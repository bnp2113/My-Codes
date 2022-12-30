#include <Adafruit_MLX90614.h>
#include <SparkFun_Bio_Sensor_Hub_Library.h>
#include <ESP8266WiFi.h>
#include <Wire.h>
#include <ESP8266HTTPClient.h>
#include <math.h>
// No other Address options.
#define DEF_ADDR 0x55
Adafruit_MLX90614 mlx = Adafruit_MLX90614();
const int GSR = A0;
int sensorValue = 0;
int gsr_average = 0;
int humanResistance = 0;

// Reset pin, MFIO pin
const int resPin = 12;
const int mfioPin = 13;

// Takes address, reset pin, and MFIO pin.
SparkFun_Bio_Sensor_Hub bioHub(resPin, mfioPin); 

bioData body;  


void setup() {
  Serial.begin(115200);

  Wire.begin();
  int result = bioHub.begin();
  if (!result)
    Serial.println("Sensor started!");
  else
    Serial.println("Could not communicate with the sensor!!!");

  Serial.println("Configuring Sensor...."); 
  int error = bioHub.configBpm(MODE_ONE); // Configuring just the BPM settings. 
  if(!error){
    Serial.println("Sensor configured.");
  }
  else {
    Serial.println("Error configuring sensor.");
    Serial.print("Error: "); 
    Serial.println(error); 
  }
  // Data lags a bit behind the sensor, if you're finger is on the sensor when
  // it's being configured this delay will give some time for the data to catch
  // up. 
  delay(4000); 

  while (!Serial);

  Serial.println("Adafruit MLX90614 test");

  if (!mlx.begin()) {
    Serial.println("Error connecting to MLX sensor. Check wiring.");
    while (1);
  };

  Serial.print("Emissivity = "); Serial.println(mlx.readEmissivity());
  Serial.println("================================================");

  WiFi.begin("Columbia University");
  Serial.print("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();
  Serial.print("Connected, IP address: ");
  Serial.print(WiFi.localIP());


}

void loop() {
      WiFiClient client;
  // Serial.print("Ambient = "); Serial.print(mlx.readAmbientTempC());
  // Serial.print("*C\tObject = "); Serial.print(mlx.readObjectTempC()); Serial.println("*C");
      /* 
      long sum=0;
      for(int i=0;i<10;i++) {//Average the 10 measurements to remove the glitch 
          
          sum += sensorValue;
          delay(5);
      }

      //humanResistance = (1024+(2*sensorValue))*10000/(512-sensorValue);
      humanResistance = (1024+(2*sum/10))*10000/(512-sum/10);
      //humanResistance = abs(humanResistance);
      //gsr_average = sum/10; 
      */

      humanResistance = analogRead(GSR);
      Serial.println(humanResistance);

      body = bioHub.readBpm();
      //Serial.print("Heartrate: ");
      int HR = body.heartRate;
      //Serial.println(HR); 
      //Serial.print("Confidence: ");
      //Serial.println(body.confidence); 
      //Serial.print("Oxygen: ");
      int BO = body.oxygen;
      //Serial.println(BO); 
      //Serial.print("Status: ");
      //Serial.println(body.status); 
      delay(250); // Slowing it down, we don't need to break our necks here.

      //Serial.print("Ambient = "); Serial.print(mlx.readAmbientTempF());
      double OT = mlx.readObjectTempF();
      //Serial.print("*F\tObject = "); Serial.print(OT+3); Serial.println("*F");
      //  Serial.print("GSR Value = "); Serial.print(analogRead(GSR));

      if (WiFi.status()==WL_CONNECTED) {
        // delay(1000);
        // Serial.println("Connecting to WiFi. . .")
        HTTPClient http;
        http.begin(client,"http://18.223.21.237:8080");
        http.addHeader("Content-Type", "text/plain");
        String data = String("")+HR+","+BO+","+OT+","+humanResistance;
        Serial.println(data);
        int httpResponseData = http.PUT(data);
        if (httpResponseData) {
          String response = http.getString();
          Serial.println(httpResponseData);
          //Serial.println(response);
        }
        http.end();
        // int httpResponseBO = http.PUT(BO);
        // int httpResponseOT = htttp.PUT(OT);
      }
      else {
        Serial.println("WIFI didn't connect.");
      }

      Serial.println();
      delay(100);
}
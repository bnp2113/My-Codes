 from flask import Flask,jsonify,request,send_file
 import json
 from datetime import datetime
 import pytz
 from bson import json_util
 from pymongo import MongoClient
 from generate import gen_gsr, gen_tp, gen_hr, gen_oxi
 client = MongoClient()
 app = Flask(__name__)
 db = client['final']
 collection = db['data']
 
 class MyJSONEncoder(json.JSONEncoder):
     def default(self, obj):
         if isinstance(obj, datetime):
             return obj.isoformat()
         if hasattr(obj, '__str__'):  # This will handle ObjectIds
             return str(obj)
 
         return super(MyJsonEncoder, self).default(obj)
 
 @app.route("/plot/<image>", methods=['GET'])
 def send_plot(image):
     print(image)
     root = '/home/ubuntu/plot/' + image
     return send_file(root, mimetype='image/png')
 
 @app.route("/data", methods=['GET'])
 def print_values():
     rawData = collection.find({}, {"_id": 0 }).sort("time", -1).limit(5)
     data = []
     gen_gsr()
     gen_tp()
     gen_hr()
     gen_oxi()
     for record in rawData:
         data.append(json.dumps(record, indent=4, cls=MyJSONEncoder))
     json_data = '[' + ', '.join(map(str, data)) + ']'
     return jsonify(json.loads(json_data)), 200
     #data = json.loads(json.dumps(collection.find({}, {"_id": 0 }).sort("time", -1).limit(5)))
     #return jsonify(data), 200
 
 @app.route("/data/day", methods=['GET'])
 def send_data_day():
     from_date = datetime(2022, 12, 9, 0, 0, 0, 0)
     to_date = datetime(2022, 12, 9, 23, 59, 59, 999999)
     rawData = collection.find({"time": {"$gte": from_date, "$lt": to_date}}, {"_id": 0})
     data = []
     for record in rawData:
         data.append(json.dumps(record, indent=4, cls=MyJSONEncoder))
     json_data = '[' + ', '.join(map(str, data)) + ']'
     return jsonify(json.loads(json_data)), 200
 
 
 @app.route("/", methods=['PUT'])
 def get_values():
     print('start')
     data = request.get_data().decode('ASCII').split(',')
     rec = {
         "time": datetime.now(pytz.utc),
         "hr": data[0],
         "oxi": data[1],
         "tp": data[2],
         "gsr": data[3]
     }
     print(rec)
     collection.insert_one(rec)
     return 'OK'
 if __name__ == '__main__':
     app.run(port=8080, host="0.0.0.0", debug = True)

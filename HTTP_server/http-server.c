/*
 * http-server.c
 */
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <netdb.h>
 
#define BUF_SIZE 4096
 
static void die(const char *msg) {
    perror(msg);
    exit(1);
}

static void printUsage() {
    fprintf(stderr, "usage: http-server <server port>" 
            "<webroot> <mdb-lookup-host> <mdb-lookup-port>\n"); 
    exit(1);
}
 
int main(int argc, char **argv) {

    if (argc != 5) {
        printUsage();
    }
    char *mdb_server;
    // parse args (only the first 2 for now)
    unsigned short port = atoi(argv[1]);
    mdb_server = argv[3];
    unsigned short mdb_port = atoi(argv[4]);
    
    //////////////////////////////////////////////
    // mdb client
    int mdb_sock;
    char *mdbIP;
    struct sockaddr_in mdbAddr;
    struct hostent *he;
    if ((he = gethostbyname(mdb_server)) == NULL) {
        die("gethostbyname failed"); }
    mdbIP = inet_ntoa(*(struct in_addr*)he->h_addr);
    
    // create socket
    if ((mdb_sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
        die("socket failed");
    
    // construct server address
    memset(&mdbAddr, 0, sizeof(mdbAddr));
    mdbAddr.sin_family = AF_INET;
    mdbAddr.sin_addr.s_addr = inet_addr(mdbIP);
    mdbAddr.sin_port = htons(mdb_port);
 
    // let's connect to mdb-lookup-server
    if (connect(mdb_sock, (struct sockaddr *)&mdbAddr, sizeof(mdbAddr)) < 0)
        die("connect to mdb-lookup-server failed");
    FILE *mdb_fd;
    mdb_fd = fdopen(mdb_sock, "r");
    /////////////////////////////////////////////////
    // Create server socket
    int servsock;
    if ((servsock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
        die("socket failed");

    // Construct local address structure
    struct sockaddr_in servaddr;
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY); // any network interface
    servaddr.sin_port = htons(port);

    // Bind to the local address
    if (bind(servsock, (struct sockaddr *) &servaddr, sizeof(servaddr)) < 0)
        die("bind failed");

    // Start listening for incoming connections
    if (listen(servsock, 5 /* queue size for connection requests */ ) < 0)
        die("listen failed");
    int clntsock;
    socklen_t clntlen;
    struct sockaddr_in clntaddr;
    char buf[BUF_SIZE];
    char requestLine[BUF_SIZE];
    const char stat_501[BUF_SIZE] =  "HTTP/1.0 501 Not Implemented\r\n\r\n"
            "<html><body>\r\n"
            "<h1>501 Not Implemented</h1>\r\n"
            "</body></html>\r\n";
    const char stat_400[BUF_SIZE] = "HTTP/1.0  400 Bad Request\r\n\r\n"
            "<html><body>\r\n"
            "<h1>400 Bad Request</h1>\r\n"
            "</body></html>\r\n";
    const char stat_404[BUF_SIZE] = "HTTP/1.0  404 Not Found\r\n\r\n"
            "<html><body>\r\n"
            "<h1>404 Not Found</h1>\r\n"
            "</body></html>\r\n";
    char header[BUF_SIZE] = "HTTP/1.0 200 OK\r\n\r\n";
    const char *form = "<html><body>\r\n<h1>mdb-lookup</h1>\r\n"
        "<p>\r\n"
        "<form method=GET action=/mdb-lookup>\r\n"
        "lookup: <input type=text name=key>\r\n"
        "<input type=submit>\r\n"
        "</form>\r\n"
        "<p>\r\n";
    while (1) {
        // Accept incoming connection
        clntlen = sizeof(clntaddr);
        if ((clntsock = accept(servsock,
                        (struct sockaddr *) &clntaddr, &clntlen)) < 0)
            die("accept failed");
        // Wrap socket with FILE* to and write
        FILE *fd = fdopen(clntsock, "r");
        if (fd  == NULL ){
            fprintf(stderr, "fdopen failed");
            break;
        }
        // Get the request line from input
        if (fgets(requestLine, sizeof(buf), fd) == NULL){
            if (ferror(fd)){
                fprintf(stderr, "IO error");
                break;
            }
        }

        // Parsing request line
        char *token_separator = "\t \r\n";
        char *method = strtok(requestLine, token_separator);
        char *requestURI = strtok(NULL, token_separator);
        char *httpVersion = strtok(NULL, token_separator);
        
        // blank request
        if (strlen(requestLine) == 2){ 
            fprintf(stderr, "%s \"%s %s %s\" 501 Not Implemented\n",
                     inet_ntoa(clntaddr.sin_addr), method, requestURI, httpVersion);
            send(clntsock, stat_501, strlen(stat_501), 0);
            fclose(fd); continue;
        }
 
        // Check method
        if  (strcmp("GET", method) != 0){
            fprintf(stderr, "%s \"%s %s %s\" 501 Not Implemented\n",
                    inet_ntoa(clntaddr.sin_addr), method, requestURI, httpVersion);
            send(clntsock, stat_501, strlen(stat_501), 0);
            fclose(fd);
            continue;
        }
         
        // Check http version
        if (strcmp("HTTP/1.0", httpVersion) != 0 && strcmp("HTTP/1.1", httpVersion) != 0){
            fprintf(stderr, "%s \"%s %s %s\" 501 Not Implemented\n",
                     inet_ntoa(clntaddr.sin_addr), method, requestURI, httpVersion);
            send(clntsock, stat_501, strlen(stat_501), 0);
            fclose(fd);
            continue;

        }
        // URI with mdb
        //char mdb_temp[BUF_SIZE];
        //snprintf(mdb_temp, sizeof(buf), "%s%s", header, form);
        if (!strncmp(requestURI, "/mdb-lookup", strlen("/mdb-lookup"))){
            char mdb_temp[BUF_SIZE];
            snprintf(mdb_temp, sizeof(buf), "%s%s", header, form);
            snprintf(buf, sizeof(buf), "%s</body></html>\r\n", mdb_temp);
            if (send(clntsock, buf, strlen(buf), 0) != strlen(buf)) {
                fclose(fd); die("send() error");}
            // if there is a keyword
            if (!strncmp(requestURI, "/mdb-lookup?key=", strlen("/mdb-lookup?key="))){
                 char *keyWIP = requestURI + strlen("/mdb-lookup?key=");
                 char key[1000] = {0}; 
                 strcpy(key, keyWIP);
                 size_t len = strlen(key);
                 fprintf(stderr, "looking up [%s]: ", key);
                 key[len] = '\n';
                 // send key to mdb-lookup-server
                 if (send(mdb_sock, key, strlen(key), 0) != strlen(key)){
                     fclose(fd); close(mdb_sock); die("send() to mdb-lookup-server failed");}
                     
                 // open FILE* on mdb_sock, while (fgets) and send bby
                 int i = 0;
                 char tab_start[50] = "<p><table border>\r\n";
                 if (send(clntsock, tab_start, strlen(tab_start), 0) != strlen(tab_start)){
                     fclose(fd); fclose(mdb_fd); continue;}
                 char line[1000];
                 char entry[1000];
                 while (fgets(line, sizeof(line), mdb_fd)){
                     if (strlen(line) == 1) break;
                     if (i % 2){ snprintf(entry, sizeof(entry), 
                                "<tr><td bgcolor=pink>%s\r\n\r\n", line);}
                     else { snprintf(entry, sizeof(entry),
                                 "<tr><td>%s\r\n\r\n", line); }
                     send(clntsock, entry, strlen(entry), 0); 
                     i++;
                 }
                 char tab_end[50] = "</table>\r\n</body></html>\r\n\r\n";
                 send(clntsock, tab_end, strlen(tab_end), 0); 
            }
            fprintf(stderr, "%s \"%s %s %s\" 200 OK\n",
                    inet_ntoa(clntaddr.sin_addr), method, requestURI, httpVersion);
            fclose(fd);
            continue;
        }
        
        ///////////////////////////////
        // Check URI
        // Bad request: a/ doesn't start with "/", b/ contain "/../", c/ end with "/.." 
        int flag = 0;
        if (strncmp(requestURI, "/", 1)) flag = 1; 
        if (strstr(requestURI, "/..") != NULL) flag = 1; 
        if (flag){
            fprintf(stderr, "%s \"%s %s %s\" 400 Bad Request\n",
                     inet_ntoa(clntaddr.sin_addr), method, requestURI, httpVersion);
            send(clntsock, stat_400, strlen(stat_400), 0);
            fclose(fd);
            continue;
        }

        // Add index.html to filepath if URI ends with /, also concat web-root and request URI
        char filepath[BUF_SIZE];
        strcpy(filepath, argv[2]); //web-root, ~/html
        strcat(filepath, requestURI); // ~html/requestURI
        struct stat statURI;
        stat(filepath, &statURI);
        if (S_ISDIR(statURI.st_mode)) { //it is a directory 
            if (requestURI[strlen(requestURI) - 1] == '/') // ends with /,  append index.htm 
                strcat(filepath, "index.html");
            else { //directory and not end with /, 501 code
            fprintf(stderr, "%s \"%s %s %s\" 501 Not Implemented\n",
                     inet_ntoa(clntaddr.sin_addr), method, requestURI, httpVersion);
            send(clntsock, stat_501, strlen(stat_501), 0);
            fclose(fd);
            continue;
            }
        }
         
        // open requested file 
        FILE *inputFile = fopen(filepath, "rb");
        if (inputFile == NULL){
            fprintf(stderr, "%s \"%s %s %s\" 404 Not Found\n",
                     inet_ntoa(clntaddr.sin_addr), method, requestURI, httpVersion);
            send(clntsock, stat_404, strlen(stat_404), 0);
            fclose(fd);
            continue;
        }
        send(clntsock, header, strlen(header), 0);
        size_t n;
        while ((n = fread(buf, 1, sizeof(buf), inputFile)) > 0){
            if (send(clntsock, buf, n, 0) != n){
                fclose(fd); fclose(inputFile); fclose(inputFile); perror("send() error"); continue; }
        }
        fclose(fd);
        fprintf(stderr, "%s \"%s %s %s\" 200 OK\n",
                   inet_ntoa(clntaddr.sin_addr), method, requestURI, httpVersion);
        if (ferror(inputFile))
            die("IO error");
        fclose(inputFile);
    }
    close(mdb_sock);
    return 0;
}

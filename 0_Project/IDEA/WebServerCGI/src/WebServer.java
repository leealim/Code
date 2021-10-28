import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.StringTokenizer;

public final class WebServer{
    public static void main(String argv[]) throws Exception
    {

        // Set the port number.
        int port = 8888;
        ServerSocket server = new ServerSocket(port);

        int count=0;
        log("服务器成功启动！");
        while (true) {
            // Listen for a TCP connection request.
            Socket socket = server.accept();
            log("接受到第 "+(++count)+" 请求。");
            // Construct an object to process the HTTP request message.
            HttpRequest request = new HttpRequest(socket,count);
            // Create a new thread to process the request.
            Thread thread = new Thread(request);
            // Start the thread.
            thread.start();
        }
    }

    private static void log(String s) {
        System.out.println(s);
    }
}

final class HttpRequest implements Runnable
{
    final static String CRLF = "\r\n";
    Socket socket;
    int index;

    // Constructor
    public HttpRequest(Socket socket,int index) throws Exception
    {
        this.socket = socket;
        this.index = index;
    }

    // Implement the run() method of the Runnable interface.
    public void run()
    {
        try {
            processRequest();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private void processRequest() throws Exception
    {
        // Get a reference to the socket's input and output streams.
        DataInputStream is = new DataInputStream(socket.getInputStream());
        DataOutputStream os = new DataOutputStream(socket.getOutputStream());

        // Set up input stream filters.
        BufferedReader br = new BufferedReader(new InputStreamReader(is));

        while(true){
//            // Get the request line of the HTTP request message.
//            String requestLine = br.readLine();
//
//            // Display the request line.
//            System.out.println();
//            System.out.println(requestLine);

            // Get and display the header lines.
            String headerLine = null;
            String fileName=null;
            while ((headerLine = br.readLine()).length() != 0) {
                StringTokenizer tokens = new StringTokenizer(headerLine);
                String method = tokens.nextToken();
                if(method.equals("GET")){
                    // Extract the filename from the request line.
                    fileName = tokens.nextToken();
                    // Prepend a "." so that file request is within the current directory.
                    fileName = "." + fileName;
                }
                System.out.println(headerLine);
            }

//            // Extract the filename from the request line.
//            StringTokenizer tokens = new StringTokenizer(requestLine);
//            tokens.nextToken();  // skip over the method, which should be "GET"
//            String fileName = tokens.nextToken();
//
//            // Prepend a "." so that file request is within the current directory.



            // Open the requested file.
            FileInputStream fis = null;
            boolean fileExists = true;
            try {
                fis = new FileInputStream(fileName);
            } catch (FileNotFoundException e) {
                fileExists = false;
            }

            // Construct the response message.
            String statusLine = null;
            String contentTypeLine = null;
            String entityBody = null;
            if (fileExists) {
                statusLine = "HTTP/1.1 200"+ CRLF;
                contentTypeLine = "Content-type: " +
                        contentType( fileName ) + CRLF;
            } else {
                statusLine = "HTTP/1.1 404"+ CRLF;
                contentTypeLine = "Content-type:"+CRLF;
                entityBody = "<HTML>" +
                        "<HEAD><TITLE>Not Found</TITLE></HEAD>" +
                        "<BODY>Not Found</BODY></HTML>";
            }

            // Send the status line.
            os.writeBytes(statusLine);

            // Send the content type line.
            os.writeBytes(contentTypeLine);

            // Send a blank line to indicate the end of the header lines.
            os.writeBytes(CRLF);

            // Send the entity body.
            if (fileExists)	{
                sendBytes(fis, os);
                fis.close();
            } else {
                os.writeBytes(entityBody);
            }
        }


        // Close streams and socket.
        os.close();
        br.close();
        socket.close();
    }

    private void sendBytes(FileInputStream fis, OutputStream os)
            throws Exception
    {
        // Construct a 1K buffer to hold bytes on their way to the socket.
        byte[] buffer = new byte[1024];
        int bytes = 0;

        // Copy requested file into the socket's output stream.
        while((bytes = fis.read(buffer)) != -1 ) {
            os.write(buffer, 0, bytes);
        }
    }
    private String contentType(String fileName)
    {
        if(fileName.endsWith(".htm") || fileName.endsWith(".html")) {
            return "text/html";
        }
//        if(?) {
//		?;
//        }
//        if(?) {
//		?;
//        }
        return "application/octet-stream";
    }
}
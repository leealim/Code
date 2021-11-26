import java.awt.desktop.SystemEventListener;
import java.io.*;
import java.net.Socket;
import java.nio.CharBuffer;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

final class HttpRequest implements Runnable {
    final static String CRLF = "\r\n";
    Socket socket;
    Tool t = new Tool();

    // Constructor
    public HttpRequest(Socket socket) throws Exception {
        this.socket = socket;
    }

    // Implement the run() method of the Runnable interface.
    public void run() {
        try {
            while (true) {
                processRequest();
                if(socket.isClosed())break;
            }
            System.out.println("yituichu");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private void processRequest() throws Exception {
        Log log=new Log();
        // Get a reference to the socket's input and output streams.
        DataInputStream is = new DataInputStream(socket.getInputStream());
        DataOutputStream os = new DataOutputStream(socket.getOutputStream());

        // Set up input stream filters.
        BufferedReader br = new BufferedReader(new InputStreamReader(is));


//            // Get the request line of the HTTP request message.
//            String requestLine = br.readLine();
//
//            // Display the request line.
//            System.out.println();
//            System.out.println(requestLine);

        // Get and display the header lines.
        String headerLine = null;
        String fileName = null;
        String toDo = null;
        String method = null;
        int contentLength = -1;
        char[] chars = null;
        while ((headerLine = br.readLine()) != null) {
            if (method != null && method.equals("POST") && (contentLength == -1) && headerLine != null && !headerLine.equals("")) {
                StringTokenizer tokens = new StringTokenizer(headerLine);
                String first = tokens.nextToken();
                if (first.equals("Content-Length:")) {
                    contentLength = Integer.parseInt(tokens.nextToken());
                    System.out.println(contentLength);
                }
            }
            if (method == null && headerLine != null && !headerLine.equals("")) {
                StringTokenizer tokens = new StringTokenizer(headerLine);
                String first = tokens.nextToken();
                if (first.equals("GET")) {
                    method = "GET";
                    // Extract the filename from the request line.
                    fileName = tokens.nextToken();
                    // Prepend a "." so that file request is within the current directory.
                    fileName = "./webroot" + fileName;
                    System.out.println(fileName);
                } else if (first.equals("POST")) {
                    method = "POST";
                    String toDot = tokens.nextToken();
                    toDo = toDot.substring(1, toDot.length());
                    System.out.println(toDo);
                } else if (first.equals("POST")) {
                    method = "HEAD";
                }
                System.out.println(method);
            }
            log.getMessage(headerLine);
            if (headerLine.equals("")) break;
            System.out.println(headerLine);
        }

        if (contentLength > 0) {
            chars = new char[contentLength];
            br.read(chars, 0, contentLength);
            System.out.println(chars);
        }
//            // Extract the filename from the request line.
//            StringTokenizer tokens = new StringTokenizer(requestLine);
//            tokens.nextToken();  // skip over the method, which should be "GET"
//            String fileName = tokens.nextToken();
//
//            // Prepend a "." so that file request is within the current directory.
        t.log(method);
        if (method == null) {

        } else if (method.equals("GET")) {
            String statusLine = null;
            // Open the requested file.
            FileInputStream fis = null;
            boolean fileExists = true;
            if (fileName.equals("./webroot/")) {
                fileName = "./webroot/index.html";
            }
            File file=new File(fileName);
            if(file.exists()){
                statusLine = "HTTP/1.1 200" + CRLF;
                log.status="200";
                fis = new FileInputStream(fileName);
            }
            else{
                statusLine = "HTTP/1.1 404" + CRLF;
                log.status="404";
                fis = new FileInputStream("./webroot/404.html");
            }

            System.out.println(fileName);
            // Construct the response message.

            String contentTypeLine = null;
            String entityBody = null;

            contentTypeLine = "Content-type: " + "text/html" + CRLF;


            // Send the status line.
            os.writeBytes(statusLine);

            // Send the content type line.
            os.writeBytes(contentTypeLine);

            // Send a blank line to indicate the end of the header lines.
            os.writeBytes(CRLF);

            // Send the entity body.
            if (fileExists) {
                sendBytes(fis, os);
                fis.close();
            } else {
                os.writeBytes(entityBody);
            }
        } else if (method.equals("POST")) {
            String entityBody=new String("");
            if (toDo == null) {

            } else if (toDo.equals("login")) {
                String s=String.valueOf(chars);
                System.out.println(s);
                String[] ss=s.split("&");
                System.out.println(ss);
                Process process = Runtime.getRuntime().exec("webroot/cgi-bin/login.exe "+ss[0].substring(ss[0].indexOf('=')+1)+" "+ss[1].substring(ss[1].indexOf('=')+1));
                BufferedReader pbr = new BufferedReader(new InputStreamReader(process.getInputStream()));
                String line = null;
                int count=0;
                while ((line = pbr.readLine()) != null) {
                    entityBody=entityBody+line;
                    System.out.println((++count)+line);
                    if (line.equals("</html>")) break;
                }
                System.out.println(line);
                System.out.println(entityBody);
                System.out.println("流结束");
            } else if (toDo.equals("calculator")) {
                String s=String.valueOf(chars);
                System.out.println(s);
                String[] ss=s.split("&");
                System.out.println(ss);
                int op=0;
                if(ss[2].substring(ss[2].indexOf('=')+1).equals("%2B")) op=0;
                else if(ss[2].substring(ss[2].indexOf('=')+1).equals("*"))op=1;
                System.out.println(op);
                Process process = Runtime.getRuntime().exec("webroot/cgi-bin/caculate.exe "+ss[0].substring(ss[0].indexOf('=')+1)+" "+ss[1].substring(ss[1].indexOf('=')+1)+" "+op);
                BufferedReader pbr = new BufferedReader(new InputStreamReader(process.getInputStream()));
                String line = null;
                int count=0;
                while ((line = pbr.readLine()) != null) {
                    entityBody=entityBody+line;
                    System.out.println((++count)+line);
                    if (line.equals("</html>")) break;
                }
                System.out.println(line);
                System.out.println(entityBody);
                System.out.println("流结束");
            } else {

            }

            // Construct the response message.
            String statusLine = null;
            String contentTypeLine = null;
            statusLine = "HTTP/1.1 200" + CRLF;
            contentTypeLine = "Content-type: " + "text/html" + CRLF;


            // Send the status line.
            os.writeBytes(statusLine);

            // Send the content type line.
            os.writeBytes(contentTypeLine);

            // Send a blank line to indicate the end of the header lines.
            os.writeBytes(CRLF);

            // Send the entity body.
            os.writeBytes(entityBody);

        } else if (method.equals("HEAD")) {

        } else {

        }

        // Close streams and socket.
        os.close();
        br.close();
        log.writeFile();
    }

    private void sendBytes(FileInputStream fis, OutputStream os) throws Exception {
        // Construct a 1K buffer to hold bytes on their way to the socket.
        byte[] buffer = new byte[1024];
        int bytes = 0;

        // Copy requested file into the socket's output stream.
        while ((bytes = fis.read(buffer)) != -1) {
            os.write(buffer, 0, bytes);
        }
    }

    private String contentType(String fileName) {
        if (fileName.endsWith(".htm") || fileName.endsWith(".html")) {
            return "text/html";
        }
        if(fileName.endsWith(".ico")) {
		    return "image/ico";
        }
//        if(?) {
//		?;
//        }
        return "application/octet-stream";
    }
}
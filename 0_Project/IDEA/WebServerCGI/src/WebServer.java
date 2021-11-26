/*
*   date: 2021-10-30
*   author: Lee
*   version: 0.1
*   description: 初步实现GET主页的请求回复
*   to do list:线程的最大限制数、处理线程持久化
 */


import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public final class WebServer{
    public static void main(String argv[]) throws Exception
    {

        // Set the port number.
        int port = 8888;
        ServerSocket server = new ServerSocket(port);
        ExecutorService executor = Executors.newFixedThreadPool(5);
        while (true) {
            // Listen for a TCP connection request.
            Socket socket = server.accept();
            // Construct an object to process the HTTP request message.
            HttpRequest request = new HttpRequest(socket);
            // Create a new thread to process the request.
            executor.submit(request);
        }
    }
}


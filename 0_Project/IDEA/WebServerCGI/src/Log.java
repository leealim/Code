import java.io.*;
import java.net.Socket;
import java.util.Date;
import java.util.StringTokenizer;

public class Log {
    final static File file=new File("webroot/log/log.txt");
    String host;
    String time;
    String request;
    String userAgent;
    String status;
    String origin;
    public Log() throws Exception {
        this.time = new Date().toString();
    }
    void getMessage(String s){
        if(s==null||s.equals(""))return;
        StringTokenizer tokens = new StringTokenizer(s);
        String first = tokens.nextToken();
        if(first.equals("Host:")){
            host=tokens.nextToken();
        }else if(first.equals("GET")){
            request= s;
        }else if(first.equals("POST")){
            request= s;
        }else if(first.equals("Origin:")){
            origin=tokens.nextToken();
        }else if(first.equals("User-Agent:")){
            userAgent=s.substring(s.indexOf(' ')+1);
        }else {

        }
    }
    void writeFile() throws IOException {
        synchronized (file) {
            if (!file.exists()) {
                file.createNewFile();
            }
            PrintStream ps = new PrintStream(new FileOutputStream(file,true));
            ps.println(host+" - - "+time+" \""+request+"\" "+status+" \""+origin+"\" \""+userAgent+"\"");
        }
    }
}

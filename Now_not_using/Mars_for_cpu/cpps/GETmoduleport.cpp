/*
    Discription：每行获得start与end之间的字符串，按规定格式打印
*/
#include <iostream>
#include <fstream>
#include <string>
using namespace std;
int main(){
    string temp;
    ifstream in("D:\\Documents\\CodeFiles\\Mars_for_cpu\\module_interface.txt");
    ofstream out("D:\\Documents\\CodeFiles\\Mars_for_cpu\\module_port.txt");
    int count=0;
    char start=']',end=' ';

    while(getline(in,temp)){
        if(string::npos==temp.find(start)) continue;
        string ttemp=temp.substr(temp.find(start));
        string tttemp=ttemp.substr(1,ttemp.find(end)-1);
        if(tttemp[0]=='(') continue;
        out<<"    "<<tttemp<<"=4‘d0;"<<endl;
    }
    
    system("pause");
}

/* GETmoduleport */
// #include <iostream>
// #include <fstream>
// #include <string>
// using namespace std;
// int main(){
//     string temp;
//     ifstream in("D:\\Documents\\CodeFiles\\Mars_for_cpu\\module_interface.txt");
//     ofstream out("D:\\Documents\\CodeFiles\\Mars_for_cpu\\module_port.txt");
//     while(getline(in,temp)){
//         if(string::npos==temp.find('.')) continue;
//         string ttemp=temp.substr(temp.find('.'));
//         string tttemp=ttemp.substr(1,ttemp.find(' ')+1);
//         if(tttemp[0]=='I'){
//             out<<"    input "<<tttemp<<","<<endl;
//         }
//         else{
//             out<<"    output "<<tttemp<<","<<endl;
//         }
//     }
    
//     system("pause");
// }
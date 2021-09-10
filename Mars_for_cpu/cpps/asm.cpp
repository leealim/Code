/*
    Discription：将32位一行二进制转换成小端序的8位一行二进制码
*/


#include <iostream>
#include <fstream>
using namespace std;
int main(int argc, char **argv){
    
    // // if(argc!=3)
    // // {
    // //     system("chcp 65001");
    // //     printf("Usage:asm inputfilelocation outputfilelocation\n");
    // //     printf("\n");
    // //     printf("用于转换机器码为8个数字一行，如：\n");
    // //     printf("before:     00000000000000000000000000000000\n");
    // //     printf("after:      00000000\n");
    // //     printf("            00000000\n");
    // //     printf("            00000000\n");
    // //     printf("            00000000\n");
    // //     system("pause");
    // //     return 0;
    // // }
    
    // char temp[4][255];
    // ifstream in(argv[1]);
    // ofstream out(argv[2]);
    char temp[4][255];
    ifstream in("D:\\Documents\\CodeFiles\\Mars_for_cpu\\machinecode.txt");
    ofstream out("D:\\Documents\\CodeFiles\\Mars_for_cpu\\machinecodevschandled.txt");
    int count=0;
    while(in.read(temp[count%4],8)){
        temp[count % 4][8]='\0';
        count++;
        if(count%4==0){
            out<<temp[3]<<endl;
            out<<temp[2]<<endl;
            out<<temp[1]<<endl;
            out<<temp[0]<<endl;
            in.read(temp[count % 4],1);
        }
    }
    system("pause");
}
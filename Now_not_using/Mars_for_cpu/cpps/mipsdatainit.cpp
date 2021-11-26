#include <iostream>
#include <fstream>
using namespace std;
int main(){
    ofstream out("D:\\Documents\\CodeFiles\\Mars\\mipsdata.txt");
    for(int i=0;i<256;i++){
        out<<"00000000"<<endl;
    }
    system("pause");
}
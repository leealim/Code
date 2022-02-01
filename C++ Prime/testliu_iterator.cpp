#include <iostream>
#include <vector>
#include <string>
#include <iterator>
#include <algorithm>
using namespace std;
int main(){
    istream_iterator<int> myII(cin),myeof;
    vector<int> vec(myII,myeof);
    for_each(vec.begin(),vec.end(),[](int i){cout<<i<<endl;});
    system("pause");
}
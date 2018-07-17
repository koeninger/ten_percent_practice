#include <iostream>

using namespace std;

int main() {

	// g++ -std=c++11 -O2 -Wall test.cpp -o test
	cout<<"Hello World"<<endl;

	int a, b;
	string x;
	cin >> a >> b >> x; // 123 456 food

	cout << a << " " << b << " " << x << "\n";

	double y = 0.3*3+0.1;
	printf("%.20f\n", y);
	return 0;
}
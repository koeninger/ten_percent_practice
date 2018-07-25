#include <iostream>

using namespace std;

int main() {
	
	long long x = 1;
	int m = 5;
	int n = 5;

	for (int i = 2; i <= n; i++) {
		x = (x*i)%m;
	}
	cout << x%m << "\n";
	
	x = x%m;
	if (x < 0) x += m;

	printf("%.20lld, %.20d\n", x, m);


	return 0;
}

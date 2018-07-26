#include <iostream>

using namespace std;

int main() {

	// Macros
	#define SQ(a) a*a
	#define SQU(a) (a)*(a)
	#define REP(i,a,b) for (int i = a; i <= b; i++)	

	// Type names
	typedef long long ll;

	// sans type names
	long long a = 123456781;
	long long b = 234567892;
	cout << a*b << "\n";

	// with type names
	ll c = 123456781;
	ll d = 234567892;
	cout << c*d << "\n";

	// sans macros
	int n = 10;
	for (int i = 1; i <= n; i++) {
		printf("%.2d\n", i);
	}

	// with macros
	REP(i,1,n) {
		printf("%.2d\n", i);
	}
	cout << SQ(3+3) << "\n"; // 15 -> bad macro causes unexpected error
	cout << SQU(3+3) << "\n"; // 36 ->  correct

	return 0;
}
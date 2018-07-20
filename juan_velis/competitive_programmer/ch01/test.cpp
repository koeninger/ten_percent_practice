#include <iostream>

using namespace std;

int main() {

	ios::sync_with_stdio(0);
	cin.tie(0);

	cout<<"Hello World"<<endl;

	int a, b, c, d;
	string s, x, e;
	cin >> a >> b >> x; // 123 456 food

	cout << a << " " << b << " " << x << "\n";

	scanf("%d %d", &c, &d);
	printf("%d %d\n", c, d);

	double y = 0.3*3+0.1;
	printf("%.20f\n", y);

	freopen("input.txt", "r", stdin); // redirects standard input
	freopen("output2.txt", "w", stdout); // redirects standard output

	// Get each line from input.txt and write it to output2.txt
	while (cin >> x) {
		getline(cin, e); // r
		cout << e << endl; // w
	}

	return 0;
}
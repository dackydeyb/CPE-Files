// Activity #1
// September 18, 2024

#include <iostream>
using namespace std;

int main () {
	
	int first_Num;
	int sec_Num;
	
	cout << "--- Basic Calculator ---\n";
	
	// Input
	cout << "Enter the 1st number: ";
	cin >> first_Num;
	
	cout << "Enter the 2nd number: ";
	cin >> sec_Num;
	
	// Process & Output
	cout << "\nHere is the computed answers: \n";
	cout << " Sum: " << first_Num + sec_Num << "\n";
	cout << " Difference: " << first_Num - sec_Num << "\n";
	cout << " Product: " << first_Num * sec_Num << "\n";
	cout << " Quotient: " << first_Num/sec_Num;
	
	return 0;
}


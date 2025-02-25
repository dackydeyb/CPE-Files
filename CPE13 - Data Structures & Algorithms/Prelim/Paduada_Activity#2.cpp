// Activity #2
// September 20, 2024

#include <iostream>
#include <string>
#include <sstream>

using namespace std;

int main () {
	
	// Input
	stringstream row;
	
	int sixT = 16;
	int sevenT = 17;
	int eightT = 18;
	int nineT = 19;
	int twT = 20;
	int twOne = 21;
	int twTwo = 22;
	int twThree = 23;
	int twFour = 24;
	int twFive = 25;
	
	// Process
	row << sixT 			<< "  |  " << sevenT 				<< " | " <<	eightT				<< "  | " << nineT			<< "  | " << twT				<< "  |  " << twOne			<< " |  " << twTwo			<< " |  " << twThree				<< " |  " << twFour				<< " | " << twFive << "\n";
	row << sixT * sixT 		<< " | " << sixT * sevenT 		<< " | " << sixT * eightT 		<< " | " << sixT * nineT 	<< " | " << sixT * twT 		<< " | " << sixT * twOne 	<< " | " << sixT * twTwo 	<< " | " << sixT * twThree 		<< " | " << sixT * twFour 		<< " | " << sixT * twFive << "\n";
    row << sevenT * sixT 	<< " | " << sevenT * sevenT 	<< " | " << sevenT * eightT 	<< " | " << sevenT * nineT 	<< " | " << sevenT * twT 	<< " | " << sevenT * twOne 	<< " | " << sevenT * twTwo 	<< " | " << sevenT * twThree 	<< " | " << sevenT * twFour 	<< " | " << sevenT * twFive << "\n";
    row << eightT * sixT 	<< " | " << eightT * sevenT 	<< " | " << eightT * eightT 	<< " | " << eightT * nineT 	<< " | " << eightT * twT 	<< " | " << eightT * twOne 	<< " | " << eightT * twTwo 	<< " | " << eightT * twThree 	<< " | " << eightT * twFour 	<< " | " << eightT * twFive << "\n";
    row << nineT * sixT 	<< " | " << nineT * sevenT 		<< " | " << nineT * eightT 		<< " | " << nineT * nineT 	<< " | " << nineT * twT 	<< " | " << nineT * twOne 	<< " | " << nineT * twTwo 	<< " | " << nineT * twThree 	<< " | " << nineT * twFour 		<< " | " << nineT * twFive << "\n";
    row << twT * sixT 		<< " | " << twT * sevenT 		<< " | " << twT * eightT 		<< " | " << twT * nineT 	<< " | " << twT * twT 		<< " | " << twT * twOne 	<< " | " << twT * twTwo 	<< " | " << twT * twThree 		<< " | " << twT * twFour 		<< " | " << twT * twFive << "\n";
    row << twOne * sixT 	<< " | " << twOne * sevenT 		<< " | " << twOne * eightT 		<< " | " << twOne * nineT 	<< " | " << twOne * twT 	<< " | " << twOne * twOne 	<< " | " << twOne * twTwo 	<< " | " << twOne * twThree 	<< " | " << twOne * twFour 		<< " | " << twOne * twFive << "\n";
    row << twTwo * sixT 	<< " | " << twTwo * sevenT 		<< " | " << twTwo * eightT 		<< " | " << twTwo * nineT 	<< " | " << twTwo * twT 	<< " | " << twTwo * twOne 	<< " | " << twTwo * twTwo 	<< " | " << twTwo * twThree 	<< " | " << twTwo * twFour 		<< " | " << twTwo * twFive << "\n";
    row << twThree * sixT 	<< " | " << twThree * sevenT 	<< " | " << twThree * eightT 	<< " | " << twThree * nineT << " | " << twThree * twT 	<< " | " << twThree * twOne << " | " << twThree * twTwo << " | " << twThree * twThree 	<< " | " << twThree * twFour 	<< " | " << twThree * twFive << "\n";
    row << twFour * sixT 	<< " | " << twFour * sevenT 	<< " | " << twFour * eightT 	<< " | " << twFour * nineT 	<< " | " << twFour * twT 	<< " | " << twFour * twOne 	<< " | " << twFour * twTwo 	<< " | " << twFour * twThree 	<< " | " << twFour * twFour 	<< " | " << twFour * twFive << "\n";
    row << twFive * sixT 	<< " | " << twFive * sevenT 	<< " | " << twFive * eightT 	<< " | " << twFive * nineT 	<< " | " << twFive * twT 	<< " | " << twFive * twOne 	<< " | " << twFive * twTwo 	<< " | " << twFive * twThree 	<< " | " << twFive * twFour 	<< " | " << twFive * twFive << "\n";
    string multiplication_Table = row.str(); 
    
    // Output
	cout << "    --- Multiplication Table for 16 to 25 ---\n\n";
	cout << multiplication_Table;
	
	return 0;
}


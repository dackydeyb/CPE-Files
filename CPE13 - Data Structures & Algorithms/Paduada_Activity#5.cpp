// Octber 9 
// Activity 5: Array and Multi-Dimensional Array
/*
Problem A:
Create a program that asks the user the number of row and column of a 2-dimensioal array, put values in the array, prints the content of the array, and determines the largest number of the array. (You must input 4x4 and the numbers are 3-digit integers).
*/

// Problem B:
// Problem: Create a program that asks the user the number of row and column of a 2-dimentional arary, put values in the array, prints the content of the array, and determines the sum of all elements. (You must input 5x3 and the numbers are 3-digit integers) Use in C++, no comment and explanation just pure code, also you must use function call 1 for accepting input and outputing the content of the array
// Objective: To use C++ programming language to create a program of array. To use utilize COntrol Statement in creation of array. TO analyze different problem requirements efficiently using array and multi-dimensional array. Here in the objectives write a conclusion about it that will match to the objectives 
#include <iostream>
using namespace std;

int inputAndOutputArray(int arr[][500], int rows, int columns) {
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < columns; ++j) {
            cout << "Enter element " << i + 1 << ", " << j + 1 << ": ";
            cin >> arr[i][j];
        }
    }

    // Displaying the inputted arrays
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < columns; ++j) {
            if (arr[i][j] >= 100) {
                cout << arr[i][j] << " "; 
            } else if (arr[i][j] >= 10) {
                cout << " " << arr[i][j] << " "; 
            } else {
                cout << "  " << arr[i][j] << " "; 
            }
        }
        cout << endl;
    }

    int sum = 0;
    for (int i = 0; i < rows; ++i) {
		for (int j = 0; j < columns; ++j) {
            sum += arr[i][j];
        }
    }

    return sum;
}

int main() {
    int rows, columns;
    cout << "Enter the number of rows: ";
    cin >> rows;
    cout << "Enter the number of columns: ";
    cin >> columns;
    
    int arr[500][500];  
    int sum = inputAndOutputArray(arr, rows, columns);
    cout << "The sum of all elements in the array is: " << sum << endl;
    return 0;
}




// October 30, 2024
// Search Algorithm

/* Problem: Create a program that has a fixed 4x4 rows and columns and has already or fixed 3 digit values, 
the values of it should be unique the user the number of row and column of a 2 - dimensional array, initialize 
values in the array, prints the content of the array, and search for an inputted number using linear or sequential search.
*/
// Objectives:
/*
	To use C++ programming language to create a program of array and search algorithm.
	To utilize Control Statement in creation and searching of elements in array.
	To analyze different problem requirements efficiently using search algorithms
*/
#include <iostream>
using namespace std;

int main() {
    // fixed 4x4 matrix w/ unique 3-digit values
    int matrix[4][4] = {
        {889, 644, 198, 344},
        {940, 329, 525, 701},
        {777, 435, 542, 796},
        {628, 261, 445, 840}
    };

    // Display matrix content
    cout << "--- 4x4 Matrix Finder ---\n";
    for (int row = 0; row < 4; row++) {
        for (int col = 0; col < 4; col++) {
            cout << matrix[row][col] << " ";
        }
        cout << endl;
    }

    int searchValue;
    bool found = false;

    // Search for a number in the matrix
    while (!found) {
        cout << "\nEnter a 3-digit number to search for: ";
        cin >> searchValue;

        // Linear search
        for (int row = 0; row < 4; row++) {
            for (int col = 0; col < 4; col++) {
                if (matrix[row][col] == searchValue) {
                    cout << "Number " << searchValue << " found at index (" << row << ", " << col << ").\n";
                    found = true;
                    break;
                }
            }
            if (found) break;
        }

        // If not found, prompt the user to try again
        if (!found) {
            cout << "Number not found. Try again.\n";
        }
    }

    return 0;
}

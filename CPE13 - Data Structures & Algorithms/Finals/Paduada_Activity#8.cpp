// Activity 8: Other operations

/*
	Problem: Create a program that prints a declared 4x3 bidimensional array and a meny for inserting, deleting, and copying of array.
	Ask the user for the operation, perform the intended operation, and prints the result. (you need to copy the whole array to another array. 
	*/
#include <iostream>
using namespace std;

const int ROWS = 4;
const int COLS = 3;
const int MAX_SIZE = ROWS * COLS; // 12
const int MAX_ARRAYS = 10;        // Can store up to 10 arrays

// Function to print a single array in a 4x3 forma
void print2DArray(const int array[], int current_size, int arrayNumber) {
    cout << "Array " << arrayNumber << " (Active Elements = " << current_size << "):" << endl;
    for (int i = 0; i < ROWS; i++) {
        for (int j = 0; j < COLS; j++) {
            int index = i * COLS + j;
            if (index < current_size) {
                cout << array[index] << " ";
            } else {
                cout << "- ";
            }
        }
        cout << endl;
    }
    cout << endl;
}

int main() {
    static int arrays[MAX_ARRAYS][MAX_SIZE];
    static int array_sizes[MAX_ARRAYS];

    int array_count = 1;
    int currentArrayIndex = 0; // Start with Array 1 as the active array

    // Initialize Array 1 with two-digit integers: 55 to 66
    for (int i = 0; i < MAX_SIZE; i++) {
        arrays[0][i] = 55 + i;
    }
    array_sizes[0] = MAX_SIZE; // Fully occupied

    cout << "Original Array (Array 1):" << endl;
    print2DArray(arrays[0], array_sizes[0], 1);

    bool exitProgram = false;
    while (!exitProgram) {
        cout << "=== MENU ===" << endl;
        cout << "1. Insert an element" << endl;
        cout << "2. Delete an element" << endl;
        cout << "3. Copy the array" << endl;
        cout << "4. Exit" << endl;

        cout << "\n\nCurrently operating on Array " << (currentArrayIndex + 1) << endl;

        int choice;
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
            case 1: {
                // INSERT into the current active array
                if (array_sizes[currentArrayIndex] == MAX_SIZE) {
                    cout << "\n--Current array is full. Cannot insert a new element.--" << endl;
                } else {
                    int r, c, num;
                    cout << "Enter the value to insert (two-digit integer): ";
                    cin >> num;

                    cout << "Enter the row (0 to " << ROWS - 1 << "): ";
                    cin >> r;
                    cout << "Enter the column (0 to " << COLS - 1 << "): ";
                    cin >> c;

                    if (r < 0 || r >= ROWS || c < 0 || c >= COLS) {
                        cout << "\n--Invalid row or column!--" << endl;
                        break;
                    }

                    int pos = r * COLS + c;

                    if (pos < 0 || pos > array_sizes[currentArrayIndex]) {
                        cout << "\n--Invalid position!--" << endl;
                        break;
                    }

                    // Shift right
                    for (int i = array_sizes[currentArrayIndex] - 1; i >= pos; i--) {
                        arrays[currentArrayIndex][i + 1] = arrays[currentArrayIndex][i];
                    }

                    arrays[currentArrayIndex][pos] = num;
                    array_sizes[currentArrayIndex]++;

                    cout << "\n--Value inserted into Array " << (currentArrayIndex + 1) << ".--" << endl;
                }
                break;
            }
            case 2: {
                // DELETE from the current active array
                if (array_sizes[currentArrayIndex] == 0) {
                    cout << "\n--Current array is empty. Cannot delete an element.--" << endl;
                } else {
                    int r, c;
                    cout << "Enter the row (0 to " << ROWS - 1 << "): ";
                    cin >> r;
                    cout << "Enter the column (0 to " << COLS - 1 << "): ";
                    cin >> c;

                    if (r < 0 || r >= ROWS || c < 0 || c >= COLS) {
                        cout << "\n--Invalid row or column!--" << endl;
                        break;
                    }

                    int pos = r * COLS + c;
                    if (pos < 0 || pos >= array_sizes[currentArrayIndex]) {
                        cout << "\n--No element at that position to delete!--" << endl;
                        break;
                    }

                    // Shift left
                    for (int i = pos; i < array_sizes[currentArrayIndex] - 1; i++) {
                        arrays[currentArrayIndex][i] = arrays[currentArrayIndex][i + 1];
                    }
                    array_sizes[currentArrayIndex]--;

                    cout << "\n--Value deleted from Array " << (currentArrayIndex + 1) << ".--" << endl;
                }
                break;
            }
            case 3: {
                if (array_count == MAX_ARRAYS) {
                    cout << "-- Maximum array limit reached. Cannot create more arrays. --" << endl;
                } else {
                    int sourceIndex = array_count - 1; // last created array index
                    int newIndex = array_count;        // new array index

                    int srcSize = array_sizes[sourceIndex];
                    // Copy elements
                    for (int i = 0; i < srcSize; i++) {
                        arrays[newIndex][i] = arrays[sourceIndex][i];
                    }
                    array_sizes[newIndex] = srcSize;

                    array_count++;
                    currentArrayIndex = newIndex; // Switch active array to the newly created one

                    cout << "Array " << (sourceIndex + 1) << " copied successfully to Array " << array_count 
                         << ". Now operating on Array " << (currentArrayIndex + 1) << "." << endl;
                }
                break;
            }
            case 4:
                // EXIT
                exitProgram = true;
                cout << "Exiting the program." << endl;
                break;
            default:
                cout << "Invalid choice! Please try again." << endl;
        }

        // After each operation (except exit), print all arrays
        if (!exitProgram) {
            cout << "\n--- CURRENT ARRAYS ---" << endl;
            for (int i = 0; i < array_count; i++) {
                print2DArray(arrays[i], array_sizes[i], i + 1);
            }
        }
    }

    return 0;
}

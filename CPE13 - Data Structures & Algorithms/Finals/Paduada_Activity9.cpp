// December 11, 2024
// Activity 9: Lists, Stacks and Queues, array implementation

/*
	Problem: Create a program that have an array of 4x4 bidimensional elemets that can perform insertion (push and enqueue) and deletion (pop and (dequeue).
	You must ask the user which operation to use and print the array every after selected operation. There should be a terminate option if the user wishes to end
	the program.
*/

#include <iostream>
using namespace std;

// Function to print the 4x4 array
void printArray(int arr[], int rows, int cols) {
    cout << "Current array state:" << endl;
    for(int i = 0; i < rows; i++) {
        for(int j = 0; j < cols; j++) {
            if(arr[i * cols + j] == -1)
                cout << "-" << "\t";
            else
                cout << arr[i * cols + j] << "\t";
        }
        cout << endl;
    }
}

int main(){
    const int ROWS = 4;
    const int COLS = 4;
    const int SIZE = ROWS * COLS;
    int arr[SIZE];
    
    // Initialize array with user input
    cout << "Enter 16 numerical elements to initialize the 4x4 array:" << endl;
    for(int i = 0; i < SIZE; i++){
        cout << "Element " << i + 1 << ": ";
        cin >> arr[i];
    }
    
    // Print initial array
    cout << "\nInitial array:" << endl;
    printArray(arr, ROWS, COLS);
    
    while(true){
        // Display menu
        cout << "\nSelect an operation:" << endl;
        cout << "1. Push" << endl;
        cout << "2. Pop" << endl;
        cout << "3. Enqueue" << endl;
        cout << "4. Dequeue" << endl;
        cout << "5. Exit" << endl;
        cout << "Enter your choice (1-5): ";
        int choice;
        cin >> choice;
        
        if(choice == 1){ // Push
            // Check if array is full (no -1 present)
            bool full = true;
            for(int i = 0; i < SIZE; i++) {
                if(arr[i] == -1){
                    full = false;
                    break;
                }
            }
            if(full){
                cout << "Error: Array is full. Cannot perform push operation." << endl;
                // Print the current array state
                printArray(arr, ROWS, COLS);
            }
            else{
                // Shift elements to the right to make space at front
                for(int i = SIZE - 1; i > 0; i--){
                    arr[i] = arr[i - 1];
                }
                // Insert new element at front
                int elem;
                cout << "Enter number to push: ";
                cin >> elem;
                arr[0] = elem;
                cout << "\nArray after push:" << endl;
                printArray(arr, ROWS, COLS);
            }
        }
        else if(choice == 2){ // Pop
            // Check if array is empty (all -1)
            bool empty = true;
            for(int i = 0; i < SIZE; i++) {
                if(arr[i] != -1){
                    empty = false;
                    break;
                }
            }
            if(empty){
                cout << "Error: Array is empty. Cannot perform pop operation." << endl;
                // Print the current array state
                printArray(arr, ROWS, COLS);
            }
            else{
                // Remove first element and shift left
                for(int i = 0; i < SIZE - 1; i++){
                    arr[i] = arr[i + 1];
                }
                // Set last element to -1
                arr[SIZE - 1] = -1;
                cout << "\nArray after pop:" << endl;
                printArray(arr, ROWS, COLS);
            }
        }
        else if(choice == 3){ // Enqueue
            // Check if array is full (no -1 present)
            bool full = true;
            for(int i = 0; i < SIZE; i++) {
                if(arr[i] == -1){
                    full = false;
                    break;
                }
            }
            if(full){
                cout << "Error: Array is full. Cannot perform enqueue operation." << endl;
                // Print the current array state
                printArray(arr, ROWS, COLS);
            }
            else{
                // Shift elements to the right to make space at front
                for(int i = SIZE - 1; i > 0; i--){
                    arr[i] = arr[i - 1];
                }
                // Insert new element at front
                int elem;
                cout << "Enter number to enqueue: ";
                cin >> elem;
                arr[0] = elem;
                cout << "\nArray after enqueue:" << endl;
                printArray(arr, ROWS, COLS);
            }
        }
        else if(choice == 4){ // Dequeue
            // Check if array is empty (all -1)
            bool empty = true;
            for(int i = 0; i < SIZE; i++) {
                if(arr[i] != -1){
                    empty = false;
                    break;
                }
            }
            if(empty){
                cout << "Error: Array is empty. Cannot perform dequeue operation." << endl;
                // Print the current array state
                printArray(arr, ROWS, COLS);
            }
            else{
                // Remove last element by setting it to -1
                int pos = -1;
                for(int i = SIZE - 1; i >=0; i--){
                    if(arr[i] != -1){
                        pos = i;
                        break;
                    }
                }
                if(pos != -1){
                    arr[pos] = -1;
                    cout << "\nArray after dequeue:" << endl;
                    printArray(arr, ROWS, COLS);
                }
            }
        }
        else if(choice == 5){
            cout << "Exiting the program. Goodbye!" << endl;
            break;
        }
        else{
            cout << "Invalid choice. Please select a valid operation (1-5)." << endl;
        }
    }
    
    return 0;
}


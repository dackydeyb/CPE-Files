// November 6, 2024

/* Objectives: 
	1. To use C++ Programming Language to create a program of array and sorting algorithm
	2. To utilize Control Statement in creation and sorting of elements in array.
	3. To analyze different problem requirements efficiently using sorting algorithms (Selection, Bubble, and Insertion Sort
		
*/

#include <iostream>
using namespace std;

// Function to perform Selection Sort
void selectionSort(int array[], int size) {
    // Loop to iterate through each element except the last
    for (int i = 0; i < size - 1; i++) {
        int minIndex = i; // Assume the current index is the minimum
        for (int j = i + 1; j < size; j++) {
            if (array[j] < array[minIndex]) { // Find the minimum element
                minIndex = j; // Update the minimum index
            }
        }
        // Swap the found minimum element with the first element
        if (minIndex != i) {
            int temp = array[i];
            array[i] = array[minIndex];
            array[minIndex] = temp;
        }
    }
}

// Function to perform Bubble Sort
void bubbleSort(int array[], int size) {
    // Loop to control the number of passes
    for (int i = 0; i < size - 1; i++) {
        // Loop to compare adjacent elements
        for (int j = 0; j < size - i - 1; j++) {
            if (array[j] > array[j + 1]) { // Swap if elements are out of order
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}

// Function to perform Insertion Sort
void insertionSort(int array[], int size) {
    // Loop through each element starting from the second
    for (int i = 1; i < size; i++) {
        int currentElement = array[i];
        int j = i - 1;
        // Move elements that are greater than currentElement one position ahead
        while (j >= 0 && array[j] > currentElement) {
            array[j + 1] = array[j];
            j--;
        }
        array[j + 1] = currentElement; // Place currentElement in the correct position
    }
}

int main() {
    int arraySize;
    int array[50]; // Array to store up to 50 elements

    // Input section
    cout << "Enter the size of the array (max 50): ";
    cin >> arraySize;

    // Ensure the size is within the valid range
    if (arraySize > 50 || arraySize <= 0) {
        cout << "Invalid size! Please enter a size between 1 and 50." << endl;
        return 1;
    }

    cout << "Enter " << arraySize << " elements: \n";
    for (int i = 0; i < arraySize; i++) {
        cin >> array[i]; // Read each element
    }

    // Perform Selection Sort and display the sorted array
    int selectionSortedArray[50];
    copy(array, array + arraySize, selectionSortedArray);
    selectionSort(selectionSortedArray, arraySize);
    
    cout << "\nArray sorted using Selection Sort: \n";
    
    for (int i = 0; i < arraySize; i++) {
        cout << selectionSortedArray[i] << " ";
    }
    cout << endl;

    // Perform Bubble Sort and display the sorted array
    int bubbleSortedArray[50];
    copy(array, array + arraySize, bubbleSortedArray);
    bubbleSort(bubbleSortedArray, arraySize);
    
    cout << "\nArray sorted using Bubble Sort: \n";
    
    for (int i = 0; i < arraySize; i++) {
        cout << bubbleSortedArray[i] << " ";
    }
    cout << endl;

    // Perform Insertion Sort and display the sorted array
    int insertionSortedArray[50];
    copy(array, array + arraySize, insertionSortedArray);
    insertionSort(insertionSortedArray, arraySize);
    
    cout << "\nArray sorted using Insertion Sort: \n";
    
    for (int i = 0; i < arraySize; i++) {
        cout << insertionSortedArray[i] << " ";
    }
    cout << endl;

    return 0;
}


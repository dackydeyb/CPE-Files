#include <iostream>
using namespace std;

int main() {
    int n;
    cout << "Enter the size of the square (minimum 7): ";
    cin >> n;

    if (n < 7) {
        cout << "Please enter a number greater than or equal to 7." << endl;
        return 1;
    }

    int matrix[n][n];

    // Fill the matrix with numbers in descending order
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            matrix[i][j] = (n - i) * (n - j);
        }
    }

    // Print the matrix
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            cout << matrix[i][j] << "\t";
        }
        cout << endl;
    }

    return 0;
}

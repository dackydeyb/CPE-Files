/* Activity #4: Pointers, Reference, and Dynamic Memory Allocation

October 4, 2024

Objective: To use C++ programming language to create a program of pointers, references, and dynamic memory allocation.
To utilize pointers and reference interchangeably.
To analyze different problem requirements in creating program using const function

Problem: Create a program that accepts input for computing the area and circumference 
of circle and ellipse. Use const function for pi(3.14) and use either radius of circle to 
ellipse and vice versa. Also the output of the program ellipse assume that A is equals to the 
radius and B is equals to 2A. Use also CMATH library
*/ 


#include <iostream>
#include <cmath> // Include cmath for math functions

using namespace std;

const double pi = 3.14; // Constant value of π

// Function to calculate the area and circumference of a circle
void circleProperties(double radius) {
    double area = pi * pow(radius, 2);
    double perimeter = 2 * pi * radius;
    cout << "Area of the Circle: " << area << endl;
    cout << "Perimeter (Circumference) of the Circle: " << perimeter << endl;
}

// Function to calculate the area and circumference of an ellipse
void ellipseProperties(double majorAxis, double minorAxis) {
    if (majorAxis <= 0 || minorAxis <= 0) {
        cout << "Invalid input for ellipse axes." << endl;
        return;
    }
    double area = pi * majorAxis * minorAxis;
    double perimeter = pi * (3 * (majorAxis + minorAxis) - sqrt((3 * majorAxis + minorAxis) * (majorAxis + 3 * minorAxis)));
    cout << "Area of the Ellipse: " << area << endl;
    cout << "Perimeter (Circumference) of the Ellipse: " << perimeter << endl;
}

int main() {
    int choice;
    double radius, majorAxis, minorAxis;

    cout << "Choose type of shape:" << endl;
    cout << "1. Circle" << endl;
    cout << "2. Ellipse" << endl;
    cin >> choice;

    if (choice == 1) {
        cout << "Enter the radius of the circle: ";
        cin >> radius;
        circleProperties(radius);
    } else if (choice == 2) {
        cout << "Enter the major axis of the ellipse: ";
        cin >> majorAxis;
        minorAxis = majorAxis / 2.0; // Assuming minor axis is half of the major axis for this example
        ellipseProperties(majorAxis, minorAxis);
    } else {
        cout << "Invalid choice." << endl;
    }

    return 0;
}



#include <iostream>
using namespace std;

int main() {
    int total_seconds;
    cout << "Input time in seconds: ";
    cin >> total_seconds;

    // Calculate days, hours, minutes, and seconds
    int days = total_seconds / (24 * 3600); // 1 day = 24 * 3600 seconds
    total_seconds %= (24 * 3600);           // remaining seconds after calculating days

    int hours = total_seconds / 3600;       // 1 hour = 3600 seconds
    total_seconds %= 3600;                  // remaining seconds after calculating hours

    int minutes = total_seconds / 60;       // 1 minute = 60 seconds
    int seconds = total_seconds % 60;       // remaining seconds after calculating minutes

    // Output the result in DD:HH:MM:SS format
    cout << "The equivalent time format is: "
         << days << ":" 
         << (hours < 10 ? "0" : "") << hours << ":" // add leading zero if needed
         << (minutes < 10 ? "0" : "") << minutes << ":"
         << (seconds < 10 ? "0" : "") << seconds << endl;

    return 0;
}


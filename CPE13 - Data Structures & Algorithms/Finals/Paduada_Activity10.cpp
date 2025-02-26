#include <iostream>
using namespace std;

void banner() {
    cout << R"(
+-----------------------------------------+
| _____ ____   ____   ____                |
|| ____|  _ \ / ___| |  _ \ ___ _ __  ___ |
||  _| | | | | |     | |_) / _ \ '_ \/ __||
|| |___| |_| | |___  |  __/  __/ | | \__ \|
||_____|____/ \____| |_|   \___|_| |_|___/|
+-----------------------------------------+
)";
}

void displayMenu(string vendingMachine[4][4], int prices[4][4], int quantities[4][4]) {
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            if (quantities[i][j] > 0) {
                cout << "[" << i + 1 << "," << j + 1 << "] [PHP" << prices[i][j] << "] " << vendingMachine[i][j]
                     << " (" << quantities[i][j] << "x) \t";
            } else {
                cout << "[" << i + 1 << "," << j + 1 << "] -       \t\t\t\t";
            }
        }
        cout << endl;
    }
    cout << "----------------------------\n";
}

int main() {
    banner();
    string vendingMachine[4][4] = {
        {"Parker Jotter", "P. Metropolitan", "Lamy Safari", "P. Vanishing Point"},
        {"Kaweco Art Sport", "Sailor Pro", "Lamy LX Safari", "Kaweco Classic"},
        {"Pilot E95S", "Aurora Ipsilon", "Lamy Dialog CC", "Platinum 3776"},
        {"Parker Sonnet", "Pelikan M800", "Platinum Peppy", "Pelikan M200"}
	};
        
    int prices[4][4] = {
        {1500, 1200, 1600, 9900},
        {5900, 17560, 1799, 1499},
        {8960, 7560, 30240, 24199},
        {1200, 48000, 550, 14995}
	};
        
    int quantities[4][4] = {
        {3, 1, 3, 4},
        {9, 5, 5, 7},
        {5, 1, 6, 8},
        {3, 1, 5, 2}
	};
    
    int insertedAmount = 0, totalAmount = 0;
    int purchaseCount[4][4] = {0};
    char proceed;

    do {
        displayMenu(vendingMachine, prices, quantities);
        
        cout << "Press any key to continue: ";
    	cin >> proceed;

        // Insert payment
        cout << "Enter your payment (PHP): ";
        cin >> insertedAmount;

        if (insertedAmount <= 0) {
            cout << "Invalid payment. Payment refunded: PHP" << insertedAmount << endl;
            continue;
        }

        while (true) {
            int row, column;
            cout << "\nEnter the row and column of the item you want to purchase (e.g., 1 2): ";
            cin >> row >> column;

            row--; // Convert to array index
            column--;

            if (row < 0 || row >= 4 || column < 0 || column >= 4 || quantities[row][column] <= 0) {
                cout << "Invalid selection or item out of stock. Try again.\n";
                continue;
            }

            int itemPrice = prices[row][column];
            if (insertedAmount < itemPrice) {
                cout << "Insufficient funds. Item price: PHP" << itemPrice << ". Your balance: PHP" << insertedAmount << endl;
                cout << "Do you want to add more money? (y/n): ";
                cin >> proceed;

                if (tolower(proceed) == 'y') {
                    int additionalAmount;
                    cout << "Enter additional payment (PHP): ";
                    cin >> additionalAmount;
                    insertedAmount += additionalAmount;
                } else {
                    break;
                }
            } else {
                // Process purchase
                quantities[row][column]--;
                insertedAmount -= itemPrice;
                totalAmount += itemPrice;
                purchaseCount[row][column]++;
                cout << "\nPurchased: " << vendingMachine[row][column] << "\nRemaining Balance: PHP" << insertedAmount << endl;
                
                displayMenu(vendingMachine, prices, quantities);
                
                cout << "Do you want to buy another item? (y/n): ";
                cin >> proceed;

                if (tolower(proceed) != 'y') {
                    break;
                }
            }
        }

        // Print receipt
        cout << "\n--- RECEIPT ---\n";
        cout << "Every Day Carry Pens" << "\nActivity 10\n\n";
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (purchaseCount[i][j] > 0) {
                    cout << purchaseCount[i][j] << "x " << vendingMachine[i][j] << " - PHP" 
                         << prices[i][j] * purchaseCount[i][j] << endl;
                }
            }
        }
    
        cout << "----------------------------\n";
        cout << "Total Amount: PHP" << totalAmount << endl;
        cout << "Change: PHP" << insertedAmount << endl;
        cout << "----------------------------\n";

        // Reset for another transaction
        cout << "Do you want to make another transaction? (y/n): ";
        cin >> proceed;
        if (tolower(proceed) == 'y') {
            totalAmount = 0;
            insertedAmount = 0;
            for (int i = 0; i < 4; i++) {
                for (int j = 0; j < 4; j++) {
                    purchaseCount[i][j] = 0;
                }
            }
        }
    } while (tolower(proceed) == 'y');

    cout << "Thank you for using Every Day Carry Pens!\n";
    return 0;
}

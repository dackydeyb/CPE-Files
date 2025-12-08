#include <Keypad.h>
#include <LiquidCrystal_I2C.h>
#include <Wire.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

// --- Keypad Setup ---
const byte ROWS = 4;
const byte COLS = 4;
char keys[ROWS][COLS] = {
  {'1', '2', '3', 'A'},
  {'4', '5', '6', 'B'},
  {'7', '8', '9', 'C'},
  {'*', '0', '#', 'D'}
};
byte rowPins[ROWS] = {9, 8, 7, 6}; // Connect to R1, R2, R3, R4
byte colPins[COLS] = {5, 4, 3, 2}; // Connect to C1, C2, C3, C4
Keypad keypad = Keypad(makeKeymap(keys), rowPins, colPins, ROWS, COLS);

String username = "ABCD";
String password = "1234";

String inputUser = "";
String inputPass = "";
int stage = 0;    // 0 = username, 1 = password
int attempts = 0;

// --- Relay Pins ---
int relay1 = 40; // Success (Access Granted)
int relay2 = 41; // Error 1
int relay3 = 42; // Error 2
int relay4 = 43; // Error 3 (System Lock)

// --- Function to turn OFF all relays ---
// (Assumes Active-LOW relays: HIGH = OFF, LOW = ON)
void deactivateAll() {
  digitalWrite(relay1, HIGH);
  digitalWrite(relay2, HIGH);
  digitalWrite(relay3, HIGH);
  digitalWrite(relay4, HIGH);
}

void setup() {
  lcd.init();
  lcd.backlight();
  
  pinMode(relay1, OUTPUT);
  pinMode(relay2, OUTPUT);
  pinMode(relay3, OUTPUT);
  pinMode(relay4, OUTPUT);
  
  deactivateAll(); // Start with all relays off
  
  lcd.setCursor(0, 0);
  lcd.print("Enter Username:");
}

void loop() {
  char key = keypad.getKey();

  if (key) {
    // --- '#' (Enter) Key ---
    if (key == '#') {
      if (stage == 0) { // Was entering username
        lcd.clear();
        lcd.print("Enter Password:");
        stage = 1; // Move to password stage
      } else if (stage == 1) { // Was entering password
        checkCredentials();
      }
    }
    
    else if (key == '*') {
      if (stage == 0) {
        inputUser = "";
        lcd.clear();
        lcd.print("Enter Username:");
      } else { // Clear password
        inputPass = "";
        lcd.clear();
        lcd.print("Enter Password:");
      }
    }
    
    // --- Any other key (1, 2, 3... A, B, C...) ---
    else {
      lcd.setCursor(0, 1); // Set cursor to the second line
      
      if (stage == 0) {
        inputUser += key;
        lcd.print(inputUser); // Show the username as it's typed
      } else {
        inputPass += key;
        lcd.print(inputPass); // <-- Password Masking Improvement
      }
    }
  }
}

void checkCredentials() {
  lcd.clear();
  
  if (inputUser == username && inputPass == password) {
    // --- SUCCESS ---
    lcd.print("Access Granted");
    deactivateAll();
    digitalWrite(relay1, LOW);
    
    // Halt the system. Requires physical reset to try again.
    while (true) {
      // Do nothing, system is unlocked
    }
  } else {
    // --- FAILURE ---
    attempts++;
    lcd.print("Access Denied");
    handleError(); // Trigger the correct error relay
    
    // Reset for next try
    inputUser = "";
    inputPass = "";
    stage = 0;
    
    delay(1000);
    lcd.clear();
    lcd.print("Enter Username:");
  }
}

void handleError() {
  if (attempts == 1) {
    digitalWrite(relay2, LOW); // Turn on 1st error relay
  }
  else if (attempts == 2) {
    digitalWrite(relay3, LOW); // Turn on 2nd error relay
  }
  else if (attempts >= 3) {
    // Lock the system, turn on final error relay
    deactivateAll(); // Optional: turn off others
    digitalWrite(relay2, LOW); // Turn on 1st error relay
    digitalWrite(relay3, LOW); // Turn on 2nd error relay
    digitalWrite(relay4, LOW); // Turn on 3rd error relay
    
    lcd.clear();
    lcd.print("SYSTEM LOCKED");
    
    // Halt the system. Requires physical reset.
    while (true) {
      // Do nothing
    }
  }
}
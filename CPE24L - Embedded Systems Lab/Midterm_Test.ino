#include <Servo.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <Keypad.h>

// --- I2C LCD Configuration ---
// Set the I2C address (common addresses are 0x27 or 0x3F)
// You may need to run an "I2C Scanner" sketch to find your LCD's address
LiquidCrystal_I2C lcd(0x27, 16, 2);

// --- Keypad Configuration ---
const byte ROWS = 4; // Four rows
const byte COLS = 4; // Four columns
// Define the keymap
char keys[ROWS][COLS] = {
  {'1','2','3','A'},
  {'4','5','6','B'},
  {'7','8','9','C'},
  {'*','0','#','D'}
};
// Define the pins connected to the keypad
// (These can be changed to any digital pins)
byte rowPins[ROWS] = {30, 31, 32, 33}; // Connect to R1, R2, R3, R4
byte colPins[COLS] = {34, 35, 36, 37}; // Connect to C1, C2, C3, C4

// Create the Keypad object
Keypad keypad = Keypad(makeKeymap(keys), rowPins, colPins, ROWS, COLS);

// --- Create a servo object ---
Servo radarServo;

// --- Define Component Pins ---
// Ultrasonic Sensor (HC-SR04) pins
const int trigPin = 9;
const int echoPin = 8;

// LED pins
const int ledScan = 6;     // Green LED for "Scanning"
const int ledDetected = 7; // Red LED for "Object Detected"

// Servo pin
const int servoPin = 10;

// --- Global Variables ---
long duration;
int distance;
int userRange;
int angle = 0;
bool sweepingForward = true;

// --- Function Prototypes ---
int getUserRangeFromKeypad();
void performRadarSweep();
void checkDistance();
void handleDetection();

void setup() {
  // Start Serial Communication (optional, but good for debugging)
  Serial.begin(9600);
  Serial.println("System Booting...");

  // --- Initialize LCD ---
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.print("System Booting...");

  // --- Initialize Pin Modes ---
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(ledScan, OUTPUT);
  pinMode(ledDetected, OUTPUT);

  // Attach the servo to its pin
  radarServo.attach(servoPin);

  // --- Get User Input for Range ---
  userRange = getUserRangeFromKeypad(); // This function will block until user presses '#'
  
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Range Set To:");
  lcd.setCursor(0, 1);
  lcd.print(userRange);
  lcd.print(" cm");
  Serial.print("Range set to: ");
  Serial.println(userRange);
  
  delay(2000); // Show the set range for 2 seconds
  lcd.clear();

  // Start in scanning mode
  digitalWrite(ledScan, HIGH);
  digitalWrite(ledDetected, LOW);

  // Move servo to starting position
  radarServo.write(0);
  delay(1000); // Wait 1 second for servo to get to position
}

void loop() {
  // This single function handles both sweeping and pausing.
  performRadarSweep();

  // This small delay prevents the loop from running too fast
  // and gives the servo time to move.
  delay(30);
}

/**
 * @brief Gets the detection range from the user via the keypad.
 * @return The validated range (10-200) entered by the user.
 */
int getUserRangeFromKeypad() {
  String inputString = "";
  int rangeValue = 0;

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Enter Range (cm):");
  lcd.setCursor(0, 1); // Move cursor to the second line for input

  while (true) {
    char key = keypad.getKey();

    if (key) { // A key was pressed
      if (key >= '0' && key <= '9') {
        // Only add digit if length is less than 3
        if (inputString.length() < 3) {
          inputString += key;
          lcd.print(key);
        }
      } 
      else if (key == '*') { // Use '*' as a clear/backspace
        inputString = "";
        lcd.setCursor(0, 1);
        lcd.print("                "); // Clear the line
        lcd.setCursor(0, 1);
      } 
      else if (key == '#') { // Use '#' as "Enter"
        if (inputString.length() > 0) {
          rangeValue = inputString.toInt();
          
          // Clamp the user's range to be within 10 and 200
          if (rangeValue < 10) {
            rangeValue = 10;
          }
          if (rangeValue > 200) {
            rangeValue = 200;
          }
          
          return rangeValue; // Exit the function and return the value
        }
      }
    }
  }
}

/**
 * @brief Moves the servo one step, checks for an object, and updates the LCD.
 */
void performRadarSweep() {
  // Update the angle based on the current sweep direction
  if (sweepingForward) {
    angle++;
    if (angle >= 180) {
      sweepingForward = false; // Change direction
    }
  } else {
    angle--;
    if (angle <= 0) {
      sweepingForward = true; // Change direction
    }
  }

  // Move the servo to the new angle
  radarServo.write(angle);

  // Check for an object at this new angle
  checkDistance();

  // Check if the detected distance is within the user's range
  if (distance <= userRange && distance > 0) {
    // Object detected! Pause the sweep and handle it.
    handleDetection();
  } else {
    // No object detected, ensure we are in "scanning" mode
    digitalWrite(ledScan, HIGH);
    digitalWrite(ledDetected, LOW);

    // Update LCD for scanning status
    lcd.setCursor(0, 0);
    lcd.print("Scanning...     "); // Add spaces to clear line
    lcd.setCursor(0, 1);
    lcd.print("Angle: ");
    if (angle < 100) lcd.print(" "); // Pad for alignment
    if (angle < 10) lcd.print(" ");  // Pad for alignment
    lcd.print(angle);
    lcd.print(" deg     "); // Add spaces to clear line
  }
}

/**
 * @brief Reads the distance from the ultrasonic sensor.
 * Updates the global 'distance' variable.
 */
void checkDistance() {
  // --- Ultrasonic Sensor Ping Sequence ---
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Read the echoPin
  duration = pulseIn(echoPin, HIGH);

  // --- Calculate Distance ---
  distance = duration * 0.034 / 2;
}

/**
 * @brief Handles the "pause" logic and LCD update when an object is detected.
 */
void handleDetection() {
  // Switch LEDs to "Detected" mode
  digitalWrite(ledScan, LOW);
  digitalWrite(ledDetected, HIGH);
  
  // Clear LCD and print detection message
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Object Detected!");

  // Print detection info to Serial for debugging
  Serial.print("Object detected at angle: ");
  Serial.print(angle);
  Serial.print(" deg, Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  // --- Pause Loop ---
  // Keep checking the distance at this *same angle*
  // until the object is gone (or out of range).
  while (distance <= userRange && distance > 0) {
    // Continuously update the distance and angle on the LCD
    lcd.setCursor(0, 1);
    lcd.print("Dist:");
    lcd.print(distance);
    lcd.print("cm A:");
    lcd.print(angle);
    lcd.print("  "); // Clear trailing characters
    
    delay(100);        // Wait a short moment before re-checking
    checkDistance();   // Re-check the distance at the *same angle*
  }
  
  // --- Object Cleared ---
  // The while loop has exited, meaning the object is gone.
  Serial.println("Object cleared. Resuming scan...");

  // Switch LEDs back to "Scanning" mode
  digitalWrite(ledScan, HIGH);
  digitalWrite(ledDetected, LOW);

  // Display "Object cleared" message
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Object cleared.");
  lcd.setCursor(0, 1);
  lcd.print("Resuming scan...");
  delay(1500); // Show message for 1.5 seconds
  lcd.clear(); // Clear for the next "Scanning..." update
}


#include "DHT.h"

#define DHTPIN 2       // DHT sensor connected to digital pin 2
#define DHTTYPE DHT11  // Sensor type: DHT11

// LED pins
#define GREEN_LED 3
#define YELLOW_LED 4
#define RED_LED 5

DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(9600);
  Serial.println(F("DHT11 Temperature Indicator"));

  dht.begin();

  // Set LED pins as output
  pinMode(GREEN_LED, OUTPUT);
  pinMode(YELLOW_LED, OUTPUT);
  pinMode(RED_LED, OUTPUT);
}

void loop() {
  delay(400); // Wait a bit between reads

  float t = dht.readTemperature(); // Read temperature in Celsius

  if (isnan(t)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }

  Serial.print(F("Temperature: "));
  Serial.print(t);
  Serial.println(F(" °C"));

  // Turn LEDs on/off based on temperature
  if (t < 26) { // Cold
    digitalWrite(GREEN_LED, HIGH);
    digitalWrite(YELLOW_LED, LOW);
    digitalWrite(RED_LED, LOW);
  } 
  else if (t >= 26 && t <= 28) { // Normal
    digitalWrite(GREEN_LED, LOW);
    digitalWrite(YELLOW_LED, HIGH);
    digitalWrite(RED_LED, LOW);
  } 
  else { // Hot
    digitalWrite(GREEN_LED, LOW);
    digitalWrite(YELLOW_LED, LOW);
    digitalWrite(RED_LED, HIGH);
  }
}

// BSCpE Group 1

const int led[] = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
const int ButtonLeft = 12;
const int buttonright = 13;

int PusbuttonLeft = 4;
int counterright = 4;

// Loop something
void setup() {
  Serial.begin(9600);
  pinMode(ButtonLeft, INPUT);
  pinMode(buttonright, INPUT);
  for (int k = 0; k < 10; k++){
    pinMode(led[k], OUTPUT);
  }
  digitalWrite(led[4], HIGH);
}

void loop() {
  int buttonStateleft = digitalRead(ButtonLeft);
  int buttonStateright = digitalRead(buttonright);

  Serial.println(buttonStateleft && "   |   " && buttonStateright);

  if (buttonStateleft == HIGH) {
    PusbuttonLeft--;
    digitalWrite(led[PusbuttonLeft], HIGH);
    // Simple debounce
    delay(1000);

  }
  if (buttonStateright == HIGH) {
    counterright++;
    digitalWrite(led[counterright], HIGH);
    // Simple debounce
    delay(1000);

  }


}
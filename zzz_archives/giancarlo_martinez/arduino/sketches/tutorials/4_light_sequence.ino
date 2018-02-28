void setup() {
  // put your setup code here, to run once:
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(LED_BUILTIN, HIGH);
  delay(214);
  digitalWrite(LED_BUILTIN, LOW);
  digitalWrite(12, HIGH);
  delay(214);
  digitalWrite(12, LOW);
  digitalWrite(11, HIGH);
  delay(214);
  digitalWrite(11, LOW);
  digitalWrite(10, HIGH);
  delay(214);
  digitalWrite(10, LOW);
}

#include <LiquidCrystal.h>
#define NOTE_C4  262
#define NOTE_C5  523
#define NOTE_A3  220
#define NOTE_A4  440
#define NOTE_AS3 233
#define NOTE_AS4 466

const int piezoPin = 9;
bool hasplayed = true;
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
int seconds = 0;

void setup()
{
  pinMode(piezoPin, OUTPUT);
  pinMode(A0, INPUT);
  pinMode(LED_BUILTIN, OUTPUT);
  lcd.begin(16, 2);
  Serial.begin(9600);
}

void loop()
{
  int led_voltage = analogRead(A0);
  
  //when dark
  if (led_voltage >= 500 && !hasplayed){
    digitalWrite(LED_BUILTIN, HIGH);
    hasplayed = true;
    playMelody();
    lcd.setCursor(4,1);
    lcd.print("Good Night!");
  }
  
  //when light
  if (led_voltage <= 499){
    digitalWrite(LED_BUILTIN, LOW);
    hasplayed = false;
  }
   
  lcd.setCursor(0,0);
  lcd.print("LED Read: ");
  lcd.println(led_voltage);
  
  lcd.setCursor(0, 1);
  lcd.print(seconds); 
  
  Serial.print("LED Voltage: ");
  Serial.println(led_voltage);
  Serial.print("Has Played: ");
  Serial.println(hasplayed);
  
  delay(1000); 
  seconds += 1;
  lcd.clear();
}

/*
The following are _independent_ functions. DO NOT add them to setup() or loop()!
*/
int melody[] = {
  NOTE_C4, NOTE_C5, NOTE_A3, NOTE_A4, NOTE_AS3, NOTE_AS4
};

int noteDurations[] = {
  12, 12, 12, 12, 12, 12 //4 = quarter note, 8 = eighth note, 12 = 1/12 or triplet, etc.
};

void playMelody() {
  // Iterate over the notes of the melody
  for (int i = 0; i < sizeof(melody) / sizeof(melody[0]); i++) {
    int noteDuration = 1000 / noteDurations[i];
    tone(piezoPin, melody[i], noteDuration);

    // Pause for the note's duration plus a brief pause between notes
    int pauseBetweenNotes = noteDuration * 1.50;
    delay(pauseBetweenNotes);

    // Stop the tone after the note is played
    noTone(piezoPin);
  }
}

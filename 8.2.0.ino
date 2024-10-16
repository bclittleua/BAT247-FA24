#include <CapacitiveSensor.h>
#include <Joystick.h>

// Define capacitive sensors for each button
CapacitiveSensor dPadUp = CapacitiveSensor(4, 2);   // Using Pin 4 to "send," Pin 2 as sensor
CapacitiveSensor dPadDown = CapacitiveSensor(4, 3);
CapacitiveSensor dPadLeft = CapacitiveSensor(4, 4);
CapacitiveSensor dPadRight = CapacitiveSensor(4, 5);
CapacitiveSensor buttonSelect = CapacitiveSensor(4, 6);
CapacitiveSensor buttonStart = CapacitiveSensor(4, 7);
CapacitiveSensor buttonA = CapacitiveSensor(4, 8);
CapacitiveSensor buttonB = CapacitiveSensor(4, 9);

// Simple Joystick initialization
Joystick_ Joystick(JOYSTICK_TYPE_GAMEPAD, 8);

void setup() {
  Joystick.begin();
}

void loop() {
  int threshold = 1000; // Adjust based on sensitivity

  // Read sensor values
  bool dPadUpState = dPadUp.capacitiveSensor(30) > threshold;
  bool dPadDownState = dPadDown.capacitiveSensor(30) > threshold;
  bool dPadLeftState = dPadLeft.capacitiveSensor(30) > threshold;
  bool dPadRightState = dPadRight.capacitiveSensor(30) > threshold;
  bool selectState = buttonSelect.capacitiveSensor(30) > threshold;
  bool startState = buttonStart.capacitiveSensor(30) > threshold;
  bool aButtonState = buttonA.capacitiveSensor(30) > threshold;
  bool bButtonState = buttonB.capacitiveSensor(30) > threshold;

  // Send button presses
  Joystick.setButton(0, dPadUpState);
  Joystick.setButton(1, dPadDownState);
  Joystick.setButton(2, dPadLeftState);
  Joystick.setButton(3, dPadRightState);
  Joystick.setButton(4, selectState);
  Joystick.setButton(5, startState);
  Joystick.setButton(6, aButtonState);
  Joystick.setButton(7, bButtonState);

  delay(10);
}

# Electronic Lock using 8051 Microcontroller

This project uses the 8051 microcontroller to create an electronic lock that relies on a passcode. The system has an electronic control system using an assembly code that uses a numerical password to regulate the output load through the 8051 chip.

The 8051 microprocessor relies on the loaded assembly code to be able to make out whether devices are connected to it and how such devices work to produce certain output based on the inputs given.

## Methodology

The project simply works using a 6V power source made up of an array of 1.5V batteries. These batteries power up the whole circuit, including an 8051 Microprocessor, motor drive, motor, 16*2 LCD display and 3*4 keypad.

**Inputs**: Passcode supplied by user.

**Outputs**: Motor drive signals the rotation of the motor in an anticlockwise motion for unlocking.

A 16*2 LCD display is connected to the microprocessor to display certain messages that tell the users if the passcode they have entered is correct or not.

The passcode is input through the 3*4 keypad which is specifically made up of 4 rows and 3 columns that contain buttons which correspond to numerical values.

A motor is used as a mechanism that is enabled when the user correctly inserts the passcode through the keypad. It is powered by the motor drive, which is the bridge between the main circuit and the motor itself. The drive supplies enough power and controls the direction in which it rotates.

1. Circuit is powered up, LCD is initialized, user is met with the message “Enter Code: “
2. User proceeds to enter a 6-digit passcode using the keypad.
3. The 8051 microcontroller analyzes the passcode input by the user and compares it with another preset passcode to determine whether they match.
4. If they do, the user is prompted with a message “Success.”
5. The microcontroller implicitly sends signals to the motor drive to rotate in an anticlockwise direction to represent and simulate the unlocking of the door. The mechanism pauses for a couple of seconds after the unlock to mimic locking the door back again.
6. If the passcodes do not match, the user is met with the message “Failure.”
7. The microcontroller does not signal the motor drive to proceed in the unlock function.
8. The user may proceed to try entering the passcode again.

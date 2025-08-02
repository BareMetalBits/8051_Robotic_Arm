# 8051_Robotic_Arm
Following is a collection of all the necessary details regarding a Remote controlled robotic arm based on 8051 micro controller:
AT89C51 from Atmel is the primary computation device for our project.
For the servo control we make the use of internal timer circuits on the chip and the use of software delays for the generation of PWM signals for the direction and speed control of the servo motors.
For the stepper motor control we make the use of a simple half step sequence pulse generation.
The driver used for the stepper motor for simulation was ULN2003A.
The clock frequency used for the simulation was 12Mhz.

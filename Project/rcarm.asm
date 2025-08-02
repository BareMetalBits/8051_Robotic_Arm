ORG 0000H

MAIN:
    MOV P1, #00H        
    MOV P2, #00H        
    SETB P3.0          
    SETB P3.1
    SETB P3.2
    SETB P3.3
    SETB P3.4
    SETB P3.5
    SETB P3.6
    SETB P3.7
MAIN_LOOP:
    JB P3.0, NEXT1     
    ACALL STEP_CW
NEXT1:
    JB P3.1, NEXT2
    ACALL STEP_CCW
NEXT2:
    JB P3.2, NEXT3
    ACALL BASE_UP
NEXT3:
    JB P3.3, NEXT4
    ACALL ELBOW_UP
NEXT4:
    JB P3.4, NEXT5
    ACALL WRIST_UP
NEXT5:
    JB P3.5, NEXT6
    ACALL GRIP_CLOSE
NEXT6:
    JB P3.6, NEXT7
    ACALL BASE_DOWN
NEXT7:
    JB P3.7, NEXT8
    ACALL ELBOW_DOWN
NEXT8:
	JB P0.0,NEXT9
	ACALL WRIST_DOWN
NEXT9:
	JB P0.1,ENDLOOP
	ACALL GRIP_OPEN
ENDLOOP:
    SJMP MAIN_LOOP

STEP_CW:
    MOV A, #09H
    MOV P1, A
    ACALL DELAY
    MOV A, #08H
    MOV P1, A
    ACALL DELAY
    MOV A, #0CH
    MOV P1, A
    ACALL DELAY
    MOV A, #04H
    MOV P1, A
    ACALL DELAY
    RET

STEP_CCW:
    MOV A, #04H
    MOV P1, A
    ACALL DELAY
    MOV A, #0CH
    MOV P1, A
    ACALL DELAY
    MOV A, #08H
    MOV P1, A
    ACALL DELAY
    MOV A, #09H
    MOV P1, A
    ACALL DELAY
    RET

; ------------------------
; Servo Control Pulses
; ------------------------
BASE_UP:
    SETB P2.0
    ACALL SHORT_PULSE
    CLR P2.0
    ACALL SERVO_DELAY
    RET

BASE_DOWN:
    SETB P2.0
    ACALL LONG_PULSE
    CLR P2.0
    ACALL SERVO_DELAY
    RET

ELBOW_UP:
    SETB P2.1
    ACALL SHORT_PULSE
    CLR P2.1
    ACALL SERVO_DELAY
    RET

ELBOW_DOWN:
    SETB P2.1
    ACALL LONG_PULSE
    CLR P2.1
    ACALL SERVO_DELAY
    RET

WRIST_UP:
    SETB P2.2
    ACALL SHORT_PULSE
    CLR P2.2
    ACALL SERVO_DELAY
    RET

GRIP_CLOSE:
    SETB P2.3
    ACALL SHORT_PULSE
    CLR P2.3
    ACALL SERVO_DELAY
    RET
GRIP_OPEN:
	SETB P2.3
	ACALL LONG_PULSE
	CLR P2.3
	ACALL SERVO_DELAY
	RET
WRIST_DOWN:
	SETB P2.2
	ACALL LONG_PULSE
	CLR P2.2
	ACALL SERVO_DELAY
	RET
; ------------------------
; Pulse Generation (~1ms)
; ------------------------
SHORT_PULSE:
    MOV R2, #100
L1: MOV R1, #250
L2: DJNZ R1, L2
    DJNZ R2, L1
    RET

; Longer Pulse (~2ms)
LONG_PULSE:
    MOV R2, #200
L3: MOV R1, #250
L4: DJNZ R1, L4
    DJNZ R2, L3
    RET

; Delay Between Pulses (~18ms)
SERVO_DELAY:
    MOV R3, #18
D1: ACALL SHORT_PULSE
    DJNZ R3, D1
    RET

; ------------------------
; Generic Delay (for stepper)
; ------------------------
DELAY:
    MOV R2, #50
D2: MOV R1, #255
D3: DJNZ R1, D3
    DJNZ R2, D2
    RET

END

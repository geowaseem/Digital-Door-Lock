ORG 0000H
RS BIT P2.0
E  BIT P2.1
IN1 BIT P2.2
IN2 BIT P2.3
ROW1 BIT P3.0
ROW2 BIT P3.1
ROW3 BIT P3.2
ROW4 BIT P3.3
COLUMN1 BIT P3.4
COLUMN2 BIT P3.5
COLUMN3 BIT P3.6
 
START: MOV P3,#0FFH ;initializing C1:C3 B 1'S
  ​CLR IN1 ; Motor drive IN1 = 0
  ​CLR IN2 ; Motor drive IN2 = 0
 
  MOV R0,#02FH​​;Input Password is Stored at 030H in memory, -1 because when the key is pressed, and accordingly increments R0
  MOV R1,#040H​​;Preset Password is Stored at 040H in memory
  MOV R4,#6          ;moved 6 into R4 as 6 digits
  ;R4 is a counter , R0 has the input password , R1 has the correct password
  MOV DPTR,#0550H
Z: MOV A,#0  ;Move into R1 the preset password chosen, 808975
  MOVC A,@A+DPTR
  MOV @R1,A ; move at address of 040h the password
  INC R1
  INC DPTR
  DJNZ R4,Z
 
  MOV A,#38H ;initiate lcd
  ACALL CMD    
  MOV A,#0EH   ;Display ON, cursor blinking
  ACALL CMD​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
  MOV A,#01H   ; clear lcd
  ACALL CMD
  MOV A,#080H ;Force cursor to beginning of first line
  ACALL CMD
  ACALL DEL
  SJMP PRT
 
;sub-routine for LCD control (to enter the command that you want)
 
CMD:     MOV P1,A ; send data to P1 (send command to p1)
​ CLR RS ;RS = 0 for command  ( to take commands )
​ SETB E ;E = 1 for high pulse
​ ACALL DEL2 ; delay
​ CLR E ;E= 0 for H-L pulse
​ RET
 
DAT: ​ MOV P1,A    ;printing on the lcd, subroutine for data latching to lcd
    ​ SETB RS   ;RS = 1 TO PRINT ​​
​ SETB E
​ ACALL DEL2
​ CLR E
​ RET
 
;delay
DEL: MOV R1,#250
D2: MOV R2,#250
   DJNZ R2,$
   DJNZ R1,D2
   RET
 
;delay2
DEL2: MOV R1,#10
D22: MOV R2,#255
    DJNZ R2, $
    DJNZ R1,D22
    RET
   
DEL3: MOV R1,#200
D2B: MOV R2,#200
D3B: MOV R3,#20
​DJNZ R3,$ 
​DJNZ R2,D3B
​DJNZ R1,D2B
​RET​
PRT:MOV R4,#11 ​​;11 to print "enter code:" on the lcd which is 11 characters, cx = 11
   MOV DPTR,#0500H  ;points at the beginning of the string that i want to print
;PRINTING A STRING byte by byte / character by character    
TH: ​MOV A,#0
​MOVC A,@A+DPTR ; @ goes to the address specified after it and takes its values like [102]
​ACALL DAT
​INC DPTR
​DJNZ R4,TH  ;decrement and jump if not zero
​MOV A,#0C0H  ;Force LCD cursor to beginning of second line
  ​ACALL CMD
​MOV R4,#6 ; since the password is set to 6 digits
​SJMP M
;checks which column has the pressed key
;whichever column has the pressed key, the correspondent row w column get grounded
M:  ​MOV P3,#0FFH
​ACALL DEL
   ​CLR ROW1
   ​JB COLUMN1, NEXT1
   ​ACALL ONE
   ​JMP NEXT12
NEXT1: JB COLUMN2, NEXT2
​ACALL TWO
​JMP NEXT12
NEXT2: JB COLUMN3,NEXT3
​ACALL THREE
​JMP NEXT12
NEXT3: SETB ROW1
      CLR ROW2
      JB COLUMN1,NEXT4
      ACALL FOUR
      JMP NEXT12
NEXT4: JB COLUMN2, NEXT5
​ACALL FIVE
​JMP NEXT12
NEXT5: JB COLUMN3 , NEXT6
​ACALL SIX
​JMP NEXT12
NEXT6: SETB ROW2
​CLR ROW3
​JB COLUMN1,NEXT7
​ACALL SEVEN
​JMP NEXT12
NEXT7: JB COLUMN2, NEXT8
​ACALL EIGHT
​JMP NEXT12
NEXT8: JB COLUMN3 , NEXT9
​ACALL NINE
​JMP NEXT12
NEXT9: SETB ROW3
​CLR ROW4
​JB COLUMN1, NEXT10
​ACALL STAR
​JMP NEXT12
NEXT10:JB COLUMN2,NEXT11
​ACALL ZERO
​JMP NEXT12
NEXT11:JB COLUMN3,NEXT12
​ACALL HASH
​JMP M​
NEXT12: CJNE R4,#0,M ;Compares R4 with Zero, if it didn't reach it then checks which key has been pressed
   ; keeps waiting until a key is pressed or when all the 6 input characters have been entered.
       JMP CHE  ;jump if read all 6 digits
 
 
 
SEVEN:     DEC R4
          INC R0
          MOV A,#'7'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'7'
​   RET
 
FOUR:      DEC R4
          INC R0
​   MOV A,#'4'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'4'
​   RET
 
ONE:       DEC R4
          INC R0
​   MOV A,#'1'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'1'
​   RET
 
STAR:      DEC R4
          INC R0
          MOV A,#'*'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'*'
​   RET
​  
EIGHT: ​   DEC R4
          INC R0
​   MOV A,#'8'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'8'
​   RET
 
FIVE:      DEC R4
          INC R0
          MOV A,#'5'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'5'
​   RET
 
TWO:       DEC R4
          INC R0
          MOV A,#'2'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'2'
​   RET
 
ZERO:      DEC R4
          INC R0
 ​   MOV A,#'0'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'0'
​   RET
 
NINE:      DEC R4
          INC R0​​
​   MOV A,#'9'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'9'
​   RET
 
SIX:       DEC R4
          INC R0
          MOV A,#'6'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'6'
​   RET
 
THREE:     DEC R4
          INC R0
          MOV A,#'3'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'3'
​   RET
 
HASH:      DEC R4
          INC R0
          MOV A,#'#'
​   ACALL DAT
​   ACALL DEL
​   MOV @R0,#'#'
​   RET
 
;The 5 digits have been read
CHE:MOV A,#01H ;Clear Display Screen
   ACALL CMD
   MOV A,#080H ;Force the cursor to the beginning of 1st Line
   ACALL CMD
   ACALL DEL
   MOV R0,#030H
   MOV R1,#040H
   MOV R4,#6
 
CH: ​MOV A,@R0
​MOV B,@R1
​INC R0 ;address 30, first byte of the input password
​INC R1 ;address 40, first byte of the correct password
​CJNE A,B,FA  ; compares both passwords byte by byte, first mismatch is considered a failure
​DJNZ R4,CH ;to check the 6 digits of the password
   MOV R4,#7
​MOV DPTR,#0600H
TH2:    MOV A,#0
​MOVC A,@A+DPTR
​ACALL DAT
​INC DPTR
​DJNZ R4,TH2
​SETB IN1
​
H2:​CLR IN1 ;IN1 clockwise direction
  ​SETB IN2 ;IN2 anticlockwise direction
  ​ACALL DEL3
  ​;ACALL DEL3
  ​CLR IN1 ; to stop the motion
  ​CLR IN2 ; to stop the motion
  ​ACALL DEL3
  ​SETB IN1 ;reverses the direction
  ​CLR IN2
  ​ACALL DEL3
  ​JMP START  
 
 
FA: MOV R4,#7
​MOV DPTR,#0650H
TH3:MOV A,#0
​MOVC A,@A+DPTR
​ACALL DAT
​INC DPTR
​DJNZ R4,TH3
​MOV R4,#10
WA:​ACALL DEL
​DJNZ R4,WA
​JMP START
 
 
 
 
ORG 0500H
DB "ENTER CODE:"
 
ORG 0550H
DB "818975"
 
ORG 0600H
DB "SUCCESS"
 
ORG 0650H
DB "FAILURE"
 
END 

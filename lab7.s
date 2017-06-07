    AREA interrupts, CODE, READWRITE
	EXPORT lab7
	EXPORT FIQ_Handler
	IMPORT pin_connect_block_setup_for_7_segment
	IMPORT display_digit
	IMPORT interrupt_init
	IMPORT String_to_number
	IMPORT number_to_string
	IMPORT div_and_mod
	IMPORT number_to_string2
	IMPORT read_character
	IMPORT output_string
	IMPORT timer_enabler
	IMPORT digits_SET
	IMPORT pin_connect_block_setup_for_RGB_LEDs
    IMPORT LED_Dir
	IMPORT display_color
    IMPORT clear_color
    IMPORT clear_digit_seg
    IMPORT display_digit  
    IMPORT increment_seven_segment      
    IMPORT RGB_LEDs
    IMPORT LEDs
	IMPORT String_to_number
    IMPORT number_to_string
    IMPORT div_and_mod
    IMPORT number_to_string2
    IMPORT read_character
    IMPORT output_string
    IMPORT timer_enabler
    IMPORT digits_SET
	IMPORT global_reg


QBert
	DCD 0x0				;QBert's position on the board
	ALIGN

QBert_Moves
	DCB 0x0				;
	ALIGN

Balls				  	;Location of Ball 1-4
	DCD 0x0
	DCD 0x0
	DCD 0x0
	DCD 0x0
	DCD 0x0
	ALIGN

Number_of_Balls		  ;Number of balls currently on the pyramid
	DCB 0x0
	ALIGN

Snake
	DCD 0x0
	ALIGN

Snake_Surrounding_Tiles
	DCD 0x0
	DCD 0x0
	DCD 0x0
	DCD 0x0
	DCD 0x0
	ALIGN

Legal_Snake_Surrounding_Tiles
	DCD 0x0
	DCD 0x0
	DCD 0x0
	DCD 0x0
	DCD 0x0
	ALIGN

Snake_Ball
	DCD 0x0
	ALIGN

Number_of_Snake_Ball
	DCB 0x0
	ALIGN

Number_of_Snakes
	DCB 0x0
	ALIGN
		
VisitedTileCount
	DCB 0x0
	ALIGN
		
QBert_Lives
	DCB 0x4
	ALIGN

Level
	DCB 0x0
	ALIGN
		
LegalTiles
	DCD 0x0 
	DCD 0x0 
	DCD 0x0 
	DCD 0x0 
	DCD 0x0
	DCD 0x0 
	DCD 0x0 
	DCD 0x0 
	DCD 0x0 
	DCD 0x0
	DCD 0x0 
	DCD 0x0 
	DCD 0x0 
	DCD 0x0
	DCD 0x0 
	DCD 0x0 
	DCD 0x0
	DCD 0x0 
	DCD 0x0 
	DCD 0x0
	DCD 0x0
	ALIGN
		
BottomTiles
	DCD 0x0 
	DCD 0x0 
	DCD 0x0 
	DCD 0x0 
	DCD 0x0
	DCD 0x0
	ALIGN

timer_counter
    DCB 0x0            ;counter for the global timer
    ALIGN

score_reg
    DCD 0x0               ;counter to keep track of the score  
    ALIGN  


LEDs_pattern
    DCB 0x4
    ALIGN

Blink_Color
	DCB 0x0
	ALIGN

Blink_Count
	DCB 0x0
	ALIGN
		
Blink_Flag
	DCB 0x0
	ALIGN

Pause_Flag
	DCB 0x0
	ALIGN

Buffer
	DCD 0x0
	DCD 0x0
	DCD 0x0
	ALIGN

refresh = 0xC, 0
space2 = "                            ", 0	
game = "           _____                            ",0xA,0xD,"          /    /|                          ",0xA,0xD,"         /____/ |____                      ",0xA,0xD,"         |    | /   /|                     ",0xA,0xD,"         |____|/___/ |____                 ",0xA,0xD,"         /   /|   | /    /|                ",0xA,0xD,"        /___/ |___|/____/ |_____           ",0xA,0xD, "        |   | /   /|    | /    /|          ",0xA,0xD, "        |___|/___/ |____|/____/ |____      ",0xA,0xD, "        /   /|   | /    /|    | /   /|     ",0xA,0xD,"       /___/ |___|/____/ |____|/___/ |____ ",0xA,0xD, "       |   | /   /|    | /    /|   | /   /|",0xA,0xD, "       |___|/___/ |____|/____/ |___|/___/ |",0xA,0xD, "      /   /|   | /    /|    | /   /|    | /",0xA,0xD, "     /___/ |___|/____/ |____|/___/ |____|/ ",0xA,0xD, "    |    | /   /|    |/    /|    | /       ",0xA,0xD,  "    |____|/___/ |____/____/ |____|/        ",0xA,0xD,"   /    /|    | /   /|    | /              ",0xA,0xD, "  /____/ |____|/___/ |____|/               ",0xA,0xD, "  |    | /   /|    | /                     ",0xA,0xD, "  |____|/___/ |____|/                      ",0xA,0xD,  " /    /|    | /                            ",0xA,0xD, "/____/ |____|/                             ",0xA,0xD,  "|    | /                                   ",0xA,0xD, "|____|/                                    ",0xA,0xD,0
prompt2 = 0xC,"Welcome to Q'Bert!",0xA,0xA,0xA,0xD,"Use the W, A, S, and D keys to move Q'bert around the pyramid.",0xA,0xA,0xD,"Q'bert is denoted by the character 'Q'.",0xA,0xA,0xD, "Travel the pyramid spots and change the asterisks.",0xA,0xA,0xD, "Avoid the snakes and the balls and gain points while traversing through the pyramid.",0xA,0xA,0xD, "You have two minutes to play the game or until you run out of lives.",0xA,0xA,0xD,"The LED's represent how many lives Q'Bert has left while the seven segment display shows your current game level.",0xA,0xA,0xD,"If you want to pause the game at any point, press the momentary push button.",0xA,0xA,0xD,"Good luck!",0xA,0xA,0xA,0xD,"Press <ENTER> to begin!",0xA,0xD,0    
prompt3 =  "TIMER: ",0
timecount = "0000", 0xA,0xD,0
prompt4 = "SCORE: ",0
score = "0000",0xA,0xD,0 
pause = "PAUSE",0xA,0xA,0xD,0
gameover = 0xC, "GAMEOVER, Press RESET Button (on Board) to play again",0xA,0xA,0xD,0	
	ALIGN

lab7	 	
		STMFD sp!, {lr}

			BL pin_connect_block_setup_for_7_segment          ;sets up the seven seg
            LDR r1, =Level                                       ;tracks current level
            LDRB r0, [r1]                                        
            BL display_digit

            BL pin_connect_block_setup_for_RGB_LEDs
            MOV r0, #0
            BL RGB_LEDs
            
            LDR r4, =prompt2                                ;load and show the game instructions for the user to understand how to play.
            BL output_string
NotCR       BL read_character
                          

            CMP r0, #0xd                                    ;Check if character entered was ENTER (0xd)
            BNE NotCR                                       ;Branch if not equal

            MOV r0, #3
            BL RGB_LEDs

            LDR r1, =Level                                       ;tracks current level
            LDRB r0, [r1]                                        
            ADD r0, r0 , #1
            STRB r0, [r1]
            BL display_digit                                     ;passed through r0, displays it

            BL LED_Dir                                             ;branch to subroutines that sets up the LEDs/ used for lives
            BL LEDs

			
			BL InitializeLegalTiles
			BL InitializeBottomTiles
			BL SetTiles2
			BL Initialize_QBert
			
	 		BL interrupt_init
	 		BL timer_enabler
	
INFINITY	ADD r0, r0, #0
			B INFINITY
			
	LDMFD sp!,{lr}
	BX lr
	
FIQ_Handler
			STMFD SP!, {r0-r12, lr}   ; Save registers 

EINT1            				; Check for EINT1 interrupt
			LDR r0, =0xE01FC140            ;Load the external interrupt flag register into r0
			LDR r1, [r0]                ;Load memory r0 into r1
			TST r1, #2                    ;checks to see if pin 2 is 1
			BEQ UART0                    ;equal, branch to the UART0
		
			LDR r3, =Blink_Flag			;
			LDRB r3, [r3]				;This Block checks if the Blinking RGB Flag register has been set 
			CMP r3, #1					;If the register has been set (=1) then the interrupt is ignored
			BEQ CLEAR					;			


            LDR r4, =refresh
            BL output_string
            LDR r4, =pause                 
            BL output_string             
            LDR r4, =space2
            BL output_string
            LDR r4, =prompt3
            BL output_string
            LDR r4, =timecount
            BL output_string
            LDR r4, =space2
            BL output_string
            LDR r4, =prompt4
            BL output_string
            LDR r4, =score
            BL output_string
            LDR r4, =game
            BL output_string

			MOV r0, #2
			BL RGB_LEDs


            LDR r3, =global_reg            ;load the global register from memory
            LDRB r4, [r3,#2]            ;load the 2nd global variable into r4
            CMP r4, #0x0                ;compare the flag to 0
            BNE not0                    ;if its not 0 than we branch to not0 Label
            ADD r4, #0x1                ;if it is a 0 then we add 1 to it
            STRB r4, [r3,#2]            ;store that back into the 2nd global variable

			LDR r3, =Pause_Flag
			MOV r4, #1
			STRB r4, [r3]

            B CLEAR                        ;branch to clear
not0        MOV r4, #0                   ;copy 0 into register 4
            STRB r4, [r3,#2]            ;store that back into the 2nd global variable

			LDR r3, =Pause_Flag
			MOV r4, #0
			STRB r4, [r3]

            B CLEAR                       ;branch to clear

CLEAR	  	LDR r3, =0xE01FC140            ;Load the external interrupt flag register into r3
			LDR r1, [r3]                ;Load that into r1
			ORR r1, r1, #2                ;Clear Interrupt
			STR r1, [r3]                ;store that back into the external interrupt flag register
			
			B FIQ_Exit

UART0   
			LDR r3, =global_reg         ;Load global_reg into r3
            LDRB r4, [r3,#2]         ;Load Button Flag into r4
            CMP r4, #0x1              ;Check if Button Flag is 1
            BEQ FIQ_Exit              ;If r4=1 then branch to FIQ_Exit    

			LDR r0, =0xE000C008          ;Load U0IIR (0xE000C008) into r0
			LDR r1, [r0]               ;Load memory from U0IIR into r1
			TST r1, #1                   ;Check if Bit 0 is 1
			BNE TIMER0                ;If Bit 0 != 1 then Branch to TIMER0	
			
			LDR r6, =0xE000C000            ;Load Recieve Register Address into r6
			LDRB r0, [r6]                ;Load Byte from Recieve Register into r0
			
			LDR r3, =Blink_Flag			;
			LDRB r3, [r3]				;This Block checks if the Blinking RGB Flag register has been set 
			CMP r3, #1					;If the register has been set (=1) then the interrupt is ignored
			BEQ FIQ_Exit				;

			LDR r2, =QBert_Moves
			LDRB r2, [r2]
			CMP r2, #1
			BEQ FIQ_Exit

			LDR r3, =QBert         		;Load QBert's position into r3
			LDR r3, [r3]			
			MOV r4, #0x20
			STRB r4, [r3]         		;Load byte from top tile into r4

			CMP r0, #0x77                ;Check if the character entered is a 'w'(0x77)
			BEQ UP                        ;if key pressed was 'w', branch to label that handles upwards movement
			CMP r0, #0x61                ;Check if the character entered is a 'a'(0x61)
			BEQ LEFT                    ;If key pressed was a 'a', branch to label that handles leftward movement
			CMP r0, #0x73                ;Check if the character entered is a 's'(0x73)
			BEQ DOWN                    ;if key pressed was a 's', branch to label that handles downward movement
			CMP r0, #0x64                ;Check if the character entered is a 'd'(0x64)
			BEQ RIGHT                    ;if key pressed was a 'd', branch to label that handles rightward movement
			B FIQ_Exit


UP                                    ;code to handle upwards movement	
			LDRB r4, [r3, #-0xb1]!		
			CMP r4, #0x2a
			BNE NOPE1
			
			MOV r7, #0x20
			STRB r7, [r3]
			
			LDR r5, =VisitedTileCount
			LDRB r6, [r5]
			ADD r6, r6, #1
			BL ADD10
			CMP r6, #21
			
			BNE SKIPP
			BL NewLevel
			B FIQ_Exit
			
SKIPP		STRB r6, [r5]
			
NOPE1		LDRB r4, [r3, #-1]!
			CMP r4, #0x45			;Ball
			BNE Not_ball2
			BL Blinking_RGB
			B FIQ_Exit
Not_ball2	CMP r4, #0x43			;Snake Ball
			BNE Not_sb2
			BL Blinking_RGB
			B FIQ_Exit
Not_sb2		CMP r4, #0x53			;Snake Ball
			BNE Not_snake2
			BL Blinking_RGB
			B FIQ_Exit

Not_snake2	MOV r4, #0x51                             
			STRB r4, [r3]
			LDR r4, =QBert
			STR r3, [r4]   
			B CHECK

LEFT                                ;code to handle leftward movement
			LDRB r4, [r3, #-0x5E]!		
			CMP r4, #0x2a
			BNE NOPE2
			
			MOV r7, #0x20
			STRB r7, [r3]
			
			LDR r5, =VisitedTileCount
			LDRB r6, [r5]
			ADD r6, r6, #1
			BL ADD10
			CMP r6, #21
			BNE SKIPP2
			
			BL NewLevel
			B FIQ_Exit
			
SKIPP2		STRB r6, [r5]
			
NOPE2		LDRB r4, [r3, #-1]!
			CMP r4, #0x45			;Ball
			BNE Not_ball
			BL Blinking_RGB
			B FIQ_Exit
Not_ball	CMP r4, #0x43			;Snake Ball
			BNE Not_sb
			BL Blinking_RGB
			B FIQ_Exit
Not_sb		CMP r4, #0x53			;Snake Ball
			BNE Not_snake
			BL Blinking_RGB
			B FIQ_Exit

Not_snake	MOV r4, #0x51                             
			STRB r4, [r3]
			LDR r4, =QBert
			STR r3, [r4]   
			B CHECK

DOWN                                ;code to handle downward movement
			LDRB r4, [r3, #0xb3]!		
			CMP r4, #0x2a
			BNE NOPE3
			
			MOV r7, #0x20
			STRB r7, [r3]
			
			LDR r5, =VisitedTileCount
			LDRB r6, [r5]
			ADD r6, r6, #1
			BL ADD10
			CMP r6, #21
			BNE SKIPP3
			
			BL NewLevel
			B FIQ_Exit
			
SKIPP3		STRB r6, [r5]
			
NOPE3		LDRB r4, [r3, #-1]!
			CMP r4, #0x45			;Ball
			BNE Not_ball4
			BL Blinking_RGB
			B FIQ_Exit
Not_ball4	CMP r4, #0x43			;Snake Ball
			BNE Not_sb4
			BL Blinking_RGB
			B FIQ_Exit
Not_sb4		CMP r4, #0x53			;Snake Ball
			BNE Not_snake4
			BL Blinking_RGB
			B FIQ_Exit

Not_snake4	MOV r4, #0x51                             
			STRB r4, [r3]
			LDR r4, =QBert
			STR r3, [r4]   
			B CHECK

RIGHT   
			LDRB r4, [r3, #0x60]!					
			CMP r4, #0x2a
			BNE NOPE4
			
			MOV r7, #0x20
			STRB r7, [r3]
			
			LDR r5, =VisitedTileCount
			LDRB r6, [r5]
			ADD r6, r6, #1
			BL ADD10
			CMP r6, #21
			BNE SKIPP4
			
			BL NewLevel
			B FIQ_Exit
			
SKIPP4		STRB r6, [r5]
			
NOPE4		LDRB r4, [r3, #-1]!
			CMP r4, #0x45			;Ball
			BNE Not_ball3
			BL Blinking_RGB
			B FIQ_Exit
Not_ball3	CMP r4, #0x43			;Snake Ball
			BNE Not_sb3
			BL Blinking_RGB
			B FIQ_Exit
Not_sb3		CMP r4, #0x53			;Snake Ball
			BNE Not_snake3
			BL Blinking_RGB
			B FIQ_Exit

Not_snake3	MOV r4, #0x51                             
			STRB r4, [r3]
			LDR r4, =QBert
			STR r3, [r4]   
			B CHECK
			
CHECK	
													;
			MOV r4, #0								;
			LDR r5, =LegalTiles						;
NOTEQ		LDR r6, [r5], #4						;
			ADD r4, r4, #1							;This block checks if the tile that QBert moved to is in
			CMP r4, #22								;the Legal Tile list. If it isn't then we branch to QBert_Fell
			BGT NEXT99								;If it is then we branch to FIQ_Exit.
			CMP r3, r6								;
			BNE	NOTEQ								;

			LDR r3, =QBert_Moves					;
			MOV r2, #1								;Sets QBert_Moved to 1 so that he can't move again till the timer interrupt occurs
			STRB r2, [r3]							;

			B FIQ_Exit
											
NEXT99		BL Blinking_RGB							;
			B FIQ_Exit								;
		
TIMER0 		LDR r0, =0xE0004000
			LDR r1, [r0]			   ;Load memory from T0IR into r1
			TST r1, #2				   ;Check if Bit 1 is 1
			BEQ TIMER1				;If Bit 1 = 1 then Branch to FIQ_Exit
			
			LDR r3, =Blink_Flag			;
			LDRB r3, [r3]				;This Block checks if the Blinking RGB Flag register has been set 
			CMP r3, #1					;If the register has been set (=1) then the interrupt is ignored
			BEQ Blink					;

			BL Increment_Counter 

			LDR r3, =timer_counter
			LDRB r3, [r3]
			CMP r3, #120
			BNE CLEAR2

			BL ENDGAMEBONUS
			BL Game_Over
			B CLEAR2
			
Blink		LDR r3, =Blink_Color
			LDRB r4, [r3]
			CMP r4, #0
			BEQ Not_Red
			
			MOV r0, #3					;GREEN
			BL RGB_LEDs
			MOV r4, #0
			STRB r4, [r3]
			B Check_Blink_Count
			
Not_Red		MOV r0, #1					;RED
			BL RGB_LEDs
			MOV r4, #1
			STRB r4, [r3]
			
Check_Blink_Count
			LDR r3, =Blink_Count
			LDRB r4, [r3]
			CMP r4, #9
			BNE Not_Yet
			
			LDR r5, =Blink_Flag
			MOV r4, #0
			STRB r4, [r5]
			STRB r4, [r3]
			
			LDR r3, =QBert_Lives
			LDRB r3, [r3]
			CMP r3, #0
			BNE Still_Alive
			BL Game_Over
			B CLEAR2
Still_Alive BL QBert_Fell
			B CLEAR2

Not_Yet		ADD r4, r4, #1
			STRB r4, [r3]

CLEAR2  
			LDR r3, =0xE0004000            ;Load the T0IR register into r3
			LDR r1, [r3]                ;Load that into r1
			ORR r1, r1, #2                ;Clear Interrupt
			STR r1, [r3]                ;store that back into the T0IR register  
		
TIMER1 		LDR r0, =0xE0008000
			LDR r1, [r0]			   ;Load memory from T1IR into r1
			TST r1, #4				   ;Check if Bit 1 is 1
			BEQ FIQ_Exit				;If Bit 1 = 1 then Branch to FIQ_Exit 
			
			LDR r3, =Blink_Flag			;
			LDRB r3, [r3]				;This Block checks if the Blinking RGB Flag register has been set 
			CMP r3, #1					;If the register has been set (=1) then the interrupt is ignored
			BEQ CLEAR3					;

			LDR r3, =timer_counter		;
			LDR r3, [r3]				;This Block Checks if the timer is less than or equal to 2
			CMP r3, #2					;If it is Less than or Equal to 2 then no monsters are added to the board
			BLE No_monsters				;

			BL Move_Snake
			BL Check_SB
			BL Move_SB
			BL Add_Snake
			BL Check_Ball
			BL Move_Ball
			BL Add_Ball

No_monsters
			LDR r3, =QBert_Moves					;
			MOV r2, #0								;Sets QBert_Moved to 0 so that he can move again
			STRB r2, [r3]							;

			
			LDR r4, =refresh
            BL output_string
            LDR r4, =space2
            BL output_string
            LDR r4, =prompt3
            BL output_string
            LDR r4, =timecount
            BL output_string
            LDR r4, =space2
            BL output_string
            LDR r4, =prompt4
            BL output_string
            LDR r4, =score
            BL output_string
            LDR r4, =game
            BL output_string
		
CLEAR3  
			LDR r3, =0xE0008000            ;Load the T1IR register into r3
			LDR r1, [r3]                ;Load that into r1
			ORR r1, r1, #4                ;Clear Interrupt
			STR r1, [r3]                ;store that back into the T0IR register
			B FIQ_Exit  
FIQ_Exit   
			LDR r3, =Blink_Flag
		 	LDRB r3, [r3]
		 	CMP r3, #1
			BEQ No_Green

			LDR r3, =Pause_Flag
			LDRB r3, [r3]
			CMP r3, #1
			BEQ No_Green

			MOV r0, #3
			BL RGB_LEDs
No_Green			                            ;exit program
			LDMFD SP!, {r0-r12, lr}
			SUBS pc, lr, #4

Initialize_QBert
			STMFD sp!, {r0-r12,lr}

			LDR r2, =QBert
			LDR r3, =game
			
			MOV r4, #0x51
			STRB r4, [r3, #0x3b]!
			STR r3, [r2]

			LDMFD sp!, {r0-r12,lr}
			BX lr
		
Start_Q_Top
			STMFD sp!, {r0-r12,lr}
			
			LDR r2, =QBert
			LDR r3, =game
			
			MOV r1, #0x20				    ;
			LDR r4,[r2]						;Removes QBert from the location he fell from 
			STRB r1, [r4]					;
			
			MOV r4, #0x51				    ;
			STRB r4, [r3, #0x3b]!		    ; Move QBert to the top tile
			
			STR r3, [r2]					;Store QBert's new location in QBert
				
			
			LDMFD sp!, {r0-r12,lr}
			BX lr
			
SetTiles2
			STMFD sp!, {r0-r12,lr}
		
			MOV r2, #0	 		;Counter
			MOV r5, #0x2a
			LDR r3, =LegalTiles
		
DoItAgain2	LDR r4, [r3], #4
			STRB r5, [r4, #1]		
			ADD r2, r2,#1		;increment counter
			CMP r2, #21
			BNE DoItAgain2
		
			LDMFD sp!, {r0-r12,lr}
			BX lr

Clear_Board
			STMFD sp!, {r0-r12,lr}

			LDR r3, =LegalTiles
			MOV r6, #0					;
			MOV r5, #0x20				;
L00p		LDR r4, [r3], #4			; This Block Clears all characters that are on the legal tiles
			STRB r5, [r4]				;
			ADD r6, r6, #1				;
			CMP r6, #21					;
			BNE L00p					;


			MOV r4, #0					 	;
			LDR r3, =Number_of_Balls	 	;This Block Clears the Number of Balls 
			STRB r4, [r3] 				 	;

			LDR r3, =Snake_Ball			 	;This Block Clears the Snake Ball's Location  
			STR r4, [r3] 				 	;

			LDR r3, =Number_of_Snake_Ball	;This Block Clears the Number of Snake Balls 
			STRB r4, [r3] 				 	;

			LDR r3, =Number_of_Snakes		;This Block Clears the Number of Snakes 
			STRB r4, [r3] 					;

			LDR r3, =Snake					;This Block Clears the Snake's Location 
			STR r4, [r3] 					;

			LDMFD sp!, {r0-r12,lr}
			BX lr

Increment_Counter                              ;;;;;;;;;;;;;;;;;code to increase the score, needs to be added when checking for asterisk
            STMFD sp!, {r0-r12,lr}
            LDR r4, =timecount
            LDR r3, =timer_counter
            LDR r2, [r3]
            ADD r2, r2, #0x1
            STR r2, [r3]
            BL number_to_string2
            LDMFD sp!, {r0-r12,lr}
            BX lr

ADD10                              ;;;;;;;;;;;;;;;;;code to increase the score, needs to be added when checking for asterisk
            STMFD sp!, {r0-r12,lr}
            LDR r4, =score
            LDR r3, =score_reg
            LDR r2, [r3]
            ADD r2, r2, #0xA
            STR r2, [r3]
            BL number_to_string2
            LDMFD sp!, {r0-r12,lr}
            BX lr

LEVELBONUS
            STMFD sp!, {r0-r12,lr}
            LDR r4, =score
            LDR r3, =score_reg
            LDR r2, [r3]
            ADD r2, r2, #0x64           ;one hundy puntos
            STR r2, [r3]
            BL number_to_string2
            LDMFD sp!, {r0-r12,lr}
            BX lr

ENDGAMEBONUS                              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;this will check the number of LIVES REMAINING AND add 25 each time
            STMFD sp!, {r0-r12,lr}
        	LDR r4, =score
        	LDR r3, =score_reg
        	LDR r2, [r3]

			LDR r6, =QBert_Lives
			LDRB r6, [r6]

			MOV r5, #25
			MUL r6, r5, r6
			ADD r2, r2, r6
        	
        	STR r2, [r3]

        	BL number_to_string2
            LDMFD sp!, {r0-r12,lr}
            BX lr

			
NewLevel
		STMFD sp!, {r0-r12,lr}
		
		LDR r3, =Level		;
		LDRB r4, [r3]		;This block increments the
		ADD r4, r4, #1		;Level global variable
		STRB r4, [r3]		;

		MOV r0, r4            ;fixed the incrementing shit, needs to be in r0.
        BL display_digit
		
		BL Clear_Board
		BL SetTiles2
		BL Start_Q_Top

		BL LEVELBONUS            ;;;;;;;;;;;;;;;;;;;;;THIS ADDS 100 to the score

		CMP r3, #5
		BGT SKIPPP
		LDR r4, =0xE0008020		;MR2 Address
		LDR r5, [r4]
		LDR r6, =0x119400
		SUB r5, r5, r6
		STR r5, [r4]

SKIPPP
		LDR r3, =VisitedTileCount	;
		MOV r4, #0					;This block sets the Visited Tiles Count back to 0
		STRB r4, [r3]				;
		
		LDMFD sp!, {r0-r12,lr}
		BX lr
		
Blinking_RGB
		 STMFD sp!, {r0-r12,lr}	

		 LDR r3, =QBert_Lives	  ;
		 LDRB r4, [r3]			  ;Decrement QBert's Lives remaining by one
		 SUB r4, r4, #1			  ;
		 STRB r4, [r3]			  ;

		 BL DECREASELEDs
		 
		 LDR r3, =Blink_Flag
		 MOV r4, #1
		 STRB r4, [r3]
			
		 LDMFD sp!, {r0-r12,lr}
		 BX lr

QBert_Fell
		STMFD sp!, {r0-r12,lr}

		BL Clear_Board
		BL Start_Q_Top

		LDMFD sp!, {r0-r12,lr}
		BX lr

DECREASELEDs
        STMFD sp!, {r0-r12,lr}
        LDR r8, =LEDs_pattern
        LDRB r7, [r8]
        SUB r7, r7, #1
        STRB r7, [r8]
        CMP r7, #3
        BEQ IF3
        CMP r7, #2
        BEQ IF2
        CMP r7, #1
        BEQ IF1
        CMP r7, #0
        BEQ IF0            
                                        ;decrease life code here
IF3        MOV r0,#7                        
        BL LED_Dir                     ;
        BL LEDs
        B ISITGAMEOVER    

IF2        MOV r0,#3
        BL LED_Dir                     ;
        BL LEDs
        B ISITGAMEOVER

IF1        MOV r0,#1
        BL LED_Dir                     ;
        BL LEDs
        B ISITGAMEOVER

IF0        MOV r0,#0
        BL LED_Dir                     ;
        BL LEDs
        B ISITGAMEOVER

ISITGAMEOVER
        LDMFD sp!, {r0-r12,lr}
        BX lr

Game_Over  
		STMFD sp!, {r0-r12,lr}

		MOV r0, #5          ;changes RGB_LED state to purple
        BL RGB_LEDs
        LDR r4, =gameover    ;tells user game is over
        BL output_string

		LDR r4, =prompt4
        BL output_string
        LDR r4, =score
        BL output_string

INFINITY2	ADD r0, r0, #0	 ;Temporary Infinite loop for testing purposes
			B INFINITY2					 

		LDMFD sp!, {r0-r12,lr}
		BX lr

Add_Ball
			STMFD sp!, {r0-r12,lr}

			LDR r3, =0xE0004008		;T0TC Register
			LDR r3, [r3]

Not_10		LSR r3, #1				;Divide T0TC by 2

			CMP r3, #0xf
			BGT Not_10

			MOV r4, #0xa

			CMP r3, r4			   
			BLT NoBall			 ;CHANGED THIS

			LDR r5, =Number_of_Balls
			LDRB r6, [r5]
			
			CMP r6, #4				   ;Check if there are already 4 balls on the pyramid
			BGE NoBall 				   ;Branch if there are already 4

			LDR r7, =game

			MOV r4, #0xd
			CMP r3, r4
			BGE NextTile

			LDRB r8, [r7, #0x9a]!
			
			CMP r8, #0x51				;Check if QBert is on the tile
			BNE step
			BL Blinking_RGB				;MAKE THIS QBert_Died!!!!!!!!!!!!!!!!!!
			B NoBall

step		CMP r8, #0x4F				;Check if a ball is on that tile
			BEQ NoBall					 ;If a ball is on that tile already then go to NextTile

			CMP r8, #0x43				;Check if a Snake Ball is on the tile
			BEQ NoBall					;If a Snake ball is on that tile already then go to NextTile

			CMP r8, #0x53			    ;Check if a Snake is on the tile
			BEQ NoBall					;If a Snake is on that tile already then go to NextTile

			B AddBall
		
NextTile	LDRB r8, [r7, #0xed]!	   

			CMP r8, #0x51				;Check if QBert is on the tile
			BNE step0
			BL Blinking_RGB				;MAKE THIS QBert_Died!!!!!!!!!!!!!!!!!!
			B NoBall

step0		CMP r8, #0x4F				;Check if a ball is on that tile
			BEQ NoBall					 ;If a ball is on that tile already then go to NextTile

			CMP r8, #0x43				;Check if a Snake Ball is on the tile
			BEQ NoBall					;If a Snake ball is on that tile already then go to NextTile

			CMP r8, #0x53			    ;Check if a Snake is on the tile
			BEQ NoBall					;If a Snake is on that tile already then go to NextTile	
			
AddBall		
			ADD r6, r6, #1				;Increment Number of Balls currently on pyramid
			STRB r6, [r5]				;Store value back into Number of Balls register
			
			MOV r8, #0x4f 				;Add Ball to the tile
			STRB r8, [r7]				;
			
			LDR r9, =Balls
			MOV r10, #4
			SUB r6, r6, #1
			CMP r6, #0
			BLE NoOffset
NoOffset	MUL r11, r10, r6
	
			STR r7,[r9,+r11] 				

NoBall		LDMFD sp!, {r0-r12,lr}
			BX lr

Move_Ball
	   		STMFD sp!, {r0-r12,lr}

			LDR r3, =Number_of_Balls
			LDR r4, =Balls
			LDRB r3, [r3]

			CMP r3, #0
			BEQ TheEnd
			
			MOV r1, #0				;Initialize Counter

Do_It_Again	ADD r1, r1, #1			;Increment Counter
			LDR r5, [r4]
			BL Random_Ball_Move
			ADD r4, r4, #4

			CMP r1, r3
			BNE Do_It_Again			

TheEnd		LDMFD sp!, {r0-r12,lr}
			BX lr


Random_Ball_Move				  		;Inputs: r5= Current Ball Address and r4= Gloabl Ball Register
			STMFD sp!, {r0-r12,lr}	
			
			MOV r8, r4				;Save the Ball Global Register Address in r8

			LDR r3, =0xE0004008		;T0TC Register
			LDR r3, [r3]

Not10		LSR r3, #1				;Divide T0TC by 2

			CMP r3, #0xf
			BGT Not10

			MOV r4, #0x8

			CMP r3, r4
			BGT Move_Down
			B Move_Right

Move_Down 	
			STMFD sp!, {r3-r6}
			
			ADD r5, r5, #0xb2
			MOV r3, r5								;
			MOV r4, #0								;
			LDR r5, =LegalTiles						;
NOT_EQ		LDR r6, [r5], #4						;
			ADD r4, r4, #1							;This block checks if the tile that the ball moved to is in
			CMP r4, #22								;the Legal Tile list. If it isn't then the ball doesn't move
			BGT Dont_Move3							;
			CMP r3, r6								;
			BNE	NOT_EQ								;
			
			LDMFD sp!, {r3-r6}
			B Step2
Dont_Move3	LDMFD sp!, {r3-r6}
			B Dont_Move

			
Step2			
			LDRB r4, [r5, #0xb2]
			CMP r4, #0x51
			BNE NotQ
			BL Blinking_RGB  			;CHANGE THIS TO QBert_Died !!!!!!!!!!!!!!!!!!!!!
			BL Dont_Move
			
NotQ		CMP r4, #0x4F			  ;Check if the next tile already has a Ball
			BEQ Dont_Move

			CMP r4, #0x43			  ;Check if the next tile already has a Snake Ball
			BEQ Dont_Move

			CMP r4, #0x53			 ;Check if the next tile already has a Snake 
			BEQ Dont_Move
			
			MOV r4, #0x20
			STRB r4, [r5]				;Store SPACE the Tile the Ball is moving from
			
			MOV r4, #0x4F				;Move character for O into r4
			STRB r4, [r5, #0xb2]!		;Store O into the new tile
			
			STR r5, [r8]			;Store new Ball memory address in game in Global Ball Register
			
			B Dont_Move 			;Exit

Move_Right 	
			STMFD sp!, {r3-r6}
			
			ADD r5, r5, #0x5F
			MOV r3, r5								;
			MOV r4, #0								;
			LDR r5, =LegalTiles						;
NOT_EQ2		LDR r6, [r5], #4						;
			ADD r4, r4, #1							;This block checks if the tile that QBert moved to is in
			CMP r4, #22								;the Legal Tile list. If it isn't then we branch to QBert_Fell
			BGT Dont_Move2							;If it is then we branch to FIQ_Exit.
			CMP r3, r6								;
			BNE	NOT_EQ2								;
			LDMFD sp!, {r3-r6}
			B Step1
Dont_Move2	LDMFD sp!, {r3-r6}
			B Dont_Move

Step1		
			LDRB r4, [r5, #0x5F]		
			CMP r4, #0x51
			BNE NotQ2
			BL Blinking_RGB   			;CHANGE THIS TO QBert_Died !!!!!!!!!!!!!!!!!!!!!
			BL Dont_Move
			
NotQ2		CMP r4, #0x4F			  ;Check if the next tile already has a Ball
			BEQ Dont_Move

			CMP r4, #0x43			  ;Check if the next tile already has a Snake Ball
			BEQ Dont_Move

			CMP r4, #0x53			 ;Check if the next tile already has a Snake 
			BEQ Dont_Move
			
			MOV r4, #0x20
			STRB r4, [r5]				;Store SPACE the Tile the Ball is moving from

			MOV r4, #0x4F			;Move character for O into r4
			STRB r4, [r5, #0x5f]!			;Store O into the new tile
			
			STR r5, [r8]			;Store new Ball memory address in game in Global Ball Register


Dont_Move	LDMFD sp!, {r0-r12,lr}
			BX lr
			
Check_Ball	
			STMFD sp!, {r0-r12,lr}			
			
			LDR r0, =Balls
			LDR r3, =Number_of_Balls
			
			LDRB r12, [r3]					 

			CMP r12, #0				;Check to see if there are any balls on the pyramid. Exit SubRoutine if there aren't
			BEQ Finished

			MOV r1, #0				; Ball counter
Next_Ball	ADD r1, r1, #1			;Increment Counter
			LDR r6, =BottomTiles
			MOV r2, #0				;Counter		
			LDR r5, [r0], #4
					
NOTEQ2		LDR r8, [r6], #4						
			ADD r2, r2, #1								
			CMP r5, r8						
			BNE Not_In_List

			SUB r0, r0, #4			
			BL In_List
			B CHECK2

Not_In_List	CMP r2, #6
			BNE NOTEQ2
CHECK2		CMP r12, r1
			BEQ Finished
			B Next_Ball

Finished	LDMFD sp!, {r0-r12,lr}
			BX lr
			
In_List		
			STMFD sp!, {r0-r12,lr}
 
			LDRB r1, [r3]
			SUB r1, r1, #1
			STRB r1, [r3]

			MOV r9, #0x20
			STRB r9, [r5]

			MOV r9, #0
Repeat		STR r9, [r0]
			LDR r10, [r0, #4]!
			CMP r10, r9
			BEQ In_List_Exit
			STR r10, [r0, #-4]
			B Repeat

In_List_Exit LDMFD sp!, {r0-r12,lr}
			 BX lr

Add_Snake	
			STMFD sp!, {r0-r12,lr}

			LDR r3, =Number_of_Snake_Ball

			LDRB r4, [r3]
			MOV r5, #0x0
			CMP r4, r5
			BNE No_SB

			LDR r3, =0xE0004008		;T0TC Register
			LDR r3, [r3]

Not_F		LSR r3, #1				;Divide T0TC by 2

			CMP r3, #0xf
			BGT Not_F

			CMP r3, #0xc			   
			BLT No_SB			 ;CHANGED THIS

			

			LDR r4, =Number_of_Snake_Ball
			MOV r5, #0x1
			STRB r5, [r4]

			CMP r3, #0xe			   
			BGT Right_Tile

			LDR r4, =Snake_Ball
			LDR r5, =game
			ADD r5, r5, #0xED
			STR r5, [r4]

			MOV r3, #0x43
			STRB r3, [r5]
			B No_SB

Right_Tile	LDR r4, =Snake_Ball
			LDR r5, =game
			ADD r5, r5, #0x9a
			STR r5, [r4]

			MOV r3, #0x43
			STRB r3, [r5]
			

No_SB		LDMFD sp!, {r0-r12,lr}
			BX lr

Move_SB	
			STMFD sp!, {r0-r12,lr}

			LDR r3, =Snake_Ball

			LDR r4, [r3]
			MOV r5, #0x0
			CMP r4, r5
			BEQ No_SB2

			;Timer Shit
			LDR r3, =0xE0004008		;T0TC Register
			LDR r3, [r3]

Not_F2		LSR r3, #1				;Divide T0TC by 2

			CMP r3, #0xf
			BGT Not_F2

			CMP r3, #0x9			   
			BLT Go_Right			 ;CHANGED THIS


			LDR r3, =Snake_Ball
			MOV r5, #0x20
			STRB r5, [r4]
			MOV r5, #0x43
			STRB r5, [r4, #0xB2]!
			STR r4, [r3]
			B No_SB2


Go_Right	LDR r3, =Snake_Ball
			MOV r5, #0x20
			STRB r5, [r4]
			MOV r5, #0x43
			STRB r5, [r4, #0x5F]!
			STR r4, [r3]



No_SB2		LDMFD sp!, {r0-r12,lr}
			BX lr

Check_SB
			STMFD sp!, {r0-r12,lr}

			LDR r3, =Snake_Ball

			LDR r4, [r3]
			MOV r5, #0x0
			CMP r4, r5
			BEQ No_SB3

			LDR r5, =BottomTiles

			MOV r7, #0		 		;Counter
Repeat2		ADD r7, r7, #1			;Increment Counter
			LDR r6, [r5], #4		
			CMP r4, r6
			BNE Skipp
			
			BL Remove_SB
			B No_SB3

Skipp		CMP r7, #6
			BNE Repeat2

No_SB3		LDMFD sp!, {r0-r12,lr}
			BX lr

Remove_SB
			STMFD sp!, {r0-r12,lr}

			LDR r3, =Snake_Ball

			LDR r5, [r3]
			MOV r4, #0x53
			STRB r4, [r5]

			MOV r4, #0
			STR r4, [r3]

			LDR r3, =Snake
			STR r5, [r3]

			LDMFD sp!, {r0-r12,lr}
			BX lr

Move_Snake
			STMFD sp!, {r0-r12,lr}

			LDR r3, =Snake

			LDR r4, [r3]
			MOV r5, #0x0
			CMP r4, r5
			BEQ No_Snake

			LDR r2, =Snake_Surrounding_Tiles

			
			ADD r6, r4, #-0xb2			;Up
			STR r6, [r2], #4
			ADD r6, r4, #0xb2			;Down
			STR r6, [r2], #4
			ADD r6, r4, #-0x5F			;Left
			STR r6, [r2], #4
			ADD r6, r4, #0x5F			;Right
			STR r6, [r2], #-12

			LDR r8, =Legal_Snake_Surrounding_Tiles

			MOV r1, #0
NEXT_T		MOV r3, #0
			LDR r6, [r2], #4
			ADD r1, r1, #1
			LDR r4, =LegalTiles
Check_Again	ADD r3, r3, #1
			LDR r5, [r4], #4
			CMP r5, r6
			BNE	Skippp
			STR r6, [r8], #4
Skippp		CMP r3, #22				;DOUBLE CHECK THIS NUMBER
			BNE Check_Again
			CMP r1, #4						
			BNE NEXT_T

			;At this point the list should only have legal tiles in it

			LDR r3, =Legal_Snake_Surrounding_Tiles
			LDR r4, =QBert

			MOV r0, #0
			MOV r1, #-1
			LDR r2, =0x400000

			LDR r6, [r4]
Try_Again	LDR r5, [r3], #4
			ADD r1, r1, #1			;Increment Counter
			CMP r1, #4
			BEQ End_Loop 
			
			SUB r7, r6, r5
			CMP r7, #0
			BGE Not_NEG
			SUB r7, r7, #1
			MVN r7, r7

Not_NEG		CMP r7, r2
			BGE Try_Again
			MOV r2, r7	
			MOV r0, r1
			B Try_Again

End_Loop 	MOV r1, #4					
			MUL r3, r0, r1

			LDR r4, =Legal_Snake_Surrounding_Tiles
			LDR r5, [r4, r3]

			LDR r6, =Snake
			LDR r7, [r6]

			LDRB r10, [r5]			 ;
			CMP r10, #0x4F			 ;Check if the tile that the snake wants to move to has a ball or not.
			BEQ No_Snake2			 ;If it does then the snake will not move

			LDRB r10, [r5]			 ;
			CMP r10, #0x51			 ;Check if the tile that the snake wants to move to has QBert or not.
			BNE Not_QBert			 ;If it does then QBert died
			BL Blinking_RGB			 ;
			B No_Snake2				 ;

Not_QBert	MOV r8, #0x20
			STRB r8, [r7]

			MOV r8, #0x53
			STRB r8, [r5]

			STR r5, [r6]

No_Snake2
			MOV r3, #0				 ;
Repeat_this	MOV r5, #0				 ;
			STR r5, [r4], #4		 ;This Block Clears Legal_Snake_Surrounding_Tiles
			ADD r3, r3, #1			 ;
			CMP r3, #4				 ;
			BNE Repeat_this			 ;

No_Snake	LDMFD sp!, {r0-r12,lr}
			BX lr
			
			
		

InitializeLegalTiles
		STMFD sp!,{r2-r4, lr}
		LDR r2, =game
		LDR r3, =LegalTiles
		
		LDR r4, =0x3b
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4

		LDR r4, =0x9a
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0xf9
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x158
		ADD r2, r2, r4
		STR r2, [r3], #4 
		SUB r2, r2, r4
		
		LDR r4, =0x1b7
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x216
		ADD r2, r2, r4
		STR r2, [r3], #4 
		SUB r2, r2, r4
		
		LDR r4, =0xed
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x14c
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x1ab
		ADD r2, r2, r4
		STR r2, [r3], #4 
		SUB r2, r2, r4
		
		LDR r4, =0x20a
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x269
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x19f
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x1fe
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x25d
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x2bc
		ADD r2, r2, r4
		STR r2, [r3], #4 
		SUB r2, r2, r4
		
		LDR r4, =0x251
		ADD r2, r2, r4
		STR r2, [r3], #4 
		SUB r2, r2, r4
		
		LDR r4, =0x2b0		
		ADD r2, r2, r4		 
		STR r2, [r3], #4 	  
		SUB r2, r2, r4		   
		
		LDR r4, =0x30f
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x303
		ADD r2, r2, r4
		STR r2, [r3], #4 
		SUB r2, r2, r4
		
		LDR r4, =0x362
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x3b5
		ADD r2, r2, r4
		STR r2, [r3], #4 
		SUB r2, r2, r4
		
		
		LDMFD sp!, {r2-r4,lr}
		BX lr
		
InitializeBottomTiles
		STMFD sp!,{r2-r4, lr}
		LDR r2, =game
		LDR r3, =BottomTiles
		
		LDR r4, =0x216
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x269
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x2bc
		ADD r2, r2, r4
		STR r2, [r3], #4 
		SUB r2, r2, r4
		
		LDR r4, =0x30f
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x362
		ADD r2, r2, r4
		STR r2, [r3], #4
		SUB r2, r2, r4
		
		LDR r4, =0x3b5
		ADD r2, r2, r4
		STR r2, [r3], #4 
		SUB r2, r2, r4
		
		
		LDMFD sp!, {r2-r4,lr}
		BX lr
			
	END
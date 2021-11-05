	 ORG 800H  
	 LXI H,HELLO  
	 RST 3  
	 LXI H,FNUM  
	 RST 3  
	 RST 5  
	 MOV B,D  
	 MOV C,E  
CHOOSE  
	 LXI H,WHAT  
	 RST 3  
	 LXI H,WHAT1  
	 RST 3  
	 LXI H,WHAT2  
	 RST 3  
	 RST 2  
	 CPI '+' 		;Check if A contains '+' and change Flag registers  
	 JZ PLUS 		;Jumps to instruction if Zero bit == 1  
	 CPI '-' 		;Check if A contains '-' and change Flag registers  
	 JZ ASKNUMMIN  
	 CPI 'n' 		;Check if A contains 'n' and change Flag registers  
	 JZ NOT  
	 CPI 'e' 		;Check if A contains 'e' and change Flag registers  
	 JZ END  
NOTGOOD 			;if A does not contain '+','-','n' or 'e', program asks to reanswer  
	 LXI H,WRONG  
	 RST 3  
	 JMP CHOOSE 	   	;jump to instruction without condition  
PLUS  
	 LXI H,SNUM  
	 RST 3  
	 RST 5  
	 LXI H,RES0  
	 RST 3  
	 XCHG 			;exchange data in HL with DE  
	 DAD B 			;SUM HL and BC, if sum will occupy more than 4 positions(bits), Carry bit will be set to 1, if not, to 0  
	 CC SHIFT 		;Call(jump to) instruction SHIFT, if Carry bit == 1  
	 MOV A,H  
	 RST 4  
	 MOV A,L  
	 RST 4  
	 JMP END  
SHIFT  
	 MVI A,01H  
	 RST 4  
	 RET 			;Return to the line where instruction last time was called without condition  
ASKNUMMIN  
	 LXI H,SNUM  
	 RST 3  
	 RST 5  
	 LXI H,RES1  
	 RST 3  
MINUS  
	 STC 			;Sets Carry bit to one  
	 CMC 			;Negate Carry bit,...We make this just to set Carry bit to Zero(There is no instruction that can just set Carry bit to zero)  
	 MOV A,C  
	 SUB E 			;Subtract data from reg. A and specified reg., if second number is greater than first, Carry bit will be set to 1  
	 MOV L,A  
	 MOV A,B  
	 SBB D 			;Subtract data from reg. A and specified reg. icluding borrow(in Carry bit). Borrow can appear another time, it will be in Carry bit again  
	 MOV H,A  
	 JC BORROW 		;If there is Borrow (Carry bit == 1)jump to instruction BORROW  
	 MOV A,H  
	 RST 4  
	 MOV A,L  
	 RST 4  
	 JMP END  
BORROW 				;If this instruction was executed, that means that result will be negative  
	 MOV H,B 		;In that case we should exchange data in first number with second number  
	 MOV L,C 		;and subtract: second_num - first_num, with adding '-' at the beginning  
	 MOV B,D  
	 MOV C,E  
	 XCHG  
	 MVI A,'-'  
	 RST 1  
	 JMP MINUS  
NOT  
	 LXI H,RES2  
	 RST 3  
	 MOV A,B  
	 CMA 			;NEGATE register A  
	 RST 4  
	 MOV A,C  
	 CMA  
	 RST 4  
END 	 
	 LXI H,KON  
	 RST 3  
	 HLT  
HELLO 	 DB 'Calculator@'                                  
FNUM 	 DB 10,13,'Enter first number: @'                                  
SNUM 	 DB 10,13,'Enter second number: @'                                 
WHAT 	 DB 10,13,'Choose operation:  @'                                 
WHAT1 	 DB 10,13,'+:Plus, -:Minus, n:Negation@'        
WHAT2 	 DB 10,13,'e:exit:   @'                       
RES0 	 DB 10,13,'Sum: @'                                 
RES1 	 DB 10,13,'Difference: @'                                 
RES2 	 DB 10,13,'Negation: @'    
WRONG 	 DB 10,13,'Wrong operation, try again@'                             
KON 	 DB 10,13,'END@'                   

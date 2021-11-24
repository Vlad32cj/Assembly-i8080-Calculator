# Intel 8080 Assembly calculator

### Hello
This program was created to understand how conditional jumps and arithmetic operations(for four-digit hexadecimal numbers) work in Assembler i8080.
Possible operations: addition, subtraction and logical negation.

It is desirable to use step-by-step execution (debugger).

I have used "Symulator MCS-8".

The code contains commands of a specific simulator, such as:
- RST1 - Print character from register A to the console.
- RST2 - Write a character from the keyboard to the accumulator register.
- RST3 - Printing to the console a string from memory from HL register to '@'.
- RST4 - Print two hexadecimal characters(numbers) from the accumulator register to the console.
- RST5 - Keyboard entry of four hexadecimal characters to the DE register.

If necessary, change these instructions to adapt code for your simulator or remove them(the result will be in HL register or in BC register(only for negation)).

Using the program is quite simple, as it assures the prompts at every step and comments.

=========================================================================

Good luck to everyone in learning programming.

P.S. Learning any programming language is not superfluous

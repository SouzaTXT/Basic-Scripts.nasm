# Basic-Scripts.nasm 
Once again, I'm here with a new project!

This time, the idea was based on some exercises from my computer architecture class. (They aren't complex scripts, but they served as a great gateway for me to learn more about NASM, which I hope to work with more in the future). 😁

+ ⚠ This summary will only serve as a way to explain what each script does. In addition to it, there are also some comments within the code that can help in understanding the structure.

<h1>EXERCISE 1 – OPERATIONS WITH ALU</h1>

The purpose of this first script was to add two numbers stored in registers. After that, the second number was subtracted from the first. When done, the previous results were multiplied and divided.
All results are stored in the variables ```resultado_soma```, ```resultado subtracao```, ```resultado_divisao```, and ```resultado_multiplicacao``` inside of the data section.

``` asm
section .data
    resultado_soma: DQ 0
    resultado_subtracao: DQ 0
    resultado_multiplicacao: DQ 0
    resultado_divisao: DQ 0
```

<h1>EXERCISE 2 – LOGICAL OPERATIONS</h1>

The idea behind this algorithm is to compare a binary number in a register (in this case, the number ```0b10101010``` or 170 in decimal).

The operations were performed using the comparators: 

``` asm
AND, OR, XOR, NOT
```

<h1>EXERCISE 3 – COMPARISON AND DEVIATIONS</h1>

Now the idea is to compare two values using the commands and, at the end, display whether the commands are equal, the first value is greater, or the second value is greater.

``` nasm
JE - ; Jump if Equal
JNE - ; Jump if Not Equal
JG - ; Jump if Greater
JL - ; Jump if Less
```

<h1>EXERCISE 4 – DECISION STRUCTURE (IF)</h1>
The idea of the code is just to write these lines of code and implement it through assembly.
<br>
<br>

``` javascript
if (a < b)
  result = a - b
else
  result = b - a
```

<h1>EXERCISE 5 – LOOP (REPEAT STRUCTURE)</h1>
This script briefly writes a program that adds up all numbers from 1 to 10 using a loop structure.
<br>
<br>

``` asm
.loop:
    add eax, ecx
    loop .loop 
```

<h1>EXERCISE 6 – MINI-CALCULATOR IN ASSEMBLY</h1>
Finally, the last program asks the user for two numbers. When entered, the program performs the four basic operations (+, -, *, /) and displays the results on the screen.
<br>
<br>

![layout example](https://github.com/user-attachments/assets/782d9b6d-09f6-4c2f-9c7e-c7ea02e535d0)

I ended up extending the README quite a bit, but I hope it was a good read and that I somehow shared something cool with you.
Thank you very much for your attention, see you next time! 🤍

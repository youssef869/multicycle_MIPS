# Introduction
The multicycle processor addresses weaknesses of single-cycle one by breaking an instruction into multiple shorter steps. In each short step, the processor can read or write the memory or register file or use the ALU. Different instructions use different numbers of steps, so simpler instructions can complete faster than more complex ones. The processor needs only one adder; this adder is reused for different purposes on various steps. And the processor uses a combined memory for instructions and data. The instruction is fetched from memory on the first step, and data may be read or written on later steps.

# Implementation 
 ## Data Path
 
![image](https://github.com/user-attachments/assets/46d9a0ff-d31d-4584-8910-5fcb9c24b173)

## Control Unit

![image](https://github.com/user-attachments/assets/675ae482-1aea-4741-b5dd-104b39a81789)

## FSM (main controller)

![image](https://github.com/user-attachments/assets/0cc93dc3-8b05-4065-8724-121f3b1be3b0)

## ALU decoder

![image](https://github.com/user-attachments/assets/bf669e94-3033-4f13-a29d-9983332b3717)


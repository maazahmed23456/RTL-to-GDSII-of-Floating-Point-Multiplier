# Floating-Point-Multiplier
Design of a multiplier architecture that operates upon IEEE 754 single precision floating point numbers

## A Glance at the BIST Architecture

A Floating-Point (FP) Multiplier is a crucial component in digital systems requiring high-performance arithmetic operations, such as digital signal processing, machine learning, and graphics processing. In VLSI design, an FP multiplier is implemented to perform multiplication of two floating-point numbers, adhering to the IEEE 754 standard. The architecture typically involves three stages: exponent addition, mantissa multiplication, and normalization. Exponent addition handles the biased exponents, while mantissa multiplication uses high-speed techniques like Wallace tree or Booth encoding to optimize the hardware and reduce critical path delay. The normalization stage ensures the result conforms to the IEEE standard by aligning the decimal point. Designing an efficient FP multiplier in VLSI requires optimizing trade-offs between power, performance, and area (PPA), making it a challenging task. Advanced techniques, such as pipelining, clock gating, and approximate computing, are often employed to enhance throughput and energy efficiency in modern ASIC or FPGA implementations.

- Sign Logic
- Exponent Adder
- Mantissa Multiplier
- Normalization
- Exceptions handler

## Base Paper

This project was inspired by the work of following paper, who designed a BIST architecture for a Carry Select Adder, refer to the following paper:

Solanki, Garima & Agarwal, Sourav & Mishra, Tushar & Khandelwal, Vansh. (2024). Design and Implementation of BIST logic for High Speed and Energy Efficient Carry Select Adder(CSLA). 1-5. 10.1109/ICSTSN61422.2024.10670853. 


## Block Diagram of BIST 

 <p align="center">
  <img width="800" height="500" src="/BIST SCHEMATICS AND WAVEFORMS/BLOCK.jpg">
</p>


## Schematic of BIST without fault

 <p align="center">
  <img width="800" height="500" src="/BIST SCHEMATICS AND WAVEFORMS/WITHOUT FAULT SCHEMATIC.png">
</p>

This module is used to generate the signature

## Simulation of BIST without fault

 <p align="center">
  <img width="800" height="500" src="/BIST SCHEMATICS AND WAVEFORMS/WITHOUT FAULT SIMULATION.png">
</p>

After 2^n - 1 clock cycle which in this case is 2047 , the **Signature** is obtained as **13** in hexadecimal

## Schematic of BIST with fault

 <p align="center">
  <img width="800" height="500" src="/BIST SCHEMATICS AND WAVEFORMS/WITH FAULT SCHEMATIC.png">
</p>

In this module SA0 fault is modelled at a input in the schematic

## Simulation of BIST with fault

 <p align="center">
  <img width="800" height="500" src="/BIST SCHEMATICS AND WAVEFORMS/WITH FAULT SIMULATION.png">
</p>

- We can observe that after inserting a SA0 at a input , the obtained signature value **27** doesnt match with the golden signature **13**
- This shows the presence of fault in the CSA which needs to be corrected. 


***************



## Future Work

- Design similar BIST architecture for any other arithmetic modules which can be done just by replacing the CSA module and adjusting the input sizes

## Contributors 

- **Maaz Ahmed**  

## Acknowledgments


- Dr.Ediga Raghuveera , AdHoc Faculty , NIT AP (mentor)
- Dr.Kiran Kumar Gurrala , Assistant Professor , NIT AP
- Dr.Puli Kishore Kumar , Assistant Professor , NIT AP
- Harika Banala , PhD , NIT AP

## Contact Information

- Shaik Maaz Ahmed , maazahmed23456@gmail.com




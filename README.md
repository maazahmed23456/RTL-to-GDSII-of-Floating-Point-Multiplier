# Floating-Point-Multiplier
Design of a multiplier architecture that operates upon IEEE 754 single precision floating point numbers

## A Glance at the FP Multiplier Architecture

A Floating-Point (FP) Multiplier is a crucial component in digital systems requiring high-performance arithmetic operations, such as digital signal processing, machine learning, and graphics processing. In VLSI design, an FP multiplier is implemented to perform multiplication of two floating-point numbers, adhering to the IEEE 754 standard. The architecture typically involves three stages: exponent addition, mantissa multiplication, and normalization. Exponent addition handles the biased exponents, while mantissa multiplication uses high-speed techniques like Wallace tree or Booth encoding to optimize the hardware and reduce critical path delay. The normalization stage ensures the result conforms to the IEEE standard by aligning the decimal point. Designing an efficient FP multiplier in VLSI requires optimizing trade-offs between power, performance, and area (PPA), making it a challenging task. Advanced techniques, such as pipelining, clock gating, and approximate computing, are often employed to enhance throughput and energy efficiency in modern ASIC or FPGA implementations.

- Sign Logic
- Exponent Adder
- Mantissa Multiplier
- Normalization
- Exceptions handler

## Base Paper

This work was referred from architectures proposed in the following paper -:

A. Y. N J and A. V R, "FPGA Implementation of a High Speed Efficient Single Precision Floating Point ALU," 2023 International Conference on Control, Communication and Computing (ICCC), Thiruvananthapuram, India, 2023, pp. 1-5, doi: 10.1109/ICCC57789.2023.10165441. keywords: {Power demand;Program processors;Simulation;Computer architecture;Dynamic range;Hardware;Hardware design languages;IEEE 754;ALU;FPGA;RISC V ISA;Exceptions},


## Block Diagram of the FP Multiplier 

 <p align="center">
  <img width="500" height="500" src="/SCHEMATIC AND WAVEFORMS/BLOCK.png">
</p>


## Schematic of the FP Multiplier

 <p align="center">
  <img width="800" height="500" src="/SCHEMATIC AND WAVEFORMS/SCHEMATIC.png">
</p>


## Simulation of the FP Multiplier

 <p align="center">
  <img width="800" height="500" src="/SCHEMATIC AND WAVEFORMS/SIMULATION.png">
</p>

- The 0 - 10 ns for normal multiplication operation
- The 10 - 50 ns for showing various exception modelled
- The 50 - 60 ns for multiplication with negative number


## Power Summary of the FP Multiplier

 <p align="center">
  <img width="800" height="500" src="/SCHEMATIC AND WAVEFORMS/POWER SUMMARY.png">
</p>

The logic which is the multiplier module consume a power of 0.555 watts 

## Resource Utilization of the FP Multiplier

 <p align="center">
  <img width="800" height="500" src="/SCHEMATIC AND WAVEFORMS/RESOURCE UTILIZATION.png">
</p>

It shows the FP Multiplier was synthesiszed by ustilisation of only 59 LUT and 2 DSP and 99 I/O ports which is fair utilization.

***************



## Future Work

- Design the division , adder and subtractor modules in similar floating point operation
- Integrate all the modules into a Floating Point ALU with opcode and clock for operation at highest frequency possible
- Perform the RTL to GDS flow of the FP ALU in Cadence or Synopsys EDA Tools or Openlane ASIC Flow
- Fabricate the chip for real time testing

## Contributors 

- **Maaz Ahmed**  

## Acknowledgments

- Dr.Ediga Raghuveera , AdHoc Faculty , NIT AP (mentor)
- Dr.Kiran Kumar Gurrala , Assistant Professor , NIT AP
- Dr.Puli Kishore Kumar , Assistant Professor , NIT AP
- Harika Banala , PhD , NIT AP

## Contact Information

- Shaik Maaz Ahmed , maazahmed23456@gmail.com




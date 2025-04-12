# aspir - Optical Tranceiver

This is a capstone project from University of Waterloo, ECE 2025. Not all the source files from the original project is included in this repository. The FPGA portion is posted here for anyone who wants to implement their own BPSK modem to use as a starting point. Note that the modem was never tested on an FPGA, I didn't have enough time to finish. 
This repository contains Matlab simulation of BPSK modulation/demodulation, as well as a simulated Verilog modem, using Vivado 2019.1.<br>
The original testing platform was Windows 11, thus the startup scripts were written in powershell syntax. Howeve a GNU makefile is also included (might be outdated) and the tcl project creation file should be usable on either OS platform.<br>
All valuable content are in `fpga/gui_mode`, ignore `fpga/script_mode` that's the non graphical project flow with Vivado, very outdated. The BPSK Modem verilog code are in `fpga/gui_mode/ip/bpsk`.<br>
You may also take a look at `Modelling/bpsk/bpsk_modem.m` for a Matlab simulation file.
If you have any questions, please message me on [linkedin](https://www.linkedin.com/in/anderson-hsieh-6003a41ba) or email andy13579246810@gmail.com
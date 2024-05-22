### Installation Prerequisites
- [Vivado 2023.2](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2023-2.html)
- [GNU make for windows](https://gnuwin32.sourceforge.net/packages/make.htm)
- Make sure you have a git's bin folder in your path cuz GNU Make uses sh.exe as its default shell, and we'll need all the basic linux commands

### How To Run And Build
```
make compile
make program_fpga RUN=<timestamp>

```
note if variable RUN is not defined the sciprt will default to the newest run which has the timestamp in `/output/timstamp.txt`
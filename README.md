# EnergiaAssemblyUploader
Command line Batch files (Windows) and makefile (Mac) for uploading assembly code to the MSP430 LaunchPad using the MSP-GCC Toolchain that comes with Energia

To use these files you will need to install Energia on your machine. Please follow the instructions http://energia.nu/Guide_index.html

To test your Energia installation make sure you can compile and upload the Blink example that can be found in file>examples>basic. If successful the LED on the board should be blinking.

To assemble and program the example assembly file blink.S you will need to download and save to the same folder blink.S, make.bat, upload.bat for windows or blink.S and makefile for Mac OS.

You will need to open the make and upload or makefile and edit the path to the path where you installed Energia on your computer.

To assemble and upload on Windows:

Plug in the MSP430 Lauchpad to a USB port.
Start the command window.
cd to the directory that you saved the files in.
Run the assemble file by entering make to assemble the code.
Run the batch file entering upload to upload the code to the MSP430.

To assemble and upload on Mac OS:

Plug in the MSP430 Lauchpad to a USB port.
Start terminal.
cd to the directory that you saved the files in.
To assemble the code run the makefile file by entering: make
Upload the assembled code by entering: make upload

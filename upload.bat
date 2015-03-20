setlocal
set PathName=C:\energia-0101E0011\hardware\tools\msp430\
set Target=Blink

set MSPDebugPath=%PathName%mspdebug\mspdebug

%MSPDebugPath% tilib --force-reset "prog %Target%.elf"

setlocal
set PathName=C:\energia-0101E0011\hardware\tools\msp430\
set Target=Blink

set GCCPath=%PathName%bin\
set IncludePath=%PathName%msp430\include\

%GCCPath%msp430-gcc -mmcu=msp430g2553 -Wall -Os -I %IncludePath%   -c -o %Target%.o %Target%.S
%GCCPath%msp430-gcc -mmcu=msp430g2553 -Wall -Os -I %IncludePath% %Target%.o -Wl,-Map,%Target%.map -nostdlib -nostartfiles -o %Target%.elf
%GCCPath%msp430-objdump -z -EL -D -W %Target%.elf >%Target%.lss
%GCCPath%msp430-size %Target%.elf
%GCCPath%msp430-objcopy -O ihex %Target%.elf %Target%.hex
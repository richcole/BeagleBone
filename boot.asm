# UART base locations from the TRM
.equ UART0.BASE,        0x44e09000        
.equ UART3.BASE, 		0x481a6000

 
# We need to be in ARM mode - we may branch to Thumb mode later if desired.
.arm
_start:
   ldr r0,=0x44e09000
   ldr r1,=0x21     
   strb r1,[r0]
_hang:
   b _hang
        
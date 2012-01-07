.arm
_start:
   ldr r0,=0x44e09000
   ldr r1,=0x21     
   strb r1,[r0]
_hang:
   b _hang
        
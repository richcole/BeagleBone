void main() {
  char* serial_port = (char *)0x44e09000;
  *serial_port = '!';

  // hang
  while(1);
}

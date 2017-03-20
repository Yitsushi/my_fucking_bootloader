.code16
.text
  .globl _start;

_start:
  jmp _init
  instruction: .asciz "Press any key to start this fucking awesome system :)\r\n"
  name: .asciz "GOSXP 0.1 Alpha\r\n"

  .macro printString str
    leaw \str, %si
    call .printStart
  .endm

  .printStart:
    lodsb
    orb  %al, %al
    jz   .printEnd # finish
    # print char
    movb $0x0e, %ah
    int  $0x10
    jmp  .printStart # next chat
  .printEnd:
  ret

_init:
  printString instruction

  # wait for a key
  xorw %ax, %ax
  int $0x16

  # Color the next line
  movb $0x09, %ah
  movb $0x00, %bh
  movb $0x03, %bl # cyan
  mov $0x1c, %cx  # number of characters
  int $0x10

  printString name

  . = _start + 510     # 512 blocksize

  # Boot Signature => must be at byte 511 and 512
  .byte 0x55
  .byte 0xaa

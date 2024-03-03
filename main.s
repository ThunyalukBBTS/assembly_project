global _start
section .data
    a           db  66
    b           db  7

extern  calculate_remainder
extern  print_num
extern  print_string


section .text
_start:
    mov     rdx, 0          ; clear reg edx for remainder
    movzx   rax, byte [a]   ; set divide variable into register rax, rbx then div
    movzx   rbx, byte [b]
    div     rbx
    movzx   rdi, byte [b]
    mov     rsi, rdx
    mov     rdx, rax
    call    calculate_remainder

last:
    mov     rax, 60
    mov     rdi, 0
    syscall

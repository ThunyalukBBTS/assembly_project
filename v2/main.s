global _start
extern div_result
section .data
    a           db  66
    b           db  7

section .text
_start:
    mov     rdx, 0          ; clear reg edx for remainder
    movzx   rax, byte [a]   ; set divide variable into register rax, rbx then div
    movzx   rbx, byte [b]
    div     rbx ; rax = a/b, rdx = a%b
    call    div_result

last:
    mov     rax, 60
    mov     rdi, 0
    syscall
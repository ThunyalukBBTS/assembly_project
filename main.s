global _start
section .data
    a           db  66
    b           db  7
    result      dw  0
    rem         db  0
    dot         db ".",0
extern  calculate_remainder
extern  print_string

section .text
_start:
    mov     rdx, 0          ; clear reg edx for remainder
    movzx   rax, byte [a]   ; set divide variable into register rax, rbx then div
    movzx   rbx, byte [b]
    div     rbx ; rax = a/b, rdx = a%b

    ; convert result in rax to string then print
    add     rax, '0'
    mov     word [result], ax
    mov     byte [rem], dl
    mov     rdi, result
    call    print_string

    ; print "."
    mov     rdi, dot
    call    print_string

    ; forward rem and denominator to calculate_remainder func
    movzx   rdi, byte [b]
    movzx   rsi, byte [rem]
    mov     rdx, rax
    call    calculate_remainder

last:
    mov     rax, 60
    mov     rdi, 0
    syscall
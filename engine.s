section .data
    num_to_print db "0"
    rem         db 0
    denominator db 0
section .text
; argument 1 (rdi) : denominator
; argument 2 (rsi) : remainder

; r10 : loop counter
; r11 : temp
; r12 : denominator
; r13 : constant 10

global  calculate_remainder
extern print_string
calculate_remainder:
    ; save previous data in register to use into stack
    push    rcx
    push    rdx     
    push    r10
    push    r12
    push    r13
    push    r14

    mov     [rem], rsi
    mov     [denominator], rdi

    movzx   rax, byte [rem]
    mov     r10, 4  ; set loop counter to 4 round
    mov     r12, [denominator]
    mov     r13, 10

my_loop:
    ; calculate (rem*10)/(denominator)
    mul     r13
    div     r12
    mov     [rem], rdx
    add     rax, '0'
    mov     byte [num_to_print], al
    mov     rdi, num_to_print
    call    print_string
    movzx   rax, byte [rem]
    dec     r10
    cmp     r10, 0
    jne     my_loop
    jmp     end_of_process

end_of_process:
    mov     rax, 0
    ; restore data back to register
    pop     r14
    pop     r13
    pop     r12
    pop     r10
    pop     rdx
    pop     rcx
    ret
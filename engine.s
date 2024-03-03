section .data
    NULL    equ 0
    LF    equ 10
    num_to_print db "0"
    rem         db 0
    result      db "0"
    point       db '.',NULL
    newLine     db LF,NULL
    denominator db 0
section .text
; argument 1 (rdi) : denominator
; argument 2 (rsi) : remainder
; argument 3 (rax) : remainder

; rcx : loop counter
; r11 : temp
; r12 : total value of reminder
; r13 : forward remainder

global  calculate_remainder
extern print_string
calculate_remainder:
    ; save previous data in register to use into stack
    push    rcx
    push    rdx     
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14

    mov     [rem], rsi
    mov     [denominator], rdi

    add     rdx, '0'
    mov     byte [result], dl
    mov     rdi, result
    call    print_string

    mov     rdi, point
    call    print_string

    ; mov     rdi, newLine
    ; call    print_string

    movsx     rax, byte [rem]
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
    movsx   rax, byte [rem]
    dec     r10
    cmp     r10, 0
    jne     my_loop
    jmp     end_of_process

end_of_process:
    mov     rdi, newLine
    call    print_string
    mov     rax, 0
    ; restore data back to register
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     rdx
    pop     rcx
    ret
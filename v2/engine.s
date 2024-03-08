section .data
    result      db 0
    remainder   db 0
    divisor     db 0
    string_to_print db 0,0
    dot         db '.',0
section .text
global  div_result
extern  print_string
div_result:
    ; save result and remainder to memory
    mov     byte [result], al
    mov     byte [remainder], dl
    mov     byte [divisor], bl
    ; print result first
    add     rax, '0'; convert int to string
    mov     byte [string_to_print], al
    ; send address to print function
    mov     rdi, string_to_print
    call    print_string
    ; print dot "."
    mov     rdi, dot
    call    print_string

    push    r12 ; clear r12 for count digit
    push    r10 ; clear r10 for set to constant number 10
    push    r13 ; clear r13 for temporary divisor
    mov     r12, 4
    mov     r10, 10
    movzx   r13, byte [divisor]
    movzx   rax, byte [remainder]
calculate_remainder_loop:
    ; calculate (rem*10)/(divisor)
    mul     r10 ; rax = rax * 10
    div     r13
    mov     [remainder], rdx  ; save remainder to memory
    add     rax, '0' ; convert to string
    mov     [string_to_print], rax
    ; send remainder to print one by one digit
    mov     rdi, string_to_print
    call    print_string
    ; move next remainder to prepare next calculate loop
    movzx   rax, byte [remainder]
    dec     r12
    cmp     r12, 0
    jne     calculate_remainder_loop

end_of_process:
    ; restore data back to register
    pop     r13
    pop     r10
    pop     r12
    ret

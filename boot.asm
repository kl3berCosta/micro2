[BITS 16]
[ORG 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov si, msg_loading
    call print
    call load_kernel
    mov si, msg_success
    call print

    mov ah, 0x0E
    mov al, 'X'
    int 0x10

    jmp 0x1000

load_kernel:
    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0x80
    mov bx, 0x1000
    int 0x13
    jc error_load
    ret

print:
    mov ah, 0x0E
.loop:
    lodsb
    or al, al
    jz done
    int 0x10
    jmp .loop
done:
    ret

error_load:
    mov si, msg_error
    call print
    jmp $

msg_loading db 'Carregando Kernel...', 0
msg_success db 'Kernel carregado com sucesso!', 0
msg_error   db 'Erro ao carregar o Kernel!', 0

times 510-($-$$) db 0
dw 0xAA55

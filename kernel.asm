[BITS 16]

global _start
global print

_start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x1000
    sti

    mov si, msg_kernel
    call print
    call initialize_fs
    hlt

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

msg_kernel db 'Kernel carregado e rodando!', 0

extern initialize_fs

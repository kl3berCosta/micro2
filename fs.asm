[BITS 16]

global initialize_fs
extern print

initialize_fs:
    mov si, msg_fs_init
    call print
    ret

superblock:
    total_blocks  dd 1024
    free_blocks   dd 900
    inode_bitmap  dd 0x2000
    block_bitmap  dd 0x3000
    inode_start   dd 0x4000

read_block:
    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 10   ; Agora lê a partir do setor 10
    mov dh, 0
    mov dl, 0x80
    mov bx, 0x5000
    int 0x13
    jc error_read
    ret

error_read:
    mov si, msg_fs_error  ; Agora aponta corretamente para a mensagem de erro
    call print
    ret

msg_fs_init  db 'FS inicializado!', 0
msg_fs_error db 'Erro ao ler bloco!', 0

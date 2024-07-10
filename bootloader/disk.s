struc DiskAddressPacket sectors, buffer, buffer_segments, lba
{
    packet_size: db 0x10  
    res: db 0x0
    sects: dw sectors
    buffer_offst: dw buffer
    buff_seg: dw buffer_segments
    lbai: dq lba
}


; Macro to read disk
; [in] DiskAddressPacket
; [in] DriveNumber (ex. 0x80)
macro read_disk DAP*, DriveNum*
{
    mov si, DAP
    mov ah, 0x42
    mov dl, DriveNum
    int 0x13
    jc DiskFailure
    
}

DiskFailure:
    puts dap_transfer_err
    failure 'D'

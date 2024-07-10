jmp short _start
nop

bdb_oem:                    db 'MSWIN4.1'           ; 8 bytes
bdb_bytes_per_sector:       dw 512
bdb_sectors_per_cluster:    db 1
bdb_reserved_sectors:       dw 4
bdb_fat_count:              db 2
bdb_dir_entries_count:      dw 512
bdb_total_sectors:          dw 60544                ; 31 MB
bdb_media_descriptor_type:  db 0F8h                 ; F8 = HDD
bdb_sectors_per_fat:        dw 60                   
bdb_sectors_per_track:      dw 32
bdb_heads:                  dw 4
bdb_hidden_sectors:         dd 0
bdb_large_sector_count:     dd 0

; extended boot record
ebr_drive_number:           db 0x80                 ; 0x00 floppy, 0x80 hdd, useless
                            db 0                    ; reserved
ebr_signature:              db 29h
ebr_volume_id:              db 12h, 34h, 56h, 78h   ; serial number, value doesn't matter
ebr_volume_label:           db 'LOLOLLOL OS'        ; 11 bytes, padded with spaces
ebr_system_id:              db 'FAT16   '           ; 8 bytes

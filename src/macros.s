; macros.s - set of macros for the bootloader
; Copyright (C) 2019  Bruno Mondelo

; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.

if ~ defined macros

define macros

macro init {
    cli                             ; disable interrupts
    mov [drive], dl                 ; save the drive we booted on
    xor cx, cx                      ; clear cx
    mov ax, cx                      ; clear ax
    mov ds, ax                      ; clear ds
    mov es, ax                      ; clear es
    mov ss, ax                      ; clear ss
    mov sp, 0x7c00                  ; set stack that growns down
    cld                             ; clear direction flag
    sti                             ; enable interrupts
}
; initialises the segments

macro reset_disk {
    mov dl, [drive]                 ; drive to reset
    xor ax, ax                      ; subfunction 0
    int 0x13                        ; call interrupt 13h
    jc fail                         ; go to error if carry set
}
; resets the disk system

macro reboot {
    puts rebootmsg                  ; shows reboot message
    xor ax, ax                      ; subfunction 0
    int 0x16                        ; call interrupt 16h

    db 0xea                         ; machine language to jump to ffff:0000
    dw 0x0000
    dw 0xffff
}
; reboots the machine

macro halt {
halt:
    jmp halt
}
; halts the machine

macro puts str* {
    lea si, [str]                   ; loads message address into si
    call write_string               ; shows the message
}
; puts a string

include 'functions.s'

end if

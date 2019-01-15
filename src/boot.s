; boot.s - first stage boot loader
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

format elf64
use16
section '.text'
org 0x7c00

main:
    jmp short start
    nop

include 'bootsector.s'
include 'macros.s'

start:
    init                            ; initialises the segments
    reset_disk                      ; reset disk system
    puts hellomsg                   ; shows loading message
    reboot
    halt                            ; set the system to halt

fail:
    puts diskerrormsg               ; shows error message
    reboot                          ; reboots the system

hellomsg db "welcome to ori loader!", 13, 10, 0
diskerrormsg db "fatal disk error.", 13, 10, 0
rebootmsg db "press any key to reboot...", 0

times 510-($-$$) db 0
bootmagic:
    db 0x55
    db 0xaa

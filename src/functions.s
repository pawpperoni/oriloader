; functions.s - set of functions for the bootloader
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

if ~ defined functions

define functions

write_string:
    lodsb                           ; load byte at ds:si into al
    or al, al                       ; check if it's null
    jz write_string_done            ; jump to the end

    mov ah, 0x0e                    ; subfunction 0x0e
    mov bx, 9                       ; set page to 0 and attribute to white
    int 0x10                        ; call interrupt 10h

    jmp write_string                ; repeat for next character

write_string_done:
    ret                             ; return to caller

end if

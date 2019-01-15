; bootsector.s - defines the FAT12 bootsector
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

bootsector:
    oem db "orider  "               ; OEM string
    size_sector dw 0x200            ; size of a sector in bytes
    size_cluster db 1               ; size of a cluster in sectors
    reserved_sectors dw 1           ; number of reserved sectors
    fat_count db 2                  ; number of FATs
    size_root_dir dw 224            ; size of a root directory in entries
    sectors dw 2880                 ; total number of sectors
    media db 0xf0                   ; media descriptor
    size_fat dw 9                   ; size of FAT in sectors
    size_track dw 9                 ; size of a track in sectors
    heads dw 2                      ; number of heads
    hidden_sectors dd 0             ; total number of hidden sectors
    sectors32 dd 0                  ; total number of sectors for over 32MB
    drive db 0                      ; holds drive that boot sector comes
    reserved db 0                   ; reserved, empty
    signature db 0x29               ; extended boot sector signature
    volume_id db "seri"             ; disk serial
    volume_label db "MYVOLUME   "   ; volume label
    fs_type db "FAT12   "           ; file system type

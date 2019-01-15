# ori - just another bootloader 
# Copyright (C) 2019  Bruno Mondelo

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

.PHONY: all clean dist image
.PRECIOUS: %.o

AS := fasm
LD := ld

AUXFILES := Makefile README.md LICENSE
PROJDIRS := src
SRCFILES := $(shell find $(PROJDIRS) -type f -name "*.s")

OBJFILES := src/boot.o
OUTFILES := src/boot.out
BINFILES := boot.bin

ALLFILES := $(AUXFILES) $(SRCFILES)

all: $(BINFILES)

clean:
	-@$(RM) $(wildcard $(OBJFILES) $(OUTFILES) $(BINFILES) ori.tar.gz floppy.img)

dist:
	@tar czf imagine.tar.gz $(ALLFILES)

image: floppy.img

%.o: %.s Makefile
	@$(AS) $< $@

%.out: %.o Makefile
	@$(LD) -o $@ $< -Ttext 0x7c00

boot.bin: src/boot.out src/bootsector.s src/macros.s src/functions.s
	@objcopy -O binary -j .text $< $@

floppy.img: $(BINFILES)
	@dd if=/dev/zero of=floppy.img bs=1024 count=720 status=none
	@/sbin/mkdosfs -F 12 floppy.img
	@dd if=boot.bin of=floppy.img conv=notrunc status=none

CFLAGS = -Wall -Wextra -pedantic -s -Os -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-ident -ffunction-sections -fdata-sections -fno-stack-protector -fomit-frame-pointer
LDFLAGS = --gc-sections -nostartfiles -nostdlib -nodefaultlibs
all : segfault
segfault : segfault.o
	$(LD) $(LDFLAGS) $^ -o $@
	strip --strip-all $@
	strip \
		-S --strip-unneeded \
		--remove-section=.comment \
		--remove-section=.note $@

segfault.o : segfault.c
	$(CC) $(CFLAGS) -c $^ -o $@

clean :
	rm -rf *.o segfault

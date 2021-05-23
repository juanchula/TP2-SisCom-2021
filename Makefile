# Directorios
HELLO_WORLD = 01HelloWorld
MODE_PROTECTED = 02ModeProtected
IMG = img

all: clean helloworld_compile run

helloworld_compile: $(HELLO_WORLD)/main.S $(HELLO_WORLD)/link.ld
		as -g -o $(HELLO_WORLD)/main.o $(HELLO_WORLD)/main.S
		mkdir $(IMG)
		ld --oformat binary -o $(IMG)/main.img -T $(HELLO_WORLD)/link.ld $(HELLO_WORLD)/main.o

modeprotected_compile: $(MODE_PROTECTED)/main.S $(MODE_PROTECTED)/link.ld
		as -g -o $(MODE_PROTECTED)/main.o $(MODE_PROTECTED)/main.S
		mkdir $(IMG)
		ld --oformat binary -o $(IMG)/main.img -T $(MODE_PROTECTED)/link.ld $(MODE_PROTECTED)/main.o

run:
	qemu-system-x86_64 -fda $(IMG)/main.img -s -S -monitor stdio
	# qemu-system-x86_64 -hda $(IMG)/main.img

clean:
	rm  -Rf ./$(IMG)/
	rm  -Rf $(HELLO_WORLD)/main.o
	rm  -Rf $(MODE_PROTECTED)/main.o
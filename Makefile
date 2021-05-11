# Directorios
HELLO_WORLD = 01HelloWorld
IMG = img

all: clean compile run

compile: $(HELLO_WORLD)/main.S $(HELLO_WORLD)/link.ld
		as -g -o $(HELLO_WORLD)/main.o $(HELLO_WORLD)/main.S
		mkdir $(IMG)
		ld --oformat binary -o $(IMG)/main.img -T $(HELLO_WORLD)/link.ld $(HELLO_WORLD)/main.o

run:
	qemu-system-x86_64 -hda $(IMG)/main.img

clean:
	rm  -Rf ./$(IMG)/
	rm  -Rf $(HELLO_WORLD)/main.o
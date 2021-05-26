# Directorios
HELLO_WORLD = 01HelloWorld
MODE_PROTECTED = 02ModeProtected
IMG = img

all: clean create_dir compile_helloworld compile_modeprotected

create_dir:
	mkdir $(IMG)

compile_helloworld: $(HELLO_WORLD)/main.S $(HELLO_WORLD)/link.ld
		as -g -o $(HELLO_WORLD)/main.o $(HELLO_WORLD)/main.S
		ld --oformat binary -o $(IMG)/main_helloworld.img -T $(HELLO_WORLD)/link.ld $(HELLO_WORLD)/main.o

compile_modeprotected: $(MODE_PROTECTED)/main.S $(MODE_PROTECTED)/link.ld
		as -g -o $(MODE_PROTECTED)/main.o $(MODE_PROTECTED)/main.S
		ld --oformat binary -o $(IMG)/main_modeprotected.img -T $(MODE_PROTECTED)/link.ld $(MODE_PROTECTED)/main.o

run_helloworld:
	qemu-system-x86_64 -fda $(IMG)/main_helloworld.img -s -S -monitor stdio

run_modeprotected:
	qemu-system-x86_64 -fda $(IMG)/main_modeprotected.img -s -S -monitor stdio

clean:
	rm  -Rf ./$(IMG)/
	rm  -Rf $(HELLO_WORLD)/main.o
	rm  -Rf $(MODE_PROTECTED)/main.o
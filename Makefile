driver: driver.o
	./masm < Assignment3.asm > Assignment3.obj
	./mic1 prom.dat Assignment3.obj 0 2048
	-rm Assignment3.obj driver.o

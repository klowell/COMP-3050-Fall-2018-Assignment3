LOOP:   
	LODD PasCnt:	; Loads the number of passes left								; for (i = PasCnt, i > 0, i--)
	JZER DONE:		; If no more passes, end program
	SUBD c1:		; Decrements number of passes
	STOD PasCnt:	; Store decremented number of passes

P1:		
	LODD daddr:		; Loads address of current argument into accumulator			; arg = data[PasCnt - i]
	PSHI			; Pushes argument onto stack
	ADDD c1:		; Increments argument address for next iteration	
	STOD daddr:		; Stores address of next argument into memory
	CALL FIB:		; Pushes return address onto stack and goes to FIB function		; fib(arg)
	INSP 1			; Removes argument from stack

P2:		
	PUSH			; Pushes result onto stack
	LODD raddr:		; Loads address for result
	POPI			; Stores result into memory array								; results[PasCnt - i] = result
	ADDD c1:		; Increments result address for next iteration
	STOD raddr:		; Stores address for next result
	JUMP LOOP:		; Repeats process

FIB:	
	LODL 1			; Loads argument from stack into accumulator
	JZER FIBZER:	; If argument is 0, returns 0									; if (arg == 0) return 0
	SUBD c1:		; Decrements argument to test if argument is 1
	JZER FIBONE:	; If argument is 1, returns 1									; if (arg == 1) return 1
	PUSH			; Pushes arg - 1 onto stack
	CALL FIB:		; fib(arg - 1)													; temp1 = fib(arg - 1)
	PUSH			; Pushes reslt of fib(arg - 1) onto stack
	LODL 1			; Loads arg - 1 from stack into accumulator
	SUBD c1:		; Decrements argument once more
	PUSH			; Pushes arg - 2 onto stack
	CALL FIB:		; fib(arg - 2)													; temp2 = fib(arg - 2)

CLEAR:	
	INSP 1			; Removes latest argument from stack
	ADDL 0			; Adds fib(arg - 1) and fib(arg - 2)							; result = temp1 + temp2
	INSP 2			; Clears arguments from stack
	RETN			; Returns back to loop											; return result

FIBZER:	
	LODD c0:		; Stores 0 into accumulator
	RETN			; Returns back to loop or recursion

FIBONE:	
	LODD c1:		; Stores 1 into accumulator
	RETN			; Returns back to loop or recursion

DONE:	
	HALT			; Ends program
	
.LOC 	100			; locate data beginning at 100
data:  		
		3			; array of args for fib function
     	9
     	18
     	23
     	25
results:	
		0			; array of result locs for fib returns
     	0
     	0
     	0 
     	0
daddr:	data:		; start address of fib args 
raddr:	results:	; start address of fib results
c0: 	0			; constants 
c1: 	1
PasCnt:	5			; number of data elements to process
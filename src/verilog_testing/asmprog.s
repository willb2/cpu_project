# multiplication program

.data
num1: .word 5 #  									0x00000005
num2: .word 3 #										0x00000003
sum: .space 4

.text

start:
	j main 		#									0x08000003

end:
	sw $r3, 2($zero) # store data					0xAC030002
	j halt	#										0x0800000A

main:
	lw $r1, 0($zero) # load first data        		0x8C010000
	lw $r2, 1($zero) # load second data				0x8C020001
	add $r3, $r1, $zero # 							0x00011820
	# setup for loop (use second data as count)

loop:
	addi $r2, $r2, -1 # subtract 1 from count 		0x2042FFFF
	be $r2, $zero, end # compare count and zero 	0x1040FFF9
	add $r3, $r1, $zero # add data 					0x00610C20
	j loop # jump loop 								0x08000006

halt:
	j halt #										0x0800000A



00111
11001
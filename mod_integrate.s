	.file	"integrate.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	func
	.type	func, @function
func: # описание функции func
	mulsd	xmm2, xmm0 # фактическая передача параметров
	mulsd	xmm2, xmm0
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1 # возврат
	ret
	.size	func, .-func
	.p2align 4
	.globl	integrate # функция в глобальном пространстве имен
	.type	integrate, @function
integrate: # функция integrate
	mov	eax, esi # параметры
	pxor	xmm3, xmm3
	pxor	xmm4, xmm4
	mov	r8d, edx
	sub	eax, edi # параметры
	cvtsi2sd	xmm3, esi # вычисление локальной переменной h
	pxor	xmm2, xmm2 # эта и 27 строчка - вызовы функций внутри цикла for
	movsd	xmm5, QWORD PTR .LC1[rip]
	cdq
	cvtsi2sd	xmm4, edi
	idiv	r8d 
	movapd	xmm0, xmm3
	movapd	xmm1, xmm3
	mulsd	xmm0, xmm3
	mulsd	xmm1, xmm4
	mulsd	xmm0, xmm3
	mulsd	xmm1, xmm4
	mulsd	xmm0, xmm3
	mulsd	xmm1, xmm4
	cvtsi2sd	xmm2, eax
	addsd	xmm0, xmm4
	addsd	xmm1, xmm4
	addsd	xmm2, xmm4
	addsd	xmm0, xmm1
	mulsd	xmm0, QWORD PTR .LC0[rip]
	comisd	xmm3, xmm2
	jbe	.L3
	.p2align 4,,10
	.p2align 3
.L6:
	movapd	xmm1, xmm3
	mulsd	xmm1, xmm2
	mulsd	xmm1, xmm2
	mulsd	xmm1, xmm2
	addsd	xmm2, xmm5
	comisd	xmm3, xmm2
	addsd	xmm1, xmm4
	addsd	xmm0, xmm1
	ja	.L6
.L3:
	ret
	.size	integrate, .-integrate
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%d"
.LC3:
	.string	"%f"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	push	rbp
	lea	rbp, .LC2[rip] # ввод локальной переменной a
	mov	rdi, rbp
	sub	rsp, 32
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 24[rsp], rax
	xor	eax, eax
	lea	rsi, 12[rsp] # ввод локальной переменной b
	call	__isoc99_scanf@PLT
	lea	rsi, 16[rsp]
	mov	rdi, rbp
	xor	eax, eax
	call	__isoc99_scanf@PLT
	lea	rsi, 20[rsp] # ввод локальной переменной n
	mov	rdi, rbp 
	xor	eax, eax
	call	__isoc99_scanf@PLT
	mov	esi, DWORD PTR 16[rsp] # эта и 88, 89 строчки - фактическое вычисление локальной переменной ans
	mov	edi, DWORD PTR 12[rsp]
	mov	edx, DWORD PTR 20[rsp]
	call	integrate # вызов функции integrate 
	mov	edi, 1
	mov	eax, 1
	lea	rsi, .LC3[rip]
	call	__printf_chk@PLT # вывод результата на экран
	mov	rax, QWORD PTR 24[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L12
	add	rsp, 32
	xor	eax, eax
	pop	rbp
	ret
.L12:
	call	__stack_chk_fail@PLT
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1071644672
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits

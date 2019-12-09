	.file	"min_benchmarks.c"
	.text
	.globl	min_C
	.type	min_C, @function
min_C:
.LFB4741:
	.cfi_startproc
	testq	%rdi, %rdi
	jle	.L4
	movl	$0, %edx
	movl	$32767, %eax
.L3:
	movslq	%edx, %rcx
	movzwl	(%rsi,%rcx,2), %ecx
	cmpw	%cx, %ax
	cmovg	%ecx, %eax
	addl	$1, %edx
	movslq	%edx, %rcx
	cmpq	%rdi, %rcx
	jl	.L3
	ret
.L4:
	movl	$32767, %eax
	ret
	.cfi_endproc
.LFE4741:
	.size	min_C, .-min_C
	.globl	min_AVX
	.type	min_AVX, @function
min_AVX:
.LFB4742:
	.cfi_startproc
	testq	%rdi, %rdi
	jle	.L11
	movl	$0, %eax
	vmovdqa	.LC0(%rip), %xmm0
.L8:
	movslq	%eax, %rdx
	vpminsw	(%rsi,%rdx,2), %xmm0, %xmm0
	addl	$8, %eax
	movslq	%eax, %rdx
	cmpq	%rdi, %rdx
	jl	.L8
.L7:
	vmovaps	%xmm0, -24(%rsp)
	vpextrw	$0, %xmm0, %eax
	leaq	-22(%rsp), %rdx
	leaq	-8(%rsp), %r8
.L10:
	movzwl	(%rdx), %ecx
	movswl	%ax, %edi
	movzwl	%cx, %esi
	cmpl	%esi, %edi
	cmovg	%ecx, %eax
	addq	$2, %rdx
	cmpq	%rdx, %r8
	jne	.L10
	ret
.L11:
	vmovdqa	.LC0(%rip), %xmm0
	jmp	.L7
	.cfi_endproc
.LFE4742:
	.size	min_AVX, .-min_AVX
	.globl	functions
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"C (local)"
.LC2:
	.string	"min_AVX"
	.data
	.align 32
	.type	functions, @object
	.size	functions, 32
functions:
	.quad	min_C
	.quad	.LC1
	.quad	min_AVX
	.quad	.LC2
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	9223231297218904063
	.quad	9223231297218904063
	.ident	"GCC: (GNU) 7.1.0"
	.section	.note.GNU-stack,"",@progbits

	.file	"sp.c"
	.text
	.globl	function
	.type	function, @function
function:
.LFB0:
	.cfi_startproc
	movl	$100, -4(%rsp)
	movl	$200, -8(%rsp)
	movl	$300, -12(%rsp)
	nop
	ret
	.cfi_endproc
.LFE0:
	.size	function, .-function
	.ident	"GCC: (GNU) 12.2.1 20220819 (Red Hat 12.2.1-2)"
	.section	.note.GNU-stack,"",@progbits

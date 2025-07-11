	.file	"a.ll"
	.text
	.globl	store_128                       # -- Begin function store_128
	.p2align	4
	.type	store_128,@function
store_128:                              # @store_128
	.cfi_startproc
# %bb.0:                                # %entry
	pushl	%edi
	.cfi_def_cfa_offset 8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset %esi, -12
	.cfi_offset %edi, -8
	movl	12(%esp), %eax
	movl	16(%esp), %ecx
	movl	20(%esp), %edx
	movl	24(%esp), %esi
	movl	28(%esp), %edi
	movl	%esi, 12(%edi)
	movl	%edx, 8(%edi)
	movl	%ecx, 4(%edi)
	movl	%eax, (%edi)
	popl	%esi
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_def_cfa_offset 4
	retl
.Lfunc_end0:
	.size	store_128, .Lfunc_end0-store_128
	.cfi_endproc
                                        # -- End function
	.globl	load_128                        # -- Begin function load_128
	.p2align	4
	.type	load_128,@function
load_128:                               # @load_128
	.cfi_startproc
# %bb.0:                                # %entry
	pushl	%edi
	.cfi_def_cfa_offset 8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset %esi, -12
	.cfi_offset %edi, -8
	movl	12(%esp), %eax
	movl	16(%esp), %ecx
	movl	(%ecx), %edx
	movl	4(%ecx), %esi
	movl	8(%ecx), %edi
	movl	12(%ecx), %ecx
	movl	%ecx, 12(%eax)
	movl	%edi, 8(%eax)
	movl	%esi, 4(%eax)
	movl	%edx, (%eax)
	popl	%esi
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_def_cfa_offset 4
	retl	$4
.Lfunc_end1:
	.size	load_128, .Lfunc_end1-load_128
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits

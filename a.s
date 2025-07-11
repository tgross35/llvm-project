	.file	"a.ll"
	.text
	.globl	store_128                       # -- Begin function store_128
	.p2align	4
	.type	store_128,@function
store_128:                              # @store_128
# %bb.0:                                # %entry
	pushl	%edi
	pushl	%esi
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
	popl	%edi
	retl
.Lfunc_end0:
	.size	store_128, .Lfunc_end0-store_128
                                        # -- End function
	.globl	store_1282                      # -- Begin function store_1282
	.p2align	4
	.type	store_1282,@function
store_1282:                             # @store_1282
# %bb.0:                                # %entry
	pushl	%edi
	pushl	%esi
	movl	16(%esp), %eax
	movl	20(%esp), %ecx
	movl	24(%esp), %edx
	movl	28(%esp), %esi
	movl	32(%esp), %edi
	movl	%esi, 12(%edi)
	movl	%edx, 8(%edi)
	movl	%ecx, 4(%edi)
	movl	%eax, (%edi)
	popl	%esi
	popl	%edi
	retl
.Lfunc_end1:
	.size	store_1282, .Lfunc_end1-store_1282
                                        # -- End function
	.globl	load_128                        # -- Begin function load_128
	.p2align	4
	.type	load_128,@function
load_128:                               # @load_128
# %bb.0:                                # %entry
	pushl	%edi
	pushl	%esi
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
	popl	%edi
	retl	$4
.Lfunc_end2:
	.size	load_128, .Lfunc_end2-load_128
                                        # -- End function
	.section	".note.GNU-stack","",@progbits

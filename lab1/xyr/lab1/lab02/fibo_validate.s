	.text
	.file	"fibo.c"
	.globl	add                             // -- Begin function add
	.p2align	2
	.type	add,@function
add:                                    // @add
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	w0, [sp, #12]
	str	w1, [sp, #8]
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #8]
	add	w0, w8, w9
	add	sp, sp, #16
	ret
.Lfunc_end0:
	.size	add, .Lfunc_end0-add
	.cfi_endproc
                                        // -- End function
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	wzr, [x29, #-4]
	stur	wzr, [x29, #-8]
	mov	w8, #1
	stur	w8, [x29, #-12]
	str	w8, [sp, #16]
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	add	x1, sp, #8
	bl	__isoc99_scanf
	ldur	w1, [x29, #-8]
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	str	x0, [sp]                        // 8-byte Folded Spill
	bl	printf
	ldr	x0, [sp]                        // 8-byte Folded Reload
	ldur	w1, [x29, #-12]
	bl	printf
	b	.LBB1_1
.LBB1_1:                                // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #16]
	ldr	w9, [sp, #8]
	subs	w8, w8, w9
	b.ge	.LBB1_5
	b	.LBB1_2
.LBB1_2:                                //   in Loop: Header=BB1_1 Depth=1
	ldur	w8, [x29, #-12]
	str	w8, [sp, #12]
	ldur	w0, [x29, #-8]
	ldur	w1, [x29, #-12]
	bl	add
	stur	w0, [x29, #-12]
	ldur	w8, [x29, #-12]
	mov	w10, #2
	sdiv	w9, w8, w10
	mul	w9, w9, w10
	subs	w8, w8, w9
	cbnz	w8, .LBB1_4
	b	.LBB1_3
.LBB1_3:                                //   in Loop: Header=BB1_1 Depth=1
	ldur	w1, [x29, #-12]
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	printf
	b	.LBB1_4
.LBB1_4:                                //   in Loop: Header=BB1_1 Depth=1
	ldr	w8, [sp, #12]
	stur	w8, [x29, #-8]
	ldr	w8, [sp, #16]
	add	w8, w8, #1
	str	w8, [sp, #16]
	b	.LBB1_1
.LBB1_5:
	mov	w0, wzr
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	add	sp, sp, #48
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object                  // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d"
	.size	.L.str, 3

	.type	.L.str.1,@object                // @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym add
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf

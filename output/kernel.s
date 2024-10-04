	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_v1p0_zicsr2p0_zifencei2p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl256b1p0_zvl32b1p0_zvl64b1p0"
	.file	"LLVMDialectModule"
	.globl	matmul_kernel                   # -- Begin function matmul_kernel
	.p2align	1
	.type	matmul_kernel,@function
matmul_kernel:                          # @matmul_kernel
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -336
	.cfi_def_cfa_offset 336
	sd	ra, 328(sp)                     # 8-byte Folded Spill
	sd	s0, 320(sp)                     # 8-byte Folded Spill
	sd	s1, 312(sp)                     # 8-byte Folded Spill
	sd	s2, 304(sp)                     # 8-byte Folded Spill
	sd	s3, 296(sp)                     # 8-byte Folded Spill
	sd	s4, 288(sp)                     # 8-byte Folded Spill
	sd	s5, 280(sp)                     # 8-byte Folded Spill
	sd	s6, 272(sp)                     # 8-byte Folded Spill
	sd	s7, 264(sp)                     # 8-byte Folded Spill
	sd	s8, 256(sp)                     # 8-byte Folded Spill
	sd	s9, 248(sp)                     # 8-byte Folded Spill
	sd	s10, 240(sp)                    # 8-byte Folded Spill
	sd	s11, 232(sp)                    # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	.cfi_offset s1, -24
	.cfi_offset s2, -32
	.cfi_offset s3, -40
	.cfi_offset s4, -48
	.cfi_offset s5, -56
	.cfi_offset s6, -64
	.cfi_offset s7, -72
	.cfi_offset s8, -80
	.cfi_offset s9, -88
	.cfi_offset s10, -96
	.cfi_offset s11, -104
	addi	s0, sp, 336
	.cfi_def_cfa s0, 0
	csrr	a0, vlenb
	slli	a0, a0, 1
	sub	sp, sp, a0
	ld	a0, 0(s0)
	sd	a0, -240(s0)                    # 8-byte Folded Spill
	lw	s1, 56(s0)
	mv	s5, a7
	mv	s7, a6
	sd	a5, -312(s0)                    # 8-byte Folded Spill
	sd	a3, -248(s0)                    # 8-byte Folded Spill
	sd	a1, -256(s0)                    # 8-byte Folded Spill
	lui	a0, 2
	addiw	s3, a0, 64
	mv	a0, s3
	call	malloc
	addi	a0, a0, 63
	andi	a0, a0, -64
	lui	a2, 2
	sd	a0, -264(s0)                    # 8-byte Folded Spill
	li	a1, 0
	call	memset
	addi	a0, s7, 31
	sraiw	a1, a0, 31
	srliw	a1, a1, 27
	add	a0, a0, a1
	sraiw	a2, a0, 5
	addi	a0, s5, 63
	sraiw	a1, a0, 31
	srliw	a1, a1, 26
	add	a0, a0, a1
	sraiw	a0, a0, 6
	slli	a0, a0, 3
	divw	a1, s1, a0
	slli	a3, a1, 3
	subw	a2, a2, a3
	li	a4, 8
	blt	a2, a4, .LBB0_2
# %bb.1:
	li	a2, 8
.LBB0_2:
	remw	a4, s1, a2
	add	a3, a3, a4
	mul	a0, a1, a0
	subw	s1, s1, a0
	divw	a0, s1, a2
	slliw	s1, a3, 5
	slliw	a0, a0, 6
	sd	a0, -232(s0)                    # 8-byte Folded Spill
	sext.w	s7, s7
	sext.w	s6, s5
	ld	s2, -240(s0)                    # 8-byte Folded Reload
	addiw	s2, s2, 15
	mv	a0, s3
	call	malloc
	mv	s10, a0
	addi	a0, a0, 63
	andi	s9, a0, -64
	lui	a2, 2
	mv	a0, s9
	li	a1, 0
	call	memset
	li	a0, 16
	sd	s1, -320(s0)                    # 8-byte Folded Spill
	sd	s7, -328(s0)                    # 8-byte Folded Spill
	blt	s2, a0, .LBB0_30
# %bb.3:                                # %.lr.ph
	lw	a1, 8(s0)
	li	a2, 0
	li	a3, 0
	lw	a4, 16(s0)
	mul	a0, a1, s7
	sd	a0, -288(s0)                    # 8-byte Folded Spill
	sraiw	a0, s2, 31
	srliw	a0, a0, 28
	add	a0, a0, s2
	sraiw	a0, a0, 4
	sd	a0, -296(s0)                    # 8-byte Folded Spill
	sd	a4, -280(s0)                    # 8-byte Folded Spill
	slliw	a0, a4, 4
	sd	a0, -304(s0)                    # 8-byte Folded Spill
	sd	a1, -128(s0)                    # 8-byte Folded Spill
	mul	s1, s1, a1
	li	a0, 1
	slli	a0, a0, 11
	sd	a0, -224(s0)                    # 8-byte Folded Spill
	li	s5, 256
	lui	a0, 524288
	vsetivli	zero, 8, e32, m1, ta, ma
	vmv.v.x	v13, a0
	vmv.s.x	v14, a0
	li	s8, 32
	mv	s4, s9
	csrr	a0, vlenb
	sub	a0, s0, a0
	addi	a0, a0, -336
	vs1r.v	v13, (a0)                       # Unknown-size Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	sub	a0, s0, a0
	addi	a0, a0, -336
	vs1r.v	v14, (a0)                       # Unknown-size Folded Spill
	sd	s6, -272(s0)                    # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_4:                                #   in Loop: Header=BB0_5 Depth=1
	ld	s1, -152(s0)                    # 8-byte Folded Reload
	addi	s1, s1, 16
	ld	a3, -144(s0)                    # 8-byte Folded Reload
	addiw	a3, a3, 1
	ld	a2, -136(s0)                    # 8-byte Folded Reload
	ld	a0, -304(s0)                    # 8-byte Folded Reload
	add	a2, a2, a0
	mv	s4, s9
	ld	a0, -296(s0)                    # 8-byte Folded Reload
	beq	a3, a0, .LBB0_30
.LBB0_5:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_19 Depth 2
                                        #       Child Loop BB0_22 Depth 3
                                        #     Child Loop BB0_27 Depth 2
                                        #       Child Loop BB0_29 Depth 3
	ld	a0, -232(s0)                    # 8-byte Folded Reload
	add	a0, a0, a2
	sd	a0, -176(s0)                    # 8-byte Folded Spill
	rem	a0, a0, s6
	sd	a0, -184(s0)                    # 8-byte Folded Spill
	addi	a0, a0, 64
	blt	a0, s6, .LBB0_7
# %bb.6:                                #   in Loop: Header=BB0_5 Depth=1
	mv	a0, s6
.LBB0_7:                                #   in Loop: Header=BB0_5 Depth=1
	sd	a0, -192(s0)                    # 8-byte Folded Spill
	sd	a2, -136(s0)                    # 8-byte Folded Spill
	sd	a3, -144(s0)                    # 8-byte Folded Spill
	slli	a0, a3, 4
	ld	a1, -240(s0)                    # 8-byte Folded Reload
	subw	s6, a1, a0
	li	a0, 16
	mv	s9, s6
	blt	s6, a0, .LBB0_9
# %bb.8:                                #   in Loop: Header=BB0_5 Depth=1
	li	s9, 16
.LBB0_9:                                #   in Loop: Header=BB0_5 Depth=1
	ld	a0, -248(s0)                    # 8-byte Folded Reload
	ld	a1, 0(a0)
	sd	a1, -160(s0)                    # 8-byte Folded Spill
	ld	a0, 8(a0)
	sd	a0, -168(s0)                    # 8-byte Folded Spill
	ld	a0, -256(s0)                    # 8-byte Folded Reload
	ld	s3, 0(a0)
	ld	s11, 8(a0)
	ld	a0, -224(s0)                    # 8-byte Folded Reload
	call	malloc
	mv	s7, a0
	li	a0, 15
	blt	a0, s6, .LBB0_11
# %bb.10:                               # %.preheader157.preheader
                                        #   in Loop: Header=BB0_5 Depth=1
	mv	a0, s7
	li	a1, 0
	ld	a2, -224(s0)                    # 8-byte Folded Reload
	call	memset
.LBB0_11:                               # %.loopexit161
                                        #   in Loop: Header=BB0_5 Depth=1
	ld	a1, -128(s0)                    # 8-byte Folded Reload
	rem	s2, s1, a1
	ld	a0, -288(s0)                    # 8-byte Folded Reload
	sub	a0, a0, s1
	add	a0, a0, s2
	div	a0, a0, a1
	li	a1, 32
	blt	a0, a1, .LBB0_13
# %bb.12:                               # %.loopexit161
                                        #   in Loop: Header=BB0_5 Depth=1
	li	a0, 32
.LBB0_13:                               # %.loopexit161
                                        #   in Loop: Header=BB0_5 Depth=1
	sd	sp, -208(s0)                    # 8-byte Folded Spill
	sub	s10, a1, a0
	slli	a1, a0, 4
	sd	a1, -200(s0)                    # 8-byte Folded Spill
	mv	a1, sp
	addi	a2, a1, -64
	mv	sp, a2
	sd	s3, -64(a1)
	sd	s11, -56(a1)
	sd	s1, -152(s0)                    # 8-byte Folded Spill
	sd	s1, -48(a1)
	sd	a0, -40(a1)
	sd	s9, -32(a1)
	sd	s11, -216(s0)                   # 8-byte Folded Spill
	mv	s11, s3
	ld	s3, -128(s0)                    # 8-byte Folded Reload
	sd	s3, -24(a1)
	li	a3, 1
	sd	a3, -16(a1)
	li	a4, 1
	mv	a1, sp
	addi	a3, a1, -64
	mv	sp, a3
	sd	s7, -64(a1)
	sd	s7, -56(a1)
	sd	zero, -48(a1)
	sd	a0, -40(a1)
	sd	s9, -32(a1)
	li	a0, 16
	sd	a0, -24(a1)
	sd	a4, -16(a1)
	mv	a0, sp
	addi	a1, a0, -16
	mv	sp, a1
	li	s1, 2
	sd	s1, -16(a0)
	sd	a2, -8(a0)
	mv	a0, sp
	addi	a2, a0, -16
	mv	sp, a2
	sd	s1, -16(a0)
	sd	a3, -8(a0)
	li	a0, 4
	call	memrefCopy
	ld	sp, -208(s0)                    # 8-byte Folded Reload
	mv	a0, sp
	addi	a2, a0, -64
	mv	sp, a2
	sd	s11, -64(a0)
	ld	a1, -216(s0)                    # 8-byte Folded Reload
	sd	a1, -56(a0)
	sd	s2, -48(a0)
	sd	s10, -40(a0)
	sd	s9, -32(a0)
	sd	s3, -24(a0)
	li	a4, 1
	sd	a4, -16(a0)
	mv	a0, sp
	addi	a3, a0, -64
	mv	sp, a3
	sd	s7, -64(a0)
	sd	s7, -56(a0)
	ld	a1, -200(s0)                    # 8-byte Folded Reload
	sd	a1, -48(a0)
	sd	s10, -40(a0)
	sd	s9, -32(a0)
	li	a1, 16
	sd	a1, -24(a0)
	sd	a4, -16(a0)
	mv	a0, sp
	addi	a1, a0, -16
	mv	sp, a1
	sd	s1, -16(a0)
	sd	a2, -8(a0)
	mv	a0, sp
	addi	a2, a0, -16
	mv	sp, a2
	sd	s1, -16(a0)
	sd	a3, -8(a0)
	li	a0, 4
	call	memrefCopy
	ld	sp, -208(s0)                    # 8-byte Folded Reload
	lui	a0, 1
	call	malloc
	mv	s3, a0
	li	a0, 15
	blt	a0, s6, .LBB0_15
# %bb.14:                               # %.preheader156.preheader
                                        #   in Loop: Header=BB0_5 Depth=1
	lui	a2, 1
	mv	a0, s3
	li	a1, 0
	call	memset
.LBB0_15:                               # %.loopexit
                                        #   in Loop: Header=BB0_5 Depth=1
	ld	a0, -184(s0)                    # 8-byte Folded Reload
	ld	s1, -192(s0)                    # 8-byte Folded Reload
	sub	s1, s1, a0
	li	a2, 64
	blt	s1, a2, .LBB0_17
# %bb.16:                               # %.loopexit
                                        #   in Loop: Header=BB0_5 Depth=1
	li	s1, 64
.LBB0_17:                               # %.loopexit
                                        #   in Loop: Header=BB0_5 Depth=1
	sd	sp, -192(s0)                    # 8-byte Folded Spill
	ld	a1, -176(s0)                    # 8-byte Folded Reload
	sub	a0, a1, a0
	sd	a0, -184(s0)                    # 8-byte Folded Spill
	sub	s6, a2, s1
	mv	a0, sp
	li	a4, 64
	addi	a2, a0, -64
	mv	sp, a2
	ld	s10, -160(s0)                   # 8-byte Folded Reload
	sd	s10, -64(a0)
	ld	s11, -168(s0)                   # 8-byte Folded Reload
	sd	s11, -56(a0)
	sd	a1, -48(a0)
	sd	s9, -40(a0)
	sd	s1, -32(a0)
	ld	s2, -280(s0)                    # 8-byte Folded Reload
	sd	s2, -24(a0)
	li	a1, 1
	sd	a1, -16(a0)
	li	a1, 1
	mv	a0, sp
	addi	a3, a0, -64
	mv	sp, a3
	sd	s3, -64(a0)
	sd	s3, -56(a0)
	sd	zero, -48(a0)
	sd	s9, -40(a0)
	sd	s1, -32(a0)
	sd	a4, -24(a0)
	sd	a1, -16(a0)
	mv	a0, sp
	addi	a1, a0, -16
	mv	sp, a1
	li	a4, 2
	sd	a4, -16(a0)
	sd	a2, -8(a0)
	mv	a0, sp
	addi	a2, a0, -16
	mv	sp, a2
	sd	a4, -16(a0)
	sd	a3, -8(a0)
	li	a0, 4
	call	memrefCopy
	ld	sp, -192(s0)                    # 8-byte Folded Reload
	sd	sp, -176(s0)                    # 8-byte Folded Spill
	mv	a0, sp
	addi	a2, a0, -64
	mv	sp, a2
	sd	s10, -64(a0)
	sd	s11, -56(a0)
	ld	a1, -184(s0)                    # 8-byte Folded Reload
	sd	a1, -48(a0)
	sd	s9, -40(a0)
	sd	s6, -32(a0)
	sd	s2, -24(a0)
	li	a1, 1
	sd	a1, -16(a0)
	mv	a0, sp
	addi	a3, a0, -64
	mv	sp, a3
	sd	s3, -64(a0)
	sd	s3, -56(a0)
	sd	s1, -48(a0)
	sd	s9, -40(a0)
	sd	s6, -32(a0)
	li	a4, 64
	sd	a4, -24(a0)
	sd	a1, -16(a0)
	mv	a0, sp
	addi	a1, a0, -16
	mv	sp, a1
	li	a4, 2
	sd	a4, -16(a0)
	sd	a2, -8(a0)
	mv	a0, sp
	addi	a2, a0, -16
	mv	sp, a2
	sd	a4, -16(a0)
	sd	a3, -8(a0)
	li	a0, 4
	call	memrefCopy
	ld	sp, -176(s0)                    # 8-byte Folded Reload
	lui	s2, 2
	addiw	a0, s2, 64
	call	malloc
	mv	s10, a0
	addi	a0, a0, 63
	andi	s9, a0, -64
	lui	a2, 2
	mv	a0, s9
	ld	a1, -264(s0)                    # 8-byte Folded Reload
	call	memcpy
	li	t1, 0
	lui	a6, 1
	add	a6, a6, s3
	addi	a7, s9, 256
	addi	t0, s7, 64
	addi	t3, s3, 2047
	addi	t3, t3, 1
	mv	a5, s9
	csrr	a0, vlenb
	sub	a0, s0, a0
	addi	a0, a0, -336
	vl1r.v	v13, (a0)                       # Unknown-size Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	sub	a0, s0, a0
	addi	a0, a0, -336
	vl1r.v	v14, (a0)                       # Unknown-size Folded Reload
	ld	s6, -272(s0)                    # 8-byte Folded Reload
	j	.LBB0_19
.LBB0_18:                               #   in Loop: Header=BB0_19 Depth=2
	addi	t1, t1, 1
	addi	a5, a5, 256
	beq	t1, s8, .LBB0_24
.LBB0_19:                               # %.preheader155
                                        #   Parent Loop BB0_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_22 Depth 3
	li	a4, 0
	slli	a0, t1, 8
	add	a1, s9, a0
	add	a0, a0, a7
	slli	a3, t1, 6
	add	a2, s7, a3
	add	a3, a3, t0
	sltu	a3, a1, a3
	sltu	s1, a2, a0
	and	a3, a3, s1
	sltu	a1, a1, a6
	sltu	a0, s3, a0
	and	a0, a0, a1
	or	a3, a3, a0
	addi	t2, a2, 32
	j	.LBB0_22
.LBB0_20:                               # %scalar.ph190
                                        #   in Loop: Header=BB0_22 Depth=3
	flw	fa4, 0(a2)
	flw	fa3, 0(s1)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 4(a2)
	flw	fa3, 256(s1)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 8(a2)
	flw	fa3, 512(s1)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 12(a2)
	flw	fa3, 768(s1)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 16(a2)
	flw	fa3, 1024(s1)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 20(a2)
	flw	fa3, 1280(s1)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 24(a2)
	flw	fa3, 1536(s1)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 28(a2)
	flw	fa3, 1792(s1)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 32(a2)
	flw	fa3, 0(a0)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 36(a2)
	flw	fa3, 256(a0)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 40(a2)
	flw	fa3, 512(a0)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 44(a2)
	flw	fa3, 768(a0)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 48(a2)
	flw	fa3, 1024(a0)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 52(a2)
	flw	fa3, 1280(a0)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 56(a2)
	flw	fa3, 1536(a0)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a1)
	flw	fa4, 60(a2)
	flw	fa3, 1792(a0)
	fmul.s	fa4, fa4, fa3
	fadd.s	fa5, fa5, fa4
.LBB0_21:                               # %.loopexit197
                                        #   in Loop: Header=BB0_22 Depth=3
	addi	a4, a4, 4
	fsw	fa5, 0(a1)
	beq	a4, s5, .LBB0_18
.LBB0_22:                               # %.preheader
                                        #   Parent Loop BB0_5 Depth=1
                                        #     Parent Loop BB0_19 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	add	a1, a5, a4
	flw	fa5, 0(a1)
	add	s1, s3, a4
	add	a0, t3, a4
	bnez	a3, .LBB0_20
# %bb.23:                               # %vector.body193
                                        #   in Loop: Header=BB0_22 Depth=3
	vsetivli	zero, 8, e32, m1, tu, ma
	vmv1r.v	v8, v13
	vfmv.s.f	v8, fa5
	vsetvli	zero, zero, e32, m1, ta, ma
	vle32.v	v9, (a2)
	vlse32.v	v10, (s1), s5
	vle32.v	v11, (t2)
	vlse32.v	v12, (a0), s5
	vfmul.vv	v9, v9, v10
	vfadd.vv	v8, v8, v9
	vfmul.vv	v9, v11, v12
	vfadd.vv	v8, v8, v9
	vfredosum.vs	v8, v8, v14
	vfmv.f.s	fa5, v8
	j	.LBB0_21
.LBB0_24:                               # %.preheader154.preheader
                                        #   in Loop: Header=BB0_5 Depth=1
	li	a0, 0
	add	a1, s9, s2
	add	a2, s4, s2
	sltu	a2, s9, a2
	sltu	a1, s4, a1
	and	a6, a2, a1
	mv	a2, s9
	mv	s1, s4
	j	.LBB0_27
.LBB0_25:                               # %vector.body
                                        #   in Loop: Header=BB0_27 Depth=2
	slli	a4, a0, 6
	slli	a4, a4, 2
	add	a3, s9, a4
	vsetivli	zero, 8, e32, m1, ta, ma
	vle32.v	v8, (a3)
	add	a5, s4, a4
	vle32.v	v9, (a5)
	ori	a5, a4, 32
	add	a1, s9, a5
	vle32.v	v10, (a1)
	add	a5, a5, s4
	vle32.v	v11, (a5)
	vfadd.vv	v8, v8, v9
	vse32.v	v8, (a3)
	vfadd.vv	v8, v10, v11
	vse32.v	v8, (a1)
	ori	a1, a4, 64
	add	a7, s9, a1
	vle32.v	v8, (a7)
	add	a1, a1, s4
	vle32.v	v9, (a1)
	ori	a1, a4, 96
	add	a5, s4, a1
	vle32.v	v10, (a5)
	ori	a3, a4, 128
	add	a5, s4, a3
	vle32.v	v11, (a5)
	vfadd.vv	v8, v8, v9
	add	a1, a1, s9
	vle32.v	v9, (a1)
	add	a3, a3, s9
	vle32.v	v12, (a3)
	vse32.v	v8, (a7)
	vfadd.vv	v8, v9, v10
	vse32.v	v8, (a1)
	vfadd.vv	v8, v12, v11
	vse32.v	v8, (a3)
	ori	a1, a4, 160
	add	a3, s9, a1
	vle32.v	v8, (a3)
	add	a1, a1, s4
	vle32.v	v9, (a1)
	ori	a1, a4, 192
	add	a5, s4, a1
	vle32.v	v10, (a5)
	ori	a4, a4, 224
	add	a5, s4, a4
	vle32.v	v11, (a5)
	vfadd.vv	v8, v8, v9
	add	a1, a1, s9
	vle32.v	v9, (a1)
	add	a4, a4, s9
	vle32.v	v12, (a4)
	vse32.v	v8, (a3)
	vfadd.vv	v8, v9, v10
	vse32.v	v8, (a1)
	vfadd.vv	v8, v12, v11
	vse32.v	v8, (a4)
.LBB0_26:                               # %middle.block
                                        #   in Loop: Header=BB0_27 Depth=2
	addi	a0, a0, 1
	addi	s1, s1, 256
	addi	a2, a2, 256
	beq	a0, s8, .LBB0_4
.LBB0_27:                               # %.preheader154
                                        #   Parent Loop BB0_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_29 Depth 3
	beqz	a6, .LBB0_25
# %bb.28:                               #   in Loop: Header=BB0_27 Depth=2
	slli	a3, a0, 8
	add	a3, a3, s4
	addi	a4, a3, 256
	mv	a5, a2
	mv	a3, s1
.LBB0_29:                               # %scalar.ph
                                        #   Parent Loop BB0_5 Depth=1
                                        #     Parent Loop BB0_27 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	flw	fa5, 0(a5)
	flw	fa4, 0(a3)
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a5)
	addi	a3, a3, 4
	addi	a5, a5, 4
	bne	a3, a4, .LBB0_29
	j	.LBB0_26
.LBB0_30:                               # %._crit_edge
	lw	a6, 24(s0)
	ld	a3, -320(s0)                    # 8-byte Folded Reload
	addi	a1, a3, 32
	ld	a0, -328(s0)                    # 8-byte Folded Reload
	blt	a1, a0, .LBB0_32
# %bb.31:                               # %._crit_edge
	mv	a1, a0
.LBB0_32:                               # %._crit_edge
	ld	a0, -232(s0)                    # 8-byte Folded Reload
	addi	a2, a0, 64
	sub	a1, a1, a3
	blt	a2, s6, .LBB0_34
# %bb.33:                               # %._crit_edge
	mv	a2, s6
.LBB0_34:                               # %._crit_edge
	mul	a3, a3, a6
	li	a4, 32
	ld	a0, -232(s0)                    # 8-byte Folded Reload
	sub	a2, a2, a0
	blt	a1, a4, .LBB0_36
# %bb.35:                               # %._crit_edge
	li	a1, 32
.LBB0_36:                               # %._crit_edge
	li	a4, 64
	ld	a7, -232(s0)                    # 8-byte Folded Reload
	add	a7, a7, a3
	blt	a2, a4, .LBB0_38
# %bb.37:                               # %._crit_edge
	li	a2, 64
.LBB0_38:                               # %._crit_edge
	mv	a5, sp
	addi	s1, a5, -64
	mv	sp, s1
	sd	s10, -64(a5)
	sd	s9, -56(a5)
	sd	zero, -48(a5)
	sd	a1, -40(a5)
	sd	a2, -32(a5)
	sd	a4, -24(a5)
	li	a4, 1
	sd	a4, -16(a5)
	mv	a5, sp
	addi	a0, a5, -64
	mv	sp, a0
	vsetivli	zero, 2, e64, m1, ta, ma
	ld	a3, -312(s0)                    # 8-byte Folded Reload
	vle64.v	v8, (a3)
	vse64.v	v8, (a0)
	sd	a7, -48(a5)
	sd	a1, -40(a5)
	sd	a2, -32(a5)
	sd	a6, -24(a5)
	sd	a4, -16(a5)
	mv	a2, sp
	addi	a1, a2, -16
	mv	sp, a1
	li	a3, 2
	sd	a3, -16(a2)
	sd	s1, -8(a2)
	mv	a4, sp
	addi	a2, a4, -16
	mv	sp, a2
	sd	a3, -16(a4)
	sd	a0, -8(a4)
	li	a0, 4
	call	memrefCopy
	addi	sp, s0, -336
	ld	ra, 328(sp)                     # 8-byte Folded Reload
	ld	s0, 320(sp)                     # 8-byte Folded Reload
	ld	s1, 312(sp)                     # 8-byte Folded Reload
	ld	s2, 304(sp)                     # 8-byte Folded Reload
	ld	s3, 296(sp)                     # 8-byte Folded Reload
	ld	s4, 288(sp)                     # 8-byte Folded Reload
	ld	s5, 280(sp)                     # 8-byte Folded Reload
	ld	s6, 272(sp)                     # 8-byte Folded Reload
	ld	s7, 264(sp)                     # 8-byte Folded Reload
	ld	s8, 256(sp)                     # 8-byte Folded Reload
	ld	s9, 248(sp)                     # 8-byte Folded Reload
	ld	s10, 240(sp)                    # 8-byte Folded Reload
	ld	s11, 232(sp)                    # 8-byte Folded Reload
	addi	sp, sp, 336
	ret
.Lfunc_end0:
	.size	matmul_kernel, .Lfunc_end0-matmul_kernel
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits

@work:
	.section	.AMDGPU.config
.long	47176
.long	131
.long	47180
.long	0
	.text
; BB#0:
                                        ; kill: SGPR2<def> SGPR2<kill> SGPR2_SGPR3<def>
	V_MOV_B32_e32 v2, 0
	V_MOV_B32_e32 v0, v2
	S_LOAD_DWORD s7, s[0:1], 3
	S_LOAD_DWORD s6, s[0:1], 13
	S_LOAD_DWORDX2 s[4:5], s[0:1], 11
	S_LOAD_DWORDX2 s[8:9], s[0:1], 9
	V_MOV_B32_e32 v2, 5
	V_MOV_B32_e32 v8, 1
	V_MOV_B32_e32 v3, 25
	V_MOV_B32_e32 v4, 20
	V_MOV_B32_e32 v5, 15
	V_MOV_B32_e32 v6, 10
	S_MOV_B64 s[0:1], 0
	S_WAITCNT lgkmcnt(0)
	S_ASHR_I32 s12, s7, 31
	S_ADD_I32 s13, s7, s12
	S_MOV_B64 s[8:9], s[8:9]
	S_MOV_B32 s10, 0
	S_MOV_B32 s11, 61440
";.BB0_1":                              ; =>This Inner Loop Header: Depth=1
	V_MOV_B32_e32 v7, v8
	V_MOV_B32_e32 v8, 100
	V_CMP_LT_I32_e64 s[14:15], v2, v8, 0, 0, 0, 0
                                        ; implicit-def: VGPR8
	S_AND_SAVEEXEC_B64 s[14:15], s[14:15]
	S_XOR_B64 s[14:15], exec, s[14:15]
	S_CBRANCH_EXECZ ";.BB0_3"
; BB#2:                                 ;   in Loop: Header=BB0_1 Depth=1
	V_MOV_B32_e32 v8, s12
	V_XOR_B32_e64 v8, s13, v8, 0, 0, 0, 0
	V_CVT_F32_U32_e32 v9, v8
	V_RCP_IFLAG_F32_e32 v9, v9
	V_MUL_F32_e32 v9, 1333788672, v9
	V_CVT_U32_F32_e32 v9, v9
	V_MUL_HI_U32 v10, v9, v8, 0, 0, 0, 0, 0
	V_CMP_EQ_I32_e64 s[16:17], v10, 0, 0, 0, 0, 0
	V_MUL_LO_I32 v10, v9, v8, 0, 0, 0, 0, 0
	V_SUB_I32_e32 v11, 0, v10
	V_CNDMASK_B32_e64 v10, v10, v11, s[16:17], 0, 0, 0, 0
	V_MUL_HI_U32 v10, v10, v9, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v11, v10, v9
	V_SUBREV_I32_e32 v9, v10, v9
	V_CNDMASK_B32_e64 v9, v9, v11, s[16:17], 0, 0, 0, 0
	V_ASHRREV_I32_e32 v10, 31, v6
	V_ADD_I32_e32 v11, v10, v6
	V_XOR_B32_e64 v10, v11, v10, 0, 0, 0, 0
	V_MUL_HI_U32 v11, v9, v10, 0, 0, 0, 0, 0
	V_MUL_LO_I32 v12, v11, v8, 0, 0, 0, 0, 0
	V_CMP_GE_U32_e64 s[16:17], v10, v12, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v13, 0, -1, s[16:17], 0, 0, 0, 0
	V_SUBREV_I32_e32 v10, v12, v10
	V_CMP_GE_U32_e64 s[16:17], v10, v8, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v10, 0, -1, s[16:17], 0, 0, 0, 0
	V_AND_B32_e32 v10, v10, v13
	V_CMP_EQ_I32_e64 s[16:17], v10, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v10, 1, v11
	V_CNDMASK_B32_e64 v10, v10, v11, s[16:17], 0, 0, 0, 0
	V_ADD_I32_e32 v11, -1, v11
	V_CMP_EQ_I32_e64 s[16:17], v13, 0, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v10, v10, v11, s[16:17], 0, 0, 0, 0
	V_MOV_B32_e32 v11, s7
	V_XOR_B32_e64 v12, v6, v11, 0, 0, 0, 0
	V_ASHRREV_I32_e32 v12, 31, v12
	V_ADD_I32_e32 v10, v10, v12
	V_XOR_B32_e64 v10, v10, v12, 0, 0, 0, 0
	V_MUL_LO_I32 v10, v10, s7, 0, 0, 0, 0, 0
	V_SUBREV_I32_e32 v12, v10, v6
	V_ASHRREV_I32_e32 v13, 31, v12
	BUFFER_LOAD_UBYTE v10, s[8:11] + v[12:13] + 0
	V_ASHRREV_I32_e32 v12, 31, v2
	V_ADD_I32_e32 v13, v12, v2
	V_XOR_B32_e64 v12, v13, v12, 0, 0, 0, 0
	V_MUL_HI_U32 v13, v9, v12, 0, 0, 0, 0, 0
	V_MUL_LO_I32 v14, v13, v8, 0, 0, 0, 0, 0
	V_CMP_GE_U32_e64 s[16:17], v12, v14, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v15, 0, -1, s[16:17], 0, 0, 0, 0
	V_SUBREV_I32_e32 v12, v14, v12
	V_CMP_GE_U32_e64 s[16:17], v12, v8, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v12, 0, -1, s[16:17], 0, 0, 0, 0
	V_AND_B32_e32 v12, v12, v15
	V_CMP_EQ_I32_e64 s[16:17], v12, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v12, 1, v13
	V_CNDMASK_B32_e64 v12, v12, v13, s[16:17], 0, 0, 0, 0
	V_ADD_I32_e32 v13, -1, v13
	V_CMP_EQ_I32_e64 s[16:17], v15, 0, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v12, v12, v13, s[16:17], 0, 0, 0, 0
	V_XOR_B32_e64 v13, v2, v11, 0, 0, 0, 0
	V_ASHRREV_I32_e32 v13, 31, v13
	V_ADD_I32_e32 v12, v12, v13
	V_XOR_B32_e64 v12, v12, v13, 0, 0, 0, 0
	V_MUL_LO_I32 v12, v12, s7, 0, 0, 0, 0, 0
	V_SUBREV_I32_e32 v12, v12, v2
	V_ASHRREV_I32_e32 v13, 31, v12
	BUFFER_LOAD_UBYTE v12, s[8:11] + v[12:13] + 0
	S_WAITCNT vmcnt(0) 
	V_ADD_I32_e32 v10, v10, v12
	V_ASHRREV_I32_e32 v12, 31, v5
	V_ADD_I32_e32 v13, v12, v5
	V_XOR_B32_e64 v12, v13, v12, 0, 0, 0, 0
	V_MUL_HI_U32 v13, v9, v12, 0, 0, 0, 0, 0
	V_MUL_LO_I32 v14, v13, v8, 0, 0, 0, 0, 0
	V_CMP_GE_U32_e64 s[16:17], v12, v14, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v15, 0, -1, s[16:17], 0, 0, 0, 0
	V_SUBREV_I32_e32 v12, v14, v12
	V_CMP_GE_U32_e64 s[16:17], v12, v8, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v12, 0, -1, s[16:17], 0, 0, 0, 0
	V_AND_B32_e32 v12, v12, v15
	V_CMP_EQ_I32_e64 s[16:17], v12, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v12, 1, v13
	V_CNDMASK_B32_e64 v12, v12, v13, s[16:17], 0, 0, 0, 0
	V_ADD_I32_e32 v13, -1, v13
	V_CMP_EQ_I32_e64 s[16:17], v15, 0, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v12, v12, v13, s[16:17], 0, 0, 0, 0
	V_XOR_B32_e64 v13, v5, v11, 0, 0, 0, 0
	V_ASHRREV_I32_e32 v13, 31, v13
	V_ADD_I32_e32 v12, v12, v13
	V_XOR_B32_e64 v12, v12, v13, 0, 0, 0, 0
	V_MUL_LO_I32 v12, v12, s7, 0, 0, 0, 0, 0
	V_SUBREV_I32_e32 v12, v12, v5
	V_ASHRREV_I32_e32 v13, 31, v12
	BUFFER_LOAD_UBYTE v12, s[8:11] + v[12:13] + 0
	S_WAITCNT vmcnt(0) 
	V_ADD_I32_e32 v10, v12, v10
	V_ASHRREV_I32_e32 v12, 31, v4
	V_ADD_I32_e32 v13, v12, v4
	V_XOR_B32_e64 v12, v13, v12, 0, 0, 0, 0
	V_MUL_HI_U32 v13, v9, v12, 0, 0, 0, 0, 0
	V_MUL_LO_I32 v14, v13, v8, 0, 0, 0, 0, 0
	V_CMP_GE_U32_e64 s[16:17], v12, v14, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v15, 0, -1, s[16:17], 0, 0, 0, 0
	V_SUBREV_I32_e32 v12, v14, v12
	V_CMP_GE_U32_e64 s[16:17], v12, v8, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v12, 0, -1, s[16:17], 0, 0, 0, 0
	V_AND_B32_e32 v12, v12, v15
	V_CMP_EQ_I32_e64 s[16:17], v12, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v12, 1, v13
	V_CNDMASK_B32_e64 v12, v12, v13, s[16:17], 0, 0, 0, 0
	V_ADD_I32_e32 v13, -1, v13
	V_CMP_EQ_I32_e64 s[16:17], v15, 0, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v12, v12, v13, s[16:17], 0, 0, 0, 0
	V_XOR_B32_e64 v13, v4, v11, 0, 0, 0, 0
	V_ASHRREV_I32_e32 v13, 31, v13
	V_ADD_I32_e32 v12, v12, v13
	V_XOR_B32_e64 v12, v12, v13, 0, 0, 0, 0
	V_MUL_LO_I32 v12, v12, s7, 0, 0, 0, 0, 0
	V_SUBREV_I32_e32 v12, v12, v4
	V_ASHRREV_I32_e32 v13, 31, v12
	BUFFER_LOAD_UBYTE v12, s[8:11] + v[12:13] + 0
	S_WAITCNT vmcnt(0) 
	V_ADD_I32_e32 v10, v12, v10
	V_ASHRREV_I32_e32 v12, 31, v3
	V_ADD_I32_e32 v13, v12, v3
	V_XOR_B32_e64 v12, v13, v12, 0, 0, 0, 0
	V_MUL_HI_U32 v9, v9, v12, 0, 0, 0, 0, 0
	V_MUL_LO_I32 v13, v9, v8, 0, 0, 0, 0, 0
	V_CMP_GE_U32_e64 s[16:17], v12, v13, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v14, 0, -1, s[16:17], 0, 0, 0, 0
	V_SUBREV_I32_e32 v12, v13, v12
	V_CMP_GE_U32_e64 s[16:17], v12, v8, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v8, 0, -1, s[16:17], 0, 0, 0, 0
	V_AND_B32_e32 v8, v8, v14
	V_CMP_EQ_I32_e64 s[16:17], v8, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v8, 1, v9
	V_CNDMASK_B32_e64 v8, v8, v9, s[16:17], 0, 0, 0, 0
	V_ADD_I32_e32 v9, -1, v9
	V_CMP_EQ_I32_e64 s[16:17], v14, 0, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v8, v8, v9, s[16:17], 0, 0, 0, 0
	V_XOR_B32_e64 v9, v3, v11, 0, 0, 0, 0
	V_ASHRREV_I32_e32 v9, 31, v9
	V_ADD_I32_e32 v8, v8, v9
	V_XOR_B32_e64 v8, v8, v9, 0, 0, 0, 0
	V_MUL_LO_I32 v8, v8, s7, 0, 0, 0, 0, 0
	V_SUBREV_I32_e32 v8, v8, v3
	V_ASHRREV_I32_e32 v9, 31, v8
	BUFFER_LOAD_UBYTE v8, s[8:11] + v[8:9] + 0
	S_WAITCNT vmcnt(0) 
	V_ADD_I32_e32 v8, v8, v10
	V_ADD_I32_e32 v8, v8, v7
; BB#4:                                 ;   in Loop: Header=BB0_1 Depth=1
	V_ADD_I32_e32 v6, 2, v6
	V_ADD_I32_e32 v5, 3, v5
	V_ADD_I32_e32 v4, 4, v4
	V_ADD_I32_e32 v3, 5, v3
	V_ADD_I32_e32 v2, 1, v2
";.BB0_3":                              ; %Flow
                                        ;   in Loop: Header=BB0_1 Depth=1
	S_OR_B64 exec, exec, s[14:15]
	S_OR_B64 s[0:1], s[14:15], s[0:1]
	S_ANDN2_B64 exec, exec, s[0:1]
	S_CBRANCH_EXECNZ ";.BB0_1"
; BB#5:
	S_OR_B64 exec, exec, s[0:1]
	S_ASHR_I32 s3, s2, 31
	V_MOV_B32_e32 v2, s2
	V_MOV_B32_e32 v3, s3
	BUFFER_LOAD_UBYTE v2, s[8:11] + v[2:3] + 0
	S_WAITCNT vmcnt(0) 
	V_MUL_LO_I32 v2, v2, s6, 0, 0, 0, 0, 0
	V_MOV_B32_e32 v3, v0
	V_MUL_LO_I32 v3, v3, v7, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v2, v3, v2
	S_MOV_B64 s[8:9], s[4:5]
	V_MOV_B32_e32 v3, s2
	V_MOV_B32_e32 v4, s3
	BUFFER_STORE_BYTE v2, s[8:11] + v[3:4] + 0
	S_ENDPGM


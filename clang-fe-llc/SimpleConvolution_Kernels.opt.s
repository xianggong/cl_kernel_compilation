@simpleConvolution:
	.section	.AMDGPU.config
.long	47176
.long	196
.long	47180
.long	0
	.text
; BB#0:
                                        ; kill: SGPR2<def> SGPR2<kill> SGPR2_SGPR3<def>
	S_LOAD_DWORDX2 s[4:5], s[0:1], 15
	S_WAITCNT lgkmcnt(0)
	V_CVT_F32_U32_e32 v0, s4
	V_RCP_IFLAG_F32_e32 v0, v0
	V_MUL_F32_e32 v0, 1333788672, v0
	V_CVT_U32_F32_e32 v0, v0
	V_MUL_HI_U32 v1, v0, s4, 0, 0, 0, 0, 0
	V_CMP_EQ_I32_e64 s[6:7], v1, 0, 0, 0, 0, 0
	V_MUL_LO_I32 v1, v0, s4, 0, 0, 0, 0, 0
	V_SUB_I32_e32 v2, 0, v1
	V_CNDMASK_B32_e64 v1, v1, v2, s[6:7], 0, 0, 0, 0
	V_MUL_HI_U32 v1, v1, v0, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v2, v1, v0
	V_SUBREV_I32_e32 v0, v1, v0
	V_CNDMASK_B32_e64 v0, v0, v2, s[6:7], 0, 0, 0, 0
	V_MUL_HI_U32 v0, v0, s2, 0, 0, 0, 0, 0
	V_MUL_LO_I32 v1, v0, s4, 0, 0, 0, 0, 0
	V_CMP_GE_U32_e64 s[6:7], s2, v1, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v2, 0, -1, s[6:7], 0, 0, 0, 0
	V_SUB_I32_e32 v1, s2, v1
	V_MOV_B32_e32 v3, s4
	V_CMP_GE_U32_e64 s[6:7], v1, v3, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v3, 0, -1, s[6:7], 0, 0, 0, 0
	V_AND_B32_e32 v3, v3, v2
	V_CMP_EQ_I32_e64 s[6:7], v3, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v3, 1, v0
	V_CNDMASK_B32_e64 v3, v3, v0, s[6:7], 0, 0, 0, 0
	V_ADD_I32_e32 v0, -1, v0
	V_CMP_EQ_I32_e64 s[8:9], v2, 0, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v6, v3, v0, s[8:9], 0, 0, 0, 0
	V_SUBREV_I32_e32 v0, s4, v1
	V_CNDMASK_B32_e64 v0, v0, v1, s[6:7], 0, 0, 0, 0
	V_ADD_I32_e32 v1, s4, v1
	V_CNDMASK_B32_e64 v7, v0, v1, s[8:9], 0, 0, 0, 0
	S_LOAD_DWORDX2 s[6:7], s[0:1], 17
	S_WAITCNT lgkmcnt(0)
	S_ADD_I32 s8, s6, -1
	S_LSHR_B32 s16, s8, 1
	V_CMP_GE_U32_e64 s[12:13], v7, s16, 0, 0, 0, 0
	S_LOAD_DWORDX2 s[18:19], s[0:1], 13
	S_LOAD_DWORDX2 s[14:15], s[0:1], 11
	S_LOAD_DWORDX2 s[0:1], s[0:1], 9
	S_MOV_B32 s10, 0
	V_MOV_B32_e32 v0, s10
	S_WAITCNT lgkmcnt(0)
	S_AND_SAVEEXEC_B64 s[12:13], s[12:13]
	S_XOR_B64 s[12:13], exec, s[12:13]
; BB#1:
	V_SUBREV_I32_e32 v0, s16, v7
";.BB0_2":
	S_OR_B64 exec, exec, s[12:13]
	V_ADD_I32_e32 v1, s16, v7
	V_MOV_B32_e32 v2, s4
	V_CMP_LT_U32_e64 s[12:13], v1, v2, 0, 0, 0, 0
	S_AND_SAVEEXEC_B64 s[12:13], s[12:13]
	S_XOR_B64 s[12:13], exec, s[12:13]
; BB#5:
";.BB0_3":                              ; %Flow7
	S_OR_SAVEEXEC_B64 s[12:13], s[12:13]
	S_XOR_B64 exec, exec, s[12:13]
; BB#4:
	S_ADD_I32 s17, s4, -1
	V_MOV_B32_e32 v1, s17
";.BB0_6":
	S_OR_B64 exec, exec, s[12:13]
	S_ADD_I32 s12, s7, -1
	S_LSHR_B32 s17, s12, 1
	V_MOV_B32_e32 v2, s17
	V_CMP_GE_U32_e64 s[12:13], v6, v2, 0, 0, 0, 0
	V_MOV_B32_e32 v2, 0
	S_AND_SAVEEXEC_B64 s[12:13], s[12:13]
	S_XOR_B64 s[12:13], exec, s[12:13]
; BB#7:
	V_SUBREV_I32_e32 v2, s17, v6
";.BB0_8":
	S_OR_B64 exec, exec, s[12:13]
	V_ADD_I32_e32 v3, s17, v6
	V_MOV_B32_e32 v4, s5
	V_CMP_LT_U32_e64 s[12:13], v3, v4, 0, 0, 0, 0
	S_AND_SAVEEXEC_B64 s[12:13], s[12:13]
	S_XOR_B64 s[12:13], exec, s[12:13]
; BB#11:
";.BB0_9":                              ; %Flow6
	S_OR_SAVEEXEC_B64 s[12:13], s[12:13]
	S_XOR_B64 exec, exec, s[12:13]
; BB#10:
	S_ADD_I32 s20, s5, -1
	V_MOV_B32_e32 v3, s20
";.BB0_12":
	S_OR_B64 exec, exec, s[12:13]
	V_MUL_LO_I32 v4, s4, v2, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v4, v4, v0
	V_ADD_I32_e32 v5, -1, v2
	V_MOV_B32_e32 v9, 0.000000e+00
	S_MOV_B64 s[12:13], 0
	V_SUBREV_I32_e32 v7, s16, v7
	V_SUBREV_I32_e32 v8, s17, v6
	S_MOV_B64 s[8:9], s[18:19]
	S_MOV_B32 s11, 61440
	S_MOV_B64 s[16:17], s[14:15]
	S_MOV_B64 s[14:15], s[12:13]
";.BB0_13":                             ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_14 Depth 2
	V_MOV_B32_e32 v6, v9
	V_CMP_LE_U32_e64 s[20:21], v0, v1, 0, 0, 0, 0
	S_MOV_B64 s[22:23], s[12:13]
	V_MOV_B32_e32 v10, v5
	V_MOV_B32_e32 v11, v4
	V_MOV_B32_e32 v14, v6
	V_MOV_B32_e32 v13, v2
                                        ; implicit-def: VGPR9
	S_AND_SAVEEXEC_B64 s[20:21], s[20:21]
	S_XOR_B64 s[20:21], exec, s[20:21]
	S_CBRANCH_EXECZ ";.BB0_17"
";.BB0_14":                             ;   Parent Loop BB0_13 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	V_MOV_B32_e32 v9, v14
	V_ADD_I32_e32 v10, 1, v10
	V_CMP_LE_U32_e64 s[24:25], v10, v3, 0, 0, 0, 0
                                        ; implicit-def: VGPR14
	S_AND_SAVEEXEC_B64 s[24:25], s[24:25]
	S_XOR_B64 s[24:25], exec, s[24:25]
	S_CBRANCH_EXECZ ";.BB0_16"
; BB#15:                                ;   in Loop: Header=BB0_14 Depth=2
	V_SUB_I32_e32 v14, v0, v7
	V_SUB_I32_e32 v15, v13, v8
	V_MOV_B32_e32 v16, s6
	V_MUL_LO_I32 v15, v15, v16, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v14, v15, v14
	V_ASHRREV_I32_e32 v15, 31, v14
	V_LSHL_B64 v[14:15], v[14:15], 2
	BUFFER_LOAD_DWORD v14, s[8:11] + v[14:15] + 0
	V_ASHRREV_I32_e32 v12, 31, v11
	V_LSHL_B64 v[15:16], v[11:12], 2
	S_MOV_B64 s[18:19], s[10:11]
	BUFFER_LOAD_DWORD v15, s[16:19] + v[15:16] + 0
	S_WAITCNT vmcnt(0) 
	V_CVT_F32_U32_e32 v15, v15
	V_MAD_F32 v14, v15, v14, v9, 0, 0, 0, 0
	V_ADD_I32_e32 v11, s4, v11
	V_ADD_I32_e32 v13, 1, v13
";.BB0_16":                             ; %Flow
                                        ;   in Loop: Header=BB0_14 Depth=2
	S_OR_B64 exec, exec, s[24:25]
	S_OR_B64 s[22:23], s[24:25], s[22:23]
	S_ANDN2_B64 exec, exec, s[22:23]
	S_CBRANCH_EXECNZ ";.BB0_14"
; BB#18:                                ;   in Loop: Header=BB0_13 Depth=1
	S_OR_B64 exec, exec, s[22:23]
	V_ADD_I32_e32 v4, 1, v4
	V_ADD_I32_e32 v0, 1, v0
";.BB0_17":                             ; %Flow5
                                        ;   in Loop: Header=BB0_13 Depth=1
	S_OR_B64 exec, exec, s[20:21]
	S_OR_B64 s[14:15], s[20:21], s[14:15]
	S_ANDN2_B64 exec, exec, s[14:15]
	S_CBRANCH_EXECNZ ";.BB0_13"
; BB#19:
	S_OR_B64 exec, exec, s[14:15]
	S_ASHR_I32 s3, s2, 31
	S_LSHL_B64 s[2:3], s[2:3], 2
	S_MOV_B64 s[8:9], s[0:1]
	V_ADD_F32_e64 v0, v6, 5.000000e-01, 0, 0, 0, 0
	V_CVT_U32_F32_e32 v0, v0
	V_MOV_B32_e32 v1, s2
	V_MOV_B32_e32 v2, s3
	BUFFER_STORE_DWORD v0, s[8:11] + v[1:2] + 0
	S_ENDPGM


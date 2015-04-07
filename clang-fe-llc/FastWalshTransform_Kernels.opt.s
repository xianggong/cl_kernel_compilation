@fastWalshTransform:
	.section	.AMDGPU.config
.long	47176
.long	65
.long	47180
.long	0
	.text
; BB#0:
	S_LOAD_DWORD s3, s[0:1], 11
	S_WAITCNT lgkmcnt(0)
	V_CVT_F32_U32_e32 v0, s3
	V_RCP_IFLAG_F32_e32 v0, v0
	V_MUL_F32_e32 v0, 1333788672, v0
	V_CVT_U32_F32_e32 v0, v0
	V_MUL_HI_U32 v1, v0, s3, 0, 0, 0, 0, 0
	V_CMP_EQ_I32_e64 s[4:5], v1, 0, 0, 0, 0, 0
	V_MUL_LO_I32 v1, v0, s3, 0, 0, 0, 0, 0
	V_SUB_I32_e32 v2, 0, v1
	V_CNDMASK_B32_e64 v1, v1, v2, s[4:5], 0, 0, 0, 0
	V_MUL_HI_U32 v1, v1, v0, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v2, v1, v0
	V_SUBREV_I32_e32 v0, v1, v0
	V_CNDMASK_B32_e64 v0, v0, v2, s[4:5], 0, 0, 0, 0
	V_MUL_HI_U32 v0, v0, s2, 0, 0, 0, 0, 0
	V_MUL_LO_I32 v1, v0, s3, 0, 0, 0, 0, 0
	V_CMP_GE_U32_e64 s[4:5], s2, v1, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v2, 0, -1, s[4:5], 0, 0, 0, 0
	V_SUB_I32_e32 v1, s2, v1
	V_MOV_B32_e32 v3, s3
	V_CMP_GE_U32_e64 s[4:5], v1, v3, 0, 0, 0, 0
	V_CNDMASK_B32_e64 v3, 0, -1, s[4:5], 0, 0, 0, 0
	V_AND_B32_e32 v3, v3, v2
	V_CMP_EQ_I32_e64 s[4:5], v3, 0, 0, 0, 0, 0
	V_SUBREV_I32_e32 v3, s3, v1
	V_CNDMASK_B32_e64 v3, v3, v1, s[4:5], 0, 0, 0, 0
	V_CMP_EQ_I32_e64 s[6:7], v2, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v1, s3, v1
	V_CNDMASK_B32_e64 v1, v3, v1, s[6:7], 0, 0, 0, 0
	V_ADD_I32_e32 v2, 1, v0
	V_CNDMASK_B32_e64 v2, v2, v0, s[4:5], 0, 0, 0, 0
	V_ADD_I32_e32 v0, -1, v0
	V_CNDMASK_B32_e64 v0, v2, v0, s[6:7], 0, 0, 0, 0
	V_MUL_LO_I32 v0, s3, v0, 0, 0, 0, 0, 0
	V_LSHLREV_B32_e32 v0, 1, v0
	V_ADD_I32_e32 v0, v1, v0
	V_ASHRREV_I32_e32 v1, 31, v0
	V_LSHL_B64 v[2:3], v[0:1], 2
	S_LOAD_DWORDX2 s[0:1], s[0:1], 9
	S_WAITCNT lgkmcnt(0)
	S_MOV_B64 s[4:5], s[0:1]
	S_MOV_B32 s6, 0
	S_MOV_B32 s7, 61440
	BUFFER_LOAD_DWORD v4, s[4:7] + v[2:3] + 0
	V_ADD_I32_e32 v0, s3, v0
	V_ASHRREV_I32_e32 v1, 31, v0
	V_LSHL_B64 v[0:1], v[0:1], 2
	BUFFER_LOAD_DWORD v5, s[4:7] + v[0:1] + 0
	S_WAITCNT vmcnt(0) 
	V_ADD_F32_e32 v6, v4, v5
	BUFFER_STORE_DWORD v6, s[4:7] + v[2:3] + 0
	V_SUB_F32_e32 v2, v4, v5
	BUFFER_STORE_DWORD v2, s[4:7] + v[0:1] + 0
	S_ENDPGM


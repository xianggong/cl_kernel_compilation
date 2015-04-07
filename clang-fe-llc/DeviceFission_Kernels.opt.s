@Add:
	.section	.AMDGPU.config
.long	47176
.long	64
.long	47180
.long	0
	.text
; BB#0:
                                        ; kill: SGPR2<def> SGPR2<kill> SGPR2_SGPR3<def>
	S_ASHR_I32 s3, s2, 31
	S_LSHL_B64 s[2:3], s[2:3], 2
	S_LOAD_DWORDX2 s[4:5], s[0:1], 9
	S_WAITCNT lgkmcnt(0)
	S_MOV_B64 s[4:5], s[4:5]
	S_MOV_B32 s6, 0
	S_MOV_B32 s7, 61440
	V_MOV_B32_e32 v0, s2
	V_MOV_B32_e32 v1, s3
	BUFFER_LOAD_DWORD v0, s[4:7] + v[0:1] + 0
	S_WAITCNT vmcnt(0) 
	V_ADD_I32_e32 v0, 1, v0
	S_LOAD_DWORDX2 s[0:1], s[0:1], 11
	S_WAITCNT lgkmcnt(0)
	S_MOV_B64 s[4:5], s[0:1]
	V_MOV_B32_e32 v1, s2
	V_MOV_B32_e32 v2, s3
	BUFFER_STORE_DWORD v0, s[4:7] + v[1:2] + 0
	S_ENDPGM

@Sub:
	.section	.AMDGPU.config
.long	47176
.long	64
.long	47180
.long	0
	.text
; BB#0:
                                        ; kill: SGPR2<def> SGPR2<kill> SGPR2_SGPR3<def>
	S_ASHR_I32 s3, s2, 31
	S_LSHL_B64 s[2:3], s[2:3], 2
	S_LOAD_DWORDX2 s[4:5], s[0:1], 9
	S_WAITCNT lgkmcnt(0)
	S_MOV_B64 s[4:5], s[4:5]
	S_MOV_B32 s6, 0
	S_MOV_B32 s7, 61440
	V_MOV_B32_e32 v0, s2
	V_MOV_B32_e32 v1, s3
	BUFFER_LOAD_DWORD v0, s[4:7] + v[0:1] + 0
	S_WAITCNT vmcnt(0) 
	V_ADD_I32_e32 v0, -1, v0
	S_LOAD_DWORDX2 s[0:1], s[0:1], 11
	S_WAITCNT lgkmcnt(0)
	S_MOV_B64 s[4:5], s[0:1]
	V_MOV_B32_e32 v1, s2
	V_MOV_B32_e32 v2, s3
	BUFFER_STORE_DWORD v0, s[4:7] + v[1:2] + 0
	S_ENDPGM


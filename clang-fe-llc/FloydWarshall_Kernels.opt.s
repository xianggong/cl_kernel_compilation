@floydWarshallPass:
	.section	.AMDGPU.config
.long	47176
.long	65
.long	47180
.long	0
	.text
; BB#0:
	S_LOAD_DWORD s8, s[0:1], 14
	S_LOAD_DWORD s9, s[0:1], 13
	S_WAITCNT lgkmcnt(0)
	V_MOV_B32_e32 v0, s9
	V_MUL_LO_I32 v1, s8, v0, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v1, s2, v1
	V_ASHRREV_I32_e32 v2, 31, v1
	V_LSHL_B64 v[1:2], v[1:2], 2
	S_LOAD_DWORDX2 s[4:5], s[0:1], 9
	S_WAITCNT lgkmcnt(0)
	S_MOV_B64 s[4:5], s[4:5]
	S_MOV_B32 s6, 0
	S_MOV_B32 s7, 61440
	BUFFER_LOAD_DWORD v1, s[4:7] + v[1:2] + 0
	V_MUL_LO_I32 v2, s3, v0, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v3, s8, v2
	V_ASHRREV_I32_e32 v4, 31, v3
	V_LSHL_B64 v[3:4], v[3:4], 2
	BUFFER_LOAD_DWORD v0, s[4:7] + v[3:4] + 0
	S_WAITCNT vmcnt(0) 
	V_ADD_I32_e32 v0, v1, v0
	V_ADD_I32_e32 v1, s2, v2
	V_ASHRREV_I32_e32 v2, 31, v1
	V_LSHL_B64 v[1:2], v[1:2], 2
	BUFFER_LOAD_DWORD v1, s[4:7] + v[1:2] + 0
	S_WAITCNT vmcnt(0) 
	V_CMP_LT_I32_e64 s[12:13], v0, v1, 0, 0, 0, 0
	S_LOAD_DWORDX2 s[10:11], s[0:1], 11
	S_WAITCNT lgkmcnt(0)
	S_AND_SAVEEXEC_B64 s[0:1], s[12:13]
	S_XOR_B64 s[0:1], exec, s[0:1]
; BB#1:
	V_MOV_B32_e32 v1, s8
	V_MOV_B32_e32 v2, s9
	V_MUL_LO_I32 v2, s3, v2, 0, 0, 0, 0, 0
	V_ADD_I32_e32 v2, s2, v2
	V_ASHRREV_I32_e32 v3, 31, v2
	V_LSHL_B64 v[2:3], v[2:3], 2
	BUFFER_STORE_DWORD v0, s[4:7] + v[2:3] + 0
	S_MOV_B64 s[4:5], s[10:11]
	BUFFER_STORE_DWORD v1, s[4:7] + v[2:3] + 0
	S_WAITCNT vmcnt(0) expcnt(0) 
";.BB0_2":
	S_OR_B64 exec, exec, s[0:1]
	S_ENDPGM


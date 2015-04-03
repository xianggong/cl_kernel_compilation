.global copy1DFastPath

.args
	float* input 0 uav10
	float* output 16 uav11

.text

header:
	s_buffer_load_dword s13, s[2:5], 0x0
	s_buffer_load_dword s14, s[2:5], 0x1
	s_buffer_load_dword s15, s[2:5], 0x2
	s_buffer_load_dword s16, s[2:5], 0x4
	s_buffer_load_dword s17, s[2:5], 0x5
	s_buffer_load_dword s18, s[2:5], 0x6
	s_buffer_load_dword s19, s[2:5], 0x18
	s_buffer_load_dword s20, s[2:5], 0x19
	s_buffer_load_dword s21, s[2:5], 0x1a
	v_mov_b32 v3, s16
	v_mul_i32_i24 v3, s10, v3
	v_add_i32 v3, vcc, v3, v0
	v_add_i32 v3, vcc, s19, v3
	v_mov_b32 v4, s17
	v_mul_i32_i24 v4, s11, v4
	v_add_i32 v4, vcc, v4, v1
	v_add_i32 v4, vcc, s20, v4
	v_mov_b32 v5, s18
	v_mul_i32_i24 v5, s12, v5
	v_add_i32 v5, vcc, v5, v2
	v_add_i32 v5, vcc, s21, v5

uavs:
	s_load_dwordx4 s[24:27], s[0:1], 0x50
	s_load_dwordx4 s[32:35], s[0:1], 0x58

args:
	s_buffer_load_dword s22, s[6:9], 0x0
	s_waitcnt lgkmcnt(0)
	s_buffer_load_dword s28, s[6:9], 0x4
	s_waitcnt lgkmcnt(0)

:
	v_mov_b32 v8, s22
	v_mul_i32_i24 v10, 0x4, v3
	v_add_i32 v9, vcc, v10, v8
	tbuffer_load_format_x v11, v9, s[24:27], 0x0 offen format:[BUF_DATA_FORMAT_32,BUF_NUM_FORMAT_FLOAT]
	s_waitcnt vmcnt(0)
	v_mov_b32 v12, s28
	v_mul_i32_i24 v14, 0x4, v3
	v_add_i32 v13, vcc, v14, v12
	tbuffer_store_format_x v11, v13, s[32:35], 0x0 offen format:[BUF_DATA_FORMAT_32,BUF_NUM_FORMAT_FLOAT]
	s_waitcnt expcnt(0)
	s_endpgm 

.metadata
	userElements[0] = PTR_UAV_TABLE, 0, s[0:1]
	userElements[1] = IMM_CONST_BUFFER, 0, s[2:5]
	userElements[2] = IMM_CONST_BUFFER, 1, s[6:9]

	FloatMode = 192
	IeeeMode = 0

	COMPUTE_PGM_RSRC2:USER_SGPR = 10
	COMPUTE_PGM_RSRC2:TGID_X_EN = 1
	COMPUTE_PGM_RSRC2:TGID_Y_EN = 1
	COMPUTE_PGM_RSRC2:TGID_Z_EN = 1



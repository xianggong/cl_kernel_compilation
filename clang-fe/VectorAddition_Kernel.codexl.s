shader main
  asic(CI)
  type(CS)

  s_buffer_load_dword  s0, s[4:7], 0x04                 // 000000000000: C2000504
  s_buffer_load_dword  s1, s[4:7], 0x18                 // 000000000004: C2008518
  s_buffer_load_dword  s4, s[8:11], 0x00                // 000000000008: C2020900
  s_buffer_load_dword  s5, s[8:11], 0x04                // 00000000000C: C2028904
  s_buffer_load_dword  s6, s[8:11], 0x08                // 000000000010: C2030908
  s_load_dwordx4  s[8:11], s[2:3], 0x70                 // 000000000014: C0840370
  s_load_dwordx4  s[16:19], s[2:3], 0x68                // 000000000018: C0880368
  s_load_dwordx4  s[20:23], s[2:3], 0x60                // 00000000001C: C08A0360
  s_waitcnt     lgkmcnt(0)                              // 000000000020: BF8C007F
  s_min_u32     s0, s0, 0x0000ffff                      // 000000000024: 8380FF00 0000FFFF
  s_mul_i32     s0, s12, s0                             // 00000000002C: 9300000C
  s_add_i32     s0, s0, s1                              // 000000000030: 81000100
  v_add_i32     v0, vcc, s0, v0                         // 000000000034: 4A000000
  v_lshlrev_b32  v0, 2, v0                              // 000000000038: 34000082
  v_add_i32     v1, vcc, s6, v0                         // 00000000003C: 4A020006
  v_add_i32     v2, vcc, s5, v0                         // 000000000040: 4A040005
  v_add_i32     v0, vcc, s4, v0                         // 000000000044: 4A000004
  tbuffer_load_format_x  v1, v1, s[8:11], 0 offen format:[BUF_DATA_FORMAT_32,BUF_NUM_FORMAT_FLOAT] // 000000000048: EBA01000 80020101
  tbuffer_load_format_x  v2, v2, s[16:19], 0 offen format:[BUF_DATA_FORMAT_32,BUF_NUM_FORMAT_FLOAT] // 000000000050: EBA01000 80040202
  s_waitcnt     vmcnt(0)                                // 000000000058: BF8C0F70
  v_add_f32     v1, v1, v2                              // 00000000005C: 06020501
  tbuffer_store_format_x  v1, v0, s[20:23], 0 offen format:[BUF_DATA_FORMAT_32,BUF_NUM_FORMAT_FLOAT] // 000000000060: EBA41000 80050100
  s_endpgm                                              // 000000000068: BF810000
end

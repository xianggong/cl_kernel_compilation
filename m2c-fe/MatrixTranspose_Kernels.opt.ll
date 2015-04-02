; ModuleID = 'MatrixTranspose_Kernels.opt.bc'

define void @matrixTranspose(<4 x float> addrspace(1)* %output, <4 x float> addrspace(1)* %input, <4 x float>* %block) {
block_0:
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_size_u32(i32 0)
  %tmp_1 = call i32 @__get_group_id_u32(i32 0)
  %tmp_2 = call i32 @__get_group_id_u32(i32 1)
  %tmp_3 = call i32 @__get_num_groups_u32(i32 0)
  %tmp_7 = add i32 %tmp_1, %tmp_2
  %tmp_9 = urem i32 %tmp_7, %tmp_3
  %tmp_10 = call i32 @__get_local_id_u32(i32 0)
  %tmp_11 = call i32 @__get_local_id_u32(i32 1)
  %tmp_12 = call i32 @__get_local_size_u32(i32 0)
  %tmp_15 = mul i32 %tmp_9, %tmp_12
  %tmp_17 = add i32 %tmp_15, %tmp_10
  %tmp_20 = mul i32 %tmp_1, %tmp_12
  %tmp_22 = add i32 %tmp_20, %tmp_11
  %tmp_26 = mul i32 %tmp_22, %tmp_0
  %tmp_28 = mul i32 %tmp_26, 4
  %tmp_281 = add i32 %tmp_17, %tmp_28
  %tmp_31 = mul i32 %tmp_11, %tmp_12
  %tmp_33 = mul i32 %tmp_31, 4
  %tmp_34 = add i32 %tmp_33, %tmp_10
  %tmp_37 = getelementptr <4 x float>* %block, i32 %tmp_34
  %tmp_40 = getelementptr <4 x float> addrspace(1)* %input, i32 %tmp_281
  %tmp_41 = load <4 x float> addrspace(1)* %tmp_40
  store <4 x float> %tmp_41, <4 x float>* %tmp_37
  %tmp_45 = add i32 %tmp_34, %tmp_12
  %tmp_47 = getelementptr <4 x float>* %block, i32 %tmp_45
  %tmp_50 = add i32 %tmp_281, %tmp_0
  %tmp_52 = getelementptr <4 x float> addrspace(1)* %input, i32 %tmp_50
  %tmp_53 = load <4 x float> addrspace(1)* %tmp_52
  store <4 x float> %tmp_53, <4 x float>* %tmp_47
  %tmp_58 = mul i32 %tmp_12, 2
  %tmp_583 = add i32 %tmp_34, %tmp_58
  %tmp_60 = getelementptr <4 x float>* %block, i32 %tmp_583
  %tmp_64 = mul i32 %tmp_0, 2
  %tmp_644 = add i32 %tmp_281, %tmp_64
  %tmp_66 = getelementptr <4 x float> addrspace(1)* %input, i32 %tmp_644
  %tmp_67 = load <4 x float> addrspace(1)* %tmp_66
  store <4 x float> %tmp_67, <4 x float>* %tmp_60
  %tmp_72 = mul i32 %tmp_12, 3
  %tmp_725 = add i32 %tmp_34, %tmp_72
  %tmp_74 = getelementptr <4 x float>* %block, i32 %tmp_725
  %tmp_78 = mul i32 %tmp_0, 3
  %tmp_786 = add i32 %tmp_281, %tmp_78
  %tmp_80 = getelementptr <4 x float> addrspace(1)* %input, i32 %tmp_786
  %tmp_81 = load <4 x float> addrspace(1)* %tmp_80
  store <4 x float> %tmp_81, <4 x float>* %tmp_74
  call void @__barrier_u32(i32 1)
  %tmp_85 = mul i32 %tmp_1, %tmp_12
  %tmp_87 = add i32 %tmp_85, %tmp_10
  %tmp_90 = mul i32 %tmp_9, %tmp_12
  %tmp_92 = add i32 %tmp_90, %tmp_11
  %tmp_96 = mul i32 %tmp_92, %tmp_0
  %tmp_98 = mul i32 %tmp_96, 4
  %tmp_987 = add i32 %tmp_87, %tmp_98
  %tmp_101 = mul i32 %tmp_10, %tmp_12
  %tmp_103 = mul i32 %tmp_101, 4
  %tmp_104 = add i32 %tmp_103, %tmp_11
  %tmp_107 = getelementptr <4 x float>* %block, i32 %tmp_104
  %tmp_108 = load <4 x float>* %tmp_107
  %tmp_111 = add i32 %tmp_104, %tmp_12
  %tmp_113 = getelementptr <4 x float>* %block, i32 %tmp_111
  %tmp_114 = load <4 x float>* %tmp_113
  %tmp_118 = mul i32 %tmp_12, 2
  %tmp_1189 = add i32 %tmp_104, %tmp_118
  %tmp_120 = getelementptr <4 x float>* %block, i32 %tmp_1189
  %tmp_121 = load <4 x float>* %tmp_120
  %tmp_125 = mul i32 %tmp_12, 3
  %tmp_12510 = add i32 %tmp_104, %tmp_125
  %tmp_127 = getelementptr <4 x float>* %block, i32 %tmp_12510
  %tmp_128 = load <4 x float>* %tmp_127
  %tmp_131 = getelementptr <4 x float> addrspace(1)* %output, i32 %tmp_987
  %tmp_133 = extractelement <4 x float> %tmp_108, i32 0
  %tmp_135 = extractelement <4 x float> %tmp_114, i32 0
  %tmp_137 = extractelement <4 x float> %tmp_121, i32 0
  %tmp_139 = extractelement <4 x float> %tmp_128, i32 0
  %tmp_148 = insertelement <4 x float> undef, float %tmp_133, i32 0
  %tmp_152 = insertelement <4 x float> %tmp_148, float %tmp_135, i32 1
  %tmp_156 = insertelement <4 x float> %tmp_152, float %tmp_137, i32 2
  %tmp_160 = insertelement <4 x float> %tmp_156, float %tmp_139, i32 3
  store <4 x float> %tmp_160, <4 x float> addrspace(1)* %tmp_131
  %tmp_164 = add i32 %tmp_987, %tmp_0
  %tmp_166 = getelementptr <4 x float> addrspace(1)* %output, i32 %tmp_164
  %tmp_168 = extractelement <4 x float> %tmp_108, i32 1
  %tmp_170 = extractelement <4 x float> %tmp_114, i32 1
  %tmp_172 = extractelement <4 x float> %tmp_121, i32 1
  %tmp_174 = extractelement <4 x float> %tmp_128, i32 1
  %tmp_183 = insertelement <4 x float> undef, float %tmp_168, i32 0
  %tmp_187 = insertelement <4 x float> %tmp_183, float %tmp_170, i32 1
  %tmp_191 = insertelement <4 x float> %tmp_187, float %tmp_172, i32 2
  %tmp_195 = insertelement <4 x float> %tmp_191, float %tmp_174, i32 3
  store <4 x float> %tmp_195, <4 x float> addrspace(1)* %tmp_166
  %tmp_200 = mul i32 %tmp_0, 2
  %tmp_20011 = add i32 %tmp_987, %tmp_200
  %tmp_202 = getelementptr <4 x float> addrspace(1)* %output, i32 %tmp_20011
  %tmp_204 = extractelement <4 x float> %tmp_108, i32 2
  %tmp_206 = extractelement <4 x float> %tmp_114, i32 2
  %tmp_208 = extractelement <4 x float> %tmp_121, i32 2
  %tmp_210 = extractelement <4 x float> %tmp_128, i32 2
  %tmp_219 = insertelement <4 x float> undef, float %tmp_204, i32 0
  %tmp_223 = insertelement <4 x float> %tmp_219, float %tmp_206, i32 1
  %tmp_227 = insertelement <4 x float> %tmp_223, float %tmp_208, i32 2
  %tmp_231 = insertelement <4 x float> %tmp_227, float %tmp_210, i32 3
  store <4 x float> %tmp_231, <4 x float> addrspace(1)* %tmp_202
  %tmp_236 = mul i32 %tmp_0, 3
  %tmp_23612 = add i32 %tmp_987, %tmp_236
  %tmp_238 = getelementptr <4 x float> addrspace(1)* %output, i32 %tmp_23612
  %tmp_240 = extractelement <4 x float> %tmp_108, i32 3
  %tmp_242 = extractelement <4 x float> %tmp_114, i32 3
  %tmp_244 = extractelement <4 x float> %tmp_121, i32 3
  %tmp_246 = extractelement <4 x float> %tmp_128, i32 3
  %tmp_255 = insertelement <4 x float> undef, float %tmp_240, i32 0
  %tmp_259 = insertelement <4 x float> %tmp_255, float %tmp_242, i32 1
  %tmp_263 = insertelement <4 x float> %tmp_259, float %tmp_244, i32 2
  %tmp_267 = insertelement <4 x float> %tmp_263, float %tmp_246, i32 3
  store <4 x float> %tmp_267, <4 x float> addrspace(1)* %tmp_238
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_size_u32(i32) #0

; Function Attrs: nounwind
declare i32 @__get_group_id_u32(i32) #0

; Function Attrs: nounwind
declare i32 @__get_num_groups_u32(i32) #0

; Function Attrs: nounwind
declare i32 @__get_local_id_u32(i32) #0

; Function Attrs: nounwind
declare i32 @__get_local_size_u32(i32) #0

; Function Attrs: nounwind
declare void @__barrier_u32(i32) #0

attributes #0 = { nounwind }

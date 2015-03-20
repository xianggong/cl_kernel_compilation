; ModuleID = 'MatrixTranspose_Kernels.llvm'

define void @matrixTranspose(<4 x float> addrspace(1)* %output, <4 x float> addrspace(1)* %input, <4 x float>* %block) {
block_0:
  %output_addr = alloca <4 x float> addrspace(1)*
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %output_addr
  %input_addr = alloca <4 x float> addrspace(1)*
  store <4 x float> addrspace(1)* %input, <4 x float> addrspace(1)** %input_addr
  %block_addr = alloca <4 x float>*
  store <4 x float>* %block, <4 x float>** %block_addr
  %wiWidth = alloca i32
  %gix_t = alloca i32
  %giy_t = alloca i32
  %num_of_blocks_x = alloca i32
  %giy = alloca i32
  %gix = alloca i32
  %lix = alloca i32
  %liy = alloca i32
  %blockSize = alloca i32
  %ix = alloca i32
  %iy = alloca i32
  %index_in = alloca i32
  %ind = alloca i32
  %index_out = alloca i32
  %v0 = alloca <4 x float>
  %v1 = alloca <4 x float>
  %v2 = alloca <4 x float>
  %v3 = alloca <4 x float>
  %tmp_140 = alloca <4 x float>
  %tmp_175 = alloca <4 x float>
  %tmp_211 = alloca <4 x float>
  %tmp_247 = alloca <4 x float>
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_0, i32* %wiWidth
  %tmp_1 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_1, i32* %gix_t
  %tmp_2 = call i32 @__get_group_id_u32(i32 1)
  store i32 %tmp_2, i32* %giy_t
  %tmp_3 = call i32 @__get_num_groups_u32(i32 0)
  store i32 %tmp_3, i32* %num_of_blocks_x
  %tmp_4 = load i32* %gix_t
  store i32 %tmp_4, i32* %giy
  %tmp_5 = load i32* %gix_t
  %tmp_6 = load i32* %giy_t
  %tmp_7 = add i32 %tmp_5, %tmp_6
  %tmp_8 = load i32* %num_of_blocks_x
  %tmp_9 = urem i32 %tmp_7, %tmp_8
  store i32 %tmp_9, i32* %gix
  %tmp_10 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_10, i32* %lix
  %tmp_11 = call i32 @__get_local_id_u32(i32 1)
  store i32 %tmp_11, i32* %liy
  %tmp_12 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_12, i32* %blockSize
  %tmp_13 = load i32* %gix
  %tmp_14 = load i32* %blockSize
  %tmp_15 = mul i32 %tmp_13, %tmp_14
  %tmp_16 = load i32* %lix
  %tmp_17 = add i32 %tmp_15, %tmp_16
  store i32 %tmp_17, i32* %ix
  %tmp_18 = load i32* %giy
  %tmp_19 = load i32* %blockSize
  %tmp_20 = mul i32 %tmp_18, %tmp_19
  %tmp_21 = load i32* %liy
  %tmp_22 = add i32 %tmp_20, %tmp_21
  store i32 %tmp_22, i32* %iy
  %tmp_23 = load i32* %ix
  %tmp_24 = load i32* %iy
  %tmp_25 = load i32* %wiWidth
  %tmp_26 = mul i32 %tmp_24, %tmp_25
  %tmp_28 = mul i32 %tmp_26, 4
  %tmp_281 = add i32 %tmp_23, %tmp_28
  store i32 %tmp_281, i32* %index_in
  %tmp_29 = load i32* %liy
  %tmp_30 = load i32* %blockSize
  %tmp_31 = mul i32 %tmp_29, %tmp_30
  %tmp_33 = mul i32 %tmp_31, 4
  %tmp_332 = load i32* %lix
  %tmp_34 = add i32 %tmp_33, %tmp_332
  store i32 %tmp_34, i32* %ind
  %tmp_35 = load i32* %ind
  %tmp_36 = load <4 x float>** %block_addr
  %tmp_37 = getelementptr <4 x float>* %tmp_36, i32 %tmp_35
  %tmp_38 = load i32* %index_in
  %tmp_39 = load <4 x float> addrspace(1)** %input_addr
  %tmp_40 = getelementptr <4 x float> addrspace(1)* %tmp_39, i32 %tmp_38
  %tmp_41 = load <4 x float> addrspace(1)* %tmp_40
  store <4 x float> %tmp_41, <4 x float>* %tmp_37
  %tmp_43 = load i32* %ind
  %tmp_44 = load i32* %blockSize
  %tmp_45 = add i32 %tmp_43, %tmp_44
  %tmp_46 = load <4 x float>** %block_addr
  %tmp_47 = getelementptr <4 x float>* %tmp_46, i32 %tmp_45
  %tmp_48 = load i32* %index_in
  %tmp_49 = load i32* %wiWidth
  %tmp_50 = add i32 %tmp_48, %tmp_49
  %tmp_51 = load <4 x float> addrspace(1)** %input_addr
  %tmp_52 = getelementptr <4 x float> addrspace(1)* %tmp_51, i32 %tmp_50
  %tmp_53 = load <4 x float> addrspace(1)* %tmp_52
  store <4 x float> %tmp_53, <4 x float>* %tmp_47
  %tmp_55 = load i32* %ind
  %tmp_56 = load i32* %blockSize
  %tmp_58 = mul i32 %tmp_56, 2
  %tmp_583 = add i32 %tmp_55, %tmp_58
  %tmp_59 = load <4 x float>** %block_addr
  %tmp_60 = getelementptr <4 x float>* %tmp_59, i32 %tmp_583
  %tmp_61 = load i32* %index_in
  %tmp_62 = load i32* %wiWidth
  %tmp_64 = mul i32 %tmp_62, 2
  %tmp_644 = add i32 %tmp_61, %tmp_64
  %tmp_65 = load <4 x float> addrspace(1)** %input_addr
  %tmp_66 = getelementptr <4 x float> addrspace(1)* %tmp_65, i32 %tmp_644
  %tmp_67 = load <4 x float> addrspace(1)* %tmp_66
  store <4 x float> %tmp_67, <4 x float>* %tmp_60
  %tmp_69 = load i32* %ind
  %tmp_70 = load i32* %blockSize
  %tmp_72 = mul i32 %tmp_70, 3
  %tmp_725 = add i32 %tmp_69, %tmp_72
  %tmp_73 = load <4 x float>** %block_addr
  %tmp_74 = getelementptr <4 x float>* %tmp_73, i32 %tmp_725
  %tmp_75 = load i32* %index_in
  %tmp_76 = load i32* %wiWidth
  %tmp_78 = mul i32 %tmp_76, 3
  %tmp_786 = add i32 %tmp_75, %tmp_78
  %tmp_79 = load <4 x float> addrspace(1)** %input_addr
  %tmp_80 = getelementptr <4 x float> addrspace(1)* %tmp_79, i32 %tmp_786
  %tmp_81 = load <4 x float> addrspace(1)* %tmp_80
  store <4 x float> %tmp_81, <4 x float>* %tmp_74
  call void @__barrier_u32(i32 1)
  %tmp_83 = load i32* %giy
  %tmp_84 = load i32* %blockSize
  %tmp_85 = mul i32 %tmp_83, %tmp_84
  %tmp_86 = load i32* %lix
  %tmp_87 = add i32 %tmp_85, %tmp_86
  store i32 %tmp_87, i32* %ix
  %tmp_88 = load i32* %gix
  %tmp_89 = load i32* %blockSize
  %tmp_90 = mul i32 %tmp_88, %tmp_89
  %tmp_91 = load i32* %liy
  %tmp_92 = add i32 %tmp_90, %tmp_91
  store i32 %tmp_92, i32* %iy
  %tmp_93 = load i32* %ix
  %tmp_94 = load i32* %iy
  %tmp_95 = load i32* %wiWidth
  %tmp_96 = mul i32 %tmp_94, %tmp_95
  %tmp_98 = mul i32 %tmp_96, 4
  %tmp_987 = add i32 %tmp_93, %tmp_98
  store i32 %tmp_987, i32* %index_out
  %tmp_99 = load i32* %lix
  %tmp_100 = load i32* %blockSize
  %tmp_101 = mul i32 %tmp_99, %tmp_100
  %tmp_103 = mul i32 %tmp_101, 4
  %tmp_1038 = load i32* %liy
  %tmp_104 = add i32 %tmp_103, %tmp_1038
  store i32 %tmp_104, i32* %ind
  %tmp_105 = load i32* %ind
  %tmp_106 = load <4 x float>** %block_addr
  %tmp_107 = getelementptr <4 x float>* %tmp_106, i32 %tmp_105
  %tmp_108 = load <4 x float>* %tmp_107
  store <4 x float> %tmp_108, <4 x float>* %v0
  %tmp_109 = load i32* %ind
  %tmp_110 = load i32* %blockSize
  %tmp_111 = add i32 %tmp_109, %tmp_110
  %tmp_112 = load <4 x float>** %block_addr
  %tmp_113 = getelementptr <4 x float>* %tmp_112, i32 %tmp_111
  %tmp_114 = load <4 x float>* %tmp_113
  store <4 x float> %tmp_114, <4 x float>* %v1
  %tmp_115 = load i32* %ind
  %tmp_116 = load i32* %blockSize
  %tmp_118 = mul i32 %tmp_116, 2
  %tmp_1189 = add i32 %tmp_115, %tmp_118
  %tmp_119 = load <4 x float>** %block_addr
  %tmp_120 = getelementptr <4 x float>* %tmp_119, i32 %tmp_1189
  %tmp_121 = load <4 x float>* %tmp_120
  store <4 x float> %tmp_121, <4 x float>* %v2
  %tmp_122 = load i32* %ind
  %tmp_123 = load i32* %blockSize
  %tmp_125 = mul i32 %tmp_123, 3
  %tmp_12510 = add i32 %tmp_122, %tmp_125
  %tmp_126 = load <4 x float>** %block_addr
  %tmp_127 = getelementptr <4 x float>* %tmp_126, i32 %tmp_12510
  %tmp_128 = load <4 x float>* %tmp_127
  store <4 x float> %tmp_128, <4 x float>* %v3
  %tmp_129 = load i32* %index_out
  %tmp_130 = load <4 x float> addrspace(1)** %output_addr
  %tmp_131 = getelementptr <4 x float> addrspace(1)* %tmp_130, i32 %tmp_129
  %tmp_132 = load <4 x float>* %v0
  %tmp_133 = extractelement <4 x float> %tmp_132, i32 0
  %tmp_134 = load <4 x float>* %v1
  %tmp_135 = extractelement <4 x float> %tmp_134, i32 0
  %tmp_136 = load <4 x float>* %v2
  %tmp_137 = extractelement <4 x float> %tmp_136, i32 0
  %tmp_138 = load <4 x float>* %v3
  %tmp_139 = extractelement <4 x float> %tmp_138, i32 0
  %tmp_146 = load <4 x float>* %tmp_140
  %tmp_148 = insertelement <4 x float> %tmp_146, float %tmp_133, i32 0
  store <4 x float> %tmp_148, <4 x float>* %tmp_140
  %tmp_150 = load <4 x float>* %tmp_140
  %tmp_152 = insertelement <4 x float> %tmp_150, float %tmp_135, i32 1
  store <4 x float> %tmp_152, <4 x float>* %tmp_140
  %tmp_154 = load <4 x float>* %tmp_140
  %tmp_156 = insertelement <4 x float> %tmp_154, float %tmp_137, i32 2
  store <4 x float> %tmp_156, <4 x float>* %tmp_140
  %tmp_158 = load <4 x float>* %tmp_140
  %tmp_160 = insertelement <4 x float> %tmp_158, float %tmp_139, i32 3
  store <4 x float> %tmp_160, <4 x float>* %tmp_140
  store <4 x float> %tmp_160, <4 x float> addrspace(1)* %tmp_131
  %tmp_162 = load i32* %index_out
  %tmp_163 = load i32* %wiWidth
  %tmp_164 = add i32 %tmp_162, %tmp_163
  %tmp_165 = load <4 x float> addrspace(1)** %output_addr
  %tmp_166 = getelementptr <4 x float> addrspace(1)* %tmp_165, i32 %tmp_164
  %tmp_167 = load <4 x float>* %v0
  %tmp_168 = extractelement <4 x float> %tmp_167, i32 1
  %tmp_169 = load <4 x float>* %v1
  %tmp_170 = extractelement <4 x float> %tmp_169, i32 1
  %tmp_171 = load <4 x float>* %v2
  %tmp_172 = extractelement <4 x float> %tmp_171, i32 1
  %tmp_173 = load <4 x float>* %v3
  %tmp_174 = extractelement <4 x float> %tmp_173, i32 1
  %tmp_181 = load <4 x float>* %tmp_175
  %tmp_183 = insertelement <4 x float> %tmp_181, float %tmp_168, i32 0
  store <4 x float> %tmp_183, <4 x float>* %tmp_175
  %tmp_185 = load <4 x float>* %tmp_175
  %tmp_187 = insertelement <4 x float> %tmp_185, float %tmp_170, i32 1
  store <4 x float> %tmp_187, <4 x float>* %tmp_175
  %tmp_189 = load <4 x float>* %tmp_175
  %tmp_191 = insertelement <4 x float> %tmp_189, float %tmp_172, i32 2
  store <4 x float> %tmp_191, <4 x float>* %tmp_175
  %tmp_193 = load <4 x float>* %tmp_175
  %tmp_195 = insertelement <4 x float> %tmp_193, float %tmp_174, i32 3
  store <4 x float> %tmp_195, <4 x float>* %tmp_175
  store <4 x float> %tmp_195, <4 x float> addrspace(1)* %tmp_166
  %tmp_197 = load i32* %index_out
  %tmp_198 = load i32* %wiWidth
  %tmp_200 = mul i32 %tmp_198, 2
  %tmp_20011 = add i32 %tmp_197, %tmp_200
  %tmp_201 = load <4 x float> addrspace(1)** %output_addr
  %tmp_202 = getelementptr <4 x float> addrspace(1)* %tmp_201, i32 %tmp_20011
  %tmp_203 = load <4 x float>* %v0
  %tmp_204 = extractelement <4 x float> %tmp_203, i32 2
  %tmp_205 = load <4 x float>* %v1
  %tmp_206 = extractelement <4 x float> %tmp_205, i32 2
  %tmp_207 = load <4 x float>* %v2
  %tmp_208 = extractelement <4 x float> %tmp_207, i32 2
  %tmp_209 = load <4 x float>* %v3
  %tmp_210 = extractelement <4 x float> %tmp_209, i32 2
  %tmp_217 = load <4 x float>* %tmp_211
  %tmp_219 = insertelement <4 x float> %tmp_217, float %tmp_204, i32 0
  store <4 x float> %tmp_219, <4 x float>* %tmp_211
  %tmp_221 = load <4 x float>* %tmp_211
  %tmp_223 = insertelement <4 x float> %tmp_221, float %tmp_206, i32 1
  store <4 x float> %tmp_223, <4 x float>* %tmp_211
  %tmp_225 = load <4 x float>* %tmp_211
  %tmp_227 = insertelement <4 x float> %tmp_225, float %tmp_208, i32 2
  store <4 x float> %tmp_227, <4 x float>* %tmp_211
  %tmp_229 = load <4 x float>* %tmp_211
  %tmp_231 = insertelement <4 x float> %tmp_229, float %tmp_210, i32 3
  store <4 x float> %tmp_231, <4 x float>* %tmp_211
  store <4 x float> %tmp_231, <4 x float> addrspace(1)* %tmp_202
  %tmp_233 = load i32* %index_out
  %tmp_234 = load i32* %wiWidth
  %tmp_236 = mul i32 %tmp_234, 3
  %tmp_23612 = add i32 %tmp_233, %tmp_236
  %tmp_237 = load <4 x float> addrspace(1)** %output_addr
  %tmp_238 = getelementptr <4 x float> addrspace(1)* %tmp_237, i32 %tmp_23612
  %tmp_239 = load <4 x float>* %v0
  %tmp_240 = extractelement <4 x float> %tmp_239, i32 3
  %tmp_241 = load <4 x float>* %v1
  %tmp_242 = extractelement <4 x float> %tmp_241, i32 3
  %tmp_243 = load <4 x float>* %v2
  %tmp_244 = extractelement <4 x float> %tmp_243, i32 3
  %tmp_245 = load <4 x float>* %v3
  %tmp_246 = extractelement <4 x float> %tmp_245, i32 3
  %tmp_253 = load <4 x float>* %tmp_247
  %tmp_255 = insertelement <4 x float> %tmp_253, float %tmp_240, i32 0
  store <4 x float> %tmp_255, <4 x float>* %tmp_247
  %tmp_257 = load <4 x float>* %tmp_247
  %tmp_259 = insertelement <4 x float> %tmp_257, float %tmp_242, i32 1
  store <4 x float> %tmp_259, <4 x float>* %tmp_247
  %tmp_261 = load <4 x float>* %tmp_247
  %tmp_263 = insertelement <4 x float> %tmp_261, float %tmp_244, i32 2
  store <4 x float> %tmp_263, <4 x float>* %tmp_247
  %tmp_265 = load <4 x float>* %tmp_247
  %tmp_267 = insertelement <4 x float> %tmp_265, float %tmp_246, i32 3
  store <4 x float> %tmp_267, <4 x float>* %tmp_247
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

; ModuleID = 'ScanLargeArrays_Kernels.llvm'

@aclocal_value = external addrspace(3) global [1 x float]

define void @blockAddition(float addrspace(1)* %input, float addrspace(1)* %output) {
block_0:
  %input_addr = alloca float addrspace(1)*
  store float addrspace(1)* %input, float addrspace(1)** %input_addr
  %output_addr = alloca float addrspace(1)*
  store float addrspace(1)* %output, float addrspace(1)** %output_addr
  %globalId = alloca i32
  %groupId = alloca i32
  %localId = alloca i32
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_0, i32* %globalId
  %tmp_1 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_1, i32* %groupId
  %tmp_2 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_2, i32* %localId
  %tmp_3 = load i32* %localId
  %tmp_4 = icmp eq i32 %tmp_3, 0
  %tmp_5 = sext i1 %tmp_4 to i32
  %tmp_6 = icmp ne i32 %tmp_5, 0
  br i1 %tmp_6, label %block_3, label %block_2

block_2:                                          ; preds = %block_3, %block_1
  call void @__barrier_u32(i32 1)
  %tmp_14 = load i32* %globalId
  %tmp_15 = load float addrspace(1)** %output_addr
  %tmp_16 = getelementptr float addrspace(1)* %tmp_15, i32 %tmp_14
  %tmp_19 = load float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @aclocal_value, i32 0, i32 0)
  %tmp_20 = load float addrspace(1)* %tmp_16
  %tmp_21 = fadd float %tmp_20, %tmp_19
  store float %tmp_21, float addrspace(1)* %tmp_16
  ret void

block_3:                                          ; preds = %block_1
  %tmp_9 = load i32* %groupId
  %tmp_10 = load float addrspace(1)** %input_addr
  %tmp_11 = getelementptr float addrspace(1)* %tmp_10, i32 %tmp_9
  %tmp_12 = load float addrspace(1)* %tmp_11
  store float %tmp_12, float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @aclocal_value, i32 0, i32 0)
  br label %block_2
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

; Function Attrs: nounwind
declare i32 @__get_group_id_u32(i32) #0

; Function Attrs: nounwind
declare i32 @__get_local_id_u32(i32) #0

; Function Attrs: nounwind
declare void @__barrier_u32(i32) #0

define void @ScanLargeArrays(float addrspace(1)* %output, float addrspace(1)* %input, float* %block, i32 %block_size, float addrspace(1)* %sumBuffer) {
block_4:
  %output_addr = alloca float addrspace(1)*
  store float addrspace(1)* %output, float addrspace(1)** %output_addr
  %input_addr = alloca float addrspace(1)*
  store float addrspace(1)* %input, float addrspace(1)** %input_addr
  %block_addr = alloca float*
  store float* %block, float** %block_addr
  %block_size_addr = alloca i32
  store i32 %block_size, i32* %block_size_addr
  %sumBuffer_addr = alloca float addrspace(1)*
  store float addrspace(1)* %sumBuffer, float addrspace(1)** %sumBuffer_addr
  %tid = alloca i32
  %gid = alloca i32
  %bid = alloca i32
  %cache0 = alloca float
  %cache1 = alloca float
  %stride = alloca i32
  br label %block_5

block_5:                                          ; preds = %block_4
  %tmp_23 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_23, i32* %tid
  %tmp_24 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_24, i32* %gid
  %tmp_25 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_25, i32* %bid
  %tmp_26 = load i32* %tid
  %tmp_27 = mul i32 2, %tmp_26
  %tmp_28 = load float** %block_addr
  %tmp_29 = getelementptr float* %tmp_28, i32 %tmp_27
  %tmp_30 = load i32* %gid
  %tmp_31 = mul i32 2, %tmp_30
  %tmp_32 = load float addrspace(1)** %input_addr
  %tmp_33 = getelementptr float addrspace(1)* %tmp_32, i32 %tmp_31
  %tmp_34 = load float addrspace(1)* %tmp_33
  store float %tmp_34, float* %tmp_29
  %tmp_36 = load i32* %tid
  %tmp_37 = mul i32 2, %tmp_36
  %tmp_38 = add i32 %tmp_37, 1
  %tmp_39 = load float** %block_addr
  %tmp_40 = getelementptr float* %tmp_39, i32 %tmp_38
  %tmp_41 = load i32* %gid
  %tmp_42 = mul i32 2, %tmp_41
  %tmp_43 = add i32 %tmp_42, 1
  %tmp_44 = load float addrspace(1)** %input_addr
  %tmp_45 = getelementptr float addrspace(1)* %tmp_44, i32 %tmp_43
  %tmp_46 = load float addrspace(1)* %tmp_45
  store float %tmp_46, float* %tmp_40
  call void @__barrier_u32(i32 1)
  %tmp_48 = load float** %block_addr
  %tmp_49 = getelementptr float* %tmp_48, i32 0
  %tmp_50 = load float* %tmp_49
  store float %tmp_50, float* %cache0
  %tmp_52 = load float* %cache0
  %tmp_53 = load float** %block_addr
  %tmp_54 = getelementptr float* %tmp_53, i32 1
  %tmp_55 = load float* %tmp_54
  %tmp_56 = fadd float %tmp_52, %tmp_55
  store float %tmp_56, float* %cache1
  store i32 1, i32* %stride
  br label %block_6

block_6:                                          ; preds = %block_8, %block_5
  %tmp_58 = load i32* %stride
  %tmp_59 = load i32* %block_size_addr
  %tmp_60 = icmp slt i32 %tmp_58, %tmp_59
  %tmp_61 = sext i1 %tmp_60 to i32
  %tmp_62 = icmp ne i32 %tmp_61, 0
  br i1 %tmp_62, label %block_7, label %block_9

block_7:                                          ; preds = %block_6
  %tmp_65 = load i32* %tid
  %tmp_66 = mul i32 2, %tmp_65
  %tmp_67 = load i32* %stride
  %tmp_68 = icmp sge i32 %tmp_66, %tmp_67
  %tmp_69 = sext i1 %tmp_68 to i32
  %tmp_70 = icmp ne i32 %tmp_69, 0
  br i1 %tmp_70, label %block_11, label %block_10

block_8:                                          ; preds = %block_10
  %tmp_63 = load i32* %stride
  %tmp_64 = mul i32 %tmp_63, 2
  store i32 %tmp_64, i32* %stride
  br label %block_6

block_9:                                          ; preds = %block_6
  %tmp_114 = load i32* %bid
  %tmp_115 = load float addrspace(1)** %sumBuffer_addr
  %tmp_116 = getelementptr float addrspace(1)* %tmp_115, i32 %tmp_114
  %tmp_117 = load i32* %block_size_addr
  %tmp_118 = sub i32 %tmp_117, 1
  %tmp_119 = load float** %block_addr
  %tmp_120 = getelementptr float* %tmp_119, i32 %tmp_118
  %tmp_121 = load float* %tmp_120
  store float %tmp_121, float addrspace(1)* %tmp_116
  %tmp_123 = load i32* %tid
  %tmp_124 = icmp eq i32 %tmp_123, 0
  %tmp_125 = sext i1 %tmp_124 to i32
  %tmp_126 = icmp ne i32 %tmp_125, 0
  br i1 %tmp_126, label %block_13, label %block_12

block_10:                                         ; preds = %block_11, %block_7
  call void @__barrier_u32(i32 1)
  %tmp_101 = load i32* %tid
  %tmp_102 = mul i32 2, %tmp_101
  %tmp_103 = load float** %block_addr
  %tmp_104 = getelementptr float* %tmp_103, i32 %tmp_102
  %tmp_105 = load float* %cache0
  store float %tmp_105, float* %tmp_104
  %tmp_107 = load i32* %tid
  %tmp_108 = mul i32 2, %tmp_107
  %tmp_109 = add i32 %tmp_108, 1
  %tmp_110 = load float** %block_addr
  %tmp_111 = getelementptr float* %tmp_110, i32 %tmp_109
  %tmp_112 = load float* %cache1
  store float %tmp_112, float* %tmp_111
  call void @__barrier_u32(i32 1)
  br label %block_8

block_11:                                         ; preds = %block_7
  %tmp_71 = load i32* %tid
  %tmp_72 = mul i32 2, %tmp_71
  %tmp_73 = load i32* %stride
  %tmp_74 = sub i32 %tmp_72, %tmp_73
  %tmp_75 = load float** %block_addr
  %tmp_76 = getelementptr float* %tmp_75, i32 %tmp_74
  %tmp_77 = load float* %tmp_76
  %tmp_78 = load i32* %tid
  %tmp_79 = mul i32 2, %tmp_78
  %tmp_80 = load float** %block_addr
  %tmp_81 = getelementptr float* %tmp_80, i32 %tmp_79
  %tmp_82 = load float* %tmp_81
  %tmp_83 = fadd float %tmp_77, %tmp_82
  store float %tmp_83, float* %cache0
  %tmp_85 = load i32* %tid
  %tmp_86 = mul i32 2, %tmp_85
  %tmp_87 = add i32 %tmp_86, 1
  %tmp_88 = load i32* %stride
  %tmp_89 = sub i32 %tmp_87, %tmp_88
  %tmp_90 = load float** %block_addr
  %tmp_91 = getelementptr float* %tmp_90, i32 %tmp_89
  %tmp_92 = load float* %tmp_91
  %tmp_93 = load i32* %tid
  %tmp_94 = mul i32 2, %tmp_93
  %tmp_95 = add i32 %tmp_94, 1
  %tmp_96 = load float** %block_addr
  %tmp_97 = getelementptr float* %tmp_96, i32 %tmp_95
  %tmp_98 = load float* %tmp_97
  %tmp_99 = fadd float %tmp_92, %tmp_98
  store float %tmp_99, float* %cache1
  br label %block_10

block_12:                                         ; preds = %block_9
  %tmp_143 = load i32* %gid
  %tmp_144 = mul i32 2, %tmp_143
  %tmp_145 = load float addrspace(1)** %output_addr
  %tmp_146 = getelementptr float addrspace(1)* %tmp_145, i32 %tmp_144
  %tmp_147 = load i32* %tid
  %tmp_148 = mul i32 2, %tmp_147
  %tmp_149 = sub i32 %tmp_148, 1
  %tmp_150 = load float** %block_addr
  %tmp_151 = getelementptr float* %tmp_150, i32 %tmp_149
  %tmp_152 = load float* %tmp_151
  store float %tmp_152, float addrspace(1)* %tmp_146
  %tmp_154 = load i32* %gid
  %tmp_155 = mul i32 2, %tmp_154
  %tmp_156 = add i32 %tmp_155, 1
  %tmp_157 = load float addrspace(1)** %output_addr
  %tmp_158 = getelementptr float addrspace(1)* %tmp_157, i32 %tmp_156
  %tmp_159 = load i32* %tid
  %tmp_160 = mul i32 2, %tmp_159
  %tmp_161 = load float** %block_addr
  %tmp_162 = getelementptr float* %tmp_161, i32 %tmp_160
  %tmp_163 = load float* %tmp_162
  store float %tmp_163, float addrspace(1)* %tmp_158
  br label %block_14

block_13:                                         ; preds = %block_9
  %tmp_127 = load i32* %gid
  %tmp_128 = mul i32 2, %tmp_127
  %tmp_129 = load float addrspace(1)** %output_addr
  %tmp_130 = getelementptr float addrspace(1)* %tmp_129, i32 %tmp_128
  store float 0.000000e+00, float addrspace(1)* %tmp_130
  %tmp_132 = load i32* %gid
  %tmp_133 = mul i32 2, %tmp_132
  %tmp_134 = add i32 %tmp_133, 1
  %tmp_135 = load float addrspace(1)** %output_addr
  %tmp_136 = getelementptr float addrspace(1)* %tmp_135, i32 %tmp_134
  %tmp_137 = load i32* %tid
  %tmp_138 = mul i32 2, %tmp_137
  %tmp_139 = load float** %block_addr
  %tmp_140 = getelementptr float* %tmp_139, i32 %tmp_138
  %tmp_141 = load float* %tmp_140
  store float %tmp_141, float addrspace(1)* %tmp_136
  br label %block_14

block_14:                                         ; preds = %block_13, %block_12
  ret void
}

define void @prefixSum(float addrspace(1)* %output, float addrspace(1)* %input, float* %block, i32 %block_size) {
block_15:
  %output_addr = alloca float addrspace(1)*
  store float addrspace(1)* %output, float addrspace(1)** %output_addr
  %input_addr = alloca float addrspace(1)*
  store float addrspace(1)* %input, float addrspace(1)** %input_addr
  %block_addr = alloca float*
  store float* %block, float** %block_addr
  %block_size_addr = alloca i32
  store i32 %block_size, i32* %block_size_addr
  %tid = alloca i32
  %gid = alloca i32
  %bid = alloca i32
  %cache0 = alloca float
  %cache1 = alloca float
  %stride = alloca i32
  br label %block_16

block_16:                                         ; preds = %block_15
  %tmp_165 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_165, i32* %tid
  %tmp_166 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_166, i32* %gid
  %tmp_167 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_167, i32* %bid
  %tmp_168 = load i32* %tid
  %tmp_169 = mul i32 2, %tmp_168
  %tmp_170 = load float** %block_addr
  %tmp_171 = getelementptr float* %tmp_170, i32 %tmp_169
  %tmp_172 = load i32* %gid
  %tmp_173 = mul i32 2, %tmp_172
  %tmp_174 = load float addrspace(1)** %input_addr
  %tmp_175 = getelementptr float addrspace(1)* %tmp_174, i32 %tmp_173
  %tmp_176 = load float addrspace(1)* %tmp_175
  store float %tmp_176, float* %tmp_171
  %tmp_178 = load i32* %tid
  %tmp_179 = mul i32 2, %tmp_178
  %tmp_180 = add i32 %tmp_179, 1
  %tmp_181 = load float** %block_addr
  %tmp_182 = getelementptr float* %tmp_181, i32 %tmp_180
  %tmp_183 = load i32* %gid
  %tmp_184 = mul i32 2, %tmp_183
  %tmp_185 = add i32 %tmp_184, 1
  %tmp_186 = load float addrspace(1)** %input_addr
  %tmp_187 = getelementptr float addrspace(1)* %tmp_186, i32 %tmp_185
  %tmp_188 = load float addrspace(1)* %tmp_187
  store float %tmp_188, float* %tmp_182
  call void @__barrier_u32(i32 1)
  %tmp_190 = load float** %block_addr
  %tmp_191 = getelementptr float* %tmp_190, i32 0
  %tmp_192 = load float* %tmp_191
  store float %tmp_192, float* %cache0
  %tmp_194 = load float* %cache0
  %tmp_195 = load float** %block_addr
  %tmp_196 = getelementptr float* %tmp_195, i32 1
  %tmp_197 = load float* %tmp_196
  %tmp_198 = fadd float %tmp_194, %tmp_197
  store float %tmp_198, float* %cache1
  store i32 1, i32* %stride
  br label %block_17

block_17:                                         ; preds = %block_19, %block_16
  %tmp_200 = load i32* %stride
  %tmp_201 = load i32* %block_size_addr
  %tmp_202 = icmp slt i32 %tmp_200, %tmp_201
  %tmp_203 = sext i1 %tmp_202 to i32
  %tmp_204 = icmp ne i32 %tmp_203, 0
  br i1 %tmp_204, label %block_18, label %block_20

block_18:                                         ; preds = %block_17
  %tmp_207 = load i32* %tid
  %tmp_208 = mul i32 2, %tmp_207
  %tmp_209 = load i32* %stride
  %tmp_210 = icmp sge i32 %tmp_208, %tmp_209
  %tmp_211 = sext i1 %tmp_210 to i32
  %tmp_212 = icmp ne i32 %tmp_211, 0
  br i1 %tmp_212, label %block_22, label %block_21

block_19:                                         ; preds = %block_21
  %tmp_205 = load i32* %stride
  %tmp_206 = mul i32 %tmp_205, 2
  store i32 %tmp_206, i32* %stride
  br label %block_17

block_20:                                         ; preds = %block_17
  %tmp_256 = load i32* %tid
  %tmp_257 = icmp eq i32 %tmp_256, 0
  %tmp_258 = sext i1 %tmp_257 to i32
  %tmp_259 = icmp ne i32 %tmp_258, 0
  br i1 %tmp_259, label %block_24, label %block_23

block_21:                                         ; preds = %block_22, %block_18
  call void @__barrier_u32(i32 1)
  %tmp_243 = load i32* %tid
  %tmp_244 = mul i32 2, %tmp_243
  %tmp_245 = load float** %block_addr
  %tmp_246 = getelementptr float* %tmp_245, i32 %tmp_244
  %tmp_247 = load float* %cache0
  store float %tmp_247, float* %tmp_246
  %tmp_249 = load i32* %tid
  %tmp_250 = mul i32 2, %tmp_249
  %tmp_251 = add i32 %tmp_250, 1
  %tmp_252 = load float** %block_addr
  %tmp_253 = getelementptr float* %tmp_252, i32 %tmp_251
  %tmp_254 = load float* %cache1
  store float %tmp_254, float* %tmp_253
  call void @__barrier_u32(i32 1)
  br label %block_19

block_22:                                         ; preds = %block_18
  %tmp_213 = load i32* %tid
  %tmp_214 = mul i32 2, %tmp_213
  %tmp_215 = load i32* %stride
  %tmp_216 = sub i32 %tmp_214, %tmp_215
  %tmp_217 = load float** %block_addr
  %tmp_218 = getelementptr float* %tmp_217, i32 %tmp_216
  %tmp_219 = load float* %tmp_218
  %tmp_220 = load i32* %tid
  %tmp_221 = mul i32 2, %tmp_220
  %tmp_222 = load float** %block_addr
  %tmp_223 = getelementptr float* %tmp_222, i32 %tmp_221
  %tmp_224 = load float* %tmp_223
  %tmp_225 = fadd float %tmp_219, %tmp_224
  store float %tmp_225, float* %cache0
  %tmp_227 = load i32* %tid
  %tmp_228 = mul i32 2, %tmp_227
  %tmp_229 = add i32 %tmp_228, 1
  %tmp_230 = load i32* %stride
  %tmp_231 = sub i32 %tmp_229, %tmp_230
  %tmp_232 = load float** %block_addr
  %tmp_233 = getelementptr float* %tmp_232, i32 %tmp_231
  %tmp_234 = load float* %tmp_233
  %tmp_235 = load i32* %tid
  %tmp_236 = mul i32 2, %tmp_235
  %tmp_237 = add i32 %tmp_236, 1
  %tmp_238 = load float** %block_addr
  %tmp_239 = getelementptr float* %tmp_238, i32 %tmp_237
  %tmp_240 = load float* %tmp_239
  %tmp_241 = fadd float %tmp_234, %tmp_240
  store float %tmp_241, float* %cache1
  br label %block_21

block_23:                                         ; preds = %block_20
  %tmp_276 = load i32* %gid
  %tmp_277 = mul i32 2, %tmp_276
  %tmp_278 = load float addrspace(1)** %output_addr
  %tmp_279 = getelementptr float addrspace(1)* %tmp_278, i32 %tmp_277
  %tmp_280 = load i32* %tid
  %tmp_281 = mul i32 2, %tmp_280
  %tmp_282 = sub i32 %tmp_281, 1
  %tmp_283 = load float** %block_addr
  %tmp_284 = getelementptr float* %tmp_283, i32 %tmp_282
  %tmp_285 = load float* %tmp_284
  store float %tmp_285, float addrspace(1)* %tmp_279
  %tmp_287 = load i32* %gid
  %tmp_288 = mul i32 2, %tmp_287
  %tmp_289 = add i32 %tmp_288, 1
  %tmp_290 = load float addrspace(1)** %output_addr
  %tmp_291 = getelementptr float addrspace(1)* %tmp_290, i32 %tmp_289
  %tmp_292 = load i32* %tid
  %tmp_293 = mul i32 2, %tmp_292
  %tmp_294 = load float** %block_addr
  %tmp_295 = getelementptr float* %tmp_294, i32 %tmp_293
  %tmp_296 = load float* %tmp_295
  store float %tmp_296, float addrspace(1)* %tmp_291
  br label %block_25

block_24:                                         ; preds = %block_20
  %tmp_260 = load i32* %gid
  %tmp_261 = mul i32 2, %tmp_260
  %tmp_262 = load float addrspace(1)** %output_addr
  %tmp_263 = getelementptr float addrspace(1)* %tmp_262, i32 %tmp_261
  store float 0.000000e+00, float addrspace(1)* %tmp_263
  %tmp_265 = load i32* %gid
  %tmp_266 = mul i32 2, %tmp_265
  %tmp_267 = add i32 %tmp_266, 1
  %tmp_268 = load float addrspace(1)** %output_addr
  %tmp_269 = getelementptr float addrspace(1)* %tmp_268, i32 %tmp_267
  %tmp_270 = load i32* %tid
  %tmp_271 = mul i32 2, %tmp_270
  %tmp_272 = load float** %block_addr
  %tmp_273 = getelementptr float* %tmp_272, i32 %tmp_271
  %tmp_274 = load float* %tmp_273
  store float %tmp_274, float addrspace(1)* %tmp_269
  br label %block_25

block_25:                                         ; preds = %block_24, %block_23
  ret void
}

attributes #0 = { nounwind }

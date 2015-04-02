; ModuleID = 'ScanLargeArrays_Kernels.opt.bc'

@aclocal_value = external addrspace(3) global [1 x float]

define void @blockAddition(float addrspace(1)* %input, float addrspace(1)* %output) {
block_0:
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  %tmp_1 = call i32 @__get_group_id_u32(i32 0)
  %tmp_2 = call i32 @__get_local_id_u32(i32 0)
  %tmp_4 = icmp eq i32 %tmp_2, 0
  %tmp_5 = sext i1 %tmp_4 to i32
  %tmp_6 = icmp ne i32 %tmp_5, 0
  br i1 %tmp_6, label %block_3, label %block_2

block_2:                                          ; preds = %block_3, %block_1
  call void @__barrier_u32(i32 1)
  %tmp_16 = getelementptr float addrspace(1)* %output, i32 %tmp_0
  %tmp_19 = load float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @aclocal_value, i32 0, i32 0)
  %tmp_20 = load float addrspace(1)* %tmp_16
  %tmp_21 = fadd float %tmp_20, %tmp_19
  store float %tmp_21, float addrspace(1)* %tmp_16
  ret void

block_3:                                          ; preds = %block_1
  %tmp_11 = getelementptr float addrspace(1)* %input, i32 %tmp_1
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
  br label %block_5

block_5:                                          ; preds = %block_4
  %tmp_23 = call i32 @__get_local_id_u32(i32 0)
  %tmp_24 = call i32 @__get_global_id_u32(i32 0)
  %tmp_25 = call i32 @__get_group_id_u32(i32 0)
  %tmp_27 = mul i32 2, %tmp_23
  %tmp_29 = getelementptr float* %block, i32 %tmp_27
  %tmp_31 = mul i32 2, %tmp_24
  %tmp_33 = getelementptr float addrspace(1)* %input, i32 %tmp_31
  %tmp_34 = load float addrspace(1)* %tmp_33
  store float %tmp_34, float* %tmp_29
  %tmp_37 = mul i32 2, %tmp_23
  %tmp_38 = add i32 %tmp_37, 1
  %tmp_40 = getelementptr float* %block, i32 %tmp_38
  %tmp_42 = mul i32 2, %tmp_24
  %tmp_43 = add i32 %tmp_42, 1
  %tmp_45 = getelementptr float addrspace(1)* %input, i32 %tmp_43
  %tmp_46 = load float addrspace(1)* %tmp_45
  store float %tmp_46, float* %tmp_40
  call void @__barrier_u32(i32 1)
  %tmp_49 = getelementptr float* %block, i32 0
  %tmp_50 = load float* %tmp_49
  %tmp_54 = getelementptr float* %block, i32 1
  %tmp_55 = load float* %tmp_54
  %tmp_56 = fadd float %tmp_50, %tmp_55
  br label %block_6

block_6:                                          ; preds = %block_8, %block_5
  %cache0.0 = phi float [ %tmp_50, %block_5 ], [ %cache0.1, %block_8 ]
  %cache1.0 = phi float [ %tmp_56, %block_5 ], [ %cache1.1, %block_8 ]
  %stride.0 = phi i32 [ 1, %block_5 ], [ %tmp_64, %block_8 ]
  %tmp_60 = icmp slt i32 %stride.0, %block_size
  %tmp_61 = sext i1 %tmp_60 to i32
  %tmp_62 = icmp ne i32 %tmp_61, 0
  br i1 %tmp_62, label %block_7, label %block_9

block_7:                                          ; preds = %block_6
  %tmp_66 = mul i32 2, %tmp_23
  %tmp_68 = icmp sge i32 %tmp_66, %stride.0
  %tmp_69 = sext i1 %tmp_68 to i32
  %tmp_70 = icmp ne i32 %tmp_69, 0
  br i1 %tmp_70, label %block_11, label %block_10

block_8:                                          ; preds = %block_10
  %tmp_64 = mul i32 %stride.0, 2
  br label %block_6

block_9:                                          ; preds = %block_6
  %tmp_116 = getelementptr float addrspace(1)* %sumBuffer, i32 %tmp_25
  %tmp_118 = sub i32 %block_size, 1
  %tmp_120 = getelementptr float* %block, i32 %tmp_118
  %tmp_121 = load float* %tmp_120
  store float %tmp_121, float addrspace(1)* %tmp_116
  %tmp_124 = icmp eq i32 %tmp_23, 0
  %tmp_125 = sext i1 %tmp_124 to i32
  %tmp_126 = icmp ne i32 %tmp_125, 0
  br i1 %tmp_126, label %block_13, label %block_12

block_10:                                         ; preds = %block_11, %block_7
  %cache0.1 = phi float [ %tmp_83, %block_11 ], [ %cache0.0, %block_7 ]
  %cache1.1 = phi float [ %tmp_99, %block_11 ], [ %cache1.0, %block_7 ]
  call void @__barrier_u32(i32 1)
  %tmp_102 = mul i32 2, %tmp_23
  %tmp_104 = getelementptr float* %block, i32 %tmp_102
  store float %cache0.1, float* %tmp_104
  %tmp_108 = mul i32 2, %tmp_23
  %tmp_109 = add i32 %tmp_108, 1
  %tmp_111 = getelementptr float* %block, i32 %tmp_109
  store float %cache1.1, float* %tmp_111
  call void @__barrier_u32(i32 1)
  br label %block_8

block_11:                                         ; preds = %block_7
  %tmp_72 = mul i32 2, %tmp_23
  %tmp_74 = sub i32 %tmp_72, %stride.0
  %tmp_76 = getelementptr float* %block, i32 %tmp_74
  %tmp_77 = load float* %tmp_76
  %tmp_79 = mul i32 2, %tmp_23
  %tmp_81 = getelementptr float* %block, i32 %tmp_79
  %tmp_82 = load float* %tmp_81
  %tmp_83 = fadd float %tmp_77, %tmp_82
  %tmp_86 = mul i32 2, %tmp_23
  %tmp_87 = add i32 %tmp_86, 1
  %tmp_89 = sub i32 %tmp_87, %stride.0
  %tmp_91 = getelementptr float* %block, i32 %tmp_89
  %tmp_92 = load float* %tmp_91
  %tmp_94 = mul i32 2, %tmp_23
  %tmp_95 = add i32 %tmp_94, 1
  %tmp_97 = getelementptr float* %block, i32 %tmp_95
  %tmp_98 = load float* %tmp_97
  %tmp_99 = fadd float %tmp_92, %tmp_98
  br label %block_10

block_12:                                         ; preds = %block_9
  %tmp_144 = mul i32 2, %tmp_24
  %tmp_146 = getelementptr float addrspace(1)* %output, i32 %tmp_144
  %tmp_148 = mul i32 2, %tmp_23
  %tmp_149 = sub i32 %tmp_148, 1
  %tmp_151 = getelementptr float* %block, i32 %tmp_149
  %tmp_152 = load float* %tmp_151
  store float %tmp_152, float addrspace(1)* %tmp_146
  %tmp_155 = mul i32 2, %tmp_24
  %tmp_156 = add i32 %tmp_155, 1
  %tmp_158 = getelementptr float addrspace(1)* %output, i32 %tmp_156
  %tmp_160 = mul i32 2, %tmp_23
  %tmp_162 = getelementptr float* %block, i32 %tmp_160
  %tmp_163 = load float* %tmp_162
  store float %tmp_163, float addrspace(1)* %tmp_158
  br label %block_14

block_13:                                         ; preds = %block_9
  %tmp_128 = mul i32 2, %tmp_24
  %tmp_130 = getelementptr float addrspace(1)* %output, i32 %tmp_128
  store float 0.000000e+00, float addrspace(1)* %tmp_130
  %tmp_133 = mul i32 2, %tmp_24
  %tmp_134 = add i32 %tmp_133, 1
  %tmp_136 = getelementptr float addrspace(1)* %output, i32 %tmp_134
  %tmp_138 = mul i32 2, %tmp_23
  %tmp_140 = getelementptr float* %block, i32 %tmp_138
  %tmp_141 = load float* %tmp_140
  store float %tmp_141, float addrspace(1)* %tmp_136
  br label %block_14

block_14:                                         ; preds = %block_13, %block_12
  ret void
}

define void @prefixSum(float addrspace(1)* %output, float addrspace(1)* %input, float* %block, i32 %block_size) {
block_15:
  br label %block_16

block_16:                                         ; preds = %block_15
  %tmp_165 = call i32 @__get_local_id_u32(i32 0)
  %tmp_166 = call i32 @__get_global_id_u32(i32 0)
  %tmp_167 = call i32 @__get_group_id_u32(i32 0)
  %tmp_169 = mul i32 2, %tmp_165
  %tmp_171 = getelementptr float* %block, i32 %tmp_169
  %tmp_173 = mul i32 2, %tmp_166
  %tmp_175 = getelementptr float addrspace(1)* %input, i32 %tmp_173
  %tmp_176 = load float addrspace(1)* %tmp_175
  store float %tmp_176, float* %tmp_171
  %tmp_179 = mul i32 2, %tmp_165
  %tmp_180 = add i32 %tmp_179, 1
  %tmp_182 = getelementptr float* %block, i32 %tmp_180
  %tmp_184 = mul i32 2, %tmp_166
  %tmp_185 = add i32 %tmp_184, 1
  %tmp_187 = getelementptr float addrspace(1)* %input, i32 %tmp_185
  %tmp_188 = load float addrspace(1)* %tmp_187
  store float %tmp_188, float* %tmp_182
  call void @__barrier_u32(i32 1)
  %tmp_191 = getelementptr float* %block, i32 0
  %tmp_192 = load float* %tmp_191
  %tmp_196 = getelementptr float* %block, i32 1
  %tmp_197 = load float* %tmp_196
  %tmp_198 = fadd float %tmp_192, %tmp_197
  br label %block_17

block_17:                                         ; preds = %block_19, %block_16
  %cache0.0 = phi float [ %tmp_192, %block_16 ], [ %cache0.1, %block_19 ]
  %cache1.0 = phi float [ %tmp_198, %block_16 ], [ %cache1.1, %block_19 ]
  %stride.0 = phi i32 [ 1, %block_16 ], [ %tmp_206, %block_19 ]
  %tmp_202 = icmp slt i32 %stride.0, %block_size
  %tmp_203 = sext i1 %tmp_202 to i32
  %tmp_204 = icmp ne i32 %tmp_203, 0
  br i1 %tmp_204, label %block_18, label %block_20

block_18:                                         ; preds = %block_17
  %tmp_208 = mul i32 2, %tmp_165
  %tmp_210 = icmp sge i32 %tmp_208, %stride.0
  %tmp_211 = sext i1 %tmp_210 to i32
  %tmp_212 = icmp ne i32 %tmp_211, 0
  br i1 %tmp_212, label %block_22, label %block_21

block_19:                                         ; preds = %block_21
  %tmp_206 = mul i32 %stride.0, 2
  br label %block_17

block_20:                                         ; preds = %block_17
  %tmp_257 = icmp eq i32 %tmp_165, 0
  %tmp_258 = sext i1 %tmp_257 to i32
  %tmp_259 = icmp ne i32 %tmp_258, 0
  br i1 %tmp_259, label %block_24, label %block_23

block_21:                                         ; preds = %block_22, %block_18
  %cache0.1 = phi float [ %tmp_225, %block_22 ], [ %cache0.0, %block_18 ]
  %cache1.1 = phi float [ %tmp_241, %block_22 ], [ %cache1.0, %block_18 ]
  call void @__barrier_u32(i32 1)
  %tmp_244 = mul i32 2, %tmp_165
  %tmp_246 = getelementptr float* %block, i32 %tmp_244
  store float %cache0.1, float* %tmp_246
  %tmp_250 = mul i32 2, %tmp_165
  %tmp_251 = add i32 %tmp_250, 1
  %tmp_253 = getelementptr float* %block, i32 %tmp_251
  store float %cache1.1, float* %tmp_253
  call void @__barrier_u32(i32 1)
  br label %block_19

block_22:                                         ; preds = %block_18
  %tmp_214 = mul i32 2, %tmp_165
  %tmp_216 = sub i32 %tmp_214, %stride.0
  %tmp_218 = getelementptr float* %block, i32 %tmp_216
  %tmp_219 = load float* %tmp_218
  %tmp_221 = mul i32 2, %tmp_165
  %tmp_223 = getelementptr float* %block, i32 %tmp_221
  %tmp_224 = load float* %tmp_223
  %tmp_225 = fadd float %tmp_219, %tmp_224
  %tmp_228 = mul i32 2, %tmp_165
  %tmp_229 = add i32 %tmp_228, 1
  %tmp_231 = sub i32 %tmp_229, %stride.0
  %tmp_233 = getelementptr float* %block, i32 %tmp_231
  %tmp_234 = load float* %tmp_233
  %tmp_236 = mul i32 2, %tmp_165
  %tmp_237 = add i32 %tmp_236, 1
  %tmp_239 = getelementptr float* %block, i32 %tmp_237
  %tmp_240 = load float* %tmp_239
  %tmp_241 = fadd float %tmp_234, %tmp_240
  br label %block_21

block_23:                                         ; preds = %block_20
  %tmp_277 = mul i32 2, %tmp_166
  %tmp_279 = getelementptr float addrspace(1)* %output, i32 %tmp_277
  %tmp_281 = mul i32 2, %tmp_165
  %tmp_282 = sub i32 %tmp_281, 1
  %tmp_284 = getelementptr float* %block, i32 %tmp_282
  %tmp_285 = load float* %tmp_284
  store float %tmp_285, float addrspace(1)* %tmp_279
  %tmp_288 = mul i32 2, %tmp_166
  %tmp_289 = add i32 %tmp_288, 1
  %tmp_291 = getelementptr float addrspace(1)* %output, i32 %tmp_289
  %tmp_293 = mul i32 2, %tmp_165
  %tmp_295 = getelementptr float* %block, i32 %tmp_293
  %tmp_296 = load float* %tmp_295
  store float %tmp_296, float addrspace(1)* %tmp_291
  br label %block_25

block_24:                                         ; preds = %block_20
  %tmp_261 = mul i32 2, %tmp_166
  %tmp_263 = getelementptr float addrspace(1)* %output, i32 %tmp_261
  store float 0.000000e+00, float addrspace(1)* %tmp_263
  %tmp_266 = mul i32 2, %tmp_166
  %tmp_267 = add i32 %tmp_266, 1
  %tmp_269 = getelementptr float addrspace(1)* %output, i32 %tmp_267
  %tmp_271 = mul i32 2, %tmp_165
  %tmp_273 = getelementptr float* %block, i32 %tmp_271
  %tmp_274 = load float* %tmp_273
  store float %tmp_274, float addrspace(1)* %tmp_269
  br label %block_25

block_25:                                         ; preds = %block_24, %block_23
  ret void
}

attributes #0 = { nounwind }

; ModuleID = '../kernel-src/MatrixMultiplication_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @mmmKernel(<4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)* %matrixC, i32 %widthA, i32 %widthB) #0 {
  %tmp_1 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_3 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i32, align 4
  %pos = alloca <2 x i32>, align 8
  %tmp_6 = alloca <2 x i32>, align 8
  %sum0 = alloca <4 x float>, align 16
  %sum1 = alloca <4 x float>, align 16
  %sum2 = alloca <4 x float>, align 16
  %sum3 = alloca <4 x float>, align 16
  %i = alloca i32, align 4
  %tempA0 = alloca <4 x float>, align 16
  %tempA1 = alloca <4 x float>, align 16
  %tempA2 = alloca <4 x float>, align 16
  %tempA3 = alloca <4 x float>, align 16
  %tempB0 = alloca <4 x float>, align 16
  %tempB1 = alloca <4 x float>, align 16
  %tempB2 = alloca <4 x float>, align 16
  %tempB3 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)** %tmp_1, align 4
  store <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)** %tmp_2, align 4
  store <4 x float> addrspace(1)* %matrixC, <4 x float> addrspace(1)** %tmp_3, align 4
  store i32 %widthA, i32* %tmp_4, align 4
  store i32 %widthB, i32* %tmp_5, align 4
  %tmp_7 = call i32 @__get_global_id_u32(i32 0)
  %tmp_8 = insertelement <2 x i32> undef, i32 %tmp_7, i32 0
  %tmp_9 = call i32 @__get_global_id_u32(i32 1)
  %tmp_10 = insertelement <2 x i32> %tmp_8, i32 %tmp_9, i32 1
  store <2 x i32> %tmp_10, <2 x i32>* %tmp_6
  %tmp_11 = load <2 x i32>* %tmp_6
  store <2 x i32> %tmp_11, <2 x i32>* %pos, align 8
  store <4 x float> zeroinitializer, <4 x float>* %sum0, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum3, align 16
  %tmp_12 = load i32* %tmp_5, align 4
  %tmp_13 = udiv i32 %tmp_12, 4
  store i32 %tmp_13, i32* %tmp_5, align 4
  store i32 0, i32* %i, align 4
  br label %tmp_14

tmp_14:                                      ; preds = %tmp_509, %tmp_0
  %tmp_15 = load i32* %i, align 4
  %tmp_16 = load i32* %tmp_4, align 4
  %tmp_17 = icmp ult i32 %tmp_15, %tmp_16
  br i1 %tmp_17, label %tmp_18, label %tmp_512

tmp_18:                                      ; preds = %tmp_14
  %tmp_19 = load i32* %i, align 4
  %tmp_20 = sdiv i32 %tmp_19, 4
  %tmp_21 = load <2 x i32>* %pos, align 8
  %tmp_22 = extractelement <2 x i32> %tmp_21, i32 1
  %tmp_23 = shl i32 %tmp_22, 2
  %tmp_24 = load i32* %tmp_4, align 4
  %tmp_25 = udiv i32 %tmp_24, 4
  %tmp_26 = mul i32 %tmp_23, %tmp_25
  %tmp_27 = add i32 %tmp_20, %tmp_26
  %tmp_28 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_29 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_28, i32 %tmp_27
  %tmp_30 = load <4 x float> addrspace(1)* %tmp_29, align 16
  store <4 x float> %tmp_30, <4 x float>* %tempA0, align 16
  %tmp_31 = load i32* %i, align 4
  %tmp_32 = sdiv i32 %tmp_31, 4
  %tmp_33 = load <2 x i32>* %pos, align 8
  %tmp_34 = extractelement <2 x i32> %tmp_33, i32 1
  %tmp_35 = shl i32 %tmp_34, 2
  %tmp_36 = add nsw i32 %tmp_35, 1
  %tmp_37 = load i32* %tmp_4, align 4
  %tmp_38 = udiv i32 %tmp_37, 4
  %tmp_39 = mul i32 %tmp_36, %tmp_38
  %tmp_40 = add i32 %tmp_32, %tmp_39
  %tmp_41 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_42 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_41, i32 %tmp_40
  %tmp_43 = load <4 x float> addrspace(1)* %tmp_42, align 16
  store <4 x float> %tmp_43, <4 x float>* %tempA1, align 16
  %tmp_44 = load i32* %i, align 4
  %tmp_45 = sdiv i32 %tmp_44, 4
  %tmp_46 = load <2 x i32>* %pos, align 8
  %tmp_47 = extractelement <2 x i32> %tmp_46, i32 1
  %tmp_48 = shl i32 %tmp_47, 2
  %tmp_49 = add nsw i32 %tmp_48, 2
  %tmp_50 = load i32* %tmp_4, align 4
  %tmp_51 = udiv i32 %tmp_50, 4
  %tmp_52 = mul i32 %tmp_49, %tmp_51
  %tmp_53 = add i32 %tmp_45, %tmp_52
  %tmp_54 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_55 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_54, i32 %tmp_53
  %tmp_56 = load <4 x float> addrspace(1)* %tmp_55, align 16
  store <4 x float> %tmp_56, <4 x float>* %tempA2, align 16
  %tmp_57 = load i32* %i, align 4
  %tmp_58 = sdiv i32 %tmp_57, 4
  %tmp_59 = load <2 x i32>* %pos, align 8
  %tmp_60 = extractelement <2 x i32> %tmp_59, i32 1
  %tmp_61 = shl i32 %tmp_60, 2
  %tmp_62 = add nsw i32 %tmp_61, 3
  %tmp_63 = load i32* %tmp_4, align 4
  %tmp_64 = udiv i32 %tmp_63, 4
  %tmp_65 = mul i32 %tmp_62, %tmp_64
  %tmp_66 = add i32 %tmp_58, %tmp_65
  %tmp_67 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_68 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_67, i32 %tmp_66
  %tmp_69 = load <4 x float> addrspace(1)* %tmp_68, align 16
  store <4 x float> %tmp_69, <4 x float>* %tempA3, align 16
  %tmp_70 = load <2 x i32>* %pos, align 8
  %tmp_71 = extractelement <2 x i32> %tmp_70, i32 0
  %tmp_72 = load i32* %i, align 4
  %tmp_73 = load i32* %tmp_5, align 4
  %tmp_74 = mul i32 %tmp_72, %tmp_73
  %tmp_75 = add i32 %tmp_71, %tmp_74
  %tmp_76 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_77 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_76, i32 %tmp_75
  %tmp_78 = load <4 x float> addrspace(1)* %tmp_77, align 16
  store <4 x float> %tmp_78, <4 x float>* %tempB0, align 16
  %tmp_79 = load <2 x i32>* %pos, align 8
  %tmp_80 = extractelement <2 x i32> %tmp_79, i32 0
  %tmp_81 = load i32* %i, align 4
  %tmp_82 = add nsw i32 %tmp_81, 1
  %tmp_83 = load i32* %tmp_5, align 4
  %tmp_84 = mul i32 %tmp_82, %tmp_83
  %tmp_85 = add i32 %tmp_80, %tmp_84
  %tmp_86 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_87 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_86, i32 %tmp_85
  %tmp_88 = load <4 x float> addrspace(1)* %tmp_87, align 16
  store <4 x float> %tmp_88, <4 x float>* %tempB1, align 16
  %tmp_89 = load <2 x i32>* %pos, align 8
  %tmp_90 = extractelement <2 x i32> %tmp_89, i32 0
  %tmp_91 = load i32* %i, align 4
  %tmp_92 = add nsw i32 %tmp_91, 2
  %tmp_93 = load i32* %tmp_5, align 4
  %tmp_94 = mul i32 %tmp_92, %tmp_93
  %tmp_95 = add i32 %tmp_90, %tmp_94
  %tmp_96 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_97 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_96, i32 %tmp_95
  %tmp_98 = load <4 x float> addrspace(1)* %tmp_97, align 16
  store <4 x float> %tmp_98, <4 x float>* %tempB2, align 16
  %tmp_99 = load <2 x i32>* %pos, align 8
  %tmp_100 = extractelement <2 x i32> %tmp_99, i32 0
  %tmp_101 = load i32* %i, align 4
  %tmp_102 = add nsw i32 %tmp_101, 3
  %tmp_103 = load i32* %tmp_5, align 4
  %tmp_104 = mul i32 %tmp_102, %tmp_103
  %tmp_105 = add i32 %tmp_100, %tmp_104
  %tmp_106 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_107 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_106, i32 %tmp_105
  %tmp_108 = load <4 x float> addrspace(1)* %tmp_107, align 16
  store <4 x float> %tmp_108, <4 x float>* %tempB3, align 16
  %tmp_109 = load <4 x float>* %tempA0, align 16
  %tmp_110 = extractelement <4 x float> %tmp_109, i32 0
  %tmp_111 = load <4 x float>* %tempB0, align 16
  %tmp_112 = extractelement <4 x float> %tmp_111, i32 0
  %tmp_113 = load <4 x float>* %tempA0, align 16
  %tmp_114 = extractelement <4 x float> %tmp_113, i32 1
  %tmp_115 = load <4 x float>* %tempB1, align 16
  %tmp_116 = extractelement <4 x float> %tmp_115, i32 0
  %tmp_117 = fmul float %tmp_114, %tmp_116
  %tmp_118 = call float @llvm.fmuladd.f32(float %tmp_110, float %tmp_112, float %tmp_117)
  %tmp_119 = load <4 x float>* %tempA0, align 16
  %tmp_120 = extractelement <4 x float> %tmp_119, i32 2
  %tmp_121 = load <4 x float>* %tempB2, align 16
  %tmp_122 = extractelement <4 x float> %tmp_121, i32 0
  %tmp_123 = call float @llvm.fmuladd.f32(float %tmp_120, float %tmp_122, float %tmp_118)
  %tmp_124 = load <4 x float>* %tempA0, align 16
  %tmp_125 = extractelement <4 x float> %tmp_124, i32 3
  %tmp_126 = load <4 x float>* %tempB3, align 16
  %tmp_127 = extractelement <4 x float> %tmp_126, i32 0
  %tmp_128 = call float @llvm.fmuladd.f32(float %tmp_125, float %tmp_127, float %tmp_123)
  %tmp_129 = load <4 x float>* %sum0, align 16
  %tmp_130 = extractelement <4 x float> %tmp_129, i32 0
  %tmp_131 = fadd float %tmp_130, %tmp_128
  %tmp_132 = load <4 x float>* %sum0, align 16
  %tmp_133 = insertelement <4 x float> %tmp_132, float %tmp_131, i32 0
  store <4 x float> %tmp_133, <4 x float>* %sum0, align 16
  %tmp_134 = load <4 x float>* %tempA0, align 16
  %tmp_135 = extractelement <4 x float> %tmp_134, i32 0
  %tmp_136 = load <4 x float>* %tempB0, align 16
  %tmp_137 = extractelement <4 x float> %tmp_136, i32 1
  %tmp_138 = load <4 x float>* %tempA0, align 16
  %tmp_139 = extractelement <4 x float> %tmp_138, i32 1
  %tmp_140 = load <4 x float>* %tempB1, align 16
  %tmp_141 = extractelement <4 x float> %tmp_140, i32 1
  %tmp_142 = fmul float %tmp_139, %tmp_141
  %tmp_143 = call float @llvm.fmuladd.f32(float %tmp_135, float %tmp_137, float %tmp_142)
  %tmp_144 = load <4 x float>* %tempA0, align 16
  %tmp_145 = extractelement <4 x float> %tmp_144, i32 2
  %tmp_146 = load <4 x float>* %tempB2, align 16
  %tmp_147 = extractelement <4 x float> %tmp_146, i32 1
  %tmp_148 = call float @llvm.fmuladd.f32(float %tmp_145, float %tmp_147, float %tmp_143)
  %tmp_149 = load <4 x float>* %tempA0, align 16
  %tmp_150 = extractelement <4 x float> %tmp_149, i32 3
  %tmp_151 = load <4 x float>* %tempB3, align 16
  %tmp_152 = extractelement <4 x float> %tmp_151, i32 1
  %tmp_153 = call float @llvm.fmuladd.f32(float %tmp_150, float %tmp_152, float %tmp_148)
  %tmp_154 = load <4 x float>* %sum0, align 16
  %tmp_155 = extractelement <4 x float> %tmp_154, i32 1
  %tmp_156 = fadd float %tmp_155, %tmp_153
  %tmp_157 = load <4 x float>* %sum0, align 16
  %tmp_158 = insertelement <4 x float> %tmp_157, float %tmp_156, i32 1
  store <4 x float> %tmp_158, <4 x float>* %sum0, align 16
  %tmp_159 = load <4 x float>* %tempA0, align 16
  %tmp_160 = extractelement <4 x float> %tmp_159, i32 0
  %tmp_161 = load <4 x float>* %tempB0, align 16
  %tmp_162 = extractelement <4 x float> %tmp_161, i32 2
  %tmp_163 = load <4 x float>* %tempA0, align 16
  %tmp_164 = extractelement <4 x float> %tmp_163, i32 1
  %tmp_165 = load <4 x float>* %tempB1, align 16
  %tmp_166 = extractelement <4 x float> %tmp_165, i32 2
  %tmp_167 = fmul float %tmp_164, %tmp_166
  %tmp_168 = call float @llvm.fmuladd.f32(float %tmp_160, float %tmp_162, float %tmp_167)
  %tmp_169 = load <4 x float>* %tempA0, align 16
  %tmp_170 = extractelement <4 x float> %tmp_169, i32 2
  %tmp_171 = load <4 x float>* %tempB2, align 16
  %tmp_172 = extractelement <4 x float> %tmp_171, i32 2
  %tmp_173 = call float @llvm.fmuladd.f32(float %tmp_170, float %tmp_172, float %tmp_168)
  %tmp_174 = load <4 x float>* %tempA0, align 16
  %tmp_175 = extractelement <4 x float> %tmp_174, i32 3
  %tmp_176 = load <4 x float>* %tempB3, align 16
  %tmp_177 = extractelement <4 x float> %tmp_176, i32 2
  %tmp_178 = call float @llvm.fmuladd.f32(float %tmp_175, float %tmp_177, float %tmp_173)
  %tmp_179 = load <4 x float>* %sum0, align 16
  %tmp_180 = extractelement <4 x float> %tmp_179, i32 2
  %tmp_181 = fadd float %tmp_180, %tmp_178
  %tmp_182 = load <4 x float>* %sum0, align 16
  %tmp_183 = insertelement <4 x float> %tmp_182, float %tmp_181, i32 2
  store <4 x float> %tmp_183, <4 x float>* %sum0, align 16
  %tmp_184 = load <4 x float>* %tempA0, align 16
  %tmp_185 = extractelement <4 x float> %tmp_184, i32 0
  %tmp_186 = load <4 x float>* %tempB0, align 16
  %tmp_187 = extractelement <4 x float> %tmp_186, i32 3
  %tmp_188 = load <4 x float>* %tempA0, align 16
  %tmp_189 = extractelement <4 x float> %tmp_188, i32 1
  %tmp_190 = load <4 x float>* %tempB1, align 16
  %tmp_191 = extractelement <4 x float> %tmp_190, i32 3
  %tmp_192 = fmul float %tmp_189, %tmp_191
  %tmp_193 = call float @llvm.fmuladd.f32(float %tmp_185, float %tmp_187, float %tmp_192)
  %tmp_194 = load <4 x float>* %tempA0, align 16
  %tmp_195 = extractelement <4 x float> %tmp_194, i32 2
  %tmp_196 = load <4 x float>* %tempB2, align 16
  %tmp_197 = extractelement <4 x float> %tmp_196, i32 3
  %tmp_198 = call float @llvm.fmuladd.f32(float %tmp_195, float %tmp_197, float %tmp_193)
  %tmp_199 = load <4 x float>* %tempA0, align 16
  %tmp_200 = extractelement <4 x float> %tmp_199, i32 3
  %tmp_201 = load <4 x float>* %tempB3, align 16
  %tmp_202 = extractelement <4 x float> %tmp_201, i32 3
  %tmp_203 = call float @llvm.fmuladd.f32(float %tmp_200, float %tmp_202, float %tmp_198)
  %tmp_204 = load <4 x float>* %sum0, align 16
  %tmp_205 = extractelement <4 x float> %tmp_204, i32 3
  %tmp_206 = fadd float %tmp_205, %tmp_203
  %tmp_207 = load <4 x float>* %sum0, align 16
  %tmp_208 = insertelement <4 x float> %tmp_207, float %tmp_206, i32 3
  store <4 x float> %tmp_208, <4 x float>* %sum0, align 16
  %tmp_209 = load <4 x float>* %tempA1, align 16
  %tmp_210 = extractelement <4 x float> %tmp_209, i32 0
  %tmp_211 = load <4 x float>* %tempB0, align 16
  %tmp_212 = extractelement <4 x float> %tmp_211, i32 0
  %tmp_213 = load <4 x float>* %tempA1, align 16
  %tmp_214 = extractelement <4 x float> %tmp_213, i32 1
  %tmp_215 = load <4 x float>* %tempB1, align 16
  %tmp_216 = extractelement <4 x float> %tmp_215, i32 0
  %tmp_217 = fmul float %tmp_214, %tmp_216
  %tmp_218 = call float @llvm.fmuladd.f32(float %tmp_210, float %tmp_212, float %tmp_217)
  %tmp_219 = load <4 x float>* %tempA1, align 16
  %tmp_220 = extractelement <4 x float> %tmp_219, i32 2
  %tmp_221 = load <4 x float>* %tempB2, align 16
  %tmp_222 = extractelement <4 x float> %tmp_221, i32 0
  %tmp_223 = call float @llvm.fmuladd.f32(float %tmp_220, float %tmp_222, float %tmp_218)
  %tmp_224 = load <4 x float>* %tempA1, align 16
  %tmp_225 = extractelement <4 x float> %tmp_224, i32 3
  %tmp_226 = load <4 x float>* %tempB3, align 16
  %tmp_227 = extractelement <4 x float> %tmp_226, i32 0
  %tmp_228 = call float @llvm.fmuladd.f32(float %tmp_225, float %tmp_227, float %tmp_223)
  %tmp_229 = load <4 x float>* %sum1, align 16
  %tmp_230 = extractelement <4 x float> %tmp_229, i32 0
  %tmp_231 = fadd float %tmp_230, %tmp_228
  %tmp_232 = load <4 x float>* %sum1, align 16
  %tmp_233 = insertelement <4 x float> %tmp_232, float %tmp_231, i32 0
  store <4 x float> %tmp_233, <4 x float>* %sum1, align 16
  %tmp_234 = load <4 x float>* %tempA1, align 16
  %tmp_235 = extractelement <4 x float> %tmp_234, i32 0
  %tmp_236 = load <4 x float>* %tempB0, align 16
  %tmp_237 = extractelement <4 x float> %tmp_236, i32 1
  %tmp_238 = load <4 x float>* %tempA1, align 16
  %tmp_239 = extractelement <4 x float> %tmp_238, i32 1
  %tmp_240 = load <4 x float>* %tempB1, align 16
  %tmp_241 = extractelement <4 x float> %tmp_240, i32 1
  %tmp_242 = fmul float %tmp_239, %tmp_241
  %tmp_243 = call float @llvm.fmuladd.f32(float %tmp_235, float %tmp_237, float %tmp_242)
  %tmp_244 = load <4 x float>* %tempA1, align 16
  %tmp_245 = extractelement <4 x float> %tmp_244, i32 2
  %tmp_246 = load <4 x float>* %tempB2, align 16
  %tmp_247 = extractelement <4 x float> %tmp_246, i32 1
  %tmp_248 = call float @llvm.fmuladd.f32(float %tmp_245, float %tmp_247, float %tmp_243)
  %tmp_249 = load <4 x float>* %tempA1, align 16
  %tmp_250 = extractelement <4 x float> %tmp_249, i32 3
  %tmp_251 = load <4 x float>* %tempB3, align 16
  %tmp_252 = extractelement <4 x float> %tmp_251, i32 1
  %tmp_253 = call float @llvm.fmuladd.f32(float %tmp_250, float %tmp_252, float %tmp_248)
  %tmp_254 = load <4 x float>* %sum1, align 16
  %tmp_255 = extractelement <4 x float> %tmp_254, i32 1
  %tmp_256 = fadd float %tmp_255, %tmp_253
  %tmp_257 = load <4 x float>* %sum1, align 16
  %tmp_258 = insertelement <4 x float> %tmp_257, float %tmp_256, i32 1
  store <4 x float> %tmp_258, <4 x float>* %sum1, align 16
  %tmp_259 = load <4 x float>* %tempA1, align 16
  %tmp_260 = extractelement <4 x float> %tmp_259, i32 0
  %tmp_261 = load <4 x float>* %tempB0, align 16
  %tmp_262 = extractelement <4 x float> %tmp_261, i32 2
  %tmp_263 = load <4 x float>* %tempA1, align 16
  %tmp_264 = extractelement <4 x float> %tmp_263, i32 1
  %tmp_265 = load <4 x float>* %tempB1, align 16
  %tmp_266 = extractelement <4 x float> %tmp_265, i32 2
  %tmp_267 = fmul float %tmp_264, %tmp_266
  %tmp_268 = call float @llvm.fmuladd.f32(float %tmp_260, float %tmp_262, float %tmp_267)
  %tmp_269 = load <4 x float>* %tempA1, align 16
  %tmp_270 = extractelement <4 x float> %tmp_269, i32 2
  %tmp_271 = load <4 x float>* %tempB2, align 16
  %tmp_272 = extractelement <4 x float> %tmp_271, i32 2
  %tmp_273 = call float @llvm.fmuladd.f32(float %tmp_270, float %tmp_272, float %tmp_268)
  %tmp_274 = load <4 x float>* %tempA1, align 16
  %tmp_275 = extractelement <4 x float> %tmp_274, i32 3
  %tmp_276 = load <4 x float>* %tempB3, align 16
  %tmp_277 = extractelement <4 x float> %tmp_276, i32 2
  %tmp_278 = call float @llvm.fmuladd.f32(float %tmp_275, float %tmp_277, float %tmp_273)
  %tmp_279 = load <4 x float>* %sum1, align 16
  %tmp_280 = extractelement <4 x float> %tmp_279, i32 2
  %tmp_281 = fadd float %tmp_280, %tmp_278
  %tmp_282 = load <4 x float>* %sum1, align 16
  %tmp_283 = insertelement <4 x float> %tmp_282, float %tmp_281, i32 2
  store <4 x float> %tmp_283, <4 x float>* %sum1, align 16
  %tmp_284 = load <4 x float>* %tempA1, align 16
  %tmp_285 = extractelement <4 x float> %tmp_284, i32 0
  %tmp_286 = load <4 x float>* %tempB0, align 16
  %tmp_287 = extractelement <4 x float> %tmp_286, i32 3
  %tmp_288 = load <4 x float>* %tempA1, align 16
  %tmp_289 = extractelement <4 x float> %tmp_288, i32 1
  %tmp_290 = load <4 x float>* %tempB1, align 16
  %tmp_291 = extractelement <4 x float> %tmp_290, i32 3
  %tmp_292 = fmul float %tmp_289, %tmp_291
  %tmp_293 = call float @llvm.fmuladd.f32(float %tmp_285, float %tmp_287, float %tmp_292)
  %tmp_294 = load <4 x float>* %tempA1, align 16
  %tmp_295 = extractelement <4 x float> %tmp_294, i32 2
  %tmp_296 = load <4 x float>* %tempB2, align 16
  %tmp_297 = extractelement <4 x float> %tmp_296, i32 3
  %tmp_298 = call float @llvm.fmuladd.f32(float %tmp_295, float %tmp_297, float %tmp_293)
  %tmp_299 = load <4 x float>* %tempA1, align 16
  %tmp_300 = extractelement <4 x float> %tmp_299, i32 3
  %tmp_301 = load <4 x float>* %tempB3, align 16
  %tmp_302 = extractelement <4 x float> %tmp_301, i32 3
  %tmp_303 = call float @llvm.fmuladd.f32(float %tmp_300, float %tmp_302, float %tmp_298)
  %tmp_304 = load <4 x float>* %sum1, align 16
  %tmp_305 = extractelement <4 x float> %tmp_304, i32 3
  %tmp_306 = fadd float %tmp_305, %tmp_303
  %tmp_307 = load <4 x float>* %sum1, align 16
  %tmp_308 = insertelement <4 x float> %tmp_307, float %tmp_306, i32 3
  store <4 x float> %tmp_308, <4 x float>* %sum1, align 16
  %tmp_309 = load <4 x float>* %tempA2, align 16
  %tmp_310 = extractelement <4 x float> %tmp_309, i32 0
  %tmp_311 = load <4 x float>* %tempB0, align 16
  %tmp_312 = extractelement <4 x float> %tmp_311, i32 0
  %tmp_313 = load <4 x float>* %tempA2, align 16
  %tmp_314 = extractelement <4 x float> %tmp_313, i32 1
  %tmp_315 = load <4 x float>* %tempB1, align 16
  %tmp_316 = extractelement <4 x float> %tmp_315, i32 0
  %tmp_317 = fmul float %tmp_314, %tmp_316
  %tmp_318 = call float @llvm.fmuladd.f32(float %tmp_310, float %tmp_312, float %tmp_317)
  %tmp_319 = load <4 x float>* %tempA2, align 16
  %tmp_320 = extractelement <4 x float> %tmp_319, i32 2
  %tmp_321 = load <4 x float>* %tempB2, align 16
  %tmp_322 = extractelement <4 x float> %tmp_321, i32 0
  %tmp_323 = call float @llvm.fmuladd.f32(float %tmp_320, float %tmp_322, float %tmp_318)
  %tmp_324 = load <4 x float>* %tempA2, align 16
  %tmp_325 = extractelement <4 x float> %tmp_324, i32 3
  %tmp_326 = load <4 x float>* %tempB3, align 16
  %tmp_327 = extractelement <4 x float> %tmp_326, i32 0
  %tmp_328 = call float @llvm.fmuladd.f32(float %tmp_325, float %tmp_327, float %tmp_323)
  %tmp_329 = load <4 x float>* %sum2, align 16
  %tmp_330 = extractelement <4 x float> %tmp_329, i32 0
  %tmp_331 = fadd float %tmp_330, %tmp_328
  %tmp_332 = load <4 x float>* %sum2, align 16
  %tmp_333 = insertelement <4 x float> %tmp_332, float %tmp_331, i32 0
  store <4 x float> %tmp_333, <4 x float>* %sum2, align 16
  %tmp_334 = load <4 x float>* %tempA2, align 16
  %tmp_335 = extractelement <4 x float> %tmp_334, i32 0
  %tmp_336 = load <4 x float>* %tempB0, align 16
  %tmp_337 = extractelement <4 x float> %tmp_336, i32 1
  %tmp_338 = load <4 x float>* %tempA2, align 16
  %tmp_339 = extractelement <4 x float> %tmp_338, i32 1
  %tmp_340 = load <4 x float>* %tempB1, align 16
  %tmp_341 = extractelement <4 x float> %tmp_340, i32 1
  %tmp_342 = fmul float %tmp_339, %tmp_341
  %tmp_343 = call float @llvm.fmuladd.f32(float %tmp_335, float %tmp_337, float %tmp_342)
  %tmp_344 = load <4 x float>* %tempA2, align 16
  %tmp_345 = extractelement <4 x float> %tmp_344, i32 2
  %tmp_346 = load <4 x float>* %tempB2, align 16
  %tmp_347 = extractelement <4 x float> %tmp_346, i32 1
  %tmp_348 = call float @llvm.fmuladd.f32(float %tmp_345, float %tmp_347, float %tmp_343)
  %tmp_349 = load <4 x float>* %tempA2, align 16
  %tmp_350 = extractelement <4 x float> %tmp_349, i32 3
  %tmp_351 = load <4 x float>* %tempB3, align 16
  %tmp_352 = extractelement <4 x float> %tmp_351, i32 1
  %tmp_353 = call float @llvm.fmuladd.f32(float %tmp_350, float %tmp_352, float %tmp_348)
  %tmp_354 = load <4 x float>* %sum2, align 16
  %tmp_355 = extractelement <4 x float> %tmp_354, i32 1
  %tmp_356 = fadd float %tmp_355, %tmp_353
  %tmp_357 = load <4 x float>* %sum2, align 16
  %tmp_358 = insertelement <4 x float> %tmp_357, float %tmp_356, i32 1
  store <4 x float> %tmp_358, <4 x float>* %sum2, align 16
  %tmp_359 = load <4 x float>* %tempA2, align 16
  %tmp_360 = extractelement <4 x float> %tmp_359, i32 0
  %tmp_361 = load <4 x float>* %tempB0, align 16
  %tmp_362 = extractelement <4 x float> %tmp_361, i32 2
  %tmp_363 = load <4 x float>* %tempA2, align 16
  %tmp_364 = extractelement <4 x float> %tmp_363, i32 1
  %tmp_365 = load <4 x float>* %tempB1, align 16
  %tmp_366 = extractelement <4 x float> %tmp_365, i32 2
  %tmp_367 = fmul float %tmp_364, %tmp_366
  %tmp_368 = call float @llvm.fmuladd.f32(float %tmp_360, float %tmp_362, float %tmp_367)
  %tmp_369 = load <4 x float>* %tempA2, align 16
  %tmp_370 = extractelement <4 x float> %tmp_369, i32 2
  %tmp_371 = load <4 x float>* %tempB2, align 16
  %tmp_372 = extractelement <4 x float> %tmp_371, i32 2
  %tmp_373 = call float @llvm.fmuladd.f32(float %tmp_370, float %tmp_372, float %tmp_368)
  %tmp_374 = load <4 x float>* %tempA2, align 16
  %tmp_375 = extractelement <4 x float> %tmp_374, i32 3
  %tmp_376 = load <4 x float>* %tempB3, align 16
  %tmp_377 = extractelement <4 x float> %tmp_376, i32 2
  %tmp_378 = call float @llvm.fmuladd.f32(float %tmp_375, float %tmp_377, float %tmp_373)
  %tmp_379 = load <4 x float>* %sum2, align 16
  %tmp_380 = extractelement <4 x float> %tmp_379, i32 2
  %tmp_381 = fadd float %tmp_380, %tmp_378
  %tmp_382 = load <4 x float>* %sum2, align 16
  %tmp_383 = insertelement <4 x float> %tmp_382, float %tmp_381, i32 2
  store <4 x float> %tmp_383, <4 x float>* %sum2, align 16
  %tmp_384 = load <4 x float>* %tempA2, align 16
  %tmp_385 = extractelement <4 x float> %tmp_384, i32 0
  %tmp_386 = load <4 x float>* %tempB0, align 16
  %tmp_387 = extractelement <4 x float> %tmp_386, i32 3
  %tmp_388 = load <4 x float>* %tempA2, align 16
  %tmp_389 = extractelement <4 x float> %tmp_388, i32 1
  %tmp_390 = load <4 x float>* %tempB1, align 16
  %tmp_391 = extractelement <4 x float> %tmp_390, i32 3
  %tmp_392 = fmul float %tmp_389, %tmp_391
  %tmp_393 = call float @llvm.fmuladd.f32(float %tmp_385, float %tmp_387, float %tmp_392)
  %tmp_394 = load <4 x float>* %tempA2, align 16
  %tmp_395 = extractelement <4 x float> %tmp_394, i32 2
  %tmp_396 = load <4 x float>* %tempB2, align 16
  %tmp_397 = extractelement <4 x float> %tmp_396, i32 3
  %tmp_398 = call float @llvm.fmuladd.f32(float %tmp_395, float %tmp_397, float %tmp_393)
  %tmp_399 = load <4 x float>* %tempA2, align 16
  %tmp_400 = extractelement <4 x float> %tmp_399, i32 3
  %tmp_401 = load <4 x float>* %tempB3, align 16
  %tmp_402 = extractelement <4 x float> %tmp_401, i32 3
  %tmp_403 = call float @llvm.fmuladd.f32(float %tmp_400, float %tmp_402, float %tmp_398)
  %tmp_404 = load <4 x float>* %sum2, align 16
  %tmp_405 = extractelement <4 x float> %tmp_404, i32 3
  %tmp_406 = fadd float %tmp_405, %tmp_403
  %tmp_407 = load <4 x float>* %sum2, align 16
  %tmp_408 = insertelement <4 x float> %tmp_407, float %tmp_406, i32 3
  store <4 x float> %tmp_408, <4 x float>* %sum2, align 16
  %tmp_409 = load <4 x float>* %tempA3, align 16
  %tmp_410 = extractelement <4 x float> %tmp_409, i32 0
  %tmp_411 = load <4 x float>* %tempB0, align 16
  %tmp_412 = extractelement <4 x float> %tmp_411, i32 0
  %tmp_413 = load <4 x float>* %tempA3, align 16
  %tmp_414 = extractelement <4 x float> %tmp_413, i32 1
  %tmp_415 = load <4 x float>* %tempB1, align 16
  %tmp_416 = extractelement <4 x float> %tmp_415, i32 0
  %tmp_417 = fmul float %tmp_414, %tmp_416
  %tmp_418 = call float @llvm.fmuladd.f32(float %tmp_410, float %tmp_412, float %tmp_417)
  %tmp_419 = load <4 x float>* %tempA3, align 16
  %tmp_420 = extractelement <4 x float> %tmp_419, i32 2
  %tmp_421 = load <4 x float>* %tempB2, align 16
  %tmp_422 = extractelement <4 x float> %tmp_421, i32 0
  %tmp_423 = call float @llvm.fmuladd.f32(float %tmp_420, float %tmp_422, float %tmp_418)
  %tmp_424 = load <4 x float>* %tempA3, align 16
  %tmp_425 = extractelement <4 x float> %tmp_424, i32 3
  %tmp_426 = load <4 x float>* %tempB3, align 16
  %tmp_427 = extractelement <4 x float> %tmp_426, i32 0
  %tmp_428 = call float @llvm.fmuladd.f32(float %tmp_425, float %tmp_427, float %tmp_423)
  %tmp_429 = load <4 x float>* %sum3, align 16
  %tmp_430 = extractelement <4 x float> %tmp_429, i32 0
  %tmp_431 = fadd float %tmp_430, %tmp_428
  %tmp_432 = load <4 x float>* %sum3, align 16
  %tmp_433 = insertelement <4 x float> %tmp_432, float %tmp_431, i32 0
  store <4 x float> %tmp_433, <4 x float>* %sum3, align 16
  %tmp_434 = load <4 x float>* %tempA3, align 16
  %tmp_435 = extractelement <4 x float> %tmp_434, i32 0
  %tmp_436 = load <4 x float>* %tempB0, align 16
  %tmp_437 = extractelement <4 x float> %tmp_436, i32 1
  %tmp_438 = load <4 x float>* %tempA3, align 16
  %tmp_439 = extractelement <4 x float> %tmp_438, i32 1
  %tmp_440 = load <4 x float>* %tempB1, align 16
  %tmp_441 = extractelement <4 x float> %tmp_440, i32 1
  %tmp_442 = fmul float %tmp_439, %tmp_441
  %tmp_443 = call float @llvm.fmuladd.f32(float %tmp_435, float %tmp_437, float %tmp_442)
  %tmp_444 = load <4 x float>* %tempA3, align 16
  %tmp_445 = extractelement <4 x float> %tmp_444, i32 2
  %tmp_446 = load <4 x float>* %tempB2, align 16
  %tmp_447 = extractelement <4 x float> %tmp_446, i32 1
  %tmp_448 = call float @llvm.fmuladd.f32(float %tmp_445, float %tmp_447, float %tmp_443)
  %tmp_449 = load <4 x float>* %tempA3, align 16
  %tmp_450 = extractelement <4 x float> %tmp_449, i32 3
  %tmp_451 = load <4 x float>* %tempB3, align 16
  %tmp_452 = extractelement <4 x float> %tmp_451, i32 1
  %tmp_453 = call float @llvm.fmuladd.f32(float %tmp_450, float %tmp_452, float %tmp_448)
  %tmp_454 = load <4 x float>* %sum3, align 16
  %tmp_455 = extractelement <4 x float> %tmp_454, i32 1
  %tmp_456 = fadd float %tmp_455, %tmp_453
  %tmp_457 = load <4 x float>* %sum3, align 16
  %tmp_458 = insertelement <4 x float> %tmp_457, float %tmp_456, i32 1
  store <4 x float> %tmp_458, <4 x float>* %sum3, align 16
  %tmp_459 = load <4 x float>* %tempA3, align 16
  %tmp_460 = extractelement <4 x float> %tmp_459, i32 0
  %tmp_461 = load <4 x float>* %tempB0, align 16
  %tmp_462 = extractelement <4 x float> %tmp_461, i32 2
  %tmp_463 = load <4 x float>* %tempA3, align 16
  %tmp_464 = extractelement <4 x float> %tmp_463, i32 1
  %tmp_465 = load <4 x float>* %tempB1, align 16
  %tmp_466 = extractelement <4 x float> %tmp_465, i32 2
  %tmp_467 = fmul float %tmp_464, %tmp_466
  %tmp_468 = call float @llvm.fmuladd.f32(float %tmp_460, float %tmp_462, float %tmp_467)
  %tmp_469 = load <4 x float>* %tempA3, align 16
  %tmp_470 = extractelement <4 x float> %tmp_469, i32 2
  %tmp_471 = load <4 x float>* %tempB2, align 16
  %tmp_472 = extractelement <4 x float> %tmp_471, i32 2
  %tmp_473 = call float @llvm.fmuladd.f32(float %tmp_470, float %tmp_472, float %tmp_468)
  %tmp_474 = load <4 x float>* %tempA3, align 16
  %tmp_475 = extractelement <4 x float> %tmp_474, i32 3
  %tmp_476 = load <4 x float>* %tempB3, align 16
  %tmp_477 = extractelement <4 x float> %tmp_476, i32 2
  %tmp_478 = call float @llvm.fmuladd.f32(float %tmp_475, float %tmp_477, float %tmp_473)
  %tmp_479 = load <4 x float>* %sum3, align 16
  %tmp_480 = extractelement <4 x float> %tmp_479, i32 2
  %tmp_481 = fadd float %tmp_480, %tmp_478
  %tmp_482 = load <4 x float>* %sum3, align 16
  %tmp_483 = insertelement <4 x float> %tmp_482, float %tmp_481, i32 2
  store <4 x float> %tmp_483, <4 x float>* %sum3, align 16
  %tmp_484 = load <4 x float>* %tempA3, align 16
  %tmp_485 = extractelement <4 x float> %tmp_484, i32 0
  %tmp_486 = load <4 x float>* %tempB0, align 16
  %tmp_487 = extractelement <4 x float> %tmp_486, i32 3
  %tmp_488 = load <4 x float>* %tempA3, align 16
  %tmp_489 = extractelement <4 x float> %tmp_488, i32 1
  %tmp_490 = load <4 x float>* %tempB1, align 16
  %tmp_491 = extractelement <4 x float> %tmp_490, i32 3
  %tmp_492 = fmul float %tmp_489, %tmp_491
  %tmp_493 = call float @llvm.fmuladd.f32(float %tmp_485, float %tmp_487, float %tmp_492)
  %tmp_494 = load <4 x float>* %tempA3, align 16
  %tmp_495 = extractelement <4 x float> %tmp_494, i32 2
  %tmp_496 = load <4 x float>* %tempB2, align 16
  %tmp_497 = extractelement <4 x float> %tmp_496, i32 3
  %tmp_498 = call float @llvm.fmuladd.f32(float %tmp_495, float %tmp_497, float %tmp_493)
  %tmp_499 = load <4 x float>* %tempA3, align 16
  %tmp_500 = extractelement <4 x float> %tmp_499, i32 3
  %tmp_501 = load <4 x float>* %tempB3, align 16
  %tmp_502 = extractelement <4 x float> %tmp_501, i32 3
  %tmp_503 = call float @llvm.fmuladd.f32(float %tmp_500, float %tmp_502, float %tmp_498)
  %tmp_504 = load <4 x float>* %sum3, align 16
  %tmp_505 = extractelement <4 x float> %tmp_504, i32 3
  %tmp_506 = fadd float %tmp_505, %tmp_503
  %tmp_507 = load <4 x float>* %sum3, align 16
  %tmp_508 = insertelement <4 x float> %tmp_507, float %tmp_506, i32 3
  store <4 x float> %tmp_508, <4 x float>* %sum3, align 16
  br label %tmp_509

tmp_509:                                     ; preds = %tmp_18
  %tmp_510 = load i32* %i, align 4
  %tmp_511 = add nsw i32 %tmp_510, 4
  store i32 %tmp_511, i32* %i, align 4
  br label %tmp_14

tmp_512:                                     ; preds = %tmp_14
  %tmp_513 = load <4 x float>* %sum0, align 16
  %tmp_514 = load <2 x i32>* %pos, align 8
  %tmp_515 = extractelement <2 x i32> %tmp_514, i32 0
  %tmp_516 = load <2 x i32>* %pos, align 8
  %tmp_517 = extractelement <2 x i32> %tmp_516, i32 1
  %tmp_518 = shl i32 %tmp_517, 2
  %tmp_519 = add nsw i32 %tmp_518, 0
  %tmp_520 = load i32* %tmp_5, align 4
  %tmp_521 = mul i32 %tmp_519, %tmp_520
  %tmp_522 = add i32 %tmp_515, %tmp_521
  %tmp_523 = load <4 x float> addrspace(1)** %tmp_3, align 4
  %tmp_524 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_523, i32 %tmp_522
  store <4 x float> %tmp_513, <4 x float> addrspace(1)* %tmp_524, align 16
  %tmp_525 = load <4 x float>* %sum1, align 16
  %tmp_526 = load <2 x i32>* %pos, align 8
  %tmp_527 = extractelement <2 x i32> %tmp_526, i32 0
  %tmp_528 = load <2 x i32>* %pos, align 8
  %tmp_529 = extractelement <2 x i32> %tmp_528, i32 1
  %tmp_530 = shl i32 %tmp_529, 2
  %tmp_531 = add nsw i32 %tmp_530, 1
  %tmp_532 = load i32* %tmp_5, align 4
  %tmp_533 = mul i32 %tmp_531, %tmp_532
  %tmp_534 = add i32 %tmp_527, %tmp_533
  %tmp_535 = load <4 x float> addrspace(1)** %tmp_3, align 4
  %tmp_536 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_535, i32 %tmp_534
  store <4 x float> %tmp_525, <4 x float> addrspace(1)* %tmp_536, align 16
  %tmp_537 = load <4 x float>* %sum2, align 16
  %tmp_538 = load <2 x i32>* %pos, align 8
  %tmp_539 = extractelement <2 x i32> %tmp_538, i32 0
  %tmp_540 = load <2 x i32>* %pos, align 8
  %tmp_541 = extractelement <2 x i32> %tmp_540, i32 1
  %tmp_542 = shl i32 %tmp_541, 2
  %tmp_543 = add nsw i32 %tmp_542, 2
  %tmp_544 = load i32* %tmp_5, align 4
  %tmp_545 = mul i32 %tmp_543, %tmp_544
  %tmp_546 = add i32 %tmp_539, %tmp_545
  %tmp_547 = load <4 x float> addrspace(1)** %tmp_3, align 4
  %tmp_548 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_547, i32 %tmp_546
  store <4 x float> %tmp_537, <4 x float> addrspace(1)* %tmp_548, align 16
  %tmp_549 = load <4 x float>* %sum3, align 16
  %tmp_550 = load <2 x i32>* %pos, align 8
  %tmp_551 = extractelement <2 x i32> %tmp_550, i32 0
  %tmp_552 = load <2 x i32>* %pos, align 8
  %tmp_553 = extractelement <2 x i32> %tmp_552, i32 1
  %tmp_554 = shl i32 %tmp_553, 2
  %tmp_555 = add nsw i32 %tmp_554, 3
  %tmp_556 = load i32* %tmp_5, align 4
  %tmp_557 = mul i32 %tmp_555, %tmp_556
  %tmp_558 = add i32 %tmp_551, %tmp_557
  %tmp_559 = load <4 x float> addrspace(1)** %tmp_3, align 4
  %tmp_560 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_559, i32 %tmp_558
  store <4 x float> %tmp_549, <4 x float> addrspace(1)* %tmp_560, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind
define void @mmmKernel_local(<4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)* %matrixC, i32 %widthA, <4 x float> addrspace(3)* %blockA) #0 {
  %tmp_1 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_3 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca <4 x float> addrspace(3)*, align 4
  %blockPos = alloca i32, align 4
  %globalPos = alloca i32, align 4
  %sum0 = alloca <4 x float>, align 16
  %sum1 = alloca <4 x float>, align 16
  %sum2 = alloca <4 x float>, align 16
  %sum3 = alloca <4 x float>, align 16
  %temp = alloca i32, align 4
  %i = alloca i32, align 4
  %globalPosA = alloca i32, align 4
  %globalPosB = alloca i32, align 4
  %j = alloca i32, align 4
  %tempA0 = alloca <4 x float>, align 16
  %tempA1 = alloca <4 x float>, align 16
  %tempA2 = alloca <4 x float>, align 16
  %tempA3 = alloca <4 x float>, align 16
  %tempB0 = alloca <4 x float>, align 16
  %tempB1 = alloca <4 x float>, align 16
  %tempB2 = alloca <4 x float>, align 16
  %tempB3 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)** %tmp_1, align 4
  store <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)** %tmp_2, align 4
  store <4 x float> addrspace(1)* %matrixC, <4 x float> addrspace(1)** %tmp_3, align 4
  store i32 %widthA, i32* %tmp_4, align 4
  store <4 x float> addrspace(3)* %blockA, <4 x float> addrspace(3)** %tmp_5, align 4
  %tmp_6 = call i32 @__get_local_id_u32(i32 0)
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  %tmp_8 = call i32 @__get_local_id_u32(i32 1)
  %tmp_9 = shl i32 %tmp_8, 2
  %tmp_10 = mul i32 %tmp_7, %tmp_9
  %tmp_11 = add i32 %tmp_6, %tmp_10
  store i32 %tmp_11, i32* %blockPos, align 4
  %tmp_12 = call i32 @__get_global_id_u32(i32 0)
  %tmp_13 = call i32 @__get_global_id_u32(i32 1)
  %tmp_14 = shl i32 %tmp_13, 2
  %tmp_15 = call i32 @__get_global_size_u32(i32 0)
  %tmp_16 = mul i32 %tmp_14, %tmp_15
  %tmp_17 = add i32 %tmp_12, %tmp_16
  store i32 %tmp_17, i32* %globalPos, align 4
  store <4 x float> zeroinitializer, <4 x float>* %sum0, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum3, align 16
  %tmp_18 = load i32* %tmp_4, align 4
  %tmp_19 = sdiv i32 %tmp_18, 4
  store i32 %tmp_19, i32* %temp, align 4
  store i32 0, i32* %i, align 4
  br label %tmp_20

tmp_20:                                      ; preds = %tmp_577, %tmp_0
  %tmp_21 = load i32* %i, align 4
  %tmp_22 = load i32* %temp, align 4
  %tmp_23 = call i32 @__get_local_size_u32(i32 0)
  %tmp_24 = udiv i32 %tmp_22, %tmp_23
  %tmp_25 = icmp ult i32 %tmp_21, %tmp_24
  br i1 %tmp_25, label %tmp_26, label %tmp_580

tmp_26:                                      ; preds = %tmp_20
  %tmp_27 = load i32* %i, align 4
  %tmp_28 = call i32 @__get_local_size_u32(i32 0)
  %tmp_29 = mul i32 %tmp_27, %tmp_28
  %tmp_30 = call i32 @__get_local_id_u32(i32 0)
  %tmp_31 = add i32 %tmp_29, %tmp_30
  %tmp_32 = call i32 @__get_global_id_u32(i32 1)
  %tmp_33 = shl i32 %tmp_32, 2
  %tmp_34 = load i32* %temp, align 4
  %tmp_35 = mul i32 %tmp_33, %tmp_34
  %tmp_36 = add i32 %tmp_31, %tmp_35
  store i32 %tmp_36, i32* %globalPosA, align 4
  %tmp_37 = load i32* %globalPosA, align 4
  %tmp_38 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_39 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_38, i32 %tmp_37
  %tmp_40 = load <4 x float> addrspace(1)* %tmp_39, align 16
  %tmp_41 = load i32* %blockPos, align 4
  %tmp_42 = load <4 x float> addrspace(3)** %tmp_5, align 4
  %tmp_43 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_42, i32 %tmp_41
  store <4 x float> %tmp_40, <4 x float> addrspace(3)* %tmp_43, align 16
  %tmp_44 = load i32* %globalPosA, align 4
  %tmp_45 = load i32* %temp, align 4
  %tmp_46 = add nsw i32 %tmp_44, %tmp_45
  %tmp_47 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_48 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_47, i32 %tmp_46
  %tmp_49 = load <4 x float> addrspace(1)* %tmp_48, align 16
  %tmp_50 = load i32* %blockPos, align 4
  %tmp_51 = call i32 @__get_local_size_u32(i32 0)
  %tmp_52 = add i32 %tmp_50, %tmp_51
  %tmp_53 = load <4 x float> addrspace(3)** %tmp_5, align 4
  %tmp_54 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_53, i32 %tmp_52
  store <4 x float> %tmp_49, <4 x float> addrspace(3)* %tmp_54, align 16
  %tmp_55 = load i32* %globalPosA, align 4
  %tmp_56 = load i32* %temp, align 4
  %tmp_57 = mul nsw i32 2, %tmp_56
  %tmp_58 = add nsw i32 %tmp_55, %tmp_57
  %tmp_59 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_60 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_59, i32 %tmp_58
  %tmp_61 = load <4 x float> addrspace(1)* %tmp_60, align 16
  %tmp_62 = load i32* %blockPos, align 4
  %tmp_63 = call i32 @__get_local_size_u32(i32 0)
  %tmp_64 = mul i32 2, %tmp_63
  %tmp_65 = add i32 %tmp_62, %tmp_64
  %tmp_66 = load <4 x float> addrspace(3)** %tmp_5, align 4
  %tmp_67 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_66, i32 %tmp_65
  store <4 x float> %tmp_61, <4 x float> addrspace(3)* %tmp_67, align 16
  %tmp_68 = load i32* %globalPosA, align 4
  %tmp_69 = load i32* %temp, align 4
  %tmp_70 = mul nsw i32 3, %tmp_69
  %tmp_71 = add nsw i32 %tmp_68, %tmp_70
  %tmp_72 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_73 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_72, i32 %tmp_71
  %tmp_74 = load <4 x float> addrspace(1)* %tmp_73, align 16
  %tmp_75 = load i32* %blockPos, align 4
  %tmp_76 = call i32 @__get_local_size_u32(i32 0)
  %tmp_77 = mul i32 3, %tmp_76
  %tmp_78 = add i32 %tmp_75, %tmp_77
  %tmp_79 = load <4 x float> addrspace(3)** %tmp_5, align 4
  %tmp_80 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_79, i32 %tmp_78
  store <4 x float> %tmp_74, <4 x float> addrspace(3)* %tmp_80, align 16
  call void @barrier(i32 1)
  %tmp_81 = call i32 @__get_global_id_u32(i32 0)
  %tmp_82 = load i32* %i, align 4
  %tmp_83 = call i32 @__get_local_size_u32(i32 0)
  %tmp_84 = mul i32 %tmp_82, %tmp_83
  %tmp_85 = shl i32 %tmp_84, 2
  %tmp_86 = call i32 @__get_global_size_u32(i32 0)
  %tmp_87 = mul i32 %tmp_85, %tmp_86
  %tmp_88 = add i32 %tmp_81, %tmp_87
  store i32 %tmp_88, i32* %globalPosB, align 4
  store i32 0, i32* %j, align 4
  br label %tmp_89

tmp_89:                                      ; preds = %tmp_573, %tmp_26
  %tmp_90 = load i32* %j, align 4
  %tmp_91 = call i32 @__get_local_size_u32(i32 0)
  %tmp_92 = mul i32 %tmp_91, 4
  %tmp_93 = icmp ult i32 %tmp_90, %tmp_92
  br i1 %tmp_93, label %tmp_94, label %tmp_576

tmp_94:                                      ; preds = %tmp_89
  %tmp_95 = load i32* %j, align 4
  %tmp_96 = ashr i32 %tmp_95, 2
  %tmp_97 = call i32 @__get_local_id_u32(i32 1)
  %tmp_98 = mul i32 %tmp_97, 4
  %tmp_99 = call i32 @__get_local_size_u32(i32 0)
  %tmp_100 = mul i32 %tmp_98, %tmp_99
  %tmp_101 = add i32 %tmp_96, %tmp_100
  %tmp_102 = load <4 x float> addrspace(3)** %tmp_5, align 4
  %tmp_103 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_102, i32 %tmp_101
  %tmp_104 = load <4 x float> addrspace(3)* %tmp_103, align 16
  store <4 x float> %tmp_104, <4 x float>* %tempA0, align 16
  %tmp_105 = load i32* %j, align 4
  %tmp_106 = ashr i32 %tmp_105, 2
  %tmp_107 = call i32 @__get_local_id_u32(i32 1)
  %tmp_108 = mul i32 %tmp_107, 4
  %tmp_109 = add i32 %tmp_108, 1
  %tmp_110 = call i32 @__get_local_size_u32(i32 0)
  %tmp_111 = mul i32 %tmp_109, %tmp_110
  %tmp_112 = add i32 %tmp_106, %tmp_111
  %tmp_113 = load <4 x float> addrspace(3)** %tmp_5, align 4
  %tmp_114 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_113, i32 %tmp_112
  %tmp_115 = load <4 x float> addrspace(3)* %tmp_114, align 16
  store <4 x float> %tmp_115, <4 x float>* %tempA1, align 16
  %tmp_116 = load i32* %j, align 4
  %tmp_117 = ashr i32 %tmp_116, 2
  %tmp_118 = call i32 @__get_local_id_u32(i32 1)
  %tmp_119 = mul i32 %tmp_118, 4
  %tmp_120 = add i32 %tmp_119, 2
  %tmp_121 = call i32 @__get_local_size_u32(i32 0)
  %tmp_122 = mul i32 %tmp_120, %tmp_121
  %tmp_123 = add i32 %tmp_117, %tmp_122
  %tmp_124 = load <4 x float> addrspace(3)** %tmp_5, align 4
  %tmp_125 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_124, i32 %tmp_123
  %tmp_126 = load <4 x float> addrspace(3)* %tmp_125, align 16
  store <4 x float> %tmp_126, <4 x float>* %tempA2, align 16
  %tmp_127 = load i32* %j, align 4
  %tmp_128 = ashr i32 %tmp_127, 2
  %tmp_129 = call i32 @__get_local_id_u32(i32 1)
  %tmp_130 = mul i32 %tmp_129, 4
  %tmp_131 = add i32 %tmp_130, 3
  %tmp_132 = call i32 @__get_local_size_u32(i32 0)
  %tmp_133 = mul i32 %tmp_131, %tmp_132
  %tmp_134 = add i32 %tmp_128, %tmp_133
  %tmp_135 = load <4 x float> addrspace(3)** %tmp_5, align 4
  %tmp_136 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_135, i32 %tmp_134
  %tmp_137 = load <4 x float> addrspace(3)* %tmp_136, align 16
  store <4 x float> %tmp_137, <4 x float>* %tempA3, align 16
  %tmp_138 = load i32* %globalPosB, align 4
  %tmp_139 = load i32* %j, align 4
  %tmp_140 = call i32 @__get_global_size_u32(i32 0)
  %tmp_141 = mul i32 %tmp_139, %tmp_140
  %tmp_142 = add i32 %tmp_138, %tmp_141
  %tmp_143 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_144 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_143, i32 %tmp_142
  %tmp_145 = load <4 x float> addrspace(1)* %tmp_144, align 16
  store <4 x float> %tmp_145, <4 x float>* %tempB0, align 16
  %tmp_146 = load i32* %globalPosB, align 4
  %tmp_147 = load i32* %j, align 4
  %tmp_148 = add nsw i32 %tmp_147, 1
  %tmp_149 = call i32 @__get_global_size_u32(i32 0)
  %tmp_150 = mul i32 %tmp_148, %tmp_149
  %tmp_151 = add i32 %tmp_146, %tmp_150
  %tmp_152 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_153 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_152, i32 %tmp_151
  %tmp_154 = load <4 x float> addrspace(1)* %tmp_153, align 16
  store <4 x float> %tmp_154, <4 x float>* %tempB1, align 16
  %tmp_155 = load i32* %globalPosB, align 4
  %tmp_156 = load i32* %j, align 4
  %tmp_157 = add nsw i32 %tmp_156, 2
  %tmp_158 = call i32 @__get_global_size_u32(i32 0)
  %tmp_159 = mul i32 %tmp_157, %tmp_158
  %tmp_160 = add i32 %tmp_155, %tmp_159
  %tmp_161 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_162 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_161, i32 %tmp_160
  %tmp_163 = load <4 x float> addrspace(1)* %tmp_162, align 16
  store <4 x float> %tmp_163, <4 x float>* %tempB2, align 16
  %tmp_164 = load i32* %globalPosB, align 4
  %tmp_165 = load i32* %j, align 4
  %tmp_166 = add nsw i32 %tmp_165, 3
  %tmp_167 = call i32 @__get_global_size_u32(i32 0)
  %tmp_168 = mul i32 %tmp_166, %tmp_167
  %tmp_169 = add i32 %tmp_164, %tmp_168
  %tmp_170 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_171 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_170, i32 %tmp_169
  %tmp_172 = load <4 x float> addrspace(1)* %tmp_171, align 16
  store <4 x float> %tmp_172, <4 x float>* %tempB3, align 16
  %tmp_173 = load <4 x float>* %tempA0, align 16
  %tmp_174 = extractelement <4 x float> %tmp_173, i32 0
  %tmp_175 = load <4 x float>* %tempB0, align 16
  %tmp_176 = extractelement <4 x float> %tmp_175, i32 0
  %tmp_177 = load <4 x float>* %tempA0, align 16
  %tmp_178 = extractelement <4 x float> %tmp_177, i32 1
  %tmp_179 = load <4 x float>* %tempB1, align 16
  %tmp_180 = extractelement <4 x float> %tmp_179, i32 0
  %tmp_181 = fmul float %tmp_178, %tmp_180
  %tmp_182 = call float @llvm.fmuladd.f32(float %tmp_174, float %tmp_176, float %tmp_181)
  %tmp_183 = load <4 x float>* %tempA0, align 16
  %tmp_184 = extractelement <4 x float> %tmp_183, i32 2
  %tmp_185 = load <4 x float>* %tempB2, align 16
  %tmp_186 = extractelement <4 x float> %tmp_185, i32 0
  %tmp_187 = call float @llvm.fmuladd.f32(float %tmp_184, float %tmp_186, float %tmp_182)
  %tmp_188 = load <4 x float>* %tempA0, align 16
  %tmp_189 = extractelement <4 x float> %tmp_188, i32 3
  %tmp_190 = load <4 x float>* %tempB3, align 16
  %tmp_191 = extractelement <4 x float> %tmp_190, i32 0
  %tmp_192 = call float @llvm.fmuladd.f32(float %tmp_189, float %tmp_191, float %tmp_187)
  %tmp_193 = load <4 x float>* %sum0, align 16
  %tmp_194 = extractelement <4 x float> %tmp_193, i32 0
  %tmp_195 = fadd float %tmp_194, %tmp_192
  %tmp_196 = load <4 x float>* %sum0, align 16
  %tmp_197 = insertelement <4 x float> %tmp_196, float %tmp_195, i32 0
  store <4 x float> %tmp_197, <4 x float>* %sum0, align 16
  %tmp_198 = load <4 x float>* %tempA0, align 16
  %tmp_199 = extractelement <4 x float> %tmp_198, i32 0
  %tmp_200 = load <4 x float>* %tempB0, align 16
  %tmp_201 = extractelement <4 x float> %tmp_200, i32 1
  %tmp_202 = load <4 x float>* %tempA0, align 16
  %tmp_203 = extractelement <4 x float> %tmp_202, i32 1
  %tmp_204 = load <4 x float>* %tempB1, align 16
  %tmp_205 = extractelement <4 x float> %tmp_204, i32 1
  %tmp_206 = fmul float %tmp_203, %tmp_205
  %tmp_207 = call float @llvm.fmuladd.f32(float %tmp_199, float %tmp_201, float %tmp_206)
  %tmp_208 = load <4 x float>* %tempA0, align 16
  %tmp_209 = extractelement <4 x float> %tmp_208, i32 2
  %tmp_210 = load <4 x float>* %tempB2, align 16
  %tmp_211 = extractelement <4 x float> %tmp_210, i32 1
  %tmp_212 = call float @llvm.fmuladd.f32(float %tmp_209, float %tmp_211, float %tmp_207)
  %tmp_213 = load <4 x float>* %tempA0, align 16
  %tmp_214 = extractelement <4 x float> %tmp_213, i32 3
  %tmp_215 = load <4 x float>* %tempB3, align 16
  %tmp_216 = extractelement <4 x float> %tmp_215, i32 1
  %tmp_217 = call float @llvm.fmuladd.f32(float %tmp_214, float %tmp_216, float %tmp_212)
  %tmp_218 = load <4 x float>* %sum0, align 16
  %tmp_219 = extractelement <4 x float> %tmp_218, i32 1
  %tmp_220 = fadd float %tmp_219, %tmp_217
  %tmp_221 = load <4 x float>* %sum0, align 16
  %tmp_222 = insertelement <4 x float> %tmp_221, float %tmp_220, i32 1
  store <4 x float> %tmp_222, <4 x float>* %sum0, align 16
  %tmp_223 = load <4 x float>* %tempA0, align 16
  %tmp_224 = extractelement <4 x float> %tmp_223, i32 0
  %tmp_225 = load <4 x float>* %tempB0, align 16
  %tmp_226 = extractelement <4 x float> %tmp_225, i32 2
  %tmp_227 = load <4 x float>* %tempA0, align 16
  %tmp_228 = extractelement <4 x float> %tmp_227, i32 1
  %tmp_229 = load <4 x float>* %tempB1, align 16
  %tmp_230 = extractelement <4 x float> %tmp_229, i32 2
  %tmp_231 = fmul float %tmp_228, %tmp_230
  %tmp_232 = call float @llvm.fmuladd.f32(float %tmp_224, float %tmp_226, float %tmp_231)
  %tmp_233 = load <4 x float>* %tempA0, align 16
  %tmp_234 = extractelement <4 x float> %tmp_233, i32 2
  %tmp_235 = load <4 x float>* %tempB2, align 16
  %tmp_236 = extractelement <4 x float> %tmp_235, i32 2
  %tmp_237 = call float @llvm.fmuladd.f32(float %tmp_234, float %tmp_236, float %tmp_232)
  %tmp_238 = load <4 x float>* %tempA0, align 16
  %tmp_239 = extractelement <4 x float> %tmp_238, i32 3
  %tmp_240 = load <4 x float>* %tempB3, align 16
  %tmp_241 = extractelement <4 x float> %tmp_240, i32 2
  %tmp_242 = call float @llvm.fmuladd.f32(float %tmp_239, float %tmp_241, float %tmp_237)
  %tmp_243 = load <4 x float>* %sum0, align 16
  %tmp_244 = extractelement <4 x float> %tmp_243, i32 2
  %tmp_245 = fadd float %tmp_244, %tmp_242
  %tmp_246 = load <4 x float>* %sum0, align 16
  %tmp_247 = insertelement <4 x float> %tmp_246, float %tmp_245, i32 2
  store <4 x float> %tmp_247, <4 x float>* %sum0, align 16
  %tmp_248 = load <4 x float>* %tempA0, align 16
  %tmp_249 = extractelement <4 x float> %tmp_248, i32 0
  %tmp_250 = load <4 x float>* %tempB0, align 16
  %tmp_251 = extractelement <4 x float> %tmp_250, i32 3
  %tmp_252 = load <4 x float>* %tempA0, align 16
  %tmp_253 = extractelement <4 x float> %tmp_252, i32 1
  %tmp_254 = load <4 x float>* %tempB1, align 16
  %tmp_255 = extractelement <4 x float> %tmp_254, i32 3
  %tmp_256 = fmul float %tmp_253, %tmp_255
  %tmp_257 = call float @llvm.fmuladd.f32(float %tmp_249, float %tmp_251, float %tmp_256)
  %tmp_258 = load <4 x float>* %tempA0, align 16
  %tmp_259 = extractelement <4 x float> %tmp_258, i32 2
  %tmp_260 = load <4 x float>* %tempB2, align 16
  %tmp_261 = extractelement <4 x float> %tmp_260, i32 3
  %tmp_262 = call float @llvm.fmuladd.f32(float %tmp_259, float %tmp_261, float %tmp_257)
  %tmp_263 = load <4 x float>* %tempA0, align 16
  %tmp_264 = extractelement <4 x float> %tmp_263, i32 3
  %tmp_265 = load <4 x float>* %tempB3, align 16
  %tmp_266 = extractelement <4 x float> %tmp_265, i32 3
  %tmp_267 = call float @llvm.fmuladd.f32(float %tmp_264, float %tmp_266, float %tmp_262)
  %tmp_268 = load <4 x float>* %sum0, align 16
  %tmp_269 = extractelement <4 x float> %tmp_268, i32 3
  %tmp_270 = fadd float %tmp_269, %tmp_267
  %tmp_271 = load <4 x float>* %sum0, align 16
  %tmp_272 = insertelement <4 x float> %tmp_271, float %tmp_270, i32 3
  store <4 x float> %tmp_272, <4 x float>* %sum0, align 16
  %tmp_273 = load <4 x float>* %tempA1, align 16
  %tmp_274 = extractelement <4 x float> %tmp_273, i32 0
  %tmp_275 = load <4 x float>* %tempB0, align 16
  %tmp_276 = extractelement <4 x float> %tmp_275, i32 0
  %tmp_277 = load <4 x float>* %tempA1, align 16
  %tmp_278 = extractelement <4 x float> %tmp_277, i32 1
  %tmp_279 = load <4 x float>* %tempB1, align 16
  %tmp_280 = extractelement <4 x float> %tmp_279, i32 0
  %tmp_281 = fmul float %tmp_278, %tmp_280
  %tmp_282 = call float @llvm.fmuladd.f32(float %tmp_274, float %tmp_276, float %tmp_281)
  %tmp_283 = load <4 x float>* %tempA1, align 16
  %tmp_284 = extractelement <4 x float> %tmp_283, i32 2
  %tmp_285 = load <4 x float>* %tempB2, align 16
  %tmp_286 = extractelement <4 x float> %tmp_285, i32 0
  %tmp_287 = call float @llvm.fmuladd.f32(float %tmp_284, float %tmp_286, float %tmp_282)
  %tmp_288 = load <4 x float>* %tempA1, align 16
  %tmp_289 = extractelement <4 x float> %tmp_288, i32 3
  %tmp_290 = load <4 x float>* %tempB3, align 16
  %tmp_291 = extractelement <4 x float> %tmp_290, i32 0
  %tmp_292 = call float @llvm.fmuladd.f32(float %tmp_289, float %tmp_291, float %tmp_287)
  %tmp_293 = load <4 x float>* %sum1, align 16
  %tmp_294 = extractelement <4 x float> %tmp_293, i32 0
  %tmp_295 = fadd float %tmp_294, %tmp_292
  %tmp_296 = load <4 x float>* %sum1, align 16
  %tmp_297 = insertelement <4 x float> %tmp_296, float %tmp_295, i32 0
  store <4 x float> %tmp_297, <4 x float>* %sum1, align 16
  %tmp_298 = load <4 x float>* %tempA1, align 16
  %tmp_299 = extractelement <4 x float> %tmp_298, i32 0
  %tmp_300 = load <4 x float>* %tempB0, align 16
  %tmp_301 = extractelement <4 x float> %tmp_300, i32 1
  %tmp_302 = load <4 x float>* %tempA1, align 16
  %tmp_303 = extractelement <4 x float> %tmp_302, i32 1
  %tmp_304 = load <4 x float>* %tempB1, align 16
  %tmp_305 = extractelement <4 x float> %tmp_304, i32 1
  %tmp_306 = fmul float %tmp_303, %tmp_305
  %tmp_307 = call float @llvm.fmuladd.f32(float %tmp_299, float %tmp_301, float %tmp_306)
  %tmp_308 = load <4 x float>* %tempA1, align 16
  %tmp_309 = extractelement <4 x float> %tmp_308, i32 2
  %tmp_310 = load <4 x float>* %tempB2, align 16
  %tmp_311 = extractelement <4 x float> %tmp_310, i32 1
  %tmp_312 = call float @llvm.fmuladd.f32(float %tmp_309, float %tmp_311, float %tmp_307)
  %tmp_313 = load <4 x float>* %tempA1, align 16
  %tmp_314 = extractelement <4 x float> %tmp_313, i32 3
  %tmp_315 = load <4 x float>* %tempB3, align 16
  %tmp_316 = extractelement <4 x float> %tmp_315, i32 1
  %tmp_317 = call float @llvm.fmuladd.f32(float %tmp_314, float %tmp_316, float %tmp_312)
  %tmp_318 = load <4 x float>* %sum1, align 16
  %tmp_319 = extractelement <4 x float> %tmp_318, i32 1
  %tmp_320 = fadd float %tmp_319, %tmp_317
  %tmp_321 = load <4 x float>* %sum1, align 16
  %tmp_322 = insertelement <4 x float> %tmp_321, float %tmp_320, i32 1
  store <4 x float> %tmp_322, <4 x float>* %sum1, align 16
  %tmp_323 = load <4 x float>* %tempA1, align 16
  %tmp_324 = extractelement <4 x float> %tmp_323, i32 0
  %tmp_325 = load <4 x float>* %tempB0, align 16
  %tmp_326 = extractelement <4 x float> %tmp_325, i32 2
  %tmp_327 = load <4 x float>* %tempA1, align 16
  %tmp_328 = extractelement <4 x float> %tmp_327, i32 1
  %tmp_329 = load <4 x float>* %tempB1, align 16
  %tmp_330 = extractelement <4 x float> %tmp_329, i32 2
  %tmp_331 = fmul float %tmp_328, %tmp_330
  %tmp_332 = call float @llvm.fmuladd.f32(float %tmp_324, float %tmp_326, float %tmp_331)
  %tmp_333 = load <4 x float>* %tempA1, align 16
  %tmp_334 = extractelement <4 x float> %tmp_333, i32 2
  %tmp_335 = load <4 x float>* %tempB2, align 16
  %tmp_336 = extractelement <4 x float> %tmp_335, i32 2
  %tmp_337 = call float @llvm.fmuladd.f32(float %tmp_334, float %tmp_336, float %tmp_332)
  %tmp_338 = load <4 x float>* %tempA1, align 16
  %tmp_339 = extractelement <4 x float> %tmp_338, i32 3
  %tmp_340 = load <4 x float>* %tempB3, align 16
  %tmp_341 = extractelement <4 x float> %tmp_340, i32 2
  %tmp_342 = call float @llvm.fmuladd.f32(float %tmp_339, float %tmp_341, float %tmp_337)
  %tmp_343 = load <4 x float>* %sum1, align 16
  %tmp_344 = extractelement <4 x float> %tmp_343, i32 2
  %tmp_345 = fadd float %tmp_344, %tmp_342
  %tmp_346 = load <4 x float>* %sum1, align 16
  %tmp_347 = insertelement <4 x float> %tmp_346, float %tmp_345, i32 2
  store <4 x float> %tmp_347, <4 x float>* %sum1, align 16
  %tmp_348 = load <4 x float>* %tempA1, align 16
  %tmp_349 = extractelement <4 x float> %tmp_348, i32 0
  %tmp_350 = load <4 x float>* %tempB0, align 16
  %tmp_351 = extractelement <4 x float> %tmp_350, i32 3
  %tmp_352 = load <4 x float>* %tempA1, align 16
  %tmp_353 = extractelement <4 x float> %tmp_352, i32 1
  %tmp_354 = load <4 x float>* %tempB1, align 16
  %tmp_355 = extractelement <4 x float> %tmp_354, i32 3
  %tmp_356 = fmul float %tmp_353, %tmp_355
  %tmp_357 = call float @llvm.fmuladd.f32(float %tmp_349, float %tmp_351, float %tmp_356)
  %tmp_358 = load <4 x float>* %tempA1, align 16
  %tmp_359 = extractelement <4 x float> %tmp_358, i32 2
  %tmp_360 = load <4 x float>* %tempB2, align 16
  %tmp_361 = extractelement <4 x float> %tmp_360, i32 3
  %tmp_362 = call float @llvm.fmuladd.f32(float %tmp_359, float %tmp_361, float %tmp_357)
  %tmp_363 = load <4 x float>* %tempA1, align 16
  %tmp_364 = extractelement <4 x float> %tmp_363, i32 3
  %tmp_365 = load <4 x float>* %tempB3, align 16
  %tmp_366 = extractelement <4 x float> %tmp_365, i32 3
  %tmp_367 = call float @llvm.fmuladd.f32(float %tmp_364, float %tmp_366, float %tmp_362)
  %tmp_368 = load <4 x float>* %sum1, align 16
  %tmp_369 = extractelement <4 x float> %tmp_368, i32 3
  %tmp_370 = fadd float %tmp_369, %tmp_367
  %tmp_371 = load <4 x float>* %sum1, align 16
  %tmp_372 = insertelement <4 x float> %tmp_371, float %tmp_370, i32 3
  store <4 x float> %tmp_372, <4 x float>* %sum1, align 16
  %tmp_373 = load <4 x float>* %tempA2, align 16
  %tmp_374 = extractelement <4 x float> %tmp_373, i32 0
  %tmp_375 = load <4 x float>* %tempB0, align 16
  %tmp_376 = extractelement <4 x float> %tmp_375, i32 0
  %tmp_377 = load <4 x float>* %tempA2, align 16
  %tmp_378 = extractelement <4 x float> %tmp_377, i32 1
  %tmp_379 = load <4 x float>* %tempB1, align 16
  %tmp_380 = extractelement <4 x float> %tmp_379, i32 0
  %tmp_381 = fmul float %tmp_378, %tmp_380
  %tmp_382 = call float @llvm.fmuladd.f32(float %tmp_374, float %tmp_376, float %tmp_381)
  %tmp_383 = load <4 x float>* %tempA2, align 16
  %tmp_384 = extractelement <4 x float> %tmp_383, i32 2
  %tmp_385 = load <4 x float>* %tempB2, align 16
  %tmp_386 = extractelement <4 x float> %tmp_385, i32 0
  %tmp_387 = call float @llvm.fmuladd.f32(float %tmp_384, float %tmp_386, float %tmp_382)
  %tmp_388 = load <4 x float>* %tempA2, align 16
  %tmp_389 = extractelement <4 x float> %tmp_388, i32 3
  %tmp_390 = load <4 x float>* %tempB3, align 16
  %tmp_391 = extractelement <4 x float> %tmp_390, i32 0
  %tmp_392 = call float @llvm.fmuladd.f32(float %tmp_389, float %tmp_391, float %tmp_387)
  %tmp_393 = load <4 x float>* %sum2, align 16
  %tmp_394 = extractelement <4 x float> %tmp_393, i32 0
  %tmp_395 = fadd float %tmp_394, %tmp_392
  %tmp_396 = load <4 x float>* %sum2, align 16
  %tmp_397 = insertelement <4 x float> %tmp_396, float %tmp_395, i32 0
  store <4 x float> %tmp_397, <4 x float>* %sum2, align 16
  %tmp_398 = load <4 x float>* %tempA2, align 16
  %tmp_399 = extractelement <4 x float> %tmp_398, i32 0
  %tmp_400 = load <4 x float>* %tempB0, align 16
  %tmp_401 = extractelement <4 x float> %tmp_400, i32 1
  %tmp_402 = load <4 x float>* %tempA2, align 16
  %tmp_403 = extractelement <4 x float> %tmp_402, i32 1
  %tmp_404 = load <4 x float>* %tempB1, align 16
  %tmp_405 = extractelement <4 x float> %tmp_404, i32 1
  %tmp_406 = fmul float %tmp_403, %tmp_405
  %tmp_407 = call float @llvm.fmuladd.f32(float %tmp_399, float %tmp_401, float %tmp_406)
  %tmp_408 = load <4 x float>* %tempA2, align 16
  %tmp_409 = extractelement <4 x float> %tmp_408, i32 2
  %tmp_410 = load <4 x float>* %tempB2, align 16
  %tmp_411 = extractelement <4 x float> %tmp_410, i32 1
  %tmp_412 = call float @llvm.fmuladd.f32(float %tmp_409, float %tmp_411, float %tmp_407)
  %tmp_413 = load <4 x float>* %tempA2, align 16
  %tmp_414 = extractelement <4 x float> %tmp_413, i32 3
  %tmp_415 = load <4 x float>* %tempB3, align 16
  %tmp_416 = extractelement <4 x float> %tmp_415, i32 1
  %tmp_417 = call float @llvm.fmuladd.f32(float %tmp_414, float %tmp_416, float %tmp_412)
  %tmp_418 = load <4 x float>* %sum2, align 16
  %tmp_419 = extractelement <4 x float> %tmp_418, i32 1
  %tmp_420 = fadd float %tmp_419, %tmp_417
  %tmp_421 = load <4 x float>* %sum2, align 16
  %tmp_422 = insertelement <4 x float> %tmp_421, float %tmp_420, i32 1
  store <4 x float> %tmp_422, <4 x float>* %sum2, align 16
  %tmp_423 = load <4 x float>* %tempA2, align 16
  %tmp_424 = extractelement <4 x float> %tmp_423, i32 0
  %tmp_425 = load <4 x float>* %tempB0, align 16
  %tmp_426 = extractelement <4 x float> %tmp_425, i32 2
  %tmp_427 = load <4 x float>* %tempA2, align 16
  %tmp_428 = extractelement <4 x float> %tmp_427, i32 1
  %tmp_429 = load <4 x float>* %tempB1, align 16
  %tmp_430 = extractelement <4 x float> %tmp_429, i32 2
  %tmp_431 = fmul float %tmp_428, %tmp_430
  %tmp_432 = call float @llvm.fmuladd.f32(float %tmp_424, float %tmp_426, float %tmp_431)
  %tmp_433 = load <4 x float>* %tempA2, align 16
  %tmp_434 = extractelement <4 x float> %tmp_433, i32 2
  %tmp_435 = load <4 x float>* %tempB2, align 16
  %tmp_436 = extractelement <4 x float> %tmp_435, i32 2
  %tmp_437 = call float @llvm.fmuladd.f32(float %tmp_434, float %tmp_436, float %tmp_432)
  %tmp_438 = load <4 x float>* %tempA2, align 16
  %tmp_439 = extractelement <4 x float> %tmp_438, i32 3
  %tmp_440 = load <4 x float>* %tempB3, align 16
  %tmp_441 = extractelement <4 x float> %tmp_440, i32 2
  %tmp_442 = call float @llvm.fmuladd.f32(float %tmp_439, float %tmp_441, float %tmp_437)
  %tmp_443 = load <4 x float>* %sum2, align 16
  %tmp_444 = extractelement <4 x float> %tmp_443, i32 2
  %tmp_445 = fadd float %tmp_444, %tmp_442
  %tmp_446 = load <4 x float>* %sum2, align 16
  %tmp_447 = insertelement <4 x float> %tmp_446, float %tmp_445, i32 2
  store <4 x float> %tmp_447, <4 x float>* %sum2, align 16
  %tmp_448 = load <4 x float>* %tempA2, align 16
  %tmp_449 = extractelement <4 x float> %tmp_448, i32 0
  %tmp_450 = load <4 x float>* %tempB0, align 16
  %tmp_451 = extractelement <4 x float> %tmp_450, i32 3
  %tmp_452 = load <4 x float>* %tempA2, align 16
  %tmp_453 = extractelement <4 x float> %tmp_452, i32 1
  %tmp_454 = load <4 x float>* %tempB1, align 16
  %tmp_455 = extractelement <4 x float> %tmp_454, i32 3
  %tmp_456 = fmul float %tmp_453, %tmp_455
  %tmp_457 = call float @llvm.fmuladd.f32(float %tmp_449, float %tmp_451, float %tmp_456)
  %tmp_458 = load <4 x float>* %tempA2, align 16
  %tmp_459 = extractelement <4 x float> %tmp_458, i32 2
  %tmp_460 = load <4 x float>* %tempB2, align 16
  %tmp_461 = extractelement <4 x float> %tmp_460, i32 3
  %tmp_462 = call float @llvm.fmuladd.f32(float %tmp_459, float %tmp_461, float %tmp_457)
  %tmp_463 = load <4 x float>* %tempA2, align 16
  %tmp_464 = extractelement <4 x float> %tmp_463, i32 3
  %tmp_465 = load <4 x float>* %tempB3, align 16
  %tmp_466 = extractelement <4 x float> %tmp_465, i32 3
  %tmp_467 = call float @llvm.fmuladd.f32(float %tmp_464, float %tmp_466, float %tmp_462)
  %tmp_468 = load <4 x float>* %sum2, align 16
  %tmp_469 = extractelement <4 x float> %tmp_468, i32 3
  %tmp_470 = fadd float %tmp_469, %tmp_467
  %tmp_471 = load <4 x float>* %sum2, align 16
  %tmp_472 = insertelement <4 x float> %tmp_471, float %tmp_470, i32 3
  store <4 x float> %tmp_472, <4 x float>* %sum2, align 16
  %tmp_473 = load <4 x float>* %tempA3, align 16
  %tmp_474 = extractelement <4 x float> %tmp_473, i32 0
  %tmp_475 = load <4 x float>* %tempB0, align 16
  %tmp_476 = extractelement <4 x float> %tmp_475, i32 0
  %tmp_477 = load <4 x float>* %tempA3, align 16
  %tmp_478 = extractelement <4 x float> %tmp_477, i32 1
  %tmp_479 = load <4 x float>* %tempB1, align 16
  %tmp_480 = extractelement <4 x float> %tmp_479, i32 0
  %tmp_481 = fmul float %tmp_478, %tmp_480
  %tmp_482 = call float @llvm.fmuladd.f32(float %tmp_474, float %tmp_476, float %tmp_481)
  %tmp_483 = load <4 x float>* %tempA3, align 16
  %tmp_484 = extractelement <4 x float> %tmp_483, i32 2
  %tmp_485 = load <4 x float>* %tempB2, align 16
  %tmp_486 = extractelement <4 x float> %tmp_485, i32 0
  %tmp_487 = call float @llvm.fmuladd.f32(float %tmp_484, float %tmp_486, float %tmp_482)
  %tmp_488 = load <4 x float>* %tempA3, align 16
  %tmp_489 = extractelement <4 x float> %tmp_488, i32 3
  %tmp_490 = load <4 x float>* %tempB3, align 16
  %tmp_491 = extractelement <4 x float> %tmp_490, i32 0
  %tmp_492 = call float @llvm.fmuladd.f32(float %tmp_489, float %tmp_491, float %tmp_487)
  %tmp_493 = load <4 x float>* %sum3, align 16
  %tmp_494 = extractelement <4 x float> %tmp_493, i32 0
  %tmp_495 = fadd float %tmp_494, %tmp_492
  %tmp_496 = load <4 x float>* %sum3, align 16
  %tmp_497 = insertelement <4 x float> %tmp_496, float %tmp_495, i32 0
  store <4 x float> %tmp_497, <4 x float>* %sum3, align 16
  %tmp_498 = load <4 x float>* %tempA3, align 16
  %tmp_499 = extractelement <4 x float> %tmp_498, i32 0
  %tmp_500 = load <4 x float>* %tempB0, align 16
  %tmp_501 = extractelement <4 x float> %tmp_500, i32 1
  %tmp_502 = load <4 x float>* %tempA3, align 16
  %tmp_503 = extractelement <4 x float> %tmp_502, i32 1
  %tmp_504 = load <4 x float>* %tempB1, align 16
  %tmp_505 = extractelement <4 x float> %tmp_504, i32 1
  %tmp_506 = fmul float %tmp_503, %tmp_505
  %tmp_507 = call float @llvm.fmuladd.f32(float %tmp_499, float %tmp_501, float %tmp_506)
  %tmp_508 = load <4 x float>* %tempA3, align 16
  %tmp_509 = extractelement <4 x float> %tmp_508, i32 2
  %tmp_510 = load <4 x float>* %tempB2, align 16
  %tmp_511 = extractelement <4 x float> %tmp_510, i32 1
  %tmp_512 = call float @llvm.fmuladd.f32(float %tmp_509, float %tmp_511, float %tmp_507)
  %tmp_513 = load <4 x float>* %tempA3, align 16
  %tmp_514 = extractelement <4 x float> %tmp_513, i32 3
  %tmp_515 = load <4 x float>* %tempB3, align 16
  %tmp_516 = extractelement <4 x float> %tmp_515, i32 1
  %tmp_517 = call float @llvm.fmuladd.f32(float %tmp_514, float %tmp_516, float %tmp_512)
  %tmp_518 = load <4 x float>* %sum3, align 16
  %tmp_519 = extractelement <4 x float> %tmp_518, i32 1
  %tmp_520 = fadd float %tmp_519, %tmp_517
  %tmp_521 = load <4 x float>* %sum3, align 16
  %tmp_522 = insertelement <4 x float> %tmp_521, float %tmp_520, i32 1
  store <4 x float> %tmp_522, <4 x float>* %sum3, align 16
  %tmp_523 = load <4 x float>* %tempA3, align 16
  %tmp_524 = extractelement <4 x float> %tmp_523, i32 0
  %tmp_525 = load <4 x float>* %tempB0, align 16
  %tmp_526 = extractelement <4 x float> %tmp_525, i32 2
  %tmp_527 = load <4 x float>* %tempA3, align 16
  %tmp_528 = extractelement <4 x float> %tmp_527, i32 1
  %tmp_529 = load <4 x float>* %tempB1, align 16
  %tmp_530 = extractelement <4 x float> %tmp_529, i32 2
  %tmp_531 = fmul float %tmp_528, %tmp_530
  %tmp_532 = call float @llvm.fmuladd.f32(float %tmp_524, float %tmp_526, float %tmp_531)
  %tmp_533 = load <4 x float>* %tempA3, align 16
  %tmp_534 = extractelement <4 x float> %tmp_533, i32 2
  %tmp_535 = load <4 x float>* %tempB2, align 16
  %tmp_536 = extractelement <4 x float> %tmp_535, i32 2
  %tmp_537 = call float @llvm.fmuladd.f32(float %tmp_534, float %tmp_536, float %tmp_532)
  %tmp_538 = load <4 x float>* %tempA3, align 16
  %tmp_539 = extractelement <4 x float> %tmp_538, i32 3
  %tmp_540 = load <4 x float>* %tempB3, align 16
  %tmp_541 = extractelement <4 x float> %tmp_540, i32 2
  %tmp_542 = call float @llvm.fmuladd.f32(float %tmp_539, float %tmp_541, float %tmp_537)
  %tmp_543 = load <4 x float>* %sum3, align 16
  %tmp_544 = extractelement <4 x float> %tmp_543, i32 2
  %tmp_545 = fadd float %tmp_544, %tmp_542
  %tmp_546 = load <4 x float>* %sum3, align 16
  %tmp_547 = insertelement <4 x float> %tmp_546, float %tmp_545, i32 2
  store <4 x float> %tmp_547, <4 x float>* %sum3, align 16
  %tmp_548 = load <4 x float>* %tempA3, align 16
  %tmp_549 = extractelement <4 x float> %tmp_548, i32 0
  %tmp_550 = load <4 x float>* %tempB0, align 16
  %tmp_551 = extractelement <4 x float> %tmp_550, i32 3
  %tmp_552 = load <4 x float>* %tempA3, align 16
  %tmp_553 = extractelement <4 x float> %tmp_552, i32 1
  %tmp_554 = load <4 x float>* %tempB1, align 16
  %tmp_555 = extractelement <4 x float> %tmp_554, i32 3
  %tmp_556 = fmul float %tmp_553, %tmp_555
  %tmp_557 = call float @llvm.fmuladd.f32(float %tmp_549, float %tmp_551, float %tmp_556)
  %tmp_558 = load <4 x float>* %tempA3, align 16
  %tmp_559 = extractelement <4 x float> %tmp_558, i32 2
  %tmp_560 = load <4 x float>* %tempB2, align 16
  %tmp_561 = extractelement <4 x float> %tmp_560, i32 3
  %tmp_562 = call float @llvm.fmuladd.f32(float %tmp_559, float %tmp_561, float %tmp_557)
  %tmp_563 = load <4 x float>* %tempA3, align 16
  %tmp_564 = extractelement <4 x float> %tmp_563, i32 3
  %tmp_565 = load <4 x float>* %tempB3, align 16
  %tmp_566 = extractelement <4 x float> %tmp_565, i32 3
  %tmp_567 = call float @llvm.fmuladd.f32(float %tmp_564, float %tmp_566, float %tmp_562)
  %tmp_568 = load <4 x float>* %sum3, align 16
  %tmp_569 = extractelement <4 x float> %tmp_568, i32 3
  %tmp_570 = fadd float %tmp_569, %tmp_567
  %tmp_571 = load <4 x float>* %sum3, align 16
  %tmp_572 = insertelement <4 x float> %tmp_571, float %tmp_570, i32 3
  store <4 x float> %tmp_572, <4 x float>* %sum3, align 16
  br label %tmp_573

tmp_573:                                     ; preds = %tmp_94
  %tmp_574 = load i32* %j, align 4
  %tmp_575 = add nsw i32 %tmp_574, 4
  store i32 %tmp_575, i32* %j, align 4
  br label %tmp_89

tmp_576:                                     ; preds = %tmp_89
  call void @barrier(i32 1)
  br label %tmp_577

tmp_577:                                     ; preds = %tmp_576
  %tmp_578 = load i32* %i, align 4
  %tmp_579 = add nsw i32 %tmp_578, 1
  store i32 %tmp_579, i32* %i, align 4
  br label %tmp_20

tmp_580:                                     ; preds = %tmp_20
  %tmp_581 = load <4 x float>* %sum0, align 16
  %tmp_582 = load i32* %globalPos, align 4
  %tmp_583 = load <4 x float> addrspace(1)** %tmp_3, align 4
  %tmp_584 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_583, i32 %tmp_582
  store <4 x float> %tmp_581, <4 x float> addrspace(1)* %tmp_584, align 16
  %tmp_585 = load <4 x float>* %sum1, align 16
  %tmp_586 = load i32* %globalPos, align 4
  %tmp_587 = call i32 @__get_global_size_u32(i32 0)
  %tmp_588 = add i32 %tmp_586, %tmp_587
  %tmp_589 = load <4 x float> addrspace(1)** %tmp_3, align 4
  %tmp_590 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_589, i32 %tmp_588
  store <4 x float> %tmp_585, <4 x float> addrspace(1)* %tmp_590, align 16
  %tmp_591 = load <4 x float>* %sum2, align 16
  %tmp_592 = load i32* %globalPos, align 4
  %tmp_593 = call i32 @__get_global_size_u32(i32 0)
  %tmp_594 = mul i32 2, %tmp_593
  %tmp_595 = add i32 %tmp_592, %tmp_594
  %tmp_596 = load <4 x float> addrspace(1)** %tmp_3, align 4
  %tmp_597 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_596, i32 %tmp_595
  store <4 x float> %tmp_591, <4 x float> addrspace(1)* %tmp_597, align 16
  %tmp_598 = load <4 x float>* %sum3, align 16
  %tmp_599 = load i32* %globalPos, align 4
  %tmp_600 = call i32 @__get_global_size_u32(i32 0)
  %tmp_601 = mul i32 3, %tmp_600
  %tmp_602 = add i32 %tmp_599, %tmp_601
  %tmp_603 = load <4 x float> addrspace(1)** %tmp_3, align 4
  %tmp_604 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_603, i32 %tmp_602
  store <4 x float> %tmp_598, <4 x float> addrspace(1)* %tmp_604, align 16
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, i32)* @mmmKernel}
!1 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, <4 x float> addrspace(3)*)* @mmmKernel_local}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

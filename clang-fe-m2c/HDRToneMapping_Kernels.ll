; ModuleID = '../kernel-src/HDRToneMapping_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define float @luminance(float %r, float %g, float %b) #0 {
  %tmp_1 = alloca float, align 4
  %tmp_2 = alloca float, align 4
  %tmp_3 = alloca float, align 4
  store float %r, float* %tmp_1, align 4
  store float %g, float* %tmp_2, align 4
  store float %b, float* %tmp_3, align 4
  %tmp_4 = load float* %tmp_1, align 4
  %tmp_5 = load float* %tmp_2, align 4
  %tmp_6 = fmul float 0x3FE6E2EB20000000, %tmp_5
  %tmp_7 = call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %tmp_4, float %tmp_6)
  %tmp_8 = load float* %tmp_3, align 4
  %tmp_9 = call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %tmp_8, float %tmp_7)
  ret float %tmp_9
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind
define void @toneMappingPattanaik1(float addrspace(1)* %input, float addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca float addrspace(1)*, align 4
  %tmp_3 = alloca float, align 4
  %tmp_4 = alloca float, align 4
  %tmp_5 = alloca float, align 4
  %tmp_6 = alloca float, align 4
  %tmp_7 = alloca i32, align 4
  %tmp_8 = alloca i32, align 4
  %tmp_9 = alloca i32, align 4
  %globalIdX = alloca i32, align 4
  %globalIdY = alloca i32, align 4
  %r = alloca float, align 4
  %r1 = alloca float, align 4
  %g = alloca float, align 4
  %g1 = alloca float, align 4
  %b = alloca float, align 4
  %b1 = alloca float, align 4
  %yLuminance = alloca float, align 4
  %cLPattanaik = alloca float, align 4
  %yLPattanaik = alloca float, align 4
  %gcPattanaik = alloca float, align 4
  %leftUp = alloca float, align 4
  %up = alloca float, align 4
  %rightUp = alloca float, align 4
  %left = alloca float, align 4
  %right = alloca float, align 4
  %leftDown = alloca float, align 4
  %down = alloca float, align 4
  %rightDown = alloca float, align 4
  %yDPattanaik = alloca float, align 4
  store float addrspace(1)* %input, float addrspace(1)** %tmp_1, align 4
  store float addrspace(1)* %output, float addrspace(1)** %tmp_2, align 4
  store float %averageLuminance, float* %tmp_3, align 4
  store float %gamma, float* %tmp_4, align 4
  store float %c, float* %tmp_5, align 4
  store float %delta, float* %tmp_6, align 4
  store i32 %width, i32* %tmp_7, align 4
  store i32 %numChannels, i32* %tmp_8, align 4
  store i32 %height, i32* %tmp_9, align 4
  %tmp_10 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_10, i32* %globalIdX, align 4
  %tmp_11 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_11, i32* %globalIdY, align 4
  store float 0.000000e+00, float* %yLuminance, align 4
  store float 0.000000e+00, float* %cLPattanaik, align 4
  store float 0.000000e+00, float* %yLPattanaik, align 4
  %tmp_12 = load i32* %tmp_7, align 4
  %tmp_13 = load i32* %tmp_8, align 4
  %tmp_14 = mul i32 %tmp_12, %tmp_13
  %tmp_15 = load i32* %globalIdY, align 4
  %tmp_16 = mul i32 %tmp_14, %tmp_15
  %tmp_17 = load i32* %globalIdX, align 4
  %tmp_18 = load i32* %tmp_8, align 4
  %tmp_19 = mul i32 %tmp_17, %tmp_18
  %tmp_20 = add i32 %tmp_19, 0
  %tmp_21 = add i32 %tmp_16, %tmp_20
  %tmp_22 = load float addrspace(1)** %tmp_1, align 4
  %tmp_23 = getelementptr inbounds float addrspace(1)* %tmp_22, i32 %tmp_21
  %tmp_24 = load float addrspace(1)* %tmp_23, align 4
  store float %tmp_24, float* %r1, align 4
  %tmp_25 = load i32* %tmp_7, align 4
  %tmp_26 = load i32* %tmp_8, align 4
  %tmp_27 = mul i32 %tmp_25, %tmp_26
  %tmp_28 = load i32* %globalIdY, align 4
  %tmp_29 = mul i32 %tmp_27, %tmp_28
  %tmp_30 = load i32* %globalIdX, align 4
  %tmp_31 = load i32* %tmp_8, align 4
  %tmp_32 = mul i32 %tmp_30, %tmp_31
  %tmp_33 = add i32 %tmp_32, 1
  %tmp_34 = add i32 %tmp_29, %tmp_33
  %tmp_35 = load float addrspace(1)** %tmp_1, align 4
  %tmp_36 = getelementptr inbounds float addrspace(1)* %tmp_35, i32 %tmp_34
  %tmp_37 = load float addrspace(1)* %tmp_36, align 4
  store float %tmp_37, float* %g1, align 4
  %tmp_38 = load i32* %tmp_7, align 4
  %tmp_39 = load i32* %tmp_8, align 4
  %tmp_40 = mul i32 %tmp_38, %tmp_39
  %tmp_41 = load i32* %globalIdY, align 4
  %tmp_42 = mul i32 %tmp_40, %tmp_41
  %tmp_43 = load i32* %globalIdX, align 4
  %tmp_44 = load i32* %tmp_8, align 4
  %tmp_45 = mul i32 %tmp_43, %tmp_44
  %tmp_46 = add i32 %tmp_45, 2
  %tmp_47 = add i32 %tmp_42, %tmp_46
  %tmp_48 = load float addrspace(1)** %tmp_1, align 4
  %tmp_49 = getelementptr inbounds float addrspace(1)* %tmp_48, i32 %tmp_47
  %tmp_50 = load float addrspace(1)* %tmp_49, align 4
  store float %tmp_50, float* %b1, align 4
  %tmp_51 = load float* %r1, align 4
  %tmp_52 = load float* %g1, align 4
  %tmp_53 = load float* %b1, align 4
  %tmp_54 = call float @luminance(float %tmp_51, float %tmp_52, float %tmp_53)
  store float %tmp_54, float* %yLuminance, align 4
  %tmp_55 = load float* %tmp_5, align 4
  %tmp_56 = load float* %tmp_3, align 4
  %tmp_57 = fmul float %tmp_55, %tmp_56
  store float %tmp_57, float* %gcPattanaik, align 4
  %tmp_58 = load i32* %globalIdX, align 4
  %tmp_59 = icmp ne i32 %tmp_58, 0
  br i1 %tmp_59, label %tmp_60, label %tmp_470

tmp_60:                                      ; preds = %tmp_0
  %tmp_61 = load i32* %globalIdY, align 4
  %tmp_62 = icmp ne i32 %tmp_61, 0
  br i1 %tmp_62, label %tmp_63, label %tmp_470

tmp_63:                                      ; preds = %tmp_60
  %tmp_64 = load i32* %globalIdX, align 4
  %tmp_65 = load i32* %tmp_7, align 4
  %tmp_66 = sub i32 %tmp_65, 1
  %tmp_67 = icmp ne i32 %tmp_64, %tmp_66
  br i1 %tmp_67, label %tmp_68, label %tmp_470

tmp_68:                                      ; preds = %tmp_63
  %tmp_69 = load i32* %globalIdY, align 4
  %tmp_70 = load i32* %tmp_9, align 4
  %tmp_71 = sub i32 %tmp_70, 1
  %tmp_72 = icmp ne i32 %tmp_69, %tmp_71
  br i1 %tmp_72, label %tmp_73, label %tmp_470

tmp_73:                                      ; preds = %tmp_68
  store float 0.000000e+00, float* %leftUp, align 4
  store float 0.000000e+00, float* %up, align 4
  store float 0.000000e+00, float* %rightUp, align 4
  store float 0.000000e+00, float* %left, align 4
  store float 0.000000e+00, float* %right, align 4
  store float 0.000000e+00, float* %leftDown, align 4
  store float 0.000000e+00, float* %down, align 4
  store float 0.000000e+00, float* %rightDown, align 4
  %tmp_74 = load i32* %tmp_7, align 4
  %tmp_75 = load i32* %tmp_8, align 4
  %tmp_76 = mul i32 %tmp_74, %tmp_75
  %tmp_77 = load i32* %globalIdY, align 4
  %tmp_78 = sub i32 %tmp_77, 1
  %tmp_79 = mul i32 %tmp_76, %tmp_78
  %tmp_80 = load i32* %globalIdX, align 4
  %tmp_81 = sub i32 %tmp_80, 1
  %tmp_82 = load i32* %tmp_8, align 4
  %tmp_83 = mul i32 %tmp_81, %tmp_82
  %tmp_84 = add i32 %tmp_79, %tmp_83
  %tmp_85 = add i32 %tmp_84, 0
  %tmp_86 = load float addrspace(1)** %tmp_1, align 4
  %tmp_87 = getelementptr inbounds float addrspace(1)* %tmp_86, i32 %tmp_85
  %tmp_88 = load float addrspace(1)* %tmp_87, align 4
  store float %tmp_88, float* %r, align 4
  %tmp_89 = load i32* %tmp_7, align 4
  %tmp_90 = load i32* %tmp_8, align 4
  %tmp_91 = mul i32 %tmp_89, %tmp_90
  %tmp_92 = load i32* %globalIdY, align 4
  %tmp_93 = sub i32 %tmp_92, 1
  %tmp_94 = mul i32 %tmp_91, %tmp_93
  %tmp_95 = load i32* %globalIdX, align 4
  %tmp_96 = sub i32 %tmp_95, 1
  %tmp_97 = load i32* %tmp_8, align 4
  %tmp_98 = mul i32 %tmp_96, %tmp_97
  %tmp_99 = add i32 %tmp_94, %tmp_98
  %tmp_100 = add i32 %tmp_99, 1
  %tmp_101 = load float addrspace(1)** %tmp_1, align 4
  %tmp_102 = getelementptr inbounds float addrspace(1)* %tmp_101, i32 %tmp_100
  %tmp_103 = load float addrspace(1)* %tmp_102, align 4
  store float %tmp_103, float* %g, align 4
  %tmp_104 = load i32* %tmp_7, align 4
  %tmp_105 = load i32* %tmp_8, align 4
  %tmp_106 = mul i32 %tmp_104, %tmp_105
  %tmp_107 = load i32* %globalIdY, align 4
  %tmp_108 = sub i32 %tmp_107, 1
  %tmp_109 = mul i32 %tmp_106, %tmp_108
  %tmp_110 = load i32* %globalIdX, align 4
  %tmp_111 = sub i32 %tmp_110, 1
  %tmp_112 = load i32* %tmp_8, align 4
  %tmp_113 = mul i32 %tmp_111, %tmp_112
  %tmp_114 = add i32 %tmp_109, %tmp_113
  %tmp_115 = add i32 %tmp_114, 2
  %tmp_116 = load float addrspace(1)** %tmp_1, align 4
  %tmp_117 = getelementptr inbounds float addrspace(1)* %tmp_116, i32 %tmp_115
  %tmp_118 = load float addrspace(1)* %tmp_117, align 4
  store float %tmp_118, float* %b, align 4
  %tmp_119 = load float* %r, align 4
  %tmp_120 = load float* %g, align 4
  %tmp_121 = load float* %b, align 4
  %tmp_122 = call float @luminance(float %tmp_119, float %tmp_120, float %tmp_121)
  store float %tmp_122, float* %leftUp, align 4
  %tmp_123 = load i32* %tmp_7, align 4
  %tmp_124 = load i32* %tmp_8, align 4
  %tmp_125 = mul i32 %tmp_123, %tmp_124
  %tmp_126 = load i32* %globalIdY, align 4
  %tmp_127 = sub i32 %tmp_126, 1
  %tmp_128 = mul i32 %tmp_125, %tmp_127
  %tmp_129 = load i32* %globalIdX, align 4
  %tmp_130 = load i32* %tmp_8, align 4
  %tmp_131 = mul i32 %tmp_129, %tmp_130
  %tmp_132 = add i32 %tmp_128, %tmp_131
  %tmp_133 = add i32 %tmp_132, 0
  %tmp_134 = load float addrspace(1)** %tmp_1, align 4
  %tmp_135 = getelementptr inbounds float addrspace(1)* %tmp_134, i32 %tmp_133
  %tmp_136 = load float addrspace(1)* %tmp_135, align 4
  store float %tmp_136, float* %r, align 4
  %tmp_137 = load i32* %tmp_7, align 4
  %tmp_138 = load i32* %tmp_8, align 4
  %tmp_139 = mul i32 %tmp_137, %tmp_138
  %tmp_140 = load i32* %globalIdY, align 4
  %tmp_141 = sub i32 %tmp_140, 1
  %tmp_142 = mul i32 %tmp_139, %tmp_141
  %tmp_143 = load i32* %globalIdX, align 4
  %tmp_144 = load i32* %tmp_8, align 4
  %tmp_145 = mul i32 %tmp_143, %tmp_144
  %tmp_146 = add i32 %tmp_142, %tmp_145
  %tmp_147 = add i32 %tmp_146, 1
  %tmp_148 = load float addrspace(1)** %tmp_1, align 4
  %tmp_149 = getelementptr inbounds float addrspace(1)* %tmp_148, i32 %tmp_147
  %tmp_150 = load float addrspace(1)* %tmp_149, align 4
  store float %tmp_150, float* %g, align 4
  %tmp_151 = load i32* %tmp_7, align 4
  %tmp_152 = load i32* %tmp_8, align 4
  %tmp_153 = mul i32 %tmp_151, %tmp_152
  %tmp_154 = load i32* %globalIdY, align 4
  %tmp_155 = sub i32 %tmp_154, 1
  %tmp_156 = mul i32 %tmp_153, %tmp_155
  %tmp_157 = load i32* %globalIdX, align 4
  %tmp_158 = load i32* %tmp_8, align 4
  %tmp_159 = mul i32 %tmp_157, %tmp_158
  %tmp_160 = add i32 %tmp_156, %tmp_159
  %tmp_161 = add i32 %tmp_160, 2
  %tmp_162 = load float addrspace(1)** %tmp_1, align 4
  %tmp_163 = getelementptr inbounds float addrspace(1)* %tmp_162, i32 %tmp_161
  %tmp_164 = load float addrspace(1)* %tmp_163, align 4
  store float %tmp_164, float* %b, align 4
  %tmp_165 = load float* %r, align 4
  %tmp_166 = load float* %g, align 4
  %tmp_167 = load float* %b, align 4
  %tmp_168 = call float @luminance(float %tmp_165, float %tmp_166, float %tmp_167)
  store float %tmp_168, float* %up, align 4
  %tmp_169 = load i32* %tmp_7, align 4
  %tmp_170 = load i32* %tmp_8, align 4
  %tmp_171 = mul i32 %tmp_169, %tmp_170
  %tmp_172 = load i32* %globalIdY, align 4
  %tmp_173 = sub i32 %tmp_172, 1
  %tmp_174 = mul i32 %tmp_171, %tmp_173
  %tmp_175 = load i32* %globalIdX, align 4
  %tmp_176 = add i32 %tmp_175, 1
  %tmp_177 = load i32* %tmp_8, align 4
  %tmp_178 = mul i32 %tmp_176, %tmp_177
  %tmp_179 = add i32 %tmp_174, %tmp_178
  %tmp_180 = add i32 %tmp_179, 0
  %tmp_181 = load float addrspace(1)** %tmp_1, align 4
  %tmp_182 = getelementptr inbounds float addrspace(1)* %tmp_181, i32 %tmp_180
  %tmp_183 = load float addrspace(1)* %tmp_182, align 4
  store float %tmp_183, float* %r, align 4
  %tmp_184 = load i32* %tmp_7, align 4
  %tmp_185 = load i32* %tmp_8, align 4
  %tmp_186 = mul i32 %tmp_184, %tmp_185
  %tmp_187 = load i32* %globalIdY, align 4
  %tmp_188 = sub i32 %tmp_187, 1
  %tmp_189 = mul i32 %tmp_186, %tmp_188
  %tmp_190 = load i32* %globalIdX, align 4
  %tmp_191 = add i32 %tmp_190, 1
  %tmp_192 = load i32* %tmp_8, align 4
  %tmp_193 = mul i32 %tmp_191, %tmp_192
  %tmp_194 = add i32 %tmp_189, %tmp_193
  %tmp_195 = add i32 %tmp_194, 1
  %tmp_196 = load float addrspace(1)** %tmp_1, align 4
  %tmp_197 = getelementptr inbounds float addrspace(1)* %tmp_196, i32 %tmp_195
  %tmp_198 = load float addrspace(1)* %tmp_197, align 4
  store float %tmp_198, float* %g, align 4
  %tmp_199 = load i32* %tmp_7, align 4
  %tmp_200 = load i32* %tmp_8, align 4
  %tmp_201 = mul i32 %tmp_199, %tmp_200
  %tmp_202 = load i32* %globalIdY, align 4
  %tmp_203 = sub i32 %tmp_202, 1
  %tmp_204 = mul i32 %tmp_201, %tmp_203
  %tmp_205 = load i32* %globalIdX, align 4
  %tmp_206 = add i32 %tmp_205, 1
  %tmp_207 = load i32* %tmp_8, align 4
  %tmp_208 = mul i32 %tmp_206, %tmp_207
  %tmp_209 = add i32 %tmp_204, %tmp_208
  %tmp_210 = add i32 %tmp_209, 2
  %tmp_211 = load float addrspace(1)** %tmp_1, align 4
  %tmp_212 = getelementptr inbounds float addrspace(1)* %tmp_211, i32 %tmp_210
  %tmp_213 = load float addrspace(1)* %tmp_212, align 4
  store float %tmp_213, float* %b, align 4
  %tmp_214 = load float* %r, align 4
  %tmp_215 = load float* %g, align 4
  %tmp_216 = load float* %b, align 4
  %tmp_217 = call float @luminance(float %tmp_214, float %tmp_215, float %tmp_216)
  store float %tmp_217, float* %rightUp, align 4
  %tmp_218 = load i32* %tmp_7, align 4
  %tmp_219 = load i32* %tmp_8, align 4
  %tmp_220 = mul i32 %tmp_218, %tmp_219
  %tmp_221 = load i32* %globalIdY, align 4
  %tmp_222 = mul i32 %tmp_220, %tmp_221
  %tmp_223 = load i32* %globalIdX, align 4
  %tmp_224 = sub i32 %tmp_223, 1
  %tmp_225 = load i32* %tmp_8, align 4
  %tmp_226 = mul i32 %tmp_224, %tmp_225
  %tmp_227 = add i32 %tmp_222, %tmp_226
  %tmp_228 = add i32 %tmp_227, 0
  %tmp_229 = load float addrspace(1)** %tmp_1, align 4
  %tmp_230 = getelementptr inbounds float addrspace(1)* %tmp_229, i32 %tmp_228
  %tmp_231 = load float addrspace(1)* %tmp_230, align 4
  store float %tmp_231, float* %r, align 4
  %tmp_232 = load i32* %tmp_7, align 4
  %tmp_233 = load i32* %tmp_8, align 4
  %tmp_234 = mul i32 %tmp_232, %tmp_233
  %tmp_235 = load i32* %globalIdY, align 4
  %tmp_236 = mul i32 %tmp_234, %tmp_235
  %tmp_237 = load i32* %globalIdX, align 4
  %tmp_238 = sub i32 %tmp_237, 1
  %tmp_239 = load i32* %tmp_8, align 4
  %tmp_240 = mul i32 %tmp_238, %tmp_239
  %tmp_241 = add i32 %tmp_236, %tmp_240
  %tmp_242 = add i32 %tmp_241, 1
  %tmp_243 = load float addrspace(1)** %tmp_1, align 4
  %tmp_244 = getelementptr inbounds float addrspace(1)* %tmp_243, i32 %tmp_242
  %tmp_245 = load float addrspace(1)* %tmp_244, align 4
  store float %tmp_245, float* %g, align 4
  %tmp_246 = load i32* %tmp_7, align 4
  %tmp_247 = load i32* %tmp_8, align 4
  %tmp_248 = mul i32 %tmp_246, %tmp_247
  %tmp_249 = load i32* %globalIdY, align 4
  %tmp_250 = mul i32 %tmp_248, %tmp_249
  %tmp_251 = load i32* %globalIdX, align 4
  %tmp_252 = sub i32 %tmp_251, 1
  %tmp_253 = load i32* %tmp_8, align 4
  %tmp_254 = mul i32 %tmp_252, %tmp_253
  %tmp_255 = add i32 %tmp_250, %tmp_254
  %tmp_256 = add i32 %tmp_255, 2
  %tmp_257 = load float addrspace(1)** %tmp_1, align 4
  %tmp_258 = getelementptr inbounds float addrspace(1)* %tmp_257, i32 %tmp_256
  %tmp_259 = load float addrspace(1)* %tmp_258, align 4
  store float %tmp_259, float* %b, align 4
  %tmp_260 = load float* %r, align 4
  %tmp_261 = load float* %g, align 4
  %tmp_262 = load float* %b, align 4
  %tmp_263 = call float @luminance(float %tmp_260, float %tmp_261, float %tmp_262)
  store float %tmp_263, float* %left, align 4
  %tmp_264 = load i32* %tmp_7, align 4
  %tmp_265 = load i32* %tmp_8, align 4
  %tmp_266 = mul i32 %tmp_264, %tmp_265
  %tmp_267 = load i32* %globalIdY, align 4
  %tmp_268 = mul i32 %tmp_266, %tmp_267
  %tmp_269 = load i32* %globalIdX, align 4
  %tmp_270 = add i32 %tmp_269, 1
  %tmp_271 = load i32* %tmp_8, align 4
  %tmp_272 = mul i32 %tmp_270, %tmp_271
  %tmp_273 = add i32 %tmp_268, %tmp_272
  %tmp_274 = add i32 %tmp_273, 0
  %tmp_275 = load float addrspace(1)** %tmp_1, align 4
  %tmp_276 = getelementptr inbounds float addrspace(1)* %tmp_275, i32 %tmp_274
  %tmp_277 = load float addrspace(1)* %tmp_276, align 4
  store float %tmp_277, float* %r, align 4
  %tmp_278 = load i32* %tmp_7, align 4
  %tmp_279 = load i32* %tmp_8, align 4
  %tmp_280 = mul i32 %tmp_278, %tmp_279
  %tmp_281 = load i32* %globalIdY, align 4
  %tmp_282 = mul i32 %tmp_280, %tmp_281
  %tmp_283 = load i32* %globalIdX, align 4
  %tmp_284 = add i32 %tmp_283, 1
  %tmp_285 = load i32* %tmp_8, align 4
  %tmp_286 = mul i32 %tmp_284, %tmp_285
  %tmp_287 = add i32 %tmp_282, %tmp_286
  %tmp_288 = add i32 %tmp_287, 1
  %tmp_289 = load float addrspace(1)** %tmp_1, align 4
  %tmp_290 = getelementptr inbounds float addrspace(1)* %tmp_289, i32 %tmp_288
  %tmp_291 = load float addrspace(1)* %tmp_290, align 4
  store float %tmp_291, float* %g, align 4
  %tmp_292 = load i32* %tmp_7, align 4
  %tmp_293 = load i32* %tmp_8, align 4
  %tmp_294 = mul i32 %tmp_292, %tmp_293
  %tmp_295 = load i32* %globalIdY, align 4
  %tmp_296 = mul i32 %tmp_294, %tmp_295
  %tmp_297 = load i32* %globalIdX, align 4
  %tmp_298 = add i32 %tmp_297, 1
  %tmp_299 = load i32* %tmp_8, align 4
  %tmp_300 = mul i32 %tmp_298, %tmp_299
  %tmp_301 = add i32 %tmp_296, %tmp_300
  %tmp_302 = add i32 %tmp_301, 2
  %tmp_303 = load float addrspace(1)** %tmp_1, align 4
  %tmp_304 = getelementptr inbounds float addrspace(1)* %tmp_303, i32 %tmp_302
  %tmp_305 = load float addrspace(1)* %tmp_304, align 4
  store float %tmp_305, float* %b, align 4
  %tmp_306 = load float* %r, align 4
  %tmp_307 = load float* %g, align 4
  %tmp_308 = load float* %b, align 4
  %tmp_309 = call float @luminance(float %tmp_306, float %tmp_307, float %tmp_308)
  store float %tmp_309, float* %right, align 4
  %tmp_310 = load i32* %tmp_7, align 4
  %tmp_311 = load i32* %tmp_8, align 4
  %tmp_312 = mul i32 %tmp_310, %tmp_311
  %tmp_313 = load i32* %globalIdY, align 4
  %tmp_314 = add i32 %tmp_313, 1
  %tmp_315 = mul i32 %tmp_312, %tmp_314
  %tmp_316 = load i32* %globalIdX, align 4
  %tmp_317 = sub i32 %tmp_316, 1
  %tmp_318 = load i32* %tmp_8, align 4
  %tmp_319 = mul i32 %tmp_317, %tmp_318
  %tmp_320 = add i32 %tmp_315, %tmp_319
  %tmp_321 = add i32 %tmp_320, 0
  %tmp_322 = load float addrspace(1)** %tmp_1, align 4
  %tmp_323 = getelementptr inbounds float addrspace(1)* %tmp_322, i32 %tmp_321
  %tmp_324 = load float addrspace(1)* %tmp_323, align 4
  store float %tmp_324, float* %r, align 4
  %tmp_325 = load i32* %tmp_7, align 4
  %tmp_326 = load i32* %tmp_8, align 4
  %tmp_327 = mul i32 %tmp_325, %tmp_326
  %tmp_328 = load i32* %globalIdY, align 4
  %tmp_329 = add i32 %tmp_328, 1
  %tmp_330 = mul i32 %tmp_327, %tmp_329
  %tmp_331 = load i32* %globalIdX, align 4
  %tmp_332 = sub i32 %tmp_331, 1
  %tmp_333 = load i32* %tmp_8, align 4
  %tmp_334 = mul i32 %tmp_332, %tmp_333
  %tmp_335 = add i32 %tmp_330, %tmp_334
  %tmp_336 = add i32 %tmp_335, 1
  %tmp_337 = load float addrspace(1)** %tmp_1, align 4
  %tmp_338 = getelementptr inbounds float addrspace(1)* %tmp_337, i32 %tmp_336
  %tmp_339 = load float addrspace(1)* %tmp_338, align 4
  store float %tmp_339, float* %g, align 4
  %tmp_340 = load i32* %tmp_7, align 4
  %tmp_341 = load i32* %tmp_8, align 4
  %tmp_342 = mul i32 %tmp_340, %tmp_341
  %tmp_343 = load i32* %globalIdY, align 4
  %tmp_344 = add i32 %tmp_343, 1
  %tmp_345 = mul i32 %tmp_342, %tmp_344
  %tmp_346 = load i32* %globalIdX, align 4
  %tmp_347 = sub i32 %tmp_346, 1
  %tmp_348 = load i32* %tmp_8, align 4
  %tmp_349 = mul i32 %tmp_347, %tmp_348
  %tmp_350 = add i32 %tmp_345, %tmp_349
  %tmp_351 = add i32 %tmp_350, 2
  %tmp_352 = load float addrspace(1)** %tmp_1, align 4
  %tmp_353 = getelementptr inbounds float addrspace(1)* %tmp_352, i32 %tmp_351
  %tmp_354 = load float addrspace(1)* %tmp_353, align 4
  store float %tmp_354, float* %b, align 4
  %tmp_355 = load float* %r, align 4
  %tmp_356 = load float* %g, align 4
  %tmp_357 = load float* %b, align 4
  %tmp_358 = call float @luminance(float %tmp_355, float %tmp_356, float %tmp_357)
  store float %tmp_358, float* %leftDown, align 4
  %tmp_359 = load i32* %tmp_7, align 4
  %tmp_360 = load i32* %tmp_8, align 4
  %tmp_361 = mul i32 %tmp_359, %tmp_360
  %tmp_362 = load i32* %globalIdY, align 4
  %tmp_363 = add i32 %tmp_362, 1
  %tmp_364 = mul i32 %tmp_361, %tmp_363
  %tmp_365 = load i32* %globalIdX, align 4
  %tmp_366 = load i32* %tmp_8, align 4
  %tmp_367 = mul i32 %tmp_365, %tmp_366
  %tmp_368 = add i32 %tmp_364, %tmp_367
  %tmp_369 = add i32 %tmp_368, 0
  %tmp_370 = load float addrspace(1)** %tmp_1, align 4
  %tmp_371 = getelementptr inbounds float addrspace(1)* %tmp_370, i32 %tmp_369
  %tmp_372 = load float addrspace(1)* %tmp_371, align 4
  store float %tmp_372, float* %r, align 4
  %tmp_373 = load i32* %tmp_7, align 4
  %tmp_374 = load i32* %tmp_8, align 4
  %tmp_375 = mul i32 %tmp_373, %tmp_374
  %tmp_376 = load i32* %globalIdY, align 4
  %tmp_377 = add i32 %tmp_376, 1
  %tmp_378 = mul i32 %tmp_375, %tmp_377
  %tmp_379 = load i32* %globalIdX, align 4
  %tmp_380 = load i32* %tmp_8, align 4
  %tmp_381 = mul i32 %tmp_379, %tmp_380
  %tmp_382 = add i32 %tmp_378, %tmp_381
  %tmp_383 = add i32 %tmp_382, 1
  %tmp_384 = load float addrspace(1)** %tmp_1, align 4
  %tmp_385 = getelementptr inbounds float addrspace(1)* %tmp_384, i32 %tmp_383
  %tmp_386 = load float addrspace(1)* %tmp_385, align 4
  store float %tmp_386, float* %g, align 4
  %tmp_387 = load i32* %tmp_7, align 4
  %tmp_388 = load i32* %tmp_8, align 4
  %tmp_389 = mul i32 %tmp_387, %tmp_388
  %tmp_390 = load i32* %globalIdY, align 4
  %tmp_391 = add i32 %tmp_390, 1
  %tmp_392 = mul i32 %tmp_389, %tmp_391
  %tmp_393 = load i32* %globalIdX, align 4
  %tmp_394 = load i32* %tmp_8, align 4
  %tmp_395 = mul i32 %tmp_393, %tmp_394
  %tmp_396 = add i32 %tmp_392, %tmp_395
  %tmp_397 = add i32 %tmp_396, 2
  %tmp_398 = load float addrspace(1)** %tmp_1, align 4
  %tmp_399 = getelementptr inbounds float addrspace(1)* %tmp_398, i32 %tmp_397
  %tmp_400 = load float addrspace(1)* %tmp_399, align 4
  store float %tmp_400, float* %b, align 4
  %tmp_401 = load float* %r, align 4
  %tmp_402 = load float* %g, align 4
  %tmp_403 = load float* %b, align 4
  %tmp_404 = call float @luminance(float %tmp_401, float %tmp_402, float %tmp_403)
  store float %tmp_404, float* %down, align 4
  %tmp_405 = load i32* %tmp_7, align 4
  %tmp_406 = load i32* %tmp_8, align 4
  %tmp_407 = mul i32 %tmp_405, %tmp_406
  %tmp_408 = load i32* %globalIdY, align 4
  %tmp_409 = add i32 %tmp_408, 1
  %tmp_410 = mul i32 %tmp_407, %tmp_409
  %tmp_411 = load i32* %globalIdX, align 4
  %tmp_412 = add i32 %tmp_411, 1
  %tmp_413 = load i32* %tmp_8, align 4
  %tmp_414 = mul i32 %tmp_412, %tmp_413
  %tmp_415 = add i32 %tmp_410, %tmp_414
  %tmp_416 = add i32 %tmp_415, 0
  %tmp_417 = load float addrspace(1)** %tmp_1, align 4
  %tmp_418 = getelementptr inbounds float addrspace(1)* %tmp_417, i32 %tmp_416
  %tmp_419 = load float addrspace(1)* %tmp_418, align 4
  store float %tmp_419, float* %r, align 4
  %tmp_420 = load i32* %tmp_7, align 4
  %tmp_421 = load i32* %tmp_8, align 4
  %tmp_422 = mul i32 %tmp_420, %tmp_421
  %tmp_423 = load i32* %globalIdY, align 4
  %tmp_424 = add i32 %tmp_423, 1
  %tmp_425 = mul i32 %tmp_422, %tmp_424
  %tmp_426 = load i32* %globalIdX, align 4
  %tmp_427 = add i32 %tmp_426, 1
  %tmp_428 = load i32* %tmp_8, align 4
  %tmp_429 = mul i32 %tmp_427, %tmp_428
  %tmp_430 = add i32 %tmp_425, %tmp_429
  %tmp_431 = add i32 %tmp_430, 1
  %tmp_432 = load float addrspace(1)** %tmp_1, align 4
  %tmp_433 = getelementptr inbounds float addrspace(1)* %tmp_432, i32 %tmp_431
  %tmp_434 = load float addrspace(1)* %tmp_433, align 4
  store float %tmp_434, float* %g, align 4
  %tmp_435 = load i32* %tmp_7, align 4
  %tmp_436 = load i32* %tmp_8, align 4
  %tmp_437 = mul i32 %tmp_435, %tmp_436
  %tmp_438 = load i32* %globalIdY, align 4
  %tmp_439 = add i32 %tmp_438, 1
  %tmp_440 = mul i32 %tmp_437, %tmp_439
  %tmp_441 = load i32* %globalIdX, align 4
  %tmp_442 = add i32 %tmp_441, 1
  %tmp_443 = load i32* %tmp_8, align 4
  %tmp_444 = mul i32 %tmp_442, %tmp_443
  %tmp_445 = add i32 %tmp_440, %tmp_444
  %tmp_446 = add i32 %tmp_445, 2
  %tmp_447 = load float addrspace(1)** %tmp_1, align 4
  %tmp_448 = getelementptr inbounds float addrspace(1)* %tmp_447, i32 %tmp_446
  %tmp_449 = load float addrspace(1)* %tmp_448, align 4
  store float %tmp_449, float* %b, align 4
  %tmp_450 = load float* %r, align 4
  %tmp_451 = load float* %g, align 4
  %tmp_452 = load float* %b, align 4
  %tmp_453 = call float @luminance(float %tmp_450, float %tmp_451, float %tmp_452)
  store float %tmp_453, float* %rightDown, align 4
  %tmp_454 = load float* %leftUp, align 4
  %tmp_455 = load float* %up, align 4
  %tmp_456 = fadd float %tmp_454, %tmp_455
  %tmp_457 = load float* %rightUp, align 4
  %tmp_458 = fadd float %tmp_456, %tmp_457
  %tmp_459 = load float* %left, align 4
  %tmp_460 = fadd float %tmp_458, %tmp_459
  %tmp_461 = load float* %right, align 4
  %tmp_462 = fadd float %tmp_460, %tmp_461
  %tmp_463 = load float* %leftDown, align 4
  %tmp_464 = fadd float %tmp_462, %tmp_463
  %tmp_465 = load float* %down, align 4
  %tmp_466 = fadd float %tmp_464, %tmp_465
  %tmp_467 = load float* %rightDown, align 4
  %tmp_468 = fadd float %tmp_466, %tmp_467
  %tmp_469 = fdiv float %tmp_468, 8.000000e+00, !fpmath !3
  store float %tmp_469, float* %yLPattanaik, align 4
  br label %tmp_472

tmp_470:                                     ; preds = %tmp_68, %tmp_63, %tmp_60, %tmp_0
  %tmp_471 = load float* %yLuminance, align 4
  store float %tmp_471, float* %yLPattanaik, align 4
  br label %tmp_472

tmp_472:                                     ; preds = %tmp_470, %tmp_73
  %tmp_473 = load float* %yLPattanaik, align 4
  %tmp_474 = load float* %tmp_6, align 4
  %tmp_475 = load float* %yLPattanaik, align 4
  %tmp_476 = load float* %yLuminance, align 4
  %tmp_477 = fdiv float %tmp_475, %tmp_476, !fpmath !3
  %tmp_478 = fadd float %tmp_474, %tmp_477
  %tmp_479 = call float @llvm.log2.f32(float %tmp_478)
  %tmp_480 = fmul float %tmp_479, 0x3FE62E4300000000
  %tmp_481 = load float* %gcPattanaik, align 4
  %tmp_482 = call float @llvm.fmuladd.f32(float %tmp_473, float %tmp_480, float %tmp_481)
  store float %tmp_482, float* %cLPattanaik, align 4
  %tmp_483 = load float* %yLuminance, align 4
  %tmp_484 = load float* %yLuminance, align 4
  %tmp_485 = load float* %cLPattanaik, align 4
  %tmp_486 = fadd float %tmp_484, %tmp_485
  %tmp_487 = fdiv float %tmp_483, %tmp_486, !fpmath !3
  store float %tmp_487, float* %yDPattanaik, align 4
  %tmp_488 = load float* %r1, align 4
  %tmp_489 = load float* %yLuminance, align 4
  %tmp_490 = fdiv float %tmp_488, %tmp_489, !fpmath !3
  %tmp_491 = load float* %tmp_4, align 4
  %tmp_492 = call float @llvm.pow.f32(float %tmp_490, float %tmp_491)
  %tmp_493 = load float* %yDPattanaik, align 4
  %tmp_494 = fmul float %tmp_492, %tmp_493
  store float %tmp_494, float* %r, align 4
  %tmp_495 = load float* %g1, align 4
  %tmp_496 = load float* %yLuminance, align 4
  %tmp_497 = fdiv float %tmp_495, %tmp_496, !fpmath !3
  %tmp_498 = load float* %tmp_4, align 4
  %tmp_499 = call float @llvm.pow.f32(float %tmp_497, float %tmp_498)
  %tmp_500 = load float* %yDPattanaik, align 4
  %tmp_501 = fmul float %tmp_499, %tmp_500
  store float %tmp_501, float* %g, align 4
  %tmp_502 = load float* %b1, align 4
  %tmp_503 = load float* %yLuminance, align 4
  %tmp_504 = fdiv float %tmp_502, %tmp_503, !fpmath !3
  %tmp_505 = load float* %tmp_4, align 4
  %tmp_506 = call float @llvm.pow.f32(float %tmp_504, float %tmp_505)
  %tmp_507 = load float* %yDPattanaik, align 4
  %tmp_508 = fmul float %tmp_506, %tmp_507
  store float %tmp_508, float* %b, align 4
  %tmp_509 = load float* %r, align 4
  %tmp_510 = load i32* %tmp_7, align 4
  %tmp_511 = load i32* %tmp_8, align 4
  %tmp_512 = mul i32 %tmp_510, %tmp_511
  %tmp_513 = load i32* %globalIdY, align 4
  %tmp_514 = mul i32 %tmp_512, %tmp_513
  %tmp_515 = load i32* %globalIdX, align 4
  %tmp_516 = load i32* %tmp_8, align 4
  %tmp_517 = mul i32 %tmp_515, %tmp_516
  %tmp_518 = add i32 %tmp_517, 0
  %tmp_519 = add i32 %tmp_514, %tmp_518
  %tmp_520 = load float addrspace(1)** %tmp_2, align 4
  %tmp_521 = getelementptr inbounds float addrspace(1)* %tmp_520, i32 %tmp_519
  store float %tmp_509, float addrspace(1)* %tmp_521, align 4
  %tmp_522 = load float* %g, align 4
  %tmp_523 = load i32* %tmp_7, align 4
  %tmp_524 = load i32* %tmp_8, align 4
  %tmp_525 = mul i32 %tmp_523, %tmp_524
  %tmp_526 = load i32* %globalIdY, align 4
  %tmp_527 = mul i32 %tmp_525, %tmp_526
  %tmp_528 = load i32* %globalIdX, align 4
  %tmp_529 = load i32* %tmp_8, align 4
  %tmp_530 = mul i32 %tmp_528, %tmp_529
  %tmp_531 = add i32 %tmp_530, 1
  %tmp_532 = add i32 %tmp_527, %tmp_531
  %tmp_533 = load float addrspace(1)** %tmp_2, align 4
  %tmp_534 = getelementptr inbounds float addrspace(1)* %tmp_533, i32 %tmp_532
  store float %tmp_522, float addrspace(1)* %tmp_534, align 4
  %tmp_535 = load float* %b, align 4
  %tmp_536 = load i32* %tmp_7, align 4
  %tmp_537 = load i32* %tmp_8, align 4
  %tmp_538 = mul i32 %tmp_536, %tmp_537
  %tmp_539 = load i32* %globalIdY, align 4
  %tmp_540 = mul i32 %tmp_538, %tmp_539
  %tmp_541 = load i32* %globalIdX, align 4
  %tmp_542 = load i32* %tmp_8, align 4
  %tmp_543 = mul i32 %tmp_541, %tmp_542
  %tmp_544 = add i32 %tmp_543, 2
  %tmp_545 = add i32 %tmp_540, %tmp_544
  %tmp_546 = load float addrspace(1)** %tmp_2, align 4
  %tmp_547 = getelementptr inbounds float addrspace(1)* %tmp_546, i32 %tmp_545
  store float %tmp_535, float addrspace(1)* %tmp_547, align 4
  %tmp_548 = load i32* %tmp_7, align 4
  %tmp_549 = load i32* %tmp_8, align 4
  %tmp_550 = mul i32 %tmp_548, %tmp_549
  %tmp_551 = load i32* %globalIdY, align 4
  %tmp_552 = mul i32 %tmp_550, %tmp_551
  %tmp_553 = load i32* %globalIdX, align 4
  %tmp_554 = load i32* %tmp_8, align 4
  %tmp_555 = mul i32 %tmp_553, %tmp_554
  %tmp_556 = add i32 %tmp_555, 3
  %tmp_557 = add i32 %tmp_552, %tmp_556
  %tmp_558 = load float addrspace(1)** %tmp_1, align 4
  %tmp_559 = getelementptr inbounds float addrspace(1)* %tmp_558, i32 %tmp_557
  %tmp_560 = load float addrspace(1)* %tmp_559, align 4
  %tmp_561 = load i32* %tmp_7, align 4
  %tmp_562 = load i32* %tmp_8, align 4
  %tmp_563 = mul i32 %tmp_561, %tmp_562
  %tmp_564 = load i32* %globalIdY, align 4
  %tmp_565 = mul i32 %tmp_563, %tmp_564
  %tmp_566 = load i32* %globalIdX, align 4
  %tmp_567 = load i32* %tmp_8, align 4
  %tmp_568 = mul i32 %tmp_566, %tmp_567
  %tmp_569 = add i32 %tmp_568, 3
  %tmp_570 = add i32 %tmp_565, %tmp_569
  %tmp_571 = load float addrspace(1)** %tmp_2, align 4
  %tmp_572 = getelementptr inbounds float addrspace(1)* %tmp_571, i32 %tmp_570
  store float %tmp_560, float addrspace(1)* %tmp_572, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #3

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #3

; Function Attrs: nounwind
define void @toneMappingPattanaik(<4 x float> addrspace(1)* %input, <4 x float> addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
  %tmp_1 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_3 = alloca float, align 4
  %tmp_4 = alloca float, align 4
  %tmp_5 = alloca float, align 4
  %tmp_6 = alloca float, align 4
  %tmp_7 = alloca i32, align 4
  %tmp_8 = alloca i32, align 4
  %tmp_9 = alloca i32, align 4
  %globalIdX = alloca i32, align 4
  %globalIdY = alloca i32, align 4
  %r = alloca float, align 4
  %r1 = alloca float, align 4
  %g = alloca float, align 4
  %g1 = alloca float, align 4
  %b = alloca float, align 4
  %b1 = alloca float, align 4
  %yLuminance = alloca float, align 4
  %cLPattanaik = alloca float, align 4
  %yLPattanaik = alloca float, align 4
  %gcPattanaik = alloca float, align 4
  %leftUp = alloca float, align 4
  %up = alloca float, align 4
  %rightUp = alloca float, align 4
  %left = alloca float, align 4
  %right = alloca float, align 4
  %leftDown = alloca float, align 4
  %down = alloca float, align 4
  %rightDown = alloca float, align 4
  %yDPattanaik = alloca float, align 4
  store <4 x float> addrspace(1)* %input, <4 x float> addrspace(1)** %tmp_1, align 4
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %tmp_2, align 4
  store float %averageLuminance, float* %tmp_3, align 4
  store float %gamma, float* %tmp_4, align 4
  store float %c, float* %tmp_5, align 4
  store float %delta, float* %tmp_6, align 4
  store i32 %width, i32* %tmp_7, align 4
  store i32 %numChannels, i32* %tmp_8, align 4
  store i32 %height, i32* %tmp_9, align 4
  %tmp_10 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_10, i32* %globalIdX, align 4
  %tmp_11 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_11, i32* %globalIdY, align 4
  store float 0.000000e+00, float* %yLuminance, align 4
  store float 0.000000e+00, float* %cLPattanaik, align 4
  store float 0.000000e+00, float* %yLPattanaik, align 4
  %tmp_12 = load i32* %tmp_7, align 4
  %tmp_13 = load i32* %globalIdY, align 4
  %tmp_14 = mul i32 %tmp_12, %tmp_13
  %tmp_15 = load i32* %globalIdX, align 4
  %tmp_16 = add i32 %tmp_14, %tmp_15
  %tmp_17 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_18 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_17, i32 %tmp_16
  %tmp_19 = load <4 x float> addrspace(1)* %tmp_18, align 16
  %tmp_20 = extractelement <4 x float> %tmp_19, i32 0
  store float %tmp_20, float* %r1, align 4
  %tmp_21 = load i32* %tmp_7, align 4
  %tmp_22 = load i32* %globalIdY, align 4
  %tmp_23 = mul i32 %tmp_21, %tmp_22
  %tmp_24 = load i32* %globalIdX, align 4
  %tmp_25 = add i32 %tmp_23, %tmp_24
  %tmp_26 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_27 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_26, i32 %tmp_25
  %tmp_28 = load <4 x float> addrspace(1)* %tmp_27, align 16
  %tmp_29 = extractelement <4 x float> %tmp_28, i32 1
  store float %tmp_29, float* %g1, align 4
  %tmp_30 = load i32* %tmp_7, align 4
  %tmp_31 = load i32* %globalIdY, align 4
  %tmp_32 = mul i32 %tmp_30, %tmp_31
  %tmp_33 = load i32* %globalIdX, align 4
  %tmp_34 = add i32 %tmp_32, %tmp_33
  %tmp_35 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_36 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_35, i32 %tmp_34
  %tmp_37 = load <4 x float> addrspace(1)* %tmp_36, align 16
  %tmp_38 = extractelement <4 x float> %tmp_37, i32 2
  store float %tmp_38, float* %b1, align 4
  %tmp_39 = load float* %r1, align 4
  %tmp_40 = load float* %g1, align 4
  %tmp_41 = load float* %b1, align 4
  %tmp_42 = call float @luminance(float %tmp_39, float %tmp_40, float %tmp_41)
  store float %tmp_42, float* %yLuminance, align 4
  %tmp_43 = load float* %tmp_5, align 4
  %tmp_44 = load float* %tmp_3, align 4
  %tmp_45 = fmul float %tmp_43, %tmp_44
  store float %tmp_45, float* %gcPattanaik, align 4
  %tmp_46 = load i32* %globalIdX, align 4
  %tmp_47 = icmp ne i32 %tmp_46, 0
  br i1 %tmp_47, label %tmp_48, label %tmp_362

tmp_48:                                      ; preds = %tmp_0
  %tmp_49 = load i32* %globalIdY, align 4
  %tmp_50 = icmp ne i32 %tmp_49, 0
  br i1 %tmp_50, label %tmp_51, label %tmp_362

tmp_51:                                      ; preds = %tmp_48
  %tmp_52 = load i32* %globalIdX, align 4
  %tmp_53 = load i32* %tmp_7, align 4
  %tmp_54 = sub i32 %tmp_53, 1
  %tmp_55 = icmp ne i32 %tmp_52, %tmp_54
  br i1 %tmp_55, label %tmp_56, label %tmp_362

tmp_56:                                      ; preds = %tmp_51
  %tmp_57 = load i32* %globalIdY, align 4
  %tmp_58 = load i32* %tmp_9, align 4
  %tmp_59 = sub i32 %tmp_58, 1
  %tmp_60 = icmp ne i32 %tmp_57, %tmp_59
  br i1 %tmp_60, label %tmp_61, label %tmp_362

tmp_61:                                      ; preds = %tmp_56
  store float 0.000000e+00, float* %leftUp, align 4
  store float 0.000000e+00, float* %up, align 4
  store float 0.000000e+00, float* %rightUp, align 4
  store float 0.000000e+00, float* %left, align 4
  store float 0.000000e+00, float* %right, align 4
  store float 0.000000e+00, float* %leftDown, align 4
  store float 0.000000e+00, float* %down, align 4
  store float 0.000000e+00, float* %rightDown, align 4
  %tmp_62 = load i32* %tmp_7, align 4
  %tmp_63 = load i32* %globalIdY, align 4
  %tmp_64 = sub i32 %tmp_63, 1
  %tmp_65 = mul i32 %tmp_62, %tmp_64
  %tmp_66 = load i32* %globalIdX, align 4
  %tmp_67 = add i32 %tmp_65, %tmp_66
  %tmp_68 = sub i32 %tmp_67, 1
  %tmp_69 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_70 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_69, i32 %tmp_68
  %tmp_71 = load <4 x float> addrspace(1)* %tmp_70, align 16
  %tmp_72 = extractelement <4 x float> %tmp_71, i32 0
  store float %tmp_72, float* %r, align 4
  %tmp_73 = load i32* %tmp_7, align 4
  %tmp_74 = load i32* %globalIdY, align 4
  %tmp_75 = sub i32 %tmp_74, 1
  %tmp_76 = mul i32 %tmp_73, %tmp_75
  %tmp_77 = load i32* %globalIdX, align 4
  %tmp_78 = add i32 %tmp_76, %tmp_77
  %tmp_79 = sub i32 %tmp_78, 1
  %tmp_80 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_81 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_80, i32 %tmp_79
  %tmp_82 = load <4 x float> addrspace(1)* %tmp_81, align 16
  %tmp_83 = extractelement <4 x float> %tmp_82, i32 1
  store float %tmp_83, float* %g, align 4
  %tmp_84 = load i32* %tmp_7, align 4
  %tmp_85 = load i32* %globalIdY, align 4
  %tmp_86 = sub i32 %tmp_85, 1
  %tmp_87 = mul i32 %tmp_84, %tmp_86
  %tmp_88 = load i32* %globalIdX, align 4
  %tmp_89 = add i32 %tmp_87, %tmp_88
  %tmp_90 = sub i32 %tmp_89, 1
  %tmp_91 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_92 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_91, i32 %tmp_90
  %tmp_93 = load <4 x float> addrspace(1)* %tmp_92, align 16
  %tmp_94 = extractelement <4 x float> %tmp_93, i32 2
  store float %tmp_94, float* %b, align 4
  %tmp_95 = load float* %r, align 4
  %tmp_96 = load float* %g, align 4
  %tmp_97 = load float* %b, align 4
  %tmp_98 = call float @luminance(float %tmp_95, float %tmp_96, float %tmp_97)
  store float %tmp_98, float* %leftUp, align 4
  %tmp_99 = load i32* %tmp_7, align 4
  %tmp_100 = load i32* %globalIdY, align 4
  %tmp_101 = sub i32 %tmp_100, 1
  %tmp_102 = mul i32 %tmp_99, %tmp_101
  %tmp_103 = load i32* %globalIdX, align 4
  %tmp_104 = add i32 %tmp_102, %tmp_103
  %tmp_105 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_106 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_105, i32 %tmp_104
  %tmp_107 = load <4 x float> addrspace(1)* %tmp_106, align 16
  %tmp_108 = extractelement <4 x float> %tmp_107, i32 0
  store float %tmp_108, float* %r, align 4
  %tmp_109 = load i32* %tmp_7, align 4
  %tmp_110 = load i32* %globalIdY, align 4
  %tmp_111 = sub i32 %tmp_110, 1
  %tmp_112 = mul i32 %tmp_109, %tmp_111
  %tmp_113 = load i32* %globalIdX, align 4
  %tmp_114 = add i32 %tmp_112, %tmp_113
  %tmp_115 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_116 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_115, i32 %tmp_114
  %tmp_117 = load <4 x float> addrspace(1)* %tmp_116, align 16
  %tmp_118 = extractelement <4 x float> %tmp_117, i32 1
  store float %tmp_118, float* %g, align 4
  %tmp_119 = load i32* %tmp_7, align 4
  %tmp_120 = load i32* %globalIdY, align 4
  %tmp_121 = sub i32 %tmp_120, 1
  %tmp_122 = mul i32 %tmp_119, %tmp_121
  %tmp_123 = load i32* %globalIdX, align 4
  %tmp_124 = add i32 %tmp_122, %tmp_123
  %tmp_125 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_126 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_125, i32 %tmp_124
  %tmp_127 = load <4 x float> addrspace(1)* %tmp_126, align 16
  %tmp_128 = extractelement <4 x float> %tmp_127, i32 2
  store float %tmp_128, float* %b, align 4
  %tmp_129 = load float* %r, align 4
  %tmp_130 = load float* %g, align 4
  %tmp_131 = load float* %b, align 4
  %tmp_132 = call float @luminance(float %tmp_129, float %tmp_130, float %tmp_131)
  store float %tmp_132, float* %up, align 4
  %tmp_133 = load i32* %tmp_7, align 4
  %tmp_134 = load i32* %globalIdY, align 4
  %tmp_135 = sub i32 %tmp_134, 1
  %tmp_136 = mul i32 %tmp_133, %tmp_135
  %tmp_137 = load i32* %globalIdX, align 4
  %tmp_138 = add i32 %tmp_136, %tmp_137
  %tmp_139 = add i32 %tmp_138, 1
  %tmp_140 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_141 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_140, i32 %tmp_139
  %tmp_142 = load <4 x float> addrspace(1)* %tmp_141, align 16
  %tmp_143 = extractelement <4 x float> %tmp_142, i32 0
  store float %tmp_143, float* %r, align 4
  %tmp_144 = load i32* %tmp_7, align 4
  %tmp_145 = load i32* %globalIdY, align 4
  %tmp_146 = sub i32 %tmp_145, 1
  %tmp_147 = mul i32 %tmp_144, %tmp_146
  %tmp_148 = load i32* %globalIdX, align 4
  %tmp_149 = add i32 %tmp_147, %tmp_148
  %tmp_150 = add i32 %tmp_149, 1
  %tmp_151 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_152 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_151, i32 %tmp_150
  %tmp_153 = load <4 x float> addrspace(1)* %tmp_152, align 16
  %tmp_154 = extractelement <4 x float> %tmp_153, i32 1
  store float %tmp_154, float* %g, align 4
  %tmp_155 = load i32* %tmp_7, align 4
  %tmp_156 = load i32* %globalIdY, align 4
  %tmp_157 = sub i32 %tmp_156, 1
  %tmp_158 = mul i32 %tmp_155, %tmp_157
  %tmp_159 = load i32* %globalIdX, align 4
  %tmp_160 = add i32 %tmp_158, %tmp_159
  %tmp_161 = add i32 %tmp_160, 1
  %tmp_162 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_163 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_162, i32 %tmp_161
  %tmp_164 = load <4 x float> addrspace(1)* %tmp_163, align 16
  %tmp_165 = extractelement <4 x float> %tmp_164, i32 2
  store float %tmp_165, float* %b, align 4
  %tmp_166 = load float* %r, align 4
  %tmp_167 = load float* %g, align 4
  %tmp_168 = load float* %b, align 4
  %tmp_169 = call float @luminance(float %tmp_166, float %tmp_167, float %tmp_168)
  store float %tmp_169, float* %rightUp, align 4
  %tmp_170 = load i32* %tmp_7, align 4
  %tmp_171 = load i32* %globalIdY, align 4
  %tmp_172 = mul i32 %tmp_170, %tmp_171
  %tmp_173 = load i32* %globalIdX, align 4
  %tmp_174 = add i32 %tmp_172, %tmp_173
  %tmp_175 = sub i32 %tmp_174, 1
  %tmp_176 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_177 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_176, i32 %tmp_175
  %tmp_178 = load <4 x float> addrspace(1)* %tmp_177, align 16
  %tmp_179 = extractelement <4 x float> %tmp_178, i32 0
  store float %tmp_179, float* %r, align 4
  %tmp_180 = load i32* %tmp_7, align 4
  %tmp_181 = load i32* %globalIdY, align 4
  %tmp_182 = mul i32 %tmp_180, %tmp_181
  %tmp_183 = load i32* %globalIdX, align 4
  %tmp_184 = add i32 %tmp_182, %tmp_183
  %tmp_185 = sub i32 %tmp_184, 1
  %tmp_186 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_187 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_186, i32 %tmp_185
  %tmp_188 = load <4 x float> addrspace(1)* %tmp_187, align 16
  %tmp_189 = extractelement <4 x float> %tmp_188, i32 1
  store float %tmp_189, float* %g, align 4
  %tmp_190 = load i32* %tmp_7, align 4
  %tmp_191 = load i32* %globalIdY, align 4
  %tmp_192 = mul i32 %tmp_190, %tmp_191
  %tmp_193 = load i32* %globalIdX, align 4
  %tmp_194 = add i32 %tmp_192, %tmp_193
  %tmp_195 = sub i32 %tmp_194, 1
  %tmp_196 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_197 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_196, i32 %tmp_195
  %tmp_198 = load <4 x float> addrspace(1)* %tmp_197, align 16
  %tmp_199 = extractelement <4 x float> %tmp_198, i32 2
  store float %tmp_199, float* %b, align 4
  %tmp_200 = load float* %r, align 4
  %tmp_201 = load float* %g, align 4
  %tmp_202 = load float* %b, align 4
  %tmp_203 = call float @luminance(float %tmp_200, float %tmp_201, float %tmp_202)
  store float %tmp_203, float* %left, align 4
  %tmp_204 = load i32* %tmp_7, align 4
  %tmp_205 = load i32* %globalIdY, align 4
  %tmp_206 = mul i32 %tmp_204, %tmp_205
  %tmp_207 = load i32* %globalIdX, align 4
  %tmp_208 = add i32 %tmp_206, %tmp_207
  %tmp_209 = add i32 %tmp_208, 1
  %tmp_210 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_211 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_210, i32 %tmp_209
  %tmp_212 = load <4 x float> addrspace(1)* %tmp_211, align 16
  %tmp_213 = extractelement <4 x float> %tmp_212, i32 0
  store float %tmp_213, float* %r, align 4
  %tmp_214 = load i32* %tmp_7, align 4
  %tmp_215 = load i32* %globalIdY, align 4
  %tmp_216 = mul i32 %tmp_214, %tmp_215
  %tmp_217 = load i32* %globalIdX, align 4
  %tmp_218 = add i32 %tmp_216, %tmp_217
  %tmp_219 = add i32 %tmp_218, 1
  %tmp_220 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_221 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_220, i32 %tmp_219
  %tmp_222 = load <4 x float> addrspace(1)* %tmp_221, align 16
  %tmp_223 = extractelement <4 x float> %tmp_222, i32 1
  store float %tmp_223, float* %g, align 4
  %tmp_224 = load i32* %tmp_7, align 4
  %tmp_225 = load i32* %globalIdY, align 4
  %tmp_226 = mul i32 %tmp_224, %tmp_225
  %tmp_227 = load i32* %globalIdX, align 4
  %tmp_228 = add i32 %tmp_226, %tmp_227
  %tmp_229 = add i32 %tmp_228, 1
  %tmp_230 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_231 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_230, i32 %tmp_229
  %tmp_232 = load <4 x float> addrspace(1)* %tmp_231, align 16
  %tmp_233 = extractelement <4 x float> %tmp_232, i32 2
  store float %tmp_233, float* %b, align 4
  %tmp_234 = load float* %r, align 4
  %tmp_235 = load float* %g, align 4
  %tmp_236 = load float* %b, align 4
  %tmp_237 = call float @luminance(float %tmp_234, float %tmp_235, float %tmp_236)
  store float %tmp_237, float* %right, align 4
  %tmp_238 = load i32* %tmp_7, align 4
  %tmp_239 = load i32* %globalIdY, align 4
  %tmp_240 = add i32 %tmp_239, 1
  %tmp_241 = mul i32 %tmp_238, %tmp_240
  %tmp_242 = load i32* %globalIdX, align 4
  %tmp_243 = add i32 %tmp_241, %tmp_242
  %tmp_244 = sub i32 %tmp_243, 1
  %tmp_245 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_246 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_245, i32 %tmp_244
  %tmp_247 = load <4 x float> addrspace(1)* %tmp_246, align 16
  %tmp_248 = extractelement <4 x float> %tmp_247, i32 0
  store float %tmp_248, float* %r, align 4
  %tmp_249 = load i32* %tmp_7, align 4
  %tmp_250 = load i32* %globalIdY, align 4
  %tmp_251 = add i32 %tmp_250, 1
  %tmp_252 = mul i32 %tmp_249, %tmp_251
  %tmp_253 = load i32* %globalIdX, align 4
  %tmp_254 = add i32 %tmp_252, %tmp_253
  %tmp_255 = sub i32 %tmp_254, 1
  %tmp_256 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_257 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_256, i32 %tmp_255
  %tmp_258 = load <4 x float> addrspace(1)* %tmp_257, align 16
  %tmp_259 = extractelement <4 x float> %tmp_258, i32 1
  store float %tmp_259, float* %g, align 4
  %tmp_260 = load i32* %tmp_7, align 4
  %tmp_261 = load i32* %globalIdY, align 4
  %tmp_262 = add i32 %tmp_261, 1
  %tmp_263 = mul i32 %tmp_260, %tmp_262
  %tmp_264 = load i32* %globalIdX, align 4
  %tmp_265 = add i32 %tmp_263, %tmp_264
  %tmp_266 = sub i32 %tmp_265, 1
  %tmp_267 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_268 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_267, i32 %tmp_266
  %tmp_269 = load <4 x float> addrspace(1)* %tmp_268, align 16
  %tmp_270 = extractelement <4 x float> %tmp_269, i32 2
  store float %tmp_270, float* %b, align 4
  %tmp_271 = load float* %r, align 4
  %tmp_272 = load float* %g, align 4
  %tmp_273 = load float* %b, align 4
  %tmp_274 = call float @luminance(float %tmp_271, float %tmp_272, float %tmp_273)
  store float %tmp_274, float* %leftDown, align 4
  %tmp_275 = load i32* %tmp_7, align 4
  %tmp_276 = load i32* %globalIdY, align 4
  %tmp_277 = add i32 %tmp_276, 1
  %tmp_278 = mul i32 %tmp_275, %tmp_277
  %tmp_279 = load i32* %globalIdX, align 4
  %tmp_280 = add i32 %tmp_278, %tmp_279
  %tmp_281 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_282 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_281, i32 %tmp_280
  %tmp_283 = load <4 x float> addrspace(1)* %tmp_282, align 16
  %tmp_284 = extractelement <4 x float> %tmp_283, i32 0
  store float %tmp_284, float* %r, align 4
  %tmp_285 = load i32* %tmp_7, align 4
  %tmp_286 = load i32* %globalIdY, align 4
  %tmp_287 = add i32 %tmp_286, 1
  %tmp_288 = mul i32 %tmp_285, %tmp_287
  %tmp_289 = load i32* %globalIdX, align 4
  %tmp_290 = add i32 %tmp_288, %tmp_289
  %tmp_291 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_292 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_291, i32 %tmp_290
  %tmp_293 = load <4 x float> addrspace(1)* %tmp_292, align 16
  %tmp_294 = extractelement <4 x float> %tmp_293, i32 1
  store float %tmp_294, float* %g, align 4
  %tmp_295 = load i32* %tmp_7, align 4
  %tmp_296 = load i32* %globalIdY, align 4
  %tmp_297 = add i32 %tmp_296, 1
  %tmp_298 = mul i32 %tmp_295, %tmp_297
  %tmp_299 = load i32* %globalIdX, align 4
  %tmp_300 = add i32 %tmp_298, %tmp_299
  %tmp_301 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_302 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_301, i32 %tmp_300
  %tmp_303 = load <4 x float> addrspace(1)* %tmp_302, align 16
  %tmp_304 = extractelement <4 x float> %tmp_303, i32 2
  store float %tmp_304, float* %b, align 4
  %tmp_305 = load float* %r, align 4
  %tmp_306 = load float* %g, align 4
  %tmp_307 = load float* %b, align 4
  %tmp_308 = call float @luminance(float %tmp_305, float %tmp_306, float %tmp_307)
  store float %tmp_308, float* %down, align 4
  %tmp_309 = load i32* %tmp_7, align 4
  %tmp_310 = load i32* %globalIdY, align 4
  %tmp_311 = add i32 %tmp_310, 1
  %tmp_312 = mul i32 %tmp_309, %tmp_311
  %tmp_313 = load i32* %globalIdX, align 4
  %tmp_314 = add i32 %tmp_312, %tmp_313
  %tmp_315 = add i32 %tmp_314, 1
  %tmp_316 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_317 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_316, i32 %tmp_315
  %tmp_318 = load <4 x float> addrspace(1)* %tmp_317, align 16
  %tmp_319 = extractelement <4 x float> %tmp_318, i32 0
  store float %tmp_319, float* %r, align 4
  %tmp_320 = load i32* %tmp_7, align 4
  %tmp_321 = load i32* %globalIdY, align 4
  %tmp_322 = add i32 %tmp_321, 1
  %tmp_323 = mul i32 %tmp_320, %tmp_322
  %tmp_324 = load i32* %globalIdX, align 4
  %tmp_325 = add i32 %tmp_323, %tmp_324
  %tmp_326 = add i32 %tmp_325, 1
  %tmp_327 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_328 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_327, i32 %tmp_326
  %tmp_329 = load <4 x float> addrspace(1)* %tmp_328, align 16
  %tmp_330 = extractelement <4 x float> %tmp_329, i32 1
  store float %tmp_330, float* %g, align 4
  %tmp_331 = load i32* %tmp_7, align 4
  %tmp_332 = load i32* %globalIdY, align 4
  %tmp_333 = add i32 %tmp_332, 1
  %tmp_334 = mul i32 %tmp_331, %tmp_333
  %tmp_335 = load i32* %globalIdX, align 4
  %tmp_336 = add i32 %tmp_334, %tmp_335
  %tmp_337 = add i32 %tmp_336, 1
  %tmp_338 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_339 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_338, i32 %tmp_337
  %tmp_340 = load <4 x float> addrspace(1)* %tmp_339, align 16
  %tmp_341 = extractelement <4 x float> %tmp_340, i32 2
  store float %tmp_341, float* %b, align 4
  %tmp_342 = load float* %r, align 4
  %tmp_343 = load float* %g, align 4
  %tmp_344 = load float* %b, align 4
  %tmp_345 = call float @luminance(float %tmp_342, float %tmp_343, float %tmp_344)
  store float %tmp_345, float* %rightDown, align 4
  %tmp_346 = load float* %leftUp, align 4
  %tmp_347 = load float* %up, align 4
  %tmp_348 = fadd float %tmp_346, %tmp_347
  %tmp_349 = load float* %rightUp, align 4
  %tmp_350 = fadd float %tmp_348, %tmp_349
  %tmp_351 = load float* %left, align 4
  %tmp_352 = fadd float %tmp_350, %tmp_351
  %tmp_353 = load float* %right, align 4
  %tmp_354 = fadd float %tmp_352, %tmp_353
  %tmp_355 = load float* %leftDown, align 4
  %tmp_356 = fadd float %tmp_354, %tmp_355
  %tmp_357 = load float* %down, align 4
  %tmp_358 = fadd float %tmp_356, %tmp_357
  %tmp_359 = load float* %rightDown, align 4
  %tmp_360 = fadd float %tmp_358, %tmp_359
  %tmp_361 = fdiv float %tmp_360, 8.000000e+00, !fpmath !3
  store float %tmp_361, float* %yLPattanaik, align 4
  br label %tmp_364

tmp_362:                                     ; preds = %tmp_56, %tmp_51, %tmp_48, %tmp_0
  %tmp_363 = load float* %yLuminance, align 4
  store float %tmp_363, float* %yLPattanaik, align 4
  br label %tmp_364

tmp_364:                                     ; preds = %tmp_362, %tmp_61
  %tmp_365 = load float* %yLPattanaik, align 4
  %tmp_366 = load float* %tmp_6, align 4
  %tmp_367 = load float* %yLPattanaik, align 4
  %tmp_368 = load float* %yLuminance, align 4
  %tmp_369 = fdiv float %tmp_367, %tmp_368, !fpmath !3
  %tmp_370 = fadd float %tmp_366, %tmp_369
  %tmp_371 = call float @llvm.log2.f32(float %tmp_370)
  %tmp_372 = fmul float %tmp_371, 0x3FE62E4300000000
  %tmp_373 = load float* %gcPattanaik, align 4
  %tmp_374 = call float @llvm.fmuladd.f32(float %tmp_365, float %tmp_372, float %tmp_373)
  store float %tmp_374, float* %cLPattanaik, align 4
  %tmp_375 = load float* %yLuminance, align 4
  %tmp_376 = load float* %yLuminance, align 4
  %tmp_377 = load float* %cLPattanaik, align 4
  %tmp_378 = fadd float %tmp_376, %tmp_377
  %tmp_379 = fdiv float %tmp_375, %tmp_378, !fpmath !3
  store float %tmp_379, float* %yDPattanaik, align 4
  %tmp_380 = load float* %r1, align 4
  %tmp_381 = load float* %yLuminance, align 4
  %tmp_382 = fdiv float %tmp_380, %tmp_381, !fpmath !3
  %tmp_383 = load float* %tmp_4, align 4
  %tmp_384 = call float @llvm.pow.f32(float %tmp_382, float %tmp_383)
  %tmp_385 = load float* %yDPattanaik, align 4
  %tmp_386 = fmul float %tmp_384, %tmp_385
  store float %tmp_386, float* %r, align 4
  %tmp_387 = load float* %g1, align 4
  %tmp_388 = load float* %yLuminance, align 4
  %tmp_389 = fdiv float %tmp_387, %tmp_388, !fpmath !3
  %tmp_390 = load float* %tmp_4, align 4
  %tmp_391 = call float @llvm.pow.f32(float %tmp_389, float %tmp_390)
  %tmp_392 = load float* %yDPattanaik, align 4
  %tmp_393 = fmul float %tmp_391, %tmp_392
  store float %tmp_393, float* %g, align 4
  %tmp_394 = load float* %b1, align 4
  %tmp_395 = load float* %yLuminance, align 4
  %tmp_396 = fdiv float %tmp_394, %tmp_395, !fpmath !3
  %tmp_397 = load float* %tmp_4, align 4
  %tmp_398 = call float @llvm.pow.f32(float %tmp_396, float %tmp_397)
  %tmp_399 = load float* %yDPattanaik, align 4
  %tmp_400 = fmul float %tmp_398, %tmp_399
  store float %tmp_400, float* %b, align 4
  %tmp_401 = load float* %r, align 4
  %tmp_402 = load i32* %tmp_7, align 4
  %tmp_403 = load i32* %globalIdY, align 4
  %tmp_404 = mul i32 %tmp_402, %tmp_403
  %tmp_405 = load i32* %globalIdX, align 4
  %tmp_406 = add i32 %tmp_404, %tmp_405
  %tmp_407 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_408 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_407, i32 %tmp_406
  %tmp_409 = load <4 x float> addrspace(1)* %tmp_408, align 16
  %tmp_410 = insertelement <4 x float> %tmp_409, float %tmp_401, i32 0
  store <4 x float> %tmp_410, <4 x float> addrspace(1)* %tmp_408, align 16
  %tmp_411 = load float* %g, align 4
  %tmp_412 = load i32* %tmp_7, align 4
  %tmp_413 = load i32* %globalIdY, align 4
  %tmp_414 = mul i32 %tmp_412, %tmp_413
  %tmp_415 = load i32* %globalIdX, align 4
  %tmp_416 = add i32 %tmp_414, %tmp_415
  %tmp_417 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_418 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_417, i32 %tmp_416
  %tmp_419 = load <4 x float> addrspace(1)* %tmp_418, align 16
  %tmp_420 = insertelement <4 x float> %tmp_419, float %tmp_411, i32 1
  store <4 x float> %tmp_420, <4 x float> addrspace(1)* %tmp_418, align 16
  %tmp_421 = load float* %b, align 4
  %tmp_422 = load i32* %tmp_7, align 4
  %tmp_423 = load i32* %globalIdY, align 4
  %tmp_424 = mul i32 %tmp_422, %tmp_423
  %tmp_425 = load i32* %globalIdX, align 4
  %tmp_426 = add i32 %tmp_424, %tmp_425
  %tmp_427 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_428 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_427, i32 %tmp_426
  %tmp_429 = load <4 x float> addrspace(1)* %tmp_428, align 16
  %tmp_430 = insertelement <4 x float> %tmp_429, float %tmp_421, i32 2
  store <4 x float> %tmp_430, <4 x float> addrspace(1)* %tmp_428, align 16
  %tmp_431 = load i32* %tmp_7, align 4
  %tmp_432 = load i32* %globalIdY, align 4
  %tmp_433 = mul i32 %tmp_431, %tmp_432
  %tmp_434 = load i32* %globalIdX, align 4
  %tmp_435 = add i32 %tmp_433, %tmp_434
  %tmp_436 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_437 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_436, i32 %tmp_435
  %tmp_438 = load <4 x float> addrspace(1)* %tmp_437, align 16
  %tmp_439 = extractelement <4 x float> %tmp_438, i32 3
  %tmp_440 = load i32* %tmp_7, align 4
  %tmp_441 = load i32* %globalIdY, align 4
  %tmp_442 = mul i32 %tmp_440, %tmp_441
  %tmp_443 = load i32* %globalIdX, align 4
  %tmp_444 = add i32 %tmp_442, %tmp_443
  %tmp_445 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_446 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_445, i32 %tmp_444
  %tmp_447 = load <4 x float> addrspace(1)* %tmp_446, align 16
  %tmp_448 = insertelement <4 x float> %tmp_447, float %tmp_439, i32 3
  store <4 x float> %tmp_448, <4 x float> addrspace(1)* %tmp_446, align 16
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float, float, float, float, i32, i32, i32)* @toneMappingPattanaik1}
!1 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, float, float, float, float, i32, i32, i32)* @toneMappingPattanaik}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{float 2.500000e+00}

; ModuleID = '../kernel-src/Mandelbrot_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @mandelbrot_vector_float(<4 x i8> addrspace(1)* %mandelbrotImage, float %posx, float %posy, float %stepSizeX, float %stepSizeY, i32 %maxIterations, i32 %width, i32 %bench) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca float, align 4
  %tmp_3 = alloca float, align 4
  %tmp_4 = alloca float, align 4
  %tmp_5 = alloca float, align 4
  %tmp_6 = alloca i32, align 4
  %tmp_7 = alloca i32, align 4
  %tmp_8 = alloca i32, align 4
  %tid = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %veci = alloca <4 x i32>, align 16
  %vecj = alloca <4 x i32>, align 16
  %x0 = alloca <4 x float>, align 16
  %y0 = alloca <4 x float>, align 16
  %x = alloca <4 x float>, align 16
  %y = alloca <4 x float>, align 16
  %iter = alloca i32, align 4
  %tmp = alloca <4 x float>, align 16
  %stay = alloca <4 x i32>, align 16
  %ccount = alloca <4 x i32>, align 16
  %savx = alloca <4 x float>, align 16
  %savy = alloca <4 x float>, align 16
  %fc = alloca <4 x float>, align 16
  %c = alloca float, align 4
  %color = alloca [4 x <4 x i8>], align 4
  store <4 x i8> addrspace(1)* %mandelbrotImage, <4 x i8> addrspace(1)** %tmp_1, align 4
  store float %posx, float* %tmp_2, align 4
  store float %posy, float* %tmp_3, align 4
  store float %stepSizeX, float* %tmp_4, align 4
  store float %stepSizeY, float* %tmp_5, align 4
  store i32 %maxIterations, i32* %tmp_6, align 4
  store i32 %width, i32* %tmp_7, align 4
  store i32 %bench, i32* %tmp_8, align 4
  %tmp_9 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_9, i32* %tid, align 4
  %tmp_10 = load i32* %tid, align 4
  %tmp_11 = load i32* %tmp_7, align 4
  %tmp_12 = sdiv i32 %tmp_11, 4
  %tmp_13 = srem i32 %tmp_10, %tmp_12
  store i32 %tmp_13, i32* %i, align 4
  %tmp_14 = load i32* %tid, align 4
  %tmp_15 = load i32* %tmp_7, align 4
  %tmp_16 = sdiv i32 %tmp_15, 4
  %tmp_17 = sdiv i32 %tmp_14, %tmp_16
  store i32 %tmp_17, i32* %j, align 4
  %tmp_18 = load i32* %i, align 4
  %tmp_19 = mul nsw i32 4, %tmp_18
  %tmp_20 = insertelement <4 x i32> undef, i32 %tmp_19, i32 0
  %tmp_21 = load i32* %i, align 4
  %tmp_22 = mul nsw i32 4, %tmp_21
  %tmp_23 = add nsw i32 %tmp_22, 1
  %tmp_24 = insertelement <4 x i32> %tmp_20, i32 %tmp_23, i32 1
  %tmp_25 = load i32* %i, align 4
  %tmp_26 = mul nsw i32 4, %tmp_25
  %tmp_27 = add nsw i32 %tmp_26, 2
  %tmp_28 = insertelement <4 x i32> %tmp_24, i32 %tmp_27, i32 2
  %tmp_29 = load i32* %i, align 4
  %tmp_30 = mul nsw i32 4, %tmp_29
  %tmp_31 = add nsw i32 %tmp_30, 3
  %tmp_32 = insertelement <4 x i32> %tmp_28, i32 %tmp_31, i32 3
  store <4 x i32> %tmp_32, <4 x i32>* %veci, align 16
  %tmp_33 = load i32* %j, align 4
  %tmp_34 = insertelement <4 x i32> undef, i32 %tmp_33, i32 0
  %tmp_35 = load i32* %j, align 4
  %tmp_36 = insertelement <4 x i32> %tmp_34, i32 %tmp_35, i32 1
  %tmp_37 = load i32* %j, align 4
  %tmp_38 = insertelement <4 x i32> %tmp_36, i32 %tmp_37, i32 2
  %tmp_39 = load i32* %j, align 4
  %tmp_40 = insertelement <4 x i32> %tmp_38, i32 %tmp_39, i32 3
  store <4 x i32> %tmp_40, <4 x i32>* %vecj, align 16
  %tmp_41 = load float* %tmp_2, align 4
  %tmp_42 = load float* %tmp_4, align 4
  %tmp_43 = load <4 x i32>* %veci, align 16
  %tmp_44 = extractelement <4 x i32> %tmp_43, i32 0
  %tmp_45 = sitofp i32 %tmp_44 to float
  %tmp_46 = call float @llvm.fmuladd.f32(float %tmp_42, float %tmp_45, float %tmp_41)
  %tmp_47 = load <4 x float>* %x0, align 16
  %tmp_48 = insertelement <4 x float> %tmp_47, float %tmp_46, i32 0
  store <4 x float> %tmp_48, <4 x float>* %x0, align 16
  %tmp_49 = load float* %tmp_2, align 4
  %tmp_50 = load float* %tmp_4, align 4
  %tmp_51 = load <4 x i32>* %veci, align 16
  %tmp_52 = extractelement <4 x i32> %tmp_51, i32 1
  %tmp_53 = sitofp i32 %tmp_52 to float
  %tmp_54 = call float @llvm.fmuladd.f32(float %tmp_50, float %tmp_53, float %tmp_49)
  %tmp_55 = load <4 x float>* %x0, align 16
  %tmp_56 = insertelement <4 x float> %tmp_55, float %tmp_54, i32 1
  store <4 x float> %tmp_56, <4 x float>* %x0, align 16
  %tmp_57 = load float* %tmp_2, align 4
  %tmp_58 = load float* %tmp_4, align 4
  %tmp_59 = load <4 x i32>* %veci, align 16
  %tmp_60 = extractelement <4 x i32> %tmp_59, i32 2
  %tmp_61 = sitofp i32 %tmp_60 to float
  %tmp_62 = call float @llvm.fmuladd.f32(float %tmp_58, float %tmp_61, float %tmp_57)
  %tmp_63 = load <4 x float>* %x0, align 16
  %tmp_64 = insertelement <4 x float> %tmp_63, float %tmp_62, i32 2
  store <4 x float> %tmp_64, <4 x float>* %x0, align 16
  %tmp_65 = load float* %tmp_2, align 4
  %tmp_66 = load float* %tmp_4, align 4
  %tmp_67 = load <4 x i32>* %veci, align 16
  %tmp_68 = extractelement <4 x i32> %tmp_67, i32 3
  %tmp_69 = sitofp i32 %tmp_68 to float
  %tmp_70 = call float @llvm.fmuladd.f32(float %tmp_66, float %tmp_69, float %tmp_65)
  %tmp_71 = load <4 x float>* %x0, align 16
  %tmp_72 = insertelement <4 x float> %tmp_71, float %tmp_70, i32 3
  store <4 x float> %tmp_72, <4 x float>* %x0, align 16
  %tmp_73 = load float* %tmp_3, align 4
  %tmp_74 = load float* %tmp_5, align 4
  %tmp_75 = load <4 x i32>* %vecj, align 16
  %tmp_76 = extractelement <4 x i32> %tmp_75, i32 0
  %tmp_77 = sitofp i32 %tmp_76 to float
  %tmp_78 = call float @llvm.fmuladd.f32(float %tmp_74, float %tmp_77, float %tmp_73)
  %tmp_79 = load <4 x float>* %y0, align 16
  %tmp_80 = insertelement <4 x float> %tmp_79, float %tmp_78, i32 0
  store <4 x float> %tmp_80, <4 x float>* %y0, align 16
  %tmp_81 = load float* %tmp_3, align 4
  %tmp_82 = load float* %tmp_5, align 4
  %tmp_83 = load <4 x i32>* %vecj, align 16
  %tmp_84 = extractelement <4 x i32> %tmp_83, i32 1
  %tmp_85 = sitofp i32 %tmp_84 to float
  %tmp_86 = call float @llvm.fmuladd.f32(float %tmp_82, float %tmp_85, float %tmp_81)
  %tmp_87 = load <4 x float>* %y0, align 16
  %tmp_88 = insertelement <4 x float> %tmp_87, float %tmp_86, i32 1
  store <4 x float> %tmp_88, <4 x float>* %y0, align 16
  %tmp_89 = load float* %tmp_3, align 4
  %tmp_90 = load float* %tmp_5, align 4
  %tmp_91 = load <4 x i32>* %vecj, align 16
  %tmp_92 = extractelement <4 x i32> %tmp_91, i32 2
  %tmp_93 = sitofp i32 %tmp_92 to float
  %tmp_94 = call float @llvm.fmuladd.f32(float %tmp_90, float %tmp_93, float %tmp_89)
  %tmp_95 = load <4 x float>* %y0, align 16
  %tmp_96 = insertelement <4 x float> %tmp_95, float %tmp_94, i32 2
  store <4 x float> %tmp_96, <4 x float>* %y0, align 16
  %tmp_97 = load float* %tmp_3, align 4
  %tmp_98 = load float* %tmp_5, align 4
  %tmp_99 = load <4 x i32>* %vecj, align 16
  %tmp_100 = extractelement <4 x i32> %tmp_99, i32 3
  %tmp_101 = sitofp i32 %tmp_100 to float
  %tmp_102 = call float @llvm.fmuladd.f32(float %tmp_98, float %tmp_101, float %tmp_97)
  %tmp_103 = load <4 x float>* %y0, align 16
  %tmp_104 = insertelement <4 x float> %tmp_103, float %tmp_102, i32 3
  store <4 x float> %tmp_104, <4 x float>* %y0, align 16
  %tmp_105 = load <4 x float>* %x0, align 16
  store <4 x float> %tmp_105, <4 x float>* %x, align 16
  %tmp_106 = load <4 x float>* %y0, align 16
  store <4 x float> %tmp_106, <4 x float>* %y, align 16
  store i32 0, i32* %iter, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %ccount, align 16
  %tmp_107 = load <4 x float>* %x, align 16
  %tmp_108 = extractelement <4 x float> %tmp_107, i32 0
  %tmp_109 = load <4 x float>* %x, align 16
  %tmp_110 = extractelement <4 x float> %tmp_109, i32 0
  %tmp_111 = load <4 x float>* %y, align 16
  %tmp_112 = extractelement <4 x float> %tmp_111, i32 0
  %tmp_113 = load <4 x float>* %y, align 16
  %tmp_114 = extractelement <4 x float> %tmp_113, i32 0
  %tmp_115 = fmul float %tmp_112, %tmp_114
  %tmp_116 = call float @llvm.fmuladd.f32(float %tmp_108, float %tmp_110, float %tmp_115)
  %tmp_117 = fcmp ole float %tmp_116, 4.000000e+00
  %tmp_118 = zext i1 %tmp_117 to i32
  %tmp_119 = load <4 x i32>* %stay, align 16
  %tmp_120 = insertelement <4 x i32> %tmp_119, i32 %tmp_118, i32 0
  store <4 x i32> %tmp_120, <4 x i32>* %stay, align 16
  %tmp_121 = load <4 x float>* %x, align 16
  %tmp_122 = extractelement <4 x float> %tmp_121, i32 1
  %tmp_123 = load <4 x float>* %x, align 16
  %tmp_124 = extractelement <4 x float> %tmp_123, i32 1
  %tmp_125 = load <4 x float>* %y, align 16
  %tmp_126 = extractelement <4 x float> %tmp_125, i32 1
  %tmp_127 = load <4 x float>* %y, align 16
  %tmp_128 = extractelement <4 x float> %tmp_127, i32 1
  %tmp_129 = fmul float %tmp_126, %tmp_128
  %tmp_130 = call float @llvm.fmuladd.f32(float %tmp_122, float %tmp_124, float %tmp_129)
  %tmp_131 = fcmp ole float %tmp_130, 4.000000e+00
  %tmp_132 = zext i1 %tmp_131 to i32
  %tmp_133 = load <4 x i32>* %stay, align 16
  %tmp_134 = insertelement <4 x i32> %tmp_133, i32 %tmp_132, i32 1
  store <4 x i32> %tmp_134, <4 x i32>* %stay, align 16
  %tmp_135 = load <4 x float>* %x, align 16
  %tmp_136 = extractelement <4 x float> %tmp_135, i32 2
  %tmp_137 = load <4 x float>* %x, align 16
  %tmp_138 = extractelement <4 x float> %tmp_137, i32 2
  %tmp_139 = load <4 x float>* %y, align 16
  %tmp_140 = extractelement <4 x float> %tmp_139, i32 2
  %tmp_141 = load <4 x float>* %y, align 16
  %tmp_142 = extractelement <4 x float> %tmp_141, i32 2
  %tmp_143 = fmul float %tmp_140, %tmp_142
  %tmp_144 = call float @llvm.fmuladd.f32(float %tmp_136, float %tmp_138, float %tmp_143)
  %tmp_145 = fcmp ole float %tmp_144, 4.000000e+00
  %tmp_146 = zext i1 %tmp_145 to i32
  %tmp_147 = load <4 x i32>* %stay, align 16
  %tmp_148 = insertelement <4 x i32> %tmp_147, i32 %tmp_146, i32 2
  store <4 x i32> %tmp_148, <4 x i32>* %stay, align 16
  %tmp_149 = load <4 x float>* %x, align 16
  %tmp_150 = extractelement <4 x float> %tmp_149, i32 3
  %tmp_151 = load <4 x float>* %x, align 16
  %tmp_152 = extractelement <4 x float> %tmp_151, i32 3
  %tmp_153 = load <4 x float>* %y, align 16
  %tmp_154 = extractelement <4 x float> %tmp_153, i32 3
  %tmp_155 = load <4 x float>* %y, align 16
  %tmp_156 = extractelement <4 x float> %tmp_155, i32 3
  %tmp_157 = fmul float %tmp_154, %tmp_156
  %tmp_158 = call float @llvm.fmuladd.f32(float %tmp_150, float %tmp_152, float %tmp_157)
  %tmp_159 = fcmp ole float %tmp_158, 4.000000e+00
  %tmp_160 = zext i1 %tmp_159 to i32
  %tmp_161 = load <4 x i32>* %stay, align 16
  %tmp_162 = insertelement <4 x i32> %tmp_161, i32 %tmp_160, i32 3
  store <4 x i32> %tmp_162, <4 x i32>* %stay, align 16
  %tmp_163 = load <4 x float>* %x, align 16
  store <4 x float> %tmp_163, <4 x float>* %savx, align 16
  %tmp_164 = load <4 x float>* %y, align 16
  store <4 x float> %tmp_164, <4 x float>* %savy, align 16
  store i32 0, i32* %iter, align 4
  br label %tmp_165

tmp_165:                                     ; preds = %tmp_653, %tmp_0
  %tmp_166 = load <4 x i32>* %stay, align 16
  %tmp_167 = extractelement <4 x i32> %tmp_166, i32 0
  %tmp_168 = load <4 x i32>* %stay, align 16
  %tmp_169 = extractelement <4 x i32> %tmp_168, i32 1
  %tmp_170 = or i32 %tmp_167, %tmp_169
  %tmp_171 = load <4 x i32>* %stay, align 16
  %tmp_172 = extractelement <4 x i32> %tmp_171, i32 2
  %tmp_173 = or i32 %tmp_170, %tmp_172
  %tmp_174 = load <4 x i32>* %stay, align 16
  %tmp_175 = extractelement <4 x i32> %tmp_174, i32 3
  %tmp_176 = or i32 %tmp_173, %tmp_175
  %tmp_177 = icmp ne i32 %tmp_176, 0
  br i1 %tmp_177, label %tmp_178, label %tmp_656

tmp_178:                                     ; preds = %tmp_165
  %tmp_179 = load i32* %iter, align 4
  %tmp_180 = load i32* %tmp_6, align 4
  %tmp_181 = icmp ult i32 %tmp_179, %tmp_180
  br i1 %tmp_181, label %tmp_182, label %tmp_656

tmp_182:                                     ; preds = %tmp_178
  %tmp_183 = load <4 x float>* %savx, align 16
  store <4 x float> %tmp_183, <4 x float>* %x, align 16
  %tmp_184 = load <4 x float>* %savy, align 16
  store <4 x float> %tmp_184, <4 x float>* %y, align 16
  %tmp_185 = load <4 x float>* %y, align 16
  %tmp_186 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_185
  %tmp_187 = load <4 x float>* %y, align 16
  %tmp_188 = load <4 x float>* %x, align 16
  %tmp_189 = load <4 x float>* %x, align 16
  %tmp_190 = load <4 x float>* %x0, align 16
  %tmp_191 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_188, <4 x float> %tmp_189, <4 x float> %tmp_190)
  %tmp_192 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_186, <4 x float> %tmp_187, i32 %tmp_191)
  %tmp_193 = sitofp i32 %tmp_192 to float
  %tmp_194 = insertelement <4 x float> undef, float %tmp_193, i32 0
  %tmp_195 = shufflevector <4 x float> %tmp_194, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_195, <4 x float>* %tmp, align 16
  %tmp_196 = load <4 x float>* %x, align 16
  %tmp_197 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_196
  %tmp_198 = load <4 x float>* %y, align 16
  %tmp_199 = load <4 x float>* %y0, align 16
  %tmp_200 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_197, <4 x float> %tmp_198, <4 x float> %tmp_199)
  %tmp_201 = sitofp i32 %tmp_200 to float
  %tmp_202 = insertelement <4 x float> undef, float %tmp_201, i32 0
  %tmp_203 = shufflevector <4 x float> %tmp_202, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_203, <4 x float>* %y, align 16
  %tmp_204 = load <4 x float>* %y, align 16
  %tmp_205 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_204
  %tmp_206 = load <4 x float>* %y, align 16
  %tmp_207 = load <4 x float>* %tmp, align 16
  %tmp_208 = load <4 x float>* %tmp, align 16
  %tmp_209 = load <4 x float>* %x0, align 16
  %tmp_210 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_207, <4 x float> %tmp_208, <4 x float> %tmp_209)
  %tmp_211 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_205, <4 x float> %tmp_206, i32 %tmp_210)
  %tmp_212 = sitofp i32 %tmp_211 to float
  %tmp_213 = insertelement <4 x float> undef, float %tmp_212, i32 0
  %tmp_214 = shufflevector <4 x float> %tmp_213, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_214, <4 x float>* %x, align 16
  %tmp_215 = load <4 x float>* %tmp, align 16
  %tmp_216 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_215
  %tmp_217 = load <4 x float>* %y, align 16
  %tmp_218 = load <4 x float>* %y0, align 16
  %tmp_219 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_216, <4 x float> %tmp_217, <4 x float> %tmp_218)
  %tmp_220 = sitofp i32 %tmp_219 to float
  %tmp_221 = insertelement <4 x float> undef, float %tmp_220, i32 0
  %tmp_222 = shufflevector <4 x float> %tmp_221, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_222, <4 x float>* %y, align 16
  %tmp_223 = load <4 x float>* %y, align 16
  %tmp_224 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_223
  %tmp_225 = load <4 x float>* %y, align 16
  %tmp_226 = load <4 x float>* %x, align 16
  %tmp_227 = load <4 x float>* %x, align 16
  %tmp_228 = load <4 x float>* %x0, align 16
  %tmp_229 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_226, <4 x float> %tmp_227, <4 x float> %tmp_228)
  %tmp_230 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_224, <4 x float> %tmp_225, i32 %tmp_229)
  %tmp_231 = sitofp i32 %tmp_230 to float
  %tmp_232 = insertelement <4 x float> undef, float %tmp_231, i32 0
  %tmp_233 = shufflevector <4 x float> %tmp_232, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_233, <4 x float>* %tmp, align 16
  %tmp_234 = load <4 x float>* %x, align 16
  %tmp_235 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_234
  %tmp_236 = load <4 x float>* %y, align 16
  %tmp_237 = load <4 x float>* %y0, align 16
  %tmp_238 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_235, <4 x float> %tmp_236, <4 x float> %tmp_237)
  %tmp_239 = sitofp i32 %tmp_238 to float
  %tmp_240 = insertelement <4 x float> undef, float %tmp_239, i32 0
  %tmp_241 = shufflevector <4 x float> %tmp_240, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_241, <4 x float>* %y, align 16
  %tmp_242 = load <4 x float>* %y, align 16
  %tmp_243 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_242
  %tmp_244 = load <4 x float>* %y, align 16
  %tmp_245 = load <4 x float>* %tmp, align 16
  %tmp_246 = load <4 x float>* %tmp, align 16
  %tmp_247 = load <4 x float>* %x0, align 16
  %tmp_248 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_245, <4 x float> %tmp_246, <4 x float> %tmp_247)
  %tmp_249 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_243, <4 x float> %tmp_244, i32 %tmp_248)
  %tmp_250 = sitofp i32 %tmp_249 to float
  %tmp_251 = insertelement <4 x float> undef, float %tmp_250, i32 0
  %tmp_252 = shufflevector <4 x float> %tmp_251, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_252, <4 x float>* %x, align 16
  %tmp_253 = load <4 x float>* %tmp, align 16
  %tmp_254 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_253
  %tmp_255 = load <4 x float>* %y, align 16
  %tmp_256 = load <4 x float>* %y0, align 16
  %tmp_257 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_254, <4 x float> %tmp_255, <4 x float> %tmp_256)
  %tmp_258 = sitofp i32 %tmp_257 to float
  %tmp_259 = insertelement <4 x float> undef, float %tmp_258, i32 0
  %tmp_260 = shufflevector <4 x float> %tmp_259, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_260, <4 x float>* %y, align 16
  %tmp_261 = load <4 x float>* %y, align 16
  %tmp_262 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_261
  %tmp_263 = load <4 x float>* %y, align 16
  %tmp_264 = load <4 x float>* %x, align 16
  %tmp_265 = load <4 x float>* %x, align 16
  %tmp_266 = load <4 x float>* %x0, align 16
  %tmp_267 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_264, <4 x float> %tmp_265, <4 x float> %tmp_266)
  %tmp_268 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_262, <4 x float> %tmp_263, i32 %tmp_267)
  %tmp_269 = sitofp i32 %tmp_268 to float
  %tmp_270 = insertelement <4 x float> undef, float %tmp_269, i32 0
  %tmp_271 = shufflevector <4 x float> %tmp_270, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_271, <4 x float>* %tmp, align 16
  %tmp_272 = load <4 x float>* %x, align 16
  %tmp_273 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_272
  %tmp_274 = load <4 x float>* %y, align 16
  %tmp_275 = load <4 x float>* %y0, align 16
  %tmp_276 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_273, <4 x float> %tmp_274, <4 x float> %tmp_275)
  %tmp_277 = sitofp i32 %tmp_276 to float
  %tmp_278 = insertelement <4 x float> undef, float %tmp_277, i32 0
  %tmp_279 = shufflevector <4 x float> %tmp_278, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_279, <4 x float>* %y, align 16
  %tmp_280 = load <4 x float>* %y, align 16
  %tmp_281 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_280
  %tmp_282 = load <4 x float>* %y, align 16
  %tmp_283 = load <4 x float>* %tmp, align 16
  %tmp_284 = load <4 x float>* %tmp, align 16
  %tmp_285 = load <4 x float>* %x0, align 16
  %tmp_286 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_283, <4 x float> %tmp_284, <4 x float> %tmp_285)
  %tmp_287 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_281, <4 x float> %tmp_282, i32 %tmp_286)
  %tmp_288 = sitofp i32 %tmp_287 to float
  %tmp_289 = insertelement <4 x float> undef, float %tmp_288, i32 0
  %tmp_290 = shufflevector <4 x float> %tmp_289, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_290, <4 x float>* %x, align 16
  %tmp_291 = load <4 x float>* %tmp, align 16
  %tmp_292 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_291
  %tmp_293 = load <4 x float>* %y, align 16
  %tmp_294 = load <4 x float>* %y0, align 16
  %tmp_295 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_292, <4 x float> %tmp_293, <4 x float> %tmp_294)
  %tmp_296 = sitofp i32 %tmp_295 to float
  %tmp_297 = insertelement <4 x float> undef, float %tmp_296, i32 0
  %tmp_298 = shufflevector <4 x float> %tmp_297, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_298, <4 x float>* %y, align 16
  %tmp_299 = load <4 x float>* %y, align 16
  %tmp_300 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_299
  %tmp_301 = load <4 x float>* %y, align 16
  %tmp_302 = load <4 x float>* %x, align 16
  %tmp_303 = load <4 x float>* %x, align 16
  %tmp_304 = load <4 x float>* %x0, align 16
  %tmp_305 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_302, <4 x float> %tmp_303, <4 x float> %tmp_304)
  %tmp_306 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_300, <4 x float> %tmp_301, i32 %tmp_305)
  %tmp_307 = sitofp i32 %tmp_306 to float
  %tmp_308 = insertelement <4 x float> undef, float %tmp_307, i32 0
  %tmp_309 = shufflevector <4 x float> %tmp_308, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_309, <4 x float>* %tmp, align 16
  %tmp_310 = load <4 x float>* %x, align 16
  %tmp_311 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_310
  %tmp_312 = load <4 x float>* %y, align 16
  %tmp_313 = load <4 x float>* %y0, align 16
  %tmp_314 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_311, <4 x float> %tmp_312, <4 x float> %tmp_313)
  %tmp_315 = sitofp i32 %tmp_314 to float
  %tmp_316 = insertelement <4 x float> undef, float %tmp_315, i32 0
  %tmp_317 = shufflevector <4 x float> %tmp_316, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_317, <4 x float>* %y, align 16
  %tmp_318 = load <4 x float>* %y, align 16
  %tmp_319 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_318
  %tmp_320 = load <4 x float>* %y, align 16
  %tmp_321 = load <4 x float>* %tmp, align 16
  %tmp_322 = load <4 x float>* %tmp, align 16
  %tmp_323 = load <4 x float>* %x0, align 16
  %tmp_324 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_321, <4 x float> %tmp_322, <4 x float> %tmp_323)
  %tmp_325 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_319, <4 x float> %tmp_320, i32 %tmp_324)
  %tmp_326 = sitofp i32 %tmp_325 to float
  %tmp_327 = insertelement <4 x float> undef, float %tmp_326, i32 0
  %tmp_328 = shufflevector <4 x float> %tmp_327, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_328, <4 x float>* %x, align 16
  %tmp_329 = load <4 x float>* %tmp, align 16
  %tmp_330 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_329
  %tmp_331 = load <4 x float>* %y, align 16
  %tmp_332 = load <4 x float>* %y0, align 16
  %tmp_333 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_330, <4 x float> %tmp_331, <4 x float> %tmp_332)
  %tmp_334 = sitofp i32 %tmp_333 to float
  %tmp_335 = insertelement <4 x float> undef, float %tmp_334, i32 0
  %tmp_336 = shufflevector <4 x float> %tmp_335, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_336, <4 x float>* %y, align 16
  %tmp_337 = load <4 x float>* %y, align 16
  %tmp_338 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_337
  %tmp_339 = load <4 x float>* %y, align 16
  %tmp_340 = load <4 x float>* %x, align 16
  %tmp_341 = load <4 x float>* %x, align 16
  %tmp_342 = load <4 x float>* %x0, align 16
  %tmp_343 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_340, <4 x float> %tmp_341, <4 x float> %tmp_342)
  %tmp_344 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_338, <4 x float> %tmp_339, i32 %tmp_343)
  %tmp_345 = sitofp i32 %tmp_344 to float
  %tmp_346 = insertelement <4 x float> undef, float %tmp_345, i32 0
  %tmp_347 = shufflevector <4 x float> %tmp_346, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_347, <4 x float>* %tmp, align 16
  %tmp_348 = load <4 x float>* %x, align 16
  %tmp_349 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_348
  %tmp_350 = load <4 x float>* %y, align 16
  %tmp_351 = load <4 x float>* %y0, align 16
  %tmp_352 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_349, <4 x float> %tmp_350, <4 x float> %tmp_351)
  %tmp_353 = sitofp i32 %tmp_352 to float
  %tmp_354 = insertelement <4 x float> undef, float %tmp_353, i32 0
  %tmp_355 = shufflevector <4 x float> %tmp_354, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_355, <4 x float>* %y, align 16
  %tmp_356 = load <4 x float>* %y, align 16
  %tmp_357 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_356
  %tmp_358 = load <4 x float>* %y, align 16
  %tmp_359 = load <4 x float>* %tmp, align 16
  %tmp_360 = load <4 x float>* %tmp, align 16
  %tmp_361 = load <4 x float>* %x0, align 16
  %tmp_362 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_359, <4 x float> %tmp_360, <4 x float> %tmp_361)
  %tmp_363 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_357, <4 x float> %tmp_358, i32 %tmp_362)
  %tmp_364 = sitofp i32 %tmp_363 to float
  %tmp_365 = insertelement <4 x float> undef, float %tmp_364, i32 0
  %tmp_366 = shufflevector <4 x float> %tmp_365, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_366, <4 x float>* %x, align 16
  %tmp_367 = load <4 x float>* %tmp, align 16
  %tmp_368 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_367
  %tmp_369 = load <4 x float>* %y, align 16
  %tmp_370 = load <4 x float>* %y0, align 16
  %tmp_371 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_368, <4 x float> %tmp_369, <4 x float> %tmp_370)
  %tmp_372 = sitofp i32 %tmp_371 to float
  %tmp_373 = insertelement <4 x float> undef, float %tmp_372, i32 0
  %tmp_374 = shufflevector <4 x float> %tmp_373, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_374, <4 x float>* %y, align 16
  %tmp_375 = load <4 x float>* %y, align 16
  %tmp_376 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_375
  %tmp_377 = load <4 x float>* %y, align 16
  %tmp_378 = load <4 x float>* %x, align 16
  %tmp_379 = load <4 x float>* %x, align 16
  %tmp_380 = load <4 x float>* %x0, align 16
  %tmp_381 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_378, <4 x float> %tmp_379, <4 x float> %tmp_380)
  %tmp_382 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_376, <4 x float> %tmp_377, i32 %tmp_381)
  %tmp_383 = sitofp i32 %tmp_382 to float
  %tmp_384 = insertelement <4 x float> undef, float %tmp_383, i32 0
  %tmp_385 = shufflevector <4 x float> %tmp_384, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_385, <4 x float>* %tmp, align 16
  %tmp_386 = load <4 x float>* %x, align 16
  %tmp_387 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_386
  %tmp_388 = load <4 x float>* %y, align 16
  %tmp_389 = load <4 x float>* %y0, align 16
  %tmp_390 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_387, <4 x float> %tmp_388, <4 x float> %tmp_389)
  %tmp_391 = sitofp i32 %tmp_390 to float
  %tmp_392 = insertelement <4 x float> undef, float %tmp_391, i32 0
  %tmp_393 = shufflevector <4 x float> %tmp_392, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_393, <4 x float>* %y, align 16
  %tmp_394 = load <4 x float>* %y, align 16
  %tmp_395 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_394
  %tmp_396 = load <4 x float>* %y, align 16
  %tmp_397 = load <4 x float>* %tmp, align 16
  %tmp_398 = load <4 x float>* %tmp, align 16
  %tmp_399 = load <4 x float>* %x0, align 16
  %tmp_400 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_397, <4 x float> %tmp_398, <4 x float> %tmp_399)
  %tmp_401 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_395, <4 x float> %tmp_396, i32 %tmp_400)
  %tmp_402 = sitofp i32 %tmp_401 to float
  %tmp_403 = insertelement <4 x float> undef, float %tmp_402, i32 0
  %tmp_404 = shufflevector <4 x float> %tmp_403, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_404, <4 x float>* %x, align 16
  %tmp_405 = load <4 x float>* %tmp, align 16
  %tmp_406 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_405
  %tmp_407 = load <4 x float>* %y, align 16
  %tmp_408 = load <4 x float>* %y0, align 16
  %tmp_409 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_406, <4 x float> %tmp_407, <4 x float> %tmp_408)
  %tmp_410 = sitofp i32 %tmp_409 to float
  %tmp_411 = insertelement <4 x float> undef, float %tmp_410, i32 0
  %tmp_412 = shufflevector <4 x float> %tmp_411, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_412, <4 x float>* %y, align 16
  %tmp_413 = load <4 x float>* %y, align 16
  %tmp_414 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_413
  %tmp_415 = load <4 x float>* %y, align 16
  %tmp_416 = load <4 x float>* %x, align 16
  %tmp_417 = load <4 x float>* %x, align 16
  %tmp_418 = load <4 x float>* %x0, align 16
  %tmp_419 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_416, <4 x float> %tmp_417, <4 x float> %tmp_418)
  %tmp_420 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_414, <4 x float> %tmp_415, i32 %tmp_419)
  %tmp_421 = sitofp i32 %tmp_420 to float
  %tmp_422 = insertelement <4 x float> undef, float %tmp_421, i32 0
  %tmp_423 = shufflevector <4 x float> %tmp_422, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_423, <4 x float>* %tmp, align 16
  %tmp_424 = load <4 x float>* %x, align 16
  %tmp_425 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_424
  %tmp_426 = load <4 x float>* %y, align 16
  %tmp_427 = load <4 x float>* %y0, align 16
  %tmp_428 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_425, <4 x float> %tmp_426, <4 x float> %tmp_427)
  %tmp_429 = sitofp i32 %tmp_428 to float
  %tmp_430 = insertelement <4 x float> undef, float %tmp_429, i32 0
  %tmp_431 = shufflevector <4 x float> %tmp_430, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_431, <4 x float>* %y, align 16
  %tmp_432 = load <4 x float>* %y, align 16
  %tmp_433 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_432
  %tmp_434 = load <4 x float>* %y, align 16
  %tmp_435 = load <4 x float>* %tmp, align 16
  %tmp_436 = load <4 x float>* %tmp, align 16
  %tmp_437 = load <4 x float>* %x0, align 16
  %tmp_438 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_435, <4 x float> %tmp_436, <4 x float> %tmp_437)
  %tmp_439 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_433, <4 x float> %tmp_434, i32 %tmp_438)
  %tmp_440 = sitofp i32 %tmp_439 to float
  %tmp_441 = insertelement <4 x float> undef, float %tmp_440, i32 0
  %tmp_442 = shufflevector <4 x float> %tmp_441, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_442, <4 x float>* %x, align 16
  %tmp_443 = load <4 x float>* %tmp, align 16
  %tmp_444 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_443
  %tmp_445 = load <4 x float>* %y, align 16
  %tmp_446 = load <4 x float>* %y0, align 16
  %tmp_447 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_444, <4 x float> %tmp_445, <4 x float> %tmp_446)
  %tmp_448 = sitofp i32 %tmp_447 to float
  %tmp_449 = insertelement <4 x float> undef, float %tmp_448, i32 0
  %tmp_450 = shufflevector <4 x float> %tmp_449, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_450, <4 x float>* %y, align 16
  %tmp_451 = load <4 x float>* %y, align 16
  %tmp_452 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_451
  %tmp_453 = load <4 x float>* %y, align 16
  %tmp_454 = load <4 x float>* %x, align 16
  %tmp_455 = load <4 x float>* %x, align 16
  %tmp_456 = load <4 x float>* %x0, align 16
  %tmp_457 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_454, <4 x float> %tmp_455, <4 x float> %tmp_456)
  %tmp_458 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_452, <4 x float> %tmp_453, i32 %tmp_457)
  %tmp_459 = sitofp i32 %tmp_458 to float
  %tmp_460 = insertelement <4 x float> undef, float %tmp_459, i32 0
  %tmp_461 = shufflevector <4 x float> %tmp_460, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_461, <4 x float>* %tmp, align 16
  %tmp_462 = load <4 x float>* %x, align 16
  %tmp_463 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_462
  %tmp_464 = load <4 x float>* %y, align 16
  %tmp_465 = load <4 x float>* %y0, align 16
  %tmp_466 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_463, <4 x float> %tmp_464, <4 x float> %tmp_465)
  %tmp_467 = sitofp i32 %tmp_466 to float
  %tmp_468 = insertelement <4 x float> undef, float %tmp_467, i32 0
  %tmp_469 = shufflevector <4 x float> %tmp_468, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_469, <4 x float>* %y, align 16
  %tmp_470 = load <4 x float>* %y, align 16
  %tmp_471 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_470
  %tmp_472 = load <4 x float>* %y, align 16
  %tmp_473 = load <4 x float>* %tmp, align 16
  %tmp_474 = load <4 x float>* %tmp, align 16
  %tmp_475 = load <4 x float>* %x0, align 16
  %tmp_476 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_473, <4 x float> %tmp_474, <4 x float> %tmp_475)
  %tmp_477 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_471, <4 x float> %tmp_472, i32 %tmp_476)
  %tmp_478 = sitofp i32 %tmp_477 to float
  %tmp_479 = insertelement <4 x float> undef, float %tmp_478, i32 0
  %tmp_480 = shufflevector <4 x float> %tmp_479, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_480, <4 x float>* %x, align 16
  %tmp_481 = load <4 x float>* %tmp, align 16
  %tmp_482 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_481
  %tmp_483 = load <4 x float>* %y, align 16
  %tmp_484 = load <4 x float>* %y0, align 16
  %tmp_485 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_482, <4 x float> %tmp_483, <4 x float> %tmp_484)
  %tmp_486 = sitofp i32 %tmp_485 to float
  %tmp_487 = insertelement <4 x float> undef, float %tmp_486, i32 0
  %tmp_488 = shufflevector <4 x float> %tmp_487, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_488, <4 x float>* %y, align 16
  %tmp_489 = load <4 x float>* %x, align 16
  %tmp_490 = extractelement <4 x float> %tmp_489, i32 0
  %tmp_491 = load <4 x float>* %x, align 16
  %tmp_492 = extractelement <4 x float> %tmp_491, i32 0
  %tmp_493 = load <4 x float>* %y, align 16
  %tmp_494 = extractelement <4 x float> %tmp_493, i32 0
  %tmp_495 = load <4 x float>* %y, align 16
  %tmp_496 = extractelement <4 x float> %tmp_495, i32 0
  %tmp_497 = fmul float %tmp_494, %tmp_496
  %tmp_498 = call float @llvm.fmuladd.f32(float %tmp_490, float %tmp_492, float %tmp_497)
  %tmp_499 = fcmp ole float %tmp_498, 4.000000e+00
  %tmp_500 = zext i1 %tmp_499 to i32
  %tmp_501 = load <4 x i32>* %stay, align 16
  %tmp_502 = insertelement <4 x i32> %tmp_501, i32 %tmp_500, i32 0
  store <4 x i32> %tmp_502, <4 x i32>* %stay, align 16
  %tmp_503 = load <4 x float>* %x, align 16
  %tmp_504 = extractelement <4 x float> %tmp_503, i32 1
  %tmp_505 = load <4 x float>* %x, align 16
  %tmp_506 = extractelement <4 x float> %tmp_505, i32 1
  %tmp_507 = load <4 x float>* %y, align 16
  %tmp_508 = extractelement <4 x float> %tmp_507, i32 1
  %tmp_509 = load <4 x float>* %y, align 16
  %tmp_510 = extractelement <4 x float> %tmp_509, i32 1
  %tmp_511 = fmul float %tmp_508, %tmp_510
  %tmp_512 = call float @llvm.fmuladd.f32(float %tmp_504, float %tmp_506, float %tmp_511)
  %tmp_513 = fcmp ole float %tmp_512, 4.000000e+00
  %tmp_514 = zext i1 %tmp_513 to i32
  %tmp_515 = load <4 x i32>* %stay, align 16
  %tmp_516 = insertelement <4 x i32> %tmp_515, i32 %tmp_514, i32 1
  store <4 x i32> %tmp_516, <4 x i32>* %stay, align 16
  %tmp_517 = load <4 x float>* %x, align 16
  %tmp_518 = extractelement <4 x float> %tmp_517, i32 2
  %tmp_519 = load <4 x float>* %x, align 16
  %tmp_520 = extractelement <4 x float> %tmp_519, i32 2
  %tmp_521 = load <4 x float>* %y, align 16
  %tmp_522 = extractelement <4 x float> %tmp_521, i32 2
  %tmp_523 = load <4 x float>* %y, align 16
  %tmp_524 = extractelement <4 x float> %tmp_523, i32 2
  %tmp_525 = fmul float %tmp_522, %tmp_524
  %tmp_526 = call float @llvm.fmuladd.f32(float %tmp_518, float %tmp_520, float %tmp_525)
  %tmp_527 = fcmp ole float %tmp_526, 4.000000e+00
  %tmp_528 = zext i1 %tmp_527 to i32
  %tmp_529 = load <4 x i32>* %stay, align 16
  %tmp_530 = insertelement <4 x i32> %tmp_529, i32 %tmp_528, i32 2
  store <4 x i32> %tmp_530, <4 x i32>* %stay, align 16
  %tmp_531 = load <4 x float>* %x, align 16
  %tmp_532 = extractelement <4 x float> %tmp_531, i32 3
  %tmp_533 = load <4 x float>* %x, align 16
  %tmp_534 = extractelement <4 x float> %tmp_533, i32 3
  %tmp_535 = load <4 x float>* %y, align 16
  %tmp_536 = extractelement <4 x float> %tmp_535, i32 3
  %tmp_537 = load <4 x float>* %y, align 16
  %tmp_538 = extractelement <4 x float> %tmp_537, i32 3
  %tmp_539 = fmul float %tmp_536, %tmp_538
  %tmp_540 = call float @llvm.fmuladd.f32(float %tmp_532, float %tmp_534, float %tmp_539)
  %tmp_541 = fcmp ole float %tmp_540, 4.000000e+00
  %tmp_542 = zext i1 %tmp_541 to i32
  %tmp_543 = load <4 x i32>* %stay, align 16
  %tmp_544 = insertelement <4 x i32> %tmp_543, i32 %tmp_542, i32 3
  store <4 x i32> %tmp_544, <4 x i32>* %stay, align 16
  %tmp_545 = load <4 x i32>* %stay, align 16
  %tmp_546 = extractelement <4 x i32> %tmp_545, i32 0
  %tmp_547 = icmp ne i32 %tmp_546, 0
  br i1 %tmp_547, label %tmp_548, label %tmp_551

tmp_548:                                     ; preds = %tmp_182
  %tmp_549 = load <4 x float>* %x, align 16
  %tmp_550 = extractelement <4 x float> %tmp_549, i32 0
  br label %tmp_554

tmp_551:                                     ; preds = %tmp_182
  %tmp_552 = load <4 x float>* %savx, align 16
  %tmp_553 = extractelement <4 x float> %tmp_552, i32 0
  br label %tmp_554

tmp_554:                                     ; preds = %tmp_551, %tmp_548
  %tmp_555 = phi float [ %tmp_550, %tmp_548 ], [ %tmp_553, %tmp_551 ]
  %tmp_556 = load <4 x float>* %savx, align 16
  %tmp_557 = insertelement <4 x float> %tmp_556, float %tmp_555, i32 0
  store <4 x float> %tmp_557, <4 x float>* %savx, align 16
  %tmp_558 = load <4 x i32>* %stay, align 16
  %tmp_559 = extractelement <4 x i32> %tmp_558, i32 1
  %tmp_560 = icmp ne i32 %tmp_559, 0
  br i1 %tmp_560, label %tmp_561, label %tmp_564

tmp_561:                                     ; preds = %tmp_554
  %tmp_562 = load <4 x float>* %x, align 16
  %tmp_563 = extractelement <4 x float> %tmp_562, i32 1
  br label %tmp_567

tmp_564:                                     ; preds = %tmp_554
  %tmp_565 = load <4 x float>* %savx, align 16
  %tmp_566 = extractelement <4 x float> %tmp_565, i32 1
  br label %tmp_567

tmp_567:                                     ; preds = %tmp_564, %tmp_561
  %tmp_568 = phi float [ %tmp_563, %tmp_561 ], [ %tmp_566, %tmp_564 ]
  %tmp_569 = load <4 x float>* %savx, align 16
  %tmp_570 = insertelement <4 x float> %tmp_569, float %tmp_568, i32 1
  store <4 x float> %tmp_570, <4 x float>* %savx, align 16
  %tmp_571 = load <4 x i32>* %stay, align 16
  %tmp_572 = extractelement <4 x i32> %tmp_571, i32 2
  %tmp_573 = icmp ne i32 %tmp_572, 0
  br i1 %tmp_573, label %tmp_574, label %tmp_577

tmp_574:                                     ; preds = %tmp_567
  %tmp_575 = load <4 x float>* %x, align 16
  %tmp_576 = extractelement <4 x float> %tmp_575, i32 2
  br label %tmp_580

tmp_577:                                     ; preds = %tmp_567
  %tmp_578 = load <4 x float>* %savx, align 16
  %tmp_579 = extractelement <4 x float> %tmp_578, i32 2
  br label %tmp_580

tmp_580:                                     ; preds = %tmp_577, %tmp_574
  %tmp_581 = phi float [ %tmp_576, %tmp_574 ], [ %tmp_579, %tmp_577 ]
  %tmp_582 = load <4 x float>* %savx, align 16
  %tmp_583 = insertelement <4 x float> %tmp_582, float %tmp_581, i32 2
  store <4 x float> %tmp_583, <4 x float>* %savx, align 16
  %tmp_584 = load <4 x i32>* %stay, align 16
  %tmp_585 = extractelement <4 x i32> %tmp_584, i32 3
  %tmp_586 = icmp ne i32 %tmp_585, 0
  br i1 %tmp_586, label %tmp_587, label %tmp_590

tmp_587:                                     ; preds = %tmp_580
  %tmp_588 = load <4 x float>* %x, align 16
  %tmp_589 = extractelement <4 x float> %tmp_588, i32 3
  br label %tmp_593

tmp_590:                                     ; preds = %tmp_580
  %tmp_591 = load <4 x float>* %savx, align 16
  %tmp_592 = extractelement <4 x float> %tmp_591, i32 3
  br label %tmp_593

tmp_593:                                     ; preds = %tmp_590, %tmp_587
  %tmp_594 = phi float [ %tmp_589, %tmp_587 ], [ %tmp_592, %tmp_590 ]
  %tmp_595 = load <4 x float>* %savx, align 16
  %tmp_596 = insertelement <4 x float> %tmp_595, float %tmp_594, i32 3
  store <4 x float> %tmp_596, <4 x float>* %savx, align 16
  %tmp_597 = load <4 x i32>* %stay, align 16
  %tmp_598 = extractelement <4 x i32> %tmp_597, i32 0
  %tmp_599 = icmp ne i32 %tmp_598, 0
  br i1 %tmp_599, label %tmp_600, label %tmp_603

tmp_600:                                     ; preds = %tmp_593
  %tmp_601 = load <4 x float>* %y, align 16
  %tmp_602 = extractelement <4 x float> %tmp_601, i32 0
  br label %tmp_606

tmp_603:                                     ; preds = %tmp_593
  %tmp_604 = load <4 x float>* %savy, align 16
  %tmp_605 = extractelement <4 x float> %tmp_604, i32 0
  br label %tmp_606

tmp_606:                                     ; preds = %tmp_603, %tmp_600
  %tmp_607 = phi float [ %tmp_602, %tmp_600 ], [ %tmp_605, %tmp_603 ]
  %tmp_608 = load <4 x float>* %savy, align 16
  %tmp_609 = insertelement <4 x float> %tmp_608, float %tmp_607, i32 0
  store <4 x float> %tmp_609, <4 x float>* %savy, align 16
  %tmp_610 = load <4 x i32>* %stay, align 16
  %tmp_611 = extractelement <4 x i32> %tmp_610, i32 1
  %tmp_612 = icmp ne i32 %tmp_611, 0
  br i1 %tmp_612, label %tmp_613, label %tmp_616

tmp_613:                                     ; preds = %tmp_606
  %tmp_614 = load <4 x float>* %y, align 16
  %tmp_615 = extractelement <4 x float> %tmp_614, i32 1
  br label %tmp_619

tmp_616:                                     ; preds = %tmp_606
  %tmp_617 = load <4 x float>* %savy, align 16
  %tmp_618 = extractelement <4 x float> %tmp_617, i32 1
  br label %tmp_619

tmp_619:                                     ; preds = %tmp_616, %tmp_613
  %tmp_620 = phi float [ %tmp_615, %tmp_613 ], [ %tmp_618, %tmp_616 ]
  %tmp_621 = load <4 x float>* %savy, align 16
  %tmp_622 = insertelement <4 x float> %tmp_621, float %tmp_620, i32 1
  store <4 x float> %tmp_622, <4 x float>* %savy, align 16
  %tmp_623 = load <4 x i32>* %stay, align 16
  %tmp_624 = extractelement <4 x i32> %tmp_623, i32 2
  %tmp_625 = icmp ne i32 %tmp_624, 0
  br i1 %tmp_625, label %tmp_626, label %tmp_629

tmp_626:                                     ; preds = %tmp_619
  %tmp_627 = load <4 x float>* %y, align 16
  %tmp_628 = extractelement <4 x float> %tmp_627, i32 2
  br label %tmp_632

tmp_629:                                     ; preds = %tmp_619
  %tmp_630 = load <4 x float>* %savy, align 16
  %tmp_631 = extractelement <4 x float> %tmp_630, i32 2
  br label %tmp_632

tmp_632:                                     ; preds = %tmp_629, %tmp_626
  %tmp_633 = phi float [ %tmp_628, %tmp_626 ], [ %tmp_631, %tmp_629 ]
  %tmp_634 = load <4 x float>* %savy, align 16
  %tmp_635 = insertelement <4 x float> %tmp_634, float %tmp_633, i32 2
  store <4 x float> %tmp_635, <4 x float>* %savy, align 16
  %tmp_636 = load <4 x i32>* %stay, align 16
  %tmp_637 = extractelement <4 x i32> %tmp_636, i32 3
  %tmp_638 = icmp ne i32 %tmp_637, 0
  br i1 %tmp_638, label %tmp_639, label %tmp_642

tmp_639:                                     ; preds = %tmp_632
  %tmp_640 = load <4 x float>* %y, align 16
  %tmp_641 = extractelement <4 x float> %tmp_640, i32 3
  br label %tmp_645

tmp_642:                                     ; preds = %tmp_632
  %tmp_643 = load <4 x float>* %savy, align 16
  %tmp_644 = extractelement <4 x float> %tmp_643, i32 3
  br label %tmp_645

tmp_645:                                     ; preds = %tmp_642, %tmp_639
  %tmp_646 = phi float [ %tmp_641, %tmp_639 ], [ %tmp_644, %tmp_642 ]
  %tmp_647 = load <4 x float>* %savy, align 16
  %tmp_648 = insertelement <4 x float> %tmp_647, float %tmp_646, i32 3
  store <4 x float> %tmp_648, <4 x float>* %savy, align 16
  %tmp_649 = load <4 x i32>* %stay, align 16
  %tmp_650 = mul <4 x i32> %tmp_649, <i32 16, i32 16, i32 16, i32 16>
  %tmp_651 = load <4 x i32>* %ccount, align 16
  %tmp_652 = add <4 x i32> %tmp_651, %tmp_650
  store <4 x i32> %tmp_652, <4 x i32>* %ccount, align 16
  br label %tmp_653

tmp_653:                                     ; preds = %tmp_645
  %tmp_654 = load i32* %iter, align 4
  %tmp_655 = add i32 %tmp_654, 16
  store i32 %tmp_655, i32* %iter, align 4
  br label %tmp_165

tmp_656:                                     ; preds = %tmp_178, %tmp_165
  %tmp_657 = load <4 x i32>* %stay, align 16
  %tmp_658 = extractelement <4 x i32> %tmp_657, i32 0
  %tmp_659 = load <4 x i32>* %stay, align 16
  %tmp_660 = extractelement <4 x i32> %tmp_659, i32 1
  %tmp_661 = and i32 %tmp_658, %tmp_660
  %tmp_662 = load <4 x i32>* %stay, align 16
  %tmp_663 = extractelement <4 x i32> %tmp_662, i32 2
  %tmp_664 = and i32 %tmp_661, %tmp_663
  %tmp_665 = load <4 x i32>* %stay, align 16
  %tmp_666 = extractelement <4 x i32> %tmp_665, i32 3
  %tmp_667 = and i32 %tmp_664, %tmp_666
  %tmp_668 = icmp ne i32 %tmp_667, 0
  br i1 %tmp_668, label %tmp_905, label %tmp_669

tmp_669:                                     ; preds = %tmp_656
  store i32 16, i32* %iter, align 4
  br label %tmp_670

tmp_670:                                     ; preds = %tmp_902, %tmp_669
  %tmp_671 = load <4 x float>* %savx, align 16
  store <4 x float> %tmp_671, <4 x float>* %x, align 16
  %tmp_672 = load <4 x float>* %savy, align 16
  store <4 x float> %tmp_672, <4 x float>* %y, align 16
  %tmp_673 = load <4 x float>* %x, align 16
  %tmp_674 = extractelement <4 x float> %tmp_673, i32 0
  %tmp_675 = load <4 x float>* %x, align 16
  %tmp_676 = extractelement <4 x float> %tmp_675, i32 0
  %tmp_677 = load <4 x float>* %y, align 16
  %tmp_678 = extractelement <4 x float> %tmp_677, i32 0
  %tmp_679 = load <4 x float>* %y, align 16
  %tmp_680 = extractelement <4 x float> %tmp_679, i32 0
  %tmp_681 = fmul float %tmp_678, %tmp_680
  %tmp_682 = call float @llvm.fmuladd.f32(float %tmp_674, float %tmp_676, float %tmp_681)
  %tmp_683 = fcmp ole float %tmp_682, 4.000000e+00
  br i1 %tmp_683, label %tmp_684, label %tmp_689

tmp_684:                                     ; preds = %tmp_670
  %tmp_685 = load <4 x i32>* %ccount, align 16
  %tmp_686 = extractelement <4 x i32> %tmp_685, i32 0
  %tmp_687 = load i32* %tmp_6, align 4
  %tmp_688 = icmp ult i32 %tmp_686, %tmp_687
  br label %tmp_689

tmp_689:                                     ; preds = %tmp_684, %tmp_670
  %tmp_690 = phi i1 [ false, %tmp_670 ], [ %tmp_688, %tmp_684 ]
  %tmp_691 = zext i1 %tmp_690 to i32
  %tmp_692 = load <4 x i32>* %stay, align 16
  %tmp_693 = insertelement <4 x i32> %tmp_692, i32 %tmp_691, i32 0
  store <4 x i32> %tmp_693, <4 x i32>* %stay, align 16
  %tmp_694 = load <4 x float>* %x, align 16
  %tmp_695 = extractelement <4 x float> %tmp_694, i32 1
  %tmp_696 = load <4 x float>* %x, align 16
  %tmp_697 = extractelement <4 x float> %tmp_696, i32 1
  %tmp_698 = load <4 x float>* %y, align 16
  %tmp_699 = extractelement <4 x float> %tmp_698, i32 1
  %tmp_700 = load <4 x float>* %y, align 16
  %tmp_701 = extractelement <4 x float> %tmp_700, i32 1
  %tmp_702 = fmul float %tmp_699, %tmp_701
  %tmp_703 = call float @llvm.fmuladd.f32(float %tmp_695, float %tmp_697, float %tmp_702)
  %tmp_704 = fcmp ole float %tmp_703, 4.000000e+00
  br i1 %tmp_704, label %tmp_705, label %tmp_710

tmp_705:                                     ; preds = %tmp_689
  %tmp_706 = load <4 x i32>* %ccount, align 16
  %tmp_707 = extractelement <4 x i32> %tmp_706, i32 1
  %tmp_708 = load i32* %tmp_6, align 4
  %tmp_709 = icmp ult i32 %tmp_707, %tmp_708
  br label %tmp_710

tmp_710:                                     ; preds = %tmp_705, %tmp_689
  %tmp_711 = phi i1 [ false, %tmp_689 ], [ %tmp_709, %tmp_705 ]
  %tmp_712 = zext i1 %tmp_711 to i32
  %tmp_713 = load <4 x i32>* %stay, align 16
  %tmp_714 = insertelement <4 x i32> %tmp_713, i32 %tmp_712, i32 1
  store <4 x i32> %tmp_714, <4 x i32>* %stay, align 16
  %tmp_715 = load <4 x float>* %x, align 16
  %tmp_716 = extractelement <4 x float> %tmp_715, i32 2
  %tmp_717 = load <4 x float>* %x, align 16
  %tmp_718 = extractelement <4 x float> %tmp_717, i32 2
  %tmp_719 = load <4 x float>* %y, align 16
  %tmp_720 = extractelement <4 x float> %tmp_719, i32 2
  %tmp_721 = load <4 x float>* %y, align 16
  %tmp_722 = extractelement <4 x float> %tmp_721, i32 2
  %tmp_723 = fmul float %tmp_720, %tmp_722
  %tmp_724 = call float @llvm.fmuladd.f32(float %tmp_716, float %tmp_718, float %tmp_723)
  %tmp_725 = fcmp ole float %tmp_724, 4.000000e+00
  br i1 %tmp_725, label %tmp_726, label %tmp_731

tmp_726:                                     ; preds = %tmp_710
  %tmp_727 = load <4 x i32>* %ccount, align 16
  %tmp_728 = extractelement <4 x i32> %tmp_727, i32 2
  %tmp_729 = load i32* %tmp_6, align 4
  %tmp_730 = icmp ult i32 %tmp_728, %tmp_729
  br label %tmp_731

tmp_731:                                     ; preds = %tmp_726, %tmp_710
  %tmp_732 = phi i1 [ false, %tmp_710 ], [ %tmp_730, %tmp_726 ]
  %tmp_733 = zext i1 %tmp_732 to i32
  %tmp_734 = load <4 x i32>* %stay, align 16
  %tmp_735 = insertelement <4 x i32> %tmp_734, i32 %tmp_733, i32 2
  store <4 x i32> %tmp_735, <4 x i32>* %stay, align 16
  %tmp_736 = load <4 x float>* %x, align 16
  %tmp_737 = extractelement <4 x float> %tmp_736, i32 3
  %tmp_738 = load <4 x float>* %x, align 16
  %tmp_739 = extractelement <4 x float> %tmp_738, i32 3
  %tmp_740 = load <4 x float>* %y, align 16
  %tmp_741 = extractelement <4 x float> %tmp_740, i32 3
  %tmp_742 = load <4 x float>* %y, align 16
  %tmp_743 = extractelement <4 x float> %tmp_742, i32 3
  %tmp_744 = fmul float %tmp_741, %tmp_743
  %tmp_745 = call float @llvm.fmuladd.f32(float %tmp_737, float %tmp_739, float %tmp_744)
  %tmp_746 = fcmp ole float %tmp_745, 4.000000e+00
  br i1 %tmp_746, label %tmp_747, label %tmp_752

tmp_747:                                     ; preds = %tmp_731
  %tmp_748 = load <4 x i32>* %ccount, align 16
  %tmp_749 = extractelement <4 x i32> %tmp_748, i32 3
  %tmp_750 = load i32* %tmp_6, align 4
  %tmp_751 = icmp ult i32 %tmp_749, %tmp_750
  br label %tmp_752

tmp_752:                                     ; preds = %tmp_747, %tmp_731
  %tmp_753 = phi i1 [ false, %tmp_731 ], [ %tmp_751, %tmp_747 ]
  %tmp_754 = zext i1 %tmp_753 to i32
  %tmp_755 = load <4 x i32>* %stay, align 16
  %tmp_756 = insertelement <4 x i32> %tmp_755, i32 %tmp_754, i32 3
  store <4 x i32> %tmp_756, <4 x i32>* %stay, align 16
  %tmp_757 = load <4 x float>* %x, align 16
  store <4 x float> %tmp_757, <4 x float>* %tmp, align 16
  %tmp_758 = load <4 x float>* %y, align 16
  %tmp_759 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_758
  %tmp_760 = load <4 x float>* %y, align 16
  %tmp_761 = load <4 x float>* %x, align 16
  %tmp_762 = load <4 x float>* %x, align 16
  %tmp_763 = load <4 x float>* %x0, align 16
  %tmp_764 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_761, <4 x float> %tmp_762, <4 x float> %tmp_763)
  %tmp_765 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_759, <4 x float> %tmp_760, i32 %tmp_764)
  %tmp_766 = sitofp i32 %tmp_765 to float
  %tmp_767 = insertelement <4 x float> undef, float %tmp_766, i32 0
  %tmp_768 = shufflevector <4 x float> %tmp_767, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_768, <4 x float>* %x, align 16
  %tmp_769 = load <4 x float>* %tmp, align 16
  %tmp_770 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_769
  %tmp_771 = load <4 x float>* %y, align 16
  %tmp_772 = load <4 x float>* %y0, align 16
  %tmp_773 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_770, <4 x float> %tmp_771, <4 x float> %tmp_772)
  %tmp_774 = sitofp i32 %tmp_773 to float
  %tmp_775 = insertelement <4 x float> undef, float %tmp_774, i32 0
  %tmp_776 = shufflevector <4 x float> %tmp_775, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %tmp_776, <4 x float>* %y, align 16
  %tmp_777 = load <4 x i32>* %stay, align 16
  %tmp_778 = load <4 x i32>* %ccount, align 16
  %tmp_779 = add <4 x i32> %tmp_778, %tmp_777
  store <4 x i32> %tmp_779, <4 x i32>* %ccount, align 16
  %tmp_780 = load i32* %iter, align 4
  %tmp_781 = add i32 %tmp_780, -1
  store i32 %tmp_781, i32* %iter, align 4
  %tmp_782 = load <4 x i32>* %stay, align 16
  %tmp_783 = extractelement <4 x i32> %tmp_782, i32 0
  %tmp_784 = icmp ne i32 %tmp_783, 0
  br i1 %tmp_784, label %tmp_785, label %tmp_788

tmp_785:                                     ; preds = %tmp_752
  %tmp_786 = load <4 x float>* %x, align 16
  %tmp_787 = extractelement <4 x float> %tmp_786, i32 0
  br label %tmp_791

tmp_788:                                     ; preds = %tmp_752
  %tmp_789 = load <4 x float>* %savx, align 16
  %tmp_790 = extractelement <4 x float> %tmp_789, i32 0
  br label %tmp_791

tmp_791:                                     ; preds = %tmp_788, %tmp_785
  %tmp_792 = phi float [ %tmp_787, %tmp_785 ], [ %tmp_790, %tmp_788 ]
  %tmp_793 = load <4 x float>* %savx, align 16
  %tmp_794 = insertelement <4 x float> %tmp_793, float %tmp_792, i32 0
  store <4 x float> %tmp_794, <4 x float>* %savx, align 16
  %tmp_795 = load <4 x i32>* %stay, align 16
  %tmp_796 = extractelement <4 x i32> %tmp_795, i32 1
  %tmp_797 = icmp ne i32 %tmp_796, 0
  br i1 %tmp_797, label %tmp_798, label %tmp_801

tmp_798:                                     ; preds = %tmp_791
  %tmp_799 = load <4 x float>* %x, align 16
  %tmp_800 = extractelement <4 x float> %tmp_799, i32 1
  br label %tmp_804

tmp_801:                                     ; preds = %tmp_791
  %tmp_802 = load <4 x float>* %savx, align 16
  %tmp_803 = extractelement <4 x float> %tmp_802, i32 1
  br label %tmp_804

tmp_804:                                     ; preds = %tmp_801, %tmp_798
  %tmp_805 = phi float [ %tmp_800, %tmp_798 ], [ %tmp_803, %tmp_801 ]
  %tmp_806 = load <4 x float>* %savx, align 16
  %tmp_807 = insertelement <4 x float> %tmp_806, float %tmp_805, i32 1
  store <4 x float> %tmp_807, <4 x float>* %savx, align 16
  %tmp_808 = load <4 x i32>* %stay, align 16
  %tmp_809 = extractelement <4 x i32> %tmp_808, i32 2
  %tmp_810 = icmp ne i32 %tmp_809, 0
  br i1 %tmp_810, label %tmp_811, label %tmp_814

tmp_811:                                     ; preds = %tmp_804
  %tmp_812 = load <4 x float>* %x, align 16
  %tmp_813 = extractelement <4 x float> %tmp_812, i32 2
  br label %tmp_817

tmp_814:                                     ; preds = %tmp_804
  %tmp_815 = load <4 x float>* %savx, align 16
  %tmp_816 = extractelement <4 x float> %tmp_815, i32 2
  br label %tmp_817

tmp_817:                                     ; preds = %tmp_814, %tmp_811
  %tmp_818 = phi float [ %tmp_813, %tmp_811 ], [ %tmp_816, %tmp_814 ]
  %tmp_819 = load <4 x float>* %savx, align 16
  %tmp_820 = insertelement <4 x float> %tmp_819, float %tmp_818, i32 2
  store <4 x float> %tmp_820, <4 x float>* %savx, align 16
  %tmp_821 = load <4 x i32>* %stay, align 16
  %tmp_822 = extractelement <4 x i32> %tmp_821, i32 3
  %tmp_823 = icmp ne i32 %tmp_822, 0
  br i1 %tmp_823, label %tmp_824, label %tmp_827

tmp_824:                                     ; preds = %tmp_817
  %tmp_825 = load <4 x float>* %x, align 16
  %tmp_826 = extractelement <4 x float> %tmp_825, i32 3
  br label %tmp_830

tmp_827:                                     ; preds = %tmp_817
  %tmp_828 = load <4 x float>* %savx, align 16
  %tmp_829 = extractelement <4 x float> %tmp_828, i32 3
  br label %tmp_830

tmp_830:                                     ; preds = %tmp_827, %tmp_824
  %tmp_831 = phi float [ %tmp_826, %tmp_824 ], [ %tmp_829, %tmp_827 ]
  %tmp_832 = load <4 x float>* %savx, align 16
  %tmp_833 = insertelement <4 x float> %tmp_832, float %tmp_831, i32 3
  store <4 x float> %tmp_833, <4 x float>* %savx, align 16
  %tmp_834 = load <4 x i32>* %stay, align 16
  %tmp_835 = extractelement <4 x i32> %tmp_834, i32 0
  %tmp_836 = icmp ne i32 %tmp_835, 0
  br i1 %tmp_836, label %tmp_837, label %tmp_840

tmp_837:                                     ; preds = %tmp_830
  %tmp_838 = load <4 x float>* %y, align 16
  %tmp_839 = extractelement <4 x float> %tmp_838, i32 0
  br label %tmp_843

tmp_840:                                     ; preds = %tmp_830
  %tmp_841 = load <4 x float>* %savy, align 16
  %tmp_842 = extractelement <4 x float> %tmp_841, i32 0
  br label %tmp_843

tmp_843:                                     ; preds = %tmp_840, %tmp_837
  %tmp_844 = phi float [ %tmp_839, %tmp_837 ], [ %tmp_842, %tmp_840 ]
  %tmp_845 = load <4 x float>* %savy, align 16
  %tmp_846 = insertelement <4 x float> %tmp_845, float %tmp_844, i32 0
  store <4 x float> %tmp_846, <4 x float>* %savy, align 16
  %tmp_847 = load <4 x i32>* %stay, align 16
  %tmp_848 = extractelement <4 x i32> %tmp_847, i32 1
  %tmp_849 = icmp ne i32 %tmp_848, 0
  br i1 %tmp_849, label %tmp_850, label %tmp_853

tmp_850:                                     ; preds = %tmp_843
  %tmp_851 = load <4 x float>* %y, align 16
  %tmp_852 = extractelement <4 x float> %tmp_851, i32 1
  br label %tmp_856

tmp_853:                                     ; preds = %tmp_843
  %tmp_854 = load <4 x float>* %savy, align 16
  %tmp_855 = extractelement <4 x float> %tmp_854, i32 1
  br label %tmp_856

tmp_856:                                     ; preds = %tmp_853, %tmp_850
  %tmp_857 = phi float [ %tmp_852, %tmp_850 ], [ %tmp_855, %tmp_853 ]
  %tmp_858 = load <4 x float>* %savy, align 16
  %tmp_859 = insertelement <4 x float> %tmp_858, float %tmp_857, i32 1
  store <4 x float> %tmp_859, <4 x float>* %savy, align 16
  %tmp_860 = load <4 x i32>* %stay, align 16
  %tmp_861 = extractelement <4 x i32> %tmp_860, i32 2
  %tmp_862 = icmp ne i32 %tmp_861, 0
  br i1 %tmp_862, label %tmp_863, label %tmp_866

tmp_863:                                     ; preds = %tmp_856
  %tmp_864 = load <4 x float>* %y, align 16
  %tmp_865 = extractelement <4 x float> %tmp_864, i32 2
  br label %tmp_869

tmp_866:                                     ; preds = %tmp_856
  %tmp_867 = load <4 x float>* %savy, align 16
  %tmp_868 = extractelement <4 x float> %tmp_867, i32 2
  br label %tmp_869

tmp_869:                                     ; preds = %tmp_866, %tmp_863
  %tmp_870 = phi float [ %tmp_865, %tmp_863 ], [ %tmp_868, %tmp_866 ]
  %tmp_871 = load <4 x float>* %savy, align 16
  %tmp_872 = insertelement <4 x float> %tmp_871, float %tmp_870, i32 2
  store <4 x float> %tmp_872, <4 x float>* %savy, align 16
  %tmp_873 = load <4 x i32>* %stay, align 16
  %tmp_874 = extractelement <4 x i32> %tmp_873, i32 3
  %tmp_875 = icmp ne i32 %tmp_874, 0
  br i1 %tmp_875, label %tmp_876, label %tmp_879

tmp_876:                                     ; preds = %tmp_869
  %tmp_877 = load <4 x float>* %y, align 16
  %tmp_878 = extractelement <4 x float> %tmp_877, i32 3
  br label %tmp_882

tmp_879:                                     ; preds = %tmp_869
  %tmp_880 = load <4 x float>* %savy, align 16
  %tmp_881 = extractelement <4 x float> %tmp_880, i32 3
  br label %tmp_882

tmp_882:                                     ; preds = %tmp_879, %tmp_876
  %tmp_883 = phi float [ %tmp_878, %tmp_876 ], [ %tmp_881, %tmp_879 ]
  %tmp_884 = load <4 x float>* %savy, align 16
  %tmp_885 = insertelement <4 x float> %tmp_884, float %tmp_883, i32 3
  store <4 x float> %tmp_885, <4 x float>* %savy, align 16
  br label %tmp_886

tmp_886:                                     ; preds = %tmp_882
  %tmp_887 = load <4 x i32>* %stay, align 16
  %tmp_888 = extractelement <4 x i32> %tmp_887, i32 0
  %tmp_889 = load <4 x i32>* %stay, align 16
  %tmp_890 = extractelement <4 x i32> %tmp_889, i32 1
  %tmp_891 = or i32 %tmp_888, %tmp_890
  %tmp_892 = load <4 x i32>* %stay, align 16
  %tmp_893 = extractelement <4 x i32> %tmp_892, i32 2
  %tmp_894 = or i32 %tmp_891, %tmp_893
  %tmp_895 = load <4 x i32>* %stay, align 16
  %tmp_896 = extractelement <4 x i32> %tmp_895, i32 3
  %tmp_897 = or i32 %tmp_894, %tmp_896
  %tmp_898 = icmp ne i32 %tmp_897, 0
  br i1 %tmp_898, label %tmp_899, label %tmp_902

tmp_899:                                     ; preds = %tmp_886
  %tmp_900 = load i32* %iter, align 4
  %tmp_901 = icmp ne i32 %tmp_900, 0
  br label %tmp_902

tmp_902:                                     ; preds = %tmp_899, %tmp_886
  %tmp_903 = phi i1 [ false, %tmp_886 ], [ %tmp_901, %tmp_899 ]
  br i1 %tmp_903, label %tmp_670, label %tmp_904

tmp_904:                                     ; preds = %tmp_902
  br label %tmp_905

tmp_905:                                     ; preds = %tmp_904, %tmp_656
  %tmp_906 = load <4 x float>* %savx, align 16
  store <4 x float> %tmp_906, <4 x float>* %x, align 16
  %tmp_907 = load <4 x float>* %savy, align 16
  store <4 x float> %tmp_907, <4 x float>* %y, align 16
  %tmp_908 = load <4 x i32>* %ccount, align 16
  %tmp_909 = call <4 x float> @_Z14convert_float4Dv4_i(<4 x i32> %tmp_908)
  store <4 x float> %tmp_909, <4 x float>* %fc, align 16
  %tmp_910 = load <4 x i32>* %ccount, align 16
  %tmp_911 = extractelement <4 x i32> %tmp_910, i32 0
  %tmp_912 = sitofp i32 %tmp_911 to float
  %tmp_913 = fadd float %tmp_912, 1.000000e+00
  %tmp_914 = load <4 x float>* %x, align 16
  %tmp_915 = extractelement <4 x float> %tmp_914, i32 0
  %tmp_916 = load <4 x float>* %x, align 16
  %tmp_917 = extractelement <4 x float> %tmp_916, i32 0
  %tmp_918 = load <4 x float>* %y, align 16
  %tmp_919 = extractelement <4 x float> %tmp_918, i32 0
  %tmp_920 = load <4 x float>* %y, align 16
  %tmp_921 = extractelement <4 x float> %tmp_920, i32 0
  %tmp_922 = fmul float %tmp_919, %tmp_921
  %tmp_923 = call float @llvm.fmuladd.f32(float %tmp_915, float %tmp_917, float %tmp_922)
  %tmp_924 = call float @llvm.log2.f32(float %tmp_923)
  %tmp_925 = call float @llvm.log2.f32(float %tmp_924)
  %tmp_926 = fsub float %tmp_913, %tmp_925
  %tmp_927 = load <4 x float>* %fc, align 16
  %tmp_928 = insertelement <4 x float> %tmp_927, float %tmp_926, i32 0
  store <4 x float> %tmp_928, <4 x float>* %fc, align 16
  %tmp_929 = load <4 x i32>* %ccount, align 16
  %tmp_930 = extractelement <4 x i32> %tmp_929, i32 1
  %tmp_931 = sitofp i32 %tmp_930 to float
  %tmp_932 = fadd float %tmp_931, 1.000000e+00
  %tmp_933 = load <4 x float>* %x, align 16
  %tmp_934 = extractelement <4 x float> %tmp_933, i32 1
  %tmp_935 = load <4 x float>* %x, align 16
  %tmp_936 = extractelement <4 x float> %tmp_935, i32 1
  %tmp_937 = load <4 x float>* %y, align 16
  %tmp_938 = extractelement <4 x float> %tmp_937, i32 1
  %tmp_939 = load <4 x float>* %y, align 16
  %tmp_940 = extractelement <4 x float> %tmp_939, i32 1
  %tmp_941 = fmul float %tmp_938, %tmp_940
  %tmp_942 = call float @llvm.fmuladd.f32(float %tmp_934, float %tmp_936, float %tmp_941)
  %tmp_943 = call float @llvm.log2.f32(float %tmp_942)
  %tmp_944 = call float @llvm.log2.f32(float %tmp_943)
  %tmp_945 = fsub float %tmp_932, %tmp_944
  %tmp_946 = load <4 x float>* %fc, align 16
  %tmp_947 = insertelement <4 x float> %tmp_946, float %tmp_945, i32 1
  store <4 x float> %tmp_947, <4 x float>* %fc, align 16
  %tmp_948 = load <4 x i32>* %ccount, align 16
  %tmp_949 = extractelement <4 x i32> %tmp_948, i32 2
  %tmp_950 = sitofp i32 %tmp_949 to float
  %tmp_951 = fadd float %tmp_950, 1.000000e+00
  %tmp_952 = load <4 x float>* %x, align 16
  %tmp_953 = extractelement <4 x float> %tmp_952, i32 2
  %tmp_954 = load <4 x float>* %x, align 16
  %tmp_955 = extractelement <4 x float> %tmp_954, i32 2
  %tmp_956 = load <4 x float>* %y, align 16
  %tmp_957 = extractelement <4 x float> %tmp_956, i32 2
  %tmp_958 = load <4 x float>* %y, align 16
  %tmp_959 = extractelement <4 x float> %tmp_958, i32 2
  %tmp_960 = fmul float %tmp_957, %tmp_959
  %tmp_961 = call float @llvm.fmuladd.f32(float %tmp_953, float %tmp_955, float %tmp_960)
  %tmp_962 = call float @llvm.log2.f32(float %tmp_961)
  %tmp_963 = call float @llvm.log2.f32(float %tmp_962)
  %tmp_964 = fsub float %tmp_951, %tmp_963
  %tmp_965 = load <4 x float>* %fc, align 16
  %tmp_966 = insertelement <4 x float> %tmp_965, float %tmp_964, i32 2
  store <4 x float> %tmp_966, <4 x float>* %fc, align 16
  %tmp_967 = load <4 x i32>* %ccount, align 16
  %tmp_968 = extractelement <4 x i32> %tmp_967, i32 3
  %tmp_969 = sitofp i32 %tmp_968 to float
  %tmp_970 = fadd float %tmp_969, 1.000000e+00
  %tmp_971 = load <4 x float>* %x, align 16
  %tmp_972 = extractelement <4 x float> %tmp_971, i32 3
  %tmp_973 = load <4 x float>* %x, align 16
  %tmp_974 = extractelement <4 x float> %tmp_973, i32 3
  %tmp_975 = load <4 x float>* %y, align 16
  %tmp_976 = extractelement <4 x float> %tmp_975, i32 3
  %tmp_977 = load <4 x float>* %y, align 16
  %tmp_978 = extractelement <4 x float> %tmp_977, i32 3
  %tmp_979 = fmul float %tmp_976, %tmp_978
  %tmp_980 = call float @llvm.fmuladd.f32(float %tmp_972, float %tmp_974, float %tmp_979)
  %tmp_981 = call float @llvm.log2.f32(float %tmp_980)
  %tmp_982 = call float @llvm.log2.f32(float %tmp_981)
  %tmp_983 = fsub float %tmp_970, %tmp_982
  %tmp_984 = load <4 x float>* %fc, align 16
  %tmp_985 = insertelement <4 x float> %tmp_984, float %tmp_983, i32 3
  store <4 x float> %tmp_985, <4 x float>* %fc, align 16
  %tmp_986 = load <4 x float>* %fc, align 16
  %tmp_987 = extractelement <4 x float> %tmp_986, i32 0
  %tmp_988 = fmul float %tmp_987, 2.000000e+00
  %tmp_989 = fmul float %tmp_988, 0x400921FF20000000
  %tmp_990 = fdiv float %tmp_989, 2.560000e+02, !fpmath !2
  store float %tmp_990, float* %c, align 4
  %tmp_991 = load float* %c, align 4
  %tmp_992 = call float @_Z3cosf(float %tmp_991)
  %tmp_993 = fadd float 1.000000e+00, %tmp_992
  %tmp_994 = fmul float %tmp_993, 5.000000e-01
  %tmp_995 = fmul float %tmp_994, 2.550000e+02
  %tmp_996 = fptoui float %tmp_995 to i8
  %tmp_997 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_998 = load <4 x i8>* %tmp_997, align 4
  %tmp_999 = insertelement <4 x i8> %tmp_998, i8 %tmp_996, i32 0
  store <4 x i8> %tmp_999, <4 x i8>* %tmp_997, align 4
  %tmp_1000 = load float* %c, align 4
  %tmp_1001 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %tmp_1000, float 0x4000C154C0000000)
  %tmp_1002 = call float @_Z3cosf(float %tmp_1001)
  %tmp_1003 = fadd float 1.000000e+00, %tmp_1002
  %tmp_1004 = fmul float %tmp_1003, 5.000000e-01
  %tmp_1005 = fmul float %tmp_1004, 2.550000e+02
  %tmp_1006 = fptoui float %tmp_1005 to i8
  %tmp_1007 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1008 = load <4 x i8>* %tmp_1007, align 4
  %tmp_1009 = insertelement <4 x i8> %tmp_1008, i8 %tmp_1006, i32 1
  store <4 x i8> %tmp_1009, <4 x i8>* %tmp_1007, align 4
  %tmp_1010 = load float* %c, align 4
  %tmp_1011 = fsub float %tmp_1010, 0x4000C154C0000000
  %tmp_1012 = call float @_Z3cosf(float %tmp_1011)
  %tmp_1013 = fadd float 1.000000e+00, %tmp_1012
  %tmp_1014 = fmul float %tmp_1013, 5.000000e-01
  %tmp_1015 = fmul float %tmp_1014, 2.550000e+02
  %tmp_1016 = fptoui float %tmp_1015 to i8
  %tmp_1017 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1018 = load <4 x i8>* %tmp_1017, align 4
  %tmp_1019 = insertelement <4 x i8> %tmp_1018, i8 %tmp_1016, i32 2
  store <4 x i8> %tmp_1019, <4 x i8>* %tmp_1017, align 4
  %tmp_1020 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1021 = load <4 x i8>* %tmp_1020, align 4
  %tmp_1022 = insertelement <4 x i8> %tmp_1021, i8 -1, i32 3
  store <4 x i8> %tmp_1022, <4 x i8>* %tmp_1020, align 4
  %tmp_1023 = load <4 x i32>* %ccount, align 16
  %tmp_1024 = extractelement <4 x i32> %tmp_1023, i32 0
  %tmp_1025 = load i32* %tmp_6, align 4
  %tmp_1026 = icmp eq i32 %tmp_1024, %tmp_1025
  br i1 %tmp_1026, label %tmp_1027, label %tmp_1037

tmp_1027:                                    ; preds = %tmp_905
  %tmp_1028 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1029 = load <4 x i8>* %tmp_1028, align 4
  %tmp_1030 = insertelement <4 x i8> %tmp_1029, i8 0, i32 0
  store <4 x i8> %tmp_1030, <4 x i8>* %tmp_1028, align 4
  %tmp_1031 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1032 = load <4 x i8>* %tmp_1031, align 4
  %tmp_1033 = insertelement <4 x i8> %tmp_1032, i8 0, i32 1
  store <4 x i8> %tmp_1033, <4 x i8>* %tmp_1031, align 4
  %tmp_1034 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1035 = load <4 x i8>* %tmp_1034, align 4
  %tmp_1036 = insertelement <4 x i8> %tmp_1035, i8 0, i32 2
  store <4 x i8> %tmp_1036, <4 x i8>* %tmp_1034, align 4
  br label %tmp_1037

tmp_1037:                                    ; preds = %tmp_1027, %tmp_905
  %tmp_1038 = load i32* %tmp_8, align 4
  %tmp_1039 = icmp ne i32 %tmp_1038, 0
  br i1 %tmp_1039, label %tmp_1040, label %tmp_1072

tmp_1040:                                    ; preds = %tmp_1037
  %tmp_1041 = load <4 x i32>* %ccount, align 16
  %tmp_1042 = extractelement <4 x i32> %tmp_1041, i32 0
  %tmp_1043 = and i32 %tmp_1042, 255
  %tmp_1044 = trunc i32 %tmp_1043 to i8
  %tmp_1045 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1046 = load <4 x i8>* %tmp_1045, align 4
  %tmp_1047 = insertelement <4 x i8> %tmp_1046, i8 %tmp_1044, i32 0
  store <4 x i8> %tmp_1047, <4 x i8>* %tmp_1045, align 4
  %tmp_1048 = load <4 x i32>* %ccount, align 16
  %tmp_1049 = extractelement <4 x i32> %tmp_1048, i32 0
  %tmp_1050 = and i32 %tmp_1049, 65280
  %tmp_1051 = ashr i32 %tmp_1050, 8
  %tmp_1052 = trunc i32 %tmp_1051 to i8
  %tmp_1053 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1054 = load <4 x i8>* %tmp_1053, align 4
  %tmp_1055 = insertelement <4 x i8> %tmp_1054, i8 %tmp_1052, i32 1
  store <4 x i8> %tmp_1055, <4 x i8>* %tmp_1053, align 4
  %tmp_1056 = load <4 x i32>* %ccount, align 16
  %tmp_1057 = extractelement <4 x i32> %tmp_1056, i32 0
  %tmp_1058 = and i32 %tmp_1057, 16711680
  %tmp_1059 = ashr i32 %tmp_1058, 16
  %tmp_1060 = trunc i32 %tmp_1059 to i8
  %tmp_1061 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1062 = load <4 x i8>* %tmp_1061, align 4
  %tmp_1063 = insertelement <4 x i8> %tmp_1062, i8 %tmp_1060, i32 2
  store <4 x i8> %tmp_1063, <4 x i8>* %tmp_1061, align 4
  %tmp_1064 = load <4 x i32>* %ccount, align 16
  %tmp_1065 = extractelement <4 x i32> %tmp_1064, i32 0
  %tmp_1066 = and i32 %tmp_1065, -16777216
  %tmp_1067 = lshr i32 %tmp_1066, 24
  %tmp_1068 = trunc i32 %tmp_1067 to i8
  %tmp_1069 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1070 = load <4 x i8>* %tmp_1069, align 4
  %tmp_1071 = insertelement <4 x i8> %tmp_1070, i8 %tmp_1068, i32 3
  store <4 x i8> %tmp_1071, <4 x i8>* %tmp_1069, align 4
  br label %tmp_1072

tmp_1072:                                    ; preds = %tmp_1040, %tmp_1037
  %tmp_1073 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1074 = load <4 x i8>* %tmp_1073, align 4
  %tmp_1075 = load i32* %tid, align 4
  %tmp_1076 = mul nsw i32 4, %tmp_1075
  %tmp_1077 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_1078 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_1077, i32 %tmp_1076
  store <4 x i8> %tmp_1074, <4 x i8> addrspace(1)* %tmp_1078, align 4
  %tmp_1079 = load <4 x float>* %fc, align 16
  %tmp_1080 = extractelement <4 x float> %tmp_1079, i32 1
  %tmp_1081 = fmul float %tmp_1080, 2.000000e+00
  %tmp_1082 = fmul float %tmp_1081, 0x400921FF20000000
  %tmp_1083 = fdiv float %tmp_1082, 2.560000e+02, !fpmath !2
  store float %tmp_1083, float* %c, align 4
  %tmp_1084 = load float* %c, align 4
  %tmp_1085 = call float @_Z3cosf(float %tmp_1084)
  %tmp_1086 = fadd float 1.000000e+00, %tmp_1085
  %tmp_1087 = fmul float %tmp_1086, 5.000000e-01
  %tmp_1088 = fmul float %tmp_1087, 2.550000e+02
  %tmp_1089 = fptoui float %tmp_1088 to i8
  %tmp_1090 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1091 = load <4 x i8>* %tmp_1090, align 4
  %tmp_1092 = insertelement <4 x i8> %tmp_1091, i8 %tmp_1089, i32 0
  store <4 x i8> %tmp_1092, <4 x i8>* %tmp_1090, align 4
  %tmp_1093 = load float* %c, align 4
  %tmp_1094 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %tmp_1093, float 0x4000C154C0000000)
  %tmp_1095 = call float @_Z3cosf(float %tmp_1094)
  %tmp_1096 = fadd float 1.000000e+00, %tmp_1095
  %tmp_1097 = fmul float %tmp_1096, 5.000000e-01
  %tmp_1098 = fmul float %tmp_1097, 2.550000e+02
  %tmp_1099 = fptoui float %tmp_1098 to i8
  %tmp_1100 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1101 = load <4 x i8>* %tmp_1100, align 4
  %tmp_1102 = insertelement <4 x i8> %tmp_1101, i8 %tmp_1099, i32 1
  store <4 x i8> %tmp_1102, <4 x i8>* %tmp_1100, align 4
  %tmp_1103 = load float* %c, align 4
  %tmp_1104 = fsub float %tmp_1103, 0x4000C154C0000000
  %tmp_1105 = call float @_Z3cosf(float %tmp_1104)
  %tmp_1106 = fadd float 1.000000e+00, %tmp_1105
  %tmp_1107 = fmul float %tmp_1106, 5.000000e-01
  %tmp_1108 = fmul float %tmp_1107, 2.550000e+02
  %tmp_1109 = fptoui float %tmp_1108 to i8
  %tmp_1110 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1111 = load <4 x i8>* %tmp_1110, align 4
  %tmp_1112 = insertelement <4 x i8> %tmp_1111, i8 %tmp_1109, i32 2
  store <4 x i8> %tmp_1112, <4 x i8>* %tmp_1110, align 4
  %tmp_1113 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1114 = load <4 x i8>* %tmp_1113, align 4
  %tmp_1115 = insertelement <4 x i8> %tmp_1114, i8 -1, i32 3
  store <4 x i8> %tmp_1115, <4 x i8>* %tmp_1113, align 4
  %tmp_1116 = load <4 x i32>* %ccount, align 16
  %tmp_1117 = extractelement <4 x i32> %tmp_1116, i32 1
  %tmp_1118 = load i32* %tmp_6, align 4
  %tmp_1119 = icmp eq i32 %tmp_1117, %tmp_1118
  br i1 %tmp_1119, label %tmp_1120, label %tmp_1130

tmp_1120:                                    ; preds = %tmp_1072
  %tmp_1121 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1122 = load <4 x i8>* %tmp_1121, align 4
  %tmp_1123 = insertelement <4 x i8> %tmp_1122, i8 0, i32 0
  store <4 x i8> %tmp_1123, <4 x i8>* %tmp_1121, align 4
  %tmp_1124 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1125 = load <4 x i8>* %tmp_1124, align 4
  %tmp_1126 = insertelement <4 x i8> %tmp_1125, i8 0, i32 1
  store <4 x i8> %tmp_1126, <4 x i8>* %tmp_1124, align 4
  %tmp_1127 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1128 = load <4 x i8>* %tmp_1127, align 4
  %tmp_1129 = insertelement <4 x i8> %tmp_1128, i8 0, i32 2
  store <4 x i8> %tmp_1129, <4 x i8>* %tmp_1127, align 4
  br label %tmp_1130

tmp_1130:                                    ; preds = %tmp_1120, %tmp_1072
  %tmp_1131 = load i32* %tmp_8, align 4
  %tmp_1132 = icmp ne i32 %tmp_1131, 0
  br i1 %tmp_1132, label %tmp_1133, label %tmp_1165

tmp_1133:                                    ; preds = %tmp_1130
  %tmp_1134 = load <4 x i32>* %ccount, align 16
  %tmp_1135 = extractelement <4 x i32> %tmp_1134, i32 1
  %tmp_1136 = and i32 %tmp_1135, 255
  %tmp_1137 = trunc i32 %tmp_1136 to i8
  %tmp_1138 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1139 = load <4 x i8>* %tmp_1138, align 4
  %tmp_1140 = insertelement <4 x i8> %tmp_1139, i8 %tmp_1137, i32 0
  store <4 x i8> %tmp_1140, <4 x i8>* %tmp_1138, align 4
  %tmp_1141 = load <4 x i32>* %ccount, align 16
  %tmp_1142 = extractelement <4 x i32> %tmp_1141, i32 1
  %tmp_1143 = and i32 %tmp_1142, 65280
  %tmp_1144 = ashr i32 %tmp_1143, 8
  %tmp_1145 = trunc i32 %tmp_1144 to i8
  %tmp_1146 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1147 = load <4 x i8>* %tmp_1146, align 4
  %tmp_1148 = insertelement <4 x i8> %tmp_1147, i8 %tmp_1145, i32 1
  store <4 x i8> %tmp_1148, <4 x i8>* %tmp_1146, align 4
  %tmp_1149 = load <4 x i32>* %ccount, align 16
  %tmp_1150 = extractelement <4 x i32> %tmp_1149, i32 1
  %tmp_1151 = and i32 %tmp_1150, 16711680
  %tmp_1152 = ashr i32 %tmp_1151, 16
  %tmp_1153 = trunc i32 %tmp_1152 to i8
  %tmp_1154 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1155 = load <4 x i8>* %tmp_1154, align 4
  %tmp_1156 = insertelement <4 x i8> %tmp_1155, i8 %tmp_1153, i32 2
  store <4 x i8> %tmp_1156, <4 x i8>* %tmp_1154, align 4
  %tmp_1157 = load <4 x i32>* %ccount, align 16
  %tmp_1158 = extractelement <4 x i32> %tmp_1157, i32 1
  %tmp_1159 = and i32 %tmp_1158, -16777216
  %tmp_1160 = lshr i32 %tmp_1159, 24
  %tmp_1161 = trunc i32 %tmp_1160 to i8
  %tmp_1162 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1163 = load <4 x i8>* %tmp_1162, align 4
  %tmp_1164 = insertelement <4 x i8> %tmp_1163, i8 %tmp_1161, i32 3
  store <4 x i8> %tmp_1164, <4 x i8>* %tmp_1162, align 4
  br label %tmp_1165

tmp_1165:                                    ; preds = %tmp_1133, %tmp_1130
  %tmp_1166 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1167 = load <4 x i8>* %tmp_1166, align 4
  %tmp_1168 = load i32* %tid, align 4
  %tmp_1169 = mul nsw i32 4, %tmp_1168
  %tmp_1170 = add nsw i32 %tmp_1169, 1
  %tmp_1171 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_1172 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_1171, i32 %tmp_1170
  store <4 x i8> %tmp_1167, <4 x i8> addrspace(1)* %tmp_1172, align 4
  %tmp_1173 = load <4 x float>* %fc, align 16
  %tmp_1174 = extractelement <4 x float> %tmp_1173, i32 2
  %tmp_1175 = fmul float %tmp_1174, 2.000000e+00
  %tmp_1176 = fmul float %tmp_1175, 0x400921FF20000000
  %tmp_1177 = fdiv float %tmp_1176, 2.560000e+02, !fpmath !2
  store float %tmp_1177, float* %c, align 4
  %tmp_1178 = load float* %c, align 4
  %tmp_1179 = call float @_Z3cosf(float %tmp_1178)
  %tmp_1180 = fadd float 1.000000e+00, %tmp_1179
  %tmp_1181 = fmul float %tmp_1180, 5.000000e-01
  %tmp_1182 = fmul float %tmp_1181, 2.550000e+02
  %tmp_1183 = fptoui float %tmp_1182 to i8
  %tmp_1184 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1185 = load <4 x i8>* %tmp_1184, align 4
  %tmp_1186 = insertelement <4 x i8> %tmp_1185, i8 %tmp_1183, i32 0
  store <4 x i8> %tmp_1186, <4 x i8>* %tmp_1184, align 4
  %tmp_1187 = load float* %c, align 4
  %tmp_1188 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %tmp_1187, float 0x4000C154C0000000)
  %tmp_1189 = call float @_Z3cosf(float %tmp_1188)
  %tmp_1190 = fadd float 1.000000e+00, %tmp_1189
  %tmp_1191 = fmul float %tmp_1190, 5.000000e-01
  %tmp_1192 = fmul float %tmp_1191, 2.550000e+02
  %tmp_1193 = fptoui float %tmp_1192 to i8
  %tmp_1194 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1195 = load <4 x i8>* %tmp_1194, align 4
  %tmp_1196 = insertelement <4 x i8> %tmp_1195, i8 %tmp_1193, i32 1
  store <4 x i8> %tmp_1196, <4 x i8>* %tmp_1194, align 4
  %tmp_1197 = load float* %c, align 4
  %tmp_1198 = fsub float %tmp_1197, 0x4000C154C0000000
  %tmp_1199 = call float @_Z3cosf(float %tmp_1198)
  %tmp_1200 = fadd float 1.000000e+00, %tmp_1199
  %tmp_1201 = fmul float %tmp_1200, 5.000000e-01
  %tmp_1202 = fmul float %tmp_1201, 2.550000e+02
  %tmp_1203 = fptoui float %tmp_1202 to i8
  %tmp_1204 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1205 = load <4 x i8>* %tmp_1204, align 4
  %tmp_1206 = insertelement <4 x i8> %tmp_1205, i8 %tmp_1203, i32 2
  store <4 x i8> %tmp_1206, <4 x i8>* %tmp_1204, align 4
  %tmp_1207 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1208 = load <4 x i8>* %tmp_1207, align 4
  %tmp_1209 = insertelement <4 x i8> %tmp_1208, i8 -1, i32 3
  store <4 x i8> %tmp_1209, <4 x i8>* %tmp_1207, align 4
  %tmp_1210 = load <4 x i32>* %ccount, align 16
  %tmp_1211 = extractelement <4 x i32> %tmp_1210, i32 2
  %tmp_1212 = load i32* %tmp_6, align 4
  %tmp_1213 = icmp eq i32 %tmp_1211, %tmp_1212
  br i1 %tmp_1213, label %tmp_1214, label %tmp_1224

tmp_1214:                                    ; preds = %tmp_1165
  %tmp_1215 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1216 = load <4 x i8>* %tmp_1215, align 4
  %tmp_1217 = insertelement <4 x i8> %tmp_1216, i8 0, i32 0
  store <4 x i8> %tmp_1217, <4 x i8>* %tmp_1215, align 4
  %tmp_1218 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1219 = load <4 x i8>* %tmp_1218, align 4
  %tmp_1220 = insertelement <4 x i8> %tmp_1219, i8 0, i32 1
  store <4 x i8> %tmp_1220, <4 x i8>* %tmp_1218, align 4
  %tmp_1221 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1222 = load <4 x i8>* %tmp_1221, align 4
  %tmp_1223 = insertelement <4 x i8> %tmp_1222, i8 0, i32 2
  store <4 x i8> %tmp_1223, <4 x i8>* %tmp_1221, align 4
  br label %tmp_1224

tmp_1224:                                    ; preds = %tmp_1214, %tmp_1165
  %tmp_1225 = load i32* %tmp_8, align 4
  %tmp_1226 = icmp ne i32 %tmp_1225, 0
  br i1 %tmp_1226, label %tmp_1227, label %tmp_1259

tmp_1227:                                    ; preds = %tmp_1224
  %tmp_1228 = load <4 x i32>* %ccount, align 16
  %tmp_1229 = extractelement <4 x i32> %tmp_1228, i32 2
  %tmp_1230 = and i32 %tmp_1229, 255
  %tmp_1231 = trunc i32 %tmp_1230 to i8
  %tmp_1232 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1233 = load <4 x i8>* %tmp_1232, align 4
  %tmp_1234 = insertelement <4 x i8> %tmp_1233, i8 %tmp_1231, i32 0
  store <4 x i8> %tmp_1234, <4 x i8>* %tmp_1232, align 4
  %tmp_1235 = load <4 x i32>* %ccount, align 16
  %tmp_1236 = extractelement <4 x i32> %tmp_1235, i32 2
  %tmp_1237 = and i32 %tmp_1236, 65280
  %tmp_1238 = ashr i32 %tmp_1237, 8
  %tmp_1239 = trunc i32 %tmp_1238 to i8
  %tmp_1240 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1241 = load <4 x i8>* %tmp_1240, align 4
  %tmp_1242 = insertelement <4 x i8> %tmp_1241, i8 %tmp_1239, i32 1
  store <4 x i8> %tmp_1242, <4 x i8>* %tmp_1240, align 4
  %tmp_1243 = load <4 x i32>* %ccount, align 16
  %tmp_1244 = extractelement <4 x i32> %tmp_1243, i32 2
  %tmp_1245 = and i32 %tmp_1244, 16711680
  %tmp_1246 = ashr i32 %tmp_1245, 16
  %tmp_1247 = trunc i32 %tmp_1246 to i8
  %tmp_1248 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1249 = load <4 x i8>* %tmp_1248, align 4
  %tmp_1250 = insertelement <4 x i8> %tmp_1249, i8 %tmp_1247, i32 2
  store <4 x i8> %tmp_1250, <4 x i8>* %tmp_1248, align 4
  %tmp_1251 = load <4 x i32>* %ccount, align 16
  %tmp_1252 = extractelement <4 x i32> %tmp_1251, i32 2
  %tmp_1253 = and i32 %tmp_1252, -16777216
  %tmp_1254 = lshr i32 %tmp_1253, 24
  %tmp_1255 = trunc i32 %tmp_1254 to i8
  %tmp_1256 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1257 = load <4 x i8>* %tmp_1256, align 4
  %tmp_1258 = insertelement <4 x i8> %tmp_1257, i8 %tmp_1255, i32 3
  store <4 x i8> %tmp_1258, <4 x i8>* %tmp_1256, align 4
  br label %tmp_1259

tmp_1259:                                    ; preds = %tmp_1227, %tmp_1224
  %tmp_1260 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1261 = load <4 x i8>* %tmp_1260, align 4
  %tmp_1262 = load i32* %tid, align 4
  %tmp_1263 = mul nsw i32 4, %tmp_1262
  %tmp_1264 = add nsw i32 %tmp_1263, 2
  %tmp_1265 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_1266 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_1265, i32 %tmp_1264
  store <4 x i8> %tmp_1261, <4 x i8> addrspace(1)* %tmp_1266, align 4
  %tmp_1267 = load <4 x float>* %fc, align 16
  %tmp_1268 = extractelement <4 x float> %tmp_1267, i32 3
  %tmp_1269 = fmul float %tmp_1268, 2.000000e+00
  %tmp_1270 = fmul float %tmp_1269, 0x400921FF20000000
  %tmp_1271 = fdiv float %tmp_1270, 2.560000e+02, !fpmath !2
  store float %tmp_1271, float* %c, align 4
  %tmp_1272 = load float* %c, align 4
  %tmp_1273 = call float @_Z3cosf(float %tmp_1272)
  %tmp_1274 = fadd float 1.000000e+00, %tmp_1273
  %tmp_1275 = fmul float %tmp_1274, 5.000000e-01
  %tmp_1276 = fmul float %tmp_1275, 2.550000e+02
  %tmp_1277 = fptoui float %tmp_1276 to i8
  %tmp_1278 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1279 = load <4 x i8>* %tmp_1278, align 4
  %tmp_1280 = insertelement <4 x i8> %tmp_1279, i8 %tmp_1277, i32 0
  store <4 x i8> %tmp_1280, <4 x i8>* %tmp_1278, align 4
  %tmp_1281 = load float* %c, align 4
  %tmp_1282 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %tmp_1281, float 0x4000C154C0000000)
  %tmp_1283 = call float @_Z3cosf(float %tmp_1282)
  %tmp_1284 = fadd float 1.000000e+00, %tmp_1283
  %tmp_1285 = fmul float %tmp_1284, 5.000000e-01
  %tmp_1286 = fmul float %tmp_1285, 2.550000e+02
  %tmp_1287 = fptoui float %tmp_1286 to i8
  %tmp_1288 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1289 = load <4 x i8>* %tmp_1288, align 4
  %tmp_1290 = insertelement <4 x i8> %tmp_1289, i8 %tmp_1287, i32 1
  store <4 x i8> %tmp_1290, <4 x i8>* %tmp_1288, align 4
  %tmp_1291 = load float* %c, align 4
  %tmp_1292 = fsub float %tmp_1291, 0x4000C154C0000000
  %tmp_1293 = call float @_Z3cosf(float %tmp_1292)
  %tmp_1294 = fadd float 1.000000e+00, %tmp_1293
  %tmp_1295 = fmul float %tmp_1294, 5.000000e-01
  %tmp_1296 = fmul float %tmp_1295, 2.550000e+02
  %tmp_1297 = fptoui float %tmp_1296 to i8
  %tmp_1298 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1299 = load <4 x i8>* %tmp_1298, align 4
  %tmp_1300 = insertelement <4 x i8> %tmp_1299, i8 %tmp_1297, i32 2
  store <4 x i8> %tmp_1300, <4 x i8>* %tmp_1298, align 4
  %tmp_1301 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1302 = load <4 x i8>* %tmp_1301, align 4
  %tmp_1303 = insertelement <4 x i8> %tmp_1302, i8 -1, i32 3
  store <4 x i8> %tmp_1303, <4 x i8>* %tmp_1301, align 4
  %tmp_1304 = load <4 x i32>* %ccount, align 16
  %tmp_1305 = extractelement <4 x i32> %tmp_1304, i32 3
  %tmp_1306 = load i32* %tmp_6, align 4
  %tmp_1307 = icmp eq i32 %tmp_1305, %tmp_1306
  br i1 %tmp_1307, label %tmp_1308, label %tmp_1318

tmp_1308:                                    ; preds = %tmp_1259
  %tmp_1309 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1310 = load <4 x i8>* %tmp_1309, align 4
  %tmp_1311 = insertelement <4 x i8> %tmp_1310, i8 0, i32 0
  store <4 x i8> %tmp_1311, <4 x i8>* %tmp_1309, align 4
  %tmp_1312 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1313 = load <4 x i8>* %tmp_1312, align 4
  %tmp_1314 = insertelement <4 x i8> %tmp_1313, i8 0, i32 1
  store <4 x i8> %tmp_1314, <4 x i8>* %tmp_1312, align 4
  %tmp_1315 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1316 = load <4 x i8>* %tmp_1315, align 4
  %tmp_1317 = insertelement <4 x i8> %tmp_1316, i8 0, i32 2
  store <4 x i8> %tmp_1317, <4 x i8>* %tmp_1315, align 4
  br label %tmp_1318

tmp_1318:                                    ; preds = %tmp_1308, %tmp_1259
  %tmp_1319 = load i32* %tmp_8, align 4
  %tmp_1320 = icmp ne i32 %tmp_1319, 0
  br i1 %tmp_1320, label %tmp_1321, label %tmp_1353

tmp_1321:                                    ; preds = %tmp_1318
  %tmp_1322 = load <4 x i32>* %ccount, align 16
  %tmp_1323 = extractelement <4 x i32> %tmp_1322, i32 3
  %tmp_1324 = and i32 %tmp_1323, 255
  %tmp_1325 = trunc i32 %tmp_1324 to i8
  %tmp_1326 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1327 = load <4 x i8>* %tmp_1326, align 4
  %tmp_1328 = insertelement <4 x i8> %tmp_1327, i8 %tmp_1325, i32 0
  store <4 x i8> %tmp_1328, <4 x i8>* %tmp_1326, align 4
  %tmp_1329 = load <4 x i32>* %ccount, align 16
  %tmp_1330 = extractelement <4 x i32> %tmp_1329, i32 3
  %tmp_1331 = and i32 %tmp_1330, 65280
  %tmp_1332 = ashr i32 %tmp_1331, 8
  %tmp_1333 = trunc i32 %tmp_1332 to i8
  %tmp_1334 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1335 = load <4 x i8>* %tmp_1334, align 4
  %tmp_1336 = insertelement <4 x i8> %tmp_1335, i8 %tmp_1333, i32 1
  store <4 x i8> %tmp_1336, <4 x i8>* %tmp_1334, align 4
  %tmp_1337 = load <4 x i32>* %ccount, align 16
  %tmp_1338 = extractelement <4 x i32> %tmp_1337, i32 3
  %tmp_1339 = and i32 %tmp_1338, 16711680
  %tmp_1340 = ashr i32 %tmp_1339, 16
  %tmp_1341 = trunc i32 %tmp_1340 to i8
  %tmp_1342 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1343 = load <4 x i8>* %tmp_1342, align 4
  %tmp_1344 = insertelement <4 x i8> %tmp_1343, i8 %tmp_1341, i32 2
  store <4 x i8> %tmp_1344, <4 x i8>* %tmp_1342, align 4
  %tmp_1345 = load <4 x i32>* %ccount, align 16
  %tmp_1346 = extractelement <4 x i32> %tmp_1345, i32 3
  %tmp_1347 = and i32 %tmp_1346, -16777216
  %tmp_1348 = lshr i32 %tmp_1347, 24
  %tmp_1349 = trunc i32 %tmp_1348 to i8
  %tmp_1350 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1351 = load <4 x i8>* %tmp_1350, align 4
  %tmp_1352 = insertelement <4 x i8> %tmp_1351, i8 %tmp_1349, i32 3
  store <4 x i8> %tmp_1352, <4 x i8>* %tmp_1350, align 4
  br label %tmp_1353

tmp_1353:                                    ; preds = %tmp_1321, %tmp_1318
  %tmp_1354 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1355 = load <4 x i8>* %tmp_1354, align 4
  %tmp_1356 = load i32* %tid, align 4
  %tmp_1357 = mul nsw i32 4, %tmp_1356
  %tmp_1358 = add nsw i32 %tmp_1357, 3
  %tmp_1359 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_1360 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_1359, i32 %tmp_1358
  store <4 x i8> %tmp_1355, <4 x i8> addrspace(1)* %tmp_1360, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare i32 @MUL_ADD(...) #1

declare <4 x float> @_Z14convert_float4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #3

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, float, float, float, float, i32, i32, i32)* @mandelbrot_vector_float}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

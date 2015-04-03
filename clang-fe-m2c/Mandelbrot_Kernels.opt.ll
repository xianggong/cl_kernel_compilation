; ModuleID = 'Mandelbrot_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @mandelbrot_vector_float(<4 x i8> addrspace(1)* %mandelbrotImage, float %posx, float %posy, float %stepSizeX, float %stepSizeY, i32 %maxIterations, i32 %width, i32 %bench) #0 {
  %color = alloca [4 x <4 x i8>], align 4
  %tmp_9 = call i32 @__get_global_id_u32(i32 0)
  %tmp_12 = sdiv i32 %width, 4
  %tmp_13 = srem i32 %tmp_9, %tmp_12
  %tmp_16 = sdiv i32 %width, 4
  %tmp_17 = sdiv i32 %tmp_9, %tmp_16
  %tmp_19 = mul nsw i32 4, %tmp_13
  %tmp_20 = insertelement <4 x i32> undef, i32 %tmp_19, i32 0
  %tmp_22 = mul nsw i32 4, %tmp_13
  %tmp_23 = add nsw i32 %tmp_22, 1
  %tmp_24 = insertelement <4 x i32> %tmp_20, i32 %tmp_23, i32 1
  %tmp_26 = mul nsw i32 4, %tmp_13
  %tmp_27 = add nsw i32 %tmp_26, 2
  %tmp_28 = insertelement <4 x i32> %tmp_24, i32 %tmp_27, i32 2
  %tmp_30 = mul nsw i32 4, %tmp_13
  %tmp_31 = add nsw i32 %tmp_30, 3
  %tmp_32 = insertelement <4 x i32> %tmp_28, i32 %tmp_31, i32 3
  %tmp_34 = insertelement <4 x i32> undef, i32 %tmp_17, i32 0
  %tmp_36 = insertelement <4 x i32> %tmp_34, i32 %tmp_17, i32 1
  %tmp_38 = insertelement <4 x i32> %tmp_36, i32 %tmp_17, i32 2
  %tmp_40 = insertelement <4 x i32> %tmp_38, i32 %tmp_17, i32 3
  %tmp_44 = extractelement <4 x i32> %tmp_32, i32 0
  %tmp_45 = sitofp i32 %tmp_44 to float
  %tmp_46 = call float @llvm.fmuladd.f32(float %stepSizeX, float %tmp_45, float %posx)
  %tmp_48 = insertelement <4 x float> undef, float %tmp_46, i32 0
  %tmp_52 = extractelement <4 x i32> %tmp_32, i32 1
  %tmp_53 = sitofp i32 %tmp_52 to float
  %tmp_54 = call float @llvm.fmuladd.f32(float %stepSizeX, float %tmp_53, float %posx)
  %tmp_56 = insertelement <4 x float> %tmp_48, float %tmp_54, i32 1
  %tmp_60 = extractelement <4 x i32> %tmp_32, i32 2
  %tmp_61 = sitofp i32 %tmp_60 to float
  %tmp_62 = call float @llvm.fmuladd.f32(float %stepSizeX, float %tmp_61, float %posx)
  %tmp_64 = insertelement <4 x float> %tmp_56, float %tmp_62, i32 2
  %tmp_68 = extractelement <4 x i32> %tmp_32, i32 3
  %tmp_69 = sitofp i32 %tmp_68 to float
  %tmp_70 = call float @llvm.fmuladd.f32(float %stepSizeX, float %tmp_69, float %posx)
  %tmp_72 = insertelement <4 x float> %tmp_64, float %tmp_70, i32 3
  %tmp_76 = extractelement <4 x i32> %tmp_40, i32 0
  %tmp_77 = sitofp i32 %tmp_76 to float
  %tmp_78 = call float @llvm.fmuladd.f32(float %stepSizeY, float %tmp_77, float %posy)
  %tmp_80 = insertelement <4 x float> undef, float %tmp_78, i32 0
  %tmp_84 = extractelement <4 x i32> %tmp_40, i32 1
  %tmp_85 = sitofp i32 %tmp_84 to float
  %tmp_86 = call float @llvm.fmuladd.f32(float %stepSizeY, float %tmp_85, float %posy)
  %tmp_88 = insertelement <4 x float> %tmp_80, float %tmp_86, i32 1
  %tmp_92 = extractelement <4 x i32> %tmp_40, i32 2
  %tmp_93 = sitofp i32 %tmp_92 to float
  %tmp_94 = call float @llvm.fmuladd.f32(float %stepSizeY, float %tmp_93, float %posy)
  %tmp_96 = insertelement <4 x float> %tmp_88, float %tmp_94, i32 2
  %tmp_100 = extractelement <4 x i32> %tmp_40, i32 3
  %tmp_101 = sitofp i32 %tmp_100 to float
  %tmp_102 = call float @llvm.fmuladd.f32(float %stepSizeY, float %tmp_101, float %posy)
  %tmp_104 = insertelement <4 x float> %tmp_96, float %tmp_102, i32 3
  %tmp_108 = extractelement <4 x float> %tmp_72, i32 0
  %tmp_110 = extractelement <4 x float> %tmp_72, i32 0
  %tmp_112 = extractelement <4 x float> %tmp_104, i32 0
  %tmp_114 = extractelement <4 x float> %tmp_104, i32 0
  %tmp_115 = fmul float %tmp_112, %tmp_114
  %tmp_116 = call float @llvm.fmuladd.f32(float %tmp_108, float %tmp_110, float %tmp_115)
  %tmp_117 = fcmp ole float %tmp_116, 4.000000e+00
  %tmp_118 = zext i1 %tmp_117 to i32
  %tmp_120 = insertelement <4 x i32> undef, i32 %tmp_118, i32 0
  %tmp_122 = extractelement <4 x float> %tmp_72, i32 1
  %tmp_124 = extractelement <4 x float> %tmp_72, i32 1
  %tmp_126 = extractelement <4 x float> %tmp_104, i32 1
  %tmp_128 = extractelement <4 x float> %tmp_104, i32 1
  %tmp_129 = fmul float %tmp_126, %tmp_128
  %tmp_130 = call float @llvm.fmuladd.f32(float %tmp_122, float %tmp_124, float %tmp_129)
  %tmp_131 = fcmp ole float %tmp_130, 4.000000e+00
  %tmp_132 = zext i1 %tmp_131 to i32
  %tmp_134 = insertelement <4 x i32> %tmp_120, i32 %tmp_132, i32 1
  %tmp_136 = extractelement <4 x float> %tmp_72, i32 2
  %tmp_138 = extractelement <4 x float> %tmp_72, i32 2
  %tmp_140 = extractelement <4 x float> %tmp_104, i32 2
  %tmp_142 = extractelement <4 x float> %tmp_104, i32 2
  %tmp_143 = fmul float %tmp_140, %tmp_142
  %tmp_144 = call float @llvm.fmuladd.f32(float %tmp_136, float %tmp_138, float %tmp_143)
  %tmp_145 = fcmp ole float %tmp_144, 4.000000e+00
  %tmp_146 = zext i1 %tmp_145 to i32
  %tmp_148 = insertelement <4 x i32> %tmp_134, i32 %tmp_146, i32 2
  %tmp_150 = extractelement <4 x float> %tmp_72, i32 3
  %tmp_152 = extractelement <4 x float> %tmp_72, i32 3
  %tmp_154 = extractelement <4 x float> %tmp_104, i32 3
  %tmp_156 = extractelement <4 x float> %tmp_104, i32 3
  %tmp_157 = fmul float %tmp_154, %tmp_156
  %tmp_158 = call float @llvm.fmuladd.f32(float %tmp_150, float %tmp_152, float %tmp_157)
  %tmp_159 = fcmp ole float %tmp_158, 4.000000e+00
  %tmp_160 = zext i1 %tmp_159 to i32
  %tmp_162 = insertelement <4 x i32> %tmp_148, i32 %tmp_160, i32 3
  br label %tmp_165

tmp_165:                                          ; preds = %tmp_653, %0
  %iter.0 = phi i32 [ 0, %0 ], [ %tmp_655, %tmp_653 ]
  %stay.0 = phi <4 x i32> [ %tmp_162, %0 ], [ %tmp_544, %tmp_653 ]
  %ccount.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %tmp_652, %tmp_653 ]
  %savx.0 = phi <4 x float> [ %tmp_72, %0 ], [ %tmp_596, %tmp_653 ]
  %savy.0 = phi <4 x float> [ %tmp_104, %0 ], [ %tmp_648, %tmp_653 ]
  %tmp_167 = extractelement <4 x i32> %stay.0, i32 0
  %tmp_169 = extractelement <4 x i32> %stay.0, i32 1
  %tmp_170 = or i32 %tmp_167, %tmp_169
  %tmp_172 = extractelement <4 x i32> %stay.0, i32 2
  %tmp_173 = or i32 %tmp_170, %tmp_172
  %tmp_175 = extractelement <4 x i32> %stay.0, i32 3
  %tmp_176 = or i32 %tmp_173, %tmp_175
  %tmp_177 = icmp ne i32 %tmp_176, 0
  br i1 %tmp_177, label %tmp_178, label %tmp_656

tmp_178:                                          ; preds = %tmp_165
  %tmp_181 = icmp ult i32 %iter.0, %maxIterations
  br i1 %tmp_181, label %tmp_182, label %tmp_656

tmp_182:                                          ; preds = %tmp_178
  %tmp_186 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.0
  %tmp_191 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %savx.0, <4 x float> %savx.0, <4 x float> %tmp_72)
  %tmp_192 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_186, <4 x float> %savy.0, i32 %tmp_191)
  %tmp_193 = sitofp i32 %tmp_192 to float
  %tmp_194 = insertelement <4 x float> undef, float %tmp_193, i32 0
  %tmp_195 = shufflevector <4 x float> %tmp_194, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_197 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %savx.0
  %tmp_200 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_197, <4 x float> %savy.0, <4 x float> %tmp_104)
  %tmp_201 = sitofp i32 %tmp_200 to float
  %tmp_202 = insertelement <4 x float> undef, float %tmp_201, i32 0
  %tmp_203 = shufflevector <4 x float> %tmp_202, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_205 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_203
  %tmp_210 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_195, <4 x float> %tmp_195, <4 x float> %tmp_72)
  %tmp_211 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_205, <4 x float> %tmp_203, i32 %tmp_210)
  %tmp_212 = sitofp i32 %tmp_211 to float
  %tmp_213 = insertelement <4 x float> undef, float %tmp_212, i32 0
  %tmp_214 = shufflevector <4 x float> %tmp_213, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_216 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_195
  %tmp_219 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_216, <4 x float> %tmp_203, <4 x float> %tmp_104)
  %tmp_220 = sitofp i32 %tmp_219 to float
  %tmp_221 = insertelement <4 x float> undef, float %tmp_220, i32 0
  %tmp_222 = shufflevector <4 x float> %tmp_221, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_224 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_222
  %tmp_229 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_214, <4 x float> %tmp_214, <4 x float> %tmp_72)
  %tmp_230 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_224, <4 x float> %tmp_222, i32 %tmp_229)
  %tmp_231 = sitofp i32 %tmp_230 to float
  %tmp_232 = insertelement <4 x float> undef, float %tmp_231, i32 0
  %tmp_233 = shufflevector <4 x float> %tmp_232, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_235 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_214
  %tmp_238 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_235, <4 x float> %tmp_222, <4 x float> %tmp_104)
  %tmp_239 = sitofp i32 %tmp_238 to float
  %tmp_240 = insertelement <4 x float> undef, float %tmp_239, i32 0
  %tmp_241 = shufflevector <4 x float> %tmp_240, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_243 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_241
  %tmp_248 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_233, <4 x float> %tmp_233, <4 x float> %tmp_72)
  %tmp_249 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_243, <4 x float> %tmp_241, i32 %tmp_248)
  %tmp_250 = sitofp i32 %tmp_249 to float
  %tmp_251 = insertelement <4 x float> undef, float %tmp_250, i32 0
  %tmp_252 = shufflevector <4 x float> %tmp_251, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_254 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_233
  %tmp_257 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_254, <4 x float> %tmp_241, <4 x float> %tmp_104)
  %tmp_258 = sitofp i32 %tmp_257 to float
  %tmp_259 = insertelement <4 x float> undef, float %tmp_258, i32 0
  %tmp_260 = shufflevector <4 x float> %tmp_259, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_262 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_260
  %tmp_267 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_252, <4 x float> %tmp_252, <4 x float> %tmp_72)
  %tmp_268 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_262, <4 x float> %tmp_260, i32 %tmp_267)
  %tmp_269 = sitofp i32 %tmp_268 to float
  %tmp_270 = insertelement <4 x float> undef, float %tmp_269, i32 0
  %tmp_271 = shufflevector <4 x float> %tmp_270, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_273 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_252
  %tmp_276 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_273, <4 x float> %tmp_260, <4 x float> %tmp_104)
  %tmp_277 = sitofp i32 %tmp_276 to float
  %tmp_278 = insertelement <4 x float> undef, float %tmp_277, i32 0
  %tmp_279 = shufflevector <4 x float> %tmp_278, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_281 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_279
  %tmp_286 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_271, <4 x float> %tmp_271, <4 x float> %tmp_72)
  %tmp_287 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_281, <4 x float> %tmp_279, i32 %tmp_286)
  %tmp_288 = sitofp i32 %tmp_287 to float
  %tmp_289 = insertelement <4 x float> undef, float %tmp_288, i32 0
  %tmp_290 = shufflevector <4 x float> %tmp_289, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_292 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_271
  %tmp_295 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_292, <4 x float> %tmp_279, <4 x float> %tmp_104)
  %tmp_296 = sitofp i32 %tmp_295 to float
  %tmp_297 = insertelement <4 x float> undef, float %tmp_296, i32 0
  %tmp_298 = shufflevector <4 x float> %tmp_297, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_300 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_298
  %tmp_305 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_290, <4 x float> %tmp_290, <4 x float> %tmp_72)
  %tmp_306 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_300, <4 x float> %tmp_298, i32 %tmp_305)
  %tmp_307 = sitofp i32 %tmp_306 to float
  %tmp_308 = insertelement <4 x float> undef, float %tmp_307, i32 0
  %tmp_309 = shufflevector <4 x float> %tmp_308, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_311 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_290
  %tmp_314 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_311, <4 x float> %tmp_298, <4 x float> %tmp_104)
  %tmp_315 = sitofp i32 %tmp_314 to float
  %tmp_316 = insertelement <4 x float> undef, float %tmp_315, i32 0
  %tmp_317 = shufflevector <4 x float> %tmp_316, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_319 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_317
  %tmp_324 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_309, <4 x float> %tmp_309, <4 x float> %tmp_72)
  %tmp_325 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_319, <4 x float> %tmp_317, i32 %tmp_324)
  %tmp_326 = sitofp i32 %tmp_325 to float
  %tmp_327 = insertelement <4 x float> undef, float %tmp_326, i32 0
  %tmp_328 = shufflevector <4 x float> %tmp_327, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_330 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_309
  %tmp_333 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_330, <4 x float> %tmp_317, <4 x float> %tmp_104)
  %tmp_334 = sitofp i32 %tmp_333 to float
  %tmp_335 = insertelement <4 x float> undef, float %tmp_334, i32 0
  %tmp_336 = shufflevector <4 x float> %tmp_335, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_338 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_336
  %tmp_343 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_328, <4 x float> %tmp_328, <4 x float> %tmp_72)
  %tmp_344 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_338, <4 x float> %tmp_336, i32 %tmp_343)
  %tmp_345 = sitofp i32 %tmp_344 to float
  %tmp_346 = insertelement <4 x float> undef, float %tmp_345, i32 0
  %tmp_347 = shufflevector <4 x float> %tmp_346, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_349 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_328
  %tmp_352 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_349, <4 x float> %tmp_336, <4 x float> %tmp_104)
  %tmp_353 = sitofp i32 %tmp_352 to float
  %tmp_354 = insertelement <4 x float> undef, float %tmp_353, i32 0
  %tmp_355 = shufflevector <4 x float> %tmp_354, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_357 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_355
  %tmp_362 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_347, <4 x float> %tmp_347, <4 x float> %tmp_72)
  %tmp_363 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_357, <4 x float> %tmp_355, i32 %tmp_362)
  %tmp_364 = sitofp i32 %tmp_363 to float
  %tmp_365 = insertelement <4 x float> undef, float %tmp_364, i32 0
  %tmp_366 = shufflevector <4 x float> %tmp_365, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_368 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_347
  %tmp_371 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_368, <4 x float> %tmp_355, <4 x float> %tmp_104)
  %tmp_372 = sitofp i32 %tmp_371 to float
  %tmp_373 = insertelement <4 x float> undef, float %tmp_372, i32 0
  %tmp_374 = shufflevector <4 x float> %tmp_373, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_376 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_374
  %tmp_381 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_366, <4 x float> %tmp_366, <4 x float> %tmp_72)
  %tmp_382 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_376, <4 x float> %tmp_374, i32 %tmp_381)
  %tmp_383 = sitofp i32 %tmp_382 to float
  %tmp_384 = insertelement <4 x float> undef, float %tmp_383, i32 0
  %tmp_385 = shufflevector <4 x float> %tmp_384, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_387 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_366
  %tmp_390 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_387, <4 x float> %tmp_374, <4 x float> %tmp_104)
  %tmp_391 = sitofp i32 %tmp_390 to float
  %tmp_392 = insertelement <4 x float> undef, float %tmp_391, i32 0
  %tmp_393 = shufflevector <4 x float> %tmp_392, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_395 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_393
  %tmp_400 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_385, <4 x float> %tmp_385, <4 x float> %tmp_72)
  %tmp_401 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_395, <4 x float> %tmp_393, i32 %tmp_400)
  %tmp_402 = sitofp i32 %tmp_401 to float
  %tmp_403 = insertelement <4 x float> undef, float %tmp_402, i32 0
  %tmp_404 = shufflevector <4 x float> %tmp_403, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_406 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_385
  %tmp_409 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_406, <4 x float> %tmp_393, <4 x float> %tmp_104)
  %tmp_410 = sitofp i32 %tmp_409 to float
  %tmp_411 = insertelement <4 x float> undef, float %tmp_410, i32 0
  %tmp_412 = shufflevector <4 x float> %tmp_411, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_414 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_412
  %tmp_419 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_404, <4 x float> %tmp_404, <4 x float> %tmp_72)
  %tmp_420 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_414, <4 x float> %tmp_412, i32 %tmp_419)
  %tmp_421 = sitofp i32 %tmp_420 to float
  %tmp_422 = insertelement <4 x float> undef, float %tmp_421, i32 0
  %tmp_423 = shufflevector <4 x float> %tmp_422, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_425 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_404
  %tmp_428 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_425, <4 x float> %tmp_412, <4 x float> %tmp_104)
  %tmp_429 = sitofp i32 %tmp_428 to float
  %tmp_430 = insertelement <4 x float> undef, float %tmp_429, i32 0
  %tmp_431 = shufflevector <4 x float> %tmp_430, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_433 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_431
  %tmp_438 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_423, <4 x float> %tmp_423, <4 x float> %tmp_72)
  %tmp_439 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_433, <4 x float> %tmp_431, i32 %tmp_438)
  %tmp_440 = sitofp i32 %tmp_439 to float
  %tmp_441 = insertelement <4 x float> undef, float %tmp_440, i32 0
  %tmp_442 = shufflevector <4 x float> %tmp_441, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_444 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_423
  %tmp_447 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_444, <4 x float> %tmp_431, <4 x float> %tmp_104)
  %tmp_448 = sitofp i32 %tmp_447 to float
  %tmp_449 = insertelement <4 x float> undef, float %tmp_448, i32 0
  %tmp_450 = shufflevector <4 x float> %tmp_449, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_452 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_450
  %tmp_457 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_442, <4 x float> %tmp_442, <4 x float> %tmp_72)
  %tmp_458 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_452, <4 x float> %tmp_450, i32 %tmp_457)
  %tmp_459 = sitofp i32 %tmp_458 to float
  %tmp_460 = insertelement <4 x float> undef, float %tmp_459, i32 0
  %tmp_461 = shufflevector <4 x float> %tmp_460, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_463 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_442
  %tmp_466 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_463, <4 x float> %tmp_450, <4 x float> %tmp_104)
  %tmp_467 = sitofp i32 %tmp_466 to float
  %tmp_468 = insertelement <4 x float> undef, float %tmp_467, i32 0
  %tmp_469 = shufflevector <4 x float> %tmp_468, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_471 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_469
  %tmp_476 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_461, <4 x float> %tmp_461, <4 x float> %tmp_72)
  %tmp_477 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_471, <4 x float> %tmp_469, i32 %tmp_476)
  %tmp_478 = sitofp i32 %tmp_477 to float
  %tmp_479 = insertelement <4 x float> undef, float %tmp_478, i32 0
  %tmp_480 = shufflevector <4 x float> %tmp_479, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_482 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_461
  %tmp_485 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_482, <4 x float> %tmp_469, <4 x float> %tmp_104)
  %tmp_486 = sitofp i32 %tmp_485 to float
  %tmp_487 = insertelement <4 x float> undef, float %tmp_486, i32 0
  %tmp_488 = shufflevector <4 x float> %tmp_487, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_490 = extractelement <4 x float> %tmp_480, i32 0
  %tmp_492 = extractelement <4 x float> %tmp_480, i32 0
  %tmp_494 = extractelement <4 x float> %tmp_488, i32 0
  %tmp_496 = extractelement <4 x float> %tmp_488, i32 0
  %tmp_497 = fmul float %tmp_494, %tmp_496
  %tmp_498 = call float @llvm.fmuladd.f32(float %tmp_490, float %tmp_492, float %tmp_497)
  %tmp_499 = fcmp ole float %tmp_498, 4.000000e+00
  %tmp_500 = zext i1 %tmp_499 to i32
  %tmp_502 = insertelement <4 x i32> %stay.0, i32 %tmp_500, i32 0
  %tmp_504 = extractelement <4 x float> %tmp_480, i32 1
  %tmp_506 = extractelement <4 x float> %tmp_480, i32 1
  %tmp_508 = extractelement <4 x float> %tmp_488, i32 1
  %tmp_510 = extractelement <4 x float> %tmp_488, i32 1
  %tmp_511 = fmul float %tmp_508, %tmp_510
  %tmp_512 = call float @llvm.fmuladd.f32(float %tmp_504, float %tmp_506, float %tmp_511)
  %tmp_513 = fcmp ole float %tmp_512, 4.000000e+00
  %tmp_514 = zext i1 %tmp_513 to i32
  %tmp_516 = insertelement <4 x i32> %tmp_502, i32 %tmp_514, i32 1
  %tmp_518 = extractelement <4 x float> %tmp_480, i32 2
  %tmp_520 = extractelement <4 x float> %tmp_480, i32 2
  %tmp_522 = extractelement <4 x float> %tmp_488, i32 2
  %tmp_524 = extractelement <4 x float> %tmp_488, i32 2
  %tmp_525 = fmul float %tmp_522, %tmp_524
  %tmp_526 = call float @llvm.fmuladd.f32(float %tmp_518, float %tmp_520, float %tmp_525)
  %tmp_527 = fcmp ole float %tmp_526, 4.000000e+00
  %tmp_528 = zext i1 %tmp_527 to i32
  %tmp_530 = insertelement <4 x i32> %tmp_516, i32 %tmp_528, i32 2
  %tmp_532 = extractelement <4 x float> %tmp_480, i32 3
  %tmp_534 = extractelement <4 x float> %tmp_480, i32 3
  %tmp_536 = extractelement <4 x float> %tmp_488, i32 3
  %tmp_538 = extractelement <4 x float> %tmp_488, i32 3
  %tmp_539 = fmul float %tmp_536, %tmp_538
  %tmp_540 = call float @llvm.fmuladd.f32(float %tmp_532, float %tmp_534, float %tmp_539)
  %tmp_541 = fcmp ole float %tmp_540, 4.000000e+00
  %tmp_542 = zext i1 %tmp_541 to i32
  %tmp_544 = insertelement <4 x i32> %tmp_530, i32 %tmp_542, i32 3
  %tmp_546 = extractelement <4 x i32> %tmp_544, i32 0
  %tmp_547 = icmp ne i32 %tmp_546, 0
  br i1 %tmp_547, label %tmp_548, label %tmp_551

tmp_548:                                          ; preds = %tmp_182
  %tmp_550 = extractelement <4 x float> %tmp_480, i32 0
  br label %tmp_554

tmp_551:                                          ; preds = %tmp_182
  %tmp_553 = extractelement <4 x float> %savx.0, i32 0
  br label %tmp_554

tmp_554:                                          ; preds = %tmp_551, %tmp_548
  %tmp_555 = phi float [ %tmp_550, %tmp_548 ], [ %tmp_553, %tmp_551 ]
  %tmp_557 = insertelement <4 x float> %savx.0, float %tmp_555, i32 0
  %tmp_559 = extractelement <4 x i32> %tmp_544, i32 1
  %tmp_560 = icmp ne i32 %tmp_559, 0
  br i1 %tmp_560, label %tmp_561, label %tmp_564

tmp_561:                                          ; preds = %tmp_554
  %tmp_563 = extractelement <4 x float> %tmp_480, i32 1
  br label %tmp_567

tmp_564:                                          ; preds = %tmp_554
  %tmp_566 = extractelement <4 x float> %tmp_557, i32 1
  br label %tmp_567

tmp_567:                                          ; preds = %tmp_564, %tmp_561
  %tmp_568 = phi float [ %tmp_563, %tmp_561 ], [ %tmp_566, %tmp_564 ]
  %tmp_570 = insertelement <4 x float> %tmp_557, float %tmp_568, i32 1
  %tmp_572 = extractelement <4 x i32> %tmp_544, i32 2
  %tmp_573 = icmp ne i32 %tmp_572, 0
  br i1 %tmp_573, label %tmp_574, label %tmp_577

tmp_574:                                          ; preds = %tmp_567
  %tmp_576 = extractelement <4 x float> %tmp_480, i32 2
  br label %tmp_580

tmp_577:                                          ; preds = %tmp_567
  %tmp_579 = extractelement <4 x float> %tmp_570, i32 2
  br label %tmp_580

tmp_580:                                          ; preds = %tmp_577, %tmp_574
  %tmp_581 = phi float [ %tmp_576, %tmp_574 ], [ %tmp_579, %tmp_577 ]
  %tmp_583 = insertelement <4 x float> %tmp_570, float %tmp_581, i32 2
  %tmp_585 = extractelement <4 x i32> %tmp_544, i32 3
  %tmp_586 = icmp ne i32 %tmp_585, 0
  br i1 %tmp_586, label %tmp_587, label %tmp_590

tmp_587:                                          ; preds = %tmp_580
  %tmp_589 = extractelement <4 x float> %tmp_480, i32 3
  br label %tmp_593

tmp_590:                                          ; preds = %tmp_580
  %tmp_592 = extractelement <4 x float> %tmp_583, i32 3
  br label %tmp_593

tmp_593:                                          ; preds = %tmp_590, %tmp_587
  %tmp_594 = phi float [ %tmp_589, %tmp_587 ], [ %tmp_592, %tmp_590 ]
  %tmp_596 = insertelement <4 x float> %tmp_583, float %tmp_594, i32 3
  %tmp_598 = extractelement <4 x i32> %tmp_544, i32 0
  %tmp_599 = icmp ne i32 %tmp_598, 0
  br i1 %tmp_599, label %tmp_600, label %tmp_603

tmp_600:                                          ; preds = %tmp_593
  %tmp_602 = extractelement <4 x float> %tmp_488, i32 0
  br label %tmp_606

tmp_603:                                          ; preds = %tmp_593
  %tmp_605 = extractelement <4 x float> %savy.0, i32 0
  br label %tmp_606

tmp_606:                                          ; preds = %tmp_603, %tmp_600
  %tmp_607 = phi float [ %tmp_602, %tmp_600 ], [ %tmp_605, %tmp_603 ]
  %tmp_609 = insertelement <4 x float> %savy.0, float %tmp_607, i32 0
  %tmp_611 = extractelement <4 x i32> %tmp_544, i32 1
  %tmp_612 = icmp ne i32 %tmp_611, 0
  br i1 %tmp_612, label %tmp_613, label %tmp_616

tmp_613:                                          ; preds = %tmp_606
  %tmp_615 = extractelement <4 x float> %tmp_488, i32 1
  br label %tmp_619

tmp_616:                                          ; preds = %tmp_606
  %tmp_618 = extractelement <4 x float> %tmp_609, i32 1
  br label %tmp_619

tmp_619:                                          ; preds = %tmp_616, %tmp_613
  %tmp_620 = phi float [ %tmp_615, %tmp_613 ], [ %tmp_618, %tmp_616 ]
  %tmp_622 = insertelement <4 x float> %tmp_609, float %tmp_620, i32 1
  %tmp_624 = extractelement <4 x i32> %tmp_544, i32 2
  %tmp_625 = icmp ne i32 %tmp_624, 0
  br i1 %tmp_625, label %tmp_626, label %tmp_629

tmp_626:                                          ; preds = %tmp_619
  %tmp_628 = extractelement <4 x float> %tmp_488, i32 2
  br label %tmp_632

tmp_629:                                          ; preds = %tmp_619
  %tmp_631 = extractelement <4 x float> %tmp_622, i32 2
  br label %tmp_632

tmp_632:                                          ; preds = %tmp_629, %tmp_626
  %tmp_633 = phi float [ %tmp_628, %tmp_626 ], [ %tmp_631, %tmp_629 ]
  %tmp_635 = insertelement <4 x float> %tmp_622, float %tmp_633, i32 2
  %tmp_637 = extractelement <4 x i32> %tmp_544, i32 3
  %tmp_638 = icmp ne i32 %tmp_637, 0
  br i1 %tmp_638, label %tmp_639, label %tmp_642

tmp_639:                                          ; preds = %tmp_632
  %tmp_641 = extractelement <4 x float> %tmp_488, i32 3
  br label %tmp_645

tmp_642:                                          ; preds = %tmp_632
  %tmp_644 = extractelement <4 x float> %tmp_635, i32 3
  br label %tmp_645

tmp_645:                                          ; preds = %tmp_642, %tmp_639
  %tmp_646 = phi float [ %tmp_641, %tmp_639 ], [ %tmp_644, %tmp_642 ]
  %tmp_648 = insertelement <4 x float> %tmp_635, float %tmp_646, i32 3
  %tmp_650 = mul <4 x i32> %tmp_544, <i32 16, i32 16, i32 16, i32 16>
  %tmp_652 = add <4 x i32> %ccount.0, %tmp_650
  br label %tmp_653

tmp_653:                                          ; preds = %tmp_645
  %tmp_655 = add i32 %iter.0, 16
  br label %tmp_165

tmp_656:                                          ; preds = %tmp_178, %tmp_165
  %tmp_658 = extractelement <4 x i32> %stay.0, i32 0
  %tmp_660 = extractelement <4 x i32> %stay.0, i32 1
  %tmp_661 = and i32 %tmp_658, %tmp_660
  %tmp_663 = extractelement <4 x i32> %stay.0, i32 2
  %tmp_664 = and i32 %tmp_661, %tmp_663
  %tmp_666 = extractelement <4 x i32> %stay.0, i32 3
  %tmp_667 = and i32 %tmp_664, %tmp_666
  %tmp_668 = icmp ne i32 %tmp_667, 0
  br i1 %tmp_668, label %tmp_905, label %tmp_669

tmp_669:                                          ; preds = %tmp_656
  br label %tmp_670

tmp_670:                                          ; preds = %tmp_902, %tmp_669
  %iter.1 = phi i32 [ 16, %tmp_669 ], [ %tmp_781, %tmp_902 ]
  %stay.1 = phi <4 x i32> [ %stay.0, %tmp_669 ], [ %tmp_756, %tmp_902 ]
  %ccount.1 = phi <4 x i32> [ %ccount.0, %tmp_669 ], [ %tmp_779, %tmp_902 ]
  %savx.1 = phi <4 x float> [ %savx.0, %tmp_669 ], [ %tmp_833, %tmp_902 ]
  %savy.1 = phi <4 x float> [ %savy.0, %tmp_669 ], [ %tmp_885, %tmp_902 ]
  %tmp_674 = extractelement <4 x float> %savx.1, i32 0
  %tmp_676 = extractelement <4 x float> %savx.1, i32 0
  %tmp_678 = extractelement <4 x float> %savy.1, i32 0
  %tmp_680 = extractelement <4 x float> %savy.1, i32 0
  %tmp_681 = fmul float %tmp_678, %tmp_680
  %tmp_682 = call float @llvm.fmuladd.f32(float %tmp_674, float %tmp_676, float %tmp_681)
  %tmp_683 = fcmp ole float %tmp_682, 4.000000e+00
  br i1 %tmp_683, label %tmp_684, label %tmp_689

tmp_684:                                          ; preds = %tmp_670
  %tmp_686 = extractelement <4 x i32> %ccount.1, i32 0
  %tmp_688 = icmp ult i32 %tmp_686, %maxIterations
  br label %tmp_689

tmp_689:                                          ; preds = %tmp_684, %tmp_670
  %tmp_690 = phi i1 [ false, %tmp_670 ], [ %tmp_688, %tmp_684 ]
  %tmp_691 = zext i1 %tmp_690 to i32
  %tmp_693 = insertelement <4 x i32> %stay.1, i32 %tmp_691, i32 0
  %tmp_695 = extractelement <4 x float> %savx.1, i32 1
  %tmp_697 = extractelement <4 x float> %savx.1, i32 1
  %tmp_699 = extractelement <4 x float> %savy.1, i32 1
  %tmp_701 = extractelement <4 x float> %savy.1, i32 1
  %tmp_702 = fmul float %tmp_699, %tmp_701
  %tmp_703 = call float @llvm.fmuladd.f32(float %tmp_695, float %tmp_697, float %tmp_702)
  %tmp_704 = fcmp ole float %tmp_703, 4.000000e+00
  br i1 %tmp_704, label %tmp_705, label %tmp_710

tmp_705:                                          ; preds = %tmp_689
  %tmp_707 = extractelement <4 x i32> %ccount.1, i32 1
  %tmp_709 = icmp ult i32 %tmp_707, %maxIterations
  br label %tmp_710

tmp_710:                                          ; preds = %tmp_705, %tmp_689
  %tmp_711 = phi i1 [ false, %tmp_689 ], [ %tmp_709, %tmp_705 ]
  %tmp_712 = zext i1 %tmp_711 to i32
  %tmp_714 = insertelement <4 x i32> %tmp_693, i32 %tmp_712, i32 1
  %tmp_716 = extractelement <4 x float> %savx.1, i32 2
  %tmp_718 = extractelement <4 x float> %savx.1, i32 2
  %tmp_720 = extractelement <4 x float> %savy.1, i32 2
  %tmp_722 = extractelement <4 x float> %savy.1, i32 2
  %tmp_723 = fmul float %tmp_720, %tmp_722
  %tmp_724 = call float @llvm.fmuladd.f32(float %tmp_716, float %tmp_718, float %tmp_723)
  %tmp_725 = fcmp ole float %tmp_724, 4.000000e+00
  br i1 %tmp_725, label %tmp_726, label %tmp_731

tmp_726:                                          ; preds = %tmp_710
  %tmp_728 = extractelement <4 x i32> %ccount.1, i32 2
  %tmp_730 = icmp ult i32 %tmp_728, %maxIterations
  br label %tmp_731

tmp_731:                                          ; preds = %tmp_726, %tmp_710
  %tmp_732 = phi i1 [ false, %tmp_710 ], [ %tmp_730, %tmp_726 ]
  %tmp_733 = zext i1 %tmp_732 to i32
  %tmp_735 = insertelement <4 x i32> %tmp_714, i32 %tmp_733, i32 2
  %tmp_737 = extractelement <4 x float> %savx.1, i32 3
  %tmp_739 = extractelement <4 x float> %savx.1, i32 3
  %tmp_741 = extractelement <4 x float> %savy.1, i32 3
  %tmp_743 = extractelement <4 x float> %savy.1, i32 3
  %tmp_744 = fmul float %tmp_741, %tmp_743
  %tmp_745 = call float @llvm.fmuladd.f32(float %tmp_737, float %tmp_739, float %tmp_744)
  %tmp_746 = fcmp ole float %tmp_745, 4.000000e+00
  br i1 %tmp_746, label %tmp_747, label %tmp_752

tmp_747:                                          ; preds = %tmp_731
  %tmp_749 = extractelement <4 x i32> %ccount.1, i32 3
  %tmp_751 = icmp ult i32 %tmp_749, %maxIterations
  br label %tmp_752

tmp_752:                                          ; preds = %tmp_747, %tmp_731
  %tmp_753 = phi i1 [ false, %tmp_731 ], [ %tmp_751, %tmp_747 ]
  %tmp_754 = zext i1 %tmp_753 to i32
  %tmp_756 = insertelement <4 x i32> %tmp_735, i32 %tmp_754, i32 3
  %tmp_759 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.1
  %tmp_764 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %savx.1, <4 x float> %savx.1, <4 x float> %tmp_72)
  %tmp_765 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %tmp_759, <4 x float> %savy.1, i32 %tmp_764)
  %tmp_766 = sitofp i32 %tmp_765 to float
  %tmp_767 = insertelement <4 x float> undef, float %tmp_766, i32 0
  %tmp_768 = shufflevector <4 x float> %tmp_767, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_770 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %savx.1
  %tmp_773 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %tmp_770, <4 x float> %savy.1, <4 x float> %tmp_104)
  %tmp_774 = sitofp i32 %tmp_773 to float
  %tmp_775 = insertelement <4 x float> undef, float %tmp_774, i32 0
  %tmp_776 = shufflevector <4 x float> %tmp_775, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_779 = add <4 x i32> %ccount.1, %tmp_756
  %tmp_781 = add i32 %iter.1, -1
  %tmp_783 = extractelement <4 x i32> %tmp_756, i32 0
  %tmp_784 = icmp ne i32 %tmp_783, 0
  br i1 %tmp_784, label %tmp_785, label %tmp_788

tmp_785:                                          ; preds = %tmp_752
  %tmp_787 = extractelement <4 x float> %tmp_768, i32 0
  br label %tmp_791

tmp_788:                                          ; preds = %tmp_752
  %tmp_790 = extractelement <4 x float> %savx.1, i32 0
  br label %tmp_791

tmp_791:                                          ; preds = %tmp_788, %tmp_785
  %tmp_792 = phi float [ %tmp_787, %tmp_785 ], [ %tmp_790, %tmp_788 ]
  %tmp_794 = insertelement <4 x float> %savx.1, float %tmp_792, i32 0
  %tmp_796 = extractelement <4 x i32> %tmp_756, i32 1
  %tmp_797 = icmp ne i32 %tmp_796, 0
  br i1 %tmp_797, label %tmp_798, label %tmp_801

tmp_798:                                          ; preds = %tmp_791
  %tmp_800 = extractelement <4 x float> %tmp_768, i32 1
  br label %tmp_804

tmp_801:                                          ; preds = %tmp_791
  %tmp_803 = extractelement <4 x float> %tmp_794, i32 1
  br label %tmp_804

tmp_804:                                          ; preds = %tmp_801, %tmp_798
  %tmp_805 = phi float [ %tmp_800, %tmp_798 ], [ %tmp_803, %tmp_801 ]
  %tmp_807 = insertelement <4 x float> %tmp_794, float %tmp_805, i32 1
  %tmp_809 = extractelement <4 x i32> %tmp_756, i32 2
  %tmp_810 = icmp ne i32 %tmp_809, 0
  br i1 %tmp_810, label %tmp_811, label %tmp_814

tmp_811:                                          ; preds = %tmp_804
  %tmp_813 = extractelement <4 x float> %tmp_768, i32 2
  br label %tmp_817

tmp_814:                                          ; preds = %tmp_804
  %tmp_816 = extractelement <4 x float> %tmp_807, i32 2
  br label %tmp_817

tmp_817:                                          ; preds = %tmp_814, %tmp_811
  %tmp_818 = phi float [ %tmp_813, %tmp_811 ], [ %tmp_816, %tmp_814 ]
  %tmp_820 = insertelement <4 x float> %tmp_807, float %tmp_818, i32 2
  %tmp_822 = extractelement <4 x i32> %tmp_756, i32 3
  %tmp_823 = icmp ne i32 %tmp_822, 0
  br i1 %tmp_823, label %tmp_824, label %tmp_827

tmp_824:                                          ; preds = %tmp_817
  %tmp_826 = extractelement <4 x float> %tmp_768, i32 3
  br label %tmp_830

tmp_827:                                          ; preds = %tmp_817
  %tmp_829 = extractelement <4 x float> %tmp_820, i32 3
  br label %tmp_830

tmp_830:                                          ; preds = %tmp_827, %tmp_824
  %tmp_831 = phi float [ %tmp_826, %tmp_824 ], [ %tmp_829, %tmp_827 ]
  %tmp_833 = insertelement <4 x float> %tmp_820, float %tmp_831, i32 3
  %tmp_835 = extractelement <4 x i32> %tmp_756, i32 0
  %tmp_836 = icmp ne i32 %tmp_835, 0
  br i1 %tmp_836, label %tmp_837, label %tmp_840

tmp_837:                                          ; preds = %tmp_830
  %tmp_839 = extractelement <4 x float> %tmp_776, i32 0
  br label %tmp_843

tmp_840:                                          ; preds = %tmp_830
  %tmp_842 = extractelement <4 x float> %savy.1, i32 0
  br label %tmp_843

tmp_843:                                          ; preds = %tmp_840, %tmp_837
  %tmp_844 = phi float [ %tmp_839, %tmp_837 ], [ %tmp_842, %tmp_840 ]
  %tmp_846 = insertelement <4 x float> %savy.1, float %tmp_844, i32 0
  %tmp_848 = extractelement <4 x i32> %tmp_756, i32 1
  %tmp_849 = icmp ne i32 %tmp_848, 0
  br i1 %tmp_849, label %tmp_850, label %tmp_853

tmp_850:                                          ; preds = %tmp_843
  %tmp_852 = extractelement <4 x float> %tmp_776, i32 1
  br label %tmp_856

tmp_853:                                          ; preds = %tmp_843
  %tmp_855 = extractelement <4 x float> %tmp_846, i32 1
  br label %tmp_856

tmp_856:                                          ; preds = %tmp_853, %tmp_850
  %tmp_857 = phi float [ %tmp_852, %tmp_850 ], [ %tmp_855, %tmp_853 ]
  %tmp_859 = insertelement <4 x float> %tmp_846, float %tmp_857, i32 1
  %tmp_861 = extractelement <4 x i32> %tmp_756, i32 2
  %tmp_862 = icmp ne i32 %tmp_861, 0
  br i1 %tmp_862, label %tmp_863, label %tmp_866

tmp_863:                                          ; preds = %tmp_856
  %tmp_865 = extractelement <4 x float> %tmp_776, i32 2
  br label %tmp_869

tmp_866:                                          ; preds = %tmp_856
  %tmp_868 = extractelement <4 x float> %tmp_859, i32 2
  br label %tmp_869

tmp_869:                                          ; preds = %tmp_866, %tmp_863
  %tmp_870 = phi float [ %tmp_865, %tmp_863 ], [ %tmp_868, %tmp_866 ]
  %tmp_872 = insertelement <4 x float> %tmp_859, float %tmp_870, i32 2
  %tmp_874 = extractelement <4 x i32> %tmp_756, i32 3
  %tmp_875 = icmp ne i32 %tmp_874, 0
  br i1 %tmp_875, label %tmp_876, label %tmp_879

tmp_876:                                          ; preds = %tmp_869
  %tmp_878 = extractelement <4 x float> %tmp_776, i32 3
  br label %tmp_882

tmp_879:                                          ; preds = %tmp_869
  %tmp_881 = extractelement <4 x float> %tmp_872, i32 3
  br label %tmp_882

tmp_882:                                          ; preds = %tmp_879, %tmp_876
  %tmp_883 = phi float [ %tmp_878, %tmp_876 ], [ %tmp_881, %tmp_879 ]
  %tmp_885 = insertelement <4 x float> %tmp_872, float %tmp_883, i32 3
  br label %tmp_886

tmp_886:                                          ; preds = %tmp_882
  %tmp_888 = extractelement <4 x i32> %tmp_756, i32 0
  %tmp_890 = extractelement <4 x i32> %tmp_756, i32 1
  %tmp_891 = or i32 %tmp_888, %tmp_890
  %tmp_893 = extractelement <4 x i32> %tmp_756, i32 2
  %tmp_894 = or i32 %tmp_891, %tmp_893
  %tmp_896 = extractelement <4 x i32> %tmp_756, i32 3
  %tmp_897 = or i32 %tmp_894, %tmp_896
  %tmp_898 = icmp ne i32 %tmp_897, 0
  br i1 %tmp_898, label %tmp_899, label %tmp_902

tmp_899:                                          ; preds = %tmp_886
  %tmp_901 = icmp ne i32 %tmp_781, 0
  br label %tmp_902

tmp_902:                                          ; preds = %tmp_899, %tmp_886
  %tmp_903 = phi i1 [ false, %tmp_886 ], [ %tmp_901, %tmp_899 ]
  br i1 %tmp_903, label %tmp_670, label %tmp_904

tmp_904:                                          ; preds = %tmp_902
  br label %tmp_905

tmp_905:                                          ; preds = %tmp_904, %tmp_656
  %ccount.2 = phi <4 x i32> [ %ccount.0, %tmp_656 ], [ %tmp_779, %tmp_904 ]
  %savx.2 = phi <4 x float> [ %savx.0, %tmp_656 ], [ %tmp_833, %tmp_904 ]
  %savy.2 = phi <4 x float> [ %savy.0, %tmp_656 ], [ %tmp_885, %tmp_904 ]
  %tmp_909 = call <4 x float> @_Z14convert_float4Dv4_i(<4 x i32> %ccount.2)
  %tmp_911 = extractelement <4 x i32> %ccount.2, i32 0
  %tmp_912 = sitofp i32 %tmp_911 to float
  %tmp_913 = fadd float %tmp_912, 1.000000e+00
  %tmp_915 = extractelement <4 x float> %savx.2, i32 0
  %tmp_917 = extractelement <4 x float> %savx.2, i32 0
  %tmp_919 = extractelement <4 x float> %savy.2, i32 0
  %tmp_921 = extractelement <4 x float> %savy.2, i32 0
  %tmp_922 = fmul float %tmp_919, %tmp_921
  %tmp_923 = call float @llvm.fmuladd.f32(float %tmp_915, float %tmp_917, float %tmp_922)
  %tmp_924 = call float @llvm.log2.f32(float %tmp_923)
  %tmp_925 = call float @llvm.log2.f32(float %tmp_924)
  %tmp_926 = fsub float %tmp_913, %tmp_925
  %tmp_928 = insertelement <4 x float> %tmp_909, float %tmp_926, i32 0
  %tmp_930 = extractelement <4 x i32> %ccount.2, i32 1
  %tmp_931 = sitofp i32 %tmp_930 to float
  %tmp_932 = fadd float %tmp_931, 1.000000e+00
  %tmp_934 = extractelement <4 x float> %savx.2, i32 1
  %tmp_936 = extractelement <4 x float> %savx.2, i32 1
  %tmp_938 = extractelement <4 x float> %savy.2, i32 1
  %tmp_940 = extractelement <4 x float> %savy.2, i32 1
  %tmp_941 = fmul float %tmp_938, %tmp_940
  %tmp_942 = call float @llvm.fmuladd.f32(float %tmp_934, float %tmp_936, float %tmp_941)
  %tmp_943 = call float @llvm.log2.f32(float %tmp_942)
  %tmp_944 = call float @llvm.log2.f32(float %tmp_943)
  %tmp_945 = fsub float %tmp_932, %tmp_944
  %tmp_947 = insertelement <4 x float> %tmp_928, float %tmp_945, i32 1
  %tmp_949 = extractelement <4 x i32> %ccount.2, i32 2
  %tmp_950 = sitofp i32 %tmp_949 to float
  %tmp_951 = fadd float %tmp_950, 1.000000e+00
  %tmp_953 = extractelement <4 x float> %savx.2, i32 2
  %tmp_955 = extractelement <4 x float> %savx.2, i32 2
  %tmp_957 = extractelement <4 x float> %savy.2, i32 2
  %tmp_959 = extractelement <4 x float> %savy.2, i32 2
  %tmp_960 = fmul float %tmp_957, %tmp_959
  %tmp_961 = call float @llvm.fmuladd.f32(float %tmp_953, float %tmp_955, float %tmp_960)
  %tmp_962 = call float @llvm.log2.f32(float %tmp_961)
  %tmp_963 = call float @llvm.log2.f32(float %tmp_962)
  %tmp_964 = fsub float %tmp_951, %tmp_963
  %tmp_966 = insertelement <4 x float> %tmp_947, float %tmp_964, i32 2
  %tmp_968 = extractelement <4 x i32> %ccount.2, i32 3
  %tmp_969 = sitofp i32 %tmp_968 to float
  %tmp_970 = fadd float %tmp_969, 1.000000e+00
  %tmp_972 = extractelement <4 x float> %savx.2, i32 3
  %tmp_974 = extractelement <4 x float> %savx.2, i32 3
  %tmp_976 = extractelement <4 x float> %savy.2, i32 3
  %tmp_978 = extractelement <4 x float> %savy.2, i32 3
  %tmp_979 = fmul float %tmp_976, %tmp_978
  %tmp_980 = call float @llvm.fmuladd.f32(float %tmp_972, float %tmp_974, float %tmp_979)
  %tmp_981 = call float @llvm.log2.f32(float %tmp_980)
  %tmp_982 = call float @llvm.log2.f32(float %tmp_981)
  %tmp_983 = fsub float %tmp_970, %tmp_982
  %tmp_985 = insertelement <4 x float> %tmp_966, float %tmp_983, i32 3
  %tmp_987 = extractelement <4 x float> %tmp_985, i32 0
  %tmp_988 = fmul float %tmp_987, 2.000000e+00
  %tmp_989 = fmul float %tmp_988, 0x400921FF20000000
  %tmp_990 = fdiv float %tmp_989, 2.560000e+02, !fpmath !2
  %tmp_992 = call float @_Z3cosf(float %tmp_990)
  %tmp_993 = fadd float 1.000000e+00, %tmp_992
  %tmp_994 = fmul float %tmp_993, 5.000000e-01
  %tmp_995 = fmul float %tmp_994, 2.550000e+02
  %tmp_996 = fptoui float %tmp_995 to i8
  %tmp_997 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_998 = load <4 x i8>* %tmp_997, align 4
  %tmp_999 = insertelement <4 x i8> %tmp_998, i8 %tmp_996, i32 0
  store <4 x i8> %tmp_999, <4 x i8>* %tmp_997, align 4
  %tmp_1001 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %tmp_990, float 0x4000C154C0000000)
  %tmp_1002 = call float @_Z3cosf(float %tmp_1001)
  %tmp_1003 = fadd float 1.000000e+00, %tmp_1002
  %tmp_1004 = fmul float %tmp_1003, 5.000000e-01
  %tmp_1005 = fmul float %tmp_1004, 2.550000e+02
  %tmp_1006 = fptoui float %tmp_1005 to i8
  %tmp_1007 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1008 = load <4 x i8>* %tmp_1007, align 4
  %tmp_1009 = insertelement <4 x i8> %tmp_1008, i8 %tmp_1006, i32 1
  store <4 x i8> %tmp_1009, <4 x i8>* %tmp_1007, align 4
  %tmp_1011 = fsub float %tmp_990, 0x4000C154C0000000
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
  %tmp_1024 = extractelement <4 x i32> %ccount.2, i32 0
  %tmp_1026 = icmp eq i32 %tmp_1024, %maxIterations
  br i1 %tmp_1026, label %tmp_1027, label %tmp_1037

tmp_1027:                                         ; preds = %tmp_905
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

tmp_1037:                                         ; preds = %tmp_1027, %tmp_905
  %tmp_1039 = icmp ne i32 %bench, 0
  br i1 %tmp_1039, label %tmp_1040, label %tmp_1072

tmp_1040:                                         ; preds = %tmp_1037
  %tmp_1042 = extractelement <4 x i32> %ccount.2, i32 0
  %tmp_1043 = and i32 %tmp_1042, 255
  %tmp_1044 = trunc i32 %tmp_1043 to i8
  %tmp_1045 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1046 = load <4 x i8>* %tmp_1045, align 4
  %tmp_1047 = insertelement <4 x i8> %tmp_1046, i8 %tmp_1044, i32 0
  store <4 x i8> %tmp_1047, <4 x i8>* %tmp_1045, align 4
  %tmp_1049 = extractelement <4 x i32> %ccount.2, i32 0
  %tmp_1050 = and i32 %tmp_1049, 65280
  %tmp_1051 = ashr i32 %tmp_1050, 8
  %tmp_1052 = trunc i32 %tmp_1051 to i8
  %tmp_1053 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1054 = load <4 x i8>* %tmp_1053, align 4
  %tmp_1055 = insertelement <4 x i8> %tmp_1054, i8 %tmp_1052, i32 1
  store <4 x i8> %tmp_1055, <4 x i8>* %tmp_1053, align 4
  %tmp_1057 = extractelement <4 x i32> %ccount.2, i32 0
  %tmp_1058 = and i32 %tmp_1057, 16711680
  %tmp_1059 = ashr i32 %tmp_1058, 16
  %tmp_1060 = trunc i32 %tmp_1059 to i8
  %tmp_1061 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1062 = load <4 x i8>* %tmp_1061, align 4
  %tmp_1063 = insertelement <4 x i8> %tmp_1062, i8 %tmp_1060, i32 2
  store <4 x i8> %tmp_1063, <4 x i8>* %tmp_1061, align 4
  %tmp_1065 = extractelement <4 x i32> %ccount.2, i32 0
  %tmp_1066 = and i32 %tmp_1065, -16777216
  %tmp_1067 = lshr i32 %tmp_1066, 24
  %tmp_1068 = trunc i32 %tmp_1067 to i8
  %tmp_1069 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1070 = load <4 x i8>* %tmp_1069, align 4
  %tmp_1071 = insertelement <4 x i8> %tmp_1070, i8 %tmp_1068, i32 3
  store <4 x i8> %tmp_1071, <4 x i8>* %tmp_1069, align 4
  br label %tmp_1072

tmp_1072:                                         ; preds = %tmp_1040, %tmp_1037
  %tmp_1073 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %tmp_1074 = load <4 x i8>* %tmp_1073, align 4
  %tmp_1076 = mul nsw i32 4, %tmp_9
  %tmp_1078 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %tmp_1076
  store <4 x i8> %tmp_1074, <4 x i8> addrspace(1)* %tmp_1078, align 4
  %tmp_1080 = extractelement <4 x float> %tmp_985, i32 1
  %tmp_1081 = fmul float %tmp_1080, 2.000000e+00
  %tmp_1082 = fmul float %tmp_1081, 0x400921FF20000000
  %tmp_1083 = fdiv float %tmp_1082, 2.560000e+02, !fpmath !2
  %tmp_1085 = call float @_Z3cosf(float %tmp_1083)
  %tmp_1086 = fadd float 1.000000e+00, %tmp_1085
  %tmp_1087 = fmul float %tmp_1086, 5.000000e-01
  %tmp_1088 = fmul float %tmp_1087, 2.550000e+02
  %tmp_1089 = fptoui float %tmp_1088 to i8
  %tmp_1090 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1091 = load <4 x i8>* %tmp_1090, align 4
  %tmp_1092 = insertelement <4 x i8> %tmp_1091, i8 %tmp_1089, i32 0
  store <4 x i8> %tmp_1092, <4 x i8>* %tmp_1090, align 4
  %tmp_1094 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %tmp_1083, float 0x4000C154C0000000)
  %tmp_1095 = call float @_Z3cosf(float %tmp_1094)
  %tmp_1096 = fadd float 1.000000e+00, %tmp_1095
  %tmp_1097 = fmul float %tmp_1096, 5.000000e-01
  %tmp_1098 = fmul float %tmp_1097, 2.550000e+02
  %tmp_1099 = fptoui float %tmp_1098 to i8
  %tmp_1100 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1101 = load <4 x i8>* %tmp_1100, align 4
  %tmp_1102 = insertelement <4 x i8> %tmp_1101, i8 %tmp_1099, i32 1
  store <4 x i8> %tmp_1102, <4 x i8>* %tmp_1100, align 4
  %tmp_1104 = fsub float %tmp_1083, 0x4000C154C0000000
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
  %tmp_1117 = extractelement <4 x i32> %ccount.2, i32 1
  %tmp_1119 = icmp eq i32 %tmp_1117, %maxIterations
  br i1 %tmp_1119, label %tmp_1120, label %tmp_1130

tmp_1120:                                         ; preds = %tmp_1072
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

tmp_1130:                                         ; preds = %tmp_1120, %tmp_1072
  %tmp_1132 = icmp ne i32 %bench, 0
  br i1 %tmp_1132, label %tmp_1133, label %tmp_1165

tmp_1133:                                         ; preds = %tmp_1130
  %tmp_1135 = extractelement <4 x i32> %ccount.2, i32 1
  %tmp_1136 = and i32 %tmp_1135, 255
  %tmp_1137 = trunc i32 %tmp_1136 to i8
  %tmp_1138 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1139 = load <4 x i8>* %tmp_1138, align 4
  %tmp_1140 = insertelement <4 x i8> %tmp_1139, i8 %tmp_1137, i32 0
  store <4 x i8> %tmp_1140, <4 x i8>* %tmp_1138, align 4
  %tmp_1142 = extractelement <4 x i32> %ccount.2, i32 1
  %tmp_1143 = and i32 %tmp_1142, 65280
  %tmp_1144 = ashr i32 %tmp_1143, 8
  %tmp_1145 = trunc i32 %tmp_1144 to i8
  %tmp_1146 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1147 = load <4 x i8>* %tmp_1146, align 4
  %tmp_1148 = insertelement <4 x i8> %tmp_1147, i8 %tmp_1145, i32 1
  store <4 x i8> %tmp_1148, <4 x i8>* %tmp_1146, align 4
  %tmp_1150 = extractelement <4 x i32> %ccount.2, i32 1
  %tmp_1151 = and i32 %tmp_1150, 16711680
  %tmp_1152 = ashr i32 %tmp_1151, 16
  %tmp_1153 = trunc i32 %tmp_1152 to i8
  %tmp_1154 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1155 = load <4 x i8>* %tmp_1154, align 4
  %tmp_1156 = insertelement <4 x i8> %tmp_1155, i8 %tmp_1153, i32 2
  store <4 x i8> %tmp_1156, <4 x i8>* %tmp_1154, align 4
  %tmp_1158 = extractelement <4 x i32> %ccount.2, i32 1
  %tmp_1159 = and i32 %tmp_1158, -16777216
  %tmp_1160 = lshr i32 %tmp_1159, 24
  %tmp_1161 = trunc i32 %tmp_1160 to i8
  %tmp_1162 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1163 = load <4 x i8>* %tmp_1162, align 4
  %tmp_1164 = insertelement <4 x i8> %tmp_1163, i8 %tmp_1161, i32 3
  store <4 x i8> %tmp_1164, <4 x i8>* %tmp_1162, align 4
  br label %tmp_1165

tmp_1165:                                         ; preds = %tmp_1133, %tmp_1130
  %tmp_1166 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %tmp_1167 = load <4 x i8>* %tmp_1166, align 4
  %tmp_1169 = mul nsw i32 4, %tmp_9
  %tmp_1170 = add nsw i32 %tmp_1169, 1
  %tmp_1172 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %tmp_1170
  store <4 x i8> %tmp_1167, <4 x i8> addrspace(1)* %tmp_1172, align 4
  %tmp_1174 = extractelement <4 x float> %tmp_985, i32 2
  %tmp_1175 = fmul float %tmp_1174, 2.000000e+00
  %tmp_1176 = fmul float %tmp_1175, 0x400921FF20000000
  %tmp_1177 = fdiv float %tmp_1176, 2.560000e+02, !fpmath !2
  %tmp_1179 = call float @_Z3cosf(float %tmp_1177)
  %tmp_1180 = fadd float 1.000000e+00, %tmp_1179
  %tmp_1181 = fmul float %tmp_1180, 5.000000e-01
  %tmp_1182 = fmul float %tmp_1181, 2.550000e+02
  %tmp_1183 = fptoui float %tmp_1182 to i8
  %tmp_1184 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1185 = load <4 x i8>* %tmp_1184, align 4
  %tmp_1186 = insertelement <4 x i8> %tmp_1185, i8 %tmp_1183, i32 0
  store <4 x i8> %tmp_1186, <4 x i8>* %tmp_1184, align 4
  %tmp_1188 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %tmp_1177, float 0x4000C154C0000000)
  %tmp_1189 = call float @_Z3cosf(float %tmp_1188)
  %tmp_1190 = fadd float 1.000000e+00, %tmp_1189
  %tmp_1191 = fmul float %tmp_1190, 5.000000e-01
  %tmp_1192 = fmul float %tmp_1191, 2.550000e+02
  %tmp_1193 = fptoui float %tmp_1192 to i8
  %tmp_1194 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1195 = load <4 x i8>* %tmp_1194, align 4
  %tmp_1196 = insertelement <4 x i8> %tmp_1195, i8 %tmp_1193, i32 1
  store <4 x i8> %tmp_1196, <4 x i8>* %tmp_1194, align 4
  %tmp_1198 = fsub float %tmp_1177, 0x4000C154C0000000
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
  %tmp_1211 = extractelement <4 x i32> %ccount.2, i32 2
  %tmp_1213 = icmp eq i32 %tmp_1211, %maxIterations
  br i1 %tmp_1213, label %tmp_1214, label %tmp_1224

tmp_1214:                                         ; preds = %tmp_1165
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

tmp_1224:                                         ; preds = %tmp_1214, %tmp_1165
  %tmp_1226 = icmp ne i32 %bench, 0
  br i1 %tmp_1226, label %tmp_1227, label %tmp_1259

tmp_1227:                                         ; preds = %tmp_1224
  %tmp_1229 = extractelement <4 x i32> %ccount.2, i32 2
  %tmp_1230 = and i32 %tmp_1229, 255
  %tmp_1231 = trunc i32 %tmp_1230 to i8
  %tmp_1232 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1233 = load <4 x i8>* %tmp_1232, align 4
  %tmp_1234 = insertelement <4 x i8> %tmp_1233, i8 %tmp_1231, i32 0
  store <4 x i8> %tmp_1234, <4 x i8>* %tmp_1232, align 4
  %tmp_1236 = extractelement <4 x i32> %ccount.2, i32 2
  %tmp_1237 = and i32 %tmp_1236, 65280
  %tmp_1238 = ashr i32 %tmp_1237, 8
  %tmp_1239 = trunc i32 %tmp_1238 to i8
  %tmp_1240 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1241 = load <4 x i8>* %tmp_1240, align 4
  %tmp_1242 = insertelement <4 x i8> %tmp_1241, i8 %tmp_1239, i32 1
  store <4 x i8> %tmp_1242, <4 x i8>* %tmp_1240, align 4
  %tmp_1244 = extractelement <4 x i32> %ccount.2, i32 2
  %tmp_1245 = and i32 %tmp_1244, 16711680
  %tmp_1246 = ashr i32 %tmp_1245, 16
  %tmp_1247 = trunc i32 %tmp_1246 to i8
  %tmp_1248 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1249 = load <4 x i8>* %tmp_1248, align 4
  %tmp_1250 = insertelement <4 x i8> %tmp_1249, i8 %tmp_1247, i32 2
  store <4 x i8> %tmp_1250, <4 x i8>* %tmp_1248, align 4
  %tmp_1252 = extractelement <4 x i32> %ccount.2, i32 2
  %tmp_1253 = and i32 %tmp_1252, -16777216
  %tmp_1254 = lshr i32 %tmp_1253, 24
  %tmp_1255 = trunc i32 %tmp_1254 to i8
  %tmp_1256 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1257 = load <4 x i8>* %tmp_1256, align 4
  %tmp_1258 = insertelement <4 x i8> %tmp_1257, i8 %tmp_1255, i32 3
  store <4 x i8> %tmp_1258, <4 x i8>* %tmp_1256, align 4
  br label %tmp_1259

tmp_1259:                                         ; preds = %tmp_1227, %tmp_1224
  %tmp_1260 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %tmp_1261 = load <4 x i8>* %tmp_1260, align 4
  %tmp_1263 = mul nsw i32 4, %tmp_9
  %tmp_1264 = add nsw i32 %tmp_1263, 2
  %tmp_1266 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %tmp_1264
  store <4 x i8> %tmp_1261, <4 x i8> addrspace(1)* %tmp_1266, align 4
  %tmp_1268 = extractelement <4 x float> %tmp_985, i32 3
  %tmp_1269 = fmul float %tmp_1268, 2.000000e+00
  %tmp_1270 = fmul float %tmp_1269, 0x400921FF20000000
  %tmp_1271 = fdiv float %tmp_1270, 2.560000e+02, !fpmath !2
  %tmp_1273 = call float @_Z3cosf(float %tmp_1271)
  %tmp_1274 = fadd float 1.000000e+00, %tmp_1273
  %tmp_1275 = fmul float %tmp_1274, 5.000000e-01
  %tmp_1276 = fmul float %tmp_1275, 2.550000e+02
  %tmp_1277 = fptoui float %tmp_1276 to i8
  %tmp_1278 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1279 = load <4 x i8>* %tmp_1278, align 4
  %tmp_1280 = insertelement <4 x i8> %tmp_1279, i8 %tmp_1277, i32 0
  store <4 x i8> %tmp_1280, <4 x i8>* %tmp_1278, align 4
  %tmp_1282 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %tmp_1271, float 0x4000C154C0000000)
  %tmp_1283 = call float @_Z3cosf(float %tmp_1282)
  %tmp_1284 = fadd float 1.000000e+00, %tmp_1283
  %tmp_1285 = fmul float %tmp_1284, 5.000000e-01
  %tmp_1286 = fmul float %tmp_1285, 2.550000e+02
  %tmp_1287 = fptoui float %tmp_1286 to i8
  %tmp_1288 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1289 = load <4 x i8>* %tmp_1288, align 4
  %tmp_1290 = insertelement <4 x i8> %tmp_1289, i8 %tmp_1287, i32 1
  store <4 x i8> %tmp_1290, <4 x i8>* %tmp_1288, align 4
  %tmp_1292 = fsub float %tmp_1271, 0x4000C154C0000000
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
  %tmp_1305 = extractelement <4 x i32> %ccount.2, i32 3
  %tmp_1307 = icmp eq i32 %tmp_1305, %maxIterations
  br i1 %tmp_1307, label %tmp_1308, label %tmp_1318

tmp_1308:                                         ; preds = %tmp_1259
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

tmp_1318:                                         ; preds = %tmp_1308, %tmp_1259
  %tmp_1320 = icmp ne i32 %bench, 0
  br i1 %tmp_1320, label %tmp_1321, label %tmp_1353

tmp_1321:                                         ; preds = %tmp_1318
  %tmp_1323 = extractelement <4 x i32> %ccount.2, i32 3
  %tmp_1324 = and i32 %tmp_1323, 255
  %tmp_1325 = trunc i32 %tmp_1324 to i8
  %tmp_1326 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1327 = load <4 x i8>* %tmp_1326, align 4
  %tmp_1328 = insertelement <4 x i8> %tmp_1327, i8 %tmp_1325, i32 0
  store <4 x i8> %tmp_1328, <4 x i8>* %tmp_1326, align 4
  %tmp_1330 = extractelement <4 x i32> %ccount.2, i32 3
  %tmp_1331 = and i32 %tmp_1330, 65280
  %tmp_1332 = ashr i32 %tmp_1331, 8
  %tmp_1333 = trunc i32 %tmp_1332 to i8
  %tmp_1334 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1335 = load <4 x i8>* %tmp_1334, align 4
  %tmp_1336 = insertelement <4 x i8> %tmp_1335, i8 %tmp_1333, i32 1
  store <4 x i8> %tmp_1336, <4 x i8>* %tmp_1334, align 4
  %tmp_1338 = extractelement <4 x i32> %ccount.2, i32 3
  %tmp_1339 = and i32 %tmp_1338, 16711680
  %tmp_1340 = ashr i32 %tmp_1339, 16
  %tmp_1341 = trunc i32 %tmp_1340 to i8
  %tmp_1342 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1343 = load <4 x i8>* %tmp_1342, align 4
  %tmp_1344 = insertelement <4 x i8> %tmp_1343, i8 %tmp_1341, i32 2
  store <4 x i8> %tmp_1344, <4 x i8>* %tmp_1342, align 4
  %tmp_1346 = extractelement <4 x i32> %ccount.2, i32 3
  %tmp_1347 = and i32 %tmp_1346, -16777216
  %tmp_1348 = lshr i32 %tmp_1347, 24
  %tmp_1349 = trunc i32 %tmp_1348 to i8
  %tmp_1350 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1351 = load <4 x i8>* %tmp_1350, align 4
  %tmp_1352 = insertelement <4 x i8> %tmp_1351, i8 %tmp_1349, i32 3
  store <4 x i8> %tmp_1352, <4 x i8>* %tmp_1350, align 4
  br label %tmp_1353

tmp_1353:                                         ; preds = %tmp_1321, %tmp_1318
  %tmp_1354 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %tmp_1355 = load <4 x i8>* %tmp_1354, align 4
  %tmp_1357 = mul nsw i32 4, %tmp_9
  %tmp_1358 = add nsw i32 %tmp_1357, 3
  %tmp_1360 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %tmp_1358
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

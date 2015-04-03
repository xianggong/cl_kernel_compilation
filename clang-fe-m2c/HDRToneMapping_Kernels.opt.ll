; ModuleID = 'HDRToneMapping_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define float @luminance(float %r, float %g, float %b) #0 {
  %tmp_6 = fmul float 0x3FE6E2EB20000000, %g
  %tmp_7 = call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %r, float %tmp_6)
  %tmp_9 = call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %b, float %tmp_7)
  ret float %tmp_9
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind
define void @toneMappingPattanaik1(float addrspace(1)* %input, float addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
  %tmp_10 = call i32 @__get_global_id_u32(i32 0)
  %tmp_11 = call i32 @__get_global_id_u32(i32 1)
  %tmp_14 = mul i32 %width, %numChannels
  %tmp_16 = mul i32 %tmp_14, %tmp_11
  %tmp_19 = mul i32 %tmp_10, %numChannels
  %tmp_20 = add i32 %tmp_19, 0
  %tmp_21 = add i32 %tmp_16, %tmp_20
  %tmp_23 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_21
  %tmp_24 = load float addrspace(1)* %tmp_23, align 4
  %tmp_27 = mul i32 %width, %numChannels
  %tmp_29 = mul i32 %tmp_27, %tmp_11
  %tmp_32 = mul i32 %tmp_10, %numChannels
  %tmp_33 = add i32 %tmp_32, 1
  %tmp_34 = add i32 %tmp_29, %tmp_33
  %tmp_36 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_34
  %tmp_37 = load float addrspace(1)* %tmp_36, align 4
  %tmp_40 = mul i32 %width, %numChannels
  %tmp_42 = mul i32 %tmp_40, %tmp_11
  %tmp_45 = mul i32 %tmp_10, %numChannels
  %tmp_46 = add i32 %tmp_45, 2
  %tmp_47 = add i32 %tmp_42, %tmp_46
  %tmp_49 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_47
  %tmp_50 = load float addrspace(1)* %tmp_49, align 4
  %tmp_54 = call float @luminance(float %tmp_24, float %tmp_37, float %tmp_50)
  %tmp_57 = fmul float %c, %averageLuminance
  %tmp_59 = icmp ne i32 %tmp_10, 0
  br i1 %tmp_59, label %tmp_60, label %tmp_470

tmp_60:                                           ; preds = %0
  %tmp_62 = icmp ne i32 %tmp_11, 0
  br i1 %tmp_62, label %tmp_63, label %tmp_470

tmp_63:                                           ; preds = %tmp_60
  %tmp_66 = sub i32 %width, 1
  %tmp_67 = icmp ne i32 %tmp_10, %tmp_66
  br i1 %tmp_67, label %tmp_68, label %tmp_470

tmp_68:                                           ; preds = %tmp_63
  %tmp_71 = sub i32 %height, 1
  %tmp_72 = icmp ne i32 %tmp_11, %tmp_71
  br i1 %tmp_72, label %tmp_73, label %tmp_470

tmp_73:                                           ; preds = %tmp_68
  %tmp_76 = mul i32 %width, %numChannels
  %tmp_78 = sub i32 %tmp_11, 1
  %tmp_79 = mul i32 %tmp_76, %tmp_78
  %tmp_81 = sub i32 %tmp_10, 1
  %tmp_83 = mul i32 %tmp_81, %numChannels
  %tmp_84 = add i32 %tmp_79, %tmp_83
  %tmp_85 = add i32 %tmp_84, 0
  %tmp_87 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_85
  %tmp_88 = load float addrspace(1)* %tmp_87, align 4
  %tmp_91 = mul i32 %width, %numChannels
  %tmp_93 = sub i32 %tmp_11, 1
  %tmp_94 = mul i32 %tmp_91, %tmp_93
  %tmp_96 = sub i32 %tmp_10, 1
  %tmp_98 = mul i32 %tmp_96, %numChannels
  %tmp_99 = add i32 %tmp_94, %tmp_98
  %tmp_100 = add i32 %tmp_99, 1
  %tmp_102 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_100
  %tmp_103 = load float addrspace(1)* %tmp_102, align 4
  %tmp_106 = mul i32 %width, %numChannels
  %tmp_108 = sub i32 %tmp_11, 1
  %tmp_109 = mul i32 %tmp_106, %tmp_108
  %tmp_111 = sub i32 %tmp_10, 1
  %tmp_113 = mul i32 %tmp_111, %numChannels
  %tmp_114 = add i32 %tmp_109, %tmp_113
  %tmp_115 = add i32 %tmp_114, 2
  %tmp_117 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_115
  %tmp_118 = load float addrspace(1)* %tmp_117, align 4
  %tmp_122 = call float @luminance(float %tmp_88, float %tmp_103, float %tmp_118)
  %tmp_125 = mul i32 %width, %numChannels
  %tmp_127 = sub i32 %tmp_11, 1
  %tmp_128 = mul i32 %tmp_125, %tmp_127
  %tmp_131 = mul i32 %tmp_10, %numChannels
  %tmp_132 = add i32 %tmp_128, %tmp_131
  %tmp_133 = add i32 %tmp_132, 0
  %tmp_135 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_133
  %tmp_136 = load float addrspace(1)* %tmp_135, align 4
  %tmp_139 = mul i32 %width, %numChannels
  %tmp_141 = sub i32 %tmp_11, 1
  %tmp_142 = mul i32 %tmp_139, %tmp_141
  %tmp_145 = mul i32 %tmp_10, %numChannels
  %tmp_146 = add i32 %tmp_142, %tmp_145
  %tmp_147 = add i32 %tmp_146, 1
  %tmp_149 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_147
  %tmp_150 = load float addrspace(1)* %tmp_149, align 4
  %tmp_153 = mul i32 %width, %numChannels
  %tmp_155 = sub i32 %tmp_11, 1
  %tmp_156 = mul i32 %tmp_153, %tmp_155
  %tmp_159 = mul i32 %tmp_10, %numChannels
  %tmp_160 = add i32 %tmp_156, %tmp_159
  %tmp_161 = add i32 %tmp_160, 2
  %tmp_163 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_161
  %tmp_164 = load float addrspace(1)* %tmp_163, align 4
  %tmp_168 = call float @luminance(float %tmp_136, float %tmp_150, float %tmp_164)
  %tmp_171 = mul i32 %width, %numChannels
  %tmp_173 = sub i32 %tmp_11, 1
  %tmp_174 = mul i32 %tmp_171, %tmp_173
  %tmp_176 = add i32 %tmp_10, 1
  %tmp_178 = mul i32 %tmp_176, %numChannels
  %tmp_179 = add i32 %tmp_174, %tmp_178
  %tmp_180 = add i32 %tmp_179, 0
  %tmp_182 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_180
  %tmp_183 = load float addrspace(1)* %tmp_182, align 4
  %tmp_186 = mul i32 %width, %numChannels
  %tmp_188 = sub i32 %tmp_11, 1
  %tmp_189 = mul i32 %tmp_186, %tmp_188
  %tmp_191 = add i32 %tmp_10, 1
  %tmp_193 = mul i32 %tmp_191, %numChannels
  %tmp_194 = add i32 %tmp_189, %tmp_193
  %tmp_195 = add i32 %tmp_194, 1
  %tmp_197 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_195
  %tmp_198 = load float addrspace(1)* %tmp_197, align 4
  %tmp_201 = mul i32 %width, %numChannels
  %tmp_203 = sub i32 %tmp_11, 1
  %tmp_204 = mul i32 %tmp_201, %tmp_203
  %tmp_206 = add i32 %tmp_10, 1
  %tmp_208 = mul i32 %tmp_206, %numChannels
  %tmp_209 = add i32 %tmp_204, %tmp_208
  %tmp_210 = add i32 %tmp_209, 2
  %tmp_212 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_210
  %tmp_213 = load float addrspace(1)* %tmp_212, align 4
  %tmp_217 = call float @luminance(float %tmp_183, float %tmp_198, float %tmp_213)
  %tmp_220 = mul i32 %width, %numChannels
  %tmp_222 = mul i32 %tmp_220, %tmp_11
  %tmp_224 = sub i32 %tmp_10, 1
  %tmp_226 = mul i32 %tmp_224, %numChannels
  %tmp_227 = add i32 %tmp_222, %tmp_226
  %tmp_228 = add i32 %tmp_227, 0
  %tmp_230 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_228
  %tmp_231 = load float addrspace(1)* %tmp_230, align 4
  %tmp_234 = mul i32 %width, %numChannels
  %tmp_236 = mul i32 %tmp_234, %tmp_11
  %tmp_238 = sub i32 %tmp_10, 1
  %tmp_240 = mul i32 %tmp_238, %numChannels
  %tmp_241 = add i32 %tmp_236, %tmp_240
  %tmp_242 = add i32 %tmp_241, 1
  %tmp_244 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_242
  %tmp_245 = load float addrspace(1)* %tmp_244, align 4
  %tmp_248 = mul i32 %width, %numChannels
  %tmp_250 = mul i32 %tmp_248, %tmp_11
  %tmp_252 = sub i32 %tmp_10, 1
  %tmp_254 = mul i32 %tmp_252, %numChannels
  %tmp_255 = add i32 %tmp_250, %tmp_254
  %tmp_256 = add i32 %tmp_255, 2
  %tmp_258 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_256
  %tmp_259 = load float addrspace(1)* %tmp_258, align 4
  %tmp_263 = call float @luminance(float %tmp_231, float %tmp_245, float %tmp_259)
  %tmp_266 = mul i32 %width, %numChannels
  %tmp_268 = mul i32 %tmp_266, %tmp_11
  %tmp_270 = add i32 %tmp_10, 1
  %tmp_272 = mul i32 %tmp_270, %numChannels
  %tmp_273 = add i32 %tmp_268, %tmp_272
  %tmp_274 = add i32 %tmp_273, 0
  %tmp_276 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_274
  %tmp_277 = load float addrspace(1)* %tmp_276, align 4
  %tmp_280 = mul i32 %width, %numChannels
  %tmp_282 = mul i32 %tmp_280, %tmp_11
  %tmp_284 = add i32 %tmp_10, 1
  %tmp_286 = mul i32 %tmp_284, %numChannels
  %tmp_287 = add i32 %tmp_282, %tmp_286
  %tmp_288 = add i32 %tmp_287, 1
  %tmp_290 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_288
  %tmp_291 = load float addrspace(1)* %tmp_290, align 4
  %tmp_294 = mul i32 %width, %numChannels
  %tmp_296 = mul i32 %tmp_294, %tmp_11
  %tmp_298 = add i32 %tmp_10, 1
  %tmp_300 = mul i32 %tmp_298, %numChannels
  %tmp_301 = add i32 %tmp_296, %tmp_300
  %tmp_302 = add i32 %tmp_301, 2
  %tmp_304 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_302
  %tmp_305 = load float addrspace(1)* %tmp_304, align 4
  %tmp_309 = call float @luminance(float %tmp_277, float %tmp_291, float %tmp_305)
  %tmp_312 = mul i32 %width, %numChannels
  %tmp_314 = add i32 %tmp_11, 1
  %tmp_315 = mul i32 %tmp_312, %tmp_314
  %tmp_317 = sub i32 %tmp_10, 1
  %tmp_319 = mul i32 %tmp_317, %numChannels
  %tmp_320 = add i32 %tmp_315, %tmp_319
  %tmp_321 = add i32 %tmp_320, 0
  %tmp_323 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_321
  %tmp_324 = load float addrspace(1)* %tmp_323, align 4
  %tmp_327 = mul i32 %width, %numChannels
  %tmp_329 = add i32 %tmp_11, 1
  %tmp_330 = mul i32 %tmp_327, %tmp_329
  %tmp_332 = sub i32 %tmp_10, 1
  %tmp_334 = mul i32 %tmp_332, %numChannels
  %tmp_335 = add i32 %tmp_330, %tmp_334
  %tmp_336 = add i32 %tmp_335, 1
  %tmp_338 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_336
  %tmp_339 = load float addrspace(1)* %tmp_338, align 4
  %tmp_342 = mul i32 %width, %numChannels
  %tmp_344 = add i32 %tmp_11, 1
  %tmp_345 = mul i32 %tmp_342, %tmp_344
  %tmp_347 = sub i32 %tmp_10, 1
  %tmp_349 = mul i32 %tmp_347, %numChannels
  %tmp_350 = add i32 %tmp_345, %tmp_349
  %tmp_351 = add i32 %tmp_350, 2
  %tmp_353 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_351
  %tmp_354 = load float addrspace(1)* %tmp_353, align 4
  %tmp_358 = call float @luminance(float %tmp_324, float %tmp_339, float %tmp_354)
  %tmp_361 = mul i32 %width, %numChannels
  %tmp_363 = add i32 %tmp_11, 1
  %tmp_364 = mul i32 %tmp_361, %tmp_363
  %tmp_367 = mul i32 %tmp_10, %numChannels
  %tmp_368 = add i32 %tmp_364, %tmp_367
  %tmp_369 = add i32 %tmp_368, 0
  %tmp_371 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_369
  %tmp_372 = load float addrspace(1)* %tmp_371, align 4
  %tmp_375 = mul i32 %width, %numChannels
  %tmp_377 = add i32 %tmp_11, 1
  %tmp_378 = mul i32 %tmp_375, %tmp_377
  %tmp_381 = mul i32 %tmp_10, %numChannels
  %tmp_382 = add i32 %tmp_378, %tmp_381
  %tmp_383 = add i32 %tmp_382, 1
  %tmp_385 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_383
  %tmp_386 = load float addrspace(1)* %tmp_385, align 4
  %tmp_389 = mul i32 %width, %numChannels
  %tmp_391 = add i32 %tmp_11, 1
  %tmp_392 = mul i32 %tmp_389, %tmp_391
  %tmp_395 = mul i32 %tmp_10, %numChannels
  %tmp_396 = add i32 %tmp_392, %tmp_395
  %tmp_397 = add i32 %tmp_396, 2
  %tmp_399 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_397
  %tmp_400 = load float addrspace(1)* %tmp_399, align 4
  %tmp_404 = call float @luminance(float %tmp_372, float %tmp_386, float %tmp_400)
  %tmp_407 = mul i32 %width, %numChannels
  %tmp_409 = add i32 %tmp_11, 1
  %tmp_410 = mul i32 %tmp_407, %tmp_409
  %tmp_412 = add i32 %tmp_10, 1
  %tmp_414 = mul i32 %tmp_412, %numChannels
  %tmp_415 = add i32 %tmp_410, %tmp_414
  %tmp_416 = add i32 %tmp_415, 0
  %tmp_418 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_416
  %tmp_419 = load float addrspace(1)* %tmp_418, align 4
  %tmp_422 = mul i32 %width, %numChannels
  %tmp_424 = add i32 %tmp_11, 1
  %tmp_425 = mul i32 %tmp_422, %tmp_424
  %tmp_427 = add i32 %tmp_10, 1
  %tmp_429 = mul i32 %tmp_427, %numChannels
  %tmp_430 = add i32 %tmp_425, %tmp_429
  %tmp_431 = add i32 %tmp_430, 1
  %tmp_433 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_431
  %tmp_434 = load float addrspace(1)* %tmp_433, align 4
  %tmp_437 = mul i32 %width, %numChannels
  %tmp_439 = add i32 %tmp_11, 1
  %tmp_440 = mul i32 %tmp_437, %tmp_439
  %tmp_442 = add i32 %tmp_10, 1
  %tmp_444 = mul i32 %tmp_442, %numChannels
  %tmp_445 = add i32 %tmp_440, %tmp_444
  %tmp_446 = add i32 %tmp_445, 2
  %tmp_448 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_446
  %tmp_449 = load float addrspace(1)* %tmp_448, align 4
  %tmp_453 = call float @luminance(float %tmp_419, float %tmp_434, float %tmp_449)
  %tmp_456 = fadd float %tmp_122, %tmp_168
  %tmp_458 = fadd float %tmp_456, %tmp_217
  %tmp_460 = fadd float %tmp_458, %tmp_263
  %tmp_462 = fadd float %tmp_460, %tmp_309
  %tmp_464 = fadd float %tmp_462, %tmp_358
  %tmp_466 = fadd float %tmp_464, %tmp_404
  %tmp_468 = fadd float %tmp_466, %tmp_453
  %tmp_469 = fdiv float %tmp_468, 8.000000e+00, !fpmath !3
  br label %tmp_472

tmp_470:                                          ; preds = %tmp_68, %tmp_63, %tmp_60, %0
  br label %tmp_472

tmp_472:                                          ; preds = %tmp_470, %tmp_73
  %yLPattanaik.0 = phi float [ %tmp_469, %tmp_73 ], [ %tmp_54, %tmp_470 ]
  %tmp_477 = fdiv float %yLPattanaik.0, %tmp_54, !fpmath !3
  %tmp_478 = fadd float %delta, %tmp_477
  %tmp_479 = call float @llvm.log2.f32(float %tmp_478)
  %tmp_480 = fmul float %tmp_479, 0x3FE62E4300000000
  %tmp_482 = call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %tmp_480, float %tmp_57)
  %tmp_486 = fadd float %tmp_54, %tmp_482
  %tmp_487 = fdiv float %tmp_54, %tmp_486, !fpmath !3
  %tmp_490 = fdiv float %tmp_24, %tmp_54, !fpmath !3
  %tmp_492 = call float @llvm.pow.f32(float %tmp_490, float %gamma)
  %tmp_494 = fmul float %tmp_492, %tmp_487
  %tmp_497 = fdiv float %tmp_37, %tmp_54, !fpmath !3
  %tmp_499 = call float @llvm.pow.f32(float %tmp_497, float %gamma)
  %tmp_501 = fmul float %tmp_499, %tmp_487
  %tmp_504 = fdiv float %tmp_50, %tmp_54, !fpmath !3
  %tmp_506 = call float @llvm.pow.f32(float %tmp_504, float %gamma)
  %tmp_508 = fmul float %tmp_506, %tmp_487
  %tmp_512 = mul i32 %width, %numChannels
  %tmp_514 = mul i32 %tmp_512, %tmp_11
  %tmp_517 = mul i32 %tmp_10, %numChannels
  %tmp_518 = add i32 %tmp_517, 0
  %tmp_519 = add i32 %tmp_514, %tmp_518
  %tmp_521 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_519
  store float %tmp_494, float addrspace(1)* %tmp_521, align 4
  %tmp_525 = mul i32 %width, %numChannels
  %tmp_527 = mul i32 %tmp_525, %tmp_11
  %tmp_530 = mul i32 %tmp_10, %numChannels
  %tmp_531 = add i32 %tmp_530, 1
  %tmp_532 = add i32 %tmp_527, %tmp_531
  %tmp_534 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_532
  store float %tmp_501, float addrspace(1)* %tmp_534, align 4
  %tmp_538 = mul i32 %width, %numChannels
  %tmp_540 = mul i32 %tmp_538, %tmp_11
  %tmp_543 = mul i32 %tmp_10, %numChannels
  %tmp_544 = add i32 %tmp_543, 2
  %tmp_545 = add i32 %tmp_540, %tmp_544
  %tmp_547 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_545
  store float %tmp_508, float addrspace(1)* %tmp_547, align 4
  %tmp_550 = mul i32 %width, %numChannels
  %tmp_552 = mul i32 %tmp_550, %tmp_11
  %tmp_555 = mul i32 %tmp_10, %numChannels
  %tmp_556 = add i32 %tmp_555, 3
  %tmp_557 = add i32 %tmp_552, %tmp_556
  %tmp_559 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_557
  %tmp_560 = load float addrspace(1)* %tmp_559, align 4
  %tmp_563 = mul i32 %width, %numChannels
  %tmp_565 = mul i32 %tmp_563, %tmp_11
  %tmp_568 = mul i32 %tmp_10, %numChannels
  %tmp_569 = add i32 %tmp_568, 3
  %tmp_570 = add i32 %tmp_565, %tmp_569
  %tmp_572 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_570
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
  %tmp_10 = call i32 @__get_global_id_u32(i32 0)
  %tmp_11 = call i32 @__get_global_id_u32(i32 1)
  %tmp_14 = mul i32 %width, %tmp_11
  %tmp_16 = add i32 %tmp_14, %tmp_10
  %tmp_18 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_16
  %tmp_19 = load <4 x float> addrspace(1)* %tmp_18, align 16
  %tmp_20 = extractelement <4 x float> %tmp_19, i32 0
  %tmp_23 = mul i32 %width, %tmp_11
  %tmp_25 = add i32 %tmp_23, %tmp_10
  %tmp_27 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_25
  %tmp_28 = load <4 x float> addrspace(1)* %tmp_27, align 16
  %tmp_29 = extractelement <4 x float> %tmp_28, i32 1
  %tmp_32 = mul i32 %width, %tmp_11
  %tmp_34 = add i32 %tmp_32, %tmp_10
  %tmp_36 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_34
  %tmp_37 = load <4 x float> addrspace(1)* %tmp_36, align 16
  %tmp_38 = extractelement <4 x float> %tmp_37, i32 2
  %tmp_42 = call float @luminance(float %tmp_20, float %tmp_29, float %tmp_38)
  %tmp_45 = fmul float %c, %averageLuminance
  %tmp_47 = icmp ne i32 %tmp_10, 0
  br i1 %tmp_47, label %tmp_48, label %tmp_362

tmp_48:                                           ; preds = %0
  %tmp_50 = icmp ne i32 %tmp_11, 0
  br i1 %tmp_50, label %tmp_51, label %tmp_362

tmp_51:                                           ; preds = %tmp_48
  %tmp_54 = sub i32 %width, 1
  %tmp_55 = icmp ne i32 %tmp_10, %tmp_54
  br i1 %tmp_55, label %tmp_56, label %tmp_362

tmp_56:                                           ; preds = %tmp_51
  %tmp_59 = sub i32 %height, 1
  %tmp_60 = icmp ne i32 %tmp_11, %tmp_59
  br i1 %tmp_60, label %tmp_61, label %tmp_362

tmp_61:                                           ; preds = %tmp_56
  %tmp_64 = sub i32 %tmp_11, 1
  %tmp_65 = mul i32 %width, %tmp_64
  %tmp_67 = add i32 %tmp_65, %tmp_10
  %tmp_68 = sub i32 %tmp_67, 1
  %tmp_70 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_68
  %tmp_71 = load <4 x float> addrspace(1)* %tmp_70, align 16
  %tmp_72 = extractelement <4 x float> %tmp_71, i32 0
  %tmp_75 = sub i32 %tmp_11, 1
  %tmp_76 = mul i32 %width, %tmp_75
  %tmp_78 = add i32 %tmp_76, %tmp_10
  %tmp_79 = sub i32 %tmp_78, 1
  %tmp_81 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_79
  %tmp_82 = load <4 x float> addrspace(1)* %tmp_81, align 16
  %tmp_83 = extractelement <4 x float> %tmp_82, i32 1
  %tmp_86 = sub i32 %tmp_11, 1
  %tmp_87 = mul i32 %width, %tmp_86
  %tmp_89 = add i32 %tmp_87, %tmp_10
  %tmp_90 = sub i32 %tmp_89, 1
  %tmp_92 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_90
  %tmp_93 = load <4 x float> addrspace(1)* %tmp_92, align 16
  %tmp_94 = extractelement <4 x float> %tmp_93, i32 2
  %tmp_98 = call float @luminance(float %tmp_72, float %tmp_83, float %tmp_94)
  %tmp_101 = sub i32 %tmp_11, 1
  %tmp_102 = mul i32 %width, %tmp_101
  %tmp_104 = add i32 %tmp_102, %tmp_10
  %tmp_106 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_104
  %tmp_107 = load <4 x float> addrspace(1)* %tmp_106, align 16
  %tmp_108 = extractelement <4 x float> %tmp_107, i32 0
  %tmp_111 = sub i32 %tmp_11, 1
  %tmp_112 = mul i32 %width, %tmp_111
  %tmp_114 = add i32 %tmp_112, %tmp_10
  %tmp_116 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_114
  %tmp_117 = load <4 x float> addrspace(1)* %tmp_116, align 16
  %tmp_118 = extractelement <4 x float> %tmp_117, i32 1
  %tmp_121 = sub i32 %tmp_11, 1
  %tmp_122 = mul i32 %width, %tmp_121
  %tmp_124 = add i32 %tmp_122, %tmp_10
  %tmp_126 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_124
  %tmp_127 = load <4 x float> addrspace(1)* %tmp_126, align 16
  %tmp_128 = extractelement <4 x float> %tmp_127, i32 2
  %tmp_132 = call float @luminance(float %tmp_108, float %tmp_118, float %tmp_128)
  %tmp_135 = sub i32 %tmp_11, 1
  %tmp_136 = mul i32 %width, %tmp_135
  %tmp_138 = add i32 %tmp_136, %tmp_10
  %tmp_139 = add i32 %tmp_138, 1
  %tmp_141 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_139
  %tmp_142 = load <4 x float> addrspace(1)* %tmp_141, align 16
  %tmp_143 = extractelement <4 x float> %tmp_142, i32 0
  %tmp_146 = sub i32 %tmp_11, 1
  %tmp_147 = mul i32 %width, %tmp_146
  %tmp_149 = add i32 %tmp_147, %tmp_10
  %tmp_150 = add i32 %tmp_149, 1
  %tmp_152 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_150
  %tmp_153 = load <4 x float> addrspace(1)* %tmp_152, align 16
  %tmp_154 = extractelement <4 x float> %tmp_153, i32 1
  %tmp_157 = sub i32 %tmp_11, 1
  %tmp_158 = mul i32 %width, %tmp_157
  %tmp_160 = add i32 %tmp_158, %tmp_10
  %tmp_161 = add i32 %tmp_160, 1
  %tmp_163 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_161
  %tmp_164 = load <4 x float> addrspace(1)* %tmp_163, align 16
  %tmp_165 = extractelement <4 x float> %tmp_164, i32 2
  %tmp_169 = call float @luminance(float %tmp_143, float %tmp_154, float %tmp_165)
  %tmp_172 = mul i32 %width, %tmp_11
  %tmp_174 = add i32 %tmp_172, %tmp_10
  %tmp_175 = sub i32 %tmp_174, 1
  %tmp_177 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_175
  %tmp_178 = load <4 x float> addrspace(1)* %tmp_177, align 16
  %tmp_179 = extractelement <4 x float> %tmp_178, i32 0
  %tmp_182 = mul i32 %width, %tmp_11
  %tmp_184 = add i32 %tmp_182, %tmp_10
  %tmp_185 = sub i32 %tmp_184, 1
  %tmp_187 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_185
  %tmp_188 = load <4 x float> addrspace(1)* %tmp_187, align 16
  %tmp_189 = extractelement <4 x float> %tmp_188, i32 1
  %tmp_192 = mul i32 %width, %tmp_11
  %tmp_194 = add i32 %tmp_192, %tmp_10
  %tmp_195 = sub i32 %tmp_194, 1
  %tmp_197 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_195
  %tmp_198 = load <4 x float> addrspace(1)* %tmp_197, align 16
  %tmp_199 = extractelement <4 x float> %tmp_198, i32 2
  %tmp_203 = call float @luminance(float %tmp_179, float %tmp_189, float %tmp_199)
  %tmp_206 = mul i32 %width, %tmp_11
  %tmp_208 = add i32 %tmp_206, %tmp_10
  %tmp_209 = add i32 %tmp_208, 1
  %tmp_211 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_209
  %tmp_212 = load <4 x float> addrspace(1)* %tmp_211, align 16
  %tmp_213 = extractelement <4 x float> %tmp_212, i32 0
  %tmp_216 = mul i32 %width, %tmp_11
  %tmp_218 = add i32 %tmp_216, %tmp_10
  %tmp_219 = add i32 %tmp_218, 1
  %tmp_221 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_219
  %tmp_222 = load <4 x float> addrspace(1)* %tmp_221, align 16
  %tmp_223 = extractelement <4 x float> %tmp_222, i32 1
  %tmp_226 = mul i32 %width, %tmp_11
  %tmp_228 = add i32 %tmp_226, %tmp_10
  %tmp_229 = add i32 %tmp_228, 1
  %tmp_231 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_229
  %tmp_232 = load <4 x float> addrspace(1)* %tmp_231, align 16
  %tmp_233 = extractelement <4 x float> %tmp_232, i32 2
  %tmp_237 = call float @luminance(float %tmp_213, float %tmp_223, float %tmp_233)
  %tmp_240 = add i32 %tmp_11, 1
  %tmp_241 = mul i32 %width, %tmp_240
  %tmp_243 = add i32 %tmp_241, %tmp_10
  %tmp_244 = sub i32 %tmp_243, 1
  %tmp_246 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_244
  %tmp_247 = load <4 x float> addrspace(1)* %tmp_246, align 16
  %tmp_248 = extractelement <4 x float> %tmp_247, i32 0
  %tmp_251 = add i32 %tmp_11, 1
  %tmp_252 = mul i32 %width, %tmp_251
  %tmp_254 = add i32 %tmp_252, %tmp_10
  %tmp_255 = sub i32 %tmp_254, 1
  %tmp_257 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_255
  %tmp_258 = load <4 x float> addrspace(1)* %tmp_257, align 16
  %tmp_259 = extractelement <4 x float> %tmp_258, i32 1
  %tmp_262 = add i32 %tmp_11, 1
  %tmp_263 = mul i32 %width, %tmp_262
  %tmp_265 = add i32 %tmp_263, %tmp_10
  %tmp_266 = sub i32 %tmp_265, 1
  %tmp_268 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_266
  %tmp_269 = load <4 x float> addrspace(1)* %tmp_268, align 16
  %tmp_270 = extractelement <4 x float> %tmp_269, i32 2
  %tmp_274 = call float @luminance(float %tmp_248, float %tmp_259, float %tmp_270)
  %tmp_277 = add i32 %tmp_11, 1
  %tmp_278 = mul i32 %width, %tmp_277
  %tmp_280 = add i32 %tmp_278, %tmp_10
  %tmp_282 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_280
  %tmp_283 = load <4 x float> addrspace(1)* %tmp_282, align 16
  %tmp_284 = extractelement <4 x float> %tmp_283, i32 0
  %tmp_287 = add i32 %tmp_11, 1
  %tmp_288 = mul i32 %width, %tmp_287
  %tmp_290 = add i32 %tmp_288, %tmp_10
  %tmp_292 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_290
  %tmp_293 = load <4 x float> addrspace(1)* %tmp_292, align 16
  %tmp_294 = extractelement <4 x float> %tmp_293, i32 1
  %tmp_297 = add i32 %tmp_11, 1
  %tmp_298 = mul i32 %width, %tmp_297
  %tmp_300 = add i32 %tmp_298, %tmp_10
  %tmp_302 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_300
  %tmp_303 = load <4 x float> addrspace(1)* %tmp_302, align 16
  %tmp_304 = extractelement <4 x float> %tmp_303, i32 2
  %tmp_308 = call float @luminance(float %tmp_284, float %tmp_294, float %tmp_304)
  %tmp_311 = add i32 %tmp_11, 1
  %tmp_312 = mul i32 %width, %tmp_311
  %tmp_314 = add i32 %tmp_312, %tmp_10
  %tmp_315 = add i32 %tmp_314, 1
  %tmp_317 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_315
  %tmp_318 = load <4 x float> addrspace(1)* %tmp_317, align 16
  %tmp_319 = extractelement <4 x float> %tmp_318, i32 0
  %tmp_322 = add i32 %tmp_11, 1
  %tmp_323 = mul i32 %width, %tmp_322
  %tmp_325 = add i32 %tmp_323, %tmp_10
  %tmp_326 = add i32 %tmp_325, 1
  %tmp_328 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_326
  %tmp_329 = load <4 x float> addrspace(1)* %tmp_328, align 16
  %tmp_330 = extractelement <4 x float> %tmp_329, i32 1
  %tmp_333 = add i32 %tmp_11, 1
  %tmp_334 = mul i32 %width, %tmp_333
  %tmp_336 = add i32 %tmp_334, %tmp_10
  %tmp_337 = add i32 %tmp_336, 1
  %tmp_339 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_337
  %tmp_340 = load <4 x float> addrspace(1)* %tmp_339, align 16
  %tmp_341 = extractelement <4 x float> %tmp_340, i32 2
  %tmp_345 = call float @luminance(float %tmp_319, float %tmp_330, float %tmp_341)
  %tmp_348 = fadd float %tmp_98, %tmp_132
  %tmp_350 = fadd float %tmp_348, %tmp_169
  %tmp_352 = fadd float %tmp_350, %tmp_203
  %tmp_354 = fadd float %tmp_352, %tmp_237
  %tmp_356 = fadd float %tmp_354, %tmp_274
  %tmp_358 = fadd float %tmp_356, %tmp_308
  %tmp_360 = fadd float %tmp_358, %tmp_345
  %tmp_361 = fdiv float %tmp_360, 8.000000e+00, !fpmath !3
  br label %tmp_364

tmp_362:                                          ; preds = %tmp_56, %tmp_51, %tmp_48, %0
  br label %tmp_364

tmp_364:                                          ; preds = %tmp_362, %tmp_61
  %yLPattanaik.0 = phi float [ %tmp_361, %tmp_61 ], [ %tmp_42, %tmp_362 ]
  %tmp_369 = fdiv float %yLPattanaik.0, %tmp_42, !fpmath !3
  %tmp_370 = fadd float %delta, %tmp_369
  %tmp_371 = call float @llvm.log2.f32(float %tmp_370)
  %tmp_372 = fmul float %tmp_371, 0x3FE62E4300000000
  %tmp_374 = call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %tmp_372, float %tmp_45)
  %tmp_378 = fadd float %tmp_42, %tmp_374
  %tmp_379 = fdiv float %tmp_42, %tmp_378, !fpmath !3
  %tmp_382 = fdiv float %tmp_20, %tmp_42, !fpmath !3
  %tmp_384 = call float @llvm.pow.f32(float %tmp_382, float %gamma)
  %tmp_386 = fmul float %tmp_384, %tmp_379
  %tmp_389 = fdiv float %tmp_29, %tmp_42, !fpmath !3
  %tmp_391 = call float @llvm.pow.f32(float %tmp_389, float %gamma)
  %tmp_393 = fmul float %tmp_391, %tmp_379
  %tmp_396 = fdiv float %tmp_38, %tmp_42, !fpmath !3
  %tmp_398 = call float @llvm.pow.f32(float %tmp_396, float %gamma)
  %tmp_400 = fmul float %tmp_398, %tmp_379
  %tmp_404 = mul i32 %width, %tmp_11
  %tmp_406 = add i32 %tmp_404, %tmp_10
  %tmp_408 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_406
  %tmp_409 = load <4 x float> addrspace(1)* %tmp_408, align 16
  %tmp_410 = insertelement <4 x float> %tmp_409, float %tmp_386, i32 0
  store <4 x float> %tmp_410, <4 x float> addrspace(1)* %tmp_408, align 16
  %tmp_414 = mul i32 %width, %tmp_11
  %tmp_416 = add i32 %tmp_414, %tmp_10
  %tmp_418 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_416
  %tmp_419 = load <4 x float> addrspace(1)* %tmp_418, align 16
  %tmp_420 = insertelement <4 x float> %tmp_419, float %tmp_393, i32 1
  store <4 x float> %tmp_420, <4 x float> addrspace(1)* %tmp_418, align 16
  %tmp_424 = mul i32 %width, %tmp_11
  %tmp_426 = add i32 %tmp_424, %tmp_10
  %tmp_428 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_426
  %tmp_429 = load <4 x float> addrspace(1)* %tmp_428, align 16
  %tmp_430 = insertelement <4 x float> %tmp_429, float %tmp_400, i32 2
  store <4 x float> %tmp_430, <4 x float> addrspace(1)* %tmp_428, align 16
  %tmp_433 = mul i32 %width, %tmp_11
  %tmp_435 = add i32 %tmp_433, %tmp_10
  %tmp_437 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_435
  %tmp_438 = load <4 x float> addrspace(1)* %tmp_437, align 16
  %tmp_439 = extractelement <4 x float> %tmp_438, i32 3
  %tmp_442 = mul i32 %width, %tmp_11
  %tmp_444 = add i32 %tmp_442, %tmp_10
  %tmp_446 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_444
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

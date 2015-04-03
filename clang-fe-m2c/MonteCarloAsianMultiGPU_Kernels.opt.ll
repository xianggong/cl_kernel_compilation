; ModuleID = 'MonteCarloAsianMultiGPU_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%struct._MonteCalroAttrib = type { <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float> }

; Function Attrs: nounwind
define void @lshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
  %tmp_5 = sub i32 32, %shift
  %tmp_7 = extractelement <4 x i32> %input, i32 0
  %tmp_9 = and i32 %shift, 31
  %tmp_10 = shl i32 %tmp_7, %tmp_9
  %tmp_12 = insertelement <4 x i32> undef, i32 %tmp_10, i32 0
  %tmp_14 = extractelement <4 x i32> %input, i32 1
  %tmp_16 = and i32 %shift, 31
  %tmp_17 = shl i32 %tmp_14, %tmp_16
  %tmp_19 = extractelement <4 x i32> %input, i32 0
  %tmp_21 = and i32 %tmp_5, 31
  %tmp_22 = lshr i32 %tmp_19, %tmp_21
  %tmp_23 = or i32 %tmp_17, %tmp_22
  %tmp_25 = insertelement <4 x i32> %tmp_12, i32 %tmp_23, i32 1
  %tmp_27 = extractelement <4 x i32> %input, i32 2
  %tmp_29 = and i32 %shift, 31
  %tmp_30 = shl i32 %tmp_27, %tmp_29
  %tmp_32 = extractelement <4 x i32> %input, i32 1
  %tmp_34 = and i32 %tmp_5, 31
  %tmp_35 = lshr i32 %tmp_32, %tmp_34
  %tmp_36 = or i32 %tmp_30, %tmp_35
  %tmp_38 = insertelement <4 x i32> %tmp_25, i32 %tmp_36, i32 2
  %tmp_40 = extractelement <4 x i32> %input, i32 3
  %tmp_42 = and i32 %shift, 31
  %tmp_43 = shl i32 %tmp_40, %tmp_42
  %tmp_45 = extractelement <4 x i32> %input, i32 2
  %tmp_47 = and i32 %tmp_5, 31
  %tmp_48 = lshr i32 %tmp_45, %tmp_47
  %tmp_49 = or i32 %tmp_43, %tmp_48
  %tmp_51 = insertelement <4 x i32> %tmp_38, i32 %tmp_49, i32 3
  store <4 x i32> %tmp_51, <4 x i32>* %output, align 16
  ret void
}

; Function Attrs: nounwind
define void @rshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
  %tmp_5 = sub i32 32, %shift
  %tmp_7 = extractelement <4 x i32> %input, i32 3
  %tmp_9 = and i32 %shift, 31
  %tmp_10 = lshr i32 %tmp_7, %tmp_9
  %tmp_12 = insertelement <4 x i32> undef, i32 %tmp_10, i32 3
  %tmp_14 = extractelement <4 x i32> %input, i32 2
  %tmp_16 = and i32 %shift, 31
  %tmp_17 = lshr i32 %tmp_14, %tmp_16
  %tmp_19 = extractelement <4 x i32> %input, i32 3
  %tmp_21 = and i32 %tmp_5, 31
  %tmp_22 = shl i32 %tmp_19, %tmp_21
  %tmp_23 = or i32 %tmp_17, %tmp_22
  %tmp_25 = insertelement <4 x i32> %tmp_12, i32 %tmp_23, i32 2
  %tmp_27 = extractelement <4 x i32> %input, i32 1
  %tmp_29 = and i32 %shift, 31
  %tmp_30 = lshr i32 %tmp_27, %tmp_29
  %tmp_32 = extractelement <4 x i32> %input, i32 2
  %tmp_34 = and i32 %tmp_5, 31
  %tmp_35 = shl i32 %tmp_32, %tmp_34
  %tmp_36 = or i32 %tmp_30, %tmp_35
  %tmp_38 = insertelement <4 x i32> %tmp_25, i32 %tmp_36, i32 1
  %tmp_40 = extractelement <4 x i32> %input, i32 0
  %tmp_42 = and i32 %shift, 31
  %tmp_43 = lshr i32 %tmp_40, %tmp_42
  %tmp_45 = extractelement <4 x i32> %input, i32 1
  %tmp_47 = and i32 %tmp_5, 31
  %tmp_48 = shl i32 %tmp_45, %tmp_47
  %tmp_49 = or i32 %tmp_43, %tmp_48
  %tmp_51 = insertelement <4 x i32> %tmp_38, i32 %tmp_49, i32 0
  store <4 x i32> %tmp_51, <4 x i32>* %output, align 16
  ret void
}

; Function Attrs: nounwind
define void @generateRand(<4 x i32> %seed, <4 x float>* %gaussianRand1, <4 x float>* %gaussianRand2, <4 x i32>* %nextRand) #0 {
  %temp = alloca [8 x <4 x i32>], align 16
  %e = alloca <4 x i32>, align 16
  %f = alloca <4 x i32>, align 16
  %tmp_7 = insertelement <4 x i32> undef, i32 1812433253, i32 0
  %tmp_8 = shufflevector <4 x i32> %tmp_7, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_10 = insertelement <4 x i32> undef, i32 30, i32 0
  %tmp_11 = shufflevector <4 x i32> %tmp_10, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> zeroinitializer, <4 x i32>* %e, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %f, align 16
  %tmp_16 = and <4 x i32> %tmp_11, <i32 31, i32 31, i32 31, i32 31>
  %tmp_17 = lshr <4 x i32> %seed, %tmp_16
  %tmp_18 = xor <4 x i32> %seed, %tmp_17
  %tmp_19 = mul <4 x i32> %tmp_8, %tmp_18
  %tmp_21 = add <4 x i32> %tmp_19, <i32 1, i32 1, i32 1, i32 1>
  %tmp_26 = and <4 x i32> %tmp_11, <i32 31, i32 31, i32 31, i32 31>
  %tmp_27 = lshr <4 x i32> %tmp_21, %tmp_26
  %tmp_28 = xor <4 x i32> %tmp_21, %tmp_27
  %tmp_29 = mul <4 x i32> %tmp_8, %tmp_28
  %tmp_31 = add <4 x i32> %tmp_29, <i32 2, i32 2, i32 2, i32 2>
  %tmp_36 = and <4 x i32> %tmp_11, <i32 31, i32 31, i32 31, i32 31>
  %tmp_37 = lshr <4 x i32> %tmp_31, %tmp_36
  %tmp_38 = xor <4 x i32> %tmp_31, %tmp_37
  %tmp_39 = mul <4 x i32> %tmp_8, %tmp_38
  %tmp_41 = add <4 x i32> %tmp_39, <i32 3, i32 3, i32 3, i32 3>
  %tmp_46 = and <4 x i32> %tmp_11, <i32 31, i32 31, i32 31, i32 31>
  %tmp_47 = lshr <4 x i32> %tmp_41, %tmp_46
  %tmp_48 = xor <4 x i32> %tmp_41, %tmp_47
  %tmp_49 = mul <4 x i32> %tmp_8, %tmp_48
  %tmp_51 = add <4 x i32> %tmp_49, <i32 4, i32 4, i32 4, i32 4>
  br label %tmp_52

tmp_52:                                           ; preds = %tmp_191, %0
  %r1.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %r1.1, %tmp_191 ]
  %r2.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %r2.1, %tmp_191 ]
  %a.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %a.1, %tmp_191 ]
  %b.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %b.1, %tmp_191 ]
  %i.0 = phi i32 [ 0, %0 ], [ %tmp_193, %tmp_191 ]
  %tmp_55 = icmp ult i32 %i.0, 4
  br i1 %tmp_55, label %tmp_56, label %tmp_194

tmp_56:                                           ; preds = %tmp_52
  switch i32 %i.0, label %tmp_81 [
    i32 0, label %tmp_58
    i32 1, label %tmp_63
    i32 2, label %tmp_69
    i32 3, label %tmp_75
  ]

tmp_58:                                           ; preds = %tmp_56
  br label %tmp_82

tmp_63:                                           ; preds = %tmp_56
  %tmp_65 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 0
  %tmp_66 = load <4 x i32>* %tmp_65, align 16
  br label %tmp_82

tmp_69:                                           ; preds = %tmp_56
  %tmp_71 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 1
  %tmp_72 = load <4 x i32>* %tmp_71, align 16
  br label %tmp_82

tmp_75:                                           ; preds = %tmp_56
  %tmp_77 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 2
  %tmp_78 = load <4 x i32>* %tmp_77, align 16
  br label %tmp_82

tmp_81:                                           ; preds = %tmp_56
  br label %tmp_82

tmp_82:                                           ; preds = %tmp_81, %tmp_75, %tmp_69, %tmp_63, %tmp_58
  %r1.1 = phi <4 x i32> [ %r1.0, %tmp_81 ], [ %r2.0, %tmp_75 ], [ %r2.0, %tmp_69 ], [ %r2.0, %tmp_63 ], [ %tmp_41, %tmp_58 ]
  %r2.1 = phi <4 x i32> [ %r2.0, %tmp_81 ], [ %tmp_78, %tmp_75 ], [ %tmp_72, %tmp_69 ], [ %tmp_66, %tmp_63 ], [ %tmp_51, %tmp_58 ]
  %a.1 = phi <4 x i32> [ %a.0, %tmp_81 ], [ %tmp_41, %tmp_75 ], [ %tmp_31, %tmp_69 ], [ %tmp_21, %tmp_63 ], [ %seed, %tmp_58 ]
  %b.1 = phi <4 x i32> [ %b.0, %tmp_81 ], [ %seed, %tmp_75 ], [ %tmp_51, %tmp_69 ], [ %tmp_41, %tmp_63 ], [ %tmp_31, %tmp_58 ]
  call void @lshift128(<4 x i32> %a.1, i32 24, <4 x i32>* %e)
  call void @rshift128(<4 x i32> %r1.1, i32 24, <4 x i32>* %f)
  %tmp_88 = extractelement <4 x i32> %a.1, i32 0
  %tmp_89 = load <4 x i32>* %e, align 16
  %tmp_90 = extractelement <4 x i32> %tmp_89, i32 0
  %tmp_91 = xor i32 %tmp_88, %tmp_90
  %tmp_93 = extractelement <4 x i32> %b.1, i32 0
  %tmp_95 = and i32 13, 31
  %tmp_96 = lshr i32 %tmp_93, %tmp_95
  %tmp_98 = and i32 %tmp_96, -33605633
  %tmp_99 = xor i32 %tmp_91, %tmp_98
  %tmp_100 = load <4 x i32>* %f, align 16
  %tmp_101 = extractelement <4 x i32> %tmp_100, i32 0
  %tmp_102 = xor i32 %tmp_99, %tmp_101
  %tmp_104 = extractelement <4 x i32> %r2.1, i32 0
  %tmp_106 = and i32 15, 31
  %tmp_107 = shl i32 %tmp_104, %tmp_106
  %tmp_108 = xor i32 %tmp_102, %tmp_107
  %tmp_110 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %i.0
  %tmp_111 = load <4 x i32>* %tmp_110, align 16
  %tmp_112 = insertelement <4 x i32> %tmp_111, i32 %tmp_108, i32 0
  store <4 x i32> %tmp_112, <4 x i32>* %tmp_110, align 16
  %tmp_114 = extractelement <4 x i32> %a.1, i32 1
  %tmp_115 = load <4 x i32>* %e, align 16
  %tmp_116 = extractelement <4 x i32> %tmp_115, i32 1
  %tmp_117 = xor i32 %tmp_114, %tmp_116
  %tmp_119 = extractelement <4 x i32> %b.1, i32 1
  %tmp_121 = and i32 13, 31
  %tmp_122 = lshr i32 %tmp_119, %tmp_121
  %tmp_124 = and i32 %tmp_122, -276873347
  %tmp_125 = xor i32 %tmp_117, %tmp_124
  %tmp_126 = load <4 x i32>* %f, align 16
  %tmp_127 = extractelement <4 x i32> %tmp_126, i32 1
  %tmp_128 = xor i32 %tmp_125, %tmp_127
  %tmp_130 = extractelement <4 x i32> %r2.1, i32 1
  %tmp_132 = and i32 15, 31
  %tmp_133 = shl i32 %tmp_130, %tmp_132
  %tmp_134 = xor i32 %tmp_128, %tmp_133
  %tmp_136 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %i.0
  %tmp_137 = load <4 x i32>* %tmp_136, align 16
  %tmp_138 = insertelement <4 x i32> %tmp_137, i32 %tmp_134, i32 1
  store <4 x i32> %tmp_138, <4 x i32>* %tmp_136, align 16
  %tmp_140 = extractelement <4 x i32> %a.1, i32 2
  %tmp_141 = load <4 x i32>* %e, align 16
  %tmp_142 = extractelement <4 x i32> %tmp_141, i32 2
  %tmp_143 = xor i32 %tmp_140, %tmp_142
  %tmp_145 = extractelement <4 x i32> %b.1, i32 2
  %tmp_147 = and i32 13, 31
  %tmp_148 = lshr i32 %tmp_145, %tmp_147
  %tmp_150 = and i32 %tmp_148, -8946819
  %tmp_151 = xor i32 %tmp_143, %tmp_150
  %tmp_152 = load <4 x i32>* %f, align 16
  %tmp_153 = extractelement <4 x i32> %tmp_152, i32 2
  %tmp_154 = xor i32 %tmp_151, %tmp_153
  %tmp_156 = extractelement <4 x i32> %r2.1, i32 2
  %tmp_158 = and i32 15, 31
  %tmp_159 = shl i32 %tmp_156, %tmp_158
  %tmp_160 = xor i32 %tmp_154, %tmp_159
  %tmp_162 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %i.0
  %tmp_163 = load <4 x i32>* %tmp_162, align 16
  %tmp_164 = insertelement <4 x i32> %tmp_163, i32 %tmp_160, i32 2
  store <4 x i32> %tmp_164, <4 x i32>* %tmp_162, align 16
  %tmp_166 = extractelement <4 x i32> %a.1, i32 3
  %tmp_167 = load <4 x i32>* %e, align 16
  %tmp_168 = extractelement <4 x i32> %tmp_167, i32 3
  %tmp_169 = xor i32 %tmp_166, %tmp_168
  %tmp_171 = extractelement <4 x i32> %b.1, i32 3
  %tmp_173 = and i32 13, 31
  %tmp_174 = lshr i32 %tmp_171, %tmp_173
  %tmp_176 = and i32 %tmp_174, 2146958127
  %tmp_177 = xor i32 %tmp_169, %tmp_176
  %tmp_178 = load <4 x i32>* %f, align 16
  %tmp_179 = extractelement <4 x i32> %tmp_178, i32 3
  %tmp_180 = xor i32 %tmp_177, %tmp_179
  %tmp_182 = extractelement <4 x i32> %r2.1, i32 3
  %tmp_184 = and i32 15, 31
  %tmp_185 = shl i32 %tmp_182, %tmp_184
  %tmp_186 = xor i32 %tmp_180, %tmp_185
  %tmp_188 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %i.0
  %tmp_189 = load <4 x i32>* %tmp_188, align 16
  %tmp_190 = insertelement <4 x i32> %tmp_189, i32 %tmp_186, i32 3
  store <4 x i32> %tmp_190, <4 x i32>* %tmp_188, align 16
  br label %tmp_191

tmp_191:                                          ; preds = %tmp_82
  %tmp_193 = add i32 %i.0, 1
  br label %tmp_52

tmp_194:                                          ; preds = %tmp_52
  %tmp_195 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 0
  %tmp_196 = load <4 x i32>* %tmp_195, align 16
  %tmp_197 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %tmp_196)
  %tmp_198 = fmul <4 x float> %tmp_197, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %tmp_199 = fdiv <4 x float> %tmp_198, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !2
  %tmp_200 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 1
  %tmp_201 = load <4 x i32>* %tmp_200, align 16
  %tmp_202 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %tmp_201)
  %tmp_203 = fmul <4 x float> %tmp_202, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %tmp_204 = fdiv <4 x float> %tmp_203, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !2
  %tmp_206 = call <4 x float> @llvm.log2.v4f32(<4 x float> %tmp_199)
  %tmp_207 = fmul <4 x float> %tmp_206, <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>
  %tmp_208 = fmul <4 x float> <float -2.000000e+00, float -2.000000e+00, float -2.000000e+00, float -2.000000e+00>, %tmp_207
  %tmp_209 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %tmp_208)
  %tmp_211 = fmul <4 x float> <float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000>, %tmp_204
  %tmp_214 = call <4 x float> @_Z3cosDv4_f(<4 x float> %tmp_211)
  %tmp_215 = fmul <4 x float> %tmp_209, %tmp_214
  store <4 x float> %tmp_215, <4 x float>* %gaussianRand1, align 16
  %tmp_219 = call <4 x float> @_Z3sinDv4_f(<4 x float> %tmp_211)
  %tmp_220 = fmul <4 x float> %tmp_209, %tmp_219
  store <4 x float> %tmp_220, <4 x float>* %gaussianRand2, align 16
  %tmp_222 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 2
  %tmp_223 = load <4 x i32>* %tmp_222, align 16
  store <4 x i32> %tmp_223, <4 x i32>* %nextRand, align 16
  ret void
}

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #2

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #2

declare <4 x float> @_Z3cosDv4_f(<4 x float>) #1

declare <4 x float> @_Z3sinDv4_f(<4 x float>) #1

; Function Attrs: nounwind
define void @calOutputs(<4 x float> %strikePrice, <4 x float> %meanDeriv1, <4 x float> %meanDeriv2, <4 x float> %meanPrice1, <4 x float> %meanPrice2, <4 x float>* %pathDeriv1, <4 x float>* %pathDeriv2, <4 x float>* %priceVec1, <4 x float>* %priceVec2) #0 {
  %tmp_12 = fsub <4 x float> %meanPrice1, %strikePrice
  %tmp_15 = fsub <4 x float> %meanPrice2, %strikePrice
  %tmp_17 = extractelement <4 x float> %tmp_12, i32 0
  %tmp_18 = fcmp ogt float %tmp_17, 0.000000e+00
  br i1 %tmp_18, label %tmp_19, label %tmp_26

tmp_19:                                           ; preds = %0
  %tmp_21 = insertelement <4 x float> zeroinitializer, float 1.000000e+00, i32 0
  %tmp_23 = extractelement <4 x float> %tmp_12, i32 0
  %tmp_25 = insertelement <4 x float> zeroinitializer, float %tmp_23, i32 0
  br label %tmp_26

tmp_26:                                           ; preds = %tmp_19, %0
  %temp1.0 = phi <4 x float> [ %tmp_21, %tmp_19 ], [ zeroinitializer, %0 ]
  %temp3.0 = phi <4 x float> [ %tmp_25, %tmp_19 ], [ zeroinitializer, %0 ]
  %tmp_28 = extractelement <4 x float> %tmp_12, i32 1
  %tmp_29 = fcmp ogt float %tmp_28, 0.000000e+00
  br i1 %tmp_29, label %tmp_30, label %tmp_37

tmp_30:                                           ; preds = %tmp_26
  %tmp_32 = insertelement <4 x float> %temp1.0, float 1.000000e+00, i32 1
  %tmp_34 = extractelement <4 x float> %tmp_12, i32 1
  %tmp_36 = insertelement <4 x float> %temp3.0, float %tmp_34, i32 1
  br label %tmp_37

tmp_37:                                           ; preds = %tmp_30, %tmp_26
  %temp1.1 = phi <4 x float> [ %tmp_32, %tmp_30 ], [ %temp1.0, %tmp_26 ]
  %temp3.1 = phi <4 x float> [ %tmp_36, %tmp_30 ], [ %temp3.0, %tmp_26 ]
  %tmp_39 = extractelement <4 x float> %tmp_12, i32 2
  %tmp_40 = fcmp ogt float %tmp_39, 0.000000e+00
  br i1 %tmp_40, label %tmp_41, label %tmp_48

tmp_41:                                           ; preds = %tmp_37
  %tmp_43 = insertelement <4 x float> %temp1.1, float 1.000000e+00, i32 2
  %tmp_45 = extractelement <4 x float> %tmp_12, i32 2
  %tmp_47 = insertelement <4 x float> %temp3.1, float %tmp_45, i32 2
  br label %tmp_48

tmp_48:                                           ; preds = %tmp_41, %tmp_37
  %temp1.2 = phi <4 x float> [ %tmp_43, %tmp_41 ], [ %temp1.1, %tmp_37 ]
  %temp3.2 = phi <4 x float> [ %tmp_47, %tmp_41 ], [ %temp3.1, %tmp_37 ]
  %tmp_50 = extractelement <4 x float> %tmp_12, i32 3
  %tmp_51 = fcmp ogt float %tmp_50, 0.000000e+00
  br i1 %tmp_51, label %tmp_52, label %tmp_59

tmp_52:                                           ; preds = %tmp_48
  %tmp_54 = insertelement <4 x float> %temp1.2, float 1.000000e+00, i32 3
  %tmp_56 = extractelement <4 x float> %tmp_12, i32 3
  %tmp_58 = insertelement <4 x float> %temp3.2, float %tmp_56, i32 3
  br label %tmp_59

tmp_59:                                           ; preds = %tmp_52, %tmp_48
  %temp1.3 = phi <4 x float> [ %tmp_54, %tmp_52 ], [ %temp1.2, %tmp_48 ]
  %temp3.3 = phi <4 x float> [ %tmp_58, %tmp_52 ], [ %temp3.2, %tmp_48 ]
  %tmp_61 = extractelement <4 x float> %tmp_15, i32 0
  %tmp_62 = fcmp ogt float %tmp_61, 0.000000e+00
  br i1 %tmp_62, label %tmp_63, label %tmp_70

tmp_63:                                           ; preds = %tmp_59
  %tmp_65 = insertelement <4 x float> zeroinitializer, float 1.000000e+00, i32 0
  %tmp_67 = extractelement <4 x float> %tmp_15, i32 0
  %tmp_69 = insertelement <4 x float> zeroinitializer, float %tmp_67, i32 0
  br label %tmp_70

tmp_70:                                           ; preds = %tmp_63, %tmp_59
  %temp2.0 = phi <4 x float> [ %tmp_65, %tmp_63 ], [ zeroinitializer, %tmp_59 ]
  %temp4.0 = phi <4 x float> [ %tmp_69, %tmp_63 ], [ zeroinitializer, %tmp_59 ]
  %tmp_72 = extractelement <4 x float> %tmp_15, i32 1
  %tmp_73 = fcmp ogt float %tmp_72, 0.000000e+00
  br i1 %tmp_73, label %tmp_74, label %tmp_81

tmp_74:                                           ; preds = %tmp_70
  %tmp_76 = insertelement <4 x float> %temp2.0, float 1.000000e+00, i32 1
  %tmp_78 = extractelement <4 x float> %tmp_15, i32 1
  %tmp_80 = insertelement <4 x float> %temp4.0, float %tmp_78, i32 1
  br label %tmp_81

tmp_81:                                           ; preds = %tmp_74, %tmp_70
  %temp2.1 = phi <4 x float> [ %tmp_76, %tmp_74 ], [ %temp2.0, %tmp_70 ]
  %temp4.1 = phi <4 x float> [ %tmp_80, %tmp_74 ], [ %temp4.0, %tmp_70 ]
  %tmp_83 = extractelement <4 x float> %tmp_15, i32 2
  %tmp_84 = fcmp ogt float %tmp_83, 0.000000e+00
  br i1 %tmp_84, label %tmp_85, label %tmp_92

tmp_85:                                           ; preds = %tmp_81
  %tmp_87 = insertelement <4 x float> %temp2.1, float 1.000000e+00, i32 2
  %tmp_89 = extractelement <4 x float> %tmp_15, i32 2
  %tmp_91 = insertelement <4 x float> %temp4.1, float %tmp_89, i32 2
  br label %tmp_92

tmp_92:                                           ; preds = %tmp_85, %tmp_81
  %temp2.2 = phi <4 x float> [ %tmp_87, %tmp_85 ], [ %temp2.1, %tmp_81 ]
  %temp4.2 = phi <4 x float> [ %tmp_91, %tmp_85 ], [ %temp4.1, %tmp_81 ]
  %tmp_94 = extractelement <4 x float> %tmp_15, i32 3
  %tmp_95 = fcmp ogt float %tmp_94, 0.000000e+00
  br i1 %tmp_95, label %tmp_96, label %tmp_103

tmp_96:                                           ; preds = %tmp_92
  %tmp_98 = insertelement <4 x float> %temp2.2, float 1.000000e+00, i32 3
  %tmp_100 = extractelement <4 x float> %tmp_15, i32 3
  %tmp_102 = insertelement <4 x float> %temp4.2, float %tmp_100, i32 3
  br label %tmp_103

tmp_103:                                          ; preds = %tmp_96, %tmp_92
  %temp2.3 = phi <4 x float> [ %tmp_98, %tmp_96 ], [ %temp2.2, %tmp_92 ]
  %temp4.3 = phi <4 x float> [ %tmp_102, %tmp_96 ], [ %temp4.2, %tmp_92 ]
  %tmp_106 = fmul <4 x float> %meanDeriv1, %temp1.3
  store <4 x float> %tmp_106, <4 x float>* %pathDeriv1, align 16
  %tmp_110 = fmul <4 x float> %meanDeriv2, %temp2.3
  store <4 x float> %tmp_110, <4 x float>* %pathDeriv2, align 16
  store <4 x float> %temp3.3, <4 x float>* %priceVec1, align 16
  store <4 x float> %temp4.3, <4 x float>* %priceVec2, align 16
  ret void
}

; Function Attrs: nounwind
define void @calPriceVega(%struct._MonteCalroAttrib* byval %attrib, i32 %noOfSum, i32 %width, <4 x i32> addrspace(1)* %randArray, <4 x float> addrspace(1)* %priceSamples, <4 x float> addrspace(1)* %pathDeriv) #0 {
  %price1 = alloca <4 x float>, align 16
  %price2 = alloca <4 x float>, align 16
  %pathDeriv1 = alloca <4 x float>, align 16
  %pathDeriv2 = alloca <4 x float>, align 16
  %finalRandf1 = alloca <4 x float>, align 16
  %finalRandf2 = alloca <4 x float>, align 16
  %nextRand = alloca <4 x i32>, align 16
  %tmp_6 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 0
  %tmp_7 = load <4 x float>* %tmp_6, align 16
  %tmp_8 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 1
  %tmp_9 = load <4 x float>* %tmp_8, align 16
  %tmp_10 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 2
  %tmp_11 = load <4 x float>* %tmp_10, align 16
  %tmp_12 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 3
  %tmp_13 = load <4 x float>* %tmp_12, align 16
  %tmp_14 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 4
  %tmp_15 = load <4 x float>* %tmp_14, align 16
  %tmp_16 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 5
  %tmp_17 = load <4 x float>* %tmp_16, align 16
  %tmp_18 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 6
  %tmp_19 = load <4 x float>* %tmp_18, align 16
  %tmp_20 = call i32 @__get_global_id_u32(i32 0)
  %tmp_21 = call i32 @__get_global_id_u32(i32 1)
  store <4 x float> zeroinitializer, <4 x float>* %price1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %price2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %pathDeriv1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %pathDeriv2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %finalRandf1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %finalRandf2, align 16
  %tmp_36 = mul i32 %tmp_21, %width
  %tmp_38 = add i32 %tmp_36, %tmp_20
  %tmp_40 = getelementptr inbounds <4 x i32> addrspace(1)* %randArray, i32 %tmp_38
  %tmp_41 = load <4 x i32> addrspace(1)* %tmp_40, align 16
  store <4 x i32> %tmp_41, <4 x i32>* %nextRand, align 16
  br label %tmp_42

tmp_42:                                           ; preds = %tmp_101, %0
  %trajPrice1.0 = phi <4 x float> [ %tmp_15, %0 ], [ %tmp_55, %tmp_101 ]
  %trajPrice2.0 = phi <4 x float> [ %tmp_15, %0 ], [ %tmp_62, %tmp_101 ]
  %sumPrice1.0 = phi <4 x float> [ %tmp_15, %0 ], [ %tmp_65, %tmp_101 ]
  %sumPrice2.0 = phi <4 x float> [ %tmp_15, %0 ], [ %tmp_68, %tmp_101 ]
  %sumDeriv1.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %tmp_88, %tmp_101 ]
  %sumDeriv2.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %tmp_100, %tmp_101 ]
  %i.0 = phi i32 [ 1, %0 ], [ %tmp_103, %tmp_101 ]
  %tmp_45 = icmp slt i32 %i.0, %noOfSum
  br i1 %tmp_45, label %tmp_46, label %tmp_104

tmp_46:                                           ; preds = %tmp_42
  %tmp_47 = load <4 x i32>* %nextRand, align 16
  call void @generateRand(<4 x i32> %tmp_47, <4 x float>* %finalRandf1, <4 x float>* %finalRandf2, <4 x i32>* %nextRand)
  %tmp_52 = load <4 x float>* %finalRandf1, align 16
  %tmp_53 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_11, <4 x float> %tmp_52, <4 x float> %tmp_9)
  %tmp_54 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_53)
  %tmp_55 = fmul <4 x float> %trajPrice1.0, %tmp_54
  %tmp_59 = load <4 x float>* %finalRandf2, align 16
  %tmp_60 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_11, <4 x float> %tmp_59, <4 x float> %tmp_9)
  %tmp_61 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_60)
  %tmp_62 = fmul <4 x float> %trajPrice2.0, %tmp_61
  %tmp_65 = fadd <4 x float> %sumPrice1.0, %tmp_55
  %tmp_68 = fadd <4 x float> %sumPrice2.0, %tmp_62
  %tmp_71 = fmul <4 x float> %tmp_13, %tmp_19
  %tmp_73 = sitofp i32 %i.0 to float
  %tmp_74 = insertelement <4 x float> undef, float %tmp_73, i32 0
  %tmp_75 = shufflevector <4 x float> %tmp_74, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_76 = fmul <4 x float> %tmp_71, %tmp_75
  %tmp_81 = fdiv <4 x float> %tmp_55, %tmp_15, !fpmath !2
  %tmp_82 = call <4 x float> @llvm.log2.v4f32(<4 x float> %tmp_81)
  %tmp_84 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_76
  %tmp_85 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_82, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %tmp_84)
  %tmp_87 = fdiv <4 x float> %tmp_85, %tmp_17, !fpmath !2
  %tmp_88 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_55, <4 x float> %tmp_87, <4 x float> %sumDeriv1.0)
  %tmp_93 = fdiv <4 x float> %tmp_62, %tmp_15, !fpmath !2
  %tmp_94 = call <4 x float> @llvm.log2.v4f32(<4 x float> %tmp_93)
  %tmp_96 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_76
  %tmp_97 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_94, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %tmp_96)
  %tmp_99 = fdiv <4 x float> %tmp_97, %tmp_17, !fpmath !2
  %tmp_100 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_62, <4 x float> %tmp_99, <4 x float> %sumDeriv2.0)
  br label %tmp_101

tmp_101:                                          ; preds = %tmp_46
  %tmp_103 = add nsw i32 %i.0, 1
  br label %tmp_42

tmp_104:                                          ; preds = %tmp_42
  %tmp_107 = sitofp i32 %noOfSum to float
  %tmp_108 = insertelement <4 x float> undef, float %tmp_107, i32 0
  %tmp_109 = shufflevector <4 x float> %tmp_108, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_110 = fdiv <4 x float> %sumPrice1.0, %tmp_109, !fpmath !2
  %tmp_113 = sitofp i32 %noOfSum to float
  %tmp_114 = insertelement <4 x float> undef, float %tmp_113, i32 0
  %tmp_115 = shufflevector <4 x float> %tmp_114, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_116 = fdiv <4 x float> %sumPrice2.0, %tmp_115, !fpmath !2
  %tmp_119 = sitofp i32 %noOfSum to float
  %tmp_120 = insertelement <4 x float> undef, float %tmp_119, i32 0
  %tmp_121 = shufflevector <4 x float> %tmp_120, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_122 = fdiv <4 x float> %sumDeriv1.0, %tmp_121, !fpmath !2
  %tmp_125 = sitofp i32 %noOfSum to float
  %tmp_126 = insertelement <4 x float> undef, float %tmp_125, i32 0
  %tmp_127 = shufflevector <4 x float> %tmp_126, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_128 = fdiv <4 x float> %sumDeriv2.0, %tmp_127, !fpmath !2
  call void @calOutputs(<4 x float> %tmp_7, <4 x float> %tmp_122, <4 x float> %tmp_128, <4 x float> %tmp_110, <4 x float> %tmp_116, <4 x float>* %pathDeriv1, <4 x float>* %pathDeriv2, <4 x float>* %price1, <4 x float>* %price2)
  %tmp_134 = load <4 x float>* %price1, align 16
  %tmp_137 = mul i32 %tmp_21, %width
  %tmp_139 = add i32 %tmp_137, %tmp_20
  %tmp_140 = mul i32 %tmp_139, 2
  %tmp_142 = getelementptr inbounds <4 x float> addrspace(1)* %priceSamples, i32 %tmp_140
  store <4 x float> %tmp_134, <4 x float> addrspace(1)* %tmp_142, align 16
  %tmp_143 = load <4 x float>* %price2, align 16
  %tmp_146 = mul i32 %tmp_21, %width
  %tmp_148 = add i32 %tmp_146, %tmp_20
  %tmp_149 = mul i32 %tmp_148, 2
  %tmp_150 = add i32 %tmp_149, 1
  %tmp_152 = getelementptr inbounds <4 x float> addrspace(1)* %priceSamples, i32 %tmp_150
  store <4 x float> %tmp_143, <4 x float> addrspace(1)* %tmp_152, align 16
  %tmp_153 = load <4 x float>* %pathDeriv1, align 16
  %tmp_156 = mul i32 %tmp_21, %width
  %tmp_158 = add i32 %tmp_156, %tmp_20
  %tmp_159 = mul i32 %tmp_158, 2
  %tmp_161 = getelementptr inbounds <4 x float> addrspace(1)* %pathDeriv, i32 %tmp_159
  store <4 x float> %tmp_153, <4 x float> addrspace(1)* %tmp_161, align 16
  %tmp_162 = load <4 x float>* %pathDeriv2, align 16
  %tmp_165 = mul i32 %tmp_21, %width
  %tmp_167 = add i32 %tmp_165, %tmp_20
  %tmp_168 = mul i32 %tmp_167, 2
  %tmp_169 = add i32 %tmp_168, 1
  %tmp_171 = getelementptr inbounds <4 x float> addrspace(1)* %pathDeriv, i32 %tmp_169
  store <4 x float> %tmp_162, <4 x float> addrspace(1)* %tmp_171, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #3

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind readnone }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (%struct._MonteCalroAttrib*, i32, i32, <4 x i32> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @calPriceVega}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

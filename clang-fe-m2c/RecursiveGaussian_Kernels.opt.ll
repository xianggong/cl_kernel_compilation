; ModuleID = 'RecursiveGaussian_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @transpose_kernel(<4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(3)* %block, i32 %width, i32 %height, i32 %blockSize) #0 {
  %tmp_7 = call i32 @__get_global_id_u32(i32 0)
  %tmp_8 = call i32 @__get_global_id_u32(i32 1)
  %tmp_9 = call i32 @__get_local_id_u32(i32 0)
  %tmp_10 = call i32 @__get_local_id_u32(i32 1)
  %tmp_13 = mul i32 %tmp_8, %width
  %tmp_15 = add i32 %tmp_13, %tmp_7
  %tmp_17 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %tmp_15
  %tmp_18 = load <4 x i8> addrspace(1)* %tmp_17, align 4
  %tmp_21 = mul i32 %tmp_10, %blockSize
  %tmp_23 = add i32 %tmp_21, %tmp_9
  %tmp_25 = getelementptr inbounds <4 x i8> addrspace(3)* %block, i32 %tmp_23
  store <4 x i8> %tmp_18, <4 x i8> addrspace(3)* %tmp_25, align 4
  call void @barrier(i32 1)
  %tmp_28 = mul i32 %tmp_10, %blockSize
  %tmp_30 = add i32 %tmp_28, %tmp_9
  %tmp_34 = mul i32 %tmp_7, %height
  %tmp_35 = add i32 %tmp_8, %tmp_34
  %tmp_38 = getelementptr inbounds <4 x i8> addrspace(3)* %block, i32 %tmp_30
  %tmp_39 = load <4 x i8> addrspace(3)* %tmp_38, align 4
  %tmp_42 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %tmp_35
  store <4 x i8> %tmp_39, <4 x i8> addrspace(1)* %tmp_42, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @RecursiveGaussian_kernel(<4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)* %output, i32 %width, i32 %height, float %a0, float %a1, float %a2, float %a3, float %b1, float %b2, float %coefp, float %coefn) #0 {
  %tmp_18 = call i32 @__get_global_id_u32(i32 0)
  %tmp_21 = icmp uge i32 %tmp_18, %width
  br i1 %tmp_21, label %tmp_22, label %tmp_23

tmp_22:                                           ; preds = %0
  br label %tmp_232

tmp_23:                                           ; preds = %0
  br label %tmp_24

tmp_24:                                           ; preds = %tmp_108, %tmp_23
  %xp.0 = phi <4 x float> [ zeroinitializer, %tmp_23 ], [ %tmp_61, %tmp_108 ]
  %yp.0 = phi <4 x float> [ zeroinitializer, %tmp_23 ], [ %tmp_84, %tmp_108 ]
  %yb.0 = phi <4 x float> [ zeroinitializer, %tmp_23 ], [ %yp.0, %tmp_108 ]
  %y.0 = phi i32 [ 0, %tmp_23 ], [ %tmp_110, %tmp_108 ]
  %tmp_27 = icmp slt i32 %y.0, %height
  br i1 %tmp_27, label %tmp_28, label %tmp_111

tmp_28:                                           ; preds = %tmp_24
  %tmp_32 = mul nsw i32 %y.0, %width
  %tmp_33 = add i32 %tmp_18, %tmp_32
  %tmp_36 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %tmp_33
  %tmp_37 = load <4 x i8> addrspace(1)* %tmp_36, align 4
  %tmp_38 = extractelement <4 x i8> %tmp_37, i32 0
  %tmp_39 = uitofp i8 %tmp_38 to float
  %tmp_40 = insertelement <4 x float> undef, float %tmp_39, i32 0
  %tmp_43 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %tmp_33
  %tmp_44 = load <4 x i8> addrspace(1)* %tmp_43, align 4
  %tmp_45 = extractelement <4 x i8> %tmp_44, i32 1
  %tmp_46 = uitofp i8 %tmp_45 to float
  %tmp_47 = insertelement <4 x float> %tmp_40, float %tmp_46, i32 1
  %tmp_50 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %tmp_33
  %tmp_51 = load <4 x i8> addrspace(1)* %tmp_50, align 4
  %tmp_52 = extractelement <4 x i8> %tmp_51, i32 2
  %tmp_53 = uitofp i8 %tmp_52 to float
  %tmp_54 = insertelement <4 x float> %tmp_47, float %tmp_53, i32 2
  %tmp_57 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %tmp_33
  %tmp_58 = load <4 x i8> addrspace(1)* %tmp_57, align 4
  %tmp_59 = extractelement <4 x i8> %tmp_58, i32 3
  %tmp_60 = uitofp i8 %tmp_59 to float
  %tmp_61 = insertelement <4 x float> %tmp_54, float %tmp_60, i32 3
  %tmp_64 = insertelement <4 x float> undef, float %a0, i32 0
  %tmp_65 = shufflevector <4 x float> %tmp_64, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_68 = insertelement <4 x float> undef, float %a1, i32 0
  %tmp_69 = shufflevector <4 x float> %tmp_68, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_71 = fmul <4 x float> %tmp_69, %xp.0
  %tmp_72 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_65, <4 x float> %tmp_61, <4 x float> %tmp_71)
  %tmp_74 = insertelement <4 x float> undef, float %b1, i32 0
  %tmp_75 = shufflevector <4 x float> %tmp_74, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_77 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_75
  %tmp_78 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_77, <4 x float> %yp.0, <4 x float> %tmp_72)
  %tmp_80 = insertelement <4 x float> undef, float %b2, i32 0
  %tmp_81 = shufflevector <4 x float> %tmp_80, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_83 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_81
  %tmp_84 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_83, <4 x float> %yb.0, <4 x float> %tmp_78)
  %tmp_86 = extractelement <4 x float> %tmp_84, i32 0
  %tmp_87 = fptoui float %tmp_86 to i8
  %tmp_88 = insertelement <4 x i8> undef, i8 %tmp_87, i32 0
  %tmp_90 = extractelement <4 x float> %tmp_84, i32 1
  %tmp_91 = fptoui float %tmp_90 to i8
  %tmp_92 = insertelement <4 x i8> %tmp_88, i8 %tmp_91, i32 1
  %tmp_94 = extractelement <4 x float> %tmp_84, i32 2
  %tmp_95 = fptoui float %tmp_94 to i8
  %tmp_96 = insertelement <4 x i8> %tmp_92, i8 %tmp_95, i32 2
  %tmp_98 = extractelement <4 x float> %tmp_84, i32 3
  %tmp_99 = fptoui float %tmp_98 to i8
  %tmp_100 = insertelement <4 x i8> %tmp_96, i8 %tmp_99, i32 3
  %tmp_104 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %tmp_33
  store <4 x i8> %tmp_100, <4 x i8> addrspace(1)* %tmp_104, align 4
  br label %tmp_108

tmp_108:                                          ; preds = %tmp_28
  %tmp_110 = add nsw i32 %y.0, 1
  br label %tmp_24

tmp_111:                                          ; preds = %tmp_24
  call void @barrier(i32 2)
  %tmp_113 = sub nsw i32 %height, 1
  br label %tmp_114

tmp_114:                                          ; preds = %tmp_229, %tmp_111
  %xn.0 = phi <4 x float> [ zeroinitializer, %tmp_111 ], [ %tmp_150, %tmp_229 ]
  %xa.0 = phi <4 x float> [ zeroinitializer, %tmp_111 ], [ %xn.0, %tmp_229 ]
  %yn.0 = phi <4 x float> [ zeroinitializer, %tmp_111 ], [ %tmp_173, %tmp_229 ]
  %ya.0 = phi <4 x float> [ zeroinitializer, %tmp_111 ], [ %yn.0, %tmp_229 ]
  %y1.0 = phi i32 [ %tmp_113, %tmp_111 ], [ %tmp_231, %tmp_229 ]
  %tmp_116 = icmp sgt i32 %y1.0, -1
  br i1 %tmp_116, label %tmp_117, label %tmp_232

tmp_117:                                          ; preds = %tmp_114
  %tmp_121 = mul nsw i32 %y1.0, %width
  %tmp_122 = add i32 %tmp_18, %tmp_121
  %tmp_125 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %tmp_122
  %tmp_126 = load <4 x i8> addrspace(1)* %tmp_125, align 4
  %tmp_127 = extractelement <4 x i8> %tmp_126, i32 0
  %tmp_128 = uitofp i8 %tmp_127 to float
  %tmp_129 = insertelement <4 x float> undef, float %tmp_128, i32 0
  %tmp_132 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %tmp_122
  %tmp_133 = load <4 x i8> addrspace(1)* %tmp_132, align 4
  %tmp_134 = extractelement <4 x i8> %tmp_133, i32 1
  %tmp_135 = uitofp i8 %tmp_134 to float
  %tmp_136 = insertelement <4 x float> %tmp_129, float %tmp_135, i32 1
  %tmp_139 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %tmp_122
  %tmp_140 = load <4 x i8> addrspace(1)* %tmp_139, align 4
  %tmp_141 = extractelement <4 x i8> %tmp_140, i32 2
  %tmp_142 = uitofp i8 %tmp_141 to float
  %tmp_143 = insertelement <4 x float> %tmp_136, float %tmp_142, i32 2
  %tmp_146 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %tmp_122
  %tmp_147 = load <4 x i8> addrspace(1)* %tmp_146, align 4
  %tmp_148 = extractelement <4 x i8> %tmp_147, i32 3
  %tmp_149 = uitofp i8 %tmp_148 to float
  %tmp_150 = insertelement <4 x float> %tmp_143, float %tmp_149, i32 3
  %tmp_153 = insertelement <4 x float> undef, float %a2, i32 0
  %tmp_154 = shufflevector <4 x float> %tmp_153, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_157 = insertelement <4 x float> undef, float %a3, i32 0
  %tmp_158 = shufflevector <4 x float> %tmp_157, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_160 = fmul <4 x float> %tmp_158, %xa.0
  %tmp_161 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_154, <4 x float> %xn.0, <4 x float> %tmp_160)
  %tmp_163 = insertelement <4 x float> undef, float %b1, i32 0
  %tmp_164 = shufflevector <4 x float> %tmp_163, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_166 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_164
  %tmp_167 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_166, <4 x float> %yn.0, <4 x float> %tmp_161)
  %tmp_169 = insertelement <4 x float> undef, float %b2, i32 0
  %tmp_170 = shufflevector <4 x float> %tmp_169, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_172 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_170
  %tmp_173 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_172, <4 x float> %ya.0, <4 x float> %tmp_167)
  %tmp_180 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %tmp_122
  %tmp_181 = load <4 x i8> addrspace(1)* %tmp_180, align 4
  %tmp_182 = extractelement <4 x i8> %tmp_181, i32 0
  %tmp_183 = uitofp i8 %tmp_182 to float
  %tmp_184 = insertelement <4 x float> undef, float %tmp_183, i32 0
  %tmp_187 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %tmp_122
  %tmp_188 = load <4 x i8> addrspace(1)* %tmp_187, align 4
  %tmp_189 = extractelement <4 x i8> %tmp_188, i32 1
  %tmp_190 = uitofp i8 %tmp_189 to float
  %tmp_191 = insertelement <4 x float> %tmp_184, float %tmp_190, i32 1
  %tmp_194 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %tmp_122
  %tmp_195 = load <4 x i8> addrspace(1)* %tmp_194, align 4
  %tmp_196 = extractelement <4 x i8> %tmp_195, i32 2
  %tmp_197 = uitofp i8 %tmp_196 to float
  %tmp_198 = insertelement <4 x float> %tmp_191, float %tmp_197, i32 2
  %tmp_201 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %tmp_122
  %tmp_202 = load <4 x i8> addrspace(1)* %tmp_201, align 4
  %tmp_203 = extractelement <4 x i8> %tmp_202, i32 3
  %tmp_204 = uitofp i8 %tmp_203 to float
  %tmp_205 = insertelement <4 x float> %tmp_198, float %tmp_204, i32 3
  %tmp_208 = fadd <4 x float> %tmp_205, %tmp_173
  %tmp_210 = extractelement <4 x float> %tmp_208, i32 0
  %tmp_211 = fptoui float %tmp_210 to i8
  %tmp_212 = insertelement <4 x i8> undef, i8 %tmp_211, i32 0
  %tmp_214 = extractelement <4 x float> %tmp_208, i32 1
  %tmp_215 = fptoui float %tmp_214 to i8
  %tmp_216 = insertelement <4 x i8> %tmp_212, i8 %tmp_215, i32 1
  %tmp_218 = extractelement <4 x float> %tmp_208, i32 2
  %tmp_219 = fptoui float %tmp_218 to i8
  %tmp_220 = insertelement <4 x i8> %tmp_216, i8 %tmp_219, i32 2
  %tmp_222 = extractelement <4 x float> %tmp_208, i32 3
  %tmp_223 = fptoui float %tmp_222 to i8
  %tmp_224 = insertelement <4 x i8> %tmp_220, i8 %tmp_223, i32 3
  %tmp_228 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %tmp_122
  store <4 x i8> %tmp_224, <4 x i8> addrspace(1)* %tmp_228, align 4
  br label %tmp_229

tmp_229:                                          ; preds = %tmp_117
  %tmp_231 = add nsw i32 %y1.0, -1
  br label %tmp_114

tmp_232:                                          ; preds = %tmp_114, %tmp_22
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, <4 x i8> addrspace(3)*, i32, i32, i32)* @transpose_kernel}
!1 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, i32, float, float, float, float, float, float, float, float)* @RecursiveGaussian_kernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

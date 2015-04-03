; ModuleID = 'BinomialOption_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @binomial_options(i32 %numSteps, <4 x float> addrspace(1)* %randArray, <4 x float> addrspace(1)* %output, <4 x float> addrspace(3)* %callA, <4 x float> addrspace(3)* %callB) #0 {
  %tmp_6 = call i32 @__get_local_id_u32(i32 0)
  %tmp_7 = call i32 @__get_group_id_u32(i32 0)
  %tmp_10 = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i32 %tmp_7
  %tmp_11 = load <4 x float> addrspace(1)* %tmp_10, align 16
  %tmp_13 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_11
  %tmp_15 = fmul <4 x float> %tmp_11, <float 3.000000e+01, float 3.000000e+01, float 3.000000e+01, float 3.000000e+01>
  %tmp_16 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_13, <4 x float> <float 5.000000e+00, float 5.000000e+00, float 5.000000e+00, float 5.000000e+00>, <4 x float> %tmp_15)
  %tmp_18 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_11
  %tmp_20 = fmul <4 x float> %tmp_11, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %tmp_21 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_18, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %tmp_20)
  %tmp_23 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_11
  %tmp_25 = fmul <4 x float> %tmp_11, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %tmp_26 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_23, <4 x float> <float 2.500000e-01, float 2.500000e-01, float 2.500000e-01, float 2.500000e-01>, <4 x float> %tmp_25)
  %tmp_29 = sitofp i32 %numSteps to float
  %tmp_30 = fdiv float 1.000000e+00, %tmp_29, !fpmath !2
  %tmp_31 = insertelement <4 x float> undef, float %tmp_30, i32 0
  %tmp_32 = shufflevector <4 x float> %tmp_31, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_33 = fmul <4 x float> %tmp_26, %tmp_32
  %tmp_35 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %tmp_33)
  %tmp_36 = fmul <4 x float> <float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000>, %tmp_35
  %tmp_38 = fmul <4 x float> <float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000>, %tmp_33
  %tmp_40 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_38)
  %tmp_42 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_40, !fpmath !2
  %tmp_44 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_36)
  %tmp_46 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_44, !fpmath !2
  %tmp_49 = fsub <4 x float> %tmp_40, %tmp_46
  %tmp_52 = fsub <4 x float> %tmp_44, %tmp_46
  %tmp_53 = fdiv <4 x float> %tmp_49, %tmp_52, !fpmath !2
  %tmp_55 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_53
  %tmp_58 = fmul <4 x float> %tmp_53, %tmp_42
  %tmp_61 = fmul <4 x float> %tmp_55, %tmp_42
  %tmp_65 = uitofp i32 %tmp_6 to float
  %tmp_67 = sitofp i32 %numSteps to float
  %tmp_68 = fsub float -0.000000e+00, %tmp_67
  %tmp_69 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %tmp_65, float %tmp_68)
  %tmp_70 = insertelement <4 x float> undef, float %tmp_69, i32 0
  %tmp_71 = shufflevector <4 x float> %tmp_70, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_72 = fmul <4 x float> %tmp_36, %tmp_71
  %tmp_73 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_72)
  %tmp_75 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_21
  %tmp_76 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_16, <4 x float> %tmp_73, <4 x float> %tmp_75)
  %tmp_78 = extractelement <4 x float> %tmp_76, i32 0
  %tmp_79 = fcmp ogt float %tmp_78, 0.000000e+00
  br i1 %tmp_79, label %tmp_80, label %tmp_83

tmp_80:                                           ; preds = %0
  %tmp_82 = extractelement <4 x float> %tmp_76, i32 0
  br label %tmp_84

tmp_83:                                           ; preds = %0
  br label %tmp_84

tmp_84:                                           ; preds = %tmp_83, %tmp_80
  %tmp_85 = phi float [ %tmp_82, %tmp_80 ], [ 0.000000e+00, %tmp_83 ]
  %tmp_88 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %tmp_6
  %tmp_89 = load <4 x float> addrspace(3)* %tmp_88, align 16
  %tmp_90 = insertelement <4 x float> %tmp_89, float %tmp_85, i32 0
  store <4 x float> %tmp_90, <4 x float> addrspace(3)* %tmp_88, align 16
  %tmp_92 = extractelement <4 x float> %tmp_76, i32 1
  %tmp_93 = fcmp ogt float %tmp_92, 0.000000e+00
  br i1 %tmp_93, label %tmp_94, label %tmp_97

tmp_94:                                           ; preds = %tmp_84
  %tmp_96 = extractelement <4 x float> %tmp_76, i32 1
  br label %tmp_98

tmp_97:                                           ; preds = %tmp_84
  br label %tmp_98

tmp_98:                                           ; preds = %tmp_97, %tmp_94
  %tmp_99 = phi float [ %tmp_96, %tmp_94 ], [ 0.000000e+00, %tmp_97 ]
  %tmp_102 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %tmp_6
  %tmp_103 = load <4 x float> addrspace(3)* %tmp_102, align 16
  %tmp_104 = insertelement <4 x float> %tmp_103, float %tmp_99, i32 1
  store <4 x float> %tmp_104, <4 x float> addrspace(3)* %tmp_102, align 16
  %tmp_106 = extractelement <4 x float> %tmp_76, i32 2
  %tmp_107 = fcmp ogt float %tmp_106, 0.000000e+00
  br i1 %tmp_107, label %tmp_108, label %tmp_111

tmp_108:                                          ; preds = %tmp_98
  %tmp_110 = extractelement <4 x float> %tmp_76, i32 2
  br label %tmp_112

tmp_111:                                          ; preds = %tmp_98
  br label %tmp_112

tmp_112:                                          ; preds = %tmp_111, %tmp_108
  %tmp_113 = phi float [ %tmp_110, %tmp_108 ], [ 0.000000e+00, %tmp_111 ]
  %tmp_116 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %tmp_6
  %tmp_117 = load <4 x float> addrspace(3)* %tmp_116, align 16
  %tmp_118 = insertelement <4 x float> %tmp_117, float %tmp_113, i32 2
  store <4 x float> %tmp_118, <4 x float> addrspace(3)* %tmp_116, align 16
  %tmp_120 = extractelement <4 x float> %tmp_76, i32 3
  %tmp_121 = fcmp ogt float %tmp_120, 0.000000e+00
  br i1 %tmp_121, label %tmp_122, label %tmp_125

tmp_122:                                          ; preds = %tmp_112
  %tmp_124 = extractelement <4 x float> %tmp_76, i32 3
  br label %tmp_126

tmp_125:                                          ; preds = %tmp_112
  br label %tmp_126

tmp_126:                                          ; preds = %tmp_125, %tmp_122
  %tmp_127 = phi float [ %tmp_124, %tmp_122 ], [ 0.000000e+00, %tmp_125 ]
  %tmp_130 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %tmp_6
  %tmp_131 = load <4 x float> addrspace(3)* %tmp_130, align 16
  %tmp_132 = insertelement <4 x float> %tmp_131, float %tmp_127, i32 3
  store <4 x float> %tmp_132, <4 x float> addrspace(3)* %tmp_130, align 16
  call void @barrier(i32 1)
  br label %tmp_134

tmp_134:                                          ; preds = %tmp_181, %tmp_126
  %j.0 = phi i32 [ %numSteps, %tmp_126 ], [ %tmp_183, %tmp_181 ]
  %tmp_136 = icmp sgt i32 %j.0, 0
  br i1 %tmp_136, label %tmp_137, label %tmp_184

tmp_137:                                          ; preds = %tmp_134
  %tmp_140 = icmp ult i32 %tmp_6, %j.0
  br i1 %tmp_140, label %tmp_141, label %tmp_158

tmp_141:                                          ; preds = %tmp_137
  %tmp_145 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %tmp_6
  %tmp_146 = load <4 x float> addrspace(3)* %tmp_145, align 16
  %tmp_149 = add i32 %tmp_6, 1
  %tmp_151 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %tmp_149
  %tmp_152 = load <4 x float> addrspace(3)* %tmp_151, align 16
  %tmp_153 = fmul <4 x float> %tmp_61, %tmp_152
  %tmp_154 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_58, <4 x float> %tmp_146, <4 x float> %tmp_153)
  %tmp_157 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %tmp_6
  store <4 x float> %tmp_154, <4 x float> addrspace(3)* %tmp_157, align 16
  br label %tmp_158

tmp_158:                                          ; preds = %tmp_141, %tmp_137
  call void @barrier(i32 1)
  %tmp_161 = sub nsw i32 %j.0, 1
  %tmp_162 = icmp ult i32 %tmp_6, %tmp_161
  br i1 %tmp_162, label %tmp_163, label %tmp_180

tmp_163:                                          ; preds = %tmp_158
  %tmp_167 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %tmp_6
  %tmp_168 = load <4 x float> addrspace(3)* %tmp_167, align 16
  %tmp_171 = add i32 %tmp_6, 1
  %tmp_173 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %tmp_171
  %tmp_174 = load <4 x float> addrspace(3)* %tmp_173, align 16
  %tmp_175 = fmul <4 x float> %tmp_61, %tmp_174
  %tmp_176 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_58, <4 x float> %tmp_168, <4 x float> %tmp_175)
  %tmp_179 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %tmp_6
  store <4 x float> %tmp_176, <4 x float> addrspace(3)* %tmp_179, align 16
  br label %tmp_180

tmp_180:                                          ; preds = %tmp_163, %tmp_158
  call void @barrier(i32 1)
  br label %tmp_181

tmp_181:                                          ; preds = %tmp_180
  %tmp_183 = sub nsw i32 %j.0, 2
  br label %tmp_134

tmp_184:                                          ; preds = %tmp_134
  %tmp_186 = icmp eq i32 %tmp_6, 0
  br i1 %tmp_186, label %tmp_187, label %tmp_194

tmp_187:                                          ; preds = %tmp_184
  %tmp_189 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 0
  %tmp_190 = load <4 x float> addrspace(3)* %tmp_189, align 16
  %tmp_193 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_7
  store <4 x float> %tmp_190, <4 x float> addrspace(1)* %tmp_193, align 16
  br label %tmp_194

tmp_194:                                          ; preds = %tmp_187, %tmp_184
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #3

declare <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*, <4 x float> addrspace(3)*)* @binomial_options}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

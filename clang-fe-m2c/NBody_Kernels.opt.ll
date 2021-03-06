; ModuleID = 'NBody_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @nbody_sim(<4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)* %vel, i32 %numBodies, float %deltaTime, float %epsSqr, <4 x float> addrspace(1)* %newPosition, <4 x float> addrspace(1)* %newVelocity) #0 {
  %tmp_8 = call i32 @__get_global_id_u32(i32 0)
  %tmp_11 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %tmp_8
  %tmp_12 = load <4 x float> addrspace(1)* %tmp_11, align 16
  br label %tmp_13

tmp_13:                                           ; preds = %tmp_81, %0
  %acc.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %acc.1, %tmp_81 ]
  %i.0 = phi i32 [ 0, %0 ], [ %i.1, %tmp_81 ]
  %tmp_15 = add nsw i32 %i.0, 8
  %tmp_17 = icmp slt i32 %tmp_15, %numBodies
  br i1 %tmp_17, label %tmp_18, label %tmp_82

tmp_18:                                           ; preds = %tmp_13
  br label %tmp_19

tmp_19:                                           ; preds = %tmp_76, %tmp_18
  %acc.1 = phi <4 x float> [ %acc.0, %tmp_18 ], [ %tmp_75, %tmp_76 ]
  %i.1 = phi i32 [ %i.0, %tmp_18 ], [ %tmp_80, %tmp_76 ]
  %j.0 = phi i32 [ 0, %tmp_18 ], [ %tmp_78, %tmp_76 ]
  %tmp_21 = icmp slt i32 %j.0, 8
  br i1 %tmp_21, label %tmp_22, label %tmp_81

tmp_22:                                           ; preds = %tmp_19
  %tmp_25 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %i.1
  %tmp_26 = load <4 x float> addrspace(1)* %tmp_25, align 16
  %tmp_28 = shufflevector <4 x float> %tmp_26, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_30 = shufflevector <4 x float> %tmp_12, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_31 = fsub <3 x float> %tmp_28, %tmp_30
  %tmp_33 = shufflevector <3 x float> %tmp_31, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_34 = shufflevector <4 x float> undef, <4 x float> %tmp_33, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %tmp_36 = extractelement <4 x float> %tmp_34, i32 0
  %tmp_38 = extractelement <4 x float> %tmp_34, i32 0
  %tmp_40 = extractelement <4 x float> %tmp_34, i32 1
  %tmp_42 = extractelement <4 x float> %tmp_34, i32 1
  %tmp_43 = fmul float %tmp_40, %tmp_42
  %tmp_44 = call float @llvm.fmuladd.f32(float %tmp_36, float %tmp_38, float %tmp_43)
  %tmp_46 = extractelement <4 x float> %tmp_34, i32 2
  %tmp_48 = extractelement <4 x float> %tmp_34, i32 2
  %tmp_49 = call float @llvm.fmuladd.f32(float %tmp_46, float %tmp_48, float %tmp_44)
  %tmp_52 = fadd float %tmp_49, %epsSqr
  %tmp_53 = call float @llvm.sqrt.f32(float %tmp_52)
  %tmp_54 = fdiv float 1.000000e+00, %tmp_53, !fpmath !2
  %tmp_57 = fmul float %tmp_54, %tmp_54
  %tmp_59 = fmul float %tmp_57, %tmp_54
  %tmp_61 = extractelement <4 x float> %tmp_26, i32 3
  %tmp_63 = fmul float %tmp_61, %tmp_59
  %tmp_65 = insertelement <3 x float> undef, float %tmp_63, i32 0
  %tmp_66 = shufflevector <3 x float> %tmp_65, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_68 = shufflevector <4 x float> %tmp_34, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_69 = fmul <3 x float> %tmp_66, %tmp_68
  %tmp_71 = shufflevector <4 x float> %acc.1, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_72 = fadd <3 x float> %tmp_71, %tmp_69
  %tmp_74 = shufflevector <3 x float> %tmp_72, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_75 = shufflevector <4 x float> %acc.1, <4 x float> %tmp_74, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  br label %tmp_76

tmp_76:                                           ; preds = %tmp_22
  %tmp_78 = add nsw i32 %j.0, 1
  %tmp_80 = add nsw i32 %i.1, 1
  br label %tmp_19

tmp_81:                                           ; preds = %tmp_19
  br label %tmp_13

tmp_82:                                           ; preds = %tmp_13
  br label %tmp_83

tmp_83:                                           ; preds = %tmp_141, %tmp_82
  %acc.2 = phi <4 x float> [ %acc.0, %tmp_82 ], [ %tmp_140, %tmp_141 ]
  %i.2 = phi i32 [ %i.0, %tmp_82 ], [ %tmp_143, %tmp_141 ]
  %tmp_86 = icmp slt i32 %i.2, %numBodies
  br i1 %tmp_86, label %tmp_87, label %tmp_144

tmp_87:                                           ; preds = %tmp_83
  %tmp_90 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %i.2
  %tmp_91 = load <4 x float> addrspace(1)* %tmp_90, align 16
  %tmp_93 = shufflevector <4 x float> %tmp_91, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_95 = shufflevector <4 x float> %tmp_12, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_96 = fsub <3 x float> %tmp_93, %tmp_95
  %tmp_98 = shufflevector <3 x float> %tmp_96, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_99 = shufflevector <4 x float> undef, <4 x float> %tmp_98, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %tmp_101 = extractelement <4 x float> %tmp_99, i32 0
  %tmp_103 = extractelement <4 x float> %tmp_99, i32 0
  %tmp_105 = extractelement <4 x float> %tmp_99, i32 1
  %tmp_107 = extractelement <4 x float> %tmp_99, i32 1
  %tmp_108 = fmul float %tmp_105, %tmp_107
  %tmp_109 = call float @llvm.fmuladd.f32(float %tmp_101, float %tmp_103, float %tmp_108)
  %tmp_111 = extractelement <4 x float> %tmp_99, i32 2
  %tmp_113 = extractelement <4 x float> %tmp_99, i32 2
  %tmp_114 = call float @llvm.fmuladd.f32(float %tmp_111, float %tmp_113, float %tmp_109)
  %tmp_117 = fadd float %tmp_114, %epsSqr
  %tmp_118 = call float @llvm.sqrt.f32(float %tmp_117)
  %tmp_119 = fdiv float 1.000000e+00, %tmp_118, !fpmath !2
  %tmp_122 = fmul float %tmp_119, %tmp_119
  %tmp_124 = fmul float %tmp_122, %tmp_119
  %tmp_126 = extractelement <4 x float> %tmp_91, i32 3
  %tmp_128 = fmul float %tmp_126, %tmp_124
  %tmp_130 = insertelement <3 x float> undef, float %tmp_128, i32 0
  %tmp_131 = shufflevector <3 x float> %tmp_130, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_133 = shufflevector <4 x float> %tmp_99, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_134 = fmul <3 x float> %tmp_131, %tmp_133
  %tmp_136 = shufflevector <4 x float> %acc.2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_137 = fadd <3 x float> %tmp_136, %tmp_134
  %tmp_139 = shufflevector <3 x float> %tmp_137, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_140 = shufflevector <4 x float> %acc.2, <4 x float> %tmp_139, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  br label %tmp_141

tmp_141:                                          ; preds = %tmp_87
  %tmp_143 = add nsw i32 %i.2, 1
  br label %tmp_83

tmp_144:                                          ; preds = %tmp_83
  %tmp_147 = getelementptr inbounds <4 x float> addrspace(1)* %vel, i32 %tmp_8
  %tmp_148 = load <4 x float> addrspace(1)* %tmp_147, align 16
  %tmp_150 = shufflevector <4 x float> %tmp_12, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_152 = shufflevector <4 x float> %tmp_148, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_154 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %tmp_155 = shufflevector <3 x float> %tmp_154, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_156 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %tmp_152, <3 x float> %tmp_155, <3 x float> %tmp_150)
  %tmp_158 = shufflevector <4 x float> %acc.2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_159 = fmul <3 x float> %tmp_158, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %tmp_161 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %tmp_162 = shufflevector <3 x float> %tmp_161, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_163 = fmul <3 x float> %tmp_159, %tmp_162
  %tmp_165 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %tmp_166 = shufflevector <3 x float> %tmp_165, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_167 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %tmp_163, <3 x float> %tmp_166, <3 x float> %tmp_156)
  %tmp_169 = shufflevector <3 x float> %tmp_167, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_170 = shufflevector <4 x float> undef, <4 x float> %tmp_169, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %tmp_172 = extractelement <4 x float> %tmp_12, i32 3
  %tmp_174 = insertelement <4 x float> %tmp_170, float %tmp_172, i32 3
  %tmp_176 = shufflevector <4 x float> %tmp_148, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_178 = shufflevector <4 x float> %acc.2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_180 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %tmp_181 = shufflevector <3 x float> %tmp_180, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_182 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %tmp_178, <3 x float> %tmp_181, <3 x float> %tmp_176)
  %tmp_184 = shufflevector <3 x float> %tmp_182, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_185 = shufflevector <4 x float> undef, <4 x float> %tmp_184, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %tmp_187 = extractelement <4 x float> %tmp_148, i32 3
  %tmp_189 = insertelement <4 x float> %tmp_185, float %tmp_187, i32 3
  %tmp_193 = getelementptr inbounds <4 x float> addrspace(1)* %newPosition, i32 %tmp_8
  store <4 x float> %tmp_174, <4 x float> addrspace(1)* %tmp_193, align 16
  %tmp_197 = getelementptr inbounds <4 x float> addrspace(1)* %newVelocity, i32 %tmp_8
  store <4 x float> %tmp_189, <4 x float> addrspace(1)* %tmp_197, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #3

; Function Attrs: nounwind readnone
declare <3 x float> @llvm.fmuladd.v3f32(<3 x float>, <3 x float>, <3 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, float, float, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @nbody_sim}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

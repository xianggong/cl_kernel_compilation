; ModuleID = '../kernel-src/NBody_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @nbody_sim(<4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)* %vel, i32 %numBodies, float %deltaTime, float %epsSqr, <4 x float> addrspace(1)* %newPosition, <4 x float> addrspace(1)* %newVelocity) #0 {
  %tmp_1 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca float, align 4
  %tmp_5 = alloca float, align 4
  %tmp_6 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_7 = alloca <4 x float> addrspace(1)*, align 4
  %gid = alloca i32, align 4
  %myPos = alloca <4 x float>, align 16
  %acc = alloca <4 x float>, align 16
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %p = alloca <4 x float>, align 16
  %r = alloca <4 x float>, align 16
  %distSqr = alloca float, align 4
  %invDist = alloca float, align 4
  %invDistCube = alloca float, align 4
  %s = alloca float, align 4
  %p1 = alloca <4 x float>, align 16
  %r2 = alloca <4 x float>, align 16
  %distSqr3 = alloca float, align 4
  %invDist4 = alloca float, align 4
  %invDistCube5 = alloca float, align 4
  %s6 = alloca float, align 4
  %oldVel = alloca <4 x float>, align 16
  %newPos = alloca <4 x float>, align 16
  %newVel = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)** %tmp_1, align 4
  store <4 x float> addrspace(1)* %vel, <4 x float> addrspace(1)** %tmp_2, align 4
  store i32 %numBodies, i32* %tmp_3, align 4
  store float %deltaTime, float* %tmp_4, align 4
  store float %epsSqr, float* %tmp_5, align 4
  store <4 x float> addrspace(1)* %newPosition, <4 x float> addrspace(1)** %tmp_6, align 4
  store <4 x float> addrspace(1)* %newVelocity, <4 x float> addrspace(1)** %tmp_7, align 4
  %tmp_8 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_8, i32* %gid, align 4
  %tmp_9 = load i32* %gid, align 4
  %tmp_10 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_11 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_10, i32 %tmp_9
  %tmp_12 = load <4 x float> addrspace(1)* %tmp_11, align 16
  store <4 x float> %tmp_12, <4 x float>* %myPos, align 16
  store <4 x float> zeroinitializer, <4 x float>* %acc, align 16
  store i32 0, i32* %i, align 4
  br label %tmp_13

tmp_13:                                      ; preds = %tmp_81, %tmp_0
  %tmp_14 = load i32* %i, align 4
  %tmp_15 = add nsw i32 %tmp_14, 8
  %tmp_16 = load i32* %tmp_3, align 4
  %tmp_17 = icmp slt i32 %tmp_15, %tmp_16
  br i1 %tmp_17, label %tmp_18, label %tmp_82

tmp_18:                                      ; preds = %tmp_13
  store i32 0, i32* %j, align 4
  br label %tmp_19

tmp_19:                                      ; preds = %tmp_76, %tmp_18
  %tmp_20 = load i32* %j, align 4
  %tmp_21 = icmp slt i32 %tmp_20, 8
  br i1 %tmp_21, label %tmp_22, label %tmp_81

tmp_22:                                      ; preds = %tmp_19
  %tmp_23 = load i32* %i, align 4
  %tmp_24 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_25 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_24, i32 %tmp_23
  %tmp_26 = load <4 x float> addrspace(1)* %tmp_25, align 16
  store <4 x float> %tmp_26, <4 x float>* %p, align 16
  %tmp_27 = load <4 x float>* %p, align 16
  %tmp_28 = shufflevector <4 x float> %tmp_27, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_29 = load <4 x float>* %myPos, align 16
  %tmp_30 = shufflevector <4 x float> %tmp_29, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_31 = fsub <3 x float> %tmp_28, %tmp_30
  %tmp_32 = load <4 x float>* %r, align 16
  %tmp_33 = shufflevector <3 x float> %tmp_31, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_34 = shufflevector <4 x float> %tmp_32, <4 x float> %tmp_33, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %tmp_34, <4 x float>* %r, align 16
  %tmp_35 = load <4 x float>* %r, align 16
  %tmp_36 = extractelement <4 x float> %tmp_35, i32 0
  %tmp_37 = load <4 x float>* %r, align 16
  %tmp_38 = extractelement <4 x float> %tmp_37, i32 0
  %tmp_39 = load <4 x float>* %r, align 16
  %tmp_40 = extractelement <4 x float> %tmp_39, i32 1
  %tmp_41 = load <4 x float>* %r, align 16
  %tmp_42 = extractelement <4 x float> %tmp_41, i32 1
  %tmp_43 = fmul float %tmp_40, %tmp_42
  %tmp_44 = call float @llvm.fmuladd.f32(float %tmp_36, float %tmp_38, float %tmp_43)
  %tmp_45 = load <4 x float>* %r, align 16
  %tmp_46 = extractelement <4 x float> %tmp_45, i32 2
  %tmp_47 = load <4 x float>* %r, align 16
  %tmp_48 = extractelement <4 x float> %tmp_47, i32 2
  %tmp_49 = call float @llvm.fmuladd.f32(float %tmp_46, float %tmp_48, float %tmp_44)
  store float %tmp_49, float* %distSqr, align 4
  %tmp_50 = load float* %distSqr, align 4
  %tmp_51 = load float* %tmp_5, align 4
  %tmp_52 = fadd float %tmp_50, %tmp_51
  %tmp_53 = call float @llvm.sqrt.f32(float %tmp_52)
  %tmp_54 = fdiv float 1.000000e+00, %tmp_53, !fpmath !2
  store float %tmp_54, float* %invDist, align 4
  %tmp_55 = load float* %invDist, align 4
  %tmp_56 = load float* %invDist, align 4
  %tmp_57 = fmul float %tmp_55, %tmp_56
  %tmp_58 = load float* %invDist, align 4
  %tmp_59 = fmul float %tmp_57, %tmp_58
  store float %tmp_59, float* %invDistCube, align 4
  %tmp_60 = load <4 x float>* %p, align 16
  %tmp_61 = extractelement <4 x float> %tmp_60, i32 3
  %tmp_62 = load float* %invDistCube, align 4
  %tmp_63 = fmul float %tmp_61, %tmp_62
  store float %tmp_63, float* %s, align 4
  %tmp_64 = load float* %s, align 4
  %tmp_65 = insertelement <3 x float> undef, float %tmp_64, i32 0
  %tmp_66 = shufflevector <3 x float> %tmp_65, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_67 = load <4 x float>* %r, align 16
  %tmp_68 = shufflevector <4 x float> %tmp_67, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_69 = fmul <3 x float> %tmp_66, %tmp_68
  %tmp_70 = load <4 x float>* %acc, align 16
  %tmp_71 = shufflevector <4 x float> %tmp_70, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_72 = fadd <3 x float> %tmp_71, %tmp_69
  %tmp_73 = load <4 x float>* %acc, align 16
  %tmp_74 = shufflevector <3 x float> %tmp_72, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_75 = shufflevector <4 x float> %tmp_73, <4 x float> %tmp_74, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %tmp_75, <4 x float>* %acc, align 16
  br label %tmp_76

tmp_76:                                      ; preds = %tmp_22
  %tmp_77 = load i32* %j, align 4
  %tmp_78 = add nsw i32 %tmp_77, 1
  store i32 %tmp_78, i32* %j, align 4
  %tmp_79 = load i32* %i, align 4
  %tmp_80 = add nsw i32 %tmp_79, 1
  store i32 %tmp_80, i32* %i, align 4
  br label %tmp_19

tmp_81:                                      ; preds = %tmp_19
  br label %tmp_13

tmp_82:                                      ; preds = %tmp_13
  br label %tmp_83

tmp_83:                                      ; preds = %tmp_141, %tmp_82
  %tmp_84 = load i32* %i, align 4
  %tmp_85 = load i32* %tmp_3, align 4
  %tmp_86 = icmp slt i32 %tmp_84, %tmp_85
  br i1 %tmp_86, label %tmp_87, label %tmp_144

tmp_87:                                      ; preds = %tmp_83
  %tmp_88 = load i32* %i, align 4
  %tmp_89 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_90 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_89, i32 %tmp_88
  %tmp_91 = load <4 x float> addrspace(1)* %tmp_90, align 16
  store <4 x float> %tmp_91, <4 x float>* %p1, align 16
  %tmp_92 = load <4 x float>* %p1, align 16
  %tmp_93 = shufflevector <4 x float> %tmp_92, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_94 = load <4 x float>* %myPos, align 16
  %tmp_95 = shufflevector <4 x float> %tmp_94, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_96 = fsub <3 x float> %tmp_93, %tmp_95
  %tmp_97 = load <4 x float>* %r2, align 16
  %tmp_98 = shufflevector <3 x float> %tmp_96, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_99 = shufflevector <4 x float> %tmp_97, <4 x float> %tmp_98, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %tmp_99, <4 x float>* %r2, align 16
  %tmp_100 = load <4 x float>* %r2, align 16
  %tmp_101 = extractelement <4 x float> %tmp_100, i32 0
  %tmp_102 = load <4 x float>* %r2, align 16
  %tmp_103 = extractelement <4 x float> %tmp_102, i32 0
  %tmp_104 = load <4 x float>* %r2, align 16
  %tmp_105 = extractelement <4 x float> %tmp_104, i32 1
  %tmp_106 = load <4 x float>* %r2, align 16
  %tmp_107 = extractelement <4 x float> %tmp_106, i32 1
  %tmp_108 = fmul float %tmp_105, %tmp_107
  %tmp_109 = call float @llvm.fmuladd.f32(float %tmp_101, float %tmp_103, float %tmp_108)
  %tmp_110 = load <4 x float>* %r2, align 16
  %tmp_111 = extractelement <4 x float> %tmp_110, i32 2
  %tmp_112 = load <4 x float>* %r2, align 16
  %tmp_113 = extractelement <4 x float> %tmp_112, i32 2
  %tmp_114 = call float @llvm.fmuladd.f32(float %tmp_111, float %tmp_113, float %tmp_109)
  store float %tmp_114, float* %distSqr3, align 4
  %tmp_115 = load float* %distSqr3, align 4
  %tmp_116 = load float* %tmp_5, align 4
  %tmp_117 = fadd float %tmp_115, %tmp_116
  %tmp_118 = call float @llvm.sqrt.f32(float %tmp_117)
  %tmp_119 = fdiv float 1.000000e+00, %tmp_118, !fpmath !2
  store float %tmp_119, float* %invDist4, align 4
  %tmp_120 = load float* %invDist4, align 4
  %tmp_121 = load float* %invDist4, align 4
  %tmp_122 = fmul float %tmp_120, %tmp_121
  %tmp_123 = load float* %invDist4, align 4
  %tmp_124 = fmul float %tmp_122, %tmp_123
  store float %tmp_124, float* %invDistCube5, align 4
  %tmp_125 = load <4 x float>* %p1, align 16
  %tmp_126 = extractelement <4 x float> %tmp_125, i32 3
  %tmp_127 = load float* %invDistCube5, align 4
  %tmp_128 = fmul float %tmp_126, %tmp_127
  store float %tmp_128, float* %s6, align 4
  %tmp_129 = load float* %s6, align 4
  %tmp_130 = insertelement <3 x float> undef, float %tmp_129, i32 0
  %tmp_131 = shufflevector <3 x float> %tmp_130, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_132 = load <4 x float>* %r2, align 16
  %tmp_133 = shufflevector <4 x float> %tmp_132, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_134 = fmul <3 x float> %tmp_131, %tmp_133
  %tmp_135 = load <4 x float>* %acc, align 16
  %tmp_136 = shufflevector <4 x float> %tmp_135, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_137 = fadd <3 x float> %tmp_136, %tmp_134
  %tmp_138 = load <4 x float>* %acc, align 16
  %tmp_139 = shufflevector <3 x float> %tmp_137, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_140 = shufflevector <4 x float> %tmp_138, <4 x float> %tmp_139, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %tmp_140, <4 x float>* %acc, align 16
  br label %tmp_141

tmp_141:                                     ; preds = %tmp_87
  %tmp_142 = load i32* %i, align 4
  %tmp_143 = add nsw i32 %tmp_142, 1
  store i32 %tmp_143, i32* %i, align 4
  br label %tmp_83

tmp_144:                                     ; preds = %tmp_83
  %tmp_145 = load i32* %gid, align 4
  %tmp_146 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_147 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_146, i32 %tmp_145
  %tmp_148 = load <4 x float> addrspace(1)* %tmp_147, align 16
  store <4 x float> %tmp_148, <4 x float>* %oldVel, align 16
  %tmp_149 = load <4 x float>* %myPos, align 16
  %tmp_150 = shufflevector <4 x float> %tmp_149, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_151 = load <4 x float>* %oldVel, align 16
  %tmp_152 = shufflevector <4 x float> %tmp_151, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_153 = load float* %tmp_4, align 4
  %tmp_154 = insertelement <3 x float> undef, float %tmp_153, i32 0
  %tmp_155 = shufflevector <3 x float> %tmp_154, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_156 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %tmp_152, <3 x float> %tmp_155, <3 x float> %tmp_150)
  %tmp_157 = load <4 x float>* %acc, align 16
  %tmp_158 = shufflevector <4 x float> %tmp_157, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_159 = fmul <3 x float> %tmp_158, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %tmp_160 = load float* %tmp_4, align 4
  %tmp_161 = insertelement <3 x float> undef, float %tmp_160, i32 0
  %tmp_162 = shufflevector <3 x float> %tmp_161, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_163 = fmul <3 x float> %tmp_159, %tmp_162
  %tmp_164 = load float* %tmp_4, align 4
  %tmp_165 = insertelement <3 x float> undef, float %tmp_164, i32 0
  %tmp_166 = shufflevector <3 x float> %tmp_165, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_167 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %tmp_163, <3 x float> %tmp_166, <3 x float> %tmp_156)
  %tmp_168 = load <4 x float>* %newPos, align 16
  %tmp_169 = shufflevector <3 x float> %tmp_167, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_170 = shufflevector <4 x float> %tmp_168, <4 x float> %tmp_169, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %tmp_170, <4 x float>* %newPos, align 16
  %tmp_171 = load <4 x float>* %myPos, align 16
  %tmp_172 = extractelement <4 x float> %tmp_171, i32 3
  %tmp_173 = load <4 x float>* %newPos, align 16
  %tmp_174 = insertelement <4 x float> %tmp_173, float %tmp_172, i32 3
  store <4 x float> %tmp_174, <4 x float>* %newPos, align 16
  %tmp_175 = load <4 x float>* %oldVel, align 16
  %tmp_176 = shufflevector <4 x float> %tmp_175, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_177 = load <4 x float>* %acc, align 16
  %tmp_178 = shufflevector <4 x float> %tmp_177, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %tmp_179 = load float* %tmp_4, align 4
  %tmp_180 = insertelement <3 x float> undef, float %tmp_179, i32 0
  %tmp_181 = shufflevector <3 x float> %tmp_180, <3 x float> undef, <3 x i32> zeroinitializer
  %tmp_182 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %tmp_178, <3 x float> %tmp_181, <3 x float> %tmp_176)
  %tmp_183 = load <4 x float>* %newVel, align 16
  %tmp_184 = shufflevector <3 x float> %tmp_182, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %tmp_185 = shufflevector <4 x float> %tmp_183, <4 x float> %tmp_184, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %tmp_185, <4 x float>* %newVel, align 16
  %tmp_186 = load <4 x float>* %oldVel, align 16
  %tmp_187 = extractelement <4 x float> %tmp_186, i32 3
  %tmp_188 = load <4 x float>* %newVel, align 16
  %tmp_189 = insertelement <4 x float> %tmp_188, float %tmp_187, i32 3
  store <4 x float> %tmp_189, <4 x float>* %newVel, align 16
  %tmp_190 = load <4 x float>* %newPos, align 16
  %tmp_191 = load i32* %gid, align 4
  %tmp_192 = load <4 x float> addrspace(1)** %tmp_6, align 4
  %tmp_193 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_192, i32 %tmp_191
  store <4 x float> %tmp_190, <4 x float> addrspace(1)* %tmp_193, align 16
  %tmp_194 = load <4 x float>* %newVel, align 16
  %tmp_195 = load i32* %gid, align 4
  %tmp_196 = load <4 x float> addrspace(1)** %tmp_7, align 4
  %tmp_197 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_196, i32 %tmp_195
  store <4 x float> %tmp_194, <4 x float> addrspace(1)* %tmp_197, align 16
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

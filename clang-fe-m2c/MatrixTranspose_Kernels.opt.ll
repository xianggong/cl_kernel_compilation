; ModuleID = 'MatrixTranspose_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @matrixTranspose(<4 x float> addrspace(1)* %output, <4 x float> addrspace(1)* %input, <4 x float> addrspace(3)* %block) #0 {
  %tmp_8 = call i32 @__get_global_size_u32(i32 0)
  %tmp_9 = call i32 @__get_group_id_u32(i32 0)
  %tmp_10 = call i32 @__get_group_id_u32(i32 1)
  %tmp_11 = call i32 @__get_num_groups_u32(i32 0)
  %tmp_15 = add i32 %tmp_9, %tmp_10
  %tmp_17 = urem i32 %tmp_15, %tmp_11
  %tmp_18 = call i32 @__get_local_id_u32(i32 0)
  %tmp_19 = call i32 @__get_local_id_u32(i32 1)
  %tmp_20 = call i32 @__get_local_size_u32(i32 0)
  %tmp_23 = mul i32 %tmp_17, %tmp_20
  %tmp_25 = add i32 %tmp_23, %tmp_18
  %tmp_28 = mul i32 %tmp_9, %tmp_20
  %tmp_30 = add i32 %tmp_28, %tmp_19
  %tmp_34 = mul i32 %tmp_30, %tmp_8
  %tmp_35 = mul i32 %tmp_34, 4
  %tmp_36 = add i32 %tmp_25, %tmp_35
  %tmp_39 = mul i32 %tmp_19, %tmp_20
  %tmp_40 = mul i32 %tmp_39, 4
  %tmp_42 = add i32 %tmp_40, %tmp_18
  %tmp_45 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_36
  %tmp_46 = load <4 x float> addrspace(1)* %tmp_45, align 16
  %tmp_49 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %tmp_42
  store <4 x float> %tmp_46, <4 x float> addrspace(3)* %tmp_49, align 16
  %tmp_52 = add i32 %tmp_36, %tmp_8
  %tmp_54 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_52
  %tmp_55 = load <4 x float> addrspace(1)* %tmp_54, align 16
  %tmp_58 = add i32 %tmp_42, %tmp_20
  %tmp_60 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %tmp_58
  store <4 x float> %tmp_55, <4 x float> addrspace(3)* %tmp_60, align 16
  %tmp_63 = mul i32 %tmp_8, 2
  %tmp_64 = add i32 %tmp_36, %tmp_63
  %tmp_66 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_64
  %tmp_67 = load <4 x float> addrspace(1)* %tmp_66, align 16
  %tmp_70 = mul i32 %tmp_20, 2
  %tmp_71 = add i32 %tmp_42, %tmp_70
  %tmp_73 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %tmp_71
  store <4 x float> %tmp_67, <4 x float> addrspace(3)* %tmp_73, align 16
  %tmp_76 = mul i32 %tmp_8, 3
  %tmp_77 = add i32 %tmp_36, %tmp_76
  %tmp_79 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_77
  %tmp_80 = load <4 x float> addrspace(1)* %tmp_79, align 16
  %tmp_83 = mul i32 %tmp_20, 3
  %tmp_84 = add i32 %tmp_42, %tmp_83
  %tmp_86 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %tmp_84
  store <4 x float> %tmp_80, <4 x float> addrspace(3)* %tmp_86, align 16
  call void @barrier(i32 1)
  %tmp_89 = mul i32 %tmp_9, %tmp_20
  %tmp_91 = add i32 %tmp_89, %tmp_18
  %tmp_94 = mul i32 %tmp_17, %tmp_20
  %tmp_96 = add i32 %tmp_94, %tmp_19
  %tmp_100 = mul i32 %tmp_96, %tmp_8
  %tmp_101 = mul i32 %tmp_100, 4
  %tmp_102 = add i32 %tmp_91, %tmp_101
  %tmp_105 = mul i32 %tmp_18, %tmp_20
  %tmp_106 = mul i32 %tmp_105, 4
  %tmp_108 = add i32 %tmp_106, %tmp_19
  %tmp_111 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %tmp_108
  %tmp_112 = load <4 x float> addrspace(3)* %tmp_111, align 16
  %tmp_115 = add i32 %tmp_108, %tmp_20
  %tmp_117 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %tmp_115
  %tmp_118 = load <4 x float> addrspace(3)* %tmp_117, align 16
  %tmp_121 = mul i32 %tmp_20, 2
  %tmp_122 = add i32 %tmp_108, %tmp_121
  %tmp_124 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %tmp_122
  %tmp_125 = load <4 x float> addrspace(3)* %tmp_124, align 16
  %tmp_128 = mul i32 %tmp_20, 3
  %tmp_129 = add i32 %tmp_108, %tmp_128
  %tmp_131 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %tmp_129
  %tmp_132 = load <4 x float> addrspace(3)* %tmp_131, align 16
  %tmp_134 = extractelement <4 x float> %tmp_112, i32 0
  %tmp_135 = insertelement <4 x float> undef, float %tmp_134, i32 0
  %tmp_137 = extractelement <4 x float> %tmp_118, i32 0
  %tmp_138 = insertelement <4 x float> %tmp_135, float %tmp_137, i32 1
  %tmp_140 = extractelement <4 x float> %tmp_125, i32 0
  %tmp_141 = insertelement <4 x float> %tmp_138, float %tmp_140, i32 2
  %tmp_143 = extractelement <4 x float> %tmp_132, i32 0
  %tmp_144 = insertelement <4 x float> %tmp_141, float %tmp_143, i32 3
  %tmp_148 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_102
  store <4 x float> %tmp_144, <4 x float> addrspace(1)* %tmp_148, align 16
  %tmp_150 = extractelement <4 x float> %tmp_112, i32 1
  %tmp_151 = insertelement <4 x float> undef, float %tmp_150, i32 0
  %tmp_153 = extractelement <4 x float> %tmp_118, i32 1
  %tmp_154 = insertelement <4 x float> %tmp_151, float %tmp_153, i32 1
  %tmp_156 = extractelement <4 x float> %tmp_125, i32 1
  %tmp_157 = insertelement <4 x float> %tmp_154, float %tmp_156, i32 2
  %tmp_159 = extractelement <4 x float> %tmp_132, i32 1
  %tmp_160 = insertelement <4 x float> %tmp_157, float %tmp_159, i32 3
  %tmp_164 = add i32 %tmp_102, %tmp_8
  %tmp_166 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_164
  store <4 x float> %tmp_160, <4 x float> addrspace(1)* %tmp_166, align 16
  %tmp_168 = extractelement <4 x float> %tmp_112, i32 2
  %tmp_169 = insertelement <4 x float> undef, float %tmp_168, i32 0
  %tmp_171 = extractelement <4 x float> %tmp_118, i32 2
  %tmp_172 = insertelement <4 x float> %tmp_169, float %tmp_171, i32 1
  %tmp_174 = extractelement <4 x float> %tmp_125, i32 2
  %tmp_175 = insertelement <4 x float> %tmp_172, float %tmp_174, i32 2
  %tmp_177 = extractelement <4 x float> %tmp_132, i32 2
  %tmp_178 = insertelement <4 x float> %tmp_175, float %tmp_177, i32 3
  %tmp_182 = mul i32 %tmp_8, 2
  %tmp_183 = add i32 %tmp_102, %tmp_182
  %tmp_185 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_183
  store <4 x float> %tmp_178, <4 x float> addrspace(1)* %tmp_185, align 16
  %tmp_187 = extractelement <4 x float> %tmp_112, i32 3
  %tmp_188 = insertelement <4 x float> undef, float %tmp_187, i32 0
  %tmp_190 = extractelement <4 x float> %tmp_118, i32 3
  %tmp_191 = insertelement <4 x float> %tmp_188, float %tmp_190, i32 1
  %tmp_193 = extractelement <4 x float> %tmp_125, i32 3
  %tmp_194 = insertelement <4 x float> %tmp_191, float %tmp_193, i32 2
  %tmp_196 = extractelement <4 x float> %tmp_132, i32 3
  %tmp_197 = insertelement <4 x float> %tmp_194, float %tmp_196, i32 3
  %tmp_201 = mul i32 %tmp_8, 3
  %tmp_202 = add i32 %tmp_102, %tmp_201
  %tmp_204 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_202
  store <4 x float> %tmp_197, <4 x float> addrspace(1)* %tmp_204, align 16
  ret void
}

declare i32 @__get_global_size_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_num_groups_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*)* @matrixTranspose}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

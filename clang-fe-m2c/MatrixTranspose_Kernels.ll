; ModuleID = '../kernel-src/MatrixTranspose_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @matrixTranspose(<4 x float> addrspace(1)* %output, <4 x float> addrspace(1)* %input, <4 x float> addrspace(3)* %block) #0 {
  %tmp_1 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_3 = alloca <4 x float> addrspace(3)*, align 4
  %wiWidth = alloca i32, align 4
  %gix_t = alloca i32, align 4
  %giy_t = alloca i32, align 4
  %num_of_blocks_x = alloca i32, align 4
  %giy = alloca i32, align 4
  %gix = alloca i32, align 4
  %lix = alloca i32, align 4
  %liy = alloca i32, align 4
  %blockSize = alloca i32, align 4
  %ix = alloca i32, align 4
  %iy = alloca i32, align 4
  %index_in = alloca i32, align 4
  %ind = alloca i32, align 4
  %index_out = alloca i32, align 4
  %v0 = alloca <4 x float>, align 16
  %v1 = alloca <4 x float>, align 16
  %v2 = alloca <4 x float>, align 16
  %v3 = alloca <4 x float>, align 16
  %tmp_4 = alloca <4 x float>, align 16
  %tmp_5 = alloca <4 x float>, align 16
  %tmp_6 = alloca <4 x float>, align 16
  %tmp_7 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %tmp_1, align 4
  store <4 x float> addrspace(1)* %input, <4 x float> addrspace(1)** %tmp_2, align 4
  store <4 x float> addrspace(3)* %block, <4 x float> addrspace(3)** %tmp_3, align 4
  %tmp_8 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_8, i32* %wiWidth, align 4
  %tmp_9 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_9, i32* %gix_t, align 4
  %tmp_10 = call i32 @__get_group_id_u32(i32 1)
  store i32 %tmp_10, i32* %giy_t, align 4
  %tmp_11 = call i32 @__get_num_groups_u32(i32 0)
  store i32 %tmp_11, i32* %num_of_blocks_x, align 4
  %tmp_12 = load i32* %gix_t, align 4
  store i32 %tmp_12, i32* %giy, align 4
  %tmp_13 = load i32* %gix_t, align 4
  %tmp_14 = load i32* %giy_t, align 4
  %tmp_15 = add i32 %tmp_13, %tmp_14
  %tmp_16 = load i32* %num_of_blocks_x, align 4
  %tmp_17 = urem i32 %tmp_15, %tmp_16
  store i32 %tmp_17, i32* %gix, align 4
  %tmp_18 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_18, i32* %lix, align 4
  %tmp_19 = call i32 @__get_local_id_u32(i32 1)
  store i32 %tmp_19, i32* %liy, align 4
  %tmp_20 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_20, i32* %blockSize, align 4
  %tmp_21 = load i32* %gix, align 4
  %tmp_22 = load i32* %blockSize, align 4
  %tmp_23 = mul i32 %tmp_21, %tmp_22
  %tmp_24 = load i32* %lix, align 4
  %tmp_25 = add i32 %tmp_23, %tmp_24
  store i32 %tmp_25, i32* %ix, align 4
  %tmp_26 = load i32* %giy, align 4
  %tmp_27 = load i32* %blockSize, align 4
  %tmp_28 = mul i32 %tmp_26, %tmp_27
  %tmp_29 = load i32* %liy, align 4
  %tmp_30 = add i32 %tmp_28, %tmp_29
  store i32 %tmp_30, i32* %iy, align 4
  %tmp_31 = load i32* %ix, align 4
  %tmp_32 = load i32* %iy, align 4
  %tmp_33 = load i32* %wiWidth, align 4
  %tmp_34 = mul i32 %tmp_32, %tmp_33
  %tmp_35 = mul i32 %tmp_34, 4
  %tmp_36 = add i32 %tmp_31, %tmp_35
  store i32 %tmp_36, i32* %index_in, align 4
  %tmp_37 = load i32* %liy, align 4
  %tmp_38 = load i32* %blockSize, align 4
  %tmp_39 = mul i32 %tmp_37, %tmp_38
  %tmp_40 = mul i32 %tmp_39, 4
  %tmp_41 = load i32* %lix, align 4
  %tmp_42 = add i32 %tmp_40, %tmp_41
  store i32 %tmp_42, i32* %ind, align 4
  %tmp_43 = load i32* %index_in, align 4
  %tmp_44 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_45 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_44, i32 %tmp_43
  %tmp_46 = load <4 x float> addrspace(1)* %tmp_45, align 16
  %tmp_47 = load i32* %ind, align 4
  %tmp_48 = load <4 x float> addrspace(3)** %tmp_3, align 4
  %tmp_49 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_48, i32 %tmp_47
  store <4 x float> %tmp_46, <4 x float> addrspace(3)* %tmp_49, align 16
  %tmp_50 = load i32* %index_in, align 4
  %tmp_51 = load i32* %wiWidth, align 4
  %tmp_52 = add i32 %tmp_50, %tmp_51
  %tmp_53 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_54 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_53, i32 %tmp_52
  %tmp_55 = load <4 x float> addrspace(1)* %tmp_54, align 16
  %tmp_56 = load i32* %ind, align 4
  %tmp_57 = load i32* %blockSize, align 4
  %tmp_58 = add i32 %tmp_56, %tmp_57
  %tmp_59 = load <4 x float> addrspace(3)** %tmp_3, align 4
  %tmp_60 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_59, i32 %tmp_58
  store <4 x float> %tmp_55, <4 x float> addrspace(3)* %tmp_60, align 16
  %tmp_61 = load i32* %index_in, align 4
  %tmp_62 = load i32* %wiWidth, align 4
  %tmp_63 = mul i32 %tmp_62, 2
  %tmp_64 = add i32 %tmp_61, %tmp_63
  %tmp_65 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_66 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_65, i32 %tmp_64
  %tmp_67 = load <4 x float> addrspace(1)* %tmp_66, align 16
  %tmp_68 = load i32* %ind, align 4
  %tmp_69 = load i32* %blockSize, align 4
  %tmp_70 = mul i32 %tmp_69, 2
  %tmp_71 = add i32 %tmp_68, %tmp_70
  %tmp_72 = load <4 x float> addrspace(3)** %tmp_3, align 4
  %tmp_73 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_72, i32 %tmp_71
  store <4 x float> %tmp_67, <4 x float> addrspace(3)* %tmp_73, align 16
  %tmp_74 = load i32* %index_in, align 4
  %tmp_75 = load i32* %wiWidth, align 4
  %tmp_76 = mul i32 %tmp_75, 3
  %tmp_77 = add i32 %tmp_74, %tmp_76
  %tmp_78 = load <4 x float> addrspace(1)** %tmp_2, align 4
  %tmp_79 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_78, i32 %tmp_77
  %tmp_80 = load <4 x float> addrspace(1)* %tmp_79, align 16
  %tmp_81 = load i32* %ind, align 4
  %tmp_82 = load i32* %blockSize, align 4
  %tmp_83 = mul i32 %tmp_82, 3
  %tmp_84 = add i32 %tmp_81, %tmp_83
  %tmp_85 = load <4 x float> addrspace(3)** %tmp_3, align 4
  %tmp_86 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_85, i32 %tmp_84
  store <4 x float> %tmp_80, <4 x float> addrspace(3)* %tmp_86, align 16
  call void @barrier(i32 1)
  %tmp_87 = load i32* %giy, align 4
  %tmp_88 = load i32* %blockSize, align 4
  %tmp_89 = mul i32 %tmp_87, %tmp_88
  %tmp_90 = load i32* %lix, align 4
  %tmp_91 = add i32 %tmp_89, %tmp_90
  store i32 %tmp_91, i32* %ix, align 4
  %tmp_92 = load i32* %gix, align 4
  %tmp_93 = load i32* %blockSize, align 4
  %tmp_94 = mul i32 %tmp_92, %tmp_93
  %tmp_95 = load i32* %liy, align 4
  %tmp_96 = add i32 %tmp_94, %tmp_95
  store i32 %tmp_96, i32* %iy, align 4
  %tmp_97 = load i32* %ix, align 4
  %tmp_98 = load i32* %iy, align 4
  %tmp_99 = load i32* %wiWidth, align 4
  %tmp_100 = mul i32 %tmp_98, %tmp_99
  %tmp_101 = mul i32 %tmp_100, 4
  %tmp_102 = add i32 %tmp_97, %tmp_101
  store i32 %tmp_102, i32* %index_out, align 4
  %tmp_103 = load i32* %lix, align 4
  %tmp_104 = load i32* %blockSize, align 4
  %tmp_105 = mul i32 %tmp_103, %tmp_104
  %tmp_106 = mul i32 %tmp_105, 4
  %tmp_107 = load i32* %liy, align 4
  %tmp_108 = add i32 %tmp_106, %tmp_107
  store i32 %tmp_108, i32* %ind, align 4
  %tmp_109 = load i32* %ind, align 4
  %tmp_110 = load <4 x float> addrspace(3)** %tmp_3, align 4
  %tmp_111 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_110, i32 %tmp_109
  %tmp_112 = load <4 x float> addrspace(3)* %tmp_111, align 16
  store <4 x float> %tmp_112, <4 x float>* %v0, align 16
  %tmp_113 = load i32* %ind, align 4
  %tmp_114 = load i32* %blockSize, align 4
  %tmp_115 = add i32 %tmp_113, %tmp_114
  %tmp_116 = load <4 x float> addrspace(3)** %tmp_3, align 4
  %tmp_117 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_116, i32 %tmp_115
  %tmp_118 = load <4 x float> addrspace(3)* %tmp_117, align 16
  store <4 x float> %tmp_118, <4 x float>* %v1, align 16
  %tmp_119 = load i32* %ind, align 4
  %tmp_120 = load i32* %blockSize, align 4
  %tmp_121 = mul i32 %tmp_120, 2
  %tmp_122 = add i32 %tmp_119, %tmp_121
  %tmp_123 = load <4 x float> addrspace(3)** %tmp_3, align 4
  %tmp_124 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_123, i32 %tmp_122
  %tmp_125 = load <4 x float> addrspace(3)* %tmp_124, align 16
  store <4 x float> %tmp_125, <4 x float>* %v2, align 16
  %tmp_126 = load i32* %ind, align 4
  %tmp_127 = load i32* %blockSize, align 4
  %tmp_128 = mul i32 %tmp_127, 3
  %tmp_129 = add i32 %tmp_126, %tmp_128
  %tmp_130 = load <4 x float> addrspace(3)** %tmp_3, align 4
  %tmp_131 = getelementptr inbounds <4 x float> addrspace(3)* %tmp_130, i32 %tmp_129
  %tmp_132 = load <4 x float> addrspace(3)* %tmp_131, align 16
  store <4 x float> %tmp_132, <4 x float>* %v3, align 16
  %tmp_133 = load <4 x float>* %v0, align 16
  %tmp_134 = extractelement <4 x float> %tmp_133, i32 0
  %tmp_135 = insertelement <4 x float> undef, float %tmp_134, i32 0
  %tmp_136 = load <4 x float>* %v1, align 16
  %tmp_137 = extractelement <4 x float> %tmp_136, i32 0
  %tmp_138 = insertelement <4 x float> %tmp_135, float %tmp_137, i32 1
  %tmp_139 = load <4 x float>* %v2, align 16
  %tmp_140 = extractelement <4 x float> %tmp_139, i32 0
  %tmp_141 = insertelement <4 x float> %tmp_138, float %tmp_140, i32 2
  %tmp_142 = load <4 x float>* %v3, align 16
  %tmp_143 = extractelement <4 x float> %tmp_142, i32 0
  %tmp_144 = insertelement <4 x float> %tmp_141, float %tmp_143, i32 3
  store <4 x float> %tmp_144, <4 x float>* %tmp_4
  %tmp_145 = load <4 x float>* %tmp_4
  %tmp_146 = load i32* %index_out, align 4
  %tmp_147 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_148 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_147, i32 %tmp_146
  store <4 x float> %tmp_145, <4 x float> addrspace(1)* %tmp_148, align 16
  %tmp_149 = load <4 x float>* %v0, align 16
  %tmp_150 = extractelement <4 x float> %tmp_149, i32 1
  %tmp_151 = insertelement <4 x float> undef, float %tmp_150, i32 0
  %tmp_152 = load <4 x float>* %v1, align 16
  %tmp_153 = extractelement <4 x float> %tmp_152, i32 1
  %tmp_154 = insertelement <4 x float> %tmp_151, float %tmp_153, i32 1
  %tmp_155 = load <4 x float>* %v2, align 16
  %tmp_156 = extractelement <4 x float> %tmp_155, i32 1
  %tmp_157 = insertelement <4 x float> %tmp_154, float %tmp_156, i32 2
  %tmp_158 = load <4 x float>* %v3, align 16
  %tmp_159 = extractelement <4 x float> %tmp_158, i32 1
  %tmp_160 = insertelement <4 x float> %tmp_157, float %tmp_159, i32 3
  store <4 x float> %tmp_160, <4 x float>* %tmp_5
  %tmp_161 = load <4 x float>* %tmp_5
  %tmp_162 = load i32* %index_out, align 4
  %tmp_163 = load i32* %wiWidth, align 4
  %tmp_164 = add i32 %tmp_162, %tmp_163
  %tmp_165 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_166 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_165, i32 %tmp_164
  store <4 x float> %tmp_161, <4 x float> addrspace(1)* %tmp_166, align 16
  %tmp_167 = load <4 x float>* %v0, align 16
  %tmp_168 = extractelement <4 x float> %tmp_167, i32 2
  %tmp_169 = insertelement <4 x float> undef, float %tmp_168, i32 0
  %tmp_170 = load <4 x float>* %v1, align 16
  %tmp_171 = extractelement <4 x float> %tmp_170, i32 2
  %tmp_172 = insertelement <4 x float> %tmp_169, float %tmp_171, i32 1
  %tmp_173 = load <4 x float>* %v2, align 16
  %tmp_174 = extractelement <4 x float> %tmp_173, i32 2
  %tmp_175 = insertelement <4 x float> %tmp_172, float %tmp_174, i32 2
  %tmp_176 = load <4 x float>* %v3, align 16
  %tmp_177 = extractelement <4 x float> %tmp_176, i32 2
  %tmp_178 = insertelement <4 x float> %tmp_175, float %tmp_177, i32 3
  store <4 x float> %tmp_178, <4 x float>* %tmp_6
  %tmp_179 = load <4 x float>* %tmp_6
  %tmp_180 = load i32* %index_out, align 4
  %tmp_181 = load i32* %wiWidth, align 4
  %tmp_182 = mul i32 %tmp_181, 2
  %tmp_183 = add i32 %tmp_180, %tmp_182
  %tmp_184 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_185 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_184, i32 %tmp_183
  store <4 x float> %tmp_179, <4 x float> addrspace(1)* %tmp_185, align 16
  %tmp_186 = load <4 x float>* %v0, align 16
  %tmp_187 = extractelement <4 x float> %tmp_186, i32 3
  %tmp_188 = insertelement <4 x float> undef, float %tmp_187, i32 0
  %tmp_189 = load <4 x float>* %v1, align 16
  %tmp_190 = extractelement <4 x float> %tmp_189, i32 3
  %tmp_191 = insertelement <4 x float> %tmp_188, float %tmp_190, i32 1
  %tmp_192 = load <4 x float>* %v2, align 16
  %tmp_193 = extractelement <4 x float> %tmp_192, i32 3
  %tmp_194 = insertelement <4 x float> %tmp_191, float %tmp_193, i32 2
  %tmp_195 = load <4 x float>* %v3, align 16
  %tmp_196 = extractelement <4 x float> %tmp_195, i32 3
  %tmp_197 = insertelement <4 x float> %tmp_194, float %tmp_196, i32 3
  store <4 x float> %tmp_197, <4 x float>* %tmp_7
  %tmp_198 = load <4 x float>* %tmp_7
  %tmp_199 = load i32* %index_out, align 4
  %tmp_200 = load i32* %wiWidth, align 4
  %tmp_201 = mul i32 %tmp_200, 3
  %tmp_202 = add i32 %tmp_199, %tmp_201
  %tmp_203 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_204 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_203, i32 %tmp_202
  store <4 x float> %tmp_198, <4 x float> addrspace(1)* %tmp_204, align 16
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

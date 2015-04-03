; ModuleID = '../kernel-src/BoxFilterGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @box_filter(<4 x i32> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %N) #0 {
  %tmp_1 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %k = alloca i32, align 4
  %filterSize = alloca <4 x i32>, align 16
  %posA = alloca <2 x i32>, align 8
  %tmp_4 = alloca <2 x i32>, align 8
  %posB = alloca <2 x i32>, align 8
  %tmp_5 = alloca <2 x i32>, align 8
  %posC = alloca <2 x i32>, align 8
  %tmp_6 = alloca <2 x i32>, align 8
  %posD = alloca <2 x i32>, align 8
  %tmp_7 = alloca <2 x i32>, align 8
  %sumA = alloca <4 x i32>, align 16
  %sumB = alloca <4 x i32>, align 16
  %sumC = alloca <4 x i32>, align 16
  %sumD = alloca <4 x i32>, align 16
  store <4 x i32> addrspace(1)* %inputImage, <4 x i32> addrspace(1)** %tmp_1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %tmp_2, align 4
  store i32 %N, i32* %tmp_3, align 4
  %tmp_8 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_8, i32* %x, align 4
  %tmp_9 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_9, i32* %y, align 4
  %tmp_10 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_10, i32* %width, align 4
  %tmp_11 = call i32 @__get_global_size_u32(i32 1)
  store i32 %tmp_11, i32* %height, align 4
  %tmp_12 = load i32* %tmp_3, align 4
  %tmp_13 = sub nsw i32 %tmp_12, 1
  %tmp_14 = sdiv i32 %tmp_13, 2
  store i32 %tmp_14, i32* %k, align 4
  %tmp_15 = load i32* %x, align 4
  %tmp_16 = load i32* %k, align 4
  %tmp_17 = icmp slt i32 %tmp_15, %tmp_16
  br i1 %tmp_17, label %tmp_36, label %tmp_18

tmp_18:                                      ; preds = %tmp_0
  %tmp_19 = load i32* %y, align 4
  %tmp_20 = load i32* %k, align 4
  %tmp_21 = icmp slt i32 %tmp_19, %tmp_20
  br i1 %tmp_21, label %tmp_36, label %tmp_22

tmp_22:                                      ; preds = %tmp_18
  %tmp_23 = load i32* %x, align 4
  %tmp_24 = load i32* %width, align 4
  %tmp_25 = load i32* %k, align 4
  %tmp_26 = sub nsw i32 %tmp_24, %tmp_25
  %tmp_27 = sub nsw i32 %tmp_26, 1
  %tmp_28 = icmp sgt i32 %tmp_23, %tmp_27
  br i1 %tmp_28, label %tmp_36, label %tmp_29

tmp_29:                                      ; preds = %tmp_22
  %tmp_30 = load i32* %y, align 4
  %tmp_31 = load i32* %height, align 4
  %tmp_32 = load i32* %k, align 4
  %tmp_33 = sub nsw i32 %tmp_31, %tmp_32
  %tmp_34 = sub nsw i32 %tmp_33, 1
  %tmp_35 = icmp sgt i32 %tmp_30, %tmp_34
  br i1 %tmp_35, label %tmp_36, label %tmp_44

tmp_36:                                      ; preds = %tmp_29, %tmp_22, %tmp_18, %tmp_0
  %tmp_37 = load i32* %x, align 4
  %tmp_38 = load i32* %y, align 4
  %tmp_39 = load i32* %width, align 4
  %tmp_40 = mul nsw i32 %tmp_38, %tmp_39
  %tmp_41 = add nsw i32 %tmp_37, %tmp_40
  %tmp_42 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_43 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_42, i32 %tmp_41
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %tmp_43, align 4
  br label %tmp_194

tmp_44:                                      ; preds = %tmp_29
  %tmp_45 = load i32* %tmp_3, align 4
  %tmp_46 = load i32* %tmp_3, align 4
  %tmp_47 = mul nsw i32 %tmp_45, %tmp_46
  %tmp_48 = insertelement <4 x i32> undef, i32 %tmp_47, i32 0
  %tmp_49 = shufflevector <4 x i32> %tmp_48, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %tmp_49, <4 x i32>* %filterSize, align 16
  %tmp_50 = load i32* %x, align 4
  %tmp_51 = load i32* %k, align 4
  %tmp_52 = sub nsw i32 %tmp_50, %tmp_51
  %tmp_53 = insertelement <2 x i32> undef, i32 %tmp_52, i32 0
  %tmp_54 = load i32* %y, align 4
  %tmp_55 = load i32* %k, align 4
  %tmp_56 = sub nsw i32 %tmp_54, %tmp_55
  %tmp_57 = insertelement <2 x i32> %tmp_53, i32 %tmp_56, i32 1
  store <2 x i32> %tmp_57, <2 x i32>* %tmp_4
  %tmp_58 = load <2 x i32>* %tmp_4
  store <2 x i32> %tmp_58, <2 x i32>* %posA, align 8
  %tmp_59 = load i32* %x, align 4
  %tmp_60 = load i32* %k, align 4
  %tmp_61 = add nsw i32 %tmp_59, %tmp_60
  %tmp_62 = insertelement <2 x i32> undef, i32 %tmp_61, i32 0
  %tmp_63 = load i32* %y, align 4
  %tmp_64 = load i32* %k, align 4
  %tmp_65 = sub nsw i32 %tmp_63, %tmp_64
  %tmp_66 = insertelement <2 x i32> %tmp_62, i32 %tmp_65, i32 1
  store <2 x i32> %tmp_66, <2 x i32>* %tmp_5
  %tmp_67 = load <2 x i32>* %tmp_5
  store <2 x i32> %tmp_67, <2 x i32>* %posB, align 8
  %tmp_68 = load i32* %x, align 4
  %tmp_69 = load i32* %k, align 4
  %tmp_70 = add nsw i32 %tmp_68, %tmp_69
  %tmp_71 = insertelement <2 x i32> undef, i32 %tmp_70, i32 0
  %tmp_72 = load i32* %y, align 4
  %tmp_73 = load i32* %k, align 4
  %tmp_74 = add nsw i32 %tmp_72, %tmp_73
  %tmp_75 = insertelement <2 x i32> %tmp_71, i32 %tmp_74, i32 1
  store <2 x i32> %tmp_75, <2 x i32>* %tmp_6
  %tmp_76 = load <2 x i32>* %tmp_6
  store <2 x i32> %tmp_76, <2 x i32>* %posC, align 8
  %tmp_77 = load i32* %x, align 4
  %tmp_78 = load i32* %k, align 4
  %tmp_79 = sub nsw i32 %tmp_77, %tmp_78
  %tmp_80 = insertelement <2 x i32> undef, i32 %tmp_79, i32 0
  %tmp_81 = load i32* %y, align 4
  %tmp_82 = load i32* %k, align 4
  %tmp_83 = add nsw i32 %tmp_81, %tmp_82
  %tmp_84 = insertelement <2 x i32> %tmp_80, i32 %tmp_83, i32 1
  store <2 x i32> %tmp_84, <2 x i32>* %tmp_7
  %tmp_85 = load <2 x i32>* %tmp_7
  store <2 x i32> %tmp_85, <2 x i32>* %posD, align 8
  store <4 x i32> zeroinitializer, <4 x i32>* %sumA, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sumB, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sumC, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sumD, align 16
  %tmp_86 = load <2 x i32>* %posA, align 8
  %tmp_87 = extractelement <2 x i32> %tmp_86, i32 0
  %tmp_88 = sub nsw i32 %tmp_87, 1
  %tmp_89 = load <2 x i32>* %posA, align 8
  %tmp_90 = insertelement <2 x i32> %tmp_89, i32 %tmp_88, i32 0
  store <2 x i32> %tmp_90, <2 x i32>* %posA, align 8
  %tmp_91 = load <2 x i32>* %posA, align 8
  %tmp_92 = extractelement <2 x i32> %tmp_91, i32 1
  %tmp_93 = sub nsw i32 %tmp_92, 1
  %tmp_94 = load <2 x i32>* %posA, align 8
  %tmp_95 = insertelement <2 x i32> %tmp_94, i32 %tmp_93, i32 1
  store <2 x i32> %tmp_95, <2 x i32>* %posA, align 8
  %tmp_96 = load <2 x i32>* %posB, align 8
  %tmp_97 = extractelement <2 x i32> %tmp_96, i32 1
  %tmp_98 = sub nsw i32 %tmp_97, 1
  %tmp_99 = load <2 x i32>* %posB, align 8
  %tmp_100 = insertelement <2 x i32> %tmp_99, i32 %tmp_98, i32 1
  store <2 x i32> %tmp_100, <2 x i32>* %posB, align 8
  %tmp_101 = load <2 x i32>* %posD, align 8
  %tmp_102 = extractelement <2 x i32> %tmp_101, i32 0
  %tmp_103 = sub nsw i32 %tmp_102, 1
  %tmp_104 = load <2 x i32>* %posD, align 8
  %tmp_105 = insertelement <2 x i32> %tmp_104, i32 %tmp_103, i32 0
  store <2 x i32> %tmp_105, <2 x i32>* %posD, align 8
  %tmp_106 = load <2 x i32>* %posA, align 8
  %tmp_107 = extractelement <2 x i32> %tmp_106, i32 0
  %tmp_108 = icmp sge i32 %tmp_107, 0
  br i1 %tmp_108, label %tmp_109, label %tmp_125

tmp_109:                                     ; preds = %tmp_44
  %tmp_110 = load <2 x i32>* %posA, align 8
  %tmp_111 = extractelement <2 x i32> %tmp_110, i32 1
  %tmp_112 = icmp sge i32 %tmp_111, 0
  br i1 %tmp_112, label %tmp_113, label %tmp_125

tmp_113:                                     ; preds = %tmp_109
  %tmp_114 = load <2 x i32>* %posA, align 8
  %tmp_115 = extractelement <2 x i32> %tmp_114, i32 0
  %tmp_116 = load <2 x i32>* %posA, align 8
  %tmp_117 = extractelement <2 x i32> %tmp_116, i32 1
  %tmp_118 = load i32* %width, align 4
  %tmp_119 = mul nsw i32 %tmp_117, %tmp_118
  %tmp_120 = add nsw i32 %tmp_115, %tmp_119
  %tmp_121 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_122 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_121, i32 %tmp_120
  %tmp_123 = load <4 x i32> addrspace(1)* %tmp_122, align 16
  %tmp_124 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %tmp_123)
  store <4 x i32> %tmp_124, <4 x i32>* %sumA, align 16
  br label %tmp_125

tmp_125:                                     ; preds = %tmp_113, %tmp_109, %tmp_44
  %tmp_126 = load <2 x i32>* %posB, align 8
  %tmp_127 = extractelement <2 x i32> %tmp_126, i32 0
  %tmp_128 = icmp sge i32 %tmp_127, 0
  br i1 %tmp_128, label %tmp_129, label %tmp_145

tmp_129:                                     ; preds = %tmp_125
  %tmp_130 = load <2 x i32>* %posB, align 8
  %tmp_131 = extractelement <2 x i32> %tmp_130, i32 1
  %tmp_132 = icmp sge i32 %tmp_131, 0
  br i1 %tmp_132, label %tmp_133, label %tmp_145

tmp_133:                                     ; preds = %tmp_129
  %tmp_134 = load <2 x i32>* %posB, align 8
  %tmp_135 = extractelement <2 x i32> %tmp_134, i32 0
  %tmp_136 = load <2 x i32>* %posB, align 8
  %tmp_137 = extractelement <2 x i32> %tmp_136, i32 1
  %tmp_138 = load i32* %width, align 4
  %tmp_139 = mul nsw i32 %tmp_137, %tmp_138
  %tmp_140 = add nsw i32 %tmp_135, %tmp_139
  %tmp_141 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_142 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_141, i32 %tmp_140
  %tmp_143 = load <4 x i32> addrspace(1)* %tmp_142, align 16
  %tmp_144 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %tmp_143)
  store <4 x i32> %tmp_144, <4 x i32>* %sumB, align 16
  br label %tmp_145

tmp_145:                                     ; preds = %tmp_133, %tmp_129, %tmp_125
  %tmp_146 = load <2 x i32>* %posD, align 8
  %tmp_147 = extractelement <2 x i32> %tmp_146, i32 0
  %tmp_148 = icmp sge i32 %tmp_147, 0
  br i1 %tmp_148, label %tmp_149, label %tmp_165

tmp_149:                                     ; preds = %tmp_145
  %tmp_150 = load <2 x i32>* %posD, align 8
  %tmp_151 = extractelement <2 x i32> %tmp_150, i32 1
  %tmp_152 = icmp sge i32 %tmp_151, 0
  br i1 %tmp_152, label %tmp_153, label %tmp_165

tmp_153:                                     ; preds = %tmp_149
  %tmp_154 = load <2 x i32>* %posD, align 8
  %tmp_155 = extractelement <2 x i32> %tmp_154, i32 0
  %tmp_156 = load <2 x i32>* %posD, align 8
  %tmp_157 = extractelement <2 x i32> %tmp_156, i32 1
  %tmp_158 = load i32* %width, align 4
  %tmp_159 = mul nsw i32 %tmp_157, %tmp_158
  %tmp_160 = add nsw i32 %tmp_155, %tmp_159
  %tmp_161 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_162 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_161, i32 %tmp_160
  %tmp_163 = load <4 x i32> addrspace(1)* %tmp_162, align 16
  %tmp_164 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %tmp_163)
  store <4 x i32> %tmp_164, <4 x i32>* %sumD, align 16
  br label %tmp_165

tmp_165:                                     ; preds = %tmp_153, %tmp_149, %tmp_145
  %tmp_166 = load <2 x i32>* %posC, align 8
  %tmp_167 = extractelement <2 x i32> %tmp_166, i32 0
  %tmp_168 = load <2 x i32>* %posC, align 8
  %tmp_169 = extractelement <2 x i32> %tmp_168, i32 1
  %tmp_170 = load i32* %width, align 4
  %tmp_171 = mul nsw i32 %tmp_169, %tmp_170
  %tmp_172 = add nsw i32 %tmp_167, %tmp_171
  %tmp_173 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_174 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_173, i32 %tmp_172
  %tmp_175 = load <4 x i32> addrspace(1)* %tmp_174, align 16
  %tmp_176 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %tmp_175)
  store <4 x i32> %tmp_176, <4 x i32>* %sumC, align 16
  %tmp_177 = load <4 x i32>* %sumA, align 16
  %tmp_178 = load <4 x i32>* %sumC, align 16
  %tmp_179 = add <4 x i32> %tmp_177, %tmp_178
  %tmp_180 = load <4 x i32>* %sumB, align 16
  %tmp_181 = sub <4 x i32> %tmp_179, %tmp_180
  %tmp_182 = load <4 x i32>* %sumD, align 16
  %tmp_183 = sub <4 x i32> %tmp_181, %tmp_182
  %tmp_184 = load <4 x i32>* %filterSize, align 16
  %tmp_185 = sdiv <4 x i32> %tmp_183, %tmp_184
  %tmp_186 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %tmp_185)
  %tmp_187 = load i32* %x, align 4
  %tmp_188 = load i32* %y, align 4
  %tmp_189 = load i32* %width, align 4
  %tmp_190 = mul nsw i32 %tmp_188, %tmp_189
  %tmp_191 = add nsw i32 %tmp_187, %tmp_190
  %tmp_192 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_193 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_192, i32 %tmp_191
  store <4 x i8> %tmp_186, <4 x i8> addrspace(1)* %tmp_193, align 4
  br label %tmp_194

tmp_194:                                     ; preds = %tmp_165, %tmp_36
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32>) #1

declare <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind
define void @horizontalSAT0(<4 x i8> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %pos = alloca i32, align 4
  %c = alloca i32, align 4
  %sum = alloca <4 x i32>, align 16
  %j = alloca i32, align 4
  store <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)** %tmp_1, align 4
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %tmp_2, align 4
  store i32 %i, i32* %tmp_3, align 4
  store i32 %r, i32* %tmp_4, align 4
  store i32 %width, i32* %tmp_5, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_6, i32* %x, align 4
  %tmp_7 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_7, i32* %y, align 4
  %tmp_8 = load i32* %x, align 4
  %tmp_9 = load i32* %y, align 4
  %tmp_10 = load i32* %tmp_5, align 4
  %tmp_11 = mul nsw i32 %tmp_9, %tmp_10
  %tmp_12 = add nsw i32 %tmp_8, %tmp_11
  store i32 %tmp_12, i32* %pos, align 4
  %tmp_13 = load i32* %tmp_4, align 4
  %tmp_14 = sitofp i32 %tmp_13 to float
  %tmp_15 = load i32* %tmp_3, align 4
  %tmp_16 = sitofp i32 %tmp_15 to float
  %tmp_17 = call float @llvm.pow.f32(float %tmp_14, float %tmp_16)
  %tmp_18 = fptosi float %tmp_17 to i32
  store i32 %tmp_18, i32* %c, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  store i32 0, i32* %j, align 4
  br label %tmp_19

tmp_19:                                      ; preds = %tmp_47, %tmp_0
  %tmp_20 = load i32* %j, align 4
  %tmp_21 = load i32* %tmp_4, align 4
  %tmp_22 = icmp slt i32 %tmp_20, %tmp_21
  br i1 %tmp_22, label %tmp_23, label %tmp_50

tmp_23:                                      ; preds = %tmp_19
  %tmp_24 = load i32* %x, align 4
  %tmp_25 = load i32* %j, align 4
  %tmp_26 = load i32* %c, align 4
  %tmp_27 = mul nsw i32 %tmp_25, %tmp_26
  %tmp_28 = sub nsw i32 %tmp_24, %tmp_27
  %tmp_29 = icmp slt i32 %tmp_28, 0
  br i1 %tmp_29, label %tmp_30, label %tmp_35

tmp_30:                                      ; preds = %tmp_23
  %tmp_31 = load <4 x i32>* %sum, align 16
  %tmp_32 = load i32* %pos, align 4
  %tmp_33 = load <4 x i32> addrspace(1)** %tmp_2, align 4
  %tmp_34 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_33, i32 %tmp_32
  store <4 x i32> %tmp_31, <4 x i32> addrspace(1)* %tmp_34, align 16
  br label %tmp_55

tmp_35:                                      ; preds = %tmp_23
  %tmp_36 = load i32* %pos, align 4
  %tmp_37 = load i32* %j, align 4
  %tmp_38 = load i32* %c, align 4
  %tmp_39 = mul nsw i32 %tmp_37, %tmp_38
  %tmp_40 = sub nsw i32 %tmp_36, %tmp_39
  %tmp_41 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_42 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_41, i32 %tmp_40
  %tmp_43 = load <4 x i8> addrspace(1)* %tmp_42, align 4
  %tmp_44 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %tmp_43)
  %tmp_45 = load <4 x i32>* %sum, align 16
  %tmp_46 = add <4 x i32> %tmp_45, %tmp_44
  store <4 x i32> %tmp_46, <4 x i32>* %sum, align 16
  br label %tmp_47

tmp_47:                                      ; preds = %tmp_35
  %tmp_48 = load i32* %j, align 4
  %tmp_49 = add nsw i32 %tmp_48, 1
  store i32 %tmp_49, i32* %j, align 4
  br label %tmp_19

tmp_50:                                      ; preds = %tmp_19
  %tmp_51 = load <4 x i32>* %sum, align 16
  %tmp_52 = load i32* %pos, align 4
  %tmp_53 = load <4 x i32> addrspace(1)** %tmp_2, align 4
  %tmp_54 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_53, i32 %tmp_52
  store <4 x i32> %tmp_51, <4 x i32> addrspace(1)* %tmp_54, align 16
  br label %tmp_55

tmp_55:                                      ; preds = %tmp_50, %tmp_30
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #2

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @horizontalSAT(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %tmp_1 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %pos = alloca i32, align 4
  %c = alloca i32, align 4
  %sum = alloca <4 x i32>, align 16
  %j = alloca i32, align 4
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %tmp_1, align 4
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %tmp_2, align 4
  store i32 %i, i32* %tmp_3, align 4
  store i32 %r, i32* %tmp_4, align 4
  store i32 %width, i32* %tmp_5, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_6, i32* %x, align 4
  %tmp_7 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_7, i32* %y, align 4
  %tmp_8 = load i32* %x, align 4
  %tmp_9 = load i32* %y, align 4
  %tmp_10 = load i32* %tmp_5, align 4
  %tmp_11 = mul nsw i32 %tmp_9, %tmp_10
  %tmp_12 = add nsw i32 %tmp_8, %tmp_11
  store i32 %tmp_12, i32* %pos, align 4
  %tmp_13 = load i32* %tmp_4, align 4
  %tmp_14 = sitofp i32 %tmp_13 to float
  %tmp_15 = load i32* %tmp_3, align 4
  %tmp_16 = sitofp i32 %tmp_15 to float
  %tmp_17 = call float @llvm.pow.f32(float %tmp_14, float %tmp_16)
  %tmp_18 = fptosi float %tmp_17 to i32
  store i32 %tmp_18, i32* %c, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  store i32 0, i32* %j, align 4
  br label %tmp_19

tmp_19:                                      ; preds = %tmp_46, %tmp_0
  %tmp_20 = load i32* %j, align 4
  %tmp_21 = load i32* %tmp_4, align 4
  %tmp_22 = icmp slt i32 %tmp_20, %tmp_21
  br i1 %tmp_22, label %tmp_23, label %tmp_49

tmp_23:                                      ; preds = %tmp_19
  %tmp_24 = load i32* %x, align 4
  %tmp_25 = load i32* %j, align 4
  %tmp_26 = load i32* %c, align 4
  %tmp_27 = mul nsw i32 %tmp_25, %tmp_26
  %tmp_28 = sub nsw i32 %tmp_24, %tmp_27
  %tmp_29 = icmp slt i32 %tmp_28, 0
  br i1 %tmp_29, label %tmp_30, label %tmp_35

tmp_30:                                      ; preds = %tmp_23
  %tmp_31 = load <4 x i32>* %sum, align 16
  %tmp_32 = load i32* %pos, align 4
  %tmp_33 = load <4 x i32> addrspace(1)** %tmp_2, align 4
  %tmp_34 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_33, i32 %tmp_32
  store <4 x i32> %tmp_31, <4 x i32> addrspace(1)* %tmp_34, align 16
  br label %tmp_54

tmp_35:                                      ; preds = %tmp_23
  %tmp_36 = load i32* %pos, align 4
  %tmp_37 = load i32* %j, align 4
  %tmp_38 = load i32* %c, align 4
  %tmp_39 = mul nsw i32 %tmp_37, %tmp_38
  %tmp_40 = sub nsw i32 %tmp_36, %tmp_39
  %tmp_41 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_42 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_41, i32 %tmp_40
  %tmp_43 = load <4 x i32> addrspace(1)* %tmp_42, align 16
  %tmp_44 = load <4 x i32>* %sum, align 16
  %tmp_45 = add <4 x i32> %tmp_44, %tmp_43
  store <4 x i32> %tmp_45, <4 x i32>* %sum, align 16
  br label %tmp_46

tmp_46:                                      ; preds = %tmp_35
  %tmp_47 = load i32* %j, align 4
  %tmp_48 = add nsw i32 %tmp_47, 1
  store i32 %tmp_48, i32* %j, align 4
  br label %tmp_19

tmp_49:                                      ; preds = %tmp_19
  %tmp_50 = load <4 x i32>* %sum, align 16
  %tmp_51 = load i32* %pos, align 4
  %tmp_52 = load <4 x i32> addrspace(1)** %tmp_2, align 4
  %tmp_53 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_52, i32 %tmp_51
  store <4 x i32> %tmp_50, <4 x i32> addrspace(1)* %tmp_53, align 16
  br label %tmp_54

tmp_54:                                      ; preds = %tmp_49, %tmp_30
  ret void
}

; Function Attrs: nounwind
define void @verticalSAT(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %tmp_1 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %c = alloca i32, align 4
  %sum = alloca <4 x i32>, align 16
  %j = alloca i32, align 4
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %tmp_1, align 4
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %tmp_2, align 4
  store i32 %i, i32* %tmp_3, align 4
  store i32 %r, i32* %tmp_4, align 4
  store i32 %width, i32* %tmp_5, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_6, i32* %x, align 4
  %tmp_7 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_7, i32* %y, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  %tmp_9 = sitofp i32 %tmp_8 to float
  %tmp_10 = load i32* %tmp_3, align 4
  %tmp_11 = sitofp i32 %tmp_10 to float
  %tmp_12 = call float @llvm.pow.f32(float %tmp_9, float %tmp_11)
  %tmp_13 = fptosi float %tmp_12 to i32
  store i32 %tmp_13, i32* %c, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  store i32 0, i32* %j, align 4
  br label %tmp_14

tmp_14:                                      ; preds = %tmp_49, %tmp_0
  %tmp_15 = load i32* %j, align 4
  %tmp_16 = load i32* %tmp_4, align 4
  %tmp_17 = icmp slt i32 %tmp_15, %tmp_16
  br i1 %tmp_17, label %tmp_18, label %tmp_52

tmp_18:                                      ; preds = %tmp_14
  %tmp_19 = load i32* %y, align 4
  %tmp_20 = load i32* %j, align 4
  %tmp_21 = load i32* %c, align 4
  %tmp_22 = mul nsw i32 %tmp_20, %tmp_21
  %tmp_23 = sub nsw i32 %tmp_19, %tmp_22
  %tmp_24 = icmp slt i32 %tmp_23, 0
  br i1 %tmp_24, label %tmp_25, label %tmp_34

tmp_25:                                      ; preds = %tmp_18
  %tmp_26 = load <4 x i32>* %sum, align 16
  %tmp_27 = load i32* %x, align 4
  %tmp_28 = load i32* %y, align 4
  %tmp_29 = load i32* %tmp_5, align 4
  %tmp_30 = mul nsw i32 %tmp_28, %tmp_29
  %tmp_31 = add nsw i32 %tmp_27, %tmp_30
  %tmp_32 = load <4 x i32> addrspace(1)** %tmp_2, align 4
  %tmp_33 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_32, i32 %tmp_31
  store <4 x i32> %tmp_26, <4 x i32> addrspace(1)* %tmp_33, align 16
  br label %tmp_61

tmp_34:                                      ; preds = %tmp_18
  %tmp_35 = load i32* %x, align 4
  %tmp_36 = load i32* %tmp_5, align 4
  %tmp_37 = load i32* %y, align 4
  %tmp_38 = load i32* %j, align 4
  %tmp_39 = load i32* %c, align 4
  %tmp_40 = mul nsw i32 %tmp_38, %tmp_39
  %tmp_41 = sub nsw i32 %tmp_37, %tmp_40
  %tmp_42 = mul nsw i32 %tmp_36, %tmp_41
  %tmp_43 = add nsw i32 %tmp_35, %tmp_42
  %tmp_44 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_45 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_44, i32 %tmp_43
  %tmp_46 = load <4 x i32> addrspace(1)* %tmp_45, align 16
  %tmp_47 = load <4 x i32>* %sum, align 16
  %tmp_48 = add <4 x i32> %tmp_47, %tmp_46
  store <4 x i32> %tmp_48, <4 x i32>* %sum, align 16
  br label %tmp_49

tmp_49:                                      ; preds = %tmp_34
  %tmp_50 = load i32* %j, align 4
  %tmp_51 = add nsw i32 %tmp_50, 1
  store i32 %tmp_51, i32* %j, align 4
  br label %tmp_14

tmp_52:                                      ; preds = %tmp_14
  %tmp_53 = load <4 x i32>* %sum, align 16
  %tmp_54 = load i32* %x, align 4
  %tmp_55 = load i32* %y, align 4
  %tmp_56 = load i32* %tmp_5, align 4
  %tmp_57 = mul nsw i32 %tmp_55, %tmp_56
  %tmp_58 = add nsw i32 %tmp_54, %tmp_57
  %tmp_59 = load <4 x i32> addrspace(1)** %tmp_2, align 4
  %tmp_60 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_59, i32 %tmp_58
  store <4 x i32> %tmp_53, <4 x i32> addrspace(1)* %tmp_60, align 16
  br label %tmp_61

tmp_61:                                      ; preds = %tmp_52, %tmp_25
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %pos = alloca i32, align 4
  %k = alloca i32, align 4
  %size = alloca <4 x i32>, align 16
  %sum = alloca <4 x i32>, align 16
  %X = alloca i32, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %tmp_1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %tmp_2, align 4
  store i32 %filterWidth, i32* %tmp_3, align 4
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_4, i32* %x, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_5, i32* %y, align 4
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_6, i32* %width, align 4
  %tmp_7 = call i32 @__get_global_size_u32(i32 1)
  store i32 %tmp_7, i32* %height, align 4
  %tmp_8 = load i32* %x, align 4
  %tmp_9 = load i32* %y, align 4
  %tmp_10 = load i32* %width, align 4
  %tmp_11 = mul nsw i32 %tmp_9, %tmp_10
  %tmp_12 = add nsw i32 %tmp_8, %tmp_11
  store i32 %tmp_12, i32* %pos, align 4
  %tmp_13 = load i32* %tmp_3, align 4
  %tmp_14 = sub nsw i32 %tmp_13, 1
  %tmp_15 = sdiv i32 %tmp_14, 2
  store i32 %tmp_15, i32* %k, align 4
  %tmp_16 = load i32* %x, align 4
  %tmp_17 = load i32* %k, align 4
  %tmp_18 = icmp slt i32 %tmp_16, %tmp_17
  br i1 %tmp_18, label %tmp_25, label %tmp_19

tmp_19:                                      ; preds = %tmp_0
  %tmp_20 = load i32* %x, align 4
  %tmp_21 = load i32* %width, align 4
  %tmp_22 = load i32* %k, align 4
  %tmp_23 = sub nsw i32 %tmp_21, %tmp_22
  %tmp_24 = icmp sge i32 %tmp_20, %tmp_23
  br i1 %tmp_24, label %tmp_25, label %tmp_29

tmp_25:                                      ; preds = %tmp_19, %tmp_0
  %tmp_26 = load i32* %pos, align 4
  %tmp_27 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_28 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_27, i32 %tmp_26
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %tmp_28, align 4
  br label %tmp_79

tmp_29:                                      ; preds = %tmp_19
  %tmp_30 = load i32* %tmp_3, align 4
  %tmp_31 = insertelement <4 x i32> undef, i32 %tmp_30, i32 0
  %tmp_32 = shufflevector <4 x i32> %tmp_31, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %tmp_32, <4 x i32>* %size, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  %tmp_33 = load i32* %k, align 4
  %tmp_34 = sub nsw i32 0, %tmp_33
  store i32 %tmp_34, i32* %X, align 4
  br label %tmp_35

tmp_35:                                      ; preds = %tmp_59, %tmp_29
  %tmp_36 = load i32* %X, align 4
  %tmp_37 = load i32* %k, align 4
  %tmp_38 = icmp slt i32 %tmp_36, %tmp_37
  br i1 %tmp_38, label %tmp_39, label %tmp_62

tmp_39:                                      ; preds = %tmp_35
  %tmp_40 = load i32* %pos, align 4
  %tmp_41 = load i32* %X, align 4
  %tmp_42 = add nsw i32 %tmp_40, %tmp_41
  %tmp_43 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_44 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_43, i32 %tmp_42
  %tmp_45 = load <4 x i8> addrspace(1)* %tmp_44, align 4
  %tmp_46 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_45)
  %tmp_47 = load <4 x i32>* %sum, align 16
  %tmp_48 = add <4 x i32> %tmp_47, %tmp_46
  store <4 x i32> %tmp_48, <4 x i32>* %sum, align 16
  %tmp_49 = load i32* %pos, align 4
  %tmp_50 = load i32* %X, align 4
  %tmp_51 = add nsw i32 %tmp_49, %tmp_50
  %tmp_52 = add nsw i32 %tmp_51, 1
  %tmp_53 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_54 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_53, i32 %tmp_52
  %tmp_55 = load <4 x i8> addrspace(1)* %tmp_54, align 4
  %tmp_56 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_55)
  %tmp_57 = load <4 x i32>* %sum, align 16
  %tmp_58 = add <4 x i32> %tmp_57, %tmp_56
  store <4 x i32> %tmp_58, <4 x i32>* %sum, align 16
  br label %tmp_59

tmp_59:                                      ; preds = %tmp_39
  %tmp_60 = load i32* %X, align 4
  %tmp_61 = add nsw i32 %tmp_60, 2
  store i32 %tmp_61, i32* %X, align 4
  br label %tmp_35

tmp_62:                                      ; preds = %tmp_35
  %tmp_63 = load i32* %pos, align 4
  %tmp_64 = load i32* %k, align 4
  %tmp_65 = add nsw i32 %tmp_63, %tmp_64
  %tmp_66 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_67 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_66, i32 %tmp_65
  %tmp_68 = load <4 x i8> addrspace(1)* %tmp_67, align 4
  %tmp_69 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_68)
  %tmp_70 = load <4 x i32>* %sum, align 16
  %tmp_71 = add <4 x i32> %tmp_70, %tmp_69
  store <4 x i32> %tmp_71, <4 x i32>* %sum, align 16
  %tmp_72 = load <4 x i32>* %sum, align 16
  %tmp_73 = load <4 x i32>* %size, align 16
  %tmp_74 = sdiv <4 x i32> %tmp_72, %tmp_73
  %tmp_75 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %tmp_74)
  %tmp_76 = load i32* %pos, align 4
  %tmp_77 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_78 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_77, i32 %tmp_76
  store <4 x i8> %tmp_75, <4 x i8> addrspace(1)* %tmp_78, align 4
  br label %tmp_79

tmp_79:                                      ; preds = %tmp_62, %tmp_25
  ret void
}

declare <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @box_filter_vertical(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %pos = alloca i32, align 4
  %k = alloca i32, align 4
  %size = alloca <4 x i32>, align 16
  %sum = alloca <4 x i32>, align 16
  %Y = alloca i32, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %tmp_1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %tmp_2, align 4
  store i32 %filterWidth, i32* %tmp_3, align 4
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_4, i32* %x, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_5, i32* %y, align 4
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_6, i32* %width, align 4
  %tmp_7 = call i32 @__get_global_size_u32(i32 1)
  store i32 %tmp_7, i32* %height, align 4
  %tmp_8 = load i32* %x, align 4
  %tmp_9 = load i32* %y, align 4
  %tmp_10 = load i32* %width, align 4
  %tmp_11 = mul nsw i32 %tmp_9, %tmp_10
  %tmp_12 = add nsw i32 %tmp_8, %tmp_11
  store i32 %tmp_12, i32* %pos, align 4
  %tmp_13 = load i32* %tmp_3, align 4
  %tmp_14 = sub nsw i32 %tmp_13, 1
  %tmp_15 = sdiv i32 %tmp_14, 2
  store i32 %tmp_15, i32* %k, align 4
  %tmp_16 = load i32* %y, align 4
  %tmp_17 = load i32* %k, align 4
  %tmp_18 = icmp slt i32 %tmp_16, %tmp_17
  br i1 %tmp_18, label %tmp_25, label %tmp_19

tmp_19:                                      ; preds = %tmp_0
  %tmp_20 = load i32* %y, align 4
  %tmp_21 = load i32* %height, align 4
  %tmp_22 = load i32* %k, align 4
  %tmp_23 = sub nsw i32 %tmp_21, %tmp_22
  %tmp_24 = icmp sge i32 %tmp_20, %tmp_23
  br i1 %tmp_24, label %tmp_25, label %tmp_29

tmp_25:                                      ; preds = %tmp_19, %tmp_0
  %tmp_26 = load i32* %pos, align 4
  %tmp_27 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_28 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_27, i32 %tmp_26
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %tmp_28, align 4
  br label %tmp_85

tmp_29:                                      ; preds = %tmp_19
  %tmp_30 = load i32* %tmp_3, align 4
  %tmp_31 = insertelement <4 x i32> undef, i32 %tmp_30, i32 0
  %tmp_32 = shufflevector <4 x i32> %tmp_31, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %tmp_32, <4 x i32>* %size, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  %tmp_33 = load i32* %k, align 4
  %tmp_34 = sub nsw i32 0, %tmp_33
  store i32 %tmp_34, i32* %Y, align 4
  br label %tmp_35

tmp_35:                                      ; preds = %tmp_63, %tmp_29
  %tmp_36 = load i32* %Y, align 4
  %tmp_37 = load i32* %k, align 4
  %tmp_38 = icmp slt i32 %tmp_36, %tmp_37
  br i1 %tmp_38, label %tmp_39, label %tmp_66

tmp_39:                                      ; preds = %tmp_35
  %tmp_40 = load i32* %pos, align 4
  %tmp_41 = load i32* %Y, align 4
  %tmp_42 = load i32* %width, align 4
  %tmp_43 = mul nsw i32 %tmp_41, %tmp_42
  %tmp_44 = add nsw i32 %tmp_40, %tmp_43
  %tmp_45 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_46 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_45, i32 %tmp_44
  %tmp_47 = load <4 x i8> addrspace(1)* %tmp_46, align 4
  %tmp_48 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_47)
  %tmp_49 = load <4 x i32>* %sum, align 16
  %tmp_50 = add <4 x i32> %tmp_49, %tmp_48
  store <4 x i32> %tmp_50, <4 x i32>* %sum, align 16
  %tmp_51 = load i32* %pos, align 4
  %tmp_52 = load i32* %Y, align 4
  %tmp_53 = add nsw i32 %tmp_52, 1
  %tmp_54 = load i32* %width, align 4
  %tmp_55 = mul nsw i32 %tmp_53, %tmp_54
  %tmp_56 = add nsw i32 %tmp_51, %tmp_55
  %tmp_57 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_58 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_57, i32 %tmp_56
  %tmp_59 = load <4 x i8> addrspace(1)* %tmp_58, align 4
  %tmp_60 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_59)
  %tmp_61 = load <4 x i32>* %sum, align 16
  %tmp_62 = add <4 x i32> %tmp_61, %tmp_60
  store <4 x i32> %tmp_62, <4 x i32>* %sum, align 16
  br label %tmp_63

tmp_63:                                      ; preds = %tmp_39
  %tmp_64 = load i32* %Y, align 4
  %tmp_65 = add nsw i32 %tmp_64, 2
  store i32 %tmp_65, i32* %Y, align 4
  br label %tmp_35

tmp_66:                                      ; preds = %tmp_35
  %tmp_67 = load i32* %pos, align 4
  %tmp_68 = load i32* %k, align 4
  %tmp_69 = load i32* %width, align 4
  %tmp_70 = mul nsw i32 %tmp_68, %tmp_69
  %tmp_71 = add nsw i32 %tmp_67, %tmp_70
  %tmp_72 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_73 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_72, i32 %tmp_71
  %tmp_74 = load <4 x i8> addrspace(1)* %tmp_73, align 4
  %tmp_75 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_74)
  %tmp_76 = load <4 x i32>* %sum, align 16
  %tmp_77 = add <4 x i32> %tmp_76, %tmp_75
  store <4 x i32> %tmp_77, <4 x i32>* %sum, align 16
  %tmp_78 = load <4 x i32>* %sum, align 16
  %tmp_79 = load <4 x i32>* %size, align 16
  %tmp_80 = sdiv <4 x i32> %tmp_78, %tmp_79
  %tmp_81 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %tmp_80)
  %tmp_82 = load i32* %pos, align 4
  %tmp_83 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_84 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_83, i32 %tmp_82
  store <4 x i8> %tmp_81, <4 x i8> addrspace(1)* %tmp_84, align 4
  br label %tmp_85

tmp_85:                                      ; preds = %tmp_66, %tmp_25
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal_local(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth, <4 x i8> addrspace(3)* %lds) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca <4 x i8> addrspace(3)*, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %pos = alloca i32, align 4
  %k = alloca i32, align 4
  %lid = alloca i32, align 4
  %gidX = alloca i32, align 4
  %gidY = alloca i32, align 4
  %gSizeX = alloca i32, align 4
  %gSizeY = alloca i32, align 4
  %firstElement = alloca i32, align 4
  %size = alloca <4 x i32>, align 16
  %sum = alloca <4 x i32>, align 16
  %X = alloca i32, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %tmp_1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %tmp_2, align 4
  store i32 %filterWidth, i32* %tmp_3, align 4
  store <4 x i8> addrspace(3)* %lds, <4 x i8> addrspace(3)** %tmp_4, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_5, i32* %x, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_6, i32* %y, align 4
  %tmp_7 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_7, i32* %width, align 4
  %tmp_8 = call i32 @__get_global_size_u32(i32 1)
  store i32 %tmp_8, i32* %height, align 4
  %tmp_9 = load i32* %x, align 4
  %tmp_10 = load i32* %y, align 4
  %tmp_11 = load i32* %width, align 4
  %tmp_12 = mul nsw i32 %tmp_10, %tmp_11
  %tmp_13 = add nsw i32 %tmp_9, %tmp_12
  store i32 %tmp_13, i32* %pos, align 4
  %tmp_14 = load i32* %tmp_3, align 4
  %tmp_15 = sub nsw i32 %tmp_14, 1
  %tmp_16 = sdiv i32 %tmp_15, 2
  store i32 %tmp_16, i32* %k, align 4
  %tmp_17 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_17, i32* %lid, align 4
  %tmp_18 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_18, i32* %gidX, align 4
  %tmp_19 = call i32 @__get_group_id_u32(i32 1)
  store i32 %tmp_19, i32* %gidY, align 4
  %tmp_20 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_20, i32* %gSizeX, align 4
  %tmp_21 = call i32 @__get_local_size_u32(i32 1)
  store i32 %tmp_21, i32* %gSizeY, align 4
  %tmp_22 = load i32* %gSizeX, align 4
  %tmp_23 = load i32* %gidX, align 4
  %tmp_24 = mul nsw i32 %tmp_22, %tmp_23
  %tmp_25 = load i32* %width, align 4
  %tmp_26 = load i32* %gidY, align 4
  %tmp_27 = mul nsw i32 %tmp_25, %tmp_26
  %tmp_28 = load i32* %gSizeY, align 4
  %tmp_29 = mul nsw i32 %tmp_27, %tmp_28
  %tmp_30 = add nsw i32 %tmp_24, %tmp_29
  store i32 %tmp_30, i32* %firstElement, align 4
  %tmp_31 = load i32* %lid, align 4
  %tmp_32 = load i32* %k, align 4
  %tmp_33 = icmp slt i32 %tmp_31, %tmp_32
  br i1 %tmp_33, label %tmp_34, label %tmp_59

tmp_34:                                      ; preds = %tmp_0
  %tmp_35 = load i32* %firstElement, align 4
  %tmp_36 = load i32* %k, align 4
  %tmp_37 = sub nsw i32 %tmp_35, %tmp_36
  %tmp_38 = load i32* %lid, align 4
  %tmp_39 = add nsw i32 %tmp_37, %tmp_38
  %tmp_40 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_41 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_40, i32 %tmp_39
  %tmp_42 = load <4 x i8> addrspace(1)* %tmp_41, align 4
  %tmp_43 = load i32* %lid, align 4
  %tmp_44 = load <4 x i8> addrspace(3)** %tmp_4, align 4
  %tmp_45 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_44, i32 %tmp_43
  store <4 x i8> %tmp_42, <4 x i8> addrspace(3)* %tmp_45, align 4
  %tmp_46 = load i32* %firstElement, align 4
  %tmp_47 = load i32* %lid, align 4
  %tmp_48 = add nsw i32 %tmp_46, %tmp_47
  %tmp_49 = add nsw i32 %tmp_48, 256
  %tmp_50 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_51 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_50, i32 %tmp_49
  %tmp_52 = load <4 x i8> addrspace(1)* %tmp_51, align 4
  %tmp_53 = load i32* %k, align 4
  %tmp_54 = add nsw i32 256, %tmp_53
  %tmp_55 = load i32* %lid, align 4
  %tmp_56 = add nsw i32 %tmp_54, %tmp_55
  %tmp_57 = load <4 x i8> addrspace(3)** %tmp_4, align 4
  %tmp_58 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_57, i32 %tmp_56
  store <4 x i8> %tmp_52, <4 x i8> addrspace(3)* %tmp_58, align 4
  br label %tmp_59

tmp_59:                                      ; preds = %tmp_34, %tmp_0
  %tmp_60 = load i32* %firstElement, align 4
  %tmp_61 = load i32* %lid, align 4
  %tmp_62 = add nsw i32 %tmp_60, %tmp_61
  %tmp_63 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_64 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_63, i32 %tmp_62
  %tmp_65 = load <4 x i8> addrspace(1)* %tmp_64, align 4
  %tmp_66 = load i32* %lid, align 4
  %tmp_67 = load i32* %k, align 4
  %tmp_68 = add nsw i32 %tmp_66, %tmp_67
  %tmp_69 = load <4 x i8> addrspace(3)** %tmp_4, align 4
  %tmp_70 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_69, i32 %tmp_68
  store <4 x i8> %tmp_65, <4 x i8> addrspace(3)* %tmp_70, align 4
  call void @barrier(i32 1)
  %tmp_71 = load i32* %x, align 4
  %tmp_72 = load i32* %k, align 4
  %tmp_73 = icmp slt i32 %tmp_71, %tmp_72
  br i1 %tmp_73, label %tmp_80, label %tmp_74

tmp_74:                                      ; preds = %tmp_59
  %tmp_75 = load i32* %x, align 4
  %tmp_76 = load i32* %width, align 4
  %tmp_77 = load i32* %k, align 4
  %tmp_78 = sub nsw i32 %tmp_76, %tmp_77
  %tmp_79 = icmp sge i32 %tmp_75, %tmp_78
  br i1 %tmp_79, label %tmp_80, label %tmp_81

tmp_80:                                      ; preds = %tmp_74, %tmp_59
  br label %tmp_114

tmp_81:                                      ; preds = %tmp_74
  %tmp_82 = load i32* %tmp_3, align 4
  %tmp_83 = insertelement <4 x i32> undef, i32 %tmp_82, i32 0
  %tmp_84 = shufflevector <4 x i32> %tmp_83, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %tmp_84, <4 x i32>* %size, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  %tmp_85 = load i32* %k, align 4
  %tmp_86 = sub nsw i32 0, %tmp_85
  store i32 %tmp_86, i32* %X, align 4
  br label %tmp_87

tmp_87:                                      ; preds = %tmp_103, %tmp_81
  %tmp_88 = load i32* %X, align 4
  %tmp_89 = load i32* %k, align 4
  %tmp_90 = icmp sle i32 %tmp_88, %tmp_89
  br i1 %tmp_90, label %tmp_91, label %tmp_106

tmp_91:                                      ; preds = %tmp_87
  %tmp_92 = load i32* %lid, align 4
  %tmp_93 = load i32* %X, align 4
  %tmp_94 = add nsw i32 %tmp_92, %tmp_93
  %tmp_95 = load i32* %k, align 4
  %tmp_96 = add nsw i32 %tmp_94, %tmp_95
  %tmp_97 = load <4 x i8> addrspace(3)** %tmp_4, align 4
  %tmp_98 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_97, i32 %tmp_96
  %tmp_99 = load <4 x i8> addrspace(3)* %tmp_98, align 4
  %tmp_100 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_99)
  %tmp_101 = load <4 x i32>* %sum, align 16
  %tmp_102 = add <4 x i32> %tmp_101, %tmp_100
  store <4 x i32> %tmp_102, <4 x i32>* %sum, align 16
  br label %tmp_103

tmp_103:                                     ; preds = %tmp_91
  %tmp_104 = load i32* %X, align 4
  %tmp_105 = add nsw i32 %tmp_104, 1
  store i32 %tmp_105, i32* %X, align 4
  br label %tmp_87

tmp_106:                                     ; preds = %tmp_87
  %tmp_107 = load <4 x i32>* %sum, align 16
  %tmp_108 = load <4 x i32>* %size, align 16
  %tmp_109 = sdiv <4 x i32> %tmp_107, %tmp_108
  %tmp_110 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %tmp_109)
  %tmp_111 = load i32* %pos, align 4
  %tmp_112 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_113 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_112, i32 %tmp_111
  store <4 x i8> %tmp_110, <4 x i8> addrspace(1)* %tmp_113, align 4
  br label %tmp_114

tmp_114:                                     ; preds = %tmp_106, %tmp_80
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter}
!1 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT0}
!2 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT}
!3 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @verticalSAT}
!4 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_horizontal}
!5 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_vertical}
!6 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, <4 x i8> addrspace(3)*)* @box_filter_horizontal_local}
!7 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

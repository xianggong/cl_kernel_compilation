; ModuleID = '../kernel-src/RecursiveGaussian_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @transpose_kernel(<4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(3)* %block, i32 %width, i32 %height, i32 %blockSize) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_3 = alloca <4 x i8> addrspace(3)*, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i32, align 4
  %tmp_6 = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %globalIdy = alloca i32, align 4
  %localIdx = alloca i32, align 4
  %localIdy = alloca i32, align 4
  %sourceIndex = alloca i32, align 4
  %targetIndex = alloca i32, align 4
  store <4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)** %tmp_1, align 4
  store <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)** %tmp_2, align 4
  store <4 x i8> addrspace(3)* %block, <4 x i8> addrspace(3)** %tmp_3, align 4
  store i32 %width, i32* %tmp_4, align 4
  store i32 %height, i32* %tmp_5, align 4
  store i32 %blockSize, i32* %tmp_6, align 4
  %tmp_7 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_7, i32* %globalIdx, align 4
  %tmp_8 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_8, i32* %globalIdy, align 4
  %tmp_9 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_9, i32* %localIdx, align 4
  %tmp_10 = call i32 @__get_local_id_u32(i32 1)
  store i32 %tmp_10, i32* %localIdy, align 4
  %tmp_11 = load i32* %globalIdy, align 4
  %tmp_12 = load i32* %tmp_4, align 4
  %tmp_13 = mul i32 %tmp_11, %tmp_12
  %tmp_14 = load i32* %globalIdx, align 4
  %tmp_15 = add i32 %tmp_13, %tmp_14
  %tmp_16 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_17 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_16, i32 %tmp_15
  %tmp_18 = load <4 x i8> addrspace(1)* %tmp_17, align 4
  %tmp_19 = load i32* %localIdy, align 4
  %tmp_20 = load i32* %tmp_6, align 4
  %tmp_21 = mul i32 %tmp_19, %tmp_20
  %tmp_22 = load i32* %localIdx, align 4
  %tmp_23 = add i32 %tmp_21, %tmp_22
  %tmp_24 = load <4 x i8> addrspace(3)** %tmp_3, align 4
  %tmp_25 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_24, i32 %tmp_23
  store <4 x i8> %tmp_18, <4 x i8> addrspace(3)* %tmp_25, align 4
  call void @barrier(i32 1)
  %tmp_26 = load i32* %localIdy, align 4
  %tmp_27 = load i32* %tmp_6, align 4
  %tmp_28 = mul i32 %tmp_26, %tmp_27
  %tmp_29 = load i32* %localIdx, align 4
  %tmp_30 = add i32 %tmp_28, %tmp_29
  store i32 %tmp_30, i32* %sourceIndex, align 4
  %tmp_31 = load i32* %globalIdy, align 4
  %tmp_32 = load i32* %globalIdx, align 4
  %tmp_33 = load i32* %tmp_5, align 4
  %tmp_34 = mul i32 %tmp_32, %tmp_33
  %tmp_35 = add i32 %tmp_31, %tmp_34
  store i32 %tmp_35, i32* %targetIndex, align 4
  %tmp_36 = load i32* %sourceIndex, align 4
  %tmp_37 = load <4 x i8> addrspace(3)** %tmp_3, align 4
  %tmp_38 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_37, i32 %tmp_36
  %tmp_39 = load <4 x i8> addrspace(3)* %tmp_38, align 4
  %tmp_40 = load i32* %targetIndex, align 4
  %tmp_41 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_42 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_41, i32 %tmp_40
  store <4 x i8> %tmp_39, <4 x i8> addrspace(1)* %tmp_42, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @RecursiveGaussian_kernel(<4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)* %output, i32 %width, i32 %height, float %a0, float %a1, float %a2, float %a3, float %b1, float %b2, float %coefp, float %coefn) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca float, align 4
  %tmp_6 = alloca float, align 4
  %tmp_7 = alloca float, align 4
  %tmp_8 = alloca float, align 4
  %tmp_9 = alloca float, align 4
  %tmp_10 = alloca float, align 4
  %tmp_11 = alloca float, align 4
  %tmp_12 = alloca float, align 4
  %x = alloca i32, align 4
  %xp = alloca <4 x float>, align 16
  %yp = alloca <4 x float>, align 16
  %yb = alloca <4 x float>, align 16
  %y = alloca i32, align 4
  %pos = alloca i32, align 4
  %xc = alloca <4 x float>, align 16
  %tmp_13 = alloca <4 x float>, align 16
  %yc = alloca <4 x float>, align 16
  %tmp_14 = alloca <4 x i8>, align 4
  %xn = alloca <4 x float>, align 16
  %xa = alloca <4 x float>, align 16
  %yn = alloca <4 x float>, align 16
  %ya = alloca <4 x float>, align 16
  %y1 = alloca i32, align 4
  %pos2 = alloca i32, align 4
  %xc3 = alloca <4 x float>, align 16
  %tmp_15 = alloca <4 x float>, align 16
  %yc4 = alloca <4 x float>, align 16
  %temp = alloca <4 x float>, align 16
  %tmp_16 = alloca <4 x float>, align 16
  %tmp_17 = alloca <4 x i8>, align 4
  store <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)** %tmp_1, align 4
  store <4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)** %tmp_2, align 4
  store i32 %width, i32* %tmp_3, align 4
  store i32 %height, i32* %tmp_4, align 4
  store float %a0, float* %tmp_5, align 4
  store float %a1, float* %tmp_6, align 4
  store float %a2, float* %tmp_7, align 4
  store float %a3, float* %tmp_8, align 4
  store float %b1, float* %tmp_9, align 4
  store float %b2, float* %tmp_10, align 4
  store float %coefp, float* %tmp_11, align 4
  store float %coefn, float* %tmp_12, align 4
  %tmp_18 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_18, i32* %x, align 4
  %tmp_19 = load i32* %x, align 4
  %tmp_20 = load i32* %tmp_3, align 4
  %tmp_21 = icmp uge i32 %tmp_19, %tmp_20
  br i1 %tmp_21, label %tmp_22, label %tmp_23

tmp_22:                                      ; preds = %tmp_0
  br label %tmp_232

tmp_23:                                      ; preds = %tmp_0
  store <4 x float> zeroinitializer, <4 x float>* %xp, align 16
  store <4 x float> zeroinitializer, <4 x float>* %yp, align 16
  store <4 x float> zeroinitializer, <4 x float>* %yb, align 16
  store i32 0, i32* %y, align 4
  br label %tmp_24

tmp_24:                                      ; preds = %tmp_108, %tmp_23
  %tmp_25 = load i32* %y, align 4
  %tmp_26 = load i32* %tmp_4, align 4
  %tmp_27 = icmp slt i32 %tmp_25, %tmp_26
  br i1 %tmp_27, label %tmp_28, label %tmp_111

tmp_28:                                      ; preds = %tmp_24
  %tmp_29 = load i32* %x, align 4
  %tmp_30 = load i32* %y, align 4
  %tmp_31 = load i32* %tmp_3, align 4
  %tmp_32 = mul nsw i32 %tmp_30, %tmp_31
  %tmp_33 = add i32 %tmp_29, %tmp_32
  store i32 %tmp_33, i32* %pos, align 4
  %tmp_34 = load i32* %pos, align 4
  %tmp_35 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_36 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_35, i32 %tmp_34
  %tmp_37 = load <4 x i8> addrspace(1)* %tmp_36, align 4
  %tmp_38 = extractelement <4 x i8> %tmp_37, i32 0
  %tmp_39 = uitofp i8 %tmp_38 to float
  %tmp_40 = insertelement <4 x float> undef, float %tmp_39, i32 0
  %tmp_41 = load i32* %pos, align 4
  %tmp_42 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_43 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_42, i32 %tmp_41
  %tmp_44 = load <4 x i8> addrspace(1)* %tmp_43, align 4
  %tmp_45 = extractelement <4 x i8> %tmp_44, i32 1
  %tmp_46 = uitofp i8 %tmp_45 to float
  %tmp_47 = insertelement <4 x float> %tmp_40, float %tmp_46, i32 1
  %tmp_48 = load i32* %pos, align 4
  %tmp_49 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_50 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_49, i32 %tmp_48
  %tmp_51 = load <4 x i8> addrspace(1)* %tmp_50, align 4
  %tmp_52 = extractelement <4 x i8> %tmp_51, i32 2
  %tmp_53 = uitofp i8 %tmp_52 to float
  %tmp_54 = insertelement <4 x float> %tmp_47, float %tmp_53, i32 2
  %tmp_55 = load i32* %pos, align 4
  %tmp_56 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_57 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_56, i32 %tmp_55
  %tmp_58 = load <4 x i8> addrspace(1)* %tmp_57, align 4
  %tmp_59 = extractelement <4 x i8> %tmp_58, i32 3
  %tmp_60 = uitofp i8 %tmp_59 to float
  %tmp_61 = insertelement <4 x float> %tmp_54, float %tmp_60, i32 3
  store <4 x float> %tmp_61, <4 x float>* %tmp_13
  %tmp_62 = load <4 x float>* %tmp_13
  store <4 x float> %tmp_62, <4 x float>* %xc, align 16
  %tmp_63 = load float* %tmp_5, align 4
  %tmp_64 = insertelement <4 x float> undef, float %tmp_63, i32 0
  %tmp_65 = shufflevector <4 x float> %tmp_64, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_66 = load <4 x float>* %xc, align 16
  %tmp_67 = load float* %tmp_6, align 4
  %tmp_68 = insertelement <4 x float> undef, float %tmp_67, i32 0
  %tmp_69 = shufflevector <4 x float> %tmp_68, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_70 = load <4 x float>* %xp, align 16
  %tmp_71 = fmul <4 x float> %tmp_69, %tmp_70
  %tmp_72 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_65, <4 x float> %tmp_66, <4 x float> %tmp_71)
  %tmp_73 = load float* %tmp_9, align 4
  %tmp_74 = insertelement <4 x float> undef, float %tmp_73, i32 0
  %tmp_75 = shufflevector <4 x float> %tmp_74, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_76 = load <4 x float>* %yp, align 16
  %tmp_77 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_75
  %tmp_78 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_77, <4 x float> %tmp_76, <4 x float> %tmp_72)
  %tmp_79 = load float* %tmp_10, align 4
  %tmp_80 = insertelement <4 x float> undef, float %tmp_79, i32 0
  %tmp_81 = shufflevector <4 x float> %tmp_80, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_82 = load <4 x float>* %yb, align 16
  %tmp_83 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_81
  %tmp_84 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_83, <4 x float> %tmp_82, <4 x float> %tmp_78)
  store <4 x float> %tmp_84, <4 x float>* %yc, align 16
  %tmp_85 = load <4 x float>* %yc, align 16
  %tmp_86 = extractelement <4 x float> %tmp_85, i32 0
  %tmp_87 = fptoui float %tmp_86 to i8
  %tmp_88 = insertelement <4 x i8> undef, i8 %tmp_87, i32 0
  %tmp_89 = load <4 x float>* %yc, align 16
  %tmp_90 = extractelement <4 x float> %tmp_89, i32 1
  %tmp_91 = fptoui float %tmp_90 to i8
  %tmp_92 = insertelement <4 x i8> %tmp_88, i8 %tmp_91, i32 1
  %tmp_93 = load <4 x float>* %yc, align 16
  %tmp_94 = extractelement <4 x float> %tmp_93, i32 2
  %tmp_95 = fptoui float %tmp_94 to i8
  %tmp_96 = insertelement <4 x i8> %tmp_92, i8 %tmp_95, i32 2
  %tmp_97 = load <4 x float>* %yc, align 16
  %tmp_98 = extractelement <4 x float> %tmp_97, i32 3
  %tmp_99 = fptoui float %tmp_98 to i8
  %tmp_100 = insertelement <4 x i8> %tmp_96, i8 %tmp_99, i32 3
  store <4 x i8> %tmp_100, <4 x i8>* %tmp_14
  %tmp_101 = load <4 x i8>* %tmp_14
  %tmp_102 = load i32* %pos, align 4
  %tmp_103 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_104 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_103, i32 %tmp_102
  store <4 x i8> %tmp_101, <4 x i8> addrspace(1)* %tmp_104, align 4
  %tmp_105 = load <4 x float>* %xc, align 16
  store <4 x float> %tmp_105, <4 x float>* %xp, align 16
  %tmp_106 = load <4 x float>* %yp, align 16
  store <4 x float> %tmp_106, <4 x float>* %yb, align 16
  %tmp_107 = load <4 x float>* %yc, align 16
  store <4 x float> %tmp_107, <4 x float>* %yp, align 16
  br label %tmp_108

tmp_108:                                     ; preds = %tmp_28
  %tmp_109 = load i32* %y, align 4
  %tmp_110 = add nsw i32 %tmp_109, 1
  store i32 %tmp_110, i32* %y, align 4
  br label %tmp_24

tmp_111:                                     ; preds = %tmp_24
  call void @barrier(i32 2)
  store <4 x float> zeroinitializer, <4 x float>* %xn, align 16
  store <4 x float> zeroinitializer, <4 x float>* %xa, align 16
  store <4 x float> zeroinitializer, <4 x float>* %yn, align 16
  store <4 x float> zeroinitializer, <4 x float>* %ya, align 16
  %tmp_112 = load i32* %tmp_4, align 4
  %tmp_113 = sub nsw i32 %tmp_112, 1
  store i32 %tmp_113, i32* %y1, align 4
  br label %tmp_114

tmp_114:                                     ; preds = %tmp_229, %tmp_111
  %tmp_115 = load i32* %y1, align 4
  %tmp_116 = icmp sgt i32 %tmp_115, -1
  br i1 %tmp_116, label %tmp_117, label %tmp_232

tmp_117:                                     ; preds = %tmp_114
  %tmp_118 = load i32* %x, align 4
  %tmp_119 = load i32* %y1, align 4
  %tmp_120 = load i32* %tmp_3, align 4
  %tmp_121 = mul nsw i32 %tmp_119, %tmp_120
  %tmp_122 = add i32 %tmp_118, %tmp_121
  store i32 %tmp_122, i32* %pos2, align 4
  %tmp_123 = load i32* %pos2, align 4
  %tmp_124 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_125 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_124, i32 %tmp_123
  %tmp_126 = load <4 x i8> addrspace(1)* %tmp_125, align 4
  %tmp_127 = extractelement <4 x i8> %tmp_126, i32 0
  %tmp_128 = uitofp i8 %tmp_127 to float
  %tmp_129 = insertelement <4 x float> undef, float %tmp_128, i32 0
  %tmp_130 = load i32* %pos2, align 4
  %tmp_131 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_132 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_131, i32 %tmp_130
  %tmp_133 = load <4 x i8> addrspace(1)* %tmp_132, align 4
  %tmp_134 = extractelement <4 x i8> %tmp_133, i32 1
  %tmp_135 = uitofp i8 %tmp_134 to float
  %tmp_136 = insertelement <4 x float> %tmp_129, float %tmp_135, i32 1
  %tmp_137 = load i32* %pos2, align 4
  %tmp_138 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_139 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_138, i32 %tmp_137
  %tmp_140 = load <4 x i8> addrspace(1)* %tmp_139, align 4
  %tmp_141 = extractelement <4 x i8> %tmp_140, i32 2
  %tmp_142 = uitofp i8 %tmp_141 to float
  %tmp_143 = insertelement <4 x float> %tmp_136, float %tmp_142, i32 2
  %tmp_144 = load i32* %pos2, align 4
  %tmp_145 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_146 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_145, i32 %tmp_144
  %tmp_147 = load <4 x i8> addrspace(1)* %tmp_146, align 4
  %tmp_148 = extractelement <4 x i8> %tmp_147, i32 3
  %tmp_149 = uitofp i8 %tmp_148 to float
  %tmp_150 = insertelement <4 x float> %tmp_143, float %tmp_149, i32 3
  store <4 x float> %tmp_150, <4 x float>* %tmp_15
  %tmp_151 = load <4 x float>* %tmp_15
  store <4 x float> %tmp_151, <4 x float>* %xc3, align 16
  %tmp_152 = load float* %tmp_7, align 4
  %tmp_153 = insertelement <4 x float> undef, float %tmp_152, i32 0
  %tmp_154 = shufflevector <4 x float> %tmp_153, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_155 = load <4 x float>* %xn, align 16
  %tmp_156 = load float* %tmp_8, align 4
  %tmp_157 = insertelement <4 x float> undef, float %tmp_156, i32 0
  %tmp_158 = shufflevector <4 x float> %tmp_157, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_159 = load <4 x float>* %xa, align 16
  %tmp_160 = fmul <4 x float> %tmp_158, %tmp_159
  %tmp_161 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_154, <4 x float> %tmp_155, <4 x float> %tmp_160)
  %tmp_162 = load float* %tmp_9, align 4
  %tmp_163 = insertelement <4 x float> undef, float %tmp_162, i32 0
  %tmp_164 = shufflevector <4 x float> %tmp_163, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_165 = load <4 x float>* %yn, align 16
  %tmp_166 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_164
  %tmp_167 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_166, <4 x float> %tmp_165, <4 x float> %tmp_161)
  %tmp_168 = load float* %tmp_10, align 4
  %tmp_169 = insertelement <4 x float> undef, float %tmp_168, i32 0
  %tmp_170 = shufflevector <4 x float> %tmp_169, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_171 = load <4 x float>* %ya, align 16
  %tmp_172 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_170
  %tmp_173 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_172, <4 x float> %tmp_171, <4 x float> %tmp_167)
  store <4 x float> %tmp_173, <4 x float>* %yc4, align 16
  %tmp_174 = load <4 x float>* %xn, align 16
  store <4 x float> %tmp_174, <4 x float>* %xa, align 16
  %tmp_175 = load <4 x float>* %xc3, align 16
  store <4 x float> %tmp_175, <4 x float>* %xn, align 16
  %tmp_176 = load <4 x float>* %yn, align 16
  store <4 x float> %tmp_176, <4 x float>* %ya, align 16
  %tmp_177 = load <4 x float>* %yc4, align 16
  store <4 x float> %tmp_177, <4 x float>* %yn, align 16
  %tmp_178 = load i32* %pos2, align 4
  %tmp_179 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_180 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_179, i32 %tmp_178
  %tmp_181 = load <4 x i8> addrspace(1)* %tmp_180, align 4
  %tmp_182 = extractelement <4 x i8> %tmp_181, i32 0
  %tmp_183 = uitofp i8 %tmp_182 to float
  %tmp_184 = insertelement <4 x float> undef, float %tmp_183, i32 0
  %tmp_185 = load i32* %pos2, align 4
  %tmp_186 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_187 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_186, i32 %tmp_185
  %tmp_188 = load <4 x i8> addrspace(1)* %tmp_187, align 4
  %tmp_189 = extractelement <4 x i8> %tmp_188, i32 1
  %tmp_190 = uitofp i8 %tmp_189 to float
  %tmp_191 = insertelement <4 x float> %tmp_184, float %tmp_190, i32 1
  %tmp_192 = load i32* %pos2, align 4
  %tmp_193 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_194 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_193, i32 %tmp_192
  %tmp_195 = load <4 x i8> addrspace(1)* %tmp_194, align 4
  %tmp_196 = extractelement <4 x i8> %tmp_195, i32 2
  %tmp_197 = uitofp i8 %tmp_196 to float
  %tmp_198 = insertelement <4 x float> %tmp_191, float %tmp_197, i32 2
  %tmp_199 = load i32* %pos2, align 4
  %tmp_200 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_201 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_200, i32 %tmp_199
  %tmp_202 = load <4 x i8> addrspace(1)* %tmp_201, align 4
  %tmp_203 = extractelement <4 x i8> %tmp_202, i32 3
  %tmp_204 = uitofp i8 %tmp_203 to float
  %tmp_205 = insertelement <4 x float> %tmp_198, float %tmp_204, i32 3
  store <4 x float> %tmp_205, <4 x float>* %tmp_16
  %tmp_206 = load <4 x float>* %tmp_16
  %tmp_207 = load <4 x float>* %yc4, align 16
  %tmp_208 = fadd <4 x float> %tmp_206, %tmp_207
  store <4 x float> %tmp_208, <4 x float>* %temp, align 16
  %tmp_209 = load <4 x float>* %temp, align 16
  %tmp_210 = extractelement <4 x float> %tmp_209, i32 0
  %tmp_211 = fptoui float %tmp_210 to i8
  %tmp_212 = insertelement <4 x i8> undef, i8 %tmp_211, i32 0
  %tmp_213 = load <4 x float>* %temp, align 16
  %tmp_214 = extractelement <4 x float> %tmp_213, i32 1
  %tmp_215 = fptoui float %tmp_214 to i8
  %tmp_216 = insertelement <4 x i8> %tmp_212, i8 %tmp_215, i32 1
  %tmp_217 = load <4 x float>* %temp, align 16
  %tmp_218 = extractelement <4 x float> %tmp_217, i32 2
  %tmp_219 = fptoui float %tmp_218 to i8
  %tmp_220 = insertelement <4 x i8> %tmp_216, i8 %tmp_219, i32 2
  %tmp_221 = load <4 x float>* %temp, align 16
  %tmp_222 = extractelement <4 x float> %tmp_221, i32 3
  %tmp_223 = fptoui float %tmp_222 to i8
  %tmp_224 = insertelement <4 x i8> %tmp_220, i8 %tmp_223, i32 3
  store <4 x i8> %tmp_224, <4 x i8>* %tmp_17
  %tmp_225 = load <4 x i8>* %tmp_17
  %tmp_226 = load i32* %pos2, align 4
  %tmp_227 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_228 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_227, i32 %tmp_226
  store <4 x i8> %tmp_225, <4 x i8> addrspace(1)* %tmp_228, align 4
  br label %tmp_229

tmp_229:                                     ; preds = %tmp_117
  %tmp_230 = load i32* %y1, align 4
  %tmp_231 = add nsw i32 %tmp_230, -1
  store i32 %tmp_231, i32* %y1, align 4
  br label %tmp_114

tmp_232:                                     ; preds = %tmp_22, %tmp_114
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

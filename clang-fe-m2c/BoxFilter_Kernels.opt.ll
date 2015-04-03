; ModuleID = 'BoxFilter_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @box_filter(<4 x i32> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %N) #0 {
  %tmp_8 = call i32 @__get_global_id_u32(i32 0)
  %tmp_9 = call i32 @__get_global_id_u32(i32 1)
  %tmp_10 = call i32 @__get_global_size_u32(i32 0)
  %tmp_11 = call i32 @__get_global_size_u32(i32 1)
  %tmp_13 = sub i32 %N, 1
  %tmp_14 = udiv i32 %tmp_13, 2
  %tmp_17 = icmp slt i32 %tmp_8, %tmp_14
  br i1 %tmp_17, label %tmp_36, label %tmp_18

tmp_18:                                           ; preds = %0
  %tmp_21 = icmp slt i32 %tmp_9, %tmp_14
  br i1 %tmp_21, label %tmp_36, label %tmp_22

tmp_22:                                           ; preds = %tmp_18
  %tmp_26 = sub nsw i32 %tmp_10, %tmp_14
  %tmp_27 = sub nsw i32 %tmp_26, 1
  %tmp_28 = icmp sgt i32 %tmp_8, %tmp_27
  br i1 %tmp_28, label %tmp_36, label %tmp_29

tmp_29:                                           ; preds = %tmp_22
  %tmp_33 = sub nsw i32 %tmp_11, %tmp_14
  %tmp_34 = sub nsw i32 %tmp_33, 1
  %tmp_35 = icmp sgt i32 %tmp_9, %tmp_34
  br i1 %tmp_35, label %tmp_36, label %tmp_44

tmp_36:                                           ; preds = %tmp_29, %tmp_22, %tmp_18, %0
  %tmp_40 = mul nsw i32 %tmp_9, %tmp_10
  %tmp_41 = add nsw i32 %tmp_8, %tmp_40
  %tmp_43 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_41
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %tmp_43, align 4
  br label %tmp_194

tmp_44:                                           ; preds = %tmp_29
  %tmp_47 = mul i32 %N, %N
  %tmp_48 = insertelement <4 x i32> undef, i32 %tmp_47, i32 0
  %tmp_49 = shufflevector <4 x i32> %tmp_48, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_52 = sub nsw i32 %tmp_8, %tmp_14
  %tmp_53 = insertelement <2 x i32> undef, i32 %tmp_52, i32 0
  %tmp_56 = sub nsw i32 %tmp_9, %tmp_14
  %tmp_57 = insertelement <2 x i32> %tmp_53, i32 %tmp_56, i32 1
  %tmp_61 = add nsw i32 %tmp_8, %tmp_14
  %tmp_62 = insertelement <2 x i32> undef, i32 %tmp_61, i32 0
  %tmp_65 = sub nsw i32 %tmp_9, %tmp_14
  %tmp_66 = insertelement <2 x i32> %tmp_62, i32 %tmp_65, i32 1
  %tmp_70 = add nsw i32 %tmp_8, %tmp_14
  %tmp_71 = insertelement <2 x i32> undef, i32 %tmp_70, i32 0
  %tmp_74 = add nsw i32 %tmp_9, %tmp_14
  %tmp_75 = insertelement <2 x i32> %tmp_71, i32 %tmp_74, i32 1
  %tmp_79 = sub nsw i32 %tmp_8, %tmp_14
  %tmp_80 = insertelement <2 x i32> undef, i32 %tmp_79, i32 0
  %tmp_83 = add nsw i32 %tmp_9, %tmp_14
  %tmp_84 = insertelement <2 x i32> %tmp_80, i32 %tmp_83, i32 1
  %tmp_87 = extractelement <2 x i32> %tmp_57, i32 0
  %tmp_88 = sub nsw i32 %tmp_87, 1
  %tmp_90 = insertelement <2 x i32> %tmp_57, i32 %tmp_88, i32 0
  %tmp_92 = extractelement <2 x i32> %tmp_90, i32 1
  %tmp_93 = sub nsw i32 %tmp_92, 1
  %tmp_95 = insertelement <2 x i32> %tmp_90, i32 %tmp_93, i32 1
  %tmp_97 = extractelement <2 x i32> %tmp_66, i32 1
  %tmp_98 = sub nsw i32 %tmp_97, 1
  %tmp_100 = insertelement <2 x i32> %tmp_66, i32 %tmp_98, i32 1
  %tmp_102 = extractelement <2 x i32> %tmp_84, i32 0
  %tmp_103 = sub nsw i32 %tmp_102, 1
  %tmp_105 = insertelement <2 x i32> %tmp_84, i32 %tmp_103, i32 0
  %tmp_107 = extractelement <2 x i32> %tmp_95, i32 0
  %tmp_108 = icmp sge i32 %tmp_107, 0
  br i1 %tmp_108, label %tmp_109, label %tmp_125

tmp_109:                                          ; preds = %tmp_44
  %tmp_111 = extractelement <2 x i32> %tmp_95, i32 1
  %tmp_112 = icmp sge i32 %tmp_111, 0
  br i1 %tmp_112, label %tmp_113, label %tmp_125

tmp_113:                                          ; preds = %tmp_109
  %tmp_115 = extractelement <2 x i32> %tmp_95, i32 0
  %tmp_117 = extractelement <2 x i32> %tmp_95, i32 1
  %tmp_119 = mul nsw i32 %tmp_117, %tmp_10
  %tmp_120 = add nsw i32 %tmp_115, %tmp_119
  %tmp_122 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %tmp_120
  %tmp_123 = load <4 x i32> addrspace(1)* %tmp_122, align 16
  %tmp_124 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %tmp_123)
  br label %tmp_125

tmp_125:                                          ; preds = %tmp_113, %tmp_109, %tmp_44
  %sumA.0 = phi <4 x i32> [ %tmp_124, %tmp_113 ], [ zeroinitializer, %tmp_109 ], [ zeroinitializer, %tmp_44 ]
  %tmp_127 = extractelement <2 x i32> %tmp_100, i32 0
  %tmp_128 = icmp sge i32 %tmp_127, 0
  br i1 %tmp_128, label %tmp_129, label %tmp_145

tmp_129:                                          ; preds = %tmp_125
  %tmp_131 = extractelement <2 x i32> %tmp_100, i32 1
  %tmp_132 = icmp sge i32 %tmp_131, 0
  br i1 %tmp_132, label %tmp_133, label %tmp_145

tmp_133:                                          ; preds = %tmp_129
  %tmp_135 = extractelement <2 x i32> %tmp_100, i32 0
  %tmp_137 = extractelement <2 x i32> %tmp_100, i32 1
  %tmp_139 = mul nsw i32 %tmp_137, %tmp_10
  %tmp_140 = add nsw i32 %tmp_135, %tmp_139
  %tmp_142 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %tmp_140
  %tmp_143 = load <4 x i32> addrspace(1)* %tmp_142, align 16
  %tmp_144 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %tmp_143)
  br label %tmp_145

tmp_145:                                          ; preds = %tmp_133, %tmp_129, %tmp_125
  %sumB.0 = phi <4 x i32> [ %tmp_144, %tmp_133 ], [ zeroinitializer, %tmp_129 ], [ zeroinitializer, %tmp_125 ]
  %tmp_147 = extractelement <2 x i32> %tmp_105, i32 0
  %tmp_148 = icmp sge i32 %tmp_147, 0
  br i1 %tmp_148, label %tmp_149, label %tmp_165

tmp_149:                                          ; preds = %tmp_145
  %tmp_151 = extractelement <2 x i32> %tmp_105, i32 1
  %tmp_152 = icmp sge i32 %tmp_151, 0
  br i1 %tmp_152, label %tmp_153, label %tmp_165

tmp_153:                                          ; preds = %tmp_149
  %tmp_155 = extractelement <2 x i32> %tmp_105, i32 0
  %tmp_157 = extractelement <2 x i32> %tmp_105, i32 1
  %tmp_159 = mul nsw i32 %tmp_157, %tmp_10
  %tmp_160 = add nsw i32 %tmp_155, %tmp_159
  %tmp_162 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %tmp_160
  %tmp_163 = load <4 x i32> addrspace(1)* %tmp_162, align 16
  %tmp_164 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %tmp_163)
  br label %tmp_165

tmp_165:                                          ; preds = %tmp_153, %tmp_149, %tmp_145
  %sumD.0 = phi <4 x i32> [ %tmp_164, %tmp_153 ], [ zeroinitializer, %tmp_149 ], [ zeroinitializer, %tmp_145 ]
  %tmp_167 = extractelement <2 x i32> %tmp_75, i32 0
  %tmp_169 = extractelement <2 x i32> %tmp_75, i32 1
  %tmp_171 = mul nsw i32 %tmp_169, %tmp_10
  %tmp_172 = add nsw i32 %tmp_167, %tmp_171
  %tmp_174 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %tmp_172
  %tmp_175 = load <4 x i32> addrspace(1)* %tmp_174, align 16
  %tmp_176 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %tmp_175)
  %tmp_179 = add <4 x i32> %sumA.0, %tmp_176
  %tmp_181 = sub <4 x i32> %tmp_179, %sumB.0
  %tmp_183 = sub <4 x i32> %tmp_181, %sumD.0
  %tmp_185 = sdiv <4 x i32> %tmp_183, %tmp_49
  %tmp_186 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %tmp_185)
  %tmp_190 = mul nsw i32 %tmp_9, %tmp_10
  %tmp_191 = add nsw i32 %tmp_8, %tmp_190
  %tmp_193 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_191
  store <4 x i8> %tmp_186, <4 x i8> addrspace(1)* %tmp_193, align 4
  br label %tmp_194

tmp_194:                                          ; preds = %tmp_165, %tmp_36
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32>) #1

declare <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind
define void @horizontalSAT0(<4 x i8> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_7 = call i32 @__get_global_id_u32(i32 1)
  %tmp_11 = mul nsw i32 %tmp_7, %width
  %tmp_12 = add nsw i32 %tmp_6, %tmp_11
  %tmp_14 = sitofp i32 %r to float
  %tmp_16 = sitofp i32 %i to float
  %tmp_17 = call float @llvm.pow.f32(float %tmp_14, float %tmp_16)
  %tmp_18 = fptosi float %tmp_17 to i32
  br label %tmp_19

tmp_19:                                           ; preds = %tmp_47, %0
  %sum.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %tmp_46, %tmp_47 ]
  %j.0 = phi i32 [ 0, %0 ], [ %tmp_49, %tmp_47 ]
  %tmp_22 = icmp slt i32 %j.0, %r
  br i1 %tmp_22, label %tmp_23, label %tmp_50

tmp_23:                                           ; preds = %tmp_19
  %tmp_27 = mul nsw i32 %j.0, %tmp_18
  %tmp_28 = sub nsw i32 %tmp_6, %tmp_27
  %tmp_29 = icmp slt i32 %tmp_28, 0
  br i1 %tmp_29, label %tmp_30, label %tmp_35

tmp_30:                                           ; preds = %tmp_23
  %tmp_34 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %tmp_12
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %tmp_34, align 16
  br label %tmp_55

tmp_35:                                           ; preds = %tmp_23
  %tmp_39 = mul nsw i32 %j.0, %tmp_18
  %tmp_40 = sub nsw i32 %tmp_12, %tmp_39
  %tmp_42 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %tmp_40
  %tmp_43 = load <4 x i8> addrspace(1)* %tmp_42, align 4
  %tmp_44 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %tmp_43)
  %tmp_46 = add <4 x i32> %sum.0, %tmp_44
  br label %tmp_47

tmp_47:                                           ; preds = %tmp_35
  %tmp_49 = add nsw i32 %j.0, 1
  br label %tmp_19

tmp_50:                                           ; preds = %tmp_19
  %tmp_54 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %tmp_12
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %tmp_54, align 16
  br label %tmp_55

tmp_55:                                           ; preds = %tmp_50, %tmp_30
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #2

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @horizontalSAT(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_7 = call i32 @__get_global_id_u32(i32 1)
  %tmp_11 = mul nsw i32 %tmp_7, %width
  %tmp_12 = add nsw i32 %tmp_6, %tmp_11
  %tmp_14 = sitofp i32 %r to float
  %tmp_16 = sitofp i32 %i to float
  %tmp_17 = call float @llvm.pow.f32(float %tmp_14, float %tmp_16)
  %tmp_18 = fptosi float %tmp_17 to i32
  br label %tmp_19

tmp_19:                                           ; preds = %tmp_46, %0
  %sum.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %tmp_45, %tmp_46 ]
  %j.0 = phi i32 [ 0, %0 ], [ %tmp_48, %tmp_46 ]
  %tmp_22 = icmp slt i32 %j.0, %r
  br i1 %tmp_22, label %tmp_23, label %tmp_49

tmp_23:                                           ; preds = %tmp_19
  %tmp_27 = mul nsw i32 %j.0, %tmp_18
  %tmp_28 = sub nsw i32 %tmp_6, %tmp_27
  %tmp_29 = icmp slt i32 %tmp_28, 0
  br i1 %tmp_29, label %tmp_30, label %tmp_35

tmp_30:                                           ; preds = %tmp_23
  %tmp_34 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %tmp_12
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %tmp_34, align 16
  br label %tmp_54

tmp_35:                                           ; preds = %tmp_23
  %tmp_39 = mul nsw i32 %j.0, %tmp_18
  %tmp_40 = sub nsw i32 %tmp_12, %tmp_39
  %tmp_42 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %tmp_40
  %tmp_43 = load <4 x i32> addrspace(1)* %tmp_42, align 16
  %tmp_45 = add <4 x i32> %sum.0, %tmp_43
  br label %tmp_46

tmp_46:                                           ; preds = %tmp_35
  %tmp_48 = add nsw i32 %j.0, 1
  br label %tmp_19

tmp_49:                                           ; preds = %tmp_19
  %tmp_53 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %tmp_12
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %tmp_53, align 16
  br label %tmp_54

tmp_54:                                           ; preds = %tmp_49, %tmp_30
  ret void
}

; Function Attrs: nounwind
define void @verticalSAT(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_7 = call i32 @__get_global_id_u32(i32 1)
  %tmp_9 = sitofp i32 %r to float
  %tmp_11 = sitofp i32 %i to float
  %tmp_12 = call float @llvm.pow.f32(float %tmp_9, float %tmp_11)
  %tmp_13 = fptosi float %tmp_12 to i32
  br label %tmp_14

tmp_14:                                           ; preds = %tmp_49, %0
  %sum.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %tmp_48, %tmp_49 ]
  %j.0 = phi i32 [ 0, %0 ], [ %tmp_51, %tmp_49 ]
  %tmp_17 = icmp slt i32 %j.0, %r
  br i1 %tmp_17, label %tmp_18, label %tmp_52

tmp_18:                                           ; preds = %tmp_14
  %tmp_22 = mul nsw i32 %j.0, %tmp_13
  %tmp_23 = sub nsw i32 %tmp_7, %tmp_22
  %tmp_24 = icmp slt i32 %tmp_23, 0
  br i1 %tmp_24, label %tmp_25, label %tmp_34

tmp_25:                                           ; preds = %tmp_18
  %tmp_30 = mul nsw i32 %tmp_7, %width
  %tmp_31 = add nsw i32 %tmp_6, %tmp_30
  %tmp_33 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %tmp_31
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %tmp_33, align 16
  br label %tmp_61

tmp_34:                                           ; preds = %tmp_18
  %tmp_40 = mul nsw i32 %j.0, %tmp_13
  %tmp_41 = sub nsw i32 %tmp_7, %tmp_40
  %tmp_42 = mul nsw i32 %width, %tmp_41
  %tmp_43 = add nsw i32 %tmp_6, %tmp_42
  %tmp_45 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %tmp_43
  %tmp_46 = load <4 x i32> addrspace(1)* %tmp_45, align 16
  %tmp_48 = add <4 x i32> %sum.0, %tmp_46
  br label %tmp_49

tmp_49:                                           ; preds = %tmp_34
  %tmp_51 = add nsw i32 %j.0, 1
  br label %tmp_14

tmp_52:                                           ; preds = %tmp_14
  %tmp_57 = mul nsw i32 %tmp_7, %width
  %tmp_58 = add nsw i32 %tmp_6, %tmp_57
  %tmp_60 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %tmp_58
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %tmp_60, align 16
  br label %tmp_61

tmp_61:                                           ; preds = %tmp_52, %tmp_25
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = call i32 @__get_global_id_u32(i32 1)
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  %tmp_7 = call i32 @__get_global_size_u32(i32 1)
  %tmp_11 = mul nsw i32 %tmp_5, %tmp_6
  %tmp_12 = add nsw i32 %tmp_4, %tmp_11
  %tmp_14 = sub nsw i32 %filterWidth, 1
  %tmp_15 = sdiv i32 %tmp_14, 2
  %tmp_18 = icmp slt i32 %tmp_4, %tmp_15
  br i1 %tmp_18, label %tmp_25, label %tmp_19

tmp_19:                                           ; preds = %0
  %tmp_23 = sub nsw i32 %tmp_6, %tmp_15
  %tmp_24 = icmp sge i32 %tmp_4, %tmp_23
  br i1 %tmp_24, label %tmp_25, label %tmp_29

tmp_25:                                           ; preds = %tmp_19, %0
  %tmp_28 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_12
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %tmp_28, align 4
  br label %tmp_79

tmp_29:                                           ; preds = %tmp_19
  %tmp_31 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %tmp_32 = shufflevector <4 x i32> %tmp_31, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_34 = sub nsw i32 0, %tmp_15
  br label %tmp_35

tmp_35:                                           ; preds = %tmp_59, %tmp_29
  %sum.0 = phi <4 x i32> [ zeroinitializer, %tmp_29 ], [ %tmp_58, %tmp_59 ]
  %X.0 = phi i32 [ %tmp_34, %tmp_29 ], [ %tmp_61, %tmp_59 ]
  %tmp_38 = icmp slt i32 %X.0, %tmp_15
  br i1 %tmp_38, label %tmp_39, label %tmp_62

tmp_39:                                           ; preds = %tmp_35
  %tmp_42 = add nsw i32 %tmp_12, %X.0
  %tmp_44 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_42
  %tmp_45 = load <4 x i8> addrspace(1)* %tmp_44, align 4
  %tmp_46 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_45)
  %tmp_48 = add <4 x i32> %sum.0, %tmp_46
  %tmp_51 = add nsw i32 %tmp_12, %X.0
  %tmp_52 = add nsw i32 %tmp_51, 1
  %tmp_54 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_52
  %tmp_55 = load <4 x i8> addrspace(1)* %tmp_54, align 4
  %tmp_56 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_55)
  %tmp_58 = add <4 x i32> %tmp_48, %tmp_56
  br label %tmp_59

tmp_59:                                           ; preds = %tmp_39
  %tmp_61 = add nsw i32 %X.0, 2
  br label %tmp_35

tmp_62:                                           ; preds = %tmp_35
  %tmp_65 = add nsw i32 %tmp_12, %tmp_15
  %tmp_67 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_65
  %tmp_68 = load <4 x i8> addrspace(1)* %tmp_67, align 4
  %tmp_69 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_68)
  %tmp_71 = add <4 x i32> %sum.0, %tmp_69
  %tmp_74 = sdiv <4 x i32> %tmp_71, %tmp_32
  %tmp_75 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %tmp_74)
  %tmp_78 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_12
  store <4 x i8> %tmp_75, <4 x i8> addrspace(1)* %tmp_78, align 4
  br label %tmp_79

tmp_79:                                           ; preds = %tmp_62, %tmp_25
  ret void
}

declare <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @box_filter_vertical(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = call i32 @__get_global_id_u32(i32 1)
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  %tmp_7 = call i32 @__get_global_size_u32(i32 1)
  %tmp_11 = mul nsw i32 %tmp_5, %tmp_6
  %tmp_12 = add nsw i32 %tmp_4, %tmp_11
  %tmp_14 = sub nsw i32 %filterWidth, 1
  %tmp_15 = sdiv i32 %tmp_14, 2
  %tmp_18 = icmp slt i32 %tmp_5, %tmp_15
  br i1 %tmp_18, label %tmp_25, label %tmp_19

tmp_19:                                           ; preds = %0
  %tmp_23 = sub nsw i32 %tmp_7, %tmp_15
  %tmp_24 = icmp sge i32 %tmp_5, %tmp_23
  br i1 %tmp_24, label %tmp_25, label %tmp_29

tmp_25:                                           ; preds = %tmp_19, %0
  %tmp_28 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_12
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %tmp_28, align 4
  br label %tmp_85

tmp_29:                                           ; preds = %tmp_19
  %tmp_31 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %tmp_32 = shufflevector <4 x i32> %tmp_31, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_34 = sub nsw i32 0, %tmp_15
  br label %tmp_35

tmp_35:                                           ; preds = %tmp_63, %tmp_29
  %sum.0 = phi <4 x i32> [ zeroinitializer, %tmp_29 ], [ %tmp_62, %tmp_63 ]
  %Y.0 = phi i32 [ %tmp_34, %tmp_29 ], [ %tmp_65, %tmp_63 ]
  %tmp_38 = icmp slt i32 %Y.0, %tmp_15
  br i1 %tmp_38, label %tmp_39, label %tmp_66

tmp_39:                                           ; preds = %tmp_35
  %tmp_43 = mul nsw i32 %Y.0, %tmp_6
  %tmp_44 = add nsw i32 %tmp_12, %tmp_43
  %tmp_46 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_44
  %tmp_47 = load <4 x i8> addrspace(1)* %tmp_46, align 4
  %tmp_48 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_47)
  %tmp_50 = add <4 x i32> %sum.0, %tmp_48
  %tmp_53 = add nsw i32 %Y.0, 1
  %tmp_55 = mul nsw i32 %tmp_53, %tmp_6
  %tmp_56 = add nsw i32 %tmp_12, %tmp_55
  %tmp_58 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_56
  %tmp_59 = load <4 x i8> addrspace(1)* %tmp_58, align 4
  %tmp_60 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_59)
  %tmp_62 = add <4 x i32> %tmp_50, %tmp_60
  br label %tmp_63

tmp_63:                                           ; preds = %tmp_39
  %tmp_65 = add nsw i32 %Y.0, 2
  br label %tmp_35

tmp_66:                                           ; preds = %tmp_35
  %tmp_70 = mul nsw i32 %tmp_15, %tmp_6
  %tmp_71 = add nsw i32 %tmp_12, %tmp_70
  %tmp_73 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_71
  %tmp_74 = load <4 x i8> addrspace(1)* %tmp_73, align 4
  %tmp_75 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_74)
  %tmp_77 = add <4 x i32> %sum.0, %tmp_75
  %tmp_80 = sdiv <4 x i32> %tmp_77, %tmp_32
  %tmp_81 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %tmp_80)
  %tmp_84 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_12
  store <4 x i8> %tmp_81, <4 x i8> addrspace(1)* %tmp_84, align 4
  br label %tmp_85

tmp_85:                                           ; preds = %tmp_66, %tmp_25
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal_local(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth, <4 x i8> addrspace(3)* %lds) #0 {
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_id_u32(i32 1)
  %tmp_7 = call i32 @__get_global_size_u32(i32 0)
  %tmp_8 = call i32 @__get_global_size_u32(i32 1)
  %tmp_12 = mul nsw i32 %tmp_6, %tmp_7
  %tmp_13 = add nsw i32 %tmp_5, %tmp_12
  %tmp_15 = sub nsw i32 %filterWidth, 1
  %tmp_16 = sdiv i32 %tmp_15, 2
  %tmp_17 = call i32 @__get_local_id_u32(i32 0)
  %tmp_18 = call i32 @__get_group_id_u32(i32 0)
  %tmp_19 = call i32 @__get_group_id_u32(i32 1)
  %tmp_20 = call i32 @__get_local_size_u32(i32 0)
  %tmp_21 = call i32 @__get_local_size_u32(i32 1)
  %tmp_24 = mul nsw i32 %tmp_20, %tmp_18
  %tmp_27 = mul nsw i32 %tmp_7, %tmp_19
  %tmp_29 = mul nsw i32 %tmp_27, %tmp_21
  %tmp_30 = add nsw i32 %tmp_24, %tmp_29
  %tmp_33 = icmp slt i32 %tmp_17, %tmp_16
  br i1 %tmp_33, label %tmp_34, label %tmp_59

tmp_34:                                           ; preds = %0
  %tmp_37 = sub nsw i32 %tmp_30, %tmp_16
  %tmp_39 = add nsw i32 %tmp_37, %tmp_17
  %tmp_41 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_39
  %tmp_42 = load <4 x i8> addrspace(1)* %tmp_41, align 4
  %tmp_45 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %tmp_17
  store <4 x i8> %tmp_42, <4 x i8> addrspace(3)* %tmp_45, align 4
  %tmp_48 = add nsw i32 %tmp_30, %tmp_17
  %tmp_49 = add nsw i32 %tmp_48, 256
  %tmp_51 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_49
  %tmp_52 = load <4 x i8> addrspace(1)* %tmp_51, align 4
  %tmp_54 = add nsw i32 256, %tmp_16
  %tmp_56 = add nsw i32 %tmp_54, %tmp_17
  %tmp_58 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %tmp_56
  store <4 x i8> %tmp_52, <4 x i8> addrspace(3)* %tmp_58, align 4
  br label %tmp_59

tmp_59:                                           ; preds = %tmp_34, %0
  %tmp_62 = add nsw i32 %tmp_30, %tmp_17
  %tmp_64 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_62
  %tmp_65 = load <4 x i8> addrspace(1)* %tmp_64, align 4
  %tmp_68 = add nsw i32 %tmp_17, %tmp_16
  %tmp_70 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %tmp_68
  store <4 x i8> %tmp_65, <4 x i8> addrspace(3)* %tmp_70, align 4
  call void @barrier(i32 1)
  %tmp_73 = icmp slt i32 %tmp_5, %tmp_16
  br i1 %tmp_73, label %tmp_80, label %tmp_74

tmp_74:                                           ; preds = %tmp_59
  %tmp_78 = sub nsw i32 %tmp_7, %tmp_16
  %tmp_79 = icmp sge i32 %tmp_5, %tmp_78
  br i1 %tmp_79, label %tmp_80, label %tmp_81

tmp_80:                                           ; preds = %tmp_74, %tmp_59
  br label %tmp_114

tmp_81:                                           ; preds = %tmp_74
  %tmp_83 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %tmp_84 = shufflevector <4 x i32> %tmp_83, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_86 = sub nsw i32 0, %tmp_16
  br label %tmp_87

tmp_87:                                           ; preds = %tmp_103, %tmp_81
  %sum.0 = phi <4 x i32> [ zeroinitializer, %tmp_81 ], [ %tmp_102, %tmp_103 ]
  %X.0 = phi i32 [ %tmp_86, %tmp_81 ], [ %tmp_105, %tmp_103 ]
  %tmp_90 = icmp sle i32 %X.0, %tmp_16
  br i1 %tmp_90, label %tmp_91, label %tmp_106

tmp_91:                                           ; preds = %tmp_87
  %tmp_94 = add nsw i32 %tmp_17, %X.0
  %tmp_96 = add nsw i32 %tmp_94, %tmp_16
  %tmp_98 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %tmp_96
  %tmp_99 = load <4 x i8> addrspace(3)* %tmp_98, align 4
  %tmp_100 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %tmp_99)
  %tmp_102 = add <4 x i32> %sum.0, %tmp_100
  br label %tmp_103

tmp_103:                                          ; preds = %tmp_91
  %tmp_105 = add nsw i32 %X.0, 1
  br label %tmp_87

tmp_106:                                          ; preds = %tmp_87
  %tmp_109 = sdiv <4 x i32> %sum.0, %tmp_84
  %tmp_110 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %tmp_109)
  %tmp_113 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_13
  store <4 x i8> %tmp_110, <4 x i8> addrspace(1)* %tmp_113, align 4
  br label %tmp_114

tmp_114:                                          ; preds = %tmp_106, %tmp_80
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

; ModuleID = 'HistogramAtomics_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@histogramKernel_Vector.subhists = internal addrspace(3) global [4096 x i32] zeroinitializer, align 4
@histogramKernel_Scalar.subhists = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @histogramKernel_Vector(<4 x i32> addrspace(1)* %Image, i32 addrspace(1)* %Histogram, i32 %n4VectorsPerThread) #0 {
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  %tmp_9 = urem i32 %tmp_5, 16
  br label %tmp_11

tmp_11:                                           ; preds = %tmp_20, %0
  %i.0 = phi i32 [ %tmp_5, %0 ], [ %tmp_23, %tmp_20 ]
  %tmp_14 = udiv i32 4096, 4
  %tmp_15 = icmp ult i32 %i.0, %tmp_14
  br i1 %tmp_15, label %tmp_16, label %tmp_24

tmp_16:                                           ; preds = %tmp_11
  %tmp_19 = getelementptr inbounds <4 x i32> addrspace(3)* bitcast ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists to <4 x i32> addrspace(3)*), i32 %i.0
  store <4 x i32> zeroinitializer, <4 x i32> addrspace(3)* %tmp_19, align 16
  br label %tmp_20

tmp_20:                                           ; preds = %tmp_16
  %tmp_23 = add i32 %i.0, %tmp_7
  br label %tmp_11

tmp_24:                                           ; preds = %tmp_11
  call void @barrier(i32 1)
  br label %tmp_25

tmp_25:                                           ; preds = %tmp_136, %tmp_24
  %i.1 = phi i32 [ 0, %tmp_24 ], [ %tmp_138, %tmp_136 ]
  %tmp_28 = icmp ult i32 %i.1, %n4VectorsPerThread
  br i1 %tmp_28, label %tmp_29, label %tmp_139

tmp_29:                                           ; preds = %tmp_25
  %tmp_33 = mul i32 %i.1, %tmp_6
  %tmp_34 = add i32 %tmp_4, %tmp_33
  %tmp_36 = getelementptr inbounds <4 x i32> addrspace(1)* %Image, i32 %tmp_34
  %tmp_37 = load <4 x i32> addrspace(1)* %tmp_36, align 16
  %tmp_39 = and <4 x i32> %tmp_37, <i32 255, i32 255, i32 255, i32 255>
  %tmp_40 = mul <4 x i32> %tmp_39, <i32 16, i32 16, i32 16, i32 16>
  %tmp_42 = insertelement <4 x i32> undef, i32 %tmp_9, i32 0
  %tmp_43 = shufflevector <4 x i32> %tmp_42, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_44 = add <4 x i32> %tmp_40, %tmp_43
  %tmp_46 = extractelement <4 x i32> %tmp_44, i32 0
  %tmp_47 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_46
  %tmp_48 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_47)
  %tmp_50 = extractelement <4 x i32> %tmp_44, i32 1
  %tmp_51 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_50
  %tmp_52 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_51)
  %tmp_54 = extractelement <4 x i32> %tmp_44, i32 2
  %tmp_55 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_54
  %tmp_56 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_55)
  %tmp_58 = extractelement <4 x i32> %tmp_44, i32 3
  %tmp_59 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_58
  %tmp_60 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_59)
  %tmp_62 = lshr <4 x i32> %tmp_37, <i32 8, i32 8, i32 8, i32 8>
  %tmp_64 = and <4 x i32> %tmp_62, <i32 255, i32 255, i32 255, i32 255>
  %tmp_65 = mul <4 x i32> %tmp_64, <i32 16, i32 16, i32 16, i32 16>
  %tmp_67 = insertelement <4 x i32> undef, i32 %tmp_9, i32 0
  %tmp_68 = shufflevector <4 x i32> %tmp_67, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_69 = add <4 x i32> %tmp_65, %tmp_68
  %tmp_71 = extractelement <4 x i32> %tmp_69, i32 0
  %tmp_72 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_71
  %tmp_73 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_72)
  %tmp_75 = extractelement <4 x i32> %tmp_69, i32 1
  %tmp_76 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_75
  %tmp_77 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_76)
  %tmp_79 = extractelement <4 x i32> %tmp_69, i32 2
  %tmp_80 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_79
  %tmp_81 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_80)
  %tmp_83 = extractelement <4 x i32> %tmp_69, i32 3
  %tmp_84 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_83
  %tmp_85 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_84)
  %tmp_87 = lshr <4 x i32> %tmp_62, <i32 8, i32 8, i32 8, i32 8>
  %tmp_89 = and <4 x i32> %tmp_87, <i32 255, i32 255, i32 255, i32 255>
  %tmp_90 = mul <4 x i32> %tmp_89, <i32 16, i32 16, i32 16, i32 16>
  %tmp_92 = insertelement <4 x i32> undef, i32 %tmp_9, i32 0
  %tmp_93 = shufflevector <4 x i32> %tmp_92, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_94 = add <4 x i32> %tmp_90, %tmp_93
  %tmp_96 = extractelement <4 x i32> %tmp_94, i32 0
  %tmp_97 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_96
  %tmp_98 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_97)
  %tmp_100 = extractelement <4 x i32> %tmp_94, i32 1
  %tmp_101 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_100
  %tmp_102 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_101)
  %tmp_104 = extractelement <4 x i32> %tmp_94, i32 2
  %tmp_105 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_104
  %tmp_106 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_105)
  %tmp_108 = extractelement <4 x i32> %tmp_94, i32 3
  %tmp_109 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_108
  %tmp_110 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_109)
  %tmp_112 = lshr <4 x i32> %tmp_87, <i32 8, i32 8, i32 8, i32 8>
  %tmp_114 = and <4 x i32> %tmp_112, <i32 255, i32 255, i32 255, i32 255>
  %tmp_115 = mul <4 x i32> %tmp_114, <i32 16, i32 16, i32 16, i32 16>
  %tmp_117 = insertelement <4 x i32> undef, i32 %tmp_9, i32 0
  %tmp_118 = shufflevector <4 x i32> %tmp_117, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_119 = add <4 x i32> %tmp_115, %tmp_118
  %tmp_121 = extractelement <4 x i32> %tmp_119, i32 0
  %tmp_122 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_121
  %tmp_123 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_122)
  %tmp_125 = extractelement <4 x i32> %tmp_119, i32 1
  %tmp_126 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_125
  %tmp_127 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_126)
  %tmp_129 = extractelement <4 x i32> %tmp_119, i32 2
  %tmp_130 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_129
  %tmp_131 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_130)
  %tmp_133 = extractelement <4 x i32> %tmp_119, i32 3
  %tmp_134 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_133
  %tmp_135 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_134)
  br label %tmp_136

tmp_136:                                          ; preds = %tmp_29
  %tmp_138 = add i32 %i.1, 1
  br label %tmp_25

tmp_139:                                          ; preds = %tmp_25
  call void @barrier(i32 1)
  br label %tmp_141

tmp_141:                                          ; preds = %tmp_172, %tmp_139
  %i.2 = phi i32 [ %tmp_5, %tmp_139 ], [ %tmp_175, %tmp_172 ]
  %tmp_143 = icmp ult i32 %i.2, 256
  br i1 %tmp_143, label %tmp_144, label %tmp_176

tmp_144:                                          ; preds = %tmp_141
  br label %tmp_146

tmp_146:                                          ; preds = %tmp_159, %tmp_144
  %bin.0 = phi i32 [ 0, %tmp_144 ], [ %tmp_158, %tmp_159 ]
  %off.0 = phi i32 [ %tmp_9, %tmp_144 ], [ %tmp_163, %tmp_159 ]
  %j.0 = phi i32 [ 0, %tmp_144 ], [ %tmp_161, %tmp_159 ]
  %tmp_148 = icmp slt i32 %j.0, 16
  br i1 %tmp_148, label %tmp_149, label %tmp_164

tmp_149:                                          ; preds = %tmp_146
  %tmp_151 = mul i32 %i.2, 16
  %tmp_153 = urem i32 %off.0, 16
  %tmp_154 = add i32 %tmp_151, %tmp_153
  %tmp_155 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %tmp_154
  %tmp_156 = load i32 addrspace(3)* %tmp_155, align 4
  %tmp_158 = add i32 %bin.0, %tmp_156
  br label %tmp_159

tmp_159:                                          ; preds = %tmp_149
  %tmp_161 = add nsw i32 %j.0, 1
  %tmp_163 = add i32 %off.0, 1
  br label %tmp_146

tmp_164:                                          ; preds = %tmp_146
  %tmp_166 = call i32 @__get_group_id_u32(i32 0)
  %tmp_167 = mul i32 %tmp_166, 256
  %tmp_169 = add i32 %tmp_167, %i.2
  %tmp_171 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %tmp_169
  store i32 %bin.0, i32 addrspace(1)* %tmp_171, align 4
  br label %tmp_172

tmp_172:                                          ; preds = %tmp_164
  %tmp_175 = add i32 %i.2, %tmp_7
  br label %tmp_141

tmp_176:                                          ; preds = %tmp_141
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)*) #1

declare i32 @__get_group_id_u32(i32) #1

; Function Attrs: nounwind
define void @histogramKernel_Scalar(i32 addrspace(1)* %Image, i32 addrspace(1)* %Histogram, i32 %nVectorsPerThread) #0 {
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  %tmp_9 = urem i32 %tmp_5, 4
  br label %tmp_11

tmp_11:                                           ; preds = %tmp_19, %0
  %i.0 = phi i32 [ %tmp_5, %0 ], [ %tmp_22, %tmp_19 ]
  %tmp_14 = icmp ult i32 %i.0, 1024
  br i1 %tmp_14, label %tmp_15, label %tmp_23

tmp_15:                                           ; preds = %tmp_11
  %tmp_18 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %i.0
  store i32 0, i32 addrspace(3)* %tmp_18, align 4
  br label %tmp_19

tmp_19:                                           ; preds = %tmp_15
  %tmp_22 = add i32 %i.0, %tmp_7
  br label %tmp_11

tmp_23:                                           ; preds = %tmp_11
  call void @barrier(i32 1)
  br label %tmp_24

tmp_24:                                           ; preds = %tmp_75, %tmp_23
  %i.1 = phi i32 [ 0, %tmp_23 ], [ %tmp_77, %tmp_75 ]
  %tmp_27 = icmp ult i32 %i.1, %nVectorsPerThread
  br i1 %tmp_27, label %tmp_28, label %tmp_78

tmp_28:                                           ; preds = %tmp_24
  %tmp_32 = mul i32 %i.1, %tmp_6
  %tmp_33 = add i32 %tmp_4, %tmp_32
  %tmp_35 = getelementptr inbounds i32 addrspace(1)* %Image, i32 %tmp_33
  %tmp_36 = load i32 addrspace(1)* %tmp_35, align 4
  %tmp_38 = and i32 %tmp_36, 255
  %tmp_39 = mul i32 %tmp_38, 4
  %tmp_41 = add i32 %tmp_39, %tmp_9
  %tmp_43 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %tmp_41
  %tmp_44 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_43)
  %tmp_46 = lshr i32 %tmp_36, 8
  %tmp_48 = and i32 %tmp_46, 255
  %tmp_49 = mul i32 %tmp_48, 4
  %tmp_51 = add i32 %tmp_49, %tmp_9
  %tmp_53 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %tmp_51
  %tmp_54 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_53)
  %tmp_56 = lshr i32 %tmp_46, 8
  %tmp_58 = and i32 %tmp_56, 255
  %tmp_59 = mul i32 %tmp_58, 4
  %tmp_61 = add i32 %tmp_59, %tmp_9
  %tmp_63 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %tmp_61
  %tmp_64 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_63)
  %tmp_66 = lshr i32 %tmp_56, 8
  %tmp_68 = and i32 %tmp_66, 255
  %tmp_69 = mul i32 %tmp_68, 4
  %tmp_71 = add i32 %tmp_69, %tmp_9
  %tmp_73 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %tmp_71
  %tmp_74 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_73)
  br label %tmp_75

tmp_75:                                           ; preds = %tmp_28
  %tmp_77 = add i32 %i.1, 1
  br label %tmp_24

tmp_78:                                           ; preds = %tmp_24
  call void @barrier(i32 1)
  br label %tmp_80

tmp_80:                                           ; preds = %tmp_111, %tmp_78
  %i.2 = phi i32 [ %tmp_5, %tmp_78 ], [ %tmp_114, %tmp_111 ]
  %tmp_82 = icmp ult i32 %i.2, 256
  br i1 %tmp_82, label %tmp_83, label %tmp_115

tmp_83:                                           ; preds = %tmp_80
  br label %tmp_85

tmp_85:                                           ; preds = %tmp_98, %tmp_83
  %bin.0 = phi i32 [ 0, %tmp_83 ], [ %tmp_97, %tmp_98 ]
  %off.0 = phi i32 [ %tmp_9, %tmp_83 ], [ %tmp_102, %tmp_98 ]
  %j1.0 = phi i32 [ 0, %tmp_83 ], [ %tmp_100, %tmp_98 ]
  %tmp_87 = icmp slt i32 %j1.0, 4
  br i1 %tmp_87, label %tmp_88, label %tmp_103

tmp_88:                                           ; preds = %tmp_85
  %tmp_90 = mul i32 %i.2, 4
  %tmp_92 = urem i32 %off.0, 4
  %tmp_93 = add i32 %tmp_90, %tmp_92
  %tmp_94 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %tmp_93
  %tmp_95 = load i32 addrspace(3)* %tmp_94, align 4
  %tmp_97 = add i32 %bin.0, %tmp_95
  br label %tmp_98

tmp_98:                                           ; preds = %tmp_88
  %tmp_100 = add nsw i32 %j1.0, 1
  %tmp_102 = add i32 %off.0, 1
  br label %tmp_85

tmp_103:                                          ; preds = %tmp_85
  %tmp_105 = call i32 @__get_group_id_u32(i32 0)
  %tmp_106 = mul i32 %tmp_105, 256
  %tmp_108 = add i32 %tmp_106, %i.2
  %tmp_110 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %tmp_108
  store i32 %bin.0, i32 addrspace(1)* %tmp_110, align 4
  br label %tmp_111

tmp_111:                                          ; preds = %tmp_103
  %tmp_114 = add i32 %i.2, %tmp_7
  br label %tmp_80

tmp_115:                                          ; preds = %tmp_80
  ret void
}

; Function Attrs: nounwind
define void @reduceKernel(i32 addrspace(1)* %Histogram, i32 %nSubHists) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  br label %tmp_4

tmp_4:                                            ; preds = %tmp_45, %0
  %bin.0 = phi i32 [ 0, %0 ], [ %tmp_44, %tmp_45 ]
  %i.0 = phi i32 [ 0, %0 ], [ %tmp_47, %tmp_45 ]
  %tmp_7 = icmp ult i32 %i.0, %nSubHists
  br i1 %tmp_7, label %tmp_8, label %tmp_48

tmp_8:                                            ; preds = %tmp_4
  %tmp_10 = mul nsw i32 %i.0, 256
  %tmp_12 = add i32 %tmp_10, %tmp_3
  %tmp_14 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %tmp_12
  %tmp_15 = load i32 addrspace(1)* %tmp_14, align 4
  %tmp_17 = mul nsw i32 %i.0, 256
  %tmp_19 = add i32 %tmp_17, %tmp_3
  %tmp_20 = add i32 %tmp_19, 256
  %tmp_22 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %tmp_20
  %tmp_23 = load i32 addrspace(1)* %tmp_22, align 4
  %tmp_24 = add i32 %tmp_15, %tmp_23
  %tmp_26 = mul nsw i32 %i.0, 256
  %tmp_28 = add i32 %tmp_26, %tmp_3
  %tmp_29 = add i32 %tmp_28, 512
  %tmp_31 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %tmp_29
  %tmp_32 = load i32 addrspace(1)* %tmp_31, align 4
  %tmp_33 = add i32 %tmp_24, %tmp_32
  %tmp_35 = mul nsw i32 %i.0, 256
  %tmp_37 = add i32 %tmp_35, %tmp_3
  %tmp_38 = add i32 %tmp_37, 768
  %tmp_40 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %tmp_38
  %tmp_41 = load i32 addrspace(1)* %tmp_40, align 4
  %tmp_42 = add i32 %tmp_33, %tmp_41
  %tmp_44 = add i32 %bin.0, %tmp_42
  br label %tmp_45

tmp_45:                                           ; preds = %tmp_8
  %tmp_47 = add nsw i32 %i.0, 4
  br label %tmp_4

tmp_48:                                           ; preds = %tmp_4
  %tmp_52 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %tmp_3
  store i32 %bin.0, i32 addrspace(1)* %tmp_52, align 4
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32)* @histogramKernel_Vector}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @histogramKernel_Scalar}
!2 = metadata !{void (i32 addrspace(1)*, i32)* @reduceKernel}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

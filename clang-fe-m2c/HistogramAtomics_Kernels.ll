; ModuleID = '../kernel-src/HistogramAtomics_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@histogramKernel_Vector.subhists = internal addrspace(3) global [4096 x i32] zeroinitializer, align 4
@histogramKernel_Scalar.subhists = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @histogramKernel_Vector(<4 x i32> addrspace(1)* %Image, i32 addrspace(1)* %Histogram, i32 %n4VectorsPerThread) #0 {
  %tmp_1 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tid = alloca i32, align 4
  %ltid = alloca i32, align 4
  %Stride = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %i = alloca i32, align 4
  %temp = alloca <4 x i32>, align 16
  %temp2 = alloca <4 x i32>, align 16
  %shft = alloca i32, align 4
  %msk = alloca i32, align 4
  %offset = alloca i32, align 4
  %lmem_items = alloca i32, align 4
  %p = alloca <4 x i32> addrspace(3)*, align 4
  %bin = alloca i32, align 4
  %off = alloca i32, align 4
  %j = alloca i32, align 4
  store <4 x i32> addrspace(1)* %Image, <4 x i32> addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %Histogram, i32 addrspace(1)** %tmp_2, align 4
  store i32 %n4VectorsPerThread, i32* %tmp_3, align 4
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_4, i32* %tid, align 4
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_5, i32* %ltid, align 4
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_6, i32* %Stride, align 4
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_7, i32* %groupSize, align 4
  store i32 8, i32* %shft, align 4
  store i32 255, i32* %msk, align 4
  %tmp_8 = load i32* %ltid, align 4
  %tmp_9 = urem i32 %tmp_8, 16
  store i32 %tmp_9, i32* %offset, align 4
  store i32 4096, i32* %lmem_items, align 4
  store <4 x i32> addrspace(3)* bitcast ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists to <4 x i32> addrspace(3)*), <4 x i32> addrspace(3)** %p, align 4
  %tmp_10 = load i32* %ltid, align 4
  store i32 %tmp_10, i32* %i, align 4
  br label %tmp_11

tmp_11:                                      ; preds = %tmp_20, %tmp_0
  %tmp_12 = load i32* %i, align 4
  %tmp_13 = load i32* %lmem_items, align 4
  %tmp_14 = udiv i32 %tmp_13, 4
  %tmp_15 = icmp ult i32 %tmp_12, %tmp_14
  br i1 %tmp_15, label %tmp_16, label %tmp_24

tmp_16:                                      ; preds = %tmp_11
  %tmp_17 = load i32* %i, align 4
  %tmp_18 = load <4 x i32> addrspace(3)** %p, align 4
  %tmp_19 = getelementptr inbounds <4 x i32> addrspace(3)* %tmp_18, i32 %tmp_17
  store <4 x i32> zeroinitializer, <4 x i32> addrspace(3)* %tmp_19, align 16
  br label %tmp_20

tmp_20:                                      ; preds = %tmp_16
  %tmp_21 = load i32* %groupSize, align 4
  %tmp_22 = load i32* %i, align 4
  %tmp_23 = add i32 %tmp_22, %tmp_21
  store i32 %tmp_23, i32* %i, align 4
  br label %tmp_11

tmp_24:                                      ; preds = %tmp_11
  call void @barrier(i32 1)
  store i32 0, i32* %i, align 4
  br label %tmp_25

tmp_25:                                      ; preds = %tmp_136, %tmp_24
  %tmp_26 = load i32* %i, align 4
  %tmp_27 = load i32* %tmp_3, align 4
  %tmp_28 = icmp ult i32 %tmp_26, %tmp_27
  br i1 %tmp_28, label %tmp_29, label %tmp_139

tmp_29:                                      ; preds = %tmp_25
  %tmp_30 = load i32* %tid, align 4
  %tmp_31 = load i32* %i, align 4
  %tmp_32 = load i32* %Stride, align 4
  %tmp_33 = mul i32 %tmp_31, %tmp_32
  %tmp_34 = add i32 %tmp_30, %tmp_33
  %tmp_35 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_36 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_35, i32 %tmp_34
  %tmp_37 = load <4 x i32> addrspace(1)* %tmp_36, align 16
  store <4 x i32> %tmp_37, <4 x i32>* %temp, align 16
  %tmp_38 = load <4 x i32>* %temp, align 16
  %tmp_39 = and <4 x i32> %tmp_38, <i32 255, i32 255, i32 255, i32 255>
  %tmp_40 = mul <4 x i32> %tmp_39, <i32 16, i32 16, i32 16, i32 16>
  %tmp_41 = load i32* %offset, align 4
  %tmp_42 = insertelement <4 x i32> undef, i32 %tmp_41, i32 0
  %tmp_43 = shufflevector <4 x i32> %tmp_42, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_44 = add <4 x i32> %tmp_40, %tmp_43
  store <4 x i32> %tmp_44, <4 x i32>* %temp2, align 16
  %tmp_45 = load <4 x i32>* %temp2, align 16
  %tmp_46 = extractelement <4 x i32> %tmp_45, i32 0
  %tmp_47 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_46
  %tmp_48 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_47)
  %tmp_49 = load <4 x i32>* %temp2, align 16
  %tmp_50 = extractelement <4 x i32> %tmp_49, i32 1
  %tmp_51 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_50
  %tmp_52 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_51)
  %tmp_53 = load <4 x i32>* %temp2, align 16
  %tmp_54 = extractelement <4 x i32> %tmp_53, i32 2
  %tmp_55 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_54
  %tmp_56 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_55)
  %tmp_57 = load <4 x i32>* %temp2, align 16
  %tmp_58 = extractelement <4 x i32> %tmp_57, i32 3
  %tmp_59 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_58
  %tmp_60 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_59)
  %tmp_61 = load <4 x i32>* %temp, align 16
  %tmp_62 = lshr <4 x i32> %tmp_61, <i32 8, i32 8, i32 8, i32 8>
  store <4 x i32> %tmp_62, <4 x i32>* %temp, align 16
  %tmp_63 = load <4 x i32>* %temp, align 16
  %tmp_64 = and <4 x i32> %tmp_63, <i32 255, i32 255, i32 255, i32 255>
  %tmp_65 = mul <4 x i32> %tmp_64, <i32 16, i32 16, i32 16, i32 16>
  %tmp_66 = load i32* %offset, align 4
  %tmp_67 = insertelement <4 x i32> undef, i32 %tmp_66, i32 0
  %tmp_68 = shufflevector <4 x i32> %tmp_67, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_69 = add <4 x i32> %tmp_65, %tmp_68
  store <4 x i32> %tmp_69, <4 x i32>* %temp2, align 16
  %tmp_70 = load <4 x i32>* %temp2, align 16
  %tmp_71 = extractelement <4 x i32> %tmp_70, i32 0
  %tmp_72 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_71
  %tmp_73 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_72)
  %tmp_74 = load <4 x i32>* %temp2, align 16
  %tmp_75 = extractelement <4 x i32> %tmp_74, i32 1
  %tmp_76 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_75
  %tmp_77 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_76)
  %tmp_78 = load <4 x i32>* %temp2, align 16
  %tmp_79 = extractelement <4 x i32> %tmp_78, i32 2
  %tmp_80 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_79
  %tmp_81 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_80)
  %tmp_82 = load <4 x i32>* %temp2, align 16
  %tmp_83 = extractelement <4 x i32> %tmp_82, i32 3
  %tmp_84 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_83
  %tmp_85 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_84)
  %tmp_86 = load <4 x i32>* %temp, align 16
  %tmp_87 = lshr <4 x i32> %tmp_86, <i32 8, i32 8, i32 8, i32 8>
  store <4 x i32> %tmp_87, <4 x i32>* %temp, align 16
  %tmp_88 = load <4 x i32>* %temp, align 16
  %tmp_89 = and <4 x i32> %tmp_88, <i32 255, i32 255, i32 255, i32 255>
  %tmp_90 = mul <4 x i32> %tmp_89, <i32 16, i32 16, i32 16, i32 16>
  %tmp_91 = load i32* %offset, align 4
  %tmp_92 = insertelement <4 x i32> undef, i32 %tmp_91, i32 0
  %tmp_93 = shufflevector <4 x i32> %tmp_92, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_94 = add <4 x i32> %tmp_90, %tmp_93
  store <4 x i32> %tmp_94, <4 x i32>* %temp2, align 16
  %tmp_95 = load <4 x i32>* %temp2, align 16
  %tmp_96 = extractelement <4 x i32> %tmp_95, i32 0
  %tmp_97 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_96
  %tmp_98 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_97)
  %tmp_99 = load <4 x i32>* %temp2, align 16
  %tmp_100 = extractelement <4 x i32> %tmp_99, i32 1
  %tmp_101 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_100
  %tmp_102 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_101)
  %tmp_103 = load <4 x i32>* %temp2, align 16
  %tmp_104 = extractelement <4 x i32> %tmp_103, i32 2
  %tmp_105 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_104
  %tmp_106 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_105)
  %tmp_107 = load <4 x i32>* %temp2, align 16
  %tmp_108 = extractelement <4 x i32> %tmp_107, i32 3
  %tmp_109 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_108
  %tmp_110 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_109)
  %tmp_111 = load <4 x i32>* %temp, align 16
  %tmp_112 = lshr <4 x i32> %tmp_111, <i32 8, i32 8, i32 8, i32 8>
  store <4 x i32> %tmp_112, <4 x i32>* %temp, align 16
  %tmp_113 = load <4 x i32>* %temp, align 16
  %tmp_114 = and <4 x i32> %tmp_113, <i32 255, i32 255, i32 255, i32 255>
  %tmp_115 = mul <4 x i32> %tmp_114, <i32 16, i32 16, i32 16, i32 16>
  %tmp_116 = load i32* %offset, align 4
  %tmp_117 = insertelement <4 x i32> undef, i32 %tmp_116, i32 0
  %tmp_118 = shufflevector <4 x i32> %tmp_117, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_119 = add <4 x i32> %tmp_115, %tmp_118
  store <4 x i32> %tmp_119, <4 x i32>* %temp2, align 16
  %tmp_120 = load <4 x i32>* %temp2, align 16
  %tmp_121 = extractelement <4 x i32> %tmp_120, i32 0
  %tmp_122 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_121
  %tmp_123 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_122)
  %tmp_124 = load <4 x i32>* %temp2, align 16
  %tmp_125 = extractelement <4 x i32> %tmp_124, i32 1
  %tmp_126 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_125
  %tmp_127 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_126)
  %tmp_128 = load <4 x i32>* %temp2, align 16
  %tmp_129 = extractelement <4 x i32> %tmp_128, i32 2
  %tmp_130 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_129
  %tmp_131 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_130)
  %tmp_132 = load <4 x i32>* %temp2, align 16
  %tmp_133 = extractelement <4 x i32> %tmp_132, i32 3
  %tmp_134 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %tmp_133
  %tmp_135 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_134)
  br label %tmp_136

tmp_136:                                     ; preds = %tmp_29
  %tmp_137 = load i32* %i, align 4
  %tmp_138 = add i32 %tmp_137, 1
  store i32 %tmp_138, i32* %i, align 4
  br label %tmp_25

tmp_139:                                     ; preds = %tmp_25
  call void @barrier(i32 1)
  %tmp_140 = load i32* %ltid, align 4
  store i32 %tmp_140, i32* %i, align 4
  br label %tmp_141

tmp_141:                                     ; preds = %tmp_172, %tmp_139
  %tmp_142 = load i32* %i, align 4
  %tmp_143 = icmp ult i32 %tmp_142, 256
  br i1 %tmp_143, label %tmp_144, label %tmp_176

tmp_144:                                     ; preds = %tmp_141
  store i32 0, i32* %bin, align 4
  %tmp_145 = load i32* %offset, align 4
  store i32 %tmp_145, i32* %off, align 4
  store i32 0, i32* %j, align 4
  br label %tmp_146

tmp_146:                                     ; preds = %tmp_159, %tmp_144
  %tmp_147 = load i32* %j, align 4
  %tmp_148 = icmp slt i32 %tmp_147, 16
  br i1 %tmp_148, label %tmp_149, label %tmp_164

tmp_149:                                     ; preds = %tmp_146
  %tmp_150 = load i32* %i, align 4
  %tmp_151 = mul i32 %tmp_150, 16
  %tmp_152 = load i32* %off, align 4
  %tmp_153 = urem i32 %tmp_152, 16
  %tmp_154 = add i32 %tmp_151, %tmp_153
  %tmp_155 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %tmp_154
  %tmp_156 = load i32 addrspace(3)* %tmp_155, align 4
  %tmp_157 = load i32* %bin, align 4
  %tmp_158 = add i32 %tmp_157, %tmp_156
  store i32 %tmp_158, i32* %bin, align 4
  br label %tmp_159

tmp_159:                                     ; preds = %tmp_149
  %tmp_160 = load i32* %j, align 4
  %tmp_161 = add nsw i32 %tmp_160, 1
  store i32 %tmp_161, i32* %j, align 4
  %tmp_162 = load i32* %off, align 4
  %tmp_163 = add i32 %tmp_162, 1
  store i32 %tmp_163, i32* %off, align 4
  br label %tmp_146

tmp_164:                                     ; preds = %tmp_146
  %tmp_165 = load i32* %bin, align 4
  %tmp_166 = call i32 @__get_group_id_u32(i32 0)
  %tmp_167 = mul i32 %tmp_166, 256
  %tmp_168 = load i32* %i, align 4
  %tmp_169 = add i32 %tmp_167, %tmp_168
  %tmp_170 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_171 = getelementptr inbounds i32 addrspace(1)* %tmp_170, i32 %tmp_169
  store i32 %tmp_165, i32 addrspace(1)* %tmp_171, align 4
  br label %tmp_172

tmp_172:                                     ; preds = %tmp_164
  %tmp_173 = load i32* %groupSize, align 4
  %tmp_174 = load i32* %i, align 4
  %tmp_175 = add i32 %tmp_174, %tmp_173
  store i32 %tmp_175, i32* %i, align 4
  br label %tmp_141

tmp_176:                                     ; preds = %tmp_141
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
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tid = alloca i32, align 4
  %ltid = alloca i32, align 4
  %Stride = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %idx = alloca i32, align 4
  %temp = alloca i32, align 4
  %temp2 = alloca i32, align 4
  %shft = alloca i32, align 4
  %msk = alloca i32, align 4
  %offset = alloca i32, align 4
  %lmem_items = alloca i32, align 4
  %p = alloca i32 addrspace(3)*, align 4
  %bin = alloca i32, align 4
  %off = alloca i32, align 4
  %j1 = alloca i32, align 4
  store i32 addrspace(1)* %Image, i32 addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %Histogram, i32 addrspace(1)** %tmp_2, align 4
  store i32 %nVectorsPerThread, i32* %tmp_3, align 4
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_4, i32* %tid, align 4
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_5, i32* %ltid, align 4
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_6, i32* %Stride, align 4
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_7, i32* %groupSize, align 4
  store i32 8, i32* %shft, align 4
  store i32 255, i32* %msk, align 4
  %tmp_8 = load i32* %ltid, align 4
  %tmp_9 = urem i32 %tmp_8, 4
  store i32 %tmp_9, i32* %offset, align 4
  store i32 1024, i32* %lmem_items, align 4
  store i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 addrspace(3)** %p, align 4
  %tmp_10 = load i32* %ltid, align 4
  store i32 %tmp_10, i32* %i, align 4
  br label %tmp_11

tmp_11:                                      ; preds = %tmp_19, %tmp_0
  %tmp_12 = load i32* %i, align 4
  %tmp_13 = load i32* %lmem_items, align 4
  %tmp_14 = icmp ult i32 %tmp_12, %tmp_13
  br i1 %tmp_14, label %tmp_15, label %tmp_23

tmp_15:                                      ; preds = %tmp_11
  %tmp_16 = load i32* %i, align 4
  %tmp_17 = load i32 addrspace(3)** %p, align 4
  %tmp_18 = getelementptr inbounds i32 addrspace(3)* %tmp_17, i32 %tmp_16
  store i32 0, i32 addrspace(3)* %tmp_18, align 4
  br label %tmp_19

tmp_19:                                      ; preds = %tmp_15
  %tmp_20 = load i32* %groupSize, align 4
  %tmp_21 = load i32* %i, align 4
  %tmp_22 = add i32 %tmp_21, %tmp_20
  store i32 %tmp_22, i32* %i, align 4
  br label %tmp_11

tmp_23:                                      ; preds = %tmp_11
  call void @barrier(i32 1)
  store i32 0, i32* %i, align 4
  br label %tmp_24

tmp_24:                                      ; preds = %tmp_75, %tmp_23
  %tmp_25 = load i32* %i, align 4
  %tmp_26 = load i32* %tmp_3, align 4
  %tmp_27 = icmp ult i32 %tmp_25, %tmp_26
  br i1 %tmp_27, label %tmp_28, label %tmp_78

tmp_28:                                      ; preds = %tmp_24
  %tmp_29 = load i32* %tid, align 4
  %tmp_30 = load i32* %i, align 4
  %tmp_31 = load i32* %Stride, align 4
  %tmp_32 = mul i32 %tmp_30, %tmp_31
  %tmp_33 = add i32 %tmp_29, %tmp_32
  %tmp_34 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_35 = getelementptr inbounds i32 addrspace(1)* %tmp_34, i32 %tmp_33
  %tmp_36 = load i32 addrspace(1)* %tmp_35, align 4
  store i32 %tmp_36, i32* %temp, align 4
  %tmp_37 = load i32* %temp, align 4
  %tmp_38 = and i32 %tmp_37, 255
  %tmp_39 = mul i32 %tmp_38, 4
  %tmp_40 = load i32* %offset, align 4
  %tmp_41 = add i32 %tmp_39, %tmp_40
  store i32 %tmp_41, i32* %temp2, align 4
  %tmp_42 = load i32* %temp2, align 4
  %tmp_43 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %tmp_42
  %tmp_44 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_43)
  %tmp_45 = load i32* %temp, align 4
  %tmp_46 = lshr i32 %tmp_45, 8
  store i32 %tmp_46, i32* %temp, align 4
  %tmp_47 = load i32* %temp, align 4
  %tmp_48 = and i32 %tmp_47, 255
  %tmp_49 = mul i32 %tmp_48, 4
  %tmp_50 = load i32* %offset, align 4
  %tmp_51 = add i32 %tmp_49, %tmp_50
  store i32 %tmp_51, i32* %temp2, align 4
  %tmp_52 = load i32* %temp2, align 4
  %tmp_53 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %tmp_52
  %tmp_54 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_53)
  %tmp_55 = load i32* %temp, align 4
  %tmp_56 = lshr i32 %tmp_55, 8
  store i32 %tmp_56, i32* %temp, align 4
  %tmp_57 = load i32* %temp, align 4
  %tmp_58 = and i32 %tmp_57, 255
  %tmp_59 = mul i32 %tmp_58, 4
  %tmp_60 = load i32* %offset, align 4
  %tmp_61 = add i32 %tmp_59, %tmp_60
  store i32 %tmp_61, i32* %temp2, align 4
  %tmp_62 = load i32* %temp2, align 4
  %tmp_63 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %tmp_62
  %tmp_64 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_63)
  %tmp_65 = load i32* %temp, align 4
  %tmp_66 = lshr i32 %tmp_65, 8
  store i32 %tmp_66, i32* %temp, align 4
  %tmp_67 = load i32* %temp, align 4
  %tmp_68 = and i32 %tmp_67, 255
  %tmp_69 = mul i32 %tmp_68, 4
  %tmp_70 = load i32* %offset, align 4
  %tmp_71 = add i32 %tmp_69, %tmp_70
  store i32 %tmp_71, i32* %temp2, align 4
  %tmp_72 = load i32* %temp2, align 4
  %tmp_73 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %tmp_72
  %tmp_74 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %tmp_73)
  br label %tmp_75

tmp_75:                                      ; preds = %tmp_28
  %tmp_76 = load i32* %i, align 4
  %tmp_77 = add i32 %tmp_76, 1
  store i32 %tmp_77, i32* %i, align 4
  br label %tmp_24

tmp_78:                                      ; preds = %tmp_24
  call void @barrier(i32 1)
  %tmp_79 = load i32* %ltid, align 4
  store i32 %tmp_79, i32* %i, align 4
  br label %tmp_80

tmp_80:                                      ; preds = %tmp_111, %tmp_78
  %tmp_81 = load i32* %i, align 4
  %tmp_82 = icmp ult i32 %tmp_81, 256
  br i1 %tmp_82, label %tmp_83, label %tmp_115

tmp_83:                                      ; preds = %tmp_80
  store i32 0, i32* %bin, align 4
  %tmp_84 = load i32* %offset, align 4
  store i32 %tmp_84, i32* %off, align 4
  store i32 0, i32* %j1, align 4
  br label %tmp_85

tmp_85:                                      ; preds = %tmp_98, %tmp_83
  %tmp_86 = load i32* %j1, align 4
  %tmp_87 = icmp slt i32 %tmp_86, 4
  br i1 %tmp_87, label %tmp_88, label %tmp_103

tmp_88:                                      ; preds = %tmp_85
  %tmp_89 = load i32* %i, align 4
  %tmp_90 = mul i32 %tmp_89, 4
  %tmp_91 = load i32* %off, align 4
  %tmp_92 = urem i32 %tmp_91, 4
  %tmp_93 = add i32 %tmp_90, %tmp_92
  %tmp_94 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %tmp_93
  %tmp_95 = load i32 addrspace(3)* %tmp_94, align 4
  %tmp_96 = load i32* %bin, align 4
  %tmp_97 = add i32 %tmp_96, %tmp_95
  store i32 %tmp_97, i32* %bin, align 4
  br label %tmp_98

tmp_98:                                      ; preds = %tmp_88
  %tmp_99 = load i32* %j1, align 4
  %tmp_100 = add nsw i32 %tmp_99, 1
  store i32 %tmp_100, i32* %j1, align 4
  %tmp_101 = load i32* %off, align 4
  %tmp_102 = add i32 %tmp_101, 1
  store i32 %tmp_102, i32* %off, align 4
  br label %tmp_85

tmp_103:                                     ; preds = %tmp_85
  %tmp_104 = load i32* %bin, align 4
  %tmp_105 = call i32 @__get_group_id_u32(i32 0)
  %tmp_106 = mul i32 %tmp_105, 256
  %tmp_107 = load i32* %i, align 4
  %tmp_108 = add i32 %tmp_106, %tmp_107
  %tmp_109 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_110 = getelementptr inbounds i32 addrspace(1)* %tmp_109, i32 %tmp_108
  store i32 %tmp_104, i32 addrspace(1)* %tmp_110, align 4
  br label %tmp_111

tmp_111:                                     ; preds = %tmp_103
  %tmp_112 = load i32* %groupSize, align 4
  %tmp_113 = load i32* %i, align 4
  %tmp_114 = add i32 %tmp_113, %tmp_112
  store i32 %tmp_114, i32* %i, align 4
  br label %tmp_80

tmp_115:                                     ; preds = %tmp_80
  ret void
}

; Function Attrs: nounwind
define void @reduceKernel(i32 addrspace(1)* %Histogram, i32 %nSubHists) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32, align 4
  %tid = alloca i32, align 4
  %bin = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 addrspace(1)* %Histogram, i32 addrspace(1)** %tmp_1, align 4
  store i32 %nSubHists, i32* %tmp_2, align 4
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_3, i32* %tid, align 4
  store i32 0, i32* %bin, align 4
  store i32 0, i32* %i, align 4
  br label %tmp_4

tmp_4:                                       ; preds = %tmp_45, %tmp_0
  %tmp_5 = load i32* %i, align 4
  %tmp_6 = load i32* %tmp_2, align 4
  %tmp_7 = icmp ult i32 %tmp_5, %tmp_6
  br i1 %tmp_7, label %tmp_8, label %tmp_48

tmp_8:                                       ; preds = %tmp_4
  %tmp_9 = load i32* %i, align 4
  %tmp_10 = mul nsw i32 %tmp_9, 256
  %tmp_11 = load i32* %tid, align 4
  %tmp_12 = add i32 %tmp_10, %tmp_11
  %tmp_13 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_14 = getelementptr inbounds i32 addrspace(1)* %tmp_13, i32 %tmp_12
  %tmp_15 = load i32 addrspace(1)* %tmp_14, align 4
  %tmp_16 = load i32* %i, align 4
  %tmp_17 = mul nsw i32 %tmp_16, 256
  %tmp_18 = load i32* %tid, align 4
  %tmp_19 = add i32 %tmp_17, %tmp_18
  %tmp_20 = add i32 %tmp_19, 256
  %tmp_21 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_22 = getelementptr inbounds i32 addrspace(1)* %tmp_21, i32 %tmp_20
  %tmp_23 = load i32 addrspace(1)* %tmp_22, align 4
  %tmp_24 = add i32 %tmp_15, %tmp_23
  %tmp_25 = load i32* %i, align 4
  %tmp_26 = mul nsw i32 %tmp_25, 256
  %tmp_27 = load i32* %tid, align 4
  %tmp_28 = add i32 %tmp_26, %tmp_27
  %tmp_29 = add i32 %tmp_28, 512
  %tmp_30 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_31 = getelementptr inbounds i32 addrspace(1)* %tmp_30, i32 %tmp_29
  %tmp_32 = load i32 addrspace(1)* %tmp_31, align 4
  %tmp_33 = add i32 %tmp_24, %tmp_32
  %tmp_34 = load i32* %i, align 4
  %tmp_35 = mul nsw i32 %tmp_34, 256
  %tmp_36 = load i32* %tid, align 4
  %tmp_37 = add i32 %tmp_35, %tmp_36
  %tmp_38 = add i32 %tmp_37, 768
  %tmp_39 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_40 = getelementptr inbounds i32 addrspace(1)* %tmp_39, i32 %tmp_38
  %tmp_41 = load i32 addrspace(1)* %tmp_40, align 4
  %tmp_42 = add i32 %tmp_33, %tmp_41
  %tmp_43 = load i32* %bin, align 4
  %tmp_44 = add i32 %tmp_43, %tmp_42
  store i32 %tmp_44, i32* %bin, align 4
  br label %tmp_45

tmp_45:                                      ; preds = %tmp_8
  %tmp_46 = load i32* %i, align 4
  %tmp_47 = add nsw i32 %tmp_46, 4
  store i32 %tmp_47, i32* %i, align 4
  br label %tmp_4

tmp_48:                                      ; preds = %tmp_4
  %tmp_49 = load i32* %bin, align 4
  %tmp_50 = load i32* %tid, align 4
  %tmp_51 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_52 = getelementptr inbounds i32 addrspace(1)* %tmp_51, i32 %tmp_50
  store i32 %tmp_49, i32 addrspace(1)* %tmp_52, align 4
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

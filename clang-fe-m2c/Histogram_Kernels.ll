; ModuleID = '../kernel-src/Histogram_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram256_vector(<4 x i32> addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
  %tmp_1 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(3)*, align 4
  %tmp_3 = alloca i32 addrspace(1)*, align 4
  %localId = alloca i32, align 4
  %globalId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %offSet1 = alloca i32, align 4
  %offSet2 = alloca i32, align 4
  %offSet3 = alloca i32, align 4
  %input = alloca <4 x i8> addrspace(3)*, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  %value = alloca <4 x i32>, align 16
  %binCount = alloca <4 x i32>, align 16
  %result = alloca i32, align 4
  %binVal = alloca <4 x i8>, align 4
  %binValAsUint = alloca <4 x i32>, align 16
  %i2 = alloca i32, align 4
  %passNumber = alloca i32, align 4
  %j = alloca i32, align 4
  %bankNum = alloca i32, align 4
  store <4 x i32> addrspace(1)* %data, <4 x i32> addrspace(1)** %tmp_1, align 4
  store i8 addrspace(3)* %sharedArray, i8 addrspace(3)** %tmp_2, align 4
  store i32 addrspace(1)* %binResult, i32 addrspace(1)** %tmp_3, align 4
  %tmp_4 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_4, i32* %localId, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_5, i32* %globalId, align 4
  %tmp_6 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_6, i32* %groupId, align 4
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_7, i32* %groupSize, align 4
  %tmp_8 = load i32* %localId, align 4
  %tmp_9 = and i32 %tmp_8, 31
  store i32 %tmp_9, i32* %offSet1, align 4
  %tmp_10 = load i32* %offSet1, align 4
  %tmp_11 = mul nsw i32 4, %tmp_10
  store i32 %tmp_11, i32* %offSet2, align 4
  %tmp_12 = load i32* %localId, align 4
  %tmp_13 = lshr i32 %tmp_12, 5
  store i32 %tmp_13, i32* %offSet3, align 4
  %tmp_14 = load i8 addrspace(3)** %tmp_2, align 4
  %tmp_15 = bitcast i8 addrspace(3)* %tmp_14 to <4 x i8> addrspace(3)*
  store <4 x i8> addrspace(3)* %tmp_15, <4 x i8> addrspace(3)** %input, align 4
  store i32 0, i32* %i, align 4
  br label %tmp_16

tmp_16:                                      ; preds = %tmp_27, %tmp_0
  %tmp_17 = load i32* %i, align 4
  %tmp_18 = icmp slt i32 %tmp_17, 64
  br i1 %tmp_18, label %tmp_19, label %tmp_30

tmp_19:                                      ; preds = %tmp_16
  %tmp_20 = load i32* %groupSize, align 4
  %tmp_21 = load i32* %i, align 4
  %tmp_22 = mul i32 %tmp_20, %tmp_21
  %tmp_23 = load i32* %localId, align 4
  %tmp_24 = add i32 %tmp_22, %tmp_23
  %tmp_25 = load <4 x i8> addrspace(3)** %input, align 4
  %tmp_26 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_25, i32 %tmp_24
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %tmp_26, align 4
  br label %tmp_27

tmp_27:                                      ; preds = %tmp_19
  %tmp_28 = load i32* %i, align 4
  %tmp_29 = add nsw i32 %tmp_28, 1
  store i32 %tmp_29, i32* %i, align 4
  br label %tmp_16

tmp_30:                                      ; preds = %tmp_16
  call void @barrier(i32 1)
  store i32 0, i32* %i1, align 4
  br label %tmp_31

tmp_31:                                      ; preds = %tmp_93, %tmp_30
  %tmp_32 = load i32* %i1, align 4
  %tmp_33 = icmp slt i32 %tmp_32, 32
  br i1 %tmp_33, label %tmp_34, label %tmp_96

tmp_34:                                      ; preds = %tmp_31
  %tmp_35 = load i32* %groupId, align 4
  %tmp_36 = load i32* %groupSize, align 4
  %tmp_37 = mul i32 %tmp_36, 256
  %tmp_38 = udiv i32 %tmp_37, 8
  %tmp_39 = mul i32 %tmp_35, %tmp_38
  %tmp_40 = load i32* %i1, align 4
  %tmp_41 = load i32* %groupSize, align 4
  %tmp_42 = mul i32 %tmp_40, %tmp_41
  %tmp_43 = add i32 %tmp_39, %tmp_42
  %tmp_44 = load i32* %localId, align 4
  %tmp_45 = add i32 %tmp_43, %tmp_44
  %tmp_46 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_47 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_46, i32 %tmp_45
  %tmp_48 = load <4 x i32> addrspace(1)* %tmp_47, align 16
  store <4 x i32> %tmp_48, <4 x i32>* %value, align 16
  %tmp_49 = load <4 x i32>* %value, align 16
  %tmp_50 = extractelement <4 x i32> %tmp_49, i32 0
  %tmp_51 = mul i32 %tmp_50, 128
  %tmp_52 = load i32* %offSet2, align 4
  %tmp_53 = add i32 %tmp_51, %tmp_52
  %tmp_54 = load i32* %offSet3, align 4
  %tmp_55 = add i32 %tmp_53, %tmp_54
  %tmp_56 = load i8 addrspace(3)** %tmp_2, align 4
  %tmp_57 = getelementptr inbounds i8 addrspace(3)* %tmp_56, i32 %tmp_55
  %tmp_58 = load i8 addrspace(3)* %tmp_57, align 1
  %tmp_59 = add i8 %tmp_58, 1
  store i8 %tmp_59, i8 addrspace(3)* %tmp_57, align 1
  %tmp_60 = load <4 x i32>* %value, align 16
  %tmp_61 = extractelement <4 x i32> %tmp_60, i32 1
  %tmp_62 = mul i32 %tmp_61, 128
  %tmp_63 = load i32* %offSet2, align 4
  %tmp_64 = add i32 %tmp_62, %tmp_63
  %tmp_65 = load i32* %offSet3, align 4
  %tmp_66 = add i32 %tmp_64, %tmp_65
  %tmp_67 = load i8 addrspace(3)** %tmp_2, align 4
  %tmp_68 = getelementptr inbounds i8 addrspace(3)* %tmp_67, i32 %tmp_66
  %tmp_69 = load i8 addrspace(3)* %tmp_68, align 1
  %tmp_70 = add i8 %tmp_69, 1
  store i8 %tmp_70, i8 addrspace(3)* %tmp_68, align 1
  %tmp_71 = load <4 x i32>* %value, align 16
  %tmp_72 = extractelement <4 x i32> %tmp_71, i32 2
  %tmp_73 = mul i32 %tmp_72, 128
  %tmp_74 = load i32* %offSet2, align 4
  %tmp_75 = add i32 %tmp_73, %tmp_74
  %tmp_76 = load i32* %offSet3, align 4
  %tmp_77 = add i32 %tmp_75, %tmp_76
  %tmp_78 = load i8 addrspace(3)** %tmp_2, align 4
  %tmp_79 = getelementptr inbounds i8 addrspace(3)* %tmp_78, i32 %tmp_77
  %tmp_80 = load i8 addrspace(3)* %tmp_79, align 1
  %tmp_81 = add i8 %tmp_80, 1
  store i8 %tmp_81, i8 addrspace(3)* %tmp_79, align 1
  %tmp_82 = load <4 x i32>* %value, align 16
  %tmp_83 = extractelement <4 x i32> %tmp_82, i32 3
  %tmp_84 = mul i32 %tmp_83, 128
  %tmp_85 = load i32* %offSet2, align 4
  %tmp_86 = add i32 %tmp_84, %tmp_85
  %tmp_87 = load i32* %offSet3, align 4
  %tmp_88 = add i32 %tmp_86, %tmp_87
  %tmp_89 = load i8 addrspace(3)** %tmp_2, align 4
  %tmp_90 = getelementptr inbounds i8 addrspace(3)* %tmp_89, i32 %tmp_88
  %tmp_91 = load i8 addrspace(3)* %tmp_90, align 1
  %tmp_92 = add i8 %tmp_91, 1
  store i8 %tmp_92, i8 addrspace(3)* %tmp_90, align 1
  br label %tmp_93

tmp_93:                                      ; preds = %tmp_34
  %tmp_94 = load i32* %i1, align 4
  %tmp_95 = add nsw i32 %tmp_94, 1
  store i32 %tmp_95, i32* %i1, align 4
  br label %tmp_31

tmp_96:                                      ; preds = %tmp_31
  call void @barrier(i32 1)
  store i32 0, i32* %i2, align 4
  br label %tmp_97

tmp_97:                                      ; preds = %tmp_153, %tmp_96
  %tmp_98 = load i32* %i2, align 4
  %tmp_99 = load i32* %groupSize, align 4
  %tmp_100 = udiv i32 256, %tmp_99
  %tmp_101 = icmp ult i32 %tmp_98, %tmp_100
  br i1 %tmp_101, label %tmp_102, label %tmp_156

tmp_102:                                     ; preds = %tmp_97
  %tmp_103 = load i32* %i2, align 4
  %tmp_104 = mul nsw i32 4096, %tmp_103
  %tmp_105 = load i32* %localId, align 4
  %tmp_106 = mul i32 %tmp_105, 32
  %tmp_107 = add i32 %tmp_104, %tmp_106
  store i32 %tmp_107, i32* %passNumber, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %binCount, align 16
  store i32 0, i32* %result, align 4
  store i32 0, i32* %j, align 4
  br label %tmp_108

tmp_108:                                     ; preds = %tmp_127, %tmp_102
  %tmp_109 = load i32* %j, align 4
  %tmp_110 = icmp slt i32 %tmp_109, 32
  br i1 %tmp_110, label %tmp_111, label %tmp_130

tmp_111:                                     ; preds = %tmp_108
  %tmp_112 = load i32* %j, align 4
  %tmp_113 = load i32* %offSet1, align 4
  %tmp_114 = add nsw i32 %tmp_112, %tmp_113
  %tmp_115 = and i32 %tmp_114, 31
  store i32 %tmp_115, i32* %bankNum, align 4
  %tmp_116 = load i32* %passNumber, align 4
  %tmp_117 = load i32* %bankNum, align 4
  %tmp_118 = add nsw i32 %tmp_116, %tmp_117
  %tmp_119 = load <4 x i8> addrspace(3)** %input, align 4
  %tmp_120 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_119, i32 %tmp_118
  %tmp_121 = load <4 x i8> addrspace(3)* %tmp_120, align 4
  store <4 x i8> %tmp_121, <4 x i8>* %binVal, align 4
  %tmp_122 = load <4 x i8>* %binVal, align 4
  %tmp_123 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %tmp_122)
  store <4 x i32> %tmp_123, <4 x i32>* %binValAsUint, align 16
  %tmp_124 = load <4 x i32>* %binValAsUint, align 16
  %tmp_125 = load <4 x i32>* %binCount, align 16
  %tmp_126 = add <4 x i32> %tmp_125, %tmp_124
  store <4 x i32> %tmp_126, <4 x i32>* %binCount, align 16
  br label %tmp_127

tmp_127:                                     ; preds = %tmp_111
  %tmp_128 = load i32* %j, align 4
  %tmp_129 = add nsw i32 %tmp_128, 1
  store i32 %tmp_129, i32* %j, align 4
  br label %tmp_108

tmp_130:                                     ; preds = %tmp_108
  %tmp_131 = load <4 x i32>* %binCount, align 16
  %tmp_132 = extractelement <4 x i32> %tmp_131, i32 0
  %tmp_133 = load <4 x i32>* %binCount, align 16
  %tmp_134 = extractelement <4 x i32> %tmp_133, i32 1
  %tmp_135 = add i32 %tmp_132, %tmp_134
  %tmp_136 = load <4 x i32>* %binCount, align 16
  %tmp_137 = extractelement <4 x i32> %tmp_136, i32 2
  %tmp_138 = add i32 %tmp_135, %tmp_137
  %tmp_139 = load <4 x i32>* %binCount, align 16
  %tmp_140 = extractelement <4 x i32> %tmp_139, i32 3
  %tmp_141 = add i32 %tmp_138, %tmp_140
  store i32 %tmp_141, i32* %result, align 4
  %tmp_142 = load i32* %result, align 4
  %tmp_143 = load i32* %groupId, align 4
  %tmp_144 = mul i32 %tmp_143, 256
  %tmp_145 = load i32* %groupSize, align 4
  %tmp_146 = load i32* %i2, align 4
  %tmp_147 = mul i32 %tmp_145, %tmp_146
  %tmp_148 = add i32 %tmp_144, %tmp_147
  %tmp_149 = load i32* %localId, align 4
  %tmp_150 = add i32 %tmp_148, %tmp_149
  %tmp_151 = load i32 addrspace(1)** %tmp_3, align 4
  %tmp_152 = getelementptr inbounds i32 addrspace(1)* %tmp_151, i32 %tmp_150
  store i32 %tmp_142, i32 addrspace(1)* %tmp_152, align 4
  br label %tmp_153

tmp_153:                                     ; preds = %tmp_130
  %tmp_154 = load i32* %i2, align 4
  %tmp_155 = add nsw i32 %tmp_154, 1
  store i32 %tmp_155, i32* %i2, align 4
  br label %tmp_97

tmp_156:                                     ; preds = %tmp_97
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare void @barrier(i32) #1

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @histogram256_scalar(i32 addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(3)*, align 4
  %tmp_3 = alloca i32 addrspace(1)*, align 4
  %localId = alloca i32, align 4
  %globalId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %offSet1 = alloca i32, align 4
  %offSet2 = alloca i32, align 4
  %offSet3 = alloca i32, align 4
  %input = alloca <4 x i8> addrspace(3)*, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  %value = alloca i32, align 4
  %binCount = alloca <4 x i32>, align 16
  %result = alloca i32, align 4
  %binVal = alloca <4 x i8>, align 4
  %binValAsUint = alloca <4 x i32>, align 16
  %i2 = alloca i32, align 4
  %passNumber = alloca i32, align 4
  %j = alloca i32, align 4
  %bankNum = alloca i32, align 4
  store i32 addrspace(1)* %data, i32 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(3)* %sharedArray, i8 addrspace(3)** %tmp_2, align 4
  store i32 addrspace(1)* %binResult, i32 addrspace(1)** %tmp_3, align 4
  %tmp_4 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_4, i32* %localId, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_5, i32* %globalId, align 4
  %tmp_6 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_6, i32* %groupId, align 4
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_7, i32* %groupSize, align 4
  %tmp_8 = load i32* %localId, align 4
  %tmp_9 = and i32 %tmp_8, 31
  store i32 %tmp_9, i32* %offSet1, align 4
  %tmp_10 = load i32* %offSet1, align 4
  %tmp_11 = mul nsw i32 4, %tmp_10
  store i32 %tmp_11, i32* %offSet2, align 4
  %tmp_12 = load i32* %localId, align 4
  %tmp_13 = lshr i32 %tmp_12, 5
  store i32 %tmp_13, i32* %offSet3, align 4
  %tmp_14 = load i8 addrspace(3)** %tmp_2, align 4
  %tmp_15 = bitcast i8 addrspace(3)* %tmp_14 to <4 x i8> addrspace(3)*
  store <4 x i8> addrspace(3)* %tmp_15, <4 x i8> addrspace(3)** %input, align 4
  store i32 0, i32* %i, align 4
  br label %tmp_16

tmp_16:                                      ; preds = %tmp_27, %tmp_0
  %tmp_17 = load i32* %i, align 4
  %tmp_18 = icmp slt i32 %tmp_17, 64
  br i1 %tmp_18, label %tmp_19, label %tmp_30

tmp_19:                                      ; preds = %tmp_16
  %tmp_20 = load i32* %groupSize, align 4
  %tmp_21 = load i32* %i, align 4
  %tmp_22 = mul i32 %tmp_20, %tmp_21
  %tmp_23 = load i32* %localId, align 4
  %tmp_24 = add i32 %tmp_22, %tmp_23
  %tmp_25 = load <4 x i8> addrspace(3)** %input, align 4
  %tmp_26 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_25, i32 %tmp_24
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %tmp_26, align 4
  br label %tmp_27

tmp_27:                                      ; preds = %tmp_19
  %tmp_28 = load i32* %i, align 4
  %tmp_29 = add nsw i32 %tmp_28, 1
  store i32 %tmp_29, i32* %i, align 4
  br label %tmp_16

tmp_30:                                      ; preds = %tmp_16
  call void @barrier(i32 1)
  store i32 0, i32* %i1, align 4
  br label %tmp_31

tmp_31:                                      ; preds = %tmp_58, %tmp_30
  %tmp_32 = load i32* %i1, align 4
  %tmp_33 = icmp slt i32 %tmp_32, 128
  br i1 %tmp_33, label %tmp_34, label %tmp_61

tmp_34:                                      ; preds = %tmp_31
  %tmp_35 = load i32* %groupId, align 4
  %tmp_36 = load i32* %groupSize, align 4
  %tmp_37 = mul i32 %tmp_36, 128
  %tmp_38 = mul i32 %tmp_35, %tmp_37
  %tmp_39 = load i32* %i1, align 4
  %tmp_40 = load i32* %groupSize, align 4
  %tmp_41 = mul i32 %tmp_39, %tmp_40
  %tmp_42 = add i32 %tmp_38, %tmp_41
  %tmp_43 = load i32* %localId, align 4
  %tmp_44 = add i32 %tmp_42, %tmp_43
  %tmp_45 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_46 = getelementptr inbounds i32 addrspace(1)* %tmp_45, i32 %tmp_44
  %tmp_47 = load i32 addrspace(1)* %tmp_46, align 4
  store i32 %tmp_47, i32* %value, align 4
  %tmp_48 = load i32* %value, align 4
  %tmp_49 = mul i32 %tmp_48, 128
  %tmp_50 = load i32* %offSet2, align 4
  %tmp_51 = add i32 %tmp_49, %tmp_50
  %tmp_52 = load i32* %offSet3, align 4
  %tmp_53 = add i32 %tmp_51, %tmp_52
  %tmp_54 = load i8 addrspace(3)** %tmp_2, align 4
  %tmp_55 = getelementptr inbounds i8 addrspace(3)* %tmp_54, i32 %tmp_53
  %tmp_56 = load i8 addrspace(3)* %tmp_55, align 1
  %tmp_57 = add i8 %tmp_56, 1
  store i8 %tmp_57, i8 addrspace(3)* %tmp_55, align 1
  br label %tmp_58

tmp_58:                                      ; preds = %tmp_34
  %tmp_59 = load i32* %i1, align 4
  %tmp_60 = add nsw i32 %tmp_59, 1
  store i32 %tmp_60, i32* %i1, align 4
  br label %tmp_31

tmp_61:                                      ; preds = %tmp_31
  call void @barrier(i32 1)
  store i32 0, i32* %i2, align 4
  br label %tmp_62

tmp_62:                                      ; preds = %tmp_118, %tmp_61
  %tmp_63 = load i32* %i2, align 4
  %tmp_64 = load i32* %groupSize, align 4
  %tmp_65 = udiv i32 256, %tmp_64
  %tmp_66 = icmp ult i32 %tmp_63, %tmp_65
  br i1 %tmp_66, label %tmp_67, label %tmp_121

tmp_67:                                      ; preds = %tmp_62
  %tmp_68 = load i32* %i2, align 4
  %tmp_69 = mul nsw i32 4096, %tmp_68
  %tmp_70 = load i32* %localId, align 4
  %tmp_71 = mul i32 %tmp_70, 32
  %tmp_72 = add i32 %tmp_69, %tmp_71
  store i32 %tmp_72, i32* %passNumber, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %binCount, align 16
  store i32 0, i32* %result, align 4
  store i32 0, i32* %j, align 4
  br label %tmp_73

tmp_73:                                      ; preds = %tmp_92, %tmp_67
  %tmp_74 = load i32* %j, align 4
  %tmp_75 = icmp slt i32 %tmp_74, 32
  br i1 %tmp_75, label %tmp_76, label %tmp_95

tmp_76:                                      ; preds = %tmp_73
  %tmp_77 = load i32* %j, align 4
  %tmp_78 = load i32* %offSet1, align 4
  %tmp_79 = add nsw i32 %tmp_77, %tmp_78
  %tmp_80 = and i32 %tmp_79, 31
  store i32 %tmp_80, i32* %bankNum, align 4
  %tmp_81 = load i32* %passNumber, align 4
  %tmp_82 = load i32* %bankNum, align 4
  %tmp_83 = add nsw i32 %tmp_81, %tmp_82
  %tmp_84 = load <4 x i8> addrspace(3)** %input, align 4
  %tmp_85 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_84, i32 %tmp_83
  %tmp_86 = load <4 x i8> addrspace(3)* %tmp_85, align 4
  store <4 x i8> %tmp_86, <4 x i8>* %binVal, align 4
  %tmp_87 = load <4 x i8>* %binVal, align 4
  %tmp_88 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %tmp_87)
  store <4 x i32> %tmp_88, <4 x i32>* %binValAsUint, align 16
  %tmp_89 = load <4 x i32>* %binValAsUint, align 16
  %tmp_90 = load <4 x i32>* %binCount, align 16
  %tmp_91 = add <4 x i32> %tmp_90, %tmp_89
  store <4 x i32> %tmp_91, <4 x i32>* %binCount, align 16
  br label %tmp_92

tmp_92:                                      ; preds = %tmp_76
  %tmp_93 = load i32* %j, align 4
  %tmp_94 = add nsw i32 %tmp_93, 1
  store i32 %tmp_94, i32* %j, align 4
  br label %tmp_73

tmp_95:                                      ; preds = %tmp_73
  %tmp_96 = load <4 x i32>* %binCount, align 16
  %tmp_97 = extractelement <4 x i32> %tmp_96, i32 0
  %tmp_98 = load <4 x i32>* %binCount, align 16
  %tmp_99 = extractelement <4 x i32> %tmp_98, i32 1
  %tmp_100 = add i32 %tmp_97, %tmp_99
  %tmp_101 = load <4 x i32>* %binCount, align 16
  %tmp_102 = extractelement <4 x i32> %tmp_101, i32 2
  %tmp_103 = add i32 %tmp_100, %tmp_102
  %tmp_104 = load <4 x i32>* %binCount, align 16
  %tmp_105 = extractelement <4 x i32> %tmp_104, i32 3
  %tmp_106 = add i32 %tmp_103, %tmp_105
  store i32 %tmp_106, i32* %result, align 4
  %tmp_107 = load i32* %result, align 4
  %tmp_108 = load i32* %groupId, align 4
  %tmp_109 = mul i32 %tmp_108, 256
  %tmp_110 = load i32* %groupSize, align 4
  %tmp_111 = load i32* %i2, align 4
  %tmp_112 = mul i32 %tmp_110, %tmp_111
  %tmp_113 = add i32 %tmp_109, %tmp_112
  %tmp_114 = load i32* %localId, align 4
  %tmp_115 = add i32 %tmp_113, %tmp_114
  %tmp_116 = load i32 addrspace(1)** %tmp_3, align 4
  %tmp_117 = getelementptr inbounds i32 addrspace(1)* %tmp_116, i32 %tmp_115
  store i32 %tmp_107, i32 addrspace(1)* %tmp_117, align 4
  br label %tmp_118

tmp_118:                                     ; preds = %tmp_95
  %tmp_119 = load i32* %i2, align 4
  %tmp_120 = add nsw i32 %tmp_119, 1
  store i32 %tmp_120, i32* %i2, align 4
  br label %tmp_62

tmp_121:                                     ; preds = %tmp_62
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_vector}
!1 = metadata !{void (i32 addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

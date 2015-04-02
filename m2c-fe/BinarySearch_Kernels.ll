; ModuleID = 'BinarySearch_Kernels.bc'

define void @binarySearch(<4 x i32> addrspace(1)* %outputArray, i32 addrspace(1)* %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) {
block_0:
  %outputArray_addr = alloca <4 x i32> addrspace(1)*
  store <4 x i32> addrspace(1)* %outputArray, <4 x i32> addrspace(1)** %outputArray_addr
  %sortedArray_addr = alloca i32 addrspace(1)*
  store i32 addrspace(1)* %sortedArray, i32 addrspace(1)** %sortedArray_addr
  %subdivSize_addr = alloca i32
  store i32 %subdivSize, i32* %subdivSize_addr
  %globalLowerIndex_addr = alloca i32
  store i32 %globalLowerIndex, i32* %globalLowerIndex_addr
  %findMe_addr = alloca i32
  store i32 %findMe, i32* %findMe_addr
  %tid = alloca i32
  %elementLower = alloca i32
  %elementUpper = alloca i32
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_0, i32* %tid
  %tmp_1 = load i32* %globalLowerIndex_addr
  %tmp_2 = load i32* %tid
  %tmp_3 = load i32* %subdivSize_addr
  %tmp_4 = mul i32 %tmp_2, %tmp_3
  %tmp_5 = add i32 %tmp_1, %tmp_4
  %tmp_6 = load i32 addrspace(1)** %sortedArray_addr
  %tmp_7 = getelementptr i32 addrspace(1)* %tmp_6, i32 %tmp_5
  %tmp_8 = load i32 addrspace(1)* %tmp_7
  store i32 %tmp_8, i32* %elementLower
  %tmp_9 = load i32* %globalLowerIndex_addr
  %tmp_10 = load i32* %tid
  %tmp_11 = add i32 %tmp_10, 1
  %tmp_12 = load i32* %subdivSize_addr
  %tmp_13 = mul i32 %tmp_11, %tmp_12
  %tmp_14 = add i32 %tmp_9, %tmp_13
  %tmp_15 = sub i32 %tmp_14, 1
  %tmp_16 = load i32 addrspace(1)** %sortedArray_addr
  %tmp_17 = getelementptr i32 addrspace(1)* %tmp_16, i32 %tmp_15
  %tmp_18 = load i32 addrspace(1)* %tmp_17
  store i32 %tmp_18, i32* %elementUpper
  %tmp_19 = load i32* %elementLower
  %tmp_20 = load i32* %findMe_addr
  %tmp_21 = icmp sgt i32 %tmp_19, %tmp_20
  %tmp_22 = sext i1 %tmp_21 to i32
  %tmp_23 = load i32* %elementUpper
  %tmp_24 = load i32* %findMe_addr
  %tmp_25 = icmp slt i32 %tmp_23, %tmp_24
  %tmp_26 = sext i1 %tmp_25 to i32
  %tmp_27 = icmp ne i32 %tmp_22, 0
  br i1 %tmp_27, label %land_end, label %land_rhs

land_rhs:                                         ; preds = %block_1
  %tmp_28 = icmp ne i32 %tmp_26, 0
  br label %land_end

land_end:                                         ; preds = %land_rhs, %block_1
  %land_cond = phi i1 [ true, %block_1 ], [ %tmp_28, %land_rhs ]
  br i1 %land_cond, label %block_3, label %block_2

block_2:                                          ; preds = %land_end
  %tmp_29 = load <4 x i32> addrspace(1)** %outputArray_addr
  %tmp_30 = getelementptr <4 x i32> addrspace(1)* %tmp_29, i32 0
  %tmp_31 = load i32* %tid
  %tmp_32 = load <4 x i32> addrspace(1)* %tmp_30
  %tmp_33 = insertelement <4 x i32> %tmp_32, i32 %tmp_31, i32 0
  %tmp_34 = load <4 x i32> addrspace(1)** %outputArray_addr
  %tmp_35 = getelementptr <4 x i32> addrspace(1)* %tmp_34, i32 0
  %tmp_36 = load <4 x i32> addrspace(1)* %tmp_35
  %tmp_37 = insertelement <4 x i32> %tmp_36, i32 1, i32 3
  br label %block_4

block_3:                                          ; preds = %land_end
  ret void

block_4:                                          ; preds = %block_2
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

define void @binarySearch_mulkeys(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %numKeys, i32 addrspace(1)* %output) {
block_5:
  %keys_addr = alloca i32 addrspace(1)*
  store i32 addrspace(1)* %keys, i32 addrspace(1)** %keys_addr
  %input_addr = alloca i32 addrspace(1)*
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input_addr
  %numKeys_addr = alloca i32
  store i32 %numKeys, i32* %numKeys_addr
  %output_addr = alloca i32 addrspace(1)*
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output_addr
  %gid = alloca i32
  %lBound = alloca i32
  %uBound = alloca i32
  %i = alloca i32
  br label %block_6

block_6:                                          ; preds = %block_5
  %tmp_38 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_38, i32* %gid
  %tmp_39 = load i32* %gid
  %tmp_40 = mul i32 %tmp_39, 256
  store i32 %tmp_40, i32* %lBound
  %tmp_41 = load i32* %lBound
  %tmp_42 = add i32 %tmp_41, 255
  store i32 %tmp_42, i32* %uBound
  store i32 0, i32* %i
  br label %block_7

block_7:                                          ; preds = %block_9, %block_6
  %tmp_43 = load i32* %i
  %tmp_44 = load i32* %numKeys_addr
  %tmp_45 = icmp slt i32 %tmp_43, %tmp_44
  %tmp_46 = sext i1 %tmp_45 to i32
  %tmp_47 = icmp ne i32 %tmp_46, 0
  br i1 %tmp_47, label %block_8, label %block_10

block_8:                                          ; preds = %block_7
  %tmp_50 = load i32* %i
  %tmp_51 = load i32 addrspace(1)** %keys_addr
  %tmp_52 = getelementptr i32 addrspace(1)* %tmp_51, i32 %tmp_50
  %tmp_53 = load i32 addrspace(1)* %tmp_52
  %tmp_54 = load i32* %lBound
  %tmp_55 = load i32 addrspace(1)** %input_addr
  %tmp_56 = getelementptr i32 addrspace(1)* %tmp_55, i32 %tmp_54
  %tmp_57 = load i32 addrspace(1)* %tmp_56
  %tmp_58 = icmp sge i32 %tmp_53, %tmp_57
  %tmp_59 = sext i1 %tmp_58 to i32
  %tmp_60 = load i32* %i
  %tmp_61 = load i32 addrspace(1)** %keys_addr
  %tmp_62 = getelementptr i32 addrspace(1)* %tmp_61, i32 %tmp_60
  %tmp_63 = load i32 addrspace(1)* %tmp_62
  %tmp_64 = load i32* %uBound
  %tmp_65 = load i32 addrspace(1)** %input_addr
  %tmp_66 = getelementptr i32 addrspace(1)* %tmp_65, i32 %tmp_64
  %tmp_67 = load i32 addrspace(1)* %tmp_66
  %tmp_68 = icmp sle i32 %tmp_63, %tmp_67
  %tmp_69 = sext i1 %tmp_68 to i32
  %tmp_70 = icmp ne i32 %tmp_59, 0
  br i1 %tmp_70, label %land_rhs, label %land_end

block_9:                                          ; preds = %block_11
  %tmp_48 = load i32* %i
  %tmp_49 = add i32 %tmp_48, 1
  store i32 %tmp_49, i32* %i
  br label %block_7

block_10:                                         ; preds = %block_7
  ret void

land_rhs:                                         ; preds = %block_8
  %tmp_71 = icmp ne i32 %tmp_69, 0
  br label %land_end

land_end:                                         ; preds = %land_rhs, %block_8
  %land_cond = phi i1 [ false, %block_8 ], [ %tmp_71, %land_rhs ]
  %tmp_72 = sext i1 %land_cond to i32
  %tmp_73 = icmp ne i32 %tmp_72, 0
  br i1 %tmp_73, label %block_12, label %block_11

block_11:                                         ; preds = %block_12, %land_end
  br label %block_9

block_12:                                         ; preds = %land_end
  %tmp_74 = load i32* %i
  %tmp_75 = load i32 addrspace(1)** %output_addr
  %tmp_76 = getelementptr i32 addrspace(1)* %tmp_75, i32 %tmp_74
  %tmp_77 = load i32* %lBound
  store i32 %tmp_77, i32 addrspace(1)* %tmp_76
  br label %block_11
}

define void @binarySearch_mulkeysConcurrent(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %inputSize, i32 %numSubdivisions, i32 addrspace(1)* %output) {
block_13:
  %keys_addr = alloca i32 addrspace(1)*
  store i32 addrspace(1)* %keys, i32 addrspace(1)** %keys_addr
  %input_addr = alloca i32 addrspace(1)*
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input_addr
  %inputSize_addr = alloca i32
  store i32 %inputSize, i32* %inputSize_addr
  %numSubdivisions_addr = alloca i32
  store i32 %numSubdivisions, i32* %numSubdivisions_addr
  %output_addr = alloca i32 addrspace(1)*
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output_addr
  %lBound = alloca i32
  %uBound = alloca i32
  %myKey = alloca i32
  %mid = alloca i32
  br label %block_14

block_14:                                         ; preds = %block_13
  %tmp_78 = call i32 @__get_global_id_u32(i32 0)
  %tmp_79 = load i32* %numSubdivisions_addr
  %tmp_80 = urem i32 %tmp_78, %tmp_79
  %tmp_81 = load i32* %inputSize_addr
  %tmp_82 = load i32* %numSubdivisions_addr
  %tmp_83 = udiv i32 %tmp_81, %tmp_82
  %tmp_84 = mul i32 %tmp_80, %tmp_83
  store i32 %tmp_84, i32* %lBound
  %tmp_85 = load i32* %lBound
  %tmp_86 = load i32* %inputSize_addr
  %tmp_87 = load i32* %numSubdivisions_addr
  %tmp_88 = udiv i32 %tmp_86, %tmp_87
  %tmp_89 = add i32 %tmp_85, %tmp_88
  store i32 %tmp_89, i32* %uBound
  %tmp_90 = call i32 @__get_global_id_u32(i32 0)
  %tmp_91 = load i32* %numSubdivisions_addr
  %tmp_92 = udiv i32 %tmp_90, %tmp_91
  %tmp_93 = load i32 addrspace(1)** %keys_addr
  %tmp_94 = getelementptr i32 addrspace(1)* %tmp_93, i32 %tmp_92
  %tmp_95 = load i32 addrspace(1)* %tmp_94
  store i32 %tmp_95, i32* %myKey
  br label %block_16

block_15:                                         ; preds = %block_16
  %tmp_101 = load i32* %lBound
  %tmp_102 = load i32* %uBound
  %tmp_103 = add i32 %tmp_101, %tmp_102
  %tmp_104 = sdiv i32 %tmp_103, 2
  store i32 %tmp_104, i32* %mid
  %tmp_105 = load i32* %mid
  %tmp_106 = load i32 addrspace(1)** %input_addr
  %tmp_107 = getelementptr i32 addrspace(1)* %tmp_106, i32 %tmp_105
  %tmp_108 = load i32 addrspace(1)* %tmp_107
  %tmp_109 = load i32* %myKey
  %tmp_110 = icmp eq i32 %tmp_108, %tmp_109
  %tmp_111 = sext i1 %tmp_110 to i32
  %tmp_112 = icmp ne i32 %tmp_111, 0
  br i1 %tmp_112, label %block_19, label %block_18

block_16:                                         ; preds = %block_20, %block_14
  %tmp_96 = load i32* %uBound
  %tmp_97 = load i32* %lBound
  %tmp_98 = icmp sge i32 %tmp_96, %tmp_97
  %tmp_99 = sext i1 %tmp_98 to i32
  %tmp_100 = icmp ne i32 %tmp_99, 0
  br i1 %tmp_100, label %block_15, label %block_17

block_17:                                         ; preds = %block_16
  ret void

block_18:                                         ; preds = %block_15
  %tmp_119 = load i32* %mid
  %tmp_120 = load i32 addrspace(1)** %input_addr
  %tmp_121 = getelementptr i32 addrspace(1)* %tmp_120, i32 %tmp_119
  %tmp_122 = load i32 addrspace(1)* %tmp_121
  %tmp_123 = load i32* %myKey
  %tmp_124 = icmp ugt i32 %tmp_122, %tmp_123
  %tmp_125 = sext i1 %tmp_124 to i32
  %tmp_126 = icmp ne i32 %tmp_125, 0
  br i1 %tmp_126, label %block_22, label %block_21

block_19:                                         ; preds = %block_15
  %tmp_113 = call i32 @__get_global_id_u32(i32 0)
  %tmp_114 = load i32* %numSubdivisions_addr
  %tmp_115 = udiv i32 %tmp_113, %tmp_114
  %tmp_116 = load i32 addrspace(1)** %output_addr
  %tmp_117 = getelementptr i32 addrspace(1)* %tmp_116, i32 %tmp_115
  %tmp_118 = load i32* %mid
  store i32 %tmp_118, i32 addrspace(1)* %tmp_117
  ret void

block_20:                                         ; preds = %block_23
  br label %block_16

block_21:                                         ; preds = %block_18
  %tmp_129 = load i32* %mid
  %tmp_130 = add i32 %tmp_129, 1
  store i32 %tmp_130, i32* %lBound
  br label %block_23

block_22:                                         ; preds = %block_18
  %tmp_127 = load i32* %mid
  %tmp_128 = sub i32 %tmp_127, 1
  store i32 %tmp_128, i32* %uBound
  br label %block_23

block_23:                                         ; preds = %block_22, %block_21
  br label %block_20
}

attributes #0 = { nounwind }

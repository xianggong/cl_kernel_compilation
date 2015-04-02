; ModuleID = 'BinarySearch_Kernels.opt.bc'

define void @binarySearch(<4 x i32> addrspace(1)* %outputArray, i32 addrspace(1)* %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) {
block_0:
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = mul i32 %tmp_0, %subdivSize
  %tmp_5 = add i32 %globalLowerIndex, %tmp_4
  %tmp_7 = getelementptr i32 addrspace(1)* %sortedArray, i32 %tmp_5
  %tmp_8 = load i32 addrspace(1)* %tmp_7
  %tmp_11 = add i32 %tmp_0, 1
  %tmp_13 = mul i32 %tmp_11, %subdivSize
  %tmp_14 = add i32 %globalLowerIndex, %tmp_13
  %tmp_15 = sub i32 %tmp_14, 1
  %tmp_17 = getelementptr i32 addrspace(1)* %sortedArray, i32 %tmp_15
  %tmp_18 = load i32 addrspace(1)* %tmp_17
  %tmp_21 = icmp sgt i32 %tmp_8, %findMe
  %tmp_22 = sext i1 %tmp_21 to i32
  %tmp_25 = icmp slt i32 %tmp_18, %findMe
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
  %tmp_30 = getelementptr <4 x i32> addrspace(1)* %outputArray, i32 0
  %tmp_32 = load <4 x i32> addrspace(1)* %tmp_30
  %tmp_33 = insertelement <4 x i32> %tmp_32, i32 %tmp_0, i32 0
  %tmp_35 = getelementptr <4 x i32> addrspace(1)* %outputArray, i32 0
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
  br label %block_6

block_6:                                          ; preds = %block_5
  %tmp_38 = call i32 @__get_global_id_u32(i32 0)
  %tmp_40 = mul i32 %tmp_38, 256
  %tmp_42 = add i32 %tmp_40, 255
  br label %block_7

block_7:                                          ; preds = %block_9, %block_6
  %i.0 = phi i32 [ 0, %block_6 ], [ %tmp_49, %block_9 ]
  %tmp_45 = icmp slt i32 %i.0, %numKeys
  %tmp_46 = sext i1 %tmp_45 to i32
  %tmp_47 = icmp ne i32 %tmp_46, 0
  br i1 %tmp_47, label %block_8, label %block_10

block_8:                                          ; preds = %block_7
  %tmp_52 = getelementptr i32 addrspace(1)* %keys, i32 %i.0
  %tmp_53 = load i32 addrspace(1)* %tmp_52
  %tmp_56 = getelementptr i32 addrspace(1)* %input, i32 %tmp_40
  %tmp_57 = load i32 addrspace(1)* %tmp_56
  %tmp_58 = icmp sge i32 %tmp_53, %tmp_57
  %tmp_59 = sext i1 %tmp_58 to i32
  %tmp_62 = getelementptr i32 addrspace(1)* %keys, i32 %i.0
  %tmp_63 = load i32 addrspace(1)* %tmp_62
  %tmp_66 = getelementptr i32 addrspace(1)* %input, i32 %tmp_42
  %tmp_67 = load i32 addrspace(1)* %tmp_66
  %tmp_68 = icmp sle i32 %tmp_63, %tmp_67
  %tmp_69 = sext i1 %tmp_68 to i32
  %tmp_70 = icmp ne i32 %tmp_59, 0
  br i1 %tmp_70, label %land_rhs, label %land_end

block_9:                                          ; preds = %block_11
  %tmp_49 = add i32 %i.0, 1
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
  %tmp_76 = getelementptr i32 addrspace(1)* %output, i32 %i.0
  store i32 %tmp_40, i32 addrspace(1)* %tmp_76
  br label %block_11
}

define void @binarySearch_mulkeysConcurrent(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %inputSize, i32 %numSubdivisions, i32 addrspace(1)* %output) {
block_13:
  br label %block_14

block_14:                                         ; preds = %block_13
  %tmp_78 = call i32 @__get_global_id_u32(i32 0)
  %tmp_80 = urem i32 %tmp_78, %numSubdivisions
  %tmp_83 = udiv i32 %inputSize, %numSubdivisions
  %tmp_84 = mul i32 %tmp_80, %tmp_83
  %tmp_88 = udiv i32 %inputSize, %numSubdivisions
  %tmp_89 = add i32 %tmp_84, %tmp_88
  %tmp_90 = call i32 @__get_global_id_u32(i32 0)
  %tmp_92 = udiv i32 %tmp_90, %numSubdivisions
  %tmp_94 = getelementptr i32 addrspace(1)* %keys, i32 %tmp_92
  %tmp_95 = load i32 addrspace(1)* %tmp_94
  br label %block_16

block_15:                                         ; preds = %block_16
  %tmp_103 = add i32 %lBound.0, %uBound.0
  %tmp_104 = sdiv i32 %tmp_103, 2
  %tmp_107 = getelementptr i32 addrspace(1)* %input, i32 %tmp_104
  %tmp_108 = load i32 addrspace(1)* %tmp_107
  %tmp_110 = icmp eq i32 %tmp_108, %tmp_95
  %tmp_111 = sext i1 %tmp_110 to i32
  %tmp_112 = icmp ne i32 %tmp_111, 0
  br i1 %tmp_112, label %block_19, label %block_18

block_16:                                         ; preds = %block_20, %block_14
  %lBound.0 = phi i32 [ %tmp_84, %block_14 ], [ %lBound.1, %block_20 ]
  %uBound.0 = phi i32 [ %tmp_89, %block_14 ], [ %uBound.1, %block_20 ]
  %tmp_98 = icmp sge i32 %uBound.0, %lBound.0
  %tmp_99 = sext i1 %tmp_98 to i32
  %tmp_100 = icmp ne i32 %tmp_99, 0
  br i1 %tmp_100, label %block_15, label %block_17

block_17:                                         ; preds = %block_16
  ret void

block_18:                                         ; preds = %block_15
  %tmp_121 = getelementptr i32 addrspace(1)* %input, i32 %tmp_104
  %tmp_122 = load i32 addrspace(1)* %tmp_121
  %tmp_124 = icmp ugt i32 %tmp_122, %tmp_95
  %tmp_125 = sext i1 %tmp_124 to i32
  %tmp_126 = icmp ne i32 %tmp_125, 0
  br i1 %tmp_126, label %block_22, label %block_21

block_19:                                         ; preds = %block_15
  %tmp_113 = call i32 @__get_global_id_u32(i32 0)
  %tmp_115 = udiv i32 %tmp_113, %numSubdivisions
  %tmp_117 = getelementptr i32 addrspace(1)* %output, i32 %tmp_115
  store i32 %tmp_104, i32 addrspace(1)* %tmp_117
  ret void

block_20:                                         ; preds = %block_23
  br label %block_16

block_21:                                         ; preds = %block_18
  %tmp_130 = add i32 %tmp_104, 1
  br label %block_23

block_22:                                         ; preds = %block_18
  %tmp_128 = sub i32 %tmp_104, 1
  br label %block_23

block_23:                                         ; preds = %block_22, %block_21
  %lBound.1 = phi i32 [ %lBound.0, %block_22 ], [ %tmp_130, %block_21 ]
  %uBound.1 = phi i32 [ %tmp_128, %block_22 ], [ %uBound.0, %block_21 ]
  br label %block_20
}

attributes #0 = { nounwind }

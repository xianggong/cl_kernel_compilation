; ModuleID = '../kernel-src/RadixSort_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram(i32 addrspace(1)* %unsortedData, i32 addrspace(1)* %buckets, i32 %shiftCount, i32 addrspace(3)* %sharedArray) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32 addrspace(3)*, align 4
  %localId = alloca i32, align 4
  %globalId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %numGroups = alloca i32, align 4
  %value = alloca i32, align 4
  %bucketPos = alloca i32, align 4
  store i32 addrspace(1)* %unsortedData, i32 addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %buckets, i32 addrspace(1)** %tmp_2, align 4
  store i32 %shiftCount, i32* %tmp_3, align 4
  store i32 addrspace(3)* %sharedArray, i32 addrspace(3)** %tmp_4, align 4
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_5, i32* %localId, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_6, i32* %globalId, align 4
  %tmp_7 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_7, i32* %groupId, align 4
  %tmp_8 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_8, i32* %groupSize, align 4
  %tmp_9 = call i32 @__get_global_size_u32(i32 0)
  %tmp_10 = call i32 @__get_local_size_u32(i32 0)
  %tmp_11 = udiv i32 %tmp_9, %tmp_10
  store i32 %tmp_11, i32* %numGroups, align 4
  %tmp_12 = load i32* %localId, align 4
  %tmp_13 = load i32 addrspace(3)** %tmp_4, align 4
  %tmp_14 = getelementptr inbounds i32 addrspace(3)* %tmp_13, i32 %tmp_12
  store i32 0, i32 addrspace(3)* %tmp_14, align 4
  call void @barrier(i32 1)
  %tmp_15 = load i32* %globalId, align 4
  %tmp_16 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_17 = getelementptr inbounds i32 addrspace(1)* %tmp_16, i32 %tmp_15
  %tmp_18 = load i32 addrspace(1)* %tmp_17, align 4
  store i32 %tmp_18, i32* %value, align 4
  %tmp_19 = load i32* %value, align 4
  %tmp_20 = load i32* %tmp_3, align 4
  %tmp_21 = and i32 %tmp_20, 31
  %tmp_22 = lshr i32 %tmp_19, %tmp_21
  %tmp_23 = and i32 %tmp_22, 255
  store i32 %tmp_23, i32* %value, align 4
  %tmp_24 = load i32 addrspace(3)** %tmp_4, align 4
  %tmp_25 = load i32* %value, align 4
  %tmp_26 = getelementptr inbounds i32 addrspace(3)* %tmp_24, i32 %tmp_25
  %tmp_27 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* %tmp_26, i32 1)
  call void @barrier(i32 1)
  %tmp_28 = load i32* %groupId, align 4
  %tmp_29 = load i32* %groupSize, align 4
  %tmp_30 = mul i32 %tmp_28, %tmp_29
  %tmp_31 = load i32* %localId, align 4
  %tmp_32 = add i32 %tmp_30, %tmp_31
  store i32 %tmp_32, i32* %bucketPos, align 4
  %tmp_33 = load i32* %localId, align 4
  %tmp_34 = load i32 addrspace(3)** %tmp_4, align 4
  %tmp_35 = getelementptr inbounds i32 addrspace(3)* %tmp_34, i32 %tmp_33
  %tmp_36 = load i32 addrspace(3)* %tmp_35, align 4
  %tmp_37 = load i32* %bucketPos, align 4
  %tmp_38 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_39 = getelementptr inbounds i32 addrspace(1)* %tmp_38, i32 %tmp_37
  store i32 %tmp_36, i32 addrspace(1)* %tmp_39, align 4
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

; Function Attrs: nounwind
define void @permute(i32 addrspace(1)* %unsortedData, i32 addrspace(1)* %scanedBuckets, i32 %shiftCount, i16 addrspace(3)* %sharedBuckets, i32 addrspace(1)* %sortedData) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i16 addrspace(3)*, align 4
  %tmp_5 = alloca i32 addrspace(1)*, align 4
  %groupId = alloca i32, align 4
  %localId = alloca i32, align 4
  %globalId = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %i = alloca i32, align 4
  %bucketPos = alloca i32, align 4
  %i1 = alloca i32, align 4
  %value = alloca i32, align 4
  %index = alloca i32, align 4
  store i32 addrspace(1)* %unsortedData, i32 addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %scanedBuckets, i32 addrspace(1)** %tmp_2, align 4
  store i32 %shiftCount, i32* %tmp_3, align 4
  store i16 addrspace(3)* %sharedBuckets, i16 addrspace(3)** %tmp_4, align 4
  store i32 addrspace(1)* %sortedData, i32 addrspace(1)** %tmp_5, align 4
  %tmp_6 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_6, i32* %groupId, align 4
  %tmp_7 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_7, i32* %localId, align 4
  %tmp_8 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_8, i32* %globalId, align 4
  %tmp_9 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_9, i32* %groupSize, align 4
  store i32 0, i32* %i, align 4
  br label %tmp_10

tmp_10:                                      ; preds = %tmp_34, %tmp_0
  %tmp_11 = load i32* %i, align 4
  %tmp_12 = icmp slt i32 %tmp_11, 256
  br i1 %tmp_12, label %tmp_13, label %tmp_37

tmp_13:                                      ; preds = %tmp_10
  %tmp_14 = load i32* %groupId, align 4
  %tmp_15 = mul i32 %tmp_14, 256
  %tmp_16 = load i32* %groupSize, align 4
  %tmp_17 = mul i32 %tmp_15, %tmp_16
  %tmp_18 = load i32* %localId, align 4
  %tmp_19 = mul i32 %tmp_18, 256
  %tmp_20 = add i32 %tmp_17, %tmp_19
  %tmp_21 = load i32* %i, align 4
  %tmp_22 = add i32 %tmp_20, %tmp_21
  store i32 %tmp_22, i32* %bucketPos, align 4
  %tmp_23 = load i32* %bucketPos, align 4
  %tmp_24 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_25 = getelementptr inbounds i32 addrspace(1)* %tmp_24, i32 %tmp_23
  %tmp_26 = load i32 addrspace(1)* %tmp_25, align 4
  %tmp_27 = trunc i32 %tmp_26 to i16
  %tmp_28 = load i32* %localId, align 4
  %tmp_29 = mul i32 %tmp_28, 256
  %tmp_30 = load i32* %i, align 4
  %tmp_31 = add i32 %tmp_29, %tmp_30
  %tmp_32 = load i16 addrspace(3)** %tmp_4, align 4
  %tmp_33 = getelementptr inbounds i16 addrspace(3)* %tmp_32, i32 %tmp_31
  store i16 %tmp_27, i16 addrspace(3)* %tmp_33, align 2
  br label %tmp_34

tmp_34:                                      ; preds = %tmp_13
  %tmp_35 = load i32* %i, align 4
  %tmp_36 = add nsw i32 %tmp_35, 1
  store i32 %tmp_36, i32* %i, align 4
  br label %tmp_10

tmp_37:                                      ; preds = %tmp_10
  call void @barrier(i32 1)
  store i32 0, i32* %i1, align 4
  br label %tmp_38

tmp_38:                                      ; preds = %tmp_81, %tmp_37
  %tmp_39 = load i32* %i1, align 4
  %tmp_40 = icmp slt i32 %tmp_39, 256
  br i1 %tmp_40, label %tmp_41, label %tmp_84

tmp_41:                                      ; preds = %tmp_38
  %tmp_42 = load i32* %globalId, align 4
  %tmp_43 = mul i32 %tmp_42, 256
  %tmp_44 = load i32* %i1, align 4
  %tmp_45 = add i32 %tmp_43, %tmp_44
  %tmp_46 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_47 = getelementptr inbounds i32 addrspace(1)* %tmp_46, i32 %tmp_45
  %tmp_48 = load i32 addrspace(1)* %tmp_47, align 4
  store i32 %tmp_48, i32* %value, align 4
  %tmp_49 = load i32* %value, align 4
  %tmp_50 = load i32* %tmp_3, align 4
  %tmp_51 = and i32 %tmp_50, 31
  %tmp_52 = lshr i32 %tmp_49, %tmp_51
  %tmp_53 = and i32 %tmp_52, 255
  store i32 %tmp_53, i32* %value, align 4
  %tmp_54 = load i32* %localId, align 4
  %tmp_55 = mul i32 %tmp_54, 256
  %tmp_56 = load i32* %value, align 4
  %tmp_57 = add i32 %tmp_55, %tmp_56
  %tmp_58 = load i16 addrspace(3)** %tmp_4, align 4
  %tmp_59 = getelementptr inbounds i16 addrspace(3)* %tmp_58, i32 %tmp_57
  %tmp_60 = load i16 addrspace(3)* %tmp_59, align 2
  %tmp_61 = zext i16 %tmp_60 to i32
  store i32 %tmp_61, i32* %index, align 4
  %tmp_62 = load i32* %globalId, align 4
  %tmp_63 = mul i32 %tmp_62, 256
  %tmp_64 = load i32* %i1, align 4
  %tmp_65 = add i32 %tmp_63, %tmp_64
  %tmp_66 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_67 = getelementptr inbounds i32 addrspace(1)* %tmp_66, i32 %tmp_65
  %tmp_68 = load i32 addrspace(1)* %tmp_67, align 4
  %tmp_69 = load i32* %index, align 4
  %tmp_70 = load i32 addrspace(1)** %tmp_5, align 4
  %tmp_71 = getelementptr inbounds i32 addrspace(1)* %tmp_70, i32 %tmp_69
  store i32 %tmp_68, i32 addrspace(1)* %tmp_71, align 4
  %tmp_72 = load i32* %index, align 4
  %tmp_73 = add i32 %tmp_72, 1
  %tmp_74 = trunc i32 %tmp_73 to i16
  %tmp_75 = load i32* %localId, align 4
  %tmp_76 = mul i32 %tmp_75, 256
  %tmp_77 = load i32* %value, align 4
  %tmp_78 = add i32 %tmp_76, %tmp_77
  %tmp_79 = load i16 addrspace(3)** %tmp_4, align 4
  %tmp_80 = getelementptr inbounds i16 addrspace(3)* %tmp_79, i32 %tmp_78
  store i16 %tmp_74, i16 addrspace(3)* %tmp_80, align 2
  call void @barrier(i32 1)
  br label %tmp_81

tmp_81:                                      ; preds = %tmp_41
  %tmp_82 = load i32* %i1, align 4
  %tmp_83 = add nsw i32 %tmp_82, 1
  store i32 %tmp_83, i32* %i1, align 4
  br label %tmp_38

tmp_84:                                      ; preds = %tmp_38
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim2(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size, i32 %stride, i32 addrspace(1)* %sumBuffer) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32 addrspace(3)*, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i32, align 4
  %tmp_6 = alloca i32 addrspace(1)*, align 4
  %tidx = alloca i32, align 4
  %tidy = alloca i32, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %bidx = alloca i32, align 4
  %bidy = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %gpos = alloca i32, align 4
  %groupIndex = alloca i32, align 4
  %cache = alloca i32, align 4
  %dis = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %tmp_2, align 4
  store i32 addrspace(3)* %block, i32 addrspace(3)** %tmp_3, align 4
  store i32 %block_size, i32* %tmp_4, align 4
  store i32 %stride, i32* %tmp_5, align 4
  store i32 addrspace(1)* %sumBuffer, i32 addrspace(1)** %tmp_6, align 4
  %tmp_7 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_7, i32* %tidx, align 4
  %tmp_8 = call i32 @__get_local_id_u32(i32 1)
  store i32 %tmp_8, i32* %tidy, align 4
  %tmp_9 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_9, i32* %gidx, align 4
  %tmp_10 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_10, i32* %gidy, align 4
  %tmp_11 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_11, i32* %bidx, align 4
  %tmp_12 = call i32 @__get_group_id_u32(i32 1)
  store i32 %tmp_12, i32* %bidy, align 4
  %tmp_13 = load i32* %tidy, align 4
  %tmp_14 = load i32* %tmp_4, align 4
  %tmp_15 = mul i32 %tmp_13, %tmp_14
  %tmp_16 = load i32* %tidx, align 4
  %tmp_17 = add i32 %tmp_15, %tmp_16
  store i32 %tmp_17, i32* %lIndex, align 4
  %tmp_18 = load i32* %gidx, align 4
  %tmp_19 = shl i32 %tmp_18, 8
  %tmp_20 = load i32* %gidy, align 4
  %tmp_21 = add nsw i32 %tmp_19, %tmp_20
  store i32 %tmp_21, i32* %gpos, align 4
  %tmp_22 = load i32* %bidy, align 4
  %tmp_23 = call i32 @__get_global_size_u32(i32 0)
  %tmp_24 = load i32* %tmp_4, align 4
  %tmp_25 = udiv i32 %tmp_23, %tmp_24
  %tmp_26 = mul i32 %tmp_22, %tmp_25
  %tmp_27 = load i32* %bidx, align 4
  %tmp_28 = add i32 %tmp_26, %tmp_27
  store i32 %tmp_28, i32* %groupIndex, align 4
  %tmp_29 = load i32* %gpos, align 4
  %tmp_30 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_31 = getelementptr inbounds i32 addrspace(1)* %tmp_30, i32 %tmp_29
  %tmp_32 = load i32 addrspace(1)* %tmp_31, align 4
  %tmp_33 = load i32* %tidx, align 4
  %tmp_34 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_35 = getelementptr inbounds i32 addrspace(3)* %tmp_34, i32 %tmp_33
  store i32 %tmp_32, i32 addrspace(3)* %tmp_35, align 4
  call void @barrier(i32 1)
  %tmp_36 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_37 = getelementptr inbounds i32 addrspace(3)* %tmp_36, i32 0
  %tmp_38 = load i32 addrspace(3)* %tmp_37, align 4
  store i32 %tmp_38, i32* %cache, align 4
  store i32 1, i32* %dis, align 4
  br label %tmp_39

tmp_39:                                      ; preds = %tmp_64, %tmp_0
  %tmp_40 = load i32* %dis, align 4
  %tmp_41 = load i32* %tmp_4, align 4
  %tmp_42 = icmp ult i32 %tmp_40, %tmp_41
  br i1 %tmp_42, label %tmp_43, label %tmp_67

tmp_43:                                      ; preds = %tmp_39
  %tmp_44 = load i32* %tidx, align 4
  %tmp_45 = load i32* %dis, align 4
  %tmp_46 = icmp sge i32 %tmp_44, %tmp_45
  br i1 %tmp_46, label %tmp_47, label %tmp_59

tmp_47:                                      ; preds = %tmp_43
  %tmp_48 = load i32* %tidx, align 4
  %tmp_49 = load i32* %dis, align 4
  %tmp_50 = sub nsw i32 %tmp_48, %tmp_49
  %tmp_51 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_52 = getelementptr inbounds i32 addrspace(3)* %tmp_51, i32 %tmp_50
  %tmp_53 = load i32 addrspace(3)* %tmp_52, align 4
  %tmp_54 = load i32* %tidx, align 4
  %tmp_55 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_56 = getelementptr inbounds i32 addrspace(3)* %tmp_55, i32 %tmp_54
  %tmp_57 = load i32 addrspace(3)* %tmp_56, align 4
  %tmp_58 = add i32 %tmp_53, %tmp_57
  store i32 %tmp_58, i32* %cache, align 4
  br label %tmp_59

tmp_59:                                      ; preds = %tmp_47, %tmp_43
  call void @barrier(i32 1)
  %tmp_60 = load i32* %cache, align 4
  %tmp_61 = load i32* %tidx, align 4
  %tmp_62 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_63 = getelementptr inbounds i32 addrspace(3)* %tmp_62, i32 %tmp_61
  store i32 %tmp_60, i32 addrspace(3)* %tmp_63, align 4
  call void @barrier(i32 1)
  br label %tmp_64

tmp_64:                                      ; preds = %tmp_59
  %tmp_65 = load i32* %dis, align 4
  %tmp_66 = mul nsw i32 %tmp_65, 2
  store i32 %tmp_66, i32* %dis, align 4
  br label %tmp_39

tmp_67:                                      ; preds = %tmp_39
  %tmp_68 = load i32* %tmp_4, align 4
  %tmp_69 = sub i32 %tmp_68, 1
  %tmp_70 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_71 = getelementptr inbounds i32 addrspace(3)* %tmp_70, i32 %tmp_69
  %tmp_72 = load i32 addrspace(3)* %tmp_71, align 4
  %tmp_73 = load i32* %groupIndex, align 4
  %tmp_74 = load i32 addrspace(1)** %tmp_6, align 4
  %tmp_75 = getelementptr inbounds i32 addrspace(1)* %tmp_74, i32 %tmp_73
  store i32 %tmp_72, i32 addrspace(1)* %tmp_75, align 4
  %tmp_76 = load i32* %tidx, align 4
  %tmp_77 = icmp eq i32 %tmp_76, 0
  br i1 %tmp_77, label %tmp_78, label %tmp_82

tmp_78:                                      ; preds = %tmp_67
  %tmp_79 = load i32* %gpos, align 4
  %tmp_80 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_81 = getelementptr inbounds i32 addrspace(1)* %tmp_80, i32 %tmp_79
  store i32 0, i32 addrspace(1)* %tmp_81, align 4
  br label %tmp_91

tmp_82:                                      ; preds = %tmp_67
  %tmp_83 = load i32* %tidx, align 4
  %tmp_84 = sub nsw i32 %tmp_83, 1
  %tmp_85 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_86 = getelementptr inbounds i32 addrspace(3)* %tmp_85, i32 %tmp_84
  %tmp_87 = load i32 addrspace(3)* %tmp_86, align 4
  %tmp_88 = load i32* %gpos, align 4
  %tmp_89 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_90 = getelementptr inbounds i32 addrspace(1)* %tmp_89, i32 %tmp_88
  store i32 %tmp_87, i32 addrspace(1)* %tmp_90, align 4
  br label %tmp_91

tmp_91:                                      ; preds = %tmp_82, %tmp_78
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim1(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32 addrspace(3)*, align 4
  %tmp_4 = alloca i32, align 4
  %tid = alloca i32, align 4
  %gid = alloca i32, align 4
  %bid = alloca i32, align 4
  %cache = alloca i32, align 4
  %stride = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %tmp_2, align 4
  store i32 addrspace(3)* %block, i32 addrspace(3)** %tmp_3, align 4
  store i32 %block_size, i32* %tmp_4, align 4
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_5, i32* %tid, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_6, i32* %gid, align 4
  %tmp_7 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_7, i32* %bid, align 4
  %tmp_8 = load i32* %gid, align 4
  %tmp_9 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_10 = getelementptr inbounds i32 addrspace(1)* %tmp_9, i32 %tmp_8
  %tmp_11 = load i32 addrspace(1)* %tmp_10, align 4
  %tmp_12 = load i32* %tid, align 4
  %tmp_13 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_14 = getelementptr inbounds i32 addrspace(3)* %tmp_13, i32 %tmp_12
  store i32 %tmp_11, i32 addrspace(3)* %tmp_14, align 4
  %tmp_15 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_16 = getelementptr inbounds i32 addrspace(3)* %tmp_15, i32 0
  %tmp_17 = load i32 addrspace(3)* %tmp_16, align 4
  store i32 %tmp_17, i32* %cache, align 4
  store i32 1, i32* %stride, align 4
  br label %tmp_18

tmp_18:                                      ; preds = %tmp_43, %tmp_0
  %tmp_19 = load i32* %stride, align 4
  %tmp_20 = load i32* %tmp_4, align 4
  %tmp_21 = icmp ult i32 %tmp_19, %tmp_20
  br i1 %tmp_21, label %tmp_22, label %tmp_46

tmp_22:                                      ; preds = %tmp_18
  %tmp_23 = load i32* %tid, align 4
  %tmp_24 = load i32* %stride, align 4
  %tmp_25 = icmp sge i32 %tmp_23, %tmp_24
  br i1 %tmp_25, label %tmp_26, label %tmp_38

tmp_26:                                      ; preds = %tmp_22
  %tmp_27 = load i32* %tid, align 4
  %tmp_28 = load i32* %stride, align 4
  %tmp_29 = sub nsw i32 %tmp_27, %tmp_28
  %tmp_30 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_31 = getelementptr inbounds i32 addrspace(3)* %tmp_30, i32 %tmp_29
  %tmp_32 = load i32 addrspace(3)* %tmp_31, align 4
  %tmp_33 = load i32* %tid, align 4
  %tmp_34 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_35 = getelementptr inbounds i32 addrspace(3)* %tmp_34, i32 %tmp_33
  %tmp_36 = load i32 addrspace(3)* %tmp_35, align 4
  %tmp_37 = add i32 %tmp_32, %tmp_36
  store i32 %tmp_37, i32* %cache, align 4
  br label %tmp_38

tmp_38:                                      ; preds = %tmp_26, %tmp_22
  call void @barrier(i32 1)
  %tmp_39 = load i32* %cache, align 4
  %tmp_40 = load i32* %tid, align 4
  %tmp_41 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_42 = getelementptr inbounds i32 addrspace(3)* %tmp_41, i32 %tmp_40
  store i32 %tmp_39, i32 addrspace(3)* %tmp_42, align 4
  call void @barrier(i32 1)
  br label %tmp_43

tmp_43:                                      ; preds = %tmp_38
  %tmp_44 = load i32* %stride, align 4
  %tmp_45 = mul nsw i32 %tmp_44, 2
  store i32 %tmp_45, i32* %stride, align 4
  br label %tmp_18

tmp_46:                                      ; preds = %tmp_18
  %tmp_47 = load i32* %tid, align 4
  %tmp_48 = icmp eq i32 %tmp_47, 0
  br i1 %tmp_48, label %tmp_49, label %tmp_53

tmp_49:                                      ; preds = %tmp_46
  %tmp_50 = load i32* %gid, align 4
  %tmp_51 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_52 = getelementptr inbounds i32 addrspace(1)* %tmp_51, i32 %tmp_50
  store i32 0, i32 addrspace(1)* %tmp_52, align 4
  br label %tmp_62

tmp_53:                                      ; preds = %tmp_46
  %tmp_54 = load i32* %tid, align 4
  %tmp_55 = sub nsw i32 %tmp_54, 1
  %tmp_56 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_57 = getelementptr inbounds i32 addrspace(3)* %tmp_56, i32 %tmp_55
  %tmp_58 = load i32 addrspace(3)* %tmp_57, align 4
  %tmp_59 = load i32* %gid, align 4
  %tmp_60 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_61 = getelementptr inbounds i32 addrspace(1)* %tmp_60, i32 %tmp_59
  store i32 %tmp_58, i32 addrspace(1)* %tmp_61, align 4
  br label %tmp_62

tmp_62:                                      ; preds = %tmp_53, %tmp_49
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(1)* %summary, i32 %stride) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32 addrspace(1)*, align 4
  %tmp_4 = alloca i32, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %Index = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %tmp_2, align 4
  store i32 addrspace(1)* %summary, i32 addrspace(1)** %tmp_3, align 4
  store i32 %stride, i32* %tmp_4, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_5, i32* %gidx, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_6, i32* %gidy, align 4
  %tmp_7 = load i32* %gidy, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  %tmp_9 = mul nsw i32 %tmp_7, %tmp_8
  %tmp_10 = load i32* %gidx, align 4
  %tmp_11 = add nsw i32 %tmp_9, %tmp_10
  store i32 %tmp_11, i32* %Index, align 4
  %tmp_12 = load i32* %Index, align 4
  %tmp_13 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_14 = getelementptr inbounds i32 addrspace(1)* %tmp_13, i32 %tmp_12
  store i32 0, i32 addrspace(1)* %tmp_14, align 4
  %tmp_15 = load i32* %gidx, align 4
  %tmp_16 = icmp sgt i32 %tmp_15, 0
  br i1 %tmp_16, label %tmp_17, label %tmp_40

tmp_17:                                      ; preds = %tmp_0
  store i32 0, i32* %i, align 4
  br label %tmp_18

tmp_18:                                      ; preds = %tmp_36, %tmp_17
  %tmp_19 = load i32* %i, align 4
  %tmp_20 = load i32* %gidx, align 4
  %tmp_21 = icmp slt i32 %tmp_19, %tmp_20
  br i1 %tmp_21, label %tmp_22, label %tmp_39

tmp_22:                                      ; preds = %tmp_18
  %tmp_23 = load i32* %gidy, align 4
  %tmp_24 = load i32* %tmp_4, align 4
  %tmp_25 = mul nsw i32 %tmp_23, %tmp_24
  %tmp_26 = load i32* %i, align 4
  %tmp_27 = add nsw i32 %tmp_25, %tmp_26
  %tmp_28 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_29 = getelementptr inbounds i32 addrspace(1)* %tmp_28, i32 %tmp_27
  %tmp_30 = load i32 addrspace(1)* %tmp_29, align 4
  %tmp_31 = load i32* %Index, align 4
  %tmp_32 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_33 = getelementptr inbounds i32 addrspace(1)* %tmp_32, i32 %tmp_31
  %tmp_34 = load i32 addrspace(1)* %tmp_33, align 4
  %tmp_35 = add i32 %tmp_34, %tmp_30
  store i32 %tmp_35, i32 addrspace(1)* %tmp_33, align 4
  br label %tmp_36

tmp_36:                                      ; preds = %tmp_22
  %tmp_37 = load i32* %i, align 4
  %tmp_38 = add nsw i32 %tmp_37, 1
  store i32 %tmp_38, i32* %i, align 4
  br label %tmp_18

tmp_39:                                      ; preds = %tmp_18
  br label %tmp_40

tmp_40:                                      ; preds = %tmp_39, %tmp_0
  %tmp_41 = load i32* %gidx, align 4
  %tmp_42 = load i32* %tmp_4, align 4
  %tmp_43 = sub nsw i32 %tmp_42, 1
  %tmp_44 = icmp eq i32 %tmp_41, %tmp_43
  br i1 %tmp_44, label %tmp_45, label %tmp_63

tmp_45:                                      ; preds = %tmp_40
  %tmp_46 = load i32* %Index, align 4
  %tmp_47 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_48 = getelementptr inbounds i32 addrspace(1)* %tmp_47, i32 %tmp_46
  %tmp_49 = load i32 addrspace(1)* %tmp_48, align 4
  %tmp_50 = load i32* %gidy, align 4
  %tmp_51 = load i32* %tmp_4, align 4
  %tmp_52 = mul nsw i32 %tmp_50, %tmp_51
  %tmp_53 = load i32* %tmp_4, align 4
  %tmp_54 = sub nsw i32 %tmp_53, 1
  %tmp_55 = add nsw i32 %tmp_52, %tmp_54
  %tmp_56 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_57 = getelementptr inbounds i32 addrspace(1)* %tmp_56, i32 %tmp_55
  %tmp_58 = load i32 addrspace(1)* %tmp_57, align 4
  %tmp_59 = add i32 %tmp_49, %tmp_58
  %tmp_60 = load i32* %gidy, align 4
  %tmp_61 = load i32 addrspace(1)** %tmp_3, align 4
  %tmp_62 = getelementptr inbounds i32 addrspace(1)* %tmp_61, i32 %tmp_60
  store i32 %tmp_59, i32 addrspace(1)* %tmp_62, align 4
  br label %tmp_63

tmp_63:                                      ; preds = %tmp_45, %tmp_40
  ret void
}

; Function Attrs: nounwind
define void @blockAddition(i32 addrspace(1)* %input, i32 addrspace(1)* %output, i32 %stride) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %bidx = alloca i32, align 4
  %bidy = alloca i32, align 4
  %gpos = alloca i32, align 4
  %groupIndex = alloca i32, align 4
  %temp = alloca i32, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %tmp_2, align 4
  store i32 %stride, i32* %tmp_3, align 4
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_4, i32* %gidx, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_5, i32* %gidy, align 4
  %tmp_6 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_6, i32* %bidx, align 4
  %tmp_7 = call i32 @__get_group_id_u32(i32 1)
  store i32 %tmp_7, i32* %bidy, align 4
  %tmp_8 = load i32* %gidy, align 4
  %tmp_9 = load i32* %gidx, align 4
  %tmp_10 = shl i32 %tmp_9, 8
  %tmp_11 = add nsw i32 %tmp_8, %tmp_10
  store i32 %tmp_11, i32* %gpos, align 4
  %tmp_12 = load i32* %bidy, align 4
  %tmp_13 = load i32* %tmp_3, align 4
  %tmp_14 = mul i32 %tmp_12, %tmp_13
  %tmp_15 = load i32* %bidx, align 4
  %tmp_16 = add i32 %tmp_14, %tmp_15
  store i32 %tmp_16, i32* %groupIndex, align 4
  %tmp_17 = load i32* %groupIndex, align 4
  %tmp_18 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_19 = getelementptr inbounds i32 addrspace(1)* %tmp_18, i32 %tmp_17
  %tmp_20 = load i32 addrspace(1)* %tmp_19, align 4
  store i32 %tmp_20, i32* %temp, align 4
  %tmp_21 = load i32* %temp, align 4
  %tmp_22 = load i32* %gpos, align 4
  %tmp_23 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_24 = getelementptr inbounds i32 addrspace(1)* %tmp_23, i32 %tmp_22
  %tmp_25 = load i32 addrspace(1)* %tmp_24, align 4
  %tmp_26 = add i32 %tmp_25, %tmp_21
  store i32 %tmp_26, i32 addrspace(1)* %tmp_24, align 4
  ret void
}

; Function Attrs: nounwind
define void @FixOffset(i32 addrspace(1)* %input, i32 addrspace(1)* %output) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %gpos = alloca i32, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %tmp_2, align 4
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_3, i32* %gidx, align 4
  %tmp_4 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_4, i32* %gidy, align 4
  %tmp_5 = load i32* %gidy, align 4
  %tmp_6 = load i32* %gidx, align 4
  %tmp_7 = shl i32 %tmp_6, 8
  %tmp_8 = add nsw i32 %tmp_5, %tmp_7
  store i32 %tmp_8, i32* %gpos, align 4
  %tmp_9 = load i32* %gidy, align 4
  %tmp_10 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_11 = getelementptr inbounds i32 addrspace(1)* %tmp_10, i32 %tmp_9
  %tmp_12 = load i32 addrspace(1)* %tmp_11, align 4
  %tmp_13 = load i32* %gpos, align 4
  %tmp_14 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_15 = getelementptr inbounds i32 addrspace(1)* %tmp_14, i32 %tmp_13
  %tmp_16 = load i32 addrspace(1)* %tmp_15, align 4
  %tmp_17 = add i32 %tmp_16, %tmp_12
  store i32 %tmp_17, i32 addrspace(1)* %tmp_15, align 4
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(3)*)* @histogram}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i16 addrspace(3)*, i32 addrspace(1)*)* @permute}
!2 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32, i32, i32 addrspace(1)*)* @ScanArraysdim2}
!3 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32)* @ScanArraysdim1}
!4 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*, i32)* @prefixSum}
!5 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @blockAddition}
!6 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @FixOffset}
!7 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

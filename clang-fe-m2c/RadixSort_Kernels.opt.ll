; ModuleID = 'RadixSort_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram(i32 addrspace(1)* %unsortedData, i32 addrspace(1)* %buckets, i32 %shiftCount, i32 addrspace(3)* %sharedArray) #0 {
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_7 = call i32 @__get_group_id_u32(i32 0)
  %tmp_8 = call i32 @__get_local_size_u32(i32 0)
  %tmp_9 = call i32 @__get_global_size_u32(i32 0)
  %tmp_10 = call i32 @__get_local_size_u32(i32 0)
  %tmp_11 = udiv i32 %tmp_9, %tmp_10
  %tmp_14 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %tmp_5
  store i32 0, i32 addrspace(3)* %tmp_14, align 4
  call void @barrier(i32 1)
  %tmp_17 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %tmp_6
  %tmp_18 = load i32 addrspace(1)* %tmp_17, align 4
  %tmp_21 = and i32 %shiftCount, 31
  %tmp_22 = lshr i32 %tmp_18, %tmp_21
  %tmp_23 = and i32 %tmp_22, 255
  %tmp_26 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %tmp_23
  %tmp_27 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* %tmp_26, i32 1)
  call void @barrier(i32 1)
  %tmp_30 = mul i32 %tmp_7, %tmp_8
  %tmp_32 = add i32 %tmp_30, %tmp_5
  %tmp_35 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %tmp_5
  %tmp_36 = load i32 addrspace(3)* %tmp_35, align 4
  %tmp_39 = getelementptr inbounds i32 addrspace(1)* %buckets, i32 %tmp_32
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
  %tmp_6 = call i32 @__get_group_id_u32(i32 0)
  %tmp_7 = call i32 @__get_local_id_u32(i32 0)
  %tmp_8 = call i32 @__get_global_id_u32(i32 0)
  %tmp_9 = call i32 @__get_local_size_u32(i32 0)
  br label %tmp_10

tmp_10:                                           ; preds = %tmp_34, %0
  %i.0 = phi i32 [ 0, %0 ], [ %tmp_36, %tmp_34 ]
  %tmp_12 = icmp slt i32 %i.0, 256
  br i1 %tmp_12, label %tmp_13, label %tmp_37

tmp_13:                                           ; preds = %tmp_10
  %tmp_15 = mul i32 %tmp_6, 256
  %tmp_17 = mul i32 %tmp_15, %tmp_9
  %tmp_19 = mul i32 %tmp_7, 256
  %tmp_20 = add i32 %tmp_17, %tmp_19
  %tmp_22 = add i32 %tmp_20, %i.0
  %tmp_25 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %tmp_22
  %tmp_26 = load i32 addrspace(1)* %tmp_25, align 4
  %tmp_27 = trunc i32 %tmp_26 to i16
  %tmp_29 = mul i32 %tmp_7, 256
  %tmp_31 = add i32 %tmp_29, %i.0
  %tmp_33 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %tmp_31
  store i16 %tmp_27, i16 addrspace(3)* %tmp_33, align 2
  br label %tmp_34

tmp_34:                                           ; preds = %tmp_13
  %tmp_36 = add nsw i32 %i.0, 1
  br label %tmp_10

tmp_37:                                           ; preds = %tmp_10
  call void @barrier(i32 1)
  br label %tmp_38

tmp_38:                                           ; preds = %tmp_81, %tmp_37
  %i1.0 = phi i32 [ 0, %tmp_37 ], [ %tmp_83, %tmp_81 ]
  %tmp_40 = icmp slt i32 %i1.0, 256
  br i1 %tmp_40, label %tmp_41, label %tmp_84

tmp_41:                                           ; preds = %tmp_38
  %tmp_43 = mul i32 %tmp_8, 256
  %tmp_45 = add i32 %tmp_43, %i1.0
  %tmp_47 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %tmp_45
  %tmp_48 = load i32 addrspace(1)* %tmp_47, align 4
  %tmp_51 = and i32 %shiftCount, 31
  %tmp_52 = lshr i32 %tmp_48, %tmp_51
  %tmp_53 = and i32 %tmp_52, 255
  %tmp_55 = mul i32 %tmp_7, 256
  %tmp_57 = add i32 %tmp_55, %tmp_53
  %tmp_59 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %tmp_57
  %tmp_60 = load i16 addrspace(3)* %tmp_59, align 2
  %tmp_61 = zext i16 %tmp_60 to i32
  %tmp_63 = mul i32 %tmp_8, 256
  %tmp_65 = add i32 %tmp_63, %i1.0
  %tmp_67 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %tmp_65
  %tmp_68 = load i32 addrspace(1)* %tmp_67, align 4
  %tmp_71 = getelementptr inbounds i32 addrspace(1)* %sortedData, i32 %tmp_61
  store i32 %tmp_68, i32 addrspace(1)* %tmp_71, align 4
  %tmp_73 = add i32 %tmp_61, 1
  %tmp_74 = trunc i32 %tmp_73 to i16
  %tmp_76 = mul i32 %tmp_7, 256
  %tmp_78 = add i32 %tmp_76, %tmp_53
  %tmp_80 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %tmp_78
  store i16 %tmp_74, i16 addrspace(3)* %tmp_80, align 2
  call void @barrier(i32 1)
  br label %tmp_81

tmp_81:                                           ; preds = %tmp_41
  %tmp_83 = add nsw i32 %i1.0, 1
  br label %tmp_38

tmp_84:                                           ; preds = %tmp_38
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim2(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size, i32 %stride, i32 addrspace(1)* %sumBuffer) #0 {
  %tmp_7 = call i32 @__get_local_id_u32(i32 0)
  %tmp_8 = call i32 @__get_local_id_u32(i32 1)
  %tmp_9 = call i32 @__get_global_id_u32(i32 0)
  %tmp_10 = call i32 @__get_global_id_u32(i32 1)
  %tmp_11 = call i32 @__get_group_id_u32(i32 0)
  %tmp_12 = call i32 @__get_group_id_u32(i32 1)
  %tmp_15 = mul i32 %tmp_8, %block_size
  %tmp_17 = add i32 %tmp_15, %tmp_7
  %tmp_19 = shl i32 %tmp_9, 8
  %tmp_21 = add nsw i32 %tmp_19, %tmp_10
  %tmp_23 = call i32 @__get_global_size_u32(i32 0)
  %tmp_25 = udiv i32 %tmp_23, %block_size
  %tmp_26 = mul i32 %tmp_12, %tmp_25
  %tmp_28 = add i32 %tmp_26, %tmp_11
  %tmp_31 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_21
  %tmp_32 = load i32 addrspace(1)* %tmp_31, align 4
  %tmp_35 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_7
  store i32 %tmp_32, i32 addrspace(3)* %tmp_35, align 4
  call void @barrier(i32 1)
  %tmp_37 = getelementptr inbounds i32 addrspace(3)* %block, i32 0
  %tmp_38 = load i32 addrspace(3)* %tmp_37, align 4
  br label %tmp_39

tmp_39:                                           ; preds = %tmp_64, %0
  %cache.0 = phi i32 [ %tmp_38, %0 ], [ %cache.1, %tmp_64 ]
  %dis.0 = phi i32 [ 1, %0 ], [ %tmp_66, %tmp_64 ]
  %tmp_42 = icmp ult i32 %dis.0, %block_size
  br i1 %tmp_42, label %tmp_43, label %tmp_67

tmp_43:                                           ; preds = %tmp_39
  %tmp_46 = icmp sge i32 %tmp_7, %dis.0
  br i1 %tmp_46, label %tmp_47, label %tmp_59

tmp_47:                                           ; preds = %tmp_43
  %tmp_50 = sub nsw i32 %tmp_7, %dis.0
  %tmp_52 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_50
  %tmp_53 = load i32 addrspace(3)* %tmp_52, align 4
  %tmp_56 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_7
  %tmp_57 = load i32 addrspace(3)* %tmp_56, align 4
  %tmp_58 = add i32 %tmp_53, %tmp_57
  br label %tmp_59

tmp_59:                                           ; preds = %tmp_47, %tmp_43
  %cache.1 = phi i32 [ %tmp_58, %tmp_47 ], [ %cache.0, %tmp_43 ]
  call void @barrier(i32 1)
  %tmp_63 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_7
  store i32 %cache.1, i32 addrspace(3)* %tmp_63, align 4
  call void @barrier(i32 1)
  br label %tmp_64

tmp_64:                                           ; preds = %tmp_59
  %tmp_66 = mul nsw i32 %dis.0, 2
  br label %tmp_39

tmp_67:                                           ; preds = %tmp_39
  %tmp_69 = sub i32 %block_size, 1
  %tmp_71 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_69
  %tmp_72 = load i32 addrspace(3)* %tmp_71, align 4
  %tmp_75 = getelementptr inbounds i32 addrspace(1)* %sumBuffer, i32 %tmp_28
  store i32 %tmp_72, i32 addrspace(1)* %tmp_75, align 4
  %tmp_77 = icmp eq i32 %tmp_7, 0
  br i1 %tmp_77, label %tmp_78, label %tmp_82

tmp_78:                                           ; preds = %tmp_67
  %tmp_81 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_21
  store i32 0, i32 addrspace(1)* %tmp_81, align 4
  br label %tmp_91

tmp_82:                                           ; preds = %tmp_67
  %tmp_84 = sub nsw i32 %tmp_7, 1
  %tmp_86 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_84
  %tmp_87 = load i32 addrspace(3)* %tmp_86, align 4
  %tmp_90 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_21
  store i32 %tmp_87, i32 addrspace(1)* %tmp_90, align 4
  br label %tmp_91

tmp_91:                                           ; preds = %tmp_82, %tmp_78
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim1(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size) #0 {
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_7 = call i32 @__get_group_id_u32(i32 0)
  %tmp_10 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_6
  %tmp_11 = load i32 addrspace(1)* %tmp_10, align 4
  %tmp_14 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_5
  store i32 %tmp_11, i32 addrspace(3)* %tmp_14, align 4
  %tmp_16 = getelementptr inbounds i32 addrspace(3)* %block, i32 0
  %tmp_17 = load i32 addrspace(3)* %tmp_16, align 4
  br label %tmp_18

tmp_18:                                           ; preds = %tmp_43, %0
  %cache.0 = phi i32 [ %tmp_17, %0 ], [ %cache.1, %tmp_43 ]
  %stride.0 = phi i32 [ 1, %0 ], [ %tmp_45, %tmp_43 ]
  %tmp_21 = icmp ult i32 %stride.0, %block_size
  br i1 %tmp_21, label %tmp_22, label %tmp_46

tmp_22:                                           ; preds = %tmp_18
  %tmp_25 = icmp sge i32 %tmp_5, %stride.0
  br i1 %tmp_25, label %tmp_26, label %tmp_38

tmp_26:                                           ; preds = %tmp_22
  %tmp_29 = sub nsw i32 %tmp_5, %stride.0
  %tmp_31 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_29
  %tmp_32 = load i32 addrspace(3)* %tmp_31, align 4
  %tmp_35 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_5
  %tmp_36 = load i32 addrspace(3)* %tmp_35, align 4
  %tmp_37 = add i32 %tmp_32, %tmp_36
  br label %tmp_38

tmp_38:                                           ; preds = %tmp_26, %tmp_22
  %cache.1 = phi i32 [ %tmp_37, %tmp_26 ], [ %cache.0, %tmp_22 ]
  call void @barrier(i32 1)
  %tmp_42 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_5
  store i32 %cache.1, i32 addrspace(3)* %tmp_42, align 4
  call void @barrier(i32 1)
  br label %tmp_43

tmp_43:                                           ; preds = %tmp_38
  %tmp_45 = mul nsw i32 %stride.0, 2
  br label %tmp_18

tmp_46:                                           ; preds = %tmp_18
  %tmp_48 = icmp eq i32 %tmp_5, 0
  br i1 %tmp_48, label %tmp_49, label %tmp_53

tmp_49:                                           ; preds = %tmp_46
  %tmp_52 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_6
  store i32 0, i32 addrspace(1)* %tmp_52, align 4
  br label %tmp_62

tmp_53:                                           ; preds = %tmp_46
  %tmp_55 = sub nsw i32 %tmp_5, 1
  %tmp_57 = getelementptr inbounds i32 addrspace(3)* %block, i32 %tmp_55
  %tmp_58 = load i32 addrspace(3)* %tmp_57, align 4
  %tmp_61 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_6
  store i32 %tmp_58, i32 addrspace(1)* %tmp_61, align 4
  br label %tmp_62

tmp_62:                                           ; preds = %tmp_53, %tmp_49
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(1)* %summary, i32 %stride) #0 {
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_id_u32(i32 1)
  %tmp_9 = mul nsw i32 %tmp_6, %stride
  %tmp_11 = add nsw i32 %tmp_9, %tmp_5
  %tmp_14 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_11
  store i32 0, i32 addrspace(1)* %tmp_14, align 4
  %tmp_16 = icmp sgt i32 %tmp_5, 0
  br i1 %tmp_16, label %tmp_17, label %tmp_40

tmp_17:                                           ; preds = %0
  br label %tmp_18

tmp_18:                                           ; preds = %tmp_36, %tmp_17
  %i.0 = phi i32 [ 0, %tmp_17 ], [ %tmp_38, %tmp_36 ]
  %tmp_21 = icmp slt i32 %i.0, %tmp_5
  br i1 %tmp_21, label %tmp_22, label %tmp_39

tmp_22:                                           ; preds = %tmp_18
  %tmp_25 = mul nsw i32 %tmp_6, %stride
  %tmp_27 = add nsw i32 %tmp_25, %i.0
  %tmp_29 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_27
  %tmp_30 = load i32 addrspace(1)* %tmp_29, align 4
  %tmp_33 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_11
  %tmp_34 = load i32 addrspace(1)* %tmp_33, align 4
  %tmp_35 = add i32 %tmp_34, %tmp_30
  store i32 %tmp_35, i32 addrspace(1)* %tmp_33, align 4
  br label %tmp_36

tmp_36:                                           ; preds = %tmp_22
  %tmp_38 = add nsw i32 %i.0, 1
  br label %tmp_18

tmp_39:                                           ; preds = %tmp_18
  br label %tmp_40

tmp_40:                                           ; preds = %tmp_39, %0
  %tmp_43 = sub nsw i32 %stride, 1
  %tmp_44 = icmp eq i32 %tmp_5, %tmp_43
  br i1 %tmp_44, label %tmp_45, label %tmp_63

tmp_45:                                           ; preds = %tmp_40
  %tmp_48 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_11
  %tmp_49 = load i32 addrspace(1)* %tmp_48, align 4
  %tmp_52 = mul nsw i32 %tmp_6, %stride
  %tmp_54 = sub nsw i32 %stride, 1
  %tmp_55 = add nsw i32 %tmp_52, %tmp_54
  %tmp_57 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_55
  %tmp_58 = load i32 addrspace(1)* %tmp_57, align 4
  %tmp_59 = add i32 %tmp_49, %tmp_58
  %tmp_62 = getelementptr inbounds i32 addrspace(1)* %summary, i32 %tmp_6
  store i32 %tmp_59, i32 addrspace(1)* %tmp_62, align 4
  br label %tmp_63

tmp_63:                                           ; preds = %tmp_45, %tmp_40
  ret void
}

; Function Attrs: nounwind
define void @blockAddition(i32 addrspace(1)* %input, i32 addrspace(1)* %output, i32 %stride) #0 {
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = call i32 @__get_global_id_u32(i32 1)
  %tmp_6 = call i32 @__get_group_id_u32(i32 0)
  %tmp_7 = call i32 @__get_group_id_u32(i32 1)
  %tmp_10 = shl i32 %tmp_4, 8
  %tmp_11 = add nsw i32 %tmp_5, %tmp_10
  %tmp_14 = mul i32 %tmp_7, %stride
  %tmp_16 = add i32 %tmp_14, %tmp_6
  %tmp_19 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_16
  %tmp_20 = load i32 addrspace(1)* %tmp_19, align 4
  %tmp_24 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_11
  %tmp_25 = load i32 addrspace(1)* %tmp_24, align 4
  %tmp_26 = add i32 %tmp_25, %tmp_20
  store i32 %tmp_26, i32 addrspace(1)* %tmp_24, align 4
  ret void
}

; Function Attrs: nounwind
define void @FixOffset(i32 addrspace(1)* %input, i32 addrspace(1)* %output) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = call i32 @__get_global_id_u32(i32 1)
  %tmp_7 = shl i32 %tmp_3, 8
  %tmp_8 = add nsw i32 %tmp_4, %tmp_7
  %tmp_11 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_4
  %tmp_12 = load i32 addrspace(1)* %tmp_11, align 4
  %tmp_15 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_8
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

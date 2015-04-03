; ModuleID = 'BinarySearch_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @binarySearch(<4 x i32> addrspace(1)* %outputArray, i32 addrspace(1)* %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) #0 {
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_10 = mul i32 %tmp_6, %subdivSize
  %tmp_11 = add i32 %globalLowerIndex, %tmp_10
  %tmp_13 = getelementptr inbounds i32 addrspace(1)* %sortedArray, i32 %tmp_11
  %tmp_14 = load i32 addrspace(1)* %tmp_13, align 4
  %tmp_17 = add i32 %tmp_6, 1
  %tmp_19 = mul i32 %tmp_17, %subdivSize
  %tmp_20 = add i32 %globalLowerIndex, %tmp_19
  %tmp_21 = sub i32 %tmp_20, 1
  %tmp_23 = getelementptr inbounds i32 addrspace(1)* %sortedArray, i32 %tmp_21
  %tmp_24 = load i32 addrspace(1)* %tmp_23, align 4
  %tmp_27 = icmp ugt i32 %tmp_14, %findMe
  br i1 %tmp_27, label %tmp_32, label %tmp_28

tmp_28:                                           ; preds = %0
  %tmp_31 = icmp ult i32 %tmp_24, %findMe
  br i1 %tmp_31, label %tmp_32, label %tmp_33

tmp_32:                                           ; preds = %tmp_28, %0
  br label %tmp_43

tmp_33:                                           ; preds = %tmp_28
  %tmp_36 = getelementptr inbounds <4 x i32> addrspace(1)* %outputArray, i32 0
  %tmp_37 = load <4 x i32> addrspace(1)* %tmp_36, align 16
  %tmp_38 = insertelement <4 x i32> %tmp_37, i32 %tmp_6, i32 0
  store <4 x i32> %tmp_38, <4 x i32> addrspace(1)* %tmp_36, align 16
  %tmp_40 = getelementptr inbounds <4 x i32> addrspace(1)* %outputArray, i32 0
  %tmp_41 = load <4 x i32> addrspace(1)* %tmp_40, align 16
  %tmp_42 = insertelement <4 x i32> %tmp_41, i32 1, i32 3
  store <4 x i32> %tmp_42, <4 x i32> addrspace(1)* %tmp_40, align 16
  br label %tmp_43

tmp_43:                                           ; preds = %tmp_33, %tmp_32
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

; Function Attrs: nounwind
define void @binarySearch_mulkeys(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %numKeys, i32 addrspace(1)* %output) #0 {
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_7 = mul nsw i32 %tmp_5, 256
  %tmp_9 = add nsw i32 %tmp_7, 255
  br label %tmp_10

tmp_10:                                           ; preds = %tmp_40, %0
  %i.0 = phi i32 [ 0, %0 ], [ %tmp_42, %tmp_40 ]
  %tmp_13 = icmp ult i32 %i.0, %numKeys
  br i1 %tmp_13, label %tmp_14, label %tmp_43

tmp_14:                                           ; preds = %tmp_10
  %tmp_17 = getelementptr inbounds i32 addrspace(1)* %keys, i32 %i.0
  %tmp_18 = load i32 addrspace(1)* %tmp_17, align 4
  %tmp_21 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_7
  %tmp_22 = load i32 addrspace(1)* %tmp_21, align 4
  %tmp_23 = icmp uge i32 %tmp_18, %tmp_22
  br i1 %tmp_23, label %tmp_24, label %tmp_39

tmp_24:                                           ; preds = %tmp_14
  %tmp_27 = getelementptr inbounds i32 addrspace(1)* %keys, i32 %i.0
  %tmp_28 = load i32 addrspace(1)* %tmp_27, align 4
  %tmp_31 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_9
  %tmp_32 = load i32 addrspace(1)* %tmp_31, align 4
  %tmp_33 = icmp ule i32 %tmp_28, %tmp_32
  br i1 %tmp_33, label %tmp_34, label %tmp_39

tmp_34:                                           ; preds = %tmp_24
  %tmp_38 = getelementptr inbounds i32 addrspace(1)* %output, i32 %i.0
  store i32 %tmp_7, i32 addrspace(1)* %tmp_38, align 4
  br label %tmp_39

tmp_39:                                           ; preds = %tmp_34, %tmp_24, %tmp_14
  br label %tmp_40

tmp_40:                                           ; preds = %tmp_39
  %tmp_42 = add nsw i32 %i.0, 1
  br label %tmp_10

tmp_43:                                           ; preds = %tmp_10
  ret void
}

; Function Attrs: nounwind
define void @binarySearch_mulkeysConcurrent(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %inputSize, i32 %numSubdivisions, i32 addrspace(1)* %output) #0 {
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_8 = urem i32 %tmp_6, %numSubdivisions
  %tmp_11 = udiv i32 %inputSize, %numSubdivisions
  %tmp_12 = mul i32 %tmp_8, %tmp_11
  %tmp_16 = udiv i32 %inputSize, %numSubdivisions
  %tmp_17 = add i32 %tmp_12, %tmp_16
  %tmp_18 = call i32 @__get_global_id_u32(i32 0)
  %tmp_20 = udiv i32 %tmp_18, %numSubdivisions
  %tmp_22 = getelementptr inbounds i32 addrspace(1)* %keys, i32 %tmp_20
  %tmp_23 = load i32 addrspace(1)* %tmp_22, align 4
  br label %tmp_24

tmp_24:                                           ; preds = %tmp_60, %0
  %lBound.0 = phi i32 [ %tmp_12, %0 ], [ %lBound.1, %tmp_60 ]
  %uBound.0 = phi i32 [ %tmp_17, %0 ], [ %uBound.1, %tmp_60 ]
  %tmp_27 = icmp sge i32 %uBound.0, %lBound.0
  br i1 %tmp_27, label %tmp_28, label %tmp_61

tmp_28:                                           ; preds = %tmp_24
  %tmp_31 = add nsw i32 %lBound.0, %uBound.0
  %tmp_32 = sdiv i32 %tmp_31, 2
  %tmp_35 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_32
  %tmp_36 = load i32 addrspace(1)* %tmp_35, align 4
  %tmp_38 = icmp eq i32 %tmp_36, %tmp_23
  br i1 %tmp_38, label %tmp_39, label %tmp_46

tmp_39:                                           ; preds = %tmp_28
  %tmp_41 = call i32 @__get_global_id_u32(i32 0)
  %tmp_43 = udiv i32 %tmp_41, %numSubdivisions
  %tmp_45 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_43
  store i32 %tmp_32, i32 addrspace(1)* %tmp_45, align 4
  br label %tmp_61

tmp_46:                                           ; preds = %tmp_28
  %tmp_49 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_32
  %tmp_50 = load i32 addrspace(1)* %tmp_49, align 4
  %tmp_52 = icmp ugt i32 %tmp_50, %tmp_23
  br i1 %tmp_52, label %tmp_53, label %tmp_56

tmp_53:                                           ; preds = %tmp_46
  %tmp_55 = sub nsw i32 %tmp_32, 1
  br label %tmp_59

tmp_56:                                           ; preds = %tmp_46
  %tmp_58 = add nsw i32 %tmp_32, 1
  br label %tmp_59

tmp_59:                                           ; preds = %tmp_56, %tmp_53
  %lBound.1 = phi i32 [ %lBound.0, %tmp_53 ], [ %tmp_58, %tmp_56 ]
  %uBound.1 = phi i32 [ %tmp_55, %tmp_53 ], [ %uBound.0, %tmp_56 ]
  br label %tmp_60

tmp_60:                                           ; preds = %tmp_59
  br label %tmp_24

tmp_61:                                           ; preds = %tmp_39, %tmp_24
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @binarySearch}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(1)*)* @binarySearch_mulkeys}
!2 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32, i32 addrspace(1)*)* @binarySearch_mulkeysConcurrent}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

; ModuleID = '../kernel-src/AsyncDataTransfer_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @work(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %gSize = alloca i32, align 4
  %gId = alloca i32, align 4
  %tmp = alloca i32, align 4
  %zero = alloca i32, align 4
  %i = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %multiplier, i32* %tmp_3, align 4
  %tmp_4 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_4, i32* %gSize, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_5, i32* %gId, align 4
  store i32 1, i32* %tmp, align 4
  store volatile i32 0, i32* %zero, align 4
  store i32 5, i32* %i, align 4
  br label %tmp_6

tmp_6:                                       ; preds = %tmp_56, %tmp_0
  %tmp_7 = load i32* %i, align 4
  %tmp_8 = icmp slt i32 %tmp_7, 100
  br i1 %tmp_8, label %tmp_9, label %tmp_59

tmp_9:                                       ; preds = %tmp_6
  %tmp_10 = load i32* %i, align 4
  %tmp_11 = mul nsw i32 %tmp_10, 1
  %tmp_12 = load i32* %gSize, align 4
  %tmp_13 = srem i32 %tmp_11, %tmp_12
  %tmp_14 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_15 = getelementptr inbounds i8 addrspace(1)* %tmp_14, i32 %tmp_13
  %tmp_16 = load i8 addrspace(1)* %tmp_15, align 1
  %tmp_17 = zext i8 %tmp_16 to i32
  %tmp_18 = load i32* %i, align 4
  %tmp_19 = mul nsw i32 %tmp_18, 2
  %tmp_20 = load i32* %gSize, align 4
  %tmp_21 = srem i32 %tmp_19, %tmp_20
  %tmp_22 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_23 = getelementptr inbounds i8 addrspace(1)* %tmp_22, i32 %tmp_21
  %tmp_24 = load i8 addrspace(1)* %tmp_23, align 1
  %tmp_25 = zext i8 %tmp_24 to i32
  %tmp_26 = add nsw i32 %tmp_17, %tmp_25
  %tmp_27 = load i32* %i, align 4
  %tmp_28 = mul nsw i32 %tmp_27, 3
  %tmp_29 = load i32* %gSize, align 4
  %tmp_30 = srem i32 %tmp_28, %tmp_29
  %tmp_31 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_32 = getelementptr inbounds i8 addrspace(1)* %tmp_31, i32 %tmp_30
  %tmp_33 = load i8 addrspace(1)* %tmp_32, align 1
  %tmp_34 = zext i8 %tmp_33 to i32
  %tmp_35 = add nsw i32 %tmp_26, %tmp_34
  %tmp_36 = load i32* %i, align 4
  %tmp_37 = mul nsw i32 %tmp_36, 4
  %tmp_38 = load i32* %gSize, align 4
  %tmp_39 = srem i32 %tmp_37, %tmp_38
  %tmp_40 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_41 = getelementptr inbounds i8 addrspace(1)* %tmp_40, i32 %tmp_39
  %tmp_42 = load i8 addrspace(1)* %tmp_41, align 1
  %tmp_43 = zext i8 %tmp_42 to i32
  %tmp_44 = add nsw i32 %tmp_35, %tmp_43
  %tmp_45 = load i32* %i, align 4
  %tmp_46 = mul nsw i32 %tmp_45, 5
  %tmp_47 = load i32* %gSize, align 4
  %tmp_48 = srem i32 %tmp_46, %tmp_47
  %tmp_49 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_50 = getelementptr inbounds i8 addrspace(1)* %tmp_49, i32 %tmp_48
  %tmp_51 = load i8 addrspace(1)* %tmp_50, align 1
  %tmp_52 = zext i8 %tmp_51 to i32
  %tmp_53 = add nsw i32 %tmp_44, %tmp_52
  %tmp_54 = load i32* %tmp, align 4
  %tmp_55 = add i32 %tmp_54, %tmp_53
  store i32 %tmp_55, i32* %tmp, align 4
  br label %tmp_56

tmp_56:                                      ; preds = %tmp_9
  %tmp_57 = load i32* %i, align 4
  %tmp_58 = add nsw i32 %tmp_57, 1
  store i32 %tmp_58, i32* %i, align 4
  br label %tmp_6

tmp_59:                                      ; preds = %tmp_6
  %tmp_60 = load i32* %gId, align 4
  %tmp_61 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_62 = getelementptr inbounds i8 addrspace(1)* %tmp_61, i32 %tmp_60
  %tmp_63 = load i8 addrspace(1)* %tmp_62, align 1
  %tmp_64 = zext i8 %tmp_63 to i32
  %tmp_65 = load i32* %tmp_3, align 4
  %tmp_66 = mul nsw i32 %tmp_64, %tmp_65
  %tmp_67 = srem i32 %tmp_66, 256
  %tmp_68 = load volatile i32* %zero, align 4
  %tmp_69 = load i32* %tmp, align 4
  %tmp_70 = mul i32 %tmp_68, %tmp_69
  %tmp_71 = add i32 %tmp_67, %tmp_70
  %tmp_72 = trunc i32 %tmp_71 to i8
  %tmp_73 = load i32* %gId, align 4
  %tmp_74 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_75 = getelementptr inbounds i8 addrspace(1)* %tmp_74, i32 %tmp_73
  store i8 %tmp_72, i8 addrspace(1)* %tmp_75, align 1
  ret void
}

declare i32 @__get_global_size_u32(i32) #1

declare i32 @__get_global_id_u32(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32)* @work}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

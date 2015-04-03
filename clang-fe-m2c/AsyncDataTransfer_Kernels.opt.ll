; ModuleID = 'AsyncDataTransfer_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @work(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %multiplier) #0 {
  %zero = alloca i32, align 4
  %tmp_4 = call i32 @__get_global_size_u32(i32 0)
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  store volatile i32 0, i32* %zero, align 4
  br label %tmp_6

tmp_6:                                            ; preds = %tmp_56, %0
  %tmp.0 = phi i32 [ 1, %0 ], [ %tmp_55, %tmp_56 ]
  %i.0 = phi i32 [ 5, %0 ], [ %tmp_58, %tmp_56 ]
  %tmp_8 = icmp slt i32 %i.0, 100
  br i1 %tmp_8, label %tmp_9, label %tmp_59

tmp_9:                                            ; preds = %tmp_6
  %tmp_11 = mul nsw i32 %i.0, 1
  %tmp_13 = srem i32 %tmp_11, %tmp_4
  %tmp_15 = getelementptr inbounds i8 addrspace(1)* %input, i32 %tmp_13
  %tmp_16 = load i8 addrspace(1)* %tmp_15, align 1
  %tmp_17 = zext i8 %tmp_16 to i32
  %tmp_19 = mul nsw i32 %i.0, 2
  %tmp_21 = srem i32 %tmp_19, %tmp_4
  %tmp_23 = getelementptr inbounds i8 addrspace(1)* %input, i32 %tmp_21
  %tmp_24 = load i8 addrspace(1)* %tmp_23, align 1
  %tmp_25 = zext i8 %tmp_24 to i32
  %tmp_26 = add nsw i32 %tmp_17, %tmp_25
  %tmp_28 = mul nsw i32 %i.0, 3
  %tmp_30 = srem i32 %tmp_28, %tmp_4
  %tmp_32 = getelementptr inbounds i8 addrspace(1)* %input, i32 %tmp_30
  %tmp_33 = load i8 addrspace(1)* %tmp_32, align 1
  %tmp_34 = zext i8 %tmp_33 to i32
  %tmp_35 = add nsw i32 %tmp_26, %tmp_34
  %tmp_37 = mul nsw i32 %i.0, 4
  %tmp_39 = srem i32 %tmp_37, %tmp_4
  %tmp_41 = getelementptr inbounds i8 addrspace(1)* %input, i32 %tmp_39
  %tmp_42 = load i8 addrspace(1)* %tmp_41, align 1
  %tmp_43 = zext i8 %tmp_42 to i32
  %tmp_44 = add nsw i32 %tmp_35, %tmp_43
  %tmp_46 = mul nsw i32 %i.0, 5
  %tmp_48 = srem i32 %tmp_46, %tmp_4
  %tmp_50 = getelementptr inbounds i8 addrspace(1)* %input, i32 %tmp_48
  %tmp_51 = load i8 addrspace(1)* %tmp_50, align 1
  %tmp_52 = zext i8 %tmp_51 to i32
  %tmp_53 = add nsw i32 %tmp_44, %tmp_52
  %tmp_55 = add i32 %tmp.0, %tmp_53
  br label %tmp_56

tmp_56:                                           ; preds = %tmp_9
  %tmp_58 = add nsw i32 %i.0, 1
  br label %tmp_6

tmp_59:                                           ; preds = %tmp_6
  %tmp_62 = getelementptr inbounds i8 addrspace(1)* %input, i32 %tmp_5
  %tmp_63 = load i8 addrspace(1)* %tmp_62, align 1
  %tmp_64 = zext i8 %tmp_63 to i32
  %tmp_66 = mul nsw i32 %tmp_64, %multiplier
  %tmp_67 = srem i32 %tmp_66, 256
  %tmp_68 = load volatile i32* %zero, align 4
  %tmp_70 = mul i32 %tmp_68, %tmp.0
  %tmp_71 = add i32 %tmp_67, %tmp_70
  %tmp_72 = trunc i32 %tmp_71 to i8
  %tmp_75 = getelementptr inbounds i8 addrspace(1)* %output, i32 %tmp_5
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

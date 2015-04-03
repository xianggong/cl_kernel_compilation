; ModuleID = 'Reduction_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @reduce(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(3)* %sdata) #0 {
  %tmp_4 = call i32 @__get_local_id_u32(i32 0)
  %tmp_5 = call i32 @__get_group_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  %tmp_9 = mul i32 %tmp_6, 2
  %tmp_12 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %tmp_9
  %tmp_13 = load <4 x i32> addrspace(1)* %tmp_12, align 16
  %tmp_15 = add i32 %tmp_9, 1
  %tmp_17 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %tmp_15
  %tmp_18 = load <4 x i32> addrspace(1)* %tmp_17, align 16
  %tmp_19 = add <4 x i32> %tmp_13, %tmp_18
  %tmp_22 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %tmp_4
  store <4 x i32> %tmp_19, <4 x i32> addrspace(3)* %tmp_22, align 16
  call void @barrier(i32 1)
  %tmp_24 = lshr i32 %tmp_7, 1
  br label %tmp_25

tmp_25:                                           ; preds = %tmp_45, %0
  %s.0 = phi i32 [ %tmp_24, %0 ], [ %tmp_47, %tmp_45 ]
  %tmp_27 = icmp ugt i32 %s.0, 0
  br i1 %tmp_27, label %tmp_28, label %tmp_48

tmp_28:                                           ; preds = %tmp_25
  %tmp_31 = icmp ult i32 %tmp_4, %s.0
  br i1 %tmp_31, label %tmp_32, label %tmp_44

tmp_32:                                           ; preds = %tmp_28
  %tmp_35 = add i32 %tmp_4, %s.0
  %tmp_37 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %tmp_35
  %tmp_38 = load <4 x i32> addrspace(3)* %tmp_37, align 16
  %tmp_41 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %tmp_4
  %tmp_42 = load <4 x i32> addrspace(3)* %tmp_41, align 16
  %tmp_43 = add <4 x i32> %tmp_42, %tmp_38
  store <4 x i32> %tmp_43, <4 x i32> addrspace(3)* %tmp_41, align 16
  br label %tmp_44

tmp_44:                                           ; preds = %tmp_32, %tmp_28
  call void @barrier(i32 1)
  br label %tmp_45

tmp_45:                                           ; preds = %tmp_44
  %tmp_47 = lshr i32 %s.0, 1
  br label %tmp_25

tmp_48:                                           ; preds = %tmp_25
  %tmp_50 = icmp eq i32 %tmp_4, 0
  br i1 %tmp_50, label %tmp_51, label %tmp_58

tmp_51:                                           ; preds = %tmp_48
  %tmp_53 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 0
  %tmp_54 = load <4 x i32> addrspace(3)* %tmp_53, align 16
  %tmp_57 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %tmp_5
  store <4 x i32> %tmp_54, <4 x i32> addrspace(1)* %tmp_57, align 16
  br label %tmp_58

tmp_58:                                           ; preds = %tmp_51, %tmp_48
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @reduce}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

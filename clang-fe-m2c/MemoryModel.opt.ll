; ModuleID = 'MemoryModel.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@mask = addrspace(2) global [4 x i32] [i32 1, i32 -1, i32 2, i32 -2], align 4
@MemoryModel.localBuffer = internal addrspace(3) global [64 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @MemoryModel(i32 addrspace(1)* %outputbuffer, i32 addrspace(1)* %inputbuffer) #0 {
  %tmp_3 = call i32 @__get_group_id_u32(i32 0)
  %tmp_4 = call i32 @__get_local_id_u32(i32 0)
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_8 = getelementptr inbounds i32 addrspace(1)* %inputbuffer, i32 %tmp_5
  %tmp_9 = load i32 addrspace(1)* %tmp_8, align 4
  %tmp_11 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %tmp_4
  store i32 %tmp_9, i32 addrspace(3)* %tmp_11, align 4
  call void @barrier(i32 1)
  br label %tmp_12

tmp_12:                                           ; preds = %tmp_24, %0
  %result.0 = phi i32 [ 0, %0 ], [ %tmp_23, %tmp_24 ]
  %i.0 = phi i32 [ 0, %0 ], [ %tmp_26, %tmp_24 ]
  %tmp_14 = icmp slt i32 %i.0, 4
  br i1 %tmp_14, label %tmp_15, label %tmp_27

tmp_15:                                           ; preds = %tmp_12
  %tmp_18 = add i32 %tmp_4, %i.0
  %tmp_19 = urem i32 %tmp_18, 64
  %tmp_20 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %tmp_19
  %tmp_21 = load i32 addrspace(3)* %tmp_20, align 4
  %tmp_23 = add nsw i32 %result.0, %tmp_21
  br label %tmp_24

tmp_24:                                           ; preds = %tmp_15
  %tmp_26 = add nsw i32 %i.0, 1
  br label %tmp_12

tmp_27:                                           ; preds = %tmp_12
  %tmp_29 = urem i32 %tmp_3, 4
  %tmp_30 = getelementptr inbounds [4 x i32] addrspace(2)* @mask, i32 0, i32 %tmp_29
  %tmp_31 = load i32 addrspace(2)* %tmp_30, align 4
  %tmp_33 = mul nsw i32 %result.0, %tmp_31
  %tmp_37 = getelementptr inbounds i32 addrspace(1)* %outputbuffer, i32 %tmp_5
  store i32 %tmp_33, i32 addrspace(1)* %tmp_37, align 4
  ret void
}

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @MemoryModel}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

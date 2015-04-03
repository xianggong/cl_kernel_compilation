; ModuleID = '../kernel-src/FastWalshTransform_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @fastWalshTransform(float addrspace(1)* %tArray, i32 %step) #0 {
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca i32, align 4
  %tid = alloca i32, align 4
  %group = alloca i32, align 4
  %pair = alloca i32, align 4
  %match = alloca i32, align 4
  %T1 = alloca float, align 4
  %T2 = alloca float, align 4
  store float addrspace(1)* %tArray, float addrspace(1)** %tmp_1, align 4
  store i32 %step, i32* %tmp_2, align 4
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_3, i32* %tid, align 4
  %tmp_4 = load i32* %tid, align 4
  %tmp_5 = load i32* %tmp_2, align 4
  %tmp_6 = urem i32 %tmp_4, %tmp_5
  store i32 %tmp_6, i32* %group, align 4
  %tmp_7 = load i32* %tmp_2, align 4
  %tmp_8 = mul nsw i32 2, %tmp_7
  %tmp_9 = load i32* %tid, align 4
  %tmp_10 = load i32* %tmp_2, align 4
  %tmp_11 = udiv i32 %tmp_9, %tmp_10
  %tmp_12 = mul i32 %tmp_8, %tmp_11
  %tmp_13 = load i32* %group, align 4
  %tmp_14 = add i32 %tmp_12, %tmp_13
  store i32 %tmp_14, i32* %pair, align 4
  %tmp_15 = load i32* %pair, align 4
  %tmp_16 = load i32* %tmp_2, align 4
  %tmp_17 = add i32 %tmp_15, %tmp_16
  store i32 %tmp_17, i32* %match, align 4
  %tmp_18 = load i32* %pair, align 4
  %tmp_19 = load float addrspace(1)** %tmp_1, align 4
  %tmp_20 = getelementptr inbounds float addrspace(1)* %tmp_19, i32 %tmp_18
  %tmp_21 = load float addrspace(1)* %tmp_20, align 4
  store float %tmp_21, float* %T1, align 4
  %tmp_22 = load i32* %match, align 4
  %tmp_23 = load float addrspace(1)** %tmp_1, align 4
  %tmp_24 = getelementptr inbounds float addrspace(1)* %tmp_23, i32 %tmp_22
  %tmp_25 = load float addrspace(1)* %tmp_24, align 4
  store float %tmp_25, float* %T2, align 4
  %tmp_26 = load float* %T1, align 4
  %tmp_27 = load float* %T2, align 4
  %tmp_28 = fadd float %tmp_26, %tmp_27
  %tmp_29 = load i32* %pair, align 4
  %tmp_30 = load float addrspace(1)** %tmp_1, align 4
  %tmp_31 = getelementptr inbounds float addrspace(1)* %tmp_30, i32 %tmp_29
  store float %tmp_28, float addrspace(1)* %tmp_31, align 4
  %tmp_32 = load float* %T1, align 4
  %tmp_33 = load float* %T2, align 4
  %tmp_34 = fsub float %tmp_32, %tmp_33
  %tmp_35 = load i32* %match, align 4
  %tmp_36 = load float addrspace(1)** %tmp_1, align 4
  %tmp_37 = getelementptr inbounds float addrspace(1)* %tmp_36, i32 %tmp_35
  store float %tmp_34, float addrspace(1)* %tmp_37, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, i32)* @fastWalshTransform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

; ModuleID = 'FastWalshTransform_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @fastWalshTransform(float addrspace(1)* %tArray, i32 %step) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = urem i32 %tmp_3, %step
  %tmp_8 = mul nsw i32 2, %step
  %tmp_11 = udiv i32 %tmp_3, %step
  %tmp_12 = mul i32 %tmp_8, %tmp_11
  %tmp_14 = add i32 %tmp_12, %tmp_6
  %tmp_17 = add i32 %tmp_14, %step
  %tmp_20 = getelementptr inbounds float addrspace(1)* %tArray, i32 %tmp_14
  %tmp_21 = load float addrspace(1)* %tmp_20, align 4
  %tmp_24 = getelementptr inbounds float addrspace(1)* %tArray, i32 %tmp_17
  %tmp_25 = load float addrspace(1)* %tmp_24, align 4
  %tmp_28 = fadd float %tmp_21, %tmp_25
  %tmp_31 = getelementptr inbounds float addrspace(1)* %tArray, i32 %tmp_14
  store float %tmp_28, float addrspace(1)* %tmp_31, align 4
  %tmp_34 = fsub float %tmp_21, %tmp_25
  %tmp_37 = getelementptr inbounds float addrspace(1)* %tArray, i32 %tmp_17
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

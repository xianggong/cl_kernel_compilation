; ModuleID = 'FastWalshTransform_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @fastWalshTransform(float addrspace(1)* %tArray, i32 %step) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = urem i32 %1, %step
  %3 = mul nsw i32 2, %step
  %4 = udiv i32 %1, %step
  %5 = mul i32 %3, %4
  %6 = add i32 %5, %2
  %7 = add i32 %6, %step
  %8 = getelementptr inbounds float addrspace(1)* %tArray, i32 %6
  %9 = load float addrspace(1)* %8, align 4
  %10 = getelementptr inbounds float addrspace(1)* %tArray, i32 %7
  %11 = load float addrspace(1)* %10, align 4
  %12 = fadd float %9, %11
  %13 = getelementptr inbounds float addrspace(1)* %tArray, i32 %6
  store float %12, float addrspace(1)* %13, align 4
  %14 = fsub float %9, %11
  %15 = getelementptr inbounds float addrspace(1)* %tArray, i32 %7
  store float %14, float addrspace(1)* %15, align 4
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, i32)* @fastWalshTransform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

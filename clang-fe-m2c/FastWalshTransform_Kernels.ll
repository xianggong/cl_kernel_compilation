; ModuleID = '../kernel-src/FastWalshTransform_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @fastWalshTransform(float addrspace(1)* %tArray, i32 %step) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca i32, align 4
  %tid = alloca i32, align 4
  %group = alloca i32, align 4
  %pair = alloca i32, align 4
  %match = alloca i32, align 4
  %T1 = alloca float, align 4
  %T2 = alloca float, align 4
  store float addrspace(1)* %tArray, float addrspace(1)** %1, align 4
  store i32 %step, i32* %2, align 4
  %3 = call i32 @__get_global_id_u32(i32 0)
  store i32 %3, i32* %tid, align 4
  %4 = load i32* %tid, align 4
  %5 = load i32* %2, align 4
  %6 = urem i32 %4, %5
  store i32 %6, i32* %group, align 4
  %7 = load i32* %2, align 4
  %8 = mul nsw i32 2, %7
  %9 = load i32* %tid, align 4
  %10 = load i32* %2, align 4
  %11 = udiv i32 %9, %10
  %12 = mul i32 %8, %11
  %13 = load i32* %group, align 4
  %14 = add i32 %12, %13
  store i32 %14, i32* %pair, align 4
  %15 = load i32* %pair, align 4
  %16 = load i32* %2, align 4
  %17 = add i32 %15, %16
  store i32 %17, i32* %match, align 4
  %18 = load i32* %pair, align 4
  %19 = load float addrspace(1)** %1, align 4
  %20 = getelementptr inbounds float addrspace(1)* %19, i32 %18
  %21 = load float addrspace(1)* %20, align 4
  store float %21, float* %T1, align 4
  %22 = load i32* %match, align 4
  %23 = load float addrspace(1)** %1, align 4
  %24 = getelementptr inbounds float addrspace(1)* %23, i32 %22
  %25 = load float addrspace(1)* %24, align 4
  store float %25, float* %T2, align 4
  %26 = load float* %T1, align 4
  %27 = load float* %T2, align 4
  %28 = fadd float %26, %27
  %29 = load i32* %pair, align 4
  %30 = load float addrspace(1)** %1, align 4
  %31 = getelementptr inbounds float addrspace(1)* %30, i32 %29
  store float %28, float addrspace(1)* %31, align 4
  %32 = load float* %T1, align 4
  %33 = load float* %T2, align 4
  %34 = fsub float %32, %33
  %35 = load i32* %match, align 4
  %36 = load float addrspace(1)** %1, align 4
  %37 = getelementptr inbounds float addrspace(1)* %36, i32 %35
  store float %34, float addrspace(1)* %37, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, i32)* @fastWalshTransform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

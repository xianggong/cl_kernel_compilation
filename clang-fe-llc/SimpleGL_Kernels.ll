; ModuleID = '../kernel-src/SimpleGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @sineWave(<4 x float> addrspace(1)* %pos, i32 %width, i32 %height, float %time) #0 {
  %1 = alloca <4 x float> addrspace(1)*, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca float, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %u = alloca float, align 4
  %v = alloca float, align 4
  %freq = alloca float, align 4
  %w = alloca float, align 4
  %5 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)** %1, align 4
  store i32 %width, i32* %2, align 4
  store i32 %height, i32* %3, align 4
  store float %time, float* %4, align 4
  %6 = call i32 @get_global_id(i32 0)
  store i32 %6, i32* %x, align 4
  %7 = call i32 @get_global_id(i32 1)
  store i32 %7, i32* %y, align 4
  %8 = load i32* %x, align 4
  %9 = uitofp i32 %8 to float
  %10 = load i32* %2, align 4
  %11 = uitofp i32 %10 to float
  %12 = fdiv float %9, %11, !fpmath !2
  store float %12, float* %u, align 4
  %13 = load i32* %y, align 4
  %14 = uitofp i32 %13 to float
  %15 = load i32* %3, align 4
  %16 = uitofp i32 %15 to float
  %17 = fdiv float %14, %16, !fpmath !2
  store float %17, float* %v, align 4
  %18 = load float* %u, align 4
  %19 = call float @llvm.fmuladd.f32(float %18, float 2.000000e+00, float -1.000000e+00)
  store float %19, float* %u, align 4
  %20 = load float* %v, align 4
  %21 = call float @llvm.fmuladd.f32(float %20, float 2.000000e+00, float -1.000000e+00)
  store float %21, float* %v, align 4
  store float 4.000000e+00, float* %freq, align 4
  %22 = load float* %u, align 4
  %23 = load float* %freq, align 4
  %24 = load float* %4, align 4
  %25 = call float @llvm.fmuladd.f32(float %22, float %23, float %24)
  %26 = call float @_Z3sinf(float %25)
  %27 = load float* %v, align 4
  %28 = load float* %freq, align 4
  %29 = load float* %4, align 4
  %30 = call float @llvm.fmuladd.f32(float %27, float %28, float %29)
  %31 = call float @_Z3cosf(float %30)
  %32 = fmul float %26, %31
  %33 = fmul float %32, 5.000000e-01
  store float %33, float* %w, align 4
  %34 = load float* %u, align 4
  %35 = insertelement <4 x float> undef, float %34, i32 0
  %36 = load float* %w, align 4
  %37 = insertelement <4 x float> %35, float %36, i32 1
  %38 = load float* %v, align 4
  %39 = insertelement <4 x float> %37, float %38, i32 2
  %40 = insertelement <4 x float> %39, float 1.000000e+00, i32 3
  store <4 x float> %40, <4 x float>* %5
  %41 = load <4 x float>* %5
  %42 = load i32* %y, align 4
  %43 = load i32* %2, align 4
  %44 = mul i32 %42, %43
  %45 = load i32* %x, align 4
  %46 = add i32 %44, %45
  %47 = load <4 x float> addrspace(1)** %1, align 4
  %48 = getelementptr inbounds <4 x float> addrspace(1)* %47, i32 %46
  store <4 x float> %41, <4 x float> addrspace(1)* %48, align 16
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, i32, i32, float)* @sineWave}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

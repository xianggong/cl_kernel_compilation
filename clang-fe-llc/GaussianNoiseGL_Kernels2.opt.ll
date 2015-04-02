; ModuleID = 'GaussianNoiseGL_Kernels2.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
  %1 = call i32 @get_local_id(i32 0)
  br label %2

; <label>:2                                       ; preds = %21, %0
  %j.0 = phi i32 [ 4, %0 ], [ %22, %21 ]
  %.0 = phi i32 [ %idum, %0 ], [ %.1, %21 ]
  %3 = icmp sge i32 %j.0, 0
  br i1 %3, label %4, label %23

; <label>:4                                       ; preds = %2
  %5 = sdiv i32 %.0, 127773
  %6 = mul nsw i32 %5, 127773
  %7 = sub nsw i32 %.0, %6
  %8 = mul nsw i32 16807, %7
  %9 = mul nsw i32 2836, %5
  %10 = sub nsw i32 %8, %9
  %11 = icmp slt i32 %10, 0
  br i1 %11, label %12, label %14

; <label>:12                                      ; preds = %4
  %13 = add nsw i32 %10, 2147483647
  br label %14

; <label>:14                                      ; preds = %12, %4
  %.1 = phi i32 [ %13, %12 ], [ %10, %4 ]
  %15 = icmp slt i32 %j.0, 4
  br i1 %15, label %16, label %20

; <label>:16                                      ; preds = %14
  %17 = mul nsw i32 4, %1
  %18 = add nsw i32 %17, %j.0
  %19 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %18
  store i32 %.1, i32 addrspace(3)* %19, align 4
  br label %20

; <label>:20                                      ; preds = %16, %14
  br label %21

; <label>:21                                      ; preds = %20
  %22 = add nsw i32 %j.0, -1
  br label %2

; <label>:23                                      ; preds = %2
  %24 = getelementptr inbounds i32 addrspace(3)* %iv, i32 0
  %25 = load i32 addrspace(3)* %24, align 4
  %26 = sdiv i32 %.0, 127773
  %27 = mul nsw i32 %26, 127773
  %28 = sub nsw i32 %.0, %27
  %29 = mul nsw i32 16807, %28
  %30 = mul nsw i32 2836, %26
  %31 = sub nsw i32 %29, %30
  %32 = icmp slt i32 %31, 0
  br i1 %32, label %33, label %35

; <label>:33                                      ; preds = %23
  %34 = add nsw i32 %31, 2147483647
  br label %35

; <label>:35                                      ; preds = %33, %23
  %36 = sdiv i32 %25, 536870912
  %37 = mul nsw i32 4, %1
  %38 = add nsw i32 %37, %36
  %39 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %38
  %40 = load i32 addrspace(3)* %39, align 4
  %41 = sitofp i32 %40 to float
  %42 = fmul float 0x3E00000000000000, %41
  ret float %42
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
  %1 = extractelement <2 x float> %uniform, i32 0
  %2 = call float @llvm.log2.f32(float %1)
  %3 = fmul float %2, 0x3FE62E4300000000
  %4 = fmul float -2.000000e+00, %3
  %5 = call float @llvm.sqrt.f32(float %4)
  %6 = extractelement <2 x float> %uniform, i32 1
  %7 = fmul float 0x40191EB860000000, %6
  %8 = call float @_Z3sinf(float %7)
  %9 = fmul float %5, %8
  %10 = insertelement <2 x float> undef, float %9, i32 0
  %11 = call float @_Z3cosf(float %7)
  %12 = fmul float %5, %11
  %13 = insertelement <2 x float> %10, float %12, i32 1
  ret <2 x float> %13
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

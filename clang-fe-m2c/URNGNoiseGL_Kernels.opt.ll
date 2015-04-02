; ModuleID = 'URNGNoiseGL_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@noise_uniform.iv = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
  %1 = call i32 @__get_local_id_u32(i32 0)
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
  %24 = mul nsw i32 4, %1
  %25 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %24
  %26 = load i32 addrspace(3)* %25, align 4
  %27 = sdiv i32 %.0, 127773
  %28 = mul nsw i32 %27, 127773
  %29 = sub nsw i32 %.0, %28
  %30 = mul nsw i32 16807, %29
  %31 = mul nsw i32 2836, %27
  %32 = sub nsw i32 %30, %31
  %33 = icmp slt i32 %32, 0
  br i1 %33, label %34, label %36

; <label>:34                                      ; preds = %23
  %35 = add nsw i32 %32, 2147483647
  br label %36

; <label>:36                                      ; preds = %34, %23
  %37 = sdiv i32 %26, 536870912
  %38 = mul nsw i32 4, %1
  %39 = add nsw i32 %38, %37
  %40 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %39
  %41 = load i32 addrspace(3)* %40, align 4
  %42 = sitofp i32 %41 to float
  %43 = fmul float 0x3E00000000000000, %42
  ret float %43
}

declare i32 @__get_local_id_u32(i32) #1

; Function Attrs: nounwind
define void @noise_uniform(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = call i32 @__get_global_size_u32(i32 0)
  %4 = mul i32 %2, %3
  %5 = add i32 %1, %4
  %6 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %5
  %7 = load <4 x i8> addrspace(1)* %6, align 4
  %8 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %7)
  %9 = extractelement <4 x float> %8, i32 0
  %10 = extractelement <4 x float> %8, i32 1
  %11 = fadd float %9, %10
  %12 = extractelement <4 x float> %8, i32 2
  %13 = fadd float %11, %12
  %14 = extractelement <4 x float> %8, i32 1
  %15 = fadd float %13, %14
  %16 = fdiv float %15, 4.000000e+00, !fpmath !2
  %17 = fsub float -0.000000e+00, %16
  %18 = fptosi float %17 to i32
  %19 = call float @ran1(i32 %18, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  %20 = fsub float %19, 5.000000e-01
  %21 = sitofp i32 %factor to float
  %22 = fmul float %20, %21
  %23 = insertelement <4 x float> undef, float %22, i32 0
  %24 = shufflevector <4 x float> %23, <4 x float> undef, <4 x i32> zeroinitializer
  %25 = fadd <4 x float> %8, %24
  %26 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %25)
  %27 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %5
  store <4 x i8> %26, <4 x i8> addrspace(1)* %27, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @noise_uniform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

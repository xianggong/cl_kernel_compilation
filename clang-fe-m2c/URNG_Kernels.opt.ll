; ModuleID = 'URNG_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@noise_uniform.iv = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
  %1 = call i32 @__get_local_id_u32(i32 0)
  %2 = call i32 @__get_local_id_u32(i32 1)
  %3 = call i32 @__get_local_size_u32(i32 0)
  %4 = mul i32 %2, %3
  %5 = add i32 %1, %4
  br label %6

; <label>:6                                       ; preds = %25, %0
  %j.0 = phi i32 [ 16, %0 ], [ %26, %25 ]
  %.0 = phi i32 [ %idum, %0 ], [ %.1, %25 ]
  %7 = icmp sge i32 %j.0, 0
  br i1 %7, label %8, label %27

; <label>:8                                       ; preds = %6
  %9 = sdiv i32 %.0, 127773
  %10 = mul nsw i32 %9, 127773
  %11 = sub nsw i32 %.0, %10
  %12 = mul nsw i32 16807, %11
  %13 = mul nsw i32 2836, %9
  %14 = sub nsw i32 %12, %13
  %15 = icmp slt i32 %14, 0
  br i1 %15, label %16, label %18

; <label>:16                                      ; preds = %8
  %17 = add nsw i32 %14, 2147483647
  br label %18

; <label>:18                                      ; preds = %16, %8
  %.1 = phi i32 [ %17, %16 ], [ %14, %8 ]
  %19 = icmp slt i32 %j.0, 16
  br i1 %19, label %20, label %24

; <label>:20                                      ; preds = %18
  %21 = mul nsw i32 16, %5
  %22 = add nsw i32 %21, %j.0
  %23 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %22
  store i32 %.1, i32 addrspace(3)* %23, align 4
  br label %24

; <label>:24                                      ; preds = %20, %18
  br label %25

; <label>:25                                      ; preds = %24
  %26 = add nsw i32 %j.0, -1
  br label %6

; <label>:27                                      ; preds = %6
  %28 = mul nsw i32 16, %5
  %29 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %28
  %30 = load i32 addrspace(3)* %29, align 4
  %31 = sdiv i32 %.0, 127773
  %32 = mul nsw i32 %31, 127773
  %33 = sub nsw i32 %.0, %32
  %34 = mul nsw i32 16807, %33
  %35 = mul nsw i32 2836, %31
  %36 = sub nsw i32 %34, %35
  %37 = icmp slt i32 %36, 0
  br i1 %37, label %38, label %40

; <label>:38                                      ; preds = %27
  %39 = add nsw i32 %36, 2147483647
  br label %40

; <label>:40                                      ; preds = %38, %27
  %41 = sdiv i32 %30, 134217728
  %42 = mul nsw i32 16, %5
  %43 = add nsw i32 %42, %41
  %44 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %43
  %45 = load i32 addrspace(3)* %44, align 4
  %46 = sitofp i32 %45 to float
  %47 = fmul float 0x3E00000000000000, %46
  ret float %47
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

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
  %19 = call float @ran1(i32 %18, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  %20 = fsub float %19, 0x3FE19999A0000000
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

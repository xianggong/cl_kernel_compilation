; ModuleID = '../kernel-src/GaussianNoise_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@gaussian_transform.iv0 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* nocapture %iv) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #3
  %2 = shl i32 %1, 2
  %3 = sdiv i32 %idum, 127773
  %4 = mul i32 %3, -127773
  %5 = add i32 %4, %idum
  %6 = mul nsw i32 %5, 16807
  %7 = mul i32 %3, -2836
  %8 = add i32 %6, %7
  %9 = icmp slt i32 %8, 0
  %10 = add nsw i32 %8, 2147483647
  %. = select i1 %9, i32 %10, i32 %8
  %11 = sdiv i32 %., 127773
  %12 = mul i32 %11, -127773
  %13 = add i32 %12, %.
  %14 = mul nsw i32 %13, 16807
  %15 = mul i32 %11, -2836
  %16 = add i32 %14, %15
  %17 = icmp slt i32 %16, 0
  %18 = add nsw i32 %16, 2147483647
  %..1 = select i1 %17, i32 %18, i32 %16
  %19 = or i32 %2, 3
  %20 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %19
  store i32 %..1, i32 addrspace(3)* %20, align 4, !tbaa !2
  %21 = sdiv i32 %..1, 127773
  %22 = mul i32 %21, -127773
  %23 = add i32 %22, %..1
  %24 = mul nsw i32 %23, 16807
  %25 = mul i32 %21, -2836
  %26 = add i32 %24, %25
  %27 = icmp slt i32 %26, 0
  %28 = add nsw i32 %26, 2147483647
  %..2 = select i1 %27, i32 %28, i32 %26
  %29 = or i32 %2, 2
  %30 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %29
  store i32 %..2, i32 addrspace(3)* %30, align 4, !tbaa !2
  %31 = sdiv i32 %..2, 127773
  %32 = mul i32 %31, -127773
  %33 = add i32 %32, %..2
  %34 = mul nsw i32 %33, 16807
  %35 = mul i32 %31, -2836
  %36 = add i32 %34, %35
  %37 = icmp slt i32 %36, 0
  %38 = add nsw i32 %36, 2147483647
  %..3 = select i1 %37, i32 %38, i32 %36
  %39 = or i32 %2, 1
  %40 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %39
  store i32 %..3, i32 addrspace(3)* %40, align 4, !tbaa !2
  %41 = sdiv i32 %..3, 127773
  %42 = mul i32 %41, -127773
  %43 = add i32 %42, %..3
  %44 = mul nsw i32 %43, 16807
  %45 = mul i32 %41, -2836
  %46 = add i32 %44, %45
  %47 = add nsw i32 %46, 2147483647
  %48 = icmp slt i32 %46, 0
  %..4 = select i1 %48, i32 %47, i32 %46
  %49 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %2
  store i32 %..4, i32 addrspace(3)* %49, align 4, !tbaa !2
  %50 = load i32 addrspace(3)* %iv, align 4, !tbaa !2
  %51 = sdiv i32 %50, 536870912
  %52 = add nsw i32 %51, %2
  %53 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %52
  %54 = load i32 addrspace(3)* %53, align 4, !tbaa !2
  %55 = sitofp i32 %54 to float
  %56 = fmul float %55, 0x3E00000000000000
  ret float %56
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
  %1 = extractelement <2 x float> %uniform, i32 0
  %2 = tail call float @llvm.log2.f32(float %1)
  %3 = fmul float %2, 0x3FE62E4300000000
  %4 = fmul float %3, -2.000000e+00
  %5 = tail call float @llvm.sqrt.f32(float %4)
  %6 = extractelement <2 x float> %uniform, i32 1
  %7 = fmul float %6, 0x40191EB860000000
  %8 = tail call float @_Z3sinf(float %7) #3
  %9 = fmul float %5, %8
  %10 = insertelement <2 x float> undef, float %9, i32 0
  %11 = tail call float @_Z3cosf(float %7) #3
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

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %factor) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_size(i32 0) #3
  %3 = shl i32 %2, 1
  %4 = tail call i32 @get_global_id(i32 1) #3
  %5 = mul i32 %3, %4
  %6 = add i32 %5, %1
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %7
  %9 = load <4 x i8> addrspace(1)* %8, align 4, !tbaa !6
  %10 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %9) #3
  %11 = tail call i32 @get_global_size(i32 0) #3
  %12 = add i32 %11, %6
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %13
  %15 = load <4 x i8> addrspace(1)* %14, align 4, !tbaa !6
  %16 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %15) #3
  %17 = extractelement <4 x float> %10, i32 0
  %18 = extractelement <4 x float> %10, i32 1
  %19 = fadd float %17, %18
  %20 = extractelement <4 x float> %10, i32 2
  %21 = fadd float %20, %19
  %22 = extractelement <4 x float> %10, i32 3
  %23 = fadd float %22, %21
  %24 = fmul float %23, 2.500000e-01
  %25 = extractelement <4 x float> %16, i32 0
  %26 = extractelement <4 x float> %16, i32 1
  %27 = fadd float %25, %26
  %28 = extractelement <4 x float> %16, i32 2
  %29 = fadd float %28, %27
  %30 = extractelement <4 x float> %16, i32 3
  %31 = fadd float %30, %29
  %32 = fmul float %31, 2.500000e-01
  %33 = fsub float -0.000000e+00, %24
  %34 = fptosi float %33 to i32
  %35 = tail call float @ran1(i32 %34, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  %36 = fsub float -0.000000e+00, %32
  %37 = fptosi float %36 to i32
  %38 = tail call float @ran1(i32 %37, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  %39 = tail call float @llvm.log2.f32(float %35) #3
  %40 = fmul float %39, 0x3FE62E4300000000
  %41 = fmul float %40, -2.000000e+00
  %42 = tail call float @llvm.sqrt.f32(float %41) #3
  %43 = fmul float %38, 0x40191EB860000000
  %44 = tail call float @_Z3sinf(float %43) #3
  %45 = fmul float %42, %44
  %46 = tail call float @_Z3cosf(float %43) #3
  %47 = fmul float %42, %46
  %48 = sitofp i32 %factor to float
  %49 = fmul float %48, %45
  %50 = insertelement <4 x float> undef, float %49, i32 0
  %51 = shufflevector <4 x float> %50, <4 x float> undef, <4 x i32> zeroinitializer
  %52 = fadd <4 x float> %10, %51
  %53 = tail call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %52) #3
  %54 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %7
  store <4 x i8> %53, <4 x i8> addrspace(1)* %54, align 4, !tbaa !6
  %55 = fmul float %48, %47
  %56 = insertelement <4 x float> undef, float %55, i32 0
  %57 = shufflevector <4 x float> %56, <4 x float> undef, <4 x i32> zeroinitializer
  %58 = fadd <4 x float> %16, %57
  %59 = tail call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %58) #3
  %60 = tail call i32 @get_global_size(i32 0) #3
  %61 = add i32 %60, %6
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %62
  store <4 x i8> %59, <4 x i8> addrspace(1)* %63, align 4, !tbaa !6
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @gaussian_transform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !4, metadata !4, i64 0}

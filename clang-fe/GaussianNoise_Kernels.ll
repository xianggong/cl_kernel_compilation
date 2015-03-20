; ModuleID = '../kernel-src/GaussianNoise_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@gaussian_transform.iv0 = internal global [1024 x i32] zeroinitializer, align 16
@gaussian_transform.iv1 = internal global [1024 x i32] zeroinitializer, align 16

; Function Attrs: nounwind uwtable
define float @ran1(i32 %idum, i32* nocapture %iv) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = shl i32 %2, 2
  %4 = sext i32 %3 to i64
  %5 = sdiv i32 %idum, 127773
  %6 = mul i32 %5, -127773
  %7 = add i32 %6, %idum
  %8 = mul nsw i32 %7, 16807
  %9 = mul i32 %5, -2836
  %10 = add i32 %8, %9
  %11 = icmp slt i32 %10, 0
  %12 = add nsw i32 %10, 2147483647
  %. = select i1 %11, i32 %12, i32 %10
  %13 = sdiv i32 %., 127773
  %14 = mul i32 %13, -127773
  %15 = add i32 %14, %.
  %16 = mul nsw i32 %15, 16807
  %17 = mul i32 %13, -2836
  %18 = add i32 %16, %17
  %19 = icmp slt i32 %18, 0
  %20 = add nsw i32 %18, 2147483647
  %..1 = select i1 %19, i32 %20, i32 %18
  %21 = or i64 %4, 3
  %22 = getelementptr inbounds i32* %iv, i64 %21
  store i32 %..1, i32* %22, align 4, !tbaa !2
  %23 = sdiv i32 %..1, 127773
  %24 = mul i32 %23, -127773
  %25 = add i32 %24, %..1
  %26 = mul nsw i32 %25, 16807
  %27 = mul i32 %23, -2836
  %28 = add i32 %26, %27
  %29 = icmp slt i32 %28, 0
  %30 = add nsw i32 %28, 2147483647
  %..2 = select i1 %29, i32 %30, i32 %28
  %31 = or i64 %4, 2
  %32 = getelementptr inbounds i32* %iv, i64 %31
  store i32 %..2, i32* %32, align 4, !tbaa !2
  %33 = sdiv i32 %..2, 127773
  %34 = mul i32 %33, -127773
  %35 = add i32 %34, %..2
  %36 = mul nsw i32 %35, 16807
  %37 = mul i32 %33, -2836
  %38 = add i32 %36, %37
  %39 = icmp slt i32 %38, 0
  %40 = add nsw i32 %38, 2147483647
  %..3 = select i1 %39, i32 %40, i32 %38
  %41 = or i64 %4, 1
  %42 = getelementptr inbounds i32* %iv, i64 %41
  store i32 %..3, i32* %42, align 4, !tbaa !2
  %43 = sdiv i32 %..3, 127773
  %44 = mul i32 %43, -127773
  %45 = add i32 %44, %..3
  %46 = mul nsw i32 %45, 16807
  %47 = mul i32 %43, -2836
  %48 = add i32 %46, %47
  %49 = add nsw i32 %48, 2147483647
  %50 = icmp slt i32 %48, 0
  %..4 = select i1 %50, i32 %49, i32 %48
  %51 = getelementptr inbounds i32* %iv, i64 %4
  store i32 %..4, i32* %51, align 4, !tbaa !2
  %52 = load i32* %iv, align 4, !tbaa !2
  %53 = sdiv i32 %52, 536870912
  %54 = add nsw i32 %53, %3
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds i32* %iv, i64 %55
  %57 = load i32* %56, align 4, !tbaa !2
  %58 = sitofp i32 %57 to float
  %59 = fmul float %58, 0x3E00000000000000
  ret float %59
}

declare i64 @get_local_id(i32) #1

; Function Attrs: nounwind uwtable
define double @BoxMuller(double %uniform.coerce) #0 {
  %1 = bitcast double %uniform.coerce to <2 x float>
  %2 = extractelement <2 x float> %1, i32 0
  %3 = tail call float @llvm.log2.f32(float %2)
  %4 = fmul float %3, 0x3FE62E4300000000
  %5 = fmul float %4, -2.000000e+00
  %6 = tail call float @llvm.sqrt.f32(float %5)
  %7 = extractelement <2 x float> %1, i32 1
  %8 = fmul float %7, 0x40191EB860000000
  %9 = tail call float @_Z3sinf(float %8) #3
  %10 = fmul float %6, %9
  %11 = insertelement <2 x float> undef, float %10, i32 0
  %12 = tail call float @_Z3cosf(float %8) #3
  %13 = fmul float %6, %12
  %14 = insertelement <2 x float> %11, float %13, i32 1
  %15 = bitcast <2 x float> %14 to double
  ret double %15
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

; Function Attrs: nounwind uwtable
define void @gaussian_transform(<4 x i8>* nocapture readonly %inputImage, <4 x i8>* nocapture %outputImage, i32 %factor) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = tail call i64 @get_global_size(i32 0) #3
  %3 = shl i64 %2, 1
  %4 = tail call i64 @get_global_id(i32 1) #3
  %5 = mul i64 %3, %4
  %6 = add i64 %5, %1
  %sext = shl i64 %6, 32
  %7 = ashr exact i64 %sext, 32
  %8 = getelementptr inbounds <4 x i8>* %inputImage, i64 %7
  %9 = load <4 x i8>* %8, align 4, !tbaa !6
  %10 = bitcast <4 x i8> %9 to i32
  %11 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %10) #3
  %12 = tail call i64 @get_global_size(i32 0) #3
  %13 = add i64 %7, %12
  %14 = getelementptr inbounds <4 x i8>* %inputImage, i64 %13
  %15 = load <4 x i8>* %14, align 4, !tbaa !6
  %16 = bitcast <4 x i8> %15 to i32
  %17 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %16) #3
  %18 = extractelement <4 x float> %11, i32 0
  %19 = extractelement <4 x float> %11, i32 1
  %20 = fadd float %18, %19
  %21 = extractelement <4 x float> %11, i32 2
  %22 = fadd float %21, %20
  %23 = extractelement <4 x float> %11, i32 3
  %24 = fadd float %23, %22
  %25 = fmul float %24, 2.500000e-01
  %26 = extractelement <4 x float> %17, i32 0
  %27 = extractelement <4 x float> %17, i32 1
  %28 = fadd float %26, %27
  %29 = extractelement <4 x float> %17, i32 2
  %30 = fadd float %29, %28
  %31 = extractelement <4 x float> %17, i32 3
  %32 = fadd float %31, %30
  %33 = fmul float %32, 2.500000e-01
  %34 = fsub float -0.000000e+00, %25
  %35 = fptosi float %34 to i32
  %36 = tail call float @ran1(i32 %35, i32* getelementptr inbounds ([1024 x i32]* @gaussian_transform.iv0, i64 0, i64 0))
  %37 = fsub float -0.000000e+00, %33
  %38 = fptosi float %37 to i32
  %39 = tail call float @ran1(i32 %38, i32* getelementptr inbounds ([1024 x i32]* @gaussian_transform.iv1, i64 0, i64 0))
  %40 = tail call float @llvm.log2.f32(float %36) #3
  %41 = fmul float %40, 0x3FE62E4300000000
  %42 = fmul float %41, -2.000000e+00
  %43 = tail call float @llvm.sqrt.f32(float %42) #3
  %44 = fmul float %39, 0x40191EB860000000
  %45 = tail call float @_Z3sinf(float %44) #3
  %46 = fmul float %43, %45
  %47 = tail call float @_Z3cosf(float %44) #3
  %48 = fmul float %43, %47
  %49 = sitofp i32 %factor to float
  %50 = fmul float %49, %46
  %51 = insertelement <4 x float> undef, float %50, i32 0
  %52 = shufflevector <4 x float> %51, <4 x float> undef, <4 x i32> zeroinitializer
  %53 = fadd <4 x float> %11, %52
  %54 = tail call i32 @_Z18convert_uchar4_satDv4_f(<4 x float> %53) #3
  %55 = bitcast i32 %54 to <4 x i8>
  %56 = getelementptr inbounds <4 x i8>* %outputImage, i64 %7
  store <4 x i8> %55, <4 x i8>* %56, align 4, !tbaa !6
  %57 = fmul float %49, %48
  %58 = insertelement <4 x float> undef, float %57, i32 0
  %59 = shufflevector <4 x float> %58, <4 x float> undef, <4 x i32> zeroinitializer
  %60 = fadd <4 x float> %17, %59
  %61 = tail call i32 @_Z18convert_uchar4_satDv4_f(<4 x float> %60) #3
  %62 = bitcast i32 %61 to <4 x i8>
  %63 = tail call i64 @get_global_size(i32 0) #3
  %64 = add i64 %63, %7
  %65 = getelementptr inbounds <4 x i8>* %outputImage, i64 %64
  store <4 x i8> %62, <4 x i8>* %65, align 4, !tbaa !6
  ret void
}

declare i64 @get_global_id(i32) #1

declare i64 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(i32) #1

declare i32 @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8>*, <4 x i8>*, i32)* @gaussian_transform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !4, metadata !4, i64 0}

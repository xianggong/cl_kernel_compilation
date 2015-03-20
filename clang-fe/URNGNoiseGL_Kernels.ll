; ModuleID = '../kernel-src/URNGNoiseGL_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@noise_uniform.iv = internal global [256 x i32] zeroinitializer, align 16

; Function Attrs: nounwind uwtable
define float @ran1(i32 %idum, i32* nocapture %iv) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
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
  %49 = icmp slt i32 %48, 0
  %50 = add nsw i32 %48, 2147483647
  %..4 = select i1 %49, i32 %50, i32 %48
  %51 = getelementptr inbounds i32* %iv, i64 %4
  store i32 %..4, i32* %51, align 4, !tbaa !2
  %phitmp = sdiv i32 %..4, 536870912
  %52 = add nsw i32 %phitmp, %3
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds i32* %iv, i64 %53
  %55 = load i32* %54, align 4, !tbaa !2
  %56 = sitofp i32 %55 to float
  %57 = fmul float %56, 0x3E00000000000000
  ret float %57
}

declare i64 @get_local_id(i32) #1

; Function Attrs: nounwind uwtable
define void @noise_uniform(<4 x i8>* nocapture readonly %inputImage, <4 x i8>* nocapture %outputImage, i32 %factor) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_global_id(i32 1) #2
  %3 = tail call i64 @get_global_size(i32 0) #2
  %4 = mul i64 %3, %2
  %5 = add i64 %4, %1
  %sext = shl i64 %5, 32
  %6 = ashr exact i64 %sext, 32
  %7 = getelementptr inbounds <4 x i8>* %inputImage, i64 %6
  %8 = load <4 x i8>* %7, align 4, !tbaa !6
  %9 = bitcast <4 x i8> %8 to i32
  %10 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %9) #2
  %11 = extractelement <4 x float> %10, i32 0
  %12 = extractelement <4 x float> %10, i32 1
  %13 = fadd float %11, %12
  %14 = extractelement <4 x float> %10, i32 2
  %15 = fadd float %14, %13
  %16 = fadd float %12, %15
  %17 = fmul float %16, 2.500000e-01
  %18 = fsub float -0.000000e+00, %17
  %19 = fptosi float %18 to i32
  %20 = tail call float @ran1(i32 %19, i32* getelementptr inbounds ([256 x i32]* @noise_uniform.iv, i64 0, i64 0))
  %21 = fadd float %20, -5.000000e-01
  %22 = sitofp i32 %factor to float
  %23 = fmul float %22, %21
  %24 = insertelement <4 x float> undef, float %23, i32 0
  %25 = shufflevector <4 x float> %24, <4 x float> undef, <4 x i32> zeroinitializer
  %26 = fadd <4 x float> %10, %25
  %27 = tail call i32 @_Z18convert_uchar4_satDv4_f(<4 x float> %26) #2
  %28 = bitcast i32 %27 to <4 x i8>
  %29 = getelementptr inbounds <4 x i8>* %outputImage, i64 %6
  store <4 x i8> %28, <4 x i8>* %29, align 4, !tbaa !6
  ret void
}

declare i64 @get_global_id(i32) #1

declare i64 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(i32) #1

declare i32 @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8>*, <4 x i8>*, i32)* @noise_uniform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !4, metadata !4, i64 0}

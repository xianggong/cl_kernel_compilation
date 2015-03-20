; ModuleID = '../kernel-src/GaussianNoiseGL_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%opencl.image2d_t = type opaque

@gaussian_transform.iv0 = internal global [256 x i32] zeroinitializer, align 16
@gaussian_transform.iv1 = internal global [256 x i32] zeroinitializer, align 16

; Function Attrs: nounwind uwtable
define void @gaussian_transform(<4 x i8>* nocapture readonly %inputImage, %opencl.image2d_t* %outputImage, i32 %factor) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_global_size(i32 0) #2
  %3 = shl i64 %2, 1
  %4 = tail call i64 @get_global_id(i32 1) #2
  %5 = mul i64 %3, %4
  %6 = add i64 %5, %1
  %7 = tail call i64 @get_global_id(i32 0) #2
  %8 = tail call i64 @get_global_size(i32 0) #2
  %9 = add i64 %8, %7
  %10 = tail call i64 @get_global_size(i32 0) #2
  %11 = shl i64 %10, 1
  %12 = tail call i64 @get_global_id(i32 1) #2
  %13 = mul i64 %11, %12
  %14 = add i64 %9, %13
  %sext = shl i64 %6, 32
  %15 = ashr exact i64 %sext, 32
  %16 = getelementptr inbounds <4 x i8>* %inputImage, i64 %15
  %17 = load <4 x i8>* %16, align 4, !tbaa !2
  %18 = bitcast <4 x i8> %17 to i32
  %19 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %18) #2
  %sext5 = shl i64 %14, 32
  %20 = ashr exact i64 %sext5, 32
  %21 = getelementptr inbounds <4 x i8>* %inputImage, i64 %20
  %22 = load <4 x i8>* %21, align 4, !tbaa !2
  %23 = bitcast <4 x i8> %22 to i32
  %24 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %23) #2
  %25 = extractelement <4 x float> %19, i32 0
  %26 = extractelement <4 x float> %19, i32 1
  %27 = fadd float %25, %26
  %28 = extractelement <4 x float> %19, i32 2
  %29 = fadd float %28, %27
  %30 = extractelement <4 x float> %19, i32 3
  %31 = fadd float %30, %29
  %32 = fmul float %31, 2.500000e-01
  %33 = extractelement <4 x float> %24, i32 0
  %34 = extractelement <4 x float> %24, i32 1
  %35 = fadd float %33, %34
  %36 = extractelement <4 x float> %24, i32 2
  %37 = fadd float %36, %35
  %38 = extractelement <4 x float> %24, i32 3
  %39 = fadd float %38, %37
  %40 = fmul float %39, 2.500000e-01
  %41 = fsub float -0.000000e+00, %32
  %42 = fptosi float %41 to i32
  %43 = tail call float @ran1(i32 %42, i32* getelementptr inbounds ([256 x i32]* @gaussian_transform.iv0, i64 0, i64 0)) #2
  %44 = fsub float -0.000000e+00, %40
  %45 = fptosi float %44 to i32
  %46 = tail call float @ran1(i32 %45, i32* getelementptr inbounds ([256 x i32]* @gaussian_transform.iv1, i64 0, i64 0)) #2
  %47 = insertelement <2 x float> undef, float %43, i32 0
  %48 = insertelement <2 x float> %47, float %46, i32 1
  %49 = bitcast <2 x float> %48 to double
  %50 = tail call double @BoxMuller(double %49) #2
  %51 = bitcast double %50 to <2 x float>
  %52 = extractelement <2 x float> %51, i32 0
  %53 = sitofp i32 %factor to float
  %54 = fmul float %53, %52
  %55 = insertelement <4 x float> undef, float %54, i32 0
  %56 = shufflevector <4 x float> %55, <4 x float> undef, <4 x i32> zeroinitializer
  %57 = fadd <4 x float> %19, %56
  %58 = fdiv <4 x float> %57, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !5
  %59 = extractelement <2 x float> %51, i32 1
  %60 = fmul float %53, %59
  %61 = insertelement <4 x float> undef, float %60, i32 0
  %62 = shufflevector <4 x float> %61, <4 x float> undef, <4 x i32> zeroinitializer
  %63 = fadd <4 x float> %24, %62
  %64 = fdiv <4 x float> %63, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !5
  %65 = tail call i64 @get_global_id(i32 0) #2
  %66 = trunc i64 %65 to i32
  %67 = insertelement <2 x i32> undef, i32 %66, i32 0
  %68 = tail call i64 @get_global_id(i32 1) #2
  %69 = trunc i64 %68 to i32
  %70 = insertelement <2 x i32> %67, i32 %69, i32 1
  %71 = tail call i64 @get_global_id(i32 0) #2
  %72 = tail call i64 @get_global_size(i32 0) #2
  %73 = add i64 %72, %71
  %74 = trunc i64 %73 to i32
  %75 = insertelement <2 x i32> undef, i32 %74, i32 0
  %76 = tail call i64 @get_global_id(i32 1) #2
  %77 = trunc i64 %76 to i32
  %78 = insertelement <2 x i32> %75, i32 %77, i32 1
  %79 = bitcast <2 x i32> %70 to double
  %80 = tail call i32 (%opencl.image2d_t*, double, <4 x float>, ...)* bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, double, <4 x float>, ...)*)(%opencl.image2d_t* %outputImage, double %79, <4 x float> %58) #2
  %81 = bitcast <2 x i32> %78 to double
  %82 = tail call i32 (%opencl.image2d_t*, double, <4 x float>, ...)* bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, double, <4 x float>, ...)*)(%opencl.image2d_t* %outputImage, double %81, <4 x float> %64) #2
  ret void
}

declare i64 @get_global_id(i32) #1

declare i64 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(i32) #1

declare float @ran1(i32, i32*) #1

declare double @BoxMuller(double) #1

declare i32 @write_imagef(...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8>*, %opencl.image2d_t*, i32)* @gaussian_transform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

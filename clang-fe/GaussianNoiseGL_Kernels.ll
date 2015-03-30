; ModuleID = '../kernel-src/GaussianNoiseGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%opencl.image2d_t = type opaque

@gaussian_transform.iv0 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* nocapture readonly %inputImage, %opencl.image2d_t* %outputImage, i32 %factor) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_size(i32 0) #2
  %3 = shl i32 %2, 1
  %4 = tail call i32 @get_global_id(i32 1) #2
  %5 = mul i32 %3, %4
  %6 = add i32 %5, %1
  %7 = tail call i32 @get_global_id(i32 0) #2
  %8 = tail call i32 @get_global_size(i32 0) #2
  %9 = add i32 %8, %7
  %10 = tail call i32 @get_global_size(i32 0) #2
  %11 = shl i32 %10, 1
  %12 = tail call i32 @get_global_id(i32 1) #2
  %13 = mul i32 %11, %12
  %14 = add i32 %9, %13
  %15 = sext i32 %6 to i64
  %16 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %15
  %17 = load <4 x i8> addrspace(1)* %16, align 4, !tbaa !2
  %18 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %17) #2
  %19 = sext i32 %14 to i64
  %20 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %19
  %21 = load <4 x i8> addrspace(1)* %20, align 4, !tbaa !2
  %22 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %21) #2
  %23 = extractelement <4 x float> %18, i32 0
  %24 = extractelement <4 x float> %18, i32 1
  %25 = fadd float %23, %24
  %26 = extractelement <4 x float> %18, i32 2
  %27 = fadd float %26, %25
  %28 = extractelement <4 x float> %18, i32 3
  %29 = fadd float %28, %27
  %30 = fmul float %29, 2.500000e-01
  %31 = extractelement <4 x float> %22, i32 0
  %32 = extractelement <4 x float> %22, i32 1
  %33 = fadd float %31, %32
  %34 = extractelement <4 x float> %22, i32 2
  %35 = fadd float %34, %33
  %36 = extractelement <4 x float> %22, i32 3
  %37 = fadd float %36, %35
  %38 = fmul float %37, 2.500000e-01
  %39 = fsub float -0.000000e+00, %30
  %40 = fptosi float %39 to i32
  %41 = tail call float @ran1(i32 %40, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0)) #2
  %42 = fsub float -0.000000e+00, %38
  %43 = fptosi float %42 to i32
  %44 = tail call float @ran1(i32 %43, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0)) #2
  %45 = insertelement <2 x float> undef, float %41, i32 0
  %46 = insertelement <2 x float> %45, float %44, i32 1
  %47 = tail call <2 x float> @BoxMuller(<2 x float> %46) #2
  %48 = extractelement <2 x float> %47, i32 0
  %49 = sitofp i32 %factor to float
  %50 = fmul float %49, %48
  %51 = insertelement <4 x float> undef, float %50, i32 0
  %52 = shufflevector <4 x float> %51, <4 x float> undef, <4 x i32> zeroinitializer
  %53 = fadd <4 x float> %18, %52
  %54 = fdiv <4 x float> %53, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !5
  %55 = extractelement <2 x float> %47, i32 1
  %56 = fmul float %49, %55
  %57 = insertelement <4 x float> undef, float %56, i32 0
  %58 = shufflevector <4 x float> %57, <4 x float> undef, <4 x i32> zeroinitializer
  %59 = fadd <4 x float> %22, %58
  %60 = fdiv <4 x float> %59, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !5
  %61 = tail call i32 @get_global_id(i32 0) #2
  %62 = insertelement <2 x i32> undef, i32 %61, i32 0
  %63 = tail call i32 @get_global_id(i32 1) #2
  %64 = insertelement <2 x i32> %62, i32 %63, i32 1
  %65 = tail call i32 @get_global_id(i32 0) #2
  %66 = tail call i32 @get_global_size(i32 0) #2
  %67 = add i32 %66, %65
  %68 = insertelement <2 x i32> undef, i32 %67, i32 0
  %69 = tail call i32 @get_global_id(i32 1) #2
  %70 = insertelement <2 x i32> %68, i32 %69, i32 1
  %71 = tail call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t* %outputImage, <2 x i32> %64, <4 x float> %54) #2
  %72 = tail call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t* %outputImage, <2 x i32> %70, <4 x float> %60) #2
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare float @ran1(i32, i32 addrspace(3)*) #1

declare <2 x float> @BoxMuller(<2 x float>) #1

declare i32 @write_imagef(...) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, %opencl.image2d_t*, i32)* @gaussian_transform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

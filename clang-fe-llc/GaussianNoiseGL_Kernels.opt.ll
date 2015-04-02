; ModuleID = 'GaussianNoiseGL_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%opencl.image2d_t = type opaque

@gaussian_transform.iv0 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* %inputImage, %opencl.image2d_t* %outputImage, i32 %factor) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_global_size(i32 0)
  %3 = mul i32 2, %2
  %4 = call i32 @get_global_id(i32 1)
  %5 = mul i32 %3, %4
  %6 = add i32 %1, %5
  %7 = call i32 @get_global_id(i32 0)
  %8 = call i32 @get_global_size(i32 0)
  %9 = add i32 %7, %8
  %10 = call i32 @get_global_size(i32 0)
  %11 = mul i32 2, %10
  %12 = call i32 @get_global_id(i32 1)
  %13 = mul i32 %11, %12
  %14 = add i32 %9, %13
  %15 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %6
  %16 = load <4 x i8> addrspace(1)* %15, align 4
  %17 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %16)
  %18 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %14
  %19 = load <4 x i8> addrspace(1)* %18, align 4
  %20 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %19)
  %21 = extractelement <4 x float> %17, i32 0
  %22 = extractelement <4 x float> %17, i32 1
  %23 = fadd float %21, %22
  %24 = extractelement <4 x float> %17, i32 2
  %25 = fadd float %23, %24
  %26 = extractelement <4 x float> %17, i32 3
  %27 = fadd float %25, %26
  %28 = fdiv float %27, 4.000000e+00, !fpmath !2
  %29 = extractelement <4 x float> %20, i32 0
  %30 = extractelement <4 x float> %20, i32 1
  %31 = fadd float %29, %30
  %32 = extractelement <4 x float> %20, i32 2
  %33 = fadd float %31, %32
  %34 = extractelement <4 x float> %20, i32 3
  %35 = fadd float %33, %34
  %36 = fdiv float %35, 4.000000e+00, !fpmath !2
  %37 = fsub float -0.000000e+00, %28
  %38 = fptosi float %37 to i32
  %39 = call float @ran1(i32 %38, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  %40 = fsub float -0.000000e+00, %36
  %41 = fptosi float %40 to i32
  %42 = call float @ran1(i32 %41, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  %43 = insertelement <2 x float> undef, float %39, i32 0
  %44 = insertelement <2 x float> %43, float %42, i32 1
  %45 = call <2 x float> @BoxMuller(<2 x float> %44)
  %46 = extractelement <2 x float> %45, i32 0
  %47 = sitofp i32 %factor to float
  %48 = fmul float %46, %47
  %49 = insertelement <4 x float> undef, float %48, i32 0
  %50 = shufflevector <4 x float> %49, <4 x float> undef, <4 x i32> zeroinitializer
  %51 = fadd <4 x float> %17, %50
  %52 = fdiv <4 x float> %51, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !2
  %53 = extractelement <2 x float> %45, i32 1
  %54 = sitofp i32 %factor to float
  %55 = fmul float %53, %54
  %56 = insertelement <4 x float> undef, float %55, i32 0
  %57 = shufflevector <4 x float> %56, <4 x float> undef, <4 x i32> zeroinitializer
  %58 = fadd <4 x float> %20, %57
  %59 = fdiv <4 x float> %58, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !2
  %60 = call i32 @get_global_id(i32 0)
  %61 = insertelement <2 x i32> undef, i32 %60, i32 0
  %62 = call i32 @get_global_id(i32 1)
  %63 = insertelement <2 x i32> %61, i32 %62, i32 1
  %64 = call i32 @get_global_id(i32 0)
  %65 = call i32 @get_global_size(i32 0)
  %66 = add i32 %64, %65
  %67 = insertelement <2 x i32> undef, i32 %66, i32 0
  %68 = call i32 @get_global_id(i32 1)
  %69 = insertelement <2 x i32> %67, i32 %68, i32 1
  %70 = call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t* %outputImage, <2 x i32> %63, <4 x float> %52)
  %71 = call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t* %outputImage, <2 x i32> %69, <4 x float> %59)
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

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, %opencl.image2d_t*, i32)* @gaussian_transform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

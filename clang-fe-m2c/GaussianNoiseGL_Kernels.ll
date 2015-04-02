; ModuleID = '../kernel-src/GaussianNoiseGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%opencl.image2d_t = type opaque

@gaussian_transform.iv0 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* %inputImage, %opencl.image2d_t* %outputImage, i32 %factor) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca %opencl.image2d_t*, align 4
  %3 = alloca i32, align 4
  %pos0 = alloca i32, align 4
  %pos1 = alloca i32, align 4
  %texel0 = alloca <4 x float>, align 16
  %texel1 = alloca <4 x float>, align 16
  %avg0 = alloca float, align 4
  %avg1 = alloca float, align 4
  %dev0 = alloca float, align 4
  %dev1 = alloca float, align 4
  %gaussian = alloca <2 x float>, align 8
  %4 = alloca <2 x float>, align 8
  %out0 = alloca <4 x float>, align 16
  %out1 = alloca <4 x float>, align 16
  %locate0 = alloca <2 x i32>, align 8
  %locate1 = alloca <2 x i32>, align 8
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %1, align 4
  store %opencl.image2d_t* %outputImage, %opencl.image2d_t** %2, align 4
  store i32 %factor, i32* %3, align 4
  %5 = call i32 @__get_global_id_u32(i32 0)
  %6 = call i32 @__get_global_size_u32(i32 0)
  %7 = mul i32 2, %6
  %8 = call i32 @__get_global_id_u32(i32 1)
  %9 = mul i32 %7, %8
  %10 = add i32 %5, %9
  store i32 %10, i32* %pos0, align 4
  %11 = call i32 @__get_global_id_u32(i32 0)
  %12 = call i32 @__get_global_size_u32(i32 0)
  %13 = add i32 %11, %12
  %14 = call i32 @__get_global_size_u32(i32 0)
  %15 = mul i32 2, %14
  %16 = call i32 @__get_global_id_u32(i32 1)
  %17 = mul i32 %15, %16
  %18 = add i32 %13, %17
  store i32 %18, i32* %pos1, align 4
  %19 = load i32* %pos0, align 4
  %20 = load <4 x i8> addrspace(1)** %1, align 4
  %21 = getelementptr inbounds <4 x i8> addrspace(1)* %20, i32 %19
  %22 = load <4 x i8> addrspace(1)* %21, align 4
  %23 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %22)
  store <4 x float> %23, <4 x float>* %texel0, align 16
  %24 = load i32* %pos1, align 4
  %25 = load <4 x i8> addrspace(1)** %1, align 4
  %26 = getelementptr inbounds <4 x i8> addrspace(1)* %25, i32 %24
  %27 = load <4 x i8> addrspace(1)* %26, align 4
  %28 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %27)
  store <4 x float> %28, <4 x float>* %texel1, align 16
  %29 = load <4 x float>* %texel0, align 16
  %30 = extractelement <4 x float> %29, i32 0
  %31 = load <4 x float>* %texel0, align 16
  %32 = extractelement <4 x float> %31, i32 1
  %33 = fadd float %30, %32
  %34 = load <4 x float>* %texel0, align 16
  %35 = extractelement <4 x float> %34, i32 2
  %36 = fadd float %33, %35
  %37 = load <4 x float>* %texel0, align 16
  %38 = extractelement <4 x float> %37, i32 3
  %39 = fadd float %36, %38
  %40 = fdiv float %39, 4.000000e+00, !fpmath !2
  store float %40, float* %avg0, align 4
  %41 = load <4 x float>* %texel1, align 16
  %42 = extractelement <4 x float> %41, i32 0
  %43 = load <4 x float>* %texel1, align 16
  %44 = extractelement <4 x float> %43, i32 1
  %45 = fadd float %42, %44
  %46 = load <4 x float>* %texel1, align 16
  %47 = extractelement <4 x float> %46, i32 2
  %48 = fadd float %45, %47
  %49 = load <4 x float>* %texel1, align 16
  %50 = extractelement <4 x float> %49, i32 3
  %51 = fadd float %48, %50
  %52 = fdiv float %51, 4.000000e+00, !fpmath !2
  store float %52, float* %avg1, align 4
  %53 = load float* %avg0, align 4
  %54 = fsub float -0.000000e+00, %53
  %55 = fptosi float %54 to i32
  %56 = call float @ran1(i32 %55, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  store float %56, float* %dev0, align 4
  %57 = load float* %avg1, align 4
  %58 = fsub float -0.000000e+00, %57
  %59 = fptosi float %58 to i32
  %60 = call float @ran1(i32 %59, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  store float %60, float* %dev1, align 4
  %61 = load float* %dev0, align 4
  %62 = insertelement <2 x float> undef, float %61, i32 0
  %63 = load float* %dev1, align 4
  %64 = insertelement <2 x float> %62, float %63, i32 1
  store <2 x float> %64, <2 x float>* %4
  %65 = load <2 x float>* %4
  %66 = call <2 x float> @BoxMuller(<2 x float> %65)
  store <2 x float> %66, <2 x float>* %gaussian, align 8
  %67 = load <4 x float>* %texel0, align 16
  %68 = load <2 x float>* %gaussian, align 8
  %69 = extractelement <2 x float> %68, i32 0
  %70 = load i32* %3, align 4
  %71 = sitofp i32 %70 to float
  %72 = fmul float %69, %71
  %73 = insertelement <4 x float> undef, float %72, i32 0
  %74 = shufflevector <4 x float> %73, <4 x float> undef, <4 x i32> zeroinitializer
  %75 = fadd <4 x float> %67, %74
  %76 = fdiv <4 x float> %75, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !2
  store <4 x float> %76, <4 x float>* %out0, align 16
  %77 = load <4 x float>* %texel1, align 16
  %78 = load <2 x float>* %gaussian, align 8
  %79 = extractelement <2 x float> %78, i32 1
  %80 = load i32* %3, align 4
  %81 = sitofp i32 %80 to float
  %82 = fmul float %79, %81
  %83 = insertelement <4 x float> undef, float %82, i32 0
  %84 = shufflevector <4 x float> %83, <4 x float> undef, <4 x i32> zeroinitializer
  %85 = fadd <4 x float> %77, %84
  %86 = fdiv <4 x float> %85, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !2
  store <4 x float> %86, <4 x float>* %out1, align 16
  %87 = call i32 @__get_global_id_u32(i32 0)
  %88 = load <2 x i32>* %locate0, align 8
  %89 = insertelement <2 x i32> %88, i32 %87, i32 0
  store <2 x i32> %89, <2 x i32>* %locate0, align 8
  %90 = call i32 @__get_global_id_u32(i32 1)
  %91 = load <2 x i32>* %locate0, align 8
  %92 = insertelement <2 x i32> %91, i32 %90, i32 1
  store <2 x i32> %92, <2 x i32>* %locate0, align 8
  %93 = call i32 @__get_global_id_u32(i32 0)
  %94 = call i32 @__get_global_size_u32(i32 0)
  %95 = add i32 %93, %94
  %96 = load <2 x i32>* %locate1, align 8
  %97 = insertelement <2 x i32> %96, i32 %95, i32 0
  store <2 x i32> %97, <2 x i32>* %locate1, align 8
  %98 = call i32 @__get_global_id_u32(i32 1)
  %99 = load <2 x i32>* %locate1, align 8
  %100 = insertelement <2 x i32> %99, i32 %98, i32 1
  store <2 x i32> %100, <2 x i32>* %locate1, align 8
  %101 = load %opencl.image2d_t** %2, align 4
  %102 = load <2 x i32>* %locate0, align 8
  %103 = load <4 x float>* %out0, align 16
  %104 = call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t* %101, <2 x i32> %102, <4 x float> %103)
  %105 = load %opencl.image2d_t** %2, align 4
  %106 = load <2 x i32>* %locate1, align 8
  %107 = load <4 x float>* %out1, align 16
  %108 = call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t* %105, <2 x i32> %106, <4 x float> %107)
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

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

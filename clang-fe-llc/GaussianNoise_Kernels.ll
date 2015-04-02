; ModuleID = '../kernel-src/GaussianNoise_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@gaussian_transform.iv0 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32 addrspace(3)*, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %iy = alloca i32, align 4
  %tid = alloca i32, align 4
  store i32 %idum, i32* %1, align 4
  store i32 addrspace(3)* %iv, i32 addrspace(3)** %2, align 4
  store i32 0, i32* %iy, align 4
  %3 = call i32 @get_local_id(i32 0)
  store i32 %3, i32* %tid, align 4
  store i32 4, i32* %j, align 4
  br label %4

; <label>:4                                       ; preds = %35, %0
  %5 = load i32* %j, align 4
  %6 = icmp sge i32 %5, 0
  br i1 %6, label %7, label %38

; <label>:7                                       ; preds = %4
  %8 = load i32* %1, align 4
  %9 = sdiv i32 %8, 127773
  store i32 %9, i32* %k, align 4
  %10 = load i32* %1, align 4
  %11 = load i32* %k, align 4
  %12 = mul nsw i32 %11, 127773
  %13 = sub nsw i32 %10, %12
  %14 = mul nsw i32 16807, %13
  %15 = load i32* %k, align 4
  %16 = mul nsw i32 2836, %15
  %17 = sub nsw i32 %14, %16
  store i32 %17, i32* %1, align 4
  %18 = load i32* %1, align 4
  %19 = icmp slt i32 %18, 0
  br i1 %19, label %20, label %23

; <label>:20                                      ; preds = %7
  %21 = load i32* %1, align 4
  %22 = add nsw i32 %21, 2147483647
  store i32 %22, i32* %1, align 4
  br label %23

; <label>:23                                      ; preds = %20, %7
  %24 = load i32* %j, align 4
  %25 = icmp slt i32 %24, 4
  br i1 %25, label %26, label %34

; <label>:26                                      ; preds = %23
  %27 = load i32* %1, align 4
  %28 = load i32* %tid, align 4
  %29 = mul nsw i32 4, %28
  %30 = load i32* %j, align 4
  %31 = add nsw i32 %29, %30
  %32 = load i32 addrspace(3)** %2, align 4
  %33 = getelementptr inbounds i32 addrspace(3)* %32, i32 %31
  store i32 %27, i32 addrspace(3)* %33, align 4
  br label %34

; <label>:34                                      ; preds = %26, %23
  br label %35

; <label>:35                                      ; preds = %34
  %36 = load i32* %j, align 4
  %37 = add nsw i32 %36, -1
  store i32 %37, i32* %j, align 4
  br label %4

; <label>:38                                      ; preds = %4
  %39 = load i32 addrspace(3)** %2, align 4
  %40 = getelementptr inbounds i32 addrspace(3)* %39, i32 0
  %41 = load i32 addrspace(3)* %40, align 4
  store i32 %41, i32* %iy, align 4
  %42 = load i32* %1, align 4
  %43 = sdiv i32 %42, 127773
  store i32 %43, i32* %k, align 4
  %44 = load i32* %1, align 4
  %45 = load i32* %k, align 4
  %46 = mul nsw i32 %45, 127773
  %47 = sub nsw i32 %44, %46
  %48 = mul nsw i32 16807, %47
  %49 = load i32* %k, align 4
  %50 = mul nsw i32 2836, %49
  %51 = sub nsw i32 %48, %50
  store i32 %51, i32* %1, align 4
  %52 = load i32* %1, align 4
  %53 = icmp slt i32 %52, 0
  br i1 %53, label %54, label %57

; <label>:54                                      ; preds = %38
  %55 = load i32* %1, align 4
  %56 = add nsw i32 %55, 2147483647
  store i32 %56, i32* %1, align 4
  br label %57

; <label>:57                                      ; preds = %54, %38
  %58 = load i32* %iy, align 4
  %59 = sdiv i32 %58, 536870912
  store i32 %59, i32* %j, align 4
  %60 = load i32* %tid, align 4
  %61 = mul nsw i32 4, %60
  %62 = load i32* %j, align 4
  %63 = add nsw i32 %61, %62
  %64 = load i32 addrspace(3)** %2, align 4
  %65 = getelementptr inbounds i32 addrspace(3)* %64, i32 %63
  %66 = load i32 addrspace(3)* %65, align 4
  store i32 %66, i32* %iy, align 4
  %67 = load i32* %iy, align 4
  %68 = sitofp i32 %67 to float
  %69 = fmul float 0x3E00000000000000, %68
  ret float %69
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
  %1 = alloca <2 x float>, align 8
  %r = alloca float, align 4
  %theta = alloca float, align 4
  %2 = alloca <2 x float>, align 8
  store <2 x float> %uniform, <2 x float>* %1, align 8
  %3 = load <2 x float>* %1, align 8
  %4 = extractelement <2 x float> %3, i32 0
  %5 = call float @llvm.log2.f32(float %4)
  %6 = fmul float %5, 0x3FE62E4300000000
  %7 = fmul float -2.000000e+00, %6
  %8 = call float @llvm.sqrt.f32(float %7)
  store float %8, float* %r, align 4
  %9 = load <2 x float>* %1, align 8
  %10 = extractelement <2 x float> %9, i32 1
  %11 = fmul float 0x40191EB860000000, %10
  store float %11, float* %theta, align 4
  %12 = load float* %r, align 4
  %13 = load float* %theta, align 4
  %14 = call float @_Z3sinf(float %13)
  %15 = fmul float %12, %14
  %16 = insertelement <2 x float> undef, float %15, i32 0
  %17 = load float* %r, align 4
  %18 = load float* %theta, align 4
  %19 = call float @_Z3cosf(float %18)
  %20 = fmul float %17, %19
  %21 = insertelement <2 x float> %16, float %20, i32 1
  store <2 x float> %21, <2 x float>* %2
  %22 = load <2 x float>* %2
  ret <2 x float> %22
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca <4 x i8> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %pos = alloca i32, align 4
  %texel0 = alloca <4 x float>, align 16
  %texel1 = alloca <4 x float>, align 16
  %avg0 = alloca float, align 4
  %avg1 = alloca float, align 4
  %dev0 = alloca float, align 4
  %dev1 = alloca float, align 4
  %gaussian = alloca <2 x float>, align 8
  %4 = alloca <2 x float>, align 8
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %2, align 4
  store i32 %factor, i32* %3, align 4
  %5 = call i32 @get_global_id(i32 0)
  %6 = call i32 @get_global_size(i32 0)
  %7 = mul i32 2, %6
  %8 = call i32 @get_global_id(i32 1)
  %9 = mul i32 %7, %8
  %10 = add i32 %5, %9
  store i32 %10, i32* %pos, align 4
  %11 = load i32* %pos, align 4
  %12 = load <4 x i8> addrspace(1)** %1, align 4
  %13 = getelementptr inbounds <4 x i8> addrspace(1)* %12, i32 %11
  %14 = load <4 x i8> addrspace(1)* %13, align 4
  %15 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %14)
  store <4 x float> %15, <4 x float>* %texel0, align 16
  %16 = load i32* %pos, align 4
  %17 = call i32 @get_global_size(i32 0)
  %18 = add i32 %16, %17
  %19 = load <4 x i8> addrspace(1)** %1, align 4
  %20 = getelementptr inbounds <4 x i8> addrspace(1)* %19, i32 %18
  %21 = load <4 x i8> addrspace(1)* %20, align 4
  %22 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %21)
  store <4 x float> %22, <4 x float>* %texel1, align 16
  %23 = load <4 x float>* %texel0, align 16
  %24 = extractelement <4 x float> %23, i32 0
  %25 = load <4 x float>* %texel0, align 16
  %26 = extractelement <4 x float> %25, i32 1
  %27 = fadd float %24, %26
  %28 = load <4 x float>* %texel0, align 16
  %29 = extractelement <4 x float> %28, i32 2
  %30 = fadd float %27, %29
  %31 = load <4 x float>* %texel0, align 16
  %32 = extractelement <4 x float> %31, i32 3
  %33 = fadd float %30, %32
  %34 = fdiv float %33, 4.000000e+00, !fpmath !2
  store float %34, float* %avg0, align 4
  %35 = load <4 x float>* %texel1, align 16
  %36 = extractelement <4 x float> %35, i32 0
  %37 = load <4 x float>* %texel1, align 16
  %38 = extractelement <4 x float> %37, i32 1
  %39 = fadd float %36, %38
  %40 = load <4 x float>* %texel1, align 16
  %41 = extractelement <4 x float> %40, i32 2
  %42 = fadd float %39, %41
  %43 = load <4 x float>* %texel1, align 16
  %44 = extractelement <4 x float> %43, i32 3
  %45 = fadd float %42, %44
  %46 = fdiv float %45, 4.000000e+00, !fpmath !2
  store float %46, float* %avg1, align 4
  %47 = load float* %avg0, align 4
  %48 = fsub float -0.000000e+00, %47
  %49 = fptosi float %48 to i32
  %50 = call float @ran1(i32 %49, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  store float %50, float* %dev0, align 4
  %51 = load float* %avg1, align 4
  %52 = fsub float -0.000000e+00, %51
  %53 = fptosi float %52 to i32
  %54 = call float @ran1(i32 %53, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  store float %54, float* %dev1, align 4
  %55 = load float* %dev0, align 4
  %56 = insertelement <2 x float> undef, float %55, i32 0
  %57 = load float* %dev1, align 4
  %58 = insertelement <2 x float> %56, float %57, i32 1
  store <2 x float> %58, <2 x float>* %4
  %59 = load <2 x float>* %4
  %60 = call <2 x float> @BoxMuller(<2 x float> %59)
  store <2 x float> %60, <2 x float>* %gaussian, align 8
  %61 = load <4 x float>* %texel0, align 16
  %62 = load <2 x float>* %gaussian, align 8
  %63 = extractelement <2 x float> %62, i32 0
  %64 = load i32* %3, align 4
  %65 = sitofp i32 %64 to float
  %66 = fmul float %63, %65
  %67 = insertelement <4 x float> undef, float %66, i32 0
  %68 = shufflevector <4 x float> %67, <4 x float> undef, <4 x i32> zeroinitializer
  %69 = fadd <4 x float> %61, %68
  %70 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %69)
  %71 = load i32* %pos, align 4
  %72 = load <4 x i8> addrspace(1)** %2, align 4
  %73 = getelementptr inbounds <4 x i8> addrspace(1)* %72, i32 %71
  store <4 x i8> %70, <4 x i8> addrspace(1)* %73, align 4
  %74 = load <4 x float>* %texel1, align 16
  %75 = load <2 x float>* %gaussian, align 8
  %76 = extractelement <2 x float> %75, i32 1
  %77 = load i32* %3, align 4
  %78 = sitofp i32 %77 to float
  %79 = fmul float %76, %78
  %80 = insertelement <4 x float> undef, float %79, i32 0
  %81 = shufflevector <4 x float> %80, <4 x float> undef, <4 x i32> zeroinitializer
  %82 = fadd <4 x float> %74, %81
  %83 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %82)
  %84 = load i32* %pos, align 4
  %85 = call i32 @get_global_size(i32 0)
  %86 = add i32 %84, %85
  %87 = load <4 x i8> addrspace(1)** %2, align 4
  %88 = getelementptr inbounds <4 x i8> addrspace(1)* %87, i32 %86
  store <4 x i8> %83, <4 x i8> addrspace(1)* %88, align 4
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @gaussian_transform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

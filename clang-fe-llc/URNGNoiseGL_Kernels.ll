; ModuleID = '../kernel-src/URNGNoiseGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@noise_uniform.iv = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

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
  %39 = load i32* %tid, align 4
  %40 = mul nsw i32 4, %39
  %41 = load i32 addrspace(3)** %2, align 4
  %42 = getelementptr inbounds i32 addrspace(3)* %41, i32 %40
  %43 = load i32 addrspace(3)* %42, align 4
  store i32 %43, i32* %iy, align 4
  %44 = load i32* %1, align 4
  %45 = sdiv i32 %44, 127773
  store i32 %45, i32* %k, align 4
  %46 = load i32* %1, align 4
  %47 = load i32* %k, align 4
  %48 = mul nsw i32 %47, 127773
  %49 = sub nsw i32 %46, %48
  %50 = mul nsw i32 16807, %49
  %51 = load i32* %k, align 4
  %52 = mul nsw i32 2836, %51
  %53 = sub nsw i32 %50, %52
  store i32 %53, i32* %1, align 4
  %54 = load i32* %1, align 4
  %55 = icmp slt i32 %54, 0
  br i1 %55, label %56, label %59

; <label>:56                                      ; preds = %38
  %57 = load i32* %1, align 4
  %58 = add nsw i32 %57, 2147483647
  store i32 %58, i32* %1, align 4
  br label %59

; <label>:59                                      ; preds = %56, %38
  %60 = load i32* %iy, align 4
  %61 = sdiv i32 %60, 536870912
  store i32 %61, i32* %j, align 4
  %62 = load i32* %tid, align 4
  %63 = mul nsw i32 4, %62
  %64 = load i32* %j, align 4
  %65 = add nsw i32 %63, %64
  %66 = load i32 addrspace(3)** %2, align 4
  %67 = getelementptr inbounds i32 addrspace(3)* %66, i32 %65
  %68 = load i32 addrspace(3)* %67, align 4
  store i32 %68, i32* %iy, align 4
  %69 = load i32* %iy, align 4
  %70 = sitofp i32 %69 to float
  %71 = fmul float 0x3E00000000000000, %70
  ret float %71
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define void @noise_uniform(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca <4 x i8> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %pos = alloca i32, align 4
  %temp = alloca <4 x float>, align 16
  %avg = alloca float, align 4
  %dev = alloca float, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %2, align 4
  store i32 %factor, i32* %3, align 4
  %4 = call i32 @get_global_id(i32 0)
  %5 = call i32 @get_global_id(i32 1)
  %6 = call i32 @get_global_size(i32 0)
  %7 = mul i32 %5, %6
  %8 = add i32 %4, %7
  store i32 %8, i32* %pos, align 4
  %9 = load i32* %pos, align 4
  %10 = load <4 x i8> addrspace(1)** %1, align 4
  %11 = getelementptr inbounds <4 x i8> addrspace(1)* %10, i32 %9
  %12 = load <4 x i8> addrspace(1)* %11, align 4
  %13 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %12)
  store <4 x float> %13, <4 x float>* %temp, align 16
  %14 = load <4 x float>* %temp, align 16
  %15 = extractelement <4 x float> %14, i32 0
  %16 = load <4 x float>* %temp, align 16
  %17 = extractelement <4 x float> %16, i32 1
  %18 = fadd float %15, %17
  %19 = load <4 x float>* %temp, align 16
  %20 = extractelement <4 x float> %19, i32 2
  %21 = fadd float %18, %20
  %22 = load <4 x float>* %temp, align 16
  %23 = extractelement <4 x float> %22, i32 1
  %24 = fadd float %21, %23
  %25 = fdiv float %24, 4.000000e+00, !fpmath !2
  store float %25, float* %avg, align 4
  %26 = load float* %avg, align 4
  %27 = fsub float -0.000000e+00, %26
  %28 = fptosi float %27 to i32
  %29 = call float @ran1(i32 %28, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  store float %29, float* %dev, align 4
  %30 = load float* %dev, align 4
  %31 = fsub float %30, 5.000000e-01
  %32 = load i32* %3, align 4
  %33 = sitofp i32 %32 to float
  %34 = fmul float %31, %33
  store float %34, float* %dev, align 4
  %35 = load <4 x float>* %temp, align 16
  %36 = load float* %dev, align 4
  %37 = insertelement <4 x float> undef, float %36, i32 0
  %38 = shufflevector <4 x float> %37, <4 x float> undef, <4 x i32> zeroinitializer
  %39 = fadd <4 x float> %35, %38
  %40 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %39)
  %41 = load i32* %pos, align 4
  %42 = load <4 x i8> addrspace(1)** %2, align 4
  %43 = getelementptr inbounds <4 x i8> addrspace(1)* %42, i32 %41
  store <4 x i8> %40, <4 x i8> addrspace(1)* %43, align 4
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @noise_uniform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

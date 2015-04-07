; ModuleID = '../kernel-src/URNG_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@noise_uniform.iv = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

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
  %3 = call i32 @llvm.r600.read.tidig.x()
  %4 = call i32 @llvm.r600.read.tidig.y()
  %5 = call i32 @llvm.r600.read.local.size.x()
  %6 = mul i32 %4, %5
  %7 = add i32 %3, %6
  store i32 %7, i32* %tid, align 4
  store i32 16, i32* %j, align 4
  br label %8

; <label>:8                                       ; preds = %39, %0
  %9 = load i32* %j, align 4
  %10 = icmp sge i32 %9, 0
  br i1 %10, label %11, label %42

; <label>:11                                      ; preds = %8
  %12 = load i32* %1, align 4
  %13 = sdiv i32 %12, 127773
  store i32 %13, i32* %k, align 4
  %14 = load i32* %1, align 4
  %15 = load i32* %k, align 4
  %16 = mul nsw i32 %15, 127773
  %17 = sub nsw i32 %14, %16
  %18 = mul nsw i32 16807, %17
  %19 = load i32* %k, align 4
  %20 = mul nsw i32 2836, %19
  %21 = sub nsw i32 %18, %20
  store i32 %21, i32* %1, align 4
  %22 = load i32* %1, align 4
  %23 = icmp slt i32 %22, 0
  br i1 %23, label %24, label %27

; <label>:24                                      ; preds = %11
  %25 = load i32* %1, align 4
  %26 = add nsw i32 %25, 2147483647
  store i32 %26, i32* %1, align 4
  br label %27

; <label>:27                                      ; preds = %24, %11
  %28 = load i32* %j, align 4
  %29 = icmp slt i32 %28, 16
  br i1 %29, label %30, label %38

; <label>:30                                      ; preds = %27
  %31 = load i32* %1, align 4
  %32 = load i32* %tid, align 4
  %33 = mul nsw i32 16, %32
  %34 = load i32* %j, align 4
  %35 = add nsw i32 %33, %34
  %36 = load i32 addrspace(3)** %2, align 4
  %37 = getelementptr inbounds i32 addrspace(3)* %36, i32 %35
  store i32 %31, i32 addrspace(3)* %37, align 4
  br label %38

; <label>:38                                      ; preds = %30, %27
  br label %39

; <label>:39                                      ; preds = %38
  %40 = load i32* %j, align 4
  %41 = add nsw i32 %40, -1
  store i32 %41, i32* %j, align 4
  br label %8

; <label>:42                                      ; preds = %8
  %43 = load i32* %tid, align 4
  %44 = mul nsw i32 16, %43
  %45 = load i32 addrspace(3)** %2, align 4
  %46 = getelementptr inbounds i32 addrspace(3)* %45, i32 %44
  %47 = load i32 addrspace(3)* %46, align 4
  store i32 %47, i32* %iy, align 4
  %48 = load i32* %1, align 4
  %49 = sdiv i32 %48, 127773
  store i32 %49, i32* %k, align 4
  %50 = load i32* %1, align 4
  %51 = load i32* %k, align 4
  %52 = mul nsw i32 %51, 127773
  %53 = sub nsw i32 %50, %52
  %54 = mul nsw i32 16807, %53
  %55 = load i32* %k, align 4
  %56 = mul nsw i32 2836, %55
  %57 = sub nsw i32 %54, %56
  store i32 %57, i32* %1, align 4
  %58 = load i32* %1, align 4
  %59 = icmp slt i32 %58, 0
  br i1 %59, label %60, label %63

; <label>:60                                      ; preds = %42
  %61 = load i32* %1, align 4
  %62 = add nsw i32 %61, 2147483647
  store i32 %62, i32* %1, align 4
  br label %63

; <label>:63                                      ; preds = %60, %42
  %64 = load i32* %iy, align 4
  %65 = sdiv i32 %64, 134217728
  store i32 %65, i32* %j, align 4
  %66 = load i32* %tid, align 4
  %67 = mul nsw i32 16, %66
  %68 = load i32* %j, align 4
  %69 = add nsw i32 %67, %68
  %70 = load i32 addrspace(3)** %2, align 4
  %71 = getelementptr inbounds i32 addrspace(3)* %70, i32 %69
  %72 = load i32 addrspace(3)* %71, align 4
  store i32 %72, i32* %iy, align 4
  %73 = load i32* %iy, align 4
  %74 = sitofp i32 %73 to float
  %75 = fmul float 0x3E00000000000000, %74
  ret float %75
}

declare i32 @llvm.r600.read.tidig.x() #1
declare i32 @llvm.r600.read.tidig.y() #1
declare i32 @llvm.r600.read.tidig.z() #1

declare i32 @llvm.r600.read.local.size.x() #1
declare i32 @llvm.r600.read.local.size.y() #1
declare i32 @llvm.r600.read.local.size.z() #1

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
  %4 = call i32 @llvm.r600.read.tgid.x()
  %5 = call i32 @llvm.r600.read.tgid.y()
  %6 = call i32 @llvm.r600.read.global.size.x()
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
  %29 = call float @ran1(i32 %28, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  store float %29, float* %dev, align 4
  %30 = load float* %dev, align 4
  %31 = fsub float %30, 0x3FE19999A0000000
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

declare i32 @llvm.r600.read.tgid.x() #1
declare i32 @llvm.r600.read.tgid.y() #1
declare i32 @llvm.r600.read.tgid.z() #1

declare i32 @llvm.r600.read.global.size.x() #1
declare i32 @llvm.r600.read.global.size.y() #1
declare i32 @llvm.r600.read.global.size.z() #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @noise_uniform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

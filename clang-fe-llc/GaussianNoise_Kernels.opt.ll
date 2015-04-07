; ModuleID = 'GaussianNoise_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@gaussian_transform.iv0 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
  %1 = call i32 @llvm.r600.read.tidig.x()
  br label %2

; <label>:2                                       ; preds = %21, %0
  %j.0 = phi i32 [ 4, %0 ], [ %22, %21 ]
  %.0 = phi i32 [ %idum, %0 ], [ %.1, %21 ]
  %3 = icmp sge i32 %j.0, 0
  br i1 %3, label %4, label %23

; <label>:4                                       ; preds = %2
  %5 = sdiv i32 %.0, 127773
  %6 = mul nsw i32 %5, 127773
  %7 = sub nsw i32 %.0, %6
  %8 = mul nsw i32 16807, %7
  %9 = mul nsw i32 2836, %5
  %10 = sub nsw i32 %8, %9
  %11 = icmp slt i32 %10, 0
  br i1 %11, label %12, label %14

; <label>:12                                      ; preds = %4
  %13 = add nsw i32 %10, 2147483647
  br label %14

; <label>:14                                      ; preds = %12, %4
  %.1 = phi i32 [ %13, %12 ], [ %10, %4 ]
  %15 = icmp slt i32 %j.0, 4
  br i1 %15, label %16, label %20

; <label>:16                                      ; preds = %14
  %17 = mul nsw i32 4, %1
  %18 = add nsw i32 %17, %j.0
  %19 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %18
  store i32 %.1, i32 addrspace(3)* %19, align 4
  br label %20

; <label>:20                                      ; preds = %16, %14
  br label %21

; <label>:21                                      ; preds = %20
  %22 = add nsw i32 %j.0, -1
  br label %2

; <label>:23                                      ; preds = %2
  %24 = getelementptr inbounds i32 addrspace(3)* %iv, i32 0
  %25 = load i32 addrspace(3)* %24, align 4
  %26 = sdiv i32 %.0, 127773
  %27 = mul nsw i32 %26, 127773
  %28 = sub nsw i32 %.0, %27
  %29 = mul nsw i32 16807, %28
  %30 = mul nsw i32 2836, %26
  %31 = sub nsw i32 %29, %30
  %32 = icmp slt i32 %31, 0
  br i1 %32, label %33, label %35

; <label>:33                                      ; preds = %23
  %34 = add nsw i32 %31, 2147483647
  br label %35

; <label>:35                                      ; preds = %33, %23
  %36 = sdiv i32 %25, 536870912
  %37 = mul nsw i32 4, %1
  %38 = add nsw i32 %37, %36
  %39 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %38
  %40 = load i32 addrspace(3)* %39, align 4
  %41 = sitofp i32 %40 to float
  %42 = fmul float 0x3E00000000000000, %41
  ret float %42
}

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.z() #1

; Function Attrs: nounwind
define <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
  %1 = extractelement <2 x float> %uniform, i32 0
  %2 = call float @llvm.log2.f32(float %1)
  %3 = fmul float %2, 0x3FE62E4300000000
  %4 = fmul float -2.000000e+00, %3
  %5 = call float @llvm.sqrt.f32(float %4)
  %6 = extractelement <2 x float> %uniform, i32 1
  %7 = fmul float 0x40191EB860000000, %6
  %8 = call float @_Z3sinf(float %7)
  %9 = fmul float %5, %8
  %10 = insertelement <2 x float> undef, float %9, i32 0
  %11 = call float @_Z3cosf(float %7)
  %12 = fmul float %5, %11
  %13 = insertelement <2 x float> %10, float %12, i32 1
  ret <2 x float> %13
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #2

declare float @_Z3sinf(float) #3

declare float @_Z3cosf(float) #3

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = call i32 @llvm.r600.read.global.size.x()
  %3 = mul i32 2, %2
  %4 = call i32 @llvm.r600.read.tgid.y()
  %5 = mul i32 %3, %4
  %6 = add i32 %1, %5
  %7 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %6
  %8 = load <4 x i8> addrspace(1)* %7, align 4
  %9 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %8)
  %10 = call i32 @llvm.r600.read.global.size.x()
  %11 = add i32 %6, %10
  %12 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %11
  %13 = load <4 x i8> addrspace(1)* %12, align 4
  %14 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %13)
  %15 = extractelement <4 x float> %9, i32 0
  %16 = extractelement <4 x float> %9, i32 1
  %17 = fadd float %15, %16
  %18 = extractelement <4 x float> %9, i32 2
  %19 = fadd float %17, %18
  %20 = extractelement <4 x float> %9, i32 3
  %21 = fadd float %19, %20
  %22 = fdiv float %21, 4.000000e+00, !fpmath !2
  %23 = extractelement <4 x float> %14, i32 0
  %24 = extractelement <4 x float> %14, i32 1
  %25 = fadd float %23, %24
  %26 = extractelement <4 x float> %14, i32 2
  %27 = fadd float %25, %26
  %28 = extractelement <4 x float> %14, i32 3
  %29 = fadd float %27, %28
  %30 = fdiv float %29, 4.000000e+00, !fpmath !2
  %31 = fsub float -0.000000e+00, %22
  %32 = fptosi float %31 to i32
  %33 = call float @ran1(i32 %32, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  %34 = fsub float -0.000000e+00, %30
  %35 = fptosi float %34 to i32
  %36 = call float @ran1(i32 %35, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  %37 = insertelement <2 x float> undef, float %33, i32 0
  %38 = insertelement <2 x float> %37, float %36, i32 1
  %39 = call <2 x float> @BoxMuller(<2 x float> %38)
  %40 = extractelement <2 x float> %39, i32 0
  %41 = sitofp i32 %factor to float
  %42 = fmul float %40, %41
  %43 = insertelement <4 x float> undef, float %42, i32 0
  %44 = shufflevector <4 x float> %43, <4 x float> undef, <4 x i32> zeroinitializer
  %45 = fadd <4 x float> %9, %44
  %46 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %45)
  %47 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> %46, <4 x i8> addrspace(1)* %47, align 4
  %48 = extractelement <2 x float> %39, i32 1
  %49 = sitofp i32 %factor to float
  %50 = fmul float %48, %49
  %51 = insertelement <4 x float> undef, float %50, i32 0
  %52 = shufflevector <4 x float> %51, <4 x float> undef, <4 x i32> zeroinitializer
  %53 = fadd <4 x float> %14, %52
  %54 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %53)
  %55 = call i32 @llvm.r600.read.global.size.x()
  %56 = add i32 %6, %55
  %57 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %56
  store <4 x i8> %54, <4 x i8> addrspace(1)* %57, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.z() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.global.size.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.global.size.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.global.size.z() #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #3

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #3

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind readonly }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @gaussian_transform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

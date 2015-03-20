; ModuleID = '../kernel-src/GaussianNoise_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

@gaussian_transform.iv0 = internal addrspace(3) global [1024 x i32] undef, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [1024 x i32] undef, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* nocapture %iv) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #3
  %2 = shl i32 %1, 2
  %3 = sdiv i32 %idum, 127773
  %4 = mul i32 %3, -127773
  %5 = add i32 %4, %idum
  %6 = mul nsw i32 %5, 16807
  %7 = mul i32 %3, -2836
  %8 = add i32 %6, %7
  %9 = icmp slt i32 %8, 0
  %10 = add nsw i32 %8, 2147483647
  %. = select i1 %9, i32 %10, i32 %8
  %11 = sdiv i32 %., 127773
  %12 = mul i32 %11, -127773
  %13 = add i32 %., %12
  %14 = mul nsw i32 %13, 16807
  %15 = mul i32 %11, -2836
  %16 = add i32 %14, %15
  %17 = icmp slt i32 %16, 0
  %18 = add nsw i32 %16, 2147483647
  %..1 = select i1 %17, i32 %18, i32 %16
  %19 = or i32 %2, 3
  %20 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %19
  store i32 %..1, i32 addrspace(3)* %20, align 4, !tbaa !7
  %21 = sdiv i32 %..1, 127773
  %22 = mul i32 %21, -127773
  %23 = add i32 %..1, %22
  %24 = mul nsw i32 %23, 16807
  %25 = mul i32 %21, -2836
  %26 = add i32 %24, %25
  %27 = icmp slt i32 %26, 0
  %28 = add nsw i32 %26, 2147483647
  %..2 = select i1 %27, i32 %28, i32 %26
  %29 = or i32 %2, 2
  %30 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %29
  store i32 %..2, i32 addrspace(3)* %30, align 4, !tbaa !7
  %31 = sdiv i32 %..2, 127773
  %32 = mul i32 %31, -127773
  %33 = add i32 %..2, %32
  %34 = mul nsw i32 %33, 16807
  %35 = mul i32 %31, -2836
  %36 = add i32 %34, %35
  %37 = icmp slt i32 %36, 0
  %38 = add nsw i32 %36, 2147483647
  %..3 = select i1 %37, i32 %38, i32 %36
  %39 = or i32 %2, 1
  %40 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %39
  store i32 %..3, i32 addrspace(3)* %40, align 4, !tbaa !7
  %41 = sdiv i32 %..3, 127773
  %42 = mul i32 %41, -127773
  %43 = add i32 %..3, %42
  %44 = mul nsw i32 %43, 16807
  %45 = mul i32 %41, -2836
  %46 = add i32 %44, %45
  %47 = icmp slt i32 %46, 0
  %48 = add nsw i32 %46, 2147483647
  %..4 = select i1 %47, i32 %48, i32 %46
  %49 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %2
  store i32 %..4, i32 addrspace(3)* %49, align 4, !tbaa !7
  %50 = load i32 addrspace(3)* %iv, align 4, !tbaa !7
  %51 = sdiv i32 %50, 536870912
  %52 = add nsw i32 %51, %2
  %53 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %52
  %54 = load i32 addrspace(3)* %53, align 4, !tbaa !7
  %55 = sitofp i32 %54 to float
  %56 = fmul float %55, 0x3E00000000000000
  ret float %56
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
  %1 = extractelement <2 x float> %uniform, i32 0
  %2 = tail call float @llvm.log2.f32(float %1)
  %3 = fmul float %2, 0x3FE62E4300000000
  %4 = fmul float %3, -2.000000e+00
  %5 = tail call float @llvm.sqrt.f32(float %4)
  %6 = extractelement <2 x float> %uniform, i32 1
  %7 = fmul float %6, 0x40191EB860000000
  %8 = tail call float @_Z3sinf(float %7) #3
  %9 = fmul float %5, %8
  %10 = insertelement <2 x float> undef, float %9, i32 0
  %11 = tail call float @_Z3cosf(float %7) #3
  %12 = fmul float %5, %11
  %13 = insertelement <2 x float> %10, float %12, i32 1
  ret <2 x float> %13
}

; Function Attrs: nounwind readnone
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nounwind readnone
declare float @llvm.log2.f32(float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %factor) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_size(i32 0) #3
  %3 = shl i32 %2, 1
  %4 = tail call i32 @get_global_id(i32 1) #3
  %5 = mul i32 %3, %4
  %6 = add i32 %5, %1
  %7 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %6
  %8 = load <4 x i8> addrspace(1)* %7, align 4, !tbaa !11
  %9 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %8) #3
  %10 = tail call i32 @get_global_size(i32 0) #3
  %11 = add i32 %10, %6
  %12 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %11
  %13 = load <4 x i8> addrspace(1)* %12, align 4, !tbaa !11
  %14 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %13) #3
  %15 = extractelement <4 x float> %9, i32 0
  %16 = extractelement <4 x float> %9, i32 1
  %17 = fadd float %15, %16
  %18 = extractelement <4 x float> %9, i32 2
  %19 = fadd float %18, %17
  %20 = extractelement <4 x float> %9, i32 3
  %21 = fadd float %20, %19
  %22 = fmul float %21, 2.500000e-01
  %23 = extractelement <4 x float> %14, i32 0
  %24 = extractelement <4 x float> %14, i32 1
  %25 = fadd float %23, %24
  %26 = extractelement <4 x float> %14, i32 2
  %27 = fadd float %26, %25
  %28 = extractelement <4 x float> %14, i32 3
  %29 = fadd float %28, %27
  %30 = fmul float %29, 2.500000e-01
  %31 = fsub float -0.000000e+00, %22
  %32 = fptosi float %31 to i32
  %33 = tail call float @ran1(i32 %32, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  %34 = fsub float -0.000000e+00, %30
  %35 = fptosi float %34 to i32
  %36 = tail call float @ran1(i32 %35, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  %37 = tail call float @llvm.log2.f32(float %33) #3
  %38 = fmul float %37, 0x3FE62E4300000000
  %39 = fmul float %38, -2.000000e+00
  %40 = tail call float @llvm.sqrt.f32(float %39) #3
  %41 = fmul float %36, 0x40191EB860000000
  %42 = tail call float @_Z3sinf(float %41) #3
  %43 = fmul float %40, %42
  %44 = tail call float @_Z3cosf(float %41) #3
  %45 = fmul float %40, %44
  %46 = sitofp i32 %factor to float
  %47 = fmul float %46, %43
  %48 = insertelement <4 x float> undef, float %47, i32 0
  %49 = shufflevector <4 x float> %48, <4 x float> undef, <4 x i32> zeroinitializer
  %50 = fadd <4 x float> %9, %49
  %51 = tail call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %50) #3
  %52 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> %51, <4 x i8> addrspace(1)* %52, align 4, !tbaa !11
  %53 = fmul float %46, %45
  %54 = insertelement <4 x float> undef, float %53, i32 0
  %55 = shufflevector <4 x float> %54, <4 x float> undef, <4 x i32> zeroinitializer
  %56 = fadd <4 x float> %14, %55
  %57 = tail call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %56) #3
  %58 = tail call i32 @get_global_size(i32 0) #3
  %59 = add i32 %58, %6
  %60 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %59
  store <4 x i8> %57, <4 x i8> addrspace(1)* %60, align 4, !tbaa !11
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @gaussian_transform, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uchar4*", !"uchar4*", !"int"}
!4 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar __attribute__((ext_vector_type(4)))*", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{!9, !9, i64 0}

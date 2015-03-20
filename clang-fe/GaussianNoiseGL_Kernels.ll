; ModuleID = '../kernel-src/GaussianNoiseGL_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

%opencl.image2d_t = type opaque

@gaussian_transform.iv0 = internal addrspace(3) global [256 x i32] undef, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [256 x i32] undef, align 4

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* nocapture readonly %inputImage, %opencl.image2d_t addrspace(1)* %outputImage, i32 %factor) #0 {
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
  %15 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %6
  %16 = load <4 x i8> addrspace(1)* %15, align 4, !tbaa !7
  %17 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %16) #2
  %18 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %14
  %19 = load <4 x i8> addrspace(1)* %18, align 4, !tbaa !7
  %20 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %19) #2
  %21 = extractelement <4 x float> %17, i32 0
  %22 = extractelement <4 x float> %17, i32 1
  %23 = fadd float %21, %22
  %24 = extractelement <4 x float> %17, i32 2
  %25 = fadd float %24, %23
  %26 = extractelement <4 x float> %17, i32 3
  %27 = fadd float %26, %25
  %28 = fmul float %27, 2.500000e-01
  %29 = extractelement <4 x float> %20, i32 0
  %30 = extractelement <4 x float> %20, i32 1
  %31 = fadd float %29, %30
  %32 = extractelement <4 x float> %20, i32 2
  %33 = fadd float %32, %31
  %34 = extractelement <4 x float> %20, i32 3
  %35 = fadd float %34, %33
  %36 = fmul float %35, 2.500000e-01
  %37 = fsub float -0.000000e+00, %28
  %38 = fptosi float %37 to i32
  %39 = tail call float @ran1(i32 %38, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0)) #2
  %40 = fsub float -0.000000e+00, %36
  %41 = fptosi float %40 to i32
  %42 = tail call float @ran1(i32 %41, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0)) #2
  %43 = insertelement <2 x float> undef, float %39, i32 0
  %44 = insertelement <2 x float> %43, float %42, i32 1
  %45 = tail call <2 x float> @BoxMuller(<2 x float> %44) #2
  %46 = extractelement <2 x float> %45, i32 0
  %47 = sitofp i32 %factor to float
  %48 = fmul float %47, %46
  %49 = insertelement <4 x float> undef, float %48, i32 0
  %50 = shufflevector <4 x float> %49, <4 x float> undef, <4 x i32> zeroinitializer
  %51 = fadd <4 x float> %17, %50
  %52 = fdiv <4 x float> %51, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !10
  %53 = extractelement <2 x float> %45, i32 1
  %54 = fmul float %47, %53
  %55 = insertelement <4 x float> undef, float %54, i32 0
  %56 = shufflevector <4 x float> %55, <4 x float> undef, <4 x i32> zeroinitializer
  %57 = fadd <4 x float> %20, %56
  %58 = fdiv <4 x float> %57, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !10
  %59 = tail call i32 @get_global_id(i32 0) #2
  %60 = insertelement <2 x i32> undef, i32 %59, i32 0
  %61 = tail call i32 @get_global_id(i32 1) #2
  %62 = insertelement <2 x i32> %60, i32 %61, i32 1
  %63 = tail call i32 @get_global_id(i32 0) #2
  %64 = tail call i32 @get_global_size(i32 0) #2
  %65 = add i32 %64, %63
  %66 = insertelement <2 x i32> undef, i32 %65, i32 0
  %67 = tail call i32 @get_global_id(i32 1) #2
  %68 = insertelement <2 x i32> %66, i32 %67, i32 1
  %69 = tail call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t addrspace(1)* %outputImage, <2 x i32> %62, <4 x float> %52) #2
  %70 = tail call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t addrspace(1)* %outputImage, <2 x i32> %68, <4 x float> %58) #2
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
!llvm.ident = !{!6}

!0 = !{void (<4 x i8> addrspace(1)*, %opencl.image2d_t addrspace(1)*, i32)* @gaussian_transform, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"write_only", !"none"}
!3 = !{!"kernel_arg_type", !"uchar4*", !"image2d_t", !"int"}
!4 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"image2d_t", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{float 2.500000e+00}

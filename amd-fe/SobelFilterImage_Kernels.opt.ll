; ModuleID = 'SobelFilterImage_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

@imageSampler = addrspace(2) constant i32 36, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_sobel_filter_kernel(%opencl.image2d_t addrspace(1)* %inputImage, %opencl.image2d_t addrspace(1)* %outputImage) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %vecinit = insertelement <2 x i32> undef, i32 %conv, i32 0
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %vecinit3 = insertelement <2 x i32> %vecinit, i32 %conv2, i32 1
  %0 = load i32 addrspace(2)* @imageSampler, align 4
  %1 = extractelement <2 x i32> %vecinit3, i32 0
  %sub = sub nsw i32 %1, 1
  %vecinit5 = insertelement <2 x i32> undef, i32 %sub, i32 0
  %2 = extractelement <2 x i32> %vecinit3, i32 1
  %add = add nsw i32 %2, 1
  %vecinit6 = insertelement <2 x i32> %vecinit5, i32 %add, i32 1
  %call7 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %inputImage, i32 %0, <2 x i32> %vecinit6) #1
  %call8 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call7) #1
  %3 = load i32 addrspace(2)* @imageSampler, align 4
  %4 = extractelement <2 x i32> %vecinit3, i32 0
  %sub10 = sub nsw i32 %4, 0
  %vecinit11 = insertelement <2 x i32> undef, i32 %sub10, i32 0
  %5 = extractelement <2 x i32> %vecinit3, i32 1
  %add12 = add nsw i32 %5, 1
  %vecinit13 = insertelement <2 x i32> %vecinit11, i32 %add12, i32 1
  %call14 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %inputImage, i32 %3, <2 x i32> %vecinit13) #1
  %call15 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call14) #1
  %6 = load i32 addrspace(2)* @imageSampler, align 4
  %7 = extractelement <2 x i32> %vecinit3, i32 0
  %add17 = add nsw i32 %7, 1
  %vecinit18 = insertelement <2 x i32> undef, i32 %add17, i32 0
  %8 = extractelement <2 x i32> %vecinit3, i32 1
  %add19 = add nsw i32 %8, 1
  %vecinit20 = insertelement <2 x i32> %vecinit18, i32 %add19, i32 1
  %call21 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %inputImage, i32 %6, <2 x i32> %vecinit20) #1
  %call22 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call21) #1
  %9 = load i32 addrspace(2)* @imageSampler, align 4
  %10 = extractelement <2 x i32> %vecinit3, i32 0
  %sub24 = sub nsw i32 %10, 1
  %vecinit25 = insertelement <2 x i32> undef, i32 %sub24, i32 0
  %11 = extractelement <2 x i32> %vecinit3, i32 1
  %add26 = add nsw i32 %11, 0
  %vecinit27 = insertelement <2 x i32> %vecinit25, i32 %add26, i32 1
  %call28 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %inputImage, i32 %9, <2 x i32> %vecinit27) #1
  %call29 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call28) #1
  %12 = load i32 addrspace(2)* @imageSampler, align 4
  %13 = extractelement <2 x i32> %vecinit3, i32 0
  %sub31 = sub nsw i32 %13, 0
  %vecinit32 = insertelement <2 x i32> undef, i32 %sub31, i32 0
  %14 = extractelement <2 x i32> %vecinit3, i32 1
  %add33 = add nsw i32 %14, 0
  %vecinit34 = insertelement <2 x i32> %vecinit32, i32 %add33, i32 1
  %call35 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %inputImage, i32 %12, <2 x i32> %vecinit34) #1
  %call36 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call35) #1
  %15 = load i32 addrspace(2)* @imageSampler, align 4
  %16 = extractelement <2 x i32> %vecinit3, i32 0
  %add38 = add nsw i32 %16, 1
  %vecinit39 = insertelement <2 x i32> undef, i32 %add38, i32 0
  %17 = extractelement <2 x i32> %vecinit3, i32 1
  %add40 = add nsw i32 %17, 0
  %vecinit41 = insertelement <2 x i32> %vecinit39, i32 %add40, i32 1
  %call42 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %inputImage, i32 %15, <2 x i32> %vecinit41) #1
  %call43 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call42) #1
  %18 = load i32 addrspace(2)* @imageSampler, align 4
  %19 = extractelement <2 x i32> %vecinit3, i32 0
  %sub45 = sub nsw i32 %19, 1
  %vecinit46 = insertelement <2 x i32> undef, i32 %sub45, i32 0
  %20 = extractelement <2 x i32> %vecinit3, i32 1
  %sub47 = sub nsw i32 %20, 1
  %vecinit48 = insertelement <2 x i32> %vecinit46, i32 %sub47, i32 1
  %call49 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %inputImage, i32 %18, <2 x i32> %vecinit48) #1
  %call50 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call49) #1
  %21 = load i32 addrspace(2)* @imageSampler, align 4
  %22 = extractelement <2 x i32> %vecinit3, i32 0
  %sub52 = sub nsw i32 %22, 0
  %vecinit53 = insertelement <2 x i32> undef, i32 %sub52, i32 0
  %23 = extractelement <2 x i32> %vecinit3, i32 1
  %sub54 = sub nsw i32 %23, 1
  %vecinit55 = insertelement <2 x i32> %vecinit53, i32 %sub54, i32 1
  %call56 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %inputImage, i32 %21, <2 x i32> %vecinit55) #1
  %call57 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call56) #1
  %24 = load i32 addrspace(2)* @imageSampler, align 4
  %25 = extractelement <2 x i32> %vecinit3, i32 0
  %add59 = add nsw i32 %25, 1
  %vecinit60 = insertelement <2 x i32> undef, i32 %add59, i32 0
  %26 = extractelement <2 x i32> %vecinit3, i32 1
  %sub61 = sub nsw i32 %26, 1
  %vecinit62 = insertelement <2 x i32> %vecinit60, i32 %sub61, i32 1
  %call63 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %inputImage, i32 %24, <2 x i32> %vecinit62) #1
  %call64 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call63) #1
  %27 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %call15, <4 x float> %call8)
  %add65 = fadd <4 x float> %27, %call22
  %sub66 = fsub <4 x float> %add65, %call50
  %mul = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %call57
  %sub67 = fsub <4 x float> %sub66, %mul
  %sub68 = fsub <4 x float> %sub67, %call64
  %sub69 = fsub <4 x float> %call8, %call22
  %mul70 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %call29
  %add71 = fadd <4 x float> %sub69, %mul70
  %mul72 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %call43
  %sub73 = fsub <4 x float> %add71, %mul72
  %add74 = fadd <4 x float> %sub73, %call50
  %sub75 = fsub <4 x float> %add74, %call64
  %mul77 = fmul <4 x float> %sub75, %sub75
  %28 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %sub68, <4 x float> %sub68, <4 x float> %mul77)
  %call78 = call cc75 <4 x float> @_Z11native_sqrtDv4_f(<4 x float> %28) #1
  %call79 = call cc75 <4 x float> @_Z13native_divideDv4_fS_(<4 x float> %call78, <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>) #1
  %call80 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_f(<4 x float> %call79) #1
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %outputImage, <2 x i32> %vecinit3, <4 x i32> %call80)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)*, i32, <2 x i32>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z13native_divideDv4_fS_(<4 x float>, <4 x float>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z11native_sqrtDv4_f(<4 x float>) #1

declare cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x i32>)

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z13convert_uint4Dv4_f(<4 x float>) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (%opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*)* @__OpenCL_sobel_filter_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"read_only", metadata !"write_only"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"image2d_t", metadata !"image2d_t"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"image2d_t", metadata !"image2d_t"}
!6 = metadata !{i32 1, i32 2}

; ModuleID = 'SobelFilterImage_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

@imageSampler = addrspace(2) constant i32 36, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_sobel_filter_kernel(%opencl.image2d_t addrspace(1)* %inputImage, %opencl.image2d_t addrspace(1)* %outputImage) #0 {
entry:
  %inputImage.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %outputImage.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %coord = alloca <2 x i32>, align 8
  %.compoundliteral = alloca <2 x i32>, align 8
  %Gx = alloca <4 x float>, align 16
  %Gy = alloca <4 x float>, align 16
  %i00 = alloca <4 x float>, align 16
  %.compoundliteral4 = alloca <2 x i32>, align 8
  %i10 = alloca <4 x float>, align 16
  %.compoundliteral9 = alloca <2 x i32>, align 8
  %i20 = alloca <4 x float>, align 16
  %.compoundliteral16 = alloca <2 x i32>, align 8
  %i01 = alloca <4 x float>, align 16
  %.compoundliteral23 = alloca <2 x i32>, align 8
  %i11 = alloca <4 x float>, align 16
  %.compoundliteral30 = alloca <2 x i32>, align 8
  %i21 = alloca <4 x float>, align 16
  %.compoundliteral37 = alloca <2 x i32>, align 8
  %i02 = alloca <4 x float>, align 16
  %.compoundliteral44 = alloca <2 x i32>, align 8
  %i12 = alloca <4 x float>, align 16
  %.compoundliteral51 = alloca <2 x i32>, align 8
  %i22 = alloca <4 x float>, align 16
  %.compoundliteral58 = alloca <2 x i32>, align 8
  store %opencl.image2d_t addrspace(1)* %inputImage, %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  store %opencl.image2d_t addrspace(1)* %outputImage, %opencl.image2d_t addrspace(1)** %outputImage.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %vecinit = insertelement <2 x i32> undef, i32 %conv, i32 0
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %vecinit3 = insertelement <2 x i32> %vecinit, i32 %conv2, i32 1
  store <2 x i32> %vecinit3, <2 x i32>* %.compoundliteral
  %0 = load <2 x i32>* %.compoundliteral
  store <2 x i32> %0, <2 x i32>* %coord, align 8
  store <4 x float> zeroinitializer, <4 x float>* %Gx, align 16
  %1 = load <4 x float>* %Gx, align 16
  store <4 x float> %1, <4 x float>* %Gy, align 16
  %2 = load %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  %3 = load i32 addrspace(2)* @imageSampler, align 4
  %4 = load <2 x i32>* %coord, align 8
  %5 = extractelement <2 x i32> %4, i32 0
  %sub = sub nsw i32 %5, 1
  %vecinit5 = insertelement <2 x i32> undef, i32 %sub, i32 0
  %6 = load <2 x i32>* %coord, align 8
  %7 = extractelement <2 x i32> %6, i32 1
  %add = add nsw i32 %7, 1
  %vecinit6 = insertelement <2 x i32> %vecinit5, i32 %add, i32 1
  store <2 x i32> %vecinit6, <2 x i32>* %.compoundliteral4
  %8 = load <2 x i32>* %.compoundliteral4
  %call7 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %2, i32 %3, <2 x i32> %8) #1
  %call8 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call7) #1
  store <4 x float> %call8, <4 x float>* %i00, align 16
  %9 = load %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  %10 = load i32 addrspace(2)* @imageSampler, align 4
  %11 = load <2 x i32>* %coord, align 8
  %12 = extractelement <2 x i32> %11, i32 0
  %sub10 = sub nsw i32 %12, 0
  %vecinit11 = insertelement <2 x i32> undef, i32 %sub10, i32 0
  %13 = load <2 x i32>* %coord, align 8
  %14 = extractelement <2 x i32> %13, i32 1
  %add12 = add nsw i32 %14, 1
  %vecinit13 = insertelement <2 x i32> %vecinit11, i32 %add12, i32 1
  store <2 x i32> %vecinit13, <2 x i32>* %.compoundliteral9
  %15 = load <2 x i32>* %.compoundliteral9
  %call14 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %9, i32 %10, <2 x i32> %15) #1
  %call15 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call14) #1
  store <4 x float> %call15, <4 x float>* %i10, align 16
  %16 = load %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  %17 = load i32 addrspace(2)* @imageSampler, align 4
  %18 = load <2 x i32>* %coord, align 8
  %19 = extractelement <2 x i32> %18, i32 0
  %add17 = add nsw i32 %19, 1
  %vecinit18 = insertelement <2 x i32> undef, i32 %add17, i32 0
  %20 = load <2 x i32>* %coord, align 8
  %21 = extractelement <2 x i32> %20, i32 1
  %add19 = add nsw i32 %21, 1
  %vecinit20 = insertelement <2 x i32> %vecinit18, i32 %add19, i32 1
  store <2 x i32> %vecinit20, <2 x i32>* %.compoundliteral16
  %22 = load <2 x i32>* %.compoundliteral16
  %call21 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %16, i32 %17, <2 x i32> %22) #1
  %call22 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call21) #1
  store <4 x float> %call22, <4 x float>* %i20, align 16
  %23 = load %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  %24 = load i32 addrspace(2)* @imageSampler, align 4
  %25 = load <2 x i32>* %coord, align 8
  %26 = extractelement <2 x i32> %25, i32 0
  %sub24 = sub nsw i32 %26, 1
  %vecinit25 = insertelement <2 x i32> undef, i32 %sub24, i32 0
  %27 = load <2 x i32>* %coord, align 8
  %28 = extractelement <2 x i32> %27, i32 1
  %add26 = add nsw i32 %28, 0
  %vecinit27 = insertelement <2 x i32> %vecinit25, i32 %add26, i32 1
  store <2 x i32> %vecinit27, <2 x i32>* %.compoundliteral23
  %29 = load <2 x i32>* %.compoundliteral23
  %call28 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %23, i32 %24, <2 x i32> %29) #1
  %call29 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call28) #1
  store <4 x float> %call29, <4 x float>* %i01, align 16
  %30 = load %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  %31 = load i32 addrspace(2)* @imageSampler, align 4
  %32 = load <2 x i32>* %coord, align 8
  %33 = extractelement <2 x i32> %32, i32 0
  %sub31 = sub nsw i32 %33, 0
  %vecinit32 = insertelement <2 x i32> undef, i32 %sub31, i32 0
  %34 = load <2 x i32>* %coord, align 8
  %35 = extractelement <2 x i32> %34, i32 1
  %add33 = add nsw i32 %35, 0
  %vecinit34 = insertelement <2 x i32> %vecinit32, i32 %add33, i32 1
  store <2 x i32> %vecinit34, <2 x i32>* %.compoundliteral30
  %36 = load <2 x i32>* %.compoundliteral30
  %call35 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %30, i32 %31, <2 x i32> %36) #1
  %call36 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call35) #1
  store <4 x float> %call36, <4 x float>* %i11, align 16
  %37 = load %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  %38 = load i32 addrspace(2)* @imageSampler, align 4
  %39 = load <2 x i32>* %coord, align 8
  %40 = extractelement <2 x i32> %39, i32 0
  %add38 = add nsw i32 %40, 1
  %vecinit39 = insertelement <2 x i32> undef, i32 %add38, i32 0
  %41 = load <2 x i32>* %coord, align 8
  %42 = extractelement <2 x i32> %41, i32 1
  %add40 = add nsw i32 %42, 0
  %vecinit41 = insertelement <2 x i32> %vecinit39, i32 %add40, i32 1
  store <2 x i32> %vecinit41, <2 x i32>* %.compoundliteral37
  %43 = load <2 x i32>* %.compoundliteral37
  %call42 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %37, i32 %38, <2 x i32> %43) #1
  %call43 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call42) #1
  store <4 x float> %call43, <4 x float>* %i21, align 16
  %44 = load %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  %45 = load i32 addrspace(2)* @imageSampler, align 4
  %46 = load <2 x i32>* %coord, align 8
  %47 = extractelement <2 x i32> %46, i32 0
  %sub45 = sub nsw i32 %47, 1
  %vecinit46 = insertelement <2 x i32> undef, i32 %sub45, i32 0
  %48 = load <2 x i32>* %coord, align 8
  %49 = extractelement <2 x i32> %48, i32 1
  %sub47 = sub nsw i32 %49, 1
  %vecinit48 = insertelement <2 x i32> %vecinit46, i32 %sub47, i32 1
  store <2 x i32> %vecinit48, <2 x i32>* %.compoundliteral44
  %50 = load <2 x i32>* %.compoundliteral44
  %call49 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %44, i32 %45, <2 x i32> %50) #1
  %call50 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call49) #1
  store <4 x float> %call50, <4 x float>* %i02, align 16
  %51 = load %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  %52 = load i32 addrspace(2)* @imageSampler, align 4
  %53 = load <2 x i32>* %coord, align 8
  %54 = extractelement <2 x i32> %53, i32 0
  %sub52 = sub nsw i32 %54, 0
  %vecinit53 = insertelement <2 x i32> undef, i32 %sub52, i32 0
  %55 = load <2 x i32>* %coord, align 8
  %56 = extractelement <2 x i32> %55, i32 1
  %sub54 = sub nsw i32 %56, 1
  %vecinit55 = insertelement <2 x i32> %vecinit53, i32 %sub54, i32 1
  store <2 x i32> %vecinit55, <2 x i32>* %.compoundliteral51
  %57 = load <2 x i32>* %.compoundliteral51
  %call56 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %51, i32 %52, <2 x i32> %57) #1
  %call57 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call56) #1
  store <4 x float> %call57, <4 x float>* %i12, align 16
  %58 = load %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  %59 = load i32 addrspace(2)* @imageSampler, align 4
  %60 = load <2 x i32>* %coord, align 8
  %61 = extractelement <2 x i32> %60, i32 0
  %add59 = add nsw i32 %61, 1
  %vecinit60 = insertelement <2 x i32> undef, i32 %add59, i32 0
  %62 = load <2 x i32>* %coord, align 8
  %63 = extractelement <2 x i32> %62, i32 1
  %sub61 = sub nsw i32 %63, 1
  %vecinit62 = insertelement <2 x i32> %vecinit60, i32 %sub61, i32 1
  store <2 x i32> %vecinit62, <2 x i32>* %.compoundliteral58
  %64 = load <2 x i32>* %.compoundliteral58
  %call63 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %58, i32 %59, <2 x i32> %64) #1
  %call64 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call63) #1
  store <4 x float> %call64, <4 x float>* %i22, align 16
  %65 = load <4 x float>* %i00, align 16
  %66 = load <4 x float>* %i10, align 16
  %67 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %66, <4 x float> %65)
  %68 = load <4 x float>* %i20, align 16
  %add65 = fadd <4 x float> %67, %68
  %69 = load <4 x float>* %i02, align 16
  %sub66 = fsub <4 x float> %add65, %69
  %70 = load <4 x float>* %i12, align 16
  %mul = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %70
  %sub67 = fsub <4 x float> %sub66, %mul
  %71 = load <4 x float>* %i22, align 16
  %sub68 = fsub <4 x float> %sub67, %71
  store <4 x float> %sub68, <4 x float>* %Gx, align 16
  %72 = load <4 x float>* %i00, align 16
  %73 = load <4 x float>* %i20, align 16
  %sub69 = fsub <4 x float> %72, %73
  %74 = load <4 x float>* %i01, align 16
  %mul70 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %74
  %add71 = fadd <4 x float> %sub69, %mul70
  %75 = load <4 x float>* %i21, align 16
  %mul72 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %75
  %sub73 = fsub <4 x float> %add71, %mul72
  %76 = load <4 x float>* %i02, align 16
  %add74 = fadd <4 x float> %sub73, %76
  %77 = load <4 x float>* %i22, align 16
  %sub75 = fsub <4 x float> %add74, %77
  store <4 x float> %sub75, <4 x float>* %Gy, align 16
  %78 = load <4 x float>* %Gx, align 16
  %79 = load <4 x float>* %Gx, align 16
  %80 = load <4 x float>* %Gy, align 16
  %81 = load <4 x float>* %Gy, align 16
  %mul77 = fmul <4 x float> %80, %81
  %82 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %78, <4 x float> %79, <4 x float> %mul77)
  %call78 = call cc75 <4 x float> @_Z11native_sqrtDv4_f(<4 x float> %82) #1
  %call79 = call cc75 <4 x float> @_Z13native_divideDv4_fS_(<4 x float> %call78, <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>) #1
  store <4 x float> %call79, <4 x float>* %Gx, align 16
  %83 = load %opencl.image2d_t addrspace(1)** %outputImage.addr, align 8
  %84 = load <2 x i32>* %coord, align 8
  %85 = load <4 x float>* %Gx, align 16
  %call80 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_f(<4 x float> %85) #1
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %83, <2 x i32> %84, <4 x i32> %call80)
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

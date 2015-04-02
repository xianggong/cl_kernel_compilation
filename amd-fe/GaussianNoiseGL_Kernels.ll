; ModuleID = 'GaussianNoiseGL_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

@gaussian_transform.iv0 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_gaussian_transform_kernel(<4 x i8> addrspace(1)* %inputImage, %opencl.image2d_t addrspace(1)* %outputImage, i32 %factor) #0 {
entry:
  %inputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %outputImage.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %factor.addr = alloca i32, align 4
  %pos0 = alloca i32, align 4
  %pos1 = alloca i32, align 4
  %texel0 = alloca <4 x float>, align 16
  %texel1 = alloca <4 x float>, align 16
  %avg0 = alloca float, align 4
  %avg1 = alloca float, align 4
  %dev0 = alloca float, align 4
  %dev1 = alloca float, align 4
  %gaussian = alloca <2 x float>, align 8
  %.compoundliteral = alloca <2 x float>, align 8
  %out0 = alloca <4 x float>, align 16
  %out1 = alloca <4 x float>, align 16
  %locate0 = alloca <2 x i32>, align 8
  %locate1 = alloca <2 x i32>, align 8
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %inputImage.addr, align 8
  store %opencl.image2d_t addrspace(1)* %outputImage, %opencl.image2d_t addrspace(1)** %outputImage.addr, align 8
  store i32 %factor, i32* %factor.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul = mul i64 2, %call1
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %mul3 = mul i64 %mul, %call2
  %add = add i64 %call, %mul3
  %conv = trunc i64 %add to i32
  store i32 %conv, i32* %pos0, align 4
  %call4 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %add6 = add i64 %call4, %call5
  %call7 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul8 = mul i64 2, %call7
  %call9 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %mul10 = mul i64 %mul8, %call9
  %add11 = add i64 %add6, %mul10
  %conv12 = trunc i64 %add11 to i32
  store i32 %conv12, i32* %pos1, align 4
  %0 = load i32* %pos0, align 4
  %idxprom = sext i32 %0 to i64
  %1 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %1, i64 %idxprom
  %2 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %call13 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %2) #1
  store <4 x float> %call13, <4 x float>* %texel0, align 16
  %3 = load i32* %pos1, align 4
  %idxprom14 = sext i32 %3 to i64
  %4 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx15 = getelementptr inbounds <4 x i8> addrspace(1)* %4, i64 %idxprom14
  %5 = load <4 x i8> addrspace(1)* %arrayidx15, align 4
  %call16 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %5) #1
  store <4 x float> %call16, <4 x float>* %texel1, align 16
  %6 = load <4 x float>* %texel0, align 16
  %7 = extractelement <4 x float> %6, i32 0
  %8 = load <4 x float>* %texel0, align 16
  %9 = extractelement <4 x float> %8, i32 1
  %add17 = fadd float %7, %9
  %10 = load <4 x float>* %texel0, align 16
  %11 = extractelement <4 x float> %10, i32 2
  %add18 = fadd float %add17, %11
  %12 = load <4 x float>* %texel0, align 16
  %13 = extractelement <4 x float> %12, i32 3
  %add19 = fadd float %add18, %13
  %div = fdiv float %add19, 4.000000e+00, !fpmath !7
  store float %div, float* %avg0, align 4
  %14 = load <4 x float>* %texel1, align 16
  %15 = extractelement <4 x float> %14, i32 0
  %16 = load <4 x float>* %texel1, align 16
  %17 = extractelement <4 x float> %16, i32 1
  %add20 = fadd float %15, %17
  %18 = load <4 x float>* %texel1, align 16
  %19 = extractelement <4 x float> %18, i32 2
  %add21 = fadd float %add20, %19
  %20 = load <4 x float>* %texel1, align 16
  %21 = extractelement <4 x float> %20, i32 3
  %add22 = fadd float %add21, %21
  %div23 = fdiv float %add22, 4.000000e+00, !fpmath !7
  store float %div23, float* %avg1, align 4
  %22 = load float* %avg0, align 4
  %sub = fsub float -0.000000e+00, %22
  %conv24 = fptosi float %sub to i32
  %call25 = call cc75 float @ran1(i32 %conv24, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  store float %call25, float* %dev0, align 4
  %23 = load float* %avg1, align 4
  %sub26 = fsub float -0.000000e+00, %23
  %conv27 = fptosi float %sub26 to i32
  %call28 = call cc75 float @ran1(i32 %conv27, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  store float %call28, float* %dev1, align 4
  %24 = load float* %dev0, align 4
  %vecinit = insertelement <2 x float> undef, float %24, i32 0
  %25 = load float* %dev1, align 4
  %vecinit29 = insertelement <2 x float> %vecinit, float %25, i32 1
  store <2 x float> %vecinit29, <2 x float>* %.compoundliteral
  %26 = load <2 x float>* %.compoundliteral
  %call30 = call cc75 <2 x float> @BoxMuller(<2 x float> %26)
  store <2 x float> %call30, <2 x float>* %gaussian, align 8
  %27 = load <4 x float>* %texel0, align 16
  %28 = load <2 x float>* %gaussian, align 8
  %29 = extractelement <2 x float> %28, i32 0
  %30 = load i32* %factor.addr, align 4
  %conv31 = sitofp i32 %30 to float
  %mul32 = fmul float %29, %conv31
  %31 = insertelement <4 x float> undef, float %mul32, i32 0
  %splat = shufflevector <4 x float> %31, <4 x float> %31, <4 x i32> zeroinitializer
  %add33 = fadd <4 x float> %27, %splat
  %div34 = fdiv <4 x float> %add33, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !7
  store <4 x float> %div34, <4 x float>* %out0, align 16
  %32 = load <4 x float>* %texel1, align 16
  %33 = load <2 x float>* %gaussian, align 8
  %34 = extractelement <2 x float> %33, i32 1
  %35 = load i32* %factor.addr, align 4
  %conv35 = sitofp i32 %35 to float
  %mul36 = fmul float %34, %conv35
  %36 = insertelement <4 x float> undef, float %mul36, i32 0
  %splat37 = shufflevector <4 x float> %36, <4 x float> %36, <4 x i32> zeroinitializer
  %add38 = fadd <4 x float> %32, %splat37
  %div39 = fdiv <4 x float> %add38, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !7
  store <4 x float> %div39, <4 x float>* %out1, align 16
  %call40 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv41 = trunc i64 %call40 to i32
  %37 = load <2 x i32>* %locate0, align 8
  %38 = insertelement <2 x i32> %37, i32 %conv41, i32 0
  store <2 x i32> %38, <2 x i32>* %locate0, align 8
  %call42 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv43 = trunc i64 %call42 to i32
  %39 = load <2 x i32>* %locate0, align 8
  %40 = insertelement <2 x i32> %39, i32 %conv43, i32 1
  store <2 x i32> %40, <2 x i32>* %locate0, align 8
  %call44 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call45 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %add46 = add i64 %call44, %call45
  %conv47 = trunc i64 %add46 to i32
  %41 = load <2 x i32>* %locate1, align 8
  %42 = insertelement <2 x i32> %41, i32 %conv47, i32 0
  store <2 x i32> %42, <2 x i32>* %locate1, align 8
  %call48 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv49 = trunc i64 %call48 to i32
  %43 = load <2 x i32>* %locate1, align 8
  %44 = insertelement <2 x i32> %43, i32 %conv49, i32 1
  store <2 x i32> %44, <2 x i32>* %locate1, align 8
  %45 = load %opencl.image2d_t addrspace(1)** %outputImage.addr, align 8
  %46 = load <2 x i32>* %locate0, align 8
  %47 = load <4 x float>* %out0, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %45, <2 x i32> %46, <4 x float> %47)
  %48 = load %opencl.image2d_t addrspace(1)** %outputImage.addr, align 8
  %49 = load <2 x i32>* %locate1, align 8
  %50 = load <4 x float>* %out1, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %48, <2 x i32> %49, <4 x float> %50)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare cc75 float @ran1(i32, i32 addrspace(3)*)

declare cc75 <2 x float> @BoxMuller(<2 x float>)

declare cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x float>)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (<4 x i8> addrspace(1)*, %opencl.image2d_t addrspace(1)*, i32)* @__OpenCL_gaussian_transform_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"write_only", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"image2d_t", metadata !"int"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"image2d_t", metadata !"int"}
!6 = metadata !{i32 1, i32 2}
!7 = metadata !{float 2.500000e+00}

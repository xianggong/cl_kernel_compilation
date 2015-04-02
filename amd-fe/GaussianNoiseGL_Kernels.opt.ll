; ModuleID = 'GaussianNoiseGL_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

@gaussian_transform.iv0 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_gaussian_transform_kernel(<4 x i8> addrspace(1)* %inputImage, %opencl.image2d_t addrspace(1)* %outputImage, i32 %factor) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul = mul i64 2, %call1
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %mul3 = mul i64 %mul, %call2
  %add = add i64 %call, %mul3
  %conv = trunc i64 %add to i32
  %call4 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %add6 = add i64 %call4, %call5
  %call7 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul8 = mul i64 2, %call7
  %call9 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %mul10 = mul i64 %mul8, %call9
  %add11 = add i64 %add6, %mul10
  %conv12 = trunc i64 %add11 to i32
  %idxprom = sext i32 %conv to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom
  %0 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %call13 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %0) #1
  %idxprom14 = sext i32 %conv12 to i64
  %arrayidx15 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom14
  %1 = load <4 x i8> addrspace(1)* %arrayidx15, align 4
  %call16 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %1) #1
  %2 = extractelement <4 x float> %call13, i32 0
  %3 = extractelement <4 x float> %call13, i32 1
  %add17 = fadd float %2, %3
  %4 = extractelement <4 x float> %call13, i32 2
  %add18 = fadd float %add17, %4
  %5 = extractelement <4 x float> %call13, i32 3
  %add19 = fadd float %add18, %5
  %div = fdiv float %add19, 4.000000e+00, !fpmath !7
  %6 = extractelement <4 x float> %call16, i32 0
  %7 = extractelement <4 x float> %call16, i32 1
  %add20 = fadd float %6, %7
  %8 = extractelement <4 x float> %call16, i32 2
  %add21 = fadd float %add20, %8
  %9 = extractelement <4 x float> %call16, i32 3
  %add22 = fadd float %add21, %9
  %div23 = fdiv float %add22, 4.000000e+00, !fpmath !7
  %sub = fsub float -0.000000e+00, %div
  %conv24 = fptosi float %sub to i32
  %call25 = call cc75 float @ran1(i32 %conv24, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  %sub26 = fsub float -0.000000e+00, %div23
  %conv27 = fptosi float %sub26 to i32
  %call28 = call cc75 float @ran1(i32 %conv27, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  %vecinit = insertelement <2 x float> undef, float %call25, i32 0
  %vecinit29 = insertelement <2 x float> %vecinit, float %call28, i32 1
  %call30 = call cc75 <2 x float> @BoxMuller(<2 x float> %vecinit29)
  %10 = extractelement <2 x float> %call30, i32 0
  %conv31 = sitofp i32 %factor to float
  %mul32 = fmul float %10, %conv31
  %11 = insertelement <4 x float> undef, float %mul32, i32 0
  %splat = shufflevector <4 x float> %11, <4 x float> %11, <4 x i32> zeroinitializer
  %add33 = fadd <4 x float> %call13, %splat
  %div34 = fdiv <4 x float> %add33, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !7
  %12 = extractelement <2 x float> %call30, i32 1
  %conv35 = sitofp i32 %factor to float
  %mul36 = fmul float %12, %conv35
  %13 = insertelement <4 x float> undef, float %mul36, i32 0
  %splat37 = shufflevector <4 x float> %13, <4 x float> %13, <4 x i32> zeroinitializer
  %add38 = fadd <4 x float> %call16, %splat37
  %div39 = fdiv <4 x float> %add38, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !7
  %call40 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv41 = trunc i64 %call40 to i32
  %14 = insertelement <2 x i32> undef, i32 %conv41, i32 0
  %call42 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv43 = trunc i64 %call42 to i32
  %15 = insertelement <2 x i32> %14, i32 %conv43, i32 1
  %call44 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call45 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %add46 = add i64 %call44, %call45
  %conv47 = trunc i64 %add46 to i32
  %16 = insertelement <2 x i32> undef, i32 %conv47, i32 0
  %call48 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv49 = trunc i64 %call48 to i32
  %17 = insertelement <2 x i32> %16, i32 %conv49, i32 1
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %outputImage, <2 x i32> %15, <4 x float> %div34)
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %outputImage, <2 x i32> %17, <4 x float> %div39)
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

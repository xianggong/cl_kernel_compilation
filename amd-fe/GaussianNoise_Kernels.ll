; ModuleID = 'GaussianNoise_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@gaussian_transform.iv0 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define cc75 float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
entry:
  %idum.addr = alloca i32, align 4
  %iv.addr = alloca i32 addrspace(3)*, align 8
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %iy = alloca i32, align 4
  %tid = alloca i32, align 4
  store i32 %idum, i32* %idum.addr, align 4
  store i32 addrspace(3)* %iv, i32 addrspace(3)** %iv.addr, align 8
  store i32 0, i32* %iy, align 4
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  store i32 4, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %j, align 4
  %cmp = icmp sge i32 %0, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32* %idum.addr, align 4
  %div = sdiv i32 %1, 127773
  store i32 %div, i32* %k, align 4
  %2 = load i32* %idum.addr, align 4
  %3 = load i32* %k, align 4
  %mul = mul nsw i32 %3, 127773
  %sub = sub nsw i32 %2, %mul
  %mul2 = mul nsw i32 16807, %sub
  %4 = load i32* %k, align 4
  %mul3 = mul nsw i32 2836, %4
  %sub4 = sub nsw i32 %mul2, %mul3
  store i32 %sub4, i32* %idum.addr, align 4
  %5 = load i32* %idum.addr, align 4
  %cmp5 = icmp slt i32 %5, 0
  br i1 %cmp5, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %6 = load i32* %idum.addr, align 4
  %add = add nsw i32 %6, 2147483647
  store i32 %add, i32* %idum.addr, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %7 = load i32* %j, align 4
  %cmp7 = icmp slt i32 %7, 4
  br i1 %cmp7, label %if.then9, label %if.end12

if.then9:                                         ; preds = %if.end
  %8 = load i32* %idum.addr, align 4
  %9 = load i32* %tid, align 4
  %mul10 = mul nsw i32 4, %9
  %10 = load i32* %j, align 4
  %add11 = add nsw i32 %mul10, %10
  %idxprom = sext i32 %add11 to i64
  %11 = load i32 addrspace(3)** %iv.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(3)* %11, i64 %idxprom
  store i32 %8, i32 addrspace(3)* %arrayidx, align 4
  br label %if.end12

if.end12:                                         ; preds = %if.then9, %if.end
  br label %for.inc

for.inc:                                          ; preds = %if.end12
  %12 = load i32* %j, align 4
  %dec = add nsw i32 %12, -1
  store i32 %dec, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %13 = load i32 addrspace(3)** %iv.addr, align 8
  %arrayidx13 = getelementptr inbounds i32 addrspace(3)* %13, i64 0
  %14 = load i32 addrspace(3)* %arrayidx13, align 4
  store i32 %14, i32* %iy, align 4
  %15 = load i32* %idum.addr, align 4
  %div14 = sdiv i32 %15, 127773
  store i32 %div14, i32* %k, align 4
  %16 = load i32* %idum.addr, align 4
  %17 = load i32* %k, align 4
  %mul15 = mul nsw i32 %17, 127773
  %sub16 = sub nsw i32 %16, %mul15
  %mul17 = mul nsw i32 16807, %sub16
  %18 = load i32* %k, align 4
  %mul18 = mul nsw i32 2836, %18
  %sub19 = sub nsw i32 %mul17, %mul18
  store i32 %sub19, i32* %idum.addr, align 4
  %19 = load i32* %idum.addr, align 4
  %cmp20 = icmp slt i32 %19, 0
  br i1 %cmp20, label %if.then22, label %if.end24

if.then22:                                        ; preds = %for.end
  %20 = load i32* %idum.addr, align 4
  %add23 = add nsw i32 %20, 2147483647
  store i32 %add23, i32* %idum.addr, align 4
  br label %if.end24

if.end24:                                         ; preds = %if.then22, %for.end
  %21 = load i32* %iy, align 4
  %div25 = sdiv i32 %21, 536870912
  store i32 %div25, i32* %j, align 4
  %22 = load i32* %tid, align 4
  %mul26 = mul nsw i32 4, %22
  %23 = load i32* %j, align 4
  %add27 = add nsw i32 %mul26, %23
  %idxprom28 = sext i32 %add27 to i64
  %24 = load i32 addrspace(3)** %iv.addr, align 8
  %arrayidx29 = getelementptr inbounds i32 addrspace(3)* %24, i64 %idxprom28
  %25 = load i32 addrspace(3)* %arrayidx29, align 4
  store i32 %25, i32* %iy, align 4
  %26 = load i32* %iy, align 4
  %conv30 = sitofp i32 %26 to double
  %mul31 = fmul double 0x3E00000000200000, %conv30
  %conv32 = fptrunc double %mul31 to float
  ret float %conv32
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind
define cc75 <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
entry:
  %uniform.addr = alloca <2 x float>, align 8
  %r = alloca float, align 4
  %theta = alloca float, align 4
  %.compoundliteral = alloca <2 x float>, align 8
  store <2 x float> %uniform, <2 x float>* %uniform.addr, align 8
  %0 = load <2 x float>* %uniform.addr, align 8
  %1 = extractelement <2 x float> %0, i32 0
  %call = call cc75 float @_Z3logf(float %1) #1
  %mul = fmul float -2.000000e+00, %call
  %call1 = call cc75 float @_Z4sqrtf(float %mul) #1
  store float %call1, float* %r, align 4
  %2 = load <2 x float>* %uniform.addr, align 8
  %3 = extractelement <2 x float> %2, i32 1
  %conv = fpext float %3 to double
  %mul2 = fmul double 6.280000e+00, %conv
  %conv3 = fptrunc double %mul2 to float
  store float %conv3, float* %theta, align 4
  %4 = load float* %r, align 4
  %5 = load float* %theta, align 4
  %call4 = call cc75 float @_Z3sinf(float %5) #1
  %mul5 = fmul float %4, %call4
  %vecinit = insertelement <2 x float> undef, float %mul5, i32 0
  %6 = load float* %r, align 4
  %7 = load float* %theta, align 4
  %call6 = call cc75 float @_Z3cosf(float %7) #1
  %mul7 = fmul float %6, %call6
  %vecinit8 = insertelement <2 x float> %vecinit, float %mul7, i32 1
  store <2 x float> %vecinit8, <2 x float>* %.compoundliteral
  %8 = load <2 x float>* %.compoundliteral
  ret <2 x float> %8
}

; Function Attrs: nounwind readnone
declare cc75 float @_Z4sqrtf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3logf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3sinf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3cosf(float) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_gaussian_transform_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
entry:
  %inputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %outputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %factor.addr = alloca i32, align 4
  %pos = alloca i32, align 4
  %texel0 = alloca <4 x float>, align 16
  %texel1 = alloca <4 x float>, align 16
  %avg0 = alloca float, align 4
  %avg1 = alloca float, align 4
  %dev0 = alloca float, align 4
  %dev1 = alloca float, align 4
  %gaussian = alloca <2 x float>, align 8
  %.compoundliteral = alloca <2 x float>, align 8
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %inputImage.addr, align 8
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %outputImage.addr, align 8
  store i32 %factor, i32* %factor.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul = mul i64 2, %call1
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %mul3 = mul i64 %mul, %call2
  %add = add i64 %call, %mul3
  %conv = trunc i64 %add to i32
  store i32 %conv, i32* %pos, align 4
  %0 = load i32* %pos, align 4
  %idxprom = sext i32 %0 to i64
  %1 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %1, i64 %idxprom
  %2 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %call4 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %2) #1
  store <4 x float> %call4, <4 x float>* %texel0, align 16
  %3 = load i32* %pos, align 4
  %conv5 = sext i32 %3 to i64
  %call6 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %add7 = add i64 %conv5, %call6
  %4 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx8 = getelementptr inbounds <4 x i8> addrspace(1)* %4, i64 %add7
  %5 = load <4 x i8> addrspace(1)* %arrayidx8, align 4
  %call9 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %5) #1
  store <4 x float> %call9, <4 x float>* %texel1, align 16
  %6 = load <4 x float>* %texel0, align 16
  %7 = extractelement <4 x float> %6, i32 0
  %8 = load <4 x float>* %texel0, align 16
  %9 = extractelement <4 x float> %8, i32 1
  %add10 = fadd float %7, %9
  %10 = load <4 x float>* %texel0, align 16
  %11 = extractelement <4 x float> %10, i32 2
  %add11 = fadd float %add10, %11
  %12 = load <4 x float>* %texel0, align 16
  %13 = extractelement <4 x float> %12, i32 3
  %add12 = fadd float %add11, %13
  %div = fdiv float %add12, 4.000000e+00, !fpmath !7
  store float %div, float* %avg0, align 4
  %14 = load <4 x float>* %texel1, align 16
  %15 = extractelement <4 x float> %14, i32 0
  %16 = load <4 x float>* %texel1, align 16
  %17 = extractelement <4 x float> %16, i32 1
  %add13 = fadd float %15, %17
  %18 = load <4 x float>* %texel1, align 16
  %19 = extractelement <4 x float> %18, i32 2
  %add14 = fadd float %add13, %19
  %20 = load <4 x float>* %texel1, align 16
  %21 = extractelement <4 x float> %20, i32 3
  %add15 = fadd float %add14, %21
  %div16 = fdiv float %add15, 4.000000e+00, !fpmath !7
  store float %div16, float* %avg1, align 4
  %22 = load float* %avg0, align 4
  %sub = fsub float -0.000000e+00, %22
  %conv17 = fptosi float %sub to i32
  %call18 = call cc75 float @ran1(i32 %conv17, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  store float %call18, float* %dev0, align 4
  %23 = load float* %avg1, align 4
  %sub19 = fsub float -0.000000e+00, %23
  %conv20 = fptosi float %sub19 to i32
  %call21 = call cc75 float @ran1(i32 %conv20, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  store float %call21, float* %dev1, align 4
  %24 = load float* %dev0, align 4
  %vecinit = insertelement <2 x float> undef, float %24, i32 0
  %25 = load float* %dev1, align 4
  %vecinit22 = insertelement <2 x float> %vecinit, float %25, i32 1
  store <2 x float> %vecinit22, <2 x float>* %.compoundliteral
  %26 = load <2 x float>* %.compoundliteral
  %call23 = call cc75 <2 x float> @BoxMuller(<2 x float> %26)
  store <2 x float> %call23, <2 x float>* %gaussian, align 8
  %27 = load <4 x float>* %texel0, align 16
  %28 = load <2 x float>* %gaussian, align 8
  %29 = extractelement <2 x float> %28, i32 0
  %30 = load i32* %factor.addr, align 4
  %conv24 = sitofp i32 %30 to float
  %mul25 = fmul float %29, %conv24
  %31 = insertelement <4 x float> undef, float %mul25, i32 0
  %splat = shufflevector <4 x float> %31, <4 x float> %31, <4 x i32> zeroinitializer
  %add26 = fadd <4 x float> %27, %splat
  %call27 = call cc75 <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %add26) #1
  %32 = load i32* %pos, align 4
  %idxprom28 = sext i32 %32 to i64
  %33 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx29 = getelementptr inbounds <4 x i8> addrspace(1)* %33, i64 %idxprom28
  store <4 x i8> %call27, <4 x i8> addrspace(1)* %arrayidx29, align 4
  %34 = load <4 x float>* %texel1, align 16
  %35 = load <2 x float>* %gaussian, align 8
  %36 = extractelement <2 x float> %35, i32 1
  %37 = load i32* %factor.addr, align 4
  %conv30 = sitofp i32 %37 to float
  %mul31 = fmul float %36, %conv30
  %38 = insertelement <4 x float> undef, float %mul31, i32 0
  %splat32 = shufflevector <4 x float> %38, <4 x float> %38, <4 x i32> zeroinitializer
  %add33 = fadd <4 x float> %34, %splat32
  %call34 = call cc75 <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %add33) #1
  %39 = load i32* %pos, align 4
  %conv35 = sext i32 %39 to i64
  %call36 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %add37 = add i64 %conv35, %call36
  %40 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx38 = getelementptr inbounds <4 x i8> addrspace(1)* %40, i64 %add37
  store <4 x i8> %call34, <4 x i8> addrspace(1)* %arrayidx38, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @__OpenCL_gaussian_transform_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int"}
!6 = metadata !{i32 1, i32 2}
!7 = metadata !{float 2.500000e+00}

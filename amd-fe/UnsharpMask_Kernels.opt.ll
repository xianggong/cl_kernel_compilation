; ModuleID = 'UnsharpMask_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

@imageSampler = addrspace(2) constant i32 34, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_unsharp_mask_kernel(%opencl.image2d_t addrspace(1)* %input, %opencl.image2d_t addrspace(1)* %output, float addrspace(1)* %gaussianKernel, i32 %gaussianKernelRadius, float %threshold, float %amount) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %0 = insertelement <2 x i32> undef, i32 %conv, i32 0
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %1 = insertelement <2 x i32> %0, i32 %conv2, i32 1
  %2 = extractelement <2 x i32> %1, i32 1
  %sub = sub nsw i32 %2, %gaussianKernelRadius
  %3 = insertelement <2 x i32> undef, i32 %sub, i32 1
  br label %for.cond

for.cond:                                         ; preds = %for.inc18, %entry
  %pixel.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %pixel.1, %for.inc18 ]
  %tc.0 = phi <2 x i32> [ %3, %entry ], [ %16, %for.inc18 ]
  %j.0 = phi i32 [ 0, %entry ], [ %inc19, %for.inc18 ]
  %mul = mul nsw i32 2, %gaussianKernelRadius
  %cmp = icmp sle i32 %j.0, %mul
  br i1 %cmp, label %for.body, label %for.end21

for.body:                                         ; preds = %for.cond
  %4 = extractelement <2 x i32> %1, i32 0
  %sub4 = sub nsw i32 %4, %gaussianKernelRadius
  %5 = insertelement <2 x i32> %tc.0, i32 %sub4, i32 0
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body
  %pixel.1 = phi <4 x float> [ %pixel.0, %for.body ], [ %12, %for.inc ]
  %tc.1 = phi <2 x i32> [ %5, %for.body ], [ %14, %for.inc ]
  %i.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %mul6 = mul nsw i32 2, %gaussianKernelRadius
  %cmp7 = icmp sle i32 %i.0, %mul6
  br i1 %cmp7, label %for.body9, label %for.end

for.body9:                                        ; preds = %for.cond5
  %6 = load i32 addrspace(2)* @imageSampler, align 4
  %call10 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %input, i32 %6, <2 x i32> %tc.1) #1
  %call11 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call10) #1
  %7 = shufflevector <4 x float> %call11, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul12 = mul nsw i32 %gaussianKernelRadius, 2
  %add = add nsw i32 %mul12, 1
  %mul13 = mul nsw i32 %j.0, %add
  %add14 = add nsw i32 %mul13, %i.0
  %idxprom = sext i32 %add14 to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %gaussianKernel, i64 %idxprom
  %8 = load float addrspace(1)* %arrayidx, align 4
  %9 = insertelement <3 x float> undef, float %8, i32 0
  %splat = shufflevector <3 x float> %9, <3 x float> %9, <3 x i32> zeroinitializer
  %mul15 = fmul <3 x float> %7, %splat
  %10 = shufflevector <4 x float> %pixel.1, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add16 = fadd <3 x float> %10, %mul15
  %11 = shufflevector <3 x float> %add16, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %12 = shufflevector <4 x float> %pixel.1, <4 x float> %11, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  br label %for.inc

for.inc:                                          ; preds = %for.body9
  %inc = add nsw i32 %i.0, 1
  %13 = extractelement <2 x i32> %tc.1, i32 0
  %inc17 = add nsw i32 %13, 1
  %14 = insertelement <2 x i32> %tc.1, i32 %inc17, i32 0
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc18

for.inc18:                                        ; preds = %for.end
  %inc19 = add nsw i32 %j.0, 1
  %15 = extractelement <2 x i32> %tc.1, i32 1
  %inc20 = add nsw i32 %15, 1
  %16 = insertelement <2 x i32> %tc.1, i32 %inc20, i32 1
  br label %for.cond

for.end21:                                        ; preds = %for.cond
  %17 = load i32 addrspace(2)* @imageSampler, align 4
  %call22 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %input, i32 %17, <2 x i32> %1) #1
  %call23 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call22) #1
  %18 = extractelement <4 x float> %call23, i32 0
  %19 = extractelement <4 x float> %pixel.0, i32 0
  %sub24 = fsub float %18, %19
  %call25 = call cc75 float @_Z4fabsf(float %sub24) #1
  %cmp26 = fcmp ogt float %call25, %threshold
  br i1 %cmp26, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.end21
  %mul28 = fmul float %sub24, %amount
  br label %cond.end

cond.false:                                       ; preds = %for.end21
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %mul28, %cond.true ], [ 0.000000e+00, %cond.false ]
  %20 = extractelement <4 x float> %call23, i32 0
  %add29 = fadd float %20, %cond
  %21 = insertelement <4 x float> %call23, float %add29, i32 0
  %22 = extractelement <4 x float> %21, i32 1
  %23 = extractelement <4 x float> %pixel.0, i32 1
  %sub30 = fsub float %22, %23
  %call31 = call cc75 float @_Z4fabsf(float %sub30) #1
  %cmp32 = fcmp ogt float %call31, %threshold
  br i1 %cmp32, label %cond.true34, label %cond.false36

cond.true34:                                      ; preds = %cond.end
  %mul35 = fmul float %sub30, %amount
  br label %cond.end37

cond.false36:                                     ; preds = %cond.end
  br label %cond.end37

cond.end37:                                       ; preds = %cond.false36, %cond.true34
  %cond38 = phi float [ %mul35, %cond.true34 ], [ 0.000000e+00, %cond.false36 ]
  %24 = extractelement <4 x float> %21, i32 1
  %add39 = fadd float %24, %cond38
  %25 = insertelement <4 x float> %21, float %add39, i32 1
  %26 = extractelement <4 x float> %25, i32 2
  %27 = extractelement <4 x float> %pixel.0, i32 2
  %sub40 = fsub float %26, %27
  %call41 = call cc75 float @_Z4fabsf(float %sub40) #1
  %cmp42 = fcmp ogt float %call41, %threshold
  br i1 %cmp42, label %cond.true44, label %cond.false46

cond.true44:                                      ; preds = %cond.end37
  %mul45 = fmul float %sub40, %amount
  br label %cond.end47

cond.false46:                                     ; preds = %cond.end37
  br label %cond.end47

cond.end47:                                       ; preds = %cond.false46, %cond.true44
  %cond48 = phi float [ %mul45, %cond.true44 ], [ 0.000000e+00, %cond.false46 ]
  %28 = extractelement <4 x float> %25, i32 2
  %add49 = fadd float %28, %cond48
  %29 = insertelement <4 x float> %25, float %add49, i32 2
  %add50 = fadd <4 x float> %29, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %call51 = call cc75 <4 x float> @_Z5clampDv4_fS_S_(<4 x float> %add50, <4 x float> zeroinitializer, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>) #1
  %call52 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_f(<4 x float> %call51) #1
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %output, <2 x i32> %1, <4 x i32> %call52)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)*, i32, <2 x i32>) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z4fabsf(float) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z5clampDv4_fS_S_(<4 x float>, <4 x float>, <4 x float>) #1

declare cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x i32>)

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z13convert_uint4Dv4_f(<4 x float>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_unsharp_mask_pass1_kernel(%opencl.image2d_t addrspace(1)* %input, <4 x float> addrspace(1)* %temp, i32 %width, float addrspace(1)* %gaussianKernel, i32 %gaussianKernelRadius) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %0 = insertelement <2 x i32> undef, i32 %conv, i32 0
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %1 = insertelement <2 x i32> %0, i32 %conv2, i32 1
  %2 = extractelement <2 x i32> %1, i32 1
  %3 = insertelement <2 x i32> undef, i32 %2, i32 1
  %4 = extractelement <2 x i32> %1, i32 0
  %sub = sub nsw i32 %4, %gaussianKernelRadius
  %5 = insertelement <2 x i32> %3, i32 %sub, i32 0
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %pixel.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %12, %for.inc ]
  %tc.0 = phi <2 x i32> [ %5, %entry ], [ %14, %for.inc ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %mul = mul nsw i32 2, %gaussianKernelRadius
  %cmp = icmp sle i32 %i.0, %mul
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load i32 addrspace(2)* @imageSampler, align 4
  %call4 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %input, i32 %6, <2 x i32> %tc.0) #1
  %call5 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call4) #1
  %7 = shufflevector <4 x float> %call5, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %gaussianKernel, i64 %idxprom
  %8 = load float addrspace(1)* %arrayidx, align 4
  %9 = insertelement <3 x float> undef, float %8, i32 0
  %splat = shufflevector <3 x float> %9, <3 x float> %9, <3 x i32> zeroinitializer
  %mul6 = fmul <3 x float> %7, %splat
  %10 = shufflevector <4 x float> %pixel.0, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add = fadd <3 x float> %10, %mul6
  %11 = shufflevector <3 x float> %add, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %12 = shufflevector <4 x float> %pixel.0, <4 x float> %11, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  %13 = extractelement <2 x i32> %tc.0, i32 0
  %inc7 = add nsw i32 %13, 1
  %14 = insertelement <2 x i32> %tc.0, i32 %inc7, i32 0
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %15 = extractelement <2 x i32> %1, i32 1
  %mul8 = mul nsw i32 %15, %width
  %16 = extractelement <2 x i32> %1, i32 0
  %add9 = add nsw i32 %mul8, %16
  %idxprom10 = sext i32 %add9 to i64
  %arrayidx11 = getelementptr inbounds <4 x float> addrspace(1)* %temp, i64 %idxprom10
  store <4 x float> %pixel.0, <4 x float> addrspace(1)* %arrayidx11, align 16
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_unsharp_mask_pass2_kernel(%opencl.image2d_t addrspace(1)* %input, <4 x float> addrspace(1)* %temp, %opencl.image2d_t addrspace(1)* %output, i32 %width, i32 %height, float addrspace(1)* %gaussianKernel, i32 %gaussianKernelRadius, float %threshold, float %amount) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %0 = insertelement <2 x i32> undef, i32 %conv, i32 0
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %1 = insertelement <2 x i32> %0, i32 %conv2, i32 1
  %2 = extractelement <2 x i32> %1, i32 1
  %sub = sub nsw i32 %2, %gaussianKernelRadius
  %3 = insertelement <2 x i32> undef, i32 %sub, i32 1
  %4 = extractelement <2 x i32> %1, i32 0
  %5 = insertelement <2 x i32> %3, i32 %4, i32 0
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %pixel.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %18, %for.inc ]
  %tc.0 = phi <2 x i32> [ %5, %entry ], [ %20, %for.inc ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %mul = mul nsw i32 2, %gaussianKernelRadius
  %cmp = icmp sle i32 %i.0, %mul
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = extractelement <2 x i32> %tc.0, i32 0
  %7 = insertelement <2 x i32> undef, i32 %6, i32 0
  %8 = extractelement <2 x i32> %tc.0, i32 1
  %sub4 = sub nsw i32 %height, 1
  %call5 = call cc75 i32 @_Z5clampiii(i32 %8, i32 0, i32 %sub4) #1
  %9 = insertelement <2 x i32> %7, i32 %call5, i32 1
  %10 = extractelement <2 x i32> %9, i32 1
  %mul6 = mul nsw i32 %10, %width
  %11 = extractelement <2 x i32> %9, i32 0
  %add = add nsw i32 %mul6, %11
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %temp, i64 %idxprom
  %12 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %13 = shufflevector <4 x float> %12, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %idxprom7 = sext i32 %i.0 to i64
  %arrayidx8 = getelementptr inbounds float addrspace(1)* %gaussianKernel, i64 %idxprom7
  %14 = load float addrspace(1)* %arrayidx8, align 4
  %15 = insertelement <3 x float> undef, float %14, i32 0
  %splat = shufflevector <3 x float> %15, <3 x float> %15, <3 x i32> zeroinitializer
  %mul9 = fmul <3 x float> %13, %splat
  %16 = shufflevector <4 x float> %pixel.0, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add10 = fadd <3 x float> %16, %mul9
  %17 = shufflevector <3 x float> %add10, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %18 = shufflevector <4 x float> %pixel.0, <4 x float> %17, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  %19 = extractelement <2 x i32> %tc.0, i32 1
  %inc11 = add nsw i32 %19, 1
  %20 = insertelement <2 x i32> %tc.0, i32 %inc11, i32 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %21 = load i32 addrspace(2)* @imageSampler, align 4
  %call12 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %input, i32 %21, <2 x i32> %1) #1
  %call13 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call12) #1
  %22 = extractelement <4 x float> %call13, i32 0
  %23 = extractelement <4 x float> %pixel.0, i32 0
  %sub14 = fsub float %22, %23
  %call15 = call cc75 float @_Z4fabsf(float %sub14) #1
  %cmp16 = fcmp ogt float %call15, %threshold
  br i1 %cmp16, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.end
  %mul18 = fmul float %sub14, %amount
  br label %cond.end

cond.false:                                       ; preds = %for.end
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %mul18, %cond.true ], [ 0.000000e+00, %cond.false ]
  %24 = extractelement <4 x float> %call13, i32 0
  %add19 = fadd float %24, %cond
  %25 = insertelement <4 x float> %call13, float %add19, i32 0
  %26 = extractelement <4 x float> %25, i32 1
  %27 = extractelement <4 x float> %pixel.0, i32 1
  %sub20 = fsub float %26, %27
  %call21 = call cc75 float @_Z4fabsf(float %sub20) #1
  %cmp22 = fcmp ogt float %call21, %threshold
  br i1 %cmp22, label %cond.true24, label %cond.false26

cond.true24:                                      ; preds = %cond.end
  %mul25 = fmul float %sub20, %amount
  br label %cond.end27

cond.false26:                                     ; preds = %cond.end
  br label %cond.end27

cond.end27:                                       ; preds = %cond.false26, %cond.true24
  %cond28 = phi float [ %mul25, %cond.true24 ], [ 0.000000e+00, %cond.false26 ]
  %28 = extractelement <4 x float> %25, i32 1
  %add29 = fadd float %28, %cond28
  %29 = insertelement <4 x float> %25, float %add29, i32 1
  %30 = extractelement <4 x float> %29, i32 2
  %31 = extractelement <4 x float> %pixel.0, i32 2
  %sub30 = fsub float %30, %31
  %call31 = call cc75 float @_Z4fabsf(float %sub30) #1
  %cmp32 = fcmp ogt float %call31, %threshold
  br i1 %cmp32, label %cond.true34, label %cond.false36

cond.true34:                                      ; preds = %cond.end27
  %mul35 = fmul float %sub30, %amount
  br label %cond.end37

cond.false36:                                     ; preds = %cond.end27
  br label %cond.end37

cond.end37:                                       ; preds = %cond.false36, %cond.true34
  %cond38 = phi float [ %mul35, %cond.true34 ], [ 0.000000e+00, %cond.false36 ]
  %32 = extractelement <4 x float> %29, i32 2
  %add39 = fadd float %32, %cond38
  %33 = insertelement <4 x float> %29, float %add39, i32 2
  %add40 = fadd <4 x float> %33, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %call41 = call cc75 <4 x float> @_Z5clampDv4_fS_S_(<4 x float> %add40, <4 x float> zeroinitializer, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>) #1
  %call42 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_f(<4 x float> %call41) #1
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %output, <2 x i32> %1, <4 x i32> %call42)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i32 @_Z5clampiii(i32, i32, i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_unsharp_mask_filter_kernel(<4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)* %output, i32 %width, i32 %height, float addrspace(1)* %gaussianKernel, i32 %gaussianKernelRadius, float %threshold, float %amount) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %0 = insertelement <2 x i32> undef, i32 %conv, i32 0
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %1 = insertelement <2 x i32> %0, i32 %conv2, i32 1
  %2 = extractelement <2 x i32> %1, i32 1
  %sub = sub nsw i32 %2, %gaussianKernelRadius
  %3 = insertelement <2 x i32> undef, i32 %sub, i32 1
  br label %for.cond

for.cond:                                         ; preds = %for.inc25, %entry
  %pixel.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %pixel.1, %for.inc25 ]
  %tc.0 = phi <2 x i32> [ %3, %entry ], [ %22, %for.inc25 ]
  %j.0 = phi i32 [ 0, %entry ], [ %inc26, %for.inc25 ]
  %mul = mul nsw i32 2, %gaussianKernelRadius
  %cmp = icmp sle i32 %j.0, %mul
  br i1 %cmp, label %for.body, label %for.end28

for.body:                                         ; preds = %for.cond
  %4 = extractelement <2 x i32> %1, i32 0
  %sub4 = sub nsw i32 %4, %gaussianKernelRadius
  %5 = insertelement <2 x i32> %tc.0, i32 %sub4, i32 0
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body
  %pixel.1 = phi <4 x float> [ %pixel.0, %for.body ], [ %18, %for.inc ]
  %tc.1 = phi <2 x i32> [ %5, %for.body ], [ %20, %for.inc ]
  %i.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %mul6 = mul nsw i32 2, %gaussianKernelRadius
  %cmp7 = icmp sle i32 %i.0, %mul6
  br i1 %cmp7, label %for.body9, label %for.end

for.body9:                                        ; preds = %for.cond5
  %6 = extractelement <2 x i32> %tc.1, i32 0
  %sub10 = sub nsw i32 %width, 1
  %call11 = call cc75 i32 @_Z5clampiii(i32 %6, i32 0, i32 %sub10) #1
  %7 = insertelement <2 x i32> undef, i32 %call11, i32 0
  %8 = extractelement <2 x i32> %tc.1, i32 1
  %sub12 = sub nsw i32 %height, 1
  %call13 = call cc75 i32 @_Z5clampiii(i32 %8, i32 0, i32 %sub12) #1
  %9 = insertelement <2 x i32> %7, i32 %call13, i32 1
  %10 = extractelement <2 x i32> %9, i32 1
  %mul14 = mul nsw i32 %10, %width
  %11 = extractelement <2 x i32> %9, i32 0
  %add = add nsw i32 %mul14, %11
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom
  %12 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %call15 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %12) #1
  %13 = shufflevector <4 x float> %call15, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul16 = mul nsw i32 %gaussianKernelRadius, 2
  %add17 = add nsw i32 %mul16, 1
  %mul18 = mul nsw i32 %j.0, %add17
  %add19 = add nsw i32 %mul18, %i.0
  %idxprom20 = sext i32 %add19 to i64
  %arrayidx21 = getelementptr inbounds float addrspace(1)* %gaussianKernel, i64 %idxprom20
  %14 = load float addrspace(1)* %arrayidx21, align 4
  %15 = insertelement <3 x float> undef, float %14, i32 0
  %splat = shufflevector <3 x float> %15, <3 x float> %15, <3 x i32> zeroinitializer
  %mul22 = fmul <3 x float> %13, %splat
  %16 = shufflevector <4 x float> %pixel.1, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add23 = fadd <3 x float> %16, %mul22
  %17 = shufflevector <3 x float> %add23, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %18 = shufflevector <4 x float> %pixel.1, <4 x float> %17, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  br label %for.inc

for.inc:                                          ; preds = %for.body9
  %inc = add nsw i32 %i.0, 1
  %19 = extractelement <2 x i32> %tc.1, i32 0
  %inc24 = add nsw i32 %19, 1
  %20 = insertelement <2 x i32> %tc.1, i32 %inc24, i32 0
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc25

for.inc25:                                        ; preds = %for.end
  %inc26 = add nsw i32 %j.0, 1
  %21 = extractelement <2 x i32> %tc.1, i32 1
  %inc27 = add nsw i32 %21, 1
  %22 = insertelement <2 x i32> %tc.1, i32 %inc27, i32 1
  br label %for.cond

for.end28:                                        ; preds = %for.cond
  %23 = extractelement <2 x i32> %1, i32 1
  %mul29 = mul nsw i32 %23, %width
  %24 = extractelement <2 x i32> %1, i32 0
  %add30 = add nsw i32 %mul29, %24
  %idxprom31 = sext i32 %add30 to i64
  %arrayidx32 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom31
  %25 = load <4 x i8> addrspace(1)* %arrayidx32, align 4
  %call33 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %25) #1
  %26 = extractelement <4 x float> %call33, i32 0
  %27 = extractelement <4 x float> %pixel.0, i32 0
  %sub34 = fsub float %26, %27
  %call35 = call cc75 float @_Z4fabsf(float %sub34) #1
  %cmp36 = fcmp ogt float %call35, %threshold
  br i1 %cmp36, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.end28
  %mul38 = fmul float %sub34, %amount
  br label %cond.end

cond.false:                                       ; preds = %for.end28
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %mul38, %cond.true ], [ 0.000000e+00, %cond.false ]
  %28 = extractelement <4 x float> %call33, i32 0
  %add39 = fadd float %28, %cond
  %29 = insertelement <4 x float> %call33, float %add39, i32 0
  %30 = extractelement <4 x float> %29, i32 1
  %31 = extractelement <4 x float> %pixel.0, i32 1
  %sub40 = fsub float %30, %31
  %call41 = call cc75 float @_Z4fabsf(float %sub40) #1
  %cmp42 = fcmp ogt float %call41, %threshold
  br i1 %cmp42, label %cond.true44, label %cond.false46

cond.true44:                                      ; preds = %cond.end
  %mul45 = fmul float %sub40, %amount
  br label %cond.end47

cond.false46:                                     ; preds = %cond.end
  br label %cond.end47

cond.end47:                                       ; preds = %cond.false46, %cond.true44
  %cond48 = phi float [ %mul45, %cond.true44 ], [ 0.000000e+00, %cond.false46 ]
  %32 = extractelement <4 x float> %29, i32 1
  %add49 = fadd float %32, %cond48
  %33 = insertelement <4 x float> %29, float %add49, i32 1
  %34 = extractelement <4 x float> %33, i32 2
  %35 = extractelement <4 x float> %pixel.0, i32 2
  %sub50 = fsub float %34, %35
  %call51 = call cc75 float @_Z4fabsf(float %sub50) #1
  %cmp52 = fcmp ogt float %call51, %threshold
  br i1 %cmp52, label %cond.true54, label %cond.false56

cond.true54:                                      ; preds = %cond.end47
  %mul55 = fmul float %sub50, %amount
  br label %cond.end57

cond.false56:                                     ; preds = %cond.end47
  br label %cond.end57

cond.end57:                                       ; preds = %cond.false56, %cond.true54
  %cond58 = phi float [ %mul55, %cond.true54 ], [ 0.000000e+00, %cond.false56 ]
  %36 = extractelement <4 x float> %33, i32 2
  %add59 = fadd float %36, %cond58
  %37 = insertelement <4 x float> %33, float %add59, i32 2
  %add60 = fadd <4 x float> %37, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %call61 = call cc75 <4 x float> @_Z5clampDv4_fS_S_(<4 x float> %add60, <4 x float> zeroinitializer, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>) #1
  %call62 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %call61) #1
  %38 = extractelement <2 x i32> %1, i32 1
  %mul63 = mul nsw i32 %38, %width
  %39 = extractelement <2 x i32> %1, i32 0
  %add64 = add nsw i32 %mul63, %39
  %idxprom65 = sext i32 %add64 to i64
  %arrayidx66 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %idxprom65
  store <4 x i8> %call62, <4 x i8> addrspace(1)* %arrayidx66, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float>) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !12, !18}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!24}
!opencl.spir.version = !{!24}

!0 = metadata !{void (%opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*, float addrspace(1)*, i32, float, float)* @__OpenCL_unsharp_mask_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"read_only", metadata !"write_only", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"image2d_t", metadata !"image2d_t", metadata !"float*", metadata !"int", metadata !"float", metadata !"float"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"image2d_t", metadata !"image2d_t", metadata !"float*", metadata !"int", metadata !"float", metadata !"float"}
!6 = metadata !{void (%opencl.image2d_t addrspace(1)*, <4 x float> addrspace(1)*, i32, float addrspace(1)*, i32)* @__OpenCL_unsharp_mask_pass1_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 1, i32 0}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"read_only", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"image2d_t", metadata !"float4*", metadata !"int", metadata !"float*", metadata !"int"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"image2d_t", metadata !"float4*", metadata !"int", metadata !"float*", metadata !"int"}
!12 = metadata !{void (%opencl.image2d_t addrspace(1)*, <4 x float> addrspace(1)*, %opencl.image2d_t addrspace(1)*, i32, i32, float addrspace(1)*, i32, float, float)* @__OpenCL_unsharp_mask_pass2_kernel, metadata !13, metadata !14, metadata !15, metadata !16, metadata !17}
!13 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 0, i32 0}
!14 = metadata !{metadata !"kernel_arg_access_qual", metadata !"read_only", metadata !"none", metadata !"write_only", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!15 = metadata !{metadata !"kernel_arg_type", metadata !"image2d_t", metadata !"float4*", metadata !"image2d_t", metadata !"int", metadata !"int", metadata !"float*", metadata !"int", metadata !"float", metadata !"float"}
!16 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!17 = metadata !{metadata !"kernel_arg_base_type", metadata !"image2d_t", metadata !"float4*", metadata !"image2d_t", metadata !"int", metadata !"int", metadata !"float*", metadata !"int", metadata !"float", metadata !"float"}
!18 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, i32, float addrspace(1)*, i32, float, float)* @__OpenCL_unsharp_mask_filter_kernel, metadata !19, metadata !20, metadata !21, metadata !22, metadata !23}
!19 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 0, i32 0}
!20 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!21 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int", metadata !"int", metadata !"float*", metadata !"int", metadata !"float", metadata !"float"}
!22 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!23 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int", metadata !"int", metadata !"float*", metadata !"int", metadata !"float", metadata !"float"}
!24 = metadata !{i32 1, i32 2}

; ModuleID = 'UnsharpMask_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

@imageSampler = addrspace(2) constant i32 34, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_unsharp_mask_kernel(%opencl.image2d_t addrspace(1)* %input, %opencl.image2d_t addrspace(1)* %output, float addrspace(1)* %gaussianKernel, i32 %gaussianKernelRadius, float %threshold, float %amount) #0 {
entry:
  %input.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %output.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %gaussianKernel.addr = alloca float addrspace(1)*, align 8
  %gaussianKernelRadius.addr = alloca i32, align 4
  %threshold.addr = alloca float, align 4
  %amount.addr = alloca float, align 4
  %coords = alloca <2 x i32>, align 8
  %pixel = alloca <4 x float>, align 16
  %tc = alloca <2 x i32>, align 8
  %j = alloca i32, align 4
  %i = alloca i32, align 4
  %tPixel = alloca <4 x float>, align 16
  %currentPixel = alloca <4 x float>, align 16
  %diffx = alloca float, align 4
  %diffy = alloca float, align 4
  %diffz = alloca float, align 4
  store %opencl.image2d_t addrspace(1)* %input, %opencl.image2d_t addrspace(1)** %input.addr, align 8
  store %opencl.image2d_t addrspace(1)* %output, %opencl.image2d_t addrspace(1)** %output.addr, align 8
  store float addrspace(1)* %gaussianKernel, float addrspace(1)** %gaussianKernel.addr, align 8
  store i32 %gaussianKernelRadius, i32* %gaussianKernelRadius.addr, align 4
  store float %threshold, float* %threshold.addr, align 4
  store float %amount, float* %amount.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %0 = load <2 x i32>* %coords, align 8
  %1 = insertelement <2 x i32> %0, i32 %conv, i32 0
  store <2 x i32> %1, <2 x i32>* %coords, align 8
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %2 = load <2 x i32>* %coords, align 8
  %3 = insertelement <2 x i32> %2, i32 %conv2, i32 1
  store <2 x i32> %3, <2 x i32>* %coords, align 8
  store <4 x float> zeroinitializer, <4 x float>* %pixel, align 16
  %4 = load <2 x i32>* %coords, align 8
  %5 = extractelement <2 x i32> %4, i32 1
  %6 = load i32* %gaussianKernelRadius.addr, align 4
  %sub = sub nsw i32 %5, %6
  %7 = load <2 x i32>* %tc, align 8
  %8 = insertelement <2 x i32> %7, i32 %sub, i32 1
  store <2 x i32> %8, <2 x i32>* %tc, align 8
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc18, %entry
  %9 = load i32* %j, align 4
  %10 = load i32* %gaussianKernelRadius.addr, align 4
  %mul = mul nsw i32 2, %10
  %cmp = icmp sle i32 %9, %mul
  br i1 %cmp, label %for.body, label %for.end21

for.body:                                         ; preds = %for.cond
  %11 = load <2 x i32>* %coords, align 8
  %12 = extractelement <2 x i32> %11, i32 0
  %13 = load i32* %gaussianKernelRadius.addr, align 4
  %sub4 = sub nsw i32 %12, %13
  %14 = load <2 x i32>* %tc, align 8
  %15 = insertelement <2 x i32> %14, i32 %sub4, i32 0
  store <2 x i32> %15, <2 x i32>* %tc, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body
  %16 = load i32* %i, align 4
  %17 = load i32* %gaussianKernelRadius.addr, align 4
  %mul6 = mul nsw i32 2, %17
  %cmp7 = icmp sle i32 %16, %mul6
  br i1 %cmp7, label %for.body9, label %for.end

for.body9:                                        ; preds = %for.cond5
  %18 = load %opencl.image2d_t addrspace(1)** %input.addr, align 8
  %19 = load i32 addrspace(2)* @imageSampler, align 4
  %20 = load <2 x i32>* %tc, align 8
  %call10 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %18, i32 %19, <2 x i32> %20) #1
  %call11 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call10) #1
  store <4 x float> %call11, <4 x float>* %tPixel, align 16
  %21 = load <4 x float>* %tPixel, align 16
  %22 = shufflevector <4 x float> %21, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %23 = load i32* %j, align 4
  %24 = load i32* %gaussianKernelRadius.addr, align 4
  %mul12 = mul nsw i32 %24, 2
  %add = add nsw i32 %mul12, 1
  %mul13 = mul nsw i32 %23, %add
  %25 = load i32* %i, align 4
  %add14 = add nsw i32 %mul13, %25
  %idxprom = sext i32 %add14 to i64
  %26 = load float addrspace(1)** %gaussianKernel.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %26, i64 %idxprom
  %27 = load float addrspace(1)* %arrayidx, align 4
  %28 = insertelement <3 x float> undef, float %27, i32 0
  %splat = shufflevector <3 x float> %28, <3 x float> %28, <3 x i32> zeroinitializer
  %mul15 = fmul <3 x float> %22, %splat
  %29 = load <4 x float>* %pixel, align 16
  %30 = shufflevector <4 x float> %29, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add16 = fadd <3 x float> %30, %mul15
  %31 = load <4 x float>* %pixel, align 16
  %32 = shufflevector <3 x float> %add16, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %33 = shufflevector <4 x float> %31, <4 x float> %32, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %33, <4 x float>* %pixel, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body9
  %34 = load i32* %i, align 4
  %inc = add nsw i32 %34, 1
  store i32 %inc, i32* %i, align 4
  %35 = load <2 x i32>* %tc, align 8
  %36 = extractelement <2 x i32> %35, i32 0
  %inc17 = add nsw i32 %36, 1
  %37 = load <2 x i32>* %tc, align 8
  %38 = insertelement <2 x i32> %37, i32 %inc17, i32 0
  store <2 x i32> %38, <2 x i32>* %tc, align 8
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc18

for.inc18:                                        ; preds = %for.end
  %39 = load i32* %j, align 4
  %inc19 = add nsw i32 %39, 1
  store i32 %inc19, i32* %j, align 4
  %40 = load <2 x i32>* %tc, align 8
  %41 = extractelement <2 x i32> %40, i32 1
  %inc20 = add nsw i32 %41, 1
  %42 = load <2 x i32>* %tc, align 8
  %43 = insertelement <2 x i32> %42, i32 %inc20, i32 1
  store <2 x i32> %43, <2 x i32>* %tc, align 8
  br label %for.cond

for.end21:                                        ; preds = %for.cond
  %44 = load %opencl.image2d_t addrspace(1)** %input.addr, align 8
  %45 = load i32 addrspace(2)* @imageSampler, align 4
  %46 = load <2 x i32>* %coords, align 8
  %call22 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %44, i32 %45, <2 x i32> %46) #1
  %call23 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call22) #1
  store <4 x float> %call23, <4 x float>* %currentPixel, align 16
  %47 = load <4 x float>* %currentPixel, align 16
  %48 = extractelement <4 x float> %47, i32 0
  %49 = load <4 x float>* %pixel, align 16
  %50 = extractelement <4 x float> %49, i32 0
  %sub24 = fsub float %48, %50
  store float %sub24, float* %diffx, align 4
  %51 = load float* %diffx, align 4
  %call25 = call cc75 float @_Z4fabsf(float %51) #1
  %52 = load float* %threshold.addr, align 4
  %cmp26 = fcmp ogt float %call25, %52
  br i1 %cmp26, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.end21
  %53 = load float* %diffx, align 4
  %54 = load float* %amount.addr, align 4
  %mul28 = fmul float %53, %54
  br label %cond.end

cond.false:                                       ; preds = %for.end21
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %mul28, %cond.true ], [ 0.000000e+00, %cond.false ]
  %55 = load <4 x float>* %currentPixel, align 16
  %56 = extractelement <4 x float> %55, i32 0
  %add29 = fadd float %56, %cond
  %57 = load <4 x float>* %currentPixel, align 16
  %58 = insertelement <4 x float> %57, float %add29, i32 0
  store <4 x float> %58, <4 x float>* %currentPixel, align 16
  %59 = load <4 x float>* %currentPixel, align 16
  %60 = extractelement <4 x float> %59, i32 1
  %61 = load <4 x float>* %pixel, align 16
  %62 = extractelement <4 x float> %61, i32 1
  %sub30 = fsub float %60, %62
  store float %sub30, float* %diffy, align 4
  %63 = load float* %diffy, align 4
  %call31 = call cc75 float @_Z4fabsf(float %63) #1
  %64 = load float* %threshold.addr, align 4
  %cmp32 = fcmp ogt float %call31, %64
  br i1 %cmp32, label %cond.true34, label %cond.false36

cond.true34:                                      ; preds = %cond.end
  %65 = load float* %diffy, align 4
  %66 = load float* %amount.addr, align 4
  %mul35 = fmul float %65, %66
  br label %cond.end37

cond.false36:                                     ; preds = %cond.end
  br label %cond.end37

cond.end37:                                       ; preds = %cond.false36, %cond.true34
  %cond38 = phi float [ %mul35, %cond.true34 ], [ 0.000000e+00, %cond.false36 ]
  %67 = load <4 x float>* %currentPixel, align 16
  %68 = extractelement <4 x float> %67, i32 1
  %add39 = fadd float %68, %cond38
  %69 = load <4 x float>* %currentPixel, align 16
  %70 = insertelement <4 x float> %69, float %add39, i32 1
  store <4 x float> %70, <4 x float>* %currentPixel, align 16
  %71 = load <4 x float>* %currentPixel, align 16
  %72 = extractelement <4 x float> %71, i32 2
  %73 = load <4 x float>* %pixel, align 16
  %74 = extractelement <4 x float> %73, i32 2
  %sub40 = fsub float %72, %74
  store float %sub40, float* %diffz, align 4
  %75 = load float* %diffz, align 4
  %call41 = call cc75 float @_Z4fabsf(float %75) #1
  %76 = load float* %threshold.addr, align 4
  %cmp42 = fcmp ogt float %call41, %76
  br i1 %cmp42, label %cond.true44, label %cond.false46

cond.true44:                                      ; preds = %cond.end37
  %77 = load float* %diffz, align 4
  %78 = load float* %amount.addr, align 4
  %mul45 = fmul float %77, %78
  br label %cond.end47

cond.false46:                                     ; preds = %cond.end37
  br label %cond.end47

cond.end47:                                       ; preds = %cond.false46, %cond.true44
  %cond48 = phi float [ %mul45, %cond.true44 ], [ 0.000000e+00, %cond.false46 ]
  %79 = load <4 x float>* %currentPixel, align 16
  %80 = extractelement <4 x float> %79, i32 2
  %add49 = fadd float %80, %cond48
  %81 = load <4 x float>* %currentPixel, align 16
  %82 = insertelement <4 x float> %81, float %add49, i32 2
  store <4 x float> %82, <4 x float>* %currentPixel, align 16
  %83 = load <4 x float>* %currentPixel, align 16
  %add50 = fadd <4 x float> %83, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %call51 = call cc75 <4 x float> @_Z5clampDv4_fS_S_(<4 x float> %add50, <4 x float> zeroinitializer, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>) #1
  store <4 x float> %call51, <4 x float>* %currentPixel, align 16
  %84 = load %opencl.image2d_t addrspace(1)** %output.addr, align 8
  %85 = load <2 x i32>* %coords, align 8
  %86 = load <4 x float>* %currentPixel, align 16
  %call52 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_f(<4 x float> %86) #1
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %84, <2 x i32> %85, <4 x i32> %call52)
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
  %input.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %temp.addr = alloca <4 x float> addrspace(1)*, align 8
  %width.addr = alloca i32, align 4
  %gaussianKernel.addr = alloca float addrspace(1)*, align 8
  %gaussianKernelRadius.addr = alloca i32, align 4
  %coords = alloca <2 x i32>, align 8
  %pixel = alloca <4 x float>, align 16
  %tc = alloca <2 x i32>, align 8
  %i = alloca i32, align 4
  %tPixel = alloca <4 x float>, align 16
  store %opencl.image2d_t addrspace(1)* %input, %opencl.image2d_t addrspace(1)** %input.addr, align 8
  store <4 x float> addrspace(1)* %temp, <4 x float> addrspace(1)** %temp.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store float addrspace(1)* %gaussianKernel, float addrspace(1)** %gaussianKernel.addr, align 8
  store i32 %gaussianKernelRadius, i32* %gaussianKernelRadius.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %0 = load <2 x i32>* %coords, align 8
  %1 = insertelement <2 x i32> %0, i32 %conv, i32 0
  store <2 x i32> %1, <2 x i32>* %coords, align 8
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %2 = load <2 x i32>* %coords, align 8
  %3 = insertelement <2 x i32> %2, i32 %conv2, i32 1
  store <2 x i32> %3, <2 x i32>* %coords, align 8
  store <4 x float> zeroinitializer, <4 x float>* %pixel, align 16
  %4 = load <2 x i32>* %coords, align 8
  %5 = extractelement <2 x i32> %4, i32 1
  %6 = load <2 x i32>* %tc, align 8
  %7 = insertelement <2 x i32> %6, i32 %5, i32 1
  store <2 x i32> %7, <2 x i32>* %tc, align 8
  %8 = load <2 x i32>* %coords, align 8
  %9 = extractelement <2 x i32> %8, i32 0
  %10 = load i32* %gaussianKernelRadius.addr, align 4
  %sub = sub nsw i32 %9, %10
  %11 = load <2 x i32>* %tc, align 8
  %12 = insertelement <2 x i32> %11, i32 %sub, i32 0
  store <2 x i32> %12, <2 x i32>* %tc, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %13 = load i32* %i, align 4
  %14 = load i32* %gaussianKernelRadius.addr, align 4
  %mul = mul nsw i32 2, %14
  %cmp = icmp sle i32 %13, %mul
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %15 = load %opencl.image2d_t addrspace(1)** %input.addr, align 8
  %16 = load i32 addrspace(2)* @imageSampler, align 4
  %17 = load <2 x i32>* %tc, align 8
  %call4 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %15, i32 %16, <2 x i32> %17) #1
  %call5 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call4) #1
  store <4 x float> %call5, <4 x float>* %tPixel, align 16
  %18 = load <4 x float>* %tPixel, align 16
  %19 = shufflevector <4 x float> %18, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %20 = load i32* %i, align 4
  %idxprom = sext i32 %20 to i64
  %21 = load float addrspace(1)** %gaussianKernel.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %21, i64 %idxprom
  %22 = load float addrspace(1)* %arrayidx, align 4
  %23 = insertelement <3 x float> undef, float %22, i32 0
  %splat = shufflevector <3 x float> %23, <3 x float> %23, <3 x i32> zeroinitializer
  %mul6 = fmul <3 x float> %19, %splat
  %24 = load <4 x float>* %pixel, align 16
  %25 = shufflevector <4 x float> %24, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add = fadd <3 x float> %25, %mul6
  %26 = load <4 x float>* %pixel, align 16
  %27 = shufflevector <3 x float> %add, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %28 = shufflevector <4 x float> %26, <4 x float> %27, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %28, <4 x float>* %pixel, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %29 = load i32* %i, align 4
  %inc = add nsw i32 %29, 1
  store i32 %inc, i32* %i, align 4
  %30 = load <2 x i32>* %tc, align 8
  %31 = extractelement <2 x i32> %30, i32 0
  %inc7 = add nsw i32 %31, 1
  %32 = load <2 x i32>* %tc, align 8
  %33 = insertelement <2 x i32> %32, i32 %inc7, i32 0
  store <2 x i32> %33, <2 x i32>* %tc, align 8
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %34 = load <4 x float>* %pixel, align 16
  %35 = load <2 x i32>* %coords, align 8
  %36 = extractelement <2 x i32> %35, i32 1
  %37 = load i32* %width.addr, align 4
  %mul8 = mul nsw i32 %36, %37
  %38 = load <2 x i32>* %coords, align 8
  %39 = extractelement <2 x i32> %38, i32 0
  %add9 = add nsw i32 %mul8, %39
  %idxprom10 = sext i32 %add9 to i64
  %40 = load <4 x float> addrspace(1)** %temp.addr, align 8
  %arrayidx11 = getelementptr inbounds <4 x float> addrspace(1)* %40, i64 %idxprom10
  store <4 x float> %34, <4 x float> addrspace(1)* %arrayidx11, align 16
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_unsharp_mask_pass2_kernel(%opencl.image2d_t addrspace(1)* %input, <4 x float> addrspace(1)* %temp, %opencl.image2d_t addrspace(1)* %output, i32 %width, i32 %height, float addrspace(1)* %gaussianKernel, i32 %gaussianKernelRadius, float %threshold, float %amount) #0 {
entry:
  %input.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %temp.addr = alloca <4 x float> addrspace(1)*, align 8
  %output.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %width.addr = alloca i32, align 4
  %height.addr = alloca i32, align 4
  %gaussianKernel.addr = alloca float addrspace(1)*, align 8
  %gaussianKernelRadius.addr = alloca i32, align 4
  %threshold.addr = alloca float, align 4
  %amount.addr = alloca float, align 4
  %coords = alloca <2 x i32>, align 8
  %pixel = alloca <4 x float>, align 16
  %tc = alloca <2 x i32>, align 8
  %i = alloca i32, align 4
  %clamped_tc = alloca <2 x i32>, align 8
  %tPixel = alloca <4 x float>, align 16
  %currentPixel = alloca <4 x float>, align 16
  %diffx = alloca float, align 4
  %diffy = alloca float, align 4
  %diffz = alloca float, align 4
  store %opencl.image2d_t addrspace(1)* %input, %opencl.image2d_t addrspace(1)** %input.addr, align 8
  store <4 x float> addrspace(1)* %temp, <4 x float> addrspace(1)** %temp.addr, align 8
  store %opencl.image2d_t addrspace(1)* %output, %opencl.image2d_t addrspace(1)** %output.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store i32 %height, i32* %height.addr, align 4
  store float addrspace(1)* %gaussianKernel, float addrspace(1)** %gaussianKernel.addr, align 8
  store i32 %gaussianKernelRadius, i32* %gaussianKernelRadius.addr, align 4
  store float %threshold, float* %threshold.addr, align 4
  store float %amount, float* %amount.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %0 = load <2 x i32>* %coords, align 8
  %1 = insertelement <2 x i32> %0, i32 %conv, i32 0
  store <2 x i32> %1, <2 x i32>* %coords, align 8
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %2 = load <2 x i32>* %coords, align 8
  %3 = insertelement <2 x i32> %2, i32 %conv2, i32 1
  store <2 x i32> %3, <2 x i32>* %coords, align 8
  store <4 x float> zeroinitializer, <4 x float>* %pixel, align 16
  %4 = load <2 x i32>* %coords, align 8
  %5 = extractelement <2 x i32> %4, i32 1
  %6 = load i32* %gaussianKernelRadius.addr, align 4
  %sub = sub nsw i32 %5, %6
  %7 = load <2 x i32>* %tc, align 8
  %8 = insertelement <2 x i32> %7, i32 %sub, i32 1
  store <2 x i32> %8, <2 x i32>* %tc, align 8
  %9 = load <2 x i32>* %coords, align 8
  %10 = extractelement <2 x i32> %9, i32 0
  %11 = load <2 x i32>* %tc, align 8
  %12 = insertelement <2 x i32> %11, i32 %10, i32 0
  store <2 x i32> %12, <2 x i32>* %tc, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %13 = load i32* %i, align 4
  %14 = load i32* %gaussianKernelRadius.addr, align 4
  %mul = mul nsw i32 2, %14
  %cmp = icmp sle i32 %13, %mul
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %15 = load <2 x i32>* %tc, align 8
  %16 = extractelement <2 x i32> %15, i32 0
  %17 = load <2 x i32>* %clamped_tc, align 8
  %18 = insertelement <2 x i32> %17, i32 %16, i32 0
  store <2 x i32> %18, <2 x i32>* %clamped_tc, align 8
  %19 = load <2 x i32>* %tc, align 8
  %20 = extractelement <2 x i32> %19, i32 1
  %21 = load i32* %height.addr, align 4
  %sub4 = sub nsw i32 %21, 1
  %call5 = call cc75 i32 @_Z5clampiii(i32 %20, i32 0, i32 %sub4) #1
  %22 = load <2 x i32>* %clamped_tc, align 8
  %23 = insertelement <2 x i32> %22, i32 %call5, i32 1
  store <2 x i32> %23, <2 x i32>* %clamped_tc, align 8
  %24 = load <2 x i32>* %clamped_tc, align 8
  %25 = extractelement <2 x i32> %24, i32 1
  %26 = load i32* %width.addr, align 4
  %mul6 = mul nsw i32 %25, %26
  %27 = load <2 x i32>* %clamped_tc, align 8
  %28 = extractelement <2 x i32> %27, i32 0
  %add = add nsw i32 %mul6, %28
  %idxprom = sext i32 %add to i64
  %29 = load <4 x float> addrspace(1)** %temp.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %29, i64 %idxprom
  %30 = load <4 x float> addrspace(1)* %arrayidx, align 16
  store <4 x float> %30, <4 x float>* %tPixel, align 16
  %31 = load <4 x float>* %tPixel, align 16
  %32 = shufflevector <4 x float> %31, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %33 = load i32* %i, align 4
  %idxprom7 = sext i32 %33 to i64
  %34 = load float addrspace(1)** %gaussianKernel.addr, align 8
  %arrayidx8 = getelementptr inbounds float addrspace(1)* %34, i64 %idxprom7
  %35 = load float addrspace(1)* %arrayidx8, align 4
  %36 = insertelement <3 x float> undef, float %35, i32 0
  %splat = shufflevector <3 x float> %36, <3 x float> %36, <3 x i32> zeroinitializer
  %mul9 = fmul <3 x float> %32, %splat
  %37 = load <4 x float>* %pixel, align 16
  %38 = shufflevector <4 x float> %37, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add10 = fadd <3 x float> %38, %mul9
  %39 = load <4 x float>* %pixel, align 16
  %40 = shufflevector <3 x float> %add10, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %41 = shufflevector <4 x float> %39, <4 x float> %40, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %41, <4 x float>* %pixel, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %42 = load i32* %i, align 4
  %inc = add nsw i32 %42, 1
  store i32 %inc, i32* %i, align 4
  %43 = load <2 x i32>* %tc, align 8
  %44 = extractelement <2 x i32> %43, i32 1
  %inc11 = add nsw i32 %44, 1
  %45 = load <2 x i32>* %tc, align 8
  %46 = insertelement <2 x i32> %45, i32 %inc11, i32 1
  store <2 x i32> %46, <2 x i32>* %tc, align 8
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %47 = load %opencl.image2d_t addrspace(1)** %input.addr, align 8
  %48 = load i32 addrspace(2)* @imageSampler, align 4
  %49 = load <2 x i32>* %coords, align 8
  %call12 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %47, i32 %48, <2 x i32> %49) #1
  %call13 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %call12) #1
  store <4 x float> %call13, <4 x float>* %currentPixel, align 16
  %50 = load <4 x float>* %currentPixel, align 16
  %51 = extractelement <4 x float> %50, i32 0
  %52 = load <4 x float>* %pixel, align 16
  %53 = extractelement <4 x float> %52, i32 0
  %sub14 = fsub float %51, %53
  store float %sub14, float* %diffx, align 4
  %54 = load float* %diffx, align 4
  %call15 = call cc75 float @_Z4fabsf(float %54) #1
  %55 = load float* %threshold.addr, align 4
  %cmp16 = fcmp ogt float %call15, %55
  br i1 %cmp16, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.end
  %56 = load float* %diffx, align 4
  %57 = load float* %amount.addr, align 4
  %mul18 = fmul float %56, %57
  br label %cond.end

cond.false:                                       ; preds = %for.end
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %mul18, %cond.true ], [ 0.000000e+00, %cond.false ]
  %58 = load <4 x float>* %currentPixel, align 16
  %59 = extractelement <4 x float> %58, i32 0
  %add19 = fadd float %59, %cond
  %60 = load <4 x float>* %currentPixel, align 16
  %61 = insertelement <4 x float> %60, float %add19, i32 0
  store <4 x float> %61, <4 x float>* %currentPixel, align 16
  %62 = load <4 x float>* %currentPixel, align 16
  %63 = extractelement <4 x float> %62, i32 1
  %64 = load <4 x float>* %pixel, align 16
  %65 = extractelement <4 x float> %64, i32 1
  %sub20 = fsub float %63, %65
  store float %sub20, float* %diffy, align 4
  %66 = load float* %diffy, align 4
  %call21 = call cc75 float @_Z4fabsf(float %66) #1
  %67 = load float* %threshold.addr, align 4
  %cmp22 = fcmp ogt float %call21, %67
  br i1 %cmp22, label %cond.true24, label %cond.false26

cond.true24:                                      ; preds = %cond.end
  %68 = load float* %diffy, align 4
  %69 = load float* %amount.addr, align 4
  %mul25 = fmul float %68, %69
  br label %cond.end27

cond.false26:                                     ; preds = %cond.end
  br label %cond.end27

cond.end27:                                       ; preds = %cond.false26, %cond.true24
  %cond28 = phi float [ %mul25, %cond.true24 ], [ 0.000000e+00, %cond.false26 ]
  %70 = load <4 x float>* %currentPixel, align 16
  %71 = extractelement <4 x float> %70, i32 1
  %add29 = fadd float %71, %cond28
  %72 = load <4 x float>* %currentPixel, align 16
  %73 = insertelement <4 x float> %72, float %add29, i32 1
  store <4 x float> %73, <4 x float>* %currentPixel, align 16
  %74 = load <4 x float>* %currentPixel, align 16
  %75 = extractelement <4 x float> %74, i32 2
  %76 = load <4 x float>* %pixel, align 16
  %77 = extractelement <4 x float> %76, i32 2
  %sub30 = fsub float %75, %77
  store float %sub30, float* %diffz, align 4
  %78 = load float* %diffz, align 4
  %call31 = call cc75 float @_Z4fabsf(float %78) #1
  %79 = load float* %threshold.addr, align 4
  %cmp32 = fcmp ogt float %call31, %79
  br i1 %cmp32, label %cond.true34, label %cond.false36

cond.true34:                                      ; preds = %cond.end27
  %80 = load float* %diffz, align 4
  %81 = load float* %amount.addr, align 4
  %mul35 = fmul float %80, %81
  br label %cond.end37

cond.false36:                                     ; preds = %cond.end27
  br label %cond.end37

cond.end37:                                       ; preds = %cond.false36, %cond.true34
  %cond38 = phi float [ %mul35, %cond.true34 ], [ 0.000000e+00, %cond.false36 ]
  %82 = load <4 x float>* %currentPixel, align 16
  %83 = extractelement <4 x float> %82, i32 2
  %add39 = fadd float %83, %cond38
  %84 = load <4 x float>* %currentPixel, align 16
  %85 = insertelement <4 x float> %84, float %add39, i32 2
  store <4 x float> %85, <4 x float>* %currentPixel, align 16
  %86 = load <4 x float>* %currentPixel, align 16
  %add40 = fadd <4 x float> %86, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %call41 = call cc75 <4 x float> @_Z5clampDv4_fS_S_(<4 x float> %add40, <4 x float> zeroinitializer, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>) #1
  store <4 x float> %call41, <4 x float>* %currentPixel, align 16
  %87 = load %opencl.image2d_t addrspace(1)** %output.addr, align 8
  %88 = load <2 x i32>* %coords, align 8
  %89 = load <4 x float>* %currentPixel, align 16
  %call42 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_f(<4 x float> %89) #1
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %87, <2 x i32> %88, <4 x i32> %call42)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i32 @_Z5clampiii(i32, i32, i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_unsharp_mask_filter_kernel(<4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)* %output, i32 %width, i32 %height, float addrspace(1)* %gaussianKernel, i32 %gaussianKernelRadius, float %threshold, float %amount) #0 {
entry:
  %input.addr = alloca <4 x i8> addrspace(1)*, align 8
  %output.addr = alloca <4 x i8> addrspace(1)*, align 8
  %width.addr = alloca i32, align 4
  %height.addr = alloca i32, align 4
  %gaussianKernel.addr = alloca float addrspace(1)*, align 8
  %gaussianKernelRadius.addr = alloca i32, align 4
  %threshold.addr = alloca float, align 4
  %amount.addr = alloca float, align 4
  %coords = alloca <2 x i32>, align 8
  %pixel = alloca <4 x float>, align 16
  %tc = alloca <2 x i32>, align 8
  %j = alloca i32, align 4
  %i = alloca i32, align 4
  %clamped_tc = alloca <2 x i32>, align 8
  %tPixel = alloca <4 x float>, align 16
  %currentPixel = alloca <4 x float>, align 16
  %diffx = alloca float, align 4
  %diffy = alloca float, align 4
  %diffz = alloca float, align 4
  store <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)** %input.addr, align 8
  store <4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)** %output.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store i32 %height, i32* %height.addr, align 4
  store float addrspace(1)* %gaussianKernel, float addrspace(1)** %gaussianKernel.addr, align 8
  store i32 %gaussianKernelRadius, i32* %gaussianKernelRadius.addr, align 4
  store float %threshold, float* %threshold.addr, align 4
  store float %amount, float* %amount.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %0 = load <2 x i32>* %coords, align 8
  %1 = insertelement <2 x i32> %0, i32 %conv, i32 0
  store <2 x i32> %1, <2 x i32>* %coords, align 8
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %2 = load <2 x i32>* %coords, align 8
  %3 = insertelement <2 x i32> %2, i32 %conv2, i32 1
  store <2 x i32> %3, <2 x i32>* %coords, align 8
  store <4 x float> zeroinitializer, <4 x float>* %pixel, align 16
  %4 = load <2 x i32>* %coords, align 8
  %5 = extractelement <2 x i32> %4, i32 1
  %6 = load i32* %gaussianKernelRadius.addr, align 4
  %sub = sub nsw i32 %5, %6
  %7 = load <2 x i32>* %tc, align 8
  %8 = insertelement <2 x i32> %7, i32 %sub, i32 1
  store <2 x i32> %8, <2 x i32>* %tc, align 8
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc25, %entry
  %9 = load i32* %j, align 4
  %10 = load i32* %gaussianKernelRadius.addr, align 4
  %mul = mul nsw i32 2, %10
  %cmp = icmp sle i32 %9, %mul
  br i1 %cmp, label %for.body, label %for.end28

for.body:                                         ; preds = %for.cond
  %11 = load <2 x i32>* %coords, align 8
  %12 = extractelement <2 x i32> %11, i32 0
  %13 = load i32* %gaussianKernelRadius.addr, align 4
  %sub4 = sub nsw i32 %12, %13
  %14 = load <2 x i32>* %tc, align 8
  %15 = insertelement <2 x i32> %14, i32 %sub4, i32 0
  store <2 x i32> %15, <2 x i32>* %tc, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body
  %16 = load i32* %i, align 4
  %17 = load i32* %gaussianKernelRadius.addr, align 4
  %mul6 = mul nsw i32 2, %17
  %cmp7 = icmp sle i32 %16, %mul6
  br i1 %cmp7, label %for.body9, label %for.end

for.body9:                                        ; preds = %for.cond5
  %18 = load <2 x i32>* %tc, align 8
  %19 = extractelement <2 x i32> %18, i32 0
  %20 = load i32* %width.addr, align 4
  %sub10 = sub nsw i32 %20, 1
  %call11 = call cc75 i32 @_Z5clampiii(i32 %19, i32 0, i32 %sub10) #1
  %21 = load <2 x i32>* %clamped_tc, align 8
  %22 = insertelement <2 x i32> %21, i32 %call11, i32 0
  store <2 x i32> %22, <2 x i32>* %clamped_tc, align 8
  %23 = load <2 x i32>* %tc, align 8
  %24 = extractelement <2 x i32> %23, i32 1
  %25 = load i32* %height.addr, align 4
  %sub12 = sub nsw i32 %25, 1
  %call13 = call cc75 i32 @_Z5clampiii(i32 %24, i32 0, i32 %sub12) #1
  %26 = load <2 x i32>* %clamped_tc, align 8
  %27 = insertelement <2 x i32> %26, i32 %call13, i32 1
  store <2 x i32> %27, <2 x i32>* %clamped_tc, align 8
  %28 = load <2 x i32>* %clamped_tc, align 8
  %29 = extractelement <2 x i32> %28, i32 1
  %30 = load i32* %width.addr, align 4
  %mul14 = mul nsw i32 %29, %30
  %31 = load <2 x i32>* %clamped_tc, align 8
  %32 = extractelement <2 x i32> %31, i32 0
  %add = add nsw i32 %mul14, %32
  %idxprom = sext i32 %add to i64
  %33 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %33, i64 %idxprom
  %34 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %call15 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %34) #1
  store <4 x float> %call15, <4 x float>* %tPixel, align 16
  %35 = load <4 x float>* %tPixel, align 16
  %36 = shufflevector <4 x float> %35, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %37 = load i32* %j, align 4
  %38 = load i32* %gaussianKernelRadius.addr, align 4
  %mul16 = mul nsw i32 %38, 2
  %add17 = add nsw i32 %mul16, 1
  %mul18 = mul nsw i32 %37, %add17
  %39 = load i32* %i, align 4
  %add19 = add nsw i32 %mul18, %39
  %idxprom20 = sext i32 %add19 to i64
  %40 = load float addrspace(1)** %gaussianKernel.addr, align 8
  %arrayidx21 = getelementptr inbounds float addrspace(1)* %40, i64 %idxprom20
  %41 = load float addrspace(1)* %arrayidx21, align 4
  %42 = insertelement <3 x float> undef, float %41, i32 0
  %splat = shufflevector <3 x float> %42, <3 x float> %42, <3 x i32> zeroinitializer
  %mul22 = fmul <3 x float> %36, %splat
  %43 = load <4 x float>* %pixel, align 16
  %44 = shufflevector <4 x float> %43, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add23 = fadd <3 x float> %44, %mul22
  %45 = load <4 x float>* %pixel, align 16
  %46 = shufflevector <3 x float> %add23, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %47 = shufflevector <4 x float> %45, <4 x float> %46, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %47, <4 x float>* %pixel, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body9
  %48 = load i32* %i, align 4
  %inc = add nsw i32 %48, 1
  store i32 %inc, i32* %i, align 4
  %49 = load <2 x i32>* %tc, align 8
  %50 = extractelement <2 x i32> %49, i32 0
  %inc24 = add nsw i32 %50, 1
  %51 = load <2 x i32>* %tc, align 8
  %52 = insertelement <2 x i32> %51, i32 %inc24, i32 0
  store <2 x i32> %52, <2 x i32>* %tc, align 8
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc25

for.inc25:                                        ; preds = %for.end
  %53 = load i32* %j, align 4
  %inc26 = add nsw i32 %53, 1
  store i32 %inc26, i32* %j, align 4
  %54 = load <2 x i32>* %tc, align 8
  %55 = extractelement <2 x i32> %54, i32 1
  %inc27 = add nsw i32 %55, 1
  %56 = load <2 x i32>* %tc, align 8
  %57 = insertelement <2 x i32> %56, i32 %inc27, i32 1
  store <2 x i32> %57, <2 x i32>* %tc, align 8
  br label %for.cond

for.end28:                                        ; preds = %for.cond
  %58 = load <2 x i32>* %coords, align 8
  %59 = extractelement <2 x i32> %58, i32 1
  %60 = load i32* %width.addr, align 4
  %mul29 = mul nsw i32 %59, %60
  %61 = load <2 x i32>* %coords, align 8
  %62 = extractelement <2 x i32> %61, i32 0
  %add30 = add nsw i32 %mul29, %62
  %idxprom31 = sext i32 %add30 to i64
  %63 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx32 = getelementptr inbounds <4 x i8> addrspace(1)* %63, i64 %idxprom31
  %64 = load <4 x i8> addrspace(1)* %arrayidx32, align 4
  %call33 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %64) #1
  store <4 x float> %call33, <4 x float>* %currentPixel, align 16
  %65 = load <4 x float>* %currentPixel, align 16
  %66 = extractelement <4 x float> %65, i32 0
  %67 = load <4 x float>* %pixel, align 16
  %68 = extractelement <4 x float> %67, i32 0
  %sub34 = fsub float %66, %68
  store float %sub34, float* %diffx, align 4
  %69 = load float* %diffx, align 4
  %call35 = call cc75 float @_Z4fabsf(float %69) #1
  %70 = load float* %threshold.addr, align 4
  %cmp36 = fcmp ogt float %call35, %70
  br i1 %cmp36, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.end28
  %71 = load float* %diffx, align 4
  %72 = load float* %amount.addr, align 4
  %mul38 = fmul float %71, %72
  br label %cond.end

cond.false:                                       ; preds = %for.end28
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %mul38, %cond.true ], [ 0.000000e+00, %cond.false ]
  %73 = load <4 x float>* %currentPixel, align 16
  %74 = extractelement <4 x float> %73, i32 0
  %add39 = fadd float %74, %cond
  %75 = load <4 x float>* %currentPixel, align 16
  %76 = insertelement <4 x float> %75, float %add39, i32 0
  store <4 x float> %76, <4 x float>* %currentPixel, align 16
  %77 = load <4 x float>* %currentPixel, align 16
  %78 = extractelement <4 x float> %77, i32 1
  %79 = load <4 x float>* %pixel, align 16
  %80 = extractelement <4 x float> %79, i32 1
  %sub40 = fsub float %78, %80
  store float %sub40, float* %diffy, align 4
  %81 = load float* %diffy, align 4
  %call41 = call cc75 float @_Z4fabsf(float %81) #1
  %82 = load float* %threshold.addr, align 4
  %cmp42 = fcmp ogt float %call41, %82
  br i1 %cmp42, label %cond.true44, label %cond.false46

cond.true44:                                      ; preds = %cond.end
  %83 = load float* %diffy, align 4
  %84 = load float* %amount.addr, align 4
  %mul45 = fmul float %83, %84
  br label %cond.end47

cond.false46:                                     ; preds = %cond.end
  br label %cond.end47

cond.end47:                                       ; preds = %cond.false46, %cond.true44
  %cond48 = phi float [ %mul45, %cond.true44 ], [ 0.000000e+00, %cond.false46 ]
  %85 = load <4 x float>* %currentPixel, align 16
  %86 = extractelement <4 x float> %85, i32 1
  %add49 = fadd float %86, %cond48
  %87 = load <4 x float>* %currentPixel, align 16
  %88 = insertelement <4 x float> %87, float %add49, i32 1
  store <4 x float> %88, <4 x float>* %currentPixel, align 16
  %89 = load <4 x float>* %currentPixel, align 16
  %90 = extractelement <4 x float> %89, i32 2
  %91 = load <4 x float>* %pixel, align 16
  %92 = extractelement <4 x float> %91, i32 2
  %sub50 = fsub float %90, %92
  store float %sub50, float* %diffz, align 4
  %93 = load float* %diffz, align 4
  %call51 = call cc75 float @_Z4fabsf(float %93) #1
  %94 = load float* %threshold.addr, align 4
  %cmp52 = fcmp ogt float %call51, %94
  br i1 %cmp52, label %cond.true54, label %cond.false56

cond.true54:                                      ; preds = %cond.end47
  %95 = load float* %diffz, align 4
  %96 = load float* %amount.addr, align 4
  %mul55 = fmul float %95, %96
  br label %cond.end57

cond.false56:                                     ; preds = %cond.end47
  br label %cond.end57

cond.end57:                                       ; preds = %cond.false56, %cond.true54
  %cond58 = phi float [ %mul55, %cond.true54 ], [ 0.000000e+00, %cond.false56 ]
  %97 = load <4 x float>* %currentPixel, align 16
  %98 = extractelement <4 x float> %97, i32 2
  %add59 = fadd float %98, %cond58
  %99 = load <4 x float>* %currentPixel, align 16
  %100 = insertelement <4 x float> %99, float %add59, i32 2
  store <4 x float> %100, <4 x float>* %currentPixel, align 16
  %101 = load <4 x float>* %currentPixel, align 16
  %add60 = fadd <4 x float> %101, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %call61 = call cc75 <4 x float> @_Z5clampDv4_fS_S_(<4 x float> %add60, <4 x float> zeroinitializer, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>) #1
  store <4 x float> %call61, <4 x float>* %currentPixel, align 16
  %102 = load <4 x float>* %currentPixel, align 16
  %call62 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %102) #1
  %103 = load <2 x i32>* %coords, align 8
  %104 = extractelement <2 x i32> %103, i32 1
  %105 = load i32* %width.addr, align 4
  %mul63 = mul nsw i32 %104, %105
  %106 = load <2 x i32>* %coords, align 8
  %107 = extractelement <2 x i32> %106, i32 0
  %add64 = add nsw i32 %mul63, %107
  %idxprom65 = sext i32 %add64 to i64
  %108 = load <4 x i8> addrspace(1)** %output.addr, align 8
  %arrayidx66 = getelementptr inbounds <4 x i8> addrspace(1)* %108, i64 %idxprom65
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

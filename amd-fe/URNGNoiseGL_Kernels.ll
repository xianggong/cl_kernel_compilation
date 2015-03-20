; ModuleID = 'URNGNoiseGL_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@noise_uniform.iv = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

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
  %13 = load i32* %tid, align 4
  %mul13 = mul nsw i32 4, %13
  %idxprom14 = sext i32 %mul13 to i64
  %14 = load i32 addrspace(3)** %iv.addr, align 8
  %arrayidx15 = getelementptr inbounds i32 addrspace(3)* %14, i64 %idxprom14
  %15 = load i32 addrspace(3)* %arrayidx15, align 4
  store i32 %15, i32* %iy, align 4
  %16 = load i32* %idum.addr, align 4
  %div16 = sdiv i32 %16, 127773
  store i32 %div16, i32* %k, align 4
  %17 = load i32* %idum.addr, align 4
  %18 = load i32* %k, align 4
  %mul17 = mul nsw i32 %18, 127773
  %sub18 = sub nsw i32 %17, %mul17
  %mul19 = mul nsw i32 16807, %sub18
  %19 = load i32* %k, align 4
  %mul20 = mul nsw i32 2836, %19
  %sub21 = sub nsw i32 %mul19, %mul20
  store i32 %sub21, i32* %idum.addr, align 4
  %20 = load i32* %idum.addr, align 4
  %cmp22 = icmp slt i32 %20, 0
  br i1 %cmp22, label %if.then24, label %if.end26

if.then24:                                        ; preds = %for.end
  %21 = load i32* %idum.addr, align 4
  %add25 = add nsw i32 %21, 2147483647
  store i32 %add25, i32* %idum.addr, align 4
  br label %if.end26

if.end26:                                         ; preds = %if.then24, %for.end
  %22 = load i32* %iy, align 4
  %div27 = sdiv i32 %22, 536870912
  store i32 %div27, i32* %j, align 4
  %23 = load i32* %tid, align 4
  %mul28 = mul nsw i32 4, %23
  %24 = load i32* %j, align 4
  %add29 = add nsw i32 %mul28, %24
  %idxprom30 = sext i32 %add29 to i64
  %25 = load i32 addrspace(3)** %iv.addr, align 8
  %arrayidx31 = getelementptr inbounds i32 addrspace(3)* %25, i64 %idxprom30
  %26 = load i32 addrspace(3)* %arrayidx31, align 4
  store i32 %26, i32* %iy, align 4
  %27 = load i32* %iy, align 4
  %conv32 = sitofp i32 %27 to float
  %mul33 = fmul float 0x3E00000000000000, %conv32
  ret float %mul33
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_noise_uniform_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
entry:
  %inputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %outputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %factor.addr = alloca i32, align 4
  %pos = alloca i32, align 4
  %temp = alloca <4 x float>, align 16
  %avg = alloca float, align 4
  %dev = alloca float, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %inputImage.addr, align 8
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %outputImage.addr, align 8
  store i32 %factor, i32* %factor.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %call2 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul = mul i64 %call1, %call2
  %add = add i64 %call, %mul
  %conv = trunc i64 %add to i32
  store i32 %conv, i32* %pos, align 4
  %0 = load i32* %pos, align 4
  %idxprom = sext i32 %0 to i64
  %1 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %1, i64 %idxprom
  %2 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %call3 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %2) #1
  store <4 x float> %call3, <4 x float>* %temp, align 16
  %3 = load <4 x float>* %temp, align 16
  %4 = extractelement <4 x float> %3, i32 0
  %5 = load <4 x float>* %temp, align 16
  %6 = extractelement <4 x float> %5, i32 1
  %add4 = fadd float %4, %6
  %7 = load <4 x float>* %temp, align 16
  %8 = extractelement <4 x float> %7, i32 2
  %add5 = fadd float %add4, %8
  %9 = load <4 x float>* %temp, align 16
  %10 = extractelement <4 x float> %9, i32 1
  %add6 = fadd float %add5, %10
  %div = fdiv float %add6, 4.000000e+00, !fpmath !7
  store float %div, float* %avg, align 4
  %11 = load float* %avg, align 4
  %sub = fsub float -0.000000e+00, %11
  %conv7 = fptosi float %sub to i32
  %call8 = call cc75 float @ran1(i32 %conv7, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  store float %call8, float* %dev, align 4
  %12 = load float* %dev, align 4
  %sub9 = fsub float %12, 5.000000e-01
  %13 = load i32* %factor.addr, align 4
  %conv10 = sitofp i32 %13 to float
  %mul11 = fmul float %sub9, %conv10
  store float %mul11, float* %dev, align 4
  %14 = load <4 x float>* %temp, align 16
  %15 = load float* %dev, align 4
  %16 = insertelement <4 x float> undef, float %15, i32 0
  %splat = shufflevector <4 x float> %16, <4 x float> %16, <4 x i32> zeroinitializer
  %add12 = fadd <4 x float> %14, %splat
  %call13 = call cc75 <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %add12) #1
  %17 = load i32* %pos, align 4
  %idxprom14 = sext i32 %17 to i64
  %18 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx15 = getelementptr inbounds <4 x i8> addrspace(1)* %18, i64 %idxprom14
  store <4 x i8> %call13, <4 x i8> addrspace(1)* %arrayidx15, align 4
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

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @__OpenCL_noise_uniform_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int"}
!6 = metadata !{i32 1, i32 2}
!7 = metadata !{float 2.500000e+00}

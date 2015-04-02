; ModuleID = 'URNGNoiseGL_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@noise_uniform.iv = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define cc75 float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %j.0 = phi i32 [ 4, %entry ], [ %dec, %for.inc ]
  %idum.addr.0 = phi i32 [ %idum, %entry ], [ %idum.addr.1, %for.inc ]
  %cmp = icmp sge i32 %j.0, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %div = sdiv i32 %idum.addr.0, 127773
  %mul = mul nsw i32 %div, 127773
  %sub = sub nsw i32 %idum.addr.0, %mul
  %mul2 = mul nsw i32 16807, %sub
  %mul3 = mul nsw i32 2836, %div
  %sub4 = sub nsw i32 %mul2, %mul3
  %cmp5 = icmp slt i32 %sub4, 0
  br i1 %cmp5, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %add = add nsw i32 %sub4, 2147483647
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %idum.addr.1 = phi i32 [ %add, %if.then ], [ %sub4, %for.body ]
  %cmp7 = icmp slt i32 %j.0, 4
  br i1 %cmp7, label %if.then9, label %if.end12

if.then9:                                         ; preds = %if.end
  %mul10 = mul nsw i32 4, %conv
  %add11 = add nsw i32 %mul10, %j.0
  %idxprom = sext i32 %add11 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(3)* %iv, i64 %idxprom
  store i32 %idum.addr.1, i32 addrspace(3)* %arrayidx, align 4
  br label %if.end12

if.end12:                                         ; preds = %if.then9, %if.end
  br label %for.inc

for.inc:                                          ; preds = %if.end12
  %dec = add nsw i32 %j.0, -1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %mul13 = mul nsw i32 4, %conv
  %idxprom14 = sext i32 %mul13 to i64
  %arrayidx15 = getelementptr inbounds i32 addrspace(3)* %iv, i64 %idxprom14
  %0 = load i32 addrspace(3)* %arrayidx15, align 4
  %div16 = sdiv i32 %idum.addr.0, 127773
  %mul17 = mul nsw i32 %div16, 127773
  %sub18 = sub nsw i32 %idum.addr.0, %mul17
  %mul19 = mul nsw i32 16807, %sub18
  %mul20 = mul nsw i32 2836, %div16
  %sub21 = sub nsw i32 %mul19, %mul20
  %cmp22 = icmp slt i32 %sub21, 0
  br i1 %cmp22, label %if.then24, label %if.end26

if.then24:                                        ; preds = %for.end
  %add25 = add nsw i32 %sub21, 2147483647
  br label %if.end26

if.end26:                                         ; preds = %if.then24, %for.end
  %div27 = sdiv i32 %0, 536870912
  %mul28 = mul nsw i32 4, %conv
  %add29 = add nsw i32 %mul28, %div27
  %idxprom30 = sext i32 %add29 to i64
  %arrayidx31 = getelementptr inbounds i32 addrspace(3)* %iv, i64 %idxprom30
  %1 = load i32 addrspace(3)* %arrayidx31, align 4
  %conv32 = sitofp i32 %1 to float
  %mul33 = fmul float 0x3E00000000000000, %conv32
  ret float %mul33
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_noise_uniform_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %call2 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul = mul i64 %call1, %call2
  %add = add i64 %call, %mul
  %conv = trunc i64 %add to i32
  %idxprom = sext i32 %conv to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom
  %0 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %call3 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %0) #1
  %1 = extractelement <4 x float> %call3, i32 0
  %2 = extractelement <4 x float> %call3, i32 1
  %add4 = fadd float %1, %2
  %3 = extractelement <4 x float> %call3, i32 2
  %add5 = fadd float %add4, %3
  %4 = extractelement <4 x float> %call3, i32 1
  %add6 = fadd float %add5, %4
  %div = fdiv float %add6, 4.000000e+00, !fpmath !7
  %sub = fsub float -0.000000e+00, %div
  %conv7 = fptosi float %sub to i32
  %call8 = call cc75 float @ran1(i32 %conv7, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  %sub9 = fsub float %call8, 5.000000e-01
  %conv10 = sitofp i32 %factor to float
  %mul11 = fmul float %sub9, %conv10
  %5 = insertelement <4 x float> undef, float %mul11, i32 0
  %splat = shufflevector <4 x float> %5, <4 x float> %5, <4 x i32> zeroinitializer
  %add12 = fadd <4 x float> %call3, %splat
  %call13 = call cc75 <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %add12) #1
  %idxprom14 = sext i32 %conv to i64
  %arrayidx15 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom14
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

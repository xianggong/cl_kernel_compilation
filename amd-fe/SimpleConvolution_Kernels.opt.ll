; ModuleID = 'SimpleConvolution_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_simpleConvolution_kernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, float addrspace(1)* %mask, <2 x i32> %inputDimensions, <2 x i32> %maskDimensions) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %0 = extractelement <2 x i32> %inputDimensions, i32 0
  %1 = extractelement <2 x i32> %inputDimensions, i32 1
  %rem = urem i32 %conv, %0
  %div = udiv i32 %conv, %0
  %2 = extractelement <2 x i32> %maskDimensions, i32 0
  %3 = extractelement <2 x i32> %maskDimensions, i32 1
  %sub = sub i32 %2, 1
  %div1 = udiv i32 %sub, 2
  %sub2 = sub i32 %3, 1
  %div3 = udiv i32 %sub2, 2
  %cmp = icmp ult i32 %rem, %div1
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  br label %cond.end

cond.false:                                       ; preds = %entry
  %sub5 = sub i32 %rem, %div1
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ 0, %cond.true ], [ %sub5, %cond.false ]
  %add = add i32 %rem, %div1
  %cmp6 = icmp uge i32 %add, %0
  br i1 %cmp6, label %cond.true8, label %cond.false10

cond.true8:                                       ; preds = %cond.end
  %sub9 = sub i32 %0, 1
  br label %cond.end12

cond.false10:                                     ; preds = %cond.end
  %add11 = add i32 %rem, %div1
  br label %cond.end12

cond.end12:                                       ; preds = %cond.false10, %cond.true8
  %cond13 = phi i32 [ %sub9, %cond.true8 ], [ %add11, %cond.false10 ]
  %cmp14 = icmp ult i32 %div, %div3
  br i1 %cmp14, label %cond.true16, label %cond.false17

cond.true16:                                      ; preds = %cond.end12
  br label %cond.end19

cond.false17:                                     ; preds = %cond.end12
  %sub18 = sub i32 %div, %div3
  br label %cond.end19

cond.end19:                                       ; preds = %cond.false17, %cond.true16
  %cond20 = phi i32 [ 0, %cond.true16 ], [ %sub18, %cond.false17 ]
  %add21 = add i32 %div, %div3
  %cmp22 = icmp uge i32 %add21, %1
  br i1 %cmp22, label %cond.true24, label %cond.false26

cond.true24:                                      ; preds = %cond.end19
  %sub25 = sub i32 %1, 1
  br label %cond.end28

cond.false26:                                     ; preds = %cond.end19
  %add27 = add i32 %div, %div3
  br label %cond.end28

cond.end28:                                       ; preds = %cond.false26, %cond.true24
  %cond29 = phi i32 [ %sub25, %cond.true24 ], [ %add27, %cond.false26 ]
  br label %for.cond

for.cond:                                         ; preds = %for.inc48, %cond.end28
  %sumFX.0 = phi float [ 0.000000e+00, %cond.end28 ], [ %sumFX.1, %for.inc48 ]
  %i.0 = phi i32 [ %cond, %cond.end28 ], [ %inc49, %for.inc48 ]
  %cmp30 = icmp ule i32 %i.0, %cond13
  br i1 %cmp30, label %for.body, label %for.end50

for.body:                                         ; preds = %for.cond
  br label %for.cond32

for.cond32:                                       ; preds = %for.inc, %for.body
  %sumFX.1 = phi float [ %sumFX.0, %for.body ], [ %add47, %for.inc ]
  %j.0 = phi i32 [ %cond20, %for.body ], [ %inc, %for.inc ]
  %cmp33 = icmp ule i32 %j.0, %cond29
  br i1 %cmp33, label %for.body35, label %for.end

for.body35:                                       ; preds = %for.cond32
  %sub36 = sub i32 %div, %div3
  %sub37 = sub i32 %j.0, %sub36
  %mul = mul i32 %sub37, %2
  %sub38 = sub i32 %rem, %div1
  %sub39 = sub i32 %i.0, %sub38
  %add40 = add i32 %mul, %sub39
  %mul41 = mul i32 %j.0, %0
  %add42 = add i32 %mul41, %i.0
  %idxprom = zext i32 %add42 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom
  %4 = load i32 addrspace(1)* %arrayidx, align 4
  %conv43 = uitofp i32 %4 to float
  %idxprom44 = zext i32 %add40 to i64
  %arrayidx45 = getelementptr inbounds float addrspace(1)* %mask, i64 %idxprom44
  %5 = load float addrspace(1)* %arrayidx45, align 4
  %mul46 = fmul float %conv43, %5
  %add47 = fadd float %sumFX.1, %mul46
  br label %for.inc

for.inc:                                          ; preds = %for.body35
  %inc = add i32 %j.0, 1
  br label %for.cond32

for.end:                                          ; preds = %for.cond32
  br label %for.inc48

for.inc48:                                        ; preds = %for.end
  %inc49 = add i32 %i.0, 1
  br label %for.cond

for.end50:                                        ; preds = %for.cond
  %add51 = fadd float %sumFX.0, 5.000000e-01
  %conv52 = fptoui float %add51 to i32
  %idxprom53 = zext i32 %conv to i64
  %arrayidx54 = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom53
  store i32 %conv52, i32 addrspace(1)* %arrayidx54, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, float addrspace(1)*, <2 x i32>, <2 x i32>)* @__OpenCL_simpleConvolution_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"float*", metadata !"uint2", metadata !"uint2"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"const", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"float*", metadata !"uint2", metadata !"uint2"}
!6 = metadata !{i32 1, i32 2}

; ModuleID = 'DCT_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc75 i32 @getIdx(i32 %blockIdx, i32 %blockIdy, i32 %localIdx, i32 %localIdy, i32 %blockWidth, i32 %globalWidth) #0 {
entry:
  %mul = mul i32 %blockIdx, %blockWidth
  %add = add i32 %mul, %localIdx
  %mul1 = mul i32 %blockIdy, %blockWidth
  %add2 = add i32 %mul1, %localIdy
  %mul3 = mul i32 %add2, %globalWidth
  %add4 = add i32 %mul3, %add
  ret i32 %add4
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_DCT_kernel(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(1)* %dct8x8, float addrspace(1)* %dct8x8_trans, float addrspace(3)* %inter, i32 %width, i32 %blockWidth, i32 %inverse) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %call7 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv8 = trunc i64 %call7 to i32
  %call9 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %conv10 = trunc i64 %call9 to i32
  %mul = mul i32 %conv2, %width
  %add = add i32 %mul, %conv
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %acc.0 = phi float [ 0.000000e+00, %entry ], [ %acc.1, %for.inc ]
  %k.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp ult i32 %k.0, %blockWidth
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul12 = mul i32 %conv10, %blockWidth
  %add13 = add i32 %mul12, %k.0
  %call14 = call cc75 i32 @getIdx(i32 %conv4, i32 %conv6, i32 %conv8, i32 %k.0, i32 %blockWidth, i32 %width)
  %tobool = icmp ne i32 %inverse, 0
  br i1 %tobool, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %idxprom = zext i32 %add13 to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %dct8x8, i64 %idxprom
  %0 = load float addrspace(1)* %arrayidx, align 4
  %idxprom15 = zext i32 %call14 to i64
  %arrayidx16 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom15
  %1 = load float addrspace(1)* %arrayidx16, align 4
  %mul17 = fmul float %0, %1
  %add18 = fadd float %acc.0, %mul17
  br label %if.end

if.else:                                          ; preds = %for.body
  %idxprom19 = zext i32 %add13 to i64
  %arrayidx20 = getelementptr inbounds float addrspace(1)* %dct8x8_trans, i64 %idxprom19
  %2 = load float addrspace(1)* %arrayidx20, align 4
  %idxprom21 = zext i32 %call14 to i64
  %arrayidx22 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom21
  %3 = load float addrspace(1)* %arrayidx22, align 4
  %mul23 = fmul float %2, %3
  %add24 = fadd float %acc.0, %mul23
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %acc.1 = phi float [ %add18, %if.then ], [ %add24, %if.else ]
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add i32 %k.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %mul25 = mul i32 %conv10, %blockWidth
  %add26 = add i32 %mul25, %conv8
  %idxprom27 = zext i32 %add26 to i64
  %arrayidx28 = getelementptr inbounds float addrspace(3)* %inter, i64 %idxprom27
  store float %acc.0, float addrspace(3)* %arrayidx28, align 4
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond30

for.cond30:                                       ; preds = %for.inc56, %for.end
  %acc.2 = phi float [ 0.000000e+00, %for.end ], [ %acc.3, %for.inc56 ]
  %k29.0 = phi i32 [ 0, %for.end ], [ %inc57, %for.inc56 ]
  %cmp31 = icmp ult i32 %k29.0, %blockWidth
  br i1 %cmp31, label %for.body33, label %for.end58

for.body33:                                       ; preds = %for.cond30
  %mul35 = mul i32 %conv10, %blockWidth
  %add36 = add i32 %mul35, %k29.0
  %mul38 = mul i32 %k29.0, %blockWidth
  %add39 = add i32 %mul38, %conv8
  %tobool40 = icmp ne i32 %inverse, 0
  br i1 %tobool40, label %if.then41, label %if.else48

if.then41:                                        ; preds = %for.body33
  %idxprom42 = zext i32 %add36 to i64
  %arrayidx43 = getelementptr inbounds float addrspace(3)* %inter, i64 %idxprom42
  %4 = load float addrspace(3)* %arrayidx43, align 4
  %idxprom44 = zext i32 %add39 to i64
  %arrayidx45 = getelementptr inbounds float addrspace(1)* %dct8x8_trans, i64 %idxprom44
  %5 = load float addrspace(1)* %arrayidx45, align 4
  %mul46 = fmul float %4, %5
  %add47 = fadd float %acc.2, %mul46
  br label %if.end55

if.else48:                                        ; preds = %for.body33
  %idxprom49 = zext i32 %add36 to i64
  %arrayidx50 = getelementptr inbounds float addrspace(3)* %inter, i64 %idxprom49
  %6 = load float addrspace(3)* %arrayidx50, align 4
  %idxprom51 = zext i32 %add39 to i64
  %arrayidx52 = getelementptr inbounds float addrspace(1)* %dct8x8, i64 %idxprom51
  %7 = load float addrspace(1)* %arrayidx52, align 4
  %mul53 = fmul float %6, %7
  %add54 = fadd float %acc.2, %mul53
  br label %if.end55

if.end55:                                         ; preds = %if.else48, %if.then41
  %acc.3 = phi float [ %add47, %if.then41 ], [ %add54, %if.else48 ]
  br label %for.inc56

for.inc56:                                        ; preds = %if.end55
  %inc57 = add i32 %k29.0, 1
  br label %for.cond30

for.end58:                                        ; preds = %for.cond30
  %idxprom59 = zext i32 %add to i64
  %arrayidx60 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom59
  store float %acc.2, float addrspace(1)* %arrayidx60, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32)* @__OpenCL_DCT_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 1, i32 3, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"const", metadata !"const", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{i32 1, i32 2}

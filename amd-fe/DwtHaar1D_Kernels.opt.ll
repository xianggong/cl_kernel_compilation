; ModuleID = 'DwtHaar1D_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_dwtHaar1D_kernel(float addrspace(1)* %inSignal, float addrspace(1)* %coefsSignal, float addrspace(1)* %AverageSignal, float addrspace(3)* %sharedArray, i32 %tLevels, i32 %signalLength, i32 %levelsDone, i32 %mLevels) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call3 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul = mul i64 %call1, %call3
  %mul4 = mul i64 %mul, 2
  %add = add i64 %mul4, %call
  %arrayidx = getelementptr inbounds float addrspace(1)* %inSignal, i64 %add
  %0 = load float addrspace(1)* %arrayidx, align 4
  %mul5 = mul i64 %call1, %call3
  %mul6 = mul i64 %mul5, 2
  %add7 = add i64 %mul6, %call3
  %add8 = add i64 %add7, %call
  %arrayidx9 = getelementptr inbounds float addrspace(1)* %inSignal, i64 %add8
  %1 = load float addrspace(1)* %arrayidx9, align 4
  %cmp = icmp eq i32 0, %levelsDone
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %conv = uitofp i32 %signalLength to float
  %call10 = call cc75 float @_Z5rsqrtf(float %conv) #1
  %mul11 = fmul float %0, %call10
  %mul12 = fmul float %1, %call10
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %t0.0 = phi float [ %mul11, %if.then ], [ %0, %entry ]
  %t1.0 = phi float [ %mul12, %if.then ], [ %1, %entry ]
  %arrayidx13 = getelementptr inbounds float addrspace(3)* %sharedArray, i64 %call
  store float %t0.0, float addrspace(3)* %arrayidx13, align 4
  %add14 = add i64 %call3, %call
  %arrayidx15 = getelementptr inbounds float addrspace(3)* %sharedArray, i64 %add14
  store float %t1.0, float addrspace(3)* %arrayidx15, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %cmp16 = icmp ugt i32 %tLevels, %mLevels
  br i1 %cmp16, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end
  br label %cond.end

cond.false:                                       ; preds = %if.end
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %mLevels, %cond.true ], [ %tLevels, %cond.false ]
  %shl.mask = and i32 %cond, 31
  %shl = shl i32 1, %shl.mask
  %div = sdiv i32 %shl, 2
  %div18 = udiv i32 %signalLength, 2
  %call19 = call cc75 float @_Z5rsqrtf(float 2.000000e+00) #1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %cond.end
  %activeThreads.0 = phi i32 [ %div, %cond.end ], [ %shr48, %for.inc ]
  %midOutPos.0 = phi i32 [ %div18, %cond.end ], [ %midOutPos.1, %for.inc ]
  %i.0 = phi i32 [ 0, %cond.end ], [ %inc, %for.inc ]
  %data0.0 = phi float [ undef, %cond.end ], [ %data0.1, %for.inc ]
  %data1.0 = phi float [ undef, %cond.end ], [ %data1.1, %for.inc ]
  %cmp20 = icmp ult i32 %i.0, %cond
  br i1 %cmp20, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %conv22 = zext i32 %activeThreads.0 to i64
  %cmp23 = icmp ult i64 %call, %conv22
  br i1 %cmp23, label %if.then25, label %if.end31

if.then25:                                        ; preds = %for.body
  %mul26 = mul i64 2, %call
  %arrayidx27 = getelementptr inbounds float addrspace(3)* %sharedArray, i64 %mul26
  %2 = load float addrspace(3)* %arrayidx27, align 4
  %mul28 = mul i64 2, %call
  %add29 = add i64 %mul28, 1
  %arrayidx30 = getelementptr inbounds float addrspace(3)* %sharedArray, i64 %add29
  %3 = load float addrspace(3)* %arrayidx30, align 4
  br label %if.end31

if.end31:                                         ; preds = %if.then25, %for.body
  %data0.1 = phi float [ %2, %if.then25 ], [ %data0.0, %for.body ]
  %data1.1 = phi float [ %3, %if.then25 ], [ %data1.0, %for.body ]
  call cc75 void @_Z7barrierj(i32 1)
  %conv32 = zext i32 %activeThreads.0 to i64
  %cmp33 = icmp ult i64 %call, %conv32
  br i1 %cmp33, label %if.then35, label %if.end47

if.then35:                                        ; preds = %if.end31
  %add36 = fadd float %data0.1, %data1.1
  %mul37 = fmul float %add36, %call19
  %arrayidx38 = getelementptr inbounds float addrspace(3)* %sharedArray, i64 %call
  store float %mul37, float addrspace(3)* %arrayidx38, align 4
  %conv39 = zext i32 %midOutPos.0 to i64
  %conv40 = zext i32 %activeThreads.0 to i64
  %mul41 = mul i64 %call1, %conv40
  %add42 = add i64 %conv39, %mul41
  %add43 = add i64 %add42, %call
  %conv44 = trunc i64 %add43 to i32
  %sub = fsub float %data0.1, %data1.1
  %mul45 = fmul float %sub, %call19
  %idxprom = zext i32 %conv44 to i64
  %arrayidx46 = getelementptr inbounds float addrspace(1)* %coefsSignal, i64 %idxprom
  store float %mul45, float addrspace(1)* %arrayidx46, align 4
  %shr = lshr i32 %midOutPos.0, 1
  br label %if.end47

if.end47:                                         ; preds = %if.then35, %if.end31
  %midOutPos.1 = phi i32 [ %shr, %if.then35 ], [ %midOutPos.0, %if.end31 ]
  %shr48 = lshr i32 %activeThreads.0, 1
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end47
  %inc = add i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %cmp49 = icmp eq i64 0, %call
  br i1 %cmp49, label %if.then51, label %if.end54

if.then51:                                        ; preds = %for.end
  %arrayidx52 = getelementptr inbounds float addrspace(3)* %sharedArray, i64 0
  %4 = load float addrspace(3)* %arrayidx52, align 4
  %arrayidx53 = getelementptr inbounds float addrspace(1)* %AverageSignal, i64 %call1
  store float %4, float addrspace(1)* %arrayidx53, align 4
  br label %if.end54

if.end54:                                         ; preds = %if.then51, %for.end
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z5rsqrtf(float) #1

declare cc75 void @_Z7barrierj(i32)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32, i32)* @__OpenCL_dwtHaar1D_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 3, i32 0, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{i32 1, i32 2}

; ModuleID = 'DwtHaar1D_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_dwtHaar1D_kernel(float addrspace(1)* %inSignal, float addrspace(1)* %coefsSignal, float addrspace(1)* %AverageSignal, float addrspace(3)* %sharedArray, i32 %tLevels, i32 %signalLength, i32 %levelsDone, i32 %mLevels) #0 {
entry:
  %inSignal.addr = alloca float addrspace(1)*, align 8
  %coefsSignal.addr = alloca float addrspace(1)*, align 8
  %AverageSignal.addr = alloca float addrspace(1)*, align 8
  %sharedArray.addr = alloca float addrspace(3)*, align 8
  %tLevels.addr = alloca i32, align 4
  %signalLength.addr = alloca i32, align 4
  %levelsDone.addr = alloca i32, align 4
  %mLevels.addr = alloca i32, align 4
  %localId = alloca i64, align 8
  %groupId = alloca i64, align 8
  %globalId = alloca i64, align 8
  %localSize = alloca i64, align 8
  %t0 = alloca float, align 4
  %t1 = alloca float, align 4
  %r = alloca float, align 4
  %levels = alloca i32, align 4
  %activeThreads = alloca i32, align 4
  %midOutPos = alloca i32, align 4
  %rsqrt_two = alloca float, align 4
  %i = alloca i32, align 4
  %data0 = alloca float, align 4
  %data1 = alloca float, align 4
  %globalPos = alloca i32, align 4
  store float addrspace(1)* %inSignal, float addrspace(1)** %inSignal.addr, align 8
  store float addrspace(1)* %coefsSignal, float addrspace(1)** %coefsSignal.addr, align 8
  store float addrspace(1)* %AverageSignal, float addrspace(1)** %AverageSignal.addr, align 8
  store float addrspace(3)* %sharedArray, float addrspace(3)** %sharedArray.addr, align 8
  store i32 %tLevels, i32* %tLevels.addr, align 4
  store i32 %signalLength, i32* %signalLength.addr, align 4
  store i32 %levelsDone, i32* %levelsDone.addr, align 4
  store i32 %mLevels, i32* %mLevels.addr, align 4
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  store i64 %call, i64* %localId, align 8
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  store i64 %call1, i64* %groupId, align 8
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call2, i64* %globalId, align 8
  %call3 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  store i64 %call3, i64* %localSize, align 8
  %0 = load i64* %groupId, align 8
  %1 = load i64* %localSize, align 8
  %mul = mul i64 %0, %1
  %mul4 = mul i64 %mul, 2
  %2 = load i64* %localId, align 8
  %add = add i64 %mul4, %2
  %3 = load float addrspace(1)** %inSignal.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %3, i64 %add
  %4 = load float addrspace(1)* %arrayidx, align 4
  store float %4, float* %t0, align 4
  %5 = load i64* %groupId, align 8
  %6 = load i64* %localSize, align 8
  %mul5 = mul i64 %5, %6
  %mul6 = mul i64 %mul5, 2
  %7 = load i64* %localSize, align 8
  %add7 = add i64 %mul6, %7
  %8 = load i64* %localId, align 8
  %add8 = add i64 %add7, %8
  %9 = load float addrspace(1)** %inSignal.addr, align 8
  %arrayidx9 = getelementptr inbounds float addrspace(1)* %9, i64 %add8
  %10 = load float addrspace(1)* %arrayidx9, align 4
  store float %10, float* %t1, align 4
  %11 = load i32* %levelsDone.addr, align 4
  %cmp = icmp eq i32 0, %11
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %12 = load i32* %signalLength.addr, align 4
  %conv = uitofp i32 %12 to float
  %call10 = call cc75 float @_Z5rsqrtf(float %conv) #1
  store float %call10, float* %r, align 4
  %13 = load float* %r, align 4
  %14 = load float* %t0, align 4
  %mul11 = fmul float %14, %13
  store float %mul11, float* %t0, align 4
  %15 = load float* %r, align 4
  %16 = load float* %t1, align 4
  %mul12 = fmul float %16, %15
  store float %mul12, float* %t1, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %17 = load float* %t0, align 4
  %18 = load i64* %localId, align 8
  %19 = load float addrspace(3)** %sharedArray.addr, align 8
  %arrayidx13 = getelementptr inbounds float addrspace(3)* %19, i64 %18
  store float %17, float addrspace(3)* %arrayidx13, align 4
  %20 = load float* %t1, align 4
  %21 = load i64* %localSize, align 8
  %22 = load i64* %localId, align 8
  %add14 = add i64 %21, %22
  %23 = load float addrspace(3)** %sharedArray.addr, align 8
  %arrayidx15 = getelementptr inbounds float addrspace(3)* %23, i64 %add14
  store float %20, float addrspace(3)* %arrayidx15, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %24 = load i32* %tLevels.addr, align 4
  %25 = load i32* %mLevels.addr, align 4
  %cmp16 = icmp ugt i32 %24, %25
  br i1 %cmp16, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end
  %26 = load i32* %mLevels.addr, align 4
  br label %cond.end

cond.false:                                       ; preds = %if.end
  %27 = load i32* %tLevels.addr, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %26, %cond.true ], [ %27, %cond.false ]
  store i32 %cond, i32* %levels, align 4
  %28 = load i32* %levels, align 4
  %shl.mask = and i32 %28, 31
  %shl = shl i32 1, %shl.mask
  %div = sdiv i32 %shl, 2
  store i32 %div, i32* %activeThreads, align 4
  %29 = load i32* %signalLength.addr, align 4
  %div18 = udiv i32 %29, 2
  store i32 %div18, i32* %midOutPos, align 4
  %call19 = call cc75 float @_Z5rsqrtf(float 2.000000e+00) #1
  store float %call19, float* %rsqrt_two, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %cond.end
  %30 = load i32* %i, align 4
  %31 = load i32* %levels, align 4
  %cmp20 = icmp ult i32 %30, %31
  br i1 %cmp20, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %32 = load i64* %localId, align 8
  %33 = load i32* %activeThreads, align 4
  %conv22 = zext i32 %33 to i64
  %cmp23 = icmp ult i64 %32, %conv22
  br i1 %cmp23, label %if.then25, label %if.end31

if.then25:                                        ; preds = %for.body
  %34 = load i64* %localId, align 8
  %mul26 = mul i64 2, %34
  %35 = load float addrspace(3)** %sharedArray.addr, align 8
  %arrayidx27 = getelementptr inbounds float addrspace(3)* %35, i64 %mul26
  %36 = load float addrspace(3)* %arrayidx27, align 4
  store float %36, float* %data0, align 4
  %37 = load i64* %localId, align 8
  %mul28 = mul i64 2, %37
  %add29 = add i64 %mul28, 1
  %38 = load float addrspace(3)** %sharedArray.addr, align 8
  %arrayidx30 = getelementptr inbounds float addrspace(3)* %38, i64 %add29
  %39 = load float addrspace(3)* %arrayidx30, align 4
  store float %39, float* %data1, align 4
  br label %if.end31

if.end31:                                         ; preds = %if.then25, %for.body
  call cc75 void @_Z7barrierj(i32 1)
  %40 = load i64* %localId, align 8
  %41 = load i32* %activeThreads, align 4
  %conv32 = zext i32 %41 to i64
  %cmp33 = icmp ult i64 %40, %conv32
  br i1 %cmp33, label %if.then35, label %if.end47

if.then35:                                        ; preds = %if.end31
  %42 = load float* %data0, align 4
  %43 = load float* %data1, align 4
  %add36 = fadd float %42, %43
  %44 = load float* %rsqrt_two, align 4
  %mul37 = fmul float %add36, %44
  %45 = load i64* %localId, align 8
  %46 = load float addrspace(3)** %sharedArray.addr, align 8
  %arrayidx38 = getelementptr inbounds float addrspace(3)* %46, i64 %45
  store float %mul37, float addrspace(3)* %arrayidx38, align 4
  %47 = load i32* %midOutPos, align 4
  %conv39 = zext i32 %47 to i64
  %48 = load i64* %groupId, align 8
  %49 = load i32* %activeThreads, align 4
  %conv40 = zext i32 %49 to i64
  %mul41 = mul i64 %48, %conv40
  %add42 = add i64 %conv39, %mul41
  %50 = load i64* %localId, align 8
  %add43 = add i64 %add42, %50
  %conv44 = trunc i64 %add43 to i32
  store i32 %conv44, i32* %globalPos, align 4
  %51 = load float* %data0, align 4
  %52 = load float* %data1, align 4
  %sub = fsub float %51, %52
  %53 = load float* %rsqrt_two, align 4
  %mul45 = fmul float %sub, %53
  %54 = load i32* %globalPos, align 4
  %idxprom = zext i32 %54 to i64
  %55 = load float addrspace(1)** %coefsSignal.addr, align 8
  %arrayidx46 = getelementptr inbounds float addrspace(1)* %55, i64 %idxprom
  store float %mul45, float addrspace(1)* %arrayidx46, align 4
  %56 = load i32* %midOutPos, align 4
  %shr = lshr i32 %56, 1
  store i32 %shr, i32* %midOutPos, align 4
  br label %if.end47

if.end47:                                         ; preds = %if.then35, %if.end31
  %57 = load i32* %activeThreads, align 4
  %shr48 = lshr i32 %57, 1
  store i32 %shr48, i32* %activeThreads, align 4
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end47
  %58 = load i32* %i, align 4
  %inc = add i32 %58, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %59 = load i64* %localId, align 8
  %cmp49 = icmp eq i64 0, %59
  br i1 %cmp49, label %if.then51, label %if.end54

if.then51:                                        ; preds = %for.end
  %60 = load float addrspace(3)** %sharedArray.addr, align 8
  %arrayidx52 = getelementptr inbounds float addrspace(3)* %60, i64 0
  %61 = load float addrspace(3)* %arrayidx52, align 4
  %62 = load i64* %groupId, align 8
  %63 = load float addrspace(1)** %AverageSignal.addr, align 8
  %arrayidx53 = getelementptr inbounds float addrspace(1)* %63, i64 %62
  store float %61, float addrspace(1)* %arrayidx53, align 4
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

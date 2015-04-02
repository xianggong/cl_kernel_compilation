; ModuleID = 'ScanLargeArrays_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@blockAddition.value = internal addrspace(3) global [1 x float] zeroinitializer, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_blockAddition_kernel(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
entry:
  %input.addr = alloca float addrspace(1)*, align 8
  %output.addr = alloca float addrspace(1)*, align 8
  %globalId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %localId = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %input.addr, align 8
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %globalId, align 4
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %groupId, align 4
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %localId, align 4
  %0 = load i32* %localId, align 4
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load i32* %groupId, align 4
  %idxprom = sext i32 %1 to i64
  %2 = load float addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %2, i64 %idxprom
  %3 = load float addrspace(1)* %arrayidx, align 4
  store float %3, float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i64 0), align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  call cc75 void @_Z7barrierj(i32 1)
  %4 = load float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i64 0), align 4
  %5 = load i32* %globalId, align 4
  %idxprom6 = sext i32 %5 to i64
  %6 = load float addrspace(1)** %output.addr, align 8
  %arrayidx7 = getelementptr inbounds float addrspace(1)* %6, i64 %idxprom6
  %7 = load float addrspace(1)* %arrayidx7, align 4
  %add = fadd float %7, %4
  store float %add, float addrspace(1)* %arrayidx7, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

; Function Attrs: nounwind
define cc76 void @__OpenCL_ScanLargeArrays_kernel(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size, float addrspace(1)* %sumBuffer) #0 {
entry:
  %output.addr = alloca float addrspace(1)*, align 8
  %input.addr = alloca float addrspace(1)*, align 8
  %block.addr = alloca float addrspace(3)*, align 8
  %block_size.addr = alloca i32, align 4
  %sumBuffer.addr = alloca float addrspace(1)*, align 8
  %tid = alloca i32, align 4
  %gid = alloca i32, align 4
  %bid = alloca i32, align 4
  %cache0 = alloca float, align 4
  %cache1 = alloca float, align 4
  %stride = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  store float addrspace(1)* %input, float addrspace(1)** %input.addr, align 8
  store float addrspace(3)* %block, float addrspace(3)** %block.addr, align 8
  store i32 %block_size, i32* %block_size.addr, align 4
  store float addrspace(1)* %sumBuffer, float addrspace(1)** %sumBuffer.addr, align 8
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %gid, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %bid, align 4
  %0 = load i32* %gid, align 4
  %mul = mul nsw i32 2, %0
  %idxprom = sext i32 %mul to i64
  %1 = load float addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %1, i64 %idxprom
  %2 = load float addrspace(1)* %arrayidx, align 4
  %3 = load i32* %tid, align 4
  %mul5 = mul nsw i32 2, %3
  %idxprom6 = sext i32 %mul5 to i64
  %4 = load float addrspace(3)** %block.addr, align 8
  %arrayidx7 = getelementptr inbounds float addrspace(3)* %4, i64 %idxprom6
  store float %2, float addrspace(3)* %arrayidx7, align 4
  %5 = load i32* %gid, align 4
  %mul8 = mul nsw i32 2, %5
  %add = add nsw i32 %mul8, 1
  %idxprom9 = sext i32 %add to i64
  %6 = load float addrspace(1)** %input.addr, align 8
  %arrayidx10 = getelementptr inbounds float addrspace(1)* %6, i64 %idxprom9
  %7 = load float addrspace(1)* %arrayidx10, align 4
  %8 = load i32* %tid, align 4
  %mul11 = mul nsw i32 2, %8
  %add12 = add nsw i32 %mul11, 1
  %idxprom13 = sext i32 %add12 to i64
  %9 = load float addrspace(3)** %block.addr, align 8
  %arrayidx14 = getelementptr inbounds float addrspace(3)* %9, i64 %idxprom13
  store float %7, float addrspace(3)* %arrayidx14, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %10 = load float addrspace(3)** %block.addr, align 8
  %arrayidx15 = getelementptr inbounds float addrspace(3)* %10, i64 0
  %11 = load float addrspace(3)* %arrayidx15, align 4
  store float %11, float* %cache0, align 4
  %12 = load float* %cache0, align 4
  %13 = load float addrspace(3)** %block.addr, align 8
  %arrayidx16 = getelementptr inbounds float addrspace(3)* %13, i64 1
  %14 = load float addrspace(3)* %arrayidx16, align 4
  %add17 = fadd float %12, %14
  store float %add17, float* %cache1, align 4
  store i32 1, i32* %stride, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %15 = load i32* %stride, align 4
  %16 = load i32* %block_size.addr, align 4
  %cmp = icmp ult i32 %15, %16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %17 = load i32* %tid, align 4
  %mul19 = mul nsw i32 2, %17
  %18 = load i32* %stride, align 4
  %cmp20 = icmp sge i32 %mul19, %18
  br i1 %cmp20, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %19 = load i32* %tid, align 4
  %mul22 = mul nsw i32 2, %19
  %20 = load i32* %stride, align 4
  %sub = sub nsw i32 %mul22, %20
  %idxprom23 = sext i32 %sub to i64
  %21 = load float addrspace(3)** %block.addr, align 8
  %arrayidx24 = getelementptr inbounds float addrspace(3)* %21, i64 %idxprom23
  %22 = load float addrspace(3)* %arrayidx24, align 4
  %23 = load i32* %tid, align 4
  %mul25 = mul nsw i32 2, %23
  %idxprom26 = sext i32 %mul25 to i64
  %24 = load float addrspace(3)** %block.addr, align 8
  %arrayidx27 = getelementptr inbounds float addrspace(3)* %24, i64 %idxprom26
  %25 = load float addrspace(3)* %arrayidx27, align 4
  %add28 = fadd float %22, %25
  store float %add28, float* %cache0, align 4
  %26 = load i32* %tid, align 4
  %mul29 = mul nsw i32 2, %26
  %add30 = add nsw i32 %mul29, 1
  %27 = load i32* %stride, align 4
  %sub31 = sub nsw i32 %add30, %27
  %idxprom32 = sext i32 %sub31 to i64
  %28 = load float addrspace(3)** %block.addr, align 8
  %arrayidx33 = getelementptr inbounds float addrspace(3)* %28, i64 %idxprom32
  %29 = load float addrspace(3)* %arrayidx33, align 4
  %30 = load i32* %tid, align 4
  %mul34 = mul nsw i32 2, %30
  %add35 = add nsw i32 %mul34, 1
  %idxprom36 = sext i32 %add35 to i64
  %31 = load float addrspace(3)** %block.addr, align 8
  %arrayidx37 = getelementptr inbounds float addrspace(3)* %31, i64 %idxprom36
  %32 = load float addrspace(3)* %arrayidx37, align 4
  %add38 = fadd float %29, %32
  store float %add38, float* %cache1, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  call cc75 void @_Z7barrierj(i32 1)
  %33 = load float* %cache0, align 4
  %34 = load i32* %tid, align 4
  %mul39 = mul nsw i32 2, %34
  %idxprom40 = sext i32 %mul39 to i64
  %35 = load float addrspace(3)** %block.addr, align 8
  %arrayidx41 = getelementptr inbounds float addrspace(3)* %35, i64 %idxprom40
  store float %33, float addrspace(3)* %arrayidx41, align 4
  %36 = load float* %cache1, align 4
  %37 = load i32* %tid, align 4
  %mul42 = mul nsw i32 2, %37
  %add43 = add nsw i32 %mul42, 1
  %idxprom44 = sext i32 %add43 to i64
  %38 = load float addrspace(3)** %block.addr, align 8
  %arrayidx45 = getelementptr inbounds float addrspace(3)* %38, i64 %idxprom44
  store float %36, float addrspace(3)* %arrayidx45, align 4
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %39 = load i32* %stride, align 4
  %mul46 = mul nsw i32 %39, 2
  store i32 %mul46, i32* %stride, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %40 = load i32* %block_size.addr, align 4
  %sub47 = sub i32 %40, 1
  %idxprom48 = zext i32 %sub47 to i64
  %41 = load float addrspace(3)** %block.addr, align 8
  %arrayidx49 = getelementptr inbounds float addrspace(3)* %41, i64 %idxprom48
  %42 = load float addrspace(3)* %arrayidx49, align 4
  %43 = load i32* %bid, align 4
  %idxprom50 = sext i32 %43 to i64
  %44 = load float addrspace(1)** %sumBuffer.addr, align 8
  %arrayidx51 = getelementptr inbounds float addrspace(1)* %44, i64 %idxprom50
  store float %42, float addrspace(1)* %arrayidx51, align 4
  %45 = load i32* %tid, align 4
  %cmp52 = icmp eq i32 %45, 0
  br i1 %cmp52, label %if.then54, label %if.else

if.then54:                                        ; preds = %for.end
  %46 = load i32* %gid, align 4
  %mul55 = mul nsw i32 2, %46
  %idxprom56 = sext i32 %mul55 to i64
  %47 = load float addrspace(1)** %output.addr, align 8
  %arrayidx57 = getelementptr inbounds float addrspace(1)* %47, i64 %idxprom56
  store float 0.000000e+00, float addrspace(1)* %arrayidx57, align 4
  %48 = load i32* %tid, align 4
  %mul58 = mul nsw i32 2, %48
  %idxprom59 = sext i32 %mul58 to i64
  %49 = load float addrspace(3)** %block.addr, align 8
  %arrayidx60 = getelementptr inbounds float addrspace(3)* %49, i64 %idxprom59
  %50 = load float addrspace(3)* %arrayidx60, align 4
  %51 = load i32* %gid, align 4
  %mul61 = mul nsw i32 2, %51
  %add62 = add nsw i32 %mul61, 1
  %idxprom63 = sext i32 %add62 to i64
  %52 = load float addrspace(1)** %output.addr, align 8
  %arrayidx64 = getelementptr inbounds float addrspace(1)* %52, i64 %idxprom63
  store float %50, float addrspace(1)* %arrayidx64, align 4
  br label %if.end79

if.else:                                          ; preds = %for.end
  %53 = load i32* %tid, align 4
  %mul65 = mul nsw i32 2, %53
  %sub66 = sub nsw i32 %mul65, 1
  %idxprom67 = sext i32 %sub66 to i64
  %54 = load float addrspace(3)** %block.addr, align 8
  %arrayidx68 = getelementptr inbounds float addrspace(3)* %54, i64 %idxprom67
  %55 = load float addrspace(3)* %arrayidx68, align 4
  %56 = load i32* %gid, align 4
  %mul69 = mul nsw i32 2, %56
  %idxprom70 = sext i32 %mul69 to i64
  %57 = load float addrspace(1)** %output.addr, align 8
  %arrayidx71 = getelementptr inbounds float addrspace(1)* %57, i64 %idxprom70
  store float %55, float addrspace(1)* %arrayidx71, align 4
  %58 = load i32* %tid, align 4
  %mul72 = mul nsw i32 2, %58
  %idxprom73 = sext i32 %mul72 to i64
  %59 = load float addrspace(3)** %block.addr, align 8
  %arrayidx74 = getelementptr inbounds float addrspace(3)* %59, i64 %idxprom73
  %60 = load float addrspace(3)* %arrayidx74, align 4
  %61 = load i32* %gid, align 4
  %mul75 = mul nsw i32 2, %61
  %add76 = add nsw i32 %mul75, 1
  %idxprom77 = sext i32 %add76 to i64
  %62 = load float addrspace(1)** %output.addr, align 8
  %arrayidx78 = getelementptr inbounds float addrspace(1)* %62, i64 %idxprom77
  store float %60, float addrspace(1)* %arrayidx78, align 4
  br label %if.end79

if.end79:                                         ; preds = %if.else, %if.then54
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_prefixSum_kernel(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size) #0 {
entry:
  %output.addr = alloca float addrspace(1)*, align 8
  %input.addr = alloca float addrspace(1)*, align 8
  %block.addr = alloca float addrspace(3)*, align 8
  %block_size.addr = alloca i32, align 4
  %tid = alloca i32, align 4
  %gid = alloca i32, align 4
  %bid = alloca i32, align 4
  %cache0 = alloca float, align 4
  %cache1 = alloca float, align 4
  %stride = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  store float addrspace(1)* %input, float addrspace(1)** %input.addr, align 8
  store float addrspace(3)* %block, float addrspace(3)** %block.addr, align 8
  store i32 %block_size, i32* %block_size.addr, align 4
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %gid, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %bid, align 4
  %0 = load i32* %gid, align 4
  %mul = mul nsw i32 2, %0
  %idxprom = sext i32 %mul to i64
  %1 = load float addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %1, i64 %idxprom
  %2 = load float addrspace(1)* %arrayidx, align 4
  %3 = load i32* %tid, align 4
  %mul5 = mul nsw i32 2, %3
  %idxprom6 = sext i32 %mul5 to i64
  %4 = load float addrspace(3)** %block.addr, align 8
  %arrayidx7 = getelementptr inbounds float addrspace(3)* %4, i64 %idxprom6
  store float %2, float addrspace(3)* %arrayidx7, align 4
  %5 = load i32* %gid, align 4
  %mul8 = mul nsw i32 2, %5
  %add = add nsw i32 %mul8, 1
  %idxprom9 = sext i32 %add to i64
  %6 = load float addrspace(1)** %input.addr, align 8
  %arrayidx10 = getelementptr inbounds float addrspace(1)* %6, i64 %idxprom9
  %7 = load float addrspace(1)* %arrayidx10, align 4
  %8 = load i32* %tid, align 4
  %mul11 = mul nsw i32 2, %8
  %add12 = add nsw i32 %mul11, 1
  %idxprom13 = sext i32 %add12 to i64
  %9 = load float addrspace(3)** %block.addr, align 8
  %arrayidx14 = getelementptr inbounds float addrspace(3)* %9, i64 %idxprom13
  store float %7, float addrspace(3)* %arrayidx14, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %10 = load float addrspace(3)** %block.addr, align 8
  %arrayidx15 = getelementptr inbounds float addrspace(3)* %10, i64 0
  %11 = load float addrspace(3)* %arrayidx15, align 4
  store float %11, float* %cache0, align 4
  %12 = load float* %cache0, align 4
  %13 = load float addrspace(3)** %block.addr, align 8
  %arrayidx16 = getelementptr inbounds float addrspace(3)* %13, i64 1
  %14 = load float addrspace(3)* %arrayidx16, align 4
  %add17 = fadd float %12, %14
  store float %add17, float* %cache1, align 4
  store i32 1, i32* %stride, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %15 = load i32* %stride, align 4
  %16 = load i32* %block_size.addr, align 4
  %cmp = icmp ult i32 %15, %16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %17 = load i32* %tid, align 4
  %mul19 = mul nsw i32 2, %17
  %18 = load i32* %stride, align 4
  %cmp20 = icmp sge i32 %mul19, %18
  br i1 %cmp20, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %19 = load i32* %tid, align 4
  %mul22 = mul nsw i32 2, %19
  %20 = load i32* %stride, align 4
  %sub = sub nsw i32 %mul22, %20
  %idxprom23 = sext i32 %sub to i64
  %21 = load float addrspace(3)** %block.addr, align 8
  %arrayidx24 = getelementptr inbounds float addrspace(3)* %21, i64 %idxprom23
  %22 = load float addrspace(3)* %arrayidx24, align 4
  %23 = load i32* %tid, align 4
  %mul25 = mul nsw i32 2, %23
  %idxprom26 = sext i32 %mul25 to i64
  %24 = load float addrspace(3)** %block.addr, align 8
  %arrayidx27 = getelementptr inbounds float addrspace(3)* %24, i64 %idxprom26
  %25 = load float addrspace(3)* %arrayidx27, align 4
  %add28 = fadd float %22, %25
  store float %add28, float* %cache0, align 4
  %26 = load i32* %tid, align 4
  %mul29 = mul nsw i32 2, %26
  %add30 = add nsw i32 %mul29, 1
  %27 = load i32* %stride, align 4
  %sub31 = sub nsw i32 %add30, %27
  %idxprom32 = sext i32 %sub31 to i64
  %28 = load float addrspace(3)** %block.addr, align 8
  %arrayidx33 = getelementptr inbounds float addrspace(3)* %28, i64 %idxprom32
  %29 = load float addrspace(3)* %arrayidx33, align 4
  %30 = load i32* %tid, align 4
  %mul34 = mul nsw i32 2, %30
  %add35 = add nsw i32 %mul34, 1
  %idxprom36 = sext i32 %add35 to i64
  %31 = load float addrspace(3)** %block.addr, align 8
  %arrayidx37 = getelementptr inbounds float addrspace(3)* %31, i64 %idxprom36
  %32 = load float addrspace(3)* %arrayidx37, align 4
  %add38 = fadd float %29, %32
  store float %add38, float* %cache1, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  call cc75 void @_Z7barrierj(i32 1)
  %33 = load float* %cache0, align 4
  %34 = load i32* %tid, align 4
  %mul39 = mul nsw i32 2, %34
  %idxprom40 = sext i32 %mul39 to i64
  %35 = load float addrspace(3)** %block.addr, align 8
  %arrayidx41 = getelementptr inbounds float addrspace(3)* %35, i64 %idxprom40
  store float %33, float addrspace(3)* %arrayidx41, align 4
  %36 = load float* %cache1, align 4
  %37 = load i32* %tid, align 4
  %mul42 = mul nsw i32 2, %37
  %add43 = add nsw i32 %mul42, 1
  %idxprom44 = sext i32 %add43 to i64
  %38 = load float addrspace(3)** %block.addr, align 8
  %arrayidx45 = getelementptr inbounds float addrspace(3)* %38, i64 %idxprom44
  store float %36, float addrspace(3)* %arrayidx45, align 4
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %39 = load i32* %stride, align 4
  %mul46 = mul nsw i32 %39, 2
  store i32 %mul46, i32* %stride, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %40 = load i32* %tid, align 4
  %cmp47 = icmp eq i32 %40, 0
  br i1 %cmp47, label %if.then49, label %if.else

if.then49:                                        ; preds = %for.end
  %41 = load i32* %gid, align 4
  %mul50 = mul nsw i32 2, %41
  %idxprom51 = sext i32 %mul50 to i64
  %42 = load float addrspace(1)** %output.addr, align 8
  %arrayidx52 = getelementptr inbounds float addrspace(1)* %42, i64 %idxprom51
  store float 0.000000e+00, float addrspace(1)* %arrayidx52, align 4
  %43 = load i32* %tid, align 4
  %mul53 = mul nsw i32 2, %43
  %idxprom54 = sext i32 %mul53 to i64
  %44 = load float addrspace(3)** %block.addr, align 8
  %arrayidx55 = getelementptr inbounds float addrspace(3)* %44, i64 %idxprom54
  %45 = load float addrspace(3)* %arrayidx55, align 4
  %46 = load i32* %gid, align 4
  %mul56 = mul nsw i32 2, %46
  %add57 = add nsw i32 %mul56, 1
  %idxprom58 = sext i32 %add57 to i64
  %47 = load float addrspace(1)** %output.addr, align 8
  %arrayidx59 = getelementptr inbounds float addrspace(1)* %47, i64 %idxprom58
  store float %45, float addrspace(1)* %arrayidx59, align 4
  br label %if.end74

if.else:                                          ; preds = %for.end
  %48 = load i32* %tid, align 4
  %mul60 = mul nsw i32 2, %48
  %sub61 = sub nsw i32 %mul60, 1
  %idxprom62 = sext i32 %sub61 to i64
  %49 = load float addrspace(3)** %block.addr, align 8
  %arrayidx63 = getelementptr inbounds float addrspace(3)* %49, i64 %idxprom62
  %50 = load float addrspace(3)* %arrayidx63, align 4
  %51 = load i32* %gid, align 4
  %mul64 = mul nsw i32 2, %51
  %idxprom65 = sext i32 %mul64 to i64
  %52 = load float addrspace(1)** %output.addr, align 8
  %arrayidx66 = getelementptr inbounds float addrspace(1)* %52, i64 %idxprom65
  store float %50, float addrspace(1)* %arrayidx66, align 4
  %53 = load i32* %tid, align 4
  %mul67 = mul nsw i32 2, %53
  %idxprom68 = sext i32 %mul67 to i64
  %54 = load float addrspace(3)** %block.addr, align 8
  %arrayidx69 = getelementptr inbounds float addrspace(3)* %54, i64 %idxprom68
  %55 = load float addrspace(3)* %arrayidx69, align 4
  %56 = load i32* %gid, align 4
  %mul70 = mul nsw i32 2, %56
  %add71 = add nsw i32 %mul70, 1
  %idxprom72 = sext i32 %add71 to i64
  %57 = load float addrspace(1)** %output.addr, align 8
  %arrayidx73 = getelementptr inbounds float addrspace(1)* %57, i64 %idxprom72
  store float %55, float addrspace(1)* %arrayidx73, align 4
  br label %if.end74

if.end74:                                         ; preds = %if.else, %if.then49
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !12}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!18}
!opencl.spir.version = !{!18}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @__OpenCL_blockAddition_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*"}
!6 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, float addrspace(1)*)* @__OpenCL_ScanLargeArrays_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0, i32 1}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"float*"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"const", metadata !""}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"float*"}
!12 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32)* @__OpenCL_prefixSum_kernel, metadata !13, metadata !14, metadata !15, metadata !16, metadata !17}
!13 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0}
!14 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!15 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint"}
!16 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"const"}
!17 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint"}
!18 = metadata !{i32 1, i32 2}

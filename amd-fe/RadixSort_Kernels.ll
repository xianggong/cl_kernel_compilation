; ModuleID = 'RadixSort_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_histogram_kernel(i32 addrspace(1)* %unsortedData, i32 addrspace(1)* %buckets, i32 %shiftCount, i32 addrspace(3)* %sharedArray) #0 {
entry:
  %unsortedData.addr = alloca i32 addrspace(1)*, align 8
  %buckets.addr = alloca i32 addrspace(1)*, align 8
  %shiftCount.addr = alloca i32, align 4
  %sharedArray.addr = alloca i32 addrspace(3)*, align 8
  %localId = alloca i64, align 8
  %globalId = alloca i64, align 8
  %groupId = alloca i64, align 8
  %groupSize = alloca i64, align 8
  %numGroups = alloca i32, align 4
  %value = alloca i32, align 4
  %bucketPos = alloca i32, align 4
  store i32 addrspace(1)* %unsortedData, i32 addrspace(1)** %unsortedData.addr, align 8
  store i32 addrspace(1)* %buckets, i32 addrspace(1)** %buckets.addr, align 8
  store i32 %shiftCount, i32* %shiftCount.addr, align 4
  store i32 addrspace(3)* %sharedArray, i32 addrspace(3)** %sharedArray.addr, align 8
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  store i64 %call, i64* %localId, align 8
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call1, i64* %globalId, align 8
  %call2 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  store i64 %call2, i64* %groupId, align 8
  %call3 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  store i64 %call3, i64* %groupSize, align 8
  %call4 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %call5 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %div = udiv i64 %call4, %call5
  %conv = trunc i64 %div to i32
  store i32 %conv, i32* %numGroups, align 4
  %0 = load i64* %localId, align 8
  %1 = load i32 addrspace(3)** %sharedArray.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(3)* %1, i64 %0
  store i32 0, i32 addrspace(3)* %arrayidx, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %2 = load i64* %globalId, align 8
  %3 = load i32 addrspace(1)** %unsortedData.addr, align 8
  %arrayidx6 = getelementptr inbounds i32 addrspace(1)* %3, i64 %2
  %4 = load i32 addrspace(1)* %arrayidx6, align 4
  store i32 %4, i32* %value, align 4
  %5 = load i32* %value, align 4
  %6 = load i32* %shiftCount.addr, align 4
  %shr.mask = and i32 %6, 31
  %shr = lshr i32 %5, %shr.mask
  %and = and i32 %shr, 255
  store i32 %and, i32* %value, align 4
  %7 = load i32 addrspace(3)** %sharedArray.addr, align 8
  %8 = load i32* %value, align 4
  %idx.ext = zext i32 %8 to i64
  %add.ptr = getelementptr inbounds i32 addrspace(3)* %7, i64 %idx.ext
  %call7 = call cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)* %add.ptr)
  call cc75 void @_Z7barrierj(i32 1)
  %9 = load i64* %groupId, align 8
  %10 = load i64* %groupSize, align 8
  %mul = mul i64 %9, %10
  %11 = load i64* %localId, align 8
  %add = add i64 %mul, %11
  %conv8 = trunc i64 %add to i32
  store i32 %conv8, i32* %bucketPos, align 4
  %12 = load i64* %localId, align 8
  %13 = load i32 addrspace(3)** %sharedArray.addr, align 8
  %arrayidx9 = getelementptr inbounds i32 addrspace(3)* %13, i64 %12
  %14 = load i32 addrspace(3)* %arrayidx9, align 4
  %15 = load i32* %bucketPos, align 4
  %idxprom = zext i32 %15 to i64
  %16 = load i32 addrspace(1)** %buckets.addr, align 8
  %arrayidx10 = getelementptr inbounds i32 addrspace(1)* %16, i64 %idxprom
  store i32 %14, i32 addrspace(1)* %arrayidx10, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

declare cc75 void @_Z7barrierj(i32)

declare cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)*)

; Function Attrs: nounwind
define cc76 void @__OpenCL_permute_kernel(i32 addrspace(1)* %unsortedData, i32 addrspace(1)* %scanedBuckets, i32 %shiftCount, i16 addrspace(3)* %sharedBuckets, i32 addrspace(1)* %sortedData) #0 {
entry:
  %unsortedData.addr = alloca i32 addrspace(1)*, align 8
  %scanedBuckets.addr = alloca i32 addrspace(1)*, align 8
  %shiftCount.addr = alloca i32, align 4
  %sharedBuckets.addr = alloca i16 addrspace(3)*, align 8
  %sortedData.addr = alloca i32 addrspace(1)*, align 8
  %groupId = alloca i64, align 8
  %localId = alloca i64, align 8
  %globalId = alloca i64, align 8
  %groupSize = alloca i64, align 8
  %i = alloca i32, align 4
  %bucketPos = alloca i32, align 4
  %i13 = alloca i32, align 4
  %value = alloca i32, align 4
  %index = alloca i32, align 4
  store i32 addrspace(1)* %unsortedData, i32 addrspace(1)** %unsortedData.addr, align 8
  store i32 addrspace(1)* %scanedBuckets, i32 addrspace(1)** %scanedBuckets.addr, align 8
  store i32 %shiftCount, i32* %shiftCount.addr, align 4
  store i16 addrspace(3)* %sharedBuckets, i16 addrspace(3)** %sharedBuckets.addr, align 8
  store i32 addrspace(1)* %sortedData, i32 addrspace(1)** %sortedData.addr, align 8
  %call = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  store i64 %call, i64* %groupId, align 8
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  store i64 %call1, i64* %localId, align 8
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call2, i64* %globalId, align 8
  %call3 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  store i64 %call3, i64* %groupSize, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %i, align 4
  %cmp = icmp slt i32 %0, 256
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i64* %groupId, align 8
  %mul = mul i64 %1, 256
  %2 = load i64* %groupSize, align 8
  %mul4 = mul i64 %mul, %2
  %3 = load i64* %localId, align 8
  %mul5 = mul i64 %3, 256
  %add = add i64 %mul4, %mul5
  %4 = load i32* %i, align 4
  %conv = sext i32 %4 to i64
  %add6 = add i64 %add, %conv
  %conv7 = trunc i64 %add6 to i32
  store i32 %conv7, i32* %bucketPos, align 4
  %5 = load i32* %bucketPos, align 4
  %idxprom = zext i32 %5 to i64
  %6 = load i32 addrspace(1)** %scanedBuckets.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %6, i64 %idxprom
  %7 = load i32 addrspace(1)* %arrayidx, align 4
  %conv8 = trunc i32 %7 to i16
  %8 = load i64* %localId, align 8
  %mul9 = mul i64 %8, 256
  %9 = load i32* %i, align 4
  %conv10 = sext i32 %9 to i64
  %add11 = add i64 %mul9, %conv10
  %10 = load i16 addrspace(3)** %sharedBuckets.addr, align 8
  %arrayidx12 = getelementptr inbounds i16 addrspace(3)* %10, i64 %add11
  store i16 %conv8, i16 addrspace(3)* %arrayidx12, align 2
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %11 = load i32* %i, align 4
  %inc = add nsw i32 %11, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %i13, align 4
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc39, %for.end
  %12 = load i32* %i13, align 4
  %cmp15 = icmp slt i32 %12, 256
  br i1 %cmp15, label %for.body17, label %for.end41

for.body17:                                       ; preds = %for.cond14
  %13 = load i64* %globalId, align 8
  %mul18 = mul i64 %13, 256
  %14 = load i32* %i13, align 4
  %conv19 = sext i32 %14 to i64
  %add20 = add i64 %mul18, %conv19
  %15 = load i32 addrspace(1)** %unsortedData.addr, align 8
  %arrayidx21 = getelementptr inbounds i32 addrspace(1)* %15, i64 %add20
  %16 = load i32 addrspace(1)* %arrayidx21, align 4
  store i32 %16, i32* %value, align 4
  %17 = load i32* %value, align 4
  %18 = load i32* %shiftCount.addr, align 4
  %shr.mask = and i32 %18, 31
  %shr = lshr i32 %17, %shr.mask
  %and = and i32 %shr, 255
  store i32 %and, i32* %value, align 4
  %19 = load i64* %localId, align 8
  %mul22 = mul i64 %19, 256
  %20 = load i32* %value, align 4
  %conv23 = zext i32 %20 to i64
  %add24 = add i64 %mul22, %conv23
  %21 = load i16 addrspace(3)** %sharedBuckets.addr, align 8
  %arrayidx25 = getelementptr inbounds i16 addrspace(3)* %21, i64 %add24
  %22 = load i16 addrspace(3)* %arrayidx25, align 2
  %conv26 = zext i16 %22 to i32
  store i32 %conv26, i32* %index, align 4
  %23 = load i64* %globalId, align 8
  %mul27 = mul i64 %23, 256
  %24 = load i32* %i13, align 4
  %conv28 = sext i32 %24 to i64
  %add29 = add i64 %mul27, %conv28
  %25 = load i32 addrspace(1)** %unsortedData.addr, align 8
  %arrayidx30 = getelementptr inbounds i32 addrspace(1)* %25, i64 %add29
  %26 = load i32 addrspace(1)* %arrayidx30, align 4
  %27 = load i32* %index, align 4
  %idxprom31 = zext i32 %27 to i64
  %28 = load i32 addrspace(1)** %sortedData.addr, align 8
  %arrayidx32 = getelementptr inbounds i32 addrspace(1)* %28, i64 %idxprom31
  store i32 %26, i32 addrspace(1)* %arrayidx32, align 4
  %29 = load i32* %index, align 4
  %add33 = add i32 %29, 1
  %conv34 = trunc i32 %add33 to i16
  %30 = load i64* %localId, align 8
  %mul35 = mul i64 %30, 256
  %31 = load i32* %value, align 4
  %conv36 = zext i32 %31 to i64
  %add37 = add i64 %mul35, %conv36
  %32 = load i16 addrspace(3)** %sharedBuckets.addr, align 8
  %arrayidx38 = getelementptr inbounds i16 addrspace(3)* %32, i64 %add37
  store i16 %conv34, i16 addrspace(3)* %arrayidx38, align 2
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc39

for.inc39:                                        ; preds = %for.body17
  %33 = load i32* %i13, align 4
  %inc40 = add nsw i32 %33, 1
  store i32 %inc40, i32* %i13, align 4
  br label %for.cond14

for.end41:                                        ; preds = %for.cond14
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_ScanArraysdim2_kernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size, i32 %stride, i32 addrspace(1)* %sumBuffer) #0 {
entry:
  %output.addr = alloca i32 addrspace(1)*, align 8
  %input.addr = alloca i32 addrspace(1)*, align 8
  %block.addr = alloca i32 addrspace(3)*, align 8
  %block_size.addr = alloca i32, align 4
  %stride.addr = alloca i32, align 4
  %sumBuffer.addr = alloca i32 addrspace(1)*, align 8
  %tidx = alloca i32, align 4
  %tidy = alloca i32, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %bidx = alloca i32, align 4
  %bidy = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %gpos = alloca i32, align 4
  %groupIndex = alloca i32, align 4
  %cache = alloca i32, align 4
  %dis = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 addrspace(3)* %block, i32 addrspace(3)** %block.addr, align 8
  store i32 %block_size, i32* %block_size.addr, align 4
  store i32 %stride, i32* %stride.addr, align 4
  store i32 addrspace(1)* %sumBuffer, i32 addrspace(1)** %sumBuffer.addr, align 8
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tidx, align 4
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %tidy, align 4
  %call3 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %gidx, align 4
  %call5 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %gidy, align 4
  %call7 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv8 = trunc i64 %call7 to i32
  store i32 %conv8, i32* %bidx, align 4
  %call9 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv10 = trunc i64 %call9 to i32
  store i32 %conv10, i32* %bidy, align 4
  %0 = load i32* %tidy, align 4
  %1 = load i32* %block_size.addr, align 4
  %mul = mul i32 %0, %1
  %2 = load i32* %tidx, align 4
  %add = add i32 %mul, %2
  store i32 %add, i32* %lIndex, align 4
  %3 = load i32* %gidx, align 4
  %shl = shl i32 %3, 8
  %4 = load i32* %gidy, align 4
  %add11 = add nsw i32 %shl, %4
  store i32 %add11, i32* %gpos, align 4
  %5 = load i32* %bidy, align 4
  %conv12 = sext i32 %5 to i64
  %call13 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %6 = load i32* %block_size.addr, align 4
  %conv14 = zext i32 %6 to i64
  %div = udiv i64 %call13, %conv14
  %mul15 = mul i64 %conv12, %div
  %7 = load i32* %bidx, align 4
  %conv16 = sext i32 %7 to i64
  %add17 = add i64 %mul15, %conv16
  %conv18 = trunc i64 %add17 to i32
  store i32 %conv18, i32* %groupIndex, align 4
  %8 = load i32* %gpos, align 4
  %idxprom = sext i32 %8 to i64
  %9 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %9, i64 %idxprom
  %10 = load i32 addrspace(1)* %arrayidx, align 4
  %11 = load i32* %tidx, align 4
  %idxprom19 = sext i32 %11 to i64
  %12 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx20 = getelementptr inbounds i32 addrspace(3)* %12, i64 %idxprom19
  store i32 %10, i32 addrspace(3)* %arrayidx20, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %13 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx21 = getelementptr inbounds i32 addrspace(3)* %13, i64 0
  %14 = load i32 addrspace(3)* %arrayidx21, align 4
  store i32 %14, i32* %cache, align 4
  store i32 1, i32* %dis, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %15 = load i32* %dis, align 4
  %16 = load i32* %block_size.addr, align 4
  %cmp = icmp ult i32 %15, %16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %17 = load i32* %tidx, align 4
  %18 = load i32* %dis, align 4
  %cmp23 = icmp sge i32 %17, %18
  br i1 %cmp23, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %19 = load i32* %tidx, align 4
  %20 = load i32* %dis, align 4
  %sub = sub nsw i32 %19, %20
  %idxprom25 = sext i32 %sub to i64
  %21 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx26 = getelementptr inbounds i32 addrspace(3)* %21, i64 %idxprom25
  %22 = load i32 addrspace(3)* %arrayidx26, align 4
  %23 = load i32* %tidx, align 4
  %idxprom27 = sext i32 %23 to i64
  %24 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx28 = getelementptr inbounds i32 addrspace(3)* %24, i64 %idxprom27
  %25 = load i32 addrspace(3)* %arrayidx28, align 4
  %add29 = add i32 %22, %25
  store i32 %add29, i32* %cache, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  call cc75 void @_Z7barrierj(i32 1)
  %26 = load i32* %cache, align 4
  %27 = load i32* %tidx, align 4
  %idxprom30 = sext i32 %27 to i64
  %28 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx31 = getelementptr inbounds i32 addrspace(3)* %28, i64 %idxprom30
  store i32 %26, i32 addrspace(3)* %arrayidx31, align 4
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %29 = load i32* %dis, align 4
  %mul32 = mul nsw i32 %29, 2
  store i32 %mul32, i32* %dis, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %30 = load i32* %block_size.addr, align 4
  %sub33 = sub i32 %30, 1
  %idxprom34 = zext i32 %sub33 to i64
  %31 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx35 = getelementptr inbounds i32 addrspace(3)* %31, i64 %idxprom34
  %32 = load i32 addrspace(3)* %arrayidx35, align 4
  %33 = load i32* %groupIndex, align 4
  %idxprom36 = sext i32 %33 to i64
  %34 = load i32 addrspace(1)** %sumBuffer.addr, align 8
  %arrayidx37 = getelementptr inbounds i32 addrspace(1)* %34, i64 %idxprom36
  store i32 %32, i32 addrspace(1)* %arrayidx37, align 4
  %35 = load i32* %tidx, align 4
  %cmp38 = icmp eq i32 %35, 0
  br i1 %cmp38, label %if.then40, label %if.else

if.then40:                                        ; preds = %for.end
  %36 = load i32* %gpos, align 4
  %idxprom41 = sext i32 %36 to i64
  %37 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx42 = getelementptr inbounds i32 addrspace(1)* %37, i64 %idxprom41
  store i32 0, i32 addrspace(1)* %arrayidx42, align 4
  br label %if.end48

if.else:                                          ; preds = %for.end
  %38 = load i32* %tidx, align 4
  %sub43 = sub nsw i32 %38, 1
  %idxprom44 = sext i32 %sub43 to i64
  %39 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx45 = getelementptr inbounds i32 addrspace(3)* %39, i64 %idxprom44
  %40 = load i32 addrspace(3)* %arrayidx45, align 4
  %41 = load i32* %gpos, align 4
  %idxprom46 = sext i32 %41 to i64
  %42 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx47 = getelementptr inbounds i32 addrspace(1)* %42, i64 %idxprom46
  store i32 %40, i32 addrspace(1)* %arrayidx47, align 4
  br label %if.end48

if.end48:                                         ; preds = %if.else, %if.then40
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_ScanArraysdim1_kernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size) #0 {
entry:
  %output.addr = alloca i32 addrspace(1)*, align 8
  %input.addr = alloca i32 addrspace(1)*, align 8
  %block.addr = alloca i32 addrspace(3)*, align 8
  %block_size.addr = alloca i32, align 4
  %tid = alloca i32, align 4
  %gid = alloca i32, align 4
  %bid = alloca i32, align 4
  %cache = alloca i32, align 4
  %stride = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 addrspace(3)* %block, i32 addrspace(3)** %block.addr, align 8
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
  %idxprom = sext i32 %0 to i64
  %1 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %1, i64 %idxprom
  %2 = load i32 addrspace(1)* %arrayidx, align 4
  %3 = load i32* %tid, align 4
  %idxprom5 = sext i32 %3 to i64
  %4 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx6 = getelementptr inbounds i32 addrspace(3)* %4, i64 %idxprom5
  store i32 %2, i32 addrspace(3)* %arrayidx6, align 4
  %5 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx7 = getelementptr inbounds i32 addrspace(3)* %5, i64 0
  %6 = load i32 addrspace(3)* %arrayidx7, align 4
  store i32 %6, i32* %cache, align 4
  store i32 1, i32* %stride, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %7 = load i32* %stride, align 4
  %8 = load i32* %block_size.addr, align 4
  %cmp = icmp ult i32 %7, %8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %9 = load i32* %tid, align 4
  %10 = load i32* %stride, align 4
  %cmp9 = icmp sge i32 %9, %10
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %11 = load i32* %tid, align 4
  %12 = load i32* %stride, align 4
  %sub = sub nsw i32 %11, %12
  %idxprom11 = sext i32 %sub to i64
  %13 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx12 = getelementptr inbounds i32 addrspace(3)* %13, i64 %idxprom11
  %14 = load i32 addrspace(3)* %arrayidx12, align 4
  %15 = load i32* %tid, align 4
  %idxprom13 = sext i32 %15 to i64
  %16 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx14 = getelementptr inbounds i32 addrspace(3)* %16, i64 %idxprom13
  %17 = load i32 addrspace(3)* %arrayidx14, align 4
  %add = add i32 %14, %17
  store i32 %add, i32* %cache, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  call cc75 void @_Z7barrierj(i32 1)
  %18 = load i32* %cache, align 4
  %19 = load i32* %tid, align 4
  %idxprom15 = sext i32 %19 to i64
  %20 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx16 = getelementptr inbounds i32 addrspace(3)* %20, i64 %idxprom15
  store i32 %18, i32 addrspace(3)* %arrayidx16, align 4
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %21 = load i32* %stride, align 4
  %mul = mul nsw i32 %21, 2
  store i32 %mul, i32* %stride, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %22 = load i32* %tid, align 4
  %cmp17 = icmp eq i32 %22, 0
  br i1 %cmp17, label %if.then19, label %if.else

if.then19:                                        ; preds = %for.end
  %23 = load i32* %gid, align 4
  %idxprom20 = sext i32 %23 to i64
  %24 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx21 = getelementptr inbounds i32 addrspace(1)* %24, i64 %idxprom20
  store i32 0, i32 addrspace(1)* %arrayidx21, align 4
  br label %if.end27

if.else:                                          ; preds = %for.end
  %25 = load i32* %tid, align 4
  %sub22 = sub nsw i32 %25, 1
  %idxprom23 = sext i32 %sub22 to i64
  %26 = load i32 addrspace(3)** %block.addr, align 8
  %arrayidx24 = getelementptr inbounds i32 addrspace(3)* %26, i64 %idxprom23
  %27 = load i32 addrspace(3)* %arrayidx24, align 4
  %28 = load i32* %gid, align 4
  %idxprom25 = sext i32 %28 to i64
  %29 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx26 = getelementptr inbounds i32 addrspace(1)* %29, i64 %idxprom25
  store i32 %27, i32 addrspace(1)* %arrayidx26, align 4
  br label %if.end27

if.end27:                                         ; preds = %if.else, %if.then19
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_prefixSum_kernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(1)* %summary, i32 %stride) #0 {
entry:
  %output.addr = alloca i32 addrspace(1)*, align 8
  %input.addr = alloca i32 addrspace(1)*, align 8
  %summary.addr = alloca i32 addrspace(1)*, align 8
  %stride.addr = alloca i32, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %Index = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 addrspace(1)* %summary, i32 addrspace(1)** %summary.addr, align 8
  store i32 %stride, i32* %stride.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gidx, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %gidy, align 4
  %0 = load i32* %gidy, align 4
  %1 = load i32* %stride.addr, align 4
  %mul = mul nsw i32 %0, %1
  %2 = load i32* %gidx, align 4
  %add = add nsw i32 %mul, %2
  store i32 %add, i32* %Index, align 4
  %3 = load i32* %Index, align 4
  %idxprom = sext i32 %3 to i64
  %4 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %4, i64 %idxprom
  store i32 0, i32 addrspace(1)* %arrayidx, align 4
  %5 = load i32* %gidx, align 4
  %cmp = icmp sgt i32 %5, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.then
  %6 = load i32* %i, align 4
  %7 = load i32* %gidx, align 4
  %cmp4 = icmp slt i32 %6, %7
  br i1 %cmp4, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %8 = load i32* %gidy, align 4
  %9 = load i32* %stride.addr, align 4
  %mul6 = mul nsw i32 %8, %9
  %10 = load i32* %i, align 4
  %add7 = add nsw i32 %mul6, %10
  %idxprom8 = sext i32 %add7 to i64
  %11 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx9 = getelementptr inbounds i32 addrspace(1)* %11, i64 %idxprom8
  %12 = load i32 addrspace(1)* %arrayidx9, align 4
  %13 = load i32* %Index, align 4
  %idxprom10 = sext i32 %13 to i64
  %14 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx11 = getelementptr inbounds i32 addrspace(1)* %14, i64 %idxprom10
  %15 = load i32 addrspace(1)* %arrayidx11, align 4
  %add12 = add i32 %15, %12
  store i32 %add12, i32 addrspace(1)* %arrayidx11, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %16 = load i32* %i, align 4
  %inc = add nsw i32 %16, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %if.end

if.end:                                           ; preds = %for.end, %entry
  %17 = load i32* %gidx, align 4
  %18 = load i32* %stride.addr, align 4
  %sub = sub nsw i32 %18, 1
  %cmp13 = icmp eq i32 %17, %sub
  br i1 %cmp13, label %if.then15, label %if.end26

if.then15:                                        ; preds = %if.end
  %19 = load i32* %Index, align 4
  %idxprom16 = sext i32 %19 to i64
  %20 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx17 = getelementptr inbounds i32 addrspace(1)* %20, i64 %idxprom16
  %21 = load i32 addrspace(1)* %arrayidx17, align 4
  %22 = load i32* %gidy, align 4
  %23 = load i32* %stride.addr, align 4
  %mul18 = mul nsw i32 %22, %23
  %24 = load i32* %stride.addr, align 4
  %sub19 = sub nsw i32 %24, 1
  %add20 = add nsw i32 %mul18, %sub19
  %idxprom21 = sext i32 %add20 to i64
  %25 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx22 = getelementptr inbounds i32 addrspace(1)* %25, i64 %idxprom21
  %26 = load i32 addrspace(1)* %arrayidx22, align 4
  %add23 = add i32 %21, %26
  %27 = load i32* %gidy, align 4
  %idxprom24 = sext i32 %27 to i64
  %28 = load i32 addrspace(1)** %summary.addr, align 8
  %arrayidx25 = getelementptr inbounds i32 addrspace(1)* %28, i64 %idxprom24
  store i32 %add23, i32 addrspace(1)* %arrayidx25, align 4
  br label %if.end26

if.end26:                                         ; preds = %if.then15, %if.end
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_blockAddition_kernel(i32 addrspace(1)* %input, i32 addrspace(1)* %output, i32 %stride) #0 {
entry:
  %input.addr = alloca i32 addrspace(1)*, align 8
  %output.addr = alloca i32 addrspace(1)*, align 8
  %stride.addr = alloca i32, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %bidx = alloca i32, align 4
  %bidy = alloca i32, align 4
  %gpos = alloca i32, align 4
  %groupIndex = alloca i32, align 4
  %temp = alloca i32, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  store i32 %stride, i32* %stride.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gidx, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %gidy, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %bidx, align 4
  %call5 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %bidy, align 4
  %0 = load i32* %gidy, align 4
  %1 = load i32* %gidx, align 4
  %shl = shl i32 %1, 8
  %add = add nsw i32 %0, %shl
  store i32 %add, i32* %gpos, align 4
  %2 = load i32* %bidy, align 4
  %3 = load i32* %stride.addr, align 4
  %mul = mul i32 %2, %3
  %4 = load i32* %bidx, align 4
  %add7 = add i32 %mul, %4
  store i32 %add7, i32* %groupIndex, align 4
  %5 = load i32* %groupIndex, align 4
  %idxprom = sext i32 %5 to i64
  %6 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %6, i64 %idxprom
  %7 = load i32 addrspace(1)* %arrayidx, align 4
  store i32 %7, i32* %temp, align 4
  %8 = load i32* %temp, align 4
  %9 = load i32* %gpos, align 4
  %idxprom8 = sext i32 %9 to i64
  %10 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx9 = getelementptr inbounds i32 addrspace(1)* %10, i64 %idxprom8
  %11 = load i32 addrspace(1)* %arrayidx9, align 4
  %add10 = add i32 %11, %8
  store i32 %add10, i32 addrspace(1)* %arrayidx9, align 4
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_FixOffset_kernel(i32 addrspace(1)* %input, i32 addrspace(1)* %output) #0 {
entry:
  %input.addr = alloca i32 addrspace(1)*, align 8
  %output.addr = alloca i32 addrspace(1)*, align 8
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %gpos = alloca i32, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gidx, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %gidy, align 4
  %0 = load i32* %gidy, align 4
  %1 = load i32* %gidx, align 4
  %shl = shl i32 %1, 8
  %add = add nsw i32 %0, %shl
  store i32 %add, i32* %gpos, align 4
  %2 = load i32* %gidy, align 4
  %idxprom = sext i32 %2 to i64
  %3 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %3, i64 %idxprom
  %4 = load i32 addrspace(1)* %arrayidx, align 4
  %5 = load i32* %gpos, align 4
  %idxprom3 = sext i32 %5 to i64
  %6 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx4 = getelementptr inbounds i32 addrspace(1)* %6, i64 %idxprom3
  %7 = load i32 addrspace(1)* %arrayidx4, align 4
  %add5 = add i32 %7, %4
  store i32 %add5, i32 addrspace(1)* %arrayidx4, align 4
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !12, !18, !23, !28, !34}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!40}
!opencl.spir.version = !{!40}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(3)*)* @__OpenCL_histogram_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 3}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"uint", metadata !"uint*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"const", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"uint", metadata !"uint*"}
!6 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i16 addrspace(3)*, i32 addrspace(1)*)* @__OpenCL_permute_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 3, i32 1}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"uint", metadata !"ushort*", metadata !"uint*"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"const", metadata !"const", metadata !"", metadata !"", metadata !""}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"uint", metadata !"ushort*", metadata !"uint*"}
!12 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32, i32, i32 addrspace(1)*)* @__OpenCL_ScanArraysdim2_kernel, metadata !13, metadata !14, metadata !15, metadata !16, metadata !17}
!13 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0, i32 0, i32 1}
!14 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!15 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint*"}
!16 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"const", metadata !"const", metadata !""}
!17 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint*"}
!18 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32)* @__OpenCL_ScanArraysdim1_kernel, metadata !19, metadata !2, metadata !20, metadata !21, metadata !22}
!19 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0}
!20 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"uint*", metadata !"uint"}
!21 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"const"}
!22 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"uint*", metadata !"uint"}
!23 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*, i32)* @__OpenCL_prefixSum_kernel, metadata !24, metadata !2, metadata !25, metadata !26, metadata !27}
!24 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0}
!25 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"uint*", metadata !"int"}
!26 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !""}
!27 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"uint*", metadata !"int"}
!28 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @__OpenCL_blockAddition_kernel, metadata !29, metadata !30, metadata !31, metadata !32, metadata !33}
!29 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!30 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!31 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"uint"}
!32 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!33 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"uint"}
!34 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @__OpenCL_FixOffset_kernel, metadata !35, metadata !36, metadata !37, metadata !38, metadata !39}
!35 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!36 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!37 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*"}
!38 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!39 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*"}
!40 = metadata !{i32 1, i32 2}

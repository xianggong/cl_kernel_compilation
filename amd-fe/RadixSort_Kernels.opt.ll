; ModuleID = 'RadixSort_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_histogram_kernel(i32 addrspace(1)* %unsortedData, i32 addrspace(1)* %buckets, i32 %shiftCount, i32 addrspace(3)* %sharedArray) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call2 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %call3 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %call4 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %call5 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %div = udiv i64 %call4, %call5
  %conv = trunc i64 %div to i32
  %arrayidx = getelementptr inbounds i32 addrspace(3)* %sharedArray, i64 %call
  store i32 0, i32 addrspace(3)* %arrayidx, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %arrayidx6 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i64 %call1
  %0 = load i32 addrspace(1)* %arrayidx6, align 4
  %shr.mask = and i32 %shiftCount, 31
  %shr = lshr i32 %0, %shr.mask
  %and = and i32 %shr, 255
  %idx.ext = zext i32 %and to i64
  %add.ptr = getelementptr inbounds i32 addrspace(3)* %sharedArray, i64 %idx.ext
  %call7 = call cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)* %add.ptr)
  call cc75 void @_Z7barrierj(i32 1)
  %mul = mul i64 %call2, %call3
  %add = add i64 %mul, %call
  %conv8 = trunc i64 %add to i32
  %arrayidx9 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i64 %call
  %1 = load i32 addrspace(3)* %arrayidx9, align 4
  %idxprom = zext i32 %conv8 to i64
  %arrayidx10 = getelementptr inbounds i32 addrspace(1)* %buckets, i64 %idxprom
  store i32 %1, i32 addrspace(1)* %arrayidx10, align 4
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
  %call = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call3 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 256
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul i64 %call, 256
  %mul4 = mul i64 %mul, %call3
  %mul5 = mul i64 %call1, 256
  %add = add i64 %mul4, %mul5
  %conv = sext i32 %i.0 to i64
  %add6 = add i64 %add, %conv
  %conv7 = trunc i64 %add6 to i32
  %idxprom = zext i32 %conv7 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %conv8 = trunc i32 %0 to i16
  %mul9 = mul i64 %call1, 256
  %conv10 = sext i32 %i.0 to i64
  %add11 = add i64 %mul9, %conv10
  %arrayidx12 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i64 %add11
  store i16 %conv8, i16 addrspace(3)* %arrayidx12, align 2
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc39, %for.end
  %i13.0 = phi i32 [ 0, %for.end ], [ %inc40, %for.inc39 ]
  %cmp15 = icmp slt i32 %i13.0, 256
  br i1 %cmp15, label %for.body17, label %for.end41

for.body17:                                       ; preds = %for.cond14
  %mul18 = mul i64 %call2, 256
  %conv19 = sext i32 %i13.0 to i64
  %add20 = add i64 %mul18, %conv19
  %arrayidx21 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i64 %add20
  %1 = load i32 addrspace(1)* %arrayidx21, align 4
  %shr.mask = and i32 %shiftCount, 31
  %shr = lshr i32 %1, %shr.mask
  %and = and i32 %shr, 255
  %mul22 = mul i64 %call1, 256
  %conv23 = zext i32 %and to i64
  %add24 = add i64 %mul22, %conv23
  %arrayidx25 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i64 %add24
  %2 = load i16 addrspace(3)* %arrayidx25, align 2
  %conv26 = zext i16 %2 to i32
  %mul27 = mul i64 %call2, 256
  %conv28 = sext i32 %i13.0 to i64
  %add29 = add i64 %mul27, %conv28
  %arrayidx30 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i64 %add29
  %3 = load i32 addrspace(1)* %arrayidx30, align 4
  %idxprom31 = zext i32 %conv26 to i64
  %arrayidx32 = getelementptr inbounds i32 addrspace(1)* %sortedData, i64 %idxprom31
  store i32 %3, i32 addrspace(1)* %arrayidx32, align 4
  %add33 = add i32 %conv26, 1
  %conv34 = trunc i32 %add33 to i16
  %mul35 = mul i64 %call1, 256
  %conv36 = zext i32 %and to i64
  %add37 = add i64 %mul35, %conv36
  %arrayidx38 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i64 %add37
  store i16 %conv34, i16 addrspace(3)* %arrayidx38, align 2
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc39

for.inc39:                                        ; preds = %for.body17
  %inc40 = add nsw i32 %i13.0, 1
  br label %for.cond14

for.end41:                                        ; preds = %for.cond14
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_ScanArraysdim2_kernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size, i32 %stride, i32 addrspace(1)* %sumBuffer) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %call7 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv8 = trunc i64 %call7 to i32
  %call9 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv10 = trunc i64 %call9 to i32
  %mul = mul i32 %conv2, %block_size
  %add = add i32 %mul, %conv
  %shl = shl i32 %conv4, 8
  %add11 = add nsw i32 %shl, %conv6
  %conv12 = sext i32 %conv10 to i64
  %call13 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv14 = zext i32 %block_size to i64
  %div = udiv i64 %call13, %conv14
  %mul15 = mul i64 %conv12, %div
  %conv16 = sext i32 %conv8 to i64
  %add17 = add i64 %mul15, %conv16
  %conv18 = trunc i64 %add17 to i32
  %idxprom = sext i32 %add11 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %idxprom19 = sext i32 %conv to i64
  %arrayidx20 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom19
  store i32 %0, i32 addrspace(3)* %arrayidx20, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %arrayidx21 = getelementptr inbounds i32 addrspace(3)* %block, i64 0
  %1 = load i32 addrspace(3)* %arrayidx21, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %cache.0 = phi i32 [ %1, %entry ], [ %cache.1, %for.inc ]
  %dis.0 = phi i32 [ 1, %entry ], [ %mul32, %for.inc ]
  %cmp = icmp ult i32 %dis.0, %block_size
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %cmp23 = icmp sge i32 %conv, %dis.0
  br i1 %cmp23, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %sub = sub nsw i32 %conv, %dis.0
  %idxprom25 = sext i32 %sub to i64
  %arrayidx26 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom25
  %2 = load i32 addrspace(3)* %arrayidx26, align 4
  %idxprom27 = sext i32 %conv to i64
  %arrayidx28 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom27
  %3 = load i32 addrspace(3)* %arrayidx28, align 4
  %add29 = add i32 %2, %3
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %cache.1 = phi i32 [ %add29, %if.then ], [ %cache.0, %for.body ]
  call cc75 void @_Z7barrierj(i32 1)
  %idxprom30 = sext i32 %conv to i64
  %arrayidx31 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom30
  store i32 %cache.1, i32 addrspace(3)* %arrayidx31, align 4
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %mul32 = mul nsw i32 %dis.0, 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %sub33 = sub i32 %block_size, 1
  %idxprom34 = zext i32 %sub33 to i64
  %arrayidx35 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom34
  %4 = load i32 addrspace(3)* %arrayidx35, align 4
  %idxprom36 = sext i32 %conv18 to i64
  %arrayidx37 = getelementptr inbounds i32 addrspace(1)* %sumBuffer, i64 %idxprom36
  store i32 %4, i32 addrspace(1)* %arrayidx37, align 4
  %cmp38 = icmp eq i32 %conv, 0
  br i1 %cmp38, label %if.then40, label %if.else

if.then40:                                        ; preds = %for.end
  %idxprom41 = sext i32 %add11 to i64
  %arrayidx42 = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom41
  store i32 0, i32 addrspace(1)* %arrayidx42, align 4
  br label %if.end48

if.else:                                          ; preds = %for.end
  %sub43 = sub nsw i32 %conv, 1
  %idxprom44 = sext i32 %sub43 to i64
  %arrayidx45 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom44
  %5 = load i32 addrspace(3)* %arrayidx45, align 4
  %idxprom46 = sext i32 %add11 to i64
  %arrayidx47 = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom46
  store i32 %5, i32 addrspace(1)* %arrayidx47, align 4
  br label %if.end48

if.end48:                                         ; preds = %if.else, %if.then40
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_ScanArraysdim1_kernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %idxprom = sext i32 %conv2 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %idxprom5 = sext i32 %conv to i64
  %arrayidx6 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom5
  store i32 %0, i32 addrspace(3)* %arrayidx6, align 4
  %arrayidx7 = getelementptr inbounds i32 addrspace(3)* %block, i64 0
  %1 = load i32 addrspace(3)* %arrayidx7, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %cache.0 = phi i32 [ %1, %entry ], [ %cache.1, %for.inc ]
  %stride.0 = phi i32 [ 1, %entry ], [ %mul, %for.inc ]
  %cmp = icmp ult i32 %stride.0, %block_size
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %cmp9 = icmp sge i32 %conv, %stride.0
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %sub = sub nsw i32 %conv, %stride.0
  %idxprom11 = sext i32 %sub to i64
  %arrayidx12 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom11
  %2 = load i32 addrspace(3)* %arrayidx12, align 4
  %idxprom13 = sext i32 %conv to i64
  %arrayidx14 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom13
  %3 = load i32 addrspace(3)* %arrayidx14, align 4
  %add = add i32 %2, %3
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %cache.1 = phi i32 [ %add, %if.then ], [ %cache.0, %for.body ]
  call cc75 void @_Z7barrierj(i32 1)
  %idxprom15 = sext i32 %conv to i64
  %arrayidx16 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom15
  store i32 %cache.1, i32 addrspace(3)* %arrayidx16, align 4
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %mul = mul nsw i32 %stride.0, 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %cmp17 = icmp eq i32 %conv, 0
  br i1 %cmp17, label %if.then19, label %if.else

if.then19:                                        ; preds = %for.end
  %idxprom20 = sext i32 %conv2 to i64
  %arrayidx21 = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom20
  store i32 0, i32 addrspace(1)* %arrayidx21, align 4
  br label %if.end27

if.else:                                          ; preds = %for.end
  %sub22 = sub nsw i32 %conv, 1
  %idxprom23 = sext i32 %sub22 to i64
  %arrayidx24 = getelementptr inbounds i32 addrspace(3)* %block, i64 %idxprom23
  %4 = load i32 addrspace(3)* %arrayidx24, align 4
  %idxprom25 = sext i32 %conv2 to i64
  %arrayidx26 = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom25
  store i32 %4, i32 addrspace(1)* %arrayidx26, align 4
  br label %if.end27

if.end27:                                         ; preds = %if.else, %if.then19
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_prefixSum_kernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(1)* %summary, i32 %stride) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %mul = mul nsw i32 %conv2, %stride
  %add = add nsw i32 %mul, %conv
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom
  store i32 0, i32 addrspace(1)* %arrayidx, align 4
  %cmp = icmp sgt i32 %conv, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.then
  %i.0 = phi i32 [ 0, %if.then ], [ %inc, %for.inc ]
  %cmp4 = icmp slt i32 %i.0, %conv
  br i1 %cmp4, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul6 = mul nsw i32 %conv2, %stride
  %add7 = add nsw i32 %mul6, %i.0
  %idxprom8 = sext i32 %add7 to i64
  %arrayidx9 = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom8
  %0 = load i32 addrspace(1)* %arrayidx9, align 4
  %idxprom10 = sext i32 %add to i64
  %arrayidx11 = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom10
  %1 = load i32 addrspace(1)* %arrayidx11, align 4
  %add12 = add i32 %1, %0
  store i32 %add12, i32 addrspace(1)* %arrayidx11, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %if.end

if.end:                                           ; preds = %for.end, %entry
  %sub = sub nsw i32 %stride, 1
  %cmp13 = icmp eq i32 %conv, %sub
  br i1 %cmp13, label %if.then15, label %if.end26

if.then15:                                        ; preds = %if.end
  %idxprom16 = sext i32 %add to i64
  %arrayidx17 = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom16
  %2 = load i32 addrspace(1)* %arrayidx17, align 4
  %mul18 = mul nsw i32 %conv2, %stride
  %sub19 = sub nsw i32 %stride, 1
  %add20 = add nsw i32 %mul18, %sub19
  %idxprom21 = sext i32 %add20 to i64
  %arrayidx22 = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom21
  %3 = load i32 addrspace(1)* %arrayidx22, align 4
  %add23 = add i32 %2, %3
  %idxprom24 = sext i32 %conv2 to i64
  %arrayidx25 = getelementptr inbounds i32 addrspace(1)* %summary, i64 %idxprom24
  store i32 %add23, i32 addrspace(1)* %arrayidx25, align 4
  br label %if.end26

if.end26:                                         ; preds = %if.then15, %if.end
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_blockAddition_kernel(i32 addrspace(1)* %input, i32 addrspace(1)* %output, i32 %stride) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %shl = shl i32 %conv, 8
  %add = add nsw i32 %conv2, %shl
  %mul = mul i32 %conv6, %stride
  %add7 = add i32 %mul, %conv4
  %idxprom = sext i32 %add7 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %idxprom8 = sext i32 %add to i64
  %arrayidx9 = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom8
  %1 = load i32 addrspace(1)* %arrayidx9, align 4
  %add10 = add i32 %1, %0
  store i32 %add10, i32 addrspace(1)* %arrayidx9, align 4
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_FixOffset_kernel(i32 addrspace(1)* %input, i32 addrspace(1)* %output) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %shl = shl i32 %conv, 8
  %add = add nsw i32 %conv2, %shl
  %idxprom = sext i32 %conv2 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %idxprom3 = sext i32 %add to i64
  %arrayidx4 = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom3
  %1 = load i32 addrspace(1)* %arrayidx4, align 4
  %add5 = add i32 %1, %0
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

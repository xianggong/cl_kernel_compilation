; ModuleID = 'StringSearch_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@StringSearchNaive.groupSuccessCounter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack1Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack2Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.groupSuccessCounter = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define cc75 i32 @compare(i8 addrspace(1)* %text, i8 addrspace(3)* %pattern, i32 %length) #0 {
entry:
  %retval = alloca i32, align 4
  %text.addr = alloca i8 addrspace(1)*, align 8
  %pattern.addr = alloca i8 addrspace(3)*, align 8
  %length.addr = alloca i32, align 4
  %l = alloca i32, align 4
  store i8 addrspace(1)* %text, i8 addrspace(1)** %text.addr, align 8
  store i8 addrspace(3)* %pattern, i8 addrspace(3)** %pattern.addr, align 8
  store i32 %length, i32* %length.addr, align 4
  store i32 0, i32* %l, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %l, align 4
  %1 = load i32* %length.addr, align 4
  %cmp = icmp ult i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32* %l, align 4
  %idxprom = zext i32 %2 to i64
  %3 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %3, i64 %idxprom
  %4 = load i8 addrspace(1)* %arrayidx, align 1
  %conv = zext i8 %4 to i32
  %cmp1 = icmp sle i32 65, %conv
  br i1 %cmp1, label %land.lhs.true, label %cond.false

land.lhs.true:                                    ; preds = %for.body
  %5 = load i32* %l, align 4
  %idxprom3 = zext i32 %5 to i64
  %6 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx4 = getelementptr inbounds i8 addrspace(1)* %6, i64 %idxprom3
  %7 = load i8 addrspace(1)* %arrayidx4, align 1
  %conv5 = zext i8 %7 to i32
  %cmp6 = icmp sle i32 %conv5, 90
  br i1 %cmp6, label %cond.true, label %cond.false

cond.true:                                        ; preds = %land.lhs.true
  %8 = load i32* %l, align 4
  %idxprom8 = zext i32 %8 to i64
  %9 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx9 = getelementptr inbounds i8 addrspace(1)* %9, i64 %idxprom8
  %10 = load i8 addrspace(1)* %arrayidx9, align 1
  %conv10 = zext i8 %10 to i32
  %sub = sub nsw i32 %conv10, 65
  %add = add nsw i32 %sub, 97
  br label %cond.end

cond.false:                                       ; preds = %land.lhs.true, %for.body
  %11 = load i32* %l, align 4
  %idxprom11 = zext i32 %11 to i64
  %12 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx12 = getelementptr inbounds i8 addrspace(1)* %12, i64 %idxprom11
  %13 = load i8 addrspace(1)* %arrayidx12, align 1
  %conv13 = zext i8 %13 to i32
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %add, %cond.true ], [ %conv13, %cond.false ]
  %14 = load i32* %l, align 4
  %idxprom14 = zext i32 %14 to i64
  %15 = load i8 addrspace(3)** %pattern.addr, align 8
  %arrayidx15 = getelementptr inbounds i8 addrspace(3)* %15, i64 %idxprom14
  %16 = load i8 addrspace(3)* %arrayidx15, align 1
  %conv16 = zext i8 %16 to i32
  %cmp17 = icmp ne i32 %cond, %conv16
  br i1 %cmp17, label %if.then, label %if.end

if.then:                                          ; preds = %cond.end
  store i32 0, i32* %retval
  br label %return

if.end:                                           ; preds = %cond.end
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %17 = load i32* %l, align 4
  %inc = add i32 %17, 1
  store i32 %inc, i32* %l, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i32 1, i32* %retval
  br label %return

return:                                           ; preds = %for.end, %if.then
  %18 = load i32* %retval
  ret i32 %18
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_StringSearchNaive_kernel(i8 addrspace(1)* %text, i32 %textLength, i8 addrspace(1)* %pattern, i32 %patternLength, i32 addrspace(1)* %resultBuffer, i32 addrspace(1)* %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* %localPattern) #0 {
entry:
  %text.addr = alloca i8 addrspace(1)*, align 8
  %textLength.addr = alloca i32, align 4
  %pattern.addr = alloca i8 addrspace(1)*, align 8
  %patternLength.addr = alloca i32, align 4
  %resultBuffer.addr = alloca i32 addrspace(1)*, align 8
  %resultCountPerWG.addr = alloca i32 addrspace(1)*, align 8
  %maxSearchLength.addr = alloca i32, align 4
  %localPattern.addr = alloca i8 addrspace(3)*, align 8
  %localIdx = alloca i32, align 4
  %localSize = alloca i32, align 4
  %groupIdx = alloca i32, align 4
  %lastSearchIdx = alloca i32, align 4
  %beginSearchIdx = alloca i32, align 4
  %endSearchIdx = alloca i32, align 4
  %idx = alloca i32, align 4
  %stringPos = alloca i32, align 4
  %count = alloca i32, align 4
  store i8 addrspace(1)* %text, i8 addrspace(1)** %text.addr, align 8
  store i32 %textLength, i32* %textLength.addr, align 4
  store i8 addrspace(1)* %pattern, i8 addrspace(1)** %pattern.addr, align 8
  store i32 %patternLength, i32* %patternLength.addr, align 4
  store i32 addrspace(1)* %resultBuffer, i32 addrspace(1)** %resultBuffer.addr, align 8
  store i32 addrspace(1)* %resultCountPerWG, i32 addrspace(1)** %resultCountPerWG.addr, align 8
  store i32 %maxSearchLength, i32* %maxSearchLength.addr, align 4
  store i8 addrspace(3)* %localPattern, i8 addrspace(3)** %localPattern.addr, align 8
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %localIdx, align 4
  %call1 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %localSize, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %groupIdx, align 4
  %0 = load i32* %textLength.addr, align 4
  %1 = load i32* %patternLength.addr, align 4
  %sub = sub i32 %0, %1
  %add = add i32 %sub, 1
  store i32 %add, i32* %lastSearchIdx, align 4
  %2 = load i32* %groupIdx, align 4
  %3 = load i32* %maxSearchLength.addr, align 4
  %mul = mul i32 %2, %3
  store i32 %mul, i32* %beginSearchIdx, align 4
  %4 = load i32* %beginSearchIdx, align 4
  %5 = load i32* %maxSearchLength.addr, align 4
  %add5 = add i32 %4, %5
  store i32 %add5, i32* %endSearchIdx, align 4
  %6 = load i32* %beginSearchIdx, align 4
  %7 = load i32* %lastSearchIdx, align 4
  %cmp = icmp ugt i32 %6, %7
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %if.end59

if.end:                                           ; preds = %entry
  %8 = load i32* %endSearchIdx, align 4
  %9 = load i32* %lastSearchIdx, align 4
  %cmp7 = icmp ugt i32 %8, %9
  br i1 %cmp7, label %if.then9, label %if.end10

if.then9:                                         ; preds = %if.end
  %10 = load i32* %lastSearchIdx, align 4
  store i32 %10, i32* %endSearchIdx, align 4
  br label %if.end10

if.end10:                                         ; preds = %if.then9, %if.end
  %11 = load i32* %localIdx, align 4
  store i32 %11, i32* %idx, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end10
  %12 = load i32* %idx, align 4
  %13 = load i32* %patternLength.addr, align 4
  %cmp11 = icmp ult i32 %12, %13
  br i1 %cmp11, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %14 = load i32* %idx, align 4
  %idxprom = sext i32 %14 to i64
  %15 = load i8 addrspace(1)** %pattern.addr, align 8
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %15, i64 %idxprom
  %16 = load i8 addrspace(1)* %arrayidx, align 1
  %conv13 = zext i8 %16 to i32
  %cmp14 = icmp sle i32 65, %conv13
  br i1 %cmp14, label %land.lhs.true, label %cond.false

land.lhs.true:                                    ; preds = %for.body
  %17 = load i32* %idx, align 4
  %idxprom16 = sext i32 %17 to i64
  %18 = load i8 addrspace(1)** %pattern.addr, align 8
  %arrayidx17 = getelementptr inbounds i8 addrspace(1)* %18, i64 %idxprom16
  %19 = load i8 addrspace(1)* %arrayidx17, align 1
  %conv18 = zext i8 %19 to i32
  %cmp19 = icmp sle i32 %conv18, 90
  br i1 %cmp19, label %cond.true, label %cond.false

cond.true:                                        ; preds = %land.lhs.true
  %20 = load i32* %idx, align 4
  %idxprom21 = sext i32 %20 to i64
  %21 = load i8 addrspace(1)** %pattern.addr, align 8
  %arrayidx22 = getelementptr inbounds i8 addrspace(1)* %21, i64 %idxprom21
  %22 = load i8 addrspace(1)* %arrayidx22, align 1
  %conv23 = zext i8 %22 to i32
  %sub24 = sub nsw i32 %conv23, 65
  %add25 = add nsw i32 %sub24, 97
  br label %cond.end

cond.false:                                       ; preds = %land.lhs.true, %for.body
  %23 = load i32* %idx, align 4
  %idxprom26 = sext i32 %23 to i64
  %24 = load i8 addrspace(1)** %pattern.addr, align 8
  %arrayidx27 = getelementptr inbounds i8 addrspace(1)* %24, i64 %idxprom26
  %25 = load i8 addrspace(1)* %arrayidx27, align 1
  %conv28 = zext i8 %25 to i32
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %add25, %cond.true ], [ %conv28, %cond.false ]
  %conv29 = trunc i32 %cond to i8
  %26 = load i32* %idx, align 4
  %idxprom30 = sext i32 %26 to i64
  %27 = load i8 addrspace(3)** %localPattern.addr, align 8
  %arrayidx31 = getelementptr inbounds i8 addrspace(3)* %27, i64 %idxprom30
  store i8 %conv29, i8 addrspace(3)* %arrayidx31, align 1
  br label %for.inc

for.inc:                                          ; preds = %cond.end
  %28 = load i32* %localSize, align 4
  %29 = load i32* %idx, align 4
  %add32 = add nsw i32 %29, %28
  store i32 %add32, i32* %idx, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %30 = load i32* %localIdx, align 4
  %cmp33 = icmp eq i32 %30, 0
  br i1 %cmp33, label %if.then35, label %if.end36

if.then35:                                        ; preds = %for.end
  store volatile i32 0, i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4
  br label %if.end36

if.end36:                                         ; preds = %if.then35, %for.end
  call cc75 void @_Z7barrierj(i32 1)
  %31 = load i32* %beginSearchIdx, align 4
  %32 = load i32* %localIdx, align 4
  %add37 = add i32 %31, %32
  store i32 %add37, i32* %stringPos, align 4
  br label %for.cond38

for.cond38:                                       ; preds = %for.inc51, %if.end36
  %33 = load i32* %stringPos, align 4
  %34 = load i32* %endSearchIdx, align 4
  %cmp39 = icmp ult i32 %33, %34
  br i1 %cmp39, label %for.body41, label %for.end53

for.body41:                                       ; preds = %for.cond38
  %35 = load i8 addrspace(1)** %text.addr, align 8
  %36 = load i32* %stringPos, align 4
  %idx.ext = zext i32 %36 to i64
  %add.ptr = getelementptr inbounds i8 addrspace(1)* %35, i64 %idx.ext
  %37 = load i8 addrspace(3)** %localPattern.addr, align 8
  %38 = load i32* %patternLength.addr, align 4
  %call42 = call cc75 i32 @compare(i8 addrspace(1)* %add.ptr, i8 addrspace(3)* %37, i32 %38)
  %cmp43 = icmp eq i32 %call42, 1
  br i1 %cmp43, label %if.then45, label %if.end50

if.then45:                                        ; preds = %for.body41
  %call46 = call cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter)
  store i32 %call46, i32* %count, align 4
  %39 = load i32* %stringPos, align 4
  %40 = load i32* %beginSearchIdx, align 4
  %41 = load i32* %count, align 4
  %add47 = add i32 %40, %41
  %idxprom48 = zext i32 %add47 to i64
  %42 = load i32 addrspace(1)** %resultBuffer.addr, align 8
  %arrayidx49 = getelementptr inbounds i32 addrspace(1)* %42, i64 %idxprom48
  store i32 %39, i32 addrspace(1)* %arrayidx49, align 4
  br label %if.end50

if.end50:                                         ; preds = %if.then45, %for.body41
  br label %for.inc51

for.inc51:                                        ; preds = %if.end50
  %43 = load i32* %localSize, align 4
  %44 = load i32* %stringPos, align 4
  %add52 = add i32 %44, %43
  store i32 %add52, i32* %stringPos, align 4
  br label %for.cond38

for.end53:                                        ; preds = %for.cond38
  call cc75 void @_Z7barrierj(i32 1)
  %45 = load i32* %localIdx, align 4
  %cmp54 = icmp eq i32 %45, 0
  br i1 %cmp54, label %if.then56, label %if.end59

if.then56:                                        ; preds = %for.end53
  %46 = load volatile i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4
  %47 = load i32* %groupIdx, align 4
  %idxprom57 = sext i32 %47 to i64
  %48 = load i32 addrspace(1)** %resultCountPerWG.addr, align 8
  %arrayidx58 = getelementptr inbounds i32 addrspace(1)* %48, i64 %idxprom57
  store i32 %46, i32 addrspace(1)* %arrayidx58, align 4
  br label %if.end59

if.end59:                                         ; preds = %if.then56, %for.end53, %if.then
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

declare cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)*)

; Function Attrs: nounwind
define cc76 void @__OpenCL_StringSearchLoadBalance_kernel(i8 addrspace(1)* %text, i32 %textLength, i8 addrspace(1)* %pattern, i32 %patternLength, i32 addrspace(1)* %resultBuffer, i32 addrspace(1)* %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* %localPattern, i32 addrspace(3)* %stack1) #0 {
entry:
  %text.addr = alloca i8 addrspace(1)*, align 8
  %textLength.addr = alloca i32, align 4
  %pattern.addr = alloca i8 addrspace(1)*, align 8
  %patternLength.addr = alloca i32, align 4
  %resultBuffer.addr = alloca i32 addrspace(1)*, align 8
  %resultCountPerWG.addr = alloca i32 addrspace(1)*, align 8
  %maxSearchLength.addr = alloca i32, align 4
  %localPattern.addr = alloca i8 addrspace(3)*, align 8
  %stack1.addr = alloca i32 addrspace(3)*, align 8
  %localIdx = alloca i32, align 4
  %localSize = alloca i32, align 4
  %groupIdx = alloca i32, align 4
  %lastSearchIdx = alloca i32, align 4
  %stackSize = alloca i32, align 4
  %beginSearchIdx = alloca i32, align 4
  %endSearchIdx = alloca i32, align 4
  %searchLength = alloca i32, align 4
  %idx = alloca i32, align 4
  %first = alloca i8, align 1
  %second = alloca i8, align 1
  %stringPos = alloca i32, align 4
  %stackPos = alloca i32, align 4
  %revStackPos = alloca i32, align 4
  %pos = alloca i32, align 4
  %count = alloca i32, align 4
  store i8 addrspace(1)* %text, i8 addrspace(1)** %text.addr, align 8
  store i32 %textLength, i32* %textLength.addr, align 4
  store i8 addrspace(1)* %pattern, i8 addrspace(1)** %pattern.addr, align 8
  store i32 %patternLength, i32* %patternLength.addr, align 4
  store i32 addrspace(1)* %resultBuffer, i32 addrspace(1)** %resultBuffer.addr, align 8
  store i32 addrspace(1)* %resultCountPerWG, i32 addrspace(1)** %resultCountPerWG.addr, align 8
  store i32 %maxSearchLength, i32* %maxSearchLength.addr, align 4
  store i8 addrspace(3)* %localPattern, i8 addrspace(3)** %localPattern.addr, align 8
  store i32 addrspace(3)* %stack1, i32 addrspace(3)** %stack1.addr, align 8
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %localIdx, align 4
  %call1 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %localSize, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %groupIdx, align 4
  %0 = load i32* %localIdx, align 4
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack2Counter, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %1 = load i32* %textLength.addr, align 4
  %2 = load i32* %patternLength.addr, align 4
  %sub = sub i32 %1, %2
  %add = add i32 %sub, 1
  store i32 %add, i32* %lastSearchIdx, align 4
  store i32 0, i32* %stackSize, align 4
  %3 = load i32* %groupIdx, align 4
  %4 = load i32* %maxSearchLength.addr, align 4
  %mul = mul i32 %3, %4
  store i32 %mul, i32* %beginSearchIdx, align 4
  %5 = load i32* %beginSearchIdx, align 4
  %6 = load i32* %maxSearchLength.addr, align 4
  %add6 = add i32 %5, %6
  store i32 %add6, i32* %endSearchIdx, align 4
  %7 = load i32* %beginSearchIdx, align 4
  %8 = load i32* %lastSearchIdx, align 4
  %cmp7 = icmp ugt i32 %7, %8
  br i1 %cmp7, label %if.then9, label %if.end10

if.then9:                                         ; preds = %if.end
  br label %if.end162

if.end10:                                         ; preds = %if.end
  %9 = load i32* %endSearchIdx, align 4
  %10 = load i32* %lastSearchIdx, align 4
  %cmp11 = icmp ugt i32 %9, %10
  br i1 %cmp11, label %if.then13, label %if.end14

if.then13:                                        ; preds = %if.end10
  %11 = load i32* %lastSearchIdx, align 4
  store i32 %11, i32* %endSearchIdx, align 4
  br label %if.end14

if.end14:                                         ; preds = %if.then13, %if.end10
  %12 = load i32* %endSearchIdx, align 4
  %13 = load i32* %beginSearchIdx, align 4
  %sub15 = sub i32 %12, %13
  store i32 %sub15, i32* %searchLength, align 4
  %14 = load i32* %localIdx, align 4
  store i32 %14, i32* %idx, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end14
  %15 = load i32* %idx, align 4
  %16 = load i32* %patternLength.addr, align 4
  %cmp16 = icmp ult i32 %15, %16
  br i1 %cmp16, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %17 = load i32* %idx, align 4
  %idxprom = zext i32 %17 to i64
  %18 = load i8 addrspace(1)** %pattern.addr, align 8
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %18, i64 %idxprom
  %19 = load i8 addrspace(1)* %arrayidx, align 1
  %conv18 = zext i8 %19 to i32
  %cmp19 = icmp sle i32 65, %conv18
  br i1 %cmp19, label %land.lhs.true, label %cond.false

land.lhs.true:                                    ; preds = %for.body
  %20 = load i32* %idx, align 4
  %idxprom21 = zext i32 %20 to i64
  %21 = load i8 addrspace(1)** %pattern.addr, align 8
  %arrayidx22 = getelementptr inbounds i8 addrspace(1)* %21, i64 %idxprom21
  %22 = load i8 addrspace(1)* %arrayidx22, align 1
  %conv23 = zext i8 %22 to i32
  %cmp24 = icmp sle i32 %conv23, 90
  br i1 %cmp24, label %cond.true, label %cond.false

cond.true:                                        ; preds = %land.lhs.true
  %23 = load i32* %idx, align 4
  %idxprom26 = zext i32 %23 to i64
  %24 = load i8 addrspace(1)** %pattern.addr, align 8
  %arrayidx27 = getelementptr inbounds i8 addrspace(1)* %24, i64 %idxprom26
  %25 = load i8 addrspace(1)* %arrayidx27, align 1
  %conv28 = zext i8 %25 to i32
  %sub29 = sub nsw i32 %conv28, 65
  %add30 = add nsw i32 %sub29, 97
  br label %cond.end

cond.false:                                       ; preds = %land.lhs.true, %for.body
  %26 = load i32* %idx, align 4
  %idxprom31 = zext i32 %26 to i64
  %27 = load i8 addrspace(1)** %pattern.addr, align 8
  %arrayidx32 = getelementptr inbounds i8 addrspace(1)* %27, i64 %idxprom31
  %28 = load i8 addrspace(1)* %arrayidx32, align 1
  %conv33 = zext i8 %28 to i32
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %add30, %cond.true ], [ %conv33, %cond.false ]
  %conv34 = trunc i32 %cond to i8
  %29 = load i32* %idx, align 4
  %idxprom35 = zext i32 %29 to i64
  %30 = load i8 addrspace(3)** %localPattern.addr, align 8
  %arrayidx36 = getelementptr inbounds i8 addrspace(3)* %30, i64 %idxprom35
  store i8 %conv34, i8 addrspace(3)* %arrayidx36, align 1
  br label %for.inc

for.inc:                                          ; preds = %cond.end
  %31 = load i32* %localSize, align 4
  %32 = load i32* %idx, align 4
  %add37 = add i32 %32, %31
  store i32 %add37, i32* %idx, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  %33 = load i8 addrspace(3)** %localPattern.addr, align 8
  %arrayidx38 = getelementptr inbounds i8 addrspace(3)* %33, i64 0
  %34 = load i8 addrspace(3)* %arrayidx38, align 1
  store i8 %34, i8* %first, align 1
  %35 = load i8 addrspace(3)** %localPattern.addr, align 8
  %arrayidx39 = getelementptr inbounds i8 addrspace(3)* %35, i64 1
  %36 = load i8 addrspace(3)* %arrayidx39, align 1
  store i8 %36, i8* %second, align 1
  %37 = load i32* %localIdx, align 4
  store i32 %37, i32* %stringPos, align 4
  store i32 0, i32* %stackPos, align 4
  store i32 0, i32* %revStackPos, align 4
  br label %while.body

while.body:                                       ; preds = %if.end156, %if.then121, %for.end
  %38 = load i32* %stringPos, align 4
  %39 = load i32* %searchLength, align 4
  %cmp40 = icmp ult i32 %38, %39
  br i1 %cmp40, label %if.then42, label %if.end113

if.then42:                                        ; preds = %while.body
  %40 = load i8* %first, align 1
  %conv43 = zext i8 %40 to i32
  %41 = load i32* %beginSearchIdx, align 4
  %42 = load i32* %stringPos, align 4
  %add44 = add i32 %41, %42
  %idxprom45 = zext i32 %add44 to i64
  %43 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx46 = getelementptr inbounds i8 addrspace(1)* %43, i64 %idxprom45
  %44 = load i8 addrspace(1)* %arrayidx46, align 1
  %conv47 = zext i8 %44 to i32
  %cmp48 = icmp sle i32 65, %conv47
  br i1 %cmp48, label %land.lhs.true50, label %cond.false64

land.lhs.true50:                                  ; preds = %if.then42
  %45 = load i32* %beginSearchIdx, align 4
  %46 = load i32* %stringPos, align 4
  %add51 = add i32 %45, %46
  %idxprom52 = zext i32 %add51 to i64
  %47 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx53 = getelementptr inbounds i8 addrspace(1)* %47, i64 %idxprom52
  %48 = load i8 addrspace(1)* %arrayidx53, align 1
  %conv54 = zext i8 %48 to i32
  %cmp55 = icmp sle i32 %conv54, 90
  br i1 %cmp55, label %cond.true57, label %cond.false64

cond.true57:                                      ; preds = %land.lhs.true50
  %49 = load i32* %beginSearchIdx, align 4
  %50 = load i32* %stringPos, align 4
  %add58 = add i32 %49, %50
  %idxprom59 = zext i32 %add58 to i64
  %51 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx60 = getelementptr inbounds i8 addrspace(1)* %51, i64 %idxprom59
  %52 = load i8 addrspace(1)* %arrayidx60, align 1
  %conv61 = zext i8 %52 to i32
  %sub62 = sub nsw i32 %conv61, 65
  %add63 = add nsw i32 %sub62, 97
  br label %cond.end69

cond.false64:                                     ; preds = %land.lhs.true50, %if.then42
  %53 = load i32* %beginSearchIdx, align 4
  %54 = load i32* %stringPos, align 4
  %add65 = add i32 %53, %54
  %idxprom66 = zext i32 %add65 to i64
  %55 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx67 = getelementptr inbounds i8 addrspace(1)* %55, i64 %idxprom66
  %56 = load i8 addrspace(1)* %arrayidx67, align 1
  %conv68 = zext i8 %56 to i32
  br label %cond.end69

cond.end69:                                       ; preds = %cond.false64, %cond.true57
  %cond70 = phi i32 [ %add63, %cond.true57 ], [ %conv68, %cond.false64 ]
  %cmp71 = icmp eq i32 %conv43, %cond70
  br i1 %cmp71, label %land.lhs.true73, label %if.end112

land.lhs.true73:                                  ; preds = %cond.end69
  %57 = load i8* %second, align 1
  %conv74 = zext i8 %57 to i32
  %58 = load i32* %beginSearchIdx, align 4
  %59 = load i32* %stringPos, align 4
  %add75 = add i32 %58, %59
  %add76 = add i32 %add75, 1
  %idxprom77 = zext i32 %add76 to i64
  %60 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx78 = getelementptr inbounds i8 addrspace(1)* %60, i64 %idxprom77
  %61 = load i8 addrspace(1)* %arrayidx78, align 1
  %conv79 = zext i8 %61 to i32
  %cmp80 = icmp sle i32 65, %conv79
  br i1 %cmp80, label %land.lhs.true82, label %cond.false98

land.lhs.true82:                                  ; preds = %land.lhs.true73
  %62 = load i32* %beginSearchIdx, align 4
  %63 = load i32* %stringPos, align 4
  %add83 = add i32 %62, %63
  %add84 = add i32 %add83, 1
  %idxprom85 = zext i32 %add84 to i64
  %64 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx86 = getelementptr inbounds i8 addrspace(1)* %64, i64 %idxprom85
  %65 = load i8 addrspace(1)* %arrayidx86, align 1
  %conv87 = zext i8 %65 to i32
  %cmp88 = icmp sle i32 %conv87, 90
  br i1 %cmp88, label %cond.true90, label %cond.false98

cond.true90:                                      ; preds = %land.lhs.true82
  %66 = load i32* %beginSearchIdx, align 4
  %67 = load i32* %stringPos, align 4
  %add91 = add i32 %66, %67
  %add92 = add i32 %add91, 1
  %idxprom93 = zext i32 %add92 to i64
  %68 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx94 = getelementptr inbounds i8 addrspace(1)* %68, i64 %idxprom93
  %69 = load i8 addrspace(1)* %arrayidx94, align 1
  %conv95 = zext i8 %69 to i32
  %sub96 = sub nsw i32 %conv95, 65
  %add97 = add nsw i32 %sub96, 97
  br label %cond.end104

cond.false98:                                     ; preds = %land.lhs.true82, %land.lhs.true73
  %70 = load i32* %beginSearchIdx, align 4
  %71 = load i32* %stringPos, align 4
  %add99 = add i32 %70, %71
  %add100 = add i32 %add99, 1
  %idxprom101 = zext i32 %add100 to i64
  %72 = load i8 addrspace(1)** %text.addr, align 8
  %arrayidx102 = getelementptr inbounds i8 addrspace(1)* %72, i64 %idxprom101
  %73 = load i8 addrspace(1)* %arrayidx102, align 1
  %conv103 = zext i8 %73 to i32
  br label %cond.end104

cond.end104:                                      ; preds = %cond.false98, %cond.true90
  %cond105 = phi i32 [ %add97, %cond.true90 ], [ %conv103, %cond.false98 ]
  %cmp106 = icmp eq i32 %conv74, %cond105
  br i1 %cmp106, label %if.then108, label %if.end112

if.then108:                                       ; preds = %cond.end104
  %call109 = call cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter)
  store i32 %call109, i32* %stackPos, align 4
  %74 = load i32* %stringPos, align 4
  %75 = load i32* %stackPos, align 4
  %idxprom110 = sext i32 %75 to i64
  %76 = load i32 addrspace(3)** %stack1.addr, align 8
  %arrayidx111 = getelementptr inbounds i32 addrspace(3)* %76, i64 %idxprom110
  store i32 %74, i32 addrspace(3)* %arrayidx111, align 4
  br label %if.end112

if.end112:                                        ; preds = %if.then108, %cond.end104, %cond.end69
  br label %if.end113

if.end113:                                        ; preds = %if.end112, %while.body
  %77 = load i32* %localSize, align 4
  %78 = load i32* %stringPos, align 4
  %add114 = add nsw i32 %78, %77
  store i32 %add114, i32* %stringPos, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %79 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  store i32 %79, i32* %stackSize, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %80 = load i32* %stackSize, align 4
  %81 = load i32* %localSize, align 4
  %cmp115 = icmp ult i32 %80, %81
  br i1 %cmp115, label %land.lhs.true117, label %if.end122

land.lhs.true117:                                 ; preds = %if.end113
  %82 = load i32* %stringPos, align 4
  %83 = load i32* %localSize, align 4
  %div = sdiv i32 %82, %83
  %84 = load i32* %localSize, align 4
  %mul118 = mul nsw i32 %div, %84
  %85 = load i32* %searchLength, align 4
  %cmp119 = icmp ult i32 %mul118, %85
  br i1 %cmp119, label %if.then121, label %if.end122

if.then121:                                       ; preds = %land.lhs.true117
  br label %while.body

if.end122:                                        ; preds = %land.lhs.true117, %if.end113
  %86 = load i32* %localIdx, align 4
  %87 = load i32* %stackSize, align 4
  %cmp123 = icmp ult i32 %86, %87
  br i1 %cmp123, label %if.then125, label %if.end144

if.then125:                                       ; preds = %if.end122
  %call126 = call cc75 i32 @_Z10atomic_decPVU3AS3j(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter)
  store i32 %call126, i32* %revStackPos, align 4
  %88 = load i32* %revStackPos, align 4
  %dec = add nsw i32 %88, -1
  store i32 %dec, i32* %revStackPos, align 4
  %idxprom127 = sext i32 %dec to i64
  %89 = load i32 addrspace(3)** %stack1.addr, align 8
  %arrayidx128 = getelementptr inbounds i32 addrspace(3)* %89, i64 %idxprom127
  %90 = load i32 addrspace(3)* %arrayidx128, align 4
  store i32 %90, i32* %pos, align 4
  %91 = load i8 addrspace(1)** %text.addr, align 8
  %92 = load i32* %beginSearchIdx, align 4
  %idx.ext = zext i32 %92 to i64
  %add.ptr = getelementptr inbounds i8 addrspace(1)* %91, i64 %idx.ext
  %93 = load i32* %pos, align 4
  %idx.ext129 = sext i32 %93 to i64
  %add.ptr130 = getelementptr inbounds i8 addrspace(1)* %add.ptr, i64 %idx.ext129
  %add.ptr131 = getelementptr inbounds i8 addrspace(1)* %add.ptr130, i64 2
  %94 = load i8 addrspace(3)** %localPattern.addr, align 8
  %add.ptr132 = getelementptr inbounds i8 addrspace(3)* %94, i64 2
  %95 = load i32* %patternLength.addr, align 4
  %sub133 = sub i32 %95, 2
  %call134 = call cc75 i32 @compare(i8 addrspace(1)* %add.ptr131, i8 addrspace(3)* %add.ptr132, i32 %sub133)
  %cmp135 = icmp eq i32 %call134, 1
  br i1 %cmp135, label %if.then137, label %if.end143

if.then137:                                       ; preds = %if.then125
  %call138 = call cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter)
  store i32 %call138, i32* %count, align 4
  %96 = load i32* %beginSearchIdx, align 4
  %97 = load i32* %pos, align 4
  %add139 = add i32 %96, %97
  %98 = load i32* %beginSearchIdx, align 4
  %99 = load i32* %count, align 4
  %add140 = add i32 %98, %99
  %idxprom141 = zext i32 %add140 to i64
  %100 = load i32 addrspace(1)** %resultBuffer.addr, align 8
  %arrayidx142 = getelementptr inbounds i32 addrspace(1)* %100, i64 %idxprom141
  store i32 %add139, i32 addrspace(1)* %arrayidx142, align 4
  br label %if.end143

if.end143:                                        ; preds = %if.then137, %if.then125
  br label %if.end144

if.end144:                                        ; preds = %if.end143, %if.end122
  call cc75 void @_Z7barrierj(i32 1)
  %101 = load i32* %stringPos, align 4
  %102 = load i32* %localSize, align 4
  %div145 = sdiv i32 %101, %102
  %103 = load i32* %localSize, align 4
  %mul146 = mul nsw i32 %div145, %103
  %104 = load i32* %searchLength, align 4
  %cmp147 = icmp uge i32 %mul146, %104
  br i1 %cmp147, label %land.lhs.true149, label %if.end156

land.lhs.true149:                                 ; preds = %if.end144
  %105 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  %cmp150 = icmp ule i32 %105, 0
  br i1 %cmp150, label %land.lhs.true152, label %if.end156

land.lhs.true152:                                 ; preds = %land.lhs.true149
  %106 = load i32 addrspace(3)* @StringSearchLoadBalance.stack2Counter, align 4
  %cmp153 = icmp ule i32 %106, 0
  br i1 %cmp153, label %if.then155, label %if.end156

if.then155:                                       ; preds = %land.lhs.true152
  br label %while.end

if.end156:                                        ; preds = %land.lhs.true152, %land.lhs.true149, %if.end144
  br label %while.body

while.end:                                        ; preds = %if.then155
  %107 = load i32* %localIdx, align 4
  %cmp157 = icmp eq i32 %107, 0
  br i1 %cmp157, label %if.then159, label %if.end162

if.then159:                                       ; preds = %while.end
  %108 = load i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4
  %109 = load i32* %groupIdx, align 4
  %idxprom160 = sext i32 %109 to i64
  %110 = load i32 addrspace(1)** %resultCountPerWG.addr, align 8
  %arrayidx161 = getelementptr inbounds i32 addrspace(1)* %110, i64 %idxprom160
  store i32 %108, i32 addrspace(1)* %arrayidx161, align 4
  br label %if.end162

if.end162:                                        ; preds = %if.then159, %while.end, %if.then9
  ret void
}

declare cc75 i32 @_Z10atomic_decPVU3AS3j(i32 addrspace(3)*)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!12}
!opencl.spir.version = !{!12}

!0 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*)* @__OpenCL_StringSearchNaive_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 0, i32 1, i32 1, i32 0, i32 3}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar*", metadata !"uint", metadata !"uchar*", metadata !"uint", metadata !"int*", metadata !"int*", metadata !"uint", metadata !"uchar*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"const", metadata !"const", metadata !"const", metadata !"", metadata !"", metadata !"const", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar*", metadata !"uint", metadata !"uchar*", metadata !"uint", metadata !"int*", metadata !"int*", metadata !"uint", metadata !"uchar*"}
!6 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*, i32 addrspace(3)*)* @__OpenCL_StringSearchLoadBalance_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 0, i32 1, i32 1, i32 0, i32 3, i32 3}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"uchar*", metadata !"uint", metadata !"uchar*", metadata !"uint", metadata !"int*", metadata !"int*", metadata !"uint", metadata !"uchar*", metadata !"int*"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"const", metadata !"const", metadata !"const", metadata !"", metadata !"", metadata !"const", metadata !"", metadata !""}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar*", metadata !"uint", metadata !"uchar*", metadata !"uint", metadata !"int*", metadata !"int*", metadata !"uint", metadata !"uchar*", metadata !"int*"}
!12 = metadata !{i32 1, i32 2}

; ModuleID = 'ConcurrentKernel_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@K2.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K4.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K6.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K8.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K10.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1

; Function Attrs: nounwind
define cc75 void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  %gSize = alloca i32, align 4
  %gId = alloca i32, align 4
  %lId = alloca i32, align 4
  %tmp = alloca i32, align 4
  %zero = alloca i32, align 4
  %i = alloca i32, align 4
  %i34 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %call = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gSize, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %gId, align 4
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %lId, align 4
  store i32 1, i32* %tmp, align 4
  store volatile i32 0, i32* %zero, align 4
  store i32 1, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %i, align 4
  %cmp = icmp slt i32 %0, 5000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32* %i, align 4
  %mul = mul nsw i32 %1, 1
  %2 = load i32* %bufferSize.addr, align 4
  %rem = urem i32 %mul, %2
  %idxprom = zext i32 %rem to i64
  %3 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %3, i64 %idxprom
  %4 = load i8 addrspace(1)* %arrayidx, align 1
  %conv8 = zext i8 %4 to i32
  %5 = load i32* %i, align 4
  %mul9 = mul nsw i32 %5, 2
  %6 = load i32* %bufferSize.addr, align 4
  %rem10 = urem i32 %mul9, %6
  %idxprom11 = zext i32 %rem10 to i64
  %7 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx12 = getelementptr inbounds i8 addrspace(1)* %7, i64 %idxprom11
  %8 = load i8 addrspace(1)* %arrayidx12, align 1
  %conv13 = zext i8 %8 to i32
  %add = add nsw i32 %conv8, %conv13
  %9 = load i32* %i, align 4
  %mul14 = mul nsw i32 %9, 3
  %10 = load i32* %bufferSize.addr, align 4
  %rem15 = urem i32 %mul14, %10
  %idxprom16 = zext i32 %rem15 to i64
  %11 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx17 = getelementptr inbounds i8 addrspace(1)* %11, i64 %idxprom16
  %12 = load i8 addrspace(1)* %arrayidx17, align 1
  %conv18 = zext i8 %12 to i32
  %add19 = add nsw i32 %add, %conv18
  %13 = load i32* %i, align 4
  %mul20 = mul nsw i32 %13, 4
  %14 = load i32* %bufferSize.addr, align 4
  %rem21 = urem i32 %mul20, %14
  %idxprom22 = zext i32 %rem21 to i64
  %15 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx23 = getelementptr inbounds i8 addrspace(1)* %15, i64 %idxprom22
  %16 = load i8 addrspace(1)* %arrayidx23, align 1
  %conv24 = zext i8 %16 to i32
  %add25 = add nsw i32 %add19, %conv24
  %17 = load i32* %i, align 4
  %mul26 = mul nsw i32 %17, 5
  %18 = load i32* %bufferSize.addr, align 4
  %rem27 = urem i32 %mul26, %18
  %idxprom28 = zext i32 %rem27 to i64
  %19 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx29 = getelementptr inbounds i8 addrspace(1)* %19, i64 %idxprom28
  %20 = load i8 addrspace(1)* %arrayidx29, align 1
  %conv30 = zext i8 %20 to i32
  %add31 = add nsw i32 %add25, %conv30
  %21 = load i32* %tmp, align 4
  %add32 = add i32 %21, %add31
  store i32 %add32, i32* %tmp, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %22 = load i32* %i, align 4
  %inc = add nsw i32 %22, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %23 = load i32* %gId, align 4
  store i32 %23, i32* %i34, align 4
  br label %for.cond35

for.cond35:                                       ; preds = %for.inc49, %for.end
  %24 = load i32* %i34, align 4
  %25 = load i32* %bufferSize.addr, align 4
  %cmp36 = icmp ult i32 %24, %25
  br i1 %cmp36, label %for.body38, label %for.end51

for.body38:                                       ; preds = %for.cond35
  %26 = load i32* %i34, align 4
  %idxprom39 = zext i32 %26 to i64
  %27 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx40 = getelementptr inbounds i8 addrspace(1)* %27, i64 %idxprom39
  %28 = load i8 addrspace(1)* %arrayidx40, align 1
  %conv41 = zext i8 %28 to i32
  %29 = load i32* %multiplier.addr, align 4
  %mul42 = mul nsw i32 %conv41, %29
  %rem43 = srem i32 %mul42, 256
  %30 = load volatile i32* %zero, align 4
  %31 = load i32* %tmp, align 4
  %mul44 = mul i32 %30, %31
  %add45 = add i32 %rem43, %mul44
  %conv46 = trunc i32 %add45 to i8
  %32 = load i32* %i34, align 4
  %idxprom47 = zext i32 %32 to i64
  %33 = load i8 addrspace(1)** %output.addr, align 8
  %arrayidx48 = getelementptr inbounds i8 addrspace(1)* %33, i64 %idxprom47
  store i8 %conv46, i8 addrspace(1)* %arrayidx48, align 1
  br label %for.inc49

for.inc49:                                        ; preds = %for.body38
  %34 = load i32* %gSize, align 4
  %35 = load i32* %i34, align 4
  %add50 = add i32 %35, %34
  store i32 %add50, i32* %i34, align 4
  br label %for.cond35

for.end51:                                        ; preds = %for.cond35
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind
define cc75 void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* %lds) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  %lds.addr = alloca i8 addrspace(3)*, align 8
  %gSize = alloca i32, align 4
  %gId = alloca i32, align 4
  %lId = alloca i32, align 4
  %tmp = alloca i32, align 4
  %zero = alloca i32, align 4
  %i = alloca i32, align 4
  %i33 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  store i8 addrspace(3)* %lds, i8 addrspace(3)** %lds.addr, align 8
  %call = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gSize, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %gId, align 4
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %lId, align 4
  store i32 1, i32* %tmp, align 4
  store volatile i32 0, i32* %zero, align 4
  store i32 1, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %i, align 4
  %cmp = icmp slt i32 %0, 10000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32* %i, align 4
  %mul = mul nsw i32 %1, 2
  %2 = load i32* %bufferSize.addr, align 4
  %rem = urem i32 %mul, %2
  %idxprom = zext i32 %rem to i64
  %3 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %3, i64 %idxprom
  %4 = load i8 addrspace(1)* %arrayidx, align 1
  %conv8 = zext i8 %4 to i32
  %5 = load i32* %i, align 4
  %mul9 = mul nsw i32 %5, 4
  %6 = load i32* %bufferSize.addr, align 4
  %rem10 = urem i32 %mul9, %6
  %idxprom11 = zext i32 %rem10 to i64
  %7 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx12 = getelementptr inbounds i8 addrspace(1)* %7, i64 %idxprom11
  %8 = load i8 addrspace(1)* %arrayidx12, align 1
  %conv13 = zext i8 %8 to i32
  %sub = sub nsw i32 %conv8, %conv13
  %9 = load i32* %i, align 4
  %mul14 = mul nsw i32 %9, 6
  %10 = load i32* %bufferSize.addr, align 4
  %rem15 = urem i32 %mul14, %10
  %idxprom16 = zext i32 %rem15 to i64
  %11 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx17 = getelementptr inbounds i8 addrspace(1)* %11, i64 %idxprom16
  %12 = load i8 addrspace(1)* %arrayidx17, align 1
  %conv18 = zext i8 %12 to i32
  %add = add nsw i32 %sub, %conv18
  %13 = load i32* %i, align 4
  %mul19 = mul nsw i32 %13, 8
  %14 = load i32* %bufferSize.addr, align 4
  %rem20 = urem i32 %mul19, %14
  %idxprom21 = zext i32 %rem20 to i64
  %15 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx22 = getelementptr inbounds i8 addrspace(1)* %15, i64 %idxprom21
  %16 = load i8 addrspace(1)* %arrayidx22, align 1
  %conv23 = zext i8 %16 to i32
  %sub24 = sub nsw i32 %add, %conv23
  %17 = load i32* %i, align 4
  %mul25 = mul nsw i32 %17, 10
  %18 = load i32* %bufferSize.addr, align 4
  %rem26 = urem i32 %mul25, %18
  %idxprom27 = zext i32 %rem26 to i64
  %19 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx28 = getelementptr inbounds i8 addrspace(1)* %19, i64 %idxprom27
  %20 = load i8 addrspace(1)* %arrayidx28, align 1
  %conv29 = zext i8 %20 to i32
  %add30 = add nsw i32 %sub24, %conv29
  %21 = load i32* %tmp, align 4
  %add31 = add nsw i32 %21, %add30
  store i32 %add31, i32* %tmp, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %22 = load i32* %i, align 4
  %inc = add nsw i32 %22, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %23 = load i32* %gId, align 4
  store i32 %23, i32* %i33, align 4
  br label %for.cond34

for.cond34:                                       ; preds = %for.inc52, %for.end
  %24 = load i32* %i33, align 4
  %25 = load i32* %bufferSize.addr, align 4
  %cmp35 = icmp ult i32 %24, %25
  br i1 %cmp35, label %for.body37, label %for.end54

for.body37:                                       ; preds = %for.cond34
  %26 = load i32* %i33, align 4
  %idxprom38 = zext i32 %26 to i64
  %27 = load i8 addrspace(1)** %input.addr, align 8
  %arrayidx39 = getelementptr inbounds i8 addrspace(1)* %27, i64 %idxprom38
  %28 = load i8 addrspace(1)* %arrayidx39, align 1
  %29 = load i32* %lId, align 4
  %idxprom40 = sext i32 %29 to i64
  %30 = load i8 addrspace(3)** %lds.addr, align 8
  %arrayidx41 = getelementptr inbounds i8 addrspace(3)* %30, i64 %idxprom40
  store i8 %28, i8 addrspace(3)* %arrayidx41, align 1
  %31 = load i32* %lId, align 4
  %idxprom42 = sext i32 %31 to i64
  %32 = load i8 addrspace(3)** %lds.addr, align 8
  %arrayidx43 = getelementptr inbounds i8 addrspace(3)* %32, i64 %idxprom42
  %33 = load i8 addrspace(3)* %arrayidx43, align 1
  %conv44 = zext i8 %33 to i32
  %34 = load i32* %multiplier.addr, align 4
  %mul45 = mul nsw i32 %conv44, %34
  %rem46 = srem i32 %mul45, 256
  %35 = load volatile i32* %zero, align 4
  %36 = load i32* %tmp, align 4
  %mul47 = mul nsw i32 %35, %36
  %add48 = add nsw i32 %rem46, %mul47
  %conv49 = trunc i32 %add48 to i8
  %37 = load i32* %i33, align 4
  %idxprom50 = zext i32 %37 to i64
  %38 = load i8 addrspace(1)** %output.addr, align 8
  %arrayidx51 = getelementptr inbounds i8 addrspace(1)* %38, i64 %idxprom50
  store i8 %conv49, i8 addrspace(1)* %arrayidx51, align 1
  br label %for.inc52

for.inc52:                                        ; preds = %for.body37
  %39 = load i32* %gSize, align 4
  %40 = load i32* %i33, align 4
  %add53 = add i32 %40, %39
  store i32 %add53, i32* %i33, align 4
  br label %for.cond34

for.end54:                                        ; preds = %for.cond34
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K1_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %0 = load i8 addrspace(1)** %input.addr, align 8
  %1 = load i8 addrspace(1)** %output.addr, align 8
  %2 = load i32* %bufferSize.addr, align 4
  %3 = load i32* %multiplier.addr, align 4
  call cc75 void @work1(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i32 %2, i32 %3)
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K2_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %0 = load i8 addrspace(1)** %input.addr, align 8
  %1 = load i8 addrspace(1)** %output.addr, align 8
  %2 = load i32* %bufferSize.addr, align 4
  %3 = load i32* %multiplier.addr, align 4
  call cc75 void @work2(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i32 %2, i32 %3, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K2.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K3_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %0 = load i8 addrspace(1)** %input.addr, align 8
  %1 = load i8 addrspace(1)** %output.addr, align 8
  %2 = load i32* %bufferSize.addr, align 4
  %3 = load i32* %multiplier.addr, align 4
  call cc75 void @work1(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i32 %2, i32 %3)
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K4_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %0 = load i8 addrspace(1)** %input.addr, align 8
  %1 = load i8 addrspace(1)** %output.addr, align 8
  %2 = load i32* %bufferSize.addr, align 4
  %3 = load i32* %multiplier.addr, align 4
  call cc75 void @work2(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i32 %2, i32 %3, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K4.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K5_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %0 = load i8 addrspace(1)** %input.addr, align 8
  %1 = load i8 addrspace(1)** %output.addr, align 8
  %2 = load i32* %bufferSize.addr, align 4
  %3 = load i32* %multiplier.addr, align 4
  call cc75 void @work1(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i32 %2, i32 %3)
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K6_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %0 = load i8 addrspace(1)** %input.addr, align 8
  %1 = load i8 addrspace(1)** %output.addr, align 8
  %2 = load i32* %bufferSize.addr, align 4
  %3 = load i32* %multiplier.addr, align 4
  call cc75 void @work2(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i32 %2, i32 %3, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K6.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K7_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %0 = load i8 addrspace(1)** %input.addr, align 8
  %1 = load i8 addrspace(1)** %output.addr, align 8
  %2 = load i32* %bufferSize.addr, align 4
  %3 = load i32* %multiplier.addr, align 4
  call cc75 void @work1(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i32 %2, i32 %3)
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K8_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %0 = load i8 addrspace(1)** %input.addr, align 8
  %1 = load i8 addrspace(1)** %output.addr, align 8
  %2 = load i32* %bufferSize.addr, align 4
  %3 = load i32* %multiplier.addr, align 4
  call cc75 void @work2(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i32 %2, i32 %3, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K8.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K9_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %0 = load i8 addrspace(1)** %input.addr, align 8
  %1 = load i8 addrspace(1)** %output.addr, align 8
  %2 = load i32* %bufferSize.addr, align 4
  %3 = load i32* %multiplier.addr, align 4
  call cc75 void @work1(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i32 %2, i32 %3)
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K10_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %input.addr = alloca i8 addrspace(1)*, align 8
  %output.addr = alloca i8 addrspace(1)*, align 8
  %bufferSize.addr = alloca i32, align 4
  %multiplier.addr = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input.addr, align 8
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output.addr, align 8
  store i32 %bufferSize, i32* %bufferSize.addr, align 4
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %0 = load i8 addrspace(1)** %input.addr, align 8
  %1 = load i8 addrspace(1)** %output.addr, align 8
  %2 = load i32* %bufferSize.addr, align 4
  %3 = load i32* %multiplier.addr, align 4
  call cc75 void @work2(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i32 %2, i32 %3, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K10.lds, i32 0, i32 0))
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !7, !8, !9, !10, !11, !12, !13, !14}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!15}
!opencl.spir.version = !{!15}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K1_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar*", metadata !"uchar*", metadata !"uint", metadata !"int"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar*", metadata !"uchar*", metadata !"uint", metadata !"int"}
!6 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K2_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!7 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K3_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!8 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K4_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!9 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K5_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!10 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K6_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!11 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K7_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!12 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K8_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!13 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K9_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!14 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K10_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!15 = metadata !{i32 1, i32 2}

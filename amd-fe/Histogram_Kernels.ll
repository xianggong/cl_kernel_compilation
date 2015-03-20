; ModuleID = 'Histogram_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_histogram256_vector_kernel(<4 x i32> addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
entry:
  %data.addr = alloca <4 x i32> addrspace(1)*, align 8
  %sharedArray.addr = alloca i8 addrspace(3)*, align 8
  %binResult.addr = alloca i32 addrspace(1)*, align 8
  %localId = alloca i64, align 8
  %globalId = alloca i64, align 8
  %groupId = alloca i64, align 8
  %groupSize = alloca i64, align 8
  %offSet1 = alloca i32, align 4
  %offSet2 = alloca i32, align 4
  %offSet3 = alloca i32, align 4
  %input = alloca <4 x i8> addrspace(3)*, align 8
  %i = alloca i32, align 4
  %i8 = alloca i32, align 4
  %value = alloca <4 x i32>, align 16
  %binCount = alloca <4 x i32>, align 16
  %result = alloca i32, align 4
  %binVal = alloca <4 x i8>, align 4
  %binValAsUint = alloca <4 x i32>, align 16
  %i46 = alloca i32, align 4
  %passNumber = alloca i32, align 4
  %j = alloca i32, align 4
  %bankNum = alloca i32, align 4
  store <4 x i32> addrspace(1)* %data, <4 x i32> addrspace(1)** %data.addr, align 8
  store i8 addrspace(3)* %sharedArray, i8 addrspace(3)** %sharedArray.addr, align 8
  store i32 addrspace(1)* %binResult, i32 addrspace(1)** %binResult.addr, align 8
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  store i64 %call, i64* %localId, align 8
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call1, i64* %globalId, align 8
  %call2 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  store i64 %call2, i64* %groupId, align 8
  %call3 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  store i64 %call3, i64* %groupSize, align 8
  %0 = load i64* %localId, align 8
  %and = and i64 %0, 31
  %conv = trunc i64 %and to i32
  store i32 %conv, i32* %offSet1, align 4
  %1 = load i32* %offSet1, align 4
  %mul = mul nsw i32 4, %1
  store i32 %mul, i32* %offSet2, align 4
  %2 = load i64* %localId, align 8
  %shr = lshr i64 %2, 5
  %conv4 = trunc i64 %shr to i32
  store i32 %conv4, i32* %offSet3, align 4
  %3 = load i8 addrspace(3)** %sharedArray.addr, align 8
  %4 = bitcast i8 addrspace(3)* %3 to <4 x i8> addrspace(3)*
  store <4 x i8> addrspace(3)* %4, <4 x i8> addrspace(3)** %input, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %5 = load i32* %i, align 4
  %cmp = icmp slt i32 %5, 64
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load i64* %groupSize, align 8
  %7 = load i32* %i, align 4
  %conv6 = sext i32 %7 to i64
  %mul7 = mul i64 %6, %conv6
  %8 = load i64* %localId, align 8
  %add = add i64 %mul7, %8
  %9 = load <4 x i8> addrspace(3)** %input, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(3)* %9, i64 %add
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %10 = load i32* %i, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %i8, align 4
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc43, %for.end
  %11 = load i32* %i8, align 4
  %cmp10 = icmp slt i32 %11, 32
  br i1 %cmp10, label %for.body12, label %for.end45

for.body12:                                       ; preds = %for.cond9
  %12 = load i64* %groupId, align 8
  %13 = load i64* %groupSize, align 8
  %mul13 = mul i64 %13, 256
  %div = udiv i64 %mul13, 8
  %mul14 = mul i64 %12, %div
  %14 = load i32* %i8, align 4
  %conv15 = sext i32 %14 to i64
  %15 = load i64* %groupSize, align 8
  %mul16 = mul i64 %conv15, %15
  %add17 = add i64 %mul14, %mul16
  %16 = load i64* %localId, align 8
  %add18 = add i64 %add17, %16
  %17 = load <4 x i32> addrspace(1)** %data.addr, align 8
  %arrayidx19 = getelementptr inbounds <4 x i32> addrspace(1)* %17, i64 %add18
  %18 = load <4 x i32> addrspace(1)* %arrayidx19, align 16
  store <4 x i32> %18, <4 x i32>* %value, align 16
  %19 = load <4 x i32>* %value, align 16
  %20 = extractelement <4 x i32> %19, i32 0
  %mul20 = mul i32 %20, 128
  %21 = load i32* %offSet2, align 4
  %add21 = add i32 %mul20, %21
  %22 = load i32* %offSet3, align 4
  %add22 = add i32 %add21, %22
  %idxprom = zext i32 %add22 to i64
  %23 = load i8 addrspace(3)** %sharedArray.addr, align 8
  %arrayidx23 = getelementptr inbounds i8 addrspace(3)* %23, i64 %idxprom
  %24 = load i8 addrspace(3)* %arrayidx23, align 1
  %inc24 = add i8 %24, 1
  store i8 %inc24, i8 addrspace(3)* %arrayidx23, align 1
  %25 = load <4 x i32>* %value, align 16
  %26 = extractelement <4 x i32> %25, i32 1
  %mul25 = mul i32 %26, 128
  %27 = load i32* %offSet2, align 4
  %add26 = add i32 %mul25, %27
  %28 = load i32* %offSet3, align 4
  %add27 = add i32 %add26, %28
  %idxprom28 = zext i32 %add27 to i64
  %29 = load i8 addrspace(3)** %sharedArray.addr, align 8
  %arrayidx29 = getelementptr inbounds i8 addrspace(3)* %29, i64 %idxprom28
  %30 = load i8 addrspace(3)* %arrayidx29, align 1
  %inc30 = add i8 %30, 1
  store i8 %inc30, i8 addrspace(3)* %arrayidx29, align 1
  %31 = load <4 x i32>* %value, align 16
  %32 = extractelement <4 x i32> %31, i32 2
  %mul31 = mul i32 %32, 128
  %33 = load i32* %offSet2, align 4
  %add32 = add i32 %mul31, %33
  %34 = load i32* %offSet3, align 4
  %add33 = add i32 %add32, %34
  %idxprom34 = zext i32 %add33 to i64
  %35 = load i8 addrspace(3)** %sharedArray.addr, align 8
  %arrayidx35 = getelementptr inbounds i8 addrspace(3)* %35, i64 %idxprom34
  %36 = load i8 addrspace(3)* %arrayidx35, align 1
  %inc36 = add i8 %36, 1
  store i8 %inc36, i8 addrspace(3)* %arrayidx35, align 1
  %37 = load <4 x i32>* %value, align 16
  %38 = extractelement <4 x i32> %37, i32 3
  %mul37 = mul i32 %38, 128
  %39 = load i32* %offSet2, align 4
  %add38 = add i32 %mul37, %39
  %40 = load i32* %offSet3, align 4
  %add39 = add i32 %add38, %40
  %idxprom40 = zext i32 %add39 to i64
  %41 = load i8 addrspace(3)** %sharedArray.addr, align 8
  %arrayidx41 = getelementptr inbounds i8 addrspace(3)* %41, i64 %idxprom40
  %42 = load i8 addrspace(3)* %arrayidx41, align 1
  %inc42 = add i8 %42, 1
  store i8 %inc42, i8 addrspace(3)* %arrayidx41, align 1
  br label %for.inc43

for.inc43:                                        ; preds = %for.body12
  %43 = load i32* %i8, align 4
  %inc44 = add nsw i32 %43, 1
  store i32 %inc44, i32* %i8, align 4
  br label %for.cond9

for.end45:                                        ; preds = %for.cond9
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %i46, align 4
  br label %for.cond47

for.cond47:                                       ; preds = %for.inc81, %for.end45
  %44 = load i32* %i46, align 4
  %conv48 = sext i32 %44 to i64
  %45 = load i64* %groupSize, align 8
  %div49 = udiv i64 256, %45
  %cmp50 = icmp ult i64 %conv48, %div49
  br i1 %cmp50, label %for.body52, label %for.end83

for.body52:                                       ; preds = %for.cond47
  %46 = load i32* %i46, align 4
  %mul53 = mul nsw i32 4096, %46
  %conv54 = sext i32 %mul53 to i64
  %47 = load i64* %localId, align 8
  %mul55 = mul i64 %47, 32
  %add56 = add i64 %conv54, %mul55
  %conv57 = trunc i64 %add56 to i32
  store i32 %conv57, i32* %passNumber, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %binCount, align 16
  store i32 0, i32* %result, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond58

for.cond58:                                       ; preds = %for.inc69, %for.body52
  %48 = load i32* %j, align 4
  %cmp59 = icmp slt i32 %48, 32
  br i1 %cmp59, label %for.body61, label %for.end71

for.body61:                                       ; preds = %for.cond58
  %49 = load i32* %j, align 4
  %50 = load i32* %offSet1, align 4
  %add62 = add nsw i32 %49, %50
  %and63 = and i32 %add62, 31
  store i32 %and63, i32* %bankNum, align 4
  %51 = load i32* %passNumber, align 4
  %52 = load i32* %bankNum, align 4
  %add64 = add nsw i32 %51, %52
  %idxprom65 = sext i32 %add64 to i64
  %53 = load <4 x i8> addrspace(3)** %input, align 8
  %arrayidx66 = getelementptr inbounds <4 x i8> addrspace(3)* %53, i64 %idxprom65
  %54 = load <4 x i8> addrspace(3)* %arrayidx66, align 4
  store <4 x i8> %54, <4 x i8>* %binVal, align 4
  %55 = load <4 x i8>* %binVal, align 4
  %call67 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %55) #1
  store <4 x i32> %call67, <4 x i32>* %binValAsUint, align 16
  %56 = load <4 x i32>* %binValAsUint, align 16
  %57 = load <4 x i32>* %binCount, align 16
  %add68 = add <4 x i32> %57, %56
  store <4 x i32> %add68, <4 x i32>* %binCount, align 16
  br label %for.inc69

for.inc69:                                        ; preds = %for.body61
  %58 = load i32* %j, align 4
  %inc70 = add nsw i32 %58, 1
  store i32 %inc70, i32* %j, align 4
  br label %for.cond58

for.end71:                                        ; preds = %for.cond58
  %59 = load <4 x i32>* %binCount, align 16
  %60 = extractelement <4 x i32> %59, i32 0
  %61 = load <4 x i32>* %binCount, align 16
  %62 = extractelement <4 x i32> %61, i32 1
  %add72 = add i32 %60, %62
  %63 = load <4 x i32>* %binCount, align 16
  %64 = extractelement <4 x i32> %63, i32 2
  %add73 = add i32 %add72, %64
  %65 = load <4 x i32>* %binCount, align 16
  %66 = extractelement <4 x i32> %65, i32 3
  %add74 = add i32 %add73, %66
  store i32 %add74, i32* %result, align 4
  %67 = load i32* %result, align 4
  %68 = load i64* %groupId, align 8
  %mul75 = mul i64 %68, 256
  %69 = load i64* %groupSize, align 8
  %70 = load i32* %i46, align 4
  %conv76 = sext i32 %70 to i64
  %mul77 = mul i64 %69, %conv76
  %add78 = add i64 %mul75, %mul77
  %71 = load i64* %localId, align 8
  %add79 = add i64 %add78, %71
  %72 = load i32 addrspace(1)** %binResult.addr, align 8
  %arrayidx80 = getelementptr inbounds i32 addrspace(1)* %72, i64 %add79
  store i32 %67, i32 addrspace(1)* %arrayidx80, align 4
  br label %for.inc81

for.inc81:                                        ; preds = %for.end71
  %73 = load i32* %i46, align 4
  %inc82 = add nsw i32 %73, 1
  store i32 %inc82, i32* %i46, align 4
  br label %for.cond47

for.end83:                                        ; preds = %for.cond47
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

declare cc75 void @_Z7barrierj(i32)

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_histogram256_scalar_kernel(i32 addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
entry:
  %data.addr = alloca i32 addrspace(1)*, align 8
  %sharedArray.addr = alloca i8 addrspace(3)*, align 8
  %binResult.addr = alloca i32 addrspace(1)*, align 8
  %localId = alloca i64, align 8
  %globalId = alloca i64, align 8
  %groupId = alloca i64, align 8
  %groupSize = alloca i64, align 8
  %offSet1 = alloca i32, align 4
  %offSet2 = alloca i32, align 4
  %offSet3 = alloca i32, align 4
  %input = alloca <4 x i8> addrspace(3)*, align 8
  %i = alloca i32, align 4
  %i8 = alloca i32, align 4
  %value = alloca i32, align 4
  %binCount = alloca <4 x i32>, align 16
  %result = alloca i32, align 4
  %binVal = alloca <4 x i8>, align 4
  %binValAsUint = alloca <4 x i32>, align 16
  %i28 = alloca i32, align 4
  %passNumber = alloca i32, align 4
  %j = alloca i32, align 4
  %bankNum = alloca i32, align 4
  store i32 addrspace(1)* %data, i32 addrspace(1)** %data.addr, align 8
  store i8 addrspace(3)* %sharedArray, i8 addrspace(3)** %sharedArray.addr, align 8
  store i32 addrspace(1)* %binResult, i32 addrspace(1)** %binResult.addr, align 8
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  store i64 %call, i64* %localId, align 8
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call1, i64* %globalId, align 8
  %call2 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  store i64 %call2, i64* %groupId, align 8
  %call3 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  store i64 %call3, i64* %groupSize, align 8
  %0 = load i64* %localId, align 8
  %and = and i64 %0, 31
  %conv = trunc i64 %and to i32
  store i32 %conv, i32* %offSet1, align 4
  %1 = load i32* %offSet1, align 4
  %mul = mul nsw i32 4, %1
  store i32 %mul, i32* %offSet2, align 4
  %2 = load i64* %localId, align 8
  %shr = lshr i64 %2, 5
  %conv4 = trunc i64 %shr to i32
  store i32 %conv4, i32* %offSet3, align 4
  %3 = load i8 addrspace(3)** %sharedArray.addr, align 8
  %4 = bitcast i8 addrspace(3)* %3 to <4 x i8> addrspace(3)*
  store <4 x i8> addrspace(3)* %4, <4 x i8> addrspace(3)** %input, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %5 = load i32* %i, align 4
  %cmp = icmp slt i32 %5, 64
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load i64* %groupSize, align 8
  %7 = load i32* %i, align 4
  %conv6 = sext i32 %7 to i64
  %mul7 = mul i64 %6, %conv6
  %8 = load i64* %localId, align 8
  %add = add i64 %mul7, %8
  %9 = load <4 x i8> addrspace(3)** %input, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(3)* %9, i64 %add
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %10 = load i32* %i, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %i8, align 4
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc25, %for.end
  %11 = load i32* %i8, align 4
  %cmp10 = icmp slt i32 %11, 128
  br i1 %cmp10, label %for.body12, label %for.end27

for.body12:                                       ; preds = %for.cond9
  %12 = load i64* %groupId, align 8
  %13 = load i64* %groupSize, align 8
  %mul13 = mul i64 %13, 128
  %mul14 = mul i64 %12, %mul13
  %14 = load i32* %i8, align 4
  %conv15 = sext i32 %14 to i64
  %15 = load i64* %groupSize, align 8
  %mul16 = mul i64 %conv15, %15
  %add17 = add i64 %mul14, %mul16
  %16 = load i64* %localId, align 8
  %add18 = add i64 %add17, %16
  %17 = load i32 addrspace(1)** %data.addr, align 8
  %arrayidx19 = getelementptr inbounds i32 addrspace(1)* %17, i64 %add18
  %18 = load i32 addrspace(1)* %arrayidx19, align 4
  store i32 %18, i32* %value, align 4
  %19 = load i32* %value, align 4
  %mul20 = mul i32 %19, 128
  %20 = load i32* %offSet2, align 4
  %add21 = add i32 %mul20, %20
  %21 = load i32* %offSet3, align 4
  %add22 = add i32 %add21, %21
  %idxprom = zext i32 %add22 to i64
  %22 = load i8 addrspace(3)** %sharedArray.addr, align 8
  %arrayidx23 = getelementptr inbounds i8 addrspace(3)* %22, i64 %idxprom
  %23 = load i8 addrspace(3)* %arrayidx23, align 1
  %inc24 = add i8 %23, 1
  store i8 %inc24, i8 addrspace(3)* %arrayidx23, align 1
  br label %for.inc25

for.inc25:                                        ; preds = %for.body12
  %24 = load i32* %i8, align 4
  %inc26 = add nsw i32 %24, 1
  store i32 %inc26, i32* %i8, align 4
  br label %for.cond9

for.end27:                                        ; preds = %for.cond9
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %i28, align 4
  br label %for.cond29

for.cond29:                                       ; preds = %for.inc62, %for.end27
  %25 = load i32* %i28, align 4
  %conv30 = sext i32 %25 to i64
  %26 = load i64* %groupSize, align 8
  %div = udiv i64 256, %26
  %cmp31 = icmp ult i64 %conv30, %div
  br i1 %cmp31, label %for.body33, label %for.end64

for.body33:                                       ; preds = %for.cond29
  %27 = load i32* %i28, align 4
  %mul34 = mul nsw i32 4096, %27
  %conv35 = sext i32 %mul34 to i64
  %28 = load i64* %localId, align 8
  %mul36 = mul i64 %28, 32
  %add37 = add i64 %conv35, %mul36
  %conv38 = trunc i64 %add37 to i32
  store i32 %conv38, i32* %passNumber, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %binCount, align 16
  store i32 0, i32* %result, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond39

for.cond39:                                       ; preds = %for.inc50, %for.body33
  %29 = load i32* %j, align 4
  %cmp40 = icmp slt i32 %29, 32
  br i1 %cmp40, label %for.body42, label %for.end52

for.body42:                                       ; preds = %for.cond39
  %30 = load i32* %j, align 4
  %31 = load i32* %offSet1, align 4
  %add43 = add nsw i32 %30, %31
  %and44 = and i32 %add43, 31
  store i32 %and44, i32* %bankNum, align 4
  %32 = load i32* %passNumber, align 4
  %33 = load i32* %bankNum, align 4
  %add45 = add nsw i32 %32, %33
  %idxprom46 = sext i32 %add45 to i64
  %34 = load <4 x i8> addrspace(3)** %input, align 8
  %arrayidx47 = getelementptr inbounds <4 x i8> addrspace(3)* %34, i64 %idxprom46
  %35 = load <4 x i8> addrspace(3)* %arrayidx47, align 4
  store <4 x i8> %35, <4 x i8>* %binVal, align 4
  %36 = load <4 x i8>* %binVal, align 4
  %call48 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %36) #1
  store <4 x i32> %call48, <4 x i32>* %binValAsUint, align 16
  %37 = load <4 x i32>* %binValAsUint, align 16
  %38 = load <4 x i32>* %binCount, align 16
  %add49 = add <4 x i32> %38, %37
  store <4 x i32> %add49, <4 x i32>* %binCount, align 16
  br label %for.inc50

for.inc50:                                        ; preds = %for.body42
  %39 = load i32* %j, align 4
  %inc51 = add nsw i32 %39, 1
  store i32 %inc51, i32* %j, align 4
  br label %for.cond39

for.end52:                                        ; preds = %for.cond39
  %40 = load <4 x i32>* %binCount, align 16
  %41 = extractelement <4 x i32> %40, i32 0
  %42 = load <4 x i32>* %binCount, align 16
  %43 = extractelement <4 x i32> %42, i32 1
  %add53 = add i32 %41, %43
  %44 = load <4 x i32>* %binCount, align 16
  %45 = extractelement <4 x i32> %44, i32 2
  %add54 = add i32 %add53, %45
  %46 = load <4 x i32>* %binCount, align 16
  %47 = extractelement <4 x i32> %46, i32 3
  %add55 = add i32 %add54, %47
  store i32 %add55, i32* %result, align 4
  %48 = load i32* %result, align 4
  %49 = load i64* %groupId, align 8
  %mul56 = mul i64 %49, 256
  %50 = load i64* %groupSize, align 8
  %51 = load i32* %i28, align 4
  %conv57 = sext i32 %51 to i64
  %mul58 = mul i64 %50, %conv57
  %add59 = add i64 %mul56, %mul58
  %52 = load i64* %localId, align 8
  %add60 = add i64 %add59, %52
  %53 = load i32 addrspace(1)** %binResult.addr, align 8
  %arrayidx61 = getelementptr inbounds i32 addrspace(1)* %53, i64 %add60
  store i32 %48, i32 addrspace(1)* %arrayidx61, align 4
  br label %for.inc62

for.inc62:                                        ; preds = %for.end52
  %54 = load i32* %i28, align 4
  %inc63 = add nsw i32 %54, 1
  store i32 %inc63, i32* %i28, align 4
  br label %for.cond29

for.end64:                                        ; preds = %for.cond29
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!9}
!opencl.spir.version = !{!9}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @__OpenCL_histogram256_vector_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 3, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint4*", metadata !"uchar*", metadata !"uint*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"const", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint4*", metadata !"uchar*", metadata !"uint*"}
!6 = metadata !{void (i32 addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @__OpenCL_histogram256_scalar_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uchar*", metadata !"uint*"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uchar*", metadata !"uint*"}
!9 = metadata !{i32 1, i32 2}

; ModuleID = 'BinarySearch_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_binarySearch_kernel(<4 x i32> addrspace(1)* %outputArray, i32 addrspace(1)* %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) #0 {
entry:
  %outputArray.addr = alloca <4 x i32> addrspace(1)*, align 8
  %sortedArray.addr = alloca i32 addrspace(1)*, align 8
  %subdivSize.addr = alloca i32, align 4
  %globalLowerIndex.addr = alloca i32, align 4
  %findMe.addr = alloca i32, align 4
  %tid = alloca i32, align 4
  %elementLower = alloca i32, align 4
  %elementUpper = alloca i32, align 4
  store <4 x i32> addrspace(1)* %outputArray, <4 x i32> addrspace(1)** %outputArray.addr, align 8
  store i32 addrspace(1)* %sortedArray, i32 addrspace(1)** %sortedArray.addr, align 8
  store i32 %subdivSize, i32* %subdivSize.addr, align 4
  store i32 %globalLowerIndex, i32* %globalLowerIndex.addr, align 4
  store i32 %findMe, i32* %findMe.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  %0 = load i32* %globalLowerIndex.addr, align 4
  %1 = load i32* %tid, align 4
  %2 = load i32* %subdivSize.addr, align 4
  %mul = mul i32 %1, %2
  %add = add i32 %0, %mul
  %idxprom = zext i32 %add to i64
  %3 = load i32 addrspace(1)** %sortedArray.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %3, i64 %idxprom
  %4 = load i32 addrspace(1)* %arrayidx, align 4
  store i32 %4, i32* %elementLower, align 4
  %5 = load i32* %globalLowerIndex.addr, align 4
  %6 = load i32* %tid, align 4
  %add1 = add i32 %6, 1
  %7 = load i32* %subdivSize.addr, align 4
  %mul2 = mul i32 %add1, %7
  %add3 = add i32 %5, %mul2
  %sub = sub i32 %add3, 1
  %idxprom4 = zext i32 %sub to i64
  %8 = load i32 addrspace(1)** %sortedArray.addr, align 8
  %arrayidx5 = getelementptr inbounds i32 addrspace(1)* %8, i64 %idxprom4
  %9 = load i32 addrspace(1)* %arrayidx5, align 4
  store i32 %9, i32* %elementUpper, align 4
  %10 = load i32* %elementLower, align 4
  %11 = load i32* %findMe.addr, align 4
  %cmp = icmp ugt i32 %10, %11
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %12 = load i32* %elementUpper, align 4
  %13 = load i32* %findMe.addr, align 4
  %cmp7 = icmp ult i32 %12, %13
  br i1 %cmp7, label %if.then, label %if.else

if.then:                                          ; preds = %lor.lhs.false, %entry
  br label %if.end

if.else:                                          ; preds = %lor.lhs.false
  %14 = load i32* %tid, align 4
  %15 = load <4 x i32> addrspace(1)** %outputArray.addr, align 8
  %arrayidx9 = getelementptr inbounds <4 x i32> addrspace(1)* %15, i64 0
  %16 = load <4 x i32> addrspace(1)* %arrayidx9, align 16
  %17 = insertelement <4 x i32> %16, i32 %14, i32 0
  store <4 x i32> %17, <4 x i32> addrspace(1)* %arrayidx9, align 16
  %18 = load <4 x i32> addrspace(1)** %outputArray.addr, align 8
  %arrayidx10 = getelementptr inbounds <4 x i32> addrspace(1)* %18, i64 0
  %19 = load <4 x i32> addrspace(1)* %arrayidx10, align 16
  %20 = insertelement <4 x i32> %19, i32 1, i32 3
  store <4 x i32> %20, <4 x i32> addrspace(1)* %arrayidx10, align 16
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_binarySearch_mulkeys_kernel(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %numKeys, i32 addrspace(1)* %output) #0 {
entry:
  %keys.addr = alloca i32 addrspace(1)*, align 8
  %input.addr = alloca i32 addrspace(1)*, align 8
  %numKeys.addr = alloca i32, align 4
  %output.addr = alloca i32 addrspace(1)*, align 8
  %gid = alloca i32, align 4
  %lBound = alloca i32, align 4
  %uBound = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 addrspace(1)* %keys, i32 addrspace(1)** %keys.addr, align 8
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 %numKeys, i32* %numKeys.addr, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gid, align 4
  %0 = load i32* %gid, align 4
  %mul = mul nsw i32 %0, 256
  store i32 %mul, i32* %lBound, align 4
  %1 = load i32* %lBound, align 4
  %add = add nsw i32 %1, 255
  store i32 %add, i32* %uBound, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32* %i, align 4
  %3 = load i32* %numKeys.addr, align 4
  %cmp = icmp ult i32 %2, %3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i32* %i, align 4
  %idxprom = sext i32 %4 to i64
  %5 = load i32 addrspace(1)** %keys.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %5, i64 %idxprom
  %6 = load i32 addrspace(1)* %arrayidx, align 4
  %7 = load i32* %lBound, align 4
  %idxprom2 = sext i32 %7 to i64
  %8 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx3 = getelementptr inbounds i32 addrspace(1)* %8, i64 %idxprom2
  %9 = load i32 addrspace(1)* %arrayidx3, align 4
  %cmp4 = icmp uge i32 %6, %9
  br i1 %cmp4, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %for.body
  %10 = load i32* %i, align 4
  %idxprom6 = sext i32 %10 to i64
  %11 = load i32 addrspace(1)** %keys.addr, align 8
  %arrayidx7 = getelementptr inbounds i32 addrspace(1)* %11, i64 %idxprom6
  %12 = load i32 addrspace(1)* %arrayidx7, align 4
  %13 = load i32* %uBound, align 4
  %idxprom8 = sext i32 %13 to i64
  %14 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx9 = getelementptr inbounds i32 addrspace(1)* %14, i64 %idxprom8
  %15 = load i32 addrspace(1)* %arrayidx9, align 4
  %cmp10 = icmp ule i32 %12, %15
  br i1 %cmp10, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %16 = load i32* %lBound, align 4
  %17 = load i32* %i, align 4
  %idxprom12 = sext i32 %17 to i64
  %18 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx13 = getelementptr inbounds i32 addrspace(1)* %18, i64 %idxprom12
  store i32 %16, i32 addrspace(1)* %arrayidx13, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true, %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %19 = load i32* %i, align 4
  %inc = add nsw i32 %19, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_binarySearch_mulkeysConcurrent_kernel(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %inputSize, i32 %numSubdivisions, i32 addrspace(1)* %output) #0 {
entry:
  %keys.addr = alloca i32 addrspace(1)*, align 8
  %input.addr = alloca i32 addrspace(1)*, align 8
  %inputSize.addr = alloca i32, align 4
  %numSubdivisions.addr = alloca i32, align 4
  %output.addr = alloca i32 addrspace(1)*, align 8
  %lBound = alloca i32, align 4
  %uBound = alloca i32, align 4
  %myKey = alloca i32, align 4
  %mid = alloca i32, align 4
  store i32 addrspace(1)* %keys, i32 addrspace(1)** %keys.addr, align 8
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 %inputSize, i32* %inputSize.addr, align 4
  store i32 %numSubdivisions, i32* %numSubdivisions.addr, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %0 = load i32* %numSubdivisions.addr, align 4
  %conv = zext i32 %0 to i64
  %rem = urem i64 %call, %conv
  %1 = load i32* %inputSize.addr, align 4
  %2 = load i32* %numSubdivisions.addr, align 4
  %div = udiv i32 %1, %2
  %conv1 = zext i32 %div to i64
  %mul = mul i64 %rem, %conv1
  %conv2 = trunc i64 %mul to i32
  store i32 %conv2, i32* %lBound, align 4
  %3 = load i32* %lBound, align 4
  %4 = load i32* %inputSize.addr, align 4
  %5 = load i32* %numSubdivisions.addr, align 4
  %div3 = udiv i32 %4, %5
  %add = add i32 %3, %div3
  store i32 %add, i32* %uBound, align 4
  %call4 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %6 = load i32* %numSubdivisions.addr, align 4
  %conv5 = zext i32 %6 to i64
  %div6 = udiv i64 %call4, %conv5
  %7 = load i32 addrspace(1)** %keys.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %7, i64 %div6
  %8 = load i32 addrspace(1)* %arrayidx, align 4
  store i32 %8, i32* %myKey, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end24, %entry
  %9 = load i32* %uBound, align 4
  %10 = load i32* %lBound, align 4
  %cmp = icmp sge i32 %9, %10
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %11 = load i32* %lBound, align 4
  %12 = load i32* %uBound, align 4
  %add8 = add nsw i32 %11, %12
  %div9 = sdiv i32 %add8, 2
  store i32 %div9, i32* %mid, align 4
  %13 = load i32* %mid, align 4
  %idxprom = sext i32 %13 to i64
  %14 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx10 = getelementptr inbounds i32 addrspace(1)* %14, i64 %idxprom
  %15 = load i32 addrspace(1)* %arrayidx10, align 4
  %16 = load i32* %myKey, align 4
  %cmp11 = icmp eq i32 %15, %16
  br i1 %cmp11, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  %17 = load i32* %mid, align 4
  %call13 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %18 = load i32* %numSubdivisions.addr, align 4
  %conv14 = zext i32 %18 to i64
  %div15 = udiv i64 %call13, %conv14
  %19 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx16 = getelementptr inbounds i32 addrspace(1)* %19, i64 %div15
  store i32 %17, i32 addrspace(1)* %arrayidx16, align 4
  br label %while.end

if.else:                                          ; preds = %while.body
  %20 = load i32* %mid, align 4
  %idxprom17 = sext i32 %20 to i64
  %21 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx18 = getelementptr inbounds i32 addrspace(1)* %21, i64 %idxprom17
  %22 = load i32 addrspace(1)* %arrayidx18, align 4
  %23 = load i32* %myKey, align 4
  %cmp19 = icmp ugt i32 %22, %23
  br i1 %cmp19, label %if.then21, label %if.else22

if.then21:                                        ; preds = %if.else
  %24 = load i32* %mid, align 4
  %sub = sub nsw i32 %24, 1
  store i32 %sub, i32* %uBound, align 4
  br label %if.end

if.else22:                                        ; preds = %if.else
  %25 = load i32* %mid, align 4
  %add23 = add nsw i32 %25, 1
  store i32 %add23, i32* %lBound, align 4
  br label %if.end

if.end:                                           ; preds = %if.else22, %if.then21
  br label %if.end24

if.end24:                                         ; preds = %if.end
  br label %while.cond

while.end:                                        ; preds = %if.then, %while.cond
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !12}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!17}
!opencl.spir.version = !{!17}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @__OpenCL_binarySearch_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint4*", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"const", metadata !"const", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint4*", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(1)*)* @__OpenCL_binarySearch_mulkeys_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 1}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"int*", metadata !"uint*", metadata !"uint", metadata !"int*"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"const", metadata !""}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"int*", metadata !"uint*", metadata !"uint", metadata !"int*"}
!12 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32, i32 addrspace(1)*)* @__OpenCL_binarySearch_mulkeysConcurrent_kernel, metadata !13, metadata !2, metadata !14, metadata !15, metadata !16}
!13 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 1}
!14 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"int*"}
!15 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"const", metadata !"const", metadata !""}
!16 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"int*"}
!17 = metadata !{i32 1, i32 2}

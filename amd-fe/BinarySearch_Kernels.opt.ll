; ModuleID = 'BinarySearch_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_binarySearch_kernel(<4 x i32> addrspace(1)* %outputArray, i32 addrspace(1)* %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %mul = mul i32 %conv, %subdivSize
  %add = add i32 %globalLowerIndex, %mul
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %sortedArray, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %add1 = add i32 %conv, 1
  %mul2 = mul i32 %add1, %subdivSize
  %add3 = add i32 %globalLowerIndex, %mul2
  %sub = sub i32 %add3, 1
  %idxprom4 = zext i32 %sub to i64
  %arrayidx5 = getelementptr inbounds i32 addrspace(1)* %sortedArray, i64 %idxprom4
  %1 = load i32 addrspace(1)* %arrayidx5, align 4
  %cmp = icmp ugt i32 %0, %findMe
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %cmp7 = icmp ult i32 %1, %findMe
  br i1 %cmp7, label %if.then, label %if.else

if.then:                                          ; preds = %lor.lhs.false, %entry
  br label %if.end

if.else:                                          ; preds = %lor.lhs.false
  %arrayidx9 = getelementptr inbounds <4 x i32> addrspace(1)* %outputArray, i64 0
  %2 = load <4 x i32> addrspace(1)* %arrayidx9, align 16
  %3 = insertelement <4 x i32> %2, i32 %conv, i32 0
  store <4 x i32> %3, <4 x i32> addrspace(1)* %arrayidx9, align 16
  %arrayidx10 = getelementptr inbounds <4 x i32> addrspace(1)* %outputArray, i64 0
  %4 = load <4 x i32> addrspace(1)* %arrayidx10, align 16
  %5 = insertelement <4 x i32> %4, i32 1, i32 3
  store <4 x i32> %5, <4 x i32> addrspace(1)* %arrayidx10, align 16
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_binarySearch_mulkeys_kernel(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %numKeys, i32 addrspace(1)* %output) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %mul = mul nsw i32 %conv, 256
  %add = add nsw i32 %mul, 255
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp ult i32 %i.0, %numKeys
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %keys, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %idxprom2 = sext i32 %mul to i64
  %arrayidx3 = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom2
  %1 = load i32 addrspace(1)* %arrayidx3, align 4
  %cmp4 = icmp uge i32 %0, %1
  br i1 %cmp4, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %for.body
  %idxprom6 = sext i32 %i.0 to i64
  %arrayidx7 = getelementptr inbounds i32 addrspace(1)* %keys, i64 %idxprom6
  %2 = load i32 addrspace(1)* %arrayidx7, align 4
  %idxprom8 = sext i32 %add to i64
  %arrayidx9 = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom8
  %3 = load i32 addrspace(1)* %arrayidx9, align 4
  %cmp10 = icmp ule i32 %2, %3
  br i1 %cmp10, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %idxprom12 = sext i32 %i.0 to i64
  %arrayidx13 = getelementptr inbounds i32 addrspace(1)* %output, i64 %idxprom12
  store i32 %mul, i32 addrspace(1)* %arrayidx13, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true, %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_binarySearch_mulkeysConcurrent_kernel(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %inputSize, i32 %numSubdivisions, i32 addrspace(1)* %output) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = zext i32 %numSubdivisions to i64
  %rem = urem i64 %call, %conv
  %div = udiv i32 %inputSize, %numSubdivisions
  %conv1 = zext i32 %div to i64
  %mul = mul i64 %rem, %conv1
  %conv2 = trunc i64 %mul to i32
  %div3 = udiv i32 %inputSize, %numSubdivisions
  %add = add i32 %conv2, %div3
  %call4 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv5 = zext i32 %numSubdivisions to i64
  %div6 = udiv i64 %call4, %conv5
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %keys, i64 %div6
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end24, %entry
  %lBound.0 = phi i32 [ %conv2, %entry ], [ %lBound.1, %if.end24 ]
  %uBound.0 = phi i32 [ %add, %entry ], [ %uBound.1, %if.end24 ]
  %cmp = icmp sge i32 %uBound.0, %lBound.0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %add8 = add nsw i32 %lBound.0, %uBound.0
  %div9 = sdiv i32 %add8, 2
  %idxprom = sext i32 %div9 to i64
  %arrayidx10 = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom
  %1 = load i32 addrspace(1)* %arrayidx10, align 4
  %cmp11 = icmp eq i32 %1, %0
  br i1 %cmp11, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  %call13 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv14 = zext i32 %numSubdivisions to i64
  %div15 = udiv i64 %call13, %conv14
  %arrayidx16 = getelementptr inbounds i32 addrspace(1)* %output, i64 %div15
  store i32 %div9, i32 addrspace(1)* %arrayidx16, align 4
  br label %while.end

if.else:                                          ; preds = %while.body
  %idxprom17 = sext i32 %div9 to i64
  %arrayidx18 = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom17
  %2 = load i32 addrspace(1)* %arrayidx18, align 4
  %cmp19 = icmp ugt i32 %2, %0
  br i1 %cmp19, label %if.then21, label %if.else22

if.then21:                                        ; preds = %if.else
  %sub = sub nsw i32 %div9, 1
  br label %if.end

if.else22:                                        ; preds = %if.else
  %add23 = add nsw i32 %div9, 1
  br label %if.end

if.end:                                           ; preds = %if.else22, %if.then21
  %lBound.1 = phi i32 [ %lBound.0, %if.then21 ], [ %add23, %if.else22 ]
  %uBound.1 = phi i32 [ %sub, %if.then21 ], [ %uBound.0, %if.else22 ]
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

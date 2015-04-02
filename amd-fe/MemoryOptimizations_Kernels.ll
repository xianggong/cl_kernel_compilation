; ModuleID = 'MemoryOptimizations_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_copy1DFastPath_kernel(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
entry:
  %input.addr = alloca float addrspace(1)*, align 8
  %output.addr = alloca float addrspace(1)*, align 8
  %gid = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %input.addr, align 8
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gid, align 4
  %0 = load i32* %gid, align 4
  %idxprom = sext i32 %0 to i64
  %1 = load float addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %1, i64 %idxprom
  %2 = load float addrspace(1)* %arrayidx, align 4
  %3 = load i32* %gid, align 4
  %idxprom1 = sext i32 %3 to i64
  %4 = load float addrspace(1)** %output.addr, align 8
  %arrayidx2 = getelementptr inbounds float addrspace(1)* %4, i64 %idxprom1
  store float %2, float addrspace(1)* %arrayidx2, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_copy1DCompletePath_kernel(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
entry:
  %input.addr = alloca float addrspace(1)*, align 8
  %output.addr = alloca float addrspace(1)*, align 8
  %gid = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %input.addr, align 8
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gid, align 4
  %0 = load i32* %gid, align 4
  %cmp = icmp slt i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load float addrspace(1)** %output.addr, align 8
  %2 = bitcast float addrspace(1)* %1 to i32 addrspace(1)*
  %call2 = call cc75 i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)* %2, i32 1)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %3 = load i32* %gid, align 4
  %idxprom = sext i32 %3 to i64
  %4 = load float addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %4, i64 %idxprom
  %5 = load float addrspace(1)* %arrayidx, align 4
  %6 = load i32* %gid, align 4
  %idxprom3 = sext i32 %6 to i64
  %7 = load float addrspace(1)** %output.addr, align 8
  %arrayidx4 = getelementptr inbounds float addrspace(1)* %7, i64 %idxprom3
  store float %5, float addrspace(1)* %arrayidx4, align 4
  ret void
}

declare cc75 i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)*, i32)

; Function Attrs: nounwind
define cc76 void @__OpenCL_copy2Dfloat_kernel(float addrspace(1)* %A, float addrspace(1)* %C) #0 {
entry:
  %A.addr = alloca float addrspace(1)*, align 8
  %C.addr = alloca float addrspace(1)*, align 8
  %idx = alloca i32, align 4
  %idy = alloca i32, align 4
  store float addrspace(1)* %A, float addrspace(1)** %A.addr, align 8
  store float addrspace(1)* %C, float addrspace(1)** %C.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %idx, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %idy, align 4
  %0 = load i32* %idy, align 4
  %mul = mul nsw i32 %0, 1024
  %1 = load i32* %idx, align 4
  %add = add nsw i32 %mul, %1
  %idxprom = sext i32 %add to i64
  %2 = load float addrspace(1)** %A.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %2, i64 %idxprom
  %3 = load float addrspace(1)* %arrayidx, align 4
  %4 = load i32* %idy, align 4
  %mul3 = mul nsw i32 %4, 1024
  %5 = load i32* %idx, align 4
  %add4 = add nsw i32 %mul3, %5
  %idxprom5 = sext i32 %add4 to i64
  %6 = load float addrspace(1)** %C.addr, align 8
  %arrayidx6 = getelementptr inbounds float addrspace(1)* %6, i64 %idxprom5
  store float %3, float addrspace(1)* %arrayidx6, align 4
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_copy2Dfloat4_kernel(<4 x float> addrspace(1)* %A, <4 x float> addrspace(1)* %C) #0 {
entry:
  %A.addr = alloca <4 x float> addrspace(1)*, align 8
  %C.addr = alloca <4 x float> addrspace(1)*, align 8
  %idx = alloca i32, align 4
  %idy = alloca i32, align 4
  store <4 x float> addrspace(1)* %A, <4 x float> addrspace(1)** %A.addr, align 8
  store <4 x float> addrspace(1)* %C, <4 x float> addrspace(1)** %C.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %idx, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %idy, align 4
  %0 = load i32* %idy, align 4
  %mul = mul nsw i32 %0, 1024
  %1 = load i32* %idx, align 4
  %add = add nsw i32 %mul, %1
  %idxprom = sext i32 %add to i64
  %2 = load <4 x float> addrspace(1)** %A.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %2, i64 %idxprom
  %3 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %4 = load i32* %idy, align 4
  %mul3 = mul nsw i32 %4, 1024
  %5 = load i32* %idx, align 4
  %add4 = add nsw i32 %mul3, %5
  %idxprom5 = sext i32 %add4 to i64
  %6 = load <4 x float> addrspace(1)** %C.addr, align 8
  %arrayidx6 = getelementptr inbounds <4 x float> addrspace(1)* %6, i64 %idxprom5
  store <4 x float> %3, <4 x float> addrspace(1)* %arrayidx6, align 16
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_copy1Dfloat4_kernel(<4 x float> addrspace(1)* %input, <4 x float> addrspace(1)* %output) #0 {
entry:
  %input.addr = alloca <4 x float> addrspace(1)*, align 8
  %output.addr = alloca <4 x float> addrspace(1)*, align 8
  %gid = alloca i32, align 4
  store <4 x float> addrspace(1)* %input, <4 x float> addrspace(1)** %input.addr, align 8
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gid, align 4
  %0 = load i32* %gid, align 4
  %idxprom = sext i32 %0 to i64
  %1 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %1, i64 %idxprom
  %2 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %3 = load i32* %gid, align 4
  %idxprom1 = sext i32 %3 to i64
  %4 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx2 = getelementptr inbounds <4 x float> addrspace(1)* %4, i64 %idxprom1
  store <4 x float> %2, <4 x float> addrspace(1)* %arrayidx2, align 16
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_NoCoal_kernel(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
entry:
  %input.addr = alloca float addrspace(1)*, align 8
  %output.addr = alloca float addrspace(1)*, align 8
  %gid = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %input.addr, align 8
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %sub = sub i64 %call, 1
  %conv = trunc i64 %sub to i32
  store i32 %conv, i32* %gid, align 4
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %and = and i64 %call1, 15
  %cmp = icmp eq i64 %and, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load i32* %gid, align 4
  %add = add nsw i32 %0, 16
  store i32 %add, i32* %gid, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %1 = load i32* %gid, align 4
  %idxprom = sext i32 %1 to i64
  %2 = load float addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %2, i64 %idxprom
  %3 = load float addrspace(1)* %arrayidx, align 4
  %4 = load i32* %gid, align 4
  %idxprom3 = sext i32 %4 to i64
  %5 = load float addrspace(1)** %output.addr, align 8
  %arrayidx4 = getelementptr inbounds float addrspace(1)* %5, i64 %idxprom3
  store float %3, float addrspace(1)* %arrayidx4, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_Split_kernel(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
entry:
  %input.addr = alloca float addrspace(1)*, align 8
  %output.addr = alloca float addrspace(1)*, align 8
  %gid = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %input.addr, align 8
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gid, align 4
  %0 = load i32* %gid, align 4
  %and = and i32 %0, 1
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load i32* %gid, align 4
  %and2 = and i32 %1, 0
  %add = add nsw i32 %and2, 62
  %conv3 = sext i32 %add to i64
  %call4 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %sub = sub i64 %conv3, %call4
  %conv5 = trunc i64 %sub to i32
  store i32 %conv5, i32* %gid, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %2 = load i32* %gid, align 4
  %idxprom = sext i32 %2 to i64
  %3 = load float addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %3, i64 %idxprom
  %4 = load float addrspace(1)* %arrayidx, align 4
  %5 = load i32* %gid, align 4
  %idxprom6 = sext i32 %5 to i64
  %6 = load float addrspace(1)** %output.addr, align 8
  %arrayidx7 = getelementptr inbounds float addrspace(1)* %6, i64 %idxprom6
  store float %4, float addrspace(1)* %arrayidx7, align 4
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_localBankConflicts_kernel(float addrspace(3)* %share, float addrspace(1)* %output) #0 {
entry:
  %share.addr = alloca float addrspace(3)*, align 8
  %output.addr = alloca float addrspace(1)*, align 8
  %gid = alloca i32, align 4
  %lid = alloca i32, align 4
  %resulta = alloca i32, align 4
  %resultb = alloca i32, align 4
  %i = alloca i32, align 4
  store float addrspace(3)* %share, float addrspace(3)** %share.addr, align 8
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gid, align 4
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %lid, align 4
  store i32 0, i32* %resulta, align 4
  store i32 0, i32* %resultb, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %i, align 4
  %cmp = icmp slt i32 %0, 128
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32* %lid, align 4
  %mul = mul nsw i32 %1, 32
  %2 = load i32* %i, align 4
  %add = add nsw i32 %mul, %2
  %idxprom = sext i32 %add to i64
  %3 = load float addrspace(3)** %share.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(3)* %3, i64 %idxprom
  %4 = load float addrspace(3)* %arrayidx, align 4
  %5 = load i32* %resulta, align 4
  %conv4 = sitofp i32 %5 to float
  %add5 = fadd float %conv4, %4
  %conv6 = fptosi float %add5 to i32
  store i32 %conv6, i32* %resulta, align 4
  %6 = load i32* %lid, align 4
  %mul7 = mul nsw i32 %6, 32
  %7 = load i32* %i, align 4
  %add8 = add nsw i32 %mul7, %7
  %add9 = add nsw i32 %add8, 1
  %idxprom10 = sext i32 %add9 to i64
  %8 = load float addrspace(3)** %share.addr, align 8
  %arrayidx11 = getelementptr inbounds float addrspace(3)* %8, i64 %idxprom10
  %9 = load float addrspace(3)* %arrayidx11, align 4
  %10 = load i32* %resultb, align 4
  %conv12 = sitofp i32 %10 to float
  %add13 = fadd float %conv12, %9
  %conv14 = fptosi float %add13 to i32
  store i32 %conv14, i32* %resultb, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %11 = load i32* %i, align 4
  %add15 = add nsw i32 %11, 2
  store i32 %add15, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %12 = load i32* %resulta, align 4
  %13 = load i32* %resultb, align 4
  %add16 = add nsw i32 %12, %13
  %conv17 = sitofp i32 %add16 to float
  %14 = load i32* %gid, align 4
  %idxprom18 = sext i32 %14 to i64
  %15 = load float addrspace(1)** %output.addr, align 8
  %arrayidx19 = getelementptr inbounds float addrspace(1)* %15, i64 %idxprom18
  store float %conv17, float addrspace(1)* %arrayidx19, align 4
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_noLocalBankConflicts_kernel(float addrspace(3)* %share, float addrspace(1)* %output) #0 {
entry:
  %share.addr = alloca float addrspace(3)*, align 8
  %output.addr = alloca float addrspace(1)*, align 8
  %gid = alloca i32, align 4
  %lid = alloca i32, align 4
  %resulta = alloca i32, align 4
  %resultb = alloca i32, align 4
  %i = alloca i32, align 4
  store float addrspace(3)* %share, float addrspace(3)** %share.addr, align 8
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gid, align 4
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %lid, align 4
  store i32 0, i32* %resulta, align 4
  store i32 0, i32* %resultb, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %i, align 4
  %cmp = icmp slt i32 %0, 128
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32* %i, align 4
  %2 = load i32* %lid, align 4
  %add = add nsw i32 %1, %2
  %idxprom = sext i32 %add to i64
  %3 = load float addrspace(3)** %share.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(3)* %3, i64 %idxprom
  %4 = load float addrspace(3)* %arrayidx, align 4
  %5 = load i32* %resulta, align 4
  %conv4 = sitofp i32 %5 to float
  %add5 = fadd float %conv4, %4
  %conv6 = fptosi float %add5 to i32
  store i32 %conv6, i32* %resulta, align 4
  %6 = load i32* %i, align 4
  %add7 = add nsw i32 %6, 1
  %7 = load i32* %lid, align 4
  %add8 = add nsw i32 %add7, %7
  %idxprom9 = sext i32 %add8 to i64
  %8 = load float addrspace(3)** %share.addr, align 8
  %arrayidx10 = getelementptr inbounds float addrspace(3)* %8, i64 %idxprom9
  %9 = load float addrspace(3)* %arrayidx10, align 4
  %10 = load i32* %resultb, align 4
  %conv11 = sitofp i32 %10 to float
  %add12 = fadd float %conv11, %9
  %conv13 = fptosi float %add12 to i32
  store i32 %conv13, i32* %resultb, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %11 = load i32* %i, align 4
  %add14 = add nsw i32 %11, 2
  store i32 %add14, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %12 = load i32* %resulta, align 4
  %13 = load i32* %resultb, align 4
  %add15 = add nsw i32 %12, %13
  %conv16 = sitofp i32 %add15 to float
  %14 = load i32* %gid, align 4
  %idxprom17 = sext i32 %14 to i64
  %15 = load float addrspace(1)** %output.addr, align 8
  %arrayidx18 = getelementptr inbounds float addrspace(1)* %15, i64 %idxprom17
  store float %conv16, float addrspace(1)* %arrayidx18, align 4
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !7, !8, !11, !12, !13, !14, !16}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!17}
!opencl.spir.version = !{!17}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @__OpenCL_copy1DFastPath_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*"}
!6 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @__OpenCL_copy1DCompletePath_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!7 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @__OpenCL_copy2Dfloat_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!8 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @__OpenCL_copy2Dfloat4_kernel, metadata !1, metadata !2, metadata !9, metadata !4, metadata !10}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"float4*"}
!10 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"float4*"}
!11 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @__OpenCL_copy1Dfloat4_kernel, metadata !1, metadata !2, metadata !9, metadata !4, metadata !10}
!12 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @__OpenCL_NoCoal_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!13 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @__OpenCL_Split_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!14 = metadata !{void (float addrspace(3)*, float addrspace(1)*)* @__OpenCL_localBankConflicts_kernel, metadata !15, metadata !2, metadata !3, metadata !4, metadata !5}
!15 = metadata !{metadata !"kernel_arg_addr_space", i32 3, i32 1}
!16 = metadata !{void (float addrspace(3)*, float addrspace(1)*)* @__OpenCL_noLocalBankConflicts_kernel, metadata !15, metadata !2, metadata !3, metadata !4, metadata !5}
!17 = metadata !{i32 1, i32 2}

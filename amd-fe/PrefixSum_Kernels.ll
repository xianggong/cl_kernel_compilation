; ModuleID = 'PrefixSum_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_group_prefixSum_kernel(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %length, i32 %idxOffset) #0 {
entry:
  %output.addr = alloca float addrspace(1)*, align 8
  %input.addr = alloca float addrspace(1)*, align 8
  %block.addr = alloca float addrspace(3)*, align 8
  %length.addr = alloca i32, align 4
  %idxOffset.addr = alloca i32, align 4
  %localId = alloca i32, align 4
  %localSize = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %offset = alloca i32, align 4
  %l = alloca i32, align 4
  %ai = alloca i32, align 4
  %bi = alloca i32, align 4
  %maxThread = alloca i32, align 4
  %d = alloca i32, align 4
  %ai59 = alloca i32, align 4
  %bi63 = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  store float addrspace(1)* %input, float addrspace(1)** %input.addr, align 8
  store float addrspace(3)* %block, float addrspace(3)** %block.addr, align 8
  store i32 %length, i32* %length.addr, align 4
  store i32 %idxOffset, i32* %idxOffset.addr, align 4
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %localId, align 4
  %call1 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %localSize, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %globalIdx, align 4
  %0 = load i32* %idxOffset.addr, align 4
  %1 = load i32* %globalIdx, align 4
  %2 = load i32* %localSize, align 4
  %mul = mul nsw i32 %1, %2
  %3 = load i32* %localId, align 4
  %add = add nsw i32 %mul, %3
  %mul5 = mul nsw i32 2, %add
  %add6 = add nsw i32 %mul5, 1
  %mul7 = mul i32 %0, %add6
  %sub = sub i32 %mul7, 1
  store i32 %sub, i32* %globalIdx, align 4
  %4 = load i32* %globalIdx, align 4
  %5 = load i32* %length.addr, align 4
  %cmp = icmp ult i32 %4, %5
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %6 = load i32* %globalIdx, align 4
  %idxprom = sext i32 %6 to i64
  %7 = load float addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %7, i64 %idxprom
  %8 = load float addrspace(1)* %arrayidx, align 4
  %9 = load i32* %localId, align 4
  %mul9 = mul nsw i32 2, %9
  %idxprom10 = sext i32 %mul9 to i64
  %10 = load float addrspace(3)** %block.addr, align 8
  %arrayidx11 = getelementptr inbounds float addrspace(3)* %10, i64 %idxprom10
  store float %8, float addrspace(3)* %arrayidx11, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %11 = load i32* %globalIdx, align 4
  %12 = load i32* %idxOffset.addr, align 4
  %add12 = add i32 %11, %12
  %13 = load i32* %length.addr, align 4
  %cmp13 = icmp ult i32 %add12, %13
  br i1 %cmp13, label %if.then15, label %if.end23

if.then15:                                        ; preds = %if.end
  %14 = load i32* %globalIdx, align 4
  %15 = load i32* %idxOffset.addr, align 4
  %add16 = add i32 %14, %15
  %idxprom17 = zext i32 %add16 to i64
  %16 = load float addrspace(1)** %input.addr, align 8
  %arrayidx18 = getelementptr inbounds float addrspace(1)* %16, i64 %idxprom17
  %17 = load float addrspace(1)* %arrayidx18, align 4
  %18 = load i32* %localId, align 4
  %mul19 = mul nsw i32 2, %18
  %add20 = add nsw i32 %mul19, 1
  %idxprom21 = sext i32 %add20 to i64
  %19 = load float addrspace(3)** %block.addr, align 8
  %arrayidx22 = getelementptr inbounds float addrspace(3)* %19, i64 %idxprom21
  store float %17, float addrspace(3)* %arrayidx22, align 4
  br label %if.end23

if.end23:                                         ; preds = %if.then15, %if.end
  store i32 1, i32* %offset, align 4
  %20 = load i32* %length.addr, align 4
  %shr = lshr i32 %20, 1
  store i32 %shr, i32* %l, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end23
  %21 = load i32* %l, align 4
  %cmp24 = icmp sgt i32 %21, 0
  br i1 %cmp24, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  %22 = load i32* %localId, align 4
  %23 = load i32* %l, align 4
  %cmp26 = icmp slt i32 %22, %23
  br i1 %cmp26, label %if.then28, label %if.end42

if.then28:                                        ; preds = %for.body
  %24 = load i32* %offset, align 4
  %25 = load i32* %localId, align 4
  %mul29 = mul nsw i32 2, %25
  %add30 = add nsw i32 %mul29, 1
  %mul31 = mul nsw i32 %24, %add30
  %sub32 = sub nsw i32 %mul31, 1
  store i32 %sub32, i32* %ai, align 4
  %26 = load i32* %offset, align 4
  %27 = load i32* %localId, align 4
  %mul33 = mul nsw i32 2, %27
  %add34 = add nsw i32 %mul33, 2
  %mul35 = mul nsw i32 %26, %add34
  %sub36 = sub nsw i32 %mul35, 1
  store i32 %sub36, i32* %bi, align 4
  %28 = load i32* %ai, align 4
  %idxprom37 = sext i32 %28 to i64
  %29 = load float addrspace(3)** %block.addr, align 8
  %arrayidx38 = getelementptr inbounds float addrspace(3)* %29, i64 %idxprom37
  %30 = load float addrspace(3)* %arrayidx38, align 4
  %31 = load i32* %bi, align 4
  %idxprom39 = sext i32 %31 to i64
  %32 = load float addrspace(3)** %block.addr, align 8
  %arrayidx40 = getelementptr inbounds float addrspace(3)* %32, i64 %idxprom39
  %33 = load float addrspace(3)* %arrayidx40, align 4
  %add41 = fadd float %33, %30
  store float %add41, float addrspace(3)* %arrayidx40, align 4
  br label %if.end42

if.end42:                                         ; preds = %if.then28, %for.body
  %34 = load i32* %offset, align 4
  %shl = shl i32 %34, 1
  store i32 %shl, i32* %offset, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.end42
  %35 = load i32* %l, align 4
  %shr43 = ashr i32 %35, 1
  store i32 %shr43, i32* %l, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %36 = load i32* %offset, align 4
  %37 = load i32* %length.addr, align 4
  %cmp44 = icmp ult i32 %36, %37
  br i1 %cmp44, label %if.then46, label %if.end48

if.then46:                                        ; preds = %for.end
  %38 = load i32* %offset, align 4
  %shl47 = shl i32 %38, 1
  store i32 %shl47, i32* %offset, align 4
  br label %if.end48

if.end48:                                         ; preds = %if.then46, %for.end
  %39 = load i32* %offset, align 4
  %shr49 = ashr i32 %39, 1
  store i32 %shr49, i32* %maxThread, align 4
  store i32 0, i32* %d, align 4
  br label %for.cond50

for.cond50:                                       ; preds = %for.inc72, %if.end48
  %40 = load i32* %d, align 4
  %41 = load i32* %maxThread, align 4
  %cmp51 = icmp slt i32 %40, %41
  br i1 %cmp51, label %for.body53, label %for.end74

for.body53:                                       ; preds = %for.cond50
  %42 = load i32* %d, align 4
  %add54 = add nsw i32 %42, 1
  store i32 %add54, i32* %d, align 4
  %43 = load i32* %offset, align 4
  %shr55 = ashr i32 %43, 1
  store i32 %shr55, i32* %offset, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %44 = load i32* %localId, align 4
  %45 = load i32* %d, align 4
  %cmp56 = icmp slt i32 %44, %45
  br i1 %cmp56, label %if.then58, label %if.end71

if.then58:                                        ; preds = %for.body53
  %46 = load i32* %offset, align 4
  %47 = load i32* %localId, align 4
  %add60 = add nsw i32 %47, 1
  %mul61 = mul nsw i32 %46, %add60
  %sub62 = sub nsw i32 %mul61, 1
  store i32 %sub62, i32* %ai59, align 4
  %48 = load i32* %ai59, align 4
  %49 = load i32* %offset, align 4
  %shr64 = ashr i32 %49, 1
  %add65 = add nsw i32 %48, %shr64
  store i32 %add65, i32* %bi63, align 4
  %50 = load i32* %ai59, align 4
  %idxprom66 = sext i32 %50 to i64
  %51 = load float addrspace(3)** %block.addr, align 8
  %arrayidx67 = getelementptr inbounds float addrspace(3)* %51, i64 %idxprom66
  %52 = load float addrspace(3)* %arrayidx67, align 4
  %53 = load i32* %bi63, align 4
  %idxprom68 = sext i32 %53 to i64
  %54 = load float addrspace(3)** %block.addr, align 8
  %arrayidx69 = getelementptr inbounds float addrspace(3)* %54, i64 %idxprom68
  %55 = load float addrspace(3)* %arrayidx69, align 4
  %add70 = fadd float %55, %52
  store float %add70, float addrspace(3)* %arrayidx69, align 4
  br label %if.end71

if.end71:                                         ; preds = %if.then58, %for.body53
  br label %for.inc72

for.inc72:                                        ; preds = %if.end71
  %56 = load i32* %d, align 4
  %shl73 = shl i32 %56, 1
  store i32 %shl73, i32* %d, align 4
  br label %for.cond50

for.end74:                                        ; preds = %for.cond50
  call cc75 void @_Z7barrierj(i32 1)
  %57 = load i32* %globalIdx, align 4
  %58 = load i32* %length.addr, align 4
  %cmp75 = icmp ult i32 %57, %58
  br i1 %cmp75, label %if.then77, label %if.end83

if.then77:                                        ; preds = %for.end74
  %59 = load i32* %localId, align 4
  %mul78 = mul nsw i32 2, %59
  %idxprom79 = sext i32 %mul78 to i64
  %60 = load float addrspace(3)** %block.addr, align 8
  %arrayidx80 = getelementptr inbounds float addrspace(3)* %60, i64 %idxprom79
  %61 = load float addrspace(3)* %arrayidx80, align 4
  %62 = load i32* %globalIdx, align 4
  %idxprom81 = sext i32 %62 to i64
  %63 = load float addrspace(1)** %output.addr, align 8
  %arrayidx82 = getelementptr inbounds float addrspace(1)* %63, i64 %idxprom81
  store float %61, float addrspace(1)* %arrayidx82, align 4
  br label %if.end83

if.end83:                                         ; preds = %if.then77, %for.end74
  %64 = load i32* %globalIdx, align 4
  %65 = load i32* %idxOffset.addr, align 4
  %add84 = add i32 %64, %65
  %66 = load i32* %length.addr, align 4
  %cmp85 = icmp ult i32 %add84, %66
  br i1 %cmp85, label %if.then87, label %if.end95

if.then87:                                        ; preds = %if.end83
  %67 = load i32* %localId, align 4
  %mul88 = mul nsw i32 2, %67
  %add89 = add nsw i32 %mul88, 1
  %idxprom90 = sext i32 %add89 to i64
  %68 = load float addrspace(3)** %block.addr, align 8
  %arrayidx91 = getelementptr inbounds float addrspace(3)* %68, i64 %idxprom90
  %69 = load float addrspace(3)* %arrayidx91, align 4
  %70 = load i32* %globalIdx, align 4
  %71 = load i32* %idxOffset.addr, align 4
  %add92 = add i32 %70, %71
  %idxprom93 = zext i32 %add92 to i64
  %72 = load float addrspace(1)** %output.addr, align 8
  %arrayidx94 = getelementptr inbounds float addrspace(1)* %72, i64 %idxprom93
  store float %69, float addrspace(1)* %arrayidx94, align 4
  br label %if.end95

if.end95:                                         ; preds = %if.then87, %if.end83
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

; Function Attrs: nounwind
define cc76 void @__OpenCL_global_prefixSum_kernel(float addrspace(1)* %buffer, i32 %offset, i32 %length) #0 {
entry:
  %buffer.addr = alloca float addrspace(1)*, align 8
  %offset.addr = alloca i32, align 4
  %length.addr = alloca i32, align 4
  %localSize = alloca i32, align 4
  %groupIdx = alloca i32, align 4
  %sortedLocalBlocks = alloca i32, align 4
  %gidToUnsortedBlocks = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  store float addrspace(1)* %buffer, float addrspace(1)** %buffer.addr, align 8
  store i32 %offset, i32* %offset.addr, align 4
  store i32 %length, i32* %length.addr, align 4
  %call = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %localSize, align 4
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %groupIdx, align 4
  %0 = load i32* %offset.addr, align 4
  %1 = load i32* %localSize, align 4
  %div = udiv i32 %0, %1
  store i32 %div, i32* %sortedLocalBlocks, align 4
  %2 = load i32* %groupIdx, align 4
  %3 = load i32* %groupIdx, align 4
  %4 = load i32* %offset.addr, align 4
  %shl = shl i32 %4, 1
  %5 = load i32* %sortedLocalBlocks, align 4
  %sub = sub i32 %shl, %5
  %div3 = udiv i32 %3, %sub
  %add = add i32 %div3, 1
  %6 = load i32* %sortedLocalBlocks, align 4
  %mul = mul i32 %add, %6
  %add4 = add i32 %2, %mul
  store i32 %add4, i32* %gidToUnsortedBlocks, align 4
  %7 = load i32* %gidToUnsortedBlocks, align 4
  %8 = load i32* %localSize, align 4
  %mul5 = mul nsw i32 %7, %8
  %conv6 = sext i32 %mul5 to i64
  %call7 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %add8 = add i64 %conv6, %call7
  %conv9 = trunc i64 %add8 to i32
  store i32 %conv9, i32* %globalIdx, align 4
  %9 = load i32* %globalIdx, align 4
  %add10 = add nsw i32 %9, 1
  %10 = load i32* %offset.addr, align 4
  %rem = urem i32 %add10, %10
  %cmp = icmp ne i32 %rem, 0
  br i1 %cmp, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %11 = load i32* %globalIdx, align 4
  %12 = load i32* %length.addr, align 4
  %cmp12 = icmp ult i32 %11, %12
  br i1 %cmp12, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %13 = load i32* %globalIdx, align 4
  %14 = load i32* %globalIdx, align 4
  %15 = load i32* %offset.addr, align 4
  %rem14 = urem i32 %14, %15
  %add15 = add i32 %rem14, 1
  %sub16 = sub i32 %13, %add15
  %idxprom = zext i32 %sub16 to i64
  %16 = load float addrspace(1)** %buffer.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %16, i64 %idxprom
  %17 = load float addrspace(1)* %arrayidx, align 4
  %18 = load i32* %globalIdx, align 4
  %idxprom17 = sext i32 %18 to i64
  %19 = load float addrspace(1)** %buffer.addr, align 8
  %arrayidx18 = getelementptr inbounds float addrspace(1)* %19, i64 %idxprom17
  %20 = load float addrspace(1)* %arrayidx18, align 4
  %add19 = fadd float %20, %17
  store float %add19, float addrspace(1)* %arrayidx18, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true, %entry
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!12}
!opencl.spir.version = !{!12}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32)* @__OpenCL_group_prefixSum_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"const", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (float addrspace(1)*, i32, i32)* @__OpenCL_global_prefixSum_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 0}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"uint", metadata !"uint"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"const", metadata !"const"}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"uint", metadata !"uint"}
!12 = metadata !{i32 1, i32 2}

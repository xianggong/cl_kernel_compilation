; ModuleID = 'PrefixSum_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_group_prefixSum_kernel(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %length, i32 %idxOffset) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %mul = mul nsw i32 %conv4, %conv2
  %add = add nsw i32 %mul, %conv
  %mul5 = mul nsw i32 2, %add
  %add6 = add nsw i32 %mul5, 1
  %mul7 = mul i32 %idxOffset, %add6
  %sub = sub i32 %mul7, 1
  %cmp = icmp ult i32 %sub, %length
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom
  %0 = load float addrspace(1)* %arrayidx, align 4
  %mul9 = mul nsw i32 2, %conv
  %idxprom10 = sext i32 %mul9 to i64
  %arrayidx11 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom10
  store float %0, float addrspace(3)* %arrayidx11, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %add12 = add i32 %sub, %idxOffset
  %cmp13 = icmp ult i32 %add12, %length
  br i1 %cmp13, label %if.then15, label %if.end23

if.then15:                                        ; preds = %if.end
  %add16 = add i32 %sub, %idxOffset
  %idxprom17 = zext i32 %add16 to i64
  %arrayidx18 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom17
  %1 = load float addrspace(1)* %arrayidx18, align 4
  %mul19 = mul nsw i32 2, %conv
  %add20 = add nsw i32 %mul19, 1
  %idxprom21 = sext i32 %add20 to i64
  %arrayidx22 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom21
  store float %1, float addrspace(3)* %arrayidx22, align 4
  br label %if.end23

if.end23:                                         ; preds = %if.then15, %if.end
  %shr = lshr i32 %length, 1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end23
  %offset.0 = phi i32 [ 1, %if.end23 ], [ %shl, %for.inc ]
  %l.0 = phi i32 [ %shr, %if.end23 ], [ %shr43, %for.inc ]
  %cmp24 = icmp sgt i32 %l.0, 0
  br i1 %cmp24, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  %cmp26 = icmp slt i32 %conv, %l.0
  br i1 %cmp26, label %if.then28, label %if.end42

if.then28:                                        ; preds = %for.body
  %mul29 = mul nsw i32 2, %conv
  %add30 = add nsw i32 %mul29, 1
  %mul31 = mul nsw i32 %offset.0, %add30
  %sub32 = sub nsw i32 %mul31, 1
  %mul33 = mul nsw i32 2, %conv
  %add34 = add nsw i32 %mul33, 2
  %mul35 = mul nsw i32 %offset.0, %add34
  %sub36 = sub nsw i32 %mul35, 1
  %idxprom37 = sext i32 %sub32 to i64
  %arrayidx38 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom37
  %2 = load float addrspace(3)* %arrayidx38, align 4
  %idxprom39 = sext i32 %sub36 to i64
  %arrayidx40 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom39
  %3 = load float addrspace(3)* %arrayidx40, align 4
  %add41 = fadd float %3, %2
  store float %add41, float addrspace(3)* %arrayidx40, align 4
  br label %if.end42

if.end42:                                         ; preds = %if.then28, %for.body
  %shl = shl i32 %offset.0, 1
  br label %for.inc

for.inc:                                          ; preds = %if.end42
  %shr43 = ashr i32 %l.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %cmp44 = icmp ult i32 %offset.0, %length
  br i1 %cmp44, label %if.then46, label %if.end48

if.then46:                                        ; preds = %for.end
  %shl47 = shl i32 %offset.0, 1
  br label %if.end48

if.end48:                                         ; preds = %if.then46, %for.end
  %offset.1 = phi i32 [ %shl47, %if.then46 ], [ %offset.0, %for.end ]
  %shr49 = ashr i32 %offset.1, 1
  br label %for.cond50

for.cond50:                                       ; preds = %for.inc72, %if.end48
  %offset.2 = phi i32 [ %offset.1, %if.end48 ], [ %shr55, %for.inc72 ]
  %d.0 = phi i32 [ 0, %if.end48 ], [ %shl73, %for.inc72 ]
  %cmp51 = icmp slt i32 %d.0, %shr49
  br i1 %cmp51, label %for.body53, label %for.end74

for.body53:                                       ; preds = %for.cond50
  %add54 = add nsw i32 %d.0, 1
  %shr55 = ashr i32 %offset.2, 1
  call cc75 void @_Z7barrierj(i32 1)
  %cmp56 = icmp slt i32 %conv, %add54
  br i1 %cmp56, label %if.then58, label %if.end71

if.then58:                                        ; preds = %for.body53
  %add60 = add nsw i32 %conv, 1
  %mul61 = mul nsw i32 %shr55, %add60
  %sub62 = sub nsw i32 %mul61, 1
  %shr64 = ashr i32 %shr55, 1
  %add65 = add nsw i32 %sub62, %shr64
  %idxprom66 = sext i32 %sub62 to i64
  %arrayidx67 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom66
  %4 = load float addrspace(3)* %arrayidx67, align 4
  %idxprom68 = sext i32 %add65 to i64
  %arrayidx69 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom68
  %5 = load float addrspace(3)* %arrayidx69, align 4
  %add70 = fadd float %5, %4
  store float %add70, float addrspace(3)* %arrayidx69, align 4
  br label %if.end71

if.end71:                                         ; preds = %if.then58, %for.body53
  br label %for.inc72

for.inc72:                                        ; preds = %if.end71
  %shl73 = shl i32 %add54, 1
  br label %for.cond50

for.end74:                                        ; preds = %for.cond50
  call cc75 void @_Z7barrierj(i32 1)
  %cmp75 = icmp ult i32 %sub, %length
  br i1 %cmp75, label %if.then77, label %if.end83

if.then77:                                        ; preds = %for.end74
  %mul78 = mul nsw i32 2, %conv
  %idxprom79 = sext i32 %mul78 to i64
  %arrayidx80 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom79
  %6 = load float addrspace(3)* %arrayidx80, align 4
  %idxprom81 = sext i32 %sub to i64
  %arrayidx82 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom81
  store float %6, float addrspace(1)* %arrayidx82, align 4
  br label %if.end83

if.end83:                                         ; preds = %if.then77, %for.end74
  %add84 = add i32 %sub, %idxOffset
  %cmp85 = icmp ult i32 %add84, %length
  br i1 %cmp85, label %if.then87, label %if.end95

if.then87:                                        ; preds = %if.end83
  %mul88 = mul nsw i32 2, %conv
  %add89 = add nsw i32 %mul88, 1
  %idxprom90 = sext i32 %add89 to i64
  %arrayidx91 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom90
  %7 = load float addrspace(3)* %arrayidx91, align 4
  %add92 = add i32 %sub, %idxOffset
  %idxprom93 = zext i32 %add92 to i64
  %arrayidx94 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom93
  store float %7, float addrspace(1)* %arrayidx94, align 4
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
  %call = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %div = udiv i32 %offset, %conv
  %shl = shl i32 %offset, 1
  %sub = sub i32 %shl, %div
  %div3 = udiv i32 %conv2, %sub
  %add = add i32 %div3, 1
  %mul = mul i32 %add, %div
  %add4 = add i32 %conv2, %mul
  %mul5 = mul nsw i32 %add4, %conv
  %conv6 = sext i32 %mul5 to i64
  %call7 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %add8 = add i64 %conv6, %call7
  %conv9 = trunc i64 %add8 to i32
  %add10 = add nsw i32 %conv9, 1
  %rem = urem i32 %add10, %offset
  %cmp = icmp ne i32 %rem, 0
  br i1 %cmp, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %cmp12 = icmp ult i32 %conv9, %length
  br i1 %cmp12, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %rem14 = urem i32 %conv9, %offset
  %add15 = add i32 %rem14, 1
  %sub16 = sub i32 %conv9, %add15
  %idxprom = zext i32 %sub16 to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %buffer, i64 %idxprom
  %0 = load float addrspace(1)* %arrayidx, align 4
  %idxprom17 = sext i32 %conv9 to i64
  %arrayidx18 = getelementptr inbounds float addrspace(1)* %buffer, i64 %idxprom17
  %1 = load float addrspace(1)* %arrayidx18, align 4
  %add19 = fadd float %1, %0
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

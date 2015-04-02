; ModuleID = 'ScanLargeArrays_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@blockAddition.value = internal addrspace(3) global [1 x float] zeroinitializer, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_blockAddition_kernel(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %cmp = icmp eq i32 %conv4, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %idxprom = sext i32 %conv2 to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom
  %0 = load float addrspace(1)* %arrayidx, align 4
  store float %0, float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i64 0), align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  call cc75 void @_Z7barrierj(i32 1)
  %1 = load float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i64 0), align 4
  %idxprom6 = sext i32 %conv to i64
  %arrayidx7 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom6
  %2 = load float addrspace(1)* %arrayidx7, align 4
  %add = fadd float %2, %1
  store float %add, float addrspace(1)* %arrayidx7, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

; Function Attrs: nounwind
define cc76 void @__OpenCL_ScanLargeArrays_kernel(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size, float addrspace(1)* %sumBuffer) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %mul = mul nsw i32 2, %conv2
  %idxprom = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom
  %0 = load float addrspace(1)* %arrayidx, align 4
  %mul5 = mul nsw i32 2, %conv
  %idxprom6 = sext i32 %mul5 to i64
  %arrayidx7 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom6
  store float %0, float addrspace(3)* %arrayidx7, align 4
  %mul8 = mul nsw i32 2, %conv2
  %add = add nsw i32 %mul8, 1
  %idxprom9 = sext i32 %add to i64
  %arrayidx10 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom9
  %1 = load float addrspace(1)* %arrayidx10, align 4
  %mul11 = mul nsw i32 2, %conv
  %add12 = add nsw i32 %mul11, 1
  %idxprom13 = sext i32 %add12 to i64
  %arrayidx14 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom13
  store float %1, float addrspace(3)* %arrayidx14, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %arrayidx15 = getelementptr inbounds float addrspace(3)* %block, i64 0
  %2 = load float addrspace(3)* %arrayidx15, align 4
  %arrayidx16 = getelementptr inbounds float addrspace(3)* %block, i64 1
  %3 = load float addrspace(3)* %arrayidx16, align 4
  %add17 = fadd float %2, %3
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %cache0.0 = phi float [ %2, %entry ], [ %cache0.1, %for.inc ]
  %cache1.0 = phi float [ %add17, %entry ], [ %cache1.1, %for.inc ]
  %stride.0 = phi i32 [ 1, %entry ], [ %mul46, %for.inc ]
  %cmp = icmp ult i32 %stride.0, %block_size
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul19 = mul nsw i32 2, %conv
  %cmp20 = icmp sge i32 %mul19, %stride.0
  br i1 %cmp20, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %mul22 = mul nsw i32 2, %conv
  %sub = sub nsw i32 %mul22, %stride.0
  %idxprom23 = sext i32 %sub to i64
  %arrayidx24 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom23
  %4 = load float addrspace(3)* %arrayidx24, align 4
  %mul25 = mul nsw i32 2, %conv
  %idxprom26 = sext i32 %mul25 to i64
  %arrayidx27 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom26
  %5 = load float addrspace(3)* %arrayidx27, align 4
  %add28 = fadd float %4, %5
  %mul29 = mul nsw i32 2, %conv
  %add30 = add nsw i32 %mul29, 1
  %sub31 = sub nsw i32 %add30, %stride.0
  %idxprom32 = sext i32 %sub31 to i64
  %arrayidx33 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom32
  %6 = load float addrspace(3)* %arrayidx33, align 4
  %mul34 = mul nsw i32 2, %conv
  %add35 = add nsw i32 %mul34, 1
  %idxprom36 = sext i32 %add35 to i64
  %arrayidx37 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom36
  %7 = load float addrspace(3)* %arrayidx37, align 4
  %add38 = fadd float %6, %7
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %cache0.1 = phi float [ %add28, %if.then ], [ %cache0.0, %for.body ]
  %cache1.1 = phi float [ %add38, %if.then ], [ %cache1.0, %for.body ]
  call cc75 void @_Z7barrierj(i32 1)
  %mul39 = mul nsw i32 2, %conv
  %idxprom40 = sext i32 %mul39 to i64
  %arrayidx41 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom40
  store float %cache0.1, float addrspace(3)* %arrayidx41, align 4
  %mul42 = mul nsw i32 2, %conv
  %add43 = add nsw i32 %mul42, 1
  %idxprom44 = sext i32 %add43 to i64
  %arrayidx45 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom44
  store float %cache1.1, float addrspace(3)* %arrayidx45, align 4
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %mul46 = mul nsw i32 %stride.0, 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %sub47 = sub i32 %block_size, 1
  %idxprom48 = zext i32 %sub47 to i64
  %arrayidx49 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom48
  %8 = load float addrspace(3)* %arrayidx49, align 4
  %idxprom50 = sext i32 %conv4 to i64
  %arrayidx51 = getelementptr inbounds float addrspace(1)* %sumBuffer, i64 %idxprom50
  store float %8, float addrspace(1)* %arrayidx51, align 4
  %cmp52 = icmp eq i32 %conv, 0
  br i1 %cmp52, label %if.then54, label %if.else

if.then54:                                        ; preds = %for.end
  %mul55 = mul nsw i32 2, %conv2
  %idxprom56 = sext i32 %mul55 to i64
  %arrayidx57 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom56
  store float 0.000000e+00, float addrspace(1)* %arrayidx57, align 4
  %mul58 = mul nsw i32 2, %conv
  %idxprom59 = sext i32 %mul58 to i64
  %arrayidx60 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom59
  %9 = load float addrspace(3)* %arrayidx60, align 4
  %mul61 = mul nsw i32 2, %conv2
  %add62 = add nsw i32 %mul61, 1
  %idxprom63 = sext i32 %add62 to i64
  %arrayidx64 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom63
  store float %9, float addrspace(1)* %arrayidx64, align 4
  br label %if.end79

if.else:                                          ; preds = %for.end
  %mul65 = mul nsw i32 2, %conv
  %sub66 = sub nsw i32 %mul65, 1
  %idxprom67 = sext i32 %sub66 to i64
  %arrayidx68 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom67
  %10 = load float addrspace(3)* %arrayidx68, align 4
  %mul69 = mul nsw i32 2, %conv2
  %idxprom70 = sext i32 %mul69 to i64
  %arrayidx71 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom70
  store float %10, float addrspace(1)* %arrayidx71, align 4
  %mul72 = mul nsw i32 2, %conv
  %idxprom73 = sext i32 %mul72 to i64
  %arrayidx74 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom73
  %11 = load float addrspace(3)* %arrayidx74, align 4
  %mul75 = mul nsw i32 2, %conv2
  %add76 = add nsw i32 %mul75, 1
  %idxprom77 = sext i32 %add76 to i64
  %arrayidx78 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom77
  store float %11, float addrspace(1)* %arrayidx78, align 4
  br label %if.end79

if.end79:                                         ; preds = %if.else, %if.then54
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_prefixSum_kernel(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %mul = mul nsw i32 2, %conv2
  %idxprom = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom
  %0 = load float addrspace(1)* %arrayidx, align 4
  %mul5 = mul nsw i32 2, %conv
  %idxprom6 = sext i32 %mul5 to i64
  %arrayidx7 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom6
  store float %0, float addrspace(3)* %arrayidx7, align 4
  %mul8 = mul nsw i32 2, %conv2
  %add = add nsw i32 %mul8, 1
  %idxprom9 = sext i32 %add to i64
  %arrayidx10 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom9
  %1 = load float addrspace(1)* %arrayidx10, align 4
  %mul11 = mul nsw i32 2, %conv
  %add12 = add nsw i32 %mul11, 1
  %idxprom13 = sext i32 %add12 to i64
  %arrayidx14 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom13
  store float %1, float addrspace(3)* %arrayidx14, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %arrayidx15 = getelementptr inbounds float addrspace(3)* %block, i64 0
  %2 = load float addrspace(3)* %arrayidx15, align 4
  %arrayidx16 = getelementptr inbounds float addrspace(3)* %block, i64 1
  %3 = load float addrspace(3)* %arrayidx16, align 4
  %add17 = fadd float %2, %3
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %cache0.0 = phi float [ %2, %entry ], [ %cache0.1, %for.inc ]
  %cache1.0 = phi float [ %add17, %entry ], [ %cache1.1, %for.inc ]
  %stride.0 = phi i32 [ 1, %entry ], [ %mul46, %for.inc ]
  %cmp = icmp ult i32 %stride.0, %block_size
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul19 = mul nsw i32 2, %conv
  %cmp20 = icmp sge i32 %mul19, %stride.0
  br i1 %cmp20, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %mul22 = mul nsw i32 2, %conv
  %sub = sub nsw i32 %mul22, %stride.0
  %idxprom23 = sext i32 %sub to i64
  %arrayidx24 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom23
  %4 = load float addrspace(3)* %arrayidx24, align 4
  %mul25 = mul nsw i32 2, %conv
  %idxprom26 = sext i32 %mul25 to i64
  %arrayidx27 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom26
  %5 = load float addrspace(3)* %arrayidx27, align 4
  %add28 = fadd float %4, %5
  %mul29 = mul nsw i32 2, %conv
  %add30 = add nsw i32 %mul29, 1
  %sub31 = sub nsw i32 %add30, %stride.0
  %idxprom32 = sext i32 %sub31 to i64
  %arrayidx33 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom32
  %6 = load float addrspace(3)* %arrayidx33, align 4
  %mul34 = mul nsw i32 2, %conv
  %add35 = add nsw i32 %mul34, 1
  %idxprom36 = sext i32 %add35 to i64
  %arrayidx37 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom36
  %7 = load float addrspace(3)* %arrayidx37, align 4
  %add38 = fadd float %6, %7
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %cache0.1 = phi float [ %add28, %if.then ], [ %cache0.0, %for.body ]
  %cache1.1 = phi float [ %add38, %if.then ], [ %cache1.0, %for.body ]
  call cc75 void @_Z7barrierj(i32 1)
  %mul39 = mul nsw i32 2, %conv
  %idxprom40 = sext i32 %mul39 to i64
  %arrayidx41 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom40
  store float %cache0.1, float addrspace(3)* %arrayidx41, align 4
  %mul42 = mul nsw i32 2, %conv
  %add43 = add nsw i32 %mul42, 1
  %idxprom44 = sext i32 %add43 to i64
  %arrayidx45 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom44
  store float %cache1.1, float addrspace(3)* %arrayidx45, align 4
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %mul46 = mul nsw i32 %stride.0, 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %cmp47 = icmp eq i32 %conv, 0
  br i1 %cmp47, label %if.then49, label %if.else

if.then49:                                        ; preds = %for.end
  %mul50 = mul nsw i32 2, %conv2
  %idxprom51 = sext i32 %mul50 to i64
  %arrayidx52 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom51
  store float 0.000000e+00, float addrspace(1)* %arrayidx52, align 4
  %mul53 = mul nsw i32 2, %conv
  %idxprom54 = sext i32 %mul53 to i64
  %arrayidx55 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom54
  %8 = load float addrspace(3)* %arrayidx55, align 4
  %mul56 = mul nsw i32 2, %conv2
  %add57 = add nsw i32 %mul56, 1
  %idxprom58 = sext i32 %add57 to i64
  %arrayidx59 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom58
  store float %8, float addrspace(1)* %arrayidx59, align 4
  br label %if.end74

if.else:                                          ; preds = %for.end
  %mul60 = mul nsw i32 2, %conv
  %sub61 = sub nsw i32 %mul60, 1
  %idxprom62 = sext i32 %sub61 to i64
  %arrayidx63 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom62
  %9 = load float addrspace(3)* %arrayidx63, align 4
  %mul64 = mul nsw i32 2, %conv2
  %idxprom65 = sext i32 %mul64 to i64
  %arrayidx66 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom65
  store float %9, float addrspace(1)* %arrayidx66, align 4
  %mul67 = mul nsw i32 2, %conv
  %idxprom68 = sext i32 %mul67 to i64
  %arrayidx69 = getelementptr inbounds float addrspace(3)* %block, i64 %idxprom68
  %10 = load float addrspace(3)* %arrayidx69, align 4
  %mul70 = mul nsw i32 2, %conv2
  %add71 = add nsw i32 %mul70, 1
  %idxprom72 = sext i32 %add71 to i64
  %arrayidx73 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom72
  store float %10, float addrspace(1)* %arrayidx73, align 4
  br label %if.end74

if.end74:                                         ; preds = %if.else, %if.then49
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !12}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!18}
!opencl.spir.version = !{!18}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @__OpenCL_blockAddition_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*"}
!6 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, float addrspace(1)*)* @__OpenCL_ScanLargeArrays_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0, i32 1}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"float*"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"const", metadata !""}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"float*"}
!12 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32)* @__OpenCL_prefixSum_kernel, metadata !13, metadata !14, metadata !15, metadata !16, metadata !17}
!13 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0}
!14 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!15 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint"}
!16 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"const"}
!17 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint"}
!18 = metadata !{i32 1, i32 2}

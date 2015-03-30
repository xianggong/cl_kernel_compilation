; ModuleID = '../kernel-src/PrefixSum_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @group_prefixSum(float addrspace(1)* nocapture %output, float addrspace(1)* nocapture readonly %input, float addrspace(3)* nocapture %block, i32 %length, i32 %idxOffset) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %call1 = tail call i32 @get_local_size(i32 0) #2
  %call2 = tail call i32 @get_group_id(i32 0) #2
  %mul = mul nsw i32 %call2, %call1
  %add = add nsw i32 %mul, %call
  %mul3 = shl nsw i32 %add, 1
  %add4123 = or i32 %mul3, 1
  %mul5 = mul i32 %add4123, %idxOffset
  %sub = add i32 %mul5, -1
  %cmp = icmp ult i32 %sub, %length
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !3
  %mul6 = shl nsw i32 %call, 1
  %arrayidx7 = getelementptr inbounds float addrspace(3)* %block, i32 %mul6
  store float %1, float addrspace(3)* %arrayidx7, align 4, !tbaa !3
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %add8 = add i32 %sub, %idxOffset
  %cmp9 = icmp ult i32 %add8, %length
  br i1 %cmp9, label %if.then10, label %if.end16

if.then10:                                        ; preds = %if.end
  %2 = sext i32 %add8 to i64
  %arrayidx12 = getelementptr inbounds float addrspace(1)* %input, i64 %2
  %3 = load float addrspace(1)* %arrayidx12, align 4, !tbaa !3
  %mul13 = shl nsw i32 %call, 1
  %add14127 = or i32 %mul13, 1
  %arrayidx15 = getelementptr inbounds float addrspace(3)* %block, i32 %add14127
  store float %3, float addrspace(3)* %arrayidx15, align 4, !tbaa !3
  br label %if.end16

if.end16:                                         ; preds = %if.then10, %if.end
  %shr = lshr i32 %length, 1
  %cmp17131 = icmp eq i32 %shr, 0
  br i1 %cmp17131, label %for.end, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %if.end16
  %mul20 = shl nsw i32 %call, 1
  %add21126 = or i32 %mul20, 1
  %add25 = add nsw i32 %mul20, 2
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %if.end31
  %offset.0133 = phi i32 [ 1, %for.body.lr.ph ], [ %shl, %if.end31 ]
  %l.0132 = phi i32 [ %shr, %for.body.lr.ph ], [ %shr32, %if.end31 ]
  tail call void @barrier(i32 1) #2
  %cmp18 = icmp slt i32 %call, %l.0132
  br i1 %cmp18, label %if.then19, label %if.end31

if.then19:                                        ; preds = %for.body
  %mul22 = mul nsw i32 %offset.0133, %add21126
  %sub23 = add nsw i32 %mul22, -1
  %mul26 = mul nsw i32 %offset.0133, %add25
  %sub27 = add nsw i32 %mul26, -1
  %arrayidx28 = getelementptr inbounds float addrspace(3)* %block, i32 %sub23
  %4 = load float addrspace(3)* %arrayidx28, align 4, !tbaa !3
  %arrayidx29 = getelementptr inbounds float addrspace(3)* %block, i32 %sub27
  %5 = load float addrspace(3)* %arrayidx29, align 4, !tbaa !3
  %add30 = fadd float %4, %5
  store float %add30, float addrspace(3)* %arrayidx29, align 4, !tbaa !3
  br label %if.end31

if.end31:                                         ; preds = %if.then19, %for.body
  %shl = shl i32 %offset.0133, 1
  %shr32 = ashr i32 %l.0132, 1
  %cmp17 = icmp sgt i32 %shr32, 0
  br i1 %cmp17, label %for.body, label %for.end

for.end:                                          ; preds = %if.end31, %if.end16
  %offset.0.lcssa = phi i32 [ 1, %if.end16 ], [ %shl, %if.end31 ]
  %cmp33 = icmp ult i32 %offset.0.lcssa, %length
  %shl35 = zext i1 %cmp33 to i32
  %shl35.offset.0 = shl i32 %offset.0.lcssa, %shl35
  %shr37 = ashr i32 %shl35.offset.0, 1
  %cmp39128 = icmp sgt i32 %shr37, 0
  br i1 %cmp39128, label %for.body40.lr.ph, label %for.end58

for.body40.lr.ph:                                 ; preds = %for.end
  %add46 = add nsw i32 %call, 1
  br label %for.body40

for.body40:                                       ; preds = %for.body40.lr.ph, %for.inc56
  %offset.2130 = phi i32 [ %shl35.offset.0, %for.body40.lr.ph ], [ %shr42, %for.inc56 ]
  %d.0129 = phi i32 [ 0, %for.body40.lr.ph ], [ %shl57, %for.inc56 ]
  %add41125 = or i32 %d.0129, 1
  %shr42 = ashr i32 %offset.2130, 1
  tail call void @barrier(i32 1) #2
  %cmp43 = icmp slt i32 %call, %add41125
  br i1 %cmp43, label %if.then44, label %for.inc56

if.then44:                                        ; preds = %for.body40
  %mul47 = mul nsw i32 %shr42, %add46
  %sub48 = add nsw i32 %mul47, -1
  %shr50 = ashr i32 %offset.2130, 2
  %add51 = add nsw i32 %sub48, %shr50
  %arrayidx52 = getelementptr inbounds float addrspace(3)* %block, i32 %sub48
  %6 = load float addrspace(3)* %arrayidx52, align 4, !tbaa !3
  %arrayidx53 = getelementptr inbounds float addrspace(3)* %block, i32 %add51
  %7 = load float addrspace(3)* %arrayidx53, align 4, !tbaa !3
  %add54 = fadd float %6, %7
  store float %add54, float addrspace(3)* %arrayidx53, align 4, !tbaa !3
  br label %for.inc56

for.inc56:                                        ; preds = %for.body40, %if.then44
  %shl57 = shl i32 %add41125, 1
  %cmp39 = icmp slt i32 %shl57, %shr37
  br i1 %cmp39, label %for.body40, label %for.end58

for.end58:                                        ; preds = %for.inc56, %for.end
  tail call void @barrier(i32 1) #2
  br i1 %cmp, label %if.then60, label %if.end64

if.then60:                                        ; preds = %for.end58
  %mul61 = shl nsw i32 %call, 1
  %arrayidx62 = getelementptr inbounds float addrspace(3)* %block, i32 %mul61
  %8 = load float addrspace(3)* %arrayidx62, align 4, !tbaa !3
  %9 = sext i32 %sub to i64
  %arrayidx63 = getelementptr inbounds float addrspace(1)* %output, i64 %9
  store float %8, float addrspace(1)* %arrayidx63, align 4, !tbaa !3
  br label %if.end64

if.end64:                                         ; preds = %if.then60, %for.end58
  br i1 %cmp9, label %if.then67, label %if.end73

if.then67:                                        ; preds = %if.end64
  %mul68 = shl nsw i32 %call, 1
  %add69124 = or i32 %mul68, 1
  %arrayidx70 = getelementptr inbounds float addrspace(3)* %block, i32 %add69124
  %10 = load float addrspace(3)* %arrayidx70, align 4, !tbaa !3
  %11 = sext i32 %add8 to i64
  %arrayidx72 = getelementptr inbounds float addrspace(1)* %output, i64 %11
  store float %10, float addrspace(1)* %arrayidx72, align 4, !tbaa !3
  br label %if.end73

if.end73:                                         ; preds = %if.then67, %if.end64
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_local_size(i32) #1

declare i32 @get_group_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @global_prefixSum(float addrspace(1)* nocapture %buffer, i32 %offset, i32 %length) #0 {
entry:
  %call = tail call i32 @get_local_size(i32 0) #2
  %call1 = tail call i32 @get_group_id(i32 0) #2
  %div = udiv i32 %offset, %call
  %shl = shl i32 %offset, 1
  %sub = sub i32 %shl, %div
  %div2 = udiv i32 %call1, %sub
  %add = add i32 %div2, 1
  %mul = mul i32 %add, %div
  %add3 = add i32 %mul, %call1
  %mul4 = mul nsw i32 %add3, %call
  %call5 = tail call i32 @get_local_id(i32 0) #2
  %add6 = add i32 %mul4, %call5
  %add7 = add nsw i32 %add6, 1
  %rem = urem i32 %add7, %offset
  %cmp = icmp ne i32 %rem, 0
  %cmp8 = icmp ult i32 %add6, %length
  %or.cond = and i1 %cmp, %cmp8
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %rem9 = urem i32 %add6, %offset
  %add10.neg = add i32 %add6, -1
  %sub11 = sub i32 %add10.neg, %rem9
  %0 = sext i32 %sub11 to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %buffer, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !3
  %2 = sext i32 %add6 to i64
  %arrayidx12 = getelementptr inbounds float addrspace(1)* %buffer, i64 %2
  %3 = load float addrspace(1)* %arrayidx12, align 4, !tbaa !3
  %add13 = fadd float %1, %3
  store float %add13, float addrspace(1)* %arrayidx12, align 4, !tbaa !3
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32)* @group_prefixSum}
!1 = metadata !{void (float addrspace(1)*, i32, i32)* @global_prefixSum}
!2 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"float", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}

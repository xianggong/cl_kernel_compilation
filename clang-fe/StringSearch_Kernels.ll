; ModuleID = '../kernel-src/StringSearch_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@StringSearchNaive.groupSuccessCounter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack1Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.groupSuccessCounter = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind readonly
define i32 @compare(i8 addrspace(1)* nocapture readonly %text, i8 addrspace(3)* nocapture readonly %pattern, i32 %length) #0 {
entry:
  %cmp24 = icmp eq i32 %length, 0
  br i1 %cmp24, label %return, label %for.body

for.cond:                                         ; preds = %for.body
  %cmp = icmp ult i32 %inc, %length
  br i1 %cmp, label %for.body, label %return

for.body:                                         ; preds = %entry, %for.cond
  %l.025 = phi i32 [ %inc, %for.cond ], [ 0, %entry ]
  %0 = sext i32 %l.025 to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %text, i64 %0
  %1 = load i8 addrspace(1)* %arrayidx, align 1, !tbaa !3
  %conv = zext i8 %1 to i32
  %.off = add i8 %1, -65
  %2 = icmp ult i8 %.off, 26
  %add = add nsw i32 %conv, 32
  %add.conv = select i1 %2, i32 %add, i32 %conv
  %arrayidx11 = getelementptr inbounds i8 addrspace(3)* %pattern, i32 %l.025
  %3 = load i8 addrspace(3)* %arrayidx11, align 1, !tbaa !3
  %conv12 = zext i8 %3 to i32
  %cmp13 = icmp eq i32 %add.conv, %conv12
  %inc = add i32 %l.025, 1
  br i1 %cmp13, label %for.cond, label %return

return:                                           ; preds = %for.cond, %for.body, %entry
  %retval.0 = phi i32 [ 1, %entry ], [ 0, %for.body ], [ 1, %for.cond ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define void @StringSearchNaive(i8 addrspace(1)* nocapture readonly %text, i32 %textLength, i8 addrspace(1)* nocapture readonly %pattern, i32 %patternLength, i32 addrspace(1)* nocapture %resultBuffer, i32 addrspace(1)* nocapture %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* nocapture %localPattern) #1 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #3
  %call1 = tail call i32 @get_local_size(i32 0) #3
  %call2 = tail call i32 @get_group_id(i32 0) #3
  %sub = sub i32 %textLength, %patternLength
  %add = add i32 %sub, 1
  %mul = mul i32 %call2, %maxSearchLength
  %add3 = add i32 %mul, %maxSearchLength
  %cmp = icmp ugt i32 %mul, %add
  br i1 %cmp, label %if.end47, label %if.end

if.end:                                           ; preds = %entry
  %cmp4 = icmp ugt i32 %add3, %add
  %add.add3 = select i1 %cmp4, i32 %add, i32 %add3
  %cmp780 = icmp ult i32 %call, %patternLength
  br i1 %cmp780, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %if.end
  %0 = sext i32 %call to i64
  %1 = sext i32 %call1 to i64
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %indvars.iv = phi i64 [ %0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %idx.081 = phi i32 [ %call, %for.body.lr.ph ], [ %add22, %for.body ]
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %indvars.iv
  %2 = load i8 addrspace(1)* %arrayidx, align 1, !tbaa !3
  %conv = zext i8 %2 to i32
  %.off = add i8 %2, -65
  %3 = icmp ult i8 %.off, 26
  %add17 = add nsw i32 %conv, 32
  %add17.conv = select i1 %3, i32 %add17, i32 %conv
  %conv20 = trunc i32 %add17.conv to i8
  %arrayidx21 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %idx.081
  store i8 %conv20, i8 addrspace(3)* %arrayidx21, align 1, !tbaa !3
  %indvars.iv.next = add nsw i64 %indvars.iv, %1
  %add22 = add nsw i32 %idx.081, %call1
  %4 = trunc i64 %indvars.iv.next to i32
  %cmp7 = icmp ult i32 %4, %patternLength
  br i1 %cmp7, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %if.end
  %cmp23 = icmp eq i32 %call, 0
  br i1 %cmp23, label %if.then25, label %if.end26

if.then25:                                        ; preds = %for.end
  store volatile i32 0, i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4, !tbaa !6
  br label %if.end26

if.end26:                                         ; preds = %if.then25, %for.end
  tail call void @barrier(i32 1) #3
  %add27 = add i32 %mul, %call
  %cmp2978 = icmp ult i32 %add27, %add.add3
  br i1 %cmp2978, label %for.body31.lr.ph, label %for.end42

for.body31.lr.ph:                                 ; preds = %if.end26
  %cmp24.i = icmp eq i32 %patternLength, 0
  br label %for.body31

for.body31:                                       ; preds = %for.body31.lr.ph, %for.inc40
  %stringPos.079 = phi i32 [ %add27, %for.body31.lr.ph ], [ %add41, %for.inc40 ]
  %5 = sext i32 %stringPos.079 to i64
  br i1 %cmp24.i, label %if.then35, label %for.body.i

for.cond.i:                                       ; preds = %for.body.i
  %cmp.i = icmp ult i32 %inc.i, %patternLength
  br i1 %cmp.i, label %for.body.i, label %if.then35

for.body.i:                                       ; preds = %for.body31, %for.cond.i
  %l.025.i = phi i32 [ %inc.i, %for.cond.i ], [ 0, %for.body31 ]
  %6 = sext i32 %l.025.i to i64
  %add.ptr.sum = add i64 %6, %5
  %arrayidx.i = getelementptr inbounds i8 addrspace(1)* %text, i64 %add.ptr.sum
  %7 = load i8 addrspace(1)* %arrayidx.i, align 1, !tbaa !3
  %conv.i = zext i8 %7 to i32
  %.off.i = add i8 %7, -65
  %8 = icmp ult i8 %.off.i, 26
  %add.i = add nsw i32 %conv.i, 32
  %add.conv.i = select i1 %8, i32 %add.i, i32 %conv.i
  %arrayidx11.i = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %l.025.i
  %9 = load i8 addrspace(3)* %arrayidx11.i, align 1, !tbaa !3
  %conv12.i = zext i8 %9 to i32
  %cmp13.i = icmp eq i32 %add.conv.i, %conv12.i
  %inc.i = add i32 %l.025.i, 1
  br i1 %cmp13.i, label %for.cond.i, label %for.inc40

if.then35:                                        ; preds = %for.cond.i, %for.body31
  %call36 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, i32 1) #3
  %add37 = add i32 %call36, %mul
  %10 = sext i32 %add37 to i64
  %arrayidx38 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i64 %10
  store i32 %stringPos.079, i32 addrspace(1)* %arrayidx38, align 4, !tbaa !6
  br label %for.inc40

for.inc40:                                        ; preds = %for.body.i, %if.then35
  %add41 = add i32 %stringPos.079, %call1
  %cmp29 = icmp ult i32 %add41, %add.add3
  br i1 %cmp29, label %for.body31, label %for.end42

for.end42:                                        ; preds = %for.inc40, %if.end26
  tail call void @barrier(i32 1) #3
  br i1 %cmp23, label %if.then45, label %if.end47

if.then45:                                        ; preds = %for.end42
  %11 = load volatile i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4, !tbaa !6
  %12 = sext i32 %call2 to i64
  %arrayidx46 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i64 %12
  store i32 %11, i32 addrspace(1)* %arrayidx46, align 4, !tbaa !6
  br label %if.end47

if.end47:                                         ; preds = %entry, %if.then45, %for.end42
  ret void
}

declare i32 @get_local_id(i32) #2

declare i32 @get_local_size(i32) #2

declare i32 @get_group_id(i32) #2

declare void @barrier(i32) #2

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #2

; Function Attrs: nounwind
define void @StringSearchLoadBalance(i8 addrspace(1)* nocapture readonly %text, i32 %textLength, i8 addrspace(1)* nocapture readonly %pattern, i32 %patternLength, i32 addrspace(1)* nocapture %resultBuffer, i32 addrspace(1)* nocapture %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* nocapture %localPattern, i32 addrspace(3)* nocapture %stack1) #1 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #3
  %call1 = tail call i32 @get_local_size(i32 0) #3
  %call2 = tail call i32 @get_group_id(i32 0) #3
  %cmp = icmp eq i32 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4, !tbaa !6
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !6
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %sub = sub i32 %textLength, %patternLength
  %add = add i32 %sub, 1
  %mul = mul i32 %call2, %maxSearchLength
  %add3 = add i32 %mul, %maxSearchLength
  %cmp4 = icmp ugt i32 %mul, %add
  br i1 %cmp4, label %if.end138, label %if.end6

if.end6:                                          ; preds = %if.end
  %cmp7 = icmp ugt i32 %add3, %add
  %add.add3 = select i1 %cmp7, i32 %add, i32 %add3
  %sub10 = sub i32 %add.add3, %mul
  %cmp11214 = icmp ult i32 %call, %patternLength
  br i1 %cmp11214, label %for.body, label %for.end

for.body:                                         ; preds = %if.end6, %for.body
  %idx.0215 = phi i32 [ %add26, %for.body ], [ %call, %if.end6 ]
  %0 = sext i32 %idx.0215 to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %0
  %1 = load i8 addrspace(1)* %arrayidx, align 1, !tbaa !3
  %conv = zext i8 %1 to i32
  %.off213 = add i8 %1, -65
  %2 = icmp ult i8 %.off213, 26
  %add21 = add nsw i32 %conv, 32
  %add21.conv = select i1 %2, i32 %add21, i32 %conv
  %conv24 = trunc i32 %add21.conv to i8
  %arrayidx25 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %idx.0215
  store i8 %conv24, i8 addrspace(3)* %arrayidx25, align 1, !tbaa !3
  %add26 = add i32 %idx.0215, %call1
  %cmp11 = icmp ult i32 %add26, %patternLength
  br i1 %cmp11, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %if.end6
  tail call void @barrier(i32 1) #3
  %3 = load i8 addrspace(3)* %localPattern, align 1, !tbaa !3
  %arrayidx28 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 1
  %4 = load i8 addrspace(3)* %arrayidx28, align 1, !tbaa !3
  %conv32 = zext i8 %3 to i32
  %conv59 = zext i8 %4 to i32
  %5 = sext i32 %mul to i64
  %sub111 = add i32 %patternLength, -2
  %cmp24.i = icmp eq i32 %sub111, 0
  %add.ptr.sum = add i64 %5, 2
  %6 = sext i32 %call to i64
  %7 = sext i32 %call1 to i64
  br label %while.body

while.body:                                       ; preds = %if.end121, %land.lhs.true97, %for.end
  %indvars.iv = phi i64 [ %6, %for.end ], [ %indvars.iv.next, %land.lhs.true97 ], [ %indvars.iv.next, %if.end121 ]
  %8 = trunc i64 %indvars.iv to i32
  %cmp29 = icmp ult i32 %8, %sub10
  br i1 %cmp29, label %if.then31, label %if.end93

if.then31:                                        ; preds = %while.body
  %add33 = add i32 %8, %mul
  %9 = sext i32 %add33 to i64
  %arrayidx34 = getelementptr inbounds i8 addrspace(1)* %text, i64 %9
  %10 = load i8 addrspace(1)* %arrayidx34, align 1, !tbaa !3
  %conv35 = zext i8 %10 to i32
  %.off = add i8 %10, -65
  %11 = icmp ult i8 %.off, 26
  %add49 = add nsw i32 %conv35, 32
  %add49.conv35 = select i1 %11, i32 %add49, i32 %conv35
  %cmp56 = icmp eq i32 %conv32, %add49.conv35
  br i1 %cmp56, label %land.lhs.true58, label %if.end93

land.lhs.true58:                                  ; preds = %if.then31
  %add61 = add i32 %add33, 1
  %12 = sext i32 %add61 to i64
  %arrayidx62 = getelementptr inbounds i8 addrspace(1)* %text, i64 %12
  %13 = load i8 addrspace(1)* %arrayidx62, align 1, !tbaa !3
  %conv63 = zext i8 %13 to i32
  %.off212 = add i8 %13, -65
  %14 = icmp ult i8 %.off212, 26
  %add79 = add nsw i32 %conv63, 32
  %add79.conv63 = select i1 %14, i32 %add79, i32 %conv63
  %cmp87 = icmp eq i32 %conv59, %add79.conv63
  br i1 %cmp87, label %if.then89, label %if.end93

if.then89:                                        ; preds = %land.lhs.true58
  %call90 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1) #3
  %arrayidx91 = getelementptr inbounds i32 addrspace(3)* %stack1, i32 %call90
  store i32 %8, i32 addrspace(3)* %arrayidx91, align 4, !tbaa !6
  br label %if.end93

if.end93:                                         ; preds = %if.then31, %land.lhs.true58, %if.then89, %while.body
  %indvars.iv.next = add nsw i64 %indvars.iv, %7
  tail call void @barrier(i32 1) #3
  %15 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !6
  tail call void @barrier(i32 1) #3
  %cmp95 = icmp ult i32 %15, %call1
  br i1 %cmp95, label %land.lhs.true97, label %if.end102

land.lhs.true97:                                  ; preds = %if.end93
  %16 = trunc i64 %indvars.iv.next to i32
  %div = srem i32 %16, %call1
  %mul98 = sub i32 %16, %div
  %cmp99 = icmp ult i32 %mul98, %sub10
  br i1 %cmp99, label %while.body, label %if.end102

if.end102:                                        ; preds = %land.lhs.true97, %if.end93
  %cmp103 = icmp ult i32 %call, %15
  br i1 %cmp103, label %if.then105, label %if.end121

if.then105:                                       ; preds = %if.end102
  %call106 = tail call i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1) #3
  %dec = add nsw i32 %call106, -1
  %arrayidx107 = getelementptr inbounds i32 addrspace(3)* %stack1, i32 %dec
  %17 = load i32 addrspace(3)* %arrayidx107, align 4, !tbaa !6
  br i1 %cmp24.i, label %if.then115, label %for.body.i.preheader

for.body.i.preheader:                             ; preds = %if.then105
  %18 = sext i32 %17 to i64
  %add.ptr108.sum = add i64 %add.ptr.sum, %18
  br label %for.body.i

for.cond.i:                                       ; preds = %for.body.i
  %cmp.i = icmp ult i32 %inc.i, %sub111
  br i1 %cmp.i, label %for.body.i, label %if.then115

for.body.i:                                       ; preds = %for.body.i.preheader, %for.cond.i
  %l.025.i = phi i32 [ %inc.i, %for.cond.i ], [ 0, %for.body.i.preheader ]
  %19 = sext i32 %l.025.i to i64
  %add.ptr109.sum = add i64 %add.ptr108.sum, %19
  %arrayidx.i = getelementptr inbounds i8 addrspace(1)* %text, i64 %add.ptr109.sum
  %20 = load i8 addrspace(1)* %arrayidx.i, align 1, !tbaa !3
  %conv.i = zext i8 %20 to i32
  %.off.i = add i8 %20, -65
  %21 = icmp ult i8 %.off.i, 26
  %add.i = add nsw i32 %conv.i, 32
  %add.conv.i = select i1 %21, i32 %add.i, i32 %conv.i
  %add.ptr110.sum = add i32 %l.025.i, 2
  %arrayidx11.i = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %add.ptr110.sum
  %22 = load i8 addrspace(3)* %arrayidx11.i, align 1, !tbaa !3
  %conv12.i = zext i8 %22 to i32
  %cmp13.i = icmp eq i32 %add.conv.i, %conv12.i
  %inc.i = add i32 %l.025.i, 1
  br i1 %cmp13.i, label %for.cond.i, label %if.end121

if.then115:                                       ; preds = %for.cond.i, %if.then105
  %call116 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, i32 1) #3
  %add117 = add i32 %17, %mul
  %add118 = add i32 %call116, %mul
  %23 = sext i32 %add118 to i64
  %arrayidx119 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i64 %23
  store i32 %add117, i32 addrspace(1)* %arrayidx119, align 4, !tbaa !6
  br label %if.end121

if.end121:                                        ; preds = %for.body.i, %if.then115, %if.end102
  tail call void @barrier(i32 1) #3
  %24 = trunc i64 %indvars.iv.next to i32
  %div122 = srem i32 %24, %call1
  %mul123 = sub i32 %24, %div122
  %cmp124 = icmp uge i32 %mul123, %sub10
  %25 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !6
  %cmp127 = icmp eq i32 %25, 0
  %or.cond139 = and i1 %cmp124, %cmp127
  br i1 %or.cond139, label %while.end, label %while.body

while.end:                                        ; preds = %if.end121
  br i1 %cmp, label %if.then136, label %if.end138

if.then136:                                       ; preds = %while.end
  %26 = load i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4, !tbaa !6
  %27 = sext i32 %call2 to i64
  %arrayidx137 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i64 %27
  store i32 %26, i32 addrspace(1)* %arrayidx137, align 4, !tbaa !6
  br label %if.end138

if.end138:                                        ; preds = %if.end, %if.then136, %while.end
  ret void
}

declare i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)*, i32) #2

attributes #0 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*)* @StringSearchNaive}
!1 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*, i32 addrspace(3)*)* @StringSearchLoadBalance}
!2 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}

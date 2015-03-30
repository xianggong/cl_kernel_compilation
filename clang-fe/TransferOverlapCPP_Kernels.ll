; ModuleID = '../kernel-src/TransferOverlapCPP_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@readKernel.lcount = internal addrspace(3) global i32 0, align 4
@writeKernel.lval = internal addrspace(3) unnamed_addr global i32 0, align 4

; Function Attrs: nounwind
define void @readKernel(<4 x i32> addrspace(1)* nocapture readonly %in, i32 addrspace(1)* nocapture %out, i32 %ni, i32 %val, i32 %nk) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %cmp = icmp eq i32 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32 addrspace(3)* @readKernel.lcount, align 4, !tbaa !3
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @barrier(i32 1) #2
  %cmp166 = icmp eq i32 %nk, 0
  br i1 %cmp166, label %for.end28, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %if.end
  %cmp462 = icmp eq i32 %ni, 0
  br label %for.body

for.body:                                         ; preds = %for.inc26, %for.body.lr.ph
  %n.068 = phi i32 [ 0, %for.body.lr.ph ], [ %inc27, %for.inc26 ]
  %pcount.067 = phi i32 [ 0, %for.body.lr.ph ], [ %pcount.1.lcssa, %for.inc26 ]
  %call2 = tail call i32 @get_global_id(i32 0) #2
  br i1 %cmp462, label %for.inc26, label %for.body5

for.body5:                                        ; preds = %for.body, %for.body5
  %idx.065 = phi i32 [ %add, %for.body5 ], [ %call2, %for.body ]
  %i.064 = phi i32 [ %inc24, %for.body5 ], [ 0, %for.body ]
  %pcount.163 = phi i32 [ %pcount.5, %for.body5 ], [ %pcount.067, %for.body ]
  %0 = sext i32 %idx.065 to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %in, i64 %0
  %1 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %2 = extractelement <4 x i32> %1, i32 0
  %cmp6 = icmp eq i32 %2, %val
  %inc = zext i1 %cmp6 to i32
  %inc.pcount.1 = add i32 %inc, %pcount.163
  %3 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %4 = extractelement <4 x i32> %3, i32 1
  %cmp10 = icmp eq i32 %4, %val
  %inc12 = zext i1 %cmp10 to i32
  %pcount.3 = add i32 %inc.pcount.1, %inc12
  %5 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %6 = extractelement <4 x i32> %5, i32 2
  %cmp15 = icmp eq i32 %6, %val
  %inc17 = zext i1 %cmp15 to i32
  %inc17.pcount.3 = add i32 %pcount.3, %inc17
  %7 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %8 = extractelement <4 x i32> %7, i32 3
  %cmp20 = icmp eq i32 %8, %val
  %inc22 = zext i1 %cmp20 to i32
  %pcount.5 = add i32 %inc17.pcount.3, %inc22
  %inc24 = add i32 %i.064, 1
  %call25 = tail call i32 @get_global_size(i32 0) #2
  %add = add i32 %call25, %idx.065
  %exitcond = icmp eq i32 %inc24, %ni
  br i1 %exitcond, label %for.inc26, label %for.body5

for.inc26:                                        ; preds = %for.body5, %for.body
  %pcount.1.lcssa = phi i32 [ %pcount.067, %for.body ], [ %pcount.5, %for.body5 ]
  %inc27 = add nsw i32 %n.068, 1
  %exitcond70 = icmp eq i32 %inc27, %nk
  br i1 %exitcond70, label %for.end28, label %for.body

for.end28:                                        ; preds = %for.inc26, %if.end
  %pcount.0.lcssa = phi i32 [ 0, %if.end ], [ %pcount.1.lcssa, %for.inc26 ]
  %call29 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @readKernel.lcount, i32 %pcount.0.lcssa) #2
  tail call void @barrier(i32 1) #2
  %call30 = tail call i32 @get_local_id(i32 0) #2
  %cmp31 = icmp eq i32 %call30, 0
  br i1 %cmp31, label %if.then32, label %if.end35

if.then32:                                        ; preds = %for.end28
  %9 = load i32 addrspace(3)* @readKernel.lcount, align 4, !tbaa !3
  %div = udiv i32 %9, %nk
  %call33 = tail call i32 @get_group_id(i32 0) #2
  %10 = sext i32 %call33 to i64
  %arrayidx34 = getelementptr inbounds i32 addrspace(1)* %out, i64 %10
  store volatile i32 %div, i32 addrspace(1)* %arrayidx34, align 4, !tbaa !3
  br label %if.end35

if.end35:                                         ; preds = %if.then32, %for.end28
  %call36 = tail call i32 @get_global_id(i32 0) #2
  %cmp37 = icmp eq i32 %call36, 0
  br i1 %cmp37, label %if.then38, label %if.end42

if.then38:                                        ; preds = %if.end35
  %call39 = tail call i32 @get_num_groups(i32 0) #2
  %add40 = add i32 %call39, 1
  %11 = sext i32 %add40 to i64
  %arrayidx41 = getelementptr inbounds i32 addrspace(1)* %out, i64 %11
  store volatile i32 %val, i32 addrspace(1)* %arrayidx41, align 4, !tbaa !3
  br label %if.end42

if.end42:                                         ; preds = %if.then38, %if.end35
  ret void
}

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_num_groups(i32) #1

; Function Attrs: nounwind
define void @writeKernel(i32 addrspace(1)* nocapture readonly %in, <4 x i32> addrspace(1)* nocapture %out, i32 %ni, i32 %val, i32 %nk) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %cmp = icmp eq i32 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call1 = tail call i32 @get_num_groups(i32 0) #2
  %add = add i32 %call1, 1
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %in, i64 %0
  %1 = load volatile i32 addrspace(1)* %arrayidx, align 4, !tbaa !3
  store i32 %1, i32 addrspace(3)* @writeKernel.lval, align 4, !tbaa !3
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @barrier(i32 1) #2
  %2 = load i32 addrspace(3)* @writeKernel.lval, align 4, !tbaa !3
  %vecinit = insertelement <4 x i32> undef, i32 %2, i32 0
  %vecinit2 = insertelement <4 x i32> %vecinit, i32 %2, i32 1
  %vecinit3 = insertelement <4 x i32> %vecinit2, i32 %2, i32 2
  %vecinit4 = insertelement <4 x i32> %vecinit3, i32 %2, i32 3
  %cmp522 = icmp eq i32 %nk, 0
  br i1 %cmp522, label %for.end15, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %if.end
  %cmp819 = icmp eq i32 %ni, 0
  br label %for.body

for.body:                                         ; preds = %for.inc13, %for.body.lr.ph
  %n.023 = phi i32 [ 0, %for.body.lr.ph ], [ %inc14, %for.inc13 ]
  %call6 = tail call i32 @get_global_id(i32 0) #2
  br i1 %cmp819, label %for.inc13, label %for.body9

for.body9:                                        ; preds = %for.body, %for.body9
  %i.021 = phi i32 [ %inc, %for.body9 ], [ 0, %for.body ]
  %idx.020 = phi i32 [ %add12, %for.body9 ], [ %call6, %for.body ]
  %3 = sext i32 %idx.020 to i64
  %arrayidx10 = getelementptr inbounds <4 x i32> addrspace(1)* %out, i64 %3
  store volatile <4 x i32> %vecinit4, <4 x i32> addrspace(1)* %arrayidx10, align 16, !tbaa !7
  %inc = add i32 %i.021, 1
  %call11 = tail call i32 @get_global_size(i32 0) #2
  %add12 = add i32 %call11, %idx.020
  %exitcond = icmp eq i32 %inc, %ni
  br i1 %exitcond, label %for.inc13, label %for.body9

for.inc13:                                        ; preds = %for.body9, %for.body
  %inc14 = add nsw i32 %n.023, 1
  %exitcond24 = icmp eq i32 %inc14, %nk
  br i1 %exitcond24, label %for.end15, label %for.body

for.end15:                                        ; preds = %for.inc13, %if.end
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @readKernel}
!1 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @writeKernel}
!2 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"int", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !5, metadata !5, i64 0}

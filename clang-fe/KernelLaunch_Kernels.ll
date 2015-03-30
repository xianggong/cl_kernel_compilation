; ModuleID = '../kernel-src/KernelLaunch_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@read_kernel.lcount = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define void @read_kernel(<4 x i32> addrspace(1)* nocapture readonly %in, i32 addrspace(1)* nocapture %out, i32 %ni, i32 %val, i32 %nk) #0 {
entry:
  %cmp = icmp eq i32 %nk, 0
  br i1 %cmp, label %if.end38, label %if.end

if.end:                                           ; preds = %entry
  %call = tail call i32 @get_local_id(i32 0) #2
  %cmp1 = icmp eq i32 %call, 0
  br i1 %cmp1, label %if.then2, label %for.body.lr.ph

if.then2:                                         ; preds = %if.end
  store i32 0, i32 addrspace(3)* @read_kernel.lcount, align 4, !tbaa !3
  br label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %if.end, %if.then2
  tail call void @barrier(i32 1) #2
  %cmp757 = icmp eq i32 %ni, 0
  br label %for.body

for.body:                                         ; preds = %for.inc29, %for.body.lr.ph
  %n.063 = phi i32 [ 0, %for.body.lr.ph ], [ %inc30, %for.inc29 ]
  %pcount.062 = phi i32 [ 0, %for.body.lr.ph ], [ %pcount.1.lcssa, %for.inc29 ]
  %call5 = tail call i32 @get_global_id(i32 0) #2
  br i1 %cmp757, label %for.inc29, label %for.body8

for.body8:                                        ; preds = %for.body, %for.body8
  %idx.060 = phi i32 [ %add, %for.body8 ], [ %call5, %for.body ]
  %i.059 = phi i32 [ %inc27, %for.body8 ], [ 0, %for.body ]
  %pcount.158 = phi i32 [ %pcount.5, %for.body8 ], [ %pcount.062, %for.body ]
  %0 = sext i32 %idx.060 to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %in, i64 %0
  %1 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %2 = extractelement <4 x i32> %1, i32 0
  %cmp9 = icmp eq i32 %2, %val
  %inc = zext i1 %cmp9 to i32
  %inc.pcount.1 = add i32 %inc, %pcount.158
  %3 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %4 = extractelement <4 x i32> %3, i32 1
  %cmp13 = icmp eq i32 %4, %val
  %inc15 = zext i1 %cmp13 to i32
  %pcount.3 = add i32 %inc.pcount.1, %inc15
  %5 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %6 = extractelement <4 x i32> %5, i32 2
  %cmp18 = icmp eq i32 %6, %val
  %inc20 = zext i1 %cmp18 to i32
  %inc20.pcount.3 = add i32 %pcount.3, %inc20
  %7 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %8 = extractelement <4 x i32> %7, i32 3
  %cmp23 = icmp eq i32 %8, %val
  %inc25 = zext i1 %cmp23 to i32
  %pcount.5 = add i32 %inc20.pcount.3, %inc25
  %inc27 = add i32 %i.059, 1
  %call28 = tail call i32 @get_global_size(i32 0) #2
  %add = add i32 %call28, %idx.060
  %exitcond = icmp eq i32 %inc27, %ni
  br i1 %exitcond, label %for.inc29, label %for.body8

for.inc29:                                        ; preds = %for.body8, %for.body
  %pcount.1.lcssa = phi i32 [ %pcount.062, %for.body ], [ %pcount.5, %for.body8 ]
  %inc30 = add nsw i32 %n.063, 1
  %exitcond65 = icmp eq i32 %inc30, %nk
  br i1 %exitcond65, label %for.end31, label %for.body

for.end31:                                        ; preds = %for.inc29
  %call32 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @read_kernel.lcount, i32 %pcount.1.lcssa) #2
  tail call void @barrier(i32 1) #2
  %call33 = tail call i32 @get_local_id(i32 0) #2
  %cmp34 = icmp eq i32 %call33, 0
  br i1 %cmp34, label %if.then35, label %if.end38

if.then35:                                        ; preds = %for.end31
  %9 = load i32 addrspace(3)* @read_kernel.lcount, align 4, !tbaa !3
  %div = udiv i32 %9, %nk
  %call36 = tail call i32 @get_group_id(i32 0) #2
  %10 = sext i32 %call36 to i64
  %arrayidx37 = getelementptr inbounds i32 addrspace(1)* %out, i64 %10
  store volatile i32 %div, i32 addrspace(1)* %arrayidx37, align 4, !tbaa !3
  br label %if.end38

if.end38:                                         ; preds = %entry, %if.then35, %for.end31
  ret void
}

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

declare i32 @get_group_id(i32) #1

; Function Attrs: nounwind
define void @write_kernel(i32 addrspace(1)* nocapture readnone %in, <4 x i32> addrspace(1)* nocapture %out, i32 %ni, i32 %val, i32 %nk) #0 {
entry:
  %cmp = icmp eq i32 %nk, 0
  br i1 %cmp, label %for.end11, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %vecinit = insertelement <4 x i32> undef, i32 %val, i32 0
  %vecinit1 = insertelement <4 x i32> %vecinit, i32 %val, i32 1
  %vecinit2 = insertelement <4 x i32> %vecinit1, i32 %val, i32 2
  %vecinit3 = insertelement <4 x i32> %vecinit2, i32 %val, i32 3
  %cmp619 = icmp eq i32 %ni, 0
  br label %for.body

for.body:                                         ; preds = %for.inc9, %for.body.lr.ph
  %n.023 = phi i32 [ 0, %for.body.lr.ph ], [ %inc10, %for.inc9 ]
  %call = tail call i32 @get_global_id(i32 0) #2
  br i1 %cmp619, label %for.inc9, label %for.body7

for.body7:                                        ; preds = %for.body, %for.body7
  %i.021 = phi i32 [ %inc, %for.body7 ], [ 0, %for.body ]
  %idx.020 = phi i32 [ %add, %for.body7 ], [ %call, %for.body ]
  %0 = sext i32 %idx.020 to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %out, i64 %0
  store volatile <4 x i32> %vecinit3, <4 x i32> addrspace(1)* %arrayidx, align 16, !tbaa !7
  %inc = add i32 %i.021, 1
  %call8 = tail call i32 @get_global_size(i32 0) #2
  %add = add i32 %call8, %idx.020
  %exitcond = icmp eq i32 %inc, %ni
  br i1 %exitcond, label %for.inc9, label %for.body7

for.inc9:                                         ; preds = %for.body7, %for.body
  %inc10 = add nsw i32 %n.023, 1
  %exitcond24 = icmp eq i32 %inc10, %nk
  br i1 %exitcond24, label %for.end11, label %for.body

for.end11:                                        ; preds = %for.inc9, %entry
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @read_kernel}
!1 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @write_kernel}
!2 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"int", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !5, metadata !5, i64 0}

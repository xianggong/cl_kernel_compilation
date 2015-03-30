; ModuleID = '../kernel-src/Histogram_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram256_vector(<4 x i32> addrspace(1)* nocapture readonly %data, i8 addrspace(3)* nocapture %sharedArray, i32 addrspace(1)* nocapture %binResult) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 0) #2
  %call2 = tail call i32 @get_group_id(i32 0) #2
  %call3 = tail call i32 @get_local_size(i32 0) #2
  %and = shl i32 %call, 2
  %mul = and i32 %and, 124
  %0 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.0112 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %mul4 = mul i32 %i.0112, %call3
  %add = add i32 %mul4, %call
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(3)* %0, i32 %add
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %arrayidx, align 4, !tbaa !3
  %inc = add nsw i32 %i.0112, 1
  %exitcond116 = icmp eq i32 %inc, 64
  br i1 %exitcond116, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  %shr = lshr i32 %call, 5
  tail call void @barrier(i32 1) #2
  %1 = shl i32 %call3, 5
  %div = and i32 %1, 536870880
  %mul10 = mul i32 %div, %call2
  %add12 = add i32 %mul10, %call
  br label %for.body8

for.body8:                                        ; preds = %for.body8, %for.end
  %indvars.iv113 = phi i64 [ 0, %for.end ], [ %indvars.iv.next114, %for.body8 ]
  %2 = trunc i64 %indvars.iv113 to i32
  %mul11 = mul i32 %2, %call3
  %add13 = add i32 %add12, %mul11
  %3 = sext i32 %add13 to i64
  %arrayidx14 = getelementptr inbounds <4 x i32> addrspace(1)* %data, i64 %3
  %4 = load <4 x i32> addrspace(1)* %arrayidx14, align 16, !tbaa !3
  %5 = extractelement <4 x i32> %4, i32 0
  %mul15 = shl i32 %5, 7
  %add16 = or i32 %mul15, %mul
  %add17 = add i32 %add16, %shr
  %arrayidx18 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %add17
  %6 = load i8 addrspace(3)* %arrayidx18, align 1, !tbaa !3
  %inc19 = add i8 %6, 1
  store i8 %inc19, i8 addrspace(3)* %arrayidx18, align 1, !tbaa !3
  %7 = extractelement <4 x i32> %4, i32 1
  %mul20 = shl i32 %7, 7
  %add21 = or i32 %mul20, %mul
  %add22 = add i32 %add21, %shr
  %arrayidx23 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %add22
  %8 = load i8 addrspace(3)* %arrayidx23, align 1, !tbaa !3
  %inc24 = add i8 %8, 1
  store i8 %inc24, i8 addrspace(3)* %arrayidx23, align 1, !tbaa !3
  %9 = extractelement <4 x i32> %4, i32 2
  %mul25 = shl i32 %9, 7
  %add26 = or i32 %mul25, %mul
  %add27 = add i32 %add26, %shr
  %arrayidx28 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %add27
  %10 = load i8 addrspace(3)* %arrayidx28, align 1, !tbaa !3
  %inc29 = add i8 %10, 1
  store i8 %inc29, i8 addrspace(3)* %arrayidx28, align 1, !tbaa !3
  %11 = extractelement <4 x i32> %4, i32 3
  %mul30 = shl i32 %11, 7
  %add31 = or i32 %mul30, %mul
  %add32 = add i32 %add31, %shr
  %arrayidx33 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %add32
  %12 = load i8 addrspace(3)* %arrayidx33, align 1, !tbaa !3
  %inc34 = add i8 %12, 1
  store i8 %inc34, i8 addrspace(3)* %arrayidx33, align 1, !tbaa !3
  %indvars.iv.next114 = add nuw nsw i64 %indvars.iv113, 1
  %exitcond115 = icmp eq i64 %indvars.iv.next114, 32
  br i1 %exitcond115, label %for.end37, label %for.body8

for.end37:                                        ; preds = %for.body8
  tail call void @barrier(i32 1) #2
  %div40 = udiv i32 256, %call3
  %cmp41109 = icmp eq i32 %div40, 0
  br i1 %cmp41109, label %for.end68, label %for.body42.lr.ph

for.body42.lr.ph:                                 ; preds = %for.end37
  %mul44 = shl i32 %call, 5
  %mul61 = shl i32 %call2, 8
  %add63 = add i32 %mul61, %call
  br label %for.body42

for.body42:                                       ; preds = %for.body42.lr.ph, %for.end57
  %indvars.iv = phi i64 [ 0, %for.body42.lr.ph ], [ %indvars.iv.next, %for.end57 ]
  %13 = trunc i64 %indvars.iv to i32
  %mul43 = shl i32 %13, 12
  %add45 = add i32 %mul43, %mul44
  br label %for.body48

for.body48:                                       ; preds = %for.body48, %for.body42
  %j.0108 = phi i32 [ 0, %for.body42 ], [ %inc56, %for.body48 ]
  %binCount.0107 = phi <4 x i32> [ zeroinitializer, %for.body42 ], [ %add54, %for.body48 ]
  %add49 = add nsw i32 %j.0108, %call
  %and50 = and i32 %add49, 31
  %add51 = or i32 %and50, %add45
  %arrayidx52 = getelementptr inbounds <4 x i8> addrspace(3)* %0, i32 %add51
  %14 = load <4 x i8> addrspace(3)* %arrayidx52, align 4, !tbaa !3
  %call53 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %14) #2
  %add54 = add <4 x i32> %binCount.0107, %call53
  %inc56 = add nsw i32 %j.0108, 1
  %exitcond = icmp eq i32 %inc56, 32
  br i1 %exitcond, label %for.end57, label %for.body48

for.end57:                                        ; preds = %for.body48
  %15 = extractelement <4 x i32> %add54, i32 0
  %16 = extractelement <4 x i32> %add54, i32 1
  %add58 = add i32 %15, %16
  %17 = extractelement <4 x i32> %add54, i32 2
  %add59 = add i32 %add58, %17
  %18 = extractelement <4 x i32> %add54, i32 3
  %add60 = add i32 %add59, %18
  %mul62 = mul i32 %13, %call3
  %add64 = add i32 %add63, %mul62
  %19 = sext i32 %add64 to i64
  %arrayidx65 = getelementptr inbounds i32 addrspace(1)* %binResult, i64 %19
  store i32 %add60, i32 addrspace(1)* %arrayidx65, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %20 = trunc i64 %indvars.iv.next to i32
  %cmp41 = icmp ult i32 %20, %div40
  br i1 %cmp41, label %for.body42, label %for.end68

for.end68:                                        ; preds = %for.end57, %for.end37
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @histogram256_scalar(i32 addrspace(1)* nocapture readonly %data, i8 addrspace(3)* nocapture %sharedArray, i32 addrspace(1)* nocapture %binResult) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 0) #2
  %call2 = tail call i32 @get_group_id(i32 0) #2
  %call3 = tail call i32 @get_local_size(i32 0) #2
  %and = shl i32 %call, 2
  %mul = and i32 %and, 124
  %0 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.085 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %mul4 = mul i32 %i.085, %call3
  %add = add i32 %mul4, %call
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(3)* %0, i32 %add
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %arrayidx, align 4, !tbaa !3
  %inc = add nsw i32 %i.085, 1
  %exitcond89 = icmp eq i32 %inc, 64
  br i1 %exitcond89, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  %shr = lshr i32 %call, 5
  tail call void @barrier(i32 1) #2
  %mul10 = shl i32 %call2, 7
  br label %for.body8

for.body8:                                        ; preds = %for.body8, %for.end
  %indvars.iv86 = phi i64 [ 0, %for.end ], [ %indvars.iv.next87, %for.body8 ]
  %1 = trunc i64 %indvars.iv86 to i32
  %tmp = add i32 %1, %mul10
  %tmp79 = mul i32 %tmp, %call3
  %add13 = add i32 %tmp79, %call
  %2 = sext i32 %add13 to i64
  %arrayidx14 = getelementptr inbounds i32 addrspace(1)* %data, i64 %2
  %3 = load i32 addrspace(1)* %arrayidx14, align 4, !tbaa !6
  %mul15 = shl i32 %3, 7
  %add16 = or i32 %mul15, %mul
  %add17 = add i32 %add16, %shr
  %arrayidx18 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %add17
  %4 = load i8 addrspace(3)* %arrayidx18, align 1, !tbaa !3
  %inc19 = add i8 %4, 1
  store i8 %inc19, i8 addrspace(3)* %arrayidx18, align 1, !tbaa !3
  %indvars.iv.next87 = add nuw nsw i64 %indvars.iv86, 1
  %exitcond88 = icmp eq i64 %indvars.iv.next87, 128
  br i1 %exitcond88, label %for.end22, label %for.body8

for.end22:                                        ; preds = %for.body8
  tail call void @barrier(i32 1) #2
  %div = udiv i32 256, %call3
  %cmp2582 = icmp eq i32 %div, 0
  br i1 %cmp2582, label %for.end52, label %for.body26.lr.ph

for.body26.lr.ph:                                 ; preds = %for.end22
  %mul28 = shl i32 %call, 5
  %mul45 = shl i32 %call2, 8
  %add47 = add i32 %mul45, %call
  br label %for.body26

for.body26:                                       ; preds = %for.body26.lr.ph, %for.end41
  %indvars.iv = phi i64 [ 0, %for.body26.lr.ph ], [ %indvars.iv.next, %for.end41 ]
  %5 = trunc i64 %indvars.iv to i32
  %mul27 = shl i32 %5, 12
  %add29 = add i32 %mul27, %mul28
  br label %for.body32

for.body32:                                       ; preds = %for.body32, %for.body26
  %j.081 = phi i32 [ 0, %for.body26 ], [ %inc40, %for.body32 ]
  %binCount.080 = phi <4 x i32> [ zeroinitializer, %for.body26 ], [ %add38, %for.body32 ]
  %add33 = add nsw i32 %j.081, %call
  %and34 = and i32 %add33, 31
  %add35 = or i32 %and34, %add29
  %arrayidx36 = getelementptr inbounds <4 x i8> addrspace(3)* %0, i32 %add35
  %6 = load <4 x i8> addrspace(3)* %arrayidx36, align 4, !tbaa !3
  %call37 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %6) #2
  %add38 = add <4 x i32> %binCount.080, %call37
  %inc40 = add nsw i32 %j.081, 1
  %exitcond = icmp eq i32 %inc40, 32
  br i1 %exitcond, label %for.end41, label %for.body32

for.end41:                                        ; preds = %for.body32
  %7 = extractelement <4 x i32> %add38, i32 0
  %8 = extractelement <4 x i32> %add38, i32 1
  %add42 = add i32 %7, %8
  %9 = extractelement <4 x i32> %add38, i32 2
  %add43 = add i32 %add42, %9
  %10 = extractelement <4 x i32> %add38, i32 3
  %add44 = add i32 %add43, %10
  %mul46 = mul i32 %5, %call3
  %add48 = add i32 %add47, %mul46
  %11 = sext i32 %add48 to i64
  %arrayidx49 = getelementptr inbounds i32 addrspace(1)* %binResult, i64 %11
  store i32 %add44, i32 addrspace(1)* %arrayidx49, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %12 = trunc i64 %indvars.iv.next to i32
  %cmp25 = icmp ult i32 %12, %div
  br i1 %cmp25, label %for.body26, label %for.end52

for.end52:                                        ; preds = %for.end41, %for.end22
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_vector}
!1 = metadata !{void (i32 addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_scalar}
!2 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}

; ModuleID = '../kernel-src/RadixSort_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram(i32 addrspace(1)* nocapture readonly %unsortedData, i32 addrspace(1)* nocapture %buckets, i32 %shiftCount, i32 addrspace(3)* %sharedArray) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 0) #2
  %call2 = tail call i32 @get_group_id(i32 0) #2
  %call3 = tail call i32 @get_local_size(i32 0) #2
  %call4 = tail call i32 @get_global_size(i32 0) #2
  %call5 = tail call i32 @get_local_size(i32 0) #2
  %arrayidx = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %call
  store i32 0, i32 addrspace(3)* %arrayidx, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %0 = sext i32 %call1 to i64
  %arrayidx6 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx6, align 4, !tbaa !8
  %shr.mask = and i32 %shiftCount, 31
  %shr = lshr i32 %1, %shr.mask
  %and = and i32 %shr, 255
  %add.ptr = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %and
  %call7 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* %add.ptr, i32 1) #2
  tail call void @barrier(i32 1) #2
  %mul = mul i32 %call3, %call2
  %add = add i32 %mul, %call
  %2 = load i32 addrspace(3)* %arrayidx, align 4, !tbaa !8
  %3 = sext i32 %add to i64
  %arrayidx9 = getelementptr inbounds i32 addrspace(1)* %buckets, i64 %3
  store i32 %2, i32 addrspace(1)* %arrayidx9, align 4, !tbaa !8
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare i32 @get_global_size(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

; Function Attrs: nounwind
define void @permute(i32 addrspace(1)* nocapture readonly %unsortedData, i32 addrspace(1)* nocapture readonly %scanedBuckets, i32 %shiftCount, i16 addrspace(3)* nocapture %sharedBuckets, i32 addrspace(1)* nocapture %sortedData) #0 {
entry:
  %call = tail call i32 @get_group_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 0) #2
  %call2 = tail call i32 @get_global_id(i32 0) #2
  %call3 = tail call i32 @get_local_size(i32 0) #2
  %mul = shl i32 %call, 8
  %mul4 = mul i32 %mul, %call3
  %mul5 = shl i32 %call1, 8
  %add = add i32 %mul4, %mul5
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv52 = phi i64 [ 0, %entry ], [ %indvars.iv.next53, %for.body ]
  %0 = trunc i64 %indvars.iv52 to i32
  %add6 = add i32 %add, %0
  %1 = sext i32 %add6 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i64 %1
  %2 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !8
  %conv = trunc i32 %2 to i16
  %add8 = add i32 %0, %mul5
  %arrayidx9 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %add8
  store i16 %conv, i16 addrspace(3)* %arrayidx9, align 2, !tbaa !12
  %indvars.iv.next53 = add nuw nsw i64 %indvars.iv52, 1
  %exitcond54 = icmp eq i64 %indvars.iv.next53, 256
  br i1 %exitcond54, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  tail call void @barrier(i32 1) #2
  %mul15 = shl i32 %call2, 8
  %shr.mask = and i32 %shiftCount, 31
  br label %for.body14

for.body14:                                       ; preds = %for.body14, %for.end
  %indvars.iv = phi i64 [ 0, %for.end ], [ %indvars.iv.next, %for.body14 ]
  %3 = trunc i64 %indvars.iv to i32
  %add16 = add i32 %3, %mul15
  %4 = sext i32 %add16 to i64
  %arrayidx17 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i64 %4
  %5 = load i32 addrspace(1)* %arrayidx17, align 4, !tbaa !8
  %shr = lshr i32 %5, %shr.mask
  %and = and i32 %shr, 255
  %add19 = or i32 %and, %mul5
  %arrayidx20 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %add19
  %6 = load i16 addrspace(3)* %arrayidx20, align 2, !tbaa !12
  %conv21 = zext i16 %6 to i32
  %7 = zext i16 %6 to i64
  %arrayidx25 = getelementptr inbounds i32 addrspace(1)* %sortedData, i64 %7
  store i32 %5, i32 addrspace(1)* %arrayidx25, align 4, !tbaa !8
  %add26 = add i32 %conv21, 1
  %conv27 = trunc i32 %add26 to i16
  store i16 %conv27, i16 addrspace(3)* %arrayidx20, align 2, !tbaa !12
  tail call void @barrier(i32 1) #2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 256
  br i1 %exitcond, label %for.end33, label %for.body14

for.end33:                                        ; preds = %for.body14
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim2(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(3)* nocapture %block, i32 %block_size, i32 %stride, i32 addrspace(1)* nocapture %sumBuffer) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 1) #2
  %call2 = tail call i32 @get_global_id(i32 0) #2
  %call3 = tail call i32 @get_global_id(i32 1) #2
  %call4 = tail call i32 @get_group_id(i32 0) #2
  %call5 = tail call i32 @get_group_id(i32 1) #2
  %shl = shl i32 %call2, 8
  %add6 = add nsw i32 %shl, %call3
  %call7 = tail call i32 @get_global_size(i32 0) #2
  %div = udiv i32 %call7, %block_size
  %mul8 = mul i32 %div, %call5
  %add9 = add i32 %mul8, %call4
  %0 = sext i32 %add6 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !8
  %arrayidx10 = getelementptr inbounds i32 addrspace(3)* %block, i32 %call
  store i32 %1, i32 addrspace(3)* %arrayidx10, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %cmp50 = icmp ugt i32 %block_size, 1
  br i1 %cmp50, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %2 = load i32 addrspace(3)* %block, align 4, !tbaa !8
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %if.end
  %dis.052 = phi i32 [ 1, %for.body.lr.ph ], [ %mul17, %if.end ]
  %cache.051 = phi i32 [ %2, %for.body.lr.ph ], [ %cache.1, %if.end ]
  %cmp12 = icmp slt i32 %call, %dis.052
  br i1 %cmp12, label %if.end, label %if.then

if.then:                                          ; preds = %for.body
  %sub = sub nsw i32 %call, %dis.052
  %arrayidx13 = getelementptr inbounds i32 addrspace(3)* %block, i32 %sub
  %3 = load i32 addrspace(3)* %arrayidx13, align 4, !tbaa !8
  %4 = load i32 addrspace(3)* %arrayidx10, align 4, !tbaa !8
  %add15 = add i32 %4, %3
  br label %if.end

if.end:                                           ; preds = %for.body, %if.then
  %cache.1 = phi i32 [ %add15, %if.then ], [ %cache.051, %for.body ]
  tail call void @barrier(i32 1) #2
  store i32 %cache.1, i32 addrspace(3)* %arrayidx10, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %mul17 = shl nsw i32 %dis.052, 1
  %cmp = icmp ult i32 %mul17, %block_size
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %if.end, %entry
  %sub18 = add i32 %block_size, -1
  %arrayidx19 = getelementptr inbounds i32 addrspace(3)* %block, i32 %sub18
  %5 = load i32 addrspace(3)* %arrayidx19, align 4, !tbaa !8
  %6 = sext i32 %add9 to i64
  %arrayidx20 = getelementptr inbounds i32 addrspace(1)* %sumBuffer, i64 %6
  store i32 %5, i32 addrspace(1)* %arrayidx20, align 4, !tbaa !8
  %cmp21 = icmp eq i32 %call, 0
  br i1 %cmp21, label %if.then22, label %if.else

if.then22:                                        ; preds = %for.end
  %arrayidx23 = getelementptr inbounds i32 addrspace(1)* %output, i64 %0
  store i32 0, i32 addrspace(1)* %arrayidx23, align 4, !tbaa !8
  br label %if.end27

if.else:                                          ; preds = %for.end
  %sub24 = add nsw i32 %call, -1
  %arrayidx25 = getelementptr inbounds i32 addrspace(3)* %block, i32 %sub24
  %7 = load i32 addrspace(3)* %arrayidx25, align 4, !tbaa !8
  %arrayidx26 = getelementptr inbounds i32 addrspace(1)* %output, i64 %0
  store i32 %7, i32 addrspace(1)* %arrayidx26, align 4, !tbaa !8
  br label %if.end27

if.end27:                                         ; preds = %if.else, %if.then22
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim1(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(3)* nocapture %block, i32 %block_size) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 0) #2
  %call2 = tail call i32 @get_group_id(i32 0) #2
  %0 = sext i32 %call1 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !8
  %arrayidx3 = getelementptr inbounds i32 addrspace(3)* %block, i32 %call
  store i32 %1, i32 addrspace(3)* %arrayidx3, align 4, !tbaa !8
  %cmp32 = icmp ugt i32 %block_size, 1
  br i1 %cmp32, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %2 = load i32 addrspace(3)* %block, align 4, !tbaa !8
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %if.end
  %stride.034 = phi i32 [ 1, %for.body.lr.ph ], [ %mul, %if.end ]
  %cache.033 = phi i32 [ %2, %for.body.lr.ph ], [ %cache.1, %if.end ]
  %cmp5 = icmp slt i32 %call, %stride.034
  br i1 %cmp5, label %if.end, label %if.then

if.then:                                          ; preds = %for.body
  %sub = sub nsw i32 %call, %stride.034
  %arrayidx6 = getelementptr inbounds i32 addrspace(3)* %block, i32 %sub
  %3 = load i32 addrspace(3)* %arrayidx6, align 4, !tbaa !8
  %4 = load i32 addrspace(3)* %arrayidx3, align 4, !tbaa !8
  %add = add i32 %4, %3
  br label %if.end

if.end:                                           ; preds = %for.body, %if.then
  %cache.1 = phi i32 [ %add, %if.then ], [ %cache.033, %for.body ]
  tail call void @barrier(i32 1) #2
  store i32 %cache.1, i32 addrspace(3)* %arrayidx3, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %mul = shl nsw i32 %stride.034, 1
  %cmp = icmp ult i32 %mul, %block_size
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %if.end, %entry
  %cmp9 = icmp eq i32 %call, 0
  br i1 %cmp9, label %if.then10, label %if.else

if.then10:                                        ; preds = %for.end
  %arrayidx11 = getelementptr inbounds i32 addrspace(1)* %output, i64 %0
  store i32 0, i32 addrspace(1)* %arrayidx11, align 4, !tbaa !8
  br label %if.end15

if.else:                                          ; preds = %for.end
  %sub12 = add nsw i32 %call, -1
  %arrayidx13 = getelementptr inbounds i32 addrspace(3)* %block, i32 %sub12
  %5 = load i32 addrspace(3)* %arrayidx13, align 4, !tbaa !8
  %arrayidx14 = getelementptr inbounds i32 addrspace(1)* %output, i64 %0
  store i32 %5, i32 addrspace(1)* %arrayidx14, align 4, !tbaa !8
  br label %if.end15

if.end15:                                         ; preds = %if.else, %if.then10
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %summary, i32 %stride) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 1) #2
  %mul = mul nsw i32 %call1, %stride
  %add = add nsw i32 %mul, %call
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %output, i64 %0
  store i32 0, i32 addrspace(1)* %arrayidx, align 4, !tbaa !8
  %cmp = icmp sgt i32 %call, 0
  br i1 %cmp, label %for.body.lr.ph, label %if.end

for.body.lr.ph:                                   ; preds = %entry
  %1 = sext i32 %mul to i64
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %2 = phi i32 [ 0, %for.body.lr.ph ], [ %add7, %for.body ]
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %3 = add nsw i64 %indvars.iv, %1
  %arrayidx5 = getelementptr inbounds i32 addrspace(1)* %input, i64 %3
  %4 = load i32 addrspace(1)* %arrayidx5, align 4, !tbaa !8
  %add7 = add i32 %2, %4
  store i32 %add7, i32 addrspace(1)* %arrayidx, align 4, !tbaa !8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %call
  br i1 %exitcond, label %if.end, label %for.body

if.end:                                           ; preds = %for.body, %entry
  %5 = phi i32 [ 0, %entry ], [ %add7, %for.body ]
  %sub = add nsw i32 %stride, -1
  %cmp8 = icmp eq i32 %call, %sub
  br i1 %cmp8, label %if.then9, label %if.end17

if.then9:                                         ; preds = %if.end
  %arrayidx14 = getelementptr inbounds i32 addrspace(1)* %input, i64 %0
  %6 = load i32 addrspace(1)* %arrayidx14, align 4, !tbaa !8
  %add15 = add i32 %6, %5
  %7 = sext i32 %call1 to i64
  %arrayidx16 = getelementptr inbounds i32 addrspace(1)* %summary, i64 %7
  store i32 %add15, i32 addrspace(1)* %arrayidx16, align 4, !tbaa !8
  br label %if.end17

if.end17:                                         ; preds = %if.then9, %if.end
  ret void
}

; Function Attrs: nounwind
define void @blockAddition(i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %output, i32 %stride) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 1) #2
  %call2 = tail call i32 @get_group_id(i32 0) #2
  %call3 = tail call i32 @get_group_id(i32 1) #2
  %shl = shl i32 %call, 8
  %add = add nsw i32 %call1, %shl
  %mul = mul i32 %call3, %stride
  %add4 = add i32 %mul, %call2
  %0 = sext i32 %add4 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !8
  %2 = sext i32 %add to i64
  %arrayidx5 = getelementptr inbounds i32 addrspace(1)* %output, i64 %2
  %3 = load i32 addrspace(1)* %arrayidx5, align 4, !tbaa !8
  %add6 = add i32 %3, %1
  store i32 %add6, i32 addrspace(1)* %arrayidx5, align 4, !tbaa !8
  ret void
}

; Function Attrs: nounwind
define void @FixOffset(i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 1) #2
  %shl = shl i32 %call, 8
  %add = add nsw i32 %call1, %shl
  %0 = sext i32 %call1 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !8
  %2 = sext i32 %add to i64
  %arrayidx2 = getelementptr inbounds i32 addrspace(1)* %output, i64 %2
  %3 = load i32 addrspace(1)* %arrayidx2, align 4, !tbaa !8
  %add3 = add i32 %3, %1
  store i32 %add3, i32 addrspace(1)* %arrayidx2, align 4, !tbaa !8
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(3)*)* @histogram}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i16 addrspace(3)*, i32 addrspace(1)*)* @permute}
!2 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32, i32, i32 addrspace(1)*)* @ScanArraysdim2}
!3 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32)* @ScanArraysdim1}
!4 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*, i32)* @prefixSum}
!5 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @blockAddition}
!6 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @FixOffset}
!7 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"int", metadata !10, i64 0}
!10 = metadata !{metadata !"omnipotent char", metadata !11, i64 0}
!11 = metadata !{metadata !"Simple C/C++ TBAA"}
!12 = metadata !{metadata !13, metadata !13, i64 0}
!13 = metadata !{metadata !"short", metadata !10, i64 0}

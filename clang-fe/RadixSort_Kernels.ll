; ModuleID = '../kernel-src/RadixSort_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram(i32 addrspace(1)* nocapture readonly %unsortedData, i32 addrspace(1)* nocapture %buckets, i32 %shiftCount, i32 addrspace(3)* %sharedArray) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = tail call i32 @get_global_size(i32 0) #2
  %6 = tail call i32 @get_local_size(i32 0) #2
  %7 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %1
  store i32 0, i32 addrspace(3)* %7, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %8 = sext i32 %2 to i64
  %9 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i64 %8
  %10 = load i32 addrspace(1)* %9, align 4, !tbaa !8
  %11 = and i32 %shiftCount, 31
  %12 = lshr i32 %10, %11
  %13 = and i32 %12, 255
  %14 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %13
  %15 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* %14, i32 1) #2
  tail call void @barrier(i32 1) #2
  %16 = mul i32 %4, %3
  %17 = add i32 %16, %1
  %18 = load i32 addrspace(3)* %7, align 4, !tbaa !8
  %19 = sext i32 %17 to i64
  %20 = getelementptr inbounds i32 addrspace(1)* %buckets, i64 %19
  store i32 %18, i32 addrspace(1)* %20, align 4, !tbaa !8
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
  %1 = tail call i32 @get_group_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = tail call i32 @get_global_id(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = shl i32 %1, 8
  %6 = mul i32 %5, %4
  %7 = shl i32 %2, 8
  %8 = add i32 %6, %7
  br label %9

; <label>:9                                       ; preds = %9, %0
  %indvars.iv4 = phi i64 [ 0, %0 ], [ %indvars.iv.next5, %9 ]
  %10 = trunc i64 %indvars.iv4 to i32
  %11 = add i32 %8, %10
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i64 %12
  %14 = load i32 addrspace(1)* %13, align 4, !tbaa !8
  %15 = trunc i32 %14 to i16
  %16 = add i32 %10, %7
  %17 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %16
  store i16 %15, i16 addrspace(3)* %17, align 2, !tbaa !12
  %indvars.iv.next5 = add nuw nsw i64 %indvars.iv4, 1
  %exitcond6 = icmp eq i64 %indvars.iv.next5, 256
  br i1 %exitcond6, label %18, label %9

; <label>:18                                      ; preds = %9
  tail call void @barrier(i32 1) #2
  %19 = shl i32 %3, 8
  %20 = and i32 %shiftCount, 31
  br label %21

; <label>:21                                      ; preds = %21, %18
  %indvars.iv = phi i64 [ 0, %18 ], [ %indvars.iv.next, %21 ]
  %22 = trunc i64 %indvars.iv to i32
  %23 = add i32 %22, %19
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i64 %24
  %26 = load i32 addrspace(1)* %25, align 4, !tbaa !8
  %27 = lshr i32 %26, %20
  %28 = and i32 %27, 255
  %29 = or i32 %28, %7
  %30 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %29
  %31 = load i16 addrspace(3)* %30, align 2, !tbaa !12
  %32 = zext i16 %31 to i32
  %33 = zext i16 %31 to i64
  %34 = getelementptr inbounds i32 addrspace(1)* %sortedData, i64 %33
  store i32 %26, i32 addrspace(1)* %34, align 4, !tbaa !8
  %35 = add i32 %32, 1
  %36 = trunc i32 %35 to i16
  store i16 %36, i16 addrspace(3)* %30, align 2, !tbaa !12
  tail call void @barrier(i32 1) #2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 256
  br i1 %exitcond, label %37, label %21

; <label>:37                                      ; preds = %21
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim2(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(3)* nocapture %block, i32 %block_size, i32 %stride, i32 addrspace(1)* nocapture %sumBuffer) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 1) #2
  %3 = tail call i32 @get_global_id(i32 0) #2
  %4 = tail call i32 @get_global_id(i32 1) #2
  %5 = tail call i32 @get_group_id(i32 0) #2
  %6 = tail call i32 @get_group_id(i32 1) #2
  %7 = shl i32 %3, 8
  %8 = add nsw i32 %7, %4
  %9 = tail call i32 @get_global_size(i32 0) #2
  %10 = udiv i32 %9, %block_size
  %11 = mul i32 %10, %6
  %12 = add i32 %11, %5
  %13 = sext i32 %8 to i64
  %14 = getelementptr inbounds i32 addrspace(1)* %input, i64 %13
  %15 = load i32 addrspace(1)* %14, align 4, !tbaa !8
  %16 = getelementptr inbounds i32 addrspace(3)* %block, i32 %1
  store i32 %15, i32 addrspace(3)* %16, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %17 = icmp ugt i32 %block_size, 1
  br i1 %17, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %18 = load i32 addrspace(3)* %block, align 4, !tbaa !8
  br label %19

; <label>:19                                      ; preds = %.lr.ph, %27
  %dis.02 = phi i32 [ 1, %.lr.ph ], [ %28, %27 ]
  %cache.01 = phi i32 [ %18, %.lr.ph ], [ %cache.1, %27 ]
  %20 = icmp slt i32 %1, %dis.02
  br i1 %20, label %27, label %21

; <label>:21                                      ; preds = %19
  %22 = sub nsw i32 %1, %dis.02
  %23 = getelementptr inbounds i32 addrspace(3)* %block, i32 %22
  %24 = load i32 addrspace(3)* %23, align 4, !tbaa !8
  %25 = load i32 addrspace(3)* %16, align 4, !tbaa !8
  %26 = add i32 %25, %24
  br label %27

; <label>:27                                      ; preds = %19, %21
  %cache.1 = phi i32 [ %26, %21 ], [ %cache.01, %19 ]
  tail call void @barrier(i32 1) #2
  store i32 %cache.1, i32 addrspace(3)* %16, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %28 = shl nsw i32 %dis.02, 1
  %29 = icmp ult i32 %28, %block_size
  br i1 %29, label %19, label %._crit_edge

._crit_edge:                                      ; preds = %27, %0
  %30 = add i32 %block_size, -1
  %31 = getelementptr inbounds i32 addrspace(3)* %block, i32 %30
  %32 = load i32 addrspace(3)* %31, align 4, !tbaa !8
  %33 = sext i32 %12 to i64
  %34 = getelementptr inbounds i32 addrspace(1)* %sumBuffer, i64 %33
  store i32 %32, i32 addrspace(1)* %34, align 4, !tbaa !8
  %35 = icmp eq i32 %1, 0
  br i1 %35, label %36, label %38

; <label>:36                                      ; preds = %._crit_edge
  %37 = getelementptr inbounds i32 addrspace(1)* %output, i64 %13
  store i32 0, i32 addrspace(1)* %37, align 4, !tbaa !8
  br label %43

; <label>:38                                      ; preds = %._crit_edge
  %39 = add nsw i32 %1, -1
  %40 = getelementptr inbounds i32 addrspace(3)* %block, i32 %39
  %41 = load i32 addrspace(3)* %40, align 4, !tbaa !8
  %42 = getelementptr inbounds i32 addrspace(1)* %output, i64 %13
  store i32 %41, i32 addrspace(1)* %42, align 4, !tbaa !8
  br label %43

; <label>:43                                      ; preds = %38, %36
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim1(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(3)* nocapture %block, i32 %block_size) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = sext i32 %2 to i64
  %5 = getelementptr inbounds i32 addrspace(1)* %input, i64 %4
  %6 = load i32 addrspace(1)* %5, align 4, !tbaa !8
  %7 = getelementptr inbounds i32 addrspace(3)* %block, i32 %1
  store i32 %6, i32 addrspace(3)* %7, align 4, !tbaa !8
  %8 = icmp ugt i32 %block_size, 1
  br i1 %8, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %9 = load i32 addrspace(3)* %block, align 4, !tbaa !8
  br label %10

; <label>:10                                      ; preds = %.lr.ph, %18
  %stride.02 = phi i32 [ 1, %.lr.ph ], [ %19, %18 ]
  %cache.01 = phi i32 [ %9, %.lr.ph ], [ %cache.1, %18 ]
  %11 = icmp slt i32 %1, %stride.02
  br i1 %11, label %18, label %12

; <label>:12                                      ; preds = %10
  %13 = sub nsw i32 %1, %stride.02
  %14 = getelementptr inbounds i32 addrspace(3)* %block, i32 %13
  %15 = load i32 addrspace(3)* %14, align 4, !tbaa !8
  %16 = load i32 addrspace(3)* %7, align 4, !tbaa !8
  %17 = add i32 %16, %15
  br label %18

; <label>:18                                      ; preds = %10, %12
  %cache.1 = phi i32 [ %17, %12 ], [ %cache.01, %10 ]
  tail call void @barrier(i32 1) #2
  store i32 %cache.1, i32 addrspace(3)* %7, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %19 = shl nsw i32 %stride.02, 1
  %20 = icmp ult i32 %19, %block_size
  br i1 %20, label %10, label %._crit_edge

._crit_edge:                                      ; preds = %18, %0
  %21 = icmp eq i32 %1, 0
  br i1 %21, label %22, label %24

; <label>:22                                      ; preds = %._crit_edge
  %23 = getelementptr inbounds i32 addrspace(1)* %output, i64 %4
  store i32 0, i32 addrspace(1)* %23, align 4, !tbaa !8
  br label %29

; <label>:24                                      ; preds = %._crit_edge
  %25 = add nsw i32 %1, -1
  %26 = getelementptr inbounds i32 addrspace(3)* %block, i32 %25
  %27 = load i32 addrspace(3)* %26, align 4, !tbaa !8
  %28 = getelementptr inbounds i32 addrspace(1)* %output, i64 %4
  store i32 %27, i32 addrspace(1)* %28, align 4, !tbaa !8
  br label %29

; <label>:29                                      ; preds = %24, %22
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %summary, i32 %stride) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = mul nsw i32 %2, %stride
  %4 = add nsw i32 %3, %1
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds i32 addrspace(1)* %output, i64 %5
  store i32 0, i32 addrspace(1)* %6, align 4, !tbaa !8
  %7 = icmp sgt i32 %1, 0
  br i1 %7, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %0
  %8 = sext i32 %3 to i64
  br label %9

; <label>:9                                       ; preds = %9, %.lr.ph
  %10 = phi i32 [ 0, %.lr.ph ], [ %14, %9 ]
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %9 ]
  %11 = add nsw i64 %indvars.iv, %8
  %12 = getelementptr inbounds i32 addrspace(1)* %input, i64 %11
  %13 = load i32 addrspace(1)* %12, align 4, !tbaa !8
  %14 = add i32 %10, %13
  store i32 %14, i32 addrspace(1)* %6, align 4, !tbaa !8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %1
  br i1 %exitcond, label %.loopexit, label %9

.loopexit:                                        ; preds = %9, %0
  %15 = phi i32 [ 0, %0 ], [ %14, %9 ]
  %16 = add nsw i32 %stride, -1
  %17 = icmp eq i32 %1, %16
  br i1 %17, label %18, label %24

; <label>:18                                      ; preds = %.loopexit
  %19 = getelementptr inbounds i32 addrspace(1)* %input, i64 %5
  %20 = load i32 addrspace(1)* %19, align 4, !tbaa !8
  %21 = add i32 %20, %15
  %22 = sext i32 %2 to i64
  %23 = getelementptr inbounds i32 addrspace(1)* %summary, i64 %22
  store i32 %21, i32 addrspace(1)* %23, align 4, !tbaa !8
  br label %24

; <label>:24                                      ; preds = %18, %.loopexit
  ret void
}

; Function Attrs: nounwind
define void @blockAddition(i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %output, i32 %stride) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = tail call i32 @get_group_id(i32 1) #2
  %5 = shl i32 %1, 8
  %6 = add nsw i32 %2, %5
  %7 = mul i32 %4, %stride
  %8 = add i32 %7, %3
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds i32 addrspace(1)* %input, i64 %9
  %11 = load i32 addrspace(1)* %10, align 4, !tbaa !8
  %12 = sext i32 %6 to i64
  %13 = getelementptr inbounds i32 addrspace(1)* %output, i64 %12
  %14 = load i32 addrspace(1)* %13, align 4, !tbaa !8
  %15 = add i32 %14, %11
  store i32 %15, i32 addrspace(1)* %13, align 4, !tbaa !8
  ret void
}

; Function Attrs: nounwind
define void @FixOffset(i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = shl i32 %1, 8
  %4 = add nsw i32 %2, %3
  %5 = sext i32 %2 to i64
  %6 = getelementptr inbounds i32 addrspace(1)* %input, i64 %5
  %7 = load i32 addrspace(1)* %6, align 4, !tbaa !8
  %8 = sext i32 %4 to i64
  %9 = getelementptr inbounds i32 addrspace(1)* %output, i64 %8
  %10 = load i32 addrspace(1)* %9, align 4, !tbaa !8
  %11 = add i32 %10, %7
  store i32 %11, i32 addrspace(1)* %9, align 4, !tbaa !8
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
!7 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"int", metadata !10, i64 0}
!10 = metadata !{metadata !"omnipotent char", metadata !11, i64 0}
!11 = metadata !{metadata !"Simple C/C++ TBAA"}
!12 = metadata !{metadata !13, metadata !13, i64 0}
!13 = metadata !{metadata !"short", metadata !10, i64 0}

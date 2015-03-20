; ModuleID = '../kernel-src/RadixSort_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @histogram(i32* nocapture readonly %unsortedData, i32* nocapture %buckets, i32 %shiftCount, i32* %sharedArray) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = tail call i64 @get_global_id(i32 0) #2
  %3 = tail call i64 @get_group_id(i32 0) #2
  %4 = tail call i64 @get_local_size(i32 0) #2
  %5 = tail call i64 @get_global_size(i32 0) #2
  %6 = tail call i64 @get_local_size(i32 0) #2
  %7 = getelementptr inbounds i32* %sharedArray, i64 %1
  store i32 0, i32* %7, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %8 = getelementptr inbounds i32* %unsortedData, i64 %2
  %9 = load i32* %8, align 4, !tbaa !8
  %10 = and i32 %shiftCount, 31
  %11 = lshr i32 %9, %10
  %12 = and i32 %11, 255
  %13 = zext i32 %12 to i64
  %14 = getelementptr inbounds i32* %sharedArray, i64 %13
  %15 = tail call i32 @_Z10atomic_addPVU7CLlocaljj(i32* %14, i32 1) #2
  tail call void @barrier(i32 1) #2
  %16 = mul i64 %4, %3
  %17 = add i64 %16, %1
  %18 = load i32* %7, align 4, !tbaa !8
  %19 = and i64 %17, 4294967295
  %20 = getelementptr inbounds i32* %buckets, i64 %19
  store i32 %18, i32* %20, align 4, !tbaa !8
  ret void
}

declare i64 @get_local_id(i32) #1

declare i64 @get_global_id(i32) #1

declare i64 @get_group_id(i32) #1

declare i64 @get_local_size(i32) #1

declare i64 @get_global_size(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z10atomic_addPVU7CLlocaljj(i32*, i32) #1

; Function Attrs: nounwind uwtable
define void @permute(i32* nocapture readonly %unsortedData, i32* nocapture readonly %scanedBuckets, i32 %shiftCount, i16* nocapture %sharedBuckets, i32* nocapture %sortedData) #0 {
  %1 = tail call i64 @get_group_id(i32 0) #2
  %2 = tail call i64 @get_local_id(i32 0) #2
  %3 = tail call i64 @get_global_id(i32 0) #2
  %4 = tail call i64 @get_local_size(i32 0) #2
  %5 = shl i64 %1, 8
  %6 = mul i64 %5, %4
  %7 = shl i64 %2, 8
  %8 = add i64 %6, %7
  br label %9

; <label>:9                                       ; preds = %9, %0
  %indvars.iv4 = phi i64 [ 0, %0 ], [ %indvars.iv.next5, %9 ]
  %10 = add i64 %8, %indvars.iv4
  %11 = and i64 %10, 4294967295
  %12 = getelementptr inbounds i32* %scanedBuckets, i64 %11
  %13 = load i32* %12, align 4, !tbaa !8
  %14 = trunc i32 %13 to i16
  %15 = add i64 %indvars.iv4, %7
  %16 = getelementptr inbounds i16* %sharedBuckets, i64 %15
  store i16 %14, i16* %16, align 2, !tbaa !12
  %indvars.iv.next5 = add nuw nsw i64 %indvars.iv4, 1
  %exitcond6 = icmp eq i64 %indvars.iv.next5, 256
  br i1 %exitcond6, label %17, label %9

; <label>:17                                      ; preds = %9
  tail call void @barrier(i32 1) #2
  %18 = shl i64 %3, 8
  %19 = and i32 %shiftCount, 31
  br label %20

; <label>:20                                      ; preds = %20, %17
  %indvars.iv = phi i64 [ 0, %17 ], [ %indvars.iv.next, %20 ]
  %21 = add i64 %indvars.iv, %18
  %22 = getelementptr inbounds i32* %unsortedData, i64 %21
  %23 = load i32* %22, align 4, !tbaa !8
  %24 = lshr i32 %23, %19
  %25 = and i32 %24, 255
  %26 = zext i32 %25 to i64
  %27 = or i64 %26, %7
  %28 = getelementptr inbounds i16* %sharedBuckets, i64 %27
  %29 = load i16* %28, align 2, !tbaa !12
  %30 = zext i16 %29 to i64
  %31 = getelementptr inbounds i32* %sortedData, i64 %30
  store i32 %23, i32* %31, align 4, !tbaa !8
  %32 = add i16 %29, 1
  store i16 %32, i16* %28, align 2, !tbaa !12
  tail call void @barrier(i32 1) #2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 256
  br i1 %exitcond, label %33, label %20

; <label>:33                                      ; preds = %20
  ret void
}

; Function Attrs: nounwind uwtable
define void @ScanArraysdim2(i32* nocapture %output, i32* nocapture readonly %input, i32* nocapture %block, i32 %block_size, i32 %stride, i32* nocapture %sumBuffer) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_local_id(i32 1) #2
  %4 = tail call i64 @get_global_id(i32 0) #2
  %5 = trunc i64 %4 to i32
  %6 = tail call i64 @get_global_id(i32 1) #2
  %7 = trunc i64 %6 to i32
  %8 = tail call i64 @get_group_id(i32 0) #2
  %9 = tail call i64 @get_group_id(i32 1) #2
  %10 = shl i32 %5, 8
  %11 = add nsw i32 %10, %7
  %sext = shl i64 %9, 32
  %12 = ashr exact i64 %sext, 32
  %13 = tail call i64 @get_global_size(i32 0) #2
  %14 = zext i32 %block_size to i64
  %15 = udiv i64 %13, %14
  %16 = mul i64 %12, %15
  %17 = add i64 %16, %8
  %18 = sext i32 %11 to i64
  %19 = getelementptr inbounds i32* %input, i64 %18
  %20 = load i32* %19, align 4, !tbaa !8
  %sext2 = shl i64 %1, 32
  %21 = ashr exact i64 %sext2, 32
  %22 = getelementptr inbounds i32* %block, i64 %21
  store i32 %20, i32* %22, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %23 = icmp ugt i32 %block_size, 1
  br i1 %23, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %24 = load i32* %block, align 4, !tbaa !8
  br label %25

; <label>:25                                      ; preds = %.lr.ph, %34
  %dis.06 = phi i32 [ 1, %.lr.ph ], [ %35, %34 ]
  %cache.05 = phi i32 [ %24, %.lr.ph ], [ %cache.1, %34 ]
  %26 = icmp slt i32 %2, %dis.06
  br i1 %26, label %34, label %27

; <label>:27                                      ; preds = %25
  %28 = sub nsw i32 %2, %dis.06
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i32* %block, i64 %29
  %31 = load i32* %30, align 4, !tbaa !8
  %32 = load i32* %22, align 4, !tbaa !8
  %33 = add i32 %32, %31
  br label %34

; <label>:34                                      ; preds = %25, %27
  %cache.1 = phi i32 [ %33, %27 ], [ %cache.05, %25 ]
  tail call void @barrier(i32 1) #2
  store i32 %cache.1, i32* %22, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %35 = shl nsw i32 %dis.06, 1
  %36 = icmp ult i32 %35, %block_size
  br i1 %36, label %25, label %._crit_edge

._crit_edge:                                      ; preds = %34, %0
  %37 = add i32 %block_size, -1
  %38 = zext i32 %37 to i64
  %39 = getelementptr inbounds i32* %block, i64 %38
  %40 = load i32* %39, align 4, !tbaa !8
  %sext3 = shl i64 %17, 32
  %41 = ashr exact i64 %sext3, 32
  %42 = getelementptr inbounds i32* %sumBuffer, i64 %41
  store i32 %40, i32* %42, align 4, !tbaa !8
  %43 = icmp eq i32 %2, 0
  br i1 %43, label %44, label %46

; <label>:44                                      ; preds = %._crit_edge
  %45 = getelementptr inbounds i32* %output, i64 %18
  store i32 0, i32* %45, align 4, !tbaa !8
  br label %51

; <label>:46                                      ; preds = %._crit_edge
  %sext4 = add i64 %sext2, -4294967296
  %47 = ashr exact i64 %sext4, 32
  %48 = getelementptr inbounds i32* %block, i64 %47
  %49 = load i32* %48, align 4, !tbaa !8
  %50 = getelementptr inbounds i32* %output, i64 %18
  store i32 %49, i32* %50, align 4, !tbaa !8
  br label %51

; <label>:51                                      ; preds = %46, %44
  ret void
}

; Function Attrs: nounwind uwtable
define void @ScanArraysdim1(i32* nocapture %output, i32* nocapture readonly %input, i32* nocapture %block, i32 %block_size) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 0) #2
  %4 = tail call i64 @get_group_id(i32 0) #2
  %sext = shl i64 %3, 32
  %5 = ashr exact i64 %sext, 32
  %6 = getelementptr inbounds i32* %input, i64 %5
  %7 = load i32* %6, align 4, !tbaa !8
  %sext1 = shl i64 %1, 32
  %8 = ashr exact i64 %sext1, 32
  %9 = getelementptr inbounds i32* %block, i64 %8
  store i32 %7, i32* %9, align 4, !tbaa !8
  %10 = icmp ugt i32 %block_size, 1
  br i1 %10, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %11 = load i32* %block, align 4, !tbaa !8
  br label %12

; <label>:12                                      ; preds = %.lr.ph, %21
  %stride.04 = phi i32 [ 1, %.lr.ph ], [ %22, %21 ]
  %cache.03 = phi i32 [ %11, %.lr.ph ], [ %cache.1, %21 ]
  %13 = icmp slt i32 %2, %stride.04
  br i1 %13, label %21, label %14

; <label>:14                                      ; preds = %12
  %15 = sub nsw i32 %2, %stride.04
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds i32* %block, i64 %16
  %18 = load i32* %17, align 4, !tbaa !8
  %19 = load i32* %9, align 4, !tbaa !8
  %20 = add i32 %19, %18
  br label %21

; <label>:21                                      ; preds = %12, %14
  %cache.1 = phi i32 [ %20, %14 ], [ %cache.03, %12 ]
  tail call void @barrier(i32 1) #2
  store i32 %cache.1, i32* %9, align 4, !tbaa !8
  tail call void @barrier(i32 1) #2
  %22 = shl nsw i32 %stride.04, 1
  %23 = icmp ult i32 %22, %block_size
  br i1 %23, label %12, label %._crit_edge

._crit_edge:                                      ; preds = %21, %0
  %24 = icmp eq i32 %2, 0
  br i1 %24, label %25, label %27

; <label>:25                                      ; preds = %._crit_edge
  %26 = getelementptr inbounds i32* %output, i64 %5
  store i32 0, i32* %26, align 4, !tbaa !8
  br label %32

; <label>:27                                      ; preds = %._crit_edge
  %sext2 = add i64 %sext1, -4294967296
  %28 = ashr exact i64 %sext2, 32
  %29 = getelementptr inbounds i32* %block, i64 %28
  %30 = load i32* %29, align 4, !tbaa !8
  %31 = getelementptr inbounds i32* %output, i64 %5
  store i32 %30, i32* %31, align 4, !tbaa !8
  br label %32

; <label>:32                                      ; preds = %27, %25
  ret void
}

; Function Attrs: nounwind uwtable
define void @prefixSum(i32* nocapture %output, i32* nocapture readonly %input, i32* nocapture %summary, i32 %stride) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #2
  %4 = trunc i64 %3 to i32
  %5 = mul nsw i32 %4, %stride
  %6 = add nsw i32 %5, %2
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds i32* %output, i64 %7
  store i32 0, i32* %8, align 4, !tbaa !8
  %9 = icmp sgt i32 %2, 0
  br i1 %9, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %0
  %10 = sext i32 %5 to i64
  br label %11

; <label>:11                                      ; preds = %11, %.lr.ph
  %12 = phi i32 [ 0, %.lr.ph ], [ %16, %11 ]
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %11 ]
  %13 = add nsw i64 %indvars.iv, %10
  %14 = getelementptr inbounds i32* %input, i64 %13
  %15 = load i32* %14, align 4, !tbaa !8
  %16 = add i32 %12, %15
  store i32 %16, i32* %8, align 4, !tbaa !8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %2
  br i1 %exitcond, label %.loopexit, label %11

.loopexit:                                        ; preds = %11, %0
  %17 = phi i32 [ 0, %0 ], [ %16, %11 ]
  %18 = add nsw i32 %stride, -1
  %19 = icmp eq i32 %2, %18
  br i1 %19, label %20, label %26

; <label>:20                                      ; preds = %.loopexit
  %21 = getelementptr inbounds i32* %input, i64 %7
  %22 = load i32* %21, align 4, !tbaa !8
  %23 = add i32 %22, %17
  %sext = shl i64 %3, 32
  %24 = ashr exact i64 %sext, 32
  %25 = getelementptr inbounds i32* %summary, i64 %24
  store i32 %23, i32* %25, align 4, !tbaa !8
  br label %26

; <label>:26                                      ; preds = %20, %.loopexit
  ret void
}

; Function Attrs: nounwind uwtable
define void @blockAddition(i32* nocapture readonly %input, i32* nocapture %output, i32 %stride) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #2
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_group_id(i32 0) #2
  %6 = trunc i64 %5 to i32
  %7 = tail call i64 @get_group_id(i32 1) #2
  %8 = trunc i64 %7 to i32
  %9 = shl i32 %2, 8
  %10 = add nsw i32 %4, %9
  %11 = mul i32 %8, %stride
  %12 = add i32 %11, %6
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds i32* %input, i64 %13
  %15 = load i32* %14, align 4, !tbaa !8
  %16 = sext i32 %10 to i64
  %17 = getelementptr inbounds i32* %output, i64 %16
  %18 = load i32* %17, align 4, !tbaa !8
  %19 = add i32 %18, %15
  store i32 %19, i32* %17, align 4, !tbaa !8
  ret void
}

; Function Attrs: nounwind uwtable
define void @FixOffset(i32* nocapture readonly %input, i32* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #2
  %4 = trunc i64 %3 to i32
  %5 = shl i32 %2, 8
  %6 = add nsw i32 %4, %5
  %sext = shl i64 %3, 32
  %7 = ashr exact i64 %sext, 32
  %8 = getelementptr inbounds i32* %input, i64 %7
  %9 = load i32* %8, align 4, !tbaa !8
  %10 = sext i32 %6 to i64
  %11 = getelementptr inbounds i32* %output, i64 %10
  %12 = load i32* %11, align 4, !tbaa !8
  %13 = add i32 %12, %9
  store i32 %13, i32* %11, align 4, !tbaa !8
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (i32*, i32*, i32, i32*)* @histogram}
!1 = metadata !{void (i32*, i32*, i32, i16*, i32*)* @permute}
!2 = metadata !{void (i32*, i32*, i32*, i32, i32, i32*)* @ScanArraysdim2}
!3 = metadata !{void (i32*, i32*, i32*, i32)* @ScanArraysdim1}
!4 = metadata !{void (i32*, i32*, i32*, i32)* @prefixSum}
!5 = metadata !{void (i32*, i32*, i32)* @blockAddition}
!6 = metadata !{void (i32*, i32*)* @FixOffset}
!7 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"int", metadata !10, i64 0}
!10 = metadata !{metadata !"omnipotent char", metadata !11, i64 0}
!11 = metadata !{metadata !"Simple C/C++ TBAA"}
!12 = metadata !{metadata !13, metadata !13, i64 0}
!13 = metadata !{metadata !"short", metadata !10, i64 0}

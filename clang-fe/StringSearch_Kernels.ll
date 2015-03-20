; ModuleID = '../kernel-src/StringSearch_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@StringSearchNaive.groupSuccessCounter = internal global i32 0, align 4
@StringSearchLoadBalance.stack1Counter = internal global i32 0, align 4
@StringSearchLoadBalance.groupSuccessCounter = internal global i32 0, align 4

; Function Attrs: nounwind readonly uwtable
define i32 @compare(i8* nocapture readonly %text, i8* nocapture readonly %pattern, i32 %length) #0 {
  %1 = icmp eq i32 %length, 0
  br i1 %1, label %split2, label %.lr.ph

; <label>:2                                       ; preds = %.lr.ph
  %3 = icmp ult i32 %14, %length
  br i1 %3, label %.lr.ph, label %split2

.lr.ph:                                           ; preds = %0, %2
  %l.01 = phi i32 [ %14, %2 ], [ 0, %0 ]
  %4 = zext i32 %l.01 to i64
  %5 = getelementptr inbounds i8* %text, i64 %4
  %6 = load i8* %5, align 1, !tbaa !3
  %7 = zext i8 %6 to i32
  %.off = add i8 %6, -65
  %8 = icmp ult i8 %.off, 26
  %9 = add nsw i32 %7, 32
  %. = select i1 %8, i32 %9, i32 %7
  %10 = getelementptr inbounds i8* %pattern, i64 %4
  %11 = load i8* %10, align 1, !tbaa !3
  %12 = zext i8 %11 to i32
  %13 = icmp eq i32 %., %12
  %14 = add i32 %l.01, 1
  br i1 %13, label %2, label %split2

split2:                                           ; preds = %2, %.lr.ph, %0
  %.0 = phi i32 [ 1, %0 ], [ 0, %.lr.ph ], [ 1, %2 ]
  ret i32 %.0
}

; Function Attrs: nounwind uwtable
define void @StringSearchNaive(i8* nocapture readonly %text, i32 %textLength, i8* nocapture readonly %pattern, i32 %patternLength, i32* nocapture %resultBuffer, i32* nocapture %resultCountPerWG, i32 %maxSearchLength, i8* nocapture %localPattern) #1 {
  %1 = tail call i64 @get_local_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_local_size(i32 0) #3
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_group_id(i32 0) #3
  %6 = trunc i64 %5 to i32
  %7 = sub i32 %textLength, %patternLength
  %8 = add i32 %7, 1
  %9 = mul i32 %6, %maxSearchLength
  %10 = add i32 %9, %maxSearchLength
  %11 = icmp ugt i32 %9, %8
  br i1 %11, label %56, label %12

; <label>:12                                      ; preds = %0
  %13 = icmp ugt i32 %10, %8
  %. = select i1 %13, i32 %8, i32 %10
  %14 = icmp ult i32 %2, %patternLength
  br i1 %14, label %.lr.ph6, label %._crit_edge7

.lr.ph6:                                          ; preds = %12
  %sext8 = shl i64 %1, 32
  %15 = ashr exact i64 %sext8, 32
  %sext9 = shl i64 %3, 32
  %16 = ashr exact i64 %sext9, 32
  br label %17

; <label>:17                                      ; preds = %.lr.ph6, %17
  %indvars.iv = phi i64 [ %15, %.lr.ph6 ], [ %indvars.iv.next, %17 ]
  %18 = getelementptr inbounds i8* %pattern, i64 %indvars.iv
  %19 = load i8* %18, align 1, !tbaa !3
  %.off = add i8 %19, -65
  %20 = icmp ult i8 %.off, 26
  %21 = add i8 %19, 32
  %.2 = select i1 %20, i8 %21, i8 %19
  %22 = getelementptr inbounds i8* %localPattern, i64 %indvars.iv
  store i8 %.2, i8* %22, align 1, !tbaa !3
  %indvars.iv.next = add nsw i64 %indvars.iv, %16
  %23 = trunc i64 %indvars.iv.next to i32
  %24 = icmp ult i32 %23, %patternLength
  br i1 %24, label %17, label %._crit_edge7

._crit_edge7:                                     ; preds = %17, %12
  %25 = icmp eq i32 %2, 0
  br i1 %25, label %26, label %27

; <label>:26                                      ; preds = %._crit_edge7
  store volatile i32 0, i32* @StringSearchNaive.groupSuccessCounter, align 4, !tbaa !6
  br label %27

; <label>:27                                      ; preds = %26, %._crit_edge7
  tail call void @barrier(i32 1) #3
  %28 = add i32 %9, %2
  %29 = icmp ult i32 %28, %.
  br i1 %29, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %27
  %30 = icmp eq i32 %patternLength, 0
  br label %31

; <label>:31                                      ; preds = %.lr.ph, %compare.exit.thread1
  %stringPos.03 = phi i32 [ %28, %.lr.ph ], [ %50, %compare.exit.thread1 ]
  %32 = zext i32 %stringPos.03 to i64
  br i1 %30, label %.loopexit, label %.lr.ph.i

; <label>:33                                      ; preds = %.lr.ph.i
  %34 = icmp ult i32 %45, %patternLength
  br i1 %34, label %.lr.ph.i, label %.loopexit

.lr.ph.i:                                         ; preds = %31, %33
  %l.01.i = phi i32 [ %45, %33 ], [ 0, %31 ]
  %35 = zext i32 %l.01.i to i64
  %.sum = add i64 %35, %32
  %36 = getelementptr inbounds i8* %text, i64 %.sum
  %37 = load i8* %36, align 1, !tbaa !3
  %38 = zext i8 %37 to i32
  %.off.i = add i8 %37, -65
  %39 = icmp ult i8 %.off.i, 26
  %40 = add nsw i32 %38, 32
  %..i = select i1 %39, i32 %40, i32 %38
  %41 = getelementptr inbounds i8* %localPattern, i64 %35
  %42 = load i8* %41, align 1, !tbaa !3
  %43 = zext i8 %42 to i32
  %44 = icmp eq i32 %..i, %43
  %45 = add i32 %l.01.i, 1
  br i1 %44, label %33, label %compare.exit.thread1

.loopexit:                                        ; preds = %33, %31
  %46 = tail call i32 @_Z10atomic_addPVU7CLlocaljj(i32* @StringSearchNaive.groupSuccessCounter, i32 1) #3
  %47 = add i32 %46, %9
  %48 = zext i32 %47 to i64
  %49 = getelementptr inbounds i32* %resultBuffer, i64 %48
  store i32 %stringPos.03, i32* %49, align 4, !tbaa !6
  br label %compare.exit.thread1

compare.exit.thread1:                             ; preds = %.lr.ph.i, %.loopexit
  %50 = add i32 %stringPos.03, %4
  %51 = icmp ult i32 %50, %.
  br i1 %51, label %31, label %._crit_edge

._crit_edge:                                      ; preds = %compare.exit.thread1, %27
  tail call void @barrier(i32 1) #3
  br i1 %25, label %52, label %56

; <label>:52                                      ; preds = %._crit_edge
  %53 = load volatile i32* @StringSearchNaive.groupSuccessCounter, align 4, !tbaa !6
  %sext = shl i64 %5, 32
  %54 = ashr exact i64 %sext, 32
  %55 = getelementptr inbounds i32* %resultCountPerWG, i64 %54
  store i32 %53, i32* %55, align 4, !tbaa !6
  br label %56

; <label>:56                                      ; preds = %0, %52, %._crit_edge
  ret void
}

declare i64 @get_local_id(i32) #2

declare i64 @get_local_size(i32) #2

declare i64 @get_group_id(i32) #2

declare void @barrier(i32) #2

declare i32 @_Z10atomic_addPVU7CLlocaljj(i32*, i32) #2

; Function Attrs: nounwind uwtable
define void @StringSearchLoadBalance(i8* nocapture readonly %text, i32 %textLength, i8* nocapture readonly %pattern, i32 %patternLength, i32* nocapture %resultBuffer, i32* nocapture %resultCountPerWG, i32 %maxSearchLength, i8* nocapture %localPattern, i32* nocapture %stack1) #1 {
  %1 = tail call i64 @get_local_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_local_size(i32 0) #3
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_group_id(i32 0) #3
  %6 = trunc i64 %5 to i32
  %7 = icmp eq i32 %2, 0
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %0
  store i32 0, i32* @StringSearchLoadBalance.groupSuccessCounter, align 4, !tbaa !6
  store i32 0, i32* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !6
  br label %9

; <label>:9                                       ; preds = %8, %0
  %10 = sub i32 %textLength, %patternLength
  %11 = add i32 %10, 1
  %12 = mul i32 %6, %maxSearchLength
  %13 = add i32 %12, %maxSearchLength
  %14 = icmp ugt i32 %12, %11
  br i1 %14, label %103, label %15

; <label>:15                                      ; preds = %9
  %16 = icmp ugt i32 %13, %11
  %. = select i1 %16, i32 %11, i32 %13
  %17 = sub i32 %., %12
  %18 = icmp ult i32 %2, %patternLength
  br i1 %18, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %15, %.lr.ph
  %idx.015 = phi i32 [ %25, %.lr.ph ], [ %2, %15 ]
  %19 = zext i32 %idx.015 to i64
  %20 = getelementptr inbounds i8* %pattern, i64 %19
  %21 = load i8* %20, align 1, !tbaa !3
  %.off14 = add i8 %21, -65
  %22 = icmp ult i8 %.off14, 26
  %23 = add i8 %21, 32
  %.8 = select i1 %22, i8 %23, i8 %21
  %24 = getelementptr inbounds i8* %localPattern, i64 %19
  store i8 %.8, i8* %24, align 1, !tbaa !3
  %25 = add i32 %idx.015, %4
  %26 = icmp ult i32 %25, %patternLength
  br i1 %26, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %15
  tail call void @barrier(i32 1) #3
  %27 = load i8* %localPattern, align 1, !tbaa !3
  %28 = getelementptr inbounds i8* %localPattern, i64 1
  %29 = load i8* %28, align 1, !tbaa !3
  %30 = zext i8 %27 to i32
  %31 = zext i8 %29 to i32
  %32 = zext i32 %12 to i64
  %33 = add i32 %patternLength, -2
  %34 = icmp eq i32 %33, 0
  %.sum = add i64 %32, 2
  br label %.backedge

.backedge:                                        ; preds = %compare.exit.thread7, %62, %._crit_edge
  %stringPos.0 = phi i32 [ %2, %._crit_edge ], [ %59, %62 ], [ %59, %compare.exit.thread7 ]
  %35 = icmp ult i32 %stringPos.0, %17
  br i1 %35, label %36, label %58

; <label>:36                                      ; preds = %.backedge
  %37 = add i32 %stringPos.0, %12
  %38 = zext i32 %37 to i64
  %39 = getelementptr inbounds i8* %text, i64 %38
  %40 = load i8* %39, align 1, !tbaa !3
  %41 = zext i8 %40 to i32
  %.off = add i8 %40, -65
  %42 = icmp ult i8 %.off, 26
  %43 = add nsw i32 %41, 32
  %.9 = select i1 %42, i32 %43, i32 %41
  %44 = icmp eq i32 %30, %.9
  br i1 %44, label %45, label %58

; <label>:45                                      ; preds = %36
  %46 = add i32 %37, 1
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds i8* %text, i64 %47
  %49 = load i8* %48, align 1, !tbaa !3
  %50 = zext i8 %49 to i32
  %.off13 = add i8 %49, -65
  %51 = icmp ult i8 %.off13, 26
  %52 = add nsw i32 %50, 32
  %.10 = select i1 %51, i32 %52, i32 %50
  %53 = icmp eq i32 %31, %.10
  br i1 %53, label %54, label %58

; <label>:54                                      ; preds = %45
  %55 = tail call i32 @_Z10atomic_addPVU7CLlocaljj(i32* @StringSearchLoadBalance.stack1Counter, i32 1) #3
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds i32* %stack1, i64 %56
  store i32 %stringPos.0, i32* %57, align 4, !tbaa !6
  br label %58

; <label>:58                                      ; preds = %36, %45, %54, %.backedge
  %59 = add nsw i32 %stringPos.0, %4
  tail call void @barrier(i32 1) #3
  %60 = load i32* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !6
  tail call void @barrier(i32 1) #3
  %61 = icmp ult i32 %60, %4
  br i1 %61, label %62, label %66

; <label>:62                                      ; preds = %58
  %63 = srem i32 %59, %4
  %64 = sub i32 %59, %63
  %65 = icmp ult i32 %64, %17
  br i1 %65, label %.backedge, label %66

; <label>:66                                      ; preds = %62, %58
  %67 = icmp ult i32 %2, %60
  br i1 %67, label %68, label %compare.exit.thread7

; <label>:68                                      ; preds = %66
  %69 = tail call i32 @_Z10atomic_subPVU7CLlocaljj(i32* @StringSearchLoadBalance.stack1Counter, i32 1) #3
  %70 = add nsw i32 %69, -1
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds i32* %stack1, i64 %71
  %73 = load i32* %72, align 4, !tbaa !6
  br i1 %34, label %.loopexit, label %.lr.ph.i.preheader

.lr.ph.i.preheader:                               ; preds = %68
  %74 = sext i32 %73 to i64
  %.sum4 = add i64 %.sum, %74
  br label %.lr.ph.i

; <label>:75                                      ; preds = %.lr.ph.i
  %76 = icmp ult i32 %87, %33
  br i1 %76, label %.lr.ph.i, label %.loopexit

.lr.ph.i:                                         ; preds = %.lr.ph.i.preheader, %75
  %l.01.i = phi i32 [ %87, %75 ], [ 0, %.lr.ph.i.preheader ]
  %77 = zext i32 %l.01.i to i64
  %.sum11 = add i64 %.sum4, %77
  %78 = getelementptr inbounds i8* %text, i64 %.sum11
  %79 = load i8* %78, align 1, !tbaa !3
  %80 = zext i8 %79 to i32
  %.off.i = add i8 %79, -65
  %81 = icmp ult i8 %.off.i, 26
  %82 = add nsw i32 %80, 32
  %..i = select i1 %81, i32 %82, i32 %80
  %.sum12 = add i64 %77, 2
  %83 = getelementptr inbounds i8* %localPattern, i64 %.sum12
  %84 = load i8* %83, align 1, !tbaa !3
  %85 = zext i8 %84 to i32
  %86 = icmp eq i32 %..i, %85
  %87 = add i32 %l.01.i, 1
  br i1 %86, label %75, label %compare.exit.thread7

.loopexit:                                        ; preds = %75, %68
  %88 = tail call i32 @_Z10atomic_addPVU7CLlocaljj(i32* @StringSearchLoadBalance.groupSuccessCounter, i32 1) #3
  %89 = add i32 %73, %12
  %90 = add i32 %88, %12
  %91 = zext i32 %90 to i64
  %92 = getelementptr inbounds i32* %resultBuffer, i64 %91
  store i32 %89, i32* %92, align 4, !tbaa !6
  br label %compare.exit.thread7

compare.exit.thread7:                             ; preds = %.lr.ph.i, %.loopexit, %66
  tail call void @barrier(i32 1) #3
  %93 = srem i32 %59, %4
  %94 = sub i32 %59, %93
  %95 = icmp uge i32 %94, %17
  %96 = load i32* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !6
  %97 = icmp eq i32 %96, 0
  %or.cond3 = and i1 %95, %97
  br i1 %or.cond3, label %98, label %.backedge

; <label>:98                                      ; preds = %compare.exit.thread7
  br i1 %7, label %99, label %103

; <label>:99                                      ; preds = %98
  %100 = load i32* @StringSearchLoadBalance.groupSuccessCounter, align 4, !tbaa !6
  %sext = shl i64 %5, 32
  %101 = ashr exact i64 %sext, 32
  %102 = getelementptr inbounds i32* %resultCountPerWG, i64 %101
  store i32 %100, i32* %102, align 4, !tbaa !6
  br label %103

; <label>:103                                     ; preds = %9, %99, %98
  ret void
}

declare i32 @_Z10atomic_subPVU7CLlocaljj(i32*, i32) #2

attributes #0 = { nounwind readonly uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (i8*, i32, i8*, i32, i32*, i32*, i32, i8*)* @StringSearchNaive}
!1 = metadata !{void (i8*, i32, i8*, i32, i32*, i32*, i32, i8*, i32*)* @StringSearchLoadBalance}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}

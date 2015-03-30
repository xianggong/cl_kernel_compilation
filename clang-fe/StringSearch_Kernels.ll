; ModuleID = '../kernel-src/StringSearch_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@StringSearchNaive.groupSuccessCounter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack1Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.groupSuccessCounter = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind readonly
define i32 @compare(i8 addrspace(1)* nocapture readonly %text, i8 addrspace(3)* nocapture readonly %pattern, i32 %length) #0 {
  %1 = icmp eq i32 %length, 0
  br i1 %1, label %split2, label %.lr.ph

; <label>:2                                       ; preds = %.lr.ph
  %3 = icmp ult i32 %14, %length
  br i1 %3, label %.lr.ph, label %split2

.lr.ph:                                           ; preds = %0, %2
  %l.01 = phi i32 [ %14, %2 ], [ 0, %0 ]
  %4 = sext i32 %l.01 to i64
  %5 = getelementptr inbounds i8 addrspace(1)* %text, i64 %4
  %6 = load i8 addrspace(1)* %5, align 1, !tbaa !3
  %7 = zext i8 %6 to i32
  %.off = add i8 %6, -65
  %8 = icmp ult i8 %.off, 26
  %9 = add nsw i32 %7, 32
  %. = select i1 %8, i32 %9, i32 %7
  %10 = getelementptr inbounds i8 addrspace(3)* %pattern, i32 %l.01
  %11 = load i8 addrspace(3)* %10, align 1, !tbaa !3
  %12 = zext i8 %11 to i32
  %13 = icmp eq i32 %., %12
  %14 = add i32 %l.01, 1
  br i1 %13, label %2, label %split2

split2:                                           ; preds = %2, %.lr.ph, %0
  %.0 = phi i32 [ 1, %0 ], [ 0, %.lr.ph ], [ 1, %2 ]
  ret i32 %.0
}

; Function Attrs: nounwind
define void @StringSearchNaive(i8 addrspace(1)* nocapture readonly %text, i32 %textLength, i8 addrspace(1)* nocapture readonly %pattern, i32 %patternLength, i32 addrspace(1)* nocapture %resultBuffer, i32 addrspace(1)* nocapture %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* nocapture %localPattern) #1 {
  %1 = tail call i32 @get_local_id(i32 0) #3
  %2 = tail call i32 @get_local_size(i32 0) #3
  %3 = tail call i32 @get_group_id(i32 0) #3
  %4 = sub i32 %textLength, %patternLength
  %5 = add i32 %4, 1
  %6 = mul i32 %3, %maxSearchLength
  %7 = add i32 %6, %maxSearchLength
  %8 = icmp ugt i32 %6, %5
  br i1 %8, label %56, label %9

; <label>:9                                       ; preds = %0
  %10 = icmp ugt i32 %7, %5
  %. = select i1 %10, i32 %5, i32 %7
  %11 = icmp ult i32 %1, %patternLength
  br i1 %11, label %.lr.ph6, label %._crit_edge7

.lr.ph6:                                          ; preds = %9
  %12 = sext i32 %1 to i64
  %13 = sext i32 %2 to i64
  br label %14

; <label>:14                                      ; preds = %.lr.ph6, %14
  %indvars.iv = phi i64 [ %12, %.lr.ph6 ], [ %indvars.iv.next, %14 ]
  %idx.04 = phi i32 [ %1, %.lr.ph6 ], [ %22, %14 ]
  %15 = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %indvars.iv
  %16 = load i8 addrspace(1)* %15, align 1, !tbaa !3
  %17 = zext i8 %16 to i32
  %.off = add i8 %16, -65
  %18 = icmp ult i8 %.off, 26
  %19 = add nsw i32 %17, 32
  %.2 = select i1 %18, i32 %19, i32 %17
  %20 = trunc i32 %.2 to i8
  %21 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %idx.04
  store i8 %20, i8 addrspace(3)* %21, align 1, !tbaa !3
  %indvars.iv.next = add nsw i64 %indvars.iv, %13
  %22 = add nsw i32 %idx.04, %2
  %23 = trunc i64 %indvars.iv.next to i32
  %24 = icmp ult i32 %23, %patternLength
  br i1 %24, label %14, label %._crit_edge7

._crit_edge7:                                     ; preds = %14, %9
  %25 = icmp eq i32 %1, 0
  br i1 %25, label %26, label %27

; <label>:26                                      ; preds = %._crit_edge7
  store volatile i32 0, i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4, !tbaa !6
  br label %27

; <label>:27                                      ; preds = %26, %._crit_edge7
  tail call void @barrier(i32 1) #3
  %28 = add i32 %6, %1
  %29 = icmp ult i32 %28, %.
  br i1 %29, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %27
  %30 = icmp eq i32 %patternLength, 0
  br label %31

; <label>:31                                      ; preds = %.lr.ph, %compare.exit.thread1
  %stringPos.03 = phi i32 [ %28, %.lr.ph ], [ %50, %compare.exit.thread1 ]
  %32 = sext i32 %stringPos.03 to i64
  br i1 %30, label %.loopexit, label %.lr.ph.i

; <label>:33                                      ; preds = %.lr.ph.i
  %34 = icmp ult i32 %45, %patternLength
  br i1 %34, label %.lr.ph.i, label %.loopexit

.lr.ph.i:                                         ; preds = %31, %33
  %l.01.i = phi i32 [ %45, %33 ], [ 0, %31 ]
  %35 = sext i32 %l.01.i to i64
  %.sum = add i64 %35, %32
  %36 = getelementptr inbounds i8 addrspace(1)* %text, i64 %.sum
  %37 = load i8 addrspace(1)* %36, align 1, !tbaa !3
  %38 = zext i8 %37 to i32
  %.off.i = add i8 %37, -65
  %39 = icmp ult i8 %.off.i, 26
  %40 = add nsw i32 %38, 32
  %..i = select i1 %39, i32 %40, i32 %38
  %41 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %l.01.i
  %42 = load i8 addrspace(3)* %41, align 1, !tbaa !3
  %43 = zext i8 %42 to i32
  %44 = icmp eq i32 %..i, %43
  %45 = add i32 %l.01.i, 1
  br i1 %44, label %33, label %compare.exit.thread1

.loopexit:                                        ; preds = %33, %31
  %46 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, i32 1) #3
  %47 = add i32 %46, %6
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i64 %48
  store i32 %stringPos.03, i32 addrspace(1)* %49, align 4, !tbaa !6
  br label %compare.exit.thread1

compare.exit.thread1:                             ; preds = %.lr.ph.i, %.loopexit
  %50 = add i32 %stringPos.03, %2
  %51 = icmp ult i32 %50, %.
  br i1 %51, label %31, label %._crit_edge

._crit_edge:                                      ; preds = %compare.exit.thread1, %27
  tail call void @barrier(i32 1) #3
  br i1 %25, label %52, label %56

; <label>:52                                      ; preds = %._crit_edge
  %53 = load volatile i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4, !tbaa !6
  %54 = sext i32 %3 to i64
  %55 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i64 %54
  store i32 %53, i32 addrspace(1)* %55, align 4, !tbaa !6
  br label %56

; <label>:56                                      ; preds = %0, %52, %._crit_edge
  ret void
}

declare i32 @get_local_id(i32) #2

declare i32 @get_local_size(i32) #2

declare i32 @get_group_id(i32) #2

declare void @barrier(i32) #2

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #2

; Function Attrs: nounwind
define void @StringSearchLoadBalance(i8 addrspace(1)* nocapture readonly %text, i32 %textLength, i8 addrspace(1)* nocapture readonly %pattern, i32 %patternLength, i32 addrspace(1)* nocapture %resultBuffer, i32 addrspace(1)* nocapture %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* nocapture %localPattern, i32 addrspace(3)* nocapture %stack1) #1 {
  %1 = tail call i32 @get_local_id(i32 0) #3
  %2 = tail call i32 @get_local_size(i32 0) #3
  %3 = tail call i32 @get_group_id(i32 0) #3
  %4 = icmp eq i32 %1, 0
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4, !tbaa !6
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !6
  br label %6

; <label>:6                                       ; preds = %5, %0
  %7 = sub i32 %textLength, %patternLength
  %8 = add i32 %7, 1
  %9 = mul i32 %3, %maxSearchLength
  %10 = add i32 %9, %maxSearchLength
  %11 = icmp ugt i32 %9, %8
  br i1 %11, label %104, label %12

; <label>:12                                      ; preds = %6
  %13 = icmp ugt i32 %10, %8
  %. = select i1 %13, i32 %8, i32 %10
  %14 = sub i32 %., %9
  %15 = icmp ult i32 %1, %patternLength
  br i1 %15, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %12, %.lr.ph
  %idx.015 = phi i32 [ %24, %.lr.ph ], [ %1, %12 ]
  %16 = sext i32 %idx.015 to i64
  %17 = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %16
  %18 = load i8 addrspace(1)* %17, align 1, !tbaa !3
  %19 = zext i8 %18 to i32
  %.off14 = add i8 %18, -65
  %20 = icmp ult i8 %.off14, 26
  %21 = add nsw i32 %19, 32
  %.8 = select i1 %20, i32 %21, i32 %19
  %22 = trunc i32 %.8 to i8
  %23 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %idx.015
  store i8 %22, i8 addrspace(3)* %23, align 1, !tbaa !3
  %24 = add i32 %idx.015, %2
  %25 = icmp ult i32 %24, %patternLength
  br i1 %25, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %12
  tail call void @barrier(i32 1) #3
  %26 = load i8 addrspace(3)* %localPattern, align 1, !tbaa !3
  %27 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 1
  %28 = load i8 addrspace(3)* %27, align 1, !tbaa !3
  %29 = zext i8 %26 to i32
  %30 = zext i8 %28 to i32
  %31 = sext i32 %9 to i64
  %32 = add i32 %patternLength, -2
  %33 = icmp eq i32 %32, 0
  %.sum = add i64 %31, 2
  %34 = sext i32 %1 to i64
  %35 = sext i32 %2 to i64
  br label %.backedge

.backedge:                                        ; preds = %compare.exit.thread7, %62, %._crit_edge
  %indvars.iv = phi i64 [ %34, %._crit_edge ], [ %indvars.iv.next, %62 ], [ %indvars.iv.next, %compare.exit.thread7 ]
  %36 = trunc i64 %indvars.iv to i32
  %37 = icmp ult i32 %36, %14
  br i1 %37, label %38, label %59

; <label>:38                                      ; preds = %.backedge
  %39 = add i32 %36, %9
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i8 addrspace(1)* %text, i64 %40
  %42 = load i8 addrspace(1)* %41, align 1, !tbaa !3
  %43 = zext i8 %42 to i32
  %.off = add i8 %42, -65
  %44 = icmp ult i8 %.off, 26
  %45 = add nsw i32 %43, 32
  %.9 = select i1 %44, i32 %45, i32 %43
  %46 = icmp eq i32 %29, %.9
  br i1 %46, label %47, label %59

; <label>:47                                      ; preds = %38
  %48 = add i32 %39, 1
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds i8 addrspace(1)* %text, i64 %49
  %51 = load i8 addrspace(1)* %50, align 1, !tbaa !3
  %52 = zext i8 %51 to i32
  %.off13 = add i8 %51, -65
  %53 = icmp ult i8 %.off13, 26
  %54 = add nsw i32 %52, 32
  %.10 = select i1 %53, i32 %54, i32 %52
  %55 = icmp eq i32 %30, %.10
  br i1 %55, label %56, label %59

; <label>:56                                      ; preds = %47
  %57 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1) #3
  %58 = getelementptr inbounds i32 addrspace(3)* %stack1, i32 %57
  store i32 %36, i32 addrspace(3)* %58, align 4, !tbaa !6
  br label %59

; <label>:59                                      ; preds = %38, %47, %56, %.backedge
  %indvars.iv.next = add nsw i64 %indvars.iv, %35
  tail call void @barrier(i32 1) #3
  %60 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !6
  tail call void @barrier(i32 1) #3
  %61 = icmp ult i32 %60, %2
  br i1 %61, label %62, label %67

; <label>:62                                      ; preds = %59
  %63 = trunc i64 %indvars.iv.next to i32
  %64 = srem i32 %63, %2
  %65 = sub i32 %63, %64
  %66 = icmp ult i32 %65, %14
  br i1 %66, label %.backedge, label %67

; <label>:67                                      ; preds = %62, %59
  %68 = icmp ult i32 %1, %60
  br i1 %68, label %69, label %compare.exit.thread7

; <label>:69                                      ; preds = %67
  %70 = tail call i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1) #3
  %71 = add nsw i32 %70, -1
  %72 = getelementptr inbounds i32 addrspace(3)* %stack1, i32 %71
  %73 = load i32 addrspace(3)* %72, align 4, !tbaa !6
  br i1 %33, label %.loopexit, label %.lr.ph.i.preheader

.lr.ph.i.preheader:                               ; preds = %69
  %74 = sext i32 %73 to i64
  %.sum4 = add i64 %.sum, %74
  br label %.lr.ph.i

; <label>:75                                      ; preds = %.lr.ph.i
  %76 = icmp ult i32 %87, %32
  br i1 %76, label %.lr.ph.i, label %.loopexit

.lr.ph.i:                                         ; preds = %.lr.ph.i.preheader, %75
  %l.01.i = phi i32 [ %87, %75 ], [ 0, %.lr.ph.i.preheader ]
  %77 = sext i32 %l.01.i to i64
  %.sum11 = add i64 %.sum4, %77
  %78 = getelementptr inbounds i8 addrspace(1)* %text, i64 %.sum11
  %79 = load i8 addrspace(1)* %78, align 1, !tbaa !3
  %80 = zext i8 %79 to i32
  %.off.i = add i8 %79, -65
  %81 = icmp ult i8 %.off.i, 26
  %82 = add nsw i32 %80, 32
  %..i = select i1 %81, i32 %82, i32 %80
  %.sum12 = add i32 %l.01.i, 2
  %83 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %.sum12
  %84 = load i8 addrspace(3)* %83, align 1, !tbaa !3
  %85 = zext i8 %84 to i32
  %86 = icmp eq i32 %..i, %85
  %87 = add i32 %l.01.i, 1
  br i1 %86, label %75, label %compare.exit.thread7

.loopexit:                                        ; preds = %75, %69
  %88 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, i32 1) #3
  %89 = add i32 %73, %9
  %90 = add i32 %88, %9
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i64 %91
  store i32 %89, i32 addrspace(1)* %92, align 4, !tbaa !6
  br label %compare.exit.thread7

compare.exit.thread7:                             ; preds = %.lr.ph.i, %.loopexit, %67
  tail call void @barrier(i32 1) #3
  %93 = trunc i64 %indvars.iv.next to i32
  %94 = srem i32 %93, %2
  %95 = sub i32 %93, %94
  %96 = icmp uge i32 %95, %14
  %97 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !6
  %98 = icmp eq i32 %97, 0
  %or.cond3 = and i1 %96, %98
  br i1 %or.cond3, label %99, label %.backedge

; <label>:99                                      ; preds = %compare.exit.thread7
  br i1 %4, label %100, label %104

; <label>:100                                     ; preds = %99
  %101 = load i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4, !tbaa !6
  %102 = sext i32 %3 to i64
  %103 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i64 %102
  store i32 %101, i32 addrspace(1)* %103, align 4, !tbaa !6
  br label %104

; <label>:104                                     ; preds = %6, %100, %99
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
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}

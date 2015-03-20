; ModuleID = '../kernel-src/TransferOverlapCPP_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@readKernel.lcount = internal global i32 0, align 4
@writeKernel.lval = internal unnamed_addr global i32 0, align 4

; Function Attrs: nounwind uwtable
define void @readKernel(<4 x i32>* nocapture readonly %in, i32* nocapture %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = icmp eq i64 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  store i32 0, i32* @readKernel.lcount, align 4, !tbaa !3
  br label %4

; <label>:4                                       ; preds = %3, %0
  tail call void @barrier(i32 1) #2
  %5 = icmp eq i32 %nk, 0
  br i1 %5, label %._crit_edge8, label %.lr.ph7

.lr.ph7:                                          ; preds = %4
  %6 = icmp eq i32 %ni, 0
  br label %7

; <label>:7                                       ; preds = %._crit_edge, %.lr.ph7
  %n.05 = phi i32 [ 0, %.lr.ph7 ], [ %30, %._crit_edge ]
  %pcount.04 = phi i32 [ 0, %.lr.ph7 ], [ %pcount.1.lcssa, %._crit_edge ]
  %8 = tail call i64 @get_global_id(i32 0) #2
  br i1 %6, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %7, %.lr.ph
  %idx.0.in3 = phi i64 [ %29, %.lr.ph ], [ %8, %7 ]
  %i.02 = phi i32 [ %27, %.lr.ph ], [ 0, %7 ]
  %pcount.11 = phi i32 [ %pcount.5, %.lr.ph ], [ %pcount.04, %7 ]
  %9 = and i64 %idx.0.in3, 4294967295
  %10 = getelementptr inbounds <4 x i32>* %in, i64 %9
  %11 = load volatile <4 x i32>* %10, align 16
  %12 = extractelement <4 x i32> %11, i32 0
  %13 = icmp eq i32 %12, %val
  %14 = zext i1 %13 to i32
  %.pcount.1 = add i32 %14, %pcount.11
  %15 = load volatile <4 x i32>* %10, align 16
  %16 = extractelement <4 x i32> %15, i32 1
  %17 = icmp eq i32 %16, %val
  %18 = zext i1 %17 to i32
  %pcount.3 = add i32 %.pcount.1, %18
  %19 = load volatile <4 x i32>* %10, align 16
  %20 = extractelement <4 x i32> %19, i32 2
  %21 = icmp eq i32 %20, %val
  %22 = zext i1 %21 to i32
  %.pcount.3 = add i32 %pcount.3, %22
  %23 = load volatile <4 x i32>* %10, align 16
  %24 = extractelement <4 x i32> %23, i32 3
  %25 = icmp eq i32 %24, %val
  %26 = zext i1 %25 to i32
  %pcount.5 = add i32 %.pcount.3, %26
  %27 = add i32 %i.02, 1
  %28 = tail call i64 @get_global_size(i32 0) #2
  %29 = add i64 %28, %9
  %exitcond = icmp eq i32 %27, %ni
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %7
  %pcount.1.lcssa = phi i32 [ %pcount.04, %7 ], [ %pcount.5, %.lr.ph ]
  %30 = add nsw i32 %n.05, 1
  %exitcond10 = icmp eq i32 %30, %nk
  br i1 %exitcond10, label %._crit_edge8, label %7

._crit_edge8:                                     ; preds = %._crit_edge, %4
  %pcount.0.lcssa = phi i32 [ 0, %4 ], [ %pcount.1.lcssa, %._crit_edge ]
  %31 = tail call i32 @_Z10atomic_addPVU7CLlocaljj(i32* @readKernel.lcount, i32 %pcount.0.lcssa) #2
  tail call void @barrier(i32 1) #2
  %32 = tail call i64 @get_local_id(i32 0) #2
  %33 = icmp eq i64 %32, 0
  br i1 %33, label %34, label %39

; <label>:34                                      ; preds = %._crit_edge8
  %35 = load i32* @readKernel.lcount, align 4, !tbaa !3
  %36 = udiv i32 %35, %nk
  %37 = tail call i64 @get_group_id(i32 0) #2
  %38 = getelementptr inbounds i32* %out, i64 %37
  store volatile i32 %36, i32* %38, align 4, !tbaa !3
  br label %39

; <label>:39                                      ; preds = %34, %._crit_edge8
  %40 = tail call i64 @get_global_id(i32 0) #2
  %41 = icmp eq i64 %40, 0
  br i1 %41, label %42, label %46

; <label>:42                                      ; preds = %39
  %43 = tail call i64 @get_num_groups(i32 0) #2
  %44 = add i64 %43, 1
  %45 = getelementptr inbounds i32* %out, i64 %44
  store volatile i32 %val, i32* %45, align 4, !tbaa !3
  br label %46

; <label>:46                                      ; preds = %42, %39
  ret void
}

declare i64 @get_local_id(i32) #1

declare void @barrier(i32) #1

declare i64 @get_global_id(i32) #1

declare i64 @get_global_size(i32) #1

declare i32 @_Z10atomic_addPVU7CLlocaljj(i32*, i32) #1

declare i64 @get_group_id(i32) #1

declare i64 @get_num_groups(i32) #1

; Function Attrs: nounwind uwtable
define void @writeKernel(i32* nocapture readonly %in, <4 x i32>* nocapture %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = icmp eq i64 %1, 0
  br i1 %2, label %3, label %8

; <label>:3                                       ; preds = %0
  %4 = tail call i64 @get_num_groups(i32 0) #2
  %5 = add i64 %4, 1
  %6 = getelementptr inbounds i32* %in, i64 %5
  %7 = load volatile i32* %6, align 4, !tbaa !3
  store i32 %7, i32* @writeKernel.lval, align 4, !tbaa !3
  br label %8

; <label>:8                                       ; preds = %3, %0
  tail call void @barrier(i32 1) #2
  %9 = load i32* @writeKernel.lval, align 4, !tbaa !3
  %10 = insertelement <4 x i32> undef, i32 %9, i32 0
  %11 = insertelement <4 x i32> %10, i32 %9, i32 1
  %12 = insertelement <4 x i32> %11, i32 %9, i32 2
  %13 = insertelement <4 x i32> %12, i32 %9, i32 3
  %14 = icmp eq i32 %nk, 0
  br i1 %14, label %._crit_edge6, label %.lr.ph5

.lr.ph5:                                          ; preds = %8
  %15 = icmp eq i32 %ni, 0
  br label %16

; <label>:16                                      ; preds = %._crit_edge, %.lr.ph5
  %n.03 = phi i32 [ 0, %.lr.ph5 ], [ %23, %._crit_edge ]
  %17 = tail call i64 @get_global_id(i32 0) #2
  br i1 %15, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %16, %.lr.ph
  %i.02 = phi i32 [ %20, %.lr.ph ], [ 0, %16 ]
  %idx.0.in1 = phi i64 [ %22, %.lr.ph ], [ %17, %16 ]
  %18 = and i64 %idx.0.in1, 4294967295
  %19 = getelementptr inbounds <4 x i32>* %out, i64 %18
  store volatile <4 x i32> %13, <4 x i32>* %19, align 16, !tbaa !7
  %20 = add i32 %i.02, 1
  %21 = tail call i64 @get_global_size(i32 0) #2
  %22 = add i64 %21, %18
  %exitcond = icmp eq i32 %20, %ni
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %16
  %23 = add nsw i32 %n.03, 1
  %exitcond7 = icmp eq i32 %23, %nk
  br i1 %exitcond7, label %._crit_edge6, label %16

._crit_edge6:                                     ; preds = %._crit_edge, %8
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32>*, i32*, i32, i32, i32)* @readKernel}
!1 = metadata !{void (i32*, <4 x i32>*, i32, i32, i32)* @writeKernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"int", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !5, metadata !5, i64 0}

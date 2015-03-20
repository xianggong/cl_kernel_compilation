; ModuleID = '../kernel-src/StringSearch_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

@StringSearchNaive.groupSuccessCounter = internal addrspace(3) global i32 undef, align 4
@StringSearchLoadBalance.stack1Counter = internal addrspace(3) global i32 undef, align 4
@StringSearchLoadBalance.groupSuccessCounter = internal addrspace(3) global i32 undef, align 4

; Function Attrs: nounwind readonly
define i32 @compare(i8 addrspace(1)* nocapture readonly %text, i8 addrspace(3)* nocapture readonly %pattern, i32 %length) #0 {
  %1 = icmp eq i32 %length, 0
  br i1 %1, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

; <label>:2                                       ; preds = %.lr.ph
  %3 = icmp ult i32 %13, %length
  br i1 %3, label %.lr.ph, label %._crit_edge.loopexit

.lr.ph:                                           ; preds = %.lr.ph.preheader, %2
  %l.01 = phi i32 [ %13, %2 ], [ 0, %.lr.ph.preheader ]
  %4 = getelementptr inbounds i8 addrspace(1)* %text, i32 %l.01
  %5 = load i8 addrspace(1)* %4, align 1, !tbaa !13
  %6 = zext i8 %5 to i32
  %.off = add i8 %5, -65
  %7 = icmp ult i8 %.off, 26
  %8 = add nuw nsw i32 %6, 32
  %. = select i1 %7, i32 %8, i32 %6
  %9 = getelementptr inbounds i8 addrspace(3)* %pattern, i32 %l.01
  %10 = load i8 addrspace(3)* %9, align 1, !tbaa !13
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %., %11
  %13 = add nuw i32 %l.01, 1
  br i1 %12, label %2, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %2, %.lr.ph
  %.0.ph = phi i32 [ 1, %2 ], [ 0, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %.0 = phi i32 [ 1, %0 ], [ %.0.ph, %._crit_edge.loopexit ]
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
  br i1 %8, label %48, label %9

; <label>:9                                       ; preds = %0
  %10 = icmp ugt i32 %7, %5
  %. = select i1 %10, i32 %5, i32 %7
  %11 = icmp ult i32 %1, %patternLength
  br i1 %11, label %.lr.ph6.preheader, label %._crit_edge7

.lr.ph6.preheader:                                ; preds = %9
  br label %.lr.ph6

.lr.ph6:                                          ; preds = %.lr.ph6.preheader, %.lr.ph6
  %idx.04 = phi i32 [ %19, %.lr.ph6 ], [ %1, %.lr.ph6.preheader ]
  %12 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.04
  %13 = load i8 addrspace(1)* %12, align 1, !tbaa !13
  %14 = zext i8 %13 to i32
  %.off = add i8 %13, -65
  %15 = icmp ult i8 %.off, 26
  %16 = add nuw nsw i32 %14, 32
  %.2 = select i1 %15, i32 %16, i32 %14
  %17 = trunc i32 %.2 to i8
  %18 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %idx.04
  store i8 %17, i8 addrspace(3)* %18, align 1, !tbaa !13
  %19 = add nsw i32 %idx.04, %2
  %20 = icmp ult i32 %19, %patternLength
  br i1 %20, label %.lr.ph6, label %._crit_edge7.loopexit

._crit_edge7.loopexit:                            ; preds = %.lr.ph6
  br label %._crit_edge7

._crit_edge7:                                     ; preds = %._crit_edge7.loopexit, %9
  %21 = icmp eq i32 %1, 0
  br i1 %21, label %22, label %23

; <label>:22                                      ; preds = %._crit_edge7
  store volatile i32 0, i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4, !tbaa !16
  br label %23

; <label>:23                                      ; preds = %22, %._crit_edge7
  tail call void @barrier(i32 1) #3
  %24 = add i32 %6, %1
  %25 = icmp ult i32 %24, %.
  br i1 %25, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %23
  %26 = icmp eq i32 %patternLength, 0
  br label %27

; <label>:27                                      ; preds = %.lr.ph, %compare.exit.thread1
  %stringPos.03 = phi i32 [ %24, %.lr.ph ], [ %43, %compare.exit.thread1 ]
  br i1 %26, label %.loopexit, label %.lr.ph.i.preheader

.lr.ph.i.preheader:                               ; preds = %27
  br label %.lr.ph.i

; <label>:28                                      ; preds = %.lr.ph.i
  %29 = icmp ult i32 %39, %patternLength
  br i1 %29, label %.lr.ph.i, label %.loopexit.loopexit

.lr.ph.i:                                         ; preds = %.lr.ph.i.preheader, %28
  %l.01.i = phi i32 [ %39, %28 ], [ 0, %.lr.ph.i.preheader ]
  %.sum = add i32 %l.01.i, %stringPos.03
  %30 = getelementptr inbounds i8 addrspace(1)* %text, i32 %.sum
  %31 = load i8 addrspace(1)* %30, align 1, !tbaa !13
  %32 = zext i8 %31 to i32
  %.off.i = add i8 %31, -65
  %33 = icmp ult i8 %.off.i, 26
  %34 = add nuw nsw i32 %32, 32
  %..i = select i1 %33, i32 %34, i32 %32
  %35 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %l.01.i
  %36 = load i8 addrspace(3)* %35, align 1, !tbaa !13
  %37 = zext i8 %36 to i32
  %38 = icmp eq i32 %..i, %37
  %39 = add nuw i32 %l.01.i, 1
  br i1 %38, label %28, label %compare.exit.thread1.loopexit

.loopexit.loopexit:                               ; preds = %28
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %27
  %40 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, i32 1) #3
  %41 = add i32 %40, %6
  %42 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i32 %41
  store i32 %stringPos.03, i32 addrspace(1)* %42, align 4, !tbaa !16
  br label %compare.exit.thread1

compare.exit.thread1.loopexit:                    ; preds = %.lr.ph.i
  br label %compare.exit.thread1

compare.exit.thread1:                             ; preds = %compare.exit.thread1.loopexit, %.loopexit
  %43 = add i32 %stringPos.03, %2
  %44 = icmp ult i32 %43, %.
  br i1 %44, label %27, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %compare.exit.thread1
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %23
  tail call void @barrier(i32 1) #3
  br i1 %21, label %45, label %48

; <label>:45                                      ; preds = %._crit_edge
  %46 = load volatile i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4, !tbaa !16
  %47 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i32 %3
  store i32 %46, i32 addrspace(1)* %47, align 4, !tbaa !16
  br label %48

; <label>:48                                      ; preds = %0, %45, %._crit_edge
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
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4, !tbaa !16
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !16
  br label %6

; <label>:6                                       ; preds = %5, %0
  %7 = sub i32 %textLength, %patternLength
  %8 = add i32 %7, 1
  %9 = mul i32 %3, %maxSearchLength
  %10 = add i32 %9, %maxSearchLength
  %11 = icmp ugt i32 %9, %8
  br i1 %11, label %91, label %12

; <label>:12                                      ; preds = %6
  %13 = icmp ugt i32 %10, %8
  %. = select i1 %13, i32 %8, i32 %10
  %14 = sub i32 %., %9
  %15 = icmp ult i32 %1, %patternLength
  br i1 %15, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %12
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %idx.015 = phi i32 [ %23, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %16 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.015
  %17 = load i8 addrspace(1)* %16, align 1, !tbaa !13
  %18 = zext i8 %17 to i32
  %.off14 = add i8 %17, -65
  %19 = icmp ult i8 %.off14, 26
  %20 = add nuw nsw i32 %18, 32
  %.8 = select i1 %19, i32 %20, i32 %18
  %21 = trunc i32 %.8 to i8
  %22 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %idx.015
  store i8 %21, i8 addrspace(3)* %22, align 1, !tbaa !13
  %23 = add i32 %idx.015, %2
  %24 = icmp ult i32 %23, %patternLength
  br i1 %24, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %12
  tail call void @barrier(i32 1) #3
  %25 = load i8 addrspace(3)* %localPattern, align 1, !tbaa !13
  %26 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 1
  %27 = load i8 addrspace(3)* %26, align 1, !tbaa !13
  %28 = zext i8 %25 to i32
  %29 = zext i8 %27 to i32
  %30 = add i32 %patternLength, -2
  %31 = icmp eq i32 %30, 0
  br label %.backedge

.backedge:                                        ; preds = %.backedge.backedge, %._crit_edge
  %stringPos.0 = phi i32 [ %1, %._crit_edge ], [ %53, %.backedge.backedge ]
  %32 = icmp ult i32 %stringPos.0, %14
  br i1 %32, label %33, label %52

; <label>:33                                      ; preds = %.backedge
  %34 = add i32 %stringPos.0, %9
  %35 = getelementptr inbounds i8 addrspace(1)* %text, i32 %34
  %36 = load i8 addrspace(1)* %35, align 1, !tbaa !13
  %37 = zext i8 %36 to i32
  %.off = add i8 %36, -65
  %38 = icmp ult i8 %.off, 26
  %39 = add nuw nsw i32 %37, 32
  %.9 = select i1 %38, i32 %39, i32 %37
  %40 = icmp eq i32 %28, %.9
  br i1 %40, label %41, label %52

; <label>:41                                      ; preds = %33
  %42 = add i32 %34, 1
  %43 = getelementptr inbounds i8 addrspace(1)* %text, i32 %42
  %44 = load i8 addrspace(1)* %43, align 1, !tbaa !13
  %45 = zext i8 %44 to i32
  %.off13 = add i8 %44, -65
  %46 = icmp ult i8 %.off13, 26
  %47 = add nuw nsw i32 %45, 32
  %.10 = select i1 %46, i32 %47, i32 %45
  %48 = icmp eq i32 %29, %.10
  br i1 %48, label %49, label %52

; <label>:49                                      ; preds = %41
  %50 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1) #3
  %51 = getelementptr inbounds i32 addrspace(3)* %stack1, i32 %50
  store i32 %stringPos.0, i32 addrspace(3)* %51, align 4, !tbaa !16
  br label %52

; <label>:52                                      ; preds = %33, %41, %49, %.backedge
  %53 = add nsw i32 %stringPos.0, %2
  tail call void @barrier(i32 1) #3
  %54 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4, !tbaa !16
  tail call void @barrier(i32 1) #3
  %55 = icmp ult i32 %54, %2
  br i1 %55, label %56, label %60

; <label>:56                                      ; preds = %52
  %57 = srem i32 %53, %2
  %58 = sub i32 %53, %57
  %59 = icmp ult i32 %58, %14
  br i1 %59, label %.backedge.backedge, label %60

.backedge.backedge:                               ; preds = %56, %compare.exit.thread7
  br label %.backedge

; <label>:60                                      ; preds = %56, %52
  %61 = icmp ult i32 %1, %54
  br i1 %61, label %62, label %compare.exit.thread7

; <label>:62                                      ; preds = %60
  %63 = tail call i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1) #3
  %64 = add nsw i32 %63, -1
  %65 = getelementptr inbounds i32 addrspace(3)* %stack1, i32 %64
  %66 = load i32 addrspace(3)* %65, align 4, !tbaa !16
  %.sum = add i32 %66, %9
  %.sum4 = add i32 %.sum, 2
  br i1 %31, label %.loopexit, label %.lr.ph.i.preheader

.lr.ph.i.preheader:                               ; preds = %62
  br label %.lr.ph.i

; <label>:67                                      ; preds = %.lr.ph.i
  %68 = icmp ult i32 %78, %30
  br i1 %68, label %.lr.ph.i, label %.loopexit.loopexit

.lr.ph.i:                                         ; preds = %.lr.ph.i.preheader, %67
  %l.01.i = phi i32 [ %78, %67 ], [ 0, %.lr.ph.i.preheader ]
  %.sum11 = add i32 %.sum4, %l.01.i
  %69 = getelementptr inbounds i8 addrspace(1)* %text, i32 %.sum11
  %70 = load i8 addrspace(1)* %69, align 1, !tbaa !13
  %71 = zext i8 %70 to i32
  %.off.i = add i8 %70, -65
  %72 = icmp ult i8 %.off.i, 26
  %73 = add nuw nsw i32 %71, 32
  %..i = select i1 %72, i32 %73, i32 %71
  %.sum12 = add i32 %l.01.i, 2
  %74 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %.sum12
  %75 = load i8 addrspace(3)* %74, align 1, !tbaa !13
  %76 = zext i8 %75 to i32
  %77 = icmp eq i32 %..i, %76
  %78 = add nuw i32 %l.01.i, 1
  br i1 %77, label %67, label %compare.exit.thread7.loopexit

.loopexit.loopexit:                               ; preds = %67
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %62
  %79 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, i32 1) #3
  %80 = add i32 %79, %9
  %81 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i32 %80
  store i32 %.sum, i32 addrspace(1)* %81, align 4, !tbaa !16
  br label %compare.exit.thread7

compare.exit.thread7.loopexit:                    ; preds = %.lr.ph.i
  br label %compare.exit.thread7

compare.exit.thread7:                             ; preds = %compare.exit.thread7.loopexit, %.loopexit, %60
  tail call void @barrier(i32 1) #3
  %82 = srem i32 %53, %2
  %83 = sub i32 %53, %82
  %84 = icmp uge i32 %83, %14
  %85 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  %86 = icmp eq i32 %85, 0
  %or.cond3 = and i1 %84, %86
  br i1 %or.cond3, label %87, label %.backedge.backedge

; <label>:87                                      ; preds = %compare.exit.thread7
  br i1 %4, label %88, label %91

; <label>:88                                      ; preds = %87
  %89 = load i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4, !tbaa !16
  %90 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i32 %3
  store i32 %89, i32 addrspace(1)* %90, align 4, !tbaa !16
  br label %91

; <label>:91                                      ; preds = %6, %88, %87
  ret void
}

declare i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)*, i32) #2

attributes #0 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!12}

!0 = !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*)* @StringSearchNaive, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 0, i32 1, i32 1, i32 0, i32 3}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uchar*", !"uint", !"uchar*", !"uint", !"int*", !"int*", !"uint", !"uchar*"}
!4 = !{!"kernel_arg_base_type", !"uchar*", !"uint", !"uchar*", !"uint", !"int*", !"int*", !"uint", !"uchar*"}
!5 = !{!"kernel_arg_type_qual", !"", !"const", !"const", !"const", !"", !"", !"const", !""}
!6 = !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*, i32 addrspace(3)*)* @StringSearchLoadBalance, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 0, i32 1, i32 1, i32 0, i32 3, i32 3}
!8 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"uchar*", !"uint", !"uchar*", !"uint", !"int*", !"int*", !"uint", !"uchar*", !"int*"}
!10 = !{!"kernel_arg_base_type", !"uchar*", !"uint", !"uchar*", !"uint", !"int*", !"int*", !"uint", !"uchar*", !"int*"}
!11 = !{!"kernel_arg_type_qual", !"", !"const", !"const", !"const", !"", !"", !"const", !"", !""}
!12 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!13 = !{!14, !14, i64 0}
!14 = !{!"omnipotent char", !15, i64 0}
!15 = !{!"Simple C/C++ TBAA"}
!16 = !{!17, !17, i64 0}
!17 = !{!"int", !14, i64 0}

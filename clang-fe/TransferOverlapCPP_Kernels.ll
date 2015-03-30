; ModuleID = '../kernel-src/TransferOverlapCPP_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@readKernel.lcount = internal addrspace(3) global i32 0, align 4
@writeKernel.lval = internal addrspace(3) unnamed_addr global i32 0, align 4

; Function Attrs: nounwind
define void @readKernel(<4 x i32> addrspace(1)* nocapture readonly %in, i32 addrspace(1)* nocapture %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  store i32 0, i32 addrspace(3)* @readKernel.lcount, align 4, !tbaa !3
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
  %8 = tail call i32 @get_global_id(i32 0) #2
  br i1 %6, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %7, %.lr.ph
  %idx.03 = phi i32 [ %29, %.lr.ph ], [ %8, %7 ]
  %i.02 = phi i32 [ %27, %.lr.ph ], [ 0, %7 ]
  %pcount.11 = phi i32 [ %pcount.5, %.lr.ph ], [ %pcount.04, %7 ]
  %9 = sext i32 %idx.03 to i64
  %10 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i64 %9
  %11 = load volatile <4 x i32> addrspace(1)* %10, align 16
  %12 = extractelement <4 x i32> %11, i32 0
  %13 = icmp eq i32 %12, %val
  %14 = zext i1 %13 to i32
  %.pcount.1 = add i32 %14, %pcount.11
  %15 = load volatile <4 x i32> addrspace(1)* %10, align 16
  %16 = extractelement <4 x i32> %15, i32 1
  %17 = icmp eq i32 %16, %val
  %18 = zext i1 %17 to i32
  %pcount.3 = add i32 %.pcount.1, %18
  %19 = load volatile <4 x i32> addrspace(1)* %10, align 16
  %20 = extractelement <4 x i32> %19, i32 2
  %21 = icmp eq i32 %20, %val
  %22 = zext i1 %21 to i32
  %.pcount.3 = add i32 %pcount.3, %22
  %23 = load volatile <4 x i32> addrspace(1)* %10, align 16
  %24 = extractelement <4 x i32> %23, i32 3
  %25 = icmp eq i32 %24, %val
  %26 = zext i1 %25 to i32
  %pcount.5 = add i32 %.pcount.3, %26
  %27 = add i32 %i.02, 1
  %28 = tail call i32 @get_global_size(i32 0) #2
  %29 = add i32 %28, %idx.03
  %exitcond = icmp eq i32 %27, %ni
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %7
  %pcount.1.lcssa = phi i32 [ %pcount.04, %7 ], [ %pcount.5, %.lr.ph ]
  %30 = add nsw i32 %n.05, 1
  %exitcond10 = icmp eq i32 %30, %nk
  br i1 %exitcond10, label %._crit_edge8, label %7

._crit_edge8:                                     ; preds = %._crit_edge, %4
  %pcount.0.lcssa = phi i32 [ 0, %4 ], [ %pcount.1.lcssa, %._crit_edge ]
  %31 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @readKernel.lcount, i32 %pcount.0.lcssa) #2
  tail call void @barrier(i32 1) #2
  %32 = tail call i32 @get_local_id(i32 0) #2
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %40

; <label>:34                                      ; preds = %._crit_edge8
  %35 = load i32 addrspace(3)* @readKernel.lcount, align 4, !tbaa !3
  %36 = udiv i32 %35, %nk
  %37 = tail call i32 @get_group_id(i32 0) #2
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds i32 addrspace(1)* %out, i64 %38
  store volatile i32 %36, i32 addrspace(1)* %39, align 4, !tbaa !3
  br label %40

; <label>:40                                      ; preds = %34, %._crit_edge8
  %41 = tail call i32 @get_global_id(i32 0) #2
  %42 = icmp eq i32 %41, 0
  br i1 %42, label %43, label %48

; <label>:43                                      ; preds = %40
  %44 = tail call i32 @get_num_groups(i32 0) #2
  %45 = add i32 %44, 1
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds i32 addrspace(1)* %out, i64 %46
  store volatile i32 %val, i32 addrspace(1)* %47, align 4, !tbaa !3
  br label %48

; <label>:48                                      ; preds = %43, %40
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
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %9

; <label>:3                                       ; preds = %0
  %4 = tail call i32 @get_num_groups(i32 0) #2
  %5 = add i32 %4, 1
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds i32 addrspace(1)* %in, i64 %6
  %8 = load volatile i32 addrspace(1)* %7, align 4, !tbaa !3
  store i32 %8, i32 addrspace(3)* @writeKernel.lval, align 4, !tbaa !3
  br label %9

; <label>:9                                       ; preds = %3, %0
  tail call void @barrier(i32 1) #2
  %10 = load i32 addrspace(3)* @writeKernel.lval, align 4, !tbaa !3
  %11 = insertelement <4 x i32> undef, i32 %10, i32 0
  %12 = insertelement <4 x i32> %11, i32 %10, i32 1
  %13 = insertelement <4 x i32> %12, i32 %10, i32 2
  %14 = insertelement <4 x i32> %13, i32 %10, i32 3
  %15 = icmp eq i32 %nk, 0
  br i1 %15, label %._crit_edge6, label %.lr.ph5

.lr.ph5:                                          ; preds = %9
  %16 = icmp eq i32 %ni, 0
  br label %17

; <label>:17                                      ; preds = %._crit_edge, %.lr.ph5
  %n.03 = phi i32 [ 0, %.lr.ph5 ], [ %24, %._crit_edge ]
  %18 = tail call i32 @get_global_id(i32 0) #2
  br i1 %16, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %17, %.lr.ph
  %i.02 = phi i32 [ %21, %.lr.ph ], [ 0, %17 ]
  %idx.01 = phi i32 [ %23, %.lr.ph ], [ %18, %17 ]
  %19 = sext i32 %idx.01 to i64
  %20 = getelementptr inbounds <4 x i32> addrspace(1)* %out, i64 %19
  store volatile <4 x i32> %14, <4 x i32> addrspace(1)* %20, align 16, !tbaa !7
  %21 = add i32 %i.02, 1
  %22 = tail call i32 @get_global_size(i32 0) #2
  %23 = add i32 %22, %idx.01
  %exitcond = icmp eq i32 %21, %ni
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %17
  %24 = add nsw i32 %n.03, 1
  %exitcond7 = icmp eq i32 %24, %nk
  br i1 %exitcond7, label %._crit_edge6, label %17

._crit_edge6:                                     ; preds = %._crit_edge, %9
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @readKernel}
!1 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @writeKernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"int", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !5, metadata !5, i64 0}

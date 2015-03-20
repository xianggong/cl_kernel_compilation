; ModuleID = '../kernel-src/BufferBandwidth_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

@read_kernel.lcount = internal addrspace(3) global i32 undef, align 4

; Function Attrs: nounwind
define void @read_kernel(<4 x i32> addrspace(1)* nocapture readonly %in, i32 addrspace(1)* nocapture %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = icmp eq i32 %nk, 0
  br i1 %1, label %36, label %2

; <label>:2                                       ; preds = %0
  %3 = tail call i32 @get_local_id(i32 0) #2
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %.lr.ph7

; <label>:5                                       ; preds = %2
  store i32 0, i32 addrspace(3)* @read_kernel.lcount, align 4, !tbaa !10
  br label %.lr.ph7

.lr.ph7:                                          ; preds = %2, %5
  tail call void @barrier(i32 1) #2
  %6 = icmp eq i32 %ni, 0
  %7 = add i32 %nk, -1
  br label %8

; <label>:8                                       ; preds = %._crit_edge, %.lr.ph7
  %n.05 = phi i32 [ 0, %.lr.ph7 ], [ %27, %._crit_edge ]
  %pcount.04 = phi i32 [ 0, %.lr.ph7 ], [ %pcount.1.lcssa, %._crit_edge ]
  %9 = tail call i32 @get_global_id(i32 0) #2
  br i1 %6, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %8
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %idx.03 = phi i32 [ %26, %.lr.ph ], [ %9, %.lr.ph.preheader ]
  %i.02 = phi i32 [ %24, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %pcount.11 = phi i32 [ %pcount.5, %.lr.ph ], [ %pcount.04, %.lr.ph.preheader ]
  %10 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.03
  %11 = load <4 x i32> addrspace(1)* %10, align 16
  %12 = extractelement <4 x i32> %11, i32 0
  %13 = icmp eq i32 %12, %val
  %14 = zext i1 %13 to i32
  %.pcount.1 = add i32 %14, %pcount.11
  %15 = extractelement <4 x i32> %11, i32 1
  %16 = icmp eq i32 %15, %val
  %17 = zext i1 %16 to i32
  %pcount.3 = add i32 %.pcount.1, %17
  %18 = extractelement <4 x i32> %11, i32 2
  %19 = icmp eq i32 %18, %val
  %20 = zext i1 %19 to i32
  %.pcount.3 = add i32 %pcount.3, %20
  %21 = extractelement <4 x i32> %11, i32 3
  %22 = icmp eq i32 %21, %val
  %23 = zext i1 %22 to i32
  %pcount.5 = add i32 %.pcount.3, %23
  %24 = add nuw i32 %i.02, 1
  %25 = tail call i32 @get_global_size(i32 0) #2
  %26 = add i32 %25, %idx.03
  %exitcond = icmp eq i32 %24, %ni
  br i1 %exitcond, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %pcount.5.lcssa = phi i32 [ %pcount.5, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %8
  %pcount.1.lcssa = phi i32 [ %pcount.04, %8 ], [ %pcount.5.lcssa, %._crit_edge.loopexit ]
  %27 = add nuw nsw i32 %n.05, 1
  %exitcond10 = icmp eq i32 %n.05, %7
  br i1 %exitcond10, label %._crit_edge8, label %8

._crit_edge8:                                     ; preds = %._crit_edge
  %pcount.1.lcssa.lcssa = phi i32 [ %pcount.1.lcssa, %._crit_edge ]
  %28 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @read_kernel.lcount, i32 %pcount.1.lcssa.lcssa) #2
  tail call void @barrier(i32 1) #2
  %29 = tail call i32 @get_local_id(i32 0) #2
  %30 = icmp eq i32 %29, 0
  br i1 %30, label %31, label %36

; <label>:31                                      ; preds = %._crit_edge8
  %32 = load i32 addrspace(3)* @read_kernel.lcount, align 4, !tbaa !10
  %33 = udiv i32 %32, %nk
  %34 = tail call i32 @get_group_id(i32 0) #2
  %35 = getelementptr inbounds i32 addrspace(1)* %out, i32 %34
  store i32 %33, i32 addrspace(1)* %35, align 4, !tbaa !10
  br label %36

; <label>:36                                      ; preds = %0, %31, %._crit_edge8
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
  %1 = icmp eq i32 %nk, 0
  br i1 %1, label %.loopexit, label %.lr.ph5

.lr.ph5:                                          ; preds = %0
  %2 = insertelement <4 x i32> undef, i32 %val, i32 0
  %3 = insertelement <4 x i32> %2, i32 %val, i32 1
  %4 = insertelement <4 x i32> %3, i32 %val, i32 2
  %5 = insertelement <4 x i32> %4, i32 %val, i32 3
  %6 = icmp eq i32 %ni, 0
  %7 = add i32 %nk, -1
  br label %8

; <label>:8                                       ; preds = %._crit_edge, %.lr.ph5
  %n.03 = phi i32 [ 0, %.lr.ph5 ], [ %14, %._crit_edge ]
  %9 = tail call i32 @get_global_id(i32 0) #2
  br i1 %6, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %8
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %i.02 = phi i32 [ %11, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %idx.01 = phi i32 [ %13, %.lr.ph ], [ %9, %.lr.ph.preheader ]
  %10 = getelementptr inbounds <4 x i32> addrspace(1)* %out, i32 %idx.01
  store <4 x i32> %5, <4 x i32> addrspace(1)* %10, align 16, !tbaa !14
  %11 = add nuw i32 %i.02, 1
  %12 = tail call i32 @get_global_size(i32 0) #2
  %13 = add i32 %12, %idx.01
  %exitcond = icmp eq i32 %11, %ni
  br i1 %exitcond, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %8
  %14 = add nuw nsw i32 %n.03, 1
  %exitcond6 = icmp eq i32 %n.03, %7
  br i1 %exitcond6, label %.loopexit.loopexit, label %8

.loopexit.loopexit:                               ; preds = %._crit_edge
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %0
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!9}

!0 = !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @read_kernel, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint4*", !"uint*", !"uint", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"uint __attribute__((ext_vector_type(4)))*", !"uint*", !"uint", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"", !""}
!6 = !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @write_kernel, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"uint*", !"uint4*", !"uint", !"uint", !"uint"}
!8 = !{!"kernel_arg_base_type", !"uint*", !"uint __attribute__((ext_vector_type(4)))*", !"uint", !"uint", !"uint"}
!9 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!10 = !{!11, !11, i64 0}
!11 = !{!"int", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{!12, !12, i64 0}

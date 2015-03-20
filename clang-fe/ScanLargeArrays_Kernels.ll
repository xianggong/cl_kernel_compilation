; ModuleID = '../kernel-src/ScanLargeArrays_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

@blockAddition.value.0 = internal unnamed_addr addrspace(3) global float undef

; Function Attrs: nounwind
define void @blockAddition(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_group_id(i32 0) #2
  %3 = tail call i32 @get_local_id(i32 0) #2
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %8

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds float addrspace(1)* %input, i32 %2
  %7 = load float addrspace(1)* %6, align 4, !tbaa !19
  store float %7, float addrspace(3)* @blockAddition.value.0, align 4, !tbaa !19
  br label %8

; <label>:8                                       ; preds = %5, %0
  tail call void @barrier(i32 1) #2
  %9 = load float addrspace(3)* @blockAddition.value.0, align 4, !tbaa !19
  %10 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  %11 = load float addrspace(1)* %10, align 4, !tbaa !19
  %12 = fadd float %9, %11
  store float %12, float addrspace(1)* %10, align 4, !tbaa !19
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @ScanLargeArrays(float addrspace(1)* nocapture %output, float addrspace(1)* nocapture readonly %input, float addrspace(3)* nocapture %block, i32 %block_size, float addrspace(1)* nocapture %sumBuffer) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = shl nsw i32 %2, 1
  %5 = getelementptr inbounds float addrspace(1)* %input, i32 %4
  %6 = load float addrspace(1)* %5, align 4, !tbaa !19
  %7 = shl nsw i32 %1, 1
  %8 = getelementptr inbounds float addrspace(3)* %block, i32 %7
  store float %6, float addrspace(3)* %8, align 4, !tbaa !19
  %9 = or i32 %4, 1
  %10 = getelementptr inbounds float addrspace(1)* %input, i32 %9
  %11 = load float addrspace(1)* %10, align 4, !tbaa !19
  %12 = or i32 %7, 1
  %13 = getelementptr inbounds float addrspace(3)* %block, i32 %12
  store float %11, float addrspace(3)* %13, align 4, !tbaa !19
  tail call void @barrier(i32 1) #2
  %14 = load float addrspace(3)* %block, align 4, !tbaa !19
  %15 = icmp ugt i32 %block_size, 1
  br i1 %15, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %16 = getelementptr inbounds float addrspace(3)* %block, i32 1
  %17 = load float addrspace(3)* %16, align 4, !tbaa !19
  %18 = fadd float %14, %17
  br label %19

; <label>:19                                      ; preds = %.lr.ph, %32
  %stride.03 = phi i32 [ 1, %.lr.ph ], [ %33, %32 ]
  %cache1.02 = phi float [ %18, %.lr.ph ], [ %cache1.1, %32 ]
  %cache0.01 = phi float [ %14, %.lr.ph ], [ %cache0.1, %32 ]
  %20 = icmp slt i32 %7, %stride.03
  br i1 %20, label %32, label %21

; <label>:21                                      ; preds = %19
  %22 = sub nsw i32 %7, %stride.03
  %23 = getelementptr inbounds float addrspace(3)* %block, i32 %22
  %24 = load float addrspace(3)* %23, align 4, !tbaa !19
  %25 = load float addrspace(3)* %8, align 4, !tbaa !19
  %26 = fadd float %24, %25
  %27 = sub nsw i32 %12, %stride.03
  %28 = getelementptr inbounds float addrspace(3)* %block, i32 %27
  %29 = load float addrspace(3)* %28, align 4, !tbaa !19
  %30 = load float addrspace(3)* %13, align 4, !tbaa !19
  %31 = fadd float %29, %30
  br label %32

; <label>:32                                      ; preds = %19, %21
  %cache0.1 = phi float [ %26, %21 ], [ %cache0.01, %19 ]
  %cache1.1 = phi float [ %31, %21 ], [ %cache1.02, %19 ]
  tail call void @barrier(i32 1) #2
  store float %cache0.1, float addrspace(3)* %8, align 4, !tbaa !19
  store float %cache1.1, float addrspace(3)* %13, align 4, !tbaa !19
  tail call void @barrier(i32 1) #2
  %33 = shl nsw i32 %stride.03, 1
  %34 = icmp ult i32 %33, %block_size
  br i1 %34, label %19, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %32
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %35 = add i32 %block_size, -1
  %36 = getelementptr inbounds float addrspace(3)* %block, i32 %35
  %37 = load float addrspace(3)* %36, align 4, !tbaa !19
  %38 = getelementptr inbounds float addrspace(1)* %sumBuffer, i32 %3
  store float %37, float addrspace(1)* %38, align 4, !tbaa !19
  %39 = icmp eq i32 %1, 0
  br i1 %39, label %40, label %42

; <label>:40                                      ; preds = %._crit_edge
  %41 = getelementptr inbounds float addrspace(1)* %output, i32 %4
  store float 0.000000e+00, float addrspace(1)* %41, align 4, !tbaa !19
  br label %47

; <label>:42                                      ; preds = %._crit_edge
  %43 = add nsw i32 %7, -1
  %44 = getelementptr inbounds float addrspace(3)* %block, i32 %43
  %45 = load float addrspace(3)* %44, align 4, !tbaa !19
  %46 = getelementptr inbounds float addrspace(1)* %output, i32 %4
  store float %45, float addrspace(1)* %46, align 4, !tbaa !19
  br label %47

; <label>:47                                      ; preds = %42, %40
  %.sink = load float addrspace(3)* %8, align 4
  %48 = getelementptr inbounds float addrspace(1)* %output, i32 %9
  store float %.sink, float addrspace(1)* %48, align 4
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(float addrspace(1)* nocapture %output, float addrspace(1)* nocapture readonly %input, float addrspace(3)* nocapture %block, i32 %block_size) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = shl nsw i32 %2, 1
  %5 = getelementptr inbounds float addrspace(1)* %input, i32 %4
  %6 = load float addrspace(1)* %5, align 4, !tbaa !19
  %7 = shl nsw i32 %1, 1
  %8 = getelementptr inbounds float addrspace(3)* %block, i32 %7
  store float %6, float addrspace(3)* %8, align 4, !tbaa !19
  %9 = or i32 %4, 1
  %10 = getelementptr inbounds float addrspace(1)* %input, i32 %9
  %11 = load float addrspace(1)* %10, align 4, !tbaa !19
  %12 = or i32 %7, 1
  %13 = getelementptr inbounds float addrspace(3)* %block, i32 %12
  store float %11, float addrspace(3)* %13, align 4, !tbaa !19
  tail call void @barrier(i32 1) #2
  %14 = load float addrspace(3)* %block, align 4, !tbaa !19
  %15 = icmp ugt i32 %block_size, 1
  br i1 %15, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %16 = getelementptr inbounds float addrspace(3)* %block, i32 1
  %17 = load float addrspace(3)* %16, align 4, !tbaa !19
  %18 = fadd float %14, %17
  br label %19

; <label>:19                                      ; preds = %.lr.ph, %32
  %stride.03 = phi i32 [ 1, %.lr.ph ], [ %33, %32 ]
  %cache1.02 = phi float [ %18, %.lr.ph ], [ %cache1.1, %32 ]
  %cache0.01 = phi float [ %14, %.lr.ph ], [ %cache0.1, %32 ]
  %20 = icmp slt i32 %7, %stride.03
  br i1 %20, label %32, label %21

; <label>:21                                      ; preds = %19
  %22 = sub nsw i32 %7, %stride.03
  %23 = getelementptr inbounds float addrspace(3)* %block, i32 %22
  %24 = load float addrspace(3)* %23, align 4, !tbaa !19
  %25 = load float addrspace(3)* %8, align 4, !tbaa !19
  %26 = fadd float %24, %25
  %27 = sub nsw i32 %12, %stride.03
  %28 = getelementptr inbounds float addrspace(3)* %block, i32 %27
  %29 = load float addrspace(3)* %28, align 4, !tbaa !19
  %30 = load float addrspace(3)* %13, align 4, !tbaa !19
  %31 = fadd float %29, %30
  br label %32

; <label>:32                                      ; preds = %19, %21
  %cache0.1 = phi float [ %26, %21 ], [ %cache0.01, %19 ]
  %cache1.1 = phi float [ %31, %21 ], [ %cache1.02, %19 ]
  tail call void @barrier(i32 1) #2
  store float %cache0.1, float addrspace(3)* %8, align 4, !tbaa !19
  store float %cache1.1, float addrspace(3)* %13, align 4, !tbaa !19
  tail call void @barrier(i32 1) #2
  %33 = shl nsw i32 %stride.03, 1
  %34 = icmp ult i32 %33, %block_size
  br i1 %34, label %19, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %32
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %35 = icmp eq i32 %1, 0
  br i1 %35, label %36, label %38

; <label>:36                                      ; preds = %._crit_edge
  %37 = getelementptr inbounds float addrspace(1)* %output, i32 %4
  store float 0.000000e+00, float addrspace(1)* %37, align 4, !tbaa !19
  br label %43

; <label>:38                                      ; preds = %._crit_edge
  %39 = add nsw i32 %7, -1
  %40 = getelementptr inbounds float addrspace(3)* %block, i32 %39
  %41 = load float addrspace(3)* %40, align 4, !tbaa !19
  %42 = getelementptr inbounds float addrspace(1)* %output, i32 %4
  store float %41, float addrspace(1)* %42, align 4, !tbaa !19
  br label %43

; <label>:43                                      ; preds = %38, %36
  %.sink = load float addrspace(3)* %8, align 4
  %44 = getelementptr inbounds float addrspace(1)* %output, i32 %9
  store float %.sink, float addrspace(1)* %44, align 4
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6, !12}
!llvm.ident = !{!18}

!0 = !{void (float addrspace(1)*, float addrspace(1)*)* @blockAddition, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, float addrspace(1)*)* @ScanLargeArrays, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0, i32 1}
!8 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"float*", !"float*", !"float*", !"uint", !"float*"}
!10 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*", !"uint", !"float*"}
!11 = !{!"kernel_arg_type_qual", !"", !"", !"", !"const", !""}
!12 = !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32)* @prefixSum, !13, !14, !15, !16, !17}
!13 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0}
!14 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!15 = !{!"kernel_arg_type", !"float*", !"float*", !"float*", !"uint"}
!16 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*", !"uint"}
!17 = !{!"kernel_arg_type_qual", !"", !"", !"", !"const"}
!18 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!19 = !{!20, !20, i64 0}
!20 = !{!"float", !21, i64 0}
!21 = !{!"omnipotent char", !22, i64 0}
!22 = !{!"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/ScanLargeArrays_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@blockAddition.value.0 = internal addrspace(3) unnamed_addr global float 0.000000e+00

; Function Attrs: nounwind
define void @blockAddition(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_group_id(i32 0) #2
  %3 = tail call i32 @get_local_id(i32 0) #2
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %9

; <label>:5                                       ; preds = %0
  %6 = sext i32 %2 to i64
  %7 = getelementptr inbounds float addrspace(1)* %input, i64 %6
  %8 = load float addrspace(1)* %7, align 4, !tbaa !4
  store float %8, float addrspace(3)* @blockAddition.value.0, align 4, !tbaa !4
  br label %9

; <label>:9                                       ; preds = %5, %0
  tail call void @barrier(i32 1) #2
  %10 = load float addrspace(3)* @blockAddition.value.0, align 4, !tbaa !4
  %11 = sext i32 %1 to i64
  %12 = getelementptr inbounds float addrspace(1)* %output, i64 %11
  %13 = load float addrspace(1)* %12, align 4, !tbaa !4
  %14 = fadd float %10, %13
  store float %14, float addrspace(1)* %12, align 4, !tbaa !4
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
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds float addrspace(1)* %input, i64 %5
  %7 = load float addrspace(1)* %6, align 4, !tbaa !4
  %8 = shl nsw i32 %1, 1
  %9 = getelementptr inbounds float addrspace(3)* %block, i32 %8
  store float %7, float addrspace(3)* %9, align 4, !tbaa !4
  %10 = or i32 %4, 1
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds float addrspace(1)* %input, i64 %11
  %13 = load float addrspace(1)* %12, align 4, !tbaa !4
  %14 = or i32 %8, 1
  %15 = getelementptr inbounds float addrspace(3)* %block, i32 %14
  store float %13, float addrspace(3)* %15, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %16 = load float addrspace(3)* %block, align 4, !tbaa !4
  %17 = icmp ugt i32 %block_size, 1
  br i1 %17, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %18 = getelementptr inbounds float addrspace(3)* %block, i32 1
  %19 = load float addrspace(3)* %18, align 4, !tbaa !4
  %20 = fadd float %16, %19
  br label %21

; <label>:21                                      ; preds = %.lr.ph, %34
  %stride.03 = phi i32 [ 1, %.lr.ph ], [ %35, %34 ]
  %cache1.02 = phi float [ %20, %.lr.ph ], [ %cache1.1, %34 ]
  %cache0.01 = phi float [ %16, %.lr.ph ], [ %cache0.1, %34 ]
  %22 = icmp slt i32 %8, %stride.03
  br i1 %22, label %34, label %23

; <label>:23                                      ; preds = %21
  %24 = sub nsw i32 %8, %stride.03
  %25 = getelementptr inbounds float addrspace(3)* %block, i32 %24
  %26 = load float addrspace(3)* %25, align 4, !tbaa !4
  %27 = load float addrspace(3)* %9, align 4, !tbaa !4
  %28 = fadd float %26, %27
  %29 = sub nsw i32 %14, %stride.03
  %30 = getelementptr inbounds float addrspace(3)* %block, i32 %29
  %31 = load float addrspace(3)* %30, align 4, !tbaa !4
  %32 = load float addrspace(3)* %15, align 4, !tbaa !4
  %33 = fadd float %31, %32
  br label %34

; <label>:34                                      ; preds = %21, %23
  %cache0.1 = phi float [ %28, %23 ], [ %cache0.01, %21 ]
  %cache1.1 = phi float [ %33, %23 ], [ %cache1.02, %21 ]
  tail call void @barrier(i32 1) #2
  store float %cache0.1, float addrspace(3)* %9, align 4, !tbaa !4
  store float %cache1.1, float addrspace(3)* %15, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %35 = shl nsw i32 %stride.03, 1
  %36 = icmp ult i32 %35, %block_size
  br i1 %36, label %21, label %._crit_edge

._crit_edge:                                      ; preds = %34, %0
  %37 = add i32 %block_size, -1
  %38 = getelementptr inbounds float addrspace(3)* %block, i32 %37
  %39 = load float addrspace(3)* %38, align 4, !tbaa !4
  %40 = sext i32 %3 to i64
  %41 = getelementptr inbounds float addrspace(1)* %sumBuffer, i64 %40
  store float %39, float addrspace(1)* %41, align 4, !tbaa !4
  %42 = icmp eq i32 %1, 0
  br i1 %42, label %43, label %47

; <label>:43                                      ; preds = %._crit_edge
  %44 = getelementptr inbounds float addrspace(1)* %output, i64 %5
  store float 0.000000e+00, float addrspace(1)* %44, align 4, !tbaa !4
  %45 = load float addrspace(3)* %9, align 4, !tbaa !4
  %46 = getelementptr inbounds float addrspace(1)* %output, i64 %11
  store float %45, float addrspace(1)* %46, align 4, !tbaa !4
  br label %54

; <label>:47                                      ; preds = %._crit_edge
  %48 = add nsw i32 %8, -1
  %49 = getelementptr inbounds float addrspace(3)* %block, i32 %48
  %50 = load float addrspace(3)* %49, align 4, !tbaa !4
  %51 = getelementptr inbounds float addrspace(1)* %output, i64 %5
  store float %50, float addrspace(1)* %51, align 4, !tbaa !4
  %52 = load float addrspace(3)* %9, align 4, !tbaa !4
  %53 = getelementptr inbounds float addrspace(1)* %output, i64 %11
  store float %52, float addrspace(1)* %53, align 4, !tbaa !4
  br label %54

; <label>:54                                      ; preds = %47, %43
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(float addrspace(1)* nocapture %output, float addrspace(1)* nocapture readonly %input, float addrspace(3)* nocapture %block, i32 %block_size) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = shl nsw i32 %2, 1
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds float addrspace(1)* %input, i64 %5
  %7 = load float addrspace(1)* %6, align 4, !tbaa !4
  %8 = shl nsw i32 %1, 1
  %9 = getelementptr inbounds float addrspace(3)* %block, i32 %8
  store float %7, float addrspace(3)* %9, align 4, !tbaa !4
  %10 = or i32 %4, 1
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds float addrspace(1)* %input, i64 %11
  %13 = load float addrspace(1)* %12, align 4, !tbaa !4
  %14 = or i32 %8, 1
  %15 = getelementptr inbounds float addrspace(3)* %block, i32 %14
  store float %13, float addrspace(3)* %15, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %16 = load float addrspace(3)* %block, align 4, !tbaa !4
  %17 = icmp ugt i32 %block_size, 1
  br i1 %17, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %18 = getelementptr inbounds float addrspace(3)* %block, i32 1
  %19 = load float addrspace(3)* %18, align 4, !tbaa !4
  %20 = fadd float %16, %19
  br label %21

; <label>:21                                      ; preds = %.lr.ph, %34
  %stride.03 = phi i32 [ 1, %.lr.ph ], [ %35, %34 ]
  %cache1.02 = phi float [ %20, %.lr.ph ], [ %cache1.1, %34 ]
  %cache0.01 = phi float [ %16, %.lr.ph ], [ %cache0.1, %34 ]
  %22 = icmp slt i32 %8, %stride.03
  br i1 %22, label %34, label %23

; <label>:23                                      ; preds = %21
  %24 = sub nsw i32 %8, %stride.03
  %25 = getelementptr inbounds float addrspace(3)* %block, i32 %24
  %26 = load float addrspace(3)* %25, align 4, !tbaa !4
  %27 = load float addrspace(3)* %9, align 4, !tbaa !4
  %28 = fadd float %26, %27
  %29 = sub nsw i32 %14, %stride.03
  %30 = getelementptr inbounds float addrspace(3)* %block, i32 %29
  %31 = load float addrspace(3)* %30, align 4, !tbaa !4
  %32 = load float addrspace(3)* %15, align 4, !tbaa !4
  %33 = fadd float %31, %32
  br label %34

; <label>:34                                      ; preds = %21, %23
  %cache0.1 = phi float [ %28, %23 ], [ %cache0.01, %21 ]
  %cache1.1 = phi float [ %33, %23 ], [ %cache1.02, %21 ]
  tail call void @barrier(i32 1) #2
  store float %cache0.1, float addrspace(3)* %9, align 4, !tbaa !4
  store float %cache1.1, float addrspace(3)* %15, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %35 = shl nsw i32 %stride.03, 1
  %36 = icmp ult i32 %35, %block_size
  br i1 %36, label %21, label %._crit_edge

._crit_edge:                                      ; preds = %34, %0
  %37 = icmp eq i32 %1, 0
  br i1 %37, label %38, label %42

; <label>:38                                      ; preds = %._crit_edge
  %39 = getelementptr inbounds float addrspace(1)* %output, i64 %5
  store float 0.000000e+00, float addrspace(1)* %39, align 4, !tbaa !4
  %40 = load float addrspace(3)* %9, align 4, !tbaa !4
  %41 = getelementptr inbounds float addrspace(1)* %output, i64 %11
  store float %40, float addrspace(1)* %41, align 4, !tbaa !4
  br label %49

; <label>:42                                      ; preds = %._crit_edge
  %43 = add nsw i32 %8, -1
  %44 = getelementptr inbounds float addrspace(3)* %block, i32 %43
  %45 = load float addrspace(3)* %44, align 4, !tbaa !4
  %46 = getelementptr inbounds float addrspace(1)* %output, i64 %5
  store float %45, float addrspace(1)* %46, align 4, !tbaa !4
  %47 = load float addrspace(3)* %9, align 4, !tbaa !4
  %48 = getelementptr inbounds float addrspace(1)* %output, i64 %11
  store float %47, float addrspace(1)* %48, align 4, !tbaa !4
  br label %49

; <label>:49                                      ; preds = %42, %38
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @blockAddition}
!1 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, float addrspace(1)*)* @ScanLargeArrays}
!2 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32)* @prefixSum}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"float", metadata !6, i64 0}
!6 = metadata !{metadata !"omnipotent char", metadata !7, i64 0}
!7 = metadata !{metadata !"Simple C/C++ TBAA"}

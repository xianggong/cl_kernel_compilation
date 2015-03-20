; ModuleID = '../kernel-src/ScanLargeArrays_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@blockAddition.value.0 = internal unnamed_addr global float 0.000000e+00

; Function Attrs: nounwind uwtable
define void @blockAddition(float* nocapture readonly %input, float* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_group_id(i32 0) #2
  %3 = tail call i64 @get_local_id(i32 0) #2
  %4 = trunc i64 %3 to i32
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %10

; <label>:6                                       ; preds = %0
  %sext1 = shl i64 %2, 32
  %7 = ashr exact i64 %sext1, 32
  %8 = getelementptr inbounds float* %input, i64 %7
  %9 = load float* %8, align 4, !tbaa !4
  store float %9, float* @blockAddition.value.0, align 4, !tbaa !4
  br label %10

; <label>:10                                      ; preds = %6, %0
  tail call void @barrier(i32 1) #2
  %11 = load float* @blockAddition.value.0, align 4, !tbaa !4
  %sext = shl i64 %1, 32
  %12 = ashr exact i64 %sext, 32
  %13 = getelementptr inbounds float* %output, i64 %12
  %14 = load float* %13, align 4, !tbaa !4
  %15 = fadd float %11, %14
  store float %15, float* %13, align 4, !tbaa !4
  ret void
}

declare i64 @get_global_id(i32) #1

declare i64 @get_group_id(i32) #1

declare i64 @get_local_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind uwtable
define void @ScanLargeArrays(float* nocapture %output, float* nocapture readonly %input, float* nocapture %block, i32 %block_size, float* nocapture %sumBuffer) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 0) #2
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_group_id(i32 0) #2
  %6 = shl nsw i32 %4, 1
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds float* %input, i64 %7
  %9 = load float* %8, align 4, !tbaa !4
  %10 = shl nsw i32 %2, 1
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds float* %block, i64 %11
  store float %9, float* %12, align 4, !tbaa !4
  %13 = or i32 %6, 1
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds float* %input, i64 %14
  %16 = load float* %15, align 4, !tbaa !4
  %17 = or i32 %10, 1
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds float* %block, i64 %18
  store float %16, float* %19, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %20 = load float* %block, align 4, !tbaa !4
  %21 = icmp ugt i32 %block_size, 1
  br i1 %21, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %22 = getelementptr inbounds float* %block, i64 1
  %23 = load float* %22, align 4, !tbaa !4
  %24 = fadd float %20, %23
  br label %25

; <label>:25                                      ; preds = %.lr.ph, %40
  %stride.03 = phi i32 [ 1, %.lr.ph ], [ %41, %40 ]
  %cache1.02 = phi float [ %24, %.lr.ph ], [ %cache1.1, %40 ]
  %cache0.01 = phi float [ %20, %.lr.ph ], [ %cache0.1, %40 ]
  %26 = icmp slt i32 %10, %stride.03
  br i1 %26, label %40, label %27

; <label>:27                                      ; preds = %25
  %28 = sub nsw i32 %10, %stride.03
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds float* %block, i64 %29
  %31 = load float* %30, align 4, !tbaa !4
  %32 = load float* %12, align 4, !tbaa !4
  %33 = fadd float %31, %32
  %34 = sub nsw i32 %17, %stride.03
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds float* %block, i64 %35
  %37 = load float* %36, align 4, !tbaa !4
  %38 = load float* %19, align 4, !tbaa !4
  %39 = fadd float %37, %38
  br label %40

; <label>:40                                      ; preds = %25, %27
  %cache0.1 = phi float [ %33, %27 ], [ %cache0.01, %25 ]
  %cache1.1 = phi float [ %39, %27 ], [ %cache1.02, %25 ]
  tail call void @barrier(i32 1) #2
  store float %cache0.1, float* %12, align 4, !tbaa !4
  store float %cache1.1, float* %19, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %41 = shl nsw i32 %stride.03, 1
  %42 = icmp ult i32 %41, %block_size
  br i1 %42, label %25, label %._crit_edge

._crit_edge:                                      ; preds = %40, %0
  %43 = add i32 %block_size, -1
  %44 = zext i32 %43 to i64
  %45 = getelementptr inbounds float* %block, i64 %44
  %46 = load float* %45, align 4, !tbaa !4
  %sext = shl i64 %5, 32
  %47 = ashr exact i64 %sext, 32
  %48 = getelementptr inbounds float* %sumBuffer, i64 %47
  store float %46, float* %48, align 4, !tbaa !4
  %49 = icmp eq i32 %2, 0
  br i1 %49, label %50, label %54

; <label>:50                                      ; preds = %._crit_edge
  %51 = getelementptr inbounds float* %output, i64 %7
  store float 0.000000e+00, float* %51, align 4, !tbaa !4
  %52 = load float* %12, align 4, !tbaa !4
  %53 = getelementptr inbounds float* %output, i64 %14
  store float %52, float* %53, align 4, !tbaa !4
  br label %62

; <label>:54                                      ; preds = %._crit_edge
  %55 = add nsw i32 %10, -1
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds float* %block, i64 %56
  %58 = load float* %57, align 4, !tbaa !4
  %59 = getelementptr inbounds float* %output, i64 %7
  store float %58, float* %59, align 4, !tbaa !4
  %60 = load float* %12, align 4, !tbaa !4
  %61 = getelementptr inbounds float* %output, i64 %14
  store float %60, float* %61, align 4, !tbaa !4
  br label %62

; <label>:62                                      ; preds = %54, %50
  ret void
}

; Function Attrs: nounwind uwtable
define void @prefixSum(float* nocapture %output, float* nocapture readonly %input, float* nocapture %block, i32 %block_size) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 0) #2
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_group_id(i32 0) #2
  %6 = shl nsw i32 %4, 1
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds float* %input, i64 %7
  %9 = load float* %8, align 4, !tbaa !4
  %10 = shl nsw i32 %2, 1
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds float* %block, i64 %11
  store float %9, float* %12, align 4, !tbaa !4
  %13 = or i32 %6, 1
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds float* %input, i64 %14
  %16 = load float* %15, align 4, !tbaa !4
  %17 = or i32 %10, 1
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds float* %block, i64 %18
  store float %16, float* %19, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %20 = load float* %block, align 4, !tbaa !4
  %21 = icmp ugt i32 %block_size, 1
  br i1 %21, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %22 = getelementptr inbounds float* %block, i64 1
  %23 = load float* %22, align 4, !tbaa !4
  %24 = fadd float %20, %23
  br label %25

; <label>:25                                      ; preds = %.lr.ph, %40
  %stride.03 = phi i32 [ 1, %.lr.ph ], [ %41, %40 ]
  %cache1.02 = phi float [ %24, %.lr.ph ], [ %cache1.1, %40 ]
  %cache0.01 = phi float [ %20, %.lr.ph ], [ %cache0.1, %40 ]
  %26 = icmp slt i32 %10, %stride.03
  br i1 %26, label %40, label %27

; <label>:27                                      ; preds = %25
  %28 = sub nsw i32 %10, %stride.03
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds float* %block, i64 %29
  %31 = load float* %30, align 4, !tbaa !4
  %32 = load float* %12, align 4, !tbaa !4
  %33 = fadd float %31, %32
  %34 = sub nsw i32 %17, %stride.03
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds float* %block, i64 %35
  %37 = load float* %36, align 4, !tbaa !4
  %38 = load float* %19, align 4, !tbaa !4
  %39 = fadd float %37, %38
  br label %40

; <label>:40                                      ; preds = %25, %27
  %cache0.1 = phi float [ %33, %27 ], [ %cache0.01, %25 ]
  %cache1.1 = phi float [ %39, %27 ], [ %cache1.02, %25 ]
  tail call void @barrier(i32 1) #2
  store float %cache0.1, float* %12, align 4, !tbaa !4
  store float %cache1.1, float* %19, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %41 = shl nsw i32 %stride.03, 1
  %42 = icmp ult i32 %41, %block_size
  br i1 %42, label %25, label %._crit_edge

._crit_edge:                                      ; preds = %40, %0
  %43 = icmp eq i32 %2, 0
  br i1 %43, label %44, label %48

; <label>:44                                      ; preds = %._crit_edge
  %45 = getelementptr inbounds float* %output, i64 %7
  store float 0.000000e+00, float* %45, align 4, !tbaa !4
  %46 = load float* %12, align 4, !tbaa !4
  %47 = getelementptr inbounds float* %output, i64 %14
  store float %46, float* %47, align 4, !tbaa !4
  br label %56

; <label>:48                                      ; preds = %._crit_edge
  %49 = add nsw i32 %10, -1
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds float* %block, i64 %50
  %52 = load float* %51, align 4, !tbaa !4
  %53 = getelementptr inbounds float* %output, i64 %7
  store float %52, float* %53, align 4, !tbaa !4
  %54 = load float* %12, align 4, !tbaa !4
  %55 = getelementptr inbounds float* %output, i64 %14
  store float %54, float* %55, align 4, !tbaa !4
  br label %56

; <label>:56                                      ; preds = %48, %44
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (float*, float*)* @blockAddition}
!1 = metadata !{void (float*, float*, float*, i32, float*)* @ScanLargeArrays}
!2 = metadata !{void (float*, float*, float*, i32)* @prefixSum}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"float", metadata !6, i64 0}
!6 = metadata !{metadata !"omnipotent char", metadata !7, i64 0}
!7 = metadata !{metadata !"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/PrefixSum_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @group_prefixSum(float* nocapture %output, float* nocapture readonly %input, float* nocapture %block, i32 %length, i32 %idxOffset) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_local_size(i32 0) #2
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_group_id(i32 0) #2
  %6 = trunc i64 %5 to i32
  %7 = mul nsw i32 %6, %4
  %8 = add nsw i32 %7, %2
  %9 = shl nsw i32 %8, 1
  %10 = or i32 %9, 1
  %11 = mul i32 %10, %idxOffset
  %12 = add i32 %11, -1
  %13 = icmp ult i32 %12, %length
  br i1 %13, label %14, label %21

; <label>:14                                      ; preds = %0
  %15 = sext i32 %12 to i64
  %16 = getelementptr inbounds float* %input, i64 %15
  %17 = load float* %16, align 4, !tbaa !3
  %18 = shl nsw i32 %2, 1
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds float* %block, i64 %19
  store float %17, float* %20, align 4, !tbaa !3
  br label %21

; <label>:21                                      ; preds = %14, %0
  %22 = add i32 %12, %idxOffset
  %23 = icmp ult i32 %22, %length
  br i1 %23, label %24, label %32

; <label>:24                                      ; preds = %21
  %25 = zext i32 %22 to i64
  %26 = getelementptr inbounds float* %input, i64 %25
  %27 = load float* %26, align 4, !tbaa !3
  %28 = shl nsw i32 %2, 1
  %29 = or i32 %28, 1
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds float* %block, i64 %30
  store float %27, float* %31, align 4, !tbaa !3
  br label %32

; <label>:32                                      ; preds = %24, %21
  %33 = lshr i32 %length, 1
  %34 = icmp eq i32 %33, 0
  br i1 %34, label %._crit_edge9, label %.lr.ph8

.lr.ph8:                                          ; preds = %32
  %35 = shl nsw i32 %2, 1
  %36 = or i32 %35, 1
  %37 = add nsw i32 %35, 2
  br label %38

; <label>:38                                      ; preds = %.lr.ph8, %52
  %offset.06 = phi i32 [ 1, %.lr.ph8 ], [ %53, %52 ]
  %l.05 = phi i32 [ %33, %.lr.ph8 ], [ %54, %52 ]
  tail call void @barrier(i32 1) #2
  %39 = icmp slt i32 %2, %l.05
  br i1 %39, label %40, label %52

; <label>:40                                      ; preds = %38
  %41 = mul nsw i32 %offset.06, %36
  %42 = add nsw i32 %41, -1
  %43 = mul nsw i32 %offset.06, %37
  %44 = add nsw i32 %43, -1
  %45 = sext i32 %42 to i64
  %46 = getelementptr inbounds float* %block, i64 %45
  %47 = load float* %46, align 4, !tbaa !3
  %48 = sext i32 %44 to i64
  %49 = getelementptr inbounds float* %block, i64 %48
  %50 = load float* %49, align 4, !tbaa !3
  %51 = fadd float %47, %50
  store float %51, float* %49, align 4, !tbaa !3
  br label %52

; <label>:52                                      ; preds = %40, %38
  %53 = shl i32 %offset.06, 1
  %54 = ashr i32 %l.05, 1
  %55 = icmp sgt i32 %54, 0
  br i1 %55, label %38, label %._crit_edge9

._crit_edge9:                                     ; preds = %52, %32
  %offset.0.lcssa = phi i32 [ 1, %32 ], [ %53, %52 ]
  %56 = icmp ult i32 %offset.0.lcssa, %length
  %57 = zext i1 %56 to i32
  %.offset.0 = shl i32 %offset.0.lcssa, %57
  %58 = ashr i32 %.offset.0, 1
  %59 = icmp sgt i32 %58, 0
  br i1 %59, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %._crit_edge9
  %60 = add nsw i32 %2, 1
  br label %61

; <label>:61                                      ; preds = %.lr.ph, %77
  %offset.24 = phi i32 [ %.offset.0, %.lr.ph ], [ %63, %77 ]
  %d.03 = phi i32 [ 0, %.lr.ph ], [ %78, %77 ]
  %62 = or i32 %d.03, 1
  %63 = ashr i32 %offset.24, 1
  tail call void @barrier(i32 1) #2
  %64 = icmp slt i32 %2, %62
  br i1 %64, label %65, label %77

; <label>:65                                      ; preds = %61
  %66 = mul nsw i32 %63, %60
  %67 = add nsw i32 %66, -1
  %68 = ashr i32 %offset.24, 2
  %69 = add nsw i32 %67, %68
  %70 = sext i32 %67 to i64
  %71 = getelementptr inbounds float* %block, i64 %70
  %72 = load float* %71, align 4, !tbaa !3
  %73 = sext i32 %69 to i64
  %74 = getelementptr inbounds float* %block, i64 %73
  %75 = load float* %74, align 4, !tbaa !3
  %76 = fadd float %72, %75
  store float %76, float* %74, align 4, !tbaa !3
  br label %77

; <label>:77                                      ; preds = %61, %65
  %78 = shl i32 %62, 1
  %79 = icmp slt i32 %78, %58
  br i1 %79, label %61, label %._crit_edge

._crit_edge:                                      ; preds = %77, %._crit_edge9
  tail call void @barrier(i32 1) #2
  br i1 %13, label %80, label %87

; <label>:80                                      ; preds = %._crit_edge
  %81 = shl nsw i32 %2, 1
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds float* %block, i64 %82
  %84 = load float* %83, align 4, !tbaa !3
  %85 = sext i32 %12 to i64
  %86 = getelementptr inbounds float* %output, i64 %85
  store float %84, float* %86, align 4, !tbaa !3
  br label %87

; <label>:87                                      ; preds = %80, %._crit_edge
  br i1 %23, label %88, label %96

; <label>:88                                      ; preds = %87
  %89 = shl nsw i32 %2, 1
  %90 = or i32 %89, 1
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds float* %block, i64 %91
  %93 = load float* %92, align 4, !tbaa !3
  %94 = zext i32 %22 to i64
  %95 = getelementptr inbounds float* %output, i64 %94
  store float %93, float* %95, align 4, !tbaa !3
  br label %96

; <label>:96                                      ; preds = %88, %87
  ret void
}

declare i64 @get_local_id(i32) #1

declare i64 @get_local_size(i32) #1

declare i64 @get_group_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind uwtable
define void @global_prefixSum(float* nocapture %buffer, i32 %offset, i32 %length) #0 {
  %1 = tail call i64 @get_local_size(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_group_id(i32 0) #2
  %4 = trunc i64 %3 to i32
  %5 = udiv i32 %offset, %2
  %6 = shl i32 %offset, 1
  %7 = sub i32 %6, %5
  %8 = udiv i32 %4, %7
  %9 = add i32 %8, 1
  %10 = mul i32 %9, %5
  %11 = add i32 %10, %4
  %12 = mul nsw i32 %11, %2
  %13 = zext i32 %12 to i64
  %14 = tail call i64 @get_local_id(i32 0) #2
  %15 = add i64 %13, %14
  %16 = trunc i64 %15 to i32
  %17 = add nsw i32 %16, 1
  %18 = urem i32 %17, %offset
  %19 = icmp ne i32 %18, 0
  %20 = icmp ult i32 %16, %length
  %or.cond = and i1 %19, %20
  br i1 %or.cond, label %21, label %31

; <label>:21                                      ; preds = %0
  %22 = urem i32 %16, %offset
  %.neg1 = add i32 %16, -1
  %23 = sub i32 %.neg1, %22
  %24 = zext i32 %23 to i64
  %25 = getelementptr inbounds float* %buffer, i64 %24
  %26 = load float* %25, align 4, !tbaa !3
  %sext = shl i64 %15, 32
  %27 = ashr exact i64 %sext, 32
  %28 = getelementptr inbounds float* %buffer, i64 %27
  %29 = load float* %28, align 4, !tbaa !3
  %30 = fadd float %26, %29
  store float %30, float* %28, align 4, !tbaa !3
  br label %31

; <label>:31                                      ; preds = %0, %21
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float*, float*, float*, i32, i32)* @group_prefixSum}
!1 = metadata !{void (float*, i32, i32)* @global_prefixSum}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"float", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}

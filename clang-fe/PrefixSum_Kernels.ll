; ModuleID = '../kernel-src/PrefixSum_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @group_prefixSum(float addrspace(1)* nocapture %output, float addrspace(1)* nocapture readonly %input, float addrspace(3)* nocapture %block, i32 %length, i32 %idxOffset) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_local_size(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = mul nsw i32 %3, %2
  %5 = add nsw i32 %4, %1
  %6 = shl nsw i32 %5, 1
  %7 = or i32 %6, 1
  %8 = mul i32 %7, %idxOffset
  %9 = add i32 %8, -1
  %10 = icmp ult i32 %9, %length
  br i1 %10, label %11, label %17

; <label>:11                                      ; preds = %0
  %12 = sext i32 %9 to i64
  %13 = getelementptr inbounds float addrspace(1)* %input, i64 %12
  %14 = load float addrspace(1)* %13, align 4, !tbaa !3
  %15 = shl nsw i32 %1, 1
  %16 = getelementptr inbounds float addrspace(3)* %block, i32 %15
  store float %14, float addrspace(3)* %16, align 4, !tbaa !3
  br label %17

; <label>:17                                      ; preds = %11, %0
  %18 = add i32 %9, %idxOffset
  %19 = icmp ult i32 %18, %length
  br i1 %19, label %20, label %27

; <label>:20                                      ; preds = %17
  %21 = sext i32 %18 to i64
  %22 = getelementptr inbounds float addrspace(1)* %input, i64 %21
  %23 = load float addrspace(1)* %22, align 4, !tbaa !3
  %24 = shl nsw i32 %1, 1
  %25 = or i32 %24, 1
  %26 = getelementptr inbounds float addrspace(3)* %block, i32 %25
  store float %23, float addrspace(3)* %26, align 4, !tbaa !3
  br label %27

; <label>:27                                      ; preds = %20, %17
  %28 = lshr i32 %length, 1
  %29 = icmp eq i32 %28, 0
  br i1 %29, label %._crit_edge9, label %.lr.ph8

.lr.ph8:                                          ; preds = %27
  %30 = shl nsw i32 %1, 1
  %31 = or i32 %30, 1
  %32 = add nsw i32 %30, 2
  br label %33

; <label>:33                                      ; preds = %.lr.ph8, %45
  %offset.06 = phi i32 [ 1, %.lr.ph8 ], [ %46, %45 ]
  %l.05 = phi i32 [ %28, %.lr.ph8 ], [ %47, %45 ]
  tail call void @barrier(i32 1) #2
  %34 = icmp slt i32 %1, %l.05
  br i1 %34, label %35, label %45

; <label>:35                                      ; preds = %33
  %36 = mul nsw i32 %offset.06, %31
  %37 = add nsw i32 %36, -1
  %38 = mul nsw i32 %offset.06, %32
  %39 = add nsw i32 %38, -1
  %40 = getelementptr inbounds float addrspace(3)* %block, i32 %37
  %41 = load float addrspace(3)* %40, align 4, !tbaa !3
  %42 = getelementptr inbounds float addrspace(3)* %block, i32 %39
  %43 = load float addrspace(3)* %42, align 4, !tbaa !3
  %44 = fadd float %41, %43
  store float %44, float addrspace(3)* %42, align 4, !tbaa !3
  br label %45

; <label>:45                                      ; preds = %35, %33
  %46 = shl i32 %offset.06, 1
  %47 = ashr i32 %l.05, 1
  %48 = icmp sgt i32 %47, 0
  br i1 %48, label %33, label %._crit_edge9

._crit_edge9:                                     ; preds = %45, %27
  %offset.0.lcssa = phi i32 [ 1, %27 ], [ %46, %45 ]
  %49 = icmp ult i32 %offset.0.lcssa, %length
  %50 = zext i1 %49 to i32
  %.offset.0 = shl i32 %offset.0.lcssa, %50
  %51 = ashr i32 %.offset.0, 1
  %52 = icmp sgt i32 %51, 0
  br i1 %52, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %._crit_edge9
  %53 = add nsw i32 %1, 1
  br label %54

; <label>:54                                      ; preds = %.lr.ph, %68
  %offset.24 = phi i32 [ %.offset.0, %.lr.ph ], [ %56, %68 ]
  %d.03 = phi i32 [ 0, %.lr.ph ], [ %69, %68 ]
  %55 = or i32 %d.03, 1
  %56 = ashr i32 %offset.24, 1
  tail call void @barrier(i32 1) #2
  %57 = icmp slt i32 %1, %55
  br i1 %57, label %58, label %68

; <label>:58                                      ; preds = %54
  %59 = mul nsw i32 %56, %53
  %60 = add nsw i32 %59, -1
  %61 = ashr i32 %offset.24, 2
  %62 = add nsw i32 %60, %61
  %63 = getelementptr inbounds float addrspace(3)* %block, i32 %60
  %64 = load float addrspace(3)* %63, align 4, !tbaa !3
  %65 = getelementptr inbounds float addrspace(3)* %block, i32 %62
  %66 = load float addrspace(3)* %65, align 4, !tbaa !3
  %67 = fadd float %64, %66
  store float %67, float addrspace(3)* %65, align 4, !tbaa !3
  br label %68

; <label>:68                                      ; preds = %54, %58
  %69 = shl i32 %55, 1
  %70 = icmp slt i32 %69, %51
  br i1 %70, label %54, label %._crit_edge

._crit_edge:                                      ; preds = %68, %._crit_edge9
  tail call void @barrier(i32 1) #2
  br i1 %10, label %71, label %77

; <label>:71                                      ; preds = %._crit_edge
  %72 = shl nsw i32 %1, 1
  %73 = getelementptr inbounds float addrspace(3)* %block, i32 %72
  %74 = load float addrspace(3)* %73, align 4, !tbaa !3
  %75 = sext i32 %9 to i64
  %76 = getelementptr inbounds float addrspace(1)* %output, i64 %75
  store float %74, float addrspace(1)* %76, align 4, !tbaa !3
  br label %77

; <label>:77                                      ; preds = %71, %._crit_edge
  br i1 %19, label %78, label %85

; <label>:78                                      ; preds = %77
  %79 = shl nsw i32 %1, 1
  %80 = or i32 %79, 1
  %81 = getelementptr inbounds float addrspace(3)* %block, i32 %80
  %82 = load float addrspace(3)* %81, align 4, !tbaa !3
  %83 = sext i32 %18 to i64
  %84 = getelementptr inbounds float addrspace(1)* %output, i64 %83
  store float %82, float addrspace(1)* %84, align 4, !tbaa !3
  br label %85

; <label>:85                                      ; preds = %78, %77
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_local_size(i32) #1

declare i32 @get_group_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @global_prefixSum(float addrspace(1)* nocapture %buffer, i32 %offset, i32 %length) #0 {
  %1 = tail call i32 @get_local_size(i32 0) #2
  %2 = tail call i32 @get_group_id(i32 0) #2
  %3 = udiv i32 %offset, %1
  %4 = shl i32 %offset, 1
  %5 = sub i32 %4, %3
  %6 = udiv i32 %2, %5
  %7 = add i32 %6, 1
  %8 = mul i32 %7, %3
  %9 = add i32 %8, %2
  %10 = mul nsw i32 %9, %1
  %11 = tail call i32 @get_local_id(i32 0) #2
  %12 = add i32 %10, %11
  %13 = add nsw i32 %12, 1
  %14 = urem i32 %13, %offset
  %15 = icmp ne i32 %14, 0
  %16 = icmp ult i32 %12, %length
  %or.cond = and i1 %15, %16
  br i1 %or.cond, label %17, label %27

; <label>:17                                      ; preds = %0
  %18 = urem i32 %12, %offset
  %.neg1 = add i32 %12, -1
  %19 = sub i32 %.neg1, %18
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds float addrspace(1)* %buffer, i64 %20
  %22 = load float addrspace(1)* %21, align 4, !tbaa !3
  %23 = sext i32 %12 to i64
  %24 = getelementptr inbounds float addrspace(1)* %buffer, i64 %23
  %25 = load float addrspace(1)* %24, align 4, !tbaa !3
  %26 = fadd float %22, %25
  store float %26, float addrspace(1)* %24, align 4, !tbaa !3
  br label %27

; <label>:27                                      ; preds = %0, %17
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32)* @group_prefixSum}
!1 = metadata !{void (float addrspace(1)*, i32, i32)* @global_prefixSum}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"float", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}

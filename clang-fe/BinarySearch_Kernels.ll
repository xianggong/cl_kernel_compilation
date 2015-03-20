; ModuleID = '../kernel-src/BinarySearch_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @binarySearch(<4 x i32>* nocapture %outputArray, i32* nocapture readonly %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = mul i32 %2, %subdivSize
  %4 = add i32 %3, %globalLowerIndex
  %5 = zext i32 %4 to i64
  %6 = getelementptr inbounds i32* %sortedArray, i64 %5
  %7 = load i32* %6, align 4, !tbaa !4
  %8 = icmp ugt i32 %7, %findMe
  br i1 %8, label %22, label %9

; <label>:9                                       ; preds = %0
  %10 = add i32 %2, 1
  %11 = mul i32 %10, %subdivSize
  %12 = add i32 %globalLowerIndex, -1
  %13 = add i32 %12, %11
  %14 = zext i32 %13 to i64
  %15 = getelementptr inbounds i32* %sortedArray, i64 %14
  %16 = load i32* %15, align 4, !tbaa !4
  %17 = icmp ult i32 %16, %findMe
  br i1 %17, label %22, label %18

; <label>:18                                      ; preds = %9
  %19 = load <4 x i32>* %outputArray, align 16
  %20 = insertelement <4 x i32> %19, i32 %2, i32 0
  %21 = insertelement <4 x i32> %20, i32 1, i32 3
  store <4 x i32> %21, <4 x i32>* %outputArray, align 16
  br label %22

; <label>:22                                      ; preds = %0, %9, %18
  ret void
}

declare i64 @get_global_id(i32) #1

; Function Attrs: nounwind uwtable
define void @binarySearch_mulkeys(i32* nocapture readonly %keys, i32* nocapture readonly %input, i32 %numKeys, i32* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = shl nsw i32 %2, 8
  %4 = icmp eq i32 %numKeys, 0
  br i1 %4, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %0
  %5 = or i32 %3, 255
  %6 = sext i32 %3 to i64
  %7 = getelementptr inbounds i32* %input, i64 %6
  %8 = sext i32 %5 to i64
  %9 = getelementptr inbounds i32* %input, i64 %8
  br label %10

; <label>:10                                      ; preds = %20, %.lr.ph
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %20 ]
  %11 = getelementptr inbounds i32* %keys, i64 %indvars.iv
  %12 = load i32* %11, align 4, !tbaa !4
  %13 = load i32* %7, align 4, !tbaa !4
  %14 = icmp ult i32 %12, %13
  br i1 %14, label %20, label %15

; <label>:15                                      ; preds = %10
  %16 = load i32* %9, align 4, !tbaa !4
  %17 = icmp ugt i32 %12, %16
  br i1 %17, label %20, label %18

; <label>:18                                      ; preds = %15
  %19 = getelementptr inbounds i32* %output, i64 %indvars.iv
  store i32 %3, i32* %19, align 4, !tbaa !4
  br label %20

; <label>:20                                      ; preds = %15, %10, %18
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %numKeys
  br i1 %exitcond, label %._crit_edge, label %10

._crit_edge:                                      ; preds = %20, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @binarySearch_mulkeysConcurrent(i32* nocapture readonly %keys, i32* nocapture readonly %input, i32 %inputSize, i32 %numSubdivisions, i32* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = zext i32 %numSubdivisions to i64
  %3 = urem i64 %1, %2
  %4 = udiv i32 %inputSize, %numSubdivisions
  %5 = zext i32 %4 to i64
  %6 = mul i64 %5, %3
  %7 = trunc i64 %6 to i32
  %8 = add i32 %7, %4
  %9 = tail call i64 @get_global_id(i32 0) #2
  %10 = udiv i64 %9, %2
  %11 = getelementptr inbounds i32* %keys, i64 %10
  %12 = load i32* %11, align 4, !tbaa !4
  %13 = icmp slt i32 %8, %7
  br i1 %13, label %.loopexit, label %.lr.ph

.lr.ph:                                           ; preds = %0, %.outer
  %lBound.0.ph6 = phi i32 [ %lBound.04, %.outer ], [ %7, %0 ]
  %uBound.0.ph5 = phi i32 [ %30, %.outer ], [ %8, %0 ]
  br label %16

; <label>:14                                      ; preds = %27
  %15 = icmp slt i32 %uBound.0.ph5, %29
  br i1 %15, label %.loopexit, label %16

; <label>:16                                      ; preds = %.lr.ph, %14
  %lBound.04 = phi i32 [ %lBound.0.ph6, %.lr.ph ], [ %29, %14 ]
  %17 = add nsw i32 %lBound.04, %uBound.0.ph5
  %18 = sdiv i32 %17, 2
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds i32* %input, i64 %19
  %21 = load i32* %20, align 4, !tbaa !4
  %22 = icmp eq i32 %21, %12
  br i1 %22, label %23, label %27

; <label>:23                                      ; preds = %16
  %24 = tail call i64 @get_global_id(i32 0) #2
  %25 = udiv i64 %24, %2
  %26 = getelementptr inbounds i32* %output, i64 %25
  store i32 %18, i32* %26, align 4, !tbaa !4
  br label %.loopexit

; <label>:27                                      ; preds = %16
  %28 = icmp ugt i32 %21, %12
  %29 = add nsw i32 %18, 1
  br i1 %28, label %.outer, label %14

.outer:                                           ; preds = %27
  %30 = add nsw i32 %18, -1
  %31 = icmp sgt i32 %18, %lBound.04
  br i1 %31, label %.lr.ph, label %.loopexit

.loopexit:                                        ; preds = %14, %.outer, %0, %23
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (<4 x i32>*, i32*, i32, i32, i32)* @binarySearch}
!1 = metadata !{void (i32*, i32*, i32, i32*)* @binarySearch_mulkeys}
!2 = metadata !{void (i32*, i32*, i32, i32, i32*)* @binarySearch_mulkeysConcurrent}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"int", metadata !6, i64 0}
!6 = metadata !{metadata !"omnipotent char", metadata !7, i64 0}
!7 = metadata !{metadata !"Simple C/C++ TBAA"}

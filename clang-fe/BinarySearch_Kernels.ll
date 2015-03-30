; ModuleID = '../kernel-src/BinarySearch_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @binarySearch(<4 x i32> addrspace(1)* nocapture %outputArray, i32 addrspace(1)* nocapture readonly %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = mul i32 %1, %subdivSize
  %3 = add i32 %2, %globalLowerIndex
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds i32 addrspace(1)* %sortedArray, i64 %4
  %6 = load i32 addrspace(1)* %5, align 4, !tbaa !4
  %7 = icmp ugt i32 %6, %findMe
  br i1 %7, label %21, label %8

; <label>:8                                       ; preds = %0
  %9 = add i32 %1, 1
  %10 = mul i32 %9, %subdivSize
  %11 = add i32 %globalLowerIndex, -1
  %12 = add i32 %11, %10
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds i32 addrspace(1)* %sortedArray, i64 %13
  %15 = load i32 addrspace(1)* %14, align 4, !tbaa !4
  %16 = icmp ult i32 %15, %findMe
  br i1 %16, label %21, label %17

; <label>:17                                      ; preds = %8
  %18 = load <4 x i32> addrspace(1)* %outputArray, align 16
  %19 = insertelement <4 x i32> %18, i32 %1, i32 0
  %20 = insertelement <4 x i32> %19, i32 1, i32 3
  store <4 x i32> %20, <4 x i32> addrspace(1)* %outputArray, align 16
  br label %21

; <label>:21                                      ; preds = %0, %8, %17
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind
define void @binarySearch_mulkeys(i32 addrspace(1)* nocapture readonly %keys, i32 addrspace(1)* nocapture readonly %input, i32 %numKeys, i32 addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = shl nsw i32 %1, 8
  %3 = icmp eq i32 %numKeys, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %0
  %4 = or i32 %2, 255
  %5 = sext i32 %2 to i64
  %6 = getelementptr inbounds i32 addrspace(1)* %input, i64 %5
  %7 = sext i32 %4 to i64
  %8 = getelementptr inbounds i32 addrspace(1)* %input, i64 %7
  br label %9

; <label>:9                                       ; preds = %19, %.lr.ph
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %19 ]
  %10 = getelementptr inbounds i32 addrspace(1)* %keys, i64 %indvars.iv
  %11 = load i32 addrspace(1)* %10, align 4, !tbaa !4
  %12 = load i32 addrspace(1)* %6, align 4, !tbaa !4
  %13 = icmp ult i32 %11, %12
  br i1 %13, label %19, label %14

; <label>:14                                      ; preds = %9
  %15 = load i32 addrspace(1)* %8, align 4, !tbaa !4
  %16 = icmp ugt i32 %11, %15
  br i1 %16, label %19, label %17

; <label>:17                                      ; preds = %14
  %18 = getelementptr inbounds i32 addrspace(1)* %output, i64 %indvars.iv
  store i32 %2, i32 addrspace(1)* %18, align 4, !tbaa !4
  br label %19

; <label>:19                                      ; preds = %14, %9, %17
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %numKeys
  br i1 %exitcond, label %._crit_edge, label %9

._crit_edge:                                      ; preds = %19, %0
  ret void
}

; Function Attrs: nounwind
define void @binarySearch_mulkeysConcurrent(i32 addrspace(1)* nocapture readonly %keys, i32 addrspace(1)* nocapture readonly %input, i32 %inputSize, i32 %numSubdivisions, i32 addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = urem i32 %1, %numSubdivisions
  %3 = udiv i32 %inputSize, %numSubdivisions
  %4 = mul i32 %3, %2
  %5 = add i32 %4, %3
  %6 = tail call i32 @get_global_id(i32 0) #2
  %7 = udiv i32 %6, %numSubdivisions
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds i32 addrspace(1)* %keys, i64 %8
  %10 = load i32 addrspace(1)* %9, align 4, !tbaa !4
  %11 = icmp slt i32 %5, %4
  br i1 %11, label %.loopexit, label %.lr.ph

.lr.ph:                                           ; preds = %0, %.outer
  %lBound.0.ph6 = phi i32 [ %lBound.04, %.outer ], [ %4, %0 ]
  %uBound.0.ph5 = phi i32 [ %29, %.outer ], [ %5, %0 ]
  br label %14

; <label>:12                                      ; preds = %26
  %13 = icmp slt i32 %uBound.0.ph5, %28
  br i1 %13, label %.loopexit, label %14

; <label>:14                                      ; preds = %.lr.ph, %12
  %lBound.04 = phi i32 [ %lBound.0.ph6, %.lr.ph ], [ %28, %12 ]
  %15 = add nsw i32 %lBound.04, %uBound.0.ph5
  %16 = sdiv i32 %15, 2
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i32 addrspace(1)* %input, i64 %17
  %19 = load i32 addrspace(1)* %18, align 4, !tbaa !4
  %20 = icmp eq i32 %19, %10
  br i1 %20, label %21, label %26

; <label>:21                                      ; preds = %14
  %22 = tail call i32 @get_global_id(i32 0) #2
  %23 = udiv i32 %22, %numSubdivisions
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds i32 addrspace(1)* %output, i64 %24
  store i32 %16, i32 addrspace(1)* %25, align 4, !tbaa !4
  br label %.loopexit

; <label>:26                                      ; preds = %14
  %27 = icmp ugt i32 %19, %10
  %28 = add nsw i32 %16, 1
  br i1 %27, label %.outer, label %12

.outer:                                           ; preds = %26
  %29 = add nsw i32 %16, -1
  %30 = icmp sgt i32 %16, %lBound.04
  br i1 %30, label %.lr.ph, label %.loopexit

.loopexit:                                        ; preds = %12, %.outer, %0, %21
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @binarySearch}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(1)*)* @binarySearch_mulkeys}
!2 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32, i32 addrspace(1)*)* @binarySearch_mulkeysConcurrent}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"int", metadata !6, i64 0}
!6 = metadata !{metadata !"omnipotent char", metadata !7, i64 0}
!7 = metadata !{metadata !"Simple C/C++ TBAA"}

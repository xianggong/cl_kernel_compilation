; ModuleID = '../kernel-src/BinarySearch_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @binarySearch(<4 x i32> addrspace(1)* nocapture %outputArray, i32 addrspace(1)* nocapture readonly %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = mul i32 %1, %subdivSize
  %3 = add i32 %2, %globalLowerIndex
  %4 = getelementptr inbounds i32 addrspace(1)* %sortedArray, i32 %3
  %5 = load i32 addrspace(1)* %4, align 4, !tbaa !18
  %6 = icmp ugt i32 %5, %findMe
  br i1 %6, label %19, label %7

; <label>:7                                       ; preds = %0
  %8 = add i32 %1, 1
  %9 = mul i32 %8, %subdivSize
  %10 = add i32 %globalLowerIndex, -1
  %11 = add i32 %10, %9
  %12 = getelementptr inbounds i32 addrspace(1)* %sortedArray, i32 %11
  %13 = load i32 addrspace(1)* %12, align 4, !tbaa !18
  %14 = icmp ult i32 %13, %findMe
  br i1 %14, label %19, label %15

; <label>:15                                      ; preds = %7
  %16 = load <4 x i32> addrspace(1)* %outputArray, align 16
  %17 = insertelement <4 x i32> %16, i32 %1, i32 0
  %18 = insertelement <4 x i32> %17, i32 1, i32 3
  store <4 x i32> %18, <4 x i32> addrspace(1)* %outputArray, align 16
  br label %19

; <label>:19                                      ; preds = %0, %7, %15
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
  %5 = getelementptr inbounds i32 addrspace(1)* %input, i32 %2
  %6 = getelementptr inbounds i32 addrspace(1)* %input, i32 %4
  %7 = add i32 %numKeys, -1
  br label %8

; <label>:8                                       ; preds = %18, %.lr.ph
  %i.01 = phi i32 [ 0, %.lr.ph ], [ %19, %18 ]
  %9 = getelementptr inbounds i32 addrspace(1)* %keys, i32 %i.01
  %10 = load i32 addrspace(1)* %9, align 4, !tbaa !18
  %11 = load i32 addrspace(1)* %5, align 4, !tbaa !18
  %12 = icmp ult i32 %10, %11
  br i1 %12, label %18, label %13

; <label>:13                                      ; preds = %8
  %14 = load i32 addrspace(1)* %6, align 4, !tbaa !18
  %15 = icmp ugt i32 %10, %14
  br i1 %15, label %18, label %16

; <label>:16                                      ; preds = %13
  %17 = getelementptr inbounds i32 addrspace(1)* %output, i32 %i.01
  store i32 %2, i32 addrspace(1)* %17, align 4, !tbaa !18
  br label %18

; <label>:18                                      ; preds = %13, %8, %16
  %19 = add nuw nsw i32 %i.01, 1
  %exitcond = icmp eq i32 %i.01, %7
  br i1 %exitcond, label %._crit_edge.loopexit, label %8

._crit_edge.loopexit:                             ; preds = %18
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
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
  %8 = getelementptr inbounds i32 addrspace(1)* %keys, i32 %7
  %9 = load i32 addrspace(1)* %8, align 4, !tbaa !18
  %10 = icmp slt i32 %5, %4
  br i1 %10, label %.loopexit, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %lBound.0.ph6 = phi i32 [ %lBound.04.lcssa17, %.outer ], [ %4, %.lr.ph.preheader ]
  %uBound.0.ph5 = phi i32 [ %23, %.outer ], [ %5, %.lr.ph.preheader ]
  br label %11

; <label>:11                                      ; preds = %.lr.ph, %25
  %lBound.04 = phi i32 [ %lBound.0.ph6, %.lr.ph ], [ %26, %25 ]
  %12 = add nsw i32 %lBound.04, %uBound.0.ph5
  %13 = sdiv i32 %12, 2
  %14 = getelementptr inbounds i32 addrspace(1)* %input, i32 %13
  %15 = load i32 addrspace(1)* %14, align 4, !tbaa !18
  %16 = icmp eq i32 %15, %9
  br i1 %16, label %17, label %21

; <label>:17                                      ; preds = %11
  %.lcssa = phi i32 [ %13, %11 ]
  %18 = tail call i32 @get_global_id(i32 0) #2
  %19 = udiv i32 %18, %numSubdivisions
  %20 = getelementptr inbounds i32 addrspace(1)* %output, i32 %19
  store i32 %.lcssa, i32 addrspace(1)* %20, align 4, !tbaa !18
  br label %.loopexit

; <label>:21                                      ; preds = %11
  %22 = icmp ugt i32 %15, %9
  br i1 %22, label %.outer, label %25

.outer:                                           ; preds = %21
  %.lcssa19 = phi i32 [ %13, %21 ]
  %lBound.04.lcssa17 = phi i32 [ %lBound.04, %21 ]
  %23 = add nsw i32 %.lcssa19, -1
  %24 = icmp sgt i32 %.lcssa19, %lBound.04.lcssa17
  br i1 %24, label %.lr.ph, label %.loopexit.loopexit16

; <label>:25                                      ; preds = %21
  %26 = add nsw i32 %13, 1
  %27 = icmp slt i32 %uBound.0.ph5, %26
  br i1 %27, label %.loopexit.loopexit, label %11

.loopexit.loopexit:                               ; preds = %25
  br label %.loopexit

.loopexit.loopexit16:                             ; preds = %.outer
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit16, %.loopexit.loopexit, %0, %17
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6, !12}
!llvm.ident = !{!17}

!0 = !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @binarySearch, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint4*", !"uint*", !"uint", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"uint __attribute__((ext_vector_type(4)))*", !"uint*", !"uint", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"const", !"const", !"const"}
!6 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(1)*)* @binarySearch_mulkeys, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 1}
!8 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"int*", !"uint*", !"uint", !"int*"}
!10 = !{!"kernel_arg_base_type", !"int*", !"uint*", !"uint", !"int*"}
!11 = !{!"kernel_arg_type_qual", !"", !"", !"const", !""}
!12 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32, i32 addrspace(1)*)* @binarySearch_mulkeysConcurrent, !13, !2, !14, !15, !16}
!13 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 1}
!14 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint", !"uint", !"int*"}
!15 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint", !"uint", !"int*"}
!16 = !{!"kernel_arg_type_qual", !"", !"", !"const", !"const", !""}
!17 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!18 = !{!19, !19, i64 0}
!19 = !{!"int", !20, i64 0}
!20 = !{!"omnipotent char", !21, i64 0}
!21 = !{!"Simple C/C++ TBAA"}

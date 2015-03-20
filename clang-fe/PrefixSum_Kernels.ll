; ModuleID = '../kernel-src/PrefixSum_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

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
  br i1 %10, label %11, label %16

; <label>:11                                      ; preds = %0
  %12 = getelementptr inbounds float addrspace(1)* %input, i32 %9
  %13 = load float addrspace(1)* %12, align 4, !tbaa !13
  %14 = shl nsw i32 %1, 1
  %15 = getelementptr inbounds float addrspace(3)* %block, i32 %14
  store float %13, float addrspace(3)* %15, align 4, !tbaa !13
  br label %16

; <label>:16                                      ; preds = %11, %0
  %17 = add i32 %9, %idxOffset
  %18 = icmp ult i32 %17, %length
  br i1 %18, label %19, label %25

; <label>:19                                      ; preds = %16
  %20 = getelementptr inbounds float addrspace(1)* %input, i32 %17
  %21 = load float addrspace(1)* %20, align 4, !tbaa !13
  %22 = shl nsw i32 %1, 1
  %23 = or i32 %22, 1
  %24 = getelementptr inbounds float addrspace(3)* %block, i32 %23
  store float %21, float addrspace(3)* %24, align 4, !tbaa !13
  br label %25

; <label>:25                                      ; preds = %19, %16
  %26 = lshr i32 %length, 1
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %._crit_edge9, label %.lr.ph8

.lr.ph8:                                          ; preds = %25
  %28 = shl nsw i32 %1, 1
  %29 = or i32 %28, 1
  %30 = add nsw i32 %28, 2
  br label %31

; <label>:31                                      ; preds = %.lr.ph8, %43
  %offset.06 = phi i32 [ 1, %.lr.ph8 ], [ %44, %43 ]
  %l.05 = phi i32 [ %26, %.lr.ph8 ], [ %45, %43 ]
  tail call void @barrier(i32 1) #2
  %32 = icmp slt i32 %1, %l.05
  br i1 %32, label %33, label %43

; <label>:33                                      ; preds = %31
  %34 = mul nsw i32 %offset.06, %29
  %35 = add nsw i32 %34, -1
  %36 = mul nsw i32 %offset.06, %30
  %37 = add nsw i32 %36, -1
  %38 = getelementptr inbounds float addrspace(3)* %block, i32 %35
  %39 = load float addrspace(3)* %38, align 4, !tbaa !13
  %40 = getelementptr inbounds float addrspace(3)* %block, i32 %37
  %41 = load float addrspace(3)* %40, align 4, !tbaa !13
  %42 = fadd float %39, %41
  store float %42, float addrspace(3)* %40, align 4, !tbaa !13
  br label %43

; <label>:43                                      ; preds = %33, %31
  %44 = shl i32 %offset.06, 1
  %45 = ashr i32 %l.05, 1
  %46 = icmp sgt i32 %45, 0
  br i1 %46, label %31, label %._crit_edge9.loopexit

._crit_edge9.loopexit:                            ; preds = %43
  %.lcssa = phi i32 [ %44, %43 ]
  br label %._crit_edge9

._crit_edge9:                                     ; preds = %._crit_edge9.loopexit, %25
  %offset.0.lcssa = phi i32 [ 1, %25 ], [ %.lcssa, %._crit_edge9.loopexit ]
  %47 = icmp ult i32 %offset.0.lcssa, %length
  %48 = zext i1 %47 to i32
  %.offset.0 = shl i32 %offset.0.lcssa, %48
  %49 = ashr i32 %.offset.0, 1
  %50 = icmp sgt i32 %49, 0
  br i1 %50, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %._crit_edge9
  %51 = add nsw i32 %1, 1
  br label %52

; <label>:52                                      ; preds = %.lr.ph, %66
  %offset.24 = phi i32 [ %.offset.0, %.lr.ph ], [ %54, %66 ]
  %d.03 = phi i32 [ 0, %.lr.ph ], [ %67, %66 ]
  %53 = or i32 %d.03, 1
  %54 = ashr i32 %offset.24, 1
  tail call void @barrier(i32 1) #2
  %55 = icmp slt i32 %1, %53
  br i1 %55, label %56, label %66

; <label>:56                                      ; preds = %52
  %57 = mul nsw i32 %54, %51
  %58 = add nsw i32 %57, -1
  %59 = ashr i32 %offset.24, 2
  %60 = add nsw i32 %58, %59
  %61 = getelementptr inbounds float addrspace(3)* %block, i32 %58
  %62 = load float addrspace(3)* %61, align 4, !tbaa !13
  %63 = getelementptr inbounds float addrspace(3)* %block, i32 %60
  %64 = load float addrspace(3)* %63, align 4, !tbaa !13
  %65 = fadd float %62, %64
  store float %65, float addrspace(3)* %63, align 4, !tbaa !13
  br label %66

; <label>:66                                      ; preds = %52, %56
  %67 = shl i32 %53, 1
  %68 = icmp slt i32 %67, %49
  br i1 %68, label %52, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %66
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %._crit_edge9
  tail call void @barrier(i32 1) #2
  br i1 %10, label %69, label %74

; <label>:69                                      ; preds = %._crit_edge
  %70 = shl nsw i32 %1, 1
  %71 = getelementptr inbounds float addrspace(3)* %block, i32 %70
  %72 = load float addrspace(3)* %71, align 4, !tbaa !13
  %73 = getelementptr inbounds float addrspace(1)* %output, i32 %9
  store float %72, float addrspace(1)* %73, align 4, !tbaa !13
  br label %74

; <label>:74                                      ; preds = %69, %._crit_edge
  br i1 %18, label %75, label %81

; <label>:75                                      ; preds = %74
  %76 = shl nsw i32 %1, 1
  %77 = or i32 %76, 1
  %78 = getelementptr inbounds float addrspace(3)* %block, i32 %77
  %79 = load float addrspace(3)* %78, align 4, !tbaa !13
  %80 = getelementptr inbounds float addrspace(1)* %output, i32 %17
  store float %79, float addrspace(1)* %80, align 4, !tbaa !13
  br label %81

; <label>:81                                      ; preds = %75, %74
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
  br i1 %or.cond, label %17, label %25

; <label>:17                                      ; preds = %0
  %18 = urem i32 %12, %offset
  %.neg1 = add i32 %12, -1
  %19 = sub i32 %.neg1, %18
  %20 = getelementptr inbounds float addrspace(1)* %buffer, i32 %19
  %21 = load float addrspace(1)* %20, align 4, !tbaa !13
  %22 = getelementptr inbounds float addrspace(1)* %buffer, i32 %12
  %23 = load float addrspace(1)* %22, align 4, !tbaa !13
  %24 = fadd float %21, %23
  store float %24, float addrspace(1)* %22, align 4, !tbaa !13
  br label %25

; <label>:25                                      ; preds = %0, %17
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!12}

!0 = !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32)* @group_prefixSum, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"float*", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"const", !"const"}
!6 = !{void (float addrspace(1)*, i32, i32)* @global_prefixSum, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 1, i32 0, i32 0}
!8 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"float*", !"uint", !"uint"}
!10 = !{!"kernel_arg_base_type", !"float*", !"uint", !"uint"}
!11 = !{!"kernel_arg_type_qual", !"", !"const", !"const"}
!12 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!13 = !{!14, !14, i64 0}
!14 = !{!"float", !15, i64 0}
!15 = !{!"omnipotent char", !16, i64 0}
!16 = !{!"Simple C/C++ TBAA"}

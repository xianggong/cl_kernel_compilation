; ModuleID = '../kernel-src/Reduction_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @reduce(<4 x i32> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(1)* nocapture %output, <4 x i32> addrspace(3)* nocapture %sdata) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_group_id(i32 0) #2
  %3 = tail call i32 @get_global_id(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = shl i32 %3, 1
  %6 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %5
  %7 = load <4 x i32> addrspace(1)* %6, align 16, !tbaa !7
  %8 = or i32 %5, 1
  %9 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %8
  %10 = load <4 x i32> addrspace(1)* %9, align 16, !tbaa !7
  %11 = add <4 x i32> %7, %10
  %12 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %1
  store <4 x i32> %11, <4 x i32> addrspace(3)* %12, align 16, !tbaa !7
  tail call void @barrier(i32 1) #2
  %s.01 = lshr i32 %4, 1
  %13 = icmp eq i32 %s.01, 0
  br i1 %13, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %21
  %s.02 = phi i32 [ %s.0, %21 ], [ %s.01, %.lr.ph.preheader ]
  %14 = icmp ult i32 %1, %s.02
  br i1 %14, label %15, label %21

; <label>:15                                      ; preds = %.lr.ph
  %16 = add i32 %s.02, %1
  %17 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %16
  %18 = load <4 x i32> addrspace(3)* %17, align 16, !tbaa !7
  %19 = load <4 x i32> addrspace(3)* %12, align 16, !tbaa !7
  %20 = add <4 x i32> %18, %19
  store <4 x i32> %20, <4 x i32> addrspace(3)* %12, align 16, !tbaa !7
  br label %21

; <label>:21                                      ; preds = %15, %.lr.ph
  tail call void @barrier(i32 1) #2
  %s.0 = lshr i32 %s.02, 1
  %22 = icmp eq i32 %s.0, 0
  br i1 %22, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %21
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %23 = icmp eq i32 %1, 0
  br i1 %23, label %24, label %27

; <label>:24                                      ; preds = %._crit_edge
  %25 = load <4 x i32> addrspace(3)* %sdata, align 16, !tbaa !7
  %26 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %2
  store <4 x i32> %25, <4 x i32> addrspace(1)* %26, align 16, !tbaa !7
  br label %27

; <label>:27                                      ; preds = %24, %._crit_edge
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @reduce, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 3}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint4*", !"uint4*", !"uint4*"}
!4 = !{!"kernel_arg_base_type", !"uint __attribute__((ext_vector_type(4)))*", !"uint __attribute__((ext_vector_type(4)))*", !"uint __attribute__((ext_vector_type(4)))*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}

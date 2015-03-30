; ModuleID = '../kernel-src/Reduction_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @reduce(<4 x i32> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(1)* nocapture %output, <4 x i32> addrspace(3)* nocapture %sdata) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_group_id(i32 0) #2
  %3 = tail call i32 @get_global_id(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = shl i32 %3, 1
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %6
  %8 = load <4 x i32> addrspace(1)* %7, align 16, !tbaa !2
  %9 = or i32 %5, 1
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %10
  %12 = load <4 x i32> addrspace(1)* %11, align 16, !tbaa !2
  %13 = add <4 x i32> %8, %12
  %14 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %1
  store <4 x i32> %13, <4 x i32> addrspace(3)* %14, align 16, !tbaa !2
  tail call void @barrier(i32 1) #2
  %s.01 = lshr i32 %4, 1
  %15 = icmp eq i32 %s.01, 0
  br i1 %15, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %0, %23
  %s.02 = phi i32 [ %s.0, %23 ], [ %s.01, %0 ]
  %16 = icmp ult i32 %1, %s.02
  br i1 %16, label %17, label %23

; <label>:17                                      ; preds = %.lr.ph
  %18 = add i32 %s.02, %1
  %19 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %18
  %20 = load <4 x i32> addrspace(3)* %19, align 16, !tbaa !2
  %21 = load <4 x i32> addrspace(3)* %14, align 16, !tbaa !2
  %22 = add <4 x i32> %21, %20
  store <4 x i32> %22, <4 x i32> addrspace(3)* %14, align 16, !tbaa !2
  br label %23

; <label>:23                                      ; preds = %17, %.lr.ph
  tail call void @barrier(i32 1) #2
  %s.0 = lshr i32 %s.02, 1
  %24 = icmp eq i32 %s.0, 0
  br i1 %24, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %23, %0
  %25 = icmp eq i32 %1, 0
  br i1 %25, label %26, label %30

; <label>:26                                      ; preds = %._crit_edge
  %27 = load <4 x i32> addrspace(3)* %sdata, align 16, !tbaa !2
  %28 = sext i32 %2 to i64
  %29 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %28
  store <4 x i32> %27, <4 x i32> addrspace(1)* %29, align 16, !tbaa !2
  br label %30

; <label>:30                                      ; preds = %26, %._crit_edge
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
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @reduce}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/Reduction_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @reduce(<4 x i32>* nocapture readonly %input, <4 x i32>* nocapture %output, <4 x i32>* nocapture %sdata) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_group_id(i32 0) #2
  %4 = tail call i64 @get_global_id(i32 0) #2
  %5 = trunc i64 %4 to i32
  %6 = tail call i64 @get_local_size(i32 0) #2
  %7 = trunc i64 %6 to i32
  %8 = shl i32 %5, 1
  %9 = zext i32 %8 to i64
  %10 = getelementptr inbounds <4 x i32>* %input, i64 %9
  %11 = load <4 x i32>* %10, align 16, !tbaa !2
  %12 = or i32 %8, 1
  %13 = zext i32 %12 to i64
  %14 = getelementptr inbounds <4 x i32>* %input, i64 %13
  %15 = load <4 x i32>* %14, align 16, !tbaa !2
  %16 = add <4 x i32> %11, %15
  %17 = and i64 %1, 4294967295
  %18 = getelementptr inbounds <4 x i32>* %sdata, i64 %17
  store <4 x i32> %16, <4 x i32>* %18, align 16, !tbaa !2
  tail call void @barrier(i32 1) #2
  %s.01 = lshr i32 %7, 1
  %19 = icmp eq i32 %s.01, 0
  br i1 %19, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %0, %28
  %s.02 = phi i32 [ %s.0, %28 ], [ %s.01, %0 ]
  %20 = icmp ult i32 %2, %s.02
  br i1 %20, label %21, label %28

; <label>:21                                      ; preds = %.lr.ph
  %22 = add i32 %s.02, %2
  %23 = zext i32 %22 to i64
  %24 = getelementptr inbounds <4 x i32>* %sdata, i64 %23
  %25 = load <4 x i32>* %24, align 16, !tbaa !2
  %26 = load <4 x i32>* %18, align 16, !tbaa !2
  %27 = add <4 x i32> %26, %25
  store <4 x i32> %27, <4 x i32>* %18, align 16, !tbaa !2
  br label %28

; <label>:28                                      ; preds = %21, %.lr.ph
  tail call void @barrier(i32 1) #2
  %s.0 = lshr i32 %s.02, 1
  %29 = icmp eq i32 %s.0, 0
  br i1 %29, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %28, %0
  %30 = icmp eq i32 %2, 0
  br i1 %30, label %31, label %35

; <label>:31                                      ; preds = %._crit_edge
  %32 = load <4 x i32>* %sdata, align 16, !tbaa !2
  %33 = and i64 %3, 4294967295
  %34 = getelementptr inbounds <4 x i32>* %output, i64 %33
  store <4 x i32> %32, <4 x i32>* %34, align 16, !tbaa !2
  br label %35

; <label>:35                                      ; preds = %31, %._crit_edge
  ret void
}

declare i64 @get_local_id(i32) #1

declare i64 @get_group_id(i32) #1

declare i64 @get_global_id(i32) #1

declare i64 @get_local_size(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i32>*, <4 x i32>*, <4 x i32>*)* @reduce}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

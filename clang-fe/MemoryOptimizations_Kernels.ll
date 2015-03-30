; ModuleID = '../kernel-src/MemoryOptimizations_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @copy1DFastPath(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float addrspace(1)* %input, i64 %2
  %4 = load float addrspace(1)* %3, align 4, !tbaa !10
  %5 = getelementptr inbounds float addrspace(1)* %output, i64 %2
  store float %4, float addrspace(1)* %5, align 4, !tbaa !10
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind
define void @copy1DCompletePath(float addrspace(1)* nocapture readonly %input, float addrspace(1)* %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %3, label %6

; <label>:3                                       ; preds = %0
  %4 = bitcast float addrspace(1)* %output to i32 addrspace(1)*
  %5 = tail call i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)* %4, i32 1) #2
  br label %6

; <label>:6                                       ; preds = %3, %0
  %7 = sext i32 %1 to i64
  %8 = getelementptr inbounds float addrspace(1)* %input, i64 %7
  %9 = load float addrspace(1)* %8, align 4, !tbaa !10
  %10 = getelementptr inbounds float addrspace(1)* %output, i64 %7
  store float %9, float addrspace(1)* %10, align 4, !tbaa !10
  ret void
}

declare i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)*, i32) #1

; Function Attrs: nounwind
define void @copy2Dfloat(float addrspace(1)* nocapture readonly %A, float addrspace(1)* nocapture %C) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = shl i32 %2, 10
  %4 = add nsw i32 %3, %1
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds float addrspace(1)* %A, i64 %5
  %7 = load float addrspace(1)* %6, align 4, !tbaa !10
  %8 = getelementptr inbounds float addrspace(1)* %C, i64 %5
  store float %7, float addrspace(1)* %8, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind
define void @copy2Dfloat4(<4 x float> addrspace(1)* nocapture readonly %A, <4 x float> addrspace(1)* nocapture %C) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = shl i32 %2, 10
  %4 = add nsw i32 %3, %1
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds <4 x float> addrspace(1)* %A, i64 %5
  %7 = load <4 x float> addrspace(1)* %6, align 16, !tbaa !14
  %8 = getelementptr inbounds <4 x float> addrspace(1)* %C, i64 %5
  store <4 x float> %7, <4 x float> addrspace(1)* %8, align 16, !tbaa !14
  ret void
}

; Function Attrs: nounwind
define void @copy1Dfloat4(<4 x float> addrspace(1)* nocapture readonly %input, <4 x float> addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %2
  %4 = load <4 x float> addrspace(1)* %3, align 16, !tbaa !14
  %5 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %2
  store <4 x float> %4, <4 x float> addrspace(1)* %5, align 16, !tbaa !14
  ret void
}

; Function Attrs: nounwind
define void @NoCoal(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = and i32 %2, 15
  %4 = icmp eq i32 %3, 0
  %..v = select i1 %4, i32 15, i32 -1
  %. = add i32 %..v, %1
  %5 = sext i32 %. to i64
  %6 = getelementptr inbounds float addrspace(1)* %input, i64 %5
  %7 = load float addrspace(1)* %6, align 4, !tbaa !10
  %8 = getelementptr inbounds float addrspace(1)* %output, i64 %5
  store float %7, float addrspace(1)* %8, align 4, !tbaa !10
  ret void
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define void @Split(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = and i32 %1, 1
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %7

; <label>:4                                       ; preds = %0
  %5 = tail call i32 @get_local_id(i32 0) #2
  %6 = sub i32 62, %5
  br label %7

; <label>:7                                       ; preds = %4, %0
  %gid.0 = phi i32 [ %6, %4 ], [ %1, %0 ]
  %8 = sext i32 %gid.0 to i64
  %9 = getelementptr inbounds float addrspace(1)* %input, i64 %8
  %10 = load float addrspace(1)* %9, align 4, !tbaa !10
  %11 = getelementptr inbounds float addrspace(1)* %output, i64 %8
  store float %10, float addrspace(1)* %11, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind
define void @localBankConflicts(float addrspace(3)* nocapture readonly %share, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = shl nsw i32 %2, 5
  br label %4

; <label>:4                                       ; preds = %0, %4
  %i.03 = phi i32 [ 0, %0 ], [ %17, %4 ]
  %resultb.02 = phi i32 [ 0, %0 ], [ %16, %4 ]
  %resulta.01 = phi i32 [ 0, %0 ], [ %10, %4 ]
  %5 = add nsw i32 %i.03, %3
  %6 = getelementptr inbounds float addrspace(3)* %share, i32 %5
  %7 = load float addrspace(3)* %6, align 4, !tbaa !10
  %8 = sitofp i32 %resulta.01 to float
  %9 = fadd float %8, %7
  %10 = fptosi float %9 to i32
  %11 = or i32 %5, 1
  %12 = getelementptr inbounds float addrspace(3)* %share, i32 %11
  %13 = load float addrspace(3)* %12, align 4, !tbaa !10
  %14 = sitofp i32 %resultb.02 to float
  %15 = fadd float %14, %13
  %16 = fptosi float %15 to i32
  %17 = add nsw i32 %i.03, 2
  %18 = icmp slt i32 %17, 128
  br i1 %18, label %4, label %19

; <label>:19                                      ; preds = %4
  %20 = add nsw i32 %16, %10
  %21 = sitofp i32 %20 to float
  %22 = sext i32 %1 to i64
  %23 = getelementptr inbounds float addrspace(1)* %output, i64 %22
  store float %21, float addrspace(1)* %23, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind
define void @noLocalBankConflicts(float addrspace(3)* nocapture readonly %share, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  br label %3

; <label>:3                                       ; preds = %0, %3
  %i.03 = phi i32 [ 0, %0 ], [ %17, %3 ]
  %resultb.02 = phi i32 [ 0, %0 ], [ %16, %3 ]
  %resulta.01 = phi i32 [ 0, %0 ], [ %9, %3 ]
  %4 = add nsw i32 %i.03, %2
  %5 = getelementptr inbounds float addrspace(3)* %share, i32 %4
  %6 = load float addrspace(3)* %5, align 4, !tbaa !10
  %7 = sitofp i32 %resulta.01 to float
  %8 = fadd float %7, %6
  %9 = fptosi float %8 to i32
  %10 = or i32 %i.03, 1
  %11 = add nsw i32 %10, %2
  %12 = getelementptr inbounds float addrspace(3)* %share, i32 %11
  %13 = load float addrspace(3)* %12, align 4, !tbaa !10
  %14 = sitofp i32 %resultb.02 to float
  %15 = fadd float %14, %13
  %16 = fptosi float %15 to i32
  %17 = add nsw i32 %i.03, 2
  %18 = icmp slt i32 %17, 128
  br i1 %18, label %3, label %19

; <label>:19                                      ; preds = %3
  %20 = add nsw i32 %16, %9
  %21 = sitofp i32 %20 to float
  %22 = sext i32 %1 to i64
  %23 = getelementptr inbounds float addrspace(1)* %output, i64 %22
  store float %21, float addrspace(1)* %23, align 4, !tbaa !10
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy1DFastPath}
!1 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy1DCompletePath}
!2 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy2Dfloat}
!3 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @copy2Dfloat4}
!4 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @copy1Dfloat4}
!5 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @NoCoal}
!6 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @Split}
!7 = metadata !{void (float addrspace(3)*, float addrspace(1)*)* @localBankConflicts}
!8 = metadata !{void (float addrspace(3)*, float addrspace(1)*)* @noLocalBankConflicts}
!9 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!10 = metadata !{metadata !11, metadata !11, i64 0}
!11 = metadata !{metadata !"float", metadata !12, i64 0}
!12 = metadata !{metadata !"omnipotent char", metadata !13, i64 0}
!13 = metadata !{metadata !"Simple C/C++ TBAA"}
!14 = metadata !{metadata !12, metadata !12, i64 0}

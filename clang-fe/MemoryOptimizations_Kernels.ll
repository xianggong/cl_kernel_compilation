; ModuleID = '../kernel-src/MemoryOptimizations_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @copy1DFastPath(float* nocapture readonly %input, float* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %sext = shl i64 %1, 32
  %2 = ashr exact i64 %sext, 32
  %3 = getelementptr inbounds float* %input, i64 %2
  %4 = load float* %3, align 4, !tbaa !10
  %5 = getelementptr inbounds float* %output, i64 %2
  store float %4, float* %5, align 4, !tbaa !10
  ret void
}

declare i64 @get_global_id(i32) #1

; Function Attrs: nounwind uwtable
define void @copy1DCompletePath(float* nocapture readonly %input, float* %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = icmp slt i32 %2, 0
  br i1 %3, label %4, label %7

; <label>:4                                       ; preds = %0
  %5 = bitcast float* %output to i32*
  %6 = tail call i32 @_Z8atom_addPU8CLglobalii(i32* %5, i32 1) #2
  br label %7

; <label>:7                                       ; preds = %4, %0
  %sext = shl i64 %1, 32
  %8 = ashr exact i64 %sext, 32
  %9 = getelementptr inbounds float* %input, i64 %8
  %10 = load float* %9, align 4, !tbaa !10
  %11 = getelementptr inbounds float* %output, i64 %8
  store float %10, float* %11, align 4, !tbaa !10
  ret void
}

declare i32 @_Z8atom_addPU8CLglobalii(i32*, i32) #1

; Function Attrs: nounwind uwtable
define void @copy2Dfloat(float* nocapture readonly %A, float* nocapture %C) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #2
  %4 = trunc i64 %3 to i32
  %5 = shl i32 %4, 10
  %6 = add nsw i32 %5, %2
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds float* %A, i64 %7
  %9 = load float* %8, align 4, !tbaa !10
  %10 = getelementptr inbounds float* %C, i64 %7
  store float %9, float* %10, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind uwtable
define void @copy2Dfloat4(<4 x float>* nocapture readonly %A, <4 x float>* nocapture %C) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #2
  %4 = trunc i64 %3 to i32
  %5 = shl i32 %4, 10
  %6 = add nsw i32 %5, %2
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds <4 x float>* %A, i64 %7
  %9 = load <4 x float>* %8, align 16, !tbaa !14
  %10 = getelementptr inbounds <4 x float>* %C, i64 %7
  store <4 x float> %9, <4 x float>* %10, align 16, !tbaa !14
  ret void
}

; Function Attrs: nounwind uwtable
define void @copy1Dfloat4(<4 x float>* nocapture readonly %input, <4 x float>* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %sext = shl i64 %1, 32
  %2 = ashr exact i64 %sext, 32
  %3 = getelementptr inbounds <4 x float>* %input, i64 %2
  %4 = load <4 x float>* %3, align 16, !tbaa !14
  %5 = getelementptr inbounds <4 x float>* %output, i64 %2
  store <4 x float> %4, <4 x float>* %5, align 16, !tbaa !14
  ret void
}

; Function Attrs: nounwind uwtable
define void @NoCoal(float* nocapture readonly %input, float* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_local_id(i32 0) #2
  %3 = and i64 %2, 15
  %4 = icmp eq i64 %3, 0
  %..v = select i1 %4, i64 15, i64 4294967295
  %. = add i64 %..v, %1
  %sext = shl i64 %., 32
  %5 = ashr exact i64 %sext, 32
  %6 = getelementptr inbounds float* %input, i64 %5
  %7 = load float* %6, align 4, !tbaa !10
  %8 = getelementptr inbounds float* %output, i64 %5
  store float %7, float* %8, align 4, !tbaa !10
  ret void
}

declare i64 @get_local_id(i32) #1

; Function Attrs: nounwind uwtable
define void @Split(float* nocapture readonly %input, float* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = and i64 %1, 1
  %3 = icmp eq i64 %2, 0
  br i1 %3, label %4, label %7

; <label>:4                                       ; preds = %0
  %5 = tail call i64 @get_local_id(i32 0) #2
  %6 = sub i64 62, %5
  br label %7

; <label>:7                                       ; preds = %4, %0
  %gid.0 = phi i64 [ %6, %4 ], [ %1, %0 ]
  %sext = shl i64 %gid.0, 32
  %8 = ashr exact i64 %sext, 32
  %9 = getelementptr inbounds float* %input, i64 %8
  %10 = load float* %9, align 4, !tbaa !10
  %11 = getelementptr inbounds float* %output, i64 %8
  store float %10, float* %11, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind uwtable
define void @localBankConflicts(float* nocapture readonly %share, float* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_local_id(i32 0) #2
  %3 = trunc i64 %2 to i32
  %4 = shl nsw i32 %3, 5
  %5 = sext i32 %4 to i64
  br label %6

; <label>:6                                       ; preds = %0, %6
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %6 ]
  %resultb.02 = phi i32 [ 0, %0 ], [ %19, %6 ]
  %resulta.01 = phi i32 [ 0, %0 ], [ %12, %6 ]
  %7 = add nsw i64 %indvars.iv, %5
  %8 = getelementptr inbounds float* %share, i64 %7
  %9 = load float* %8, align 4, !tbaa !10
  %10 = sitofp i32 %resulta.01 to float
  %11 = fadd float %10, %9
  %12 = fptosi float %11 to i32
  %13 = shl i64 %7, 32
  %sext5 = ashr exact i64 %13, 32
  %14 = or i64 %sext5, 1
  %15 = getelementptr inbounds float* %share, i64 %14
  %16 = load float* %15, align 4, !tbaa !10
  %17 = sitofp i32 %resultb.02 to float
  %18 = fadd float %17, %16
  %19 = fptosi float %18 to i32
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 2
  %20 = trunc i64 %indvars.iv.next to i32
  %21 = icmp slt i32 %20, 128
  br i1 %21, label %6, label %22

; <label>:22                                      ; preds = %6
  %23 = add nsw i32 %19, %12
  %24 = sitofp i32 %23 to float
  %sext = shl i64 %1, 32
  %25 = ashr exact i64 %sext, 32
  %26 = getelementptr inbounds float* %output, i64 %25
  store float %24, float* %26, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind uwtable
define void @noLocalBankConflicts(float* nocapture readonly %share, float* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_local_id(i32 0) #2
  %sext5 = shl i64 %2, 32
  %3 = ashr exact i64 %sext5, 32
  br label %4

; <label>:4                                       ; preds = %0, %4
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %4 ]
  %resultb.02 = phi i32 [ 0, %0 ], [ %17, %4 ]
  %resulta.01 = phi i32 [ 0, %0 ], [ %10, %4 ]
  %5 = add nsw i64 %indvars.iv, %3
  %6 = getelementptr inbounds float* %share, i64 %5
  %7 = load float* %6, align 4, !tbaa !10
  %8 = sitofp i32 %resulta.01 to float
  %9 = fadd float %8, %7
  %10 = fptosi float %9 to i32
  %11 = or i64 %indvars.iv, 1
  %12 = add nsw i64 %11, %3
  %13 = getelementptr inbounds float* %share, i64 %12
  %14 = load float* %13, align 4, !tbaa !10
  %15 = sitofp i32 %resultb.02 to float
  %16 = fadd float %15, %14
  %17 = fptosi float %16 to i32
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 2
  %18 = trunc i64 %indvars.iv.next to i32
  %19 = icmp slt i32 %18, 128
  br i1 %19, label %4, label %20

; <label>:20                                      ; preds = %4
  %21 = add nsw i32 %17, %10
  %22 = sitofp i32 %21 to float
  %sext = shl i64 %1, 32
  %23 = ashr exact i64 %sext, 32
  %24 = getelementptr inbounds float* %output, i64 %23
  store float %22, float* %24, align 4, !tbaa !10
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = metadata !{void (float*, float*)* @copy1DFastPath}
!1 = metadata !{void (float*, float*)* @copy1DCompletePath}
!2 = metadata !{void (float*, float*)* @copy2Dfloat}
!3 = metadata !{void (<4 x float>*, <4 x float>*)* @copy2Dfloat4}
!4 = metadata !{void (<4 x float>*, <4 x float>*)* @copy1Dfloat4}
!5 = metadata !{void (float*, float*)* @NoCoal}
!6 = metadata !{void (float*, float*)* @Split}
!7 = metadata !{void (float*, float*)* @localBankConflicts}
!8 = metadata !{void (float*, float*)* @noLocalBankConflicts}
!9 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!10 = metadata !{metadata !11, metadata !11, i64 0}
!11 = metadata !{metadata !"float", metadata !12, i64 0}
!12 = metadata !{metadata !"omnipotent char", metadata !13, i64 0}
!13 = metadata !{metadata !"Simple C/C++ TBAA"}
!14 = metadata !{metadata !12, metadata !12, i64 0}

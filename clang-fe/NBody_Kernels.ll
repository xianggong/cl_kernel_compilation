; ModuleID = '../kernel-src/NBody_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @nbody_sim(<4 x float>* nocapture readonly %pos, <4 x float>* nocapture readonly %vel, i32 %numBodies, float %deltaTime, float %epsSqr, <4 x float>* nocapture %newPosition, <4 x float>* nocapture %newVelocity) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #4
  %2 = and i64 %1, 4294967295
  %3 = getelementptr inbounds <4 x float>* %pos, i64 %2
  %4 = load <4 x float>* %3, align 16, !tbaa !2
  %5 = icmp sgt i32 %numBodies, 8
  br i1 %5, label %.preheader9.lr.ph, label %.preheader

.preheader9.lr.ph:                                ; preds = %0
  %6 = shufflevector <4 x float> %4, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  br label %.preheader9

.loopexit:                                        ; preds = %14
  %7 = add i32 %i.013, 8
  %8 = add nsw i32 %indvars.iv21, 9
  %9 = icmp slt i32 %8, %numBodies
  %indvars.iv.next22 = add i32 %indvars.iv21, 8
  %indvars.iv.next24 = add i32 %indvars.iv23, 8
  br i1 %9, label %.preheader9, label %.preheader

.preheader9:                                      ; preds = %.preheader9.lr.ph, %.loopexit
  %indvars.iv23 = phi i32 [ 8, %.preheader9.lr.ph ], [ %indvars.iv.next24, %.loopexit ]
  %indvars.iv21 = phi i32 [ 7, %.preheader9.lr.ph ], [ %indvars.iv.next22, %.loopexit ]
  %acc.014 = phi <4 x float> [ zeroinitializer, %.preheader9.lr.ph ], [ %38, %.loopexit ]
  %i.013 = phi i32 [ 0, %.preheader9.lr.ph ], [ %7, %.loopexit ]
  %10 = sext i32 %i.013 to i64
  br label %14

.preheader:                                       ; preds = %.loopexit, %0
  %acc.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %38, %.loopexit ]
  %i.0.lcssa = phi i32 [ 0, %0 ], [ %7, %.loopexit ]
  %11 = icmp slt i32 %i.0.lcssa, %numBodies
  %12 = shufflevector <4 x float> %4, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  br i1 %11, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.preheader
  %13 = sext i32 %i.0.lcssa to i64
  br label %39

; <label>:14                                      ; preds = %14, %.preheader9
  %indvars.iv19 = phi i64 [ %10, %.preheader9 ], [ %indvars.iv.next20, %14 ]
  %acc.112 = phi <4 x float> [ %acc.014, %.preheader9 ], [ %38, %14 ]
  %15 = getelementptr inbounds <4 x float>* %pos, i64 %indvars.iv19
  %16 = load <4 x float>* %15, align 16, !tbaa !2
  %17 = shufflevector <4 x float> %16, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %18 = fsub <3 x float> %17, %6
  %19 = extractelement <3 x float> %18, i32 0
  %20 = extractelement <3 x float> %18, i32 1
  %21 = fmul float %20, %20
  %22 = tail call float @llvm.fmuladd.f32(float %19, float %19, float %21)
  %23 = extractelement <3 x float> %18, i32 2
  %24 = tail call float @llvm.fmuladd.f32(float %23, float %23, float %22)
  %25 = fadd float %24, %epsSqr
  %26 = tail call float @llvm.sqrt.f32(float %25)
  %27 = fdiv float 1.000000e+00, %26, !fpmath !5
  %28 = fmul float %27, %27
  %29 = fmul float %27, %28
  %30 = extractelement <4 x float> %16, i32 3
  %31 = fmul float %30, %29
  %32 = insertelement <3 x float> undef, float %31, i32 0
  %33 = shufflevector <3 x float> %32, <3 x float> undef, <3 x i32> zeroinitializer
  %34 = fmul <3 x float> %18, %33
  %35 = shufflevector <4 x float> %acc.112, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %36 = fadd <3 x float> %35, %34
  %37 = shufflevector <3 x float> %36, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %38 = shufflevector <4 x float> %acc.112, <4 x float> %37, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %indvars.iv.next20 = add nsw i64 %indvars.iv19, 1
  %lftr.wideiv25 = trunc i64 %indvars.iv.next20 to i32
  %exitcond26 = icmp eq i32 %lftr.wideiv25, %indvars.iv23
  br i1 %exitcond26, label %.loopexit, label %14

; <label>:39                                      ; preds = %39, %.lr.ph
  %indvars.iv = phi i64 [ %13, %.lr.ph ], [ %indvars.iv.next, %39 ]
  %acc.28 = phi <4 x float> [ %acc.0.lcssa, %.lr.ph ], [ %63, %39 ]
  %40 = getelementptr inbounds <4 x float>* %pos, i64 %indvars.iv
  %41 = load <4 x float>* %40, align 16, !tbaa !2
  %42 = shufflevector <4 x float> %41, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %43 = fsub <3 x float> %42, %12
  %44 = extractelement <3 x float> %43, i32 0
  %45 = extractelement <3 x float> %43, i32 1
  %46 = fmul float %45, %45
  %47 = tail call float @llvm.fmuladd.f32(float %44, float %44, float %46)
  %48 = extractelement <3 x float> %43, i32 2
  %49 = tail call float @llvm.fmuladd.f32(float %48, float %48, float %47)
  %50 = fadd float %49, %epsSqr
  %51 = tail call float @llvm.sqrt.f32(float %50)
  %52 = fdiv float 1.000000e+00, %51, !fpmath !5
  %53 = fmul float %52, %52
  %54 = fmul float %52, %53
  %55 = extractelement <4 x float> %41, i32 3
  %56 = fmul float %55, %54
  %57 = insertelement <3 x float> undef, float %56, i32 0
  %58 = shufflevector <3 x float> %57, <3 x float> undef, <3 x i32> zeroinitializer
  %59 = fmul <3 x float> %43, %58
  %60 = shufflevector <4 x float> %acc.28, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %61 = fadd <3 x float> %60, %59
  %62 = shufflevector <3 x float> %61, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %63 = shufflevector <4 x float> %acc.28, <4 x float> %62, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %numBodies
  br i1 %exitcond, label %._crit_edge, label %39

._crit_edge:                                      ; preds = %.preheader, %39
  %acc.2.lcssa = phi <4 x float> [ %63, %39 ], [ %acc.0.lcssa, %.preheader ]
  %64 = getelementptr inbounds <4 x float>* %vel, i64 %2
  %65 = load <4 x float>* %64, align 16, !tbaa !2
  %66 = shufflevector <4 x float> %65, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %67 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %68 = shufflevector <3 x float> %67, <3 x float> undef, <3 x i32> zeroinitializer
  %69 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %66, <3 x float> %68, <3 x float> %12)
  %70 = shufflevector <4 x float> %acc.2.lcssa, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %71 = fmul <3 x float> %70, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %72 = fmul <3 x float> %68, %71
  %73 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %72, <3 x float> %68, <3 x float> %69)
  %74 = shufflevector <3 x float> %73, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %75 = shufflevector <4 x float> %74, <4 x float> %4, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %76 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %70, <3 x float> %68, <3 x float> %66)
  %77 = shufflevector <3 x float> %76, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %78 = shufflevector <4 x float> %77, <4 x float> %65, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %79 = getelementptr inbounds <4 x float>* %newPosition, i64 %2
  store <4 x float> %75, <4 x float>* %79, align 16, !tbaa !2
  %80 = getelementptr inbounds <4 x float>* %newVelocity, i64 %2
  store <4 x float> %78, <4 x float>* %80, align 16, !tbaa !2
  ret void
}

declare i64 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #3

; Function Attrs: nounwind readnone
declare <3 x float> @llvm.fmuladd.v3f32(<3 x float>, <3 x float>, <3 x float>) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float>*, <4 x float>*, i32, float, float, <4 x float>*, <4 x float>*)* @nbody_sim}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

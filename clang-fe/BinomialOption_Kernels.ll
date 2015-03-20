; ModuleID = '../kernel-src/BinomialOption_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @binomial_options(i32 %numSteps, <4 x float>* nocapture readonly %randArray, <4 x float>* nocapture %output, <4 x float>* nocapture %callA, <4 x float>* nocapture %callB) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #4
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_group_id(i32 0) #4
  %4 = and i64 %3, 4294967295
  %5 = getelementptr inbounds <4 x float>* %randArray, i64 %4
  %6 = load <4 x float>* %5, align 16, !tbaa !2
  %7 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %6
  %8 = fmul <4 x float> %6, <float 3.000000e+01, float 3.000000e+01, float 3.000000e+01, float 3.000000e+01>
  %9 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %7, <4 x float> <float 5.000000e+00, float 5.000000e+00, float 5.000000e+00, float 5.000000e+00>, <4 x float> %8)
  %10 = fmul <4 x float> %6, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %11 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %7, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %10)
  %12 = fmul <4 x float> %6, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %13 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %7, <4 x float> <float 2.500000e-01, float 2.500000e-01, float 2.500000e-01, float 2.500000e-01>, <4 x float> %12)
  %14 = sitofp i32 %numSteps to float
  %15 = fdiv float 1.000000e+00, %14, !fpmath !5
  %16 = insertelement <4 x float> undef, float %15, i32 0
  %17 = shufflevector <4 x float> %16, <4 x float> undef, <4 x i32> zeroinitializer
  %18 = fmul <4 x float> %13, %17
  %19 = tail call <4 x float> @llvm.sqrt.v4f32(<4 x float> %18)
  %20 = fmul <4 x float> %19, <float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000>
  %21 = fmul <4 x float> %18, <float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000>
  %22 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %21) #4
  %23 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %22, !fpmath !5
  %24 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %20) #4
  %25 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %24, !fpmath !5
  %26 = fsub <4 x float> %22, %25
  %27 = fsub <4 x float> %24, %25
  %28 = fdiv <4 x float> %26, %27, !fpmath !5
  %29 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %28
  %30 = fmul <4 x float> %23, %28
  %31 = fmul <4 x float> %23, %29
  %32 = uitofp i32 %2 to float
  %33 = fsub float -0.000000e+00, %14
  %34 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %32, float %33)
  %35 = insertelement <4 x float> undef, float %34, i32 0
  %36 = shufflevector <4 x float> %35, <4 x float> undef, <4 x i32> zeroinitializer
  %37 = fmul <4 x float> %20, %36
  %38 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %37) #4
  %39 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %11
  %40 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %9, <4 x float> %38, <4 x float> %39)
  %41 = extractelement <4 x float> %40, i32 0
  %42 = fcmp ogt float %41, 0.000000e+00
  %43 = select i1 %42, float %41, float 0.000000e+00
  %44 = and i64 %1, 4294967295
  %45 = getelementptr inbounds <4 x float>* %callA, i64 %44
  %46 = insertelement <4 x float> undef, float %43, i32 0
  %47 = extractelement <4 x float> %40, i32 1
  %48 = fcmp ogt float %47, 0.000000e+00
  %49 = select i1 %48, float %47, float 0.000000e+00
  %50 = insertelement <4 x float> %46, float %49, i32 1
  %51 = extractelement <4 x float> %40, i32 2
  %52 = fcmp ogt float %51, 0.000000e+00
  %53 = select i1 %52, float %51, float 0.000000e+00
  %54 = insertelement <4 x float> %50, float %53, i32 2
  %55 = extractelement <4 x float> %40, i32 3
  %56 = fcmp ogt float %55, 0.000000e+00
  %57 = select i1 %56, float %55, float 0.000000e+00
  %58 = insertelement <4 x float> %54, float %57, i32 3
  store <4 x float> %58, <4 x float>* %45, align 16
  tail call void @barrier(i32 1) #4
  %59 = icmp sgt i32 %numSteps, 0
  br i1 %59, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %60 = add i64 %1, 1
  %61 = and i64 %60, 4294967295
  %62 = getelementptr inbounds <4 x float>* %callA, i64 %61
  %63 = getelementptr inbounds <4 x float>* %callB, i64 %44
  %64 = getelementptr inbounds <4 x float>* %callB, i64 %61
  br label %65

; <label>:65                                      ; preds = %.lr.ph, %80
  %j.01 = phi i32 [ %numSteps, %.lr.ph ], [ %81, %80 ]
  %66 = icmp ult i32 %2, %j.01
  br i1 %66, label %67, label %72

; <label>:67                                      ; preds = %65
  %68 = load <4 x float>* %45, align 16, !tbaa !2
  %69 = load <4 x float>* %62, align 16, !tbaa !2
  %70 = fmul <4 x float> %31, %69
  %71 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %30, <4 x float> %68, <4 x float> %70)
  store <4 x float> %71, <4 x float>* %63, align 16, !tbaa !2
  br label %72

; <label>:72                                      ; preds = %67, %65
  tail call void @barrier(i32 1) #4
  %73 = add nsw i32 %j.01, -1
  %74 = icmp ult i32 %2, %73
  br i1 %74, label %75, label %80

; <label>:75                                      ; preds = %72
  %76 = load <4 x float>* %63, align 16, !tbaa !2
  %77 = load <4 x float>* %64, align 16, !tbaa !2
  %78 = fmul <4 x float> %31, %77
  %79 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %30, <4 x float> %76, <4 x float> %78)
  store <4 x float> %79, <4 x float>* %45, align 16, !tbaa !2
  br label %80

; <label>:80                                      ; preds = %75, %72
  tail call void @barrier(i32 1) #4
  %81 = add nsw i32 %j.01, -2
  %82 = icmp sgt i32 %81, 0
  br i1 %82, label %65, label %._crit_edge

._crit_edge:                                      ; preds = %80, %0
  %83 = icmp eq i32 %2, 0
  br i1 %83, label %84, label %87

; <label>:84                                      ; preds = %._crit_edge
  %85 = load <4 x float>* %callA, align 16, !tbaa !2
  %86 = getelementptr inbounds <4 x float>* %output, i64 %4
  store <4 x float> %85, <4 x float>* %86, align 16, !tbaa !2
  br label %87

; <label>:87                                      ; preds = %84, %._crit_edge
  ret void
}

declare i64 @get_local_id(i32) #1

declare i64 @get_group_id(i32) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #3

declare <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32, <4 x float>*, <4 x float>*, <4 x float>*, <4 x float>*)* @binomial_options}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

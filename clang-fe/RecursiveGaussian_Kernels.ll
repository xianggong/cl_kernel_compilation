; ModuleID = '../kernel-src/RecursiveGaussian_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @transpose_kernel(<4 x i8>* nocapture %output, <4 x i8>* nocapture readonly %input, <4 x i8>* nocapture %block, i32 %width, i32 %height, i32 %blockSize) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_local_id(i32 0) #3
  %6 = trunc i64 %5 to i32
  %7 = tail call i64 @get_local_id(i32 1) #3
  %8 = trunc i64 %7 to i32
  %9 = mul i32 %4, %width
  %10 = add i32 %9, %2
  %11 = zext i32 %10 to i64
  %12 = getelementptr inbounds <4 x i8>* %input, i64 %11
  %13 = load <4 x i8>* %12, align 4, !tbaa !3
  %14 = mul i32 %8, %blockSize
  %15 = add i32 %14, %6
  %16 = zext i32 %15 to i64
  %17 = getelementptr inbounds <4 x i8>* %block, i64 %16
  store <4 x i8> %13, <4 x i8>* %17, align 4, !tbaa !3
  tail call void @barrier(i32 1) #3
  %18 = mul i32 %2, %height
  %19 = add i32 %4, %18
  %20 = load <4 x i8>* %17, align 4, !tbaa !3
  %21 = zext i32 %19 to i64
  %22 = getelementptr inbounds <4 x i8>* %output, i64 %21
  store <4 x i8> %20, <4 x i8>* %22, align 4, !tbaa !3
  ret void
}

declare i64 @get_global_id(i32) #1

declare i64 @get_local_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind uwtable
define void @RecursiveGaussian_kernel(<4 x i8>* nocapture readonly %input, <4 x i8>* nocapture %output, i32 %width, i32 %height, float %a0, float %a1, float %a2, float %a3, float %b1, float %b2, float %coefp, float %coefn) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = icmp ult i32 %2, %width
  br i1 %3, label %.preheader, label %.loopexit

.preheader:                                       ; preds = %0
  %4 = icmp sgt i32 %height, 0
  br i1 %4, label %.lr.ph15, label %._crit_edge.thread

._crit_edge.thread:                               ; preds = %.preheader
  tail call void @barrier(i32 2) #3
  br label %.loopexit

.lr.ph15:                                         ; preds = %.preheader
  %5 = insertelement <4 x float> undef, float %a0, i32 0
  %6 = shufflevector <4 x float> %5, <4 x float> undef, <4 x i32> zeroinitializer
  %7 = insertelement <4 x float> undef, float %a1, i32 0
  %8 = shufflevector <4 x float> %7, <4 x float> undef, <4 x i32> zeroinitializer
  %9 = insertelement <4 x float> undef, float %b1, i32 0
  %10 = shufflevector <4 x float> %9, <4 x float> undef, <4 x i32> zeroinitializer
  %11 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %10
  %12 = insertelement <4 x float> undef, float %b2, i32 0
  %13 = shufflevector <4 x float> %12, <4 x float> undef, <4 x i32> zeroinitializer
  %14 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %13
  br label %15

; <label>:15                                      ; preds = %15, %.lr.ph15
  %indvars.iv16 = phi i64 [ 0, %.lr.ph15 ], [ %indvars.iv.next17, %15 ]
  %xp.014 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %33, %15 ]
  %yp.013 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %37, %15 ]
  %yb.012 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %yp.013, %15 ]
  %16 = trunc i64 %indvars.iv16 to i32
  %17 = mul nsw i32 %16, %width
  %18 = add i32 %17, %2
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds <4 x i8>* %input, i64 %19
  %21 = load <4 x i8>* %20, align 4
  %22 = extractelement <4 x i8> %21, i32 0
  %23 = uitofp i8 %22 to float
  %24 = insertelement <4 x float> undef, float %23, i32 0
  %25 = extractelement <4 x i8> %21, i32 1
  %26 = uitofp i8 %25 to float
  %27 = insertelement <4 x float> %24, float %26, i32 1
  %28 = extractelement <4 x i8> %21, i32 2
  %29 = uitofp i8 %28 to float
  %30 = insertelement <4 x float> %27, float %29, i32 2
  %31 = extractelement <4 x i8> %21, i32 3
  %32 = uitofp i8 %31 to float
  %33 = insertelement <4 x float> %30, float %32, i32 3
  %34 = fmul <4 x float> %8, %xp.014
  %35 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %6, <4 x float> %33, <4 x float> %34)
  %36 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %11, <4 x float> %yp.013, <4 x float> %35)
  %37 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %14, <4 x float> %yb.012, <4 x float> %36)
  %38 = extractelement <4 x float> %37, i32 0
  %39 = fptoui float %38 to i8
  %40 = insertelement <4 x i8> undef, i8 %39, i32 0
  %41 = extractelement <4 x float> %37, i32 1
  %42 = fptoui float %41 to i8
  %43 = insertelement <4 x i8> %40, i8 %42, i32 1
  %44 = extractelement <4 x float> %37, i32 2
  %45 = fptoui float %44 to i8
  %46 = insertelement <4 x i8> %43, i8 %45, i32 2
  %47 = extractelement <4 x float> %37, i32 3
  %48 = fptoui float %47 to i8
  %49 = insertelement <4 x i8> %46, i8 %48, i32 3
  %50 = getelementptr inbounds <4 x i8>* %output, i64 %19
  store <4 x i8> %49, <4 x i8>* %50, align 4, !tbaa !3
  %indvars.iv.next17 = add nuw nsw i64 %indvars.iv16, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next17 to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %height
  br i1 %exitcond, label %._crit_edge, label %15

._crit_edge:                                      ; preds = %15
  tail call void @barrier(i32 2) #3
  br i1 %4, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %._crit_edge
  %51 = insertelement <4 x float> undef, float %a2, i32 0
  %52 = shufflevector <4 x float> %51, <4 x float> undef, <4 x i32> zeroinitializer
  %53 = insertelement <4 x float> undef, float %a3, i32 0
  %54 = shufflevector <4 x float> %53, <4 x float> undef, <4 x i32> zeroinitializer
  %55 = insertelement <4 x float> undef, float %b1, i32 0
  %56 = shufflevector <4 x float> %55, <4 x float> undef, <4 x i32> zeroinitializer
  %57 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %56
  %58 = insertelement <4 x float> undef, float %b2, i32 0
  %59 = shufflevector <4 x float> %58, <4 x float> undef, <4 x i32> zeroinitializer
  %60 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %59
  %61 = sext i32 %height to i64
  br label %62

; <label>:62                                      ; preds = %.lr.ph, %62
  %indvars.iv = phi i64 [ %61, %.lr.ph ], [ %indvars.iv.next, %62 ]
  %xn.09 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %80, %62 ]
  %xa.08 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %xn.09, %62 ]
  %yn.07 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %84, %62 ]
  %ya.06 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %yn.07, %62 ]
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  %63 = trunc i64 %indvars.iv.next to i32
  %64 = mul nsw i32 %63, %width
  %65 = add i32 %64, %2
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds <4 x i8>* %input, i64 %66
  %68 = load <4 x i8>* %67, align 4
  %69 = extractelement <4 x i8> %68, i32 0
  %70 = uitofp i8 %69 to float
  %71 = insertelement <4 x float> undef, float %70, i32 0
  %72 = extractelement <4 x i8> %68, i32 1
  %73 = uitofp i8 %72 to float
  %74 = insertelement <4 x float> %71, float %73, i32 1
  %75 = extractelement <4 x i8> %68, i32 2
  %76 = uitofp i8 %75 to float
  %77 = insertelement <4 x float> %74, float %76, i32 2
  %78 = extractelement <4 x i8> %68, i32 3
  %79 = uitofp i8 %78 to float
  %80 = insertelement <4 x float> %77, float %79, i32 3
  %81 = fmul <4 x float> %54, %xa.08
  %82 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %52, <4 x float> %xn.09, <4 x float> %81)
  %83 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %57, <4 x float> %yn.07, <4 x float> %82)
  %84 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %60, <4 x float> %ya.06, <4 x float> %83)
  %85 = getelementptr inbounds <4 x i8>* %output, i64 %66
  %86 = load <4 x i8>* %85, align 4
  %87 = extractelement <4 x i8> %86, i32 0
  %88 = uitofp i8 %87 to float
  %89 = insertelement <4 x float> undef, float %88, i32 0
  %90 = extractelement <4 x i8> %86, i32 1
  %91 = uitofp i8 %90 to float
  %92 = insertelement <4 x float> %89, float %91, i32 1
  %93 = extractelement <4 x i8> %86, i32 2
  %94 = uitofp i8 %93 to float
  %95 = insertelement <4 x float> %92, float %94, i32 2
  %96 = extractelement <4 x i8> %86, i32 3
  %97 = uitofp i8 %96 to float
  %98 = insertelement <4 x float> %95, float %97, i32 3
  %99 = fadd <4 x float> %84, %98
  %100 = extractelement <4 x float> %99, i32 0
  %101 = fptoui float %100 to i8
  %102 = insertelement <4 x i8> undef, i8 %101, i32 0
  %103 = extractelement <4 x float> %99, i32 1
  %104 = fptoui float %103 to i8
  %105 = insertelement <4 x i8> %102, i8 %104, i32 1
  %106 = extractelement <4 x float> %99, i32 2
  %107 = fptoui float %106 to i8
  %108 = insertelement <4 x i8> %105, i8 %107, i32 2
  %109 = extractelement <4 x float> %99, i32 3
  %110 = fptoui float %109 to i8
  %111 = insertelement <4 x i8> %108, i8 %110, i32 3
  store <4 x i8> %111, <4 x i8>* %85, align 4, !tbaa !3
  %112 = icmp sgt i32 %63, 0
  br i1 %112, label %62, label %.loopexit

.loopexit:                                        ; preds = %._crit_edge, %._crit_edge.thread, %62, %0
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i8>*, <4 x i8>*, <4 x i8>*, i32, i32, i32)* @transpose_kernel}
!1 = metadata !{void (<4 x i8>*, <4 x i8>*, i32, i32, float, float, float, float, float, float, float, float)* @RecursiveGaussian_kernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/RecursiveGaussian_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @transpose_kernel(<4 x i8> addrspace(1)* nocapture %output, <4 x i8> addrspace(1)* nocapture readonly %input, <4 x i8> addrspace(3)* nocapture %block, i32 %width, i32 %height, i32 %blockSize) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = tail call i32 @get_local_id(i32 0) #3
  %4 = tail call i32 @get_local_id(i32 1) #3
  %5 = mul i32 %2, %width
  %6 = add i32 %5, %1
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %7
  %9 = load <4 x i8> addrspace(1)* %8, align 4, !tbaa !3
  %10 = mul i32 %4, %blockSize
  %11 = add i32 %10, %3
  %12 = getelementptr inbounds <4 x i8> addrspace(3)* %block, i32 %11
  store <4 x i8> %9, <4 x i8> addrspace(3)* %12, align 4, !tbaa !3
  tail call void @barrier(i32 1) #3
  %13 = mul i32 %1, %height
  %14 = add i32 %2, %13
  %15 = load <4 x i8> addrspace(3)* %12, align 4, !tbaa !3
  %16 = sext i32 %14 to i64
  %17 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %16
  store <4 x i8> %15, <4 x i8> addrspace(1)* %17, align 4, !tbaa !3
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @RecursiveGaussian_kernel(<4 x i8> addrspace(1)* nocapture readonly %input, <4 x i8> addrspace(1)* nocapture %output, i32 %width, i32 %height, float %a0, float %a1, float %a2, float %a3, float %b1, float %b2, float %coefp, float %coefn) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = icmp ult i32 %1, %width
  br i1 %2, label %.preheader, label %.loopexit

.preheader:                                       ; preds = %0
  %3 = icmp sgt i32 %height, 0
  br i1 %3, label %.lr.ph15, label %._crit_edge.thread

._crit_edge.thread:                               ; preds = %.preheader
  tail call void @barrier(i32 2) #3
  br label %.loopexit

.lr.ph15:                                         ; preds = %.preheader
  %4 = insertelement <4 x float> undef, float %a0, i32 0
  %5 = shufflevector <4 x float> %4, <4 x float> undef, <4 x i32> zeroinitializer
  %6 = insertelement <4 x float> undef, float %a1, i32 0
  %7 = shufflevector <4 x float> %6, <4 x float> undef, <4 x i32> zeroinitializer
  %8 = insertelement <4 x float> undef, float %b1, i32 0
  %9 = shufflevector <4 x float> %8, <4 x float> undef, <4 x i32> zeroinitializer
  %10 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %9
  %11 = insertelement <4 x float> undef, float %b2, i32 0
  %12 = shufflevector <4 x float> %11, <4 x float> undef, <4 x i32> zeroinitializer
  %13 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %12
  br label %14

; <label>:14                                      ; preds = %14, %.lr.ph15
  %indvars.iv16 = phi i64 [ 0, %.lr.ph15 ], [ %indvars.iv.next17, %14 ]
  %xp.014 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %32, %14 ]
  %yp.013 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %36, %14 ]
  %yb.012 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %yp.013, %14 ]
  %15 = trunc i64 %indvars.iv16 to i32
  %16 = mul nsw i32 %15, %width
  %17 = add i32 %16, %1
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %18
  %20 = load <4 x i8> addrspace(1)* %19, align 4
  %21 = extractelement <4 x i8> %20, i32 0
  %22 = uitofp i8 %21 to float
  %23 = insertelement <4 x float> undef, float %22, i32 0
  %24 = extractelement <4 x i8> %20, i32 1
  %25 = uitofp i8 %24 to float
  %26 = insertelement <4 x float> %23, float %25, i32 1
  %27 = extractelement <4 x i8> %20, i32 2
  %28 = uitofp i8 %27 to float
  %29 = insertelement <4 x float> %26, float %28, i32 2
  %30 = extractelement <4 x i8> %20, i32 3
  %31 = uitofp i8 %30 to float
  %32 = insertelement <4 x float> %29, float %31, i32 3
  %33 = fmul <4 x float> %7, %xp.014
  %34 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %5, <4 x float> %32, <4 x float> %33)
  %35 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %10, <4 x float> %yp.013, <4 x float> %34)
  %36 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %13, <4 x float> %yb.012, <4 x float> %35)
  %37 = extractelement <4 x float> %36, i32 0
  %38 = fptoui float %37 to i8
  %39 = insertelement <4 x i8> undef, i8 %38, i32 0
  %40 = extractelement <4 x float> %36, i32 1
  %41 = fptoui float %40 to i8
  %42 = insertelement <4 x i8> %39, i8 %41, i32 1
  %43 = extractelement <4 x float> %36, i32 2
  %44 = fptoui float %43 to i8
  %45 = insertelement <4 x i8> %42, i8 %44, i32 2
  %46 = extractelement <4 x float> %36, i32 3
  %47 = fptoui float %46 to i8
  %48 = insertelement <4 x i8> %45, i8 %47, i32 3
  %49 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %18
  store <4 x i8> %48, <4 x i8> addrspace(1)* %49, align 4, !tbaa !3
  %indvars.iv.next17 = add nuw nsw i64 %indvars.iv16, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next17 to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %height
  br i1 %exitcond, label %._crit_edge, label %14

._crit_edge:                                      ; preds = %14
  tail call void @barrier(i32 2) #3
  br i1 %3, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %._crit_edge
  %50 = insertelement <4 x float> undef, float %a2, i32 0
  %51 = shufflevector <4 x float> %50, <4 x float> undef, <4 x i32> zeroinitializer
  %52 = insertelement <4 x float> undef, float %a3, i32 0
  %53 = shufflevector <4 x float> %52, <4 x float> undef, <4 x i32> zeroinitializer
  %54 = insertelement <4 x float> undef, float %b1, i32 0
  %55 = shufflevector <4 x float> %54, <4 x float> undef, <4 x i32> zeroinitializer
  %56 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %55
  %57 = insertelement <4 x float> undef, float %b2, i32 0
  %58 = shufflevector <4 x float> %57, <4 x float> undef, <4 x i32> zeroinitializer
  %59 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %58
  %60 = sext i32 %height to i64
  br label %61

; <label>:61                                      ; preds = %.lr.ph, %61
  %indvars.iv = phi i64 [ %60, %.lr.ph ], [ %indvars.iv.next, %61 ]
  %xn.09 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %79, %61 ]
  %xa.08 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %xn.09, %61 ]
  %yn.07 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %83, %61 ]
  %ya.06 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %yn.07, %61 ]
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  %62 = trunc i64 %indvars.iv.next to i32
  %63 = mul nsw i32 %62, %width
  %64 = add i32 %63, %1
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %65
  %67 = load <4 x i8> addrspace(1)* %66, align 4
  %68 = extractelement <4 x i8> %67, i32 0
  %69 = uitofp i8 %68 to float
  %70 = insertelement <4 x float> undef, float %69, i32 0
  %71 = extractelement <4 x i8> %67, i32 1
  %72 = uitofp i8 %71 to float
  %73 = insertelement <4 x float> %70, float %72, i32 1
  %74 = extractelement <4 x i8> %67, i32 2
  %75 = uitofp i8 %74 to float
  %76 = insertelement <4 x float> %73, float %75, i32 2
  %77 = extractelement <4 x i8> %67, i32 3
  %78 = uitofp i8 %77 to float
  %79 = insertelement <4 x float> %76, float %78, i32 3
  %80 = fmul <4 x float> %53, %xa.08
  %81 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %51, <4 x float> %xn.09, <4 x float> %80)
  %82 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %56, <4 x float> %yn.07, <4 x float> %81)
  %83 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %59, <4 x float> %ya.06, <4 x float> %82)
  %84 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %65
  %85 = load <4 x i8> addrspace(1)* %84, align 4
  %86 = extractelement <4 x i8> %85, i32 0
  %87 = uitofp i8 %86 to float
  %88 = insertelement <4 x float> undef, float %87, i32 0
  %89 = extractelement <4 x i8> %85, i32 1
  %90 = uitofp i8 %89 to float
  %91 = insertelement <4 x float> %88, float %90, i32 1
  %92 = extractelement <4 x i8> %85, i32 2
  %93 = uitofp i8 %92 to float
  %94 = insertelement <4 x float> %91, float %93, i32 2
  %95 = extractelement <4 x i8> %85, i32 3
  %96 = uitofp i8 %95 to float
  %97 = insertelement <4 x float> %94, float %96, i32 3
  %98 = fadd <4 x float> %83, %97
  %99 = extractelement <4 x float> %98, i32 0
  %100 = fptoui float %99 to i8
  %101 = insertelement <4 x i8> undef, i8 %100, i32 0
  %102 = extractelement <4 x float> %98, i32 1
  %103 = fptoui float %102 to i8
  %104 = insertelement <4 x i8> %101, i8 %103, i32 1
  %105 = extractelement <4 x float> %98, i32 2
  %106 = fptoui float %105 to i8
  %107 = insertelement <4 x i8> %104, i8 %106, i32 2
  %108 = extractelement <4 x float> %98, i32 3
  %109 = fptoui float %108 to i8
  %110 = insertelement <4 x i8> %107, i8 %109, i32 3
  store <4 x i8> %110, <4 x i8> addrspace(1)* %84, align 4, !tbaa !3
  %111 = icmp sgt i32 %62, 0
  br i1 %111, label %61, label %.loopexit

.loopexit:                                        ; preds = %._crit_edge, %._crit_edge.thread, %61, %0
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, <4 x i8> addrspace(3)*, i32, i32, i32)* @transpose_kernel}
!1 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, i32, float, float, float, float, float, float, float, float)* @RecursiveGaussian_kernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

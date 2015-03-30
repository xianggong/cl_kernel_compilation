; ModuleID = '../kernel-src/BinomialOption_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @binomial_options(i32 %numSteps, <4 x float> addrspace(1)* nocapture readonly %randArray, <4 x float> addrspace(1)* nocapture %output, <4 x float> addrspace(3)* nocapture %callA, <4 x float> addrspace(3)* nocapture %callB) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #4
  %2 = tail call i32 @get_group_id(i32 0) #4
  %3 = sext i32 %2 to i64
  %4 = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i64 %3
  %5 = load <4 x float> addrspace(1)* %4, align 16, !tbaa !2
  %6 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %5
  %7 = fmul <4 x float> %5, <float 3.000000e+01, float 3.000000e+01, float 3.000000e+01, float 3.000000e+01>
  %8 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %6, <4 x float> <float 5.000000e+00, float 5.000000e+00, float 5.000000e+00, float 5.000000e+00>, <4 x float> %7)
  %9 = fmul <4 x float> %5, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %10 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %6, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %9)
  %11 = fmul <4 x float> %5, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %12 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %6, <4 x float> <float 2.500000e-01, float 2.500000e-01, float 2.500000e-01, float 2.500000e-01>, <4 x float> %11)
  %13 = sitofp i32 %numSteps to float
  %14 = fdiv float 1.000000e+00, %13, !fpmath !5
  %15 = insertelement <4 x float> undef, float %14, i32 0
  %16 = shufflevector <4 x float> %15, <4 x float> undef, <4 x i32> zeroinitializer
  %17 = fmul <4 x float> %12, %16
  %18 = tail call <4 x float> @llvm.sqrt.v4f32(<4 x float> %17)
  %19 = fmul <4 x float> %18, <float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000>
  %20 = fmul <4 x float> %17, <float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000>
  %21 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %20) #4
  %22 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %21, !fpmath !5
  %23 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %19) #4
  %24 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %23, !fpmath !5
  %25 = fsub <4 x float> %21, %24
  %26 = fsub <4 x float> %23, %24
  %27 = fdiv <4 x float> %25, %26, !fpmath !5
  %28 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %27
  %29 = fmul <4 x float> %22, %27
  %30 = fmul <4 x float> %22, %28
  %31 = uitofp i32 %1 to float
  %32 = fsub float -0.000000e+00, %13
  %33 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %31, float %32)
  %34 = insertelement <4 x float> undef, float %33, i32 0
  %35 = shufflevector <4 x float> %34, <4 x float> undef, <4 x i32> zeroinitializer
  %36 = fmul <4 x float> %19, %35
  %37 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %36) #4
  %38 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %10
  %39 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %8, <4 x float> %37, <4 x float> %38)
  %40 = extractelement <4 x float> %39, i32 0
  %41 = fcmp ogt float %40, 0.000000e+00
  %42 = select i1 %41, float %40, float 0.000000e+00
  %43 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %1
  %44 = insertelement <4 x float> undef, float %42, i32 0
  %45 = extractelement <4 x float> %39, i32 1
  %46 = fcmp ogt float %45, 0.000000e+00
  %47 = select i1 %46, float %45, float 0.000000e+00
  %48 = insertelement <4 x float> %44, float %47, i32 1
  %49 = extractelement <4 x float> %39, i32 2
  %50 = fcmp ogt float %49, 0.000000e+00
  %51 = select i1 %50, float %49, float 0.000000e+00
  %52 = insertelement <4 x float> %48, float %51, i32 2
  %53 = extractelement <4 x float> %39, i32 3
  %54 = fcmp ogt float %53, 0.000000e+00
  %55 = select i1 %54, float %53, float 0.000000e+00
  %56 = insertelement <4 x float> %52, float %55, i32 3
  store <4 x float> %56, <4 x float> addrspace(3)* %43, align 16
  tail call void @barrier(i32 1) #4
  %57 = icmp sgt i32 %numSteps, 0
  br i1 %57, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %58 = add i32 %1, 1
  %59 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %58
  %60 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %1
  %61 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %58
  br label %62

; <label>:62                                      ; preds = %.lr.ph, %77
  %j.01 = phi i32 [ %numSteps, %.lr.ph ], [ %78, %77 ]
  %63 = icmp ult i32 %1, %j.01
  br i1 %63, label %64, label %69

; <label>:64                                      ; preds = %62
  %65 = load <4 x float> addrspace(3)* %43, align 16, !tbaa !2
  %66 = load <4 x float> addrspace(3)* %59, align 16, !tbaa !2
  %67 = fmul <4 x float> %30, %66
  %68 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %29, <4 x float> %65, <4 x float> %67)
  store <4 x float> %68, <4 x float> addrspace(3)* %60, align 16, !tbaa !2
  br label %69

; <label>:69                                      ; preds = %64, %62
  tail call void @barrier(i32 1) #4
  %70 = add nsw i32 %j.01, -1
  %71 = icmp ult i32 %1, %70
  br i1 %71, label %72, label %77

; <label>:72                                      ; preds = %69
  %73 = load <4 x float> addrspace(3)* %60, align 16, !tbaa !2
  %74 = load <4 x float> addrspace(3)* %61, align 16, !tbaa !2
  %75 = fmul <4 x float> %30, %74
  %76 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %29, <4 x float> %73, <4 x float> %75)
  store <4 x float> %76, <4 x float> addrspace(3)* %43, align 16, !tbaa !2
  br label %77

; <label>:77                                      ; preds = %72, %69
  tail call void @barrier(i32 1) #4
  %78 = add nsw i32 %j.01, -2
  %79 = icmp sgt i32 %78, 0
  br i1 %79, label %62, label %._crit_edge

._crit_edge:                                      ; preds = %77, %0
  %80 = icmp eq i32 %1, 0
  br i1 %80, label %81, label %84

; <label>:81                                      ; preds = %._crit_edge
  %82 = load <4 x float> addrspace(3)* %callA, align 16, !tbaa !2
  %83 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %3
  store <4 x float> %82, <4 x float> addrspace(1)* %83, align 16, !tbaa !2
  br label %84

; <label>:84                                      ; preds = %81, %._crit_edge
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #3

declare <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*, <4 x float> addrspace(3)*)* @binomial_options}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

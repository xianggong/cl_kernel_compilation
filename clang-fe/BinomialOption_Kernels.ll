; ModuleID = '../kernel-src/BinomialOption_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @binomial_options(i32 %numSteps, <4 x float> addrspace(1)* nocapture readonly %randArray, <4 x float> addrspace(1)* nocapture %output, <4 x float> addrspace(3)* nocapture %callA, <4 x float> addrspace(3)* nocapture %callB) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #3
  %2 = tail call i32 @get_group_id(i32 0) #3
  %3 = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i32 %2
  %4 = load <4 x float> addrspace(1)* %3, align 16, !tbaa !7
  %5 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %4
  %6 = fmul <4 x float> %4, <float 3.000000e+01, float 3.000000e+01, float 3.000000e+01, float 3.000000e+01>
  %7 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %5, <4 x float> <float 5.000000e+00, float 5.000000e+00, float 5.000000e+00, float 5.000000e+00>, <4 x float> %6)
  %8 = fmul <4 x float> %4, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %9 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %5, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %8)
  %10 = fmul <4 x float> %4, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %11 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %5, <4 x float> <float 2.500000e-01, float 2.500000e-01, float 2.500000e-01, float 2.500000e-01>, <4 x float> %10)
  %12 = sitofp i32 %numSteps to float
  %13 = fdiv float 1.000000e+00, %12, !fpmath !10
  %14 = insertelement <4 x float> undef, float %13, i32 0
  %15 = shufflevector <4 x float> %14, <4 x float> undef, <4 x i32> zeroinitializer
  %16 = fmul <4 x float> %11, %15
  %17 = tail call <4 x float> @llvm.sqrt.v4f32(<4 x float> %16)
  %18 = fmul <4 x float> %17, <float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000>
  %19 = fmul <4 x float> %16, <float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000>
  %20 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %19) #3
  %21 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %20, !fpmath !10
  %22 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %18) #3
  %23 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %22, !fpmath !10
  %24 = fsub <4 x float> %20, %23
  %25 = fsub <4 x float> %22, %23
  %26 = fdiv <4 x float> %24, %25, !fpmath !10
  %27 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %26
  %28 = fmul <4 x float> %21, %26
  %29 = fmul <4 x float> %21, %27
  %30 = uitofp i32 %1 to float
  %31 = fsub float -0.000000e+00, %12
  %32 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %30, float %31)
  %33 = insertelement <4 x float> undef, float %32, i32 0
  %34 = shufflevector <4 x float> %33, <4 x float> undef, <4 x i32> zeroinitializer
  %35 = fmul <4 x float> %18, %34
  %36 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %35) #3
  %37 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %9
  %38 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %7, <4 x float> %36, <4 x float> %37)
  %39 = extractelement <4 x float> %38, i32 0
  %40 = fcmp ogt float %39, 0.000000e+00
  %41 = select i1 %40, float %39, float 0.000000e+00
  %42 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %1
  %43 = insertelement <4 x float> undef, float %41, i32 0
  %44 = extractelement <4 x float> %38, i32 1
  %45 = fcmp ogt float %44, 0.000000e+00
  %46 = select i1 %45, float %44, float 0.000000e+00
  %47 = insertelement <4 x float> %43, float %46, i32 1
  %48 = extractelement <4 x float> %38, i32 2
  %49 = fcmp ogt float %48, 0.000000e+00
  %50 = select i1 %49, float %48, float 0.000000e+00
  %51 = insertelement <4 x float> %47, float %50, i32 2
  %52 = extractelement <4 x float> %38, i32 3
  %53 = fcmp ogt float %52, 0.000000e+00
  %54 = select i1 %53, float %52, float 0.000000e+00
  %55 = insertelement <4 x float> %51, float %54, i32 3
  store <4 x float> %55, <4 x float> addrspace(3)* %42, align 16
  tail call void @barrier(i32 1) #3
  %56 = icmp sgt i32 %numSteps, 0
  br i1 %56, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %57 = add i32 %1, 1
  %58 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %57
  %59 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %1
  %60 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %57
  br label %61

; <label>:61                                      ; preds = %.lr.ph, %76
  %j.01 = phi i32 [ %numSteps, %.lr.ph ], [ %77, %76 ]
  %62 = icmp ult i32 %1, %j.01
  br i1 %62, label %63, label %68

; <label>:63                                      ; preds = %61
  %64 = load <4 x float> addrspace(3)* %42, align 16, !tbaa !7
  %65 = load <4 x float> addrspace(3)* %58, align 16, !tbaa !7
  %66 = fmul <4 x float> %29, %65
  %67 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %28, <4 x float> %64, <4 x float> %66)
  store <4 x float> %67, <4 x float> addrspace(3)* %59, align 16, !tbaa !7
  br label %68

; <label>:68                                      ; preds = %63, %61
  tail call void @barrier(i32 1) #3
  %69 = add nsw i32 %j.01, -1
  %70 = icmp ult i32 %1, %69
  br i1 %70, label %71, label %76

; <label>:71                                      ; preds = %68
  %72 = load <4 x float> addrspace(3)* %59, align 16, !tbaa !7
  %73 = load <4 x float> addrspace(3)* %60, align 16, !tbaa !7
  %74 = fmul <4 x float> %29, %73
  %75 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %28, <4 x float> %72, <4 x float> %74)
  store <4 x float> %75, <4 x float> addrspace(3)* %42, align 16, !tbaa !7
  br label %76

; <label>:76                                      ; preds = %71, %68
  tail call void @barrier(i32 1) #3
  %77 = add nsw i32 %j.01, -2
  %78 = icmp sgt i32 %j.01, 2
  br i1 %78, label %61, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %76
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %79 = icmp eq i32 %1, 0
  br i1 %79, label %80, label %83

; <label>:80                                      ; preds = %._crit_edge
  %81 = load <4 x float> addrspace(3)* %callA, align 16, !tbaa !7
  %82 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %2
  store <4 x float> %81, <4 x float> addrspace(1)* %82, align 16, !tbaa !7
  br label %83

; <label>:83                                      ; preds = %80, %._crit_edge
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #2

declare <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*, <4 x float> addrspace(3)*)* @binomial_options, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 1, i32 1, i32 3, i32 3}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int", !"float4*", !"float4*", !"float4*", !"float4*"}
!4 = !{!"kernel_arg_base_type", !"int", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*"}
!5 = !{!"kernel_arg_type_qual", !"", !"const", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{float 2.500000e+00}

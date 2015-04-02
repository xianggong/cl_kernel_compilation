; ModuleID = 'BinomialOption_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @binomial_options(i32 %numSteps, <4 x float> addrspace(1)* %randArray, <4 x float> addrspace(1)* %output, <4 x float> addrspace(3)* %callA, <4 x float> addrspace(3)* %callB) #0 {
  %1 = call i32 @__get_local_id_u32(i32 0)
  %2 = call i32 @__get_group_id_u32(i32 0)
  %3 = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i32 %2
  %4 = load <4 x float> addrspace(1)* %3, align 16
  %5 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %4
  %6 = fmul <4 x float> %4, <float 3.000000e+01, float 3.000000e+01, float 3.000000e+01, float 3.000000e+01>
  %7 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %5, <4 x float> <float 5.000000e+00, float 5.000000e+00, float 5.000000e+00, float 5.000000e+00>, <4 x float> %6)
  %8 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %4
  %9 = fmul <4 x float> %4, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %10 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %8, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %9)
  %11 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %4
  %12 = fmul <4 x float> %4, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %13 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %11, <4 x float> <float 2.500000e-01, float 2.500000e-01, float 2.500000e-01, float 2.500000e-01>, <4 x float> %12)
  %14 = sitofp i32 %numSteps to float
  %15 = fdiv float 1.000000e+00, %14, !fpmath !2
  %16 = insertelement <4 x float> undef, float %15, i32 0
  %17 = shufflevector <4 x float> %16, <4 x float> undef, <4 x i32> zeroinitializer
  %18 = fmul <4 x float> %13, %17
  %19 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %18)
  %20 = fmul <4 x float> <float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000>, %19
  %21 = fmul <4 x float> <float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000>, %18
  %22 = call <4 x float> @_Z3expDv4_f(<4 x float> %21)
  %23 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %22, !fpmath !2
  %24 = call <4 x float> @_Z3expDv4_f(<4 x float> %20)
  %25 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %24, !fpmath !2
  %26 = fsub <4 x float> %22, %25
  %27 = fsub <4 x float> %24, %25
  %28 = fdiv <4 x float> %26, %27, !fpmath !2
  %29 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %28
  %30 = fmul <4 x float> %28, %23
  %31 = fmul <4 x float> %29, %23
  %32 = uitofp i32 %1 to float
  %33 = sitofp i32 %numSteps to float
  %34 = fsub float -0.000000e+00, %33
  %35 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %32, float %34)
  %36 = insertelement <4 x float> undef, float %35, i32 0
  %37 = shufflevector <4 x float> %36, <4 x float> undef, <4 x i32> zeroinitializer
  %38 = fmul <4 x float> %20, %37
  %39 = call <4 x float> @_Z3expDv4_f(<4 x float> %38)
  %40 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %10
  %41 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %7, <4 x float> %39, <4 x float> %40)
  %42 = extractelement <4 x float> %41, i32 0
  %43 = fcmp ogt float %42, 0.000000e+00
  br i1 %43, label %44, label %46

; <label>:44                                      ; preds = %0
  %45 = extractelement <4 x float> %41, i32 0
  br label %47

; <label>:46                                      ; preds = %0
  br label %47

; <label>:47                                      ; preds = %46, %44
  %48 = phi float [ %45, %44 ], [ 0.000000e+00, %46 ]
  %49 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %1
  %50 = load <4 x float> addrspace(3)* %49, align 16
  %51 = insertelement <4 x float> %50, float %48, i32 0
  store <4 x float> %51, <4 x float> addrspace(3)* %49, align 16
  %52 = extractelement <4 x float> %41, i32 1
  %53 = fcmp ogt float %52, 0.000000e+00
  br i1 %53, label %54, label %56

; <label>:54                                      ; preds = %47
  %55 = extractelement <4 x float> %41, i32 1
  br label %57

; <label>:56                                      ; preds = %47
  br label %57

; <label>:57                                      ; preds = %56, %54
  %58 = phi float [ %55, %54 ], [ 0.000000e+00, %56 ]
  %59 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %1
  %60 = load <4 x float> addrspace(3)* %59, align 16
  %61 = insertelement <4 x float> %60, float %58, i32 1
  store <4 x float> %61, <4 x float> addrspace(3)* %59, align 16
  %62 = extractelement <4 x float> %41, i32 2
  %63 = fcmp ogt float %62, 0.000000e+00
  br i1 %63, label %64, label %66

; <label>:64                                      ; preds = %57
  %65 = extractelement <4 x float> %41, i32 2
  br label %67

; <label>:66                                      ; preds = %57
  br label %67

; <label>:67                                      ; preds = %66, %64
  %68 = phi float [ %65, %64 ], [ 0.000000e+00, %66 ]
  %69 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %1
  %70 = load <4 x float> addrspace(3)* %69, align 16
  %71 = insertelement <4 x float> %70, float %68, i32 2
  store <4 x float> %71, <4 x float> addrspace(3)* %69, align 16
  %72 = extractelement <4 x float> %41, i32 3
  %73 = fcmp ogt float %72, 0.000000e+00
  br i1 %73, label %74, label %76

; <label>:74                                      ; preds = %67
  %75 = extractelement <4 x float> %41, i32 3
  br label %77

; <label>:76                                      ; preds = %67
  br label %77

; <label>:77                                      ; preds = %76, %74
  %78 = phi float [ %75, %74 ], [ 0.000000e+00, %76 ]
  %79 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %1
  %80 = load <4 x float> addrspace(3)* %79, align 16
  %81 = insertelement <4 x float> %80, float %78, i32 3
  store <4 x float> %81, <4 x float> addrspace(3)* %79, align 16
  call void @barrier(i32 1)
  br label %82

; <label>:82                                      ; preds = %108, %77
  %j.0 = phi i32 [ %numSteps, %77 ], [ %109, %108 ]
  %83 = icmp sgt i32 %j.0, 0
  br i1 %83, label %84, label %110

; <label>:84                                      ; preds = %82
  %85 = icmp ult i32 %1, %j.0
  br i1 %85, label %86, label %95

; <label>:86                                      ; preds = %84
  %87 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %1
  %88 = load <4 x float> addrspace(3)* %87, align 16
  %89 = add i32 %1, 1
  %90 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %89
  %91 = load <4 x float> addrspace(3)* %90, align 16
  %92 = fmul <4 x float> %31, %91
  %93 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %30, <4 x float> %88, <4 x float> %92)
  %94 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %1
  store <4 x float> %93, <4 x float> addrspace(3)* %94, align 16
  br label %95

; <label>:95                                      ; preds = %86, %84
  call void @barrier(i32 1)
  %96 = sub nsw i32 %j.0, 1
  %97 = icmp ult i32 %1, %96
  br i1 %97, label %98, label %107

; <label>:98                                      ; preds = %95
  %99 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %1
  %100 = load <4 x float> addrspace(3)* %99, align 16
  %101 = add i32 %1, 1
  %102 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %101
  %103 = load <4 x float> addrspace(3)* %102, align 16
  %104 = fmul <4 x float> %31, %103
  %105 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %30, <4 x float> %100, <4 x float> %104)
  %106 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %1
  store <4 x float> %105, <4 x float> addrspace(3)* %106, align 16
  br label %107

; <label>:107                                     ; preds = %98, %95
  call void @barrier(i32 1)
  br label %108

; <label>:108                                     ; preds = %107
  %109 = sub nsw i32 %j.0, 2
  br label %82

; <label>:110                                     ; preds = %82
  %111 = icmp eq i32 %1, 0
  br i1 %111, label %112, label %116

; <label>:112                                     ; preds = %110
  %113 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 0
  %114 = load <4 x float> addrspace(3)* %113, align 16
  %115 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %2
  store <4 x float> %114, <4 x float> addrspace(1)* %115, align 16
  br label %116

; <label>:116                                     ; preds = %112, %110
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

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

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*, <4 x float> addrspace(3)*)* @binomial_options}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

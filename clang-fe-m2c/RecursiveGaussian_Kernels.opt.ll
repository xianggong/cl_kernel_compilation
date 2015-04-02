; ModuleID = 'RecursiveGaussian_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @transpose_kernel(<4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(3)* %block, i32 %width, i32 %height, i32 %blockSize) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = call i32 @__get_local_id_u32(i32 0)
  %4 = call i32 @__get_local_id_u32(i32 1)
  %5 = mul i32 %2, %width
  %6 = add i32 %5, %1
  %7 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %6
  %8 = load <4 x i8> addrspace(1)* %7, align 4
  %9 = mul i32 %4, %blockSize
  %10 = add i32 %9, %3
  %11 = getelementptr inbounds <4 x i8> addrspace(3)* %block, i32 %10
  store <4 x i8> %8, <4 x i8> addrspace(3)* %11, align 4
  call void @barrier(i32 1)
  %12 = mul i32 %4, %blockSize
  %13 = add i32 %12, %3
  %14 = mul i32 %1, %height
  %15 = add i32 %2, %14
  %16 = getelementptr inbounds <4 x i8> addrspace(3)* %block, i32 %13
  %17 = load <4 x i8> addrspace(3)* %16, align 4
  %18 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %15
  store <4 x i8> %17, <4 x i8> addrspace(1)* %18, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @RecursiveGaussian_kernel(<4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)* %output, i32 %width, i32 %height, float %a0, float %a1, float %a2, float %a3, float %b1, float %b2, float %coefp, float %coefn) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = icmp uge i32 %1, %width
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  br label %136

; <label>:4                                       ; preds = %0
  br label %5

; <label>:5                                       ; preds = %57, %4
  %xp.0 = phi <4 x float> [ zeroinitializer, %4 ], [ %29, %57 ]
  %yp.0 = phi <4 x float> [ zeroinitializer, %4 ], [ %43, %57 ]
  %yb.0 = phi <4 x float> [ zeroinitializer, %4 ], [ %yp.0, %57 ]
  %y.0 = phi i32 [ 0, %4 ], [ %58, %57 ]
  %6 = icmp slt i32 %y.0, %height
  br i1 %6, label %7, label %59

; <label>:7                                       ; preds = %5
  %8 = mul nsw i32 %y.0, %width
  %9 = add i32 %1, %8
  %10 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %9
  %11 = load <4 x i8> addrspace(1)* %10, align 4
  %12 = extractelement <4 x i8> %11, i32 0
  %13 = uitofp i8 %12 to float
  %14 = insertelement <4 x float> undef, float %13, i32 0
  %15 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %9
  %16 = load <4 x i8> addrspace(1)* %15, align 4
  %17 = extractelement <4 x i8> %16, i32 1
  %18 = uitofp i8 %17 to float
  %19 = insertelement <4 x float> %14, float %18, i32 1
  %20 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %9
  %21 = load <4 x i8> addrspace(1)* %20, align 4
  %22 = extractelement <4 x i8> %21, i32 2
  %23 = uitofp i8 %22 to float
  %24 = insertelement <4 x float> %19, float %23, i32 2
  %25 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %9
  %26 = load <4 x i8> addrspace(1)* %25, align 4
  %27 = extractelement <4 x i8> %26, i32 3
  %28 = uitofp i8 %27 to float
  %29 = insertelement <4 x float> %24, float %28, i32 3
  %30 = insertelement <4 x float> undef, float %a0, i32 0
  %31 = shufflevector <4 x float> %30, <4 x float> undef, <4 x i32> zeroinitializer
  %32 = insertelement <4 x float> undef, float %a1, i32 0
  %33 = shufflevector <4 x float> %32, <4 x float> undef, <4 x i32> zeroinitializer
  %34 = fmul <4 x float> %33, %xp.0
  %35 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %31, <4 x float> %29, <4 x float> %34)
  %36 = insertelement <4 x float> undef, float %b1, i32 0
  %37 = shufflevector <4 x float> %36, <4 x float> undef, <4 x i32> zeroinitializer
  %38 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %37
  %39 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %38, <4 x float> %yp.0, <4 x float> %35)
  %40 = insertelement <4 x float> undef, float %b2, i32 0
  %41 = shufflevector <4 x float> %40, <4 x float> undef, <4 x i32> zeroinitializer
  %42 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %41
  %43 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %42, <4 x float> %yb.0, <4 x float> %39)
  %44 = extractelement <4 x float> %43, i32 0
  %45 = fptoui float %44 to i8
  %46 = insertelement <4 x i8> undef, i8 %45, i32 0
  %47 = extractelement <4 x float> %43, i32 1
  %48 = fptoui float %47 to i8
  %49 = insertelement <4 x i8> %46, i8 %48, i32 1
  %50 = extractelement <4 x float> %43, i32 2
  %51 = fptoui float %50 to i8
  %52 = insertelement <4 x i8> %49, i8 %51, i32 2
  %53 = extractelement <4 x float> %43, i32 3
  %54 = fptoui float %53 to i8
  %55 = insertelement <4 x i8> %52, i8 %54, i32 3
  %56 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %9
  store <4 x i8> %55, <4 x i8> addrspace(1)* %56, align 4
  br label %57

; <label>:57                                      ; preds = %7
  %58 = add nsw i32 %y.0, 1
  br label %5

; <label>:59                                      ; preds = %5
  call void @barrier(i32 2)
  %60 = sub nsw i32 %height, 1
  br label %61

; <label>:61                                      ; preds = %134, %59
  %xn.0 = phi <4 x float> [ zeroinitializer, %59 ], [ %85, %134 ]
  %xa.0 = phi <4 x float> [ zeroinitializer, %59 ], [ %xn.0, %134 ]
  %yn.0 = phi <4 x float> [ zeroinitializer, %59 ], [ %99, %134 ]
  %ya.0 = phi <4 x float> [ zeroinitializer, %59 ], [ %yn.0, %134 ]
  %y1.0 = phi i32 [ %60, %59 ], [ %135, %134 ]
  %62 = icmp sgt i32 %y1.0, -1
  br i1 %62, label %63, label %136

; <label>:63                                      ; preds = %61
  %64 = mul nsw i32 %y1.0, %width
  %65 = add i32 %1, %64
  %66 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %65
  %67 = load <4 x i8> addrspace(1)* %66, align 4
  %68 = extractelement <4 x i8> %67, i32 0
  %69 = uitofp i8 %68 to float
  %70 = insertelement <4 x float> undef, float %69, i32 0
  %71 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %65
  %72 = load <4 x i8> addrspace(1)* %71, align 4
  %73 = extractelement <4 x i8> %72, i32 1
  %74 = uitofp i8 %73 to float
  %75 = insertelement <4 x float> %70, float %74, i32 1
  %76 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %65
  %77 = load <4 x i8> addrspace(1)* %76, align 4
  %78 = extractelement <4 x i8> %77, i32 2
  %79 = uitofp i8 %78 to float
  %80 = insertelement <4 x float> %75, float %79, i32 2
  %81 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %65
  %82 = load <4 x i8> addrspace(1)* %81, align 4
  %83 = extractelement <4 x i8> %82, i32 3
  %84 = uitofp i8 %83 to float
  %85 = insertelement <4 x float> %80, float %84, i32 3
  %86 = insertelement <4 x float> undef, float %a2, i32 0
  %87 = shufflevector <4 x float> %86, <4 x float> undef, <4 x i32> zeroinitializer
  %88 = insertelement <4 x float> undef, float %a3, i32 0
  %89 = shufflevector <4 x float> %88, <4 x float> undef, <4 x i32> zeroinitializer
  %90 = fmul <4 x float> %89, %xa.0
  %91 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %87, <4 x float> %xn.0, <4 x float> %90)
  %92 = insertelement <4 x float> undef, float %b1, i32 0
  %93 = shufflevector <4 x float> %92, <4 x float> undef, <4 x i32> zeroinitializer
  %94 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %93
  %95 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %94, <4 x float> %yn.0, <4 x float> %91)
  %96 = insertelement <4 x float> undef, float %b2, i32 0
  %97 = shufflevector <4 x float> %96, <4 x float> undef, <4 x i32> zeroinitializer
  %98 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %97
  %99 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %98, <4 x float> %ya.0, <4 x float> %95)
  %100 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %65
  %101 = load <4 x i8> addrspace(1)* %100, align 4
  %102 = extractelement <4 x i8> %101, i32 0
  %103 = uitofp i8 %102 to float
  %104 = insertelement <4 x float> undef, float %103, i32 0
  %105 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %65
  %106 = load <4 x i8> addrspace(1)* %105, align 4
  %107 = extractelement <4 x i8> %106, i32 1
  %108 = uitofp i8 %107 to float
  %109 = insertelement <4 x float> %104, float %108, i32 1
  %110 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %65
  %111 = load <4 x i8> addrspace(1)* %110, align 4
  %112 = extractelement <4 x i8> %111, i32 2
  %113 = uitofp i8 %112 to float
  %114 = insertelement <4 x float> %109, float %113, i32 2
  %115 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %65
  %116 = load <4 x i8> addrspace(1)* %115, align 4
  %117 = extractelement <4 x i8> %116, i32 3
  %118 = uitofp i8 %117 to float
  %119 = insertelement <4 x float> %114, float %118, i32 3
  %120 = fadd <4 x float> %119, %99
  %121 = extractelement <4 x float> %120, i32 0
  %122 = fptoui float %121 to i8
  %123 = insertelement <4 x i8> undef, i8 %122, i32 0
  %124 = extractelement <4 x float> %120, i32 1
  %125 = fptoui float %124 to i8
  %126 = insertelement <4 x i8> %123, i8 %125, i32 1
  %127 = extractelement <4 x float> %120, i32 2
  %128 = fptoui float %127 to i8
  %129 = insertelement <4 x i8> %126, i8 %128, i32 2
  %130 = extractelement <4 x float> %120, i32 3
  %131 = fptoui float %130 to i8
  %132 = insertelement <4 x i8> %129, i8 %131, i32 3
  %133 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %65
  store <4 x i8> %132, <4 x i8> addrspace(1)* %133, align 4
  br label %134

; <label>:134                                     ; preds = %63
  %135 = add nsw i32 %y1.0, -1
  br label %61

; <label>:136                                     ; preds = %61, %3
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, <4 x i8> addrspace(3)*, i32, i32, i32)* @transpose_kernel}
!1 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, i32, float, float, float, float, float, float, float, float)* @RecursiveGaussian_kernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

; ModuleID = 'MonteCarloAsianMultiGPU_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%struct._MonteCalroAttrib = type { <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float> }

; Function Attrs: nounwind
define void @lshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
  %1 = sub i32 32, %shift
  %2 = extractelement <4 x i32> %input, i32 0
  %3 = and i32 %shift, 31
  %4 = shl i32 %2, %3
  %5 = insertelement <4 x i32> undef, i32 %4, i32 0
  %6 = extractelement <4 x i32> %input, i32 1
  %7 = and i32 %shift, 31
  %8 = shl i32 %6, %7
  %9 = extractelement <4 x i32> %input, i32 0
  %10 = and i32 %1, 31
  %11 = lshr i32 %9, %10
  %12 = or i32 %8, %11
  %13 = insertelement <4 x i32> %5, i32 %12, i32 1
  %14 = extractelement <4 x i32> %input, i32 2
  %15 = and i32 %shift, 31
  %16 = shl i32 %14, %15
  %17 = extractelement <4 x i32> %input, i32 1
  %18 = and i32 %1, 31
  %19 = lshr i32 %17, %18
  %20 = or i32 %16, %19
  %21 = insertelement <4 x i32> %13, i32 %20, i32 2
  %22 = extractelement <4 x i32> %input, i32 3
  %23 = and i32 %shift, 31
  %24 = shl i32 %22, %23
  %25 = extractelement <4 x i32> %input, i32 2
  %26 = and i32 %1, 31
  %27 = lshr i32 %25, %26
  %28 = or i32 %24, %27
  %29 = insertelement <4 x i32> %21, i32 %28, i32 3
  store <4 x i32> %29, <4 x i32>* %output, align 16
  ret void
}

; Function Attrs: nounwind
define void @rshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
  %1 = sub i32 32, %shift
  %2 = extractelement <4 x i32> %input, i32 3
  %3 = and i32 %shift, 31
  %4 = lshr i32 %2, %3
  %5 = insertelement <4 x i32> undef, i32 %4, i32 3
  %6 = extractelement <4 x i32> %input, i32 2
  %7 = and i32 %shift, 31
  %8 = lshr i32 %6, %7
  %9 = extractelement <4 x i32> %input, i32 3
  %10 = and i32 %1, 31
  %11 = shl i32 %9, %10
  %12 = or i32 %8, %11
  %13 = insertelement <4 x i32> %5, i32 %12, i32 2
  %14 = extractelement <4 x i32> %input, i32 1
  %15 = and i32 %shift, 31
  %16 = lshr i32 %14, %15
  %17 = extractelement <4 x i32> %input, i32 2
  %18 = and i32 %1, 31
  %19 = shl i32 %17, %18
  %20 = or i32 %16, %19
  %21 = insertelement <4 x i32> %13, i32 %20, i32 1
  %22 = extractelement <4 x i32> %input, i32 0
  %23 = and i32 %shift, 31
  %24 = lshr i32 %22, %23
  %25 = extractelement <4 x i32> %input, i32 1
  %26 = and i32 %1, 31
  %27 = shl i32 %25, %26
  %28 = or i32 %24, %27
  %29 = insertelement <4 x i32> %21, i32 %28, i32 0
  store <4 x i32> %29, <4 x i32>* %output, align 16
  ret void
}

; Function Attrs: nounwind
define void @generateRand(<4 x i32> %seed, <4 x float>* %gaussianRand1, <4 x float>* %gaussianRand2, <4 x i32>* %nextRand) #0 {
  %temp = alloca [8 x <4 x i32>], align 16
  %e = alloca <4 x i32>, align 16
  %f = alloca <4 x i32>, align 16
  %1 = insertelement <4 x i32> undef, i32 1812433253, i32 0
  %2 = shufflevector <4 x i32> %1, <4 x i32> undef, <4 x i32> zeroinitializer
  %3 = insertelement <4 x i32> undef, i32 30, i32 0
  %4 = shufflevector <4 x i32> %3, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> zeroinitializer, <4 x i32>* %e, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %f, align 16
  %5 = and <4 x i32> %4, <i32 31, i32 31, i32 31, i32 31>
  %6 = lshr <4 x i32> %seed, %5
  %7 = xor <4 x i32> %seed, %6
  %8 = mul <4 x i32> %2, %7
  %9 = add <4 x i32> %8, <i32 1, i32 1, i32 1, i32 1>
  %10 = and <4 x i32> %4, <i32 31, i32 31, i32 31, i32 31>
  %11 = lshr <4 x i32> %9, %10
  %12 = xor <4 x i32> %9, %11
  %13 = mul <4 x i32> %2, %12
  %14 = add <4 x i32> %13, <i32 2, i32 2, i32 2, i32 2>
  %15 = and <4 x i32> %4, <i32 31, i32 31, i32 31, i32 31>
  %16 = lshr <4 x i32> %14, %15
  %17 = xor <4 x i32> %14, %16
  %18 = mul <4 x i32> %2, %17
  %19 = add <4 x i32> %18, <i32 3, i32 3, i32 3, i32 3>
  %20 = and <4 x i32> %4, <i32 31, i32 31, i32 31, i32 31>
  %21 = lshr <4 x i32> %19, %20
  %22 = xor <4 x i32> %19, %21
  %23 = mul <4 x i32> %2, %22
  %24 = add <4 x i32> %23, <i32 4, i32 4, i32 4, i32 4>
  br label %25

; <label>:25                                      ; preds = %116, %0
  %r1.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %r1.1, %116 ]
  %r2.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %r2.1, %116 ]
  %a.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %a.1, %116 ]
  %b.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %b.1, %116 ]
  %i.0 = phi i32 [ 0, %0 ], [ %117, %116 ]
  %26 = icmp ult i32 %i.0, 4
  br i1 %26, label %27, label %118

; <label>:27                                      ; preds = %25
  switch i32 %i.0, label %38 [
    i32 0, label %28
    i32 1, label %29
    i32 2, label %32
    i32 3, label %35
  ]

; <label>:28                                      ; preds = %27
  br label %39

; <label>:29                                      ; preds = %27
  %30 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 0
  %31 = load <4 x i32>* %30, align 16
  br label %39

; <label>:32                                      ; preds = %27
  %33 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 1
  %34 = load <4 x i32>* %33, align 16
  br label %39

; <label>:35                                      ; preds = %27
  %36 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 2
  %37 = load <4 x i32>* %36, align 16
  br label %39

; <label>:38                                      ; preds = %27
  br label %39

; <label>:39                                      ; preds = %38, %35, %32, %29, %28
  %r1.1 = phi <4 x i32> [ %r1.0, %38 ], [ %r2.0, %35 ], [ %r2.0, %32 ], [ %r2.0, %29 ], [ %19, %28 ]
  %r2.1 = phi <4 x i32> [ %r2.0, %38 ], [ %37, %35 ], [ %34, %32 ], [ %31, %29 ], [ %24, %28 ]
  %a.1 = phi <4 x i32> [ %a.0, %38 ], [ %19, %35 ], [ %14, %32 ], [ %9, %29 ], [ %seed, %28 ]
  %b.1 = phi <4 x i32> [ %b.0, %38 ], [ %seed, %35 ], [ %24, %32 ], [ %19, %29 ], [ %14, %28 ]
  call void @lshift128(<4 x i32> %a.1, i32 24, <4 x i32>* %e)
  call void @rshift128(<4 x i32> %r1.1, i32 24, <4 x i32>* %f)
  %40 = extractelement <4 x i32> %a.1, i32 0
  %41 = load <4 x i32>* %e, align 16
  %42 = extractelement <4 x i32> %41, i32 0
  %43 = xor i32 %40, %42
  %44 = extractelement <4 x i32> %b.1, i32 0
  %45 = and i32 13, 31
  %46 = lshr i32 %44, %45
  %47 = and i32 %46, -33605633
  %48 = xor i32 %43, %47
  %49 = load <4 x i32>* %f, align 16
  %50 = extractelement <4 x i32> %49, i32 0
  %51 = xor i32 %48, %50
  %52 = extractelement <4 x i32> %r2.1, i32 0
  %53 = and i32 15, 31
  %54 = shl i32 %52, %53
  %55 = xor i32 %51, %54
  %56 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %i.0
  %57 = load <4 x i32>* %56, align 16
  %58 = insertelement <4 x i32> %57, i32 %55, i32 0
  store <4 x i32> %58, <4 x i32>* %56, align 16
  %59 = extractelement <4 x i32> %a.1, i32 1
  %60 = load <4 x i32>* %e, align 16
  %61 = extractelement <4 x i32> %60, i32 1
  %62 = xor i32 %59, %61
  %63 = extractelement <4 x i32> %b.1, i32 1
  %64 = and i32 13, 31
  %65 = lshr i32 %63, %64
  %66 = and i32 %65, -276873347
  %67 = xor i32 %62, %66
  %68 = load <4 x i32>* %f, align 16
  %69 = extractelement <4 x i32> %68, i32 1
  %70 = xor i32 %67, %69
  %71 = extractelement <4 x i32> %r2.1, i32 1
  %72 = and i32 15, 31
  %73 = shl i32 %71, %72
  %74 = xor i32 %70, %73
  %75 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %i.0
  %76 = load <4 x i32>* %75, align 16
  %77 = insertelement <4 x i32> %76, i32 %74, i32 1
  store <4 x i32> %77, <4 x i32>* %75, align 16
  %78 = extractelement <4 x i32> %a.1, i32 2
  %79 = load <4 x i32>* %e, align 16
  %80 = extractelement <4 x i32> %79, i32 2
  %81 = xor i32 %78, %80
  %82 = extractelement <4 x i32> %b.1, i32 2
  %83 = and i32 13, 31
  %84 = lshr i32 %82, %83
  %85 = and i32 %84, -8946819
  %86 = xor i32 %81, %85
  %87 = load <4 x i32>* %f, align 16
  %88 = extractelement <4 x i32> %87, i32 2
  %89 = xor i32 %86, %88
  %90 = extractelement <4 x i32> %r2.1, i32 2
  %91 = and i32 15, 31
  %92 = shl i32 %90, %91
  %93 = xor i32 %89, %92
  %94 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %i.0
  %95 = load <4 x i32>* %94, align 16
  %96 = insertelement <4 x i32> %95, i32 %93, i32 2
  store <4 x i32> %96, <4 x i32>* %94, align 16
  %97 = extractelement <4 x i32> %a.1, i32 3
  %98 = load <4 x i32>* %e, align 16
  %99 = extractelement <4 x i32> %98, i32 3
  %100 = xor i32 %97, %99
  %101 = extractelement <4 x i32> %b.1, i32 3
  %102 = and i32 13, 31
  %103 = lshr i32 %101, %102
  %104 = and i32 %103, 2146958127
  %105 = xor i32 %100, %104
  %106 = load <4 x i32>* %f, align 16
  %107 = extractelement <4 x i32> %106, i32 3
  %108 = xor i32 %105, %107
  %109 = extractelement <4 x i32> %r2.1, i32 3
  %110 = and i32 15, 31
  %111 = shl i32 %109, %110
  %112 = xor i32 %108, %111
  %113 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %i.0
  %114 = load <4 x i32>* %113, align 16
  %115 = insertelement <4 x i32> %114, i32 %112, i32 3
  store <4 x i32> %115, <4 x i32>* %113, align 16
  br label %116

; <label>:116                                     ; preds = %39
  %117 = add i32 %i.0, 1
  br label %25

; <label>:118                                     ; preds = %25
  %119 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 0
  %120 = load <4 x i32>* %119, align 16
  %121 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %120)
  %122 = fmul <4 x float> %121, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %123 = fdiv <4 x float> %122, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !2
  %124 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 1
  %125 = load <4 x i32>* %124, align 16
  %126 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %125)
  %127 = fmul <4 x float> %126, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %128 = fdiv <4 x float> %127, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !2
  %129 = call <4 x float> @llvm.log2.v4f32(<4 x float> %123)
  %130 = fmul <4 x float> %129, <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>
  %131 = fmul <4 x float> <float -2.000000e+00, float -2.000000e+00, float -2.000000e+00, float -2.000000e+00>, %130
  %132 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %131)
  %133 = fmul <4 x float> <float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000>, %128
  %134 = call <4 x float> @_Z3cosDv4_f(<4 x float> %133)
  %135 = fmul <4 x float> %132, %134
  store <4 x float> %135, <4 x float>* %gaussianRand1, align 16
  %136 = call <4 x float> @_Z3sinDv4_f(<4 x float> %133)
  %137 = fmul <4 x float> %132, %136
  store <4 x float> %137, <4 x float>* %gaussianRand2, align 16
  %138 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 2
  %139 = load <4 x i32>* %138, align 16
  store <4 x i32> %139, <4 x i32>* %nextRand, align 16
  ret void
}

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #2

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #2

declare <4 x float> @_Z3cosDv4_f(<4 x float>) #1

declare <4 x float> @_Z3sinDv4_f(<4 x float>) #1

; Function Attrs: nounwind
define void @calOutputs(<4 x float> %strikePrice, <4 x float> %meanDeriv1, <4 x float> %meanDeriv2, <4 x float> %meanPrice1, <4 x float> %meanPrice2, <4 x float>* %pathDeriv1, <4 x float>* %pathDeriv2, <4 x float>* %priceVec1, <4 x float>* %priceVec2) #0 {
  %1 = fsub <4 x float> %meanPrice1, %strikePrice
  %2 = fsub <4 x float> %meanPrice2, %strikePrice
  %3 = extractelement <4 x float> %1, i32 0
  %4 = fcmp ogt float %3, 0.000000e+00
  br i1 %4, label %5, label %9

; <label>:5                                       ; preds = %0
  %6 = insertelement <4 x float> zeroinitializer, float 1.000000e+00, i32 0
  %7 = extractelement <4 x float> %1, i32 0
  %8 = insertelement <4 x float> zeroinitializer, float %7, i32 0
  br label %9

; <label>:9                                       ; preds = %5, %0
  %temp1.0 = phi <4 x float> [ %6, %5 ], [ zeroinitializer, %0 ]
  %temp3.0 = phi <4 x float> [ %8, %5 ], [ zeroinitializer, %0 ]
  %10 = extractelement <4 x float> %1, i32 1
  %11 = fcmp ogt float %10, 0.000000e+00
  br i1 %11, label %12, label %16

; <label>:12                                      ; preds = %9
  %13 = insertelement <4 x float> %temp1.0, float 1.000000e+00, i32 1
  %14 = extractelement <4 x float> %1, i32 1
  %15 = insertelement <4 x float> %temp3.0, float %14, i32 1
  br label %16

; <label>:16                                      ; preds = %12, %9
  %temp1.1 = phi <4 x float> [ %13, %12 ], [ %temp1.0, %9 ]
  %temp3.1 = phi <4 x float> [ %15, %12 ], [ %temp3.0, %9 ]
  %17 = extractelement <4 x float> %1, i32 2
  %18 = fcmp ogt float %17, 0.000000e+00
  br i1 %18, label %19, label %23

; <label>:19                                      ; preds = %16
  %20 = insertelement <4 x float> %temp1.1, float 1.000000e+00, i32 2
  %21 = extractelement <4 x float> %1, i32 2
  %22 = insertelement <4 x float> %temp3.1, float %21, i32 2
  br label %23

; <label>:23                                      ; preds = %19, %16
  %temp1.2 = phi <4 x float> [ %20, %19 ], [ %temp1.1, %16 ]
  %temp3.2 = phi <4 x float> [ %22, %19 ], [ %temp3.1, %16 ]
  %24 = extractelement <4 x float> %1, i32 3
  %25 = fcmp ogt float %24, 0.000000e+00
  br i1 %25, label %26, label %30

; <label>:26                                      ; preds = %23
  %27 = insertelement <4 x float> %temp1.2, float 1.000000e+00, i32 3
  %28 = extractelement <4 x float> %1, i32 3
  %29 = insertelement <4 x float> %temp3.2, float %28, i32 3
  br label %30

; <label>:30                                      ; preds = %26, %23
  %temp1.3 = phi <4 x float> [ %27, %26 ], [ %temp1.2, %23 ]
  %temp3.3 = phi <4 x float> [ %29, %26 ], [ %temp3.2, %23 ]
  %31 = extractelement <4 x float> %2, i32 0
  %32 = fcmp ogt float %31, 0.000000e+00
  br i1 %32, label %33, label %37

; <label>:33                                      ; preds = %30
  %34 = insertelement <4 x float> zeroinitializer, float 1.000000e+00, i32 0
  %35 = extractelement <4 x float> %2, i32 0
  %36 = insertelement <4 x float> zeroinitializer, float %35, i32 0
  br label %37

; <label>:37                                      ; preds = %33, %30
  %temp2.0 = phi <4 x float> [ %34, %33 ], [ zeroinitializer, %30 ]
  %temp4.0 = phi <4 x float> [ %36, %33 ], [ zeroinitializer, %30 ]
  %38 = extractelement <4 x float> %2, i32 1
  %39 = fcmp ogt float %38, 0.000000e+00
  br i1 %39, label %40, label %44

; <label>:40                                      ; preds = %37
  %41 = insertelement <4 x float> %temp2.0, float 1.000000e+00, i32 1
  %42 = extractelement <4 x float> %2, i32 1
  %43 = insertelement <4 x float> %temp4.0, float %42, i32 1
  br label %44

; <label>:44                                      ; preds = %40, %37
  %temp2.1 = phi <4 x float> [ %41, %40 ], [ %temp2.0, %37 ]
  %temp4.1 = phi <4 x float> [ %43, %40 ], [ %temp4.0, %37 ]
  %45 = extractelement <4 x float> %2, i32 2
  %46 = fcmp ogt float %45, 0.000000e+00
  br i1 %46, label %47, label %51

; <label>:47                                      ; preds = %44
  %48 = insertelement <4 x float> %temp2.1, float 1.000000e+00, i32 2
  %49 = extractelement <4 x float> %2, i32 2
  %50 = insertelement <4 x float> %temp4.1, float %49, i32 2
  br label %51

; <label>:51                                      ; preds = %47, %44
  %temp2.2 = phi <4 x float> [ %48, %47 ], [ %temp2.1, %44 ]
  %temp4.2 = phi <4 x float> [ %50, %47 ], [ %temp4.1, %44 ]
  %52 = extractelement <4 x float> %2, i32 3
  %53 = fcmp ogt float %52, 0.000000e+00
  br i1 %53, label %54, label %58

; <label>:54                                      ; preds = %51
  %55 = insertelement <4 x float> %temp2.2, float 1.000000e+00, i32 3
  %56 = extractelement <4 x float> %2, i32 3
  %57 = insertelement <4 x float> %temp4.2, float %56, i32 3
  br label %58

; <label>:58                                      ; preds = %54, %51
  %temp2.3 = phi <4 x float> [ %55, %54 ], [ %temp2.2, %51 ]
  %temp4.3 = phi <4 x float> [ %57, %54 ], [ %temp4.2, %51 ]
  %59 = fmul <4 x float> %meanDeriv1, %temp1.3
  store <4 x float> %59, <4 x float>* %pathDeriv1, align 16
  %60 = fmul <4 x float> %meanDeriv2, %temp2.3
  store <4 x float> %60, <4 x float>* %pathDeriv2, align 16
  store <4 x float> %temp3.3, <4 x float>* %priceVec1, align 16
  store <4 x float> %temp4.3, <4 x float>* %priceVec2, align 16
  ret void
}

; Function Attrs: nounwind
define void @calPriceVega(%struct._MonteCalroAttrib* byval %attrib, i32 %noOfSum, i32 %width, <4 x i32> addrspace(1)* %randArray, <4 x float> addrspace(1)* %priceSamples, <4 x float> addrspace(1)* %pathDeriv) #0 {
  %price1 = alloca <4 x float>, align 16
  %price2 = alloca <4 x float>, align 16
  %pathDeriv1 = alloca <4 x float>, align 16
  %pathDeriv2 = alloca <4 x float>, align 16
  %finalRandf1 = alloca <4 x float>, align 16
  %finalRandf2 = alloca <4 x float>, align 16
  %nextRand = alloca <4 x i32>, align 16
  %1 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 0
  %2 = load <4 x float>* %1, align 16
  %3 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 1
  %4 = load <4 x float>* %3, align 16
  %5 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 2
  %6 = load <4 x float>* %5, align 16
  %7 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 3
  %8 = load <4 x float>* %7, align 16
  %9 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 4
  %10 = load <4 x float>* %9, align 16
  %11 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 5
  %12 = load <4 x float>* %11, align 16
  %13 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 6
  %14 = load <4 x float>* %13, align 16
  %15 = call i32 @__get_global_id_u32(i32 0)
  %16 = call i32 @__get_global_id_u32(i32 1)
  store <4 x float> zeroinitializer, <4 x float>* %price1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %price2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %pathDeriv1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %pathDeriv2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %finalRandf1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %finalRandf2, align 16
  %17 = mul i32 %16, %width
  %18 = add i32 %17, %15
  %19 = getelementptr inbounds <4 x i32> addrspace(1)* %randArray, i32 %18
  %20 = load <4 x i32> addrspace(1)* %19, align 16
  store <4 x i32> %20, <4 x i32>* %nextRand, align 16
  br label %21

; <label>:21                                      ; preds = %52, %0
  %trajPrice1.0 = phi <4 x float> [ %10, %0 ], [ %28, %52 ]
  %trajPrice2.0 = phi <4 x float> [ %10, %0 ], [ %32, %52 ]
  %sumPrice1.0 = phi <4 x float> [ %10, %0 ], [ %33, %52 ]
  %sumPrice2.0 = phi <4 x float> [ %10, %0 ], [ %34, %52 ]
  %sumDeriv1.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %45, %52 ]
  %sumDeriv2.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %51, %52 ]
  %i.0 = phi i32 [ 1, %0 ], [ %53, %52 ]
  %22 = icmp slt i32 %i.0, %noOfSum
  br i1 %22, label %23, label %54

; <label>:23                                      ; preds = %21
  %24 = load <4 x i32>* %nextRand, align 16
  call void @generateRand(<4 x i32> %24, <4 x float>* %finalRandf1, <4 x float>* %finalRandf2, <4 x i32>* %nextRand)
  %25 = load <4 x float>* %finalRandf1, align 16
  %26 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %6, <4 x float> %25, <4 x float> %4)
  %27 = call <4 x float> @_Z3expDv4_f(<4 x float> %26)
  %28 = fmul <4 x float> %trajPrice1.0, %27
  %29 = load <4 x float>* %finalRandf2, align 16
  %30 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %6, <4 x float> %29, <4 x float> %4)
  %31 = call <4 x float> @_Z3expDv4_f(<4 x float> %30)
  %32 = fmul <4 x float> %trajPrice2.0, %31
  %33 = fadd <4 x float> %sumPrice1.0, %28
  %34 = fadd <4 x float> %sumPrice2.0, %32
  %35 = fmul <4 x float> %8, %14
  %36 = sitofp i32 %i.0 to float
  %37 = insertelement <4 x float> undef, float %36, i32 0
  %38 = shufflevector <4 x float> %37, <4 x float> undef, <4 x i32> zeroinitializer
  %39 = fmul <4 x float> %35, %38
  %40 = fdiv <4 x float> %28, %10, !fpmath !2
  %41 = call <4 x float> @llvm.log2.v4f32(<4 x float> %40)
  %42 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %39
  %43 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %41, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %42)
  %44 = fdiv <4 x float> %43, %12, !fpmath !2
  %45 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %28, <4 x float> %44, <4 x float> %sumDeriv1.0)
  %46 = fdiv <4 x float> %32, %10, !fpmath !2
  %47 = call <4 x float> @llvm.log2.v4f32(<4 x float> %46)
  %48 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %39
  %49 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %47, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %48)
  %50 = fdiv <4 x float> %49, %12, !fpmath !2
  %51 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %32, <4 x float> %50, <4 x float> %sumDeriv2.0)
  br label %52

; <label>:52                                      ; preds = %23
  %53 = add nsw i32 %i.0, 1
  br label %21

; <label>:54                                      ; preds = %21
  %55 = sitofp i32 %noOfSum to float
  %56 = insertelement <4 x float> undef, float %55, i32 0
  %57 = shufflevector <4 x float> %56, <4 x float> undef, <4 x i32> zeroinitializer
  %58 = fdiv <4 x float> %sumPrice1.0, %57, !fpmath !2
  %59 = sitofp i32 %noOfSum to float
  %60 = insertelement <4 x float> undef, float %59, i32 0
  %61 = shufflevector <4 x float> %60, <4 x float> undef, <4 x i32> zeroinitializer
  %62 = fdiv <4 x float> %sumPrice2.0, %61, !fpmath !2
  %63 = sitofp i32 %noOfSum to float
  %64 = insertelement <4 x float> undef, float %63, i32 0
  %65 = shufflevector <4 x float> %64, <4 x float> undef, <4 x i32> zeroinitializer
  %66 = fdiv <4 x float> %sumDeriv1.0, %65, !fpmath !2
  %67 = sitofp i32 %noOfSum to float
  %68 = insertelement <4 x float> undef, float %67, i32 0
  %69 = shufflevector <4 x float> %68, <4 x float> undef, <4 x i32> zeroinitializer
  %70 = fdiv <4 x float> %sumDeriv2.0, %69, !fpmath !2
  call void @calOutputs(<4 x float> %2, <4 x float> %66, <4 x float> %70, <4 x float> %58, <4 x float> %62, <4 x float>* %pathDeriv1, <4 x float>* %pathDeriv2, <4 x float>* %price1, <4 x float>* %price2)
  %71 = load <4 x float>* %price1, align 16
  %72 = mul i32 %16, %width
  %73 = add i32 %72, %15
  %74 = mul i32 %73, 2
  %75 = getelementptr inbounds <4 x float> addrspace(1)* %priceSamples, i32 %74
  store <4 x float> %71, <4 x float> addrspace(1)* %75, align 16
  %76 = load <4 x float>* %price2, align 16
  %77 = mul i32 %16, %width
  %78 = add i32 %77, %15
  %79 = mul i32 %78, 2
  %80 = add i32 %79, 1
  %81 = getelementptr inbounds <4 x float> addrspace(1)* %priceSamples, i32 %80
  store <4 x float> %76, <4 x float> addrspace(1)* %81, align 16
  %82 = load <4 x float>* %pathDeriv1, align 16
  %83 = mul i32 %16, %width
  %84 = add i32 %83, %15
  %85 = mul i32 %84, 2
  %86 = getelementptr inbounds <4 x float> addrspace(1)* %pathDeriv, i32 %85
  store <4 x float> %82, <4 x float> addrspace(1)* %86, align 16
  %87 = load <4 x float>* %pathDeriv2, align 16
  %88 = mul i32 %16, %width
  %89 = add i32 %88, %15
  %90 = mul i32 %89, 2
  %91 = add i32 %90, 1
  %92 = getelementptr inbounds <4 x float> addrspace(1)* %pathDeriv, i32 %91
  store <4 x float> %87, <4 x float> addrspace(1)* %92, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #3

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind readnone }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (%struct._MonteCalroAttrib*, i32, i32, <4 x i32> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @calPriceVega}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

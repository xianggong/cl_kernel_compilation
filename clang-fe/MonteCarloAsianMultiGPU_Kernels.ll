; ModuleID = '../kernel-src/MonteCarloAsianMultiGPU_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%struct._MonteCalroAttrib = type { <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float> }

; Function Attrs: nounwind
define void @lshift128(<4 x i32> %input, i32 %shift, <4 x i32>* nocapture %output) #0 {
  %1 = extractelement <4 x i32> %input, i32 0
  %2 = and i32 %shift, 31
  %3 = shl i32 %1, %2
  %4 = insertelement <4 x i32> undef, i32 %3, i32 0
  %5 = extractelement <4 x i32> %input, i32 1
  %6 = shl i32 %5, %2
  %7 = sub i32 0, %shift
  %8 = and i32 %7, 31
  %9 = lshr i32 %1, %8
  %10 = or i32 %6, %9
  %11 = insertelement <4 x i32> %4, i32 %10, i32 1
  %12 = extractelement <4 x i32> %input, i32 2
  %13 = shl i32 %12, %2
  %14 = lshr i32 %5, %8
  %15 = or i32 %13, %14
  %16 = insertelement <4 x i32> %11, i32 %15, i32 2
  %17 = extractelement <4 x i32> %input, i32 3
  %18 = shl i32 %17, %2
  %19 = lshr i32 %12, %8
  %20 = or i32 %18, %19
  %21 = insertelement <4 x i32> %16, i32 %20, i32 3
  store <4 x i32> %21, <4 x i32>* %output, align 16, !tbaa !2
  ret void
}

; Function Attrs: nounwind
define void @rshift128(<4 x i32> %input, i32 %shift, <4 x i32>* nocapture %output) #0 {
  %1 = extractelement <4 x i32> %input, i32 3
  %2 = and i32 %shift, 31
  %3 = lshr i32 %1, %2
  %4 = insertelement <4 x i32> undef, i32 %3, i32 3
  %5 = extractelement <4 x i32> %input, i32 2
  %6 = lshr i32 %5, %2
  %7 = sub i32 0, %shift
  %8 = and i32 %7, 31
  %9 = shl i32 %1, %8
  %10 = or i32 %6, %9
  %11 = insertelement <4 x i32> %4, i32 %10, i32 2
  %12 = extractelement <4 x i32> %input, i32 1
  %13 = lshr i32 %12, %2
  %14 = shl i32 %5, %8
  %15 = or i32 %13, %14
  %16 = insertelement <4 x i32> %11, i32 %15, i32 1
  %17 = extractelement <4 x i32> %input, i32 0
  %18 = lshr i32 %17, %2
  %19 = shl i32 %12, %8
  %20 = or i32 %18, %19
  %21 = insertelement <4 x i32> %16, i32 %20, i32 0
  store <4 x i32> %21, <4 x i32>* %output, align 16, !tbaa !2
  ret void
}

; Function Attrs: nounwind
define void @generateRand(<4 x i32> %seed, <4 x float>* nocapture %gaussianRand1, <4 x float>* nocapture %gaussianRand2, <4 x i32>* nocapture %nextRand) #0 {
  %temp = alloca [8 x <4 x i32>], align 16
  %1 = bitcast [8 x <4 x i32>]* %temp to i8*
  call void @llvm.lifetime.start(i64 128, i8* %1) #1
  %2 = lshr <4 x i32> %seed, <i32 30, i32 30, i32 30, i32 30>
  %3 = xor <4 x i32> %2, %seed
  %4 = mul <4 x i32> %3, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %5 = add <4 x i32> %4, <i32 1, i32 1, i32 1, i32 1>
  %6 = lshr <4 x i32> %5, <i32 30, i32 30, i32 30, i32 30>
  %7 = xor <4 x i32> %5, %6
  %8 = mul <4 x i32> %7, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %9 = add <4 x i32> %8, <i32 2, i32 2, i32 2, i32 2>
  %10 = lshr <4 x i32> %9, <i32 30, i32 30, i32 30, i32 30>
  %11 = xor <4 x i32> %9, %10
  %12 = mul <4 x i32> %11, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %13 = add <4 x i32> %12, <i32 3, i32 3, i32 3, i32 3>
  %14 = lshr <4 x i32> %13, <i32 30, i32 30, i32 30, i32 30>
  %15 = xor <4 x i32> %13, %14
  %16 = mul <4 x i32> %15, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %17 = add <4 x i32> %16, <i32 4, i32 4, i32 4, i32 4>
  %18 = getelementptr inbounds [8 x <4 x i32>]* %temp, i64 0, i64 0
  %19 = getelementptr inbounds [8 x <4 x i32>]* %temp, i64 0, i64 1
  %20 = getelementptr inbounds [8 x <4 x i32>]* %temp, i64 0, i64 2
  br label %21

; <label>:21                                      ; preds = %30, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %30 ]
  %r1.04 = phi <4 x i32> [ zeroinitializer, %0 ], [ %r1.1, %30 ]
  %r2.03 = phi <4 x i32> [ zeroinitializer, %0 ], [ %r2.1, %30 ]
  %a.02 = phi <4 x i32> [ zeroinitializer, %0 ], [ %a.1, %30 ]
  %b.01 = phi <4 x i32> [ zeroinitializer, %0 ], [ %b.1, %30 ]
  %22 = trunc i64 %indvars.iv to i32
  switch i32 %22, label %30 [
    i32 0, label %23
    i32 1, label %24
    i32 2, label %26
    i32 3, label %28
  ]

; <label>:23                                      ; preds = %21
  br label %30

; <label>:24                                      ; preds = %21
  %25 = load <4 x i32>* %18, align 16, !tbaa !2
  br label %30

; <label>:26                                      ; preds = %21
  %27 = load <4 x i32>* %19, align 16, !tbaa !2
  br label %30

; <label>:28                                      ; preds = %21
  %29 = load <4 x i32>* %20, align 16, !tbaa !2
  br label %30

; <label>:30                                      ; preds = %21, %28, %26, %24, %23
  %b.1 = phi <4 x i32> [ %b.01, %21 ], [ %seed, %28 ], [ %17, %26 ], [ %13, %24 ], [ %9, %23 ]
  %a.1 = phi <4 x i32> [ %a.02, %21 ], [ %13, %28 ], [ %9, %26 ], [ %5, %24 ], [ %seed, %23 ]
  %r2.1 = phi <4 x i32> [ %r2.03, %21 ], [ %29, %28 ], [ %27, %26 ], [ %25, %24 ], [ %17, %23 ]
  %r1.1 = phi <4 x i32> [ %r1.04, %21 ], [ %r2.03, %28 ], [ %r2.03, %26 ], [ %r2.03, %24 ], [ %13, %23 ]
  %31 = extractelement <4 x i32> %a.1, i32 0
  %32 = shl i32 %31, 24
  %33 = extractelement <4 x i32> %a.1, i32 1
  %34 = shl i32 %33, 24
  %35 = lshr i32 %31, 8
  %36 = or i32 %34, %35
  %37 = extractelement <4 x i32> %a.1, i32 2
  %38 = shl i32 %37, 24
  %39 = lshr i32 %33, 8
  %40 = or i32 %38, %39
  %41 = extractelement <4 x i32> %a.1, i32 3
  %42 = shl i32 %41, 24
  %43 = lshr i32 %37, 8
  %44 = or i32 %42, %43
  %45 = extractelement <4 x i32> %r1.1, i32 3
  %46 = lshr i32 %45, 24
  %47 = extractelement <4 x i32> %r1.1, i32 2
  %48 = lshr i32 %47, 24
  %49 = shl i32 %45, 8
  %50 = or i32 %48, %49
  %51 = extractelement <4 x i32> %r1.1, i32 1
  %52 = lshr i32 %51, 24
  %53 = shl i32 %47, 8
  %54 = or i32 %52, %53
  %55 = extractelement <4 x i32> %r1.1, i32 0
  %56 = lshr i32 %55, 24
  %57 = shl i32 %51, 8
  %58 = or i32 %56, %57
  %59 = xor i32 %32, %31
  %60 = extractelement <4 x i32> %b.1, i32 0
  %61 = lshr i32 %60, 13
  %62 = and i32 %61, 473087
  %63 = xor i32 %59, %62
  %64 = extractelement <4 x i32> %r2.1, i32 0
  %65 = shl i32 %64, 15
  %66 = xor i32 %63, %65
  %67 = xor i32 %66, %58
  %68 = getelementptr inbounds [8 x <4 x i32>]* %temp, i64 0, i64 %indvars.iv
  %69 = insertelement <4 x i32> undef, i32 %67, i32 0
  %70 = extractelement <4 x i32> %b.1, i32 1
  %71 = lshr i32 %70, 13
  %72 = and i32 %71, 475005
  %73 = extractelement <4 x i32> %r2.1, i32 1
  %74 = shl i32 %73, 15
  %75 = xor i32 %72, %33
  %76 = xor i32 %75, %36
  %77 = xor i32 %76, %74
  %78 = xor i32 %77, %54
  %79 = insertelement <4 x i32> %69, i32 %78, i32 1
  %80 = extractelement <4 x i32> %b.1, i32 2
  %81 = lshr i32 %80, 13
  %82 = and i32 %81, 490365
  %83 = extractelement <4 x i32> %r2.1, i32 2
  %84 = shl i32 %83, 15
  %85 = xor i32 %82, %37
  %86 = xor i32 %85, %40
  %87 = xor i32 %86, %84
  %88 = xor i32 %87, %50
  %89 = insertelement <4 x i32> %79, i32 %88, i32 2
  %90 = extractelement <4 x i32> %b.1, i32 3
  %91 = lshr i32 %90, 13
  %92 = and i32 %91, 523055
  %93 = extractelement <4 x i32> %r2.1, i32 3
  %94 = shl i32 %93, 15
  %95 = xor i32 %92, %41
  %96 = xor i32 %95, %44
  %97 = xor i32 %96, %94
  %98 = xor i32 %97, %46
  %99 = insertelement <4 x i32> %89, i32 %98, i32 3
  store <4 x i32> %99, <4 x i32>* %68, align 16
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 4
  br i1 %exitcond, label %100, label %21

; <label>:100                                     ; preds = %30
  %101 = load <4 x i32>* %18, align 16, !tbaa !2
  %102 = tail call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %101) #1
  %103 = fdiv <4 x float> %102, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !5
  %104 = load <4 x i32>* %19, align 16, !tbaa !2
  %105 = tail call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %104) #1
  %106 = fdiv <4 x float> %105, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !5
  %107 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %103)
  %108 = fmul <4 x float> %107, <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>
  %109 = fmul <4 x float> %108, <float -2.000000e+00, float -2.000000e+00, float -2.000000e+00, float -2.000000e+00>
  %110 = tail call <4 x float> @llvm.sqrt.v4f32(<4 x float> %109)
  %111 = fmul <4 x float> %106, <float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000>
  %112 = tail call <4 x float> @_Z3cosDv4_f(<4 x float> %111) #1
  %113 = fmul <4 x float> %110, %112
  store <4 x float> %113, <4 x float>* %gaussianRand1, align 16, !tbaa !2
  %114 = tail call <4 x float> @_Z3sinDv4_f(<4 x float> %111) #1
  %115 = fmul <4 x float> %110, %114
  store <4 x float> %115, <4 x float>* %gaussianRand2, align 16, !tbaa !2
  %116 = load <4 x i32>* %20, align 16, !tbaa !2
  store <4 x i32> %116, <4 x i32>* %nextRand, align 16, !tbaa !2
  call void @llvm.lifetime.end(i64 128, i8* %1) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #2

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #3

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #3

declare <4 x float> @_Z3cosDv4_f(<4 x float>) #2

declare <4 x float> @_Z3sinDv4_f(<4 x float>) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind
define void @calOutputs(<4 x float> %strikePrice, <4 x float> %meanDeriv1, <4 x float> %meanDeriv2, <4 x float> %meanPrice1, <4 x float> %meanPrice2, <4 x float>* nocapture %pathDeriv1, <4 x float>* nocapture %pathDeriv2, <4 x float>* nocapture %priceVec1, <4 x float>* nocapture %priceVec2) #0 {
  %1 = fsub <4 x float> %meanPrice1, %strikePrice
  %2 = fsub <4 x float> %meanPrice2, %strikePrice
  %3 = extractelement <4 x float> %1, i32 0
  %4 = fcmp ogt float %3, 0.000000e+00
  br i1 %4, label %5, label %7

; <label>:5                                       ; preds = %0
  %6 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %1, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %7

; <label>:7                                       ; preds = %5, %0
  %temp3.0 = phi <4 x float> [ %6, %5 ], [ zeroinitializer, %0 ]
  %temp1.0 = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %5 ], [ zeroinitializer, %0 ]
  %8 = extractelement <4 x float> %1, i32 1
  %9 = fcmp ogt float %8, 0.000000e+00
  br i1 %9, label %10, label %13

; <label>:10                                      ; preds = %7
  %11 = insertelement <4 x float> %temp1.0, float 1.000000e+00, i32 1
  %12 = shufflevector <4 x float> %temp3.0, <4 x float> %1, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %13

; <label>:13                                      ; preds = %10, %7
  %temp3.1 = phi <4 x float> [ %12, %10 ], [ %temp3.0, %7 ]
  %temp1.1 = phi <4 x float> [ %11, %10 ], [ %temp1.0, %7 ]
  %14 = extractelement <4 x float> %1, i32 2
  %15 = fcmp ogt float %14, 0.000000e+00
  br i1 %15, label %16, label %19

; <label>:16                                      ; preds = %13
  %17 = insertelement <4 x float> %temp1.1, float 1.000000e+00, i32 2
  %18 = shufflevector <4 x float> %temp3.1, <4 x float> %1, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %19

; <label>:19                                      ; preds = %16, %13
  %temp3.2 = phi <4 x float> [ %18, %16 ], [ %temp3.1, %13 ]
  %temp1.2 = phi <4 x float> [ %17, %16 ], [ %temp1.1, %13 ]
  %20 = extractelement <4 x float> %1, i32 3
  %21 = fcmp ogt float %20, 0.000000e+00
  br i1 %21, label %22, label %25

; <label>:22                                      ; preds = %19
  %23 = insertelement <4 x float> %temp1.2, float 1.000000e+00, i32 3
  %24 = shufflevector <4 x float> %temp3.2, <4 x float> %1, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %25

; <label>:25                                      ; preds = %22, %19
  %temp3.3 = phi <4 x float> [ %24, %22 ], [ %temp3.2, %19 ]
  %temp1.3 = phi <4 x float> [ %23, %22 ], [ %temp1.2, %19 ]
  %26 = extractelement <4 x float> %2, i32 0
  %27 = fcmp ogt float %26, 0.000000e+00
  br i1 %27, label %28, label %30

; <label>:28                                      ; preds = %25
  %29 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %2, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %30

; <label>:30                                      ; preds = %28, %25
  %temp4.0 = phi <4 x float> [ %29, %28 ], [ zeroinitializer, %25 ]
  %temp2.0 = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %28 ], [ zeroinitializer, %25 ]
  %31 = extractelement <4 x float> %2, i32 1
  %32 = fcmp ogt float %31, 0.000000e+00
  br i1 %32, label %33, label %36

; <label>:33                                      ; preds = %30
  %34 = insertelement <4 x float> %temp2.0, float 1.000000e+00, i32 1
  %35 = shufflevector <4 x float> %temp4.0, <4 x float> %2, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %36

; <label>:36                                      ; preds = %33, %30
  %temp4.1 = phi <4 x float> [ %35, %33 ], [ %temp4.0, %30 ]
  %temp2.1 = phi <4 x float> [ %34, %33 ], [ %temp2.0, %30 ]
  %37 = extractelement <4 x float> %2, i32 2
  %38 = fcmp ogt float %37, 0.000000e+00
  br i1 %38, label %39, label %42

; <label>:39                                      ; preds = %36
  %40 = insertelement <4 x float> %temp2.1, float 1.000000e+00, i32 2
  %41 = shufflevector <4 x float> %temp4.1, <4 x float> %2, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %42

; <label>:42                                      ; preds = %39, %36
  %temp4.2 = phi <4 x float> [ %41, %39 ], [ %temp4.1, %36 ]
  %temp2.2 = phi <4 x float> [ %40, %39 ], [ %temp2.1, %36 ]
  %43 = extractelement <4 x float> %2, i32 3
  %44 = fcmp ogt float %43, 0.000000e+00
  br i1 %44, label %45, label %48

; <label>:45                                      ; preds = %42
  %46 = insertelement <4 x float> %temp2.2, float 1.000000e+00, i32 3
  %47 = shufflevector <4 x float> %temp4.2, <4 x float> %2, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %48

; <label>:48                                      ; preds = %45, %42
  %temp4.3 = phi <4 x float> [ %47, %45 ], [ %temp4.2, %42 ]
  %temp2.3 = phi <4 x float> [ %46, %45 ], [ %temp2.2, %42 ]
  %49 = fmul <4 x float> %temp1.3, %meanDeriv1
  store <4 x float> %49, <4 x float>* %pathDeriv1, align 16, !tbaa !2
  %50 = fmul <4 x float> %temp2.3, %meanDeriv2
  store <4 x float> %50, <4 x float>* %pathDeriv2, align 16, !tbaa !2
  store <4 x float> %temp3.3, <4 x float>* %priceVec1, align 16, !tbaa !2
  store <4 x float> %temp4.3, <4 x float>* %priceVec2, align 16, !tbaa !2
  ret void
}

; Function Attrs: nounwind
define void @calPriceVega(%struct._MonteCalroAttrib* byval nocapture readonly %attrib, i32 %noOfSum, i32 %width, <4 x i32> addrspace(1)* nocapture readonly %randArray, <4 x float> addrspace(1)* nocapture %priceSamples, <4 x float> addrspace(1)* nocapture %pathDeriv) #0 {
  %finalRandf1 = alloca <4 x float>, align 16
  %finalRandf2 = alloca <4 x float>, align 16
  %nextRand = alloca <4 x i32>, align 16
  %1 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 0
  %2 = load <4 x float>* %1, align 16, !tbaa !6
  %3 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 1
  %4 = load <4 x float>* %3, align 16, !tbaa !8
  %5 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 2
  %6 = load <4 x float>* %5, align 16, !tbaa !9
  %7 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 3
  %8 = load <4 x float>* %7, align 16, !tbaa !10
  %9 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 4
  %10 = load <4 x float>* %9, align 16, !tbaa !11
  %11 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 5
  %12 = load <4 x float>* %11, align 16, !tbaa !12
  %13 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 6
  %14 = load <4 x float>* %13, align 16, !tbaa !13
  %15 = tail call i32 @get_global_id(i32 0) #1
  %16 = tail call i32 @get_global_id(i32 1) #1
  store <4 x float> zeroinitializer, <4 x float>* %finalRandf1, align 16, !tbaa !2
  store <4 x float> zeroinitializer, <4 x float>* %finalRandf2, align 16, !tbaa !2
  %17 = mul i32 %16, %width
  %18 = add i32 %17, %15
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds <4 x i32> addrspace(1)* %randArray, i64 %19
  %21 = load <4 x i32> addrspace(1)* %20, align 16, !tbaa !2
  store <4 x i32> %21, <4 x i32>* %nextRand, align 16, !tbaa !2
  %22 = icmp sgt i32 %noOfSum, 1
  br i1 %22, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %23 = fmul <4 x float> %8, %14
  br label %24

; <label>:24                                      ; preds = %._crit_edge14, %.lr.ph
  %25 = phi <4 x i32> [ %21, %.lr.ph ], [ %.pre, %._crit_edge14 ]
  %i.07 = phi i32 [ 1, %.lr.ph ], [ %51, %._crit_edge14 ]
  %sumDeriv2.06 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %50, %._crit_edge14 ]
  %sumDeriv1.05 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %45, %._crit_edge14 ]
  %sumPrice2.04 = phi <4 x float> [ %10, %.lr.ph ], [ %35, %._crit_edge14 ]
  %sumPrice1.03 = phi <4 x float> [ %10, %.lr.ph ], [ %34, %._crit_edge14 ]
  %trajPrice2.02 = phi <4 x float> [ %10, %.lr.ph ], [ %33, %._crit_edge14 ]
  %trajPrice1.01 = phi <4 x float> [ %10, %.lr.ph ], [ %29, %._crit_edge14 ]
  call void @generateRand(<4 x i32> %25, <4 x float>* %finalRandf1, <4 x float>* %finalRandf2, <4 x i32>* %nextRand)
  %26 = load <4 x float>* %finalRandf1, align 16, !tbaa !2
  %27 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %6, <4 x float> %26, <4 x float> %4)
  %28 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %27) #1
  %29 = fmul <4 x float> %trajPrice1.01, %28
  %30 = load <4 x float>* %finalRandf2, align 16, !tbaa !2
  %31 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %6, <4 x float> %30, <4 x float> %4)
  %32 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %31) #1
  %33 = fmul <4 x float> %trajPrice2.02, %32
  %34 = fadd <4 x float> %sumPrice1.03, %29
  %35 = fadd <4 x float> %sumPrice2.04, %33
  %36 = sitofp i32 %i.07 to float
  %37 = insertelement <4 x float> undef, float %36, i32 0
  %38 = shufflevector <4 x float> %37, <4 x float> undef, <4 x i32> zeroinitializer
  %39 = fmul <4 x float> %23, %38
  %40 = fdiv <4 x float> %29, %10, !fpmath !5
  %41 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %40)
  %42 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %39
  %43 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %41, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %42)
  %44 = fdiv <4 x float> %43, %12, !fpmath !5
  %45 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %29, <4 x float> %44, <4 x float> %sumDeriv1.05)
  %46 = fdiv <4 x float> %33, %10, !fpmath !5
  %47 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %46)
  %48 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %47, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %42)
  %49 = fdiv <4 x float> %48, %12, !fpmath !5
  %50 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %33, <4 x float> %49, <4 x float> %sumDeriv2.06)
  %51 = add nsw i32 %i.07, 1
  %exitcond = icmp eq i32 %51, %noOfSum
  br i1 %exitcond, label %._crit_edge, label %._crit_edge14

._crit_edge14:                                    ; preds = %24
  %.pre = load <4 x i32>* %nextRand, align 16, !tbaa !2
  br label %24

._crit_edge:                                      ; preds = %24, %0
  %sumDeriv2.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %50, %24 ]
  %sumDeriv1.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %45, %24 ]
  %sumPrice2.0.lcssa = phi <4 x float> [ %10, %0 ], [ %35, %24 ]
  %sumPrice1.0.lcssa = phi <4 x float> [ %10, %0 ], [ %34, %24 ]
  %52 = sitofp i32 %noOfSum to float
  %53 = insertelement <4 x float> undef, float %52, i32 0
  %54 = shufflevector <4 x float> %53, <4 x float> undef, <4 x i32> zeroinitializer
  %55 = fdiv <4 x float> %sumPrice1.0.lcssa, %54, !fpmath !5
  %56 = fdiv <4 x float> %sumPrice2.0.lcssa, %54, !fpmath !5
  %57 = fdiv <4 x float> %sumDeriv1.0.lcssa, %54, !fpmath !5
  %58 = fdiv <4 x float> %sumDeriv2.0.lcssa, %54, !fpmath !5
  %59 = fsub <4 x float> %55, %2
  %60 = fsub <4 x float> %56, %2
  %61 = extractelement <4 x float> %59, i32 0
  %62 = fcmp ogt float %61, 0.000000e+00
  br i1 %62, label %63, label %65

; <label>:63                                      ; preds = %._crit_edge
  %64 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %59, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %65

; <label>:65                                      ; preds = %63, %._crit_edge
  %temp3.0.i = phi <4 x float> [ %64, %63 ], [ zeroinitializer, %._crit_edge ]
  %temp1.0.i = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %63 ], [ zeroinitializer, %._crit_edge ]
  %66 = extractelement <4 x float> %59, i32 1
  %67 = fcmp ogt float %66, 0.000000e+00
  br i1 %67, label %68, label %71

; <label>:68                                      ; preds = %65
  %69 = insertelement <4 x float> %temp1.0.i, float 1.000000e+00, i32 1
  %70 = shufflevector <4 x float> %temp3.0.i, <4 x float> %59, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %71

; <label>:71                                      ; preds = %68, %65
  %temp3.1.i = phi <4 x float> [ %70, %68 ], [ %temp3.0.i, %65 ]
  %temp1.1.i = phi <4 x float> [ %69, %68 ], [ %temp1.0.i, %65 ]
  %72 = extractelement <4 x float> %59, i32 2
  %73 = fcmp ogt float %72, 0.000000e+00
  br i1 %73, label %74, label %77

; <label>:74                                      ; preds = %71
  %75 = insertelement <4 x float> %temp1.1.i, float 1.000000e+00, i32 2
  %76 = shufflevector <4 x float> %temp3.1.i, <4 x float> %59, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %77

; <label>:77                                      ; preds = %74, %71
  %temp3.2.i = phi <4 x float> [ %76, %74 ], [ %temp3.1.i, %71 ]
  %temp1.2.i = phi <4 x float> [ %75, %74 ], [ %temp1.1.i, %71 ]
  %78 = extractelement <4 x float> %59, i32 3
  %79 = fcmp ogt float %78, 0.000000e+00
  br i1 %79, label %80, label %83

; <label>:80                                      ; preds = %77
  %81 = insertelement <4 x float> %temp1.2.i, float 1.000000e+00, i32 3
  %82 = shufflevector <4 x float> %temp3.2.i, <4 x float> %59, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %83

; <label>:83                                      ; preds = %80, %77
  %temp3.3.i = phi <4 x float> [ %82, %80 ], [ %temp3.2.i, %77 ]
  %temp1.3.i = phi <4 x float> [ %81, %80 ], [ %temp1.2.i, %77 ]
  %84 = extractelement <4 x float> %60, i32 0
  %85 = fcmp ogt float %84, 0.000000e+00
  br i1 %85, label %86, label %88

; <label>:86                                      ; preds = %83
  %87 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %60, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %88

; <label>:88                                      ; preds = %86, %83
  %temp4.0.i = phi <4 x float> [ %87, %86 ], [ zeroinitializer, %83 ]
  %temp2.0.i = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %86 ], [ zeroinitializer, %83 ]
  %89 = extractelement <4 x float> %60, i32 1
  %90 = fcmp ogt float %89, 0.000000e+00
  br i1 %90, label %91, label %94

; <label>:91                                      ; preds = %88
  %92 = insertelement <4 x float> %temp2.0.i, float 1.000000e+00, i32 1
  %93 = shufflevector <4 x float> %temp4.0.i, <4 x float> %60, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %94

; <label>:94                                      ; preds = %91, %88
  %temp4.1.i = phi <4 x float> [ %93, %91 ], [ %temp4.0.i, %88 ]
  %temp2.1.i = phi <4 x float> [ %92, %91 ], [ %temp2.0.i, %88 ]
  %95 = extractelement <4 x float> %60, i32 2
  %96 = fcmp ogt float %95, 0.000000e+00
  br i1 %96, label %97, label %100

; <label>:97                                      ; preds = %94
  %98 = insertelement <4 x float> %temp2.1.i, float 1.000000e+00, i32 2
  %99 = shufflevector <4 x float> %temp4.1.i, <4 x float> %60, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %100

; <label>:100                                     ; preds = %97, %94
  %temp4.2.i = phi <4 x float> [ %99, %97 ], [ %temp4.1.i, %94 ]
  %temp2.2.i = phi <4 x float> [ %98, %97 ], [ %temp2.1.i, %94 ]
  %101 = extractelement <4 x float> %60, i32 3
  %102 = fcmp ogt float %101, 0.000000e+00
  br i1 %102, label %103, label %calOutputs.exit

; <label>:103                                     ; preds = %100
  %104 = insertelement <4 x float> %temp2.2.i, float 1.000000e+00, i32 3
  %105 = shufflevector <4 x float> %temp4.2.i, <4 x float> %60, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %calOutputs.exit

calOutputs.exit:                                  ; preds = %100, %103
  %temp4.3.i = phi <4 x float> [ %105, %103 ], [ %temp4.2.i, %100 ]
  %temp2.3.i = phi <4 x float> [ %104, %103 ], [ %temp2.2.i, %100 ]
  %106 = fmul <4 x float> %57, %temp1.3.i
  %107 = fmul <4 x float> %58, %temp2.3.i
  %108 = shl i32 %18, 1
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds <4 x float> addrspace(1)* %priceSamples, i64 %109
  store <4 x float> %temp3.3.i, <4 x float> addrspace(1)* %110, align 16, !tbaa !2
  %111 = or i32 %108, 1
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds <4 x float> addrspace(1)* %priceSamples, i64 %112
  store <4 x float> %temp4.3.i, <4 x float> addrspace(1)* %113, align 16, !tbaa !2
  %114 = getelementptr inbounds <4 x float> addrspace(1)* %pathDeriv, i64 %109
  store <4 x float> %106, <4 x float> addrspace(1)* %114, align 16, !tbaa !2
  %115 = getelementptr inbounds <4 x float> addrspace(1)* %pathDeriv, i64 %112
  store <4 x float> %107, <4 x float> addrspace(1)* %115, align 16, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #2

declare <4 x float> @_Z3expDv4_f(<4 x float>) #2

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #4

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind readnone }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (%struct._MonteCalroAttrib*, i32, i32, <4 x i32> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @calPriceVega}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}
!6 = metadata !{metadata !7, metadata !3, i64 0}
!7 = metadata !{metadata !"_MonteCalroAttrib", metadata !3, i64 0, metadata !3, i64 16, metadata !3, i64 32, metadata !3, i64 48, metadata !3, i64 64, metadata !3, i64 80, metadata !3, i64 96}
!8 = metadata !{metadata !7, metadata !3, i64 16}
!9 = metadata !{metadata !7, metadata !3, i64 32}
!10 = metadata !{metadata !7, metadata !3, i64 48}
!11 = metadata !{metadata !7, metadata !3, i64 64}
!12 = metadata !{metadata !7, metadata !3, i64 80}
!13 = metadata !{metadata !7, metadata !3, i64 96}

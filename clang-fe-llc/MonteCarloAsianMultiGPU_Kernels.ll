; ModuleID = '../kernel-src/MonteCarloAsianMultiGPU_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%struct._MonteCalroAttrib = type { <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float> }

; Function Attrs: nounwind
define void @lshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
  %1 = alloca <4 x i32>, align 16
  %2 = alloca i32, align 4
  %3 = alloca <4 x i32>*, align 4
  %invshift = alloca i32, align 4
  %temp = alloca <4 x i32>, align 16
  store <4 x i32> %input, <4 x i32>* %1, align 16
  store i32 %shift, i32* %2, align 4
  store <4 x i32>* %output, <4 x i32>** %3, align 4
  %4 = load i32* %2, align 4
  %5 = sub i32 32, %4
  store i32 %5, i32* %invshift, align 4
  %6 = load <4 x i32>* %1, align 16
  %7 = extractelement <4 x i32> %6, i32 0
  %8 = load i32* %2, align 4
  %9 = and i32 %8, 31
  %10 = shl i32 %7, %9
  %11 = load <4 x i32>* %temp, align 16
  %12 = insertelement <4 x i32> %11, i32 %10, i32 0
  store <4 x i32> %12, <4 x i32>* %temp, align 16
  %13 = load <4 x i32>* %1, align 16
  %14 = extractelement <4 x i32> %13, i32 1
  %15 = load i32* %2, align 4
  %16 = and i32 %15, 31
  %17 = shl i32 %14, %16
  %18 = load <4 x i32>* %1, align 16
  %19 = extractelement <4 x i32> %18, i32 0
  %20 = load i32* %invshift, align 4
  %21 = and i32 %20, 31
  %22 = lshr i32 %19, %21
  %23 = or i32 %17, %22
  %24 = load <4 x i32>* %temp, align 16
  %25 = insertelement <4 x i32> %24, i32 %23, i32 1
  store <4 x i32> %25, <4 x i32>* %temp, align 16
  %26 = load <4 x i32>* %1, align 16
  %27 = extractelement <4 x i32> %26, i32 2
  %28 = load i32* %2, align 4
  %29 = and i32 %28, 31
  %30 = shl i32 %27, %29
  %31 = load <4 x i32>* %1, align 16
  %32 = extractelement <4 x i32> %31, i32 1
  %33 = load i32* %invshift, align 4
  %34 = and i32 %33, 31
  %35 = lshr i32 %32, %34
  %36 = or i32 %30, %35
  %37 = load <4 x i32>* %temp, align 16
  %38 = insertelement <4 x i32> %37, i32 %36, i32 2
  store <4 x i32> %38, <4 x i32>* %temp, align 16
  %39 = load <4 x i32>* %1, align 16
  %40 = extractelement <4 x i32> %39, i32 3
  %41 = load i32* %2, align 4
  %42 = and i32 %41, 31
  %43 = shl i32 %40, %42
  %44 = load <4 x i32>* %1, align 16
  %45 = extractelement <4 x i32> %44, i32 2
  %46 = load i32* %invshift, align 4
  %47 = and i32 %46, 31
  %48 = lshr i32 %45, %47
  %49 = or i32 %43, %48
  %50 = load <4 x i32>* %temp, align 16
  %51 = insertelement <4 x i32> %50, i32 %49, i32 3
  store <4 x i32> %51, <4 x i32>* %temp, align 16
  %52 = load <4 x i32>* %temp, align 16
  %53 = load <4 x i32>** %3, align 4
  store <4 x i32> %52, <4 x i32>* %53, align 16
  ret void
}

; Function Attrs: nounwind
define void @rshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
  %1 = alloca <4 x i32>, align 16
  %2 = alloca i32, align 4
  %3 = alloca <4 x i32>*, align 4
  %invshift = alloca i32, align 4
  %temp = alloca <4 x i32>, align 16
  store <4 x i32> %input, <4 x i32>* %1, align 16
  store i32 %shift, i32* %2, align 4
  store <4 x i32>* %output, <4 x i32>** %3, align 4
  %4 = load i32* %2, align 4
  %5 = sub i32 32, %4
  store i32 %5, i32* %invshift, align 4
  %6 = load <4 x i32>* %1, align 16
  %7 = extractelement <4 x i32> %6, i32 3
  %8 = load i32* %2, align 4
  %9 = and i32 %8, 31
  %10 = lshr i32 %7, %9
  %11 = load <4 x i32>* %temp, align 16
  %12 = insertelement <4 x i32> %11, i32 %10, i32 3
  store <4 x i32> %12, <4 x i32>* %temp, align 16
  %13 = load <4 x i32>* %1, align 16
  %14 = extractelement <4 x i32> %13, i32 2
  %15 = load i32* %2, align 4
  %16 = and i32 %15, 31
  %17 = lshr i32 %14, %16
  %18 = load <4 x i32>* %1, align 16
  %19 = extractelement <4 x i32> %18, i32 3
  %20 = load i32* %invshift, align 4
  %21 = and i32 %20, 31
  %22 = shl i32 %19, %21
  %23 = or i32 %17, %22
  %24 = load <4 x i32>* %temp, align 16
  %25 = insertelement <4 x i32> %24, i32 %23, i32 2
  store <4 x i32> %25, <4 x i32>* %temp, align 16
  %26 = load <4 x i32>* %1, align 16
  %27 = extractelement <4 x i32> %26, i32 1
  %28 = load i32* %2, align 4
  %29 = and i32 %28, 31
  %30 = lshr i32 %27, %29
  %31 = load <4 x i32>* %1, align 16
  %32 = extractelement <4 x i32> %31, i32 2
  %33 = load i32* %invshift, align 4
  %34 = and i32 %33, 31
  %35 = shl i32 %32, %34
  %36 = or i32 %30, %35
  %37 = load <4 x i32>* %temp, align 16
  %38 = insertelement <4 x i32> %37, i32 %36, i32 1
  store <4 x i32> %38, <4 x i32>* %temp, align 16
  %39 = load <4 x i32>* %1, align 16
  %40 = extractelement <4 x i32> %39, i32 0
  %41 = load i32* %2, align 4
  %42 = and i32 %41, 31
  %43 = lshr i32 %40, %42
  %44 = load <4 x i32>* %1, align 16
  %45 = extractelement <4 x i32> %44, i32 1
  %46 = load i32* %invshift, align 4
  %47 = and i32 %46, 31
  %48 = shl i32 %45, %47
  %49 = or i32 %43, %48
  %50 = load <4 x i32>* %temp, align 16
  %51 = insertelement <4 x i32> %50, i32 %49, i32 0
  store <4 x i32> %51, <4 x i32>* %temp, align 16
  %52 = load <4 x i32>* %temp, align 16
  %53 = load <4 x i32>** %3, align 4
  store <4 x i32> %52, <4 x i32>* %53, align 16
  ret void
}

; Function Attrs: nounwind
define void @generateRand(<4 x i32> %seed, <4 x float>* %gaussianRand1, <4 x float>* %gaussianRand2, <4 x i32>* %nextRand) #0 {
  %1 = alloca <4 x i32>, align 16
  %2 = alloca <4 x float>*, align 4
  %3 = alloca <4 x float>*, align 4
  %4 = alloca <4 x i32>*, align 4
  %mulFactor = alloca i32, align 4
  %temp = alloca [8 x <4 x i32>], align 16
  %state1 = alloca <4 x i32>, align 16
  %state2 = alloca <4 x i32>, align 16
  %state3 = alloca <4 x i32>, align 16
  %state4 = alloca <4 x i32>, align 16
  %state5 = alloca <4 x i32>, align 16
  %stateMask = alloca i32, align 4
  %thirty = alloca i32, align 4
  %mask4 = alloca <4 x i32>, align 16
  %thirty4 = alloca <4 x i32>, align 16
  %one4 = alloca <4 x i32>, align 16
  %two4 = alloca <4 x i32>, align 16
  %three4 = alloca <4 x i32>, align 16
  %four4 = alloca <4 x i32>, align 16
  %r1 = alloca <4 x i32>, align 16
  %r2 = alloca <4 x i32>, align 16
  %a = alloca <4 x i32>, align 16
  %b = alloca <4 x i32>, align 16
  %e = alloca <4 x i32>, align 16
  %f = alloca <4 x i32>, align 16
  %thirteen = alloca i32, align 4
  %fifteen = alloca i32, align 4
  %shift = alloca i32, align 4
  %mask11 = alloca i32, align 4
  %mask12 = alloca i32, align 4
  %mask13 = alloca i32, align 4
  %mask14 = alloca i32, align 4
  %one = alloca float, align 4
  %intMax = alloca float, align 4
  %PI = alloca float, align 4
  %two = alloca float, align 4
  %r = alloca <4 x float>, align 16
  %phi = alloca <4 x float>, align 16
  %temp1 = alloca <4 x float>, align 16
  %temp2 = alloca <4 x float>, align 16
  %i = alloca i32, align 4
  store <4 x i32> %seed, <4 x i32>* %1, align 16
  store <4 x float>* %gaussianRand1, <4 x float>** %2, align 4
  store <4 x float>* %gaussianRand2, <4 x float>** %3, align 4
  store <4 x i32>* %nextRand, <4 x i32>** %4, align 4
  store i32 4, i32* %mulFactor, align 4
  %5 = load <4 x i32>* %1, align 16
  store <4 x i32> %5, <4 x i32>* %state1, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state2, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state3, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state4, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state5, align 16
  store i32 1812433253, i32* %stateMask, align 4
  store i32 30, i32* %thirty, align 4
  %6 = load i32* %stateMask, align 4
  %7 = insertelement <4 x i32> undef, i32 %6, i32 0
  %8 = shufflevector <4 x i32> %7, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %8, <4 x i32>* %mask4, align 16
  %9 = load i32* %thirty, align 4
  %10 = insertelement <4 x i32> undef, i32 %9, i32 0
  %11 = shufflevector <4 x i32> %10, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %11, <4 x i32>* %thirty4, align 16
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %one4, align 16
  store <4 x i32> <i32 2, i32 2, i32 2, i32 2>, <4 x i32>* %two4, align 16
  store <4 x i32> <i32 3, i32 3, i32 3, i32 3>, <4 x i32>* %three4, align 16
  store <4 x i32> <i32 4, i32 4, i32 4, i32 4>, <4 x i32>* %four4, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %r1, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %r2, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %a, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %b, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %e, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %f, align 16
  store i32 13, i32* %thirteen, align 4
  store i32 15, i32* %fifteen, align 4
  store i32 24, i32* %shift, align 4
  store i32 -33605633, i32* %mask11, align 4
  store i32 -276873347, i32* %mask12, align 4
  store i32 -8946819, i32* %mask13, align 4
  store i32 2146958127, i32* %mask14, align 4
  store float 1.000000e+00, float* %one, align 4
  store float 0x41F0000000000000, float* %intMax, align 4
  store float 0x400921FB60000000, float* %PI, align 4
  store float 2.000000e+00, float* %two, align 4
  %12 = load <4 x i32>* %mask4, align 16
  %13 = load <4 x i32>* %state1, align 16
  %14 = load <4 x i32>* %state1, align 16
  %15 = load <4 x i32>* %thirty4, align 16
  %16 = and <4 x i32> %15, <i32 31, i32 31, i32 31, i32 31>
  %17 = lshr <4 x i32> %14, %16
  %18 = xor <4 x i32> %13, %17
  %19 = mul <4 x i32> %12, %18
  %20 = load <4 x i32>* %one4, align 16
  %21 = add <4 x i32> %19, %20
  store <4 x i32> %21, <4 x i32>* %state2, align 16
  %22 = load <4 x i32>* %mask4, align 16
  %23 = load <4 x i32>* %state2, align 16
  %24 = load <4 x i32>* %state2, align 16
  %25 = load <4 x i32>* %thirty4, align 16
  %26 = and <4 x i32> %25, <i32 31, i32 31, i32 31, i32 31>
  %27 = lshr <4 x i32> %24, %26
  %28 = xor <4 x i32> %23, %27
  %29 = mul <4 x i32> %22, %28
  %30 = load <4 x i32>* %two4, align 16
  %31 = add <4 x i32> %29, %30
  store <4 x i32> %31, <4 x i32>* %state3, align 16
  %32 = load <4 x i32>* %mask4, align 16
  %33 = load <4 x i32>* %state3, align 16
  %34 = load <4 x i32>* %state3, align 16
  %35 = load <4 x i32>* %thirty4, align 16
  %36 = and <4 x i32> %35, <i32 31, i32 31, i32 31, i32 31>
  %37 = lshr <4 x i32> %34, %36
  %38 = xor <4 x i32> %33, %37
  %39 = mul <4 x i32> %32, %38
  %40 = load <4 x i32>* %three4, align 16
  %41 = add <4 x i32> %39, %40
  store <4 x i32> %41, <4 x i32>* %state4, align 16
  %42 = load <4 x i32>* %mask4, align 16
  %43 = load <4 x i32>* %state4, align 16
  %44 = load <4 x i32>* %state4, align 16
  %45 = load <4 x i32>* %thirty4, align 16
  %46 = and <4 x i32> %45, <i32 31, i32 31, i32 31, i32 31>
  %47 = lshr <4 x i32> %44, %46
  %48 = xor <4 x i32> %43, %47
  %49 = mul <4 x i32> %42, %48
  %50 = load <4 x i32>* %four4, align 16
  %51 = add <4 x i32> %49, %50
  store <4 x i32> %51, <4 x i32>* %state5, align 16
  store i32 0, i32* %i, align 4
  store i32 0, i32* %i, align 4
  br label %52

; <label>:52                                      ; preds = %191, %0
  %53 = load i32* %i, align 4
  %54 = load i32* %mulFactor, align 4
  %55 = icmp ult i32 %53, %54
  br i1 %55, label %56, label %194

; <label>:56                                      ; preds = %52
  %57 = load i32* %i, align 4
  switch i32 %57, label %81 [
    i32 0, label %58
    i32 1, label %63
    i32 2, label %69
    i32 3, label %75
  ]

; <label>:58                                      ; preds = %56
  %59 = load <4 x i32>* %state4, align 16
  store <4 x i32> %59, <4 x i32>* %r1, align 16
  %60 = load <4 x i32>* %state5, align 16
  store <4 x i32> %60, <4 x i32>* %r2, align 16
  %61 = load <4 x i32>* %state1, align 16
  store <4 x i32> %61, <4 x i32>* %a, align 16
  %62 = load <4 x i32>* %state3, align 16
  store <4 x i32> %62, <4 x i32>* %b, align 16
  br label %82

; <label>:63                                      ; preds = %56
  %64 = load <4 x i32>* %r2, align 16
  store <4 x i32> %64, <4 x i32>* %r1, align 16
  %65 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 0
  %66 = load <4 x i32>* %65, align 16
  store <4 x i32> %66, <4 x i32>* %r2, align 16
  %67 = load <4 x i32>* %state2, align 16
  store <4 x i32> %67, <4 x i32>* %a, align 16
  %68 = load <4 x i32>* %state4, align 16
  store <4 x i32> %68, <4 x i32>* %b, align 16
  br label %82

; <label>:69                                      ; preds = %56
  %70 = load <4 x i32>* %r2, align 16
  store <4 x i32> %70, <4 x i32>* %r1, align 16
  %71 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 1
  %72 = load <4 x i32>* %71, align 16
  store <4 x i32> %72, <4 x i32>* %r2, align 16
  %73 = load <4 x i32>* %state3, align 16
  store <4 x i32> %73, <4 x i32>* %a, align 16
  %74 = load <4 x i32>* %state5, align 16
  store <4 x i32> %74, <4 x i32>* %b, align 16
  br label %82

; <label>:75                                      ; preds = %56
  %76 = load <4 x i32>* %r2, align 16
  store <4 x i32> %76, <4 x i32>* %r1, align 16
  %77 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 2
  %78 = load <4 x i32>* %77, align 16
  store <4 x i32> %78, <4 x i32>* %r2, align 16
  %79 = load <4 x i32>* %state4, align 16
  store <4 x i32> %79, <4 x i32>* %a, align 16
  %80 = load <4 x i32>* %state1, align 16
  store <4 x i32> %80, <4 x i32>* %b, align 16
  br label %82

; <label>:81                                      ; preds = %56
  br label %82

; <label>:82                                      ; preds = %81, %75, %69, %63, %58
  %83 = load <4 x i32>* %a, align 16
  %84 = load i32* %shift, align 4
  call void @lshift128(<4 x i32> %83, i32 %84, <4 x i32>* %e)
  %85 = load <4 x i32>* %r1, align 16
  %86 = load i32* %shift, align 4
  call void @rshift128(<4 x i32> %85, i32 %86, <4 x i32>* %f)
  %87 = load <4 x i32>* %a, align 16
  %88 = extractelement <4 x i32> %87, i32 0
  %89 = load <4 x i32>* %e, align 16
  %90 = extractelement <4 x i32> %89, i32 0
  %91 = xor i32 %88, %90
  %92 = load <4 x i32>* %b, align 16
  %93 = extractelement <4 x i32> %92, i32 0
  %94 = load i32* %thirteen, align 4
  %95 = and i32 %94, 31
  %96 = lshr i32 %93, %95
  %97 = load i32* %mask11, align 4
  %98 = and i32 %96, %97
  %99 = xor i32 %91, %98
  %100 = load <4 x i32>* %f, align 16
  %101 = extractelement <4 x i32> %100, i32 0
  %102 = xor i32 %99, %101
  %103 = load <4 x i32>* %r2, align 16
  %104 = extractelement <4 x i32> %103, i32 0
  %105 = load i32* %fifteen, align 4
  %106 = and i32 %105, 31
  %107 = shl i32 %104, %106
  %108 = xor i32 %102, %107
  %109 = load i32* %i, align 4
  %110 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %109
  %111 = load <4 x i32>* %110, align 16
  %112 = insertelement <4 x i32> %111, i32 %108, i32 0
  store <4 x i32> %112, <4 x i32>* %110, align 16
  %113 = load <4 x i32>* %a, align 16
  %114 = extractelement <4 x i32> %113, i32 1
  %115 = load <4 x i32>* %e, align 16
  %116 = extractelement <4 x i32> %115, i32 1
  %117 = xor i32 %114, %116
  %118 = load <4 x i32>* %b, align 16
  %119 = extractelement <4 x i32> %118, i32 1
  %120 = load i32* %thirteen, align 4
  %121 = and i32 %120, 31
  %122 = lshr i32 %119, %121
  %123 = load i32* %mask12, align 4
  %124 = and i32 %122, %123
  %125 = xor i32 %117, %124
  %126 = load <4 x i32>* %f, align 16
  %127 = extractelement <4 x i32> %126, i32 1
  %128 = xor i32 %125, %127
  %129 = load <4 x i32>* %r2, align 16
  %130 = extractelement <4 x i32> %129, i32 1
  %131 = load i32* %fifteen, align 4
  %132 = and i32 %131, 31
  %133 = shl i32 %130, %132
  %134 = xor i32 %128, %133
  %135 = load i32* %i, align 4
  %136 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %135
  %137 = load <4 x i32>* %136, align 16
  %138 = insertelement <4 x i32> %137, i32 %134, i32 1
  store <4 x i32> %138, <4 x i32>* %136, align 16
  %139 = load <4 x i32>* %a, align 16
  %140 = extractelement <4 x i32> %139, i32 2
  %141 = load <4 x i32>* %e, align 16
  %142 = extractelement <4 x i32> %141, i32 2
  %143 = xor i32 %140, %142
  %144 = load <4 x i32>* %b, align 16
  %145 = extractelement <4 x i32> %144, i32 2
  %146 = load i32* %thirteen, align 4
  %147 = and i32 %146, 31
  %148 = lshr i32 %145, %147
  %149 = load i32* %mask13, align 4
  %150 = and i32 %148, %149
  %151 = xor i32 %143, %150
  %152 = load <4 x i32>* %f, align 16
  %153 = extractelement <4 x i32> %152, i32 2
  %154 = xor i32 %151, %153
  %155 = load <4 x i32>* %r2, align 16
  %156 = extractelement <4 x i32> %155, i32 2
  %157 = load i32* %fifteen, align 4
  %158 = and i32 %157, 31
  %159 = shl i32 %156, %158
  %160 = xor i32 %154, %159
  %161 = load i32* %i, align 4
  %162 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %161
  %163 = load <4 x i32>* %162, align 16
  %164 = insertelement <4 x i32> %163, i32 %160, i32 2
  store <4 x i32> %164, <4 x i32>* %162, align 16
  %165 = load <4 x i32>* %a, align 16
  %166 = extractelement <4 x i32> %165, i32 3
  %167 = load <4 x i32>* %e, align 16
  %168 = extractelement <4 x i32> %167, i32 3
  %169 = xor i32 %166, %168
  %170 = load <4 x i32>* %b, align 16
  %171 = extractelement <4 x i32> %170, i32 3
  %172 = load i32* %thirteen, align 4
  %173 = and i32 %172, 31
  %174 = lshr i32 %171, %173
  %175 = load i32* %mask14, align 4
  %176 = and i32 %174, %175
  %177 = xor i32 %169, %176
  %178 = load <4 x i32>* %f, align 16
  %179 = extractelement <4 x i32> %178, i32 3
  %180 = xor i32 %177, %179
  %181 = load <4 x i32>* %r2, align 16
  %182 = extractelement <4 x i32> %181, i32 3
  %183 = load i32* %fifteen, align 4
  %184 = and i32 %183, 31
  %185 = shl i32 %182, %184
  %186 = xor i32 %180, %185
  %187 = load i32* %i, align 4
  %188 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %187
  %189 = load <4 x i32>* %188, align 16
  %190 = insertelement <4 x i32> %189, i32 %186, i32 3
  store <4 x i32> %190, <4 x i32>* %188, align 16
  br label %191

; <label>:191                                     ; preds = %82
  %192 = load i32* %i, align 4
  %193 = add i32 %192, 1
  store i32 %193, i32* %i, align 4
  br label %52

; <label>:194                                     ; preds = %52
  %195 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 0
  %196 = load <4 x i32>* %195, align 16
  %197 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %196)
  %198 = fmul <4 x float> %197, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %199 = fdiv <4 x float> %198, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !2
  store <4 x float> %199, <4 x float>* %temp1, align 16
  %200 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 1
  %201 = load <4 x i32>* %200, align 16
  %202 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %201)
  %203 = fmul <4 x float> %202, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %204 = fdiv <4 x float> %203, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !2
  store <4 x float> %204, <4 x float>* %temp2, align 16
  %205 = load <4 x float>* %temp1, align 16
  %206 = call <4 x float> @llvm.log2.v4f32(<4 x float> %205)
  %207 = fmul <4 x float> %206, <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>
  %208 = fmul <4 x float> <float -2.000000e+00, float -2.000000e+00, float -2.000000e+00, float -2.000000e+00>, %207
  %209 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %208)
  store <4 x float> %209, <4 x float>* %r, align 16
  %210 = load <4 x float>* %temp2, align 16
  %211 = fmul <4 x float> <float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000>, %210
  store <4 x float> %211, <4 x float>* %phi, align 16
  %212 = load <4 x float>* %r, align 16
  %213 = load <4 x float>* %phi, align 16
  %214 = call <4 x float> @_Z3cosDv4_f(<4 x float> %213)
  %215 = fmul <4 x float> %212, %214
  %216 = load <4 x float>** %2, align 4
  store <4 x float> %215, <4 x float>* %216, align 16
  %217 = load <4 x float>* %r, align 16
  %218 = load <4 x float>* %phi, align 16
  %219 = call <4 x float> @_Z3sinDv4_f(<4 x float> %218)
  %220 = fmul <4 x float> %217, %219
  %221 = load <4 x float>** %3, align 4
  store <4 x float> %220, <4 x float>* %221, align 16
  %222 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 2
  %223 = load <4 x i32>* %222, align 16
  %224 = load <4 x i32>** %4, align 4
  store <4 x i32> %223, <4 x i32>* %224, align 16
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
  %1 = alloca <4 x float>, align 16
  %2 = alloca <4 x float>, align 16
  %3 = alloca <4 x float>, align 16
  %4 = alloca <4 x float>, align 16
  %5 = alloca <4 x float>, align 16
  %6 = alloca <4 x float>*, align 4
  %7 = alloca <4 x float>*, align 4
  %8 = alloca <4 x float>*, align 4
  %9 = alloca <4 x float>*, align 4
  %temp1 = alloca <4 x float>, align 16
  %temp2 = alloca <4 x float>, align 16
  %temp3 = alloca <4 x float>, align 16
  %temp4 = alloca <4 x float>, align 16
  %tempDiff1 = alloca <4 x float>, align 16
  %tempDiff2 = alloca <4 x float>, align 16
  store <4 x float> %strikePrice, <4 x float>* %1, align 16
  store <4 x float> %meanDeriv1, <4 x float>* %2, align 16
  store <4 x float> %meanDeriv2, <4 x float>* %3, align 16
  store <4 x float> %meanPrice1, <4 x float>* %4, align 16
  store <4 x float> %meanPrice2, <4 x float>* %5, align 16
  store <4 x float>* %pathDeriv1, <4 x float>** %6, align 4
  store <4 x float>* %pathDeriv2, <4 x float>** %7, align 4
  store <4 x float>* %priceVec1, <4 x float>** %8, align 4
  store <4 x float>* %priceVec2, <4 x float>** %9, align 4
  store <4 x float> zeroinitializer, <4 x float>* %temp1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %temp2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %temp3, align 16
  store <4 x float> zeroinitializer, <4 x float>* %temp4, align 16
  %10 = load <4 x float>* %4, align 16
  %11 = load <4 x float>* %1, align 16
  %12 = fsub <4 x float> %10, %11
  store <4 x float> %12, <4 x float>* %tempDiff1, align 16
  %13 = load <4 x float>* %5, align 16
  %14 = load <4 x float>* %1, align 16
  %15 = fsub <4 x float> %13, %14
  store <4 x float> %15, <4 x float>* %tempDiff2, align 16
  %16 = load <4 x float>* %tempDiff1, align 16
  %17 = extractelement <4 x float> %16, i32 0
  %18 = fcmp ogt float %17, 0.000000e+00
  br i1 %18, label %19, label %26

; <label>:19                                      ; preds = %0
  %20 = load <4 x float>* %temp1, align 16
  %21 = insertelement <4 x float> %20, float 1.000000e+00, i32 0
  store <4 x float> %21, <4 x float>* %temp1, align 16
  %22 = load <4 x float>* %tempDiff1, align 16
  %23 = extractelement <4 x float> %22, i32 0
  %24 = load <4 x float>* %temp3, align 16
  %25 = insertelement <4 x float> %24, float %23, i32 0
  store <4 x float> %25, <4 x float>* %temp3, align 16
  br label %26

; <label>:26                                      ; preds = %19, %0
  %27 = load <4 x float>* %tempDiff1, align 16
  %28 = extractelement <4 x float> %27, i32 1
  %29 = fcmp ogt float %28, 0.000000e+00
  br i1 %29, label %30, label %37

; <label>:30                                      ; preds = %26
  %31 = load <4 x float>* %temp1, align 16
  %32 = insertelement <4 x float> %31, float 1.000000e+00, i32 1
  store <4 x float> %32, <4 x float>* %temp1, align 16
  %33 = load <4 x float>* %tempDiff1, align 16
  %34 = extractelement <4 x float> %33, i32 1
  %35 = load <4 x float>* %temp3, align 16
  %36 = insertelement <4 x float> %35, float %34, i32 1
  store <4 x float> %36, <4 x float>* %temp3, align 16
  br label %37

; <label>:37                                      ; preds = %30, %26
  %38 = load <4 x float>* %tempDiff1, align 16
  %39 = extractelement <4 x float> %38, i32 2
  %40 = fcmp ogt float %39, 0.000000e+00
  br i1 %40, label %41, label %48

; <label>:41                                      ; preds = %37
  %42 = load <4 x float>* %temp1, align 16
  %43 = insertelement <4 x float> %42, float 1.000000e+00, i32 2
  store <4 x float> %43, <4 x float>* %temp1, align 16
  %44 = load <4 x float>* %tempDiff1, align 16
  %45 = extractelement <4 x float> %44, i32 2
  %46 = load <4 x float>* %temp3, align 16
  %47 = insertelement <4 x float> %46, float %45, i32 2
  store <4 x float> %47, <4 x float>* %temp3, align 16
  br label %48

; <label>:48                                      ; preds = %41, %37
  %49 = load <4 x float>* %tempDiff1, align 16
  %50 = extractelement <4 x float> %49, i32 3
  %51 = fcmp ogt float %50, 0.000000e+00
  br i1 %51, label %52, label %59

; <label>:52                                      ; preds = %48
  %53 = load <4 x float>* %temp1, align 16
  %54 = insertelement <4 x float> %53, float 1.000000e+00, i32 3
  store <4 x float> %54, <4 x float>* %temp1, align 16
  %55 = load <4 x float>* %tempDiff1, align 16
  %56 = extractelement <4 x float> %55, i32 3
  %57 = load <4 x float>* %temp3, align 16
  %58 = insertelement <4 x float> %57, float %56, i32 3
  store <4 x float> %58, <4 x float>* %temp3, align 16
  br label %59

; <label>:59                                      ; preds = %52, %48
  %60 = load <4 x float>* %tempDiff2, align 16
  %61 = extractelement <4 x float> %60, i32 0
  %62 = fcmp ogt float %61, 0.000000e+00
  br i1 %62, label %63, label %70

; <label>:63                                      ; preds = %59
  %64 = load <4 x float>* %temp2, align 16
  %65 = insertelement <4 x float> %64, float 1.000000e+00, i32 0
  store <4 x float> %65, <4 x float>* %temp2, align 16
  %66 = load <4 x float>* %tempDiff2, align 16
  %67 = extractelement <4 x float> %66, i32 0
  %68 = load <4 x float>* %temp4, align 16
  %69 = insertelement <4 x float> %68, float %67, i32 0
  store <4 x float> %69, <4 x float>* %temp4, align 16
  br label %70

; <label>:70                                      ; preds = %63, %59
  %71 = load <4 x float>* %tempDiff2, align 16
  %72 = extractelement <4 x float> %71, i32 1
  %73 = fcmp ogt float %72, 0.000000e+00
  br i1 %73, label %74, label %81

; <label>:74                                      ; preds = %70
  %75 = load <4 x float>* %temp2, align 16
  %76 = insertelement <4 x float> %75, float 1.000000e+00, i32 1
  store <4 x float> %76, <4 x float>* %temp2, align 16
  %77 = load <4 x float>* %tempDiff2, align 16
  %78 = extractelement <4 x float> %77, i32 1
  %79 = load <4 x float>* %temp4, align 16
  %80 = insertelement <4 x float> %79, float %78, i32 1
  store <4 x float> %80, <4 x float>* %temp4, align 16
  br label %81

; <label>:81                                      ; preds = %74, %70
  %82 = load <4 x float>* %tempDiff2, align 16
  %83 = extractelement <4 x float> %82, i32 2
  %84 = fcmp ogt float %83, 0.000000e+00
  br i1 %84, label %85, label %92

; <label>:85                                      ; preds = %81
  %86 = load <4 x float>* %temp2, align 16
  %87 = insertelement <4 x float> %86, float 1.000000e+00, i32 2
  store <4 x float> %87, <4 x float>* %temp2, align 16
  %88 = load <4 x float>* %tempDiff2, align 16
  %89 = extractelement <4 x float> %88, i32 2
  %90 = load <4 x float>* %temp4, align 16
  %91 = insertelement <4 x float> %90, float %89, i32 2
  store <4 x float> %91, <4 x float>* %temp4, align 16
  br label %92

; <label>:92                                      ; preds = %85, %81
  %93 = load <4 x float>* %tempDiff2, align 16
  %94 = extractelement <4 x float> %93, i32 3
  %95 = fcmp ogt float %94, 0.000000e+00
  br i1 %95, label %96, label %103

; <label>:96                                      ; preds = %92
  %97 = load <4 x float>* %temp2, align 16
  %98 = insertelement <4 x float> %97, float 1.000000e+00, i32 3
  store <4 x float> %98, <4 x float>* %temp2, align 16
  %99 = load <4 x float>* %tempDiff2, align 16
  %100 = extractelement <4 x float> %99, i32 3
  %101 = load <4 x float>* %temp4, align 16
  %102 = insertelement <4 x float> %101, float %100, i32 3
  store <4 x float> %102, <4 x float>* %temp4, align 16
  br label %103

; <label>:103                                     ; preds = %96, %92
  %104 = load <4 x float>* %2, align 16
  %105 = load <4 x float>* %temp1, align 16
  %106 = fmul <4 x float> %104, %105
  %107 = load <4 x float>** %6, align 4
  store <4 x float> %106, <4 x float>* %107, align 16
  %108 = load <4 x float>* %3, align 16
  %109 = load <4 x float>* %temp2, align 16
  %110 = fmul <4 x float> %108, %109
  %111 = load <4 x float>** %7, align 4
  store <4 x float> %110, <4 x float>* %111, align 16
  %112 = load <4 x float>* %temp3, align 16
  %113 = load <4 x float>** %8, align 4
  store <4 x float> %112, <4 x float>* %113, align 16
  %114 = load <4 x float>* %temp4, align 16
  %115 = load <4 x float>** %9, align 4
  store <4 x float> %114, <4 x float>* %115, align 16
  ret void
}

; Function Attrs: nounwind
define void @calPriceVega(%struct._MonteCalroAttrib* byval %attrib, i32 %noOfSum, i32 %width, <4 x i32> addrspace(1)* %randArray, <4 x float> addrspace(1)* %priceSamples, <4 x float> addrspace(1)* %pathDeriv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca <4 x i32> addrspace(1)*, align 4
  %4 = alloca <4 x float> addrspace(1)*, align 4
  %5 = alloca <4 x float> addrspace(1)*, align 4
  %strikePrice = alloca <4 x float>, align 16
  %c1 = alloca <4 x float>, align 16
  %c2 = alloca <4 x float>, align 16
  %c3 = alloca <4 x float>, align 16
  %initPrice = alloca <4 x float>, align 16
  %sigma = alloca <4 x float>, align 16
  %timeStep = alloca <4 x float>, align 16
  %xPos = alloca i32, align 4
  %yPos = alloca i32, align 4
  %temp = alloca <4 x float>, align 16
  %price1 = alloca <4 x float>, align 16
  %price2 = alloca <4 x float>, align 16
  %pathDeriv1 = alloca <4 x float>, align 16
  %pathDeriv2 = alloca <4 x float>, align 16
  %trajPrice1 = alloca <4 x float>, align 16
  %trajPrice2 = alloca <4 x float>, align 16
  %sumPrice1 = alloca <4 x float>, align 16
  %sumPrice2 = alloca <4 x float>, align 16
  %meanPrice1 = alloca <4 x float>, align 16
  %meanPrice2 = alloca <4 x float>, align 16
  %sumDeriv1 = alloca <4 x float>, align 16
  %sumDeriv2 = alloca <4 x float>, align 16
  %meanDeriv1 = alloca <4 x float>, align 16
  %meanDeriv2 = alloca <4 x float>, align 16
  %finalRandf1 = alloca <4 x float>, align 16
  %finalRandf2 = alloca <4 x float>, align 16
  %nextRand = alloca <4 x i32>, align 16
  %i = alloca i32, align 4
  %tempRand = alloca <4 x i32>, align 16
  store i32 %noOfSum, i32* %1, align 4
  store i32 %width, i32* %2, align 4
  store <4 x i32> addrspace(1)* %randArray, <4 x i32> addrspace(1)** %3, align 4
  store <4 x float> addrspace(1)* %priceSamples, <4 x float> addrspace(1)** %4, align 4
  store <4 x float> addrspace(1)* %pathDeriv, <4 x float> addrspace(1)** %5, align 4
  %6 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 0
  %7 = load <4 x float>* %6, align 16
  store <4 x float> %7, <4 x float>* %strikePrice, align 16
  %8 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 1
  %9 = load <4 x float>* %8, align 16
  store <4 x float> %9, <4 x float>* %c1, align 16
  %10 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 2
  %11 = load <4 x float>* %10, align 16
  store <4 x float> %11, <4 x float>* %c2, align 16
  %12 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 3
  %13 = load <4 x float>* %12, align 16
  store <4 x float> %13, <4 x float>* %c3, align 16
  %14 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 4
  %15 = load <4 x float>* %14, align 16
  store <4 x float> %15, <4 x float>* %initPrice, align 16
  %16 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 5
  %17 = load <4 x float>* %16, align 16
  store <4 x float> %17, <4 x float>* %sigma, align 16
  %18 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 6
  %19 = load <4 x float>* %18, align 16
  store <4 x float> %19, <4 x float>* %timeStep, align 16
  %20 = call i32 @llvm.r600.read.tgid.x()
  store i32 %20, i32* %xPos, align 4
  %21 = call i32 @llvm.r600.read.tgid.y()
  store i32 %21, i32* %yPos, align 4
  store <4 x float> zeroinitializer, <4 x float>* %temp, align 16
  store <4 x float> zeroinitializer, <4 x float>* %price1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %price2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %pathDeriv1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %pathDeriv2, align 16
  %22 = load <4 x float>* %initPrice, align 16
  store <4 x float> %22, <4 x float>* %trajPrice1, align 16
  %23 = load <4 x float>* %initPrice, align 16
  store <4 x float> %23, <4 x float>* %trajPrice2, align 16
  %24 = load <4 x float>* %initPrice, align 16
  store <4 x float> %24, <4 x float>* %sumPrice1, align 16
  %25 = load <4 x float>* %initPrice, align 16
  store <4 x float> %25, <4 x float>* %sumPrice2, align 16
  %26 = load <4 x float>* %temp, align 16
  store <4 x float> %26, <4 x float>* %meanPrice1, align 16
  %27 = load <4 x float>* %temp, align 16
  store <4 x float> %27, <4 x float>* %meanPrice2, align 16
  %28 = load <4 x float>* %temp, align 16
  store <4 x float> %28, <4 x float>* %sumDeriv1, align 16
  %29 = load <4 x float>* %temp, align 16
  store <4 x float> %29, <4 x float>* %sumDeriv2, align 16
  %30 = load <4 x float>* %temp, align 16
  store <4 x float> %30, <4 x float>* %meanDeriv1, align 16
  %31 = load <4 x float>* %temp, align 16
  store <4 x float> %31, <4 x float>* %meanDeriv2, align 16
  %32 = load <4 x float>* %temp, align 16
  store <4 x float> %32, <4 x float>* %finalRandf1, align 16
  %33 = load <4 x float>* %temp, align 16
  store <4 x float> %33, <4 x float>* %finalRandf2, align 16
  %34 = load i32* %yPos, align 4
  %35 = load i32* %2, align 4
  %36 = mul i32 %34, %35
  %37 = load i32* %xPos, align 4
  %38 = add i32 %36, %37
  %39 = load <4 x i32> addrspace(1)** %3, align 4
  %40 = getelementptr inbounds <4 x i32> addrspace(1)* %39, i32 %38
  %41 = load <4 x i32> addrspace(1)* %40, align 16
  store <4 x i32> %41, <4 x i32>* %nextRand, align 16
  store i32 1, i32* %i, align 4
  br label %42

; <label>:42                                      ; preds = %101, %0
  %43 = load i32* %i, align 4
  %44 = load i32* %1, align 4
  %45 = icmp slt i32 %43, %44
  br i1 %45, label %46, label %104

; <label>:46                                      ; preds = %42
  %47 = load <4 x i32>* %nextRand, align 16
  store <4 x i32> %47, <4 x i32>* %tempRand, align 16
  %48 = load <4 x i32>* %tempRand, align 16
  call void @generateRand(<4 x i32> %48, <4 x float>* %finalRandf1, <4 x float>* %finalRandf2, <4 x i32>* %nextRand)
  %49 = load <4 x float>* %trajPrice1, align 16
  %50 = load <4 x float>* %c1, align 16
  %51 = load <4 x float>* %c2, align 16
  %52 = load <4 x float>* %finalRandf1, align 16
  %53 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %51, <4 x float> %52, <4 x float> %50)
  %54 = call <4 x float> @_Z3expDv4_f(<4 x float> %53)
  %55 = fmul <4 x float> %49, %54
  store <4 x float> %55, <4 x float>* %trajPrice1, align 16
  %56 = load <4 x float>* %trajPrice2, align 16
  %57 = load <4 x float>* %c1, align 16
  %58 = load <4 x float>* %c2, align 16
  %59 = load <4 x float>* %finalRandf2, align 16
  %60 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %58, <4 x float> %59, <4 x float> %57)
  %61 = call <4 x float> @_Z3expDv4_f(<4 x float> %60)
  %62 = fmul <4 x float> %56, %61
  store <4 x float> %62, <4 x float>* %trajPrice2, align 16
  %63 = load <4 x float>* %sumPrice1, align 16
  %64 = load <4 x float>* %trajPrice1, align 16
  %65 = fadd <4 x float> %63, %64
  store <4 x float> %65, <4 x float>* %sumPrice1, align 16
  %66 = load <4 x float>* %sumPrice2, align 16
  %67 = load <4 x float>* %trajPrice2, align 16
  %68 = fadd <4 x float> %66, %67
  store <4 x float> %68, <4 x float>* %sumPrice2, align 16
  %69 = load <4 x float>* %c3, align 16
  %70 = load <4 x float>* %timeStep, align 16
  %71 = fmul <4 x float> %69, %70
  %72 = load i32* %i, align 4
  %73 = sitofp i32 %72 to float
  %74 = insertelement <4 x float> undef, float %73, i32 0
  %75 = shufflevector <4 x float> %74, <4 x float> undef, <4 x i32> zeroinitializer
  %76 = fmul <4 x float> %71, %75
  store <4 x float> %76, <4 x float>* %temp, align 16
  %77 = load <4 x float>* %sumDeriv1, align 16
  %78 = load <4 x float>* %trajPrice1, align 16
  %79 = load <4 x float>* %trajPrice1, align 16
  %80 = load <4 x float>* %initPrice, align 16
  %81 = fdiv <4 x float> %79, %80, !fpmath !2
  %82 = call <4 x float> @llvm.log2.v4f32(<4 x float> %81)
  %83 = load <4 x float>* %temp, align 16
  %84 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %83
  %85 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %82, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %84)
  %86 = load <4 x float>* %sigma, align 16
  %87 = fdiv <4 x float> %85, %86, !fpmath !2
  %88 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %78, <4 x float> %87, <4 x float> %77)
  store <4 x float> %88, <4 x float>* %sumDeriv1, align 16
  %89 = load <4 x float>* %sumDeriv2, align 16
  %90 = load <4 x float>* %trajPrice2, align 16
  %91 = load <4 x float>* %trajPrice2, align 16
  %92 = load <4 x float>* %initPrice, align 16
  %93 = fdiv <4 x float> %91, %92, !fpmath !2
  %94 = call <4 x float> @llvm.log2.v4f32(<4 x float> %93)
  %95 = load <4 x float>* %temp, align 16
  %96 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %95
  %97 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %94, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %96)
  %98 = load <4 x float>* %sigma, align 16
  %99 = fdiv <4 x float> %97, %98, !fpmath !2
  %100 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %90, <4 x float> %99, <4 x float> %89)
  store <4 x float> %100, <4 x float>* %sumDeriv2, align 16
  br label %101

; <label>:101                                     ; preds = %46
  %102 = load i32* %i, align 4
  %103 = add nsw i32 %102, 1
  store i32 %103, i32* %i, align 4
  br label %42

; <label>:104                                     ; preds = %42
  %105 = load <4 x float>* %sumPrice1, align 16
  %106 = load i32* %1, align 4
  %107 = sitofp i32 %106 to float
  %108 = insertelement <4 x float> undef, float %107, i32 0
  %109 = shufflevector <4 x float> %108, <4 x float> undef, <4 x i32> zeroinitializer
  %110 = fdiv <4 x float> %105, %109, !fpmath !2
  store <4 x float> %110, <4 x float>* %meanPrice1, align 16
  %111 = load <4 x float>* %sumPrice2, align 16
  %112 = load i32* %1, align 4
  %113 = sitofp i32 %112 to float
  %114 = insertelement <4 x float> undef, float %113, i32 0
  %115 = shufflevector <4 x float> %114, <4 x float> undef, <4 x i32> zeroinitializer
  %116 = fdiv <4 x float> %111, %115, !fpmath !2
  store <4 x float> %116, <4 x float>* %meanPrice2, align 16
  %117 = load <4 x float>* %sumDeriv1, align 16
  %118 = load i32* %1, align 4
  %119 = sitofp i32 %118 to float
  %120 = insertelement <4 x float> undef, float %119, i32 0
  %121 = shufflevector <4 x float> %120, <4 x float> undef, <4 x i32> zeroinitializer
  %122 = fdiv <4 x float> %117, %121, !fpmath !2
  store <4 x float> %122, <4 x float>* %meanDeriv1, align 16
  %123 = load <4 x float>* %sumDeriv2, align 16
  %124 = load i32* %1, align 4
  %125 = sitofp i32 %124 to float
  %126 = insertelement <4 x float> undef, float %125, i32 0
  %127 = shufflevector <4 x float> %126, <4 x float> undef, <4 x i32> zeroinitializer
  %128 = fdiv <4 x float> %123, %127, !fpmath !2
  store <4 x float> %128, <4 x float>* %meanDeriv2, align 16
  %129 = load <4 x float>* %strikePrice, align 16
  %130 = load <4 x float>* %meanDeriv1, align 16
  %131 = load <4 x float>* %meanDeriv2, align 16
  %132 = load <4 x float>* %meanPrice1, align 16
  %133 = load <4 x float>* %meanPrice2, align 16
  call void @calOutputs(<4 x float> %129, <4 x float> %130, <4 x float> %131, <4 x float> %132, <4 x float> %133, <4 x float>* %pathDeriv1, <4 x float>* %pathDeriv2, <4 x float>* %price1, <4 x float>* %price2)
  %134 = load <4 x float>* %price1, align 16
  %135 = load i32* %yPos, align 4
  %136 = load i32* %2, align 4
  %137 = mul i32 %135, %136
  %138 = load i32* %xPos, align 4
  %139 = add i32 %137, %138
  %140 = mul i32 %139, 2
  %141 = load <4 x float> addrspace(1)** %4, align 4
  %142 = getelementptr inbounds <4 x float> addrspace(1)* %141, i32 %140
  store <4 x float> %134, <4 x float> addrspace(1)* %142, align 16
  %143 = load <4 x float>* %price2, align 16
  %144 = load i32* %yPos, align 4
  %145 = load i32* %2, align 4
  %146 = mul i32 %144, %145
  %147 = load i32* %xPos, align 4
  %148 = add i32 %146, %147
  %149 = mul i32 %148, 2
  %150 = add i32 %149, 1
  %151 = load <4 x float> addrspace(1)** %4, align 4
  %152 = getelementptr inbounds <4 x float> addrspace(1)* %151, i32 %150
  store <4 x float> %143, <4 x float> addrspace(1)* %152, align 16
  %153 = load <4 x float>* %pathDeriv1, align 16
  %154 = load i32* %yPos, align 4
  %155 = load i32* %2, align 4
  %156 = mul i32 %154, %155
  %157 = load i32* %xPos, align 4
  %158 = add i32 %156, %157
  %159 = mul i32 %158, 2
  %160 = load <4 x float> addrspace(1)** %5, align 4
  %161 = getelementptr inbounds <4 x float> addrspace(1)* %160, i32 %159
  store <4 x float> %153, <4 x float> addrspace(1)* %161, align 16
  %162 = load <4 x float>* %pathDeriv2, align 16
  %163 = load i32* %yPos, align 4
  %164 = load i32* %2, align 4
  %165 = mul i32 %163, %164
  %166 = load i32* %xPos, align 4
  %167 = add i32 %165, %166
  %168 = mul i32 %167, 2
  %169 = add i32 %168, 1
  %170 = load <4 x float> addrspace(1)** %5, align 4
  %171 = getelementptr inbounds <4 x float> addrspace(1)* %170, i32 %169
  store <4 x float> %162, <4 x float> addrspace(1)* %171, align 16
  ret void
}

declare i32 @llvm.r600.read.tgid.x() #1
declare i32 @llvm.r600.read.tgid.y() #1
declare i32 @llvm.r600.read.tgid.z() #1

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

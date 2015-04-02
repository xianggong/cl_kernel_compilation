; ModuleID = '../kernel-src/BlackScholes_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @phi(<4 x float> %X, <4 x float>* %phi) #0 {
  %1 = alloca <4 x float>, align 16
  %2 = alloca <4 x float>*, align 4
  %y = alloca <4 x float>, align 16
  %absX = alloca <4 x float>, align 16
  %t = alloca <4 x float>, align 16
  %result = alloca <4 x float>, align 16
  %c1 = alloca <4 x float>, align 16
  %c2 = alloca <4 x float>, align 16
  %c3 = alloca <4 x float>, align 16
  %c4 = alloca <4 x float>, align 16
  %c5 = alloca <4 x float>, align 16
  %zero = alloca <4 x float>, align 16
  %one = alloca <4 x float>, align 16
  %two = alloca <4 x float>, align 16
  %temp4 = alloca <4 x float>, align 16
  %oneBySqrt2pi = alloca <4 x float>, align 16
  store <4 x float> %X, <4 x float>* %1, align 16
  store <4 x float>* %phi, <4 x float>** %2, align 4
  store <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>, <4 x float>* %c1, align 16
  store <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>, <4 x float>* %c2, align 16
  store <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>, <4 x float>* %c3, align 16
  store <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>, <4 x float>* %c4, align 16
  store <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float>* %c5, align 16
  store <4 x float> zeroinitializer, <4 x float>* %zero, align 16
  store <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float>* %one, align 16
  store <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float>* %two, align 16
  store <4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float>* %temp4, align 16
  store <4 x float> <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>, <4 x float>* %oneBySqrt2pi, align 16
  %3 = load <4 x float>* %1, align 16
  %4 = call <4 x float> @llvm.fabs.v4f32(<4 x float> %3)
  store <4 x float> %4, <4 x float>* %absX, align 16
  %5 = load <4 x float>* %one, align 16
  %6 = load <4 x float>* %one, align 16
  %7 = load <4 x float>* %temp4, align 16
  %8 = load <4 x float>* %absX, align 16
  %9 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %7, <4 x float> %8, <4 x float> %6)
  %10 = fdiv <4 x float> %5, %9, !fpmath !3
  store <4 x float> %10, <4 x float>* %t, align 16
  %11 = load <4 x float>* %one, align 16
  %12 = load <4 x float>* %oneBySqrt2pi, align 16
  %13 = load <4 x float>* %1, align 16
  %14 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %13
  %15 = load <4 x float>* %1, align 16
  %16 = fmul <4 x float> %14, %15
  %17 = load <4 x float>* %two, align 16
  %18 = fdiv <4 x float> %16, %17, !fpmath !3
  %19 = call <4 x float> @_Z3expDv4_f(<4 x float> %18)
  %20 = fmul <4 x float> %12, %19
  %21 = load <4 x float>* %t, align 16
  %22 = fmul <4 x float> %20, %21
  %23 = load <4 x float>* %c1, align 16
  %24 = load <4 x float>* %t, align 16
  %25 = load <4 x float>* %c2, align 16
  %26 = load <4 x float>* %t, align 16
  %27 = load <4 x float>* %c3, align 16
  %28 = load <4 x float>* %t, align 16
  %29 = load <4 x float>* %c4, align 16
  %30 = load <4 x float>* %t, align 16
  %31 = load <4 x float>* %c5, align 16
  %32 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %30, <4 x float> %31, <4 x float> %29)
  %33 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %28, <4 x float> %32, <4 x float> %27)
  %34 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %26, <4 x float> %33, <4 x float> %25)
  %35 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %24, <4 x float> %34, <4 x float> %23)
  %36 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %22
  %37 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %36, <4 x float> %35, <4 x float> %11)
  store <4 x float> %37, <4 x float>* %y, align 16
  %38 = load <4 x float>* %1, align 16
  %39 = load <4 x float>* %zero, align 16
  %40 = fcmp olt <4 x float> %38, %39
  %41 = sext <4 x i1> %40 to <4 x i32>
  %42 = load <4 x float>* %one, align 16
  %43 = load <4 x float>* %y, align 16
  %44 = fsub <4 x float> %42, %43
  %45 = load <4 x float>* %y, align 16
  %46 = icmp slt <4 x i32> %41, zeroinitializer
  %47 = sext <4 x i1> %46 to <4 x i32>
  %48 = xor <4 x i32> %47, <i32 -1, i32 -1, i32 -1, i32 -1>
  %49 = bitcast <4 x float> %45 to <4 x i32>
  %50 = bitcast <4 x float> %44 to <4 x i32>
  %51 = and <4 x i32> %49, %48
  %52 = and <4 x i32> %50, %47
  %53 = or <4 x i32> %51, %52
  %54 = bitcast <4 x i32> %53 to <4 x float>
  store <4 x float> %54, <4 x float>* %result, align 16
  %55 = load <4 x float>* %result, align 16
  %56 = load <4 x float>** %2, align 4
  store <4 x float> %55, <4 x float>* %56, align 16
  ret void
}

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.fabs.v4f32(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare <4 x float> @_Z3expDv4_f(<4 x float>) #3

; Function Attrs: nounwind
define void @blackScholes(<4 x float> addrspace(1)* %randArray, i32 %width, <4 x float> addrspace(1)* %call, <4 x float> addrspace(1)* %put) #0 {
  %1 = alloca <4 x float> addrspace(1)*, align 4
  %2 = alloca i32, align 4
  %3 = alloca <4 x float> addrspace(1)*, align 4
  %4 = alloca <4 x float> addrspace(1)*, align 4
  %d1 = alloca <4 x float>, align 16
  %d2 = alloca <4 x float>, align 16
  %phiD1 = alloca <4 x float>, align 16
  %phiD2 = alloca <4 x float>, align 16
  %sigmaSqrtT = alloca <4 x float>, align 16
  %KexpMinusRT = alloca <4 x float>, align 16
  %xPos = alloca i32, align 4
  %yPos = alloca i32, align 4
  %two = alloca <4 x float>, align 16
  %inRand = alloca <4 x float>, align 16
  %S = alloca <4 x float>, align 16
  %K = alloca <4 x float>, align 16
  %T = alloca <4 x float>, align 16
  %R = alloca <4 x float>, align 16
  %sigmaVal = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %randArray, <4 x float> addrspace(1)** %1, align 4
  store i32 %width, i32* %2, align 4
  store <4 x float> addrspace(1)* %call, <4 x float> addrspace(1)** %3, align 4
  store <4 x float> addrspace(1)* %put, <4 x float> addrspace(1)** %4, align 4
  %5 = call i32 @get_global_id(i32 0)
  store i32 %5, i32* %xPos, align 4
  %6 = call i32 @get_global_id(i32 1)
  store i32 %6, i32* %yPos, align 4
  store <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float>* %two, align 16
  %7 = load i32* %yPos, align 4
  %8 = load i32* %2, align 4
  %9 = mul i32 %7, %8
  %10 = load i32* %xPos, align 4
  %11 = add i32 %9, %10
  %12 = load <4 x float> addrspace(1)** %1, align 4
  %13 = getelementptr inbounds <4 x float> addrspace(1)* %12, i32 %11
  %14 = load <4 x float> addrspace(1)* %13, align 16
  store <4 x float> %14, <4 x float>* %inRand, align 16
  %15 = load <4 x float>* %inRand, align 16
  %16 = load <4 x float>* %inRand, align 16
  %17 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %16
  %18 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %17
  %19 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %15, <4 x float> %18)
  store <4 x float> %19, <4 x float>* %S, align 16
  %20 = load <4 x float>* %inRand, align 16
  %21 = load <4 x float>* %inRand, align 16
  %22 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %21
  %23 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %22
  %24 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %20, <4 x float> %23)
  store <4 x float> %24, <4 x float>* %K, align 16
  %25 = load <4 x float>* %inRand, align 16
  %26 = load <4 x float>* %inRand, align 16
  %27 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %26
  %28 = fmul <4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, %27
  %29 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %25, <4 x float> %28)
  store <4 x float> %29, <4 x float>* %T, align 16
  %30 = load <4 x float>* %inRand, align 16
  %31 = load <4 x float>* %inRand, align 16
  %32 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %31
  %33 = fmul <4 x float> <float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000>, %32
  %34 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %30, <4 x float> %33)
  store <4 x float> %34, <4 x float>* %R, align 16
  %35 = load <4 x float>* %inRand, align 16
  %36 = load <4 x float>* %inRand, align 16
  %37 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %36
  %38 = fmul <4 x float> <float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000>, %37
  %39 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %35, <4 x float> %38)
  store <4 x float> %39, <4 x float>* %sigmaVal, align 16
  %40 = load <4 x float>* %sigmaVal, align 16
  %41 = load <4 x float>* %T, align 16
  %42 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %41)
  %43 = fmul <4 x float> %40, %42
  store <4 x float> %43, <4 x float>* %sigmaSqrtT, align 16
  %44 = load <4 x float>* %S, align 16
  %45 = load <4 x float>* %K, align 16
  %46 = fdiv <4 x float> %44, %45, !fpmath !3
  %47 = call <4 x float> @llvm.log2.v4f32(<4 x float> %46)
  %48 = load <4 x float>* %R, align 16
  %49 = load <4 x float>* %sigmaVal, align 16
  %50 = load <4 x float>* %sigmaVal, align 16
  %51 = fmul <4 x float> %49, %50
  %52 = load <4 x float>* %two, align 16
  %53 = fdiv <4 x float> %51, %52, !fpmath !3
  %54 = fadd <4 x float> %48, %53
  %55 = load <4 x float>* %T, align 16
  %56 = fmul <4 x float> %54, %55
  %57 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %47, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %56)
  %58 = load <4 x float>* %sigmaSqrtT, align 16
  %59 = fdiv <4 x float> %57, %58, !fpmath !3
  store <4 x float> %59, <4 x float>* %d1, align 16
  %60 = load <4 x float>* %d1, align 16
  %61 = load <4 x float>* %sigmaSqrtT, align 16
  %62 = fsub <4 x float> %60, %61
  store <4 x float> %62, <4 x float>* %d2, align 16
  %63 = load <4 x float>* %K, align 16
  %64 = load <4 x float>* %R, align 16
  %65 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %64
  %66 = load <4 x float>* %T, align 16
  %67 = fmul <4 x float> %65, %66
  %68 = call <4 x float> @_Z3expDv4_f(<4 x float> %67)
  %69 = fmul <4 x float> %63, %68
  store <4 x float> %69, <4 x float>* %KexpMinusRT, align 16
  %70 = load <4 x float>* %d1, align 16
  call void @phi(<4 x float> %70, <4 x float>* %phiD1)
  %71 = load <4 x float>* %d2, align 16
  call void @phi(<4 x float> %71, <4 x float>* %phiD2)
  %72 = load <4 x float>* %S, align 16
  %73 = load <4 x float>* %phiD1, align 16
  %74 = load <4 x float>* %KexpMinusRT, align 16
  %75 = load <4 x float>* %phiD2, align 16
  %76 = fmul <4 x float> %74, %75
  %77 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %76
  %78 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %72, <4 x float> %73, <4 x float> %77)
  %79 = load i32* %yPos, align 4
  %80 = load i32* %2, align 4
  %81 = mul i32 %79, %80
  %82 = load i32* %xPos, align 4
  %83 = add i32 %81, %82
  %84 = load <4 x float> addrspace(1)** %3, align 4
  %85 = getelementptr inbounds <4 x float> addrspace(1)* %84, i32 %83
  store <4 x float> %78, <4 x float> addrspace(1)* %85, align 16
  %86 = load <4 x float>* %d1, align 16
  %87 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %86
  call void @phi(<4 x float> %87, <4 x float>* %phiD1)
  %88 = load <4 x float>* %d2, align 16
  %89 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %88
  call void @phi(<4 x float> %89, <4 x float>* %phiD2)
  %90 = load <4 x float>* %KexpMinusRT, align 16
  %91 = load <4 x float>* %phiD2, align 16
  %92 = load <4 x float>* %S, align 16
  %93 = load <4 x float>* %phiD1, align 16
  %94 = fmul <4 x float> %92, %93
  %95 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %94
  %96 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %90, <4 x float> %91, <4 x float> %95)
  %97 = load i32* %yPos, align 4
  %98 = load i32* %2, align 4
  %99 = mul i32 %97, %98
  %100 = load i32* %xPos, align 4
  %101 = add i32 %99, %100
  %102 = load <4 x float> addrspace(1)** %4, align 4
  %103 = getelementptr inbounds <4 x float> addrspace(1)* %102, i32 %101
  store <4 x float> %96, <4 x float> addrspace(1)* %103, align 16
  ret void
}

declare i32 @get_global_id(i32) #3

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #1

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #1

; Function Attrs: nounwind
define void @phi_scalar(float %X, float* %phi) #0 {
  %1 = alloca float, align 4
  %2 = alloca float*, align 4
  %y = alloca float, align 4
  %absX = alloca float, align 4
  %t = alloca float, align 4
  %result = alloca float, align 4
  %c1 = alloca float, align 4
  %c2 = alloca float, align 4
  %c3 = alloca float, align 4
  %c4 = alloca float, align 4
  %c5 = alloca float, align 4
  %zero = alloca float, align 4
  %one = alloca float, align 4
  %two = alloca float, align 4
  %temp4 = alloca float, align 4
  %oneBySqrt2pi = alloca float, align 4
  store float %X, float* %1, align 4
  store float* %phi, float** %2, align 4
  store float 0x3FD470BF40000000, float* %c1, align 4
  store float 0xBFD6D1F0E0000000, float* %c2, align 4
  store float 0x3FFC80EF00000000, float* %c3, align 4
  store float 0xBFFD23DD40000000, float* %c4, align 4
  store float 0x3FF548CDE0000000, float* %c5, align 4
  store float 0.000000e+00, float* %zero, align 4
  store float 1.000000e+00, float* %one, align 4
  store float 2.000000e+00, float* %two, align 4
  store float 0x3FCDA67120000000, float* %temp4, align 4
  store float 0x3FD9884540000000, float* %oneBySqrt2pi, align 4
  %3 = load float* %1, align 4
  %4 = call float @llvm.fabs.f32(float %3)
  store float %4, float* %absX, align 4
  %5 = load float* %absX, align 4
  %6 = call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %5, float 1.000000e+00)
  %7 = fdiv float 1.000000e+00, %6, !fpmath !3
  store float %7, float* %t, align 4
  %8 = load float* %1, align 4
  %9 = fsub float -0.000000e+00, %8
  %10 = load float* %1, align 4
  %11 = fmul float %9, %10
  %12 = fdiv float %11, 2.000000e+00, !fpmath !3
  %13 = call float @_Z3expf(float %12)
  %14 = fmul float 0x3FD9884540000000, %13
  %15 = load float* %t, align 4
  %16 = fmul float %14, %15
  %17 = load float* %t, align 4
  %18 = load float* %t, align 4
  %19 = load float* %t, align 4
  %20 = load float* %t, align 4
  %21 = call float @llvm.fmuladd.f32(float %20, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000)
  %22 = call float @llvm.fmuladd.f32(float %19, float %21, float 0x3FFC80EF00000000)
  %23 = call float @llvm.fmuladd.f32(float %18, float %22, float 0xBFD6D1F0E0000000)
  %24 = call float @llvm.fmuladd.f32(float %17, float %23, float 0x3FD470BF40000000)
  %25 = fsub float -0.000000e+00, %16
  %26 = call float @llvm.fmuladd.f32(float %25, float %24, float 1.000000e+00)
  store float %26, float* %y, align 4
  %27 = load float* %1, align 4
  %28 = fcmp olt float %27, 0.000000e+00
  br i1 %28, label %29, label %32

; <label>:29                                      ; preds = %0
  %30 = load float* %y, align 4
  %31 = fsub float 1.000000e+00, %30
  br label %34

; <label>:32                                      ; preds = %0
  %33 = load float* %y, align 4
  br label %34

; <label>:34                                      ; preds = %32, %29
  %35 = phi float [ %31, %29 ], [ %33, %32 ]
  store float %35, float* %result, align 4
  %36 = load float* %result, align 4
  %37 = load float** %2, align 4
  store float %36, float* %37, align 4
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.fabs.f32(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3expf(float) #3

; Function Attrs: nounwind
define void @blackScholes_scalar(float addrspace(1)* %randArray, i32 %width, float addrspace(1)* %call, float addrspace(1)* %put) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca i32, align 4
  %3 = alloca float addrspace(1)*, align 4
  %4 = alloca float addrspace(1)*, align 4
  %d1 = alloca float, align 4
  %d2 = alloca float, align 4
  %phiD1 = alloca float, align 4
  %phiD2 = alloca float, align 4
  %sigmaSqrtT = alloca float, align 4
  %KexpMinusRT = alloca float, align 4
  %xPos = alloca i32, align 4
  %yPos = alloca i32, align 4
  %two = alloca float, align 4
  %inRand = alloca float, align 4
  %S = alloca float, align 4
  %K = alloca float, align 4
  %T = alloca float, align 4
  %R = alloca float, align 4
  %sigmaVal = alloca float, align 4
  store float addrspace(1)* %randArray, float addrspace(1)** %1, align 4
  store i32 %width, i32* %2, align 4
  store float addrspace(1)* %call, float addrspace(1)** %3, align 4
  store float addrspace(1)* %put, float addrspace(1)** %4, align 4
  %5 = call i32 @get_global_id(i32 0)
  store i32 %5, i32* %xPos, align 4
  %6 = call i32 @get_global_id(i32 1)
  store i32 %6, i32* %yPos, align 4
  store float 2.000000e+00, float* %two, align 4
  %7 = load i32* %yPos, align 4
  %8 = load i32* %2, align 4
  %9 = mul i32 %7, %8
  %10 = load i32* %xPos, align 4
  %11 = add i32 %9, %10
  %12 = load float addrspace(1)** %1, align 4
  %13 = getelementptr inbounds float addrspace(1)* %12, i32 %11
  %14 = load float addrspace(1)* %13, align 4
  store float %14, float* %inRand, align 4
  %15 = load float* %inRand, align 4
  %16 = load float* %inRand, align 4
  %17 = fsub float 1.000000e+00, %16
  %18 = fmul float 1.000000e+02, %17
  %19 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %15, float %18)
  store float %19, float* %S, align 4
  %20 = load float* %inRand, align 4
  %21 = load float* %inRand, align 4
  %22 = fsub float 1.000000e+00, %21
  %23 = fmul float 1.000000e+02, %22
  %24 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %20, float %23)
  store float %24, float* %K, align 4
  %25 = load float* %inRand, align 4
  %26 = load float* %inRand, align 4
  %27 = fsub float 1.000000e+00, %26
  %28 = fmul float 1.000000e+01, %27
  %29 = call float @llvm.fmuladd.f32(float 1.000000e+00, float %25, float %28)
  store float %29, float* %T, align 4
  %30 = load float* %inRand, align 4
  %31 = load float* %inRand, align 4
  %32 = fsub float 1.000000e+00, %31
  %33 = fmul float 0x3FA99999A0000000, %32
  %34 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %30, float %33)
  store float %34, float* %R, align 4
  %35 = load float* %inRand, align 4
  %36 = load float* %inRand, align 4
  %37 = fsub float 1.000000e+00, %36
  %38 = fmul float 0x3FB99999A0000000, %37
  %39 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %35, float %38)
  store float %39, float* %sigmaVal, align 4
  %40 = load float* %sigmaVal, align 4
  %41 = load float* %T, align 4
  %42 = call float @llvm.sqrt.f32(float %41)
  %43 = fmul float %40, %42
  store float %43, float* %sigmaSqrtT, align 4
  %44 = load float* %S, align 4
  %45 = load float* %K, align 4
  %46 = fdiv float %44, %45, !fpmath !3
  %47 = call float @llvm.log2.f32(float %46)
  %48 = load float* %R, align 4
  %49 = load float* %sigmaVal, align 4
  %50 = load float* %sigmaVal, align 4
  %51 = fmul float %49, %50
  %52 = load float* %two, align 4
  %53 = fdiv float %51, %52, !fpmath !3
  %54 = fadd float %48, %53
  %55 = load float* %T, align 4
  %56 = fmul float %54, %55
  %57 = call float @llvm.fmuladd.f32(float %47, float 0x3FE62E4300000000, float %56)
  %58 = load float* %sigmaSqrtT, align 4
  %59 = fdiv float %57, %58, !fpmath !3
  store float %59, float* %d1, align 4
  %60 = load float* %d1, align 4
  %61 = load float* %sigmaSqrtT, align 4
  %62 = fsub float %60, %61
  store float %62, float* %d2, align 4
  %63 = load float* %K, align 4
  %64 = load float* %R, align 4
  %65 = fsub float -0.000000e+00, %64
  %66 = load float* %T, align 4
  %67 = fmul float %65, %66
  %68 = call float @_Z3expf(float %67)
  %69 = fmul float %63, %68
  store float %69, float* %KexpMinusRT, align 4
  %70 = load float* %d1, align 4
  call void @phi_scalar(float %70, float* %phiD1)
  %71 = load float* %d2, align 4
  call void @phi_scalar(float %71, float* %phiD2)
  %72 = load float* %S, align 4
  %73 = load float* %phiD1, align 4
  %74 = load float* %KexpMinusRT, align 4
  %75 = load float* %phiD2, align 4
  %76 = fmul float %74, %75
  %77 = fsub float -0.000000e+00, %76
  %78 = call float @llvm.fmuladd.f32(float %72, float %73, float %77)
  %79 = load i32* %yPos, align 4
  %80 = load i32* %2, align 4
  %81 = mul i32 %79, %80
  %82 = load i32* %xPos, align 4
  %83 = add i32 %81, %82
  %84 = load float addrspace(1)** %3, align 4
  %85 = getelementptr inbounds float addrspace(1)* %84, i32 %83
  store float %78, float addrspace(1)* %85, align 4
  %86 = load float* %d1, align 4
  %87 = fsub float -0.000000e+00, %86
  call void @phi_scalar(float %87, float* %phiD1)
  %88 = load float* %d2, align 4
  %89 = fsub float -0.000000e+00, %88
  call void @phi_scalar(float %89, float* %phiD2)
  %90 = load float* %KexpMinusRT, align 4
  %91 = load float* %phiD2, align 4
  %92 = load float* %S, align 4
  %93 = load float* %phiD1, align 4
  %94 = fmul float %92, %93
  %95 = fsub float -0.000000e+00, %94
  %96 = call float @llvm.fmuladd.f32(float %90, float %91, float %95)
  %97 = load i32* %yPos, align 4
  %98 = load i32* %2, align 4
  %99 = mul i32 %97, %98
  %100 = load i32* %xPos, align 4
  %101 = add i32 %99, %100
  %102 = load float addrspace(1)** %4, align 4
  %103 = getelementptr inbounds float addrspace(1)* %102, i32 %101
  store float %96, float addrspace(1)* %103, align 4
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #1

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @blackScholes}
!1 = metadata !{void (float addrspace(1)*, i32, float addrspace(1)*, float addrspace(1)*)* @blackScholes_scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{float 2.500000e+00}

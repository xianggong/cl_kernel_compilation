; ModuleID = 'BlackScholes_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc75 void @phi(<4 x float> %X, <4 x float>* %phi) #0 {
entry:
  %X.addr = alloca <4 x float>, align 16
  %phi.addr = alloca <4 x float>*, align 8
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
  store <4 x float> %X, <4 x float>* %X.addr, align 16
  store <4 x float>* %phi, <4 x float>** %phi.addr, align 8
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
  %0 = load <4 x float>* %X.addr, align 16
  %call = call cc75 <4 x float> @_Z4fabsDv4_f(<4 x float> %0) #1
  store <4 x float> %call, <4 x float>* %absX, align 16
  %1 = load <4 x float>* %one, align 16
  %2 = load <4 x float>* %one, align 16
  %3 = load <4 x float>* %temp4, align 16
  %4 = load <4 x float>* %absX, align 16
  %5 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %3, <4 x float> %4, <4 x float> %2)
  %div = fdiv <4 x float> %1, %5, !fpmath !10
  store <4 x float> %div, <4 x float>* %t, align 16
  %6 = load <4 x float>* %one, align 16
  %7 = load <4 x float>* %oneBySqrt2pi, align 16
  %8 = load <4 x float>* %X.addr, align 16
  %sub = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %8
  %9 = load <4 x float>* %X.addr, align 16
  %mul = fmul <4 x float> %sub, %9
  %10 = load <4 x float>* %two, align 16
  %div1 = fdiv <4 x float> %mul, %10, !fpmath !10
  %call2 = call cc75 <4 x float> @_Z3expDv4_f(<4 x float> %div1) #1
  %mul3 = fmul <4 x float> %7, %call2
  %11 = load <4 x float>* %t, align 16
  %mul4 = fmul <4 x float> %mul3, %11
  %12 = load <4 x float>* %c1, align 16
  %13 = load <4 x float>* %t, align 16
  %14 = load <4 x float>* %c2, align 16
  %15 = load <4 x float>* %t, align 16
  %16 = load <4 x float>* %c3, align 16
  %17 = load <4 x float>* %t, align 16
  %18 = load <4 x float>* %c4, align 16
  %19 = load <4 x float>* %t, align 16
  %20 = load <4 x float>* %c5, align 16
  %21 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %19, <4 x float> %20, <4 x float> %18)
  %22 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %17, <4 x float> %21, <4 x float> %16)
  %23 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %15, <4 x float> %22, <4 x float> %14)
  %24 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %13, <4 x float> %23, <4 x float> %12)
  %neg = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul4
  %25 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg, <4 x float> %24, <4 x float> %6)
  store <4 x float> %25, <4 x float>* %y, align 16
  %26 = load <4 x float>* %X.addr, align 16
  %27 = load <4 x float>* %zero, align 16
  %cmp = fcmp olt <4 x float> %26, %27
  %sext = sext <4 x i1> %cmp to <4 x i32>
  %28 = load <4 x float>* %one, align 16
  %29 = load <4 x float>* %y, align 16
  %sub10 = fsub <4 x float> %28, %29
  %30 = load <4 x float>* %y, align 16
  %31 = icmp slt <4 x i32> %sext, zeroinitializer
  %32 = select <4 x i1> %31, <4 x float> %sub10, <4 x float> %30
  store <4 x float> %32, <4 x float>* %result, align 16
  %33 = load <4 x float>* %result, align 16
  %34 = load <4 x float>** %phi.addr, align 8
  store <4 x float> %33, <4 x float>* %34, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z4fabsDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_blackScholes_kernel(<4 x float> addrspace(1)* %randArray, i32 %width, <4 x float> addrspace(1)* %call, <4 x float> addrspace(1)* %put) #0 {
entry:
  %randArray.addr = alloca <4 x float> addrspace(1)*, align 8
  %width.addr = alloca i32, align 4
  %call.addr = alloca <4 x float> addrspace(1)*, align 8
  %put.addr = alloca <4 x float> addrspace(1)*, align 8
  %d1 = alloca <4 x float>, align 16
  %d2 = alloca <4 x float>, align 16
  %phiD1 = alloca <4 x float>, align 16
  %phiD2 = alloca <4 x float>, align 16
  %sigmaSqrtT = alloca <4 x float>, align 16
  %KexpMinusRT = alloca <4 x float>, align 16
  %xPos = alloca i64, align 8
  %yPos = alloca i64, align 8
  %two = alloca <4 x float>, align 16
  %inRand = alloca <4 x float>, align 16
  %S = alloca <4 x float>, align 16
  %K = alloca <4 x float>, align 16
  %T = alloca <4 x float>, align 16
  %R = alloca <4 x float>, align 16
  %sigmaVal = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %randArray, <4 x float> addrspace(1)** %randArray.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store <4 x float> addrspace(1)* %call, <4 x float> addrspace(1)** %call.addr, align 8
  store <4 x float> addrspace(1)* %put, <4 x float> addrspace(1)** %put.addr, align 8
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call1, i64* %xPos, align 8
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  store i64 %call2, i64* %yPos, align 8
  store <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float>* %two, align 16
  %0 = load i64* %yPos, align 8
  %1 = load i32* %width.addr, align 4
  %conv = sext i32 %1 to i64
  %mul = mul i64 %0, %conv
  %2 = load i64* %xPos, align 8
  %add = add i64 %mul, %2
  %3 = load <4 x float> addrspace(1)** %randArray.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %3, i64 %add
  %4 = load <4 x float> addrspace(1)* %arrayidx, align 16
  store <4 x float> %4, <4 x float>* %inRand, align 16
  %5 = load <4 x float>* %inRand, align 16
  %6 = load <4 x float>* %inRand, align 16
  %sub = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %6
  %mul4 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %sub
  %7 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %5, <4 x float> %mul4)
  store <4 x float> %7, <4 x float>* %S, align 16
  %8 = load <4 x float>* %inRand, align 16
  %9 = load <4 x float>* %inRand, align 16
  %sub6 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %9
  %mul7 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %sub6
  %10 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %8, <4 x float> %mul7)
  store <4 x float> %10, <4 x float>* %K, align 16
  %11 = load <4 x float>* %inRand, align 16
  %12 = load <4 x float>* %inRand, align 16
  %sub9 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %12
  %mul10 = fmul <4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, %sub9
  %13 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %11, <4 x float> %mul10)
  store <4 x float> %13, <4 x float>* %T, align 16
  %14 = load <4 x float>* %inRand, align 16
  %15 = load <4 x float>* %inRand, align 16
  %sub12 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %15
  %mul13 = fmul <4 x float> <float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000>, %sub12
  %16 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %14, <4 x float> %mul13)
  store <4 x float> %16, <4 x float>* %R, align 16
  %17 = load <4 x float>* %inRand, align 16
  %18 = load <4 x float>* %inRand, align 16
  %sub15 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %18
  %mul16 = fmul <4 x float> <float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000>, %sub15
  %19 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %17, <4 x float> %mul16)
  store <4 x float> %19, <4 x float>* %sigmaVal, align 16
  %20 = load <4 x float>* %sigmaVal, align 16
  %21 = load <4 x float>* %T, align 16
  %call17 = call cc75 <4 x float> @_Z4sqrtDv4_f(<4 x float> %21) #1
  %mul18 = fmul <4 x float> %20, %call17
  store <4 x float> %mul18, <4 x float>* %sigmaSqrtT, align 16
  %22 = load <4 x float>* %S, align 16
  %23 = load <4 x float>* %K, align 16
  %div = fdiv <4 x float> %22, %23, !fpmath !10
  %call19 = call cc75 <4 x float> @_Z3logDv4_f(<4 x float> %div) #1
  %24 = load <4 x float>* %R, align 16
  %25 = load <4 x float>* %sigmaVal, align 16
  %26 = load <4 x float>* %sigmaVal, align 16
  %mul20 = fmul <4 x float> %25, %26
  %27 = load <4 x float>* %two, align 16
  %div21 = fdiv <4 x float> %mul20, %27, !fpmath !10
  %add22 = fadd <4 x float> %24, %div21
  %28 = load <4 x float>* %T, align 16
  %29 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %add22, <4 x float> %28, <4 x float> %call19)
  %30 = load <4 x float>* %sigmaSqrtT, align 16
  %div24 = fdiv <4 x float> %29, %30, !fpmath !10
  store <4 x float> %div24, <4 x float>* %d1, align 16
  %31 = load <4 x float>* %d1, align 16
  %32 = load <4 x float>* %sigmaSqrtT, align 16
  %sub25 = fsub <4 x float> %31, %32
  store <4 x float> %sub25, <4 x float>* %d2, align 16
  %33 = load <4 x float>* %K, align 16
  %34 = load <4 x float>* %R, align 16
  %sub26 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %34
  %35 = load <4 x float>* %T, align 16
  %mul27 = fmul <4 x float> %sub26, %35
  %call28 = call cc75 <4 x float> @_Z3expDv4_f(<4 x float> %mul27) #1
  %mul29 = fmul <4 x float> %33, %call28
  store <4 x float> %mul29, <4 x float>* %KexpMinusRT, align 16
  %36 = load <4 x float>* %d1, align 16
  call cc75 void @phi(<4 x float> %36, <4 x float>* %phiD1)
  %37 = load <4 x float>* %d2, align 16
  call cc75 void @phi(<4 x float> %37, <4 x float>* %phiD2)
  %38 = load <4 x float>* %S, align 16
  %39 = load <4 x float>* %phiD1, align 16
  %40 = load <4 x float>* %KexpMinusRT, align 16
  %41 = load <4 x float>* %phiD2, align 16
  %mul31 = fmul <4 x float> %40, %41
  %neg = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul31
  %42 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %38, <4 x float> %39, <4 x float> %neg)
  %43 = load i64* %yPos, align 8
  %44 = load i32* %width.addr, align 4
  %conv32 = sext i32 %44 to i64
  %mul33 = mul i64 %43, %conv32
  %45 = load i64* %xPos, align 8
  %add34 = add i64 %mul33, %45
  %46 = load <4 x float> addrspace(1)** %call.addr, align 8
  %arrayidx35 = getelementptr inbounds <4 x float> addrspace(1)* %46, i64 %add34
  store <4 x float> %42, <4 x float> addrspace(1)* %arrayidx35, align 16
  %47 = load <4 x float>* %d1, align 16
  %sub36 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %47
  call cc75 void @phi(<4 x float> %sub36, <4 x float>* %phiD1)
  %48 = load <4 x float>* %d2, align 16
  %sub37 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %48
  call cc75 void @phi(<4 x float> %sub37, <4 x float>* %phiD2)
  %49 = load <4 x float>* %KexpMinusRT, align 16
  %50 = load <4 x float>* %phiD2, align 16
  %51 = load <4 x float>* %S, align 16
  %52 = load <4 x float>* %phiD1, align 16
  %mul39 = fmul <4 x float> %51, %52
  %neg40 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul39
  %53 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %49, <4 x float> %50, <4 x float> %neg40)
  %54 = load i64* %yPos, align 8
  %55 = load i32* %width.addr, align 4
  %conv41 = sext i32 %55 to i64
  %mul42 = mul i64 %54, %conv41
  %56 = load i64* %xPos, align 8
  %add43 = add i64 %mul42, %56
  %57 = load <4 x float> addrspace(1)** %put.addr, align 8
  %arrayidx44 = getelementptr inbounds <4 x float> addrspace(1)* %57, i64 %add43
  store <4 x float> %53, <4 x float> addrspace(1)* %arrayidx44, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z4sqrtDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z3logDv4_f(<4 x float>) #1

; Function Attrs: nounwind
define cc75 void @phi_scalar(float %X, float* %phi) #0 {
entry:
  %X.addr = alloca float, align 4
  %phi.addr = alloca float*, align 8
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
  store float %X, float* %X.addr, align 4
  store float* %phi, float** %phi.addr, align 8
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
  %0 = load float* %X.addr, align 4
  %call = call cc75 float @_Z4fabsf(float %0) #1
  store float %call, float* %absX, align 4
  %1 = load float* %absX, align 4
  %2 = call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %1, float 1.000000e+00)
  %div = fdiv float 1.000000e+00, %2, !fpmath !10
  store float %div, float* %t, align 4
  %3 = load float* %X.addr, align 4
  %sub = fsub float -0.000000e+00, %3
  %4 = load float* %X.addr, align 4
  %mul = fmul float %sub, %4
  %div1 = fdiv float %mul, 2.000000e+00, !fpmath !10
  %call2 = call cc75 float @_Z3expf(float %div1) #1
  %mul3 = fmul float 0x3FD9884540000000, %call2
  %5 = load float* %t, align 4
  %mul4 = fmul float %mul3, %5
  %6 = load float* %t, align 4
  %7 = load float* %t, align 4
  %8 = load float* %t, align 4
  %9 = load float* %t, align 4
  %10 = call float @llvm.fmuladd.f32(float %9, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000)
  %11 = call float @llvm.fmuladd.f32(float %8, float %10, float 0x3FFC80EF00000000)
  %12 = call float @llvm.fmuladd.f32(float %7, float %11, float 0xBFD6D1F0E0000000)
  %13 = call float @llvm.fmuladd.f32(float %6, float %12, float 0x3FD470BF40000000)
  %neg = fsub float -0.000000e+00, %mul4
  %14 = call float @llvm.fmuladd.f32(float %neg, float %13, float 1.000000e+00)
  store float %14, float* %y, align 4
  %15 = load float* %X.addr, align 4
  %cmp = fcmp olt float %15, 0.000000e+00
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %16 = load float* %y, align 4
  %sub10 = fsub float 1.000000e+00, %16
  br label %cond.end

cond.false:                                       ; preds = %entry
  %17 = load float* %y, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %sub10, %cond.true ], [ %17, %cond.false ]
  store float %cond, float* %result, align 4
  %18 = load float* %result, align 4
  %19 = load float** %phi.addr, align 8
  store float %18, float* %19, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 float @_Z4fabsf(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3expf(float) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_blackScholes_scalar_kernel(float addrspace(1)* %randArray, i32 %width, float addrspace(1)* %call, float addrspace(1)* %put) #0 {
entry:
  %randArray.addr = alloca float addrspace(1)*, align 8
  %width.addr = alloca i32, align 4
  %call.addr = alloca float addrspace(1)*, align 8
  %put.addr = alloca float addrspace(1)*, align 8
  %d1 = alloca float, align 4
  %d2 = alloca float, align 4
  %phiD1 = alloca float, align 4
  %phiD2 = alloca float, align 4
  %sigmaSqrtT = alloca float, align 4
  %KexpMinusRT = alloca float, align 4
  %xPos = alloca i64, align 8
  %yPos = alloca i64, align 8
  %two = alloca float, align 4
  %inRand = alloca float, align 4
  %S = alloca float, align 4
  %K = alloca float, align 4
  %T = alloca float, align 4
  %R = alloca float, align 4
  %sigmaVal = alloca float, align 4
  store float addrspace(1)* %randArray, float addrspace(1)** %randArray.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store float addrspace(1)* %call, float addrspace(1)** %call.addr, align 8
  store float addrspace(1)* %put, float addrspace(1)** %put.addr, align 8
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call1, i64* %xPos, align 8
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  store i64 %call2, i64* %yPos, align 8
  store float 2.000000e+00, float* %two, align 4
  %0 = load i64* %yPos, align 8
  %1 = load i32* %width.addr, align 4
  %conv = sext i32 %1 to i64
  %mul = mul i64 %0, %conv
  %2 = load i64* %xPos, align 8
  %add = add i64 %mul, %2
  %3 = load float addrspace(1)** %randArray.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %3, i64 %add
  %4 = load float addrspace(1)* %arrayidx, align 4
  store float %4, float* %inRand, align 4
  %5 = load float* %inRand, align 4
  %6 = load float* %inRand, align 4
  %sub = fsub float 1.000000e+00, %6
  %mul4 = fmul float 1.000000e+02, %sub
  %7 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %5, float %mul4)
  store float %7, float* %S, align 4
  %8 = load float* %inRand, align 4
  %9 = load float* %inRand, align 4
  %sub6 = fsub float 1.000000e+00, %9
  %mul7 = fmul float 1.000000e+02, %sub6
  %10 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %8, float %mul7)
  store float %10, float* %K, align 4
  %11 = load float* %inRand, align 4
  %12 = load float* %inRand, align 4
  %sub9 = fsub float 1.000000e+00, %12
  %mul10 = fmul float 1.000000e+01, %sub9
  %13 = call float @llvm.fmuladd.f32(float 1.000000e+00, float %11, float %mul10)
  store float %13, float* %T, align 4
  %14 = load float* %inRand, align 4
  %15 = load float* %inRand, align 4
  %sub12 = fsub float 1.000000e+00, %15
  %mul13 = fmul float 0x3FA99999A0000000, %sub12
  %16 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %14, float %mul13)
  store float %16, float* %R, align 4
  %17 = load float* %inRand, align 4
  %18 = load float* %inRand, align 4
  %sub15 = fsub float 1.000000e+00, %18
  %mul16 = fmul float 0x3FB99999A0000000, %sub15
  %19 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %17, float %mul16)
  store float %19, float* %sigmaVal, align 4
  %20 = load float* %sigmaVal, align 4
  %21 = load float* %T, align 4
  %call17 = call cc75 float @_Z4sqrtf(float %21) #1
  %mul18 = fmul float %20, %call17
  store float %mul18, float* %sigmaSqrtT, align 4
  %22 = load float* %S, align 4
  %23 = load float* %K, align 4
  %div = fdiv float %22, %23, !fpmath !10
  %call19 = call cc75 float @_Z3logf(float %div) #1
  %24 = load float* %R, align 4
  %25 = load float* %sigmaVal, align 4
  %26 = load float* %sigmaVal, align 4
  %mul20 = fmul float %25, %26
  %27 = load float* %two, align 4
  %div21 = fdiv float %mul20, %27, !fpmath !10
  %add22 = fadd float %24, %div21
  %28 = load float* %T, align 4
  %29 = call float @llvm.fmuladd.f32(float %add22, float %28, float %call19)
  %30 = load float* %sigmaSqrtT, align 4
  %div24 = fdiv float %29, %30, !fpmath !10
  store float %div24, float* %d1, align 4
  %31 = load float* %d1, align 4
  %32 = load float* %sigmaSqrtT, align 4
  %sub25 = fsub float %31, %32
  store float %sub25, float* %d2, align 4
  %33 = load float* %K, align 4
  %34 = load float* %R, align 4
  %sub26 = fsub float -0.000000e+00, %34
  %35 = load float* %T, align 4
  %mul27 = fmul float %sub26, %35
  %call28 = call cc75 float @_Z3expf(float %mul27) #1
  %mul29 = fmul float %33, %call28
  store float %mul29, float* %KexpMinusRT, align 4
  %36 = load float* %d1, align 4
  call cc75 void @phi_scalar(float %36, float* %phiD1)
  %37 = load float* %d2, align 4
  call cc75 void @phi_scalar(float %37, float* %phiD2)
  %38 = load float* %S, align 4
  %39 = load float* %phiD1, align 4
  %40 = load float* %KexpMinusRT, align 4
  %41 = load float* %phiD2, align 4
  %mul31 = fmul float %40, %41
  %neg = fsub float -0.000000e+00, %mul31
  %42 = call float @llvm.fmuladd.f32(float %38, float %39, float %neg)
  %43 = load i64* %yPos, align 8
  %44 = load i32* %width.addr, align 4
  %conv32 = sext i32 %44 to i64
  %mul33 = mul i64 %43, %conv32
  %45 = load i64* %xPos, align 8
  %add34 = add i64 %mul33, %45
  %46 = load float addrspace(1)** %call.addr, align 8
  %arrayidx35 = getelementptr inbounds float addrspace(1)* %46, i64 %add34
  store float %42, float addrspace(1)* %arrayidx35, align 4
  %47 = load float* %d1, align 4
  %sub36 = fsub float -0.000000e+00, %47
  call cc75 void @phi_scalar(float %sub36, float* %phiD1)
  %48 = load float* %d2, align 4
  %sub37 = fsub float -0.000000e+00, %48
  call cc75 void @phi_scalar(float %sub37, float* %phiD2)
  %49 = load float* %KexpMinusRT, align 4
  %50 = load float* %phiD2, align 4
  %51 = load float* %S, align 4
  %52 = load float* %phiD1, align 4
  %mul39 = fmul float %51, %52
  %neg40 = fsub float -0.000000e+00, %mul39
  %53 = call float @llvm.fmuladd.f32(float %49, float %50, float %neg40)
  %54 = load i64* %yPos, align 8
  %55 = load i32* %width.addr, align 4
  %conv41 = sext i32 %55 to i64
  %mul42 = mul i64 %54, %conv41
  %56 = load i64* %xPos, align 8
  %add43 = add i64 %mul42, %56
  %57 = load float addrspace(1)** %put.addr, align 8
  %arrayidx44 = getelementptr inbounds float addrspace(1)* %57, i64 %add43
  store float %53, float addrspace(1)* %arrayidx44, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 float @_Z4sqrtf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3logf(float) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!9}
!opencl.spir.version = !{!9}

!0 = metadata !{void (<4 x float> addrspace(1)*, i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @__OpenCL_blackScholes_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"int", metadata !"float4*", metadata !"float4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"const", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"int", metadata !"float4*", metadata !"float4*"}
!6 = metadata !{void (float addrspace(1)*, i32, float addrspace(1)*, float addrspace(1)*)* @__OpenCL_blackScholes_scalar_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"int", metadata !"float*", metadata !"float*"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"int", metadata !"float*", metadata !"float*"}
!9 = metadata !{i32 1, i32 2}
!10 = metadata !{float 2.500000e+00}

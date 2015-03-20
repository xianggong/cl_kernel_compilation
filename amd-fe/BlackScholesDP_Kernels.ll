; ModuleID = 'BlackScholesDP_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc75 void @phi(<4 x double> %X, <4 x double>* %phi) #0 {
entry:
  %X.addr = alloca <4 x double>, align 32
  %phi.addr = alloca <4 x double>*, align 8
  %y = alloca <4 x double>, align 32
  %absX = alloca <4 x double>, align 32
  %t = alloca <4 x double>, align 32
  %result = alloca <4 x double>, align 32
  %c1 = alloca <4 x double>, align 32
  %c2 = alloca <4 x double>, align 32
  %c3 = alloca <4 x double>, align 32
  %c4 = alloca <4 x double>, align 32
  %c5 = alloca <4 x double>, align 32
  %zero = alloca <4 x double>, align 32
  %one = alloca <4 x double>, align 32
  %two = alloca <4 x double>, align 32
  %temp4 = alloca <4 x double>, align 32
  %oneBySqrt2pi = alloca <4 x double>, align 32
  store <4 x double> %X, <4 x double>* %X.addr, align 32
  store <4 x double>* %phi, <4 x double>** %phi.addr, align 8
  store <4 x double> <double 0x3FD470BF3A92F8EC, double 0x3FD470BF3A92F8EC, double 0x3FD470BF3A92F8EC, double 0x3FD470BF3A92F8EC>, <4 x double>* %c1, align 32
  store <4 x double> <double 0xBFD6D1F0E5A8325B, double 0xBFD6D1F0E5A8325B, double 0xBFD6D1F0E5A8325B, double 0xBFD6D1F0E5A8325B>, <4 x double>* %c2, align 32
  store <4 x double> <double 0x3FFC80EF025F5E68, double 0x3FFC80EF025F5E68, double 0x3FFC80EF025F5E68, double 0x3FFC80EF025F5E68>, <4 x double>* %c3, align 32
  store <4 x double> <double 0xBFFD23DD4EF278D0, double 0xBFFD23DD4EF278D0, double 0xBFFD23DD4EF278D0, double 0xBFFD23DD4EF278D0>, <4 x double>* %c4, align 32
  store <4 x double> <double 0x3FF548CDD6F42943, double 0x3FF548CDD6F42943, double 0x3FF548CDD6F42943, double 0x3FF548CDD6F42943>, <4 x double>* %c5, align 32
  store <4 x double> zeroinitializer, <4 x double>* %zero, align 32
  store <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, <4 x double>* %one, align 32
  store <4 x double> <double 2.000000e+00, double 2.000000e+00, double 2.000000e+00, double 2.000000e+00>, <4 x double>* %two, align 32
  store <4 x double> <double 2.316419e-01, double 2.316419e-01, double 2.316419e-01, double 2.316419e-01>, <4 x double>* %temp4, align 32
  store <4 x double> <double 0x3FD988453365DE00, double 0x3FD988453365DE00, double 0x3FD988453365DE00, double 0x3FD988453365DE00>, <4 x double>* %oneBySqrt2pi, align 32
  %0 = load <4 x double>* %X.addr, align 32
  %call = call cc75 <4 x double> @_Z4fabsDv4_d(<4 x double> %0) #1
  store <4 x double> %call, <4 x double>* %absX, align 32
  %1 = load <4 x double>* %one, align 32
  %2 = load <4 x double>* %one, align 32
  %3 = load <4 x double>* %temp4, align 32
  %4 = load <4 x double>* %absX, align 32
  %5 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %3, <4 x double> %4, <4 x double> %2)
  %div = fdiv <4 x double> %1, %5
  store <4 x double> %div, <4 x double>* %t, align 32
  %6 = load <4 x double>* %one, align 32
  %7 = load <4 x double>* %oneBySqrt2pi, align 32
  %8 = load <4 x double>* %X.addr, align 32
  %sub = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %8
  %9 = load <4 x double>* %X.addr, align 32
  %mul = fmul <4 x double> %sub, %9
  %10 = load <4 x double>* %two, align 32
  %div1 = fdiv <4 x double> %mul, %10
  %call2 = call cc75 <4 x double> @_Z3expDv4_d(<4 x double> %div1) #1
  %mul3 = fmul <4 x double> %7, %call2
  %11 = load <4 x double>* %t, align 32
  %mul4 = fmul <4 x double> %mul3, %11
  %12 = load <4 x double>* %c1, align 32
  %13 = load <4 x double>* %t, align 32
  %14 = load <4 x double>* %c2, align 32
  %15 = load <4 x double>* %t, align 32
  %16 = load <4 x double>* %c3, align 32
  %17 = load <4 x double>* %t, align 32
  %18 = load <4 x double>* %c4, align 32
  %19 = load <4 x double>* %t, align 32
  %20 = load <4 x double>* %c5, align 32
  %21 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %19, <4 x double> %20, <4 x double> %18)
  %22 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %17, <4 x double> %21, <4 x double> %16)
  %23 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %15, <4 x double> %22, <4 x double> %14)
  %24 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %13, <4 x double> %23, <4 x double> %12)
  %neg = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %mul4
  %25 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %neg, <4 x double> %24, <4 x double> %6)
  store <4 x double> %25, <4 x double>* %y, align 32
  %26 = load <4 x double>* %X.addr, align 32
  %27 = load <4 x double>* %zero, align 32
  %cmp = fcmp olt <4 x double> %26, %27
  %sext = sext <4 x i1> %cmp to <4 x i64>
  %28 = load <4 x double>* %one, align 32
  %29 = load <4 x double>* %y, align 32
  %sub10 = fsub <4 x double> %28, %29
  %30 = load <4 x double>* %y, align 32
  %31 = icmp slt <4 x i64> %sext, zeroinitializer
  %32 = select <4 x i1> %31, <4 x double> %sub10, <4 x double> %30
  store <4 x double> %32, <4 x double>* %result, align 32
  %33 = load <4 x double>* %result, align 32
  %34 = load <4 x double>** %phi.addr, align 8
  store <4 x double> %33, <4 x double>* %34, align 32
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z4fabsDv4_d(<4 x double>) #1

; Function Attrs: nounwind readnone
declare <4 x double> @llvm.fmuladd.v4f64(<4 x double>, <4 x double>, <4 x double>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z3expDv4_d(<4 x double>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_blackScholes_kernel(<4 x double> addrspace(1)* %randArray, i32 %width, <4 x double> addrspace(1)* %call, <4 x double> addrspace(1)* %put) #0 {
entry:
  %randArray.addr = alloca <4 x double> addrspace(1)*, align 8
  %width.addr = alloca i32, align 4
  %call.addr = alloca <4 x double> addrspace(1)*, align 8
  %put.addr = alloca <4 x double> addrspace(1)*, align 8
  %d1 = alloca <4 x double>, align 32
  %d2 = alloca <4 x double>, align 32
  %phiD1 = alloca <4 x double>, align 32
  %phiD2 = alloca <4 x double>, align 32
  %sigmaSqrtT = alloca <4 x double>, align 32
  %KexpMinusRT = alloca <4 x double>, align 32
  %xPos = alloca i64, align 8
  %yPos = alloca i64, align 8
  %two = alloca <4 x double>, align 32
  %inRand = alloca <4 x double>, align 32
  %S = alloca <4 x double>, align 32
  %K = alloca <4 x double>, align 32
  %T = alloca <4 x double>, align 32
  %R = alloca <4 x double>, align 32
  %sigmaVal = alloca <4 x double>, align 32
  store <4 x double> addrspace(1)* %randArray, <4 x double> addrspace(1)** %randArray.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store <4 x double> addrspace(1)* %call, <4 x double> addrspace(1)** %call.addr, align 8
  store <4 x double> addrspace(1)* %put, <4 x double> addrspace(1)** %put.addr, align 8
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call1, i64* %xPos, align 8
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  store i64 %call2, i64* %yPos, align 8
  store <4 x double> <double 2.000000e+00, double 2.000000e+00, double 2.000000e+00, double 2.000000e+00>, <4 x double>* %two, align 32
  %0 = load i64* %yPos, align 8
  %1 = load i32* %width.addr, align 4
  %conv = sext i32 %1 to i64
  %mul = mul i64 %0, %conv
  %2 = load i64* %xPos, align 8
  %add = add i64 %mul, %2
  %3 = load <4 x double> addrspace(1)** %randArray.addr, align 8
  %arrayidx = getelementptr inbounds <4 x double> addrspace(1)* %3, i64 %add
  %4 = load <4 x double> addrspace(1)* %arrayidx, align 32
  store <4 x double> %4, <4 x double>* %inRand, align 32
  %5 = load <4 x double>* %inRand, align 32
  %6 = load <4 x double>* %inRand, align 32
  %sub = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %6
  %mul4 = fmul <4 x double> <double 1.000000e+02, double 1.000000e+02, double 1.000000e+02, double 1.000000e+02>, %sub
  %7 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 1.000000e+01, double 1.000000e+01, double 1.000000e+01, double 1.000000e+01>, <4 x double> %5, <4 x double> %mul4)
  store <4 x double> %7, <4 x double>* %S, align 32
  %8 = load <4 x double>* %inRand, align 32
  %9 = load <4 x double>* %inRand, align 32
  %sub6 = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %9
  %mul7 = fmul <4 x double> <double 1.000000e+02, double 1.000000e+02, double 1.000000e+02, double 1.000000e+02>, %sub6
  %10 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 1.000000e+01, double 1.000000e+01, double 1.000000e+01, double 1.000000e+01>, <4 x double> %8, <4 x double> %mul7)
  store <4 x double> %10, <4 x double>* %K, align 32
  %11 = load <4 x double>* %inRand, align 32
  %12 = load <4 x double>* %inRand, align 32
  %sub9 = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %12
  %mul10 = fmul <4 x double> <double 1.000000e+01, double 1.000000e+01, double 1.000000e+01, double 1.000000e+01>, %sub9
  %13 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, <4 x double> %11, <4 x double> %mul10)
  store <4 x double> %13, <4 x double>* %T, align 32
  %14 = load <4 x double>* %inRand, align 32
  %15 = load <4 x double>* %inRand, align 32
  %sub12 = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %15
  %mul13 = fmul <4 x double> <double 5.000000e-02, double 5.000000e-02, double 5.000000e-02, double 5.000000e-02>, %sub12
  %16 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 1.000000e-02, double 1.000000e-02, double 1.000000e-02, double 1.000000e-02>, <4 x double> %14, <4 x double> %mul13)
  store <4 x double> %16, <4 x double>* %R, align 32
  %17 = load <4 x double>* %inRand, align 32
  %18 = load <4 x double>* %inRand, align 32
  %sub15 = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %18
  %mul16 = fmul <4 x double> <double 1.000000e-01, double 1.000000e-01, double 1.000000e-01, double 1.000000e-01>, %sub15
  %19 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 1.000000e-02, double 1.000000e-02, double 1.000000e-02, double 1.000000e-02>, <4 x double> %17, <4 x double> %mul16)
  store <4 x double> %19, <4 x double>* %sigmaVal, align 32
  %20 = load <4 x double>* %sigmaVal, align 32
  %21 = load <4 x double>* %T, align 32
  %call17 = call cc75 <4 x double> @_Z4sqrtDv4_d(<4 x double> %21) #1
  %mul18 = fmul <4 x double> %20, %call17
  store <4 x double> %mul18, <4 x double>* %sigmaSqrtT, align 32
  %22 = load <4 x double>* %S, align 32
  %23 = load <4 x double>* %K, align 32
  %div = fdiv <4 x double> %22, %23
  %call19 = call cc75 <4 x double> @_Z3logDv4_d(<4 x double> %div) #1
  %24 = load <4 x double>* %R, align 32
  %25 = load <4 x double>* %sigmaVal, align 32
  %26 = load <4 x double>* %sigmaVal, align 32
  %mul20 = fmul <4 x double> %25, %26
  %27 = load <4 x double>* %two, align 32
  %div21 = fdiv <4 x double> %mul20, %27
  %add22 = fadd <4 x double> %24, %div21
  %28 = load <4 x double>* %T, align 32
  %29 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %add22, <4 x double> %28, <4 x double> %call19)
  %30 = load <4 x double>* %sigmaSqrtT, align 32
  %div24 = fdiv <4 x double> %29, %30
  store <4 x double> %div24, <4 x double>* %d1, align 32
  %31 = load <4 x double>* %d1, align 32
  %32 = load <4 x double>* %sigmaSqrtT, align 32
  %sub25 = fsub <4 x double> %31, %32
  store <4 x double> %sub25, <4 x double>* %d2, align 32
  %33 = load <4 x double>* %K, align 32
  %34 = load <4 x double>* %R, align 32
  %sub26 = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %34
  %35 = load <4 x double>* %T, align 32
  %mul27 = fmul <4 x double> %sub26, %35
  %call28 = call cc75 <4 x double> @_Z3expDv4_d(<4 x double> %mul27) #1
  %mul29 = fmul <4 x double> %33, %call28
  store <4 x double> %mul29, <4 x double>* %KexpMinusRT, align 32
  %36 = load <4 x double>* %d1, align 32
  call cc75 void @phi(<4 x double> %36, <4 x double>* %phiD1)
  %37 = load <4 x double>* %d2, align 32
  call cc75 void @phi(<4 x double> %37, <4 x double>* %phiD2)
  %38 = load <4 x double>* %S, align 32
  %39 = load <4 x double>* %phiD1, align 32
  %40 = load <4 x double>* %KexpMinusRT, align 32
  %41 = load <4 x double>* %phiD2, align 32
  %mul31 = fmul <4 x double> %40, %41
  %neg = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %mul31
  %42 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %38, <4 x double> %39, <4 x double> %neg)
  %43 = load i64* %yPos, align 8
  %44 = load i32* %width.addr, align 4
  %conv32 = sext i32 %44 to i64
  %mul33 = mul i64 %43, %conv32
  %45 = load i64* %xPos, align 8
  %add34 = add i64 %mul33, %45
  %46 = load <4 x double> addrspace(1)** %call.addr, align 8
  %arrayidx35 = getelementptr inbounds <4 x double> addrspace(1)* %46, i64 %add34
  store <4 x double> %42, <4 x double> addrspace(1)* %arrayidx35, align 32
  %47 = load <4 x double>* %d1, align 32
  %sub36 = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %47
  call cc75 void @phi(<4 x double> %sub36, <4 x double>* %phiD1)
  %48 = load <4 x double>* %d2, align 32
  %sub37 = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %48
  call cc75 void @phi(<4 x double> %sub37, <4 x double>* %phiD2)
  %49 = load <4 x double>* %KexpMinusRT, align 32
  %50 = load <4 x double>* %phiD2, align 32
  %51 = load <4 x double>* %S, align 32
  %52 = load <4 x double>* %phiD1, align 32
  %mul39 = fmul <4 x double> %51, %52
  %neg40 = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %mul39
  %53 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %49, <4 x double> %50, <4 x double> %neg40)
  %54 = load i64* %yPos, align 8
  %55 = load i32* %width.addr, align 4
  %conv41 = sext i32 %55 to i64
  %mul42 = mul i64 %54, %conv41
  %56 = load i64* %xPos, align 8
  %add43 = add i64 %mul42, %56
  %57 = load <4 x double> addrspace(1)** %put.addr, align 8
  %arrayidx44 = getelementptr inbounds <4 x double> addrspace(1)* %57, i64 %add43
  store <4 x double> %53, <4 x double> addrspace(1)* %arrayidx44, align 32
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z4sqrtDv4_d(<4 x double>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z3logDv4_d(<4 x double>) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (<4 x double> addrspace(1)*, i32, <4 x double> addrspace(1)*, <4 x double> addrspace(1)*)* @__OpenCL_blackScholes_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"double4*", metadata !"int", metadata !"double4*", metadata !"double4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"const", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"double4*", metadata !"int", metadata !"double4*", metadata !"double4*"}
!6 = metadata !{i32 1, i32 2}

; ModuleID = 'RecursiveGaussian_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_transpose_kernel_kernel(<4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(3)* %block, i32 %width, i32 %height, i32 %blockSize) #0 {
entry:
  %output.addr = alloca <4 x i8> addrspace(1)*, align 8
  %input.addr = alloca <4 x i8> addrspace(1)*, align 8
  %block.addr = alloca <4 x i8> addrspace(3)*, align 8
  %width.addr = alloca i32, align 4
  %height.addr = alloca i32, align 4
  %blockSize.addr = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %globalIdy = alloca i32, align 4
  %localIdx = alloca i32, align 4
  %localIdy = alloca i32, align 4
  %sourceIndex = alloca i32, align 4
  %targetIndex = alloca i32, align 4
  store <4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)** %output.addr, align 8
  store <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)** %input.addr, align 8
  store <4 x i8> addrspace(3)* %block, <4 x i8> addrspace(3)** %block.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store i32 %height, i32* %height.addr, align 4
  store i32 %blockSize, i32* %blockSize.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %globalIdx, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %globalIdy, align 4
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %localIdx, align 4
  %call5 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %localIdy, align 4
  %0 = load i32* %globalIdy, align 4
  %1 = load i32* %width.addr, align 4
  %mul = mul i32 %0, %1
  %2 = load i32* %globalIdx, align 4
  %add = add i32 %mul, %2
  %idxprom = zext i32 %add to i64
  %3 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %3, i64 %idxprom
  %4 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %5 = load i32* %localIdy, align 4
  %6 = load i32* %blockSize.addr, align 4
  %mul7 = mul i32 %5, %6
  %7 = load i32* %localIdx, align 4
  %add8 = add i32 %mul7, %7
  %idxprom9 = zext i32 %add8 to i64
  %8 = load <4 x i8> addrspace(3)** %block.addr, align 8
  %arrayidx10 = getelementptr inbounds <4 x i8> addrspace(3)* %8, i64 %idxprom9
  store <4 x i8> %4, <4 x i8> addrspace(3)* %arrayidx10, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %9 = load i32* %localIdy, align 4
  %10 = load i32* %blockSize.addr, align 4
  %mul11 = mul i32 %9, %10
  %11 = load i32* %localIdx, align 4
  %add12 = add i32 %mul11, %11
  store i32 %add12, i32* %sourceIndex, align 4
  %12 = load i32* %globalIdy, align 4
  %13 = load i32* %globalIdx, align 4
  %14 = load i32* %height.addr, align 4
  %mul13 = mul i32 %13, %14
  %add14 = add i32 %12, %mul13
  store i32 %add14, i32* %targetIndex, align 4
  %15 = load i32* %sourceIndex, align 4
  %idxprom15 = zext i32 %15 to i64
  %16 = load <4 x i8> addrspace(3)** %block.addr, align 8
  %arrayidx16 = getelementptr inbounds <4 x i8> addrspace(3)* %16, i64 %idxprom15
  %17 = load <4 x i8> addrspace(3)* %arrayidx16, align 4
  %18 = load i32* %targetIndex, align 4
  %idxprom17 = zext i32 %18 to i64
  %19 = load <4 x i8> addrspace(1)** %output.addr, align 8
  %arrayidx18 = getelementptr inbounds <4 x i8> addrspace(1)* %19, i64 %idxprom17
  store <4 x i8> %17, <4 x i8> addrspace(1)* %arrayidx18, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

; Function Attrs: nounwind
define cc76 void @__OpenCL_RecursiveGaussian_kernel_kernel(<4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)* %output, i32 %width, i32 %height, float %a0, float %a1, float %a2, float %a3, float %b1, float %b2, float %coefp, float %coefn) #0 {
entry:
  %input.addr = alloca <4 x i8> addrspace(1)*, align 8
  %output.addr = alloca <4 x i8> addrspace(1)*, align 8
  %width.addr = alloca i32, align 4
  %height.addr = alloca i32, align 4
  %a0.addr = alloca float, align 4
  %a1.addr = alloca float, align 4
  %a2.addr = alloca float, align 4
  %a3.addr = alloca float, align 4
  %b1.addr = alloca float, align 4
  %b2.addr = alloca float, align 4
  %coefp.addr = alloca float, align 4
  %coefn.addr = alloca float, align 4
  %x = alloca i32, align 4
  %xp = alloca <4 x float>, align 16
  %yp = alloca <4 x float>, align 16
  %yb = alloca <4 x float>, align 16
  %y = alloca i32, align 4
  %pos = alloca i32, align 4
  %xc = alloca <4 x float>, align 16
  %.compoundliteral = alloca <4 x float>, align 16
  %yc = alloca <4 x float>, align 16
  %.compoundliteral25 = alloca <4 x i8>, align 4
  %xn = alloca <4 x float>, align 16
  %xa = alloca <4 x float>, align 16
  %yn = alloca <4 x float>, align 16
  %ya = alloca <4 x float>, align 16
  %y36 = alloca i32, align 4
  %pos41 = alloca i32, align 4
  %xc44 = alloca <4 x float>, align 16
  %.compoundliteral45 = alloca <4 x float>, align 16
  %yc62 = alloca <4 x float>, align 16
  %temp = alloca <4 x float>, align 16
  %.compoundliteral73 = alloca <4 x float>, align 16
  %.compoundliteral91 = alloca <4 x i8>, align 4
  store <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)** %input.addr, align 8
  store <4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)** %output.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store i32 %height, i32* %height.addr, align 4
  store float %a0, float* %a0.addr, align 4
  store float %a1, float* %a1.addr, align 4
  store float %a2, float* %a2.addr, align 4
  store float %a3, float* %a3.addr, align 4
  store float %b1, float* %b1.addr, align 4
  store float %b2, float* %b2.addr, align 4
  store float %coefp, float* %coefp.addr, align 4
  store float %coefn, float* %coefn.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %0 = load i32* %x, align 4
  %1 = load i32* %width.addr, align 4
  %cmp = icmp uge i32 %0, %1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %for.end103

if.end:                                           ; preds = %entry
  store <4 x float> zeroinitializer, <4 x float>* %xp, align 16
  store <4 x float> zeroinitializer, <4 x float>* %yp, align 16
  store <4 x float> zeroinitializer, <4 x float>* %yb, align 16
  store i32 0, i32* %y, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end
  %2 = load i32* %y, align 4
  %3 = load i32* %height.addr, align 4
  %cmp2 = icmp slt i32 %2, %3
  br i1 %cmp2, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i32* %x, align 4
  %5 = load i32* %y, align 4
  %6 = load i32* %width.addr, align 4
  %mul = mul nsw i32 %5, %6
  %add = add i32 %4, %mul
  store i32 %add, i32* %pos, align 4
  %7 = load i32* %pos, align 4
  %idxprom = sext i32 %7 to i64
  %8 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %8, i64 %idxprom
  %9 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %10 = extractelement <4 x i8> %9, i32 0
  %conv4 = uitofp i8 %10 to float
  %vecinit = insertelement <4 x float> undef, float %conv4, i32 0
  %11 = load i32* %pos, align 4
  %idxprom5 = sext i32 %11 to i64
  %12 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx6 = getelementptr inbounds <4 x i8> addrspace(1)* %12, i64 %idxprom5
  %13 = load <4 x i8> addrspace(1)* %arrayidx6, align 4
  %14 = extractelement <4 x i8> %13, i32 1
  %conv7 = uitofp i8 %14 to float
  %vecinit8 = insertelement <4 x float> %vecinit, float %conv7, i32 1
  %15 = load i32* %pos, align 4
  %idxprom9 = sext i32 %15 to i64
  %16 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx10 = getelementptr inbounds <4 x i8> addrspace(1)* %16, i64 %idxprom9
  %17 = load <4 x i8> addrspace(1)* %arrayidx10, align 4
  %18 = extractelement <4 x i8> %17, i32 2
  %conv11 = uitofp i8 %18 to float
  %vecinit12 = insertelement <4 x float> %vecinit8, float %conv11, i32 2
  %19 = load i32* %pos, align 4
  %idxprom13 = sext i32 %19 to i64
  %20 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx14 = getelementptr inbounds <4 x i8> addrspace(1)* %20, i64 %idxprom13
  %21 = load <4 x i8> addrspace(1)* %arrayidx14, align 4
  %22 = extractelement <4 x i8> %21, i32 3
  %conv15 = uitofp i8 %22 to float
  %vecinit16 = insertelement <4 x float> %vecinit12, float %conv15, i32 3
  store <4 x float> %vecinit16, <4 x float>* %.compoundliteral
  %23 = load <4 x float>* %.compoundliteral
  store <4 x float> %23, <4 x float>* %xc, align 16
  %24 = load float* %a0.addr, align 4
  %25 = insertelement <4 x float> undef, float %24, i32 0
  %splat = shufflevector <4 x float> %25, <4 x float> %25, <4 x i32> zeroinitializer
  %26 = load <4 x float>* %xc, align 16
  %27 = load float* %a1.addr, align 4
  %28 = insertelement <4 x float> undef, float %27, i32 0
  %splat18 = shufflevector <4 x float> %28, <4 x float> %28, <4 x i32> zeroinitializer
  %29 = load <4 x float>* %xp, align 16
  %mul19 = fmul <4 x float> %splat18, %29
  %30 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %splat, <4 x float> %26, <4 x float> %mul19)
  %31 = load float* %b1.addr, align 4
  %32 = insertelement <4 x float> undef, float %31, i32 0
  %splat20 = shufflevector <4 x float> %32, <4 x float> %32, <4 x i32> zeroinitializer
  %33 = load <4 x float>* %yp, align 16
  %neg = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat20
  %34 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg, <4 x float> %33, <4 x float> %30)
  %35 = load float* %b2.addr, align 4
  %36 = insertelement <4 x float> undef, float %35, i32 0
  %splat22 = shufflevector <4 x float> %36, <4 x float> %36, <4 x i32> zeroinitializer
  %37 = load <4 x float>* %yb, align 16
  %neg24 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat22
  %38 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg24, <4 x float> %37, <4 x float> %34)
  store <4 x float> %38, <4 x float>* %yc, align 16
  %39 = load <4 x float>* %yc, align 16
  %40 = extractelement <4 x float> %39, i32 0
  %conv26 = fptoui float %40 to i8
  %vecinit27 = insertelement <4 x i8> undef, i8 %conv26, i32 0
  %41 = load <4 x float>* %yc, align 16
  %42 = extractelement <4 x float> %41, i32 1
  %conv28 = fptoui float %42 to i8
  %vecinit29 = insertelement <4 x i8> %vecinit27, i8 %conv28, i32 1
  %43 = load <4 x float>* %yc, align 16
  %44 = extractelement <4 x float> %43, i32 2
  %conv30 = fptoui float %44 to i8
  %vecinit31 = insertelement <4 x i8> %vecinit29, i8 %conv30, i32 2
  %45 = load <4 x float>* %yc, align 16
  %46 = extractelement <4 x float> %45, i32 3
  %conv32 = fptoui float %46 to i8
  %vecinit33 = insertelement <4 x i8> %vecinit31, i8 %conv32, i32 3
  store <4 x i8> %vecinit33, <4 x i8>* %.compoundliteral25
  %47 = load <4 x i8>* %.compoundliteral25
  %48 = load i32* %pos, align 4
  %idxprom34 = sext i32 %48 to i64
  %49 = load <4 x i8> addrspace(1)** %output.addr, align 8
  %arrayidx35 = getelementptr inbounds <4 x i8> addrspace(1)* %49, i64 %idxprom34
  store <4 x i8> %47, <4 x i8> addrspace(1)* %arrayidx35, align 4
  %50 = load <4 x float>* %xc, align 16
  store <4 x float> %50, <4 x float>* %xp, align 16
  %51 = load <4 x float>* %yp, align 16
  store <4 x float> %51, <4 x float>* %yb, align 16
  %52 = load <4 x float>* %yc, align 16
  store <4 x float> %52, <4 x float>* %yp, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %53 = load i32* %y, align 4
  %inc = add nsw i32 %53, 1
  store i32 %inc, i32* %y, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 2)
  store <4 x float> zeroinitializer, <4 x float>* %xn, align 16
  store <4 x float> zeroinitializer, <4 x float>* %xa, align 16
  store <4 x float> zeroinitializer, <4 x float>* %yn, align 16
  store <4 x float> zeroinitializer, <4 x float>* %ya, align 16
  %54 = load i32* %height.addr, align 4
  %sub = sub nsw i32 %54, 1
  store i32 %sub, i32* %y36, align 4
  br label %for.cond37

for.cond37:                                       ; preds = %for.inc102, %for.end
  %55 = load i32* %y36, align 4
  %cmp38 = icmp sgt i32 %55, -1
  br i1 %cmp38, label %for.body40, label %for.end103

for.body40:                                       ; preds = %for.cond37
  %56 = load i32* %x, align 4
  %57 = load i32* %y36, align 4
  %58 = load i32* %width.addr, align 4
  %mul42 = mul nsw i32 %57, %58
  %add43 = add i32 %56, %mul42
  store i32 %add43, i32* %pos41, align 4
  %59 = load i32* %pos41, align 4
  %idxprom46 = sext i32 %59 to i64
  %60 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx47 = getelementptr inbounds <4 x i8> addrspace(1)* %60, i64 %idxprom46
  %61 = load <4 x i8> addrspace(1)* %arrayidx47, align 4
  %62 = extractelement <4 x i8> %61, i32 0
  %conv48 = uitofp i8 %62 to float
  %vecinit49 = insertelement <4 x float> undef, float %conv48, i32 0
  %63 = load i32* %pos41, align 4
  %idxprom50 = sext i32 %63 to i64
  %64 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx51 = getelementptr inbounds <4 x i8> addrspace(1)* %64, i64 %idxprom50
  %65 = load <4 x i8> addrspace(1)* %arrayidx51, align 4
  %66 = extractelement <4 x i8> %65, i32 1
  %conv52 = uitofp i8 %66 to float
  %vecinit53 = insertelement <4 x float> %vecinit49, float %conv52, i32 1
  %67 = load i32* %pos41, align 4
  %idxprom54 = sext i32 %67 to i64
  %68 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx55 = getelementptr inbounds <4 x i8> addrspace(1)* %68, i64 %idxprom54
  %69 = load <4 x i8> addrspace(1)* %arrayidx55, align 4
  %70 = extractelement <4 x i8> %69, i32 2
  %conv56 = uitofp i8 %70 to float
  %vecinit57 = insertelement <4 x float> %vecinit53, float %conv56, i32 2
  %71 = load i32* %pos41, align 4
  %idxprom58 = sext i32 %71 to i64
  %72 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx59 = getelementptr inbounds <4 x i8> addrspace(1)* %72, i64 %idxprom58
  %73 = load <4 x i8> addrspace(1)* %arrayidx59, align 4
  %74 = extractelement <4 x i8> %73, i32 3
  %conv60 = uitofp i8 %74 to float
  %vecinit61 = insertelement <4 x float> %vecinit57, float %conv60, i32 3
  store <4 x float> %vecinit61, <4 x float>* %.compoundliteral45
  %75 = load <4 x float>* %.compoundliteral45
  store <4 x float> %75, <4 x float>* %xc44, align 16
  %76 = load float* %a2.addr, align 4
  %77 = insertelement <4 x float> undef, float %76, i32 0
  %splat63 = shufflevector <4 x float> %77, <4 x float> %77, <4 x i32> zeroinitializer
  %78 = load <4 x float>* %xn, align 16
  %79 = load float* %a3.addr, align 4
  %80 = insertelement <4 x float> undef, float %79, i32 0
  %splat65 = shufflevector <4 x float> %80, <4 x float> %80, <4 x i32> zeroinitializer
  %81 = load <4 x float>* %xa, align 16
  %mul66 = fmul <4 x float> %splat65, %81
  %82 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %splat63, <4 x float> %78, <4 x float> %mul66)
  %83 = load float* %b1.addr, align 4
  %84 = insertelement <4 x float> undef, float %83, i32 0
  %splat67 = shufflevector <4 x float> %84, <4 x float> %84, <4 x i32> zeroinitializer
  %85 = load <4 x float>* %yn, align 16
  %neg69 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat67
  %86 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg69, <4 x float> %85, <4 x float> %82)
  %87 = load float* %b2.addr, align 4
  %88 = insertelement <4 x float> undef, float %87, i32 0
  %splat70 = shufflevector <4 x float> %88, <4 x float> %88, <4 x i32> zeroinitializer
  %89 = load <4 x float>* %ya, align 16
  %neg72 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat70
  %90 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg72, <4 x float> %89, <4 x float> %86)
  store <4 x float> %90, <4 x float>* %yc62, align 16
  %91 = load <4 x float>* %xn, align 16
  store <4 x float> %91, <4 x float>* %xa, align 16
  %92 = load <4 x float>* %xc44, align 16
  store <4 x float> %92, <4 x float>* %xn, align 16
  %93 = load <4 x float>* %yn, align 16
  store <4 x float> %93, <4 x float>* %ya, align 16
  %94 = load <4 x float>* %yc62, align 16
  store <4 x float> %94, <4 x float>* %yn, align 16
  %95 = load i32* %pos41, align 4
  %idxprom74 = sext i32 %95 to i64
  %96 = load <4 x i8> addrspace(1)** %output.addr, align 8
  %arrayidx75 = getelementptr inbounds <4 x i8> addrspace(1)* %96, i64 %idxprom74
  %97 = load <4 x i8> addrspace(1)* %arrayidx75, align 4
  %98 = extractelement <4 x i8> %97, i32 0
  %conv76 = uitofp i8 %98 to float
  %vecinit77 = insertelement <4 x float> undef, float %conv76, i32 0
  %99 = load i32* %pos41, align 4
  %idxprom78 = sext i32 %99 to i64
  %100 = load <4 x i8> addrspace(1)** %output.addr, align 8
  %arrayidx79 = getelementptr inbounds <4 x i8> addrspace(1)* %100, i64 %idxprom78
  %101 = load <4 x i8> addrspace(1)* %arrayidx79, align 4
  %102 = extractelement <4 x i8> %101, i32 1
  %conv80 = uitofp i8 %102 to float
  %vecinit81 = insertelement <4 x float> %vecinit77, float %conv80, i32 1
  %103 = load i32* %pos41, align 4
  %idxprom82 = sext i32 %103 to i64
  %104 = load <4 x i8> addrspace(1)** %output.addr, align 8
  %arrayidx83 = getelementptr inbounds <4 x i8> addrspace(1)* %104, i64 %idxprom82
  %105 = load <4 x i8> addrspace(1)* %arrayidx83, align 4
  %106 = extractelement <4 x i8> %105, i32 2
  %conv84 = uitofp i8 %106 to float
  %vecinit85 = insertelement <4 x float> %vecinit81, float %conv84, i32 2
  %107 = load i32* %pos41, align 4
  %idxprom86 = sext i32 %107 to i64
  %108 = load <4 x i8> addrspace(1)** %output.addr, align 8
  %arrayidx87 = getelementptr inbounds <4 x i8> addrspace(1)* %108, i64 %idxprom86
  %109 = load <4 x i8> addrspace(1)* %arrayidx87, align 4
  %110 = extractelement <4 x i8> %109, i32 3
  %conv88 = uitofp i8 %110 to float
  %vecinit89 = insertelement <4 x float> %vecinit85, float %conv88, i32 3
  store <4 x float> %vecinit89, <4 x float>* %.compoundliteral73
  %111 = load <4 x float>* %.compoundliteral73
  %112 = load <4 x float>* %yc62, align 16
  %add90 = fadd <4 x float> %111, %112
  store <4 x float> %add90, <4 x float>* %temp, align 16
  %113 = load <4 x float>* %temp, align 16
  %114 = extractelement <4 x float> %113, i32 0
  %conv92 = fptoui float %114 to i8
  %vecinit93 = insertelement <4 x i8> undef, i8 %conv92, i32 0
  %115 = load <4 x float>* %temp, align 16
  %116 = extractelement <4 x float> %115, i32 1
  %conv94 = fptoui float %116 to i8
  %vecinit95 = insertelement <4 x i8> %vecinit93, i8 %conv94, i32 1
  %117 = load <4 x float>* %temp, align 16
  %118 = extractelement <4 x float> %117, i32 2
  %conv96 = fptoui float %118 to i8
  %vecinit97 = insertelement <4 x i8> %vecinit95, i8 %conv96, i32 2
  %119 = load <4 x float>* %temp, align 16
  %120 = extractelement <4 x float> %119, i32 3
  %conv98 = fptoui float %120 to i8
  %vecinit99 = insertelement <4 x i8> %vecinit97, i8 %conv98, i32 3
  store <4 x i8> %vecinit99, <4 x i8>* %.compoundliteral91
  %121 = load <4 x i8>* %.compoundliteral91
  %122 = load i32* %pos41, align 4
  %idxprom100 = sext i32 %122 to i64
  %123 = load <4 x i8> addrspace(1)** %output.addr, align 8
  %arrayidx101 = getelementptr inbounds <4 x i8> addrspace(1)* %123, i64 %idxprom100
  store <4 x i8> %121, <4 x i8> addrspace(1)* %arrayidx101, align 4
  br label %for.inc102

for.inc102:                                       ; preds = %for.body40
  %124 = load i32* %y36, align 4
  %dec = add nsw i32 %124, -1
  store i32 %dec, i32* %y36, align 4
  br label %for.cond37

for.end103:                                       ; preds = %for.cond37, %if.then
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!12}
!opencl.spir.version = !{!12}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, <4 x i8> addrspace(3)*, i32, i32, i32)* @__OpenCL_transpose_kernel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"uchar4*", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"const", metadata !"const", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"uchar4*", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, i32, float, float, float, float, float, float, float, float)* @__OpenCL_RecursiveGaussian_kernel_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int", metadata !"int", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"float"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"const", metadata !"", metadata !"const", metadata !"const", metadata !"const", metadata !"const", metadata !"const", metadata !"const", metadata !"const", metadata !"const", metadata !"const", metadata !"const"}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int", metadata !"int", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"float"}
!12 = metadata !{i32 1, i32 2}

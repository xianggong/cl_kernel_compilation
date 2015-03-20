; ModuleID = 'BinomialOption_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_binomial_options_kernel(i32 %numSteps, <4 x float> addrspace(1)* %randArray, <4 x float> addrspace(1)* %output, <4 x float> addrspace(3)* %callA, <4 x float> addrspace(3)* %callB) #0 {
entry:
  %numSteps.addr = alloca i32, align 4
  %randArray.addr = alloca <4 x float> addrspace(1)*, align 8
  %output.addr = alloca <4 x float> addrspace(1)*, align 8
  %callA.addr = alloca <4 x float> addrspace(3)*, align 8
  %callB.addr = alloca <4 x float> addrspace(3)*, align 8
  %tid = alloca i32, align 4
  %bid = alloca i32, align 4
  %inRand = alloca <4 x float>, align 16
  %s = alloca <4 x float>, align 16
  %x = alloca <4 x float>, align 16
  %optionYears = alloca <4 x float>, align 16
  %dt = alloca <4 x float>, align 16
  %vsdt = alloca <4 x float>, align 16
  %rdt = alloca <4 x float>, align 16
  %r = alloca <4 x float>, align 16
  %rInv = alloca <4 x float>, align 16
  %u = alloca <4 x float>, align 16
  %d = alloca <4 x float>, align 16
  %pu = alloca <4 x float>, align 16
  %pd = alloca <4 x float>, align 16
  %puByr = alloca <4 x float>, align 16
  %pdByr = alloca <4 x float>, align 16
  %profit = alloca <4 x float>, align 16
  %j = alloca i32, align 4
  store i32 %numSteps, i32* %numSteps.addr, align 4
  store <4 x float> addrspace(1)* %randArray, <4 x float> addrspace(1)** %randArray.addr, align 8
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %output.addr, align 8
  store <4 x float> addrspace(3)* %callA, <4 x float> addrspace(3)** %callA.addr, align 8
  store <4 x float> addrspace(3)* %callB, <4 x float> addrspace(3)** %callB.addr, align 8
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %bid, align 4
  %0 = load i32* %bid, align 4
  %idxprom = zext i32 %0 to i64
  %1 = load <4 x float> addrspace(1)** %randArray.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %1, i64 %idxprom
  %2 = load <4 x float> addrspace(1)* %arrayidx, align 16
  store <4 x float> %2, <4 x float>* %inRand, align 16
  %3 = load <4 x float>* %inRand, align 16
  %sub = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %3
  %4 = load <4 x float>* %inRand, align 16
  %mul3 = fmul <4 x float> %4, <float 3.000000e+01, float 3.000000e+01, float 3.000000e+01, float 3.000000e+01>
  %5 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %sub, <4 x float> <float 5.000000e+00, float 5.000000e+00, float 5.000000e+00, float 5.000000e+00>, <4 x float> %mul3)
  store <4 x float> %5, <4 x float>* %s, align 16
  %6 = load <4 x float>* %inRand, align 16
  %sub4 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %6
  %7 = load <4 x float>* %inRand, align 16
  %mul5 = fmul <4 x float> %7, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %8 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %sub4, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %mul5)
  store <4 x float> %8, <4 x float>* %x, align 16
  %9 = load <4 x float>* %inRand, align 16
  %sub6 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %9
  %10 = load <4 x float>* %inRand, align 16
  %mul7 = fmul <4 x float> %10, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %11 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %sub6, <4 x float> <float 2.500000e-01, float 2.500000e-01, float 2.500000e-01, float 2.500000e-01>, <4 x float> %mul7)
  store <4 x float> %11, <4 x float>* %optionYears, align 16
  %12 = load <4 x float>* %optionYears, align 16
  %13 = load i32* %numSteps.addr, align 4
  %conv8 = sitofp i32 %13 to float
  %div = fdiv float 1.000000e+00, %conv8, !fpmath !7
  %14 = insertelement <4 x float> undef, float %div, i32 0
  %splat = shufflevector <4 x float> %14, <4 x float> %14, <4 x i32> zeroinitializer
  %mul = fmul <4 x float> %12, %splat
  store <4 x float> %mul, <4 x float>* %dt, align 16
  %15 = load <4 x float>* %dt, align 16
  %call9 = call cc75 <4 x float> @_Z4sqrtDv4_f(<4 x float> %15) #1
  %mul10 = fmul <4 x float> <float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000>, %call9
  store <4 x float> %mul10, <4 x float>* %vsdt, align 16
  %16 = load <4 x float>* %dt, align 16
  %mul11 = fmul <4 x float> <float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000>, %16
  store <4 x float> %mul11, <4 x float>* %rdt, align 16
  %17 = load <4 x float>* %rdt, align 16
  %call12 = call cc75 <4 x float> @_Z3expDv4_f(<4 x float> %17) #1
  store <4 x float> %call12, <4 x float>* %r, align 16
  %18 = load <4 x float>* %r, align 16
  %div13 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %18, !fpmath !7
  store <4 x float> %div13, <4 x float>* %rInv, align 16
  %19 = load <4 x float>* %vsdt, align 16
  %call14 = call cc75 <4 x float> @_Z3expDv4_f(<4 x float> %19) #1
  store <4 x float> %call14, <4 x float>* %u, align 16
  %20 = load <4 x float>* %u, align 16
  %div15 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %20, !fpmath !7
  store <4 x float> %div15, <4 x float>* %d, align 16
  %21 = load <4 x float>* %r, align 16
  %22 = load <4 x float>* %d, align 16
  %sub16 = fsub <4 x float> %21, %22
  %23 = load <4 x float>* %u, align 16
  %24 = load <4 x float>* %d, align 16
  %sub17 = fsub <4 x float> %23, %24
  %div18 = fdiv <4 x float> %sub16, %sub17, !fpmath !7
  store <4 x float> %div18, <4 x float>* %pu, align 16
  %25 = load <4 x float>* %pu, align 16
  %sub19 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %25
  store <4 x float> %sub19, <4 x float>* %pd, align 16
  %26 = load <4 x float>* %pu, align 16
  %27 = load <4 x float>* %rInv, align 16
  %mul20 = fmul <4 x float> %26, %27
  store <4 x float> %mul20, <4 x float>* %puByr, align 16
  %28 = load <4 x float>* %pd, align 16
  %29 = load <4 x float>* %rInv, align 16
  %mul21 = fmul <4 x float> %28, %29
  store <4 x float> %mul21, <4 x float>* %pdByr, align 16
  %30 = load <4 x float>* %s, align 16
  %31 = load <4 x float>* %vsdt, align 16
  %32 = load i32* %tid, align 4
  %conv22 = uitofp i32 %32 to float
  %33 = load i32* %numSteps.addr, align 4
  %conv24 = sitofp i32 %33 to float
  %neg = fsub float -0.000000e+00, %conv24
  %34 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %conv22, float %neg)
  %35 = insertelement <4 x float> undef, float %34, i32 0
  %splat25 = shufflevector <4 x float> %35, <4 x float> %35, <4 x i32> zeroinitializer
  %mul26 = fmul <4 x float> %31, %splat25
  %call27 = call cc75 <4 x float> @_Z3expDv4_f(<4 x float> %mul26) #1
  %36 = load <4 x float>* %x, align 16
  %neg29 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %36
  %37 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %30, <4 x float> %call27, <4 x float> %neg29)
  store <4 x float> %37, <4 x float>* %profit, align 16
  %38 = load <4 x float>* %profit, align 16
  %39 = extractelement <4 x float> %38, i32 0
  %cmp = fcmp ogt float %39, 0.000000e+00
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %40 = load <4 x float>* %profit, align 16
  %41 = extractelement <4 x float> %40, i32 0
  br label %cond.end

cond.false:                                       ; preds = %entry
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %41, %cond.true ], [ 0.000000e+00, %cond.false ]
  %42 = load i32* %tid, align 4
  %idxprom31 = zext i32 %42 to i64
  %43 = load <4 x float> addrspace(3)** %callA.addr, align 8
  %arrayidx32 = getelementptr inbounds <4 x float> addrspace(3)* %43, i64 %idxprom31
  %44 = load <4 x float> addrspace(3)* %arrayidx32, align 16
  %45 = insertelement <4 x float> %44, float %cond, i32 0
  store <4 x float> %45, <4 x float> addrspace(3)* %arrayidx32, align 16
  %46 = load <4 x float>* %profit, align 16
  %47 = extractelement <4 x float> %46, i32 1
  %cmp33 = fcmp ogt float %47, 0.000000e+00
  br i1 %cmp33, label %cond.true35, label %cond.false36

cond.true35:                                      ; preds = %cond.end
  %48 = load <4 x float>* %profit, align 16
  %49 = extractelement <4 x float> %48, i32 1
  br label %cond.end37

cond.false36:                                     ; preds = %cond.end
  br label %cond.end37

cond.end37:                                       ; preds = %cond.false36, %cond.true35
  %cond38 = phi float [ %49, %cond.true35 ], [ 0.000000e+00, %cond.false36 ]
  %50 = load i32* %tid, align 4
  %idxprom39 = zext i32 %50 to i64
  %51 = load <4 x float> addrspace(3)** %callA.addr, align 8
  %arrayidx40 = getelementptr inbounds <4 x float> addrspace(3)* %51, i64 %idxprom39
  %52 = load <4 x float> addrspace(3)* %arrayidx40, align 16
  %53 = insertelement <4 x float> %52, float %cond38, i32 1
  store <4 x float> %53, <4 x float> addrspace(3)* %arrayidx40, align 16
  %54 = load <4 x float>* %profit, align 16
  %55 = extractelement <4 x float> %54, i32 2
  %cmp41 = fcmp ogt float %55, 0.000000e+00
  br i1 %cmp41, label %cond.true43, label %cond.false44

cond.true43:                                      ; preds = %cond.end37
  %56 = load <4 x float>* %profit, align 16
  %57 = extractelement <4 x float> %56, i32 2
  br label %cond.end45

cond.false44:                                     ; preds = %cond.end37
  br label %cond.end45

cond.end45:                                       ; preds = %cond.false44, %cond.true43
  %cond46 = phi float [ %57, %cond.true43 ], [ 0.000000e+00, %cond.false44 ]
  %58 = load i32* %tid, align 4
  %idxprom47 = zext i32 %58 to i64
  %59 = load <4 x float> addrspace(3)** %callA.addr, align 8
  %arrayidx48 = getelementptr inbounds <4 x float> addrspace(3)* %59, i64 %idxprom47
  %60 = load <4 x float> addrspace(3)* %arrayidx48, align 16
  %61 = insertelement <4 x float> %60, float %cond46, i32 2
  store <4 x float> %61, <4 x float> addrspace(3)* %arrayidx48, align 16
  %62 = load <4 x float>* %profit, align 16
  %63 = extractelement <4 x float> %62, i32 3
  %cmp49 = fcmp ogt float %63, 0.000000e+00
  br i1 %cmp49, label %cond.true51, label %cond.false52

cond.true51:                                      ; preds = %cond.end45
  %64 = load <4 x float>* %profit, align 16
  %65 = extractelement <4 x float> %64, i32 3
  br label %cond.end53

cond.false52:                                     ; preds = %cond.end45
  br label %cond.end53

cond.end53:                                       ; preds = %cond.false52, %cond.true51
  %cond54 = phi float [ %65, %cond.true51 ], [ 0.000000e+00, %cond.false52 ]
  %66 = load i32* %tid, align 4
  %idxprom55 = zext i32 %66 to i64
  %67 = load <4 x float> addrspace(3)** %callA.addr, align 8
  %arrayidx56 = getelementptr inbounds <4 x float> addrspace(3)* %67, i64 %idxprom55
  %68 = load <4 x float> addrspace(3)* %arrayidx56, align 16
  %69 = insertelement <4 x float> %68, float %cond54, i32 3
  store <4 x float> %69, <4 x float> addrspace(3)* %arrayidx56, align 16
  call cc75 void @_Z7barrierj(i32 1)
  %70 = load i32* %numSteps.addr, align 4
  store i32 %70, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %cond.end53
  %71 = load i32* %j, align 4
  %cmp57 = icmp sgt i32 %71, 0
  br i1 %cmp57, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %72 = load i32* %tid, align 4
  %73 = load i32* %j, align 4
  %cmp59 = icmp ult i32 %72, %73
  br i1 %cmp59, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %74 = load <4 x float>* %puByr, align 16
  %75 = load i32* %tid, align 4
  %idxprom61 = zext i32 %75 to i64
  %76 = load <4 x float> addrspace(3)** %callA.addr, align 8
  %arrayidx62 = getelementptr inbounds <4 x float> addrspace(3)* %76, i64 %idxprom61
  %77 = load <4 x float> addrspace(3)* %arrayidx62, align 16
  %78 = load <4 x float>* %pdByr, align 16
  %79 = load i32* %tid, align 4
  %add = add i32 %79, 1
  %idxprom64 = zext i32 %add to i64
  %80 = load <4 x float> addrspace(3)** %callA.addr, align 8
  %arrayidx65 = getelementptr inbounds <4 x float> addrspace(3)* %80, i64 %idxprom64
  %81 = load <4 x float> addrspace(3)* %arrayidx65, align 16
  %mul66 = fmul <4 x float> %78, %81
  %82 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %74, <4 x float> %77, <4 x float> %mul66)
  %83 = load i32* %tid, align 4
  %idxprom67 = zext i32 %83 to i64
  %84 = load <4 x float> addrspace(3)** %callB.addr, align 8
  %arrayidx68 = getelementptr inbounds <4 x float> addrspace(3)* %84, i64 %idxprom67
  store <4 x float> %82, <4 x float> addrspace(3)* %arrayidx68, align 16
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  call cc75 void @_Z7barrierj(i32 1)
  %85 = load i32* %tid, align 4
  %86 = load i32* %j, align 4
  %sub69 = sub nsw i32 %86, 1
  %cmp70 = icmp ult i32 %85, %sub69
  br i1 %cmp70, label %if.then72, label %if.end82

if.then72:                                        ; preds = %if.end
  %87 = load <4 x float>* %puByr, align 16
  %88 = load i32* %tid, align 4
  %idxprom73 = zext i32 %88 to i64
  %89 = load <4 x float> addrspace(3)** %callB.addr, align 8
  %arrayidx74 = getelementptr inbounds <4 x float> addrspace(3)* %89, i64 %idxprom73
  %90 = load <4 x float> addrspace(3)* %arrayidx74, align 16
  %91 = load <4 x float>* %pdByr, align 16
  %92 = load i32* %tid, align 4
  %add76 = add i32 %92, 1
  %idxprom77 = zext i32 %add76 to i64
  %93 = load <4 x float> addrspace(3)** %callB.addr, align 8
  %arrayidx78 = getelementptr inbounds <4 x float> addrspace(3)* %93, i64 %idxprom77
  %94 = load <4 x float> addrspace(3)* %arrayidx78, align 16
  %mul79 = fmul <4 x float> %91, %94
  %95 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %87, <4 x float> %90, <4 x float> %mul79)
  %96 = load i32* %tid, align 4
  %idxprom80 = zext i32 %96 to i64
  %97 = load <4 x float> addrspace(3)** %callA.addr, align 8
  %arrayidx81 = getelementptr inbounds <4 x float> addrspace(3)* %97, i64 %idxprom80
  store <4 x float> %95, <4 x float> addrspace(3)* %arrayidx81, align 16
  br label %if.end82

if.end82:                                         ; preds = %if.then72, %if.end
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end82
  %98 = load i32* %j, align 4
  %sub83 = sub nsw i32 %98, 2
  store i32 %sub83, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %99 = load i32* %tid, align 4
  %cmp84 = icmp eq i32 %99, 0
  br i1 %cmp84, label %if.then86, label %if.end90

if.then86:                                        ; preds = %for.end
  %100 = load <4 x float> addrspace(3)** %callA.addr, align 8
  %arrayidx87 = getelementptr inbounds <4 x float> addrspace(3)* %100, i64 0
  %101 = load <4 x float> addrspace(3)* %arrayidx87, align 16
  %102 = load i32* %bid, align 4
  %idxprom88 = zext i32 %102 to i64
  %103 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx89 = getelementptr inbounds <4 x float> addrspace(1)* %103, i64 %idxprom88
  store <4 x float> %101, <4 x float> addrspace(1)* %arrayidx89, align 16
  br label %if.end90

if.end90:                                         ; preds = %if.then86, %for.end
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z4sqrtDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

declare cc75 void @_Z7barrierj(i32)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*, <4 x float> addrspace(3)*)* @__OpenCL_binomial_options_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 0, i32 1, i32 1, i32 3, i32 3}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"int", metadata !"float4*", metadata !"float4*", metadata !"float4*", metadata !"float4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"const", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"int", metadata !"float4*", metadata !"float4*", metadata !"float4*", metadata !"float4*"}
!6 = metadata !{i32 1, i32 2}
!7 = metadata !{float 2.500000e+00}

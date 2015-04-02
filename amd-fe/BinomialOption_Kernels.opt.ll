; ModuleID = 'BinomialOption_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_binomial_options_kernel(i32 %numSteps, <4 x float> addrspace(1)* %randArray, <4 x float> addrspace(1)* %output, <4 x float> addrspace(3)* %callA, <4 x float> addrspace(3)* %callB) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %idxprom = zext i32 %conv2 to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i64 %idxprom
  %0 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %sub = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %0
  %mul3 = fmul <4 x float> %0, <float 3.000000e+01, float 3.000000e+01, float 3.000000e+01, float 3.000000e+01>
  %1 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %sub, <4 x float> <float 5.000000e+00, float 5.000000e+00, float 5.000000e+00, float 5.000000e+00>, <4 x float> %mul3)
  %sub4 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %0
  %mul5 = fmul <4 x float> %0, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %2 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %sub4, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %mul5)
  %sub6 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %0
  %mul7 = fmul <4 x float> %0, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %3 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %sub6, <4 x float> <float 2.500000e-01, float 2.500000e-01, float 2.500000e-01, float 2.500000e-01>, <4 x float> %mul7)
  %conv8 = sitofp i32 %numSteps to float
  %div = fdiv float 1.000000e+00, %conv8, !fpmath !7
  %4 = insertelement <4 x float> undef, float %div, i32 0
  %splat = shufflevector <4 x float> %4, <4 x float> %4, <4 x i32> zeroinitializer
  %mul = fmul <4 x float> %3, %splat
  %call9 = call cc75 <4 x float> @_Z4sqrtDv4_f(<4 x float> %mul) #1
  %mul10 = fmul <4 x float> <float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000>, %call9
  %mul11 = fmul <4 x float> <float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000>, %mul
  %call12 = call cc75 <4 x float> @_Z3expDv4_f(<4 x float> %mul11) #1
  %div13 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %call12, !fpmath !7
  %call14 = call cc75 <4 x float> @_Z3expDv4_f(<4 x float> %mul10) #1
  %div15 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %call14, !fpmath !7
  %sub16 = fsub <4 x float> %call12, %div15
  %sub17 = fsub <4 x float> %call14, %div15
  %div18 = fdiv <4 x float> %sub16, %sub17, !fpmath !7
  %sub19 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %div18
  %mul20 = fmul <4 x float> %div18, %div13
  %mul21 = fmul <4 x float> %sub19, %div13
  %conv22 = uitofp i32 %conv to float
  %conv24 = sitofp i32 %numSteps to float
  %neg = fsub float -0.000000e+00, %conv24
  %5 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %conv22, float %neg)
  %6 = insertelement <4 x float> undef, float %5, i32 0
  %splat25 = shufflevector <4 x float> %6, <4 x float> %6, <4 x i32> zeroinitializer
  %mul26 = fmul <4 x float> %mul10, %splat25
  %call27 = call cc75 <4 x float> @_Z3expDv4_f(<4 x float> %mul26) #1
  %neg29 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %2
  %7 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %1, <4 x float> %call27, <4 x float> %neg29)
  %8 = extractelement <4 x float> %7, i32 0
  %cmp = fcmp ogt float %8, 0.000000e+00
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %9 = extractelement <4 x float> %7, i32 0
  br label %cond.end

cond.false:                                       ; preds = %entry
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %9, %cond.true ], [ 0.000000e+00, %cond.false ]
  %idxprom31 = zext i32 %conv to i64
  %arrayidx32 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i64 %idxprom31
  %10 = load <4 x float> addrspace(3)* %arrayidx32, align 16
  %11 = insertelement <4 x float> %10, float %cond, i32 0
  store <4 x float> %11, <4 x float> addrspace(3)* %arrayidx32, align 16
  %12 = extractelement <4 x float> %7, i32 1
  %cmp33 = fcmp ogt float %12, 0.000000e+00
  br i1 %cmp33, label %cond.true35, label %cond.false36

cond.true35:                                      ; preds = %cond.end
  %13 = extractelement <4 x float> %7, i32 1
  br label %cond.end37

cond.false36:                                     ; preds = %cond.end
  br label %cond.end37

cond.end37:                                       ; preds = %cond.false36, %cond.true35
  %cond38 = phi float [ %13, %cond.true35 ], [ 0.000000e+00, %cond.false36 ]
  %idxprom39 = zext i32 %conv to i64
  %arrayidx40 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i64 %idxprom39
  %14 = load <4 x float> addrspace(3)* %arrayidx40, align 16
  %15 = insertelement <4 x float> %14, float %cond38, i32 1
  store <4 x float> %15, <4 x float> addrspace(3)* %arrayidx40, align 16
  %16 = extractelement <4 x float> %7, i32 2
  %cmp41 = fcmp ogt float %16, 0.000000e+00
  br i1 %cmp41, label %cond.true43, label %cond.false44

cond.true43:                                      ; preds = %cond.end37
  %17 = extractelement <4 x float> %7, i32 2
  br label %cond.end45

cond.false44:                                     ; preds = %cond.end37
  br label %cond.end45

cond.end45:                                       ; preds = %cond.false44, %cond.true43
  %cond46 = phi float [ %17, %cond.true43 ], [ 0.000000e+00, %cond.false44 ]
  %idxprom47 = zext i32 %conv to i64
  %arrayidx48 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i64 %idxprom47
  %18 = load <4 x float> addrspace(3)* %arrayidx48, align 16
  %19 = insertelement <4 x float> %18, float %cond46, i32 2
  store <4 x float> %19, <4 x float> addrspace(3)* %arrayidx48, align 16
  %20 = extractelement <4 x float> %7, i32 3
  %cmp49 = fcmp ogt float %20, 0.000000e+00
  br i1 %cmp49, label %cond.true51, label %cond.false52

cond.true51:                                      ; preds = %cond.end45
  %21 = extractelement <4 x float> %7, i32 3
  br label %cond.end53

cond.false52:                                     ; preds = %cond.end45
  br label %cond.end53

cond.end53:                                       ; preds = %cond.false52, %cond.true51
  %cond54 = phi float [ %21, %cond.true51 ], [ 0.000000e+00, %cond.false52 ]
  %idxprom55 = zext i32 %conv to i64
  %arrayidx56 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i64 %idxprom55
  %22 = load <4 x float> addrspace(3)* %arrayidx56, align 16
  %23 = insertelement <4 x float> %22, float %cond54, i32 3
  store <4 x float> %23, <4 x float> addrspace(3)* %arrayidx56, align 16
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %cond.end53
  %j.0 = phi i32 [ %numSteps, %cond.end53 ], [ %sub83, %for.inc ]
  %cmp57 = icmp sgt i32 %j.0, 0
  br i1 %cmp57, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %cmp59 = icmp ult i32 %conv, %j.0
  br i1 %cmp59, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %idxprom61 = zext i32 %conv to i64
  %arrayidx62 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i64 %idxprom61
  %24 = load <4 x float> addrspace(3)* %arrayidx62, align 16
  %add = add i32 %conv, 1
  %idxprom64 = zext i32 %add to i64
  %arrayidx65 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i64 %idxprom64
  %25 = load <4 x float> addrspace(3)* %arrayidx65, align 16
  %mul66 = fmul <4 x float> %mul21, %25
  %26 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %mul20, <4 x float> %24, <4 x float> %mul66)
  %idxprom67 = zext i32 %conv to i64
  %arrayidx68 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i64 %idxprom67
  store <4 x float> %26, <4 x float> addrspace(3)* %arrayidx68, align 16
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  call cc75 void @_Z7barrierj(i32 1)
  %sub69 = sub nsw i32 %j.0, 1
  %cmp70 = icmp ult i32 %conv, %sub69
  br i1 %cmp70, label %if.then72, label %if.end82

if.then72:                                        ; preds = %if.end
  %idxprom73 = zext i32 %conv to i64
  %arrayidx74 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i64 %idxprom73
  %27 = load <4 x float> addrspace(3)* %arrayidx74, align 16
  %add76 = add i32 %conv, 1
  %idxprom77 = zext i32 %add76 to i64
  %arrayidx78 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i64 %idxprom77
  %28 = load <4 x float> addrspace(3)* %arrayidx78, align 16
  %mul79 = fmul <4 x float> %mul21, %28
  %29 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %mul20, <4 x float> %27, <4 x float> %mul79)
  %idxprom80 = zext i32 %conv to i64
  %arrayidx81 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i64 %idxprom80
  store <4 x float> %29, <4 x float> addrspace(3)* %arrayidx81, align 16
  br label %if.end82

if.end82:                                         ; preds = %if.then72, %if.end
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end82
  %sub83 = sub nsw i32 %j.0, 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %cmp84 = icmp eq i32 %conv, 0
  br i1 %cmp84, label %if.then86, label %if.end90

if.then86:                                        ; preds = %for.end
  %arrayidx87 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i64 0
  %30 = load <4 x float> addrspace(3)* %arrayidx87, align 16
  %idxprom88 = zext i32 %conv2 to i64
  %arrayidx89 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %idxprom88
  store <4 x float> %30, <4 x float> addrspace(1)* %arrayidx89, align 16
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

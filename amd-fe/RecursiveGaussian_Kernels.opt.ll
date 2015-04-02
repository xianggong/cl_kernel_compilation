; ModuleID = 'RecursiveGaussian_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_transpose_kernel_kernel(<4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(3)* %block, i32 %width, i32 %height, i32 %blockSize) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %mul = mul i32 %conv2, %width
  %add = add i32 %mul, %conv
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom
  %0 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %mul7 = mul i32 %conv6, %blockSize
  %add8 = add i32 %mul7, %conv4
  %idxprom9 = zext i32 %add8 to i64
  %arrayidx10 = getelementptr inbounds <4 x i8> addrspace(3)* %block, i64 %idxprom9
  store <4 x i8> %0, <4 x i8> addrspace(3)* %arrayidx10, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %mul11 = mul i32 %conv6, %blockSize
  %add12 = add i32 %mul11, %conv4
  %mul13 = mul i32 %conv, %height
  %add14 = add i32 %conv2, %mul13
  %idxprom15 = zext i32 %add12 to i64
  %arrayidx16 = getelementptr inbounds <4 x i8> addrspace(3)* %block, i64 %idxprom15
  %1 = load <4 x i8> addrspace(3)* %arrayidx16, align 4
  %idxprom17 = zext i32 %add14 to i64
  %arrayidx18 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %idxprom17
  store <4 x i8> %1, <4 x i8> addrspace(1)* %arrayidx18, align 4
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
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %cmp = icmp uge i32 %conv, %width
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %for.end103

if.end:                                           ; preds = %entry
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end
  %xp.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %vecinit16, %for.inc ]
  %yp.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %14, %for.inc ]
  %yb.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %yp.0, %for.inc ]
  %y.0 = phi i32 [ 0, %if.end ], [ %inc, %for.inc ]
  %cmp2 = icmp slt i32 %y.0, %height
  br i1 %cmp2, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul nsw i32 %y.0, %width
  %add = add i32 %conv, %mul
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom
  %0 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %1 = extractelement <4 x i8> %0, i32 0
  %conv4 = uitofp i8 %1 to float
  %vecinit = insertelement <4 x float> undef, float %conv4, i32 0
  %idxprom5 = sext i32 %add to i64
  %arrayidx6 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom5
  %2 = load <4 x i8> addrspace(1)* %arrayidx6, align 4
  %3 = extractelement <4 x i8> %2, i32 1
  %conv7 = uitofp i8 %3 to float
  %vecinit8 = insertelement <4 x float> %vecinit, float %conv7, i32 1
  %idxprom9 = sext i32 %add to i64
  %arrayidx10 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom9
  %4 = load <4 x i8> addrspace(1)* %arrayidx10, align 4
  %5 = extractelement <4 x i8> %4, i32 2
  %conv11 = uitofp i8 %5 to float
  %vecinit12 = insertelement <4 x float> %vecinit8, float %conv11, i32 2
  %idxprom13 = sext i32 %add to i64
  %arrayidx14 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom13
  %6 = load <4 x i8> addrspace(1)* %arrayidx14, align 4
  %7 = extractelement <4 x i8> %6, i32 3
  %conv15 = uitofp i8 %7 to float
  %vecinit16 = insertelement <4 x float> %vecinit12, float %conv15, i32 3
  %8 = insertelement <4 x float> undef, float %a0, i32 0
  %splat = shufflevector <4 x float> %8, <4 x float> %8, <4 x i32> zeroinitializer
  %9 = insertelement <4 x float> undef, float %a1, i32 0
  %splat18 = shufflevector <4 x float> %9, <4 x float> %9, <4 x i32> zeroinitializer
  %mul19 = fmul <4 x float> %splat18, %xp.0
  %10 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %splat, <4 x float> %vecinit16, <4 x float> %mul19)
  %11 = insertelement <4 x float> undef, float %b1, i32 0
  %splat20 = shufflevector <4 x float> %11, <4 x float> %11, <4 x i32> zeroinitializer
  %neg = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat20
  %12 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg, <4 x float> %yp.0, <4 x float> %10)
  %13 = insertelement <4 x float> undef, float %b2, i32 0
  %splat22 = shufflevector <4 x float> %13, <4 x float> %13, <4 x i32> zeroinitializer
  %neg24 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat22
  %14 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg24, <4 x float> %yb.0, <4 x float> %12)
  %15 = extractelement <4 x float> %14, i32 0
  %conv26 = fptoui float %15 to i8
  %vecinit27 = insertelement <4 x i8> undef, i8 %conv26, i32 0
  %16 = extractelement <4 x float> %14, i32 1
  %conv28 = fptoui float %16 to i8
  %vecinit29 = insertelement <4 x i8> %vecinit27, i8 %conv28, i32 1
  %17 = extractelement <4 x float> %14, i32 2
  %conv30 = fptoui float %17 to i8
  %vecinit31 = insertelement <4 x i8> %vecinit29, i8 %conv30, i32 2
  %18 = extractelement <4 x float> %14, i32 3
  %conv32 = fptoui float %18 to i8
  %vecinit33 = insertelement <4 x i8> %vecinit31, i8 %conv32, i32 3
  %idxprom34 = sext i32 %add to i64
  %arrayidx35 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %idxprom34
  store <4 x i8> %vecinit33, <4 x i8> addrspace(1)* %arrayidx35, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %y.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 2)
  %sub = sub nsw i32 %height, 1
  br label %for.cond37

for.cond37:                                       ; preds = %for.inc102, %for.end
  %xn.0 = phi <4 x float> [ zeroinitializer, %for.end ], [ %vecinit61, %for.inc102 ]
  %xa.0 = phi <4 x float> [ zeroinitializer, %for.end ], [ %xn.0, %for.inc102 ]
  %yn.0 = phi <4 x float> [ zeroinitializer, %for.end ], [ %33, %for.inc102 ]
  %ya.0 = phi <4 x float> [ zeroinitializer, %for.end ], [ %yn.0, %for.inc102 ]
  %y36.0 = phi i32 [ %sub, %for.end ], [ %dec, %for.inc102 ]
  %cmp38 = icmp sgt i32 %y36.0, -1
  br i1 %cmp38, label %for.body40, label %for.end103

for.body40:                                       ; preds = %for.cond37
  %mul42 = mul nsw i32 %y36.0, %width
  %add43 = add i32 %conv, %mul42
  %idxprom46 = sext i32 %add43 to i64
  %arrayidx47 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom46
  %19 = load <4 x i8> addrspace(1)* %arrayidx47, align 4
  %20 = extractelement <4 x i8> %19, i32 0
  %conv48 = uitofp i8 %20 to float
  %vecinit49 = insertelement <4 x float> undef, float %conv48, i32 0
  %idxprom50 = sext i32 %add43 to i64
  %arrayidx51 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom50
  %21 = load <4 x i8> addrspace(1)* %arrayidx51, align 4
  %22 = extractelement <4 x i8> %21, i32 1
  %conv52 = uitofp i8 %22 to float
  %vecinit53 = insertelement <4 x float> %vecinit49, float %conv52, i32 1
  %idxprom54 = sext i32 %add43 to i64
  %arrayidx55 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom54
  %23 = load <4 x i8> addrspace(1)* %arrayidx55, align 4
  %24 = extractelement <4 x i8> %23, i32 2
  %conv56 = uitofp i8 %24 to float
  %vecinit57 = insertelement <4 x float> %vecinit53, float %conv56, i32 2
  %idxprom58 = sext i32 %add43 to i64
  %arrayidx59 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom58
  %25 = load <4 x i8> addrspace(1)* %arrayidx59, align 4
  %26 = extractelement <4 x i8> %25, i32 3
  %conv60 = uitofp i8 %26 to float
  %vecinit61 = insertelement <4 x float> %vecinit57, float %conv60, i32 3
  %27 = insertelement <4 x float> undef, float %a2, i32 0
  %splat63 = shufflevector <4 x float> %27, <4 x float> %27, <4 x i32> zeroinitializer
  %28 = insertelement <4 x float> undef, float %a3, i32 0
  %splat65 = shufflevector <4 x float> %28, <4 x float> %28, <4 x i32> zeroinitializer
  %mul66 = fmul <4 x float> %splat65, %xa.0
  %29 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %splat63, <4 x float> %xn.0, <4 x float> %mul66)
  %30 = insertelement <4 x float> undef, float %b1, i32 0
  %splat67 = shufflevector <4 x float> %30, <4 x float> %30, <4 x i32> zeroinitializer
  %neg69 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat67
  %31 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg69, <4 x float> %yn.0, <4 x float> %29)
  %32 = insertelement <4 x float> undef, float %b2, i32 0
  %splat70 = shufflevector <4 x float> %32, <4 x float> %32, <4 x i32> zeroinitializer
  %neg72 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat70
  %33 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg72, <4 x float> %ya.0, <4 x float> %31)
  %idxprom74 = sext i32 %add43 to i64
  %arrayidx75 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %idxprom74
  %34 = load <4 x i8> addrspace(1)* %arrayidx75, align 4
  %35 = extractelement <4 x i8> %34, i32 0
  %conv76 = uitofp i8 %35 to float
  %vecinit77 = insertelement <4 x float> undef, float %conv76, i32 0
  %idxprom78 = sext i32 %add43 to i64
  %arrayidx79 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %idxprom78
  %36 = load <4 x i8> addrspace(1)* %arrayidx79, align 4
  %37 = extractelement <4 x i8> %36, i32 1
  %conv80 = uitofp i8 %37 to float
  %vecinit81 = insertelement <4 x float> %vecinit77, float %conv80, i32 1
  %idxprom82 = sext i32 %add43 to i64
  %arrayidx83 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %idxprom82
  %38 = load <4 x i8> addrspace(1)* %arrayidx83, align 4
  %39 = extractelement <4 x i8> %38, i32 2
  %conv84 = uitofp i8 %39 to float
  %vecinit85 = insertelement <4 x float> %vecinit81, float %conv84, i32 2
  %idxprom86 = sext i32 %add43 to i64
  %arrayidx87 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %idxprom86
  %40 = load <4 x i8> addrspace(1)* %arrayidx87, align 4
  %41 = extractelement <4 x i8> %40, i32 3
  %conv88 = uitofp i8 %41 to float
  %vecinit89 = insertelement <4 x float> %vecinit85, float %conv88, i32 3
  %add90 = fadd <4 x float> %vecinit89, %33
  %42 = extractelement <4 x float> %add90, i32 0
  %conv92 = fptoui float %42 to i8
  %vecinit93 = insertelement <4 x i8> undef, i8 %conv92, i32 0
  %43 = extractelement <4 x float> %add90, i32 1
  %conv94 = fptoui float %43 to i8
  %vecinit95 = insertelement <4 x i8> %vecinit93, i8 %conv94, i32 1
  %44 = extractelement <4 x float> %add90, i32 2
  %conv96 = fptoui float %44 to i8
  %vecinit97 = insertelement <4 x i8> %vecinit95, i8 %conv96, i32 2
  %45 = extractelement <4 x float> %add90, i32 3
  %conv98 = fptoui float %45 to i8
  %vecinit99 = insertelement <4 x i8> %vecinit97, i8 %conv98, i32 3
  %idxprom100 = sext i32 %add43 to i64
  %arrayidx101 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %idxprom100
  store <4 x i8> %vecinit99, <4 x i8> addrspace(1)* %arrayidx101, align 4
  br label %for.inc102

for.inc102:                                       ; preds = %for.body40
  %dec = add nsw i32 %y36.0, -1
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

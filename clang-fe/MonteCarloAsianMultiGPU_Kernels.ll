; ModuleID = '../kernel-src/MonteCarloAsianMultiGPU_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%struct._MonteCalroAttrib = type { <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float> }

; Function Attrs: nounwind
define void @lshift128(<4 x i32> %input, i32 %shift, <4 x i32>* nocapture %output) #0 {
entry:
  %0 = extractelement <4 x i32> %input, i32 0
  %shl.mask = and i32 %shift, 31
  %shl = shl i32 %0, %shl.mask
  %1 = insertelement <4 x i32> undef, i32 %shl, i32 0
  %2 = extractelement <4 x i32> %input, i32 1
  %shl2 = shl i32 %2, %shl.mask
  %3 = sub i32 0, %shift
  %shr.mask = and i32 %3, 31
  %shr = lshr i32 %0, %shr.mask
  %or = or i32 %shl2, %shr
  %4 = insertelement <4 x i32> %1, i32 %or, i32 1
  %5 = extractelement <4 x i32> %input, i32 2
  %shl4 = shl i32 %5, %shl.mask
  %shr6 = lshr i32 %2, %shr.mask
  %or7 = or i32 %shl4, %shr6
  %6 = insertelement <4 x i32> %4, i32 %or7, i32 2
  %7 = extractelement <4 x i32> %input, i32 3
  %shl9 = shl i32 %7, %shl.mask
  %shr11 = lshr i32 %5, %shr.mask
  %or12 = or i32 %shl9, %shr11
  %8 = insertelement <4 x i32> %6, i32 %or12, i32 3
  store <4 x i32> %8, <4 x i32>* %output, align 16, !tbaa !2
  ret void
}

; Function Attrs: nounwind
define void @rshift128(<4 x i32> %input, i32 %shift, <4 x i32>* nocapture %output) #0 {
entry:
  %0 = extractelement <4 x i32> %input, i32 3
  %shr.mask = and i32 %shift, 31
  %shr = lshr i32 %0, %shr.mask
  %1 = insertelement <4 x i32> undef, i32 %shr, i32 3
  %2 = extractelement <4 x i32> %input, i32 2
  %shr2 = lshr i32 %2, %shr.mask
  %3 = sub i32 0, %shift
  %shl.mask = and i32 %3, 31
  %shl = shl i32 %0, %shl.mask
  %or = or i32 %shr2, %shl
  %4 = insertelement <4 x i32> %1, i32 %or, i32 2
  %5 = extractelement <4 x i32> %input, i32 1
  %shr4 = lshr i32 %5, %shr.mask
  %shl6 = shl i32 %2, %shl.mask
  %or7 = or i32 %shr4, %shl6
  %6 = insertelement <4 x i32> %4, i32 %or7, i32 1
  %7 = extractelement <4 x i32> %input, i32 0
  %shr9 = lshr i32 %7, %shr.mask
  %shl11 = shl i32 %5, %shl.mask
  %or12 = or i32 %shr9, %shl11
  %8 = insertelement <4 x i32> %6, i32 %or12, i32 0
  store <4 x i32> %8, <4 x i32>* %output, align 16, !tbaa !2
  ret void
}

; Function Attrs: nounwind
define void @generateRand(<4 x i32> %seed, <4 x float>* nocapture %gaussianRand1, <4 x float>* nocapture %gaussianRand2, <4 x i32>* nocapture %nextRand) #0 {
entry:
  %temp = alloca [8 x <4 x i32>], align 16
  %0 = bitcast [8 x <4 x i32>]* %temp to i8*
  call void @llvm.lifetime.start(i64 128, i8* %0) #1
  %shr = lshr <4 x i32> %seed, <i32 30, i32 30, i32 30, i32 30>
  %xor = xor <4 x i32> %shr, %seed
  %mul = mul <4 x i32> %xor, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %add = add <4 x i32> %mul, <i32 1, i32 1, i32 1, i32 1>
  %shr4 = lshr <4 x i32> %add, <i32 30, i32 30, i32 30, i32 30>
  %xor5 = xor <4 x i32> %add, %shr4
  %mul6 = mul <4 x i32> %xor5, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %add7 = add <4 x i32> %mul6, <i32 2, i32 2, i32 2, i32 2>
  %shr9 = lshr <4 x i32> %add7, <i32 30, i32 30, i32 30, i32 30>
  %xor10 = xor <4 x i32> %add7, %shr9
  %mul11 = mul <4 x i32> %xor10, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %add12 = add <4 x i32> %mul11, <i32 3, i32 3, i32 3, i32 3>
  %shr14 = lshr <4 x i32> %add12, <i32 30, i32 30, i32 30, i32 30>
  %xor15 = xor <4 x i32> %add12, %shr14
  %mul16 = mul <4 x i32> %xor15, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %add17 = add <4 x i32> %mul16, <i32 4, i32 4, i32 4, i32 4>
  %arrayidx = getelementptr inbounds [8 x <4 x i32>]* %temp, i64 0, i64 0
  %arrayidx20 = getelementptr inbounds [8 x <4 x i32>]* %temp, i64 0, i64 1
  %arrayidx22 = getelementptr inbounds [8 x <4 x i32>]* %temp, i64 0, i64 2
  br label %for.body

for.body:                                         ; preds = %sw.epilog, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %sw.epilog ]
  %r1.0137 = phi <4 x i32> [ zeroinitializer, %entry ], [ %r1.1, %sw.epilog ]
  %r2.0136 = phi <4 x i32> [ zeroinitializer, %entry ], [ %r2.1, %sw.epilog ]
  %a.0135 = phi <4 x i32> [ zeroinitializer, %entry ], [ %a.1, %sw.epilog ]
  %b.0134 = phi <4 x i32> [ zeroinitializer, %entry ], [ %b.1, %sw.epilog ]
  %1 = trunc i64 %indvars.iv to i32
  switch i32 %1, label %sw.epilog [
    i32 0, label %sw.bb
    i32 1, label %sw.bb18
    i32 2, label %sw.bb19
    i32 3, label %sw.bb21
  ]

sw.bb:                                            ; preds = %for.body
  br label %sw.epilog

sw.bb18:                                          ; preds = %for.body
  %2 = load <4 x i32>* %arrayidx, align 16, !tbaa !2
  br label %sw.epilog

sw.bb19:                                          ; preds = %for.body
  %3 = load <4 x i32>* %arrayidx20, align 16, !tbaa !2
  br label %sw.epilog

sw.bb21:                                          ; preds = %for.body
  %4 = load <4 x i32>* %arrayidx22, align 16, !tbaa !2
  br label %sw.epilog

sw.epilog:                                        ; preds = %for.body, %sw.bb21, %sw.bb19, %sw.bb18, %sw.bb
  %b.1 = phi <4 x i32> [ %b.0134, %for.body ], [ %seed, %sw.bb21 ], [ %add17, %sw.bb19 ], [ %add12, %sw.bb18 ], [ %add7, %sw.bb ]
  %a.1 = phi <4 x i32> [ %a.0135, %for.body ], [ %add12, %sw.bb21 ], [ %add7, %sw.bb19 ], [ %add, %sw.bb18 ], [ %seed, %sw.bb ]
  %r2.1 = phi <4 x i32> [ %r2.0136, %for.body ], [ %4, %sw.bb21 ], [ %3, %sw.bb19 ], [ %2, %sw.bb18 ], [ %add17, %sw.bb ]
  %r1.1 = phi <4 x i32> [ %r1.0137, %for.body ], [ %r2.0136, %sw.bb21 ], [ %r2.0136, %sw.bb19 ], [ %r2.0136, %sw.bb18 ], [ %add12, %sw.bb ]
  %5 = extractelement <4 x i32> %a.1, i32 0
  %shl.i = shl i32 %5, 24
  %6 = extractelement <4 x i32> %a.1, i32 1
  %shl2.i = shl i32 %6, 24
  %shr.i = lshr i32 %5, 8
  %or.i = or i32 %shl2.i, %shr.i
  %7 = extractelement <4 x i32> %a.1, i32 2
  %shl4.i = shl i32 %7, 24
  %shr6.i = lshr i32 %6, 8
  %or7.i = or i32 %shl4.i, %shr6.i
  %8 = extractelement <4 x i32> %a.1, i32 3
  %shl9.i = shl i32 %8, 24
  %shr11.i = lshr i32 %7, 8
  %or12.i = or i32 %shl9.i, %shr11.i
  %9 = extractelement <4 x i32> %r1.1, i32 3
  %shr.i123 = lshr i32 %9, 24
  %10 = extractelement <4 x i32> %r1.1, i32 2
  %shr2.i = lshr i32 %10, 24
  %shl.i124 = shl i32 %9, 8
  %or.i125 = or i32 %shr2.i, %shl.i124
  %11 = extractelement <4 x i32> %r1.1, i32 1
  %shr4.i = lshr i32 %11, 24
  %shl6.i = shl i32 %10, 8
  %or7.i126 = or i32 %shr4.i, %shl6.i
  %12 = extractelement <4 x i32> %r1.1, i32 0
  %shr9.i = lshr i32 %12, 24
  %shl11.i = shl i32 %11, 8
  %or12.i127 = or i32 %shr9.i, %shl11.i
  %xor23 = xor i32 %shl.i, %5
  %13 = extractelement <4 x i32> %b.1, i32 0
  %shr25 = lshr i32 %13, 13
  %and = and i32 %shr25, 473087
  %xor26 = xor i32 %xor23, %and
  %14 = extractelement <4 x i32> %r2.1, i32 0
  %shl = shl i32 %14, 15
  %xor27 = xor i32 %xor26, %shl
  %xor28 = xor i32 %xor27, %or12.i127
  %arrayidx29 = getelementptr inbounds [8 x <4 x i32>]* %temp, i64 0, i64 %indvars.iv
  %15 = insertelement <4 x i32> undef, i32 %xor28, i32 0
  %16 = extractelement <4 x i32> %b.1, i32 1
  %shr32 = lshr i32 %16, 13
  %and33 = and i32 %shr32, 475005
  %17 = extractelement <4 x i32> %r2.1, i32 1
  %shl37 = shl i32 %17, 15
  %xor30 = xor i32 %and33, %6
  %xor34 = xor i32 %xor30, %or.i
  %xor35 = xor i32 %xor34, %shl37
  %xor38 = xor i32 %xor35, %or7.i126
  %18 = insertelement <4 x i32> %15, i32 %xor38, i32 1
  %19 = extractelement <4 x i32> %b.1, i32 2
  %shr42 = lshr i32 %19, 13
  %and43 = and i32 %shr42, 490365
  %20 = extractelement <4 x i32> %r2.1, i32 2
  %shl47 = shl i32 %20, 15
  %xor40 = xor i32 %and43, %7
  %xor44 = xor i32 %xor40, %or7.i
  %xor45 = xor i32 %xor44, %shl47
  %xor48 = xor i32 %xor45, %or.i125
  %21 = insertelement <4 x i32> %18, i32 %xor48, i32 2
  %22 = extractelement <4 x i32> %b.1, i32 3
  %shr52 = lshr i32 %22, 13
  %and53 = and i32 %shr52, 523055
  %23 = extractelement <4 x i32> %r2.1, i32 3
  %shl57 = shl i32 %23, 15
  %xor50 = xor i32 %and53, %8
  %xor54 = xor i32 %xor50, %or12.i
  %xor55 = xor i32 %xor54, %shl57
  %xor58 = xor i32 %xor55, %shr.i123
  %24 = insertelement <4 x i32> %21, i32 %xor58, i32 3
  store <4 x i32> %24, <4 x i32>* %arrayidx29, align 16
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 4
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %sw.epilog
  %25 = load <4 x i32>* %arrayidx, align 16, !tbaa !2
  %call = tail call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %25) #1
  %div = fdiv <4 x float> %call, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !5
  %26 = load <4 x i32>* %arrayidx20, align 16, !tbaa !2
  %call63 = tail call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %26) #1
  %div65 = fdiv <4 x float> %call63, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !5
  %call66 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %div)
  %mul67 = fmul <4 x float> %call66, <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>
  %mul68 = fmul <4 x float> %mul67, <float -2.000000e+00, float -2.000000e+00, float -2.000000e+00, float -2.000000e+00>
  %call69 = tail call <4 x float> @llvm.sqrt.v4f32(<4 x float> %mul68)
  %mul70 = fmul <4 x float> %div65, <float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000>
  %call71 = tail call <4 x float> @_Z3cosDv4_f(<4 x float> %mul70) #1
  %mul72 = fmul <4 x float> %call69, %call71
  store <4 x float> %mul72, <4 x float>* %gaussianRand1, align 16, !tbaa !2
  %call73 = tail call <4 x float> @_Z3sinDv4_f(<4 x float> %mul70) #1
  %mul74 = fmul <4 x float> %call69, %call73
  store <4 x float> %mul74, <4 x float>* %gaussianRand2, align 16, !tbaa !2
  %27 = load <4 x i32>* %arrayidx22, align 16, !tbaa !2
  store <4 x i32> %27, <4 x i32>* %nextRand, align 16, !tbaa !2
  call void @llvm.lifetime.end(i64 128, i8* %0) #1
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
entry:
  %sub = fsub <4 x float> %meanPrice1, %strikePrice
  %sub1 = fsub <4 x float> %meanPrice2, %strikePrice
  %0 = extractelement <4 x float> %sub, i32 0
  %cmp = fcmp ogt float %0, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %sub, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %temp3.0 = phi <4 x float> [ %1, %if.then ], [ zeroinitializer, %entry ]
  %temp1.0 = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %if.then ], [ zeroinitializer, %entry ]
  %2 = extractelement <4 x float> %sub, i32 1
  %cmp2 = fcmp ogt float %2, 0.000000e+00
  br i1 %cmp2, label %if.then3, label %if.end4

if.then3:                                         ; preds = %if.end
  %3 = insertelement <4 x float> %temp1.0, float 1.000000e+00, i32 1
  %4 = shufflevector <4 x float> %temp3.0, <4 x float> %sub, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %if.end4

if.end4:                                          ; preds = %if.then3, %if.end
  %temp3.1 = phi <4 x float> [ %4, %if.then3 ], [ %temp3.0, %if.end ]
  %temp1.1 = phi <4 x float> [ %3, %if.then3 ], [ %temp1.0, %if.end ]
  %5 = extractelement <4 x float> %sub, i32 2
  %cmp5 = fcmp ogt float %5, 0.000000e+00
  br i1 %cmp5, label %if.then6, label %if.end7

if.then6:                                         ; preds = %if.end4
  %6 = insertelement <4 x float> %temp1.1, float 1.000000e+00, i32 2
  %7 = shufflevector <4 x float> %temp3.1, <4 x float> %sub, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %if.end7

if.end7:                                          ; preds = %if.then6, %if.end4
  %temp3.2 = phi <4 x float> [ %7, %if.then6 ], [ %temp3.1, %if.end4 ]
  %temp1.2 = phi <4 x float> [ %6, %if.then6 ], [ %temp1.1, %if.end4 ]
  %8 = extractelement <4 x float> %sub, i32 3
  %cmp8 = fcmp ogt float %8, 0.000000e+00
  br i1 %cmp8, label %if.then9, label %if.end10

if.then9:                                         ; preds = %if.end7
  %9 = insertelement <4 x float> %temp1.2, float 1.000000e+00, i32 3
  %10 = shufflevector <4 x float> %temp3.2, <4 x float> %sub, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %if.end10

if.end10:                                         ; preds = %if.then9, %if.end7
  %temp3.3 = phi <4 x float> [ %10, %if.then9 ], [ %temp3.2, %if.end7 ]
  %temp1.3 = phi <4 x float> [ %9, %if.then9 ], [ %temp1.2, %if.end7 ]
  %11 = extractelement <4 x float> %sub1, i32 0
  %cmp11 = fcmp ogt float %11, 0.000000e+00
  br i1 %cmp11, label %if.then12, label %if.end13

if.then12:                                        ; preds = %if.end10
  %12 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %sub1, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %if.end13

if.end13:                                         ; preds = %if.then12, %if.end10
  %temp4.0 = phi <4 x float> [ %12, %if.then12 ], [ zeroinitializer, %if.end10 ]
  %temp2.0 = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %if.then12 ], [ zeroinitializer, %if.end10 ]
  %13 = extractelement <4 x float> %sub1, i32 1
  %cmp14 = fcmp ogt float %13, 0.000000e+00
  br i1 %cmp14, label %if.then15, label %if.end16

if.then15:                                        ; preds = %if.end13
  %14 = insertelement <4 x float> %temp2.0, float 1.000000e+00, i32 1
  %15 = shufflevector <4 x float> %temp4.0, <4 x float> %sub1, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %if.end16

if.end16:                                         ; preds = %if.then15, %if.end13
  %temp4.1 = phi <4 x float> [ %15, %if.then15 ], [ %temp4.0, %if.end13 ]
  %temp2.1 = phi <4 x float> [ %14, %if.then15 ], [ %temp2.0, %if.end13 ]
  %16 = extractelement <4 x float> %sub1, i32 2
  %cmp17 = fcmp ogt float %16, 0.000000e+00
  br i1 %cmp17, label %if.then18, label %if.end19

if.then18:                                        ; preds = %if.end16
  %17 = insertelement <4 x float> %temp2.1, float 1.000000e+00, i32 2
  %18 = shufflevector <4 x float> %temp4.1, <4 x float> %sub1, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %if.end19

if.end19:                                         ; preds = %if.then18, %if.end16
  %temp4.2 = phi <4 x float> [ %18, %if.then18 ], [ %temp4.1, %if.end16 ]
  %temp2.2 = phi <4 x float> [ %17, %if.then18 ], [ %temp2.1, %if.end16 ]
  %19 = extractelement <4 x float> %sub1, i32 3
  %cmp20 = fcmp ogt float %19, 0.000000e+00
  br i1 %cmp20, label %if.then21, label %if.end22

if.then21:                                        ; preds = %if.end19
  %20 = insertelement <4 x float> %temp2.2, float 1.000000e+00, i32 3
  %21 = shufflevector <4 x float> %temp4.2, <4 x float> %sub1, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %if.end22

if.end22:                                         ; preds = %if.then21, %if.end19
  %temp4.3 = phi <4 x float> [ %21, %if.then21 ], [ %temp4.2, %if.end19 ]
  %temp2.3 = phi <4 x float> [ %20, %if.then21 ], [ %temp2.2, %if.end19 ]
  %mul = fmul <4 x float> %temp1.3, %meanDeriv1
  store <4 x float> %mul, <4 x float>* %pathDeriv1, align 16, !tbaa !2
  %mul23 = fmul <4 x float> %temp2.3, %meanDeriv2
  store <4 x float> %mul23, <4 x float>* %pathDeriv2, align 16, !tbaa !2
  store <4 x float> %temp3.3, <4 x float>* %priceVec1, align 16, !tbaa !2
  store <4 x float> %temp4.3, <4 x float>* %priceVec2, align 16, !tbaa !2
  ret void
}

; Function Attrs: nounwind
define void @calPriceVega(%struct._MonteCalroAttrib* byval nocapture readonly %attrib, i32 %noOfSum, i32 %width, <4 x i32> addrspace(1)* nocapture readonly %randArray, <4 x float> addrspace(1)* nocapture %priceSamples, <4 x float> addrspace(1)* nocapture %pathDeriv) #0 {
entry:
  %finalRandf1 = alloca <4 x float>, align 16
  %finalRandf2 = alloca <4 x float>, align 16
  %nextRand = alloca <4 x i32>, align 16
  %strikePrice1 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 0
  %0 = load <4 x float>* %strikePrice1, align 16, !tbaa !6
  %c12 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 1
  %1 = load <4 x float>* %c12, align 16, !tbaa !8
  %c23 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 2
  %2 = load <4 x float>* %c23, align 16, !tbaa !9
  %c34 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 3
  %3 = load <4 x float>* %c34, align 16, !tbaa !10
  %initPrice5 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 4
  %4 = load <4 x float>* %initPrice5, align 16, !tbaa !11
  %sigma6 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 5
  %5 = load <4 x float>* %sigma6, align 16, !tbaa !12
  %timeStep7 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i64 0, i32 6
  %6 = load <4 x float>* %timeStep7, align 16, !tbaa !13
  %call = tail call i32 @get_global_id(i32 0) #1
  %call8 = tail call i32 @get_global_id(i32 1) #1
  store <4 x float> zeroinitializer, <4 x float>* %finalRandf1, align 16, !tbaa !2
  store <4 x float> zeroinitializer, <4 x float>* %finalRandf2, align 16, !tbaa !2
  %mul = mul i32 %call8, %width
  %add = add i32 %mul, %call
  %7 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %randArray, i64 %7
  %8 = load <4 x i32> addrspace(1)* %arrayidx, align 16, !tbaa !2
  store <4 x i32> %8, <4 x i32>* %nextRand, align 16, !tbaa !2
  %cmp111 = icmp sgt i32 %noOfSum, 1
  br i1 %cmp111, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %mul17 = fmul <4 x float> %3, %6
  br label %for.body

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.lr.ph
  %9 = phi <4 x i32> [ %8, %for.body.lr.ph ], [ %.pre, %for.body.for.body_crit_edge ]
  %i.0118 = phi i32 [ 1, %for.body.lr.ph ], [ %inc, %for.body.for.body_crit_edge ]
  %sumDeriv2.0117 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %17, %for.body.for.body_crit_edge ]
  %sumDeriv1.0116 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %15, %for.body.for.body_crit_edge ]
  %sumPrice2.0115 = phi <4 x float> [ %4, %for.body.lr.ph ], [ %add16, %for.body.for.body_crit_edge ]
  %sumPrice1.0114 = phi <4 x float> [ %4, %for.body.lr.ph ], [ %add15, %for.body.for.body_crit_edge ]
  %trajPrice2.0113 = phi <4 x float> [ %4, %for.body.lr.ph ], [ %mul14, %for.body.for.body_crit_edge ]
  %trajPrice1.0112 = phi <4 x float> [ %4, %for.body.lr.ph ], [ %mul11, %for.body.for.body_crit_edge ]
  call void @generateRand(<4 x i32> %9, <4 x float>* %finalRandf1, <4 x float>* %finalRandf2, <4 x i32>* %nextRand)
  %10 = load <4 x float>* %finalRandf1, align 16, !tbaa !2
  %11 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %2, <4 x float> %10, <4 x float> %1)
  %call10 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %11) #1
  %mul11 = fmul <4 x float> %trajPrice1.0112, %call10
  %12 = load <4 x float>* %finalRandf2, align 16, !tbaa !2
  %13 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %2, <4 x float> %12, <4 x float> %1)
  %call13 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %13) #1
  %mul14 = fmul <4 x float> %trajPrice2.0113, %call13
  %add15 = fadd <4 x float> %sumPrice1.0114, %mul11
  %add16 = fadd <4 x float> %sumPrice2.0115, %mul14
  %conv = sitofp i32 %i.0118 to float
  %splat.splatinsert = insertelement <4 x float> undef, float %conv, i32 0
  %splat.splat = shufflevector <4 x float> %splat.splatinsert, <4 x float> undef, <4 x i32> zeroinitializer
  %mul18 = fmul <4 x float> %mul17, %splat.splat
  %div = fdiv <4 x float> %mul11, %4, !fpmath !5
  %call19 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %div)
  %neg = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul18
  %14 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %call19, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %neg)
  %div21 = fdiv <4 x float> %14, %5, !fpmath !5
  %15 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %mul11, <4 x float> %div21, <4 x float> %sumDeriv1.0116)
  %div23 = fdiv <4 x float> %mul14, %4, !fpmath !5
  %call24 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %div23)
  %16 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %call24, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %neg)
  %div27 = fdiv <4 x float> %16, %5, !fpmath !5
  %17 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %mul14, <4 x float> %div27, <4 x float> %sumDeriv2.0117)
  %inc = add nsw i32 %i.0118, 1
  %exitcond = icmp eq i32 %inc, %noOfSum
  br i1 %exitcond, label %for.end, label %for.body.for.body_crit_edge

for.body.for.body_crit_edge:                      ; preds = %for.body
  %.pre = load <4 x i32>* %nextRand, align 16, !tbaa !2
  br label %for.body

for.end:                                          ; preds = %for.body, %entry
  %sumDeriv2.0.lcssa = phi <4 x float> [ zeroinitializer, %entry ], [ %17, %for.body ]
  %sumDeriv1.0.lcssa = phi <4 x float> [ zeroinitializer, %entry ], [ %15, %for.body ]
  %sumPrice2.0.lcssa = phi <4 x float> [ %4, %entry ], [ %add16, %for.body ]
  %sumPrice1.0.lcssa = phi <4 x float> [ %4, %entry ], [ %add15, %for.body ]
  %conv29 = sitofp i32 %noOfSum to float
  %splat.splatinsert30 = insertelement <4 x float> undef, float %conv29, i32 0
  %splat.splat31 = shufflevector <4 x float> %splat.splatinsert30, <4 x float> undef, <4 x i32> zeroinitializer
  %div32 = fdiv <4 x float> %sumPrice1.0.lcssa, %splat.splat31, !fpmath !5
  %div36 = fdiv <4 x float> %sumPrice2.0.lcssa, %splat.splat31, !fpmath !5
  %div40 = fdiv <4 x float> %sumDeriv1.0.lcssa, %splat.splat31, !fpmath !5
  %div44 = fdiv <4 x float> %sumDeriv2.0.lcssa, %splat.splat31, !fpmath !5
  %sub.i = fsub <4 x float> %div32, %0
  %sub1.i = fsub <4 x float> %div36, %0
  %18 = extractelement <4 x float> %sub.i, i32 0
  %cmp.i = fcmp ogt float %18, 0.000000e+00
  br i1 %cmp.i, label %if.then.i, label %if.end.i

if.then.i:                                        ; preds = %for.end
  %19 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %sub.i, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %if.end.i

if.end.i:                                         ; preds = %if.then.i, %for.end
  %temp3.0.i = phi <4 x float> [ %19, %if.then.i ], [ zeroinitializer, %for.end ]
  %temp1.0.i = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %if.then.i ], [ zeroinitializer, %for.end ]
  %20 = extractelement <4 x float> %sub.i, i32 1
  %cmp2.i = fcmp ogt float %20, 0.000000e+00
  br i1 %cmp2.i, label %if.then3.i, label %if.end4.i

if.then3.i:                                       ; preds = %if.end.i
  %21 = insertelement <4 x float> %temp1.0.i, float 1.000000e+00, i32 1
  %22 = shufflevector <4 x float> %temp3.0.i, <4 x float> %sub.i, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %if.end4.i

if.end4.i:                                        ; preds = %if.then3.i, %if.end.i
  %temp3.1.i = phi <4 x float> [ %22, %if.then3.i ], [ %temp3.0.i, %if.end.i ]
  %temp1.1.i = phi <4 x float> [ %21, %if.then3.i ], [ %temp1.0.i, %if.end.i ]
  %23 = extractelement <4 x float> %sub.i, i32 2
  %cmp5.i = fcmp ogt float %23, 0.000000e+00
  br i1 %cmp5.i, label %if.then6.i, label %if.end7.i

if.then6.i:                                       ; preds = %if.end4.i
  %24 = insertelement <4 x float> %temp1.1.i, float 1.000000e+00, i32 2
  %25 = shufflevector <4 x float> %temp3.1.i, <4 x float> %sub.i, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %if.end7.i

if.end7.i:                                        ; preds = %if.then6.i, %if.end4.i
  %temp3.2.i = phi <4 x float> [ %25, %if.then6.i ], [ %temp3.1.i, %if.end4.i ]
  %temp1.2.i = phi <4 x float> [ %24, %if.then6.i ], [ %temp1.1.i, %if.end4.i ]
  %26 = extractelement <4 x float> %sub.i, i32 3
  %cmp8.i = fcmp ogt float %26, 0.000000e+00
  br i1 %cmp8.i, label %if.then9.i, label %if.end10.i

if.then9.i:                                       ; preds = %if.end7.i
  %27 = insertelement <4 x float> %temp1.2.i, float 1.000000e+00, i32 3
  %28 = shufflevector <4 x float> %temp3.2.i, <4 x float> %sub.i, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %if.end10.i

if.end10.i:                                       ; preds = %if.then9.i, %if.end7.i
  %temp3.3.i = phi <4 x float> [ %28, %if.then9.i ], [ %temp3.2.i, %if.end7.i ]
  %temp1.3.i = phi <4 x float> [ %27, %if.then9.i ], [ %temp1.2.i, %if.end7.i ]
  %29 = extractelement <4 x float> %sub1.i, i32 0
  %cmp11.i = fcmp ogt float %29, 0.000000e+00
  br i1 %cmp11.i, label %if.then12.i, label %if.end13.i

if.then12.i:                                      ; preds = %if.end10.i
  %30 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %sub1.i, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %if.end13.i

if.end13.i:                                       ; preds = %if.then12.i, %if.end10.i
  %temp4.0.i = phi <4 x float> [ %30, %if.then12.i ], [ zeroinitializer, %if.end10.i ]
  %temp2.0.i = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %if.then12.i ], [ zeroinitializer, %if.end10.i ]
  %31 = extractelement <4 x float> %sub1.i, i32 1
  %cmp14.i = fcmp ogt float %31, 0.000000e+00
  br i1 %cmp14.i, label %if.then15.i, label %if.end16.i

if.then15.i:                                      ; preds = %if.end13.i
  %32 = insertelement <4 x float> %temp2.0.i, float 1.000000e+00, i32 1
  %33 = shufflevector <4 x float> %temp4.0.i, <4 x float> %sub1.i, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %if.end16.i

if.end16.i:                                       ; preds = %if.then15.i, %if.end13.i
  %temp4.1.i = phi <4 x float> [ %33, %if.then15.i ], [ %temp4.0.i, %if.end13.i ]
  %temp2.1.i = phi <4 x float> [ %32, %if.then15.i ], [ %temp2.0.i, %if.end13.i ]
  %34 = extractelement <4 x float> %sub1.i, i32 2
  %cmp17.i = fcmp ogt float %34, 0.000000e+00
  br i1 %cmp17.i, label %if.then18.i, label %if.end19.i

if.then18.i:                                      ; preds = %if.end16.i
  %35 = insertelement <4 x float> %temp2.1.i, float 1.000000e+00, i32 2
  %36 = shufflevector <4 x float> %temp4.1.i, <4 x float> %sub1.i, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %if.end19.i

if.end19.i:                                       ; preds = %if.then18.i, %if.end16.i
  %temp4.2.i = phi <4 x float> [ %36, %if.then18.i ], [ %temp4.1.i, %if.end16.i ]
  %temp2.2.i = phi <4 x float> [ %35, %if.then18.i ], [ %temp2.1.i, %if.end16.i ]
  %37 = extractelement <4 x float> %sub1.i, i32 3
  %cmp20.i = fcmp ogt float %37, 0.000000e+00
  br i1 %cmp20.i, label %if.then21.i, label %calOutputs.exit

if.then21.i:                                      ; preds = %if.end19.i
  %38 = insertelement <4 x float> %temp2.2.i, float 1.000000e+00, i32 3
  %39 = shufflevector <4 x float> %temp4.2.i, <4 x float> %sub1.i, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %calOutputs.exit

calOutputs.exit:                                  ; preds = %if.end19.i, %if.then21.i
  %temp4.3.i = phi <4 x float> [ %39, %if.then21.i ], [ %temp4.2.i, %if.end19.i ]
  %temp2.3.i = phi <4 x float> [ %38, %if.then21.i ], [ %temp2.2.i, %if.end19.i ]
  %mul.i = fmul <4 x float> %div40, %temp1.3.i
  %mul23.i = fmul <4 x float> %div44, %temp2.3.i
  %mul47 = shl i32 %add, 1
  %40 = sext i32 %mul47 to i64
  %arrayidx48 = getelementptr inbounds <4 x float> addrspace(1)* %priceSamples, i64 %40
  store <4 x float> %temp3.3.i, <4 x float> addrspace(1)* %arrayidx48, align 16, !tbaa !2
  %add52110 = or i32 %mul47, 1
  %41 = sext i32 %add52110 to i64
  %arrayidx53 = getelementptr inbounds <4 x float> addrspace(1)* %priceSamples, i64 %41
  store <4 x float> %temp4.3.i, <4 x float> addrspace(1)* %arrayidx53, align 16, !tbaa !2
  %arrayidx57 = getelementptr inbounds <4 x float> addrspace(1)* %pathDeriv, i64 %40
  store <4 x float> %mul.i, <4 x float> addrspace(1)* %arrayidx57, align 16, !tbaa !2
  %arrayidx62 = getelementptr inbounds <4 x float> addrspace(1)* %pathDeriv, i64 %41
  store <4 x float> %mul23.i, <4 x float> addrspace(1)* %arrayidx62, align 16, !tbaa !2
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
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
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

; ModuleID = 'MonteCarloAsianDP_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%struct._MonteCalroAttrib = type { <4 x double>, <4 x double>, <4 x double>, <4 x double>, <4 x double>, <4 x double>, <4 x double> }

; Function Attrs: nounwind
define cc75 void @lshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
entry:
  %sub = sub i32 32, %shift
  %0 = extractelement <4 x i32> %input, i32 0
  %shl.mask = and i32 %shift, 31
  %shl = shl i32 %0, %shl.mask
  %1 = insertelement <4 x i32> undef, i32 %shl, i32 0
  %2 = extractelement <4 x i32> %input, i32 1
  %shl.mask1 = and i32 %shift, 31
  %shl2 = shl i32 %2, %shl.mask1
  %3 = extractelement <4 x i32> %input, i32 0
  %shr.mask = and i32 %sub, 31
  %shr = lshr i32 %3, %shr.mask
  %or = or i32 %shl2, %shr
  %4 = insertelement <4 x i32> %1, i32 %or, i32 1
  %5 = extractelement <4 x i32> %input, i32 2
  %shl.mask3 = and i32 %shift, 31
  %shl4 = shl i32 %5, %shl.mask3
  %6 = extractelement <4 x i32> %input, i32 1
  %shr.mask5 = and i32 %sub, 31
  %shr6 = lshr i32 %6, %shr.mask5
  %or7 = or i32 %shl4, %shr6
  %7 = insertelement <4 x i32> %4, i32 %or7, i32 2
  %8 = extractelement <4 x i32> %input, i32 3
  %shl.mask8 = and i32 %shift, 31
  %shl9 = shl i32 %8, %shl.mask8
  %9 = extractelement <4 x i32> %input, i32 2
  %shr.mask10 = and i32 %sub, 31
  %shr11 = lshr i32 %9, %shr.mask10
  %or12 = or i32 %shl9, %shr11
  %10 = insertelement <4 x i32> %7, i32 %or12, i32 3
  store <4 x i32> %10, <4 x i32>* %output, align 16
  ret void
}

; Function Attrs: nounwind
define cc75 void @rshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
entry:
  %sub = sub i32 32, %shift
  %0 = extractelement <4 x i32> %input, i32 3
  %shr.mask = and i32 %shift, 31
  %shr = lshr i32 %0, %shr.mask
  %1 = insertelement <4 x i32> undef, i32 %shr, i32 3
  %2 = extractelement <4 x i32> %input, i32 2
  %shr.mask1 = and i32 %shift, 31
  %shr2 = lshr i32 %2, %shr.mask1
  %3 = extractelement <4 x i32> %input, i32 3
  %shl.mask = and i32 %sub, 31
  %shl = shl i32 %3, %shl.mask
  %or = or i32 %shr2, %shl
  %4 = insertelement <4 x i32> %1, i32 %or, i32 2
  %5 = extractelement <4 x i32> %input, i32 1
  %shr.mask3 = and i32 %shift, 31
  %shr4 = lshr i32 %5, %shr.mask3
  %6 = extractelement <4 x i32> %input, i32 2
  %shl.mask5 = and i32 %sub, 31
  %shl6 = shl i32 %6, %shl.mask5
  %or7 = or i32 %shr4, %shl6
  %7 = insertelement <4 x i32> %4, i32 %or7, i32 1
  %8 = extractelement <4 x i32> %input, i32 0
  %shr.mask8 = and i32 %shift, 31
  %shr9 = lshr i32 %8, %shr.mask8
  %9 = extractelement <4 x i32> %input, i32 1
  %shl.mask10 = and i32 %sub, 31
  %shl11 = shl i32 %9, %shl.mask10
  %or12 = or i32 %shr9, %shl11
  %10 = insertelement <4 x i32> %7, i32 %or12, i32 0
  store <4 x i32> %10, <4 x i32>* %output, align 16
  ret void
}

; Function Attrs: nounwind
define cc75 void @generateRand(<4 x i32> %seed, <4 x double>* %gaussianRand1, <4 x double>* %gaussianRand2, <4 x i32>* %nextRand) #0 {
entry:
  %temp = alloca [8 x <4 x i32>], align 16
  %e = alloca <4 x i32>, align 16
  %f = alloca <4 x i32>, align 16
  %0 = insertelement <4 x i32> undef, i32 1812433253, i32 0
  %splat = shufflevector <4 x i32> %0, <4 x i32> %0, <4 x i32> zeroinitializer
  %1 = insertelement <4 x i32> undef, i32 30, i32 0
  %splat1 = shufflevector <4 x i32> %1, <4 x i32> %1, <4 x i32> zeroinitializer
  store <4 x i32> zeroinitializer, <4 x i32>* %e, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %f, align 16
  %shr.mask = and <4 x i32> %splat1, <i32 31, i32 31, i32 31, i32 31>
  %shr = lshr <4 x i32> %seed, %shr.mask
  %xor = xor <4 x i32> %seed, %shr
  %mul = mul <4 x i32> %splat, %xor
  %add = add <4 x i32> %mul, <i32 1, i32 1, i32 1, i32 1>
  %shr.mask2 = and <4 x i32> %splat1, <i32 31, i32 31, i32 31, i32 31>
  %shr3 = lshr <4 x i32> %add, %shr.mask2
  %xor4 = xor <4 x i32> %add, %shr3
  %mul5 = mul <4 x i32> %splat, %xor4
  %add6 = add <4 x i32> %mul5, <i32 2, i32 2, i32 2, i32 2>
  %shr.mask7 = and <4 x i32> %splat1, <i32 31, i32 31, i32 31, i32 31>
  %shr8 = lshr <4 x i32> %add6, %shr.mask7
  %xor9 = xor <4 x i32> %add6, %shr8
  %mul10 = mul <4 x i32> %splat, %xor9
  %add11 = add <4 x i32> %mul10, <i32 3, i32 3, i32 3, i32 3>
  %shr.mask12 = and <4 x i32> %splat1, <i32 31, i32 31, i32 31, i32 31>
  %shr13 = lshr <4 x i32> %add11, %shr.mask12
  %xor14 = xor <4 x i32> %add11, %shr13
  %mul15 = mul <4 x i32> %splat, %xor14
  %add16 = add <4 x i32> %mul15, <i32 4, i32 4, i32 4, i32 4>
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %r1.0 = phi <4 x i32> [ zeroinitializer, %entry ], [ %r1.1, %for.inc ]
  %r2.0 = phi <4 x i32> [ zeroinitializer, %entry ], [ %r2.1, %for.inc ]
  %a.0 = phi <4 x i32> [ zeroinitializer, %entry ], [ %a.1, %for.inc ]
  %b.0 = phi <4 x i32> [ zeroinitializer, %entry ], [ %b.1, %for.inc ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp ult i32 %i.0, 4
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  switch i32 %i.0, label %sw.default [
    i32 0, label %sw.bb
    i32 1, label %sw.bb17
    i32 2, label %sw.bb18
    i32 3, label %sw.bb20
  ]

sw.bb:                                            ; preds = %for.body
  br label %sw.epilog

sw.bb17:                                          ; preds = %for.body
  %arrayidx = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 0
  %2 = load <4 x i32>* %arrayidx, align 16
  br label %sw.epilog

sw.bb18:                                          ; preds = %for.body
  %arrayidx19 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 1
  %3 = load <4 x i32>* %arrayidx19, align 16
  br label %sw.epilog

sw.bb20:                                          ; preds = %for.body
  %arrayidx21 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 2
  %4 = load <4 x i32>* %arrayidx21, align 16
  br label %sw.epilog

sw.default:                                       ; preds = %for.body
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default, %sw.bb20, %sw.bb18, %sw.bb17, %sw.bb
  %r1.1 = phi <4 x i32> [ %r1.0, %sw.default ], [ %r2.0, %sw.bb20 ], [ %r2.0, %sw.bb18 ], [ %r2.0, %sw.bb17 ], [ %add11, %sw.bb ]
  %r2.1 = phi <4 x i32> [ %r2.0, %sw.default ], [ %4, %sw.bb20 ], [ %3, %sw.bb18 ], [ %2, %sw.bb17 ], [ %add16, %sw.bb ]
  %a.1 = phi <4 x i32> [ %a.0, %sw.default ], [ %add11, %sw.bb20 ], [ %add6, %sw.bb18 ], [ %add, %sw.bb17 ], [ %seed, %sw.bb ]
  %b.1 = phi <4 x i32> [ %b.0, %sw.default ], [ %seed, %sw.bb20 ], [ %add16, %sw.bb18 ], [ %add11, %sw.bb17 ], [ %add6, %sw.bb ]
  call cc75 void @lshift128(<4 x i32> %a.1, i32 24, <4 x i32>* %e)
  call cc75 void @rshift128(<4 x i32> %r1.1, i32 24, <4 x i32>* %f)
  %5 = extractelement <4 x i32> %a.1, i32 0
  %6 = load <4 x i32>* %e, align 16
  %7 = extractelement <4 x i32> %6, i32 0
  %xor22 = xor i32 %5, %7
  %8 = extractelement <4 x i32> %b.1, i32 0
  %shr.mask23 = and i32 13, 31
  %shr24 = lshr i32 %8, %shr.mask23
  %and = and i32 %shr24, -33605633
  %xor25 = xor i32 %xor22, %and
  %9 = load <4 x i32>* %f, align 16
  %10 = extractelement <4 x i32> %9, i32 0
  %xor26 = xor i32 %xor25, %10
  %11 = extractelement <4 x i32> %r2.1, i32 0
  %shl.mask = and i32 15, 31
  %shl = shl i32 %11, %shl.mask
  %xor27 = xor i32 %xor26, %shl
  %idxprom = zext i32 %i.0 to i64
  %arrayidx28 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 %idxprom
  %12 = load <4 x i32>* %arrayidx28, align 16
  %13 = insertelement <4 x i32> %12, i32 %xor27, i32 0
  store <4 x i32> %13, <4 x i32>* %arrayidx28, align 16
  %14 = extractelement <4 x i32> %a.1, i32 1
  %15 = load <4 x i32>* %e, align 16
  %16 = extractelement <4 x i32> %15, i32 1
  %xor29 = xor i32 %14, %16
  %17 = extractelement <4 x i32> %b.1, i32 1
  %shr.mask30 = and i32 13, 31
  %shr31 = lshr i32 %17, %shr.mask30
  %and32 = and i32 %shr31, -276873347
  %xor33 = xor i32 %xor29, %and32
  %18 = load <4 x i32>* %f, align 16
  %19 = extractelement <4 x i32> %18, i32 1
  %xor34 = xor i32 %xor33, %19
  %20 = extractelement <4 x i32> %r2.1, i32 1
  %shl.mask35 = and i32 15, 31
  %shl36 = shl i32 %20, %shl.mask35
  %xor37 = xor i32 %xor34, %shl36
  %idxprom38 = zext i32 %i.0 to i64
  %arrayidx39 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 %idxprom38
  %21 = load <4 x i32>* %arrayidx39, align 16
  %22 = insertelement <4 x i32> %21, i32 %xor37, i32 1
  store <4 x i32> %22, <4 x i32>* %arrayidx39, align 16
  %23 = extractelement <4 x i32> %a.1, i32 2
  %24 = load <4 x i32>* %e, align 16
  %25 = extractelement <4 x i32> %24, i32 2
  %xor40 = xor i32 %23, %25
  %26 = extractelement <4 x i32> %b.1, i32 2
  %shr.mask41 = and i32 13, 31
  %shr42 = lshr i32 %26, %shr.mask41
  %and43 = and i32 %shr42, -8946819
  %xor44 = xor i32 %xor40, %and43
  %27 = load <4 x i32>* %f, align 16
  %28 = extractelement <4 x i32> %27, i32 2
  %xor45 = xor i32 %xor44, %28
  %29 = extractelement <4 x i32> %r2.1, i32 2
  %shl.mask46 = and i32 15, 31
  %shl47 = shl i32 %29, %shl.mask46
  %xor48 = xor i32 %xor45, %shl47
  %idxprom49 = zext i32 %i.0 to i64
  %arrayidx50 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 %idxprom49
  %30 = load <4 x i32>* %arrayidx50, align 16
  %31 = insertelement <4 x i32> %30, i32 %xor48, i32 2
  store <4 x i32> %31, <4 x i32>* %arrayidx50, align 16
  %32 = extractelement <4 x i32> %a.1, i32 3
  %33 = load <4 x i32>* %e, align 16
  %34 = extractelement <4 x i32> %33, i32 3
  %xor51 = xor i32 %32, %34
  %35 = extractelement <4 x i32> %b.1, i32 3
  %shr.mask52 = and i32 13, 31
  %shr53 = lshr i32 %35, %shr.mask52
  %and54 = and i32 %shr53, 2146958127
  %xor55 = xor i32 %xor51, %and54
  %36 = load <4 x i32>* %f, align 16
  %37 = extractelement <4 x i32> %36, i32 3
  %xor56 = xor i32 %xor55, %37
  %38 = extractelement <4 x i32> %r2.1, i32 3
  %shl.mask57 = and i32 15, 31
  %shl58 = shl i32 %38, %shl.mask57
  %xor59 = xor i32 %xor56, %shl58
  %idxprom60 = zext i32 %i.0 to i64
  %arrayidx61 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 %idxprom60
  %39 = load <4 x i32>* %arrayidx61, align 16
  %40 = insertelement <4 x i32> %39, i32 %xor59, i32 3
  store <4 x i32> %40, <4 x i32>* %arrayidx61, align 16
  br label %for.inc

for.inc:                                          ; preds = %sw.epilog
  %inc = add i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %arrayidx62 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 0
  %41 = load <4 x i32>* %arrayidx62, align 16
  %call = call cc75 <4 x double> @_Z15convert_double4Dv4_j(<4 x i32> %41) #1
  %mul63 = fmul <4 x double> %call, <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>
  %div = fdiv <4 x double> %mul63, <double 0x41F0000000000000, double 0x41F0000000000000, double 0x41F0000000000000, double 0x41F0000000000000>
  %arrayidx64 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 1
  %42 = load <4 x i32>* %arrayidx64, align 16
  %call65 = call cc75 <4 x double> @_Z15convert_double4Dv4_j(<4 x i32> %42) #1
  %mul66 = fmul <4 x double> %call65, <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>
  %div67 = fdiv <4 x double> %mul66, <double 0x41F0000000000000, double 0x41F0000000000000, double 0x41F0000000000000, double 0x41F0000000000000>
  %call68 = call cc75 <4 x double> @_Z3logDv4_d(<4 x double> %div) #1
  %mul69 = fmul <4 x double> <double -2.000000e+00, double -2.000000e+00, double -2.000000e+00, double -2.000000e+00>, %call68
  %call70 = call cc75 <4 x double> @_Z4sqrtDv4_d(<4 x double> %mul69) #1
  %mul71 = fmul <4 x double> <double 0x401921FB54442D11, double 0x401921FB54442D11, double 0x401921FB54442D11, double 0x401921FB54442D11>, %div67
  %call72 = call cc75 <4 x double> @_Z3cosDv4_d(<4 x double> %mul71) #1
  %mul73 = fmul <4 x double> %call70, %call72
  store <4 x double> %mul73, <4 x double>* %gaussianRand1, align 32
  %call74 = call cc75 <4 x double> @_Z3sinDv4_d(<4 x double> %mul71) #1
  %mul75 = fmul <4 x double> %call70, %call74
  store <4 x double> %mul75, <4 x double>* %gaussianRand2, align 32
  %arrayidx76 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 2
  %43 = load <4 x i32>* %arrayidx76, align 16
  store <4 x i32> %43, <4 x i32>* %nextRand, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z15convert_double4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z4sqrtDv4_d(<4 x double>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z3logDv4_d(<4 x double>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z3cosDv4_d(<4 x double>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z3sinDv4_d(<4 x double>) #1

; Function Attrs: nounwind
define cc75 void @calOutputs(<4 x double> %strikePrice, <4 x double> %meanDeriv1, <4 x double> %meanDeriv2, <4 x double> %meanPrice1, <4 x double> %meanPrice2, <4 x double>* %pathDeriv1, <4 x double>* %pathDeriv2, <4 x double>* %priceVec1, <4 x double>* %priceVec2) #0 {
entry:
  %sub = fsub <4 x double> %meanPrice1, %strikePrice
  %sub1 = fsub <4 x double> %meanPrice2, %strikePrice
  %0 = extractelement <4 x double> %sub, i32 0
  %cmp = fcmp ogt double %0, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = insertelement <4 x double> zeroinitializer, double 1.000000e+00, i32 0
  %2 = extractelement <4 x double> %sub, i32 0
  %3 = insertelement <4 x double> zeroinitializer, double %2, i32 0
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %temp1.0 = phi <4 x double> [ %1, %if.then ], [ zeroinitializer, %entry ]
  %temp3.0 = phi <4 x double> [ %3, %if.then ], [ zeroinitializer, %entry ]
  %4 = extractelement <4 x double> %sub, i32 1
  %cmp2 = fcmp ogt double %4, 0.000000e+00
  br i1 %cmp2, label %if.then3, label %if.end4

if.then3:                                         ; preds = %if.end
  %5 = insertelement <4 x double> %temp1.0, double 1.000000e+00, i32 1
  %6 = extractelement <4 x double> %sub, i32 1
  %7 = insertelement <4 x double> %temp3.0, double %6, i32 1
  br label %if.end4

if.end4:                                          ; preds = %if.then3, %if.end
  %temp1.1 = phi <4 x double> [ %5, %if.then3 ], [ %temp1.0, %if.end ]
  %temp3.1 = phi <4 x double> [ %7, %if.then3 ], [ %temp3.0, %if.end ]
  %8 = extractelement <4 x double> %sub, i32 2
  %cmp5 = fcmp ogt double %8, 0.000000e+00
  br i1 %cmp5, label %if.then6, label %if.end7

if.then6:                                         ; preds = %if.end4
  %9 = insertelement <4 x double> %temp1.1, double 1.000000e+00, i32 2
  %10 = extractelement <4 x double> %sub, i32 2
  %11 = insertelement <4 x double> %temp3.1, double %10, i32 2
  br label %if.end7

if.end7:                                          ; preds = %if.then6, %if.end4
  %temp1.2 = phi <4 x double> [ %9, %if.then6 ], [ %temp1.1, %if.end4 ]
  %temp3.2 = phi <4 x double> [ %11, %if.then6 ], [ %temp3.1, %if.end4 ]
  %12 = extractelement <4 x double> %sub, i32 3
  %cmp8 = fcmp ogt double %12, 0.000000e+00
  br i1 %cmp8, label %if.then9, label %if.end10

if.then9:                                         ; preds = %if.end7
  %13 = insertelement <4 x double> %temp1.2, double 1.000000e+00, i32 3
  %14 = extractelement <4 x double> %sub, i32 3
  %15 = insertelement <4 x double> %temp3.2, double %14, i32 3
  br label %if.end10

if.end10:                                         ; preds = %if.then9, %if.end7
  %temp1.3 = phi <4 x double> [ %13, %if.then9 ], [ %temp1.2, %if.end7 ]
  %temp3.3 = phi <4 x double> [ %15, %if.then9 ], [ %temp3.2, %if.end7 ]
  %16 = extractelement <4 x double> %sub1, i32 0
  %cmp11 = fcmp ogt double %16, 0.000000e+00
  br i1 %cmp11, label %if.then12, label %if.end13

if.then12:                                        ; preds = %if.end10
  %17 = insertelement <4 x double> zeroinitializer, double 1.000000e+00, i32 0
  %18 = extractelement <4 x double> %sub1, i32 0
  %19 = insertelement <4 x double> zeroinitializer, double %18, i32 0
  br label %if.end13

if.end13:                                         ; preds = %if.then12, %if.end10
  %temp2.0 = phi <4 x double> [ %17, %if.then12 ], [ zeroinitializer, %if.end10 ]
  %temp4.0 = phi <4 x double> [ %19, %if.then12 ], [ zeroinitializer, %if.end10 ]
  %20 = extractelement <4 x double> %sub1, i32 1
  %cmp14 = fcmp ogt double %20, 0.000000e+00
  br i1 %cmp14, label %if.then15, label %if.end16

if.then15:                                        ; preds = %if.end13
  %21 = insertelement <4 x double> %temp2.0, double 1.000000e+00, i32 1
  %22 = extractelement <4 x double> %sub1, i32 1
  %23 = insertelement <4 x double> %temp4.0, double %22, i32 1
  br label %if.end16

if.end16:                                         ; preds = %if.then15, %if.end13
  %temp2.1 = phi <4 x double> [ %21, %if.then15 ], [ %temp2.0, %if.end13 ]
  %temp4.1 = phi <4 x double> [ %23, %if.then15 ], [ %temp4.0, %if.end13 ]
  %24 = extractelement <4 x double> %sub1, i32 2
  %cmp17 = fcmp ogt double %24, 0.000000e+00
  br i1 %cmp17, label %if.then18, label %if.end19

if.then18:                                        ; preds = %if.end16
  %25 = insertelement <4 x double> %temp2.1, double 1.000000e+00, i32 2
  %26 = extractelement <4 x double> %sub1, i32 2
  %27 = insertelement <4 x double> %temp4.1, double %26, i32 2
  br label %if.end19

if.end19:                                         ; preds = %if.then18, %if.end16
  %temp2.2 = phi <4 x double> [ %25, %if.then18 ], [ %temp2.1, %if.end16 ]
  %temp4.2 = phi <4 x double> [ %27, %if.then18 ], [ %temp4.1, %if.end16 ]
  %28 = extractelement <4 x double> %sub1, i32 3
  %cmp20 = fcmp ogt double %28, 0.000000e+00
  br i1 %cmp20, label %if.then21, label %if.end22

if.then21:                                        ; preds = %if.end19
  %29 = insertelement <4 x double> %temp2.2, double 1.000000e+00, i32 3
  %30 = extractelement <4 x double> %sub1, i32 3
  %31 = insertelement <4 x double> %temp4.2, double %30, i32 3
  br label %if.end22

if.end22:                                         ; preds = %if.then21, %if.end19
  %temp2.3 = phi <4 x double> [ %29, %if.then21 ], [ %temp2.2, %if.end19 ]
  %temp4.3 = phi <4 x double> [ %31, %if.then21 ], [ %temp4.2, %if.end19 ]
  %mul = fmul <4 x double> %meanDeriv1, %temp1.3
  store <4 x double> %mul, <4 x double>* %pathDeriv1, align 32
  %mul23 = fmul <4 x double> %meanDeriv2, %temp2.3
  store <4 x double> %mul23, <4 x double>* %pathDeriv2, align 32
  store <4 x double> %temp3.3, <4 x double>* %priceVec1, align 32
  store <4 x double> %temp4.3, <4 x double>* %priceVec2, align 32
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_calPriceVega_kernel(%struct._MonteCalroAttrib* byval %attrib, i32 %noOfSum, i32 %width, <4 x i32> addrspace(1)* %randArray, <4 x double> addrspace(1)* %priceSamples, <4 x double> addrspace(1)* %pathDeriv) #0 {
entry:
  %price1 = alloca <4 x double>, align 32
  %price2 = alloca <4 x double>, align 32
  %pathDeriv1 = alloca <4 x double>, align 32
  %pathDeriv2 = alloca <4 x double>, align 32
  %finalRandf1 = alloca <4 x double>, align 32
  %finalRandf2 = alloca <4 x double>, align 32
  %nextRand = alloca <4 x i32>, align 16
  %strikePrice1 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 0
  %0 = load <4 x double>* %strikePrice1, align 32
  %c12 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 1
  %1 = load <4 x double>* %c12, align 32
  %c23 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 2
  %2 = load <4 x double>* %c23, align 32
  %c34 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 3
  %3 = load <4 x double>* %c34, align 32
  %initPrice5 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 4
  %4 = load <4 x double>* %initPrice5, align 32
  %sigma6 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 5
  %5 = load <4 x double>* %sigma6, align 32
  %timeStep7 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 6
  %6 = load <4 x double>* %timeStep7, align 32
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call8 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  store <4 x double> zeroinitializer, <4 x double>* %price1, align 32
  store <4 x double> zeroinitializer, <4 x double>* %price2, align 32
  store <4 x double> zeroinitializer, <4 x double>* %pathDeriv1, align 32
  store <4 x double> zeroinitializer, <4 x double>* %pathDeriv2, align 32
  store <4 x double> zeroinitializer, <4 x double>* %finalRandf1, align 32
  store <4 x double> zeroinitializer, <4 x double>* %finalRandf2, align 32
  %conv = sext i32 %width to i64
  %mul = mul i64 %call8, %conv
  %add = add i64 %mul, %call
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %randArray, i64 %add
  %7 = load <4 x i32> addrspace(1)* %arrayidx, align 16
  store <4 x i32> %7, <4 x i32>* %nextRand, align 16
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %trajPrice1.0 = phi <4 x double> [ %4, %entry ], [ %mul12, %for.inc ]
  %trajPrice2.0 = phi <4 x double> [ %4, %entry ], [ %mul15, %for.inc ]
  %sumPrice1.0 = phi <4 x double> [ %4, %entry ], [ %add16, %for.inc ]
  %sumPrice2.0 = phi <4 x double> [ %4, %entry ], [ %add17, %for.inc ]
  %sumDeriv1.0 = phi <4 x double> [ zeroinitializer, %entry ], [ %14, %for.inc ]
  %sumDeriv2.0 = phi <4 x double> [ zeroinitializer, %entry ], [ %15, %for.inc ]
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %noOfSum
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %8 = load <4 x i32>* %nextRand, align 16
  call cc75 void @generateRand(<4 x i32> %8, <4 x double>* %finalRandf1, <4 x double>* %finalRandf2, <4 x i32>* %nextRand)
  %9 = load <4 x double>* %finalRandf1, align 32
  %10 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %2, <4 x double> %9, <4 x double> %1)
  %call11 = call cc75 <4 x double> @_Z3expDv4_d(<4 x double> %10) #1
  %mul12 = fmul <4 x double> %trajPrice1.0, %call11
  %11 = load <4 x double>* %finalRandf2, align 32
  %12 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %2, <4 x double> %11, <4 x double> %1)
  %call14 = call cc75 <4 x double> @_Z3expDv4_d(<4 x double> %12) #1
  %mul15 = fmul <4 x double> %trajPrice2.0, %call14
  %add16 = fadd <4 x double> %sumPrice1.0, %mul12
  %add17 = fadd <4 x double> %sumPrice2.0, %mul15
  %mul18 = fmul <4 x double> %3, %6
  %conv19 = sitofp i32 %i.0 to double
  %13 = insertelement <4 x double> undef, double %conv19, i32 0
  %splat = shufflevector <4 x double> %13, <4 x double> %13, <4 x i32> zeroinitializer
  %mul20 = fmul <4 x double> %mul18, %splat
  %div = fdiv <4 x double> %mul12, %4
  %call21 = call cc75 <4 x double> @_Z3logDv4_d(<4 x double> %div) #1
  %sub = fsub <4 x double> %call21, %mul20
  %div22 = fdiv <4 x double> %sub, %5
  %14 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %mul12, <4 x double> %div22, <4 x double> %sumDeriv1.0)
  %div24 = fdiv <4 x double> %mul15, %4
  %call25 = call cc75 <4 x double> @_Z3logDv4_d(<4 x double> %div24) #1
  %sub26 = fsub <4 x double> %call25, %mul20
  %div27 = fdiv <4 x double> %sub26, %5
  %15 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %mul15, <4 x double> %div27, <4 x double> %sumDeriv2.0)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %conv29 = sitofp i32 %noOfSum to double
  %16 = insertelement <4 x double> undef, double %conv29, i32 0
  %splat30 = shufflevector <4 x double> %16, <4 x double> %16, <4 x i32> zeroinitializer
  %div31 = fdiv <4 x double> %sumPrice1.0, %splat30
  %conv32 = sitofp i32 %noOfSum to double
  %17 = insertelement <4 x double> undef, double %conv32, i32 0
  %splat33 = shufflevector <4 x double> %17, <4 x double> %17, <4 x i32> zeroinitializer
  %div34 = fdiv <4 x double> %sumPrice2.0, %splat33
  %conv35 = sitofp i32 %noOfSum to double
  %18 = insertelement <4 x double> undef, double %conv35, i32 0
  %splat36 = shufflevector <4 x double> %18, <4 x double> %18, <4 x i32> zeroinitializer
  %div37 = fdiv <4 x double> %sumDeriv1.0, %splat36
  %conv38 = sitofp i32 %noOfSum to double
  %19 = insertelement <4 x double> undef, double %conv38, i32 0
  %splat39 = shufflevector <4 x double> %19, <4 x double> %19, <4 x i32> zeroinitializer
  %div40 = fdiv <4 x double> %sumDeriv2.0, %splat39
  call cc75 void @calOutputs(<4 x double> %0, <4 x double> %div37, <4 x double> %div40, <4 x double> %div31, <4 x double> %div34, <4 x double>* %pathDeriv1, <4 x double>* %pathDeriv2, <4 x double>* %price1, <4 x double>* %price2)
  %20 = load <4 x double>* %price1, align 32
  %conv41 = sext i32 %width to i64
  %mul42 = mul i64 %call8, %conv41
  %add43 = add i64 %mul42, %call
  %mul44 = mul i64 %add43, 2
  %arrayidx45 = getelementptr inbounds <4 x double> addrspace(1)* %priceSamples, i64 %mul44
  store <4 x double> %20, <4 x double> addrspace(1)* %arrayidx45, align 32
  %21 = load <4 x double>* %price2, align 32
  %conv46 = sext i32 %width to i64
  %mul47 = mul i64 %call8, %conv46
  %add48 = add i64 %mul47, %call
  %mul49 = mul i64 %add48, 2
  %add50 = add i64 %mul49, 1
  %arrayidx51 = getelementptr inbounds <4 x double> addrspace(1)* %priceSamples, i64 %add50
  store <4 x double> %21, <4 x double> addrspace(1)* %arrayidx51, align 32
  %22 = load <4 x double>* %pathDeriv1, align 32
  %conv52 = sext i32 %width to i64
  %mul53 = mul i64 %call8, %conv52
  %add54 = add i64 %mul53, %call
  %mul55 = mul i64 %add54, 2
  %arrayidx56 = getelementptr inbounds <4 x double> addrspace(1)* %pathDeriv, i64 %mul55
  store <4 x double> %22, <4 x double> addrspace(1)* %arrayidx56, align 32
  %23 = load <4 x double>* %pathDeriv2, align 32
  %conv57 = sext i32 %width to i64
  %mul58 = mul i64 %call8, %conv57
  %add59 = add i64 %mul58, %call
  %mul60 = mul i64 %add59, 2
  %add61 = add i64 %mul60, 1
  %arrayidx62 = getelementptr inbounds <4 x double> addrspace(1)* %pathDeriv, i64 %add61
  store <4 x double> %23, <4 x double> addrspace(1)* %arrayidx62, align 32
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z3expDv4_d(<4 x double>) #1

; Function Attrs: nounwind readnone
declare <4 x double> @llvm.fmuladd.v4f64(<4 x double>, <4 x double>, <4 x double>) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (%struct._MonteCalroAttrib*, i32, i32, <4 x i32> addrspace(1)*, <4 x double> addrspace(1)*, <4 x double> addrspace(1)*)* @__OpenCL_calPriceVega_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 1, i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"MonteCarloAttrib", metadata !"int", metadata !"int", metadata !"uint4*", metadata !"double4*", metadata !"double4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"struct _MonteCalroAttrib", metadata !"int", metadata !"int", metadata !"uint4*", metadata !"double4*", metadata !"double4*"}
!6 = metadata !{i32 1, i32 2}

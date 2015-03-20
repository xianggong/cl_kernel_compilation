; ModuleID = 'MonteCarloAsianDP_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%struct._MonteCalroAttrib = type { <4 x double>, <4 x double>, <4 x double>, <4 x double>, <4 x double>, <4 x double>, <4 x double> }

; Function Attrs: nounwind
define cc75 void @lshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
entry:
  %input.addr = alloca <4 x i32>, align 16
  %shift.addr = alloca i32, align 4
  %output.addr = alloca <4 x i32>*, align 8
  %invshift = alloca i32, align 4
  %temp = alloca <4 x i32>, align 16
  store <4 x i32> %input, <4 x i32>* %input.addr, align 16
  store i32 %shift, i32* %shift.addr, align 4
  store <4 x i32>* %output, <4 x i32>** %output.addr, align 8
  %0 = load i32* %shift.addr, align 4
  %sub = sub i32 32, %0
  store i32 %sub, i32* %invshift, align 4
  %1 = load <4 x i32>* %input.addr, align 16
  %2 = extractelement <4 x i32> %1, i32 0
  %3 = load i32* %shift.addr, align 4
  %shl.mask = and i32 %3, 31
  %shl = shl i32 %2, %shl.mask
  %4 = load <4 x i32>* %temp, align 16
  %5 = insertelement <4 x i32> %4, i32 %shl, i32 0
  store <4 x i32> %5, <4 x i32>* %temp, align 16
  %6 = load <4 x i32>* %input.addr, align 16
  %7 = extractelement <4 x i32> %6, i32 1
  %8 = load i32* %shift.addr, align 4
  %shl.mask1 = and i32 %8, 31
  %shl2 = shl i32 %7, %shl.mask1
  %9 = load <4 x i32>* %input.addr, align 16
  %10 = extractelement <4 x i32> %9, i32 0
  %11 = load i32* %invshift, align 4
  %shr.mask = and i32 %11, 31
  %shr = lshr i32 %10, %shr.mask
  %or = or i32 %shl2, %shr
  %12 = load <4 x i32>* %temp, align 16
  %13 = insertelement <4 x i32> %12, i32 %or, i32 1
  store <4 x i32> %13, <4 x i32>* %temp, align 16
  %14 = load <4 x i32>* %input.addr, align 16
  %15 = extractelement <4 x i32> %14, i32 2
  %16 = load i32* %shift.addr, align 4
  %shl.mask3 = and i32 %16, 31
  %shl4 = shl i32 %15, %shl.mask3
  %17 = load <4 x i32>* %input.addr, align 16
  %18 = extractelement <4 x i32> %17, i32 1
  %19 = load i32* %invshift, align 4
  %shr.mask5 = and i32 %19, 31
  %shr6 = lshr i32 %18, %shr.mask5
  %or7 = or i32 %shl4, %shr6
  %20 = load <4 x i32>* %temp, align 16
  %21 = insertelement <4 x i32> %20, i32 %or7, i32 2
  store <4 x i32> %21, <4 x i32>* %temp, align 16
  %22 = load <4 x i32>* %input.addr, align 16
  %23 = extractelement <4 x i32> %22, i32 3
  %24 = load i32* %shift.addr, align 4
  %shl.mask8 = and i32 %24, 31
  %shl9 = shl i32 %23, %shl.mask8
  %25 = load <4 x i32>* %input.addr, align 16
  %26 = extractelement <4 x i32> %25, i32 2
  %27 = load i32* %invshift, align 4
  %shr.mask10 = and i32 %27, 31
  %shr11 = lshr i32 %26, %shr.mask10
  %or12 = or i32 %shl9, %shr11
  %28 = load <4 x i32>* %temp, align 16
  %29 = insertelement <4 x i32> %28, i32 %or12, i32 3
  store <4 x i32> %29, <4 x i32>* %temp, align 16
  %30 = load <4 x i32>* %temp, align 16
  %31 = load <4 x i32>** %output.addr, align 8
  store <4 x i32> %30, <4 x i32>* %31, align 16
  ret void
}

; Function Attrs: nounwind
define cc75 void @rshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
entry:
  %input.addr = alloca <4 x i32>, align 16
  %shift.addr = alloca i32, align 4
  %output.addr = alloca <4 x i32>*, align 8
  %invshift = alloca i32, align 4
  %temp = alloca <4 x i32>, align 16
  store <4 x i32> %input, <4 x i32>* %input.addr, align 16
  store i32 %shift, i32* %shift.addr, align 4
  store <4 x i32>* %output, <4 x i32>** %output.addr, align 8
  %0 = load i32* %shift.addr, align 4
  %sub = sub i32 32, %0
  store i32 %sub, i32* %invshift, align 4
  %1 = load <4 x i32>* %input.addr, align 16
  %2 = extractelement <4 x i32> %1, i32 3
  %3 = load i32* %shift.addr, align 4
  %shr.mask = and i32 %3, 31
  %shr = lshr i32 %2, %shr.mask
  %4 = load <4 x i32>* %temp, align 16
  %5 = insertelement <4 x i32> %4, i32 %shr, i32 3
  store <4 x i32> %5, <4 x i32>* %temp, align 16
  %6 = load <4 x i32>* %input.addr, align 16
  %7 = extractelement <4 x i32> %6, i32 2
  %8 = load i32* %shift.addr, align 4
  %shr.mask1 = and i32 %8, 31
  %shr2 = lshr i32 %7, %shr.mask1
  %9 = load <4 x i32>* %input.addr, align 16
  %10 = extractelement <4 x i32> %9, i32 3
  %11 = load i32* %invshift, align 4
  %shl.mask = and i32 %11, 31
  %shl = shl i32 %10, %shl.mask
  %or = or i32 %shr2, %shl
  %12 = load <4 x i32>* %temp, align 16
  %13 = insertelement <4 x i32> %12, i32 %or, i32 2
  store <4 x i32> %13, <4 x i32>* %temp, align 16
  %14 = load <4 x i32>* %input.addr, align 16
  %15 = extractelement <4 x i32> %14, i32 1
  %16 = load i32* %shift.addr, align 4
  %shr.mask3 = and i32 %16, 31
  %shr4 = lshr i32 %15, %shr.mask3
  %17 = load <4 x i32>* %input.addr, align 16
  %18 = extractelement <4 x i32> %17, i32 2
  %19 = load i32* %invshift, align 4
  %shl.mask5 = and i32 %19, 31
  %shl6 = shl i32 %18, %shl.mask5
  %or7 = or i32 %shr4, %shl6
  %20 = load <4 x i32>* %temp, align 16
  %21 = insertelement <4 x i32> %20, i32 %or7, i32 1
  store <4 x i32> %21, <4 x i32>* %temp, align 16
  %22 = load <4 x i32>* %input.addr, align 16
  %23 = extractelement <4 x i32> %22, i32 0
  %24 = load i32* %shift.addr, align 4
  %shr.mask8 = and i32 %24, 31
  %shr9 = lshr i32 %23, %shr.mask8
  %25 = load <4 x i32>* %input.addr, align 16
  %26 = extractelement <4 x i32> %25, i32 1
  %27 = load i32* %invshift, align 4
  %shl.mask10 = and i32 %27, 31
  %shl11 = shl i32 %26, %shl.mask10
  %or12 = or i32 %shr9, %shl11
  %28 = load <4 x i32>* %temp, align 16
  %29 = insertelement <4 x i32> %28, i32 %or12, i32 0
  store <4 x i32> %29, <4 x i32>* %temp, align 16
  %30 = load <4 x i32>* %temp, align 16
  %31 = load <4 x i32>** %output.addr, align 8
  store <4 x i32> %30, <4 x i32>* %31, align 16
  ret void
}

; Function Attrs: nounwind
define cc75 void @generateRand(<4 x i32> %seed, <4 x double>* %gaussianRand1, <4 x double>* %gaussianRand2, <4 x i32>* %nextRand) #0 {
entry:
  %seed.addr = alloca <4 x i32>, align 16
  %gaussianRand1.addr = alloca <4 x double>*, align 8
  %gaussianRand2.addr = alloca <4 x double>*, align 8
  %nextRand.addr = alloca <4 x i32>*, align 8
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
  %one = alloca double, align 8
  %intMax = alloca double, align 8
  %PI = alloca double, align 8
  %two = alloca double, align 8
  %r = alloca <4 x double>, align 32
  %phi = alloca <4 x double>, align 32
  %temp1 = alloca <4 x double>, align 32
  %temp2 = alloca <4 x double>, align 32
  %i = alloca i32, align 4
  store <4 x i32> %seed, <4 x i32>* %seed.addr, align 16
  store <4 x double>* %gaussianRand1, <4 x double>** %gaussianRand1.addr, align 8
  store <4 x double>* %gaussianRand2, <4 x double>** %gaussianRand2.addr, align 8
  store <4 x i32>* %nextRand, <4 x i32>** %nextRand.addr, align 8
  store i32 4, i32* %mulFactor, align 4
  %0 = load <4 x i32>* %seed.addr, align 16
  store <4 x i32> %0, <4 x i32>* %state1, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state2, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state3, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state4, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state5, align 16
  store i32 1812433253, i32* %stateMask, align 4
  store i32 30, i32* %thirty, align 4
  %1 = load i32* %stateMask, align 4
  %2 = insertelement <4 x i32> undef, i32 %1, i32 0
  %splat = shufflevector <4 x i32> %2, <4 x i32> %2, <4 x i32> zeroinitializer
  store <4 x i32> %splat, <4 x i32>* %mask4, align 16
  %3 = load i32* %thirty, align 4
  %4 = insertelement <4 x i32> undef, i32 %3, i32 0
  %splat1 = shufflevector <4 x i32> %4, <4 x i32> %4, <4 x i32> zeroinitializer
  store <4 x i32> %splat1, <4 x i32>* %thirty4, align 16
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
  store double 1.000000e+00, double* %one, align 8
  store double 0x41F0000000000000, double* %intMax, align 8
  store double 0x400921FB54442D11, double* %PI, align 8
  store double 2.000000e+00, double* %two, align 8
  %5 = load <4 x i32>* %mask4, align 16
  %6 = load <4 x i32>* %state1, align 16
  %7 = load <4 x i32>* %state1, align 16
  %8 = load <4 x i32>* %thirty4, align 16
  %shr.mask = and <4 x i32> %8, <i32 31, i32 31, i32 31, i32 31>
  %shr = lshr <4 x i32> %7, %shr.mask
  %xor = xor <4 x i32> %6, %shr
  %mul = mul <4 x i32> %5, %xor
  %9 = load <4 x i32>* %one4, align 16
  %add = add <4 x i32> %mul, %9
  store <4 x i32> %add, <4 x i32>* %state2, align 16
  %10 = load <4 x i32>* %mask4, align 16
  %11 = load <4 x i32>* %state2, align 16
  %12 = load <4 x i32>* %state2, align 16
  %13 = load <4 x i32>* %thirty4, align 16
  %shr.mask2 = and <4 x i32> %13, <i32 31, i32 31, i32 31, i32 31>
  %shr3 = lshr <4 x i32> %12, %shr.mask2
  %xor4 = xor <4 x i32> %11, %shr3
  %mul5 = mul <4 x i32> %10, %xor4
  %14 = load <4 x i32>* %two4, align 16
  %add6 = add <4 x i32> %mul5, %14
  store <4 x i32> %add6, <4 x i32>* %state3, align 16
  %15 = load <4 x i32>* %mask4, align 16
  %16 = load <4 x i32>* %state3, align 16
  %17 = load <4 x i32>* %state3, align 16
  %18 = load <4 x i32>* %thirty4, align 16
  %shr.mask7 = and <4 x i32> %18, <i32 31, i32 31, i32 31, i32 31>
  %shr8 = lshr <4 x i32> %17, %shr.mask7
  %xor9 = xor <4 x i32> %16, %shr8
  %mul10 = mul <4 x i32> %15, %xor9
  %19 = load <4 x i32>* %three4, align 16
  %add11 = add <4 x i32> %mul10, %19
  store <4 x i32> %add11, <4 x i32>* %state4, align 16
  %20 = load <4 x i32>* %mask4, align 16
  %21 = load <4 x i32>* %state4, align 16
  %22 = load <4 x i32>* %state4, align 16
  %23 = load <4 x i32>* %thirty4, align 16
  %shr.mask12 = and <4 x i32> %23, <i32 31, i32 31, i32 31, i32 31>
  %shr13 = lshr <4 x i32> %22, %shr.mask12
  %xor14 = xor <4 x i32> %21, %shr13
  %mul15 = mul <4 x i32> %20, %xor14
  %24 = load <4 x i32>* %four4, align 16
  %add16 = add <4 x i32> %mul15, %24
  store <4 x i32> %add16, <4 x i32>* %state5, align 16
  store i32 0, i32* %i, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %25 = load i32* %i, align 4
  %26 = load i32* %mulFactor, align 4
  %cmp = icmp ult i32 %25, %26
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %27 = load i32* %i, align 4
  switch i32 %27, label %sw.default [
    i32 0, label %sw.bb
    i32 1, label %sw.bb17
    i32 2, label %sw.bb18
    i32 3, label %sw.bb20
  ]

sw.bb:                                            ; preds = %for.body
  %28 = load <4 x i32>* %state4, align 16
  store <4 x i32> %28, <4 x i32>* %r1, align 16
  %29 = load <4 x i32>* %state5, align 16
  store <4 x i32> %29, <4 x i32>* %r2, align 16
  %30 = load <4 x i32>* %state1, align 16
  store <4 x i32> %30, <4 x i32>* %a, align 16
  %31 = load <4 x i32>* %state3, align 16
  store <4 x i32> %31, <4 x i32>* %b, align 16
  br label %sw.epilog

sw.bb17:                                          ; preds = %for.body
  %32 = load <4 x i32>* %r2, align 16
  store <4 x i32> %32, <4 x i32>* %r1, align 16
  %arrayidx = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 0
  %33 = load <4 x i32>* %arrayidx, align 16
  store <4 x i32> %33, <4 x i32>* %r2, align 16
  %34 = load <4 x i32>* %state2, align 16
  store <4 x i32> %34, <4 x i32>* %a, align 16
  %35 = load <4 x i32>* %state4, align 16
  store <4 x i32> %35, <4 x i32>* %b, align 16
  br label %sw.epilog

sw.bb18:                                          ; preds = %for.body
  %36 = load <4 x i32>* %r2, align 16
  store <4 x i32> %36, <4 x i32>* %r1, align 16
  %arrayidx19 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 1
  %37 = load <4 x i32>* %arrayidx19, align 16
  store <4 x i32> %37, <4 x i32>* %r2, align 16
  %38 = load <4 x i32>* %state3, align 16
  store <4 x i32> %38, <4 x i32>* %a, align 16
  %39 = load <4 x i32>* %state5, align 16
  store <4 x i32> %39, <4 x i32>* %b, align 16
  br label %sw.epilog

sw.bb20:                                          ; preds = %for.body
  %40 = load <4 x i32>* %r2, align 16
  store <4 x i32> %40, <4 x i32>* %r1, align 16
  %arrayidx21 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 2
  %41 = load <4 x i32>* %arrayidx21, align 16
  store <4 x i32> %41, <4 x i32>* %r2, align 16
  %42 = load <4 x i32>* %state4, align 16
  store <4 x i32> %42, <4 x i32>* %a, align 16
  %43 = load <4 x i32>* %state1, align 16
  store <4 x i32> %43, <4 x i32>* %b, align 16
  br label %sw.epilog

sw.default:                                       ; preds = %for.body
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default, %sw.bb20, %sw.bb18, %sw.bb17, %sw.bb
  %44 = load <4 x i32>* %a, align 16
  %45 = load i32* %shift, align 4
  call cc75 void @lshift128(<4 x i32> %44, i32 %45, <4 x i32>* %e)
  %46 = load <4 x i32>* %r1, align 16
  %47 = load i32* %shift, align 4
  call cc75 void @rshift128(<4 x i32> %46, i32 %47, <4 x i32>* %f)
  %48 = load <4 x i32>* %a, align 16
  %49 = extractelement <4 x i32> %48, i32 0
  %50 = load <4 x i32>* %e, align 16
  %51 = extractelement <4 x i32> %50, i32 0
  %xor22 = xor i32 %49, %51
  %52 = load <4 x i32>* %b, align 16
  %53 = extractelement <4 x i32> %52, i32 0
  %54 = load i32* %thirteen, align 4
  %shr.mask23 = and i32 %54, 31
  %shr24 = lshr i32 %53, %shr.mask23
  %55 = load i32* %mask11, align 4
  %and = and i32 %shr24, %55
  %xor25 = xor i32 %xor22, %and
  %56 = load <4 x i32>* %f, align 16
  %57 = extractelement <4 x i32> %56, i32 0
  %xor26 = xor i32 %xor25, %57
  %58 = load <4 x i32>* %r2, align 16
  %59 = extractelement <4 x i32> %58, i32 0
  %60 = load i32* %fifteen, align 4
  %shl.mask = and i32 %60, 31
  %shl = shl i32 %59, %shl.mask
  %xor27 = xor i32 %xor26, %shl
  %61 = load i32* %i, align 4
  %idxprom = zext i32 %61 to i64
  %arrayidx28 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 %idxprom
  %62 = load <4 x i32>* %arrayidx28, align 16
  %63 = insertelement <4 x i32> %62, i32 %xor27, i32 0
  store <4 x i32> %63, <4 x i32>* %arrayidx28, align 16
  %64 = load <4 x i32>* %a, align 16
  %65 = extractelement <4 x i32> %64, i32 1
  %66 = load <4 x i32>* %e, align 16
  %67 = extractelement <4 x i32> %66, i32 1
  %xor29 = xor i32 %65, %67
  %68 = load <4 x i32>* %b, align 16
  %69 = extractelement <4 x i32> %68, i32 1
  %70 = load i32* %thirteen, align 4
  %shr.mask30 = and i32 %70, 31
  %shr31 = lshr i32 %69, %shr.mask30
  %71 = load i32* %mask12, align 4
  %and32 = and i32 %shr31, %71
  %xor33 = xor i32 %xor29, %and32
  %72 = load <4 x i32>* %f, align 16
  %73 = extractelement <4 x i32> %72, i32 1
  %xor34 = xor i32 %xor33, %73
  %74 = load <4 x i32>* %r2, align 16
  %75 = extractelement <4 x i32> %74, i32 1
  %76 = load i32* %fifteen, align 4
  %shl.mask35 = and i32 %76, 31
  %shl36 = shl i32 %75, %shl.mask35
  %xor37 = xor i32 %xor34, %shl36
  %77 = load i32* %i, align 4
  %idxprom38 = zext i32 %77 to i64
  %arrayidx39 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 %idxprom38
  %78 = load <4 x i32>* %arrayidx39, align 16
  %79 = insertelement <4 x i32> %78, i32 %xor37, i32 1
  store <4 x i32> %79, <4 x i32>* %arrayidx39, align 16
  %80 = load <4 x i32>* %a, align 16
  %81 = extractelement <4 x i32> %80, i32 2
  %82 = load <4 x i32>* %e, align 16
  %83 = extractelement <4 x i32> %82, i32 2
  %xor40 = xor i32 %81, %83
  %84 = load <4 x i32>* %b, align 16
  %85 = extractelement <4 x i32> %84, i32 2
  %86 = load i32* %thirteen, align 4
  %shr.mask41 = and i32 %86, 31
  %shr42 = lshr i32 %85, %shr.mask41
  %87 = load i32* %mask13, align 4
  %and43 = and i32 %shr42, %87
  %xor44 = xor i32 %xor40, %and43
  %88 = load <4 x i32>* %f, align 16
  %89 = extractelement <4 x i32> %88, i32 2
  %xor45 = xor i32 %xor44, %89
  %90 = load <4 x i32>* %r2, align 16
  %91 = extractelement <4 x i32> %90, i32 2
  %92 = load i32* %fifteen, align 4
  %shl.mask46 = and i32 %92, 31
  %shl47 = shl i32 %91, %shl.mask46
  %xor48 = xor i32 %xor45, %shl47
  %93 = load i32* %i, align 4
  %idxprom49 = zext i32 %93 to i64
  %arrayidx50 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 %idxprom49
  %94 = load <4 x i32>* %arrayidx50, align 16
  %95 = insertelement <4 x i32> %94, i32 %xor48, i32 2
  store <4 x i32> %95, <4 x i32>* %arrayidx50, align 16
  %96 = load <4 x i32>* %a, align 16
  %97 = extractelement <4 x i32> %96, i32 3
  %98 = load <4 x i32>* %e, align 16
  %99 = extractelement <4 x i32> %98, i32 3
  %xor51 = xor i32 %97, %99
  %100 = load <4 x i32>* %b, align 16
  %101 = extractelement <4 x i32> %100, i32 3
  %102 = load i32* %thirteen, align 4
  %shr.mask52 = and i32 %102, 31
  %shr53 = lshr i32 %101, %shr.mask52
  %103 = load i32* %mask14, align 4
  %and54 = and i32 %shr53, %103
  %xor55 = xor i32 %xor51, %and54
  %104 = load <4 x i32>* %f, align 16
  %105 = extractelement <4 x i32> %104, i32 3
  %xor56 = xor i32 %xor55, %105
  %106 = load <4 x i32>* %r2, align 16
  %107 = extractelement <4 x i32> %106, i32 3
  %108 = load i32* %fifteen, align 4
  %shl.mask57 = and i32 %108, 31
  %shl58 = shl i32 %107, %shl.mask57
  %xor59 = xor i32 %xor56, %shl58
  %109 = load i32* %i, align 4
  %idxprom60 = zext i32 %109 to i64
  %arrayidx61 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 %idxprom60
  %110 = load <4 x i32>* %arrayidx61, align 16
  %111 = insertelement <4 x i32> %110, i32 %xor59, i32 3
  store <4 x i32> %111, <4 x i32>* %arrayidx61, align 16
  br label %for.inc

for.inc:                                          ; preds = %sw.epilog
  %112 = load i32* %i, align 4
  %inc = add i32 %112, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %arrayidx62 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 0
  %113 = load <4 x i32>* %arrayidx62, align 16
  %call = call cc75 <4 x double> @_Z15convert_double4Dv4_j(<4 x i32> %113) #1
  %mul63 = fmul <4 x double> %call, <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>
  %div = fdiv <4 x double> %mul63, <double 0x41F0000000000000, double 0x41F0000000000000, double 0x41F0000000000000, double 0x41F0000000000000>
  store <4 x double> %div, <4 x double>* %temp1, align 32
  %arrayidx64 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 1
  %114 = load <4 x i32>* %arrayidx64, align 16
  %call65 = call cc75 <4 x double> @_Z15convert_double4Dv4_j(<4 x i32> %114) #1
  %mul66 = fmul <4 x double> %call65, <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>
  %div67 = fdiv <4 x double> %mul66, <double 0x41F0000000000000, double 0x41F0000000000000, double 0x41F0000000000000, double 0x41F0000000000000>
  store <4 x double> %div67, <4 x double>* %temp2, align 32
  %115 = load <4 x double>* %temp1, align 32
  %call68 = call cc75 <4 x double> @_Z3logDv4_d(<4 x double> %115) #1
  %mul69 = fmul <4 x double> <double -2.000000e+00, double -2.000000e+00, double -2.000000e+00, double -2.000000e+00>, %call68
  %call70 = call cc75 <4 x double> @_Z4sqrtDv4_d(<4 x double> %mul69) #1
  store <4 x double> %call70, <4 x double>* %r, align 32
  %116 = load <4 x double>* %temp2, align 32
  %mul71 = fmul <4 x double> <double 0x401921FB54442D11, double 0x401921FB54442D11, double 0x401921FB54442D11, double 0x401921FB54442D11>, %116
  store <4 x double> %mul71, <4 x double>* %phi, align 32
  %117 = load <4 x double>* %r, align 32
  %118 = load <4 x double>* %phi, align 32
  %call72 = call cc75 <4 x double> @_Z3cosDv4_d(<4 x double> %118) #1
  %mul73 = fmul <4 x double> %117, %call72
  %119 = load <4 x double>** %gaussianRand1.addr, align 8
  store <4 x double> %mul73, <4 x double>* %119, align 32
  %120 = load <4 x double>* %r, align 32
  %121 = load <4 x double>* %phi, align 32
  %call74 = call cc75 <4 x double> @_Z3sinDv4_d(<4 x double> %121) #1
  %mul75 = fmul <4 x double> %120, %call74
  %122 = load <4 x double>** %gaussianRand2.addr, align 8
  store <4 x double> %mul75, <4 x double>* %122, align 32
  %arrayidx76 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i64 2
  %123 = load <4 x i32>* %arrayidx76, align 16
  %124 = load <4 x i32>** %nextRand.addr, align 8
  store <4 x i32> %123, <4 x i32>* %124, align 16
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
  %strikePrice.addr = alloca <4 x double>, align 32
  %meanDeriv1.addr = alloca <4 x double>, align 32
  %meanDeriv2.addr = alloca <4 x double>, align 32
  %meanPrice1.addr = alloca <4 x double>, align 32
  %meanPrice2.addr = alloca <4 x double>, align 32
  %pathDeriv1.addr = alloca <4 x double>*, align 8
  %pathDeriv2.addr = alloca <4 x double>*, align 8
  %priceVec1.addr = alloca <4 x double>*, align 8
  %priceVec2.addr = alloca <4 x double>*, align 8
  %temp1 = alloca <4 x double>, align 32
  %temp2 = alloca <4 x double>, align 32
  %temp3 = alloca <4 x double>, align 32
  %temp4 = alloca <4 x double>, align 32
  %tempDiff1 = alloca <4 x double>, align 32
  %tempDiff2 = alloca <4 x double>, align 32
  store <4 x double> %strikePrice, <4 x double>* %strikePrice.addr, align 32
  store <4 x double> %meanDeriv1, <4 x double>* %meanDeriv1.addr, align 32
  store <4 x double> %meanDeriv2, <4 x double>* %meanDeriv2.addr, align 32
  store <4 x double> %meanPrice1, <4 x double>* %meanPrice1.addr, align 32
  store <4 x double> %meanPrice2, <4 x double>* %meanPrice2.addr, align 32
  store <4 x double>* %pathDeriv1, <4 x double>** %pathDeriv1.addr, align 8
  store <4 x double>* %pathDeriv2, <4 x double>** %pathDeriv2.addr, align 8
  store <4 x double>* %priceVec1, <4 x double>** %priceVec1.addr, align 8
  store <4 x double>* %priceVec2, <4 x double>** %priceVec2.addr, align 8
  store <4 x double> zeroinitializer, <4 x double>* %temp1, align 32
  store <4 x double> zeroinitializer, <4 x double>* %temp2, align 32
  store <4 x double> zeroinitializer, <4 x double>* %temp3, align 32
  store <4 x double> zeroinitializer, <4 x double>* %temp4, align 32
  %0 = load <4 x double>* %meanPrice1.addr, align 32
  %1 = load <4 x double>* %strikePrice.addr, align 32
  %sub = fsub <4 x double> %0, %1
  store <4 x double> %sub, <4 x double>* %tempDiff1, align 32
  %2 = load <4 x double>* %meanPrice2.addr, align 32
  %3 = load <4 x double>* %strikePrice.addr, align 32
  %sub1 = fsub <4 x double> %2, %3
  store <4 x double> %sub1, <4 x double>* %tempDiff2, align 32
  %4 = load <4 x double>* %tempDiff1, align 32
  %5 = extractelement <4 x double> %4, i32 0
  %cmp = fcmp ogt double %5, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %6 = load <4 x double>* %temp1, align 32
  %7 = insertelement <4 x double> %6, double 1.000000e+00, i32 0
  store <4 x double> %7, <4 x double>* %temp1, align 32
  %8 = load <4 x double>* %tempDiff1, align 32
  %9 = extractelement <4 x double> %8, i32 0
  %10 = load <4 x double>* %temp3, align 32
  %11 = insertelement <4 x double> %10, double %9, i32 0
  store <4 x double> %11, <4 x double>* %temp3, align 32
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %12 = load <4 x double>* %tempDiff1, align 32
  %13 = extractelement <4 x double> %12, i32 1
  %cmp2 = fcmp ogt double %13, 0.000000e+00
  br i1 %cmp2, label %if.then3, label %if.end4

if.then3:                                         ; preds = %if.end
  %14 = load <4 x double>* %temp1, align 32
  %15 = insertelement <4 x double> %14, double 1.000000e+00, i32 1
  store <4 x double> %15, <4 x double>* %temp1, align 32
  %16 = load <4 x double>* %tempDiff1, align 32
  %17 = extractelement <4 x double> %16, i32 1
  %18 = load <4 x double>* %temp3, align 32
  %19 = insertelement <4 x double> %18, double %17, i32 1
  store <4 x double> %19, <4 x double>* %temp3, align 32
  br label %if.end4

if.end4:                                          ; preds = %if.then3, %if.end
  %20 = load <4 x double>* %tempDiff1, align 32
  %21 = extractelement <4 x double> %20, i32 2
  %cmp5 = fcmp ogt double %21, 0.000000e+00
  br i1 %cmp5, label %if.then6, label %if.end7

if.then6:                                         ; preds = %if.end4
  %22 = load <4 x double>* %temp1, align 32
  %23 = insertelement <4 x double> %22, double 1.000000e+00, i32 2
  store <4 x double> %23, <4 x double>* %temp1, align 32
  %24 = load <4 x double>* %tempDiff1, align 32
  %25 = extractelement <4 x double> %24, i32 2
  %26 = load <4 x double>* %temp3, align 32
  %27 = insertelement <4 x double> %26, double %25, i32 2
  store <4 x double> %27, <4 x double>* %temp3, align 32
  br label %if.end7

if.end7:                                          ; preds = %if.then6, %if.end4
  %28 = load <4 x double>* %tempDiff1, align 32
  %29 = extractelement <4 x double> %28, i32 3
  %cmp8 = fcmp ogt double %29, 0.000000e+00
  br i1 %cmp8, label %if.then9, label %if.end10

if.then9:                                         ; preds = %if.end7
  %30 = load <4 x double>* %temp1, align 32
  %31 = insertelement <4 x double> %30, double 1.000000e+00, i32 3
  store <4 x double> %31, <4 x double>* %temp1, align 32
  %32 = load <4 x double>* %tempDiff1, align 32
  %33 = extractelement <4 x double> %32, i32 3
  %34 = load <4 x double>* %temp3, align 32
  %35 = insertelement <4 x double> %34, double %33, i32 3
  store <4 x double> %35, <4 x double>* %temp3, align 32
  br label %if.end10

if.end10:                                         ; preds = %if.then9, %if.end7
  %36 = load <4 x double>* %tempDiff2, align 32
  %37 = extractelement <4 x double> %36, i32 0
  %cmp11 = fcmp ogt double %37, 0.000000e+00
  br i1 %cmp11, label %if.then12, label %if.end13

if.then12:                                        ; preds = %if.end10
  %38 = load <4 x double>* %temp2, align 32
  %39 = insertelement <4 x double> %38, double 1.000000e+00, i32 0
  store <4 x double> %39, <4 x double>* %temp2, align 32
  %40 = load <4 x double>* %tempDiff2, align 32
  %41 = extractelement <4 x double> %40, i32 0
  %42 = load <4 x double>* %temp4, align 32
  %43 = insertelement <4 x double> %42, double %41, i32 0
  store <4 x double> %43, <4 x double>* %temp4, align 32
  br label %if.end13

if.end13:                                         ; preds = %if.then12, %if.end10
  %44 = load <4 x double>* %tempDiff2, align 32
  %45 = extractelement <4 x double> %44, i32 1
  %cmp14 = fcmp ogt double %45, 0.000000e+00
  br i1 %cmp14, label %if.then15, label %if.end16

if.then15:                                        ; preds = %if.end13
  %46 = load <4 x double>* %temp2, align 32
  %47 = insertelement <4 x double> %46, double 1.000000e+00, i32 1
  store <4 x double> %47, <4 x double>* %temp2, align 32
  %48 = load <4 x double>* %tempDiff2, align 32
  %49 = extractelement <4 x double> %48, i32 1
  %50 = load <4 x double>* %temp4, align 32
  %51 = insertelement <4 x double> %50, double %49, i32 1
  store <4 x double> %51, <4 x double>* %temp4, align 32
  br label %if.end16

if.end16:                                         ; preds = %if.then15, %if.end13
  %52 = load <4 x double>* %tempDiff2, align 32
  %53 = extractelement <4 x double> %52, i32 2
  %cmp17 = fcmp ogt double %53, 0.000000e+00
  br i1 %cmp17, label %if.then18, label %if.end19

if.then18:                                        ; preds = %if.end16
  %54 = load <4 x double>* %temp2, align 32
  %55 = insertelement <4 x double> %54, double 1.000000e+00, i32 2
  store <4 x double> %55, <4 x double>* %temp2, align 32
  %56 = load <4 x double>* %tempDiff2, align 32
  %57 = extractelement <4 x double> %56, i32 2
  %58 = load <4 x double>* %temp4, align 32
  %59 = insertelement <4 x double> %58, double %57, i32 2
  store <4 x double> %59, <4 x double>* %temp4, align 32
  br label %if.end19

if.end19:                                         ; preds = %if.then18, %if.end16
  %60 = load <4 x double>* %tempDiff2, align 32
  %61 = extractelement <4 x double> %60, i32 3
  %cmp20 = fcmp ogt double %61, 0.000000e+00
  br i1 %cmp20, label %if.then21, label %if.end22

if.then21:                                        ; preds = %if.end19
  %62 = load <4 x double>* %temp2, align 32
  %63 = insertelement <4 x double> %62, double 1.000000e+00, i32 3
  store <4 x double> %63, <4 x double>* %temp2, align 32
  %64 = load <4 x double>* %tempDiff2, align 32
  %65 = extractelement <4 x double> %64, i32 3
  %66 = load <4 x double>* %temp4, align 32
  %67 = insertelement <4 x double> %66, double %65, i32 3
  store <4 x double> %67, <4 x double>* %temp4, align 32
  br label %if.end22

if.end22:                                         ; preds = %if.then21, %if.end19
  %68 = load <4 x double>* %meanDeriv1.addr, align 32
  %69 = load <4 x double>* %temp1, align 32
  %mul = fmul <4 x double> %68, %69
  %70 = load <4 x double>** %pathDeriv1.addr, align 8
  store <4 x double> %mul, <4 x double>* %70, align 32
  %71 = load <4 x double>* %meanDeriv2.addr, align 32
  %72 = load <4 x double>* %temp2, align 32
  %mul23 = fmul <4 x double> %71, %72
  %73 = load <4 x double>** %pathDeriv2.addr, align 8
  store <4 x double> %mul23, <4 x double>* %73, align 32
  %74 = load <4 x double>* %temp3, align 32
  %75 = load <4 x double>** %priceVec1.addr, align 8
  store <4 x double> %74, <4 x double>* %75, align 32
  %76 = load <4 x double>* %temp4, align 32
  %77 = load <4 x double>** %priceVec2.addr, align 8
  store <4 x double> %76, <4 x double>* %77, align 32
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_calPriceVega_kernel(%struct._MonteCalroAttrib* byval %attrib, i32 %noOfSum, i32 %width, <4 x i32> addrspace(1)* %randArray, <4 x double> addrspace(1)* %priceSamples, <4 x double> addrspace(1)* %pathDeriv) #0 {
entry:
  %noOfSum.addr = alloca i32, align 4
  %width.addr = alloca i32, align 4
  %randArray.addr = alloca <4 x i32> addrspace(1)*, align 8
  %priceSamples.addr = alloca <4 x double> addrspace(1)*, align 8
  %pathDeriv.addr = alloca <4 x double> addrspace(1)*, align 8
  %strikePrice = alloca <4 x double>, align 32
  %c1 = alloca <4 x double>, align 32
  %c2 = alloca <4 x double>, align 32
  %c3 = alloca <4 x double>, align 32
  %initPrice = alloca <4 x double>, align 32
  %sigma = alloca <4 x double>, align 32
  %timeStep = alloca <4 x double>, align 32
  %xPos = alloca i64, align 8
  %yPos = alloca i64, align 8
  %temp = alloca <4 x double>, align 32
  %price1 = alloca <4 x double>, align 32
  %price2 = alloca <4 x double>, align 32
  %pathDeriv1 = alloca <4 x double>, align 32
  %pathDeriv2 = alloca <4 x double>, align 32
  %trajPrice1 = alloca <4 x double>, align 32
  %trajPrice2 = alloca <4 x double>, align 32
  %sumPrice1 = alloca <4 x double>, align 32
  %sumPrice2 = alloca <4 x double>, align 32
  %meanPrice1 = alloca <4 x double>, align 32
  %meanPrice2 = alloca <4 x double>, align 32
  %sumDeriv1 = alloca <4 x double>, align 32
  %sumDeriv2 = alloca <4 x double>, align 32
  %meanDeriv1 = alloca <4 x double>, align 32
  %meanDeriv2 = alloca <4 x double>, align 32
  %finalRandf1 = alloca <4 x double>, align 32
  %finalRandf2 = alloca <4 x double>, align 32
  %nextRand = alloca <4 x i32>, align 16
  %i = alloca i32, align 4
  %tempRand = alloca <4 x i32>, align 16
  store i32 %noOfSum, i32* %noOfSum.addr, align 4
  store i32 %width, i32* %width.addr, align 4
  store <4 x i32> addrspace(1)* %randArray, <4 x i32> addrspace(1)** %randArray.addr, align 8
  store <4 x double> addrspace(1)* %priceSamples, <4 x double> addrspace(1)** %priceSamples.addr, align 8
  store <4 x double> addrspace(1)* %pathDeriv, <4 x double> addrspace(1)** %pathDeriv.addr, align 8
  %strikePrice1 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 0
  %0 = load <4 x double>* %strikePrice1, align 32
  store <4 x double> %0, <4 x double>* %strikePrice, align 32
  %c12 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 1
  %1 = load <4 x double>* %c12, align 32
  store <4 x double> %1, <4 x double>* %c1, align 32
  %c23 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 2
  %2 = load <4 x double>* %c23, align 32
  store <4 x double> %2, <4 x double>* %c2, align 32
  %c34 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 3
  %3 = load <4 x double>* %c34, align 32
  store <4 x double> %3, <4 x double>* %c3, align 32
  %initPrice5 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 4
  %4 = load <4 x double>* %initPrice5, align 32
  store <4 x double> %4, <4 x double>* %initPrice, align 32
  %sigma6 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 5
  %5 = load <4 x double>* %sigma6, align 32
  store <4 x double> %5, <4 x double>* %sigma, align 32
  %timeStep7 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 6
  %6 = load <4 x double>* %timeStep7, align 32
  store <4 x double> %6, <4 x double>* %timeStep, align 32
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call, i64* %xPos, align 8
  %call8 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  store i64 %call8, i64* %yPos, align 8
  store <4 x double> zeroinitializer, <4 x double>* %temp, align 32
  store <4 x double> zeroinitializer, <4 x double>* %price1, align 32
  store <4 x double> zeroinitializer, <4 x double>* %price2, align 32
  store <4 x double> zeroinitializer, <4 x double>* %pathDeriv1, align 32
  store <4 x double> zeroinitializer, <4 x double>* %pathDeriv2, align 32
  %7 = load <4 x double>* %initPrice, align 32
  store <4 x double> %7, <4 x double>* %trajPrice1, align 32
  %8 = load <4 x double>* %initPrice, align 32
  store <4 x double> %8, <4 x double>* %trajPrice2, align 32
  %9 = load <4 x double>* %initPrice, align 32
  store <4 x double> %9, <4 x double>* %sumPrice1, align 32
  %10 = load <4 x double>* %initPrice, align 32
  store <4 x double> %10, <4 x double>* %sumPrice2, align 32
  %11 = load <4 x double>* %temp, align 32
  store <4 x double> %11, <4 x double>* %meanPrice1, align 32
  %12 = load <4 x double>* %temp, align 32
  store <4 x double> %12, <4 x double>* %meanPrice2, align 32
  %13 = load <4 x double>* %temp, align 32
  store <4 x double> %13, <4 x double>* %sumDeriv1, align 32
  %14 = load <4 x double>* %temp, align 32
  store <4 x double> %14, <4 x double>* %sumDeriv2, align 32
  %15 = load <4 x double>* %temp, align 32
  store <4 x double> %15, <4 x double>* %meanDeriv1, align 32
  %16 = load <4 x double>* %temp, align 32
  store <4 x double> %16, <4 x double>* %meanDeriv2, align 32
  %17 = load <4 x double>* %temp, align 32
  store <4 x double> %17, <4 x double>* %finalRandf1, align 32
  %18 = load <4 x double>* %temp, align 32
  store <4 x double> %18, <4 x double>* %finalRandf2, align 32
  %19 = load i64* %yPos, align 8
  %20 = load i32* %width.addr, align 4
  %conv = sext i32 %20 to i64
  %mul = mul i64 %19, %conv
  %21 = load i64* %xPos, align 8
  %add = add i64 %mul, %21
  %22 = load <4 x i32> addrspace(1)** %randArray.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %22, i64 %add
  %23 = load <4 x i32> addrspace(1)* %arrayidx, align 16
  store <4 x i32> %23, <4 x i32>* %nextRand, align 16
  store i32 1, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %24 = load i32* %i, align 4
  %25 = load i32* %noOfSum.addr, align 4
  %cmp = icmp slt i32 %24, %25
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %26 = load <4 x i32>* %nextRand, align 16
  store <4 x i32> %26, <4 x i32>* %tempRand, align 16
  %27 = load <4 x i32>* %tempRand, align 16
  call cc75 void @generateRand(<4 x i32> %27, <4 x double>* %finalRandf1, <4 x double>* %finalRandf2, <4 x i32>* %nextRand)
  %28 = load <4 x double>* %trajPrice1, align 32
  %29 = load <4 x double>* %c1, align 32
  %30 = load <4 x double>* %c2, align 32
  %31 = load <4 x double>* %finalRandf1, align 32
  %32 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %30, <4 x double> %31, <4 x double> %29)
  %call11 = call cc75 <4 x double> @_Z3expDv4_d(<4 x double> %32) #1
  %mul12 = fmul <4 x double> %28, %call11
  store <4 x double> %mul12, <4 x double>* %trajPrice1, align 32
  %33 = load <4 x double>* %trajPrice2, align 32
  %34 = load <4 x double>* %c1, align 32
  %35 = load <4 x double>* %c2, align 32
  %36 = load <4 x double>* %finalRandf2, align 32
  %37 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %35, <4 x double> %36, <4 x double> %34)
  %call14 = call cc75 <4 x double> @_Z3expDv4_d(<4 x double> %37) #1
  %mul15 = fmul <4 x double> %33, %call14
  store <4 x double> %mul15, <4 x double>* %trajPrice2, align 32
  %38 = load <4 x double>* %sumPrice1, align 32
  %39 = load <4 x double>* %trajPrice1, align 32
  %add16 = fadd <4 x double> %38, %39
  store <4 x double> %add16, <4 x double>* %sumPrice1, align 32
  %40 = load <4 x double>* %sumPrice2, align 32
  %41 = load <4 x double>* %trajPrice2, align 32
  %add17 = fadd <4 x double> %40, %41
  store <4 x double> %add17, <4 x double>* %sumPrice2, align 32
  %42 = load <4 x double>* %c3, align 32
  %43 = load <4 x double>* %timeStep, align 32
  %mul18 = fmul <4 x double> %42, %43
  %44 = load i32* %i, align 4
  %conv19 = sitofp i32 %44 to double
  %45 = insertelement <4 x double> undef, double %conv19, i32 0
  %splat = shufflevector <4 x double> %45, <4 x double> %45, <4 x i32> zeroinitializer
  %mul20 = fmul <4 x double> %mul18, %splat
  store <4 x double> %mul20, <4 x double>* %temp, align 32
  %46 = load <4 x double>* %sumDeriv1, align 32
  %47 = load <4 x double>* %trajPrice1, align 32
  %48 = load <4 x double>* %trajPrice1, align 32
  %49 = load <4 x double>* %initPrice, align 32
  %div = fdiv <4 x double> %48, %49
  %call21 = call cc75 <4 x double> @_Z3logDv4_d(<4 x double> %div) #1
  %50 = load <4 x double>* %temp, align 32
  %sub = fsub <4 x double> %call21, %50
  %51 = load <4 x double>* %sigma, align 32
  %div22 = fdiv <4 x double> %sub, %51
  %52 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %47, <4 x double> %div22, <4 x double> %46)
  store <4 x double> %52, <4 x double>* %sumDeriv1, align 32
  %53 = load <4 x double>* %sumDeriv2, align 32
  %54 = load <4 x double>* %trajPrice2, align 32
  %55 = load <4 x double>* %trajPrice2, align 32
  %56 = load <4 x double>* %initPrice, align 32
  %div24 = fdiv <4 x double> %55, %56
  %call25 = call cc75 <4 x double> @_Z3logDv4_d(<4 x double> %div24) #1
  %57 = load <4 x double>* %temp, align 32
  %sub26 = fsub <4 x double> %call25, %57
  %58 = load <4 x double>* %sigma, align 32
  %div27 = fdiv <4 x double> %sub26, %58
  %59 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %54, <4 x double> %div27, <4 x double> %53)
  store <4 x double> %59, <4 x double>* %sumDeriv2, align 32
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %60 = load i32* %i, align 4
  %inc = add nsw i32 %60, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %61 = load <4 x double>* %sumPrice1, align 32
  %62 = load i32* %noOfSum.addr, align 4
  %conv29 = sitofp i32 %62 to double
  %63 = insertelement <4 x double> undef, double %conv29, i32 0
  %splat30 = shufflevector <4 x double> %63, <4 x double> %63, <4 x i32> zeroinitializer
  %div31 = fdiv <4 x double> %61, %splat30
  store <4 x double> %div31, <4 x double>* %meanPrice1, align 32
  %64 = load <4 x double>* %sumPrice2, align 32
  %65 = load i32* %noOfSum.addr, align 4
  %conv32 = sitofp i32 %65 to double
  %66 = insertelement <4 x double> undef, double %conv32, i32 0
  %splat33 = shufflevector <4 x double> %66, <4 x double> %66, <4 x i32> zeroinitializer
  %div34 = fdiv <4 x double> %64, %splat33
  store <4 x double> %div34, <4 x double>* %meanPrice2, align 32
  %67 = load <4 x double>* %sumDeriv1, align 32
  %68 = load i32* %noOfSum.addr, align 4
  %conv35 = sitofp i32 %68 to double
  %69 = insertelement <4 x double> undef, double %conv35, i32 0
  %splat36 = shufflevector <4 x double> %69, <4 x double> %69, <4 x i32> zeroinitializer
  %div37 = fdiv <4 x double> %67, %splat36
  store <4 x double> %div37, <4 x double>* %meanDeriv1, align 32
  %70 = load <4 x double>* %sumDeriv2, align 32
  %71 = load i32* %noOfSum.addr, align 4
  %conv38 = sitofp i32 %71 to double
  %72 = insertelement <4 x double> undef, double %conv38, i32 0
  %splat39 = shufflevector <4 x double> %72, <4 x double> %72, <4 x i32> zeroinitializer
  %div40 = fdiv <4 x double> %70, %splat39
  store <4 x double> %div40, <4 x double>* %meanDeriv2, align 32
  %73 = load <4 x double>* %strikePrice, align 32
  %74 = load <4 x double>* %meanDeriv1, align 32
  %75 = load <4 x double>* %meanDeriv2, align 32
  %76 = load <4 x double>* %meanPrice1, align 32
  %77 = load <4 x double>* %meanPrice2, align 32
  call cc75 void @calOutputs(<4 x double> %73, <4 x double> %74, <4 x double> %75, <4 x double> %76, <4 x double> %77, <4 x double>* %pathDeriv1, <4 x double>* %pathDeriv2, <4 x double>* %price1, <4 x double>* %price2)
  %78 = load <4 x double>* %price1, align 32
  %79 = load i64* %yPos, align 8
  %80 = load i32* %width.addr, align 4
  %conv41 = sext i32 %80 to i64
  %mul42 = mul i64 %79, %conv41
  %81 = load i64* %xPos, align 8
  %add43 = add i64 %mul42, %81
  %mul44 = mul i64 %add43, 2
  %82 = load <4 x double> addrspace(1)** %priceSamples.addr, align 8
  %arrayidx45 = getelementptr inbounds <4 x double> addrspace(1)* %82, i64 %mul44
  store <4 x double> %78, <4 x double> addrspace(1)* %arrayidx45, align 32
  %83 = load <4 x double>* %price2, align 32
  %84 = load i64* %yPos, align 8
  %85 = load i32* %width.addr, align 4
  %conv46 = sext i32 %85 to i64
  %mul47 = mul i64 %84, %conv46
  %86 = load i64* %xPos, align 8
  %add48 = add i64 %mul47, %86
  %mul49 = mul i64 %add48, 2
  %add50 = add i64 %mul49, 1
  %87 = load <4 x double> addrspace(1)** %priceSamples.addr, align 8
  %arrayidx51 = getelementptr inbounds <4 x double> addrspace(1)* %87, i64 %add50
  store <4 x double> %83, <4 x double> addrspace(1)* %arrayidx51, align 32
  %88 = load <4 x double>* %pathDeriv1, align 32
  %89 = load i64* %yPos, align 8
  %90 = load i32* %width.addr, align 4
  %conv52 = sext i32 %90 to i64
  %mul53 = mul i64 %89, %conv52
  %91 = load i64* %xPos, align 8
  %add54 = add i64 %mul53, %91
  %mul55 = mul i64 %add54, 2
  %92 = load <4 x double> addrspace(1)** %pathDeriv.addr, align 8
  %arrayidx56 = getelementptr inbounds <4 x double> addrspace(1)* %92, i64 %mul55
  store <4 x double> %88, <4 x double> addrspace(1)* %arrayidx56, align 32
  %93 = load <4 x double>* %pathDeriv2, align 32
  %94 = load i64* %yPos, align 8
  %95 = load i32* %width.addr, align 4
  %conv57 = sext i32 %95 to i64
  %mul58 = mul i64 %94, %conv57
  %96 = load i64* %xPos, align 8
  %add59 = add i64 %mul58, %96
  %mul60 = mul i64 %add59, 2
  %add61 = add i64 %mul60, 1
  %97 = load <4 x double> addrspace(1)** %pathDeriv.addr, align 8
  %arrayidx62 = getelementptr inbounds <4 x double> addrspace(1)* %97, i64 %add61
  store <4 x double> %93, <4 x double> addrspace(1)* %arrayidx62, align 32
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

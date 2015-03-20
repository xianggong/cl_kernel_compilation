; ModuleID = 'GaussianNoiseGL_Kernels2.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc75 float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
entry:
  %idum.addr = alloca i32, align 4
  %iv.addr = alloca i32 addrspace(3)*, align 8
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %iy = alloca i32, align 4
  %tid = alloca i32, align 4
  store i32 %idum, i32* %idum.addr, align 4
  store i32 addrspace(3)* %iv, i32 addrspace(3)** %iv.addr, align 8
  store i32 0, i32* %iy, align 4
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  store i32 4, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %j, align 4
  %cmp = icmp sge i32 %0, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32* %idum.addr, align 4
  %div = sdiv i32 %1, 127773
  store i32 %div, i32* %k, align 4
  %2 = load i32* %idum.addr, align 4
  %3 = load i32* %k, align 4
  %mul = mul nsw i32 %3, 127773
  %sub = sub nsw i32 %2, %mul
  %mul2 = mul nsw i32 16807, %sub
  %4 = load i32* %k, align 4
  %mul3 = mul nsw i32 2836, %4
  %sub4 = sub nsw i32 %mul2, %mul3
  store i32 %sub4, i32* %idum.addr, align 4
  %5 = load i32* %idum.addr, align 4
  %cmp5 = icmp slt i32 %5, 0
  br i1 %cmp5, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %6 = load i32* %idum.addr, align 4
  %add = add nsw i32 %6, 2147483647
  store i32 %add, i32* %idum.addr, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %7 = load i32* %j, align 4
  %cmp7 = icmp slt i32 %7, 4
  br i1 %cmp7, label %if.then9, label %if.end12

if.then9:                                         ; preds = %if.end
  %8 = load i32* %idum.addr, align 4
  %9 = load i32* %tid, align 4
  %mul10 = mul nsw i32 4, %9
  %10 = load i32* %j, align 4
  %add11 = add nsw i32 %mul10, %10
  %idxprom = sext i32 %add11 to i64
  %11 = load i32 addrspace(3)** %iv.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(3)* %11, i64 %idxprom
  store i32 %8, i32 addrspace(3)* %arrayidx, align 4
  br label %if.end12

if.end12:                                         ; preds = %if.then9, %if.end
  br label %for.inc

for.inc:                                          ; preds = %if.end12
  %12 = load i32* %j, align 4
  %dec = add nsw i32 %12, -1
  store i32 %dec, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %13 = load i32 addrspace(3)** %iv.addr, align 8
  %arrayidx13 = getelementptr inbounds i32 addrspace(3)* %13, i64 0
  %14 = load i32 addrspace(3)* %arrayidx13, align 4
  store i32 %14, i32* %iy, align 4
  %15 = load i32* %idum.addr, align 4
  %div14 = sdiv i32 %15, 127773
  store i32 %div14, i32* %k, align 4
  %16 = load i32* %idum.addr, align 4
  %17 = load i32* %k, align 4
  %mul15 = mul nsw i32 %17, 127773
  %sub16 = sub nsw i32 %16, %mul15
  %mul17 = mul nsw i32 16807, %sub16
  %18 = load i32* %k, align 4
  %mul18 = mul nsw i32 2836, %18
  %sub19 = sub nsw i32 %mul17, %mul18
  store i32 %sub19, i32* %idum.addr, align 4
  %19 = load i32* %idum.addr, align 4
  %cmp20 = icmp slt i32 %19, 0
  br i1 %cmp20, label %if.then22, label %if.end24

if.then22:                                        ; preds = %for.end
  %20 = load i32* %idum.addr, align 4
  %add23 = add nsw i32 %20, 2147483647
  store i32 %add23, i32* %idum.addr, align 4
  br label %if.end24

if.end24:                                         ; preds = %if.then22, %for.end
  %21 = load i32* %iy, align 4
  %div25 = sdiv i32 %21, 536870912
  store i32 %div25, i32* %j, align 4
  %22 = load i32* %tid, align 4
  %mul26 = mul nsw i32 4, %22
  %23 = load i32* %j, align 4
  %add27 = add nsw i32 %mul26, %23
  %idxprom28 = sext i32 %add27 to i64
  %24 = load i32 addrspace(3)** %iv.addr, align 8
  %arrayidx29 = getelementptr inbounds i32 addrspace(3)* %24, i64 %idxprom28
  %25 = load i32 addrspace(3)* %arrayidx29, align 4
  store i32 %25, i32* %iy, align 4
  %26 = load i32* %iy, align 4
  %conv30 = sitofp i32 %26 to double
  %mul31 = fmul double 0x3E00000000200000, %conv30
  %conv32 = fptrunc double %mul31 to float
  ret float %conv32
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind
define cc75 <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
entry:
  %uniform.addr = alloca <2 x float>, align 8
  %r = alloca float, align 4
  %theta = alloca float, align 4
  %.compoundliteral = alloca <2 x float>, align 8
  store <2 x float> %uniform, <2 x float>* %uniform.addr, align 8
  %0 = load <2 x float>* %uniform.addr, align 8
  %1 = extractelement <2 x float> %0, i32 0
  %call = call cc75 float @_Z3logf(float %1) #1
  %mul = fmul float -2.000000e+00, %call
  %call1 = call cc75 float @_Z4sqrtf(float %mul) #1
  store float %call1, float* %r, align 4
  %2 = load <2 x float>* %uniform.addr, align 8
  %3 = extractelement <2 x float> %2, i32 1
  %conv = fpext float %3 to double
  %mul2 = fmul double 6.280000e+00, %conv
  %conv3 = fptrunc double %mul2 to float
  store float %conv3, float* %theta, align 4
  %4 = load float* %r, align 4
  %5 = load float* %theta, align 4
  %call4 = call cc75 float @_Z3sinf(float %5) #1
  %mul5 = fmul float %4, %call4
  %vecinit = insertelement <2 x float> undef, float %mul5, i32 0
  %6 = load float* %r, align 4
  %7 = load float* %theta, align 4
  %call6 = call cc75 float @_Z3cosf(float %7) #1
  %mul7 = fmul float %6, %call6
  %vecinit8 = insertelement <2 x float> %vecinit, float %mul7, i32 1
  store <2 x float> %vecinit8, <2 x float>* %.compoundliteral
  %8 = load <2 x float>* %.compoundliteral
  ret <2 x float> %8
}

; Function Attrs: nounwind readnone
declare cc75 float @_Z4sqrtf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3logf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3sinf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3cosf(float) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!0}
!opencl.spir.version = !{!0}

!0 = metadata !{i32 1, i32 2}

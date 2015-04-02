; ModuleID = 'GaussianNoiseGL_Kernels2.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc75 float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %j.0 = phi i32 [ 4, %entry ], [ %dec, %for.inc ]
  %idum.addr.0 = phi i32 [ %idum, %entry ], [ %idum.addr.1, %for.inc ]
  %cmp = icmp sge i32 %j.0, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %div = sdiv i32 %idum.addr.0, 127773
  %mul = mul nsw i32 %div, 127773
  %sub = sub nsw i32 %idum.addr.0, %mul
  %mul2 = mul nsw i32 16807, %sub
  %mul3 = mul nsw i32 2836, %div
  %sub4 = sub nsw i32 %mul2, %mul3
  %cmp5 = icmp slt i32 %sub4, 0
  br i1 %cmp5, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %add = add nsw i32 %sub4, 2147483647
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %idum.addr.1 = phi i32 [ %add, %if.then ], [ %sub4, %for.body ]
  %cmp7 = icmp slt i32 %j.0, 4
  br i1 %cmp7, label %if.then9, label %if.end12

if.then9:                                         ; preds = %if.end
  %mul10 = mul nsw i32 4, %conv
  %add11 = add nsw i32 %mul10, %j.0
  %idxprom = sext i32 %add11 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(3)* %iv, i64 %idxprom
  store i32 %idum.addr.1, i32 addrspace(3)* %arrayidx, align 4
  br label %if.end12

if.end12:                                         ; preds = %if.then9, %if.end
  br label %for.inc

for.inc:                                          ; preds = %if.end12
  %dec = add nsw i32 %j.0, -1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %arrayidx13 = getelementptr inbounds i32 addrspace(3)* %iv, i64 0
  %0 = load i32 addrspace(3)* %arrayidx13, align 4
  %div14 = sdiv i32 %idum.addr.0, 127773
  %mul15 = mul nsw i32 %div14, 127773
  %sub16 = sub nsw i32 %idum.addr.0, %mul15
  %mul17 = mul nsw i32 16807, %sub16
  %mul18 = mul nsw i32 2836, %div14
  %sub19 = sub nsw i32 %mul17, %mul18
  %cmp20 = icmp slt i32 %sub19, 0
  br i1 %cmp20, label %if.then22, label %if.end24

if.then22:                                        ; preds = %for.end
  %add23 = add nsw i32 %sub19, 2147483647
  br label %if.end24

if.end24:                                         ; preds = %if.then22, %for.end
  %div25 = sdiv i32 %0, 536870912
  %mul26 = mul nsw i32 4, %conv
  %add27 = add nsw i32 %mul26, %div25
  %idxprom28 = sext i32 %add27 to i64
  %arrayidx29 = getelementptr inbounds i32 addrspace(3)* %iv, i64 %idxprom28
  %1 = load i32 addrspace(3)* %arrayidx29, align 4
  %conv30 = sitofp i32 %1 to double
  %mul31 = fmul double 0x3E00000000200000, %conv30
  %conv32 = fptrunc double %mul31 to float
  ret float %conv32
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind
define cc75 <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
entry:
  %0 = extractelement <2 x float> %uniform, i32 0
  %call = call cc75 float @_Z3logf(float %0) #1
  %mul = fmul float -2.000000e+00, %call
  %call1 = call cc75 float @_Z4sqrtf(float %mul) #1
  %1 = extractelement <2 x float> %uniform, i32 1
  %conv = fpext float %1 to double
  %mul2 = fmul double 6.280000e+00, %conv
  %conv3 = fptrunc double %mul2 to float
  %call4 = call cc75 float @_Z3sinf(float %conv3) #1
  %mul5 = fmul float %call1, %call4
  %vecinit = insertelement <2 x float> undef, float %mul5, i32 0
  %call6 = call cc75 float @_Z3cosf(float %conv3) #1
  %mul7 = fmul float %call1, %call6
  %vecinit8 = insertelement <2 x float> %vecinit, float %mul7, i32 1
  ret <2 x float> %vecinit8
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

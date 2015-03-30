; ModuleID = '../kernel-src/BinomialOption_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @binomial_options(i32 %numSteps, <4 x float> addrspace(1)* nocapture readonly %randArray, <4 x float> addrspace(1)* nocapture %output, <4 x float> addrspace(3)* nocapture %callA, <4 x float> addrspace(3)* nocapture %callB) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #4
  %call1 = tail call i32 @get_group_id(i32 0) #4
  %0 = sext i32 %call1 to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i64 %0
  %1 = load <4 x float> addrspace(1)* %arrayidx, align 16, !tbaa !2
  %sub = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %1
  %mul2 = fmul <4 x float> %1, <float 3.000000e+01, float 3.000000e+01, float 3.000000e+01, float 3.000000e+01>
  %2 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %sub, <4 x float> <float 5.000000e+00, float 5.000000e+00, float 5.000000e+00, float 5.000000e+00>, <4 x float> %mul2)
  %mul4 = fmul <4 x float> %1, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %3 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %sub, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %mul4)
  %mul6 = fmul <4 x float> %1, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %4 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %sub, <4 x float> <float 2.500000e-01, float 2.500000e-01, float 2.500000e-01, float 2.500000e-01>, <4 x float> %mul6)
  %conv = sitofp i32 %numSteps to float
  %div = fdiv float 1.000000e+00, %conv, !fpmath !5
  %splat.splatinsert = insertelement <4 x float> undef, float %div, i32 0
  %splat.splat = shufflevector <4 x float> %splat.splatinsert, <4 x float> undef, <4 x i32> zeroinitializer
  %mul = fmul <4 x float> %4, %splat.splat
  %call7 = tail call <4 x float> @llvm.sqrt.v4f32(<4 x float> %mul)
  %mul8 = fmul <4 x float> %call7, <float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000>
  %mul9 = fmul <4 x float> %mul, <float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000>
  %call10 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %mul9) #4
  %div11 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %call10, !fpmath !5
  %call12 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %mul8) #4
  %div13 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %call12, !fpmath !5
  %sub14 = fsub <4 x float> %call10, %div13
  %sub15 = fsub <4 x float> %call12, %div13
  %div16 = fdiv <4 x float> %sub14, %sub15, !fpmath !5
  %sub17 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %div16
  %mul18 = fmul <4 x float> %div11, %div16
  %mul19 = fmul <4 x float> %div11, %sub17
  %conv20 = uitofp i32 %call to float
  %neg = fsub float -0.000000e+00, %conv
  %5 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %conv20, float %neg)
  %splat.splatinsert23 = insertelement <4 x float> undef, float %5, i32 0
  %splat.splat24 = shufflevector <4 x float> %splat.splatinsert23, <4 x float> undef, <4 x i32> zeroinitializer
  %mul25 = fmul <4 x float> %mul8, %splat.splat24
  %call26 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %mul25) #4
  %neg28 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %3
  %6 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %2, <4 x float> %call26, <4 x float> %neg28)
  %7 = extractelement <4 x float> %6, i32 0
  %cmp = fcmp ogt float %7, 0.000000e+00
  %cond = select i1 %cmp, float %7, float 0.000000e+00
  %arrayidx30 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %call
  %8 = insertelement <4 x float> undef, float %cond, i32 0
  %9 = extractelement <4 x float> %6, i32 1
  %cmp31 = fcmp ogt float %9, 0.000000e+00
  %cond36 = select i1 %cmp31, float %9, float 0.000000e+00
  %10 = insertelement <4 x float> %8, float %cond36, i32 1
  %11 = extractelement <4 x float> %6, i32 2
  %cmp38 = fcmp ogt float %11, 0.000000e+00
  %cond43 = select i1 %cmp38, float %11, float 0.000000e+00
  %12 = insertelement <4 x float> %10, float %cond43, i32 2
  %13 = extractelement <4 x float> %6, i32 3
  %cmp45 = fcmp ogt float %13, 0.000000e+00
  %cond50 = select i1 %cmp45, float %13, float 0.000000e+00
  %14 = insertelement <4 x float> %12, float %cond50, i32 3
  store <4 x float> %14, <4 x float> addrspace(3)* %arrayidx30, align 16
  tail call void @barrier(i32 1) #4
  %cmp52127 = icmp sgt i32 %numSteps, 0
  br i1 %cmp52127, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %add = add i32 %call, 1
  %arrayidx58 = getelementptr inbounds <4 x float> addrspace(3)* %callA, i32 %add
  %arrayidx60 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %call
  %arrayidx68 = getelementptr inbounds <4 x float> addrspace(3)* %callB, i32 %add
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %if.end71
  %j.0128 = phi i32 [ %numSteps, %for.body.lr.ph ], [ %sub72, %if.end71 ]
  %cmp54 = icmp ult i32 %call, %j.0128
  br i1 %cmp54, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %15 = load <4 x float> addrspace(3)* %arrayidx30, align 16, !tbaa !2
  %16 = load <4 x float> addrspace(3)* %arrayidx58, align 16, !tbaa !2
  %mul59 = fmul <4 x float> %mul19, %16
  %17 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %mul18, <4 x float> %15, <4 x float> %mul59)
  store <4 x float> %17, <4 x float> addrspace(3)* %arrayidx60, align 16, !tbaa !2
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  tail call void @barrier(i32 1) #4
  %sub61 = add nsw i32 %j.0128, -1
  %cmp62 = icmp ult i32 %call, %sub61
  br i1 %cmp62, label %if.then64, label %if.end71

if.then64:                                        ; preds = %if.end
  %18 = load <4 x float> addrspace(3)* %arrayidx60, align 16, !tbaa !2
  %19 = load <4 x float> addrspace(3)* %arrayidx68, align 16, !tbaa !2
  %mul69 = fmul <4 x float> %mul19, %19
  %20 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %mul18, <4 x float> %18, <4 x float> %mul69)
  store <4 x float> %20, <4 x float> addrspace(3)* %arrayidx30, align 16, !tbaa !2
  br label %if.end71

if.end71:                                         ; preds = %if.then64, %if.end
  tail call void @barrier(i32 1) #4
  %sub72 = add nsw i32 %j.0128, -2
  %cmp52 = icmp sgt i32 %sub72, 0
  br i1 %cmp52, label %for.body, label %for.end

for.end:                                          ; preds = %if.end71, %entry
  %cmp73 = icmp eq i32 %call, 0
  br i1 %cmp73, label %if.then75, label %if.end78

if.then75:                                        ; preds = %for.end
  %21 = load <4 x float> addrspace(3)* %callA, align 16, !tbaa !2
  %arrayidx77 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %0
  store <4 x float> %21, <4 x float> addrspace(1)* %arrayidx77, align 16, !tbaa !2
  br label %if.end78

if.end78:                                         ; preds = %if.then75, %for.end
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #3

declare <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*, <4 x float> addrspace(3)*)* @binomial_options}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

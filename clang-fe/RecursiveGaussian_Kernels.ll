; ModuleID = '../kernel-src/RecursiveGaussian_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @transpose_kernel(<4 x i8> addrspace(1)* nocapture %output, <4 x i8> addrspace(1)* nocapture readonly %input, <4 x i8> addrspace(3)* nocapture %block, i32 %width, i32 %height, i32 %blockSize) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %call2 = tail call i32 @get_local_id(i32 0) #3
  %call3 = tail call i32 @get_local_id(i32 1) #3
  %mul = mul i32 %call1, %width
  %add = add i32 %mul, %call
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %0
  %1 = load <4 x i8> addrspace(1)* %arrayidx, align 4, !tbaa !3
  %mul4 = mul i32 %call3, %blockSize
  %add5 = add i32 %mul4, %call2
  %arrayidx6 = getelementptr inbounds <4 x i8> addrspace(3)* %block, i32 %add5
  store <4 x i8> %1, <4 x i8> addrspace(3)* %arrayidx6, align 4, !tbaa !3
  tail call void @barrier(i32 1) #3
  %mul9 = mul i32 %call, %height
  %add10 = add i32 %call1, %mul9
  %2 = load <4 x i8> addrspace(3)* %arrayidx6, align 4, !tbaa !3
  %3 = sext i32 %add10 to i64
  %arrayidx12 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %3
  store <4 x i8> %2, <4 x i8> addrspace(1)* %arrayidx12, align 4, !tbaa !3
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @RecursiveGaussian_kernel(<4 x i8> addrspace(1)* nocapture readonly %input, <4 x i8> addrspace(1)* nocapture %output, i32 %width, i32 %height, float %a0, float %a1, float %a2, float %a3, float %b1, float %b2, float %coefp, float %coefn) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %cmp = icmp ult i32 %call, %width
  br i1 %cmp, label %for.cond.preheader, label %for.end94

for.cond.preheader:                               ; preds = %entry
  %cmp1149 = icmp sgt i32 %height, 0
  br i1 %cmp1149, label %for.body.lr.ph, label %for.end.thread

for.end.thread:                                   ; preds = %for.cond.preheader
  tail call void @barrier(i32 2) #3
  br label %for.end94

for.body.lr.ph:                                   ; preds = %for.cond.preheader
  %splat.splatinsert = insertelement <4 x float> undef, float %a0, i32 0
  %splat.splat = shufflevector <4 x float> %splat.splatinsert, <4 x float> undef, <4 x i32> zeroinitializer
  %splat.splatinsert12 = insertelement <4 x float> undef, float %a1, i32 0
  %splat.splat13 = shufflevector <4 x float> %splat.splatinsert12, <4 x float> undef, <4 x i32> zeroinitializer
  %splat.splatinsert15 = insertelement <4 x float> undef, float %b1, i32 0
  %splat.splat16 = shufflevector <4 x float> %splat.splatinsert15, <4 x float> undef, <4 x i32> zeroinitializer
  %neg = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat16
  %splat.splatinsert18 = insertelement <4 x float> undef, float %b2, i32 0
  %splat.splat19 = shufflevector <4 x float> %splat.splatinsert18, <4 x float> undef, <4 x i32> zeroinitializer
  %neg21 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat19
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %indvars.iv154 = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next155, %for.body ]
  %xp.0153 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %vecinit10, %for.body ]
  %yp.0152 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %9, %for.body ]
  %yb.0151 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %yp.0152, %for.body ]
  %0 = trunc i64 %indvars.iv154 to i32
  %mul = mul nsw i32 %0, %width
  %add = add i32 %mul, %call
  %1 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %1
  %2 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %3 = extractelement <4 x i8> %2, i32 0
  %conv = uitofp i8 %3 to float
  %vecinit = insertelement <4 x float> undef, float %conv, i32 0
  %4 = extractelement <4 x i8> %2, i32 1
  %conv3 = uitofp i8 %4 to float
  %vecinit4 = insertelement <4 x float> %vecinit, float %conv3, i32 1
  %5 = extractelement <4 x i8> %2, i32 2
  %conv6 = uitofp i8 %5 to float
  %vecinit7 = insertelement <4 x float> %vecinit4, float %conv6, i32 2
  %6 = extractelement <4 x i8> %2, i32 3
  %conv9 = uitofp i8 %6 to float
  %vecinit10 = insertelement <4 x float> %vecinit7, float %conv9, i32 3
  %mul14 = fmul <4 x float> %splat.splat13, %xp.0153
  %7 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %splat.splat, <4 x float> %vecinit10, <4 x float> %mul14)
  %8 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg, <4 x float> %yp.0152, <4 x float> %7)
  %9 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg21, <4 x float> %yb.0151, <4 x float> %8)
  %10 = extractelement <4 x float> %9, i32 0
  %conv23 = fptoui float %10 to i8
  %vecinit24 = insertelement <4 x i8> undef, i8 %conv23, i32 0
  %11 = extractelement <4 x float> %9, i32 1
  %conv25 = fptoui float %11 to i8
  %vecinit26 = insertelement <4 x i8> %vecinit24, i8 %conv25, i32 1
  %12 = extractelement <4 x float> %9, i32 2
  %conv27 = fptoui float %12 to i8
  %vecinit28 = insertelement <4 x i8> %vecinit26, i8 %conv27, i32 2
  %13 = extractelement <4 x float> %9, i32 3
  %conv29 = fptoui float %13 to i8
  %vecinit30 = insertelement <4 x i8> %vecinit28, i8 %conv29, i32 3
  %arrayidx31 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %1
  store <4 x i8> %vecinit30, <4 x i8> addrspace(1)* %arrayidx31, align 4, !tbaa !3
  %indvars.iv.next155 = add nuw nsw i64 %indvars.iv154, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next155 to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %height
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  tail call void @barrier(i32 2) #3
  br i1 %cmp1149, label %for.body36.lr.ph, label %for.end94

for.body36.lr.ph:                                 ; preds = %for.end
  %splat.splatinsert55 = insertelement <4 x float> undef, float %a2, i32 0
  %splat.splat56 = shufflevector <4 x float> %splat.splatinsert55, <4 x float> undef, <4 x i32> zeroinitializer
  %splat.splatinsert58 = insertelement <4 x float> undef, float %a3, i32 0
  %splat.splat59 = shufflevector <4 x float> %splat.splatinsert58, <4 x float> undef, <4 x i32> zeroinitializer
  %splat.splatinsert61 = insertelement <4 x float> undef, float %b1, i32 0
  %splat.splat62 = shufflevector <4 x float> %splat.splatinsert61, <4 x float> undef, <4 x i32> zeroinitializer
  %neg64 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat62
  %splat.splatinsert65 = insertelement <4 x float> undef, float %b2, i32 0
  %splat.splat66 = shufflevector <4 x float> %splat.splatinsert65, <4 x float> undef, <4 x i32> zeroinitializer
  %neg68 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat66
  %14 = sext i32 %height to i64
  br label %for.body36

for.body36:                                       ; preds = %for.body36.lr.ph, %for.body36
  %indvars.iv = phi i64 [ %14, %for.body36.lr.ph ], [ %indvars.iv.next, %for.body36 ]
  %xn.0147 = phi <4 x float> [ zeroinitializer, %for.body36.lr.ph ], [ %vecinit53, %for.body36 ]
  %xa.0146 = phi <4 x float> [ zeroinitializer, %for.body36.lr.ph ], [ %xn.0147, %for.body36 ]
  %yn.0145 = phi <4 x float> [ zeroinitializer, %for.body36.lr.ph ], [ %24, %for.body36 ]
  %ya.0144 = phi <4 x float> [ zeroinitializer, %for.body36.lr.ph ], [ %yn.0145, %for.body36 ]
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  %15 = trunc i64 %indvars.iv.next to i32
  %mul38 = mul nsw i32 %15, %width
  %add39 = add i32 %mul38, %call
  %16 = sext i32 %add39 to i64
  %arrayidx42 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %16
  %17 = load <4 x i8> addrspace(1)* %arrayidx42, align 4
  %18 = extractelement <4 x i8> %17, i32 0
  %conv43 = uitofp i8 %18 to float
  %vecinit44 = insertelement <4 x float> undef, float %conv43, i32 0
  %19 = extractelement <4 x i8> %17, i32 1
  %conv46 = uitofp i8 %19 to float
  %vecinit47 = insertelement <4 x float> %vecinit44, float %conv46, i32 1
  %20 = extractelement <4 x i8> %17, i32 2
  %conv49 = uitofp i8 %20 to float
  %vecinit50 = insertelement <4 x float> %vecinit47, float %conv49, i32 2
  %21 = extractelement <4 x i8> %17, i32 3
  %conv52 = uitofp i8 %21 to float
  %vecinit53 = insertelement <4 x float> %vecinit50, float %conv52, i32 3
  %mul60 = fmul <4 x float> %splat.splat59, %xa.0146
  %22 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %splat.splat56, <4 x float> %xn.0147, <4 x float> %mul60)
  %23 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg64, <4 x float> %yn.0145, <4 x float> %22)
  %24 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg68, <4 x float> %ya.0144, <4 x float> %23)
  %arrayidx70 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i64 %16
  %25 = load <4 x i8> addrspace(1)* %arrayidx70, align 4
  %26 = extractelement <4 x i8> %25, i32 0
  %conv71 = uitofp i8 %26 to float
  %vecinit72 = insertelement <4 x float> undef, float %conv71, i32 0
  %27 = extractelement <4 x i8> %25, i32 1
  %conv74 = uitofp i8 %27 to float
  %vecinit75 = insertelement <4 x float> %vecinit72, float %conv74, i32 1
  %28 = extractelement <4 x i8> %25, i32 2
  %conv77 = uitofp i8 %28 to float
  %vecinit78 = insertelement <4 x float> %vecinit75, float %conv77, i32 2
  %29 = extractelement <4 x i8> %25, i32 3
  %conv80 = uitofp i8 %29 to float
  %vecinit81 = insertelement <4 x float> %vecinit78, float %conv80, i32 3
  %add82 = fadd <4 x float> %24, %vecinit81
  %30 = extractelement <4 x float> %add82, i32 0
  %conv84 = fptoui float %30 to i8
  %vecinit85 = insertelement <4 x i8> undef, i8 %conv84, i32 0
  %31 = extractelement <4 x float> %add82, i32 1
  %conv86 = fptoui float %31 to i8
  %vecinit87 = insertelement <4 x i8> %vecinit85, i8 %conv86, i32 1
  %32 = extractelement <4 x float> %add82, i32 2
  %conv88 = fptoui float %32 to i8
  %vecinit89 = insertelement <4 x i8> %vecinit87, i8 %conv88, i32 2
  %33 = extractelement <4 x float> %add82, i32 3
  %conv90 = fptoui float %33 to i8
  %vecinit91 = insertelement <4 x i8> %vecinit89, i8 %conv90, i32 3
  store <4 x i8> %vecinit91, <4 x i8> addrspace(1)* %arrayidx70, align 4, !tbaa !3
  %cmp34 = icmp sgt i32 %15, 0
  br i1 %cmp34, label %for.body36, label %for.end94

for.end94:                                        ; preds = %for.end, %for.end.thread, %for.body36, %entry
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, <4 x i8> addrspace(3)*, i32, i32, i32)* @transpose_kernel}
!1 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, i32, float, float, float, float, float, float, float, float)* @RecursiveGaussian_kernel}
!2 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/SimpleConvolution_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @simpleConvolution(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture readonly %mask, <2 x i32> %inputDimensions, <2 x i32> %maskDimensions) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %0 = extractelement <2 x i32> %inputDimensions, i32 0
  %1 = extractelement <2 x i32> %inputDimensions, i32 1
  %rem = urem i32 %call, %0
  %div = udiv i32 %call, %0
  %2 = extractelement <2 x i32> %maskDimensions, i32 0
  %3 = extractelement <2 x i32> %maskDimensions, i32 1
  %sub = add i32 %2, -1
  %div1 = lshr i32 %sub, 1
  %sub2 = add i32 %3, -1
  %div3 = lshr i32 %sub2, 1
  %cmp = icmp ult i32 %rem, %div1
  %sub4 = sub i32 %rem, %div1
  %.sub4 = select i1 %cmp, i32 0, i32 %sub4
  %add = add i32 %rem, %div1
  %cmp5 = icmp ult i32 %add, %0
  %sub7 = add i32 %0, -1
  %cond11 = select i1 %cmp5, i32 %add, i32 %sub7
  %cmp12 = icmp ult i32 %div, %div3
  %sub15 = sub i32 %div, %div3
  %.sub15 = select i1 %cmp12, i32 0, i32 %sub15
  %add18 = add i32 %div, %div3
  %cmp19 = icmp ult i32 %add18, %1
  %sub21 = add i32 %1, -1
  %cond25 = select i1 %cmp19, i32 %add18, i32 %sub21
  %cmp2685 = icmp ugt i32 %.sub4, %cond11
  br i1 %cmp2685, label %for.end42, label %for.cond27.preheader.lr.ph

for.cond27.preheader.lr.ph:                       ; preds = %entry
  %cmp2882 = icmp ugt i32 %.sub15, %cond25
  %sub3080 = sub i32 %div3, %div
  %sub3281 = sub i32 %div1, %rem
  br label %for.cond27.preheader

for.cond27.preheader:                             ; preds = %for.cond27.preheader.lr.ph, %for.inc40
  %sumFX.087 = phi float [ 0.000000e+00, %for.cond27.preheader.lr.ph ], [ %sumFX.1.lcssa, %for.inc40 ]
  %i.086 = phi i32 [ %.sub4, %for.cond27.preheader.lr.ph ], [ %inc41, %for.inc40 ]
  br i1 %cmp2882, label %for.inc40, label %for.body29.lr.ph

for.body29.lr.ph:                                 ; preds = %for.cond27.preheader
  %sub33 = add i32 %sub3281, %i.086
  br label %for.body29

for.body29:                                       ; preds = %for.body29.lr.ph, %for.body29
  %sumFX.184 = phi float [ %sumFX.087, %for.body29.lr.ph ], [ %add39, %for.body29 ]
  %j.083 = phi i32 [ %.sub15, %for.body29.lr.ph ], [ %inc, %for.body29 ]
  %sub31 = add i32 %sub3080, %j.083
  %mul = mul i32 %sub31, %2
  %add34 = add i32 %sub33, %mul
  %mul35 = mul i32 %j.083, %0
  %add36 = add i32 %mul35, %i.086
  %4 = sext i32 %add36 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %4
  %5 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !2
  %conv = uitofp i32 %5 to float
  %6 = sext i32 %add34 to i64
  %arrayidx37 = getelementptr inbounds float addrspace(1)* %mask, i64 %6
  %7 = load float addrspace(1)* %arrayidx37, align 4, !tbaa !6
  %mul38 = fmul float %conv, %7
  %add39 = fadd float %sumFX.184, %mul38
  %inc = add i32 %j.083, 1
  %cmp28 = icmp ugt i32 %inc, %cond25
  br i1 %cmp28, label %for.inc40, label %for.body29

for.inc40:                                        ; preds = %for.body29, %for.cond27.preheader
  %sumFX.1.lcssa = phi float [ %sumFX.087, %for.cond27.preheader ], [ %add39, %for.body29 ]
  %inc41 = add i32 %i.086, 1
  %cmp26 = icmp ugt i32 %inc41, %cond11
  br i1 %cmp26, label %for.end42, label %for.cond27.preheader

for.end42:                                        ; preds = %for.inc40, %entry
  %sumFX.0.lcssa = phi float [ 0.000000e+00, %entry ], [ %sumFX.1.lcssa, %for.inc40 ]
  %add43 = fadd float %sumFX.0.lcssa, 5.000000e-01
  %conv44 = fptoui float %add43 to i32
  %8 = sext i32 %call to i64
  %arrayidx45 = getelementptr inbounds i32 addrspace(1)* %output, i64 %8
  store i32 %conv44, i32 addrspace(1)* %arrayidx45, align 4, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, float addrspace(1)*, <2 x i32>, <2 x i32>)* @simpleConvolution}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"float", metadata !4, i64 0}

; ModuleID = '../kernel-src/NBody_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @nbody_sim(<4 x float> addrspace(1)* nocapture readonly %pos, <4 x float> addrspace(1)* nocapture readonly %vel, i32 %numBodies, float %deltaTime, float %epsSqr, <4 x float> addrspace(1)* nocapture %newPosition, <4 x float> addrspace(1)* nocapture %newVelocity) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #4
  %0 = sext i32 %call to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %pos, i64 %0
  %1 = load <4 x float> addrspace(1)* %arrayidx, align 16, !tbaa !2
  %cmp113 = icmp sgt i32 %numBodies, 8
  br i1 %cmp113, label %for.cond1.preheader.lr.ph, label %for.cond14.preheader

for.cond1.preheader.lr.ph:                        ; preds = %entry
  %2 = shufflevector <4 x float> %1, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  br label %for.cond1.preheader

for.cond.loopexit:                                ; preds = %for.body3
  %3 = add i32 %i.0114, 8
  %add = add nsw i32 %indvars.iv121, 9
  %cmp = icmp slt i32 %add, %numBodies
  %indvars.iv.next122 = add i32 %indvars.iv121, 8
  %indvars.iv.next124 = add i32 %indvars.iv123, 8
  br i1 %cmp, label %for.cond1.preheader, label %for.cond14.preheader

for.cond1.preheader:                              ; preds = %for.cond1.preheader.lr.ph, %for.cond.loopexit
  %indvars.iv123 = phi i32 [ 8, %for.cond1.preheader.lr.ph ], [ %indvars.iv.next124, %for.cond.loopexit ]
  %indvars.iv121 = phi i32 [ 7, %for.cond1.preheader.lr.ph ], [ %indvars.iv.next122, %for.cond.loopexit ]
  %acc.0115 = phi <4 x float> [ zeroinitializer, %for.cond1.preheader.lr.ph ], [ %17, %for.cond.loopexit ]
  %i.0114 = phi i32 [ 0, %for.cond1.preheader.lr.ph ], [ %3, %for.cond.loopexit ]
  %4 = sext i32 %i.0114 to i64
  br label %for.body3

for.cond14.preheader:                             ; preds = %for.cond.loopexit, %entry
  %acc.0.lcssa = phi <4 x float> [ zeroinitializer, %entry ], [ %17, %for.cond.loopexit ]
  %i.0.lcssa = phi i32 [ 0, %entry ], [ %3, %for.cond.loopexit ]
  %cmp15107 = icmp slt i32 %i.0.lcssa, %numBodies
  %5 = shufflevector <4 x float> %1, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  br i1 %cmp15107, label %for.body16.lr.ph, label %for.end40

for.body16.lr.ph:                                 ; preds = %for.cond14.preheader
  %6 = sext i32 %i.0.lcssa to i64
  br label %for.body16

for.body3:                                        ; preds = %for.body3, %for.cond1.preheader
  %indvars.iv119 = phi i64 [ %4, %for.cond1.preheader ], [ %indvars.iv.next120, %for.body3 ]
  %acc.1112 = phi <4 x float> [ %acc.0115, %for.cond1.preheader ], [ %17, %for.body3 ]
  %arrayidx4 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i64 %indvars.iv119
  %7 = load <4 x float> addrspace(1)* %arrayidx4, align 16, !tbaa !2
  %8 = shufflevector <4 x float> %7, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %sub = fsub <3 x float> %8, %2
  %9 = extractelement <3 x float> %sub, i32 0
  %10 = extractelement <3 x float> %sub, i32 1
  %mul5 = fmul float %10, %10
  %11 = tail call float @llvm.fmuladd.f32(float %9, float %9, float %mul5)
  %12 = extractelement <3 x float> %sub, i32 2
  %13 = tail call float @llvm.fmuladd.f32(float %12, float %12, float %11)
  %add6 = fadd float %13, %epsSqr
  %call7 = tail call float @llvm.sqrt.f32(float %add6)
  %div = fdiv float 1.000000e+00, %call7, !fpmath !5
  %mul = fmul float %div, %div
  %mul8 = fmul float %div, %mul
  %14 = extractelement <4 x float> %7, i32 3
  %mul9 = fmul float %14, %mul8
  %splat.splatinsert = insertelement <3 x float> undef, float %mul9, i32 0
  %splat.splat = shufflevector <3 x float> %splat.splatinsert, <3 x float> undef, <3 x i32> zeroinitializer
  %mul10 = fmul <3 x float> %sub, %splat.splat
  %15 = shufflevector <4 x float> %acc.1112, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add11 = fadd <3 x float> %15, %mul10
  %16 = shufflevector <3 x float> %add11, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %17 = shufflevector <4 x float> %acc.1112, <4 x float> %16, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %indvars.iv.next120 = add nsw i64 %indvars.iv119, 1
  %lftr.wideiv125 = trunc i64 %indvars.iv.next120 to i32
  %exitcond126 = icmp eq i32 %lftr.wideiv125, %indvars.iv123
  br i1 %exitcond126, label %for.cond.loopexit, label %for.body3

for.body16:                                       ; preds = %for.body16, %for.body16.lr.ph
  %indvars.iv = phi i64 [ %6, %for.body16.lr.ph ], [ %indvars.iv.next, %for.body16 ]
  %acc.2109 = phi <4 x float> [ %acc.0.lcssa, %for.body16.lr.ph ], [ %28, %for.body16 ]
  %arrayidx18 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i64 %indvars.iv
  %18 = load <4 x float> addrspace(1)* %arrayidx18, align 16, !tbaa !2
  %19 = shufflevector <4 x float> %18, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %sub20 = fsub <3 x float> %19, %5
  %20 = extractelement <3 x float> %sub20, i32 0
  %21 = extractelement <3 x float> %sub20, i32 1
  %mul23 = fmul float %21, %21
  %22 = tail call float @llvm.fmuladd.f32(float %20, float %20, float %mul23)
  %23 = extractelement <3 x float> %sub20, i32 2
  %24 = tail call float @llvm.fmuladd.f32(float %23, float %23, float %22)
  %add26 = fadd float %24, %epsSqr
  %call27 = tail call float @llvm.sqrt.f32(float %add26)
  %div28 = fdiv float 1.000000e+00, %call27, !fpmath !5
  %mul30 = fmul float %div28, %div28
  %mul31 = fmul float %div28, %mul30
  %25 = extractelement <4 x float> %18, i32 3
  %mul33 = fmul float %25, %mul31
  %splat.splatinsert34 = insertelement <3 x float> undef, float %mul33, i32 0
  %splat.splat35 = shufflevector <3 x float> %splat.splatinsert34, <3 x float> undef, <3 x i32> zeroinitializer
  %mul36 = fmul <3 x float> %sub20, %splat.splat35
  %26 = shufflevector <4 x float> %acc.2109, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add37 = fadd <3 x float> %26, %mul36
  %27 = shufflevector <3 x float> %add37, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %28 = shufflevector <4 x float> %acc.2109, <4 x float> %27, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %numBodies
  br i1 %exitcond, label %for.end40, label %for.body16

for.end40:                                        ; preds = %for.cond14.preheader, %for.body16
  %acc.2.lcssa = phi <4 x float> [ %28, %for.body16 ], [ %acc.0.lcssa, %for.cond14.preheader ]
  %arrayidx41 = getelementptr inbounds <4 x float> addrspace(1)* %vel, i64 %0
  %29 = load <4 x float> addrspace(1)* %arrayidx41, align 16, !tbaa !2
  %30 = shufflevector <4 x float> %29, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %splat.splatinsert42 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %splat.splat43 = shufflevector <3 x float> %splat.splatinsert42, <3 x float> undef, <3 x i32> zeroinitializer
  %31 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %30, <3 x float> %splat.splat43, <3 x float> %5)
  %32 = shufflevector <4 x float> %acc.2.lcssa, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul45 = fmul <3 x float> %32, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %mul48 = fmul <3 x float> %splat.splat43, %mul45
  %33 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %mul48, <3 x float> %splat.splat43, <3 x float> %31)
  %34 = shufflevector <3 x float> %33, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %35 = shufflevector <4 x float> %34, <4 x float> %1, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %36 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %32, <3 x float> %splat.splat43, <3 x float> %30)
  %37 = shufflevector <3 x float> %36, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %38 = shufflevector <4 x float> %37, <4 x float> %29, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %arrayidx55 = getelementptr inbounds <4 x float> addrspace(1)* %newPosition, i64 %0
  store <4 x float> %35, <4 x float> addrspace(1)* %arrayidx55, align 16, !tbaa !2
  %arrayidx56 = getelementptr inbounds <4 x float> addrspace(1)* %newVelocity, i64 %0
  store <4 x float> %38, <4 x float> addrspace(1)* %arrayidx56, align 16, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #3

; Function Attrs: nounwind readnone
declare <3 x float> @llvm.fmuladd.v3f32(<3 x float>, <3 x float>, <3 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, float, float, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @nbody_sim}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

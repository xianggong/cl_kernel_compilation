; ModuleID = '../kernel-src/MemoryOptimizations_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @copy1DFastPath(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %0 = sext i32 %call to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !10
  %arrayidx1 = getelementptr inbounds float addrspace(1)* %output, i64 %0
  store float %1, float addrspace(1)* %arrayidx1, align 4, !tbaa !10
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind
define void @copy1DCompletePath(float addrspace(1)* nocapture readonly %input, float addrspace(1)* %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %cmp = icmp slt i32 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = bitcast float addrspace(1)* %output to i32 addrspace(1)*
  %call1 = tail call i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)* %0, i32 1) #2
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %1 = sext i32 %call to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %1
  %2 = load float addrspace(1)* %arrayidx, align 4, !tbaa !10
  %arrayidx2 = getelementptr inbounds float addrspace(1)* %output, i64 %1
  store float %2, float addrspace(1)* %arrayidx2, align 4, !tbaa !10
  ret void
}

declare i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)*, i32) #1

; Function Attrs: nounwind
define void @copy2Dfloat(float addrspace(1)* nocapture readonly %A, float addrspace(1)* nocapture %C) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 1) #2
  %mul = shl i32 %call1, 10
  %add = add nsw i32 %mul, %call
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %A, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !10
  %arrayidx4 = getelementptr inbounds float addrspace(1)* %C, i64 %0
  store float %1, float addrspace(1)* %arrayidx4, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind
define void @copy2Dfloat4(<4 x float> addrspace(1)* nocapture readonly %A, <4 x float> addrspace(1)* nocapture %C) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 1) #2
  %mul = shl i32 %call1, 10
  %add = add nsw i32 %mul, %call
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %A, i64 %0
  %1 = load <4 x float> addrspace(1)* %arrayidx, align 16, !tbaa !14
  %arrayidx4 = getelementptr inbounds <4 x float> addrspace(1)* %C, i64 %0
  store <4 x float> %1, <4 x float> addrspace(1)* %arrayidx4, align 16, !tbaa !14
  ret void
}

; Function Attrs: nounwind
define void @copy1Dfloat4(<4 x float> addrspace(1)* nocapture readonly %input, <4 x float> addrspace(1)* nocapture %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %0 = sext i32 %call to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %0
  %1 = load <4 x float> addrspace(1)* %arrayidx, align 16, !tbaa !14
  %arrayidx1 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %0
  store <4 x float> %1, <4 x float> addrspace(1)* %arrayidx1, align 16, !tbaa !14
  ret void
}

; Function Attrs: nounwind
define void @NoCoal(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 0) #2
  %and = and i32 %call1, 15
  %cmp = icmp eq i32 %and, 0
  %add.sub.v = select i1 %cmp, i32 15, i32 -1
  %add.sub = add i32 %add.sub.v, %call
  %0 = sext i32 %add.sub to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !10
  %arrayidx2 = getelementptr inbounds float addrspace(1)* %output, i64 %0
  store float %1, float addrspace(1)* %arrayidx2, align 4, !tbaa !10
  ret void
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define void @Split(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %and = and i32 %call, 1
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call2 = tail call i32 @get_local_id(i32 0) #2
  %sub = sub i32 62, %call2
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %gid.0 = phi i32 [ %sub, %if.then ], [ %call, %entry ]
  %0 = sext i32 %gid.0 to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !10
  %arrayidx3 = getelementptr inbounds float addrspace(1)* %output, i64 %0
  store float %1, float addrspace(1)* %arrayidx3, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind
define void @localBankConflicts(float addrspace(3)* nocapture readonly %share, float addrspace(1)* nocapture %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 0) #2
  %mul = shl nsw i32 %call1, 5
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.025 = phi i32 [ 0, %entry ], [ %add11, %for.body ]
  %resultb.024 = phi i32 [ 0, %entry ], [ %conv10, %for.body ]
  %resulta.023 = phi i32 [ 0, %entry ], [ %conv3, %for.body ]
  %add = add nsw i32 %i.025, %mul
  %arrayidx = getelementptr inbounds float addrspace(3)* %share, i32 %add
  %0 = load float addrspace(3)* %arrayidx, align 4, !tbaa !10
  %conv = sitofp i32 %resulta.023 to float
  %add2 = fadd float %conv, %0
  %conv3 = fptosi float %add2 to i32
  %add622 = or i32 %add, 1
  %arrayidx7 = getelementptr inbounds float addrspace(3)* %share, i32 %add622
  %1 = load float addrspace(3)* %arrayidx7, align 4, !tbaa !10
  %conv8 = sitofp i32 %resultb.024 to float
  %add9 = fadd float %conv8, %1
  %conv10 = fptosi float %add9 to i32
  %add11 = add nsw i32 %i.025, 2
  %cmp = icmp slt i32 %add11, 128
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  %add12 = add nsw i32 %conv10, %conv3
  %conv13 = sitofp i32 %add12 to float
  %2 = sext i32 %call to i64
  %arrayidx14 = getelementptr inbounds float addrspace(1)* %output, i64 %2
  store float %conv13, float addrspace(1)* %arrayidx14, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind
define void @noLocalBankConflicts(float addrspace(3)* nocapture readonly %share, float addrspace(1)* nocapture %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 0) #2
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.024 = phi i32 [ 0, %entry ], [ %add10, %for.body ]
  %resultb.023 = phi i32 [ 0, %entry ], [ %conv9, %for.body ]
  %resulta.022 = phi i32 [ 0, %entry ], [ %conv3, %for.body ]
  %add = add nsw i32 %i.024, %call1
  %arrayidx = getelementptr inbounds float addrspace(3)* %share, i32 %add
  %0 = load float addrspace(3)* %arrayidx, align 4, !tbaa !10
  %conv = sitofp i32 %resulta.022 to float
  %add2 = fadd float %conv, %0
  %conv3 = fptosi float %add2 to i32
  %add421 = or i32 %i.024, 1
  %add5 = add nsw i32 %add421, %call1
  %arrayidx6 = getelementptr inbounds float addrspace(3)* %share, i32 %add5
  %1 = load float addrspace(3)* %arrayidx6, align 4, !tbaa !10
  %conv7 = sitofp i32 %resultb.023 to float
  %add8 = fadd float %conv7, %1
  %conv9 = fptosi float %add8 to i32
  %add10 = add nsw i32 %i.024, 2
  %cmp = icmp slt i32 %add10, 128
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  %add11 = add nsw i32 %conv9, %conv3
  %conv12 = sitofp i32 %add11 to float
  %2 = sext i32 %call to i64
  %arrayidx13 = getelementptr inbounds float addrspace(1)* %output, i64 %2
  store float %conv12, float addrspace(1)* %arrayidx13, align 4, !tbaa !10
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy1DFastPath}
!1 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy1DCompletePath}
!2 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy2Dfloat}
!3 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @copy2Dfloat4}
!4 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @copy1Dfloat4}
!5 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @NoCoal}
!6 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @Split}
!7 = metadata !{void (float addrspace(3)*, float addrspace(1)*)* @localBankConflicts}
!8 = metadata !{void (float addrspace(3)*, float addrspace(1)*)* @noLocalBankConflicts}
!9 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!10 = metadata !{metadata !11, metadata !11, i64 0}
!11 = metadata !{metadata !"float", metadata !12, i64 0}
!12 = metadata !{metadata !"omnipotent char", metadata !13, i64 0}
!13 = metadata !{metadata !"Simple C/C++ TBAA"}
!14 = metadata !{metadata !12, metadata !12, i64 0}

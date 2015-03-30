; ModuleID = '../kernel-src/BinarySearch_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @binarySearch(<4 x i32> addrspace(1)* nocapture %outputArray, i32 addrspace(1)* nocapture readonly %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %mul = mul i32 %call, %subdivSize
  %add = add i32 %mul, %globalLowerIndex
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %sortedArray, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !4
  %cmp = icmp ugt i32 %1, %findMe
  br i1 %cmp, label %if.end, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %add1 = add i32 %call, 1
  %mul2 = mul i32 %add1, %subdivSize
  %add3 = add i32 %globalLowerIndex, -1
  %sub = add i32 %add3, %mul2
  %2 = sext i32 %sub to i64
  %arrayidx4 = getelementptr inbounds i32 addrspace(1)* %sortedArray, i64 %2
  %3 = load i32 addrspace(1)* %arrayidx4, align 4, !tbaa !4
  %cmp5 = icmp ult i32 %3, %findMe
  br i1 %cmp5, label %if.end, label %if.else

if.else:                                          ; preds = %lor.lhs.false
  %4 = load <4 x i32> addrspace(1)* %outputArray, align 16
  %5 = insertelement <4 x i32> %4, i32 %call, i32 0
  %6 = insertelement <4 x i32> %5, i32 1, i32 3
  store <4 x i32> %6, <4 x i32> addrspace(1)* %outputArray, align 16
  br label %if.end

if.end:                                           ; preds = %entry, %lor.lhs.false, %if.else
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind
define void @binarySearch_mulkeys(i32 addrspace(1)* nocapture readonly %keys, i32 addrspace(1)* nocapture readonly %input, i32 %numKeys, i32 addrspace(1)* nocapture %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %mul = shl nsw i32 %call, 8
  %cmp16 = icmp eq i32 %numKeys, 0
  br i1 %cmp16, label %for.end, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %add15 = or i32 %mul, 255
  %0 = sext i32 %mul to i64
  %arrayidx1 = getelementptr inbounds i32 addrspace(1)* %input, i64 %0
  %1 = sext i32 %add15 to i64
  %arrayidx4 = getelementptr inbounds i32 addrspace(1)* %input, i64 %1
  br label %for.body

for.body:                                         ; preds = %for.inc, %for.body.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %keys, i64 %indvars.iv
  %2 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !4
  %3 = load i32 addrspace(1)* %arrayidx1, align 4, !tbaa !4
  %cmp2 = icmp ult i32 %2, %3
  br i1 %cmp2, label %for.inc, label %land.lhs.true

land.lhs.true:                                    ; preds = %for.body
  %4 = load i32 addrspace(1)* %arrayidx4, align 4, !tbaa !4
  %cmp5 = icmp ugt i32 %2, %4
  br i1 %cmp5, label %for.inc, label %if.then

if.then:                                          ; preds = %land.lhs.true
  %arrayidx6 = getelementptr inbounds i32 addrspace(1)* %output, i64 %indvars.iv
  store i32 %mul, i32 addrspace(1)* %arrayidx6, align 4, !tbaa !4
  br label %for.inc

for.inc:                                          ; preds = %land.lhs.true, %for.body, %if.then
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %numKeys
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.inc, %entry
  ret void
}

; Function Attrs: nounwind
define void @binarySearch_mulkeysConcurrent(i32 addrspace(1)* nocapture readonly %keys, i32 addrspace(1)* nocapture readonly %input, i32 %inputSize, i32 %numSubdivisions, i32 addrspace(1)* nocapture %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %rem = urem i32 %call, %numSubdivisions
  %div = udiv i32 %inputSize, %numSubdivisions
  %mul = mul i32 %div, %rem
  %add = add i32 %mul, %div
  %call2 = tail call i32 @get_global_id(i32 0) #2
  %div3 = udiv i32 %call2, %numSubdivisions
  %0 = sext i32 %div3 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %keys, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !4
  %cmp3234 = icmp slt i32 %add, %mul
  br i1 %cmp3234, label %while.end, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %entry, %if.then13
  %lBound.0.ph36 = phi i32 [ %lBound.033, %if.then13 ], [ %mul, %entry ]
  %uBound.0.ph35 = phi i32 [ %sub, %if.then13 ], [ %add, %entry ]
  br label %while.body

while.cond:                                       ; preds = %if.else
  %cmp = icmp slt i32 %uBound.0.ph35, %add15
  br i1 %cmp, label %while.end, label %while.body

while.body:                                       ; preds = %while.body.lr.ph, %while.cond
  %lBound.033 = phi i32 [ %lBound.0.ph36, %while.body.lr.ph ], [ %add15, %while.cond ]
  %add4 = add nsw i32 %lBound.033, %uBound.0.ph35
  %div5 = sdiv i32 %add4, 2
  %2 = sext i32 %div5 to i64
  %arrayidx6 = getelementptr inbounds i32 addrspace(1)* %input, i64 %2
  %3 = load i32 addrspace(1)* %arrayidx6, align 4, !tbaa !4
  %cmp7 = icmp eq i32 %3, %1
  br i1 %cmp7, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  %call8 = tail call i32 @get_global_id(i32 0) #2
  %div9 = udiv i32 %call8, %numSubdivisions
  %4 = sext i32 %div9 to i64
  %arrayidx10 = getelementptr inbounds i32 addrspace(1)* %output, i64 %4
  store i32 %div5, i32 addrspace(1)* %arrayidx10, align 4, !tbaa !4
  br label %while.end

if.else:                                          ; preds = %while.body
  %cmp12 = icmp ugt i32 %3, %1
  %add15 = add nsw i32 %div5, 1
  br i1 %cmp12, label %if.then13, label %while.cond

if.then13:                                        ; preds = %if.else
  %sub = add nsw i32 %div5, -1
  %cmp32 = icmp sgt i32 %div5, %lBound.033
  br i1 %cmp32, label %while.body.lr.ph, label %while.end

while.end:                                        ; preds = %while.cond, %if.then13, %entry, %if.then
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @binarySearch}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(1)*)* @binarySearch_mulkeys}
!2 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32, i32 addrspace(1)*)* @binarySearch_mulkeysConcurrent}
!3 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"int", metadata !6, i64 0}
!6 = metadata !{metadata !"omnipotent char", metadata !7, i64 0}
!7 = metadata !{metadata !"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/ConcurrentKernel_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@K2.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K4.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K6.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K8.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K10.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1

; Function Attrs: nounwind
define void @work1(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %zero = alloca i32, align 4
  %call = tail call i32 @get_global_size(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 0) #2
  %call2 = tail call i32 @get_local_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %for.body

for.cond27.preheader:                             ; preds = %for.body
  %cmp2863 = icmp ult i32 %call1, %bufferSize
  br i1 %cmp2863, label %for.body30, label %for.end41

for.body:                                         ; preds = %for.body, %entry
  %i.066 = phi i32 [ 1, %entry ], [ %inc, %for.body ]
  %tmp.065 = phi i32 [ 1, %entry ], [ %add24, %for.body ]
  %rem = urem i32 %i.066, %bufferSize
  %0 = sext i32 %rem to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %input, i64 %0
  %1 = load i8 addrspace(1)* %arrayidx, align 1, !tbaa !11
  %conv = zext i8 %1 to i32
  %mul5 = shl nsw i32 %i.066, 1
  %rem6 = urem i32 %mul5, %bufferSize
  %2 = sext i32 %rem6 to i64
  %arrayidx7 = getelementptr inbounds i8 addrspace(1)* %input, i64 %2
  %3 = load i8 addrspace(1)* %arrayidx7, align 1, !tbaa !11
  %conv8 = zext i8 %3 to i32
  %mul9 = mul nsw i32 %i.066, 3
  %rem10 = urem i32 %mul9, %bufferSize
  %4 = sext i32 %rem10 to i64
  %arrayidx11 = getelementptr inbounds i8 addrspace(1)* %input, i64 %4
  %5 = load i8 addrspace(1)* %arrayidx11, align 1, !tbaa !11
  %conv12 = zext i8 %5 to i32
  %mul14 = shl nsw i32 %i.066, 2
  %rem15 = urem i32 %mul14, %bufferSize
  %6 = sext i32 %rem15 to i64
  %arrayidx16 = getelementptr inbounds i8 addrspace(1)* %input, i64 %6
  %7 = load i8 addrspace(1)* %arrayidx16, align 1, !tbaa !11
  %conv17 = zext i8 %7 to i32
  %mul19 = mul nsw i32 %i.066, 5
  %rem20 = urem i32 %mul19, %bufferSize
  %8 = sext i32 %rem20 to i64
  %arrayidx21 = getelementptr inbounds i8 addrspace(1)* %input, i64 %8
  %9 = load i8 addrspace(1)* %arrayidx21, align 1, !tbaa !11
  %conv22 = zext i8 %9 to i32
  %add = add i32 %conv, %tmp.065
  %add13 = add i32 %add, %conv8
  %add18 = add i32 %add13, %conv12
  %add23 = add i32 %add18, %conv17
  %add24 = add i32 %add23, %conv22
  %inc = add nsw i32 %i.066, 1
  %exitcond = icmp eq i32 %inc, 5000
  br i1 %exitcond, label %for.cond27.preheader, label %for.body

for.body30:                                       ; preds = %for.cond27.preheader, %for.body30
  %i26.064 = phi i32 [ %add40, %for.body30 ], [ %call1, %for.cond27.preheader ]
  %10 = sext i32 %i26.064 to i64
  %arrayidx31 = getelementptr inbounds i8 addrspace(1)* %input, i64 %10
  %11 = load i8 addrspace(1)* %arrayidx31, align 1, !tbaa !11
  %conv32 = zext i8 %11 to i32
  %mul33 = mul nsw i32 %conv32, %multiplier
  %zero.0.load62 = load volatile i32* %zero, align 4
  %mul35 = mul i32 %zero.0.load62, %add24
  %add36 = add i32 %mul33, %mul35
  %conv37 = trunc i32 %add36 to i8
  %arrayidx38 = getelementptr inbounds i8 addrspace(1)* %output, i64 %10
  store i8 %conv37, i8 addrspace(1)* %arrayidx38, align 1, !tbaa !11
  %add40 = add i32 %i26.064, %call
  %cmp28 = icmp ult i32 %add40, %bufferSize
  br i1 %cmp28, label %for.body30, label %for.end41

for.end41:                                        ; preds = %for.body30, %for.cond27.preheader
  ret void
}

declare i32 @get_global_size(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define void @work2(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* nocapture %lds) #0 {
entry:
  %zero = alloca i32, align 4
  %call = tail call i32 @get_global_size(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 0) #2
  %call2 = tail call i32 @get_local_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %for.body

for.cond26.preheader:                             ; preds = %for.body
  %cmp2766 = icmp ult i32 %call1, %bufferSize
  br i1 %cmp2766, label %for.body29.lr.ph, label %for.end42

for.body29.lr.ph:                                 ; preds = %for.cond26.preheader
  %arrayidx31 = getelementptr inbounds i8 addrspace(3)* %lds, i32 %call2
  br label %for.body29

for.body:                                         ; preds = %for.body, %entry
  %i.069 = phi i32 [ 1, %entry ], [ %inc, %for.body ]
  %tmp.068 = phi i32 [ 1, %entry ], [ %add23, %for.body ]
  %mul = shl nsw i32 %i.069, 1
  %rem = urem i32 %mul, %bufferSize
  %0 = sext i32 %rem to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %input, i64 %0
  %1 = load i8 addrspace(1)* %arrayidx, align 1, !tbaa !11
  %conv = zext i8 %1 to i32
  %mul5 = shl nsw i32 %i.069, 2
  %rem6 = urem i32 %mul5, %bufferSize
  %2 = sext i32 %rem6 to i64
  %arrayidx7 = getelementptr inbounds i8 addrspace(1)* %input, i64 %2
  %3 = load i8 addrspace(1)* %arrayidx7, align 1, !tbaa !11
  %conv8 = zext i8 %3 to i32
  %mul9 = mul nsw i32 %i.069, 6
  %rem10 = urem i32 %mul9, %bufferSize
  %4 = sext i32 %rem10 to i64
  %arrayidx11 = getelementptr inbounds i8 addrspace(1)* %input, i64 %4
  %5 = load i8 addrspace(1)* %arrayidx11, align 1, !tbaa !11
  %conv12 = zext i8 %5 to i32
  %mul13 = shl nsw i32 %i.069, 3
  %rem14 = urem i32 %mul13, %bufferSize
  %6 = sext i32 %rem14 to i64
  %arrayidx15 = getelementptr inbounds i8 addrspace(1)* %input, i64 %6
  %7 = load i8 addrspace(1)* %arrayidx15, align 1, !tbaa !11
  %conv16 = zext i8 %7 to i32
  %mul18 = mul nsw i32 %i.069, 10
  %rem19 = urem i32 %mul18, %bufferSize
  %8 = sext i32 %rem19 to i64
  %arrayidx20 = getelementptr inbounds i8 addrspace(1)* %input, i64 %8
  %9 = load i8 addrspace(1)* %arrayidx20, align 1, !tbaa !11
  %conv21 = zext i8 %9 to i32
  %sub = add i32 %conv, %tmp.068
  %add = sub i32 %sub, %conv8
  %sub17 = add i32 %add, %conv12
  %add22 = sub i32 %sub17, %conv16
  %add23 = add i32 %add22, %conv21
  %inc = add nsw i32 %i.069, 1
  %exitcond = icmp eq i32 %inc, 10000
  br i1 %exitcond, label %for.cond26.preheader, label %for.body

for.body29:                                       ; preds = %for.body29.lr.ph, %for.body29
  %i25.067 = phi i32 [ %call1, %for.body29.lr.ph ], [ %add41, %for.body29 ]
  %10 = sext i32 %i25.067 to i64
  %arrayidx30 = getelementptr inbounds i8 addrspace(1)* %input, i64 %10
  %11 = load i8 addrspace(1)* %arrayidx30, align 1, !tbaa !11
  store i8 %11, i8 addrspace(3)* %arrayidx31, align 1, !tbaa !11
  %conv33 = zext i8 %11 to i32
  %mul34 = mul nsw i32 %conv33, %multiplier
  %zero.0.load65 = load volatile i32* %zero, align 4
  %mul36 = mul nsw i32 %zero.0.load65, %add23
  %add37 = add nsw i32 %mul34, %mul36
  %conv38 = trunc i32 %add37 to i8
  %arrayidx39 = getelementptr inbounds i8 addrspace(1)* %output, i64 %10
  store i8 %conv38, i8 addrspace(1)* %arrayidx39, align 1, !tbaa !11
  %add41 = add i32 %i25.067, %call
  %cmp27 = icmp ult i32 %add41, %bufferSize
  br i1 %cmp27, label %for.body29, label %for.end42

for.end42:                                        ; preds = %for.body29, %for.cond26.preheader
  ret void
}

; Function Attrs: nounwind
define void @K1(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  tail call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K2(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  tail call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K2.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K3(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  tail call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K4(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  tail call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K4.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K5(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  tail call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K6(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  tail call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K6.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K7(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  tail call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K8(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  tail call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K8.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K9(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  tail call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K10(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  tail call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K10.lds, i32 0, i32 0))
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9}
!llvm.ident = !{!10}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K1}
!1 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K2}
!2 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K3}
!3 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K4}
!4 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K5}
!5 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K6}
!6 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K7}
!7 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K8}
!8 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K9}
!9 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K10}
!10 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!11 = metadata !{metadata !12, metadata !12, i64 0}
!12 = metadata !{metadata !"omnipotent char", metadata !13, i64 0}
!13 = metadata !{metadata !"Simple C/C++ TBAA"}

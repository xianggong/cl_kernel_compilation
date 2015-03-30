; ModuleID = '../kernel-src/AsyncDataTransfer_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @work(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %multiplier) #0 {
entry:
  %zero = alloca i32, align 4
  %call = tail call i32 @get_global_size(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.051 = phi i32 [ 5, %entry ], [ %inc, %for.body ]
  %tmp.050 = phi i32 [ 1, %entry ], [ %add23, %for.body ]
  %rem = srem i32 %i.051, %call
  %0 = sext i32 %rem to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %input, i64 %0
  %1 = load i8 addrspace(1)* %arrayidx, align 1, !tbaa !2
  %conv = zext i8 %1 to i32
  %mul4 = shl nsw i32 %i.051, 1
  %rem5 = srem i32 %mul4, %call
  %2 = sext i32 %rem5 to i64
  %arrayidx6 = getelementptr inbounds i8 addrspace(1)* %input, i64 %2
  %3 = load i8 addrspace(1)* %arrayidx6, align 1, !tbaa !2
  %conv7 = zext i8 %3 to i32
  %mul8 = mul nsw i32 %i.051, 3
  %rem9 = srem i32 %mul8, %call
  %4 = sext i32 %rem9 to i64
  %arrayidx10 = getelementptr inbounds i8 addrspace(1)* %input, i64 %4
  %5 = load i8 addrspace(1)* %arrayidx10, align 1, !tbaa !2
  %conv11 = zext i8 %5 to i32
  %mul13 = shl nsw i32 %i.051, 2
  %rem14 = srem i32 %mul13, %call
  %6 = sext i32 %rem14 to i64
  %arrayidx15 = getelementptr inbounds i8 addrspace(1)* %input, i64 %6
  %7 = load i8 addrspace(1)* %arrayidx15, align 1, !tbaa !2
  %conv16 = zext i8 %7 to i32
  %mul18 = mul nsw i32 %i.051, 5
  %rem19 = srem i32 %mul18, %call
  %8 = sext i32 %rem19 to i64
  %arrayidx20 = getelementptr inbounds i8 addrspace(1)* %input, i64 %8
  %9 = load i8 addrspace(1)* %arrayidx20, align 1, !tbaa !2
  %conv21 = zext i8 %9 to i32
  %add = add i32 %conv, %tmp.050
  %add12 = add i32 %add, %conv7
  %add17 = add i32 %add12, %conv11
  %add22 = add i32 %add17, %conv16
  %add23 = add i32 %add22, %conv21
  %inc = add nsw i32 %i.051, 1
  %exitcond = icmp eq i32 %inc, 100
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  %10 = sext i32 %call1 to i64
  %arrayidx24 = getelementptr inbounds i8 addrspace(1)* %input, i64 %10
  %11 = load i8 addrspace(1)* %arrayidx24, align 1, !tbaa !2
  %conv25 = zext i8 %11 to i32
  %mul26 = mul nsw i32 %conv25, %multiplier
  %zero.0.load49 = load volatile i32* %zero, align 4
  %mul28 = mul i32 %zero.0.load49, %add23
  %add29 = add i32 %mul26, %mul28
  %conv30 = trunc i32 %add29 to i8
  %arrayidx31 = getelementptr inbounds i8 addrspace(1)* %output, i64 %10
  store i8 %conv30, i8 addrspace(1)* %arrayidx31, align 1, !tbaa !2
  ret void
}

declare i32 @get_global_size(i32) #1

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32)* @work}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

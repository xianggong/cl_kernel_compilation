; ModuleID = '../kernel-src/ScanLargeArrays_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@blockAddition.value.0 = internal addrspace(3) unnamed_addr global float 0.000000e+00

; Function Attrs: nounwind
define void @blockAddition(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_group_id(i32 0) #2
  %call2 = tail call i32 @get_local_id(i32 0) #2
  %cmp = icmp eq i32 %call2, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = sext i32 %call1 to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !4
  store float %1, float addrspace(3)* @blockAddition.value.0, align 4, !tbaa !4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @barrier(i32 1) #2
  %2 = load float addrspace(3)* @blockAddition.value.0, align 4, !tbaa !4
  %3 = sext i32 %call to i64
  %arrayidx3 = getelementptr inbounds float addrspace(1)* %output, i64 %3
  %4 = load float addrspace(1)* %arrayidx3, align 4, !tbaa !4
  %add = fadd float %2, %4
  store float %add, float addrspace(1)* %arrayidx3, align 4, !tbaa !4
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @ScanLargeArrays(float addrspace(1)* nocapture %output, float addrspace(1)* nocapture readonly %input, float addrspace(3)* nocapture %block, i32 %block_size, float addrspace(1)* nocapture %sumBuffer) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 0) #2
  %call2 = tail call i32 @get_group_id(i32 0) #2
  %mul = shl nsw i32 %call1, 1
  %0 = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !4
  %mul3 = shl nsw i32 %call, 1
  %arrayidx4 = getelementptr inbounds float addrspace(3)* %block, i32 %mul3
  store float %1, float addrspace(3)* %arrayidx4, align 4, !tbaa !4
  %add97 = or i32 %mul, 1
  %2 = sext i32 %add97 to i64
  %arrayidx6 = getelementptr inbounds float addrspace(1)* %input, i64 %2
  %3 = load float addrspace(1)* %arrayidx6, align 4, !tbaa !4
  %add898 = or i32 %mul3, 1
  %arrayidx9 = getelementptr inbounds float addrspace(3)* %block, i32 %add898
  store float %3, float addrspace(3)* %arrayidx9, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %4 = load float addrspace(3)* %block, align 4, !tbaa !4
  %cmp99 = icmp ugt i32 %block_size, 1
  br i1 %cmp99, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %arrayidx11 = getelementptr inbounds float addrspace(3)* %block, i32 1
  %5 = load float addrspace(3)* %arrayidx11, align 4, !tbaa !4
  %add12 = fadd float %4, %5
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %if.end
  %stride.0102 = phi i32 [ 1, %for.body.lr.ph ], [ %mul33, %if.end ]
  %cache1.0101 = phi float [ %add12, %for.body.lr.ph ], [ %cache1.1, %if.end ]
  %cache0.0100 = phi float [ %4, %for.body.lr.ph ], [ %cache0.1, %if.end ]
  %cmp14 = icmp slt i32 %mul3, %stride.0102
  br i1 %cmp14, label %if.end, label %if.then

if.then:                                          ; preds = %for.body
  %sub = sub nsw i32 %mul3, %stride.0102
  %arrayidx16 = getelementptr inbounds float addrspace(3)* %block, i32 %sub
  %6 = load float addrspace(3)* %arrayidx16, align 4, !tbaa !4
  %7 = load float addrspace(3)* %arrayidx4, align 4, !tbaa !4
  %add19 = fadd float %6, %7
  %sub22 = sub nsw i32 %add898, %stride.0102
  %arrayidx23 = getelementptr inbounds float addrspace(3)* %block, i32 %sub22
  %8 = load float addrspace(3)* %arrayidx23, align 4, !tbaa !4
  %9 = load float addrspace(3)* %arrayidx9, align 4, !tbaa !4
  %add27 = fadd float %8, %9
  br label %if.end

if.end:                                           ; preds = %for.body, %if.then
  %cache0.1 = phi float [ %add19, %if.then ], [ %cache0.0100, %for.body ]
  %cache1.1 = phi float [ %add27, %if.then ], [ %cache1.0101, %for.body ]
  tail call void @barrier(i32 1) #2
  store float %cache0.1, float addrspace(3)* %arrayidx4, align 4, !tbaa !4
  store float %cache1.1, float addrspace(3)* %arrayidx9, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %mul33 = shl nsw i32 %stride.0102, 1
  %cmp = icmp ult i32 %mul33, %block_size
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %if.end, %entry
  %sub34 = add i32 %block_size, -1
  %arrayidx35 = getelementptr inbounds float addrspace(3)* %block, i32 %sub34
  %10 = load float addrspace(3)* %arrayidx35, align 4, !tbaa !4
  %11 = sext i32 %call2 to i64
  %arrayidx36 = getelementptr inbounds float addrspace(1)* %sumBuffer, i64 %11
  store float %10, float addrspace(1)* %arrayidx36, align 4, !tbaa !4
  %cmp37 = icmp eq i32 %call, 0
  br i1 %cmp37, label %if.then38, label %if.else

if.then38:                                        ; preds = %for.end
  %arrayidx40 = getelementptr inbounds float addrspace(1)* %output, i64 %0
  store float 0.000000e+00, float addrspace(1)* %arrayidx40, align 4, !tbaa !4
  %12 = load float addrspace(3)* %arrayidx4, align 4, !tbaa !4
  %arrayidx45 = getelementptr inbounds float addrspace(1)* %output, i64 %2
  store float %12, float addrspace(1)* %arrayidx45, align 4, !tbaa !4
  br label %if.end56

if.else:                                          ; preds = %for.end
  %sub47 = add nsw i32 %mul3, -1
  %arrayidx48 = getelementptr inbounds float addrspace(3)* %block, i32 %sub47
  %13 = load float addrspace(3)* %arrayidx48, align 4, !tbaa !4
  %arrayidx50 = getelementptr inbounds float addrspace(1)* %output, i64 %0
  store float %13, float addrspace(1)* %arrayidx50, align 4, !tbaa !4
  %14 = load float addrspace(3)* %arrayidx4, align 4, !tbaa !4
  %arrayidx55 = getelementptr inbounds float addrspace(1)* %output, i64 %2
  store float %14, float addrspace(1)* %arrayidx55, align 4, !tbaa !4
  br label %if.end56

if.end56:                                         ; preds = %if.else, %if.then38
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(float addrspace(1)* nocapture %output, float addrspace(1)* nocapture readonly %input, float addrspace(3)* nocapture %block, i32 %block_size) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 0) #2
  %call2 = tail call i32 @get_group_id(i32 0) #2
  %mul = shl nsw i32 %call1, 1
  %0 = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !4
  %mul3 = shl nsw i32 %call, 1
  %arrayidx4 = getelementptr inbounds float addrspace(3)* %block, i32 %mul3
  store float %1, float addrspace(3)* %arrayidx4, align 4, !tbaa !4
  %add91 = or i32 %mul, 1
  %2 = sext i32 %add91 to i64
  %arrayidx6 = getelementptr inbounds float addrspace(1)* %input, i64 %2
  %3 = load float addrspace(1)* %arrayidx6, align 4, !tbaa !4
  %add892 = or i32 %mul3, 1
  %arrayidx9 = getelementptr inbounds float addrspace(3)* %block, i32 %add892
  store float %3, float addrspace(3)* %arrayidx9, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %4 = load float addrspace(3)* %block, align 4, !tbaa !4
  %cmp93 = icmp ugt i32 %block_size, 1
  br i1 %cmp93, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %arrayidx11 = getelementptr inbounds float addrspace(3)* %block, i32 1
  %5 = load float addrspace(3)* %arrayidx11, align 4, !tbaa !4
  %add12 = fadd float %4, %5
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %if.end
  %stride.096 = phi i32 [ 1, %for.body.lr.ph ], [ %mul33, %if.end ]
  %cache1.095 = phi float [ %add12, %for.body.lr.ph ], [ %cache1.1, %if.end ]
  %cache0.094 = phi float [ %4, %for.body.lr.ph ], [ %cache0.1, %if.end ]
  %cmp14 = icmp slt i32 %mul3, %stride.096
  br i1 %cmp14, label %if.end, label %if.then

if.then:                                          ; preds = %for.body
  %sub = sub nsw i32 %mul3, %stride.096
  %arrayidx16 = getelementptr inbounds float addrspace(3)* %block, i32 %sub
  %6 = load float addrspace(3)* %arrayidx16, align 4, !tbaa !4
  %7 = load float addrspace(3)* %arrayidx4, align 4, !tbaa !4
  %add19 = fadd float %6, %7
  %sub22 = sub nsw i32 %add892, %stride.096
  %arrayidx23 = getelementptr inbounds float addrspace(3)* %block, i32 %sub22
  %8 = load float addrspace(3)* %arrayidx23, align 4, !tbaa !4
  %9 = load float addrspace(3)* %arrayidx9, align 4, !tbaa !4
  %add27 = fadd float %8, %9
  br label %if.end

if.end:                                           ; preds = %for.body, %if.then
  %cache0.1 = phi float [ %add19, %if.then ], [ %cache0.094, %for.body ]
  %cache1.1 = phi float [ %add27, %if.then ], [ %cache1.095, %for.body ]
  tail call void @barrier(i32 1) #2
  store float %cache0.1, float addrspace(3)* %arrayidx4, align 4, !tbaa !4
  store float %cache1.1, float addrspace(3)* %arrayidx9, align 4, !tbaa !4
  tail call void @barrier(i32 1) #2
  %mul33 = shl nsw i32 %stride.096, 1
  %cmp = icmp ult i32 %mul33, %block_size
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %if.end, %entry
  %cmp34 = icmp eq i32 %call, 0
  br i1 %cmp34, label %if.then35, label %if.else

if.then35:                                        ; preds = %for.end
  %arrayidx37 = getelementptr inbounds float addrspace(1)* %output, i64 %0
  store float 0.000000e+00, float addrspace(1)* %arrayidx37, align 4, !tbaa !4
  %10 = load float addrspace(3)* %arrayidx4, align 4, !tbaa !4
  %arrayidx42 = getelementptr inbounds float addrspace(1)* %output, i64 %2
  store float %10, float addrspace(1)* %arrayidx42, align 4, !tbaa !4
  br label %if.end53

if.else:                                          ; preds = %for.end
  %sub44 = add nsw i32 %mul3, -1
  %arrayidx45 = getelementptr inbounds float addrspace(3)* %block, i32 %sub44
  %11 = load float addrspace(3)* %arrayidx45, align 4, !tbaa !4
  %arrayidx47 = getelementptr inbounds float addrspace(1)* %output, i64 %0
  store float %11, float addrspace(1)* %arrayidx47, align 4, !tbaa !4
  %12 = load float addrspace(3)* %arrayidx4, align 4, !tbaa !4
  %arrayidx52 = getelementptr inbounds float addrspace(1)* %output, i64 %2
  store float %12, float addrspace(1)* %arrayidx52, align 4, !tbaa !4
  br label %if.end53

if.end53:                                         ; preds = %if.else, %if.then35
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @blockAddition}
!1 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, float addrspace(1)*)* @ScanLargeArrays}
!2 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32)* @prefixSum}
!3 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"float", metadata !6, i64 0}
!6 = metadata !{metadata !"omnipotent char", metadata !7, i64 0}
!7 = metadata !{metadata !"Simple C/C++ TBAA"}

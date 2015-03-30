; ModuleID = '../kernel-src/QuasiRandomSequence_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @QuasiRandomSequence_Vector(<4 x float> addrspace(1)* nocapture %output, <4 x i32> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(3)* nocapture %shared) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 0) #2
  %call2 = tail call i32 @get_group_id(i32 0) #2
  %mul = shl i32 %call1, 2
  %vecinit = insertelement <4 x i32> undef, i32 %mul, i32 0
  %add37 = or i32 %mul, 1
  %vecinit3 = insertelement <4 x i32> %vecinit, i32 %add37, i32 1
  %add438 = or i32 %mul, 2
  %vecinit5 = insertelement <4 x i32> %vecinit3, i32 %add438, i32 2
  %add639 = or i32 %mul, 3
  %vecinit7 = insertelement <4 x i32> %vecinit5, i32 %add639, i32 3
  %cmp43 = icmp slt i32 %call1, 8
  br i1 %cmp43, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %mul9 = shl i32 %call2, 3
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %i.044 = phi i32 [ %call1, %for.body.lr.ph ], [ %add13, %for.body ]
  %add10 = add i32 %i.044, %mul9
  %0 = sext i32 %add10 to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %0
  %1 = load <4 x i32> addrspace(1)* %arrayidx, align 16, !tbaa !3
  %arrayidx11 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 %i.044
  store <4 x i32> %1, <4 x i32> addrspace(3)* %arrayidx11, align 16, !tbaa !3
  %call12 = tail call i32 @get_local_size(i32 0) #2
  %add13 = add i32 %call12, %i.044
  %cmp = icmp slt i32 %add13, 8
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  tail call void @barrier(i32 1) #2
  %and = and <4 x i32> %vecinit7, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 0
  %2 = load i32 addrspace(3)* %arrayidx17, align 4, !tbaa !6
  %splat.splatinsert = insertelement <4 x i32> undef, i32 %2, i32 0
  %splat.splat = shufflevector <4 x i32> %splat.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18 = mul <4 x i32> %and, %splat.splat
  %shr = lshr <4 x i32> %vecinit7, <i32 1, i32 1, i32 1, i32 1>
  %and.1 = and <4 x i32> %shr, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.1 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 1
  %3 = load i32 addrspace(3)* %arrayidx17.1, align 4, !tbaa !6
  %splat.splatinsert.1 = insertelement <4 x i32> undef, i32 %3, i32 0
  %splat.splat.1 = shufflevector <4 x i32> %splat.splatinsert.1, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.1 = mul <4 x i32> %and.1, %splat.splat.1
  %xor.1 = xor <4 x i32> %mul18, %mul18.1
  %shr.1 = lshr <4 x i32> %shr, <i32 1, i32 1, i32 1, i32 1>
  %and.2 = and <4 x i32> %shr.1, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.2 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 2
  %4 = load i32 addrspace(3)* %arrayidx17.2, align 4, !tbaa !6
  %splat.splatinsert.2 = insertelement <4 x i32> undef, i32 %4, i32 0
  %splat.splat.2 = shufflevector <4 x i32> %splat.splatinsert.2, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.2 = mul <4 x i32> %and.2, %splat.splat.2
  %xor.2 = xor <4 x i32> %xor.1, %mul18.2
  %shr.2 = lshr <4 x i32> %shr.1, <i32 1, i32 1, i32 1, i32 1>
  %and.3 = and <4 x i32> %shr.2, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.3 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 3
  %5 = load i32 addrspace(3)* %arrayidx17.3, align 4, !tbaa !6
  %splat.splatinsert.3 = insertelement <4 x i32> undef, i32 %5, i32 0
  %splat.splat.3 = shufflevector <4 x i32> %splat.splatinsert.3, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.3 = mul <4 x i32> %and.3, %splat.splat.3
  %xor.3 = xor <4 x i32> %xor.2, %mul18.3
  %shr.3 = lshr <4 x i32> %shr.2, <i32 1, i32 1, i32 1, i32 1>
  %and.4 = and <4 x i32> %shr.3, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.4 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 4
  %6 = load i32 addrspace(3)* %arrayidx17.4, align 4, !tbaa !6
  %splat.splatinsert.4 = insertelement <4 x i32> undef, i32 %6, i32 0
  %splat.splat.4 = shufflevector <4 x i32> %splat.splatinsert.4, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.4 = mul <4 x i32> %and.4, %splat.splat.4
  %xor.4 = xor <4 x i32> %xor.3, %mul18.4
  %shr.4 = lshr <4 x i32> %shr.3, <i32 1, i32 1, i32 1, i32 1>
  %and.5 = and <4 x i32> %shr.4, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.5 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 5
  %7 = load i32 addrspace(3)* %arrayidx17.5, align 4, !tbaa !6
  %splat.splatinsert.5 = insertelement <4 x i32> undef, i32 %7, i32 0
  %splat.splat.5 = shufflevector <4 x i32> %splat.splatinsert.5, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.5 = mul <4 x i32> %and.5, %splat.splat.5
  %xor.5 = xor <4 x i32> %xor.4, %mul18.5
  %shr.5 = lshr <4 x i32> %shr.4, <i32 1, i32 1, i32 1, i32 1>
  %and.6 = and <4 x i32> %shr.5, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.6 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 6
  %8 = load i32 addrspace(3)* %arrayidx17.6, align 4, !tbaa !6
  %splat.splatinsert.6 = insertelement <4 x i32> undef, i32 %8, i32 0
  %splat.splat.6 = shufflevector <4 x i32> %splat.splatinsert.6, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.6 = mul <4 x i32> %and.6, %splat.splat.6
  %xor.6 = xor <4 x i32> %xor.5, %mul18.6
  %shr.6 = lshr <4 x i32> %shr.5, <i32 1, i32 1, i32 1, i32 1>
  %and.7 = and <4 x i32> %shr.6, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.7 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 7
  %9 = load i32 addrspace(3)* %arrayidx17.7, align 4, !tbaa !6
  %splat.splatinsert.7 = insertelement <4 x i32> undef, i32 %9, i32 0
  %splat.splat.7 = shufflevector <4 x i32> %splat.splatinsert.7, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.7 = mul <4 x i32> %and.7, %splat.splat.7
  %xor.7 = xor <4 x i32> %xor.6, %mul18.7
  %shr.7 = lshr <4 x i32> %shr.6, <i32 1, i32 1, i32 1, i32 1>
  %and.8 = and <4 x i32> %shr.7, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.8 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 8
  %10 = load i32 addrspace(3)* %arrayidx17.8, align 4, !tbaa !6
  %splat.splatinsert.8 = insertelement <4 x i32> undef, i32 %10, i32 0
  %splat.splat.8 = shufflevector <4 x i32> %splat.splatinsert.8, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.8 = mul <4 x i32> %and.8, %splat.splat.8
  %xor.8 = xor <4 x i32> %xor.7, %mul18.8
  %shr.8 = lshr <4 x i32> %shr.7, <i32 1, i32 1, i32 1, i32 1>
  %and.9 = and <4 x i32> %shr.8, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.9 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 9
  %11 = load i32 addrspace(3)* %arrayidx17.9, align 4, !tbaa !6
  %splat.splatinsert.9 = insertelement <4 x i32> undef, i32 %11, i32 0
  %splat.splat.9 = shufflevector <4 x i32> %splat.splatinsert.9, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.9 = mul <4 x i32> %and.9, %splat.splat.9
  %xor.9 = xor <4 x i32> %xor.8, %mul18.9
  %shr.9 = lshr <4 x i32> %shr.8, <i32 1, i32 1, i32 1, i32 1>
  %and.10 = and <4 x i32> %shr.9, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.10 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 10
  %12 = load i32 addrspace(3)* %arrayidx17.10, align 4, !tbaa !6
  %splat.splatinsert.10 = insertelement <4 x i32> undef, i32 %12, i32 0
  %splat.splat.10 = shufflevector <4 x i32> %splat.splatinsert.10, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.10 = mul <4 x i32> %and.10, %splat.splat.10
  %xor.10 = xor <4 x i32> %xor.9, %mul18.10
  %shr.10 = lshr <4 x i32> %shr.9, <i32 1, i32 1, i32 1, i32 1>
  %and.11 = and <4 x i32> %shr.10, <i32 1, i32 1, i32 1, i32 1>
  %arrayidx17.11 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 11
  %13 = load i32 addrspace(3)* %arrayidx17.11, align 4, !tbaa !6
  %splat.splatinsert.11 = insertelement <4 x i32> undef, i32 %13, i32 0
  %splat.splat.11 = shufflevector <4 x i32> %splat.splatinsert.11, <4 x i32> undef, <4 x i32> zeroinitializer
  %mul18.11 = mul <4 x i32> %and.11, %splat.splat.11
  %xor.11 = xor <4 x i32> %xor.10, %mul18.11
  %call21 = tail call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %xor.11) #2
  %div = fdiv <4 x float> %call21, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !8
  %14 = sext i32 %call to i64
  %arrayidx24 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %14
  store <4 x float> %div, <4 x float> addrspace(1)* %arrayidx24, align 16, !tbaa !3
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind
define void @QuasiRandomSequence_Scalar(float addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(3)* nocapture %shared) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 0) #2
  %call2 = tail call i32 @get_group_id(i32 0) #2
  %cmp28 = icmp slt i32 %call1, 32
  br i1 %cmp28, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %mul = shl i32 %call2, 5
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %i.029 = phi i32 [ %call1, %for.body.lr.ph ], [ %add6, %for.body ]
  %add = add i32 %i.029, %mul
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !6
  %arrayidx4 = getelementptr inbounds i32 addrspace(3)* %shared, i32 %i.029
  store i32 %1, i32 addrspace(3)* %arrayidx4, align 4, !tbaa !6
  %call5 = tail call i32 @get_local_size(i32 0) #2
  %add6 = add i32 %call5, %i.029
  %cmp = icmp slt i32 %add6, 32
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  tail call void @barrier(i32 1) #2
  %and = and i32 %call1, 1
  %2 = load i32 addrspace(3)* %shared, align 4, !tbaa !6
  %3 = sub i32 0, %and
  %mul11 = and i32 %2, %3
  %shr = lshr i32 %call1, 1
  %and.1 = and i32 %shr, 1
  %arrayidx10.1 = getelementptr inbounds i32 addrspace(3)* %shared, i32 1
  %4 = load i32 addrspace(3)* %arrayidx10.1, align 4, !tbaa !6
  %5 = sub i32 0, %and.1
  %mul11.1 = and i32 %4, %5
  %xor.1 = xor i32 %mul11.1, %mul11
  %shr.1 = lshr i32 %call1, 2
  %and.2 = and i32 %shr.1, 1
  %arrayidx10.2 = getelementptr inbounds i32 addrspace(3)* %shared, i32 2
  %6 = load i32 addrspace(3)* %arrayidx10.2, align 4, !tbaa !6
  %7 = sub i32 0, %and.2
  %mul11.2 = and i32 %6, %7
  %xor.2 = xor i32 %mul11.2, %xor.1
  %shr.2 = lshr i32 %call1, 3
  %and.3 = and i32 %shr.2, 1
  %arrayidx10.3 = getelementptr inbounds i32 addrspace(3)* %shared, i32 3
  %8 = load i32 addrspace(3)* %arrayidx10.3, align 4, !tbaa !6
  %9 = sub i32 0, %and.3
  %mul11.3 = and i32 %8, %9
  %xor.3 = xor i32 %mul11.3, %xor.2
  %shr.3 = lshr i32 %call1, 4
  %and.4 = and i32 %shr.3, 1
  %arrayidx10.4 = getelementptr inbounds i32 addrspace(3)* %shared, i32 4
  %10 = load i32 addrspace(3)* %arrayidx10.4, align 4, !tbaa !6
  %11 = sub i32 0, %and.4
  %mul11.4 = and i32 %10, %11
  %xor.4 = xor i32 %mul11.4, %xor.3
  %shr.4 = lshr i32 %call1, 5
  %and.5 = and i32 %shr.4, 1
  %arrayidx10.5 = getelementptr inbounds i32 addrspace(3)* %shared, i32 5
  %12 = load i32 addrspace(3)* %arrayidx10.5, align 4, !tbaa !6
  %13 = sub i32 0, %and.5
  %mul11.5 = and i32 %12, %13
  %xor.5 = xor i32 %mul11.5, %xor.4
  %shr.5 = lshr i32 %call1, 6
  %and.6 = and i32 %shr.5, 1
  %arrayidx10.6 = getelementptr inbounds i32 addrspace(3)* %shared, i32 6
  %14 = load i32 addrspace(3)* %arrayidx10.6, align 4, !tbaa !6
  %15 = sub i32 0, %and.6
  %mul11.6 = and i32 %14, %15
  %xor.6 = xor i32 %mul11.6, %xor.5
  %shr.6 = lshr i32 %call1, 7
  %and.7 = and i32 %shr.6, 1
  %arrayidx10.7 = getelementptr inbounds i32 addrspace(3)* %shared, i32 7
  %16 = load i32 addrspace(3)* %arrayidx10.7, align 4, !tbaa !6
  %17 = sub i32 0, %and.7
  %mul11.7 = and i32 %16, %17
  %xor.7 = xor i32 %mul11.7, %xor.6
  %shr.7 = lshr i32 %call1, 8
  %and.8 = and i32 %shr.7, 1
  %arrayidx10.8 = getelementptr inbounds i32 addrspace(3)* %shared, i32 8
  %18 = load i32 addrspace(3)* %arrayidx10.8, align 4, !tbaa !6
  %19 = sub i32 0, %and.8
  %mul11.8 = and i32 %18, %19
  %xor.8 = xor i32 %mul11.8, %xor.7
  %shr.8 = lshr i32 %call1, 9
  %and.9 = and i32 %shr.8, 1
  %arrayidx10.9 = getelementptr inbounds i32 addrspace(3)* %shared, i32 9
  %20 = load i32 addrspace(3)* %arrayidx10.9, align 4, !tbaa !6
  %21 = sub i32 0, %and.9
  %mul11.9 = and i32 %20, %21
  %xor.9 = xor i32 %mul11.9, %xor.8
  %call14 = tail call float @_Z13convert_floatj(i32 %xor.9) #2
  %div = fmul float %call14, 0x3DF0000000000000
  %22 = sext i32 %call to i64
  %arrayidx15 = getelementptr inbounds float addrspace(1)* %output, i64 %22
  store float %div, float addrspace(1)* %arrayidx15, align 4, !tbaa !9
  ret void
}

declare float @_Z13convert_floatj(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @QuasiRandomSequence_Vector}
!1 = metadata !{void (float addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*)* @QuasiRandomSequence_Scalar}
!2 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}
!8 = metadata !{float 2.500000e+00}
!9 = metadata !{metadata !10, metadata !10, i64 0}
!10 = metadata !{metadata !"float", metadata !4, i64 0}

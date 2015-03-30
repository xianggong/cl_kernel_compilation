; ModuleID = '../kernel-src/URNG_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@noise_uniform.iv = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* nocapture %iv) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 1) #2
  %call2 = tail call i32 @get_local_size(i32 0) #2
  %mul = mul i32 %call2, %call1
  %add = add i32 %mul, %call
  %mul11 = shl i32 %add, 4
  br label %for.body

for.body:                                         ; preds = %for.inc.thread, %entry, %for.inc
  %idum.addr.052 = phi i32 [ %idum, %entry ], [ %add8.sub6, %for.inc ], [ %add8.sub6, %for.inc.thread ]
  %j.051 = phi i32 [ 16, %entry ], [ %dec, %for.inc ], [ %dec53, %for.inc.thread ]
  %div = sdiv i32 %idum.addr.052, 127773
  %0 = mul i32 %div, -127773
  %sub = add i32 %0, %idum.addr.052
  %mul4 = mul nsw i32 %sub, 16807
  %1 = mul i32 %div, -2836
  %sub6 = add i32 %mul4, %1
  %cmp7 = icmp slt i32 %sub6, 0
  %add8 = add nsw i32 %sub6, 2147483647
  %add8.sub6 = select i1 %cmp7, i32 %add8, i32 %sub6
  %cmp9 = icmp slt i32 %j.051, 16
  br i1 %cmp9, label %for.inc, label %for.inc.thread

for.inc.thread:                                   ; preds = %for.body
  %dec53 = add nsw i32 %j.051, -1
  br label %for.body

for.inc:                                          ; preds = %for.body
  %add12 = add nsw i32 %j.051, %mul11
  %arrayidx = getelementptr inbounds i32 addrspace(3)* %iv, i32 %add12
  store i32 %add8.sub6, i32 addrspace(3)* %arrayidx, align 4, !tbaa !2
  %dec = add nsw i32 %j.051, -1
  %cmp = icmp sgt i32 %j.051, 0
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.inc
  %arrayidx15 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %mul11
  %2 = load i32 addrspace(3)* %arrayidx15, align 4, !tbaa !2
  %div26 = sdiv i32 %2, 134217728
  %add28 = add nsw i32 %div26, %mul11
  %arrayidx29 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %add28
  %3 = load i32 addrspace(3)* %arrayidx29, align 4, !tbaa !2
  %conv = sitofp i32 %3 to float
  %mul30 = fmul float %conv, 0x3E00000000000000
  ret float %mul30
}

declare i32 @get_local_id(i32) #1

declare i32 @get_local_size(i32) #1

; Function Attrs: nounwind
define void @noise_uniform(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %factor) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 1) #2
  %call2 = tail call i32 @get_global_size(i32 0) #2
  %mul = mul i32 %call2, %call1
  %add = add i32 %mul, %call
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %0
  %1 = load <4 x i8> addrspace(1)* %arrayidx, align 4, !tbaa !6
  %call3 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %1) #2
  %2 = extractelement <4 x float> %call3, i32 0
  %3 = extractelement <4 x float> %call3, i32 1
  %add4 = fadd float %2, %3
  %4 = extractelement <4 x float> %call3, i32 2
  %add5 = fadd float %4, %add4
  %add6 = fadd float %3, %add5
  %div = fmul float %add6, 2.500000e-01
  %sub = fsub float -0.000000e+00, %div
  %conv = fptosi float %sub to i32
  %call7 = tail call float @ran1(i32 %conv, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  %sub8 = fadd float %call7, 0xBFE19999A0000000
  %conv9 = sitofp i32 %factor to float
  %mul10 = fmul float %conv9, %sub8
  %splat.splatinsert = insertelement <4 x float> undef, float %mul10, i32 0
  %splat.splat = shufflevector <4 x float> %splat.splatinsert, <4 x float> undef, <4 x i32> zeroinitializer
  %add11 = fadd <4 x float> %call3, %splat.splat
  %call12 = tail call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %add11) #2
  %arrayidx13 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %0
  store <4 x i8> %call12, <4 x i8> addrspace(1)* %arrayidx13, align 4, !tbaa !6
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @noise_uniform}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !4, metadata !4, i64 0}

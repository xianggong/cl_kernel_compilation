; ModuleID = '../kernel-src/URNGNoiseGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@noise_uniform.iv = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* nocapture %iv) #0 {
for.inc.4:
  %call = tail call i32 @get_local_id(i32 0) #2
  %mul7 = shl i32 %call, 2
  %div = sdiv i32 %idum, 127773
  %0 = mul i32 %div, -127773
  %sub = add i32 %0, %idum
  %mul1 = mul nsw i32 %sub, 16807
  %1 = mul i32 %div, -2836
  %sub3 = add i32 %mul1, %1
  %cmp4 = icmp slt i32 %sub3, 0
  %add = add nsw i32 %sub3, 2147483647
  %add.sub3 = select i1 %cmp4, i32 %add, i32 %sub3
  %div.1 = sdiv i32 %add.sub3, 127773
  %2 = mul i32 %div.1, -127773
  %sub.1 = add i32 %2, %add.sub3
  %mul1.1 = mul nsw i32 %sub.1, 16807
  %3 = mul i32 %div.1, -2836
  %sub3.1 = add i32 %mul1.1, %3
  %cmp4.1 = icmp slt i32 %sub3.1, 0
  %add.1 = add nsw i32 %sub3.1, 2147483647
  %add.sub3.1 = select i1 %cmp4.1, i32 %add.1, i32 %sub3.1
  %add8.149 = or i32 %mul7, 3
  %arrayidx.1 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %add8.149
  store i32 %add.sub3.1, i32 addrspace(3)* %arrayidx.1, align 4, !tbaa !2
  %div.2 = sdiv i32 %add.sub3.1, 127773
  %4 = mul i32 %div.2, -127773
  %sub.2 = add i32 %4, %add.sub3.1
  %mul1.2 = mul nsw i32 %sub.2, 16807
  %5 = mul i32 %div.2, -2836
  %sub3.2 = add i32 %mul1.2, %5
  %cmp4.2 = icmp slt i32 %sub3.2, 0
  %add.2 = add nsw i32 %sub3.2, 2147483647
  %add.sub3.2 = select i1 %cmp4.2, i32 %add.2, i32 %sub3.2
  %add8.250 = or i32 %mul7, 2
  %arrayidx.2 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %add8.250
  store i32 %add.sub3.2, i32 addrspace(3)* %arrayidx.2, align 4, !tbaa !2
  %div.3 = sdiv i32 %add.sub3.2, 127773
  %6 = mul i32 %div.3, -127773
  %sub.3 = add i32 %6, %add.sub3.2
  %mul1.3 = mul nsw i32 %sub.3, 16807
  %7 = mul i32 %div.3, -2836
  %sub3.3 = add i32 %mul1.3, %7
  %cmp4.3 = icmp slt i32 %sub3.3, 0
  %add.3 = add nsw i32 %sub3.3, 2147483647
  %add.sub3.3 = select i1 %cmp4.3, i32 %add.3, i32 %sub3.3
  %add8.351 = or i32 %mul7, 1
  %arrayidx.3 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %add8.351
  store i32 %add.sub3.3, i32 addrspace(3)* %arrayidx.3, align 4, !tbaa !2
  %div.4 = sdiv i32 %add.sub3.3, 127773
  %8 = mul i32 %div.4, -127773
  %sub.4 = add i32 %8, %add.sub3.3
  %mul1.4 = mul nsw i32 %sub.4, 16807
  %9 = mul i32 %div.4, -2836
  %sub3.4 = add i32 %mul1.4, %9
  %cmp4.4 = icmp slt i32 %sub3.4, 0
  %add.4 = add nsw i32 %sub3.4, 2147483647
  %add.sub3.4 = select i1 %cmp4.4, i32 %add.4, i32 %sub3.4
  %arrayidx.4 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %mul7
  store i32 %add.sub3.4, i32 addrspace(3)* %arrayidx.4, align 4, !tbaa !2
  %phitmp = sdiv i32 %add.sub3.4, 536870912
  %add24 = add nsw i32 %phitmp, %mul7
  %arrayidx25 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %add24
  %10 = load i32 addrspace(3)* %arrayidx25, align 4, !tbaa !2
  %conv = sitofp i32 %10 to float
  %mul26 = fmul float %conv, 0x3E00000000000000
  ret float %mul26
}

declare i32 @get_local_id(i32) #1

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
  %call7 = tail call float @ran1(i32 %conv, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  %sub8 = fadd float %call7, -5.000000e-01
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

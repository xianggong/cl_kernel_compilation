; ModuleID = '../kernel-src/GaussianNoiseGL_Kernels2.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* nocapture %iv) #0 {
for.inc.4:
  %call = tail call i32 @get_local_id(i32 0) #3
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
  %add8.147 = or i32 %mul7, 3
  %arrayidx.1 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %add8.147
  store i32 %add.sub3.1, i32 addrspace(3)* %arrayidx.1, align 4, !tbaa !1
  %div.2 = sdiv i32 %add.sub3.1, 127773
  %4 = mul i32 %div.2, -127773
  %sub.2 = add i32 %4, %add.sub3.1
  %mul1.2 = mul nsw i32 %sub.2, 16807
  %5 = mul i32 %div.2, -2836
  %sub3.2 = add i32 %mul1.2, %5
  %cmp4.2 = icmp slt i32 %sub3.2, 0
  %add.2 = add nsw i32 %sub3.2, 2147483647
  %add.sub3.2 = select i1 %cmp4.2, i32 %add.2, i32 %sub3.2
  %add8.248 = or i32 %mul7, 2
  %arrayidx.2 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %add8.248
  store i32 %add.sub3.2, i32 addrspace(3)* %arrayidx.2, align 4, !tbaa !1
  %div.3 = sdiv i32 %add.sub3.2, 127773
  %6 = mul i32 %div.3, -127773
  %sub.3 = add i32 %6, %add.sub3.2
  %mul1.3 = mul nsw i32 %sub.3, 16807
  %7 = mul i32 %div.3, -2836
  %sub3.3 = add i32 %mul1.3, %7
  %cmp4.3 = icmp slt i32 %sub3.3, 0
  %add.3 = add nsw i32 %sub3.3, 2147483647
  %add.sub3.3 = select i1 %cmp4.3, i32 %add.3, i32 %sub3.3
  %add8.349 = or i32 %mul7, 1
  %arrayidx.3 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %add8.349
  store i32 %add.sub3.3, i32 addrspace(3)* %arrayidx.3, align 4, !tbaa !1
  %div.4 = sdiv i32 %add.sub3.3, 127773
  %8 = mul i32 %div.4, -127773
  %sub.4 = add i32 %8, %add.sub3.3
  %mul1.4 = mul nsw i32 %sub.4, 16807
  %9 = mul i32 %div.4, -2836
  %sub3.4 = add i32 %mul1.4, %9
  %add.4 = add nsw i32 %sub3.4, 2147483647
  %cmp4.4 = icmp slt i32 %sub3.4, 0
  %add.sub3.4 = select i1 %cmp4.4, i32 %add.4, i32 %sub3.4
  %arrayidx.4 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %mul7
  store i32 %add.sub3.4, i32 addrspace(3)* %arrayidx.4, align 4, !tbaa !1
  %10 = load i32 addrspace(3)* %iv, align 4, !tbaa !1
  %div21 = sdiv i32 %10, 536870912
  %add23 = add nsw i32 %div21, %mul7
  %arrayidx24 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %add23
  %11 = load i32 addrspace(3)* %arrayidx24, align 4, !tbaa !1
  %conv = sitofp i32 %11 to float
  %mul25 = fmul float %conv, 0x3E00000000000000
  ret float %mul25
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
entry:
  %0 = extractelement <2 x float> %uniform, i32 0
  %call = tail call float @llvm.log2.f32(float %0)
  %mul = fmul float %call, 0x3FE62E4300000000
  %mul1 = fmul float %mul, -2.000000e+00
  %call2 = tail call float @llvm.sqrt.f32(float %mul1)
  %1 = extractelement <2 x float> %uniform, i32 1
  %mul3 = fmul float %1, 0x40191EB860000000
  %call4 = tail call float @_Z3sinf(float %mul3) #3
  %mul5 = fmul float %call2, %call4
  %vecinit = insertelement <2 x float> undef, float %mul5, i32 0
  %call6 = tail call float @_Z3cosf(float %mul3) #3
  %mul7 = fmul float %call2, %call6
  %vecinit8 = insertelement <2 x float> %vecinit, float %mul7, i32 1
  ret <2 x float> %vecinit8
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

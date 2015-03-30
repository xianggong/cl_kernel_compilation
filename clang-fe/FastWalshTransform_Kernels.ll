; ModuleID = '../kernel-src/FastWalshTransform_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @fastWalshTransform(float addrspace(1)* nocapture %tArray, i32 %step) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %rem = urem i32 %call, %step
  %mul = shl i32 %step, 1
  %div = udiv i32 %call, %step
  %mul1 = mul i32 %mul, %div
  %add = add i32 %mul1, %rem
  %add2 = add i32 %add, %step
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %tArray, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !2
  %2 = sext i32 %add2 to i64
  %arrayidx3 = getelementptr inbounds float addrspace(1)* %tArray, i64 %2
  %3 = load float addrspace(1)* %arrayidx3, align 4, !tbaa !2
  %add4 = fadd float %1, %3
  store float %add4, float addrspace(1)* %arrayidx, align 4, !tbaa !2
  %sub = fsub float %1, %3
  store float %sub, float addrspace(1)* %arrayidx3, align 4, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, i32)* @fastWalshTransform}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

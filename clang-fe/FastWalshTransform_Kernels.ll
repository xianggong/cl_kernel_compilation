; ModuleID = '../kernel-src/FastWalshTransform_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @fastWalshTransform(float* nocapture %tArray, i32 %step) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = urem i32 %2, %step
  %4 = shl i32 %step, 1
  %5 = udiv i32 %2, %step
  %6 = mul i32 %4, %5
  %7 = add i32 %6, %3
  %8 = add i32 %7, %step
  %9 = zext i32 %7 to i64
  %10 = getelementptr inbounds float* %tArray, i64 %9
  %11 = load float* %10, align 4, !tbaa !2
  %12 = zext i32 %8 to i64
  %13 = getelementptr inbounds float* %tArray, i64 %12
  %14 = load float* %13, align 4, !tbaa !2
  %15 = fadd float %11, %14
  store float %15, float* %10, align 4, !tbaa !2
  %16 = fsub float %11, %14
  store float %16, float* %13, align 4, !tbaa !2
  ret void
}

declare i64 @get_global_id(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float*, i32)* @fastWalshTransform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

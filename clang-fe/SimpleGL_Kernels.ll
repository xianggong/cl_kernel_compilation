; ModuleID = '../kernel-src/SimpleGL_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @sineWave(<4 x float>* nocapture %pos, i32 %width, i32 %height, float %time) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = trunc i64 %3 to i32
  %5 = uitofp i32 %2 to float
  %6 = uitofp i32 %width to float
  %7 = fdiv float %5, %6, !fpmath !2
  %8 = uitofp i32 %4 to float
  %9 = uitofp i32 %height to float
  %10 = fdiv float %8, %9, !fpmath !2
  %11 = tail call float @llvm.fmuladd.f32(float %7, float 2.000000e+00, float -1.000000e+00)
  %12 = tail call float @llvm.fmuladd.f32(float %10, float 2.000000e+00, float -1.000000e+00)
  %13 = tail call float @llvm.fmuladd.f32(float %11, float 4.000000e+00, float %time)
  %14 = tail call float @_Z3sinf(float %13) #3
  %15 = tail call float @llvm.fmuladd.f32(float %12, float 4.000000e+00, float %time)
  %16 = tail call float @_Z3cosf(float %15) #3
  %17 = fmul float %14, %16
  %18 = fmul float %17, 5.000000e-01
  %19 = insertelement <4 x float> undef, float %11, i32 0
  %20 = insertelement <4 x float> %19, float %18, i32 1
  %21 = insertelement <4 x float> %20, float %12, i32 2
  %22 = insertelement <4 x float> %21, float 1.000000e+00, i32 3
  %23 = mul i32 %4, %width
  %24 = add i32 %23, %2
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds <4 x float>* %pos, i64 %25
  store <4 x float> %22, <4 x float>* %26, align 16, !tbaa !3
  ret void
}

declare i64 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float>*, i32, i32, float)* @sineWave}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

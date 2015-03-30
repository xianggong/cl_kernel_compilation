; ModuleID = '../kernel-src/SimpleGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @sineWave(<4 x float> addrspace(1)* nocapture %pos, i32 %width, i32 %height, float %time) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %conv = uitofp i32 %call to float
  %conv2 = uitofp i32 %width to float
  %div = fdiv float %conv, %conv2, !fpmath !2
  %conv3 = uitofp i32 %call1 to float
  %conv4 = uitofp i32 %height to float
  %div5 = fdiv float %conv3, %conv4, !fpmath !2
  %0 = tail call float @llvm.fmuladd.f32(float %div, float 2.000000e+00, float -1.000000e+00)
  %1 = tail call float @llvm.fmuladd.f32(float %div5, float 2.000000e+00, float -1.000000e+00)
  %2 = tail call float @llvm.fmuladd.f32(float %0, float 4.000000e+00, float %time)
  %call6 = tail call float @_Z3sinf(float %2) #3
  %3 = tail call float @llvm.fmuladd.f32(float %1, float 4.000000e+00, float %time)
  %call7 = tail call float @_Z3cosf(float %3) #3
  %mul = fmul float %call6, %call7
  %mul8 = fmul float %mul, 5.000000e-01
  %vecinit = insertelement <4 x float> undef, float %0, i32 0
  %vecinit9 = insertelement <4 x float> %vecinit, float %mul8, i32 1
  %vecinit10 = insertelement <4 x float> %vecinit9, float %1, i32 2
  %vecinit11 = insertelement <4 x float> %vecinit10, float 1.000000e+00, i32 3
  %mul12 = mul i32 %call1, %width
  %add = add i32 %mul12, %call
  %4 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %pos, i64 %4
  store <4 x float> %vecinit11, <4 x float> addrspace(1)* %arrayidx, align 16, !tbaa !3
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, i32, i32, float)* @sineWave}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{float 2.500000e+00}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

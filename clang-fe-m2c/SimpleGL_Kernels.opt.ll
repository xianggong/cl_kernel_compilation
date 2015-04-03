; ModuleID = 'SimpleGL_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @sineWave(<4 x float> addrspace(1)* %pos, i32 %width, i32 %height, float %time) #0 {
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_7 = call i32 @__get_global_id_u32(i32 1)
  %tmp_9 = uitofp i32 %tmp_6 to float
  %tmp_11 = uitofp i32 %width to float
  %tmp_12 = fdiv float %tmp_9, %tmp_11, !fpmath !2
  %tmp_14 = uitofp i32 %tmp_7 to float
  %tmp_16 = uitofp i32 %height to float
  %tmp_17 = fdiv float %tmp_14, %tmp_16, !fpmath !2
  %tmp_19 = call float @llvm.fmuladd.f32(float %tmp_12, float 2.000000e+00, float -1.000000e+00)
  %tmp_21 = call float @llvm.fmuladd.f32(float %tmp_17, float 2.000000e+00, float -1.000000e+00)
  %tmp_25 = call float @llvm.fmuladd.f32(float %tmp_19, float 4.000000e+00, float %time)
  %tmp_26 = call float @_Z3sinf(float %tmp_25)
  %tmp_30 = call float @llvm.fmuladd.f32(float %tmp_21, float 4.000000e+00, float %time)
  %tmp_31 = call float @_Z3cosf(float %tmp_30)
  %tmp_32 = fmul float %tmp_26, %tmp_31
  %tmp_33 = fmul float %tmp_32, 5.000000e-01
  %tmp_35 = insertelement <4 x float> undef, float %tmp_19, i32 0
  %tmp_37 = insertelement <4 x float> %tmp_35, float %tmp_33, i32 1
  %tmp_39 = insertelement <4 x float> %tmp_37, float %tmp_21, i32 2
  %tmp_40 = insertelement <4 x float> %tmp_39, float 1.000000e+00, i32 3
  %tmp_44 = mul i32 %tmp_7, %width
  %tmp_46 = add i32 %tmp_44, %tmp_6
  %tmp_48 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %tmp_46
  store <4 x float> %tmp_40, <4 x float> addrspace(1)* %tmp_48, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, i32, i32, float)* @sineWave}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

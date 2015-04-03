; ModuleID = '../kernel-src/SimpleGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @sineWave(<4 x float> addrspace(1)* %pos, i32 %width, i32 %height, float %time) #0 {
  %tmp_1 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_2 = alloca i32, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca float, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %u = alloca float, align 4
  %v = alloca float, align 4
  %freq = alloca float, align 4
  %w = alloca float, align 4
  %tmp_5 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)** %tmp_1, align 4
  store i32 %width, i32* %tmp_2, align 4
  store i32 %height, i32* %tmp_3, align 4
  store float %time, float* %tmp_4, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_6, i32* %x, align 4
  %tmp_7 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_7, i32* %y, align 4
  %tmp_8 = load i32* %x, align 4
  %tmp_9 = uitofp i32 %tmp_8 to float
  %tmp_10 = load i32* %tmp_2, align 4
  %tmp_11 = uitofp i32 %tmp_10 to float
  %tmp_12 = fdiv float %tmp_9, %tmp_11, !fpmath !2
  store float %tmp_12, float* %u, align 4
  %tmp_13 = load i32* %y, align 4
  %tmp_14 = uitofp i32 %tmp_13 to float
  %tmp_15 = load i32* %tmp_3, align 4
  %tmp_16 = uitofp i32 %tmp_15 to float
  %tmp_17 = fdiv float %tmp_14, %tmp_16, !fpmath !2
  store float %tmp_17, float* %v, align 4
  %tmp_18 = load float* %u, align 4
  %tmp_19 = call float @llvm.fmuladd.f32(float %tmp_18, float 2.000000e+00, float -1.000000e+00)
  store float %tmp_19, float* %u, align 4
  %tmp_20 = load float* %v, align 4
  %tmp_21 = call float @llvm.fmuladd.f32(float %tmp_20, float 2.000000e+00, float -1.000000e+00)
  store float %tmp_21, float* %v, align 4
  store float 4.000000e+00, float* %freq, align 4
  %tmp_22 = load float* %u, align 4
  %tmp_23 = load float* %freq, align 4
  %tmp_24 = load float* %tmp_4, align 4
  %tmp_25 = call float @llvm.fmuladd.f32(float %tmp_22, float %tmp_23, float %tmp_24)
  %tmp_26 = call float @_Z3sinf(float %tmp_25)
  %tmp_27 = load float* %v, align 4
  %tmp_28 = load float* %freq, align 4
  %tmp_29 = load float* %tmp_4, align 4
  %tmp_30 = call float @llvm.fmuladd.f32(float %tmp_27, float %tmp_28, float %tmp_29)
  %tmp_31 = call float @_Z3cosf(float %tmp_30)
  %tmp_32 = fmul float %tmp_26, %tmp_31
  %tmp_33 = fmul float %tmp_32, 5.000000e-01
  store float %tmp_33, float* %w, align 4
  %tmp_34 = load float* %u, align 4
  %tmp_35 = insertelement <4 x float> undef, float %tmp_34, i32 0
  %tmp_36 = load float* %w, align 4
  %tmp_37 = insertelement <4 x float> %tmp_35, float %tmp_36, i32 1
  %tmp_38 = load float* %v, align 4
  %tmp_39 = insertelement <4 x float> %tmp_37, float %tmp_38, i32 2
  %tmp_40 = insertelement <4 x float> %tmp_39, float 1.000000e+00, i32 3
  store <4 x float> %tmp_40, <4 x float>* %tmp_5
  %tmp_41 = load <4 x float>* %tmp_5
  %tmp_42 = load i32* %y, align 4
  %tmp_43 = load i32* %tmp_2, align 4
  %tmp_44 = mul i32 %tmp_42, %tmp_43
  %tmp_45 = load i32* %x, align 4
  %tmp_46 = add i32 %tmp_44, %tmp_45
  %tmp_47 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_48 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_47, i32 %tmp_46
  store <4 x float> %tmp_41, <4 x float> addrspace(1)* %tmp_48, align 16
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

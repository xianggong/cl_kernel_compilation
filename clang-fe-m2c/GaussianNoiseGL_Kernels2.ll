; ModuleID = '../kernel-src/GaussianNoiseGL_Kernels2.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
  %tmp_1 = alloca i32, align 4
  %tmp_2 = alloca i32 addrspace(3)*, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %iy = alloca i32, align 4
  %tid = alloca i32, align 4
  store i32 %idum, i32* %tmp_1, align 4
  store i32 addrspace(3)* %iv, i32 addrspace(3)** %tmp_2, align 4
  store i32 0, i32* %iy, align 4
  %tmp_3 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_3, i32* %tid, align 4
  store i32 4, i32* %j, align 4
  br label %tmp_4

tmp_4:                                       ; preds = %tmp_35, %tmp_0
  %tmp_5 = load i32* %j, align 4
  %tmp_6 = icmp sge i32 %tmp_5, 0
  br i1 %tmp_6, label %tmp_7, label %tmp_38

tmp_7:                                       ; preds = %tmp_4
  %tmp_8 = load i32* %tmp_1, align 4
  %tmp_9 = sdiv i32 %tmp_8, 127773
  store i32 %tmp_9, i32* %k, align 4
  %tmp_10 = load i32* %tmp_1, align 4
  %tmp_11 = load i32* %k, align 4
  %tmp_12 = mul nsw i32 %tmp_11, 127773
  %tmp_13 = sub nsw i32 %tmp_10, %tmp_12
  %tmp_14 = mul nsw i32 16807, %tmp_13
  %tmp_15 = load i32* %k, align 4
  %tmp_16 = mul nsw i32 2836, %tmp_15
  %tmp_17 = sub nsw i32 %tmp_14, %tmp_16
  store i32 %tmp_17, i32* %tmp_1, align 4
  %tmp_18 = load i32* %tmp_1, align 4
  %tmp_19 = icmp slt i32 %tmp_18, 0
  br i1 %tmp_19, label %tmp_20, label %tmp_23

tmp_20:                                      ; preds = %tmp_7
  %tmp_21 = load i32* %tmp_1, align 4
  %tmp_22 = add nsw i32 %tmp_21, 2147483647
  store i32 %tmp_22, i32* %tmp_1, align 4
  br label %tmp_23

tmp_23:                                      ; preds = %tmp_20, %tmp_7
  %tmp_24 = load i32* %j, align 4
  %tmp_25 = icmp slt i32 %tmp_24, 4
  br i1 %tmp_25, label %tmp_26, label %tmp_34

tmp_26:                                      ; preds = %tmp_23
  %tmp_27 = load i32* %tmp_1, align 4
  %tmp_28 = load i32* %tid, align 4
  %tmp_29 = mul nsw i32 4, %tmp_28
  %tmp_30 = load i32* %j, align 4
  %tmp_31 = add nsw i32 %tmp_29, %tmp_30
  %tmp_32 = load i32 addrspace(3)** %tmp_2, align 4
  %tmp_33 = getelementptr inbounds i32 addrspace(3)* %tmp_32, i32 %tmp_31
  store i32 %tmp_27, i32 addrspace(3)* %tmp_33, align 4
  br label %tmp_34

tmp_34:                                      ; preds = %tmp_26, %tmp_23
  br label %tmp_35

tmp_35:                                      ; preds = %tmp_34
  %tmp_36 = load i32* %j, align 4
  %tmp_37 = add nsw i32 %tmp_36, -1
  store i32 %tmp_37, i32* %j, align 4
  br label %tmp_4

tmp_38:                                      ; preds = %tmp_4
  %tmp_39 = load i32 addrspace(3)** %tmp_2, align 4
  %tmp_40 = getelementptr inbounds i32 addrspace(3)* %tmp_39, i32 0
  %tmp_41 = load i32 addrspace(3)* %tmp_40, align 4
  store i32 %tmp_41, i32* %iy, align 4
  %tmp_42 = load i32* %tmp_1, align 4
  %tmp_43 = sdiv i32 %tmp_42, 127773
  store i32 %tmp_43, i32* %k, align 4
  %tmp_44 = load i32* %tmp_1, align 4
  %tmp_45 = load i32* %k, align 4
  %tmp_46 = mul nsw i32 %tmp_45, 127773
  %tmp_47 = sub nsw i32 %tmp_44, %tmp_46
  %tmp_48 = mul nsw i32 16807, %tmp_47
  %tmp_49 = load i32* %k, align 4
  %tmp_50 = mul nsw i32 2836, %tmp_49
  %tmp_51 = sub nsw i32 %tmp_48, %tmp_50
  store i32 %tmp_51, i32* %tmp_1, align 4
  %tmp_52 = load i32* %tmp_1, align 4
  %tmp_53 = icmp slt i32 %tmp_52, 0
  br i1 %tmp_53, label %tmp_54, label %tmp_57

tmp_54:                                      ; preds = %tmp_38
  %tmp_55 = load i32* %tmp_1, align 4
  %tmp_56 = add nsw i32 %tmp_55, 2147483647
  store i32 %tmp_56, i32* %tmp_1, align 4
  br label %tmp_57

tmp_57:                                      ; preds = %tmp_54, %tmp_38
  %tmp_58 = load i32* %iy, align 4
  %tmp_59 = sdiv i32 %tmp_58, 536870912
  store i32 %tmp_59, i32* %j, align 4
  %tmp_60 = load i32* %tid, align 4
  %tmp_61 = mul nsw i32 4, %tmp_60
  %tmp_62 = load i32* %j, align 4
  %tmp_63 = add nsw i32 %tmp_61, %tmp_62
  %tmp_64 = load i32 addrspace(3)** %tmp_2, align 4
  %tmp_65 = getelementptr inbounds i32 addrspace(3)* %tmp_64, i32 %tmp_63
  %tmp_66 = load i32 addrspace(3)* %tmp_65, align 4
  store i32 %tmp_66, i32* %iy, align 4
  %tmp_67 = load i32* %iy, align 4
  %tmp_68 = sitofp i32 %tmp_67 to float
  %tmp_69 = fmul float 0x3E00000000000000, %tmp_68
  ret float %tmp_69
}

declare i32 @__get_local_id_u32(i32) #1

; Function Attrs: nounwind
define <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
  %tmp_1 = alloca <2 x float>, align 8
  %r = alloca float, align 4
  %theta = alloca float, align 4
  %tmp_2 = alloca <2 x float>, align 8
  store <2 x float> %uniform, <2 x float>* %tmp_1, align 8
  %tmp_3 = load <2 x float>* %tmp_1, align 8
  %tmp_4 = extractelement <2 x float> %tmp_3, i32 0
  %tmp_5 = call float @llvm.log2.f32(float %tmp_4)
  %tmp_6 = fmul float %tmp_5, 0x3FE62E4300000000
  %tmp_7 = fmul float -2.000000e+00, %tmp_6
  %tmp_8 = call float @llvm.sqrt.f32(float %tmp_7)
  store float %tmp_8, float* %r, align 4
  %tmp_9 = load <2 x float>* %tmp_1, align 8
  %tmp_10 = extractelement <2 x float> %tmp_9, i32 1
  %tmp_11 = fmul float 0x40191EB860000000, %tmp_10
  store float %tmp_11, float* %theta, align 4
  %tmp_12 = load float* %r, align 4
  %tmp_13 = load float* %theta, align 4
  %tmp_14 = call float @_Z3sinf(float %tmp_13)
  %tmp_15 = fmul float %tmp_12, %tmp_14
  %tmp_16 = insertelement <2 x float> undef, float %tmp_15, i32 0
  %tmp_17 = load float* %r, align 4
  %tmp_18 = load float* %theta, align 4
  %tmp_19 = call float @_Z3cosf(float %tmp_18)
  %tmp_20 = fmul float %tmp_17, %tmp_19
  %tmp_21 = insertelement <2 x float> %tmp_16, float %tmp_20, i32 1
  store <2 x float> %tmp_21, <2 x float>* %tmp_2
  %tmp_22 = load <2 x float>* %tmp_2
  ret <2 x float> %tmp_22
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

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

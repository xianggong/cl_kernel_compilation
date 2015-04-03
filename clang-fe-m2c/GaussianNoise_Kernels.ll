; ModuleID = '../kernel-src/GaussianNoise_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@gaussian_transform.iv0 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

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

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %pos = alloca i32, align 4
  %texel0 = alloca <4 x float>, align 16
  %texel1 = alloca <4 x float>, align 16
  %avg0 = alloca float, align 4
  %avg1 = alloca float, align 4
  %dev0 = alloca float, align 4
  %dev1 = alloca float, align 4
  %gaussian = alloca <2 x float>, align 8
  %tmp_4 = alloca <2 x float>, align 8
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %tmp_1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %tmp_2, align 4
  store i32 %factor, i32* %tmp_3, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  %tmp_7 = mul i32 2, %tmp_6
  %tmp_8 = call i32 @__get_global_id_u32(i32 1)
  %tmp_9 = mul i32 %tmp_7, %tmp_8
  %tmp_10 = add i32 %tmp_5, %tmp_9
  store i32 %tmp_10, i32* %pos, align 4
  %tmp_11 = load i32* %pos, align 4
  %tmp_12 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_13 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_12, i32 %tmp_11
  %tmp_14 = load <4 x i8> addrspace(1)* %tmp_13, align 4
  %tmp_15 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_14)
  store <4 x float> %tmp_15, <4 x float>* %texel0, align 16
  %tmp_16 = load i32* %pos, align 4
  %tmp_17 = call i32 @__get_global_size_u32(i32 0)
  %tmp_18 = add i32 %tmp_16, %tmp_17
  %tmp_19 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_20 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_19, i32 %tmp_18
  %tmp_21 = load <4 x i8> addrspace(1)* %tmp_20, align 4
  %tmp_22 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_21)
  store <4 x float> %tmp_22, <4 x float>* %texel1, align 16
  %tmp_23 = load <4 x float>* %texel0, align 16
  %tmp_24 = extractelement <4 x float> %tmp_23, i32 0
  %tmp_25 = load <4 x float>* %texel0, align 16
  %tmp_26 = extractelement <4 x float> %tmp_25, i32 1
  %tmp_27 = fadd float %tmp_24, %tmp_26
  %tmp_28 = load <4 x float>* %texel0, align 16
  %tmp_29 = extractelement <4 x float> %tmp_28, i32 2
  %tmp_30 = fadd float %tmp_27, %tmp_29
  %tmp_31 = load <4 x float>* %texel0, align 16
  %tmp_32 = extractelement <4 x float> %tmp_31, i32 3
  %tmp_33 = fadd float %tmp_30, %tmp_32
  %tmp_34 = fdiv float %tmp_33, 4.000000e+00, !fpmath !2
  store float %tmp_34, float* %avg0, align 4
  %tmp_35 = load <4 x float>* %texel1, align 16
  %tmp_36 = extractelement <4 x float> %tmp_35, i32 0
  %tmp_37 = load <4 x float>* %texel1, align 16
  %tmp_38 = extractelement <4 x float> %tmp_37, i32 1
  %tmp_39 = fadd float %tmp_36, %tmp_38
  %tmp_40 = load <4 x float>* %texel1, align 16
  %tmp_41 = extractelement <4 x float> %tmp_40, i32 2
  %tmp_42 = fadd float %tmp_39, %tmp_41
  %tmp_43 = load <4 x float>* %texel1, align 16
  %tmp_44 = extractelement <4 x float> %tmp_43, i32 3
  %tmp_45 = fadd float %tmp_42, %tmp_44
  %tmp_46 = fdiv float %tmp_45, 4.000000e+00, !fpmath !2
  store float %tmp_46, float* %avg1, align 4
  %tmp_47 = load float* %avg0, align 4
  %tmp_48 = fsub float -0.000000e+00, %tmp_47
  %tmp_49 = fptosi float %tmp_48 to i32
  %tmp_50 = call float @ran1(i32 %tmp_49, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  store float %tmp_50, float* %dev0, align 4
  %tmp_51 = load float* %avg1, align 4
  %tmp_52 = fsub float -0.000000e+00, %tmp_51
  %tmp_53 = fptosi float %tmp_52 to i32
  %tmp_54 = call float @ran1(i32 %tmp_53, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  store float %tmp_54, float* %dev1, align 4
  %tmp_55 = load float* %dev0, align 4
  %tmp_56 = insertelement <2 x float> undef, float %tmp_55, i32 0
  %tmp_57 = load float* %dev1, align 4
  %tmp_58 = insertelement <2 x float> %tmp_56, float %tmp_57, i32 1
  store <2 x float> %tmp_58, <2 x float>* %tmp_4
  %tmp_59 = load <2 x float>* %tmp_4
  %tmp_60 = call <2 x float> @BoxMuller(<2 x float> %tmp_59)
  store <2 x float> %tmp_60, <2 x float>* %gaussian, align 8
  %tmp_61 = load <4 x float>* %texel0, align 16
  %tmp_62 = load <2 x float>* %gaussian, align 8
  %tmp_63 = extractelement <2 x float> %tmp_62, i32 0
  %tmp_64 = load i32* %tmp_3, align 4
  %tmp_65 = sitofp i32 %tmp_64 to float
  %tmp_66 = fmul float %tmp_63, %tmp_65
  %tmp_67 = insertelement <4 x float> undef, float %tmp_66, i32 0
  %tmp_68 = shufflevector <4 x float> %tmp_67, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_69 = fadd <4 x float> %tmp_61, %tmp_68
  %tmp_70 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %tmp_69)
  %tmp_71 = load i32* %pos, align 4
  %tmp_72 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_73 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_72, i32 %tmp_71
  store <4 x i8> %tmp_70, <4 x i8> addrspace(1)* %tmp_73, align 4
  %tmp_74 = load <4 x float>* %texel1, align 16
  %tmp_75 = load <2 x float>* %gaussian, align 8
  %tmp_76 = extractelement <2 x float> %tmp_75, i32 1
  %tmp_77 = load i32* %tmp_3, align 4
  %tmp_78 = sitofp i32 %tmp_77 to float
  %tmp_79 = fmul float %tmp_76, %tmp_78
  %tmp_80 = insertelement <4 x float> undef, float %tmp_79, i32 0
  %tmp_81 = shufflevector <4 x float> %tmp_80, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_82 = fadd <4 x float> %tmp_74, %tmp_81
  %tmp_83 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %tmp_82)
  %tmp_84 = load i32* %pos, align 4
  %tmp_85 = call i32 @__get_global_size_u32(i32 0)
  %tmp_86 = add i32 %tmp_84, %tmp_85
  %tmp_87 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_88 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_87, i32 %tmp_86
  store <4 x i8> %tmp_83, <4 x i8> addrspace(1)* %tmp_88, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @gaussian_transform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

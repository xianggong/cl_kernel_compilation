; ModuleID = 'GaussianNoise_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@gaussian_transform.iv0 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
  %tmp_3 = call i32 @__get_local_id_u32(i32 0)
  br label %tmp_4

tmp_4:                                            ; preds = %tmp_35, %0
  %j.0 = phi i32 [ 4, %0 ], [ %tmp_37, %tmp_35 ]
  %tmp_1.0 = phi i32 [ %idum, %0 ], [ %tmp_1.1, %tmp_35 ]
  %tmp_6 = icmp sge i32 %j.0, 0
  br i1 %tmp_6, label %tmp_7, label %tmp_38

tmp_7:                                            ; preds = %tmp_4
  %tmp_9 = sdiv i32 %tmp_1.0, 127773
  %tmp_12 = mul nsw i32 %tmp_9, 127773
  %tmp_13 = sub nsw i32 %tmp_1.0, %tmp_12
  %tmp_14 = mul nsw i32 16807, %tmp_13
  %tmp_16 = mul nsw i32 2836, %tmp_9
  %tmp_17 = sub nsw i32 %tmp_14, %tmp_16
  %tmp_19 = icmp slt i32 %tmp_17, 0
  br i1 %tmp_19, label %tmp_20, label %tmp_23

tmp_20:                                           ; preds = %tmp_7
  %tmp_22 = add nsw i32 %tmp_17, 2147483647
  br label %tmp_23

tmp_23:                                           ; preds = %tmp_20, %tmp_7
  %tmp_1.1 = phi i32 [ %tmp_22, %tmp_20 ], [ %tmp_17, %tmp_7 ]
  %tmp_25 = icmp slt i32 %j.0, 4
  br i1 %tmp_25, label %tmp_26, label %tmp_34

tmp_26:                                           ; preds = %tmp_23
  %tmp_29 = mul nsw i32 4, %tmp_3
  %tmp_31 = add nsw i32 %tmp_29, %j.0
  %tmp_33 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %tmp_31
  store i32 %tmp_1.1, i32 addrspace(3)* %tmp_33, align 4
  br label %tmp_34

tmp_34:                                           ; preds = %tmp_26, %tmp_23
  br label %tmp_35

tmp_35:                                           ; preds = %tmp_34
  %tmp_37 = add nsw i32 %j.0, -1
  br label %tmp_4

tmp_38:                                           ; preds = %tmp_4
  %tmp_40 = getelementptr inbounds i32 addrspace(3)* %iv, i32 0
  %tmp_41 = load i32 addrspace(3)* %tmp_40, align 4
  %tmp_43 = sdiv i32 %tmp_1.0, 127773
  %tmp_46 = mul nsw i32 %tmp_43, 127773
  %tmp_47 = sub nsw i32 %tmp_1.0, %tmp_46
  %tmp_48 = mul nsw i32 16807, %tmp_47
  %tmp_50 = mul nsw i32 2836, %tmp_43
  %tmp_51 = sub nsw i32 %tmp_48, %tmp_50
  %tmp_53 = icmp slt i32 %tmp_51, 0
  br i1 %tmp_53, label %tmp_54, label %tmp_57

tmp_54:                                           ; preds = %tmp_38
  %tmp_56 = add nsw i32 %tmp_51, 2147483647
  br label %tmp_57

tmp_57:                                           ; preds = %tmp_54, %tmp_38
  %tmp_59 = sdiv i32 %tmp_41, 536870912
  %tmp_61 = mul nsw i32 4, %tmp_3
  %tmp_63 = add nsw i32 %tmp_61, %tmp_59
  %tmp_65 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %tmp_63
  %tmp_66 = load i32 addrspace(3)* %tmp_65, align 4
  %tmp_68 = sitofp i32 %tmp_66 to float
  %tmp_69 = fmul float 0x3E00000000000000, %tmp_68
  ret float %tmp_69
}

declare i32 @__get_local_id_u32(i32) #1

; Function Attrs: nounwind
define <2 x float> @BoxMuller(<2 x float> %uniform) #0 {
  %tmp_4 = extractelement <2 x float> %uniform, i32 0
  %tmp_5 = call float @llvm.log2.f32(float %tmp_4)
  %tmp_6 = fmul float %tmp_5, 0x3FE62E4300000000
  %tmp_7 = fmul float -2.000000e+00, %tmp_6
  %tmp_8 = call float @llvm.sqrt.f32(float %tmp_7)
  %tmp_10 = extractelement <2 x float> %uniform, i32 1
  %tmp_11 = fmul float 0x40191EB860000000, %tmp_10
  %tmp_14 = call float @_Z3sinf(float %tmp_11)
  %tmp_15 = fmul float %tmp_8, %tmp_14
  %tmp_16 = insertelement <2 x float> undef, float %tmp_15, i32 0
  %tmp_19 = call float @_Z3cosf(float %tmp_11)
  %tmp_20 = fmul float %tmp_8, %tmp_19
  %tmp_21 = insertelement <2 x float> %tmp_16, float %tmp_20, i32 1
  ret <2 x float> %tmp_21
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  %tmp_7 = mul i32 2, %tmp_6
  %tmp_8 = call i32 @__get_global_id_u32(i32 1)
  %tmp_9 = mul i32 %tmp_7, %tmp_8
  %tmp_10 = add i32 %tmp_5, %tmp_9
  %tmp_13 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_10
  %tmp_14 = load <4 x i8> addrspace(1)* %tmp_13, align 4
  %tmp_15 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_14)
  %tmp_17 = call i32 @__get_global_size_u32(i32 0)
  %tmp_18 = add i32 %tmp_10, %tmp_17
  %tmp_20 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_18
  %tmp_21 = load <4 x i8> addrspace(1)* %tmp_20, align 4
  %tmp_22 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_21)
  %tmp_24 = extractelement <4 x float> %tmp_15, i32 0
  %tmp_26 = extractelement <4 x float> %tmp_15, i32 1
  %tmp_27 = fadd float %tmp_24, %tmp_26
  %tmp_29 = extractelement <4 x float> %tmp_15, i32 2
  %tmp_30 = fadd float %tmp_27, %tmp_29
  %tmp_32 = extractelement <4 x float> %tmp_15, i32 3
  %tmp_33 = fadd float %tmp_30, %tmp_32
  %tmp_34 = fdiv float %tmp_33, 4.000000e+00, !fpmath !2
  %tmp_36 = extractelement <4 x float> %tmp_22, i32 0
  %tmp_38 = extractelement <4 x float> %tmp_22, i32 1
  %tmp_39 = fadd float %tmp_36, %tmp_38
  %tmp_41 = extractelement <4 x float> %tmp_22, i32 2
  %tmp_42 = fadd float %tmp_39, %tmp_41
  %tmp_44 = extractelement <4 x float> %tmp_22, i32 3
  %tmp_45 = fadd float %tmp_42, %tmp_44
  %tmp_46 = fdiv float %tmp_45, 4.000000e+00, !fpmath !2
  %tmp_48 = fsub float -0.000000e+00, %tmp_34
  %tmp_49 = fptosi float %tmp_48 to i32
  %tmp_50 = call float @ran1(i32 %tmp_49, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  %tmp_52 = fsub float -0.000000e+00, %tmp_46
  %tmp_53 = fptosi float %tmp_52 to i32
  %tmp_54 = call float @ran1(i32 %tmp_53, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  %tmp_56 = insertelement <2 x float> undef, float %tmp_50, i32 0
  %tmp_58 = insertelement <2 x float> %tmp_56, float %tmp_54, i32 1
  %tmp_60 = call <2 x float> @BoxMuller(<2 x float> %tmp_58)
  %tmp_63 = extractelement <2 x float> %tmp_60, i32 0
  %tmp_65 = sitofp i32 %factor to float
  %tmp_66 = fmul float %tmp_63, %tmp_65
  %tmp_67 = insertelement <4 x float> undef, float %tmp_66, i32 0
  %tmp_68 = shufflevector <4 x float> %tmp_67, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_69 = fadd <4 x float> %tmp_15, %tmp_68
  %tmp_70 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %tmp_69)
  %tmp_73 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_10
  store <4 x i8> %tmp_70, <4 x i8> addrspace(1)* %tmp_73, align 4
  %tmp_76 = extractelement <2 x float> %tmp_60, i32 1
  %tmp_78 = sitofp i32 %factor to float
  %tmp_79 = fmul float %tmp_76, %tmp_78
  %tmp_80 = insertelement <4 x float> undef, float %tmp_79, i32 0
  %tmp_81 = shufflevector <4 x float> %tmp_80, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_82 = fadd <4 x float> %tmp_22, %tmp_81
  %tmp_83 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %tmp_82)
  %tmp_85 = call i32 @__get_global_size_u32(i32 0)
  %tmp_86 = add i32 %tmp_10, %tmp_85
  %tmp_88 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_86
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

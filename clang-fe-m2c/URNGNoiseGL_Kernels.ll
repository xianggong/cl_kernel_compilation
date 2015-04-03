; ModuleID = '../kernel-src/URNGNoiseGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@noise_uniform.iv = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

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
  %tmp_39 = load i32* %tid, align 4
  %tmp_40 = mul nsw i32 4, %tmp_39
  %tmp_41 = load i32 addrspace(3)** %tmp_2, align 4
  %tmp_42 = getelementptr inbounds i32 addrspace(3)* %tmp_41, i32 %tmp_40
  %tmp_43 = load i32 addrspace(3)* %tmp_42, align 4
  store i32 %tmp_43, i32* %iy, align 4
  %tmp_44 = load i32* %tmp_1, align 4
  %tmp_45 = sdiv i32 %tmp_44, 127773
  store i32 %tmp_45, i32* %k, align 4
  %tmp_46 = load i32* %tmp_1, align 4
  %tmp_47 = load i32* %k, align 4
  %tmp_48 = mul nsw i32 %tmp_47, 127773
  %tmp_49 = sub nsw i32 %tmp_46, %tmp_48
  %tmp_50 = mul nsw i32 16807, %tmp_49
  %tmp_51 = load i32* %k, align 4
  %tmp_52 = mul nsw i32 2836, %tmp_51
  %tmp_53 = sub nsw i32 %tmp_50, %tmp_52
  store i32 %tmp_53, i32* %tmp_1, align 4
  %tmp_54 = load i32* %tmp_1, align 4
  %tmp_55 = icmp slt i32 %tmp_54, 0
  br i1 %tmp_55, label %tmp_56, label %tmp_59

tmp_56:                                      ; preds = %tmp_38
  %tmp_57 = load i32* %tmp_1, align 4
  %tmp_58 = add nsw i32 %tmp_57, 2147483647
  store i32 %tmp_58, i32* %tmp_1, align 4
  br label %tmp_59

tmp_59:                                      ; preds = %tmp_56, %tmp_38
  %tmp_60 = load i32* %iy, align 4
  %tmp_61 = sdiv i32 %tmp_60, 536870912
  store i32 %tmp_61, i32* %j, align 4
  %tmp_62 = load i32* %tid, align 4
  %tmp_63 = mul nsw i32 4, %tmp_62
  %tmp_64 = load i32* %j, align 4
  %tmp_65 = add nsw i32 %tmp_63, %tmp_64
  %tmp_66 = load i32 addrspace(3)** %tmp_2, align 4
  %tmp_67 = getelementptr inbounds i32 addrspace(3)* %tmp_66, i32 %tmp_65
  %tmp_68 = load i32 addrspace(3)* %tmp_67, align 4
  store i32 %tmp_68, i32* %iy, align 4
  %tmp_69 = load i32* %iy, align 4
  %tmp_70 = sitofp i32 %tmp_69 to float
  %tmp_71 = fmul float 0x3E00000000000000, %tmp_70
  ret float %tmp_71
}

declare i32 @__get_local_id_u32(i32) #1

; Function Attrs: nounwind
define void @noise_uniform(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %pos = alloca i32, align 4
  %temp = alloca <4 x float>, align 16
  %avg = alloca float, align 4
  %dev = alloca float, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %tmp_1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %tmp_2, align 4
  store i32 %factor, i32* %tmp_3, align 4
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = call i32 @__get_global_id_u32(i32 1)
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  %tmp_7 = mul i32 %tmp_5, %tmp_6
  %tmp_8 = add i32 %tmp_4, %tmp_7
  store i32 %tmp_8, i32* %pos, align 4
  %tmp_9 = load i32* %pos, align 4
  %tmp_10 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_11 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_10, i32 %tmp_9
  %tmp_12 = load <4 x i8> addrspace(1)* %tmp_11, align 4
  %tmp_13 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_12)
  store <4 x float> %tmp_13, <4 x float>* %temp, align 16
  %tmp_14 = load <4 x float>* %temp, align 16
  %tmp_15 = extractelement <4 x float> %tmp_14, i32 0
  %tmp_16 = load <4 x float>* %temp, align 16
  %tmp_17 = extractelement <4 x float> %tmp_16, i32 1
  %tmp_18 = fadd float %tmp_15, %tmp_17
  %tmp_19 = load <4 x float>* %temp, align 16
  %tmp_20 = extractelement <4 x float> %tmp_19, i32 2
  %tmp_21 = fadd float %tmp_18, %tmp_20
  %tmp_22 = load <4 x float>* %temp, align 16
  %tmp_23 = extractelement <4 x float> %tmp_22, i32 1
  %tmp_24 = fadd float %tmp_21, %tmp_23
  %tmp_25 = fdiv float %tmp_24, 4.000000e+00, !fpmath !2
  store float %tmp_25, float* %avg, align 4
  %tmp_26 = load float* %avg, align 4
  %tmp_27 = fsub float -0.000000e+00, %tmp_26
  %tmp_28 = fptosi float %tmp_27 to i32
  %tmp_29 = call float @ran1(i32 %tmp_28, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  store float %tmp_29, float* %dev, align 4
  %tmp_30 = load float* %dev, align 4
  %tmp_31 = fsub float %tmp_30, 5.000000e-01
  %tmp_32 = load i32* %tmp_3, align 4
  %tmp_33 = sitofp i32 %tmp_32 to float
  %tmp_34 = fmul float %tmp_31, %tmp_33
  store float %tmp_34, float* %dev, align 4
  %tmp_35 = load <4 x float>* %temp, align 16
  %tmp_36 = load float* %dev, align 4
  %tmp_37 = insertelement <4 x float> undef, float %tmp_36, i32 0
  %tmp_38 = shufflevector <4 x float> %tmp_37, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_39 = fadd <4 x float> %tmp_35, %tmp_38
  %tmp_40 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %tmp_39)
  %tmp_41 = load i32* %pos, align 4
  %tmp_42 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_43 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_42, i32 %tmp_41
  store <4 x i8> %tmp_40, <4 x i8> addrspace(1)* %tmp_43, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @noise_uniform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

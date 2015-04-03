; ModuleID = '../kernel-src/GaussianNoiseGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%opencl.image2d_t = type opaque

@gaussian_transform.iv0 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* %inputImage, %opencl.image2d_t* %outputImage, i32 %factor) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca %opencl.image2d_t*, align 4
  %tmp_3 = alloca i32, align 4
  %pos0 = alloca i32, align 4
  %pos1 = alloca i32, align 4
  %texel0 = alloca <4 x float>, align 16
  %texel1 = alloca <4 x float>, align 16
  %avg0 = alloca float, align 4
  %avg1 = alloca float, align 4
  %dev0 = alloca float, align 4
  %dev1 = alloca float, align 4
  %gaussian = alloca <2 x float>, align 8
  %tmp_4 = alloca <2 x float>, align 8
  %out0 = alloca <4 x float>, align 16
  %out1 = alloca <4 x float>, align 16
  %locate0 = alloca <2 x i32>, align 8
  %locate1 = alloca <2 x i32>, align 8
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %tmp_1, align 4
  store %opencl.image2d_t* %outputImage, %opencl.image2d_t** %tmp_2, align 4
  store i32 %factor, i32* %tmp_3, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  %tmp_7 = mul i32 2, %tmp_6
  %tmp_8 = call i32 @__get_global_id_u32(i32 1)
  %tmp_9 = mul i32 %tmp_7, %tmp_8
  %tmp_10 = add i32 %tmp_5, %tmp_9
  store i32 %tmp_10, i32* %pos0, align 4
  %tmp_11 = call i32 @__get_global_id_u32(i32 0)
  %tmp_12 = call i32 @__get_global_size_u32(i32 0)
  %tmp_13 = add i32 %tmp_11, %tmp_12
  %tmp_14 = call i32 @__get_global_size_u32(i32 0)
  %tmp_15 = mul i32 2, %tmp_14
  %tmp_16 = call i32 @__get_global_id_u32(i32 1)
  %tmp_17 = mul i32 %tmp_15, %tmp_16
  %tmp_18 = add i32 %tmp_13, %tmp_17
  store i32 %tmp_18, i32* %pos1, align 4
  %tmp_19 = load i32* %pos0, align 4
  %tmp_20 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_21 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_20, i32 %tmp_19
  %tmp_22 = load <4 x i8> addrspace(1)* %tmp_21, align 4
  %tmp_23 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_22)
  store <4 x float> %tmp_23, <4 x float>* %texel0, align 16
  %tmp_24 = load i32* %pos1, align 4
  %tmp_25 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_26 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_25, i32 %tmp_24
  %tmp_27 = load <4 x i8> addrspace(1)* %tmp_26, align 4
  %tmp_28 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_27)
  store <4 x float> %tmp_28, <4 x float>* %texel1, align 16
  %tmp_29 = load <4 x float>* %texel0, align 16
  %tmp_30 = extractelement <4 x float> %tmp_29, i32 0
  %tmp_31 = load <4 x float>* %texel0, align 16
  %tmp_32 = extractelement <4 x float> %tmp_31, i32 1
  %tmp_33 = fadd float %tmp_30, %tmp_32
  %tmp_34 = load <4 x float>* %texel0, align 16
  %tmp_35 = extractelement <4 x float> %tmp_34, i32 2
  %tmp_36 = fadd float %tmp_33, %tmp_35
  %tmp_37 = load <4 x float>* %texel0, align 16
  %tmp_38 = extractelement <4 x float> %tmp_37, i32 3
  %tmp_39 = fadd float %tmp_36, %tmp_38
  %tmp_40 = fdiv float %tmp_39, 4.000000e+00, !fpmath !2
  store float %tmp_40, float* %avg0, align 4
  %tmp_41 = load <4 x float>* %texel1, align 16
  %tmp_42 = extractelement <4 x float> %tmp_41, i32 0
  %tmp_43 = load <4 x float>* %texel1, align 16
  %tmp_44 = extractelement <4 x float> %tmp_43, i32 1
  %tmp_45 = fadd float %tmp_42, %tmp_44
  %tmp_46 = load <4 x float>* %texel1, align 16
  %tmp_47 = extractelement <4 x float> %tmp_46, i32 2
  %tmp_48 = fadd float %tmp_45, %tmp_47
  %tmp_49 = load <4 x float>* %texel1, align 16
  %tmp_50 = extractelement <4 x float> %tmp_49, i32 3
  %tmp_51 = fadd float %tmp_48, %tmp_50
  %tmp_52 = fdiv float %tmp_51, 4.000000e+00, !fpmath !2
  store float %tmp_52, float* %avg1, align 4
  %tmp_53 = load float* %avg0, align 4
  %tmp_54 = fsub float -0.000000e+00, %tmp_53
  %tmp_55 = fptosi float %tmp_54 to i32
  %tmp_56 = call float @ran1(i32 %tmp_55, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0))
  store float %tmp_56, float* %dev0, align 4
  %tmp_57 = load float* %avg1, align 4
  %tmp_58 = fsub float -0.000000e+00, %tmp_57
  %tmp_59 = fptosi float %tmp_58 to i32
  %tmp_60 = call float @ran1(i32 %tmp_59, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0))
  store float %tmp_60, float* %dev1, align 4
  %tmp_61 = load float* %dev0, align 4
  %tmp_62 = insertelement <2 x float> undef, float %tmp_61, i32 0
  %tmp_63 = load float* %dev1, align 4
  %tmp_64 = insertelement <2 x float> %tmp_62, float %tmp_63, i32 1
  store <2 x float> %tmp_64, <2 x float>* %tmp_4
  %tmp_65 = load <2 x float>* %tmp_4
  %tmp_66 = call <2 x float> @BoxMuller(<2 x float> %tmp_65)
  store <2 x float> %tmp_66, <2 x float>* %gaussian, align 8
  %tmp_67 = load <4 x float>* %texel0, align 16
  %tmp_68 = load <2 x float>* %gaussian, align 8
  %tmp_69 = extractelement <2 x float> %tmp_68, i32 0
  %tmp_70 = load i32* %tmp_3, align 4
  %tmp_71 = sitofp i32 %tmp_70 to float
  %tmp_72 = fmul float %tmp_69, %tmp_71
  %tmp_73 = insertelement <4 x float> undef, float %tmp_72, i32 0
  %tmp_74 = shufflevector <4 x float> %tmp_73, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_75 = fadd <4 x float> %tmp_67, %tmp_74
  %tmp_76 = fdiv <4 x float> %tmp_75, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !2
  store <4 x float> %tmp_76, <4 x float>* %out0, align 16
  %tmp_77 = load <4 x float>* %texel1, align 16
  %tmp_78 = load <2 x float>* %gaussian, align 8
  %tmp_79 = extractelement <2 x float> %tmp_78, i32 1
  %tmp_80 = load i32* %tmp_3, align 4
  %tmp_81 = sitofp i32 %tmp_80 to float
  %tmp_82 = fmul float %tmp_79, %tmp_81
  %tmp_83 = insertelement <4 x float> undef, float %tmp_82, i32 0
  %tmp_84 = shufflevector <4 x float> %tmp_83, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_85 = fadd <4 x float> %tmp_77, %tmp_84
  %tmp_86 = fdiv <4 x float> %tmp_85, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !2
  store <4 x float> %tmp_86, <4 x float>* %out1, align 16
  %tmp_87 = call i32 @__get_global_id_u32(i32 0)
  %tmp_88 = load <2 x i32>* %locate0, align 8
  %tmp_89 = insertelement <2 x i32> %tmp_88, i32 %tmp_87, i32 0
  store <2 x i32> %tmp_89, <2 x i32>* %locate0, align 8
  %tmp_90 = call i32 @__get_global_id_u32(i32 1)
  %tmp_91 = load <2 x i32>* %locate0, align 8
  %tmp_92 = insertelement <2 x i32> %tmp_91, i32 %tmp_90, i32 1
  store <2 x i32> %tmp_92, <2 x i32>* %locate0, align 8
  %tmp_93 = call i32 @__get_global_id_u32(i32 0)
  %tmp_94 = call i32 @__get_global_size_u32(i32 0)
  %tmp_95 = add i32 %tmp_93, %tmp_94
  %tmp_96 = load <2 x i32>* %locate1, align 8
  %tmp_97 = insertelement <2 x i32> %tmp_96, i32 %tmp_95, i32 0
  store <2 x i32> %tmp_97, <2 x i32>* %locate1, align 8
  %tmp_98 = call i32 @__get_global_id_u32(i32 1)
  %tmp_99 = load <2 x i32>* %locate1, align 8
  %tmp_100 = insertelement <2 x i32> %tmp_99, i32 %tmp_98, i32 1
  store <2 x i32> %tmp_100, <2 x i32>* %locate1, align 8
  %tmp_101 = load %opencl.image2d_t** %tmp_2, align 4
  %tmp_102 = load <2 x i32>* %locate0, align 8
  %tmp_103 = load <4 x float>* %out0, align 16
  %tmp_104 = call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t* %tmp_101, <2 x i32> %tmp_102, <4 x float> %tmp_103)
  %tmp_105 = load %opencl.image2d_t** %tmp_2, align 4
  %tmp_106 = load <2 x i32>* %locate1, align 8
  %tmp_107 = load <4 x float>* %out1, align 16
  %tmp_108 = call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t* %tmp_105, <2 x i32> %tmp_106, <4 x float> %tmp_107)
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare float @ran1(i32, i32 addrspace(3)*) #1

declare <2 x float> @BoxMuller(<2 x float>) #1

declare i32 @write_imagef(...) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, %opencl.image2d_t*, i32)* @gaussian_transform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

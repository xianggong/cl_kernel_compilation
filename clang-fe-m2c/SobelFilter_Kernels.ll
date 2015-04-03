; ModuleID = '../kernel-src/SobelFilter_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @sobel_filter(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage) #0 {
  %tmp_1 = alloca <4 x i8> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i8> addrspace(1)*, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %Gx = alloca <4 x float>, align 16
  %Gy = alloca <4 x float>, align 16
  %c = alloca i32, align 4
  %i00 = alloca <4 x float>, align 16
  %i10 = alloca <4 x float>, align 16
  %i20 = alloca <4 x float>, align 16
  %i01 = alloca <4 x float>, align 16
  %i11 = alloca <4 x float>, align 16
  %i21 = alloca <4 x float>, align 16
  %i02 = alloca <4 x float>, align 16
  %i12 = alloca <4 x float>, align 16
  %i22 = alloca <4 x float>, align 16
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %tmp_1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_3, i32* %x, align 4
  %tmp_4 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_4, i32* %y, align 4
  %tmp_5 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_5, i32* %width, align 4
  %tmp_6 = call i32 @__get_global_size_u32(i32 1)
  store i32 %tmp_6, i32* %height, align 4
  store <4 x float> zeroinitializer, <4 x float>* %Gx, align 16
  %tmp_7 = load <4 x float>* %Gx, align 16
  store <4 x float> %tmp_7, <4 x float>* %Gy, align 16
  %tmp_8 = load i32* %x, align 4
  %tmp_9 = load i32* %y, align 4
  %tmp_10 = load i32* %width, align 4
  %tmp_11 = mul i32 %tmp_9, %tmp_10
  %tmp_12 = add i32 %tmp_8, %tmp_11
  store i32 %tmp_12, i32* %c, align 4
  %tmp_13 = load i32* %x, align 4
  %tmp_14 = icmp uge i32 %tmp_13, 1
  br i1 %tmp_14, label %tmp_15, label %tmp_125

tmp_15:                                      ; preds = %tmp_0
  %tmp_16 = load i32* %x, align 4
  %tmp_17 = load i32* %width, align 4
  %tmp_18 = sub i32 %tmp_17, 1
  %tmp_19 = icmp ult i32 %tmp_16, %tmp_18
  br i1 %tmp_19, label %tmp_20, label %tmp_125

tmp_20:                                      ; preds = %tmp_15
  %tmp_21 = load i32* %y, align 4
  %tmp_22 = icmp uge i32 %tmp_21, 1
  br i1 %tmp_22, label %tmp_23, label %tmp_125

tmp_23:                                      ; preds = %tmp_20
  %tmp_24 = load i32* %y, align 4
  %tmp_25 = load i32* %height, align 4
  %tmp_26 = sub i32 %tmp_25, 1
  %tmp_27 = icmp ult i32 %tmp_24, %tmp_26
  br i1 %tmp_27, label %tmp_28, label %tmp_125

tmp_28:                                      ; preds = %tmp_23
  %tmp_29 = load i32* %c, align 4
  %tmp_30 = sub nsw i32 %tmp_29, 1
  %tmp_31 = load i32* %width, align 4
  %tmp_32 = sub i32 %tmp_30, %tmp_31
  %tmp_33 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_34 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_33, i32 %tmp_32
  %tmp_35 = load <4 x i8> addrspace(1)* %tmp_34, align 4
  %tmp_36 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_35)
  store <4 x float> %tmp_36, <4 x float>* %i00, align 16
  %tmp_37 = load i32* %c, align 4
  %tmp_38 = load i32* %width, align 4
  %tmp_39 = sub i32 %tmp_37, %tmp_38
  %tmp_40 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_41 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_40, i32 %tmp_39
  %tmp_42 = load <4 x i8> addrspace(1)* %tmp_41, align 4
  %tmp_43 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_42)
  store <4 x float> %tmp_43, <4 x float>* %i10, align 16
  %tmp_44 = load i32* %c, align 4
  %tmp_45 = add nsw i32 %tmp_44, 1
  %tmp_46 = load i32* %width, align 4
  %tmp_47 = sub i32 %tmp_45, %tmp_46
  %tmp_48 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_49 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_48, i32 %tmp_47
  %tmp_50 = load <4 x i8> addrspace(1)* %tmp_49, align 4
  %tmp_51 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_50)
  store <4 x float> %tmp_51, <4 x float>* %i20, align 16
  %tmp_52 = load i32* %c, align 4
  %tmp_53 = sub nsw i32 %tmp_52, 1
  %tmp_54 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_55 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_54, i32 %tmp_53
  %tmp_56 = load <4 x i8> addrspace(1)* %tmp_55, align 4
  %tmp_57 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_56)
  store <4 x float> %tmp_57, <4 x float>* %i01, align 16
  %tmp_58 = load i32* %c, align 4
  %tmp_59 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_60 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_59, i32 %tmp_58
  %tmp_61 = load <4 x i8> addrspace(1)* %tmp_60, align 4
  %tmp_62 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_61)
  store <4 x float> %tmp_62, <4 x float>* %i11, align 16
  %tmp_63 = load i32* %c, align 4
  %tmp_64 = add nsw i32 %tmp_63, 1
  %tmp_65 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_66 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_65, i32 %tmp_64
  %tmp_67 = load <4 x i8> addrspace(1)* %tmp_66, align 4
  %tmp_68 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_67)
  store <4 x float> %tmp_68, <4 x float>* %i21, align 16
  %tmp_69 = load i32* %c, align 4
  %tmp_70 = sub nsw i32 %tmp_69, 1
  %tmp_71 = load i32* %width, align 4
  %tmp_72 = add i32 %tmp_70, %tmp_71
  %tmp_73 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_74 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_73, i32 %tmp_72
  %tmp_75 = load <4 x i8> addrspace(1)* %tmp_74, align 4
  %tmp_76 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_75)
  store <4 x float> %tmp_76, <4 x float>* %i02, align 16
  %tmp_77 = load i32* %c, align 4
  %tmp_78 = load i32* %width, align 4
  %tmp_79 = add i32 %tmp_77, %tmp_78
  %tmp_80 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_81 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_80, i32 %tmp_79
  %tmp_82 = load <4 x i8> addrspace(1)* %tmp_81, align 4
  %tmp_83 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_82)
  store <4 x float> %tmp_83, <4 x float>* %i12, align 16
  %tmp_84 = load i32* %c, align 4
  %tmp_85 = add nsw i32 %tmp_84, 1
  %tmp_86 = load i32* %width, align 4
  %tmp_87 = add i32 %tmp_85, %tmp_86
  %tmp_88 = load <4 x i8> addrspace(1)** %tmp_1, align 4
  %tmp_89 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_88, i32 %tmp_87
  %tmp_90 = load <4 x i8> addrspace(1)* %tmp_89, align 4
  %tmp_91 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_90)
  store <4 x float> %tmp_91, <4 x float>* %i22, align 16
  %tmp_92 = load <4 x float>* %i00, align 16
  %tmp_93 = load <4 x float>* %i10, align 16
  %tmp_94 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %tmp_93, <4 x float> %tmp_92)
  %tmp_95 = load <4 x float>* %i20, align 16
  %tmp_96 = fadd <4 x float> %tmp_94, %tmp_95
  %tmp_97 = load <4 x float>* %i02, align 16
  %tmp_98 = fsub <4 x float> %tmp_96, %tmp_97
  %tmp_99 = load <4 x float>* %i12, align 16
  %tmp_100 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_99
  %tmp_101 = fsub <4 x float> %tmp_98, %tmp_100
  %tmp_102 = load <4 x float>* %i22, align 16
  %tmp_103 = fsub <4 x float> %tmp_101, %tmp_102
  store <4 x float> %tmp_103, <4 x float>* %Gx, align 16
  %tmp_104 = load <4 x float>* %i00, align 16
  %tmp_105 = load <4 x float>* %i20, align 16
  %tmp_106 = fsub <4 x float> %tmp_104, %tmp_105
  %tmp_107 = load <4 x float>* %i01, align 16
  %tmp_108 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_107
  %tmp_109 = fadd <4 x float> %tmp_106, %tmp_108
  %tmp_110 = load <4 x float>* %i21, align 16
  %tmp_111 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_110
  %tmp_112 = fsub <4 x float> %tmp_109, %tmp_111
  %tmp_113 = load <4 x float>* %i02, align 16
  %tmp_114 = fadd <4 x float> %tmp_112, %tmp_113
  %tmp_115 = load <4 x float>* %i22, align 16
  %tmp_116 = fsub <4 x float> %tmp_114, %tmp_115
  store <4 x float> %tmp_116, <4 x float>* %Gy, align 16
  %tmp_117 = load <4 x float>* %Gx, align 16
  %tmp_118 = load <4 x float>* %Gy, align 16
  %tmp_119 = call <4 x float> @_Z5hypotDv4_fS_(<4 x float> %tmp_117, <4 x float> %tmp_118)
  %tmp_120 = fdiv <4 x float> %tmp_119, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !2
  %tmp_121 = call <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %tmp_120)
  %tmp_122 = load i32* %c, align 4
  %tmp_123 = load <4 x i8> addrspace(1)** %tmp_2, align 4
  %tmp_124 = getelementptr inbounds <4 x i8> addrspace(1)* %tmp_123, i32 %tmp_122
  store <4 x i8> %tmp_121, <4 x i8> addrspace(1)* %tmp_124, align 4
  br label %tmp_125

tmp_125:                                     ; preds = %tmp_28, %tmp_23, %tmp_20, %tmp_15, %tmp_0
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float>) #1

declare <4 x float> @_Z5hypotDv4_fS_(<4 x float>, <4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*)* @sobel_filter}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

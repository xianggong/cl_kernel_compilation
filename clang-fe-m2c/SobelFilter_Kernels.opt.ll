; ModuleID = 'SobelFilter_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @sobel_filter(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = call i32 @__get_global_id_u32(i32 1)
  %tmp_5 = call i32 @__get_global_size_u32(i32 0)
  %tmp_6 = call i32 @__get_global_size_u32(i32 1)
  %tmp_11 = mul i32 %tmp_4, %tmp_5
  %tmp_12 = add i32 %tmp_3, %tmp_11
  %tmp_14 = icmp uge i32 %tmp_3, 1
  br i1 %tmp_14, label %tmp_15, label %tmp_125

tmp_15:                                           ; preds = %0
  %tmp_18 = sub i32 %tmp_5, 1
  %tmp_19 = icmp ult i32 %tmp_3, %tmp_18
  br i1 %tmp_19, label %tmp_20, label %tmp_125

tmp_20:                                           ; preds = %tmp_15
  %tmp_22 = icmp uge i32 %tmp_4, 1
  br i1 %tmp_22, label %tmp_23, label %tmp_125

tmp_23:                                           ; preds = %tmp_20
  %tmp_26 = sub i32 %tmp_6, 1
  %tmp_27 = icmp ult i32 %tmp_4, %tmp_26
  br i1 %tmp_27, label %tmp_28, label %tmp_125

tmp_28:                                           ; preds = %tmp_23
  %tmp_30 = sub nsw i32 %tmp_12, 1
  %tmp_32 = sub i32 %tmp_30, %tmp_5
  %tmp_34 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_32
  %tmp_35 = load <4 x i8> addrspace(1)* %tmp_34, align 4
  %tmp_36 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_35)
  %tmp_39 = sub i32 %tmp_12, %tmp_5
  %tmp_41 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_39
  %tmp_42 = load <4 x i8> addrspace(1)* %tmp_41, align 4
  %tmp_43 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_42)
  %tmp_45 = add nsw i32 %tmp_12, 1
  %tmp_47 = sub i32 %tmp_45, %tmp_5
  %tmp_49 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_47
  %tmp_50 = load <4 x i8> addrspace(1)* %tmp_49, align 4
  %tmp_51 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_50)
  %tmp_53 = sub nsw i32 %tmp_12, 1
  %tmp_55 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_53
  %tmp_56 = load <4 x i8> addrspace(1)* %tmp_55, align 4
  %tmp_57 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_56)
  %tmp_60 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_12
  %tmp_61 = load <4 x i8> addrspace(1)* %tmp_60, align 4
  %tmp_62 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_61)
  %tmp_64 = add nsw i32 %tmp_12, 1
  %tmp_66 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_64
  %tmp_67 = load <4 x i8> addrspace(1)* %tmp_66, align 4
  %tmp_68 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_67)
  %tmp_70 = sub nsw i32 %tmp_12, 1
  %tmp_72 = add i32 %tmp_70, %tmp_5
  %tmp_74 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_72
  %tmp_75 = load <4 x i8> addrspace(1)* %tmp_74, align 4
  %tmp_76 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_75)
  %tmp_79 = add i32 %tmp_12, %tmp_5
  %tmp_81 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_79
  %tmp_82 = load <4 x i8> addrspace(1)* %tmp_81, align 4
  %tmp_83 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_82)
  %tmp_85 = add nsw i32 %tmp_12, 1
  %tmp_87 = add i32 %tmp_85, %tmp_5
  %tmp_89 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_87
  %tmp_90 = load <4 x i8> addrspace(1)* %tmp_89, align 4
  %tmp_91 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_90)
  %tmp_94 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %tmp_43, <4 x float> %tmp_36)
  %tmp_96 = fadd <4 x float> %tmp_94, %tmp_51
  %tmp_98 = fsub <4 x float> %tmp_96, %tmp_76
  %tmp_100 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_83
  %tmp_101 = fsub <4 x float> %tmp_98, %tmp_100
  %tmp_103 = fsub <4 x float> %tmp_101, %tmp_91
  %tmp_106 = fsub <4 x float> %tmp_36, %tmp_51
  %tmp_108 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_57
  %tmp_109 = fadd <4 x float> %tmp_106, %tmp_108
  %tmp_111 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %tmp_68
  %tmp_112 = fsub <4 x float> %tmp_109, %tmp_111
  %tmp_114 = fadd <4 x float> %tmp_112, %tmp_76
  %tmp_116 = fsub <4 x float> %tmp_114, %tmp_91
  %tmp_119 = call <4 x float> @_Z5hypotDv4_fS_(<4 x float> %tmp_103, <4 x float> %tmp_116)
  %tmp_120 = fdiv <4 x float> %tmp_119, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !2
  %tmp_121 = call <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %tmp_120)
  %tmp_124 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_12
  store <4 x i8> %tmp_121, <4 x i8> addrspace(1)* %tmp_124, align 4
  br label %tmp_125

tmp_125:                                          ; preds = %tmp_28, %tmp_23, %tmp_20, %tmp_15, %0
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

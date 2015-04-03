; ModuleID = '../kernel-src/SimpleConvolution_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @simpleConvolution(i32 addrspace(1)* %output, i32 addrspace(1)* %input, float addrspace(1)* %mask, <2 x i32> %inputDimensions, <2 x i32> %maskDimensions) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca float addrspace(1)*, align 4
  %tmp_4 = alloca <2 x i32>, align 8
  %tmp_5 = alloca <2 x i32>, align 8
  %tid = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %maskWidth = alloca i32, align 4
  %maskHeight = alloca i32, align 4
  %vstep = alloca i32, align 4
  %hstep = alloca i32, align 4
  %left = alloca i32, align 4
  %right = alloca i32, align 4
  %top = alloca i32, align 4
  %bottom = alloca i32, align 4
  %sumFX = alloca float, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %maskIndex = alloca i32, align 4
  %index = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %tmp_2, align 4
  store float addrspace(1)* %mask, float addrspace(1)** %tmp_3, align 4
  store <2 x i32> %inputDimensions, <2 x i32>* %tmp_4, align 8
  store <2 x i32> %maskDimensions, <2 x i32>* %tmp_5, align 8
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_6, i32* %tid, align 4
  %tmp_7 = load <2 x i32>* %tmp_4, align 8
  %tmp_8 = extractelement <2 x i32> %tmp_7, i32 0
  store i32 %tmp_8, i32* %width, align 4
  %tmp_9 = load <2 x i32>* %tmp_4, align 8
  %tmp_10 = extractelement <2 x i32> %tmp_9, i32 1
  store i32 %tmp_10, i32* %height, align 4
  %tmp_11 = load i32* %tid, align 4
  %tmp_12 = load i32* %width, align 4
  %tmp_13 = urem i32 %tmp_11, %tmp_12
  store i32 %tmp_13, i32* %x, align 4
  %tmp_14 = load i32* %tid, align 4
  %tmp_15 = load i32* %width, align 4
  %tmp_16 = udiv i32 %tmp_14, %tmp_15
  store i32 %tmp_16, i32* %y, align 4
  %tmp_17 = load <2 x i32>* %tmp_5, align 8
  %tmp_18 = extractelement <2 x i32> %tmp_17, i32 0
  store i32 %tmp_18, i32* %maskWidth, align 4
  %tmp_19 = load <2 x i32>* %tmp_5, align 8
  %tmp_20 = extractelement <2 x i32> %tmp_19, i32 1
  store i32 %tmp_20, i32* %maskHeight, align 4
  %tmp_21 = load i32* %maskWidth, align 4
  %tmp_22 = sub i32 %tmp_21, 1
  %tmp_23 = udiv i32 %tmp_22, 2
  store i32 %tmp_23, i32* %vstep, align 4
  %tmp_24 = load i32* %maskHeight, align 4
  %tmp_25 = sub i32 %tmp_24, 1
  %tmp_26 = udiv i32 %tmp_25, 2
  store i32 %tmp_26, i32* %hstep, align 4
  %tmp_27 = load i32* %x, align 4
  %tmp_28 = load i32* %vstep, align 4
  %tmp_29 = icmp ult i32 %tmp_27, %tmp_28
  br i1 %tmp_29, label %tmp_30, label %tmp_31

tmp_30:                                      ; preds = %tmp_0
  br label %tmp_35

tmp_31:                                      ; preds = %tmp_0
  %tmp_32 = load i32* %x, align 4
  %tmp_33 = load i32* %vstep, align 4
  %tmp_34 = sub i32 %tmp_32, %tmp_33
  br label %tmp_35

tmp_35:                                      ; preds = %tmp_31, %tmp_30
  %tmp_36 = phi i32 [ 0, %tmp_30 ], [ %tmp_34, %tmp_31 ]
  store i32 %tmp_36, i32* %left, align 4
  %tmp_37 = load i32* %x, align 4
  %tmp_38 = load i32* %vstep, align 4
  %tmp_39 = add i32 %tmp_37, %tmp_38
  %tmp_40 = load i32* %width, align 4
  %tmp_41 = icmp uge i32 %tmp_39, %tmp_40
  br i1 %tmp_41, label %tmp_42, label %tmp_45

tmp_42:                                      ; preds = %tmp_35
  %tmp_43 = load i32* %width, align 4
  %tmp_44 = sub i32 %tmp_43, 1
  br label %tmp_49

tmp_45:                                      ; preds = %tmp_35
  %tmp_46 = load i32* %x, align 4
  %tmp_47 = load i32* %vstep, align 4
  %tmp_48 = add i32 %tmp_46, %tmp_47
  br label %tmp_49

tmp_49:                                      ; preds = %tmp_45, %tmp_42
  %tmp_50 = phi i32 [ %tmp_44, %tmp_42 ], [ %tmp_48, %tmp_45 ]
  store i32 %tmp_50, i32* %right, align 4
  %tmp_51 = load i32* %y, align 4
  %tmp_52 = load i32* %hstep, align 4
  %tmp_53 = icmp ult i32 %tmp_51, %tmp_52
  br i1 %tmp_53, label %tmp_54, label %tmp_55

tmp_54:                                      ; preds = %tmp_49
  br label %tmp_59

tmp_55:                                      ; preds = %tmp_49
  %tmp_56 = load i32* %y, align 4
  %tmp_57 = load i32* %hstep, align 4
  %tmp_58 = sub i32 %tmp_56, %tmp_57
  br label %tmp_59

tmp_59:                                      ; preds = %tmp_55, %tmp_54
  %tmp_60 = phi i32 [ 0, %tmp_54 ], [ %tmp_58, %tmp_55 ]
  store i32 %tmp_60, i32* %top, align 4
  %tmp_61 = load i32* %y, align 4
  %tmp_62 = load i32* %hstep, align 4
  %tmp_63 = add i32 %tmp_61, %tmp_62
  %tmp_64 = load i32* %height, align 4
  %tmp_65 = icmp uge i32 %tmp_63, %tmp_64
  br i1 %tmp_65, label %tmp_66, label %tmp_69

tmp_66:                                      ; preds = %tmp_59
  %tmp_67 = load i32* %height, align 4
  %tmp_68 = sub i32 %tmp_67, 1
  br label %tmp_73

tmp_69:                                      ; preds = %tmp_59
  %tmp_70 = load i32* %y, align 4
  %tmp_71 = load i32* %hstep, align 4
  %tmp_72 = add i32 %tmp_70, %tmp_71
  br label %tmp_73

tmp_73:                                      ; preds = %tmp_69, %tmp_66
  %tmp_74 = phi i32 [ %tmp_68, %tmp_66 ], [ %tmp_72, %tmp_69 ]
  store i32 %tmp_74, i32* %bottom, align 4
  store float 0.000000e+00, float* %sumFX, align 4
  %tmp_75 = load i32* %left, align 4
  store i32 %tmp_75, i32* %i, align 4
  br label %tmp_76

tmp_76:                                      ; preds = %tmp_121, %tmp_73
  %tmp_77 = load i32* %i, align 4
  %tmp_78 = load i32* %right, align 4
  %tmp_79 = icmp ule i32 %tmp_77, %tmp_78
  br i1 %tmp_79, label %tmp_80, label %tmp_124

tmp_80:                                      ; preds = %tmp_76
  %tmp_81 = load i32* %top, align 4
  store i32 %tmp_81, i32* %j, align 4
  br label %tmp_82

tmp_82:                                      ; preds = %tmp_117, %tmp_80
  %tmp_83 = load i32* %j, align 4
  %tmp_84 = load i32* %bottom, align 4
  %tmp_85 = icmp ule i32 %tmp_83, %tmp_84
  br i1 %tmp_85, label %tmp_86, label %tmp_120

tmp_86:                                      ; preds = %tmp_82
  %tmp_87 = load i32* %j, align 4
  %tmp_88 = load i32* %y, align 4
  %tmp_89 = load i32* %hstep, align 4
  %tmp_90 = sub i32 %tmp_88, %tmp_89
  %tmp_91 = sub i32 %tmp_87, %tmp_90
  %tmp_92 = load i32* %maskWidth, align 4
  %tmp_93 = mul i32 %tmp_91, %tmp_92
  %tmp_94 = load i32* %i, align 4
  %tmp_95 = load i32* %x, align 4
  %tmp_96 = load i32* %vstep, align 4
  %tmp_97 = sub i32 %tmp_95, %tmp_96
  %tmp_98 = sub i32 %tmp_94, %tmp_97
  %tmp_99 = add i32 %tmp_93, %tmp_98
  store i32 %tmp_99, i32* %maskIndex, align 4
  %tmp_100 = load i32* %j, align 4
  %tmp_101 = load i32* %width, align 4
  %tmp_102 = mul i32 %tmp_100, %tmp_101
  %tmp_103 = load i32* %i, align 4
  %tmp_104 = add i32 %tmp_102, %tmp_103
  store i32 %tmp_104, i32* %index, align 4
  %tmp_105 = load i32* %index, align 4
  %tmp_106 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_107 = getelementptr inbounds i32 addrspace(1)* %tmp_106, i32 %tmp_105
  %tmp_108 = load i32 addrspace(1)* %tmp_107, align 4
  %tmp_109 = uitofp i32 %tmp_108 to float
  %tmp_110 = load i32* %maskIndex, align 4
  %tmp_111 = load float addrspace(1)** %tmp_3, align 4
  %tmp_112 = getelementptr inbounds float addrspace(1)* %tmp_111, i32 %tmp_110
  %tmp_113 = load float addrspace(1)* %tmp_112, align 4
  %tmp_114 = fmul float %tmp_109, %tmp_113
  %tmp_115 = load float* %sumFX, align 4
  %tmp_116 = fadd float %tmp_115, %tmp_114
  store float %tmp_116, float* %sumFX, align 4
  br label %tmp_117

tmp_117:                                     ; preds = %tmp_86
  %tmp_118 = load i32* %j, align 4
  %tmp_119 = add i32 %tmp_118, 1
  store i32 %tmp_119, i32* %j, align 4
  br label %tmp_82

tmp_120:                                     ; preds = %tmp_82
  br label %tmp_121

tmp_121:                                     ; preds = %tmp_120
  %tmp_122 = load i32* %i, align 4
  %tmp_123 = add i32 %tmp_122, 1
  store i32 %tmp_123, i32* %i, align 4
  br label %tmp_76

tmp_124:                                     ; preds = %tmp_76
  %tmp_125 = load float* %sumFX, align 4
  %tmp_126 = fadd float %tmp_125, 5.000000e-01
  store float %tmp_126, float* %sumFX, align 4
  %tmp_127 = load float* %sumFX, align 4
  %tmp_128 = fptoui float %tmp_127 to i32
  %tmp_129 = load i32* %tid, align 4
  %tmp_130 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_131 = getelementptr inbounds i32 addrspace(1)* %tmp_130, i32 %tmp_129
  store i32 %tmp_128, i32 addrspace(1)* %tmp_131, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, float addrspace(1)*, <2 x i32>, <2 x i32>)* @simpleConvolution}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

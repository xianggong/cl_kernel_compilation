; ModuleID = 'SimpleConvolution_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @simpleConvolution(i32 addrspace(1)* %output, i32 addrspace(1)* %input, float addrspace(1)* %mask, <2 x i32> %inputDimensions, <2 x i32> %maskDimensions) #0 {
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_8 = extractelement <2 x i32> %inputDimensions, i32 0
  %tmp_10 = extractelement <2 x i32> %inputDimensions, i32 1
  %tmp_13 = urem i32 %tmp_6, %tmp_8
  %tmp_16 = udiv i32 %tmp_6, %tmp_8
  %tmp_18 = extractelement <2 x i32> %maskDimensions, i32 0
  %tmp_20 = extractelement <2 x i32> %maskDimensions, i32 1
  %tmp_22 = sub i32 %tmp_18, 1
  %tmp_23 = udiv i32 %tmp_22, 2
  %tmp_25 = sub i32 %tmp_20, 1
  %tmp_26 = udiv i32 %tmp_25, 2
  %tmp_29 = icmp ult i32 %tmp_13, %tmp_23
  br i1 %tmp_29, label %tmp_30, label %tmp_31

tmp_30:                                           ; preds = %0
  br label %tmp_35

tmp_31:                                           ; preds = %0
  %tmp_34 = sub i32 %tmp_13, %tmp_23
  br label %tmp_35

tmp_35:                                           ; preds = %tmp_31, %tmp_30
  %tmp_36 = phi i32 [ 0, %tmp_30 ], [ %tmp_34, %tmp_31 ]
  %tmp_39 = add i32 %tmp_13, %tmp_23
  %tmp_41 = icmp uge i32 %tmp_39, %tmp_8
  br i1 %tmp_41, label %tmp_42, label %tmp_45

tmp_42:                                           ; preds = %tmp_35
  %tmp_44 = sub i32 %tmp_8, 1
  br label %tmp_49

tmp_45:                                           ; preds = %tmp_35
  %tmp_48 = add i32 %tmp_13, %tmp_23
  br label %tmp_49

tmp_49:                                           ; preds = %tmp_45, %tmp_42
  %tmp_50 = phi i32 [ %tmp_44, %tmp_42 ], [ %tmp_48, %tmp_45 ]
  %tmp_53 = icmp ult i32 %tmp_16, %tmp_26
  br i1 %tmp_53, label %tmp_54, label %tmp_55

tmp_54:                                           ; preds = %tmp_49
  br label %tmp_59

tmp_55:                                           ; preds = %tmp_49
  %tmp_58 = sub i32 %tmp_16, %tmp_26
  br label %tmp_59

tmp_59:                                           ; preds = %tmp_55, %tmp_54
  %tmp_60 = phi i32 [ 0, %tmp_54 ], [ %tmp_58, %tmp_55 ]
  %tmp_63 = add i32 %tmp_16, %tmp_26
  %tmp_65 = icmp uge i32 %tmp_63, %tmp_10
  br i1 %tmp_65, label %tmp_66, label %tmp_69

tmp_66:                                           ; preds = %tmp_59
  %tmp_68 = sub i32 %tmp_10, 1
  br label %tmp_73

tmp_69:                                           ; preds = %tmp_59
  %tmp_72 = add i32 %tmp_16, %tmp_26
  br label %tmp_73

tmp_73:                                           ; preds = %tmp_69, %tmp_66
  %tmp_74 = phi i32 [ %tmp_68, %tmp_66 ], [ %tmp_72, %tmp_69 ]
  br label %tmp_76

tmp_76:                                           ; preds = %tmp_121, %tmp_73
  %sumFX.0 = phi float [ 0.000000e+00, %tmp_73 ], [ %sumFX.1, %tmp_121 ]
  %i.0 = phi i32 [ %tmp_36, %tmp_73 ], [ %tmp_123, %tmp_121 ]
  %tmp_79 = icmp ule i32 %i.0, %tmp_50
  br i1 %tmp_79, label %tmp_80, label %tmp_124

tmp_80:                                           ; preds = %tmp_76
  br label %tmp_82

tmp_82:                                           ; preds = %tmp_117, %tmp_80
  %sumFX.1 = phi float [ %sumFX.0, %tmp_80 ], [ %tmp_116, %tmp_117 ]
  %j.0 = phi i32 [ %tmp_60, %tmp_80 ], [ %tmp_119, %tmp_117 ]
  %tmp_85 = icmp ule i32 %j.0, %tmp_74
  br i1 %tmp_85, label %tmp_86, label %tmp_120

tmp_86:                                           ; preds = %tmp_82
  %tmp_90 = sub i32 %tmp_16, %tmp_26
  %tmp_91 = sub i32 %j.0, %tmp_90
  %tmp_93 = mul i32 %tmp_91, %tmp_18
  %tmp_97 = sub i32 %tmp_13, %tmp_23
  %tmp_98 = sub i32 %i.0, %tmp_97
  %tmp_99 = add i32 %tmp_93, %tmp_98
  %tmp_102 = mul i32 %j.0, %tmp_8
  %tmp_104 = add i32 %tmp_102, %i.0
  %tmp_107 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_104
  %tmp_108 = load i32 addrspace(1)* %tmp_107, align 4
  %tmp_109 = uitofp i32 %tmp_108 to float
  %tmp_112 = getelementptr inbounds float addrspace(1)* %mask, i32 %tmp_99
  %tmp_113 = load float addrspace(1)* %tmp_112, align 4
  %tmp_114 = fmul float %tmp_109, %tmp_113
  %tmp_116 = fadd float %sumFX.1, %tmp_114
  br label %tmp_117

tmp_117:                                          ; preds = %tmp_86
  %tmp_119 = add i32 %j.0, 1
  br label %tmp_82

tmp_120:                                          ; preds = %tmp_82
  br label %tmp_121

tmp_121:                                          ; preds = %tmp_120
  %tmp_123 = add i32 %i.0, 1
  br label %tmp_76

tmp_124:                                          ; preds = %tmp_76
  %tmp_126 = fadd float %sumFX.0, 5.000000e-01
  %tmp_128 = fptoui float %tmp_126 to i32
  %tmp_131 = getelementptr inbounds i32 addrspace(1)* %output, i32 %tmp_6
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

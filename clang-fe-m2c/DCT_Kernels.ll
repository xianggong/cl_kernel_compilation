; ModuleID = '../kernel-src/DCT_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define i32 @getIdx(i32 %blockIdx, i32 %blockIdy, i32 %localIdx, i32 %localIdy, i32 %blockWidth, i32 %globalWidth) #0 {
  %tmp_1 = alloca i32, align 4
  %tmp_2 = alloca i32, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i32, align 4
  %tmp_6 = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %globalIdy = alloca i32, align 4
  store i32 %blockIdx, i32* %tmp_1, align 4
  store i32 %blockIdy, i32* %tmp_2, align 4
  store i32 %localIdx, i32* %tmp_3, align 4
  store i32 %localIdy, i32* %tmp_4, align 4
  store i32 %blockWidth, i32* %tmp_5, align 4
  store i32 %globalWidth, i32* %tmp_6, align 4
  %tmp_7 = load i32* %tmp_1, align 4
  %tmp_8 = load i32* %tmp_5, align 4
  %tmp_9 = mul i32 %tmp_7, %tmp_8
  %tmp_10 = load i32* %tmp_3, align 4
  %tmp_11 = add i32 %tmp_9, %tmp_10
  store i32 %tmp_11, i32* %globalIdx, align 4
  %tmp_12 = load i32* %tmp_2, align 4
  %tmp_13 = load i32* %tmp_5, align 4
  %tmp_14 = mul i32 %tmp_12, %tmp_13
  %tmp_15 = load i32* %tmp_4, align 4
  %tmp_16 = add i32 %tmp_14, %tmp_15
  store i32 %tmp_16, i32* %globalIdy, align 4
  %tmp_17 = load i32* %globalIdy, align 4
  %tmp_18 = load i32* %tmp_6, align 4
  %tmp_19 = mul i32 %tmp_17, %tmp_18
  %tmp_20 = load i32* %globalIdx, align 4
  %tmp_21 = add i32 %tmp_19, %tmp_20
  ret i32 %tmp_21
}

; Function Attrs: nounwind
define void @DCT(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(1)* %dct8x8, float addrspace(1)* %dct8x8_trans, float addrspace(3)* %inter, i32 %width, i32 %blockWidth, i32 %inverse) #0 {
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca float addrspace(1)*, align 4
  %tmp_3 = alloca float addrspace(1)*, align 4
  %tmp_4 = alloca float addrspace(1)*, align 4
  %tmp_5 = alloca float addrspace(3)*, align 4
  %tmp_6 = alloca i32, align 4
  %tmp_7 = alloca i32, align 4
  %tmp_8 = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %globalIdy = alloca i32, align 4
  %groupIdx = alloca i32, align 4
  %groupIdy = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %idx = alloca i32, align 4
  %acc = alloca float, align 4
  %k = alloca i32, align 4
  %index1 = alloca i32, align 4
  %index2 = alloca i32, align 4
  %k1 = alloca i32, align 4
  %index12 = alloca i32, align 4
  %index23 = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %tmp_1, align 4
  store float addrspace(1)* %input, float addrspace(1)** %tmp_2, align 4
  store float addrspace(1)* %dct8x8, float addrspace(1)** %tmp_3, align 4
  store float addrspace(1)* %dct8x8_trans, float addrspace(1)** %tmp_4, align 4
  store float addrspace(3)* %inter, float addrspace(3)** %tmp_5, align 4
  store i32 %width, i32* %tmp_6, align 4
  store i32 %blockWidth, i32* %tmp_7, align 4
  store i32 %inverse, i32* %tmp_8, align 4
  %tmp_9 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_9, i32* %globalIdx, align 4
  %tmp_10 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_10, i32* %globalIdy, align 4
  %tmp_11 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_11, i32* %groupIdx, align 4
  %tmp_12 = call i32 @__get_group_id_u32(i32 1)
  store i32 %tmp_12, i32* %groupIdy, align 4
  %tmp_13 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_13, i32* %i, align 4
  %tmp_14 = call i32 @__get_local_id_u32(i32 1)
  store i32 %tmp_14, i32* %j, align 4
  %tmp_15 = load i32* %globalIdy, align 4
  %tmp_16 = load i32* %tmp_6, align 4
  %tmp_17 = mul i32 %tmp_15, %tmp_16
  %tmp_18 = load i32* %globalIdx, align 4
  %tmp_19 = add i32 %tmp_17, %tmp_18
  store i32 %tmp_19, i32* %idx, align 4
  store float 0.000000e+00, float* %acc, align 4
  store i32 0, i32* %k, align 4
  br label %tmp_20

tmp_20:                                      ; preds = %tmp_64, %tmp_0
  %tmp_21 = load i32* %k, align 4
  %tmp_22 = load i32* %tmp_7, align 4
  %tmp_23 = icmp ult i32 %tmp_21, %tmp_22
  br i1 %tmp_23, label %tmp_24, label %tmp_67

tmp_24:                                      ; preds = %tmp_20
  %tmp_25 = load i32* %j, align 4
  %tmp_26 = load i32* %tmp_7, align 4
  %tmp_27 = mul i32 %tmp_25, %tmp_26
  %tmp_28 = load i32* %k, align 4
  %tmp_29 = add i32 %tmp_27, %tmp_28
  store i32 %tmp_29, i32* %index1, align 4
  %tmp_30 = load i32* %groupIdx, align 4
  %tmp_31 = load i32* %groupIdy, align 4
  %tmp_32 = load i32* %i, align 4
  %tmp_33 = load i32* %k, align 4
  %tmp_34 = load i32* %tmp_7, align 4
  %tmp_35 = load i32* %tmp_6, align 4
  %tmp_36 = call i32 @getIdx(i32 %tmp_30, i32 %tmp_31, i32 %tmp_32, i32 %tmp_33, i32 %tmp_34, i32 %tmp_35)
  store i32 %tmp_36, i32* %index2, align 4
  %tmp_37 = load i32* %tmp_8, align 4
  %tmp_38 = icmp ne i32 %tmp_37, 0
  br i1 %tmp_38, label %tmp_39, label %tmp_51

tmp_39:                                      ; preds = %tmp_24
  %tmp_40 = load i32* %index1, align 4
  %tmp_41 = load float addrspace(1)** %tmp_3, align 4
  %tmp_42 = getelementptr inbounds float addrspace(1)* %tmp_41, i32 %tmp_40
  %tmp_43 = load float addrspace(1)* %tmp_42, align 4
  %tmp_44 = load i32* %index2, align 4
  %tmp_45 = load float addrspace(1)** %tmp_2, align 4
  %tmp_46 = getelementptr inbounds float addrspace(1)* %tmp_45, i32 %tmp_44
  %tmp_47 = load float addrspace(1)* %tmp_46, align 4
  %tmp_48 = fmul float %tmp_43, %tmp_47
  %tmp_49 = load float* %acc, align 4
  %tmp_50 = fadd float %tmp_49, %tmp_48
  store float %tmp_50, float* %acc, align 4
  br label %tmp_63

tmp_51:                                      ; preds = %tmp_24
  %tmp_52 = load i32* %index1, align 4
  %tmp_53 = load float addrspace(1)** %tmp_4, align 4
  %tmp_54 = getelementptr inbounds float addrspace(1)* %tmp_53, i32 %tmp_52
  %tmp_55 = load float addrspace(1)* %tmp_54, align 4
  %tmp_56 = load i32* %index2, align 4
  %tmp_57 = load float addrspace(1)** %tmp_2, align 4
  %tmp_58 = getelementptr inbounds float addrspace(1)* %tmp_57, i32 %tmp_56
  %tmp_59 = load float addrspace(1)* %tmp_58, align 4
  %tmp_60 = fmul float %tmp_55, %tmp_59
  %tmp_61 = load float* %acc, align 4
  %tmp_62 = fadd float %tmp_61, %tmp_60
  store float %tmp_62, float* %acc, align 4
  br label %tmp_63

tmp_63:                                      ; preds = %tmp_51, %tmp_39
  br label %tmp_64

tmp_64:                                      ; preds = %tmp_63
  %tmp_65 = load i32* %k, align 4
  %tmp_66 = add i32 %tmp_65, 1
  store i32 %tmp_66, i32* %k, align 4
  br label %tmp_20

tmp_67:                                      ; preds = %tmp_20
  %tmp_68 = load float* %acc, align 4
  %tmp_69 = load i32* %j, align 4
  %tmp_70 = load i32* %tmp_7, align 4
  %tmp_71 = mul i32 %tmp_69, %tmp_70
  %tmp_72 = load i32* %i, align 4
  %tmp_73 = add i32 %tmp_71, %tmp_72
  %tmp_74 = load float addrspace(3)** %tmp_5, align 4
  %tmp_75 = getelementptr inbounds float addrspace(3)* %tmp_74, i32 %tmp_73
  store float %tmp_68, float addrspace(3)* %tmp_75, align 4
  call void @barrier(i32 1)
  store float 0.000000e+00, float* %acc, align 4
  store i32 0, i32* %k1, align 4
  br label %tmp_76

tmp_76:                                      ; preds = %tmp_118, %tmp_67
  %tmp_77 = load i32* %k1, align 4
  %tmp_78 = load i32* %tmp_7, align 4
  %tmp_79 = icmp ult i32 %tmp_77, %tmp_78
  br i1 %tmp_79, label %tmp_80, label %tmp_121

tmp_80:                                      ; preds = %tmp_76
  %tmp_81 = load i32* %j, align 4
  %tmp_82 = load i32* %tmp_7, align 4
  %tmp_83 = mul i32 %tmp_81, %tmp_82
  %tmp_84 = load i32* %k1, align 4
  %tmp_85 = add i32 %tmp_83, %tmp_84
  store i32 %tmp_85, i32* %index12, align 4
  %tmp_86 = load i32* %k1, align 4
  %tmp_87 = load i32* %tmp_7, align 4
  %tmp_88 = mul i32 %tmp_86, %tmp_87
  %tmp_89 = load i32* %i, align 4
  %tmp_90 = add i32 %tmp_88, %tmp_89
  store i32 %tmp_90, i32* %index23, align 4
  %tmp_91 = load i32* %tmp_8, align 4
  %tmp_92 = icmp ne i32 %tmp_91, 0
  br i1 %tmp_92, label %tmp_93, label %tmp_105

tmp_93:                                      ; preds = %tmp_80
  %tmp_94 = load i32* %index12, align 4
  %tmp_95 = load float addrspace(3)** %tmp_5, align 4
  %tmp_96 = getelementptr inbounds float addrspace(3)* %tmp_95, i32 %tmp_94
  %tmp_97 = load float addrspace(3)* %tmp_96, align 4
  %tmp_98 = load i32* %index23, align 4
  %tmp_99 = load float addrspace(1)** %tmp_4, align 4
  %tmp_100 = getelementptr inbounds float addrspace(1)* %tmp_99, i32 %tmp_98
  %tmp_101 = load float addrspace(1)* %tmp_100, align 4
  %tmp_102 = fmul float %tmp_97, %tmp_101
  %tmp_103 = load float* %acc, align 4
  %tmp_104 = fadd float %tmp_103, %tmp_102
  store float %tmp_104, float* %acc, align 4
  br label %tmp_117

tmp_105:                                     ; preds = %tmp_80
  %tmp_106 = load i32* %index12, align 4
  %tmp_107 = load float addrspace(3)** %tmp_5, align 4
  %tmp_108 = getelementptr inbounds float addrspace(3)* %tmp_107, i32 %tmp_106
  %tmp_109 = load float addrspace(3)* %tmp_108, align 4
  %tmp_110 = load i32* %index23, align 4
  %tmp_111 = load float addrspace(1)** %tmp_3, align 4
  %tmp_112 = getelementptr inbounds float addrspace(1)* %tmp_111, i32 %tmp_110
  %tmp_113 = load float addrspace(1)* %tmp_112, align 4
  %tmp_114 = fmul float %tmp_109, %tmp_113
  %tmp_115 = load float* %acc, align 4
  %tmp_116 = fadd float %tmp_115, %tmp_114
  store float %tmp_116, float* %acc, align 4
  br label %tmp_117

tmp_117:                                     ; preds = %tmp_105, %tmp_93
  br label %tmp_118

tmp_118:                                     ; preds = %tmp_117
  %tmp_119 = load i32* %k1, align 4
  %tmp_120 = add i32 %tmp_119, 1
  store i32 %tmp_120, i32* %k1, align 4
  br label %tmp_76

tmp_121:                                     ; preds = %tmp_76
  %tmp_122 = load float* %acc, align 4
  %tmp_123 = load i32* %idx, align 4
  %tmp_124 = load float addrspace(1)** %tmp_1, align 4
  %tmp_125 = getelementptr inbounds float addrspace(1)* %tmp_124, i32 %tmp_123
  store float %tmp_122, float addrspace(1)* %tmp_125, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32)* @DCT}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

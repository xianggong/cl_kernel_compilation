; ModuleID = '../kernel-src/PrefixSum_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @group_prefixSum(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %length, i32 %idxOffset) #0 {
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca float addrspace(1)*, align 4
  %tmp_3 = alloca float addrspace(3)*, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i32, align 4
  %localId = alloca i32, align 4
  %localSize = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %offset = alloca i32, align 4
  %l = alloca i32, align 4
  %ai = alloca i32, align 4
  %bi = alloca i32, align 4
  %maxThread = alloca i32, align 4
  %d = alloca i32, align 4
  %ai1 = alloca i32, align 4
  %bi2 = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %tmp_1, align 4
  store float addrspace(1)* %input, float addrspace(1)** %tmp_2, align 4
  store float addrspace(3)* %block, float addrspace(3)** %tmp_3, align 4
  store i32 %length, i32* %tmp_4, align 4
  store i32 %idxOffset, i32* %tmp_5, align 4
  %tmp_6 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_6, i32* %localId, align 4
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_7, i32* %localSize, align 4
  %tmp_8 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_8, i32* %globalIdx, align 4
  %tmp_9 = load i32* %tmp_5, align 4
  %tmp_10 = load i32* %globalIdx, align 4
  %tmp_11 = load i32* %localSize, align 4
  %tmp_12 = mul nsw i32 %tmp_10, %tmp_11
  %tmp_13 = load i32* %localId, align 4
  %tmp_14 = add nsw i32 %tmp_12, %tmp_13
  %tmp_15 = mul nsw i32 2, %tmp_14
  %tmp_16 = add nsw i32 %tmp_15, 1
  %tmp_17 = mul i32 %tmp_9, %tmp_16
  %tmp_18 = sub i32 %tmp_17, 1
  store i32 %tmp_18, i32* %globalIdx, align 4
  %tmp_19 = load i32* %globalIdx, align 4
  %tmp_20 = load i32* %tmp_4, align 4
  %tmp_21 = icmp ult i32 %tmp_19, %tmp_20
  br i1 %tmp_21, label %tmp_22, label %tmp_31

tmp_22:                                      ; preds = %tmp_0
  %tmp_23 = load i32* %globalIdx, align 4
  %tmp_24 = load float addrspace(1)** %tmp_2, align 4
  %tmp_25 = getelementptr inbounds float addrspace(1)* %tmp_24, i32 %tmp_23
  %tmp_26 = load float addrspace(1)* %tmp_25, align 4
  %tmp_27 = load i32* %localId, align 4
  %tmp_28 = mul nsw i32 2, %tmp_27
  %tmp_29 = load float addrspace(3)** %tmp_3, align 4
  %tmp_30 = getelementptr inbounds float addrspace(3)* %tmp_29, i32 %tmp_28
  store float %tmp_26, float addrspace(3)* %tmp_30, align 4
  br label %tmp_31

tmp_31:                                      ; preds = %tmp_22, %tmp_0
  %tmp_32 = load i32* %globalIdx, align 4
  %tmp_33 = load i32* %tmp_5, align 4
  %tmp_34 = add i32 %tmp_32, %tmp_33
  %tmp_35 = load i32* %tmp_4, align 4
  %tmp_36 = icmp ult i32 %tmp_34, %tmp_35
  br i1 %tmp_36, label %tmp_37, label %tmp_49

tmp_37:                                      ; preds = %tmp_31
  %tmp_38 = load i32* %globalIdx, align 4
  %tmp_39 = load i32* %tmp_5, align 4
  %tmp_40 = add i32 %tmp_38, %tmp_39
  %tmp_41 = load float addrspace(1)** %tmp_2, align 4
  %tmp_42 = getelementptr inbounds float addrspace(1)* %tmp_41, i32 %tmp_40
  %tmp_43 = load float addrspace(1)* %tmp_42, align 4
  %tmp_44 = load i32* %localId, align 4
  %tmp_45 = mul nsw i32 2, %tmp_44
  %tmp_46 = add nsw i32 %tmp_45, 1
  %tmp_47 = load float addrspace(3)** %tmp_3, align 4
  %tmp_48 = getelementptr inbounds float addrspace(3)* %tmp_47, i32 %tmp_46
  store float %tmp_43, float addrspace(3)* %tmp_48, align 4
  br label %tmp_49

tmp_49:                                      ; preds = %tmp_37, %tmp_31
  store i32 1, i32* %offset, align 4
  %tmp_50 = load i32* %tmp_4, align 4
  %tmp_51 = lshr i32 %tmp_50, 1
  store i32 %tmp_51, i32* %l, align 4
  br label %tmp_52

tmp_52:                                      ; preds = %tmp_84, %tmp_49
  %tmp_53 = load i32* %l, align 4
  %tmp_54 = icmp sgt i32 %tmp_53, 0
  br i1 %tmp_54, label %tmp_55, label %tmp_87

tmp_55:                                      ; preds = %tmp_52
  call void @barrier(i32 1)
  %tmp_56 = load i32* %localId, align 4
  %tmp_57 = load i32* %l, align 4
  %tmp_58 = icmp slt i32 %tmp_56, %tmp_57
  br i1 %tmp_58, label %tmp_59, label %tmp_81

tmp_59:                                      ; preds = %tmp_55
  %tmp_60 = load i32* %offset, align 4
  %tmp_61 = load i32* %localId, align 4
  %tmp_62 = mul nsw i32 2, %tmp_61
  %tmp_63 = add nsw i32 %tmp_62, 1
  %tmp_64 = mul nsw i32 %tmp_60, %tmp_63
  %tmp_65 = sub nsw i32 %tmp_64, 1
  store i32 %tmp_65, i32* %ai, align 4
  %tmp_66 = load i32* %offset, align 4
  %tmp_67 = load i32* %localId, align 4
  %tmp_68 = mul nsw i32 2, %tmp_67
  %tmp_69 = add nsw i32 %tmp_68, 2
  %tmp_70 = mul nsw i32 %tmp_66, %tmp_69
  %tmp_71 = sub nsw i32 %tmp_70, 1
  store i32 %tmp_71, i32* %bi, align 4
  %tmp_72 = load i32* %ai, align 4
  %tmp_73 = load float addrspace(3)** %tmp_3, align 4
  %tmp_74 = getelementptr inbounds float addrspace(3)* %tmp_73, i32 %tmp_72
  %tmp_75 = load float addrspace(3)* %tmp_74, align 4
  %tmp_76 = load i32* %bi, align 4
  %tmp_77 = load float addrspace(3)** %tmp_3, align 4
  %tmp_78 = getelementptr inbounds float addrspace(3)* %tmp_77, i32 %tmp_76
  %tmp_79 = load float addrspace(3)* %tmp_78, align 4
  %tmp_80 = fadd float %tmp_79, %tmp_75
  store float %tmp_80, float addrspace(3)* %tmp_78, align 4
  br label %tmp_81

tmp_81:                                      ; preds = %tmp_59, %tmp_55
  %tmp_82 = load i32* %offset, align 4
  %tmp_83 = shl i32 %tmp_82, 1
  store i32 %tmp_83, i32* %offset, align 4
  br label %tmp_84

tmp_84:                                      ; preds = %tmp_81
  %tmp_85 = load i32* %l, align 4
  %tmp_86 = ashr i32 %tmp_85, 1
  store i32 %tmp_86, i32* %l, align 4
  br label %tmp_52

tmp_87:                                      ; preds = %tmp_52
  %tmp_88 = load i32* %offset, align 4
  %tmp_89 = load i32* %tmp_4, align 4
  %tmp_90 = icmp ult i32 %tmp_88, %tmp_89
  br i1 %tmp_90, label %tmp_91, label %tmp_94

tmp_91:                                      ; preds = %tmp_87
  %tmp_92 = load i32* %offset, align 4
  %tmp_93 = shl i32 %tmp_92, 1
  store i32 %tmp_93, i32* %offset, align 4
  br label %tmp_94

tmp_94:                                      ; preds = %tmp_91, %tmp_87
  %tmp_95 = load i32* %offset, align 4
  %tmp_96 = ashr i32 %tmp_95, 1
  store i32 %tmp_96, i32* %maxThread, align 4
  store i32 0, i32* %d, align 4
  br label %tmp_97

tmp_97:                                      ; preds = %tmp_129, %tmp_94
  %tmp_98 = load i32* %d, align 4
  %tmp_99 = load i32* %maxThread, align 4
  %tmp_100 = icmp slt i32 %tmp_98, %tmp_99
  br i1 %tmp_100, label %tmp_101, label %tmp_132

tmp_101:                                     ; preds = %tmp_97
  %tmp_102 = load i32* %d, align 4
  %tmp_103 = add nsw i32 %tmp_102, 1
  store i32 %tmp_103, i32* %d, align 4
  %tmp_104 = load i32* %offset, align 4
  %tmp_105 = ashr i32 %tmp_104, 1
  store i32 %tmp_105, i32* %offset, align 4
  call void @barrier(i32 1)
  %tmp_106 = load i32* %localId, align 4
  %tmp_107 = load i32* %d, align 4
  %tmp_108 = icmp slt i32 %tmp_106, %tmp_107
  br i1 %tmp_108, label %tmp_109, label %tmp_128

tmp_109:                                     ; preds = %tmp_101
  %tmp_110 = load i32* %offset, align 4
  %tmp_111 = load i32* %localId, align 4
  %tmp_112 = add nsw i32 %tmp_111, 1
  %tmp_113 = mul nsw i32 %tmp_110, %tmp_112
  %tmp_114 = sub nsw i32 %tmp_113, 1
  store i32 %tmp_114, i32* %ai1, align 4
  %tmp_115 = load i32* %ai1, align 4
  %tmp_116 = load i32* %offset, align 4
  %tmp_117 = ashr i32 %tmp_116, 1
  %tmp_118 = add nsw i32 %tmp_115, %tmp_117
  store i32 %tmp_118, i32* %bi2, align 4
  %tmp_119 = load i32* %ai1, align 4
  %tmp_120 = load float addrspace(3)** %tmp_3, align 4
  %tmp_121 = getelementptr inbounds float addrspace(3)* %tmp_120, i32 %tmp_119
  %tmp_122 = load float addrspace(3)* %tmp_121, align 4
  %tmp_123 = load i32* %bi2, align 4
  %tmp_124 = load float addrspace(3)** %tmp_3, align 4
  %tmp_125 = getelementptr inbounds float addrspace(3)* %tmp_124, i32 %tmp_123
  %tmp_126 = load float addrspace(3)* %tmp_125, align 4
  %tmp_127 = fadd float %tmp_126, %tmp_122
  store float %tmp_127, float addrspace(3)* %tmp_125, align 4
  br label %tmp_128

tmp_128:                                     ; preds = %tmp_109, %tmp_101
  br label %tmp_129

tmp_129:                                     ; preds = %tmp_128
  %tmp_130 = load i32* %d, align 4
  %tmp_131 = shl i32 %tmp_130, 1
  store i32 %tmp_131, i32* %d, align 4
  br label %tmp_97

tmp_132:                                     ; preds = %tmp_97
  call void @barrier(i32 1)
  %tmp_133 = load i32* %globalIdx, align 4
  %tmp_134 = load i32* %tmp_4, align 4
  %tmp_135 = icmp ult i32 %tmp_133, %tmp_134
  br i1 %tmp_135, label %tmp_136, label %tmp_145

tmp_136:                                     ; preds = %tmp_132
  %tmp_137 = load i32* %localId, align 4
  %tmp_138 = mul nsw i32 2, %tmp_137
  %tmp_139 = load float addrspace(3)** %tmp_3, align 4
  %tmp_140 = getelementptr inbounds float addrspace(3)* %tmp_139, i32 %tmp_138
  %tmp_141 = load float addrspace(3)* %tmp_140, align 4
  %tmp_142 = load i32* %globalIdx, align 4
  %tmp_143 = load float addrspace(1)** %tmp_1, align 4
  %tmp_144 = getelementptr inbounds float addrspace(1)* %tmp_143, i32 %tmp_142
  store float %tmp_141, float addrspace(1)* %tmp_144, align 4
  br label %tmp_145

tmp_145:                                     ; preds = %tmp_136, %tmp_132
  %tmp_146 = load i32* %globalIdx, align 4
  %tmp_147 = load i32* %tmp_5, align 4
  %tmp_148 = add i32 %tmp_146, %tmp_147
  %tmp_149 = load i32* %tmp_4, align 4
  %tmp_150 = icmp ult i32 %tmp_148, %tmp_149
  br i1 %tmp_150, label %tmp_151, label %tmp_163

tmp_151:                                     ; preds = %tmp_145
  %tmp_152 = load i32* %localId, align 4
  %tmp_153 = mul nsw i32 2, %tmp_152
  %tmp_154 = add nsw i32 %tmp_153, 1
  %tmp_155 = load float addrspace(3)** %tmp_3, align 4
  %tmp_156 = getelementptr inbounds float addrspace(3)* %tmp_155, i32 %tmp_154
  %tmp_157 = load float addrspace(3)* %tmp_156, align 4
  %tmp_158 = load i32* %globalIdx, align 4
  %tmp_159 = load i32* %tmp_5, align 4
  %tmp_160 = add i32 %tmp_158, %tmp_159
  %tmp_161 = load float addrspace(1)** %tmp_1, align 4
  %tmp_162 = getelementptr inbounds float addrspace(1)* %tmp_161, i32 %tmp_160
  store float %tmp_157, float addrspace(1)* %tmp_162, align 4
  br label %tmp_163

tmp_163:                                     ; preds = %tmp_151, %tmp_145
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @global_prefixSum(float addrspace(1)* %buffer, i32 %offset, i32 %length) #0 {
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca i32, align 4
  %tmp_3 = alloca i32, align 4
  %localSize = alloca i32, align 4
  %groupIdx = alloca i32, align 4
  %sortedLocalBlocks = alloca i32, align 4
  %gidToUnsortedBlocks = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  store float addrspace(1)* %buffer, float addrspace(1)** %tmp_1, align 4
  store i32 %offset, i32* %tmp_2, align 4
  store i32 %length, i32* %tmp_3, align 4
  %tmp_4 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_4, i32* %localSize, align 4
  %tmp_5 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_5, i32* %groupIdx, align 4
  %tmp_6 = load i32* %tmp_2, align 4
  %tmp_7 = load i32* %localSize, align 4
  %tmp_8 = udiv i32 %tmp_6, %tmp_7
  store i32 %tmp_8, i32* %sortedLocalBlocks, align 4
  %tmp_9 = load i32* %groupIdx, align 4
  %tmp_10 = load i32* %groupIdx, align 4
  %tmp_11 = load i32* %tmp_2, align 4
  %tmp_12 = shl i32 %tmp_11, 1
  %tmp_13 = load i32* %sortedLocalBlocks, align 4
  %tmp_14 = sub i32 %tmp_12, %tmp_13
  %tmp_15 = udiv i32 %tmp_10, %tmp_14
  %tmp_16 = add i32 %tmp_15, 1
  %tmp_17 = load i32* %sortedLocalBlocks, align 4
  %tmp_18 = mul i32 %tmp_16, %tmp_17
  %tmp_19 = add i32 %tmp_9, %tmp_18
  store i32 %tmp_19, i32* %gidToUnsortedBlocks, align 4
  %tmp_20 = load i32* %gidToUnsortedBlocks, align 4
  %tmp_21 = load i32* %localSize, align 4
  %tmp_22 = mul nsw i32 %tmp_20, %tmp_21
  %tmp_23 = call i32 @__get_local_id_u32(i32 0)
  %tmp_24 = add i32 %tmp_22, %tmp_23
  store i32 %tmp_24, i32* %globalIdx, align 4
  %tmp_25 = load i32* %globalIdx, align 4
  %tmp_26 = add nsw i32 %tmp_25, 1
  %tmp_27 = load i32* %tmp_2, align 4
  %tmp_28 = urem i32 %tmp_26, %tmp_27
  %tmp_29 = icmp ne i32 %tmp_28, 0
  br i1 %tmp_29, label %tmp_30, label %tmp_49

tmp_30:                                      ; preds = %tmp_0
  %tmp_31 = load i32* %globalIdx, align 4
  %tmp_32 = load i32* %tmp_3, align 4
  %tmp_33 = icmp ult i32 %tmp_31, %tmp_32
  br i1 %tmp_33, label %tmp_34, label %tmp_49

tmp_34:                                      ; preds = %tmp_30
  %tmp_35 = load i32* %globalIdx, align 4
  %tmp_36 = load i32* %globalIdx, align 4
  %tmp_37 = load i32* %tmp_2, align 4
  %tmp_38 = urem i32 %tmp_36, %tmp_37
  %tmp_39 = add i32 %tmp_38, 1
  %tmp_40 = sub i32 %tmp_35, %tmp_39
  %tmp_41 = load float addrspace(1)** %tmp_1, align 4
  %tmp_42 = getelementptr inbounds float addrspace(1)* %tmp_41, i32 %tmp_40
  %tmp_43 = load float addrspace(1)* %tmp_42, align 4
  %tmp_44 = load i32* %globalIdx, align 4
  %tmp_45 = load float addrspace(1)** %tmp_1, align 4
  %tmp_46 = getelementptr inbounds float addrspace(1)* %tmp_45, i32 %tmp_44
  %tmp_47 = load float addrspace(1)* %tmp_46, align 4
  %tmp_48 = fadd float %tmp_47, %tmp_43
  store float %tmp_48, float addrspace(1)* %tmp_46, align 4
  br label %tmp_49

tmp_49:                                      ; preds = %tmp_34, %tmp_30, %tmp_0
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32)* @group_prefixSum}
!1 = metadata !{void (float addrspace(1)*, i32, i32)* @global_prefixSum}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

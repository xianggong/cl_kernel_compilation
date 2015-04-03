; ModuleID = 'PrefixSum_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @group_prefixSum(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %length, i32 %idxOffset) #0 {
  %tmp_6 = call i32 @__get_local_id_u32(i32 0)
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  %tmp_8 = call i32 @__get_group_id_u32(i32 0)
  %tmp_12 = mul nsw i32 %tmp_8, %tmp_7
  %tmp_14 = add nsw i32 %tmp_12, %tmp_6
  %tmp_15 = mul nsw i32 2, %tmp_14
  %tmp_16 = add nsw i32 %tmp_15, 1
  %tmp_17 = mul i32 %idxOffset, %tmp_16
  %tmp_18 = sub i32 %tmp_17, 1
  %tmp_21 = icmp ult i32 %tmp_18, %length
  br i1 %tmp_21, label %tmp_22, label %tmp_31

tmp_22:                                           ; preds = %0
  %tmp_25 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_18
  %tmp_26 = load float addrspace(1)* %tmp_25, align 4
  %tmp_28 = mul nsw i32 2, %tmp_6
  %tmp_30 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_28
  store float %tmp_26, float addrspace(3)* %tmp_30, align 4
  br label %tmp_31

tmp_31:                                           ; preds = %tmp_22, %0
  %tmp_34 = add i32 %tmp_18, %idxOffset
  %tmp_36 = icmp ult i32 %tmp_34, %length
  br i1 %tmp_36, label %tmp_37, label %tmp_49

tmp_37:                                           ; preds = %tmp_31
  %tmp_40 = add i32 %tmp_18, %idxOffset
  %tmp_42 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_40
  %tmp_43 = load float addrspace(1)* %tmp_42, align 4
  %tmp_45 = mul nsw i32 2, %tmp_6
  %tmp_46 = add nsw i32 %tmp_45, 1
  %tmp_48 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_46
  store float %tmp_43, float addrspace(3)* %tmp_48, align 4
  br label %tmp_49

tmp_49:                                           ; preds = %tmp_37, %tmp_31
  %tmp_51 = lshr i32 %length, 1
  br label %tmp_52

tmp_52:                                           ; preds = %tmp_84, %tmp_49
  %offset.0 = phi i32 [ 1, %tmp_49 ], [ %tmp_83, %tmp_84 ]
  %l.0 = phi i32 [ %tmp_51, %tmp_49 ], [ %tmp_86, %tmp_84 ]
  %tmp_54 = icmp sgt i32 %l.0, 0
  br i1 %tmp_54, label %tmp_55, label %tmp_87

tmp_55:                                           ; preds = %tmp_52
  call void @barrier(i32 1)
  %tmp_58 = icmp slt i32 %tmp_6, %l.0
  br i1 %tmp_58, label %tmp_59, label %tmp_81

tmp_59:                                           ; preds = %tmp_55
  %tmp_62 = mul nsw i32 2, %tmp_6
  %tmp_63 = add nsw i32 %tmp_62, 1
  %tmp_64 = mul nsw i32 %offset.0, %tmp_63
  %tmp_65 = sub nsw i32 %tmp_64, 1
  %tmp_68 = mul nsw i32 2, %tmp_6
  %tmp_69 = add nsw i32 %tmp_68, 2
  %tmp_70 = mul nsw i32 %offset.0, %tmp_69
  %tmp_71 = sub nsw i32 %tmp_70, 1
  %tmp_74 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_65
  %tmp_75 = load float addrspace(3)* %tmp_74, align 4
  %tmp_78 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_71
  %tmp_79 = load float addrspace(3)* %tmp_78, align 4
  %tmp_80 = fadd float %tmp_79, %tmp_75
  store float %tmp_80, float addrspace(3)* %tmp_78, align 4
  br label %tmp_81

tmp_81:                                           ; preds = %tmp_59, %tmp_55
  %tmp_83 = shl i32 %offset.0, 1
  br label %tmp_84

tmp_84:                                           ; preds = %tmp_81
  %tmp_86 = ashr i32 %l.0, 1
  br label %tmp_52

tmp_87:                                           ; preds = %tmp_52
  %tmp_90 = icmp ult i32 %offset.0, %length
  br i1 %tmp_90, label %tmp_91, label %tmp_94

tmp_91:                                           ; preds = %tmp_87
  %tmp_93 = shl i32 %offset.0, 1
  br label %tmp_94

tmp_94:                                           ; preds = %tmp_91, %tmp_87
  %offset.1 = phi i32 [ %tmp_93, %tmp_91 ], [ %offset.0, %tmp_87 ]
  %tmp_96 = ashr i32 %offset.1, 1
  br label %tmp_97

tmp_97:                                           ; preds = %tmp_129, %tmp_94
  %offset.2 = phi i32 [ %offset.1, %tmp_94 ], [ %tmp_105, %tmp_129 ]
  %d.0 = phi i32 [ 0, %tmp_94 ], [ %tmp_131, %tmp_129 ]
  %tmp_100 = icmp slt i32 %d.0, %tmp_96
  br i1 %tmp_100, label %tmp_101, label %tmp_132

tmp_101:                                          ; preds = %tmp_97
  %tmp_103 = add nsw i32 %d.0, 1
  %tmp_105 = ashr i32 %offset.2, 1
  call void @barrier(i32 1)
  %tmp_108 = icmp slt i32 %tmp_6, %tmp_103
  br i1 %tmp_108, label %tmp_109, label %tmp_128

tmp_109:                                          ; preds = %tmp_101
  %tmp_112 = add nsw i32 %tmp_6, 1
  %tmp_113 = mul nsw i32 %tmp_105, %tmp_112
  %tmp_114 = sub nsw i32 %tmp_113, 1
  %tmp_117 = ashr i32 %tmp_105, 1
  %tmp_118 = add nsw i32 %tmp_114, %tmp_117
  %tmp_121 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_114
  %tmp_122 = load float addrspace(3)* %tmp_121, align 4
  %tmp_125 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_118
  %tmp_126 = load float addrspace(3)* %tmp_125, align 4
  %tmp_127 = fadd float %tmp_126, %tmp_122
  store float %tmp_127, float addrspace(3)* %tmp_125, align 4
  br label %tmp_128

tmp_128:                                          ; preds = %tmp_109, %tmp_101
  br label %tmp_129

tmp_129:                                          ; preds = %tmp_128
  %tmp_131 = shl i32 %tmp_103, 1
  br label %tmp_97

tmp_132:                                          ; preds = %tmp_97
  call void @barrier(i32 1)
  %tmp_135 = icmp ult i32 %tmp_18, %length
  br i1 %tmp_135, label %tmp_136, label %tmp_145

tmp_136:                                          ; preds = %tmp_132
  %tmp_138 = mul nsw i32 2, %tmp_6
  %tmp_140 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_138
  %tmp_141 = load float addrspace(3)* %tmp_140, align 4
  %tmp_144 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_18
  store float %tmp_141, float addrspace(1)* %tmp_144, align 4
  br label %tmp_145

tmp_145:                                          ; preds = %tmp_136, %tmp_132
  %tmp_148 = add i32 %tmp_18, %idxOffset
  %tmp_150 = icmp ult i32 %tmp_148, %length
  br i1 %tmp_150, label %tmp_151, label %tmp_163

tmp_151:                                          ; preds = %tmp_145
  %tmp_153 = mul nsw i32 2, %tmp_6
  %tmp_154 = add nsw i32 %tmp_153, 1
  %tmp_156 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_154
  %tmp_157 = load float addrspace(3)* %tmp_156, align 4
  %tmp_160 = add i32 %tmp_18, %idxOffset
  %tmp_162 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_160
  store float %tmp_157, float addrspace(1)* %tmp_162, align 4
  br label %tmp_163

tmp_163:                                          ; preds = %tmp_151, %tmp_145
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @global_prefixSum(float addrspace(1)* %buffer, i32 %offset, i32 %length) #0 {
  %tmp_4 = call i32 @__get_local_size_u32(i32 0)
  %tmp_5 = call i32 @__get_group_id_u32(i32 0)
  %tmp_8 = udiv i32 %offset, %tmp_4
  %tmp_12 = shl i32 %offset, 1
  %tmp_14 = sub i32 %tmp_12, %tmp_8
  %tmp_15 = udiv i32 %tmp_5, %tmp_14
  %tmp_16 = add i32 %tmp_15, 1
  %tmp_18 = mul i32 %tmp_16, %tmp_8
  %tmp_19 = add i32 %tmp_5, %tmp_18
  %tmp_22 = mul nsw i32 %tmp_19, %tmp_4
  %tmp_23 = call i32 @__get_local_id_u32(i32 0)
  %tmp_24 = add i32 %tmp_22, %tmp_23
  %tmp_26 = add nsw i32 %tmp_24, 1
  %tmp_28 = urem i32 %tmp_26, %offset
  %tmp_29 = icmp ne i32 %tmp_28, 0
  br i1 %tmp_29, label %tmp_30, label %tmp_49

tmp_30:                                           ; preds = %0
  %tmp_33 = icmp ult i32 %tmp_24, %length
  br i1 %tmp_33, label %tmp_34, label %tmp_49

tmp_34:                                           ; preds = %tmp_30
  %tmp_38 = urem i32 %tmp_24, %offset
  %tmp_39 = add i32 %tmp_38, 1
  %tmp_40 = sub i32 %tmp_24, %tmp_39
  %tmp_42 = getelementptr inbounds float addrspace(1)* %buffer, i32 %tmp_40
  %tmp_43 = load float addrspace(1)* %tmp_42, align 4
  %tmp_46 = getelementptr inbounds float addrspace(1)* %buffer, i32 %tmp_24
  %tmp_47 = load float addrspace(1)* %tmp_46, align 4
  %tmp_48 = fadd float %tmp_47, %tmp_43
  store float %tmp_48, float addrspace(1)* %tmp_46, align 4
  br label %tmp_49

tmp_49:                                           ; preds = %tmp_34, %tmp_30, %0
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32)* @group_prefixSum}
!1 = metadata !{void (float addrspace(1)*, i32, i32)* @global_prefixSum}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

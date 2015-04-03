; ModuleID = 'ScanLargeArrays_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@blockAddition.value = internal addrspace(3) global [1 x float] zeroinitializer, align 4

; Function Attrs: nounwind
define void @blockAddition(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = call i32 @__get_group_id_u32(i32 0)
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  %tmp_7 = icmp eq i32 %tmp_5, 0
  br i1 %tmp_7, label %tmp_8, label %tmp_13

tmp_8:                                            ; preds = %0
  %tmp_11 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_4
  %tmp_12 = load float addrspace(1)* %tmp_11, align 4
  store float %tmp_12, float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i32 0), align 4
  br label %tmp_13

tmp_13:                                           ; preds = %tmp_8, %0
  call void @barrier(i32 1)
  %tmp_14 = load float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i32 0), align 4
  %tmp_17 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_3
  %tmp_18 = load float addrspace(1)* %tmp_17, align 4
  %tmp_19 = fadd float %tmp_18, %tmp_14
  store float %tmp_19, float addrspace(1)* %tmp_17, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @ScanLargeArrays(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size, float addrspace(1)* %sumBuffer) #0 {
  %tmp_6 = call i32 @__get_local_id_u32(i32 0)
  %tmp_7 = call i32 @__get_global_id_u32(i32 0)
  %tmp_8 = call i32 @__get_group_id_u32(i32 0)
  %tmp_10 = mul nsw i32 2, %tmp_7
  %tmp_12 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_10
  %tmp_13 = load float addrspace(1)* %tmp_12, align 4
  %tmp_15 = mul nsw i32 2, %tmp_6
  %tmp_17 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_15
  store float %tmp_13, float addrspace(3)* %tmp_17, align 4
  %tmp_19 = mul nsw i32 2, %tmp_7
  %tmp_20 = add nsw i32 %tmp_19, 1
  %tmp_22 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_20
  %tmp_23 = load float addrspace(1)* %tmp_22, align 4
  %tmp_25 = mul nsw i32 2, %tmp_6
  %tmp_26 = add nsw i32 %tmp_25, 1
  %tmp_28 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_26
  store float %tmp_23, float addrspace(3)* %tmp_28, align 4
  call void @barrier(i32 1)
  %tmp_30 = getelementptr inbounds float addrspace(3)* %block, i32 0
  %tmp_31 = load float addrspace(3)* %tmp_30, align 4
  %tmp_34 = getelementptr inbounds float addrspace(3)* %block, i32 1
  %tmp_35 = load float addrspace(3)* %tmp_34, align 4
  %tmp_36 = fadd float %tmp_31, %tmp_35
  br label %tmp_37

tmp_37:                                           ; preds = %tmp_87, %0
  %cache0.0 = phi float [ %tmp_31, %0 ], [ %cache0.1, %tmp_87 ]
  %cache1.0 = phi float [ %tmp_36, %0 ], [ %cache1.1, %tmp_87 ]
  %stride.0 = phi i32 [ 1, %0 ], [ %tmp_89, %tmp_87 ]
  %tmp_40 = icmp ult i32 %stride.0, %block_size
  br i1 %tmp_40, label %tmp_41, label %tmp_90

tmp_41:                                           ; preds = %tmp_37
  %tmp_43 = mul nsw i32 2, %tmp_6
  %tmp_45 = icmp sge i32 %tmp_43, %stride.0
  br i1 %tmp_45, label %tmp_46, label %tmp_75

tmp_46:                                           ; preds = %tmp_41
  %tmp_48 = mul nsw i32 2, %tmp_6
  %tmp_50 = sub nsw i32 %tmp_48, %stride.0
  %tmp_52 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_50
  %tmp_53 = load float addrspace(3)* %tmp_52, align 4
  %tmp_55 = mul nsw i32 2, %tmp_6
  %tmp_57 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_55
  %tmp_58 = load float addrspace(3)* %tmp_57, align 4
  %tmp_59 = fadd float %tmp_53, %tmp_58
  %tmp_61 = mul nsw i32 2, %tmp_6
  %tmp_62 = add nsw i32 %tmp_61, 1
  %tmp_64 = sub nsw i32 %tmp_62, %stride.0
  %tmp_66 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_64
  %tmp_67 = load float addrspace(3)* %tmp_66, align 4
  %tmp_69 = mul nsw i32 2, %tmp_6
  %tmp_70 = add nsw i32 %tmp_69, 1
  %tmp_72 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_70
  %tmp_73 = load float addrspace(3)* %tmp_72, align 4
  %tmp_74 = fadd float %tmp_67, %tmp_73
  br label %tmp_75

tmp_75:                                           ; preds = %tmp_46, %tmp_41
  %cache0.1 = phi float [ %tmp_59, %tmp_46 ], [ %cache0.0, %tmp_41 ]
  %cache1.1 = phi float [ %tmp_74, %tmp_46 ], [ %cache1.0, %tmp_41 ]
  call void @barrier(i32 1)
  %tmp_78 = mul nsw i32 2, %tmp_6
  %tmp_80 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_78
  store float %cache0.1, float addrspace(3)* %tmp_80, align 4
  %tmp_83 = mul nsw i32 2, %tmp_6
  %tmp_84 = add nsw i32 %tmp_83, 1
  %tmp_86 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_84
  store float %cache1.1, float addrspace(3)* %tmp_86, align 4
  call void @barrier(i32 1)
  br label %tmp_87

tmp_87:                                           ; preds = %tmp_75
  %tmp_89 = mul nsw i32 %stride.0, 2
  br label %tmp_37

tmp_90:                                           ; preds = %tmp_37
  %tmp_92 = sub i32 %block_size, 1
  %tmp_94 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_92
  %tmp_95 = load float addrspace(3)* %tmp_94, align 4
  %tmp_98 = getelementptr inbounds float addrspace(1)* %sumBuffer, i32 %tmp_8
  store float %tmp_95, float addrspace(1)* %tmp_98, align 4
  %tmp_100 = icmp eq i32 %tmp_6, 0
  br i1 %tmp_100, label %tmp_101, label %tmp_116

tmp_101:                                          ; preds = %tmp_90
  %tmp_103 = mul nsw i32 2, %tmp_7
  %tmp_105 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_103
  store float 0.000000e+00, float addrspace(1)* %tmp_105, align 4
  %tmp_107 = mul nsw i32 2, %tmp_6
  %tmp_109 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_107
  %tmp_110 = load float addrspace(3)* %tmp_109, align 4
  %tmp_112 = mul nsw i32 2, %tmp_7
  %tmp_113 = add nsw i32 %tmp_112, 1
  %tmp_115 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_113
  store float %tmp_110, float addrspace(1)* %tmp_115, align 4
  br label %tmp_137

tmp_116:                                          ; preds = %tmp_90
  %tmp_118 = mul nsw i32 2, %tmp_6
  %tmp_119 = sub nsw i32 %tmp_118, 1
  %tmp_121 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_119
  %tmp_122 = load float addrspace(3)* %tmp_121, align 4
  %tmp_124 = mul nsw i32 2, %tmp_7
  %tmp_126 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_124
  store float %tmp_122, float addrspace(1)* %tmp_126, align 4
  %tmp_128 = mul nsw i32 2, %tmp_6
  %tmp_130 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_128
  %tmp_131 = load float addrspace(3)* %tmp_130, align 4
  %tmp_133 = mul nsw i32 2, %tmp_7
  %tmp_134 = add nsw i32 %tmp_133, 1
  %tmp_136 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_134
  store float %tmp_131, float addrspace(1)* %tmp_136, align 4
  br label %tmp_137

tmp_137:                                          ; preds = %tmp_116, %tmp_101
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size) #0 {
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_7 = call i32 @__get_group_id_u32(i32 0)
  %tmp_9 = mul nsw i32 2, %tmp_6
  %tmp_11 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_9
  %tmp_12 = load float addrspace(1)* %tmp_11, align 4
  %tmp_14 = mul nsw i32 2, %tmp_5
  %tmp_16 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_14
  store float %tmp_12, float addrspace(3)* %tmp_16, align 4
  %tmp_18 = mul nsw i32 2, %tmp_6
  %tmp_19 = add nsw i32 %tmp_18, 1
  %tmp_21 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_19
  %tmp_22 = load float addrspace(1)* %tmp_21, align 4
  %tmp_24 = mul nsw i32 2, %tmp_5
  %tmp_25 = add nsw i32 %tmp_24, 1
  %tmp_27 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_25
  store float %tmp_22, float addrspace(3)* %tmp_27, align 4
  call void @barrier(i32 1)
  %tmp_29 = getelementptr inbounds float addrspace(3)* %block, i32 0
  %tmp_30 = load float addrspace(3)* %tmp_29, align 4
  %tmp_33 = getelementptr inbounds float addrspace(3)* %block, i32 1
  %tmp_34 = load float addrspace(3)* %tmp_33, align 4
  %tmp_35 = fadd float %tmp_30, %tmp_34
  br label %tmp_36

tmp_36:                                           ; preds = %tmp_86, %0
  %cache0.0 = phi float [ %tmp_30, %0 ], [ %cache0.1, %tmp_86 ]
  %cache1.0 = phi float [ %tmp_35, %0 ], [ %cache1.1, %tmp_86 ]
  %stride.0 = phi i32 [ 1, %0 ], [ %tmp_88, %tmp_86 ]
  %tmp_39 = icmp ult i32 %stride.0, %block_size
  br i1 %tmp_39, label %tmp_40, label %tmp_89

tmp_40:                                           ; preds = %tmp_36
  %tmp_42 = mul nsw i32 2, %tmp_5
  %tmp_44 = icmp sge i32 %tmp_42, %stride.0
  br i1 %tmp_44, label %tmp_45, label %tmp_74

tmp_45:                                           ; preds = %tmp_40
  %tmp_47 = mul nsw i32 2, %tmp_5
  %tmp_49 = sub nsw i32 %tmp_47, %stride.0
  %tmp_51 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_49
  %tmp_52 = load float addrspace(3)* %tmp_51, align 4
  %tmp_54 = mul nsw i32 2, %tmp_5
  %tmp_56 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_54
  %tmp_57 = load float addrspace(3)* %tmp_56, align 4
  %tmp_58 = fadd float %tmp_52, %tmp_57
  %tmp_60 = mul nsw i32 2, %tmp_5
  %tmp_61 = add nsw i32 %tmp_60, 1
  %tmp_63 = sub nsw i32 %tmp_61, %stride.0
  %tmp_65 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_63
  %tmp_66 = load float addrspace(3)* %tmp_65, align 4
  %tmp_68 = mul nsw i32 2, %tmp_5
  %tmp_69 = add nsw i32 %tmp_68, 1
  %tmp_71 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_69
  %tmp_72 = load float addrspace(3)* %tmp_71, align 4
  %tmp_73 = fadd float %tmp_66, %tmp_72
  br label %tmp_74

tmp_74:                                           ; preds = %tmp_45, %tmp_40
  %cache0.1 = phi float [ %tmp_58, %tmp_45 ], [ %cache0.0, %tmp_40 ]
  %cache1.1 = phi float [ %tmp_73, %tmp_45 ], [ %cache1.0, %tmp_40 ]
  call void @barrier(i32 1)
  %tmp_77 = mul nsw i32 2, %tmp_5
  %tmp_79 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_77
  store float %cache0.1, float addrspace(3)* %tmp_79, align 4
  %tmp_82 = mul nsw i32 2, %tmp_5
  %tmp_83 = add nsw i32 %tmp_82, 1
  %tmp_85 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_83
  store float %cache1.1, float addrspace(3)* %tmp_85, align 4
  call void @barrier(i32 1)
  br label %tmp_86

tmp_86:                                           ; preds = %tmp_74
  %tmp_88 = mul nsw i32 %stride.0, 2
  br label %tmp_36

tmp_89:                                           ; preds = %tmp_36
  %tmp_91 = icmp eq i32 %tmp_5, 0
  br i1 %tmp_91, label %tmp_92, label %tmp_107

tmp_92:                                           ; preds = %tmp_89
  %tmp_94 = mul nsw i32 2, %tmp_6
  %tmp_96 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_94
  store float 0.000000e+00, float addrspace(1)* %tmp_96, align 4
  %tmp_98 = mul nsw i32 2, %tmp_5
  %tmp_100 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_98
  %tmp_101 = load float addrspace(3)* %tmp_100, align 4
  %tmp_103 = mul nsw i32 2, %tmp_6
  %tmp_104 = add nsw i32 %tmp_103, 1
  %tmp_106 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_104
  store float %tmp_101, float addrspace(1)* %tmp_106, align 4
  br label %tmp_128

tmp_107:                                          ; preds = %tmp_89
  %tmp_109 = mul nsw i32 2, %tmp_5
  %tmp_110 = sub nsw i32 %tmp_109, 1
  %tmp_112 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_110
  %tmp_113 = load float addrspace(3)* %tmp_112, align 4
  %tmp_115 = mul nsw i32 2, %tmp_6
  %tmp_117 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_115
  store float %tmp_113, float addrspace(1)* %tmp_117, align 4
  %tmp_119 = mul nsw i32 2, %tmp_5
  %tmp_121 = getelementptr inbounds float addrspace(3)* %block, i32 %tmp_119
  %tmp_122 = load float addrspace(3)* %tmp_121, align 4
  %tmp_124 = mul nsw i32 2, %tmp_6
  %tmp_125 = add nsw i32 %tmp_124, 1
  %tmp_127 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_125
  store float %tmp_122, float addrspace(1)* %tmp_127, align 4
  br label %tmp_128

tmp_128:                                          ; preds = %tmp_107, %tmp_92
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @blockAddition}
!1 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, float addrspace(1)*)* @ScanLargeArrays}
!2 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32)* @prefixSum}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

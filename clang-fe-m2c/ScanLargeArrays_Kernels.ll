; ModuleID = '../kernel-src/ScanLargeArrays_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@blockAddition.value = internal addrspace(3) global [1 x float] zeroinitializer, align 4

; Function Attrs: nounwind
define void @blockAddition(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca float addrspace(1)*, align 4
  %globalId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %localId = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %tmp_1, align 4
  store float addrspace(1)* %output, float addrspace(1)** %tmp_2, align 4
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_3, i32* %globalId, align 4
  %tmp_4 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_4, i32* %groupId, align 4
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_5, i32* %localId, align 4
  %tmp_6 = load i32* %localId, align 4
  %tmp_7 = icmp eq i32 %tmp_6, 0
  br i1 %tmp_7, label %tmp_8, label %tmp_13

tmp_8:                                       ; preds = %tmp_0
  %tmp_9 = load i32* %groupId, align 4
  %tmp_10 = load float addrspace(1)** %tmp_1, align 4
  %tmp_11 = getelementptr inbounds float addrspace(1)* %tmp_10, i32 %tmp_9
  %tmp_12 = load float addrspace(1)* %tmp_11, align 4
  store float %tmp_12, float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i32 0), align 4
  br label %tmp_13

tmp_13:                                      ; preds = %tmp_8, %tmp_0
  call void @barrier(i32 1)
  %tmp_14 = load float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i32 0), align 4
  %tmp_15 = load i32* %globalId, align 4
  %tmp_16 = load float addrspace(1)** %tmp_2, align 4
  %tmp_17 = getelementptr inbounds float addrspace(1)* %tmp_16, i32 %tmp_15
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
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca float addrspace(1)*, align 4
  %tmp_3 = alloca float addrspace(3)*, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca float addrspace(1)*, align 4
  %tid = alloca i32, align 4
  %gid = alloca i32, align 4
  %bid = alloca i32, align 4
  %cache0 = alloca float, align 4
  %cache1 = alloca float, align 4
  %stride = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %tmp_1, align 4
  store float addrspace(1)* %input, float addrspace(1)** %tmp_2, align 4
  store float addrspace(3)* %block, float addrspace(3)** %tmp_3, align 4
  store i32 %block_size, i32* %tmp_4, align 4
  store float addrspace(1)* %sumBuffer, float addrspace(1)** %tmp_5, align 4
  %tmp_6 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_6, i32* %tid, align 4
  %tmp_7 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_7, i32* %gid, align 4
  %tmp_8 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_8, i32* %bid, align 4
  %tmp_9 = load i32* %gid, align 4
  %tmp_10 = mul nsw i32 2, %tmp_9
  %tmp_11 = load float addrspace(1)** %tmp_2, align 4
  %tmp_12 = getelementptr inbounds float addrspace(1)* %tmp_11, i32 %tmp_10
  %tmp_13 = load float addrspace(1)* %tmp_12, align 4
  %tmp_14 = load i32* %tid, align 4
  %tmp_15 = mul nsw i32 2, %tmp_14
  %tmp_16 = load float addrspace(3)** %tmp_3, align 4
  %tmp_17 = getelementptr inbounds float addrspace(3)* %tmp_16, i32 %tmp_15
  store float %tmp_13, float addrspace(3)* %tmp_17, align 4
  %tmp_18 = load i32* %gid, align 4
  %tmp_19 = mul nsw i32 2, %tmp_18
  %tmp_20 = add nsw i32 %tmp_19, 1
  %tmp_21 = load float addrspace(1)** %tmp_2, align 4
  %tmp_22 = getelementptr inbounds float addrspace(1)* %tmp_21, i32 %tmp_20
  %tmp_23 = load float addrspace(1)* %tmp_22, align 4
  %tmp_24 = load i32* %tid, align 4
  %tmp_25 = mul nsw i32 2, %tmp_24
  %tmp_26 = add nsw i32 %tmp_25, 1
  %tmp_27 = load float addrspace(3)** %tmp_3, align 4
  %tmp_28 = getelementptr inbounds float addrspace(3)* %tmp_27, i32 %tmp_26
  store float %tmp_23, float addrspace(3)* %tmp_28, align 4
  call void @barrier(i32 1)
  %tmp_29 = load float addrspace(3)** %tmp_3, align 4
  %tmp_30 = getelementptr inbounds float addrspace(3)* %tmp_29, i32 0
  %tmp_31 = load float addrspace(3)* %tmp_30, align 4
  store float %tmp_31, float* %cache0, align 4
  %tmp_32 = load float* %cache0, align 4
  %tmp_33 = load float addrspace(3)** %tmp_3, align 4
  %tmp_34 = getelementptr inbounds float addrspace(3)* %tmp_33, i32 1
  %tmp_35 = load float addrspace(3)* %tmp_34, align 4
  %tmp_36 = fadd float %tmp_32, %tmp_35
  store float %tmp_36, float* %cache1, align 4
  store i32 1, i32* %stride, align 4
  br label %tmp_37

tmp_37:                                      ; preds = %tmp_87, %tmp_0
  %tmp_38 = load i32* %stride, align 4
  %tmp_39 = load i32* %tmp_4, align 4
  %tmp_40 = icmp ult i32 %tmp_38, %tmp_39
  br i1 %tmp_40, label %tmp_41, label %tmp_90

tmp_41:                                      ; preds = %tmp_37
  %tmp_42 = load i32* %tid, align 4
  %tmp_43 = mul nsw i32 2, %tmp_42
  %tmp_44 = load i32* %stride, align 4
  %tmp_45 = icmp sge i32 %tmp_43, %tmp_44
  br i1 %tmp_45, label %tmp_46, label %tmp_75

tmp_46:                                      ; preds = %tmp_41
  %tmp_47 = load i32* %tid, align 4
  %tmp_48 = mul nsw i32 2, %tmp_47
  %tmp_49 = load i32* %stride, align 4
  %tmp_50 = sub nsw i32 %tmp_48, %tmp_49
  %tmp_51 = load float addrspace(3)** %tmp_3, align 4
  %tmp_52 = getelementptr inbounds float addrspace(3)* %tmp_51, i32 %tmp_50
  %tmp_53 = load float addrspace(3)* %tmp_52, align 4
  %tmp_54 = load i32* %tid, align 4
  %tmp_55 = mul nsw i32 2, %tmp_54
  %tmp_56 = load float addrspace(3)** %tmp_3, align 4
  %tmp_57 = getelementptr inbounds float addrspace(3)* %tmp_56, i32 %tmp_55
  %tmp_58 = load float addrspace(3)* %tmp_57, align 4
  %tmp_59 = fadd float %tmp_53, %tmp_58
  store float %tmp_59, float* %cache0, align 4
  %tmp_60 = load i32* %tid, align 4
  %tmp_61 = mul nsw i32 2, %tmp_60
  %tmp_62 = add nsw i32 %tmp_61, 1
  %tmp_63 = load i32* %stride, align 4
  %tmp_64 = sub nsw i32 %tmp_62, %tmp_63
  %tmp_65 = load float addrspace(3)** %tmp_3, align 4
  %tmp_66 = getelementptr inbounds float addrspace(3)* %tmp_65, i32 %tmp_64
  %tmp_67 = load float addrspace(3)* %tmp_66, align 4
  %tmp_68 = load i32* %tid, align 4
  %tmp_69 = mul nsw i32 2, %tmp_68
  %tmp_70 = add nsw i32 %tmp_69, 1
  %tmp_71 = load float addrspace(3)** %tmp_3, align 4
  %tmp_72 = getelementptr inbounds float addrspace(3)* %tmp_71, i32 %tmp_70
  %tmp_73 = load float addrspace(3)* %tmp_72, align 4
  %tmp_74 = fadd float %tmp_67, %tmp_73
  store float %tmp_74, float* %cache1, align 4
  br label %tmp_75

tmp_75:                                      ; preds = %tmp_46, %tmp_41
  call void @barrier(i32 1)
  %tmp_76 = load float* %cache0, align 4
  %tmp_77 = load i32* %tid, align 4
  %tmp_78 = mul nsw i32 2, %tmp_77
  %tmp_79 = load float addrspace(3)** %tmp_3, align 4
  %tmp_80 = getelementptr inbounds float addrspace(3)* %tmp_79, i32 %tmp_78
  store float %tmp_76, float addrspace(3)* %tmp_80, align 4
  %tmp_81 = load float* %cache1, align 4
  %tmp_82 = load i32* %tid, align 4
  %tmp_83 = mul nsw i32 2, %tmp_82
  %tmp_84 = add nsw i32 %tmp_83, 1
  %tmp_85 = load float addrspace(3)** %tmp_3, align 4
  %tmp_86 = getelementptr inbounds float addrspace(3)* %tmp_85, i32 %tmp_84
  store float %tmp_81, float addrspace(3)* %tmp_86, align 4
  call void @barrier(i32 1)
  br label %tmp_87

tmp_87:                                      ; preds = %tmp_75
  %tmp_88 = load i32* %stride, align 4
  %tmp_89 = mul nsw i32 %tmp_88, 2
  store i32 %tmp_89, i32* %stride, align 4
  br label %tmp_37

tmp_90:                                      ; preds = %tmp_37
  %tmp_91 = load i32* %tmp_4, align 4
  %tmp_92 = sub i32 %tmp_91, 1
  %tmp_93 = load float addrspace(3)** %tmp_3, align 4
  %tmp_94 = getelementptr inbounds float addrspace(3)* %tmp_93, i32 %tmp_92
  %tmp_95 = load float addrspace(3)* %tmp_94, align 4
  %tmp_96 = load i32* %bid, align 4
  %tmp_97 = load float addrspace(1)** %tmp_5, align 4
  %tmp_98 = getelementptr inbounds float addrspace(1)* %tmp_97, i32 %tmp_96
  store float %tmp_95, float addrspace(1)* %tmp_98, align 4
  %tmp_99 = load i32* %tid, align 4
  %tmp_100 = icmp eq i32 %tmp_99, 0
  br i1 %tmp_100, label %tmp_101, label %tmp_116

tmp_101:                                     ; preds = %tmp_90
  %tmp_102 = load i32* %gid, align 4
  %tmp_103 = mul nsw i32 2, %tmp_102
  %tmp_104 = load float addrspace(1)** %tmp_1, align 4
  %tmp_105 = getelementptr inbounds float addrspace(1)* %tmp_104, i32 %tmp_103
  store float 0.000000e+00, float addrspace(1)* %tmp_105, align 4
  %tmp_106 = load i32* %tid, align 4
  %tmp_107 = mul nsw i32 2, %tmp_106
  %tmp_108 = load float addrspace(3)** %tmp_3, align 4
  %tmp_109 = getelementptr inbounds float addrspace(3)* %tmp_108, i32 %tmp_107
  %tmp_110 = load float addrspace(3)* %tmp_109, align 4
  %tmp_111 = load i32* %gid, align 4
  %tmp_112 = mul nsw i32 2, %tmp_111
  %tmp_113 = add nsw i32 %tmp_112, 1
  %tmp_114 = load float addrspace(1)** %tmp_1, align 4
  %tmp_115 = getelementptr inbounds float addrspace(1)* %tmp_114, i32 %tmp_113
  store float %tmp_110, float addrspace(1)* %tmp_115, align 4
  br label %tmp_137

tmp_116:                                     ; preds = %tmp_90
  %tmp_117 = load i32* %tid, align 4
  %tmp_118 = mul nsw i32 2, %tmp_117
  %tmp_119 = sub nsw i32 %tmp_118, 1
  %tmp_120 = load float addrspace(3)** %tmp_3, align 4
  %tmp_121 = getelementptr inbounds float addrspace(3)* %tmp_120, i32 %tmp_119
  %tmp_122 = load float addrspace(3)* %tmp_121, align 4
  %tmp_123 = load i32* %gid, align 4
  %tmp_124 = mul nsw i32 2, %tmp_123
  %tmp_125 = load float addrspace(1)** %tmp_1, align 4
  %tmp_126 = getelementptr inbounds float addrspace(1)* %tmp_125, i32 %tmp_124
  store float %tmp_122, float addrspace(1)* %tmp_126, align 4
  %tmp_127 = load i32* %tid, align 4
  %tmp_128 = mul nsw i32 2, %tmp_127
  %tmp_129 = load float addrspace(3)** %tmp_3, align 4
  %tmp_130 = getelementptr inbounds float addrspace(3)* %tmp_129, i32 %tmp_128
  %tmp_131 = load float addrspace(3)* %tmp_130, align 4
  %tmp_132 = load i32* %gid, align 4
  %tmp_133 = mul nsw i32 2, %tmp_132
  %tmp_134 = add nsw i32 %tmp_133, 1
  %tmp_135 = load float addrspace(1)** %tmp_1, align 4
  %tmp_136 = getelementptr inbounds float addrspace(1)* %tmp_135, i32 %tmp_134
  store float %tmp_131, float addrspace(1)* %tmp_136, align 4
  br label %tmp_137

tmp_137:                                     ; preds = %tmp_116, %tmp_101
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size) #0 {
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca float addrspace(1)*, align 4
  %tmp_3 = alloca float addrspace(3)*, align 4
  %tmp_4 = alloca i32, align 4
  %tid = alloca i32, align 4
  %gid = alloca i32, align 4
  %bid = alloca i32, align 4
  %cache0 = alloca float, align 4
  %cache1 = alloca float, align 4
  %stride = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %tmp_1, align 4
  store float addrspace(1)* %input, float addrspace(1)** %tmp_2, align 4
  store float addrspace(3)* %block, float addrspace(3)** %tmp_3, align 4
  store i32 %block_size, i32* %tmp_4, align 4
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_5, i32* %tid, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_6, i32* %gid, align 4
  %tmp_7 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_7, i32* %bid, align 4
  %tmp_8 = load i32* %gid, align 4
  %tmp_9 = mul nsw i32 2, %tmp_8
  %tmp_10 = load float addrspace(1)** %tmp_2, align 4
  %tmp_11 = getelementptr inbounds float addrspace(1)* %tmp_10, i32 %tmp_9
  %tmp_12 = load float addrspace(1)* %tmp_11, align 4
  %tmp_13 = load i32* %tid, align 4
  %tmp_14 = mul nsw i32 2, %tmp_13
  %tmp_15 = load float addrspace(3)** %tmp_3, align 4
  %tmp_16 = getelementptr inbounds float addrspace(3)* %tmp_15, i32 %tmp_14
  store float %tmp_12, float addrspace(3)* %tmp_16, align 4
  %tmp_17 = load i32* %gid, align 4
  %tmp_18 = mul nsw i32 2, %tmp_17
  %tmp_19 = add nsw i32 %tmp_18, 1
  %tmp_20 = load float addrspace(1)** %tmp_2, align 4
  %tmp_21 = getelementptr inbounds float addrspace(1)* %tmp_20, i32 %tmp_19
  %tmp_22 = load float addrspace(1)* %tmp_21, align 4
  %tmp_23 = load i32* %tid, align 4
  %tmp_24 = mul nsw i32 2, %tmp_23
  %tmp_25 = add nsw i32 %tmp_24, 1
  %tmp_26 = load float addrspace(3)** %tmp_3, align 4
  %tmp_27 = getelementptr inbounds float addrspace(3)* %tmp_26, i32 %tmp_25
  store float %tmp_22, float addrspace(3)* %tmp_27, align 4
  call void @barrier(i32 1)
  %tmp_28 = load float addrspace(3)** %tmp_3, align 4
  %tmp_29 = getelementptr inbounds float addrspace(3)* %tmp_28, i32 0
  %tmp_30 = load float addrspace(3)* %tmp_29, align 4
  store float %tmp_30, float* %cache0, align 4
  %tmp_31 = load float* %cache0, align 4
  %tmp_32 = load float addrspace(3)** %tmp_3, align 4
  %tmp_33 = getelementptr inbounds float addrspace(3)* %tmp_32, i32 1
  %tmp_34 = load float addrspace(3)* %tmp_33, align 4
  %tmp_35 = fadd float %tmp_31, %tmp_34
  store float %tmp_35, float* %cache1, align 4
  store i32 1, i32* %stride, align 4
  br label %tmp_36

tmp_36:                                      ; preds = %tmp_86, %tmp_0
  %tmp_37 = load i32* %stride, align 4
  %tmp_38 = load i32* %tmp_4, align 4
  %tmp_39 = icmp ult i32 %tmp_37, %tmp_38
  br i1 %tmp_39, label %tmp_40, label %tmp_89

tmp_40:                                      ; preds = %tmp_36
  %tmp_41 = load i32* %tid, align 4
  %tmp_42 = mul nsw i32 2, %tmp_41
  %tmp_43 = load i32* %stride, align 4
  %tmp_44 = icmp sge i32 %tmp_42, %tmp_43
  br i1 %tmp_44, label %tmp_45, label %tmp_74

tmp_45:                                      ; preds = %tmp_40
  %tmp_46 = load i32* %tid, align 4
  %tmp_47 = mul nsw i32 2, %tmp_46
  %tmp_48 = load i32* %stride, align 4
  %tmp_49 = sub nsw i32 %tmp_47, %tmp_48
  %tmp_50 = load float addrspace(3)** %tmp_3, align 4
  %tmp_51 = getelementptr inbounds float addrspace(3)* %tmp_50, i32 %tmp_49
  %tmp_52 = load float addrspace(3)* %tmp_51, align 4
  %tmp_53 = load i32* %tid, align 4
  %tmp_54 = mul nsw i32 2, %tmp_53
  %tmp_55 = load float addrspace(3)** %tmp_3, align 4
  %tmp_56 = getelementptr inbounds float addrspace(3)* %tmp_55, i32 %tmp_54
  %tmp_57 = load float addrspace(3)* %tmp_56, align 4
  %tmp_58 = fadd float %tmp_52, %tmp_57
  store float %tmp_58, float* %cache0, align 4
  %tmp_59 = load i32* %tid, align 4
  %tmp_60 = mul nsw i32 2, %tmp_59
  %tmp_61 = add nsw i32 %tmp_60, 1
  %tmp_62 = load i32* %stride, align 4
  %tmp_63 = sub nsw i32 %tmp_61, %tmp_62
  %tmp_64 = load float addrspace(3)** %tmp_3, align 4
  %tmp_65 = getelementptr inbounds float addrspace(3)* %tmp_64, i32 %tmp_63
  %tmp_66 = load float addrspace(3)* %tmp_65, align 4
  %tmp_67 = load i32* %tid, align 4
  %tmp_68 = mul nsw i32 2, %tmp_67
  %tmp_69 = add nsw i32 %tmp_68, 1
  %tmp_70 = load float addrspace(3)** %tmp_3, align 4
  %tmp_71 = getelementptr inbounds float addrspace(3)* %tmp_70, i32 %tmp_69
  %tmp_72 = load float addrspace(3)* %tmp_71, align 4
  %tmp_73 = fadd float %tmp_66, %tmp_72
  store float %tmp_73, float* %cache1, align 4
  br label %tmp_74

tmp_74:                                      ; preds = %tmp_45, %tmp_40
  call void @barrier(i32 1)
  %tmp_75 = load float* %cache0, align 4
  %tmp_76 = load i32* %tid, align 4
  %tmp_77 = mul nsw i32 2, %tmp_76
  %tmp_78 = load float addrspace(3)** %tmp_3, align 4
  %tmp_79 = getelementptr inbounds float addrspace(3)* %tmp_78, i32 %tmp_77
  store float %tmp_75, float addrspace(3)* %tmp_79, align 4
  %tmp_80 = load float* %cache1, align 4
  %tmp_81 = load i32* %tid, align 4
  %tmp_82 = mul nsw i32 2, %tmp_81
  %tmp_83 = add nsw i32 %tmp_82, 1
  %tmp_84 = load float addrspace(3)** %tmp_3, align 4
  %tmp_85 = getelementptr inbounds float addrspace(3)* %tmp_84, i32 %tmp_83
  store float %tmp_80, float addrspace(3)* %tmp_85, align 4
  call void @barrier(i32 1)
  br label %tmp_86

tmp_86:                                      ; preds = %tmp_74
  %tmp_87 = load i32* %stride, align 4
  %tmp_88 = mul nsw i32 %tmp_87, 2
  store i32 %tmp_88, i32* %stride, align 4
  br label %tmp_36

tmp_89:                                      ; preds = %tmp_36
  %tmp_90 = load i32* %tid, align 4
  %tmp_91 = icmp eq i32 %tmp_90, 0
  br i1 %tmp_91, label %tmp_92, label %tmp_107

tmp_92:                                      ; preds = %tmp_89
  %tmp_93 = load i32* %gid, align 4
  %tmp_94 = mul nsw i32 2, %tmp_93
  %tmp_95 = load float addrspace(1)** %tmp_1, align 4
  %tmp_96 = getelementptr inbounds float addrspace(1)* %tmp_95, i32 %tmp_94
  store float 0.000000e+00, float addrspace(1)* %tmp_96, align 4
  %tmp_97 = load i32* %tid, align 4
  %tmp_98 = mul nsw i32 2, %tmp_97
  %tmp_99 = load float addrspace(3)** %tmp_3, align 4
  %tmp_100 = getelementptr inbounds float addrspace(3)* %tmp_99, i32 %tmp_98
  %tmp_101 = load float addrspace(3)* %tmp_100, align 4
  %tmp_102 = load i32* %gid, align 4
  %tmp_103 = mul nsw i32 2, %tmp_102
  %tmp_104 = add nsw i32 %tmp_103, 1
  %tmp_105 = load float addrspace(1)** %tmp_1, align 4
  %tmp_106 = getelementptr inbounds float addrspace(1)* %tmp_105, i32 %tmp_104
  store float %tmp_101, float addrspace(1)* %tmp_106, align 4
  br label %tmp_128

tmp_107:                                     ; preds = %tmp_89
  %tmp_108 = load i32* %tid, align 4
  %tmp_109 = mul nsw i32 2, %tmp_108
  %tmp_110 = sub nsw i32 %tmp_109, 1
  %tmp_111 = load float addrspace(3)** %tmp_3, align 4
  %tmp_112 = getelementptr inbounds float addrspace(3)* %tmp_111, i32 %tmp_110
  %tmp_113 = load float addrspace(3)* %tmp_112, align 4
  %tmp_114 = load i32* %gid, align 4
  %tmp_115 = mul nsw i32 2, %tmp_114
  %tmp_116 = load float addrspace(1)** %tmp_1, align 4
  %tmp_117 = getelementptr inbounds float addrspace(1)* %tmp_116, i32 %tmp_115
  store float %tmp_113, float addrspace(1)* %tmp_117, align 4
  %tmp_118 = load i32* %tid, align 4
  %tmp_119 = mul nsw i32 2, %tmp_118
  %tmp_120 = load float addrspace(3)** %tmp_3, align 4
  %tmp_121 = getelementptr inbounds float addrspace(3)* %tmp_120, i32 %tmp_119
  %tmp_122 = load float addrspace(3)* %tmp_121, align 4
  %tmp_123 = load i32* %gid, align 4
  %tmp_124 = mul nsw i32 2, %tmp_123
  %tmp_125 = add nsw i32 %tmp_124, 1
  %tmp_126 = load float addrspace(1)** %tmp_1, align 4
  %tmp_127 = getelementptr inbounds float addrspace(1)* %tmp_126, i32 %tmp_125
  store float %tmp_122, float addrspace(1)* %tmp_127, align 4
  br label %tmp_128

tmp_128:                                     ; preds = %tmp_107, %tmp_92
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

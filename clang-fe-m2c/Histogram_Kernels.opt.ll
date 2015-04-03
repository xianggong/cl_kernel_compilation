; ModuleID = 'Histogram_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram256_vector(<4 x i32> addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
  %tmp_4 = call i32 @__get_local_id_u32(i32 0)
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = call i32 @__get_group_id_u32(i32 0)
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  %tmp_9 = and i32 %tmp_4, 31
  %tmp_11 = mul nsw i32 4, %tmp_9
  %tmp_13 = lshr i32 %tmp_4, 5
  %tmp_15 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %tmp_16

tmp_16:                                           ; preds = %tmp_27, %0
  %i.0 = phi i32 [ 0, %0 ], [ %tmp_29, %tmp_27 ]
  %tmp_18 = icmp slt i32 %i.0, 64
  br i1 %tmp_18, label %tmp_19, label %tmp_30

tmp_19:                                           ; preds = %tmp_16
  %tmp_22 = mul i32 %tmp_7, %i.0
  %tmp_24 = add i32 %tmp_22, %tmp_4
  %tmp_26 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_15, i32 %tmp_24
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %tmp_26, align 4
  br label %tmp_27

tmp_27:                                           ; preds = %tmp_19
  %tmp_29 = add nsw i32 %i.0, 1
  br label %tmp_16

tmp_30:                                           ; preds = %tmp_16
  call void @barrier(i32 1)
  br label %tmp_31

tmp_31:                                           ; preds = %tmp_93, %tmp_30
  %i1.0 = phi i32 [ 0, %tmp_30 ], [ %tmp_95, %tmp_93 ]
  %tmp_33 = icmp slt i32 %i1.0, 32
  br i1 %tmp_33, label %tmp_34, label %tmp_96

tmp_34:                                           ; preds = %tmp_31
  %tmp_37 = mul i32 %tmp_7, 256
  %tmp_38 = udiv i32 %tmp_37, 8
  %tmp_39 = mul i32 %tmp_6, %tmp_38
  %tmp_42 = mul i32 %i1.0, %tmp_7
  %tmp_43 = add i32 %tmp_39, %tmp_42
  %tmp_45 = add i32 %tmp_43, %tmp_4
  %tmp_47 = getelementptr inbounds <4 x i32> addrspace(1)* %data, i32 %tmp_45
  %tmp_48 = load <4 x i32> addrspace(1)* %tmp_47, align 16
  %tmp_50 = extractelement <4 x i32> %tmp_48, i32 0
  %tmp_51 = mul i32 %tmp_50, 128
  %tmp_53 = add i32 %tmp_51, %tmp_11
  %tmp_55 = add i32 %tmp_53, %tmp_13
  %tmp_57 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %tmp_55
  %tmp_58 = load i8 addrspace(3)* %tmp_57, align 1
  %tmp_59 = add i8 %tmp_58, 1
  store i8 %tmp_59, i8 addrspace(3)* %tmp_57, align 1
  %tmp_61 = extractelement <4 x i32> %tmp_48, i32 1
  %tmp_62 = mul i32 %tmp_61, 128
  %tmp_64 = add i32 %tmp_62, %tmp_11
  %tmp_66 = add i32 %tmp_64, %tmp_13
  %tmp_68 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %tmp_66
  %tmp_69 = load i8 addrspace(3)* %tmp_68, align 1
  %tmp_70 = add i8 %tmp_69, 1
  store i8 %tmp_70, i8 addrspace(3)* %tmp_68, align 1
  %tmp_72 = extractelement <4 x i32> %tmp_48, i32 2
  %tmp_73 = mul i32 %tmp_72, 128
  %tmp_75 = add i32 %tmp_73, %tmp_11
  %tmp_77 = add i32 %tmp_75, %tmp_13
  %tmp_79 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %tmp_77
  %tmp_80 = load i8 addrspace(3)* %tmp_79, align 1
  %tmp_81 = add i8 %tmp_80, 1
  store i8 %tmp_81, i8 addrspace(3)* %tmp_79, align 1
  %tmp_83 = extractelement <4 x i32> %tmp_48, i32 3
  %tmp_84 = mul i32 %tmp_83, 128
  %tmp_86 = add i32 %tmp_84, %tmp_11
  %tmp_88 = add i32 %tmp_86, %tmp_13
  %tmp_90 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %tmp_88
  %tmp_91 = load i8 addrspace(3)* %tmp_90, align 1
  %tmp_92 = add i8 %tmp_91, 1
  store i8 %tmp_92, i8 addrspace(3)* %tmp_90, align 1
  br label %tmp_93

tmp_93:                                           ; preds = %tmp_34
  %tmp_95 = add nsw i32 %i1.0, 1
  br label %tmp_31

tmp_96:                                           ; preds = %tmp_31
  call void @barrier(i32 1)
  br label %tmp_97

tmp_97:                                           ; preds = %tmp_153, %tmp_96
  %i2.0 = phi i32 [ 0, %tmp_96 ], [ %tmp_155, %tmp_153 ]
  %tmp_100 = udiv i32 256, %tmp_7
  %tmp_101 = icmp ult i32 %i2.0, %tmp_100
  br i1 %tmp_101, label %tmp_102, label %tmp_156

tmp_102:                                          ; preds = %tmp_97
  %tmp_104 = mul nsw i32 4096, %i2.0
  %tmp_106 = mul i32 %tmp_4, 32
  %tmp_107 = add i32 %tmp_104, %tmp_106
  br label %tmp_108

tmp_108:                                          ; preds = %tmp_127, %tmp_102
  %binCount.0 = phi <4 x i32> [ zeroinitializer, %tmp_102 ], [ %tmp_126, %tmp_127 ]
  %j.0 = phi i32 [ 0, %tmp_102 ], [ %tmp_129, %tmp_127 ]
  %tmp_110 = icmp slt i32 %j.0, 32
  br i1 %tmp_110, label %tmp_111, label %tmp_130

tmp_111:                                          ; preds = %tmp_108
  %tmp_114 = add nsw i32 %j.0, %tmp_9
  %tmp_115 = and i32 %tmp_114, 31
  %tmp_118 = add nsw i32 %tmp_107, %tmp_115
  %tmp_120 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_15, i32 %tmp_118
  %tmp_121 = load <4 x i8> addrspace(3)* %tmp_120, align 4
  %tmp_123 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %tmp_121)
  %tmp_126 = add <4 x i32> %binCount.0, %tmp_123
  br label %tmp_127

tmp_127:                                          ; preds = %tmp_111
  %tmp_129 = add nsw i32 %j.0, 1
  br label %tmp_108

tmp_130:                                          ; preds = %tmp_108
  %tmp_132 = extractelement <4 x i32> %binCount.0, i32 0
  %tmp_134 = extractelement <4 x i32> %binCount.0, i32 1
  %tmp_135 = add i32 %tmp_132, %tmp_134
  %tmp_137 = extractelement <4 x i32> %binCount.0, i32 2
  %tmp_138 = add i32 %tmp_135, %tmp_137
  %tmp_140 = extractelement <4 x i32> %binCount.0, i32 3
  %tmp_141 = add i32 %tmp_138, %tmp_140
  %tmp_144 = mul i32 %tmp_6, 256
  %tmp_147 = mul i32 %tmp_7, %i2.0
  %tmp_148 = add i32 %tmp_144, %tmp_147
  %tmp_150 = add i32 %tmp_148, %tmp_4
  %tmp_152 = getelementptr inbounds i32 addrspace(1)* %binResult, i32 %tmp_150
  store i32 %tmp_141, i32 addrspace(1)* %tmp_152, align 4
  br label %tmp_153

tmp_153:                                          ; preds = %tmp_130
  %tmp_155 = add nsw i32 %i2.0, 1
  br label %tmp_97

tmp_156:                                          ; preds = %tmp_97
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare void @barrier(i32) #1

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @histogram256_scalar(i32 addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
  %tmp_4 = call i32 @__get_local_id_u32(i32 0)
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = call i32 @__get_group_id_u32(i32 0)
  %tmp_7 = call i32 @__get_local_size_u32(i32 0)
  %tmp_9 = and i32 %tmp_4, 31
  %tmp_11 = mul nsw i32 4, %tmp_9
  %tmp_13 = lshr i32 %tmp_4, 5
  %tmp_15 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %tmp_16

tmp_16:                                           ; preds = %tmp_27, %0
  %i.0 = phi i32 [ 0, %0 ], [ %tmp_29, %tmp_27 ]
  %tmp_18 = icmp slt i32 %i.0, 64
  br i1 %tmp_18, label %tmp_19, label %tmp_30

tmp_19:                                           ; preds = %tmp_16
  %tmp_22 = mul i32 %tmp_7, %i.0
  %tmp_24 = add i32 %tmp_22, %tmp_4
  %tmp_26 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_15, i32 %tmp_24
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %tmp_26, align 4
  br label %tmp_27

tmp_27:                                           ; preds = %tmp_19
  %tmp_29 = add nsw i32 %i.0, 1
  br label %tmp_16

tmp_30:                                           ; preds = %tmp_16
  call void @barrier(i32 1)
  br label %tmp_31

tmp_31:                                           ; preds = %tmp_58, %tmp_30
  %i1.0 = phi i32 [ 0, %tmp_30 ], [ %tmp_60, %tmp_58 ]
  %tmp_33 = icmp slt i32 %i1.0, 128
  br i1 %tmp_33, label %tmp_34, label %tmp_61

tmp_34:                                           ; preds = %tmp_31
  %tmp_37 = mul i32 %tmp_7, 128
  %tmp_38 = mul i32 %tmp_6, %tmp_37
  %tmp_41 = mul i32 %i1.0, %tmp_7
  %tmp_42 = add i32 %tmp_38, %tmp_41
  %tmp_44 = add i32 %tmp_42, %tmp_4
  %tmp_46 = getelementptr inbounds i32 addrspace(1)* %data, i32 %tmp_44
  %tmp_47 = load i32 addrspace(1)* %tmp_46, align 4
  %tmp_49 = mul i32 %tmp_47, 128
  %tmp_51 = add i32 %tmp_49, %tmp_11
  %tmp_53 = add i32 %tmp_51, %tmp_13
  %tmp_55 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %tmp_53
  %tmp_56 = load i8 addrspace(3)* %tmp_55, align 1
  %tmp_57 = add i8 %tmp_56, 1
  store i8 %tmp_57, i8 addrspace(3)* %tmp_55, align 1
  br label %tmp_58

tmp_58:                                           ; preds = %tmp_34
  %tmp_60 = add nsw i32 %i1.0, 1
  br label %tmp_31

tmp_61:                                           ; preds = %tmp_31
  call void @barrier(i32 1)
  br label %tmp_62

tmp_62:                                           ; preds = %tmp_118, %tmp_61
  %i2.0 = phi i32 [ 0, %tmp_61 ], [ %tmp_120, %tmp_118 ]
  %tmp_65 = udiv i32 256, %tmp_7
  %tmp_66 = icmp ult i32 %i2.0, %tmp_65
  br i1 %tmp_66, label %tmp_67, label %tmp_121

tmp_67:                                           ; preds = %tmp_62
  %tmp_69 = mul nsw i32 4096, %i2.0
  %tmp_71 = mul i32 %tmp_4, 32
  %tmp_72 = add i32 %tmp_69, %tmp_71
  br label %tmp_73

tmp_73:                                           ; preds = %tmp_92, %tmp_67
  %binCount.0 = phi <4 x i32> [ zeroinitializer, %tmp_67 ], [ %tmp_91, %tmp_92 ]
  %j.0 = phi i32 [ 0, %tmp_67 ], [ %tmp_94, %tmp_92 ]
  %tmp_75 = icmp slt i32 %j.0, 32
  br i1 %tmp_75, label %tmp_76, label %tmp_95

tmp_76:                                           ; preds = %tmp_73
  %tmp_79 = add nsw i32 %j.0, %tmp_9
  %tmp_80 = and i32 %tmp_79, 31
  %tmp_83 = add nsw i32 %tmp_72, %tmp_80
  %tmp_85 = getelementptr inbounds <4 x i8> addrspace(3)* %tmp_15, i32 %tmp_83
  %tmp_86 = load <4 x i8> addrspace(3)* %tmp_85, align 4
  %tmp_88 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %tmp_86)
  %tmp_91 = add <4 x i32> %binCount.0, %tmp_88
  br label %tmp_92

tmp_92:                                           ; preds = %tmp_76
  %tmp_94 = add nsw i32 %j.0, 1
  br label %tmp_73

tmp_95:                                           ; preds = %tmp_73
  %tmp_97 = extractelement <4 x i32> %binCount.0, i32 0
  %tmp_99 = extractelement <4 x i32> %binCount.0, i32 1
  %tmp_100 = add i32 %tmp_97, %tmp_99
  %tmp_102 = extractelement <4 x i32> %binCount.0, i32 2
  %tmp_103 = add i32 %tmp_100, %tmp_102
  %tmp_105 = extractelement <4 x i32> %binCount.0, i32 3
  %tmp_106 = add i32 %tmp_103, %tmp_105
  %tmp_109 = mul i32 %tmp_6, 256
  %tmp_112 = mul i32 %tmp_7, %i2.0
  %tmp_113 = add i32 %tmp_109, %tmp_112
  %tmp_115 = add i32 %tmp_113, %tmp_4
  %tmp_117 = getelementptr inbounds i32 addrspace(1)* %binResult, i32 %tmp_115
  store i32 %tmp_106, i32 addrspace(1)* %tmp_117, align 4
  br label %tmp_118

tmp_118:                                          ; preds = %tmp_95
  %tmp_120 = add nsw i32 %i2.0, 1
  br label %tmp_62

tmp_121:                                          ; preds = %tmp_62
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_vector}
!1 = metadata !{void (i32 addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

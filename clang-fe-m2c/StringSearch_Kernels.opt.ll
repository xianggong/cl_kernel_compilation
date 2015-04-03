; ModuleID = 'StringSearch_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@StringSearchNaive.groupSuccessCounter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack1Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack2Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.groupSuccessCounter = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define i32 @compare(i8 addrspace(1)* %text, i8 addrspace(3)* %pattern, i32 %length) #0 {
  br label %tmp_5

tmp_5:                                            ; preds = %tmp_47, %0
  %l.0 = phi i32 [ 0, %0 ], [ %tmp_49, %tmp_47 ]
  %tmp_8 = icmp ult i32 %l.0, %length
  br i1 %tmp_8, label %tmp_9, label %tmp_50

tmp_9:                                            ; preds = %tmp_5
  %tmp_12 = getelementptr inbounds i8 addrspace(1)* %text, i32 %l.0
  %tmp_13 = load i8 addrspace(1)* %tmp_12, align 1
  %tmp_14 = zext i8 %tmp_13 to i32
  %tmp_15 = icmp sle i32 65, %tmp_14
  br i1 %tmp_15, label %tmp_16, label %tmp_31

tmp_16:                                           ; preds = %tmp_9
  %tmp_19 = getelementptr inbounds i8 addrspace(1)* %text, i32 %l.0
  %tmp_20 = load i8 addrspace(1)* %tmp_19, align 1
  %tmp_21 = zext i8 %tmp_20 to i32
  %tmp_22 = icmp sle i32 %tmp_21, 90
  br i1 %tmp_22, label %tmp_23, label %tmp_31

tmp_23:                                           ; preds = %tmp_16
  %tmp_26 = getelementptr inbounds i8 addrspace(1)* %text, i32 %l.0
  %tmp_27 = load i8 addrspace(1)* %tmp_26, align 1
  %tmp_28 = zext i8 %tmp_27 to i32
  %tmp_29 = sub nsw i32 %tmp_28, 65
  %tmp_30 = add nsw i32 %tmp_29, 97
  br label %tmp_37

tmp_31:                                           ; preds = %tmp_16, %tmp_9
  %tmp_34 = getelementptr inbounds i8 addrspace(1)* %text, i32 %l.0
  %tmp_35 = load i8 addrspace(1)* %tmp_34, align 1
  %tmp_36 = zext i8 %tmp_35 to i32
  br label %tmp_37

tmp_37:                                           ; preds = %tmp_31, %tmp_23
  %tmp_38 = phi i32 [ %tmp_30, %tmp_23 ], [ %tmp_36, %tmp_31 ]
  %tmp_41 = getelementptr inbounds i8 addrspace(3)* %pattern, i32 %l.0
  %tmp_42 = load i8 addrspace(3)* %tmp_41, align 1
  %tmp_43 = zext i8 %tmp_42 to i32
  %tmp_44 = icmp ne i32 %tmp_38, %tmp_43
  br i1 %tmp_44, label %tmp_45, label %tmp_46

tmp_45:                                           ; preds = %tmp_37
  br label %tmp_51

tmp_46:                                           ; preds = %tmp_37
  br label %tmp_47

tmp_47:                                           ; preds = %tmp_46
  %tmp_49 = add i32 %l.0, 1
  br label %tmp_5

tmp_50:                                           ; preds = %tmp_5
  br label %tmp_51

tmp_51:                                           ; preds = %tmp_50, %tmp_45
  %tmp_1.0 = phi i32 [ 0, %tmp_45 ], [ 1, %tmp_50 ]
  ret i32 %tmp_1.0
}

; Function Attrs: nounwind
define void @StringSearchNaive(i8 addrspace(1)* %text, i32 %textLength, i8 addrspace(1)* %pattern, i32 %patternLength, i32 addrspace(1)* %resultBuffer, i32 addrspace(1)* %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* %localPattern) #0 {
  %tmp_9 = call i32 @__get_local_id_u32(i32 0)
  %tmp_10 = call i32 @__get_local_size_u32(i32 0)
  %tmp_11 = call i32 @__get_group_id_u32(i32 0)
  %tmp_14 = sub i32 %textLength, %patternLength
  %tmp_15 = add i32 %tmp_14, 1
  %tmp_18 = mul i32 %tmp_11, %maxSearchLength
  %tmp_21 = add i32 %tmp_18, %maxSearchLength
  %tmp_24 = icmp ugt i32 %tmp_18, %tmp_15
  br i1 %tmp_24, label %tmp_25, label %tmp_26

tmp_25:                                           ; preds = %0
  br label %tmp_117

tmp_26:                                           ; preds = %0
  %tmp_29 = icmp ugt i32 %tmp_21, %tmp_15
  br i1 %tmp_29, label %tmp_30, label %tmp_32

tmp_30:                                           ; preds = %tmp_26
  br label %tmp_32

tmp_32:                                           ; preds = %tmp_30, %tmp_26
  %endSearchIdx.0 = phi i32 [ %tmp_15, %tmp_30 ], [ %tmp_21, %tmp_26 ]
  br label %tmp_34

tmp_34:                                           ; preds = %tmp_72, %tmp_32
  %idx.0 = phi i32 [ %tmp_9, %tmp_32 ], [ %tmp_75, %tmp_72 ]
  %tmp_37 = icmp ult i32 %idx.0, %patternLength
  br i1 %tmp_37, label %tmp_38, label %tmp_76

tmp_38:                                           ; preds = %tmp_34
  %tmp_41 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %tmp_42 = load i8 addrspace(1)* %tmp_41, align 1
  %tmp_43 = zext i8 %tmp_42 to i32
  %tmp_44 = icmp sle i32 65, %tmp_43
  br i1 %tmp_44, label %tmp_45, label %tmp_60

tmp_45:                                           ; preds = %tmp_38
  %tmp_48 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %tmp_49 = load i8 addrspace(1)* %tmp_48, align 1
  %tmp_50 = zext i8 %tmp_49 to i32
  %tmp_51 = icmp sle i32 %tmp_50, 90
  br i1 %tmp_51, label %tmp_52, label %tmp_60

tmp_52:                                           ; preds = %tmp_45
  %tmp_55 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %tmp_56 = load i8 addrspace(1)* %tmp_55, align 1
  %tmp_57 = zext i8 %tmp_56 to i32
  %tmp_58 = sub nsw i32 %tmp_57, 65
  %tmp_59 = add nsw i32 %tmp_58, 97
  br label %tmp_66

tmp_60:                                           ; preds = %tmp_45, %tmp_38
  %tmp_63 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %tmp_64 = load i8 addrspace(1)* %tmp_63, align 1
  %tmp_65 = zext i8 %tmp_64 to i32
  br label %tmp_66

tmp_66:                                           ; preds = %tmp_60, %tmp_52
  %tmp_67 = phi i32 [ %tmp_59, %tmp_52 ], [ %tmp_65, %tmp_60 ]
  %tmp_68 = trunc i32 %tmp_67 to i8
  %tmp_71 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %idx.0
  store i8 %tmp_68, i8 addrspace(3)* %tmp_71, align 1
  br label %tmp_72

tmp_72:                                           ; preds = %tmp_66
  %tmp_75 = add nsw i32 %idx.0, %tmp_10
  br label %tmp_34

tmp_76:                                           ; preds = %tmp_34
  %tmp_78 = icmp eq i32 %tmp_9, 0
  br i1 %tmp_78, label %tmp_79, label %tmp_80

tmp_79:                                           ; preds = %tmp_76
  store volatile i32 0, i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4
  br label %tmp_80

tmp_80:                                           ; preds = %tmp_79, %tmp_76
  call void @barrier(i32 1)
  %tmp_83 = add i32 %tmp_18, %tmp_9
  br label %tmp_84

tmp_84:                                           ; preds = %tmp_105, %tmp_80
  %stringPos.0 = phi i32 [ %tmp_83, %tmp_80 ], [ %tmp_108, %tmp_105 ]
  %tmp_87 = icmp ult i32 %stringPos.0, %endSearchIdx.0
  br i1 %tmp_87, label %tmp_88, label %tmp_109

tmp_88:                                           ; preds = %tmp_84
  %tmp_91 = getelementptr inbounds i8 addrspace(1)* %text, i32 %stringPos.0
  %tmp_94 = call i32 @compare(i8 addrspace(1)* %tmp_91, i8 addrspace(3)* %localPattern, i32 %patternLength)
  %tmp_95 = icmp eq i32 %tmp_94, 1
  br i1 %tmp_95, label %tmp_96, label %tmp_104

tmp_96:                                           ; preds = %tmp_88
  %tmp_97 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, i32 1)
  %tmp_101 = add i32 %tmp_18, %tmp_97
  %tmp_103 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i32 %tmp_101
  store i32 %stringPos.0, i32 addrspace(1)* %tmp_103, align 4
  br label %tmp_104

tmp_104:                                          ; preds = %tmp_96, %tmp_88
  br label %tmp_105

tmp_105:                                          ; preds = %tmp_104
  %tmp_108 = add i32 %stringPos.0, %tmp_10
  br label %tmp_84

tmp_109:                                          ; preds = %tmp_84
  call void @barrier(i32 1)
  %tmp_111 = icmp eq i32 %tmp_9, 0
  br i1 %tmp_111, label %tmp_112, label %tmp_117

tmp_112:                                          ; preds = %tmp_109
  %tmp_113 = load volatile i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4
  %tmp_116 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i32 %tmp_11
  store i32 %tmp_113, i32 addrspace(1)* %tmp_116, align 4
  br label %tmp_117

tmp_117:                                          ; preds = %tmp_112, %tmp_109, %tmp_25
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

; Function Attrs: nounwind
define void @StringSearchLoadBalance(i8 addrspace(1)* %text, i32 %textLength, i8 addrspace(1)* %pattern, i32 %patternLength, i32 addrspace(1)* %resultBuffer, i32 addrspace(1)* %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* %localPattern, i32 addrspace(3)* %stack1) #0 {
  %tmp_10 = call i32 @__get_local_id_u32(i32 0)
  %tmp_11 = call i32 @__get_local_size_u32(i32 0)
  %tmp_12 = call i32 @__get_group_id_u32(i32 0)
  %tmp_14 = icmp eq i32 %tmp_10, 0
  br i1 %tmp_14, label %tmp_15, label %tmp_16

tmp_15:                                           ; preds = %0
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack2Counter, align 4
  br label %tmp_16

tmp_16:                                           ; preds = %tmp_15, %0
  %tmp_19 = sub i32 %textLength, %patternLength
  %tmp_20 = add i32 %tmp_19, 1
  %tmp_23 = mul i32 %tmp_12, %maxSearchLength
  %tmp_26 = add i32 %tmp_23, %maxSearchLength
  %tmp_29 = icmp ugt i32 %tmp_23, %tmp_20
  br i1 %tmp_29, label %tmp_30, label %tmp_31

tmp_30:                                           ; preds = %tmp_16
  br label %tmp_264

tmp_31:                                           ; preds = %tmp_16
  %tmp_34 = icmp ugt i32 %tmp_26, %tmp_20
  br i1 %tmp_34, label %tmp_35, label %tmp_37

tmp_35:                                           ; preds = %tmp_31
  br label %tmp_37

tmp_37:                                           ; preds = %tmp_35, %tmp_31
  %endSearchIdx.0 = phi i32 [ %tmp_20, %tmp_35 ], [ %tmp_26, %tmp_31 ]
  %tmp_40 = sub i32 %endSearchIdx.0, %tmp_23
  br label %tmp_42

tmp_42:                                           ; preds = %tmp_80, %tmp_37
  %idx.0 = phi i32 [ %tmp_10, %tmp_37 ], [ %tmp_83, %tmp_80 ]
  %tmp_45 = icmp ult i32 %idx.0, %patternLength
  br i1 %tmp_45, label %tmp_46, label %tmp_84

tmp_46:                                           ; preds = %tmp_42
  %tmp_49 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %tmp_50 = load i8 addrspace(1)* %tmp_49, align 1
  %tmp_51 = zext i8 %tmp_50 to i32
  %tmp_52 = icmp sle i32 65, %tmp_51
  br i1 %tmp_52, label %tmp_53, label %tmp_68

tmp_53:                                           ; preds = %tmp_46
  %tmp_56 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %tmp_57 = load i8 addrspace(1)* %tmp_56, align 1
  %tmp_58 = zext i8 %tmp_57 to i32
  %tmp_59 = icmp sle i32 %tmp_58, 90
  br i1 %tmp_59, label %tmp_60, label %tmp_68

tmp_60:                                           ; preds = %tmp_53
  %tmp_63 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %tmp_64 = load i8 addrspace(1)* %tmp_63, align 1
  %tmp_65 = zext i8 %tmp_64 to i32
  %tmp_66 = sub nsw i32 %tmp_65, 65
  %tmp_67 = add nsw i32 %tmp_66, 97
  br label %tmp_74

tmp_68:                                           ; preds = %tmp_53, %tmp_46
  %tmp_71 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %tmp_72 = load i8 addrspace(1)* %tmp_71, align 1
  %tmp_73 = zext i8 %tmp_72 to i32
  br label %tmp_74

tmp_74:                                           ; preds = %tmp_68, %tmp_60
  %tmp_75 = phi i32 [ %tmp_67, %tmp_60 ], [ %tmp_73, %tmp_68 ]
  %tmp_76 = trunc i32 %tmp_75 to i8
  %tmp_79 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %idx.0
  store i8 %tmp_76, i8 addrspace(3)* %tmp_79, align 1
  br label %tmp_80

tmp_80:                                           ; preds = %tmp_74
  %tmp_83 = add i32 %idx.0, %tmp_11
  br label %tmp_42

tmp_84:                                           ; preds = %tmp_42
  call void @barrier(i32 1)
  %tmp_86 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 0
  %tmp_87 = load i8 addrspace(3)* %tmp_86, align 1
  %tmp_89 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 1
  %tmp_90 = load i8 addrspace(3)* %tmp_89, align 1
  br label %tmp_92

tmp_92:                                           ; preds = %tmp_255, %tmp_205, %tmp_84
  %stringPos.0 = phi i32 [ %tmp_10, %tmp_84 ], [ %tmp_192, %tmp_205 ], [ %tmp_192, %tmp_255 ]
  %tmp_95 = icmp ult i32 %stringPos.0, %tmp_40
  br i1 %tmp_95, label %tmp_96, label %tmp_189

tmp_96:                                           ; preds = %tmp_92
  %tmp_98 = zext i8 %tmp_87 to i32
  %tmp_101 = add i32 %tmp_23, %stringPos.0
  %tmp_103 = getelementptr inbounds i8 addrspace(1)* %text, i32 %tmp_101
  %tmp_104 = load i8 addrspace(1)* %tmp_103, align 1
  %tmp_105 = zext i8 %tmp_104 to i32
  %tmp_106 = icmp sle i32 65, %tmp_105
  br i1 %tmp_106, label %tmp_107, label %tmp_126

tmp_107:                                          ; preds = %tmp_96
  %tmp_110 = add i32 %tmp_23, %stringPos.0
  %tmp_112 = getelementptr inbounds i8 addrspace(1)* %text, i32 %tmp_110
  %tmp_113 = load i8 addrspace(1)* %tmp_112, align 1
  %tmp_114 = zext i8 %tmp_113 to i32
  %tmp_115 = icmp sle i32 %tmp_114, 90
  br i1 %tmp_115, label %tmp_116, label %tmp_126

tmp_116:                                          ; preds = %tmp_107
  %tmp_119 = add i32 %tmp_23, %stringPos.0
  %tmp_121 = getelementptr inbounds i8 addrspace(1)* %text, i32 %tmp_119
  %tmp_122 = load i8 addrspace(1)* %tmp_121, align 1
  %tmp_123 = zext i8 %tmp_122 to i32
  %tmp_124 = sub nsw i32 %tmp_123, 65
  %tmp_125 = add nsw i32 %tmp_124, 97
  br label %tmp_134

tmp_126:                                          ; preds = %tmp_107, %tmp_96
  %tmp_129 = add i32 %tmp_23, %stringPos.0
  %tmp_131 = getelementptr inbounds i8 addrspace(1)* %text, i32 %tmp_129
  %tmp_132 = load i8 addrspace(1)* %tmp_131, align 1
  %tmp_133 = zext i8 %tmp_132 to i32
  br label %tmp_134

tmp_134:                                          ; preds = %tmp_126, %tmp_116
  %tmp_135 = phi i32 [ %tmp_125, %tmp_116 ], [ %tmp_133, %tmp_126 ]
  %tmp_136 = icmp eq i32 %tmp_98, %tmp_135
  br i1 %tmp_136, label %tmp_137, label %tmp_188

tmp_137:                                          ; preds = %tmp_134
  %tmp_139 = zext i8 %tmp_90 to i32
  %tmp_142 = add i32 %tmp_23, %stringPos.0
  %tmp_143 = add i32 %tmp_142, 1
  %tmp_145 = getelementptr inbounds i8 addrspace(1)* %text, i32 %tmp_143
  %tmp_146 = load i8 addrspace(1)* %tmp_145, align 1
  %tmp_147 = zext i8 %tmp_146 to i32
  %tmp_148 = icmp sle i32 65, %tmp_147
  br i1 %tmp_148, label %tmp_149, label %tmp_170

tmp_149:                                          ; preds = %tmp_137
  %tmp_152 = add i32 %tmp_23, %stringPos.0
  %tmp_153 = add i32 %tmp_152, 1
  %tmp_155 = getelementptr inbounds i8 addrspace(1)* %text, i32 %tmp_153
  %tmp_156 = load i8 addrspace(1)* %tmp_155, align 1
  %tmp_157 = zext i8 %tmp_156 to i32
  %tmp_158 = icmp sle i32 %tmp_157, 90
  br i1 %tmp_158, label %tmp_159, label %tmp_170

tmp_159:                                          ; preds = %tmp_149
  %tmp_162 = add i32 %tmp_23, %stringPos.0
  %tmp_163 = add i32 %tmp_162, 1
  %tmp_165 = getelementptr inbounds i8 addrspace(1)* %text, i32 %tmp_163
  %tmp_166 = load i8 addrspace(1)* %tmp_165, align 1
  %tmp_167 = zext i8 %tmp_166 to i32
  %tmp_168 = sub nsw i32 %tmp_167, 65
  %tmp_169 = add nsw i32 %tmp_168, 97
  br label %tmp_179

tmp_170:                                          ; preds = %tmp_149, %tmp_137
  %tmp_173 = add i32 %tmp_23, %stringPos.0
  %tmp_174 = add i32 %tmp_173, 1
  %tmp_176 = getelementptr inbounds i8 addrspace(1)* %text, i32 %tmp_174
  %tmp_177 = load i8 addrspace(1)* %tmp_176, align 1
  %tmp_178 = zext i8 %tmp_177 to i32
  br label %tmp_179

tmp_179:                                          ; preds = %tmp_170, %tmp_159
  %tmp_180 = phi i32 [ %tmp_169, %tmp_159 ], [ %tmp_178, %tmp_170 ]
  %tmp_181 = icmp eq i32 %tmp_139, %tmp_180
  br i1 %tmp_181, label %tmp_182, label %tmp_188

tmp_182:                                          ; preds = %tmp_179
  %tmp_183 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1)
  %tmp_187 = getelementptr inbounds i32 addrspace(3)* %stack1, i32 %tmp_183
  store i32 %stringPos.0, i32 addrspace(3)* %tmp_187, align 4
  br label %tmp_188

tmp_188:                                          ; preds = %tmp_182, %tmp_179, %tmp_134
  br label %tmp_189

tmp_189:                                          ; preds = %tmp_188, %tmp_92
  %tmp_192 = add nsw i32 %stringPos.0, %tmp_11
  call void @barrier(i32 1)
  %tmp_193 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  call void @barrier(i32 1)
  %tmp_196 = icmp ult i32 %tmp_193, %tmp_11
  br i1 %tmp_196, label %tmp_197, label %tmp_206

tmp_197:                                          ; preds = %tmp_189
  %tmp_200 = sdiv i32 %tmp_192, %tmp_11
  %tmp_202 = mul nsw i32 %tmp_200, %tmp_11
  %tmp_204 = icmp ult i32 %tmp_202, %tmp_40
  br i1 %tmp_204, label %tmp_205, label %tmp_206

tmp_205:                                          ; preds = %tmp_197
  br label %tmp_92

tmp_206:                                          ; preds = %tmp_197, %tmp_189
  %tmp_209 = icmp ult i32 %tmp_10, %tmp_193
  br i1 %tmp_209, label %tmp_210, label %tmp_240

tmp_210:                                          ; preds = %tmp_206
  %tmp_211 = call i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1)
  %tmp_213 = add nsw i32 %tmp_211, -1
  %tmp_215 = getelementptr inbounds i32 addrspace(3)* %stack1, i32 %tmp_213
  %tmp_216 = load i32 addrspace(3)* %tmp_215, align 4
  %tmp_219 = getelementptr inbounds i8 addrspace(1)* %text, i32 %tmp_23
  %tmp_221 = getelementptr inbounds i8 addrspace(1)* %tmp_219, i32 %tmp_216
  %tmp_222 = getelementptr inbounds i8 addrspace(1)* %tmp_221, i32 2
  %tmp_224 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 2
  %tmp_226 = sub i32 %patternLength, 2
  %tmp_227 = call i32 @compare(i8 addrspace(1)* %tmp_222, i8 addrspace(3)* %tmp_224, i32 %tmp_226)
  %tmp_228 = icmp eq i32 %tmp_227, 1
  br i1 %tmp_228, label %tmp_229, label %tmp_239

tmp_229:                                          ; preds = %tmp_210
  %tmp_230 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, i32 1)
  %tmp_233 = add i32 %tmp_23, %tmp_216
  %tmp_236 = add i32 %tmp_23, %tmp_230
  %tmp_238 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i32 %tmp_236
  store i32 %tmp_233, i32 addrspace(1)* %tmp_238, align 4
  br label %tmp_239

tmp_239:                                          ; preds = %tmp_229, %tmp_210
  br label %tmp_240

tmp_240:                                          ; preds = %tmp_239, %tmp_206
  call void @barrier(i32 1)
  %tmp_243 = sdiv i32 %tmp_192, %tmp_11
  %tmp_245 = mul nsw i32 %tmp_243, %tmp_11
  %tmp_247 = icmp uge i32 %tmp_245, %tmp_40
  br i1 %tmp_247, label %tmp_248, label %tmp_255

tmp_248:                                          ; preds = %tmp_240
  %tmp_249 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  %tmp_250 = icmp ule i32 %tmp_249, 0
  br i1 %tmp_250, label %tmp_251, label %tmp_255

tmp_251:                                          ; preds = %tmp_248
  %tmp_252 = load i32 addrspace(3)* @StringSearchLoadBalance.stack2Counter, align 4
  %tmp_253 = icmp ule i32 %tmp_252, 0
  br i1 %tmp_253, label %tmp_254, label %tmp_255

tmp_254:                                          ; preds = %tmp_251
  br label %tmp_256

tmp_255:                                          ; preds = %tmp_251, %tmp_248, %tmp_240
  br label %tmp_92

tmp_256:                                          ; preds = %tmp_254
  %tmp_258 = icmp eq i32 %tmp_10, 0
  br i1 %tmp_258, label %tmp_259, label %tmp_264

tmp_259:                                          ; preds = %tmp_256
  %tmp_260 = load i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4
  %tmp_263 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i32 %tmp_12
  store i32 %tmp_260, i32 addrspace(1)* %tmp_263, align 4
  br label %tmp_264

tmp_264:                                          ; preds = %tmp_259, %tmp_256, %tmp_30
  ret void
}

declare i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)*, i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*)* @StringSearchNaive}
!1 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*, i32 addrspace(3)*)* @StringSearchLoadBalance}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

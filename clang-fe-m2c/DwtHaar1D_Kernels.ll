; ModuleID = '../kernel-src/DwtHaar1D_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @dwtHaar1D(float addrspace(1)* %inSignal, float addrspace(1)* %coefsSignal, float addrspace(1)* %AverageSignal, float addrspace(3)* %sharedArray, i32 %tLevels, i32 %signalLength, i32 %levelsDone, i32 %mLevels) #0 {
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca float addrspace(1)*, align 4
  %tmp_3 = alloca float addrspace(1)*, align 4
  %tmp_4 = alloca float addrspace(3)*, align 4
  %tmp_5 = alloca i32, align 4
  %tmp_6 = alloca i32, align 4
  %tmp_7 = alloca i32, align 4
  %tmp_8 = alloca i32, align 4
  %localId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %globalId = alloca i32, align 4
  %localSize = alloca i32, align 4
  %t0 = alloca float, align 4
  %t1 = alloca float, align 4
  %r = alloca float, align 4
  %levels = alloca i32, align 4
  %activeThreads = alloca i32, align 4
  %midOutPos = alloca i32, align 4
  %rsqrt_two = alloca float, align 4
  %i = alloca i32, align 4
  %data0 = alloca float, align 4
  %data1 = alloca float, align 4
  %globalPos = alloca i32, align 4
  store float addrspace(1)* %inSignal, float addrspace(1)** %tmp_1, align 4
  store float addrspace(1)* %coefsSignal, float addrspace(1)** %tmp_2, align 4
  store float addrspace(1)* %AverageSignal, float addrspace(1)** %tmp_3, align 4
  store float addrspace(3)* %sharedArray, float addrspace(3)** %tmp_4, align 4
  store i32 %tLevels, i32* %tmp_5, align 4
  store i32 %signalLength, i32* %tmp_6, align 4
  store i32 %levelsDone, i32* %tmp_7, align 4
  store i32 %mLevels, i32* %tmp_8, align 4
  %tmp_9 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_9, i32* %localId, align 4
  %tmp_10 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_10, i32* %groupId, align 4
  %tmp_11 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_11, i32* %globalId, align 4
  %tmp_12 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_12, i32* %localSize, align 4
  %tmp_13 = load i32* %groupId, align 4
  %tmp_14 = load i32* %localSize, align 4
  %tmp_15 = mul i32 %tmp_13, %tmp_14
  %tmp_16 = mul i32 %tmp_15, 2
  %tmp_17 = load i32* %localId, align 4
  %tmp_18 = add i32 %tmp_16, %tmp_17
  %tmp_19 = load float addrspace(1)** %tmp_1, align 4
  %tmp_20 = getelementptr inbounds float addrspace(1)* %tmp_19, i32 %tmp_18
  %tmp_21 = load float addrspace(1)* %tmp_20, align 4
  store float %tmp_21, float* %t0, align 4
  %tmp_22 = load i32* %groupId, align 4
  %tmp_23 = load i32* %localSize, align 4
  %tmp_24 = mul i32 %tmp_22, %tmp_23
  %tmp_25 = mul i32 %tmp_24, 2
  %tmp_26 = load i32* %localSize, align 4
  %tmp_27 = add i32 %tmp_25, %tmp_26
  %tmp_28 = load i32* %localId, align 4
  %tmp_29 = add i32 %tmp_27, %tmp_28
  %tmp_30 = load float addrspace(1)** %tmp_1, align 4
  %tmp_31 = getelementptr inbounds float addrspace(1)* %tmp_30, i32 %tmp_29
  %tmp_32 = load float addrspace(1)* %tmp_31, align 4
  store float %tmp_32, float* %t1, align 4
  %tmp_33 = load i32* %tmp_7, align 4
  %tmp_34 = icmp eq i32 0, %tmp_33
  br i1 %tmp_34, label %tmp_35, label %tmp_46

tmp_35:                                      ; preds = %tmp_0
  %tmp_36 = load i32* %tmp_6, align 4
  %tmp_37 = uitofp i32 %tmp_36 to float
  %tmp_38 = call float @llvm.sqrt.f32(float %tmp_37)
  %tmp_39 = fdiv float 1.000000e+00, %tmp_38, !fpmath !2
  store float %tmp_39, float* %r, align 4
  %tmp_40 = load float* %r, align 4
  %tmp_41 = load float* %t0, align 4
  %tmp_42 = fmul float %tmp_41, %tmp_40
  store float %tmp_42, float* %t0, align 4
  %tmp_43 = load float* %r, align 4
  %tmp_44 = load float* %t1, align 4
  %tmp_45 = fmul float %tmp_44, %tmp_43
  store float %tmp_45, float* %t1, align 4
  br label %tmp_46

tmp_46:                                      ; preds = %tmp_35, %tmp_0
  %tmp_47 = load float* %t0, align 4
  %tmp_48 = load i32* %localId, align 4
  %tmp_49 = load float addrspace(3)** %tmp_4, align 4
  %tmp_50 = getelementptr inbounds float addrspace(3)* %tmp_49, i32 %tmp_48
  store float %tmp_47, float addrspace(3)* %tmp_50, align 4
  %tmp_51 = load float* %t1, align 4
  %tmp_52 = load i32* %localSize, align 4
  %tmp_53 = load i32* %localId, align 4
  %tmp_54 = add i32 %tmp_52, %tmp_53
  %tmp_55 = load float addrspace(3)** %tmp_4, align 4
  %tmp_56 = getelementptr inbounds float addrspace(3)* %tmp_55, i32 %tmp_54
  store float %tmp_51, float addrspace(3)* %tmp_56, align 4
  call void @barrier(i32 1)
  %tmp_57 = load i32* %tmp_5, align 4
  %tmp_58 = load i32* %tmp_8, align 4
  %tmp_59 = icmp ugt i32 %tmp_57, %tmp_58
  br i1 %tmp_59, label %tmp_60, label %tmp_62

tmp_60:                                      ; preds = %tmp_46
  %tmp_61 = load i32* %tmp_8, align 4
  br label %tmp_64

tmp_62:                                      ; preds = %tmp_46
  %tmp_63 = load i32* %tmp_5, align 4
  br label %tmp_64

tmp_64:                                      ; preds = %tmp_62, %tmp_60
  %tmp_65 = phi i32 [ %tmp_61, %tmp_60 ], [ %tmp_63, %tmp_62 ]
  store i32 %tmp_65, i32* %levels, align 4
  %tmp_66 = load i32* %levels, align 4
  %tmp_67 = and i32 %tmp_66, 31
  %tmp_68 = shl i32 1, %tmp_67
  %tmp_69 = sdiv i32 %tmp_68, 2
  store i32 %tmp_69, i32* %activeThreads, align 4
  %tmp_70 = load i32* %tmp_6, align 4
  %tmp_71 = udiv i32 %tmp_70, 2
  store i32 %tmp_71, i32* %midOutPos, align 4
  %tmp_72 = call float @llvm.sqrt.f32(float 2.000000e+00)
  %tmp_73 = fdiv float 1.000000e+00, %tmp_72, !fpmath !2
  store float %tmp_73, float* %rsqrt_two, align 4
  store i32 0, i32* %i, align 4
  br label %tmp_74

tmp_74:                                      ; preds = %tmp_127, %tmp_64
  %tmp_75 = load i32* %i, align 4
  %tmp_76 = load i32* %levels, align 4
  %tmp_77 = icmp ult i32 %tmp_75, %tmp_76
  br i1 %tmp_77, label %tmp_78, label %tmp_130

tmp_78:                                      ; preds = %tmp_74
  %tmp_79 = load i32* %localId, align 4
  %tmp_80 = load i32* %activeThreads, align 4
  %tmp_81 = icmp ult i32 %tmp_79, %tmp_80
  br i1 %tmp_81, label %tmp_82, label %tmp_94

tmp_82:                                      ; preds = %tmp_78
  %tmp_83 = load i32* %localId, align 4
  %tmp_84 = mul i32 2, %tmp_83
  %tmp_85 = load float addrspace(3)** %tmp_4, align 4
  %tmp_86 = getelementptr inbounds float addrspace(3)* %tmp_85, i32 %tmp_84
  %tmp_87 = load float addrspace(3)* %tmp_86, align 4
  store float %tmp_87, float* %data0, align 4
  %tmp_88 = load i32* %localId, align 4
  %tmp_89 = mul i32 2, %tmp_88
  %tmp_90 = add i32 %tmp_89, 1
  %tmp_91 = load float addrspace(3)** %tmp_4, align 4
  %tmp_92 = getelementptr inbounds float addrspace(3)* %tmp_91, i32 %tmp_90
  %tmp_93 = load float addrspace(3)* %tmp_92, align 4
  store float %tmp_93, float* %data1, align 4
  br label %tmp_94

tmp_94:                                      ; preds = %tmp_82, %tmp_78
  call void @barrier(i32 1)
  %tmp_95 = load i32* %localId, align 4
  %tmp_96 = load i32* %activeThreads, align 4
  %tmp_97 = icmp ult i32 %tmp_95, %tmp_96
  br i1 %tmp_97, label %tmp_98, label %tmp_124

tmp_98:                                      ; preds = %tmp_94
  %tmp_99 = load float* %data0, align 4
  %tmp_100 = load float* %data1, align 4
  %tmp_101 = fadd float %tmp_99, %tmp_100
  %tmp_102 = load float* %rsqrt_two, align 4
  %tmp_103 = fmul float %tmp_101, %tmp_102
  %tmp_104 = load i32* %localId, align 4
  %tmp_105 = load float addrspace(3)** %tmp_4, align 4
  %tmp_106 = getelementptr inbounds float addrspace(3)* %tmp_105, i32 %tmp_104
  store float %tmp_103, float addrspace(3)* %tmp_106, align 4
  %tmp_107 = load i32* %midOutPos, align 4
  %tmp_108 = load i32* %groupId, align 4
  %tmp_109 = load i32* %activeThreads, align 4
  %tmp_110 = mul i32 %tmp_108, %tmp_109
  %tmp_111 = add i32 %tmp_107, %tmp_110
  %tmp_112 = load i32* %localId, align 4
  %tmp_113 = add i32 %tmp_111, %tmp_112
  store i32 %tmp_113, i32* %globalPos, align 4
  %tmp_114 = load float* %data0, align 4
  %tmp_115 = load float* %data1, align 4
  %tmp_116 = fsub float %tmp_114, %tmp_115
  %tmp_117 = load float* %rsqrt_two, align 4
  %tmp_118 = fmul float %tmp_116, %tmp_117
  %tmp_119 = load i32* %globalPos, align 4
  %tmp_120 = load float addrspace(1)** %tmp_2, align 4
  %tmp_121 = getelementptr inbounds float addrspace(1)* %tmp_120, i32 %tmp_119
  store float %tmp_118, float addrspace(1)* %tmp_121, align 4
  %tmp_122 = load i32* %midOutPos, align 4
  %tmp_123 = lshr i32 %tmp_122, 1
  store i32 %tmp_123, i32* %midOutPos, align 4
  br label %tmp_124

tmp_124:                                     ; preds = %tmp_98, %tmp_94
  %tmp_125 = load i32* %activeThreads, align 4
  %tmp_126 = lshr i32 %tmp_125, 1
  store i32 %tmp_126, i32* %activeThreads, align 4
  call void @barrier(i32 1)
  br label %tmp_127

tmp_127:                                     ; preds = %tmp_124
  %tmp_128 = load i32* %i, align 4
  %tmp_129 = add i32 %tmp_128, 1
  store i32 %tmp_129, i32* %i, align 4
  br label %tmp_74

tmp_130:                                     ; preds = %tmp_74
  %tmp_131 = load i32* %localId, align 4
  %tmp_132 = icmp eq i32 0, %tmp_131
  br i1 %tmp_132, label %tmp_133, label %tmp_140

tmp_133:                                     ; preds = %tmp_130
  %tmp_134 = load float addrspace(3)** %tmp_4, align 4
  %tmp_135 = getelementptr inbounds float addrspace(3)* %tmp_134, i32 0
  %tmp_136 = load float addrspace(3)* %tmp_135, align 4
  %tmp_137 = load i32* %groupId, align 4
  %tmp_138 = load float addrspace(1)** %tmp_3, align 4
  %tmp_139 = getelementptr inbounds float addrspace(1)* %tmp_138, i32 %tmp_137
  store float %tmp_136, float addrspace(1)* %tmp_139, align 4
  br label %tmp_140

tmp_140:                                     ; preds = %tmp_133, %tmp_130
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32, i32)* @dwtHaar1D}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

; ModuleID = 'DwtHaar1D_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @dwtHaar1D(float addrspace(1)* %inSignal, float addrspace(1)* %coefsSignal, float addrspace(1)* %AverageSignal, float addrspace(3)* %sharedArray, i32 %tLevels, i32 %signalLength, i32 %levelsDone, i32 %mLevels) #0 {
  %tmp_9 = call i32 @__get_local_id_u32(i32 0)
  %tmp_10 = call i32 @__get_group_id_u32(i32 0)
  %tmp_11 = call i32 @__get_global_id_u32(i32 0)
  %tmp_12 = call i32 @__get_local_size_u32(i32 0)
  %tmp_15 = mul i32 %tmp_10, %tmp_12
  %tmp_16 = mul i32 %tmp_15, 2
  %tmp_18 = add i32 %tmp_16, %tmp_9
  %tmp_20 = getelementptr inbounds float addrspace(1)* %inSignal, i32 %tmp_18
  %tmp_21 = load float addrspace(1)* %tmp_20, align 4
  %tmp_24 = mul i32 %tmp_10, %tmp_12
  %tmp_25 = mul i32 %tmp_24, 2
  %tmp_27 = add i32 %tmp_25, %tmp_12
  %tmp_29 = add i32 %tmp_27, %tmp_9
  %tmp_31 = getelementptr inbounds float addrspace(1)* %inSignal, i32 %tmp_29
  %tmp_32 = load float addrspace(1)* %tmp_31, align 4
  %tmp_34 = icmp eq i32 0, %levelsDone
  br i1 %tmp_34, label %tmp_35, label %tmp_46

tmp_35:                                           ; preds = %0
  %tmp_37 = uitofp i32 %signalLength to float
  %tmp_38 = call float @llvm.sqrt.f32(float %tmp_37)
  %tmp_39 = fdiv float 1.000000e+00, %tmp_38, !fpmath !2
  %tmp_42 = fmul float %tmp_21, %tmp_39
  %tmp_45 = fmul float %tmp_32, %tmp_39
  br label %tmp_46

tmp_46:                                           ; preds = %tmp_35, %0
  %t0.0 = phi float [ %tmp_42, %tmp_35 ], [ %tmp_21, %0 ]
  %t1.0 = phi float [ %tmp_45, %tmp_35 ], [ %tmp_32, %0 ]
  %tmp_50 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %tmp_9
  store float %t0.0, float addrspace(3)* %tmp_50, align 4
  %tmp_54 = add i32 %tmp_12, %tmp_9
  %tmp_56 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %tmp_54
  store float %t1.0, float addrspace(3)* %tmp_56, align 4
  call void @barrier(i32 1)
  %tmp_59 = icmp ugt i32 %tLevels, %mLevels
  br i1 %tmp_59, label %tmp_60, label %tmp_62

tmp_60:                                           ; preds = %tmp_46
  br label %tmp_64

tmp_62:                                           ; preds = %tmp_46
  br label %tmp_64

tmp_64:                                           ; preds = %tmp_62, %tmp_60
  %tmp_65 = phi i32 [ %mLevels, %tmp_60 ], [ %tLevels, %tmp_62 ]
  %tmp_67 = and i32 %tmp_65, 31
  %tmp_68 = shl i32 1, %tmp_67
  %tmp_69 = sdiv i32 %tmp_68, 2
  %tmp_71 = udiv i32 %signalLength, 2
  %tmp_72 = call float @llvm.sqrt.f32(float 2.000000e+00)
  %tmp_73 = fdiv float 1.000000e+00, %tmp_72, !fpmath !2
  br label %tmp_74

tmp_74:                                           ; preds = %tmp_127, %tmp_64
  %activeThreads.0 = phi i32 [ %tmp_69, %tmp_64 ], [ %tmp_126, %tmp_127 ]
  %midOutPos.0 = phi i32 [ %tmp_71, %tmp_64 ], [ %midOutPos.1, %tmp_127 ]
  %i.0 = phi i32 [ 0, %tmp_64 ], [ %tmp_129, %tmp_127 ]
  %data0.0 = phi float [ undef, %tmp_64 ], [ %data0.1, %tmp_127 ]
  %data1.0 = phi float [ undef, %tmp_64 ], [ %data1.1, %tmp_127 ]
  %tmp_77 = icmp ult i32 %i.0, %tmp_65
  br i1 %tmp_77, label %tmp_78, label %tmp_130

tmp_78:                                           ; preds = %tmp_74
  %tmp_81 = icmp ult i32 %tmp_9, %activeThreads.0
  br i1 %tmp_81, label %tmp_82, label %tmp_94

tmp_82:                                           ; preds = %tmp_78
  %tmp_84 = mul i32 2, %tmp_9
  %tmp_86 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %tmp_84
  %tmp_87 = load float addrspace(3)* %tmp_86, align 4
  %tmp_89 = mul i32 2, %tmp_9
  %tmp_90 = add i32 %tmp_89, 1
  %tmp_92 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %tmp_90
  %tmp_93 = load float addrspace(3)* %tmp_92, align 4
  br label %tmp_94

tmp_94:                                           ; preds = %tmp_82, %tmp_78
  %data0.1 = phi float [ %tmp_87, %tmp_82 ], [ %data0.0, %tmp_78 ]
  %data1.1 = phi float [ %tmp_93, %tmp_82 ], [ %data1.0, %tmp_78 ]
  call void @barrier(i32 1)
  %tmp_97 = icmp ult i32 %tmp_9, %activeThreads.0
  br i1 %tmp_97, label %tmp_98, label %tmp_124

tmp_98:                                           ; preds = %tmp_94
  %tmp_101 = fadd float %data0.1, %data1.1
  %tmp_103 = fmul float %tmp_101, %tmp_73
  %tmp_106 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %tmp_9
  store float %tmp_103, float addrspace(3)* %tmp_106, align 4
  %tmp_110 = mul i32 %tmp_10, %activeThreads.0
  %tmp_111 = add i32 %midOutPos.0, %tmp_110
  %tmp_113 = add i32 %tmp_111, %tmp_9
  %tmp_116 = fsub float %data0.1, %data1.1
  %tmp_118 = fmul float %tmp_116, %tmp_73
  %tmp_121 = getelementptr inbounds float addrspace(1)* %coefsSignal, i32 %tmp_113
  store float %tmp_118, float addrspace(1)* %tmp_121, align 4
  %tmp_123 = lshr i32 %midOutPos.0, 1
  br label %tmp_124

tmp_124:                                          ; preds = %tmp_98, %tmp_94
  %midOutPos.1 = phi i32 [ %tmp_123, %tmp_98 ], [ %midOutPos.0, %tmp_94 ]
  %tmp_126 = lshr i32 %activeThreads.0, 1
  call void @barrier(i32 1)
  br label %tmp_127

tmp_127:                                          ; preds = %tmp_124
  %tmp_129 = add i32 %i.0, 1
  br label %tmp_74

tmp_130:                                          ; preds = %tmp_74
  %tmp_132 = icmp eq i32 0, %tmp_9
  br i1 %tmp_132, label %tmp_133, label %tmp_140

tmp_133:                                          ; preds = %tmp_130
  %tmp_135 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 0
  %tmp_136 = load float addrspace(3)* %tmp_135, align 4
  %tmp_139 = getelementptr inbounds float addrspace(1)* %AverageSignal, i32 %tmp_10
  store float %tmp_136, float addrspace(1)* %tmp_139, align 4
  br label %tmp_140

tmp_140:                                          ; preds = %tmp_133, %tmp_130
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

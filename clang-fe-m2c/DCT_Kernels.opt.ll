; ModuleID = 'DCT_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define i32 @getIdx(i32 %blockIdx, i32 %blockIdy, i32 %localIdx, i32 %localIdy, i32 %blockWidth, i32 %globalWidth) #0 {
  %tmp_9 = mul i32 %blockIdx, %blockWidth
  %tmp_11 = add i32 %tmp_9, %localIdx
  %tmp_14 = mul i32 %blockIdy, %blockWidth
  %tmp_16 = add i32 %tmp_14, %localIdy
  %tmp_19 = mul i32 %tmp_16, %globalWidth
  %tmp_21 = add i32 %tmp_19, %tmp_11
  ret i32 %tmp_21
}

; Function Attrs: nounwind
define void @DCT(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(1)* %dct8x8, float addrspace(1)* %dct8x8_trans, float addrspace(3)* %inter, i32 %width, i32 %blockWidth, i32 %inverse) #0 {
  %tmp_9 = call i32 @__get_global_id_u32(i32 0)
  %tmp_10 = call i32 @__get_global_id_u32(i32 1)
  %tmp_11 = call i32 @__get_group_id_u32(i32 0)
  %tmp_12 = call i32 @__get_group_id_u32(i32 1)
  %tmp_13 = call i32 @__get_local_id_u32(i32 0)
  %tmp_14 = call i32 @__get_local_id_u32(i32 1)
  %tmp_17 = mul i32 %tmp_10, %width
  %tmp_19 = add i32 %tmp_17, %tmp_9
  br label %tmp_20

tmp_20:                                           ; preds = %tmp_64, %0
  %acc.0 = phi float [ 0.000000e+00, %0 ], [ %acc.1, %tmp_64 ]
  %k.0 = phi i32 [ 0, %0 ], [ %tmp_66, %tmp_64 ]
  %tmp_23 = icmp ult i32 %k.0, %blockWidth
  br i1 %tmp_23, label %tmp_24, label %tmp_67

tmp_24:                                           ; preds = %tmp_20
  %tmp_27 = mul i32 %tmp_14, %blockWidth
  %tmp_29 = add i32 %tmp_27, %k.0
  %tmp_36 = call i32 @getIdx(i32 %tmp_11, i32 %tmp_12, i32 %tmp_13, i32 %k.0, i32 %blockWidth, i32 %width)
  %tmp_38 = icmp ne i32 %inverse, 0
  br i1 %tmp_38, label %tmp_39, label %tmp_51

tmp_39:                                           ; preds = %tmp_24
  %tmp_42 = getelementptr inbounds float addrspace(1)* %dct8x8, i32 %tmp_29
  %tmp_43 = load float addrspace(1)* %tmp_42, align 4
  %tmp_46 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_36
  %tmp_47 = load float addrspace(1)* %tmp_46, align 4
  %tmp_48 = fmul float %tmp_43, %tmp_47
  %tmp_50 = fadd float %acc.0, %tmp_48
  br label %tmp_63

tmp_51:                                           ; preds = %tmp_24
  %tmp_54 = getelementptr inbounds float addrspace(1)* %dct8x8_trans, i32 %tmp_29
  %tmp_55 = load float addrspace(1)* %tmp_54, align 4
  %tmp_58 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_36
  %tmp_59 = load float addrspace(1)* %tmp_58, align 4
  %tmp_60 = fmul float %tmp_55, %tmp_59
  %tmp_62 = fadd float %acc.0, %tmp_60
  br label %tmp_63

tmp_63:                                           ; preds = %tmp_51, %tmp_39
  %acc.1 = phi float [ %tmp_50, %tmp_39 ], [ %tmp_62, %tmp_51 ]
  br label %tmp_64

tmp_64:                                           ; preds = %tmp_63
  %tmp_66 = add i32 %k.0, 1
  br label %tmp_20

tmp_67:                                           ; preds = %tmp_20
  %tmp_71 = mul i32 %tmp_14, %blockWidth
  %tmp_73 = add i32 %tmp_71, %tmp_13
  %tmp_75 = getelementptr inbounds float addrspace(3)* %inter, i32 %tmp_73
  store float %acc.0, float addrspace(3)* %tmp_75, align 4
  call void @barrier(i32 1)
  br label %tmp_76

tmp_76:                                           ; preds = %tmp_118, %tmp_67
  %acc.2 = phi float [ 0.000000e+00, %tmp_67 ], [ %acc.3, %tmp_118 ]
  %k1.0 = phi i32 [ 0, %tmp_67 ], [ %tmp_120, %tmp_118 ]
  %tmp_79 = icmp ult i32 %k1.0, %blockWidth
  br i1 %tmp_79, label %tmp_80, label %tmp_121

tmp_80:                                           ; preds = %tmp_76
  %tmp_83 = mul i32 %tmp_14, %blockWidth
  %tmp_85 = add i32 %tmp_83, %k1.0
  %tmp_88 = mul i32 %k1.0, %blockWidth
  %tmp_90 = add i32 %tmp_88, %tmp_13
  %tmp_92 = icmp ne i32 %inverse, 0
  br i1 %tmp_92, label %tmp_93, label %tmp_105

tmp_93:                                           ; preds = %tmp_80
  %tmp_96 = getelementptr inbounds float addrspace(3)* %inter, i32 %tmp_85
  %tmp_97 = load float addrspace(3)* %tmp_96, align 4
  %tmp_100 = getelementptr inbounds float addrspace(1)* %dct8x8_trans, i32 %tmp_90
  %tmp_101 = load float addrspace(1)* %tmp_100, align 4
  %tmp_102 = fmul float %tmp_97, %tmp_101
  %tmp_104 = fadd float %acc.2, %tmp_102
  br label %tmp_117

tmp_105:                                          ; preds = %tmp_80
  %tmp_108 = getelementptr inbounds float addrspace(3)* %inter, i32 %tmp_85
  %tmp_109 = load float addrspace(3)* %tmp_108, align 4
  %tmp_112 = getelementptr inbounds float addrspace(1)* %dct8x8, i32 %tmp_90
  %tmp_113 = load float addrspace(1)* %tmp_112, align 4
  %tmp_114 = fmul float %tmp_109, %tmp_113
  %tmp_116 = fadd float %acc.2, %tmp_114
  br label %tmp_117

tmp_117:                                          ; preds = %tmp_105, %tmp_93
  %acc.3 = phi float [ %tmp_104, %tmp_93 ], [ %tmp_116, %tmp_105 ]
  br label %tmp_118

tmp_118:                                          ; preds = %tmp_117
  %tmp_120 = add i32 %k1.0, 1
  br label %tmp_76

tmp_121:                                          ; preds = %tmp_76
  %tmp_125 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_19
  store float %acc.2, float addrspace(1)* %tmp_125, align 4
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

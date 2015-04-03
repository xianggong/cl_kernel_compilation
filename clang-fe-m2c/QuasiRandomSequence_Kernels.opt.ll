; ModuleID = 'QuasiRandomSequence_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @QuasiRandomSequence_Vector(<4 x float> addrspace(1)* %output, <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(3)* %shared) #0 {
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = call i32 @__get_local_id_u32(i32 0)
  %tmp_7 = call i32 @__get_group_id_u32(i32 0)
  %tmp_9 = mul i32 %tmp_6, 4
  %tmp_11 = insertelement <4 x i32> undef, i32 %tmp_9, i32 0
  %tmp_13 = add i32 %tmp_9, 1
  %tmp_14 = insertelement <4 x i32> %tmp_11, i32 %tmp_13, i32 1
  %tmp_16 = add i32 %tmp_9, 2
  %tmp_17 = insertelement <4 x i32> %tmp_14, i32 %tmp_16, i32 2
  %tmp_19 = add i32 %tmp_9, 3
  %tmp_20 = insertelement <4 x i32> %tmp_17, i32 %tmp_19, i32 3
  %tmp_22 = call float @llvm.pow.f32(float 2.000000e+00, float 3.200000e+01)
  br label %tmp_24

tmp_24:                                           ; preds = %tmp_38, %0
  %i.0 = phi i32 [ %tmp_6, %0 ], [ %tmp_41, %tmp_38 ]
  %tmp_26 = icmp slt i32 %i.0, 8
  br i1 %tmp_26, label %tmp_27, label %tmp_42

tmp_27:                                           ; preds = %tmp_24
  %tmp_29 = mul i32 %tmp_7, 8
  %tmp_31 = add i32 %tmp_29, %i.0
  %tmp_33 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %tmp_31
  %tmp_34 = load <4 x i32> addrspace(1)* %tmp_33, align 16
  %tmp_37 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 %i.0
  store <4 x i32> %tmp_34, <4 x i32> addrspace(3)* %tmp_37, align 16
  br label %tmp_38

tmp_38:                                           ; preds = %tmp_27
  %tmp_39 = call i32 @__get_local_size_u32(i32 0)
  %tmp_41 = add i32 %i.0, %tmp_39
  br label %tmp_24

tmp_42:                                           ; preds = %tmp_24
  call void @barrier(i32 1)
  %tmp_44 = bitcast <4 x i32> addrspace(3)* %shared to i32 addrspace(3)*
  br label %tmp_46

tmp_46:                                           ; preds = %tmp_63, %tmp_42
  %temp.0 = phi <4 x i32> [ zeroinitializer, %tmp_42 ], [ %tmp_60, %tmp_63 ]
  %lastBit.0 = phi <4 x i32> [ %tmp_20, %tmp_42 ], [ %tmp_62, %tmp_63 ]
  %k.0 = phi i32 [ 0, %tmp_42 ], [ %tmp_65, %tmp_63 ]
  %tmp_48 = icmp slt i32 %k.0, 12
  br i1 %tmp_48, label %tmp_49, label %tmp_66

tmp_49:                                           ; preds = %tmp_46
  %tmp_51 = and <4 x i32> %lastBit.0, <i32 1, i32 1, i32 1, i32 1>
  %tmp_54 = getelementptr inbounds i32 addrspace(3)* %tmp_44, i32 %k.0
  %tmp_55 = load i32 addrspace(3)* %tmp_54, align 4
  %tmp_56 = insertelement <4 x i32> undef, i32 %tmp_55, i32 0
  %tmp_57 = shufflevector <4 x i32> %tmp_56, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_58 = mul <4 x i32> %tmp_51, %tmp_57
  %tmp_60 = xor <4 x i32> %temp.0, %tmp_58
  %tmp_62 = lshr <4 x i32> %lastBit.0, <i32 1, i32 1, i32 1, i32 1>
  br label %tmp_63

tmp_63:                                           ; preds = %tmp_49
  %tmp_65 = add nsw i32 %k.0, 1
  br label %tmp_46

tmp_66:                                           ; preds = %tmp_46
  %tmp_68 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %temp.0)
  %tmp_70 = insertelement <4 x float> undef, float %tmp_22, i32 0
  %tmp_71 = shufflevector <4 x float> %tmp_70, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_72 = fdiv <4 x float> %tmp_68, %tmp_71, !fpmath !3
  %tmp_75 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_5
  store <4 x float> %tmp_72, <4 x float> addrspace(1)* %tmp_75, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #2

declare i32 @__get_local_size_u32(i32) #1

declare void @barrier(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind
define void @QuasiRandomSequence_Scalar(float addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %shared) #0 {
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  %tmp_6 = call i32 @__get_group_id_u32(i32 0)
  %tmp_7 = call float @llvm.pow.f32(float 2.000000e+00, float 3.200000e+01)
  br label %tmp_9

tmp_9:                                            ; preds = %tmp_23, %0
  %i.0 = phi i32 [ %tmp_5, %0 ], [ %tmp_26, %tmp_23 ]
  %tmp_11 = icmp slt i32 %i.0, 32
  br i1 %tmp_11, label %tmp_12, label %tmp_27

tmp_12:                                           ; preds = %tmp_9
  %tmp_14 = mul i32 %tmp_6, 32
  %tmp_16 = add i32 %tmp_14, %i.0
  %tmp_18 = getelementptr inbounds i32 addrspace(1)* %input, i32 %tmp_16
  %tmp_19 = load i32 addrspace(1)* %tmp_18, align 4
  %tmp_22 = getelementptr inbounds i32 addrspace(3)* %shared, i32 %i.0
  store i32 %tmp_19, i32 addrspace(3)* %tmp_22, align 4
  br label %tmp_23

tmp_23:                                           ; preds = %tmp_12
  %tmp_24 = call i32 @__get_local_size_u32(i32 0)
  %tmp_26 = add i32 %i.0, %tmp_24
  br label %tmp_9

tmp_27:                                           ; preds = %tmp_9
  call void @barrier(i32 1)
  br label %tmp_29

tmp_29:                                           ; preds = %tmp_44, %tmp_27
  %temp.0 = phi i32 [ 0, %tmp_27 ], [ %tmp_41, %tmp_44 ]
  %lastBit.0 = phi i32 [ %tmp_5, %tmp_27 ], [ %tmp_43, %tmp_44 ]
  %k.0 = phi i32 [ 0, %tmp_27 ], [ %tmp_46, %tmp_44 ]
  %tmp_31 = icmp slt i32 %k.0, 10
  br i1 %tmp_31, label %tmp_32, label %tmp_47

tmp_32:                                           ; preds = %tmp_29
  %tmp_34 = and i32 %lastBit.0, 1
  %tmp_37 = getelementptr inbounds i32 addrspace(3)* %shared, i32 %k.0
  %tmp_38 = load i32 addrspace(3)* %tmp_37, align 4
  %tmp_39 = mul i32 %tmp_34, %tmp_38
  %tmp_41 = xor i32 %temp.0, %tmp_39
  %tmp_43 = lshr i32 %lastBit.0, 1
  br label %tmp_44

tmp_44:                                           ; preds = %tmp_32
  %tmp_46 = add nsw i32 %k.0, 1
  br label %tmp_29

tmp_47:                                           ; preds = %tmp_29
  %tmp_49 = call float @_Z13convert_floatj(i32 %temp.0)
  %tmp_51 = fdiv float %tmp_49, %tmp_7, !fpmath !3
  %tmp_54 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_4
  store float %tmp_51, float addrspace(1)* %tmp_54, align 4
  ret void
}

declare float @_Z13convert_floatj(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @QuasiRandomSequence_Vector}
!1 = metadata !{void (float addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*)* @QuasiRandomSequence_Scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{float 2.500000e+00}

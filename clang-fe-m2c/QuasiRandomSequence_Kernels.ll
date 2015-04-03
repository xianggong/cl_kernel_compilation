; ModuleID = '../kernel-src/QuasiRandomSequence_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @QuasiRandomSequence_Vector(<4 x float> addrspace(1)* %output, <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(3)* %shared) #0 {
  %tmp_1 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_3 = alloca <4 x i32> addrspace(3)*, align 4
  %global_id = alloca i32, align 4
  %local_id = alloca i32, align 4
  %group_id = alloca i32, align 4
  %factor = alloca i32, align 4
  %vlid = alloca <4 x i32>, align 16
  %tmp_4 = alloca <4 x i32>, align 16
  %divisor = alloca float, align 4
  %i = alloca i32, align 4
  %shared_scalar = alloca i32 addrspace(3)*, align 4
  %temp = alloca <4 x i32>, align 16
  %lastBit = alloca <4 x i32>, align 16
  %k = alloca i32, align 4
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %tmp_1, align 4
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %tmp_2, align 4
  store <4 x i32> addrspace(3)* %shared, <4 x i32> addrspace(3)** %tmp_3, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_5, i32* %global_id, align 4
  %tmp_6 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_6, i32* %local_id, align 4
  %tmp_7 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_7, i32* %group_id, align 4
  %tmp_8 = load i32* %local_id, align 4
  %tmp_9 = mul i32 %tmp_8, 4
  store i32 %tmp_9, i32* %factor, align 4
  %tmp_10 = load i32* %factor, align 4
  %tmp_11 = insertelement <4 x i32> undef, i32 %tmp_10, i32 0
  %tmp_12 = load i32* %factor, align 4
  %tmp_13 = add i32 %tmp_12, 1
  %tmp_14 = insertelement <4 x i32> %tmp_11, i32 %tmp_13, i32 1
  %tmp_15 = load i32* %factor, align 4
  %tmp_16 = add i32 %tmp_15, 2
  %tmp_17 = insertelement <4 x i32> %tmp_14, i32 %tmp_16, i32 2
  %tmp_18 = load i32* %factor, align 4
  %tmp_19 = add i32 %tmp_18, 3
  %tmp_20 = insertelement <4 x i32> %tmp_17, i32 %tmp_19, i32 3
  store <4 x i32> %tmp_20, <4 x i32>* %tmp_4
  %tmp_21 = load <4 x i32>* %tmp_4
  store <4 x i32> %tmp_21, <4 x i32>* %vlid, align 16
  %tmp_22 = call float @llvm.pow.f32(float 2.000000e+00, float 3.200000e+01)
  store float %tmp_22, float* %divisor, align 4
  %tmp_23 = load i32* %local_id, align 4
  store i32 %tmp_23, i32* %i, align 4
  br label %tmp_24

tmp_24:                                      ; preds = %tmp_38, %tmp_0
  %tmp_25 = load i32* %i, align 4
  %tmp_26 = icmp slt i32 %tmp_25, 8
  br i1 %tmp_26, label %tmp_27, label %tmp_42

tmp_27:                                      ; preds = %tmp_24
  %tmp_28 = load i32* %group_id, align 4
  %tmp_29 = mul i32 %tmp_28, 8
  %tmp_30 = load i32* %i, align 4
  %tmp_31 = add i32 %tmp_29, %tmp_30
  %tmp_32 = load <4 x i32> addrspace(1)** %tmp_2, align 4
  %tmp_33 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_32, i32 %tmp_31
  %tmp_34 = load <4 x i32> addrspace(1)* %tmp_33, align 16
  %tmp_35 = load i32* %i, align 4
  %tmp_36 = load <4 x i32> addrspace(3)** %tmp_3, align 4
  %tmp_37 = getelementptr inbounds <4 x i32> addrspace(3)* %tmp_36, i32 %tmp_35
  store <4 x i32> %tmp_34, <4 x i32> addrspace(3)* %tmp_37, align 16
  br label %tmp_38

tmp_38:                                      ; preds = %tmp_27
  %tmp_39 = call i32 @__get_local_size_u32(i32 0)
  %tmp_40 = load i32* %i, align 4
  %tmp_41 = add i32 %tmp_40, %tmp_39
  store i32 %tmp_41, i32* %i, align 4
  br label %tmp_24

tmp_42:                                      ; preds = %tmp_24
  call void @barrier(i32 1)
  %tmp_43 = load <4 x i32> addrspace(3)** %tmp_3, align 4
  %tmp_44 = bitcast <4 x i32> addrspace(3)* %tmp_43 to i32 addrspace(3)*
  store i32 addrspace(3)* %tmp_44, i32 addrspace(3)** %shared_scalar, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %temp, align 16
  %tmp_45 = load <4 x i32>* %vlid, align 16
  store <4 x i32> %tmp_45, <4 x i32>* %lastBit, align 16
  store i32 0, i32* %k, align 4
  br label %tmp_46

tmp_46:                                      ; preds = %tmp_63, %tmp_42
  %tmp_47 = load i32* %k, align 4
  %tmp_48 = icmp slt i32 %tmp_47, 12
  br i1 %tmp_48, label %tmp_49, label %tmp_66

tmp_49:                                      ; preds = %tmp_46
  %tmp_50 = load <4 x i32>* %lastBit, align 16
  %tmp_51 = and <4 x i32> %tmp_50, <i32 1, i32 1, i32 1, i32 1>
  %tmp_52 = load i32* %k, align 4
  %tmp_53 = load i32 addrspace(3)** %shared_scalar, align 4
  %tmp_54 = getelementptr inbounds i32 addrspace(3)* %tmp_53, i32 %tmp_52
  %tmp_55 = load i32 addrspace(3)* %tmp_54, align 4
  %tmp_56 = insertelement <4 x i32> undef, i32 %tmp_55, i32 0
  %tmp_57 = shufflevector <4 x i32> %tmp_56, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_58 = mul <4 x i32> %tmp_51, %tmp_57
  %tmp_59 = load <4 x i32>* %temp, align 16
  %tmp_60 = xor <4 x i32> %tmp_59, %tmp_58
  store <4 x i32> %tmp_60, <4 x i32>* %temp, align 16
  %tmp_61 = load <4 x i32>* %lastBit, align 16
  %tmp_62 = lshr <4 x i32> %tmp_61, <i32 1, i32 1, i32 1, i32 1>
  store <4 x i32> %tmp_62, <4 x i32>* %lastBit, align 16
  br label %tmp_63

tmp_63:                                      ; preds = %tmp_49
  %tmp_64 = load i32* %k, align 4
  %tmp_65 = add nsw i32 %tmp_64, 1
  store i32 %tmp_65, i32* %k, align 4
  br label %tmp_46

tmp_66:                                      ; preds = %tmp_46
  %tmp_67 = load <4 x i32>* %temp, align 16
  %tmp_68 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %tmp_67)
  %tmp_69 = load float* %divisor, align 4
  %tmp_70 = insertelement <4 x float> undef, float %tmp_69, i32 0
  %tmp_71 = shufflevector <4 x float> %tmp_70, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_72 = fdiv <4 x float> %tmp_68, %tmp_71, !fpmath !3
  %tmp_73 = load i32* %global_id, align 4
  %tmp_74 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_75 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_74, i32 %tmp_73
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
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32 addrspace(3)*, align 4
  %global_id = alloca i32, align 4
  %local_id = alloca i32, align 4
  %group_id = alloca i32, align 4
  %divisor = alloca float, align 4
  %i = alloca i32, align 4
  %temp = alloca i32, align 4
  %lastBit = alloca i32, align 4
  %k = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %tmp_2, align 4
  store i32 addrspace(3)* %shared, i32 addrspace(3)** %tmp_3, align 4
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_4, i32* %global_id, align 4
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_5, i32* %local_id, align 4
  %tmp_6 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_6, i32* %group_id, align 4
  %tmp_7 = call float @llvm.pow.f32(float 2.000000e+00, float 3.200000e+01)
  store float %tmp_7, float* %divisor, align 4
  %tmp_8 = load i32* %local_id, align 4
  store i32 %tmp_8, i32* %i, align 4
  br label %tmp_9

tmp_9:                                       ; preds = %tmp_23, %tmp_0
  %tmp_10 = load i32* %i, align 4
  %tmp_11 = icmp slt i32 %tmp_10, 32
  br i1 %tmp_11, label %tmp_12, label %tmp_27

tmp_12:                                      ; preds = %tmp_9
  %tmp_13 = load i32* %group_id, align 4
  %tmp_14 = mul i32 %tmp_13, 32
  %tmp_15 = load i32* %i, align 4
  %tmp_16 = add i32 %tmp_14, %tmp_15
  %tmp_17 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_18 = getelementptr inbounds i32 addrspace(1)* %tmp_17, i32 %tmp_16
  %tmp_19 = load i32 addrspace(1)* %tmp_18, align 4
  %tmp_20 = load i32* %i, align 4
  %tmp_21 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_22 = getelementptr inbounds i32 addrspace(3)* %tmp_21, i32 %tmp_20
  store i32 %tmp_19, i32 addrspace(3)* %tmp_22, align 4
  br label %tmp_23

tmp_23:                                      ; preds = %tmp_12
  %tmp_24 = call i32 @__get_local_size_u32(i32 0)
  %tmp_25 = load i32* %i, align 4
  %tmp_26 = add i32 %tmp_25, %tmp_24
  store i32 %tmp_26, i32* %i, align 4
  br label %tmp_9

tmp_27:                                      ; preds = %tmp_9
  call void @barrier(i32 1)
  store i32 0, i32* %temp, align 4
  %tmp_28 = load i32* %local_id, align 4
  store i32 %tmp_28, i32* %lastBit, align 4
  store i32 0, i32* %k, align 4
  br label %tmp_29

tmp_29:                                      ; preds = %tmp_44, %tmp_27
  %tmp_30 = load i32* %k, align 4
  %tmp_31 = icmp slt i32 %tmp_30, 10
  br i1 %tmp_31, label %tmp_32, label %tmp_47

tmp_32:                                      ; preds = %tmp_29
  %tmp_33 = load i32* %lastBit, align 4
  %tmp_34 = and i32 %tmp_33, 1
  %tmp_35 = load i32* %k, align 4
  %tmp_36 = load i32 addrspace(3)** %tmp_3, align 4
  %tmp_37 = getelementptr inbounds i32 addrspace(3)* %tmp_36, i32 %tmp_35
  %tmp_38 = load i32 addrspace(3)* %tmp_37, align 4
  %tmp_39 = mul i32 %tmp_34, %tmp_38
  %tmp_40 = load i32* %temp, align 4
  %tmp_41 = xor i32 %tmp_40, %tmp_39
  store i32 %tmp_41, i32* %temp, align 4
  %tmp_42 = load i32* %lastBit, align 4
  %tmp_43 = lshr i32 %tmp_42, 1
  store i32 %tmp_43, i32* %lastBit, align 4
  br label %tmp_44

tmp_44:                                      ; preds = %tmp_32
  %tmp_45 = load i32* %k, align 4
  %tmp_46 = add nsw i32 %tmp_45, 1
  store i32 %tmp_46, i32* %k, align 4
  br label %tmp_29

tmp_47:                                      ; preds = %tmp_29
  %tmp_48 = load i32* %temp, align 4
  %tmp_49 = call float @_Z13convert_floatj(i32 %tmp_48)
  %tmp_50 = load float* %divisor, align 4
  %tmp_51 = fdiv float %tmp_49, %tmp_50, !fpmath !3
  %tmp_52 = load i32* %global_id, align 4
  %tmp_53 = load float addrspace(1)** %tmp_1, align 4
  %tmp_54 = getelementptr inbounds float addrspace(1)* %tmp_53, i32 %tmp_52
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

; ModuleID = 'URNG_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@noise_uniform.iv = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
  %tmp_3 = call i32 @__get_local_id_u32(i32 0)
  %tmp_4 = call i32 @__get_local_id_u32(i32 1)
  %tmp_5 = call i32 @__get_local_size_u32(i32 0)
  %tmp_6 = mul i32 %tmp_4, %tmp_5
  %tmp_7 = add i32 %tmp_3, %tmp_6
  br label %tmp_8

tmp_8:                                            ; preds = %tmp_39, %0
  %j.0 = phi i32 [ 16, %0 ], [ %tmp_41, %tmp_39 ]
  %tmp_1.0 = phi i32 [ %idum, %0 ], [ %tmp_1.1, %tmp_39 ]
  %tmp_10 = icmp sge i32 %j.0, 0
  br i1 %tmp_10, label %tmp_11, label %tmp_42

tmp_11:                                           ; preds = %tmp_8
  %tmp_13 = sdiv i32 %tmp_1.0, 127773
  %tmp_16 = mul nsw i32 %tmp_13, 127773
  %tmp_17 = sub nsw i32 %tmp_1.0, %tmp_16
  %tmp_18 = mul nsw i32 16807, %tmp_17
  %tmp_20 = mul nsw i32 2836, %tmp_13
  %tmp_21 = sub nsw i32 %tmp_18, %tmp_20
  %tmp_23 = icmp slt i32 %tmp_21, 0
  br i1 %tmp_23, label %tmp_24, label %tmp_27

tmp_24:                                           ; preds = %tmp_11
  %tmp_26 = add nsw i32 %tmp_21, 2147483647
  br label %tmp_27

tmp_27:                                           ; preds = %tmp_24, %tmp_11
  %tmp_1.1 = phi i32 [ %tmp_26, %tmp_24 ], [ %tmp_21, %tmp_11 ]
  %tmp_29 = icmp slt i32 %j.0, 16
  br i1 %tmp_29, label %tmp_30, label %tmp_38

tmp_30:                                           ; preds = %tmp_27
  %tmp_33 = mul nsw i32 16, %tmp_7
  %tmp_35 = add nsw i32 %tmp_33, %j.0
  %tmp_37 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %tmp_35
  store i32 %tmp_1.1, i32 addrspace(3)* %tmp_37, align 4
  br label %tmp_38

tmp_38:                                           ; preds = %tmp_30, %tmp_27
  br label %tmp_39

tmp_39:                                           ; preds = %tmp_38
  %tmp_41 = add nsw i32 %j.0, -1
  br label %tmp_8

tmp_42:                                           ; preds = %tmp_8
  %tmp_44 = mul nsw i32 16, %tmp_7
  %tmp_46 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %tmp_44
  %tmp_47 = load i32 addrspace(3)* %tmp_46, align 4
  %tmp_49 = sdiv i32 %tmp_1.0, 127773
  %tmp_52 = mul nsw i32 %tmp_49, 127773
  %tmp_53 = sub nsw i32 %tmp_1.0, %tmp_52
  %tmp_54 = mul nsw i32 16807, %tmp_53
  %tmp_56 = mul nsw i32 2836, %tmp_49
  %tmp_57 = sub nsw i32 %tmp_54, %tmp_56
  %tmp_59 = icmp slt i32 %tmp_57, 0
  br i1 %tmp_59, label %tmp_60, label %tmp_63

tmp_60:                                           ; preds = %tmp_42
  %tmp_62 = add nsw i32 %tmp_57, 2147483647
  br label %tmp_63

tmp_63:                                           ; preds = %tmp_60, %tmp_42
  %tmp_65 = sdiv i32 %tmp_47, 134217728
  %tmp_67 = mul nsw i32 16, %tmp_7
  %tmp_69 = add nsw i32 %tmp_67, %tmp_65
  %tmp_71 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %tmp_69
  %tmp_72 = load i32 addrspace(3)* %tmp_71, align 4
  %tmp_74 = sitofp i32 %tmp_72 to float
  %tmp_75 = fmul float 0x3E00000000000000, %tmp_74
  ret float %tmp_75
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

; Function Attrs: nounwind
define void @noise_uniform(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %factor) #0 {
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = call i32 @__get_global_id_u32(i32 1)
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  %tmp_7 = mul i32 %tmp_5, %tmp_6
  %tmp_8 = add i32 %tmp_4, %tmp_7
  %tmp_11 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %tmp_8
  %tmp_12 = load <4 x i8> addrspace(1)* %tmp_11, align 4
  %tmp_13 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %tmp_12)
  %tmp_15 = extractelement <4 x float> %tmp_13, i32 0
  %tmp_17 = extractelement <4 x float> %tmp_13, i32 1
  %tmp_18 = fadd float %tmp_15, %tmp_17
  %tmp_20 = extractelement <4 x float> %tmp_13, i32 2
  %tmp_21 = fadd float %tmp_18, %tmp_20
  %tmp_23 = extractelement <4 x float> %tmp_13, i32 1
  %tmp_24 = fadd float %tmp_21, %tmp_23
  %tmp_25 = fdiv float %tmp_24, 4.000000e+00, !fpmath !2
  %tmp_27 = fsub float -0.000000e+00, %tmp_25
  %tmp_28 = fptosi float %tmp_27 to i32
  %tmp_29 = call float @ran1(i32 %tmp_28, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  %tmp_31 = fsub float %tmp_29, 0x3FE19999A0000000
  %tmp_33 = sitofp i32 %factor to float
  %tmp_34 = fmul float %tmp_31, %tmp_33
  %tmp_37 = insertelement <4 x float> undef, float %tmp_34, i32 0
  %tmp_38 = shufflevector <4 x float> %tmp_37, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_39 = fadd <4 x float> %tmp_13, %tmp_38
  %tmp_40 = call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %tmp_39)
  %tmp_43 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %tmp_8
  store <4 x i8> %tmp_40, <4 x i8> addrspace(1)* %tmp_43, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @noise_uniform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

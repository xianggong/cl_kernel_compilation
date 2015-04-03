; ModuleID = 'URNGNoiseGL_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@noise_uniform.iv = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* %iv) #0 {
  %tmp_3 = call i32 @__get_local_id_u32(i32 0)
  br label %tmp_4

tmp_4:                                            ; preds = %tmp_35, %0
  %j.0 = phi i32 [ 4, %0 ], [ %tmp_37, %tmp_35 ]
  %tmp_1.0 = phi i32 [ %idum, %0 ], [ %tmp_1.1, %tmp_35 ]
  %tmp_6 = icmp sge i32 %j.0, 0
  br i1 %tmp_6, label %tmp_7, label %tmp_38

tmp_7:                                            ; preds = %tmp_4
  %tmp_9 = sdiv i32 %tmp_1.0, 127773
  %tmp_12 = mul nsw i32 %tmp_9, 127773
  %tmp_13 = sub nsw i32 %tmp_1.0, %tmp_12
  %tmp_14 = mul nsw i32 16807, %tmp_13
  %tmp_16 = mul nsw i32 2836, %tmp_9
  %tmp_17 = sub nsw i32 %tmp_14, %tmp_16
  %tmp_19 = icmp slt i32 %tmp_17, 0
  br i1 %tmp_19, label %tmp_20, label %tmp_23

tmp_20:                                           ; preds = %tmp_7
  %tmp_22 = add nsw i32 %tmp_17, 2147483647
  br label %tmp_23

tmp_23:                                           ; preds = %tmp_20, %tmp_7
  %tmp_1.1 = phi i32 [ %tmp_22, %tmp_20 ], [ %tmp_17, %tmp_7 ]
  %tmp_25 = icmp slt i32 %j.0, 4
  br i1 %tmp_25, label %tmp_26, label %tmp_34

tmp_26:                                           ; preds = %tmp_23
  %tmp_29 = mul nsw i32 4, %tmp_3
  %tmp_31 = add nsw i32 %tmp_29, %j.0
  %tmp_33 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %tmp_31
  store i32 %tmp_1.1, i32 addrspace(3)* %tmp_33, align 4
  br label %tmp_34

tmp_34:                                           ; preds = %tmp_26, %tmp_23
  br label %tmp_35

tmp_35:                                           ; preds = %tmp_34
  %tmp_37 = add nsw i32 %j.0, -1
  br label %tmp_4

tmp_38:                                           ; preds = %tmp_4
  %tmp_40 = mul nsw i32 4, %tmp_3
  %tmp_42 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %tmp_40
  %tmp_43 = load i32 addrspace(3)* %tmp_42, align 4
  %tmp_45 = sdiv i32 %tmp_1.0, 127773
  %tmp_48 = mul nsw i32 %tmp_45, 127773
  %tmp_49 = sub nsw i32 %tmp_1.0, %tmp_48
  %tmp_50 = mul nsw i32 16807, %tmp_49
  %tmp_52 = mul nsw i32 2836, %tmp_45
  %tmp_53 = sub nsw i32 %tmp_50, %tmp_52
  %tmp_55 = icmp slt i32 %tmp_53, 0
  br i1 %tmp_55, label %tmp_56, label %tmp_59

tmp_56:                                           ; preds = %tmp_38
  %tmp_58 = add nsw i32 %tmp_53, 2147483647
  br label %tmp_59

tmp_59:                                           ; preds = %tmp_56, %tmp_38
  %tmp_61 = sdiv i32 %tmp_43, 536870912
  %tmp_63 = mul nsw i32 4, %tmp_3
  %tmp_65 = add nsw i32 %tmp_63, %tmp_61
  %tmp_67 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %tmp_65
  %tmp_68 = load i32 addrspace(3)* %tmp_67, align 4
  %tmp_70 = sitofp i32 %tmp_68 to float
  %tmp_71 = fmul float 0x3E00000000000000, %tmp_70
  ret float %tmp_71
}

declare i32 @__get_local_id_u32(i32) #1

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
  %tmp_29 = call float @ran1(i32 %tmp_28, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  %tmp_31 = fsub float %tmp_29, 5.000000e-01
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

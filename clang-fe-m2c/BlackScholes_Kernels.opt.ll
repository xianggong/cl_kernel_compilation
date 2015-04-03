; ModuleID = 'BlackScholes_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @phi(<4 x float> %X, <4 x float>* %phi) #0 {
  %tmp_4 = call <4 x float> @llvm.fabs.v4f32(<4 x float> %X)
  %tmp_9 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %tmp_4, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %tmp_10 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_9, !fpmath !3
  %tmp_14 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %X
  %tmp_16 = fmul <4 x float> %tmp_14, %X
  %tmp_18 = fdiv <4 x float> %tmp_16, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %tmp_19 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_18)
  %tmp_20 = fmul <4 x float> <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>, %tmp_19
  %tmp_22 = fmul <4 x float> %tmp_20, %tmp_10
  %tmp_32 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_10, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>)
  %tmp_33 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_10, <4 x float> %tmp_32, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>)
  %tmp_34 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_10, <4 x float> %tmp_33, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>)
  %tmp_35 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_10, <4 x float> %tmp_34, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>)
  %tmp_36 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_22
  %tmp_37 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_36, <4 x float> %tmp_35, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %tmp_40 = fcmp olt <4 x float> %X, zeroinitializer
  %tmp_41 = sext <4 x i1> %tmp_40 to <4 x i32>
  %tmp_44 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_37
  %tmp_46 = icmp slt <4 x i32> %tmp_41, zeroinitializer
  %tmp_47 = sext <4 x i1> %tmp_46 to <4 x i32>
  %tmp_48 = xor <4 x i32> %tmp_47, <i32 -1, i32 -1, i32 -1, i32 -1>
  %tmp_49 = bitcast <4 x float> %tmp_37 to <4 x i32>
  %tmp_50 = bitcast <4 x float> %tmp_44 to <4 x i32>
  %tmp_51 = and <4 x i32> %tmp_49, %tmp_48
  %tmp_52 = and <4 x i32> %tmp_50, %tmp_47
  %tmp_53 = or <4 x i32> %tmp_51, %tmp_52
  %tmp_54 = bitcast <4 x i32> %tmp_53 to <4 x float>
  store <4 x float> %tmp_54, <4 x float>* %phi, align 16
  ret void
}

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.fabs.v4f32(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare <4 x float> @_Z3expDv4_f(<4 x float>) #3

; Function Attrs: nounwind
define void @blackScholes(<4 x float> addrspace(1)* %randArray, i32 %width, <4 x float> addrspace(1)* %call, <4 x float> addrspace(1)* %put) #0 {
  %phiD1 = alloca <4 x float>, align 16
  %phiD2 = alloca <4 x float>, align 16
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_id_u32(i32 1)
  %tmp_9 = mul i32 %tmp_6, %width
  %tmp_11 = add i32 %tmp_9, %tmp_5
  %tmp_13 = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i32 %tmp_11
  %tmp_14 = load <4 x float> addrspace(1)* %tmp_13, align 16
  %tmp_17 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_14
  %tmp_18 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %tmp_17
  %tmp_19 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %tmp_14, <4 x float> %tmp_18)
  %tmp_22 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_14
  %tmp_23 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %tmp_22
  %tmp_24 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %tmp_14, <4 x float> %tmp_23)
  %tmp_27 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_14
  %tmp_28 = fmul <4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, %tmp_27
  %tmp_29 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %tmp_14, <4 x float> %tmp_28)
  %tmp_32 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_14
  %tmp_33 = fmul <4 x float> <float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000>, %tmp_32
  %tmp_34 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %tmp_14, <4 x float> %tmp_33)
  %tmp_37 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_14
  %tmp_38 = fmul <4 x float> <float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000>, %tmp_37
  %tmp_39 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %tmp_14, <4 x float> %tmp_38)
  %tmp_42 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %tmp_29)
  %tmp_43 = fmul <4 x float> %tmp_39, %tmp_42
  %tmp_46 = fdiv <4 x float> %tmp_19, %tmp_24, !fpmath !3
  %tmp_47 = call <4 x float> @llvm.log2.v4f32(<4 x float> %tmp_46)
  %tmp_51 = fmul <4 x float> %tmp_39, %tmp_39
  %tmp_53 = fdiv <4 x float> %tmp_51, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %tmp_54 = fadd <4 x float> %tmp_34, %tmp_53
  %tmp_56 = fmul <4 x float> %tmp_54, %tmp_29
  %tmp_57 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_47, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %tmp_56)
  %tmp_59 = fdiv <4 x float> %tmp_57, %tmp_43, !fpmath !3
  %tmp_62 = fsub <4 x float> %tmp_59, %tmp_43
  %tmp_65 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_34
  %tmp_67 = fmul <4 x float> %tmp_65, %tmp_29
  %tmp_68 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_67)
  %tmp_69 = fmul <4 x float> %tmp_24, %tmp_68
  call void @phi(<4 x float> %tmp_59, <4 x float>* %phiD1)
  call void @phi(<4 x float> %tmp_62, <4 x float>* %phiD2)
  %tmp_73 = load <4 x float>* %phiD1, align 16
  %tmp_75 = load <4 x float>* %phiD2, align 16
  %tmp_76 = fmul <4 x float> %tmp_69, %tmp_75
  %tmp_77 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_76
  %tmp_78 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_19, <4 x float> %tmp_73, <4 x float> %tmp_77)
  %tmp_81 = mul i32 %tmp_6, %width
  %tmp_83 = add i32 %tmp_81, %tmp_5
  %tmp_85 = getelementptr inbounds <4 x float> addrspace(1)* %call, i32 %tmp_83
  store <4 x float> %tmp_78, <4 x float> addrspace(1)* %tmp_85, align 16
  %tmp_87 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_59
  call void @phi(<4 x float> %tmp_87, <4 x float>* %phiD1)
  %tmp_89 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_62
  call void @phi(<4 x float> %tmp_89, <4 x float>* %phiD2)
  %tmp_91 = load <4 x float>* %phiD2, align 16
  %tmp_93 = load <4 x float>* %phiD1, align 16
  %tmp_94 = fmul <4 x float> %tmp_19, %tmp_93
  %tmp_95 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_94
  %tmp_96 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_69, <4 x float> %tmp_91, <4 x float> %tmp_95)
  %tmp_99 = mul i32 %tmp_6, %width
  %tmp_101 = add i32 %tmp_99, %tmp_5
  %tmp_103 = getelementptr inbounds <4 x float> addrspace(1)* %put, i32 %tmp_101
  store <4 x float> %tmp_96, <4 x float> addrspace(1)* %tmp_103, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #3

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #1

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #1

; Function Attrs: nounwind
define void @phi_scalar(float %X, float* %phi) #0 {
  %tmp_4 = call float @llvm.fabs.f32(float %X)
  %tmp_6 = call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %tmp_4, float 1.000000e+00)
  %tmp_7 = fdiv float 1.000000e+00, %tmp_6, !fpmath !3
  %tmp_9 = fsub float -0.000000e+00, %X
  %tmp_11 = fmul float %tmp_9, %X
  %tmp_12 = fdiv float %tmp_11, 2.000000e+00, !fpmath !3
  %tmp_13 = call float @_Z3expf(float %tmp_12)
  %tmp_14 = fmul float 0x3FD9884540000000, %tmp_13
  %tmp_16 = fmul float %tmp_14, %tmp_7
  %tmp_21 = call float @llvm.fmuladd.f32(float %tmp_7, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000)
  %tmp_22 = call float @llvm.fmuladd.f32(float %tmp_7, float %tmp_21, float 0x3FFC80EF00000000)
  %tmp_23 = call float @llvm.fmuladd.f32(float %tmp_7, float %tmp_22, float 0xBFD6D1F0E0000000)
  %tmp_24 = call float @llvm.fmuladd.f32(float %tmp_7, float %tmp_23, float 0x3FD470BF40000000)
  %tmp_25 = fsub float -0.000000e+00, %tmp_16
  %tmp_26 = call float @llvm.fmuladd.f32(float %tmp_25, float %tmp_24, float 1.000000e+00)
  %tmp_28 = fcmp olt float %X, 0.000000e+00
  br i1 %tmp_28, label %tmp_29, label %tmp_32

tmp_29:                                           ; preds = %0
  %tmp_31 = fsub float 1.000000e+00, %tmp_26
  br label %tmp_34

tmp_32:                                           ; preds = %0
  br label %tmp_34

tmp_34:                                           ; preds = %tmp_32, %tmp_29
  %tmp_35 = phi float [ %tmp_31, %tmp_29 ], [ %tmp_26, %tmp_32 ]
  store float %tmp_35, float* %phi, align 4
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.fabs.f32(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3expf(float) #3

; Function Attrs: nounwind
define void @blackScholes_scalar(float addrspace(1)* %randArray, i32 %width, float addrspace(1)* %call, float addrspace(1)* %put) #0 {
  %phiD1 = alloca float, align 4
  %phiD2 = alloca float, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = call i32 @__get_global_id_u32(i32 1)
  %tmp_9 = mul i32 %tmp_6, %width
  %tmp_11 = add i32 %tmp_9, %tmp_5
  %tmp_13 = getelementptr inbounds float addrspace(1)* %randArray, i32 %tmp_11
  %tmp_14 = load float addrspace(1)* %tmp_13, align 4
  %tmp_17 = fsub float 1.000000e+00, %tmp_14
  %tmp_18 = fmul float 1.000000e+02, %tmp_17
  %tmp_19 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %tmp_14, float %tmp_18)
  %tmp_22 = fsub float 1.000000e+00, %tmp_14
  %tmp_23 = fmul float 1.000000e+02, %tmp_22
  %tmp_24 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %tmp_14, float %tmp_23)
  %tmp_27 = fsub float 1.000000e+00, %tmp_14
  %tmp_28 = fmul float 1.000000e+01, %tmp_27
  %tmp_29 = call float @llvm.fmuladd.f32(float 1.000000e+00, float %tmp_14, float %tmp_28)
  %tmp_32 = fsub float 1.000000e+00, %tmp_14
  %tmp_33 = fmul float 0x3FA99999A0000000, %tmp_32
  %tmp_34 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %tmp_14, float %tmp_33)
  %tmp_37 = fsub float 1.000000e+00, %tmp_14
  %tmp_38 = fmul float 0x3FB99999A0000000, %tmp_37
  %tmp_39 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %tmp_14, float %tmp_38)
  %tmp_42 = call float @llvm.sqrt.f32(float %tmp_29)
  %tmp_43 = fmul float %tmp_39, %tmp_42
  %tmp_46 = fdiv float %tmp_19, %tmp_24, !fpmath !3
  %tmp_47 = call float @llvm.log2.f32(float %tmp_46)
  %tmp_51 = fmul float %tmp_39, %tmp_39
  %tmp_53 = fdiv float %tmp_51, 2.000000e+00, !fpmath !3
  %tmp_54 = fadd float %tmp_34, %tmp_53
  %tmp_56 = fmul float %tmp_54, %tmp_29
  %tmp_57 = call float @llvm.fmuladd.f32(float %tmp_47, float 0x3FE62E4300000000, float %tmp_56)
  %tmp_59 = fdiv float %tmp_57, %tmp_43, !fpmath !3
  %tmp_62 = fsub float %tmp_59, %tmp_43
  %tmp_65 = fsub float -0.000000e+00, %tmp_34
  %tmp_67 = fmul float %tmp_65, %tmp_29
  %tmp_68 = call float @_Z3expf(float %tmp_67)
  %tmp_69 = fmul float %tmp_24, %tmp_68
  call void @phi_scalar(float %tmp_59, float* %phiD1)
  call void @phi_scalar(float %tmp_62, float* %phiD2)
  %tmp_73 = load float* %phiD1, align 4
  %tmp_75 = load float* %phiD2, align 4
  %tmp_76 = fmul float %tmp_69, %tmp_75
  %tmp_77 = fsub float -0.000000e+00, %tmp_76
  %tmp_78 = call float @llvm.fmuladd.f32(float %tmp_19, float %tmp_73, float %tmp_77)
  %tmp_81 = mul i32 %tmp_6, %width
  %tmp_83 = add i32 %tmp_81, %tmp_5
  %tmp_85 = getelementptr inbounds float addrspace(1)* %call, i32 %tmp_83
  store float %tmp_78, float addrspace(1)* %tmp_85, align 4
  %tmp_87 = fsub float -0.000000e+00, %tmp_59
  call void @phi_scalar(float %tmp_87, float* %phiD1)
  %tmp_89 = fsub float -0.000000e+00, %tmp_62
  call void @phi_scalar(float %tmp_89, float* %phiD2)
  %tmp_91 = load float* %phiD2, align 4
  %tmp_93 = load float* %phiD1, align 4
  %tmp_94 = fmul float %tmp_19, %tmp_93
  %tmp_95 = fsub float -0.000000e+00, %tmp_94
  %tmp_96 = call float @llvm.fmuladd.f32(float %tmp_69, float %tmp_91, float %tmp_95)
  %tmp_99 = mul i32 %tmp_6, %width
  %tmp_101 = add i32 %tmp_99, %tmp_5
  %tmp_103 = getelementptr inbounds float addrspace(1)* %put, i32 %tmp_101
  store float %tmp_96, float addrspace(1)* %tmp_103, align 4
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #1

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @blackScholes}
!1 = metadata !{void (float addrspace(1)*, i32, float addrspace(1)*, float addrspace(1)*)* @blackScholes_scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{float 2.500000e+00}

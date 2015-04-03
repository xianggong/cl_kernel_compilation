; ModuleID = '../kernel-src/BlackScholes_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @phi(<4 x float> %X, <4 x float>* %phi) #0 {
  %tmp_1 = alloca <4 x float>, align 16
  %tmp_2 = alloca <4 x float>*, align 4
  %y = alloca <4 x float>, align 16
  %absX = alloca <4 x float>, align 16
  %t = alloca <4 x float>, align 16
  %result = alloca <4 x float>, align 16
  %c1 = alloca <4 x float>, align 16
  %c2 = alloca <4 x float>, align 16
  %c3 = alloca <4 x float>, align 16
  %c4 = alloca <4 x float>, align 16
  %c5 = alloca <4 x float>, align 16
  %zero = alloca <4 x float>, align 16
  %one = alloca <4 x float>, align 16
  %two = alloca <4 x float>, align 16
  %temp4 = alloca <4 x float>, align 16
  %oneBySqrt2pi = alloca <4 x float>, align 16
  store <4 x float> %X, <4 x float>* %tmp_1, align 16
  store <4 x float>* %phi, <4 x float>** %tmp_2, align 4
  store <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>, <4 x float>* %c1, align 16
  store <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>, <4 x float>* %c2, align 16
  store <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>, <4 x float>* %c3, align 16
  store <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>, <4 x float>* %c4, align 16
  store <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float>* %c5, align 16
  store <4 x float> zeroinitializer, <4 x float>* %zero, align 16
  store <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float>* %one, align 16
  store <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float>* %two, align 16
  store <4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float>* %temp4, align 16
  store <4 x float> <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>, <4 x float>* %oneBySqrt2pi, align 16
  %tmp_3 = load <4 x float>* %tmp_1, align 16
  %tmp_4 = call <4 x float> @llvm.fabs.v4f32(<4 x float> %tmp_3)
  store <4 x float> %tmp_4, <4 x float>* %absX, align 16
  %tmp_5 = load <4 x float>* %one, align 16
  %tmp_6 = load <4 x float>* %one, align 16
  %tmp_7 = load <4 x float>* %temp4, align 16
  %tmp_8 = load <4 x float>* %absX, align 16
  %tmp_9 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_7, <4 x float> %tmp_8, <4 x float> %tmp_6)
  %tmp_10 = fdiv <4 x float> %tmp_5, %tmp_9, !fpmath !3
  store <4 x float> %tmp_10, <4 x float>* %t, align 16
  %tmp_11 = load <4 x float>* %one, align 16
  %tmp_12 = load <4 x float>* %oneBySqrt2pi, align 16
  %tmp_13 = load <4 x float>* %tmp_1, align 16
  %tmp_14 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_13
  %tmp_15 = load <4 x float>* %tmp_1, align 16
  %tmp_16 = fmul <4 x float> %tmp_14, %tmp_15
  %tmp_17 = load <4 x float>* %two, align 16
  %tmp_18 = fdiv <4 x float> %tmp_16, %tmp_17, !fpmath !3
  %tmp_19 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_18)
  %tmp_20 = fmul <4 x float> %tmp_12, %tmp_19
  %tmp_21 = load <4 x float>* %t, align 16
  %tmp_22 = fmul <4 x float> %tmp_20, %tmp_21
  %tmp_23 = load <4 x float>* %c1, align 16
  %tmp_24 = load <4 x float>* %t, align 16
  %tmp_25 = load <4 x float>* %c2, align 16
  %tmp_26 = load <4 x float>* %t, align 16
  %tmp_27 = load <4 x float>* %c3, align 16
  %tmp_28 = load <4 x float>* %t, align 16
  %tmp_29 = load <4 x float>* %c4, align 16
  %tmp_30 = load <4 x float>* %t, align 16
  %tmp_31 = load <4 x float>* %c5, align 16
  %tmp_32 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_30, <4 x float> %tmp_31, <4 x float> %tmp_29)
  %tmp_33 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_28, <4 x float> %tmp_32, <4 x float> %tmp_27)
  %tmp_34 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_26, <4 x float> %tmp_33, <4 x float> %tmp_25)
  %tmp_35 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_24, <4 x float> %tmp_34, <4 x float> %tmp_23)
  %tmp_36 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_22
  %tmp_37 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_36, <4 x float> %tmp_35, <4 x float> %tmp_11)
  store <4 x float> %tmp_37, <4 x float>* %y, align 16
  %tmp_38 = load <4 x float>* %tmp_1, align 16
  %tmp_39 = load <4 x float>* %zero, align 16
  %tmp_40 = fcmp olt <4 x float> %tmp_38, %tmp_39
  %tmp_41 = sext <4 x i1> %tmp_40 to <4 x i32>
  %tmp_42 = load <4 x float>* %one, align 16
  %tmp_43 = load <4 x float>* %y, align 16
  %tmp_44 = fsub <4 x float> %tmp_42, %tmp_43
  %tmp_45 = load <4 x float>* %y, align 16
  %tmp_46 = icmp slt <4 x i32> %tmp_41, zeroinitializer
  %tmp_47 = sext <4 x i1> %tmp_46 to <4 x i32>
  %tmp_48 = xor <4 x i32> %tmp_47, <i32 -1, i32 -1, i32 -1, i32 -1>
  %tmp_49 = bitcast <4 x float> %tmp_45 to <4 x i32>
  %tmp_50 = bitcast <4 x float> %tmp_44 to <4 x i32>
  %tmp_51 = and <4 x i32> %tmp_49, %tmp_48
  %tmp_52 = and <4 x i32> %tmp_50, %tmp_47
  %tmp_53 = or <4 x i32> %tmp_51, %tmp_52
  %tmp_54 = bitcast <4 x i32> %tmp_53 to <4 x float>
  store <4 x float> %tmp_54, <4 x float>* %result, align 16
  %tmp_55 = load <4 x float>* %result, align 16
  %tmp_56 = load <4 x float>** %tmp_2, align 4
  store <4 x float> %tmp_55, <4 x float>* %tmp_56, align 16
  ret void
}

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.fabs.v4f32(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare <4 x float> @_Z3expDv4_f(<4 x float>) #3

; Function Attrs: nounwind
define void @blackScholes(<4 x float> addrspace(1)* %randArray, i32 %width, <4 x float> addrspace(1)* %call, <4 x float> addrspace(1)* %put) #0 {
  %tmp_1 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_2 = alloca i32, align 4
  %tmp_3 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_4 = alloca <4 x float> addrspace(1)*, align 4
  %d1 = alloca <4 x float>, align 16
  %d2 = alloca <4 x float>, align 16
  %phiD1 = alloca <4 x float>, align 16
  %phiD2 = alloca <4 x float>, align 16
  %sigmaSqrtT = alloca <4 x float>, align 16
  %KexpMinusRT = alloca <4 x float>, align 16
  %xPos = alloca i32, align 4
  %yPos = alloca i32, align 4
  %two = alloca <4 x float>, align 16
  %inRand = alloca <4 x float>, align 16
  %S = alloca <4 x float>, align 16
  %K = alloca <4 x float>, align 16
  %T = alloca <4 x float>, align 16
  %R = alloca <4 x float>, align 16
  %sigmaVal = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %randArray, <4 x float> addrspace(1)** %tmp_1, align 4
  store i32 %width, i32* %tmp_2, align 4
  store <4 x float> addrspace(1)* %call, <4 x float> addrspace(1)** %tmp_3, align 4
  store <4 x float> addrspace(1)* %put, <4 x float> addrspace(1)** %tmp_4, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_5, i32* %xPos, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_6, i32* %yPos, align 4
  store <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float>* %two, align 16
  %tmp_7 = load i32* %yPos, align 4
  %tmp_8 = load i32* %tmp_2, align 4
  %tmp_9 = mul i32 %tmp_7, %tmp_8
  %tmp_10 = load i32* %xPos, align 4
  %tmp_11 = add i32 %tmp_9, %tmp_10
  %tmp_12 = load <4 x float> addrspace(1)** %tmp_1, align 4
  %tmp_13 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_12, i32 %tmp_11
  %tmp_14 = load <4 x float> addrspace(1)* %tmp_13, align 16
  store <4 x float> %tmp_14, <4 x float>* %inRand, align 16
  %tmp_15 = load <4 x float>* %inRand, align 16
  %tmp_16 = load <4 x float>* %inRand, align 16
  %tmp_17 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_16
  %tmp_18 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %tmp_17
  %tmp_19 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %tmp_15, <4 x float> %tmp_18)
  store <4 x float> %tmp_19, <4 x float>* %S, align 16
  %tmp_20 = load <4 x float>* %inRand, align 16
  %tmp_21 = load <4 x float>* %inRand, align 16
  %tmp_22 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_21
  %tmp_23 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %tmp_22
  %tmp_24 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %tmp_20, <4 x float> %tmp_23)
  store <4 x float> %tmp_24, <4 x float>* %K, align 16
  %tmp_25 = load <4 x float>* %inRand, align 16
  %tmp_26 = load <4 x float>* %inRand, align 16
  %tmp_27 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_26
  %tmp_28 = fmul <4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, %tmp_27
  %tmp_29 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %tmp_25, <4 x float> %tmp_28)
  store <4 x float> %tmp_29, <4 x float>* %T, align 16
  %tmp_30 = load <4 x float>* %inRand, align 16
  %tmp_31 = load <4 x float>* %inRand, align 16
  %tmp_32 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_31
  %tmp_33 = fmul <4 x float> <float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000>, %tmp_32
  %tmp_34 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %tmp_30, <4 x float> %tmp_33)
  store <4 x float> %tmp_34, <4 x float>* %R, align 16
  %tmp_35 = load <4 x float>* %inRand, align 16
  %tmp_36 = load <4 x float>* %inRand, align 16
  %tmp_37 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %tmp_36
  %tmp_38 = fmul <4 x float> <float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000>, %tmp_37
  %tmp_39 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %tmp_35, <4 x float> %tmp_38)
  store <4 x float> %tmp_39, <4 x float>* %sigmaVal, align 16
  %tmp_40 = load <4 x float>* %sigmaVal, align 16
  %tmp_41 = load <4 x float>* %T, align 16
  %tmp_42 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %tmp_41)
  %tmp_43 = fmul <4 x float> %tmp_40, %tmp_42
  store <4 x float> %tmp_43, <4 x float>* %sigmaSqrtT, align 16
  %tmp_44 = load <4 x float>* %S, align 16
  %tmp_45 = load <4 x float>* %K, align 16
  %tmp_46 = fdiv <4 x float> %tmp_44, %tmp_45, !fpmath !3
  %tmp_47 = call <4 x float> @llvm.log2.v4f32(<4 x float> %tmp_46)
  %tmp_48 = load <4 x float>* %R, align 16
  %tmp_49 = load <4 x float>* %sigmaVal, align 16
  %tmp_50 = load <4 x float>* %sigmaVal, align 16
  %tmp_51 = fmul <4 x float> %tmp_49, %tmp_50
  %tmp_52 = load <4 x float>* %two, align 16
  %tmp_53 = fdiv <4 x float> %tmp_51, %tmp_52, !fpmath !3
  %tmp_54 = fadd <4 x float> %tmp_48, %tmp_53
  %tmp_55 = load <4 x float>* %T, align 16
  %tmp_56 = fmul <4 x float> %tmp_54, %tmp_55
  %tmp_57 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_47, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %tmp_56)
  %tmp_58 = load <4 x float>* %sigmaSqrtT, align 16
  %tmp_59 = fdiv <4 x float> %tmp_57, %tmp_58, !fpmath !3
  store <4 x float> %tmp_59, <4 x float>* %d1, align 16
  %tmp_60 = load <4 x float>* %d1, align 16
  %tmp_61 = load <4 x float>* %sigmaSqrtT, align 16
  %tmp_62 = fsub <4 x float> %tmp_60, %tmp_61
  store <4 x float> %tmp_62, <4 x float>* %d2, align 16
  %tmp_63 = load <4 x float>* %K, align 16
  %tmp_64 = load <4 x float>* %R, align 16
  %tmp_65 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_64
  %tmp_66 = load <4 x float>* %T, align 16
  %tmp_67 = fmul <4 x float> %tmp_65, %tmp_66
  %tmp_68 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_67)
  %tmp_69 = fmul <4 x float> %tmp_63, %tmp_68
  store <4 x float> %tmp_69, <4 x float>* %KexpMinusRT, align 16
  %tmp_70 = load <4 x float>* %d1, align 16
  call void @phi(<4 x float> %tmp_70, <4 x float>* %phiD1)
  %tmp_71 = load <4 x float>* %d2, align 16
  call void @phi(<4 x float> %tmp_71, <4 x float>* %phiD2)
  %tmp_72 = load <4 x float>* %S, align 16
  %tmp_73 = load <4 x float>* %phiD1, align 16
  %tmp_74 = load <4 x float>* %KexpMinusRT, align 16
  %tmp_75 = load <4 x float>* %phiD2, align 16
  %tmp_76 = fmul <4 x float> %tmp_74, %tmp_75
  %tmp_77 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_76
  %tmp_78 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_72, <4 x float> %tmp_73, <4 x float> %tmp_77)
  %tmp_79 = load i32* %yPos, align 4
  %tmp_80 = load i32* %tmp_2, align 4
  %tmp_81 = mul i32 %tmp_79, %tmp_80
  %tmp_82 = load i32* %xPos, align 4
  %tmp_83 = add i32 %tmp_81, %tmp_82
  %tmp_84 = load <4 x float> addrspace(1)** %tmp_3, align 4
  %tmp_85 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_84, i32 %tmp_83
  store <4 x float> %tmp_78, <4 x float> addrspace(1)* %tmp_85, align 16
  %tmp_86 = load <4 x float>* %d1, align 16
  %tmp_87 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_86
  call void @phi(<4 x float> %tmp_87, <4 x float>* %phiD1)
  %tmp_88 = load <4 x float>* %d2, align 16
  %tmp_89 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_88
  call void @phi(<4 x float> %tmp_89, <4 x float>* %phiD2)
  %tmp_90 = load <4 x float>* %KexpMinusRT, align 16
  %tmp_91 = load <4 x float>* %phiD2, align 16
  %tmp_92 = load <4 x float>* %S, align 16
  %tmp_93 = load <4 x float>* %phiD1, align 16
  %tmp_94 = fmul <4 x float> %tmp_92, %tmp_93
  %tmp_95 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_94
  %tmp_96 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_90, <4 x float> %tmp_91, <4 x float> %tmp_95)
  %tmp_97 = load i32* %yPos, align 4
  %tmp_98 = load i32* %tmp_2, align 4
  %tmp_99 = mul i32 %tmp_97, %tmp_98
  %tmp_100 = load i32* %xPos, align 4
  %tmp_101 = add i32 %tmp_99, %tmp_100
  %tmp_102 = load <4 x float> addrspace(1)** %tmp_4, align 4
  %tmp_103 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_102, i32 %tmp_101
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
  %tmp_1 = alloca float, align 4
  %tmp_2 = alloca float*, align 4
  %y = alloca float, align 4
  %absX = alloca float, align 4
  %t = alloca float, align 4
  %result = alloca float, align 4
  %c1 = alloca float, align 4
  %c2 = alloca float, align 4
  %c3 = alloca float, align 4
  %c4 = alloca float, align 4
  %c5 = alloca float, align 4
  %zero = alloca float, align 4
  %one = alloca float, align 4
  %two = alloca float, align 4
  %temp4 = alloca float, align 4
  %oneBySqrt2pi = alloca float, align 4
  store float %X, float* %tmp_1, align 4
  store float* %phi, float** %tmp_2, align 4
  store float 0x3FD470BF40000000, float* %c1, align 4
  store float 0xBFD6D1F0E0000000, float* %c2, align 4
  store float 0x3FFC80EF00000000, float* %c3, align 4
  store float 0xBFFD23DD40000000, float* %c4, align 4
  store float 0x3FF548CDE0000000, float* %c5, align 4
  store float 0.000000e+00, float* %zero, align 4
  store float 1.000000e+00, float* %one, align 4
  store float 2.000000e+00, float* %two, align 4
  store float 0x3FCDA67120000000, float* %temp4, align 4
  store float 0x3FD9884540000000, float* %oneBySqrt2pi, align 4
  %tmp_3 = load float* %tmp_1, align 4
  %tmp_4 = call float @llvm.fabs.f32(float %tmp_3)
  store float %tmp_4, float* %absX, align 4
  %tmp_5 = load float* %absX, align 4
  %tmp_6 = call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %tmp_5, float 1.000000e+00)
  %tmp_7 = fdiv float 1.000000e+00, %tmp_6, !fpmath !3
  store float %tmp_7, float* %t, align 4
  %tmp_8 = load float* %tmp_1, align 4
  %tmp_9 = fsub float -0.000000e+00, %tmp_8
  %tmp_10 = load float* %tmp_1, align 4
  %tmp_11 = fmul float %tmp_9, %tmp_10
  %tmp_12 = fdiv float %tmp_11, 2.000000e+00, !fpmath !3
  %tmp_13 = call float @_Z3expf(float %tmp_12)
  %tmp_14 = fmul float 0x3FD9884540000000, %tmp_13
  %tmp_15 = load float* %t, align 4
  %tmp_16 = fmul float %tmp_14, %tmp_15
  %tmp_17 = load float* %t, align 4
  %tmp_18 = load float* %t, align 4
  %tmp_19 = load float* %t, align 4
  %tmp_20 = load float* %t, align 4
  %tmp_21 = call float @llvm.fmuladd.f32(float %tmp_20, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000)
  %tmp_22 = call float @llvm.fmuladd.f32(float %tmp_19, float %tmp_21, float 0x3FFC80EF00000000)
  %tmp_23 = call float @llvm.fmuladd.f32(float %tmp_18, float %tmp_22, float 0xBFD6D1F0E0000000)
  %tmp_24 = call float @llvm.fmuladd.f32(float %tmp_17, float %tmp_23, float 0x3FD470BF40000000)
  %tmp_25 = fsub float -0.000000e+00, %tmp_16
  %tmp_26 = call float @llvm.fmuladd.f32(float %tmp_25, float %tmp_24, float 1.000000e+00)
  store float %tmp_26, float* %y, align 4
  %tmp_27 = load float* %tmp_1, align 4
  %tmp_28 = fcmp olt float %tmp_27, 0.000000e+00
  br i1 %tmp_28, label %tmp_29, label %tmp_32

tmp_29:                                      ; preds = %tmp_0
  %tmp_30 = load float* %y, align 4
  %tmp_31 = fsub float 1.000000e+00, %tmp_30
  br label %tmp_34

tmp_32:                                      ; preds = %tmp_0
  %tmp_33 = load float* %y, align 4
  br label %tmp_34

tmp_34:                                      ; preds = %tmp_32, %tmp_29
  %tmp_35 = phi float [ %tmp_31, %tmp_29 ], [ %tmp_33, %tmp_32 ]
  store float %tmp_35, float* %result, align 4
  %tmp_36 = load float* %result, align 4
  %tmp_37 = load float** %tmp_2, align 4
  store float %tmp_36, float* %tmp_37, align 4
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.fabs.f32(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3expf(float) #3

; Function Attrs: nounwind
define void @blackScholes_scalar(float addrspace(1)* %randArray, i32 %width, float addrspace(1)* %call, float addrspace(1)* %put) #0 {
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca i32, align 4
  %tmp_3 = alloca float addrspace(1)*, align 4
  %tmp_4 = alloca float addrspace(1)*, align 4
  %d1 = alloca float, align 4
  %d2 = alloca float, align 4
  %phiD1 = alloca float, align 4
  %phiD2 = alloca float, align 4
  %sigmaSqrtT = alloca float, align 4
  %KexpMinusRT = alloca float, align 4
  %xPos = alloca i32, align 4
  %yPos = alloca i32, align 4
  %two = alloca float, align 4
  %inRand = alloca float, align 4
  %S = alloca float, align 4
  %K = alloca float, align 4
  %T = alloca float, align 4
  %R = alloca float, align 4
  %sigmaVal = alloca float, align 4
  store float addrspace(1)* %randArray, float addrspace(1)** %tmp_1, align 4
  store i32 %width, i32* %tmp_2, align 4
  store float addrspace(1)* %call, float addrspace(1)** %tmp_3, align 4
  store float addrspace(1)* %put, float addrspace(1)** %tmp_4, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_5, i32* %xPos, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_6, i32* %yPos, align 4
  store float 2.000000e+00, float* %two, align 4
  %tmp_7 = load i32* %yPos, align 4
  %tmp_8 = load i32* %tmp_2, align 4
  %tmp_9 = mul i32 %tmp_7, %tmp_8
  %tmp_10 = load i32* %xPos, align 4
  %tmp_11 = add i32 %tmp_9, %tmp_10
  %tmp_12 = load float addrspace(1)** %tmp_1, align 4
  %tmp_13 = getelementptr inbounds float addrspace(1)* %tmp_12, i32 %tmp_11
  %tmp_14 = load float addrspace(1)* %tmp_13, align 4
  store float %tmp_14, float* %inRand, align 4
  %tmp_15 = load float* %inRand, align 4
  %tmp_16 = load float* %inRand, align 4
  %tmp_17 = fsub float 1.000000e+00, %tmp_16
  %tmp_18 = fmul float 1.000000e+02, %tmp_17
  %tmp_19 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %tmp_15, float %tmp_18)
  store float %tmp_19, float* %S, align 4
  %tmp_20 = load float* %inRand, align 4
  %tmp_21 = load float* %inRand, align 4
  %tmp_22 = fsub float 1.000000e+00, %tmp_21
  %tmp_23 = fmul float 1.000000e+02, %tmp_22
  %tmp_24 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %tmp_20, float %tmp_23)
  store float %tmp_24, float* %K, align 4
  %tmp_25 = load float* %inRand, align 4
  %tmp_26 = load float* %inRand, align 4
  %tmp_27 = fsub float 1.000000e+00, %tmp_26
  %tmp_28 = fmul float 1.000000e+01, %tmp_27
  %tmp_29 = call float @llvm.fmuladd.f32(float 1.000000e+00, float %tmp_25, float %tmp_28)
  store float %tmp_29, float* %T, align 4
  %tmp_30 = load float* %inRand, align 4
  %tmp_31 = load float* %inRand, align 4
  %tmp_32 = fsub float 1.000000e+00, %tmp_31
  %tmp_33 = fmul float 0x3FA99999A0000000, %tmp_32
  %tmp_34 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %tmp_30, float %tmp_33)
  store float %tmp_34, float* %R, align 4
  %tmp_35 = load float* %inRand, align 4
  %tmp_36 = load float* %inRand, align 4
  %tmp_37 = fsub float 1.000000e+00, %tmp_36
  %tmp_38 = fmul float 0x3FB99999A0000000, %tmp_37
  %tmp_39 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %tmp_35, float %tmp_38)
  store float %tmp_39, float* %sigmaVal, align 4
  %tmp_40 = load float* %sigmaVal, align 4
  %tmp_41 = load float* %T, align 4
  %tmp_42 = call float @llvm.sqrt.f32(float %tmp_41)
  %tmp_43 = fmul float %tmp_40, %tmp_42
  store float %tmp_43, float* %sigmaSqrtT, align 4
  %tmp_44 = load float* %S, align 4
  %tmp_45 = load float* %K, align 4
  %tmp_46 = fdiv float %tmp_44, %tmp_45, !fpmath !3
  %tmp_47 = call float @llvm.log2.f32(float %tmp_46)
  %tmp_48 = load float* %R, align 4
  %tmp_49 = load float* %sigmaVal, align 4
  %tmp_50 = load float* %sigmaVal, align 4
  %tmp_51 = fmul float %tmp_49, %tmp_50
  %tmp_52 = load float* %two, align 4
  %tmp_53 = fdiv float %tmp_51, %tmp_52, !fpmath !3
  %tmp_54 = fadd float %tmp_48, %tmp_53
  %tmp_55 = load float* %T, align 4
  %tmp_56 = fmul float %tmp_54, %tmp_55
  %tmp_57 = call float @llvm.fmuladd.f32(float %tmp_47, float 0x3FE62E4300000000, float %tmp_56)
  %tmp_58 = load float* %sigmaSqrtT, align 4
  %tmp_59 = fdiv float %tmp_57, %tmp_58, !fpmath !3
  store float %tmp_59, float* %d1, align 4
  %tmp_60 = load float* %d1, align 4
  %tmp_61 = load float* %sigmaSqrtT, align 4
  %tmp_62 = fsub float %tmp_60, %tmp_61
  store float %tmp_62, float* %d2, align 4
  %tmp_63 = load float* %K, align 4
  %tmp_64 = load float* %R, align 4
  %tmp_65 = fsub float -0.000000e+00, %tmp_64
  %tmp_66 = load float* %T, align 4
  %tmp_67 = fmul float %tmp_65, %tmp_66
  %tmp_68 = call float @_Z3expf(float %tmp_67)
  %tmp_69 = fmul float %tmp_63, %tmp_68
  store float %tmp_69, float* %KexpMinusRT, align 4
  %tmp_70 = load float* %d1, align 4
  call void @phi_scalar(float %tmp_70, float* %phiD1)
  %tmp_71 = load float* %d2, align 4
  call void @phi_scalar(float %tmp_71, float* %phiD2)
  %tmp_72 = load float* %S, align 4
  %tmp_73 = load float* %phiD1, align 4
  %tmp_74 = load float* %KexpMinusRT, align 4
  %tmp_75 = load float* %phiD2, align 4
  %tmp_76 = fmul float %tmp_74, %tmp_75
  %tmp_77 = fsub float -0.000000e+00, %tmp_76
  %tmp_78 = call float @llvm.fmuladd.f32(float %tmp_72, float %tmp_73, float %tmp_77)
  %tmp_79 = load i32* %yPos, align 4
  %tmp_80 = load i32* %tmp_2, align 4
  %tmp_81 = mul i32 %tmp_79, %tmp_80
  %tmp_82 = load i32* %xPos, align 4
  %tmp_83 = add i32 %tmp_81, %tmp_82
  %tmp_84 = load float addrspace(1)** %tmp_3, align 4
  %tmp_85 = getelementptr inbounds float addrspace(1)* %tmp_84, i32 %tmp_83
  store float %tmp_78, float addrspace(1)* %tmp_85, align 4
  %tmp_86 = load float* %d1, align 4
  %tmp_87 = fsub float -0.000000e+00, %tmp_86
  call void @phi_scalar(float %tmp_87, float* %phiD1)
  %tmp_88 = load float* %d2, align 4
  %tmp_89 = fsub float -0.000000e+00, %tmp_88
  call void @phi_scalar(float %tmp_89, float* %phiD2)
  %tmp_90 = load float* %KexpMinusRT, align 4
  %tmp_91 = load float* %phiD2, align 4
  %tmp_92 = load float* %S, align 4
  %tmp_93 = load float* %phiD1, align 4
  %tmp_94 = fmul float %tmp_92, %tmp_93
  %tmp_95 = fsub float -0.000000e+00, %tmp_94
  %tmp_96 = call float @llvm.fmuladd.f32(float %tmp_90, float %tmp_91, float %tmp_95)
  %tmp_97 = load i32* %yPos, align 4
  %tmp_98 = load i32* %tmp_2, align 4
  %tmp_99 = mul i32 %tmp_97, %tmp_98
  %tmp_100 = load i32* %xPos, align 4
  %tmp_101 = add i32 %tmp_99, %tmp_100
  %tmp_102 = load float addrspace(1)** %tmp_4, align 4
  %tmp_103 = getelementptr inbounds float addrspace(1)* %tmp_102, i32 %tmp_101
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

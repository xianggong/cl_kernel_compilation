; ModuleID = '../kernel-src/MonteCarloAsianMultiGPU_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%struct._MonteCalroAttrib = type { <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float> }

; Function Attrs: nounwind
define void @lshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
  %tmp_1 = alloca <4 x i32>, align 16
  %tmp_2 = alloca i32, align 4
  %tmp_3 = alloca <4 x i32>*, align 4
  %invshift = alloca i32, align 4
  %temp = alloca <4 x i32>, align 16
  store <4 x i32> %input, <4 x i32>* %tmp_1, align 16
  store i32 %shift, i32* %tmp_2, align 4
  store <4 x i32>* %output, <4 x i32>** %tmp_3, align 4
  %tmp_4 = load i32* %tmp_2, align 4
  %tmp_5 = sub i32 32, %tmp_4
  store i32 %tmp_5, i32* %invshift, align 4
  %tmp_6 = load <4 x i32>* %tmp_1, align 16
  %tmp_7 = extractelement <4 x i32> %tmp_6, i32 0
  %tmp_8 = load i32* %tmp_2, align 4
  %tmp_9 = and i32 %tmp_8, 31
  %tmp_10 = shl i32 %tmp_7, %tmp_9
  %tmp_11 = load <4 x i32>* %temp, align 16
  %tmp_12 = insertelement <4 x i32> %tmp_11, i32 %tmp_10, i32 0
  store <4 x i32> %tmp_12, <4 x i32>* %temp, align 16
  %tmp_13 = load <4 x i32>* %tmp_1, align 16
  %tmp_14 = extractelement <4 x i32> %tmp_13, i32 1
  %tmp_15 = load i32* %tmp_2, align 4
  %tmp_16 = and i32 %tmp_15, 31
  %tmp_17 = shl i32 %tmp_14, %tmp_16
  %tmp_18 = load <4 x i32>* %tmp_1, align 16
  %tmp_19 = extractelement <4 x i32> %tmp_18, i32 0
  %tmp_20 = load i32* %invshift, align 4
  %tmp_21 = and i32 %tmp_20, 31
  %tmp_22 = lshr i32 %tmp_19, %tmp_21
  %tmp_23 = or i32 %tmp_17, %tmp_22
  %tmp_24 = load <4 x i32>* %temp, align 16
  %tmp_25 = insertelement <4 x i32> %tmp_24, i32 %tmp_23, i32 1
  store <4 x i32> %tmp_25, <4 x i32>* %temp, align 16
  %tmp_26 = load <4 x i32>* %tmp_1, align 16
  %tmp_27 = extractelement <4 x i32> %tmp_26, i32 2
  %tmp_28 = load i32* %tmp_2, align 4
  %tmp_29 = and i32 %tmp_28, 31
  %tmp_30 = shl i32 %tmp_27, %tmp_29
  %tmp_31 = load <4 x i32>* %tmp_1, align 16
  %tmp_32 = extractelement <4 x i32> %tmp_31, i32 1
  %tmp_33 = load i32* %invshift, align 4
  %tmp_34 = and i32 %tmp_33, 31
  %tmp_35 = lshr i32 %tmp_32, %tmp_34
  %tmp_36 = or i32 %tmp_30, %tmp_35
  %tmp_37 = load <4 x i32>* %temp, align 16
  %tmp_38 = insertelement <4 x i32> %tmp_37, i32 %tmp_36, i32 2
  store <4 x i32> %tmp_38, <4 x i32>* %temp, align 16
  %tmp_39 = load <4 x i32>* %tmp_1, align 16
  %tmp_40 = extractelement <4 x i32> %tmp_39, i32 3
  %tmp_41 = load i32* %tmp_2, align 4
  %tmp_42 = and i32 %tmp_41, 31
  %tmp_43 = shl i32 %tmp_40, %tmp_42
  %tmp_44 = load <4 x i32>* %tmp_1, align 16
  %tmp_45 = extractelement <4 x i32> %tmp_44, i32 2
  %tmp_46 = load i32* %invshift, align 4
  %tmp_47 = and i32 %tmp_46, 31
  %tmp_48 = lshr i32 %tmp_45, %tmp_47
  %tmp_49 = or i32 %tmp_43, %tmp_48
  %tmp_50 = load <4 x i32>* %temp, align 16
  %tmp_51 = insertelement <4 x i32> %tmp_50, i32 %tmp_49, i32 3
  store <4 x i32> %tmp_51, <4 x i32>* %temp, align 16
  %tmp_52 = load <4 x i32>* %temp, align 16
  %tmp_53 = load <4 x i32>** %tmp_3, align 4
  store <4 x i32> %tmp_52, <4 x i32>* %tmp_53, align 16
  ret void
}

; Function Attrs: nounwind
define void @rshift128(<4 x i32> %input, i32 %shift, <4 x i32>* %output) #0 {
  %tmp_1 = alloca <4 x i32>, align 16
  %tmp_2 = alloca i32, align 4
  %tmp_3 = alloca <4 x i32>*, align 4
  %invshift = alloca i32, align 4
  %temp = alloca <4 x i32>, align 16
  store <4 x i32> %input, <4 x i32>* %tmp_1, align 16
  store i32 %shift, i32* %tmp_2, align 4
  store <4 x i32>* %output, <4 x i32>** %tmp_3, align 4
  %tmp_4 = load i32* %tmp_2, align 4
  %tmp_5 = sub i32 32, %tmp_4
  store i32 %tmp_5, i32* %invshift, align 4
  %tmp_6 = load <4 x i32>* %tmp_1, align 16
  %tmp_7 = extractelement <4 x i32> %tmp_6, i32 3
  %tmp_8 = load i32* %tmp_2, align 4
  %tmp_9 = and i32 %tmp_8, 31
  %tmp_10 = lshr i32 %tmp_7, %tmp_9
  %tmp_11 = load <4 x i32>* %temp, align 16
  %tmp_12 = insertelement <4 x i32> %tmp_11, i32 %tmp_10, i32 3
  store <4 x i32> %tmp_12, <4 x i32>* %temp, align 16
  %tmp_13 = load <4 x i32>* %tmp_1, align 16
  %tmp_14 = extractelement <4 x i32> %tmp_13, i32 2
  %tmp_15 = load i32* %tmp_2, align 4
  %tmp_16 = and i32 %tmp_15, 31
  %tmp_17 = lshr i32 %tmp_14, %tmp_16
  %tmp_18 = load <4 x i32>* %tmp_1, align 16
  %tmp_19 = extractelement <4 x i32> %tmp_18, i32 3
  %tmp_20 = load i32* %invshift, align 4
  %tmp_21 = and i32 %tmp_20, 31
  %tmp_22 = shl i32 %tmp_19, %tmp_21
  %tmp_23 = or i32 %tmp_17, %tmp_22
  %tmp_24 = load <4 x i32>* %temp, align 16
  %tmp_25 = insertelement <4 x i32> %tmp_24, i32 %tmp_23, i32 2
  store <4 x i32> %tmp_25, <4 x i32>* %temp, align 16
  %tmp_26 = load <4 x i32>* %tmp_1, align 16
  %tmp_27 = extractelement <4 x i32> %tmp_26, i32 1
  %tmp_28 = load i32* %tmp_2, align 4
  %tmp_29 = and i32 %tmp_28, 31
  %tmp_30 = lshr i32 %tmp_27, %tmp_29
  %tmp_31 = load <4 x i32>* %tmp_1, align 16
  %tmp_32 = extractelement <4 x i32> %tmp_31, i32 2
  %tmp_33 = load i32* %invshift, align 4
  %tmp_34 = and i32 %tmp_33, 31
  %tmp_35 = shl i32 %tmp_32, %tmp_34
  %tmp_36 = or i32 %tmp_30, %tmp_35
  %tmp_37 = load <4 x i32>* %temp, align 16
  %tmp_38 = insertelement <4 x i32> %tmp_37, i32 %tmp_36, i32 1
  store <4 x i32> %tmp_38, <4 x i32>* %temp, align 16
  %tmp_39 = load <4 x i32>* %tmp_1, align 16
  %tmp_40 = extractelement <4 x i32> %tmp_39, i32 0
  %tmp_41 = load i32* %tmp_2, align 4
  %tmp_42 = and i32 %tmp_41, 31
  %tmp_43 = lshr i32 %tmp_40, %tmp_42
  %tmp_44 = load <4 x i32>* %tmp_1, align 16
  %tmp_45 = extractelement <4 x i32> %tmp_44, i32 1
  %tmp_46 = load i32* %invshift, align 4
  %tmp_47 = and i32 %tmp_46, 31
  %tmp_48 = shl i32 %tmp_45, %tmp_47
  %tmp_49 = or i32 %tmp_43, %tmp_48
  %tmp_50 = load <4 x i32>* %temp, align 16
  %tmp_51 = insertelement <4 x i32> %tmp_50, i32 %tmp_49, i32 0
  store <4 x i32> %tmp_51, <4 x i32>* %temp, align 16
  %tmp_52 = load <4 x i32>* %temp, align 16
  %tmp_53 = load <4 x i32>** %tmp_3, align 4
  store <4 x i32> %tmp_52, <4 x i32>* %tmp_53, align 16
  ret void
}

; Function Attrs: nounwind
define void @generateRand(<4 x i32> %seed, <4 x float>* %gaussianRand1, <4 x float>* %gaussianRand2, <4 x i32>* %nextRand) #0 {
  %tmp_1 = alloca <4 x i32>, align 16
  %tmp_2 = alloca <4 x float>*, align 4
  %tmp_3 = alloca <4 x float>*, align 4
  %tmp_4 = alloca <4 x i32>*, align 4
  %mulFactor = alloca i32, align 4
  %temp = alloca [8 x <4 x i32>], align 16
  %state1 = alloca <4 x i32>, align 16
  %state2 = alloca <4 x i32>, align 16
  %state3 = alloca <4 x i32>, align 16
  %state4 = alloca <4 x i32>, align 16
  %state5 = alloca <4 x i32>, align 16
  %stateMask = alloca i32, align 4
  %thirty = alloca i32, align 4
  %mask4 = alloca <4 x i32>, align 16
  %thirty4 = alloca <4 x i32>, align 16
  %one4 = alloca <4 x i32>, align 16
  %two4 = alloca <4 x i32>, align 16
  %three4 = alloca <4 x i32>, align 16
  %four4 = alloca <4 x i32>, align 16
  %r1 = alloca <4 x i32>, align 16
  %r2 = alloca <4 x i32>, align 16
  %a = alloca <4 x i32>, align 16
  %b = alloca <4 x i32>, align 16
  %e = alloca <4 x i32>, align 16
  %f = alloca <4 x i32>, align 16
  %thirteen = alloca i32, align 4
  %fifteen = alloca i32, align 4
  %shift = alloca i32, align 4
  %mask11 = alloca i32, align 4
  %mask12 = alloca i32, align 4
  %mask13 = alloca i32, align 4
  %mask14 = alloca i32, align 4
  %one = alloca float, align 4
  %intMax = alloca float, align 4
  %PI = alloca float, align 4
  %two = alloca float, align 4
  %r = alloca <4 x float>, align 16
  %phi = alloca <4 x float>, align 16
  %temp1 = alloca <4 x float>, align 16
  %temp2 = alloca <4 x float>, align 16
  %i = alloca i32, align 4
  store <4 x i32> %seed, <4 x i32>* %tmp_1, align 16
  store <4 x float>* %gaussianRand1, <4 x float>** %tmp_2, align 4
  store <4 x float>* %gaussianRand2, <4 x float>** %tmp_3, align 4
  store <4 x i32>* %nextRand, <4 x i32>** %tmp_4, align 4
  store i32 4, i32* %mulFactor, align 4
  %tmp_5 = load <4 x i32>* %tmp_1, align 16
  store <4 x i32> %tmp_5, <4 x i32>* %state1, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state2, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state3, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state4, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %state5, align 16
  store i32 1812433253, i32* %stateMask, align 4
  store i32 30, i32* %thirty, align 4
  %tmp_6 = load i32* %stateMask, align 4
  %tmp_7 = insertelement <4 x i32> undef, i32 %tmp_6, i32 0
  %tmp_8 = shufflevector <4 x i32> %tmp_7, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %tmp_8, <4 x i32>* %mask4, align 16
  %tmp_9 = load i32* %thirty, align 4
  %tmp_10 = insertelement <4 x i32> undef, i32 %tmp_9, i32 0
  %tmp_11 = shufflevector <4 x i32> %tmp_10, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %tmp_11, <4 x i32>* %thirty4, align 16
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %one4, align 16
  store <4 x i32> <i32 2, i32 2, i32 2, i32 2>, <4 x i32>* %two4, align 16
  store <4 x i32> <i32 3, i32 3, i32 3, i32 3>, <4 x i32>* %three4, align 16
  store <4 x i32> <i32 4, i32 4, i32 4, i32 4>, <4 x i32>* %four4, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %r1, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %r2, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %a, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %b, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %e, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %f, align 16
  store i32 13, i32* %thirteen, align 4
  store i32 15, i32* %fifteen, align 4
  store i32 24, i32* %shift, align 4
  store i32 -33605633, i32* %mask11, align 4
  store i32 -276873347, i32* %mask12, align 4
  store i32 -8946819, i32* %mask13, align 4
  store i32 2146958127, i32* %mask14, align 4
  store float 1.000000e+00, float* %one, align 4
  store float 0x41F0000000000000, float* %intMax, align 4
  store float 0x400921FB60000000, float* %PI, align 4
  store float 2.000000e+00, float* %two, align 4
  %tmp_12 = load <4 x i32>* %mask4, align 16
  %tmp_13 = load <4 x i32>* %state1, align 16
  %tmp_14 = load <4 x i32>* %state1, align 16
  %tmp_15 = load <4 x i32>* %thirty4, align 16
  %tmp_16 = and <4 x i32> %tmp_15, <i32 31, i32 31, i32 31, i32 31>
  %tmp_17 = lshr <4 x i32> %tmp_14, %tmp_16
  %tmp_18 = xor <4 x i32> %tmp_13, %tmp_17
  %tmp_19 = mul <4 x i32> %tmp_12, %tmp_18
  %tmp_20 = load <4 x i32>* %one4, align 16
  %tmp_21 = add <4 x i32> %tmp_19, %tmp_20
  store <4 x i32> %tmp_21, <4 x i32>* %state2, align 16
  %tmp_22 = load <4 x i32>* %mask4, align 16
  %tmp_23 = load <4 x i32>* %state2, align 16
  %tmp_24 = load <4 x i32>* %state2, align 16
  %tmp_25 = load <4 x i32>* %thirty4, align 16
  %tmp_26 = and <4 x i32> %tmp_25, <i32 31, i32 31, i32 31, i32 31>
  %tmp_27 = lshr <4 x i32> %tmp_24, %tmp_26
  %tmp_28 = xor <4 x i32> %tmp_23, %tmp_27
  %tmp_29 = mul <4 x i32> %tmp_22, %tmp_28
  %tmp_30 = load <4 x i32>* %two4, align 16
  %tmp_31 = add <4 x i32> %tmp_29, %tmp_30
  store <4 x i32> %tmp_31, <4 x i32>* %state3, align 16
  %tmp_32 = load <4 x i32>* %mask4, align 16
  %tmp_33 = load <4 x i32>* %state3, align 16
  %tmp_34 = load <4 x i32>* %state3, align 16
  %tmp_35 = load <4 x i32>* %thirty4, align 16
  %tmp_36 = and <4 x i32> %tmp_35, <i32 31, i32 31, i32 31, i32 31>
  %tmp_37 = lshr <4 x i32> %tmp_34, %tmp_36
  %tmp_38 = xor <4 x i32> %tmp_33, %tmp_37
  %tmp_39 = mul <4 x i32> %tmp_32, %tmp_38
  %tmp_40 = load <4 x i32>* %three4, align 16
  %tmp_41 = add <4 x i32> %tmp_39, %tmp_40
  store <4 x i32> %tmp_41, <4 x i32>* %state4, align 16
  %tmp_42 = load <4 x i32>* %mask4, align 16
  %tmp_43 = load <4 x i32>* %state4, align 16
  %tmp_44 = load <4 x i32>* %state4, align 16
  %tmp_45 = load <4 x i32>* %thirty4, align 16
  %tmp_46 = and <4 x i32> %tmp_45, <i32 31, i32 31, i32 31, i32 31>
  %tmp_47 = lshr <4 x i32> %tmp_44, %tmp_46
  %tmp_48 = xor <4 x i32> %tmp_43, %tmp_47
  %tmp_49 = mul <4 x i32> %tmp_42, %tmp_48
  %tmp_50 = load <4 x i32>* %four4, align 16
  %tmp_51 = add <4 x i32> %tmp_49, %tmp_50
  store <4 x i32> %tmp_51, <4 x i32>* %state5, align 16
  store i32 0, i32* %i, align 4
  store i32 0, i32* %i, align 4
  br label %tmp_52

tmp_52:                                      ; preds = %tmp_191, %tmp_0
  %tmp_53 = load i32* %i, align 4
  %tmp_54 = load i32* %mulFactor, align 4
  %tmp_55 = icmp ult i32 %tmp_53, %tmp_54
  br i1 %tmp_55, label %tmp_56, label %tmp_194

tmp_56:                                      ; preds = %tmp_52
  %tmp_57 = load i32* %i, align 4
  switch i32 %tmp_57, label %tmp_81 [
    i32 0, label %tmp_58
    i32 1, label %tmp_63
    i32 2, label %tmp_69
    i32 3, label %tmp_75
  ]

tmp_58:                                      ; preds = %tmp_56
  %tmp_59 = load <4 x i32>* %state4, align 16
  store <4 x i32> %tmp_59, <4 x i32>* %r1, align 16
  %tmp_60 = load <4 x i32>* %state5, align 16
  store <4 x i32> %tmp_60, <4 x i32>* %r2, align 16
  %tmp_61 = load <4 x i32>* %state1, align 16
  store <4 x i32> %tmp_61, <4 x i32>* %a, align 16
  %tmp_62 = load <4 x i32>* %state3, align 16
  store <4 x i32> %tmp_62, <4 x i32>* %b, align 16
  br label %tmp_82

tmp_63:                                      ; preds = %tmp_56
  %tmp_64 = load <4 x i32>* %r2, align 16
  store <4 x i32> %tmp_64, <4 x i32>* %r1, align 16
  %tmp_65 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 0
  %tmp_66 = load <4 x i32>* %tmp_65, align 16
  store <4 x i32> %tmp_66, <4 x i32>* %r2, align 16
  %tmp_67 = load <4 x i32>* %state2, align 16
  store <4 x i32> %tmp_67, <4 x i32>* %a, align 16
  %tmp_68 = load <4 x i32>* %state4, align 16
  store <4 x i32> %tmp_68, <4 x i32>* %b, align 16
  br label %tmp_82

tmp_69:                                      ; preds = %tmp_56
  %tmp_70 = load <4 x i32>* %r2, align 16
  store <4 x i32> %tmp_70, <4 x i32>* %r1, align 16
  %tmp_71 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 1
  %tmp_72 = load <4 x i32>* %tmp_71, align 16
  store <4 x i32> %tmp_72, <4 x i32>* %r2, align 16
  %tmp_73 = load <4 x i32>* %state3, align 16
  store <4 x i32> %tmp_73, <4 x i32>* %a, align 16
  %tmp_74 = load <4 x i32>* %state5, align 16
  store <4 x i32> %tmp_74, <4 x i32>* %b, align 16
  br label %tmp_82

tmp_75:                                      ; preds = %tmp_56
  %tmp_76 = load <4 x i32>* %r2, align 16
  store <4 x i32> %tmp_76, <4 x i32>* %r1, align 16
  %tmp_77 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 2
  %tmp_78 = load <4 x i32>* %tmp_77, align 16
  store <4 x i32> %tmp_78, <4 x i32>* %r2, align 16
  %tmp_79 = load <4 x i32>* %state4, align 16
  store <4 x i32> %tmp_79, <4 x i32>* %a, align 16
  %tmp_80 = load <4 x i32>* %state1, align 16
  store <4 x i32> %tmp_80, <4 x i32>* %b, align 16
  br label %tmp_82

tmp_81:                                      ; preds = %tmp_56
  br label %tmp_82

tmp_82:                                      ; preds = %tmp_81, %tmp_75, %tmp_69, %tmp_63, %tmp_58
  %tmp_83 = load <4 x i32>* %a, align 16
  %tmp_84 = load i32* %shift, align 4
  call void @lshift128(<4 x i32> %tmp_83, i32 %tmp_84, <4 x i32>* %e)
  %tmp_85 = load <4 x i32>* %r1, align 16
  %tmp_86 = load i32* %shift, align 4
  call void @rshift128(<4 x i32> %tmp_85, i32 %tmp_86, <4 x i32>* %f)
  %tmp_87 = load <4 x i32>* %a, align 16
  %tmp_88 = extractelement <4 x i32> %tmp_87, i32 0
  %tmp_89 = load <4 x i32>* %e, align 16
  %tmp_90 = extractelement <4 x i32> %tmp_89, i32 0
  %tmp_91 = xor i32 %tmp_88, %tmp_90
  %tmp_92 = load <4 x i32>* %b, align 16
  %tmp_93 = extractelement <4 x i32> %tmp_92, i32 0
  %tmp_94 = load i32* %thirteen, align 4
  %tmp_95 = and i32 %tmp_94, 31
  %tmp_96 = lshr i32 %tmp_93, %tmp_95
  %tmp_97 = load i32* %mask11, align 4
  %tmp_98 = and i32 %tmp_96, %tmp_97
  %tmp_99 = xor i32 %tmp_91, %tmp_98
  %tmp_100 = load <4 x i32>* %f, align 16
  %tmp_101 = extractelement <4 x i32> %tmp_100, i32 0
  %tmp_102 = xor i32 %tmp_99, %tmp_101
  %tmp_103 = load <4 x i32>* %r2, align 16
  %tmp_104 = extractelement <4 x i32> %tmp_103, i32 0
  %tmp_105 = load i32* %fifteen, align 4
  %tmp_106 = and i32 %tmp_105, 31
  %tmp_107 = shl i32 %tmp_104, %tmp_106
  %tmp_108 = xor i32 %tmp_102, %tmp_107
  %tmp_109 = load i32* %i, align 4
  %tmp_110 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %tmp_109
  %tmp_111 = load <4 x i32>* %tmp_110, align 16
  %tmp_112 = insertelement <4 x i32> %tmp_111, i32 %tmp_108, i32 0
  store <4 x i32> %tmp_112, <4 x i32>* %tmp_110, align 16
  %tmp_113 = load <4 x i32>* %a, align 16
  %tmp_114 = extractelement <4 x i32> %tmp_113, i32 1
  %tmp_115 = load <4 x i32>* %e, align 16
  %tmp_116 = extractelement <4 x i32> %tmp_115, i32 1
  %tmp_117 = xor i32 %tmp_114, %tmp_116
  %tmp_118 = load <4 x i32>* %b, align 16
  %tmp_119 = extractelement <4 x i32> %tmp_118, i32 1
  %tmp_120 = load i32* %thirteen, align 4
  %tmp_121 = and i32 %tmp_120, 31
  %tmp_122 = lshr i32 %tmp_119, %tmp_121
  %tmp_123 = load i32* %mask12, align 4
  %tmp_124 = and i32 %tmp_122, %tmp_123
  %tmp_125 = xor i32 %tmp_117, %tmp_124
  %tmp_126 = load <4 x i32>* %f, align 16
  %tmp_127 = extractelement <4 x i32> %tmp_126, i32 1
  %tmp_128 = xor i32 %tmp_125, %tmp_127
  %tmp_129 = load <4 x i32>* %r2, align 16
  %tmp_130 = extractelement <4 x i32> %tmp_129, i32 1
  %tmp_131 = load i32* %fifteen, align 4
  %tmp_132 = and i32 %tmp_131, 31
  %tmp_133 = shl i32 %tmp_130, %tmp_132
  %tmp_134 = xor i32 %tmp_128, %tmp_133
  %tmp_135 = load i32* %i, align 4
  %tmp_136 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %tmp_135
  %tmp_137 = load <4 x i32>* %tmp_136, align 16
  %tmp_138 = insertelement <4 x i32> %tmp_137, i32 %tmp_134, i32 1
  store <4 x i32> %tmp_138, <4 x i32>* %tmp_136, align 16
  %tmp_139 = load <4 x i32>* %a, align 16
  %tmp_140 = extractelement <4 x i32> %tmp_139, i32 2
  %tmp_141 = load <4 x i32>* %e, align 16
  %tmp_142 = extractelement <4 x i32> %tmp_141, i32 2
  %tmp_143 = xor i32 %tmp_140, %tmp_142
  %tmp_144 = load <4 x i32>* %b, align 16
  %tmp_145 = extractelement <4 x i32> %tmp_144, i32 2
  %tmp_146 = load i32* %thirteen, align 4
  %tmp_147 = and i32 %tmp_146, 31
  %tmp_148 = lshr i32 %tmp_145, %tmp_147
  %tmp_149 = load i32* %mask13, align 4
  %tmp_150 = and i32 %tmp_148, %tmp_149
  %tmp_151 = xor i32 %tmp_143, %tmp_150
  %tmp_152 = load <4 x i32>* %f, align 16
  %tmp_153 = extractelement <4 x i32> %tmp_152, i32 2
  %tmp_154 = xor i32 %tmp_151, %tmp_153
  %tmp_155 = load <4 x i32>* %r2, align 16
  %tmp_156 = extractelement <4 x i32> %tmp_155, i32 2
  %tmp_157 = load i32* %fifteen, align 4
  %tmp_158 = and i32 %tmp_157, 31
  %tmp_159 = shl i32 %tmp_156, %tmp_158
  %tmp_160 = xor i32 %tmp_154, %tmp_159
  %tmp_161 = load i32* %i, align 4
  %tmp_162 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %tmp_161
  %tmp_163 = load <4 x i32>* %tmp_162, align 16
  %tmp_164 = insertelement <4 x i32> %tmp_163, i32 %tmp_160, i32 2
  store <4 x i32> %tmp_164, <4 x i32>* %tmp_162, align 16
  %tmp_165 = load <4 x i32>* %a, align 16
  %tmp_166 = extractelement <4 x i32> %tmp_165, i32 3
  %tmp_167 = load <4 x i32>* %e, align 16
  %tmp_168 = extractelement <4 x i32> %tmp_167, i32 3
  %tmp_169 = xor i32 %tmp_166, %tmp_168
  %tmp_170 = load <4 x i32>* %b, align 16
  %tmp_171 = extractelement <4 x i32> %tmp_170, i32 3
  %tmp_172 = load i32* %thirteen, align 4
  %tmp_173 = and i32 %tmp_172, 31
  %tmp_174 = lshr i32 %tmp_171, %tmp_173
  %tmp_175 = load i32* %mask14, align 4
  %tmp_176 = and i32 %tmp_174, %tmp_175
  %tmp_177 = xor i32 %tmp_169, %tmp_176
  %tmp_178 = load <4 x i32>* %f, align 16
  %tmp_179 = extractelement <4 x i32> %tmp_178, i32 3
  %tmp_180 = xor i32 %tmp_177, %tmp_179
  %tmp_181 = load <4 x i32>* %r2, align 16
  %tmp_182 = extractelement <4 x i32> %tmp_181, i32 3
  %tmp_183 = load i32* %fifteen, align 4
  %tmp_184 = and i32 %tmp_183, 31
  %tmp_185 = shl i32 %tmp_182, %tmp_184
  %tmp_186 = xor i32 %tmp_180, %tmp_185
  %tmp_187 = load i32* %i, align 4
  %tmp_188 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 %tmp_187
  %tmp_189 = load <4 x i32>* %tmp_188, align 16
  %tmp_190 = insertelement <4 x i32> %tmp_189, i32 %tmp_186, i32 3
  store <4 x i32> %tmp_190, <4 x i32>* %tmp_188, align 16
  br label %tmp_191

tmp_191:                                     ; preds = %tmp_82
  %tmp_192 = load i32* %i, align 4
  %tmp_193 = add i32 %tmp_192, 1
  store i32 %tmp_193, i32* %i, align 4
  br label %tmp_52

tmp_194:                                     ; preds = %tmp_52
  %tmp_195 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 0
  %tmp_196 = load <4 x i32>* %tmp_195, align 16
  %tmp_197 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %tmp_196)
  %tmp_198 = fmul <4 x float> %tmp_197, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %tmp_199 = fdiv <4 x float> %tmp_198, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !2
  store <4 x float> %tmp_199, <4 x float>* %temp1, align 16
  %tmp_200 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 1
  %tmp_201 = load <4 x i32>* %tmp_200, align 16
  %tmp_202 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %tmp_201)
  %tmp_203 = fmul <4 x float> %tmp_202, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %tmp_204 = fdiv <4 x float> %tmp_203, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !2
  store <4 x float> %tmp_204, <4 x float>* %temp2, align 16
  %tmp_205 = load <4 x float>* %temp1, align 16
  %tmp_206 = call <4 x float> @llvm.log2.v4f32(<4 x float> %tmp_205)
  %tmp_207 = fmul <4 x float> %tmp_206, <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>
  %tmp_208 = fmul <4 x float> <float -2.000000e+00, float -2.000000e+00, float -2.000000e+00, float -2.000000e+00>, %tmp_207
  %tmp_209 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %tmp_208)
  store <4 x float> %tmp_209, <4 x float>* %r, align 16
  %tmp_210 = load <4 x float>* %temp2, align 16
  %tmp_211 = fmul <4 x float> <float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000>, %tmp_210
  store <4 x float> %tmp_211, <4 x float>* %phi, align 16
  %tmp_212 = load <4 x float>* %r, align 16
  %tmp_213 = load <4 x float>* %phi, align 16
  %tmp_214 = call <4 x float> @_Z3cosDv4_f(<4 x float> %tmp_213)
  %tmp_215 = fmul <4 x float> %tmp_212, %tmp_214
  %tmp_216 = load <4 x float>** %tmp_2, align 4
  store <4 x float> %tmp_215, <4 x float>* %tmp_216, align 16
  %tmp_217 = load <4 x float>* %r, align 16
  %tmp_218 = load <4 x float>* %phi, align 16
  %tmp_219 = call <4 x float> @_Z3sinDv4_f(<4 x float> %tmp_218)
  %tmp_220 = fmul <4 x float> %tmp_217, %tmp_219
  %tmp_221 = load <4 x float>** %tmp_3, align 4
  store <4 x float> %tmp_220, <4 x float>* %tmp_221, align 16
  %tmp_222 = getelementptr inbounds [8 x <4 x i32>]* %temp, i32 0, i32 2
  %tmp_223 = load <4 x i32>* %tmp_222, align 16
  %tmp_224 = load <4 x i32>** %tmp_4, align 4
  store <4 x i32> %tmp_223, <4 x i32>* %tmp_224, align 16
  ret void
}

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #2

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #2

declare <4 x float> @_Z3cosDv4_f(<4 x float>) #1

declare <4 x float> @_Z3sinDv4_f(<4 x float>) #1

; Function Attrs: nounwind
define void @calOutputs(<4 x float> %strikePrice, <4 x float> %meanDeriv1, <4 x float> %meanDeriv2, <4 x float> %meanPrice1, <4 x float> %meanPrice2, <4 x float>* %pathDeriv1, <4 x float>* %pathDeriv2, <4 x float>* %priceVec1, <4 x float>* %priceVec2) #0 {
  %tmp_1 = alloca <4 x float>, align 16
  %tmp_2 = alloca <4 x float>, align 16
  %tmp_3 = alloca <4 x float>, align 16
  %tmp_4 = alloca <4 x float>, align 16
  %tmp_5 = alloca <4 x float>, align 16
  %tmp_6 = alloca <4 x float>*, align 4
  %tmp_7 = alloca <4 x float>*, align 4
  %tmp_8 = alloca <4 x float>*, align 4
  %tmp_9 = alloca <4 x float>*, align 4
  %temp1 = alloca <4 x float>, align 16
  %temp2 = alloca <4 x float>, align 16
  %temp3 = alloca <4 x float>, align 16
  %temp4 = alloca <4 x float>, align 16
  %tempDiff1 = alloca <4 x float>, align 16
  %tempDiff2 = alloca <4 x float>, align 16
  store <4 x float> %strikePrice, <4 x float>* %tmp_1, align 16
  store <4 x float> %meanDeriv1, <4 x float>* %tmp_2, align 16
  store <4 x float> %meanDeriv2, <4 x float>* %tmp_3, align 16
  store <4 x float> %meanPrice1, <4 x float>* %tmp_4, align 16
  store <4 x float> %meanPrice2, <4 x float>* %tmp_5, align 16
  store <4 x float>* %pathDeriv1, <4 x float>** %tmp_6, align 4
  store <4 x float>* %pathDeriv2, <4 x float>** %tmp_7, align 4
  store <4 x float>* %priceVec1, <4 x float>** %tmp_8, align 4
  store <4 x float>* %priceVec2, <4 x float>** %tmp_9, align 4
  store <4 x float> zeroinitializer, <4 x float>* %temp1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %temp2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %temp3, align 16
  store <4 x float> zeroinitializer, <4 x float>* %temp4, align 16
  %tmp_10 = load <4 x float>* %tmp_4, align 16
  %tmp_11 = load <4 x float>* %tmp_1, align 16
  %tmp_12 = fsub <4 x float> %tmp_10, %tmp_11
  store <4 x float> %tmp_12, <4 x float>* %tempDiff1, align 16
  %tmp_13 = load <4 x float>* %tmp_5, align 16
  %tmp_14 = load <4 x float>* %tmp_1, align 16
  %tmp_15 = fsub <4 x float> %tmp_13, %tmp_14
  store <4 x float> %tmp_15, <4 x float>* %tempDiff2, align 16
  %tmp_16 = load <4 x float>* %tempDiff1, align 16
  %tmp_17 = extractelement <4 x float> %tmp_16, i32 0
  %tmp_18 = fcmp ogt float %tmp_17, 0.000000e+00
  br i1 %tmp_18, label %tmp_19, label %tmp_26

tmp_19:                                      ; preds = %tmp_0
  %tmp_20 = load <4 x float>* %temp1, align 16
  %tmp_21 = insertelement <4 x float> %tmp_20, float 1.000000e+00, i32 0
  store <4 x float> %tmp_21, <4 x float>* %temp1, align 16
  %tmp_22 = load <4 x float>* %tempDiff1, align 16
  %tmp_23 = extractelement <4 x float> %tmp_22, i32 0
  %tmp_24 = load <4 x float>* %temp3, align 16
  %tmp_25 = insertelement <4 x float> %tmp_24, float %tmp_23, i32 0
  store <4 x float> %tmp_25, <4 x float>* %temp3, align 16
  br label %tmp_26

tmp_26:                                      ; preds = %tmp_19, %tmp_0
  %tmp_27 = load <4 x float>* %tempDiff1, align 16
  %tmp_28 = extractelement <4 x float> %tmp_27, i32 1
  %tmp_29 = fcmp ogt float %tmp_28, 0.000000e+00
  br i1 %tmp_29, label %tmp_30, label %tmp_37

tmp_30:                                      ; preds = %tmp_26
  %tmp_31 = load <4 x float>* %temp1, align 16
  %tmp_32 = insertelement <4 x float> %tmp_31, float 1.000000e+00, i32 1
  store <4 x float> %tmp_32, <4 x float>* %temp1, align 16
  %tmp_33 = load <4 x float>* %tempDiff1, align 16
  %tmp_34 = extractelement <4 x float> %tmp_33, i32 1
  %tmp_35 = load <4 x float>* %temp3, align 16
  %tmp_36 = insertelement <4 x float> %tmp_35, float %tmp_34, i32 1
  store <4 x float> %tmp_36, <4 x float>* %temp3, align 16
  br label %tmp_37

tmp_37:                                      ; preds = %tmp_30, %tmp_26
  %tmp_38 = load <4 x float>* %tempDiff1, align 16
  %tmp_39 = extractelement <4 x float> %tmp_38, i32 2
  %tmp_40 = fcmp ogt float %tmp_39, 0.000000e+00
  br i1 %tmp_40, label %tmp_41, label %tmp_48

tmp_41:                                      ; preds = %tmp_37
  %tmp_42 = load <4 x float>* %temp1, align 16
  %tmp_43 = insertelement <4 x float> %tmp_42, float 1.000000e+00, i32 2
  store <4 x float> %tmp_43, <4 x float>* %temp1, align 16
  %tmp_44 = load <4 x float>* %tempDiff1, align 16
  %tmp_45 = extractelement <4 x float> %tmp_44, i32 2
  %tmp_46 = load <4 x float>* %temp3, align 16
  %tmp_47 = insertelement <4 x float> %tmp_46, float %tmp_45, i32 2
  store <4 x float> %tmp_47, <4 x float>* %temp3, align 16
  br label %tmp_48

tmp_48:                                      ; preds = %tmp_41, %tmp_37
  %tmp_49 = load <4 x float>* %tempDiff1, align 16
  %tmp_50 = extractelement <4 x float> %tmp_49, i32 3
  %tmp_51 = fcmp ogt float %tmp_50, 0.000000e+00
  br i1 %tmp_51, label %tmp_52, label %tmp_59

tmp_52:                                      ; preds = %tmp_48
  %tmp_53 = load <4 x float>* %temp1, align 16
  %tmp_54 = insertelement <4 x float> %tmp_53, float 1.000000e+00, i32 3
  store <4 x float> %tmp_54, <4 x float>* %temp1, align 16
  %tmp_55 = load <4 x float>* %tempDiff1, align 16
  %tmp_56 = extractelement <4 x float> %tmp_55, i32 3
  %tmp_57 = load <4 x float>* %temp3, align 16
  %tmp_58 = insertelement <4 x float> %tmp_57, float %tmp_56, i32 3
  store <4 x float> %tmp_58, <4 x float>* %temp3, align 16
  br label %tmp_59

tmp_59:                                      ; preds = %tmp_52, %tmp_48
  %tmp_60 = load <4 x float>* %tempDiff2, align 16
  %tmp_61 = extractelement <4 x float> %tmp_60, i32 0
  %tmp_62 = fcmp ogt float %tmp_61, 0.000000e+00
  br i1 %tmp_62, label %tmp_63, label %tmp_70

tmp_63:                                      ; preds = %tmp_59
  %tmp_64 = load <4 x float>* %temp2, align 16
  %tmp_65 = insertelement <4 x float> %tmp_64, float 1.000000e+00, i32 0
  store <4 x float> %tmp_65, <4 x float>* %temp2, align 16
  %tmp_66 = load <4 x float>* %tempDiff2, align 16
  %tmp_67 = extractelement <4 x float> %tmp_66, i32 0
  %tmp_68 = load <4 x float>* %temp4, align 16
  %tmp_69 = insertelement <4 x float> %tmp_68, float %tmp_67, i32 0
  store <4 x float> %tmp_69, <4 x float>* %temp4, align 16
  br label %tmp_70

tmp_70:                                      ; preds = %tmp_63, %tmp_59
  %tmp_71 = load <4 x float>* %tempDiff2, align 16
  %tmp_72 = extractelement <4 x float> %tmp_71, i32 1
  %tmp_73 = fcmp ogt float %tmp_72, 0.000000e+00
  br i1 %tmp_73, label %tmp_74, label %tmp_81

tmp_74:                                      ; preds = %tmp_70
  %tmp_75 = load <4 x float>* %temp2, align 16
  %tmp_76 = insertelement <4 x float> %tmp_75, float 1.000000e+00, i32 1
  store <4 x float> %tmp_76, <4 x float>* %temp2, align 16
  %tmp_77 = load <4 x float>* %tempDiff2, align 16
  %tmp_78 = extractelement <4 x float> %tmp_77, i32 1
  %tmp_79 = load <4 x float>* %temp4, align 16
  %tmp_80 = insertelement <4 x float> %tmp_79, float %tmp_78, i32 1
  store <4 x float> %tmp_80, <4 x float>* %temp4, align 16
  br label %tmp_81

tmp_81:                                      ; preds = %tmp_74, %tmp_70
  %tmp_82 = load <4 x float>* %tempDiff2, align 16
  %tmp_83 = extractelement <4 x float> %tmp_82, i32 2
  %tmp_84 = fcmp ogt float %tmp_83, 0.000000e+00
  br i1 %tmp_84, label %tmp_85, label %tmp_92

tmp_85:                                      ; preds = %tmp_81
  %tmp_86 = load <4 x float>* %temp2, align 16
  %tmp_87 = insertelement <4 x float> %tmp_86, float 1.000000e+00, i32 2
  store <4 x float> %tmp_87, <4 x float>* %temp2, align 16
  %tmp_88 = load <4 x float>* %tempDiff2, align 16
  %tmp_89 = extractelement <4 x float> %tmp_88, i32 2
  %tmp_90 = load <4 x float>* %temp4, align 16
  %tmp_91 = insertelement <4 x float> %tmp_90, float %tmp_89, i32 2
  store <4 x float> %tmp_91, <4 x float>* %temp4, align 16
  br label %tmp_92

tmp_92:                                      ; preds = %tmp_85, %tmp_81
  %tmp_93 = load <4 x float>* %tempDiff2, align 16
  %tmp_94 = extractelement <4 x float> %tmp_93, i32 3
  %tmp_95 = fcmp ogt float %tmp_94, 0.000000e+00
  br i1 %tmp_95, label %tmp_96, label %tmp_103

tmp_96:                                      ; preds = %tmp_92
  %tmp_97 = load <4 x float>* %temp2, align 16
  %tmp_98 = insertelement <4 x float> %tmp_97, float 1.000000e+00, i32 3
  store <4 x float> %tmp_98, <4 x float>* %temp2, align 16
  %tmp_99 = load <4 x float>* %tempDiff2, align 16
  %tmp_100 = extractelement <4 x float> %tmp_99, i32 3
  %tmp_101 = load <4 x float>* %temp4, align 16
  %tmp_102 = insertelement <4 x float> %tmp_101, float %tmp_100, i32 3
  store <4 x float> %tmp_102, <4 x float>* %temp4, align 16
  br label %tmp_103

tmp_103:                                     ; preds = %tmp_96, %tmp_92
  %tmp_104 = load <4 x float>* %tmp_2, align 16
  %tmp_105 = load <4 x float>* %temp1, align 16
  %tmp_106 = fmul <4 x float> %tmp_104, %tmp_105
  %tmp_107 = load <4 x float>** %tmp_6, align 4
  store <4 x float> %tmp_106, <4 x float>* %tmp_107, align 16
  %tmp_108 = load <4 x float>* %tmp_3, align 16
  %tmp_109 = load <4 x float>* %temp2, align 16
  %tmp_110 = fmul <4 x float> %tmp_108, %tmp_109
  %tmp_111 = load <4 x float>** %tmp_7, align 4
  store <4 x float> %tmp_110, <4 x float>* %tmp_111, align 16
  %tmp_112 = load <4 x float>* %temp3, align 16
  %tmp_113 = load <4 x float>** %tmp_8, align 4
  store <4 x float> %tmp_112, <4 x float>* %tmp_113, align 16
  %tmp_114 = load <4 x float>* %temp4, align 16
  %tmp_115 = load <4 x float>** %tmp_9, align 4
  store <4 x float> %tmp_114, <4 x float>* %tmp_115, align 16
  ret void
}

; Function Attrs: nounwind
define void @calPriceVega(%struct._MonteCalroAttrib* byval %attrib, i32 %noOfSum, i32 %width, <4 x i32> addrspace(1)* %randArray, <4 x float> addrspace(1)* %priceSamples, <4 x float> addrspace(1)* %pathDeriv) #0 {
  %tmp_1 = alloca i32, align 4
  %tmp_2 = alloca i32, align 4
  %tmp_3 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_4 = alloca <4 x float> addrspace(1)*, align 4
  %tmp_5 = alloca <4 x float> addrspace(1)*, align 4
  %strikePrice = alloca <4 x float>, align 16
  %c1 = alloca <4 x float>, align 16
  %c2 = alloca <4 x float>, align 16
  %c3 = alloca <4 x float>, align 16
  %initPrice = alloca <4 x float>, align 16
  %sigma = alloca <4 x float>, align 16
  %timeStep = alloca <4 x float>, align 16
  %xPos = alloca i32, align 4
  %yPos = alloca i32, align 4
  %temp = alloca <4 x float>, align 16
  %price1 = alloca <4 x float>, align 16
  %price2 = alloca <4 x float>, align 16
  %pathDeriv1 = alloca <4 x float>, align 16
  %pathDeriv2 = alloca <4 x float>, align 16
  %trajPrice1 = alloca <4 x float>, align 16
  %trajPrice2 = alloca <4 x float>, align 16
  %sumPrice1 = alloca <4 x float>, align 16
  %sumPrice2 = alloca <4 x float>, align 16
  %meanPrice1 = alloca <4 x float>, align 16
  %meanPrice2 = alloca <4 x float>, align 16
  %sumDeriv1 = alloca <4 x float>, align 16
  %sumDeriv2 = alloca <4 x float>, align 16
  %meanDeriv1 = alloca <4 x float>, align 16
  %meanDeriv2 = alloca <4 x float>, align 16
  %finalRandf1 = alloca <4 x float>, align 16
  %finalRandf2 = alloca <4 x float>, align 16
  %nextRand = alloca <4 x i32>, align 16
  %i = alloca i32, align 4
  %tempRand = alloca <4 x i32>, align 16
  store i32 %noOfSum, i32* %tmp_1, align 4
  store i32 %width, i32* %tmp_2, align 4
  store <4 x i32> addrspace(1)* %randArray, <4 x i32> addrspace(1)** %tmp_3, align 4
  store <4 x float> addrspace(1)* %priceSamples, <4 x float> addrspace(1)** %tmp_4, align 4
  store <4 x float> addrspace(1)* %pathDeriv, <4 x float> addrspace(1)** %tmp_5, align 4
  %tmp_6 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 0
  %tmp_7 = load <4 x float>* %tmp_6, align 16
  store <4 x float> %tmp_7, <4 x float>* %strikePrice, align 16
  %tmp_8 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 1
  %tmp_9 = load <4 x float>* %tmp_8, align 16
  store <4 x float> %tmp_9, <4 x float>* %c1, align 16
  %tmp_10 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 2
  %tmp_11 = load <4 x float>* %tmp_10, align 16
  store <4 x float> %tmp_11, <4 x float>* %c2, align 16
  %tmp_12 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 3
  %tmp_13 = load <4 x float>* %tmp_12, align 16
  store <4 x float> %tmp_13, <4 x float>* %c3, align 16
  %tmp_14 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 4
  %tmp_15 = load <4 x float>* %tmp_14, align 16
  store <4 x float> %tmp_15, <4 x float>* %initPrice, align 16
  %tmp_16 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 5
  %tmp_17 = load <4 x float>* %tmp_16, align 16
  store <4 x float> %tmp_17, <4 x float>* %sigma, align 16
  %tmp_18 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 6
  %tmp_19 = load <4 x float>* %tmp_18, align 16
  store <4 x float> %tmp_19, <4 x float>* %timeStep, align 16
  %tmp_20 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_20, i32* %xPos, align 4
  %tmp_21 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_21, i32* %yPos, align 4
  store <4 x float> zeroinitializer, <4 x float>* %temp, align 16
  store <4 x float> zeroinitializer, <4 x float>* %price1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %price2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %pathDeriv1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %pathDeriv2, align 16
  %tmp_22 = load <4 x float>* %initPrice, align 16
  store <4 x float> %tmp_22, <4 x float>* %trajPrice1, align 16
  %tmp_23 = load <4 x float>* %initPrice, align 16
  store <4 x float> %tmp_23, <4 x float>* %trajPrice2, align 16
  %tmp_24 = load <4 x float>* %initPrice, align 16
  store <4 x float> %tmp_24, <4 x float>* %sumPrice1, align 16
  %tmp_25 = load <4 x float>* %initPrice, align 16
  store <4 x float> %tmp_25, <4 x float>* %sumPrice2, align 16
  %tmp_26 = load <4 x float>* %temp, align 16
  store <4 x float> %tmp_26, <4 x float>* %meanPrice1, align 16
  %tmp_27 = load <4 x float>* %temp, align 16
  store <4 x float> %tmp_27, <4 x float>* %meanPrice2, align 16
  %tmp_28 = load <4 x float>* %temp, align 16
  store <4 x float> %tmp_28, <4 x float>* %sumDeriv1, align 16
  %tmp_29 = load <4 x float>* %temp, align 16
  store <4 x float> %tmp_29, <4 x float>* %sumDeriv2, align 16
  %tmp_30 = load <4 x float>* %temp, align 16
  store <4 x float> %tmp_30, <4 x float>* %meanDeriv1, align 16
  %tmp_31 = load <4 x float>* %temp, align 16
  store <4 x float> %tmp_31, <4 x float>* %meanDeriv2, align 16
  %tmp_32 = load <4 x float>* %temp, align 16
  store <4 x float> %tmp_32, <4 x float>* %finalRandf1, align 16
  %tmp_33 = load <4 x float>* %temp, align 16
  store <4 x float> %tmp_33, <4 x float>* %finalRandf2, align 16
  %tmp_34 = load i32* %yPos, align 4
  %tmp_35 = load i32* %tmp_2, align 4
  %tmp_36 = mul i32 %tmp_34, %tmp_35
  %tmp_37 = load i32* %xPos, align 4
  %tmp_38 = add i32 %tmp_36, %tmp_37
  %tmp_39 = load <4 x i32> addrspace(1)** %tmp_3, align 4
  %tmp_40 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_39, i32 %tmp_38
  %tmp_41 = load <4 x i32> addrspace(1)* %tmp_40, align 16
  store <4 x i32> %tmp_41, <4 x i32>* %nextRand, align 16
  store i32 1, i32* %i, align 4
  br label %tmp_42

tmp_42:                                      ; preds = %tmp_101, %tmp_0
  %tmp_43 = load i32* %i, align 4
  %tmp_44 = load i32* %tmp_1, align 4
  %tmp_45 = icmp slt i32 %tmp_43, %tmp_44
  br i1 %tmp_45, label %tmp_46, label %tmp_104

tmp_46:                                      ; preds = %tmp_42
  %tmp_47 = load <4 x i32>* %nextRand, align 16
  store <4 x i32> %tmp_47, <4 x i32>* %tempRand, align 16
  %tmp_48 = load <4 x i32>* %tempRand, align 16
  call void @generateRand(<4 x i32> %tmp_48, <4 x float>* %finalRandf1, <4 x float>* %finalRandf2, <4 x i32>* %nextRand)
  %tmp_49 = load <4 x float>* %trajPrice1, align 16
  %tmp_50 = load <4 x float>* %c1, align 16
  %tmp_51 = load <4 x float>* %c2, align 16
  %tmp_52 = load <4 x float>* %finalRandf1, align 16
  %tmp_53 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_51, <4 x float> %tmp_52, <4 x float> %tmp_50)
  %tmp_54 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_53)
  %tmp_55 = fmul <4 x float> %tmp_49, %tmp_54
  store <4 x float> %tmp_55, <4 x float>* %trajPrice1, align 16
  %tmp_56 = load <4 x float>* %trajPrice2, align 16
  %tmp_57 = load <4 x float>* %c1, align 16
  %tmp_58 = load <4 x float>* %c2, align 16
  %tmp_59 = load <4 x float>* %finalRandf2, align 16
  %tmp_60 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_58, <4 x float> %tmp_59, <4 x float> %tmp_57)
  %tmp_61 = call <4 x float> @_Z3expDv4_f(<4 x float> %tmp_60)
  %tmp_62 = fmul <4 x float> %tmp_56, %tmp_61
  store <4 x float> %tmp_62, <4 x float>* %trajPrice2, align 16
  %tmp_63 = load <4 x float>* %sumPrice1, align 16
  %tmp_64 = load <4 x float>* %trajPrice1, align 16
  %tmp_65 = fadd <4 x float> %tmp_63, %tmp_64
  store <4 x float> %tmp_65, <4 x float>* %sumPrice1, align 16
  %tmp_66 = load <4 x float>* %sumPrice2, align 16
  %tmp_67 = load <4 x float>* %trajPrice2, align 16
  %tmp_68 = fadd <4 x float> %tmp_66, %tmp_67
  store <4 x float> %tmp_68, <4 x float>* %sumPrice2, align 16
  %tmp_69 = load <4 x float>* %c3, align 16
  %tmp_70 = load <4 x float>* %timeStep, align 16
  %tmp_71 = fmul <4 x float> %tmp_69, %tmp_70
  %tmp_72 = load i32* %i, align 4
  %tmp_73 = sitofp i32 %tmp_72 to float
  %tmp_74 = insertelement <4 x float> undef, float %tmp_73, i32 0
  %tmp_75 = shufflevector <4 x float> %tmp_74, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_76 = fmul <4 x float> %tmp_71, %tmp_75
  store <4 x float> %tmp_76, <4 x float>* %temp, align 16
  %tmp_77 = load <4 x float>* %sumDeriv1, align 16
  %tmp_78 = load <4 x float>* %trajPrice1, align 16
  %tmp_79 = load <4 x float>* %trajPrice1, align 16
  %tmp_80 = load <4 x float>* %initPrice, align 16
  %tmp_81 = fdiv <4 x float> %tmp_79, %tmp_80, !fpmath !2
  %tmp_82 = call <4 x float> @llvm.log2.v4f32(<4 x float> %tmp_81)
  %tmp_83 = load <4 x float>* %temp, align 16
  %tmp_84 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_83
  %tmp_85 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_82, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %tmp_84)
  %tmp_86 = load <4 x float>* %sigma, align 16
  %tmp_87 = fdiv <4 x float> %tmp_85, %tmp_86, !fpmath !2
  %tmp_88 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_78, <4 x float> %tmp_87, <4 x float> %tmp_77)
  store <4 x float> %tmp_88, <4 x float>* %sumDeriv1, align 16
  %tmp_89 = load <4 x float>* %sumDeriv2, align 16
  %tmp_90 = load <4 x float>* %trajPrice2, align 16
  %tmp_91 = load <4 x float>* %trajPrice2, align 16
  %tmp_92 = load <4 x float>* %initPrice, align 16
  %tmp_93 = fdiv <4 x float> %tmp_91, %tmp_92, !fpmath !2
  %tmp_94 = call <4 x float> @llvm.log2.v4f32(<4 x float> %tmp_93)
  %tmp_95 = load <4 x float>* %temp, align 16
  %tmp_96 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %tmp_95
  %tmp_97 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_94, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %tmp_96)
  %tmp_98 = load <4 x float>* %sigma, align 16
  %tmp_99 = fdiv <4 x float> %tmp_97, %tmp_98, !fpmath !2
  %tmp_100 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %tmp_90, <4 x float> %tmp_99, <4 x float> %tmp_89)
  store <4 x float> %tmp_100, <4 x float>* %sumDeriv2, align 16
  br label %tmp_101

tmp_101:                                     ; preds = %tmp_46
  %tmp_102 = load i32* %i, align 4
  %tmp_103 = add nsw i32 %tmp_102, 1
  store i32 %tmp_103, i32* %i, align 4
  br label %tmp_42

tmp_104:                                     ; preds = %tmp_42
  %tmp_105 = load <4 x float>* %sumPrice1, align 16
  %tmp_106 = load i32* %tmp_1, align 4
  %tmp_107 = sitofp i32 %tmp_106 to float
  %tmp_108 = insertelement <4 x float> undef, float %tmp_107, i32 0
  %tmp_109 = shufflevector <4 x float> %tmp_108, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_110 = fdiv <4 x float> %tmp_105, %tmp_109, !fpmath !2
  store <4 x float> %tmp_110, <4 x float>* %meanPrice1, align 16
  %tmp_111 = load <4 x float>* %sumPrice2, align 16
  %tmp_112 = load i32* %tmp_1, align 4
  %tmp_113 = sitofp i32 %tmp_112 to float
  %tmp_114 = insertelement <4 x float> undef, float %tmp_113, i32 0
  %tmp_115 = shufflevector <4 x float> %tmp_114, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_116 = fdiv <4 x float> %tmp_111, %tmp_115, !fpmath !2
  store <4 x float> %tmp_116, <4 x float>* %meanPrice2, align 16
  %tmp_117 = load <4 x float>* %sumDeriv1, align 16
  %tmp_118 = load i32* %tmp_1, align 4
  %tmp_119 = sitofp i32 %tmp_118 to float
  %tmp_120 = insertelement <4 x float> undef, float %tmp_119, i32 0
  %tmp_121 = shufflevector <4 x float> %tmp_120, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_122 = fdiv <4 x float> %tmp_117, %tmp_121, !fpmath !2
  store <4 x float> %tmp_122, <4 x float>* %meanDeriv1, align 16
  %tmp_123 = load <4 x float>* %sumDeriv2, align 16
  %tmp_124 = load i32* %tmp_1, align 4
  %tmp_125 = sitofp i32 %tmp_124 to float
  %tmp_126 = insertelement <4 x float> undef, float %tmp_125, i32 0
  %tmp_127 = shufflevector <4 x float> %tmp_126, <4 x float> undef, <4 x i32> zeroinitializer
  %tmp_128 = fdiv <4 x float> %tmp_123, %tmp_127, !fpmath !2
  store <4 x float> %tmp_128, <4 x float>* %meanDeriv2, align 16
  %tmp_129 = load <4 x float>* %strikePrice, align 16
  %tmp_130 = load <4 x float>* %meanDeriv1, align 16
  %tmp_131 = load <4 x float>* %meanDeriv2, align 16
  %tmp_132 = load <4 x float>* %meanPrice1, align 16
  %tmp_133 = load <4 x float>* %meanPrice2, align 16
  call void @calOutputs(<4 x float> %tmp_129, <4 x float> %tmp_130, <4 x float> %tmp_131, <4 x float> %tmp_132, <4 x float> %tmp_133, <4 x float>* %pathDeriv1, <4 x float>* %pathDeriv2, <4 x float>* %price1, <4 x float>* %price2)
  %tmp_134 = load <4 x float>* %price1, align 16
  %tmp_135 = load i32* %yPos, align 4
  %tmp_136 = load i32* %tmp_2, align 4
  %tmp_137 = mul i32 %tmp_135, %tmp_136
  %tmp_138 = load i32* %xPos, align 4
  %tmp_139 = add i32 %tmp_137, %tmp_138
  %tmp_140 = mul i32 %tmp_139, 2
  %tmp_141 = load <4 x float> addrspace(1)** %tmp_4, align 4
  %tmp_142 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_141, i32 %tmp_140
  store <4 x float> %tmp_134, <4 x float> addrspace(1)* %tmp_142, align 16
  %tmp_143 = load <4 x float>* %price2, align 16
  %tmp_144 = load i32* %yPos, align 4
  %tmp_145 = load i32* %tmp_2, align 4
  %tmp_146 = mul i32 %tmp_144, %tmp_145
  %tmp_147 = load i32* %xPos, align 4
  %tmp_148 = add i32 %tmp_146, %tmp_147
  %tmp_149 = mul i32 %tmp_148, 2
  %tmp_150 = add i32 %tmp_149, 1
  %tmp_151 = load <4 x float> addrspace(1)** %tmp_4, align 4
  %tmp_152 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_151, i32 %tmp_150
  store <4 x float> %tmp_143, <4 x float> addrspace(1)* %tmp_152, align 16
  %tmp_153 = load <4 x float>* %pathDeriv1, align 16
  %tmp_154 = load i32* %yPos, align 4
  %tmp_155 = load i32* %tmp_2, align 4
  %tmp_156 = mul i32 %tmp_154, %tmp_155
  %tmp_157 = load i32* %xPos, align 4
  %tmp_158 = add i32 %tmp_156, %tmp_157
  %tmp_159 = mul i32 %tmp_158, 2
  %tmp_160 = load <4 x float> addrspace(1)** %tmp_5, align 4
  %tmp_161 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_160, i32 %tmp_159
  store <4 x float> %tmp_153, <4 x float> addrspace(1)* %tmp_161, align 16
  %tmp_162 = load <4 x float>* %pathDeriv2, align 16
  %tmp_163 = load i32* %yPos, align 4
  %tmp_164 = load i32* %tmp_2, align 4
  %tmp_165 = mul i32 %tmp_163, %tmp_164
  %tmp_166 = load i32* %xPos, align 4
  %tmp_167 = add i32 %tmp_165, %tmp_166
  %tmp_168 = mul i32 %tmp_167, 2
  %tmp_169 = add i32 %tmp_168, 1
  %tmp_170 = load <4 x float> addrspace(1)** %tmp_5, align 4
  %tmp_171 = getelementptr inbounds <4 x float> addrspace(1)* %tmp_170, i32 %tmp_169
  store <4 x float> %tmp_162, <4 x float> addrspace(1)* %tmp_171, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #3

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind readnone }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (%struct._MonteCalroAttrib*, i32, i32, <4 x i32> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @calPriceVega}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

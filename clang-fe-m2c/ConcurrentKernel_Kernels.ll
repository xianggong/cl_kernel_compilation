; ModuleID = '../kernel-src/ConcurrentKernel_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@K2.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K4.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K6.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K8.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K10.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1

; Function Attrs: nounwind
define void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %gSize = alloca i32, align 4
  %gId = alloca i32, align 4
  %lId = alloca i32, align 4
  %tmp = alloca i32, align 4
  %zero = alloca i32, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_5, i32* %gSize, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_6, i32* %gId, align 4
  %tmp_7 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_7, i32* %lId, align 4
  store i32 1, i32* %tmp, align 4
  store volatile i32 0, i32* %zero, align 4
  store i32 1, i32* %i, align 4
  br label %tmp_8

tmp_8:                                       ; preds = %tmp_58, %tmp_0
  %tmp_9 = load i32* %i, align 4
  %tmp_10 = icmp slt i32 %tmp_9, 5000
  br i1 %tmp_10, label %tmp_11, label %tmp_61

tmp_11:                                      ; preds = %tmp_8
  %tmp_12 = load i32* %i, align 4
  %tmp_13 = mul nsw i32 %tmp_12, 1
  %tmp_14 = load i32* %tmp_3, align 4
  %tmp_15 = urem i32 %tmp_13, %tmp_14
  %tmp_16 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_17 = getelementptr inbounds i8 addrspace(1)* %tmp_16, i32 %tmp_15
  %tmp_18 = load i8 addrspace(1)* %tmp_17, align 1
  %tmp_19 = zext i8 %tmp_18 to i32
  %tmp_20 = load i32* %i, align 4
  %tmp_21 = mul nsw i32 %tmp_20, 2
  %tmp_22 = load i32* %tmp_3, align 4
  %tmp_23 = urem i32 %tmp_21, %tmp_22
  %tmp_24 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_25 = getelementptr inbounds i8 addrspace(1)* %tmp_24, i32 %tmp_23
  %tmp_26 = load i8 addrspace(1)* %tmp_25, align 1
  %tmp_27 = zext i8 %tmp_26 to i32
  %tmp_28 = add nsw i32 %tmp_19, %tmp_27
  %tmp_29 = load i32* %i, align 4
  %tmp_30 = mul nsw i32 %tmp_29, 3
  %tmp_31 = load i32* %tmp_3, align 4
  %tmp_32 = urem i32 %tmp_30, %tmp_31
  %tmp_33 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_34 = getelementptr inbounds i8 addrspace(1)* %tmp_33, i32 %tmp_32
  %tmp_35 = load i8 addrspace(1)* %tmp_34, align 1
  %tmp_36 = zext i8 %tmp_35 to i32
  %tmp_37 = add nsw i32 %tmp_28, %tmp_36
  %tmp_38 = load i32* %i, align 4
  %tmp_39 = mul nsw i32 %tmp_38, 4
  %tmp_40 = load i32* %tmp_3, align 4
  %tmp_41 = urem i32 %tmp_39, %tmp_40
  %tmp_42 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_43 = getelementptr inbounds i8 addrspace(1)* %tmp_42, i32 %tmp_41
  %tmp_44 = load i8 addrspace(1)* %tmp_43, align 1
  %tmp_45 = zext i8 %tmp_44 to i32
  %tmp_46 = add nsw i32 %tmp_37, %tmp_45
  %tmp_47 = load i32* %i, align 4
  %tmp_48 = mul nsw i32 %tmp_47, 5
  %tmp_49 = load i32* %tmp_3, align 4
  %tmp_50 = urem i32 %tmp_48, %tmp_49
  %tmp_51 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_52 = getelementptr inbounds i8 addrspace(1)* %tmp_51, i32 %tmp_50
  %tmp_53 = load i8 addrspace(1)* %tmp_52, align 1
  %tmp_54 = zext i8 %tmp_53 to i32
  %tmp_55 = add nsw i32 %tmp_46, %tmp_54
  %tmp_56 = load i32* %tmp, align 4
  %tmp_57 = add i32 %tmp_56, %tmp_55
  store i32 %tmp_57, i32* %tmp, align 4
  br label %tmp_58

tmp_58:                                      ; preds = %tmp_11
  %tmp_59 = load i32* %i, align 4
  %tmp_60 = add nsw i32 %tmp_59, 1
  store i32 %tmp_60, i32* %i, align 4
  br label %tmp_8

tmp_61:                                      ; preds = %tmp_8
  %tmp_62 = load i32* %gId, align 4
  store i32 %tmp_62, i32* %i1, align 4
  br label %tmp_63

tmp_63:                                      ; preds = %tmp_84, %tmp_61
  %tmp_64 = load i32* %i1, align 4
  %tmp_65 = load i32* %tmp_3, align 4
  %tmp_66 = icmp ult i32 %tmp_64, %tmp_65
  br i1 %tmp_66, label %tmp_67, label %tmp_88

tmp_67:                                      ; preds = %tmp_63
  %tmp_68 = load i32* %i1, align 4
  %tmp_69 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_70 = getelementptr inbounds i8 addrspace(1)* %tmp_69, i32 %tmp_68
  %tmp_71 = load i8 addrspace(1)* %tmp_70, align 1
  %tmp_72 = zext i8 %tmp_71 to i32
  %tmp_73 = load i32* %tmp_4, align 4
  %tmp_74 = mul nsw i32 %tmp_72, %tmp_73
  %tmp_75 = srem i32 %tmp_74, 256
  %tmp_76 = load volatile i32* %zero, align 4
  %tmp_77 = load i32* %tmp, align 4
  %tmp_78 = mul i32 %tmp_76, %tmp_77
  %tmp_79 = add i32 %tmp_75, %tmp_78
  %tmp_80 = trunc i32 %tmp_79 to i8
  %tmp_81 = load i32* %i1, align 4
  %tmp_82 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_83 = getelementptr inbounds i8 addrspace(1)* %tmp_82, i32 %tmp_81
  store i8 %tmp_80, i8 addrspace(1)* %tmp_83, align 1
  br label %tmp_84

tmp_84:                                      ; preds = %tmp_67
  %tmp_85 = load i32* %gSize, align 4
  %tmp_86 = load i32* %i1, align 4
  %tmp_87 = add i32 %tmp_86, %tmp_85
  store i32 %tmp_87, i32* %i1, align 4
  br label %tmp_63

tmp_88:                                      ; preds = %tmp_63
  ret void
}

declare i32 @__get_global_size_u32(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

; Function Attrs: nounwind
define void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* %lds) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i8 addrspace(3)*, align 4
  %gSize = alloca i32, align 4
  %gId = alloca i32, align 4
  %lId = alloca i32, align 4
  %tmp = alloca i32, align 4
  %zero = alloca i32, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  store i8 addrspace(3)* %lds, i8 addrspace(3)** %tmp_5, align 4
  %tmp_6 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_6, i32* %gSize, align 4
  %tmp_7 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_7, i32* %gId, align 4
  %tmp_8 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_8, i32* %lId, align 4
  store i32 1, i32* %tmp, align 4
  store volatile i32 0, i32* %zero, align 4
  store i32 1, i32* %i, align 4
  br label %tmp_9

tmp_9:                                       ; preds = %tmp_59, %tmp_0
  %tmp_10 = load i32* %i, align 4
  %tmp_11 = icmp slt i32 %tmp_10, 10000
  br i1 %tmp_11, label %tmp_12, label %tmp_62

tmp_12:                                      ; preds = %tmp_9
  %tmp_13 = load i32* %i, align 4
  %tmp_14 = mul nsw i32 %tmp_13, 2
  %tmp_15 = load i32* %tmp_3, align 4
  %tmp_16 = urem i32 %tmp_14, %tmp_15
  %tmp_17 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_18 = getelementptr inbounds i8 addrspace(1)* %tmp_17, i32 %tmp_16
  %tmp_19 = load i8 addrspace(1)* %tmp_18, align 1
  %tmp_20 = zext i8 %tmp_19 to i32
  %tmp_21 = load i32* %i, align 4
  %tmp_22 = mul nsw i32 %tmp_21, 4
  %tmp_23 = load i32* %tmp_3, align 4
  %tmp_24 = urem i32 %tmp_22, %tmp_23
  %tmp_25 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_26 = getelementptr inbounds i8 addrspace(1)* %tmp_25, i32 %tmp_24
  %tmp_27 = load i8 addrspace(1)* %tmp_26, align 1
  %tmp_28 = zext i8 %tmp_27 to i32
  %tmp_29 = sub nsw i32 %tmp_20, %tmp_28
  %tmp_30 = load i32* %i, align 4
  %tmp_31 = mul nsw i32 %tmp_30, 6
  %tmp_32 = load i32* %tmp_3, align 4
  %tmp_33 = urem i32 %tmp_31, %tmp_32
  %tmp_34 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_35 = getelementptr inbounds i8 addrspace(1)* %tmp_34, i32 %tmp_33
  %tmp_36 = load i8 addrspace(1)* %tmp_35, align 1
  %tmp_37 = zext i8 %tmp_36 to i32
  %tmp_38 = add nsw i32 %tmp_29, %tmp_37
  %tmp_39 = load i32* %i, align 4
  %tmp_40 = mul nsw i32 %tmp_39, 8
  %tmp_41 = load i32* %tmp_3, align 4
  %tmp_42 = urem i32 %tmp_40, %tmp_41
  %tmp_43 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_44 = getelementptr inbounds i8 addrspace(1)* %tmp_43, i32 %tmp_42
  %tmp_45 = load i8 addrspace(1)* %tmp_44, align 1
  %tmp_46 = zext i8 %tmp_45 to i32
  %tmp_47 = sub nsw i32 %tmp_38, %tmp_46
  %tmp_48 = load i32* %i, align 4
  %tmp_49 = mul nsw i32 %tmp_48, 10
  %tmp_50 = load i32* %tmp_3, align 4
  %tmp_51 = urem i32 %tmp_49, %tmp_50
  %tmp_52 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_53 = getelementptr inbounds i8 addrspace(1)* %tmp_52, i32 %tmp_51
  %tmp_54 = load i8 addrspace(1)* %tmp_53, align 1
  %tmp_55 = zext i8 %tmp_54 to i32
  %tmp_56 = add nsw i32 %tmp_47, %tmp_55
  %tmp_57 = load i32* %tmp, align 4
  %tmp_58 = add nsw i32 %tmp_57, %tmp_56
  store i32 %tmp_58, i32* %tmp, align 4
  br label %tmp_59

tmp_59:                                      ; preds = %tmp_12
  %tmp_60 = load i32* %i, align 4
  %tmp_61 = add nsw i32 %tmp_60, 1
  store i32 %tmp_61, i32* %i, align 4
  br label %tmp_9

tmp_62:                                      ; preds = %tmp_9
  %tmp_63 = load i32* %gId, align 4
  store i32 %tmp_63, i32* %i1, align 4
  br label %tmp_64

tmp_64:                                      ; preds = %tmp_92, %tmp_62
  %tmp_65 = load i32* %i1, align 4
  %tmp_66 = load i32* %tmp_3, align 4
  %tmp_67 = icmp ult i32 %tmp_65, %tmp_66
  br i1 %tmp_67, label %tmp_68, label %tmp_96

tmp_68:                                      ; preds = %tmp_64
  %tmp_69 = load i32* %i1, align 4
  %tmp_70 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_71 = getelementptr inbounds i8 addrspace(1)* %tmp_70, i32 %tmp_69
  %tmp_72 = load i8 addrspace(1)* %tmp_71, align 1
  %tmp_73 = load i32* %lId, align 4
  %tmp_74 = load i8 addrspace(3)** %tmp_5, align 4
  %tmp_75 = getelementptr inbounds i8 addrspace(3)* %tmp_74, i32 %tmp_73
  store i8 %tmp_72, i8 addrspace(3)* %tmp_75, align 1
  %tmp_76 = load i32* %lId, align 4
  %tmp_77 = load i8 addrspace(3)** %tmp_5, align 4
  %tmp_78 = getelementptr inbounds i8 addrspace(3)* %tmp_77, i32 %tmp_76
  %tmp_79 = load i8 addrspace(3)* %tmp_78, align 1
  %tmp_80 = zext i8 %tmp_79 to i32
  %tmp_81 = load i32* %tmp_4, align 4
  %tmp_82 = mul nsw i32 %tmp_80, %tmp_81
  %tmp_83 = srem i32 %tmp_82, 256
  %tmp_84 = load volatile i32* %zero, align 4
  %tmp_85 = load i32* %tmp, align 4
  %tmp_86 = mul nsw i32 %tmp_84, %tmp_85
  %tmp_87 = add nsw i32 %tmp_83, %tmp_86
  %tmp_88 = trunc i32 %tmp_87 to i8
  %tmp_89 = load i32* %i1, align 4
  %tmp_90 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_91 = getelementptr inbounds i8 addrspace(1)* %tmp_90, i32 %tmp_89
  store i8 %tmp_88, i8 addrspace(1)* %tmp_91, align 1
  br label %tmp_92

tmp_92:                                      ; preds = %tmp_68
  %tmp_93 = load i32* %gSize, align 4
  %tmp_94 = load i32* %i1, align 4
  %tmp_95 = add i32 %tmp_94, %tmp_93
  store i32 %tmp_95, i32* %i1, align 4
  br label %tmp_64

tmp_96:                                      ; preds = %tmp_64
  ret void
}

; Function Attrs: nounwind
define void @K1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_6 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_7 = load i32* %tmp_3, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  call void @work1(i8 addrspace(1)* %tmp_5, i8 addrspace(1)* %tmp_6, i32 %tmp_7, i32 %tmp_8)
  ret void
}

; Function Attrs: nounwind
define void @K2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_6 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_7 = load i32* %tmp_3, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  call void @work2(i8 addrspace(1)* %tmp_5, i8 addrspace(1)* %tmp_6, i32 %tmp_7, i32 %tmp_8, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K2.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K3(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_6 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_7 = load i32* %tmp_3, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  call void @work1(i8 addrspace(1)* %tmp_5, i8 addrspace(1)* %tmp_6, i32 %tmp_7, i32 %tmp_8)
  ret void
}

; Function Attrs: nounwind
define void @K4(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_6 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_7 = load i32* %tmp_3, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  call void @work2(i8 addrspace(1)* %tmp_5, i8 addrspace(1)* %tmp_6, i32 %tmp_7, i32 %tmp_8, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K4.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K5(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_6 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_7 = load i32* %tmp_3, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  call void @work1(i8 addrspace(1)* %tmp_5, i8 addrspace(1)* %tmp_6, i32 %tmp_7, i32 %tmp_8)
  ret void
}

; Function Attrs: nounwind
define void @K6(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_6 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_7 = load i32* %tmp_3, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  call void @work2(i8 addrspace(1)* %tmp_5, i8 addrspace(1)* %tmp_6, i32 %tmp_7, i32 %tmp_8, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K6.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K7(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_6 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_7 = load i32* %tmp_3, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  call void @work1(i8 addrspace(1)* %tmp_5, i8 addrspace(1)* %tmp_6, i32 %tmp_7, i32 %tmp_8)
  ret void
}

; Function Attrs: nounwind
define void @K8(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_6 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_7 = load i32* %tmp_3, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  call void @work2(i8 addrspace(1)* %tmp_5, i8 addrspace(1)* %tmp_6, i32 %tmp_7, i32 %tmp_8, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K8.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K9(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_6 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_7 = load i32* %tmp_3, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  call void @work1(i8 addrspace(1)* %tmp_5, i8 addrspace(1)* %tmp_6, i32 %tmp_7, i32 %tmp_8)
  ret void
}

; Function Attrs: nounwind
define void @K10(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %tmp_1 = alloca i8 addrspace(1)*, align 4
  %tmp_2 = alloca i8 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %tmp_1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %tmp_2, align 4
  store i32 %bufferSize, i32* %tmp_3, align 4
  store i32 %multiplier, i32* %tmp_4, align 4
  %tmp_5 = load i8 addrspace(1)** %tmp_1, align 4
  %tmp_6 = load i8 addrspace(1)** %tmp_2, align 4
  %tmp_7 = load i32* %tmp_3, align 4
  %tmp_8 = load i32* %tmp_4, align 4
  call void @work2(i8 addrspace(1)* %tmp_5, i8 addrspace(1)* %tmp_6, i32 %tmp_7, i32 %tmp_8, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K10.lds, i32 0, i32 0))
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9}
!llvm.ident = !{!10}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K1}
!1 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K2}
!2 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K3}
!3 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K4}
!4 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K5}
!5 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K6}
!6 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K7}
!7 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K8}
!8 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K9}
!9 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K10}
!10 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

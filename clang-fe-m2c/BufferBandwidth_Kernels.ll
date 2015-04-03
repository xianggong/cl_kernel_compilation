; ModuleID = '../kernel-src/BufferBandwidth_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@read_kernel.lcount = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define void @read_kernel(<4 x i32> addrspace(1)* %in, i32 addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %tmp_1 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i32, align 4
  %pcount = alloca i32, align 4
  %i = alloca i32, align 4
  %idx = alloca i32, align 4
  %n = alloca i32, align 4
  store <4 x i32> addrspace(1)* %in, <4 x i32> addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %out, i32 addrspace(1)** %tmp_2, align 4
  store i32 %ni, i32* %tmp_3, align 4
  store i32 %val, i32* %tmp_4, align 4
  store i32 %nk, i32* %tmp_5, align 4
  %tmp_6 = load i32* %tmp_5, align 4
  %tmp_7 = icmp eq i32 %tmp_6, 0
  br i1 %tmp_7, label %tmp_8, label %tmp_9

tmp_8:                                       ; preds = %tmp_0
  br label %tmp_91

tmp_9:                                       ; preds = %tmp_0
  store i32 0, i32* %pcount, align 4
  %tmp_10 = call i32 @__get_local_id_u32(i32 0)
  %tmp_11 = icmp eq i32 %tmp_10, 0
  br i1 %tmp_11, label %tmp_12, label %tmp_13

tmp_12:                                      ; preds = %tmp_9
  store i32 0, i32 addrspace(3)* @read_kernel.lcount, align 4
  br label %tmp_13

tmp_13:                                      ; preds = %tmp_12, %tmp_9
  call void @barrier(i32 1)
  store i32 0, i32* %n, align 4
  br label %tmp_14

tmp_14:                                      ; preds = %tmp_76, %tmp_13
  %tmp_15 = load i32* %n, align 4
  %tmp_16 = load i32* %tmp_5, align 4
  %tmp_17 = icmp ult i32 %tmp_15, %tmp_16
  br i1 %tmp_17, label %tmp_18, label %tmp_79

tmp_18:                                      ; preds = %tmp_14
  store i32 0, i32* %i, align 4
  %tmp_19 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_19, i32* %idx, align 4
  br label %tmp_20

tmp_20:                                      ; preds = %tmp_69, %tmp_18
  %tmp_21 = load i32* %i, align 4
  %tmp_22 = load i32* %tmp_3, align 4
  %tmp_23 = icmp ult i32 %tmp_21, %tmp_22
  br i1 %tmp_23, label %tmp_24, label %tmp_75

tmp_24:                                      ; preds = %tmp_20
  %tmp_25 = load i32* %idx, align 4
  %tmp_26 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_27 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_26, i32 %tmp_25
  %tmp_28 = load <4 x i32> addrspace(1)* %tmp_27, align 16
  %tmp_29 = extractelement <4 x i32> %tmp_28, i32 0
  %tmp_30 = load i32* %tmp_4, align 4
  %tmp_31 = icmp eq i32 %tmp_29, %tmp_30
  br i1 %tmp_31, label %tmp_32, label %tmp_35

tmp_32:                                      ; preds = %tmp_24
  %tmp_33 = load i32* %pcount, align 4
  %tmp_34 = add i32 %tmp_33, 1
  store i32 %tmp_34, i32* %pcount, align 4
  br label %tmp_35

tmp_35:                                      ; preds = %tmp_32, %tmp_24
  %tmp_36 = load i32* %idx, align 4
  %tmp_37 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_38 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_37, i32 %tmp_36
  %tmp_39 = load <4 x i32> addrspace(1)* %tmp_38, align 16
  %tmp_40 = extractelement <4 x i32> %tmp_39, i32 1
  %tmp_41 = load i32* %tmp_4, align 4
  %tmp_42 = icmp eq i32 %tmp_40, %tmp_41
  br i1 %tmp_42, label %tmp_43, label %tmp_46

tmp_43:                                      ; preds = %tmp_35
  %tmp_44 = load i32* %pcount, align 4
  %tmp_45 = add i32 %tmp_44, 1
  store i32 %tmp_45, i32* %pcount, align 4
  br label %tmp_46

tmp_46:                                      ; preds = %tmp_43, %tmp_35
  %tmp_47 = load i32* %idx, align 4
  %tmp_48 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_49 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_48, i32 %tmp_47
  %tmp_50 = load <4 x i32> addrspace(1)* %tmp_49, align 16
  %tmp_51 = extractelement <4 x i32> %tmp_50, i32 2
  %tmp_52 = load i32* %tmp_4, align 4
  %tmp_53 = icmp eq i32 %tmp_51, %tmp_52
  br i1 %tmp_53, label %tmp_54, label %tmp_57

tmp_54:                                      ; preds = %tmp_46
  %tmp_55 = load i32* %pcount, align 4
  %tmp_56 = add i32 %tmp_55, 1
  store i32 %tmp_56, i32* %pcount, align 4
  br label %tmp_57

tmp_57:                                      ; preds = %tmp_54, %tmp_46
  %tmp_58 = load i32* %idx, align 4
  %tmp_59 = load <4 x i32> addrspace(1)** %tmp_1, align 4
  %tmp_60 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_59, i32 %tmp_58
  %tmp_61 = load <4 x i32> addrspace(1)* %tmp_60, align 16
  %tmp_62 = extractelement <4 x i32> %tmp_61, i32 3
  %tmp_63 = load i32* %tmp_4, align 4
  %tmp_64 = icmp eq i32 %tmp_62, %tmp_63
  br i1 %tmp_64, label %tmp_65, label %tmp_68

tmp_65:                                      ; preds = %tmp_57
  %tmp_66 = load i32* %pcount, align 4
  %tmp_67 = add i32 %tmp_66, 1
  store i32 %tmp_67, i32* %pcount, align 4
  br label %tmp_68

tmp_68:                                      ; preds = %tmp_65, %tmp_57
  br label %tmp_69

tmp_69:                                      ; preds = %tmp_68
  %tmp_70 = load i32* %i, align 4
  %tmp_71 = add i32 %tmp_70, 1
  store i32 %tmp_71, i32* %i, align 4
  %tmp_72 = call i32 @__get_global_size_u32(i32 0)
  %tmp_73 = load i32* %idx, align 4
  %tmp_74 = add i32 %tmp_73, %tmp_72
  store i32 %tmp_74, i32* %idx, align 4
  br label %tmp_20

tmp_75:                                      ; preds = %tmp_20
  br label %tmp_76

tmp_76:                                      ; preds = %tmp_75
  %tmp_77 = load i32* %n, align 4
  %tmp_78 = add nsw i32 %tmp_77, 1
  store i32 %tmp_78, i32* %n, align 4
  br label %tmp_14

tmp_79:                                      ; preds = %tmp_14
  %tmp_80 = load i32* %pcount, align 4
  %tmp_81 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @read_kernel.lcount, i32 %tmp_80)
  call void @barrier(i32 1)
  %tmp_82 = call i32 @__get_local_id_u32(i32 0)
  %tmp_83 = icmp eq i32 %tmp_82, 0
  br i1 %tmp_83, label %tmp_84, label %tmp_91

tmp_84:                                      ; preds = %tmp_79
  %tmp_85 = load i32 addrspace(3)* @read_kernel.lcount, align 4
  %tmp_86 = load i32* %tmp_5, align 4
  %tmp_87 = udiv i32 %tmp_85, %tmp_86
  %tmp_88 = call i32 @__get_group_id_u32(i32 0)
  %tmp_89 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_90 = getelementptr inbounds i32 addrspace(1)* %tmp_89, i32 %tmp_88
  store i32 %tmp_87, i32 addrspace(1)* %tmp_90, align 4
  br label %tmp_91

tmp_91:                                      ; preds = %tmp_8, %tmp_84, %tmp_79
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare void @barrier(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

declare i32 @__get_group_id_u32(i32) #1

; Function Attrs: nounwind
define void @write_kernel(i32 addrspace(1)* %in, <4 x i32> addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca <4 x i32> addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %tmp_5 = alloca i32, align 4
  %i = alloca i32, align 4
  %idx = alloca i32, align 4
  %pval = alloca <4 x i32>, align 16
  %tmp_6 = alloca <4 x i32>, align 16
  %n = alloca i32, align 4
  store i32 addrspace(1)* %in, i32 addrspace(1)** %tmp_1, align 4
  store <4 x i32> addrspace(1)* %out, <4 x i32> addrspace(1)** %tmp_2, align 4
  store i32 %ni, i32* %tmp_3, align 4
  store i32 %val, i32* %tmp_4, align 4
  store i32 %nk, i32* %tmp_5, align 4
  %tmp_7 = load i32* %tmp_5, align 4
  %tmp_8 = icmp eq i32 %tmp_7, 0
  br i1 %tmp_8, label %tmp_9, label %tmp_10

tmp_9:                                       ; preds = %tmp_0
  br label %tmp_45

tmp_10:                                      ; preds = %tmp_0
  %tmp_11 = load i32* %tmp_4, align 4
  %tmp_12 = insertelement <4 x i32> undef, i32 %tmp_11, i32 0
  %tmp_13 = load i32* %tmp_4, align 4
  %tmp_14 = insertelement <4 x i32> %tmp_12, i32 %tmp_13, i32 1
  %tmp_15 = load i32* %tmp_4, align 4
  %tmp_16 = insertelement <4 x i32> %tmp_14, i32 %tmp_15, i32 2
  %tmp_17 = load i32* %tmp_4, align 4
  %tmp_18 = insertelement <4 x i32> %tmp_16, i32 %tmp_17, i32 3
  store <4 x i32> %tmp_18, <4 x i32>* %tmp_6
  %tmp_19 = load <4 x i32>* %tmp_6
  store <4 x i32> %tmp_19, <4 x i32>* %pval, align 16
  store i32 0, i32* %n, align 4
  br label %tmp_20

tmp_20:                                      ; preds = %tmp_42, %tmp_10
  %tmp_21 = load i32* %n, align 4
  %tmp_22 = load i32* %tmp_5, align 4
  %tmp_23 = icmp ult i32 %tmp_21, %tmp_22
  br i1 %tmp_23, label %tmp_24, label %tmp_45

tmp_24:                                      ; preds = %tmp_20
  store i32 0, i32* %i, align 4
  %tmp_25 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_25, i32* %idx, align 4
  br label %tmp_26

tmp_26:                                      ; preds = %tmp_35, %tmp_24
  %tmp_27 = load i32* %i, align 4
  %tmp_28 = load i32* %tmp_3, align 4
  %tmp_29 = icmp ult i32 %tmp_27, %tmp_28
  br i1 %tmp_29, label %tmp_30, label %tmp_41

tmp_30:                                      ; preds = %tmp_26
  %tmp_31 = load <4 x i32>* %pval, align 16
  %tmp_32 = load i32* %idx, align 4
  %tmp_33 = load <4 x i32> addrspace(1)** %tmp_2, align 4
  %tmp_34 = getelementptr inbounds <4 x i32> addrspace(1)* %tmp_33, i32 %tmp_32
  store <4 x i32> %tmp_31, <4 x i32> addrspace(1)* %tmp_34, align 16
  br label %tmp_35

tmp_35:                                      ; preds = %tmp_30
  %tmp_36 = load i32* %i, align 4
  %tmp_37 = add i32 %tmp_36, 1
  store i32 %tmp_37, i32* %i, align 4
  %tmp_38 = call i32 @__get_global_size_u32(i32 0)
  %tmp_39 = load i32* %idx, align 4
  %tmp_40 = add i32 %tmp_39, %tmp_38
  store i32 %tmp_40, i32* %idx, align 4
  br label %tmp_26

tmp_41:                                      ; preds = %tmp_26
  br label %tmp_42

tmp_42:                                      ; preds = %tmp_41
  %tmp_43 = load i32* %n, align 4
  %tmp_44 = add nsw i32 %tmp_43, 1
  store i32 %tmp_44, i32* %n, align 4
  br label %tmp_20

tmp_45:                                      ; preds = %tmp_9, %tmp_20
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @read_kernel}
!1 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @write_kernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

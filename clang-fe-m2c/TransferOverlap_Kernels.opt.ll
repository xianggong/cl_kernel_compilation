; ModuleID = 'TransferOverlap_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@readKernel.lcount = internal addrspace(3) global i32 0, align 4
@writeKernel.lval = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define void @readKernel(<4 x i32> addrspace(1)* %in, i32 addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %tmp_6 = call i32 @__get_local_id_u32(i32 0)
  %tmp_7 = icmp eq i32 %tmp_6, 0
  br i1 %tmp_7, label %tmp_8, label %tmp_9

tmp_8:                                            ; preds = %0
  store i32 0, i32 addrspace(3)* @readKernel.lcount, align 4
  br label %tmp_9

tmp_9:                                            ; preds = %tmp_8, %0
  call void @barrier(i32 1)
  br label %tmp_10

tmp_10:                                           ; preds = %tmp_72, %tmp_9
  %pcount.0 = phi i32 [ 0, %tmp_9 ], [ %pcount.1, %tmp_72 ]
  %n.0 = phi i32 [ 0, %tmp_9 ], [ %tmp_74, %tmp_72 ]
  %tmp_13 = icmp ult i32 %n.0, %nk
  br i1 %tmp_13, label %tmp_14, label %tmp_75

tmp_14:                                           ; preds = %tmp_10
  %tmp_15 = call i32 @__get_global_id_u32(i32 0)
  br label %tmp_16

tmp_16:                                           ; preds = %tmp_65, %tmp_14
  %pcount.1 = phi i32 [ %pcount.0, %tmp_14 ], [ %pcount.5, %tmp_65 ]
  %i.0 = phi i32 [ 0, %tmp_14 ], [ %tmp_67, %tmp_65 ]
  %idx.0 = phi i32 [ %tmp_15, %tmp_14 ], [ %tmp_70, %tmp_65 ]
  %tmp_19 = icmp ult i32 %i.0, %ni
  br i1 %tmp_19, label %tmp_20, label %tmp_71

tmp_20:                                           ; preds = %tmp_16
  %tmp_23 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %tmp_24 = load volatile <4 x i32> addrspace(1)* %tmp_23, align 16
  %tmp_25 = extractelement <4 x i32> %tmp_24, i32 0
  %tmp_27 = icmp eq i32 %tmp_25, %val
  br i1 %tmp_27, label %tmp_28, label %tmp_31

tmp_28:                                           ; preds = %tmp_20
  %tmp_30 = add i32 %pcount.1, 1
  br label %tmp_31

tmp_31:                                           ; preds = %tmp_28, %tmp_20
  %pcount.2 = phi i32 [ %tmp_30, %tmp_28 ], [ %pcount.1, %tmp_20 ]
  %tmp_34 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %tmp_35 = load volatile <4 x i32> addrspace(1)* %tmp_34, align 16
  %tmp_36 = extractelement <4 x i32> %tmp_35, i32 1
  %tmp_38 = icmp eq i32 %tmp_36, %val
  br i1 %tmp_38, label %tmp_39, label %tmp_42

tmp_39:                                           ; preds = %tmp_31
  %tmp_41 = add i32 %pcount.2, 1
  br label %tmp_42

tmp_42:                                           ; preds = %tmp_39, %tmp_31
  %pcount.3 = phi i32 [ %tmp_41, %tmp_39 ], [ %pcount.2, %tmp_31 ]
  %tmp_45 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %tmp_46 = load volatile <4 x i32> addrspace(1)* %tmp_45, align 16
  %tmp_47 = extractelement <4 x i32> %tmp_46, i32 2
  %tmp_49 = icmp eq i32 %tmp_47, %val
  br i1 %tmp_49, label %tmp_50, label %tmp_53

tmp_50:                                           ; preds = %tmp_42
  %tmp_52 = add i32 %pcount.3, 1
  br label %tmp_53

tmp_53:                                           ; preds = %tmp_50, %tmp_42
  %pcount.4 = phi i32 [ %tmp_52, %tmp_50 ], [ %pcount.3, %tmp_42 ]
  %tmp_56 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %tmp_57 = load volatile <4 x i32> addrspace(1)* %tmp_56, align 16
  %tmp_58 = extractelement <4 x i32> %tmp_57, i32 3
  %tmp_60 = icmp eq i32 %tmp_58, %val
  br i1 %tmp_60, label %tmp_61, label %tmp_64

tmp_61:                                           ; preds = %tmp_53
  %tmp_63 = add i32 %pcount.4, 1
  br label %tmp_64

tmp_64:                                           ; preds = %tmp_61, %tmp_53
  %pcount.5 = phi i32 [ %tmp_63, %tmp_61 ], [ %pcount.4, %tmp_53 ]
  br label %tmp_65

tmp_65:                                           ; preds = %tmp_64
  %tmp_67 = add i32 %i.0, 1
  %tmp_68 = call i32 @__get_global_size_u32(i32 0)
  %tmp_70 = add i32 %idx.0, %tmp_68
  br label %tmp_16

tmp_71:                                           ; preds = %tmp_16
  br label %tmp_72

tmp_72:                                           ; preds = %tmp_71
  %tmp_74 = add nsw i32 %n.0, 1
  br label %tmp_10

tmp_75:                                           ; preds = %tmp_10
  %tmp_77 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @readKernel.lcount, i32 %pcount.0)
  call void @barrier(i32 1)
  %tmp_78 = call i32 @__get_local_id_u32(i32 0)
  %tmp_79 = icmp eq i32 %tmp_78, 0
  br i1 %tmp_79, label %tmp_80, label %tmp_87

tmp_80:                                           ; preds = %tmp_75
  %tmp_81 = load i32 addrspace(3)* @readKernel.lcount, align 4
  %tmp_83 = udiv i32 %tmp_81, %nk
  %tmp_84 = call i32 @__get_group_id_u32(i32 0)
  %tmp_86 = getelementptr inbounds i32 addrspace(1)* %out, i32 %tmp_84
  store volatile i32 %tmp_83, i32 addrspace(1)* %tmp_86, align 4
  br label %tmp_87

tmp_87:                                           ; preds = %tmp_80, %tmp_75
  %tmp_88 = call i32 @__get_global_id_u32(i32 0)
  %tmp_89 = icmp eq i32 %tmp_88, 0
  br i1 %tmp_89, label %tmp_90, label %tmp_96

tmp_90:                                           ; preds = %tmp_87
  %tmp_92 = call i32 @__get_num_groups_u32(i32 0)
  %tmp_93 = add i32 %tmp_92, 1
  %tmp_95 = getelementptr inbounds i32 addrspace(1)* %out, i32 %tmp_93
  store volatile i32 %val, i32 addrspace(1)* %tmp_95, align 4
  br label %tmp_96

tmp_96:                                           ; preds = %tmp_90, %tmp_87
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare void @barrier(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_num_groups_u32(i32) #1

; Function Attrs: nounwind
define void @writeKernel(i32 addrspace(1)* %in, <4 x i32> addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %tmp_7 = call i32 @__get_local_id_u32(i32 0)
  %tmp_8 = icmp eq i32 %tmp_7, 0
  br i1 %tmp_8, label %tmp_9, label %tmp_15

tmp_9:                                            ; preds = %0
  %tmp_10 = call i32 @__get_num_groups_u32(i32 0)
  %tmp_11 = add i32 %tmp_10, 1
  %tmp_13 = getelementptr inbounds i32 addrspace(1)* %in, i32 %tmp_11
  %tmp_14 = load volatile i32 addrspace(1)* %tmp_13, align 4
  store i32 %tmp_14, i32 addrspace(3)* @writeKernel.lval, align 4
  br label %tmp_15

tmp_15:                                           ; preds = %tmp_9, %0
  call void @barrier(i32 1)
  %tmp_16 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %tmp_17 = insertelement <4 x i32> undef, i32 %tmp_16, i32 0
  %tmp_18 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %tmp_19 = insertelement <4 x i32> %tmp_17, i32 %tmp_18, i32 1
  %tmp_20 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %tmp_21 = insertelement <4 x i32> %tmp_19, i32 %tmp_20, i32 2
  %tmp_22 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %tmp_23 = insertelement <4 x i32> %tmp_21, i32 %tmp_22, i32 3
  br label %tmp_25

tmp_25:                                           ; preds = %tmp_47, %tmp_15
  %n.0 = phi i32 [ 0, %tmp_15 ], [ %tmp_49, %tmp_47 ]
  %tmp_28 = icmp ult i32 %n.0, %nk
  br i1 %tmp_28, label %tmp_29, label %tmp_50

tmp_29:                                           ; preds = %tmp_25
  %tmp_30 = call i32 @__get_global_id_u32(i32 0)
  br label %tmp_31

tmp_31:                                           ; preds = %tmp_40, %tmp_29
  %i.0 = phi i32 [ 0, %tmp_29 ], [ %tmp_42, %tmp_40 ]
  %idx.0 = phi i32 [ %tmp_30, %tmp_29 ], [ %tmp_45, %tmp_40 ]
  %tmp_34 = icmp ult i32 %i.0, %ni
  br i1 %tmp_34, label %tmp_35, label %tmp_46

tmp_35:                                           ; preds = %tmp_31
  %tmp_39 = getelementptr inbounds <4 x i32> addrspace(1)* %out, i32 %idx.0
  store volatile <4 x i32> %tmp_23, <4 x i32> addrspace(1)* %tmp_39, align 16
  br label %tmp_40

tmp_40:                                           ; preds = %tmp_35
  %tmp_42 = add i32 %i.0, 1
  %tmp_43 = call i32 @__get_global_size_u32(i32 0)
  %tmp_45 = add i32 %idx.0, %tmp_43
  br label %tmp_31

tmp_46:                                           ; preds = %tmp_31
  br label %tmp_47

tmp_47:                                           ; preds = %tmp_46
  %tmp_49 = add nsw i32 %n.0, 1
  br label %tmp_25

tmp_50:                                           ; preds = %tmp_25
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @readKernel}
!1 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @writeKernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

; ModuleID = 'BufferBandwidth_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@read_kernel.lcount = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define void @read_kernel(<4 x i32> addrspace(1)* %in, i32 addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %tmp_7 = icmp eq i32 %nk, 0
  br i1 %tmp_7, label %tmp_8, label %tmp_9

tmp_8:                                            ; preds = %0
  br label %tmp_91

tmp_9:                                            ; preds = %0
  %tmp_10 = call i32 @__get_local_id_u32(i32 0)
  %tmp_11 = icmp eq i32 %tmp_10, 0
  br i1 %tmp_11, label %tmp_12, label %tmp_13

tmp_12:                                           ; preds = %tmp_9
  store i32 0, i32 addrspace(3)* @read_kernel.lcount, align 4
  br label %tmp_13

tmp_13:                                           ; preds = %tmp_12, %tmp_9
  call void @barrier(i32 1)
  br label %tmp_14

tmp_14:                                           ; preds = %tmp_76, %tmp_13
  %pcount.0 = phi i32 [ 0, %tmp_13 ], [ %pcount.1, %tmp_76 ]
  %n.0 = phi i32 [ 0, %tmp_13 ], [ %tmp_78, %tmp_76 ]
  %tmp_17 = icmp ult i32 %n.0, %nk
  br i1 %tmp_17, label %tmp_18, label %tmp_79

tmp_18:                                           ; preds = %tmp_14
  %tmp_19 = call i32 @__get_global_id_u32(i32 0)
  br label %tmp_20

tmp_20:                                           ; preds = %tmp_69, %tmp_18
  %pcount.1 = phi i32 [ %pcount.0, %tmp_18 ], [ %pcount.5, %tmp_69 ]
  %i.0 = phi i32 [ 0, %tmp_18 ], [ %tmp_71, %tmp_69 ]
  %idx.0 = phi i32 [ %tmp_19, %tmp_18 ], [ %tmp_74, %tmp_69 ]
  %tmp_23 = icmp ult i32 %i.0, %ni
  br i1 %tmp_23, label %tmp_24, label %tmp_75

tmp_24:                                           ; preds = %tmp_20
  %tmp_27 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %tmp_28 = load <4 x i32> addrspace(1)* %tmp_27, align 16
  %tmp_29 = extractelement <4 x i32> %tmp_28, i32 0
  %tmp_31 = icmp eq i32 %tmp_29, %val
  br i1 %tmp_31, label %tmp_32, label %tmp_35

tmp_32:                                           ; preds = %tmp_24
  %tmp_34 = add i32 %pcount.1, 1
  br label %tmp_35

tmp_35:                                           ; preds = %tmp_32, %tmp_24
  %pcount.2 = phi i32 [ %tmp_34, %tmp_32 ], [ %pcount.1, %tmp_24 ]
  %tmp_38 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %tmp_39 = load <4 x i32> addrspace(1)* %tmp_38, align 16
  %tmp_40 = extractelement <4 x i32> %tmp_39, i32 1
  %tmp_42 = icmp eq i32 %tmp_40, %val
  br i1 %tmp_42, label %tmp_43, label %tmp_46

tmp_43:                                           ; preds = %tmp_35
  %tmp_45 = add i32 %pcount.2, 1
  br label %tmp_46

tmp_46:                                           ; preds = %tmp_43, %tmp_35
  %pcount.3 = phi i32 [ %tmp_45, %tmp_43 ], [ %pcount.2, %tmp_35 ]
  %tmp_49 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %tmp_50 = load <4 x i32> addrspace(1)* %tmp_49, align 16
  %tmp_51 = extractelement <4 x i32> %tmp_50, i32 2
  %tmp_53 = icmp eq i32 %tmp_51, %val
  br i1 %tmp_53, label %tmp_54, label %tmp_57

tmp_54:                                           ; preds = %tmp_46
  %tmp_56 = add i32 %pcount.3, 1
  br label %tmp_57

tmp_57:                                           ; preds = %tmp_54, %tmp_46
  %pcount.4 = phi i32 [ %tmp_56, %tmp_54 ], [ %pcount.3, %tmp_46 ]
  %tmp_60 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %tmp_61 = load <4 x i32> addrspace(1)* %tmp_60, align 16
  %tmp_62 = extractelement <4 x i32> %tmp_61, i32 3
  %tmp_64 = icmp eq i32 %tmp_62, %val
  br i1 %tmp_64, label %tmp_65, label %tmp_68

tmp_65:                                           ; preds = %tmp_57
  %tmp_67 = add i32 %pcount.4, 1
  br label %tmp_68

tmp_68:                                           ; preds = %tmp_65, %tmp_57
  %pcount.5 = phi i32 [ %tmp_67, %tmp_65 ], [ %pcount.4, %tmp_57 ]
  br label %tmp_69

tmp_69:                                           ; preds = %tmp_68
  %tmp_71 = add i32 %i.0, 1
  %tmp_72 = call i32 @__get_global_size_u32(i32 0)
  %tmp_74 = add i32 %idx.0, %tmp_72
  br label %tmp_20

tmp_75:                                           ; preds = %tmp_20
  br label %tmp_76

tmp_76:                                           ; preds = %tmp_75
  %tmp_78 = add nsw i32 %n.0, 1
  br label %tmp_14

tmp_79:                                           ; preds = %tmp_14
  %tmp_81 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @read_kernel.lcount, i32 %pcount.0)
  call void @barrier(i32 1)
  %tmp_82 = call i32 @__get_local_id_u32(i32 0)
  %tmp_83 = icmp eq i32 %tmp_82, 0
  br i1 %tmp_83, label %tmp_84, label %tmp_91

tmp_84:                                           ; preds = %tmp_79
  %tmp_85 = load i32 addrspace(3)* @read_kernel.lcount, align 4
  %tmp_87 = udiv i32 %tmp_85, %nk
  %tmp_88 = call i32 @__get_group_id_u32(i32 0)
  %tmp_90 = getelementptr inbounds i32 addrspace(1)* %out, i32 %tmp_88
  store i32 %tmp_87, i32 addrspace(1)* %tmp_90, align 4
  br label %tmp_91

tmp_91:                                           ; preds = %tmp_84, %tmp_79, %tmp_8
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
  %tmp_8 = icmp eq i32 %nk, 0
  br i1 %tmp_8, label %tmp_9, label %tmp_10

tmp_9:                                            ; preds = %0
  br label %tmp_45

tmp_10:                                           ; preds = %0
  %tmp_12 = insertelement <4 x i32> undef, i32 %val, i32 0
  %tmp_14 = insertelement <4 x i32> %tmp_12, i32 %val, i32 1
  %tmp_16 = insertelement <4 x i32> %tmp_14, i32 %val, i32 2
  %tmp_18 = insertelement <4 x i32> %tmp_16, i32 %val, i32 3
  br label %tmp_20

tmp_20:                                           ; preds = %tmp_42, %tmp_10
  %n.0 = phi i32 [ 0, %tmp_10 ], [ %tmp_44, %tmp_42 ]
  %tmp_23 = icmp ult i32 %n.0, %nk
  br i1 %tmp_23, label %tmp_24, label %tmp_45

tmp_24:                                           ; preds = %tmp_20
  %tmp_25 = call i32 @__get_global_id_u32(i32 0)
  br label %tmp_26

tmp_26:                                           ; preds = %tmp_35, %tmp_24
  %i.0 = phi i32 [ 0, %tmp_24 ], [ %tmp_37, %tmp_35 ]
  %idx.0 = phi i32 [ %tmp_25, %tmp_24 ], [ %tmp_40, %tmp_35 ]
  %tmp_29 = icmp ult i32 %i.0, %ni
  br i1 %tmp_29, label %tmp_30, label %tmp_41

tmp_30:                                           ; preds = %tmp_26
  %tmp_34 = getelementptr inbounds <4 x i32> addrspace(1)* %out, i32 %idx.0
  store <4 x i32> %tmp_18, <4 x i32> addrspace(1)* %tmp_34, align 16
  br label %tmp_35

tmp_35:                                           ; preds = %tmp_30
  %tmp_37 = add i32 %i.0, 1
  %tmp_38 = call i32 @__get_global_size_u32(i32 0)
  %tmp_40 = add i32 %idx.0, %tmp_38
  br label %tmp_26

tmp_41:                                           ; preds = %tmp_26
  br label %tmp_42

tmp_42:                                           ; preds = %tmp_41
  %tmp_44 = add nsw i32 %n.0, 1
  br label %tmp_20

tmp_45:                                           ; preds = %tmp_20, %tmp_9
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @read_kernel}
!1 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @write_kernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

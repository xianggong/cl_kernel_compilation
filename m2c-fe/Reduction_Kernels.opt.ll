; ModuleID = 'Reduction_Kernels.opt.bc'

define void @reduce(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, <4 x i32>* %sdata) {
block_0:
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_local_id_u32(i32 0)
  %tmp_1 = call i32 @__get_group_id_u32(i32 0)
  %tmp_2 = call i32 @__get_global_id_u32(i32 0)
  %tmp_3 = call i32 @__get_local_size_u32(i32 0)
  %tmp_6 = mul i32 %tmp_2, 2
  %tmp_8 = getelementptr <4 x i32>* %sdata, i32 %tmp_0
  %tmp_11 = getelementptr <4 x i32> addrspace(1)* %input, i32 %tmp_6
  %tmp_12 = load <4 x i32> addrspace(1)* %tmp_11
  %tmp_14 = add i32 %tmp_6, 1
  %tmp_16 = getelementptr <4 x i32> addrspace(1)* %input, i32 %tmp_14
  %tmp_17 = load <4 x i32> addrspace(1)* %tmp_16
  %tmp_18 = add <4 x i32> %tmp_12, %tmp_17
  store <4 x i32> %tmp_18, <4 x i32>* %tmp_8
  call void @__barrier_u32(i32 1)
  %tmp_22 = ashr i32 %tmp_3, 1
  br label %block_2

block_2:                                          ; preds = %block_4, %block_1
  %s.0 = phi i32 [ %tmp_22, %block_1 ], [ %tmp_27, %block_4 ]
  %tmp_23 = icmp ugt i32 %s.0, 0
  %tmp_24 = sext i1 %tmp_23 to i32
  %tmp_25 = icmp ne i32 %tmp_24, 0
  br i1 %tmp_25, label %block_3, label %block_5

block_3:                                          ; preds = %block_2
  %tmp_30 = icmp ult i32 %tmp_0, %s.0
  %tmp_31 = sext i1 %tmp_30 to i32
  %tmp_32 = icmp ne i32 %tmp_31, 0
  br i1 %tmp_32, label %block_7, label %block_6

block_4:                                          ; preds = %block_6
  %tmp_27 = ashr i32 %s.0, 1
  br label %block_2

block_5:                                          ; preds = %block_2
  %tmp_46 = icmp eq i32 %tmp_0, 0
  %tmp_47 = sext i1 %tmp_46 to i32
  %tmp_48 = icmp ne i32 %tmp_47, 0
  br i1 %tmp_48, label %block_9, label %block_8

block_6:                                          ; preds = %block_7, %block_3
  call void @__barrier_u32(i32 1)
  br label %block_4

block_7:                                          ; preds = %block_3
  %tmp_35 = getelementptr <4 x i32>* %sdata, i32 %tmp_0
  %tmp_38 = add i32 %tmp_0, %s.0
  %tmp_40 = getelementptr <4 x i32>* %sdata, i32 %tmp_38
  %tmp_41 = load <4 x i32>* %tmp_40
  %tmp_42 = load <4 x i32>* %tmp_35
  %tmp_43 = add <4 x i32> %tmp_42, %tmp_41
  store <4 x i32> %tmp_43, <4 x i32>* %tmp_35
  br label %block_6

block_8:                                          ; preds = %block_9, %block_5
  ret void

block_9:                                          ; preds = %block_5
  %tmp_51 = getelementptr <4 x i32> addrspace(1)* %output, i32 %tmp_1
  %tmp_53 = getelementptr <4 x i32>* %sdata, i32 0
  %tmp_54 = load <4 x i32>* %tmp_53
  store <4 x i32> %tmp_54, <4 x i32> addrspace(1)* %tmp_51
  br label %block_8
}

; Function Attrs: nounwind
declare i32 @__get_local_id_u32(i32) #0

; Function Attrs: nounwind
declare i32 @__get_group_id_u32(i32) #0

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

; Function Attrs: nounwind
declare i32 @__get_local_size_u32(i32) #0

; Function Attrs: nounwind
declare void @__barrier_u32(i32) #0

attributes #0 = { nounwind }

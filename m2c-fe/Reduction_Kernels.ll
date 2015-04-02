; ModuleID = 'Reduction_Kernels.bc'

define void @reduce(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, <4 x i32>* %sdata) {
block_0:
  %input_addr = alloca <4 x i32> addrspace(1)*
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %input_addr
  %output_addr = alloca <4 x i32> addrspace(1)*
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %output_addr
  %sdata_addr = alloca <4 x i32>*
  store <4 x i32>* %sdata, <4 x i32>** %sdata_addr
  %tid = alloca i32
  %bid = alloca i32
  %gid = alloca i32
  %localSize = alloca i32
  %stride = alloca i32
  %s = alloca i32
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_local_id_u32(i32 0)
  store i32 %tmp_0, i32* %tid
  %tmp_1 = call i32 @__get_group_id_u32(i32 0)
  store i32 %tmp_1, i32* %bid
  %tmp_2 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_2, i32* %gid
  %tmp_3 = call i32 @__get_local_size_u32(i32 0)
  store i32 %tmp_3, i32* %localSize
  %tmp_4 = load i32* %gid
  %tmp_6 = mul i32 %tmp_4, 2
  store i32 %tmp_6, i32* %stride
  %tmp_61 = load i32* %tid
  %tmp_7 = load <4 x i32>** %sdata_addr
  %tmp_8 = getelementptr <4 x i32>* %tmp_7, i32 %tmp_61
  %tmp_9 = load i32* %stride
  %tmp_10 = load <4 x i32> addrspace(1)** %input_addr
  %tmp_11 = getelementptr <4 x i32> addrspace(1)* %tmp_10, i32 %tmp_9
  %tmp_12 = load <4 x i32> addrspace(1)* %tmp_11
  %tmp_13 = load i32* %stride
  %tmp_14 = add i32 %tmp_13, 1
  %tmp_15 = load <4 x i32> addrspace(1)** %input_addr
  %tmp_16 = getelementptr <4 x i32> addrspace(1)* %tmp_15, i32 %tmp_14
  %tmp_17 = load <4 x i32> addrspace(1)* %tmp_16
  %tmp_18 = add <4 x i32> %tmp_12, %tmp_17
  store <4 x i32> %tmp_18, <4 x i32>* %tmp_8
  call void @__barrier_u32(i32 1)
  %tmp_20 = load i32* %localSize
  %tmp_22 = ashr i32 %tmp_20, 1
  store i32 %tmp_22, i32* %s
  br label %block_2

block_2:                                          ; preds = %block_4, %block_1
  %tmp_222 = load i32* %s
  %tmp_23 = icmp ugt i32 %tmp_222, 0
  %tmp_24 = sext i1 %tmp_23 to i32
  %tmp_25 = icmp ne i32 %tmp_24, 0
  br i1 %tmp_25, label %block_3, label %block_5

block_3:                                          ; preds = %block_2
  %tmp_28 = load i32* %tid
  %tmp_29 = load i32* %s
  %tmp_30 = icmp ult i32 %tmp_28, %tmp_29
  %tmp_31 = sext i1 %tmp_30 to i32
  %tmp_32 = icmp ne i32 %tmp_31, 0
  br i1 %tmp_32, label %block_7, label %block_6

block_4:                                          ; preds = %block_6
  %tmp_26 = load i32* %s
  %tmp_27 = ashr i32 %tmp_26, 1
  store i32 %tmp_27, i32* %s
  br label %block_2

block_5:                                          ; preds = %block_2
  %tmp_45 = load i32* %tid
  %tmp_46 = icmp eq i32 %tmp_45, 0
  %tmp_47 = sext i1 %tmp_46 to i32
  %tmp_48 = icmp ne i32 %tmp_47, 0
  br i1 %tmp_48, label %block_9, label %block_8

block_6:                                          ; preds = %block_7, %block_3
  call void @__barrier_u32(i32 1)
  br label %block_4

block_7:                                          ; preds = %block_3
  %tmp_33 = load i32* %tid
  %tmp_34 = load <4 x i32>** %sdata_addr
  %tmp_35 = getelementptr <4 x i32>* %tmp_34, i32 %tmp_33
  %tmp_36 = load i32* %tid
  %tmp_37 = load i32* %s
  %tmp_38 = add i32 %tmp_36, %tmp_37
  %tmp_39 = load <4 x i32>** %sdata_addr
  %tmp_40 = getelementptr <4 x i32>* %tmp_39, i32 %tmp_38
  %tmp_41 = load <4 x i32>* %tmp_40
  %tmp_42 = load <4 x i32>* %tmp_35
  %tmp_43 = add <4 x i32> %tmp_42, %tmp_41
  store <4 x i32> %tmp_43, <4 x i32>* %tmp_35
  br label %block_6

block_8:                                          ; preds = %block_9, %block_5
  ret void

block_9:                                          ; preds = %block_5
  %tmp_49 = load i32* %bid
  %tmp_50 = load <4 x i32> addrspace(1)** %output_addr
  %tmp_51 = getelementptr <4 x i32> addrspace(1)* %tmp_50, i32 %tmp_49
  %tmp_52 = load <4 x i32>** %sdata_addr
  %tmp_53 = getelementptr <4 x i32>* %tmp_52, i32 0
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

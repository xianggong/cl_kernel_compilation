; ModuleID = 'AsyncDataTransfer_Kernels.opt.bc'

define void @work(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %multiplier) {
block_0:
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_size_u32(i32 0)
  %tmp_1 = call i32 @__get_global_id_u32(i32 0)
  br label %block_2

block_2:                                          ; preds = %block_4, %block_1
  %tmp.0 = phi i32 [ 1, %block_1 ], [ %tmp_49, %block_4 ]
  %i.0 = phi i32 [ 5, %block_1 ], [ %tmp_7, %block_4 ]
  %tmp_3 = icmp slt i32 %i.0, 100
  %tmp_4 = sext i1 %tmp_3 to i32
  %tmp_5 = icmp ne i32 %tmp_4, 0
  br i1 %tmp_5, label %block_3, label %block_5

block_3:                                          ; preds = %block_2
  %tmp_9 = mul i32 %i.0, 1
  %tmp_11 = srem i32 %tmp_9, %tmp_0
  %tmp_13 = getelementptr i8 addrspace(1)* %input, i32 %tmp_11
  %tmp_14 = load i8 addrspace(1)* %tmp_13
  %tmp_16 = mul i32 %i.0, 2
  %tmp_18 = srem i32 %tmp_16, %tmp_0
  %tmp_20 = getelementptr i8 addrspace(1)* %input, i32 %tmp_18
  %tmp_21 = load i8 addrspace(1)* %tmp_20
  %tmp_22 = add i8 %tmp_14, %tmp_21
  %tmp_24 = mul i32 %i.0, 3
  %tmp_26 = srem i32 %tmp_24, %tmp_0
  %tmp_28 = getelementptr i8 addrspace(1)* %input, i32 %tmp_26
  %tmp_29 = load i8 addrspace(1)* %tmp_28
  %tmp_30 = add i8 %tmp_22, %tmp_29
  %tmp_32 = mul i32 %i.0, 4
  %tmp_34 = srem i32 %tmp_32, %tmp_0
  %tmp_36 = getelementptr i8 addrspace(1)* %input, i32 %tmp_34
  %tmp_37 = load i8 addrspace(1)* %tmp_36
  %tmp_38 = add i8 %tmp_30, %tmp_37
  %tmp_40 = mul i32 %i.0, 5
  %tmp_42 = srem i32 %tmp_40, %tmp_0
  %tmp_44 = getelementptr i8 addrspace(1)* %input, i32 %tmp_42
  %tmp_45 = load i8 addrspace(1)* %tmp_44
  %tmp_46 = add i8 %tmp_38, %tmp_45
  %tmp_48 = zext i8 %tmp_46 to i32
  %tmp_49 = add i32 %tmp.0, %tmp_48
  br label %block_4

block_4:                                          ; preds = %block_3
  %tmp_7 = add i32 %i.0, 1
  br label %block_2

block_5:                                          ; preds = %block_2
  %tmp_52 = getelementptr i8 addrspace(1)* %output, i32 %tmp_1
  %tmp_55 = getelementptr i8 addrspace(1)* %input, i32 %tmp_1
  %tmp_56 = load i8 addrspace(1)* %tmp_55
  %tmp_59 = trunc i32 %multiplier to i8
  %tmp_591 = mul i8 %tmp_56, %tmp_59
  %tmp_61 = urem i8 %tmp_591, 0
  %tmp_65 = mul i32 0, %tmp.0
  %tmp_652 = trunc i32 %tmp_65 to i8
  %tmp_66 = add i8 %tmp_61, %tmp_652
  store i8 %tmp_66, i8 addrspace(1)* %tmp_52
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_size_u32(i32) #0

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

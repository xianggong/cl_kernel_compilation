; ModuleID = 'AsyncDataTransfer_Kernels.llvm'

define void @work(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %multiplier) {
block_0:
  %input_addr = alloca i8 addrspace(1)*
  store i8 addrspace(1)* %input, i8 addrspace(1)** %input_addr
  %output_addr = alloca i8 addrspace(1)*
  store i8 addrspace(1)* %output, i8 addrspace(1)** %output_addr
  %multiplier_addr = alloca i32
  store i32 %multiplier, i32* %multiplier_addr
  %gSize = alloca i32
  %gId = alloca i32
  %tmp = alloca i32
  %zero = alloca i32
  %i = alloca i32
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_size_u32(i32 0)
  store i32 %tmp_0, i32* %gSize
  %tmp_1 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_1, i32* %gId
  store i32 1, i32* %tmp
  store i32 0, i32* %zero
  store i32 5, i32* %i
  br label %block_2

block_2:                                          ; preds = %block_4, %block_1
  %tmp_2 = load i32* %i
  %tmp_3 = icmp slt i32 %tmp_2, 100
  %tmp_4 = sext i1 %tmp_3 to i32
  %tmp_5 = icmp ne i32 %tmp_4, 0
  br i1 %tmp_5, label %block_3, label %block_5

block_3:                                          ; preds = %block_2
  %tmp_8 = load i32* %i
  %tmp_9 = mul i32 %tmp_8, 1
  %tmp_10 = load i32* %gSize
  %tmp_11 = srem i32 %tmp_9, %tmp_10
  %tmp_12 = load i8 addrspace(1)** %input_addr
  %tmp_13 = getelementptr i8 addrspace(1)* %tmp_12, i32 %tmp_11
  %tmp_14 = load i8 addrspace(1)* %tmp_13
  %tmp_15 = load i32* %i
  %tmp_16 = mul i32 %tmp_15, 2
  %tmp_17 = load i32* %gSize
  %tmp_18 = srem i32 %tmp_16, %tmp_17
  %tmp_19 = load i8 addrspace(1)** %input_addr
  %tmp_20 = getelementptr i8 addrspace(1)* %tmp_19, i32 %tmp_18
  %tmp_21 = load i8 addrspace(1)* %tmp_20
  %tmp_22 = add i8 %tmp_14, %tmp_21
  %tmp_23 = load i32* %i
  %tmp_24 = mul i32 %tmp_23, 3
  %tmp_25 = load i32* %gSize
  %tmp_26 = srem i32 %tmp_24, %tmp_25
  %tmp_27 = load i8 addrspace(1)** %input_addr
  %tmp_28 = getelementptr i8 addrspace(1)* %tmp_27, i32 %tmp_26
  %tmp_29 = load i8 addrspace(1)* %tmp_28
  %tmp_30 = add i8 %tmp_22, %tmp_29
  %tmp_31 = load i32* %i
  %tmp_32 = mul i32 %tmp_31, 4
  %tmp_33 = load i32* %gSize
  %tmp_34 = srem i32 %tmp_32, %tmp_33
  %tmp_35 = load i8 addrspace(1)** %input_addr
  %tmp_36 = getelementptr i8 addrspace(1)* %tmp_35, i32 %tmp_34
  %tmp_37 = load i8 addrspace(1)* %tmp_36
  %tmp_38 = add i8 %tmp_30, %tmp_37
  %tmp_39 = load i32* %i
  %tmp_40 = mul i32 %tmp_39, 5
  %tmp_41 = load i32* %gSize
  %tmp_42 = srem i32 %tmp_40, %tmp_41
  %tmp_43 = load i8 addrspace(1)** %input_addr
  %tmp_44 = getelementptr i8 addrspace(1)* %tmp_43, i32 %tmp_42
  %tmp_45 = load i8 addrspace(1)* %tmp_44
  %tmp_46 = add i8 %tmp_38, %tmp_45
  %tmp_47 = load i32* %tmp
  %tmp_48 = zext i8 %tmp_46 to i32
  %tmp_49 = add i32 %tmp_47, %tmp_48
  store i32 %tmp_49, i32* %tmp
  br label %block_4

block_4:                                          ; preds = %block_3
  %tmp_6 = load i32* %i
  %tmp_7 = add i32 %tmp_6, 1
  store i32 %tmp_7, i32* %i
  br label %block_2

block_5:                                          ; preds = %block_2
  %tmp_50 = load i32* %gId
  %tmp_51 = load i8 addrspace(1)** %output_addr
  %tmp_52 = getelementptr i8 addrspace(1)* %tmp_51, i32 %tmp_50
  %tmp_53 = load i32* %gId
  %tmp_54 = load i8 addrspace(1)** %input_addr
  %tmp_55 = getelementptr i8 addrspace(1)* %tmp_54, i32 %tmp_53
  %tmp_56 = load i8 addrspace(1)* %tmp_55
  %tmp_57 = load i32* %multiplier_addr
  %tmp_59 = trunc i32 %tmp_57 to i8
  %tmp_591 = mul i8 %tmp_56, %tmp_59
  %tmp_61 = urem i8 %tmp_591, 0
  %tmp_62 = load i32* %zero
  %tmp_63 = load i32* %tmp
  %tmp_65 = mul i32 %tmp_62, %tmp_63
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

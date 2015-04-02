; ModuleID = 'BitonicSort_Kernels.bc'

define void @bitonicSort(i32 addrspace(1)* %theArray, i32 %stage, i32 %passOfStage, i32 %direction) {
block_0:
  %theArray_addr = alloca i32 addrspace(1)*
  store i32 addrspace(1)* %theArray, i32 addrspace(1)** %theArray_addr
  %stage_addr = alloca i32
  store i32 %stage, i32* %stage_addr
  %passOfStage_addr = alloca i32
  store i32 %passOfStage, i32* %passOfStage_addr
  %direction_addr = alloca i32
  store i32 %direction, i32* %direction_addr
  %sortIncreasing = alloca i32
  %threadId = alloca i32
  %pairDistance = alloca i32
  %blockWidth = alloca i32
  %leftId = alloca i32
  %rightId = alloca i32
  %leftElement = alloca i32
  %rightElement = alloca i32
  %sameDirectionBlockWidth = alloca i32
  %greater = alloca i32
  %lesser = alloca i32
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = load i32* %direction_addr
  store i32 %tmp_0, i32* %sortIncreasing
  %tmp_1 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_1, i32* %threadId
  %tmp_2 = load i32* %stage_addr
  %tmp_3 = load i32* %passOfStage_addr
  %tmp_4 = sub i32 %tmp_2, %tmp_3
  %tmp_6 = shl i32 1, %tmp_4
  store i32 %tmp_6, i32* %pairDistance
  %tmp_61 = load i32* %pairDistance
  %tmp_8 = mul i32 2, %tmp_61
  store i32 %tmp_8, i32* %blockWidth
  %tmp_82 = load i32* %threadId
  %tmp_9 = load i32* %pairDistance
  %tmp_10 = urem i32 %tmp_82, %tmp_9
  %tmp_11 = load i32* %threadId
  %tmp_12 = load i32* %pairDistance
  %tmp_13 = udiv i32 %tmp_11, %tmp_12
  %tmp_14 = load i32* %blockWidth
  %tmp_15 = mul i32 %tmp_13, %tmp_14
  %tmp_16 = add i32 %tmp_10, %tmp_15
  store i32 %tmp_16, i32* %leftId
  %tmp_17 = load i32* %leftId
  %tmp_18 = load i32* %pairDistance
  %tmp_19 = add i32 %tmp_17, %tmp_18
  store i32 %tmp_19, i32* %rightId
  %tmp_20 = load i32* %leftId
  %tmp_21 = load i32 addrspace(1)** %theArray_addr
  %tmp_22 = getelementptr i32 addrspace(1)* %tmp_21, i32 %tmp_20
  %tmp_23 = load i32 addrspace(1)* %tmp_22
  store i32 %tmp_23, i32* %leftElement
  %tmp_24 = load i32* %rightId
  %tmp_25 = load i32 addrspace(1)** %theArray_addr
  %tmp_26 = getelementptr i32 addrspace(1)* %tmp_25, i32 %tmp_24
  %tmp_27 = load i32 addrspace(1)* %tmp_26
  store i32 %tmp_27, i32* %rightElement
  %tmp_28 = load i32* %stage_addr
  %tmp_30 = shl i32 1, %tmp_28
  store i32 %tmp_30, i32* %sameDirectionBlockWidth
  %tmp_303 = load i32* %threadId
  %tmp_31 = load i32* %sameDirectionBlockWidth
  %tmp_32 = udiv i32 %tmp_303, %tmp_31
  %tmp_34 = urem i32 %tmp_32, 2
  %tmp_344 = icmp eq i32 %tmp_34, 1
  %tmp_35 = sext i1 %tmp_344 to i32
  %tmp_36 = icmp ne i32 %tmp_35, 0
  br i1 %tmp_36, label %block_3, label %block_2

block_2:                                          ; preds = %block_3, %block_1
  %tmp_39 = load i32* %leftElement
  %tmp_40 = load i32* %rightElement
  %tmp_41 = icmp ugt i32 %tmp_39, %tmp_40
  %tmp_42 = sext i1 %tmp_41 to i32
  %tmp_43 = icmp ne i32 %tmp_42, 0
  br i1 %tmp_43, label %block_5, label %block_4

block_3:                                          ; preds = %block_1
  %tmp_37 = load i32* %sortIncreasing
  %tmp_38 = sub i32 1, %tmp_37
  store i32 %tmp_38, i32* %sortIncreasing
  br label %block_2

block_4:                                          ; preds = %block_2
  %tmp_46 = load i32* %rightElement
  store i32 %tmp_46, i32* %greater
  %tmp_47 = load i32* %leftElement
  store i32 %tmp_47, i32* %lesser
  br label %block_6

block_5:                                          ; preds = %block_2
  %tmp_44 = load i32* %leftElement
  store i32 %tmp_44, i32* %greater
  %tmp_45 = load i32* %rightElement
  store i32 %tmp_45, i32* %lesser
  br label %block_6

block_6:                                          ; preds = %block_5, %block_4
  %tmp_48 = load i32* %sortIncreasing
  %tmp_49 = icmp ne i32 %tmp_48, 0
  br i1 %tmp_49, label %block_8, label %block_7

block_7:                                          ; preds = %block_6
  %tmp_58 = load i32* %leftId
  %tmp_59 = load i32 addrspace(1)** %theArray_addr
  %tmp_60 = getelementptr i32 addrspace(1)* %tmp_59, i32 %tmp_58
  %tmp_615 = load i32* %greater
  store i32 %tmp_615, i32 addrspace(1)* %tmp_60
  %tmp_62 = load i32* %rightId
  %tmp_63 = load i32 addrspace(1)** %theArray_addr
  %tmp_64 = getelementptr i32 addrspace(1)* %tmp_63, i32 %tmp_62
  %tmp_65 = load i32* %lesser
  store i32 %tmp_65, i32 addrspace(1)* %tmp_64
  br label %block_9

block_8:                                          ; preds = %block_6
  %tmp_50 = load i32* %leftId
  %tmp_51 = load i32 addrspace(1)** %theArray_addr
  %tmp_52 = getelementptr i32 addrspace(1)* %tmp_51, i32 %tmp_50
  %tmp_53 = load i32* %lesser
  store i32 %tmp_53, i32 addrspace(1)* %tmp_52
  %tmp_54 = load i32* %rightId
  %tmp_55 = load i32 addrspace(1)** %theArray_addr
  %tmp_56 = getelementptr i32 addrspace(1)* %tmp_55, i32 %tmp_54
  %tmp_57 = load i32* %greater
  store i32 %tmp_57, i32 addrspace(1)* %tmp_56
  br label %block_9

block_9:                                          ; preds = %block_8, %block_7
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

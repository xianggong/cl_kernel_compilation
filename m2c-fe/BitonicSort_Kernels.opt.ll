; ModuleID = 'BitonicSort_Kernels.opt.bc'

define void @bitonicSort(i32 addrspace(1)* %theArray, i32 %stage, i32 %passOfStage, i32 %direction) {
block_0:
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_1 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = sub i32 %stage, %passOfStage
  %tmp_6 = shl i32 1, %tmp_4
  %tmp_8 = mul i32 2, %tmp_6
  %tmp_10 = urem i32 %tmp_1, %tmp_6
  %tmp_13 = udiv i32 %tmp_1, %tmp_6
  %tmp_15 = mul i32 %tmp_13, %tmp_8
  %tmp_16 = add i32 %tmp_10, %tmp_15
  %tmp_19 = add i32 %tmp_16, %tmp_6
  %tmp_22 = getelementptr i32 addrspace(1)* %theArray, i32 %tmp_16
  %tmp_23 = load i32 addrspace(1)* %tmp_22
  %tmp_26 = getelementptr i32 addrspace(1)* %theArray, i32 %tmp_19
  %tmp_27 = load i32 addrspace(1)* %tmp_26
  %tmp_30 = shl i32 1, %stage
  %tmp_32 = udiv i32 %tmp_1, %tmp_30
  %tmp_34 = urem i32 %tmp_32, 2
  %tmp_344 = icmp eq i32 %tmp_34, 1
  %tmp_35 = sext i1 %tmp_344 to i32
  %tmp_36 = icmp ne i32 %tmp_35, 0
  br i1 %tmp_36, label %block_3, label %block_2

block_2:                                          ; preds = %block_3, %block_1
  %sortIncreasing.0 = phi i32 [ %tmp_38, %block_3 ], [ %direction, %block_1 ]
  %tmp_41 = icmp ugt i32 %tmp_23, %tmp_27
  %tmp_42 = sext i1 %tmp_41 to i32
  %tmp_43 = icmp ne i32 %tmp_42, 0
  br i1 %tmp_43, label %block_5, label %block_4

block_3:                                          ; preds = %block_1
  %tmp_38 = sub i32 1, %direction
  br label %block_2

block_4:                                          ; preds = %block_2
  br label %block_6

block_5:                                          ; preds = %block_2
  br label %block_6

block_6:                                          ; preds = %block_5, %block_4
  %greater.0 = phi i32 [ %tmp_23, %block_5 ], [ %tmp_27, %block_4 ]
  %lesser.0 = phi i32 [ %tmp_27, %block_5 ], [ %tmp_23, %block_4 ]
  %tmp_49 = icmp ne i32 %sortIncreasing.0, 0
  br i1 %tmp_49, label %block_8, label %block_7

block_7:                                          ; preds = %block_6
  %tmp_60 = getelementptr i32 addrspace(1)* %theArray, i32 %tmp_16
  store i32 %greater.0, i32 addrspace(1)* %tmp_60
  %tmp_64 = getelementptr i32 addrspace(1)* %theArray, i32 %tmp_19
  store i32 %lesser.0, i32 addrspace(1)* %tmp_64
  br label %block_9

block_8:                                          ; preds = %block_6
  %tmp_52 = getelementptr i32 addrspace(1)* %theArray, i32 %tmp_16
  store i32 %lesser.0, i32 addrspace(1)* %tmp_52
  %tmp_56 = getelementptr i32 addrspace(1)* %theArray, i32 %tmp_19
  store i32 %greater.0, i32 addrspace(1)* %tmp_56
  br label %block_9

block_9:                                          ; preds = %block_8, %block_7
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

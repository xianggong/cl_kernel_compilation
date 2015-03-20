; ModuleID = 'FastWalshTransform_Kernels.llvm'

define void @fastWalshTransform(float addrspace(1)* %tArray, i32 %step) {
block_0:
  %tArray_addr = alloca float addrspace(1)*
  store float addrspace(1)* %tArray, float addrspace(1)** %tArray_addr
  %step_addr = alloca i32
  store i32 %step, i32* %step_addr
  %tid = alloca i32
  %group = alloca i32
  %pair = alloca i32
  %match = alloca i32
  %T1 = alloca float
  %T2 = alloca float
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_0, i32* %tid
  %tmp_1 = load i32* %tid
  %tmp_2 = load i32* %step_addr
  %tmp_4 = urem i32 %tmp_1, %tmp_2
  store i32 %tmp_4, i32* %group
  %tmp_41 = load i32* %step_addr
  %tmp_5 = mul i32 2, %tmp_41
  %tmp_6 = load i32* %tid
  %tmp_7 = load i32* %step_addr
  %tmp_9 = udiv i32 %tmp_6, %tmp_7
  %tmp_10 = mul i32 %tmp_5, %tmp_9
  %tmp_102 = load i32* %group
  %tmp_11 = add i32 %tmp_10, %tmp_102
  store i32 %tmp_11, i32* %pair
  %tmp_12 = load i32* %pair
  %tmp_13 = load i32* %step_addr
  %tmp_14 = add i32 %tmp_12, %tmp_13
  store i32 %tmp_14, i32* %match
  %tmp_15 = load i32* %pair
  %tmp_16 = load float addrspace(1)** %tArray_addr
  %tmp_17 = getelementptr float addrspace(1)* %tmp_16, i32 %tmp_15
  %tmp_18 = load float addrspace(1)* %tmp_17
  store float %tmp_18, float* %T1
  %tmp_20 = load i32* %match
  %tmp_21 = load float addrspace(1)** %tArray_addr
  %tmp_22 = getelementptr float addrspace(1)* %tmp_21, i32 %tmp_20
  %tmp_23 = load float addrspace(1)* %tmp_22
  store float %tmp_23, float* %T2
  %tmp_25 = load i32* %pair
  %tmp_26 = load float addrspace(1)** %tArray_addr
  %tmp_27 = getelementptr float addrspace(1)* %tmp_26, i32 %tmp_25
  %tmp_28 = load float* %T1
  %tmp_29 = load float* %T2
  %tmp_30 = fadd float %tmp_28, %tmp_29
  store float %tmp_30, float addrspace(1)* %tmp_27
  %tmp_32 = load i32* %match
  %tmp_33 = load float addrspace(1)** %tArray_addr
  %tmp_34 = getelementptr float addrspace(1)* %tmp_33, i32 %tmp_32
  %tmp_35 = load float* %T1
  %tmp_36 = load float* %T2
  %tmp_37 = fsub float %tmp_35, %tmp_36
  store float %tmp_37, float addrspace(1)* %tmp_34
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

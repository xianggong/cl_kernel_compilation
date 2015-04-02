; ModuleID = 'FastWalshTransform_Kernels.opt.bc'

define void @fastWalshTransform(float addrspace(1)* %tArray, i32 %step) {
block_0:
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = urem i32 %tmp_0, %step
  %tmp_5 = mul i32 2, %step
  %tmp_9 = udiv i32 %tmp_0, %step
  %tmp_10 = mul i32 %tmp_5, %tmp_9
  %tmp_11 = add i32 %tmp_10, %tmp_4
  %tmp_14 = add i32 %tmp_11, %step
  %tmp_17 = getelementptr float addrspace(1)* %tArray, i32 %tmp_11
  %tmp_18 = load float addrspace(1)* %tmp_17
  %tmp_22 = getelementptr float addrspace(1)* %tArray, i32 %tmp_14
  %tmp_23 = load float addrspace(1)* %tmp_22
  %tmp_27 = getelementptr float addrspace(1)* %tArray, i32 %tmp_11
  %tmp_30 = fadd float %tmp_18, %tmp_23
  store float %tmp_30, float addrspace(1)* %tmp_27
  %tmp_34 = getelementptr float addrspace(1)* %tArray, i32 %tmp_14
  %tmp_37 = fsub float %tmp_18, %tmp_23
  store float %tmp_37, float addrspace(1)* %tmp_34
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

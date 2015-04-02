; ModuleID = 'CplusplusWrapper_Kernels.opt.bc'

define void @vectorAdd(float addrspace(1)* %output, float addrspace(1)* %inputA, float addrspace(1)* %inputB) {
block_0:
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  %tmp_3 = getelementptr float addrspace(1)* %output, i32 %tmp_0
  %tmp_6 = getelementptr float addrspace(1)* %inputA, i32 %tmp_0
  %tmp_7 = load float addrspace(1)* %tmp_6
  %tmp_10 = getelementptr float addrspace(1)* %inputB, i32 %tmp_0
  %tmp_11 = load float addrspace(1)* %tmp_10
  %tmp_12 = fadd float %tmp_7, %tmp_11
  store float %tmp_12, float addrspace(1)* %tmp_3
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

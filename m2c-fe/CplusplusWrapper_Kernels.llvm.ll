; ModuleID = 'CplusplusWrapper_Kernels.llvm'

define void @vectorAdd(float addrspace(1)* %output, float addrspace(1)* %inputA, float addrspace(1)* %inputB) {
block_0:
  %output_addr = alloca float addrspace(1)*
  store float addrspace(1)* %output, float addrspace(1)** %output_addr
  %inputA_addr = alloca float addrspace(1)*
  store float addrspace(1)* %inputA, float addrspace(1)** %inputA_addr
  %inputB_addr = alloca float addrspace(1)*
  store float addrspace(1)* %inputB, float addrspace(1)** %inputB_addr
  %gid = alloca i32
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_0, i32* %gid
  %tmp_1 = load i32* %gid
  %tmp_2 = load float addrspace(1)** %output_addr
  %tmp_3 = getelementptr float addrspace(1)* %tmp_2, i32 %tmp_1
  %tmp_4 = load i32* %gid
  %tmp_5 = load float addrspace(1)** %inputA_addr
  %tmp_6 = getelementptr float addrspace(1)* %tmp_5, i32 %tmp_4
  %tmp_7 = load float addrspace(1)* %tmp_6
  %tmp_8 = load i32* %gid
  %tmp_9 = load float addrspace(1)** %inputB_addr
  %tmp_10 = getelementptr float addrspace(1)* %tmp_9, i32 %tmp_8
  %tmp_11 = load float addrspace(1)* %tmp_10
  %tmp_12 = fadd float %tmp_7, %tmp_11
  store float %tmp_12, float addrspace(1)* %tmp_3
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

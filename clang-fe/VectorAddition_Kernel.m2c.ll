; ModuleID = '../kernel-src/VectorAddition_Kernel.cl'

define void @vectorAdd(float addrspace(1)* %output, float addrspace(1)* %inputA, float addrspace(1)* %inputB) {
block_0:
  %tmp0 = call i32 @__get_global_id_u32(i32 0)
  %tmp1 = getelementptr float addrspace(1)* %inputA, i32 %tmp0
  %tmp2 = load float addrspace(1)* %tmp1
  %tmp3 = getelementptr float addrspace(1)* %inputB, i32 %tmp0
  %tmp4 = load float addrspace(1)* %tmp3
  %tmp5 = fadd float %tmp2, %tmp4
  %tmp6 = getelementptr float addrspace(1)* %output, i32 %tmp0
  store float %tmp5, float addrspace(1)* %tmp6
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

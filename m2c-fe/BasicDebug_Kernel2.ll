; ModuleID = 'BasicDebug_Kernel2.bc'

define void @debugKernel(float addrspace(1)* %inputbuffer, float addrspace(1)* %outputbuffer) {
block_0:
  %inputbuffer_addr = alloca float addrspace(1)*
  store float addrspace(1)* %inputbuffer, float addrspace(1)** %inputbuffer_addr
  %outputbuffer_addr = alloca float addrspace(1)*
  store float addrspace(1)* %outputbuffer, float addrspace(1)** %outputbuffer_addr
  %globalID = alloca i32
  %value = alloca i32
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_0, i32* %globalID
  store i32 0, i32* %value
  %tmp_1 = load i32* %globalID
  %tmp_2 = load float addrspace(1)** %inputbuffer_addr
  %tmp_3 = getelementptr float addrspace(1)* %tmp_2, i32 %tmp_1
  %tmp_4 = load float addrspace(1)* %tmp_3
  %tmp_5 = fptoui float %tmp_4 to i32
  store i32 %tmp_5, i32* %value
  %tmp_6 = load i32* %globalID
  %tmp_7 = load float addrspace(1)** %outputbuffer_addr
  %tmp_8 = getelementptr float addrspace(1)* %tmp_7, i32 %tmp_6
  %tmp_9 = load i32* %value
  %tmp_10 = uitofp i32 %tmp_9 to float
  store float %tmp_10, float addrspace(1)* %tmp_8
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

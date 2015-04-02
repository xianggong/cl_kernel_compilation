; ModuleID = 'BasicDebug_Kernel2.opt.bc'

define void @debugKernel(float addrspace(1)* %inputbuffer, float addrspace(1)* %outputbuffer) {
block_0:
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  %tmp_3 = getelementptr float addrspace(1)* %inputbuffer, i32 %tmp_0
  %tmp_4 = load float addrspace(1)* %tmp_3
  %tmp_5 = fptoui float %tmp_4 to i32
  %tmp_8 = getelementptr float addrspace(1)* %outputbuffer, i32 %tmp_0
  %tmp_10 = uitofp i32 %tmp_5 to float
  store float %tmp_10, float addrspace(1)* %tmp_8
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

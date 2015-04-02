; ModuleID = 'Template_Kernels.opt.bc'

define void @templateKernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 %multiplier) {
block_0:
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  %tmp_3 = getelementptr i32 addrspace(1)* %output, i32 %tmp_0
  %tmp_6 = getelementptr i32 addrspace(1)* %input, i32 %tmp_0
  %tmp_7 = load i32 addrspace(1)* %tmp_6
  %tmp_9 = mul i32 %tmp_7, %multiplier
  store i32 %tmp_9, i32 addrspace(1)* %tmp_3
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

; ModuleID = 'Template_Kernels.bc'

define void @templateKernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 %multiplier) {
block_0:
  %output_addr = alloca i32 addrspace(1)*
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output_addr
  %input_addr = alloca i32 addrspace(1)*
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input_addr
  %multiplier_addr = alloca i32
  store i32 %multiplier, i32* %multiplier_addr
  %tid = alloca i32
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_0, i32* %tid
  %tmp_1 = load i32* %tid
  %tmp_2 = load i32 addrspace(1)** %output_addr
  %tmp_3 = getelementptr i32 addrspace(1)* %tmp_2, i32 %tmp_1
  %tmp_4 = load i32* %tid
  %tmp_5 = load i32 addrspace(1)** %input_addr
  %tmp_6 = getelementptr i32 addrspace(1)* %tmp_5, i32 %tmp_4
  %tmp_7 = load i32 addrspace(1)* %tmp_6
  %tmp_8 = load i32* %multiplier_addr
  %tmp_9 = mul i32 %tmp_7, %tmp_8
  store i32 %tmp_9, i32 addrspace(1)* %tmp_3
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

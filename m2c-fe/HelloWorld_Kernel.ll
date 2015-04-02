; ModuleID = 'HelloWorld_Kernel.bc'

define void @helloworld(i8 addrspace(1)* %in, i8 addrspace(1)* %out) {
block_0:
  %in_addr = alloca i8 addrspace(1)*
  store i8 addrspace(1)* %in, i8 addrspace(1)** %in_addr
  %out_addr = alloca i8 addrspace(1)*
  store i8 addrspace(1)* %out, i8 addrspace(1)** %out_addr
  %num = alloca i32
  br label %block_1

block_1:                                          ; preds = %block_0
  %tmp_0 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_0, i32* %num
  %tmp_1 = load i32* %num
  %tmp_2 = load i8 addrspace(1)** %out_addr
  %tmp_3 = getelementptr i8 addrspace(1)* %tmp_2, i32 %tmp_1
  %tmp_4 = load i32* %num
  %tmp_5 = load i8 addrspace(1)** %in_addr
  %tmp_6 = getelementptr i8 addrspace(1)* %tmp_5, i32 %tmp_4
  %tmp_7 = load i8 addrspace(1)* %tmp_6
  %tmp_8 = sext i8 %tmp_7 to i32
  %tmp_9 = add i32 %tmp_8, 1
  %tmp_10 = trunc i32 %tmp_9 to i8
  store i8 %tmp_10, i8 addrspace(1)* %tmp_3
  ret void
}

; Function Attrs: nounwind
declare i32 @__get_global_id_u32(i32) #0

attributes #0 = { nounwind }

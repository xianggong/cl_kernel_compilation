; ModuleID = 'DeviceFission_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_Add_kernel(i32 addrspace(1)* %input, i32 addrspace(1)* %output) #0 {
entry:
  %input.addr = alloca i32 addrspace(1)*, align 8
  %output.addr = alloca i32 addrspace(1)*, align 8
  %xPos = alloca i64, align 8
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call, i64* %xPos, align 8
  %0 = load i64* %xPos, align 8
  %1 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %1, i64 %0
  %2 = load i32 addrspace(1)* %arrayidx, align 4
  %add = add nsw i32 %2, 1
  %3 = load i64* %xPos, align 8
  %4 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx1 = getelementptr inbounds i32 addrspace(1)* %4, i64 %3
  store i32 %add, i32 addrspace(1)* %arrayidx1, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_Sub_kernel(i32 addrspace(1)* %input, i32 addrspace(1)* %output) #0 {
entry:
  %input.addr = alloca i32 addrspace(1)*, align 8
  %output.addr = alloca i32 addrspace(1)*, align 8
  %xPos = alloca i64, align 8
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call, i64* %xPos, align 8
  %0 = load i64* %xPos, align 8
  %1 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %1, i64 %0
  %2 = load i32 addrspace(1)* %arrayidx, align 4
  %sub = sub nsw i32 %2, 1
  %3 = load i64* %xPos, align 8
  %4 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx1 = getelementptr inbounds i32 addrspace(1)* %4, i64 %3
  store i32 %sub, i32 addrspace(1)* %arrayidx1, align 4
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!7}
!opencl.spir.version = !{!7}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @__OpenCL_Add_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"int*", metadata !"int*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"int*", metadata !"int*"}
!6 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @__OpenCL_Sub_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!7 = metadata !{i32 1, i32 2}

; ModuleID = 'Template_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_templateKernel_kernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 %multiplier) #0 {
entry:
  %output.addr = alloca i32 addrspace(1)*, align 8
  %input.addr = alloca i32 addrspace(1)*, align 8
  %multiplier.addr = alloca i32, align 4
  %tid = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 %multiplier, i32* %multiplier.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  %0 = load i32* %tid, align 4
  %idxprom = zext i32 %0 to i64
  %1 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %1, i64 %idxprom
  %2 = load i32 addrspace(1)* %arrayidx, align 4
  %3 = load i32* %multiplier.addr, align 4
  %mul = mul i32 %2, %3
  %4 = load i32* %tid, align 4
  %idxprom1 = zext i32 %4 to i64
  %5 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx2 = getelementptr inbounds i32 addrspace(1)* %5, i64 %idxprom1
  store i32 %mul, i32 addrspace(1)* %arrayidx2, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @__OpenCL_templateKernel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"uint"}
!6 = metadata !{i32 1, i32 2}

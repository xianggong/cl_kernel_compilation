; ModuleID = 'BasicDebug_Kernel2.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_debugKernel_kernel(float addrspace(1)* %inputbuffer, float addrspace(1)* %outputbuffer) #0 {
entry:
  %inputbuffer.addr = alloca float addrspace(1)*, align 8
  %outputbuffer.addr = alloca float addrspace(1)*, align 8
  %globalID = alloca i32, align 4
  %value = alloca i32, align 4
  store float addrspace(1)* %inputbuffer, float addrspace(1)** %inputbuffer.addr, align 8
  store float addrspace(1)* %outputbuffer, float addrspace(1)** %outputbuffer.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %globalID, align 4
  store i32 0, i32* %value, align 4
  %0 = load i32* %globalID, align 4
  %idxprom = zext i32 %0 to i64
  %1 = load float addrspace(1)** %inputbuffer.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %1, i64 %idxprom
  %2 = load float addrspace(1)* %arrayidx, align 4
  %conv1 = fptoui float %2 to i32
  store i32 %conv1, i32* %value, align 4
  %3 = load i32* %value, align 4
  %conv2 = uitofp i32 %3 to float
  %4 = load i32* %globalID, align 4
  %idxprom3 = zext i32 %4 to i64
  %5 = load float addrspace(1)** %outputbuffer.addr, align 8
  %arrayidx4 = getelementptr inbounds float addrspace(1)* %5, i64 %idxprom3
  store float %conv2, float addrspace(1)* %arrayidx4, align 4
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

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @__OpenCL_debugKernel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*"}
!6 = metadata !{i32 1, i32 2}

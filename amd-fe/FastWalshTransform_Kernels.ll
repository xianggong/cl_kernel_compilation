; ModuleID = 'FastWalshTransform_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_fastWalshTransform_kernel(float addrspace(1)* %tArray, i32 %step) #0 {
entry:
  %tArray.addr = alloca float addrspace(1)*, align 8
  %step.addr = alloca i32, align 4
  %tid = alloca i32, align 4
  %group = alloca i32, align 4
  %pair = alloca i32, align 4
  %match = alloca i32, align 4
  %T1 = alloca float, align 4
  %T2 = alloca float, align 4
  store float addrspace(1)* %tArray, float addrspace(1)** %tArray.addr, align 8
  store i32 %step, i32* %step.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  %0 = load i32* %tid, align 4
  %1 = load i32* %step.addr, align 4
  %rem = urem i32 %0, %1
  store i32 %rem, i32* %group, align 4
  %2 = load i32* %step.addr, align 4
  %mul = mul nsw i32 2, %2
  %3 = load i32* %tid, align 4
  %4 = load i32* %step.addr, align 4
  %div = udiv i32 %3, %4
  %mul1 = mul i32 %mul, %div
  %5 = load i32* %group, align 4
  %add = add i32 %mul1, %5
  store i32 %add, i32* %pair, align 4
  %6 = load i32* %pair, align 4
  %7 = load i32* %step.addr, align 4
  %add2 = add i32 %6, %7
  store i32 %add2, i32* %match, align 4
  %8 = load i32* %pair, align 4
  %idxprom = zext i32 %8 to i64
  %9 = load float addrspace(1)** %tArray.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %9, i64 %idxprom
  %10 = load float addrspace(1)* %arrayidx, align 4
  store float %10, float* %T1, align 4
  %11 = load i32* %match, align 4
  %idxprom3 = zext i32 %11 to i64
  %12 = load float addrspace(1)** %tArray.addr, align 8
  %arrayidx4 = getelementptr inbounds float addrspace(1)* %12, i64 %idxprom3
  %13 = load float addrspace(1)* %arrayidx4, align 4
  store float %13, float* %T2, align 4
  %14 = load float* %T1, align 4
  %15 = load float* %T2, align 4
  %add5 = fadd float %14, %15
  %16 = load i32* %pair, align 4
  %idxprom6 = zext i32 %16 to i64
  %17 = load float addrspace(1)** %tArray.addr, align 8
  %arrayidx7 = getelementptr inbounds float addrspace(1)* %17, i64 %idxprom6
  store float %add5, float addrspace(1)* %arrayidx7, align 4
  %18 = load float* %T1, align 4
  %19 = load float* %T2, align 4
  %sub = fsub float %18, %19
  %20 = load i32* %match, align 4
  %idxprom8 = zext i32 %20 to i64
  %21 = load float addrspace(1)** %tArray.addr, align 8
  %arrayidx9 = getelementptr inbounds float addrspace(1)* %21, i64 %idxprom8
  store float %sub, float addrspace(1)* %arrayidx9, align 4
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

!0 = metadata !{void (float addrspace(1)*, i32)* @__OpenCL_fastWalshTransform_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"int"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"int"}
!6 = metadata !{i32 1, i32 2}

; ModuleID = 'FastWalshTransform_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_fastWalshTransform_kernel(float addrspace(1)* %tArray, i32 %step) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %rem = urem i32 %conv, %step
  %mul = mul nsw i32 2, %step
  %div = udiv i32 %conv, %step
  %mul1 = mul i32 %mul, %div
  %add = add i32 %mul1, %rem
  %add2 = add i32 %add, %step
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %tArray, i64 %idxprom
  %0 = load float addrspace(1)* %arrayidx, align 4
  %idxprom3 = zext i32 %add2 to i64
  %arrayidx4 = getelementptr inbounds float addrspace(1)* %tArray, i64 %idxprom3
  %1 = load float addrspace(1)* %arrayidx4, align 4
  %add5 = fadd float %0, %1
  %idxprom6 = zext i32 %add to i64
  %arrayidx7 = getelementptr inbounds float addrspace(1)* %tArray, i64 %idxprom6
  store float %add5, float addrspace(1)* %arrayidx7, align 4
  %sub = fsub float %0, %1
  %idxprom8 = zext i32 %add2 to i64
  %arrayidx9 = getelementptr inbounds float addrspace(1)* %tArray, i64 %idxprom8
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

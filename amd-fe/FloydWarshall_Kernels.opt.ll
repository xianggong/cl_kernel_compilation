; ModuleID = 'FloydWarshall_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_floydWarshallPass_kernel(i32 addrspace(1)* %pathDistanceBuffer, i32 addrspace(1)* %pathBuffer, i32 %numNodes, i32 %pass) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %mul = mul i32 %conv2, %numNodes
  %add = add i32 %mul, %conv
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %mul3 = mul i32 %conv2, %numNodes
  %add4 = add i32 %mul3, %pass
  %idxprom5 = zext i32 %add4 to i64
  %arrayidx6 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i64 %idxprom5
  %1 = load i32 addrspace(1)* %arrayidx6, align 4
  %mul7 = mul i32 %pass, %numNodes
  %add8 = add i32 %mul7, %conv
  %idxprom9 = zext i32 %add8 to i64
  %arrayidx10 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i64 %idxprom9
  %2 = load i32 addrspace(1)* %arrayidx10, align 4
  %add11 = add i32 %1, %2
  %cmp = icmp slt i32 %add11, %0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %mul13 = mul i32 %conv2, %numNodes
  %add14 = add i32 %mul13, %conv
  %idxprom15 = zext i32 %add14 to i64
  %arrayidx16 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i64 %idxprom15
  store i32 %add11, i32 addrspace(1)* %arrayidx16, align 4
  %mul17 = mul i32 %conv2, %numNodes
  %add18 = add i32 %mul17, %conv
  %idxprom19 = zext i32 %add18 to i64
  %arrayidx20 = getelementptr inbounds i32 addrspace(1)* %pathBuffer, i64 %idxprom19
  store i32 %pass, i32 addrspace(1)* %arrayidx20, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
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

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32)* @__OpenCL_floydWarshallPass_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"const", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"uint", metadata !"uint"}
!6 = metadata !{i32 1, i32 2}

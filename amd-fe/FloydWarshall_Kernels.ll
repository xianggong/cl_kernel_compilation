; ModuleID = 'FloydWarshall_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_floydWarshallPass_kernel(i32 addrspace(1)* %pathDistanceBuffer, i32 addrspace(1)* %pathBuffer, i32 %numNodes, i32 %pass) #0 {
entry:
  %pathDistanceBuffer.addr = alloca i32 addrspace(1)*, align 8
  %pathBuffer.addr = alloca i32 addrspace(1)*, align 8
  %numNodes.addr = alloca i32, align 4
  %pass.addr = alloca i32, align 4
  %xValue = alloca i32, align 4
  %yValue = alloca i32, align 4
  %k = alloca i32, align 4
  %oldWeight = alloca i32, align 4
  %tempWeight = alloca i32, align 4
  store i32 addrspace(1)* %pathDistanceBuffer, i32 addrspace(1)** %pathDistanceBuffer.addr, align 8
  store i32 addrspace(1)* %pathBuffer, i32 addrspace(1)** %pathBuffer.addr, align 8
  store i32 %numNodes, i32* %numNodes.addr, align 4
  store i32 %pass, i32* %pass.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %xValue, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %yValue, align 4
  %0 = load i32* %pass.addr, align 4
  store i32 %0, i32* %k, align 4
  %1 = load i32* %yValue, align 4
  %2 = load i32* %numNodes.addr, align 4
  %mul = mul i32 %1, %2
  %3 = load i32* %xValue, align 4
  %add = add i32 %mul, %3
  %idxprom = zext i32 %add to i64
  %4 = load i32 addrspace(1)** %pathDistanceBuffer.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %4, i64 %idxprom
  %5 = load i32 addrspace(1)* %arrayidx, align 4
  store i32 %5, i32* %oldWeight, align 4
  %6 = load i32* %yValue, align 4
  %7 = load i32* %numNodes.addr, align 4
  %mul3 = mul i32 %6, %7
  %8 = load i32* %k, align 4
  %add4 = add i32 %mul3, %8
  %idxprom5 = zext i32 %add4 to i64
  %9 = load i32 addrspace(1)** %pathDistanceBuffer.addr, align 8
  %arrayidx6 = getelementptr inbounds i32 addrspace(1)* %9, i64 %idxprom5
  %10 = load i32 addrspace(1)* %arrayidx6, align 4
  %11 = load i32* %k, align 4
  %12 = load i32* %numNodes.addr, align 4
  %mul7 = mul i32 %11, %12
  %13 = load i32* %xValue, align 4
  %add8 = add i32 %mul7, %13
  %idxprom9 = zext i32 %add8 to i64
  %14 = load i32 addrspace(1)** %pathDistanceBuffer.addr, align 8
  %arrayidx10 = getelementptr inbounds i32 addrspace(1)* %14, i64 %idxprom9
  %15 = load i32 addrspace(1)* %arrayidx10, align 4
  %add11 = add i32 %10, %15
  store i32 %add11, i32* %tempWeight, align 4
  %16 = load i32* %tempWeight, align 4
  %17 = load i32* %oldWeight, align 4
  %cmp = icmp slt i32 %16, %17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %18 = load i32* %tempWeight, align 4
  %19 = load i32* %yValue, align 4
  %20 = load i32* %numNodes.addr, align 4
  %mul13 = mul i32 %19, %20
  %21 = load i32* %xValue, align 4
  %add14 = add i32 %mul13, %21
  %idxprom15 = zext i32 %add14 to i64
  %22 = load i32 addrspace(1)** %pathDistanceBuffer.addr, align 8
  %arrayidx16 = getelementptr inbounds i32 addrspace(1)* %22, i64 %idxprom15
  store i32 %18, i32 addrspace(1)* %arrayidx16, align 4
  %23 = load i32* %k, align 4
  %24 = load i32* %yValue, align 4
  %25 = load i32* %numNodes.addr, align 4
  %mul17 = mul i32 %24, %25
  %26 = load i32* %xValue, align 4
  %add18 = add i32 %mul17, %26
  %idxprom19 = zext i32 %add18 to i64
  %27 = load i32 addrspace(1)** %pathBuffer.addr, align 8
  %arrayidx20 = getelementptr inbounds i32 addrspace(1)* %27, i64 %idxprom19
  store i32 %23, i32 addrspace(1)* %arrayidx20, align 4
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

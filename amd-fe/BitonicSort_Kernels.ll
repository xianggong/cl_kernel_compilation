; ModuleID = 'BitonicSort_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_bitonicSort_kernel(i32 addrspace(1)* %theArray, i32 %stage, i32 %passOfStage, i32 %direction) #0 {
entry:
  %theArray.addr = alloca i32 addrspace(1)*, align 8
  %stage.addr = alloca i32, align 4
  %passOfStage.addr = alloca i32, align 4
  %direction.addr = alloca i32, align 4
  %sortIncreasing = alloca i32, align 4
  %threadId = alloca i32, align 4
  %pairDistance = alloca i32, align 4
  %blockWidth = alloca i32, align 4
  %leftId = alloca i32, align 4
  %rightId = alloca i32, align 4
  %leftElement = alloca i32, align 4
  %rightElement = alloca i32, align 4
  %sameDirectionBlockWidth = alloca i32, align 4
  %greater = alloca i32, align 4
  %lesser = alloca i32, align 4
  store i32 addrspace(1)* %theArray, i32 addrspace(1)** %theArray.addr, align 8
  store i32 %stage, i32* %stage.addr, align 4
  store i32 %passOfStage, i32* %passOfStage.addr, align 4
  store i32 %direction, i32* %direction.addr, align 4
  %0 = load i32* %direction.addr, align 4
  store i32 %0, i32* %sortIncreasing, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %threadId, align 4
  %1 = load i32* %stage.addr, align 4
  %2 = load i32* %passOfStage.addr, align 4
  %sub = sub i32 %1, %2
  %shl.mask = and i32 %sub, 31
  %shl = shl i32 1, %shl.mask
  store i32 %shl, i32* %pairDistance, align 4
  %3 = load i32* %pairDistance, align 4
  %mul = mul i32 2, %3
  store i32 %mul, i32* %blockWidth, align 4
  %4 = load i32* %threadId, align 4
  %5 = load i32* %pairDistance, align 4
  %rem = urem i32 %4, %5
  %6 = load i32* %threadId, align 4
  %7 = load i32* %pairDistance, align 4
  %div = udiv i32 %6, %7
  %8 = load i32* %blockWidth, align 4
  %mul1 = mul i32 %div, %8
  %add = add i32 %rem, %mul1
  store i32 %add, i32* %leftId, align 4
  %9 = load i32* %leftId, align 4
  %10 = load i32* %pairDistance, align 4
  %add2 = add i32 %9, %10
  store i32 %add2, i32* %rightId, align 4
  %11 = load i32* %leftId, align 4
  %idxprom = zext i32 %11 to i64
  %12 = load i32 addrspace(1)** %theArray.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %12, i64 %idxprom
  %13 = load i32 addrspace(1)* %arrayidx, align 4
  store i32 %13, i32* %leftElement, align 4
  %14 = load i32* %rightId, align 4
  %idxprom3 = zext i32 %14 to i64
  %15 = load i32 addrspace(1)** %theArray.addr, align 8
  %arrayidx4 = getelementptr inbounds i32 addrspace(1)* %15, i64 %idxprom3
  %16 = load i32 addrspace(1)* %arrayidx4, align 4
  store i32 %16, i32* %rightElement, align 4
  %17 = load i32* %stage.addr, align 4
  %shl.mask5 = and i32 %17, 31
  %shl6 = shl i32 1, %shl.mask5
  store i32 %shl6, i32* %sameDirectionBlockWidth, align 4
  %18 = load i32* %threadId, align 4
  %19 = load i32* %sameDirectionBlockWidth, align 4
  %div7 = udiv i32 %18, %19
  %rem8 = urem i32 %div7, 2
  %cmp = icmp eq i32 %rem8, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %20 = load i32* %sortIncreasing, align 4
  %sub10 = sub i32 1, %20
  store i32 %sub10, i32* %sortIncreasing, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %21 = load i32* %leftElement, align 4
  %22 = load i32* %rightElement, align 4
  %cmp11 = icmp ugt i32 %21, %22
  br i1 %cmp11, label %if.then13, label %if.else

if.then13:                                        ; preds = %if.end
  %23 = load i32* %leftElement, align 4
  store i32 %23, i32* %greater, align 4
  %24 = load i32* %rightElement, align 4
  store i32 %24, i32* %lesser, align 4
  br label %if.end14

if.else:                                          ; preds = %if.end
  %25 = load i32* %rightElement, align 4
  store i32 %25, i32* %greater, align 4
  %26 = load i32* %leftElement, align 4
  store i32 %26, i32* %lesser, align 4
  br label %if.end14

if.end14:                                         ; preds = %if.else, %if.then13
  %27 = load i32* %sortIncreasing, align 4
  %tobool = icmp ne i32 %27, 0
  br i1 %tobool, label %if.then15, label %if.else20

if.then15:                                        ; preds = %if.end14
  %28 = load i32* %lesser, align 4
  %29 = load i32* %leftId, align 4
  %idxprom16 = zext i32 %29 to i64
  %30 = load i32 addrspace(1)** %theArray.addr, align 8
  %arrayidx17 = getelementptr inbounds i32 addrspace(1)* %30, i64 %idxprom16
  store i32 %28, i32 addrspace(1)* %arrayidx17, align 4
  %31 = load i32* %greater, align 4
  %32 = load i32* %rightId, align 4
  %idxprom18 = zext i32 %32 to i64
  %33 = load i32 addrspace(1)** %theArray.addr, align 8
  %arrayidx19 = getelementptr inbounds i32 addrspace(1)* %33, i64 %idxprom18
  store i32 %31, i32 addrspace(1)* %arrayidx19, align 4
  br label %if.end25

if.else20:                                        ; preds = %if.end14
  %34 = load i32* %greater, align 4
  %35 = load i32* %leftId, align 4
  %idxprom21 = zext i32 %35 to i64
  %36 = load i32 addrspace(1)** %theArray.addr, align 8
  %arrayidx22 = getelementptr inbounds i32 addrspace(1)* %36, i64 %idxprom21
  store i32 %34, i32 addrspace(1)* %arrayidx22, align 4
  %37 = load i32* %lesser, align 4
  %38 = load i32* %rightId, align 4
  %idxprom23 = zext i32 %38 to i64
  %39 = load i32 addrspace(1)** %theArray.addr, align 8
  %arrayidx24 = getelementptr inbounds i32 addrspace(1)* %39, i64 %idxprom23
  store i32 %37, i32 addrspace(1)* %arrayidx24, align 4
  br label %if.end25

if.end25:                                         ; preds = %if.else20, %if.then15
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

!0 = metadata !{void (i32 addrspace(1)*, i32, i32, i32)* @__OpenCL_bitonicSort_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"const", metadata !"const", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{i32 1, i32 2}

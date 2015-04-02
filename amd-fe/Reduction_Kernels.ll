; ModuleID = 'Reduction_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_reduce_kernel(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(3)* %sdata) #0 {
entry:
  %input.addr = alloca <4 x i32> addrspace(1)*, align 8
  %output.addr = alloca <4 x i32> addrspace(1)*, align 8
  %sdata.addr = alloca <4 x i32> addrspace(3)*, align 8
  %tid = alloca i32, align 4
  %bid = alloca i32, align 4
  %gid = alloca i32, align 4
  %localSize = alloca i32, align 4
  %stride = alloca i32, align 4
  %s = alloca i32, align 4
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %input.addr, align 8
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %output.addr, align 8
  store <4 x i32> addrspace(3)* %sdata, <4 x i32> addrspace(3)** %sdata.addr, align 8
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %bid, align 4
  %call3 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %gid, align 4
  %call5 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %localSize, align 4
  %0 = load i32* %gid, align 4
  %mul = mul i32 %0, 2
  store i32 %mul, i32* %stride, align 4
  %1 = load i32* %stride, align 4
  %idxprom = zext i32 %1 to i64
  %2 = load <4 x i32> addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %2, i64 %idxprom
  %3 = load <4 x i32> addrspace(1)* %arrayidx, align 16
  %4 = load i32* %stride, align 4
  %add = add i32 %4, 1
  %idxprom7 = zext i32 %add to i64
  %5 = load <4 x i32> addrspace(1)** %input.addr, align 8
  %arrayidx8 = getelementptr inbounds <4 x i32> addrspace(1)* %5, i64 %idxprom7
  %6 = load <4 x i32> addrspace(1)* %arrayidx8, align 16
  %add9 = add <4 x i32> %3, %6
  %7 = load i32* %tid, align 4
  %idxprom10 = zext i32 %7 to i64
  %8 = load <4 x i32> addrspace(3)** %sdata.addr, align 8
  %arrayidx11 = getelementptr inbounds <4 x i32> addrspace(3)* %8, i64 %idxprom10
  store <4 x i32> %add9, <4 x i32> addrspace(3)* %arrayidx11, align 16
  call cc75 void @_Z7barrierj(i32 1)
  %9 = load i32* %localSize, align 4
  %shr = lshr i32 %9, 1
  store i32 %shr, i32* %s, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %10 = load i32* %s, align 4
  %cmp = icmp ugt i32 %10, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %11 = load i32* %tid, align 4
  %12 = load i32* %s, align 4
  %cmp13 = icmp ult i32 %11, %12
  br i1 %cmp13, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %13 = load i32* %tid, align 4
  %14 = load i32* %s, align 4
  %add15 = add i32 %13, %14
  %idxprom16 = zext i32 %add15 to i64
  %15 = load <4 x i32> addrspace(3)** %sdata.addr, align 8
  %arrayidx17 = getelementptr inbounds <4 x i32> addrspace(3)* %15, i64 %idxprom16
  %16 = load <4 x i32> addrspace(3)* %arrayidx17, align 16
  %17 = load i32* %tid, align 4
  %idxprom18 = zext i32 %17 to i64
  %18 = load <4 x i32> addrspace(3)** %sdata.addr, align 8
  %arrayidx19 = getelementptr inbounds <4 x i32> addrspace(3)* %18, i64 %idxprom18
  %19 = load <4 x i32> addrspace(3)* %arrayidx19, align 16
  %add20 = add <4 x i32> %19, %16
  store <4 x i32> %add20, <4 x i32> addrspace(3)* %arrayidx19, align 16
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %20 = load i32* %s, align 4
  %shr21 = lshr i32 %20, 1
  store i32 %shr21, i32* %s, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %21 = load i32* %tid, align 4
  %cmp22 = icmp eq i32 %21, 0
  br i1 %cmp22, label %if.then24, label %if.end28

if.then24:                                        ; preds = %for.end
  %22 = load <4 x i32> addrspace(3)** %sdata.addr, align 8
  %arrayidx25 = getelementptr inbounds <4 x i32> addrspace(3)* %22, i64 0
  %23 = load <4 x i32> addrspace(3)* %arrayidx25, align 16
  %24 = load i32* %bid, align 4
  %idxprom26 = zext i32 %24 to i64
  %25 = load <4 x i32> addrspace(1)** %output.addr, align 8
  %arrayidx27 = getelementptr inbounds <4 x i32> addrspace(1)* %25, i64 %idxprom26
  store <4 x i32> %23, <4 x i32> addrspace(1)* %arrayidx27, align 16
  br label %if.end28

if.end28:                                         ; preds = %if.then24, %for.end
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

declare cc75 void @_Z7barrierj(i32)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @__OpenCL_reduce_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint4*", metadata !"uint4*", metadata !"uint4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint4*", metadata !"uint4*", metadata !"uint4*"}
!6 = metadata !{i32 1, i32 2}

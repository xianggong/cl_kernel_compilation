; ModuleID = 'MemoryModel.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@mask = addrspace(2) constant [4 x i32] [i32 1, i32 -1, i32 2, i32 -2], align 4
@MemoryModel.localBuffer = internal addrspace(3) global [64 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_MemoryModel_kernel(i32 addrspace(1)* %outputbuffer, i32 addrspace(1)* %inputbuffer) #0 {
entry:
  %outputbuffer.addr = alloca i32 addrspace(1)*, align 8
  %inputbuffer.addr = alloca i32 addrspace(1)*, align 8
  %result = alloca i32, align 4
  %group_id = alloca i64, align 8
  %item_id = alloca i64, align 8
  %gid = alloca i64, align 8
  %i = alloca i32, align 4
  store i32 addrspace(1)* %outputbuffer, i32 addrspace(1)** %outputbuffer.addr, align 8
  store i32 addrspace(1)* %inputbuffer, i32 addrspace(1)** %inputbuffer.addr, align 8
  store i32 0, i32* %result, align 4
  %call = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  store i64 %call, i64* %group_id, align 8
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  store i64 %call1, i64* %item_id, align 8
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  store i64 %call2, i64* %gid, align 8
  %0 = load i64* %gid, align 8
  %1 = load i32 addrspace(1)** %inputbuffer.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %1, i64 %0
  %2 = load i32 addrspace(1)* %arrayidx, align 4
  %3 = load i64* %item_id, align 8
  %arrayidx3 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i64 %3
  store i32 %2, i32 addrspace(3)* %arrayidx3, align 4
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32* %i, align 4
  %cmp = icmp slt i32 %4, 4
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %5 = load i64* %item_id, align 8
  %6 = load i32* %i, align 4
  %conv = sext i32 %6 to i64
  %add = add i64 %5, %conv
  %rem = urem i64 %add, 64
  %arrayidx4 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i64 %rem
  %7 = load i32 addrspace(3)* %arrayidx4, align 4
  %8 = load i32* %result, align 4
  %add5 = add nsw i32 %8, %7
  store i32 %add5, i32* %result, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %9 = load i32* %i, align 4
  %inc = add nsw i32 %9, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %10 = load i64* %group_id, align 8
  %rem6 = urem i64 %10, 4
  %arrayidx7 = getelementptr inbounds [4 x i32] addrspace(2)* @mask, i32 0, i64 %rem6
  %11 = load i32 addrspace(2)* %arrayidx7, align 4
  %12 = load i32* %result, align 4
  %mul = mul nsw i32 %12, %11
  store i32 %mul, i32* %result, align 4
  %13 = load i32* %result, align 4
  %14 = load i64* %gid, align 8
  %15 = load i32 addrspace(1)** %outputbuffer.addr, align 8
  %arrayidx8 = getelementptr inbounds i32 addrspace(1)* %15, i64 %14
  store i32 %13, i32 addrspace(1)* %arrayidx8, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @__OpenCL_MemoryModel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"int*", metadata !"int*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"int*", metadata !"int*"}
!6 = metadata !{i32 1, i32 2}

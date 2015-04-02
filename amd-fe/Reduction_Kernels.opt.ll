; ModuleID = 'Reduction_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_reduce_kernel(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(3)* %sdata) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv6 = trunc i64 %call5 to i32
  %mul = mul i32 %conv4, 2
  %idxprom = zext i32 %mul to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %idxprom
  %0 = load <4 x i32> addrspace(1)* %arrayidx, align 16
  %add = add i32 %mul, 1
  %idxprom7 = zext i32 %add to i64
  %arrayidx8 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %idxprom7
  %1 = load <4 x i32> addrspace(1)* %arrayidx8, align 16
  %add9 = add <4 x i32> %0, %1
  %idxprom10 = zext i32 %conv to i64
  %arrayidx11 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i64 %idxprom10
  store <4 x i32> %add9, <4 x i32> addrspace(3)* %arrayidx11, align 16
  call cc75 void @_Z7barrierj(i32 1)
  %shr = lshr i32 %conv6, 1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %s.0 = phi i32 [ %shr, %entry ], [ %shr21, %for.inc ]
  %cmp = icmp ugt i32 %s.0, 0
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %cmp13 = icmp ult i32 %conv, %s.0
  br i1 %cmp13, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %add15 = add i32 %conv, %s.0
  %idxprom16 = zext i32 %add15 to i64
  %arrayidx17 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i64 %idxprom16
  %2 = load <4 x i32> addrspace(3)* %arrayidx17, align 16
  %idxprom18 = zext i32 %conv to i64
  %arrayidx19 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i64 %idxprom18
  %3 = load <4 x i32> addrspace(3)* %arrayidx19, align 16
  %add20 = add <4 x i32> %3, %2
  store <4 x i32> %add20, <4 x i32> addrspace(3)* %arrayidx19, align 16
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %shr21 = lshr i32 %s.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %cmp22 = icmp eq i32 %conv, 0
  br i1 %cmp22, label %if.then24, label %if.end28

if.then24:                                        ; preds = %for.end
  %arrayidx25 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i64 0
  %4 = load <4 x i32> addrspace(3)* %arrayidx25, align 16
  %idxprom26 = zext i32 %conv2 to i64
  %arrayidx27 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %idxprom26
  store <4 x i32> %4, <4 x i32> addrspace(1)* %arrayidx27, align 16
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

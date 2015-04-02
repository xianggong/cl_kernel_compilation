; ModuleID = 'AsyncDataTransfer_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_work_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %multiplier) #0 {
entry:
  %zero = alloca i32, align 4
  %call = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store volatile i32 0, i32* %zero, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %tmp.0 = phi i32 [ 1, %entry ], [ %add30, %for.inc ]
  %i.0 = phi i32 [ 5, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 100
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul nsw i32 %i.0, 1
  %rem = srem i32 %mul, %conv
  %idxprom = sext i32 %rem to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom
  %0 = load i8 addrspace(1)* %arrayidx, align 1
  %conv6 = zext i8 %0 to i32
  %mul7 = mul nsw i32 %i.0, 2
  %rem8 = srem i32 %mul7, %conv
  %idxprom9 = sext i32 %rem8 to i64
  %arrayidx10 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom9
  %1 = load i8 addrspace(1)* %arrayidx10, align 1
  %conv11 = zext i8 %1 to i32
  %add = add nsw i32 %conv6, %conv11
  %mul12 = mul nsw i32 %i.0, 3
  %rem13 = srem i32 %mul12, %conv
  %idxprom14 = sext i32 %rem13 to i64
  %arrayidx15 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom14
  %2 = load i8 addrspace(1)* %arrayidx15, align 1
  %conv16 = zext i8 %2 to i32
  %add17 = add nsw i32 %add, %conv16
  %mul18 = mul nsw i32 %i.0, 4
  %rem19 = srem i32 %mul18, %conv
  %idxprom20 = sext i32 %rem19 to i64
  %arrayidx21 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom20
  %3 = load i8 addrspace(1)* %arrayidx21, align 1
  %conv22 = zext i8 %3 to i32
  %add23 = add nsw i32 %add17, %conv22
  %mul24 = mul nsw i32 %i.0, 5
  %rem25 = srem i32 %mul24, %conv
  %idxprom26 = sext i32 %rem25 to i64
  %arrayidx27 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom26
  %4 = load i8 addrspace(1)* %arrayidx27, align 1
  %conv28 = zext i8 %4 to i32
  %add29 = add nsw i32 %add23, %conv28
  %add30 = add i32 %tmp.0, %add29
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %idxprom31 = sext i32 %conv2 to i64
  %arrayidx32 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom31
  %5 = load i8 addrspace(1)* %arrayidx32, align 1
  %conv33 = zext i8 %5 to i32
  %mul34 = mul nsw i32 %conv33, %multiplier
  %rem35 = srem i32 %mul34, 256
  %6 = load volatile i32* %zero, align 4
  %mul36 = mul i32 %6, %tmp.0
  %add37 = add i32 %rem35, %mul36
  %conv38 = trunc i32 %add37 to i8
  %idxprom39 = sext i32 %conv2 to i64
  %arrayidx40 = getelementptr inbounds i8 addrspace(1)* %output, i64 %idxprom39
  store i8 %conv38, i8 addrspace(1)* %arrayidx40, align 1
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32)* @__OpenCL_work_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar*", metadata !"uchar*", metadata !"int"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar*", metadata !"uchar*", metadata !"int"}
!6 = metadata !{i32 1, i32 2}

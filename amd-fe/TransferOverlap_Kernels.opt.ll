; ModuleID = 'TransferOverlap_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@readKernel.lcount = internal addrspace(3) global i32 0, align 4
@writeKernel.lval = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_readKernel_kernel(<4 x i32> addrspace(1)* %in, i32 addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp = icmp eq i64 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32 addrspace(3)* @readKernel.lcount, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond

for.cond:                                         ; preds = %for.inc36, %if.end
  %pcount.0 = phi i32 [ 0, %if.end ], [ %pcount.1, %for.inc36 ]
  %n.0 = phi i32 [ 0, %if.end ], [ %inc37, %for.inc36 ]
  %cmp1 = icmp ult i32 %n.0, %nk
  br i1 %cmp1, label %for.body, label %for.end38

for.body:                                         ; preds = %for.cond
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call2 to i32
  br label %for.cond3

for.cond3:                                        ; preds = %for.inc, %for.body
  %pcount.1 = phi i32 [ %pcount.0, %for.body ], [ %pcount.5, %for.inc ]
  %i.0 = phi i32 [ 0, %for.body ], [ %inc32, %for.inc ]
  %idx.0 = phi i32 [ %conv, %for.body ], [ %conv35, %for.inc ]
  %cmp4 = icmp ult i32 %i.0, %ni
  br i1 %cmp4, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond3
  %idxprom = zext i32 %idx.0 to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %in, i64 %idxprom
  %0 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %1 = extractelement <4 x i32> %0, i32 0
  %cmp7 = icmp eq i32 %1, %val
  br i1 %cmp7, label %if.then9, label %if.end10

if.then9:                                         ; preds = %for.body6
  %inc = add i32 %pcount.1, 1
  br label %if.end10

if.end10:                                         ; preds = %if.then9, %for.body6
  %pcount.2 = phi i32 [ %inc, %if.then9 ], [ %pcount.1, %for.body6 ]
  %idxprom11 = zext i32 %idx.0 to i64
  %arrayidx12 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i64 %idxprom11
  %2 = load volatile <4 x i32> addrspace(1)* %arrayidx12, align 16
  %3 = extractelement <4 x i32> %2, i32 1
  %cmp13 = icmp eq i32 %3, %val
  br i1 %cmp13, label %if.then15, label %if.end17

if.then15:                                        ; preds = %if.end10
  %inc16 = add i32 %pcount.2, 1
  br label %if.end17

if.end17:                                         ; preds = %if.then15, %if.end10
  %pcount.3 = phi i32 [ %inc16, %if.then15 ], [ %pcount.2, %if.end10 ]
  %idxprom18 = zext i32 %idx.0 to i64
  %arrayidx19 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i64 %idxprom18
  %4 = load volatile <4 x i32> addrspace(1)* %arrayidx19, align 16
  %5 = extractelement <4 x i32> %4, i32 2
  %cmp20 = icmp eq i32 %5, %val
  br i1 %cmp20, label %if.then22, label %if.end24

if.then22:                                        ; preds = %if.end17
  %inc23 = add i32 %pcount.3, 1
  br label %if.end24

if.end24:                                         ; preds = %if.then22, %if.end17
  %pcount.4 = phi i32 [ %inc23, %if.then22 ], [ %pcount.3, %if.end17 ]
  %idxprom25 = zext i32 %idx.0 to i64
  %arrayidx26 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i64 %idxprom25
  %6 = load volatile <4 x i32> addrspace(1)* %arrayidx26, align 16
  %7 = extractelement <4 x i32> %6, i32 3
  %cmp27 = icmp eq i32 %7, %val
  br i1 %cmp27, label %if.then29, label %if.end31

if.then29:                                        ; preds = %if.end24
  %inc30 = add i32 %pcount.4, 1
  br label %if.end31

if.end31:                                         ; preds = %if.then29, %if.end24
  %pcount.5 = phi i32 [ %inc30, %if.then29 ], [ %pcount.4, %if.end24 ]
  br label %for.inc

for.inc:                                          ; preds = %if.end31
  %inc32 = add i32 %i.0, 1
  %call33 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv34 = zext i32 %idx.0 to i64
  %add = add i64 %conv34, %call33
  %conv35 = trunc i64 %add to i32
  br label %for.cond3

for.end:                                          ; preds = %for.cond3
  br label %for.inc36

for.inc36:                                        ; preds = %for.end
  %inc37 = add nsw i32 %n.0, 1
  br label %for.cond

for.end38:                                        ; preds = %for.cond
  %call39 = call cc75 i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @readKernel.lcount, i32 %pcount.0)
  call cc75 void @_Z7barrierj(i32 1)
  %call40 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp41 = icmp eq i64 %call40, 0
  br i1 %cmp41, label %if.then43, label %if.end46

if.then43:                                        ; preds = %for.end38
  %8 = load i32 addrspace(3)* @readKernel.lcount, align 4
  %div = udiv i32 %8, %nk
  %call44 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %arrayidx45 = getelementptr inbounds i32 addrspace(1)* %out, i64 %call44
  store volatile i32 %div, i32 addrspace(1)* %arrayidx45, align 4
  br label %if.end46

if.end46:                                         ; preds = %if.then43, %for.end38
  %call47 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %cmp48 = icmp eq i64 %call47, 0
  br i1 %cmp48, label %if.then50, label %if.end54

if.then50:                                        ; preds = %if.end46
  %call51 = call cc75 i64 @_Z14get_num_groupsj(i32 0) #1
  %add52 = add i64 %call51, 1
  %arrayidx53 = getelementptr inbounds i32 addrspace(1)* %out, i64 %add52
  store volatile i32 %val, i32 addrspace(1)* %arrayidx53, align 4
  br label %if.end54

if.end54:                                         ; preds = %if.then50, %if.end46
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

declare cc75 i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32)

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_num_groupsj(i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_writeKernel_kernel(i32 addrspace(1)* %in, <4 x i32> addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp = icmp eq i64 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call1 = call cc75 i64 @_Z14get_num_groupsj(i32 0) #1
  %add = add i64 %call1, 1
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %in, i64 %add
  %0 = load volatile i32 addrspace(1)* %arrayidx, align 4
  store i32 %0, i32 addrspace(3)* @writeKernel.lval, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  call cc75 void @_Z7barrierj(i32 1)
  %1 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %vecinit = insertelement <4 x i32> undef, i32 %1, i32 0
  %2 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %vecinit2 = insertelement <4 x i32> %vecinit, i32 %2, i32 1
  %3 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %vecinit3 = insertelement <4 x i32> %vecinit2, i32 %3, i32 2
  %4 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %vecinit4 = insertelement <4 x i32> %vecinit3, i32 %4, i32 3
  br label %for.cond

for.cond:                                         ; preds = %for.inc16, %if.end
  %n.0 = phi i32 [ 0, %if.end ], [ %inc17, %for.inc16 ]
  %cmp5 = icmp ult i32 %n.0, %nk
  br i1 %cmp5, label %for.body, label %for.end18

for.body:                                         ; preds = %for.cond
  %call6 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call6 to i32
  br label %for.cond7

for.cond7:                                        ; preds = %for.inc, %for.body
  %i.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %idx.0 = phi i32 [ %conv, %for.body ], [ %conv15, %for.inc ]
  %cmp8 = icmp ult i32 %i.0, %ni
  br i1 %cmp8, label %for.body10, label %for.end

for.body10:                                       ; preds = %for.cond7
  %idxprom = zext i32 %idx.0 to i64
  %arrayidx11 = getelementptr inbounds <4 x i32> addrspace(1)* %out, i64 %idxprom
  store volatile <4 x i32> %vecinit4, <4 x i32> addrspace(1)* %arrayidx11, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body10
  %inc = add i32 %i.0, 1
  %call12 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv13 = zext i32 %idx.0 to i64
  %add14 = add i64 %conv13, %call12
  %conv15 = trunc i64 %add14 to i32
  br label %for.cond7

for.end:                                          ; preds = %for.cond7
  br label %for.inc16

for.inc16:                                        ; preds = %for.end
  %inc17 = add nsw i32 %n.0, 1
  br label %for.cond

for.end18:                                        ; preds = %for.cond
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!9}
!opencl.spir.version = !{!9}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @__OpenCL_readKernel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint4*", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"volatile", metadata !"volatile", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint4*", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @__OpenCL_writeKernel_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint4*", metadata !"uint", metadata !"uint", metadata !"uint"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint4*", metadata !"uint", metadata !"uint", metadata !"uint"}
!9 = metadata !{i32 1, i32 2}

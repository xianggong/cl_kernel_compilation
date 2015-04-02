; ModuleID = 'TransferOverlap_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@readKernel.lcount = internal addrspace(3) global i32 0, align 4
@writeKernel.lval = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_readKernel_kernel(<4 x i32> addrspace(1)* %in, i32 addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
entry:
  %in.addr = alloca <4 x i32> addrspace(1)*, align 8
  %out.addr = alloca i32 addrspace(1)*, align 8
  %ni.addr = alloca i32, align 4
  %val.addr = alloca i32, align 4
  %nk.addr = alloca i32, align 4
  %pcount = alloca i32, align 4
  %i = alloca i32, align 4
  %idx = alloca i32, align 4
  %n = alloca i32, align 4
  store <4 x i32> addrspace(1)* %in, <4 x i32> addrspace(1)** %in.addr, align 8
  store i32 addrspace(1)* %out, i32 addrspace(1)** %out.addr, align 8
  store i32 %ni, i32* %ni.addr, align 4
  store i32 %val, i32* %val.addr, align 4
  store i32 %nk, i32* %nk.addr, align 4
  store i32 0, i32* %pcount, align 4
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp = icmp eq i64 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32 addrspace(3)* @readKernel.lcount, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %n, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc36, %if.end
  %0 = load i32* %n, align 4
  %1 = load i32* %nk.addr, align 4
  %cmp1 = icmp ult i32 %0, %1
  br i1 %cmp1, label %for.body, label %for.end38

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call2 to i32
  store i32 %conv, i32* %idx, align 4
  br label %for.cond3

for.cond3:                                        ; preds = %for.inc, %for.body
  %2 = load i32* %i, align 4
  %3 = load i32* %ni.addr, align 4
  %cmp4 = icmp ult i32 %2, %3
  br i1 %cmp4, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond3
  %4 = load i32* %idx, align 4
  %idxprom = zext i32 %4 to i64
  %5 = load <4 x i32> addrspace(1)** %in.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %5, i64 %idxprom
  %6 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %7 = extractelement <4 x i32> %6, i32 0
  %8 = load i32* %val.addr, align 4
  %cmp7 = icmp eq i32 %7, %8
  br i1 %cmp7, label %if.then9, label %if.end10

if.then9:                                         ; preds = %for.body6
  %9 = load i32* %pcount, align 4
  %inc = add i32 %9, 1
  store i32 %inc, i32* %pcount, align 4
  br label %if.end10

if.end10:                                         ; preds = %if.then9, %for.body6
  %10 = load i32* %idx, align 4
  %idxprom11 = zext i32 %10 to i64
  %11 = load <4 x i32> addrspace(1)** %in.addr, align 8
  %arrayidx12 = getelementptr inbounds <4 x i32> addrspace(1)* %11, i64 %idxprom11
  %12 = load volatile <4 x i32> addrspace(1)* %arrayidx12, align 16
  %13 = extractelement <4 x i32> %12, i32 1
  %14 = load i32* %val.addr, align 4
  %cmp13 = icmp eq i32 %13, %14
  br i1 %cmp13, label %if.then15, label %if.end17

if.then15:                                        ; preds = %if.end10
  %15 = load i32* %pcount, align 4
  %inc16 = add i32 %15, 1
  store i32 %inc16, i32* %pcount, align 4
  br label %if.end17

if.end17:                                         ; preds = %if.then15, %if.end10
  %16 = load i32* %idx, align 4
  %idxprom18 = zext i32 %16 to i64
  %17 = load <4 x i32> addrspace(1)** %in.addr, align 8
  %arrayidx19 = getelementptr inbounds <4 x i32> addrspace(1)* %17, i64 %idxprom18
  %18 = load volatile <4 x i32> addrspace(1)* %arrayidx19, align 16
  %19 = extractelement <4 x i32> %18, i32 2
  %20 = load i32* %val.addr, align 4
  %cmp20 = icmp eq i32 %19, %20
  br i1 %cmp20, label %if.then22, label %if.end24

if.then22:                                        ; preds = %if.end17
  %21 = load i32* %pcount, align 4
  %inc23 = add i32 %21, 1
  store i32 %inc23, i32* %pcount, align 4
  br label %if.end24

if.end24:                                         ; preds = %if.then22, %if.end17
  %22 = load i32* %idx, align 4
  %idxprom25 = zext i32 %22 to i64
  %23 = load <4 x i32> addrspace(1)** %in.addr, align 8
  %arrayidx26 = getelementptr inbounds <4 x i32> addrspace(1)* %23, i64 %idxprom25
  %24 = load volatile <4 x i32> addrspace(1)* %arrayidx26, align 16
  %25 = extractelement <4 x i32> %24, i32 3
  %26 = load i32* %val.addr, align 4
  %cmp27 = icmp eq i32 %25, %26
  br i1 %cmp27, label %if.then29, label %if.end31

if.then29:                                        ; preds = %if.end24
  %27 = load i32* %pcount, align 4
  %inc30 = add i32 %27, 1
  store i32 %inc30, i32* %pcount, align 4
  br label %if.end31

if.end31:                                         ; preds = %if.then29, %if.end24
  br label %for.inc

for.inc:                                          ; preds = %if.end31
  %28 = load i32* %i, align 4
  %inc32 = add i32 %28, 1
  store i32 %inc32, i32* %i, align 4
  %call33 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %29 = load i32* %idx, align 4
  %conv34 = zext i32 %29 to i64
  %add = add i64 %conv34, %call33
  %conv35 = trunc i64 %add to i32
  store i32 %conv35, i32* %idx, align 4
  br label %for.cond3

for.end:                                          ; preds = %for.cond3
  br label %for.inc36

for.inc36:                                        ; preds = %for.end
  %30 = load i32* %n, align 4
  %inc37 = add nsw i32 %30, 1
  store i32 %inc37, i32* %n, align 4
  br label %for.cond

for.end38:                                        ; preds = %for.cond
  %31 = load i32* %pcount, align 4
  %call39 = call cc75 i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @readKernel.lcount, i32 %31)
  call cc75 void @_Z7barrierj(i32 1)
  %call40 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp41 = icmp eq i64 %call40, 0
  br i1 %cmp41, label %if.then43, label %if.end46

if.then43:                                        ; preds = %for.end38
  %32 = load i32 addrspace(3)* @readKernel.lcount, align 4
  %33 = load i32* %nk.addr, align 4
  %div = udiv i32 %32, %33
  %call44 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %34 = load i32 addrspace(1)** %out.addr, align 8
  %arrayidx45 = getelementptr inbounds i32 addrspace(1)* %34, i64 %call44
  store volatile i32 %div, i32 addrspace(1)* %arrayidx45, align 4
  br label %if.end46

if.end46:                                         ; preds = %if.then43, %for.end38
  %call47 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %cmp48 = icmp eq i64 %call47, 0
  br i1 %cmp48, label %if.then50, label %if.end54

if.then50:                                        ; preds = %if.end46
  %35 = load i32* %val.addr, align 4
  %call51 = call cc75 i64 @_Z14get_num_groupsj(i32 0) #1
  %add52 = add i64 %call51, 1
  %36 = load i32 addrspace(1)** %out.addr, align 8
  %arrayidx53 = getelementptr inbounds i32 addrspace(1)* %36, i64 %add52
  store volatile i32 %35, i32 addrspace(1)* %arrayidx53, align 4
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
  %in.addr = alloca i32 addrspace(1)*, align 8
  %out.addr = alloca <4 x i32> addrspace(1)*, align 8
  %ni.addr = alloca i32, align 4
  %val.addr = alloca i32, align 4
  %nk.addr = alloca i32, align 4
  %pval = alloca <4 x i32>, align 16
  %i = alloca i32, align 4
  %idx = alloca i32, align 4
  %.compoundliteral = alloca <4 x i32>, align 16
  %n = alloca i32, align 4
  store i32 addrspace(1)* %in, i32 addrspace(1)** %in.addr, align 8
  store <4 x i32> addrspace(1)* %out, <4 x i32> addrspace(1)** %out.addr, align 8
  store i32 %ni, i32* %ni.addr, align 4
  store i32 %val, i32* %val.addr, align 4
  store i32 %nk, i32* %nk.addr, align 4
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp = icmp eq i64 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call1 = call cc75 i64 @_Z14get_num_groupsj(i32 0) #1
  %add = add i64 %call1, 1
  %0 = load i32 addrspace(1)** %in.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %0, i64 %add
  %1 = load volatile i32 addrspace(1)* %arrayidx, align 4
  store i32 %1, i32 addrspace(3)* @writeKernel.lval, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  call cc75 void @_Z7barrierj(i32 1)
  %2 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %vecinit = insertelement <4 x i32> undef, i32 %2, i32 0
  %3 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %vecinit2 = insertelement <4 x i32> %vecinit, i32 %3, i32 1
  %4 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %vecinit3 = insertelement <4 x i32> %vecinit2, i32 %4, i32 2
  %5 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %vecinit4 = insertelement <4 x i32> %vecinit3, i32 %5, i32 3
  store <4 x i32> %vecinit4, <4 x i32>* %.compoundliteral
  %6 = load <4 x i32>* %.compoundliteral
  store <4 x i32> %6, <4 x i32>* %pval, align 16
  store i32 0, i32* %n, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc16, %if.end
  %7 = load i32* %n, align 4
  %8 = load i32* %nk.addr, align 4
  %cmp5 = icmp ult i32 %7, %8
  br i1 %cmp5, label %for.body, label %for.end18

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  %call6 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call6 to i32
  store i32 %conv, i32* %idx, align 4
  br label %for.cond7

for.cond7:                                        ; preds = %for.inc, %for.body
  %9 = load i32* %i, align 4
  %10 = load i32* %ni.addr, align 4
  %cmp8 = icmp ult i32 %9, %10
  br i1 %cmp8, label %for.body10, label %for.end

for.body10:                                       ; preds = %for.cond7
  %11 = load <4 x i32>* %pval, align 16
  %12 = load i32* %idx, align 4
  %idxprom = zext i32 %12 to i64
  %13 = load <4 x i32> addrspace(1)** %out.addr, align 8
  %arrayidx11 = getelementptr inbounds <4 x i32> addrspace(1)* %13, i64 %idxprom
  store volatile <4 x i32> %11, <4 x i32> addrspace(1)* %arrayidx11, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body10
  %14 = load i32* %i, align 4
  %inc = add i32 %14, 1
  store i32 %inc, i32* %i, align 4
  %call12 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %15 = load i32* %idx, align 4
  %conv13 = zext i32 %15 to i64
  %add14 = add i64 %conv13, %call12
  %conv15 = trunc i64 %add14 to i32
  store i32 %conv15, i32* %idx, align 4
  br label %for.cond7

for.end:                                          ; preds = %for.cond7
  br label %for.inc16

for.inc16:                                        ; preds = %for.end
  %16 = load i32* %n, align 4
  %inc17 = add nsw i32 %16, 1
  store i32 %inc17, i32* %n, align 4
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

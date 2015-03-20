; ModuleID = 'KernelLaunch_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@read_kernel.lcount = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_read_kernel_kernel(<4 x i32> addrspace(1)* %in, i32 addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
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
  %0 = load i32* %nk.addr, align 4
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %if.end49

if.end:                                           ; preds = %entry
  store i32 0, i32* %pcount, align 4
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp1 = icmp eq i64 %call, 0
  br i1 %cmp1, label %if.then2, label %if.end3

if.then2:                                         ; preds = %if.end
  store i32 0, i32 addrspace(3)* @read_kernel.lcount, align 4
  br label %if.end3

if.end3:                                          ; preds = %if.then2, %if.end
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %n, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc39, %if.end3
  %1 = load i32* %n, align 4
  %2 = load i32* %nk.addr, align 4
  %cmp4 = icmp ult i32 %1, %2
  br i1 %cmp4, label %for.body, label %for.end41

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  %call5 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call5 to i32
  store i32 %conv, i32* %idx, align 4
  br label %for.cond6

for.cond6:                                        ; preds = %for.inc, %for.body
  %3 = load i32* %i, align 4
  %4 = load i32* %ni.addr, align 4
  %cmp7 = icmp ult i32 %3, %4
  br i1 %cmp7, label %for.body9, label %for.end

for.body9:                                        ; preds = %for.cond6
  %5 = load i32* %idx, align 4
  %idxprom = zext i32 %5 to i64
  %6 = load <4 x i32> addrspace(1)** %in.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %6, i64 %idxprom
  %7 = load volatile <4 x i32> addrspace(1)* %arrayidx, align 16
  %8 = extractelement <4 x i32> %7, i32 0
  %9 = load i32* %val.addr, align 4
  %cmp10 = icmp eq i32 %8, %9
  br i1 %cmp10, label %if.then12, label %if.end13

if.then12:                                        ; preds = %for.body9
  %10 = load i32* %pcount, align 4
  %inc = add i32 %10, 1
  store i32 %inc, i32* %pcount, align 4
  br label %if.end13

if.end13:                                         ; preds = %if.then12, %for.body9
  %11 = load i32* %idx, align 4
  %idxprom14 = zext i32 %11 to i64
  %12 = load <4 x i32> addrspace(1)** %in.addr, align 8
  %arrayidx15 = getelementptr inbounds <4 x i32> addrspace(1)* %12, i64 %idxprom14
  %13 = load volatile <4 x i32> addrspace(1)* %arrayidx15, align 16
  %14 = extractelement <4 x i32> %13, i32 1
  %15 = load i32* %val.addr, align 4
  %cmp16 = icmp eq i32 %14, %15
  br i1 %cmp16, label %if.then18, label %if.end20

if.then18:                                        ; preds = %if.end13
  %16 = load i32* %pcount, align 4
  %inc19 = add i32 %16, 1
  store i32 %inc19, i32* %pcount, align 4
  br label %if.end20

if.end20:                                         ; preds = %if.then18, %if.end13
  %17 = load i32* %idx, align 4
  %idxprom21 = zext i32 %17 to i64
  %18 = load <4 x i32> addrspace(1)** %in.addr, align 8
  %arrayidx22 = getelementptr inbounds <4 x i32> addrspace(1)* %18, i64 %idxprom21
  %19 = load volatile <4 x i32> addrspace(1)* %arrayidx22, align 16
  %20 = extractelement <4 x i32> %19, i32 2
  %21 = load i32* %val.addr, align 4
  %cmp23 = icmp eq i32 %20, %21
  br i1 %cmp23, label %if.then25, label %if.end27

if.then25:                                        ; preds = %if.end20
  %22 = load i32* %pcount, align 4
  %inc26 = add i32 %22, 1
  store i32 %inc26, i32* %pcount, align 4
  br label %if.end27

if.end27:                                         ; preds = %if.then25, %if.end20
  %23 = load i32* %idx, align 4
  %idxprom28 = zext i32 %23 to i64
  %24 = load <4 x i32> addrspace(1)** %in.addr, align 8
  %arrayidx29 = getelementptr inbounds <4 x i32> addrspace(1)* %24, i64 %idxprom28
  %25 = load volatile <4 x i32> addrspace(1)* %arrayidx29, align 16
  %26 = extractelement <4 x i32> %25, i32 3
  %27 = load i32* %val.addr, align 4
  %cmp30 = icmp eq i32 %26, %27
  br i1 %cmp30, label %if.then32, label %if.end34

if.then32:                                        ; preds = %if.end27
  %28 = load i32* %pcount, align 4
  %inc33 = add i32 %28, 1
  store i32 %inc33, i32* %pcount, align 4
  br label %if.end34

if.end34:                                         ; preds = %if.then32, %if.end27
  br label %for.inc

for.inc:                                          ; preds = %if.end34
  %29 = load i32* %i, align 4
  %inc35 = add i32 %29, 1
  store i32 %inc35, i32* %i, align 4
  %call36 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %30 = load i32* %idx, align 4
  %conv37 = zext i32 %30 to i64
  %add = add i64 %conv37, %call36
  %conv38 = trunc i64 %add to i32
  store i32 %conv38, i32* %idx, align 4
  br label %for.cond6

for.end:                                          ; preds = %for.cond6
  br label %for.inc39

for.inc39:                                        ; preds = %for.end
  %31 = load i32* %n, align 4
  %inc40 = add nsw i32 %31, 1
  store i32 %inc40, i32* %n, align 4
  br label %for.cond

for.end41:                                        ; preds = %for.cond
  %32 = load i32* %pcount, align 4
  %call42 = call cc75 i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @read_kernel.lcount, i32 %32)
  call cc75 void @_Z7barrierj(i32 1)
  %call43 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp44 = icmp eq i64 %call43, 0
  br i1 %cmp44, label %if.then46, label %if.end49

if.then46:                                        ; preds = %for.end41
  %33 = load i32 addrspace(3)* @read_kernel.lcount, align 4
  %34 = load i32* %nk.addr, align 4
  %div = udiv i32 %33, %34
  %call47 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %35 = load i32 addrspace(1)** %out.addr, align 8
  %arrayidx48 = getelementptr inbounds i32 addrspace(1)* %35, i64 %call47
  store volatile i32 %div, i32 addrspace(1)* %arrayidx48, align 4
  br label %if.end49

if.end49:                                         ; preds = %if.then46, %for.end41, %if.then
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

; Function Attrs: nounwind
define cc76 void @__OpenCL_write_kernel_kernel(i32 addrspace(1)* %in, <4 x i32> addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
entry:
  %in.addr = alloca i32 addrspace(1)*, align 8
  %out.addr = alloca <4 x i32> addrspace(1)*, align 8
  %ni.addr = alloca i32, align 4
  %val.addr = alloca i32, align 4
  %nk.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %idx = alloca i32, align 4
  %pval = alloca <4 x i32>, align 16
  %.compoundliteral = alloca <4 x i32>, align 16
  %n = alloca i32, align 4
  store i32 addrspace(1)* %in, i32 addrspace(1)** %in.addr, align 8
  store <4 x i32> addrspace(1)* %out, <4 x i32> addrspace(1)** %out.addr, align 8
  store i32 %ni, i32* %ni.addr, align 4
  store i32 %val, i32* %val.addr, align 4
  store i32 %nk, i32* %nk.addr, align 4
  %0 = load i32* %nk.addr, align 4
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %for.end14

if.end:                                           ; preds = %entry
  %1 = load i32* %val.addr, align 4
  %vecinit = insertelement <4 x i32> undef, i32 %1, i32 0
  %2 = load i32* %val.addr, align 4
  %vecinit1 = insertelement <4 x i32> %vecinit, i32 %2, i32 1
  %3 = load i32* %val.addr, align 4
  %vecinit2 = insertelement <4 x i32> %vecinit1, i32 %3, i32 2
  %4 = load i32* %val.addr, align 4
  %vecinit3 = insertelement <4 x i32> %vecinit2, i32 %4, i32 3
  store <4 x i32> %vecinit3, <4 x i32>* %.compoundliteral
  %5 = load <4 x i32>* %.compoundliteral
  store <4 x i32> %5, <4 x i32>* %pval, align 16
  store i32 0, i32* %n, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc12, %if.end
  %6 = load i32* %n, align 4
  %7 = load i32* %nk.addr, align 4
  %cmp4 = icmp ult i32 %6, %7
  br i1 %cmp4, label %for.body, label %for.end14

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %idx, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body
  %8 = load i32* %i, align 4
  %9 = load i32* %ni.addr, align 4
  %cmp6 = icmp ult i32 %8, %9
  br i1 %cmp6, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond5
  %10 = load <4 x i32>* %pval, align 16
  %11 = load i32* %idx, align 4
  %idxprom = zext i32 %11 to i64
  %12 = load <4 x i32> addrspace(1)** %out.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %12, i64 %idxprom
  store volatile <4 x i32> %10, <4 x i32> addrspace(1)* %arrayidx, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body8
  %13 = load i32* %i, align 4
  %inc = add i32 %13, 1
  store i32 %inc, i32* %i, align 4
  %call9 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %14 = load i32* %idx, align 4
  %conv10 = zext i32 %14 to i64
  %add = add i64 %conv10, %call9
  %conv11 = trunc i64 %add to i32
  store i32 %conv11, i32* %idx, align 4
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc12

for.inc12:                                        ; preds = %for.end
  %15 = load i32* %n, align 4
  %inc13 = add nsw i32 %15, 1
  store i32 %inc13, i32* %n, align 4
  br label %for.cond

for.end14:                                        ; preds = %for.cond, %if.then
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!9}
!opencl.spir.version = !{!9}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @__OpenCL_read_kernel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint4*", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"volatile", metadata !"volatile", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint4*", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @__OpenCL_write_kernel_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint4*", metadata !"uint", metadata !"uint", metadata !"uint"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint4*", metadata !"uint", metadata !"uint", metadata !"uint"}
!9 = metadata !{i32 1, i32 2}

; ModuleID = 'ImageBandwidth_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

@read_kernel.lcount = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_read_kernel_kernel(%opencl.image2d_t addrspace(1)* %in, i32 addrspace(1)* %out, i32 %np, i32 %val, i32 %nk) #0 {
entry:
  %in.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %out.addr = alloca i32 addrspace(1)*, align 8
  %np.addr = alloca i32, align 4
  %val.addr = alloca i32, align 4
  %nk.addr = alloca i32, align 4
  %sampler = alloca i32, align 4
  %pcount = alloca i32, align 4
  %i = alloca i32, align 4
  %idx = alloca i32, align 4
  %pix = alloca <4 x i32>, align 16
  %coord = alloca <2 x i32>, align 8
  %.compoundliteral = alloca <2 x i32>, align 8
  %n = alloca i32, align 4
  %gid1D = alloca i32, align 4
  store %opencl.image2d_t addrspace(1)* %in, %opencl.image2d_t addrspace(1)** %in.addr, align 8
  store i32 addrspace(1)* %out, i32 addrspace(1)** %out.addr, align 8
  store i32 %np, i32* %np.addr, align 4
  store i32 %val, i32* %val.addr, align 4
  store i32 %nk, i32* %nk.addr, align 4
  %0 = load i32* %nk.addr, align 4
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %if.end59

if.end:                                           ; preds = %entry
  store i32 18, i32* %sampler, align 4
  store i32 0, i32* %pcount, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %vecinit = insertelement <2 x i32> undef, i32 %conv, i32 0
  %vecinit1 = insertelement <2 x i32> %vecinit, i32 0, i32 1
  store <2 x i32> %vecinit1, <2 x i32>* %.compoundliteral
  %1 = load <2 x i32>* %.compoundliteral
  store <2 x i32> %1, <2 x i32>* %coord, align 8
  %call2 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp3 = icmp eq i64 %call2, 0
  br i1 %cmp3, label %land.lhs.true, label %if.end9

land.lhs.true:                                    ; preds = %if.end
  %call5 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %cmp6 = icmp eq i64 %call5, 0
  br i1 %cmp6, label %if.then8, label %if.end9

if.then8:                                         ; preds = %land.lhs.true
  store i32 0, i32 addrspace(3)* @read_kernel.lcount, align 4
  br label %if.end9

if.end9:                                          ; preds = %if.then8, %land.lhs.true, %if.end
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %n, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc42, %if.end9
  %2 = load i32* %n, align 4
  %3 = load i32* %nk.addr, align 4
  %cmp10 = icmp ult i32 %2, %3
  br i1 %cmp10, label %for.body, label %for.end44

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  %call12 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv13 = trunc i64 %call12 to i32
  store i32 %conv13, i32* %idx, align 4
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc, %for.body
  %4 = load i32* %i, align 4
  %5 = load i32* %np.addr, align 4
  %cmp15 = icmp ult i32 %4, %5
  br i1 %cmp15, label %for.body17, label %for.end

for.body17:                                       ; preds = %for.cond14
  %6 = load i32* %idx, align 4
  %7 = load <2 x i32>* %coord, align 8
  %8 = insertelement <2 x i32> %7, i32 %6, i32 1
  store <2 x i32> %8, <2 x i32>* %coord, align 8
  %9 = load %opencl.image2d_t addrspace(1)** %in.addr, align 8
  %10 = load i32* %sampler, align 4
  %11 = load <2 x i32>* %coord, align 8
  %call18 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %9, i32 %10, <2 x i32> %11) #1
  store <4 x i32> %call18, <4 x i32>* %pix, align 16
  %12 = load <4 x i32>* %pix, align 16
  %13 = extractelement <4 x i32> %12, i32 0
  %14 = load i32* %val.addr, align 4
  %cmp19 = icmp eq i32 %13, %14
  br i1 %cmp19, label %if.then21, label %if.end22

if.then21:                                        ; preds = %for.body17
  %15 = load i32* %pcount, align 4
  %inc = add i32 %15, 1
  store i32 %inc, i32* %pcount, align 4
  br label %if.end22

if.end22:                                         ; preds = %if.then21, %for.body17
  %16 = load <4 x i32>* %pix, align 16
  %17 = extractelement <4 x i32> %16, i32 1
  %18 = load i32* %val.addr, align 4
  %cmp23 = icmp eq i32 %17, %18
  br i1 %cmp23, label %if.then25, label %if.end27

if.then25:                                        ; preds = %if.end22
  %19 = load i32* %pcount, align 4
  %inc26 = add i32 %19, 1
  store i32 %inc26, i32* %pcount, align 4
  br label %if.end27

if.end27:                                         ; preds = %if.then25, %if.end22
  %20 = load <4 x i32>* %pix, align 16
  %21 = extractelement <4 x i32> %20, i32 2
  %22 = load i32* %val.addr, align 4
  %cmp28 = icmp eq i32 %21, %22
  br i1 %cmp28, label %if.then30, label %if.end32

if.then30:                                        ; preds = %if.end27
  %23 = load i32* %pcount, align 4
  %inc31 = add i32 %23, 1
  store i32 %inc31, i32* %pcount, align 4
  br label %if.end32

if.end32:                                         ; preds = %if.then30, %if.end27
  %24 = load <4 x i32>* %pix, align 16
  %25 = extractelement <4 x i32> %24, i32 3
  %26 = load i32* %val.addr, align 4
  %cmp33 = icmp eq i32 %25, %26
  br i1 %cmp33, label %if.then35, label %if.end37

if.then35:                                        ; preds = %if.end32
  %27 = load i32* %pcount, align 4
  %inc36 = add i32 %27, 1
  store i32 %inc36, i32* %pcount, align 4
  br label %if.end37

if.end37:                                         ; preds = %if.then35, %if.end32
  br label %for.inc

for.inc:                                          ; preds = %if.end37
  %28 = load i32* %i, align 4
  %inc38 = add i32 %28, 1
  store i32 %inc38, i32* %i, align 4
  %call39 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %29 = load i32* %idx, align 4
  %conv40 = zext i32 %29 to i64
  %add = add i64 %conv40, %call39
  %conv41 = trunc i64 %add to i32
  store i32 %conv41, i32* %idx, align 4
  br label %for.cond14

for.end:                                          ; preds = %for.cond14
  br label %for.inc42

for.inc42:                                        ; preds = %for.end
  %30 = load i32* %n, align 4
  %inc43 = add nsw i32 %30, 1
  store i32 %inc43, i32* %n, align 4
  br label %for.cond

for.end44:                                        ; preds = %for.cond
  %31 = load i32* %pcount, align 4
  %call45 = call cc75 i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @read_kernel.lcount, i32 %31)
  call cc75 void @_Z7barrierj(i32 1)
  %call46 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %call47 = call cc75 i64 @_Z14get_num_groupsj(i32 0) #1
  %mul = mul i64 %call46, %call47
  %call48 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %add49 = add i64 %mul, %call48
  %conv50 = trunc i64 %add49 to i32
  store i32 %conv50, i32* %gid1D, align 4
  %call51 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp52 = icmp eq i64 %call51, 0
  br i1 %cmp52, label %land.lhs.true54, label %if.end59

land.lhs.true54:                                  ; preds = %for.end44
  %call55 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %cmp56 = icmp eq i64 %call55, 0
  br i1 %cmp56, label %if.then58, label %if.end59

if.then58:                                        ; preds = %land.lhs.true54
  %32 = load i32 addrspace(3)* @read_kernel.lcount, align 4
  %33 = load i32* %nk.addr, align 4
  %div = udiv i32 %32, %33
  %34 = load i32* %gid1D, align 4
  %idxprom = zext i32 %34 to i64
  %35 = load i32 addrspace(1)** %out.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %35, i64 %idxprom
  store i32 %div, i32 addrspace(1)* %arrayidx, align 4
  br label %if.end59

if.end59:                                         ; preds = %if.then58, %land.lhs.true54, %for.end44, %if.then
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)*, i32, <2 x i32>) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

declare cc75 i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32)

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_num_groupsj(i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_write_kernel_kernel(i32 addrspace(1)* %in, %opencl.image2d_t addrspace(1)* %out, i32 %np, i32 %val, i32 %nk) #0 {
entry:
  %in.addr = alloca i32 addrspace(1)*, align 8
  %out.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %np.addr = alloca i32, align 4
  %val.addr = alloca i32, align 4
  %nk.addr = alloca i32, align 4
  %pval = alloca <4 x i32>, align 16
  %i = alloca i32, align 4
  %idx = alloca i32, align 4
  %coord = alloca <2 x i32>, align 8
  %.compoundliteral = alloca <2 x i32>, align 8
  %.compoundliteral2 = alloca <4 x i32>, align 16
  %n = alloca i32, align 4
  store i32 addrspace(1)* %in, i32 addrspace(1)** %in.addr, align 8
  store %opencl.image2d_t addrspace(1)* %out, %opencl.image2d_t addrspace(1)** %out.addr, align 8
  store i32 %np, i32* %np.addr, align 4
  store i32 %val, i32* %val.addr, align 4
  store i32 %nk, i32* %nk.addr, align 4
  %0 = load i32* %nk.addr, align 4
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %for.end20

if.end:                                           ; preds = %entry
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %vecinit = insertelement <2 x i32> undef, i32 %conv, i32 0
  %vecinit1 = insertelement <2 x i32> %vecinit, i32 0, i32 1
  store <2 x i32> %vecinit1, <2 x i32>* %.compoundliteral
  %1 = load <2 x i32>* %.compoundliteral
  store <2 x i32> %1, <2 x i32>* %coord, align 8
  %2 = load i32* %val.addr, align 4
  %vecinit3 = insertelement <4 x i32> undef, i32 %2, i32 0
  %3 = load i32* %val.addr, align 4
  %vecinit4 = insertelement <4 x i32> %vecinit3, i32 %3, i32 1
  %4 = load i32* %val.addr, align 4
  %vecinit5 = insertelement <4 x i32> %vecinit4, i32 %4, i32 2
  %5 = load i32* %val.addr, align 4
  %vecinit6 = insertelement <4 x i32> %vecinit5, i32 %5, i32 3
  store <4 x i32> %vecinit6, <4 x i32>* %.compoundliteral2
  %6 = load <4 x i32>* %.compoundliteral2
  store <4 x i32> %6, <4 x i32>* %pval, align 16
  store i32 0, i32* %n, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc18, %if.end
  %7 = load i32* %n, align 4
  %8 = load i32* %nk.addr, align 4
  %cmp7 = icmp ult i32 %7, %8
  br i1 %cmp7, label %for.body, label %for.end20

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  %call9 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv10 = trunc i64 %call9 to i32
  store i32 %conv10, i32* %idx, align 4
  br label %for.cond11

for.cond11:                                       ; preds = %for.inc, %for.body
  %9 = load i32* %i, align 4
  %10 = load i32* %np.addr, align 4
  %cmp12 = icmp ult i32 %9, %10
  br i1 %cmp12, label %for.body14, label %for.end

for.body14:                                       ; preds = %for.cond11
  %11 = load i32* %idx, align 4
  %12 = load <2 x i32>* %coord, align 8
  %13 = insertelement <2 x i32> %12, i32 %11, i32 1
  store <2 x i32> %13, <2 x i32>* %coord, align 8
  %14 = load %opencl.image2d_t addrspace(1)** %out.addr, align 8
  %15 = load <2 x i32>* %coord, align 8
  %16 = load <4 x i32>* %pval, align 16
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %14, <2 x i32> %15, <4 x i32> %16)
  br label %for.inc

for.inc:                                          ; preds = %for.body14
  %17 = load i32* %i, align 4
  %inc = add i32 %17, 1
  store i32 %inc, i32* %i, align 4
  %call15 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %18 = load i32* %idx, align 4
  %conv16 = zext i32 %18 to i64
  %add = add i64 %conv16, %call15
  %conv17 = trunc i64 %add to i32
  store i32 %conv17, i32* %idx, align 4
  br label %for.cond11

for.end:                                          ; preds = %for.cond11
  br label %for.inc18

for.inc18:                                        ; preds = %for.end
  %19 = load i32* %n, align 4
  %inc19 = add nsw i32 %19, 1
  store i32 %inc19, i32* %n, align 4
  br label %for.cond

for.end20:                                        ; preds = %for.cond, %if.then
  ret void
}

declare cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x i32>)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!10}
!opencl.spir.version = !{!10}

!0 = metadata !{void (%opencl.image2d_t addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @__OpenCL_read_kernel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"read_only", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"image2d_t", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"image2d_t", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (i32 addrspace(1)*, %opencl.image2d_t addrspace(1)*, i32, i32, i32)* @__OpenCL_write_kernel_kernel, metadata !1, metadata !7, metadata !8, metadata !4, metadata !9}
!7 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"write_only", metadata !"none", metadata !"none", metadata !"none"}
!8 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"image2d_t", metadata !"uint", metadata !"uint", metadata !"uint"}
!9 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"image2d_t", metadata !"uint", metadata !"uint", metadata !"uint"}
!10 = metadata !{i32 1, i32 2}

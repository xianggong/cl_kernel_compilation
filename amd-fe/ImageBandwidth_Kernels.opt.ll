; ModuleID = 'ImageBandwidth_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

@read_kernel.lcount = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_read_kernel_kernel(%opencl.image2d_t addrspace(1)* %in, i32 addrspace(1)* %out, i32 %np, i32 %val, i32 %nk) #0 {
entry:
  %cmp = icmp eq i32 %nk, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %if.end59

if.end:                                           ; preds = %entry
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %vecinit = insertelement <2 x i32> undef, i32 %conv, i32 0
  %vecinit1 = insertelement <2 x i32> %vecinit, i32 0, i32 1
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
  br label %for.cond

for.cond:                                         ; preds = %for.inc42, %if.end9
  %pcount.0 = phi i32 [ 0, %if.end9 ], [ %pcount.1, %for.inc42 ]
  %coord.0 = phi <2 x i32> [ %vecinit1, %if.end9 ], [ %coord.1, %for.inc42 ]
  %n.0 = phi i32 [ 0, %if.end9 ], [ %inc43, %for.inc42 ]
  %cmp10 = icmp ult i32 %n.0, %nk
  br i1 %cmp10, label %for.body, label %for.end44

for.body:                                         ; preds = %for.cond
  %call12 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv13 = trunc i64 %call12 to i32
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc, %for.body
  %pcount.1 = phi i32 [ %pcount.0, %for.body ], [ %pcount.5, %for.inc ]
  %i.0 = phi i32 [ 0, %for.body ], [ %inc38, %for.inc ]
  %idx.0 = phi i32 [ %conv13, %for.body ], [ %conv41, %for.inc ]
  %coord.1 = phi <2 x i32> [ %coord.0, %for.body ], [ %0, %for.inc ]
  %cmp15 = icmp ult i32 %i.0, %np
  br i1 %cmp15, label %for.body17, label %for.end

for.body17:                                       ; preds = %for.cond14
  %0 = insertelement <2 x i32> %coord.1, i32 %idx.0, i32 1
  %call18 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %in, i32 18, <2 x i32> %0) #1
  %1 = extractelement <4 x i32> %call18, i32 0
  %cmp19 = icmp eq i32 %1, %val
  br i1 %cmp19, label %if.then21, label %if.end22

if.then21:                                        ; preds = %for.body17
  %inc = add i32 %pcount.1, 1
  br label %if.end22

if.end22:                                         ; preds = %if.then21, %for.body17
  %pcount.2 = phi i32 [ %inc, %if.then21 ], [ %pcount.1, %for.body17 ]
  %2 = extractelement <4 x i32> %call18, i32 1
  %cmp23 = icmp eq i32 %2, %val
  br i1 %cmp23, label %if.then25, label %if.end27

if.then25:                                        ; preds = %if.end22
  %inc26 = add i32 %pcount.2, 1
  br label %if.end27

if.end27:                                         ; preds = %if.then25, %if.end22
  %pcount.3 = phi i32 [ %inc26, %if.then25 ], [ %pcount.2, %if.end22 ]
  %3 = extractelement <4 x i32> %call18, i32 2
  %cmp28 = icmp eq i32 %3, %val
  br i1 %cmp28, label %if.then30, label %if.end32

if.then30:                                        ; preds = %if.end27
  %inc31 = add i32 %pcount.3, 1
  br label %if.end32

if.end32:                                         ; preds = %if.then30, %if.end27
  %pcount.4 = phi i32 [ %inc31, %if.then30 ], [ %pcount.3, %if.end27 ]
  %4 = extractelement <4 x i32> %call18, i32 3
  %cmp33 = icmp eq i32 %4, %val
  br i1 %cmp33, label %if.then35, label %if.end37

if.then35:                                        ; preds = %if.end32
  %inc36 = add i32 %pcount.4, 1
  br label %if.end37

if.end37:                                         ; preds = %if.then35, %if.end32
  %pcount.5 = phi i32 [ %inc36, %if.then35 ], [ %pcount.4, %if.end32 ]
  br label %for.inc

for.inc:                                          ; preds = %if.end37
  %inc38 = add i32 %i.0, 1
  %call39 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv40 = zext i32 %idx.0 to i64
  %add = add i64 %conv40, %call39
  %conv41 = trunc i64 %add to i32
  br label %for.cond14

for.end:                                          ; preds = %for.cond14
  br label %for.inc42

for.inc42:                                        ; preds = %for.end
  %inc43 = add nsw i32 %n.0, 1
  br label %for.cond

for.end44:                                        ; preds = %for.cond
  %call45 = call cc75 i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @read_kernel.lcount, i32 %pcount.0)
  call cc75 void @_Z7barrierj(i32 1)
  %call46 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %call47 = call cc75 i64 @_Z14get_num_groupsj(i32 0) #1
  %mul = mul i64 %call46, %call47
  %call48 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %add49 = add i64 %mul, %call48
  %conv50 = trunc i64 %add49 to i32
  %call51 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp52 = icmp eq i64 %call51, 0
  br i1 %cmp52, label %land.lhs.true54, label %if.end59

land.lhs.true54:                                  ; preds = %for.end44
  %call55 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %cmp56 = icmp eq i64 %call55, 0
  br i1 %cmp56, label %if.then58, label %if.end59

if.then58:                                        ; preds = %land.lhs.true54
  %5 = load i32 addrspace(3)* @read_kernel.lcount, align 4
  %div = udiv i32 %5, %nk
  %idxprom = zext i32 %conv50 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %out, i64 %idxprom
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
  %cmp = icmp eq i32 %nk, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %for.end20

if.end:                                           ; preds = %entry
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %vecinit = insertelement <2 x i32> undef, i32 %conv, i32 0
  %vecinit1 = insertelement <2 x i32> %vecinit, i32 0, i32 1
  %vecinit3 = insertelement <4 x i32> undef, i32 %val, i32 0
  %vecinit4 = insertelement <4 x i32> %vecinit3, i32 %val, i32 1
  %vecinit5 = insertelement <4 x i32> %vecinit4, i32 %val, i32 2
  %vecinit6 = insertelement <4 x i32> %vecinit5, i32 %val, i32 3
  br label %for.cond

for.cond:                                         ; preds = %for.inc18, %if.end
  %coord.0 = phi <2 x i32> [ %vecinit1, %if.end ], [ %coord.1, %for.inc18 ]
  %n.0 = phi i32 [ 0, %if.end ], [ %inc19, %for.inc18 ]
  %cmp7 = icmp ult i32 %n.0, %nk
  br i1 %cmp7, label %for.body, label %for.end20

for.body:                                         ; preds = %for.cond
  %call9 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv10 = trunc i64 %call9 to i32
  br label %for.cond11

for.cond11:                                       ; preds = %for.inc, %for.body
  %i.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %idx.0 = phi i32 [ %conv10, %for.body ], [ %conv17, %for.inc ]
  %coord.1 = phi <2 x i32> [ %coord.0, %for.body ], [ %0, %for.inc ]
  %cmp12 = icmp ult i32 %i.0, %np
  br i1 %cmp12, label %for.body14, label %for.end

for.body14:                                       ; preds = %for.cond11
  %0 = insertelement <2 x i32> %coord.1, i32 %idx.0, i32 1
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %out, <2 x i32> %0, <4 x i32> %vecinit6)
  br label %for.inc

for.inc:                                          ; preds = %for.body14
  %inc = add i32 %i.0, 1
  %call15 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv16 = zext i32 %idx.0 to i64
  %add = add i64 %conv16, %call15
  %conv17 = trunc i64 %add to i32
  br label %for.cond11

for.end:                                          ; preds = %for.cond11
  br label %for.inc18

for.inc18:                                        ; preds = %for.end
  %inc19 = add nsw i32 %n.0, 1
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

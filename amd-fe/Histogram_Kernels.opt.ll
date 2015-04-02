; ModuleID = 'Histogram_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_histogram256_vector_kernel(<4 x i32> addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call2 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %call3 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %and = and i64 %call, 31
  %conv = trunc i64 %and to i32
  %mul = mul nsw i32 4, %conv
  %shr = lshr i64 %call, 5
  %conv4 = trunc i64 %shr to i32
  %0 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 64
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %conv6 = sext i32 %i.0 to i64
  %mul7 = mul i64 %call3, %conv6
  %add = add i64 %mul7, %call
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(3)* %0, i64 %add
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc43, %for.end
  %i8.0 = phi i32 [ 0, %for.end ], [ %inc44, %for.inc43 ]
  %cmp10 = icmp slt i32 %i8.0, 32
  br i1 %cmp10, label %for.body12, label %for.end45

for.body12:                                       ; preds = %for.cond9
  %mul13 = mul i64 %call3, 256
  %div = udiv i64 %mul13, 8
  %mul14 = mul i64 %call2, %div
  %conv15 = sext i32 %i8.0 to i64
  %mul16 = mul i64 %conv15, %call3
  %add17 = add i64 %mul14, %mul16
  %add18 = add i64 %add17, %call
  %arrayidx19 = getelementptr inbounds <4 x i32> addrspace(1)* %data, i64 %add18
  %1 = load <4 x i32> addrspace(1)* %arrayidx19, align 16
  %2 = extractelement <4 x i32> %1, i32 0
  %mul20 = mul i32 %2, 128
  %add21 = add i32 %mul20, %mul
  %add22 = add i32 %add21, %conv4
  %idxprom = zext i32 %add22 to i64
  %arrayidx23 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i64 %idxprom
  %3 = load i8 addrspace(3)* %arrayidx23, align 1
  %inc24 = add i8 %3, 1
  store i8 %inc24, i8 addrspace(3)* %arrayidx23, align 1
  %4 = extractelement <4 x i32> %1, i32 1
  %mul25 = mul i32 %4, 128
  %add26 = add i32 %mul25, %mul
  %add27 = add i32 %add26, %conv4
  %idxprom28 = zext i32 %add27 to i64
  %arrayidx29 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i64 %idxprom28
  %5 = load i8 addrspace(3)* %arrayidx29, align 1
  %inc30 = add i8 %5, 1
  store i8 %inc30, i8 addrspace(3)* %arrayidx29, align 1
  %6 = extractelement <4 x i32> %1, i32 2
  %mul31 = mul i32 %6, 128
  %add32 = add i32 %mul31, %mul
  %add33 = add i32 %add32, %conv4
  %idxprom34 = zext i32 %add33 to i64
  %arrayidx35 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i64 %idxprom34
  %7 = load i8 addrspace(3)* %arrayidx35, align 1
  %inc36 = add i8 %7, 1
  store i8 %inc36, i8 addrspace(3)* %arrayidx35, align 1
  %8 = extractelement <4 x i32> %1, i32 3
  %mul37 = mul i32 %8, 128
  %add38 = add i32 %mul37, %mul
  %add39 = add i32 %add38, %conv4
  %idxprom40 = zext i32 %add39 to i64
  %arrayidx41 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i64 %idxprom40
  %9 = load i8 addrspace(3)* %arrayidx41, align 1
  %inc42 = add i8 %9, 1
  store i8 %inc42, i8 addrspace(3)* %arrayidx41, align 1
  br label %for.inc43

for.inc43:                                        ; preds = %for.body12
  %inc44 = add nsw i32 %i8.0, 1
  br label %for.cond9

for.end45:                                        ; preds = %for.cond9
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond47

for.cond47:                                       ; preds = %for.inc81, %for.end45
  %i46.0 = phi i32 [ 0, %for.end45 ], [ %inc82, %for.inc81 ]
  %conv48 = sext i32 %i46.0 to i64
  %div49 = udiv i64 256, %call3
  %cmp50 = icmp ult i64 %conv48, %div49
  br i1 %cmp50, label %for.body52, label %for.end83

for.body52:                                       ; preds = %for.cond47
  %mul53 = mul nsw i32 4096, %i46.0
  %conv54 = sext i32 %mul53 to i64
  %mul55 = mul i64 %call, 32
  %add56 = add i64 %conv54, %mul55
  %conv57 = trunc i64 %add56 to i32
  br label %for.cond58

for.cond58:                                       ; preds = %for.inc69, %for.body52
  %binCount.0 = phi <4 x i32> [ zeroinitializer, %for.body52 ], [ %add68, %for.inc69 ]
  %j.0 = phi i32 [ 0, %for.body52 ], [ %inc70, %for.inc69 ]
  %cmp59 = icmp slt i32 %j.0, 32
  br i1 %cmp59, label %for.body61, label %for.end71

for.body61:                                       ; preds = %for.cond58
  %add62 = add nsw i32 %j.0, %conv
  %and63 = and i32 %add62, 31
  %add64 = add nsw i32 %conv57, %and63
  %idxprom65 = sext i32 %add64 to i64
  %arrayidx66 = getelementptr inbounds <4 x i8> addrspace(3)* %0, i64 %idxprom65
  %10 = load <4 x i8> addrspace(3)* %arrayidx66, align 4
  %call67 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %10) #1
  %add68 = add <4 x i32> %binCount.0, %call67
  br label %for.inc69

for.inc69:                                        ; preds = %for.body61
  %inc70 = add nsw i32 %j.0, 1
  br label %for.cond58

for.end71:                                        ; preds = %for.cond58
  %11 = extractelement <4 x i32> %binCount.0, i32 0
  %12 = extractelement <4 x i32> %binCount.0, i32 1
  %add72 = add i32 %11, %12
  %13 = extractelement <4 x i32> %binCount.0, i32 2
  %add73 = add i32 %add72, %13
  %14 = extractelement <4 x i32> %binCount.0, i32 3
  %add74 = add i32 %add73, %14
  %mul75 = mul i64 %call2, 256
  %conv76 = sext i32 %i46.0 to i64
  %mul77 = mul i64 %call3, %conv76
  %add78 = add i64 %mul75, %mul77
  %add79 = add i64 %add78, %call
  %arrayidx80 = getelementptr inbounds i32 addrspace(1)* %binResult, i64 %add79
  store i32 %add74, i32 addrspace(1)* %arrayidx80, align 4
  br label %for.inc81

for.inc81:                                        ; preds = %for.end71
  %inc82 = add nsw i32 %i46.0, 1
  br label %for.cond47

for.end83:                                        ; preds = %for.cond47
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

declare cc75 void @_Z7barrierj(i32)

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_histogram256_scalar_kernel(i32 addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call2 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %call3 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %and = and i64 %call, 31
  %conv = trunc i64 %and to i32
  %mul = mul nsw i32 4, %conv
  %shr = lshr i64 %call, 5
  %conv4 = trunc i64 %shr to i32
  %0 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 64
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %conv6 = sext i32 %i.0 to i64
  %mul7 = mul i64 %call3, %conv6
  %add = add i64 %mul7, %call
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(3)* %0, i64 %add
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc25, %for.end
  %i8.0 = phi i32 [ 0, %for.end ], [ %inc26, %for.inc25 ]
  %cmp10 = icmp slt i32 %i8.0, 128
  br i1 %cmp10, label %for.body12, label %for.end27

for.body12:                                       ; preds = %for.cond9
  %mul13 = mul i64 %call3, 128
  %mul14 = mul i64 %call2, %mul13
  %conv15 = sext i32 %i8.0 to i64
  %mul16 = mul i64 %conv15, %call3
  %add17 = add i64 %mul14, %mul16
  %add18 = add i64 %add17, %call
  %arrayidx19 = getelementptr inbounds i32 addrspace(1)* %data, i64 %add18
  %1 = load i32 addrspace(1)* %arrayidx19, align 4
  %mul20 = mul i32 %1, 128
  %add21 = add i32 %mul20, %mul
  %add22 = add i32 %add21, %conv4
  %idxprom = zext i32 %add22 to i64
  %arrayidx23 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i64 %idxprom
  %2 = load i8 addrspace(3)* %arrayidx23, align 1
  %inc24 = add i8 %2, 1
  store i8 %inc24, i8 addrspace(3)* %arrayidx23, align 1
  br label %for.inc25

for.inc25:                                        ; preds = %for.body12
  %inc26 = add nsw i32 %i8.0, 1
  br label %for.cond9

for.end27:                                        ; preds = %for.cond9
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond29

for.cond29:                                       ; preds = %for.inc62, %for.end27
  %i28.0 = phi i32 [ 0, %for.end27 ], [ %inc63, %for.inc62 ]
  %conv30 = sext i32 %i28.0 to i64
  %div = udiv i64 256, %call3
  %cmp31 = icmp ult i64 %conv30, %div
  br i1 %cmp31, label %for.body33, label %for.end64

for.body33:                                       ; preds = %for.cond29
  %mul34 = mul nsw i32 4096, %i28.0
  %conv35 = sext i32 %mul34 to i64
  %mul36 = mul i64 %call, 32
  %add37 = add i64 %conv35, %mul36
  %conv38 = trunc i64 %add37 to i32
  br label %for.cond39

for.cond39:                                       ; preds = %for.inc50, %for.body33
  %binCount.0 = phi <4 x i32> [ zeroinitializer, %for.body33 ], [ %add49, %for.inc50 ]
  %j.0 = phi i32 [ 0, %for.body33 ], [ %inc51, %for.inc50 ]
  %cmp40 = icmp slt i32 %j.0, 32
  br i1 %cmp40, label %for.body42, label %for.end52

for.body42:                                       ; preds = %for.cond39
  %add43 = add nsw i32 %j.0, %conv
  %and44 = and i32 %add43, 31
  %add45 = add nsw i32 %conv38, %and44
  %idxprom46 = sext i32 %add45 to i64
  %arrayidx47 = getelementptr inbounds <4 x i8> addrspace(3)* %0, i64 %idxprom46
  %3 = load <4 x i8> addrspace(3)* %arrayidx47, align 4
  %call48 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %3) #1
  %add49 = add <4 x i32> %binCount.0, %call48
  br label %for.inc50

for.inc50:                                        ; preds = %for.body42
  %inc51 = add nsw i32 %j.0, 1
  br label %for.cond39

for.end52:                                        ; preds = %for.cond39
  %4 = extractelement <4 x i32> %binCount.0, i32 0
  %5 = extractelement <4 x i32> %binCount.0, i32 1
  %add53 = add i32 %4, %5
  %6 = extractelement <4 x i32> %binCount.0, i32 2
  %add54 = add i32 %add53, %6
  %7 = extractelement <4 x i32> %binCount.0, i32 3
  %add55 = add i32 %add54, %7
  %mul56 = mul i64 %call2, 256
  %conv57 = sext i32 %i28.0 to i64
  %mul58 = mul i64 %call3, %conv57
  %add59 = add i64 %mul56, %mul58
  %add60 = add i64 %add59, %call
  %arrayidx61 = getelementptr inbounds i32 addrspace(1)* %binResult, i64 %add60
  store i32 %add55, i32 addrspace(1)* %arrayidx61, align 4
  br label %for.inc62

for.inc62:                                        ; preds = %for.end52
  %inc63 = add nsw i32 %i28.0, 1
  br label %for.cond29

for.end64:                                        ; preds = %for.cond29
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!9}
!opencl.spir.version = !{!9}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @__OpenCL_histogram256_vector_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 3, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint4*", metadata !"uchar*", metadata !"uint*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"const", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint4*", metadata !"uchar*", metadata !"uint*"}
!6 = metadata !{void (i32 addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @__OpenCL_histogram256_scalar_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uchar*", metadata !"uint*"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uchar*", metadata !"uint*"}
!9 = metadata !{i32 1, i32 2}

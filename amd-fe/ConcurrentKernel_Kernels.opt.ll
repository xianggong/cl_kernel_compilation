; ModuleID = 'ConcurrentKernel_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@K2.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K4.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K6.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K8.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K10.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1

; Function Attrs: nounwind
define cc75 void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  %zero = alloca i32, align 4
  %call = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store volatile i32 0, i32* %zero, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %tmp.0 = phi i32 [ 1, %entry ], [ %add32, %for.inc ]
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 5000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul nsw i32 %i.0, 1
  %rem = urem i32 %mul, %bufferSize
  %idxprom = zext i32 %rem to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom
  %0 = load i8 addrspace(1)* %arrayidx, align 1
  %conv8 = zext i8 %0 to i32
  %mul9 = mul nsw i32 %i.0, 2
  %rem10 = urem i32 %mul9, %bufferSize
  %idxprom11 = zext i32 %rem10 to i64
  %arrayidx12 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom11
  %1 = load i8 addrspace(1)* %arrayidx12, align 1
  %conv13 = zext i8 %1 to i32
  %add = add nsw i32 %conv8, %conv13
  %mul14 = mul nsw i32 %i.0, 3
  %rem15 = urem i32 %mul14, %bufferSize
  %idxprom16 = zext i32 %rem15 to i64
  %arrayidx17 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom16
  %2 = load i8 addrspace(1)* %arrayidx17, align 1
  %conv18 = zext i8 %2 to i32
  %add19 = add nsw i32 %add, %conv18
  %mul20 = mul nsw i32 %i.0, 4
  %rem21 = urem i32 %mul20, %bufferSize
  %idxprom22 = zext i32 %rem21 to i64
  %arrayidx23 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom22
  %3 = load i8 addrspace(1)* %arrayidx23, align 1
  %conv24 = zext i8 %3 to i32
  %add25 = add nsw i32 %add19, %conv24
  %mul26 = mul nsw i32 %i.0, 5
  %rem27 = urem i32 %mul26, %bufferSize
  %idxprom28 = zext i32 %rem27 to i64
  %arrayidx29 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom28
  %4 = load i8 addrspace(1)* %arrayidx29, align 1
  %conv30 = zext i8 %4 to i32
  %add31 = add nsw i32 %add25, %conv30
  %add32 = add i32 %tmp.0, %add31
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %for.cond35

for.cond35:                                       ; preds = %for.inc49, %for.end
  %i34.0 = phi i32 [ %conv2, %for.end ], [ %add50, %for.inc49 ]
  %cmp36 = icmp ult i32 %i34.0, %bufferSize
  br i1 %cmp36, label %for.body38, label %for.end51

for.body38:                                       ; preds = %for.cond35
  %idxprom39 = zext i32 %i34.0 to i64
  %arrayidx40 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom39
  %5 = load i8 addrspace(1)* %arrayidx40, align 1
  %conv41 = zext i8 %5 to i32
  %mul42 = mul nsw i32 %conv41, %multiplier
  %rem43 = srem i32 %mul42, 256
  %6 = load volatile i32* %zero, align 4
  %mul44 = mul i32 %6, %tmp.0
  %add45 = add i32 %rem43, %mul44
  %conv46 = trunc i32 %add45 to i8
  %idxprom47 = zext i32 %i34.0 to i64
  %arrayidx48 = getelementptr inbounds i8 addrspace(1)* %output, i64 %idxprom47
  store i8 %conv46, i8 addrspace(1)* %arrayidx48, align 1
  br label %for.inc49

for.inc49:                                        ; preds = %for.body38
  %add50 = add i32 %i34.0, %conv
  br label %for.cond35

for.end51:                                        ; preds = %for.cond35
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind
define cc75 void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* %lds) #0 {
entry:
  %zero = alloca i32, align 4
  %call = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store volatile i32 0, i32* %zero, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %tmp.0 = phi i32 [ 1, %entry ], [ %add31, %for.inc ]
  %i.0 = phi i32 [ 1, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 10000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul nsw i32 %i.0, 2
  %rem = urem i32 %mul, %bufferSize
  %idxprom = zext i32 %rem to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom
  %0 = load i8 addrspace(1)* %arrayidx, align 1
  %conv8 = zext i8 %0 to i32
  %mul9 = mul nsw i32 %i.0, 4
  %rem10 = urem i32 %mul9, %bufferSize
  %idxprom11 = zext i32 %rem10 to i64
  %arrayidx12 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom11
  %1 = load i8 addrspace(1)* %arrayidx12, align 1
  %conv13 = zext i8 %1 to i32
  %sub = sub nsw i32 %conv8, %conv13
  %mul14 = mul nsw i32 %i.0, 6
  %rem15 = urem i32 %mul14, %bufferSize
  %idxprom16 = zext i32 %rem15 to i64
  %arrayidx17 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom16
  %2 = load i8 addrspace(1)* %arrayidx17, align 1
  %conv18 = zext i8 %2 to i32
  %add = add nsw i32 %sub, %conv18
  %mul19 = mul nsw i32 %i.0, 8
  %rem20 = urem i32 %mul19, %bufferSize
  %idxprom21 = zext i32 %rem20 to i64
  %arrayidx22 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom21
  %3 = load i8 addrspace(1)* %arrayidx22, align 1
  %conv23 = zext i8 %3 to i32
  %sub24 = sub nsw i32 %add, %conv23
  %mul25 = mul nsw i32 %i.0, 10
  %rem26 = urem i32 %mul25, %bufferSize
  %idxprom27 = zext i32 %rem26 to i64
  %arrayidx28 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom27
  %4 = load i8 addrspace(1)* %arrayidx28, align 1
  %conv29 = zext i8 %4 to i32
  %add30 = add nsw i32 %sub24, %conv29
  %add31 = add nsw i32 %tmp.0, %add30
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %for.cond34

for.cond34:                                       ; preds = %for.inc52, %for.end
  %i33.0 = phi i32 [ %conv2, %for.end ], [ %add53, %for.inc52 ]
  %cmp35 = icmp ult i32 %i33.0, %bufferSize
  br i1 %cmp35, label %for.body37, label %for.end54

for.body37:                                       ; preds = %for.cond34
  %idxprom38 = zext i32 %i33.0 to i64
  %arrayidx39 = getelementptr inbounds i8 addrspace(1)* %input, i64 %idxprom38
  %5 = load i8 addrspace(1)* %arrayidx39, align 1
  %idxprom40 = sext i32 %conv4 to i64
  %arrayidx41 = getelementptr inbounds i8 addrspace(3)* %lds, i64 %idxprom40
  store i8 %5, i8 addrspace(3)* %arrayidx41, align 1
  %idxprom42 = sext i32 %conv4 to i64
  %arrayidx43 = getelementptr inbounds i8 addrspace(3)* %lds, i64 %idxprom42
  %6 = load i8 addrspace(3)* %arrayidx43, align 1
  %conv44 = zext i8 %6 to i32
  %mul45 = mul nsw i32 %conv44, %multiplier
  %rem46 = srem i32 %mul45, 256
  %7 = load volatile i32* %zero, align 4
  %mul47 = mul nsw i32 %7, %tmp.0
  %add48 = add nsw i32 %rem46, %mul47
  %conv49 = trunc i32 %add48 to i8
  %idxprom50 = zext i32 %i33.0 to i64
  %arrayidx51 = getelementptr inbounds i8 addrspace(1)* %output, i64 %idxprom50
  store i8 %conv49, i8 addrspace(1)* %arrayidx51, align 1
  br label %for.inc52

for.inc52:                                        ; preds = %for.body37
  %add53 = add i32 %i33.0, %conv
  br label %for.cond34

for.end54:                                        ; preds = %for.cond34
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K1_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  call cc75 void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K2_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  call cc75 void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K2.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K3_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  call cc75 void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K4_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  call cc75 void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K4.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K5_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  call cc75 void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K6_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  call cc75 void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K6.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K7_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  call cc75 void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K8_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  call cc75 void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K8.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K9_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  call cc75 void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_K10_kernel(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
entry:
  call cc75 void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K10.lds, i32 0, i32 0))
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !7, !8, !9, !10, !11, !12, !13, !14}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!15}
!opencl.spir.version = !{!15}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K1_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar*", metadata !"uchar*", metadata !"uint", metadata !"int"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar*", metadata !"uchar*", metadata !"uint", metadata !"int"}
!6 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K2_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!7 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K3_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!8 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K4_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!9 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K5_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!10 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K6_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!11 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K7_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!12 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K8_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!13 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K9_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!14 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @__OpenCL_K10_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!15 = metadata !{i32 1, i32 2}

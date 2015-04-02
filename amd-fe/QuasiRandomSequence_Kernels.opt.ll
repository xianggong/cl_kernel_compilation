; ModuleID = 'QuasiRandomSequence_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_QuasiRandomSequence_Vector_kernel(<4 x float> addrspace(1)* %output, <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(3)* %shared) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %mul = mul i32 %conv2, 4
  %vecinit = insertelement <4 x i32> undef, i32 %mul, i32 0
  %add = add i32 %mul, 1
  %vecinit5 = insertelement <4 x i32> %vecinit, i32 %add, i32 1
  %add6 = add i32 %mul, 2
  %vecinit7 = insertelement <4 x i32> %vecinit5, i32 %add6, i32 2
  %add8 = add i32 %mul, 3
  %vecinit9 = insertelement <4 x i32> %vecinit7, i32 %add8, i32 3
  %call10 = call cc75 float @_Z3powff(float 2.000000e+00, float 3.200000e+01) #1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ %conv2, %entry ], [ %conv19, %for.inc ]
  %cmp = icmp slt i32 %i.0, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul12 = mul i32 %conv4, 8
  %add13 = add i32 %mul12, %i.0
  %idxprom = zext i32 %add13 to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %idxprom
  %0 = load <4 x i32> addrspace(1)* %arrayidx, align 16
  %idxprom14 = sext i32 %i.0 to i64
  %arrayidx15 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i64 %idxprom14
  store <4 x i32> %0, <4 x i32> addrspace(3)* %arrayidx15, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %call16 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv17 = sext i32 %i.0 to i64
  %add18 = add i64 %conv17, %call16
  %conv19 = trunc i64 %add18 to i32
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  %1 = bitcast <4 x i32> addrspace(3)* %shared to i32 addrspace(3)*
  br label %for.cond20

for.cond20:                                       ; preds = %for.inc27, %for.end
  %temp.0 = phi <4 x i32> [ zeroinitializer, %for.end ], [ %xor, %for.inc27 ]
  %lastBit.0 = phi <4 x i32> [ %vecinit9, %for.end ], [ %shr, %for.inc27 ]
  %k.0 = phi i32 [ 0, %for.end ], [ %inc, %for.inc27 ]
  %cmp21 = icmp slt i32 %k.0, 12
  br i1 %cmp21, label %for.body23, label %for.end28

for.body23:                                       ; preds = %for.cond20
  %and = and <4 x i32> %lastBit.0, <i32 1, i32 1, i32 1, i32 1>
  %idxprom24 = sext i32 %k.0 to i64
  %arrayidx25 = getelementptr inbounds i32 addrspace(3)* %1, i64 %idxprom24
  %2 = load i32 addrspace(3)* %arrayidx25, align 4
  %3 = insertelement <4 x i32> undef, i32 %2, i32 0
  %splat = shufflevector <4 x i32> %3, <4 x i32> %3, <4 x i32> zeroinitializer
  %mul26 = mul <4 x i32> %and, %splat
  %xor = xor <4 x i32> %temp.0, %mul26
  %shr = lshr <4 x i32> %lastBit.0, <i32 1, i32 1, i32 1, i32 1>
  br label %for.inc27

for.inc27:                                        ; preds = %for.body23
  %inc = add nsw i32 %k.0, 1
  br label %for.cond20

for.end28:                                        ; preds = %for.cond20
  %call29 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %temp.0) #1
  %4 = insertelement <4 x float> undef, float %call10, i32 0
  %splat30 = shufflevector <4 x float> %4, <4 x float> %4, <4 x i32> zeroinitializer
  %div = fdiv <4 x float> %call29, %splat30, !fpmath !10
  %idxprom31 = zext i32 %conv to i64
  %arrayidx32 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %idxprom31
  store <4 x float> %div, <4 x float> addrspace(1)* %arrayidx32, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3powff(float, float) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

declare cc75 void @_Z7barrierj(i32)

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_QuasiRandomSequence_Scalar_kernel(float addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %shared) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 float @_Z3powff(float 2.000000e+00, float 3.200000e+01) #1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ %conv2, %entry ], [ %conv12, %for.inc ]
  %cmp = icmp slt i32 %i.0, 32
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul i32 %conv4, 32
  %add = add i32 %mul, %i.0
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %input, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %idxprom7 = sext i32 %i.0 to i64
  %arrayidx8 = getelementptr inbounds i32 addrspace(3)* %shared, i64 %idxprom7
  store i32 %0, i32 addrspace(3)* %arrayidx8, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %call9 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv10 = sext i32 %i.0 to i64
  %add11 = add i64 %conv10, %call9
  %conv12 = trunc i64 %add11 to i32
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond13

for.cond13:                                       ; preds = %for.inc20, %for.end
  %temp.0 = phi i32 [ 0, %for.end ], [ %xor, %for.inc20 ]
  %lastBit.0 = phi i32 [ %conv2, %for.end ], [ %shr, %for.inc20 ]
  %k.0 = phi i32 [ 0, %for.end ], [ %inc, %for.inc20 ]
  %cmp14 = icmp slt i32 %k.0, 10
  br i1 %cmp14, label %for.body16, label %for.end21

for.body16:                                       ; preds = %for.cond13
  %and = and i32 %lastBit.0, 1
  %idxprom17 = sext i32 %k.0 to i64
  %arrayidx18 = getelementptr inbounds i32 addrspace(3)* %shared, i64 %idxprom17
  %1 = load i32 addrspace(3)* %arrayidx18, align 4
  %mul19 = mul i32 %and, %1
  %xor = xor i32 %temp.0, %mul19
  %shr = lshr i32 %lastBit.0, 1
  br label %for.inc20

for.inc20:                                        ; preds = %for.body16
  %inc = add nsw i32 %k.0, 1
  br label %for.cond13

for.end21:                                        ; preds = %for.cond13
  %call22 = call cc75 float @_Z13convert_floatj(i32 %temp.0) #1
  %div = fdiv float %call22, %call5, !fpmath !10
  %idxprom23 = zext i32 %conv to i64
  %arrayidx24 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom23
  store float %div, float addrspace(1)* %arrayidx24, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 float @_Z13convert_floatj(i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!9}
!opencl.spir.version = !{!9}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @__OpenCL_QuasiRandomSequence_Vector_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"uint4*", metadata !"uint4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"uint4*", metadata !"uint4*"}
!6 = metadata !{void (float addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*)* @__OpenCL_QuasiRandomSequence_Scalar_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"uint*", metadata !"uint*"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"uint*", metadata !"uint*"}
!9 = metadata !{i32 1, i32 2}
!10 = metadata !{float 2.500000e+00}

; ModuleID = 'QuasiRandomSequence_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_QuasiRandomSequence_Vector_kernel(<4 x float> addrspace(1)* %output, <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(3)* %shared) #0 {
entry:
  %output.addr = alloca <4 x float> addrspace(1)*, align 8
  %input.addr = alloca <4 x i32> addrspace(1)*, align 8
  %shared.addr = alloca <4 x i32> addrspace(3)*, align 8
  %global_id = alloca i32, align 4
  %local_id = alloca i32, align 4
  %group_id = alloca i32, align 4
  %factor = alloca i32, align 4
  %vlid = alloca <4 x i32>, align 16
  %.compoundliteral = alloca <4 x i32>, align 16
  %divisor = alloca float, align 4
  %i = alloca i32, align 4
  %shared_scalar = alloca i32 addrspace(3)*, align 8
  %temp = alloca <4 x i32>, align 16
  %lastBit = alloca <4 x i32>, align 16
  %k = alloca i32, align 4
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %output.addr, align 8
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %input.addr, align 8
  store <4 x i32> addrspace(3)* %shared, <4 x i32> addrspace(3)** %shared.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %global_id, align 4
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %local_id, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %group_id, align 4
  %0 = load i32* %local_id, align 4
  %mul = mul i32 %0, 4
  store i32 %mul, i32* %factor, align 4
  %1 = load i32* %factor, align 4
  %vecinit = insertelement <4 x i32> undef, i32 %1, i32 0
  %2 = load i32* %factor, align 4
  %add = add i32 %2, 1
  %vecinit5 = insertelement <4 x i32> %vecinit, i32 %add, i32 1
  %3 = load i32* %factor, align 4
  %add6 = add i32 %3, 2
  %vecinit7 = insertelement <4 x i32> %vecinit5, i32 %add6, i32 2
  %4 = load i32* %factor, align 4
  %add8 = add i32 %4, 3
  %vecinit9 = insertelement <4 x i32> %vecinit7, i32 %add8, i32 3
  store <4 x i32> %vecinit9, <4 x i32>* %.compoundliteral
  %5 = load <4 x i32>* %.compoundliteral
  store <4 x i32> %5, <4 x i32>* %vlid, align 16
  %call10 = call cc75 float @_Z3powff(float 2.000000e+00, float 3.200000e+01) #1
  store float %call10, float* %divisor, align 4
  %6 = load i32* %local_id, align 4
  store i32 %6, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %7 = load i32* %i, align 4
  %cmp = icmp slt i32 %7, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %8 = load i32* %group_id, align 4
  %mul12 = mul i32 %8, 8
  %9 = load i32* %i, align 4
  %add13 = add i32 %mul12, %9
  %idxprom = zext i32 %add13 to i64
  %10 = load <4 x i32> addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %10, i64 %idxprom
  %11 = load <4 x i32> addrspace(1)* %arrayidx, align 16
  %12 = load i32* %i, align 4
  %idxprom14 = sext i32 %12 to i64
  %13 = load <4 x i32> addrspace(3)** %shared.addr, align 8
  %arrayidx15 = getelementptr inbounds <4 x i32> addrspace(3)* %13, i64 %idxprom14
  store <4 x i32> %11, <4 x i32> addrspace(3)* %arrayidx15, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %call16 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %14 = load i32* %i, align 4
  %conv17 = sext i32 %14 to i64
  %add18 = add i64 %conv17, %call16
  %conv19 = trunc i64 %add18 to i32
  store i32 %conv19, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  %15 = load <4 x i32> addrspace(3)** %shared.addr, align 8
  %16 = bitcast <4 x i32> addrspace(3)* %15 to i32 addrspace(3)*
  store i32 addrspace(3)* %16, i32 addrspace(3)** %shared_scalar, align 8
  store <4 x i32> zeroinitializer, <4 x i32>* %temp, align 16
  %17 = load <4 x i32>* %vlid, align 16
  store <4 x i32> %17, <4 x i32>* %lastBit, align 16
  store i32 0, i32* %k, align 4
  br label %for.cond20

for.cond20:                                       ; preds = %for.inc27, %for.end
  %18 = load i32* %k, align 4
  %cmp21 = icmp slt i32 %18, 12
  br i1 %cmp21, label %for.body23, label %for.end28

for.body23:                                       ; preds = %for.cond20
  %19 = load <4 x i32>* %lastBit, align 16
  %and = and <4 x i32> %19, <i32 1, i32 1, i32 1, i32 1>
  %20 = load i32* %k, align 4
  %idxprom24 = sext i32 %20 to i64
  %21 = load i32 addrspace(3)** %shared_scalar, align 8
  %arrayidx25 = getelementptr inbounds i32 addrspace(3)* %21, i64 %idxprom24
  %22 = load i32 addrspace(3)* %arrayidx25, align 4
  %23 = insertelement <4 x i32> undef, i32 %22, i32 0
  %splat = shufflevector <4 x i32> %23, <4 x i32> %23, <4 x i32> zeroinitializer
  %mul26 = mul <4 x i32> %and, %splat
  %24 = load <4 x i32>* %temp, align 16
  %xor = xor <4 x i32> %24, %mul26
  store <4 x i32> %xor, <4 x i32>* %temp, align 16
  %25 = load <4 x i32>* %lastBit, align 16
  %shr = lshr <4 x i32> %25, <i32 1, i32 1, i32 1, i32 1>
  store <4 x i32> %shr, <4 x i32>* %lastBit, align 16
  br label %for.inc27

for.inc27:                                        ; preds = %for.body23
  %26 = load i32* %k, align 4
  %inc = add nsw i32 %26, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond20

for.end28:                                        ; preds = %for.cond20
  %27 = load <4 x i32>* %temp, align 16
  %call29 = call cc75 <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %27) #1
  %28 = load float* %divisor, align 4
  %29 = insertelement <4 x float> undef, float %28, i32 0
  %splat30 = shufflevector <4 x float> %29, <4 x float> %29, <4 x i32> zeroinitializer
  %div = fdiv <4 x float> %call29, %splat30, !fpmath !10
  %30 = load i32* %global_id, align 4
  %idxprom31 = zext i32 %30 to i64
  %31 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx32 = getelementptr inbounds <4 x float> addrspace(1)* %31, i64 %idxprom31
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
  %output.addr = alloca float addrspace(1)*, align 8
  %input.addr = alloca i32 addrspace(1)*, align 8
  %shared.addr = alloca i32 addrspace(3)*, align 8
  %global_id = alloca i32, align 4
  %local_id = alloca i32, align 4
  %group_id = alloca i32, align 4
  %divisor = alloca float, align 4
  %i = alloca i32, align 4
  %temp = alloca i32, align 4
  %lastBit = alloca i32, align 4
  %k = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store i32 addrspace(3)* %shared, i32 addrspace(3)** %shared.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %global_id, align 4
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %local_id, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %group_id, align 4
  %call5 = call cc75 float @_Z3powff(float 2.000000e+00, float 3.200000e+01) #1
  store float %call5, float* %divisor, align 4
  %0 = load i32* %local_id, align 4
  store i32 %0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32* %i, align 4
  %cmp = icmp slt i32 %1, 32
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32* %group_id, align 4
  %mul = mul i32 %2, 32
  %3 = load i32* %i, align 4
  %add = add i32 %mul, %3
  %idxprom = zext i32 %add to i64
  %4 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %4, i64 %idxprom
  %5 = load i32 addrspace(1)* %arrayidx, align 4
  %6 = load i32* %i, align 4
  %idxprom7 = sext i32 %6 to i64
  %7 = load i32 addrspace(3)** %shared.addr, align 8
  %arrayidx8 = getelementptr inbounds i32 addrspace(3)* %7, i64 %idxprom7
  store i32 %5, i32 addrspace(3)* %arrayidx8, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %call9 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %8 = load i32* %i, align 4
  %conv10 = sext i32 %8 to i64
  %add11 = add i64 %conv10, %call9
  %conv12 = trunc i64 %add11 to i32
  store i32 %conv12, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %temp, align 4
  %9 = load i32* %local_id, align 4
  store i32 %9, i32* %lastBit, align 4
  store i32 0, i32* %k, align 4
  br label %for.cond13

for.cond13:                                       ; preds = %for.inc20, %for.end
  %10 = load i32* %k, align 4
  %cmp14 = icmp slt i32 %10, 10
  br i1 %cmp14, label %for.body16, label %for.end21

for.body16:                                       ; preds = %for.cond13
  %11 = load i32* %lastBit, align 4
  %and = and i32 %11, 1
  %12 = load i32* %k, align 4
  %idxprom17 = sext i32 %12 to i64
  %13 = load i32 addrspace(3)** %shared.addr, align 8
  %arrayidx18 = getelementptr inbounds i32 addrspace(3)* %13, i64 %idxprom17
  %14 = load i32 addrspace(3)* %arrayidx18, align 4
  %mul19 = mul i32 %and, %14
  %15 = load i32* %temp, align 4
  %xor = xor i32 %15, %mul19
  store i32 %xor, i32* %temp, align 4
  %16 = load i32* %lastBit, align 4
  %shr = lshr i32 %16, 1
  store i32 %shr, i32* %lastBit, align 4
  br label %for.inc20

for.inc20:                                        ; preds = %for.body16
  %17 = load i32* %k, align 4
  %inc = add nsw i32 %17, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond13

for.end21:                                        ; preds = %for.cond13
  %18 = load i32* %temp, align 4
  %call22 = call cc75 float @_Z13convert_floatj(i32 %18) #1
  %19 = load float* %divisor, align 4
  %div = fdiv float %call22, %19, !fpmath !10
  %20 = load i32* %global_id, align 4
  %idxprom23 = zext i32 %20 to i64
  %21 = load float addrspace(1)** %output.addr, align 8
  %arrayidx24 = getelementptr inbounds float addrspace(1)* %21, i64 %idxprom23
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

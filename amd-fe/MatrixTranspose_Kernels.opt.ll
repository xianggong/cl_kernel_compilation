; ModuleID = 'MatrixTranspose_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_matrixTranspose_kernel(<4 x float> addrspace(1)* %output, <4 x float> addrspace(1)* %input, <4 x float> addrspace(3)* %block) #0 {
entry:
  %call = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z14get_num_groupsj(i32 0) #1
  %conv6 = trunc i64 %call5 to i32
  %add = add i32 %conv2, %conv4
  %rem = urem i32 %add, %conv6
  %call7 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv8 = trunc i64 %call7 to i32
  %call9 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %conv10 = trunc i64 %call9 to i32
  %call11 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv12 = trunc i64 %call11 to i32
  %mul = mul i32 %rem, %conv12
  %add13 = add i32 %mul, %conv8
  %mul14 = mul i32 %conv2, %conv12
  %add15 = add i32 %mul14, %conv10
  %mul16 = mul i32 %add15, %conv
  %mul17 = mul i32 %mul16, 4
  %add18 = add i32 %add13, %mul17
  %mul19 = mul i32 %conv10, %conv12
  %mul20 = mul i32 %mul19, 4
  %add21 = add i32 %mul20, %conv8
  %idxprom = sext i32 %add18 to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom
  %0 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %idxprom22 = sext i32 %add21 to i64
  %arrayidx23 = getelementptr inbounds <4 x float> addrspace(3)* %block, i64 %idxprom22
  store <4 x float> %0, <4 x float> addrspace(3)* %arrayidx23, align 16
  %add24 = add i32 %add18, %conv
  %idxprom25 = zext i32 %add24 to i64
  %arrayidx26 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom25
  %1 = load <4 x float> addrspace(1)* %arrayidx26, align 16
  %add27 = add i32 %add21, %conv12
  %idxprom28 = zext i32 %add27 to i64
  %arrayidx29 = getelementptr inbounds <4 x float> addrspace(3)* %block, i64 %idxprom28
  store <4 x float> %1, <4 x float> addrspace(3)* %arrayidx29, align 16
  %mul30 = mul i32 %conv, 2
  %add31 = add i32 %add18, %mul30
  %idxprom32 = zext i32 %add31 to i64
  %arrayidx33 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom32
  %2 = load <4 x float> addrspace(1)* %arrayidx33, align 16
  %mul34 = mul i32 %conv12, 2
  %add35 = add i32 %add21, %mul34
  %idxprom36 = zext i32 %add35 to i64
  %arrayidx37 = getelementptr inbounds <4 x float> addrspace(3)* %block, i64 %idxprom36
  store <4 x float> %2, <4 x float> addrspace(3)* %arrayidx37, align 16
  %mul38 = mul i32 %conv, 3
  %add39 = add i32 %add18, %mul38
  %idxprom40 = zext i32 %add39 to i64
  %arrayidx41 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom40
  %3 = load <4 x float> addrspace(1)* %arrayidx41, align 16
  %mul42 = mul i32 %conv12, 3
  %add43 = add i32 %add21, %mul42
  %idxprom44 = zext i32 %add43 to i64
  %arrayidx45 = getelementptr inbounds <4 x float> addrspace(3)* %block, i64 %idxprom44
  store <4 x float> %3, <4 x float> addrspace(3)* %arrayidx45, align 16
  call cc75 void @_Z7barrierj(i32 1)
  %mul46 = mul i32 %conv2, %conv12
  %add47 = add i32 %mul46, %conv8
  %mul48 = mul i32 %rem, %conv12
  %add49 = add i32 %mul48, %conv10
  %mul50 = mul i32 %add49, %conv
  %mul51 = mul i32 %mul50, 4
  %add52 = add i32 %add47, %mul51
  %mul53 = mul i32 %conv8, %conv12
  %mul54 = mul i32 %mul53, 4
  %add55 = add i32 %mul54, %conv10
  %idxprom56 = sext i32 %add55 to i64
  %arrayidx57 = getelementptr inbounds <4 x float> addrspace(3)* %block, i64 %idxprom56
  %4 = load <4 x float> addrspace(3)* %arrayidx57, align 16
  %add58 = add i32 %add55, %conv12
  %idxprom59 = zext i32 %add58 to i64
  %arrayidx60 = getelementptr inbounds <4 x float> addrspace(3)* %block, i64 %idxprom59
  %5 = load <4 x float> addrspace(3)* %arrayidx60, align 16
  %mul61 = mul i32 %conv12, 2
  %add62 = add i32 %add55, %mul61
  %idxprom63 = zext i32 %add62 to i64
  %arrayidx64 = getelementptr inbounds <4 x float> addrspace(3)* %block, i64 %idxprom63
  %6 = load <4 x float> addrspace(3)* %arrayidx64, align 16
  %mul65 = mul i32 %conv12, 3
  %add66 = add i32 %add55, %mul65
  %idxprom67 = zext i32 %add66 to i64
  %arrayidx68 = getelementptr inbounds <4 x float> addrspace(3)* %block, i64 %idxprom67
  %7 = load <4 x float> addrspace(3)* %arrayidx68, align 16
  %8 = extractelement <4 x float> %4, i32 0
  %vecinit = insertelement <4 x float> undef, float %8, i32 0
  %9 = extractelement <4 x float> %5, i32 0
  %vecinit69 = insertelement <4 x float> %vecinit, float %9, i32 1
  %10 = extractelement <4 x float> %6, i32 0
  %vecinit70 = insertelement <4 x float> %vecinit69, float %10, i32 2
  %11 = extractelement <4 x float> %7, i32 0
  %vecinit71 = insertelement <4 x float> %vecinit70, float %11, i32 3
  %idxprom72 = sext i32 %add52 to i64
  %arrayidx73 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %idxprom72
  store <4 x float> %vecinit71, <4 x float> addrspace(1)* %arrayidx73, align 16
  %12 = extractelement <4 x float> %4, i32 1
  %vecinit75 = insertelement <4 x float> undef, float %12, i32 0
  %13 = extractelement <4 x float> %5, i32 1
  %vecinit76 = insertelement <4 x float> %vecinit75, float %13, i32 1
  %14 = extractelement <4 x float> %6, i32 1
  %vecinit77 = insertelement <4 x float> %vecinit76, float %14, i32 2
  %15 = extractelement <4 x float> %7, i32 1
  %vecinit78 = insertelement <4 x float> %vecinit77, float %15, i32 3
  %add79 = add i32 %add52, %conv
  %idxprom80 = zext i32 %add79 to i64
  %arrayidx81 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %idxprom80
  store <4 x float> %vecinit78, <4 x float> addrspace(1)* %arrayidx81, align 16
  %16 = extractelement <4 x float> %4, i32 2
  %vecinit83 = insertelement <4 x float> undef, float %16, i32 0
  %17 = extractelement <4 x float> %5, i32 2
  %vecinit84 = insertelement <4 x float> %vecinit83, float %17, i32 1
  %18 = extractelement <4 x float> %6, i32 2
  %vecinit85 = insertelement <4 x float> %vecinit84, float %18, i32 2
  %19 = extractelement <4 x float> %7, i32 2
  %vecinit86 = insertelement <4 x float> %vecinit85, float %19, i32 3
  %mul87 = mul i32 %conv, 2
  %add88 = add i32 %add52, %mul87
  %idxprom89 = zext i32 %add88 to i64
  %arrayidx90 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %idxprom89
  store <4 x float> %vecinit86, <4 x float> addrspace(1)* %arrayidx90, align 16
  %20 = extractelement <4 x float> %4, i32 3
  %vecinit92 = insertelement <4 x float> undef, float %20, i32 0
  %21 = extractelement <4 x float> %5, i32 3
  %vecinit93 = insertelement <4 x float> %vecinit92, float %21, i32 1
  %22 = extractelement <4 x float> %6, i32 3
  %vecinit94 = insertelement <4 x float> %vecinit93, float %22, i32 2
  %23 = extractelement <4 x float> %7, i32 3
  %vecinit95 = insertelement <4 x float> %vecinit94, float %23, i32 3
  %mul96 = mul i32 %conv, 3
  %add97 = add i32 %add52, %mul96
  %idxprom98 = zext i32 %add97 to i64
  %arrayidx99 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %idxprom98
  store <4 x float> %vecinit95, <4 x float> addrspace(1)* %arrayidx99, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_num_groupsj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

declare cc75 void @_Z7barrierj(i32)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*)* @__OpenCL_matrixTranspose_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 3}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"float4*", metadata !"float4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"float4*", metadata !"float4*"}
!6 = metadata !{i32 1, i32 2}

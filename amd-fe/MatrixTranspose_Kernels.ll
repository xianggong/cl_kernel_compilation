; ModuleID = 'MatrixTranspose_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_matrixTranspose_kernel(<4 x float> addrspace(1)* %output, <4 x float> addrspace(1)* %input, <4 x float> addrspace(3)* %block) #0 {
entry:
  %output.addr = alloca <4 x float> addrspace(1)*, align 8
  %input.addr = alloca <4 x float> addrspace(1)*, align 8
  %block.addr = alloca <4 x float> addrspace(3)*, align 8
  %wiWidth = alloca i32, align 4
  %gix_t = alloca i32, align 4
  %giy_t = alloca i32, align 4
  %num_of_blocks_x = alloca i32, align 4
  %giy = alloca i32, align 4
  %gix = alloca i32, align 4
  %lix = alloca i32, align 4
  %liy = alloca i32, align 4
  %blockSize = alloca i32, align 4
  %ix = alloca i32, align 4
  %iy = alloca i32, align 4
  %index_in = alloca i32, align 4
  %ind = alloca i32, align 4
  %index_out = alloca i32, align 4
  %v0 = alloca <4 x float>, align 16
  %v1 = alloca <4 x float>, align 16
  %v2 = alloca <4 x float>, align 16
  %v3 = alloca <4 x float>, align 16
  %.compoundliteral = alloca <4 x float>, align 16
  %.compoundliteral74 = alloca <4 x float>, align 16
  %.compoundliteral82 = alloca <4 x float>, align 16
  %.compoundliteral91 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %output.addr, align 8
  store <4 x float> addrspace(1)* %input, <4 x float> addrspace(1)** %input.addr, align 8
  store <4 x float> addrspace(3)* %block, <4 x float> addrspace(3)** %block.addr, align 8
  %call = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %wiWidth, align 4
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %gix_t, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %giy_t, align 4
  %call5 = call cc75 i64 @_Z14get_num_groupsj(i32 0) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %num_of_blocks_x, align 4
  %0 = load i32* %gix_t, align 4
  store i32 %0, i32* %giy, align 4
  %1 = load i32* %gix_t, align 4
  %2 = load i32* %giy_t, align 4
  %add = add i32 %1, %2
  %3 = load i32* %num_of_blocks_x, align 4
  %rem = urem i32 %add, %3
  store i32 %rem, i32* %gix, align 4
  %call7 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv8 = trunc i64 %call7 to i32
  store i32 %conv8, i32* %lix, align 4
  %call9 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %conv10 = trunc i64 %call9 to i32
  store i32 %conv10, i32* %liy, align 4
  %call11 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv12 = trunc i64 %call11 to i32
  store i32 %conv12, i32* %blockSize, align 4
  %4 = load i32* %gix, align 4
  %5 = load i32* %blockSize, align 4
  %mul = mul i32 %4, %5
  %6 = load i32* %lix, align 4
  %add13 = add i32 %mul, %6
  store i32 %add13, i32* %ix, align 4
  %7 = load i32* %giy, align 4
  %8 = load i32* %blockSize, align 4
  %mul14 = mul i32 %7, %8
  %9 = load i32* %liy, align 4
  %add15 = add i32 %mul14, %9
  store i32 %add15, i32* %iy, align 4
  %10 = load i32* %ix, align 4
  %11 = load i32* %iy, align 4
  %12 = load i32* %wiWidth, align 4
  %mul16 = mul i32 %11, %12
  %mul17 = mul i32 %mul16, 4
  %add18 = add i32 %10, %mul17
  store i32 %add18, i32* %index_in, align 4
  %13 = load i32* %liy, align 4
  %14 = load i32* %blockSize, align 4
  %mul19 = mul i32 %13, %14
  %mul20 = mul i32 %mul19, 4
  %15 = load i32* %lix, align 4
  %add21 = add i32 %mul20, %15
  store i32 %add21, i32* %ind, align 4
  %16 = load i32* %index_in, align 4
  %idxprom = sext i32 %16 to i64
  %17 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %17, i64 %idxprom
  %18 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %19 = load i32* %ind, align 4
  %idxprom22 = sext i32 %19 to i64
  %20 = load <4 x float> addrspace(3)** %block.addr, align 8
  %arrayidx23 = getelementptr inbounds <4 x float> addrspace(3)* %20, i64 %idxprom22
  store <4 x float> %18, <4 x float> addrspace(3)* %arrayidx23, align 16
  %21 = load i32* %index_in, align 4
  %22 = load i32* %wiWidth, align 4
  %add24 = add i32 %21, %22
  %idxprom25 = zext i32 %add24 to i64
  %23 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx26 = getelementptr inbounds <4 x float> addrspace(1)* %23, i64 %idxprom25
  %24 = load <4 x float> addrspace(1)* %arrayidx26, align 16
  %25 = load i32* %ind, align 4
  %26 = load i32* %blockSize, align 4
  %add27 = add i32 %25, %26
  %idxprom28 = zext i32 %add27 to i64
  %27 = load <4 x float> addrspace(3)** %block.addr, align 8
  %arrayidx29 = getelementptr inbounds <4 x float> addrspace(3)* %27, i64 %idxprom28
  store <4 x float> %24, <4 x float> addrspace(3)* %arrayidx29, align 16
  %28 = load i32* %index_in, align 4
  %29 = load i32* %wiWidth, align 4
  %mul30 = mul i32 %29, 2
  %add31 = add i32 %28, %mul30
  %idxprom32 = zext i32 %add31 to i64
  %30 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx33 = getelementptr inbounds <4 x float> addrspace(1)* %30, i64 %idxprom32
  %31 = load <4 x float> addrspace(1)* %arrayidx33, align 16
  %32 = load i32* %ind, align 4
  %33 = load i32* %blockSize, align 4
  %mul34 = mul i32 %33, 2
  %add35 = add i32 %32, %mul34
  %idxprom36 = zext i32 %add35 to i64
  %34 = load <4 x float> addrspace(3)** %block.addr, align 8
  %arrayidx37 = getelementptr inbounds <4 x float> addrspace(3)* %34, i64 %idxprom36
  store <4 x float> %31, <4 x float> addrspace(3)* %arrayidx37, align 16
  %35 = load i32* %index_in, align 4
  %36 = load i32* %wiWidth, align 4
  %mul38 = mul i32 %36, 3
  %add39 = add i32 %35, %mul38
  %idxprom40 = zext i32 %add39 to i64
  %37 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx41 = getelementptr inbounds <4 x float> addrspace(1)* %37, i64 %idxprom40
  %38 = load <4 x float> addrspace(1)* %arrayidx41, align 16
  %39 = load i32* %ind, align 4
  %40 = load i32* %blockSize, align 4
  %mul42 = mul i32 %40, 3
  %add43 = add i32 %39, %mul42
  %idxprom44 = zext i32 %add43 to i64
  %41 = load <4 x float> addrspace(3)** %block.addr, align 8
  %arrayidx45 = getelementptr inbounds <4 x float> addrspace(3)* %41, i64 %idxprom44
  store <4 x float> %38, <4 x float> addrspace(3)* %arrayidx45, align 16
  call cc75 void @_Z7barrierj(i32 1)
  %42 = load i32* %giy, align 4
  %43 = load i32* %blockSize, align 4
  %mul46 = mul i32 %42, %43
  %44 = load i32* %lix, align 4
  %add47 = add i32 %mul46, %44
  store i32 %add47, i32* %ix, align 4
  %45 = load i32* %gix, align 4
  %46 = load i32* %blockSize, align 4
  %mul48 = mul i32 %45, %46
  %47 = load i32* %liy, align 4
  %add49 = add i32 %mul48, %47
  store i32 %add49, i32* %iy, align 4
  %48 = load i32* %ix, align 4
  %49 = load i32* %iy, align 4
  %50 = load i32* %wiWidth, align 4
  %mul50 = mul i32 %49, %50
  %mul51 = mul i32 %mul50, 4
  %add52 = add i32 %48, %mul51
  store i32 %add52, i32* %index_out, align 4
  %51 = load i32* %lix, align 4
  %52 = load i32* %blockSize, align 4
  %mul53 = mul i32 %51, %52
  %mul54 = mul i32 %mul53, 4
  %53 = load i32* %liy, align 4
  %add55 = add i32 %mul54, %53
  store i32 %add55, i32* %ind, align 4
  %54 = load i32* %ind, align 4
  %idxprom56 = sext i32 %54 to i64
  %55 = load <4 x float> addrspace(3)** %block.addr, align 8
  %arrayidx57 = getelementptr inbounds <4 x float> addrspace(3)* %55, i64 %idxprom56
  %56 = load <4 x float> addrspace(3)* %arrayidx57, align 16
  store <4 x float> %56, <4 x float>* %v0, align 16
  %57 = load i32* %ind, align 4
  %58 = load i32* %blockSize, align 4
  %add58 = add i32 %57, %58
  %idxprom59 = zext i32 %add58 to i64
  %59 = load <4 x float> addrspace(3)** %block.addr, align 8
  %arrayidx60 = getelementptr inbounds <4 x float> addrspace(3)* %59, i64 %idxprom59
  %60 = load <4 x float> addrspace(3)* %arrayidx60, align 16
  store <4 x float> %60, <4 x float>* %v1, align 16
  %61 = load i32* %ind, align 4
  %62 = load i32* %blockSize, align 4
  %mul61 = mul i32 %62, 2
  %add62 = add i32 %61, %mul61
  %idxprom63 = zext i32 %add62 to i64
  %63 = load <4 x float> addrspace(3)** %block.addr, align 8
  %arrayidx64 = getelementptr inbounds <4 x float> addrspace(3)* %63, i64 %idxprom63
  %64 = load <4 x float> addrspace(3)* %arrayidx64, align 16
  store <4 x float> %64, <4 x float>* %v2, align 16
  %65 = load i32* %ind, align 4
  %66 = load i32* %blockSize, align 4
  %mul65 = mul i32 %66, 3
  %add66 = add i32 %65, %mul65
  %idxprom67 = zext i32 %add66 to i64
  %67 = load <4 x float> addrspace(3)** %block.addr, align 8
  %arrayidx68 = getelementptr inbounds <4 x float> addrspace(3)* %67, i64 %idxprom67
  %68 = load <4 x float> addrspace(3)* %arrayidx68, align 16
  store <4 x float> %68, <4 x float>* %v3, align 16
  %69 = load <4 x float>* %v0, align 16
  %70 = extractelement <4 x float> %69, i32 0
  %vecinit = insertelement <4 x float> undef, float %70, i32 0
  %71 = load <4 x float>* %v1, align 16
  %72 = extractelement <4 x float> %71, i32 0
  %vecinit69 = insertelement <4 x float> %vecinit, float %72, i32 1
  %73 = load <4 x float>* %v2, align 16
  %74 = extractelement <4 x float> %73, i32 0
  %vecinit70 = insertelement <4 x float> %vecinit69, float %74, i32 2
  %75 = load <4 x float>* %v3, align 16
  %76 = extractelement <4 x float> %75, i32 0
  %vecinit71 = insertelement <4 x float> %vecinit70, float %76, i32 3
  store <4 x float> %vecinit71, <4 x float>* %.compoundliteral
  %77 = load <4 x float>* %.compoundliteral
  %78 = load i32* %index_out, align 4
  %idxprom72 = sext i32 %78 to i64
  %79 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx73 = getelementptr inbounds <4 x float> addrspace(1)* %79, i64 %idxprom72
  store <4 x float> %77, <4 x float> addrspace(1)* %arrayidx73, align 16
  %80 = load <4 x float>* %v0, align 16
  %81 = extractelement <4 x float> %80, i32 1
  %vecinit75 = insertelement <4 x float> undef, float %81, i32 0
  %82 = load <4 x float>* %v1, align 16
  %83 = extractelement <4 x float> %82, i32 1
  %vecinit76 = insertelement <4 x float> %vecinit75, float %83, i32 1
  %84 = load <4 x float>* %v2, align 16
  %85 = extractelement <4 x float> %84, i32 1
  %vecinit77 = insertelement <4 x float> %vecinit76, float %85, i32 2
  %86 = load <4 x float>* %v3, align 16
  %87 = extractelement <4 x float> %86, i32 1
  %vecinit78 = insertelement <4 x float> %vecinit77, float %87, i32 3
  store <4 x float> %vecinit78, <4 x float>* %.compoundliteral74
  %88 = load <4 x float>* %.compoundliteral74
  %89 = load i32* %index_out, align 4
  %90 = load i32* %wiWidth, align 4
  %add79 = add i32 %89, %90
  %idxprom80 = zext i32 %add79 to i64
  %91 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx81 = getelementptr inbounds <4 x float> addrspace(1)* %91, i64 %idxprom80
  store <4 x float> %88, <4 x float> addrspace(1)* %arrayidx81, align 16
  %92 = load <4 x float>* %v0, align 16
  %93 = extractelement <4 x float> %92, i32 2
  %vecinit83 = insertelement <4 x float> undef, float %93, i32 0
  %94 = load <4 x float>* %v1, align 16
  %95 = extractelement <4 x float> %94, i32 2
  %vecinit84 = insertelement <4 x float> %vecinit83, float %95, i32 1
  %96 = load <4 x float>* %v2, align 16
  %97 = extractelement <4 x float> %96, i32 2
  %vecinit85 = insertelement <4 x float> %vecinit84, float %97, i32 2
  %98 = load <4 x float>* %v3, align 16
  %99 = extractelement <4 x float> %98, i32 2
  %vecinit86 = insertelement <4 x float> %vecinit85, float %99, i32 3
  store <4 x float> %vecinit86, <4 x float>* %.compoundliteral82
  %100 = load <4 x float>* %.compoundliteral82
  %101 = load i32* %index_out, align 4
  %102 = load i32* %wiWidth, align 4
  %mul87 = mul i32 %102, 2
  %add88 = add i32 %101, %mul87
  %idxprom89 = zext i32 %add88 to i64
  %103 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx90 = getelementptr inbounds <4 x float> addrspace(1)* %103, i64 %idxprom89
  store <4 x float> %100, <4 x float> addrspace(1)* %arrayidx90, align 16
  %104 = load <4 x float>* %v0, align 16
  %105 = extractelement <4 x float> %104, i32 3
  %vecinit92 = insertelement <4 x float> undef, float %105, i32 0
  %106 = load <4 x float>* %v1, align 16
  %107 = extractelement <4 x float> %106, i32 3
  %vecinit93 = insertelement <4 x float> %vecinit92, float %107, i32 1
  %108 = load <4 x float>* %v2, align 16
  %109 = extractelement <4 x float> %108, i32 3
  %vecinit94 = insertelement <4 x float> %vecinit93, float %109, i32 2
  %110 = load <4 x float>* %v3, align 16
  %111 = extractelement <4 x float> %110, i32 3
  %vecinit95 = insertelement <4 x float> %vecinit94, float %111, i32 3
  store <4 x float> %vecinit95, <4 x float>* %.compoundliteral91
  %112 = load <4 x float>* %.compoundliteral91
  %113 = load i32* %index_out, align 4
  %114 = load i32* %wiWidth, align 4
  %mul96 = mul i32 %114, 3
  %add97 = add i32 %113, %mul96
  %idxprom98 = zext i32 %add97 to i64
  %115 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx99 = getelementptr inbounds <4 x float> addrspace(1)* %115, i64 %idxprom98
  store <4 x float> %112, <4 x float> addrspace(1)* %arrayidx99, align 16
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

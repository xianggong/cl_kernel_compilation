; ModuleID = 'DCT_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc75 i32 @getIdx(i32 %blockIdx, i32 %blockIdy, i32 %localIdx, i32 %localIdy, i32 %blockWidth, i32 %globalWidth) #0 {
entry:
  %blockIdx.addr = alloca i32, align 4
  %blockIdy.addr = alloca i32, align 4
  %localIdx.addr = alloca i32, align 4
  %localIdy.addr = alloca i32, align 4
  %blockWidth.addr = alloca i32, align 4
  %globalWidth.addr = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %globalIdy = alloca i32, align 4
  store i32 %blockIdx, i32* %blockIdx.addr, align 4
  store i32 %blockIdy, i32* %blockIdy.addr, align 4
  store i32 %localIdx, i32* %localIdx.addr, align 4
  store i32 %localIdy, i32* %localIdy.addr, align 4
  store i32 %blockWidth, i32* %blockWidth.addr, align 4
  store i32 %globalWidth, i32* %globalWidth.addr, align 4
  %0 = load i32* %blockIdx.addr, align 4
  %1 = load i32* %blockWidth.addr, align 4
  %mul = mul i32 %0, %1
  %2 = load i32* %localIdx.addr, align 4
  %add = add i32 %mul, %2
  store i32 %add, i32* %globalIdx, align 4
  %3 = load i32* %blockIdy.addr, align 4
  %4 = load i32* %blockWidth.addr, align 4
  %mul1 = mul i32 %3, %4
  %5 = load i32* %localIdy.addr, align 4
  %add2 = add i32 %mul1, %5
  store i32 %add2, i32* %globalIdy, align 4
  %6 = load i32* %globalIdy, align 4
  %7 = load i32* %globalWidth.addr, align 4
  %mul3 = mul i32 %6, %7
  %8 = load i32* %globalIdx, align 4
  %add4 = add i32 %mul3, %8
  ret i32 %add4
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_DCT_kernel(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(1)* %dct8x8, float addrspace(1)* %dct8x8_trans, float addrspace(3)* %inter, i32 %width, i32 %blockWidth, i32 %inverse) #0 {
entry:
  %output.addr = alloca float addrspace(1)*, align 8
  %input.addr = alloca float addrspace(1)*, align 8
  %dct8x8.addr = alloca float addrspace(1)*, align 8
  %dct8x8_trans.addr = alloca float addrspace(1)*, align 8
  %inter.addr = alloca float addrspace(3)*, align 8
  %width.addr = alloca i32, align 4
  %blockWidth.addr = alloca i32, align 4
  %inverse.addr = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %globalIdy = alloca i32, align 4
  %groupIdx = alloca i32, align 4
  %groupIdy = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %idx = alloca i32, align 4
  %acc = alloca float, align 4
  %k = alloca i32, align 4
  %index1 = alloca i32, align 4
  %index2 = alloca i32, align 4
  %k29 = alloca i32, align 4
  %index134 = alloca i32, align 4
  %index237 = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  store float addrspace(1)* %input, float addrspace(1)** %input.addr, align 8
  store float addrspace(1)* %dct8x8, float addrspace(1)** %dct8x8.addr, align 8
  store float addrspace(1)* %dct8x8_trans, float addrspace(1)** %dct8x8_trans.addr, align 8
  store float addrspace(3)* %inter, float addrspace(3)** %inter.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store i32 %blockWidth, i32* %blockWidth.addr, align 4
  store i32 %inverse, i32* %inverse.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %globalIdx, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %globalIdy, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %groupIdx, align 4
  %call5 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %groupIdy, align 4
  %call7 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv8 = trunc i64 %call7 to i32
  store i32 %conv8, i32* %i, align 4
  %call9 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %conv10 = trunc i64 %call9 to i32
  store i32 %conv10, i32* %j, align 4
  %0 = load i32* %globalIdy, align 4
  %1 = load i32* %width.addr, align 4
  %mul = mul i32 %0, %1
  %2 = load i32* %globalIdx, align 4
  %add = add i32 %mul, %2
  store i32 %add, i32* %idx, align 4
  store float 0.000000e+00, float* %acc, align 4
  store i32 0, i32* %k, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %3 = load i32* %k, align 4
  %4 = load i32* %blockWidth.addr, align 4
  %cmp = icmp ult i32 %3, %4
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %5 = load i32* %j, align 4
  %6 = load i32* %blockWidth.addr, align 4
  %mul12 = mul i32 %5, %6
  %7 = load i32* %k, align 4
  %add13 = add i32 %mul12, %7
  store i32 %add13, i32* %index1, align 4
  %8 = load i32* %groupIdx, align 4
  %9 = load i32* %groupIdy, align 4
  %10 = load i32* %i, align 4
  %11 = load i32* %k, align 4
  %12 = load i32* %blockWidth.addr, align 4
  %13 = load i32* %width.addr, align 4
  %call14 = call cc75 i32 @getIdx(i32 %8, i32 %9, i32 %10, i32 %11, i32 %12, i32 %13)
  store i32 %call14, i32* %index2, align 4
  %14 = load i32* %inverse.addr, align 4
  %tobool = icmp ne i32 %14, 0
  br i1 %tobool, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %15 = load i32* %index1, align 4
  %idxprom = zext i32 %15 to i64
  %16 = load float addrspace(1)** %dct8x8.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %16, i64 %idxprom
  %17 = load float addrspace(1)* %arrayidx, align 4
  %18 = load i32* %index2, align 4
  %idxprom15 = zext i32 %18 to i64
  %19 = load float addrspace(1)** %input.addr, align 8
  %arrayidx16 = getelementptr inbounds float addrspace(1)* %19, i64 %idxprom15
  %20 = load float addrspace(1)* %arrayidx16, align 4
  %mul17 = fmul float %17, %20
  %21 = load float* %acc, align 4
  %add18 = fadd float %21, %mul17
  store float %add18, float* %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %22 = load i32* %index1, align 4
  %idxprom19 = zext i32 %22 to i64
  %23 = load float addrspace(1)** %dct8x8_trans.addr, align 8
  %arrayidx20 = getelementptr inbounds float addrspace(1)* %23, i64 %idxprom19
  %24 = load float addrspace(1)* %arrayidx20, align 4
  %25 = load i32* %index2, align 4
  %idxprom21 = zext i32 %25 to i64
  %26 = load float addrspace(1)** %input.addr, align 8
  %arrayidx22 = getelementptr inbounds float addrspace(1)* %26, i64 %idxprom21
  %27 = load float addrspace(1)* %arrayidx22, align 4
  %mul23 = fmul float %24, %27
  %28 = load float* %acc, align 4
  %add24 = fadd float %28, %mul23
  store float %add24, float* %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %29 = load i32* %k, align 4
  %inc = add i32 %29, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %30 = load float* %acc, align 4
  %31 = load i32* %j, align 4
  %32 = load i32* %blockWidth.addr, align 4
  %mul25 = mul i32 %31, %32
  %33 = load i32* %i, align 4
  %add26 = add i32 %mul25, %33
  %idxprom27 = zext i32 %add26 to i64
  %34 = load float addrspace(3)** %inter.addr, align 8
  %arrayidx28 = getelementptr inbounds float addrspace(3)* %34, i64 %idxprom27
  store float %30, float addrspace(3)* %arrayidx28, align 4
  call cc75 void @_Z7barrierj(i32 1)
  store float 0.000000e+00, float* %acc, align 4
  store i32 0, i32* %k29, align 4
  br label %for.cond30

for.cond30:                                       ; preds = %for.inc56, %for.end
  %35 = load i32* %k29, align 4
  %36 = load i32* %blockWidth.addr, align 4
  %cmp31 = icmp ult i32 %35, %36
  br i1 %cmp31, label %for.body33, label %for.end58

for.body33:                                       ; preds = %for.cond30
  %37 = load i32* %j, align 4
  %38 = load i32* %blockWidth.addr, align 4
  %mul35 = mul i32 %37, %38
  %39 = load i32* %k29, align 4
  %add36 = add i32 %mul35, %39
  store i32 %add36, i32* %index134, align 4
  %40 = load i32* %k29, align 4
  %41 = load i32* %blockWidth.addr, align 4
  %mul38 = mul i32 %40, %41
  %42 = load i32* %i, align 4
  %add39 = add i32 %mul38, %42
  store i32 %add39, i32* %index237, align 4
  %43 = load i32* %inverse.addr, align 4
  %tobool40 = icmp ne i32 %43, 0
  br i1 %tobool40, label %if.then41, label %if.else48

if.then41:                                        ; preds = %for.body33
  %44 = load i32* %index134, align 4
  %idxprom42 = zext i32 %44 to i64
  %45 = load float addrspace(3)** %inter.addr, align 8
  %arrayidx43 = getelementptr inbounds float addrspace(3)* %45, i64 %idxprom42
  %46 = load float addrspace(3)* %arrayidx43, align 4
  %47 = load i32* %index237, align 4
  %idxprom44 = zext i32 %47 to i64
  %48 = load float addrspace(1)** %dct8x8_trans.addr, align 8
  %arrayidx45 = getelementptr inbounds float addrspace(1)* %48, i64 %idxprom44
  %49 = load float addrspace(1)* %arrayidx45, align 4
  %mul46 = fmul float %46, %49
  %50 = load float* %acc, align 4
  %add47 = fadd float %50, %mul46
  store float %add47, float* %acc, align 4
  br label %if.end55

if.else48:                                        ; preds = %for.body33
  %51 = load i32* %index134, align 4
  %idxprom49 = zext i32 %51 to i64
  %52 = load float addrspace(3)** %inter.addr, align 8
  %arrayidx50 = getelementptr inbounds float addrspace(3)* %52, i64 %idxprom49
  %53 = load float addrspace(3)* %arrayidx50, align 4
  %54 = load i32* %index237, align 4
  %idxprom51 = zext i32 %54 to i64
  %55 = load float addrspace(1)** %dct8x8.addr, align 8
  %arrayidx52 = getelementptr inbounds float addrspace(1)* %55, i64 %idxprom51
  %56 = load float addrspace(1)* %arrayidx52, align 4
  %mul53 = fmul float %53, %56
  %57 = load float* %acc, align 4
  %add54 = fadd float %57, %mul53
  store float %add54, float* %acc, align 4
  br label %if.end55

if.end55:                                         ; preds = %if.else48, %if.then41
  br label %for.inc56

for.inc56:                                        ; preds = %if.end55
  %58 = load i32* %k29, align 4
  %inc57 = add i32 %58, 1
  store i32 %inc57, i32* %k29, align 4
  br label %for.cond30

for.end58:                                        ; preds = %for.cond30
  %59 = load float* %acc, align 4
  %60 = load i32* %idx, align 4
  %idxprom59 = zext i32 %60 to i64
  %61 = load float addrspace(1)** %output.addr, align 8
  %arrayidx60 = getelementptr inbounds float addrspace(1)* %61, i64 %idxprom59
  store float %59, float addrspace(1)* %arrayidx60, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32)* @__OpenCL_DCT_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 1, i32 3, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"const", metadata !"const", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{i32 1, i32 2}

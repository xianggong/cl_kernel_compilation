; ModuleID = 'SimpleConvolution_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_simpleConvolution_kernel(i32 addrspace(1)* %output, i32 addrspace(1)* %input, float addrspace(1)* %mask, <2 x i32> %inputDimensions, <2 x i32> %maskDimensions) #0 {
entry:
  %output.addr = alloca i32 addrspace(1)*, align 8
  %input.addr = alloca i32 addrspace(1)*, align 8
  %mask.addr = alloca float addrspace(1)*, align 8
  %inputDimensions.addr = alloca <2 x i32>, align 8
  %maskDimensions.addr = alloca <2 x i32>, align 8
  %tid = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %maskWidth = alloca i32, align 4
  %maskHeight = alloca i32, align 4
  %vstep = alloca i32, align 4
  %hstep = alloca i32, align 4
  %left = alloca i32, align 4
  %right = alloca i32, align 4
  %top = alloca i32, align 4
  %bottom = alloca i32, align 4
  %sumFX = alloca float, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %maskIndex = alloca i32, align 4
  %index = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %output.addr, align 8
  store i32 addrspace(1)* %input, i32 addrspace(1)** %input.addr, align 8
  store float addrspace(1)* %mask, float addrspace(1)** %mask.addr, align 8
  store <2 x i32> %inputDimensions, <2 x i32>* %inputDimensions.addr, align 8
  store <2 x i32> %maskDimensions, <2 x i32>* %maskDimensions.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  %0 = load <2 x i32>* %inputDimensions.addr, align 8
  %1 = extractelement <2 x i32> %0, i32 0
  store i32 %1, i32* %width, align 4
  %2 = load <2 x i32>* %inputDimensions.addr, align 8
  %3 = extractelement <2 x i32> %2, i32 1
  store i32 %3, i32* %height, align 4
  %4 = load i32* %tid, align 4
  %5 = load i32* %width, align 4
  %rem = urem i32 %4, %5
  store i32 %rem, i32* %x, align 4
  %6 = load i32* %tid, align 4
  %7 = load i32* %width, align 4
  %div = udiv i32 %6, %7
  store i32 %div, i32* %y, align 4
  %8 = load <2 x i32>* %maskDimensions.addr, align 8
  %9 = extractelement <2 x i32> %8, i32 0
  store i32 %9, i32* %maskWidth, align 4
  %10 = load <2 x i32>* %maskDimensions.addr, align 8
  %11 = extractelement <2 x i32> %10, i32 1
  store i32 %11, i32* %maskHeight, align 4
  %12 = load i32* %maskWidth, align 4
  %sub = sub i32 %12, 1
  %div1 = udiv i32 %sub, 2
  store i32 %div1, i32* %vstep, align 4
  %13 = load i32* %maskHeight, align 4
  %sub2 = sub i32 %13, 1
  %div3 = udiv i32 %sub2, 2
  store i32 %div3, i32* %hstep, align 4
  %14 = load i32* %x, align 4
  %15 = load i32* %vstep, align 4
  %cmp = icmp ult i32 %14, %15
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  br label %cond.end

cond.false:                                       ; preds = %entry
  %16 = load i32* %x, align 4
  %17 = load i32* %vstep, align 4
  %sub5 = sub i32 %16, %17
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ 0, %cond.true ], [ %sub5, %cond.false ]
  store i32 %cond, i32* %left, align 4
  %18 = load i32* %x, align 4
  %19 = load i32* %vstep, align 4
  %add = add i32 %18, %19
  %20 = load i32* %width, align 4
  %cmp6 = icmp uge i32 %add, %20
  br i1 %cmp6, label %cond.true8, label %cond.false10

cond.true8:                                       ; preds = %cond.end
  %21 = load i32* %width, align 4
  %sub9 = sub i32 %21, 1
  br label %cond.end12

cond.false10:                                     ; preds = %cond.end
  %22 = load i32* %x, align 4
  %23 = load i32* %vstep, align 4
  %add11 = add i32 %22, %23
  br label %cond.end12

cond.end12:                                       ; preds = %cond.false10, %cond.true8
  %cond13 = phi i32 [ %sub9, %cond.true8 ], [ %add11, %cond.false10 ]
  store i32 %cond13, i32* %right, align 4
  %24 = load i32* %y, align 4
  %25 = load i32* %hstep, align 4
  %cmp14 = icmp ult i32 %24, %25
  br i1 %cmp14, label %cond.true16, label %cond.false17

cond.true16:                                      ; preds = %cond.end12
  br label %cond.end19

cond.false17:                                     ; preds = %cond.end12
  %26 = load i32* %y, align 4
  %27 = load i32* %hstep, align 4
  %sub18 = sub i32 %26, %27
  br label %cond.end19

cond.end19:                                       ; preds = %cond.false17, %cond.true16
  %cond20 = phi i32 [ 0, %cond.true16 ], [ %sub18, %cond.false17 ]
  store i32 %cond20, i32* %top, align 4
  %28 = load i32* %y, align 4
  %29 = load i32* %hstep, align 4
  %add21 = add i32 %28, %29
  %30 = load i32* %height, align 4
  %cmp22 = icmp uge i32 %add21, %30
  br i1 %cmp22, label %cond.true24, label %cond.false26

cond.true24:                                      ; preds = %cond.end19
  %31 = load i32* %height, align 4
  %sub25 = sub i32 %31, 1
  br label %cond.end28

cond.false26:                                     ; preds = %cond.end19
  %32 = load i32* %y, align 4
  %33 = load i32* %hstep, align 4
  %add27 = add i32 %32, %33
  br label %cond.end28

cond.end28:                                       ; preds = %cond.false26, %cond.true24
  %cond29 = phi i32 [ %sub25, %cond.true24 ], [ %add27, %cond.false26 ]
  store i32 %cond29, i32* %bottom, align 4
  store float 0.000000e+00, float* %sumFX, align 4
  %34 = load i32* %left, align 4
  store i32 %34, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc48, %cond.end28
  %35 = load i32* %i, align 4
  %36 = load i32* %right, align 4
  %cmp30 = icmp ule i32 %35, %36
  br i1 %cmp30, label %for.body, label %for.end50

for.body:                                         ; preds = %for.cond
  %37 = load i32* %top, align 4
  store i32 %37, i32* %j, align 4
  br label %for.cond32

for.cond32:                                       ; preds = %for.inc, %for.body
  %38 = load i32* %j, align 4
  %39 = load i32* %bottom, align 4
  %cmp33 = icmp ule i32 %38, %39
  br i1 %cmp33, label %for.body35, label %for.end

for.body35:                                       ; preds = %for.cond32
  %40 = load i32* %j, align 4
  %41 = load i32* %y, align 4
  %42 = load i32* %hstep, align 4
  %sub36 = sub i32 %41, %42
  %sub37 = sub i32 %40, %sub36
  %43 = load i32* %maskWidth, align 4
  %mul = mul i32 %sub37, %43
  %44 = load i32* %i, align 4
  %45 = load i32* %x, align 4
  %46 = load i32* %vstep, align 4
  %sub38 = sub i32 %45, %46
  %sub39 = sub i32 %44, %sub38
  %add40 = add i32 %mul, %sub39
  store i32 %add40, i32* %maskIndex, align 4
  %47 = load i32* %j, align 4
  %48 = load i32* %width, align 4
  %mul41 = mul i32 %47, %48
  %49 = load i32* %i, align 4
  %add42 = add i32 %mul41, %49
  store i32 %add42, i32* %index, align 4
  %50 = load i32* %index, align 4
  %idxprom = zext i32 %50 to i64
  %51 = load i32 addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %51, i64 %idxprom
  %52 = load i32 addrspace(1)* %arrayidx, align 4
  %conv43 = uitofp i32 %52 to float
  %53 = load i32* %maskIndex, align 4
  %idxprom44 = zext i32 %53 to i64
  %54 = load float addrspace(1)** %mask.addr, align 8
  %arrayidx45 = getelementptr inbounds float addrspace(1)* %54, i64 %idxprom44
  %55 = load float addrspace(1)* %arrayidx45, align 4
  %mul46 = fmul float %conv43, %55
  %56 = load float* %sumFX, align 4
  %add47 = fadd float %56, %mul46
  store float %add47, float* %sumFX, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body35
  %57 = load i32* %j, align 4
  %inc = add i32 %57, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond32

for.end:                                          ; preds = %for.cond32
  br label %for.inc48

for.inc48:                                        ; preds = %for.end
  %58 = load i32* %i, align 4
  %inc49 = add i32 %58, 1
  store i32 %inc49, i32* %i, align 4
  br label %for.cond

for.end50:                                        ; preds = %for.cond
  %59 = load float* %sumFX, align 4
  %add51 = fadd float %59, 5.000000e-01
  store float %add51, float* %sumFX, align 4
  %60 = load float* %sumFX, align 4
  %conv52 = fptoui float %60 to i32
  %61 = load i32* %tid, align 4
  %idxprom53 = zext i32 %61 to i64
  %62 = load i32 addrspace(1)** %output.addr, align 8
  %arrayidx54 = getelementptr inbounds i32 addrspace(1)* %62, i64 %idxprom53
  store i32 %conv52, i32 addrspace(1)* %arrayidx54, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, float addrspace(1)*, <2 x i32>, <2 x i32>)* @__OpenCL_simpleConvolution_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"float*", metadata !"uint2", metadata !"uint2"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"const", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"float*", metadata !"uint2", metadata !"uint2"}
!6 = metadata !{i32 1, i32 2}

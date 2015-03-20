; ModuleID = 'SimpleGL_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_sineWave_kernel(<4 x float> addrspace(1)* %pos, i32 %width, i32 %height, float %time) #0 {
entry:
  %pos.addr = alloca <4 x float> addrspace(1)*, align 8
  %width.addr = alloca i32, align 4
  %height.addr = alloca i32, align 4
  %time.addr = alloca float, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %u = alloca float, align 4
  %v = alloca float, align 4
  %freq = alloca float, align 4
  %w = alloca float, align 4
  %.compoundliteral = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)** %pos.addr, align 8
  store i32 %width, i32* %width.addr, align 4
  store i32 %height, i32* %height.addr, align 4
  store float %time, float* %time.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %y, align 4
  %0 = load i32* %x, align 4
  %conv3 = uitofp i32 %0 to float
  %1 = load i32* %width.addr, align 4
  %conv4 = uitofp i32 %1 to float
  %div = fdiv float %conv3, %conv4, !fpmath !7
  store float %div, float* %u, align 4
  %2 = load i32* %y, align 4
  %conv5 = uitofp i32 %2 to float
  %3 = load i32* %height.addr, align 4
  %conv6 = uitofp i32 %3 to float
  %div7 = fdiv float %conv5, %conv6, !fpmath !7
  store float %div7, float* %v, align 4
  %4 = load float* %u, align 4
  %5 = call float @llvm.fmuladd.f32(float %4, float 2.000000e+00, float -1.000000e+00)
  store float %5, float* %u, align 4
  %6 = load float* %v, align 4
  %7 = call float @llvm.fmuladd.f32(float %6, float 2.000000e+00, float -1.000000e+00)
  store float %7, float* %v, align 4
  store float 4.000000e+00, float* %freq, align 4
  %8 = load float* %u, align 4
  %9 = load float* %freq, align 4
  %10 = load float* %time.addr, align 4
  %11 = call float @llvm.fmuladd.f32(float %8, float %9, float %10)
  %call8 = call cc75 float @_Z3sinf(float %11) #1
  %12 = load float* %v, align 4
  %13 = load float* %freq, align 4
  %14 = load float* %time.addr, align 4
  %15 = call float @llvm.fmuladd.f32(float %12, float %13, float %14)
  %call9 = call cc75 float @_Z3cosf(float %15) #1
  %mul = fmul float %call8, %call9
  %mul10 = fmul float %mul, 5.000000e-01
  store float %mul10, float* %w, align 4
  %16 = load float* %u, align 4
  %vecinit = insertelement <4 x float> undef, float %16, i32 0
  %17 = load float* %w, align 4
  %vecinit11 = insertelement <4 x float> %vecinit, float %17, i32 1
  %18 = load float* %v, align 4
  %vecinit12 = insertelement <4 x float> %vecinit11, float %18, i32 2
  %vecinit13 = insertelement <4 x float> %vecinit12, float 1.000000e+00, i32 3
  store <4 x float> %vecinit13, <4 x float>* %.compoundliteral
  %19 = load <4 x float>* %.compoundliteral
  %20 = load i32* %y, align 4
  %21 = load i32* %width.addr, align 4
  %mul14 = mul i32 %20, %21
  %22 = load i32* %x, align 4
  %add = add i32 %mul14, %22
  %idxprom = zext i32 %add to i64
  %23 = load <4 x float> addrspace(1)** %pos.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %23, i64 %idxprom
  store <4 x float> %19, <4 x float> addrspace(1)* %arrayidx, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3sinf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3cosf(float) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (<4 x float> addrspace(1)*, i32, i32, float)* @__OpenCL_sineWave_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"uint", metadata !"uint", metadata !"float"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"uint", metadata !"uint", metadata !"float"}
!6 = metadata !{i32 1, i32 2}
!7 = metadata !{float 2.500000e+00}

; ModuleID = 'SimpleGL_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_sineWave_kernel(<4 x float> addrspace(1)* %pos, i32 %width, i32 %height, float %time) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %conv3 = uitofp i32 %conv to float
  %conv4 = uitofp i32 %width to float
  %div = fdiv float %conv3, %conv4, !fpmath !7
  %conv5 = uitofp i32 %conv2 to float
  %conv6 = uitofp i32 %height to float
  %div7 = fdiv float %conv5, %conv6, !fpmath !7
  %0 = call float @llvm.fmuladd.f32(float %div, float 2.000000e+00, float -1.000000e+00)
  %1 = call float @llvm.fmuladd.f32(float %div7, float 2.000000e+00, float -1.000000e+00)
  %2 = call float @llvm.fmuladd.f32(float %0, float 4.000000e+00, float %time)
  %call8 = call cc75 float @_Z3sinf(float %2) #1
  %3 = call float @llvm.fmuladd.f32(float %1, float 4.000000e+00, float %time)
  %call9 = call cc75 float @_Z3cosf(float %3) #1
  %mul = fmul float %call8, %call9
  %mul10 = fmul float %mul, 5.000000e-01
  %vecinit = insertelement <4 x float> undef, float %0, i32 0
  %vecinit11 = insertelement <4 x float> %vecinit, float %mul10, i32 1
  %vecinit12 = insertelement <4 x float> %vecinit11, float %1, i32 2
  %vecinit13 = insertelement <4 x float> %vecinit12, float 1.000000e+00, i32 3
  %mul14 = mul i32 %conv2, %width
  %add = add i32 %mul14, %conv
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %pos, i64 %idxprom
  store <4 x float> %vecinit13, <4 x float> addrspace(1)* %arrayidx, align 16
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

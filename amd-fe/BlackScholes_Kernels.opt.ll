; ModuleID = 'BlackScholes_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc75 void @phi(<4 x float> %X, <4 x float>* %phi) #0 {
entry:
  %call = call cc75 <4 x float> @_Z4fabsDv4_f(<4 x float> %X) #1
  %0 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %call, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %div = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %0, !fpmath !10
  %sub = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %X
  %mul = fmul <4 x float> %sub, %X
  %div1 = fdiv <4 x float> %mul, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !10
  %call2 = call cc75 <4 x float> @_Z3expDv4_f(<4 x float> %div1) #1
  %mul3 = fmul <4 x float> <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>, %call2
  %mul4 = fmul <4 x float> %mul3, %div
  %1 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>)
  %2 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div, <4 x float> %1, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>)
  %3 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div, <4 x float> %2, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>)
  %4 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div, <4 x float> %3, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>)
  %neg = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul4
  %5 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg, <4 x float> %4, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %cmp = fcmp olt <4 x float> %X, zeroinitializer
  %sext = sext <4 x i1> %cmp to <4 x i32>
  %sub10 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %5
  %6 = icmp slt <4 x i32> %sext, zeroinitializer
  %7 = select <4 x i1> %6, <4 x float> %sub10, <4 x float> %5
  store <4 x float> %7, <4 x float>* %phi, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z4fabsDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_blackScholes_kernel(<4 x float> addrspace(1)* %randArray, i32 %width, <4 x float> addrspace(1)* %call, <4 x float> addrspace(1)* %put) #0 {
entry:
  %phiD1 = alloca <4 x float>, align 16
  %phiD2 = alloca <4 x float>, align 16
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv = sext i32 %width to i64
  %mul = mul i64 %call2, %conv
  %add = add i64 %mul, %call1
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i64 %add
  %0 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %sub = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %0
  %mul4 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %sub
  %1 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %0, <4 x float> %mul4)
  %sub6 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %0
  %mul7 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %sub6
  %2 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %0, <4 x float> %mul7)
  %sub9 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %0
  %mul10 = fmul <4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, %sub9
  %3 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %0, <4 x float> %mul10)
  %sub12 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %0
  %mul13 = fmul <4 x float> <float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000>, %sub12
  %4 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %0, <4 x float> %mul13)
  %sub15 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %0
  %mul16 = fmul <4 x float> <float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000>, %sub15
  %5 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %0, <4 x float> %mul16)
  %call17 = call cc75 <4 x float> @_Z4sqrtDv4_f(<4 x float> %3) #1
  %mul18 = fmul <4 x float> %5, %call17
  %div = fdiv <4 x float> %1, %2, !fpmath !10
  %call19 = call cc75 <4 x float> @_Z3logDv4_f(<4 x float> %div) #1
  %mul20 = fmul <4 x float> %5, %5
  %div21 = fdiv <4 x float> %mul20, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !10
  %add22 = fadd <4 x float> %4, %div21
  %6 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %add22, <4 x float> %3, <4 x float> %call19)
  %div24 = fdiv <4 x float> %6, %mul18, !fpmath !10
  %sub25 = fsub <4 x float> %div24, %mul18
  %sub26 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %4
  %mul27 = fmul <4 x float> %sub26, %3
  %call28 = call cc75 <4 x float> @_Z3expDv4_f(<4 x float> %mul27) #1
  %mul29 = fmul <4 x float> %2, %call28
  call cc75 void @phi(<4 x float> %div24, <4 x float>* %phiD1)
  call cc75 void @phi(<4 x float> %sub25, <4 x float>* %phiD2)
  %7 = load <4 x float>* %phiD1, align 16
  %8 = load <4 x float>* %phiD2, align 16
  %mul31 = fmul <4 x float> %mul29, %8
  %neg = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul31
  %9 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %1, <4 x float> %7, <4 x float> %neg)
  %conv32 = sext i32 %width to i64
  %mul33 = mul i64 %call2, %conv32
  %add34 = add i64 %mul33, %call1
  %arrayidx35 = getelementptr inbounds <4 x float> addrspace(1)* %call, i64 %add34
  store <4 x float> %9, <4 x float> addrspace(1)* %arrayidx35, align 16
  %sub36 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %div24
  call cc75 void @phi(<4 x float> %sub36, <4 x float>* %phiD1)
  %sub37 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %sub25
  call cc75 void @phi(<4 x float> %sub37, <4 x float>* %phiD2)
  %10 = load <4 x float>* %phiD2, align 16
  %11 = load <4 x float>* %phiD1, align 16
  %mul39 = fmul <4 x float> %1, %11
  %neg40 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul39
  %12 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %mul29, <4 x float> %10, <4 x float> %neg40)
  %conv41 = sext i32 %width to i64
  %mul42 = mul i64 %call2, %conv41
  %add43 = add i64 %mul42, %call1
  %arrayidx44 = getelementptr inbounds <4 x float> addrspace(1)* %put, i64 %add43
  store <4 x float> %12, <4 x float> addrspace(1)* %arrayidx44, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z4sqrtDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z3logDv4_f(<4 x float>) #1

; Function Attrs: nounwind
define cc75 void @phi_scalar(float %X, float* %phi) #0 {
entry:
  %call = call cc75 float @_Z4fabsf(float %X) #1
  %0 = call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %call, float 1.000000e+00)
  %div = fdiv float 1.000000e+00, %0, !fpmath !10
  %sub = fsub float -0.000000e+00, %X
  %mul = fmul float %sub, %X
  %div1 = fdiv float %mul, 2.000000e+00, !fpmath !10
  %call2 = call cc75 float @_Z3expf(float %div1) #1
  %mul3 = fmul float 0x3FD9884540000000, %call2
  %mul4 = fmul float %mul3, %div
  %1 = call float @llvm.fmuladd.f32(float %div, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000)
  %2 = call float @llvm.fmuladd.f32(float %div, float %1, float 0x3FFC80EF00000000)
  %3 = call float @llvm.fmuladd.f32(float %div, float %2, float 0xBFD6D1F0E0000000)
  %4 = call float @llvm.fmuladd.f32(float %div, float %3, float 0x3FD470BF40000000)
  %neg = fsub float -0.000000e+00, %mul4
  %5 = call float @llvm.fmuladd.f32(float %neg, float %4, float 1.000000e+00)
  %cmp = fcmp olt float %X, 0.000000e+00
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %sub10 = fsub float 1.000000e+00, %5
  br label %cond.end

cond.false:                                       ; preds = %entry
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi float [ %sub10, %cond.true ], [ %5, %cond.false ]
  store float %cond, float* %phi, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 float @_Z4fabsf(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3expf(float) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_blackScholes_scalar_kernel(float addrspace(1)* %randArray, i32 %width, float addrspace(1)* %call, float addrspace(1)* %put) #0 {
entry:
  %phiD1 = alloca float, align 4
  %phiD2 = alloca float, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv = sext i32 %width to i64
  %mul = mul i64 %call2, %conv
  %add = add i64 %mul, %call1
  %arrayidx = getelementptr inbounds float addrspace(1)* %randArray, i64 %add
  %0 = load float addrspace(1)* %arrayidx, align 4
  %sub = fsub float 1.000000e+00, %0
  %mul4 = fmul float 1.000000e+02, %sub
  %1 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %0, float %mul4)
  %sub6 = fsub float 1.000000e+00, %0
  %mul7 = fmul float 1.000000e+02, %sub6
  %2 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %0, float %mul7)
  %sub9 = fsub float 1.000000e+00, %0
  %mul10 = fmul float 1.000000e+01, %sub9
  %3 = call float @llvm.fmuladd.f32(float 1.000000e+00, float %0, float %mul10)
  %sub12 = fsub float 1.000000e+00, %0
  %mul13 = fmul float 0x3FA99999A0000000, %sub12
  %4 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %0, float %mul13)
  %sub15 = fsub float 1.000000e+00, %0
  %mul16 = fmul float 0x3FB99999A0000000, %sub15
  %5 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %0, float %mul16)
  %call17 = call cc75 float @_Z4sqrtf(float %3) #1
  %mul18 = fmul float %5, %call17
  %div = fdiv float %1, %2, !fpmath !10
  %call19 = call cc75 float @_Z3logf(float %div) #1
  %mul20 = fmul float %5, %5
  %div21 = fdiv float %mul20, 2.000000e+00, !fpmath !10
  %add22 = fadd float %4, %div21
  %6 = call float @llvm.fmuladd.f32(float %add22, float %3, float %call19)
  %div24 = fdiv float %6, %mul18, !fpmath !10
  %sub25 = fsub float %div24, %mul18
  %sub26 = fsub float -0.000000e+00, %4
  %mul27 = fmul float %sub26, %3
  %call28 = call cc75 float @_Z3expf(float %mul27) #1
  %mul29 = fmul float %2, %call28
  call cc75 void @phi_scalar(float %div24, float* %phiD1)
  call cc75 void @phi_scalar(float %sub25, float* %phiD2)
  %7 = load float* %phiD1, align 4
  %8 = load float* %phiD2, align 4
  %mul31 = fmul float %mul29, %8
  %neg = fsub float -0.000000e+00, %mul31
  %9 = call float @llvm.fmuladd.f32(float %1, float %7, float %neg)
  %conv32 = sext i32 %width to i64
  %mul33 = mul i64 %call2, %conv32
  %add34 = add i64 %mul33, %call1
  %arrayidx35 = getelementptr inbounds float addrspace(1)* %call, i64 %add34
  store float %9, float addrspace(1)* %arrayidx35, align 4
  %sub36 = fsub float -0.000000e+00, %div24
  call cc75 void @phi_scalar(float %sub36, float* %phiD1)
  %sub37 = fsub float -0.000000e+00, %sub25
  call cc75 void @phi_scalar(float %sub37, float* %phiD2)
  %10 = load float* %phiD2, align 4
  %11 = load float* %phiD1, align 4
  %mul39 = fmul float %1, %11
  %neg40 = fsub float -0.000000e+00, %mul39
  %12 = call float @llvm.fmuladd.f32(float %mul29, float %10, float %neg40)
  %conv41 = sext i32 %width to i64
  %mul42 = mul i64 %call2, %conv41
  %add43 = add i64 %mul42, %call1
  %arrayidx44 = getelementptr inbounds float addrspace(1)* %put, i64 %add43
  store float %12, float addrspace(1)* %arrayidx44, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 float @_Z4sqrtf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3logf(float) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!9}
!opencl.spir.version = !{!9}

!0 = metadata !{void (<4 x float> addrspace(1)*, i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @__OpenCL_blackScholes_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"int", metadata !"float4*", metadata !"float4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"const", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"int", metadata !"float4*", metadata !"float4*"}
!6 = metadata !{void (float addrspace(1)*, i32, float addrspace(1)*, float addrspace(1)*)* @__OpenCL_blackScholes_scalar_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"int", metadata !"float*", metadata !"float*"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"int", metadata !"float*", metadata !"float*"}
!9 = metadata !{i32 1, i32 2}
!10 = metadata !{float 2.500000e+00}

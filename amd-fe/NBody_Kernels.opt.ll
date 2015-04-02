; ModuleID = 'NBody_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_nbody_sim_kernel(<4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)* %vel, i32 %numBodies, float %deltaTime, float %epsSqr, <4 x float> addrspace(1)* %newPosition, <4 x float> addrspace(1)* %newVelocity) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %idxprom = zext i32 %conv to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %pos, i64 %idxprom
  %0 = load <4 x float> addrspace(1)* %arrayidx, align 16
  br label %for.cond

for.cond:                                         ; preds = %for.end, %entry
  %acc.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc.1, %for.end ]
  %i.0 = phi i32 [ 0, %entry ], [ %i.1, %for.end ]
  %add = add nsw i32 %i.0, 8
  %cmp = icmp slt i32 %add, %numBodies
  br i1 %cmp, label %for.body, label %for.end16

for.body:                                         ; preds = %for.cond
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc, %for.body
  %acc.1 = phi <4 x float> [ %acc.0, %for.body ], [ %19, %for.inc ]
  %i.1 = phi i32 [ %i.0, %for.body ], [ %inc15, %for.inc ]
  %j.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %cmp3 = icmp slt i32 %j.0, 8
  br i1 %cmp3, label %for.body5, label %for.end

for.body5:                                        ; preds = %for.cond2
  %idxprom6 = sext i32 %i.1 to i64
  %arrayidx7 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i64 %idxprom6
  %1 = load <4 x float> addrspace(1)* %arrayidx7, align 16
  %2 = shufflevector <4 x float> %1, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %3 = shufflevector <4 x float> %0, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %sub = fsub <3 x float> %2, %3
  %4 = shufflevector <3 x float> %sub, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %5 = shufflevector <4 x float> undef, <4 x float> %4, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %6 = extractelement <4 x float> %5, i32 0
  %7 = extractelement <4 x float> %5, i32 0
  %8 = extractelement <4 x float> %5, i32 1
  %9 = extractelement <4 x float> %5, i32 1
  %mul8 = fmul float %8, %9
  %10 = call float @llvm.fmuladd.f32(float %6, float %7, float %mul8)
  %11 = extractelement <4 x float> %5, i32 2
  %12 = extractelement <4 x float> %5, i32 2
  %13 = call float @llvm.fmuladd.f32(float %11, float %12, float %10)
  %add9 = fadd float %13, %epsSqr
  %call10 = call cc75 float @_Z4sqrtf(float %add9) #1
  %div = fdiv float 1.000000e+00, %call10, !fpmath !7
  %mul = fmul float %div, %div
  %mul11 = fmul float %mul, %div
  %14 = extractelement <4 x float> %1, i32 3
  %mul12 = fmul float %14, %mul11
  %15 = insertelement <3 x float> undef, float %mul12, i32 0
  %splat = shufflevector <3 x float> %15, <3 x float> %15, <3 x i32> zeroinitializer
  %16 = shufflevector <4 x float> %5, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul13 = fmul <3 x float> %splat, %16
  %17 = shufflevector <4 x float> %acc.1, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add14 = fadd <3 x float> %17, %mul13
  %18 = shufflevector <3 x float> %add14, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %19 = shufflevector <4 x float> %acc.1, <4 x float> %18, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  br label %for.inc

for.inc:                                          ; preds = %for.body5
  %inc = add nsw i32 %j.0, 1
  %inc15 = add nsw i32 %i.1, 1
  br label %for.cond2

for.end:                                          ; preds = %for.cond2
  br label %for.cond

for.end16:                                        ; preds = %for.cond
  br label %for.cond17

for.cond17:                                       ; preds = %for.inc42, %for.end16
  %acc.2 = phi <4 x float> [ %acc.0, %for.end16 ], [ %38, %for.inc42 ]
  %i.2 = phi i32 [ %i.0, %for.end16 ], [ %inc43, %for.inc42 ]
  %cmp18 = icmp slt i32 %i.2, %numBodies
  br i1 %cmp18, label %for.body20, label %for.end44

for.body20:                                       ; preds = %for.cond17
  %idxprom22 = sext i32 %i.2 to i64
  %arrayidx23 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i64 %idxprom22
  %20 = load <4 x float> addrspace(1)* %arrayidx23, align 16
  %21 = shufflevector <4 x float> %20, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %22 = shufflevector <4 x float> %0, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %sub25 = fsub <3 x float> %21, %22
  %23 = shufflevector <3 x float> %sub25, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %24 = shufflevector <4 x float> undef, <4 x float> %23, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %25 = extractelement <4 x float> %24, i32 0
  %26 = extractelement <4 x float> %24, i32 0
  %27 = extractelement <4 x float> %24, i32 1
  %28 = extractelement <4 x float> %24, i32 1
  %mul28 = fmul float %27, %28
  %29 = call float @llvm.fmuladd.f32(float %25, float %26, float %mul28)
  %30 = extractelement <4 x float> %24, i32 2
  %31 = extractelement <4 x float> %24, i32 2
  %32 = call float @llvm.fmuladd.f32(float %30, float %31, float %29)
  %add31 = fadd float %32, %epsSqr
  %call32 = call cc75 float @_Z4sqrtf(float %add31) #1
  %div33 = fdiv float 1.000000e+00, %call32, !fpmath !7
  %mul35 = fmul float %div33, %div33
  %mul36 = fmul float %mul35, %div33
  %33 = extractelement <4 x float> %20, i32 3
  %mul38 = fmul float %33, %mul36
  %34 = insertelement <3 x float> undef, float %mul38, i32 0
  %splat39 = shufflevector <3 x float> %34, <3 x float> %34, <3 x i32> zeroinitializer
  %35 = shufflevector <4 x float> %24, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul40 = fmul <3 x float> %splat39, %35
  %36 = shufflevector <4 x float> %acc.2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add41 = fadd <3 x float> %36, %mul40
  %37 = shufflevector <3 x float> %add41, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %38 = shufflevector <4 x float> %acc.2, <4 x float> %37, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  br label %for.inc42

for.inc42:                                        ; preds = %for.body20
  %inc43 = add nsw i32 %i.2, 1
  br label %for.cond17

for.end44:                                        ; preds = %for.cond17
  %idxprom45 = zext i32 %conv to i64
  %arrayidx46 = getelementptr inbounds <4 x float> addrspace(1)* %vel, i64 %idxprom45
  %39 = load <4 x float> addrspace(1)* %arrayidx46, align 16
  %40 = shufflevector <4 x float> %0, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %41 = shufflevector <4 x float> %39, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %42 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %splat47 = shufflevector <3 x float> %42, <3 x float> %42, <3 x i32> zeroinitializer
  %43 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %41, <3 x float> %splat47, <3 x float> %40)
  %44 = shufflevector <4 x float> %acc.2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul49 = fmul <3 x float> %44, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %45 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %splat50 = shufflevector <3 x float> %45, <3 x float> %45, <3 x i32> zeroinitializer
  %mul51 = fmul <3 x float> %mul49, %splat50
  %46 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %splat52 = shufflevector <3 x float> %46, <3 x float> %46, <3 x i32> zeroinitializer
  %47 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %mul51, <3 x float> %splat52, <3 x float> %43)
  %48 = shufflevector <3 x float> %47, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %49 = shufflevector <4 x float> undef, <4 x float> %48, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %50 = extractelement <4 x float> %0, i32 3
  %51 = insertelement <4 x float> %49, float %50, i32 3
  %52 = shufflevector <4 x float> %39, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %53 = shufflevector <4 x float> %acc.2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %54 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %splat54 = shufflevector <3 x float> %54, <3 x float> %54, <3 x i32> zeroinitializer
  %55 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %53, <3 x float> %splat54, <3 x float> %52)
  %56 = shufflevector <3 x float> %55, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %57 = shufflevector <4 x float> undef, <4 x float> %56, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %58 = extractelement <4 x float> %39, i32 3
  %59 = insertelement <4 x float> %57, float %58, i32 3
  %idxprom56 = zext i32 %conv to i64
  %arrayidx57 = getelementptr inbounds <4 x float> addrspace(1)* %newPosition, i64 %idxprom56
  store <4 x float> %51, <4 x float> addrspace(1)* %arrayidx57, align 16
  %idxprom58 = zext i32 %conv to i64
  %arrayidx59 = getelementptr inbounds <4 x float> addrspace(1)* %newVelocity, i64 %idxprom58
  store <4 x float> %59, <4 x float> addrspace(1)* %arrayidx59, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z4sqrtf(float) #1

; Function Attrs: nounwind readnone
declare <3 x float> @llvm.fmuladd.v3f32(<3 x float>, <3 x float>, <3 x float>) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, float, float, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @__OpenCL_nbody_sim_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0, i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"float4*", metadata !"int", metadata !"float", metadata !"float", metadata !"float4*", metadata !"float4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"float4*", metadata !"int", metadata !"float", metadata !"float", metadata !"float4*", metadata !"float4*"}
!6 = metadata !{i32 1, i32 2}
!7 = metadata !{float 2.500000e+00}

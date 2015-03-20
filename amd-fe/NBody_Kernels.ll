; ModuleID = 'NBody_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_nbody_sim_kernel(<4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)* %vel, i32 %numBodies, float %deltaTime, float %epsSqr, <4 x float> addrspace(1)* %newPosition, <4 x float> addrspace(1)* %newVelocity) #0 {
entry:
  %pos.addr = alloca <4 x float> addrspace(1)*, align 8
  %vel.addr = alloca <4 x float> addrspace(1)*, align 8
  %numBodies.addr = alloca i32, align 4
  %deltaTime.addr = alloca float, align 4
  %epsSqr.addr = alloca float, align 4
  %newPosition.addr = alloca <4 x float> addrspace(1)*, align 8
  %newVelocity.addr = alloca <4 x float> addrspace(1)*, align 8
  %gid = alloca i32, align 4
  %myPos = alloca <4 x float>, align 16
  %acc = alloca <4 x float>, align 16
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %p = alloca <4 x float>, align 16
  %r = alloca <4 x float>, align 16
  %distSqr = alloca float, align 4
  %invDist = alloca float, align 4
  %invDistCube = alloca float, align 4
  %s = alloca float, align 4
  %p21 = alloca <4 x float>, align 16
  %r24 = alloca <4 x float>, align 16
  %distSqr26 = alloca float, align 4
  %invDist30 = alloca float, align 4
  %invDistCube34 = alloca float, align 4
  %s37 = alloca float, align 4
  %oldVel = alloca <4 x float>, align 16
  %newPos = alloca <4 x float>, align 16
  %newVel = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)** %pos.addr, align 8
  store <4 x float> addrspace(1)* %vel, <4 x float> addrspace(1)** %vel.addr, align 8
  store i32 %numBodies, i32* %numBodies.addr, align 4
  store float %deltaTime, float* %deltaTime.addr, align 4
  store float %epsSqr, float* %epsSqr.addr, align 4
  store <4 x float> addrspace(1)* %newPosition, <4 x float> addrspace(1)** %newPosition.addr, align 8
  store <4 x float> addrspace(1)* %newVelocity, <4 x float> addrspace(1)** %newVelocity.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %gid, align 4
  %0 = load i32* %gid, align 4
  %idxprom = zext i32 %0 to i64
  %1 = load <4 x float> addrspace(1)** %pos.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %1, i64 %idxprom
  %2 = load <4 x float> addrspace(1)* %arrayidx, align 16
  store <4 x float> %2, <4 x float>* %myPos, align 16
  store <4 x float> zeroinitializer, <4 x float>* %acc, align 16
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.end, %entry
  %3 = load i32* %i, align 4
  %add = add nsw i32 %3, 8
  %4 = load i32* %numBodies.addr, align 4
  %cmp = icmp slt i32 %add, %4
  br i1 %cmp, label %for.body, label %for.end16

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc, %for.body
  %5 = load i32* %j, align 4
  %cmp3 = icmp slt i32 %5, 8
  br i1 %cmp3, label %for.body5, label %for.end

for.body5:                                        ; preds = %for.cond2
  %6 = load i32* %i, align 4
  %idxprom6 = sext i32 %6 to i64
  %7 = load <4 x float> addrspace(1)** %pos.addr, align 8
  %arrayidx7 = getelementptr inbounds <4 x float> addrspace(1)* %7, i64 %idxprom6
  %8 = load <4 x float> addrspace(1)* %arrayidx7, align 16
  store <4 x float> %8, <4 x float>* %p, align 16
  %9 = load <4 x float>* %p, align 16
  %10 = shufflevector <4 x float> %9, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %11 = load <4 x float>* %myPos, align 16
  %12 = shufflevector <4 x float> %11, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %sub = fsub <3 x float> %10, %12
  %13 = load <4 x float>* %r, align 16
  %14 = shufflevector <3 x float> %sub, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %15 = shufflevector <4 x float> %13, <4 x float> %14, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %15, <4 x float>* %r, align 16
  %16 = load <4 x float>* %r, align 16
  %17 = extractelement <4 x float> %16, i32 0
  %18 = load <4 x float>* %r, align 16
  %19 = extractelement <4 x float> %18, i32 0
  %20 = load <4 x float>* %r, align 16
  %21 = extractelement <4 x float> %20, i32 1
  %22 = load <4 x float>* %r, align 16
  %23 = extractelement <4 x float> %22, i32 1
  %mul8 = fmul float %21, %23
  %24 = call float @llvm.fmuladd.f32(float %17, float %19, float %mul8)
  %25 = load <4 x float>* %r, align 16
  %26 = extractelement <4 x float> %25, i32 2
  %27 = load <4 x float>* %r, align 16
  %28 = extractelement <4 x float> %27, i32 2
  %29 = call float @llvm.fmuladd.f32(float %26, float %28, float %24)
  store float %29, float* %distSqr, align 4
  %30 = load float* %distSqr, align 4
  %31 = load float* %epsSqr.addr, align 4
  %add9 = fadd float %30, %31
  %call10 = call cc75 float @_Z4sqrtf(float %add9) #1
  %div = fdiv float 1.000000e+00, %call10, !fpmath !7
  store float %div, float* %invDist, align 4
  %32 = load float* %invDist, align 4
  %33 = load float* %invDist, align 4
  %mul = fmul float %32, %33
  %34 = load float* %invDist, align 4
  %mul11 = fmul float %mul, %34
  store float %mul11, float* %invDistCube, align 4
  %35 = load <4 x float>* %p, align 16
  %36 = extractelement <4 x float> %35, i32 3
  %37 = load float* %invDistCube, align 4
  %mul12 = fmul float %36, %37
  store float %mul12, float* %s, align 4
  %38 = load float* %s, align 4
  %39 = insertelement <3 x float> undef, float %38, i32 0
  %splat = shufflevector <3 x float> %39, <3 x float> %39, <3 x i32> zeroinitializer
  %40 = load <4 x float>* %r, align 16
  %41 = shufflevector <4 x float> %40, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul13 = fmul <3 x float> %splat, %41
  %42 = load <4 x float>* %acc, align 16
  %43 = shufflevector <4 x float> %42, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add14 = fadd <3 x float> %43, %mul13
  %44 = load <4 x float>* %acc, align 16
  %45 = shufflevector <3 x float> %add14, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %46 = shufflevector <4 x float> %44, <4 x float> %45, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %46, <4 x float>* %acc, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body5
  %47 = load i32* %j, align 4
  %inc = add nsw i32 %47, 1
  store i32 %inc, i32* %j, align 4
  %48 = load i32* %i, align 4
  %inc15 = add nsw i32 %48, 1
  store i32 %inc15, i32* %i, align 4
  br label %for.cond2

for.end:                                          ; preds = %for.cond2
  br label %for.cond

for.end16:                                        ; preds = %for.cond
  br label %for.cond17

for.cond17:                                       ; preds = %for.inc42, %for.end16
  %49 = load i32* %i, align 4
  %50 = load i32* %numBodies.addr, align 4
  %cmp18 = icmp slt i32 %49, %50
  br i1 %cmp18, label %for.body20, label %for.end44

for.body20:                                       ; preds = %for.cond17
  %51 = load i32* %i, align 4
  %idxprom22 = sext i32 %51 to i64
  %52 = load <4 x float> addrspace(1)** %pos.addr, align 8
  %arrayidx23 = getelementptr inbounds <4 x float> addrspace(1)* %52, i64 %idxprom22
  %53 = load <4 x float> addrspace(1)* %arrayidx23, align 16
  store <4 x float> %53, <4 x float>* %p21, align 16
  %54 = load <4 x float>* %p21, align 16
  %55 = shufflevector <4 x float> %54, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %56 = load <4 x float>* %myPos, align 16
  %57 = shufflevector <4 x float> %56, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %sub25 = fsub <3 x float> %55, %57
  %58 = load <4 x float>* %r24, align 16
  %59 = shufflevector <3 x float> %sub25, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %60 = shufflevector <4 x float> %58, <4 x float> %59, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %60, <4 x float>* %r24, align 16
  %61 = load <4 x float>* %r24, align 16
  %62 = extractelement <4 x float> %61, i32 0
  %63 = load <4 x float>* %r24, align 16
  %64 = extractelement <4 x float> %63, i32 0
  %65 = load <4 x float>* %r24, align 16
  %66 = extractelement <4 x float> %65, i32 1
  %67 = load <4 x float>* %r24, align 16
  %68 = extractelement <4 x float> %67, i32 1
  %mul28 = fmul float %66, %68
  %69 = call float @llvm.fmuladd.f32(float %62, float %64, float %mul28)
  %70 = load <4 x float>* %r24, align 16
  %71 = extractelement <4 x float> %70, i32 2
  %72 = load <4 x float>* %r24, align 16
  %73 = extractelement <4 x float> %72, i32 2
  %74 = call float @llvm.fmuladd.f32(float %71, float %73, float %69)
  store float %74, float* %distSqr26, align 4
  %75 = load float* %distSqr26, align 4
  %76 = load float* %epsSqr.addr, align 4
  %add31 = fadd float %75, %76
  %call32 = call cc75 float @_Z4sqrtf(float %add31) #1
  %div33 = fdiv float 1.000000e+00, %call32, !fpmath !7
  store float %div33, float* %invDist30, align 4
  %77 = load float* %invDist30, align 4
  %78 = load float* %invDist30, align 4
  %mul35 = fmul float %77, %78
  %79 = load float* %invDist30, align 4
  %mul36 = fmul float %mul35, %79
  store float %mul36, float* %invDistCube34, align 4
  %80 = load <4 x float>* %p21, align 16
  %81 = extractelement <4 x float> %80, i32 3
  %82 = load float* %invDistCube34, align 4
  %mul38 = fmul float %81, %82
  store float %mul38, float* %s37, align 4
  %83 = load float* %s37, align 4
  %84 = insertelement <3 x float> undef, float %83, i32 0
  %splat39 = shufflevector <3 x float> %84, <3 x float> %84, <3 x i32> zeroinitializer
  %85 = load <4 x float>* %r24, align 16
  %86 = shufflevector <4 x float> %85, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul40 = fmul <3 x float> %splat39, %86
  %87 = load <4 x float>* %acc, align 16
  %88 = shufflevector <4 x float> %87, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %add41 = fadd <3 x float> %88, %mul40
  %89 = load <4 x float>* %acc, align 16
  %90 = shufflevector <3 x float> %add41, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %91 = shufflevector <4 x float> %89, <4 x float> %90, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %91, <4 x float>* %acc, align 16
  br label %for.inc42

for.inc42:                                        ; preds = %for.body20
  %92 = load i32* %i, align 4
  %inc43 = add nsw i32 %92, 1
  store i32 %inc43, i32* %i, align 4
  br label %for.cond17

for.end44:                                        ; preds = %for.cond17
  %93 = load i32* %gid, align 4
  %idxprom45 = zext i32 %93 to i64
  %94 = load <4 x float> addrspace(1)** %vel.addr, align 8
  %arrayidx46 = getelementptr inbounds <4 x float> addrspace(1)* %94, i64 %idxprom45
  %95 = load <4 x float> addrspace(1)* %arrayidx46, align 16
  store <4 x float> %95, <4 x float>* %oldVel, align 16
  %96 = load <4 x float>* %myPos, align 16
  %97 = shufflevector <4 x float> %96, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %98 = load <4 x float>* %oldVel, align 16
  %99 = shufflevector <4 x float> %98, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %100 = load float* %deltaTime.addr, align 4
  %101 = insertelement <3 x float> undef, float %100, i32 0
  %splat47 = shufflevector <3 x float> %101, <3 x float> %101, <3 x i32> zeroinitializer
  %102 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %99, <3 x float> %splat47, <3 x float> %97)
  %103 = load <4 x float>* %acc, align 16
  %104 = shufflevector <4 x float> %103, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul49 = fmul <3 x float> %104, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %105 = load float* %deltaTime.addr, align 4
  %106 = insertelement <3 x float> undef, float %105, i32 0
  %splat50 = shufflevector <3 x float> %106, <3 x float> %106, <3 x i32> zeroinitializer
  %mul51 = fmul <3 x float> %mul49, %splat50
  %107 = load float* %deltaTime.addr, align 4
  %108 = insertelement <3 x float> undef, float %107, i32 0
  %splat52 = shufflevector <3 x float> %108, <3 x float> %108, <3 x i32> zeroinitializer
  %109 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %mul51, <3 x float> %splat52, <3 x float> %102)
  %110 = load <4 x float>* %newPos, align 16
  %111 = shufflevector <3 x float> %109, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %112 = shufflevector <4 x float> %110, <4 x float> %111, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %112, <4 x float>* %newPos, align 16
  %113 = load <4 x float>* %myPos, align 16
  %114 = extractelement <4 x float> %113, i32 3
  %115 = load <4 x float>* %newPos, align 16
  %116 = insertelement <4 x float> %115, float %114, i32 3
  store <4 x float> %116, <4 x float>* %newPos, align 16
  %117 = load <4 x float>* %oldVel, align 16
  %118 = shufflevector <4 x float> %117, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %119 = load <4 x float>* %acc, align 16
  %120 = shufflevector <4 x float> %119, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %121 = load float* %deltaTime.addr, align 4
  %122 = insertelement <3 x float> undef, float %121, i32 0
  %splat54 = shufflevector <3 x float> %122, <3 x float> %122, <3 x i32> zeroinitializer
  %123 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %120, <3 x float> %splat54, <3 x float> %118)
  %124 = load <4 x float>* %newVel, align 16
  %125 = shufflevector <3 x float> %123, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %126 = shufflevector <4 x float> %124, <4 x float> %125, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %126, <4 x float>* %newVel, align 16
  %127 = load <4 x float>* %oldVel, align 16
  %128 = extractelement <4 x float> %127, i32 3
  %129 = load <4 x float>* %newVel, align 16
  %130 = insertelement <4 x float> %129, float %128, i32 3
  store <4 x float> %130, <4 x float>* %newVel, align 16
  %131 = load <4 x float>* %newPos, align 16
  %132 = load i32* %gid, align 4
  %idxprom56 = zext i32 %132 to i64
  %133 = load <4 x float> addrspace(1)** %newPosition.addr, align 8
  %arrayidx57 = getelementptr inbounds <4 x float> addrspace(1)* %133, i64 %idxprom56
  store <4 x float> %131, <4 x float> addrspace(1)* %arrayidx57, align 16
  %134 = load <4 x float>* %newVel, align 16
  %135 = load i32* %gid, align 4
  %idxprom58 = zext i32 %135 to i64
  %136 = load <4 x float> addrspace(1)** %newVelocity.addr, align 8
  %arrayidx59 = getelementptr inbounds <4 x float> addrspace(1)* %136, i64 %idxprom58
  store <4 x float> %134, <4 x float> addrspace(1)* %arrayidx59, align 16
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

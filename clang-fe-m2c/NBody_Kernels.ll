; ModuleID = '../kernel-src/NBody_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @nbody_sim(<4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)* %vel, i32 %numBodies, float %deltaTime, float %epsSqr, <4 x float> addrspace(1)* %newPosition, <4 x float> addrspace(1)* %newVelocity) #0 {
  %1 = alloca <4 x float> addrspace(1)*, align 4
  %2 = alloca <4 x float> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca <4 x float> addrspace(1)*, align 4
  %7 = alloca <4 x float> addrspace(1)*, align 4
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
  %p1 = alloca <4 x float>, align 16
  %r2 = alloca <4 x float>, align 16
  %distSqr3 = alloca float, align 4
  %invDist4 = alloca float, align 4
  %invDistCube5 = alloca float, align 4
  %s6 = alloca float, align 4
  %oldVel = alloca <4 x float>, align 16
  %newPos = alloca <4 x float>, align 16
  %newVel = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)** %1, align 4
  store <4 x float> addrspace(1)* %vel, <4 x float> addrspace(1)** %2, align 4
  store i32 %numBodies, i32* %3, align 4
  store float %deltaTime, float* %4, align 4
  store float %epsSqr, float* %5, align 4
  store <4 x float> addrspace(1)* %newPosition, <4 x float> addrspace(1)** %6, align 4
  store <4 x float> addrspace(1)* %newVelocity, <4 x float> addrspace(1)** %7, align 4
  %8 = call i32 @__get_global_id_u32(i32 0)
  store i32 %8, i32* %gid, align 4
  %9 = load i32* %gid, align 4
  %10 = load <4 x float> addrspace(1)** %1, align 4
  %11 = getelementptr inbounds <4 x float> addrspace(1)* %10, i32 %9
  %12 = load <4 x float> addrspace(1)* %11, align 16
  store <4 x float> %12, <4 x float>* %myPos, align 16
  store <4 x float> zeroinitializer, <4 x float>* %acc, align 16
  store i32 0, i32* %i, align 4
  br label %13

; <label>:13                                      ; preds = %81, %0
  %14 = load i32* %i, align 4
  %15 = add nsw i32 %14, 8
  %16 = load i32* %3, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %82

; <label>:18                                      ; preds = %13
  store i32 0, i32* %j, align 4
  br label %19

; <label>:19                                      ; preds = %76, %18
  %20 = load i32* %j, align 4
  %21 = icmp slt i32 %20, 8
  br i1 %21, label %22, label %81

; <label>:22                                      ; preds = %19
  %23 = load i32* %i, align 4
  %24 = load <4 x float> addrspace(1)** %1, align 4
  %25 = getelementptr inbounds <4 x float> addrspace(1)* %24, i32 %23
  %26 = load <4 x float> addrspace(1)* %25, align 16
  store <4 x float> %26, <4 x float>* %p, align 16
  %27 = load <4 x float>* %p, align 16
  %28 = shufflevector <4 x float> %27, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %29 = load <4 x float>* %myPos, align 16
  %30 = shufflevector <4 x float> %29, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %31 = fsub <3 x float> %28, %30
  %32 = load <4 x float>* %r, align 16
  %33 = shufflevector <3 x float> %31, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %34 = shufflevector <4 x float> %32, <4 x float> %33, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %34, <4 x float>* %r, align 16
  %35 = load <4 x float>* %r, align 16
  %36 = extractelement <4 x float> %35, i32 0
  %37 = load <4 x float>* %r, align 16
  %38 = extractelement <4 x float> %37, i32 0
  %39 = load <4 x float>* %r, align 16
  %40 = extractelement <4 x float> %39, i32 1
  %41 = load <4 x float>* %r, align 16
  %42 = extractelement <4 x float> %41, i32 1
  %43 = fmul float %40, %42
  %44 = call float @llvm.fmuladd.f32(float %36, float %38, float %43)
  %45 = load <4 x float>* %r, align 16
  %46 = extractelement <4 x float> %45, i32 2
  %47 = load <4 x float>* %r, align 16
  %48 = extractelement <4 x float> %47, i32 2
  %49 = call float @llvm.fmuladd.f32(float %46, float %48, float %44)
  store float %49, float* %distSqr, align 4
  %50 = load float* %distSqr, align 4
  %51 = load float* %5, align 4
  %52 = fadd float %50, %51
  %53 = call float @llvm.sqrt.f32(float %52)
  %54 = fdiv float 1.000000e+00, %53, !fpmath !2
  store float %54, float* %invDist, align 4
  %55 = load float* %invDist, align 4
  %56 = load float* %invDist, align 4
  %57 = fmul float %55, %56
  %58 = load float* %invDist, align 4
  %59 = fmul float %57, %58
  store float %59, float* %invDistCube, align 4
  %60 = load <4 x float>* %p, align 16
  %61 = extractelement <4 x float> %60, i32 3
  %62 = load float* %invDistCube, align 4
  %63 = fmul float %61, %62
  store float %63, float* %s, align 4
  %64 = load float* %s, align 4
  %65 = insertelement <3 x float> undef, float %64, i32 0
  %66 = shufflevector <3 x float> %65, <3 x float> undef, <3 x i32> zeroinitializer
  %67 = load <4 x float>* %r, align 16
  %68 = shufflevector <4 x float> %67, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %69 = fmul <3 x float> %66, %68
  %70 = load <4 x float>* %acc, align 16
  %71 = shufflevector <4 x float> %70, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %72 = fadd <3 x float> %71, %69
  %73 = load <4 x float>* %acc, align 16
  %74 = shufflevector <3 x float> %72, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %75 = shufflevector <4 x float> %73, <4 x float> %74, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %75, <4 x float>* %acc, align 16
  br label %76

; <label>:76                                      ; preds = %22
  %77 = load i32* %j, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, i32* %j, align 4
  %79 = load i32* %i, align 4
  %80 = add nsw i32 %79, 1
  store i32 %80, i32* %i, align 4
  br label %19

; <label>:81                                      ; preds = %19
  br label %13

; <label>:82                                      ; preds = %13
  br label %83

; <label>:83                                      ; preds = %141, %82
  %84 = load i32* %i, align 4
  %85 = load i32* %3, align 4
  %86 = icmp slt i32 %84, %85
  br i1 %86, label %87, label %144

; <label>:87                                      ; preds = %83
  %88 = load i32* %i, align 4
  %89 = load <4 x float> addrspace(1)** %1, align 4
  %90 = getelementptr inbounds <4 x float> addrspace(1)* %89, i32 %88
  %91 = load <4 x float> addrspace(1)* %90, align 16
  store <4 x float> %91, <4 x float>* %p1, align 16
  %92 = load <4 x float>* %p1, align 16
  %93 = shufflevector <4 x float> %92, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %94 = load <4 x float>* %myPos, align 16
  %95 = shufflevector <4 x float> %94, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %96 = fsub <3 x float> %93, %95
  %97 = load <4 x float>* %r2, align 16
  %98 = shufflevector <3 x float> %96, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %99 = shufflevector <4 x float> %97, <4 x float> %98, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %99, <4 x float>* %r2, align 16
  %100 = load <4 x float>* %r2, align 16
  %101 = extractelement <4 x float> %100, i32 0
  %102 = load <4 x float>* %r2, align 16
  %103 = extractelement <4 x float> %102, i32 0
  %104 = load <4 x float>* %r2, align 16
  %105 = extractelement <4 x float> %104, i32 1
  %106 = load <4 x float>* %r2, align 16
  %107 = extractelement <4 x float> %106, i32 1
  %108 = fmul float %105, %107
  %109 = call float @llvm.fmuladd.f32(float %101, float %103, float %108)
  %110 = load <4 x float>* %r2, align 16
  %111 = extractelement <4 x float> %110, i32 2
  %112 = load <4 x float>* %r2, align 16
  %113 = extractelement <4 x float> %112, i32 2
  %114 = call float @llvm.fmuladd.f32(float %111, float %113, float %109)
  store float %114, float* %distSqr3, align 4
  %115 = load float* %distSqr3, align 4
  %116 = load float* %5, align 4
  %117 = fadd float %115, %116
  %118 = call float @llvm.sqrt.f32(float %117)
  %119 = fdiv float 1.000000e+00, %118, !fpmath !2
  store float %119, float* %invDist4, align 4
  %120 = load float* %invDist4, align 4
  %121 = load float* %invDist4, align 4
  %122 = fmul float %120, %121
  %123 = load float* %invDist4, align 4
  %124 = fmul float %122, %123
  store float %124, float* %invDistCube5, align 4
  %125 = load <4 x float>* %p1, align 16
  %126 = extractelement <4 x float> %125, i32 3
  %127 = load float* %invDistCube5, align 4
  %128 = fmul float %126, %127
  store float %128, float* %s6, align 4
  %129 = load float* %s6, align 4
  %130 = insertelement <3 x float> undef, float %129, i32 0
  %131 = shufflevector <3 x float> %130, <3 x float> undef, <3 x i32> zeroinitializer
  %132 = load <4 x float>* %r2, align 16
  %133 = shufflevector <4 x float> %132, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %134 = fmul <3 x float> %131, %133
  %135 = load <4 x float>* %acc, align 16
  %136 = shufflevector <4 x float> %135, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %137 = fadd <3 x float> %136, %134
  %138 = load <4 x float>* %acc, align 16
  %139 = shufflevector <3 x float> %137, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %140 = shufflevector <4 x float> %138, <4 x float> %139, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %140, <4 x float>* %acc, align 16
  br label %141

; <label>:141                                     ; preds = %87
  %142 = load i32* %i, align 4
  %143 = add nsw i32 %142, 1
  store i32 %143, i32* %i, align 4
  br label %83

; <label>:144                                     ; preds = %83
  %145 = load i32* %gid, align 4
  %146 = load <4 x float> addrspace(1)** %2, align 4
  %147 = getelementptr inbounds <4 x float> addrspace(1)* %146, i32 %145
  %148 = load <4 x float> addrspace(1)* %147, align 16
  store <4 x float> %148, <4 x float>* %oldVel, align 16
  %149 = load <4 x float>* %myPos, align 16
  %150 = shufflevector <4 x float> %149, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %151 = load <4 x float>* %oldVel, align 16
  %152 = shufflevector <4 x float> %151, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %153 = load float* %4, align 4
  %154 = insertelement <3 x float> undef, float %153, i32 0
  %155 = shufflevector <3 x float> %154, <3 x float> undef, <3 x i32> zeroinitializer
  %156 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %152, <3 x float> %155, <3 x float> %150)
  %157 = load <4 x float>* %acc, align 16
  %158 = shufflevector <4 x float> %157, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %159 = fmul <3 x float> %158, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %160 = load float* %4, align 4
  %161 = insertelement <3 x float> undef, float %160, i32 0
  %162 = shufflevector <3 x float> %161, <3 x float> undef, <3 x i32> zeroinitializer
  %163 = fmul <3 x float> %159, %162
  %164 = load float* %4, align 4
  %165 = insertelement <3 x float> undef, float %164, i32 0
  %166 = shufflevector <3 x float> %165, <3 x float> undef, <3 x i32> zeroinitializer
  %167 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %163, <3 x float> %166, <3 x float> %156)
  %168 = load <4 x float>* %newPos, align 16
  %169 = shufflevector <3 x float> %167, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %170 = shufflevector <4 x float> %168, <4 x float> %169, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %170, <4 x float>* %newPos, align 16
  %171 = load <4 x float>* %myPos, align 16
  %172 = extractelement <4 x float> %171, i32 3
  %173 = load <4 x float>* %newPos, align 16
  %174 = insertelement <4 x float> %173, float %172, i32 3
  store <4 x float> %174, <4 x float>* %newPos, align 16
  %175 = load <4 x float>* %oldVel, align 16
  %176 = shufflevector <4 x float> %175, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %177 = load <4 x float>* %acc, align 16
  %178 = shufflevector <4 x float> %177, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %179 = load float* %4, align 4
  %180 = insertelement <3 x float> undef, float %179, i32 0
  %181 = shufflevector <3 x float> %180, <3 x float> undef, <3 x i32> zeroinitializer
  %182 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %178, <3 x float> %181, <3 x float> %176)
  %183 = load <4 x float>* %newVel, align 16
  %184 = shufflevector <3 x float> %182, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %185 = shufflevector <4 x float> %183, <4 x float> %184, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  store <4 x float> %185, <4 x float>* %newVel, align 16
  %186 = load <4 x float>* %oldVel, align 16
  %187 = extractelement <4 x float> %186, i32 3
  %188 = load <4 x float>* %newVel, align 16
  %189 = insertelement <4 x float> %188, float %187, i32 3
  store <4 x float> %189, <4 x float>* %newVel, align 16
  %190 = load <4 x float>* %newPos, align 16
  %191 = load i32* %gid, align 4
  %192 = load <4 x float> addrspace(1)** %6, align 4
  %193 = getelementptr inbounds <4 x float> addrspace(1)* %192, i32 %191
  store <4 x float> %190, <4 x float> addrspace(1)* %193, align 16
  %194 = load <4 x float>* %newVel, align 16
  %195 = load i32* %gid, align 4
  %196 = load <4 x float> addrspace(1)** %7, align 4
  %197 = getelementptr inbounds <4 x float> addrspace(1)* %196, i32 %195
  store <4 x float> %194, <4 x float> addrspace(1)* %197, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #3

; Function Attrs: nounwind readnone
declare <3 x float> @llvm.fmuladd.v3f32(<3 x float>, <3 x float>, <3 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, float, float, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @nbody_sim}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

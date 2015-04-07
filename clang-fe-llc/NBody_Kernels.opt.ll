; ModuleID = 'NBody_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @nbody_sim(<4 x float> addrspace(1)* %pos, <4 x float> addrspace(1)* %vel, i32 %numBodies, float %deltaTime, float %epsSqr, <4 x float> addrspace(1)* %newPosition, <4 x float> addrspace(1)* %newVelocity) #0 {
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %1
  %3 = load <4 x float> addrspace(1)* %2, align 16
  br label %4

; <label>:4                                       ; preds = %45, %0
  %acc.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %acc.1, %45 ]
  %i.0 = phi i32 [ 0, %0 ], [ %i.1, %45 ]
  %5 = add nsw i32 %i.0, 8
  %6 = icmp slt i32 %5, %numBodies
  br i1 %6, label %7, label %46

; <label>:7                                       ; preds = %4
  br label %8

; <label>:8                                       ; preds = %42, %7
  %acc.1 = phi <4 x float> [ %acc.0, %7 ], [ %41, %42 ]
  %i.1 = phi i32 [ %i.0, %7 ], [ %44, %42 ]
  %j.0 = phi i32 [ 0, %7 ], [ %43, %42 ]
  %9 = icmp slt i32 %j.0, 8
  br i1 %9, label %10, label %45

; <label>:10                                      ; preds = %8
  %11 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %i.1
  %12 = load <4 x float> addrspace(1)* %11, align 16
  %13 = shufflevector <4 x float> %12, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %14 = shufflevector <4 x float> %3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %15 = fsub <3 x float> %13, %14
  %16 = shufflevector <3 x float> %15, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %17 = shufflevector <4 x float> undef, <4 x float> %16, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %18 = extractelement <4 x float> %17, i32 0
  %19 = extractelement <4 x float> %17, i32 0
  %20 = extractelement <4 x float> %17, i32 1
  %21 = extractelement <4 x float> %17, i32 1
  %22 = fmul float %20, %21
  %23 = call float @llvm.fmuladd.f32(float %18, float %19, float %22)
  %24 = extractelement <4 x float> %17, i32 2
  %25 = extractelement <4 x float> %17, i32 2
  %26 = call float @llvm.fmuladd.f32(float %24, float %25, float %23)
  %27 = fadd float %26, %epsSqr
  %28 = call float @llvm.sqrt.f32(float %27)
  %29 = fdiv float 1.000000e+00, %28, !fpmath !2
  %30 = fmul float %29, %29
  %31 = fmul float %30, %29
  %32 = extractelement <4 x float> %12, i32 3
  %33 = fmul float %32, %31
  %34 = insertelement <3 x float> undef, float %33, i32 0
  %35 = shufflevector <3 x float> %34, <3 x float> undef, <3 x i32> zeroinitializer
  %36 = shufflevector <4 x float> %17, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %37 = fmul <3 x float> %35, %36
  %38 = shufflevector <4 x float> %acc.1, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %39 = fadd <3 x float> %38, %37
  %40 = shufflevector <3 x float> %39, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %41 = shufflevector <4 x float> %acc.1, <4 x float> %40, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  br label %42

; <label>:42                                      ; preds = %10
  %43 = add nsw i32 %j.0, 1
  %44 = add nsw i32 %i.1, 1
  br label %8

; <label>:45                                      ; preds = %8
  br label %4

; <label>:46                                      ; preds = %4
  br label %47

; <label>:47                                      ; preds = %81, %46
  %acc.2 = phi <4 x float> [ %acc.0, %46 ], [ %80, %81 ]
  %i.2 = phi i32 [ %i.0, %46 ], [ %82, %81 ]
  %48 = icmp slt i32 %i.2, %numBodies
  br i1 %48, label %49, label %83

; <label>:49                                      ; preds = %47
  %50 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %i.2
  %51 = load <4 x float> addrspace(1)* %50, align 16
  %52 = shufflevector <4 x float> %51, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %53 = shufflevector <4 x float> %3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %54 = fsub <3 x float> %52, %53
  %55 = shufflevector <3 x float> %54, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %56 = shufflevector <4 x float> undef, <4 x float> %55, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %57 = extractelement <4 x float> %56, i32 0
  %58 = extractelement <4 x float> %56, i32 0
  %59 = extractelement <4 x float> %56, i32 1
  %60 = extractelement <4 x float> %56, i32 1
  %61 = fmul float %59, %60
  %62 = call float @llvm.fmuladd.f32(float %57, float %58, float %61)
  %63 = extractelement <4 x float> %56, i32 2
  %64 = extractelement <4 x float> %56, i32 2
  %65 = call float @llvm.fmuladd.f32(float %63, float %64, float %62)
  %66 = fadd float %65, %epsSqr
  %67 = call float @llvm.sqrt.f32(float %66)
  %68 = fdiv float 1.000000e+00, %67, !fpmath !2
  %69 = fmul float %68, %68
  %70 = fmul float %69, %68
  %71 = extractelement <4 x float> %51, i32 3
  %72 = fmul float %71, %70
  %73 = insertelement <3 x float> undef, float %72, i32 0
  %74 = shufflevector <3 x float> %73, <3 x float> undef, <3 x i32> zeroinitializer
  %75 = shufflevector <4 x float> %56, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %76 = fmul <3 x float> %74, %75
  %77 = shufflevector <4 x float> %acc.2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %78 = fadd <3 x float> %77, %76
  %79 = shufflevector <3 x float> %78, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %80 = shufflevector <4 x float> %acc.2, <4 x float> %79, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  br label %81

; <label>:81                                      ; preds = %49
  %82 = add nsw i32 %i.2, 1
  br label %47

; <label>:83                                      ; preds = %47
  %84 = getelementptr inbounds <4 x float> addrspace(1)* %vel, i32 %1
  %85 = load <4 x float> addrspace(1)* %84, align 16
  %86 = shufflevector <4 x float> %3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %87 = shufflevector <4 x float> %85, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %88 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %89 = shufflevector <3 x float> %88, <3 x float> undef, <3 x i32> zeroinitializer
  %90 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %87, <3 x float> %89, <3 x float> %86)
  %91 = shufflevector <4 x float> %acc.2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %92 = fmul <3 x float> %91, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %93 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %94 = shufflevector <3 x float> %93, <3 x float> undef, <3 x i32> zeroinitializer
  %95 = fmul <3 x float> %92, %94
  %96 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %97 = shufflevector <3 x float> %96, <3 x float> undef, <3 x i32> zeroinitializer
  %98 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %95, <3 x float> %97, <3 x float> %90)
  %99 = shufflevector <3 x float> %98, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %100 = shufflevector <4 x float> undef, <4 x float> %99, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %101 = extractelement <4 x float> %3, i32 3
  %102 = insertelement <4 x float> %100, float %101, i32 3
  %103 = shufflevector <4 x float> %85, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %104 = shufflevector <4 x float> %acc.2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %105 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %106 = shufflevector <3 x float> %105, <3 x float> undef, <3 x i32> zeroinitializer
  %107 = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %104, <3 x float> %106, <3 x float> %103)
  %108 = shufflevector <3 x float> %107, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %109 = shufflevector <4 x float> undef, <4 x float> %108, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %110 = extractelement <4 x float> %85, i32 3
  %111 = insertelement <4 x float> %109, float %110, i32 3
  %112 = getelementptr inbounds <4 x float> addrspace(1)* %newPosition, i32 %1
  store <4 x float> %102, <4 x float> addrspace(1)* %112, align 16
  %113 = getelementptr inbounds <4 x float> addrspace(1)* %newVelocity, i32 %1
  store <4 x float> %111, <4 x float> addrspace(1)* %113, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.z() #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nounwind readnone
declare <3 x float> @llvm.fmuladd.v3f32(<3 x float>, <3 x float>, <3 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, float, float, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @nbody_sim}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

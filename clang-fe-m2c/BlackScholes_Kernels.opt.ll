; ModuleID = 'BlackScholes_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @phi(<4 x float> %X, <4 x float>* %phi) #0 {
  %1 = call <4 x float> @llvm.fabs.v4f32(<4 x float> %X)
  %2 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %1, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %3 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %2, !fpmath !3
  %4 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %X
  %5 = fmul <4 x float> %4, %X
  %6 = fdiv <4 x float> %5, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %7 = call <4 x float> @_Z3expDv4_f(<4 x float> %6)
  %8 = fmul <4 x float> <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>, %7
  %9 = fmul <4 x float> %8, %3
  %10 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %3, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>)
  %11 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %3, <4 x float> %10, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>)
  %12 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %3, <4 x float> %11, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>)
  %13 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %3, <4 x float> %12, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>)
  %14 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %9
  %15 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %14, <4 x float> %13, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %16 = fcmp olt <4 x float> %X, zeroinitializer
  %17 = sext <4 x i1> %16 to <4 x i32>
  %18 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %15
  %19 = icmp slt <4 x i32> %17, zeroinitializer
  %20 = sext <4 x i1> %19 to <4 x i32>
  %21 = xor <4 x i32> %20, <i32 -1, i32 -1, i32 -1, i32 -1>
  %22 = bitcast <4 x float> %15 to <4 x i32>
  %23 = bitcast <4 x float> %18 to <4 x i32>
  %24 = and <4 x i32> %22, %21
  %25 = and <4 x i32> %23, %20
  %26 = or <4 x i32> %24, %25
  %27 = bitcast <4 x i32> %26 to <4 x float>
  store <4 x float> %27, <4 x float>* %phi, align 16
  ret void
}

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.fabs.v4f32(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare <4 x float> @_Z3expDv4_f(<4 x float>) #3

; Function Attrs: nounwind
define void @blackScholes(<4 x float> addrspace(1)* %randArray, i32 %width, <4 x float> addrspace(1)* %call, <4 x float> addrspace(1)* %put) #0 {
  %phiD1 = alloca <4 x float>, align 16
  %phiD2 = alloca <4 x float>, align 16
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = mul i32 %2, %width
  %4 = add i32 %3, %1
  %5 = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i32 %4
  %6 = load <4 x float> addrspace(1)* %5, align 16
  %7 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %6
  %8 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %7
  %9 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %6, <4 x float> %8)
  %10 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %6
  %11 = fmul <4 x float> <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>, %10
  %12 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %6, <4 x float> %11)
  %13 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %6
  %14 = fmul <4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, %13
  %15 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %6, <4 x float> %14)
  %16 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %6
  %17 = fmul <4 x float> <float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000>, %16
  %18 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %6, <4 x float> %17)
  %19 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %6
  %20 = fmul <4 x float> <float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000>, %19
  %21 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %6, <4 x float> %20)
  %22 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %15)
  %23 = fmul <4 x float> %21, %22
  %24 = fdiv <4 x float> %9, %12, !fpmath !3
  %25 = call <4 x float> @llvm.log2.v4f32(<4 x float> %24)
  %26 = fmul <4 x float> %21, %21
  %27 = fdiv <4 x float> %26, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %28 = fadd <4 x float> %18, %27
  %29 = fmul <4 x float> %28, %15
  %30 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %25, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %29)
  %31 = fdiv <4 x float> %30, %23, !fpmath !3
  %32 = fsub <4 x float> %31, %23
  %33 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %18
  %34 = fmul <4 x float> %33, %15
  %35 = call <4 x float> @_Z3expDv4_f(<4 x float> %34)
  %36 = fmul <4 x float> %12, %35
  call void @phi(<4 x float> %31, <4 x float>* %phiD1)
  call void @phi(<4 x float> %32, <4 x float>* %phiD2)
  %37 = load <4 x float>* %phiD1, align 16
  %38 = load <4 x float>* %phiD2, align 16
  %39 = fmul <4 x float> %36, %38
  %40 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %39
  %41 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %9, <4 x float> %37, <4 x float> %40)
  %42 = mul i32 %2, %width
  %43 = add i32 %42, %1
  %44 = getelementptr inbounds <4 x float> addrspace(1)* %call, i32 %43
  store <4 x float> %41, <4 x float> addrspace(1)* %44, align 16
  %45 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %31
  call void @phi(<4 x float> %45, <4 x float>* %phiD1)
  %46 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %32
  call void @phi(<4 x float> %46, <4 x float>* %phiD2)
  %47 = load <4 x float>* %phiD2, align 16
  %48 = load <4 x float>* %phiD1, align 16
  %49 = fmul <4 x float> %9, %48
  %50 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %49
  %51 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %36, <4 x float> %47, <4 x float> %50)
  %52 = mul i32 %2, %width
  %53 = add i32 %52, %1
  %54 = getelementptr inbounds <4 x float> addrspace(1)* %put, i32 %53
  store <4 x float> %51, <4 x float> addrspace(1)* %54, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #3

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #1

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #1

; Function Attrs: nounwind
define void @phi_scalar(float %X, float* %phi) #0 {
  %1 = call float @llvm.fabs.f32(float %X)
  %2 = call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %1, float 1.000000e+00)
  %3 = fdiv float 1.000000e+00, %2, !fpmath !3
  %4 = fsub float -0.000000e+00, %X
  %5 = fmul float %4, %X
  %6 = fdiv float %5, 2.000000e+00, !fpmath !3
  %7 = call float @_Z3expf(float %6)
  %8 = fmul float 0x3FD9884540000000, %7
  %9 = fmul float %8, %3
  %10 = call float @llvm.fmuladd.f32(float %3, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000)
  %11 = call float @llvm.fmuladd.f32(float %3, float %10, float 0x3FFC80EF00000000)
  %12 = call float @llvm.fmuladd.f32(float %3, float %11, float 0xBFD6D1F0E0000000)
  %13 = call float @llvm.fmuladd.f32(float %3, float %12, float 0x3FD470BF40000000)
  %14 = fsub float -0.000000e+00, %9
  %15 = call float @llvm.fmuladd.f32(float %14, float %13, float 1.000000e+00)
  %16 = fcmp olt float %X, 0.000000e+00
  br i1 %16, label %17, label %19

; <label>:17                                      ; preds = %0
  %18 = fsub float 1.000000e+00, %15
  br label %20

; <label>:19                                      ; preds = %0
  br label %20

; <label>:20                                      ; preds = %19, %17
  %21 = phi float [ %18, %17 ], [ %15, %19 ]
  store float %21, float* %phi, align 4
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.fabs.f32(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3expf(float) #3

; Function Attrs: nounwind
define void @blackScholes_scalar(float addrspace(1)* %randArray, i32 %width, float addrspace(1)* %call, float addrspace(1)* %put) #0 {
  %phiD1 = alloca float, align 4
  %phiD2 = alloca float, align 4
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = mul i32 %2, %width
  %4 = add i32 %3, %1
  %5 = getelementptr inbounds float addrspace(1)* %randArray, i32 %4
  %6 = load float addrspace(1)* %5, align 4
  %7 = fsub float 1.000000e+00, %6
  %8 = fmul float 1.000000e+02, %7
  %9 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %6, float %8)
  %10 = fsub float 1.000000e+00, %6
  %11 = fmul float 1.000000e+02, %10
  %12 = call float @llvm.fmuladd.f32(float 1.000000e+01, float %6, float %11)
  %13 = fsub float 1.000000e+00, %6
  %14 = fmul float 1.000000e+01, %13
  %15 = call float @llvm.fmuladd.f32(float 1.000000e+00, float %6, float %14)
  %16 = fsub float 1.000000e+00, %6
  %17 = fmul float 0x3FA99999A0000000, %16
  %18 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %6, float %17)
  %19 = fsub float 1.000000e+00, %6
  %20 = fmul float 0x3FB99999A0000000, %19
  %21 = call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %6, float %20)
  %22 = call float @llvm.sqrt.f32(float %15)
  %23 = fmul float %21, %22
  %24 = fdiv float %9, %12, !fpmath !3
  %25 = call float @llvm.log2.f32(float %24)
  %26 = fmul float %21, %21
  %27 = fdiv float %26, 2.000000e+00, !fpmath !3
  %28 = fadd float %18, %27
  %29 = fmul float %28, %15
  %30 = call float @llvm.fmuladd.f32(float %25, float 0x3FE62E4300000000, float %29)
  %31 = fdiv float %30, %23, !fpmath !3
  %32 = fsub float %31, %23
  %33 = fsub float -0.000000e+00, %18
  %34 = fmul float %33, %15
  %35 = call float @_Z3expf(float %34)
  %36 = fmul float %12, %35
  call void @phi_scalar(float %31, float* %phiD1)
  call void @phi_scalar(float %32, float* %phiD2)
  %37 = load float* %phiD1, align 4
  %38 = load float* %phiD2, align 4
  %39 = fmul float %36, %38
  %40 = fsub float -0.000000e+00, %39
  %41 = call float @llvm.fmuladd.f32(float %9, float %37, float %40)
  %42 = mul i32 %2, %width
  %43 = add i32 %42, %1
  %44 = getelementptr inbounds float addrspace(1)* %call, i32 %43
  store float %41, float addrspace(1)* %44, align 4
  %45 = fsub float -0.000000e+00, %31
  call void @phi_scalar(float %45, float* %phiD1)
  %46 = fsub float -0.000000e+00, %32
  call void @phi_scalar(float %46, float* %phiD2)
  %47 = load float* %phiD2, align 4
  %48 = load float* %phiD1, align 4
  %49 = fmul float %9, %48
  %50 = fsub float -0.000000e+00, %49
  %51 = call float @llvm.fmuladd.f32(float %36, float %47, float %50)
  %52 = mul i32 %2, %width
  %53 = add i32 %52, %1
  %54 = getelementptr inbounds float addrspace(1)* %put, i32 %53
  store float %51, float addrspace(1)* %54, align 4
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #1

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @blackScholes}
!1 = metadata !{void (float addrspace(1)*, i32, float addrspace(1)*, float addrspace(1)*)* @blackScholes_scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{float 2.500000e+00}

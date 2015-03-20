; ModuleID = '../kernel-src/BlackScholes_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @phi(<4 x float> %X, <4 x float>* nocapture %phi) #0 {
  %1 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %X)
  %2 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %1, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %3 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %2, !fpmath !10
  %4 = fmul <4 x float> %X, %X
  %5 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %4
  %6 = fdiv <4 x float> %5, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !10
  %7 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %6) #3
  %8 = fmul <4 x float> %7, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %9 = fmul <4 x float> %3, %8
  %10 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %3, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>)
  %11 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %3, <4 x float> %10, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>)
  %12 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %3, <4 x float> %11, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>)
  %13 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %3, <4 x float> %12, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>)
  %14 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %9
  %15 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %14, <4 x float> %13, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %16 = fcmp olt <4 x float> %X, zeroinitializer
  %17 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %15
  %.v = select <4 x i1> %16, <4 x float> %17, <4 x float> %15
  store <4 x float> %.v, <4 x float>* %phi, align 16, !tbaa !11
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fabs.v4f32(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #1

declare <4 x float> @_Z3expDv4_f(<4 x float>) #2

; Function Attrs: nounwind
define void @blackScholes(<4 x float> addrspace(1)* nocapture readonly %randArray, i32 %width, <4 x float> addrspace(1)* nocapture %call, <4 x float> addrspace(1)* nocapture %put) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = mul i32 %2, %width
  %4 = add i32 %3, %1
  %5 = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i32 %4
  %6 = load <4 x float> addrspace(1)* %5, align 16, !tbaa !11
  %7 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %6
  %8 = fmul <4 x float> %7, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %9 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %6, <4 x float> %8)
  %10 = fmul <4 x float> %7, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %11 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %6, <4 x float> %10)
  %12 = fmul <4 x float> %7, <float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000>
  %13 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %6, <4 x float> %12)
  %14 = fmul <4 x float> %7, <float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000>
  %15 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %6, <4 x float> %14)
  %16 = tail call <4 x float> @llvm.sqrt.v4f32(<4 x float> %11)
  %17 = fmul <4 x float> %15, %16
  %18 = fdiv <4 x float> %9, %9, !fpmath !10
  %19 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %18)
  %20 = fmul <4 x float> %15, %15
  %21 = fdiv <4 x float> %20, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !10
  %22 = fadd <4 x float> %13, %21
  %23 = fmul <4 x float> %11, %22
  %24 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %19, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %23)
  %25 = fdiv <4 x float> %24, %17, !fpmath !10
  %26 = fsub <4 x float> %25, %17
  %27 = fmul <4 x float> %11, %13
  %28 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %27
  %29 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %28) #3
  %30 = fmul <4 x float> %9, %29
  %31 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %25) #3
  %32 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %31, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #3
  %33 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %32, !fpmath !10
  %34 = fmul <4 x float> %25, %25
  %35 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %34
  %36 = fdiv <4 x float> %35, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !10
  %37 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %36) #3
  %38 = fmul <4 x float> %37, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %39 = fmul <4 x float> %33, %38
  %40 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %33, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #3
  %41 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %33, <4 x float> %40, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #3
  %42 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %33, <4 x float> %41, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #3
  %43 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %33, <4 x float> %42, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #3
  %44 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %39
  %45 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %44, <4 x float> %43, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #3
  %46 = fcmp olt <4 x float> %25, zeroinitializer
  %47 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %45
  %.v.i = select <4 x i1> %46, <4 x float> %47, <4 x float> %45
  %48 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %26) #3
  %49 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %48, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #3
  %50 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %49, !fpmath !10
  %51 = fmul <4 x float> %26, %26
  %52 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %51
  %53 = fdiv <4 x float> %52, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !10
  %54 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %53) #3
  %55 = fmul <4 x float> %54, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %56 = fmul <4 x float> %50, %55
  %57 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %50, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #3
  %58 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %50, <4 x float> %57, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #3
  %59 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %50, <4 x float> %58, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #3
  %60 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %50, <4 x float> %59, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #3
  %61 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %56
  %62 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %61, <4 x float> %60, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #3
  %63 = fcmp olt <4 x float> %26, zeroinitializer
  %64 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %62
  %.v.i1 = select <4 x i1> %63, <4 x float> %64, <4 x float> %62
  %65 = fmul <4 x float> %30, %.v.i1
  %66 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %65
  %67 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %9, <4 x float> %.v.i, <4 x float> %66)
  %68 = getelementptr inbounds <4 x float> addrspace(1)* %call, i32 %4
  store <4 x float> %67, <4 x float> addrspace(1)* %68, align 16, !tbaa !11
  %69 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %25
  %70 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %69) #3
  %71 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %70, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #3
  %72 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %71, !fpmath !10
  %73 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %36) #3
  %74 = fmul <4 x float> %73, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %75 = fmul <4 x float> %72, %74
  %76 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %72, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #3
  %77 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %72, <4 x float> %76, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #3
  %78 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %72, <4 x float> %77, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #3
  %79 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %72, <4 x float> %78, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #3
  %80 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %75
  %81 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %80, <4 x float> %79, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #3
  %82 = fcmp olt <4 x float> %69, zeroinitializer
  %83 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %81
  %.v.i2 = select <4 x i1> %82, <4 x float> %83, <4 x float> %81
  %84 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %26
  %85 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %84) #3
  %86 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %85, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #3
  %87 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %86, !fpmath !10
  %88 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %53) #3
  %89 = fmul <4 x float> %88, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %90 = fmul <4 x float> %87, %89
  %91 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %87, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #3
  %92 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %87, <4 x float> %91, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #3
  %93 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %87, <4 x float> %92, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #3
  %94 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %87, <4 x float> %93, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #3
  %95 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %90
  %96 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %95, <4 x float> %94, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #3
  %97 = fcmp olt <4 x float> %84, zeroinitializer
  %98 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %96
  %.v.i3 = select <4 x i1> %97, <4 x float> %98, <4 x float> %96
  %99 = fmul <4 x float> %9, %.v.i2
  %100 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %99
  %101 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %30, <4 x float> %.v.i3, <4 x float> %100)
  %102 = getelementptr inbounds <4 x float> addrspace(1)* %put, i32 %4
  store <4 x float> %101, <4 x float> addrspace(1)* %102, align 16, !tbaa !11
  ret void
}

declare i32 @get_global_id(i32) #2

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #1

; Function Attrs: nounwind
define void @phi_scalar(float %X, float* nocapture %phi) #0 {
  %1 = tail call float @llvm.fabs.f32(float %X)
  %2 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %1, float 1.000000e+00)
  %3 = fdiv float 1.000000e+00, %2, !fpmath !10
  %4 = fmul float %X, %X
  %5 = fmul float %4, -5.000000e-01
  %6 = tail call float @_Z3expf(float %5) #3
  %7 = fmul float %6, 0x3FD9884540000000
  %8 = fmul float %3, %7
  %9 = tail call float @llvm.fmuladd.f32(float %3, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000)
  %10 = tail call float @llvm.fmuladd.f32(float %3, float %9, float 0x3FFC80EF00000000)
  %11 = tail call float @llvm.fmuladd.f32(float %3, float %10, float 0xBFD6D1F0E0000000)
  %12 = tail call float @llvm.fmuladd.f32(float %3, float %11, float 0x3FD470BF40000000)
  %13 = fsub float -0.000000e+00, %8
  %14 = tail call float @llvm.fmuladd.f32(float %13, float %12, float 1.000000e+00)
  %15 = fcmp olt float %X, 0.000000e+00
  br i1 %15, label %16, label %18

; <label>:16                                      ; preds = %0
  %17 = fsub float 1.000000e+00, %14
  br label %18

; <label>:18                                      ; preds = %0, %16
  %19 = phi float [ %17, %16 ], [ %14, %0 ]
  store float %19, float* %phi, align 4, !tbaa !14
  ret void
}

; Function Attrs: nounwind readnone
declare float @llvm.fabs.f32(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

declare float @_Z3expf(float) #2

; Function Attrs: nounwind
define void @blackScholes_scalar(float addrspace(1)* nocapture readonly %randArray, i32 %width, float addrspace(1)* nocapture %call, float addrspace(1)* nocapture %put) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = mul i32 %2, %width
  %4 = add i32 %3, %1
  %5 = getelementptr inbounds float addrspace(1)* %randArray, i32 %4
  %6 = load float addrspace(1)* %5, align 4, !tbaa !14
  %7 = fsub float 1.000000e+00, %6
  %8 = fmul float %7, 1.000000e+02
  %9 = tail call float @llvm.fmuladd.f32(float 1.000000e+01, float %6, float %8)
  %10 = fmul float %7, 1.000000e+01
  %11 = tail call float @llvm.fmuladd.f32(float 1.000000e+00, float %6, float %10)
  %12 = fmul float %7, 0x3FA99999A0000000
  %13 = tail call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %6, float %12)
  %14 = fmul float %7, 0x3FB99999A0000000
  %15 = tail call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %6, float %14)
  %16 = tail call float @llvm.sqrt.f32(float %11)
  %17 = fmul float %15, %16
  %18 = fdiv float %9, %9, !fpmath !10
  %19 = tail call float @llvm.log2.f32(float %18)
  %20 = fmul float %15, %15
  %21 = fmul float %20, 5.000000e-01
  %22 = fadd float %13, %21
  %23 = fmul float %11, %22
  %24 = tail call float @llvm.fmuladd.f32(float %19, float 0x3FE62E4300000000, float %23)
  %25 = fdiv float %24, %17, !fpmath !10
  %26 = fsub float %25, %17
  %27 = fmul float %11, %13
  %28 = fsub float -0.000000e+00, %27
  %29 = tail call float @_Z3expf(float %28) #3
  %30 = fmul float %9, %29
  %31 = tail call float @llvm.fabs.f32(float %25) #3
  %32 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %31, float 1.000000e+00) #3
  %33 = fdiv float 1.000000e+00, %32, !fpmath !10
  %34 = fmul float %25, %25
  %35 = fmul float %34, -5.000000e-01
  %36 = tail call float @_Z3expf(float %35) #3
  %37 = fmul float %36, 0x3FD9884540000000
  %38 = fmul float %33, %37
  %39 = tail call float @llvm.fmuladd.f32(float %33, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #3
  %40 = tail call float @llvm.fmuladd.f32(float %33, float %39, float 0x3FFC80EF00000000) #3
  %41 = tail call float @llvm.fmuladd.f32(float %33, float %40, float 0xBFD6D1F0E0000000) #3
  %42 = tail call float @llvm.fmuladd.f32(float %33, float %41, float 0x3FD470BF40000000) #3
  %43 = fsub float -0.000000e+00, %38
  %44 = tail call float @llvm.fmuladd.f32(float %43, float %42, float 1.000000e+00) #3
  %45 = fcmp olt float %25, 0.000000e+00
  br i1 %45, label %46, label %phi_scalar.exit

; <label>:46                                      ; preds = %0
  %47 = fsub float 1.000000e+00, %44
  br label %phi_scalar.exit

phi_scalar.exit:                                  ; preds = %0, %46
  %48 = phi float [ %47, %46 ], [ %44, %0 ]
  %49 = tail call float @llvm.fabs.f32(float %26) #3
  %50 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %49, float 1.000000e+00) #3
  %51 = fdiv float 1.000000e+00, %50, !fpmath !10
  %52 = fmul float %26, %26
  %53 = fmul float %52, -5.000000e-01
  %54 = tail call float @_Z3expf(float %53) #3
  %55 = fmul float %54, 0x3FD9884540000000
  %56 = fmul float %51, %55
  %57 = tail call float @llvm.fmuladd.f32(float %51, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #3
  %58 = tail call float @llvm.fmuladd.f32(float %51, float %57, float 0x3FFC80EF00000000) #3
  %59 = tail call float @llvm.fmuladd.f32(float %51, float %58, float 0xBFD6D1F0E0000000) #3
  %60 = tail call float @llvm.fmuladd.f32(float %51, float %59, float 0x3FD470BF40000000) #3
  %61 = fsub float -0.000000e+00, %56
  %62 = tail call float @llvm.fmuladd.f32(float %61, float %60, float 1.000000e+00) #3
  %63 = fcmp olt float %26, 0.000000e+00
  br i1 %63, label %64, label %phi_scalar.exit1

; <label>:64                                      ; preds = %phi_scalar.exit
  %65 = fsub float 1.000000e+00, %62
  br label %phi_scalar.exit1

phi_scalar.exit1:                                 ; preds = %phi_scalar.exit, %64
  %66 = phi float [ %65, %64 ], [ %62, %phi_scalar.exit ]
  %67 = fmul float %30, %66
  %68 = fsub float -0.000000e+00, %67
  %69 = tail call float @llvm.fmuladd.f32(float %9, float %48, float %68)
  %70 = getelementptr inbounds float addrspace(1)* %call, i32 %4
  store float %69, float addrspace(1)* %70, align 4, !tbaa !14
  %71 = fsub float -0.000000e+00, %25
  %72 = tail call float @llvm.fabs.f32(float %71) #3
  %73 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %72, float 1.000000e+00) #3
  %74 = fdiv float 1.000000e+00, %73, !fpmath !10
  %75 = tail call float @_Z3expf(float %35) #3
  %76 = fmul float %75, 0x3FD9884540000000
  %77 = fmul float %74, %76
  %78 = tail call float @llvm.fmuladd.f32(float %74, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #3
  %79 = tail call float @llvm.fmuladd.f32(float %74, float %78, float 0x3FFC80EF00000000) #3
  %80 = tail call float @llvm.fmuladd.f32(float %74, float %79, float 0xBFD6D1F0E0000000) #3
  %81 = tail call float @llvm.fmuladd.f32(float %74, float %80, float 0x3FD470BF40000000) #3
  %82 = fsub float -0.000000e+00, %77
  %83 = tail call float @llvm.fmuladd.f32(float %82, float %81, float 1.000000e+00) #3
  %84 = fcmp ogt float %25, -0.000000e+00
  br i1 %84, label %85, label %phi_scalar.exit2

; <label>:85                                      ; preds = %phi_scalar.exit1
  %86 = fsub float 1.000000e+00, %83
  br label %phi_scalar.exit2

phi_scalar.exit2:                                 ; preds = %phi_scalar.exit1, %85
  %87 = phi float [ %86, %85 ], [ %83, %phi_scalar.exit1 ]
  %88 = fsub float -0.000000e+00, %26
  %89 = tail call float @llvm.fabs.f32(float %88) #3
  %90 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %89, float 1.000000e+00) #3
  %91 = fdiv float 1.000000e+00, %90, !fpmath !10
  %92 = tail call float @_Z3expf(float %53) #3
  %93 = fmul float %92, 0x3FD9884540000000
  %94 = fmul float %91, %93
  %95 = tail call float @llvm.fmuladd.f32(float %91, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #3
  %96 = tail call float @llvm.fmuladd.f32(float %91, float %95, float 0x3FFC80EF00000000) #3
  %97 = tail call float @llvm.fmuladd.f32(float %91, float %96, float 0xBFD6D1F0E0000000) #3
  %98 = tail call float @llvm.fmuladd.f32(float %91, float %97, float 0x3FD470BF40000000) #3
  %99 = fsub float -0.000000e+00, %94
  %100 = tail call float @llvm.fmuladd.f32(float %99, float %98, float 1.000000e+00) #3
  %101 = fcmp ogt float %26, -0.000000e+00
  br i1 %101, label %102, label %phi_scalar.exit3

; <label>:102                                     ; preds = %phi_scalar.exit2
  %103 = fsub float 1.000000e+00, %100
  br label %phi_scalar.exit3

phi_scalar.exit3:                                 ; preds = %phi_scalar.exit2, %102
  %104 = phi float [ %103, %102 ], [ %100, %phi_scalar.exit2 ]
  %105 = fmul float %9, %87
  %106 = fsub float -0.000000e+00, %105
  %107 = tail call float @llvm.fmuladd.f32(float %30, float %104, float %106)
  %108 = getelementptr inbounds float addrspace(1)* %put, i32 %4
  store float %107, float addrspace(1)* %108, align 4, !tbaa !14
  ret void
}

; Function Attrs: nounwind readnone
declare float @llvm.sqrt.f32(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.log2.f32(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!9}

!0 = !{void (<4 x float> addrspace(1)*, i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @blackScholes, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float4*", !"int", !"float4*", !"float4*"}
!4 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"int", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*"}
!5 = !{!"kernel_arg_type_qual", !"const", !"", !"", !""}
!6 = !{void (float addrspace(1)*, i32, float addrspace(1)*, float addrspace(1)*)* @blackScholes_scalar, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"float*", !"int", !"float*", !"float*"}
!8 = !{!"kernel_arg_base_type", !"float*", !"int", !"float*", !"float*"}
!9 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!10 = !{float 2.500000e+00}
!11 = !{!12, !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{!15, !15, i64 0}
!15 = !{!"float", !12, i64 0}

; ModuleID = '../kernel-src/BlackScholes_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @phi(<4 x float> %X, <4 x float>* nocapture %phi) #0 {
  %1 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %X)
  %2 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %1, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %3 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %2, !fpmath !3
  %4 = fmul <4 x float> %X, %X
  %5 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %4
  %6 = fdiv <4 x float> %5, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %7 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %6) #4
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
  store <4 x float> %.v, <4 x float>* %phi, align 16, !tbaa !4
  ret void
}

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.fabs.v4f32(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare <4 x float> @_Z3expDv4_f(<4 x float>) #3

; Function Attrs: nounwind uwtable
define void @blackScholes(<4 x float>* nocapture readonly %randArray, i32 %width, <4 x float>* nocapture %call, <4 x float>* nocapture %put) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #4
  %2 = tail call i64 @get_global_id(i32 1) #4
  %3 = sext i32 %width to i64
  %4 = mul i64 %2, %3
  %5 = add i64 %4, %1
  %6 = getelementptr inbounds <4 x float>* %randArray, i64 %5
  %7 = load <4 x float>* %6, align 16, !tbaa !4
  %8 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %7
  %9 = fmul <4 x float> %8, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %10 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %7, <4 x float> %9)
  %11 = fmul <4 x float> %8, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %12 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %7, <4 x float> %11)
  %13 = fmul <4 x float> %8, <float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000>
  %14 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %7, <4 x float> %13)
  %15 = fmul <4 x float> %8, <float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000>
  %16 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %7, <4 x float> %15)
  %17 = tail call <4 x float> @llvm.sqrt.v4f32(<4 x float> %12)
  %18 = fmul <4 x float> %16, %17
  %19 = fdiv <4 x float> %10, %10, !fpmath !3
  %20 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %19)
  %21 = fmul <4 x float> %16, %16
  %22 = fdiv <4 x float> %21, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %23 = fadd <4 x float> %14, %22
  %24 = fmul <4 x float> %12, %23
  %25 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %20, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %24)
  %26 = fdiv <4 x float> %25, %18, !fpmath !3
  %27 = fsub <4 x float> %26, %18
  %28 = fmul <4 x float> %12, %14
  %29 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %28
  %30 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %29) #4
  %31 = fmul <4 x float> %10, %30
  %32 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %26) #4
  %33 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %32, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %34 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %33, !fpmath !3
  %35 = fmul <4 x float> %26, %26
  %36 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %35
  %37 = fdiv <4 x float> %36, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %38 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %37) #4
  %39 = fmul <4 x float> %38, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %40 = fmul <4 x float> %34, %39
  %41 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %34, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #4
  %42 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %34, <4 x float> %41, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #4
  %43 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %34, <4 x float> %42, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #4
  %44 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %34, <4 x float> %43, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #4
  %45 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %40
  %46 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %45, <4 x float> %44, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %47 = fcmp olt <4 x float> %26, zeroinitializer
  %48 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %46
  %.v.i = select <4 x i1> %47, <4 x float> %48, <4 x float> %46
  %49 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %27) #4
  %50 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %49, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %51 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %50, !fpmath !3
  %52 = fmul <4 x float> %27, %27
  %53 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %52
  %54 = fdiv <4 x float> %53, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %55 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %54) #4
  %56 = fmul <4 x float> %55, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %57 = fmul <4 x float> %51, %56
  %58 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %51, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #4
  %59 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %51, <4 x float> %58, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #4
  %60 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %51, <4 x float> %59, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #4
  %61 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %51, <4 x float> %60, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #4
  %62 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %57
  %63 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %62, <4 x float> %61, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %64 = fcmp olt <4 x float> %27, zeroinitializer
  %65 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %63
  %.v.i1 = select <4 x i1> %64, <4 x float> %65, <4 x float> %63
  %66 = fmul <4 x float> %31, %.v.i1
  %67 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %66
  %68 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %10, <4 x float> %.v.i, <4 x float> %67)
  %69 = getelementptr inbounds <4 x float>* %call, i64 %5
  store <4 x float> %68, <4 x float>* %69, align 16, !tbaa !4
  %70 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %26
  %71 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %70) #4
  %72 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %71, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %73 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %72, !fpmath !3
  %74 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %37) #4
  %75 = fmul <4 x float> %74, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %76 = fmul <4 x float> %73, %75
  %77 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %73, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #4
  %78 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %73, <4 x float> %77, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #4
  %79 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %73, <4 x float> %78, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #4
  %80 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %73, <4 x float> %79, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #4
  %81 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %76
  %82 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %81, <4 x float> %80, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %83 = fcmp olt <4 x float> %70, zeroinitializer
  %84 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %82
  %.v.i2 = select <4 x i1> %83, <4 x float> %84, <4 x float> %82
  %85 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %27
  %86 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %85) #4
  %87 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %86, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %88 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %87, !fpmath !3
  %89 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %54) #4
  %90 = fmul <4 x float> %89, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %91 = fmul <4 x float> %88, %90
  %92 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %88, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #4
  %93 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %88, <4 x float> %92, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #4
  %94 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %88, <4 x float> %93, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #4
  %95 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %88, <4 x float> %94, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #4
  %96 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %91
  %97 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %96, <4 x float> %95, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %98 = fcmp olt <4 x float> %85, zeroinitializer
  %99 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %97
  %.v.i3 = select <4 x i1> %98, <4 x float> %99, <4 x float> %97
  %100 = fmul <4 x float> %10, %.v.i2
  %101 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %100
  %102 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %31, <4 x float> %.v.i3, <4 x float> %101)
  %103 = getelementptr inbounds <4 x float>* %put, i64 %5
  store <4 x float> %102, <4 x float>* %103, align 16, !tbaa !4
  ret void
}

declare i64 @get_global_id(i32) #3

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #1

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #1

; Function Attrs: nounwind uwtable
define void @phi_scalar(float %X, float* nocapture %phi) #0 {
  %1 = tail call float @llvm.fabs.f32(float %X)
  %2 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %1, float 1.000000e+00)
  %3 = fdiv float 1.000000e+00, %2, !fpmath !3
  %4 = fmul float %X, %X
  %5 = fmul float %4, -5.000000e-01
  %6 = tail call float @_Z3expf(float %5) #4
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
  store float %19, float* %phi, align 4, !tbaa !7
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.fabs.f32(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3expf(float) #3

; Function Attrs: nounwind uwtable
define void @blackScholes_scalar(float* nocapture readonly %randArray, i32 %width, float* nocapture %call, float* nocapture %put) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #4
  %2 = tail call i64 @get_global_id(i32 1) #4
  %3 = sext i32 %width to i64
  %4 = mul i64 %2, %3
  %5 = add i64 %4, %1
  %6 = getelementptr inbounds float* %randArray, i64 %5
  %7 = load float* %6, align 4, !tbaa !7
  %8 = fsub float 1.000000e+00, %7
  %9 = fmul float %8, 1.000000e+02
  %10 = tail call float @llvm.fmuladd.f32(float 1.000000e+01, float %7, float %9)
  %11 = fmul float %8, 1.000000e+01
  %12 = tail call float @llvm.fmuladd.f32(float 1.000000e+00, float %7, float %11)
  %13 = fmul float %8, 0x3FA99999A0000000
  %14 = tail call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %7, float %13)
  %15 = fmul float %8, 0x3FB99999A0000000
  %16 = tail call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %7, float %15)
  %17 = tail call float @llvm.sqrt.f32(float %12)
  %18 = fmul float %16, %17
  %19 = fdiv float %10, %10, !fpmath !3
  %20 = tail call float @llvm.log2.f32(float %19)
  %21 = fmul float %16, %16
  %22 = fmul float %21, 5.000000e-01
  %23 = fadd float %14, %22
  %24 = fmul float %12, %23
  %25 = tail call float @llvm.fmuladd.f32(float %20, float 0x3FE62E4300000000, float %24)
  %26 = fdiv float %25, %18, !fpmath !3
  %27 = fsub float %26, %18
  %28 = fmul float %12, %14
  %29 = fsub float -0.000000e+00, %28
  %30 = tail call float @_Z3expf(float %29) #4
  %31 = fmul float %10, %30
  %32 = tail call float @llvm.fabs.f32(float %26) #4
  %33 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %32, float 1.000000e+00) #4
  %34 = fdiv float 1.000000e+00, %33, !fpmath !3
  %35 = fmul float %26, %26
  %36 = fmul float %35, -5.000000e-01
  %37 = tail call float @_Z3expf(float %36) #4
  %38 = fmul float %37, 0x3FD9884540000000
  %39 = fmul float %34, %38
  %40 = tail call float @llvm.fmuladd.f32(float %34, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #4
  %41 = tail call float @llvm.fmuladd.f32(float %34, float %40, float 0x3FFC80EF00000000) #4
  %42 = tail call float @llvm.fmuladd.f32(float %34, float %41, float 0xBFD6D1F0E0000000) #4
  %43 = tail call float @llvm.fmuladd.f32(float %34, float %42, float 0x3FD470BF40000000) #4
  %44 = fsub float -0.000000e+00, %39
  %45 = tail call float @llvm.fmuladd.f32(float %44, float %43, float 1.000000e+00) #4
  %46 = fcmp olt float %26, 0.000000e+00
  br i1 %46, label %47, label %phi_scalar.exit

; <label>:47                                      ; preds = %0
  %48 = fsub float 1.000000e+00, %45
  br label %phi_scalar.exit

phi_scalar.exit:                                  ; preds = %0, %47
  %49 = phi float [ %48, %47 ], [ %45, %0 ]
  %50 = tail call float @llvm.fabs.f32(float %27) #4
  %51 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %50, float 1.000000e+00) #4
  %52 = fdiv float 1.000000e+00, %51, !fpmath !3
  %53 = fmul float %27, %27
  %54 = fmul float %53, -5.000000e-01
  %55 = tail call float @_Z3expf(float %54) #4
  %56 = fmul float %55, 0x3FD9884540000000
  %57 = fmul float %52, %56
  %58 = tail call float @llvm.fmuladd.f32(float %52, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #4
  %59 = tail call float @llvm.fmuladd.f32(float %52, float %58, float 0x3FFC80EF00000000) #4
  %60 = tail call float @llvm.fmuladd.f32(float %52, float %59, float 0xBFD6D1F0E0000000) #4
  %61 = tail call float @llvm.fmuladd.f32(float %52, float %60, float 0x3FD470BF40000000) #4
  %62 = fsub float -0.000000e+00, %57
  %63 = tail call float @llvm.fmuladd.f32(float %62, float %61, float 1.000000e+00) #4
  %64 = fcmp olt float %27, 0.000000e+00
  br i1 %64, label %65, label %phi_scalar.exit1

; <label>:65                                      ; preds = %phi_scalar.exit
  %66 = fsub float 1.000000e+00, %63
  br label %phi_scalar.exit1

phi_scalar.exit1:                                 ; preds = %phi_scalar.exit, %65
  %67 = phi float [ %66, %65 ], [ %63, %phi_scalar.exit ]
  %68 = fmul float %31, %67
  %69 = fsub float -0.000000e+00, %68
  %70 = tail call float @llvm.fmuladd.f32(float %10, float %49, float %69)
  %71 = getelementptr inbounds float* %call, i64 %5
  store float %70, float* %71, align 4, !tbaa !7
  %72 = fsub float -0.000000e+00, %26
  %73 = tail call float @llvm.fabs.f32(float %72) #4
  %74 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %73, float 1.000000e+00) #4
  %75 = fdiv float 1.000000e+00, %74, !fpmath !3
  %76 = tail call float @_Z3expf(float %36) #4
  %77 = fmul float %76, 0x3FD9884540000000
  %78 = fmul float %75, %77
  %79 = tail call float @llvm.fmuladd.f32(float %75, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #4
  %80 = tail call float @llvm.fmuladd.f32(float %75, float %79, float 0x3FFC80EF00000000) #4
  %81 = tail call float @llvm.fmuladd.f32(float %75, float %80, float 0xBFD6D1F0E0000000) #4
  %82 = tail call float @llvm.fmuladd.f32(float %75, float %81, float 0x3FD470BF40000000) #4
  %83 = fsub float -0.000000e+00, %78
  %84 = tail call float @llvm.fmuladd.f32(float %83, float %82, float 1.000000e+00) #4
  %85 = fcmp ogt float %26, -0.000000e+00
  br i1 %85, label %86, label %phi_scalar.exit2

; <label>:86                                      ; preds = %phi_scalar.exit1
  %87 = fsub float 1.000000e+00, %84
  br label %phi_scalar.exit2

phi_scalar.exit2:                                 ; preds = %phi_scalar.exit1, %86
  %88 = phi float [ %87, %86 ], [ %84, %phi_scalar.exit1 ]
  %89 = fsub float -0.000000e+00, %27
  %90 = tail call float @llvm.fabs.f32(float %89) #4
  %91 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %90, float 1.000000e+00) #4
  %92 = fdiv float 1.000000e+00, %91, !fpmath !3
  %93 = tail call float @_Z3expf(float %54) #4
  %94 = fmul float %93, 0x3FD9884540000000
  %95 = fmul float %92, %94
  %96 = tail call float @llvm.fmuladd.f32(float %92, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #4
  %97 = tail call float @llvm.fmuladd.f32(float %92, float %96, float 0x3FFC80EF00000000) #4
  %98 = tail call float @llvm.fmuladd.f32(float %92, float %97, float 0xBFD6D1F0E0000000) #4
  %99 = tail call float @llvm.fmuladd.f32(float %92, float %98, float 0x3FD470BF40000000) #4
  %100 = fsub float -0.000000e+00, %95
  %101 = tail call float @llvm.fmuladd.f32(float %100, float %99, float 1.000000e+00) #4
  %102 = fcmp ogt float %27, -0.000000e+00
  br i1 %102, label %103, label %phi_scalar.exit3

; <label>:103                                     ; preds = %phi_scalar.exit2
  %104 = fsub float 1.000000e+00, %101
  br label %phi_scalar.exit3

phi_scalar.exit3:                                 ; preds = %phi_scalar.exit2, %103
  %105 = phi float [ %104, %103 ], [ %101, %phi_scalar.exit2 ]
  %106 = fmul float %10, %88
  %107 = fsub float -0.000000e+00, %106
  %108 = tail call float @llvm.fmuladd.f32(float %31, float %105, float %107)
  %109 = getelementptr inbounds float* %put, i64 %5
  store float %108, float* %109, align 4, !tbaa !7
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #1

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float>*, i32, <4 x float>*, <4 x float>*)* @blackScholes}
!1 = metadata !{void (float*, i32, float*, float*)* @blackScholes_scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{float 2.500000e+00}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"float", metadata !5, i64 0}

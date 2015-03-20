; ModuleID = '../kernel-src/Mandelbrot_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @mandelbrot_vector_float(<4 x i8>* nocapture %mandelbrotImage, float %posx, float %posy, float %stepSizeX, float %stepSizeY, i32 %maxIterations, i32 %width, i32 %bench) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #4
  %2 = trunc i64 %1 to i32
  %3 = sdiv i32 %width, 4
  %4 = srem i32 %2, %3
  %5 = sdiv i32 %2, %3
  %6 = shl nsw i32 %4, 2
  %7 = or i32 %6, 1
  %8 = or i32 %6, 2
  %9 = or i32 %6, 3
  %10 = sitofp i32 %6 to float
  %11 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %10, float %posx)
  %12 = insertelement <4 x float> undef, float %11, i32 0
  %13 = sitofp i32 %7 to float
  %14 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %13, float %posx)
  %15 = insertelement <4 x float> %12, float %14, i32 1
  %16 = sitofp i32 %8 to float
  %17 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %16, float %posx)
  %18 = insertelement <4 x float> %15, float %17, i32 2
  %19 = sitofp i32 %9 to float
  %20 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %19, float %posx)
  %21 = insertelement <4 x float> %18, float %20, i32 3
  %22 = sitofp i32 %5 to float
  %23 = tail call float @llvm.fmuladd.f32(float %stepSizeY, float %22, float %posy)
  %24 = insertelement <4 x float> undef, float %23, i32 0
  %25 = insertelement <4 x float> %24, float %23, i32 1
  %26 = insertelement <4 x float> %25, float %23, i32 2
  %27 = insertelement <4 x float> %26, float %23, i32 3
  %28 = fmul float %23, %23
  %29 = tail call float @llvm.fmuladd.f32(float %11, float %11, float %28)
  %30 = fcmp ole float %29, 4.000000e+00
  %31 = zext i1 %30 to i32
  %32 = tail call float @llvm.fmuladd.f32(float %14, float %14, float %28)
  %33 = fcmp ole float %32, 4.000000e+00
  %34 = zext i1 %33 to i32
  %35 = tail call float @llvm.fmuladd.f32(float %17, float %17, float %28)
  %36 = fcmp ole float %35, 4.000000e+00
  %37 = zext i1 %36 to i32
  %38 = tail call float @llvm.fmuladd.f32(float %20, float %20, float %28)
  %39 = fcmp ole float %38, 4.000000e+00
  %40 = zext i1 %39 to i32
  %41 = or i1 %30, %33
  %42 = or i1 %41, %36
  %43 = or i1 %42, %39
  %44 = icmp ne i32 %maxIterations, 0
  %or.cond2936 = and i1 %43, %44
  br i1 %or.cond2936, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %.lr.ph
  %savy.040 = phi <4 x float> [ %240, %.lr.ph ], [ %27, %0 ]
  %savx.039 = phi <4 x float> [ %232, %.lr.ph ], [ %21, %0 ]
  %ccount.038 = phi <4 x i32> [ %242, %.lr.ph ], [ zeroinitializer, %0 ]
  %iter.037 = phi i32 [ %243, %.lr.ph ], [ 0, %0 ]
  %45 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.040
  %46 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %savx.039, <4 x float> %savx.039, <4 x float> %21) #4
  %47 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %45, <4 x float> %savy.040, i32 %46) #4
  %48 = sitofp i32 %47 to float
  %49 = insertelement <4 x float> undef, float %48, i32 0
  %50 = shufflevector <4 x float> %49, <4 x float> undef, <4 x i32> zeroinitializer
  %51 = fmul <4 x float> %savx.039, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %52 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %51, <4 x float> %savy.040, <4 x float> %27) #4
  %53 = sitofp i32 %52 to float
  %54 = insertelement <4 x float> undef, float %53, i32 0
  %55 = shufflevector <4 x float> %54, <4 x float> undef, <4 x i32> zeroinitializer
  %56 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %55
  %57 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %50, <4 x float> %50, <4 x float> %21) #4
  %58 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %56, <4 x float> %55, i32 %57) #4
  %59 = sitofp i32 %58 to float
  %60 = insertelement <4 x float> undef, float %59, i32 0
  %61 = shufflevector <4 x float> %60, <4 x float> undef, <4 x i32> zeroinitializer
  %62 = fmul <4 x float> %50, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %63 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %62, <4 x float> %55, <4 x float> %27) #4
  %64 = sitofp i32 %63 to float
  %65 = insertelement <4 x float> undef, float %64, i32 0
  %66 = shufflevector <4 x float> %65, <4 x float> undef, <4 x i32> zeroinitializer
  %67 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %66
  %68 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %61, <4 x float> %61, <4 x float> %21) #4
  %69 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %67, <4 x float> %66, i32 %68) #4
  %70 = sitofp i32 %69 to float
  %71 = insertelement <4 x float> undef, float %70, i32 0
  %72 = shufflevector <4 x float> %71, <4 x float> undef, <4 x i32> zeroinitializer
  %73 = fmul <4 x float> %61, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %74 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %73, <4 x float> %66, <4 x float> %27) #4
  %75 = sitofp i32 %74 to float
  %76 = insertelement <4 x float> undef, float %75, i32 0
  %77 = shufflevector <4 x float> %76, <4 x float> undef, <4 x i32> zeroinitializer
  %78 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %77
  %79 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %72, <4 x float> %72, <4 x float> %21) #4
  %80 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %78, <4 x float> %77, i32 %79) #4
  %81 = sitofp i32 %80 to float
  %82 = insertelement <4 x float> undef, float %81, i32 0
  %83 = shufflevector <4 x float> %82, <4 x float> undef, <4 x i32> zeroinitializer
  %84 = fmul <4 x float> %72, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %85 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %84, <4 x float> %77, <4 x float> %27) #4
  %86 = sitofp i32 %85 to float
  %87 = insertelement <4 x float> undef, float %86, i32 0
  %88 = shufflevector <4 x float> %87, <4 x float> undef, <4 x i32> zeroinitializer
  %89 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %88
  %90 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %83, <4 x float> %83, <4 x float> %21) #4
  %91 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %89, <4 x float> %88, i32 %90) #4
  %92 = sitofp i32 %91 to float
  %93 = insertelement <4 x float> undef, float %92, i32 0
  %94 = shufflevector <4 x float> %93, <4 x float> undef, <4 x i32> zeroinitializer
  %95 = fmul <4 x float> %83, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %96 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %95, <4 x float> %88, <4 x float> %27) #4
  %97 = sitofp i32 %96 to float
  %98 = insertelement <4 x float> undef, float %97, i32 0
  %99 = shufflevector <4 x float> %98, <4 x float> undef, <4 x i32> zeroinitializer
  %100 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %99
  %101 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %94, <4 x float> %94, <4 x float> %21) #4
  %102 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %100, <4 x float> %99, i32 %101) #4
  %103 = sitofp i32 %102 to float
  %104 = insertelement <4 x float> undef, float %103, i32 0
  %105 = shufflevector <4 x float> %104, <4 x float> undef, <4 x i32> zeroinitializer
  %106 = fmul <4 x float> %94, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %107 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %106, <4 x float> %99, <4 x float> %27) #4
  %108 = sitofp i32 %107 to float
  %109 = insertelement <4 x float> undef, float %108, i32 0
  %110 = shufflevector <4 x float> %109, <4 x float> undef, <4 x i32> zeroinitializer
  %111 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %110
  %112 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %105, <4 x float> %105, <4 x float> %21) #4
  %113 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %111, <4 x float> %110, i32 %112) #4
  %114 = sitofp i32 %113 to float
  %115 = insertelement <4 x float> undef, float %114, i32 0
  %116 = shufflevector <4 x float> %115, <4 x float> undef, <4 x i32> zeroinitializer
  %117 = fmul <4 x float> %105, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %118 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %117, <4 x float> %110, <4 x float> %27) #4
  %119 = sitofp i32 %118 to float
  %120 = insertelement <4 x float> undef, float %119, i32 0
  %121 = shufflevector <4 x float> %120, <4 x float> undef, <4 x i32> zeroinitializer
  %122 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %121
  %123 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %116, <4 x float> %116, <4 x float> %21) #4
  %124 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %122, <4 x float> %121, i32 %123) #4
  %125 = sitofp i32 %124 to float
  %126 = insertelement <4 x float> undef, float %125, i32 0
  %127 = shufflevector <4 x float> %126, <4 x float> undef, <4 x i32> zeroinitializer
  %128 = fmul <4 x float> %116, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %129 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %128, <4 x float> %121, <4 x float> %27) #4
  %130 = sitofp i32 %129 to float
  %131 = insertelement <4 x float> undef, float %130, i32 0
  %132 = shufflevector <4 x float> %131, <4 x float> undef, <4 x i32> zeroinitializer
  %133 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %132
  %134 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %127, <4 x float> %127, <4 x float> %21) #4
  %135 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %133, <4 x float> %132, i32 %134) #4
  %136 = sitofp i32 %135 to float
  %137 = insertelement <4 x float> undef, float %136, i32 0
  %138 = shufflevector <4 x float> %137, <4 x float> undef, <4 x i32> zeroinitializer
  %139 = fmul <4 x float> %127, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %140 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %139, <4 x float> %132, <4 x float> %27) #4
  %141 = sitofp i32 %140 to float
  %142 = insertelement <4 x float> undef, float %141, i32 0
  %143 = shufflevector <4 x float> %142, <4 x float> undef, <4 x i32> zeroinitializer
  %144 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %143
  %145 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %138, <4 x float> %138, <4 x float> %21) #4
  %146 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %144, <4 x float> %143, i32 %145) #4
  %147 = sitofp i32 %146 to float
  %148 = insertelement <4 x float> undef, float %147, i32 0
  %149 = shufflevector <4 x float> %148, <4 x float> undef, <4 x i32> zeroinitializer
  %150 = fmul <4 x float> %138, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %151 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %150, <4 x float> %143, <4 x float> %27) #4
  %152 = sitofp i32 %151 to float
  %153 = insertelement <4 x float> undef, float %152, i32 0
  %154 = shufflevector <4 x float> %153, <4 x float> undef, <4 x i32> zeroinitializer
  %155 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %154
  %156 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %149, <4 x float> %149, <4 x float> %21) #4
  %157 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %155, <4 x float> %154, i32 %156) #4
  %158 = sitofp i32 %157 to float
  %159 = insertelement <4 x float> undef, float %158, i32 0
  %160 = shufflevector <4 x float> %159, <4 x float> undef, <4 x i32> zeroinitializer
  %161 = fmul <4 x float> %149, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %162 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %161, <4 x float> %154, <4 x float> %27) #4
  %163 = sitofp i32 %162 to float
  %164 = insertelement <4 x float> undef, float %163, i32 0
  %165 = shufflevector <4 x float> %164, <4 x float> undef, <4 x i32> zeroinitializer
  %166 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %165
  %167 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %160, <4 x float> %160, <4 x float> %21) #4
  %168 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %166, <4 x float> %165, i32 %167) #4
  %169 = sitofp i32 %168 to float
  %170 = insertelement <4 x float> undef, float %169, i32 0
  %171 = shufflevector <4 x float> %170, <4 x float> undef, <4 x i32> zeroinitializer
  %172 = fmul <4 x float> %160, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %173 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %172, <4 x float> %165, <4 x float> %27) #4
  %174 = sitofp i32 %173 to float
  %175 = insertelement <4 x float> undef, float %174, i32 0
  %176 = shufflevector <4 x float> %175, <4 x float> undef, <4 x i32> zeroinitializer
  %177 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %176
  %178 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %171, <4 x float> %171, <4 x float> %21) #4
  %179 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %177, <4 x float> %176, i32 %178) #4
  %180 = sitofp i32 %179 to float
  %181 = insertelement <4 x float> undef, float %180, i32 0
  %182 = shufflevector <4 x float> %181, <4 x float> undef, <4 x i32> zeroinitializer
  %183 = fmul <4 x float> %171, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %184 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %183, <4 x float> %176, <4 x float> %27) #4
  %185 = sitofp i32 %184 to float
  %186 = insertelement <4 x float> undef, float %185, i32 0
  %187 = shufflevector <4 x float> %186, <4 x float> undef, <4 x i32> zeroinitializer
  %188 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %187
  %189 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %182, <4 x float> %182, <4 x float> %21) #4
  %190 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %188, <4 x float> %187, i32 %189) #4
  %191 = sitofp i32 %190 to float
  %192 = insertelement <4 x float> undef, float %191, i32 0
  %193 = shufflevector <4 x float> %192, <4 x float> undef, <4 x i32> zeroinitializer
  %194 = fmul <4 x float> %182, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %195 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %194, <4 x float> %187, <4 x float> %27) #4
  %196 = sitofp i32 %195 to float
  %197 = insertelement <4 x float> undef, float %196, i32 0
  %198 = shufflevector <4 x float> %197, <4 x float> undef, <4 x i32> zeroinitializer
  %199 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %198
  %200 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %193, <4 x float> %193, <4 x float> %21) #4
  %201 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %199, <4 x float> %198, i32 %200) #4
  %202 = sitofp i32 %201 to float
  %203 = insertelement <4 x float> undef, float %202, i32 0
  %204 = shufflevector <4 x float> %203, <4 x float> undef, <4 x i32> zeroinitializer
  %205 = fmul <4 x float> %193, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %206 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %205, <4 x float> %198, <4 x float> %27) #4
  %207 = sitofp i32 %206 to float
  %208 = insertelement <4 x float> undef, float %207, i32 0
  %209 = shufflevector <4 x float> %208, <4 x float> undef, <4 x i32> zeroinitializer
  %210 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %209
  %211 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %204, <4 x float> %204, <4 x float> %21) #4
  %212 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %210, <4 x float> %209, i32 %211) #4
  %213 = sitofp i32 %212 to float
  %214 = fmul <4 x float> %204, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %215 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %214, <4 x float> %209, <4 x float> %27) #4
  %216 = sitofp i32 %215 to float
  %217 = fmul float %216, %216
  %218 = tail call float @llvm.fmuladd.f32(float %213, float %213, float %217)
  %219 = fcmp ole float %218, 4.000000e+00
  %220 = zext i1 %219 to i32
  %221 = insertelement <4 x i32> undef, i32 %220, i32 0
  %222 = insertelement <4 x i32> %221, i32 %220, i32 1
  %223 = insertelement <4 x i32> %222, i32 %220, i32 2
  %224 = insertelement <4 x i32> %223, i32 %220, i32 3
  %savx.0.elt = extractelement <4 x float> %savx.039, i32 0
  %225 = select i1 %219, float %213, float %savx.0.elt
  %226 = insertelement <4 x float> undef, float %225, i32 0
  %.elt23 = extractelement <4 x float> %savx.039, i32 1
  %227 = select i1 %219, float %213, float %.elt23
  %228 = insertelement <4 x float> %226, float %227, i32 1
  %.elt24 = extractelement <4 x float> %savx.039, i32 2
  %229 = select i1 %219, float %213, float %.elt24
  %230 = insertelement <4 x float> %228, float %229, i32 2
  %.elt25 = extractelement <4 x float> %savx.039, i32 3
  %231 = select i1 %219, float %213, float %.elt25
  %232 = insertelement <4 x float> %230, float %231, i32 3
  %savy.0.elt = extractelement <4 x float> %savy.040, i32 0
  %233 = select i1 %219, float %216, float %savy.0.elt
  %234 = insertelement <4 x float> undef, float %233, i32 0
  %.elt26 = extractelement <4 x float> %savy.040, i32 1
  %235 = select i1 %219, float %216, float %.elt26
  %236 = insertelement <4 x float> %234, float %235, i32 1
  %.elt27 = extractelement <4 x float> %savy.040, i32 2
  %237 = select i1 %219, float %216, float %.elt27
  %238 = insertelement <4 x float> %236, float %237, i32 2
  %.elt28 = extractelement <4 x float> %savy.040, i32 3
  %239 = select i1 %219, float %216, float %.elt28
  %240 = insertelement <4 x float> %238, float %239, i32 3
  %241 = shl <4 x i32> %224, <i32 4, i32 4, i32 4, i32 4>
  %242 = add <4 x i32> %ccount.038, %241
  %243 = add i32 %iter.037, 16
  %244 = icmp ult i32 %243, %maxIterations
  %or.cond29 = and i1 %219, %244
  br i1 %or.cond29, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %0
  %.lcssa35 = phi i32 [ %40, %0 ], [ %220, %.lr.ph ]
  %.lcssa34 = phi i32 [ %37, %0 ], [ %220, %.lr.ph ]
  %.lcssa33 = phi i32 [ %34, %0 ], [ %220, %.lr.ph ]
  %.lcssa32 = phi i32 [ %31, %0 ], [ %220, %.lr.ph ]
  %savy.0.lcssa = phi <4 x float> [ %27, %0 ], [ %240, %.lr.ph ]
  %savx.0.lcssa = phi <4 x float> [ %21, %0 ], [ %232, %.lr.ph ]
  %ccount.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %242, %.lr.ph ]
  %245 = and i32 %.lcssa32, %.lcssa33
  %246 = and i32 %245, %.lcssa34
  %247 = and i32 %246, %.lcssa35
  %248 = icmp eq i32 %247, 0
  br i1 %248, label %.preheader, label %.critedge

.preheader:                                       ; preds = %._crit_edge, %293
  %iter.1 = phi i32 [ %305, %293 ], [ 16, %._crit_edge ]
  %ccount.1 = phi <4 x i32> [ %304, %293 ], [ %ccount.0.lcssa, %._crit_edge ]
  %savx.1 = phi <4 x float> [ %313, %293 ], [ %savx.0.lcssa, %._crit_edge ]
  %savy.1 = phi <4 x float> [ %321, %293 ], [ %savy.0.lcssa, %._crit_edge ]
  %249 = extractelement <4 x float> %savx.1, i32 0
  %250 = extractelement <4 x float> %savy.1, i32 0
  %251 = fmul float %250, %250
  %252 = tail call float @llvm.fmuladd.f32(float %249, float %249, float %251)
  %253 = fcmp ugt float %252, 4.000000e+00
  br i1 %253, label %257, label %254

; <label>:254                                     ; preds = %.preheader
  %255 = extractelement <4 x i32> %ccount.1, i32 0
  %256 = icmp ult i32 %255, %maxIterations
  br label %257

; <label>:257                                     ; preds = %.preheader, %254
  %258 = phi i1 [ false, %.preheader ], [ %256, %254 ]
  %259 = zext i1 %258 to i32
  %260 = insertelement <4 x i32> undef, i32 %259, i32 0
  %261 = extractelement <4 x float> %savx.1, i32 1
  %262 = extractelement <4 x float> %savy.1, i32 1
  %263 = fmul float %262, %262
  %264 = tail call float @llvm.fmuladd.f32(float %261, float %261, float %263)
  %265 = fcmp ugt float %264, 4.000000e+00
  br i1 %265, label %269, label %266

; <label>:266                                     ; preds = %257
  %267 = extractelement <4 x i32> %ccount.1, i32 1
  %268 = icmp ult i32 %267, %maxIterations
  br label %269

; <label>:269                                     ; preds = %257, %266
  %270 = phi i1 [ false, %257 ], [ %268, %266 ]
  %271 = zext i1 %270 to i32
  %272 = insertelement <4 x i32> %260, i32 %271, i32 1
  %273 = extractelement <4 x float> %savx.1, i32 2
  %274 = extractelement <4 x float> %savy.1, i32 2
  %275 = fmul float %274, %274
  %276 = tail call float @llvm.fmuladd.f32(float %273, float %273, float %275)
  %277 = fcmp ugt float %276, 4.000000e+00
  br i1 %277, label %281, label %278

; <label>:278                                     ; preds = %269
  %279 = extractelement <4 x i32> %ccount.1, i32 2
  %280 = icmp ult i32 %279, %maxIterations
  br label %281

; <label>:281                                     ; preds = %269, %278
  %282 = phi i1 [ false, %269 ], [ %280, %278 ]
  %283 = zext i1 %282 to i32
  %284 = insertelement <4 x i32> %272, i32 %283, i32 2
  %285 = extractelement <4 x float> %savx.1, i32 3
  %286 = extractelement <4 x float> %savy.1, i32 3
  %287 = fmul float %286, %286
  %288 = tail call float @llvm.fmuladd.f32(float %285, float %285, float %287)
  %289 = fcmp ugt float %288, 4.000000e+00
  br i1 %289, label %293, label %290

; <label>:290                                     ; preds = %281
  %291 = extractelement <4 x i32> %ccount.1, i32 3
  %292 = icmp ult i32 %291, %maxIterations
  br label %293

; <label>:293                                     ; preds = %281, %290
  %294 = phi i1 [ false, %281 ], [ %292, %290 ]
  %295 = zext i1 %294 to i32
  %296 = insertelement <4 x i32> %284, i32 %295, i32 3
  %297 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.1
  %298 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %savx.1, <4 x float> %savx.1, <4 x float> %21) #4
  %299 = tail call i32 (<4 x float>, <4 x float>, i32, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32, ...)*)(<4 x float> %297, <4 x float> %savy.1, i32 %298) #4
  %300 = sitofp i32 %299 to float
  %301 = fmul <4 x float> %savx.1, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %302 = tail call i32 (<4 x float>, <4 x float>, <4 x float>, ...)* bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>, ...)*)(<4 x float> %301, <4 x float> %savy.1, <4 x float> %27) #4
  %303 = sitofp i32 %302 to float
  %304 = add <4 x i32> %ccount.1, %296
  %305 = add i32 %iter.1, -1
  %306 = select i1 %258, float %300, float %249
  %307 = insertelement <4 x float> undef, float %306, i32 0
  %308 = select i1 %270, float %300, float %261
  %309 = insertelement <4 x float> %307, float %308, i32 1
  %310 = select i1 %282, float %300, float %273
  %311 = insertelement <4 x float> %309, float %310, i32 2
  %312 = select i1 %294, float %300, float %285
  %313 = insertelement <4 x float> %311, float %312, i32 3
  %314 = select i1 %258, float %303, float %250
  %315 = insertelement <4 x float> undef, float %314, i32 0
  %316 = select i1 %270, float %303, float %262
  %317 = insertelement <4 x float> %315, float %316, i32 1
  %318 = select i1 %282, float %303, float %274
  %319 = insertelement <4 x float> %317, float %318, i32 2
  %320 = select i1 %294, float %303, float %286
  %321 = insertelement <4 x float> %319, float %320, i32 3
  %322 = or i1 %258, %270
  %323 = or i1 %322, %282
  %324 = or i1 %323, %294
  %325 = icmp ne i32 %305, 0
  %or.cond = and i1 %324, %325
  br i1 %or.cond, label %.preheader, label %.critedge

.critedge:                                        ; preds = %293, %._crit_edge
  %ccount.2 = phi <4 x i32> [ %ccount.0.lcssa, %._crit_edge ], [ %304, %293 ]
  %savx.2 = phi <4 x float> [ %savx.0.lcssa, %._crit_edge ], [ %313, %293 ]
  %savy.2 = phi <4 x float> [ %savy.0.lcssa, %._crit_edge ], [ %321, %293 ]
  %326 = tail call <4 x float> @_Z14convert_float4Dv4_i(<4 x i32> %ccount.2) #4
  %327 = extractelement <4 x i32> %ccount.2, i32 0
  %328 = sitofp i32 %327 to float
  %329 = fadd float %328, 1.000000e+00
  %330 = extractelement <4 x float> %savx.2, i32 0
  %331 = extractelement <4 x float> %savy.2, i32 0
  %332 = fmul float %331, %331
  %333 = tail call float @llvm.fmuladd.f32(float %330, float %330, float %332)
  %334 = tail call float @llvm.log2.f32(float %333)
  %335 = tail call float @llvm.log2.f32(float %334)
  %336 = fsub float %329, %335
  %337 = extractelement <4 x i32> %ccount.2, i32 1
  %338 = sitofp i32 %337 to float
  %339 = fadd float %338, 1.000000e+00
  %340 = extractelement <4 x float> %savx.2, i32 1
  %341 = extractelement <4 x float> %savy.2, i32 1
  %342 = fmul float %341, %341
  %343 = tail call float @llvm.fmuladd.f32(float %340, float %340, float %342)
  %344 = tail call float @llvm.log2.f32(float %343)
  %345 = tail call float @llvm.log2.f32(float %344)
  %346 = fsub float %339, %345
  %347 = extractelement <4 x i32> %ccount.2, i32 2
  %348 = sitofp i32 %347 to float
  %349 = fadd float %348, 1.000000e+00
  %350 = extractelement <4 x float> %savx.2, i32 2
  %351 = extractelement <4 x float> %savy.2, i32 2
  %352 = fmul float %351, %351
  %353 = tail call float @llvm.fmuladd.f32(float %350, float %350, float %352)
  %354 = tail call float @llvm.log2.f32(float %353)
  %355 = tail call float @llvm.log2.f32(float %354)
  %356 = fsub float %349, %355
  %357 = extractelement <4 x i32> %ccount.2, i32 3
  %358 = sitofp i32 %357 to float
  %359 = fadd float %358, 1.000000e+00
  %360 = extractelement <4 x float> %savx.2, i32 3
  %361 = extractelement <4 x float> %savy.2, i32 3
  %362 = fmul float %361, %361
  %363 = tail call float @llvm.fmuladd.f32(float %360, float %360, float %362)
  %364 = tail call float @llvm.log2.f32(float %363)
  %365 = tail call float @llvm.log2.f32(float %364)
  %366 = fsub float %359, %365
  %367 = fmul float %336, 2.000000e+00
  %368 = fmul float %367, 0x400921FF20000000
  %369 = fmul float %368, 3.906250e-03
  %370 = tail call float @_Z3cosf(float %369) #4
  %371 = fadd float %370, 1.000000e+00
  %372 = fmul float %371, 5.000000e-01
  %373 = fmul float %372, 2.550000e+02
  %374 = fptoui float %373 to i8
  %375 = insertelement <4 x i8> undef, i8 %374, i32 0
  %376 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %369, float 0x4000C154C0000000)
  %377 = tail call float @_Z3cosf(float %376) #4
  %378 = fadd float %377, 1.000000e+00
  %379 = fmul float %378, 5.000000e-01
  %380 = fmul float %379, 2.550000e+02
  %381 = fptoui float %380 to i8
  %382 = insertelement <4 x i8> %375, i8 %381, i32 1
  %383 = fadd float %369, 0xC000C154C0000000
  %384 = tail call float @_Z3cosf(float %383) #4
  %385 = fadd float %384, 1.000000e+00
  %386 = fmul float %385, 5.000000e-01
  %387 = fmul float %386, 2.550000e+02
  %388 = fptoui float %387 to i8
  %389 = insertelement <4 x i8> %382, i8 %388, i32 2
  %390 = insertelement <4 x i8> %389, i8 -1, i32 3
  %391 = icmp eq i32 %327, %maxIterations
  br i1 %391, label %392, label %396

; <label>:392                                     ; preds = %.critedge
  %393 = insertelement <4 x i8> %390, i8 0, i32 0
  %394 = insertelement <4 x i8> %393, i8 0, i32 1
  %395 = insertelement <4 x i8> %394, i8 0, i32 2
  br label %396

; <label>:396                                     ; preds = %392, %.critedge
  %color.sroa.0.0 = phi <4 x i8> [ %395, %392 ], [ %390, %.critedge ]
  %397 = icmp ne i32 %bench, 0
  br i1 %397, label %398, label %410

; <label>:398                                     ; preds = %396
  %399 = trunc i32 %327 to i8
  %400 = insertelement <4 x i8> undef, i8 %399, i32 0
  %401 = lshr i32 %327, 8
  %402 = trunc i32 %401 to i8
  %403 = insertelement <4 x i8> %400, i8 %402, i32 1
  %404 = lshr i32 %327, 16
  %405 = trunc i32 %404 to i8
  %406 = insertelement <4 x i8> %403, i8 %405, i32 2
  %407 = lshr i32 %327, 24
  %408 = trunc i32 %407 to i8
  %409 = insertelement <4 x i8> %406, i8 %408, i32 3
  br label %410

; <label>:410                                     ; preds = %398, %396
  %color.sroa.0.1 = phi <4 x i8> [ %409, %398 ], [ %color.sroa.0.0, %396 ]
  %411 = shl nsw i32 %2, 2
  %412 = sext i32 %411 to i64
  %413 = getelementptr inbounds <4 x i8>* %mandelbrotImage, i64 %412
  store <4 x i8> %color.sroa.0.1, <4 x i8>* %413, align 4, !tbaa !2
  %414 = fmul float %346, 2.000000e+00
  %415 = fmul float %414, 0x400921FF20000000
  %416 = fmul float %415, 3.906250e-03
  %417 = tail call float @_Z3cosf(float %416) #4
  %418 = fadd float %417, 1.000000e+00
  %419 = fmul float %418, 5.000000e-01
  %420 = fmul float %419, 2.550000e+02
  %421 = fptoui float %420 to i8
  %422 = insertelement <4 x i8> undef, i8 %421, i32 0
  %423 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %416, float 0x4000C154C0000000)
  %424 = tail call float @_Z3cosf(float %423) #4
  %425 = fadd float %424, 1.000000e+00
  %426 = fmul float %425, 5.000000e-01
  %427 = fmul float %426, 2.550000e+02
  %428 = fptoui float %427 to i8
  %429 = insertelement <4 x i8> %422, i8 %428, i32 1
  %430 = fadd float %416, 0xC000C154C0000000
  %431 = tail call float @_Z3cosf(float %430) #4
  %432 = fadd float %431, 1.000000e+00
  %433 = fmul float %432, 5.000000e-01
  %434 = fmul float %433, 2.550000e+02
  %435 = fptoui float %434 to i8
  %436 = insertelement <4 x i8> %429, i8 %435, i32 2
  %437 = insertelement <4 x i8> %436, i8 -1, i32 3
  %438 = icmp eq i32 %337, %maxIterations
  br i1 %438, label %439, label %443

; <label>:439                                     ; preds = %410
  %440 = insertelement <4 x i8> %437, i8 0, i32 0
  %441 = insertelement <4 x i8> %440, i8 0, i32 1
  %442 = insertelement <4 x i8> %441, i8 0, i32 2
  br label %443

; <label>:443                                     ; preds = %439, %410
  %color.sroa.23.0 = phi <4 x i8> [ %442, %439 ], [ %437, %410 ]
  br i1 %397, label %444, label %456

; <label>:444                                     ; preds = %443
  %445 = trunc i32 %337 to i8
  %446 = insertelement <4 x i8> undef, i8 %445, i32 0
  %447 = lshr i32 %337, 8
  %448 = trunc i32 %447 to i8
  %449 = insertelement <4 x i8> %446, i8 %448, i32 1
  %450 = lshr i32 %337, 16
  %451 = trunc i32 %450 to i8
  %452 = insertelement <4 x i8> %449, i8 %451, i32 2
  %453 = lshr i32 %337, 24
  %454 = trunc i32 %453 to i8
  %455 = insertelement <4 x i8> %452, i8 %454, i32 3
  br label %456

; <label>:456                                     ; preds = %444, %443
  %color.sroa.23.1 = phi <4 x i8> [ %455, %444 ], [ %color.sroa.23.0, %443 ]
  %457 = or i32 %411, 1
  %458 = sext i32 %457 to i64
  %459 = getelementptr inbounds <4 x i8>* %mandelbrotImage, i64 %458
  store <4 x i8> %color.sroa.23.1, <4 x i8>* %459, align 4, !tbaa !2
  %460 = fmul float %356, 2.000000e+00
  %461 = fmul float %460, 0x400921FF20000000
  %462 = fmul float %461, 3.906250e-03
  %463 = tail call float @_Z3cosf(float %462) #4
  %464 = fadd float %463, 1.000000e+00
  %465 = fmul float %464, 5.000000e-01
  %466 = fmul float %465, 2.550000e+02
  %467 = fptoui float %466 to i8
  %468 = insertelement <4 x i8> undef, i8 %467, i32 0
  %469 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %462, float 0x4000C154C0000000)
  %470 = tail call float @_Z3cosf(float %469) #4
  %471 = fadd float %470, 1.000000e+00
  %472 = fmul float %471, 5.000000e-01
  %473 = fmul float %472, 2.550000e+02
  %474 = fptoui float %473 to i8
  %475 = insertelement <4 x i8> %468, i8 %474, i32 1
  %476 = fadd float %462, 0xC000C154C0000000
  %477 = tail call float @_Z3cosf(float %476) #4
  %478 = fadd float %477, 1.000000e+00
  %479 = fmul float %478, 5.000000e-01
  %480 = fmul float %479, 2.550000e+02
  %481 = fptoui float %480 to i8
  %482 = insertelement <4 x i8> %475, i8 %481, i32 2
  %483 = insertelement <4 x i8> %482, i8 -1, i32 3
  %484 = icmp eq i32 %347, %maxIterations
  br i1 %484, label %485, label %489

; <label>:485                                     ; preds = %456
  %486 = insertelement <4 x i8> %483, i8 0, i32 0
  %487 = insertelement <4 x i8> %486, i8 0, i32 1
  %488 = insertelement <4 x i8> %487, i8 0, i32 2
  br label %489

; <label>:489                                     ; preds = %485, %456
  %color.sroa.46.0 = phi <4 x i8> [ %488, %485 ], [ %483, %456 ]
  br i1 %397, label %490, label %502

; <label>:490                                     ; preds = %489
  %491 = trunc i32 %347 to i8
  %492 = insertelement <4 x i8> undef, i8 %491, i32 0
  %493 = lshr i32 %347, 8
  %494 = trunc i32 %493 to i8
  %495 = insertelement <4 x i8> %492, i8 %494, i32 1
  %496 = lshr i32 %347, 16
  %497 = trunc i32 %496 to i8
  %498 = insertelement <4 x i8> %495, i8 %497, i32 2
  %499 = lshr i32 %347, 24
  %500 = trunc i32 %499 to i8
  %501 = insertelement <4 x i8> %498, i8 %500, i32 3
  br label %502

; <label>:502                                     ; preds = %490, %489
  %color.sroa.46.1 = phi <4 x i8> [ %501, %490 ], [ %color.sroa.46.0, %489 ]
  %503 = or i32 %411, 2
  %504 = sext i32 %503 to i64
  %505 = getelementptr inbounds <4 x i8>* %mandelbrotImage, i64 %504
  store <4 x i8> %color.sroa.46.1, <4 x i8>* %505, align 4, !tbaa !2
  %506 = fmul float %366, 2.000000e+00
  %507 = fmul float %506, 0x400921FF20000000
  %508 = fmul float %507, 3.906250e-03
  %509 = tail call float @_Z3cosf(float %508) #4
  %510 = fadd float %509, 1.000000e+00
  %511 = fmul float %510, 5.000000e-01
  %512 = fmul float %511, 2.550000e+02
  %513 = fptoui float %512 to i8
  %514 = insertelement <4 x i8> undef, i8 %513, i32 0
  %515 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %508, float 0x4000C154C0000000)
  %516 = tail call float @_Z3cosf(float %515) #4
  %517 = fadd float %516, 1.000000e+00
  %518 = fmul float %517, 5.000000e-01
  %519 = fmul float %518, 2.550000e+02
  %520 = fptoui float %519 to i8
  %521 = insertelement <4 x i8> %514, i8 %520, i32 1
  %522 = fadd float %508, 0xC000C154C0000000
  %523 = tail call float @_Z3cosf(float %522) #4
  %524 = fadd float %523, 1.000000e+00
  %525 = fmul float %524, 5.000000e-01
  %526 = fmul float %525, 2.550000e+02
  %527 = fptoui float %526 to i8
  %528 = insertelement <4 x i8> %521, i8 %527, i32 2
  %529 = insertelement <4 x i8> %528, i8 -1, i32 3
  %530 = icmp eq i32 %357, %maxIterations
  br i1 %530, label %531, label %535

; <label>:531                                     ; preds = %502
  %532 = insertelement <4 x i8> %529, i8 0, i32 0
  %533 = insertelement <4 x i8> %532, i8 0, i32 1
  %534 = insertelement <4 x i8> %533, i8 0, i32 2
  br label %535

; <label>:535                                     ; preds = %531, %502
  %color.sroa.69.0 = phi <4 x i8> [ %534, %531 ], [ %529, %502 ]
  br i1 %397, label %536, label %548

; <label>:536                                     ; preds = %535
  %537 = trunc i32 %357 to i8
  %538 = insertelement <4 x i8> undef, i8 %537, i32 0
  %539 = lshr i32 %357, 8
  %540 = trunc i32 %539 to i8
  %541 = insertelement <4 x i8> %538, i8 %540, i32 1
  %542 = lshr i32 %357, 16
  %543 = trunc i32 %542 to i8
  %544 = insertelement <4 x i8> %541, i8 %543, i32 2
  %545 = lshr i32 %357, 24
  %546 = trunc i32 %545 to i8
  %547 = insertelement <4 x i8> %544, i8 %546, i32 3
  br label %548

; <label>:548                                     ; preds = %536, %535
  %color.sroa.69.1 = phi <4 x i8> [ %547, %536 ], [ %color.sroa.69.0, %535 ]
  %549 = or i32 %411, 3
  %550 = sext i32 %549 to i64
  %551 = getelementptr inbounds <4 x i8>* %mandelbrotImage, i64 %550
  store <4 x i8> %color.sroa.69.1, <4 x i8>* %551, align 4, !tbaa !2
  ret void
}

declare i64 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare i32 @MUL_ADD(...) #1

declare <4 x float> @_Z14convert_float4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #3

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8>*, float, float, float, float, i32, i32, i32)* @mandelbrot_vector_float}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

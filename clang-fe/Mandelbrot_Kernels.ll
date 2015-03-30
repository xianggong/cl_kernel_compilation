; ModuleID = '../kernel-src/Mandelbrot_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @mandelbrot_vector_float(<4 x i8> addrspace(1)* nocapture %mandelbrotImage, float %posx, float %posy, float %stepSizeX, float %stepSizeY, i32 %maxIterations, i32 %width, i32 %bench) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #4
  %2 = sdiv i32 %width, 4
  %3 = srem i32 %1, %2
  %4 = sdiv i32 %1, %2
  %5 = shl nsw i32 %3, 2
  %6 = or i32 %5, 1
  %7 = or i32 %5, 2
  %8 = or i32 %5, 3
  %9 = sitofp i32 %5 to float
  %10 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %9, float %posx)
  %11 = insertelement <4 x float> undef, float %10, i32 0
  %12 = sitofp i32 %6 to float
  %13 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %12, float %posx)
  %14 = insertelement <4 x float> %11, float %13, i32 1
  %15 = sitofp i32 %7 to float
  %16 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %15, float %posx)
  %17 = insertelement <4 x float> %14, float %16, i32 2
  %18 = sitofp i32 %8 to float
  %19 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %18, float %posx)
  %20 = insertelement <4 x float> %17, float %19, i32 3
  %21 = sitofp i32 %4 to float
  %22 = tail call float @llvm.fmuladd.f32(float %stepSizeY, float %21, float %posy)
  %23 = insertelement <4 x float> undef, float %22, i32 0
  %24 = insertelement <4 x float> %23, float %22, i32 1
  %25 = insertelement <4 x float> %24, float %22, i32 2
  %26 = insertelement <4 x float> %25, float %22, i32 3
  %27 = fmul float %22, %22
  %28 = tail call float @llvm.fmuladd.f32(float %10, float %10, float %27)
  %29 = fcmp ole float %28, 4.000000e+00
  %30 = zext i1 %29 to i32
  %31 = tail call float @llvm.fmuladd.f32(float %13, float %13, float %27)
  %32 = fcmp ole float %31, 4.000000e+00
  %33 = zext i1 %32 to i32
  %34 = tail call float @llvm.fmuladd.f32(float %16, float %16, float %27)
  %35 = fcmp ole float %34, 4.000000e+00
  %36 = zext i1 %35 to i32
  %37 = tail call float @llvm.fmuladd.f32(float %19, float %19, float %27)
  %38 = fcmp ole float %37, 4.000000e+00
  %39 = zext i1 %38 to i32
  %40 = or i1 %29, %32
  %41 = or i1 %40, %35
  %42 = or i1 %41, %38
  %43 = icmp ne i32 %maxIterations, 0
  %or.cond2936 = and i1 %42, %43
  br i1 %or.cond2936, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %.lr.ph
  %savy.040 = phi <4 x float> [ %239, %.lr.ph ], [ %26, %0 ]
  %savx.039 = phi <4 x float> [ %231, %.lr.ph ], [ %20, %0 ]
  %ccount.038 = phi <4 x i32> [ %241, %.lr.ph ], [ zeroinitializer, %0 ]
  %iter.037 = phi i32 [ %242, %.lr.ph ], [ 0, %0 ]
  %44 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.040
  %45 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %savx.039, <4 x float> %savx.039, <4 x float> %20) #4
  %46 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %44, <4 x float> %savy.040, i32 %45) #4
  %47 = sitofp i32 %46 to float
  %48 = insertelement <4 x float> undef, float %47, i32 0
  %49 = shufflevector <4 x float> %48, <4 x float> undef, <4 x i32> zeroinitializer
  %50 = fmul <4 x float> %savx.039, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %51 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %50, <4 x float> %savy.040, <4 x float> %26) #4
  %52 = sitofp i32 %51 to float
  %53 = insertelement <4 x float> undef, float %52, i32 0
  %54 = shufflevector <4 x float> %53, <4 x float> undef, <4 x i32> zeroinitializer
  %55 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %54
  %56 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %49, <4 x float> %49, <4 x float> %20) #4
  %57 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %55, <4 x float> %54, i32 %56) #4
  %58 = sitofp i32 %57 to float
  %59 = insertelement <4 x float> undef, float %58, i32 0
  %60 = shufflevector <4 x float> %59, <4 x float> undef, <4 x i32> zeroinitializer
  %61 = fmul <4 x float> %49, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %62 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %61, <4 x float> %54, <4 x float> %26) #4
  %63 = sitofp i32 %62 to float
  %64 = insertelement <4 x float> undef, float %63, i32 0
  %65 = shufflevector <4 x float> %64, <4 x float> undef, <4 x i32> zeroinitializer
  %66 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %65
  %67 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %60, <4 x float> %60, <4 x float> %20) #4
  %68 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %66, <4 x float> %65, i32 %67) #4
  %69 = sitofp i32 %68 to float
  %70 = insertelement <4 x float> undef, float %69, i32 0
  %71 = shufflevector <4 x float> %70, <4 x float> undef, <4 x i32> zeroinitializer
  %72 = fmul <4 x float> %60, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %73 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %72, <4 x float> %65, <4 x float> %26) #4
  %74 = sitofp i32 %73 to float
  %75 = insertelement <4 x float> undef, float %74, i32 0
  %76 = shufflevector <4 x float> %75, <4 x float> undef, <4 x i32> zeroinitializer
  %77 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %76
  %78 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %71, <4 x float> %71, <4 x float> %20) #4
  %79 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %77, <4 x float> %76, i32 %78) #4
  %80 = sitofp i32 %79 to float
  %81 = insertelement <4 x float> undef, float %80, i32 0
  %82 = shufflevector <4 x float> %81, <4 x float> undef, <4 x i32> zeroinitializer
  %83 = fmul <4 x float> %71, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %84 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %83, <4 x float> %76, <4 x float> %26) #4
  %85 = sitofp i32 %84 to float
  %86 = insertelement <4 x float> undef, float %85, i32 0
  %87 = shufflevector <4 x float> %86, <4 x float> undef, <4 x i32> zeroinitializer
  %88 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %87
  %89 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %82, <4 x float> %82, <4 x float> %20) #4
  %90 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %88, <4 x float> %87, i32 %89) #4
  %91 = sitofp i32 %90 to float
  %92 = insertelement <4 x float> undef, float %91, i32 0
  %93 = shufflevector <4 x float> %92, <4 x float> undef, <4 x i32> zeroinitializer
  %94 = fmul <4 x float> %82, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %95 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %94, <4 x float> %87, <4 x float> %26) #4
  %96 = sitofp i32 %95 to float
  %97 = insertelement <4 x float> undef, float %96, i32 0
  %98 = shufflevector <4 x float> %97, <4 x float> undef, <4 x i32> zeroinitializer
  %99 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %98
  %100 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %93, <4 x float> %93, <4 x float> %20) #4
  %101 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %99, <4 x float> %98, i32 %100) #4
  %102 = sitofp i32 %101 to float
  %103 = insertelement <4 x float> undef, float %102, i32 0
  %104 = shufflevector <4 x float> %103, <4 x float> undef, <4 x i32> zeroinitializer
  %105 = fmul <4 x float> %93, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %106 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %105, <4 x float> %98, <4 x float> %26) #4
  %107 = sitofp i32 %106 to float
  %108 = insertelement <4 x float> undef, float %107, i32 0
  %109 = shufflevector <4 x float> %108, <4 x float> undef, <4 x i32> zeroinitializer
  %110 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %109
  %111 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %104, <4 x float> %104, <4 x float> %20) #4
  %112 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %110, <4 x float> %109, i32 %111) #4
  %113 = sitofp i32 %112 to float
  %114 = insertelement <4 x float> undef, float %113, i32 0
  %115 = shufflevector <4 x float> %114, <4 x float> undef, <4 x i32> zeroinitializer
  %116 = fmul <4 x float> %104, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %117 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %116, <4 x float> %109, <4 x float> %26) #4
  %118 = sitofp i32 %117 to float
  %119 = insertelement <4 x float> undef, float %118, i32 0
  %120 = shufflevector <4 x float> %119, <4 x float> undef, <4 x i32> zeroinitializer
  %121 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %120
  %122 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %115, <4 x float> %115, <4 x float> %20) #4
  %123 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %121, <4 x float> %120, i32 %122) #4
  %124 = sitofp i32 %123 to float
  %125 = insertelement <4 x float> undef, float %124, i32 0
  %126 = shufflevector <4 x float> %125, <4 x float> undef, <4 x i32> zeroinitializer
  %127 = fmul <4 x float> %115, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %128 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %127, <4 x float> %120, <4 x float> %26) #4
  %129 = sitofp i32 %128 to float
  %130 = insertelement <4 x float> undef, float %129, i32 0
  %131 = shufflevector <4 x float> %130, <4 x float> undef, <4 x i32> zeroinitializer
  %132 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %131
  %133 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %126, <4 x float> %126, <4 x float> %20) #4
  %134 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %132, <4 x float> %131, i32 %133) #4
  %135 = sitofp i32 %134 to float
  %136 = insertelement <4 x float> undef, float %135, i32 0
  %137 = shufflevector <4 x float> %136, <4 x float> undef, <4 x i32> zeroinitializer
  %138 = fmul <4 x float> %126, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %139 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %138, <4 x float> %131, <4 x float> %26) #4
  %140 = sitofp i32 %139 to float
  %141 = insertelement <4 x float> undef, float %140, i32 0
  %142 = shufflevector <4 x float> %141, <4 x float> undef, <4 x i32> zeroinitializer
  %143 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %142
  %144 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %137, <4 x float> %137, <4 x float> %20) #4
  %145 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %143, <4 x float> %142, i32 %144) #4
  %146 = sitofp i32 %145 to float
  %147 = insertelement <4 x float> undef, float %146, i32 0
  %148 = shufflevector <4 x float> %147, <4 x float> undef, <4 x i32> zeroinitializer
  %149 = fmul <4 x float> %137, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %150 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %149, <4 x float> %142, <4 x float> %26) #4
  %151 = sitofp i32 %150 to float
  %152 = insertelement <4 x float> undef, float %151, i32 0
  %153 = shufflevector <4 x float> %152, <4 x float> undef, <4 x i32> zeroinitializer
  %154 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %153
  %155 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %148, <4 x float> %148, <4 x float> %20) #4
  %156 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %154, <4 x float> %153, i32 %155) #4
  %157 = sitofp i32 %156 to float
  %158 = insertelement <4 x float> undef, float %157, i32 0
  %159 = shufflevector <4 x float> %158, <4 x float> undef, <4 x i32> zeroinitializer
  %160 = fmul <4 x float> %148, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %161 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %160, <4 x float> %153, <4 x float> %26) #4
  %162 = sitofp i32 %161 to float
  %163 = insertelement <4 x float> undef, float %162, i32 0
  %164 = shufflevector <4 x float> %163, <4 x float> undef, <4 x i32> zeroinitializer
  %165 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %164
  %166 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %159, <4 x float> %159, <4 x float> %20) #4
  %167 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %165, <4 x float> %164, i32 %166) #4
  %168 = sitofp i32 %167 to float
  %169 = insertelement <4 x float> undef, float %168, i32 0
  %170 = shufflevector <4 x float> %169, <4 x float> undef, <4 x i32> zeroinitializer
  %171 = fmul <4 x float> %159, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %172 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %171, <4 x float> %164, <4 x float> %26) #4
  %173 = sitofp i32 %172 to float
  %174 = insertelement <4 x float> undef, float %173, i32 0
  %175 = shufflevector <4 x float> %174, <4 x float> undef, <4 x i32> zeroinitializer
  %176 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %175
  %177 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %170, <4 x float> %170, <4 x float> %20) #4
  %178 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %176, <4 x float> %175, i32 %177) #4
  %179 = sitofp i32 %178 to float
  %180 = insertelement <4 x float> undef, float %179, i32 0
  %181 = shufflevector <4 x float> %180, <4 x float> undef, <4 x i32> zeroinitializer
  %182 = fmul <4 x float> %170, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %183 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %182, <4 x float> %175, <4 x float> %26) #4
  %184 = sitofp i32 %183 to float
  %185 = insertelement <4 x float> undef, float %184, i32 0
  %186 = shufflevector <4 x float> %185, <4 x float> undef, <4 x i32> zeroinitializer
  %187 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %186
  %188 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %181, <4 x float> %181, <4 x float> %20) #4
  %189 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %187, <4 x float> %186, i32 %188) #4
  %190 = sitofp i32 %189 to float
  %191 = insertelement <4 x float> undef, float %190, i32 0
  %192 = shufflevector <4 x float> %191, <4 x float> undef, <4 x i32> zeroinitializer
  %193 = fmul <4 x float> %181, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %194 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %193, <4 x float> %186, <4 x float> %26) #4
  %195 = sitofp i32 %194 to float
  %196 = insertelement <4 x float> undef, float %195, i32 0
  %197 = shufflevector <4 x float> %196, <4 x float> undef, <4 x i32> zeroinitializer
  %198 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %197
  %199 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %192, <4 x float> %192, <4 x float> %20) #4
  %200 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %198, <4 x float> %197, i32 %199) #4
  %201 = sitofp i32 %200 to float
  %202 = insertelement <4 x float> undef, float %201, i32 0
  %203 = shufflevector <4 x float> %202, <4 x float> undef, <4 x i32> zeroinitializer
  %204 = fmul <4 x float> %192, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %205 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %204, <4 x float> %197, <4 x float> %26) #4
  %206 = sitofp i32 %205 to float
  %207 = insertelement <4 x float> undef, float %206, i32 0
  %208 = shufflevector <4 x float> %207, <4 x float> undef, <4 x i32> zeroinitializer
  %209 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %208
  %210 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %203, <4 x float> %203, <4 x float> %20) #4
  %211 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %209, <4 x float> %208, i32 %210) #4
  %212 = sitofp i32 %211 to float
  %213 = fmul <4 x float> %203, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %214 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %213, <4 x float> %208, <4 x float> %26) #4
  %215 = sitofp i32 %214 to float
  %216 = fmul float %215, %215
  %217 = tail call float @llvm.fmuladd.f32(float %212, float %212, float %216)
  %218 = fcmp ole float %217, 4.000000e+00
  %219 = zext i1 %218 to i32
  %220 = insertelement <4 x i32> undef, i32 %219, i32 0
  %221 = insertelement <4 x i32> %220, i32 %219, i32 1
  %222 = insertelement <4 x i32> %221, i32 %219, i32 2
  %223 = insertelement <4 x i32> %222, i32 %219, i32 3
  %savx.0.elt = extractelement <4 x float> %savx.039, i32 0
  %224 = select i1 %218, float %212, float %savx.0.elt
  %225 = insertelement <4 x float> undef, float %224, i32 0
  %.elt23 = extractelement <4 x float> %savx.039, i32 1
  %226 = select i1 %218, float %212, float %.elt23
  %227 = insertelement <4 x float> %225, float %226, i32 1
  %.elt24 = extractelement <4 x float> %savx.039, i32 2
  %228 = select i1 %218, float %212, float %.elt24
  %229 = insertelement <4 x float> %227, float %228, i32 2
  %.elt25 = extractelement <4 x float> %savx.039, i32 3
  %230 = select i1 %218, float %212, float %.elt25
  %231 = insertelement <4 x float> %229, float %230, i32 3
  %savy.0.elt = extractelement <4 x float> %savy.040, i32 0
  %232 = select i1 %218, float %215, float %savy.0.elt
  %233 = insertelement <4 x float> undef, float %232, i32 0
  %.elt26 = extractelement <4 x float> %savy.040, i32 1
  %234 = select i1 %218, float %215, float %.elt26
  %235 = insertelement <4 x float> %233, float %234, i32 1
  %.elt27 = extractelement <4 x float> %savy.040, i32 2
  %236 = select i1 %218, float %215, float %.elt27
  %237 = insertelement <4 x float> %235, float %236, i32 2
  %.elt28 = extractelement <4 x float> %savy.040, i32 3
  %238 = select i1 %218, float %215, float %.elt28
  %239 = insertelement <4 x float> %237, float %238, i32 3
  %240 = shl <4 x i32> %223, <i32 4, i32 4, i32 4, i32 4>
  %241 = add <4 x i32> %ccount.038, %240
  %242 = add i32 %iter.037, 16
  %243 = icmp ult i32 %242, %maxIterations
  %or.cond29 = and i1 %218, %243
  br i1 %or.cond29, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %0
  %.lcssa35 = phi i32 [ %39, %0 ], [ %219, %.lr.ph ]
  %.lcssa34 = phi i32 [ %36, %0 ], [ %219, %.lr.ph ]
  %.lcssa33 = phi i32 [ %33, %0 ], [ %219, %.lr.ph ]
  %.lcssa32 = phi i32 [ %30, %0 ], [ %219, %.lr.ph ]
  %savy.0.lcssa = phi <4 x float> [ %26, %0 ], [ %239, %.lr.ph ]
  %savx.0.lcssa = phi <4 x float> [ %20, %0 ], [ %231, %.lr.ph ]
  %ccount.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %241, %.lr.ph ]
  %244 = and i32 %.lcssa32, %.lcssa33
  %245 = and i32 %244, %.lcssa34
  %246 = and i32 %245, %.lcssa35
  %247 = icmp eq i32 %246, 0
  br i1 %247, label %.preheader, label %.critedge

.preheader:                                       ; preds = %._crit_edge, %292
  %iter.1 = phi i32 [ %304, %292 ], [ 16, %._crit_edge ]
  %ccount.1 = phi <4 x i32> [ %303, %292 ], [ %ccount.0.lcssa, %._crit_edge ]
  %savx.1 = phi <4 x float> [ %312, %292 ], [ %savx.0.lcssa, %._crit_edge ]
  %savy.1 = phi <4 x float> [ %320, %292 ], [ %savy.0.lcssa, %._crit_edge ]
  %248 = extractelement <4 x float> %savx.1, i32 0
  %249 = extractelement <4 x float> %savy.1, i32 0
  %250 = fmul float %249, %249
  %251 = tail call float @llvm.fmuladd.f32(float %248, float %248, float %250)
  %252 = fcmp ugt float %251, 4.000000e+00
  br i1 %252, label %256, label %253

; <label>:253                                     ; preds = %.preheader
  %254 = extractelement <4 x i32> %ccount.1, i32 0
  %255 = icmp ult i32 %254, %maxIterations
  br label %256

; <label>:256                                     ; preds = %.preheader, %253
  %257 = phi i1 [ false, %.preheader ], [ %255, %253 ]
  %258 = zext i1 %257 to i32
  %259 = insertelement <4 x i32> undef, i32 %258, i32 0
  %260 = extractelement <4 x float> %savx.1, i32 1
  %261 = extractelement <4 x float> %savy.1, i32 1
  %262 = fmul float %261, %261
  %263 = tail call float @llvm.fmuladd.f32(float %260, float %260, float %262)
  %264 = fcmp ugt float %263, 4.000000e+00
  br i1 %264, label %268, label %265

; <label>:265                                     ; preds = %256
  %266 = extractelement <4 x i32> %ccount.1, i32 1
  %267 = icmp ult i32 %266, %maxIterations
  br label %268

; <label>:268                                     ; preds = %256, %265
  %269 = phi i1 [ false, %256 ], [ %267, %265 ]
  %270 = zext i1 %269 to i32
  %271 = insertelement <4 x i32> %259, i32 %270, i32 1
  %272 = extractelement <4 x float> %savx.1, i32 2
  %273 = extractelement <4 x float> %savy.1, i32 2
  %274 = fmul float %273, %273
  %275 = tail call float @llvm.fmuladd.f32(float %272, float %272, float %274)
  %276 = fcmp ugt float %275, 4.000000e+00
  br i1 %276, label %280, label %277

; <label>:277                                     ; preds = %268
  %278 = extractelement <4 x i32> %ccount.1, i32 2
  %279 = icmp ult i32 %278, %maxIterations
  br label %280

; <label>:280                                     ; preds = %268, %277
  %281 = phi i1 [ false, %268 ], [ %279, %277 ]
  %282 = zext i1 %281 to i32
  %283 = insertelement <4 x i32> %271, i32 %282, i32 2
  %284 = extractelement <4 x float> %savx.1, i32 3
  %285 = extractelement <4 x float> %savy.1, i32 3
  %286 = fmul float %285, %285
  %287 = tail call float @llvm.fmuladd.f32(float %284, float %284, float %286)
  %288 = fcmp ugt float %287, 4.000000e+00
  br i1 %288, label %292, label %289

; <label>:289                                     ; preds = %280
  %290 = extractelement <4 x i32> %ccount.1, i32 3
  %291 = icmp ult i32 %290, %maxIterations
  br label %292

; <label>:292                                     ; preds = %280, %289
  %293 = phi i1 [ false, %280 ], [ %291, %289 ]
  %294 = zext i1 %293 to i32
  %295 = insertelement <4 x i32> %283, i32 %294, i32 3
  %296 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.1
  %297 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %savx.1, <4 x float> %savx.1, <4 x float> %20) #4
  %298 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %296, <4 x float> %savy.1, i32 %297) #4
  %299 = sitofp i32 %298 to float
  %300 = fmul <4 x float> %savx.1, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %301 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %300, <4 x float> %savy.1, <4 x float> %26) #4
  %302 = sitofp i32 %301 to float
  %303 = add <4 x i32> %ccount.1, %295
  %304 = add i32 %iter.1, -1
  %305 = select i1 %257, float %299, float %248
  %306 = insertelement <4 x float> undef, float %305, i32 0
  %307 = select i1 %269, float %299, float %260
  %308 = insertelement <4 x float> %306, float %307, i32 1
  %309 = select i1 %281, float %299, float %272
  %310 = insertelement <4 x float> %308, float %309, i32 2
  %311 = select i1 %293, float %299, float %284
  %312 = insertelement <4 x float> %310, float %311, i32 3
  %313 = select i1 %257, float %302, float %249
  %314 = insertelement <4 x float> undef, float %313, i32 0
  %315 = select i1 %269, float %302, float %261
  %316 = insertelement <4 x float> %314, float %315, i32 1
  %317 = select i1 %281, float %302, float %273
  %318 = insertelement <4 x float> %316, float %317, i32 2
  %319 = select i1 %293, float %302, float %285
  %320 = insertelement <4 x float> %318, float %319, i32 3
  %321 = or i1 %257, %269
  %322 = or i1 %321, %281
  %323 = or i1 %322, %293
  %324 = icmp ne i32 %304, 0
  %or.cond = and i1 %323, %324
  br i1 %or.cond, label %.preheader, label %.critedge

.critedge:                                        ; preds = %292, %._crit_edge
  %ccount.2 = phi <4 x i32> [ %ccount.0.lcssa, %._crit_edge ], [ %303, %292 ]
  %savx.2 = phi <4 x float> [ %savx.0.lcssa, %._crit_edge ], [ %312, %292 ]
  %savy.2 = phi <4 x float> [ %savy.0.lcssa, %._crit_edge ], [ %320, %292 ]
  %325 = tail call <4 x float> @_Z14convert_float4Dv4_i(<4 x i32> %ccount.2) #4
  %326 = extractelement <4 x i32> %ccount.2, i32 0
  %327 = sitofp i32 %326 to float
  %328 = fadd float %327, 1.000000e+00
  %329 = extractelement <4 x float> %savx.2, i32 0
  %330 = extractelement <4 x float> %savy.2, i32 0
  %331 = fmul float %330, %330
  %332 = tail call float @llvm.fmuladd.f32(float %329, float %329, float %331)
  %333 = tail call float @llvm.log2.f32(float %332)
  %334 = tail call float @llvm.log2.f32(float %333)
  %335 = fsub float %328, %334
  %336 = extractelement <4 x i32> %ccount.2, i32 1
  %337 = sitofp i32 %336 to float
  %338 = fadd float %337, 1.000000e+00
  %339 = extractelement <4 x float> %savx.2, i32 1
  %340 = extractelement <4 x float> %savy.2, i32 1
  %341 = fmul float %340, %340
  %342 = tail call float @llvm.fmuladd.f32(float %339, float %339, float %341)
  %343 = tail call float @llvm.log2.f32(float %342)
  %344 = tail call float @llvm.log2.f32(float %343)
  %345 = fsub float %338, %344
  %346 = extractelement <4 x i32> %ccount.2, i32 2
  %347 = sitofp i32 %346 to float
  %348 = fadd float %347, 1.000000e+00
  %349 = extractelement <4 x float> %savx.2, i32 2
  %350 = extractelement <4 x float> %savy.2, i32 2
  %351 = fmul float %350, %350
  %352 = tail call float @llvm.fmuladd.f32(float %349, float %349, float %351)
  %353 = tail call float @llvm.log2.f32(float %352)
  %354 = tail call float @llvm.log2.f32(float %353)
  %355 = fsub float %348, %354
  %356 = extractelement <4 x i32> %ccount.2, i32 3
  %357 = sitofp i32 %356 to float
  %358 = fadd float %357, 1.000000e+00
  %359 = extractelement <4 x float> %savx.2, i32 3
  %360 = extractelement <4 x float> %savy.2, i32 3
  %361 = fmul float %360, %360
  %362 = tail call float @llvm.fmuladd.f32(float %359, float %359, float %361)
  %363 = tail call float @llvm.log2.f32(float %362)
  %364 = tail call float @llvm.log2.f32(float %363)
  %365 = fsub float %358, %364
  %366 = fmul float %335, 2.000000e+00
  %367 = fmul float %366, 0x400921FF20000000
  %368 = fmul float %367, 3.906250e-03
  %369 = tail call float @_Z3cosf(float %368) #4
  %370 = fadd float %369, 1.000000e+00
  %371 = fmul float %370, 5.000000e-01
  %372 = fmul float %371, 2.550000e+02
  %373 = fptoui float %372 to i8
  %374 = insertelement <4 x i8> undef, i8 %373, i32 0
  %375 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %368, float 0x4000C154C0000000)
  %376 = tail call float @_Z3cosf(float %375) #4
  %377 = fadd float %376, 1.000000e+00
  %378 = fmul float %377, 5.000000e-01
  %379 = fmul float %378, 2.550000e+02
  %380 = fptoui float %379 to i8
  %381 = insertelement <4 x i8> %374, i8 %380, i32 1
  %382 = fadd float %368, 0xC000C154C0000000
  %383 = tail call float @_Z3cosf(float %382) #4
  %384 = fadd float %383, 1.000000e+00
  %385 = fmul float %384, 5.000000e-01
  %386 = fmul float %385, 2.550000e+02
  %387 = fptoui float %386 to i8
  %388 = insertelement <4 x i8> %381, i8 %387, i32 2
  %389 = insertelement <4 x i8> %388, i8 -1, i32 3
  %390 = icmp eq i32 %326, %maxIterations
  br i1 %390, label %391, label %395

; <label>:391                                     ; preds = %.critedge
  %392 = insertelement <4 x i8> %389, i8 0, i32 0
  %393 = insertelement <4 x i8> %392, i8 0, i32 1
  %394 = insertelement <4 x i8> %393, i8 0, i32 2
  br label %395

; <label>:395                                     ; preds = %391, %.critedge
  %color.sroa.0.0 = phi <4 x i8> [ %394, %391 ], [ %389, %.critedge ]
  %396 = icmp ne i32 %bench, 0
  br i1 %396, label %397, label %409

; <label>:397                                     ; preds = %395
  %398 = trunc i32 %326 to i8
  %399 = insertelement <4 x i8> undef, i8 %398, i32 0
  %400 = lshr i32 %326, 8
  %401 = trunc i32 %400 to i8
  %402 = insertelement <4 x i8> %399, i8 %401, i32 1
  %403 = lshr i32 %326, 16
  %404 = trunc i32 %403 to i8
  %405 = insertelement <4 x i8> %402, i8 %404, i32 2
  %406 = lshr i32 %326, 24
  %407 = trunc i32 %406 to i8
  %408 = insertelement <4 x i8> %405, i8 %407, i32 3
  br label %409

; <label>:409                                     ; preds = %397, %395
  %color.sroa.0.1 = phi <4 x i8> [ %408, %397 ], [ %color.sroa.0.0, %395 ]
  %410 = shl nsw i32 %1, 2
  %411 = sext i32 %410 to i64
  %412 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i64 %411
  store <4 x i8> %color.sroa.0.1, <4 x i8> addrspace(1)* %412, align 4, !tbaa !2
  %413 = fmul float %345, 2.000000e+00
  %414 = fmul float %413, 0x400921FF20000000
  %415 = fmul float %414, 3.906250e-03
  %416 = tail call float @_Z3cosf(float %415) #4
  %417 = fadd float %416, 1.000000e+00
  %418 = fmul float %417, 5.000000e-01
  %419 = fmul float %418, 2.550000e+02
  %420 = fptoui float %419 to i8
  %421 = insertelement <4 x i8> undef, i8 %420, i32 0
  %422 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %415, float 0x4000C154C0000000)
  %423 = tail call float @_Z3cosf(float %422) #4
  %424 = fadd float %423, 1.000000e+00
  %425 = fmul float %424, 5.000000e-01
  %426 = fmul float %425, 2.550000e+02
  %427 = fptoui float %426 to i8
  %428 = insertelement <4 x i8> %421, i8 %427, i32 1
  %429 = fadd float %415, 0xC000C154C0000000
  %430 = tail call float @_Z3cosf(float %429) #4
  %431 = fadd float %430, 1.000000e+00
  %432 = fmul float %431, 5.000000e-01
  %433 = fmul float %432, 2.550000e+02
  %434 = fptoui float %433 to i8
  %435 = insertelement <4 x i8> %428, i8 %434, i32 2
  %436 = insertelement <4 x i8> %435, i8 -1, i32 3
  %437 = icmp eq i32 %336, %maxIterations
  br i1 %437, label %438, label %442

; <label>:438                                     ; preds = %409
  %439 = insertelement <4 x i8> %436, i8 0, i32 0
  %440 = insertelement <4 x i8> %439, i8 0, i32 1
  %441 = insertelement <4 x i8> %440, i8 0, i32 2
  br label %442

; <label>:442                                     ; preds = %438, %409
  %color.sroa.23.0 = phi <4 x i8> [ %441, %438 ], [ %436, %409 ]
  br i1 %396, label %443, label %455

; <label>:443                                     ; preds = %442
  %444 = trunc i32 %336 to i8
  %445 = insertelement <4 x i8> undef, i8 %444, i32 0
  %446 = lshr i32 %336, 8
  %447 = trunc i32 %446 to i8
  %448 = insertelement <4 x i8> %445, i8 %447, i32 1
  %449 = lshr i32 %336, 16
  %450 = trunc i32 %449 to i8
  %451 = insertelement <4 x i8> %448, i8 %450, i32 2
  %452 = lshr i32 %336, 24
  %453 = trunc i32 %452 to i8
  %454 = insertelement <4 x i8> %451, i8 %453, i32 3
  br label %455

; <label>:455                                     ; preds = %443, %442
  %color.sroa.23.1 = phi <4 x i8> [ %454, %443 ], [ %color.sroa.23.0, %442 ]
  %456 = or i32 %410, 1
  %457 = sext i32 %456 to i64
  %458 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i64 %457
  store <4 x i8> %color.sroa.23.1, <4 x i8> addrspace(1)* %458, align 4, !tbaa !2
  %459 = fmul float %355, 2.000000e+00
  %460 = fmul float %459, 0x400921FF20000000
  %461 = fmul float %460, 3.906250e-03
  %462 = tail call float @_Z3cosf(float %461) #4
  %463 = fadd float %462, 1.000000e+00
  %464 = fmul float %463, 5.000000e-01
  %465 = fmul float %464, 2.550000e+02
  %466 = fptoui float %465 to i8
  %467 = insertelement <4 x i8> undef, i8 %466, i32 0
  %468 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %461, float 0x4000C154C0000000)
  %469 = tail call float @_Z3cosf(float %468) #4
  %470 = fadd float %469, 1.000000e+00
  %471 = fmul float %470, 5.000000e-01
  %472 = fmul float %471, 2.550000e+02
  %473 = fptoui float %472 to i8
  %474 = insertelement <4 x i8> %467, i8 %473, i32 1
  %475 = fadd float %461, 0xC000C154C0000000
  %476 = tail call float @_Z3cosf(float %475) #4
  %477 = fadd float %476, 1.000000e+00
  %478 = fmul float %477, 5.000000e-01
  %479 = fmul float %478, 2.550000e+02
  %480 = fptoui float %479 to i8
  %481 = insertelement <4 x i8> %474, i8 %480, i32 2
  %482 = insertelement <4 x i8> %481, i8 -1, i32 3
  %483 = icmp eq i32 %346, %maxIterations
  br i1 %483, label %484, label %488

; <label>:484                                     ; preds = %455
  %485 = insertelement <4 x i8> %482, i8 0, i32 0
  %486 = insertelement <4 x i8> %485, i8 0, i32 1
  %487 = insertelement <4 x i8> %486, i8 0, i32 2
  br label %488

; <label>:488                                     ; preds = %484, %455
  %color.sroa.46.0 = phi <4 x i8> [ %487, %484 ], [ %482, %455 ]
  br i1 %396, label %489, label %501

; <label>:489                                     ; preds = %488
  %490 = trunc i32 %346 to i8
  %491 = insertelement <4 x i8> undef, i8 %490, i32 0
  %492 = lshr i32 %346, 8
  %493 = trunc i32 %492 to i8
  %494 = insertelement <4 x i8> %491, i8 %493, i32 1
  %495 = lshr i32 %346, 16
  %496 = trunc i32 %495 to i8
  %497 = insertelement <4 x i8> %494, i8 %496, i32 2
  %498 = lshr i32 %346, 24
  %499 = trunc i32 %498 to i8
  %500 = insertelement <4 x i8> %497, i8 %499, i32 3
  br label %501

; <label>:501                                     ; preds = %489, %488
  %color.sroa.46.1 = phi <4 x i8> [ %500, %489 ], [ %color.sroa.46.0, %488 ]
  %502 = or i32 %410, 2
  %503 = sext i32 %502 to i64
  %504 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i64 %503
  store <4 x i8> %color.sroa.46.1, <4 x i8> addrspace(1)* %504, align 4, !tbaa !2
  %505 = fmul float %365, 2.000000e+00
  %506 = fmul float %505, 0x400921FF20000000
  %507 = fmul float %506, 3.906250e-03
  %508 = tail call float @_Z3cosf(float %507) #4
  %509 = fadd float %508, 1.000000e+00
  %510 = fmul float %509, 5.000000e-01
  %511 = fmul float %510, 2.550000e+02
  %512 = fptoui float %511 to i8
  %513 = insertelement <4 x i8> undef, i8 %512, i32 0
  %514 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %507, float 0x4000C154C0000000)
  %515 = tail call float @_Z3cosf(float %514) #4
  %516 = fadd float %515, 1.000000e+00
  %517 = fmul float %516, 5.000000e-01
  %518 = fmul float %517, 2.550000e+02
  %519 = fptoui float %518 to i8
  %520 = insertelement <4 x i8> %513, i8 %519, i32 1
  %521 = fadd float %507, 0xC000C154C0000000
  %522 = tail call float @_Z3cosf(float %521) #4
  %523 = fadd float %522, 1.000000e+00
  %524 = fmul float %523, 5.000000e-01
  %525 = fmul float %524, 2.550000e+02
  %526 = fptoui float %525 to i8
  %527 = insertelement <4 x i8> %520, i8 %526, i32 2
  %528 = insertelement <4 x i8> %527, i8 -1, i32 3
  %529 = icmp eq i32 %356, %maxIterations
  br i1 %529, label %530, label %534

; <label>:530                                     ; preds = %501
  %531 = insertelement <4 x i8> %528, i8 0, i32 0
  %532 = insertelement <4 x i8> %531, i8 0, i32 1
  %533 = insertelement <4 x i8> %532, i8 0, i32 2
  br label %534

; <label>:534                                     ; preds = %530, %501
  %color.sroa.69.0 = phi <4 x i8> [ %533, %530 ], [ %528, %501 ]
  br i1 %396, label %535, label %547

; <label>:535                                     ; preds = %534
  %536 = trunc i32 %356 to i8
  %537 = insertelement <4 x i8> undef, i8 %536, i32 0
  %538 = lshr i32 %356, 8
  %539 = trunc i32 %538 to i8
  %540 = insertelement <4 x i8> %537, i8 %539, i32 1
  %541 = lshr i32 %356, 16
  %542 = trunc i32 %541 to i8
  %543 = insertelement <4 x i8> %540, i8 %542, i32 2
  %544 = lshr i32 %356, 24
  %545 = trunc i32 %544 to i8
  %546 = insertelement <4 x i8> %543, i8 %545, i32 3
  br label %547

; <label>:547                                     ; preds = %535, %534
  %color.sroa.69.1 = phi <4 x i8> [ %546, %535 ], [ %color.sroa.69.0, %534 ]
  %548 = or i32 %410, 3
  %549 = sext i32 %548 to i64
  %550 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i64 %549
  store <4 x i8> %color.sroa.69.1, <4 x i8> addrspace(1)* %550, align 4, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare i32 @MUL_ADD(...) #1

declare <4 x float> @_Z14convert_float4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #3

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, float, float, float, float, i32, i32, i32)* @mandelbrot_vector_float}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

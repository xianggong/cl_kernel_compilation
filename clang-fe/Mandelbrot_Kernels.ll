; ModuleID = '../kernel-src/Mandelbrot_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @mandelbrot_vector_float(<4 x i8> addrspace(1)* nocapture %mandelbrotImage, float %posx, float %posy, float %stepSizeX, float %stepSizeY, i32 %maxIterations, i32 %width, i32 %bench) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
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
  %or.cond3037 = and i1 %43, %42
  br i1 %or.cond3037, label %.lr.ph.preheader, label %.critedge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %savy.041 = phi <4 x float> [ %239, %.lr.ph ], [ %26, %.lr.ph.preheader ]
  %savx.040 = phi <4 x float> [ %231, %.lr.ph ], [ %20, %.lr.ph.preheader ]
  %ccount.039 = phi <4 x i32> [ %241, %.lr.ph ], [ zeroinitializer, %.lr.ph.preheader ]
  %iter.038 = phi i32 [ %242, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %44 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.041
  %45 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %savx.040, <4 x float> %savx.040, <4 x float> %20) #3
  %46 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %44, <4 x float> %savy.041, i32 %45) #3
  %47 = sitofp i32 %46 to float
  %48 = insertelement <4 x float> undef, float %47, i32 0
  %49 = shufflevector <4 x float> %48, <4 x float> undef, <4 x i32> zeroinitializer
  %50 = fmul <4 x float> %savx.040, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %51 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %50, <4 x float> %savy.041, <4 x float> %26) #3
  %52 = sitofp i32 %51 to float
  %53 = insertelement <4 x float> undef, float %52, i32 0
  %54 = shufflevector <4 x float> %53, <4 x float> undef, <4 x i32> zeroinitializer
  %55 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %54
  %56 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %49, <4 x float> %49, <4 x float> %20) #3
  %57 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %55, <4 x float> %54, i32 %56) #3
  %58 = sitofp i32 %57 to float
  %59 = insertelement <4 x float> undef, float %58, i32 0
  %60 = shufflevector <4 x float> %59, <4 x float> undef, <4 x i32> zeroinitializer
  %61 = fmul <4 x float> %49, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %62 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %61, <4 x float> %54, <4 x float> %26) #3
  %63 = sitofp i32 %62 to float
  %64 = insertelement <4 x float> undef, float %63, i32 0
  %65 = shufflevector <4 x float> %64, <4 x float> undef, <4 x i32> zeroinitializer
  %66 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %65
  %67 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %60, <4 x float> %60, <4 x float> %20) #3
  %68 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %66, <4 x float> %65, i32 %67) #3
  %69 = sitofp i32 %68 to float
  %70 = insertelement <4 x float> undef, float %69, i32 0
  %71 = shufflevector <4 x float> %70, <4 x float> undef, <4 x i32> zeroinitializer
  %72 = fmul <4 x float> %60, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %73 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %72, <4 x float> %65, <4 x float> %26) #3
  %74 = sitofp i32 %73 to float
  %75 = insertelement <4 x float> undef, float %74, i32 0
  %76 = shufflevector <4 x float> %75, <4 x float> undef, <4 x i32> zeroinitializer
  %77 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %76
  %78 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %71, <4 x float> %71, <4 x float> %20) #3
  %79 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %77, <4 x float> %76, i32 %78) #3
  %80 = sitofp i32 %79 to float
  %81 = insertelement <4 x float> undef, float %80, i32 0
  %82 = shufflevector <4 x float> %81, <4 x float> undef, <4 x i32> zeroinitializer
  %83 = fmul <4 x float> %71, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %84 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %83, <4 x float> %76, <4 x float> %26) #3
  %85 = sitofp i32 %84 to float
  %86 = insertelement <4 x float> undef, float %85, i32 0
  %87 = shufflevector <4 x float> %86, <4 x float> undef, <4 x i32> zeroinitializer
  %88 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %87
  %89 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %82, <4 x float> %82, <4 x float> %20) #3
  %90 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %88, <4 x float> %87, i32 %89) #3
  %91 = sitofp i32 %90 to float
  %92 = insertelement <4 x float> undef, float %91, i32 0
  %93 = shufflevector <4 x float> %92, <4 x float> undef, <4 x i32> zeroinitializer
  %94 = fmul <4 x float> %82, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %95 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %94, <4 x float> %87, <4 x float> %26) #3
  %96 = sitofp i32 %95 to float
  %97 = insertelement <4 x float> undef, float %96, i32 0
  %98 = shufflevector <4 x float> %97, <4 x float> undef, <4 x i32> zeroinitializer
  %99 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %98
  %100 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %93, <4 x float> %93, <4 x float> %20) #3
  %101 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %99, <4 x float> %98, i32 %100) #3
  %102 = sitofp i32 %101 to float
  %103 = insertelement <4 x float> undef, float %102, i32 0
  %104 = shufflevector <4 x float> %103, <4 x float> undef, <4 x i32> zeroinitializer
  %105 = fmul <4 x float> %93, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %106 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %105, <4 x float> %98, <4 x float> %26) #3
  %107 = sitofp i32 %106 to float
  %108 = insertelement <4 x float> undef, float %107, i32 0
  %109 = shufflevector <4 x float> %108, <4 x float> undef, <4 x i32> zeroinitializer
  %110 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %109
  %111 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %104, <4 x float> %104, <4 x float> %20) #3
  %112 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %110, <4 x float> %109, i32 %111) #3
  %113 = sitofp i32 %112 to float
  %114 = insertelement <4 x float> undef, float %113, i32 0
  %115 = shufflevector <4 x float> %114, <4 x float> undef, <4 x i32> zeroinitializer
  %116 = fmul <4 x float> %104, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %117 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %116, <4 x float> %109, <4 x float> %26) #3
  %118 = sitofp i32 %117 to float
  %119 = insertelement <4 x float> undef, float %118, i32 0
  %120 = shufflevector <4 x float> %119, <4 x float> undef, <4 x i32> zeroinitializer
  %121 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %120
  %122 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %115, <4 x float> %115, <4 x float> %20) #3
  %123 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %121, <4 x float> %120, i32 %122) #3
  %124 = sitofp i32 %123 to float
  %125 = insertelement <4 x float> undef, float %124, i32 0
  %126 = shufflevector <4 x float> %125, <4 x float> undef, <4 x i32> zeroinitializer
  %127 = fmul <4 x float> %115, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %128 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %127, <4 x float> %120, <4 x float> %26) #3
  %129 = sitofp i32 %128 to float
  %130 = insertelement <4 x float> undef, float %129, i32 0
  %131 = shufflevector <4 x float> %130, <4 x float> undef, <4 x i32> zeroinitializer
  %132 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %131
  %133 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %126, <4 x float> %126, <4 x float> %20) #3
  %134 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %132, <4 x float> %131, i32 %133) #3
  %135 = sitofp i32 %134 to float
  %136 = insertelement <4 x float> undef, float %135, i32 0
  %137 = shufflevector <4 x float> %136, <4 x float> undef, <4 x i32> zeroinitializer
  %138 = fmul <4 x float> %126, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %139 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %138, <4 x float> %131, <4 x float> %26) #3
  %140 = sitofp i32 %139 to float
  %141 = insertelement <4 x float> undef, float %140, i32 0
  %142 = shufflevector <4 x float> %141, <4 x float> undef, <4 x i32> zeroinitializer
  %143 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %142
  %144 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %137, <4 x float> %137, <4 x float> %20) #3
  %145 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %143, <4 x float> %142, i32 %144) #3
  %146 = sitofp i32 %145 to float
  %147 = insertelement <4 x float> undef, float %146, i32 0
  %148 = shufflevector <4 x float> %147, <4 x float> undef, <4 x i32> zeroinitializer
  %149 = fmul <4 x float> %137, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %150 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %149, <4 x float> %142, <4 x float> %26) #3
  %151 = sitofp i32 %150 to float
  %152 = insertelement <4 x float> undef, float %151, i32 0
  %153 = shufflevector <4 x float> %152, <4 x float> undef, <4 x i32> zeroinitializer
  %154 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %153
  %155 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %148, <4 x float> %148, <4 x float> %20) #3
  %156 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %154, <4 x float> %153, i32 %155) #3
  %157 = sitofp i32 %156 to float
  %158 = insertelement <4 x float> undef, float %157, i32 0
  %159 = shufflevector <4 x float> %158, <4 x float> undef, <4 x i32> zeroinitializer
  %160 = fmul <4 x float> %148, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %161 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %160, <4 x float> %153, <4 x float> %26) #3
  %162 = sitofp i32 %161 to float
  %163 = insertelement <4 x float> undef, float %162, i32 0
  %164 = shufflevector <4 x float> %163, <4 x float> undef, <4 x i32> zeroinitializer
  %165 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %164
  %166 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %159, <4 x float> %159, <4 x float> %20) #3
  %167 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %165, <4 x float> %164, i32 %166) #3
  %168 = sitofp i32 %167 to float
  %169 = insertelement <4 x float> undef, float %168, i32 0
  %170 = shufflevector <4 x float> %169, <4 x float> undef, <4 x i32> zeroinitializer
  %171 = fmul <4 x float> %159, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %172 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %171, <4 x float> %164, <4 x float> %26) #3
  %173 = sitofp i32 %172 to float
  %174 = insertelement <4 x float> undef, float %173, i32 0
  %175 = shufflevector <4 x float> %174, <4 x float> undef, <4 x i32> zeroinitializer
  %176 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %175
  %177 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %170, <4 x float> %170, <4 x float> %20) #3
  %178 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %176, <4 x float> %175, i32 %177) #3
  %179 = sitofp i32 %178 to float
  %180 = insertelement <4 x float> undef, float %179, i32 0
  %181 = shufflevector <4 x float> %180, <4 x float> undef, <4 x i32> zeroinitializer
  %182 = fmul <4 x float> %170, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %183 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %182, <4 x float> %175, <4 x float> %26) #3
  %184 = sitofp i32 %183 to float
  %185 = insertelement <4 x float> undef, float %184, i32 0
  %186 = shufflevector <4 x float> %185, <4 x float> undef, <4 x i32> zeroinitializer
  %187 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %186
  %188 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %181, <4 x float> %181, <4 x float> %20) #3
  %189 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %187, <4 x float> %186, i32 %188) #3
  %190 = sitofp i32 %189 to float
  %191 = insertelement <4 x float> undef, float %190, i32 0
  %192 = shufflevector <4 x float> %191, <4 x float> undef, <4 x i32> zeroinitializer
  %193 = fmul <4 x float> %181, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %194 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %193, <4 x float> %186, <4 x float> %26) #3
  %195 = sitofp i32 %194 to float
  %196 = insertelement <4 x float> undef, float %195, i32 0
  %197 = shufflevector <4 x float> %196, <4 x float> undef, <4 x i32> zeroinitializer
  %198 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %197
  %199 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %192, <4 x float> %192, <4 x float> %20) #3
  %200 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %198, <4 x float> %197, i32 %199) #3
  %201 = sitofp i32 %200 to float
  %202 = insertelement <4 x float> undef, float %201, i32 0
  %203 = shufflevector <4 x float> %202, <4 x float> undef, <4 x i32> zeroinitializer
  %204 = fmul <4 x float> %192, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %205 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %204, <4 x float> %197, <4 x float> %26) #3
  %206 = sitofp i32 %205 to float
  %207 = insertelement <4 x float> undef, float %206, i32 0
  %208 = shufflevector <4 x float> %207, <4 x float> undef, <4 x i32> zeroinitializer
  %209 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %208
  %210 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %203, <4 x float> %203, <4 x float> %20) #3
  %211 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %209, <4 x float> %208, i32 %210) #3
  %212 = sitofp i32 %211 to float
  %213 = fmul <4 x float> %203, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %214 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %213, <4 x float> %208, <4 x float> %26) #3
  %215 = sitofp i32 %214 to float
  %216 = fmul float %215, %215
  %217 = tail call float @llvm.fmuladd.f32(float %212, float %212, float %216)
  %218 = fcmp ole float %217, 4.000000e+00
  %219 = zext i1 %218 to i32
  %220 = insertelement <4 x i32> undef, i32 %219, i32 0
  %221 = insertelement <4 x i32> %220, i32 %219, i32 1
  %222 = insertelement <4 x i32> %221, i32 %219, i32 2
  %223 = insertelement <4 x i32> %222, i32 %219, i32 3
  %savx.0.elt = extractelement <4 x float> %savx.040, i32 0
  %224 = select i1 %218, float %212, float %savx.0.elt
  %225 = insertelement <4 x float> undef, float %224, i32 0
  %.elt24 = extractelement <4 x float> %savx.040, i32 1
  %226 = select i1 %218, float %212, float %.elt24
  %227 = insertelement <4 x float> %225, float %226, i32 1
  %.elt25 = extractelement <4 x float> %savx.040, i32 2
  %228 = select i1 %218, float %212, float %.elt25
  %229 = insertelement <4 x float> %227, float %228, i32 2
  %.elt26 = extractelement <4 x float> %savx.040, i32 3
  %230 = select i1 %218, float %212, float %.elt26
  %231 = insertelement <4 x float> %229, float %230, i32 3
  %savy.0.elt = extractelement <4 x float> %savy.041, i32 0
  %232 = select i1 %218, float %215, float %savy.0.elt
  %233 = insertelement <4 x float> undef, float %232, i32 0
  %.elt27 = extractelement <4 x float> %savy.041, i32 1
  %234 = select i1 %218, float %215, float %.elt27
  %235 = insertelement <4 x float> %233, float %234, i32 1
  %.elt28 = extractelement <4 x float> %savy.041, i32 2
  %236 = select i1 %218, float %215, float %.elt28
  %237 = insertelement <4 x float> %235, float %236, i32 2
  %.elt29 = extractelement <4 x float> %savy.041, i32 3
  %238 = select i1 %218, float %215, float %.elt29
  %239 = insertelement <4 x float> %237, float %238, i32 3
  %240 = shl <4 x i32> %223, <i32 4, i32 4, i32 4, i32 4>
  %241 = add <4 x i32> %ccount.039, %240
  %242 = add i32 %iter.038, 16
  %243 = icmp ult i32 %242, %maxIterations
  %or.cond30 = and i1 %243, %218
  br i1 %or.cond30, label %.lr.ph, label %.critedge.loopexit

.critedge.loopexit:                               ; preds = %.lr.ph
  %.lcssa65 = phi <4 x i32> [ %241, %.lr.ph ]
  %.lcssa64 = phi <4 x float> [ %239, %.lr.ph ]
  %.lcssa63 = phi <4 x float> [ %231, %.lr.ph ]
  %.lcssa62 = phi i32 [ %219, %.lr.ph ]
  br label %.critedge

.critedge:                                        ; preds = %.critedge.loopexit, %0
  %.lcssa36 = phi i32 [ %39, %0 ], [ %.lcssa62, %.critedge.loopexit ]
  %.lcssa35 = phi i32 [ %36, %0 ], [ %.lcssa62, %.critedge.loopexit ]
  %.lcssa34 = phi i32 [ %33, %0 ], [ %.lcssa62, %.critedge.loopexit ]
  %.lcssa33 = phi i32 [ %30, %0 ], [ %.lcssa62, %.critedge.loopexit ]
  %savy.0.lcssa = phi <4 x float> [ %26, %0 ], [ %.lcssa64, %.critedge.loopexit ]
  %savx.0.lcssa = phi <4 x float> [ %20, %0 ], [ %.lcssa63, %.critedge.loopexit ]
  %ccount.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %.lcssa65, %.critedge.loopexit ]
  %244 = and i32 %.lcssa33, %.lcssa34
  %245 = and i32 %244, %.lcssa35
  %246 = and i32 %245, %.lcssa36
  %247 = icmp eq i32 %246, 0
  br i1 %247, label %.preheader.preheader, label %.critedge16

.preheader.preheader:                             ; preds = %.critedge
  br label %.preheader

.preheader:                                       ; preds = %.preheader.preheader, %292
  %iter.1 = phi i32 [ %304, %292 ], [ 16, %.preheader.preheader ]
  %ccount.1 = phi <4 x i32> [ %303, %292 ], [ %ccount.0.lcssa, %.preheader.preheader ]
  %savx.1 = phi <4 x float> [ %312, %292 ], [ %savx.0.lcssa, %.preheader.preheader ]
  %savy.1 = phi <4 x float> [ %320, %292 ], [ %savy.0.lcssa, %.preheader.preheader ]
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
  %297 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %savx.1, <4 x float> %savx.1, <4 x float> %20) #3
  %298 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %296, <4 x float> %savy.1, i32 %297) #3
  %299 = sitofp i32 %298 to float
  %300 = fmul <4 x float> %savx.1, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %301 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %300, <4 x float> %savy.1, <4 x float> %26) #3
  %302 = sitofp i32 %301 to float
  %303 = add <4 x i32> %ccount.1, %295
  %304 = add nsw i32 %iter.1, -1
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
  %or.cond = and i1 %324, %323
  br i1 %or.cond, label %.preheader, label %.critedge16.loopexit

.critedge16.loopexit:                             ; preds = %292
  %.lcssa61 = phi <4 x float> [ %320, %292 ]
  %.lcssa60 = phi <4 x float> [ %312, %292 ]
  %.lcssa = phi <4 x i32> [ %303, %292 ]
  br label %.critedge16

.critedge16:                                      ; preds = %.critedge16.loopexit, %.critedge
  %ccount.2 = phi <4 x i32> [ %ccount.0.lcssa, %.critedge ], [ %.lcssa, %.critedge16.loopexit ]
  %savx.2 = phi <4 x float> [ %savx.0.lcssa, %.critedge ], [ %.lcssa60, %.critedge16.loopexit ]
  %savy.2 = phi <4 x float> [ %savy.0.lcssa, %.critedge ], [ %.lcssa61, %.critedge16.loopexit ]
  %325 = tail call <4 x float> @_Z14convert_float4Dv4_i(<4 x i32> %ccount.2) #3
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
  %369 = tail call float @_Z3cosf(float %368) #3
  %370 = fadd float %369, 1.000000e+00
  %371 = fmul float %370, 5.000000e-01
  %372 = fmul float %371, 2.550000e+02
  %373 = fptoui float %372 to i8
  %374 = insertelement <4 x i8> undef, i8 %373, i32 0
  %375 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %368, float 0x4000C154C0000000)
  %376 = tail call float @_Z3cosf(float %375) #3
  %377 = fadd float %376, 1.000000e+00
  %378 = fmul float %377, 5.000000e-01
  %379 = fmul float %378, 2.550000e+02
  %380 = fptoui float %379 to i8
  %381 = insertelement <4 x i8> %374, i8 %380, i32 1
  %382 = fadd float %368, 0xC000C154C0000000
  %383 = tail call float @_Z3cosf(float %382) #3
  %384 = fadd float %383, 1.000000e+00
  %385 = fmul float %384, 5.000000e-01
  %386 = fmul float %385, 2.550000e+02
  %387 = fptoui float %386 to i8
  %388 = insertelement <4 x i8> %381, i8 %387, i32 2
  %389 = insertelement <4 x i8> %388, i8 -1, i32 3
  %390 = icmp eq i32 %326, %maxIterations
  br i1 %390, label %391, label %395

; <label>:391                                     ; preds = %.critedge16
  %392 = insertelement <4 x i8> %389, i8 0, i32 0
  %393 = insertelement <4 x i8> %392, i8 0, i32 1
  %394 = insertelement <4 x i8> %393, i8 0, i32 2
  br label %395

; <label>:395                                     ; preds = %391, %.critedge16
  %color.sroa.0.0 = phi <4 x i8> [ %394, %391 ], [ %389, %.critedge16 ]
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
  %411 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %410
  store <4 x i8> %color.sroa.0.1, <4 x i8> addrspace(1)* %411, align 4, !tbaa !7
  %412 = fmul float %345, 2.000000e+00
  %413 = fmul float %412, 0x400921FF20000000
  %414 = fmul float %413, 3.906250e-03
  %415 = tail call float @_Z3cosf(float %414) #3
  %416 = fadd float %415, 1.000000e+00
  %417 = fmul float %416, 5.000000e-01
  %418 = fmul float %417, 2.550000e+02
  %419 = fptoui float %418 to i8
  %420 = insertelement <4 x i8> undef, i8 %419, i32 0
  %421 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %414, float 0x4000C154C0000000)
  %422 = tail call float @_Z3cosf(float %421) #3
  %423 = fadd float %422, 1.000000e+00
  %424 = fmul float %423, 5.000000e-01
  %425 = fmul float %424, 2.550000e+02
  %426 = fptoui float %425 to i8
  %427 = insertelement <4 x i8> %420, i8 %426, i32 1
  %428 = fadd float %414, 0xC000C154C0000000
  %429 = tail call float @_Z3cosf(float %428) #3
  %430 = fadd float %429, 1.000000e+00
  %431 = fmul float %430, 5.000000e-01
  %432 = fmul float %431, 2.550000e+02
  %433 = fptoui float %432 to i8
  %434 = insertelement <4 x i8> %427, i8 %433, i32 2
  %435 = insertelement <4 x i8> %434, i8 -1, i32 3
  %436 = icmp eq i32 %336, %maxIterations
  br i1 %436, label %437, label %441

; <label>:437                                     ; preds = %409
  %438 = insertelement <4 x i8> %435, i8 0, i32 0
  %439 = insertelement <4 x i8> %438, i8 0, i32 1
  %440 = insertelement <4 x i8> %439, i8 0, i32 2
  br label %441

; <label>:441                                     ; preds = %437, %409
  %color.sroa.23.0 = phi <4 x i8> [ %440, %437 ], [ %435, %409 ]
  br i1 %396, label %442, label %454

; <label>:442                                     ; preds = %441
  %443 = trunc i32 %336 to i8
  %444 = insertelement <4 x i8> undef, i8 %443, i32 0
  %445 = lshr i32 %336, 8
  %446 = trunc i32 %445 to i8
  %447 = insertelement <4 x i8> %444, i8 %446, i32 1
  %448 = lshr i32 %336, 16
  %449 = trunc i32 %448 to i8
  %450 = insertelement <4 x i8> %447, i8 %449, i32 2
  %451 = lshr i32 %336, 24
  %452 = trunc i32 %451 to i8
  %453 = insertelement <4 x i8> %450, i8 %452, i32 3
  br label %454

; <label>:454                                     ; preds = %442, %441
  %color.sroa.23.1 = phi <4 x i8> [ %453, %442 ], [ %color.sroa.23.0, %441 ]
  %455 = or i32 %410, 1
  %456 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %455
  store <4 x i8> %color.sroa.23.1, <4 x i8> addrspace(1)* %456, align 4, !tbaa !7
  %457 = fmul float %355, 2.000000e+00
  %458 = fmul float %457, 0x400921FF20000000
  %459 = fmul float %458, 3.906250e-03
  %460 = tail call float @_Z3cosf(float %459) #3
  %461 = fadd float %460, 1.000000e+00
  %462 = fmul float %461, 5.000000e-01
  %463 = fmul float %462, 2.550000e+02
  %464 = fptoui float %463 to i8
  %465 = insertelement <4 x i8> undef, i8 %464, i32 0
  %466 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %459, float 0x4000C154C0000000)
  %467 = tail call float @_Z3cosf(float %466) #3
  %468 = fadd float %467, 1.000000e+00
  %469 = fmul float %468, 5.000000e-01
  %470 = fmul float %469, 2.550000e+02
  %471 = fptoui float %470 to i8
  %472 = insertelement <4 x i8> %465, i8 %471, i32 1
  %473 = fadd float %459, 0xC000C154C0000000
  %474 = tail call float @_Z3cosf(float %473) #3
  %475 = fadd float %474, 1.000000e+00
  %476 = fmul float %475, 5.000000e-01
  %477 = fmul float %476, 2.550000e+02
  %478 = fptoui float %477 to i8
  %479 = insertelement <4 x i8> %472, i8 %478, i32 2
  %480 = insertelement <4 x i8> %479, i8 -1, i32 3
  %481 = icmp eq i32 %346, %maxIterations
  br i1 %481, label %482, label %486

; <label>:482                                     ; preds = %454
  %483 = insertelement <4 x i8> %480, i8 0, i32 0
  %484 = insertelement <4 x i8> %483, i8 0, i32 1
  %485 = insertelement <4 x i8> %484, i8 0, i32 2
  br label %486

; <label>:486                                     ; preds = %482, %454
  %color.sroa.46.0 = phi <4 x i8> [ %485, %482 ], [ %480, %454 ]
  br i1 %396, label %487, label %499

; <label>:487                                     ; preds = %486
  %488 = trunc i32 %346 to i8
  %489 = insertelement <4 x i8> undef, i8 %488, i32 0
  %490 = lshr i32 %346, 8
  %491 = trunc i32 %490 to i8
  %492 = insertelement <4 x i8> %489, i8 %491, i32 1
  %493 = lshr i32 %346, 16
  %494 = trunc i32 %493 to i8
  %495 = insertelement <4 x i8> %492, i8 %494, i32 2
  %496 = lshr i32 %346, 24
  %497 = trunc i32 %496 to i8
  %498 = insertelement <4 x i8> %495, i8 %497, i32 3
  br label %499

; <label>:499                                     ; preds = %487, %486
  %color.sroa.46.1 = phi <4 x i8> [ %498, %487 ], [ %color.sroa.46.0, %486 ]
  %500 = or i32 %410, 2
  %501 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %500
  store <4 x i8> %color.sroa.46.1, <4 x i8> addrspace(1)* %501, align 4, !tbaa !7
  %502 = fmul float %365, 2.000000e+00
  %503 = fmul float %502, 0x400921FF20000000
  %504 = fmul float %503, 3.906250e-03
  %505 = tail call float @_Z3cosf(float %504) #3
  %506 = fadd float %505, 1.000000e+00
  %507 = fmul float %506, 5.000000e-01
  %508 = fmul float %507, 2.550000e+02
  %509 = fptoui float %508 to i8
  %510 = insertelement <4 x i8> undef, i8 %509, i32 0
  %511 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %504, float 0x4000C154C0000000)
  %512 = tail call float @_Z3cosf(float %511) #3
  %513 = fadd float %512, 1.000000e+00
  %514 = fmul float %513, 5.000000e-01
  %515 = fmul float %514, 2.550000e+02
  %516 = fptoui float %515 to i8
  %517 = insertelement <4 x i8> %510, i8 %516, i32 1
  %518 = fadd float %504, 0xC000C154C0000000
  %519 = tail call float @_Z3cosf(float %518) #3
  %520 = fadd float %519, 1.000000e+00
  %521 = fmul float %520, 5.000000e-01
  %522 = fmul float %521, 2.550000e+02
  %523 = fptoui float %522 to i8
  %524 = insertelement <4 x i8> %517, i8 %523, i32 2
  %525 = insertelement <4 x i8> %524, i8 -1, i32 3
  %526 = icmp eq i32 %356, %maxIterations
  br i1 %526, label %527, label %531

; <label>:527                                     ; preds = %499
  %528 = insertelement <4 x i8> %525, i8 0, i32 0
  %529 = insertelement <4 x i8> %528, i8 0, i32 1
  %530 = insertelement <4 x i8> %529, i8 0, i32 2
  br label %531

; <label>:531                                     ; preds = %527, %499
  %color.sroa.69.0 = phi <4 x i8> [ %530, %527 ], [ %525, %499 ]
  br i1 %396, label %532, label %544

; <label>:532                                     ; preds = %531
  %533 = trunc i32 %356 to i8
  %534 = insertelement <4 x i8> undef, i8 %533, i32 0
  %535 = lshr i32 %356, 8
  %536 = trunc i32 %535 to i8
  %537 = insertelement <4 x i8> %534, i8 %536, i32 1
  %538 = lshr i32 %356, 16
  %539 = trunc i32 %538 to i8
  %540 = insertelement <4 x i8> %537, i8 %539, i32 2
  %541 = lshr i32 %356, 24
  %542 = trunc i32 %541 to i8
  %543 = insertelement <4 x i8> %540, i8 %542, i32 3
  br label %544

; <label>:544                                     ; preds = %532, %531
  %color.sroa.69.1 = phi <4 x i8> [ %543, %532 ], [ %color.sroa.69.0, %531 ]
  %545 = or i32 %410, 3
  %546 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %545
  store <4 x i8> %color.sroa.69.1, <4 x i8> addrspace(1)* %546, align 4, !tbaa !7
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare i32 @MUL_ADD(...) #1

declare <4 x float> @_Z14convert_float4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind readnone
declare float @llvm.log2.f32(float) #2

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (<4 x i8> addrspace(1)*, float, float, float, float, i32, i32, i32)* @mandelbrot_vector_float, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uchar4*", !"float", !"float", !"float", !"float", !"uint", !"int", !"int"}
!4 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"float", !"float", !"float", !"float", !"uint", !"int", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"const", !"const", !"const", !"const", !"const", !"const", !"const"}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}

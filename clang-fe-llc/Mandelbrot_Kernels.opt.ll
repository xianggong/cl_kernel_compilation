; ModuleID = 'Mandelbrot_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @mandelbrot_vector_float(<4 x i8> addrspace(1)* %mandelbrotImage, float %posx, float %posy, float %stepSizeX, float %stepSizeY, i32 %maxIterations, i32 %width, i32 %bench) #0 {
  %color = alloca [4 x <4 x i8>], align 4
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = sdiv i32 %width, 4
  %3 = srem i32 %1, %2
  %4 = sdiv i32 %width, 4
  %5 = sdiv i32 %1, %4
  %6 = mul nsw i32 4, %3
  %7 = insertelement <4 x i32> undef, i32 %6, i32 0
  %8 = mul nsw i32 4, %3
  %9 = add nsw i32 %8, 1
  %10 = insertelement <4 x i32> %7, i32 %9, i32 1
  %11 = mul nsw i32 4, %3
  %12 = add nsw i32 %11, 2
  %13 = insertelement <4 x i32> %10, i32 %12, i32 2
  %14 = mul nsw i32 4, %3
  %15 = add nsw i32 %14, 3
  %16 = insertelement <4 x i32> %13, i32 %15, i32 3
  %17 = insertelement <4 x i32> undef, i32 %5, i32 0
  %18 = insertelement <4 x i32> %17, i32 %5, i32 1
  %19 = insertelement <4 x i32> %18, i32 %5, i32 2
  %20 = insertelement <4 x i32> %19, i32 %5, i32 3
  %21 = extractelement <4 x i32> %16, i32 0
  %22 = sitofp i32 %21 to float
  %23 = call float @llvm.fmuladd.f32(float %stepSizeX, float %22, float %posx)
  %24 = insertelement <4 x float> undef, float %23, i32 0
  %25 = extractelement <4 x i32> %16, i32 1
  %26 = sitofp i32 %25 to float
  %27 = call float @llvm.fmuladd.f32(float %stepSizeX, float %26, float %posx)
  %28 = insertelement <4 x float> %24, float %27, i32 1
  %29 = extractelement <4 x i32> %16, i32 2
  %30 = sitofp i32 %29 to float
  %31 = call float @llvm.fmuladd.f32(float %stepSizeX, float %30, float %posx)
  %32 = insertelement <4 x float> %28, float %31, i32 2
  %33 = extractelement <4 x i32> %16, i32 3
  %34 = sitofp i32 %33 to float
  %35 = call float @llvm.fmuladd.f32(float %stepSizeX, float %34, float %posx)
  %36 = insertelement <4 x float> %32, float %35, i32 3
  %37 = extractelement <4 x i32> %20, i32 0
  %38 = sitofp i32 %37 to float
  %39 = call float @llvm.fmuladd.f32(float %stepSizeY, float %38, float %posy)
  %40 = insertelement <4 x float> undef, float %39, i32 0
  %41 = extractelement <4 x i32> %20, i32 1
  %42 = sitofp i32 %41 to float
  %43 = call float @llvm.fmuladd.f32(float %stepSizeY, float %42, float %posy)
  %44 = insertelement <4 x float> %40, float %43, i32 1
  %45 = extractelement <4 x i32> %20, i32 2
  %46 = sitofp i32 %45 to float
  %47 = call float @llvm.fmuladd.f32(float %stepSizeY, float %46, float %posy)
  %48 = insertelement <4 x float> %44, float %47, i32 2
  %49 = extractelement <4 x i32> %20, i32 3
  %50 = sitofp i32 %49 to float
  %51 = call float @llvm.fmuladd.f32(float %stepSizeY, float %50, float %posy)
  %52 = insertelement <4 x float> %48, float %51, i32 3
  %53 = extractelement <4 x float> %36, i32 0
  %54 = extractelement <4 x float> %36, i32 0
  %55 = extractelement <4 x float> %52, i32 0
  %56 = extractelement <4 x float> %52, i32 0
  %57 = fmul float %55, %56
  %58 = call float @llvm.fmuladd.f32(float %53, float %54, float %57)
  %59 = fcmp ole float %58, 4.000000e+00
  %60 = zext i1 %59 to i32
  %61 = insertelement <4 x i32> undef, i32 %60, i32 0
  %62 = extractelement <4 x float> %36, i32 1
  %63 = extractelement <4 x float> %36, i32 1
  %64 = extractelement <4 x float> %52, i32 1
  %65 = extractelement <4 x float> %52, i32 1
  %66 = fmul float %64, %65
  %67 = call float @llvm.fmuladd.f32(float %62, float %63, float %66)
  %68 = fcmp ole float %67, 4.000000e+00
  %69 = zext i1 %68 to i32
  %70 = insertelement <4 x i32> %61, i32 %69, i32 1
  %71 = extractelement <4 x float> %36, i32 2
  %72 = extractelement <4 x float> %36, i32 2
  %73 = extractelement <4 x float> %52, i32 2
  %74 = extractelement <4 x float> %52, i32 2
  %75 = fmul float %73, %74
  %76 = call float @llvm.fmuladd.f32(float %71, float %72, float %75)
  %77 = fcmp ole float %76, 4.000000e+00
  %78 = zext i1 %77 to i32
  %79 = insertelement <4 x i32> %70, i32 %78, i32 2
  %80 = extractelement <4 x float> %36, i32 3
  %81 = extractelement <4 x float> %36, i32 3
  %82 = extractelement <4 x float> %52, i32 3
  %83 = extractelement <4 x float> %52, i32 3
  %84 = fmul float %82, %83
  %85 = call float @llvm.fmuladd.f32(float %80, float %81, float %84)
  %86 = fcmp ole float %85, 4.000000e+00
  %87 = zext i1 %86 to i32
  %88 = insertelement <4 x i32> %79, i32 %87, i32 3
  br label %89

; <label>:89                                      ; preds = %387, %0
  %iter.0 = phi i32 [ 0, %0 ], [ %388, %387 ]
  %stay.0 = phi <4 x i32> [ %88, %0 ], [ %312, %387 ]
  %ccount.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %386, %387 ]
  %savx.0 = phi <4 x float> [ %36, %0 ], [ %348, %387 ]
  %savy.0 = phi <4 x float> [ %52, %0 ], [ %384, %387 ]
  %90 = extractelement <4 x i32> %stay.0, i32 0
  %91 = extractelement <4 x i32> %stay.0, i32 1
  %92 = or i32 %90, %91
  %93 = extractelement <4 x i32> %stay.0, i32 2
  %94 = or i32 %92, %93
  %95 = extractelement <4 x i32> %stay.0, i32 3
  %96 = or i32 %94, %95
  %97 = icmp ne i32 %96, 0
  br i1 %97, label %98, label %389

; <label>:98                                      ; preds = %89
  %99 = icmp ult i32 %iter.0, %maxIterations
  br i1 %99, label %100, label %389

; <label>:100                                     ; preds = %98
  %101 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.0
  %102 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %savx.0, <4 x float> %savx.0, <4 x float> %36)
  %103 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %101, <4 x float> %savy.0, i32 %102)
  %104 = sitofp i32 %103 to float
  %105 = insertelement <4 x float> undef, float %104, i32 0
  %106 = shufflevector <4 x float> %105, <4 x float> undef, <4 x i32> zeroinitializer
  %107 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %savx.0
  %108 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %107, <4 x float> %savy.0, <4 x float> %52)
  %109 = sitofp i32 %108 to float
  %110 = insertelement <4 x float> undef, float %109, i32 0
  %111 = shufflevector <4 x float> %110, <4 x float> undef, <4 x i32> zeroinitializer
  %112 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %111
  %113 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %106, <4 x float> %106, <4 x float> %36)
  %114 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %112, <4 x float> %111, i32 %113)
  %115 = sitofp i32 %114 to float
  %116 = insertelement <4 x float> undef, float %115, i32 0
  %117 = shufflevector <4 x float> %116, <4 x float> undef, <4 x i32> zeroinitializer
  %118 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %106
  %119 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %118, <4 x float> %111, <4 x float> %52)
  %120 = sitofp i32 %119 to float
  %121 = insertelement <4 x float> undef, float %120, i32 0
  %122 = shufflevector <4 x float> %121, <4 x float> undef, <4 x i32> zeroinitializer
  %123 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %122
  %124 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %117, <4 x float> %117, <4 x float> %36)
  %125 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %123, <4 x float> %122, i32 %124)
  %126 = sitofp i32 %125 to float
  %127 = insertelement <4 x float> undef, float %126, i32 0
  %128 = shufflevector <4 x float> %127, <4 x float> undef, <4 x i32> zeroinitializer
  %129 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %117
  %130 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %129, <4 x float> %122, <4 x float> %52)
  %131 = sitofp i32 %130 to float
  %132 = insertelement <4 x float> undef, float %131, i32 0
  %133 = shufflevector <4 x float> %132, <4 x float> undef, <4 x i32> zeroinitializer
  %134 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %133
  %135 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %128, <4 x float> %128, <4 x float> %36)
  %136 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %134, <4 x float> %133, i32 %135)
  %137 = sitofp i32 %136 to float
  %138 = insertelement <4 x float> undef, float %137, i32 0
  %139 = shufflevector <4 x float> %138, <4 x float> undef, <4 x i32> zeroinitializer
  %140 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %128
  %141 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %140, <4 x float> %133, <4 x float> %52)
  %142 = sitofp i32 %141 to float
  %143 = insertelement <4 x float> undef, float %142, i32 0
  %144 = shufflevector <4 x float> %143, <4 x float> undef, <4 x i32> zeroinitializer
  %145 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %144
  %146 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %139, <4 x float> %139, <4 x float> %36)
  %147 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %145, <4 x float> %144, i32 %146)
  %148 = sitofp i32 %147 to float
  %149 = insertelement <4 x float> undef, float %148, i32 0
  %150 = shufflevector <4 x float> %149, <4 x float> undef, <4 x i32> zeroinitializer
  %151 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %139
  %152 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %151, <4 x float> %144, <4 x float> %52)
  %153 = sitofp i32 %152 to float
  %154 = insertelement <4 x float> undef, float %153, i32 0
  %155 = shufflevector <4 x float> %154, <4 x float> undef, <4 x i32> zeroinitializer
  %156 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %155
  %157 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %150, <4 x float> %150, <4 x float> %36)
  %158 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %156, <4 x float> %155, i32 %157)
  %159 = sitofp i32 %158 to float
  %160 = insertelement <4 x float> undef, float %159, i32 0
  %161 = shufflevector <4 x float> %160, <4 x float> undef, <4 x i32> zeroinitializer
  %162 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %150
  %163 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %162, <4 x float> %155, <4 x float> %52)
  %164 = sitofp i32 %163 to float
  %165 = insertelement <4 x float> undef, float %164, i32 0
  %166 = shufflevector <4 x float> %165, <4 x float> undef, <4 x i32> zeroinitializer
  %167 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %166
  %168 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %161, <4 x float> %161, <4 x float> %36)
  %169 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %167, <4 x float> %166, i32 %168)
  %170 = sitofp i32 %169 to float
  %171 = insertelement <4 x float> undef, float %170, i32 0
  %172 = shufflevector <4 x float> %171, <4 x float> undef, <4 x i32> zeroinitializer
  %173 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %161
  %174 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %173, <4 x float> %166, <4 x float> %52)
  %175 = sitofp i32 %174 to float
  %176 = insertelement <4 x float> undef, float %175, i32 0
  %177 = shufflevector <4 x float> %176, <4 x float> undef, <4 x i32> zeroinitializer
  %178 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %177
  %179 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %172, <4 x float> %172, <4 x float> %36)
  %180 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %178, <4 x float> %177, i32 %179)
  %181 = sitofp i32 %180 to float
  %182 = insertelement <4 x float> undef, float %181, i32 0
  %183 = shufflevector <4 x float> %182, <4 x float> undef, <4 x i32> zeroinitializer
  %184 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %172
  %185 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %184, <4 x float> %177, <4 x float> %52)
  %186 = sitofp i32 %185 to float
  %187 = insertelement <4 x float> undef, float %186, i32 0
  %188 = shufflevector <4 x float> %187, <4 x float> undef, <4 x i32> zeroinitializer
  %189 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %188
  %190 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %183, <4 x float> %183, <4 x float> %36)
  %191 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %189, <4 x float> %188, i32 %190)
  %192 = sitofp i32 %191 to float
  %193 = insertelement <4 x float> undef, float %192, i32 0
  %194 = shufflevector <4 x float> %193, <4 x float> undef, <4 x i32> zeroinitializer
  %195 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %183
  %196 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %195, <4 x float> %188, <4 x float> %52)
  %197 = sitofp i32 %196 to float
  %198 = insertelement <4 x float> undef, float %197, i32 0
  %199 = shufflevector <4 x float> %198, <4 x float> undef, <4 x i32> zeroinitializer
  %200 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %199
  %201 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %194, <4 x float> %194, <4 x float> %36)
  %202 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %200, <4 x float> %199, i32 %201)
  %203 = sitofp i32 %202 to float
  %204 = insertelement <4 x float> undef, float %203, i32 0
  %205 = shufflevector <4 x float> %204, <4 x float> undef, <4 x i32> zeroinitializer
  %206 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %194
  %207 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %206, <4 x float> %199, <4 x float> %52)
  %208 = sitofp i32 %207 to float
  %209 = insertelement <4 x float> undef, float %208, i32 0
  %210 = shufflevector <4 x float> %209, <4 x float> undef, <4 x i32> zeroinitializer
  %211 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %210
  %212 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %205, <4 x float> %205, <4 x float> %36)
  %213 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %211, <4 x float> %210, i32 %212)
  %214 = sitofp i32 %213 to float
  %215 = insertelement <4 x float> undef, float %214, i32 0
  %216 = shufflevector <4 x float> %215, <4 x float> undef, <4 x i32> zeroinitializer
  %217 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %205
  %218 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %217, <4 x float> %210, <4 x float> %52)
  %219 = sitofp i32 %218 to float
  %220 = insertelement <4 x float> undef, float %219, i32 0
  %221 = shufflevector <4 x float> %220, <4 x float> undef, <4 x i32> zeroinitializer
  %222 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %221
  %223 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %216, <4 x float> %216, <4 x float> %36)
  %224 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %222, <4 x float> %221, i32 %223)
  %225 = sitofp i32 %224 to float
  %226 = insertelement <4 x float> undef, float %225, i32 0
  %227 = shufflevector <4 x float> %226, <4 x float> undef, <4 x i32> zeroinitializer
  %228 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %216
  %229 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %228, <4 x float> %221, <4 x float> %52)
  %230 = sitofp i32 %229 to float
  %231 = insertelement <4 x float> undef, float %230, i32 0
  %232 = shufflevector <4 x float> %231, <4 x float> undef, <4 x i32> zeroinitializer
  %233 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %232
  %234 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %227, <4 x float> %227, <4 x float> %36)
  %235 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %233, <4 x float> %232, i32 %234)
  %236 = sitofp i32 %235 to float
  %237 = insertelement <4 x float> undef, float %236, i32 0
  %238 = shufflevector <4 x float> %237, <4 x float> undef, <4 x i32> zeroinitializer
  %239 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %227
  %240 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %239, <4 x float> %232, <4 x float> %52)
  %241 = sitofp i32 %240 to float
  %242 = insertelement <4 x float> undef, float %241, i32 0
  %243 = shufflevector <4 x float> %242, <4 x float> undef, <4 x i32> zeroinitializer
  %244 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %243
  %245 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %238, <4 x float> %238, <4 x float> %36)
  %246 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %244, <4 x float> %243, i32 %245)
  %247 = sitofp i32 %246 to float
  %248 = insertelement <4 x float> undef, float %247, i32 0
  %249 = shufflevector <4 x float> %248, <4 x float> undef, <4 x i32> zeroinitializer
  %250 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %238
  %251 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %250, <4 x float> %243, <4 x float> %52)
  %252 = sitofp i32 %251 to float
  %253 = insertelement <4 x float> undef, float %252, i32 0
  %254 = shufflevector <4 x float> %253, <4 x float> undef, <4 x i32> zeroinitializer
  %255 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %254
  %256 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %249, <4 x float> %249, <4 x float> %36)
  %257 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %255, <4 x float> %254, i32 %256)
  %258 = sitofp i32 %257 to float
  %259 = insertelement <4 x float> undef, float %258, i32 0
  %260 = shufflevector <4 x float> %259, <4 x float> undef, <4 x i32> zeroinitializer
  %261 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %249
  %262 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %261, <4 x float> %254, <4 x float> %52)
  %263 = sitofp i32 %262 to float
  %264 = insertelement <4 x float> undef, float %263, i32 0
  %265 = shufflevector <4 x float> %264, <4 x float> undef, <4 x i32> zeroinitializer
  %266 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %265
  %267 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %260, <4 x float> %260, <4 x float> %36)
  %268 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %266, <4 x float> %265, i32 %267)
  %269 = sitofp i32 %268 to float
  %270 = insertelement <4 x float> undef, float %269, i32 0
  %271 = shufflevector <4 x float> %270, <4 x float> undef, <4 x i32> zeroinitializer
  %272 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %260
  %273 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %272, <4 x float> %265, <4 x float> %52)
  %274 = sitofp i32 %273 to float
  %275 = insertelement <4 x float> undef, float %274, i32 0
  %276 = shufflevector <4 x float> %275, <4 x float> undef, <4 x i32> zeroinitializer
  %277 = extractelement <4 x float> %271, i32 0
  %278 = extractelement <4 x float> %271, i32 0
  %279 = extractelement <4 x float> %276, i32 0
  %280 = extractelement <4 x float> %276, i32 0
  %281 = fmul float %279, %280
  %282 = call float @llvm.fmuladd.f32(float %277, float %278, float %281)
  %283 = fcmp ole float %282, 4.000000e+00
  %284 = zext i1 %283 to i32
  %285 = insertelement <4 x i32> %stay.0, i32 %284, i32 0
  %286 = extractelement <4 x float> %271, i32 1
  %287 = extractelement <4 x float> %271, i32 1
  %288 = extractelement <4 x float> %276, i32 1
  %289 = extractelement <4 x float> %276, i32 1
  %290 = fmul float %288, %289
  %291 = call float @llvm.fmuladd.f32(float %286, float %287, float %290)
  %292 = fcmp ole float %291, 4.000000e+00
  %293 = zext i1 %292 to i32
  %294 = insertelement <4 x i32> %285, i32 %293, i32 1
  %295 = extractelement <4 x float> %271, i32 2
  %296 = extractelement <4 x float> %271, i32 2
  %297 = extractelement <4 x float> %276, i32 2
  %298 = extractelement <4 x float> %276, i32 2
  %299 = fmul float %297, %298
  %300 = call float @llvm.fmuladd.f32(float %295, float %296, float %299)
  %301 = fcmp ole float %300, 4.000000e+00
  %302 = zext i1 %301 to i32
  %303 = insertelement <4 x i32> %294, i32 %302, i32 2
  %304 = extractelement <4 x float> %271, i32 3
  %305 = extractelement <4 x float> %271, i32 3
  %306 = extractelement <4 x float> %276, i32 3
  %307 = extractelement <4 x float> %276, i32 3
  %308 = fmul float %306, %307
  %309 = call float @llvm.fmuladd.f32(float %304, float %305, float %308)
  %310 = fcmp ole float %309, 4.000000e+00
  %311 = zext i1 %310 to i32
  %312 = insertelement <4 x i32> %303, i32 %311, i32 3
  %313 = extractelement <4 x i32> %312, i32 0
  %314 = icmp ne i32 %313, 0
  br i1 %314, label %315, label %317

; <label>:315                                     ; preds = %100
  %316 = extractelement <4 x float> %271, i32 0
  br label %319

; <label>:317                                     ; preds = %100
  %318 = extractelement <4 x float> %savx.0, i32 0
  br label %319

; <label>:319                                     ; preds = %317, %315
  %320 = phi float [ %316, %315 ], [ %318, %317 ]
  %321 = insertelement <4 x float> %savx.0, float %320, i32 0
  %322 = extractelement <4 x i32> %312, i32 1
  %323 = icmp ne i32 %322, 0
  br i1 %323, label %324, label %326

; <label>:324                                     ; preds = %319
  %325 = extractelement <4 x float> %271, i32 1
  br label %328

; <label>:326                                     ; preds = %319
  %327 = extractelement <4 x float> %321, i32 1
  br label %328

; <label>:328                                     ; preds = %326, %324
  %329 = phi float [ %325, %324 ], [ %327, %326 ]
  %330 = insertelement <4 x float> %321, float %329, i32 1
  %331 = extractelement <4 x i32> %312, i32 2
  %332 = icmp ne i32 %331, 0
  br i1 %332, label %333, label %335

; <label>:333                                     ; preds = %328
  %334 = extractelement <4 x float> %271, i32 2
  br label %337

; <label>:335                                     ; preds = %328
  %336 = extractelement <4 x float> %330, i32 2
  br label %337

; <label>:337                                     ; preds = %335, %333
  %338 = phi float [ %334, %333 ], [ %336, %335 ]
  %339 = insertelement <4 x float> %330, float %338, i32 2
  %340 = extractelement <4 x i32> %312, i32 3
  %341 = icmp ne i32 %340, 0
  br i1 %341, label %342, label %344

; <label>:342                                     ; preds = %337
  %343 = extractelement <4 x float> %271, i32 3
  br label %346

; <label>:344                                     ; preds = %337
  %345 = extractelement <4 x float> %339, i32 3
  br label %346

; <label>:346                                     ; preds = %344, %342
  %347 = phi float [ %343, %342 ], [ %345, %344 ]
  %348 = insertelement <4 x float> %339, float %347, i32 3
  %349 = extractelement <4 x i32> %312, i32 0
  %350 = icmp ne i32 %349, 0
  br i1 %350, label %351, label %353

; <label>:351                                     ; preds = %346
  %352 = extractelement <4 x float> %276, i32 0
  br label %355

; <label>:353                                     ; preds = %346
  %354 = extractelement <4 x float> %savy.0, i32 0
  br label %355

; <label>:355                                     ; preds = %353, %351
  %356 = phi float [ %352, %351 ], [ %354, %353 ]
  %357 = insertelement <4 x float> %savy.0, float %356, i32 0
  %358 = extractelement <4 x i32> %312, i32 1
  %359 = icmp ne i32 %358, 0
  br i1 %359, label %360, label %362

; <label>:360                                     ; preds = %355
  %361 = extractelement <4 x float> %276, i32 1
  br label %364

; <label>:362                                     ; preds = %355
  %363 = extractelement <4 x float> %357, i32 1
  br label %364

; <label>:364                                     ; preds = %362, %360
  %365 = phi float [ %361, %360 ], [ %363, %362 ]
  %366 = insertelement <4 x float> %357, float %365, i32 1
  %367 = extractelement <4 x i32> %312, i32 2
  %368 = icmp ne i32 %367, 0
  br i1 %368, label %369, label %371

; <label>:369                                     ; preds = %364
  %370 = extractelement <4 x float> %276, i32 2
  br label %373

; <label>:371                                     ; preds = %364
  %372 = extractelement <4 x float> %366, i32 2
  br label %373

; <label>:373                                     ; preds = %371, %369
  %374 = phi float [ %370, %369 ], [ %372, %371 ]
  %375 = insertelement <4 x float> %366, float %374, i32 2
  %376 = extractelement <4 x i32> %312, i32 3
  %377 = icmp ne i32 %376, 0
  br i1 %377, label %378, label %380

; <label>:378                                     ; preds = %373
  %379 = extractelement <4 x float> %276, i32 3
  br label %382

; <label>:380                                     ; preds = %373
  %381 = extractelement <4 x float> %375, i32 3
  br label %382

; <label>:382                                     ; preds = %380, %378
  %383 = phi float [ %379, %378 ], [ %381, %380 ]
  %384 = insertelement <4 x float> %375, float %383, i32 3
  %385 = mul <4 x i32> %312, <i32 16, i32 16, i32 16, i32 16>
  %386 = add <4 x i32> %ccount.0, %385
  br label %387

; <label>:387                                     ; preds = %382
  %388 = add i32 %iter.0, 16
  br label %89

; <label>:389                                     ; preds = %98, %89
  %390 = extractelement <4 x i32> %stay.0, i32 0
  %391 = extractelement <4 x i32> %stay.0, i32 1
  %392 = and i32 %390, %391
  %393 = extractelement <4 x i32> %stay.0, i32 2
  %394 = and i32 %392, %393
  %395 = extractelement <4 x i32> %stay.0, i32 3
  %396 = and i32 %394, %395
  %397 = icmp ne i32 %396, 0
  br i1 %397, label %555, label %398

; <label>:398                                     ; preds = %389
  br label %399

; <label>:399                                     ; preds = %552, %398
  %iter.1 = phi i32 [ 16, %398 ], [ %468, %552 ]
  %stay.1 = phi <4 x i32> [ %stay.0, %398 ], [ %455, %552 ]
  %ccount.1 = phi <4 x i32> [ %ccount.0, %398 ], [ %467, %552 ]
  %savx.1 = phi <4 x float> [ %savx.0, %398 ], [ %504, %552 ]
  %savy.1 = phi <4 x float> [ %savy.0, %398 ], [ %540, %552 ]
  %400 = extractelement <4 x float> %savx.1, i32 0
  %401 = extractelement <4 x float> %savx.1, i32 0
  %402 = extractelement <4 x float> %savy.1, i32 0
  %403 = extractelement <4 x float> %savy.1, i32 0
  %404 = fmul float %402, %403
  %405 = call float @llvm.fmuladd.f32(float %400, float %401, float %404)
  %406 = fcmp ole float %405, 4.000000e+00
  br i1 %406, label %407, label %410

; <label>:407                                     ; preds = %399
  %408 = extractelement <4 x i32> %ccount.1, i32 0
  %409 = icmp ult i32 %408, %maxIterations
  br label %410

; <label>:410                                     ; preds = %407, %399
  %411 = phi i1 [ false, %399 ], [ %409, %407 ]
  %412 = zext i1 %411 to i32
  %413 = insertelement <4 x i32> %stay.1, i32 %412, i32 0
  %414 = extractelement <4 x float> %savx.1, i32 1
  %415 = extractelement <4 x float> %savx.1, i32 1
  %416 = extractelement <4 x float> %savy.1, i32 1
  %417 = extractelement <4 x float> %savy.1, i32 1
  %418 = fmul float %416, %417
  %419 = call float @llvm.fmuladd.f32(float %414, float %415, float %418)
  %420 = fcmp ole float %419, 4.000000e+00
  br i1 %420, label %421, label %424

; <label>:421                                     ; preds = %410
  %422 = extractelement <4 x i32> %ccount.1, i32 1
  %423 = icmp ult i32 %422, %maxIterations
  br label %424

; <label>:424                                     ; preds = %421, %410
  %425 = phi i1 [ false, %410 ], [ %423, %421 ]
  %426 = zext i1 %425 to i32
  %427 = insertelement <4 x i32> %413, i32 %426, i32 1
  %428 = extractelement <4 x float> %savx.1, i32 2
  %429 = extractelement <4 x float> %savx.1, i32 2
  %430 = extractelement <4 x float> %savy.1, i32 2
  %431 = extractelement <4 x float> %savy.1, i32 2
  %432 = fmul float %430, %431
  %433 = call float @llvm.fmuladd.f32(float %428, float %429, float %432)
  %434 = fcmp ole float %433, 4.000000e+00
  br i1 %434, label %435, label %438

; <label>:435                                     ; preds = %424
  %436 = extractelement <4 x i32> %ccount.1, i32 2
  %437 = icmp ult i32 %436, %maxIterations
  br label %438

; <label>:438                                     ; preds = %435, %424
  %439 = phi i1 [ false, %424 ], [ %437, %435 ]
  %440 = zext i1 %439 to i32
  %441 = insertelement <4 x i32> %427, i32 %440, i32 2
  %442 = extractelement <4 x float> %savx.1, i32 3
  %443 = extractelement <4 x float> %savx.1, i32 3
  %444 = extractelement <4 x float> %savy.1, i32 3
  %445 = extractelement <4 x float> %savy.1, i32 3
  %446 = fmul float %444, %445
  %447 = call float @llvm.fmuladd.f32(float %442, float %443, float %446)
  %448 = fcmp ole float %447, 4.000000e+00
  br i1 %448, label %449, label %452

; <label>:449                                     ; preds = %438
  %450 = extractelement <4 x i32> %ccount.1, i32 3
  %451 = icmp ult i32 %450, %maxIterations
  br label %452

; <label>:452                                     ; preds = %449, %438
  %453 = phi i1 [ false, %438 ], [ %451, %449 ]
  %454 = zext i1 %453 to i32
  %455 = insertelement <4 x i32> %441, i32 %454, i32 3
  %456 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.1
  %457 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %savx.1, <4 x float> %savx.1, <4 x float> %36)
  %458 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %456, <4 x float> %savy.1, i32 %457)
  %459 = sitofp i32 %458 to float
  %460 = insertelement <4 x float> undef, float %459, i32 0
  %461 = shufflevector <4 x float> %460, <4 x float> undef, <4 x i32> zeroinitializer
  %462 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %savx.1
  %463 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %462, <4 x float> %savy.1, <4 x float> %52)
  %464 = sitofp i32 %463 to float
  %465 = insertelement <4 x float> undef, float %464, i32 0
  %466 = shufflevector <4 x float> %465, <4 x float> undef, <4 x i32> zeroinitializer
  %467 = add <4 x i32> %ccount.1, %455
  %468 = add i32 %iter.1, -1
  %469 = extractelement <4 x i32> %455, i32 0
  %470 = icmp ne i32 %469, 0
  br i1 %470, label %471, label %473

; <label>:471                                     ; preds = %452
  %472 = extractelement <4 x float> %461, i32 0
  br label %475

; <label>:473                                     ; preds = %452
  %474 = extractelement <4 x float> %savx.1, i32 0
  br label %475

; <label>:475                                     ; preds = %473, %471
  %476 = phi float [ %472, %471 ], [ %474, %473 ]
  %477 = insertelement <4 x float> %savx.1, float %476, i32 0
  %478 = extractelement <4 x i32> %455, i32 1
  %479 = icmp ne i32 %478, 0
  br i1 %479, label %480, label %482

; <label>:480                                     ; preds = %475
  %481 = extractelement <4 x float> %461, i32 1
  br label %484

; <label>:482                                     ; preds = %475
  %483 = extractelement <4 x float> %477, i32 1
  br label %484

; <label>:484                                     ; preds = %482, %480
  %485 = phi float [ %481, %480 ], [ %483, %482 ]
  %486 = insertelement <4 x float> %477, float %485, i32 1
  %487 = extractelement <4 x i32> %455, i32 2
  %488 = icmp ne i32 %487, 0
  br i1 %488, label %489, label %491

; <label>:489                                     ; preds = %484
  %490 = extractelement <4 x float> %461, i32 2
  br label %493

; <label>:491                                     ; preds = %484
  %492 = extractelement <4 x float> %486, i32 2
  br label %493

; <label>:493                                     ; preds = %491, %489
  %494 = phi float [ %490, %489 ], [ %492, %491 ]
  %495 = insertelement <4 x float> %486, float %494, i32 2
  %496 = extractelement <4 x i32> %455, i32 3
  %497 = icmp ne i32 %496, 0
  br i1 %497, label %498, label %500

; <label>:498                                     ; preds = %493
  %499 = extractelement <4 x float> %461, i32 3
  br label %502

; <label>:500                                     ; preds = %493
  %501 = extractelement <4 x float> %495, i32 3
  br label %502

; <label>:502                                     ; preds = %500, %498
  %503 = phi float [ %499, %498 ], [ %501, %500 ]
  %504 = insertelement <4 x float> %495, float %503, i32 3
  %505 = extractelement <4 x i32> %455, i32 0
  %506 = icmp ne i32 %505, 0
  br i1 %506, label %507, label %509

; <label>:507                                     ; preds = %502
  %508 = extractelement <4 x float> %466, i32 0
  br label %511

; <label>:509                                     ; preds = %502
  %510 = extractelement <4 x float> %savy.1, i32 0
  br label %511

; <label>:511                                     ; preds = %509, %507
  %512 = phi float [ %508, %507 ], [ %510, %509 ]
  %513 = insertelement <4 x float> %savy.1, float %512, i32 0
  %514 = extractelement <4 x i32> %455, i32 1
  %515 = icmp ne i32 %514, 0
  br i1 %515, label %516, label %518

; <label>:516                                     ; preds = %511
  %517 = extractelement <4 x float> %466, i32 1
  br label %520

; <label>:518                                     ; preds = %511
  %519 = extractelement <4 x float> %513, i32 1
  br label %520

; <label>:520                                     ; preds = %518, %516
  %521 = phi float [ %517, %516 ], [ %519, %518 ]
  %522 = insertelement <4 x float> %513, float %521, i32 1
  %523 = extractelement <4 x i32> %455, i32 2
  %524 = icmp ne i32 %523, 0
  br i1 %524, label %525, label %527

; <label>:525                                     ; preds = %520
  %526 = extractelement <4 x float> %466, i32 2
  br label %529

; <label>:527                                     ; preds = %520
  %528 = extractelement <4 x float> %522, i32 2
  br label %529

; <label>:529                                     ; preds = %527, %525
  %530 = phi float [ %526, %525 ], [ %528, %527 ]
  %531 = insertelement <4 x float> %522, float %530, i32 2
  %532 = extractelement <4 x i32> %455, i32 3
  %533 = icmp ne i32 %532, 0
  br i1 %533, label %534, label %536

; <label>:534                                     ; preds = %529
  %535 = extractelement <4 x float> %466, i32 3
  br label %538

; <label>:536                                     ; preds = %529
  %537 = extractelement <4 x float> %531, i32 3
  br label %538

; <label>:538                                     ; preds = %536, %534
  %539 = phi float [ %535, %534 ], [ %537, %536 ]
  %540 = insertelement <4 x float> %531, float %539, i32 3
  br label %541

; <label>:541                                     ; preds = %538
  %542 = extractelement <4 x i32> %455, i32 0
  %543 = extractelement <4 x i32> %455, i32 1
  %544 = or i32 %542, %543
  %545 = extractelement <4 x i32> %455, i32 2
  %546 = or i32 %544, %545
  %547 = extractelement <4 x i32> %455, i32 3
  %548 = or i32 %546, %547
  %549 = icmp ne i32 %548, 0
  br i1 %549, label %550, label %552

; <label>:550                                     ; preds = %541
  %551 = icmp ne i32 %468, 0
  br label %552

; <label>:552                                     ; preds = %550, %541
  %553 = phi i1 [ false, %541 ], [ %551, %550 ]
  br i1 %553, label %399, label %554

; <label>:554                                     ; preds = %552
  br label %555

; <label>:555                                     ; preds = %554, %389
  %ccount.2 = phi <4 x i32> [ %ccount.0, %389 ], [ %467, %554 ]
  %savx.2 = phi <4 x float> [ %savx.0, %389 ], [ %504, %554 ]
  %savy.2 = phi <4 x float> [ %savy.0, %389 ], [ %540, %554 ]
  %556 = call <4 x float> @_Z14convert_float4Dv4_i(<4 x i32> %ccount.2)
  %557 = extractelement <4 x i32> %ccount.2, i32 0
  %558 = sitofp i32 %557 to float
  %559 = fadd float %558, 1.000000e+00
  %560 = extractelement <4 x float> %savx.2, i32 0
  %561 = extractelement <4 x float> %savx.2, i32 0
  %562 = extractelement <4 x float> %savy.2, i32 0
  %563 = extractelement <4 x float> %savy.2, i32 0
  %564 = fmul float %562, %563
  %565 = call float @llvm.fmuladd.f32(float %560, float %561, float %564)
  %566 = call float @llvm.log2.f32(float %565)
  %567 = call float @llvm.log2.f32(float %566)
  %568 = fsub float %559, %567
  %569 = insertelement <4 x float> %556, float %568, i32 0
  %570 = extractelement <4 x i32> %ccount.2, i32 1
  %571 = sitofp i32 %570 to float
  %572 = fadd float %571, 1.000000e+00
  %573 = extractelement <4 x float> %savx.2, i32 1
  %574 = extractelement <4 x float> %savx.2, i32 1
  %575 = extractelement <4 x float> %savy.2, i32 1
  %576 = extractelement <4 x float> %savy.2, i32 1
  %577 = fmul float %575, %576
  %578 = call float @llvm.fmuladd.f32(float %573, float %574, float %577)
  %579 = call float @llvm.log2.f32(float %578)
  %580 = call float @llvm.log2.f32(float %579)
  %581 = fsub float %572, %580
  %582 = insertelement <4 x float> %569, float %581, i32 1
  %583 = extractelement <4 x i32> %ccount.2, i32 2
  %584 = sitofp i32 %583 to float
  %585 = fadd float %584, 1.000000e+00
  %586 = extractelement <4 x float> %savx.2, i32 2
  %587 = extractelement <4 x float> %savx.2, i32 2
  %588 = extractelement <4 x float> %savy.2, i32 2
  %589 = extractelement <4 x float> %savy.2, i32 2
  %590 = fmul float %588, %589
  %591 = call float @llvm.fmuladd.f32(float %586, float %587, float %590)
  %592 = call float @llvm.log2.f32(float %591)
  %593 = call float @llvm.log2.f32(float %592)
  %594 = fsub float %585, %593
  %595 = insertelement <4 x float> %582, float %594, i32 2
  %596 = extractelement <4 x i32> %ccount.2, i32 3
  %597 = sitofp i32 %596 to float
  %598 = fadd float %597, 1.000000e+00
  %599 = extractelement <4 x float> %savx.2, i32 3
  %600 = extractelement <4 x float> %savx.2, i32 3
  %601 = extractelement <4 x float> %savy.2, i32 3
  %602 = extractelement <4 x float> %savy.2, i32 3
  %603 = fmul float %601, %602
  %604 = call float @llvm.fmuladd.f32(float %599, float %600, float %603)
  %605 = call float @llvm.log2.f32(float %604)
  %606 = call float @llvm.log2.f32(float %605)
  %607 = fsub float %598, %606
  %608 = insertelement <4 x float> %595, float %607, i32 3
  %609 = extractelement <4 x float> %608, i32 0
  %610 = fmul float %609, 2.000000e+00
  %611 = fmul float %610, 0x400921FF20000000
  %612 = fdiv float %611, 2.560000e+02, !fpmath !2
  %613 = call float @_Z3cosf(float %612)
  %614 = fadd float 1.000000e+00, %613
  %615 = fmul float %614, 5.000000e-01
  %616 = fmul float %615, 2.550000e+02
  %617 = fptoui float %616 to i8
  %618 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %619 = load <4 x i8>* %618, align 4
  %620 = insertelement <4 x i8> %619, i8 %617, i32 0
  store <4 x i8> %620, <4 x i8>* %618, align 4
  %621 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %612, float 0x4000C154C0000000)
  %622 = call float @_Z3cosf(float %621)
  %623 = fadd float 1.000000e+00, %622
  %624 = fmul float %623, 5.000000e-01
  %625 = fmul float %624, 2.550000e+02
  %626 = fptoui float %625 to i8
  %627 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %628 = load <4 x i8>* %627, align 4
  %629 = insertelement <4 x i8> %628, i8 %626, i32 1
  store <4 x i8> %629, <4 x i8>* %627, align 4
  %630 = fsub float %612, 0x4000C154C0000000
  %631 = call float @_Z3cosf(float %630)
  %632 = fadd float 1.000000e+00, %631
  %633 = fmul float %632, 5.000000e-01
  %634 = fmul float %633, 2.550000e+02
  %635 = fptoui float %634 to i8
  %636 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %637 = load <4 x i8>* %636, align 4
  %638 = insertelement <4 x i8> %637, i8 %635, i32 2
  store <4 x i8> %638, <4 x i8>* %636, align 4
  %639 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %640 = load <4 x i8>* %639, align 4
  %641 = insertelement <4 x i8> %640, i8 -1, i32 3
  store <4 x i8> %641, <4 x i8>* %639, align 4
  %642 = extractelement <4 x i32> %ccount.2, i32 0
  %643 = icmp eq i32 %642, %maxIterations
  br i1 %643, label %644, label %654

; <label>:644                                     ; preds = %555
  %645 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %646 = load <4 x i8>* %645, align 4
  %647 = insertelement <4 x i8> %646, i8 0, i32 0
  store <4 x i8> %647, <4 x i8>* %645, align 4
  %648 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %649 = load <4 x i8>* %648, align 4
  %650 = insertelement <4 x i8> %649, i8 0, i32 1
  store <4 x i8> %650, <4 x i8>* %648, align 4
  %651 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %652 = load <4 x i8>* %651, align 4
  %653 = insertelement <4 x i8> %652, i8 0, i32 2
  store <4 x i8> %653, <4 x i8>* %651, align 4
  br label %654

; <label>:654                                     ; preds = %644, %555
  %655 = icmp ne i32 %bench, 0
  br i1 %655, label %656, label %684

; <label>:656                                     ; preds = %654
  %657 = extractelement <4 x i32> %ccount.2, i32 0
  %658 = and i32 %657, 255
  %659 = trunc i32 %658 to i8
  %660 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %661 = load <4 x i8>* %660, align 4
  %662 = insertelement <4 x i8> %661, i8 %659, i32 0
  store <4 x i8> %662, <4 x i8>* %660, align 4
  %663 = extractelement <4 x i32> %ccount.2, i32 0
  %664 = and i32 %663, 65280
  %665 = ashr i32 %664, 8
  %666 = trunc i32 %665 to i8
  %667 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %668 = load <4 x i8>* %667, align 4
  %669 = insertelement <4 x i8> %668, i8 %666, i32 1
  store <4 x i8> %669, <4 x i8>* %667, align 4
  %670 = extractelement <4 x i32> %ccount.2, i32 0
  %671 = and i32 %670, 16711680
  %672 = ashr i32 %671, 16
  %673 = trunc i32 %672 to i8
  %674 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %675 = load <4 x i8>* %674, align 4
  %676 = insertelement <4 x i8> %675, i8 %673, i32 2
  store <4 x i8> %676, <4 x i8>* %674, align 4
  %677 = extractelement <4 x i32> %ccount.2, i32 0
  %678 = and i32 %677, -16777216
  %679 = lshr i32 %678, 24
  %680 = trunc i32 %679 to i8
  %681 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %682 = load <4 x i8>* %681, align 4
  %683 = insertelement <4 x i8> %682, i8 %680, i32 3
  store <4 x i8> %683, <4 x i8>* %681, align 4
  br label %684

; <label>:684                                     ; preds = %656, %654
  %685 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %686 = load <4 x i8>* %685, align 4
  %687 = mul nsw i32 4, %1
  %688 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %687
  store <4 x i8> %686, <4 x i8> addrspace(1)* %688, align 4
  %689 = extractelement <4 x float> %608, i32 1
  %690 = fmul float %689, 2.000000e+00
  %691 = fmul float %690, 0x400921FF20000000
  %692 = fdiv float %691, 2.560000e+02, !fpmath !2
  %693 = call float @_Z3cosf(float %692)
  %694 = fadd float 1.000000e+00, %693
  %695 = fmul float %694, 5.000000e-01
  %696 = fmul float %695, 2.550000e+02
  %697 = fptoui float %696 to i8
  %698 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %699 = load <4 x i8>* %698, align 4
  %700 = insertelement <4 x i8> %699, i8 %697, i32 0
  store <4 x i8> %700, <4 x i8>* %698, align 4
  %701 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %692, float 0x4000C154C0000000)
  %702 = call float @_Z3cosf(float %701)
  %703 = fadd float 1.000000e+00, %702
  %704 = fmul float %703, 5.000000e-01
  %705 = fmul float %704, 2.550000e+02
  %706 = fptoui float %705 to i8
  %707 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %708 = load <4 x i8>* %707, align 4
  %709 = insertelement <4 x i8> %708, i8 %706, i32 1
  store <4 x i8> %709, <4 x i8>* %707, align 4
  %710 = fsub float %692, 0x4000C154C0000000
  %711 = call float @_Z3cosf(float %710)
  %712 = fadd float 1.000000e+00, %711
  %713 = fmul float %712, 5.000000e-01
  %714 = fmul float %713, 2.550000e+02
  %715 = fptoui float %714 to i8
  %716 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %717 = load <4 x i8>* %716, align 4
  %718 = insertelement <4 x i8> %717, i8 %715, i32 2
  store <4 x i8> %718, <4 x i8>* %716, align 4
  %719 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %720 = load <4 x i8>* %719, align 4
  %721 = insertelement <4 x i8> %720, i8 -1, i32 3
  store <4 x i8> %721, <4 x i8>* %719, align 4
  %722 = extractelement <4 x i32> %ccount.2, i32 1
  %723 = icmp eq i32 %722, %maxIterations
  br i1 %723, label %724, label %734

; <label>:724                                     ; preds = %684
  %725 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %726 = load <4 x i8>* %725, align 4
  %727 = insertelement <4 x i8> %726, i8 0, i32 0
  store <4 x i8> %727, <4 x i8>* %725, align 4
  %728 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %729 = load <4 x i8>* %728, align 4
  %730 = insertelement <4 x i8> %729, i8 0, i32 1
  store <4 x i8> %730, <4 x i8>* %728, align 4
  %731 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %732 = load <4 x i8>* %731, align 4
  %733 = insertelement <4 x i8> %732, i8 0, i32 2
  store <4 x i8> %733, <4 x i8>* %731, align 4
  br label %734

; <label>:734                                     ; preds = %724, %684
  %735 = icmp ne i32 %bench, 0
  br i1 %735, label %736, label %764

; <label>:736                                     ; preds = %734
  %737 = extractelement <4 x i32> %ccount.2, i32 1
  %738 = and i32 %737, 255
  %739 = trunc i32 %738 to i8
  %740 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %741 = load <4 x i8>* %740, align 4
  %742 = insertelement <4 x i8> %741, i8 %739, i32 0
  store <4 x i8> %742, <4 x i8>* %740, align 4
  %743 = extractelement <4 x i32> %ccount.2, i32 1
  %744 = and i32 %743, 65280
  %745 = ashr i32 %744, 8
  %746 = trunc i32 %745 to i8
  %747 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %748 = load <4 x i8>* %747, align 4
  %749 = insertelement <4 x i8> %748, i8 %746, i32 1
  store <4 x i8> %749, <4 x i8>* %747, align 4
  %750 = extractelement <4 x i32> %ccount.2, i32 1
  %751 = and i32 %750, 16711680
  %752 = ashr i32 %751, 16
  %753 = trunc i32 %752 to i8
  %754 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %755 = load <4 x i8>* %754, align 4
  %756 = insertelement <4 x i8> %755, i8 %753, i32 2
  store <4 x i8> %756, <4 x i8>* %754, align 4
  %757 = extractelement <4 x i32> %ccount.2, i32 1
  %758 = and i32 %757, -16777216
  %759 = lshr i32 %758, 24
  %760 = trunc i32 %759 to i8
  %761 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %762 = load <4 x i8>* %761, align 4
  %763 = insertelement <4 x i8> %762, i8 %760, i32 3
  store <4 x i8> %763, <4 x i8>* %761, align 4
  br label %764

; <label>:764                                     ; preds = %736, %734
  %765 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %766 = load <4 x i8>* %765, align 4
  %767 = mul nsw i32 4, %1
  %768 = add nsw i32 %767, 1
  %769 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %768
  store <4 x i8> %766, <4 x i8> addrspace(1)* %769, align 4
  %770 = extractelement <4 x float> %608, i32 2
  %771 = fmul float %770, 2.000000e+00
  %772 = fmul float %771, 0x400921FF20000000
  %773 = fdiv float %772, 2.560000e+02, !fpmath !2
  %774 = call float @_Z3cosf(float %773)
  %775 = fadd float 1.000000e+00, %774
  %776 = fmul float %775, 5.000000e-01
  %777 = fmul float %776, 2.550000e+02
  %778 = fptoui float %777 to i8
  %779 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %780 = load <4 x i8>* %779, align 4
  %781 = insertelement <4 x i8> %780, i8 %778, i32 0
  store <4 x i8> %781, <4 x i8>* %779, align 4
  %782 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %773, float 0x4000C154C0000000)
  %783 = call float @_Z3cosf(float %782)
  %784 = fadd float 1.000000e+00, %783
  %785 = fmul float %784, 5.000000e-01
  %786 = fmul float %785, 2.550000e+02
  %787 = fptoui float %786 to i8
  %788 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %789 = load <4 x i8>* %788, align 4
  %790 = insertelement <4 x i8> %789, i8 %787, i32 1
  store <4 x i8> %790, <4 x i8>* %788, align 4
  %791 = fsub float %773, 0x4000C154C0000000
  %792 = call float @_Z3cosf(float %791)
  %793 = fadd float 1.000000e+00, %792
  %794 = fmul float %793, 5.000000e-01
  %795 = fmul float %794, 2.550000e+02
  %796 = fptoui float %795 to i8
  %797 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %798 = load <4 x i8>* %797, align 4
  %799 = insertelement <4 x i8> %798, i8 %796, i32 2
  store <4 x i8> %799, <4 x i8>* %797, align 4
  %800 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %801 = load <4 x i8>* %800, align 4
  %802 = insertelement <4 x i8> %801, i8 -1, i32 3
  store <4 x i8> %802, <4 x i8>* %800, align 4
  %803 = extractelement <4 x i32> %ccount.2, i32 2
  %804 = icmp eq i32 %803, %maxIterations
  br i1 %804, label %805, label %815

; <label>:805                                     ; preds = %764
  %806 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %807 = load <4 x i8>* %806, align 4
  %808 = insertelement <4 x i8> %807, i8 0, i32 0
  store <4 x i8> %808, <4 x i8>* %806, align 4
  %809 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %810 = load <4 x i8>* %809, align 4
  %811 = insertelement <4 x i8> %810, i8 0, i32 1
  store <4 x i8> %811, <4 x i8>* %809, align 4
  %812 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %813 = load <4 x i8>* %812, align 4
  %814 = insertelement <4 x i8> %813, i8 0, i32 2
  store <4 x i8> %814, <4 x i8>* %812, align 4
  br label %815

; <label>:815                                     ; preds = %805, %764
  %816 = icmp ne i32 %bench, 0
  br i1 %816, label %817, label %845

; <label>:817                                     ; preds = %815
  %818 = extractelement <4 x i32> %ccount.2, i32 2
  %819 = and i32 %818, 255
  %820 = trunc i32 %819 to i8
  %821 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %822 = load <4 x i8>* %821, align 4
  %823 = insertelement <4 x i8> %822, i8 %820, i32 0
  store <4 x i8> %823, <4 x i8>* %821, align 4
  %824 = extractelement <4 x i32> %ccount.2, i32 2
  %825 = and i32 %824, 65280
  %826 = ashr i32 %825, 8
  %827 = trunc i32 %826 to i8
  %828 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %829 = load <4 x i8>* %828, align 4
  %830 = insertelement <4 x i8> %829, i8 %827, i32 1
  store <4 x i8> %830, <4 x i8>* %828, align 4
  %831 = extractelement <4 x i32> %ccount.2, i32 2
  %832 = and i32 %831, 16711680
  %833 = ashr i32 %832, 16
  %834 = trunc i32 %833 to i8
  %835 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %836 = load <4 x i8>* %835, align 4
  %837 = insertelement <4 x i8> %836, i8 %834, i32 2
  store <4 x i8> %837, <4 x i8>* %835, align 4
  %838 = extractelement <4 x i32> %ccount.2, i32 2
  %839 = and i32 %838, -16777216
  %840 = lshr i32 %839, 24
  %841 = trunc i32 %840 to i8
  %842 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %843 = load <4 x i8>* %842, align 4
  %844 = insertelement <4 x i8> %843, i8 %841, i32 3
  store <4 x i8> %844, <4 x i8>* %842, align 4
  br label %845

; <label>:845                                     ; preds = %817, %815
  %846 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %847 = load <4 x i8>* %846, align 4
  %848 = mul nsw i32 4, %1
  %849 = add nsw i32 %848, 2
  %850 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %849
  store <4 x i8> %847, <4 x i8> addrspace(1)* %850, align 4
  %851 = extractelement <4 x float> %608, i32 3
  %852 = fmul float %851, 2.000000e+00
  %853 = fmul float %852, 0x400921FF20000000
  %854 = fdiv float %853, 2.560000e+02, !fpmath !2
  %855 = call float @_Z3cosf(float %854)
  %856 = fadd float 1.000000e+00, %855
  %857 = fmul float %856, 5.000000e-01
  %858 = fmul float %857, 2.550000e+02
  %859 = fptoui float %858 to i8
  %860 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %861 = load <4 x i8>* %860, align 4
  %862 = insertelement <4 x i8> %861, i8 %859, i32 0
  store <4 x i8> %862, <4 x i8>* %860, align 4
  %863 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %854, float 0x4000C154C0000000)
  %864 = call float @_Z3cosf(float %863)
  %865 = fadd float 1.000000e+00, %864
  %866 = fmul float %865, 5.000000e-01
  %867 = fmul float %866, 2.550000e+02
  %868 = fptoui float %867 to i8
  %869 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %870 = load <4 x i8>* %869, align 4
  %871 = insertelement <4 x i8> %870, i8 %868, i32 1
  store <4 x i8> %871, <4 x i8>* %869, align 4
  %872 = fsub float %854, 0x4000C154C0000000
  %873 = call float @_Z3cosf(float %872)
  %874 = fadd float 1.000000e+00, %873
  %875 = fmul float %874, 5.000000e-01
  %876 = fmul float %875, 2.550000e+02
  %877 = fptoui float %876 to i8
  %878 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %879 = load <4 x i8>* %878, align 4
  %880 = insertelement <4 x i8> %879, i8 %877, i32 2
  store <4 x i8> %880, <4 x i8>* %878, align 4
  %881 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %882 = load <4 x i8>* %881, align 4
  %883 = insertelement <4 x i8> %882, i8 -1, i32 3
  store <4 x i8> %883, <4 x i8>* %881, align 4
  %884 = extractelement <4 x i32> %ccount.2, i32 3
  %885 = icmp eq i32 %884, %maxIterations
  br i1 %885, label %886, label %896

; <label>:886                                     ; preds = %845
  %887 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %888 = load <4 x i8>* %887, align 4
  %889 = insertelement <4 x i8> %888, i8 0, i32 0
  store <4 x i8> %889, <4 x i8>* %887, align 4
  %890 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %891 = load <4 x i8>* %890, align 4
  %892 = insertelement <4 x i8> %891, i8 0, i32 1
  store <4 x i8> %892, <4 x i8>* %890, align 4
  %893 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %894 = load <4 x i8>* %893, align 4
  %895 = insertelement <4 x i8> %894, i8 0, i32 2
  store <4 x i8> %895, <4 x i8>* %893, align 4
  br label %896

; <label>:896                                     ; preds = %886, %845
  %897 = icmp ne i32 %bench, 0
  br i1 %897, label %898, label %926

; <label>:898                                     ; preds = %896
  %899 = extractelement <4 x i32> %ccount.2, i32 3
  %900 = and i32 %899, 255
  %901 = trunc i32 %900 to i8
  %902 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %903 = load <4 x i8>* %902, align 4
  %904 = insertelement <4 x i8> %903, i8 %901, i32 0
  store <4 x i8> %904, <4 x i8>* %902, align 4
  %905 = extractelement <4 x i32> %ccount.2, i32 3
  %906 = and i32 %905, 65280
  %907 = ashr i32 %906, 8
  %908 = trunc i32 %907 to i8
  %909 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %910 = load <4 x i8>* %909, align 4
  %911 = insertelement <4 x i8> %910, i8 %908, i32 1
  store <4 x i8> %911, <4 x i8>* %909, align 4
  %912 = extractelement <4 x i32> %ccount.2, i32 3
  %913 = and i32 %912, 16711680
  %914 = ashr i32 %913, 16
  %915 = trunc i32 %914 to i8
  %916 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %917 = load <4 x i8>* %916, align 4
  %918 = insertelement <4 x i8> %917, i8 %915, i32 2
  store <4 x i8> %918, <4 x i8>* %916, align 4
  %919 = extractelement <4 x i32> %ccount.2, i32 3
  %920 = and i32 %919, -16777216
  %921 = lshr i32 %920, 24
  %922 = trunc i32 %921 to i8
  %923 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %924 = load <4 x i8>* %923, align 4
  %925 = insertelement <4 x i8> %924, i8 %922, i32 3
  store <4 x i8> %925, <4 x i8>* %923, align 4
  br label %926

; <label>:926                                     ; preds = %898, %896
  %927 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %928 = load <4 x i8>* %927, align 4
  %929 = mul nsw i32 4, %1
  %930 = add nsw i32 %929, 3
  %931 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i32 %930
  store <4 x i8> %928, <4 x i8> addrspace(1)* %931, align 4
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

declare i32 @MUL_ADD(...) #2

declare <4 x float> @_Z14convert_float4Dv4_i(<4 x i32>) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #3

declare float @_Z3cosf(float) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, float, float, float, float, i32, i32, i32)* @mandelbrot_vector_float}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

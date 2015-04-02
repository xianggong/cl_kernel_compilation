; ModuleID = '../kernel-src/Mandelbrot_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @mandelbrot_vector_float(<4 x i8> addrspace(1)* %mandelbrotImage, float %posx, float %posy, float %stepSizeX, float %stepSizeY, i32 %maxIterations, i32 %width, i32 %bench) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %tid = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %veci = alloca <4 x i32>, align 16
  %vecj = alloca <4 x i32>, align 16
  %x0 = alloca <4 x float>, align 16
  %y0 = alloca <4 x float>, align 16
  %x = alloca <4 x float>, align 16
  %y = alloca <4 x float>, align 16
  %iter = alloca i32, align 4
  %tmp = alloca <4 x float>, align 16
  %stay = alloca <4 x i32>, align 16
  %ccount = alloca <4 x i32>, align 16
  %savx = alloca <4 x float>, align 16
  %savy = alloca <4 x float>, align 16
  %fc = alloca <4 x float>, align 16
  %c = alloca float, align 4
  %color = alloca [4 x <4 x i8>], align 4
  store <4 x i8> addrspace(1)* %mandelbrotImage, <4 x i8> addrspace(1)** %1, align 4
  store float %posx, float* %2, align 4
  store float %posy, float* %3, align 4
  store float %stepSizeX, float* %4, align 4
  store float %stepSizeY, float* %5, align 4
  store i32 %maxIterations, i32* %6, align 4
  store i32 %width, i32* %7, align 4
  store i32 %bench, i32* %8, align 4
  %9 = call i32 @__get_global_id_u32(i32 0)
  store i32 %9, i32* %tid, align 4
  %10 = load i32* %tid, align 4
  %11 = load i32* %7, align 4
  %12 = sdiv i32 %11, 4
  %13 = srem i32 %10, %12
  store i32 %13, i32* %i, align 4
  %14 = load i32* %tid, align 4
  %15 = load i32* %7, align 4
  %16 = sdiv i32 %15, 4
  %17 = sdiv i32 %14, %16
  store i32 %17, i32* %j, align 4
  %18 = load i32* %i, align 4
  %19 = mul nsw i32 4, %18
  %20 = insertelement <4 x i32> undef, i32 %19, i32 0
  %21 = load i32* %i, align 4
  %22 = mul nsw i32 4, %21
  %23 = add nsw i32 %22, 1
  %24 = insertelement <4 x i32> %20, i32 %23, i32 1
  %25 = load i32* %i, align 4
  %26 = mul nsw i32 4, %25
  %27 = add nsw i32 %26, 2
  %28 = insertelement <4 x i32> %24, i32 %27, i32 2
  %29 = load i32* %i, align 4
  %30 = mul nsw i32 4, %29
  %31 = add nsw i32 %30, 3
  %32 = insertelement <4 x i32> %28, i32 %31, i32 3
  store <4 x i32> %32, <4 x i32>* %veci, align 16
  %33 = load i32* %j, align 4
  %34 = insertelement <4 x i32> undef, i32 %33, i32 0
  %35 = load i32* %j, align 4
  %36 = insertelement <4 x i32> %34, i32 %35, i32 1
  %37 = load i32* %j, align 4
  %38 = insertelement <4 x i32> %36, i32 %37, i32 2
  %39 = load i32* %j, align 4
  %40 = insertelement <4 x i32> %38, i32 %39, i32 3
  store <4 x i32> %40, <4 x i32>* %vecj, align 16
  %41 = load float* %2, align 4
  %42 = load float* %4, align 4
  %43 = load <4 x i32>* %veci, align 16
  %44 = extractelement <4 x i32> %43, i32 0
  %45 = sitofp i32 %44 to float
  %46 = call float @llvm.fmuladd.f32(float %42, float %45, float %41)
  %47 = load <4 x float>* %x0, align 16
  %48 = insertelement <4 x float> %47, float %46, i32 0
  store <4 x float> %48, <4 x float>* %x0, align 16
  %49 = load float* %2, align 4
  %50 = load float* %4, align 4
  %51 = load <4 x i32>* %veci, align 16
  %52 = extractelement <4 x i32> %51, i32 1
  %53 = sitofp i32 %52 to float
  %54 = call float @llvm.fmuladd.f32(float %50, float %53, float %49)
  %55 = load <4 x float>* %x0, align 16
  %56 = insertelement <4 x float> %55, float %54, i32 1
  store <4 x float> %56, <4 x float>* %x0, align 16
  %57 = load float* %2, align 4
  %58 = load float* %4, align 4
  %59 = load <4 x i32>* %veci, align 16
  %60 = extractelement <4 x i32> %59, i32 2
  %61 = sitofp i32 %60 to float
  %62 = call float @llvm.fmuladd.f32(float %58, float %61, float %57)
  %63 = load <4 x float>* %x0, align 16
  %64 = insertelement <4 x float> %63, float %62, i32 2
  store <4 x float> %64, <4 x float>* %x0, align 16
  %65 = load float* %2, align 4
  %66 = load float* %4, align 4
  %67 = load <4 x i32>* %veci, align 16
  %68 = extractelement <4 x i32> %67, i32 3
  %69 = sitofp i32 %68 to float
  %70 = call float @llvm.fmuladd.f32(float %66, float %69, float %65)
  %71 = load <4 x float>* %x0, align 16
  %72 = insertelement <4 x float> %71, float %70, i32 3
  store <4 x float> %72, <4 x float>* %x0, align 16
  %73 = load float* %3, align 4
  %74 = load float* %5, align 4
  %75 = load <4 x i32>* %vecj, align 16
  %76 = extractelement <4 x i32> %75, i32 0
  %77 = sitofp i32 %76 to float
  %78 = call float @llvm.fmuladd.f32(float %74, float %77, float %73)
  %79 = load <4 x float>* %y0, align 16
  %80 = insertelement <4 x float> %79, float %78, i32 0
  store <4 x float> %80, <4 x float>* %y0, align 16
  %81 = load float* %3, align 4
  %82 = load float* %5, align 4
  %83 = load <4 x i32>* %vecj, align 16
  %84 = extractelement <4 x i32> %83, i32 1
  %85 = sitofp i32 %84 to float
  %86 = call float @llvm.fmuladd.f32(float %82, float %85, float %81)
  %87 = load <4 x float>* %y0, align 16
  %88 = insertelement <4 x float> %87, float %86, i32 1
  store <4 x float> %88, <4 x float>* %y0, align 16
  %89 = load float* %3, align 4
  %90 = load float* %5, align 4
  %91 = load <4 x i32>* %vecj, align 16
  %92 = extractelement <4 x i32> %91, i32 2
  %93 = sitofp i32 %92 to float
  %94 = call float @llvm.fmuladd.f32(float %90, float %93, float %89)
  %95 = load <4 x float>* %y0, align 16
  %96 = insertelement <4 x float> %95, float %94, i32 2
  store <4 x float> %96, <4 x float>* %y0, align 16
  %97 = load float* %3, align 4
  %98 = load float* %5, align 4
  %99 = load <4 x i32>* %vecj, align 16
  %100 = extractelement <4 x i32> %99, i32 3
  %101 = sitofp i32 %100 to float
  %102 = call float @llvm.fmuladd.f32(float %98, float %101, float %97)
  %103 = load <4 x float>* %y0, align 16
  %104 = insertelement <4 x float> %103, float %102, i32 3
  store <4 x float> %104, <4 x float>* %y0, align 16
  %105 = load <4 x float>* %x0, align 16
  store <4 x float> %105, <4 x float>* %x, align 16
  %106 = load <4 x float>* %y0, align 16
  store <4 x float> %106, <4 x float>* %y, align 16
  store i32 0, i32* %iter, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %ccount, align 16
  %107 = load <4 x float>* %x, align 16
  %108 = extractelement <4 x float> %107, i32 0
  %109 = load <4 x float>* %x, align 16
  %110 = extractelement <4 x float> %109, i32 0
  %111 = load <4 x float>* %y, align 16
  %112 = extractelement <4 x float> %111, i32 0
  %113 = load <4 x float>* %y, align 16
  %114 = extractelement <4 x float> %113, i32 0
  %115 = fmul float %112, %114
  %116 = call float @llvm.fmuladd.f32(float %108, float %110, float %115)
  %117 = fcmp ole float %116, 4.000000e+00
  %118 = zext i1 %117 to i32
  %119 = load <4 x i32>* %stay, align 16
  %120 = insertelement <4 x i32> %119, i32 %118, i32 0
  store <4 x i32> %120, <4 x i32>* %stay, align 16
  %121 = load <4 x float>* %x, align 16
  %122 = extractelement <4 x float> %121, i32 1
  %123 = load <4 x float>* %x, align 16
  %124 = extractelement <4 x float> %123, i32 1
  %125 = load <4 x float>* %y, align 16
  %126 = extractelement <4 x float> %125, i32 1
  %127 = load <4 x float>* %y, align 16
  %128 = extractelement <4 x float> %127, i32 1
  %129 = fmul float %126, %128
  %130 = call float @llvm.fmuladd.f32(float %122, float %124, float %129)
  %131 = fcmp ole float %130, 4.000000e+00
  %132 = zext i1 %131 to i32
  %133 = load <4 x i32>* %stay, align 16
  %134 = insertelement <4 x i32> %133, i32 %132, i32 1
  store <4 x i32> %134, <4 x i32>* %stay, align 16
  %135 = load <4 x float>* %x, align 16
  %136 = extractelement <4 x float> %135, i32 2
  %137 = load <4 x float>* %x, align 16
  %138 = extractelement <4 x float> %137, i32 2
  %139 = load <4 x float>* %y, align 16
  %140 = extractelement <4 x float> %139, i32 2
  %141 = load <4 x float>* %y, align 16
  %142 = extractelement <4 x float> %141, i32 2
  %143 = fmul float %140, %142
  %144 = call float @llvm.fmuladd.f32(float %136, float %138, float %143)
  %145 = fcmp ole float %144, 4.000000e+00
  %146 = zext i1 %145 to i32
  %147 = load <4 x i32>* %stay, align 16
  %148 = insertelement <4 x i32> %147, i32 %146, i32 2
  store <4 x i32> %148, <4 x i32>* %stay, align 16
  %149 = load <4 x float>* %x, align 16
  %150 = extractelement <4 x float> %149, i32 3
  %151 = load <4 x float>* %x, align 16
  %152 = extractelement <4 x float> %151, i32 3
  %153 = load <4 x float>* %y, align 16
  %154 = extractelement <4 x float> %153, i32 3
  %155 = load <4 x float>* %y, align 16
  %156 = extractelement <4 x float> %155, i32 3
  %157 = fmul float %154, %156
  %158 = call float @llvm.fmuladd.f32(float %150, float %152, float %157)
  %159 = fcmp ole float %158, 4.000000e+00
  %160 = zext i1 %159 to i32
  %161 = load <4 x i32>* %stay, align 16
  %162 = insertelement <4 x i32> %161, i32 %160, i32 3
  store <4 x i32> %162, <4 x i32>* %stay, align 16
  %163 = load <4 x float>* %x, align 16
  store <4 x float> %163, <4 x float>* %savx, align 16
  %164 = load <4 x float>* %y, align 16
  store <4 x float> %164, <4 x float>* %savy, align 16
  store i32 0, i32* %iter, align 4
  br label %165

; <label>:165                                     ; preds = %653, %0
  %166 = load <4 x i32>* %stay, align 16
  %167 = extractelement <4 x i32> %166, i32 0
  %168 = load <4 x i32>* %stay, align 16
  %169 = extractelement <4 x i32> %168, i32 1
  %170 = or i32 %167, %169
  %171 = load <4 x i32>* %stay, align 16
  %172 = extractelement <4 x i32> %171, i32 2
  %173 = or i32 %170, %172
  %174 = load <4 x i32>* %stay, align 16
  %175 = extractelement <4 x i32> %174, i32 3
  %176 = or i32 %173, %175
  %177 = icmp ne i32 %176, 0
  br i1 %177, label %178, label %656

; <label>:178                                     ; preds = %165
  %179 = load i32* %iter, align 4
  %180 = load i32* %6, align 4
  %181 = icmp ult i32 %179, %180
  br i1 %181, label %182, label %656

; <label>:182                                     ; preds = %178
  %183 = load <4 x float>* %savx, align 16
  store <4 x float> %183, <4 x float>* %x, align 16
  %184 = load <4 x float>* %savy, align 16
  store <4 x float> %184, <4 x float>* %y, align 16
  %185 = load <4 x float>* %y, align 16
  %186 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %185
  %187 = load <4 x float>* %y, align 16
  %188 = load <4 x float>* %x, align 16
  %189 = load <4 x float>* %x, align 16
  %190 = load <4 x float>* %x0, align 16
  %191 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %188, <4 x float> %189, <4 x float> %190)
  %192 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %186, <4 x float> %187, i32 %191)
  %193 = sitofp i32 %192 to float
  %194 = insertelement <4 x float> undef, float %193, i32 0
  %195 = shufflevector <4 x float> %194, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %195, <4 x float>* %tmp, align 16
  %196 = load <4 x float>* %x, align 16
  %197 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %196
  %198 = load <4 x float>* %y, align 16
  %199 = load <4 x float>* %y0, align 16
  %200 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %197, <4 x float> %198, <4 x float> %199)
  %201 = sitofp i32 %200 to float
  %202 = insertelement <4 x float> undef, float %201, i32 0
  %203 = shufflevector <4 x float> %202, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %203, <4 x float>* %y, align 16
  %204 = load <4 x float>* %y, align 16
  %205 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %204
  %206 = load <4 x float>* %y, align 16
  %207 = load <4 x float>* %tmp, align 16
  %208 = load <4 x float>* %tmp, align 16
  %209 = load <4 x float>* %x0, align 16
  %210 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %207, <4 x float> %208, <4 x float> %209)
  %211 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %205, <4 x float> %206, i32 %210)
  %212 = sitofp i32 %211 to float
  %213 = insertelement <4 x float> undef, float %212, i32 0
  %214 = shufflevector <4 x float> %213, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %214, <4 x float>* %x, align 16
  %215 = load <4 x float>* %tmp, align 16
  %216 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %215
  %217 = load <4 x float>* %y, align 16
  %218 = load <4 x float>* %y0, align 16
  %219 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %216, <4 x float> %217, <4 x float> %218)
  %220 = sitofp i32 %219 to float
  %221 = insertelement <4 x float> undef, float %220, i32 0
  %222 = shufflevector <4 x float> %221, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %222, <4 x float>* %y, align 16
  %223 = load <4 x float>* %y, align 16
  %224 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %223
  %225 = load <4 x float>* %y, align 16
  %226 = load <4 x float>* %x, align 16
  %227 = load <4 x float>* %x, align 16
  %228 = load <4 x float>* %x0, align 16
  %229 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %226, <4 x float> %227, <4 x float> %228)
  %230 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %224, <4 x float> %225, i32 %229)
  %231 = sitofp i32 %230 to float
  %232 = insertelement <4 x float> undef, float %231, i32 0
  %233 = shufflevector <4 x float> %232, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %233, <4 x float>* %tmp, align 16
  %234 = load <4 x float>* %x, align 16
  %235 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %234
  %236 = load <4 x float>* %y, align 16
  %237 = load <4 x float>* %y0, align 16
  %238 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %235, <4 x float> %236, <4 x float> %237)
  %239 = sitofp i32 %238 to float
  %240 = insertelement <4 x float> undef, float %239, i32 0
  %241 = shufflevector <4 x float> %240, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %241, <4 x float>* %y, align 16
  %242 = load <4 x float>* %y, align 16
  %243 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %242
  %244 = load <4 x float>* %y, align 16
  %245 = load <4 x float>* %tmp, align 16
  %246 = load <4 x float>* %tmp, align 16
  %247 = load <4 x float>* %x0, align 16
  %248 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %245, <4 x float> %246, <4 x float> %247)
  %249 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %243, <4 x float> %244, i32 %248)
  %250 = sitofp i32 %249 to float
  %251 = insertelement <4 x float> undef, float %250, i32 0
  %252 = shufflevector <4 x float> %251, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %252, <4 x float>* %x, align 16
  %253 = load <4 x float>* %tmp, align 16
  %254 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %253
  %255 = load <4 x float>* %y, align 16
  %256 = load <4 x float>* %y0, align 16
  %257 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %254, <4 x float> %255, <4 x float> %256)
  %258 = sitofp i32 %257 to float
  %259 = insertelement <4 x float> undef, float %258, i32 0
  %260 = shufflevector <4 x float> %259, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %260, <4 x float>* %y, align 16
  %261 = load <4 x float>* %y, align 16
  %262 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %261
  %263 = load <4 x float>* %y, align 16
  %264 = load <4 x float>* %x, align 16
  %265 = load <4 x float>* %x, align 16
  %266 = load <4 x float>* %x0, align 16
  %267 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %264, <4 x float> %265, <4 x float> %266)
  %268 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %262, <4 x float> %263, i32 %267)
  %269 = sitofp i32 %268 to float
  %270 = insertelement <4 x float> undef, float %269, i32 0
  %271 = shufflevector <4 x float> %270, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %271, <4 x float>* %tmp, align 16
  %272 = load <4 x float>* %x, align 16
  %273 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %272
  %274 = load <4 x float>* %y, align 16
  %275 = load <4 x float>* %y0, align 16
  %276 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %273, <4 x float> %274, <4 x float> %275)
  %277 = sitofp i32 %276 to float
  %278 = insertelement <4 x float> undef, float %277, i32 0
  %279 = shufflevector <4 x float> %278, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %279, <4 x float>* %y, align 16
  %280 = load <4 x float>* %y, align 16
  %281 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %280
  %282 = load <4 x float>* %y, align 16
  %283 = load <4 x float>* %tmp, align 16
  %284 = load <4 x float>* %tmp, align 16
  %285 = load <4 x float>* %x0, align 16
  %286 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %283, <4 x float> %284, <4 x float> %285)
  %287 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %281, <4 x float> %282, i32 %286)
  %288 = sitofp i32 %287 to float
  %289 = insertelement <4 x float> undef, float %288, i32 0
  %290 = shufflevector <4 x float> %289, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %290, <4 x float>* %x, align 16
  %291 = load <4 x float>* %tmp, align 16
  %292 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %291
  %293 = load <4 x float>* %y, align 16
  %294 = load <4 x float>* %y0, align 16
  %295 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %292, <4 x float> %293, <4 x float> %294)
  %296 = sitofp i32 %295 to float
  %297 = insertelement <4 x float> undef, float %296, i32 0
  %298 = shufflevector <4 x float> %297, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %298, <4 x float>* %y, align 16
  %299 = load <4 x float>* %y, align 16
  %300 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %299
  %301 = load <4 x float>* %y, align 16
  %302 = load <4 x float>* %x, align 16
  %303 = load <4 x float>* %x, align 16
  %304 = load <4 x float>* %x0, align 16
  %305 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %302, <4 x float> %303, <4 x float> %304)
  %306 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %300, <4 x float> %301, i32 %305)
  %307 = sitofp i32 %306 to float
  %308 = insertelement <4 x float> undef, float %307, i32 0
  %309 = shufflevector <4 x float> %308, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %309, <4 x float>* %tmp, align 16
  %310 = load <4 x float>* %x, align 16
  %311 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %310
  %312 = load <4 x float>* %y, align 16
  %313 = load <4 x float>* %y0, align 16
  %314 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %311, <4 x float> %312, <4 x float> %313)
  %315 = sitofp i32 %314 to float
  %316 = insertelement <4 x float> undef, float %315, i32 0
  %317 = shufflevector <4 x float> %316, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %317, <4 x float>* %y, align 16
  %318 = load <4 x float>* %y, align 16
  %319 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %318
  %320 = load <4 x float>* %y, align 16
  %321 = load <4 x float>* %tmp, align 16
  %322 = load <4 x float>* %tmp, align 16
  %323 = load <4 x float>* %x0, align 16
  %324 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %321, <4 x float> %322, <4 x float> %323)
  %325 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %319, <4 x float> %320, i32 %324)
  %326 = sitofp i32 %325 to float
  %327 = insertelement <4 x float> undef, float %326, i32 0
  %328 = shufflevector <4 x float> %327, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %328, <4 x float>* %x, align 16
  %329 = load <4 x float>* %tmp, align 16
  %330 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %329
  %331 = load <4 x float>* %y, align 16
  %332 = load <4 x float>* %y0, align 16
  %333 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %330, <4 x float> %331, <4 x float> %332)
  %334 = sitofp i32 %333 to float
  %335 = insertelement <4 x float> undef, float %334, i32 0
  %336 = shufflevector <4 x float> %335, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %336, <4 x float>* %y, align 16
  %337 = load <4 x float>* %y, align 16
  %338 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %337
  %339 = load <4 x float>* %y, align 16
  %340 = load <4 x float>* %x, align 16
  %341 = load <4 x float>* %x, align 16
  %342 = load <4 x float>* %x0, align 16
  %343 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %340, <4 x float> %341, <4 x float> %342)
  %344 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %338, <4 x float> %339, i32 %343)
  %345 = sitofp i32 %344 to float
  %346 = insertelement <4 x float> undef, float %345, i32 0
  %347 = shufflevector <4 x float> %346, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %347, <4 x float>* %tmp, align 16
  %348 = load <4 x float>* %x, align 16
  %349 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %348
  %350 = load <4 x float>* %y, align 16
  %351 = load <4 x float>* %y0, align 16
  %352 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %349, <4 x float> %350, <4 x float> %351)
  %353 = sitofp i32 %352 to float
  %354 = insertelement <4 x float> undef, float %353, i32 0
  %355 = shufflevector <4 x float> %354, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %355, <4 x float>* %y, align 16
  %356 = load <4 x float>* %y, align 16
  %357 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %356
  %358 = load <4 x float>* %y, align 16
  %359 = load <4 x float>* %tmp, align 16
  %360 = load <4 x float>* %tmp, align 16
  %361 = load <4 x float>* %x0, align 16
  %362 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %359, <4 x float> %360, <4 x float> %361)
  %363 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %357, <4 x float> %358, i32 %362)
  %364 = sitofp i32 %363 to float
  %365 = insertelement <4 x float> undef, float %364, i32 0
  %366 = shufflevector <4 x float> %365, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %366, <4 x float>* %x, align 16
  %367 = load <4 x float>* %tmp, align 16
  %368 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %367
  %369 = load <4 x float>* %y, align 16
  %370 = load <4 x float>* %y0, align 16
  %371 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %368, <4 x float> %369, <4 x float> %370)
  %372 = sitofp i32 %371 to float
  %373 = insertelement <4 x float> undef, float %372, i32 0
  %374 = shufflevector <4 x float> %373, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %374, <4 x float>* %y, align 16
  %375 = load <4 x float>* %y, align 16
  %376 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %375
  %377 = load <4 x float>* %y, align 16
  %378 = load <4 x float>* %x, align 16
  %379 = load <4 x float>* %x, align 16
  %380 = load <4 x float>* %x0, align 16
  %381 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %378, <4 x float> %379, <4 x float> %380)
  %382 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %376, <4 x float> %377, i32 %381)
  %383 = sitofp i32 %382 to float
  %384 = insertelement <4 x float> undef, float %383, i32 0
  %385 = shufflevector <4 x float> %384, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %385, <4 x float>* %tmp, align 16
  %386 = load <4 x float>* %x, align 16
  %387 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %386
  %388 = load <4 x float>* %y, align 16
  %389 = load <4 x float>* %y0, align 16
  %390 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %387, <4 x float> %388, <4 x float> %389)
  %391 = sitofp i32 %390 to float
  %392 = insertelement <4 x float> undef, float %391, i32 0
  %393 = shufflevector <4 x float> %392, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %393, <4 x float>* %y, align 16
  %394 = load <4 x float>* %y, align 16
  %395 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %394
  %396 = load <4 x float>* %y, align 16
  %397 = load <4 x float>* %tmp, align 16
  %398 = load <4 x float>* %tmp, align 16
  %399 = load <4 x float>* %x0, align 16
  %400 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %397, <4 x float> %398, <4 x float> %399)
  %401 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %395, <4 x float> %396, i32 %400)
  %402 = sitofp i32 %401 to float
  %403 = insertelement <4 x float> undef, float %402, i32 0
  %404 = shufflevector <4 x float> %403, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %404, <4 x float>* %x, align 16
  %405 = load <4 x float>* %tmp, align 16
  %406 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %405
  %407 = load <4 x float>* %y, align 16
  %408 = load <4 x float>* %y0, align 16
  %409 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %406, <4 x float> %407, <4 x float> %408)
  %410 = sitofp i32 %409 to float
  %411 = insertelement <4 x float> undef, float %410, i32 0
  %412 = shufflevector <4 x float> %411, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %412, <4 x float>* %y, align 16
  %413 = load <4 x float>* %y, align 16
  %414 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %413
  %415 = load <4 x float>* %y, align 16
  %416 = load <4 x float>* %x, align 16
  %417 = load <4 x float>* %x, align 16
  %418 = load <4 x float>* %x0, align 16
  %419 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %416, <4 x float> %417, <4 x float> %418)
  %420 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %414, <4 x float> %415, i32 %419)
  %421 = sitofp i32 %420 to float
  %422 = insertelement <4 x float> undef, float %421, i32 0
  %423 = shufflevector <4 x float> %422, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %423, <4 x float>* %tmp, align 16
  %424 = load <4 x float>* %x, align 16
  %425 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %424
  %426 = load <4 x float>* %y, align 16
  %427 = load <4 x float>* %y0, align 16
  %428 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %425, <4 x float> %426, <4 x float> %427)
  %429 = sitofp i32 %428 to float
  %430 = insertelement <4 x float> undef, float %429, i32 0
  %431 = shufflevector <4 x float> %430, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %431, <4 x float>* %y, align 16
  %432 = load <4 x float>* %y, align 16
  %433 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %432
  %434 = load <4 x float>* %y, align 16
  %435 = load <4 x float>* %tmp, align 16
  %436 = load <4 x float>* %tmp, align 16
  %437 = load <4 x float>* %x0, align 16
  %438 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %435, <4 x float> %436, <4 x float> %437)
  %439 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %433, <4 x float> %434, i32 %438)
  %440 = sitofp i32 %439 to float
  %441 = insertelement <4 x float> undef, float %440, i32 0
  %442 = shufflevector <4 x float> %441, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %442, <4 x float>* %x, align 16
  %443 = load <4 x float>* %tmp, align 16
  %444 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %443
  %445 = load <4 x float>* %y, align 16
  %446 = load <4 x float>* %y0, align 16
  %447 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %444, <4 x float> %445, <4 x float> %446)
  %448 = sitofp i32 %447 to float
  %449 = insertelement <4 x float> undef, float %448, i32 0
  %450 = shufflevector <4 x float> %449, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %450, <4 x float>* %y, align 16
  %451 = load <4 x float>* %y, align 16
  %452 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %451
  %453 = load <4 x float>* %y, align 16
  %454 = load <4 x float>* %x, align 16
  %455 = load <4 x float>* %x, align 16
  %456 = load <4 x float>* %x0, align 16
  %457 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %454, <4 x float> %455, <4 x float> %456)
  %458 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %452, <4 x float> %453, i32 %457)
  %459 = sitofp i32 %458 to float
  %460 = insertelement <4 x float> undef, float %459, i32 0
  %461 = shufflevector <4 x float> %460, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %461, <4 x float>* %tmp, align 16
  %462 = load <4 x float>* %x, align 16
  %463 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %462
  %464 = load <4 x float>* %y, align 16
  %465 = load <4 x float>* %y0, align 16
  %466 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %463, <4 x float> %464, <4 x float> %465)
  %467 = sitofp i32 %466 to float
  %468 = insertelement <4 x float> undef, float %467, i32 0
  %469 = shufflevector <4 x float> %468, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %469, <4 x float>* %y, align 16
  %470 = load <4 x float>* %y, align 16
  %471 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %470
  %472 = load <4 x float>* %y, align 16
  %473 = load <4 x float>* %tmp, align 16
  %474 = load <4 x float>* %tmp, align 16
  %475 = load <4 x float>* %x0, align 16
  %476 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %473, <4 x float> %474, <4 x float> %475)
  %477 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %471, <4 x float> %472, i32 %476)
  %478 = sitofp i32 %477 to float
  %479 = insertelement <4 x float> undef, float %478, i32 0
  %480 = shufflevector <4 x float> %479, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %480, <4 x float>* %x, align 16
  %481 = load <4 x float>* %tmp, align 16
  %482 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %481
  %483 = load <4 x float>* %y, align 16
  %484 = load <4 x float>* %y0, align 16
  %485 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %482, <4 x float> %483, <4 x float> %484)
  %486 = sitofp i32 %485 to float
  %487 = insertelement <4 x float> undef, float %486, i32 0
  %488 = shufflevector <4 x float> %487, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %488, <4 x float>* %y, align 16
  %489 = load <4 x float>* %x, align 16
  %490 = extractelement <4 x float> %489, i32 0
  %491 = load <4 x float>* %x, align 16
  %492 = extractelement <4 x float> %491, i32 0
  %493 = load <4 x float>* %y, align 16
  %494 = extractelement <4 x float> %493, i32 0
  %495 = load <4 x float>* %y, align 16
  %496 = extractelement <4 x float> %495, i32 0
  %497 = fmul float %494, %496
  %498 = call float @llvm.fmuladd.f32(float %490, float %492, float %497)
  %499 = fcmp ole float %498, 4.000000e+00
  %500 = zext i1 %499 to i32
  %501 = load <4 x i32>* %stay, align 16
  %502 = insertelement <4 x i32> %501, i32 %500, i32 0
  store <4 x i32> %502, <4 x i32>* %stay, align 16
  %503 = load <4 x float>* %x, align 16
  %504 = extractelement <4 x float> %503, i32 1
  %505 = load <4 x float>* %x, align 16
  %506 = extractelement <4 x float> %505, i32 1
  %507 = load <4 x float>* %y, align 16
  %508 = extractelement <4 x float> %507, i32 1
  %509 = load <4 x float>* %y, align 16
  %510 = extractelement <4 x float> %509, i32 1
  %511 = fmul float %508, %510
  %512 = call float @llvm.fmuladd.f32(float %504, float %506, float %511)
  %513 = fcmp ole float %512, 4.000000e+00
  %514 = zext i1 %513 to i32
  %515 = load <4 x i32>* %stay, align 16
  %516 = insertelement <4 x i32> %515, i32 %514, i32 1
  store <4 x i32> %516, <4 x i32>* %stay, align 16
  %517 = load <4 x float>* %x, align 16
  %518 = extractelement <4 x float> %517, i32 2
  %519 = load <4 x float>* %x, align 16
  %520 = extractelement <4 x float> %519, i32 2
  %521 = load <4 x float>* %y, align 16
  %522 = extractelement <4 x float> %521, i32 2
  %523 = load <4 x float>* %y, align 16
  %524 = extractelement <4 x float> %523, i32 2
  %525 = fmul float %522, %524
  %526 = call float @llvm.fmuladd.f32(float %518, float %520, float %525)
  %527 = fcmp ole float %526, 4.000000e+00
  %528 = zext i1 %527 to i32
  %529 = load <4 x i32>* %stay, align 16
  %530 = insertelement <4 x i32> %529, i32 %528, i32 2
  store <4 x i32> %530, <4 x i32>* %stay, align 16
  %531 = load <4 x float>* %x, align 16
  %532 = extractelement <4 x float> %531, i32 3
  %533 = load <4 x float>* %x, align 16
  %534 = extractelement <4 x float> %533, i32 3
  %535 = load <4 x float>* %y, align 16
  %536 = extractelement <4 x float> %535, i32 3
  %537 = load <4 x float>* %y, align 16
  %538 = extractelement <4 x float> %537, i32 3
  %539 = fmul float %536, %538
  %540 = call float @llvm.fmuladd.f32(float %532, float %534, float %539)
  %541 = fcmp ole float %540, 4.000000e+00
  %542 = zext i1 %541 to i32
  %543 = load <4 x i32>* %stay, align 16
  %544 = insertelement <4 x i32> %543, i32 %542, i32 3
  store <4 x i32> %544, <4 x i32>* %stay, align 16
  %545 = load <4 x i32>* %stay, align 16
  %546 = extractelement <4 x i32> %545, i32 0
  %547 = icmp ne i32 %546, 0
  br i1 %547, label %548, label %551

; <label>:548                                     ; preds = %182
  %549 = load <4 x float>* %x, align 16
  %550 = extractelement <4 x float> %549, i32 0
  br label %554

; <label>:551                                     ; preds = %182
  %552 = load <4 x float>* %savx, align 16
  %553 = extractelement <4 x float> %552, i32 0
  br label %554

; <label>:554                                     ; preds = %551, %548
  %555 = phi float [ %550, %548 ], [ %553, %551 ]
  %556 = load <4 x float>* %savx, align 16
  %557 = insertelement <4 x float> %556, float %555, i32 0
  store <4 x float> %557, <4 x float>* %savx, align 16
  %558 = load <4 x i32>* %stay, align 16
  %559 = extractelement <4 x i32> %558, i32 1
  %560 = icmp ne i32 %559, 0
  br i1 %560, label %561, label %564

; <label>:561                                     ; preds = %554
  %562 = load <4 x float>* %x, align 16
  %563 = extractelement <4 x float> %562, i32 1
  br label %567

; <label>:564                                     ; preds = %554
  %565 = load <4 x float>* %savx, align 16
  %566 = extractelement <4 x float> %565, i32 1
  br label %567

; <label>:567                                     ; preds = %564, %561
  %568 = phi float [ %563, %561 ], [ %566, %564 ]
  %569 = load <4 x float>* %savx, align 16
  %570 = insertelement <4 x float> %569, float %568, i32 1
  store <4 x float> %570, <4 x float>* %savx, align 16
  %571 = load <4 x i32>* %stay, align 16
  %572 = extractelement <4 x i32> %571, i32 2
  %573 = icmp ne i32 %572, 0
  br i1 %573, label %574, label %577

; <label>:574                                     ; preds = %567
  %575 = load <4 x float>* %x, align 16
  %576 = extractelement <4 x float> %575, i32 2
  br label %580

; <label>:577                                     ; preds = %567
  %578 = load <4 x float>* %savx, align 16
  %579 = extractelement <4 x float> %578, i32 2
  br label %580

; <label>:580                                     ; preds = %577, %574
  %581 = phi float [ %576, %574 ], [ %579, %577 ]
  %582 = load <4 x float>* %savx, align 16
  %583 = insertelement <4 x float> %582, float %581, i32 2
  store <4 x float> %583, <4 x float>* %savx, align 16
  %584 = load <4 x i32>* %stay, align 16
  %585 = extractelement <4 x i32> %584, i32 3
  %586 = icmp ne i32 %585, 0
  br i1 %586, label %587, label %590

; <label>:587                                     ; preds = %580
  %588 = load <4 x float>* %x, align 16
  %589 = extractelement <4 x float> %588, i32 3
  br label %593

; <label>:590                                     ; preds = %580
  %591 = load <4 x float>* %savx, align 16
  %592 = extractelement <4 x float> %591, i32 3
  br label %593

; <label>:593                                     ; preds = %590, %587
  %594 = phi float [ %589, %587 ], [ %592, %590 ]
  %595 = load <4 x float>* %savx, align 16
  %596 = insertelement <4 x float> %595, float %594, i32 3
  store <4 x float> %596, <4 x float>* %savx, align 16
  %597 = load <4 x i32>* %stay, align 16
  %598 = extractelement <4 x i32> %597, i32 0
  %599 = icmp ne i32 %598, 0
  br i1 %599, label %600, label %603

; <label>:600                                     ; preds = %593
  %601 = load <4 x float>* %y, align 16
  %602 = extractelement <4 x float> %601, i32 0
  br label %606

; <label>:603                                     ; preds = %593
  %604 = load <4 x float>* %savy, align 16
  %605 = extractelement <4 x float> %604, i32 0
  br label %606

; <label>:606                                     ; preds = %603, %600
  %607 = phi float [ %602, %600 ], [ %605, %603 ]
  %608 = load <4 x float>* %savy, align 16
  %609 = insertelement <4 x float> %608, float %607, i32 0
  store <4 x float> %609, <4 x float>* %savy, align 16
  %610 = load <4 x i32>* %stay, align 16
  %611 = extractelement <4 x i32> %610, i32 1
  %612 = icmp ne i32 %611, 0
  br i1 %612, label %613, label %616

; <label>:613                                     ; preds = %606
  %614 = load <4 x float>* %y, align 16
  %615 = extractelement <4 x float> %614, i32 1
  br label %619

; <label>:616                                     ; preds = %606
  %617 = load <4 x float>* %savy, align 16
  %618 = extractelement <4 x float> %617, i32 1
  br label %619

; <label>:619                                     ; preds = %616, %613
  %620 = phi float [ %615, %613 ], [ %618, %616 ]
  %621 = load <4 x float>* %savy, align 16
  %622 = insertelement <4 x float> %621, float %620, i32 1
  store <4 x float> %622, <4 x float>* %savy, align 16
  %623 = load <4 x i32>* %stay, align 16
  %624 = extractelement <4 x i32> %623, i32 2
  %625 = icmp ne i32 %624, 0
  br i1 %625, label %626, label %629

; <label>:626                                     ; preds = %619
  %627 = load <4 x float>* %y, align 16
  %628 = extractelement <4 x float> %627, i32 2
  br label %632

; <label>:629                                     ; preds = %619
  %630 = load <4 x float>* %savy, align 16
  %631 = extractelement <4 x float> %630, i32 2
  br label %632

; <label>:632                                     ; preds = %629, %626
  %633 = phi float [ %628, %626 ], [ %631, %629 ]
  %634 = load <4 x float>* %savy, align 16
  %635 = insertelement <4 x float> %634, float %633, i32 2
  store <4 x float> %635, <4 x float>* %savy, align 16
  %636 = load <4 x i32>* %stay, align 16
  %637 = extractelement <4 x i32> %636, i32 3
  %638 = icmp ne i32 %637, 0
  br i1 %638, label %639, label %642

; <label>:639                                     ; preds = %632
  %640 = load <4 x float>* %y, align 16
  %641 = extractelement <4 x float> %640, i32 3
  br label %645

; <label>:642                                     ; preds = %632
  %643 = load <4 x float>* %savy, align 16
  %644 = extractelement <4 x float> %643, i32 3
  br label %645

; <label>:645                                     ; preds = %642, %639
  %646 = phi float [ %641, %639 ], [ %644, %642 ]
  %647 = load <4 x float>* %savy, align 16
  %648 = insertelement <4 x float> %647, float %646, i32 3
  store <4 x float> %648, <4 x float>* %savy, align 16
  %649 = load <4 x i32>* %stay, align 16
  %650 = mul <4 x i32> %649, <i32 16, i32 16, i32 16, i32 16>
  %651 = load <4 x i32>* %ccount, align 16
  %652 = add <4 x i32> %651, %650
  store <4 x i32> %652, <4 x i32>* %ccount, align 16
  br label %653

; <label>:653                                     ; preds = %645
  %654 = load i32* %iter, align 4
  %655 = add i32 %654, 16
  store i32 %655, i32* %iter, align 4
  br label %165

; <label>:656                                     ; preds = %178, %165
  %657 = load <4 x i32>* %stay, align 16
  %658 = extractelement <4 x i32> %657, i32 0
  %659 = load <4 x i32>* %stay, align 16
  %660 = extractelement <4 x i32> %659, i32 1
  %661 = and i32 %658, %660
  %662 = load <4 x i32>* %stay, align 16
  %663 = extractelement <4 x i32> %662, i32 2
  %664 = and i32 %661, %663
  %665 = load <4 x i32>* %stay, align 16
  %666 = extractelement <4 x i32> %665, i32 3
  %667 = and i32 %664, %666
  %668 = icmp ne i32 %667, 0
  br i1 %668, label %905, label %669

; <label>:669                                     ; preds = %656
  store i32 16, i32* %iter, align 4
  br label %670

; <label>:670                                     ; preds = %902, %669
  %671 = load <4 x float>* %savx, align 16
  store <4 x float> %671, <4 x float>* %x, align 16
  %672 = load <4 x float>* %savy, align 16
  store <4 x float> %672, <4 x float>* %y, align 16
  %673 = load <4 x float>* %x, align 16
  %674 = extractelement <4 x float> %673, i32 0
  %675 = load <4 x float>* %x, align 16
  %676 = extractelement <4 x float> %675, i32 0
  %677 = load <4 x float>* %y, align 16
  %678 = extractelement <4 x float> %677, i32 0
  %679 = load <4 x float>* %y, align 16
  %680 = extractelement <4 x float> %679, i32 0
  %681 = fmul float %678, %680
  %682 = call float @llvm.fmuladd.f32(float %674, float %676, float %681)
  %683 = fcmp ole float %682, 4.000000e+00
  br i1 %683, label %684, label %689

; <label>:684                                     ; preds = %670
  %685 = load <4 x i32>* %ccount, align 16
  %686 = extractelement <4 x i32> %685, i32 0
  %687 = load i32* %6, align 4
  %688 = icmp ult i32 %686, %687
  br label %689

; <label>:689                                     ; preds = %684, %670
  %690 = phi i1 [ false, %670 ], [ %688, %684 ]
  %691 = zext i1 %690 to i32
  %692 = load <4 x i32>* %stay, align 16
  %693 = insertelement <4 x i32> %692, i32 %691, i32 0
  store <4 x i32> %693, <4 x i32>* %stay, align 16
  %694 = load <4 x float>* %x, align 16
  %695 = extractelement <4 x float> %694, i32 1
  %696 = load <4 x float>* %x, align 16
  %697 = extractelement <4 x float> %696, i32 1
  %698 = load <4 x float>* %y, align 16
  %699 = extractelement <4 x float> %698, i32 1
  %700 = load <4 x float>* %y, align 16
  %701 = extractelement <4 x float> %700, i32 1
  %702 = fmul float %699, %701
  %703 = call float @llvm.fmuladd.f32(float %695, float %697, float %702)
  %704 = fcmp ole float %703, 4.000000e+00
  br i1 %704, label %705, label %710

; <label>:705                                     ; preds = %689
  %706 = load <4 x i32>* %ccount, align 16
  %707 = extractelement <4 x i32> %706, i32 1
  %708 = load i32* %6, align 4
  %709 = icmp ult i32 %707, %708
  br label %710

; <label>:710                                     ; preds = %705, %689
  %711 = phi i1 [ false, %689 ], [ %709, %705 ]
  %712 = zext i1 %711 to i32
  %713 = load <4 x i32>* %stay, align 16
  %714 = insertelement <4 x i32> %713, i32 %712, i32 1
  store <4 x i32> %714, <4 x i32>* %stay, align 16
  %715 = load <4 x float>* %x, align 16
  %716 = extractelement <4 x float> %715, i32 2
  %717 = load <4 x float>* %x, align 16
  %718 = extractelement <4 x float> %717, i32 2
  %719 = load <4 x float>* %y, align 16
  %720 = extractelement <4 x float> %719, i32 2
  %721 = load <4 x float>* %y, align 16
  %722 = extractelement <4 x float> %721, i32 2
  %723 = fmul float %720, %722
  %724 = call float @llvm.fmuladd.f32(float %716, float %718, float %723)
  %725 = fcmp ole float %724, 4.000000e+00
  br i1 %725, label %726, label %731

; <label>:726                                     ; preds = %710
  %727 = load <4 x i32>* %ccount, align 16
  %728 = extractelement <4 x i32> %727, i32 2
  %729 = load i32* %6, align 4
  %730 = icmp ult i32 %728, %729
  br label %731

; <label>:731                                     ; preds = %726, %710
  %732 = phi i1 [ false, %710 ], [ %730, %726 ]
  %733 = zext i1 %732 to i32
  %734 = load <4 x i32>* %stay, align 16
  %735 = insertelement <4 x i32> %734, i32 %733, i32 2
  store <4 x i32> %735, <4 x i32>* %stay, align 16
  %736 = load <4 x float>* %x, align 16
  %737 = extractelement <4 x float> %736, i32 3
  %738 = load <4 x float>* %x, align 16
  %739 = extractelement <4 x float> %738, i32 3
  %740 = load <4 x float>* %y, align 16
  %741 = extractelement <4 x float> %740, i32 3
  %742 = load <4 x float>* %y, align 16
  %743 = extractelement <4 x float> %742, i32 3
  %744 = fmul float %741, %743
  %745 = call float @llvm.fmuladd.f32(float %737, float %739, float %744)
  %746 = fcmp ole float %745, 4.000000e+00
  br i1 %746, label %747, label %752

; <label>:747                                     ; preds = %731
  %748 = load <4 x i32>* %ccount, align 16
  %749 = extractelement <4 x i32> %748, i32 3
  %750 = load i32* %6, align 4
  %751 = icmp ult i32 %749, %750
  br label %752

; <label>:752                                     ; preds = %747, %731
  %753 = phi i1 [ false, %731 ], [ %751, %747 ]
  %754 = zext i1 %753 to i32
  %755 = load <4 x i32>* %stay, align 16
  %756 = insertelement <4 x i32> %755, i32 %754, i32 3
  store <4 x i32> %756, <4 x i32>* %stay, align 16
  %757 = load <4 x float>* %x, align 16
  store <4 x float> %757, <4 x float>* %tmp, align 16
  %758 = load <4 x float>* %y, align 16
  %759 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %758
  %760 = load <4 x float>* %y, align 16
  %761 = load <4 x float>* %x, align 16
  %762 = load <4 x float>* %x, align 16
  %763 = load <4 x float>* %x0, align 16
  %764 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %761, <4 x float> %762, <4 x float> %763)
  %765 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %759, <4 x float> %760, i32 %764)
  %766 = sitofp i32 %765 to float
  %767 = insertelement <4 x float> undef, float %766, i32 0
  %768 = shufflevector <4 x float> %767, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %768, <4 x float>* %x, align 16
  %769 = load <4 x float>* %tmp, align 16
  %770 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %769
  %771 = load <4 x float>* %y, align 16
  %772 = load <4 x float>* %y0, align 16
  %773 = call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %770, <4 x float> %771, <4 x float> %772)
  %774 = sitofp i32 %773 to float
  %775 = insertelement <4 x float> undef, float %774, i32 0
  %776 = shufflevector <4 x float> %775, <4 x float> undef, <4 x i32> zeroinitializer
  store <4 x float> %776, <4 x float>* %y, align 16
  %777 = load <4 x i32>* %stay, align 16
  %778 = load <4 x i32>* %ccount, align 16
  %779 = add <4 x i32> %778, %777
  store <4 x i32> %779, <4 x i32>* %ccount, align 16
  %780 = load i32* %iter, align 4
  %781 = add i32 %780, -1
  store i32 %781, i32* %iter, align 4
  %782 = load <4 x i32>* %stay, align 16
  %783 = extractelement <4 x i32> %782, i32 0
  %784 = icmp ne i32 %783, 0
  br i1 %784, label %785, label %788

; <label>:785                                     ; preds = %752
  %786 = load <4 x float>* %x, align 16
  %787 = extractelement <4 x float> %786, i32 0
  br label %791

; <label>:788                                     ; preds = %752
  %789 = load <4 x float>* %savx, align 16
  %790 = extractelement <4 x float> %789, i32 0
  br label %791

; <label>:791                                     ; preds = %788, %785
  %792 = phi float [ %787, %785 ], [ %790, %788 ]
  %793 = load <4 x float>* %savx, align 16
  %794 = insertelement <4 x float> %793, float %792, i32 0
  store <4 x float> %794, <4 x float>* %savx, align 16
  %795 = load <4 x i32>* %stay, align 16
  %796 = extractelement <4 x i32> %795, i32 1
  %797 = icmp ne i32 %796, 0
  br i1 %797, label %798, label %801

; <label>:798                                     ; preds = %791
  %799 = load <4 x float>* %x, align 16
  %800 = extractelement <4 x float> %799, i32 1
  br label %804

; <label>:801                                     ; preds = %791
  %802 = load <4 x float>* %savx, align 16
  %803 = extractelement <4 x float> %802, i32 1
  br label %804

; <label>:804                                     ; preds = %801, %798
  %805 = phi float [ %800, %798 ], [ %803, %801 ]
  %806 = load <4 x float>* %savx, align 16
  %807 = insertelement <4 x float> %806, float %805, i32 1
  store <4 x float> %807, <4 x float>* %savx, align 16
  %808 = load <4 x i32>* %stay, align 16
  %809 = extractelement <4 x i32> %808, i32 2
  %810 = icmp ne i32 %809, 0
  br i1 %810, label %811, label %814

; <label>:811                                     ; preds = %804
  %812 = load <4 x float>* %x, align 16
  %813 = extractelement <4 x float> %812, i32 2
  br label %817

; <label>:814                                     ; preds = %804
  %815 = load <4 x float>* %savx, align 16
  %816 = extractelement <4 x float> %815, i32 2
  br label %817

; <label>:817                                     ; preds = %814, %811
  %818 = phi float [ %813, %811 ], [ %816, %814 ]
  %819 = load <4 x float>* %savx, align 16
  %820 = insertelement <4 x float> %819, float %818, i32 2
  store <4 x float> %820, <4 x float>* %savx, align 16
  %821 = load <4 x i32>* %stay, align 16
  %822 = extractelement <4 x i32> %821, i32 3
  %823 = icmp ne i32 %822, 0
  br i1 %823, label %824, label %827

; <label>:824                                     ; preds = %817
  %825 = load <4 x float>* %x, align 16
  %826 = extractelement <4 x float> %825, i32 3
  br label %830

; <label>:827                                     ; preds = %817
  %828 = load <4 x float>* %savx, align 16
  %829 = extractelement <4 x float> %828, i32 3
  br label %830

; <label>:830                                     ; preds = %827, %824
  %831 = phi float [ %826, %824 ], [ %829, %827 ]
  %832 = load <4 x float>* %savx, align 16
  %833 = insertelement <4 x float> %832, float %831, i32 3
  store <4 x float> %833, <4 x float>* %savx, align 16
  %834 = load <4 x i32>* %stay, align 16
  %835 = extractelement <4 x i32> %834, i32 0
  %836 = icmp ne i32 %835, 0
  br i1 %836, label %837, label %840

; <label>:837                                     ; preds = %830
  %838 = load <4 x float>* %y, align 16
  %839 = extractelement <4 x float> %838, i32 0
  br label %843

; <label>:840                                     ; preds = %830
  %841 = load <4 x float>* %savy, align 16
  %842 = extractelement <4 x float> %841, i32 0
  br label %843

; <label>:843                                     ; preds = %840, %837
  %844 = phi float [ %839, %837 ], [ %842, %840 ]
  %845 = load <4 x float>* %savy, align 16
  %846 = insertelement <4 x float> %845, float %844, i32 0
  store <4 x float> %846, <4 x float>* %savy, align 16
  %847 = load <4 x i32>* %stay, align 16
  %848 = extractelement <4 x i32> %847, i32 1
  %849 = icmp ne i32 %848, 0
  br i1 %849, label %850, label %853

; <label>:850                                     ; preds = %843
  %851 = load <4 x float>* %y, align 16
  %852 = extractelement <4 x float> %851, i32 1
  br label %856

; <label>:853                                     ; preds = %843
  %854 = load <4 x float>* %savy, align 16
  %855 = extractelement <4 x float> %854, i32 1
  br label %856

; <label>:856                                     ; preds = %853, %850
  %857 = phi float [ %852, %850 ], [ %855, %853 ]
  %858 = load <4 x float>* %savy, align 16
  %859 = insertelement <4 x float> %858, float %857, i32 1
  store <4 x float> %859, <4 x float>* %savy, align 16
  %860 = load <4 x i32>* %stay, align 16
  %861 = extractelement <4 x i32> %860, i32 2
  %862 = icmp ne i32 %861, 0
  br i1 %862, label %863, label %866

; <label>:863                                     ; preds = %856
  %864 = load <4 x float>* %y, align 16
  %865 = extractelement <4 x float> %864, i32 2
  br label %869

; <label>:866                                     ; preds = %856
  %867 = load <4 x float>* %savy, align 16
  %868 = extractelement <4 x float> %867, i32 2
  br label %869

; <label>:869                                     ; preds = %866, %863
  %870 = phi float [ %865, %863 ], [ %868, %866 ]
  %871 = load <4 x float>* %savy, align 16
  %872 = insertelement <4 x float> %871, float %870, i32 2
  store <4 x float> %872, <4 x float>* %savy, align 16
  %873 = load <4 x i32>* %stay, align 16
  %874 = extractelement <4 x i32> %873, i32 3
  %875 = icmp ne i32 %874, 0
  br i1 %875, label %876, label %879

; <label>:876                                     ; preds = %869
  %877 = load <4 x float>* %y, align 16
  %878 = extractelement <4 x float> %877, i32 3
  br label %882

; <label>:879                                     ; preds = %869
  %880 = load <4 x float>* %savy, align 16
  %881 = extractelement <4 x float> %880, i32 3
  br label %882

; <label>:882                                     ; preds = %879, %876
  %883 = phi float [ %878, %876 ], [ %881, %879 ]
  %884 = load <4 x float>* %savy, align 16
  %885 = insertelement <4 x float> %884, float %883, i32 3
  store <4 x float> %885, <4 x float>* %savy, align 16
  br label %886

; <label>:886                                     ; preds = %882
  %887 = load <4 x i32>* %stay, align 16
  %888 = extractelement <4 x i32> %887, i32 0
  %889 = load <4 x i32>* %stay, align 16
  %890 = extractelement <4 x i32> %889, i32 1
  %891 = or i32 %888, %890
  %892 = load <4 x i32>* %stay, align 16
  %893 = extractelement <4 x i32> %892, i32 2
  %894 = or i32 %891, %893
  %895 = load <4 x i32>* %stay, align 16
  %896 = extractelement <4 x i32> %895, i32 3
  %897 = or i32 %894, %896
  %898 = icmp ne i32 %897, 0
  br i1 %898, label %899, label %902

; <label>:899                                     ; preds = %886
  %900 = load i32* %iter, align 4
  %901 = icmp ne i32 %900, 0
  br label %902

; <label>:902                                     ; preds = %899, %886
  %903 = phi i1 [ false, %886 ], [ %901, %899 ]
  br i1 %903, label %670, label %904

; <label>:904                                     ; preds = %902
  br label %905

; <label>:905                                     ; preds = %904, %656
  %906 = load <4 x float>* %savx, align 16
  store <4 x float> %906, <4 x float>* %x, align 16
  %907 = load <4 x float>* %savy, align 16
  store <4 x float> %907, <4 x float>* %y, align 16
  %908 = load <4 x i32>* %ccount, align 16
  %909 = call <4 x float> @_Z14convert_float4Dv4_i(<4 x i32> %908)
  store <4 x float> %909, <4 x float>* %fc, align 16
  %910 = load <4 x i32>* %ccount, align 16
  %911 = extractelement <4 x i32> %910, i32 0
  %912 = sitofp i32 %911 to float
  %913 = fadd float %912, 1.000000e+00
  %914 = load <4 x float>* %x, align 16
  %915 = extractelement <4 x float> %914, i32 0
  %916 = load <4 x float>* %x, align 16
  %917 = extractelement <4 x float> %916, i32 0
  %918 = load <4 x float>* %y, align 16
  %919 = extractelement <4 x float> %918, i32 0
  %920 = load <4 x float>* %y, align 16
  %921 = extractelement <4 x float> %920, i32 0
  %922 = fmul float %919, %921
  %923 = call float @llvm.fmuladd.f32(float %915, float %917, float %922)
  %924 = call float @llvm.log2.f32(float %923)
  %925 = call float @llvm.log2.f32(float %924)
  %926 = fsub float %913, %925
  %927 = load <4 x float>* %fc, align 16
  %928 = insertelement <4 x float> %927, float %926, i32 0
  store <4 x float> %928, <4 x float>* %fc, align 16
  %929 = load <4 x i32>* %ccount, align 16
  %930 = extractelement <4 x i32> %929, i32 1
  %931 = sitofp i32 %930 to float
  %932 = fadd float %931, 1.000000e+00
  %933 = load <4 x float>* %x, align 16
  %934 = extractelement <4 x float> %933, i32 1
  %935 = load <4 x float>* %x, align 16
  %936 = extractelement <4 x float> %935, i32 1
  %937 = load <4 x float>* %y, align 16
  %938 = extractelement <4 x float> %937, i32 1
  %939 = load <4 x float>* %y, align 16
  %940 = extractelement <4 x float> %939, i32 1
  %941 = fmul float %938, %940
  %942 = call float @llvm.fmuladd.f32(float %934, float %936, float %941)
  %943 = call float @llvm.log2.f32(float %942)
  %944 = call float @llvm.log2.f32(float %943)
  %945 = fsub float %932, %944
  %946 = load <4 x float>* %fc, align 16
  %947 = insertelement <4 x float> %946, float %945, i32 1
  store <4 x float> %947, <4 x float>* %fc, align 16
  %948 = load <4 x i32>* %ccount, align 16
  %949 = extractelement <4 x i32> %948, i32 2
  %950 = sitofp i32 %949 to float
  %951 = fadd float %950, 1.000000e+00
  %952 = load <4 x float>* %x, align 16
  %953 = extractelement <4 x float> %952, i32 2
  %954 = load <4 x float>* %x, align 16
  %955 = extractelement <4 x float> %954, i32 2
  %956 = load <4 x float>* %y, align 16
  %957 = extractelement <4 x float> %956, i32 2
  %958 = load <4 x float>* %y, align 16
  %959 = extractelement <4 x float> %958, i32 2
  %960 = fmul float %957, %959
  %961 = call float @llvm.fmuladd.f32(float %953, float %955, float %960)
  %962 = call float @llvm.log2.f32(float %961)
  %963 = call float @llvm.log2.f32(float %962)
  %964 = fsub float %951, %963
  %965 = load <4 x float>* %fc, align 16
  %966 = insertelement <4 x float> %965, float %964, i32 2
  store <4 x float> %966, <4 x float>* %fc, align 16
  %967 = load <4 x i32>* %ccount, align 16
  %968 = extractelement <4 x i32> %967, i32 3
  %969 = sitofp i32 %968 to float
  %970 = fadd float %969, 1.000000e+00
  %971 = load <4 x float>* %x, align 16
  %972 = extractelement <4 x float> %971, i32 3
  %973 = load <4 x float>* %x, align 16
  %974 = extractelement <4 x float> %973, i32 3
  %975 = load <4 x float>* %y, align 16
  %976 = extractelement <4 x float> %975, i32 3
  %977 = load <4 x float>* %y, align 16
  %978 = extractelement <4 x float> %977, i32 3
  %979 = fmul float %976, %978
  %980 = call float @llvm.fmuladd.f32(float %972, float %974, float %979)
  %981 = call float @llvm.log2.f32(float %980)
  %982 = call float @llvm.log2.f32(float %981)
  %983 = fsub float %970, %982
  %984 = load <4 x float>* %fc, align 16
  %985 = insertelement <4 x float> %984, float %983, i32 3
  store <4 x float> %985, <4 x float>* %fc, align 16
  %986 = load <4 x float>* %fc, align 16
  %987 = extractelement <4 x float> %986, i32 0
  %988 = fmul float %987, 2.000000e+00
  %989 = fmul float %988, 0x400921FF20000000
  %990 = fdiv float %989, 2.560000e+02, !fpmath !2
  store float %990, float* %c, align 4
  %991 = load float* %c, align 4
  %992 = call float @_Z3cosf(float %991)
  %993 = fadd float 1.000000e+00, %992
  %994 = fmul float %993, 5.000000e-01
  %995 = fmul float %994, 2.550000e+02
  %996 = fptoui float %995 to i8
  %997 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %998 = load <4 x i8>* %997, align 4
  %999 = insertelement <4 x i8> %998, i8 %996, i32 0
  store <4 x i8> %999, <4 x i8>* %997, align 4
  %1000 = load float* %c, align 4
  %1001 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %1000, float 0x4000C154C0000000)
  %1002 = call float @_Z3cosf(float %1001)
  %1003 = fadd float 1.000000e+00, %1002
  %1004 = fmul float %1003, 5.000000e-01
  %1005 = fmul float %1004, 2.550000e+02
  %1006 = fptoui float %1005 to i8
  %1007 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1008 = load <4 x i8>* %1007, align 4
  %1009 = insertelement <4 x i8> %1008, i8 %1006, i32 1
  store <4 x i8> %1009, <4 x i8>* %1007, align 4
  %1010 = load float* %c, align 4
  %1011 = fsub float %1010, 0x4000C154C0000000
  %1012 = call float @_Z3cosf(float %1011)
  %1013 = fadd float 1.000000e+00, %1012
  %1014 = fmul float %1013, 5.000000e-01
  %1015 = fmul float %1014, 2.550000e+02
  %1016 = fptoui float %1015 to i8
  %1017 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1018 = load <4 x i8>* %1017, align 4
  %1019 = insertelement <4 x i8> %1018, i8 %1016, i32 2
  store <4 x i8> %1019, <4 x i8>* %1017, align 4
  %1020 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1021 = load <4 x i8>* %1020, align 4
  %1022 = insertelement <4 x i8> %1021, i8 -1, i32 3
  store <4 x i8> %1022, <4 x i8>* %1020, align 4
  %1023 = load <4 x i32>* %ccount, align 16
  %1024 = extractelement <4 x i32> %1023, i32 0
  %1025 = load i32* %6, align 4
  %1026 = icmp eq i32 %1024, %1025
  br i1 %1026, label %1027, label %1037

; <label>:1027                                    ; preds = %905
  %1028 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1029 = load <4 x i8>* %1028, align 4
  %1030 = insertelement <4 x i8> %1029, i8 0, i32 0
  store <4 x i8> %1030, <4 x i8>* %1028, align 4
  %1031 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1032 = load <4 x i8>* %1031, align 4
  %1033 = insertelement <4 x i8> %1032, i8 0, i32 1
  store <4 x i8> %1033, <4 x i8>* %1031, align 4
  %1034 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1035 = load <4 x i8>* %1034, align 4
  %1036 = insertelement <4 x i8> %1035, i8 0, i32 2
  store <4 x i8> %1036, <4 x i8>* %1034, align 4
  br label %1037

; <label>:1037                                    ; preds = %1027, %905
  %1038 = load i32* %8, align 4
  %1039 = icmp ne i32 %1038, 0
  br i1 %1039, label %1040, label %1072

; <label>:1040                                    ; preds = %1037
  %1041 = load <4 x i32>* %ccount, align 16
  %1042 = extractelement <4 x i32> %1041, i32 0
  %1043 = and i32 %1042, 255
  %1044 = trunc i32 %1043 to i8
  %1045 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1046 = load <4 x i8>* %1045, align 4
  %1047 = insertelement <4 x i8> %1046, i8 %1044, i32 0
  store <4 x i8> %1047, <4 x i8>* %1045, align 4
  %1048 = load <4 x i32>* %ccount, align 16
  %1049 = extractelement <4 x i32> %1048, i32 0
  %1050 = and i32 %1049, 65280
  %1051 = ashr i32 %1050, 8
  %1052 = trunc i32 %1051 to i8
  %1053 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1054 = load <4 x i8>* %1053, align 4
  %1055 = insertelement <4 x i8> %1054, i8 %1052, i32 1
  store <4 x i8> %1055, <4 x i8>* %1053, align 4
  %1056 = load <4 x i32>* %ccount, align 16
  %1057 = extractelement <4 x i32> %1056, i32 0
  %1058 = and i32 %1057, 16711680
  %1059 = ashr i32 %1058, 16
  %1060 = trunc i32 %1059 to i8
  %1061 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1062 = load <4 x i8>* %1061, align 4
  %1063 = insertelement <4 x i8> %1062, i8 %1060, i32 2
  store <4 x i8> %1063, <4 x i8>* %1061, align 4
  %1064 = load <4 x i32>* %ccount, align 16
  %1065 = extractelement <4 x i32> %1064, i32 0
  %1066 = and i32 %1065, -16777216
  %1067 = lshr i32 %1066, 24
  %1068 = trunc i32 %1067 to i8
  %1069 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1070 = load <4 x i8>* %1069, align 4
  %1071 = insertelement <4 x i8> %1070, i8 %1068, i32 3
  store <4 x i8> %1071, <4 x i8>* %1069, align 4
  br label %1072

; <label>:1072                                    ; preds = %1040, %1037
  %1073 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 0
  %1074 = load <4 x i8>* %1073, align 4
  %1075 = load i32* %tid, align 4
  %1076 = mul nsw i32 4, %1075
  %1077 = load <4 x i8> addrspace(1)** %1, align 4
  %1078 = getelementptr inbounds <4 x i8> addrspace(1)* %1077, i32 %1076
  store <4 x i8> %1074, <4 x i8> addrspace(1)* %1078, align 4
  %1079 = load <4 x float>* %fc, align 16
  %1080 = extractelement <4 x float> %1079, i32 1
  %1081 = fmul float %1080, 2.000000e+00
  %1082 = fmul float %1081, 0x400921FF20000000
  %1083 = fdiv float %1082, 2.560000e+02, !fpmath !2
  store float %1083, float* %c, align 4
  %1084 = load float* %c, align 4
  %1085 = call float @_Z3cosf(float %1084)
  %1086 = fadd float 1.000000e+00, %1085
  %1087 = fmul float %1086, 5.000000e-01
  %1088 = fmul float %1087, 2.550000e+02
  %1089 = fptoui float %1088 to i8
  %1090 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1091 = load <4 x i8>* %1090, align 4
  %1092 = insertelement <4 x i8> %1091, i8 %1089, i32 0
  store <4 x i8> %1092, <4 x i8>* %1090, align 4
  %1093 = load float* %c, align 4
  %1094 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %1093, float 0x4000C154C0000000)
  %1095 = call float @_Z3cosf(float %1094)
  %1096 = fadd float 1.000000e+00, %1095
  %1097 = fmul float %1096, 5.000000e-01
  %1098 = fmul float %1097, 2.550000e+02
  %1099 = fptoui float %1098 to i8
  %1100 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1101 = load <4 x i8>* %1100, align 4
  %1102 = insertelement <4 x i8> %1101, i8 %1099, i32 1
  store <4 x i8> %1102, <4 x i8>* %1100, align 4
  %1103 = load float* %c, align 4
  %1104 = fsub float %1103, 0x4000C154C0000000
  %1105 = call float @_Z3cosf(float %1104)
  %1106 = fadd float 1.000000e+00, %1105
  %1107 = fmul float %1106, 5.000000e-01
  %1108 = fmul float %1107, 2.550000e+02
  %1109 = fptoui float %1108 to i8
  %1110 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1111 = load <4 x i8>* %1110, align 4
  %1112 = insertelement <4 x i8> %1111, i8 %1109, i32 2
  store <4 x i8> %1112, <4 x i8>* %1110, align 4
  %1113 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1114 = load <4 x i8>* %1113, align 4
  %1115 = insertelement <4 x i8> %1114, i8 -1, i32 3
  store <4 x i8> %1115, <4 x i8>* %1113, align 4
  %1116 = load <4 x i32>* %ccount, align 16
  %1117 = extractelement <4 x i32> %1116, i32 1
  %1118 = load i32* %6, align 4
  %1119 = icmp eq i32 %1117, %1118
  br i1 %1119, label %1120, label %1130

; <label>:1120                                    ; preds = %1072
  %1121 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1122 = load <4 x i8>* %1121, align 4
  %1123 = insertelement <4 x i8> %1122, i8 0, i32 0
  store <4 x i8> %1123, <4 x i8>* %1121, align 4
  %1124 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1125 = load <4 x i8>* %1124, align 4
  %1126 = insertelement <4 x i8> %1125, i8 0, i32 1
  store <4 x i8> %1126, <4 x i8>* %1124, align 4
  %1127 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1128 = load <4 x i8>* %1127, align 4
  %1129 = insertelement <4 x i8> %1128, i8 0, i32 2
  store <4 x i8> %1129, <4 x i8>* %1127, align 4
  br label %1130

; <label>:1130                                    ; preds = %1120, %1072
  %1131 = load i32* %8, align 4
  %1132 = icmp ne i32 %1131, 0
  br i1 %1132, label %1133, label %1165

; <label>:1133                                    ; preds = %1130
  %1134 = load <4 x i32>* %ccount, align 16
  %1135 = extractelement <4 x i32> %1134, i32 1
  %1136 = and i32 %1135, 255
  %1137 = trunc i32 %1136 to i8
  %1138 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1139 = load <4 x i8>* %1138, align 4
  %1140 = insertelement <4 x i8> %1139, i8 %1137, i32 0
  store <4 x i8> %1140, <4 x i8>* %1138, align 4
  %1141 = load <4 x i32>* %ccount, align 16
  %1142 = extractelement <4 x i32> %1141, i32 1
  %1143 = and i32 %1142, 65280
  %1144 = ashr i32 %1143, 8
  %1145 = trunc i32 %1144 to i8
  %1146 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1147 = load <4 x i8>* %1146, align 4
  %1148 = insertelement <4 x i8> %1147, i8 %1145, i32 1
  store <4 x i8> %1148, <4 x i8>* %1146, align 4
  %1149 = load <4 x i32>* %ccount, align 16
  %1150 = extractelement <4 x i32> %1149, i32 1
  %1151 = and i32 %1150, 16711680
  %1152 = ashr i32 %1151, 16
  %1153 = trunc i32 %1152 to i8
  %1154 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1155 = load <4 x i8>* %1154, align 4
  %1156 = insertelement <4 x i8> %1155, i8 %1153, i32 2
  store <4 x i8> %1156, <4 x i8>* %1154, align 4
  %1157 = load <4 x i32>* %ccount, align 16
  %1158 = extractelement <4 x i32> %1157, i32 1
  %1159 = and i32 %1158, -16777216
  %1160 = lshr i32 %1159, 24
  %1161 = trunc i32 %1160 to i8
  %1162 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1163 = load <4 x i8>* %1162, align 4
  %1164 = insertelement <4 x i8> %1163, i8 %1161, i32 3
  store <4 x i8> %1164, <4 x i8>* %1162, align 4
  br label %1165

; <label>:1165                                    ; preds = %1133, %1130
  %1166 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 1
  %1167 = load <4 x i8>* %1166, align 4
  %1168 = load i32* %tid, align 4
  %1169 = mul nsw i32 4, %1168
  %1170 = add nsw i32 %1169, 1
  %1171 = load <4 x i8> addrspace(1)** %1, align 4
  %1172 = getelementptr inbounds <4 x i8> addrspace(1)* %1171, i32 %1170
  store <4 x i8> %1167, <4 x i8> addrspace(1)* %1172, align 4
  %1173 = load <4 x float>* %fc, align 16
  %1174 = extractelement <4 x float> %1173, i32 2
  %1175 = fmul float %1174, 2.000000e+00
  %1176 = fmul float %1175, 0x400921FF20000000
  %1177 = fdiv float %1176, 2.560000e+02, !fpmath !2
  store float %1177, float* %c, align 4
  %1178 = load float* %c, align 4
  %1179 = call float @_Z3cosf(float %1178)
  %1180 = fadd float 1.000000e+00, %1179
  %1181 = fmul float %1180, 5.000000e-01
  %1182 = fmul float %1181, 2.550000e+02
  %1183 = fptoui float %1182 to i8
  %1184 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1185 = load <4 x i8>* %1184, align 4
  %1186 = insertelement <4 x i8> %1185, i8 %1183, i32 0
  store <4 x i8> %1186, <4 x i8>* %1184, align 4
  %1187 = load float* %c, align 4
  %1188 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %1187, float 0x4000C154C0000000)
  %1189 = call float @_Z3cosf(float %1188)
  %1190 = fadd float 1.000000e+00, %1189
  %1191 = fmul float %1190, 5.000000e-01
  %1192 = fmul float %1191, 2.550000e+02
  %1193 = fptoui float %1192 to i8
  %1194 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1195 = load <4 x i8>* %1194, align 4
  %1196 = insertelement <4 x i8> %1195, i8 %1193, i32 1
  store <4 x i8> %1196, <4 x i8>* %1194, align 4
  %1197 = load float* %c, align 4
  %1198 = fsub float %1197, 0x4000C154C0000000
  %1199 = call float @_Z3cosf(float %1198)
  %1200 = fadd float 1.000000e+00, %1199
  %1201 = fmul float %1200, 5.000000e-01
  %1202 = fmul float %1201, 2.550000e+02
  %1203 = fptoui float %1202 to i8
  %1204 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1205 = load <4 x i8>* %1204, align 4
  %1206 = insertelement <4 x i8> %1205, i8 %1203, i32 2
  store <4 x i8> %1206, <4 x i8>* %1204, align 4
  %1207 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1208 = load <4 x i8>* %1207, align 4
  %1209 = insertelement <4 x i8> %1208, i8 -1, i32 3
  store <4 x i8> %1209, <4 x i8>* %1207, align 4
  %1210 = load <4 x i32>* %ccount, align 16
  %1211 = extractelement <4 x i32> %1210, i32 2
  %1212 = load i32* %6, align 4
  %1213 = icmp eq i32 %1211, %1212
  br i1 %1213, label %1214, label %1224

; <label>:1214                                    ; preds = %1165
  %1215 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1216 = load <4 x i8>* %1215, align 4
  %1217 = insertelement <4 x i8> %1216, i8 0, i32 0
  store <4 x i8> %1217, <4 x i8>* %1215, align 4
  %1218 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1219 = load <4 x i8>* %1218, align 4
  %1220 = insertelement <4 x i8> %1219, i8 0, i32 1
  store <4 x i8> %1220, <4 x i8>* %1218, align 4
  %1221 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1222 = load <4 x i8>* %1221, align 4
  %1223 = insertelement <4 x i8> %1222, i8 0, i32 2
  store <4 x i8> %1223, <4 x i8>* %1221, align 4
  br label %1224

; <label>:1224                                    ; preds = %1214, %1165
  %1225 = load i32* %8, align 4
  %1226 = icmp ne i32 %1225, 0
  br i1 %1226, label %1227, label %1259

; <label>:1227                                    ; preds = %1224
  %1228 = load <4 x i32>* %ccount, align 16
  %1229 = extractelement <4 x i32> %1228, i32 2
  %1230 = and i32 %1229, 255
  %1231 = trunc i32 %1230 to i8
  %1232 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1233 = load <4 x i8>* %1232, align 4
  %1234 = insertelement <4 x i8> %1233, i8 %1231, i32 0
  store <4 x i8> %1234, <4 x i8>* %1232, align 4
  %1235 = load <4 x i32>* %ccount, align 16
  %1236 = extractelement <4 x i32> %1235, i32 2
  %1237 = and i32 %1236, 65280
  %1238 = ashr i32 %1237, 8
  %1239 = trunc i32 %1238 to i8
  %1240 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1241 = load <4 x i8>* %1240, align 4
  %1242 = insertelement <4 x i8> %1241, i8 %1239, i32 1
  store <4 x i8> %1242, <4 x i8>* %1240, align 4
  %1243 = load <4 x i32>* %ccount, align 16
  %1244 = extractelement <4 x i32> %1243, i32 2
  %1245 = and i32 %1244, 16711680
  %1246 = ashr i32 %1245, 16
  %1247 = trunc i32 %1246 to i8
  %1248 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1249 = load <4 x i8>* %1248, align 4
  %1250 = insertelement <4 x i8> %1249, i8 %1247, i32 2
  store <4 x i8> %1250, <4 x i8>* %1248, align 4
  %1251 = load <4 x i32>* %ccount, align 16
  %1252 = extractelement <4 x i32> %1251, i32 2
  %1253 = and i32 %1252, -16777216
  %1254 = lshr i32 %1253, 24
  %1255 = trunc i32 %1254 to i8
  %1256 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1257 = load <4 x i8>* %1256, align 4
  %1258 = insertelement <4 x i8> %1257, i8 %1255, i32 3
  store <4 x i8> %1258, <4 x i8>* %1256, align 4
  br label %1259

; <label>:1259                                    ; preds = %1227, %1224
  %1260 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 2
  %1261 = load <4 x i8>* %1260, align 4
  %1262 = load i32* %tid, align 4
  %1263 = mul nsw i32 4, %1262
  %1264 = add nsw i32 %1263, 2
  %1265 = load <4 x i8> addrspace(1)** %1, align 4
  %1266 = getelementptr inbounds <4 x i8> addrspace(1)* %1265, i32 %1264
  store <4 x i8> %1261, <4 x i8> addrspace(1)* %1266, align 4
  %1267 = load <4 x float>* %fc, align 16
  %1268 = extractelement <4 x float> %1267, i32 3
  %1269 = fmul float %1268, 2.000000e+00
  %1270 = fmul float %1269, 0x400921FF20000000
  %1271 = fdiv float %1270, 2.560000e+02, !fpmath !2
  store float %1271, float* %c, align 4
  %1272 = load float* %c, align 4
  %1273 = call float @_Z3cosf(float %1272)
  %1274 = fadd float 1.000000e+00, %1273
  %1275 = fmul float %1274, 5.000000e-01
  %1276 = fmul float %1275, 2.550000e+02
  %1277 = fptoui float %1276 to i8
  %1278 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1279 = load <4 x i8>* %1278, align 4
  %1280 = insertelement <4 x i8> %1279, i8 %1277, i32 0
  store <4 x i8> %1280, <4 x i8>* %1278, align 4
  %1281 = load float* %c, align 4
  %1282 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %1281, float 0x4000C154C0000000)
  %1283 = call float @_Z3cosf(float %1282)
  %1284 = fadd float 1.000000e+00, %1283
  %1285 = fmul float %1284, 5.000000e-01
  %1286 = fmul float %1285, 2.550000e+02
  %1287 = fptoui float %1286 to i8
  %1288 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1289 = load <4 x i8>* %1288, align 4
  %1290 = insertelement <4 x i8> %1289, i8 %1287, i32 1
  store <4 x i8> %1290, <4 x i8>* %1288, align 4
  %1291 = load float* %c, align 4
  %1292 = fsub float %1291, 0x4000C154C0000000
  %1293 = call float @_Z3cosf(float %1292)
  %1294 = fadd float 1.000000e+00, %1293
  %1295 = fmul float %1294, 5.000000e-01
  %1296 = fmul float %1295, 2.550000e+02
  %1297 = fptoui float %1296 to i8
  %1298 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1299 = load <4 x i8>* %1298, align 4
  %1300 = insertelement <4 x i8> %1299, i8 %1297, i32 2
  store <4 x i8> %1300, <4 x i8>* %1298, align 4
  %1301 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1302 = load <4 x i8>* %1301, align 4
  %1303 = insertelement <4 x i8> %1302, i8 -1, i32 3
  store <4 x i8> %1303, <4 x i8>* %1301, align 4
  %1304 = load <4 x i32>* %ccount, align 16
  %1305 = extractelement <4 x i32> %1304, i32 3
  %1306 = load i32* %6, align 4
  %1307 = icmp eq i32 %1305, %1306
  br i1 %1307, label %1308, label %1318

; <label>:1308                                    ; preds = %1259
  %1309 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1310 = load <4 x i8>* %1309, align 4
  %1311 = insertelement <4 x i8> %1310, i8 0, i32 0
  store <4 x i8> %1311, <4 x i8>* %1309, align 4
  %1312 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1313 = load <4 x i8>* %1312, align 4
  %1314 = insertelement <4 x i8> %1313, i8 0, i32 1
  store <4 x i8> %1314, <4 x i8>* %1312, align 4
  %1315 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1316 = load <4 x i8>* %1315, align 4
  %1317 = insertelement <4 x i8> %1316, i8 0, i32 2
  store <4 x i8> %1317, <4 x i8>* %1315, align 4
  br label %1318

; <label>:1318                                    ; preds = %1308, %1259
  %1319 = load i32* %8, align 4
  %1320 = icmp ne i32 %1319, 0
  br i1 %1320, label %1321, label %1353

; <label>:1321                                    ; preds = %1318
  %1322 = load <4 x i32>* %ccount, align 16
  %1323 = extractelement <4 x i32> %1322, i32 3
  %1324 = and i32 %1323, 255
  %1325 = trunc i32 %1324 to i8
  %1326 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1327 = load <4 x i8>* %1326, align 4
  %1328 = insertelement <4 x i8> %1327, i8 %1325, i32 0
  store <4 x i8> %1328, <4 x i8>* %1326, align 4
  %1329 = load <4 x i32>* %ccount, align 16
  %1330 = extractelement <4 x i32> %1329, i32 3
  %1331 = and i32 %1330, 65280
  %1332 = ashr i32 %1331, 8
  %1333 = trunc i32 %1332 to i8
  %1334 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1335 = load <4 x i8>* %1334, align 4
  %1336 = insertelement <4 x i8> %1335, i8 %1333, i32 1
  store <4 x i8> %1336, <4 x i8>* %1334, align 4
  %1337 = load <4 x i32>* %ccount, align 16
  %1338 = extractelement <4 x i32> %1337, i32 3
  %1339 = and i32 %1338, 16711680
  %1340 = ashr i32 %1339, 16
  %1341 = trunc i32 %1340 to i8
  %1342 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1343 = load <4 x i8>* %1342, align 4
  %1344 = insertelement <4 x i8> %1343, i8 %1341, i32 2
  store <4 x i8> %1344, <4 x i8>* %1342, align 4
  %1345 = load <4 x i32>* %ccount, align 16
  %1346 = extractelement <4 x i32> %1345, i32 3
  %1347 = and i32 %1346, -16777216
  %1348 = lshr i32 %1347, 24
  %1349 = trunc i32 %1348 to i8
  %1350 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1351 = load <4 x i8>* %1350, align 4
  %1352 = insertelement <4 x i8> %1351, i8 %1349, i32 3
  store <4 x i8> %1352, <4 x i8>* %1350, align 4
  br label %1353

; <label>:1353                                    ; preds = %1321, %1318
  %1354 = getelementptr inbounds [4 x <4 x i8>]* %color, i32 0, i32 3
  %1355 = load <4 x i8>* %1354, align 4
  %1356 = load i32* %tid, align 4
  %1357 = mul nsw i32 4, %1356
  %1358 = add nsw i32 %1357, 3
  %1359 = load <4 x i8> addrspace(1)** %1, align 4
  %1360 = getelementptr inbounds <4 x i8> addrspace(1)* %1359, i32 %1358
  store <4 x i8> %1355, <4 x i8> addrspace(1)* %1360, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

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

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, float, float, float, float, i32, i32, i32)* @mandelbrot_vector_float}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

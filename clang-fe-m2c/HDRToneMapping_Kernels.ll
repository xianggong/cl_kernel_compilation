; ModuleID = '../kernel-src/HDRToneMapping_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define float @luminance(float %r, float %g, float %b) #0 {
  %1 = alloca float, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  store float %r, float* %1, align 4
  store float %g, float* %2, align 4
  store float %b, float* %3, align 4
  %4 = load float* %1, align 4
  %5 = load float* %2, align 4
  %6 = fmul float 0x3FE6E2EB20000000, %5
  %7 = call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %4, float %6)
  %8 = load float* %3, align 4
  %9 = call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %8, float %7)
  ret float %9
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind
define void @toneMappingPattanaik1(float addrspace(1)* %input, float addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %globalIdX = alloca i32, align 4
  %globalIdY = alloca i32, align 4
  %r = alloca float, align 4
  %r1 = alloca float, align 4
  %g = alloca float, align 4
  %g1 = alloca float, align 4
  %b = alloca float, align 4
  %b1 = alloca float, align 4
  %yLuminance = alloca float, align 4
  %cLPattanaik = alloca float, align 4
  %yLPattanaik = alloca float, align 4
  %gcPattanaik = alloca float, align 4
  %leftUp = alloca float, align 4
  %up = alloca float, align 4
  %rightUp = alloca float, align 4
  %left = alloca float, align 4
  %right = alloca float, align 4
  %leftDown = alloca float, align 4
  %down = alloca float, align 4
  %rightDown = alloca float, align 4
  %yDPattanaik = alloca float, align 4
  store float addrspace(1)* %input, float addrspace(1)** %1, align 4
  store float addrspace(1)* %output, float addrspace(1)** %2, align 4
  store float %averageLuminance, float* %3, align 4
  store float %gamma, float* %4, align 4
  store float %c, float* %5, align 4
  store float %delta, float* %6, align 4
  store i32 %width, i32* %7, align 4
  store i32 %numChannels, i32* %8, align 4
  store i32 %height, i32* %9, align 4
  %10 = call i32 @__get_global_id_u32(i32 0)
  store i32 %10, i32* %globalIdX, align 4
  %11 = call i32 @__get_global_id_u32(i32 1)
  store i32 %11, i32* %globalIdY, align 4
  store float 0.000000e+00, float* %yLuminance, align 4
  store float 0.000000e+00, float* %cLPattanaik, align 4
  store float 0.000000e+00, float* %yLPattanaik, align 4
  %12 = load i32* %7, align 4
  %13 = load i32* %8, align 4
  %14 = mul i32 %12, %13
  %15 = load i32* %globalIdY, align 4
  %16 = mul i32 %14, %15
  %17 = load i32* %globalIdX, align 4
  %18 = load i32* %8, align 4
  %19 = mul i32 %17, %18
  %20 = add i32 %19, 0
  %21 = add i32 %16, %20
  %22 = load float addrspace(1)** %1, align 4
  %23 = getelementptr inbounds float addrspace(1)* %22, i32 %21
  %24 = load float addrspace(1)* %23, align 4
  store float %24, float* %r1, align 4
  %25 = load i32* %7, align 4
  %26 = load i32* %8, align 4
  %27 = mul i32 %25, %26
  %28 = load i32* %globalIdY, align 4
  %29 = mul i32 %27, %28
  %30 = load i32* %globalIdX, align 4
  %31 = load i32* %8, align 4
  %32 = mul i32 %30, %31
  %33 = add i32 %32, 1
  %34 = add i32 %29, %33
  %35 = load float addrspace(1)** %1, align 4
  %36 = getelementptr inbounds float addrspace(1)* %35, i32 %34
  %37 = load float addrspace(1)* %36, align 4
  store float %37, float* %g1, align 4
  %38 = load i32* %7, align 4
  %39 = load i32* %8, align 4
  %40 = mul i32 %38, %39
  %41 = load i32* %globalIdY, align 4
  %42 = mul i32 %40, %41
  %43 = load i32* %globalIdX, align 4
  %44 = load i32* %8, align 4
  %45 = mul i32 %43, %44
  %46 = add i32 %45, 2
  %47 = add i32 %42, %46
  %48 = load float addrspace(1)** %1, align 4
  %49 = getelementptr inbounds float addrspace(1)* %48, i32 %47
  %50 = load float addrspace(1)* %49, align 4
  store float %50, float* %b1, align 4
  %51 = load float* %r1, align 4
  %52 = load float* %g1, align 4
  %53 = load float* %b1, align 4
  %54 = call float @luminance(float %51, float %52, float %53)
  store float %54, float* %yLuminance, align 4
  %55 = load float* %5, align 4
  %56 = load float* %3, align 4
  %57 = fmul float %55, %56
  store float %57, float* %gcPattanaik, align 4
  %58 = load i32* %globalIdX, align 4
  %59 = icmp ne i32 %58, 0
  br i1 %59, label %60, label %470

; <label>:60                                      ; preds = %0
  %61 = load i32* %globalIdY, align 4
  %62 = icmp ne i32 %61, 0
  br i1 %62, label %63, label %470

; <label>:63                                      ; preds = %60
  %64 = load i32* %globalIdX, align 4
  %65 = load i32* %7, align 4
  %66 = sub i32 %65, 1
  %67 = icmp ne i32 %64, %66
  br i1 %67, label %68, label %470

; <label>:68                                      ; preds = %63
  %69 = load i32* %globalIdY, align 4
  %70 = load i32* %9, align 4
  %71 = sub i32 %70, 1
  %72 = icmp ne i32 %69, %71
  br i1 %72, label %73, label %470

; <label>:73                                      ; preds = %68
  store float 0.000000e+00, float* %leftUp, align 4
  store float 0.000000e+00, float* %up, align 4
  store float 0.000000e+00, float* %rightUp, align 4
  store float 0.000000e+00, float* %left, align 4
  store float 0.000000e+00, float* %right, align 4
  store float 0.000000e+00, float* %leftDown, align 4
  store float 0.000000e+00, float* %down, align 4
  store float 0.000000e+00, float* %rightDown, align 4
  %74 = load i32* %7, align 4
  %75 = load i32* %8, align 4
  %76 = mul i32 %74, %75
  %77 = load i32* %globalIdY, align 4
  %78 = sub i32 %77, 1
  %79 = mul i32 %76, %78
  %80 = load i32* %globalIdX, align 4
  %81 = sub i32 %80, 1
  %82 = load i32* %8, align 4
  %83 = mul i32 %81, %82
  %84 = add i32 %79, %83
  %85 = add i32 %84, 0
  %86 = load float addrspace(1)** %1, align 4
  %87 = getelementptr inbounds float addrspace(1)* %86, i32 %85
  %88 = load float addrspace(1)* %87, align 4
  store float %88, float* %r, align 4
  %89 = load i32* %7, align 4
  %90 = load i32* %8, align 4
  %91 = mul i32 %89, %90
  %92 = load i32* %globalIdY, align 4
  %93 = sub i32 %92, 1
  %94 = mul i32 %91, %93
  %95 = load i32* %globalIdX, align 4
  %96 = sub i32 %95, 1
  %97 = load i32* %8, align 4
  %98 = mul i32 %96, %97
  %99 = add i32 %94, %98
  %100 = add i32 %99, 1
  %101 = load float addrspace(1)** %1, align 4
  %102 = getelementptr inbounds float addrspace(1)* %101, i32 %100
  %103 = load float addrspace(1)* %102, align 4
  store float %103, float* %g, align 4
  %104 = load i32* %7, align 4
  %105 = load i32* %8, align 4
  %106 = mul i32 %104, %105
  %107 = load i32* %globalIdY, align 4
  %108 = sub i32 %107, 1
  %109 = mul i32 %106, %108
  %110 = load i32* %globalIdX, align 4
  %111 = sub i32 %110, 1
  %112 = load i32* %8, align 4
  %113 = mul i32 %111, %112
  %114 = add i32 %109, %113
  %115 = add i32 %114, 2
  %116 = load float addrspace(1)** %1, align 4
  %117 = getelementptr inbounds float addrspace(1)* %116, i32 %115
  %118 = load float addrspace(1)* %117, align 4
  store float %118, float* %b, align 4
  %119 = load float* %r, align 4
  %120 = load float* %g, align 4
  %121 = load float* %b, align 4
  %122 = call float @luminance(float %119, float %120, float %121)
  store float %122, float* %leftUp, align 4
  %123 = load i32* %7, align 4
  %124 = load i32* %8, align 4
  %125 = mul i32 %123, %124
  %126 = load i32* %globalIdY, align 4
  %127 = sub i32 %126, 1
  %128 = mul i32 %125, %127
  %129 = load i32* %globalIdX, align 4
  %130 = load i32* %8, align 4
  %131 = mul i32 %129, %130
  %132 = add i32 %128, %131
  %133 = add i32 %132, 0
  %134 = load float addrspace(1)** %1, align 4
  %135 = getelementptr inbounds float addrspace(1)* %134, i32 %133
  %136 = load float addrspace(1)* %135, align 4
  store float %136, float* %r, align 4
  %137 = load i32* %7, align 4
  %138 = load i32* %8, align 4
  %139 = mul i32 %137, %138
  %140 = load i32* %globalIdY, align 4
  %141 = sub i32 %140, 1
  %142 = mul i32 %139, %141
  %143 = load i32* %globalIdX, align 4
  %144 = load i32* %8, align 4
  %145 = mul i32 %143, %144
  %146 = add i32 %142, %145
  %147 = add i32 %146, 1
  %148 = load float addrspace(1)** %1, align 4
  %149 = getelementptr inbounds float addrspace(1)* %148, i32 %147
  %150 = load float addrspace(1)* %149, align 4
  store float %150, float* %g, align 4
  %151 = load i32* %7, align 4
  %152 = load i32* %8, align 4
  %153 = mul i32 %151, %152
  %154 = load i32* %globalIdY, align 4
  %155 = sub i32 %154, 1
  %156 = mul i32 %153, %155
  %157 = load i32* %globalIdX, align 4
  %158 = load i32* %8, align 4
  %159 = mul i32 %157, %158
  %160 = add i32 %156, %159
  %161 = add i32 %160, 2
  %162 = load float addrspace(1)** %1, align 4
  %163 = getelementptr inbounds float addrspace(1)* %162, i32 %161
  %164 = load float addrspace(1)* %163, align 4
  store float %164, float* %b, align 4
  %165 = load float* %r, align 4
  %166 = load float* %g, align 4
  %167 = load float* %b, align 4
  %168 = call float @luminance(float %165, float %166, float %167)
  store float %168, float* %up, align 4
  %169 = load i32* %7, align 4
  %170 = load i32* %8, align 4
  %171 = mul i32 %169, %170
  %172 = load i32* %globalIdY, align 4
  %173 = sub i32 %172, 1
  %174 = mul i32 %171, %173
  %175 = load i32* %globalIdX, align 4
  %176 = add i32 %175, 1
  %177 = load i32* %8, align 4
  %178 = mul i32 %176, %177
  %179 = add i32 %174, %178
  %180 = add i32 %179, 0
  %181 = load float addrspace(1)** %1, align 4
  %182 = getelementptr inbounds float addrspace(1)* %181, i32 %180
  %183 = load float addrspace(1)* %182, align 4
  store float %183, float* %r, align 4
  %184 = load i32* %7, align 4
  %185 = load i32* %8, align 4
  %186 = mul i32 %184, %185
  %187 = load i32* %globalIdY, align 4
  %188 = sub i32 %187, 1
  %189 = mul i32 %186, %188
  %190 = load i32* %globalIdX, align 4
  %191 = add i32 %190, 1
  %192 = load i32* %8, align 4
  %193 = mul i32 %191, %192
  %194 = add i32 %189, %193
  %195 = add i32 %194, 1
  %196 = load float addrspace(1)** %1, align 4
  %197 = getelementptr inbounds float addrspace(1)* %196, i32 %195
  %198 = load float addrspace(1)* %197, align 4
  store float %198, float* %g, align 4
  %199 = load i32* %7, align 4
  %200 = load i32* %8, align 4
  %201 = mul i32 %199, %200
  %202 = load i32* %globalIdY, align 4
  %203 = sub i32 %202, 1
  %204 = mul i32 %201, %203
  %205 = load i32* %globalIdX, align 4
  %206 = add i32 %205, 1
  %207 = load i32* %8, align 4
  %208 = mul i32 %206, %207
  %209 = add i32 %204, %208
  %210 = add i32 %209, 2
  %211 = load float addrspace(1)** %1, align 4
  %212 = getelementptr inbounds float addrspace(1)* %211, i32 %210
  %213 = load float addrspace(1)* %212, align 4
  store float %213, float* %b, align 4
  %214 = load float* %r, align 4
  %215 = load float* %g, align 4
  %216 = load float* %b, align 4
  %217 = call float @luminance(float %214, float %215, float %216)
  store float %217, float* %rightUp, align 4
  %218 = load i32* %7, align 4
  %219 = load i32* %8, align 4
  %220 = mul i32 %218, %219
  %221 = load i32* %globalIdY, align 4
  %222 = mul i32 %220, %221
  %223 = load i32* %globalIdX, align 4
  %224 = sub i32 %223, 1
  %225 = load i32* %8, align 4
  %226 = mul i32 %224, %225
  %227 = add i32 %222, %226
  %228 = add i32 %227, 0
  %229 = load float addrspace(1)** %1, align 4
  %230 = getelementptr inbounds float addrspace(1)* %229, i32 %228
  %231 = load float addrspace(1)* %230, align 4
  store float %231, float* %r, align 4
  %232 = load i32* %7, align 4
  %233 = load i32* %8, align 4
  %234 = mul i32 %232, %233
  %235 = load i32* %globalIdY, align 4
  %236 = mul i32 %234, %235
  %237 = load i32* %globalIdX, align 4
  %238 = sub i32 %237, 1
  %239 = load i32* %8, align 4
  %240 = mul i32 %238, %239
  %241 = add i32 %236, %240
  %242 = add i32 %241, 1
  %243 = load float addrspace(1)** %1, align 4
  %244 = getelementptr inbounds float addrspace(1)* %243, i32 %242
  %245 = load float addrspace(1)* %244, align 4
  store float %245, float* %g, align 4
  %246 = load i32* %7, align 4
  %247 = load i32* %8, align 4
  %248 = mul i32 %246, %247
  %249 = load i32* %globalIdY, align 4
  %250 = mul i32 %248, %249
  %251 = load i32* %globalIdX, align 4
  %252 = sub i32 %251, 1
  %253 = load i32* %8, align 4
  %254 = mul i32 %252, %253
  %255 = add i32 %250, %254
  %256 = add i32 %255, 2
  %257 = load float addrspace(1)** %1, align 4
  %258 = getelementptr inbounds float addrspace(1)* %257, i32 %256
  %259 = load float addrspace(1)* %258, align 4
  store float %259, float* %b, align 4
  %260 = load float* %r, align 4
  %261 = load float* %g, align 4
  %262 = load float* %b, align 4
  %263 = call float @luminance(float %260, float %261, float %262)
  store float %263, float* %left, align 4
  %264 = load i32* %7, align 4
  %265 = load i32* %8, align 4
  %266 = mul i32 %264, %265
  %267 = load i32* %globalIdY, align 4
  %268 = mul i32 %266, %267
  %269 = load i32* %globalIdX, align 4
  %270 = add i32 %269, 1
  %271 = load i32* %8, align 4
  %272 = mul i32 %270, %271
  %273 = add i32 %268, %272
  %274 = add i32 %273, 0
  %275 = load float addrspace(1)** %1, align 4
  %276 = getelementptr inbounds float addrspace(1)* %275, i32 %274
  %277 = load float addrspace(1)* %276, align 4
  store float %277, float* %r, align 4
  %278 = load i32* %7, align 4
  %279 = load i32* %8, align 4
  %280 = mul i32 %278, %279
  %281 = load i32* %globalIdY, align 4
  %282 = mul i32 %280, %281
  %283 = load i32* %globalIdX, align 4
  %284 = add i32 %283, 1
  %285 = load i32* %8, align 4
  %286 = mul i32 %284, %285
  %287 = add i32 %282, %286
  %288 = add i32 %287, 1
  %289 = load float addrspace(1)** %1, align 4
  %290 = getelementptr inbounds float addrspace(1)* %289, i32 %288
  %291 = load float addrspace(1)* %290, align 4
  store float %291, float* %g, align 4
  %292 = load i32* %7, align 4
  %293 = load i32* %8, align 4
  %294 = mul i32 %292, %293
  %295 = load i32* %globalIdY, align 4
  %296 = mul i32 %294, %295
  %297 = load i32* %globalIdX, align 4
  %298 = add i32 %297, 1
  %299 = load i32* %8, align 4
  %300 = mul i32 %298, %299
  %301 = add i32 %296, %300
  %302 = add i32 %301, 2
  %303 = load float addrspace(1)** %1, align 4
  %304 = getelementptr inbounds float addrspace(1)* %303, i32 %302
  %305 = load float addrspace(1)* %304, align 4
  store float %305, float* %b, align 4
  %306 = load float* %r, align 4
  %307 = load float* %g, align 4
  %308 = load float* %b, align 4
  %309 = call float @luminance(float %306, float %307, float %308)
  store float %309, float* %right, align 4
  %310 = load i32* %7, align 4
  %311 = load i32* %8, align 4
  %312 = mul i32 %310, %311
  %313 = load i32* %globalIdY, align 4
  %314 = add i32 %313, 1
  %315 = mul i32 %312, %314
  %316 = load i32* %globalIdX, align 4
  %317 = sub i32 %316, 1
  %318 = load i32* %8, align 4
  %319 = mul i32 %317, %318
  %320 = add i32 %315, %319
  %321 = add i32 %320, 0
  %322 = load float addrspace(1)** %1, align 4
  %323 = getelementptr inbounds float addrspace(1)* %322, i32 %321
  %324 = load float addrspace(1)* %323, align 4
  store float %324, float* %r, align 4
  %325 = load i32* %7, align 4
  %326 = load i32* %8, align 4
  %327 = mul i32 %325, %326
  %328 = load i32* %globalIdY, align 4
  %329 = add i32 %328, 1
  %330 = mul i32 %327, %329
  %331 = load i32* %globalIdX, align 4
  %332 = sub i32 %331, 1
  %333 = load i32* %8, align 4
  %334 = mul i32 %332, %333
  %335 = add i32 %330, %334
  %336 = add i32 %335, 1
  %337 = load float addrspace(1)** %1, align 4
  %338 = getelementptr inbounds float addrspace(1)* %337, i32 %336
  %339 = load float addrspace(1)* %338, align 4
  store float %339, float* %g, align 4
  %340 = load i32* %7, align 4
  %341 = load i32* %8, align 4
  %342 = mul i32 %340, %341
  %343 = load i32* %globalIdY, align 4
  %344 = add i32 %343, 1
  %345 = mul i32 %342, %344
  %346 = load i32* %globalIdX, align 4
  %347 = sub i32 %346, 1
  %348 = load i32* %8, align 4
  %349 = mul i32 %347, %348
  %350 = add i32 %345, %349
  %351 = add i32 %350, 2
  %352 = load float addrspace(1)** %1, align 4
  %353 = getelementptr inbounds float addrspace(1)* %352, i32 %351
  %354 = load float addrspace(1)* %353, align 4
  store float %354, float* %b, align 4
  %355 = load float* %r, align 4
  %356 = load float* %g, align 4
  %357 = load float* %b, align 4
  %358 = call float @luminance(float %355, float %356, float %357)
  store float %358, float* %leftDown, align 4
  %359 = load i32* %7, align 4
  %360 = load i32* %8, align 4
  %361 = mul i32 %359, %360
  %362 = load i32* %globalIdY, align 4
  %363 = add i32 %362, 1
  %364 = mul i32 %361, %363
  %365 = load i32* %globalIdX, align 4
  %366 = load i32* %8, align 4
  %367 = mul i32 %365, %366
  %368 = add i32 %364, %367
  %369 = add i32 %368, 0
  %370 = load float addrspace(1)** %1, align 4
  %371 = getelementptr inbounds float addrspace(1)* %370, i32 %369
  %372 = load float addrspace(1)* %371, align 4
  store float %372, float* %r, align 4
  %373 = load i32* %7, align 4
  %374 = load i32* %8, align 4
  %375 = mul i32 %373, %374
  %376 = load i32* %globalIdY, align 4
  %377 = add i32 %376, 1
  %378 = mul i32 %375, %377
  %379 = load i32* %globalIdX, align 4
  %380 = load i32* %8, align 4
  %381 = mul i32 %379, %380
  %382 = add i32 %378, %381
  %383 = add i32 %382, 1
  %384 = load float addrspace(1)** %1, align 4
  %385 = getelementptr inbounds float addrspace(1)* %384, i32 %383
  %386 = load float addrspace(1)* %385, align 4
  store float %386, float* %g, align 4
  %387 = load i32* %7, align 4
  %388 = load i32* %8, align 4
  %389 = mul i32 %387, %388
  %390 = load i32* %globalIdY, align 4
  %391 = add i32 %390, 1
  %392 = mul i32 %389, %391
  %393 = load i32* %globalIdX, align 4
  %394 = load i32* %8, align 4
  %395 = mul i32 %393, %394
  %396 = add i32 %392, %395
  %397 = add i32 %396, 2
  %398 = load float addrspace(1)** %1, align 4
  %399 = getelementptr inbounds float addrspace(1)* %398, i32 %397
  %400 = load float addrspace(1)* %399, align 4
  store float %400, float* %b, align 4
  %401 = load float* %r, align 4
  %402 = load float* %g, align 4
  %403 = load float* %b, align 4
  %404 = call float @luminance(float %401, float %402, float %403)
  store float %404, float* %down, align 4
  %405 = load i32* %7, align 4
  %406 = load i32* %8, align 4
  %407 = mul i32 %405, %406
  %408 = load i32* %globalIdY, align 4
  %409 = add i32 %408, 1
  %410 = mul i32 %407, %409
  %411 = load i32* %globalIdX, align 4
  %412 = add i32 %411, 1
  %413 = load i32* %8, align 4
  %414 = mul i32 %412, %413
  %415 = add i32 %410, %414
  %416 = add i32 %415, 0
  %417 = load float addrspace(1)** %1, align 4
  %418 = getelementptr inbounds float addrspace(1)* %417, i32 %416
  %419 = load float addrspace(1)* %418, align 4
  store float %419, float* %r, align 4
  %420 = load i32* %7, align 4
  %421 = load i32* %8, align 4
  %422 = mul i32 %420, %421
  %423 = load i32* %globalIdY, align 4
  %424 = add i32 %423, 1
  %425 = mul i32 %422, %424
  %426 = load i32* %globalIdX, align 4
  %427 = add i32 %426, 1
  %428 = load i32* %8, align 4
  %429 = mul i32 %427, %428
  %430 = add i32 %425, %429
  %431 = add i32 %430, 1
  %432 = load float addrspace(1)** %1, align 4
  %433 = getelementptr inbounds float addrspace(1)* %432, i32 %431
  %434 = load float addrspace(1)* %433, align 4
  store float %434, float* %g, align 4
  %435 = load i32* %7, align 4
  %436 = load i32* %8, align 4
  %437 = mul i32 %435, %436
  %438 = load i32* %globalIdY, align 4
  %439 = add i32 %438, 1
  %440 = mul i32 %437, %439
  %441 = load i32* %globalIdX, align 4
  %442 = add i32 %441, 1
  %443 = load i32* %8, align 4
  %444 = mul i32 %442, %443
  %445 = add i32 %440, %444
  %446 = add i32 %445, 2
  %447 = load float addrspace(1)** %1, align 4
  %448 = getelementptr inbounds float addrspace(1)* %447, i32 %446
  %449 = load float addrspace(1)* %448, align 4
  store float %449, float* %b, align 4
  %450 = load float* %r, align 4
  %451 = load float* %g, align 4
  %452 = load float* %b, align 4
  %453 = call float @luminance(float %450, float %451, float %452)
  store float %453, float* %rightDown, align 4
  %454 = load float* %leftUp, align 4
  %455 = load float* %up, align 4
  %456 = fadd float %454, %455
  %457 = load float* %rightUp, align 4
  %458 = fadd float %456, %457
  %459 = load float* %left, align 4
  %460 = fadd float %458, %459
  %461 = load float* %right, align 4
  %462 = fadd float %460, %461
  %463 = load float* %leftDown, align 4
  %464 = fadd float %462, %463
  %465 = load float* %down, align 4
  %466 = fadd float %464, %465
  %467 = load float* %rightDown, align 4
  %468 = fadd float %466, %467
  %469 = fdiv float %468, 8.000000e+00, !fpmath !3
  store float %469, float* %yLPattanaik, align 4
  br label %472

; <label>:470                                     ; preds = %68, %63, %60, %0
  %471 = load float* %yLuminance, align 4
  store float %471, float* %yLPattanaik, align 4
  br label %472

; <label>:472                                     ; preds = %470, %73
  %473 = load float* %yLPattanaik, align 4
  %474 = load float* %6, align 4
  %475 = load float* %yLPattanaik, align 4
  %476 = load float* %yLuminance, align 4
  %477 = fdiv float %475, %476, !fpmath !3
  %478 = fadd float %474, %477
  %479 = call float @llvm.log2.f32(float %478)
  %480 = fmul float %479, 0x3FE62E4300000000
  %481 = load float* %gcPattanaik, align 4
  %482 = call float @llvm.fmuladd.f32(float %473, float %480, float %481)
  store float %482, float* %cLPattanaik, align 4
  %483 = load float* %yLuminance, align 4
  %484 = load float* %yLuminance, align 4
  %485 = load float* %cLPattanaik, align 4
  %486 = fadd float %484, %485
  %487 = fdiv float %483, %486, !fpmath !3
  store float %487, float* %yDPattanaik, align 4
  %488 = load float* %r1, align 4
  %489 = load float* %yLuminance, align 4
  %490 = fdiv float %488, %489, !fpmath !3
  %491 = load float* %4, align 4
  %492 = call float @llvm.pow.f32(float %490, float %491)
  %493 = load float* %yDPattanaik, align 4
  %494 = fmul float %492, %493
  store float %494, float* %r, align 4
  %495 = load float* %g1, align 4
  %496 = load float* %yLuminance, align 4
  %497 = fdiv float %495, %496, !fpmath !3
  %498 = load float* %4, align 4
  %499 = call float @llvm.pow.f32(float %497, float %498)
  %500 = load float* %yDPattanaik, align 4
  %501 = fmul float %499, %500
  store float %501, float* %g, align 4
  %502 = load float* %b1, align 4
  %503 = load float* %yLuminance, align 4
  %504 = fdiv float %502, %503, !fpmath !3
  %505 = load float* %4, align 4
  %506 = call float @llvm.pow.f32(float %504, float %505)
  %507 = load float* %yDPattanaik, align 4
  %508 = fmul float %506, %507
  store float %508, float* %b, align 4
  %509 = load float* %r, align 4
  %510 = load i32* %7, align 4
  %511 = load i32* %8, align 4
  %512 = mul i32 %510, %511
  %513 = load i32* %globalIdY, align 4
  %514 = mul i32 %512, %513
  %515 = load i32* %globalIdX, align 4
  %516 = load i32* %8, align 4
  %517 = mul i32 %515, %516
  %518 = add i32 %517, 0
  %519 = add i32 %514, %518
  %520 = load float addrspace(1)** %2, align 4
  %521 = getelementptr inbounds float addrspace(1)* %520, i32 %519
  store float %509, float addrspace(1)* %521, align 4
  %522 = load float* %g, align 4
  %523 = load i32* %7, align 4
  %524 = load i32* %8, align 4
  %525 = mul i32 %523, %524
  %526 = load i32* %globalIdY, align 4
  %527 = mul i32 %525, %526
  %528 = load i32* %globalIdX, align 4
  %529 = load i32* %8, align 4
  %530 = mul i32 %528, %529
  %531 = add i32 %530, 1
  %532 = add i32 %527, %531
  %533 = load float addrspace(1)** %2, align 4
  %534 = getelementptr inbounds float addrspace(1)* %533, i32 %532
  store float %522, float addrspace(1)* %534, align 4
  %535 = load float* %b, align 4
  %536 = load i32* %7, align 4
  %537 = load i32* %8, align 4
  %538 = mul i32 %536, %537
  %539 = load i32* %globalIdY, align 4
  %540 = mul i32 %538, %539
  %541 = load i32* %globalIdX, align 4
  %542 = load i32* %8, align 4
  %543 = mul i32 %541, %542
  %544 = add i32 %543, 2
  %545 = add i32 %540, %544
  %546 = load float addrspace(1)** %2, align 4
  %547 = getelementptr inbounds float addrspace(1)* %546, i32 %545
  store float %535, float addrspace(1)* %547, align 4
  %548 = load i32* %7, align 4
  %549 = load i32* %8, align 4
  %550 = mul i32 %548, %549
  %551 = load i32* %globalIdY, align 4
  %552 = mul i32 %550, %551
  %553 = load i32* %globalIdX, align 4
  %554 = load i32* %8, align 4
  %555 = mul i32 %553, %554
  %556 = add i32 %555, 3
  %557 = add i32 %552, %556
  %558 = load float addrspace(1)** %1, align 4
  %559 = getelementptr inbounds float addrspace(1)* %558, i32 %557
  %560 = load float addrspace(1)* %559, align 4
  %561 = load i32* %7, align 4
  %562 = load i32* %8, align 4
  %563 = mul i32 %561, %562
  %564 = load i32* %globalIdY, align 4
  %565 = mul i32 %563, %564
  %566 = load i32* %globalIdX, align 4
  %567 = load i32* %8, align 4
  %568 = mul i32 %566, %567
  %569 = add i32 %568, 3
  %570 = add i32 %565, %569
  %571 = load float addrspace(1)** %2, align 4
  %572 = getelementptr inbounds float addrspace(1)* %571, i32 %570
  store float %560, float addrspace(1)* %572, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #3

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #3

; Function Attrs: nounwind
define void @toneMappingPattanaik(<4 x float> addrspace(1)* %input, <4 x float> addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
  %1 = alloca <4 x float> addrspace(1)*, align 4
  %2 = alloca <4 x float> addrspace(1)*, align 4
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %globalIdX = alloca i32, align 4
  %globalIdY = alloca i32, align 4
  %r = alloca float, align 4
  %r1 = alloca float, align 4
  %g = alloca float, align 4
  %g1 = alloca float, align 4
  %b = alloca float, align 4
  %b1 = alloca float, align 4
  %yLuminance = alloca float, align 4
  %cLPattanaik = alloca float, align 4
  %yLPattanaik = alloca float, align 4
  %gcPattanaik = alloca float, align 4
  %leftUp = alloca float, align 4
  %up = alloca float, align 4
  %rightUp = alloca float, align 4
  %left = alloca float, align 4
  %right = alloca float, align 4
  %leftDown = alloca float, align 4
  %down = alloca float, align 4
  %rightDown = alloca float, align 4
  %yDPattanaik = alloca float, align 4
  store <4 x float> addrspace(1)* %input, <4 x float> addrspace(1)** %1, align 4
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %2, align 4
  store float %averageLuminance, float* %3, align 4
  store float %gamma, float* %4, align 4
  store float %c, float* %5, align 4
  store float %delta, float* %6, align 4
  store i32 %width, i32* %7, align 4
  store i32 %numChannels, i32* %8, align 4
  store i32 %height, i32* %9, align 4
  %10 = call i32 @__get_global_id_u32(i32 0)
  store i32 %10, i32* %globalIdX, align 4
  %11 = call i32 @__get_global_id_u32(i32 1)
  store i32 %11, i32* %globalIdY, align 4
  store float 0.000000e+00, float* %yLuminance, align 4
  store float 0.000000e+00, float* %cLPattanaik, align 4
  store float 0.000000e+00, float* %yLPattanaik, align 4
  %12 = load i32* %7, align 4
  %13 = load i32* %globalIdY, align 4
  %14 = mul i32 %12, %13
  %15 = load i32* %globalIdX, align 4
  %16 = add i32 %14, %15
  %17 = load <4 x float> addrspace(1)** %1, align 4
  %18 = getelementptr inbounds <4 x float> addrspace(1)* %17, i32 %16
  %19 = load <4 x float> addrspace(1)* %18, align 16
  %20 = extractelement <4 x float> %19, i32 0
  store float %20, float* %r1, align 4
  %21 = load i32* %7, align 4
  %22 = load i32* %globalIdY, align 4
  %23 = mul i32 %21, %22
  %24 = load i32* %globalIdX, align 4
  %25 = add i32 %23, %24
  %26 = load <4 x float> addrspace(1)** %1, align 4
  %27 = getelementptr inbounds <4 x float> addrspace(1)* %26, i32 %25
  %28 = load <4 x float> addrspace(1)* %27, align 16
  %29 = extractelement <4 x float> %28, i32 1
  store float %29, float* %g1, align 4
  %30 = load i32* %7, align 4
  %31 = load i32* %globalIdY, align 4
  %32 = mul i32 %30, %31
  %33 = load i32* %globalIdX, align 4
  %34 = add i32 %32, %33
  %35 = load <4 x float> addrspace(1)** %1, align 4
  %36 = getelementptr inbounds <4 x float> addrspace(1)* %35, i32 %34
  %37 = load <4 x float> addrspace(1)* %36, align 16
  %38 = extractelement <4 x float> %37, i32 2
  store float %38, float* %b1, align 4
  %39 = load float* %r1, align 4
  %40 = load float* %g1, align 4
  %41 = load float* %b1, align 4
  %42 = call float @luminance(float %39, float %40, float %41)
  store float %42, float* %yLuminance, align 4
  %43 = load float* %5, align 4
  %44 = load float* %3, align 4
  %45 = fmul float %43, %44
  store float %45, float* %gcPattanaik, align 4
  %46 = load i32* %globalIdX, align 4
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %48, label %362

; <label>:48                                      ; preds = %0
  %49 = load i32* %globalIdY, align 4
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %51, label %362

; <label>:51                                      ; preds = %48
  %52 = load i32* %globalIdX, align 4
  %53 = load i32* %7, align 4
  %54 = sub i32 %53, 1
  %55 = icmp ne i32 %52, %54
  br i1 %55, label %56, label %362

; <label>:56                                      ; preds = %51
  %57 = load i32* %globalIdY, align 4
  %58 = load i32* %9, align 4
  %59 = sub i32 %58, 1
  %60 = icmp ne i32 %57, %59
  br i1 %60, label %61, label %362

; <label>:61                                      ; preds = %56
  store float 0.000000e+00, float* %leftUp, align 4
  store float 0.000000e+00, float* %up, align 4
  store float 0.000000e+00, float* %rightUp, align 4
  store float 0.000000e+00, float* %left, align 4
  store float 0.000000e+00, float* %right, align 4
  store float 0.000000e+00, float* %leftDown, align 4
  store float 0.000000e+00, float* %down, align 4
  store float 0.000000e+00, float* %rightDown, align 4
  %62 = load i32* %7, align 4
  %63 = load i32* %globalIdY, align 4
  %64 = sub i32 %63, 1
  %65 = mul i32 %62, %64
  %66 = load i32* %globalIdX, align 4
  %67 = add i32 %65, %66
  %68 = sub i32 %67, 1
  %69 = load <4 x float> addrspace(1)** %1, align 4
  %70 = getelementptr inbounds <4 x float> addrspace(1)* %69, i32 %68
  %71 = load <4 x float> addrspace(1)* %70, align 16
  %72 = extractelement <4 x float> %71, i32 0
  store float %72, float* %r, align 4
  %73 = load i32* %7, align 4
  %74 = load i32* %globalIdY, align 4
  %75 = sub i32 %74, 1
  %76 = mul i32 %73, %75
  %77 = load i32* %globalIdX, align 4
  %78 = add i32 %76, %77
  %79 = sub i32 %78, 1
  %80 = load <4 x float> addrspace(1)** %1, align 4
  %81 = getelementptr inbounds <4 x float> addrspace(1)* %80, i32 %79
  %82 = load <4 x float> addrspace(1)* %81, align 16
  %83 = extractelement <4 x float> %82, i32 1
  store float %83, float* %g, align 4
  %84 = load i32* %7, align 4
  %85 = load i32* %globalIdY, align 4
  %86 = sub i32 %85, 1
  %87 = mul i32 %84, %86
  %88 = load i32* %globalIdX, align 4
  %89 = add i32 %87, %88
  %90 = sub i32 %89, 1
  %91 = load <4 x float> addrspace(1)** %1, align 4
  %92 = getelementptr inbounds <4 x float> addrspace(1)* %91, i32 %90
  %93 = load <4 x float> addrspace(1)* %92, align 16
  %94 = extractelement <4 x float> %93, i32 2
  store float %94, float* %b, align 4
  %95 = load float* %r, align 4
  %96 = load float* %g, align 4
  %97 = load float* %b, align 4
  %98 = call float @luminance(float %95, float %96, float %97)
  store float %98, float* %leftUp, align 4
  %99 = load i32* %7, align 4
  %100 = load i32* %globalIdY, align 4
  %101 = sub i32 %100, 1
  %102 = mul i32 %99, %101
  %103 = load i32* %globalIdX, align 4
  %104 = add i32 %102, %103
  %105 = load <4 x float> addrspace(1)** %1, align 4
  %106 = getelementptr inbounds <4 x float> addrspace(1)* %105, i32 %104
  %107 = load <4 x float> addrspace(1)* %106, align 16
  %108 = extractelement <4 x float> %107, i32 0
  store float %108, float* %r, align 4
  %109 = load i32* %7, align 4
  %110 = load i32* %globalIdY, align 4
  %111 = sub i32 %110, 1
  %112 = mul i32 %109, %111
  %113 = load i32* %globalIdX, align 4
  %114 = add i32 %112, %113
  %115 = load <4 x float> addrspace(1)** %1, align 4
  %116 = getelementptr inbounds <4 x float> addrspace(1)* %115, i32 %114
  %117 = load <4 x float> addrspace(1)* %116, align 16
  %118 = extractelement <4 x float> %117, i32 1
  store float %118, float* %g, align 4
  %119 = load i32* %7, align 4
  %120 = load i32* %globalIdY, align 4
  %121 = sub i32 %120, 1
  %122 = mul i32 %119, %121
  %123 = load i32* %globalIdX, align 4
  %124 = add i32 %122, %123
  %125 = load <4 x float> addrspace(1)** %1, align 4
  %126 = getelementptr inbounds <4 x float> addrspace(1)* %125, i32 %124
  %127 = load <4 x float> addrspace(1)* %126, align 16
  %128 = extractelement <4 x float> %127, i32 2
  store float %128, float* %b, align 4
  %129 = load float* %r, align 4
  %130 = load float* %g, align 4
  %131 = load float* %b, align 4
  %132 = call float @luminance(float %129, float %130, float %131)
  store float %132, float* %up, align 4
  %133 = load i32* %7, align 4
  %134 = load i32* %globalIdY, align 4
  %135 = sub i32 %134, 1
  %136 = mul i32 %133, %135
  %137 = load i32* %globalIdX, align 4
  %138 = add i32 %136, %137
  %139 = add i32 %138, 1
  %140 = load <4 x float> addrspace(1)** %1, align 4
  %141 = getelementptr inbounds <4 x float> addrspace(1)* %140, i32 %139
  %142 = load <4 x float> addrspace(1)* %141, align 16
  %143 = extractelement <4 x float> %142, i32 0
  store float %143, float* %r, align 4
  %144 = load i32* %7, align 4
  %145 = load i32* %globalIdY, align 4
  %146 = sub i32 %145, 1
  %147 = mul i32 %144, %146
  %148 = load i32* %globalIdX, align 4
  %149 = add i32 %147, %148
  %150 = add i32 %149, 1
  %151 = load <4 x float> addrspace(1)** %1, align 4
  %152 = getelementptr inbounds <4 x float> addrspace(1)* %151, i32 %150
  %153 = load <4 x float> addrspace(1)* %152, align 16
  %154 = extractelement <4 x float> %153, i32 1
  store float %154, float* %g, align 4
  %155 = load i32* %7, align 4
  %156 = load i32* %globalIdY, align 4
  %157 = sub i32 %156, 1
  %158 = mul i32 %155, %157
  %159 = load i32* %globalIdX, align 4
  %160 = add i32 %158, %159
  %161 = add i32 %160, 1
  %162 = load <4 x float> addrspace(1)** %1, align 4
  %163 = getelementptr inbounds <4 x float> addrspace(1)* %162, i32 %161
  %164 = load <4 x float> addrspace(1)* %163, align 16
  %165 = extractelement <4 x float> %164, i32 2
  store float %165, float* %b, align 4
  %166 = load float* %r, align 4
  %167 = load float* %g, align 4
  %168 = load float* %b, align 4
  %169 = call float @luminance(float %166, float %167, float %168)
  store float %169, float* %rightUp, align 4
  %170 = load i32* %7, align 4
  %171 = load i32* %globalIdY, align 4
  %172 = mul i32 %170, %171
  %173 = load i32* %globalIdX, align 4
  %174 = add i32 %172, %173
  %175 = sub i32 %174, 1
  %176 = load <4 x float> addrspace(1)** %1, align 4
  %177 = getelementptr inbounds <4 x float> addrspace(1)* %176, i32 %175
  %178 = load <4 x float> addrspace(1)* %177, align 16
  %179 = extractelement <4 x float> %178, i32 0
  store float %179, float* %r, align 4
  %180 = load i32* %7, align 4
  %181 = load i32* %globalIdY, align 4
  %182 = mul i32 %180, %181
  %183 = load i32* %globalIdX, align 4
  %184 = add i32 %182, %183
  %185 = sub i32 %184, 1
  %186 = load <4 x float> addrspace(1)** %1, align 4
  %187 = getelementptr inbounds <4 x float> addrspace(1)* %186, i32 %185
  %188 = load <4 x float> addrspace(1)* %187, align 16
  %189 = extractelement <4 x float> %188, i32 1
  store float %189, float* %g, align 4
  %190 = load i32* %7, align 4
  %191 = load i32* %globalIdY, align 4
  %192 = mul i32 %190, %191
  %193 = load i32* %globalIdX, align 4
  %194 = add i32 %192, %193
  %195 = sub i32 %194, 1
  %196 = load <4 x float> addrspace(1)** %1, align 4
  %197 = getelementptr inbounds <4 x float> addrspace(1)* %196, i32 %195
  %198 = load <4 x float> addrspace(1)* %197, align 16
  %199 = extractelement <4 x float> %198, i32 2
  store float %199, float* %b, align 4
  %200 = load float* %r, align 4
  %201 = load float* %g, align 4
  %202 = load float* %b, align 4
  %203 = call float @luminance(float %200, float %201, float %202)
  store float %203, float* %left, align 4
  %204 = load i32* %7, align 4
  %205 = load i32* %globalIdY, align 4
  %206 = mul i32 %204, %205
  %207 = load i32* %globalIdX, align 4
  %208 = add i32 %206, %207
  %209 = add i32 %208, 1
  %210 = load <4 x float> addrspace(1)** %1, align 4
  %211 = getelementptr inbounds <4 x float> addrspace(1)* %210, i32 %209
  %212 = load <4 x float> addrspace(1)* %211, align 16
  %213 = extractelement <4 x float> %212, i32 0
  store float %213, float* %r, align 4
  %214 = load i32* %7, align 4
  %215 = load i32* %globalIdY, align 4
  %216 = mul i32 %214, %215
  %217 = load i32* %globalIdX, align 4
  %218 = add i32 %216, %217
  %219 = add i32 %218, 1
  %220 = load <4 x float> addrspace(1)** %1, align 4
  %221 = getelementptr inbounds <4 x float> addrspace(1)* %220, i32 %219
  %222 = load <4 x float> addrspace(1)* %221, align 16
  %223 = extractelement <4 x float> %222, i32 1
  store float %223, float* %g, align 4
  %224 = load i32* %7, align 4
  %225 = load i32* %globalIdY, align 4
  %226 = mul i32 %224, %225
  %227 = load i32* %globalIdX, align 4
  %228 = add i32 %226, %227
  %229 = add i32 %228, 1
  %230 = load <4 x float> addrspace(1)** %1, align 4
  %231 = getelementptr inbounds <4 x float> addrspace(1)* %230, i32 %229
  %232 = load <4 x float> addrspace(1)* %231, align 16
  %233 = extractelement <4 x float> %232, i32 2
  store float %233, float* %b, align 4
  %234 = load float* %r, align 4
  %235 = load float* %g, align 4
  %236 = load float* %b, align 4
  %237 = call float @luminance(float %234, float %235, float %236)
  store float %237, float* %right, align 4
  %238 = load i32* %7, align 4
  %239 = load i32* %globalIdY, align 4
  %240 = add i32 %239, 1
  %241 = mul i32 %238, %240
  %242 = load i32* %globalIdX, align 4
  %243 = add i32 %241, %242
  %244 = sub i32 %243, 1
  %245 = load <4 x float> addrspace(1)** %1, align 4
  %246 = getelementptr inbounds <4 x float> addrspace(1)* %245, i32 %244
  %247 = load <4 x float> addrspace(1)* %246, align 16
  %248 = extractelement <4 x float> %247, i32 0
  store float %248, float* %r, align 4
  %249 = load i32* %7, align 4
  %250 = load i32* %globalIdY, align 4
  %251 = add i32 %250, 1
  %252 = mul i32 %249, %251
  %253 = load i32* %globalIdX, align 4
  %254 = add i32 %252, %253
  %255 = sub i32 %254, 1
  %256 = load <4 x float> addrspace(1)** %1, align 4
  %257 = getelementptr inbounds <4 x float> addrspace(1)* %256, i32 %255
  %258 = load <4 x float> addrspace(1)* %257, align 16
  %259 = extractelement <4 x float> %258, i32 1
  store float %259, float* %g, align 4
  %260 = load i32* %7, align 4
  %261 = load i32* %globalIdY, align 4
  %262 = add i32 %261, 1
  %263 = mul i32 %260, %262
  %264 = load i32* %globalIdX, align 4
  %265 = add i32 %263, %264
  %266 = sub i32 %265, 1
  %267 = load <4 x float> addrspace(1)** %1, align 4
  %268 = getelementptr inbounds <4 x float> addrspace(1)* %267, i32 %266
  %269 = load <4 x float> addrspace(1)* %268, align 16
  %270 = extractelement <4 x float> %269, i32 2
  store float %270, float* %b, align 4
  %271 = load float* %r, align 4
  %272 = load float* %g, align 4
  %273 = load float* %b, align 4
  %274 = call float @luminance(float %271, float %272, float %273)
  store float %274, float* %leftDown, align 4
  %275 = load i32* %7, align 4
  %276 = load i32* %globalIdY, align 4
  %277 = add i32 %276, 1
  %278 = mul i32 %275, %277
  %279 = load i32* %globalIdX, align 4
  %280 = add i32 %278, %279
  %281 = load <4 x float> addrspace(1)** %1, align 4
  %282 = getelementptr inbounds <4 x float> addrspace(1)* %281, i32 %280
  %283 = load <4 x float> addrspace(1)* %282, align 16
  %284 = extractelement <4 x float> %283, i32 0
  store float %284, float* %r, align 4
  %285 = load i32* %7, align 4
  %286 = load i32* %globalIdY, align 4
  %287 = add i32 %286, 1
  %288 = mul i32 %285, %287
  %289 = load i32* %globalIdX, align 4
  %290 = add i32 %288, %289
  %291 = load <4 x float> addrspace(1)** %1, align 4
  %292 = getelementptr inbounds <4 x float> addrspace(1)* %291, i32 %290
  %293 = load <4 x float> addrspace(1)* %292, align 16
  %294 = extractelement <4 x float> %293, i32 1
  store float %294, float* %g, align 4
  %295 = load i32* %7, align 4
  %296 = load i32* %globalIdY, align 4
  %297 = add i32 %296, 1
  %298 = mul i32 %295, %297
  %299 = load i32* %globalIdX, align 4
  %300 = add i32 %298, %299
  %301 = load <4 x float> addrspace(1)** %1, align 4
  %302 = getelementptr inbounds <4 x float> addrspace(1)* %301, i32 %300
  %303 = load <4 x float> addrspace(1)* %302, align 16
  %304 = extractelement <4 x float> %303, i32 2
  store float %304, float* %b, align 4
  %305 = load float* %r, align 4
  %306 = load float* %g, align 4
  %307 = load float* %b, align 4
  %308 = call float @luminance(float %305, float %306, float %307)
  store float %308, float* %down, align 4
  %309 = load i32* %7, align 4
  %310 = load i32* %globalIdY, align 4
  %311 = add i32 %310, 1
  %312 = mul i32 %309, %311
  %313 = load i32* %globalIdX, align 4
  %314 = add i32 %312, %313
  %315 = add i32 %314, 1
  %316 = load <4 x float> addrspace(1)** %1, align 4
  %317 = getelementptr inbounds <4 x float> addrspace(1)* %316, i32 %315
  %318 = load <4 x float> addrspace(1)* %317, align 16
  %319 = extractelement <4 x float> %318, i32 0
  store float %319, float* %r, align 4
  %320 = load i32* %7, align 4
  %321 = load i32* %globalIdY, align 4
  %322 = add i32 %321, 1
  %323 = mul i32 %320, %322
  %324 = load i32* %globalIdX, align 4
  %325 = add i32 %323, %324
  %326 = add i32 %325, 1
  %327 = load <4 x float> addrspace(1)** %1, align 4
  %328 = getelementptr inbounds <4 x float> addrspace(1)* %327, i32 %326
  %329 = load <4 x float> addrspace(1)* %328, align 16
  %330 = extractelement <4 x float> %329, i32 1
  store float %330, float* %g, align 4
  %331 = load i32* %7, align 4
  %332 = load i32* %globalIdY, align 4
  %333 = add i32 %332, 1
  %334 = mul i32 %331, %333
  %335 = load i32* %globalIdX, align 4
  %336 = add i32 %334, %335
  %337 = add i32 %336, 1
  %338 = load <4 x float> addrspace(1)** %1, align 4
  %339 = getelementptr inbounds <4 x float> addrspace(1)* %338, i32 %337
  %340 = load <4 x float> addrspace(1)* %339, align 16
  %341 = extractelement <4 x float> %340, i32 2
  store float %341, float* %b, align 4
  %342 = load float* %r, align 4
  %343 = load float* %g, align 4
  %344 = load float* %b, align 4
  %345 = call float @luminance(float %342, float %343, float %344)
  store float %345, float* %rightDown, align 4
  %346 = load float* %leftUp, align 4
  %347 = load float* %up, align 4
  %348 = fadd float %346, %347
  %349 = load float* %rightUp, align 4
  %350 = fadd float %348, %349
  %351 = load float* %left, align 4
  %352 = fadd float %350, %351
  %353 = load float* %right, align 4
  %354 = fadd float %352, %353
  %355 = load float* %leftDown, align 4
  %356 = fadd float %354, %355
  %357 = load float* %down, align 4
  %358 = fadd float %356, %357
  %359 = load float* %rightDown, align 4
  %360 = fadd float %358, %359
  %361 = fdiv float %360, 8.000000e+00, !fpmath !3
  store float %361, float* %yLPattanaik, align 4
  br label %364

; <label>:362                                     ; preds = %56, %51, %48, %0
  %363 = load float* %yLuminance, align 4
  store float %363, float* %yLPattanaik, align 4
  br label %364

; <label>:364                                     ; preds = %362, %61
  %365 = load float* %yLPattanaik, align 4
  %366 = load float* %6, align 4
  %367 = load float* %yLPattanaik, align 4
  %368 = load float* %yLuminance, align 4
  %369 = fdiv float %367, %368, !fpmath !3
  %370 = fadd float %366, %369
  %371 = call float @llvm.log2.f32(float %370)
  %372 = fmul float %371, 0x3FE62E4300000000
  %373 = load float* %gcPattanaik, align 4
  %374 = call float @llvm.fmuladd.f32(float %365, float %372, float %373)
  store float %374, float* %cLPattanaik, align 4
  %375 = load float* %yLuminance, align 4
  %376 = load float* %yLuminance, align 4
  %377 = load float* %cLPattanaik, align 4
  %378 = fadd float %376, %377
  %379 = fdiv float %375, %378, !fpmath !3
  store float %379, float* %yDPattanaik, align 4
  %380 = load float* %r1, align 4
  %381 = load float* %yLuminance, align 4
  %382 = fdiv float %380, %381, !fpmath !3
  %383 = load float* %4, align 4
  %384 = call float @llvm.pow.f32(float %382, float %383)
  %385 = load float* %yDPattanaik, align 4
  %386 = fmul float %384, %385
  store float %386, float* %r, align 4
  %387 = load float* %g1, align 4
  %388 = load float* %yLuminance, align 4
  %389 = fdiv float %387, %388, !fpmath !3
  %390 = load float* %4, align 4
  %391 = call float @llvm.pow.f32(float %389, float %390)
  %392 = load float* %yDPattanaik, align 4
  %393 = fmul float %391, %392
  store float %393, float* %g, align 4
  %394 = load float* %b1, align 4
  %395 = load float* %yLuminance, align 4
  %396 = fdiv float %394, %395, !fpmath !3
  %397 = load float* %4, align 4
  %398 = call float @llvm.pow.f32(float %396, float %397)
  %399 = load float* %yDPattanaik, align 4
  %400 = fmul float %398, %399
  store float %400, float* %b, align 4
  %401 = load float* %r, align 4
  %402 = load i32* %7, align 4
  %403 = load i32* %globalIdY, align 4
  %404 = mul i32 %402, %403
  %405 = load i32* %globalIdX, align 4
  %406 = add i32 %404, %405
  %407 = load <4 x float> addrspace(1)** %2, align 4
  %408 = getelementptr inbounds <4 x float> addrspace(1)* %407, i32 %406
  %409 = load <4 x float> addrspace(1)* %408, align 16
  %410 = insertelement <4 x float> %409, float %401, i32 0
  store <4 x float> %410, <4 x float> addrspace(1)* %408, align 16
  %411 = load float* %g, align 4
  %412 = load i32* %7, align 4
  %413 = load i32* %globalIdY, align 4
  %414 = mul i32 %412, %413
  %415 = load i32* %globalIdX, align 4
  %416 = add i32 %414, %415
  %417 = load <4 x float> addrspace(1)** %2, align 4
  %418 = getelementptr inbounds <4 x float> addrspace(1)* %417, i32 %416
  %419 = load <4 x float> addrspace(1)* %418, align 16
  %420 = insertelement <4 x float> %419, float %411, i32 1
  store <4 x float> %420, <4 x float> addrspace(1)* %418, align 16
  %421 = load float* %b, align 4
  %422 = load i32* %7, align 4
  %423 = load i32* %globalIdY, align 4
  %424 = mul i32 %422, %423
  %425 = load i32* %globalIdX, align 4
  %426 = add i32 %424, %425
  %427 = load <4 x float> addrspace(1)** %2, align 4
  %428 = getelementptr inbounds <4 x float> addrspace(1)* %427, i32 %426
  %429 = load <4 x float> addrspace(1)* %428, align 16
  %430 = insertelement <4 x float> %429, float %421, i32 2
  store <4 x float> %430, <4 x float> addrspace(1)* %428, align 16
  %431 = load i32* %7, align 4
  %432 = load i32* %globalIdY, align 4
  %433 = mul i32 %431, %432
  %434 = load i32* %globalIdX, align 4
  %435 = add i32 %433, %434
  %436 = load <4 x float> addrspace(1)** %1, align 4
  %437 = getelementptr inbounds <4 x float> addrspace(1)* %436, i32 %435
  %438 = load <4 x float> addrspace(1)* %437, align 16
  %439 = extractelement <4 x float> %438, i32 3
  %440 = load i32* %7, align 4
  %441 = load i32* %globalIdY, align 4
  %442 = mul i32 %440, %441
  %443 = load i32* %globalIdX, align 4
  %444 = add i32 %442, %443
  %445 = load <4 x float> addrspace(1)** %2, align 4
  %446 = getelementptr inbounds <4 x float> addrspace(1)* %445, i32 %444
  %447 = load <4 x float> addrspace(1)* %446, align 16
  %448 = insertelement <4 x float> %447, float %439, i32 3
  store <4 x float> %448, <4 x float> addrspace(1)* %446, align 16
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float, float, float, float, i32, i32, i32)* @toneMappingPattanaik1}
!1 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, float, float, float, float, i32, i32, i32)* @toneMappingPattanaik}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{float 2.500000e+00}

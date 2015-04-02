; ModuleID = '../kernel-src/MatrixMultiplication_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @mmmKernel(<4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)* %matrixC, i32 %widthA, i32 %widthB) #0 {
  %1 = alloca <4 x float> addrspace(1)*, align 4
  %2 = alloca <4 x float> addrspace(1)*, align 4
  %3 = alloca <4 x float> addrspace(1)*, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %pos = alloca <2 x i32>, align 8
  %6 = alloca <2 x i32>, align 8
  %sum0 = alloca <4 x float>, align 16
  %sum1 = alloca <4 x float>, align 16
  %sum2 = alloca <4 x float>, align 16
  %sum3 = alloca <4 x float>, align 16
  %i = alloca i32, align 4
  %tempA0 = alloca <4 x float>, align 16
  %tempA1 = alloca <4 x float>, align 16
  %tempA2 = alloca <4 x float>, align 16
  %tempA3 = alloca <4 x float>, align 16
  %tempB0 = alloca <4 x float>, align 16
  %tempB1 = alloca <4 x float>, align 16
  %tempB2 = alloca <4 x float>, align 16
  %tempB3 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)** %1, align 4
  store <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)** %2, align 4
  store <4 x float> addrspace(1)* %matrixC, <4 x float> addrspace(1)** %3, align 4
  store i32 %widthA, i32* %4, align 4
  store i32 %widthB, i32* %5, align 4
  %7 = call i32 @__get_global_id_u32(i32 0)
  %8 = insertelement <2 x i32> undef, i32 %7, i32 0
  %9 = call i32 @__get_global_id_u32(i32 1)
  %10 = insertelement <2 x i32> %8, i32 %9, i32 1
  store <2 x i32> %10, <2 x i32>* %6
  %11 = load <2 x i32>* %6
  store <2 x i32> %11, <2 x i32>* %pos, align 8
  store <4 x float> zeroinitializer, <4 x float>* %sum0, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum3, align 16
  %12 = load i32* %5, align 4
  %13 = udiv i32 %12, 4
  store i32 %13, i32* %5, align 4
  store i32 0, i32* %i, align 4
  br label %14

; <label>:14                                      ; preds = %509, %0
  %15 = load i32* %i, align 4
  %16 = load i32* %4, align 4
  %17 = icmp ult i32 %15, %16
  br i1 %17, label %18, label %512

; <label>:18                                      ; preds = %14
  %19 = load i32* %i, align 4
  %20 = sdiv i32 %19, 4
  %21 = load <2 x i32>* %pos, align 8
  %22 = extractelement <2 x i32> %21, i32 1
  %23 = shl i32 %22, 2
  %24 = load i32* %4, align 4
  %25 = udiv i32 %24, 4
  %26 = mul i32 %23, %25
  %27 = add i32 %20, %26
  %28 = load <4 x float> addrspace(1)** %1, align 4
  %29 = getelementptr inbounds <4 x float> addrspace(1)* %28, i32 %27
  %30 = load <4 x float> addrspace(1)* %29, align 16
  store <4 x float> %30, <4 x float>* %tempA0, align 16
  %31 = load i32* %i, align 4
  %32 = sdiv i32 %31, 4
  %33 = load <2 x i32>* %pos, align 8
  %34 = extractelement <2 x i32> %33, i32 1
  %35 = shl i32 %34, 2
  %36 = add nsw i32 %35, 1
  %37 = load i32* %4, align 4
  %38 = udiv i32 %37, 4
  %39 = mul i32 %36, %38
  %40 = add i32 %32, %39
  %41 = load <4 x float> addrspace(1)** %1, align 4
  %42 = getelementptr inbounds <4 x float> addrspace(1)* %41, i32 %40
  %43 = load <4 x float> addrspace(1)* %42, align 16
  store <4 x float> %43, <4 x float>* %tempA1, align 16
  %44 = load i32* %i, align 4
  %45 = sdiv i32 %44, 4
  %46 = load <2 x i32>* %pos, align 8
  %47 = extractelement <2 x i32> %46, i32 1
  %48 = shl i32 %47, 2
  %49 = add nsw i32 %48, 2
  %50 = load i32* %4, align 4
  %51 = udiv i32 %50, 4
  %52 = mul i32 %49, %51
  %53 = add i32 %45, %52
  %54 = load <4 x float> addrspace(1)** %1, align 4
  %55 = getelementptr inbounds <4 x float> addrspace(1)* %54, i32 %53
  %56 = load <4 x float> addrspace(1)* %55, align 16
  store <4 x float> %56, <4 x float>* %tempA2, align 16
  %57 = load i32* %i, align 4
  %58 = sdiv i32 %57, 4
  %59 = load <2 x i32>* %pos, align 8
  %60 = extractelement <2 x i32> %59, i32 1
  %61 = shl i32 %60, 2
  %62 = add nsw i32 %61, 3
  %63 = load i32* %4, align 4
  %64 = udiv i32 %63, 4
  %65 = mul i32 %62, %64
  %66 = add i32 %58, %65
  %67 = load <4 x float> addrspace(1)** %1, align 4
  %68 = getelementptr inbounds <4 x float> addrspace(1)* %67, i32 %66
  %69 = load <4 x float> addrspace(1)* %68, align 16
  store <4 x float> %69, <4 x float>* %tempA3, align 16
  %70 = load <2 x i32>* %pos, align 8
  %71 = extractelement <2 x i32> %70, i32 0
  %72 = load i32* %i, align 4
  %73 = load i32* %5, align 4
  %74 = mul i32 %72, %73
  %75 = add i32 %71, %74
  %76 = load <4 x float> addrspace(1)** %2, align 4
  %77 = getelementptr inbounds <4 x float> addrspace(1)* %76, i32 %75
  %78 = load <4 x float> addrspace(1)* %77, align 16
  store <4 x float> %78, <4 x float>* %tempB0, align 16
  %79 = load <2 x i32>* %pos, align 8
  %80 = extractelement <2 x i32> %79, i32 0
  %81 = load i32* %i, align 4
  %82 = add nsw i32 %81, 1
  %83 = load i32* %5, align 4
  %84 = mul i32 %82, %83
  %85 = add i32 %80, %84
  %86 = load <4 x float> addrspace(1)** %2, align 4
  %87 = getelementptr inbounds <4 x float> addrspace(1)* %86, i32 %85
  %88 = load <4 x float> addrspace(1)* %87, align 16
  store <4 x float> %88, <4 x float>* %tempB1, align 16
  %89 = load <2 x i32>* %pos, align 8
  %90 = extractelement <2 x i32> %89, i32 0
  %91 = load i32* %i, align 4
  %92 = add nsw i32 %91, 2
  %93 = load i32* %5, align 4
  %94 = mul i32 %92, %93
  %95 = add i32 %90, %94
  %96 = load <4 x float> addrspace(1)** %2, align 4
  %97 = getelementptr inbounds <4 x float> addrspace(1)* %96, i32 %95
  %98 = load <4 x float> addrspace(1)* %97, align 16
  store <4 x float> %98, <4 x float>* %tempB2, align 16
  %99 = load <2 x i32>* %pos, align 8
  %100 = extractelement <2 x i32> %99, i32 0
  %101 = load i32* %i, align 4
  %102 = add nsw i32 %101, 3
  %103 = load i32* %5, align 4
  %104 = mul i32 %102, %103
  %105 = add i32 %100, %104
  %106 = load <4 x float> addrspace(1)** %2, align 4
  %107 = getelementptr inbounds <4 x float> addrspace(1)* %106, i32 %105
  %108 = load <4 x float> addrspace(1)* %107, align 16
  store <4 x float> %108, <4 x float>* %tempB3, align 16
  %109 = load <4 x float>* %tempA0, align 16
  %110 = extractelement <4 x float> %109, i32 0
  %111 = load <4 x float>* %tempB0, align 16
  %112 = extractelement <4 x float> %111, i32 0
  %113 = load <4 x float>* %tempA0, align 16
  %114 = extractelement <4 x float> %113, i32 1
  %115 = load <4 x float>* %tempB1, align 16
  %116 = extractelement <4 x float> %115, i32 0
  %117 = fmul float %114, %116
  %118 = call float @llvm.fmuladd.f32(float %110, float %112, float %117)
  %119 = load <4 x float>* %tempA0, align 16
  %120 = extractelement <4 x float> %119, i32 2
  %121 = load <4 x float>* %tempB2, align 16
  %122 = extractelement <4 x float> %121, i32 0
  %123 = call float @llvm.fmuladd.f32(float %120, float %122, float %118)
  %124 = load <4 x float>* %tempA0, align 16
  %125 = extractelement <4 x float> %124, i32 3
  %126 = load <4 x float>* %tempB3, align 16
  %127 = extractelement <4 x float> %126, i32 0
  %128 = call float @llvm.fmuladd.f32(float %125, float %127, float %123)
  %129 = load <4 x float>* %sum0, align 16
  %130 = extractelement <4 x float> %129, i32 0
  %131 = fadd float %130, %128
  %132 = load <4 x float>* %sum0, align 16
  %133 = insertelement <4 x float> %132, float %131, i32 0
  store <4 x float> %133, <4 x float>* %sum0, align 16
  %134 = load <4 x float>* %tempA0, align 16
  %135 = extractelement <4 x float> %134, i32 0
  %136 = load <4 x float>* %tempB0, align 16
  %137 = extractelement <4 x float> %136, i32 1
  %138 = load <4 x float>* %tempA0, align 16
  %139 = extractelement <4 x float> %138, i32 1
  %140 = load <4 x float>* %tempB1, align 16
  %141 = extractelement <4 x float> %140, i32 1
  %142 = fmul float %139, %141
  %143 = call float @llvm.fmuladd.f32(float %135, float %137, float %142)
  %144 = load <4 x float>* %tempA0, align 16
  %145 = extractelement <4 x float> %144, i32 2
  %146 = load <4 x float>* %tempB2, align 16
  %147 = extractelement <4 x float> %146, i32 1
  %148 = call float @llvm.fmuladd.f32(float %145, float %147, float %143)
  %149 = load <4 x float>* %tempA0, align 16
  %150 = extractelement <4 x float> %149, i32 3
  %151 = load <4 x float>* %tempB3, align 16
  %152 = extractelement <4 x float> %151, i32 1
  %153 = call float @llvm.fmuladd.f32(float %150, float %152, float %148)
  %154 = load <4 x float>* %sum0, align 16
  %155 = extractelement <4 x float> %154, i32 1
  %156 = fadd float %155, %153
  %157 = load <4 x float>* %sum0, align 16
  %158 = insertelement <4 x float> %157, float %156, i32 1
  store <4 x float> %158, <4 x float>* %sum0, align 16
  %159 = load <4 x float>* %tempA0, align 16
  %160 = extractelement <4 x float> %159, i32 0
  %161 = load <4 x float>* %tempB0, align 16
  %162 = extractelement <4 x float> %161, i32 2
  %163 = load <4 x float>* %tempA0, align 16
  %164 = extractelement <4 x float> %163, i32 1
  %165 = load <4 x float>* %tempB1, align 16
  %166 = extractelement <4 x float> %165, i32 2
  %167 = fmul float %164, %166
  %168 = call float @llvm.fmuladd.f32(float %160, float %162, float %167)
  %169 = load <4 x float>* %tempA0, align 16
  %170 = extractelement <4 x float> %169, i32 2
  %171 = load <4 x float>* %tempB2, align 16
  %172 = extractelement <4 x float> %171, i32 2
  %173 = call float @llvm.fmuladd.f32(float %170, float %172, float %168)
  %174 = load <4 x float>* %tempA0, align 16
  %175 = extractelement <4 x float> %174, i32 3
  %176 = load <4 x float>* %tempB3, align 16
  %177 = extractelement <4 x float> %176, i32 2
  %178 = call float @llvm.fmuladd.f32(float %175, float %177, float %173)
  %179 = load <4 x float>* %sum0, align 16
  %180 = extractelement <4 x float> %179, i32 2
  %181 = fadd float %180, %178
  %182 = load <4 x float>* %sum0, align 16
  %183 = insertelement <4 x float> %182, float %181, i32 2
  store <4 x float> %183, <4 x float>* %sum0, align 16
  %184 = load <4 x float>* %tempA0, align 16
  %185 = extractelement <4 x float> %184, i32 0
  %186 = load <4 x float>* %tempB0, align 16
  %187 = extractelement <4 x float> %186, i32 3
  %188 = load <4 x float>* %tempA0, align 16
  %189 = extractelement <4 x float> %188, i32 1
  %190 = load <4 x float>* %tempB1, align 16
  %191 = extractelement <4 x float> %190, i32 3
  %192 = fmul float %189, %191
  %193 = call float @llvm.fmuladd.f32(float %185, float %187, float %192)
  %194 = load <4 x float>* %tempA0, align 16
  %195 = extractelement <4 x float> %194, i32 2
  %196 = load <4 x float>* %tempB2, align 16
  %197 = extractelement <4 x float> %196, i32 3
  %198 = call float @llvm.fmuladd.f32(float %195, float %197, float %193)
  %199 = load <4 x float>* %tempA0, align 16
  %200 = extractelement <4 x float> %199, i32 3
  %201 = load <4 x float>* %tempB3, align 16
  %202 = extractelement <4 x float> %201, i32 3
  %203 = call float @llvm.fmuladd.f32(float %200, float %202, float %198)
  %204 = load <4 x float>* %sum0, align 16
  %205 = extractelement <4 x float> %204, i32 3
  %206 = fadd float %205, %203
  %207 = load <4 x float>* %sum0, align 16
  %208 = insertelement <4 x float> %207, float %206, i32 3
  store <4 x float> %208, <4 x float>* %sum0, align 16
  %209 = load <4 x float>* %tempA1, align 16
  %210 = extractelement <4 x float> %209, i32 0
  %211 = load <4 x float>* %tempB0, align 16
  %212 = extractelement <4 x float> %211, i32 0
  %213 = load <4 x float>* %tempA1, align 16
  %214 = extractelement <4 x float> %213, i32 1
  %215 = load <4 x float>* %tempB1, align 16
  %216 = extractelement <4 x float> %215, i32 0
  %217 = fmul float %214, %216
  %218 = call float @llvm.fmuladd.f32(float %210, float %212, float %217)
  %219 = load <4 x float>* %tempA1, align 16
  %220 = extractelement <4 x float> %219, i32 2
  %221 = load <4 x float>* %tempB2, align 16
  %222 = extractelement <4 x float> %221, i32 0
  %223 = call float @llvm.fmuladd.f32(float %220, float %222, float %218)
  %224 = load <4 x float>* %tempA1, align 16
  %225 = extractelement <4 x float> %224, i32 3
  %226 = load <4 x float>* %tempB3, align 16
  %227 = extractelement <4 x float> %226, i32 0
  %228 = call float @llvm.fmuladd.f32(float %225, float %227, float %223)
  %229 = load <4 x float>* %sum1, align 16
  %230 = extractelement <4 x float> %229, i32 0
  %231 = fadd float %230, %228
  %232 = load <4 x float>* %sum1, align 16
  %233 = insertelement <4 x float> %232, float %231, i32 0
  store <4 x float> %233, <4 x float>* %sum1, align 16
  %234 = load <4 x float>* %tempA1, align 16
  %235 = extractelement <4 x float> %234, i32 0
  %236 = load <4 x float>* %tempB0, align 16
  %237 = extractelement <4 x float> %236, i32 1
  %238 = load <4 x float>* %tempA1, align 16
  %239 = extractelement <4 x float> %238, i32 1
  %240 = load <4 x float>* %tempB1, align 16
  %241 = extractelement <4 x float> %240, i32 1
  %242 = fmul float %239, %241
  %243 = call float @llvm.fmuladd.f32(float %235, float %237, float %242)
  %244 = load <4 x float>* %tempA1, align 16
  %245 = extractelement <4 x float> %244, i32 2
  %246 = load <4 x float>* %tempB2, align 16
  %247 = extractelement <4 x float> %246, i32 1
  %248 = call float @llvm.fmuladd.f32(float %245, float %247, float %243)
  %249 = load <4 x float>* %tempA1, align 16
  %250 = extractelement <4 x float> %249, i32 3
  %251 = load <4 x float>* %tempB3, align 16
  %252 = extractelement <4 x float> %251, i32 1
  %253 = call float @llvm.fmuladd.f32(float %250, float %252, float %248)
  %254 = load <4 x float>* %sum1, align 16
  %255 = extractelement <4 x float> %254, i32 1
  %256 = fadd float %255, %253
  %257 = load <4 x float>* %sum1, align 16
  %258 = insertelement <4 x float> %257, float %256, i32 1
  store <4 x float> %258, <4 x float>* %sum1, align 16
  %259 = load <4 x float>* %tempA1, align 16
  %260 = extractelement <4 x float> %259, i32 0
  %261 = load <4 x float>* %tempB0, align 16
  %262 = extractelement <4 x float> %261, i32 2
  %263 = load <4 x float>* %tempA1, align 16
  %264 = extractelement <4 x float> %263, i32 1
  %265 = load <4 x float>* %tempB1, align 16
  %266 = extractelement <4 x float> %265, i32 2
  %267 = fmul float %264, %266
  %268 = call float @llvm.fmuladd.f32(float %260, float %262, float %267)
  %269 = load <4 x float>* %tempA1, align 16
  %270 = extractelement <4 x float> %269, i32 2
  %271 = load <4 x float>* %tempB2, align 16
  %272 = extractelement <4 x float> %271, i32 2
  %273 = call float @llvm.fmuladd.f32(float %270, float %272, float %268)
  %274 = load <4 x float>* %tempA1, align 16
  %275 = extractelement <4 x float> %274, i32 3
  %276 = load <4 x float>* %tempB3, align 16
  %277 = extractelement <4 x float> %276, i32 2
  %278 = call float @llvm.fmuladd.f32(float %275, float %277, float %273)
  %279 = load <4 x float>* %sum1, align 16
  %280 = extractelement <4 x float> %279, i32 2
  %281 = fadd float %280, %278
  %282 = load <4 x float>* %sum1, align 16
  %283 = insertelement <4 x float> %282, float %281, i32 2
  store <4 x float> %283, <4 x float>* %sum1, align 16
  %284 = load <4 x float>* %tempA1, align 16
  %285 = extractelement <4 x float> %284, i32 0
  %286 = load <4 x float>* %tempB0, align 16
  %287 = extractelement <4 x float> %286, i32 3
  %288 = load <4 x float>* %tempA1, align 16
  %289 = extractelement <4 x float> %288, i32 1
  %290 = load <4 x float>* %tempB1, align 16
  %291 = extractelement <4 x float> %290, i32 3
  %292 = fmul float %289, %291
  %293 = call float @llvm.fmuladd.f32(float %285, float %287, float %292)
  %294 = load <4 x float>* %tempA1, align 16
  %295 = extractelement <4 x float> %294, i32 2
  %296 = load <4 x float>* %tempB2, align 16
  %297 = extractelement <4 x float> %296, i32 3
  %298 = call float @llvm.fmuladd.f32(float %295, float %297, float %293)
  %299 = load <4 x float>* %tempA1, align 16
  %300 = extractelement <4 x float> %299, i32 3
  %301 = load <4 x float>* %tempB3, align 16
  %302 = extractelement <4 x float> %301, i32 3
  %303 = call float @llvm.fmuladd.f32(float %300, float %302, float %298)
  %304 = load <4 x float>* %sum1, align 16
  %305 = extractelement <4 x float> %304, i32 3
  %306 = fadd float %305, %303
  %307 = load <4 x float>* %sum1, align 16
  %308 = insertelement <4 x float> %307, float %306, i32 3
  store <4 x float> %308, <4 x float>* %sum1, align 16
  %309 = load <4 x float>* %tempA2, align 16
  %310 = extractelement <4 x float> %309, i32 0
  %311 = load <4 x float>* %tempB0, align 16
  %312 = extractelement <4 x float> %311, i32 0
  %313 = load <4 x float>* %tempA2, align 16
  %314 = extractelement <4 x float> %313, i32 1
  %315 = load <4 x float>* %tempB1, align 16
  %316 = extractelement <4 x float> %315, i32 0
  %317 = fmul float %314, %316
  %318 = call float @llvm.fmuladd.f32(float %310, float %312, float %317)
  %319 = load <4 x float>* %tempA2, align 16
  %320 = extractelement <4 x float> %319, i32 2
  %321 = load <4 x float>* %tempB2, align 16
  %322 = extractelement <4 x float> %321, i32 0
  %323 = call float @llvm.fmuladd.f32(float %320, float %322, float %318)
  %324 = load <4 x float>* %tempA2, align 16
  %325 = extractelement <4 x float> %324, i32 3
  %326 = load <4 x float>* %tempB3, align 16
  %327 = extractelement <4 x float> %326, i32 0
  %328 = call float @llvm.fmuladd.f32(float %325, float %327, float %323)
  %329 = load <4 x float>* %sum2, align 16
  %330 = extractelement <4 x float> %329, i32 0
  %331 = fadd float %330, %328
  %332 = load <4 x float>* %sum2, align 16
  %333 = insertelement <4 x float> %332, float %331, i32 0
  store <4 x float> %333, <4 x float>* %sum2, align 16
  %334 = load <4 x float>* %tempA2, align 16
  %335 = extractelement <4 x float> %334, i32 0
  %336 = load <4 x float>* %tempB0, align 16
  %337 = extractelement <4 x float> %336, i32 1
  %338 = load <4 x float>* %tempA2, align 16
  %339 = extractelement <4 x float> %338, i32 1
  %340 = load <4 x float>* %tempB1, align 16
  %341 = extractelement <4 x float> %340, i32 1
  %342 = fmul float %339, %341
  %343 = call float @llvm.fmuladd.f32(float %335, float %337, float %342)
  %344 = load <4 x float>* %tempA2, align 16
  %345 = extractelement <4 x float> %344, i32 2
  %346 = load <4 x float>* %tempB2, align 16
  %347 = extractelement <4 x float> %346, i32 1
  %348 = call float @llvm.fmuladd.f32(float %345, float %347, float %343)
  %349 = load <4 x float>* %tempA2, align 16
  %350 = extractelement <4 x float> %349, i32 3
  %351 = load <4 x float>* %tempB3, align 16
  %352 = extractelement <4 x float> %351, i32 1
  %353 = call float @llvm.fmuladd.f32(float %350, float %352, float %348)
  %354 = load <4 x float>* %sum2, align 16
  %355 = extractelement <4 x float> %354, i32 1
  %356 = fadd float %355, %353
  %357 = load <4 x float>* %sum2, align 16
  %358 = insertelement <4 x float> %357, float %356, i32 1
  store <4 x float> %358, <4 x float>* %sum2, align 16
  %359 = load <4 x float>* %tempA2, align 16
  %360 = extractelement <4 x float> %359, i32 0
  %361 = load <4 x float>* %tempB0, align 16
  %362 = extractelement <4 x float> %361, i32 2
  %363 = load <4 x float>* %tempA2, align 16
  %364 = extractelement <4 x float> %363, i32 1
  %365 = load <4 x float>* %tempB1, align 16
  %366 = extractelement <4 x float> %365, i32 2
  %367 = fmul float %364, %366
  %368 = call float @llvm.fmuladd.f32(float %360, float %362, float %367)
  %369 = load <4 x float>* %tempA2, align 16
  %370 = extractelement <4 x float> %369, i32 2
  %371 = load <4 x float>* %tempB2, align 16
  %372 = extractelement <4 x float> %371, i32 2
  %373 = call float @llvm.fmuladd.f32(float %370, float %372, float %368)
  %374 = load <4 x float>* %tempA2, align 16
  %375 = extractelement <4 x float> %374, i32 3
  %376 = load <4 x float>* %tempB3, align 16
  %377 = extractelement <4 x float> %376, i32 2
  %378 = call float @llvm.fmuladd.f32(float %375, float %377, float %373)
  %379 = load <4 x float>* %sum2, align 16
  %380 = extractelement <4 x float> %379, i32 2
  %381 = fadd float %380, %378
  %382 = load <4 x float>* %sum2, align 16
  %383 = insertelement <4 x float> %382, float %381, i32 2
  store <4 x float> %383, <4 x float>* %sum2, align 16
  %384 = load <4 x float>* %tempA2, align 16
  %385 = extractelement <4 x float> %384, i32 0
  %386 = load <4 x float>* %tempB0, align 16
  %387 = extractelement <4 x float> %386, i32 3
  %388 = load <4 x float>* %tempA2, align 16
  %389 = extractelement <4 x float> %388, i32 1
  %390 = load <4 x float>* %tempB1, align 16
  %391 = extractelement <4 x float> %390, i32 3
  %392 = fmul float %389, %391
  %393 = call float @llvm.fmuladd.f32(float %385, float %387, float %392)
  %394 = load <4 x float>* %tempA2, align 16
  %395 = extractelement <4 x float> %394, i32 2
  %396 = load <4 x float>* %tempB2, align 16
  %397 = extractelement <4 x float> %396, i32 3
  %398 = call float @llvm.fmuladd.f32(float %395, float %397, float %393)
  %399 = load <4 x float>* %tempA2, align 16
  %400 = extractelement <4 x float> %399, i32 3
  %401 = load <4 x float>* %tempB3, align 16
  %402 = extractelement <4 x float> %401, i32 3
  %403 = call float @llvm.fmuladd.f32(float %400, float %402, float %398)
  %404 = load <4 x float>* %sum2, align 16
  %405 = extractelement <4 x float> %404, i32 3
  %406 = fadd float %405, %403
  %407 = load <4 x float>* %sum2, align 16
  %408 = insertelement <4 x float> %407, float %406, i32 3
  store <4 x float> %408, <4 x float>* %sum2, align 16
  %409 = load <4 x float>* %tempA3, align 16
  %410 = extractelement <4 x float> %409, i32 0
  %411 = load <4 x float>* %tempB0, align 16
  %412 = extractelement <4 x float> %411, i32 0
  %413 = load <4 x float>* %tempA3, align 16
  %414 = extractelement <4 x float> %413, i32 1
  %415 = load <4 x float>* %tempB1, align 16
  %416 = extractelement <4 x float> %415, i32 0
  %417 = fmul float %414, %416
  %418 = call float @llvm.fmuladd.f32(float %410, float %412, float %417)
  %419 = load <4 x float>* %tempA3, align 16
  %420 = extractelement <4 x float> %419, i32 2
  %421 = load <4 x float>* %tempB2, align 16
  %422 = extractelement <4 x float> %421, i32 0
  %423 = call float @llvm.fmuladd.f32(float %420, float %422, float %418)
  %424 = load <4 x float>* %tempA3, align 16
  %425 = extractelement <4 x float> %424, i32 3
  %426 = load <4 x float>* %tempB3, align 16
  %427 = extractelement <4 x float> %426, i32 0
  %428 = call float @llvm.fmuladd.f32(float %425, float %427, float %423)
  %429 = load <4 x float>* %sum3, align 16
  %430 = extractelement <4 x float> %429, i32 0
  %431 = fadd float %430, %428
  %432 = load <4 x float>* %sum3, align 16
  %433 = insertelement <4 x float> %432, float %431, i32 0
  store <4 x float> %433, <4 x float>* %sum3, align 16
  %434 = load <4 x float>* %tempA3, align 16
  %435 = extractelement <4 x float> %434, i32 0
  %436 = load <4 x float>* %tempB0, align 16
  %437 = extractelement <4 x float> %436, i32 1
  %438 = load <4 x float>* %tempA3, align 16
  %439 = extractelement <4 x float> %438, i32 1
  %440 = load <4 x float>* %tempB1, align 16
  %441 = extractelement <4 x float> %440, i32 1
  %442 = fmul float %439, %441
  %443 = call float @llvm.fmuladd.f32(float %435, float %437, float %442)
  %444 = load <4 x float>* %tempA3, align 16
  %445 = extractelement <4 x float> %444, i32 2
  %446 = load <4 x float>* %tempB2, align 16
  %447 = extractelement <4 x float> %446, i32 1
  %448 = call float @llvm.fmuladd.f32(float %445, float %447, float %443)
  %449 = load <4 x float>* %tempA3, align 16
  %450 = extractelement <4 x float> %449, i32 3
  %451 = load <4 x float>* %tempB3, align 16
  %452 = extractelement <4 x float> %451, i32 1
  %453 = call float @llvm.fmuladd.f32(float %450, float %452, float %448)
  %454 = load <4 x float>* %sum3, align 16
  %455 = extractelement <4 x float> %454, i32 1
  %456 = fadd float %455, %453
  %457 = load <4 x float>* %sum3, align 16
  %458 = insertelement <4 x float> %457, float %456, i32 1
  store <4 x float> %458, <4 x float>* %sum3, align 16
  %459 = load <4 x float>* %tempA3, align 16
  %460 = extractelement <4 x float> %459, i32 0
  %461 = load <4 x float>* %tempB0, align 16
  %462 = extractelement <4 x float> %461, i32 2
  %463 = load <4 x float>* %tempA3, align 16
  %464 = extractelement <4 x float> %463, i32 1
  %465 = load <4 x float>* %tempB1, align 16
  %466 = extractelement <4 x float> %465, i32 2
  %467 = fmul float %464, %466
  %468 = call float @llvm.fmuladd.f32(float %460, float %462, float %467)
  %469 = load <4 x float>* %tempA3, align 16
  %470 = extractelement <4 x float> %469, i32 2
  %471 = load <4 x float>* %tempB2, align 16
  %472 = extractelement <4 x float> %471, i32 2
  %473 = call float @llvm.fmuladd.f32(float %470, float %472, float %468)
  %474 = load <4 x float>* %tempA3, align 16
  %475 = extractelement <4 x float> %474, i32 3
  %476 = load <4 x float>* %tempB3, align 16
  %477 = extractelement <4 x float> %476, i32 2
  %478 = call float @llvm.fmuladd.f32(float %475, float %477, float %473)
  %479 = load <4 x float>* %sum3, align 16
  %480 = extractelement <4 x float> %479, i32 2
  %481 = fadd float %480, %478
  %482 = load <4 x float>* %sum3, align 16
  %483 = insertelement <4 x float> %482, float %481, i32 2
  store <4 x float> %483, <4 x float>* %sum3, align 16
  %484 = load <4 x float>* %tempA3, align 16
  %485 = extractelement <4 x float> %484, i32 0
  %486 = load <4 x float>* %tempB0, align 16
  %487 = extractelement <4 x float> %486, i32 3
  %488 = load <4 x float>* %tempA3, align 16
  %489 = extractelement <4 x float> %488, i32 1
  %490 = load <4 x float>* %tempB1, align 16
  %491 = extractelement <4 x float> %490, i32 3
  %492 = fmul float %489, %491
  %493 = call float @llvm.fmuladd.f32(float %485, float %487, float %492)
  %494 = load <4 x float>* %tempA3, align 16
  %495 = extractelement <4 x float> %494, i32 2
  %496 = load <4 x float>* %tempB2, align 16
  %497 = extractelement <4 x float> %496, i32 3
  %498 = call float @llvm.fmuladd.f32(float %495, float %497, float %493)
  %499 = load <4 x float>* %tempA3, align 16
  %500 = extractelement <4 x float> %499, i32 3
  %501 = load <4 x float>* %tempB3, align 16
  %502 = extractelement <4 x float> %501, i32 3
  %503 = call float @llvm.fmuladd.f32(float %500, float %502, float %498)
  %504 = load <4 x float>* %sum3, align 16
  %505 = extractelement <4 x float> %504, i32 3
  %506 = fadd float %505, %503
  %507 = load <4 x float>* %sum3, align 16
  %508 = insertelement <4 x float> %507, float %506, i32 3
  store <4 x float> %508, <4 x float>* %sum3, align 16
  br label %509

; <label>:509                                     ; preds = %18
  %510 = load i32* %i, align 4
  %511 = add nsw i32 %510, 4
  store i32 %511, i32* %i, align 4
  br label %14

; <label>:512                                     ; preds = %14
  %513 = load <4 x float>* %sum0, align 16
  %514 = load <2 x i32>* %pos, align 8
  %515 = extractelement <2 x i32> %514, i32 0
  %516 = load <2 x i32>* %pos, align 8
  %517 = extractelement <2 x i32> %516, i32 1
  %518 = shl i32 %517, 2
  %519 = add nsw i32 %518, 0
  %520 = load i32* %5, align 4
  %521 = mul i32 %519, %520
  %522 = add i32 %515, %521
  %523 = load <4 x float> addrspace(1)** %3, align 4
  %524 = getelementptr inbounds <4 x float> addrspace(1)* %523, i32 %522
  store <4 x float> %513, <4 x float> addrspace(1)* %524, align 16
  %525 = load <4 x float>* %sum1, align 16
  %526 = load <2 x i32>* %pos, align 8
  %527 = extractelement <2 x i32> %526, i32 0
  %528 = load <2 x i32>* %pos, align 8
  %529 = extractelement <2 x i32> %528, i32 1
  %530 = shl i32 %529, 2
  %531 = add nsw i32 %530, 1
  %532 = load i32* %5, align 4
  %533 = mul i32 %531, %532
  %534 = add i32 %527, %533
  %535 = load <4 x float> addrspace(1)** %3, align 4
  %536 = getelementptr inbounds <4 x float> addrspace(1)* %535, i32 %534
  store <4 x float> %525, <4 x float> addrspace(1)* %536, align 16
  %537 = load <4 x float>* %sum2, align 16
  %538 = load <2 x i32>* %pos, align 8
  %539 = extractelement <2 x i32> %538, i32 0
  %540 = load <2 x i32>* %pos, align 8
  %541 = extractelement <2 x i32> %540, i32 1
  %542 = shl i32 %541, 2
  %543 = add nsw i32 %542, 2
  %544 = load i32* %5, align 4
  %545 = mul i32 %543, %544
  %546 = add i32 %539, %545
  %547 = load <4 x float> addrspace(1)** %3, align 4
  %548 = getelementptr inbounds <4 x float> addrspace(1)* %547, i32 %546
  store <4 x float> %537, <4 x float> addrspace(1)* %548, align 16
  %549 = load <4 x float>* %sum3, align 16
  %550 = load <2 x i32>* %pos, align 8
  %551 = extractelement <2 x i32> %550, i32 0
  %552 = load <2 x i32>* %pos, align 8
  %553 = extractelement <2 x i32> %552, i32 1
  %554 = shl i32 %553, 2
  %555 = add nsw i32 %554, 3
  %556 = load i32* %5, align 4
  %557 = mul i32 %555, %556
  %558 = add i32 %551, %557
  %559 = load <4 x float> addrspace(1)** %3, align 4
  %560 = getelementptr inbounds <4 x float> addrspace(1)* %559, i32 %558
  store <4 x float> %549, <4 x float> addrspace(1)* %560, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind
define void @mmmKernel_local(<4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)* %matrixC, i32 %widthA, <4 x float> addrspace(3)* %blockA) #0 {
  %1 = alloca <4 x float> addrspace(1)*, align 4
  %2 = alloca <4 x float> addrspace(1)*, align 4
  %3 = alloca <4 x float> addrspace(1)*, align 4
  %4 = alloca i32, align 4
  %5 = alloca <4 x float> addrspace(3)*, align 4
  %blockPos = alloca i32, align 4
  %globalPos = alloca i32, align 4
  %sum0 = alloca <4 x float>, align 16
  %sum1 = alloca <4 x float>, align 16
  %sum2 = alloca <4 x float>, align 16
  %sum3 = alloca <4 x float>, align 16
  %temp = alloca i32, align 4
  %i = alloca i32, align 4
  %globalPosA = alloca i32, align 4
  %globalPosB = alloca i32, align 4
  %j = alloca i32, align 4
  %tempA0 = alloca <4 x float>, align 16
  %tempA1 = alloca <4 x float>, align 16
  %tempA2 = alloca <4 x float>, align 16
  %tempA3 = alloca <4 x float>, align 16
  %tempB0 = alloca <4 x float>, align 16
  %tempB1 = alloca <4 x float>, align 16
  %tempB2 = alloca <4 x float>, align 16
  %tempB3 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)** %1, align 4
  store <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)** %2, align 4
  store <4 x float> addrspace(1)* %matrixC, <4 x float> addrspace(1)** %3, align 4
  store i32 %widthA, i32* %4, align 4
  store <4 x float> addrspace(3)* %blockA, <4 x float> addrspace(3)** %5, align 4
  %6 = call i32 @__get_local_id_u32(i32 0)
  %7 = call i32 @__get_local_size_u32(i32 0)
  %8 = call i32 @__get_local_id_u32(i32 1)
  %9 = shl i32 %8, 2
  %10 = mul i32 %7, %9
  %11 = add i32 %6, %10
  store i32 %11, i32* %blockPos, align 4
  %12 = call i32 @__get_global_id_u32(i32 0)
  %13 = call i32 @__get_global_id_u32(i32 1)
  %14 = shl i32 %13, 2
  %15 = call i32 @__get_global_size_u32(i32 0)
  %16 = mul i32 %14, %15
  %17 = add i32 %12, %16
  store i32 %17, i32* %globalPos, align 4
  store <4 x float> zeroinitializer, <4 x float>* %sum0, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum3, align 16
  %18 = load i32* %4, align 4
  %19 = sdiv i32 %18, 4
  store i32 %19, i32* %temp, align 4
  store i32 0, i32* %i, align 4
  br label %20

; <label>:20                                      ; preds = %577, %0
  %21 = load i32* %i, align 4
  %22 = load i32* %temp, align 4
  %23 = call i32 @__get_local_size_u32(i32 0)
  %24 = udiv i32 %22, %23
  %25 = icmp ult i32 %21, %24
  br i1 %25, label %26, label %580

; <label>:26                                      ; preds = %20
  %27 = load i32* %i, align 4
  %28 = call i32 @__get_local_size_u32(i32 0)
  %29 = mul i32 %27, %28
  %30 = call i32 @__get_local_id_u32(i32 0)
  %31 = add i32 %29, %30
  %32 = call i32 @__get_global_id_u32(i32 1)
  %33 = shl i32 %32, 2
  %34 = load i32* %temp, align 4
  %35 = mul i32 %33, %34
  %36 = add i32 %31, %35
  store i32 %36, i32* %globalPosA, align 4
  %37 = load i32* %globalPosA, align 4
  %38 = load <4 x float> addrspace(1)** %1, align 4
  %39 = getelementptr inbounds <4 x float> addrspace(1)* %38, i32 %37
  %40 = load <4 x float> addrspace(1)* %39, align 16
  %41 = load i32* %blockPos, align 4
  %42 = load <4 x float> addrspace(3)** %5, align 4
  %43 = getelementptr inbounds <4 x float> addrspace(3)* %42, i32 %41
  store <4 x float> %40, <4 x float> addrspace(3)* %43, align 16
  %44 = load i32* %globalPosA, align 4
  %45 = load i32* %temp, align 4
  %46 = add nsw i32 %44, %45
  %47 = load <4 x float> addrspace(1)** %1, align 4
  %48 = getelementptr inbounds <4 x float> addrspace(1)* %47, i32 %46
  %49 = load <4 x float> addrspace(1)* %48, align 16
  %50 = load i32* %blockPos, align 4
  %51 = call i32 @__get_local_size_u32(i32 0)
  %52 = add i32 %50, %51
  %53 = load <4 x float> addrspace(3)** %5, align 4
  %54 = getelementptr inbounds <4 x float> addrspace(3)* %53, i32 %52
  store <4 x float> %49, <4 x float> addrspace(3)* %54, align 16
  %55 = load i32* %globalPosA, align 4
  %56 = load i32* %temp, align 4
  %57 = mul nsw i32 2, %56
  %58 = add nsw i32 %55, %57
  %59 = load <4 x float> addrspace(1)** %1, align 4
  %60 = getelementptr inbounds <4 x float> addrspace(1)* %59, i32 %58
  %61 = load <4 x float> addrspace(1)* %60, align 16
  %62 = load i32* %blockPos, align 4
  %63 = call i32 @__get_local_size_u32(i32 0)
  %64 = mul i32 2, %63
  %65 = add i32 %62, %64
  %66 = load <4 x float> addrspace(3)** %5, align 4
  %67 = getelementptr inbounds <4 x float> addrspace(3)* %66, i32 %65
  store <4 x float> %61, <4 x float> addrspace(3)* %67, align 16
  %68 = load i32* %globalPosA, align 4
  %69 = load i32* %temp, align 4
  %70 = mul nsw i32 3, %69
  %71 = add nsw i32 %68, %70
  %72 = load <4 x float> addrspace(1)** %1, align 4
  %73 = getelementptr inbounds <4 x float> addrspace(1)* %72, i32 %71
  %74 = load <4 x float> addrspace(1)* %73, align 16
  %75 = load i32* %blockPos, align 4
  %76 = call i32 @__get_local_size_u32(i32 0)
  %77 = mul i32 3, %76
  %78 = add i32 %75, %77
  %79 = load <4 x float> addrspace(3)** %5, align 4
  %80 = getelementptr inbounds <4 x float> addrspace(3)* %79, i32 %78
  store <4 x float> %74, <4 x float> addrspace(3)* %80, align 16
  call void @barrier(i32 1)
  %81 = call i32 @__get_global_id_u32(i32 0)
  %82 = load i32* %i, align 4
  %83 = call i32 @__get_local_size_u32(i32 0)
  %84 = mul i32 %82, %83
  %85 = shl i32 %84, 2
  %86 = call i32 @__get_global_size_u32(i32 0)
  %87 = mul i32 %85, %86
  %88 = add i32 %81, %87
  store i32 %88, i32* %globalPosB, align 4
  store i32 0, i32* %j, align 4
  br label %89

; <label>:89                                      ; preds = %573, %26
  %90 = load i32* %j, align 4
  %91 = call i32 @__get_local_size_u32(i32 0)
  %92 = mul i32 %91, 4
  %93 = icmp ult i32 %90, %92
  br i1 %93, label %94, label %576

; <label>:94                                      ; preds = %89
  %95 = load i32* %j, align 4
  %96 = ashr i32 %95, 2
  %97 = call i32 @__get_local_id_u32(i32 1)
  %98 = mul i32 %97, 4
  %99 = call i32 @__get_local_size_u32(i32 0)
  %100 = mul i32 %98, %99
  %101 = add i32 %96, %100
  %102 = load <4 x float> addrspace(3)** %5, align 4
  %103 = getelementptr inbounds <4 x float> addrspace(3)* %102, i32 %101
  %104 = load <4 x float> addrspace(3)* %103, align 16
  store <4 x float> %104, <4 x float>* %tempA0, align 16
  %105 = load i32* %j, align 4
  %106 = ashr i32 %105, 2
  %107 = call i32 @__get_local_id_u32(i32 1)
  %108 = mul i32 %107, 4
  %109 = add i32 %108, 1
  %110 = call i32 @__get_local_size_u32(i32 0)
  %111 = mul i32 %109, %110
  %112 = add i32 %106, %111
  %113 = load <4 x float> addrspace(3)** %5, align 4
  %114 = getelementptr inbounds <4 x float> addrspace(3)* %113, i32 %112
  %115 = load <4 x float> addrspace(3)* %114, align 16
  store <4 x float> %115, <4 x float>* %tempA1, align 16
  %116 = load i32* %j, align 4
  %117 = ashr i32 %116, 2
  %118 = call i32 @__get_local_id_u32(i32 1)
  %119 = mul i32 %118, 4
  %120 = add i32 %119, 2
  %121 = call i32 @__get_local_size_u32(i32 0)
  %122 = mul i32 %120, %121
  %123 = add i32 %117, %122
  %124 = load <4 x float> addrspace(3)** %5, align 4
  %125 = getelementptr inbounds <4 x float> addrspace(3)* %124, i32 %123
  %126 = load <4 x float> addrspace(3)* %125, align 16
  store <4 x float> %126, <4 x float>* %tempA2, align 16
  %127 = load i32* %j, align 4
  %128 = ashr i32 %127, 2
  %129 = call i32 @__get_local_id_u32(i32 1)
  %130 = mul i32 %129, 4
  %131 = add i32 %130, 3
  %132 = call i32 @__get_local_size_u32(i32 0)
  %133 = mul i32 %131, %132
  %134 = add i32 %128, %133
  %135 = load <4 x float> addrspace(3)** %5, align 4
  %136 = getelementptr inbounds <4 x float> addrspace(3)* %135, i32 %134
  %137 = load <4 x float> addrspace(3)* %136, align 16
  store <4 x float> %137, <4 x float>* %tempA3, align 16
  %138 = load i32* %globalPosB, align 4
  %139 = load i32* %j, align 4
  %140 = call i32 @__get_global_size_u32(i32 0)
  %141 = mul i32 %139, %140
  %142 = add i32 %138, %141
  %143 = load <4 x float> addrspace(1)** %2, align 4
  %144 = getelementptr inbounds <4 x float> addrspace(1)* %143, i32 %142
  %145 = load <4 x float> addrspace(1)* %144, align 16
  store <4 x float> %145, <4 x float>* %tempB0, align 16
  %146 = load i32* %globalPosB, align 4
  %147 = load i32* %j, align 4
  %148 = add nsw i32 %147, 1
  %149 = call i32 @__get_global_size_u32(i32 0)
  %150 = mul i32 %148, %149
  %151 = add i32 %146, %150
  %152 = load <4 x float> addrspace(1)** %2, align 4
  %153 = getelementptr inbounds <4 x float> addrspace(1)* %152, i32 %151
  %154 = load <4 x float> addrspace(1)* %153, align 16
  store <4 x float> %154, <4 x float>* %tempB1, align 16
  %155 = load i32* %globalPosB, align 4
  %156 = load i32* %j, align 4
  %157 = add nsw i32 %156, 2
  %158 = call i32 @__get_global_size_u32(i32 0)
  %159 = mul i32 %157, %158
  %160 = add i32 %155, %159
  %161 = load <4 x float> addrspace(1)** %2, align 4
  %162 = getelementptr inbounds <4 x float> addrspace(1)* %161, i32 %160
  %163 = load <4 x float> addrspace(1)* %162, align 16
  store <4 x float> %163, <4 x float>* %tempB2, align 16
  %164 = load i32* %globalPosB, align 4
  %165 = load i32* %j, align 4
  %166 = add nsw i32 %165, 3
  %167 = call i32 @__get_global_size_u32(i32 0)
  %168 = mul i32 %166, %167
  %169 = add i32 %164, %168
  %170 = load <4 x float> addrspace(1)** %2, align 4
  %171 = getelementptr inbounds <4 x float> addrspace(1)* %170, i32 %169
  %172 = load <4 x float> addrspace(1)* %171, align 16
  store <4 x float> %172, <4 x float>* %tempB3, align 16
  %173 = load <4 x float>* %tempA0, align 16
  %174 = extractelement <4 x float> %173, i32 0
  %175 = load <4 x float>* %tempB0, align 16
  %176 = extractelement <4 x float> %175, i32 0
  %177 = load <4 x float>* %tempA0, align 16
  %178 = extractelement <4 x float> %177, i32 1
  %179 = load <4 x float>* %tempB1, align 16
  %180 = extractelement <4 x float> %179, i32 0
  %181 = fmul float %178, %180
  %182 = call float @llvm.fmuladd.f32(float %174, float %176, float %181)
  %183 = load <4 x float>* %tempA0, align 16
  %184 = extractelement <4 x float> %183, i32 2
  %185 = load <4 x float>* %tempB2, align 16
  %186 = extractelement <4 x float> %185, i32 0
  %187 = call float @llvm.fmuladd.f32(float %184, float %186, float %182)
  %188 = load <4 x float>* %tempA0, align 16
  %189 = extractelement <4 x float> %188, i32 3
  %190 = load <4 x float>* %tempB3, align 16
  %191 = extractelement <4 x float> %190, i32 0
  %192 = call float @llvm.fmuladd.f32(float %189, float %191, float %187)
  %193 = load <4 x float>* %sum0, align 16
  %194 = extractelement <4 x float> %193, i32 0
  %195 = fadd float %194, %192
  %196 = load <4 x float>* %sum0, align 16
  %197 = insertelement <4 x float> %196, float %195, i32 0
  store <4 x float> %197, <4 x float>* %sum0, align 16
  %198 = load <4 x float>* %tempA0, align 16
  %199 = extractelement <4 x float> %198, i32 0
  %200 = load <4 x float>* %tempB0, align 16
  %201 = extractelement <4 x float> %200, i32 1
  %202 = load <4 x float>* %tempA0, align 16
  %203 = extractelement <4 x float> %202, i32 1
  %204 = load <4 x float>* %tempB1, align 16
  %205 = extractelement <4 x float> %204, i32 1
  %206 = fmul float %203, %205
  %207 = call float @llvm.fmuladd.f32(float %199, float %201, float %206)
  %208 = load <4 x float>* %tempA0, align 16
  %209 = extractelement <4 x float> %208, i32 2
  %210 = load <4 x float>* %tempB2, align 16
  %211 = extractelement <4 x float> %210, i32 1
  %212 = call float @llvm.fmuladd.f32(float %209, float %211, float %207)
  %213 = load <4 x float>* %tempA0, align 16
  %214 = extractelement <4 x float> %213, i32 3
  %215 = load <4 x float>* %tempB3, align 16
  %216 = extractelement <4 x float> %215, i32 1
  %217 = call float @llvm.fmuladd.f32(float %214, float %216, float %212)
  %218 = load <4 x float>* %sum0, align 16
  %219 = extractelement <4 x float> %218, i32 1
  %220 = fadd float %219, %217
  %221 = load <4 x float>* %sum0, align 16
  %222 = insertelement <4 x float> %221, float %220, i32 1
  store <4 x float> %222, <4 x float>* %sum0, align 16
  %223 = load <4 x float>* %tempA0, align 16
  %224 = extractelement <4 x float> %223, i32 0
  %225 = load <4 x float>* %tempB0, align 16
  %226 = extractelement <4 x float> %225, i32 2
  %227 = load <4 x float>* %tempA0, align 16
  %228 = extractelement <4 x float> %227, i32 1
  %229 = load <4 x float>* %tempB1, align 16
  %230 = extractelement <4 x float> %229, i32 2
  %231 = fmul float %228, %230
  %232 = call float @llvm.fmuladd.f32(float %224, float %226, float %231)
  %233 = load <4 x float>* %tempA0, align 16
  %234 = extractelement <4 x float> %233, i32 2
  %235 = load <4 x float>* %tempB2, align 16
  %236 = extractelement <4 x float> %235, i32 2
  %237 = call float @llvm.fmuladd.f32(float %234, float %236, float %232)
  %238 = load <4 x float>* %tempA0, align 16
  %239 = extractelement <4 x float> %238, i32 3
  %240 = load <4 x float>* %tempB3, align 16
  %241 = extractelement <4 x float> %240, i32 2
  %242 = call float @llvm.fmuladd.f32(float %239, float %241, float %237)
  %243 = load <4 x float>* %sum0, align 16
  %244 = extractelement <4 x float> %243, i32 2
  %245 = fadd float %244, %242
  %246 = load <4 x float>* %sum0, align 16
  %247 = insertelement <4 x float> %246, float %245, i32 2
  store <4 x float> %247, <4 x float>* %sum0, align 16
  %248 = load <4 x float>* %tempA0, align 16
  %249 = extractelement <4 x float> %248, i32 0
  %250 = load <4 x float>* %tempB0, align 16
  %251 = extractelement <4 x float> %250, i32 3
  %252 = load <4 x float>* %tempA0, align 16
  %253 = extractelement <4 x float> %252, i32 1
  %254 = load <4 x float>* %tempB1, align 16
  %255 = extractelement <4 x float> %254, i32 3
  %256 = fmul float %253, %255
  %257 = call float @llvm.fmuladd.f32(float %249, float %251, float %256)
  %258 = load <4 x float>* %tempA0, align 16
  %259 = extractelement <4 x float> %258, i32 2
  %260 = load <4 x float>* %tempB2, align 16
  %261 = extractelement <4 x float> %260, i32 3
  %262 = call float @llvm.fmuladd.f32(float %259, float %261, float %257)
  %263 = load <4 x float>* %tempA0, align 16
  %264 = extractelement <4 x float> %263, i32 3
  %265 = load <4 x float>* %tempB3, align 16
  %266 = extractelement <4 x float> %265, i32 3
  %267 = call float @llvm.fmuladd.f32(float %264, float %266, float %262)
  %268 = load <4 x float>* %sum0, align 16
  %269 = extractelement <4 x float> %268, i32 3
  %270 = fadd float %269, %267
  %271 = load <4 x float>* %sum0, align 16
  %272 = insertelement <4 x float> %271, float %270, i32 3
  store <4 x float> %272, <4 x float>* %sum0, align 16
  %273 = load <4 x float>* %tempA1, align 16
  %274 = extractelement <4 x float> %273, i32 0
  %275 = load <4 x float>* %tempB0, align 16
  %276 = extractelement <4 x float> %275, i32 0
  %277 = load <4 x float>* %tempA1, align 16
  %278 = extractelement <4 x float> %277, i32 1
  %279 = load <4 x float>* %tempB1, align 16
  %280 = extractelement <4 x float> %279, i32 0
  %281 = fmul float %278, %280
  %282 = call float @llvm.fmuladd.f32(float %274, float %276, float %281)
  %283 = load <4 x float>* %tempA1, align 16
  %284 = extractelement <4 x float> %283, i32 2
  %285 = load <4 x float>* %tempB2, align 16
  %286 = extractelement <4 x float> %285, i32 0
  %287 = call float @llvm.fmuladd.f32(float %284, float %286, float %282)
  %288 = load <4 x float>* %tempA1, align 16
  %289 = extractelement <4 x float> %288, i32 3
  %290 = load <4 x float>* %tempB3, align 16
  %291 = extractelement <4 x float> %290, i32 0
  %292 = call float @llvm.fmuladd.f32(float %289, float %291, float %287)
  %293 = load <4 x float>* %sum1, align 16
  %294 = extractelement <4 x float> %293, i32 0
  %295 = fadd float %294, %292
  %296 = load <4 x float>* %sum1, align 16
  %297 = insertelement <4 x float> %296, float %295, i32 0
  store <4 x float> %297, <4 x float>* %sum1, align 16
  %298 = load <4 x float>* %tempA1, align 16
  %299 = extractelement <4 x float> %298, i32 0
  %300 = load <4 x float>* %tempB0, align 16
  %301 = extractelement <4 x float> %300, i32 1
  %302 = load <4 x float>* %tempA1, align 16
  %303 = extractelement <4 x float> %302, i32 1
  %304 = load <4 x float>* %tempB1, align 16
  %305 = extractelement <4 x float> %304, i32 1
  %306 = fmul float %303, %305
  %307 = call float @llvm.fmuladd.f32(float %299, float %301, float %306)
  %308 = load <4 x float>* %tempA1, align 16
  %309 = extractelement <4 x float> %308, i32 2
  %310 = load <4 x float>* %tempB2, align 16
  %311 = extractelement <4 x float> %310, i32 1
  %312 = call float @llvm.fmuladd.f32(float %309, float %311, float %307)
  %313 = load <4 x float>* %tempA1, align 16
  %314 = extractelement <4 x float> %313, i32 3
  %315 = load <4 x float>* %tempB3, align 16
  %316 = extractelement <4 x float> %315, i32 1
  %317 = call float @llvm.fmuladd.f32(float %314, float %316, float %312)
  %318 = load <4 x float>* %sum1, align 16
  %319 = extractelement <4 x float> %318, i32 1
  %320 = fadd float %319, %317
  %321 = load <4 x float>* %sum1, align 16
  %322 = insertelement <4 x float> %321, float %320, i32 1
  store <4 x float> %322, <4 x float>* %sum1, align 16
  %323 = load <4 x float>* %tempA1, align 16
  %324 = extractelement <4 x float> %323, i32 0
  %325 = load <4 x float>* %tempB0, align 16
  %326 = extractelement <4 x float> %325, i32 2
  %327 = load <4 x float>* %tempA1, align 16
  %328 = extractelement <4 x float> %327, i32 1
  %329 = load <4 x float>* %tempB1, align 16
  %330 = extractelement <4 x float> %329, i32 2
  %331 = fmul float %328, %330
  %332 = call float @llvm.fmuladd.f32(float %324, float %326, float %331)
  %333 = load <4 x float>* %tempA1, align 16
  %334 = extractelement <4 x float> %333, i32 2
  %335 = load <4 x float>* %tempB2, align 16
  %336 = extractelement <4 x float> %335, i32 2
  %337 = call float @llvm.fmuladd.f32(float %334, float %336, float %332)
  %338 = load <4 x float>* %tempA1, align 16
  %339 = extractelement <4 x float> %338, i32 3
  %340 = load <4 x float>* %tempB3, align 16
  %341 = extractelement <4 x float> %340, i32 2
  %342 = call float @llvm.fmuladd.f32(float %339, float %341, float %337)
  %343 = load <4 x float>* %sum1, align 16
  %344 = extractelement <4 x float> %343, i32 2
  %345 = fadd float %344, %342
  %346 = load <4 x float>* %sum1, align 16
  %347 = insertelement <4 x float> %346, float %345, i32 2
  store <4 x float> %347, <4 x float>* %sum1, align 16
  %348 = load <4 x float>* %tempA1, align 16
  %349 = extractelement <4 x float> %348, i32 0
  %350 = load <4 x float>* %tempB0, align 16
  %351 = extractelement <4 x float> %350, i32 3
  %352 = load <4 x float>* %tempA1, align 16
  %353 = extractelement <4 x float> %352, i32 1
  %354 = load <4 x float>* %tempB1, align 16
  %355 = extractelement <4 x float> %354, i32 3
  %356 = fmul float %353, %355
  %357 = call float @llvm.fmuladd.f32(float %349, float %351, float %356)
  %358 = load <4 x float>* %tempA1, align 16
  %359 = extractelement <4 x float> %358, i32 2
  %360 = load <4 x float>* %tempB2, align 16
  %361 = extractelement <4 x float> %360, i32 3
  %362 = call float @llvm.fmuladd.f32(float %359, float %361, float %357)
  %363 = load <4 x float>* %tempA1, align 16
  %364 = extractelement <4 x float> %363, i32 3
  %365 = load <4 x float>* %tempB3, align 16
  %366 = extractelement <4 x float> %365, i32 3
  %367 = call float @llvm.fmuladd.f32(float %364, float %366, float %362)
  %368 = load <4 x float>* %sum1, align 16
  %369 = extractelement <4 x float> %368, i32 3
  %370 = fadd float %369, %367
  %371 = load <4 x float>* %sum1, align 16
  %372 = insertelement <4 x float> %371, float %370, i32 3
  store <4 x float> %372, <4 x float>* %sum1, align 16
  %373 = load <4 x float>* %tempA2, align 16
  %374 = extractelement <4 x float> %373, i32 0
  %375 = load <4 x float>* %tempB0, align 16
  %376 = extractelement <4 x float> %375, i32 0
  %377 = load <4 x float>* %tempA2, align 16
  %378 = extractelement <4 x float> %377, i32 1
  %379 = load <4 x float>* %tempB1, align 16
  %380 = extractelement <4 x float> %379, i32 0
  %381 = fmul float %378, %380
  %382 = call float @llvm.fmuladd.f32(float %374, float %376, float %381)
  %383 = load <4 x float>* %tempA2, align 16
  %384 = extractelement <4 x float> %383, i32 2
  %385 = load <4 x float>* %tempB2, align 16
  %386 = extractelement <4 x float> %385, i32 0
  %387 = call float @llvm.fmuladd.f32(float %384, float %386, float %382)
  %388 = load <4 x float>* %tempA2, align 16
  %389 = extractelement <4 x float> %388, i32 3
  %390 = load <4 x float>* %tempB3, align 16
  %391 = extractelement <4 x float> %390, i32 0
  %392 = call float @llvm.fmuladd.f32(float %389, float %391, float %387)
  %393 = load <4 x float>* %sum2, align 16
  %394 = extractelement <4 x float> %393, i32 0
  %395 = fadd float %394, %392
  %396 = load <4 x float>* %sum2, align 16
  %397 = insertelement <4 x float> %396, float %395, i32 0
  store <4 x float> %397, <4 x float>* %sum2, align 16
  %398 = load <4 x float>* %tempA2, align 16
  %399 = extractelement <4 x float> %398, i32 0
  %400 = load <4 x float>* %tempB0, align 16
  %401 = extractelement <4 x float> %400, i32 1
  %402 = load <4 x float>* %tempA2, align 16
  %403 = extractelement <4 x float> %402, i32 1
  %404 = load <4 x float>* %tempB1, align 16
  %405 = extractelement <4 x float> %404, i32 1
  %406 = fmul float %403, %405
  %407 = call float @llvm.fmuladd.f32(float %399, float %401, float %406)
  %408 = load <4 x float>* %tempA2, align 16
  %409 = extractelement <4 x float> %408, i32 2
  %410 = load <4 x float>* %tempB2, align 16
  %411 = extractelement <4 x float> %410, i32 1
  %412 = call float @llvm.fmuladd.f32(float %409, float %411, float %407)
  %413 = load <4 x float>* %tempA2, align 16
  %414 = extractelement <4 x float> %413, i32 3
  %415 = load <4 x float>* %tempB3, align 16
  %416 = extractelement <4 x float> %415, i32 1
  %417 = call float @llvm.fmuladd.f32(float %414, float %416, float %412)
  %418 = load <4 x float>* %sum2, align 16
  %419 = extractelement <4 x float> %418, i32 1
  %420 = fadd float %419, %417
  %421 = load <4 x float>* %sum2, align 16
  %422 = insertelement <4 x float> %421, float %420, i32 1
  store <4 x float> %422, <4 x float>* %sum2, align 16
  %423 = load <4 x float>* %tempA2, align 16
  %424 = extractelement <4 x float> %423, i32 0
  %425 = load <4 x float>* %tempB0, align 16
  %426 = extractelement <4 x float> %425, i32 2
  %427 = load <4 x float>* %tempA2, align 16
  %428 = extractelement <4 x float> %427, i32 1
  %429 = load <4 x float>* %tempB1, align 16
  %430 = extractelement <4 x float> %429, i32 2
  %431 = fmul float %428, %430
  %432 = call float @llvm.fmuladd.f32(float %424, float %426, float %431)
  %433 = load <4 x float>* %tempA2, align 16
  %434 = extractelement <4 x float> %433, i32 2
  %435 = load <4 x float>* %tempB2, align 16
  %436 = extractelement <4 x float> %435, i32 2
  %437 = call float @llvm.fmuladd.f32(float %434, float %436, float %432)
  %438 = load <4 x float>* %tempA2, align 16
  %439 = extractelement <4 x float> %438, i32 3
  %440 = load <4 x float>* %tempB3, align 16
  %441 = extractelement <4 x float> %440, i32 2
  %442 = call float @llvm.fmuladd.f32(float %439, float %441, float %437)
  %443 = load <4 x float>* %sum2, align 16
  %444 = extractelement <4 x float> %443, i32 2
  %445 = fadd float %444, %442
  %446 = load <4 x float>* %sum2, align 16
  %447 = insertelement <4 x float> %446, float %445, i32 2
  store <4 x float> %447, <4 x float>* %sum2, align 16
  %448 = load <4 x float>* %tempA2, align 16
  %449 = extractelement <4 x float> %448, i32 0
  %450 = load <4 x float>* %tempB0, align 16
  %451 = extractelement <4 x float> %450, i32 3
  %452 = load <4 x float>* %tempA2, align 16
  %453 = extractelement <4 x float> %452, i32 1
  %454 = load <4 x float>* %tempB1, align 16
  %455 = extractelement <4 x float> %454, i32 3
  %456 = fmul float %453, %455
  %457 = call float @llvm.fmuladd.f32(float %449, float %451, float %456)
  %458 = load <4 x float>* %tempA2, align 16
  %459 = extractelement <4 x float> %458, i32 2
  %460 = load <4 x float>* %tempB2, align 16
  %461 = extractelement <4 x float> %460, i32 3
  %462 = call float @llvm.fmuladd.f32(float %459, float %461, float %457)
  %463 = load <4 x float>* %tempA2, align 16
  %464 = extractelement <4 x float> %463, i32 3
  %465 = load <4 x float>* %tempB3, align 16
  %466 = extractelement <4 x float> %465, i32 3
  %467 = call float @llvm.fmuladd.f32(float %464, float %466, float %462)
  %468 = load <4 x float>* %sum2, align 16
  %469 = extractelement <4 x float> %468, i32 3
  %470 = fadd float %469, %467
  %471 = load <4 x float>* %sum2, align 16
  %472 = insertelement <4 x float> %471, float %470, i32 3
  store <4 x float> %472, <4 x float>* %sum2, align 16
  %473 = load <4 x float>* %tempA3, align 16
  %474 = extractelement <4 x float> %473, i32 0
  %475 = load <4 x float>* %tempB0, align 16
  %476 = extractelement <4 x float> %475, i32 0
  %477 = load <4 x float>* %tempA3, align 16
  %478 = extractelement <4 x float> %477, i32 1
  %479 = load <4 x float>* %tempB1, align 16
  %480 = extractelement <4 x float> %479, i32 0
  %481 = fmul float %478, %480
  %482 = call float @llvm.fmuladd.f32(float %474, float %476, float %481)
  %483 = load <4 x float>* %tempA3, align 16
  %484 = extractelement <4 x float> %483, i32 2
  %485 = load <4 x float>* %tempB2, align 16
  %486 = extractelement <4 x float> %485, i32 0
  %487 = call float @llvm.fmuladd.f32(float %484, float %486, float %482)
  %488 = load <4 x float>* %tempA3, align 16
  %489 = extractelement <4 x float> %488, i32 3
  %490 = load <4 x float>* %tempB3, align 16
  %491 = extractelement <4 x float> %490, i32 0
  %492 = call float @llvm.fmuladd.f32(float %489, float %491, float %487)
  %493 = load <4 x float>* %sum3, align 16
  %494 = extractelement <4 x float> %493, i32 0
  %495 = fadd float %494, %492
  %496 = load <4 x float>* %sum3, align 16
  %497 = insertelement <4 x float> %496, float %495, i32 0
  store <4 x float> %497, <4 x float>* %sum3, align 16
  %498 = load <4 x float>* %tempA3, align 16
  %499 = extractelement <4 x float> %498, i32 0
  %500 = load <4 x float>* %tempB0, align 16
  %501 = extractelement <4 x float> %500, i32 1
  %502 = load <4 x float>* %tempA3, align 16
  %503 = extractelement <4 x float> %502, i32 1
  %504 = load <4 x float>* %tempB1, align 16
  %505 = extractelement <4 x float> %504, i32 1
  %506 = fmul float %503, %505
  %507 = call float @llvm.fmuladd.f32(float %499, float %501, float %506)
  %508 = load <4 x float>* %tempA3, align 16
  %509 = extractelement <4 x float> %508, i32 2
  %510 = load <4 x float>* %tempB2, align 16
  %511 = extractelement <4 x float> %510, i32 1
  %512 = call float @llvm.fmuladd.f32(float %509, float %511, float %507)
  %513 = load <4 x float>* %tempA3, align 16
  %514 = extractelement <4 x float> %513, i32 3
  %515 = load <4 x float>* %tempB3, align 16
  %516 = extractelement <4 x float> %515, i32 1
  %517 = call float @llvm.fmuladd.f32(float %514, float %516, float %512)
  %518 = load <4 x float>* %sum3, align 16
  %519 = extractelement <4 x float> %518, i32 1
  %520 = fadd float %519, %517
  %521 = load <4 x float>* %sum3, align 16
  %522 = insertelement <4 x float> %521, float %520, i32 1
  store <4 x float> %522, <4 x float>* %sum3, align 16
  %523 = load <4 x float>* %tempA3, align 16
  %524 = extractelement <4 x float> %523, i32 0
  %525 = load <4 x float>* %tempB0, align 16
  %526 = extractelement <4 x float> %525, i32 2
  %527 = load <4 x float>* %tempA3, align 16
  %528 = extractelement <4 x float> %527, i32 1
  %529 = load <4 x float>* %tempB1, align 16
  %530 = extractelement <4 x float> %529, i32 2
  %531 = fmul float %528, %530
  %532 = call float @llvm.fmuladd.f32(float %524, float %526, float %531)
  %533 = load <4 x float>* %tempA3, align 16
  %534 = extractelement <4 x float> %533, i32 2
  %535 = load <4 x float>* %tempB2, align 16
  %536 = extractelement <4 x float> %535, i32 2
  %537 = call float @llvm.fmuladd.f32(float %534, float %536, float %532)
  %538 = load <4 x float>* %tempA3, align 16
  %539 = extractelement <4 x float> %538, i32 3
  %540 = load <4 x float>* %tempB3, align 16
  %541 = extractelement <4 x float> %540, i32 2
  %542 = call float @llvm.fmuladd.f32(float %539, float %541, float %537)
  %543 = load <4 x float>* %sum3, align 16
  %544 = extractelement <4 x float> %543, i32 2
  %545 = fadd float %544, %542
  %546 = load <4 x float>* %sum3, align 16
  %547 = insertelement <4 x float> %546, float %545, i32 2
  store <4 x float> %547, <4 x float>* %sum3, align 16
  %548 = load <4 x float>* %tempA3, align 16
  %549 = extractelement <4 x float> %548, i32 0
  %550 = load <4 x float>* %tempB0, align 16
  %551 = extractelement <4 x float> %550, i32 3
  %552 = load <4 x float>* %tempA3, align 16
  %553 = extractelement <4 x float> %552, i32 1
  %554 = load <4 x float>* %tempB1, align 16
  %555 = extractelement <4 x float> %554, i32 3
  %556 = fmul float %553, %555
  %557 = call float @llvm.fmuladd.f32(float %549, float %551, float %556)
  %558 = load <4 x float>* %tempA3, align 16
  %559 = extractelement <4 x float> %558, i32 2
  %560 = load <4 x float>* %tempB2, align 16
  %561 = extractelement <4 x float> %560, i32 3
  %562 = call float @llvm.fmuladd.f32(float %559, float %561, float %557)
  %563 = load <4 x float>* %tempA3, align 16
  %564 = extractelement <4 x float> %563, i32 3
  %565 = load <4 x float>* %tempB3, align 16
  %566 = extractelement <4 x float> %565, i32 3
  %567 = call float @llvm.fmuladd.f32(float %564, float %566, float %562)
  %568 = load <4 x float>* %sum3, align 16
  %569 = extractelement <4 x float> %568, i32 3
  %570 = fadd float %569, %567
  %571 = load <4 x float>* %sum3, align 16
  %572 = insertelement <4 x float> %571, float %570, i32 3
  store <4 x float> %572, <4 x float>* %sum3, align 16
  br label %573

; <label>:573                                     ; preds = %94
  %574 = load i32* %j, align 4
  %575 = add nsw i32 %574, 4
  store i32 %575, i32* %j, align 4
  br label %89

; <label>:576                                     ; preds = %89
  call void @barrier(i32 1)
  br label %577

; <label>:577                                     ; preds = %576
  %578 = load i32* %i, align 4
  %579 = add nsw i32 %578, 1
  store i32 %579, i32* %i, align 4
  br label %20

; <label>:580                                     ; preds = %20
  %581 = load <4 x float>* %sum0, align 16
  %582 = load i32* %globalPos, align 4
  %583 = load <4 x float> addrspace(1)** %3, align 4
  %584 = getelementptr inbounds <4 x float> addrspace(1)* %583, i32 %582
  store <4 x float> %581, <4 x float> addrspace(1)* %584, align 16
  %585 = load <4 x float>* %sum1, align 16
  %586 = load i32* %globalPos, align 4
  %587 = call i32 @__get_global_size_u32(i32 0)
  %588 = add i32 %586, %587
  %589 = load <4 x float> addrspace(1)** %3, align 4
  %590 = getelementptr inbounds <4 x float> addrspace(1)* %589, i32 %588
  store <4 x float> %585, <4 x float> addrspace(1)* %590, align 16
  %591 = load <4 x float>* %sum2, align 16
  %592 = load i32* %globalPos, align 4
  %593 = call i32 @__get_global_size_u32(i32 0)
  %594 = mul i32 2, %593
  %595 = add i32 %592, %594
  %596 = load <4 x float> addrspace(1)** %3, align 4
  %597 = getelementptr inbounds <4 x float> addrspace(1)* %596, i32 %595
  store <4 x float> %591, <4 x float> addrspace(1)* %597, align 16
  %598 = load <4 x float>* %sum3, align 16
  %599 = load i32* %globalPos, align 4
  %600 = call i32 @__get_global_size_u32(i32 0)
  %601 = mul i32 3, %600
  %602 = add i32 %599, %601
  %603 = load <4 x float> addrspace(1)** %3, align 4
  %604 = getelementptr inbounds <4 x float> addrspace(1)* %603, i32 %602
  store <4 x float> %598, <4 x float> addrspace(1)* %604, align 16
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, i32)* @mmmKernel}
!1 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, <4 x float> addrspace(3)*)* @mmmKernel_local}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

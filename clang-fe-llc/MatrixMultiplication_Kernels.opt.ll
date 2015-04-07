; ModuleID = 'MatrixMultiplication_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @mmmKernel(<4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)* %matrixC, i32 %widthA, i32 %widthB) #0 {
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = insertelement <2 x i32> undef, i32 %1, i32 0
  %3 = call i32 @llvm.r600.read.tgid.y()
  %4 = insertelement <2 x i32> %2, i32 %3, i32 1
  %5 = udiv i32 %widthB, 4
  br label %6

; <label>:6                                       ; preds = %307, %0
  %sum0.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %126, %307 ]
  %sum1.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %186, %307 ]
  %sum2.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %246, %307 ]
  %sum3.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %306, %307 ]
  %i.0 = phi i32 [ 0, %0 ], [ %308, %307 ]
  %7 = icmp ult i32 %i.0, %widthA
  br i1 %7, label %8, label %309

; <label>:8                                       ; preds = %6
  %9 = sdiv i32 %i.0, 4
  %10 = extractelement <2 x i32> %4, i32 1
  %11 = shl i32 %10, 2
  %12 = udiv i32 %widthA, 4
  %13 = mul i32 %11, %12
  %14 = add i32 %9, %13
  %15 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %14
  %16 = load <4 x float> addrspace(1)* %15, align 16
  %17 = sdiv i32 %i.0, 4
  %18 = extractelement <2 x i32> %4, i32 1
  %19 = shl i32 %18, 2
  %20 = add nsw i32 %19, 1
  %21 = udiv i32 %widthA, 4
  %22 = mul i32 %20, %21
  %23 = add i32 %17, %22
  %24 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %23
  %25 = load <4 x float> addrspace(1)* %24, align 16
  %26 = sdiv i32 %i.0, 4
  %27 = extractelement <2 x i32> %4, i32 1
  %28 = shl i32 %27, 2
  %29 = add nsw i32 %28, 2
  %30 = udiv i32 %widthA, 4
  %31 = mul i32 %29, %30
  %32 = add i32 %26, %31
  %33 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %32
  %34 = load <4 x float> addrspace(1)* %33, align 16
  %35 = sdiv i32 %i.0, 4
  %36 = extractelement <2 x i32> %4, i32 1
  %37 = shl i32 %36, 2
  %38 = add nsw i32 %37, 3
  %39 = udiv i32 %widthA, 4
  %40 = mul i32 %38, %39
  %41 = add i32 %35, %40
  %42 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %41
  %43 = load <4 x float> addrspace(1)* %42, align 16
  %44 = extractelement <2 x i32> %4, i32 0
  %45 = mul i32 %i.0, %5
  %46 = add i32 %44, %45
  %47 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %46
  %48 = load <4 x float> addrspace(1)* %47, align 16
  %49 = extractelement <2 x i32> %4, i32 0
  %50 = add nsw i32 %i.0, 1
  %51 = mul i32 %50, %5
  %52 = add i32 %49, %51
  %53 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %52
  %54 = load <4 x float> addrspace(1)* %53, align 16
  %55 = extractelement <2 x i32> %4, i32 0
  %56 = add nsw i32 %i.0, 2
  %57 = mul i32 %56, %5
  %58 = add i32 %55, %57
  %59 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %58
  %60 = load <4 x float> addrspace(1)* %59, align 16
  %61 = extractelement <2 x i32> %4, i32 0
  %62 = add nsw i32 %i.0, 3
  %63 = mul i32 %62, %5
  %64 = add i32 %61, %63
  %65 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %64
  %66 = load <4 x float> addrspace(1)* %65, align 16
  %67 = extractelement <4 x float> %16, i32 0
  %68 = extractelement <4 x float> %48, i32 0
  %69 = extractelement <4 x float> %16, i32 1
  %70 = extractelement <4 x float> %54, i32 0
  %71 = fmul float %69, %70
  %72 = call float @llvm.fmuladd.f32(float %67, float %68, float %71)
  %73 = extractelement <4 x float> %16, i32 2
  %74 = extractelement <4 x float> %60, i32 0
  %75 = call float @llvm.fmuladd.f32(float %73, float %74, float %72)
  %76 = extractelement <4 x float> %16, i32 3
  %77 = extractelement <4 x float> %66, i32 0
  %78 = call float @llvm.fmuladd.f32(float %76, float %77, float %75)
  %79 = extractelement <4 x float> %sum0.0, i32 0
  %80 = fadd float %79, %78
  %81 = insertelement <4 x float> %sum0.0, float %80, i32 0
  %82 = extractelement <4 x float> %16, i32 0
  %83 = extractelement <4 x float> %48, i32 1
  %84 = extractelement <4 x float> %16, i32 1
  %85 = extractelement <4 x float> %54, i32 1
  %86 = fmul float %84, %85
  %87 = call float @llvm.fmuladd.f32(float %82, float %83, float %86)
  %88 = extractelement <4 x float> %16, i32 2
  %89 = extractelement <4 x float> %60, i32 1
  %90 = call float @llvm.fmuladd.f32(float %88, float %89, float %87)
  %91 = extractelement <4 x float> %16, i32 3
  %92 = extractelement <4 x float> %66, i32 1
  %93 = call float @llvm.fmuladd.f32(float %91, float %92, float %90)
  %94 = extractelement <4 x float> %81, i32 1
  %95 = fadd float %94, %93
  %96 = insertelement <4 x float> %81, float %95, i32 1
  %97 = extractelement <4 x float> %16, i32 0
  %98 = extractelement <4 x float> %48, i32 2
  %99 = extractelement <4 x float> %16, i32 1
  %100 = extractelement <4 x float> %54, i32 2
  %101 = fmul float %99, %100
  %102 = call float @llvm.fmuladd.f32(float %97, float %98, float %101)
  %103 = extractelement <4 x float> %16, i32 2
  %104 = extractelement <4 x float> %60, i32 2
  %105 = call float @llvm.fmuladd.f32(float %103, float %104, float %102)
  %106 = extractelement <4 x float> %16, i32 3
  %107 = extractelement <4 x float> %66, i32 2
  %108 = call float @llvm.fmuladd.f32(float %106, float %107, float %105)
  %109 = extractelement <4 x float> %96, i32 2
  %110 = fadd float %109, %108
  %111 = insertelement <4 x float> %96, float %110, i32 2
  %112 = extractelement <4 x float> %16, i32 0
  %113 = extractelement <4 x float> %48, i32 3
  %114 = extractelement <4 x float> %16, i32 1
  %115 = extractelement <4 x float> %54, i32 3
  %116 = fmul float %114, %115
  %117 = call float @llvm.fmuladd.f32(float %112, float %113, float %116)
  %118 = extractelement <4 x float> %16, i32 2
  %119 = extractelement <4 x float> %60, i32 3
  %120 = call float @llvm.fmuladd.f32(float %118, float %119, float %117)
  %121 = extractelement <4 x float> %16, i32 3
  %122 = extractelement <4 x float> %66, i32 3
  %123 = call float @llvm.fmuladd.f32(float %121, float %122, float %120)
  %124 = extractelement <4 x float> %111, i32 3
  %125 = fadd float %124, %123
  %126 = insertelement <4 x float> %111, float %125, i32 3
  %127 = extractelement <4 x float> %25, i32 0
  %128 = extractelement <4 x float> %48, i32 0
  %129 = extractelement <4 x float> %25, i32 1
  %130 = extractelement <4 x float> %54, i32 0
  %131 = fmul float %129, %130
  %132 = call float @llvm.fmuladd.f32(float %127, float %128, float %131)
  %133 = extractelement <4 x float> %25, i32 2
  %134 = extractelement <4 x float> %60, i32 0
  %135 = call float @llvm.fmuladd.f32(float %133, float %134, float %132)
  %136 = extractelement <4 x float> %25, i32 3
  %137 = extractelement <4 x float> %66, i32 0
  %138 = call float @llvm.fmuladd.f32(float %136, float %137, float %135)
  %139 = extractelement <4 x float> %sum1.0, i32 0
  %140 = fadd float %139, %138
  %141 = insertelement <4 x float> %sum1.0, float %140, i32 0
  %142 = extractelement <4 x float> %25, i32 0
  %143 = extractelement <4 x float> %48, i32 1
  %144 = extractelement <4 x float> %25, i32 1
  %145 = extractelement <4 x float> %54, i32 1
  %146 = fmul float %144, %145
  %147 = call float @llvm.fmuladd.f32(float %142, float %143, float %146)
  %148 = extractelement <4 x float> %25, i32 2
  %149 = extractelement <4 x float> %60, i32 1
  %150 = call float @llvm.fmuladd.f32(float %148, float %149, float %147)
  %151 = extractelement <4 x float> %25, i32 3
  %152 = extractelement <4 x float> %66, i32 1
  %153 = call float @llvm.fmuladd.f32(float %151, float %152, float %150)
  %154 = extractelement <4 x float> %141, i32 1
  %155 = fadd float %154, %153
  %156 = insertelement <4 x float> %141, float %155, i32 1
  %157 = extractelement <4 x float> %25, i32 0
  %158 = extractelement <4 x float> %48, i32 2
  %159 = extractelement <4 x float> %25, i32 1
  %160 = extractelement <4 x float> %54, i32 2
  %161 = fmul float %159, %160
  %162 = call float @llvm.fmuladd.f32(float %157, float %158, float %161)
  %163 = extractelement <4 x float> %25, i32 2
  %164 = extractelement <4 x float> %60, i32 2
  %165 = call float @llvm.fmuladd.f32(float %163, float %164, float %162)
  %166 = extractelement <4 x float> %25, i32 3
  %167 = extractelement <4 x float> %66, i32 2
  %168 = call float @llvm.fmuladd.f32(float %166, float %167, float %165)
  %169 = extractelement <4 x float> %156, i32 2
  %170 = fadd float %169, %168
  %171 = insertelement <4 x float> %156, float %170, i32 2
  %172 = extractelement <4 x float> %25, i32 0
  %173 = extractelement <4 x float> %48, i32 3
  %174 = extractelement <4 x float> %25, i32 1
  %175 = extractelement <4 x float> %54, i32 3
  %176 = fmul float %174, %175
  %177 = call float @llvm.fmuladd.f32(float %172, float %173, float %176)
  %178 = extractelement <4 x float> %25, i32 2
  %179 = extractelement <4 x float> %60, i32 3
  %180 = call float @llvm.fmuladd.f32(float %178, float %179, float %177)
  %181 = extractelement <4 x float> %25, i32 3
  %182 = extractelement <4 x float> %66, i32 3
  %183 = call float @llvm.fmuladd.f32(float %181, float %182, float %180)
  %184 = extractelement <4 x float> %171, i32 3
  %185 = fadd float %184, %183
  %186 = insertelement <4 x float> %171, float %185, i32 3
  %187 = extractelement <4 x float> %34, i32 0
  %188 = extractelement <4 x float> %48, i32 0
  %189 = extractelement <4 x float> %34, i32 1
  %190 = extractelement <4 x float> %54, i32 0
  %191 = fmul float %189, %190
  %192 = call float @llvm.fmuladd.f32(float %187, float %188, float %191)
  %193 = extractelement <4 x float> %34, i32 2
  %194 = extractelement <4 x float> %60, i32 0
  %195 = call float @llvm.fmuladd.f32(float %193, float %194, float %192)
  %196 = extractelement <4 x float> %34, i32 3
  %197 = extractelement <4 x float> %66, i32 0
  %198 = call float @llvm.fmuladd.f32(float %196, float %197, float %195)
  %199 = extractelement <4 x float> %sum2.0, i32 0
  %200 = fadd float %199, %198
  %201 = insertelement <4 x float> %sum2.0, float %200, i32 0
  %202 = extractelement <4 x float> %34, i32 0
  %203 = extractelement <4 x float> %48, i32 1
  %204 = extractelement <4 x float> %34, i32 1
  %205 = extractelement <4 x float> %54, i32 1
  %206 = fmul float %204, %205
  %207 = call float @llvm.fmuladd.f32(float %202, float %203, float %206)
  %208 = extractelement <4 x float> %34, i32 2
  %209 = extractelement <4 x float> %60, i32 1
  %210 = call float @llvm.fmuladd.f32(float %208, float %209, float %207)
  %211 = extractelement <4 x float> %34, i32 3
  %212 = extractelement <4 x float> %66, i32 1
  %213 = call float @llvm.fmuladd.f32(float %211, float %212, float %210)
  %214 = extractelement <4 x float> %201, i32 1
  %215 = fadd float %214, %213
  %216 = insertelement <4 x float> %201, float %215, i32 1
  %217 = extractelement <4 x float> %34, i32 0
  %218 = extractelement <4 x float> %48, i32 2
  %219 = extractelement <4 x float> %34, i32 1
  %220 = extractelement <4 x float> %54, i32 2
  %221 = fmul float %219, %220
  %222 = call float @llvm.fmuladd.f32(float %217, float %218, float %221)
  %223 = extractelement <4 x float> %34, i32 2
  %224 = extractelement <4 x float> %60, i32 2
  %225 = call float @llvm.fmuladd.f32(float %223, float %224, float %222)
  %226 = extractelement <4 x float> %34, i32 3
  %227 = extractelement <4 x float> %66, i32 2
  %228 = call float @llvm.fmuladd.f32(float %226, float %227, float %225)
  %229 = extractelement <4 x float> %216, i32 2
  %230 = fadd float %229, %228
  %231 = insertelement <4 x float> %216, float %230, i32 2
  %232 = extractelement <4 x float> %34, i32 0
  %233 = extractelement <4 x float> %48, i32 3
  %234 = extractelement <4 x float> %34, i32 1
  %235 = extractelement <4 x float> %54, i32 3
  %236 = fmul float %234, %235
  %237 = call float @llvm.fmuladd.f32(float %232, float %233, float %236)
  %238 = extractelement <4 x float> %34, i32 2
  %239 = extractelement <4 x float> %60, i32 3
  %240 = call float @llvm.fmuladd.f32(float %238, float %239, float %237)
  %241 = extractelement <4 x float> %34, i32 3
  %242 = extractelement <4 x float> %66, i32 3
  %243 = call float @llvm.fmuladd.f32(float %241, float %242, float %240)
  %244 = extractelement <4 x float> %231, i32 3
  %245 = fadd float %244, %243
  %246 = insertelement <4 x float> %231, float %245, i32 3
  %247 = extractelement <4 x float> %43, i32 0
  %248 = extractelement <4 x float> %48, i32 0
  %249 = extractelement <4 x float> %43, i32 1
  %250 = extractelement <4 x float> %54, i32 0
  %251 = fmul float %249, %250
  %252 = call float @llvm.fmuladd.f32(float %247, float %248, float %251)
  %253 = extractelement <4 x float> %43, i32 2
  %254 = extractelement <4 x float> %60, i32 0
  %255 = call float @llvm.fmuladd.f32(float %253, float %254, float %252)
  %256 = extractelement <4 x float> %43, i32 3
  %257 = extractelement <4 x float> %66, i32 0
  %258 = call float @llvm.fmuladd.f32(float %256, float %257, float %255)
  %259 = extractelement <4 x float> %sum3.0, i32 0
  %260 = fadd float %259, %258
  %261 = insertelement <4 x float> %sum3.0, float %260, i32 0
  %262 = extractelement <4 x float> %43, i32 0
  %263 = extractelement <4 x float> %48, i32 1
  %264 = extractelement <4 x float> %43, i32 1
  %265 = extractelement <4 x float> %54, i32 1
  %266 = fmul float %264, %265
  %267 = call float @llvm.fmuladd.f32(float %262, float %263, float %266)
  %268 = extractelement <4 x float> %43, i32 2
  %269 = extractelement <4 x float> %60, i32 1
  %270 = call float @llvm.fmuladd.f32(float %268, float %269, float %267)
  %271 = extractelement <4 x float> %43, i32 3
  %272 = extractelement <4 x float> %66, i32 1
  %273 = call float @llvm.fmuladd.f32(float %271, float %272, float %270)
  %274 = extractelement <4 x float> %261, i32 1
  %275 = fadd float %274, %273
  %276 = insertelement <4 x float> %261, float %275, i32 1
  %277 = extractelement <4 x float> %43, i32 0
  %278 = extractelement <4 x float> %48, i32 2
  %279 = extractelement <4 x float> %43, i32 1
  %280 = extractelement <4 x float> %54, i32 2
  %281 = fmul float %279, %280
  %282 = call float @llvm.fmuladd.f32(float %277, float %278, float %281)
  %283 = extractelement <4 x float> %43, i32 2
  %284 = extractelement <4 x float> %60, i32 2
  %285 = call float @llvm.fmuladd.f32(float %283, float %284, float %282)
  %286 = extractelement <4 x float> %43, i32 3
  %287 = extractelement <4 x float> %66, i32 2
  %288 = call float @llvm.fmuladd.f32(float %286, float %287, float %285)
  %289 = extractelement <4 x float> %276, i32 2
  %290 = fadd float %289, %288
  %291 = insertelement <4 x float> %276, float %290, i32 2
  %292 = extractelement <4 x float> %43, i32 0
  %293 = extractelement <4 x float> %48, i32 3
  %294 = extractelement <4 x float> %43, i32 1
  %295 = extractelement <4 x float> %54, i32 3
  %296 = fmul float %294, %295
  %297 = call float @llvm.fmuladd.f32(float %292, float %293, float %296)
  %298 = extractelement <4 x float> %43, i32 2
  %299 = extractelement <4 x float> %60, i32 3
  %300 = call float @llvm.fmuladd.f32(float %298, float %299, float %297)
  %301 = extractelement <4 x float> %43, i32 3
  %302 = extractelement <4 x float> %66, i32 3
  %303 = call float @llvm.fmuladd.f32(float %301, float %302, float %300)
  %304 = extractelement <4 x float> %291, i32 3
  %305 = fadd float %304, %303
  %306 = insertelement <4 x float> %291, float %305, i32 3
  br label %307

; <label>:307                                     ; preds = %8
  %308 = add nsw i32 %i.0, 4
  br label %6

; <label>:309                                     ; preds = %6
  %310 = extractelement <2 x i32> %4, i32 0
  %311 = extractelement <2 x i32> %4, i32 1
  %312 = shl i32 %311, 2
  %313 = add nsw i32 %312, 0
  %314 = mul i32 %313, %5
  %315 = add i32 %310, %314
  %316 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %315
  store <4 x float> %sum0.0, <4 x float> addrspace(1)* %316, align 16
  %317 = extractelement <2 x i32> %4, i32 0
  %318 = extractelement <2 x i32> %4, i32 1
  %319 = shl i32 %318, 2
  %320 = add nsw i32 %319, 1
  %321 = mul i32 %320, %5
  %322 = add i32 %317, %321
  %323 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %322
  store <4 x float> %sum1.0, <4 x float> addrspace(1)* %323, align 16
  %324 = extractelement <2 x i32> %4, i32 0
  %325 = extractelement <2 x i32> %4, i32 1
  %326 = shl i32 %325, 2
  %327 = add nsw i32 %326, 2
  %328 = mul i32 %327, %5
  %329 = add i32 %324, %328
  %330 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %329
  store <4 x float> %sum2.0, <4 x float> addrspace(1)* %330, align 16
  %331 = extractelement <2 x i32> %4, i32 0
  %332 = extractelement <2 x i32> %4, i32 1
  %333 = shl i32 %332, 2
  %334 = add nsw i32 %333, 3
  %335 = mul i32 %334, %5
  %336 = add i32 %331, %335
  %337 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %336
  store <4 x float> %sum3.0, <4 x float> addrspace(1)* %337, align 16
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

; Function Attrs: nounwind
define void @mmmKernel_local(<4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)* %matrixC, i32 %widthA, <4 x float> addrspace(3)* %blockA) #0 {
  %1 = call i32 @llvm.r600.read.tidig.x()
  %2 = call i32 @llvm.r600.read.local.size.x()
  %3 = call i32 @llvm.r600.read.tidig.y()
  %4 = shl i32 %3, 2
  %5 = mul i32 %2, %4
  %6 = add i32 %1, %5
  %7 = call i32 @llvm.r600.read.tgid.x()
  %8 = call i32 @llvm.r600.read.tgid.y()
  %9 = shl i32 %8, 2
  %10 = call i32 @llvm.r600.read.global.size.x()
  %11 = mul i32 %9, %10
  %12 = add i32 %7, %11
  %13 = sdiv i32 %widthA, 4
  br label %14

; <label>:14                                      ; preds = %365, %0
  %sum0.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %sum0.1, %365 ]
  %sum1.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %sum1.1, %365 ]
  %sum2.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %sum2.1, %365 ]
  %sum3.0 = phi <4 x float> [ zeroinitializer, %0 ], [ %sum3.1, %365 ]
  %i.0 = phi i32 [ 0, %0 ], [ %366, %365 ]
  %15 = call i32 @llvm.r600.read.local.size.x()
  %16 = udiv i32 %13, %15
  %17 = icmp ult i32 %i.0, %16
  br i1 %17, label %18, label %367

; <label>:18                                      ; preds = %14
  %19 = call i32 @llvm.r600.read.local.size.x()
  %20 = mul i32 %i.0, %19
  %21 = call i32 @llvm.r600.read.tidig.x()
  %22 = add i32 %20, %21
  %23 = call i32 @llvm.r600.read.tgid.y()
  %24 = shl i32 %23, 2
  %25 = mul i32 %24, %13
  %26 = add i32 %22, %25
  %27 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %26
  %28 = load <4 x float> addrspace(1)* %27, align 16
  %29 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %6
  store <4 x float> %28, <4 x float> addrspace(3)* %29, align 16
  %30 = add nsw i32 %26, %13
  %31 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %30
  %32 = load <4 x float> addrspace(1)* %31, align 16
  %33 = call i32 @llvm.r600.read.local.size.x()
  %34 = add i32 %6, %33
  %35 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %34
  store <4 x float> %32, <4 x float> addrspace(3)* %35, align 16
  %36 = mul nsw i32 2, %13
  %37 = add nsw i32 %26, %36
  %38 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %37
  %39 = load <4 x float> addrspace(1)* %38, align 16
  %40 = call i32 @llvm.r600.read.local.size.x()
  %41 = mul i32 2, %40
  %42 = add i32 %6, %41
  %43 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %42
  store <4 x float> %39, <4 x float> addrspace(3)* %43, align 16
  %44 = mul nsw i32 3, %13
  %45 = add nsw i32 %26, %44
  %46 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %45
  %47 = load <4 x float> addrspace(1)* %46, align 16
  %48 = call i32 @llvm.r600.read.local.size.x()
  %49 = mul i32 3, %48
  %50 = add i32 %6, %49
  %51 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %50
  store <4 x float> %47, <4 x float> addrspace(3)* %51, align 16
  call void @barrier(i32 1)
  %52 = call i32 @llvm.r600.read.tgid.x()
  %53 = call i32 @llvm.r600.read.local.size.x()
  %54 = mul i32 %i.0, %53
  %55 = shl i32 %54, 2
  %56 = call i32 @llvm.r600.read.global.size.x()
  %57 = mul i32 %55, %56
  %58 = add i32 %52, %57
  br label %59

; <label>:59                                      ; preds = %362, %18
  %sum0.1 = phi <4 x float> [ %sum0.0, %18 ], [ %181, %362 ]
  %sum1.1 = phi <4 x float> [ %sum1.0, %18 ], [ %241, %362 ]
  %sum2.1 = phi <4 x float> [ %sum2.0, %18 ], [ %301, %362 ]
  %sum3.1 = phi <4 x float> [ %sum3.0, %18 ], [ %361, %362 ]
  %j.0 = phi i32 [ 0, %18 ], [ %363, %362 ]
  %60 = call i32 @llvm.r600.read.local.size.x()
  %61 = mul i32 %60, 4
  %62 = icmp ult i32 %j.0, %61
  br i1 %62, label %63, label %364

; <label>:63                                      ; preds = %59
  %64 = ashr i32 %j.0, 2
  %65 = call i32 @llvm.r600.read.tidig.y()
  %66 = mul i32 %65, 4
  %67 = call i32 @llvm.r600.read.local.size.x()
  %68 = mul i32 %66, %67
  %69 = add i32 %64, %68
  %70 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %69
  %71 = load <4 x float> addrspace(3)* %70, align 16
  %72 = ashr i32 %j.0, 2
  %73 = call i32 @llvm.r600.read.tidig.y()
  %74 = mul i32 %73, 4
  %75 = add i32 %74, 1
  %76 = call i32 @llvm.r600.read.local.size.x()
  %77 = mul i32 %75, %76
  %78 = add i32 %72, %77
  %79 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %78
  %80 = load <4 x float> addrspace(3)* %79, align 16
  %81 = ashr i32 %j.0, 2
  %82 = call i32 @llvm.r600.read.tidig.y()
  %83 = mul i32 %82, 4
  %84 = add i32 %83, 2
  %85 = call i32 @llvm.r600.read.local.size.x()
  %86 = mul i32 %84, %85
  %87 = add i32 %81, %86
  %88 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %87
  %89 = load <4 x float> addrspace(3)* %88, align 16
  %90 = ashr i32 %j.0, 2
  %91 = call i32 @llvm.r600.read.tidig.y()
  %92 = mul i32 %91, 4
  %93 = add i32 %92, 3
  %94 = call i32 @llvm.r600.read.local.size.x()
  %95 = mul i32 %93, %94
  %96 = add i32 %90, %95
  %97 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %96
  %98 = load <4 x float> addrspace(3)* %97, align 16
  %99 = call i32 @llvm.r600.read.global.size.x()
  %100 = mul i32 %j.0, %99
  %101 = add i32 %58, %100
  %102 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %101
  %103 = load <4 x float> addrspace(1)* %102, align 16
  %104 = add nsw i32 %j.0, 1
  %105 = call i32 @llvm.r600.read.global.size.x()
  %106 = mul i32 %104, %105
  %107 = add i32 %58, %106
  %108 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %107
  %109 = load <4 x float> addrspace(1)* %108, align 16
  %110 = add nsw i32 %j.0, 2
  %111 = call i32 @llvm.r600.read.global.size.x()
  %112 = mul i32 %110, %111
  %113 = add i32 %58, %112
  %114 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %113
  %115 = load <4 x float> addrspace(1)* %114, align 16
  %116 = add nsw i32 %j.0, 3
  %117 = call i32 @llvm.r600.read.global.size.x()
  %118 = mul i32 %116, %117
  %119 = add i32 %58, %118
  %120 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %119
  %121 = load <4 x float> addrspace(1)* %120, align 16
  %122 = extractelement <4 x float> %71, i32 0
  %123 = extractelement <4 x float> %103, i32 0
  %124 = extractelement <4 x float> %71, i32 1
  %125 = extractelement <4 x float> %109, i32 0
  %126 = fmul float %124, %125
  %127 = call float @llvm.fmuladd.f32(float %122, float %123, float %126)
  %128 = extractelement <4 x float> %71, i32 2
  %129 = extractelement <4 x float> %115, i32 0
  %130 = call float @llvm.fmuladd.f32(float %128, float %129, float %127)
  %131 = extractelement <4 x float> %71, i32 3
  %132 = extractelement <4 x float> %121, i32 0
  %133 = call float @llvm.fmuladd.f32(float %131, float %132, float %130)
  %134 = extractelement <4 x float> %sum0.1, i32 0
  %135 = fadd float %134, %133
  %136 = insertelement <4 x float> %sum0.1, float %135, i32 0
  %137 = extractelement <4 x float> %71, i32 0
  %138 = extractelement <4 x float> %103, i32 1
  %139 = extractelement <4 x float> %71, i32 1
  %140 = extractelement <4 x float> %109, i32 1
  %141 = fmul float %139, %140
  %142 = call float @llvm.fmuladd.f32(float %137, float %138, float %141)
  %143 = extractelement <4 x float> %71, i32 2
  %144 = extractelement <4 x float> %115, i32 1
  %145 = call float @llvm.fmuladd.f32(float %143, float %144, float %142)
  %146 = extractelement <4 x float> %71, i32 3
  %147 = extractelement <4 x float> %121, i32 1
  %148 = call float @llvm.fmuladd.f32(float %146, float %147, float %145)
  %149 = extractelement <4 x float> %136, i32 1
  %150 = fadd float %149, %148
  %151 = insertelement <4 x float> %136, float %150, i32 1
  %152 = extractelement <4 x float> %71, i32 0
  %153 = extractelement <4 x float> %103, i32 2
  %154 = extractelement <4 x float> %71, i32 1
  %155 = extractelement <4 x float> %109, i32 2
  %156 = fmul float %154, %155
  %157 = call float @llvm.fmuladd.f32(float %152, float %153, float %156)
  %158 = extractelement <4 x float> %71, i32 2
  %159 = extractelement <4 x float> %115, i32 2
  %160 = call float @llvm.fmuladd.f32(float %158, float %159, float %157)
  %161 = extractelement <4 x float> %71, i32 3
  %162 = extractelement <4 x float> %121, i32 2
  %163 = call float @llvm.fmuladd.f32(float %161, float %162, float %160)
  %164 = extractelement <4 x float> %151, i32 2
  %165 = fadd float %164, %163
  %166 = insertelement <4 x float> %151, float %165, i32 2
  %167 = extractelement <4 x float> %71, i32 0
  %168 = extractelement <4 x float> %103, i32 3
  %169 = extractelement <4 x float> %71, i32 1
  %170 = extractelement <4 x float> %109, i32 3
  %171 = fmul float %169, %170
  %172 = call float @llvm.fmuladd.f32(float %167, float %168, float %171)
  %173 = extractelement <4 x float> %71, i32 2
  %174 = extractelement <4 x float> %115, i32 3
  %175 = call float @llvm.fmuladd.f32(float %173, float %174, float %172)
  %176 = extractelement <4 x float> %71, i32 3
  %177 = extractelement <4 x float> %121, i32 3
  %178 = call float @llvm.fmuladd.f32(float %176, float %177, float %175)
  %179 = extractelement <4 x float> %166, i32 3
  %180 = fadd float %179, %178
  %181 = insertelement <4 x float> %166, float %180, i32 3
  %182 = extractelement <4 x float> %80, i32 0
  %183 = extractelement <4 x float> %103, i32 0
  %184 = extractelement <4 x float> %80, i32 1
  %185 = extractelement <4 x float> %109, i32 0
  %186 = fmul float %184, %185
  %187 = call float @llvm.fmuladd.f32(float %182, float %183, float %186)
  %188 = extractelement <4 x float> %80, i32 2
  %189 = extractelement <4 x float> %115, i32 0
  %190 = call float @llvm.fmuladd.f32(float %188, float %189, float %187)
  %191 = extractelement <4 x float> %80, i32 3
  %192 = extractelement <4 x float> %121, i32 0
  %193 = call float @llvm.fmuladd.f32(float %191, float %192, float %190)
  %194 = extractelement <4 x float> %sum1.1, i32 0
  %195 = fadd float %194, %193
  %196 = insertelement <4 x float> %sum1.1, float %195, i32 0
  %197 = extractelement <4 x float> %80, i32 0
  %198 = extractelement <4 x float> %103, i32 1
  %199 = extractelement <4 x float> %80, i32 1
  %200 = extractelement <4 x float> %109, i32 1
  %201 = fmul float %199, %200
  %202 = call float @llvm.fmuladd.f32(float %197, float %198, float %201)
  %203 = extractelement <4 x float> %80, i32 2
  %204 = extractelement <4 x float> %115, i32 1
  %205 = call float @llvm.fmuladd.f32(float %203, float %204, float %202)
  %206 = extractelement <4 x float> %80, i32 3
  %207 = extractelement <4 x float> %121, i32 1
  %208 = call float @llvm.fmuladd.f32(float %206, float %207, float %205)
  %209 = extractelement <4 x float> %196, i32 1
  %210 = fadd float %209, %208
  %211 = insertelement <4 x float> %196, float %210, i32 1
  %212 = extractelement <4 x float> %80, i32 0
  %213 = extractelement <4 x float> %103, i32 2
  %214 = extractelement <4 x float> %80, i32 1
  %215 = extractelement <4 x float> %109, i32 2
  %216 = fmul float %214, %215
  %217 = call float @llvm.fmuladd.f32(float %212, float %213, float %216)
  %218 = extractelement <4 x float> %80, i32 2
  %219 = extractelement <4 x float> %115, i32 2
  %220 = call float @llvm.fmuladd.f32(float %218, float %219, float %217)
  %221 = extractelement <4 x float> %80, i32 3
  %222 = extractelement <4 x float> %121, i32 2
  %223 = call float @llvm.fmuladd.f32(float %221, float %222, float %220)
  %224 = extractelement <4 x float> %211, i32 2
  %225 = fadd float %224, %223
  %226 = insertelement <4 x float> %211, float %225, i32 2
  %227 = extractelement <4 x float> %80, i32 0
  %228 = extractelement <4 x float> %103, i32 3
  %229 = extractelement <4 x float> %80, i32 1
  %230 = extractelement <4 x float> %109, i32 3
  %231 = fmul float %229, %230
  %232 = call float @llvm.fmuladd.f32(float %227, float %228, float %231)
  %233 = extractelement <4 x float> %80, i32 2
  %234 = extractelement <4 x float> %115, i32 3
  %235 = call float @llvm.fmuladd.f32(float %233, float %234, float %232)
  %236 = extractelement <4 x float> %80, i32 3
  %237 = extractelement <4 x float> %121, i32 3
  %238 = call float @llvm.fmuladd.f32(float %236, float %237, float %235)
  %239 = extractelement <4 x float> %226, i32 3
  %240 = fadd float %239, %238
  %241 = insertelement <4 x float> %226, float %240, i32 3
  %242 = extractelement <4 x float> %89, i32 0
  %243 = extractelement <4 x float> %103, i32 0
  %244 = extractelement <4 x float> %89, i32 1
  %245 = extractelement <4 x float> %109, i32 0
  %246 = fmul float %244, %245
  %247 = call float @llvm.fmuladd.f32(float %242, float %243, float %246)
  %248 = extractelement <4 x float> %89, i32 2
  %249 = extractelement <4 x float> %115, i32 0
  %250 = call float @llvm.fmuladd.f32(float %248, float %249, float %247)
  %251 = extractelement <4 x float> %89, i32 3
  %252 = extractelement <4 x float> %121, i32 0
  %253 = call float @llvm.fmuladd.f32(float %251, float %252, float %250)
  %254 = extractelement <4 x float> %sum2.1, i32 0
  %255 = fadd float %254, %253
  %256 = insertelement <4 x float> %sum2.1, float %255, i32 0
  %257 = extractelement <4 x float> %89, i32 0
  %258 = extractelement <4 x float> %103, i32 1
  %259 = extractelement <4 x float> %89, i32 1
  %260 = extractelement <4 x float> %109, i32 1
  %261 = fmul float %259, %260
  %262 = call float @llvm.fmuladd.f32(float %257, float %258, float %261)
  %263 = extractelement <4 x float> %89, i32 2
  %264 = extractelement <4 x float> %115, i32 1
  %265 = call float @llvm.fmuladd.f32(float %263, float %264, float %262)
  %266 = extractelement <4 x float> %89, i32 3
  %267 = extractelement <4 x float> %121, i32 1
  %268 = call float @llvm.fmuladd.f32(float %266, float %267, float %265)
  %269 = extractelement <4 x float> %256, i32 1
  %270 = fadd float %269, %268
  %271 = insertelement <4 x float> %256, float %270, i32 1
  %272 = extractelement <4 x float> %89, i32 0
  %273 = extractelement <4 x float> %103, i32 2
  %274 = extractelement <4 x float> %89, i32 1
  %275 = extractelement <4 x float> %109, i32 2
  %276 = fmul float %274, %275
  %277 = call float @llvm.fmuladd.f32(float %272, float %273, float %276)
  %278 = extractelement <4 x float> %89, i32 2
  %279 = extractelement <4 x float> %115, i32 2
  %280 = call float @llvm.fmuladd.f32(float %278, float %279, float %277)
  %281 = extractelement <4 x float> %89, i32 3
  %282 = extractelement <4 x float> %121, i32 2
  %283 = call float @llvm.fmuladd.f32(float %281, float %282, float %280)
  %284 = extractelement <4 x float> %271, i32 2
  %285 = fadd float %284, %283
  %286 = insertelement <4 x float> %271, float %285, i32 2
  %287 = extractelement <4 x float> %89, i32 0
  %288 = extractelement <4 x float> %103, i32 3
  %289 = extractelement <4 x float> %89, i32 1
  %290 = extractelement <4 x float> %109, i32 3
  %291 = fmul float %289, %290
  %292 = call float @llvm.fmuladd.f32(float %287, float %288, float %291)
  %293 = extractelement <4 x float> %89, i32 2
  %294 = extractelement <4 x float> %115, i32 3
  %295 = call float @llvm.fmuladd.f32(float %293, float %294, float %292)
  %296 = extractelement <4 x float> %89, i32 3
  %297 = extractelement <4 x float> %121, i32 3
  %298 = call float @llvm.fmuladd.f32(float %296, float %297, float %295)
  %299 = extractelement <4 x float> %286, i32 3
  %300 = fadd float %299, %298
  %301 = insertelement <4 x float> %286, float %300, i32 3
  %302 = extractelement <4 x float> %98, i32 0
  %303 = extractelement <4 x float> %103, i32 0
  %304 = extractelement <4 x float> %98, i32 1
  %305 = extractelement <4 x float> %109, i32 0
  %306 = fmul float %304, %305
  %307 = call float @llvm.fmuladd.f32(float %302, float %303, float %306)
  %308 = extractelement <4 x float> %98, i32 2
  %309 = extractelement <4 x float> %115, i32 0
  %310 = call float @llvm.fmuladd.f32(float %308, float %309, float %307)
  %311 = extractelement <4 x float> %98, i32 3
  %312 = extractelement <4 x float> %121, i32 0
  %313 = call float @llvm.fmuladd.f32(float %311, float %312, float %310)
  %314 = extractelement <4 x float> %sum3.1, i32 0
  %315 = fadd float %314, %313
  %316 = insertelement <4 x float> %sum3.1, float %315, i32 0
  %317 = extractelement <4 x float> %98, i32 0
  %318 = extractelement <4 x float> %103, i32 1
  %319 = extractelement <4 x float> %98, i32 1
  %320 = extractelement <4 x float> %109, i32 1
  %321 = fmul float %319, %320
  %322 = call float @llvm.fmuladd.f32(float %317, float %318, float %321)
  %323 = extractelement <4 x float> %98, i32 2
  %324 = extractelement <4 x float> %115, i32 1
  %325 = call float @llvm.fmuladd.f32(float %323, float %324, float %322)
  %326 = extractelement <4 x float> %98, i32 3
  %327 = extractelement <4 x float> %121, i32 1
  %328 = call float @llvm.fmuladd.f32(float %326, float %327, float %325)
  %329 = extractelement <4 x float> %316, i32 1
  %330 = fadd float %329, %328
  %331 = insertelement <4 x float> %316, float %330, i32 1
  %332 = extractelement <4 x float> %98, i32 0
  %333 = extractelement <4 x float> %103, i32 2
  %334 = extractelement <4 x float> %98, i32 1
  %335 = extractelement <4 x float> %109, i32 2
  %336 = fmul float %334, %335
  %337 = call float @llvm.fmuladd.f32(float %332, float %333, float %336)
  %338 = extractelement <4 x float> %98, i32 2
  %339 = extractelement <4 x float> %115, i32 2
  %340 = call float @llvm.fmuladd.f32(float %338, float %339, float %337)
  %341 = extractelement <4 x float> %98, i32 3
  %342 = extractelement <4 x float> %121, i32 2
  %343 = call float @llvm.fmuladd.f32(float %341, float %342, float %340)
  %344 = extractelement <4 x float> %331, i32 2
  %345 = fadd float %344, %343
  %346 = insertelement <4 x float> %331, float %345, i32 2
  %347 = extractelement <4 x float> %98, i32 0
  %348 = extractelement <4 x float> %103, i32 3
  %349 = extractelement <4 x float> %98, i32 1
  %350 = extractelement <4 x float> %109, i32 3
  %351 = fmul float %349, %350
  %352 = call float @llvm.fmuladd.f32(float %347, float %348, float %351)
  %353 = extractelement <4 x float> %98, i32 2
  %354 = extractelement <4 x float> %115, i32 3
  %355 = call float @llvm.fmuladd.f32(float %353, float %354, float %352)
  %356 = extractelement <4 x float> %98, i32 3
  %357 = extractelement <4 x float> %121, i32 3
  %358 = call float @llvm.fmuladd.f32(float %356, float %357, float %355)
  %359 = extractelement <4 x float> %346, i32 3
  %360 = fadd float %359, %358
  %361 = insertelement <4 x float> %346, float %360, i32 3
  br label %362

; <label>:362                                     ; preds = %63
  %363 = add nsw i32 %j.0, 4
  br label %59

; <label>:364                                     ; preds = %59
  call void @barrier(i32 1)
  br label %365

; <label>:365                                     ; preds = %364
  %366 = add nsw i32 %i.0, 1
  br label %14

; <label>:367                                     ; preds = %14
  %368 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %12
  store <4 x float> %sum0.0, <4 x float> addrspace(1)* %368, align 16
  %369 = call i32 @llvm.r600.read.global.size.x()
  %370 = add i32 %12, %369
  %371 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %370
  store <4 x float> %sum1.0, <4 x float> addrspace(1)* %371, align 16
  %372 = call i32 @llvm.r600.read.global.size.x()
  %373 = mul i32 2, %372
  %374 = add i32 %12, %373
  %375 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %374
  store <4 x float> %sum2.0, <4 x float> addrspace(1)* %375, align 16
  %376 = call i32 @llvm.r600.read.global.size.x()
  %377 = mul i32 3, %376
  %378 = add i32 %12, %377
  %379 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %378
  store <4 x float> %sum3.0, <4 x float> addrspace(1)* %379, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.z() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.local.size.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.local.size.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.local.size.z() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.global.size.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.global.size.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.global.size.z() #1

declare void @barrier(i32) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, i32)* @mmmKernel}
!1 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, <4 x float> addrspace(3)*)* @mmmKernel_local}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

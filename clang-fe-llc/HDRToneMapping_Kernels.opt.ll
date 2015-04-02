; ModuleID = 'HDRToneMapping_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define float @luminance(float %r, float %g, float %b) #0 {
  %1 = fmul float 0x3FE6E2EB20000000, %g
  %2 = call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %r, float %1)
  %3 = call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %b, float %2)
  ret float %3
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind
define void @toneMappingPattanaik1(float addrspace(1)* %input, float addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_global_id(i32 1)
  %3 = mul i32 %width, %numChannels
  %4 = mul i32 %3, %2
  %5 = mul i32 %1, %numChannels
  %6 = add i32 %5, 0
  %7 = add i32 %4, %6
  %8 = getelementptr inbounds float addrspace(1)* %input, i32 %7
  %9 = load float addrspace(1)* %8, align 4
  %10 = mul i32 %width, %numChannels
  %11 = mul i32 %10, %2
  %12 = mul i32 %1, %numChannels
  %13 = add i32 %12, 1
  %14 = add i32 %11, %13
  %15 = getelementptr inbounds float addrspace(1)* %input, i32 %14
  %16 = load float addrspace(1)* %15, align 4
  %17 = mul i32 %width, %numChannels
  %18 = mul i32 %17, %2
  %19 = mul i32 %1, %numChannels
  %20 = add i32 %19, 2
  %21 = add i32 %18, %20
  %22 = getelementptr inbounds float addrspace(1)* %input, i32 %21
  %23 = load float addrspace(1)* %22, align 4
  %24 = call float @luminance(float %9, float %16, float %23)
  %25 = fmul float %c, %averageLuminance
  %26 = icmp ne i32 %1, 0
  br i1 %26, label %27, label %256

; <label>:27                                      ; preds = %0
  %28 = icmp ne i32 %2, 0
  br i1 %28, label %29, label %256

; <label>:29                                      ; preds = %27
  %30 = sub i32 %width, 1
  %31 = icmp ne i32 %1, %30
  br i1 %31, label %32, label %256

; <label>:32                                      ; preds = %29
  %33 = sub i32 %height, 1
  %34 = icmp ne i32 %2, %33
  br i1 %34, label %35, label %256

; <label>:35                                      ; preds = %32
  %36 = mul i32 %width, %numChannels
  %37 = sub i32 %2, 1
  %38 = mul i32 %36, %37
  %39 = sub i32 %1, 1
  %40 = mul i32 %39, %numChannels
  %41 = add i32 %38, %40
  %42 = add i32 %41, 0
  %43 = getelementptr inbounds float addrspace(1)* %input, i32 %42
  %44 = load float addrspace(1)* %43, align 4
  %45 = mul i32 %width, %numChannels
  %46 = sub i32 %2, 1
  %47 = mul i32 %45, %46
  %48 = sub i32 %1, 1
  %49 = mul i32 %48, %numChannels
  %50 = add i32 %47, %49
  %51 = add i32 %50, 1
  %52 = getelementptr inbounds float addrspace(1)* %input, i32 %51
  %53 = load float addrspace(1)* %52, align 4
  %54 = mul i32 %width, %numChannels
  %55 = sub i32 %2, 1
  %56 = mul i32 %54, %55
  %57 = sub i32 %1, 1
  %58 = mul i32 %57, %numChannels
  %59 = add i32 %56, %58
  %60 = add i32 %59, 2
  %61 = getelementptr inbounds float addrspace(1)* %input, i32 %60
  %62 = load float addrspace(1)* %61, align 4
  %63 = call float @luminance(float %44, float %53, float %62)
  %64 = mul i32 %width, %numChannels
  %65 = sub i32 %2, 1
  %66 = mul i32 %64, %65
  %67 = mul i32 %1, %numChannels
  %68 = add i32 %66, %67
  %69 = add i32 %68, 0
  %70 = getelementptr inbounds float addrspace(1)* %input, i32 %69
  %71 = load float addrspace(1)* %70, align 4
  %72 = mul i32 %width, %numChannels
  %73 = sub i32 %2, 1
  %74 = mul i32 %72, %73
  %75 = mul i32 %1, %numChannels
  %76 = add i32 %74, %75
  %77 = add i32 %76, 1
  %78 = getelementptr inbounds float addrspace(1)* %input, i32 %77
  %79 = load float addrspace(1)* %78, align 4
  %80 = mul i32 %width, %numChannels
  %81 = sub i32 %2, 1
  %82 = mul i32 %80, %81
  %83 = mul i32 %1, %numChannels
  %84 = add i32 %82, %83
  %85 = add i32 %84, 2
  %86 = getelementptr inbounds float addrspace(1)* %input, i32 %85
  %87 = load float addrspace(1)* %86, align 4
  %88 = call float @luminance(float %71, float %79, float %87)
  %89 = mul i32 %width, %numChannels
  %90 = sub i32 %2, 1
  %91 = mul i32 %89, %90
  %92 = add i32 %1, 1
  %93 = mul i32 %92, %numChannels
  %94 = add i32 %91, %93
  %95 = add i32 %94, 0
  %96 = getelementptr inbounds float addrspace(1)* %input, i32 %95
  %97 = load float addrspace(1)* %96, align 4
  %98 = mul i32 %width, %numChannels
  %99 = sub i32 %2, 1
  %100 = mul i32 %98, %99
  %101 = add i32 %1, 1
  %102 = mul i32 %101, %numChannels
  %103 = add i32 %100, %102
  %104 = add i32 %103, 1
  %105 = getelementptr inbounds float addrspace(1)* %input, i32 %104
  %106 = load float addrspace(1)* %105, align 4
  %107 = mul i32 %width, %numChannels
  %108 = sub i32 %2, 1
  %109 = mul i32 %107, %108
  %110 = add i32 %1, 1
  %111 = mul i32 %110, %numChannels
  %112 = add i32 %109, %111
  %113 = add i32 %112, 2
  %114 = getelementptr inbounds float addrspace(1)* %input, i32 %113
  %115 = load float addrspace(1)* %114, align 4
  %116 = call float @luminance(float %97, float %106, float %115)
  %117 = mul i32 %width, %numChannels
  %118 = mul i32 %117, %2
  %119 = sub i32 %1, 1
  %120 = mul i32 %119, %numChannels
  %121 = add i32 %118, %120
  %122 = add i32 %121, 0
  %123 = getelementptr inbounds float addrspace(1)* %input, i32 %122
  %124 = load float addrspace(1)* %123, align 4
  %125 = mul i32 %width, %numChannels
  %126 = mul i32 %125, %2
  %127 = sub i32 %1, 1
  %128 = mul i32 %127, %numChannels
  %129 = add i32 %126, %128
  %130 = add i32 %129, 1
  %131 = getelementptr inbounds float addrspace(1)* %input, i32 %130
  %132 = load float addrspace(1)* %131, align 4
  %133 = mul i32 %width, %numChannels
  %134 = mul i32 %133, %2
  %135 = sub i32 %1, 1
  %136 = mul i32 %135, %numChannels
  %137 = add i32 %134, %136
  %138 = add i32 %137, 2
  %139 = getelementptr inbounds float addrspace(1)* %input, i32 %138
  %140 = load float addrspace(1)* %139, align 4
  %141 = call float @luminance(float %124, float %132, float %140)
  %142 = mul i32 %width, %numChannels
  %143 = mul i32 %142, %2
  %144 = add i32 %1, 1
  %145 = mul i32 %144, %numChannels
  %146 = add i32 %143, %145
  %147 = add i32 %146, 0
  %148 = getelementptr inbounds float addrspace(1)* %input, i32 %147
  %149 = load float addrspace(1)* %148, align 4
  %150 = mul i32 %width, %numChannels
  %151 = mul i32 %150, %2
  %152 = add i32 %1, 1
  %153 = mul i32 %152, %numChannels
  %154 = add i32 %151, %153
  %155 = add i32 %154, 1
  %156 = getelementptr inbounds float addrspace(1)* %input, i32 %155
  %157 = load float addrspace(1)* %156, align 4
  %158 = mul i32 %width, %numChannels
  %159 = mul i32 %158, %2
  %160 = add i32 %1, 1
  %161 = mul i32 %160, %numChannels
  %162 = add i32 %159, %161
  %163 = add i32 %162, 2
  %164 = getelementptr inbounds float addrspace(1)* %input, i32 %163
  %165 = load float addrspace(1)* %164, align 4
  %166 = call float @luminance(float %149, float %157, float %165)
  %167 = mul i32 %width, %numChannels
  %168 = add i32 %2, 1
  %169 = mul i32 %167, %168
  %170 = sub i32 %1, 1
  %171 = mul i32 %170, %numChannels
  %172 = add i32 %169, %171
  %173 = add i32 %172, 0
  %174 = getelementptr inbounds float addrspace(1)* %input, i32 %173
  %175 = load float addrspace(1)* %174, align 4
  %176 = mul i32 %width, %numChannels
  %177 = add i32 %2, 1
  %178 = mul i32 %176, %177
  %179 = sub i32 %1, 1
  %180 = mul i32 %179, %numChannels
  %181 = add i32 %178, %180
  %182 = add i32 %181, 1
  %183 = getelementptr inbounds float addrspace(1)* %input, i32 %182
  %184 = load float addrspace(1)* %183, align 4
  %185 = mul i32 %width, %numChannels
  %186 = add i32 %2, 1
  %187 = mul i32 %185, %186
  %188 = sub i32 %1, 1
  %189 = mul i32 %188, %numChannels
  %190 = add i32 %187, %189
  %191 = add i32 %190, 2
  %192 = getelementptr inbounds float addrspace(1)* %input, i32 %191
  %193 = load float addrspace(1)* %192, align 4
  %194 = call float @luminance(float %175, float %184, float %193)
  %195 = mul i32 %width, %numChannels
  %196 = add i32 %2, 1
  %197 = mul i32 %195, %196
  %198 = mul i32 %1, %numChannels
  %199 = add i32 %197, %198
  %200 = add i32 %199, 0
  %201 = getelementptr inbounds float addrspace(1)* %input, i32 %200
  %202 = load float addrspace(1)* %201, align 4
  %203 = mul i32 %width, %numChannels
  %204 = add i32 %2, 1
  %205 = mul i32 %203, %204
  %206 = mul i32 %1, %numChannels
  %207 = add i32 %205, %206
  %208 = add i32 %207, 1
  %209 = getelementptr inbounds float addrspace(1)* %input, i32 %208
  %210 = load float addrspace(1)* %209, align 4
  %211 = mul i32 %width, %numChannels
  %212 = add i32 %2, 1
  %213 = mul i32 %211, %212
  %214 = mul i32 %1, %numChannels
  %215 = add i32 %213, %214
  %216 = add i32 %215, 2
  %217 = getelementptr inbounds float addrspace(1)* %input, i32 %216
  %218 = load float addrspace(1)* %217, align 4
  %219 = call float @luminance(float %202, float %210, float %218)
  %220 = mul i32 %width, %numChannels
  %221 = add i32 %2, 1
  %222 = mul i32 %220, %221
  %223 = add i32 %1, 1
  %224 = mul i32 %223, %numChannels
  %225 = add i32 %222, %224
  %226 = add i32 %225, 0
  %227 = getelementptr inbounds float addrspace(1)* %input, i32 %226
  %228 = load float addrspace(1)* %227, align 4
  %229 = mul i32 %width, %numChannels
  %230 = add i32 %2, 1
  %231 = mul i32 %229, %230
  %232 = add i32 %1, 1
  %233 = mul i32 %232, %numChannels
  %234 = add i32 %231, %233
  %235 = add i32 %234, 1
  %236 = getelementptr inbounds float addrspace(1)* %input, i32 %235
  %237 = load float addrspace(1)* %236, align 4
  %238 = mul i32 %width, %numChannels
  %239 = add i32 %2, 1
  %240 = mul i32 %238, %239
  %241 = add i32 %1, 1
  %242 = mul i32 %241, %numChannels
  %243 = add i32 %240, %242
  %244 = add i32 %243, 2
  %245 = getelementptr inbounds float addrspace(1)* %input, i32 %244
  %246 = load float addrspace(1)* %245, align 4
  %247 = call float @luminance(float %228, float %237, float %246)
  %248 = fadd float %63, %88
  %249 = fadd float %248, %116
  %250 = fadd float %249, %141
  %251 = fadd float %250, %166
  %252 = fadd float %251, %194
  %253 = fadd float %252, %219
  %254 = fadd float %253, %247
  %255 = fdiv float %254, 8.000000e+00, !fpmath !3
  br label %257

; <label>:256                                     ; preds = %32, %29, %27, %0
  br label %257

; <label>:257                                     ; preds = %256, %35
  %yLPattanaik.0 = phi float [ %255, %35 ], [ %24, %256 ]
  %258 = fdiv float %yLPattanaik.0, %24, !fpmath !3
  %259 = fadd float %delta, %258
  %260 = call float @llvm.log2.f32(float %259)
  %261 = fmul float %260, 0x3FE62E4300000000
  %262 = call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %261, float %25)
  %263 = fadd float %24, %262
  %264 = fdiv float %24, %263, !fpmath !3
  %265 = fdiv float %9, %24, !fpmath !3
  %266 = call float @llvm.pow.f32(float %265, float %gamma)
  %267 = fmul float %266, %264
  %268 = fdiv float %16, %24, !fpmath !3
  %269 = call float @llvm.pow.f32(float %268, float %gamma)
  %270 = fmul float %269, %264
  %271 = fdiv float %23, %24, !fpmath !3
  %272 = call float @llvm.pow.f32(float %271, float %gamma)
  %273 = fmul float %272, %264
  %274 = mul i32 %width, %numChannels
  %275 = mul i32 %274, %2
  %276 = mul i32 %1, %numChannels
  %277 = add i32 %276, 0
  %278 = add i32 %275, %277
  %279 = getelementptr inbounds float addrspace(1)* %output, i32 %278
  store float %267, float addrspace(1)* %279, align 4
  %280 = mul i32 %width, %numChannels
  %281 = mul i32 %280, %2
  %282 = mul i32 %1, %numChannels
  %283 = add i32 %282, 1
  %284 = add i32 %281, %283
  %285 = getelementptr inbounds float addrspace(1)* %output, i32 %284
  store float %270, float addrspace(1)* %285, align 4
  %286 = mul i32 %width, %numChannels
  %287 = mul i32 %286, %2
  %288 = mul i32 %1, %numChannels
  %289 = add i32 %288, 2
  %290 = add i32 %287, %289
  %291 = getelementptr inbounds float addrspace(1)* %output, i32 %290
  store float %273, float addrspace(1)* %291, align 4
  %292 = mul i32 %width, %numChannels
  %293 = mul i32 %292, %2
  %294 = mul i32 %1, %numChannels
  %295 = add i32 %294, 3
  %296 = add i32 %293, %295
  %297 = getelementptr inbounds float addrspace(1)* %input, i32 %296
  %298 = load float addrspace(1)* %297, align 4
  %299 = mul i32 %width, %numChannels
  %300 = mul i32 %299, %2
  %301 = mul i32 %1, %numChannels
  %302 = add i32 %301, 3
  %303 = add i32 %300, %302
  %304 = getelementptr inbounds float addrspace(1)* %output, i32 %303
  store float %298, float addrspace(1)* %304, align 4
  ret void
}

declare i32 @get_global_id(i32) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #3

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #3

; Function Attrs: nounwind
define void @toneMappingPattanaik(<4 x float> addrspace(1)* %input, <4 x float> addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_global_id(i32 1)
  %3 = mul i32 %width, %2
  %4 = add i32 %3, %1
  %5 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %4
  %6 = load <4 x float> addrspace(1)* %5, align 16
  %7 = extractelement <4 x float> %6, i32 0
  %8 = mul i32 %width, %2
  %9 = add i32 %8, %1
  %10 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %9
  %11 = load <4 x float> addrspace(1)* %10, align 16
  %12 = extractelement <4 x float> %11, i32 1
  %13 = mul i32 %width, %2
  %14 = add i32 %13, %1
  %15 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %14
  %16 = load <4 x float> addrspace(1)* %15, align 16
  %17 = extractelement <4 x float> %16, i32 2
  %18 = call float @luminance(float %7, float %12, float %17)
  %19 = fmul float %c, %averageLuminance
  %20 = icmp ne i32 %1, 0
  br i1 %20, label %21, label %202

; <label>:21                                      ; preds = %0
  %22 = icmp ne i32 %2, 0
  br i1 %22, label %23, label %202

; <label>:23                                      ; preds = %21
  %24 = sub i32 %width, 1
  %25 = icmp ne i32 %1, %24
  br i1 %25, label %26, label %202

; <label>:26                                      ; preds = %23
  %27 = sub i32 %height, 1
  %28 = icmp ne i32 %2, %27
  br i1 %28, label %29, label %202

; <label>:29                                      ; preds = %26
  %30 = sub i32 %2, 1
  %31 = mul i32 %width, %30
  %32 = add i32 %31, %1
  %33 = sub i32 %32, 1
  %34 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %33
  %35 = load <4 x float> addrspace(1)* %34, align 16
  %36 = extractelement <4 x float> %35, i32 0
  %37 = sub i32 %2, 1
  %38 = mul i32 %width, %37
  %39 = add i32 %38, %1
  %40 = sub i32 %39, 1
  %41 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %40
  %42 = load <4 x float> addrspace(1)* %41, align 16
  %43 = extractelement <4 x float> %42, i32 1
  %44 = sub i32 %2, 1
  %45 = mul i32 %width, %44
  %46 = add i32 %45, %1
  %47 = sub i32 %46, 1
  %48 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %47
  %49 = load <4 x float> addrspace(1)* %48, align 16
  %50 = extractelement <4 x float> %49, i32 2
  %51 = call float @luminance(float %36, float %43, float %50)
  %52 = sub i32 %2, 1
  %53 = mul i32 %width, %52
  %54 = add i32 %53, %1
  %55 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %54
  %56 = load <4 x float> addrspace(1)* %55, align 16
  %57 = extractelement <4 x float> %56, i32 0
  %58 = sub i32 %2, 1
  %59 = mul i32 %width, %58
  %60 = add i32 %59, %1
  %61 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %60
  %62 = load <4 x float> addrspace(1)* %61, align 16
  %63 = extractelement <4 x float> %62, i32 1
  %64 = sub i32 %2, 1
  %65 = mul i32 %width, %64
  %66 = add i32 %65, %1
  %67 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %66
  %68 = load <4 x float> addrspace(1)* %67, align 16
  %69 = extractelement <4 x float> %68, i32 2
  %70 = call float @luminance(float %57, float %63, float %69)
  %71 = sub i32 %2, 1
  %72 = mul i32 %width, %71
  %73 = add i32 %72, %1
  %74 = add i32 %73, 1
  %75 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %74
  %76 = load <4 x float> addrspace(1)* %75, align 16
  %77 = extractelement <4 x float> %76, i32 0
  %78 = sub i32 %2, 1
  %79 = mul i32 %width, %78
  %80 = add i32 %79, %1
  %81 = add i32 %80, 1
  %82 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %81
  %83 = load <4 x float> addrspace(1)* %82, align 16
  %84 = extractelement <4 x float> %83, i32 1
  %85 = sub i32 %2, 1
  %86 = mul i32 %width, %85
  %87 = add i32 %86, %1
  %88 = add i32 %87, 1
  %89 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %88
  %90 = load <4 x float> addrspace(1)* %89, align 16
  %91 = extractelement <4 x float> %90, i32 2
  %92 = call float @luminance(float %77, float %84, float %91)
  %93 = mul i32 %width, %2
  %94 = add i32 %93, %1
  %95 = sub i32 %94, 1
  %96 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %95
  %97 = load <4 x float> addrspace(1)* %96, align 16
  %98 = extractelement <4 x float> %97, i32 0
  %99 = mul i32 %width, %2
  %100 = add i32 %99, %1
  %101 = sub i32 %100, 1
  %102 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %101
  %103 = load <4 x float> addrspace(1)* %102, align 16
  %104 = extractelement <4 x float> %103, i32 1
  %105 = mul i32 %width, %2
  %106 = add i32 %105, %1
  %107 = sub i32 %106, 1
  %108 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %107
  %109 = load <4 x float> addrspace(1)* %108, align 16
  %110 = extractelement <4 x float> %109, i32 2
  %111 = call float @luminance(float %98, float %104, float %110)
  %112 = mul i32 %width, %2
  %113 = add i32 %112, %1
  %114 = add i32 %113, 1
  %115 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %114
  %116 = load <4 x float> addrspace(1)* %115, align 16
  %117 = extractelement <4 x float> %116, i32 0
  %118 = mul i32 %width, %2
  %119 = add i32 %118, %1
  %120 = add i32 %119, 1
  %121 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %120
  %122 = load <4 x float> addrspace(1)* %121, align 16
  %123 = extractelement <4 x float> %122, i32 1
  %124 = mul i32 %width, %2
  %125 = add i32 %124, %1
  %126 = add i32 %125, 1
  %127 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %126
  %128 = load <4 x float> addrspace(1)* %127, align 16
  %129 = extractelement <4 x float> %128, i32 2
  %130 = call float @luminance(float %117, float %123, float %129)
  %131 = add i32 %2, 1
  %132 = mul i32 %width, %131
  %133 = add i32 %132, %1
  %134 = sub i32 %133, 1
  %135 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %134
  %136 = load <4 x float> addrspace(1)* %135, align 16
  %137 = extractelement <4 x float> %136, i32 0
  %138 = add i32 %2, 1
  %139 = mul i32 %width, %138
  %140 = add i32 %139, %1
  %141 = sub i32 %140, 1
  %142 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %141
  %143 = load <4 x float> addrspace(1)* %142, align 16
  %144 = extractelement <4 x float> %143, i32 1
  %145 = add i32 %2, 1
  %146 = mul i32 %width, %145
  %147 = add i32 %146, %1
  %148 = sub i32 %147, 1
  %149 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %148
  %150 = load <4 x float> addrspace(1)* %149, align 16
  %151 = extractelement <4 x float> %150, i32 2
  %152 = call float @luminance(float %137, float %144, float %151)
  %153 = add i32 %2, 1
  %154 = mul i32 %width, %153
  %155 = add i32 %154, %1
  %156 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %155
  %157 = load <4 x float> addrspace(1)* %156, align 16
  %158 = extractelement <4 x float> %157, i32 0
  %159 = add i32 %2, 1
  %160 = mul i32 %width, %159
  %161 = add i32 %160, %1
  %162 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %161
  %163 = load <4 x float> addrspace(1)* %162, align 16
  %164 = extractelement <4 x float> %163, i32 1
  %165 = add i32 %2, 1
  %166 = mul i32 %width, %165
  %167 = add i32 %166, %1
  %168 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %167
  %169 = load <4 x float> addrspace(1)* %168, align 16
  %170 = extractelement <4 x float> %169, i32 2
  %171 = call float @luminance(float %158, float %164, float %170)
  %172 = add i32 %2, 1
  %173 = mul i32 %width, %172
  %174 = add i32 %173, %1
  %175 = add i32 %174, 1
  %176 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %175
  %177 = load <4 x float> addrspace(1)* %176, align 16
  %178 = extractelement <4 x float> %177, i32 0
  %179 = add i32 %2, 1
  %180 = mul i32 %width, %179
  %181 = add i32 %180, %1
  %182 = add i32 %181, 1
  %183 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %182
  %184 = load <4 x float> addrspace(1)* %183, align 16
  %185 = extractelement <4 x float> %184, i32 1
  %186 = add i32 %2, 1
  %187 = mul i32 %width, %186
  %188 = add i32 %187, %1
  %189 = add i32 %188, 1
  %190 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %189
  %191 = load <4 x float> addrspace(1)* %190, align 16
  %192 = extractelement <4 x float> %191, i32 2
  %193 = call float @luminance(float %178, float %185, float %192)
  %194 = fadd float %51, %70
  %195 = fadd float %194, %92
  %196 = fadd float %195, %111
  %197 = fadd float %196, %130
  %198 = fadd float %197, %152
  %199 = fadd float %198, %171
  %200 = fadd float %199, %193
  %201 = fdiv float %200, 8.000000e+00, !fpmath !3
  br label %203

; <label>:202                                     ; preds = %26, %23, %21, %0
  br label %203

; <label>:203                                     ; preds = %202, %29
  %yLPattanaik.0 = phi float [ %201, %29 ], [ %18, %202 ]
  %204 = fdiv float %yLPattanaik.0, %18, !fpmath !3
  %205 = fadd float %delta, %204
  %206 = call float @llvm.log2.f32(float %205)
  %207 = fmul float %206, 0x3FE62E4300000000
  %208 = call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %207, float %19)
  %209 = fadd float %18, %208
  %210 = fdiv float %18, %209, !fpmath !3
  %211 = fdiv float %7, %18, !fpmath !3
  %212 = call float @llvm.pow.f32(float %211, float %gamma)
  %213 = fmul float %212, %210
  %214 = fdiv float %12, %18, !fpmath !3
  %215 = call float @llvm.pow.f32(float %214, float %gamma)
  %216 = fmul float %215, %210
  %217 = fdiv float %17, %18, !fpmath !3
  %218 = call float @llvm.pow.f32(float %217, float %gamma)
  %219 = fmul float %218, %210
  %220 = mul i32 %width, %2
  %221 = add i32 %220, %1
  %222 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %221
  %223 = load <4 x float> addrspace(1)* %222, align 16
  %224 = insertelement <4 x float> %223, float %213, i32 0
  store <4 x float> %224, <4 x float> addrspace(1)* %222, align 16
  %225 = mul i32 %width, %2
  %226 = add i32 %225, %1
  %227 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %226
  %228 = load <4 x float> addrspace(1)* %227, align 16
  %229 = insertelement <4 x float> %228, float %216, i32 1
  store <4 x float> %229, <4 x float> addrspace(1)* %227, align 16
  %230 = mul i32 %width, %2
  %231 = add i32 %230, %1
  %232 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %231
  %233 = load <4 x float> addrspace(1)* %232, align 16
  %234 = insertelement <4 x float> %233, float %219, i32 2
  store <4 x float> %234, <4 x float> addrspace(1)* %232, align 16
  %235 = mul i32 %width, %2
  %236 = add i32 %235, %1
  %237 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %236
  %238 = load <4 x float> addrspace(1)* %237, align 16
  %239 = extractelement <4 x float> %238, i32 3
  %240 = mul i32 %width, %2
  %241 = add i32 %240, %1
  %242 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %241
  %243 = load <4 x float> addrspace(1)* %242, align 16
  %244 = insertelement <4 x float> %243, float %239, i32 3
  store <4 x float> %244, <4 x float> addrspace(1)* %242, align 16
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

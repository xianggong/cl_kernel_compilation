; ModuleID = '../kernel-src/MonteCarloAsianMultiGPU_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

%struct._MonteCalroAttrib = type { <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float>, <4 x float> }

; Function Attrs: nounwind
define void @lshift128(<4 x i32> %input, i32 %shift, <4 x i32>* nocapture %output) #0 {
  %1 = extractelement <4 x i32> %input, i32 0
  %2 = and i32 %shift, 31
  %3 = shl i32 %1, %2
  %4 = insertelement <4 x i32> undef, i32 %3, i32 0
  %5 = extractelement <4 x i32> %input, i32 1
  %6 = shl i32 %5, %2
  %7 = sub i32 0, %shift
  %8 = and i32 %7, 31
  %9 = lshr i32 %1, %8
  %10 = or i32 %6, %9
  %11 = insertelement <4 x i32> %4, i32 %10, i32 1
  %12 = extractelement <4 x i32> %input, i32 2
  %13 = shl i32 %12, %2
  %14 = lshr i32 %5, %8
  %15 = or i32 %13, %14
  %16 = insertelement <4 x i32> %11, i32 %15, i32 2
  %17 = extractelement <4 x i32> %input, i32 3
  %18 = shl i32 %17, %2
  %19 = lshr i32 %12, %8
  %20 = or i32 %18, %19
  %21 = insertelement <4 x i32> %16, i32 %20, i32 3
  store <4 x i32> %21, <4 x i32>* %output, align 16, !tbaa !7
  ret void
}

; Function Attrs: nounwind
define void @rshift128(<4 x i32> %input, i32 %shift, <4 x i32>* nocapture %output) #0 {
  %1 = extractelement <4 x i32> %input, i32 3
  %2 = and i32 %shift, 31
  %3 = lshr i32 %1, %2
  %4 = insertelement <4 x i32> undef, i32 %3, i32 3
  %5 = extractelement <4 x i32> %input, i32 2
  %6 = lshr i32 %5, %2
  %7 = sub i32 0, %shift
  %8 = and i32 %7, 31
  %9 = shl i32 %1, %8
  %10 = or i32 %6, %9
  %11 = insertelement <4 x i32> %4, i32 %10, i32 2
  %12 = extractelement <4 x i32> %input, i32 1
  %13 = lshr i32 %12, %2
  %14 = shl i32 %5, %8
  %15 = or i32 %13, %14
  %16 = insertelement <4 x i32> %11, i32 %15, i32 1
  %17 = extractelement <4 x i32> %input, i32 0
  %18 = lshr i32 %17, %2
  %19 = shl i32 %12, %8
  %20 = or i32 %18, %19
  %21 = insertelement <4 x i32> %16, i32 %20, i32 0
  store <4 x i32> %21, <4 x i32>* %output, align 16, !tbaa !7
  ret void
}

; Function Attrs: nounwind
define void @generateRand(<4 x i32> %seed, <4 x float>* nocapture %gaussianRand1, <4 x float>* nocapture %gaussianRand2, <4 x i32>* nocapture %nextRand) #0 {
  %1 = lshr <4 x i32> %seed, <i32 30, i32 30, i32 30, i32 30>
  %2 = xor <4 x i32> %1, %seed
  %3 = mul <4 x i32> %2, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %4 = add <4 x i32> %3, <i32 1, i32 1, i32 1, i32 1>
  %5 = lshr <4 x i32> %4, <i32 30, i32 30, i32 30, i32 30>
  %6 = xor <4 x i32> %4, %5
  %7 = mul <4 x i32> %6, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %8 = add <4 x i32> %7, <i32 2, i32 2, i32 2, i32 2>
  %9 = lshr <4 x i32> %8, <i32 30, i32 30, i32 30, i32 30>
  %10 = xor <4 x i32> %8, %9
  %11 = mul <4 x i32> %10, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %12 = add <4 x i32> %11, <i32 3, i32 3, i32 3, i32 3>
  %13 = lshr <4 x i32> %12, <i32 30, i32 30, i32 30, i32 30>
  %14 = xor <4 x i32> %12, %13
  %15 = mul <4 x i32> %14, <i32 1812433253, i32 1812433253, i32 1812433253, i32 1812433253>
  %16 = add <4 x i32> %15, <i32 4, i32 4, i32 4, i32 4>
  %17 = extractelement <4 x i32> %seed, i32 0
  %18 = shl i32 %17, 24
  %19 = extractelement <4 x i32> %seed, i32 1
  %20 = shl i32 %19, 24
  %21 = lshr i32 %17, 8
  %22 = or i32 %20, %21
  %23 = extractelement <4 x i32> %seed, i32 2
  %24 = shl i32 %23, 24
  %25 = lshr i32 %19, 8
  %26 = or i32 %24, %25
  %27 = extractelement <4 x i32> %seed, i32 3
  %28 = shl i32 %27, 24
  %29 = lshr i32 %23, 8
  %30 = or i32 %28, %29
  %31 = extractelement <4 x i32> %12, i32 3
  %32 = lshr i32 %31, 24
  %33 = extractelement <4 x i32> %12, i32 2
  %34 = lshr i32 %33, 24
  %35 = shl i32 %31, 8
  %36 = or i32 %34, %35
  %37 = extractelement <4 x i32> %12, i32 1
  %38 = lshr i32 %37, 24
  %39 = shl i32 %33, 8
  %40 = or i32 %38, %39
  %41 = extractelement <4 x i32> %12, i32 0
  %42 = lshr i32 %41, 24
  %43 = shl i32 %37, 8
  %44 = or i32 %42, %43
  %45 = xor i32 %18, %17
  %46 = extractelement <4 x i32> %8, i32 0
  %47 = lshr i32 %46, 13
  %48 = and i32 %47, 473087
  %49 = xor i32 %45, %48
  %50 = extractelement <4 x i32> %16, i32 0
  %51 = shl i32 %50, 15
  %52 = xor i32 %49, %51
  %53 = xor i32 %52, %44
  %54 = insertelement <4 x i32> undef, i32 %53, i32 0
  %55 = extractelement <4 x i32> %8, i32 1
  %56 = lshr i32 %55, 13
  %57 = and i32 %56, 475005
  %58 = extractelement <4 x i32> %16, i32 1
  %59 = shl i32 %58, 15
  %60 = xor i32 %57, %19
  %61 = xor i32 %60, %22
  %62 = xor i32 %61, %59
  %63 = xor i32 %62, %40
  %64 = insertelement <4 x i32> %54, i32 %63, i32 1
  %65 = extractelement <4 x i32> %8, i32 2
  %66 = lshr i32 %65, 13
  %67 = and i32 %66, 490365
  %68 = extractelement <4 x i32> %16, i32 2
  %69 = shl i32 %68, 15
  %70 = xor i32 %67, %23
  %71 = xor i32 %70, %26
  %72 = xor i32 %71, %69
  %73 = xor i32 %72, %36
  %74 = insertelement <4 x i32> %64, i32 %73, i32 2
  %75 = extractelement <4 x i32> %8, i32 3
  %76 = lshr i32 %75, 13
  %77 = and i32 %76, 523055
  %78 = extractelement <4 x i32> %16, i32 3
  %79 = shl i32 %78, 15
  %80 = xor i32 %77, %27
  %81 = xor i32 %80, %30
  %82 = xor i32 %81, %79
  %83 = xor i32 %82, %32
  %84 = insertelement <4 x i32> %74, i32 %83, i32 3
  %85 = extractelement <4 x i32> %4, i32 0
  %86 = shl i32 %85, 24
  %87 = extractelement <4 x i32> %4, i32 1
  %88 = shl i32 %87, 24
  %89 = lshr i32 %85, 8
  %90 = or i32 %88, %89
  %91 = extractelement <4 x i32> %4, i32 2
  %92 = shl i32 %91, 24
  %93 = lshr i32 %87, 8
  %94 = or i32 %92, %93
  %95 = extractelement <4 x i32> %4, i32 3
  %96 = shl i32 %95, 24
  %97 = lshr i32 %91, 8
  %98 = or i32 %96, %97
  %99 = extractelement <4 x i32> %16, i32 3
  %100 = lshr i32 %99, 24
  %101 = extractelement <4 x i32> %16, i32 2
  %102 = lshr i32 %101, 24
  %103 = shl i32 %99, 8
  %104 = or i32 %102, %103
  %105 = extractelement <4 x i32> %16, i32 1
  %106 = lshr i32 %105, 24
  %107 = shl i32 %101, 8
  %108 = or i32 %106, %107
  %109 = extractelement <4 x i32> %16, i32 0
  %110 = lshr i32 %109, 24
  %111 = shl i32 %105, 8
  %112 = or i32 %110, %111
  %113 = xor i32 %86, %85
  %114 = extractelement <4 x i32> %12, i32 0
  %115 = lshr i32 %114, 13
  %116 = and i32 %115, 473087
  %117 = xor i32 %113, %116
  %118 = shl i32 %53, 15
  %119 = xor i32 %117, %118
  %120 = xor i32 %119, %112
  %121 = insertelement <4 x i32> undef, i32 %120, i32 0
  %122 = extractelement <4 x i32> %12, i32 1
  %123 = lshr i32 %122, 13
  %124 = and i32 %123, 475005
  %125 = shl i32 %63, 15
  %126 = xor i32 %124, %87
  %127 = xor i32 %126, %90
  %128 = xor i32 %127, %125
  %129 = xor i32 %128, %108
  %130 = insertelement <4 x i32> %121, i32 %129, i32 1
  %131 = extractelement <4 x i32> %12, i32 2
  %132 = lshr i32 %131, 13
  %133 = and i32 %132, 490365
  %134 = shl i32 %73, 15
  %135 = xor i32 %133, %91
  %136 = xor i32 %135, %94
  %137 = xor i32 %136, %134
  %138 = xor i32 %137, %104
  %139 = insertelement <4 x i32> %130, i32 %138, i32 2
  %140 = extractelement <4 x i32> %12, i32 3
  %141 = lshr i32 %140, 13
  %142 = and i32 %141, 523055
  %143 = shl i32 %83, 15
  %144 = xor i32 %142, %95
  %145 = xor i32 %144, %98
  %146 = xor i32 %145, %143
  %147 = xor i32 %146, %100
  %148 = insertelement <4 x i32> %139, i32 %147, i32 3
  %149 = extractelement <4 x i32> %8, i32 0
  %150 = shl i32 %149, 24
  %151 = extractelement <4 x i32> %8, i32 1
  %152 = shl i32 %151, 24
  %153 = lshr i32 %149, 8
  %154 = or i32 %152, %153
  %155 = extractelement <4 x i32> %8, i32 2
  %156 = shl i32 %155, 24
  %157 = lshr i32 %151, 8
  %158 = or i32 %156, %157
  %159 = extractelement <4 x i32> %8, i32 3
  %160 = shl i32 %159, 24
  %161 = lshr i32 %155, 8
  %162 = or i32 %160, %161
  %163 = lshr i32 %82, 24
  %164 = lshr i32 %73, 24
  %165 = shl i32 %83, 8
  %166 = or i32 %164, %165
  %167 = lshr i32 %63, 24
  %168 = shl i32 %73, 8
  %169 = or i32 %167, %168
  %170 = lshr i32 %53, 24
  %171 = shl i32 %63, 8
  %172 = or i32 %170, %171
  %173 = xor i32 %150, %149
  %174 = extractelement <4 x i32> %16, i32 0
  %175 = lshr i32 %174, 13
  %176 = and i32 %175, 473087
  %177 = xor i32 %173, %176
  %178 = shl i32 %120, 15
  %179 = xor i32 %177, %178
  %180 = xor i32 %179, %172
  %181 = insertelement <4 x i32> undef, i32 %180, i32 0
  %182 = extractelement <4 x i32> %16, i32 1
  %183 = lshr i32 %182, 13
  %184 = and i32 %183, 475005
  %185 = shl i32 %129, 15
  %186 = xor i32 %184, %151
  %187 = xor i32 %186, %154
  %188 = xor i32 %187, %185
  %189 = xor i32 %188, %169
  %190 = insertelement <4 x i32> %181, i32 %189, i32 1
  %191 = extractelement <4 x i32> %16, i32 2
  %192 = lshr i32 %191, 13
  %193 = and i32 %192, 490365
  %194 = shl i32 %138, 15
  %195 = xor i32 %193, %155
  %196 = xor i32 %195, %158
  %197 = xor i32 %196, %194
  %198 = xor i32 %197, %166
  %199 = insertelement <4 x i32> %190, i32 %198, i32 2
  %200 = extractelement <4 x i32> %16, i32 3
  %201 = lshr i32 %200, 13
  %202 = and i32 %201, 523055
  %203 = shl i32 %147, 15
  %204 = xor i32 %202, %159
  %205 = xor i32 %204, %162
  %206 = xor i32 %205, %203
  %207 = xor i32 %206, %163
  %208 = insertelement <4 x i32> %199, i32 %207, i32 3
  %209 = tail call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %84) #3
  %210 = fdiv <4 x float> %209, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !10
  %211 = tail call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %148) #3
  %212 = fdiv <4 x float> %211, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !10
  %213 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %210)
  %214 = fmul <4 x float> %213, <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>
  %215 = fmul <4 x float> %214, <float -2.000000e+00, float -2.000000e+00, float -2.000000e+00, float -2.000000e+00>
  %216 = tail call <4 x float> @llvm.sqrt.v4f32(<4 x float> %215)
  %217 = fmul <4 x float> %212, <float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000, float 0x401921FB60000000>
  %218 = tail call <4 x float> @_Z3cosDv4_f(<4 x float> %217) #3
  %219 = fmul <4 x float> %216, %218
  store <4 x float> %219, <4 x float>* %gaussianRand1, align 16, !tbaa !7
  %220 = tail call <4 x float> @_Z3sinDv4_f(<4 x float> %217) #3
  %221 = fmul <4 x float> %216, %220
  store <4 x float> %221, <4 x float>* %gaussianRand2, align 16, !tbaa !7
  store <4 x i32> %208, <4 x i32>* %nextRand, align 16, !tbaa !7
  ret void
}

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #2

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #2

declare <4 x float> @_Z3cosDv4_f(<4 x float>) #1

declare <4 x float> @_Z3sinDv4_f(<4 x float>) #1

; Function Attrs: nounwind
define void @calOutputs(<4 x float> %strikePrice, <4 x float> %meanDeriv1, <4 x float> %meanDeriv2, <4 x float> %meanPrice1, <4 x float> %meanPrice2, <4 x float>* nocapture %pathDeriv1, <4 x float>* nocapture %pathDeriv2, <4 x float>* nocapture %priceVec1, <4 x float>* nocapture %priceVec2) #0 {
  %1 = fsub <4 x float> %meanPrice1, %strikePrice
  %2 = fsub <4 x float> %meanPrice2, %strikePrice
  %3 = extractelement <4 x float> %1, i32 0
  %4 = fcmp ogt float %3, 0.000000e+00
  br i1 %4, label %5, label %7

; <label>:5                                       ; preds = %0
  %6 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %1, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %7

; <label>:7                                       ; preds = %5, %0
  %temp3.0 = phi <4 x float> [ %6, %5 ], [ zeroinitializer, %0 ]
  %temp1.0 = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %5 ], [ zeroinitializer, %0 ]
  %8 = extractelement <4 x float> %1, i32 1
  %9 = fcmp ogt float %8, 0.000000e+00
  br i1 %9, label %10, label %13

; <label>:10                                      ; preds = %7
  %11 = insertelement <4 x float> %temp1.0, float 1.000000e+00, i32 1
  %12 = shufflevector <4 x float> %temp3.0, <4 x float> %1, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %13

; <label>:13                                      ; preds = %10, %7
  %temp3.1 = phi <4 x float> [ %12, %10 ], [ %temp3.0, %7 ]
  %temp1.1 = phi <4 x float> [ %11, %10 ], [ %temp1.0, %7 ]
  %14 = extractelement <4 x float> %1, i32 2
  %15 = fcmp ogt float %14, 0.000000e+00
  br i1 %15, label %16, label %19

; <label>:16                                      ; preds = %13
  %17 = insertelement <4 x float> %temp1.1, float 1.000000e+00, i32 2
  %18 = shufflevector <4 x float> %temp3.1, <4 x float> %1, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %19

; <label>:19                                      ; preds = %16, %13
  %temp3.2 = phi <4 x float> [ %18, %16 ], [ %temp3.1, %13 ]
  %temp1.2 = phi <4 x float> [ %17, %16 ], [ %temp1.1, %13 ]
  %20 = extractelement <4 x float> %1, i32 3
  %21 = fcmp ogt float %20, 0.000000e+00
  br i1 %21, label %22, label %25

; <label>:22                                      ; preds = %19
  %23 = insertelement <4 x float> %temp1.2, float 1.000000e+00, i32 3
  %24 = shufflevector <4 x float> %temp3.2, <4 x float> %1, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %25

; <label>:25                                      ; preds = %22, %19
  %temp3.3 = phi <4 x float> [ %24, %22 ], [ %temp3.2, %19 ]
  %temp1.3 = phi <4 x float> [ %23, %22 ], [ %temp1.2, %19 ]
  %26 = extractelement <4 x float> %2, i32 0
  %27 = fcmp ogt float %26, 0.000000e+00
  br i1 %27, label %28, label %30

; <label>:28                                      ; preds = %25
  %29 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %2, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %30

; <label>:30                                      ; preds = %28, %25
  %temp4.0 = phi <4 x float> [ %29, %28 ], [ zeroinitializer, %25 ]
  %temp2.0 = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %28 ], [ zeroinitializer, %25 ]
  %31 = extractelement <4 x float> %2, i32 1
  %32 = fcmp ogt float %31, 0.000000e+00
  br i1 %32, label %33, label %36

; <label>:33                                      ; preds = %30
  %34 = insertelement <4 x float> %temp2.0, float 1.000000e+00, i32 1
  %35 = shufflevector <4 x float> %temp4.0, <4 x float> %2, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %36

; <label>:36                                      ; preds = %33, %30
  %temp4.1 = phi <4 x float> [ %35, %33 ], [ %temp4.0, %30 ]
  %temp2.1 = phi <4 x float> [ %34, %33 ], [ %temp2.0, %30 ]
  %37 = extractelement <4 x float> %2, i32 2
  %38 = fcmp ogt float %37, 0.000000e+00
  br i1 %38, label %39, label %42

; <label>:39                                      ; preds = %36
  %40 = insertelement <4 x float> %temp2.1, float 1.000000e+00, i32 2
  %41 = shufflevector <4 x float> %temp4.1, <4 x float> %2, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %42

; <label>:42                                      ; preds = %39, %36
  %temp4.2 = phi <4 x float> [ %41, %39 ], [ %temp4.1, %36 ]
  %temp2.2 = phi <4 x float> [ %40, %39 ], [ %temp2.1, %36 ]
  %43 = extractelement <4 x float> %2, i32 3
  %44 = fcmp ogt float %43, 0.000000e+00
  br i1 %44, label %45, label %48

; <label>:45                                      ; preds = %42
  %46 = insertelement <4 x float> %temp2.2, float 1.000000e+00, i32 3
  %47 = shufflevector <4 x float> %temp4.2, <4 x float> %2, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %48

; <label>:48                                      ; preds = %45, %42
  %temp4.3 = phi <4 x float> [ %47, %45 ], [ %temp4.2, %42 ]
  %temp2.3 = phi <4 x float> [ %46, %45 ], [ %temp2.2, %42 ]
  %49 = fmul <4 x float> %temp1.3, %meanDeriv1
  store <4 x float> %49, <4 x float>* %pathDeriv1, align 16, !tbaa !7
  %50 = fmul <4 x float> %temp2.3, %meanDeriv2
  store <4 x float> %50, <4 x float>* %pathDeriv2, align 16, !tbaa !7
  store <4 x float> %temp3.3, <4 x float>* %priceVec1, align 16, !tbaa !7
  store <4 x float> %temp4.3, <4 x float>* %priceVec2, align 16, !tbaa !7
  ret void
}

; Function Attrs: nounwind
define void @calPriceVega(%struct._MonteCalroAttrib* byval nocapture readonly %attrib, i32 %noOfSum, i32 %width, <4 x i32> addrspace(1)* nocapture readonly %randArray, <4 x float> addrspace(1)* nocapture %priceSamples, <4 x float> addrspace(1)* nocapture %pathDeriv) #0 {
  %finalRandf1 = alloca <4 x float>, align 16
  %finalRandf2 = alloca <4 x float>, align 16
  %nextRand = alloca <4 x i32>, align 16
  %1 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 0
  %2 = load <4 x float>* %1, align 16, !tbaa !11
  %3 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 1
  %4 = load <4 x float>* %3, align 16, !tbaa !13
  %5 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 2
  %6 = load <4 x float>* %5, align 16, !tbaa !14
  %7 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 3
  %8 = load <4 x float>* %7, align 16, !tbaa !15
  %9 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 4
  %10 = load <4 x float>* %9, align 16, !tbaa !16
  %11 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 5
  %12 = load <4 x float>* %11, align 16, !tbaa !17
  %13 = getelementptr inbounds %struct._MonteCalroAttrib* %attrib, i32 0, i32 6
  %14 = load <4 x float>* %13, align 16, !tbaa !18
  %15 = tail call i32 @get_global_id(i32 0) #3
  %16 = tail call i32 @get_global_id(i32 1) #3
  store <4 x float> zeroinitializer, <4 x float>* %finalRandf1, align 16, !tbaa !7
  store <4 x float> zeroinitializer, <4 x float>* %finalRandf2, align 16, !tbaa !7
  %17 = mul i32 %16, %width
  %18 = add i32 %17, %15
  %19 = getelementptr inbounds <4 x i32> addrspace(1)* %randArray, i32 %18
  %20 = load <4 x i32> addrspace(1)* %19, align 16, !tbaa !7
  store <4 x i32> %20, <4 x i32>* %nextRand, align 16, !tbaa !7
  %21 = icmp sgt i32 %noOfSum, 1
  br i1 %21, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %22 = fmul <4 x float> %8, %14
  %23 = add i32 %noOfSum, -1
  br label %24

; <label>:24                                      ; preds = %._crit_edge14, %.lr.ph
  %25 = phi <4 x i32> [ %20, %.lr.ph ], [ %.pre, %._crit_edge14 ]
  %i.07 = phi i32 [ 1, %.lr.ph ], [ %51, %._crit_edge14 ]
  %sumDeriv2.06 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %50, %._crit_edge14 ]
  %sumDeriv1.05 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %45, %._crit_edge14 ]
  %sumPrice2.04 = phi <4 x float> [ %10, %.lr.ph ], [ %35, %._crit_edge14 ]
  %sumPrice1.03 = phi <4 x float> [ %10, %.lr.ph ], [ %34, %._crit_edge14 ]
  %trajPrice2.02 = phi <4 x float> [ %10, %.lr.ph ], [ %33, %._crit_edge14 ]
  %trajPrice1.01 = phi <4 x float> [ %10, %.lr.ph ], [ %29, %._crit_edge14 ]
  call void @generateRand(<4 x i32> %25, <4 x float>* %finalRandf1, <4 x float>* %finalRandf2, <4 x i32>* %nextRand)
  %26 = load <4 x float>* %finalRandf1, align 16, !tbaa !7
  %27 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %6, <4 x float> %26, <4 x float> %4)
  %28 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %27) #3
  %29 = fmul <4 x float> %trajPrice1.01, %28
  %30 = load <4 x float>* %finalRandf2, align 16, !tbaa !7
  %31 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %6, <4 x float> %30, <4 x float> %4)
  %32 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %31) #3
  %33 = fmul <4 x float> %trajPrice2.02, %32
  %34 = fadd <4 x float> %sumPrice1.03, %29
  %35 = fadd <4 x float> %sumPrice2.04, %33
  %36 = sitofp i32 %i.07 to float
  %37 = insertelement <4 x float> undef, float %36, i32 0
  %38 = shufflevector <4 x float> %37, <4 x float> undef, <4 x i32> zeroinitializer
  %39 = fmul <4 x float> %22, %38
  %40 = fdiv <4 x float> %29, %10, !fpmath !10
  %41 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %40)
  %42 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %39
  %43 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %41, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %42)
  %44 = fdiv <4 x float> %43, %12, !fpmath !10
  %45 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %29, <4 x float> %44, <4 x float> %sumDeriv1.05)
  %46 = fdiv <4 x float> %33, %10, !fpmath !10
  %47 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %46)
  %48 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %47, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %42)
  %49 = fdiv <4 x float> %48, %12, !fpmath !10
  %50 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %33, <4 x float> %49, <4 x float> %sumDeriv2.06)
  %exitcond = icmp eq i32 %i.07, %23
  br i1 %exitcond, label %._crit_edge.loopexit, label %._crit_edge14

._crit_edge14:                                    ; preds = %24
  %51 = add nuw nsw i32 %i.07, 1
  %.pre = load <4 x i32>* %nextRand, align 16, !tbaa !7
  br label %24

._crit_edge.loopexit:                             ; preds = %24
  %.lcssa20 = phi <4 x float> [ %50, %24 ]
  %.lcssa19 = phi <4 x float> [ %45, %24 ]
  %.lcssa18 = phi <4 x float> [ %35, %24 ]
  %.lcssa = phi <4 x float> [ %34, %24 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %sumDeriv2.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %.lcssa20, %._crit_edge.loopexit ]
  %sumDeriv1.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %.lcssa19, %._crit_edge.loopexit ]
  %sumPrice2.0.lcssa = phi <4 x float> [ %10, %0 ], [ %.lcssa18, %._crit_edge.loopexit ]
  %sumPrice1.0.lcssa = phi <4 x float> [ %10, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %52 = sitofp i32 %noOfSum to float
  %53 = insertelement <4 x float> undef, float %52, i32 0
  %54 = shufflevector <4 x float> %53, <4 x float> undef, <4 x i32> zeroinitializer
  %55 = fdiv <4 x float> %sumPrice1.0.lcssa, %54, !fpmath !10
  %56 = fdiv <4 x float> %sumPrice2.0.lcssa, %54, !fpmath !10
  %57 = fdiv <4 x float> %sumDeriv1.0.lcssa, %54, !fpmath !10
  %58 = fdiv <4 x float> %sumDeriv2.0.lcssa, %54, !fpmath !10
  %59 = fsub <4 x float> %55, %2
  %60 = fsub <4 x float> %56, %2
  %61 = extractelement <4 x float> %59, i32 0
  %62 = fcmp ogt float %61, 0.000000e+00
  br i1 %62, label %63, label %65

; <label>:63                                      ; preds = %._crit_edge
  %64 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %59, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %65

; <label>:65                                      ; preds = %63, %._crit_edge
  %temp3.0.i = phi <4 x float> [ %64, %63 ], [ zeroinitializer, %._crit_edge ]
  %temp1.0.i = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %63 ], [ zeroinitializer, %._crit_edge ]
  %66 = extractelement <4 x float> %59, i32 1
  %67 = fcmp ogt float %66, 0.000000e+00
  br i1 %67, label %68, label %71

; <label>:68                                      ; preds = %65
  %69 = insertelement <4 x float> %temp1.0.i, float 1.000000e+00, i32 1
  %70 = shufflevector <4 x float> %temp3.0.i, <4 x float> %59, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %71

; <label>:71                                      ; preds = %68, %65
  %temp3.1.i = phi <4 x float> [ %70, %68 ], [ %temp3.0.i, %65 ]
  %temp1.1.i = phi <4 x float> [ %69, %68 ], [ %temp1.0.i, %65 ]
  %72 = extractelement <4 x float> %59, i32 2
  %73 = fcmp ogt float %72, 0.000000e+00
  br i1 %73, label %74, label %77

; <label>:74                                      ; preds = %71
  %75 = insertelement <4 x float> %temp1.1.i, float 1.000000e+00, i32 2
  %76 = shufflevector <4 x float> %temp3.1.i, <4 x float> %59, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %77

; <label>:77                                      ; preds = %74, %71
  %temp3.2.i = phi <4 x float> [ %76, %74 ], [ %temp3.1.i, %71 ]
  %temp1.2.i = phi <4 x float> [ %75, %74 ], [ %temp1.1.i, %71 ]
  %78 = extractelement <4 x float> %59, i32 3
  %79 = fcmp ogt float %78, 0.000000e+00
  br i1 %79, label %80, label %83

; <label>:80                                      ; preds = %77
  %81 = insertelement <4 x float> %temp1.2.i, float 1.000000e+00, i32 3
  %82 = shufflevector <4 x float> %temp3.2.i, <4 x float> %59, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %83

; <label>:83                                      ; preds = %80, %77
  %temp3.3.i = phi <4 x float> [ %82, %80 ], [ %temp3.2.i, %77 ]
  %temp1.3.i = phi <4 x float> [ %81, %80 ], [ %temp1.2.i, %77 ]
  %84 = extractelement <4 x float> %60, i32 0
  %85 = fcmp ogt float %84, 0.000000e+00
  br i1 %85, label %86, label %88

; <label>:86                                      ; preds = %83
  %87 = shufflevector <4 x float> <float 0.000000e+00, float undef, float undef, float undef>, <4 x float> %60, <4 x i32> <i32 4, i32 0, i32 0, i32 0>
  br label %88

; <label>:88                                      ; preds = %86, %83
  %temp4.0.i = phi <4 x float> [ %87, %86 ], [ zeroinitializer, %83 ]
  %temp2.0.i = phi <4 x float> [ <float 1.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, %86 ], [ zeroinitializer, %83 ]
  %89 = extractelement <4 x float> %60, i32 1
  %90 = fcmp ogt float %89, 0.000000e+00
  br i1 %90, label %91, label %94

; <label>:91                                      ; preds = %88
  %92 = insertelement <4 x float> %temp2.0.i, float 1.000000e+00, i32 1
  %93 = shufflevector <4 x float> %temp4.0.i, <4 x float> %60, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  br label %94

; <label>:94                                      ; preds = %91, %88
  %temp4.1.i = phi <4 x float> [ %93, %91 ], [ %temp4.0.i, %88 ]
  %temp2.1.i = phi <4 x float> [ %92, %91 ], [ %temp2.0.i, %88 ]
  %95 = extractelement <4 x float> %60, i32 2
  %96 = fcmp ogt float %95, 0.000000e+00
  br i1 %96, label %97, label %100

; <label>:97                                      ; preds = %94
  %98 = insertelement <4 x float> %temp2.1.i, float 1.000000e+00, i32 2
  %99 = shufflevector <4 x float> %temp4.1.i, <4 x float> %60, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  br label %100

; <label>:100                                     ; preds = %97, %94
  %temp4.2.i = phi <4 x float> [ %99, %97 ], [ %temp4.1.i, %94 ]
  %temp2.2.i = phi <4 x float> [ %98, %97 ], [ %temp2.1.i, %94 ]
  %101 = extractelement <4 x float> %60, i32 3
  %102 = fcmp ogt float %101, 0.000000e+00
  br i1 %102, label %103, label %calOutputs.exit

; <label>:103                                     ; preds = %100
  %104 = insertelement <4 x float> %temp2.2.i, float 1.000000e+00, i32 3
  %105 = shufflevector <4 x float> %temp4.2.i, <4 x float> %60, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  br label %calOutputs.exit

calOutputs.exit:                                  ; preds = %100, %103
  %temp4.3.i = phi <4 x float> [ %105, %103 ], [ %temp4.2.i, %100 ]
  %temp2.3.i = phi <4 x float> [ %104, %103 ], [ %temp2.2.i, %100 ]
  %106 = fmul <4 x float> %57, %temp1.3.i
  %107 = fmul <4 x float> %58, %temp2.3.i
  %108 = shl i32 %18, 1
  %109 = getelementptr inbounds <4 x float> addrspace(1)* %priceSamples, i32 %108
  store <4 x float> %temp3.3.i, <4 x float> addrspace(1)* %109, align 16, !tbaa !7
  %110 = or i32 %108, 1
  %111 = getelementptr inbounds <4 x float> addrspace(1)* %priceSamples, i32 %110
  store <4 x float> %temp4.3.i, <4 x float> addrspace(1)* %111, align 16, !tbaa !7
  %112 = getelementptr inbounds <4 x float> addrspace(1)* %pathDeriv, i32 %108
  store <4 x float> %106, <4 x float> addrspace(1)* %112, align 16, !tbaa !7
  %113 = getelementptr inbounds <4 x float> addrspace(1)* %pathDeriv, i32 %110
  store <4 x float> %107, <4 x float> addrspace(1)* %113, align 16, !tbaa !7
  ret void
}

declare i32 @get_global_id(i32) #1

declare <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (%struct._MonteCalroAttrib*, i32, i32, <4 x i32> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @calPriceVega, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 1, i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"MonteCarloAttrib", !"int", !"int", !"uint4*", !"float4*", !"float4*"}
!4 = !{!"kernel_arg_base_type", !"struct _MonteCalroAttrib", !"int", !"int", !"uint __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{float 2.500000e+00}
!11 = !{!12, !8, i64 0}
!12 = !{!"_MonteCalroAttrib", !8, i64 0, !8, i64 16, !8, i64 32, !8, i64 48, !8, i64 64, !8, i64 80, !8, i64 96}
!13 = !{!12, !8, i64 16}
!14 = !{!12, !8, i64 32}
!15 = !{!12, !8, i64 48}
!16 = !{!12, !8, i64 64}
!17 = !{!12, !8, i64 80}
!18 = !{!12, !8, i64 96}

; ModuleID = 'HDRToneMapping_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc75 float @luminance(float %r, float %g, float %b) #0 {
entry:
  %mul1 = fmul float 0x3FE6E2EB20000000, %g
  %0 = call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %r, float %mul1)
  %1 = call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %b, float %0)
  ret float %1
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_toneMappingPattanaik1_kernel(float addrspace(1)* %input, float addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %mul = mul i32 %width, %numChannels
  %mul3 = mul i32 %mul, %conv2
  %mul4 = mul i32 %conv, %numChannels
  %add = add i32 %mul4, 0
  %add5 = add i32 %mul3, %add
  %idxprom = zext i32 %add5 to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom
  %0 = load float addrspace(1)* %arrayidx, align 4
  %mul6 = mul i32 %width, %numChannels
  %mul7 = mul i32 %mul6, %conv2
  %mul8 = mul i32 %conv, %numChannels
  %add9 = add i32 %mul8, 1
  %add10 = add i32 %mul7, %add9
  %idxprom11 = zext i32 %add10 to i64
  %arrayidx12 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom11
  %1 = load float addrspace(1)* %arrayidx12, align 4
  %mul13 = mul i32 %width, %numChannels
  %mul14 = mul i32 %mul13, %conv2
  %mul15 = mul i32 %conv, %numChannels
  %add16 = add i32 %mul15, 2
  %add17 = add i32 %mul14, %add16
  %idxprom18 = zext i32 %add17 to i64
  %arrayidx19 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom18
  %2 = load float addrspace(1)* %arrayidx19, align 4
  %call20 = call cc75 float @luminance(float %0, float %1, float %2)
  %mul21 = fmul float %c, %averageLuminance
  %cmp = icmp ne i32 %conv, 0
  br i1 %cmp, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %entry
  %cmp23 = icmp ne i32 %conv2, 0
  br i1 %cmp23, label %land.lhs.true25, label %if.else

land.lhs.true25:                                  ; preds = %land.lhs.true
  %sub = sub i32 %width, 1
  %cmp26 = icmp ne i32 %conv, %sub
  br i1 %cmp26, label %land.lhs.true28, label %if.else

land.lhs.true28:                                  ; preds = %land.lhs.true25
  %sub29 = sub i32 %height, 1
  %cmp30 = icmp ne i32 %conv2, %sub29
  br i1 %cmp30, label %if.then, label %if.else

if.then:                                          ; preds = %land.lhs.true28
  %mul32 = mul i32 %width, %numChannels
  %sub33 = sub i32 %conv2, 1
  %mul34 = mul i32 %mul32, %sub33
  %sub35 = sub i32 %conv, 1
  %mul36 = mul i32 %sub35, %numChannels
  %add37 = add i32 %mul34, %mul36
  %add38 = add i32 %add37, 0
  %idxprom39 = zext i32 %add38 to i64
  %arrayidx40 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom39
  %3 = load float addrspace(1)* %arrayidx40, align 4
  %mul41 = mul i32 %width, %numChannels
  %sub42 = sub i32 %conv2, 1
  %mul43 = mul i32 %mul41, %sub42
  %sub44 = sub i32 %conv, 1
  %mul45 = mul i32 %sub44, %numChannels
  %add46 = add i32 %mul43, %mul45
  %add47 = add i32 %add46, 1
  %idxprom48 = zext i32 %add47 to i64
  %arrayidx49 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom48
  %4 = load float addrspace(1)* %arrayidx49, align 4
  %mul50 = mul i32 %width, %numChannels
  %sub51 = sub i32 %conv2, 1
  %mul52 = mul i32 %mul50, %sub51
  %sub53 = sub i32 %conv, 1
  %mul54 = mul i32 %sub53, %numChannels
  %add55 = add i32 %mul52, %mul54
  %add56 = add i32 %add55, 2
  %idxprom57 = zext i32 %add56 to i64
  %arrayidx58 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom57
  %5 = load float addrspace(1)* %arrayidx58, align 4
  %call59 = call cc75 float @luminance(float %3, float %4, float %5)
  %mul60 = mul i32 %width, %numChannels
  %sub61 = sub i32 %conv2, 1
  %mul62 = mul i32 %mul60, %sub61
  %mul63 = mul i32 %conv, %numChannels
  %add64 = add i32 %mul62, %mul63
  %add65 = add i32 %add64, 0
  %idxprom66 = zext i32 %add65 to i64
  %arrayidx67 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom66
  %6 = load float addrspace(1)* %arrayidx67, align 4
  %mul68 = mul i32 %width, %numChannels
  %sub69 = sub i32 %conv2, 1
  %mul70 = mul i32 %mul68, %sub69
  %mul71 = mul i32 %conv, %numChannels
  %add72 = add i32 %mul70, %mul71
  %add73 = add i32 %add72, 1
  %idxprom74 = zext i32 %add73 to i64
  %arrayidx75 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom74
  %7 = load float addrspace(1)* %arrayidx75, align 4
  %mul76 = mul i32 %width, %numChannels
  %sub77 = sub i32 %conv2, 1
  %mul78 = mul i32 %mul76, %sub77
  %mul79 = mul i32 %conv, %numChannels
  %add80 = add i32 %mul78, %mul79
  %add81 = add i32 %add80, 2
  %idxprom82 = zext i32 %add81 to i64
  %arrayidx83 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom82
  %8 = load float addrspace(1)* %arrayidx83, align 4
  %call84 = call cc75 float @luminance(float %6, float %7, float %8)
  %mul85 = mul i32 %width, %numChannels
  %sub86 = sub i32 %conv2, 1
  %mul87 = mul i32 %mul85, %sub86
  %add88 = add i32 %conv, 1
  %mul89 = mul i32 %add88, %numChannels
  %add90 = add i32 %mul87, %mul89
  %add91 = add i32 %add90, 0
  %idxprom92 = zext i32 %add91 to i64
  %arrayidx93 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom92
  %9 = load float addrspace(1)* %arrayidx93, align 4
  %mul94 = mul i32 %width, %numChannels
  %sub95 = sub i32 %conv2, 1
  %mul96 = mul i32 %mul94, %sub95
  %add97 = add i32 %conv, 1
  %mul98 = mul i32 %add97, %numChannels
  %add99 = add i32 %mul96, %mul98
  %add100 = add i32 %add99, 1
  %idxprom101 = zext i32 %add100 to i64
  %arrayidx102 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom101
  %10 = load float addrspace(1)* %arrayidx102, align 4
  %mul103 = mul i32 %width, %numChannels
  %sub104 = sub i32 %conv2, 1
  %mul105 = mul i32 %mul103, %sub104
  %add106 = add i32 %conv, 1
  %mul107 = mul i32 %add106, %numChannels
  %add108 = add i32 %mul105, %mul107
  %add109 = add i32 %add108, 2
  %idxprom110 = zext i32 %add109 to i64
  %arrayidx111 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom110
  %11 = load float addrspace(1)* %arrayidx111, align 4
  %call112 = call cc75 float @luminance(float %9, float %10, float %11)
  %mul113 = mul i32 %width, %numChannels
  %mul114 = mul i32 %mul113, %conv2
  %sub115 = sub i32 %conv, 1
  %mul116 = mul i32 %sub115, %numChannels
  %add117 = add i32 %mul114, %mul116
  %add118 = add i32 %add117, 0
  %idxprom119 = zext i32 %add118 to i64
  %arrayidx120 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom119
  %12 = load float addrspace(1)* %arrayidx120, align 4
  %mul121 = mul i32 %width, %numChannels
  %mul122 = mul i32 %mul121, %conv2
  %sub123 = sub i32 %conv, 1
  %mul124 = mul i32 %sub123, %numChannels
  %add125 = add i32 %mul122, %mul124
  %add126 = add i32 %add125, 1
  %idxprom127 = zext i32 %add126 to i64
  %arrayidx128 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom127
  %13 = load float addrspace(1)* %arrayidx128, align 4
  %mul129 = mul i32 %width, %numChannels
  %mul130 = mul i32 %mul129, %conv2
  %sub131 = sub i32 %conv, 1
  %mul132 = mul i32 %sub131, %numChannels
  %add133 = add i32 %mul130, %mul132
  %add134 = add i32 %add133, 2
  %idxprom135 = zext i32 %add134 to i64
  %arrayidx136 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom135
  %14 = load float addrspace(1)* %arrayidx136, align 4
  %call137 = call cc75 float @luminance(float %12, float %13, float %14)
  %mul138 = mul i32 %width, %numChannels
  %mul139 = mul i32 %mul138, %conv2
  %add140 = add i32 %conv, 1
  %mul141 = mul i32 %add140, %numChannels
  %add142 = add i32 %mul139, %mul141
  %add143 = add i32 %add142, 0
  %idxprom144 = zext i32 %add143 to i64
  %arrayidx145 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom144
  %15 = load float addrspace(1)* %arrayidx145, align 4
  %mul146 = mul i32 %width, %numChannels
  %mul147 = mul i32 %mul146, %conv2
  %add148 = add i32 %conv, 1
  %mul149 = mul i32 %add148, %numChannels
  %add150 = add i32 %mul147, %mul149
  %add151 = add i32 %add150, 1
  %idxprom152 = zext i32 %add151 to i64
  %arrayidx153 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom152
  %16 = load float addrspace(1)* %arrayidx153, align 4
  %mul154 = mul i32 %width, %numChannels
  %mul155 = mul i32 %mul154, %conv2
  %add156 = add i32 %conv, 1
  %mul157 = mul i32 %add156, %numChannels
  %add158 = add i32 %mul155, %mul157
  %add159 = add i32 %add158, 2
  %idxprom160 = zext i32 %add159 to i64
  %arrayidx161 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom160
  %17 = load float addrspace(1)* %arrayidx161, align 4
  %call162 = call cc75 float @luminance(float %15, float %16, float %17)
  %mul163 = mul i32 %width, %numChannels
  %add164 = add i32 %conv2, 1
  %mul165 = mul i32 %mul163, %add164
  %sub166 = sub i32 %conv, 1
  %mul167 = mul i32 %sub166, %numChannels
  %add168 = add i32 %mul165, %mul167
  %add169 = add i32 %add168, 0
  %idxprom170 = zext i32 %add169 to i64
  %arrayidx171 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom170
  %18 = load float addrspace(1)* %arrayidx171, align 4
  %mul172 = mul i32 %width, %numChannels
  %add173 = add i32 %conv2, 1
  %mul174 = mul i32 %mul172, %add173
  %sub175 = sub i32 %conv, 1
  %mul176 = mul i32 %sub175, %numChannels
  %add177 = add i32 %mul174, %mul176
  %add178 = add i32 %add177, 1
  %idxprom179 = zext i32 %add178 to i64
  %arrayidx180 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom179
  %19 = load float addrspace(1)* %arrayidx180, align 4
  %mul181 = mul i32 %width, %numChannels
  %add182 = add i32 %conv2, 1
  %mul183 = mul i32 %mul181, %add182
  %sub184 = sub i32 %conv, 1
  %mul185 = mul i32 %sub184, %numChannels
  %add186 = add i32 %mul183, %mul185
  %add187 = add i32 %add186, 2
  %idxprom188 = zext i32 %add187 to i64
  %arrayidx189 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom188
  %20 = load float addrspace(1)* %arrayidx189, align 4
  %call190 = call cc75 float @luminance(float %18, float %19, float %20)
  %mul191 = mul i32 %width, %numChannels
  %add192 = add i32 %conv2, 1
  %mul193 = mul i32 %mul191, %add192
  %mul194 = mul i32 %conv, %numChannels
  %add195 = add i32 %mul193, %mul194
  %add196 = add i32 %add195, 0
  %idxprom197 = zext i32 %add196 to i64
  %arrayidx198 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom197
  %21 = load float addrspace(1)* %arrayidx198, align 4
  %mul199 = mul i32 %width, %numChannels
  %add200 = add i32 %conv2, 1
  %mul201 = mul i32 %mul199, %add200
  %mul202 = mul i32 %conv, %numChannels
  %add203 = add i32 %mul201, %mul202
  %add204 = add i32 %add203, 1
  %idxprom205 = zext i32 %add204 to i64
  %arrayidx206 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom205
  %22 = load float addrspace(1)* %arrayidx206, align 4
  %mul207 = mul i32 %width, %numChannels
  %add208 = add i32 %conv2, 1
  %mul209 = mul i32 %mul207, %add208
  %mul210 = mul i32 %conv, %numChannels
  %add211 = add i32 %mul209, %mul210
  %add212 = add i32 %add211, 2
  %idxprom213 = zext i32 %add212 to i64
  %arrayidx214 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom213
  %23 = load float addrspace(1)* %arrayidx214, align 4
  %call215 = call cc75 float @luminance(float %21, float %22, float %23)
  %mul216 = mul i32 %width, %numChannels
  %add217 = add i32 %conv2, 1
  %mul218 = mul i32 %mul216, %add217
  %add219 = add i32 %conv, 1
  %mul220 = mul i32 %add219, %numChannels
  %add221 = add i32 %mul218, %mul220
  %add222 = add i32 %add221, 0
  %idxprom223 = zext i32 %add222 to i64
  %arrayidx224 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom223
  %24 = load float addrspace(1)* %arrayidx224, align 4
  %mul225 = mul i32 %width, %numChannels
  %add226 = add i32 %conv2, 1
  %mul227 = mul i32 %mul225, %add226
  %add228 = add i32 %conv, 1
  %mul229 = mul i32 %add228, %numChannels
  %add230 = add i32 %mul227, %mul229
  %add231 = add i32 %add230, 1
  %idxprom232 = zext i32 %add231 to i64
  %arrayidx233 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom232
  %25 = load float addrspace(1)* %arrayidx233, align 4
  %mul234 = mul i32 %width, %numChannels
  %add235 = add i32 %conv2, 1
  %mul236 = mul i32 %mul234, %add235
  %add237 = add i32 %conv, 1
  %mul238 = mul i32 %add237, %numChannels
  %add239 = add i32 %mul236, %mul238
  %add240 = add i32 %add239, 2
  %idxprom241 = zext i32 %add240 to i64
  %arrayidx242 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom241
  %26 = load float addrspace(1)* %arrayidx242, align 4
  %call243 = call cc75 float @luminance(float %24, float %25, float %26)
  %add244 = fadd float %call59, %call84
  %add245 = fadd float %add244, %call112
  %add246 = fadd float %add245, %call137
  %add247 = fadd float %add246, %call162
  %add248 = fadd float %add247, %call190
  %add249 = fadd float %add248, %call215
  %add250 = fadd float %add249, %call243
  %div = fdiv float %add250, 8.000000e+00, !fpmath !10
  br label %if.end

if.else:                                          ; preds = %land.lhs.true28, %land.lhs.true25, %land.lhs.true, %entry
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %yLPattanaik.0 = phi float [ %div, %if.then ], [ %call20, %if.else ]
  %div251 = fdiv float %yLPattanaik.0, %call20, !fpmath !10
  %add252 = fadd float %delta, %div251
  %call253 = call cc75 float @_Z3logf(float %add252) #1
  %27 = call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %call253, float %mul21)
  %add255 = fadd float %call20, %27
  %div256 = fdiv float %call20, %add255, !fpmath !10
  %div257 = fdiv float %0, %call20, !fpmath !10
  %call258 = call cc75 float @_Z3powff(float %div257, float %gamma) #1
  %mul259 = fmul float %call258, %div256
  %div260 = fdiv float %1, %call20, !fpmath !10
  %call261 = call cc75 float @_Z3powff(float %div260, float %gamma) #1
  %mul262 = fmul float %call261, %div256
  %div263 = fdiv float %2, %call20, !fpmath !10
  %call264 = call cc75 float @_Z3powff(float %div263, float %gamma) #1
  %mul265 = fmul float %call264, %div256
  %mul266 = mul i32 %width, %numChannels
  %mul267 = mul i32 %mul266, %conv2
  %mul268 = mul i32 %conv, %numChannels
  %add269 = add i32 %mul268, 0
  %add270 = add i32 %mul267, %add269
  %idxprom271 = zext i32 %add270 to i64
  %arrayidx272 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom271
  store float %mul259, float addrspace(1)* %arrayidx272, align 4
  %mul273 = mul i32 %width, %numChannels
  %mul274 = mul i32 %mul273, %conv2
  %mul275 = mul i32 %conv, %numChannels
  %add276 = add i32 %mul275, 1
  %add277 = add i32 %mul274, %add276
  %idxprom278 = zext i32 %add277 to i64
  %arrayidx279 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom278
  store float %mul262, float addrspace(1)* %arrayidx279, align 4
  %mul280 = mul i32 %width, %numChannels
  %mul281 = mul i32 %mul280, %conv2
  %mul282 = mul i32 %conv, %numChannels
  %add283 = add i32 %mul282, 2
  %add284 = add i32 %mul281, %add283
  %idxprom285 = zext i32 %add284 to i64
  %arrayidx286 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom285
  store float %mul265, float addrspace(1)* %arrayidx286, align 4
  %mul287 = mul i32 %width, %numChannels
  %mul288 = mul i32 %mul287, %conv2
  %mul289 = mul i32 %conv, %numChannels
  %add290 = add i32 %mul289, 3
  %add291 = add i32 %mul288, %add290
  %idxprom292 = zext i32 %add291 to i64
  %arrayidx293 = getelementptr inbounds float addrspace(1)* %input, i64 %idxprom292
  %28 = load float addrspace(1)* %arrayidx293, align 4
  %mul294 = mul i32 %width, %numChannels
  %mul295 = mul i32 %mul294, %conv2
  %mul296 = mul i32 %conv, %numChannels
  %add297 = add i32 %mul296, 3
  %add298 = add i32 %mul295, %add297
  %idxprom299 = zext i32 %add298 to i64
  %arrayidx300 = getelementptr inbounds float addrspace(1)* %output, i64 %idxprom299
  store float %28, float addrspace(1)* %arrayidx300, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3logf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3powff(float, float) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_toneMappingPattanaik_kernel(<4 x float> addrspace(1)* %input, <4 x float> addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %mul = mul i32 %width, %conv2
  %add = add i32 %mul, %conv
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom
  %0 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %1 = extractelement <4 x float> %0, i32 0
  %mul3 = mul i32 %width, %conv2
  %add4 = add i32 %mul3, %conv
  %idxprom5 = zext i32 %add4 to i64
  %arrayidx6 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom5
  %2 = load <4 x float> addrspace(1)* %arrayidx6, align 16
  %3 = extractelement <4 x float> %2, i32 1
  %mul7 = mul i32 %width, %conv2
  %add8 = add i32 %mul7, %conv
  %idxprom9 = zext i32 %add8 to i64
  %arrayidx10 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom9
  %4 = load <4 x float> addrspace(1)* %arrayidx10, align 16
  %5 = extractelement <4 x float> %4, i32 2
  %call11 = call cc75 float @luminance(float %1, float %3, float %5)
  %mul12 = fmul float %c, %averageLuminance
  %cmp = icmp ne i32 %conv, 0
  br i1 %cmp, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %entry
  %cmp14 = icmp ne i32 %conv2, 0
  br i1 %cmp14, label %land.lhs.true16, label %if.else

land.lhs.true16:                                  ; preds = %land.lhs.true
  %sub = sub i32 %width, 1
  %cmp17 = icmp ne i32 %conv, %sub
  br i1 %cmp17, label %land.lhs.true19, label %if.else

land.lhs.true19:                                  ; preds = %land.lhs.true16
  %sub20 = sub i32 %height, 1
  %cmp21 = icmp ne i32 %conv2, %sub20
  br i1 %cmp21, label %if.then, label %if.else

if.then:                                          ; preds = %land.lhs.true19
  %sub23 = sub i32 %conv2, 1
  %mul24 = mul i32 %width, %sub23
  %add25 = add i32 %mul24, %conv
  %sub26 = sub i32 %add25, 1
  %idxprom27 = zext i32 %sub26 to i64
  %arrayidx28 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom27
  %6 = load <4 x float> addrspace(1)* %arrayidx28, align 16
  %7 = extractelement <4 x float> %6, i32 0
  %sub29 = sub i32 %conv2, 1
  %mul30 = mul i32 %width, %sub29
  %add31 = add i32 %mul30, %conv
  %sub32 = sub i32 %add31, 1
  %idxprom33 = zext i32 %sub32 to i64
  %arrayidx34 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom33
  %8 = load <4 x float> addrspace(1)* %arrayidx34, align 16
  %9 = extractelement <4 x float> %8, i32 1
  %sub35 = sub i32 %conv2, 1
  %mul36 = mul i32 %width, %sub35
  %add37 = add i32 %mul36, %conv
  %sub38 = sub i32 %add37, 1
  %idxprom39 = zext i32 %sub38 to i64
  %arrayidx40 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom39
  %10 = load <4 x float> addrspace(1)* %arrayidx40, align 16
  %11 = extractelement <4 x float> %10, i32 2
  %call41 = call cc75 float @luminance(float %7, float %9, float %11)
  %sub42 = sub i32 %conv2, 1
  %mul43 = mul i32 %width, %sub42
  %add44 = add i32 %mul43, %conv
  %idxprom45 = zext i32 %add44 to i64
  %arrayidx46 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom45
  %12 = load <4 x float> addrspace(1)* %arrayidx46, align 16
  %13 = extractelement <4 x float> %12, i32 0
  %sub47 = sub i32 %conv2, 1
  %mul48 = mul i32 %width, %sub47
  %add49 = add i32 %mul48, %conv
  %idxprom50 = zext i32 %add49 to i64
  %arrayidx51 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom50
  %14 = load <4 x float> addrspace(1)* %arrayidx51, align 16
  %15 = extractelement <4 x float> %14, i32 1
  %sub52 = sub i32 %conv2, 1
  %mul53 = mul i32 %width, %sub52
  %add54 = add i32 %mul53, %conv
  %idxprom55 = zext i32 %add54 to i64
  %arrayidx56 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom55
  %16 = load <4 x float> addrspace(1)* %arrayidx56, align 16
  %17 = extractelement <4 x float> %16, i32 2
  %call57 = call cc75 float @luminance(float %13, float %15, float %17)
  %sub58 = sub i32 %conv2, 1
  %mul59 = mul i32 %width, %sub58
  %add60 = add i32 %mul59, %conv
  %add61 = add i32 %add60, 1
  %idxprom62 = zext i32 %add61 to i64
  %arrayidx63 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom62
  %18 = load <4 x float> addrspace(1)* %arrayidx63, align 16
  %19 = extractelement <4 x float> %18, i32 0
  %sub64 = sub i32 %conv2, 1
  %mul65 = mul i32 %width, %sub64
  %add66 = add i32 %mul65, %conv
  %add67 = add i32 %add66, 1
  %idxprom68 = zext i32 %add67 to i64
  %arrayidx69 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom68
  %20 = load <4 x float> addrspace(1)* %arrayidx69, align 16
  %21 = extractelement <4 x float> %20, i32 1
  %sub70 = sub i32 %conv2, 1
  %mul71 = mul i32 %width, %sub70
  %add72 = add i32 %mul71, %conv
  %add73 = add i32 %add72, 1
  %idxprom74 = zext i32 %add73 to i64
  %arrayidx75 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom74
  %22 = load <4 x float> addrspace(1)* %arrayidx75, align 16
  %23 = extractelement <4 x float> %22, i32 2
  %call76 = call cc75 float @luminance(float %19, float %21, float %23)
  %mul77 = mul i32 %width, %conv2
  %add78 = add i32 %mul77, %conv
  %sub79 = sub i32 %add78, 1
  %idxprom80 = zext i32 %sub79 to i64
  %arrayidx81 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom80
  %24 = load <4 x float> addrspace(1)* %arrayidx81, align 16
  %25 = extractelement <4 x float> %24, i32 0
  %mul82 = mul i32 %width, %conv2
  %add83 = add i32 %mul82, %conv
  %sub84 = sub i32 %add83, 1
  %idxprom85 = zext i32 %sub84 to i64
  %arrayidx86 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom85
  %26 = load <4 x float> addrspace(1)* %arrayidx86, align 16
  %27 = extractelement <4 x float> %26, i32 1
  %mul87 = mul i32 %width, %conv2
  %add88 = add i32 %mul87, %conv
  %sub89 = sub i32 %add88, 1
  %idxprom90 = zext i32 %sub89 to i64
  %arrayidx91 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom90
  %28 = load <4 x float> addrspace(1)* %arrayidx91, align 16
  %29 = extractelement <4 x float> %28, i32 2
  %call92 = call cc75 float @luminance(float %25, float %27, float %29)
  %mul93 = mul i32 %width, %conv2
  %add94 = add i32 %mul93, %conv
  %add95 = add i32 %add94, 1
  %idxprom96 = zext i32 %add95 to i64
  %arrayidx97 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom96
  %30 = load <4 x float> addrspace(1)* %arrayidx97, align 16
  %31 = extractelement <4 x float> %30, i32 0
  %mul98 = mul i32 %width, %conv2
  %add99 = add i32 %mul98, %conv
  %add100 = add i32 %add99, 1
  %idxprom101 = zext i32 %add100 to i64
  %arrayidx102 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom101
  %32 = load <4 x float> addrspace(1)* %arrayidx102, align 16
  %33 = extractelement <4 x float> %32, i32 1
  %mul103 = mul i32 %width, %conv2
  %add104 = add i32 %mul103, %conv
  %add105 = add i32 %add104, 1
  %idxprom106 = zext i32 %add105 to i64
  %arrayidx107 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom106
  %34 = load <4 x float> addrspace(1)* %arrayidx107, align 16
  %35 = extractelement <4 x float> %34, i32 2
  %call108 = call cc75 float @luminance(float %31, float %33, float %35)
  %add109 = add i32 %conv2, 1
  %mul110 = mul i32 %width, %add109
  %add111 = add i32 %mul110, %conv
  %sub112 = sub i32 %add111, 1
  %idxprom113 = zext i32 %sub112 to i64
  %arrayidx114 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom113
  %36 = load <4 x float> addrspace(1)* %arrayidx114, align 16
  %37 = extractelement <4 x float> %36, i32 0
  %add115 = add i32 %conv2, 1
  %mul116 = mul i32 %width, %add115
  %add117 = add i32 %mul116, %conv
  %sub118 = sub i32 %add117, 1
  %idxprom119 = zext i32 %sub118 to i64
  %arrayidx120 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom119
  %38 = load <4 x float> addrspace(1)* %arrayidx120, align 16
  %39 = extractelement <4 x float> %38, i32 1
  %add121 = add i32 %conv2, 1
  %mul122 = mul i32 %width, %add121
  %add123 = add i32 %mul122, %conv
  %sub124 = sub i32 %add123, 1
  %idxprom125 = zext i32 %sub124 to i64
  %arrayidx126 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom125
  %40 = load <4 x float> addrspace(1)* %arrayidx126, align 16
  %41 = extractelement <4 x float> %40, i32 2
  %call127 = call cc75 float @luminance(float %37, float %39, float %41)
  %add128 = add i32 %conv2, 1
  %mul129 = mul i32 %width, %add128
  %add130 = add i32 %mul129, %conv
  %idxprom131 = zext i32 %add130 to i64
  %arrayidx132 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom131
  %42 = load <4 x float> addrspace(1)* %arrayidx132, align 16
  %43 = extractelement <4 x float> %42, i32 0
  %add133 = add i32 %conv2, 1
  %mul134 = mul i32 %width, %add133
  %add135 = add i32 %mul134, %conv
  %idxprom136 = zext i32 %add135 to i64
  %arrayidx137 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom136
  %44 = load <4 x float> addrspace(1)* %arrayidx137, align 16
  %45 = extractelement <4 x float> %44, i32 1
  %add138 = add i32 %conv2, 1
  %mul139 = mul i32 %width, %add138
  %add140 = add i32 %mul139, %conv
  %idxprom141 = zext i32 %add140 to i64
  %arrayidx142 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom141
  %46 = load <4 x float> addrspace(1)* %arrayidx142, align 16
  %47 = extractelement <4 x float> %46, i32 2
  %call143 = call cc75 float @luminance(float %43, float %45, float %47)
  %add144 = add i32 %conv2, 1
  %mul145 = mul i32 %width, %add144
  %add146 = add i32 %mul145, %conv
  %add147 = add i32 %add146, 1
  %idxprom148 = zext i32 %add147 to i64
  %arrayidx149 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom148
  %48 = load <4 x float> addrspace(1)* %arrayidx149, align 16
  %49 = extractelement <4 x float> %48, i32 0
  %add150 = add i32 %conv2, 1
  %mul151 = mul i32 %width, %add150
  %add152 = add i32 %mul151, %conv
  %add153 = add i32 %add152, 1
  %idxprom154 = zext i32 %add153 to i64
  %arrayidx155 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom154
  %50 = load <4 x float> addrspace(1)* %arrayidx155, align 16
  %51 = extractelement <4 x float> %50, i32 1
  %add156 = add i32 %conv2, 1
  %mul157 = mul i32 %width, %add156
  %add158 = add i32 %mul157, %conv
  %add159 = add i32 %add158, 1
  %idxprom160 = zext i32 %add159 to i64
  %arrayidx161 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom160
  %52 = load <4 x float> addrspace(1)* %arrayidx161, align 16
  %53 = extractelement <4 x float> %52, i32 2
  %call162 = call cc75 float @luminance(float %49, float %51, float %53)
  %add163 = fadd float %call41, %call57
  %add164 = fadd float %add163, %call76
  %add165 = fadd float %add164, %call92
  %add166 = fadd float %add165, %call108
  %add167 = fadd float %add166, %call127
  %add168 = fadd float %add167, %call143
  %add169 = fadd float %add168, %call162
  %div = fdiv float %add169, 8.000000e+00, !fpmath !10
  br label %if.end

if.else:                                          ; preds = %land.lhs.true19, %land.lhs.true16, %land.lhs.true, %entry
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %yLPattanaik.0 = phi float [ %div, %if.then ], [ %call11, %if.else ]
  %div170 = fdiv float %yLPattanaik.0, %call11, !fpmath !10
  %add171 = fadd float %delta, %div170
  %call172 = call cc75 float @_Z3logf(float %add171) #1
  %54 = call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %call172, float %mul12)
  %add174 = fadd float %call11, %54
  %div175 = fdiv float %call11, %add174, !fpmath !10
  %div176 = fdiv float %1, %call11, !fpmath !10
  %call177 = call cc75 float @_Z3powff(float %div176, float %gamma) #1
  %mul178 = fmul float %call177, %div175
  %div179 = fdiv float %3, %call11, !fpmath !10
  %call180 = call cc75 float @_Z3powff(float %div179, float %gamma) #1
  %mul181 = fmul float %call180, %div175
  %div182 = fdiv float %5, %call11, !fpmath !10
  %call183 = call cc75 float @_Z3powff(float %div182, float %gamma) #1
  %mul184 = fmul float %call183, %div175
  %mul185 = mul i32 %width, %conv2
  %add186 = add i32 %mul185, %conv
  %idxprom187 = zext i32 %add186 to i64
  %arrayidx188 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %idxprom187
  %55 = load <4 x float> addrspace(1)* %arrayidx188, align 16
  %56 = insertelement <4 x float> %55, float %mul178, i32 0
  store <4 x float> %56, <4 x float> addrspace(1)* %arrayidx188, align 16
  %mul189 = mul i32 %width, %conv2
  %add190 = add i32 %mul189, %conv
  %idxprom191 = zext i32 %add190 to i64
  %arrayidx192 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %idxprom191
  %57 = load <4 x float> addrspace(1)* %arrayidx192, align 16
  %58 = insertelement <4 x float> %57, float %mul181, i32 1
  store <4 x float> %58, <4 x float> addrspace(1)* %arrayidx192, align 16
  %mul193 = mul i32 %width, %conv2
  %add194 = add i32 %mul193, %conv
  %idxprom195 = zext i32 %add194 to i64
  %arrayidx196 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %idxprom195
  %59 = load <4 x float> addrspace(1)* %arrayidx196, align 16
  %60 = insertelement <4 x float> %59, float %mul184, i32 2
  store <4 x float> %60, <4 x float> addrspace(1)* %arrayidx196, align 16
  %mul197 = mul i32 %width, %conv2
  %add198 = add i32 %mul197, %conv
  %idxprom199 = zext i32 %add198 to i64
  %arrayidx200 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %idxprom199
  %61 = load <4 x float> addrspace(1)* %arrayidx200, align 16
  %62 = extractelement <4 x float> %61, i32 3
  %mul201 = mul i32 %width, %conv2
  %add202 = add i32 %mul201, %conv
  %idxprom203 = zext i32 %add202 to i64
  %arrayidx204 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %idxprom203
  %63 = load <4 x float> addrspace(1)* %arrayidx204, align 16
  %64 = insertelement <4 x float> %63, float %62, i32 3
  store <4 x float> %64, <4 x float> addrspace(1)* %arrayidx204, align 16
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!9}
!opencl.spir.version = !{!9}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float, float, float, float, i32, i32, i32)* @__OpenCL_toneMappingPattanaik1_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, float, float, float, float, i32, i32, i32)* @__OpenCL_toneMappingPattanaik_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"float4*", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"uint", metadata !"uint", metadata !"uint"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"float4*", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"uint", metadata !"uint", metadata !"uint"}
!9 = metadata !{i32 1, i32 2}
!10 = metadata !{float 2.500000e+00}

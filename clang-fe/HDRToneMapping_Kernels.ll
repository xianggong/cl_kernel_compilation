; ModuleID = '../kernel-src/HDRToneMapping_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind readnone
define float @luminance(float %r, float %g, float %b) #0 {
entry:
  %mul1 = fmul float %g, 0x3FE6E2EB20000000
  %0 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %r, float %mul1)
  %1 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %b, float %0)
  ret float %1
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind
define void @toneMappingPattanaik1(float addrspace(1)* %input, float addrspace(1)* nocapture %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #2 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #5
  %call1 = tail call i32 @get_global_id(i32 1) #5
  %mul = mul i32 %numChannels, %width
  %mul2 = mul i32 %call1, %mul
  %mul3 = mul i32 %call, %numChannels
  %add4 = add i32 %mul2, %mul3
  %0 = sext i32 %add4 to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %input, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !3
  %add8 = add i32 %mul3, 1
  %add9 = add i32 %add8, %mul2
  %2 = sext i32 %add9 to i64
  %arrayidx10 = getelementptr inbounds float addrspace(1)* %input, i64 %2
  %3 = load float addrspace(1)* %arrayidx10, align 4, !tbaa !3
  %add14 = add i32 %mul3, 2
  %add15 = add i32 %add14, %mul2
  %4 = sext i32 %add15 to i64
  %arrayidx16 = getelementptr inbounds float addrspace(1)* %input, i64 %4
  %5 = load float addrspace(1)* %arrayidx16, align 4, !tbaa !3
  %mul1.i = fmul float %3, 0x3FE6E2EB20000000
  %6 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %1, float %mul1.i) #5
  %7 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %5, float %6) #5
  %mul18 = fmul float %averageLuminance, %c
  %notlhs = icmp eq i32 %call, 0
  %notrhs = icmp eq i32 %call1, 0
  %or.cond.not = or i1 %notrhs, %notlhs
  %sub = add i32 %width, -1
  %cmp21 = icmp eq i32 %call, %sub
  %or.cond495 = or i1 %or.cond.not, %cmp21
  %sub23 = add i32 %height, -1
  %cmp24 = icmp eq i32 %call1, %sub23
  %or.cond496 = or i1 %or.cond495, %cmp24
  br i1 %or.cond496, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %sub26 = add i32 %call1, -1
  %mul27 = mul i32 %sub26, %mul
  %sub28 = add i32 %call, -1
  %mul29 = mul i32 %sub28, %numChannels
  %add30 = add i32 %mul27, %mul29
  %8 = sext i32 %add30 to i64
  %arrayidx32 = getelementptr inbounds float addrspace(1)* %input, i64 %8
  %9 = load float addrspace(1)* %arrayidx32, align 4, !tbaa !3
  %add39 = add i32 %add30, 1
  %10 = sext i32 %add39 to i64
  %arrayidx40 = getelementptr inbounds float addrspace(1)* %input, i64 %10
  %11 = load float addrspace(1)* %arrayidx40, align 4, !tbaa !3
  %add47 = add i32 %add30, 2
  %12 = sext i32 %add47 to i64
  %arrayidx48 = getelementptr inbounds float addrspace(1)* %input, i64 %12
  %13 = load float addrspace(1)* %arrayidx48, align 4, !tbaa !3
  %mul1.i504 = fmul float %11, 0x3FE6E2EB20000000
  %14 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %9, float %mul1.i504) #5
  %15 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %13, float %14) #5
  %add54 = add i32 %mul27, %mul3
  %16 = sext i32 %add54 to i64
  %arrayidx56 = getelementptr inbounds float addrspace(1)* %input, i64 %16
  %17 = load float addrspace(1)* %arrayidx56, align 4, !tbaa !3
  %add62 = add i32 %add54, 1
  %18 = sext i32 %add62 to i64
  %arrayidx63 = getelementptr inbounds float addrspace(1)* %input, i64 %18
  %19 = load float addrspace(1)* %arrayidx63, align 4, !tbaa !3
  %add69 = add i32 %add54, 2
  %20 = sext i32 %add69 to i64
  %arrayidx70 = getelementptr inbounds float addrspace(1)* %input, i64 %20
  %21 = load float addrspace(1)* %arrayidx70, align 4, !tbaa !3
  %mul1.i503 = fmul float %19, 0x3FE6E2EB20000000
  %22 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %17, float %mul1.i503) #5
  %23 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %21, float %22) #5
  %add75 = add i32 %call, 1
  %mul76 = mul i32 %add75, %numChannels
  %add77 = add i32 %mul27, %mul76
  %24 = sext i32 %add77 to i64
  %arrayidx79 = getelementptr inbounds float addrspace(1)* %input, i64 %24
  %25 = load float addrspace(1)* %arrayidx79, align 4, !tbaa !3
  %add86 = add i32 %add77, 1
  %26 = sext i32 %add86 to i64
  %arrayidx87 = getelementptr inbounds float addrspace(1)* %input, i64 %26
  %27 = load float addrspace(1)* %arrayidx87, align 4, !tbaa !3
  %add94 = add i32 %add77, 2
  %28 = sext i32 %add94 to i64
  %arrayidx95 = getelementptr inbounds float addrspace(1)* %input, i64 %28
  %29 = load float addrspace(1)* %arrayidx95, align 4, !tbaa !3
  %mul1.i502 = fmul float %27, 0x3FE6E2EB20000000
  %30 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %25, float %mul1.i502) #5
  %31 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %29, float %30) #5
  %add101 = add i32 %mul2, %mul29
  %32 = sext i32 %add101 to i64
  %arrayidx103 = getelementptr inbounds float addrspace(1)* %input, i64 %32
  %33 = load float addrspace(1)* %arrayidx103, align 4, !tbaa !3
  %add109 = add i32 %add101, 1
  %34 = sext i32 %add109 to i64
  %arrayidx110 = getelementptr inbounds float addrspace(1)* %input, i64 %34
  %35 = load float addrspace(1)* %arrayidx110, align 4, !tbaa !3
  %add116 = add i32 %add101, 2
  %36 = sext i32 %add116 to i64
  %arrayidx117 = getelementptr inbounds float addrspace(1)* %input, i64 %36
  %37 = load float addrspace(1)* %arrayidx117, align 4, !tbaa !3
  %mul1.i501 = fmul float %35, 0x3FE6E2EB20000000
  %38 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %33, float %mul1.i501) #5
  %39 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %37, float %38) #5
  %add123 = add i32 %mul2, %mul76
  %40 = sext i32 %add123 to i64
  %arrayidx125 = getelementptr inbounds float addrspace(1)* %input, i64 %40
  %41 = load float addrspace(1)* %arrayidx125, align 4, !tbaa !3
  %add131 = add i32 %add123, 1
  %42 = sext i32 %add131 to i64
  %arrayidx132 = getelementptr inbounds float addrspace(1)* %input, i64 %42
  %43 = load float addrspace(1)* %arrayidx132, align 4, !tbaa !3
  %add138 = add i32 %add123, 2
  %44 = sext i32 %add138 to i64
  %arrayidx139 = getelementptr inbounds float addrspace(1)* %input, i64 %44
  %45 = load float addrspace(1)* %arrayidx139, align 4, !tbaa !3
  %mul1.i500 = fmul float %43, 0x3FE6E2EB20000000
  %46 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %41, float %mul1.i500) #5
  %47 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %45, float %46) #5
  %add142 = add i32 %call1, 1
  %mul143 = mul i32 %add142, %mul
  %add146 = add i32 %mul143, %mul29
  %48 = sext i32 %add146 to i64
  %arrayidx148 = getelementptr inbounds float addrspace(1)* %input, i64 %48
  %49 = load float addrspace(1)* %arrayidx148, align 4, !tbaa !3
  %add155 = add i32 %add146, 1
  %50 = sext i32 %add155 to i64
  %arrayidx156 = getelementptr inbounds float addrspace(1)* %input, i64 %50
  %51 = load float addrspace(1)* %arrayidx156, align 4, !tbaa !3
  %add163 = add i32 %add146, 2
  %52 = sext i32 %add163 to i64
  %arrayidx164 = getelementptr inbounds float addrspace(1)* %input, i64 %52
  %53 = load float addrspace(1)* %arrayidx164, align 4, !tbaa !3
  %mul1.i499 = fmul float %51, 0x3FE6E2EB20000000
  %54 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %49, float %mul1.i499) #5
  %55 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %53, float %54) #5
  %add170 = add i32 %mul143, %mul3
  %56 = sext i32 %add170 to i64
  %arrayidx172 = getelementptr inbounds float addrspace(1)* %input, i64 %56
  %57 = load float addrspace(1)* %arrayidx172, align 4, !tbaa !3
  %add178 = add i32 %add170, 1
  %58 = sext i32 %add178 to i64
  %arrayidx179 = getelementptr inbounds float addrspace(1)* %input, i64 %58
  %59 = load float addrspace(1)* %arrayidx179, align 4, !tbaa !3
  %add185 = add i32 %add170, 2
  %60 = sext i32 %add185 to i64
  %arrayidx186 = getelementptr inbounds float addrspace(1)* %input, i64 %60
  %61 = load float addrspace(1)* %arrayidx186, align 4, !tbaa !3
  %mul1.i498 = fmul float %59, 0x3FE6E2EB20000000
  %62 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %57, float %mul1.i498) #5
  %63 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %61, float %62) #5
  %add193 = add i32 %mul143, %mul76
  %64 = sext i32 %add193 to i64
  %arrayidx195 = getelementptr inbounds float addrspace(1)* %input, i64 %64
  %65 = load float addrspace(1)* %arrayidx195, align 4, !tbaa !3
  %add202 = add i32 %add193, 1
  %66 = sext i32 %add202 to i64
  %arrayidx203 = getelementptr inbounds float addrspace(1)* %input, i64 %66
  %67 = load float addrspace(1)* %arrayidx203, align 4, !tbaa !3
  %add210 = add i32 %add193, 2
  %68 = sext i32 %add210 to i64
  %arrayidx211 = getelementptr inbounds float addrspace(1)* %input, i64 %68
  %69 = load float addrspace(1)* %arrayidx211, align 4, !tbaa !3
  %mul1.i497 = fmul float %67, 0x3FE6E2EB20000000
  %70 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %65, float %mul1.i497) #5
  %71 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %69, float %70) #5
  %add213 = fadd float %15, %23
  %add214 = fadd float %add213, %31
  %add215 = fadd float %add214, %39
  %add216 = fadd float %add215, %47
  %add217 = fadd float %add216, %55
  %add218 = fadd float %add217, %63
  %add219 = fadd float %add218, %71
  %div = fmul float %add219, 1.250000e-01
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  %yLPattanaik.0 = phi float [ %div, %if.then ], [ %7, %entry ]
  %div220 = fdiv float %yLPattanaik.0, %7, !fpmath !7
  %add221 = fadd float %div220, %delta
  %call222 = tail call float @llvm.log2.f32(float %add221)
  %mul223 = fmul float %call222, 0x3FE62E4300000000
  %72 = tail call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %mul223, float %mul18)
  %add225 = fadd float %7, %72
  %div226 = fdiv float %7, %add225, !fpmath !7
  %div227 = fdiv float %1, %7, !fpmath !7
  %call228 = tail call float @llvm.pow.f32(float %div227, float %gamma)
  %mul229 = fmul float %div226, %call228
  %div230 = fdiv float %3, %7, !fpmath !7
  %call231 = tail call float @llvm.pow.f32(float %div230, float %gamma)
  %mul232 = fmul float %div226, %call231
  %div233 = fdiv float %5, %7, !fpmath !7
  %call234 = tail call float @llvm.pow.f32(float %div233, float %gamma)
  %mul235 = fmul float %div226, %call234
  %arrayidx241 = getelementptr inbounds float addrspace(1)* %output, i64 %0
  store float %mul229, float addrspace(1)* %arrayidx241, align 4, !tbaa !3
  %arrayidx247 = getelementptr inbounds float addrspace(1)* %output, i64 %2
  store float %mul232, float addrspace(1)* %arrayidx247, align 4, !tbaa !3
  %arrayidx253 = getelementptr inbounds float addrspace(1)* %output, i64 %4
  store float %mul235, float addrspace(1)* %arrayidx253, align 4, !tbaa !3
  %add257 = add i32 %mul3, 3
  %add258 = add i32 %add257, %mul2
  %73 = sext i32 %add258 to i64
  %arrayidx259 = getelementptr inbounds float addrspace(1)* %input, i64 %73
  %74 = load float addrspace(1)* %arrayidx259, align 4, !tbaa !3
  %arrayidx265 = getelementptr inbounds float addrspace(1)* %output, i64 %73
  store float %74, float addrspace(1)* %arrayidx265, align 4, !tbaa !3
  ret void
}

declare i32 @get_global_id(i32) #3

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #4

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #4

; Function Attrs: nounwind
define void @toneMappingPattanaik(<4 x float> addrspace(1)* nocapture readonly %input, <4 x float> addrspace(1)* nocapture %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #2 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #5
  %call1 = tail call i32 @get_global_id(i32 1) #5
  %mul = mul i32 %call1, %width
  %add = add i32 %mul, %call
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %0
  %1 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %2 = extractelement <4 x float> %1, i32 0
  %3 = extractelement <4 x float> %1, i32 1
  %4 = extractelement <4 x float> %1, i32 2
  %mul1.i = fmul float %3, 0x3FE6E2EB20000000
  %5 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %2, float %mul1.i) #5
  %6 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %4, float %5) #5
  %mul9 = fmul float %averageLuminance, %c
  %notlhs = icmp eq i32 %call, 0
  %notrhs = icmp eq i32 %call1, 0
  %or.cond.not = or i1 %notrhs, %notlhs
  %sub = add i32 %width, -1
  %cmp12 = icmp eq i32 %call, %sub
  %or.cond336 = or i1 %or.cond.not, %cmp12
  %sub14 = add i32 %height, -1
  %cmp15 = icmp eq i32 %call1, %sub14
  %or.cond337 = or i1 %or.cond336, %cmp15
  br i1 %or.cond337, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %sub16 = add i32 %call1, -1
  %mul17 = mul i32 %sub16, %width
  %add18 = add i32 %mul17, %call
  %sub19 = add i32 %add18, -1
  %7 = sext i32 %sub19 to i64
  %arrayidx20 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %7
  %8 = load <4 x float> addrspace(1)* %arrayidx20, align 16
  %9 = extractelement <4 x float> %8, i32 0
  %10 = extractelement <4 x float> %8, i32 1
  %11 = extractelement <4 x float> %8, i32 2
  %mul1.i345 = fmul float %10, 0x3FE6E2EB20000000
  %12 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %9, float %mul1.i345) #5
  %13 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %11, float %12) #5
  %14 = sext i32 %add18 to i64
  %arrayidx35 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %14
  %15 = load <4 x float> addrspace(1)* %arrayidx35, align 16
  %16 = extractelement <4 x float> %15, i32 0
  %17 = extractelement <4 x float> %15, i32 1
  %18 = extractelement <4 x float> %15, i32 2
  %mul1.i344 = fmul float %17, 0x3FE6E2EB20000000
  %19 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %16, float %mul1.i344) #5
  %20 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %18, float %19) #5
  %add48 = add i32 %add18, 1
  %21 = sext i32 %add48 to i64
  %arrayidx49 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %21
  %22 = load <4 x float> addrspace(1)* %arrayidx49, align 16
  %23 = extractelement <4 x float> %22, i32 0
  %24 = extractelement <4 x float> %22, i32 1
  %25 = extractelement <4 x float> %22, i32 2
  %mul1.i343 = fmul float %24, 0x3FE6E2EB20000000
  %26 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %23, float %mul1.i343) #5
  %27 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %25, float %26) #5
  %sub63 = add i32 %add, -1
  %28 = sext i32 %sub63 to i64
  %arrayidx64 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %28
  %29 = load <4 x float> addrspace(1)* %arrayidx64, align 16
  %30 = extractelement <4 x float> %29, i32 0
  %31 = extractelement <4 x float> %29, i32 1
  %32 = extractelement <4 x float> %29, i32 2
  %mul1.i342 = fmul float %31, 0x3FE6E2EB20000000
  %33 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %30, float %mul1.i342) #5
  %34 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %32, float %33) #5
  %add76 = add i32 %add, 1
  %35 = sext i32 %add76 to i64
  %arrayidx77 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %35
  %36 = load <4 x float> addrspace(1)* %arrayidx77, align 16
  %37 = extractelement <4 x float> %36, i32 0
  %38 = extractelement <4 x float> %36, i32 1
  %39 = extractelement <4 x float> %36, i32 2
  %mul1.i341 = fmul float %38, 0x3FE6E2EB20000000
  %40 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %37, float %mul1.i341) #5
  %41 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %39, float %40) #5
  %add87 = add i32 %call1, 1
  %mul88 = mul i32 %add87, %width
  %add89 = add i32 %mul88, %call
  %sub90 = add i32 %add89, -1
  %42 = sext i32 %sub90 to i64
  %arrayidx91 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %42
  %43 = load <4 x float> addrspace(1)* %arrayidx91, align 16
  %44 = extractelement <4 x float> %43, i32 0
  %45 = extractelement <4 x float> %43, i32 1
  %46 = extractelement <4 x float> %43, i32 2
  %mul1.i340 = fmul float %45, 0x3FE6E2EB20000000
  %47 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %44, float %mul1.i340) #5
  %48 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %46, float %47) #5
  %49 = sext i32 %add89 to i64
  %arrayidx106 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %49
  %50 = load <4 x float> addrspace(1)* %arrayidx106, align 16
  %51 = extractelement <4 x float> %50, i32 0
  %52 = extractelement <4 x float> %50, i32 1
  %53 = extractelement <4 x float> %50, i32 2
  %mul1.i339 = fmul float %52, 0x3FE6E2EB20000000
  %54 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %51, float %mul1.i339) #5
  %55 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %53, float %54) #5
  %add119 = add i32 %add89, 1
  %56 = sext i32 %add119 to i64
  %arrayidx120 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %56
  %57 = load <4 x float> addrspace(1)* %arrayidx120, align 16
  %58 = extractelement <4 x float> %57, i32 0
  %59 = extractelement <4 x float> %57, i32 1
  %60 = extractelement <4 x float> %57, i32 2
  %mul1.i338 = fmul float %59, 0x3FE6E2EB20000000
  %61 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %58, float %mul1.i338) #5
  %62 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %60, float %61) #5
  %add132 = fadd float %13, %20
  %add133 = fadd float %add132, %27
  %add134 = fadd float %add133, %34
  %add135 = fadd float %add134, %41
  %add136 = fadd float %add135, %48
  %add137 = fadd float %add136, %55
  %add138 = fadd float %add137, %62
  %div = fmul float %add138, 1.250000e-01
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  %yLPattanaik.0 = phi float [ %div, %if.then ], [ %6, %entry ]
  %div139 = fdiv float %yLPattanaik.0, %6, !fpmath !7
  %add140 = fadd float %div139, %delta
  %call141 = tail call float @llvm.log2.f32(float %add140)
  %mul142 = fmul float %call141, 0x3FE62E4300000000
  %63 = tail call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %mul142, float %mul9)
  %add144 = fadd float %6, %63
  %div145 = fdiv float %6, %add144, !fpmath !7
  %div146 = fdiv float %2, %6, !fpmath !7
  %call147 = tail call float @llvm.pow.f32(float %div146, float %gamma)
  %mul148 = fmul float %div145, %call147
  %div149 = fdiv float %3, %6, !fpmath !7
  %call150 = tail call float @llvm.pow.f32(float %div149, float %gamma)
  %mul151 = fmul float %div145, %call150
  %div152 = fdiv float %4, %6, !fpmath !7
  %call153 = tail call float @llvm.pow.f32(float %div152, float %gamma)
  %mul154 = fmul float %div145, %call153
  %arrayidx157 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %0
  %64 = load <4 x float> addrspace(1)* %arrayidx157, align 16
  %65 = insertelement <4 x float> %64, float %mul148, i32 0
  %66 = insertelement <4 x float> %65, float %mul151, i32 1
  %67 = insertelement <4 x float> %66, float %mul154, i32 2
  store <4 x float> %67, <4 x float> addrspace(1)* %arrayidx157, align 16
  %68 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %69 = shufflevector <4 x float> %67, <4 x float> %68, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  store <4 x float> %69, <4 x float> addrspace(1)* %arrayidx157, align 16
  ret void
}

attributes #0 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float, float, float, float, i32, i32, i32)* @toneMappingPattanaik1}
!1 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, float, float, float, float, i32, i32, i32)* @toneMappingPattanaik}
!2 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"float", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{float 2.500000e+00}

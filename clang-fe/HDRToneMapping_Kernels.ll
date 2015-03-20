; ModuleID = '../kernel-src/HDRToneMapping_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind readnone uwtable
define float @luminance(float %r, float %g, float %b) #0 {
  %1 = fmul float %g, 0x3FE6E2EB20000000
  %2 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %r, float %1)
  %3 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %b, float %2)
  ret float %3
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind uwtable
define void @toneMappingPattanaik1(float* %input, float* nocapture %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #2 {
  %1 = tail call i64 @get_global_id(i32 0) #5
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #5
  %4 = trunc i64 %3 to i32
  %5 = mul i32 %numChannels, %width
  %6 = mul i32 %4, %5
  %7 = mul i32 %2, %numChannels
  %8 = add i32 %6, %7
  %9 = zext i32 %8 to i64
  %10 = getelementptr inbounds float* %input, i64 %9
  %11 = load float* %10, align 4, !tbaa !3
  %12 = add i32 %7, 1
  %13 = add i32 %12, %6
  %14 = zext i32 %13 to i64
  %15 = getelementptr inbounds float* %input, i64 %14
  %16 = load float* %15, align 4, !tbaa !3
  %17 = add i32 %7, 2
  %18 = add i32 %17, %6
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds float* %input, i64 %19
  %21 = load float* %20, align 4, !tbaa !3
  %22 = fmul float %16, 0x3FE6E2EB20000000
  %23 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %11, float %22) #5
  %24 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %21, float %23) #5
  %25 = fmul float %averageLuminance, %c
  %notlhs = icmp eq i32 %2, 0
  %notrhs = icmp eq i32 %4, 0
  %or.cond.not = or i1 %notrhs, %notlhs
  %26 = add i32 %width, -1
  %27 = icmp eq i32 %2, %26
  %or.cond3 = or i1 %or.cond.not, %27
  %28 = add i32 %height, -1
  %29 = icmp eq i32 %4, %28
  %or.cond5 = or i1 %or.cond3, %29
  br i1 %or.cond5, label %167, label %30

; <label>:30                                      ; preds = %0
  %31 = add i32 %4, -1
  %32 = mul i32 %31, %5
  %33 = add i32 %2, -1
  %34 = mul i32 %33, %numChannels
  %35 = add i32 %32, %34
  %36 = zext i32 %35 to i64
  %37 = getelementptr inbounds float* %input, i64 %36
  %38 = load float* %37, align 4, !tbaa !3
  %39 = add i32 %35, 1
  %40 = zext i32 %39 to i64
  %41 = getelementptr inbounds float* %input, i64 %40
  %42 = load float* %41, align 4, !tbaa !3
  %43 = add i32 %35, 2
  %44 = zext i32 %43 to i64
  %45 = getelementptr inbounds float* %input, i64 %44
  %46 = load float* %45, align 4, !tbaa !3
  %47 = fmul float %42, 0x3FE6E2EB20000000
  %48 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %38, float %47) #5
  %49 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %46, float %48) #5
  %50 = add i32 %32, %7
  %51 = zext i32 %50 to i64
  %52 = getelementptr inbounds float* %input, i64 %51
  %53 = load float* %52, align 4, !tbaa !3
  %54 = add i32 %50, 1
  %55 = zext i32 %54 to i64
  %56 = getelementptr inbounds float* %input, i64 %55
  %57 = load float* %56, align 4, !tbaa !3
  %58 = add i32 %50, 2
  %59 = zext i32 %58 to i64
  %60 = getelementptr inbounds float* %input, i64 %59
  %61 = load float* %60, align 4, !tbaa !3
  %62 = fmul float %57, 0x3FE6E2EB20000000
  %63 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %53, float %62) #5
  %64 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %61, float %63) #5
  %65 = add i32 %2, 1
  %66 = mul i32 %65, %numChannels
  %67 = add i32 %32, %66
  %68 = zext i32 %67 to i64
  %69 = getelementptr inbounds float* %input, i64 %68
  %70 = load float* %69, align 4, !tbaa !3
  %71 = add i32 %67, 1
  %72 = zext i32 %71 to i64
  %73 = getelementptr inbounds float* %input, i64 %72
  %74 = load float* %73, align 4, !tbaa !3
  %75 = add i32 %67, 2
  %76 = zext i32 %75 to i64
  %77 = getelementptr inbounds float* %input, i64 %76
  %78 = load float* %77, align 4, !tbaa !3
  %79 = fmul float %74, 0x3FE6E2EB20000000
  %80 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %70, float %79) #5
  %81 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %78, float %80) #5
  %82 = add i32 %6, %34
  %83 = zext i32 %82 to i64
  %84 = getelementptr inbounds float* %input, i64 %83
  %85 = load float* %84, align 4, !tbaa !3
  %86 = add i32 %82, 1
  %87 = zext i32 %86 to i64
  %88 = getelementptr inbounds float* %input, i64 %87
  %89 = load float* %88, align 4, !tbaa !3
  %90 = add i32 %82, 2
  %91 = zext i32 %90 to i64
  %92 = getelementptr inbounds float* %input, i64 %91
  %93 = load float* %92, align 4, !tbaa !3
  %94 = fmul float %89, 0x3FE6E2EB20000000
  %95 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %85, float %94) #5
  %96 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %93, float %95) #5
  %97 = add i32 %6, %66
  %98 = zext i32 %97 to i64
  %99 = getelementptr inbounds float* %input, i64 %98
  %100 = load float* %99, align 4, !tbaa !3
  %101 = add i32 %97, 1
  %102 = zext i32 %101 to i64
  %103 = getelementptr inbounds float* %input, i64 %102
  %104 = load float* %103, align 4, !tbaa !3
  %105 = add i32 %97, 2
  %106 = zext i32 %105 to i64
  %107 = getelementptr inbounds float* %input, i64 %106
  %108 = load float* %107, align 4, !tbaa !3
  %109 = fmul float %104, 0x3FE6E2EB20000000
  %110 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %100, float %109) #5
  %111 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %108, float %110) #5
  %112 = add i32 %4, 1
  %113 = mul i32 %112, %5
  %114 = add i32 %113, %34
  %115 = zext i32 %114 to i64
  %116 = getelementptr inbounds float* %input, i64 %115
  %117 = load float* %116, align 4, !tbaa !3
  %118 = add i32 %114, 1
  %119 = zext i32 %118 to i64
  %120 = getelementptr inbounds float* %input, i64 %119
  %121 = load float* %120, align 4, !tbaa !3
  %122 = add i32 %114, 2
  %123 = zext i32 %122 to i64
  %124 = getelementptr inbounds float* %input, i64 %123
  %125 = load float* %124, align 4, !tbaa !3
  %126 = fmul float %121, 0x3FE6E2EB20000000
  %127 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %117, float %126) #5
  %128 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %125, float %127) #5
  %129 = add i32 %113, %7
  %130 = zext i32 %129 to i64
  %131 = getelementptr inbounds float* %input, i64 %130
  %132 = load float* %131, align 4, !tbaa !3
  %133 = add i32 %129, 1
  %134 = zext i32 %133 to i64
  %135 = getelementptr inbounds float* %input, i64 %134
  %136 = load float* %135, align 4, !tbaa !3
  %137 = add i32 %129, 2
  %138 = zext i32 %137 to i64
  %139 = getelementptr inbounds float* %input, i64 %138
  %140 = load float* %139, align 4, !tbaa !3
  %141 = fmul float %136, 0x3FE6E2EB20000000
  %142 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %132, float %141) #5
  %143 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %140, float %142) #5
  %144 = add i32 %113, %66
  %145 = zext i32 %144 to i64
  %146 = getelementptr inbounds float* %input, i64 %145
  %147 = load float* %146, align 4, !tbaa !3
  %148 = add i32 %144, 1
  %149 = zext i32 %148 to i64
  %150 = getelementptr inbounds float* %input, i64 %149
  %151 = load float* %150, align 4, !tbaa !3
  %152 = add i32 %144, 2
  %153 = zext i32 %152 to i64
  %154 = getelementptr inbounds float* %input, i64 %153
  %155 = load float* %154, align 4, !tbaa !3
  %156 = fmul float %151, 0x3FE6E2EB20000000
  %157 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %147, float %156) #5
  %158 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %155, float %157) #5
  %159 = fadd float %49, %64
  %160 = fadd float %159, %81
  %161 = fadd float %160, %96
  %162 = fadd float %161, %111
  %163 = fadd float %162, %128
  %164 = fadd float %163, %143
  %165 = fadd float %164, %158
  %166 = fmul float %165, 1.250000e-01
  br label %167

; <label>:167                                     ; preds = %0, %30
  %yLPattanaik.0 = phi float [ %166, %30 ], [ %24, %0 ]
  %168 = fdiv float %yLPattanaik.0, %24, !fpmath !7
  %169 = fadd float %168, %delta
  %170 = tail call float @llvm.log2.f32(float %169)
  %171 = fmul float %170, 0x3FE62E4300000000
  %172 = tail call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %171, float %25)
  %173 = fadd float %24, %172
  %174 = fdiv float %24, %173, !fpmath !7
  %175 = fdiv float %11, %24, !fpmath !7
  %176 = tail call float @llvm.pow.f32(float %175, float %gamma)
  %177 = fmul float %174, %176
  %178 = fdiv float %16, %24, !fpmath !7
  %179 = tail call float @llvm.pow.f32(float %178, float %gamma)
  %180 = fmul float %174, %179
  %181 = fdiv float %21, %24, !fpmath !7
  %182 = tail call float @llvm.pow.f32(float %181, float %gamma)
  %183 = fmul float %174, %182
  %184 = getelementptr inbounds float* %output, i64 %9
  store float %177, float* %184, align 4, !tbaa !3
  %185 = getelementptr inbounds float* %output, i64 %14
  store float %180, float* %185, align 4, !tbaa !3
  %186 = getelementptr inbounds float* %output, i64 %19
  store float %183, float* %186, align 4, !tbaa !3
  %187 = add i32 %7, 3
  %188 = add i32 %187, %6
  %189 = zext i32 %188 to i64
  %190 = getelementptr inbounds float* %input, i64 %189
  %191 = load float* %190, align 4, !tbaa !3
  %192 = getelementptr inbounds float* %output, i64 %189
  store float %191, float* %192, align 4, !tbaa !3
  ret void
}

declare i64 @get_global_id(i32) #3

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #4

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #4

; Function Attrs: nounwind uwtable
define void @toneMappingPattanaik(<4 x float>* nocapture readonly %input, <4 x float>* nocapture %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #2 {
  %1 = tail call i64 @get_global_id(i32 0) #5
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #5
  %4 = trunc i64 %3 to i32
  %5 = mul i32 %4, %width
  %6 = add i32 %5, %2
  %7 = zext i32 %6 to i64
  %8 = getelementptr inbounds <4 x float>* %input, i64 %7
  %9 = load <4 x float>* %8, align 16
  %10 = extractelement <4 x float> %9, i32 0
  %11 = extractelement <4 x float> %9, i32 1
  %12 = extractelement <4 x float> %9, i32 2
  %13 = fmul float %11, 0x3FE6E2EB20000000
  %14 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %10, float %13) #5
  %15 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %12, float %14) #5
  %16 = fmul float %averageLuminance, %c
  %notlhs = icmp eq i32 %2, 0
  %notrhs = icmp eq i32 %4, 0
  %or.cond.not = or i1 %notrhs, %notlhs
  %17 = add i32 %width, -1
  %18 = icmp eq i32 %2, %17
  %or.cond3 = or i1 %or.cond.not, %18
  %19 = add i32 %height, -1
  %20 = icmp eq i32 %4, %19
  %or.cond5 = or i1 %or.cond3, %20
  br i1 %or.cond5, label %114, label %21

; <label>:21                                      ; preds = %0
  %22 = add i32 %4, -1
  %23 = mul i32 %22, %width
  %24 = add i32 %23, %2
  %25 = add i32 %24, -1
  %26 = zext i32 %25 to i64
  %27 = getelementptr inbounds <4 x float>* %input, i64 %26
  %28 = load <4 x float>* %27, align 16
  %29 = extractelement <4 x float> %28, i32 0
  %30 = extractelement <4 x float> %28, i32 1
  %31 = extractelement <4 x float> %28, i32 2
  %32 = fmul float %30, 0x3FE6E2EB20000000
  %33 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %29, float %32) #5
  %34 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %31, float %33) #5
  %35 = zext i32 %24 to i64
  %36 = getelementptr inbounds <4 x float>* %input, i64 %35
  %37 = load <4 x float>* %36, align 16
  %38 = extractelement <4 x float> %37, i32 0
  %39 = extractelement <4 x float> %37, i32 1
  %40 = extractelement <4 x float> %37, i32 2
  %41 = fmul float %39, 0x3FE6E2EB20000000
  %42 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %38, float %41) #5
  %43 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %40, float %42) #5
  %44 = add i32 %24, 1
  %45 = zext i32 %44 to i64
  %46 = getelementptr inbounds <4 x float>* %input, i64 %45
  %47 = load <4 x float>* %46, align 16
  %48 = extractelement <4 x float> %47, i32 0
  %49 = extractelement <4 x float> %47, i32 1
  %50 = extractelement <4 x float> %47, i32 2
  %51 = fmul float %49, 0x3FE6E2EB20000000
  %52 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %48, float %51) #5
  %53 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %50, float %52) #5
  %54 = add i32 %6, -1
  %55 = zext i32 %54 to i64
  %56 = getelementptr inbounds <4 x float>* %input, i64 %55
  %57 = load <4 x float>* %56, align 16
  %58 = extractelement <4 x float> %57, i32 0
  %59 = extractelement <4 x float> %57, i32 1
  %60 = extractelement <4 x float> %57, i32 2
  %61 = fmul float %59, 0x3FE6E2EB20000000
  %62 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %58, float %61) #5
  %63 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %60, float %62) #5
  %64 = add i32 %6, 1
  %65 = zext i32 %64 to i64
  %66 = getelementptr inbounds <4 x float>* %input, i64 %65
  %67 = load <4 x float>* %66, align 16
  %68 = extractelement <4 x float> %67, i32 0
  %69 = extractelement <4 x float> %67, i32 1
  %70 = extractelement <4 x float> %67, i32 2
  %71 = fmul float %69, 0x3FE6E2EB20000000
  %72 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %68, float %71) #5
  %73 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %70, float %72) #5
  %74 = add i32 %4, 1
  %75 = mul i32 %74, %width
  %76 = add i32 %75, %2
  %77 = add i32 %76, -1
  %78 = zext i32 %77 to i64
  %79 = getelementptr inbounds <4 x float>* %input, i64 %78
  %80 = load <4 x float>* %79, align 16
  %81 = extractelement <4 x float> %80, i32 0
  %82 = extractelement <4 x float> %80, i32 1
  %83 = extractelement <4 x float> %80, i32 2
  %84 = fmul float %82, 0x3FE6E2EB20000000
  %85 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %81, float %84) #5
  %86 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %83, float %85) #5
  %87 = zext i32 %76 to i64
  %88 = getelementptr inbounds <4 x float>* %input, i64 %87
  %89 = load <4 x float>* %88, align 16
  %90 = extractelement <4 x float> %89, i32 0
  %91 = extractelement <4 x float> %89, i32 1
  %92 = extractelement <4 x float> %89, i32 2
  %93 = fmul float %91, 0x3FE6E2EB20000000
  %94 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %90, float %93) #5
  %95 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %92, float %94) #5
  %96 = add i32 %76, 1
  %97 = zext i32 %96 to i64
  %98 = getelementptr inbounds <4 x float>* %input, i64 %97
  %99 = load <4 x float>* %98, align 16
  %100 = extractelement <4 x float> %99, i32 0
  %101 = extractelement <4 x float> %99, i32 1
  %102 = extractelement <4 x float> %99, i32 2
  %103 = fmul float %101, 0x3FE6E2EB20000000
  %104 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %100, float %103) #5
  %105 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %102, float %104) #5
  %106 = fadd float %34, %43
  %107 = fadd float %106, %53
  %108 = fadd float %107, %63
  %109 = fadd float %108, %73
  %110 = fadd float %109, %86
  %111 = fadd float %110, %95
  %112 = fadd float %111, %105
  %113 = fmul float %112, 1.250000e-01
  br label %114

; <label>:114                                     ; preds = %0, %21
  %yLPattanaik.0 = phi float [ %113, %21 ], [ %15, %0 ]
  %115 = fdiv float %yLPattanaik.0, %15, !fpmath !7
  %116 = fadd float %115, %delta
  %117 = tail call float @llvm.log2.f32(float %116)
  %118 = fmul float %117, 0x3FE62E4300000000
  %119 = tail call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %118, float %16)
  %120 = fadd float %15, %119
  %121 = fdiv float %15, %120, !fpmath !7
  %122 = fdiv float %10, %15, !fpmath !7
  %123 = tail call float @llvm.pow.f32(float %122, float %gamma)
  %124 = fmul float %121, %123
  %125 = fdiv float %11, %15, !fpmath !7
  %126 = tail call float @llvm.pow.f32(float %125, float %gamma)
  %127 = fmul float %121, %126
  %128 = fdiv float %12, %15, !fpmath !7
  %129 = tail call float @llvm.pow.f32(float %128, float %gamma)
  %130 = fmul float %121, %129
  %131 = getelementptr inbounds <4 x float>* %output, i64 %7
  %132 = load <4 x float>* %131, align 16
  %133 = insertelement <4 x float> %132, float %124, i32 0
  %134 = insertelement <4 x float> %133, float %127, i32 1
  %135 = insertelement <4 x float> %134, float %130, i32 2
  store <4 x float> %135, <4 x float>* %131, align 16
  %136 = load <4 x float>* %8, align 16
  %137 = shufflevector <4 x float> %135, <4 x float> %136, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  store <4 x float> %137, <4 x float>* %131, align 16
  ret void
}

attributes #0 = { nounwind readnone uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float*, float*, float, float, float, float, i32, i32, i32)* @toneMappingPattanaik1}
!1 = metadata !{void (<4 x float>*, <4 x float>*, float, float, float, float, i32, i32, i32)* @toneMappingPattanaik}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"float", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{float 2.500000e+00}

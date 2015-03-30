; ModuleID = '../kernel-src/HDRToneMapping_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind readnone
define float @luminance(float %r, float %g, float %b) #0 {
  %1 = fmul float %g, 0x3FE6E2EB20000000
  %2 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %r, float %1)
  %3 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %b, float %2)
  ret float %3
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind
define void @toneMappingPattanaik1(float addrspace(1)* %input, float addrspace(1)* nocapture %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #2 {
  %1 = tail call i32 @get_global_id(i32 0) #5
  %2 = tail call i32 @get_global_id(i32 1) #5
  %3 = mul i32 %numChannels, %width
  %4 = mul i32 %2, %3
  %5 = mul i32 %1, %numChannels
  %6 = add i32 %4, %5
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds float addrspace(1)* %input, i64 %7
  %9 = load float addrspace(1)* %8, align 4, !tbaa !3
  %10 = add i32 %5, 1
  %11 = add i32 %10, %4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds float addrspace(1)* %input, i64 %12
  %14 = load float addrspace(1)* %13, align 4, !tbaa !3
  %15 = add i32 %5, 2
  %16 = add i32 %15, %4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds float addrspace(1)* %input, i64 %17
  %19 = load float addrspace(1)* %18, align 4, !tbaa !3
  %20 = fmul float %14, 0x3FE6E2EB20000000
  %21 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %9, float %20) #5
  %22 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %19, float %21) #5
  %23 = fmul float %averageLuminance, %c
  %notlhs = icmp eq i32 %1, 0
  %notrhs = icmp eq i32 %2, 0
  %or.cond.not = or i1 %notrhs, %notlhs
  %24 = add i32 %width, -1
  %25 = icmp eq i32 %1, %24
  %or.cond3 = or i1 %or.cond.not, %25
  %26 = add i32 %height, -1
  %27 = icmp eq i32 %2, %26
  %or.cond5 = or i1 %or.cond3, %27
  br i1 %or.cond5, label %165, label %28

; <label>:28                                      ; preds = %0
  %29 = add i32 %2, -1
  %30 = mul i32 %29, %3
  %31 = add i32 %1, -1
  %32 = mul i32 %31, %numChannels
  %33 = add i32 %30, %32
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds float addrspace(1)* %input, i64 %34
  %36 = load float addrspace(1)* %35, align 4, !tbaa !3
  %37 = add i32 %33, 1
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds float addrspace(1)* %input, i64 %38
  %40 = load float addrspace(1)* %39, align 4, !tbaa !3
  %41 = add i32 %33, 2
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds float addrspace(1)* %input, i64 %42
  %44 = load float addrspace(1)* %43, align 4, !tbaa !3
  %45 = fmul float %40, 0x3FE6E2EB20000000
  %46 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %36, float %45) #5
  %47 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %44, float %46) #5
  %48 = add i32 %30, %5
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds float addrspace(1)* %input, i64 %49
  %51 = load float addrspace(1)* %50, align 4, !tbaa !3
  %52 = add i32 %48, 1
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds float addrspace(1)* %input, i64 %53
  %55 = load float addrspace(1)* %54, align 4, !tbaa !3
  %56 = add i32 %48, 2
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds float addrspace(1)* %input, i64 %57
  %59 = load float addrspace(1)* %58, align 4, !tbaa !3
  %60 = fmul float %55, 0x3FE6E2EB20000000
  %61 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %51, float %60) #5
  %62 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %59, float %61) #5
  %63 = add i32 %1, 1
  %64 = mul i32 %63, %numChannels
  %65 = add i32 %30, %64
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds float addrspace(1)* %input, i64 %66
  %68 = load float addrspace(1)* %67, align 4, !tbaa !3
  %69 = add i32 %65, 1
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds float addrspace(1)* %input, i64 %70
  %72 = load float addrspace(1)* %71, align 4, !tbaa !3
  %73 = add i32 %65, 2
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds float addrspace(1)* %input, i64 %74
  %76 = load float addrspace(1)* %75, align 4, !tbaa !3
  %77 = fmul float %72, 0x3FE6E2EB20000000
  %78 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %68, float %77) #5
  %79 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %76, float %78) #5
  %80 = add i32 %4, %32
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds float addrspace(1)* %input, i64 %81
  %83 = load float addrspace(1)* %82, align 4, !tbaa !3
  %84 = add i32 %80, 1
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds float addrspace(1)* %input, i64 %85
  %87 = load float addrspace(1)* %86, align 4, !tbaa !3
  %88 = add i32 %80, 2
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds float addrspace(1)* %input, i64 %89
  %91 = load float addrspace(1)* %90, align 4, !tbaa !3
  %92 = fmul float %87, 0x3FE6E2EB20000000
  %93 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %83, float %92) #5
  %94 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %91, float %93) #5
  %95 = add i32 %4, %64
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds float addrspace(1)* %input, i64 %96
  %98 = load float addrspace(1)* %97, align 4, !tbaa !3
  %99 = add i32 %95, 1
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds float addrspace(1)* %input, i64 %100
  %102 = load float addrspace(1)* %101, align 4, !tbaa !3
  %103 = add i32 %95, 2
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds float addrspace(1)* %input, i64 %104
  %106 = load float addrspace(1)* %105, align 4, !tbaa !3
  %107 = fmul float %102, 0x3FE6E2EB20000000
  %108 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %98, float %107) #5
  %109 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %106, float %108) #5
  %110 = add i32 %2, 1
  %111 = mul i32 %110, %3
  %112 = add i32 %111, %32
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds float addrspace(1)* %input, i64 %113
  %115 = load float addrspace(1)* %114, align 4, !tbaa !3
  %116 = add i32 %112, 1
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds float addrspace(1)* %input, i64 %117
  %119 = load float addrspace(1)* %118, align 4, !tbaa !3
  %120 = add i32 %112, 2
  %121 = sext i32 %120 to i64
  %122 = getelementptr inbounds float addrspace(1)* %input, i64 %121
  %123 = load float addrspace(1)* %122, align 4, !tbaa !3
  %124 = fmul float %119, 0x3FE6E2EB20000000
  %125 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %115, float %124) #5
  %126 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %123, float %125) #5
  %127 = add i32 %111, %5
  %128 = sext i32 %127 to i64
  %129 = getelementptr inbounds float addrspace(1)* %input, i64 %128
  %130 = load float addrspace(1)* %129, align 4, !tbaa !3
  %131 = add i32 %127, 1
  %132 = sext i32 %131 to i64
  %133 = getelementptr inbounds float addrspace(1)* %input, i64 %132
  %134 = load float addrspace(1)* %133, align 4, !tbaa !3
  %135 = add i32 %127, 2
  %136 = sext i32 %135 to i64
  %137 = getelementptr inbounds float addrspace(1)* %input, i64 %136
  %138 = load float addrspace(1)* %137, align 4, !tbaa !3
  %139 = fmul float %134, 0x3FE6E2EB20000000
  %140 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %130, float %139) #5
  %141 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %138, float %140) #5
  %142 = add i32 %111, %64
  %143 = sext i32 %142 to i64
  %144 = getelementptr inbounds float addrspace(1)* %input, i64 %143
  %145 = load float addrspace(1)* %144, align 4, !tbaa !3
  %146 = add i32 %142, 1
  %147 = sext i32 %146 to i64
  %148 = getelementptr inbounds float addrspace(1)* %input, i64 %147
  %149 = load float addrspace(1)* %148, align 4, !tbaa !3
  %150 = add i32 %142, 2
  %151 = sext i32 %150 to i64
  %152 = getelementptr inbounds float addrspace(1)* %input, i64 %151
  %153 = load float addrspace(1)* %152, align 4, !tbaa !3
  %154 = fmul float %149, 0x3FE6E2EB20000000
  %155 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %145, float %154) #5
  %156 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %153, float %155) #5
  %157 = fadd float %47, %62
  %158 = fadd float %157, %79
  %159 = fadd float %158, %94
  %160 = fadd float %159, %109
  %161 = fadd float %160, %126
  %162 = fadd float %161, %141
  %163 = fadd float %162, %156
  %164 = fmul float %163, 1.250000e-01
  br label %165

; <label>:165                                     ; preds = %0, %28
  %yLPattanaik.0 = phi float [ %164, %28 ], [ %22, %0 ]
  %166 = fdiv float %yLPattanaik.0, %22, !fpmath !7
  %167 = fadd float %166, %delta
  %168 = tail call float @llvm.log2.f32(float %167)
  %169 = fmul float %168, 0x3FE62E4300000000
  %170 = tail call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %169, float %23)
  %171 = fadd float %22, %170
  %172 = fdiv float %22, %171, !fpmath !7
  %173 = fdiv float %9, %22, !fpmath !7
  %174 = tail call float @llvm.pow.f32(float %173, float %gamma)
  %175 = fmul float %172, %174
  %176 = fdiv float %14, %22, !fpmath !7
  %177 = tail call float @llvm.pow.f32(float %176, float %gamma)
  %178 = fmul float %172, %177
  %179 = fdiv float %19, %22, !fpmath !7
  %180 = tail call float @llvm.pow.f32(float %179, float %gamma)
  %181 = fmul float %172, %180
  %182 = getelementptr inbounds float addrspace(1)* %output, i64 %7
  store float %175, float addrspace(1)* %182, align 4, !tbaa !3
  %183 = getelementptr inbounds float addrspace(1)* %output, i64 %12
  store float %178, float addrspace(1)* %183, align 4, !tbaa !3
  %184 = getelementptr inbounds float addrspace(1)* %output, i64 %17
  store float %181, float addrspace(1)* %184, align 4, !tbaa !3
  %185 = add i32 %5, 3
  %186 = add i32 %185, %4
  %187 = sext i32 %186 to i64
  %188 = getelementptr inbounds float addrspace(1)* %input, i64 %187
  %189 = load float addrspace(1)* %188, align 4, !tbaa !3
  %190 = getelementptr inbounds float addrspace(1)* %output, i64 %187
  store float %189, float addrspace(1)* %190, align 4, !tbaa !3
  ret void
}

declare i32 @get_global_id(i32) #3

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #4

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #4

; Function Attrs: nounwind
define void @toneMappingPattanaik(<4 x float> addrspace(1)* nocapture readonly %input, <4 x float> addrspace(1)* nocapture %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #2 {
  %1 = tail call i32 @get_global_id(i32 0) #5
  %2 = tail call i32 @get_global_id(i32 1) #5
  %3 = mul i32 %2, %width
  %4 = add i32 %3, %1
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %5
  %7 = load <4 x float> addrspace(1)* %6, align 16
  %8 = extractelement <4 x float> %7, i32 0
  %9 = extractelement <4 x float> %7, i32 1
  %10 = extractelement <4 x float> %7, i32 2
  %11 = fmul float %9, 0x3FE6E2EB20000000
  %12 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %8, float %11) #5
  %13 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %10, float %12) #5
  %14 = fmul float %averageLuminance, %c
  %notlhs = icmp eq i32 %1, 0
  %notrhs = icmp eq i32 %2, 0
  %or.cond.not = or i1 %notrhs, %notlhs
  %15 = add i32 %width, -1
  %16 = icmp eq i32 %1, %15
  %or.cond3 = or i1 %or.cond.not, %16
  %17 = add i32 %height, -1
  %18 = icmp eq i32 %2, %17
  %or.cond5 = or i1 %or.cond3, %18
  br i1 %or.cond5, label %112, label %19

; <label>:19                                      ; preds = %0
  %20 = add i32 %2, -1
  %21 = mul i32 %20, %width
  %22 = add i32 %21, %1
  %23 = add i32 %22, -1
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %24
  %26 = load <4 x float> addrspace(1)* %25, align 16
  %27 = extractelement <4 x float> %26, i32 0
  %28 = extractelement <4 x float> %26, i32 1
  %29 = extractelement <4 x float> %26, i32 2
  %30 = fmul float %28, 0x3FE6E2EB20000000
  %31 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %27, float %30) #5
  %32 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %29, float %31) #5
  %33 = sext i32 %22 to i64
  %34 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %33
  %35 = load <4 x float> addrspace(1)* %34, align 16
  %36 = extractelement <4 x float> %35, i32 0
  %37 = extractelement <4 x float> %35, i32 1
  %38 = extractelement <4 x float> %35, i32 2
  %39 = fmul float %37, 0x3FE6E2EB20000000
  %40 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %36, float %39) #5
  %41 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %38, float %40) #5
  %42 = add i32 %22, 1
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %43
  %45 = load <4 x float> addrspace(1)* %44, align 16
  %46 = extractelement <4 x float> %45, i32 0
  %47 = extractelement <4 x float> %45, i32 1
  %48 = extractelement <4 x float> %45, i32 2
  %49 = fmul float %47, 0x3FE6E2EB20000000
  %50 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %46, float %49) #5
  %51 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %48, float %50) #5
  %52 = add i32 %4, -1
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %53
  %55 = load <4 x float> addrspace(1)* %54, align 16
  %56 = extractelement <4 x float> %55, i32 0
  %57 = extractelement <4 x float> %55, i32 1
  %58 = extractelement <4 x float> %55, i32 2
  %59 = fmul float %57, 0x3FE6E2EB20000000
  %60 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %56, float %59) #5
  %61 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %58, float %60) #5
  %62 = add i32 %4, 1
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %63
  %65 = load <4 x float> addrspace(1)* %64, align 16
  %66 = extractelement <4 x float> %65, i32 0
  %67 = extractelement <4 x float> %65, i32 1
  %68 = extractelement <4 x float> %65, i32 2
  %69 = fmul float %67, 0x3FE6E2EB20000000
  %70 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %66, float %69) #5
  %71 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %68, float %70) #5
  %72 = add i32 %2, 1
  %73 = mul i32 %72, %width
  %74 = add i32 %73, %1
  %75 = add i32 %74, -1
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %76
  %78 = load <4 x float> addrspace(1)* %77, align 16
  %79 = extractelement <4 x float> %78, i32 0
  %80 = extractelement <4 x float> %78, i32 1
  %81 = extractelement <4 x float> %78, i32 2
  %82 = fmul float %80, 0x3FE6E2EB20000000
  %83 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %79, float %82) #5
  %84 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %81, float %83) #5
  %85 = sext i32 %74 to i64
  %86 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %85
  %87 = load <4 x float> addrspace(1)* %86, align 16
  %88 = extractelement <4 x float> %87, i32 0
  %89 = extractelement <4 x float> %87, i32 1
  %90 = extractelement <4 x float> %87, i32 2
  %91 = fmul float %89, 0x3FE6E2EB20000000
  %92 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %88, float %91) #5
  %93 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %90, float %92) #5
  %94 = add i32 %74, 1
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %95
  %97 = load <4 x float> addrspace(1)* %96, align 16
  %98 = extractelement <4 x float> %97, i32 0
  %99 = extractelement <4 x float> %97, i32 1
  %100 = extractelement <4 x float> %97, i32 2
  %101 = fmul float %99, 0x3FE6E2EB20000000
  %102 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %98, float %101) #5
  %103 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %100, float %102) #5
  %104 = fadd float %32, %41
  %105 = fadd float %104, %51
  %106 = fadd float %105, %61
  %107 = fadd float %106, %71
  %108 = fadd float %107, %84
  %109 = fadd float %108, %93
  %110 = fadd float %109, %103
  %111 = fmul float %110, 1.250000e-01
  br label %112

; <label>:112                                     ; preds = %0, %19
  %yLPattanaik.0 = phi float [ %111, %19 ], [ %13, %0 ]
  %113 = fdiv float %yLPattanaik.0, %13, !fpmath !7
  %114 = fadd float %113, %delta
  %115 = tail call float @llvm.log2.f32(float %114)
  %116 = fmul float %115, 0x3FE62E4300000000
  %117 = tail call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %116, float %14)
  %118 = fadd float %13, %117
  %119 = fdiv float %13, %118, !fpmath !7
  %120 = fdiv float %8, %13, !fpmath !7
  %121 = tail call float @llvm.pow.f32(float %120, float %gamma)
  %122 = fmul float %119, %121
  %123 = fdiv float %9, %13, !fpmath !7
  %124 = tail call float @llvm.pow.f32(float %123, float %gamma)
  %125 = fmul float %119, %124
  %126 = fdiv float %10, %13, !fpmath !7
  %127 = tail call float @llvm.pow.f32(float %126, float %gamma)
  %128 = fmul float %119, %127
  %129 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %5
  %130 = load <4 x float> addrspace(1)* %129, align 16
  %131 = insertelement <4 x float> %130, float %122, i32 0
  %132 = insertelement <4 x float> %131, float %125, i32 1
  %133 = insertelement <4 x float> %132, float %128, i32 2
  store <4 x float> %133, <4 x float> addrspace(1)* %129, align 16
  %134 = load <4 x float> addrspace(1)* %6, align 16
  %135 = shufflevector <4 x float> %133, <4 x float> %134, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  store <4 x float> %135, <4 x float> addrspace(1)* %129, align 16
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
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"float", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{float 2.500000e+00}

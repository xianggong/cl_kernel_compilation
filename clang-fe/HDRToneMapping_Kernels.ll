; ModuleID = '../kernel-src/HDRToneMapping_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

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
  %1 = tail call i32 @get_global_id(i32 0) #4
  %2 = tail call i32 @get_global_id(i32 1) #4
  %3 = mul i32 %numChannels, %width
  %4 = mul i32 %2, %3
  %5 = mul i32 %1, %numChannels
  %6 = add i32 %4, %5
  %7 = getelementptr inbounds float addrspace(1)* %input, i32 %6
  %8 = load float addrspace(1)* %7, align 4, !tbaa !10
  %9 = add i32 %5, 1
  %10 = add i32 %9, %4
  %11 = getelementptr inbounds float addrspace(1)* %input, i32 %10
  %12 = load float addrspace(1)* %11, align 4, !tbaa !10
  %13 = add i32 %5, 2
  %14 = add i32 %13, %4
  %15 = getelementptr inbounds float addrspace(1)* %input, i32 %14
  %16 = load float addrspace(1)* %15, align 4, !tbaa !10
  %17 = fmul float %12, 0x3FE6E2EB20000000
  %18 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %8, float %17) #4
  %19 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %16, float %18) #4
  %20 = fmul float %averageLuminance, %c
  %notlhs = icmp eq i32 %1, 0
  %notrhs = icmp eq i32 %2, 0
  %or.cond.not = or i1 %notlhs, %notrhs
  %21 = add i32 %width, -1
  %22 = icmp eq i32 %1, %21
  %or.cond3 = or i1 %22, %or.cond.not
  %23 = add i32 %height, -1
  %24 = icmp eq i32 %2, %23
  %or.cond5 = or i1 %24, %or.cond3
  br i1 %or.cond5, label %138, label %25

; <label>:25                                      ; preds = %0
  %26 = add i32 %2, -1
  %27 = mul i32 %26, %3
  %28 = add i32 %1, -1
  %29 = mul i32 %28, %numChannels
  %30 = add i32 %27, %29
  %31 = getelementptr inbounds float addrspace(1)* %input, i32 %30
  %32 = load float addrspace(1)* %31, align 4, !tbaa !10
  %33 = add i32 %30, 1
  %34 = getelementptr inbounds float addrspace(1)* %input, i32 %33
  %35 = load float addrspace(1)* %34, align 4, !tbaa !10
  %36 = add i32 %30, 2
  %37 = getelementptr inbounds float addrspace(1)* %input, i32 %36
  %38 = load float addrspace(1)* %37, align 4, !tbaa !10
  %39 = fmul float %35, 0x3FE6E2EB20000000
  %40 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %32, float %39) #4
  %41 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %38, float %40) #4
  %42 = add i32 %27, %5
  %43 = getelementptr inbounds float addrspace(1)* %input, i32 %42
  %44 = load float addrspace(1)* %43, align 4, !tbaa !10
  %45 = add i32 %42, 1
  %46 = getelementptr inbounds float addrspace(1)* %input, i32 %45
  %47 = load float addrspace(1)* %46, align 4, !tbaa !10
  %48 = add i32 %42, 2
  %49 = getelementptr inbounds float addrspace(1)* %input, i32 %48
  %50 = load float addrspace(1)* %49, align 4, !tbaa !10
  %51 = fmul float %47, 0x3FE6E2EB20000000
  %52 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %44, float %51) #4
  %53 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %50, float %52) #4
  %54 = add i32 %1, 1
  %55 = mul i32 %54, %numChannels
  %56 = add i32 %27, %55
  %57 = getelementptr inbounds float addrspace(1)* %input, i32 %56
  %58 = load float addrspace(1)* %57, align 4, !tbaa !10
  %59 = add i32 %56, 1
  %60 = getelementptr inbounds float addrspace(1)* %input, i32 %59
  %61 = load float addrspace(1)* %60, align 4, !tbaa !10
  %62 = add i32 %56, 2
  %63 = getelementptr inbounds float addrspace(1)* %input, i32 %62
  %64 = load float addrspace(1)* %63, align 4, !tbaa !10
  %65 = fmul float %61, 0x3FE6E2EB20000000
  %66 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %58, float %65) #4
  %67 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %64, float %66) #4
  %68 = add i32 %4, %29
  %69 = getelementptr inbounds float addrspace(1)* %input, i32 %68
  %70 = load float addrspace(1)* %69, align 4, !tbaa !10
  %71 = add i32 %68, 1
  %72 = getelementptr inbounds float addrspace(1)* %input, i32 %71
  %73 = load float addrspace(1)* %72, align 4, !tbaa !10
  %74 = add i32 %68, 2
  %75 = getelementptr inbounds float addrspace(1)* %input, i32 %74
  %76 = load float addrspace(1)* %75, align 4, !tbaa !10
  %77 = fmul float %73, 0x3FE6E2EB20000000
  %78 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %70, float %77) #4
  %79 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %76, float %78) #4
  %80 = add i32 %4, %55
  %81 = getelementptr inbounds float addrspace(1)* %input, i32 %80
  %82 = load float addrspace(1)* %81, align 4, !tbaa !10
  %83 = add i32 %80, 1
  %84 = getelementptr inbounds float addrspace(1)* %input, i32 %83
  %85 = load float addrspace(1)* %84, align 4, !tbaa !10
  %86 = add i32 %80, 2
  %87 = getelementptr inbounds float addrspace(1)* %input, i32 %86
  %88 = load float addrspace(1)* %87, align 4, !tbaa !10
  %89 = fmul float %85, 0x3FE6E2EB20000000
  %90 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %82, float %89) #4
  %91 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %88, float %90) #4
  %92 = add i32 %2, 1
  %93 = mul i32 %92, %3
  %94 = add i32 %93, %29
  %95 = getelementptr inbounds float addrspace(1)* %input, i32 %94
  %96 = load float addrspace(1)* %95, align 4, !tbaa !10
  %97 = add i32 %94, 1
  %98 = getelementptr inbounds float addrspace(1)* %input, i32 %97
  %99 = load float addrspace(1)* %98, align 4, !tbaa !10
  %100 = add i32 %94, 2
  %101 = getelementptr inbounds float addrspace(1)* %input, i32 %100
  %102 = load float addrspace(1)* %101, align 4, !tbaa !10
  %103 = fmul float %99, 0x3FE6E2EB20000000
  %104 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %96, float %103) #4
  %105 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %102, float %104) #4
  %106 = add i32 %93, %5
  %107 = getelementptr inbounds float addrspace(1)* %input, i32 %106
  %108 = load float addrspace(1)* %107, align 4, !tbaa !10
  %109 = add i32 %106, 1
  %110 = getelementptr inbounds float addrspace(1)* %input, i32 %109
  %111 = load float addrspace(1)* %110, align 4, !tbaa !10
  %112 = add i32 %106, 2
  %113 = getelementptr inbounds float addrspace(1)* %input, i32 %112
  %114 = load float addrspace(1)* %113, align 4, !tbaa !10
  %115 = fmul float %111, 0x3FE6E2EB20000000
  %116 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %108, float %115) #4
  %117 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %114, float %116) #4
  %118 = add i32 %93, %55
  %119 = getelementptr inbounds float addrspace(1)* %input, i32 %118
  %120 = load float addrspace(1)* %119, align 4, !tbaa !10
  %121 = add i32 %118, 1
  %122 = getelementptr inbounds float addrspace(1)* %input, i32 %121
  %123 = load float addrspace(1)* %122, align 4, !tbaa !10
  %124 = add i32 %118, 2
  %125 = getelementptr inbounds float addrspace(1)* %input, i32 %124
  %126 = load float addrspace(1)* %125, align 4, !tbaa !10
  %127 = fmul float %123, 0x3FE6E2EB20000000
  %128 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %120, float %127) #4
  %129 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %126, float %128) #4
  %130 = fadd float %41, %53
  %131 = fadd float %130, %67
  %132 = fadd float %131, %79
  %133 = fadd float %132, %91
  %134 = fadd float %133, %105
  %135 = fadd float %134, %117
  %136 = fadd float %135, %129
  %137 = fmul float %136, 1.250000e-01
  br label %138

; <label>:138                                     ; preds = %0, %25
  %yLPattanaik.0 = phi float [ %137, %25 ], [ %19, %0 ]
  %139 = fdiv float %yLPattanaik.0, %19, !fpmath !14
  %140 = fadd float %139, %delta
  %141 = tail call float @llvm.log2.f32(float %140)
  %142 = fmul float %141, 0x3FE62E4300000000
  %143 = tail call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %142, float %20)
  %144 = fadd float %19, %143
  %145 = fdiv float %19, %144, !fpmath !14
  %146 = fdiv float %8, %19, !fpmath !14
  %147 = tail call float @llvm.pow.f32(float %146, float %gamma)
  %148 = fmul float %145, %147
  %149 = fdiv float %12, %19, !fpmath !14
  %150 = tail call float @llvm.pow.f32(float %149, float %gamma)
  %151 = fmul float %145, %150
  %152 = fdiv float %16, %19, !fpmath !14
  %153 = tail call float @llvm.pow.f32(float %152, float %gamma)
  %154 = fmul float %145, %153
  %155 = getelementptr inbounds float addrspace(1)* %output, i32 %6
  store float %148, float addrspace(1)* %155, align 4, !tbaa !10
  %156 = getelementptr inbounds float addrspace(1)* %output, i32 %10
  store float %151, float addrspace(1)* %156, align 4, !tbaa !10
  %157 = getelementptr inbounds float addrspace(1)* %output, i32 %14
  store float %154, float addrspace(1)* %157, align 4, !tbaa !10
  %158 = add i32 %5, 3
  %159 = add i32 %158, %4
  %160 = getelementptr inbounds float addrspace(1)* %input, i32 %159
  %161 = load float addrspace(1)* %160, align 4, !tbaa !10
  %162 = getelementptr inbounds float addrspace(1)* %output, i32 %159
  store float %161, float addrspace(1)* %162, align 4, !tbaa !10
  ret void
}

declare i32 @get_global_id(i32) #3

; Function Attrs: nounwind readnone
declare float @llvm.log2.f32(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.pow.f32(float, float) #1

; Function Attrs: nounwind
define void @toneMappingPattanaik(<4 x float> addrspace(1)* nocapture readonly %input, <4 x float> addrspace(1)* nocapture %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #2 {
  %1 = tail call i32 @get_global_id(i32 0) #4
  %2 = tail call i32 @get_global_id(i32 1) #4
  %3 = mul i32 %2, %width
  %4 = add i32 %3, %1
  %5 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %4
  %6 = load <4 x float> addrspace(1)* %5, align 16
  %7 = extractelement <4 x float> %6, i32 0
  %8 = extractelement <4 x float> %6, i32 1
  %9 = extractelement <4 x float> %6, i32 2
  %10 = fmul float %8, 0x3FE6E2EB20000000
  %11 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %7, float %10) #4
  %12 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %9, float %11) #4
  %13 = fmul float %averageLuminance, %c
  %notlhs = icmp eq i32 %1, 0
  %notrhs = icmp eq i32 %2, 0
  %or.cond.not = or i1 %notlhs, %notrhs
  %14 = add i32 %width, -1
  %15 = icmp eq i32 %1, %14
  %or.cond3 = or i1 %15, %or.cond.not
  %16 = add i32 %height, -1
  %17 = icmp eq i32 %2, %16
  %or.cond5 = or i1 %17, %or.cond3
  br i1 %or.cond5, label %103, label %18

; <label>:18                                      ; preds = %0
  %19 = add i32 %2, -1
  %20 = mul i32 %19, %width
  %21 = add i32 %20, %1
  %22 = add i32 %21, -1
  %23 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %22
  %24 = load <4 x float> addrspace(1)* %23, align 16
  %25 = extractelement <4 x float> %24, i32 0
  %26 = extractelement <4 x float> %24, i32 1
  %27 = extractelement <4 x float> %24, i32 2
  %28 = fmul float %26, 0x3FE6E2EB20000000
  %29 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %25, float %28) #4
  %30 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %27, float %29) #4
  %31 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %21
  %32 = load <4 x float> addrspace(1)* %31, align 16
  %33 = extractelement <4 x float> %32, i32 0
  %34 = extractelement <4 x float> %32, i32 1
  %35 = extractelement <4 x float> %32, i32 2
  %36 = fmul float %34, 0x3FE6E2EB20000000
  %37 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %33, float %36) #4
  %38 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %35, float %37) #4
  %39 = add i32 %21, 1
  %40 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %39
  %41 = load <4 x float> addrspace(1)* %40, align 16
  %42 = extractelement <4 x float> %41, i32 0
  %43 = extractelement <4 x float> %41, i32 1
  %44 = extractelement <4 x float> %41, i32 2
  %45 = fmul float %43, 0x3FE6E2EB20000000
  %46 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %42, float %45) #4
  %47 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %44, float %46) #4
  %48 = add i32 %4, -1
  %49 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %48
  %50 = load <4 x float> addrspace(1)* %49, align 16
  %51 = extractelement <4 x float> %50, i32 0
  %52 = extractelement <4 x float> %50, i32 1
  %53 = extractelement <4 x float> %50, i32 2
  %54 = fmul float %52, 0x3FE6E2EB20000000
  %55 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %51, float %54) #4
  %56 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %53, float %55) #4
  %57 = add i32 %4, 1
  %58 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %57
  %59 = load <4 x float> addrspace(1)* %58, align 16
  %60 = extractelement <4 x float> %59, i32 0
  %61 = extractelement <4 x float> %59, i32 1
  %62 = extractelement <4 x float> %59, i32 2
  %63 = fmul float %61, 0x3FE6E2EB20000000
  %64 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %60, float %63) #4
  %65 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %62, float %64) #4
  %66 = add i32 %2, 1
  %67 = mul i32 %66, %width
  %68 = add i32 %67, %1
  %69 = add i32 %68, -1
  %70 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %69
  %71 = load <4 x float> addrspace(1)* %70, align 16
  %72 = extractelement <4 x float> %71, i32 0
  %73 = extractelement <4 x float> %71, i32 1
  %74 = extractelement <4 x float> %71, i32 2
  %75 = fmul float %73, 0x3FE6E2EB20000000
  %76 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %72, float %75) #4
  %77 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %74, float %76) #4
  %78 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %68
  %79 = load <4 x float> addrspace(1)* %78, align 16
  %80 = extractelement <4 x float> %79, i32 0
  %81 = extractelement <4 x float> %79, i32 1
  %82 = extractelement <4 x float> %79, i32 2
  %83 = fmul float %81, 0x3FE6E2EB20000000
  %84 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %80, float %83) #4
  %85 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %82, float %84) #4
  %86 = add i32 %68, 1
  %87 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %86
  %88 = load <4 x float> addrspace(1)* %87, align 16
  %89 = extractelement <4 x float> %88, i32 0
  %90 = extractelement <4 x float> %88, i32 1
  %91 = extractelement <4 x float> %88, i32 2
  %92 = fmul float %90, 0x3FE6E2EB20000000
  %93 = tail call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %89, float %92) #4
  %94 = tail call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %91, float %93) #4
  %95 = fadd float %30, %38
  %96 = fadd float %95, %47
  %97 = fadd float %96, %56
  %98 = fadd float %97, %65
  %99 = fadd float %98, %77
  %100 = fadd float %99, %85
  %101 = fadd float %100, %94
  %102 = fmul float %101, 1.250000e-01
  br label %103

; <label>:103                                     ; preds = %0, %18
  %yLPattanaik.0 = phi float [ %102, %18 ], [ %12, %0 ]
  %104 = fdiv float %yLPattanaik.0, %12, !fpmath !14
  %105 = fadd float %104, %delta
  %106 = tail call float @llvm.log2.f32(float %105)
  %107 = fmul float %106, 0x3FE62E4300000000
  %108 = tail call float @llvm.fmuladd.f32(float %yLPattanaik.0, float %107, float %13)
  %109 = fadd float %12, %108
  %110 = fdiv float %12, %109, !fpmath !14
  %111 = fdiv float %7, %12, !fpmath !14
  %112 = tail call float @llvm.pow.f32(float %111, float %gamma)
  %113 = fmul float %110, %112
  %114 = fdiv float %8, %12, !fpmath !14
  %115 = tail call float @llvm.pow.f32(float %114, float %gamma)
  %116 = fmul float %110, %115
  %117 = fdiv float %9, %12, !fpmath !14
  %118 = tail call float @llvm.pow.f32(float %117, float %gamma)
  %119 = fmul float %110, %118
  %120 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %4
  %121 = load <4 x float> addrspace(1)* %120, align 16
  %122 = insertelement <4 x float> %121, float %113, i32 0
  %123 = insertelement <4 x float> %122, float %116, i32 1
  %124 = insertelement <4 x float> %123, float %119, i32 2
  store <4 x float> %124, <4 x float> addrspace(1)* %120, align 16
  %125 = load <4 x float> addrspace(1)* %5, align 16
  %126 = shufflevector <4 x float> %124, <4 x float> %125, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  store <4 x float> %126, <4 x float> addrspace(1)* %120, align 16
  ret void
}

attributes #0 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!9}

!0 = !{void (float addrspace(1)*, float addrspace(1)*, float, float, float, float, i32, i32, i32)* @toneMappingPattanaik1, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"float", !"float", !"float", !"float", !"uint", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float", !"float", !"float", !"float", !"uint", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"", !"", !"", !"", !"", !""}
!6 = !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, float, float, float, float, i32, i32, i32)* @toneMappingPattanaik, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"float4*", !"float4*", !"float", !"float", !"float", !"float", !"uint", !"uint", !"uint"}
!8 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"float", !"float", !"float", !"float", !"uint", !"uint", !"uint"}
!9 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{float 2.500000e+00}

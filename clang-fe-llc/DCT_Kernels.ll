; ModuleID = '../kernel-src/DCT_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define i32 @getIdx(i32 %blockIdx, i32 %blockIdy, i32 %localIdx, i32 %localIdy, i32 %blockWidth, i32 %globalWidth) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %globalIdy = alloca i32, align 4
  store i32 %blockIdx, i32* %1, align 4
  store i32 %blockIdy, i32* %2, align 4
  store i32 %localIdx, i32* %3, align 4
  store i32 %localIdy, i32* %4, align 4
  store i32 %blockWidth, i32* %5, align 4
  store i32 %globalWidth, i32* %6, align 4
  %7 = load i32* %1, align 4
  %8 = load i32* %5, align 4
  %9 = mul i32 %7, %8
  %10 = load i32* %3, align 4
  %11 = add i32 %9, %10
  store i32 %11, i32* %globalIdx, align 4
  %12 = load i32* %2, align 4
  %13 = load i32* %5, align 4
  %14 = mul i32 %12, %13
  %15 = load i32* %4, align 4
  %16 = add i32 %14, %15
  store i32 %16, i32* %globalIdy, align 4
  %17 = load i32* %globalIdy, align 4
  %18 = load i32* %6, align 4
  %19 = mul i32 %17, %18
  %20 = load i32* %globalIdx, align 4
  %21 = add i32 %19, %20
  ret i32 %21
}

; Function Attrs: nounwind
define void @DCT(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(1)* %dct8x8, float addrspace(1)* %dct8x8_trans, float addrspace(3)* %inter, i32 %width, i32 %blockWidth, i32 %inverse) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %3 = alloca float addrspace(1)*, align 4
  %4 = alloca float addrspace(1)*, align 4
  %5 = alloca float addrspace(3)*, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %globalIdy = alloca i32, align 4
  %groupIdx = alloca i32, align 4
  %groupIdy = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %idx = alloca i32, align 4
  %acc = alloca float, align 4
  %k = alloca i32, align 4
  %index1 = alloca i32, align 4
  %index2 = alloca i32, align 4
  %k1 = alloca i32, align 4
  %index12 = alloca i32, align 4
  %index23 = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %1, align 4
  store float addrspace(1)* %input, float addrspace(1)** %2, align 4
  store float addrspace(1)* %dct8x8, float addrspace(1)** %3, align 4
  store float addrspace(1)* %dct8x8_trans, float addrspace(1)** %4, align 4
  store float addrspace(3)* %inter, float addrspace(3)** %5, align 4
  store i32 %width, i32* %6, align 4
  store i32 %blockWidth, i32* %7, align 4
  store i32 %inverse, i32* %8, align 4
  %9 = call i32 @get_global_id(i32 0)
  store i32 %9, i32* %globalIdx, align 4
  %10 = call i32 @get_global_id(i32 1)
  store i32 %10, i32* %globalIdy, align 4
  %11 = call i32 @get_group_id(i32 0)
  store i32 %11, i32* %groupIdx, align 4
  %12 = call i32 @get_group_id(i32 1)
  store i32 %12, i32* %groupIdy, align 4
  %13 = call i32 @get_local_id(i32 0)
  store i32 %13, i32* %i, align 4
  %14 = call i32 @get_local_id(i32 1)
  store i32 %14, i32* %j, align 4
  %15 = load i32* %globalIdy, align 4
  %16 = load i32* %6, align 4
  %17 = mul i32 %15, %16
  %18 = load i32* %globalIdx, align 4
  %19 = add i32 %17, %18
  store i32 %19, i32* %idx, align 4
  store float 0.000000e+00, float* %acc, align 4
  store i32 0, i32* %k, align 4
  br label %20

; <label>:20                                      ; preds = %64, %0
  %21 = load i32* %k, align 4
  %22 = load i32* %7, align 4
  %23 = icmp ult i32 %21, %22
  br i1 %23, label %24, label %67

; <label>:24                                      ; preds = %20
  %25 = load i32* %j, align 4
  %26 = load i32* %7, align 4
  %27 = mul i32 %25, %26
  %28 = load i32* %k, align 4
  %29 = add i32 %27, %28
  store i32 %29, i32* %index1, align 4
  %30 = load i32* %groupIdx, align 4
  %31 = load i32* %groupIdy, align 4
  %32 = load i32* %i, align 4
  %33 = load i32* %k, align 4
  %34 = load i32* %7, align 4
  %35 = load i32* %6, align 4
  %36 = call i32 @getIdx(i32 %30, i32 %31, i32 %32, i32 %33, i32 %34, i32 %35)
  store i32 %36, i32* %index2, align 4
  %37 = load i32* %8, align 4
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %39, label %51

; <label>:39                                      ; preds = %24
  %40 = load i32* %index1, align 4
  %41 = load float addrspace(1)** %3, align 4
  %42 = getelementptr inbounds float addrspace(1)* %41, i32 %40
  %43 = load float addrspace(1)* %42, align 4
  %44 = load i32* %index2, align 4
  %45 = load float addrspace(1)** %2, align 4
  %46 = getelementptr inbounds float addrspace(1)* %45, i32 %44
  %47 = load float addrspace(1)* %46, align 4
  %48 = fmul float %43, %47
  %49 = load float* %acc, align 4
  %50 = fadd float %49, %48
  store float %50, float* %acc, align 4
  br label %63

; <label>:51                                      ; preds = %24
  %52 = load i32* %index1, align 4
  %53 = load float addrspace(1)** %4, align 4
  %54 = getelementptr inbounds float addrspace(1)* %53, i32 %52
  %55 = load float addrspace(1)* %54, align 4
  %56 = load i32* %index2, align 4
  %57 = load float addrspace(1)** %2, align 4
  %58 = getelementptr inbounds float addrspace(1)* %57, i32 %56
  %59 = load float addrspace(1)* %58, align 4
  %60 = fmul float %55, %59
  %61 = load float* %acc, align 4
  %62 = fadd float %61, %60
  store float %62, float* %acc, align 4
  br label %63

; <label>:63                                      ; preds = %51, %39
  br label %64

; <label>:64                                      ; preds = %63
  %65 = load i32* %k, align 4
  %66 = add i32 %65, 1
  store i32 %66, i32* %k, align 4
  br label %20

; <label>:67                                      ; preds = %20
  %68 = load float* %acc, align 4
  %69 = load i32* %j, align 4
  %70 = load i32* %7, align 4
  %71 = mul i32 %69, %70
  %72 = load i32* %i, align 4
  %73 = add i32 %71, %72
  %74 = load float addrspace(3)** %5, align 4
  %75 = getelementptr inbounds float addrspace(3)* %74, i32 %73
  store float %68, float addrspace(3)* %75, align 4
  call void @barrier(i32 1)
  store float 0.000000e+00, float* %acc, align 4
  store i32 0, i32* %k1, align 4
  br label %76

; <label>:76                                      ; preds = %118, %67
  %77 = load i32* %k1, align 4
  %78 = load i32* %7, align 4
  %79 = icmp ult i32 %77, %78
  br i1 %79, label %80, label %121

; <label>:80                                      ; preds = %76
  %81 = load i32* %j, align 4
  %82 = load i32* %7, align 4
  %83 = mul i32 %81, %82
  %84 = load i32* %k1, align 4
  %85 = add i32 %83, %84
  store i32 %85, i32* %index12, align 4
  %86 = load i32* %k1, align 4
  %87 = load i32* %7, align 4
  %88 = mul i32 %86, %87
  %89 = load i32* %i, align 4
  %90 = add i32 %88, %89
  store i32 %90, i32* %index23, align 4
  %91 = load i32* %8, align 4
  %92 = icmp ne i32 %91, 0
  br i1 %92, label %93, label %105

; <label>:93                                      ; preds = %80
  %94 = load i32* %index12, align 4
  %95 = load float addrspace(3)** %5, align 4
  %96 = getelementptr inbounds float addrspace(3)* %95, i32 %94
  %97 = load float addrspace(3)* %96, align 4
  %98 = load i32* %index23, align 4
  %99 = load float addrspace(1)** %4, align 4
  %100 = getelementptr inbounds float addrspace(1)* %99, i32 %98
  %101 = load float addrspace(1)* %100, align 4
  %102 = fmul float %97, %101
  %103 = load float* %acc, align 4
  %104 = fadd float %103, %102
  store float %104, float* %acc, align 4
  br label %117

; <label>:105                                     ; preds = %80
  %106 = load i32* %index12, align 4
  %107 = load float addrspace(3)** %5, align 4
  %108 = getelementptr inbounds float addrspace(3)* %107, i32 %106
  %109 = load float addrspace(3)* %108, align 4
  %110 = load i32* %index23, align 4
  %111 = load float addrspace(1)** %3, align 4
  %112 = getelementptr inbounds float addrspace(1)* %111, i32 %110
  %113 = load float addrspace(1)* %112, align 4
  %114 = fmul float %109, %113
  %115 = load float* %acc, align 4
  %116 = fadd float %115, %114
  store float %116, float* %acc, align 4
  br label %117

; <label>:117                                     ; preds = %105, %93
  br label %118

; <label>:118                                     ; preds = %117
  %119 = load i32* %k1, align 4
  %120 = add i32 %119, 1
  store i32 %120, i32* %k1, align 4
  br label %76

; <label>:121                                     ; preds = %76
  %122 = load float* %acc, align 4
  %123 = load i32* %idx, align 4
  %124 = load float addrspace(1)** %1, align 4
  %125 = getelementptr inbounds float addrspace(1)* %124, i32 %123
  store float %122, float addrspace(1)* %125, align 4
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32)* @DCT}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

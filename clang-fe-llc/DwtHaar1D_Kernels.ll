; ModuleID = '../kernel-src/DwtHaar1D_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @dwtHaar1D(float addrspace(1)* %inSignal, float addrspace(1)* %coefsSignal, float addrspace(1)* %AverageSignal, float addrspace(3)* %sharedArray, i32 %tLevels, i32 %signalLength, i32 %levelsDone, i32 %mLevels) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %3 = alloca float addrspace(1)*, align 4
  %4 = alloca float addrspace(3)*, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %localId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %globalId = alloca i32, align 4
  %localSize = alloca i32, align 4
  %t0 = alloca float, align 4
  %t1 = alloca float, align 4
  %r = alloca float, align 4
  %levels = alloca i32, align 4
  %activeThreads = alloca i32, align 4
  %midOutPos = alloca i32, align 4
  %rsqrt_two = alloca float, align 4
  %i = alloca i32, align 4
  %data0 = alloca float, align 4
  %data1 = alloca float, align 4
  %globalPos = alloca i32, align 4
  store float addrspace(1)* %inSignal, float addrspace(1)** %1, align 4
  store float addrspace(1)* %coefsSignal, float addrspace(1)** %2, align 4
  store float addrspace(1)* %AverageSignal, float addrspace(1)** %3, align 4
  store float addrspace(3)* %sharedArray, float addrspace(3)** %4, align 4
  store i32 %tLevels, i32* %5, align 4
  store i32 %signalLength, i32* %6, align 4
  store i32 %levelsDone, i32* %7, align 4
  store i32 %mLevels, i32* %8, align 4
  %9 = call i32 @get_local_id(i32 0)
  store i32 %9, i32* %localId, align 4
  %10 = call i32 @get_group_id(i32 0)
  store i32 %10, i32* %groupId, align 4
  %11 = call i32 @get_global_id(i32 0)
  store i32 %11, i32* %globalId, align 4
  %12 = call i32 @get_local_size(i32 0)
  store i32 %12, i32* %localSize, align 4
  %13 = load i32* %groupId, align 4
  %14 = load i32* %localSize, align 4
  %15 = mul i32 %13, %14
  %16 = mul i32 %15, 2
  %17 = load i32* %localId, align 4
  %18 = add i32 %16, %17
  %19 = load float addrspace(1)** %1, align 4
  %20 = getelementptr inbounds float addrspace(1)* %19, i32 %18
  %21 = load float addrspace(1)* %20, align 4
  store float %21, float* %t0, align 4
  %22 = load i32* %groupId, align 4
  %23 = load i32* %localSize, align 4
  %24 = mul i32 %22, %23
  %25 = mul i32 %24, 2
  %26 = load i32* %localSize, align 4
  %27 = add i32 %25, %26
  %28 = load i32* %localId, align 4
  %29 = add i32 %27, %28
  %30 = load float addrspace(1)** %1, align 4
  %31 = getelementptr inbounds float addrspace(1)* %30, i32 %29
  %32 = load float addrspace(1)* %31, align 4
  store float %32, float* %t1, align 4
  %33 = load i32* %7, align 4
  %34 = icmp eq i32 0, %33
  br i1 %34, label %35, label %46

; <label>:35                                      ; preds = %0
  %36 = load i32* %6, align 4
  %37 = uitofp i32 %36 to float
  %38 = call float @llvm.sqrt.f32(float %37)
  %39 = fdiv float 1.000000e+00, %38, !fpmath !2
  store float %39, float* %r, align 4
  %40 = load float* %r, align 4
  %41 = load float* %t0, align 4
  %42 = fmul float %41, %40
  store float %42, float* %t0, align 4
  %43 = load float* %r, align 4
  %44 = load float* %t1, align 4
  %45 = fmul float %44, %43
  store float %45, float* %t1, align 4
  br label %46

; <label>:46                                      ; preds = %35, %0
  %47 = load float* %t0, align 4
  %48 = load i32* %localId, align 4
  %49 = load float addrspace(3)** %4, align 4
  %50 = getelementptr inbounds float addrspace(3)* %49, i32 %48
  store float %47, float addrspace(3)* %50, align 4
  %51 = load float* %t1, align 4
  %52 = load i32* %localSize, align 4
  %53 = load i32* %localId, align 4
  %54 = add i32 %52, %53
  %55 = load float addrspace(3)** %4, align 4
  %56 = getelementptr inbounds float addrspace(3)* %55, i32 %54
  store float %51, float addrspace(3)* %56, align 4
  call void @barrier(i32 1)
  %57 = load i32* %5, align 4
  %58 = load i32* %8, align 4
  %59 = icmp ugt i32 %57, %58
  br i1 %59, label %60, label %62

; <label>:60                                      ; preds = %46
  %61 = load i32* %8, align 4
  br label %64

; <label>:62                                      ; preds = %46
  %63 = load i32* %5, align 4
  br label %64

; <label>:64                                      ; preds = %62, %60
  %65 = phi i32 [ %61, %60 ], [ %63, %62 ]
  store i32 %65, i32* %levels, align 4
  %66 = load i32* %levels, align 4
  %67 = and i32 %66, 31
  %68 = shl i32 1, %67
  %69 = sdiv i32 %68, 2
  store i32 %69, i32* %activeThreads, align 4
  %70 = load i32* %6, align 4
  %71 = udiv i32 %70, 2
  store i32 %71, i32* %midOutPos, align 4
  %72 = call float @llvm.sqrt.f32(float 2.000000e+00)
  %73 = fdiv float 1.000000e+00, %72, !fpmath !2
  store float %73, float* %rsqrt_two, align 4
  store i32 0, i32* %i, align 4
  br label %74

; <label>:74                                      ; preds = %127, %64
  %75 = load i32* %i, align 4
  %76 = load i32* %levels, align 4
  %77 = icmp ult i32 %75, %76
  br i1 %77, label %78, label %130

; <label>:78                                      ; preds = %74
  %79 = load i32* %localId, align 4
  %80 = load i32* %activeThreads, align 4
  %81 = icmp ult i32 %79, %80
  br i1 %81, label %82, label %94

; <label>:82                                      ; preds = %78
  %83 = load i32* %localId, align 4
  %84 = mul i32 2, %83
  %85 = load float addrspace(3)** %4, align 4
  %86 = getelementptr inbounds float addrspace(3)* %85, i32 %84
  %87 = load float addrspace(3)* %86, align 4
  store float %87, float* %data0, align 4
  %88 = load i32* %localId, align 4
  %89 = mul i32 2, %88
  %90 = add i32 %89, 1
  %91 = load float addrspace(3)** %4, align 4
  %92 = getelementptr inbounds float addrspace(3)* %91, i32 %90
  %93 = load float addrspace(3)* %92, align 4
  store float %93, float* %data1, align 4
  br label %94

; <label>:94                                      ; preds = %82, %78
  call void @barrier(i32 1)
  %95 = load i32* %localId, align 4
  %96 = load i32* %activeThreads, align 4
  %97 = icmp ult i32 %95, %96
  br i1 %97, label %98, label %124

; <label>:98                                      ; preds = %94
  %99 = load float* %data0, align 4
  %100 = load float* %data1, align 4
  %101 = fadd float %99, %100
  %102 = load float* %rsqrt_two, align 4
  %103 = fmul float %101, %102
  %104 = load i32* %localId, align 4
  %105 = load float addrspace(3)** %4, align 4
  %106 = getelementptr inbounds float addrspace(3)* %105, i32 %104
  store float %103, float addrspace(3)* %106, align 4
  %107 = load i32* %midOutPos, align 4
  %108 = load i32* %groupId, align 4
  %109 = load i32* %activeThreads, align 4
  %110 = mul i32 %108, %109
  %111 = add i32 %107, %110
  %112 = load i32* %localId, align 4
  %113 = add i32 %111, %112
  store i32 %113, i32* %globalPos, align 4
  %114 = load float* %data0, align 4
  %115 = load float* %data1, align 4
  %116 = fsub float %114, %115
  %117 = load float* %rsqrt_two, align 4
  %118 = fmul float %116, %117
  %119 = load i32* %globalPos, align 4
  %120 = load float addrspace(1)** %2, align 4
  %121 = getelementptr inbounds float addrspace(1)* %120, i32 %119
  store float %118, float addrspace(1)* %121, align 4
  %122 = load i32* %midOutPos, align 4
  %123 = lshr i32 %122, 1
  store i32 %123, i32* %midOutPos, align 4
  br label %124

; <label>:124                                     ; preds = %98, %94
  %125 = load i32* %activeThreads, align 4
  %126 = lshr i32 %125, 1
  store i32 %126, i32* %activeThreads, align 4
  call void @barrier(i32 1)
  br label %127

; <label>:127                                     ; preds = %124
  %128 = load i32* %i, align 4
  %129 = add i32 %128, 1
  store i32 %129, i32* %i, align 4
  br label %74

; <label>:130                                     ; preds = %74
  %131 = load i32* %localId, align 4
  %132 = icmp eq i32 0, %131
  br i1 %132, label %133, label %140

; <label>:133                                     ; preds = %130
  %134 = load float addrspace(3)** %4, align 4
  %135 = getelementptr inbounds float addrspace(3)* %134, i32 0
  %136 = load float addrspace(3)* %135, align 4
  %137 = load i32* %groupId, align 4
  %138 = load float addrspace(1)** %3, align 4
  %139 = getelementptr inbounds float addrspace(1)* %138, i32 %137
  store float %136, float addrspace(1)* %139, align 4
  br label %140

; <label>:140                                     ; preds = %133, %130
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_local_size(i32) #1

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32, i32)* @dwtHaar1D}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

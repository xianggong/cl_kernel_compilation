; ModuleID = '../kernel-src/QuasiRandomSequence_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @QuasiRandomSequence_Vector(<4 x float> addrspace(1)* %output, <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(3)* %shared) #0 {
  %1 = alloca <4 x float> addrspace(1)*, align 4
  %2 = alloca <4 x i32> addrspace(1)*, align 4
  %3 = alloca <4 x i32> addrspace(3)*, align 4
  %global_id = alloca i32, align 4
  %local_id = alloca i32, align 4
  %group_id = alloca i32, align 4
  %factor = alloca i32, align 4
  %vlid = alloca <4 x i32>, align 16
  %4 = alloca <4 x i32>, align 16
  %divisor = alloca float, align 4
  %i = alloca i32, align 4
  %shared_scalar = alloca i32 addrspace(3)*, align 4
  %temp = alloca <4 x i32>, align 16
  %lastBit = alloca <4 x i32>, align 16
  %k = alloca i32, align 4
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %1, align 4
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %2, align 4
  store <4 x i32> addrspace(3)* %shared, <4 x i32> addrspace(3)** %3, align 4
  %5 = call i32 @get_global_id(i32 0)
  store i32 %5, i32* %global_id, align 4
  %6 = call i32 @get_local_id(i32 0)
  store i32 %6, i32* %local_id, align 4
  %7 = call i32 @get_group_id(i32 0)
  store i32 %7, i32* %group_id, align 4
  %8 = load i32* %local_id, align 4
  %9 = mul i32 %8, 4
  store i32 %9, i32* %factor, align 4
  %10 = load i32* %factor, align 4
  %11 = insertelement <4 x i32> undef, i32 %10, i32 0
  %12 = load i32* %factor, align 4
  %13 = add i32 %12, 1
  %14 = insertelement <4 x i32> %11, i32 %13, i32 1
  %15 = load i32* %factor, align 4
  %16 = add i32 %15, 2
  %17 = insertelement <4 x i32> %14, i32 %16, i32 2
  %18 = load i32* %factor, align 4
  %19 = add i32 %18, 3
  %20 = insertelement <4 x i32> %17, i32 %19, i32 3
  store <4 x i32> %20, <4 x i32>* %4
  %21 = load <4 x i32>* %4
  store <4 x i32> %21, <4 x i32>* %vlid, align 16
  %22 = call float @llvm.pow.f32(float 2.000000e+00, float 3.200000e+01)
  store float %22, float* %divisor, align 4
  %23 = load i32* %local_id, align 4
  store i32 %23, i32* %i, align 4
  br label %24

; <label>:24                                      ; preds = %38, %0
  %25 = load i32* %i, align 4
  %26 = icmp slt i32 %25, 8
  br i1 %26, label %27, label %42

; <label>:27                                      ; preds = %24
  %28 = load i32* %group_id, align 4
  %29 = mul i32 %28, 8
  %30 = load i32* %i, align 4
  %31 = add i32 %29, %30
  %32 = load <4 x i32> addrspace(1)** %2, align 4
  %33 = getelementptr inbounds <4 x i32> addrspace(1)* %32, i32 %31
  %34 = load <4 x i32> addrspace(1)* %33, align 16
  %35 = load i32* %i, align 4
  %36 = load <4 x i32> addrspace(3)** %3, align 4
  %37 = getelementptr inbounds <4 x i32> addrspace(3)* %36, i32 %35
  store <4 x i32> %34, <4 x i32> addrspace(3)* %37, align 16
  br label %38

; <label>:38                                      ; preds = %27
  %39 = call i32 @get_local_size(i32 0)
  %40 = load i32* %i, align 4
  %41 = add i32 %40, %39
  store i32 %41, i32* %i, align 4
  br label %24

; <label>:42                                      ; preds = %24
  call void @barrier(i32 1)
  %43 = load <4 x i32> addrspace(3)** %3, align 4
  %44 = bitcast <4 x i32> addrspace(3)* %43 to i32 addrspace(3)*
  store i32 addrspace(3)* %44, i32 addrspace(3)** %shared_scalar, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %temp, align 16
  %45 = load <4 x i32>* %vlid, align 16
  store <4 x i32> %45, <4 x i32>* %lastBit, align 16
  store i32 0, i32* %k, align 4
  br label %46

; <label>:46                                      ; preds = %63, %42
  %47 = load i32* %k, align 4
  %48 = icmp slt i32 %47, 12
  br i1 %48, label %49, label %66

; <label>:49                                      ; preds = %46
  %50 = load <4 x i32>* %lastBit, align 16
  %51 = and <4 x i32> %50, <i32 1, i32 1, i32 1, i32 1>
  %52 = load i32* %k, align 4
  %53 = load i32 addrspace(3)** %shared_scalar, align 4
  %54 = getelementptr inbounds i32 addrspace(3)* %53, i32 %52
  %55 = load i32 addrspace(3)* %54, align 4
  %56 = insertelement <4 x i32> undef, i32 %55, i32 0
  %57 = shufflevector <4 x i32> %56, <4 x i32> undef, <4 x i32> zeroinitializer
  %58 = mul <4 x i32> %51, %57
  %59 = load <4 x i32>* %temp, align 16
  %60 = xor <4 x i32> %59, %58
  store <4 x i32> %60, <4 x i32>* %temp, align 16
  %61 = load <4 x i32>* %lastBit, align 16
  %62 = lshr <4 x i32> %61, <i32 1, i32 1, i32 1, i32 1>
  store <4 x i32> %62, <4 x i32>* %lastBit, align 16
  br label %63

; <label>:63                                      ; preds = %49
  %64 = load i32* %k, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, i32* %k, align 4
  br label %46

; <label>:66                                      ; preds = %46
  %67 = load <4 x i32>* %temp, align 16
  %68 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %67)
  %69 = load float* %divisor, align 4
  %70 = insertelement <4 x float> undef, float %69, i32 0
  %71 = shufflevector <4 x float> %70, <4 x float> undef, <4 x i32> zeroinitializer
  %72 = fdiv <4 x float> %68, %71, !fpmath !3
  %73 = load i32* %global_id, align 4
  %74 = load <4 x float> addrspace(1)** %1, align 4
  %75 = getelementptr inbounds <4 x float> addrspace(1)* %74, i32 %73
  store <4 x float> %72, <4 x float> addrspace(1)* %75, align 16
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #2

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind
define void @QuasiRandomSequence_Scalar(float addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %shared) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32 addrspace(3)*, align 4
  %global_id = alloca i32, align 4
  %local_id = alloca i32, align 4
  %group_id = alloca i32, align 4
  %divisor = alloca float, align 4
  %i = alloca i32, align 4
  %temp = alloca i32, align 4
  %lastBit = alloca i32, align 4
  %k = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %2, align 4
  store i32 addrspace(3)* %shared, i32 addrspace(3)** %3, align 4
  %4 = call i32 @get_global_id(i32 0)
  store i32 %4, i32* %global_id, align 4
  %5 = call i32 @get_local_id(i32 0)
  store i32 %5, i32* %local_id, align 4
  %6 = call i32 @get_group_id(i32 0)
  store i32 %6, i32* %group_id, align 4
  %7 = call float @llvm.pow.f32(float 2.000000e+00, float 3.200000e+01)
  store float %7, float* %divisor, align 4
  %8 = load i32* %local_id, align 4
  store i32 %8, i32* %i, align 4
  br label %9

; <label>:9                                       ; preds = %23, %0
  %10 = load i32* %i, align 4
  %11 = icmp slt i32 %10, 32
  br i1 %11, label %12, label %27

; <label>:12                                      ; preds = %9
  %13 = load i32* %group_id, align 4
  %14 = mul i32 %13, 32
  %15 = load i32* %i, align 4
  %16 = add i32 %14, %15
  %17 = load i32 addrspace(1)** %2, align 4
  %18 = getelementptr inbounds i32 addrspace(1)* %17, i32 %16
  %19 = load i32 addrspace(1)* %18, align 4
  %20 = load i32* %i, align 4
  %21 = load i32 addrspace(3)** %3, align 4
  %22 = getelementptr inbounds i32 addrspace(3)* %21, i32 %20
  store i32 %19, i32 addrspace(3)* %22, align 4
  br label %23

; <label>:23                                      ; preds = %12
  %24 = call i32 @get_local_size(i32 0)
  %25 = load i32* %i, align 4
  %26 = add i32 %25, %24
  store i32 %26, i32* %i, align 4
  br label %9

; <label>:27                                      ; preds = %9
  call void @barrier(i32 1)
  store i32 0, i32* %temp, align 4
  %28 = load i32* %local_id, align 4
  store i32 %28, i32* %lastBit, align 4
  store i32 0, i32* %k, align 4
  br label %29

; <label>:29                                      ; preds = %44, %27
  %30 = load i32* %k, align 4
  %31 = icmp slt i32 %30, 10
  br i1 %31, label %32, label %47

; <label>:32                                      ; preds = %29
  %33 = load i32* %lastBit, align 4
  %34 = and i32 %33, 1
  %35 = load i32* %k, align 4
  %36 = load i32 addrspace(3)** %3, align 4
  %37 = getelementptr inbounds i32 addrspace(3)* %36, i32 %35
  %38 = load i32 addrspace(3)* %37, align 4
  %39 = mul i32 %34, %38
  %40 = load i32* %temp, align 4
  %41 = xor i32 %40, %39
  store i32 %41, i32* %temp, align 4
  %42 = load i32* %lastBit, align 4
  %43 = lshr i32 %42, 1
  store i32 %43, i32* %lastBit, align 4
  br label %44

; <label>:44                                      ; preds = %32
  %45 = load i32* %k, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, i32* %k, align 4
  br label %29

; <label>:47                                      ; preds = %29
  %48 = load i32* %temp, align 4
  %49 = call float @_Z13convert_floatj(i32 %48)
  %50 = load float* %divisor, align 4
  %51 = fdiv float %49, %50, !fpmath !3
  %52 = load i32* %global_id, align 4
  %53 = load float addrspace(1)** %1, align 4
  %54 = getelementptr inbounds float addrspace(1)* %53, i32 %52
  store float %51, float addrspace(1)* %54, align 4
  ret void
}

declare float @_Z13convert_floatj(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @QuasiRandomSequence_Vector}
!1 = metadata !{void (float addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*)* @QuasiRandomSequence_Scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{float 2.500000e+00}

; ModuleID = 'QuasiRandomSequence_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @QuasiRandomSequence_Vector(<4 x float> addrspace(1)* %output, <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(3)* %shared) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_local_id_u32(i32 0)
  %3 = call i32 @__get_group_id_u32(i32 0)
  %4 = mul i32 %2, 4
  %5 = insertelement <4 x i32> undef, i32 %4, i32 0
  %6 = add i32 %4, 1
  %7 = insertelement <4 x i32> %5, i32 %6, i32 1
  %8 = add i32 %4, 2
  %9 = insertelement <4 x i32> %7, i32 %8, i32 2
  %10 = add i32 %4, 3
  %11 = insertelement <4 x i32> %9, i32 %10, i32 3
  %12 = call float @llvm.pow.f32(float 2.000000e+00, float 3.200000e+01)
  br label %13

; <label>:13                                      ; preds = %21, %0
  %i.0 = phi i32 [ %2, %0 ], [ %23, %21 ]
  %14 = icmp slt i32 %i.0, 8
  br i1 %14, label %15, label %24

; <label>:15                                      ; preds = %13
  %16 = mul i32 %3, 8
  %17 = add i32 %16, %i.0
  %18 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %17
  %19 = load <4 x i32> addrspace(1)* %18, align 16
  %20 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 %i.0
  store <4 x i32> %19, <4 x i32> addrspace(3)* %20, align 16
  br label %21

; <label>:21                                      ; preds = %15
  %22 = call i32 @__get_local_size_u32(i32 0)
  %23 = add i32 %i.0, %22
  br label %13

; <label>:24                                      ; preds = %13
  call void @barrier(i32 1)
  %25 = bitcast <4 x i32> addrspace(3)* %shared to i32 addrspace(3)*
  br label %26

; <label>:26                                      ; preds = %37, %24
  %temp.0 = phi <4 x i32> [ zeroinitializer, %24 ], [ %35, %37 ]
  %lastBit.0 = phi <4 x i32> [ %11, %24 ], [ %36, %37 ]
  %k.0 = phi i32 [ 0, %24 ], [ %38, %37 ]
  %27 = icmp slt i32 %k.0, 12
  br i1 %27, label %28, label %39

; <label>:28                                      ; preds = %26
  %29 = and <4 x i32> %lastBit.0, <i32 1, i32 1, i32 1, i32 1>
  %30 = getelementptr inbounds i32 addrspace(3)* %25, i32 %k.0
  %31 = load i32 addrspace(3)* %30, align 4
  %32 = insertelement <4 x i32> undef, i32 %31, i32 0
  %33 = shufflevector <4 x i32> %32, <4 x i32> undef, <4 x i32> zeroinitializer
  %34 = mul <4 x i32> %29, %33
  %35 = xor <4 x i32> %temp.0, %34
  %36 = lshr <4 x i32> %lastBit.0, <i32 1, i32 1, i32 1, i32 1>
  br label %37

; <label>:37                                      ; preds = %28
  %38 = add nsw i32 %k.0, 1
  br label %26

; <label>:39                                      ; preds = %26
  %40 = call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %temp.0)
  %41 = insertelement <4 x float> undef, float %12, i32 0
  %42 = shufflevector <4 x float> %41, <4 x float> undef, <4 x i32> zeroinitializer
  %43 = fdiv <4 x float> %40, %42, !fpmath !3
  %44 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %1
  store <4 x float> %43, <4 x float> addrspace(1)* %44, align 16
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #2

declare i32 @__get_local_size_u32(i32) #1

declare void @barrier(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind
define void @QuasiRandomSequence_Scalar(float addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %shared) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_local_id_u32(i32 0)
  %3 = call i32 @__get_group_id_u32(i32 0)
  %4 = call float @llvm.pow.f32(float 2.000000e+00, float 3.200000e+01)
  br label %5

; <label>:5                                       ; preds = %13, %0
  %i.0 = phi i32 [ %2, %0 ], [ %15, %13 ]
  %6 = icmp slt i32 %i.0, 32
  br i1 %6, label %7, label %16

; <label>:7                                       ; preds = %5
  %8 = mul i32 %3, 32
  %9 = add i32 %8, %i.0
  %10 = getelementptr inbounds i32 addrspace(1)* %input, i32 %9
  %11 = load i32 addrspace(1)* %10, align 4
  %12 = getelementptr inbounds i32 addrspace(3)* %shared, i32 %i.0
  store i32 %11, i32 addrspace(3)* %12, align 4
  br label %13

; <label>:13                                      ; preds = %7
  %14 = call i32 @__get_local_size_u32(i32 0)
  %15 = add i32 %i.0, %14
  br label %5

; <label>:16                                      ; preds = %5
  call void @barrier(i32 1)
  br label %17

; <label>:17                                      ; preds = %26, %16
  %temp.0 = phi i32 [ 0, %16 ], [ %24, %26 ]
  %lastBit.0 = phi i32 [ %2, %16 ], [ %25, %26 ]
  %k.0 = phi i32 [ 0, %16 ], [ %27, %26 ]
  %18 = icmp slt i32 %k.0, 10
  br i1 %18, label %19, label %28

; <label>:19                                      ; preds = %17
  %20 = and i32 %lastBit.0, 1
  %21 = getelementptr inbounds i32 addrspace(3)* %shared, i32 %k.0
  %22 = load i32 addrspace(3)* %21, align 4
  %23 = mul i32 %20, %22
  %24 = xor i32 %temp.0, %23
  %25 = lshr i32 %lastBit.0, 1
  br label %26

; <label>:26                                      ; preds = %19
  %27 = add nsw i32 %k.0, 1
  br label %17

; <label>:28                                      ; preds = %17
  %29 = call float @_Z13convert_floatj(i32 %temp.0)
  %30 = fdiv float %29, %4, !fpmath !3
  %31 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  store float %30, float addrspace(1)* %31, align 4
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

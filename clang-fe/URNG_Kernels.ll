; ModuleID = '../kernel-src/URNG_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@noise_uniform.iv = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* nocapture %iv) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 1) #2
  %3 = tail call i32 @get_local_size(i32 0) #2
  %4 = mul i32 %3, %2
  %5 = add i32 %4, %1
  %6 = shl i32 %5, 4
  br label %7

; <label>:7                                       ; preds = %.thread, %0, %18
  %.02 = phi i32 [ %idum, %0 ], [ %., %18 ], [ %., %.thread ]
  %j.01 = phi i32 [ 16, %0 ], [ %21, %18 ], [ %17, %.thread ]
  %8 = sdiv i32 %.02, 127773
  %9 = mul i32 %8, -127773
  %10 = add i32 %9, %.02
  %11 = mul nsw i32 %10, 16807
  %12 = mul i32 %8, -2836
  %13 = add i32 %11, %12
  %14 = icmp slt i32 %13, 0
  %15 = add nsw i32 %13, 2147483647
  %. = select i1 %14, i32 %15, i32 %13
  %16 = icmp slt i32 %j.01, 16
  br i1 %16, label %18, label %.thread

.thread:                                          ; preds = %7
  %17 = add nsw i32 %j.01, -1
  br label %7

; <label>:18                                      ; preds = %7
  %19 = add nsw i32 %j.01, %6
  %20 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %19
  store i32 %., i32 addrspace(3)* %20, align 4, !tbaa !2
  %21 = add nsw i32 %j.01, -1
  %22 = icmp sgt i32 %j.01, 0
  br i1 %22, label %7, label %23

; <label>:23                                      ; preds = %18
  %24 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %6
  %25 = load i32 addrspace(3)* %24, align 4, !tbaa !2
  %26 = sdiv i32 %25, 134217728
  %27 = add nsw i32 %26, %6
  %28 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %27
  %29 = load i32 addrspace(3)* %28, align 4, !tbaa !2
  %30 = sitofp i32 %29 to float
  %31 = fmul float %30, 0x3E00000000000000
  ret float %31
}

declare i32 @get_local_id(i32) #1

declare i32 @get_local_size(i32) #1

; Function Attrs: nounwind
define void @noise_uniform(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %factor) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = tail call i32 @get_global_size(i32 0) #2
  %4 = mul i32 %3, %2
  %5 = add i32 %4, %1
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %6
  %8 = load <4 x i8> addrspace(1)* %7, align 4, !tbaa !6
  %9 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %8) #2
  %10 = extractelement <4 x float> %9, i32 0
  %11 = extractelement <4 x float> %9, i32 1
  %12 = fadd float %10, %11
  %13 = extractelement <4 x float> %9, i32 2
  %14 = fadd float %13, %12
  %15 = fadd float %11, %14
  %16 = fmul float %15, 2.500000e-01
  %17 = fsub float -0.000000e+00, %16
  %18 = fptosi float %17 to i32
  %19 = tail call float @ran1(i32 %18, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  %20 = fadd float %19, 0xBFE19999A0000000
  %21 = sitofp i32 %factor to float
  %22 = fmul float %21, %20
  %23 = insertelement <4 x float> undef, float %22, i32 0
  %24 = shufflevector <4 x float> %23, <4 x float> undef, <4 x i32> zeroinitializer
  %25 = fadd <4 x float> %9, %24
  %26 = tail call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %25) #2
  %27 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %6
  store <4 x i8> %26, <4 x i8> addrspace(1)* %27, align 4, !tbaa !6
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @noise_uniform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !4, metadata !4, i64 0}

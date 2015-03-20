; ModuleID = '../kernel-src/URNG_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@noise_uniform.iv = internal global [1024 x i32] zeroinitializer, align 16

; Function Attrs: nounwind uwtable
define float @ran1(i32 %idum, i32* nocapture %iv) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = tail call i64 @get_local_id(i32 1) #2
  %3 = tail call i64 @get_local_size(i32 0) #2
  %4 = mul i64 %3, %2
  %5 = add i64 %4, %1
  %6 = trunc i64 %5 to i32
  %7 = shl i32 %6, 4
  %8 = sext i32 %7 to i64
  br label %9

; <label>:9                                       ; preds = %.thread, %0, %20
  %indvars.iv = phi i64 [ 16, %0 ], [ %indvars.iv.next, %20 ], [ %indvars.iv.next3, %.thread ]
  %.02 = phi i32 [ %idum, %0 ], [ %., %20 ], [ %., %.thread ]
  %10 = sdiv i32 %.02, 127773
  %11 = mul i32 %10, -127773
  %12 = add i32 %11, %.02
  %13 = mul nsw i32 %12, 16807
  %14 = mul i32 %10, -2836
  %15 = add i32 %13, %14
  %16 = icmp slt i32 %15, 0
  %17 = add nsw i32 %15, 2147483647
  %. = select i1 %16, i32 %17, i32 %15
  %18 = trunc i64 %indvars.iv to i32
  %19 = icmp slt i32 %18, 16
  br i1 %19, label %20, label %.thread

.thread:                                          ; preds = %9
  %indvars.iv.next3 = add nsw i64 %indvars.iv, -1
  br label %9

; <label>:20                                      ; preds = %9
  %21 = add nsw i64 %indvars.iv, %8
  %22 = getelementptr inbounds i32* %iv, i64 %21
  store i32 %., i32* %22, align 4, !tbaa !2
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  %23 = icmp sgt i32 %18, 0
  br i1 %23, label %9, label %24

; <label>:24                                      ; preds = %20
  %25 = getelementptr inbounds i32* %iv, i64 %8
  %26 = load i32* %25, align 4, !tbaa !2
  %27 = sdiv i32 %26, 134217728
  %28 = add nsw i32 %27, %7
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i32* %iv, i64 %29
  %31 = load i32* %30, align 4, !tbaa !2
  %32 = sitofp i32 %31 to float
  %33 = fmul float %32, 0x3E00000000000000
  ret float %33
}

declare i64 @get_local_id(i32) #1

declare i64 @get_local_size(i32) #1

; Function Attrs: nounwind uwtable
define void @noise_uniform(<4 x i8>* nocapture readonly %inputImage, <4 x i8>* nocapture %outputImage, i32 %factor) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_global_id(i32 1) #2
  %3 = tail call i64 @get_global_size(i32 0) #2
  %4 = mul i64 %3, %2
  %5 = add i64 %4, %1
  %sext = shl i64 %5, 32
  %6 = ashr exact i64 %sext, 32
  %7 = getelementptr inbounds <4 x i8>* %inputImage, i64 %6
  %8 = load <4 x i8>* %7, align 4, !tbaa !6
  %9 = bitcast <4 x i8> %8 to i32
  %10 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %9) #2
  %11 = extractelement <4 x float> %10, i32 0
  %12 = extractelement <4 x float> %10, i32 1
  %13 = fadd float %11, %12
  %14 = extractelement <4 x float> %10, i32 2
  %15 = fadd float %14, %13
  %16 = fadd float %12, %15
  %17 = fmul float %16, 2.500000e-01
  %18 = fsub float -0.000000e+00, %17
  %19 = fptosi float %18 to i32
  %20 = tail call float @ran1(i32 %19, i32* getelementptr inbounds ([1024 x i32]* @noise_uniform.iv, i64 0, i64 0))
  %21 = fadd float %20, 0xBFE19999A0000000
  %22 = sitofp i32 %factor to float
  %23 = fmul float %22, %21
  %24 = insertelement <4 x float> undef, float %23, i32 0
  %25 = shufflevector <4 x float> %24, <4 x float> undef, <4 x i32> zeroinitializer
  %26 = fadd <4 x float> %10, %25
  %27 = tail call i32 @_Z18convert_uchar4_satDv4_f(<4 x float> %26) #2
  %28 = bitcast i32 %27 to <4 x i8>
  %29 = getelementptr inbounds <4 x i8>* %outputImage, i64 %6
  store <4 x i8> %28, <4 x i8>* %29, align 4, !tbaa !6
  ret void
}

declare i64 @get_global_id(i32) #1

declare i64 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(i32) #1

declare i32 @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8>*, <4 x i8>*, i32)* @noise_uniform}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !4, metadata !4, i64 0}

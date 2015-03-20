; ModuleID = '../kernel-src/GaussianNoiseGL_Kernels2.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define float @ran1(i32 %idum, i32* nocapture %iv) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = shl i32 %2, 2
  %4 = sext i32 %3 to i64
  %5 = sdiv i32 %idum, 127773
  %6 = mul i32 %5, -127773
  %7 = add i32 %6, %idum
  %8 = mul nsw i32 %7, 16807
  %9 = mul i32 %5, -2836
  %10 = add i32 %8, %9
  %11 = icmp slt i32 %10, 0
  %12 = add nsw i32 %10, 2147483647
  %. = select i1 %11, i32 %12, i32 %10
  %13 = sdiv i32 %., 127773
  %14 = mul i32 %13, -127773
  %15 = add i32 %14, %.
  %16 = mul nsw i32 %15, 16807
  %17 = mul i32 %13, -2836
  %18 = add i32 %16, %17
  %19 = icmp slt i32 %18, 0
  %20 = add nsw i32 %18, 2147483647
  %..1 = select i1 %19, i32 %20, i32 %18
  %21 = or i64 %4, 3
  %22 = getelementptr inbounds i32* %iv, i64 %21
  store i32 %..1, i32* %22, align 4, !tbaa !1
  %23 = sdiv i32 %..1, 127773
  %24 = mul i32 %23, -127773
  %25 = add i32 %24, %..1
  %26 = mul nsw i32 %25, 16807
  %27 = mul i32 %23, -2836
  %28 = add i32 %26, %27
  %29 = icmp slt i32 %28, 0
  %30 = add nsw i32 %28, 2147483647
  %..2 = select i1 %29, i32 %30, i32 %28
  %31 = or i64 %4, 2
  %32 = getelementptr inbounds i32* %iv, i64 %31
  store i32 %..2, i32* %32, align 4, !tbaa !1
  %33 = sdiv i32 %..2, 127773
  %34 = mul i32 %33, -127773
  %35 = add i32 %34, %..2
  %36 = mul nsw i32 %35, 16807
  %37 = mul i32 %33, -2836
  %38 = add i32 %36, %37
  %39 = icmp slt i32 %38, 0
  %40 = add nsw i32 %38, 2147483647
  %..3 = select i1 %39, i32 %40, i32 %38
  %41 = or i64 %4, 1
  %42 = getelementptr inbounds i32* %iv, i64 %41
  store i32 %..3, i32* %42, align 4, !tbaa !1
  %43 = sdiv i32 %..3, 127773
  %44 = mul i32 %43, -127773
  %45 = add i32 %44, %..3
  %46 = mul nsw i32 %45, 16807
  %47 = mul i32 %43, -2836
  %48 = add i32 %46, %47
  %49 = add nsw i32 %48, 2147483647
  %50 = icmp slt i32 %48, 0
  %..4 = select i1 %50, i32 %49, i32 %48
  %51 = getelementptr inbounds i32* %iv, i64 %4
  store i32 %..4, i32* %51, align 4, !tbaa !1
  %52 = load i32* %iv, align 4, !tbaa !1
  %53 = sdiv i32 %52, 536870912
  %54 = add nsw i32 %53, %3
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds i32* %iv, i64 %55
  %57 = load i32* %56, align 4, !tbaa !1
  %58 = sitofp i32 %57 to float
  %59 = fmul float %58, 0x3E00000000000000
  ret float %59
}

declare i64 @get_local_id(i32) #1

; Function Attrs: nounwind uwtable
define double @BoxMuller(double %uniform.coerce) #0 {
  %1 = bitcast double %uniform.coerce to <2 x float>
  %2 = extractelement <2 x float> %1, i32 0
  %3 = tail call float @llvm.log2.f32(float %2)
  %4 = fmul float %3, 0x3FE62E4300000000
  %5 = fmul float %4, -2.000000e+00
  %6 = tail call float @llvm.sqrt.f32(float %5)
  %7 = extractelement <2 x float> %1, i32 1
  %8 = fmul float %7, 0x40191EB860000000
  %9 = tail call float @_Z3sinf(float %8) #3
  %10 = fmul float %6, %9
  %11 = insertelement <2 x float> undef, float %10, i32 0
  %12 = tail call float @_Z3cosf(float %8) #3
  %13 = fmul float %6, %12
  %14 = insertelement <2 x float> %11, float %13, i32 1
  %15 = bitcast <2 x float> %14 to double
  ret double %15
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/SimpleConvolution_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @simpleConvolution(i32* nocapture %output, i32* nocapture readonly %input, float* nocapture readonly %mask, double %inputDimensions.coerce, double %maskDimensions.coerce) #0 {
  %1 = bitcast double %inputDimensions.coerce to <2 x i32>
  %2 = bitcast double %maskDimensions.coerce to <2 x i32>
  %3 = tail call i64 @get_global_id(i32 0) #2
  %4 = trunc i64 %3 to i32
  %5 = extractelement <2 x i32> %1, i32 0
  %6 = extractelement <2 x i32> %1, i32 1
  %7 = urem i32 %4, %5
  %8 = udiv i32 %4, %5
  %9 = extractelement <2 x i32> %2, i32 0
  %10 = extractelement <2 x i32> %2, i32 1
  %11 = add i32 %9, -1
  %12 = lshr i32 %11, 1
  %13 = add i32 %10, -1
  %14 = lshr i32 %13, 1
  %15 = icmp ult i32 %7, %12
  %16 = sub i32 %7, %12
  %. = select i1 %15, i32 0, i32 %16
  %17 = add i32 %7, %12
  %18 = icmp ult i32 %17, %5
  %19 = add i32 %5, -1
  %20 = select i1 %18, i32 %17, i32 %19
  %21 = icmp ult i32 %8, %14
  %22 = sub i32 %8, %14
  %.1 = select i1 %21, i32 0, i32 %22
  %23 = add i32 %8, %14
  %24 = icmp ult i32 %23, %6
  %25 = add i32 %6, -1
  %26 = select i1 %24, i32 %23, i32 %25
  %27 = icmp ugt i32 %., %20
  br i1 %27, label %._crit_edge7, label %.preheader.lr.ph

.preheader.lr.ph:                                 ; preds = %0
  %28 = icmp ugt i32 %.1, %26
  %29 = sub i32 %14, %8
  %30 = sub i32 %12, %7
  br label %.preheader

.preheader:                                       ; preds = %.preheader.lr.ph, %._crit_edge
  %sumFX.06 = phi float [ 0.000000e+00, %.preheader.lr.ph ], [ %sumFX.1.lcssa, %._crit_edge ]
  %i.05 = phi i32 [ %., %.preheader.lr.ph ], [ %49, %._crit_edge ]
  br i1 %28, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.preheader
  %31 = add i32 %30, %i.05
  br label %32

; <label>:32                                      ; preds = %.lr.ph, %32
  %sumFX.14 = phi float [ %sumFX.06, %.lr.ph ], [ %46, %32 ]
  %j.03 = phi i32 [ %.1, %.lr.ph ], [ %47, %32 ]
  %33 = add i32 %29, %j.03
  %34 = mul i32 %33, %9
  %35 = add i32 %31, %34
  %36 = mul i32 %j.03, %5
  %37 = add i32 %36, %i.05
  %38 = zext i32 %37 to i64
  %39 = getelementptr inbounds i32* %input, i64 %38
  %40 = load i32* %39, align 4, !tbaa !2
  %41 = uitofp i32 %40 to float
  %42 = zext i32 %35 to i64
  %43 = getelementptr inbounds float* %mask, i64 %42
  %44 = load float* %43, align 4, !tbaa !6
  %45 = fmul float %41, %44
  %46 = fadd float %sumFX.14, %45
  %47 = add i32 %j.03, 1
  %48 = icmp ugt i32 %47, %26
  br i1 %48, label %._crit_edge, label %32

._crit_edge:                                      ; preds = %32, %.preheader
  %sumFX.1.lcssa = phi float [ %sumFX.06, %.preheader ], [ %46, %32 ]
  %49 = add i32 %i.05, 1
  %50 = icmp ugt i32 %49, %20
  br i1 %50, label %._crit_edge7, label %.preheader

._crit_edge7:                                     ; preds = %._crit_edge, %0
  %sumFX.0.lcssa = phi float [ 0.000000e+00, %0 ], [ %sumFX.1.lcssa, %._crit_edge ]
  %51 = fadd float %sumFX.0.lcssa, 5.000000e-01
  %52 = fptoui float %51 to i32
  %53 = and i64 %3, 4294967295
  %54 = getelementptr inbounds i32* %output, i64 %53
  store i32 %52, i32* %54, align 4, !tbaa !2
  ret void
}

declare i64 @get_global_id(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32*, i32*, float*, double, double)* @simpleConvolution}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"float", metadata !4, i64 0}

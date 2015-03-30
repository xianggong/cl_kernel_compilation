; ModuleID = '../kernel-src/SimpleConvolution_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @simpleConvolution(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture readonly %mask, <2 x i32> %inputDimensions, <2 x i32> %maskDimensions) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = extractelement <2 x i32> %inputDimensions, i32 0
  %3 = extractelement <2 x i32> %inputDimensions, i32 1
  %4 = urem i32 %1, %2
  %5 = udiv i32 %1, %2
  %6 = extractelement <2 x i32> %maskDimensions, i32 0
  %7 = extractelement <2 x i32> %maskDimensions, i32 1
  %8 = add i32 %6, -1
  %9 = lshr i32 %8, 1
  %10 = add i32 %7, -1
  %11 = lshr i32 %10, 1
  %12 = icmp ult i32 %4, %9
  %13 = sub i32 %4, %9
  %. = select i1 %12, i32 0, i32 %13
  %14 = add i32 %4, %9
  %15 = icmp ult i32 %14, %2
  %16 = add i32 %2, -1
  %17 = select i1 %15, i32 %14, i32 %16
  %18 = icmp ult i32 %5, %11
  %19 = sub i32 %5, %11
  %.1 = select i1 %18, i32 0, i32 %19
  %20 = add i32 %5, %11
  %21 = icmp ult i32 %20, %3
  %22 = add i32 %3, -1
  %23 = select i1 %21, i32 %20, i32 %22
  %24 = icmp ugt i32 %., %17
  br i1 %24, label %._crit_edge7, label %.preheader.lr.ph

.preheader.lr.ph:                                 ; preds = %0
  %25 = icmp ugt i32 %.1, %23
  %26 = sub i32 %11, %5
  %27 = sub i32 %9, %4
  br label %.preheader

.preheader:                                       ; preds = %.preheader.lr.ph, %._crit_edge
  %sumFX.06 = phi float [ 0.000000e+00, %.preheader.lr.ph ], [ %sumFX.1.lcssa, %._crit_edge ]
  %i.05 = phi i32 [ %., %.preheader.lr.ph ], [ %46, %._crit_edge ]
  br i1 %25, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.preheader
  %28 = add i32 %27, %i.05
  br label %29

; <label>:29                                      ; preds = %.lr.ph, %29
  %sumFX.14 = phi float [ %sumFX.06, %.lr.ph ], [ %43, %29 ]
  %j.03 = phi i32 [ %.1, %.lr.ph ], [ %44, %29 ]
  %30 = add i32 %26, %j.03
  %31 = mul i32 %30, %6
  %32 = add i32 %28, %31
  %33 = mul i32 %j.03, %2
  %34 = add i32 %33, %i.05
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds i32 addrspace(1)* %input, i64 %35
  %37 = load i32 addrspace(1)* %36, align 4, !tbaa !2
  %38 = uitofp i32 %37 to float
  %39 = sext i32 %32 to i64
  %40 = getelementptr inbounds float addrspace(1)* %mask, i64 %39
  %41 = load float addrspace(1)* %40, align 4, !tbaa !6
  %42 = fmul float %38, %41
  %43 = fadd float %sumFX.14, %42
  %44 = add i32 %j.03, 1
  %45 = icmp ugt i32 %44, %23
  br i1 %45, label %._crit_edge, label %29

._crit_edge:                                      ; preds = %29, %.preheader
  %sumFX.1.lcssa = phi float [ %sumFX.06, %.preheader ], [ %43, %29 ]
  %46 = add i32 %i.05, 1
  %47 = icmp ugt i32 %46, %17
  br i1 %47, label %._crit_edge7, label %.preheader

._crit_edge7:                                     ; preds = %._crit_edge, %0
  %sumFX.0.lcssa = phi float [ 0.000000e+00, %0 ], [ %sumFX.1.lcssa, %._crit_edge ]
  %48 = fadd float %sumFX.0.lcssa, 5.000000e-01
  %49 = fptoui float %48 to i32
  %50 = sext i32 %1 to i64
  %51 = getelementptr inbounds i32 addrspace(1)* %output, i64 %50
  store i32 %49, i32 addrspace(1)* %51, align 4, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, float addrspace(1)*, <2 x i32>, <2 x i32>)* @simpleConvolution}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"float", metadata !4, i64 0}

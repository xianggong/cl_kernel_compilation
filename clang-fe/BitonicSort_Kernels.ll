; ModuleID = '../kernel-src/BitonicSort_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @bitonicSort(i32* nocapture %theArray, i32 %stage, i32 %passOfStage, i32 %direction) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = sub i32 %stage, %passOfStage
  %4 = and i32 %3, 31
  %5 = shl i32 1, %4
  %6 = shl i32 %5, 1
  %7 = add i32 %5, -1
  %8 = and i32 %2, %7
  %9 = lshr i32 %2, %4
  %10 = mul i32 %6, %9
  %11 = add i32 %10, %8
  %12 = add i32 %11, %5
  %13 = zext i32 %11 to i64
  %14 = getelementptr inbounds i32* %theArray, i64 %13
  %15 = load i32* %14, align 4, !tbaa !2
  %16 = zext i32 %12 to i64
  %17 = getelementptr inbounds i32* %theArray, i64 %16
  %18 = load i32* %17, align 4, !tbaa !2
  %19 = and i32 %stage, 31
  %20 = shl i32 1, %19
  %21 = and i32 %2, %20
  %22 = icmp eq i32 %21, 0
  %23 = sub i32 1, %direction
  %direction. = select i1 %22, i32 %direction, i32 %23
  %24 = icmp ugt i32 %15, %18
  %greater.0 = select i1 %24, i32 %15, i32 %18
  %lesser.0 = select i1 %24, i32 %18, i32 %15
  %25 = icmp eq i32 %direction., 0
  %greater.0.lesser.0 = select i1 %25, i32 %greater.0, i32 %lesser.0
  %lesser.0.greater.0 = select i1 %25, i32 %lesser.0, i32 %greater.0
  store i32 %greater.0.lesser.0, i32* %14, align 4, !tbaa !2
  store i32 %lesser.0.greater.0, i32* %17, align 4, !tbaa !2
  ret void
}

declare i64 @get_global_id(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32*, i32, i32, i32)* @bitonicSort}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

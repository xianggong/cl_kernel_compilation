; ModuleID = '../kernel-src/BitonicSort_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @bitonicSort(i32 addrspace(1)* nocapture %theArray, i32 %stage, i32 %passOfStage, i32 %direction) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = sub i32 %stage, %passOfStage
  %3 = and i32 %2, 31
  %4 = shl i32 1, %3
  %5 = shl i32 %4, 1
  %6 = add i32 %4, -1
  %7 = and i32 %1, %6
  %8 = lshr i32 %1, %3
  %9 = mul i32 %5, %8
  %10 = add i32 %9, %7
  %11 = add i32 %10, %4
  %12 = sext i32 %10 to i64
  %13 = getelementptr inbounds i32 addrspace(1)* %theArray, i64 %12
  %14 = load i32 addrspace(1)* %13, align 4, !tbaa !2
  %15 = sext i32 %11 to i64
  %16 = getelementptr inbounds i32 addrspace(1)* %theArray, i64 %15
  %17 = load i32 addrspace(1)* %16, align 4, !tbaa !2
  %18 = and i32 %stage, 31
  %19 = shl i32 1, %18
  %20 = and i32 %1, %19
  %21 = icmp eq i32 %20, 0
  %22 = sub i32 1, %direction
  %direction. = select i1 %21, i32 %direction, i32 %22
  %23 = icmp ugt i32 %14, %17
  %greater.0 = select i1 %23, i32 %14, i32 %17
  %lesser.0 = select i1 %23, i32 %17, i32 %14
  %24 = icmp eq i32 %direction., 0
  %greater.0.lesser.0 = select i1 %24, i32 %greater.0, i32 %lesser.0
  %lesser.0.greater.0 = select i1 %24, i32 %lesser.0, i32 %greater.0
  store i32 %greater.0.lesser.0, i32 addrspace(1)* %13, align 4, !tbaa !2
  store i32 %lesser.0.greater.0, i32 addrspace(1)* %16, align 4, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32, i32, i32)* @bitonicSort}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

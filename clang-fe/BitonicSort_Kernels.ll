; ModuleID = '../kernel-src/BitonicSort_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

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
  %12 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %10
  %13 = load i32 addrspace(1)* %12, align 4, !tbaa !7
  %14 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %11
  %15 = load i32 addrspace(1)* %14, align 4, !tbaa !7
  %16 = and i32 %stage, 31
  %17 = shl i32 1, %16
  %18 = and i32 %1, %17
  %19 = icmp eq i32 %18, 0
  %20 = sub i32 1, %direction
  %direction. = select i1 %19, i32 %direction, i32 %20
  %21 = icmp ugt i32 %13, %15
  %greater.0 = select i1 %21, i32 %13, i32 %15
  %lesser.0 = select i1 %21, i32 %15, i32 %13
  %22 = icmp eq i32 %direction., 0
  %greater.0.lesser.0 = select i1 %22, i32 %greater.0, i32 %lesser.0
  %lesser.0.greater.0 = select i1 %22, i32 %lesser.0, i32 %greater.0
  store i32 %greater.0.lesser.0, i32 addrspace(1)* %12, align 4, !tbaa !7
  store i32 %lesser.0.greater.0, i32 addrspace(1)* %14, align 4, !tbaa !7
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32 addrspace(1)*, i32, i32, i32)* @bitonicSort, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint*", !"uint", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"uint*", !"uint", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"const", !"const", !"const"}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}

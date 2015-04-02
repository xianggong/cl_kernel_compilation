; ModuleID = 'BitonicSort_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @bitonicSort(i32 addrspace(1)* %theArray, i32 %stage, i32 %passOfStage, i32 %direction) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = sub i32 %stage, %passOfStage
  %3 = and i32 %2, 31
  %4 = shl i32 1, %3
  %5 = mul i32 2, %4
  %6 = urem i32 %1, %4
  %7 = udiv i32 %1, %4
  %8 = mul i32 %7, %5
  %9 = add i32 %6, %8
  %10 = add i32 %9, %4
  %11 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %9
  %12 = load i32 addrspace(1)* %11, align 4
  %13 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %10
  %14 = load i32 addrspace(1)* %13, align 4
  %15 = and i32 %stage, 31
  %16 = shl i32 1, %15
  %17 = udiv i32 %1, %16
  %18 = urem i32 %17, 2
  %19 = icmp eq i32 %18, 1
  br i1 %19, label %20, label %22

; <label>:20                                      ; preds = %0
  %21 = sub i32 1, %direction
  br label %22

; <label>:22                                      ; preds = %20, %0
  %sortIncreasing.0 = phi i32 [ %21, %20 ], [ %direction, %0 ]
  %23 = icmp ugt i32 %12, %14
  br i1 %23, label %24, label %25

; <label>:24                                      ; preds = %22
  br label %26

; <label>:25                                      ; preds = %22
  br label %26

; <label>:26                                      ; preds = %25, %24
  %greater.0 = phi i32 [ %12, %24 ], [ %14, %25 ]
  %lesser.0 = phi i32 [ %14, %24 ], [ %12, %25 ]
  %27 = icmp ne i32 %sortIncreasing.0, 0
  br i1 %27, label %28, label %31

; <label>:28                                      ; preds = %26
  %29 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %9
  store i32 %lesser.0, i32 addrspace(1)* %29, align 4
  %30 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %10
  store i32 %greater.0, i32 addrspace(1)* %30, align 4
  br label %34

; <label>:31                                      ; preds = %26
  %32 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %9
  store i32 %greater.0, i32 addrspace(1)* %32, align 4
  %33 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %10
  store i32 %lesser.0, i32 addrspace(1)* %33, align 4
  br label %34

; <label>:34                                      ; preds = %31, %28
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32, i32, i32)* @bitonicSort}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

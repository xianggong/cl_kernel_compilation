; ModuleID = '../kernel-src/BitonicSort_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @bitonicSort(i32 addrspace(1)* %theArray, i32 %stage, i32 %passOfStage, i32 %direction) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %sortIncreasing = alloca i32, align 4
  %threadId = alloca i32, align 4
  %pairDistance = alloca i32, align 4
  %blockWidth = alloca i32, align 4
  %leftId = alloca i32, align 4
  %rightId = alloca i32, align 4
  %leftElement = alloca i32, align 4
  %rightElement = alloca i32, align 4
  %sameDirectionBlockWidth = alloca i32, align 4
  %greater = alloca i32, align 4
  %lesser = alloca i32, align 4
  store i32 addrspace(1)* %theArray, i32 addrspace(1)** %1, align 4
  store i32 %stage, i32* %2, align 4
  store i32 %passOfStage, i32* %3, align 4
  store i32 %direction, i32* %4, align 4
  %5 = load i32* %4, align 4
  store i32 %5, i32* %sortIncreasing, align 4
  %6 = call i32 @get_global_id(i32 0)
  store i32 %6, i32* %threadId, align 4
  %7 = load i32* %2, align 4
  %8 = load i32* %3, align 4
  %9 = sub i32 %7, %8
  %10 = and i32 %9, 31
  %11 = shl i32 1, %10
  store i32 %11, i32* %pairDistance, align 4
  %12 = load i32* %pairDistance, align 4
  %13 = mul i32 2, %12
  store i32 %13, i32* %blockWidth, align 4
  %14 = load i32* %threadId, align 4
  %15 = load i32* %pairDistance, align 4
  %16 = urem i32 %14, %15
  %17 = load i32* %threadId, align 4
  %18 = load i32* %pairDistance, align 4
  %19 = udiv i32 %17, %18
  %20 = load i32* %blockWidth, align 4
  %21 = mul i32 %19, %20
  %22 = add i32 %16, %21
  store i32 %22, i32* %leftId, align 4
  %23 = load i32* %leftId, align 4
  %24 = load i32* %pairDistance, align 4
  %25 = add i32 %23, %24
  store i32 %25, i32* %rightId, align 4
  %26 = load i32* %leftId, align 4
  %27 = load i32 addrspace(1)** %1, align 4
  %28 = getelementptr inbounds i32 addrspace(1)* %27, i32 %26
  %29 = load i32 addrspace(1)* %28, align 4
  store i32 %29, i32* %leftElement, align 4
  %30 = load i32* %rightId, align 4
  %31 = load i32 addrspace(1)** %1, align 4
  %32 = getelementptr inbounds i32 addrspace(1)* %31, i32 %30
  %33 = load i32 addrspace(1)* %32, align 4
  store i32 %33, i32* %rightElement, align 4
  %34 = load i32* %2, align 4
  %35 = and i32 %34, 31
  %36 = shl i32 1, %35
  store i32 %36, i32* %sameDirectionBlockWidth, align 4
  %37 = load i32* %threadId, align 4
  %38 = load i32* %sameDirectionBlockWidth, align 4
  %39 = udiv i32 %37, %38
  %40 = urem i32 %39, 2
  %41 = icmp eq i32 %40, 1
  br i1 %41, label %42, label %45

; <label>:42                                      ; preds = %0
  %43 = load i32* %sortIncreasing, align 4
  %44 = sub i32 1, %43
  store i32 %44, i32* %sortIncreasing, align 4
  br label %45

; <label>:45                                      ; preds = %42, %0
  %46 = load i32* %leftElement, align 4
  %47 = load i32* %rightElement, align 4
  %48 = icmp ugt i32 %46, %47
  br i1 %48, label %49, label %52

; <label>:49                                      ; preds = %45
  %50 = load i32* %leftElement, align 4
  store i32 %50, i32* %greater, align 4
  %51 = load i32* %rightElement, align 4
  store i32 %51, i32* %lesser, align 4
  br label %55

; <label>:52                                      ; preds = %45
  %53 = load i32* %rightElement, align 4
  store i32 %53, i32* %greater, align 4
  %54 = load i32* %leftElement, align 4
  store i32 %54, i32* %lesser, align 4
  br label %55

; <label>:55                                      ; preds = %52, %49
  %56 = load i32* %sortIncreasing, align 4
  %57 = icmp ne i32 %56, 0
  br i1 %57, label %58, label %67

; <label>:58                                      ; preds = %55
  %59 = load i32* %lesser, align 4
  %60 = load i32* %leftId, align 4
  %61 = load i32 addrspace(1)** %1, align 4
  %62 = getelementptr inbounds i32 addrspace(1)* %61, i32 %60
  store i32 %59, i32 addrspace(1)* %62, align 4
  %63 = load i32* %greater, align 4
  %64 = load i32* %rightId, align 4
  %65 = load i32 addrspace(1)** %1, align 4
  %66 = getelementptr inbounds i32 addrspace(1)* %65, i32 %64
  store i32 %63, i32 addrspace(1)* %66, align 4
  br label %76

; <label>:67                                      ; preds = %55
  %68 = load i32* %greater, align 4
  %69 = load i32* %leftId, align 4
  %70 = load i32 addrspace(1)** %1, align 4
  %71 = getelementptr inbounds i32 addrspace(1)* %70, i32 %69
  store i32 %68, i32 addrspace(1)* %71, align 4
  %72 = load i32* %lesser, align 4
  %73 = load i32* %rightId, align 4
  %74 = load i32 addrspace(1)** %1, align 4
  %75 = getelementptr inbounds i32 addrspace(1)* %74, i32 %73
  store i32 %72, i32 addrspace(1)* %75, align 4
  br label %76

; <label>:76                                      ; preds = %67, %58
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32, i32, i32)* @bitonicSort}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

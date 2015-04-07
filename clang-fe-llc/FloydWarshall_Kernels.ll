; ModuleID = '../kernel-src/FloydWarshall_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @floydWarshallPass(i32 addrspace(1)* %pathDistanceBuffer, i32 addrspace(1)* %pathBuffer, i32 %numNodes, i32 %pass) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %xValue = alloca i32, align 4
  %yValue = alloca i32, align 4
  %k = alloca i32, align 4
  %oldWeight = alloca i32, align 4
  %tempWeight = alloca i32, align 4
  store i32 addrspace(1)* %pathDistanceBuffer, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %pathBuffer, i32 addrspace(1)** %2, align 4
  store i32 %numNodes, i32* %3, align 4
  store i32 %pass, i32* %4, align 4
  %5 = call i32 @llvm.r600.read.tgid.x()
  store i32 %5, i32* %xValue, align 4
  %6 = call i32 @llvm.r600.read.tgid.y()
  store i32 %6, i32* %yValue, align 4
  %7 = load i32* %4, align 4
  store i32 %7, i32* %k, align 4
  %8 = load i32* %yValue, align 4
  %9 = load i32* %3, align 4
  %10 = mul i32 %8, %9
  %11 = load i32* %xValue, align 4
  %12 = add i32 %10, %11
  %13 = load i32 addrspace(1)** %1, align 4
  %14 = getelementptr inbounds i32 addrspace(1)* %13, i32 %12
  %15 = load i32 addrspace(1)* %14, align 4
  store i32 %15, i32* %oldWeight, align 4
  %16 = load i32* %yValue, align 4
  %17 = load i32* %3, align 4
  %18 = mul i32 %16, %17
  %19 = load i32* %k, align 4
  %20 = add i32 %18, %19
  %21 = load i32 addrspace(1)** %1, align 4
  %22 = getelementptr inbounds i32 addrspace(1)* %21, i32 %20
  %23 = load i32 addrspace(1)* %22, align 4
  %24 = load i32* %k, align 4
  %25 = load i32* %3, align 4
  %26 = mul i32 %24, %25
  %27 = load i32* %xValue, align 4
  %28 = add i32 %26, %27
  %29 = load i32 addrspace(1)** %1, align 4
  %30 = getelementptr inbounds i32 addrspace(1)* %29, i32 %28
  %31 = load i32 addrspace(1)* %30, align 4
  %32 = add i32 %23, %31
  store i32 %32, i32* %tempWeight, align 4
  %33 = load i32* %tempWeight, align 4
  %34 = load i32* %oldWeight, align 4
  %35 = icmp slt i32 %33, %34
  br i1 %35, label %36, label %53

; <label>:36                                      ; preds = %0
  %37 = load i32* %tempWeight, align 4
  %38 = load i32* %yValue, align 4
  %39 = load i32* %3, align 4
  %40 = mul i32 %38, %39
  %41 = load i32* %xValue, align 4
  %42 = add i32 %40, %41
  %43 = load i32 addrspace(1)** %1, align 4
  %44 = getelementptr inbounds i32 addrspace(1)* %43, i32 %42
  store i32 %37, i32 addrspace(1)* %44, align 4
  %45 = load i32* %k, align 4
  %46 = load i32* %yValue, align 4
  %47 = load i32* %3, align 4
  %48 = mul i32 %46, %47
  %49 = load i32* %xValue, align 4
  %50 = add i32 %48, %49
  %51 = load i32 addrspace(1)** %2, align 4
  %52 = getelementptr inbounds i32 addrspace(1)* %51, i32 %50
  store i32 %45, i32 addrspace(1)* %52, align 4
  br label %53

; <label>:53                                      ; preds = %36, %0
  ret void
}

declare i32 @llvm.r600.read.tgid.x() #1
declare i32 @llvm.r600.read.tgid.y() #1
declare i32 @llvm.r600.read.tgid.z() #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32)* @floydWarshallPass}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

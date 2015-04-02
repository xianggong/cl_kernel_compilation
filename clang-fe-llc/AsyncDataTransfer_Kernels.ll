; ModuleID = '../kernel-src/AsyncDataTransfer_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @work(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %gSize = alloca i32, align 4
  %gId = alloca i32, align 4
  %tmp = alloca i32, align 4
  %zero = alloca i32, align 4
  %i = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %multiplier, i32* %3, align 4
  %4 = call i32 @get_global_size(i32 0)
  store i32 %4, i32* %gSize, align 4
  %5 = call i32 @get_global_id(i32 0)
  store i32 %5, i32* %gId, align 4
  store i32 1, i32* %tmp, align 4
  store volatile i32 0, i32* %zero, align 4
  store i32 5, i32* %i, align 4
  br label %6

; <label>:6                                       ; preds = %56, %0
  %7 = load i32* %i, align 4
  %8 = icmp slt i32 %7, 100
  br i1 %8, label %9, label %59

; <label>:9                                       ; preds = %6
  %10 = load i32* %i, align 4
  %11 = mul nsw i32 %10, 1
  %12 = load i32* %gSize, align 4
  %13 = srem i32 %11, %12
  %14 = load i8 addrspace(1)** %1, align 4
  %15 = getelementptr inbounds i8 addrspace(1)* %14, i32 %13
  %16 = load i8 addrspace(1)* %15, align 1
  %17 = zext i8 %16 to i32
  %18 = load i32* %i, align 4
  %19 = mul nsw i32 %18, 2
  %20 = load i32* %gSize, align 4
  %21 = srem i32 %19, %20
  %22 = load i8 addrspace(1)** %1, align 4
  %23 = getelementptr inbounds i8 addrspace(1)* %22, i32 %21
  %24 = load i8 addrspace(1)* %23, align 1
  %25 = zext i8 %24 to i32
  %26 = add nsw i32 %17, %25
  %27 = load i32* %i, align 4
  %28 = mul nsw i32 %27, 3
  %29 = load i32* %gSize, align 4
  %30 = srem i32 %28, %29
  %31 = load i8 addrspace(1)** %1, align 4
  %32 = getelementptr inbounds i8 addrspace(1)* %31, i32 %30
  %33 = load i8 addrspace(1)* %32, align 1
  %34 = zext i8 %33 to i32
  %35 = add nsw i32 %26, %34
  %36 = load i32* %i, align 4
  %37 = mul nsw i32 %36, 4
  %38 = load i32* %gSize, align 4
  %39 = srem i32 %37, %38
  %40 = load i8 addrspace(1)** %1, align 4
  %41 = getelementptr inbounds i8 addrspace(1)* %40, i32 %39
  %42 = load i8 addrspace(1)* %41, align 1
  %43 = zext i8 %42 to i32
  %44 = add nsw i32 %35, %43
  %45 = load i32* %i, align 4
  %46 = mul nsw i32 %45, 5
  %47 = load i32* %gSize, align 4
  %48 = srem i32 %46, %47
  %49 = load i8 addrspace(1)** %1, align 4
  %50 = getelementptr inbounds i8 addrspace(1)* %49, i32 %48
  %51 = load i8 addrspace(1)* %50, align 1
  %52 = zext i8 %51 to i32
  %53 = add nsw i32 %44, %52
  %54 = load i32* %tmp, align 4
  %55 = add i32 %54, %53
  store i32 %55, i32* %tmp, align 4
  br label %56

; <label>:56                                      ; preds = %9
  %57 = load i32* %i, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, i32* %i, align 4
  br label %6

; <label>:59                                      ; preds = %6
  %60 = load i32* %gId, align 4
  %61 = load i8 addrspace(1)** %1, align 4
  %62 = getelementptr inbounds i8 addrspace(1)* %61, i32 %60
  %63 = load i8 addrspace(1)* %62, align 1
  %64 = zext i8 %63 to i32
  %65 = load i32* %3, align 4
  %66 = mul nsw i32 %64, %65
  %67 = srem i32 %66, 256
  %68 = load volatile i32* %zero, align 4
  %69 = load i32* %tmp, align 4
  %70 = mul i32 %68, %69
  %71 = add i32 %67, %70
  %72 = trunc i32 %71 to i8
  %73 = load i32* %gId, align 4
  %74 = load i8 addrspace(1)** %2, align 4
  %75 = getelementptr inbounds i8 addrspace(1)* %74, i32 %73
  store i8 %72, i8 addrspace(1)* %75, align 1
  ret void
}

declare i32 @get_global_size(i32) #1

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32)* @work}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

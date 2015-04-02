; ModuleID = 'AsyncDataTransfer_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @work(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %multiplier) #0 {
  %zero = alloca i32, align 4
  %1 = call i32 @get_global_size(i32 0)
  %2 = call i32 @get_global_id(i32 0)
  store volatile i32 0, i32* %zero, align 4
  br label %3

; <label>:3                                       ; preds = %36, %0
  %tmp.0 = phi i32 [ 1, %0 ], [ %35, %36 ]
  %i.0 = phi i32 [ 5, %0 ], [ %37, %36 ]
  %4 = icmp slt i32 %i.0, 100
  br i1 %4, label %5, label %38

; <label>:5                                       ; preds = %3
  %6 = mul nsw i32 %i.0, 1
  %7 = srem i32 %6, %1
  %8 = getelementptr inbounds i8 addrspace(1)* %input, i32 %7
  %9 = load i8 addrspace(1)* %8, align 1
  %10 = zext i8 %9 to i32
  %11 = mul nsw i32 %i.0, 2
  %12 = srem i32 %11, %1
  %13 = getelementptr inbounds i8 addrspace(1)* %input, i32 %12
  %14 = load i8 addrspace(1)* %13, align 1
  %15 = zext i8 %14 to i32
  %16 = add nsw i32 %10, %15
  %17 = mul nsw i32 %i.0, 3
  %18 = srem i32 %17, %1
  %19 = getelementptr inbounds i8 addrspace(1)* %input, i32 %18
  %20 = load i8 addrspace(1)* %19, align 1
  %21 = zext i8 %20 to i32
  %22 = add nsw i32 %16, %21
  %23 = mul nsw i32 %i.0, 4
  %24 = srem i32 %23, %1
  %25 = getelementptr inbounds i8 addrspace(1)* %input, i32 %24
  %26 = load i8 addrspace(1)* %25, align 1
  %27 = zext i8 %26 to i32
  %28 = add nsw i32 %22, %27
  %29 = mul nsw i32 %i.0, 5
  %30 = srem i32 %29, %1
  %31 = getelementptr inbounds i8 addrspace(1)* %input, i32 %30
  %32 = load i8 addrspace(1)* %31, align 1
  %33 = zext i8 %32 to i32
  %34 = add nsw i32 %28, %33
  %35 = add i32 %tmp.0, %34
  br label %36

; <label>:36                                      ; preds = %5
  %37 = add nsw i32 %i.0, 1
  br label %3

; <label>:38                                      ; preds = %3
  %39 = getelementptr inbounds i8 addrspace(1)* %input, i32 %2
  %40 = load i8 addrspace(1)* %39, align 1
  %41 = zext i8 %40 to i32
  %42 = mul nsw i32 %41, %multiplier
  %43 = srem i32 %42, 256
  %44 = load volatile i32* %zero, align 4
  %45 = mul i32 %44, %tmp.0
  %46 = add i32 %43, %45
  %47 = trunc i32 %46 to i8
  %48 = getelementptr inbounds i8 addrspace(1)* %output, i32 %2
  store i8 %47, i8 addrspace(1)* %48, align 1
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

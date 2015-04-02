; ModuleID = '../kernel-src/BinarySearch_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @binarySearch(<4 x i32> addrspace(1)* %outputArray, i32 addrspace(1)* %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) #0 {
  %1 = alloca <4 x i32> addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %tid = alloca i32, align 4
  %elementLower = alloca i32, align 4
  %elementUpper = alloca i32, align 4
  store <4 x i32> addrspace(1)* %outputArray, <4 x i32> addrspace(1)** %1, align 4
  store i32 addrspace(1)* %sortedArray, i32 addrspace(1)** %2, align 4
  store i32 %subdivSize, i32* %3, align 4
  store i32 %globalLowerIndex, i32* %4, align 4
  store i32 %findMe, i32* %5, align 4
  %6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %6, i32* %tid, align 4
  %7 = load i32* %4, align 4
  %8 = load i32* %tid, align 4
  %9 = load i32* %3, align 4
  %10 = mul i32 %8, %9
  %11 = add i32 %7, %10
  %12 = load i32 addrspace(1)** %2, align 4
  %13 = getelementptr inbounds i32 addrspace(1)* %12, i32 %11
  %14 = load i32 addrspace(1)* %13, align 4
  store i32 %14, i32* %elementLower, align 4
  %15 = load i32* %4, align 4
  %16 = load i32* %tid, align 4
  %17 = add i32 %16, 1
  %18 = load i32* %3, align 4
  %19 = mul i32 %17, %18
  %20 = add i32 %15, %19
  %21 = sub i32 %20, 1
  %22 = load i32 addrspace(1)** %2, align 4
  %23 = getelementptr inbounds i32 addrspace(1)* %22, i32 %21
  %24 = load i32 addrspace(1)* %23, align 4
  store i32 %24, i32* %elementUpper, align 4
  %25 = load i32* %elementLower, align 4
  %26 = load i32* %5, align 4
  %27 = icmp ugt i32 %25, %26
  br i1 %27, label %32, label %28

; <label>:28                                      ; preds = %0
  %29 = load i32* %elementUpper, align 4
  %30 = load i32* %5, align 4
  %31 = icmp ult i32 %29, %30
  br i1 %31, label %32, label %33

; <label>:32                                      ; preds = %28, %0
  br label %43

; <label>:33                                      ; preds = %28
  %34 = load i32* %tid, align 4
  %35 = load <4 x i32> addrspace(1)** %1, align 4
  %36 = getelementptr inbounds <4 x i32> addrspace(1)* %35, i32 0
  %37 = load <4 x i32> addrspace(1)* %36, align 16
  %38 = insertelement <4 x i32> %37, i32 %34, i32 0
  store <4 x i32> %38, <4 x i32> addrspace(1)* %36, align 16
  %39 = load <4 x i32> addrspace(1)** %1, align 4
  %40 = getelementptr inbounds <4 x i32> addrspace(1)* %39, i32 0
  %41 = load <4 x i32> addrspace(1)* %40, align 16
  %42 = insertelement <4 x i32> %41, i32 1, i32 3
  store <4 x i32> %42, <4 x i32> addrspace(1)* %40, align 16
  br label %43

; <label>:43                                      ; preds = %32, %33
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

; Function Attrs: nounwind
define void @binarySearch_mulkeys(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %numKeys, i32 addrspace(1)* %output) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32 addrspace(1)*, align 4
  %gid = alloca i32, align 4
  %lBound = alloca i32, align 4
  %uBound = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 addrspace(1)* %keys, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %2, align 4
  store i32 %numKeys, i32* %3, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %4, align 4
  %5 = call i32 @__get_global_id_u32(i32 0)
  store i32 %5, i32* %gid, align 4
  %6 = load i32* %gid, align 4
  %7 = mul nsw i32 %6, 256
  store i32 %7, i32* %lBound, align 4
  %8 = load i32* %lBound, align 4
  %9 = add nsw i32 %8, 255
  store i32 %9, i32* %uBound, align 4
  store i32 0, i32* %i, align 4
  br label %10

; <label>:10                                      ; preds = %40, %0
  %11 = load i32* %i, align 4
  %12 = load i32* %3, align 4
  %13 = icmp ult i32 %11, %12
  br i1 %13, label %14, label %43

; <label>:14                                      ; preds = %10
  %15 = load i32* %i, align 4
  %16 = load i32 addrspace(1)** %1, align 4
  %17 = getelementptr inbounds i32 addrspace(1)* %16, i32 %15
  %18 = load i32 addrspace(1)* %17, align 4
  %19 = load i32* %lBound, align 4
  %20 = load i32 addrspace(1)** %2, align 4
  %21 = getelementptr inbounds i32 addrspace(1)* %20, i32 %19
  %22 = load i32 addrspace(1)* %21, align 4
  %23 = icmp uge i32 %18, %22
  br i1 %23, label %24, label %39

; <label>:24                                      ; preds = %14
  %25 = load i32* %i, align 4
  %26 = load i32 addrspace(1)** %1, align 4
  %27 = getelementptr inbounds i32 addrspace(1)* %26, i32 %25
  %28 = load i32 addrspace(1)* %27, align 4
  %29 = load i32* %uBound, align 4
  %30 = load i32 addrspace(1)** %2, align 4
  %31 = getelementptr inbounds i32 addrspace(1)* %30, i32 %29
  %32 = load i32 addrspace(1)* %31, align 4
  %33 = icmp ule i32 %28, %32
  br i1 %33, label %34, label %39

; <label>:34                                      ; preds = %24
  %35 = load i32* %lBound, align 4
  %36 = load i32* %i, align 4
  %37 = load i32 addrspace(1)** %4, align 4
  %38 = getelementptr inbounds i32 addrspace(1)* %37, i32 %36
  store i32 %35, i32 addrspace(1)* %38, align 4
  br label %39

; <label>:39                                      ; preds = %34, %24, %14
  br label %40

; <label>:40                                      ; preds = %39
  %41 = load i32* %i, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %i, align 4
  br label %10

; <label>:43                                      ; preds = %10
  ret void
}

; Function Attrs: nounwind
define void @binarySearch_mulkeysConcurrent(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %inputSize, i32 %numSubdivisions, i32 addrspace(1)* %output) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32 addrspace(1)*, align 4
  %lBound = alloca i32, align 4
  %uBound = alloca i32, align 4
  %myKey = alloca i32, align 4
  %mid = alloca i32, align 4
  store i32 addrspace(1)* %keys, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %2, align 4
  store i32 %inputSize, i32* %3, align 4
  store i32 %numSubdivisions, i32* %4, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %5, align 4
  %6 = call i32 @__get_global_id_u32(i32 0)
  %7 = load i32* %4, align 4
  %8 = urem i32 %6, %7
  %9 = load i32* %3, align 4
  %10 = load i32* %4, align 4
  %11 = udiv i32 %9, %10
  %12 = mul i32 %8, %11
  store i32 %12, i32* %lBound, align 4
  %13 = load i32* %lBound, align 4
  %14 = load i32* %3, align 4
  %15 = load i32* %4, align 4
  %16 = udiv i32 %14, %15
  %17 = add i32 %13, %16
  store i32 %17, i32* %uBound, align 4
  %18 = call i32 @__get_global_id_u32(i32 0)
  %19 = load i32* %4, align 4
  %20 = udiv i32 %18, %19
  %21 = load i32 addrspace(1)** %1, align 4
  %22 = getelementptr inbounds i32 addrspace(1)* %21, i32 %20
  %23 = load i32 addrspace(1)* %22, align 4
  store i32 %23, i32* %myKey, align 4
  br label %24

; <label>:24                                      ; preds = %60, %0
  %25 = load i32* %uBound, align 4
  %26 = load i32* %lBound, align 4
  %27 = icmp sge i32 %25, %26
  br i1 %27, label %28, label %61

; <label>:28                                      ; preds = %24
  %29 = load i32* %lBound, align 4
  %30 = load i32* %uBound, align 4
  %31 = add nsw i32 %29, %30
  %32 = sdiv i32 %31, 2
  store i32 %32, i32* %mid, align 4
  %33 = load i32* %mid, align 4
  %34 = load i32 addrspace(1)** %2, align 4
  %35 = getelementptr inbounds i32 addrspace(1)* %34, i32 %33
  %36 = load i32 addrspace(1)* %35, align 4
  %37 = load i32* %myKey, align 4
  %38 = icmp eq i32 %36, %37
  br i1 %38, label %39, label %46

; <label>:39                                      ; preds = %28
  %40 = load i32* %mid, align 4
  %41 = call i32 @__get_global_id_u32(i32 0)
  %42 = load i32* %4, align 4
  %43 = udiv i32 %41, %42
  %44 = load i32 addrspace(1)** %5, align 4
  %45 = getelementptr inbounds i32 addrspace(1)* %44, i32 %43
  store i32 %40, i32 addrspace(1)* %45, align 4
  br label %61

; <label>:46                                      ; preds = %28
  %47 = load i32* %mid, align 4
  %48 = load i32 addrspace(1)** %2, align 4
  %49 = getelementptr inbounds i32 addrspace(1)* %48, i32 %47
  %50 = load i32 addrspace(1)* %49, align 4
  %51 = load i32* %myKey, align 4
  %52 = icmp ugt i32 %50, %51
  br i1 %52, label %53, label %56

; <label>:53                                      ; preds = %46
  %54 = load i32* %mid, align 4
  %55 = sub nsw i32 %54, 1
  store i32 %55, i32* %uBound, align 4
  br label %59

; <label>:56                                      ; preds = %46
  %57 = load i32* %mid, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, i32* %lBound, align 4
  br label %59

; <label>:59                                      ; preds = %56, %53
  br label %60

; <label>:60                                      ; preds = %59
  br label %24

; <label>:61                                      ; preds = %39, %24
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @binarySearch}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(1)*)* @binarySearch_mulkeys}
!2 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32, i32 addrspace(1)*)* @binarySearch_mulkeysConcurrent}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

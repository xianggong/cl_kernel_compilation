; ModuleID = '../kernel-src/ConcurrentKernel_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@K2.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K4.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K6.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K8.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K10.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1

; Function Attrs: nounwind
define void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %gSize = alloca i32, align 4
  %gId = alloca i32, align 4
  %lId = alloca i32, align 4
  %tmp = alloca i32, align 4
  %zero = alloca i32, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = call i32 @get_global_size(i32 0)
  store i32 %5, i32* %gSize, align 4
  %6 = call i32 @get_global_id(i32 0)
  store i32 %6, i32* %gId, align 4
  %7 = call i32 @get_local_id(i32 0)
  store i32 %7, i32* %lId, align 4
  store i32 1, i32* %tmp, align 4
  store volatile i32 0, i32* %zero, align 4
  store i32 1, i32* %i, align 4
  br label %8

; <label>:8                                       ; preds = %58, %0
  %9 = load i32* %i, align 4
  %10 = icmp slt i32 %9, 5000
  br i1 %10, label %11, label %61

; <label>:11                                      ; preds = %8
  %12 = load i32* %i, align 4
  %13 = mul nsw i32 %12, 1
  %14 = load i32* %3, align 4
  %15 = urem i32 %13, %14
  %16 = load i8 addrspace(1)** %1, align 4
  %17 = getelementptr inbounds i8 addrspace(1)* %16, i32 %15
  %18 = load i8 addrspace(1)* %17, align 1
  %19 = zext i8 %18 to i32
  %20 = load i32* %i, align 4
  %21 = mul nsw i32 %20, 2
  %22 = load i32* %3, align 4
  %23 = urem i32 %21, %22
  %24 = load i8 addrspace(1)** %1, align 4
  %25 = getelementptr inbounds i8 addrspace(1)* %24, i32 %23
  %26 = load i8 addrspace(1)* %25, align 1
  %27 = zext i8 %26 to i32
  %28 = add nsw i32 %19, %27
  %29 = load i32* %i, align 4
  %30 = mul nsw i32 %29, 3
  %31 = load i32* %3, align 4
  %32 = urem i32 %30, %31
  %33 = load i8 addrspace(1)** %1, align 4
  %34 = getelementptr inbounds i8 addrspace(1)* %33, i32 %32
  %35 = load i8 addrspace(1)* %34, align 1
  %36 = zext i8 %35 to i32
  %37 = add nsw i32 %28, %36
  %38 = load i32* %i, align 4
  %39 = mul nsw i32 %38, 4
  %40 = load i32* %3, align 4
  %41 = urem i32 %39, %40
  %42 = load i8 addrspace(1)** %1, align 4
  %43 = getelementptr inbounds i8 addrspace(1)* %42, i32 %41
  %44 = load i8 addrspace(1)* %43, align 1
  %45 = zext i8 %44 to i32
  %46 = add nsw i32 %37, %45
  %47 = load i32* %i, align 4
  %48 = mul nsw i32 %47, 5
  %49 = load i32* %3, align 4
  %50 = urem i32 %48, %49
  %51 = load i8 addrspace(1)** %1, align 4
  %52 = getelementptr inbounds i8 addrspace(1)* %51, i32 %50
  %53 = load i8 addrspace(1)* %52, align 1
  %54 = zext i8 %53 to i32
  %55 = add nsw i32 %46, %54
  %56 = load i32* %tmp, align 4
  %57 = add i32 %56, %55
  store i32 %57, i32* %tmp, align 4
  br label %58

; <label>:58                                      ; preds = %11
  %59 = load i32* %i, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, i32* %i, align 4
  br label %8

; <label>:61                                      ; preds = %8
  %62 = load i32* %gId, align 4
  store i32 %62, i32* %i1, align 4
  br label %63

; <label>:63                                      ; preds = %84, %61
  %64 = load i32* %i1, align 4
  %65 = load i32* %3, align 4
  %66 = icmp ult i32 %64, %65
  br i1 %66, label %67, label %88

; <label>:67                                      ; preds = %63
  %68 = load i32* %i1, align 4
  %69 = load i8 addrspace(1)** %1, align 4
  %70 = getelementptr inbounds i8 addrspace(1)* %69, i32 %68
  %71 = load i8 addrspace(1)* %70, align 1
  %72 = zext i8 %71 to i32
  %73 = load i32* %4, align 4
  %74 = mul nsw i32 %72, %73
  %75 = srem i32 %74, 256
  %76 = load volatile i32* %zero, align 4
  %77 = load i32* %tmp, align 4
  %78 = mul i32 %76, %77
  %79 = add i32 %75, %78
  %80 = trunc i32 %79 to i8
  %81 = load i32* %i1, align 4
  %82 = load i8 addrspace(1)** %2, align 4
  %83 = getelementptr inbounds i8 addrspace(1)* %82, i32 %81
  store i8 %80, i8 addrspace(1)* %83, align 1
  br label %84

; <label>:84                                      ; preds = %67
  %85 = load i32* %gSize, align 4
  %86 = load i32* %i1, align 4
  %87 = add i32 %86, %85
  store i32 %87, i32* %i1, align 4
  br label %63

; <label>:88                                      ; preds = %63
  ret void
}

declare i32 @get_global_size(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* %lds) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8 addrspace(3)*, align 4
  %gSize = alloca i32, align 4
  %gId = alloca i32, align 4
  %lId = alloca i32, align 4
  %tmp = alloca i32, align 4
  %zero = alloca i32, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  store i8 addrspace(3)* %lds, i8 addrspace(3)** %5, align 4
  %6 = call i32 @get_global_size(i32 0)
  store i32 %6, i32* %gSize, align 4
  %7 = call i32 @get_global_id(i32 0)
  store i32 %7, i32* %gId, align 4
  %8 = call i32 @get_local_id(i32 0)
  store i32 %8, i32* %lId, align 4
  store i32 1, i32* %tmp, align 4
  store volatile i32 0, i32* %zero, align 4
  store i32 1, i32* %i, align 4
  br label %9

; <label>:9                                       ; preds = %59, %0
  %10 = load i32* %i, align 4
  %11 = icmp slt i32 %10, 10000
  br i1 %11, label %12, label %62

; <label>:12                                      ; preds = %9
  %13 = load i32* %i, align 4
  %14 = mul nsw i32 %13, 2
  %15 = load i32* %3, align 4
  %16 = urem i32 %14, %15
  %17 = load i8 addrspace(1)** %1, align 4
  %18 = getelementptr inbounds i8 addrspace(1)* %17, i32 %16
  %19 = load i8 addrspace(1)* %18, align 1
  %20 = zext i8 %19 to i32
  %21 = load i32* %i, align 4
  %22 = mul nsw i32 %21, 4
  %23 = load i32* %3, align 4
  %24 = urem i32 %22, %23
  %25 = load i8 addrspace(1)** %1, align 4
  %26 = getelementptr inbounds i8 addrspace(1)* %25, i32 %24
  %27 = load i8 addrspace(1)* %26, align 1
  %28 = zext i8 %27 to i32
  %29 = sub nsw i32 %20, %28
  %30 = load i32* %i, align 4
  %31 = mul nsw i32 %30, 6
  %32 = load i32* %3, align 4
  %33 = urem i32 %31, %32
  %34 = load i8 addrspace(1)** %1, align 4
  %35 = getelementptr inbounds i8 addrspace(1)* %34, i32 %33
  %36 = load i8 addrspace(1)* %35, align 1
  %37 = zext i8 %36 to i32
  %38 = add nsw i32 %29, %37
  %39 = load i32* %i, align 4
  %40 = mul nsw i32 %39, 8
  %41 = load i32* %3, align 4
  %42 = urem i32 %40, %41
  %43 = load i8 addrspace(1)** %1, align 4
  %44 = getelementptr inbounds i8 addrspace(1)* %43, i32 %42
  %45 = load i8 addrspace(1)* %44, align 1
  %46 = zext i8 %45 to i32
  %47 = sub nsw i32 %38, %46
  %48 = load i32* %i, align 4
  %49 = mul nsw i32 %48, 10
  %50 = load i32* %3, align 4
  %51 = urem i32 %49, %50
  %52 = load i8 addrspace(1)** %1, align 4
  %53 = getelementptr inbounds i8 addrspace(1)* %52, i32 %51
  %54 = load i8 addrspace(1)* %53, align 1
  %55 = zext i8 %54 to i32
  %56 = add nsw i32 %47, %55
  %57 = load i32* %tmp, align 4
  %58 = add nsw i32 %57, %56
  store i32 %58, i32* %tmp, align 4
  br label %59

; <label>:59                                      ; preds = %12
  %60 = load i32* %i, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, i32* %i, align 4
  br label %9

; <label>:62                                      ; preds = %9
  %63 = load i32* %gId, align 4
  store i32 %63, i32* %i1, align 4
  br label %64

; <label>:64                                      ; preds = %92, %62
  %65 = load i32* %i1, align 4
  %66 = load i32* %3, align 4
  %67 = icmp ult i32 %65, %66
  br i1 %67, label %68, label %96

; <label>:68                                      ; preds = %64
  %69 = load i32* %i1, align 4
  %70 = load i8 addrspace(1)** %1, align 4
  %71 = getelementptr inbounds i8 addrspace(1)* %70, i32 %69
  %72 = load i8 addrspace(1)* %71, align 1
  %73 = load i32* %lId, align 4
  %74 = load i8 addrspace(3)** %5, align 4
  %75 = getelementptr inbounds i8 addrspace(3)* %74, i32 %73
  store i8 %72, i8 addrspace(3)* %75, align 1
  %76 = load i32* %lId, align 4
  %77 = load i8 addrspace(3)** %5, align 4
  %78 = getelementptr inbounds i8 addrspace(3)* %77, i32 %76
  %79 = load i8 addrspace(3)* %78, align 1
  %80 = zext i8 %79 to i32
  %81 = load i32* %4, align 4
  %82 = mul nsw i32 %80, %81
  %83 = srem i32 %82, 256
  %84 = load volatile i32* %zero, align 4
  %85 = load i32* %tmp, align 4
  %86 = mul nsw i32 %84, %85
  %87 = add nsw i32 %83, %86
  %88 = trunc i32 %87 to i8
  %89 = load i32* %i1, align 4
  %90 = load i8 addrspace(1)** %2, align 4
  %91 = getelementptr inbounds i8 addrspace(1)* %90, i32 %89
  store i8 %88, i8 addrspace(1)* %91, align 1
  br label %92

; <label>:92                                      ; preds = %68
  %93 = load i32* %gSize, align 4
  %94 = load i32* %i1, align 4
  %95 = add i32 %94, %93
  store i32 %95, i32* %i1, align 4
  br label %64

; <label>:96                                      ; preds = %64
  ret void
}

; Function Attrs: nounwind
define void @K1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = load i8 addrspace(1)** %1, align 4
  %6 = load i8 addrspace(1)** %2, align 4
  %7 = load i32* %3, align 4
  %8 = load i32* %4, align 4
  call void @work1(i8 addrspace(1)* %5, i8 addrspace(1)* %6, i32 %7, i32 %8)
  ret void
}

; Function Attrs: nounwind
define void @K2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = load i8 addrspace(1)** %1, align 4
  %6 = load i8 addrspace(1)** %2, align 4
  %7 = load i32* %3, align 4
  %8 = load i32* %4, align 4
  call void @work2(i8 addrspace(1)* %5, i8 addrspace(1)* %6, i32 %7, i32 %8, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K2.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K3(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = load i8 addrspace(1)** %1, align 4
  %6 = load i8 addrspace(1)** %2, align 4
  %7 = load i32* %3, align 4
  %8 = load i32* %4, align 4
  call void @work1(i8 addrspace(1)* %5, i8 addrspace(1)* %6, i32 %7, i32 %8)
  ret void
}

; Function Attrs: nounwind
define void @K4(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = load i8 addrspace(1)** %1, align 4
  %6 = load i8 addrspace(1)** %2, align 4
  %7 = load i32* %3, align 4
  %8 = load i32* %4, align 4
  call void @work2(i8 addrspace(1)* %5, i8 addrspace(1)* %6, i32 %7, i32 %8, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K4.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K5(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = load i8 addrspace(1)** %1, align 4
  %6 = load i8 addrspace(1)** %2, align 4
  %7 = load i32* %3, align 4
  %8 = load i32* %4, align 4
  call void @work1(i8 addrspace(1)* %5, i8 addrspace(1)* %6, i32 %7, i32 %8)
  ret void
}

; Function Attrs: nounwind
define void @K6(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = load i8 addrspace(1)** %1, align 4
  %6 = load i8 addrspace(1)** %2, align 4
  %7 = load i32* %3, align 4
  %8 = load i32* %4, align 4
  call void @work2(i8 addrspace(1)* %5, i8 addrspace(1)* %6, i32 %7, i32 %8, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K6.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K7(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = load i8 addrspace(1)** %1, align 4
  %6 = load i8 addrspace(1)** %2, align 4
  %7 = load i32* %3, align 4
  %8 = load i32* %4, align 4
  call void @work1(i8 addrspace(1)* %5, i8 addrspace(1)* %6, i32 %7, i32 %8)
  ret void
}

; Function Attrs: nounwind
define void @K8(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = load i8 addrspace(1)** %1, align 4
  %6 = load i8 addrspace(1)** %2, align 4
  %7 = load i32* %3, align 4
  %8 = load i32* %4, align 4
  call void @work2(i8 addrspace(1)* %5, i8 addrspace(1)* %6, i32 %7, i32 %8, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K8.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K9(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = load i8 addrspace(1)** %1, align 4
  %6 = load i8 addrspace(1)** %2, align 4
  %7 = load i32* %3, align 4
  %8 = load i32* %4, align 4
  call void @work1(i8 addrspace(1)* %5, i8 addrspace(1)* %6, i32 %7, i32 %8)
  ret void
}

; Function Attrs: nounwind
define void @K10(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i8 addrspace(1)* %input, i8 addrspace(1)** %1, align 4
  store i8 addrspace(1)* %output, i8 addrspace(1)** %2, align 4
  store i32 %bufferSize, i32* %3, align 4
  store i32 %multiplier, i32* %4, align 4
  %5 = load i8 addrspace(1)** %1, align 4
  %6 = load i8 addrspace(1)** %2, align 4
  %7 = load i32* %3, align 4
  %8 = load i32* %4, align 4
  call void @work2(i8 addrspace(1)* %5, i8 addrspace(1)* %6, i32 %7, i32 %8, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K10.lds, i32 0, i32 0))
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9}
!llvm.ident = !{!10}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K1}
!1 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K2}
!2 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K3}
!3 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K4}
!4 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K5}
!5 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K6}
!6 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K7}
!7 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K8}
!8 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K9}
!9 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K10}
!10 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

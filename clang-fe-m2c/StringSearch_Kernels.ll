; ModuleID = '../kernel-src/StringSearch_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@StringSearchNaive.groupSuccessCounter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack1Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack2Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.groupSuccessCounter = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define i32 @compare(i8 addrspace(1)* %text, i8 addrspace(3)* %pattern, i32 %length) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8 addrspace(1)*, align 4
  %3 = alloca i8 addrspace(3)*, align 4
  %4 = alloca i32, align 4
  %l = alloca i32, align 4
  store i8 addrspace(1)* %text, i8 addrspace(1)** %2, align 4
  store i8 addrspace(3)* %pattern, i8 addrspace(3)** %3, align 4
  store i32 %length, i32* %4, align 4
  store i32 0, i32* %l, align 4
  br label %5

; <label>:5                                       ; preds = %47, %0
  %6 = load i32* %l, align 4
  %7 = load i32* %4, align 4
  %8 = icmp ult i32 %6, %7
  br i1 %8, label %9, label %50

; <label>:9                                       ; preds = %5
  %10 = load i32* %l, align 4
  %11 = load i8 addrspace(1)** %2, align 4
  %12 = getelementptr inbounds i8 addrspace(1)* %11, i32 %10
  %13 = load i8 addrspace(1)* %12, align 1
  %14 = zext i8 %13 to i32
  %15 = icmp sle i32 65, %14
  br i1 %15, label %16, label %31

; <label>:16                                      ; preds = %9
  %17 = load i32* %l, align 4
  %18 = load i8 addrspace(1)** %2, align 4
  %19 = getelementptr inbounds i8 addrspace(1)* %18, i32 %17
  %20 = load i8 addrspace(1)* %19, align 1
  %21 = zext i8 %20 to i32
  %22 = icmp sle i32 %21, 90
  br i1 %22, label %23, label %31

; <label>:23                                      ; preds = %16
  %24 = load i32* %l, align 4
  %25 = load i8 addrspace(1)** %2, align 4
  %26 = getelementptr inbounds i8 addrspace(1)* %25, i32 %24
  %27 = load i8 addrspace(1)* %26, align 1
  %28 = zext i8 %27 to i32
  %29 = sub nsw i32 %28, 65
  %30 = add nsw i32 %29, 97
  br label %37

; <label>:31                                      ; preds = %16, %9
  %32 = load i32* %l, align 4
  %33 = load i8 addrspace(1)** %2, align 4
  %34 = getelementptr inbounds i8 addrspace(1)* %33, i32 %32
  %35 = load i8 addrspace(1)* %34, align 1
  %36 = zext i8 %35 to i32
  br label %37

; <label>:37                                      ; preds = %31, %23
  %38 = phi i32 [ %30, %23 ], [ %36, %31 ]
  %39 = load i32* %l, align 4
  %40 = load i8 addrspace(3)** %3, align 4
  %41 = getelementptr inbounds i8 addrspace(3)* %40, i32 %39
  %42 = load i8 addrspace(3)* %41, align 1
  %43 = zext i8 %42 to i32
  %44 = icmp ne i32 %38, %43
  br i1 %44, label %45, label %46

; <label>:45                                      ; preds = %37
  store i32 0, i32* %1
  br label %51

; <label>:46                                      ; preds = %37
  br label %47

; <label>:47                                      ; preds = %46
  %48 = load i32* %l, align 4
  %49 = add i32 %48, 1
  store i32 %49, i32* %l, align 4
  br label %5

; <label>:50                                      ; preds = %5
  store i32 1, i32* %1
  br label %51

; <label>:51                                      ; preds = %50, %45
  %52 = load i32* %1
  ret i32 %52
}

; Function Attrs: nounwind
define void @StringSearchNaive(i8 addrspace(1)* %text, i32 %textLength, i8 addrspace(1)* %pattern, i32 %patternLength, i32 addrspace(1)* %resultBuffer, i32 addrspace(1)* %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* %localPattern) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8 addrspace(1)*, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32 addrspace(1)*, align 4
  %6 = alloca i32 addrspace(1)*, align 4
  %7 = alloca i32, align 4
  %8 = alloca i8 addrspace(3)*, align 4
  %localIdx = alloca i32, align 4
  %localSize = alloca i32, align 4
  %groupIdx = alloca i32, align 4
  %lastSearchIdx = alloca i32, align 4
  %beginSearchIdx = alloca i32, align 4
  %endSearchIdx = alloca i32, align 4
  %idx = alloca i32, align 4
  %stringPos = alloca i32, align 4
  %count = alloca i32, align 4
  store i8 addrspace(1)* %text, i8 addrspace(1)** %1, align 4
  store i32 %textLength, i32* %2, align 4
  store i8 addrspace(1)* %pattern, i8 addrspace(1)** %3, align 4
  store i32 %patternLength, i32* %4, align 4
  store i32 addrspace(1)* %resultBuffer, i32 addrspace(1)** %5, align 4
  store i32 addrspace(1)* %resultCountPerWG, i32 addrspace(1)** %6, align 4
  store i32 %maxSearchLength, i32* %7, align 4
  store i8 addrspace(3)* %localPattern, i8 addrspace(3)** %8, align 4
  %9 = call i32 @__get_local_id_u32(i32 0)
  store i32 %9, i32* %localIdx, align 4
  %10 = call i32 @__get_local_size_u32(i32 0)
  store i32 %10, i32* %localSize, align 4
  %11 = call i32 @__get_group_id_u32(i32 0)
  store i32 %11, i32* %groupIdx, align 4
  %12 = load i32* %2, align 4
  %13 = load i32* %4, align 4
  %14 = sub i32 %12, %13
  %15 = add i32 %14, 1
  store i32 %15, i32* %lastSearchIdx, align 4
  %16 = load i32* %groupIdx, align 4
  %17 = load i32* %7, align 4
  %18 = mul i32 %16, %17
  store i32 %18, i32* %beginSearchIdx, align 4
  %19 = load i32* %beginSearchIdx, align 4
  %20 = load i32* %7, align 4
  %21 = add i32 %19, %20
  store i32 %21, i32* %endSearchIdx, align 4
  %22 = load i32* %beginSearchIdx, align 4
  %23 = load i32* %lastSearchIdx, align 4
  %24 = icmp ugt i32 %22, %23
  br i1 %24, label %25, label %26

; <label>:25                                      ; preds = %0
  br label %117

; <label>:26                                      ; preds = %0
  %27 = load i32* %endSearchIdx, align 4
  %28 = load i32* %lastSearchIdx, align 4
  %29 = icmp ugt i32 %27, %28
  br i1 %29, label %30, label %32

; <label>:30                                      ; preds = %26
  %31 = load i32* %lastSearchIdx, align 4
  store i32 %31, i32* %endSearchIdx, align 4
  br label %32

; <label>:32                                      ; preds = %30, %26
  %33 = load i32* %localIdx, align 4
  store i32 %33, i32* %idx, align 4
  br label %34

; <label>:34                                      ; preds = %72, %32
  %35 = load i32* %idx, align 4
  %36 = load i32* %4, align 4
  %37 = icmp ult i32 %35, %36
  br i1 %37, label %38, label %76

; <label>:38                                      ; preds = %34
  %39 = load i32* %idx, align 4
  %40 = load i8 addrspace(1)** %3, align 4
  %41 = getelementptr inbounds i8 addrspace(1)* %40, i32 %39
  %42 = load i8 addrspace(1)* %41, align 1
  %43 = zext i8 %42 to i32
  %44 = icmp sle i32 65, %43
  br i1 %44, label %45, label %60

; <label>:45                                      ; preds = %38
  %46 = load i32* %idx, align 4
  %47 = load i8 addrspace(1)** %3, align 4
  %48 = getelementptr inbounds i8 addrspace(1)* %47, i32 %46
  %49 = load i8 addrspace(1)* %48, align 1
  %50 = zext i8 %49 to i32
  %51 = icmp sle i32 %50, 90
  br i1 %51, label %52, label %60

; <label>:52                                      ; preds = %45
  %53 = load i32* %idx, align 4
  %54 = load i8 addrspace(1)** %3, align 4
  %55 = getelementptr inbounds i8 addrspace(1)* %54, i32 %53
  %56 = load i8 addrspace(1)* %55, align 1
  %57 = zext i8 %56 to i32
  %58 = sub nsw i32 %57, 65
  %59 = add nsw i32 %58, 97
  br label %66

; <label>:60                                      ; preds = %45, %38
  %61 = load i32* %idx, align 4
  %62 = load i8 addrspace(1)** %3, align 4
  %63 = getelementptr inbounds i8 addrspace(1)* %62, i32 %61
  %64 = load i8 addrspace(1)* %63, align 1
  %65 = zext i8 %64 to i32
  br label %66

; <label>:66                                      ; preds = %60, %52
  %67 = phi i32 [ %59, %52 ], [ %65, %60 ]
  %68 = trunc i32 %67 to i8
  %69 = load i32* %idx, align 4
  %70 = load i8 addrspace(3)** %8, align 4
  %71 = getelementptr inbounds i8 addrspace(3)* %70, i32 %69
  store i8 %68, i8 addrspace(3)* %71, align 1
  br label %72

; <label>:72                                      ; preds = %66
  %73 = load i32* %localSize, align 4
  %74 = load i32* %idx, align 4
  %75 = add nsw i32 %74, %73
  store i32 %75, i32* %idx, align 4
  br label %34

; <label>:76                                      ; preds = %34
  %77 = load i32* %localIdx, align 4
  %78 = icmp eq i32 %77, 0
  br i1 %78, label %79, label %80

; <label>:79                                      ; preds = %76
  store volatile i32 0, i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4
  br label %80

; <label>:80                                      ; preds = %79, %76
  call void @barrier(i32 1)
  %81 = load i32* %beginSearchIdx, align 4
  %82 = load i32* %localIdx, align 4
  %83 = add i32 %81, %82
  store i32 %83, i32* %stringPos, align 4
  br label %84

; <label>:84                                      ; preds = %105, %80
  %85 = load i32* %stringPos, align 4
  %86 = load i32* %endSearchIdx, align 4
  %87 = icmp ult i32 %85, %86
  br i1 %87, label %88, label %109

; <label>:88                                      ; preds = %84
  %89 = load i8 addrspace(1)** %1, align 4
  %90 = load i32* %stringPos, align 4
  %91 = getelementptr inbounds i8 addrspace(1)* %89, i32 %90
  %92 = load i8 addrspace(3)** %8, align 4
  %93 = load i32* %4, align 4
  %94 = call i32 @compare(i8 addrspace(1)* %91, i8 addrspace(3)* %92, i32 %93)
  %95 = icmp eq i32 %94, 1
  br i1 %95, label %96, label %104

; <label>:96                                      ; preds = %88
  %97 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, i32 1)
  store i32 %97, i32* %count, align 4
  %98 = load i32* %stringPos, align 4
  %99 = load i32* %beginSearchIdx, align 4
  %100 = load i32* %count, align 4
  %101 = add i32 %99, %100
  %102 = load i32 addrspace(1)** %5, align 4
  %103 = getelementptr inbounds i32 addrspace(1)* %102, i32 %101
  store i32 %98, i32 addrspace(1)* %103, align 4
  br label %104

; <label>:104                                     ; preds = %96, %88
  br label %105

; <label>:105                                     ; preds = %104
  %106 = load i32* %localSize, align 4
  %107 = load i32* %stringPos, align 4
  %108 = add i32 %107, %106
  store i32 %108, i32* %stringPos, align 4
  br label %84

; <label>:109                                     ; preds = %84
  call void @barrier(i32 1)
  %110 = load i32* %localIdx, align 4
  %111 = icmp eq i32 %110, 0
  br i1 %111, label %112, label %117

; <label>:112                                     ; preds = %109
  %113 = load volatile i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4
  %114 = load i32* %groupIdx, align 4
  %115 = load i32 addrspace(1)** %6, align 4
  %116 = getelementptr inbounds i32 addrspace(1)* %115, i32 %114
  store i32 %113, i32 addrspace(1)* %116, align 4
  br label %117

; <label>:117                                     ; preds = %25, %112, %109
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

; Function Attrs: nounwind
define void @StringSearchLoadBalance(i8 addrspace(1)* %text, i32 %textLength, i8 addrspace(1)* %pattern, i32 %patternLength, i32 addrspace(1)* %resultBuffer, i32 addrspace(1)* %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* %localPattern, i32 addrspace(3)* %stack1) #0 {
  %1 = alloca i8 addrspace(1)*, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8 addrspace(1)*, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32 addrspace(1)*, align 4
  %6 = alloca i32 addrspace(1)*, align 4
  %7 = alloca i32, align 4
  %8 = alloca i8 addrspace(3)*, align 4
  %9 = alloca i32 addrspace(3)*, align 4
  %localIdx = alloca i32, align 4
  %localSize = alloca i32, align 4
  %groupIdx = alloca i32, align 4
  %lastSearchIdx = alloca i32, align 4
  %stackSize = alloca i32, align 4
  %beginSearchIdx = alloca i32, align 4
  %endSearchIdx = alloca i32, align 4
  %searchLength = alloca i32, align 4
  %idx = alloca i32, align 4
  %first = alloca i8, align 1
  %second = alloca i8, align 1
  %stringPos = alloca i32, align 4
  %stackPos = alloca i32, align 4
  %revStackPos = alloca i32, align 4
  %pos = alloca i32, align 4
  %count = alloca i32, align 4
  store i8 addrspace(1)* %text, i8 addrspace(1)** %1, align 4
  store i32 %textLength, i32* %2, align 4
  store i8 addrspace(1)* %pattern, i8 addrspace(1)** %3, align 4
  store i32 %patternLength, i32* %4, align 4
  store i32 addrspace(1)* %resultBuffer, i32 addrspace(1)** %5, align 4
  store i32 addrspace(1)* %resultCountPerWG, i32 addrspace(1)** %6, align 4
  store i32 %maxSearchLength, i32* %7, align 4
  store i8 addrspace(3)* %localPattern, i8 addrspace(3)** %8, align 4
  store i32 addrspace(3)* %stack1, i32 addrspace(3)** %9, align 4
  %10 = call i32 @__get_local_id_u32(i32 0)
  store i32 %10, i32* %localIdx, align 4
  %11 = call i32 @__get_local_size_u32(i32 0)
  store i32 %11, i32* %localSize, align 4
  %12 = call i32 @__get_group_id_u32(i32 0)
  store i32 %12, i32* %groupIdx, align 4
  %13 = load i32* %localIdx, align 4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %15, label %16

; <label>:15                                      ; preds = %0
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack2Counter, align 4
  br label %16

; <label>:16                                      ; preds = %15, %0
  %17 = load i32* %2, align 4
  %18 = load i32* %4, align 4
  %19 = sub i32 %17, %18
  %20 = add i32 %19, 1
  store i32 %20, i32* %lastSearchIdx, align 4
  store i32 0, i32* %stackSize, align 4
  %21 = load i32* %groupIdx, align 4
  %22 = load i32* %7, align 4
  %23 = mul i32 %21, %22
  store i32 %23, i32* %beginSearchIdx, align 4
  %24 = load i32* %beginSearchIdx, align 4
  %25 = load i32* %7, align 4
  %26 = add i32 %24, %25
  store i32 %26, i32* %endSearchIdx, align 4
  %27 = load i32* %beginSearchIdx, align 4
  %28 = load i32* %lastSearchIdx, align 4
  %29 = icmp ugt i32 %27, %28
  br i1 %29, label %30, label %31

; <label>:30                                      ; preds = %16
  br label %264

; <label>:31                                      ; preds = %16
  %32 = load i32* %endSearchIdx, align 4
  %33 = load i32* %lastSearchIdx, align 4
  %34 = icmp ugt i32 %32, %33
  br i1 %34, label %35, label %37

; <label>:35                                      ; preds = %31
  %36 = load i32* %lastSearchIdx, align 4
  store i32 %36, i32* %endSearchIdx, align 4
  br label %37

; <label>:37                                      ; preds = %35, %31
  %38 = load i32* %endSearchIdx, align 4
  %39 = load i32* %beginSearchIdx, align 4
  %40 = sub i32 %38, %39
  store i32 %40, i32* %searchLength, align 4
  %41 = load i32* %localIdx, align 4
  store i32 %41, i32* %idx, align 4
  br label %42

; <label>:42                                      ; preds = %80, %37
  %43 = load i32* %idx, align 4
  %44 = load i32* %4, align 4
  %45 = icmp ult i32 %43, %44
  br i1 %45, label %46, label %84

; <label>:46                                      ; preds = %42
  %47 = load i32* %idx, align 4
  %48 = load i8 addrspace(1)** %3, align 4
  %49 = getelementptr inbounds i8 addrspace(1)* %48, i32 %47
  %50 = load i8 addrspace(1)* %49, align 1
  %51 = zext i8 %50 to i32
  %52 = icmp sle i32 65, %51
  br i1 %52, label %53, label %68

; <label>:53                                      ; preds = %46
  %54 = load i32* %idx, align 4
  %55 = load i8 addrspace(1)** %3, align 4
  %56 = getelementptr inbounds i8 addrspace(1)* %55, i32 %54
  %57 = load i8 addrspace(1)* %56, align 1
  %58 = zext i8 %57 to i32
  %59 = icmp sle i32 %58, 90
  br i1 %59, label %60, label %68

; <label>:60                                      ; preds = %53
  %61 = load i32* %idx, align 4
  %62 = load i8 addrspace(1)** %3, align 4
  %63 = getelementptr inbounds i8 addrspace(1)* %62, i32 %61
  %64 = load i8 addrspace(1)* %63, align 1
  %65 = zext i8 %64 to i32
  %66 = sub nsw i32 %65, 65
  %67 = add nsw i32 %66, 97
  br label %74

; <label>:68                                      ; preds = %53, %46
  %69 = load i32* %idx, align 4
  %70 = load i8 addrspace(1)** %3, align 4
  %71 = getelementptr inbounds i8 addrspace(1)* %70, i32 %69
  %72 = load i8 addrspace(1)* %71, align 1
  %73 = zext i8 %72 to i32
  br label %74

; <label>:74                                      ; preds = %68, %60
  %75 = phi i32 [ %67, %60 ], [ %73, %68 ]
  %76 = trunc i32 %75 to i8
  %77 = load i32* %idx, align 4
  %78 = load i8 addrspace(3)** %8, align 4
  %79 = getelementptr inbounds i8 addrspace(3)* %78, i32 %77
  store i8 %76, i8 addrspace(3)* %79, align 1
  br label %80

; <label>:80                                      ; preds = %74
  %81 = load i32* %localSize, align 4
  %82 = load i32* %idx, align 4
  %83 = add i32 %82, %81
  store i32 %83, i32* %idx, align 4
  br label %42

; <label>:84                                      ; preds = %42
  call void @barrier(i32 1)
  %85 = load i8 addrspace(3)** %8, align 4
  %86 = getelementptr inbounds i8 addrspace(3)* %85, i32 0
  %87 = load i8 addrspace(3)* %86, align 1
  store i8 %87, i8* %first, align 1
  %88 = load i8 addrspace(3)** %8, align 4
  %89 = getelementptr inbounds i8 addrspace(3)* %88, i32 1
  %90 = load i8 addrspace(3)* %89, align 1
  store i8 %90, i8* %second, align 1
  %91 = load i32* %localIdx, align 4
  store i32 %91, i32* %stringPos, align 4
  store i32 0, i32* %stackPos, align 4
  store i32 0, i32* %revStackPos, align 4
  br label %92

; <label>:92                                      ; preds = %84, %205, %255
  %93 = load i32* %stringPos, align 4
  %94 = load i32* %searchLength, align 4
  %95 = icmp ult i32 %93, %94
  br i1 %95, label %96, label %189

; <label>:96                                      ; preds = %92
  %97 = load i8* %first, align 1
  %98 = zext i8 %97 to i32
  %99 = load i32* %beginSearchIdx, align 4
  %100 = load i32* %stringPos, align 4
  %101 = add i32 %99, %100
  %102 = load i8 addrspace(1)** %1, align 4
  %103 = getelementptr inbounds i8 addrspace(1)* %102, i32 %101
  %104 = load i8 addrspace(1)* %103, align 1
  %105 = zext i8 %104 to i32
  %106 = icmp sle i32 65, %105
  br i1 %106, label %107, label %126

; <label>:107                                     ; preds = %96
  %108 = load i32* %beginSearchIdx, align 4
  %109 = load i32* %stringPos, align 4
  %110 = add i32 %108, %109
  %111 = load i8 addrspace(1)** %1, align 4
  %112 = getelementptr inbounds i8 addrspace(1)* %111, i32 %110
  %113 = load i8 addrspace(1)* %112, align 1
  %114 = zext i8 %113 to i32
  %115 = icmp sle i32 %114, 90
  br i1 %115, label %116, label %126

; <label>:116                                     ; preds = %107
  %117 = load i32* %beginSearchIdx, align 4
  %118 = load i32* %stringPos, align 4
  %119 = add i32 %117, %118
  %120 = load i8 addrspace(1)** %1, align 4
  %121 = getelementptr inbounds i8 addrspace(1)* %120, i32 %119
  %122 = load i8 addrspace(1)* %121, align 1
  %123 = zext i8 %122 to i32
  %124 = sub nsw i32 %123, 65
  %125 = add nsw i32 %124, 97
  br label %134

; <label>:126                                     ; preds = %107, %96
  %127 = load i32* %beginSearchIdx, align 4
  %128 = load i32* %stringPos, align 4
  %129 = add i32 %127, %128
  %130 = load i8 addrspace(1)** %1, align 4
  %131 = getelementptr inbounds i8 addrspace(1)* %130, i32 %129
  %132 = load i8 addrspace(1)* %131, align 1
  %133 = zext i8 %132 to i32
  br label %134

; <label>:134                                     ; preds = %126, %116
  %135 = phi i32 [ %125, %116 ], [ %133, %126 ]
  %136 = icmp eq i32 %98, %135
  br i1 %136, label %137, label %188

; <label>:137                                     ; preds = %134
  %138 = load i8* %second, align 1
  %139 = zext i8 %138 to i32
  %140 = load i32* %beginSearchIdx, align 4
  %141 = load i32* %stringPos, align 4
  %142 = add i32 %140, %141
  %143 = add i32 %142, 1
  %144 = load i8 addrspace(1)** %1, align 4
  %145 = getelementptr inbounds i8 addrspace(1)* %144, i32 %143
  %146 = load i8 addrspace(1)* %145, align 1
  %147 = zext i8 %146 to i32
  %148 = icmp sle i32 65, %147
  br i1 %148, label %149, label %170

; <label>:149                                     ; preds = %137
  %150 = load i32* %beginSearchIdx, align 4
  %151 = load i32* %stringPos, align 4
  %152 = add i32 %150, %151
  %153 = add i32 %152, 1
  %154 = load i8 addrspace(1)** %1, align 4
  %155 = getelementptr inbounds i8 addrspace(1)* %154, i32 %153
  %156 = load i8 addrspace(1)* %155, align 1
  %157 = zext i8 %156 to i32
  %158 = icmp sle i32 %157, 90
  br i1 %158, label %159, label %170

; <label>:159                                     ; preds = %149
  %160 = load i32* %beginSearchIdx, align 4
  %161 = load i32* %stringPos, align 4
  %162 = add i32 %160, %161
  %163 = add i32 %162, 1
  %164 = load i8 addrspace(1)** %1, align 4
  %165 = getelementptr inbounds i8 addrspace(1)* %164, i32 %163
  %166 = load i8 addrspace(1)* %165, align 1
  %167 = zext i8 %166 to i32
  %168 = sub nsw i32 %167, 65
  %169 = add nsw i32 %168, 97
  br label %179

; <label>:170                                     ; preds = %149, %137
  %171 = load i32* %beginSearchIdx, align 4
  %172 = load i32* %stringPos, align 4
  %173 = add i32 %171, %172
  %174 = add i32 %173, 1
  %175 = load i8 addrspace(1)** %1, align 4
  %176 = getelementptr inbounds i8 addrspace(1)* %175, i32 %174
  %177 = load i8 addrspace(1)* %176, align 1
  %178 = zext i8 %177 to i32
  br label %179

; <label>:179                                     ; preds = %170, %159
  %180 = phi i32 [ %169, %159 ], [ %178, %170 ]
  %181 = icmp eq i32 %139, %180
  br i1 %181, label %182, label %188

; <label>:182                                     ; preds = %179
  %183 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1)
  store i32 %183, i32* %stackPos, align 4
  %184 = load i32* %stringPos, align 4
  %185 = load i32* %stackPos, align 4
  %186 = load i32 addrspace(3)** %9, align 4
  %187 = getelementptr inbounds i32 addrspace(3)* %186, i32 %185
  store i32 %184, i32 addrspace(3)* %187, align 4
  br label %188

; <label>:188                                     ; preds = %182, %179, %134
  br label %189

; <label>:189                                     ; preds = %188, %92
  %190 = load i32* %localSize, align 4
  %191 = load i32* %stringPos, align 4
  %192 = add nsw i32 %191, %190
  store i32 %192, i32* %stringPos, align 4
  call void @barrier(i32 1)
  %193 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  store i32 %193, i32* %stackSize, align 4
  call void @barrier(i32 1)
  %194 = load i32* %stackSize, align 4
  %195 = load i32* %localSize, align 4
  %196 = icmp ult i32 %194, %195
  br i1 %196, label %197, label %206

; <label>:197                                     ; preds = %189
  %198 = load i32* %stringPos, align 4
  %199 = load i32* %localSize, align 4
  %200 = sdiv i32 %198, %199
  %201 = load i32* %localSize, align 4
  %202 = mul nsw i32 %200, %201
  %203 = load i32* %searchLength, align 4
  %204 = icmp ult i32 %202, %203
  br i1 %204, label %205, label %206

; <label>:205                                     ; preds = %197
  br label %92

; <label>:206                                     ; preds = %197, %189
  %207 = load i32* %localIdx, align 4
  %208 = load i32* %stackSize, align 4
  %209 = icmp ult i32 %207, %208
  br i1 %209, label %210, label %240

; <label>:210                                     ; preds = %206
  %211 = call i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1)
  store i32 %211, i32* %revStackPos, align 4
  %212 = load i32* %revStackPos, align 4
  %213 = add nsw i32 %212, -1
  store i32 %213, i32* %revStackPos, align 4
  %214 = load i32 addrspace(3)** %9, align 4
  %215 = getelementptr inbounds i32 addrspace(3)* %214, i32 %213
  %216 = load i32 addrspace(3)* %215, align 4
  store i32 %216, i32* %pos, align 4
  %217 = load i8 addrspace(1)** %1, align 4
  %218 = load i32* %beginSearchIdx, align 4
  %219 = getelementptr inbounds i8 addrspace(1)* %217, i32 %218
  %220 = load i32* %pos, align 4
  %221 = getelementptr inbounds i8 addrspace(1)* %219, i32 %220
  %222 = getelementptr inbounds i8 addrspace(1)* %221, i32 2
  %223 = load i8 addrspace(3)** %8, align 4
  %224 = getelementptr inbounds i8 addrspace(3)* %223, i32 2
  %225 = load i32* %4, align 4
  %226 = sub i32 %225, 2
  %227 = call i32 @compare(i8 addrspace(1)* %222, i8 addrspace(3)* %224, i32 %226)
  %228 = icmp eq i32 %227, 1
  br i1 %228, label %229, label %239

; <label>:229                                     ; preds = %210
  %230 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, i32 1)
  store i32 %230, i32* %count, align 4
  %231 = load i32* %beginSearchIdx, align 4
  %232 = load i32* %pos, align 4
  %233 = add i32 %231, %232
  %234 = load i32* %beginSearchIdx, align 4
  %235 = load i32* %count, align 4
  %236 = add i32 %234, %235
  %237 = load i32 addrspace(1)** %5, align 4
  %238 = getelementptr inbounds i32 addrspace(1)* %237, i32 %236
  store i32 %233, i32 addrspace(1)* %238, align 4
  br label %239

; <label>:239                                     ; preds = %229, %210
  br label %240

; <label>:240                                     ; preds = %239, %206
  call void @barrier(i32 1)
  %241 = load i32* %stringPos, align 4
  %242 = load i32* %localSize, align 4
  %243 = sdiv i32 %241, %242
  %244 = load i32* %localSize, align 4
  %245 = mul nsw i32 %243, %244
  %246 = load i32* %searchLength, align 4
  %247 = icmp uge i32 %245, %246
  br i1 %247, label %248, label %255

; <label>:248                                     ; preds = %240
  %249 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  %250 = icmp ule i32 %249, 0
  br i1 %250, label %251, label %255

; <label>:251                                     ; preds = %248
  %252 = load i32 addrspace(3)* @StringSearchLoadBalance.stack2Counter, align 4
  %253 = icmp ule i32 %252, 0
  br i1 %253, label %254, label %255

; <label>:254                                     ; preds = %251
  br label %256

; <label>:255                                     ; preds = %251, %248, %240
  br label %92

; <label>:256                                     ; preds = %254
  %257 = load i32* %localIdx, align 4
  %258 = icmp eq i32 %257, 0
  br i1 %258, label %259, label %264

; <label>:259                                     ; preds = %256
  %260 = load i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4
  %261 = load i32* %groupIdx, align 4
  %262 = load i32 addrspace(1)** %6, align 4
  %263 = getelementptr inbounds i32 addrspace(1)* %262, i32 %261
  store i32 %260, i32 addrspace(1)* %263, align 4
  br label %264

; <label>:264                                     ; preds = %30, %259, %256
  ret void
}

declare i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)*, i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*)* @StringSearchNaive}
!1 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*, i32 addrspace(3)*)* @StringSearchLoadBalance}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

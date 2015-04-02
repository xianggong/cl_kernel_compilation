; ModuleID = '../kernel-src/RadixSort_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram(i32 addrspace(1)* %unsortedData, i32 addrspace(1)* %buckets, i32 %shiftCount, i32 addrspace(3)* %sharedArray) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32 addrspace(3)*, align 4
  %localId = alloca i32, align 4
  %globalId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %numGroups = alloca i32, align 4
  %value = alloca i32, align 4
  %bucketPos = alloca i32, align 4
  store i32 addrspace(1)* %unsortedData, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %buckets, i32 addrspace(1)** %2, align 4
  store i32 %shiftCount, i32* %3, align 4
  store i32 addrspace(3)* %sharedArray, i32 addrspace(3)** %4, align 4
  %5 = call i32 @get_local_id(i32 0)
  store i32 %5, i32* %localId, align 4
  %6 = call i32 @get_global_id(i32 0)
  store i32 %6, i32* %globalId, align 4
  %7 = call i32 @get_group_id(i32 0)
  store i32 %7, i32* %groupId, align 4
  %8 = call i32 @get_local_size(i32 0)
  store i32 %8, i32* %groupSize, align 4
  %9 = call i32 @get_global_size(i32 0)
  %10 = call i32 @get_local_size(i32 0)
  %11 = udiv i32 %9, %10
  store i32 %11, i32* %numGroups, align 4
  %12 = load i32* %localId, align 4
  %13 = load i32 addrspace(3)** %4, align 4
  %14 = getelementptr inbounds i32 addrspace(3)* %13, i32 %12
  store i32 0, i32 addrspace(3)* %14, align 4
  call void @barrier(i32 1)
  %15 = load i32* %globalId, align 4
  %16 = load i32 addrspace(1)** %1, align 4
  %17 = getelementptr inbounds i32 addrspace(1)* %16, i32 %15
  %18 = load i32 addrspace(1)* %17, align 4
  store i32 %18, i32* %value, align 4
  %19 = load i32* %value, align 4
  %20 = load i32* %3, align 4
  %21 = and i32 %20, 31
  %22 = lshr i32 %19, %21
  %23 = and i32 %22, 255
  store i32 %23, i32* %value, align 4
  %24 = load i32 addrspace(3)** %4, align 4
  %25 = load i32* %value, align 4
  %26 = getelementptr inbounds i32 addrspace(3)* %24, i32 %25
  %27 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* %26, i32 1)
  call void @barrier(i32 1)
  %28 = load i32* %groupId, align 4
  %29 = load i32* %groupSize, align 4
  %30 = mul i32 %28, %29
  %31 = load i32* %localId, align 4
  %32 = add i32 %30, %31
  store i32 %32, i32* %bucketPos, align 4
  %33 = load i32* %localId, align 4
  %34 = load i32 addrspace(3)** %4, align 4
  %35 = getelementptr inbounds i32 addrspace(3)* %34, i32 %33
  %36 = load i32 addrspace(3)* %35, align 4
  %37 = load i32* %bucketPos, align 4
  %38 = load i32 addrspace(1)** %2, align 4
  %39 = getelementptr inbounds i32 addrspace(1)* %38, i32 %37
  store i32 %36, i32 addrspace(1)* %39, align 4
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare i32 @get_global_size(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

; Function Attrs: nounwind
define void @permute(i32 addrspace(1)* %unsortedData, i32 addrspace(1)* %scanedBuckets, i32 %shiftCount, i16 addrspace(3)* %sharedBuckets, i32 addrspace(1)* %sortedData) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i16 addrspace(3)*, align 4
  %5 = alloca i32 addrspace(1)*, align 4
  %groupId = alloca i32, align 4
  %localId = alloca i32, align 4
  %globalId = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %i = alloca i32, align 4
  %bucketPos = alloca i32, align 4
  %i1 = alloca i32, align 4
  %value = alloca i32, align 4
  %index = alloca i32, align 4
  store i32 addrspace(1)* %unsortedData, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %scanedBuckets, i32 addrspace(1)** %2, align 4
  store i32 %shiftCount, i32* %3, align 4
  store i16 addrspace(3)* %sharedBuckets, i16 addrspace(3)** %4, align 4
  store i32 addrspace(1)* %sortedData, i32 addrspace(1)** %5, align 4
  %6 = call i32 @get_group_id(i32 0)
  store i32 %6, i32* %groupId, align 4
  %7 = call i32 @get_local_id(i32 0)
  store i32 %7, i32* %localId, align 4
  %8 = call i32 @get_global_id(i32 0)
  store i32 %8, i32* %globalId, align 4
  %9 = call i32 @get_local_size(i32 0)
  store i32 %9, i32* %groupSize, align 4
  store i32 0, i32* %i, align 4
  br label %10

; <label>:10                                      ; preds = %34, %0
  %11 = load i32* %i, align 4
  %12 = icmp slt i32 %11, 256
  br i1 %12, label %13, label %37

; <label>:13                                      ; preds = %10
  %14 = load i32* %groupId, align 4
  %15 = mul i32 %14, 256
  %16 = load i32* %groupSize, align 4
  %17 = mul i32 %15, %16
  %18 = load i32* %localId, align 4
  %19 = mul i32 %18, 256
  %20 = add i32 %17, %19
  %21 = load i32* %i, align 4
  %22 = add i32 %20, %21
  store i32 %22, i32* %bucketPos, align 4
  %23 = load i32* %bucketPos, align 4
  %24 = load i32 addrspace(1)** %2, align 4
  %25 = getelementptr inbounds i32 addrspace(1)* %24, i32 %23
  %26 = load i32 addrspace(1)* %25, align 4
  %27 = trunc i32 %26 to i16
  %28 = load i32* %localId, align 4
  %29 = mul i32 %28, 256
  %30 = load i32* %i, align 4
  %31 = add i32 %29, %30
  %32 = load i16 addrspace(3)** %4, align 4
  %33 = getelementptr inbounds i16 addrspace(3)* %32, i32 %31
  store i16 %27, i16 addrspace(3)* %33, align 2
  br label %34

; <label>:34                                      ; preds = %13
  %35 = load i32* %i, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %i, align 4
  br label %10

; <label>:37                                      ; preds = %10
  call void @barrier(i32 1)
  store i32 0, i32* %i1, align 4
  br label %38

; <label>:38                                      ; preds = %81, %37
  %39 = load i32* %i1, align 4
  %40 = icmp slt i32 %39, 256
  br i1 %40, label %41, label %84

; <label>:41                                      ; preds = %38
  %42 = load i32* %globalId, align 4
  %43 = mul i32 %42, 256
  %44 = load i32* %i1, align 4
  %45 = add i32 %43, %44
  %46 = load i32 addrspace(1)** %1, align 4
  %47 = getelementptr inbounds i32 addrspace(1)* %46, i32 %45
  %48 = load i32 addrspace(1)* %47, align 4
  store i32 %48, i32* %value, align 4
  %49 = load i32* %value, align 4
  %50 = load i32* %3, align 4
  %51 = and i32 %50, 31
  %52 = lshr i32 %49, %51
  %53 = and i32 %52, 255
  store i32 %53, i32* %value, align 4
  %54 = load i32* %localId, align 4
  %55 = mul i32 %54, 256
  %56 = load i32* %value, align 4
  %57 = add i32 %55, %56
  %58 = load i16 addrspace(3)** %4, align 4
  %59 = getelementptr inbounds i16 addrspace(3)* %58, i32 %57
  %60 = load i16 addrspace(3)* %59, align 2
  %61 = zext i16 %60 to i32
  store i32 %61, i32* %index, align 4
  %62 = load i32* %globalId, align 4
  %63 = mul i32 %62, 256
  %64 = load i32* %i1, align 4
  %65 = add i32 %63, %64
  %66 = load i32 addrspace(1)** %1, align 4
  %67 = getelementptr inbounds i32 addrspace(1)* %66, i32 %65
  %68 = load i32 addrspace(1)* %67, align 4
  %69 = load i32* %index, align 4
  %70 = load i32 addrspace(1)** %5, align 4
  %71 = getelementptr inbounds i32 addrspace(1)* %70, i32 %69
  store i32 %68, i32 addrspace(1)* %71, align 4
  %72 = load i32* %index, align 4
  %73 = add i32 %72, 1
  %74 = trunc i32 %73 to i16
  %75 = load i32* %localId, align 4
  %76 = mul i32 %75, 256
  %77 = load i32* %value, align 4
  %78 = add i32 %76, %77
  %79 = load i16 addrspace(3)** %4, align 4
  %80 = getelementptr inbounds i16 addrspace(3)* %79, i32 %78
  store i16 %74, i16 addrspace(3)* %80, align 2
  call void @barrier(i32 1)
  br label %81

; <label>:81                                      ; preds = %41
  %82 = load i32* %i1, align 4
  %83 = add nsw i32 %82, 1
  store i32 %83, i32* %i1, align 4
  br label %38

; <label>:84                                      ; preds = %38
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim2(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size, i32 %stride, i32 addrspace(1)* %sumBuffer) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32 addrspace(3)*, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32 addrspace(1)*, align 4
  %tidx = alloca i32, align 4
  %tidy = alloca i32, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %bidx = alloca i32, align 4
  %bidy = alloca i32, align 4
  %lIndex = alloca i32, align 4
  %gpos = alloca i32, align 4
  %groupIndex = alloca i32, align 4
  %cache = alloca i32, align 4
  %dis = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %2, align 4
  store i32 addrspace(3)* %block, i32 addrspace(3)** %3, align 4
  store i32 %block_size, i32* %4, align 4
  store i32 %stride, i32* %5, align 4
  store i32 addrspace(1)* %sumBuffer, i32 addrspace(1)** %6, align 4
  %7 = call i32 @get_local_id(i32 0)
  store i32 %7, i32* %tidx, align 4
  %8 = call i32 @get_local_id(i32 1)
  store i32 %8, i32* %tidy, align 4
  %9 = call i32 @get_global_id(i32 0)
  store i32 %9, i32* %gidx, align 4
  %10 = call i32 @get_global_id(i32 1)
  store i32 %10, i32* %gidy, align 4
  %11 = call i32 @get_group_id(i32 0)
  store i32 %11, i32* %bidx, align 4
  %12 = call i32 @get_group_id(i32 1)
  store i32 %12, i32* %bidy, align 4
  %13 = load i32* %tidy, align 4
  %14 = load i32* %4, align 4
  %15 = mul i32 %13, %14
  %16 = load i32* %tidx, align 4
  %17 = add i32 %15, %16
  store i32 %17, i32* %lIndex, align 4
  %18 = load i32* %gidx, align 4
  %19 = shl i32 %18, 8
  %20 = load i32* %gidy, align 4
  %21 = add nsw i32 %19, %20
  store i32 %21, i32* %gpos, align 4
  %22 = load i32* %bidy, align 4
  %23 = call i32 @get_global_size(i32 0)
  %24 = load i32* %4, align 4
  %25 = udiv i32 %23, %24
  %26 = mul i32 %22, %25
  %27 = load i32* %bidx, align 4
  %28 = add i32 %26, %27
  store i32 %28, i32* %groupIndex, align 4
  %29 = load i32* %gpos, align 4
  %30 = load i32 addrspace(1)** %2, align 4
  %31 = getelementptr inbounds i32 addrspace(1)* %30, i32 %29
  %32 = load i32 addrspace(1)* %31, align 4
  %33 = load i32* %tidx, align 4
  %34 = load i32 addrspace(3)** %3, align 4
  %35 = getelementptr inbounds i32 addrspace(3)* %34, i32 %33
  store i32 %32, i32 addrspace(3)* %35, align 4
  call void @barrier(i32 1)
  %36 = load i32 addrspace(3)** %3, align 4
  %37 = getelementptr inbounds i32 addrspace(3)* %36, i32 0
  %38 = load i32 addrspace(3)* %37, align 4
  store i32 %38, i32* %cache, align 4
  store i32 1, i32* %dis, align 4
  br label %39

; <label>:39                                      ; preds = %64, %0
  %40 = load i32* %dis, align 4
  %41 = load i32* %4, align 4
  %42 = icmp ult i32 %40, %41
  br i1 %42, label %43, label %67

; <label>:43                                      ; preds = %39
  %44 = load i32* %tidx, align 4
  %45 = load i32* %dis, align 4
  %46 = icmp sge i32 %44, %45
  br i1 %46, label %47, label %59

; <label>:47                                      ; preds = %43
  %48 = load i32* %tidx, align 4
  %49 = load i32* %dis, align 4
  %50 = sub nsw i32 %48, %49
  %51 = load i32 addrspace(3)** %3, align 4
  %52 = getelementptr inbounds i32 addrspace(3)* %51, i32 %50
  %53 = load i32 addrspace(3)* %52, align 4
  %54 = load i32* %tidx, align 4
  %55 = load i32 addrspace(3)** %3, align 4
  %56 = getelementptr inbounds i32 addrspace(3)* %55, i32 %54
  %57 = load i32 addrspace(3)* %56, align 4
  %58 = add i32 %53, %57
  store i32 %58, i32* %cache, align 4
  br label %59

; <label>:59                                      ; preds = %47, %43
  call void @barrier(i32 1)
  %60 = load i32* %cache, align 4
  %61 = load i32* %tidx, align 4
  %62 = load i32 addrspace(3)** %3, align 4
  %63 = getelementptr inbounds i32 addrspace(3)* %62, i32 %61
  store i32 %60, i32 addrspace(3)* %63, align 4
  call void @barrier(i32 1)
  br label %64

; <label>:64                                      ; preds = %59
  %65 = load i32* %dis, align 4
  %66 = mul nsw i32 %65, 2
  store i32 %66, i32* %dis, align 4
  br label %39

; <label>:67                                      ; preds = %39
  %68 = load i32* %4, align 4
  %69 = sub i32 %68, 1
  %70 = load i32 addrspace(3)** %3, align 4
  %71 = getelementptr inbounds i32 addrspace(3)* %70, i32 %69
  %72 = load i32 addrspace(3)* %71, align 4
  %73 = load i32* %groupIndex, align 4
  %74 = load i32 addrspace(1)** %6, align 4
  %75 = getelementptr inbounds i32 addrspace(1)* %74, i32 %73
  store i32 %72, i32 addrspace(1)* %75, align 4
  %76 = load i32* %tidx, align 4
  %77 = icmp eq i32 %76, 0
  br i1 %77, label %78, label %82

; <label>:78                                      ; preds = %67
  %79 = load i32* %gpos, align 4
  %80 = load i32 addrspace(1)** %1, align 4
  %81 = getelementptr inbounds i32 addrspace(1)* %80, i32 %79
  store i32 0, i32 addrspace(1)* %81, align 4
  br label %91

; <label>:82                                      ; preds = %67
  %83 = load i32* %tidx, align 4
  %84 = sub nsw i32 %83, 1
  %85 = load i32 addrspace(3)** %3, align 4
  %86 = getelementptr inbounds i32 addrspace(3)* %85, i32 %84
  %87 = load i32 addrspace(3)* %86, align 4
  %88 = load i32* %gpos, align 4
  %89 = load i32 addrspace(1)** %1, align 4
  %90 = getelementptr inbounds i32 addrspace(1)* %89, i32 %88
  store i32 %87, i32 addrspace(1)* %90, align 4
  br label %91

; <label>:91                                      ; preds = %82, %78
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim1(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32 addrspace(3)*, align 4
  %4 = alloca i32, align 4
  %tid = alloca i32, align 4
  %gid = alloca i32, align 4
  %bid = alloca i32, align 4
  %cache = alloca i32, align 4
  %stride = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %2, align 4
  store i32 addrspace(3)* %block, i32 addrspace(3)** %3, align 4
  store i32 %block_size, i32* %4, align 4
  %5 = call i32 @get_local_id(i32 0)
  store i32 %5, i32* %tid, align 4
  %6 = call i32 @get_global_id(i32 0)
  store i32 %6, i32* %gid, align 4
  %7 = call i32 @get_group_id(i32 0)
  store i32 %7, i32* %bid, align 4
  %8 = load i32* %gid, align 4
  %9 = load i32 addrspace(1)** %2, align 4
  %10 = getelementptr inbounds i32 addrspace(1)* %9, i32 %8
  %11 = load i32 addrspace(1)* %10, align 4
  %12 = load i32* %tid, align 4
  %13 = load i32 addrspace(3)** %3, align 4
  %14 = getelementptr inbounds i32 addrspace(3)* %13, i32 %12
  store i32 %11, i32 addrspace(3)* %14, align 4
  %15 = load i32 addrspace(3)** %3, align 4
  %16 = getelementptr inbounds i32 addrspace(3)* %15, i32 0
  %17 = load i32 addrspace(3)* %16, align 4
  store i32 %17, i32* %cache, align 4
  store i32 1, i32* %stride, align 4
  br label %18

; <label>:18                                      ; preds = %43, %0
  %19 = load i32* %stride, align 4
  %20 = load i32* %4, align 4
  %21 = icmp ult i32 %19, %20
  br i1 %21, label %22, label %46

; <label>:22                                      ; preds = %18
  %23 = load i32* %tid, align 4
  %24 = load i32* %stride, align 4
  %25 = icmp sge i32 %23, %24
  br i1 %25, label %26, label %38

; <label>:26                                      ; preds = %22
  %27 = load i32* %tid, align 4
  %28 = load i32* %stride, align 4
  %29 = sub nsw i32 %27, %28
  %30 = load i32 addrspace(3)** %3, align 4
  %31 = getelementptr inbounds i32 addrspace(3)* %30, i32 %29
  %32 = load i32 addrspace(3)* %31, align 4
  %33 = load i32* %tid, align 4
  %34 = load i32 addrspace(3)** %3, align 4
  %35 = getelementptr inbounds i32 addrspace(3)* %34, i32 %33
  %36 = load i32 addrspace(3)* %35, align 4
  %37 = add i32 %32, %36
  store i32 %37, i32* %cache, align 4
  br label %38

; <label>:38                                      ; preds = %26, %22
  call void @barrier(i32 1)
  %39 = load i32* %cache, align 4
  %40 = load i32* %tid, align 4
  %41 = load i32 addrspace(3)** %3, align 4
  %42 = getelementptr inbounds i32 addrspace(3)* %41, i32 %40
  store i32 %39, i32 addrspace(3)* %42, align 4
  call void @barrier(i32 1)
  br label %43

; <label>:43                                      ; preds = %38
  %44 = load i32* %stride, align 4
  %45 = mul nsw i32 %44, 2
  store i32 %45, i32* %stride, align 4
  br label %18

; <label>:46                                      ; preds = %18
  %47 = load i32* %tid, align 4
  %48 = icmp eq i32 %47, 0
  br i1 %48, label %49, label %53

; <label>:49                                      ; preds = %46
  %50 = load i32* %gid, align 4
  %51 = load i32 addrspace(1)** %1, align 4
  %52 = getelementptr inbounds i32 addrspace(1)* %51, i32 %50
  store i32 0, i32 addrspace(1)* %52, align 4
  br label %62

; <label>:53                                      ; preds = %46
  %54 = load i32* %tid, align 4
  %55 = sub nsw i32 %54, 1
  %56 = load i32 addrspace(3)** %3, align 4
  %57 = getelementptr inbounds i32 addrspace(3)* %56, i32 %55
  %58 = load i32 addrspace(3)* %57, align 4
  %59 = load i32* %gid, align 4
  %60 = load i32 addrspace(1)** %1, align 4
  %61 = getelementptr inbounds i32 addrspace(1)* %60, i32 %59
  store i32 %58, i32 addrspace(1)* %61, align 4
  br label %62

; <label>:62                                      ; preds = %53, %49
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(1)* %summary, i32 %stride) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32 addrspace(1)*, align 4
  %4 = alloca i32, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %Index = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %2, align 4
  store i32 addrspace(1)* %summary, i32 addrspace(1)** %3, align 4
  store i32 %stride, i32* %4, align 4
  %5 = call i32 @get_global_id(i32 0)
  store i32 %5, i32* %gidx, align 4
  %6 = call i32 @get_global_id(i32 1)
  store i32 %6, i32* %gidy, align 4
  %7 = load i32* %gidy, align 4
  %8 = load i32* %4, align 4
  %9 = mul nsw i32 %7, %8
  %10 = load i32* %gidx, align 4
  %11 = add nsw i32 %9, %10
  store i32 %11, i32* %Index, align 4
  %12 = load i32* %Index, align 4
  %13 = load i32 addrspace(1)** %1, align 4
  %14 = getelementptr inbounds i32 addrspace(1)* %13, i32 %12
  store i32 0, i32 addrspace(1)* %14, align 4
  %15 = load i32* %gidx, align 4
  %16 = icmp sgt i32 %15, 0
  br i1 %16, label %17, label %40

; <label>:17                                      ; preds = %0
  store i32 0, i32* %i, align 4
  br label %18

; <label>:18                                      ; preds = %36, %17
  %19 = load i32* %i, align 4
  %20 = load i32* %gidx, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %39

; <label>:22                                      ; preds = %18
  %23 = load i32* %gidy, align 4
  %24 = load i32* %4, align 4
  %25 = mul nsw i32 %23, %24
  %26 = load i32* %i, align 4
  %27 = add nsw i32 %25, %26
  %28 = load i32 addrspace(1)** %2, align 4
  %29 = getelementptr inbounds i32 addrspace(1)* %28, i32 %27
  %30 = load i32 addrspace(1)* %29, align 4
  %31 = load i32* %Index, align 4
  %32 = load i32 addrspace(1)** %1, align 4
  %33 = getelementptr inbounds i32 addrspace(1)* %32, i32 %31
  %34 = load i32 addrspace(1)* %33, align 4
  %35 = add i32 %34, %30
  store i32 %35, i32 addrspace(1)* %33, align 4
  br label %36

; <label>:36                                      ; preds = %22
  %37 = load i32* %i, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, i32* %i, align 4
  br label %18

; <label>:39                                      ; preds = %18
  br label %40

; <label>:40                                      ; preds = %39, %0
  %41 = load i32* %gidx, align 4
  %42 = load i32* %4, align 4
  %43 = sub nsw i32 %42, 1
  %44 = icmp eq i32 %41, %43
  br i1 %44, label %45, label %63

; <label>:45                                      ; preds = %40
  %46 = load i32* %Index, align 4
  %47 = load i32 addrspace(1)** %1, align 4
  %48 = getelementptr inbounds i32 addrspace(1)* %47, i32 %46
  %49 = load i32 addrspace(1)* %48, align 4
  %50 = load i32* %gidy, align 4
  %51 = load i32* %4, align 4
  %52 = mul nsw i32 %50, %51
  %53 = load i32* %4, align 4
  %54 = sub nsw i32 %53, 1
  %55 = add nsw i32 %52, %54
  %56 = load i32 addrspace(1)** %2, align 4
  %57 = getelementptr inbounds i32 addrspace(1)* %56, i32 %55
  %58 = load i32 addrspace(1)* %57, align 4
  %59 = add i32 %49, %58
  %60 = load i32* %gidy, align 4
  %61 = load i32 addrspace(1)** %3, align 4
  %62 = getelementptr inbounds i32 addrspace(1)* %61, i32 %60
  store i32 %59, i32 addrspace(1)* %62, align 4
  br label %63

; <label>:63                                      ; preds = %45, %40
  ret void
}

; Function Attrs: nounwind
define void @blockAddition(i32 addrspace(1)* %input, i32 addrspace(1)* %output, i32 %stride) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %bidx = alloca i32, align 4
  %bidy = alloca i32, align 4
  %gpos = alloca i32, align 4
  %groupIndex = alloca i32, align 4
  %temp = alloca i32, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %2, align 4
  store i32 %stride, i32* %3, align 4
  %4 = call i32 @get_global_id(i32 0)
  store i32 %4, i32* %gidx, align 4
  %5 = call i32 @get_global_id(i32 1)
  store i32 %5, i32* %gidy, align 4
  %6 = call i32 @get_group_id(i32 0)
  store i32 %6, i32* %bidx, align 4
  %7 = call i32 @get_group_id(i32 1)
  store i32 %7, i32* %bidy, align 4
  %8 = load i32* %gidy, align 4
  %9 = load i32* %gidx, align 4
  %10 = shl i32 %9, 8
  %11 = add nsw i32 %8, %10
  store i32 %11, i32* %gpos, align 4
  %12 = load i32* %bidy, align 4
  %13 = load i32* %3, align 4
  %14 = mul i32 %12, %13
  %15 = load i32* %bidx, align 4
  %16 = add i32 %14, %15
  store i32 %16, i32* %groupIndex, align 4
  %17 = load i32* %groupIndex, align 4
  %18 = load i32 addrspace(1)** %1, align 4
  %19 = getelementptr inbounds i32 addrspace(1)* %18, i32 %17
  %20 = load i32 addrspace(1)* %19, align 4
  store i32 %20, i32* %temp, align 4
  %21 = load i32* %temp, align 4
  %22 = load i32* %gpos, align 4
  %23 = load i32 addrspace(1)** %2, align 4
  %24 = getelementptr inbounds i32 addrspace(1)* %23, i32 %22
  %25 = load i32 addrspace(1)* %24, align 4
  %26 = add i32 %25, %21
  store i32 %26, i32 addrspace(1)* %24, align 4
  ret void
}

; Function Attrs: nounwind
define void @FixOffset(i32 addrspace(1)* %input, i32 addrspace(1)* %output) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %gpos = alloca i32, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %2, align 4
  %3 = call i32 @get_global_id(i32 0)
  store i32 %3, i32* %gidx, align 4
  %4 = call i32 @get_global_id(i32 1)
  store i32 %4, i32* %gidy, align 4
  %5 = load i32* %gidy, align 4
  %6 = load i32* %gidx, align 4
  %7 = shl i32 %6, 8
  %8 = add nsw i32 %5, %7
  store i32 %8, i32* %gpos, align 4
  %9 = load i32* %gidy, align 4
  %10 = load i32 addrspace(1)** %1, align 4
  %11 = getelementptr inbounds i32 addrspace(1)* %10, i32 %9
  %12 = load i32 addrspace(1)* %11, align 4
  %13 = load i32* %gpos, align 4
  %14 = load i32 addrspace(1)** %2, align 4
  %15 = getelementptr inbounds i32 addrspace(1)* %14, i32 %13
  %16 = load i32 addrspace(1)* %15, align 4
  %17 = add i32 %16, %12
  store i32 %17, i32 addrspace(1)* %15, align 4
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(3)*)* @histogram}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i16 addrspace(3)*, i32 addrspace(1)*)* @permute}
!2 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32, i32, i32 addrspace(1)*)* @ScanArraysdim2}
!3 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32)* @ScanArraysdim1}
!4 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*, i32)* @prefixSum}
!5 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @blockAddition}
!6 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @FixOffset}
!7 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

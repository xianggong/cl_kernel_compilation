; ModuleID = '../kernel-src/ScanLargeArrays_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@blockAddition.value = internal addrspace(3) global [1 x float] zeroinitializer, align 4

; Function Attrs: nounwind
define void @blockAddition(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %globalId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %localId = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %1, align 4
  store float addrspace(1)* %output, float addrspace(1)** %2, align 4
  %3 = call i32 @llvm.r600.read.tgid.x()
  store i32 %3, i32* %globalId, align 4
  %4 = call i32 @get_group_id(i32 0)
  store i32 %4, i32* %groupId, align 4
  %5 = call i32 @llvm.r600.read.tidig.x()
  store i32 %5, i32* %localId, align 4
  %6 = load i32* %localId, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %13

; <label>:8                                       ; preds = %0
  %9 = load i32* %groupId, align 4
  %10 = load float addrspace(1)** %1, align 4
  %11 = getelementptr inbounds float addrspace(1)* %10, i32 %9
  %12 = load float addrspace(1)* %11, align 4
  store float %12, float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i32 0), align 4
  br label %13

; <label>:13                                      ; preds = %8, %0
  call void @barrier(i32 1)
  %14 = load float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i32 0), align 4
  %15 = load i32* %globalId, align 4
  %16 = load float addrspace(1)** %2, align 4
  %17 = getelementptr inbounds float addrspace(1)* %16, i32 %15
  %18 = load float addrspace(1)* %17, align 4
  %19 = fadd float %18, %14
  store float %19, float addrspace(1)* %17, align 4
  ret void
}

declare i32 @llvm.r600.read.tgid.x() #1
declare i32 @llvm.r600.read.tgid.y() #1
declare i32 @llvm.r600.read.tgid.z() #1

declare i32 @get_group_id(i32) #1

declare i32 @llvm.r600.read.tidig.x() #1
declare i32 @llvm.r600.read.tidig.y() #1
declare i32 @llvm.r600.read.tidig.z() #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @ScanLargeArrays(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size, float addrspace(1)* %sumBuffer) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %3 = alloca float addrspace(3)*, align 4
  %4 = alloca i32, align 4
  %5 = alloca float addrspace(1)*, align 4
  %tid = alloca i32, align 4
  %gid = alloca i32, align 4
  %bid = alloca i32, align 4
  %cache0 = alloca float, align 4
  %cache1 = alloca float, align 4
  %stride = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %1, align 4
  store float addrspace(1)* %input, float addrspace(1)** %2, align 4
  store float addrspace(3)* %block, float addrspace(3)** %3, align 4
  store i32 %block_size, i32* %4, align 4
  store float addrspace(1)* %sumBuffer, float addrspace(1)** %5, align 4
  %6 = call i32 @llvm.r600.read.tidig.x()
  store i32 %6, i32* %tid, align 4
  %7 = call i32 @llvm.r600.read.tgid.x()
  store i32 %7, i32* %gid, align 4
  %8 = call i32 @get_group_id(i32 0)
  store i32 %8, i32* %bid, align 4
  %9 = load i32* %gid, align 4
  %10 = mul nsw i32 2, %9
  %11 = load float addrspace(1)** %2, align 4
  %12 = getelementptr inbounds float addrspace(1)* %11, i32 %10
  %13 = load float addrspace(1)* %12, align 4
  %14 = load i32* %tid, align 4
  %15 = mul nsw i32 2, %14
  %16 = load float addrspace(3)** %3, align 4
  %17 = getelementptr inbounds float addrspace(3)* %16, i32 %15
  store float %13, float addrspace(3)* %17, align 4
  %18 = load i32* %gid, align 4
  %19 = mul nsw i32 2, %18
  %20 = add nsw i32 %19, 1
  %21 = load float addrspace(1)** %2, align 4
  %22 = getelementptr inbounds float addrspace(1)* %21, i32 %20
  %23 = load float addrspace(1)* %22, align 4
  %24 = load i32* %tid, align 4
  %25 = mul nsw i32 2, %24
  %26 = add nsw i32 %25, 1
  %27 = load float addrspace(3)** %3, align 4
  %28 = getelementptr inbounds float addrspace(3)* %27, i32 %26
  store float %23, float addrspace(3)* %28, align 4
  call void @barrier(i32 1)
  %29 = load float addrspace(3)** %3, align 4
  %30 = getelementptr inbounds float addrspace(3)* %29, i32 0
  %31 = load float addrspace(3)* %30, align 4
  store float %31, float* %cache0, align 4
  %32 = load float* %cache0, align 4
  %33 = load float addrspace(3)** %3, align 4
  %34 = getelementptr inbounds float addrspace(3)* %33, i32 1
  %35 = load float addrspace(3)* %34, align 4
  %36 = fadd float %32, %35
  store float %36, float* %cache1, align 4
  store i32 1, i32* %stride, align 4
  br label %37

; <label>:37                                      ; preds = %87, %0
  %38 = load i32* %stride, align 4
  %39 = load i32* %4, align 4
  %40 = icmp ult i32 %38, %39
  br i1 %40, label %41, label %90

; <label>:41                                      ; preds = %37
  %42 = load i32* %tid, align 4
  %43 = mul nsw i32 2, %42
  %44 = load i32* %stride, align 4
  %45 = icmp sge i32 %43, %44
  br i1 %45, label %46, label %75

; <label>:46                                      ; preds = %41
  %47 = load i32* %tid, align 4
  %48 = mul nsw i32 2, %47
  %49 = load i32* %stride, align 4
  %50 = sub nsw i32 %48, %49
  %51 = load float addrspace(3)** %3, align 4
  %52 = getelementptr inbounds float addrspace(3)* %51, i32 %50
  %53 = load float addrspace(3)* %52, align 4
  %54 = load i32* %tid, align 4
  %55 = mul nsw i32 2, %54
  %56 = load float addrspace(3)** %3, align 4
  %57 = getelementptr inbounds float addrspace(3)* %56, i32 %55
  %58 = load float addrspace(3)* %57, align 4
  %59 = fadd float %53, %58
  store float %59, float* %cache0, align 4
  %60 = load i32* %tid, align 4
  %61 = mul nsw i32 2, %60
  %62 = add nsw i32 %61, 1
  %63 = load i32* %stride, align 4
  %64 = sub nsw i32 %62, %63
  %65 = load float addrspace(3)** %3, align 4
  %66 = getelementptr inbounds float addrspace(3)* %65, i32 %64
  %67 = load float addrspace(3)* %66, align 4
  %68 = load i32* %tid, align 4
  %69 = mul nsw i32 2, %68
  %70 = add nsw i32 %69, 1
  %71 = load float addrspace(3)** %3, align 4
  %72 = getelementptr inbounds float addrspace(3)* %71, i32 %70
  %73 = load float addrspace(3)* %72, align 4
  %74 = fadd float %67, %73
  store float %74, float* %cache1, align 4
  br label %75

; <label>:75                                      ; preds = %46, %41
  call void @barrier(i32 1)
  %76 = load float* %cache0, align 4
  %77 = load i32* %tid, align 4
  %78 = mul nsw i32 2, %77
  %79 = load float addrspace(3)** %3, align 4
  %80 = getelementptr inbounds float addrspace(3)* %79, i32 %78
  store float %76, float addrspace(3)* %80, align 4
  %81 = load float* %cache1, align 4
  %82 = load i32* %tid, align 4
  %83 = mul nsw i32 2, %82
  %84 = add nsw i32 %83, 1
  %85 = load float addrspace(3)** %3, align 4
  %86 = getelementptr inbounds float addrspace(3)* %85, i32 %84
  store float %81, float addrspace(3)* %86, align 4
  call void @barrier(i32 1)
  br label %87

; <label>:87                                      ; preds = %75
  %88 = load i32* %stride, align 4
  %89 = mul nsw i32 %88, 2
  store i32 %89, i32* %stride, align 4
  br label %37

; <label>:90                                      ; preds = %37
  %91 = load i32* %4, align 4
  %92 = sub i32 %91, 1
  %93 = load float addrspace(3)** %3, align 4
  %94 = getelementptr inbounds float addrspace(3)* %93, i32 %92
  %95 = load float addrspace(3)* %94, align 4
  %96 = load i32* %bid, align 4
  %97 = load float addrspace(1)** %5, align 4
  %98 = getelementptr inbounds float addrspace(1)* %97, i32 %96
  store float %95, float addrspace(1)* %98, align 4
  %99 = load i32* %tid, align 4
  %100 = icmp eq i32 %99, 0
  br i1 %100, label %101, label %116

; <label>:101                                     ; preds = %90
  %102 = load i32* %gid, align 4
  %103 = mul nsw i32 2, %102
  %104 = load float addrspace(1)** %1, align 4
  %105 = getelementptr inbounds float addrspace(1)* %104, i32 %103
  store float 0.000000e+00, float addrspace(1)* %105, align 4
  %106 = load i32* %tid, align 4
  %107 = mul nsw i32 2, %106
  %108 = load float addrspace(3)** %3, align 4
  %109 = getelementptr inbounds float addrspace(3)* %108, i32 %107
  %110 = load float addrspace(3)* %109, align 4
  %111 = load i32* %gid, align 4
  %112 = mul nsw i32 2, %111
  %113 = add nsw i32 %112, 1
  %114 = load float addrspace(1)** %1, align 4
  %115 = getelementptr inbounds float addrspace(1)* %114, i32 %113
  store float %110, float addrspace(1)* %115, align 4
  br label %137

; <label>:116                                     ; preds = %90
  %117 = load i32* %tid, align 4
  %118 = mul nsw i32 2, %117
  %119 = sub nsw i32 %118, 1
  %120 = load float addrspace(3)** %3, align 4
  %121 = getelementptr inbounds float addrspace(3)* %120, i32 %119
  %122 = load float addrspace(3)* %121, align 4
  %123 = load i32* %gid, align 4
  %124 = mul nsw i32 2, %123
  %125 = load float addrspace(1)** %1, align 4
  %126 = getelementptr inbounds float addrspace(1)* %125, i32 %124
  store float %122, float addrspace(1)* %126, align 4
  %127 = load i32* %tid, align 4
  %128 = mul nsw i32 2, %127
  %129 = load float addrspace(3)** %3, align 4
  %130 = getelementptr inbounds float addrspace(3)* %129, i32 %128
  %131 = load float addrspace(3)* %130, align 4
  %132 = load i32* %gid, align 4
  %133 = mul nsw i32 2, %132
  %134 = add nsw i32 %133, 1
  %135 = load float addrspace(1)** %1, align 4
  %136 = getelementptr inbounds float addrspace(1)* %135, i32 %134
  store float %131, float addrspace(1)* %136, align 4
  br label %137

; <label>:137                                     ; preds = %116, %101
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %3 = alloca float addrspace(3)*, align 4
  %4 = alloca i32, align 4
  %tid = alloca i32, align 4
  %gid = alloca i32, align 4
  %bid = alloca i32, align 4
  %cache0 = alloca float, align 4
  %cache1 = alloca float, align 4
  %stride = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %1, align 4
  store float addrspace(1)* %input, float addrspace(1)** %2, align 4
  store float addrspace(3)* %block, float addrspace(3)** %3, align 4
  store i32 %block_size, i32* %4, align 4
  %5 = call i32 @llvm.r600.read.tidig.x()
  store i32 %5, i32* %tid, align 4
  %6 = call i32 @llvm.r600.read.tgid.x()
  store i32 %6, i32* %gid, align 4
  %7 = call i32 @get_group_id(i32 0)
  store i32 %7, i32* %bid, align 4
  %8 = load i32* %gid, align 4
  %9 = mul nsw i32 2, %8
  %10 = load float addrspace(1)** %2, align 4
  %11 = getelementptr inbounds float addrspace(1)* %10, i32 %9
  %12 = load float addrspace(1)* %11, align 4
  %13 = load i32* %tid, align 4
  %14 = mul nsw i32 2, %13
  %15 = load float addrspace(3)** %3, align 4
  %16 = getelementptr inbounds float addrspace(3)* %15, i32 %14
  store float %12, float addrspace(3)* %16, align 4
  %17 = load i32* %gid, align 4
  %18 = mul nsw i32 2, %17
  %19 = add nsw i32 %18, 1
  %20 = load float addrspace(1)** %2, align 4
  %21 = getelementptr inbounds float addrspace(1)* %20, i32 %19
  %22 = load float addrspace(1)* %21, align 4
  %23 = load i32* %tid, align 4
  %24 = mul nsw i32 2, %23
  %25 = add nsw i32 %24, 1
  %26 = load float addrspace(3)** %3, align 4
  %27 = getelementptr inbounds float addrspace(3)* %26, i32 %25
  store float %22, float addrspace(3)* %27, align 4
  call void @barrier(i32 1)
  %28 = load float addrspace(3)** %3, align 4
  %29 = getelementptr inbounds float addrspace(3)* %28, i32 0
  %30 = load float addrspace(3)* %29, align 4
  store float %30, float* %cache0, align 4
  %31 = load float* %cache0, align 4
  %32 = load float addrspace(3)** %3, align 4
  %33 = getelementptr inbounds float addrspace(3)* %32, i32 1
  %34 = load float addrspace(3)* %33, align 4
  %35 = fadd float %31, %34
  store float %35, float* %cache1, align 4
  store i32 1, i32* %stride, align 4
  br label %36

; <label>:36                                      ; preds = %86, %0
  %37 = load i32* %stride, align 4
  %38 = load i32* %4, align 4
  %39 = icmp ult i32 %37, %38
  br i1 %39, label %40, label %89

; <label>:40                                      ; preds = %36
  %41 = load i32* %tid, align 4
  %42 = mul nsw i32 2, %41
  %43 = load i32* %stride, align 4
  %44 = icmp sge i32 %42, %43
  br i1 %44, label %45, label %74

; <label>:45                                      ; preds = %40
  %46 = load i32* %tid, align 4
  %47 = mul nsw i32 2, %46
  %48 = load i32* %stride, align 4
  %49 = sub nsw i32 %47, %48
  %50 = load float addrspace(3)** %3, align 4
  %51 = getelementptr inbounds float addrspace(3)* %50, i32 %49
  %52 = load float addrspace(3)* %51, align 4
  %53 = load i32* %tid, align 4
  %54 = mul nsw i32 2, %53
  %55 = load float addrspace(3)** %3, align 4
  %56 = getelementptr inbounds float addrspace(3)* %55, i32 %54
  %57 = load float addrspace(3)* %56, align 4
  %58 = fadd float %52, %57
  store float %58, float* %cache0, align 4
  %59 = load i32* %tid, align 4
  %60 = mul nsw i32 2, %59
  %61 = add nsw i32 %60, 1
  %62 = load i32* %stride, align 4
  %63 = sub nsw i32 %61, %62
  %64 = load float addrspace(3)** %3, align 4
  %65 = getelementptr inbounds float addrspace(3)* %64, i32 %63
  %66 = load float addrspace(3)* %65, align 4
  %67 = load i32* %tid, align 4
  %68 = mul nsw i32 2, %67
  %69 = add nsw i32 %68, 1
  %70 = load float addrspace(3)** %3, align 4
  %71 = getelementptr inbounds float addrspace(3)* %70, i32 %69
  %72 = load float addrspace(3)* %71, align 4
  %73 = fadd float %66, %72
  store float %73, float* %cache1, align 4
  br label %74

; <label>:74                                      ; preds = %45, %40
  call void @barrier(i32 1)
  %75 = load float* %cache0, align 4
  %76 = load i32* %tid, align 4
  %77 = mul nsw i32 2, %76
  %78 = load float addrspace(3)** %3, align 4
  %79 = getelementptr inbounds float addrspace(3)* %78, i32 %77
  store float %75, float addrspace(3)* %79, align 4
  %80 = load float* %cache1, align 4
  %81 = load i32* %tid, align 4
  %82 = mul nsw i32 2, %81
  %83 = add nsw i32 %82, 1
  %84 = load float addrspace(3)** %3, align 4
  %85 = getelementptr inbounds float addrspace(3)* %84, i32 %83
  store float %80, float addrspace(3)* %85, align 4
  call void @barrier(i32 1)
  br label %86

; <label>:86                                      ; preds = %74
  %87 = load i32* %stride, align 4
  %88 = mul nsw i32 %87, 2
  store i32 %88, i32* %stride, align 4
  br label %36

; <label>:89                                      ; preds = %36
  %90 = load i32* %tid, align 4
  %91 = icmp eq i32 %90, 0
  br i1 %91, label %92, label %107

; <label>:92                                      ; preds = %89
  %93 = load i32* %gid, align 4
  %94 = mul nsw i32 2, %93
  %95 = load float addrspace(1)** %1, align 4
  %96 = getelementptr inbounds float addrspace(1)* %95, i32 %94
  store float 0.000000e+00, float addrspace(1)* %96, align 4
  %97 = load i32* %tid, align 4
  %98 = mul nsw i32 2, %97
  %99 = load float addrspace(3)** %3, align 4
  %100 = getelementptr inbounds float addrspace(3)* %99, i32 %98
  %101 = load float addrspace(3)* %100, align 4
  %102 = load i32* %gid, align 4
  %103 = mul nsw i32 2, %102
  %104 = add nsw i32 %103, 1
  %105 = load float addrspace(1)** %1, align 4
  %106 = getelementptr inbounds float addrspace(1)* %105, i32 %104
  store float %101, float addrspace(1)* %106, align 4
  br label %128

; <label>:107                                     ; preds = %89
  %108 = load i32* %tid, align 4
  %109 = mul nsw i32 2, %108
  %110 = sub nsw i32 %109, 1
  %111 = load float addrspace(3)** %3, align 4
  %112 = getelementptr inbounds float addrspace(3)* %111, i32 %110
  %113 = load float addrspace(3)* %112, align 4
  %114 = load i32* %gid, align 4
  %115 = mul nsw i32 2, %114
  %116 = load float addrspace(1)** %1, align 4
  %117 = getelementptr inbounds float addrspace(1)* %116, i32 %115
  store float %113, float addrspace(1)* %117, align 4
  %118 = load i32* %tid, align 4
  %119 = mul nsw i32 2, %118
  %120 = load float addrspace(3)** %3, align 4
  %121 = getelementptr inbounds float addrspace(3)* %120, i32 %119
  %122 = load float addrspace(3)* %121, align 4
  %123 = load i32* %gid, align 4
  %124 = mul nsw i32 2, %123
  %125 = add nsw i32 %124, 1
  %126 = load float addrspace(1)** %1, align 4
  %127 = getelementptr inbounds float addrspace(1)* %126, i32 %125
  store float %122, float addrspace(1)* %127, align 4
  br label %128

; <label>:128                                     ; preds = %107, %92
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @blockAddition}
!1 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, float addrspace(1)*)* @ScanLargeArrays}
!2 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32)* @prefixSum}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

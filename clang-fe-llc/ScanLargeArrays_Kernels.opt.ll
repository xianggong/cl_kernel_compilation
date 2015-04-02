; ModuleID = 'ScanLargeArrays_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@blockAddition.value = internal addrspace(3) global [1 x float] zeroinitializer, align 4

; Function Attrs: nounwind
define void @blockAddition(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_group_id(i32 0)
  %3 = call i32 @get_local_id(i32 0)
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %8

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds float addrspace(1)* %input, i32 %2
  %7 = load float addrspace(1)* %6, align 4
  store float %7, float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i32 0), align 4
  br label %8

; <label>:8                                       ; preds = %5, %0
  call void @barrier(i32 1)
  %9 = load float addrspace(3)* getelementptr inbounds ([1 x float] addrspace(3)* @blockAddition.value, i32 0, i32 0), align 4
  %10 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  %11 = load float addrspace(1)* %10, align 4
  %12 = fadd float %11, %9
  store float %12, float addrspace(1)* %10, align 4
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @ScanLargeArrays(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size, float addrspace(1)* %sumBuffer) #0 {
  %1 = call i32 @get_local_id(i32 0)
  %2 = call i32 @get_global_id(i32 0)
  %3 = call i32 @get_group_id(i32 0)
  %4 = mul nsw i32 2, %2
  %5 = getelementptr inbounds float addrspace(1)* %input, i32 %4
  %6 = load float addrspace(1)* %5, align 4
  %7 = mul nsw i32 2, %1
  %8 = getelementptr inbounds float addrspace(3)* %block, i32 %7
  store float %6, float addrspace(3)* %8, align 4
  %9 = mul nsw i32 2, %2
  %10 = add nsw i32 %9, 1
  %11 = getelementptr inbounds float addrspace(1)* %input, i32 %10
  %12 = load float addrspace(1)* %11, align 4
  %13 = mul nsw i32 2, %1
  %14 = add nsw i32 %13, 1
  %15 = getelementptr inbounds float addrspace(3)* %block, i32 %14
  store float %12, float addrspace(3)* %15, align 4
  call void @barrier(i32 1)
  %16 = getelementptr inbounds float addrspace(3)* %block, i32 0
  %17 = load float addrspace(3)* %16, align 4
  %18 = getelementptr inbounds float addrspace(3)* %block, i32 1
  %19 = load float addrspace(3)* %18, align 4
  %20 = fadd float %17, %19
  br label %21

; <label>:21                                      ; preds = %51, %0
  %cache0.0 = phi float [ %17, %0 ], [ %cache0.1, %51 ]
  %cache1.0 = phi float [ %20, %0 ], [ %cache1.1, %51 ]
  %stride.0 = phi i32 [ 1, %0 ], [ %52, %51 ]
  %22 = icmp ult i32 %stride.0, %block_size
  br i1 %22, label %23, label %53

; <label>:23                                      ; preds = %21
  %24 = mul nsw i32 2, %1
  %25 = icmp sge i32 %24, %stride.0
  br i1 %25, label %26, label %45

; <label>:26                                      ; preds = %23
  %27 = mul nsw i32 2, %1
  %28 = sub nsw i32 %27, %stride.0
  %29 = getelementptr inbounds float addrspace(3)* %block, i32 %28
  %30 = load float addrspace(3)* %29, align 4
  %31 = mul nsw i32 2, %1
  %32 = getelementptr inbounds float addrspace(3)* %block, i32 %31
  %33 = load float addrspace(3)* %32, align 4
  %34 = fadd float %30, %33
  %35 = mul nsw i32 2, %1
  %36 = add nsw i32 %35, 1
  %37 = sub nsw i32 %36, %stride.0
  %38 = getelementptr inbounds float addrspace(3)* %block, i32 %37
  %39 = load float addrspace(3)* %38, align 4
  %40 = mul nsw i32 2, %1
  %41 = add nsw i32 %40, 1
  %42 = getelementptr inbounds float addrspace(3)* %block, i32 %41
  %43 = load float addrspace(3)* %42, align 4
  %44 = fadd float %39, %43
  br label %45

; <label>:45                                      ; preds = %26, %23
  %cache0.1 = phi float [ %34, %26 ], [ %cache0.0, %23 ]
  %cache1.1 = phi float [ %44, %26 ], [ %cache1.0, %23 ]
  call void @barrier(i32 1)
  %46 = mul nsw i32 2, %1
  %47 = getelementptr inbounds float addrspace(3)* %block, i32 %46
  store float %cache0.1, float addrspace(3)* %47, align 4
  %48 = mul nsw i32 2, %1
  %49 = add nsw i32 %48, 1
  %50 = getelementptr inbounds float addrspace(3)* %block, i32 %49
  store float %cache1.1, float addrspace(3)* %50, align 4
  call void @barrier(i32 1)
  br label %51

; <label>:51                                      ; preds = %45
  %52 = mul nsw i32 %stride.0, 2
  br label %21

; <label>:53                                      ; preds = %21
  %54 = sub i32 %block_size, 1
  %55 = getelementptr inbounds float addrspace(3)* %block, i32 %54
  %56 = load float addrspace(3)* %55, align 4
  %57 = getelementptr inbounds float addrspace(1)* %sumBuffer, i32 %3
  store float %56, float addrspace(1)* %57, align 4
  %58 = icmp eq i32 %1, 0
  br i1 %58, label %59, label %68

; <label>:59                                      ; preds = %53
  %60 = mul nsw i32 2, %2
  %61 = getelementptr inbounds float addrspace(1)* %output, i32 %60
  store float 0.000000e+00, float addrspace(1)* %61, align 4
  %62 = mul nsw i32 2, %1
  %63 = getelementptr inbounds float addrspace(3)* %block, i32 %62
  %64 = load float addrspace(3)* %63, align 4
  %65 = mul nsw i32 2, %2
  %66 = add nsw i32 %65, 1
  %67 = getelementptr inbounds float addrspace(1)* %output, i32 %66
  store float %64, float addrspace(1)* %67, align 4
  br label %81

; <label>:68                                      ; preds = %53
  %69 = mul nsw i32 2, %1
  %70 = sub nsw i32 %69, 1
  %71 = getelementptr inbounds float addrspace(3)* %block, i32 %70
  %72 = load float addrspace(3)* %71, align 4
  %73 = mul nsw i32 2, %2
  %74 = getelementptr inbounds float addrspace(1)* %output, i32 %73
  store float %72, float addrspace(1)* %74, align 4
  %75 = mul nsw i32 2, %1
  %76 = getelementptr inbounds float addrspace(3)* %block, i32 %75
  %77 = load float addrspace(3)* %76, align 4
  %78 = mul nsw i32 2, %2
  %79 = add nsw i32 %78, 1
  %80 = getelementptr inbounds float addrspace(1)* %output, i32 %79
  store float %77, float addrspace(1)* %80, align 4
  br label %81

; <label>:81                                      ; preds = %68, %59
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %block_size) #0 {
  %1 = call i32 @get_local_id(i32 0)
  %2 = call i32 @get_global_id(i32 0)
  %3 = call i32 @get_group_id(i32 0)
  %4 = mul nsw i32 2, %2
  %5 = getelementptr inbounds float addrspace(1)* %input, i32 %4
  %6 = load float addrspace(1)* %5, align 4
  %7 = mul nsw i32 2, %1
  %8 = getelementptr inbounds float addrspace(3)* %block, i32 %7
  store float %6, float addrspace(3)* %8, align 4
  %9 = mul nsw i32 2, %2
  %10 = add nsw i32 %9, 1
  %11 = getelementptr inbounds float addrspace(1)* %input, i32 %10
  %12 = load float addrspace(1)* %11, align 4
  %13 = mul nsw i32 2, %1
  %14 = add nsw i32 %13, 1
  %15 = getelementptr inbounds float addrspace(3)* %block, i32 %14
  store float %12, float addrspace(3)* %15, align 4
  call void @barrier(i32 1)
  %16 = getelementptr inbounds float addrspace(3)* %block, i32 0
  %17 = load float addrspace(3)* %16, align 4
  %18 = getelementptr inbounds float addrspace(3)* %block, i32 1
  %19 = load float addrspace(3)* %18, align 4
  %20 = fadd float %17, %19
  br label %21

; <label>:21                                      ; preds = %51, %0
  %cache0.0 = phi float [ %17, %0 ], [ %cache0.1, %51 ]
  %cache1.0 = phi float [ %20, %0 ], [ %cache1.1, %51 ]
  %stride.0 = phi i32 [ 1, %0 ], [ %52, %51 ]
  %22 = icmp ult i32 %stride.0, %block_size
  br i1 %22, label %23, label %53

; <label>:23                                      ; preds = %21
  %24 = mul nsw i32 2, %1
  %25 = icmp sge i32 %24, %stride.0
  br i1 %25, label %26, label %45

; <label>:26                                      ; preds = %23
  %27 = mul nsw i32 2, %1
  %28 = sub nsw i32 %27, %stride.0
  %29 = getelementptr inbounds float addrspace(3)* %block, i32 %28
  %30 = load float addrspace(3)* %29, align 4
  %31 = mul nsw i32 2, %1
  %32 = getelementptr inbounds float addrspace(3)* %block, i32 %31
  %33 = load float addrspace(3)* %32, align 4
  %34 = fadd float %30, %33
  %35 = mul nsw i32 2, %1
  %36 = add nsw i32 %35, 1
  %37 = sub nsw i32 %36, %stride.0
  %38 = getelementptr inbounds float addrspace(3)* %block, i32 %37
  %39 = load float addrspace(3)* %38, align 4
  %40 = mul nsw i32 2, %1
  %41 = add nsw i32 %40, 1
  %42 = getelementptr inbounds float addrspace(3)* %block, i32 %41
  %43 = load float addrspace(3)* %42, align 4
  %44 = fadd float %39, %43
  br label %45

; <label>:45                                      ; preds = %26, %23
  %cache0.1 = phi float [ %34, %26 ], [ %cache0.0, %23 ]
  %cache1.1 = phi float [ %44, %26 ], [ %cache1.0, %23 ]
  call void @barrier(i32 1)
  %46 = mul nsw i32 2, %1
  %47 = getelementptr inbounds float addrspace(3)* %block, i32 %46
  store float %cache0.1, float addrspace(3)* %47, align 4
  %48 = mul nsw i32 2, %1
  %49 = add nsw i32 %48, 1
  %50 = getelementptr inbounds float addrspace(3)* %block, i32 %49
  store float %cache1.1, float addrspace(3)* %50, align 4
  call void @barrier(i32 1)
  br label %51

; <label>:51                                      ; preds = %45
  %52 = mul nsw i32 %stride.0, 2
  br label %21

; <label>:53                                      ; preds = %21
  %54 = icmp eq i32 %1, 0
  br i1 %54, label %55, label %64

; <label>:55                                      ; preds = %53
  %56 = mul nsw i32 2, %2
  %57 = getelementptr inbounds float addrspace(1)* %output, i32 %56
  store float 0.000000e+00, float addrspace(1)* %57, align 4
  %58 = mul nsw i32 2, %1
  %59 = getelementptr inbounds float addrspace(3)* %block, i32 %58
  %60 = load float addrspace(3)* %59, align 4
  %61 = mul nsw i32 2, %2
  %62 = add nsw i32 %61, 1
  %63 = getelementptr inbounds float addrspace(1)* %output, i32 %62
  store float %60, float addrspace(1)* %63, align 4
  br label %77

; <label>:64                                      ; preds = %53
  %65 = mul nsw i32 2, %1
  %66 = sub nsw i32 %65, 1
  %67 = getelementptr inbounds float addrspace(3)* %block, i32 %66
  %68 = load float addrspace(3)* %67, align 4
  %69 = mul nsw i32 2, %2
  %70 = getelementptr inbounds float addrspace(1)* %output, i32 %69
  store float %68, float addrspace(1)* %70, align 4
  %71 = mul nsw i32 2, %1
  %72 = getelementptr inbounds float addrspace(3)* %block, i32 %71
  %73 = load float addrspace(3)* %72, align 4
  %74 = mul nsw i32 2, %2
  %75 = add nsw i32 %74, 1
  %76 = getelementptr inbounds float addrspace(1)* %output, i32 %75
  store float %73, float addrspace(1)* %76, align 4
  br label %77

; <label>:77                                      ; preds = %64, %55
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

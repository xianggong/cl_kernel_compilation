; ModuleID = 'PrefixSum_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @group_prefixSum(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %length, i32 %idxOffset) #0 {
  %1 = call i32 @get_local_id(i32 0)
  %2 = call i32 @get_local_size(i32 0)
  %3 = call i32 @get_group_id(i32 0)
  %4 = mul nsw i32 %3, %2
  %5 = add nsw i32 %4, %1
  %6 = mul nsw i32 2, %5
  %7 = add nsw i32 %6, 1
  %8 = mul i32 %idxOffset, %7
  %9 = sub i32 %8, 1
  %10 = icmp ult i32 %9, %length
  br i1 %10, label %11, label %16

; <label>:11                                      ; preds = %0
  %12 = getelementptr inbounds float addrspace(1)* %input, i32 %9
  %13 = load float addrspace(1)* %12, align 4
  %14 = mul nsw i32 2, %1
  %15 = getelementptr inbounds float addrspace(3)* %block, i32 %14
  store float %13, float addrspace(3)* %15, align 4
  br label %16

; <label>:16                                      ; preds = %11, %0
  %17 = add i32 %9, %idxOffset
  %18 = icmp ult i32 %17, %length
  br i1 %18, label %19, label %26

; <label>:19                                      ; preds = %16
  %20 = add i32 %9, %idxOffset
  %21 = getelementptr inbounds float addrspace(1)* %input, i32 %20
  %22 = load float addrspace(1)* %21, align 4
  %23 = mul nsw i32 2, %1
  %24 = add nsw i32 %23, 1
  %25 = getelementptr inbounds float addrspace(3)* %block, i32 %24
  store float %22, float addrspace(3)* %25, align 4
  br label %26

; <label>:26                                      ; preds = %19, %16
  %27 = lshr i32 %length, 1
  br label %28

; <label>:28                                      ; preds = %48, %26
  %offset.0 = phi i32 [ 1, %26 ], [ %47, %48 ]
  %l.0 = phi i32 [ %27, %26 ], [ %49, %48 ]
  %29 = icmp sgt i32 %l.0, 0
  br i1 %29, label %30, label %50

; <label>:30                                      ; preds = %28
  call void @barrier(i32 1)
  %31 = icmp slt i32 %1, %l.0
  br i1 %31, label %32, label %46

; <label>:32                                      ; preds = %30
  %33 = mul nsw i32 2, %1
  %34 = add nsw i32 %33, 1
  %35 = mul nsw i32 %offset.0, %34
  %36 = sub nsw i32 %35, 1
  %37 = mul nsw i32 2, %1
  %38 = add nsw i32 %37, 2
  %39 = mul nsw i32 %offset.0, %38
  %40 = sub nsw i32 %39, 1
  %41 = getelementptr inbounds float addrspace(3)* %block, i32 %36
  %42 = load float addrspace(3)* %41, align 4
  %43 = getelementptr inbounds float addrspace(3)* %block, i32 %40
  %44 = load float addrspace(3)* %43, align 4
  %45 = fadd float %44, %42
  store float %45, float addrspace(3)* %43, align 4
  br label %46

; <label>:46                                      ; preds = %32, %30
  %47 = shl i32 %offset.0, 1
  br label %48

; <label>:48                                      ; preds = %46
  %49 = ashr i32 %l.0, 1
  br label %28

; <label>:50                                      ; preds = %28
  %51 = icmp ult i32 %offset.0, %length
  br i1 %51, label %52, label %54

; <label>:52                                      ; preds = %50
  %53 = shl i32 %offset.0, 1
  br label %54

; <label>:54                                      ; preds = %52, %50
  %offset.1 = phi i32 [ %53, %52 ], [ %offset.0, %50 ]
  %55 = ashr i32 %offset.1, 1
  br label %56

; <label>:56                                      ; preds = %74, %54
  %offset.2 = phi i32 [ %offset.1, %54 ], [ %60, %74 ]
  %d.0 = phi i32 [ 0, %54 ], [ %75, %74 ]
  %57 = icmp slt i32 %d.0, %55
  br i1 %57, label %58, label %76

; <label>:58                                      ; preds = %56
  %59 = add nsw i32 %d.0, 1
  %60 = ashr i32 %offset.2, 1
  call void @barrier(i32 1)
  %61 = icmp slt i32 %1, %59
  br i1 %61, label %62, label %73

; <label>:62                                      ; preds = %58
  %63 = add nsw i32 %1, 1
  %64 = mul nsw i32 %60, %63
  %65 = sub nsw i32 %64, 1
  %66 = ashr i32 %60, 1
  %67 = add nsw i32 %65, %66
  %68 = getelementptr inbounds float addrspace(3)* %block, i32 %65
  %69 = load float addrspace(3)* %68, align 4
  %70 = getelementptr inbounds float addrspace(3)* %block, i32 %67
  %71 = load float addrspace(3)* %70, align 4
  %72 = fadd float %71, %69
  store float %72, float addrspace(3)* %70, align 4
  br label %73

; <label>:73                                      ; preds = %62, %58
  br label %74

; <label>:74                                      ; preds = %73
  %75 = shl i32 %59, 1
  br label %56

; <label>:76                                      ; preds = %56
  call void @barrier(i32 1)
  %77 = icmp ult i32 %9, %length
  br i1 %77, label %78, label %83

; <label>:78                                      ; preds = %76
  %79 = mul nsw i32 2, %1
  %80 = getelementptr inbounds float addrspace(3)* %block, i32 %79
  %81 = load float addrspace(3)* %80, align 4
  %82 = getelementptr inbounds float addrspace(1)* %output, i32 %9
  store float %81, float addrspace(1)* %82, align 4
  br label %83

; <label>:83                                      ; preds = %78, %76
  %84 = add i32 %9, %idxOffset
  %85 = icmp ult i32 %84, %length
  br i1 %85, label %86, label %93

; <label>:86                                      ; preds = %83
  %87 = mul nsw i32 2, %1
  %88 = add nsw i32 %87, 1
  %89 = getelementptr inbounds float addrspace(3)* %block, i32 %88
  %90 = load float addrspace(3)* %89, align 4
  %91 = add i32 %9, %idxOffset
  %92 = getelementptr inbounds float addrspace(1)* %output, i32 %91
  store float %90, float addrspace(1)* %92, align 4
  br label %93

; <label>:93                                      ; preds = %86, %83
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_local_size(i32) #1

declare i32 @get_group_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @global_prefixSum(float addrspace(1)* %buffer, i32 %offset, i32 %length) #0 {
  %1 = call i32 @get_local_size(i32 0)
  %2 = call i32 @get_group_id(i32 0)
  %3 = udiv i32 %offset, %1
  %4 = shl i32 %offset, 1
  %5 = sub i32 %4, %3
  %6 = udiv i32 %2, %5
  %7 = add i32 %6, 1
  %8 = mul i32 %7, %3
  %9 = add i32 %2, %8
  %10 = mul nsw i32 %9, %1
  %11 = call i32 @get_local_id(i32 0)
  %12 = add i32 %10, %11
  %13 = add nsw i32 %12, 1
  %14 = urem i32 %13, %offset
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %27

; <label>:16                                      ; preds = %0
  %17 = icmp ult i32 %12, %length
  br i1 %17, label %18, label %27

; <label>:18                                      ; preds = %16
  %19 = urem i32 %12, %offset
  %20 = add i32 %19, 1
  %21 = sub i32 %12, %20
  %22 = getelementptr inbounds float addrspace(1)* %buffer, i32 %21
  %23 = load float addrspace(1)* %22, align 4
  %24 = getelementptr inbounds float addrspace(1)* %buffer, i32 %12
  %25 = load float addrspace(1)* %24, align 4
  %26 = fadd float %25, %23
  store float %26, float addrspace(1)* %24, align 4
  br label %27

; <label>:27                                      ; preds = %18, %16, %0
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32)* @group_prefixSum}
!1 = metadata !{void (float addrspace(1)*, i32, i32)* @global_prefixSum}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

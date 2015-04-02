; ModuleID = '../kernel-src/TransferOverlapCPP_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@readKernel.lcount = internal addrspace(3) global i32 0, align 4
@writeKernel.lval = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define void @readKernel(<4 x i32> addrspace(1)* %in, i32 addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = alloca <4 x i32> addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %pcount = alloca i32, align 4
  %i = alloca i32, align 4
  %idx = alloca i32, align 4
  %n = alloca i32, align 4
  store <4 x i32> addrspace(1)* %in, <4 x i32> addrspace(1)** %1, align 4
  store i32 addrspace(1)* %out, i32 addrspace(1)** %2, align 4
  store i32 %ni, i32* %3, align 4
  store i32 %val, i32* %4, align 4
  store i32 %nk, i32* %5, align 4
  store i32 0, i32* %pcount, align 4
  %6 = call i32 @get_local_id(i32 0)
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %0
  store i32 0, i32 addrspace(3)* @readKernel.lcount, align 4
  br label %9

; <label>:9                                       ; preds = %8, %0
  call void @barrier(i32 1)
  store i32 0, i32* %n, align 4
  br label %10

; <label>:10                                      ; preds = %72, %9
  %11 = load i32* %n, align 4
  %12 = load i32* %5, align 4
  %13 = icmp ult i32 %11, %12
  br i1 %13, label %14, label %75

; <label>:14                                      ; preds = %10
  store i32 0, i32* %i, align 4
  %15 = call i32 @get_global_id(i32 0)
  store i32 %15, i32* %idx, align 4
  br label %16

; <label>:16                                      ; preds = %65, %14
  %17 = load i32* %i, align 4
  %18 = load i32* %3, align 4
  %19 = icmp ult i32 %17, %18
  br i1 %19, label %20, label %71

; <label>:20                                      ; preds = %16
  %21 = load i32* %idx, align 4
  %22 = load <4 x i32> addrspace(1)** %1, align 4
  %23 = getelementptr inbounds <4 x i32> addrspace(1)* %22, i32 %21
  %24 = load volatile <4 x i32> addrspace(1)* %23, align 16
  %25 = extractelement <4 x i32> %24, i32 0
  %26 = load i32* %4, align 4
  %27 = icmp eq i32 %25, %26
  br i1 %27, label %28, label %31

; <label>:28                                      ; preds = %20
  %29 = load i32* %pcount, align 4
  %30 = add i32 %29, 1
  store i32 %30, i32* %pcount, align 4
  br label %31

; <label>:31                                      ; preds = %28, %20
  %32 = load i32* %idx, align 4
  %33 = load <4 x i32> addrspace(1)** %1, align 4
  %34 = getelementptr inbounds <4 x i32> addrspace(1)* %33, i32 %32
  %35 = load volatile <4 x i32> addrspace(1)* %34, align 16
  %36 = extractelement <4 x i32> %35, i32 1
  %37 = load i32* %4, align 4
  %38 = icmp eq i32 %36, %37
  br i1 %38, label %39, label %42

; <label>:39                                      ; preds = %31
  %40 = load i32* %pcount, align 4
  %41 = add i32 %40, 1
  store i32 %41, i32* %pcount, align 4
  br label %42

; <label>:42                                      ; preds = %39, %31
  %43 = load i32* %idx, align 4
  %44 = load <4 x i32> addrspace(1)** %1, align 4
  %45 = getelementptr inbounds <4 x i32> addrspace(1)* %44, i32 %43
  %46 = load volatile <4 x i32> addrspace(1)* %45, align 16
  %47 = extractelement <4 x i32> %46, i32 2
  %48 = load i32* %4, align 4
  %49 = icmp eq i32 %47, %48
  br i1 %49, label %50, label %53

; <label>:50                                      ; preds = %42
  %51 = load i32* %pcount, align 4
  %52 = add i32 %51, 1
  store i32 %52, i32* %pcount, align 4
  br label %53

; <label>:53                                      ; preds = %50, %42
  %54 = load i32* %idx, align 4
  %55 = load <4 x i32> addrspace(1)** %1, align 4
  %56 = getelementptr inbounds <4 x i32> addrspace(1)* %55, i32 %54
  %57 = load volatile <4 x i32> addrspace(1)* %56, align 16
  %58 = extractelement <4 x i32> %57, i32 3
  %59 = load i32* %4, align 4
  %60 = icmp eq i32 %58, %59
  br i1 %60, label %61, label %64

; <label>:61                                      ; preds = %53
  %62 = load i32* %pcount, align 4
  %63 = add i32 %62, 1
  store i32 %63, i32* %pcount, align 4
  br label %64

; <label>:64                                      ; preds = %61, %53
  br label %65

; <label>:65                                      ; preds = %64
  %66 = load i32* %i, align 4
  %67 = add i32 %66, 1
  store i32 %67, i32* %i, align 4
  %68 = call i32 @get_global_size(i32 0)
  %69 = load i32* %idx, align 4
  %70 = add i32 %69, %68
  store i32 %70, i32* %idx, align 4
  br label %16

; <label>:71                                      ; preds = %16
  br label %72

; <label>:72                                      ; preds = %71
  %73 = load i32* %n, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, i32* %n, align 4
  br label %10

; <label>:75                                      ; preds = %10
  %76 = load i32* %pcount, align 4
  %77 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @readKernel.lcount, i32 %76)
  call void @barrier(i32 1)
  %78 = call i32 @get_local_id(i32 0)
  %79 = icmp eq i32 %78, 0
  br i1 %79, label %80, label %87

; <label>:80                                      ; preds = %75
  %81 = load i32 addrspace(3)* @readKernel.lcount, align 4
  %82 = load i32* %5, align 4
  %83 = udiv i32 %81, %82
  %84 = call i32 @get_group_id(i32 0)
  %85 = load i32 addrspace(1)** %2, align 4
  %86 = getelementptr inbounds i32 addrspace(1)* %85, i32 %84
  store volatile i32 %83, i32 addrspace(1)* %86, align 4
  br label %87

; <label>:87                                      ; preds = %80, %75
  %88 = call i32 @get_global_id(i32 0)
  %89 = icmp eq i32 %88, 0
  br i1 %89, label %90, label %96

; <label>:90                                      ; preds = %87
  %91 = load i32* %4, align 4
  %92 = call i32 @get_num_groups(i32 0)
  %93 = add i32 %92, 1
  %94 = load i32 addrspace(1)** %2, align 4
  %95 = getelementptr inbounds i32 addrspace(1)* %94, i32 %93
  store volatile i32 %91, i32 addrspace(1)* %95, align 4
  br label %96

; <label>:96                                      ; preds = %90, %87
  ret void
}

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_num_groups(i32) #1

; Function Attrs: nounwind
define void @writeKernel(i32 addrspace(1)* %in, <4 x i32> addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca <4 x i32> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %pval = alloca <4 x i32>, align 16
  %i = alloca i32, align 4
  %idx = alloca i32, align 4
  %6 = alloca <4 x i32>, align 16
  %n = alloca i32, align 4
  store i32 addrspace(1)* %in, i32 addrspace(1)** %1, align 4
  store <4 x i32> addrspace(1)* %out, <4 x i32> addrspace(1)** %2, align 4
  store i32 %ni, i32* %3, align 4
  store i32 %val, i32* %4, align 4
  store i32 %nk, i32* %5, align 4
  %7 = call i32 @get_local_id(i32 0)
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %15

; <label>:9                                       ; preds = %0
  %10 = call i32 @get_num_groups(i32 0)
  %11 = add i32 %10, 1
  %12 = load i32 addrspace(1)** %1, align 4
  %13 = getelementptr inbounds i32 addrspace(1)* %12, i32 %11
  %14 = load volatile i32 addrspace(1)* %13, align 4
  store i32 %14, i32 addrspace(3)* @writeKernel.lval, align 4
  br label %15

; <label>:15                                      ; preds = %9, %0
  call void @barrier(i32 1)
  %16 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %17 = insertelement <4 x i32> undef, i32 %16, i32 0
  %18 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %19 = insertelement <4 x i32> %17, i32 %18, i32 1
  %20 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %21 = insertelement <4 x i32> %19, i32 %20, i32 2
  %22 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %23 = insertelement <4 x i32> %21, i32 %22, i32 3
  store <4 x i32> %23, <4 x i32>* %6
  %24 = load <4 x i32>* %6
  store <4 x i32> %24, <4 x i32>* %pval, align 16
  store i32 0, i32* %n, align 4
  br label %25

; <label>:25                                      ; preds = %47, %15
  %26 = load i32* %n, align 4
  %27 = load i32* %5, align 4
  %28 = icmp ult i32 %26, %27
  br i1 %28, label %29, label %50

; <label>:29                                      ; preds = %25
  store i32 0, i32* %i, align 4
  %30 = call i32 @get_global_id(i32 0)
  store i32 %30, i32* %idx, align 4
  br label %31

; <label>:31                                      ; preds = %40, %29
  %32 = load i32* %i, align 4
  %33 = load i32* %3, align 4
  %34 = icmp ult i32 %32, %33
  br i1 %34, label %35, label %46

; <label>:35                                      ; preds = %31
  %36 = load <4 x i32>* %pval, align 16
  %37 = load i32* %idx, align 4
  %38 = load <4 x i32> addrspace(1)** %2, align 4
  %39 = getelementptr inbounds <4 x i32> addrspace(1)* %38, i32 %37
  store volatile <4 x i32> %36, <4 x i32> addrspace(1)* %39, align 16
  br label %40

; <label>:40                                      ; preds = %35
  %41 = load i32* %i, align 4
  %42 = add i32 %41, 1
  store i32 %42, i32* %i, align 4
  %43 = call i32 @get_global_size(i32 0)
  %44 = load i32* %idx, align 4
  %45 = add i32 %44, %43
  store i32 %45, i32* %idx, align 4
  br label %31

; <label>:46                                      ; preds = %31
  br label %47

; <label>:47                                      ; preds = %46
  %48 = load i32* %n, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, i32* %n, align 4
  br label %25

; <label>:50                                      ; preds = %25
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @readKernel}
!1 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @writeKernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

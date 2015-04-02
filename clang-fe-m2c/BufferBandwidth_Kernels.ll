; ModuleID = '../kernel-src/BufferBandwidth_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@read_kernel.lcount = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define void @read_kernel(<4 x i32> addrspace(1)* %in, i32 addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
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
  %6 = load i32* %5, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %0
  br label %91

; <label>:9                                       ; preds = %0
  store i32 0, i32* %pcount, align 4
  %10 = call i32 @__get_local_id_u32(i32 0)
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %13

; <label>:12                                      ; preds = %9
  store i32 0, i32 addrspace(3)* @read_kernel.lcount, align 4
  br label %13

; <label>:13                                      ; preds = %12, %9
  call void @barrier(i32 1)
  store i32 0, i32* %n, align 4
  br label %14

; <label>:14                                      ; preds = %76, %13
  %15 = load i32* %n, align 4
  %16 = load i32* %5, align 4
  %17 = icmp ult i32 %15, %16
  br i1 %17, label %18, label %79

; <label>:18                                      ; preds = %14
  store i32 0, i32* %i, align 4
  %19 = call i32 @__get_global_id_u32(i32 0)
  store i32 %19, i32* %idx, align 4
  br label %20

; <label>:20                                      ; preds = %69, %18
  %21 = load i32* %i, align 4
  %22 = load i32* %3, align 4
  %23 = icmp ult i32 %21, %22
  br i1 %23, label %24, label %75

; <label>:24                                      ; preds = %20
  %25 = load i32* %idx, align 4
  %26 = load <4 x i32> addrspace(1)** %1, align 4
  %27 = getelementptr inbounds <4 x i32> addrspace(1)* %26, i32 %25
  %28 = load <4 x i32> addrspace(1)* %27, align 16
  %29 = extractelement <4 x i32> %28, i32 0
  %30 = load i32* %4, align 4
  %31 = icmp eq i32 %29, %30
  br i1 %31, label %32, label %35

; <label>:32                                      ; preds = %24
  %33 = load i32* %pcount, align 4
  %34 = add i32 %33, 1
  store i32 %34, i32* %pcount, align 4
  br label %35

; <label>:35                                      ; preds = %32, %24
  %36 = load i32* %idx, align 4
  %37 = load <4 x i32> addrspace(1)** %1, align 4
  %38 = getelementptr inbounds <4 x i32> addrspace(1)* %37, i32 %36
  %39 = load <4 x i32> addrspace(1)* %38, align 16
  %40 = extractelement <4 x i32> %39, i32 1
  %41 = load i32* %4, align 4
  %42 = icmp eq i32 %40, %41
  br i1 %42, label %43, label %46

; <label>:43                                      ; preds = %35
  %44 = load i32* %pcount, align 4
  %45 = add i32 %44, 1
  store i32 %45, i32* %pcount, align 4
  br label %46

; <label>:46                                      ; preds = %43, %35
  %47 = load i32* %idx, align 4
  %48 = load <4 x i32> addrspace(1)** %1, align 4
  %49 = getelementptr inbounds <4 x i32> addrspace(1)* %48, i32 %47
  %50 = load <4 x i32> addrspace(1)* %49, align 16
  %51 = extractelement <4 x i32> %50, i32 2
  %52 = load i32* %4, align 4
  %53 = icmp eq i32 %51, %52
  br i1 %53, label %54, label %57

; <label>:54                                      ; preds = %46
  %55 = load i32* %pcount, align 4
  %56 = add i32 %55, 1
  store i32 %56, i32* %pcount, align 4
  br label %57

; <label>:57                                      ; preds = %54, %46
  %58 = load i32* %idx, align 4
  %59 = load <4 x i32> addrspace(1)** %1, align 4
  %60 = getelementptr inbounds <4 x i32> addrspace(1)* %59, i32 %58
  %61 = load <4 x i32> addrspace(1)* %60, align 16
  %62 = extractelement <4 x i32> %61, i32 3
  %63 = load i32* %4, align 4
  %64 = icmp eq i32 %62, %63
  br i1 %64, label %65, label %68

; <label>:65                                      ; preds = %57
  %66 = load i32* %pcount, align 4
  %67 = add i32 %66, 1
  store i32 %67, i32* %pcount, align 4
  br label %68

; <label>:68                                      ; preds = %65, %57
  br label %69

; <label>:69                                      ; preds = %68
  %70 = load i32* %i, align 4
  %71 = add i32 %70, 1
  store i32 %71, i32* %i, align 4
  %72 = call i32 @__get_global_size_u32(i32 0)
  %73 = load i32* %idx, align 4
  %74 = add i32 %73, %72
  store i32 %74, i32* %idx, align 4
  br label %20

; <label>:75                                      ; preds = %20
  br label %76

; <label>:76                                      ; preds = %75
  %77 = load i32* %n, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, i32* %n, align 4
  br label %14

; <label>:79                                      ; preds = %14
  %80 = load i32* %pcount, align 4
  %81 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @read_kernel.lcount, i32 %80)
  call void @barrier(i32 1)
  %82 = call i32 @__get_local_id_u32(i32 0)
  %83 = icmp eq i32 %82, 0
  br i1 %83, label %84, label %91

; <label>:84                                      ; preds = %79
  %85 = load i32 addrspace(3)* @read_kernel.lcount, align 4
  %86 = load i32* %5, align 4
  %87 = udiv i32 %85, %86
  %88 = call i32 @__get_group_id_u32(i32 0)
  %89 = load i32 addrspace(1)** %2, align 4
  %90 = getelementptr inbounds i32 addrspace(1)* %89, i32 %88
  store i32 %87, i32 addrspace(1)* %90, align 4
  br label %91

; <label>:91                                      ; preds = %8, %84, %79
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare void @barrier(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

declare i32 @__get_group_id_u32(i32) #1

; Function Attrs: nounwind
define void @write_kernel(i32 addrspace(1)* %in, <4 x i32> addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca <4 x i32> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %i = alloca i32, align 4
  %idx = alloca i32, align 4
  %pval = alloca <4 x i32>, align 16
  %6 = alloca <4 x i32>, align 16
  %n = alloca i32, align 4
  store i32 addrspace(1)* %in, i32 addrspace(1)** %1, align 4
  store <4 x i32> addrspace(1)* %out, <4 x i32> addrspace(1)** %2, align 4
  store i32 %ni, i32* %3, align 4
  store i32 %val, i32* %4, align 4
  store i32 %nk, i32* %5, align 4
  %7 = load i32* %5, align 4
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %10

; <label>:9                                       ; preds = %0
  br label %45

; <label>:10                                      ; preds = %0
  %11 = load i32* %4, align 4
  %12 = insertelement <4 x i32> undef, i32 %11, i32 0
  %13 = load i32* %4, align 4
  %14 = insertelement <4 x i32> %12, i32 %13, i32 1
  %15 = load i32* %4, align 4
  %16 = insertelement <4 x i32> %14, i32 %15, i32 2
  %17 = load i32* %4, align 4
  %18 = insertelement <4 x i32> %16, i32 %17, i32 3
  store <4 x i32> %18, <4 x i32>* %6
  %19 = load <4 x i32>* %6
  store <4 x i32> %19, <4 x i32>* %pval, align 16
  store i32 0, i32* %n, align 4
  br label %20

; <label>:20                                      ; preds = %42, %10
  %21 = load i32* %n, align 4
  %22 = load i32* %5, align 4
  %23 = icmp ult i32 %21, %22
  br i1 %23, label %24, label %45

; <label>:24                                      ; preds = %20
  store i32 0, i32* %i, align 4
  %25 = call i32 @__get_global_id_u32(i32 0)
  store i32 %25, i32* %idx, align 4
  br label %26

; <label>:26                                      ; preds = %35, %24
  %27 = load i32* %i, align 4
  %28 = load i32* %3, align 4
  %29 = icmp ult i32 %27, %28
  br i1 %29, label %30, label %41

; <label>:30                                      ; preds = %26
  %31 = load <4 x i32>* %pval, align 16
  %32 = load i32* %idx, align 4
  %33 = load <4 x i32> addrspace(1)** %2, align 4
  %34 = getelementptr inbounds <4 x i32> addrspace(1)* %33, i32 %32
  store <4 x i32> %31, <4 x i32> addrspace(1)* %34, align 16
  br label %35

; <label>:35                                      ; preds = %30
  %36 = load i32* %i, align 4
  %37 = add i32 %36, 1
  store i32 %37, i32* %i, align 4
  %38 = call i32 @__get_global_size_u32(i32 0)
  %39 = load i32* %idx, align 4
  %40 = add i32 %39, %38
  store i32 %40, i32* %idx, align 4
  br label %26

; <label>:41                                      ; preds = %26
  br label %42

; <label>:42                                      ; preds = %41
  %43 = load i32* %n, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, i32* %n, align 4
  br label %20

; <label>:45                                      ; preds = %9, %20
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @read_kernel}
!1 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @write_kernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

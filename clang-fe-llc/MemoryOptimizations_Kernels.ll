; ModuleID = '../kernel-src/MemoryOptimizations_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @copy1DFastPath(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %gid = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %1, align 4
  store float addrspace(1)* %output, float addrspace(1)** %2, align 4
  %3 = call i32 @get_global_id(i32 0)
  store i32 %3, i32* %gid, align 4
  %4 = load i32* %gid, align 4
  %5 = load float addrspace(1)** %1, align 4
  %6 = getelementptr inbounds float addrspace(1)* %5, i32 %4
  %7 = load float addrspace(1)* %6, align 4
  %8 = load i32* %gid, align 4
  %9 = load float addrspace(1)** %2, align 4
  %10 = getelementptr inbounds float addrspace(1)* %9, i32 %8
  store float %7, float addrspace(1)* %10, align 4
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind
define void @copy1DCompletePath(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %gid = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %1, align 4
  store float addrspace(1)* %output, float addrspace(1)** %2, align 4
  %3 = call i32 @get_global_id(i32 0)
  store i32 %3, i32* %gid, align 4
  %4 = load i32* %gid, align 4
  %5 = icmp slt i32 %4, 0
  br i1 %5, label %6, label %10

; <label>:6                                       ; preds = %0
  %7 = load float addrspace(1)** %2, align 4
  %8 = bitcast float addrspace(1)* %7 to i32 addrspace(1)*
  %9 = call i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)* %8, i32 1)
  br label %10

; <label>:10                                      ; preds = %6, %0
  %11 = load i32* %gid, align 4
  %12 = load float addrspace(1)** %1, align 4
  %13 = getelementptr inbounds float addrspace(1)* %12, i32 %11
  %14 = load float addrspace(1)* %13, align 4
  %15 = load i32* %gid, align 4
  %16 = load float addrspace(1)** %2, align 4
  %17 = getelementptr inbounds float addrspace(1)* %16, i32 %15
  store float %14, float addrspace(1)* %17, align 4
  ret void
}

declare i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)*, i32) #1

; Function Attrs: nounwind
define void @copy2Dfloat(float addrspace(1)* %A, float addrspace(1)* %C) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %idx = alloca i32, align 4
  %idy = alloca i32, align 4
  store float addrspace(1)* %A, float addrspace(1)** %1, align 4
  store float addrspace(1)* %C, float addrspace(1)** %2, align 4
  %3 = call i32 @get_global_id(i32 0)
  store i32 %3, i32* %idx, align 4
  %4 = call i32 @get_global_id(i32 1)
  store i32 %4, i32* %idy, align 4
  %5 = load i32* %idy, align 4
  %6 = mul nsw i32 %5, 1024
  %7 = load i32* %idx, align 4
  %8 = add nsw i32 %6, %7
  %9 = load float addrspace(1)** %1, align 4
  %10 = getelementptr inbounds float addrspace(1)* %9, i32 %8
  %11 = load float addrspace(1)* %10, align 4
  %12 = load i32* %idy, align 4
  %13 = mul nsw i32 %12, 1024
  %14 = load i32* %idx, align 4
  %15 = add nsw i32 %13, %14
  %16 = load float addrspace(1)** %2, align 4
  %17 = getelementptr inbounds float addrspace(1)* %16, i32 %15
  store float %11, float addrspace(1)* %17, align 4
  ret void
}

; Function Attrs: nounwind
define void @copy2Dfloat4(<4 x float> addrspace(1)* %A, <4 x float> addrspace(1)* %C) #0 {
  %1 = alloca <4 x float> addrspace(1)*, align 4
  %2 = alloca <4 x float> addrspace(1)*, align 4
  %idx = alloca i32, align 4
  %idy = alloca i32, align 4
  store <4 x float> addrspace(1)* %A, <4 x float> addrspace(1)** %1, align 4
  store <4 x float> addrspace(1)* %C, <4 x float> addrspace(1)** %2, align 4
  %3 = call i32 @get_global_id(i32 0)
  store i32 %3, i32* %idx, align 4
  %4 = call i32 @get_global_id(i32 1)
  store i32 %4, i32* %idy, align 4
  %5 = load i32* %idy, align 4
  %6 = mul nsw i32 %5, 1024
  %7 = load i32* %idx, align 4
  %8 = add nsw i32 %6, %7
  %9 = load <4 x float> addrspace(1)** %1, align 4
  %10 = getelementptr inbounds <4 x float> addrspace(1)* %9, i32 %8
  %11 = load <4 x float> addrspace(1)* %10, align 16
  %12 = load i32* %idy, align 4
  %13 = mul nsw i32 %12, 1024
  %14 = load i32* %idx, align 4
  %15 = add nsw i32 %13, %14
  %16 = load <4 x float> addrspace(1)** %2, align 4
  %17 = getelementptr inbounds <4 x float> addrspace(1)* %16, i32 %15
  store <4 x float> %11, <4 x float> addrspace(1)* %17, align 16
  ret void
}

; Function Attrs: nounwind
define void @copy1Dfloat4(<4 x float> addrspace(1)* %input, <4 x float> addrspace(1)* %output) #0 {
  %1 = alloca <4 x float> addrspace(1)*, align 4
  %2 = alloca <4 x float> addrspace(1)*, align 4
  %gid = alloca i32, align 4
  store <4 x float> addrspace(1)* %input, <4 x float> addrspace(1)** %1, align 4
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %2, align 4
  %3 = call i32 @get_global_id(i32 0)
  store i32 %3, i32* %gid, align 4
  %4 = load i32* %gid, align 4
  %5 = load <4 x float> addrspace(1)** %1, align 4
  %6 = getelementptr inbounds <4 x float> addrspace(1)* %5, i32 %4
  %7 = load <4 x float> addrspace(1)* %6, align 16
  %8 = load i32* %gid, align 4
  %9 = load <4 x float> addrspace(1)** %2, align 4
  %10 = getelementptr inbounds <4 x float> addrspace(1)* %9, i32 %8
  store <4 x float> %7, <4 x float> addrspace(1)* %10, align 16
  ret void
}

; Function Attrs: nounwind
define void @NoCoal(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %gid = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %1, align 4
  store float addrspace(1)* %output, float addrspace(1)** %2, align 4
  %3 = call i32 @get_global_id(i32 0)
  %4 = sub i32 %3, 1
  store i32 %4, i32* %gid, align 4
  %5 = call i32 @get_local_id(i32 0)
  %6 = and i32 %5, 15
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %11

; <label>:8                                       ; preds = %0
  %9 = load i32* %gid, align 4
  %10 = add nsw i32 %9, 16
  store i32 %10, i32* %gid, align 4
  br label %11

; <label>:11                                      ; preds = %8, %0
  %12 = load i32* %gid, align 4
  %13 = load float addrspace(1)** %1, align 4
  %14 = getelementptr inbounds float addrspace(1)* %13, i32 %12
  %15 = load float addrspace(1)* %14, align 4
  %16 = load i32* %gid, align 4
  %17 = load float addrspace(1)** %2, align 4
  %18 = getelementptr inbounds float addrspace(1)* %17, i32 %16
  store float %15, float addrspace(1)* %18, align 4
  ret void
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define void @Split(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %gid = alloca i32, align 4
  store float addrspace(1)* %input, float addrspace(1)** %1, align 4
  store float addrspace(1)* %output, float addrspace(1)** %2, align 4
  %3 = call i32 @get_global_id(i32 0)
  store i32 %3, i32* %gid, align 4
  %4 = load i32* %gid, align 4
  %5 = and i32 %4, 1
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %13

; <label>:7                                       ; preds = %0
  %8 = load i32* %gid, align 4
  %9 = and i32 %8, 0
  %10 = add nsw i32 %9, 62
  %11 = call i32 @get_local_id(i32 0)
  %12 = sub i32 %10, %11
  store i32 %12, i32* %gid, align 4
  br label %13

; <label>:13                                      ; preds = %7, %0
  %14 = load i32* %gid, align 4
  %15 = load float addrspace(1)** %1, align 4
  %16 = getelementptr inbounds float addrspace(1)* %15, i32 %14
  %17 = load float addrspace(1)* %16, align 4
  %18 = load i32* %gid, align 4
  %19 = load float addrspace(1)** %2, align 4
  %20 = getelementptr inbounds float addrspace(1)* %19, i32 %18
  store float %17, float addrspace(1)* %20, align 4
  ret void
}

; Function Attrs: nounwind
define void @localBankConflicts(float addrspace(3)* %share, float addrspace(1)* %output) #0 {
  %1 = alloca float addrspace(3)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %gid = alloca i32, align 4
  %lid = alloca i32, align 4
  %resulta = alloca i32, align 4
  %resultb = alloca i32, align 4
  %i = alloca i32, align 4
  store float addrspace(3)* %share, float addrspace(3)** %1, align 4
  store float addrspace(1)* %output, float addrspace(1)** %2, align 4
  %3 = call i32 @get_global_id(i32 0)
  store i32 %3, i32* %gid, align 4
  %4 = call i32 @get_local_id(i32 0)
  store i32 %4, i32* %lid, align 4
  store i32 0, i32* %resulta, align 4
  store i32 0, i32* %resultb, align 4
  store i32 0, i32* %i, align 4
  br label %5

; <label>:5                                       ; preds = %32, %0
  %6 = load i32* %i, align 4
  %7 = icmp slt i32 %6, 128
  br i1 %7, label %8, label %35

; <label>:8                                       ; preds = %5
  %9 = load i32* %lid, align 4
  %10 = mul nsw i32 %9, 32
  %11 = load i32* %i, align 4
  %12 = add nsw i32 %10, %11
  %13 = load float addrspace(3)** %1, align 4
  %14 = getelementptr inbounds float addrspace(3)* %13, i32 %12
  %15 = load float addrspace(3)* %14, align 4
  %16 = load i32* %resulta, align 4
  %17 = sitofp i32 %16 to float
  %18 = fadd float %17, %15
  %19 = fptosi float %18 to i32
  store i32 %19, i32* %resulta, align 4
  %20 = load i32* %lid, align 4
  %21 = mul nsw i32 %20, 32
  %22 = load i32* %i, align 4
  %23 = add nsw i32 %21, %22
  %24 = add nsw i32 %23, 1
  %25 = load float addrspace(3)** %1, align 4
  %26 = getelementptr inbounds float addrspace(3)* %25, i32 %24
  %27 = load float addrspace(3)* %26, align 4
  %28 = load i32* %resultb, align 4
  %29 = sitofp i32 %28 to float
  %30 = fadd float %29, %27
  %31 = fptosi float %30 to i32
  store i32 %31, i32* %resultb, align 4
  br label %32

; <label>:32                                      ; preds = %8
  %33 = load i32* %i, align 4
  %34 = add nsw i32 %33, 2
  store i32 %34, i32* %i, align 4
  br label %5

; <label>:35                                      ; preds = %5
  %36 = load i32* %resulta, align 4
  %37 = load i32* %resultb, align 4
  %38 = add nsw i32 %36, %37
  %39 = sitofp i32 %38 to float
  %40 = load i32* %gid, align 4
  %41 = load float addrspace(1)** %2, align 4
  %42 = getelementptr inbounds float addrspace(1)* %41, i32 %40
  store float %39, float addrspace(1)* %42, align 4
  ret void
}

; Function Attrs: nounwind
define void @noLocalBankConflicts(float addrspace(3)* %share, float addrspace(1)* %output) #0 {
  %1 = alloca float addrspace(3)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %gid = alloca i32, align 4
  %lid = alloca i32, align 4
  %resulta = alloca i32, align 4
  %resultb = alloca i32, align 4
  %i = alloca i32, align 4
  store float addrspace(3)* %share, float addrspace(3)** %1, align 4
  store float addrspace(1)* %output, float addrspace(1)** %2, align 4
  %3 = call i32 @get_global_id(i32 0)
  store i32 %3, i32* %gid, align 4
  %4 = call i32 @get_local_id(i32 0)
  store i32 %4, i32* %lid, align 4
  store i32 0, i32* %resulta, align 4
  store i32 0, i32* %resultb, align 4
  store i32 0, i32* %i, align 4
  br label %5

; <label>:5                                       ; preds = %30, %0
  %6 = load i32* %i, align 4
  %7 = icmp slt i32 %6, 128
  br i1 %7, label %8, label %33

; <label>:8                                       ; preds = %5
  %9 = load i32* %i, align 4
  %10 = load i32* %lid, align 4
  %11 = add nsw i32 %9, %10
  %12 = load float addrspace(3)** %1, align 4
  %13 = getelementptr inbounds float addrspace(3)* %12, i32 %11
  %14 = load float addrspace(3)* %13, align 4
  %15 = load i32* %resulta, align 4
  %16 = sitofp i32 %15 to float
  %17 = fadd float %16, %14
  %18 = fptosi float %17 to i32
  store i32 %18, i32* %resulta, align 4
  %19 = load i32* %i, align 4
  %20 = add nsw i32 %19, 1
  %21 = load i32* %lid, align 4
  %22 = add nsw i32 %20, %21
  %23 = load float addrspace(3)** %1, align 4
  %24 = getelementptr inbounds float addrspace(3)* %23, i32 %22
  %25 = load float addrspace(3)* %24, align 4
  %26 = load i32* %resultb, align 4
  %27 = sitofp i32 %26 to float
  %28 = fadd float %27, %25
  %29 = fptosi float %28 to i32
  store i32 %29, i32* %resultb, align 4
  br label %30

; <label>:30                                      ; preds = %8
  %31 = load i32* %i, align 4
  %32 = add nsw i32 %31, 2
  store i32 %32, i32* %i, align 4
  br label %5

; <label>:33                                      ; preds = %5
  %34 = load i32* %resulta, align 4
  %35 = load i32* %resultb, align 4
  %36 = add nsw i32 %34, %35
  %37 = sitofp i32 %36 to float
  %38 = load i32* %gid, align 4
  %39 = load float addrspace(1)** %2, align 4
  %40 = getelementptr inbounds float addrspace(1)* %39, i32 %38
  store float %37, float addrspace(1)* %40, align 4
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy1DFastPath}
!1 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy1DCompletePath}
!2 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy2Dfloat}
!3 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @copy2Dfloat4}
!4 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @copy1Dfloat4}
!5 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @NoCoal}
!6 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @Split}
!7 = metadata !{void (float addrspace(3)*, float addrspace(1)*)* @localBankConflicts}
!8 = metadata !{void (float addrspace(3)*, float addrspace(1)*)* @noLocalBankConflicts}
!9 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

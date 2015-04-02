; ModuleID = 'MemoryOptimizations_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @copy1DFastPath(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = getelementptr inbounds float addrspace(1)* %input, i32 %1
  %3 = load float addrspace(1)* %2, align 4
  %4 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  store float %3, float addrspace(1)* %4, align 4
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind
define void @copy1DCompletePath(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %3, label %6

; <label>:3                                       ; preds = %0
  %4 = bitcast float addrspace(1)* %output to i32 addrspace(1)*
  %5 = call i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)* %4, i32 1)
  br label %6

; <label>:6                                       ; preds = %3, %0
  %7 = getelementptr inbounds float addrspace(1)* %input, i32 %1
  %8 = load float addrspace(1)* %7, align 4
  %9 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  store float %8, float addrspace(1)* %9, align 4
  ret void
}

declare i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)*, i32) #1

; Function Attrs: nounwind
define void @copy2Dfloat(float addrspace(1)* %A, float addrspace(1)* %C) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_global_id(i32 1)
  %3 = mul nsw i32 %2, 1024
  %4 = add nsw i32 %3, %1
  %5 = getelementptr inbounds float addrspace(1)* %A, i32 %4
  %6 = load float addrspace(1)* %5, align 4
  %7 = mul nsw i32 %2, 1024
  %8 = add nsw i32 %7, %1
  %9 = getelementptr inbounds float addrspace(1)* %C, i32 %8
  store float %6, float addrspace(1)* %9, align 4
  ret void
}

; Function Attrs: nounwind
define void @copy2Dfloat4(<4 x float> addrspace(1)* %A, <4 x float> addrspace(1)* %C) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_global_id(i32 1)
  %3 = mul nsw i32 %2, 1024
  %4 = add nsw i32 %3, %1
  %5 = getelementptr inbounds <4 x float> addrspace(1)* %A, i32 %4
  %6 = load <4 x float> addrspace(1)* %5, align 16
  %7 = mul nsw i32 %2, 1024
  %8 = add nsw i32 %7, %1
  %9 = getelementptr inbounds <4 x float> addrspace(1)* %C, i32 %8
  store <4 x float> %6, <4 x float> addrspace(1)* %9, align 16
  ret void
}

; Function Attrs: nounwind
define void @copy1Dfloat4(<4 x float> addrspace(1)* %input, <4 x float> addrspace(1)* %output) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %1
  %3 = load <4 x float> addrspace(1)* %2, align 16
  %4 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %1
  store <4 x float> %3, <4 x float> addrspace(1)* %4, align 16
  ret void
}

; Function Attrs: nounwind
define void @NoCoal(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = sub i32 %1, 1
  %3 = call i32 @get_local_id(i32 0)
  %4 = and i32 %3, 15
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %8

; <label>:6                                       ; preds = %0
  %7 = add nsw i32 %2, 16
  br label %8

; <label>:8                                       ; preds = %6, %0
  %gid.0 = phi i32 [ %7, %6 ], [ %2, %0 ]
  %9 = getelementptr inbounds float addrspace(1)* %input, i32 %gid.0
  %10 = load float addrspace(1)* %9, align 4
  %11 = getelementptr inbounds float addrspace(1)* %output, i32 %gid.0
  store float %10, float addrspace(1)* %11, align 4
  ret void
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define void @Split(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = and i32 %1, 1
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %9

; <label>:4                                       ; preds = %0
  %5 = and i32 %1, 0
  %6 = add nsw i32 %5, 62
  %7 = call i32 @get_local_id(i32 0)
  %8 = sub i32 %6, %7
  br label %9

; <label>:9                                       ; preds = %4, %0
  %gid.0 = phi i32 [ %8, %4 ], [ %1, %0 ]
  %10 = getelementptr inbounds float addrspace(1)* %input, i32 %gid.0
  %11 = load float addrspace(1)* %10, align 4
  %12 = getelementptr inbounds float addrspace(1)* %output, i32 %gid.0
  store float %11, float addrspace(1)* %12, align 4
  ret void
}

; Function Attrs: nounwind
define void @localBankConflicts(float addrspace(3)* %share, float addrspace(1)* %output) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_local_id(i32 0)
  br label %3

; <label>:3                                       ; preds = %21, %0
  %resulta.0 = phi i32 [ 0, %0 ], [ %12, %21 ]
  %resultb.0 = phi i32 [ 0, %0 ], [ %20, %21 ]
  %i.0 = phi i32 [ 0, %0 ], [ %22, %21 ]
  %4 = icmp slt i32 %i.0, 128
  br i1 %4, label %5, label %23

; <label>:5                                       ; preds = %3
  %6 = mul nsw i32 %2, 32
  %7 = add nsw i32 %6, %i.0
  %8 = getelementptr inbounds float addrspace(3)* %share, i32 %7
  %9 = load float addrspace(3)* %8, align 4
  %10 = sitofp i32 %resulta.0 to float
  %11 = fadd float %10, %9
  %12 = fptosi float %11 to i32
  %13 = mul nsw i32 %2, 32
  %14 = add nsw i32 %13, %i.0
  %15 = add nsw i32 %14, 1
  %16 = getelementptr inbounds float addrspace(3)* %share, i32 %15
  %17 = load float addrspace(3)* %16, align 4
  %18 = sitofp i32 %resultb.0 to float
  %19 = fadd float %18, %17
  %20 = fptosi float %19 to i32
  br label %21

; <label>:21                                      ; preds = %5
  %22 = add nsw i32 %i.0, 2
  br label %3

; <label>:23                                      ; preds = %3
  %24 = add nsw i32 %resulta.0, %resultb.0
  %25 = sitofp i32 %24 to float
  %26 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  store float %25, float addrspace(1)* %26, align 4
  ret void
}

; Function Attrs: nounwind
define void @noLocalBankConflicts(float addrspace(3)* %share, float addrspace(1)* %output) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_local_id(i32 0)
  br label %3

; <label>:3                                       ; preds = %19, %0
  %resulta.0 = phi i32 [ 0, %0 ], [ %11, %19 ]
  %resultb.0 = phi i32 [ 0, %0 ], [ %18, %19 ]
  %i.0 = phi i32 [ 0, %0 ], [ %20, %19 ]
  %4 = icmp slt i32 %i.0, 128
  br i1 %4, label %5, label %21

; <label>:5                                       ; preds = %3
  %6 = add nsw i32 %i.0, %2
  %7 = getelementptr inbounds float addrspace(3)* %share, i32 %6
  %8 = load float addrspace(3)* %7, align 4
  %9 = sitofp i32 %resulta.0 to float
  %10 = fadd float %9, %8
  %11 = fptosi float %10 to i32
  %12 = add nsw i32 %i.0, 1
  %13 = add nsw i32 %12, %2
  %14 = getelementptr inbounds float addrspace(3)* %share, i32 %13
  %15 = load float addrspace(3)* %14, align 4
  %16 = sitofp i32 %resultb.0 to float
  %17 = fadd float %16, %15
  %18 = fptosi float %17 to i32
  br label %19

; <label>:19                                      ; preds = %5
  %20 = add nsw i32 %i.0, 2
  br label %3

; <label>:21                                      ; preds = %3
  %22 = add nsw i32 %resulta.0, %resultb.0
  %23 = sitofp i32 %22 to float
  %24 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  store float %23, float addrspace(1)* %24, align 4
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

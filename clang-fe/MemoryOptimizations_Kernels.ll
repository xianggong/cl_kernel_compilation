; ModuleID = '../kernel-src/MemoryOptimizations_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @copy1DFastPath(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = getelementptr inbounds float addrspace(1)* %input, i32 %1
  %3 = load float addrspace(1)* %2, align 4, !tbaa !18
  %4 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  store float %3, float addrspace(1)* %4, align 4, !tbaa !18
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind
define void @copy1DCompletePath(float addrspace(1)* nocapture readonly %input, float addrspace(1)* %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %3, label %6

; <label>:3                                       ; preds = %0
  %4 = bitcast float addrspace(1)* %output to i32 addrspace(1)*
  %5 = tail call i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)* %4, i32 1) #2
  br label %6

; <label>:6                                       ; preds = %3, %0
  %7 = getelementptr inbounds float addrspace(1)* %input, i32 %1
  %8 = load float addrspace(1)* %7, align 4, !tbaa !18
  %9 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  store float %8, float addrspace(1)* %9, align 4, !tbaa !18
  ret void
}

declare i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)*, i32) #1

; Function Attrs: nounwind
define void @copy2Dfloat(float addrspace(1)* nocapture readonly %A, float addrspace(1)* nocapture %C) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = shl nsw i32 %2, 10
  %4 = add nsw i32 %3, %1
  %5 = getelementptr inbounds float addrspace(1)* %A, i32 %4
  %6 = load float addrspace(1)* %5, align 4, !tbaa !18
  %7 = getelementptr inbounds float addrspace(1)* %C, i32 %4
  store float %6, float addrspace(1)* %7, align 4, !tbaa !18
  ret void
}

; Function Attrs: nounwind
define void @copy2Dfloat4(<4 x float> addrspace(1)* nocapture readonly %A, <4 x float> addrspace(1)* nocapture %C) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = shl nsw i32 %2, 10
  %4 = add nsw i32 %3, %1
  %5 = getelementptr inbounds <4 x float> addrspace(1)* %A, i32 %4
  %6 = load <4 x float> addrspace(1)* %5, align 16, !tbaa !22
  %7 = getelementptr inbounds <4 x float> addrspace(1)* %C, i32 %4
  store <4 x float> %6, <4 x float> addrspace(1)* %7, align 16, !tbaa !22
  ret void
}

; Function Attrs: nounwind
define void @copy1Dfloat4(<4 x float> addrspace(1)* nocapture readonly %input, <4 x float> addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %1
  %3 = load <4 x float> addrspace(1)* %2, align 16, !tbaa !22
  %4 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %1
  store <4 x float> %3, <4 x float> addrspace(1)* %4, align 16, !tbaa !22
  ret void
}

; Function Attrs: nounwind
define void @NoCoal(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = and i32 %2, 15
  %4 = icmp eq i32 %3, 0
  %..v = select i1 %4, i32 15, i32 -1
  %. = add i32 %..v, %1
  %5 = getelementptr inbounds float addrspace(1)* %input, i32 %.
  %6 = load float addrspace(1)* %5, align 4, !tbaa !18
  %7 = getelementptr inbounds float addrspace(1)* %output, i32 %.
  store float %6, float addrspace(1)* %7, align 4, !tbaa !18
  ret void
}

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define void @Split(float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = and i32 %1, 1
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %7

; <label>:4                                       ; preds = %0
  %5 = tail call i32 @get_local_id(i32 0) #2
  %6 = sub i32 62, %5
  br label %7

; <label>:7                                       ; preds = %4, %0
  %gid.0 = phi i32 [ %6, %4 ], [ %1, %0 ]
  %8 = getelementptr inbounds float addrspace(1)* %input, i32 %gid.0
  %9 = load float addrspace(1)* %8, align 4, !tbaa !18
  %10 = getelementptr inbounds float addrspace(1)* %output, i32 %gid.0
  store float %9, float addrspace(1)* %10, align 4, !tbaa !18
  ret void
}

; Function Attrs: nounwind
define void @localBankConflicts(float addrspace(3)* nocapture readonly %share, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = shl nsw i32 %2, 5
  br label %4

; <label>:4                                       ; preds = %4, %0
  %i.03 = phi i32 [ 0, %0 ], [ %108, %4 ]
  %resultb.02 = phi i32 [ 0, %0 ], [ %107, %4 ]
  %resulta.01 = phi i32 [ 0, %0 ], [ %101, %4 ]
  %5 = add nsw i32 %i.03, %3
  %6 = getelementptr inbounds float addrspace(3)* %share, i32 %5
  %7 = load float addrspace(3)* %6, align 4, !tbaa !18
  %8 = sitofp i32 %resulta.01 to float
  %9 = fadd float %8, %7
  %10 = fptosi float %9 to i32
  %11 = or i32 %5, 1
  %12 = getelementptr inbounds float addrspace(3)* %share, i32 %11
  %13 = load float addrspace(3)* %12, align 4, !tbaa !18
  %14 = sitofp i32 %resultb.02 to float
  %15 = fadd float %14, %13
  %16 = fptosi float %15 to i32
  %17 = add nuw nsw i32 %i.03, 2
  %18 = add nsw i32 %17, %3
  %19 = getelementptr inbounds float addrspace(3)* %share, i32 %18
  %20 = load float addrspace(3)* %19, align 4, !tbaa !18
  %21 = sitofp i32 %10 to float
  %22 = fadd float %21, %20
  %23 = fptosi float %22 to i32
  %24 = or i32 %18, 1
  %25 = getelementptr inbounds float addrspace(3)* %share, i32 %24
  %26 = load float addrspace(3)* %25, align 4, !tbaa !18
  %27 = sitofp i32 %16 to float
  %28 = fadd float %27, %26
  %29 = fptosi float %28 to i32
  %30 = add nuw nsw i32 %17, 2
  %31 = add nsw i32 %30, %3
  %32 = getelementptr inbounds float addrspace(3)* %share, i32 %31
  %33 = load float addrspace(3)* %32, align 4, !tbaa !18
  %34 = sitofp i32 %23 to float
  %35 = fadd float %34, %33
  %36 = fptosi float %35 to i32
  %37 = or i32 %31, 1
  %38 = getelementptr inbounds float addrspace(3)* %share, i32 %37
  %39 = load float addrspace(3)* %38, align 4, !tbaa !18
  %40 = sitofp i32 %29 to float
  %41 = fadd float %40, %39
  %42 = fptosi float %41 to i32
  %43 = add nuw nsw i32 %30, 2
  %44 = add nsw i32 %43, %3
  %45 = getelementptr inbounds float addrspace(3)* %share, i32 %44
  %46 = load float addrspace(3)* %45, align 4, !tbaa !18
  %47 = sitofp i32 %36 to float
  %48 = fadd float %47, %46
  %49 = fptosi float %48 to i32
  %50 = or i32 %44, 1
  %51 = getelementptr inbounds float addrspace(3)* %share, i32 %50
  %52 = load float addrspace(3)* %51, align 4, !tbaa !18
  %53 = sitofp i32 %42 to float
  %54 = fadd float %53, %52
  %55 = fptosi float %54 to i32
  %56 = add nuw nsw i32 %43, 2
  %57 = add nsw i32 %56, %3
  %58 = getelementptr inbounds float addrspace(3)* %share, i32 %57
  %59 = load float addrspace(3)* %58, align 4, !tbaa !18
  %60 = sitofp i32 %49 to float
  %61 = fadd float %60, %59
  %62 = fptosi float %61 to i32
  %63 = or i32 %57, 1
  %64 = getelementptr inbounds float addrspace(3)* %share, i32 %63
  %65 = load float addrspace(3)* %64, align 4, !tbaa !18
  %66 = sitofp i32 %55 to float
  %67 = fadd float %66, %65
  %68 = fptosi float %67 to i32
  %69 = add nuw nsw i32 %56, 2
  %70 = add nsw i32 %69, %3
  %71 = getelementptr inbounds float addrspace(3)* %share, i32 %70
  %72 = load float addrspace(3)* %71, align 4, !tbaa !18
  %73 = sitofp i32 %62 to float
  %74 = fadd float %73, %72
  %75 = fptosi float %74 to i32
  %76 = or i32 %70, 1
  %77 = getelementptr inbounds float addrspace(3)* %share, i32 %76
  %78 = load float addrspace(3)* %77, align 4, !tbaa !18
  %79 = sitofp i32 %68 to float
  %80 = fadd float %79, %78
  %81 = fptosi float %80 to i32
  %82 = add nuw nsw i32 %69, 2
  %83 = add nsw i32 %82, %3
  %84 = getelementptr inbounds float addrspace(3)* %share, i32 %83
  %85 = load float addrspace(3)* %84, align 4, !tbaa !18
  %86 = sitofp i32 %75 to float
  %87 = fadd float %86, %85
  %88 = fptosi float %87 to i32
  %89 = or i32 %83, 1
  %90 = getelementptr inbounds float addrspace(3)* %share, i32 %89
  %91 = load float addrspace(3)* %90, align 4, !tbaa !18
  %92 = sitofp i32 %81 to float
  %93 = fadd float %92, %91
  %94 = fptosi float %93 to i32
  %95 = add nuw nsw i32 %82, 2
  %96 = add nsw i32 %95, %3
  %97 = getelementptr inbounds float addrspace(3)* %share, i32 %96
  %98 = load float addrspace(3)* %97, align 4, !tbaa !18
  %99 = sitofp i32 %88 to float
  %100 = fadd float %99, %98
  %101 = fptosi float %100 to i32
  %102 = or i32 %96, 1
  %103 = getelementptr inbounds float addrspace(3)* %share, i32 %102
  %104 = load float addrspace(3)* %103, align 4, !tbaa !18
  %105 = sitofp i32 %94 to float
  %106 = fadd float %105, %104
  %107 = fptosi float %106 to i32
  %108 = add nuw nsw i32 %95, 2
  %109 = icmp slt i32 %108, 128
  br i1 %109, label %4, label %110

; <label>:110                                     ; preds = %4
  %.lcssa6 = phi i32 [ %107, %4 ]
  %.lcssa = phi i32 [ %101, %4 ]
  %111 = add nsw i32 %.lcssa6, %.lcssa
  %112 = sitofp i32 %111 to float
  %113 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  store float %112, float addrspace(1)* %113, align 4, !tbaa !18
  ret void
}

; Function Attrs: nounwind
define void @noLocalBankConflicts(float addrspace(3)* nocapture readonly %share, float addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  br label %3

; <label>:3                                       ; preds = %3, %0
  %i.03 = phi i32 [ 0, %0 ], [ %115, %3 ]
  %resultb.02 = phi i32 [ 0, %0 ], [ %114, %3 ]
  %resulta.01 = phi i32 [ 0, %0 ], [ %107, %3 ]
  %4 = add nsw i32 %i.03, %2
  %5 = getelementptr inbounds float addrspace(3)* %share, i32 %4
  %6 = load float addrspace(3)* %5, align 4, !tbaa !18
  %7 = sitofp i32 %resulta.01 to float
  %8 = fadd float %7, %6
  %9 = fptosi float %8 to i32
  %10 = or i32 %i.03, 1
  %11 = add nsw i32 %10, %2
  %12 = getelementptr inbounds float addrspace(3)* %share, i32 %11
  %13 = load float addrspace(3)* %12, align 4, !tbaa !18
  %14 = sitofp i32 %resultb.02 to float
  %15 = fadd float %14, %13
  %16 = fptosi float %15 to i32
  %17 = add nuw nsw i32 %i.03, 2
  %18 = add nsw i32 %17, %2
  %19 = getelementptr inbounds float addrspace(3)* %share, i32 %18
  %20 = load float addrspace(3)* %19, align 4, !tbaa !18
  %21 = sitofp i32 %9 to float
  %22 = fadd float %21, %20
  %23 = fptosi float %22 to i32
  %24 = or i32 %17, 1
  %25 = add nsw i32 %24, %2
  %26 = getelementptr inbounds float addrspace(3)* %share, i32 %25
  %27 = load float addrspace(3)* %26, align 4, !tbaa !18
  %28 = sitofp i32 %16 to float
  %29 = fadd float %28, %27
  %30 = fptosi float %29 to i32
  %31 = add nuw nsw i32 %17, 2
  %32 = add nsw i32 %31, %2
  %33 = getelementptr inbounds float addrspace(3)* %share, i32 %32
  %34 = load float addrspace(3)* %33, align 4, !tbaa !18
  %35 = sitofp i32 %23 to float
  %36 = fadd float %35, %34
  %37 = fptosi float %36 to i32
  %38 = or i32 %31, 1
  %39 = add nsw i32 %38, %2
  %40 = getelementptr inbounds float addrspace(3)* %share, i32 %39
  %41 = load float addrspace(3)* %40, align 4, !tbaa !18
  %42 = sitofp i32 %30 to float
  %43 = fadd float %42, %41
  %44 = fptosi float %43 to i32
  %45 = add nuw nsw i32 %31, 2
  %46 = add nsw i32 %45, %2
  %47 = getelementptr inbounds float addrspace(3)* %share, i32 %46
  %48 = load float addrspace(3)* %47, align 4, !tbaa !18
  %49 = sitofp i32 %37 to float
  %50 = fadd float %49, %48
  %51 = fptosi float %50 to i32
  %52 = or i32 %45, 1
  %53 = add nsw i32 %52, %2
  %54 = getelementptr inbounds float addrspace(3)* %share, i32 %53
  %55 = load float addrspace(3)* %54, align 4, !tbaa !18
  %56 = sitofp i32 %44 to float
  %57 = fadd float %56, %55
  %58 = fptosi float %57 to i32
  %59 = add nuw nsw i32 %45, 2
  %60 = add nsw i32 %59, %2
  %61 = getelementptr inbounds float addrspace(3)* %share, i32 %60
  %62 = load float addrspace(3)* %61, align 4, !tbaa !18
  %63 = sitofp i32 %51 to float
  %64 = fadd float %63, %62
  %65 = fptosi float %64 to i32
  %66 = or i32 %59, 1
  %67 = add nsw i32 %66, %2
  %68 = getelementptr inbounds float addrspace(3)* %share, i32 %67
  %69 = load float addrspace(3)* %68, align 4, !tbaa !18
  %70 = sitofp i32 %58 to float
  %71 = fadd float %70, %69
  %72 = fptosi float %71 to i32
  %73 = add nuw nsw i32 %59, 2
  %74 = add nsw i32 %73, %2
  %75 = getelementptr inbounds float addrspace(3)* %share, i32 %74
  %76 = load float addrspace(3)* %75, align 4, !tbaa !18
  %77 = sitofp i32 %65 to float
  %78 = fadd float %77, %76
  %79 = fptosi float %78 to i32
  %80 = or i32 %73, 1
  %81 = add nsw i32 %80, %2
  %82 = getelementptr inbounds float addrspace(3)* %share, i32 %81
  %83 = load float addrspace(3)* %82, align 4, !tbaa !18
  %84 = sitofp i32 %72 to float
  %85 = fadd float %84, %83
  %86 = fptosi float %85 to i32
  %87 = add nuw nsw i32 %73, 2
  %88 = add nsw i32 %87, %2
  %89 = getelementptr inbounds float addrspace(3)* %share, i32 %88
  %90 = load float addrspace(3)* %89, align 4, !tbaa !18
  %91 = sitofp i32 %79 to float
  %92 = fadd float %91, %90
  %93 = fptosi float %92 to i32
  %94 = or i32 %87, 1
  %95 = add nsw i32 %94, %2
  %96 = getelementptr inbounds float addrspace(3)* %share, i32 %95
  %97 = load float addrspace(3)* %96, align 4, !tbaa !18
  %98 = sitofp i32 %86 to float
  %99 = fadd float %98, %97
  %100 = fptosi float %99 to i32
  %101 = add nuw nsw i32 %87, 2
  %102 = add nsw i32 %101, %2
  %103 = getelementptr inbounds float addrspace(3)* %share, i32 %102
  %104 = load float addrspace(3)* %103, align 4, !tbaa !18
  %105 = sitofp i32 %93 to float
  %106 = fadd float %105, %104
  %107 = fptosi float %106 to i32
  %108 = or i32 %101, 1
  %109 = add nsw i32 %108, %2
  %110 = getelementptr inbounds float addrspace(3)* %share, i32 %109
  %111 = load float addrspace(3)* %110, align 4, !tbaa !18
  %112 = sitofp i32 %100 to float
  %113 = fadd float %112, %111
  %114 = fptosi float %113 to i32
  %115 = add nuw nsw i32 %101, 2
  %116 = icmp slt i32 %115, 128
  br i1 %116, label %3, label %117

; <label>:117                                     ; preds = %3
  %.lcssa6 = phi i32 [ %114, %3 ]
  %.lcssa = phi i32 [ %107, %3 ]
  %118 = add nsw i32 %.lcssa6, %.lcssa
  %119 = sitofp i32 %118 to float
  %120 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  store float %119, float addrspace(1)* %120, align 4, !tbaa !18
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6, !7, !8, !11, !12, !13, !14, !16}
!llvm.ident = !{!17}

!0 = !{void (float addrspace(1)*, float addrspace(1)*)* @copy1DFastPath, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{void (float addrspace(1)*, float addrspace(1)*)* @copy1DCompletePath, !1, !2, !3, !4, !5}
!7 = !{void (float addrspace(1)*, float addrspace(1)*)* @copy2Dfloat, !1, !2, !3, !4, !5}
!8 = !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @copy2Dfloat4, !1, !2, !9, !10, !5}
!9 = !{!"kernel_arg_type", !"float4*", !"float4*"}
!10 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*"}
!11 = !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @copy1Dfloat4, !1, !2, !9, !10, !5}
!12 = !{void (float addrspace(1)*, float addrspace(1)*)* @NoCoal, !1, !2, !3, !4, !5}
!13 = !{void (float addrspace(1)*, float addrspace(1)*)* @Split, !1, !2, !3, !4, !5}
!14 = !{void (float addrspace(3)*, float addrspace(1)*)* @localBankConflicts, !15, !2, !3, !4, !5}
!15 = !{!"kernel_arg_addr_space", i32 3, i32 1}
!16 = !{void (float addrspace(3)*, float addrspace(1)*)* @noLocalBankConflicts, !15, !2, !3, !4, !5}
!17 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!18 = !{!19, !19, i64 0}
!19 = !{!"float", !20, i64 0}
!20 = !{!"omnipotent char", !21, i64 0}
!21 = !{!"Simple C/C++ TBAA"}
!22 = !{!20, !20, i64 0}

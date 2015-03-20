; ModuleID = '../kernel-src/QuasiRandomSequence_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @QuasiRandomSequence_Vector(<4 x float> addrspace(1)* nocapture %output, <4 x i32> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(3)* nocapture %shared) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = shl i32 %2, 2
  %5 = insertelement <4 x i32> undef, i32 %4, i32 0
  %6 = or i32 %4, 1
  %7 = insertelement <4 x i32> %5, i32 %6, i32 1
  %8 = or i32 %4, 2
  %9 = insertelement <4 x i32> %7, i32 %8, i32 2
  %10 = or i32 %4, 3
  %11 = insertelement <4 x i32> %9, i32 %10, i32 3
  %12 = icmp slt i32 %2, 8
  br i1 %12, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %13 = shl i32 %3, 3
  br label %14

; <label>:14                                      ; preds = %.lr.ph, %14
  %i.04 = phi i32 [ %2, %.lr.ph ], [ %20, %14 ]
  %15 = add i32 %i.04, %13
  %16 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %15
  %17 = load <4 x i32> addrspace(1)* %16, align 16, !tbaa !10
  %18 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 %i.04
  store <4 x i32> %17, <4 x i32> addrspace(3)* %18, align 16, !tbaa !10
  %19 = tail call i32 @get_local_size(i32 0) #2
  %20 = add i32 %19, %i.04
  %21 = icmp slt i32 %20, 8
  br i1 %21, label %14, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %14
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  tail call void @barrier(i32 1) #2
  %22 = and <4 x i32> %11, <i32 1, i32 1, i32 1, i32 1>
  %23 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 0
  %24 = load i32 addrspace(3)* %23, align 4, !tbaa !13
  %25 = insertelement <4 x i32> undef, i32 %24, i32 0
  %26 = shufflevector <4 x i32> %25, <4 x i32> undef, <4 x i32> zeroinitializer
  %27 = mul nuw <4 x i32> %22, %26
  %28 = lshr <4 x i32> %11, <i32 1, i32 1, i32 1, i32 1>
  %29 = and <4 x i32> %28, <i32 1, i32 1, i32 1, i32 1>
  %30 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 1
  %31 = load i32 addrspace(3)* %30, align 4, !tbaa !13
  %32 = insertelement <4 x i32> undef, i32 %31, i32 0
  %33 = shufflevector <4 x i32> %32, <4 x i32> undef, <4 x i32> zeroinitializer
  %34 = mul nuw <4 x i32> %29, %33
  %35 = xor <4 x i32> %27, %34
  %36 = lshr <4 x i32> %28, <i32 1, i32 1, i32 1, i32 1>
  %37 = and <4 x i32> %36, <i32 1, i32 1, i32 1, i32 1>
  %38 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 2
  %39 = load i32 addrspace(3)* %38, align 4, !tbaa !13
  %40 = insertelement <4 x i32> undef, i32 %39, i32 0
  %41 = shufflevector <4 x i32> %40, <4 x i32> undef, <4 x i32> zeroinitializer
  %42 = mul nuw <4 x i32> %37, %41
  %43 = xor <4 x i32> %35, %42
  %44 = lshr <4 x i32> %36, <i32 1, i32 1, i32 1, i32 1>
  %45 = and <4 x i32> %44, <i32 1, i32 1, i32 1, i32 1>
  %46 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 3
  %47 = load i32 addrspace(3)* %46, align 4, !tbaa !13
  %48 = insertelement <4 x i32> undef, i32 %47, i32 0
  %49 = shufflevector <4 x i32> %48, <4 x i32> undef, <4 x i32> zeroinitializer
  %50 = mul nuw <4 x i32> %45, %49
  %51 = xor <4 x i32> %43, %50
  %52 = lshr <4 x i32> %44, <i32 1, i32 1, i32 1, i32 1>
  %53 = and <4 x i32> %52, <i32 1, i32 1, i32 1, i32 1>
  %54 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 4
  %55 = load i32 addrspace(3)* %54, align 4, !tbaa !13
  %56 = insertelement <4 x i32> undef, i32 %55, i32 0
  %57 = shufflevector <4 x i32> %56, <4 x i32> undef, <4 x i32> zeroinitializer
  %58 = mul nuw <4 x i32> %53, %57
  %59 = xor <4 x i32> %51, %58
  %60 = lshr <4 x i32> %52, <i32 1, i32 1, i32 1, i32 1>
  %61 = and <4 x i32> %60, <i32 1, i32 1, i32 1, i32 1>
  %62 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 5
  %63 = load i32 addrspace(3)* %62, align 4, !tbaa !13
  %64 = insertelement <4 x i32> undef, i32 %63, i32 0
  %65 = shufflevector <4 x i32> %64, <4 x i32> undef, <4 x i32> zeroinitializer
  %66 = mul nuw <4 x i32> %61, %65
  %67 = xor <4 x i32> %59, %66
  %68 = lshr <4 x i32> %60, <i32 1, i32 1, i32 1, i32 1>
  %69 = and <4 x i32> %68, <i32 1, i32 1, i32 1, i32 1>
  %70 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 6
  %71 = load i32 addrspace(3)* %70, align 4, !tbaa !13
  %72 = insertelement <4 x i32> undef, i32 %71, i32 0
  %73 = shufflevector <4 x i32> %72, <4 x i32> undef, <4 x i32> zeroinitializer
  %74 = mul nuw <4 x i32> %69, %73
  %75 = xor <4 x i32> %67, %74
  %76 = lshr <4 x i32> %68, <i32 1, i32 1, i32 1, i32 1>
  %77 = and <4 x i32> %76, <i32 1, i32 1, i32 1, i32 1>
  %78 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 7
  %79 = load i32 addrspace(3)* %78, align 4, !tbaa !13
  %80 = insertelement <4 x i32> undef, i32 %79, i32 0
  %81 = shufflevector <4 x i32> %80, <4 x i32> undef, <4 x i32> zeroinitializer
  %82 = mul nuw <4 x i32> %77, %81
  %83 = xor <4 x i32> %75, %82
  %84 = lshr <4 x i32> %76, <i32 1, i32 1, i32 1, i32 1>
  %85 = and <4 x i32> %84, <i32 1, i32 1, i32 1, i32 1>
  %86 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 8
  %87 = load i32 addrspace(3)* %86, align 4, !tbaa !13
  %88 = insertelement <4 x i32> undef, i32 %87, i32 0
  %89 = shufflevector <4 x i32> %88, <4 x i32> undef, <4 x i32> zeroinitializer
  %90 = mul nuw <4 x i32> %85, %89
  %91 = xor <4 x i32> %83, %90
  %92 = lshr <4 x i32> %84, <i32 1, i32 1, i32 1, i32 1>
  %93 = and <4 x i32> %92, <i32 1, i32 1, i32 1, i32 1>
  %94 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 9
  %95 = load i32 addrspace(3)* %94, align 4, !tbaa !13
  %96 = insertelement <4 x i32> undef, i32 %95, i32 0
  %97 = shufflevector <4 x i32> %96, <4 x i32> undef, <4 x i32> zeroinitializer
  %98 = mul nuw <4 x i32> %93, %97
  %99 = xor <4 x i32> %91, %98
  %100 = lshr <4 x i32> %92, <i32 1, i32 1, i32 1, i32 1>
  %101 = and <4 x i32> %100, <i32 1, i32 1, i32 1, i32 1>
  %102 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 10
  %103 = load i32 addrspace(3)* %102, align 4, !tbaa !13
  %104 = insertelement <4 x i32> undef, i32 %103, i32 0
  %105 = shufflevector <4 x i32> %104, <4 x i32> undef, <4 x i32> zeroinitializer
  %106 = mul nuw <4 x i32> %101, %105
  %107 = xor <4 x i32> %99, %106
  %108 = lshr <4 x i32> %100, <i32 1, i32 1, i32 1, i32 1>
  %109 = and <4 x i32> %108, <i32 1, i32 1, i32 1, i32 1>
  %110 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 11
  %111 = load i32 addrspace(3)* %110, align 4, !tbaa !13
  %112 = insertelement <4 x i32> undef, i32 %111, i32 0
  %113 = shufflevector <4 x i32> %112, <4 x i32> undef, <4 x i32> zeroinitializer
  %114 = mul nuw <4 x i32> %109, %113
  %115 = xor <4 x i32> %107, %114
  %116 = tail call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %115) #2
  %117 = fdiv <4 x float> %116, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !15
  %118 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %1
  store <4 x float> %117, <4 x float> addrspace(1)* %118, align 16, !tbaa !10
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind
define void @QuasiRandomSequence_Scalar(float addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(3)* nocapture %shared) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = icmp slt i32 %2, 32
  br i1 %4, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %5 = shl i32 %3, 5
  br label %6

; <label>:6                                       ; preds = %.lr.ph, %6
  %i.04 = phi i32 [ %2, %.lr.ph ], [ %12, %6 ]
  %7 = add i32 %i.04, %5
  %8 = getelementptr inbounds i32 addrspace(1)* %input, i32 %7
  %9 = load i32 addrspace(1)* %8, align 4, !tbaa !13
  %10 = getelementptr inbounds i32 addrspace(3)* %shared, i32 %i.04
  store i32 %9, i32 addrspace(3)* %10, align 4, !tbaa !13
  %11 = tail call i32 @get_local_size(i32 0) #2
  %12 = add i32 %11, %i.04
  %13 = icmp slt i32 %12, 32
  br i1 %13, label %6, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %6
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  tail call void @barrier(i32 1) #2
  %14 = and i32 %2, 1
  %15 = load i32 addrspace(3)* %shared, align 4, !tbaa !13
  %16 = sub nsw i32 0, %14
  %17 = and i32 %15, %16
  %18 = lshr i32 %2, 1
  %19 = and i32 %18, 1
  %20 = getelementptr inbounds i32 addrspace(3)* %shared, i32 1
  %21 = load i32 addrspace(3)* %20, align 4, !tbaa !13
  %22 = sub nsw i32 0, %19
  %23 = and i32 %21, %22
  %24 = xor i32 %23, %17
  %25 = lshr i32 %2, 2
  %26 = and i32 %25, 1
  %27 = getelementptr inbounds i32 addrspace(3)* %shared, i32 2
  %28 = load i32 addrspace(3)* %27, align 4, !tbaa !13
  %29 = sub nsw i32 0, %26
  %30 = and i32 %28, %29
  %31 = xor i32 %30, %24
  %32 = lshr i32 %2, 3
  %33 = and i32 %32, 1
  %34 = getelementptr inbounds i32 addrspace(3)* %shared, i32 3
  %35 = load i32 addrspace(3)* %34, align 4, !tbaa !13
  %36 = sub nsw i32 0, %33
  %37 = and i32 %35, %36
  %38 = xor i32 %37, %31
  %39 = lshr i32 %2, 4
  %40 = and i32 %39, 1
  %41 = getelementptr inbounds i32 addrspace(3)* %shared, i32 4
  %42 = load i32 addrspace(3)* %41, align 4, !tbaa !13
  %43 = sub nsw i32 0, %40
  %44 = and i32 %42, %43
  %45 = xor i32 %44, %38
  %46 = lshr i32 %2, 5
  %47 = and i32 %46, 1
  %48 = getelementptr inbounds i32 addrspace(3)* %shared, i32 5
  %49 = load i32 addrspace(3)* %48, align 4, !tbaa !13
  %50 = sub nsw i32 0, %47
  %51 = and i32 %49, %50
  %52 = xor i32 %51, %45
  %53 = lshr i32 %2, 6
  %54 = and i32 %53, 1
  %55 = getelementptr inbounds i32 addrspace(3)* %shared, i32 6
  %56 = load i32 addrspace(3)* %55, align 4, !tbaa !13
  %57 = sub nsw i32 0, %54
  %58 = and i32 %56, %57
  %59 = xor i32 %58, %52
  %60 = lshr i32 %2, 7
  %61 = and i32 %60, 1
  %62 = getelementptr inbounds i32 addrspace(3)* %shared, i32 7
  %63 = load i32 addrspace(3)* %62, align 4, !tbaa !13
  %64 = sub nsw i32 0, %61
  %65 = and i32 %63, %64
  %66 = xor i32 %65, %59
  %67 = lshr i32 %2, 8
  %68 = and i32 %67, 1
  %69 = getelementptr inbounds i32 addrspace(3)* %shared, i32 8
  %70 = load i32 addrspace(3)* %69, align 4, !tbaa !13
  %71 = sub nsw i32 0, %68
  %72 = and i32 %70, %71
  %73 = xor i32 %72, %66
  %74 = lshr i32 %2, 9
  %75 = and i32 %74, 1
  %76 = getelementptr inbounds i32 addrspace(3)* %shared, i32 9
  %77 = load i32 addrspace(3)* %76, align 4, !tbaa !13
  %78 = sub nsw i32 0, %75
  %79 = and i32 %77, %78
  %80 = xor i32 %79, %73
  %81 = tail call float @_Z13convert_floatj(i32 %80) #2
  %82 = fmul float %81, 0x3DF0000000000000
  %83 = getelementptr inbounds float addrspace(1)* %output, i32 %1
  store float %82, float addrspace(1)* %83, align 4, !tbaa !16
  ret void
}

declare float @_Z13convert_floatj(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!9}

!0 = !{void (<4 x float> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @QuasiRandomSequence_Vector, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 3}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float4*", !"uint4*", !"uint4*"}
!4 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"uint __attribute__((ext_vector_type(4)))*", !"uint __attribute__((ext_vector_type(4)))*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (float addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*)* @QuasiRandomSequence_Scalar, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"float*", !"uint*", !"uint*"}
!8 = !{!"kernel_arg_base_type", !"float*", !"uint*", !"uint*"}
!9 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!10 = !{!11, !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{!14, !14, i64 0}
!14 = !{!"int", !11, i64 0}
!15 = !{float 2.500000e+00}
!16 = !{!17, !17, i64 0}
!17 = !{!"float", !11, i64 0}

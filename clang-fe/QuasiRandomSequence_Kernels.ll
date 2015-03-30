; ModuleID = '../kernel-src/QuasiRandomSequence_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

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
  %i.04 = phi i32 [ %2, %.lr.ph ], [ %21, %14 ]
  %15 = add i32 %i.04, %13
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %16
  %18 = load <4 x i32> addrspace(1)* %17, align 16, !tbaa !3
  %19 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 %i.04
  store <4 x i32> %18, <4 x i32> addrspace(3)* %19, align 16, !tbaa !3
  %20 = tail call i32 @get_local_size(i32 0) #2
  %21 = add i32 %20, %i.04
  %22 = icmp slt i32 %21, 8
  br i1 %22, label %14, label %._crit_edge

._crit_edge:                                      ; preds = %14, %0
  tail call void @barrier(i32 1) #2
  %23 = and <4 x i32> %11, <i32 1, i32 1, i32 1, i32 1>
  %24 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 0
  %25 = load i32 addrspace(3)* %24, align 4, !tbaa !6
  %26 = insertelement <4 x i32> undef, i32 %25, i32 0
  %27 = shufflevector <4 x i32> %26, <4 x i32> undef, <4 x i32> zeroinitializer
  %28 = mul <4 x i32> %23, %27
  %29 = lshr <4 x i32> %11, <i32 1, i32 1, i32 1, i32 1>
  %30 = and <4 x i32> %29, <i32 1, i32 1, i32 1, i32 1>
  %31 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 1
  %32 = load i32 addrspace(3)* %31, align 4, !tbaa !6
  %33 = insertelement <4 x i32> undef, i32 %32, i32 0
  %34 = shufflevector <4 x i32> %33, <4 x i32> undef, <4 x i32> zeroinitializer
  %35 = mul <4 x i32> %30, %34
  %36 = xor <4 x i32> %28, %35
  %37 = lshr <4 x i32> %29, <i32 1, i32 1, i32 1, i32 1>
  %38 = and <4 x i32> %37, <i32 1, i32 1, i32 1, i32 1>
  %39 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 2
  %40 = load i32 addrspace(3)* %39, align 4, !tbaa !6
  %41 = insertelement <4 x i32> undef, i32 %40, i32 0
  %42 = shufflevector <4 x i32> %41, <4 x i32> undef, <4 x i32> zeroinitializer
  %43 = mul <4 x i32> %38, %42
  %44 = xor <4 x i32> %36, %43
  %45 = lshr <4 x i32> %37, <i32 1, i32 1, i32 1, i32 1>
  %46 = and <4 x i32> %45, <i32 1, i32 1, i32 1, i32 1>
  %47 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 3
  %48 = load i32 addrspace(3)* %47, align 4, !tbaa !6
  %49 = insertelement <4 x i32> undef, i32 %48, i32 0
  %50 = shufflevector <4 x i32> %49, <4 x i32> undef, <4 x i32> zeroinitializer
  %51 = mul <4 x i32> %46, %50
  %52 = xor <4 x i32> %44, %51
  %53 = lshr <4 x i32> %45, <i32 1, i32 1, i32 1, i32 1>
  %54 = and <4 x i32> %53, <i32 1, i32 1, i32 1, i32 1>
  %55 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 4
  %56 = load i32 addrspace(3)* %55, align 4, !tbaa !6
  %57 = insertelement <4 x i32> undef, i32 %56, i32 0
  %58 = shufflevector <4 x i32> %57, <4 x i32> undef, <4 x i32> zeroinitializer
  %59 = mul <4 x i32> %54, %58
  %60 = xor <4 x i32> %52, %59
  %61 = lshr <4 x i32> %53, <i32 1, i32 1, i32 1, i32 1>
  %62 = and <4 x i32> %61, <i32 1, i32 1, i32 1, i32 1>
  %63 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 5
  %64 = load i32 addrspace(3)* %63, align 4, !tbaa !6
  %65 = insertelement <4 x i32> undef, i32 %64, i32 0
  %66 = shufflevector <4 x i32> %65, <4 x i32> undef, <4 x i32> zeroinitializer
  %67 = mul <4 x i32> %62, %66
  %68 = xor <4 x i32> %60, %67
  %69 = lshr <4 x i32> %61, <i32 1, i32 1, i32 1, i32 1>
  %70 = and <4 x i32> %69, <i32 1, i32 1, i32 1, i32 1>
  %71 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 6
  %72 = load i32 addrspace(3)* %71, align 4, !tbaa !6
  %73 = insertelement <4 x i32> undef, i32 %72, i32 0
  %74 = shufflevector <4 x i32> %73, <4 x i32> undef, <4 x i32> zeroinitializer
  %75 = mul <4 x i32> %70, %74
  %76 = xor <4 x i32> %68, %75
  %77 = lshr <4 x i32> %69, <i32 1, i32 1, i32 1, i32 1>
  %78 = and <4 x i32> %77, <i32 1, i32 1, i32 1, i32 1>
  %79 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 7
  %80 = load i32 addrspace(3)* %79, align 4, !tbaa !6
  %81 = insertelement <4 x i32> undef, i32 %80, i32 0
  %82 = shufflevector <4 x i32> %81, <4 x i32> undef, <4 x i32> zeroinitializer
  %83 = mul <4 x i32> %78, %82
  %84 = xor <4 x i32> %76, %83
  %85 = lshr <4 x i32> %77, <i32 1, i32 1, i32 1, i32 1>
  %86 = and <4 x i32> %85, <i32 1, i32 1, i32 1, i32 1>
  %87 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 8
  %88 = load i32 addrspace(3)* %87, align 4, !tbaa !6
  %89 = insertelement <4 x i32> undef, i32 %88, i32 0
  %90 = shufflevector <4 x i32> %89, <4 x i32> undef, <4 x i32> zeroinitializer
  %91 = mul <4 x i32> %86, %90
  %92 = xor <4 x i32> %84, %91
  %93 = lshr <4 x i32> %85, <i32 1, i32 1, i32 1, i32 1>
  %94 = and <4 x i32> %93, <i32 1, i32 1, i32 1, i32 1>
  %95 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 9
  %96 = load i32 addrspace(3)* %95, align 4, !tbaa !6
  %97 = insertelement <4 x i32> undef, i32 %96, i32 0
  %98 = shufflevector <4 x i32> %97, <4 x i32> undef, <4 x i32> zeroinitializer
  %99 = mul <4 x i32> %94, %98
  %100 = xor <4 x i32> %92, %99
  %101 = lshr <4 x i32> %93, <i32 1, i32 1, i32 1, i32 1>
  %102 = and <4 x i32> %101, <i32 1, i32 1, i32 1, i32 1>
  %103 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 10
  %104 = load i32 addrspace(3)* %103, align 4, !tbaa !6
  %105 = insertelement <4 x i32> undef, i32 %104, i32 0
  %106 = shufflevector <4 x i32> %105, <4 x i32> undef, <4 x i32> zeroinitializer
  %107 = mul <4 x i32> %102, %106
  %108 = xor <4 x i32> %100, %107
  %109 = lshr <4 x i32> %101, <i32 1, i32 1, i32 1, i32 1>
  %110 = and <4 x i32> %109, <i32 1, i32 1, i32 1, i32 1>
  %111 = getelementptr inbounds <4 x i32> addrspace(3)* %shared, i32 0, i32 11
  %112 = load i32 addrspace(3)* %111, align 4, !tbaa !6
  %113 = insertelement <4 x i32> undef, i32 %112, i32 0
  %114 = shufflevector <4 x i32> %113, <4 x i32> undef, <4 x i32> zeroinitializer
  %115 = mul <4 x i32> %110, %114
  %116 = xor <4 x i32> %108, %115
  %117 = tail call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %116) #2
  %118 = fdiv <4 x float> %117, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !8
  %119 = sext i32 %1 to i64
  %120 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %119
  store <4 x float> %118, <4 x float> addrspace(1)* %120, align 16, !tbaa !3
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
  %i.04 = phi i32 [ %2, %.lr.ph ], [ %13, %6 ]
  %7 = add i32 %i.04, %5
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds i32 addrspace(1)* %input, i64 %8
  %10 = load i32 addrspace(1)* %9, align 4, !tbaa !6
  %11 = getelementptr inbounds i32 addrspace(3)* %shared, i32 %i.04
  store i32 %10, i32 addrspace(3)* %11, align 4, !tbaa !6
  %12 = tail call i32 @get_local_size(i32 0) #2
  %13 = add i32 %12, %i.04
  %14 = icmp slt i32 %13, 32
  br i1 %14, label %6, label %._crit_edge

._crit_edge:                                      ; preds = %6, %0
  tail call void @barrier(i32 1) #2
  %15 = and i32 %2, 1
  %16 = load i32 addrspace(3)* %shared, align 4, !tbaa !6
  %17 = sub i32 0, %15
  %18 = and i32 %16, %17
  %19 = lshr i32 %2, 1
  %20 = and i32 %19, 1
  %21 = getelementptr inbounds i32 addrspace(3)* %shared, i32 1
  %22 = load i32 addrspace(3)* %21, align 4, !tbaa !6
  %23 = sub i32 0, %20
  %24 = and i32 %22, %23
  %25 = xor i32 %24, %18
  %26 = lshr i32 %2, 2
  %27 = and i32 %26, 1
  %28 = getelementptr inbounds i32 addrspace(3)* %shared, i32 2
  %29 = load i32 addrspace(3)* %28, align 4, !tbaa !6
  %30 = sub i32 0, %27
  %31 = and i32 %29, %30
  %32 = xor i32 %31, %25
  %33 = lshr i32 %2, 3
  %34 = and i32 %33, 1
  %35 = getelementptr inbounds i32 addrspace(3)* %shared, i32 3
  %36 = load i32 addrspace(3)* %35, align 4, !tbaa !6
  %37 = sub i32 0, %34
  %38 = and i32 %36, %37
  %39 = xor i32 %38, %32
  %40 = lshr i32 %2, 4
  %41 = and i32 %40, 1
  %42 = getelementptr inbounds i32 addrspace(3)* %shared, i32 4
  %43 = load i32 addrspace(3)* %42, align 4, !tbaa !6
  %44 = sub i32 0, %41
  %45 = and i32 %43, %44
  %46 = xor i32 %45, %39
  %47 = lshr i32 %2, 5
  %48 = and i32 %47, 1
  %49 = getelementptr inbounds i32 addrspace(3)* %shared, i32 5
  %50 = load i32 addrspace(3)* %49, align 4, !tbaa !6
  %51 = sub i32 0, %48
  %52 = and i32 %50, %51
  %53 = xor i32 %52, %46
  %54 = lshr i32 %2, 6
  %55 = and i32 %54, 1
  %56 = getelementptr inbounds i32 addrspace(3)* %shared, i32 6
  %57 = load i32 addrspace(3)* %56, align 4, !tbaa !6
  %58 = sub i32 0, %55
  %59 = and i32 %57, %58
  %60 = xor i32 %59, %53
  %61 = lshr i32 %2, 7
  %62 = and i32 %61, 1
  %63 = getelementptr inbounds i32 addrspace(3)* %shared, i32 7
  %64 = load i32 addrspace(3)* %63, align 4, !tbaa !6
  %65 = sub i32 0, %62
  %66 = and i32 %64, %65
  %67 = xor i32 %66, %60
  %68 = lshr i32 %2, 8
  %69 = and i32 %68, 1
  %70 = getelementptr inbounds i32 addrspace(3)* %shared, i32 8
  %71 = load i32 addrspace(3)* %70, align 4, !tbaa !6
  %72 = sub i32 0, %69
  %73 = and i32 %71, %72
  %74 = xor i32 %73, %67
  %75 = lshr i32 %2, 9
  %76 = and i32 %75, 1
  %77 = getelementptr inbounds i32 addrspace(3)* %shared, i32 9
  %78 = load i32 addrspace(3)* %77, align 4, !tbaa !6
  %79 = sub i32 0, %76
  %80 = and i32 %78, %79
  %81 = xor i32 %80, %74
  %82 = tail call float @_Z13convert_floatj(i32 %81) #2
  %83 = fmul float %82, 0x3DF0000000000000
  %84 = sext i32 %1 to i64
  %85 = getelementptr inbounds float addrspace(1)* %output, i64 %84
  store float %83, float addrspace(1)* %85, align 4, !tbaa !9
  ret void
}

declare float @_Z13convert_floatj(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @QuasiRandomSequence_Vector}
!1 = metadata !{void (float addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*)* @QuasiRandomSequence_Scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}
!8 = metadata !{float 2.500000e+00}
!9 = metadata !{metadata !10, metadata !10, i64 0}
!10 = metadata !{metadata !"float", metadata !4, i64 0}

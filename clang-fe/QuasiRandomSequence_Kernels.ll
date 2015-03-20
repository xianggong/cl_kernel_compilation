; ModuleID = '../kernel-src/QuasiRandomSequence_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @QuasiRandomSequence_Vector(<4 x float>* nocapture %output, <4 x i32>* nocapture readonly %input, <4 x i32>* nocapture %shared) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_local_id(i32 0) #2
  %3 = trunc i64 %2 to i32
  %4 = tail call i64 @get_group_id(i32 0) #2
  %5 = shl i32 %3, 2
  %6 = insertelement <4 x i32> undef, i32 %5, i32 0
  %7 = or i32 %5, 1
  %8 = insertelement <4 x i32> %6, i32 %7, i32 1
  %9 = or i32 %5, 2
  %10 = insertelement <4 x i32> %8, i32 %9, i32 2
  %11 = or i32 %5, 3
  %12 = insertelement <4 x i32> %10, i32 %11, i32 3
  %13 = icmp slt i32 %3, 8
  br i1 %13, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %14 = trunc i64 %4 to i32
  %15 = shl i32 %14, 3
  br label %16

; <label>:16                                      ; preds = %.lr.ph, %16
  %i.04 = phi i32 [ %3, %.lr.ph ], [ %25, %16 ]
  %17 = add i32 %i.04, %15
  %18 = zext i32 %17 to i64
  %19 = getelementptr inbounds <4 x i32>* %input, i64 %18
  %20 = load <4 x i32>* %19, align 16, !tbaa !3
  %21 = sext i32 %i.04 to i64
  %22 = getelementptr inbounds <4 x i32>* %shared, i64 %21
  store <4 x i32> %20, <4 x i32>* %22, align 16, !tbaa !3
  %23 = tail call i64 @get_local_size(i32 0) #2
  %24 = add i64 %23, %21
  %25 = trunc i64 %24 to i32
  %26 = icmp slt i32 %25, 8
  br i1 %26, label %16, label %._crit_edge

._crit_edge:                                      ; preds = %16, %0
  tail call void @barrier(i32 1) #2
  %27 = and <4 x i32> %12, <i32 1, i32 1, i32 1, i32 1>
  %28 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 0
  %29 = load i32* %28, align 4, !tbaa !6
  %30 = insertelement <4 x i32> undef, i32 %29, i32 0
  %31 = shufflevector <4 x i32> %30, <4 x i32> undef, <4 x i32> zeroinitializer
  %32 = mul <4 x i32> %27, %31
  %33 = lshr <4 x i32> %12, <i32 1, i32 1, i32 1, i32 1>
  %34 = and <4 x i32> %33, <i32 1, i32 1, i32 1, i32 1>
  %35 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 1
  %36 = load i32* %35, align 4, !tbaa !6
  %37 = insertelement <4 x i32> undef, i32 %36, i32 0
  %38 = shufflevector <4 x i32> %37, <4 x i32> undef, <4 x i32> zeroinitializer
  %39 = mul <4 x i32> %34, %38
  %40 = xor <4 x i32> %32, %39
  %41 = lshr <4 x i32> %33, <i32 1, i32 1, i32 1, i32 1>
  %42 = and <4 x i32> %41, <i32 1, i32 1, i32 1, i32 1>
  %43 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 2
  %44 = load i32* %43, align 4, !tbaa !6
  %45 = insertelement <4 x i32> undef, i32 %44, i32 0
  %46 = shufflevector <4 x i32> %45, <4 x i32> undef, <4 x i32> zeroinitializer
  %47 = mul <4 x i32> %42, %46
  %48 = xor <4 x i32> %40, %47
  %49 = lshr <4 x i32> %41, <i32 1, i32 1, i32 1, i32 1>
  %50 = and <4 x i32> %49, <i32 1, i32 1, i32 1, i32 1>
  %51 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 3
  %52 = load i32* %51, align 4, !tbaa !6
  %53 = insertelement <4 x i32> undef, i32 %52, i32 0
  %54 = shufflevector <4 x i32> %53, <4 x i32> undef, <4 x i32> zeroinitializer
  %55 = mul <4 x i32> %50, %54
  %56 = xor <4 x i32> %48, %55
  %57 = lshr <4 x i32> %49, <i32 1, i32 1, i32 1, i32 1>
  %58 = and <4 x i32> %57, <i32 1, i32 1, i32 1, i32 1>
  %59 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 4
  %60 = load i32* %59, align 4, !tbaa !6
  %61 = insertelement <4 x i32> undef, i32 %60, i32 0
  %62 = shufflevector <4 x i32> %61, <4 x i32> undef, <4 x i32> zeroinitializer
  %63 = mul <4 x i32> %58, %62
  %64 = xor <4 x i32> %56, %63
  %65 = lshr <4 x i32> %57, <i32 1, i32 1, i32 1, i32 1>
  %66 = and <4 x i32> %65, <i32 1, i32 1, i32 1, i32 1>
  %67 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 5
  %68 = load i32* %67, align 4, !tbaa !6
  %69 = insertelement <4 x i32> undef, i32 %68, i32 0
  %70 = shufflevector <4 x i32> %69, <4 x i32> undef, <4 x i32> zeroinitializer
  %71 = mul <4 x i32> %66, %70
  %72 = xor <4 x i32> %64, %71
  %73 = lshr <4 x i32> %65, <i32 1, i32 1, i32 1, i32 1>
  %74 = and <4 x i32> %73, <i32 1, i32 1, i32 1, i32 1>
  %75 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 6
  %76 = load i32* %75, align 4, !tbaa !6
  %77 = insertelement <4 x i32> undef, i32 %76, i32 0
  %78 = shufflevector <4 x i32> %77, <4 x i32> undef, <4 x i32> zeroinitializer
  %79 = mul <4 x i32> %74, %78
  %80 = xor <4 x i32> %72, %79
  %81 = lshr <4 x i32> %73, <i32 1, i32 1, i32 1, i32 1>
  %82 = and <4 x i32> %81, <i32 1, i32 1, i32 1, i32 1>
  %83 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 7
  %84 = load i32* %83, align 4, !tbaa !6
  %85 = insertelement <4 x i32> undef, i32 %84, i32 0
  %86 = shufflevector <4 x i32> %85, <4 x i32> undef, <4 x i32> zeroinitializer
  %87 = mul <4 x i32> %82, %86
  %88 = xor <4 x i32> %80, %87
  %89 = lshr <4 x i32> %81, <i32 1, i32 1, i32 1, i32 1>
  %90 = and <4 x i32> %89, <i32 1, i32 1, i32 1, i32 1>
  %91 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 8
  %92 = load i32* %91, align 4, !tbaa !6
  %93 = insertelement <4 x i32> undef, i32 %92, i32 0
  %94 = shufflevector <4 x i32> %93, <4 x i32> undef, <4 x i32> zeroinitializer
  %95 = mul <4 x i32> %90, %94
  %96 = xor <4 x i32> %88, %95
  %97 = lshr <4 x i32> %89, <i32 1, i32 1, i32 1, i32 1>
  %98 = and <4 x i32> %97, <i32 1, i32 1, i32 1, i32 1>
  %99 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 9
  %100 = load i32* %99, align 4, !tbaa !6
  %101 = insertelement <4 x i32> undef, i32 %100, i32 0
  %102 = shufflevector <4 x i32> %101, <4 x i32> undef, <4 x i32> zeroinitializer
  %103 = mul <4 x i32> %98, %102
  %104 = xor <4 x i32> %96, %103
  %105 = lshr <4 x i32> %97, <i32 1, i32 1, i32 1, i32 1>
  %106 = and <4 x i32> %105, <i32 1, i32 1, i32 1, i32 1>
  %107 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 10
  %108 = load i32* %107, align 4, !tbaa !6
  %109 = insertelement <4 x i32> undef, i32 %108, i32 0
  %110 = shufflevector <4 x i32> %109, <4 x i32> undef, <4 x i32> zeroinitializer
  %111 = mul <4 x i32> %106, %110
  %112 = xor <4 x i32> %104, %111
  %113 = lshr <4 x i32> %105, <i32 1, i32 1, i32 1, i32 1>
  %114 = and <4 x i32> %113, <i32 1, i32 1, i32 1, i32 1>
  %115 = getelementptr inbounds <4 x i32>* %shared, i64 0, i64 11
  %116 = load i32* %115, align 4, !tbaa !6
  %117 = insertelement <4 x i32> undef, i32 %116, i32 0
  %118 = shufflevector <4 x i32> %117, <4 x i32> undef, <4 x i32> zeroinitializer
  %119 = mul <4 x i32> %114, %118
  %120 = xor <4 x i32> %112, %119
  %121 = tail call <4 x float> @_Z14convert_float4Dv4_j(<4 x i32> %120) #2
  %122 = fdiv <4 x float> %121, <float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000, float 0x41F0000000000000>, !fpmath !8
  %123 = and i64 %1, 4294967295
  %124 = getelementptr inbounds <4 x float>* %output, i64 %123
  store <4 x float> %122, <4 x float>* %124, align 16, !tbaa !3
  ret void
}

declare i64 @get_global_id(i32) #1

declare i64 @get_local_id(i32) #1

declare i64 @get_group_id(i32) #1

declare i64 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind uwtable
define void @QuasiRandomSequence_Scalar(float* nocapture %output, i32* nocapture readonly %input, i32* nocapture %shared) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_local_id(i32 0) #2
  %3 = trunc i64 %2 to i32
  %4 = tail call i64 @get_group_id(i32 0) #2
  %5 = icmp slt i32 %3, 32
  br i1 %5, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %6 = trunc i64 %4 to i32
  %7 = shl i32 %6, 5
  br label %8

; <label>:8                                       ; preds = %.lr.ph, %8
  %i.04 = phi i32 [ %3, %.lr.ph ], [ %17, %8 ]
  %9 = add i32 %i.04, %7
  %10 = zext i32 %9 to i64
  %11 = getelementptr inbounds i32* %input, i64 %10
  %12 = load i32* %11, align 4, !tbaa !6
  %13 = sext i32 %i.04 to i64
  %14 = getelementptr inbounds i32* %shared, i64 %13
  store i32 %12, i32* %14, align 4, !tbaa !6
  %15 = tail call i64 @get_local_size(i32 0) #2
  %16 = add i64 %15, %13
  %17 = trunc i64 %16 to i32
  %18 = icmp slt i32 %17, 32
  br i1 %18, label %8, label %._crit_edge

._crit_edge:                                      ; preds = %8, %0
  tail call void @barrier(i32 1) #2
  %19 = and i32 %3, 1
  %20 = load i32* %shared, align 4, !tbaa !6
  %21 = sub i32 0, %19
  %22 = and i32 %20, %21
  %23 = lshr i32 %3, 1
  %24 = and i32 %23, 1
  %25 = getelementptr inbounds i32* %shared, i64 1
  %26 = load i32* %25, align 4, !tbaa !6
  %27 = sub i32 0, %24
  %28 = and i32 %26, %27
  %29 = xor i32 %28, %22
  %30 = lshr i32 %3, 2
  %31 = and i32 %30, 1
  %32 = getelementptr inbounds i32* %shared, i64 2
  %33 = load i32* %32, align 4, !tbaa !6
  %34 = sub i32 0, %31
  %35 = and i32 %33, %34
  %36 = xor i32 %35, %29
  %37 = lshr i32 %3, 3
  %38 = and i32 %37, 1
  %39 = getelementptr inbounds i32* %shared, i64 3
  %40 = load i32* %39, align 4, !tbaa !6
  %41 = sub i32 0, %38
  %42 = and i32 %40, %41
  %43 = xor i32 %42, %36
  %44 = lshr i32 %3, 4
  %45 = and i32 %44, 1
  %46 = getelementptr inbounds i32* %shared, i64 4
  %47 = load i32* %46, align 4, !tbaa !6
  %48 = sub i32 0, %45
  %49 = and i32 %47, %48
  %50 = xor i32 %49, %43
  %51 = lshr i32 %3, 5
  %52 = and i32 %51, 1
  %53 = getelementptr inbounds i32* %shared, i64 5
  %54 = load i32* %53, align 4, !tbaa !6
  %55 = sub i32 0, %52
  %56 = and i32 %54, %55
  %57 = xor i32 %56, %50
  %58 = lshr i32 %3, 6
  %59 = and i32 %58, 1
  %60 = getelementptr inbounds i32* %shared, i64 6
  %61 = load i32* %60, align 4, !tbaa !6
  %62 = sub i32 0, %59
  %63 = and i32 %61, %62
  %64 = xor i32 %63, %57
  %65 = lshr i32 %3, 7
  %66 = and i32 %65, 1
  %67 = getelementptr inbounds i32* %shared, i64 7
  %68 = load i32* %67, align 4, !tbaa !6
  %69 = sub i32 0, %66
  %70 = and i32 %68, %69
  %71 = xor i32 %70, %64
  %72 = lshr i32 %3, 8
  %73 = and i32 %72, 1
  %74 = getelementptr inbounds i32* %shared, i64 8
  %75 = load i32* %74, align 4, !tbaa !6
  %76 = sub i32 0, %73
  %77 = and i32 %75, %76
  %78 = xor i32 %77, %71
  %79 = lshr i32 %3, 9
  %80 = and i32 %79, 1
  %81 = getelementptr inbounds i32* %shared, i64 9
  %82 = load i32* %81, align 4, !tbaa !6
  %83 = sub i32 0, %80
  %84 = and i32 %82, %83
  %85 = xor i32 %84, %78
  %86 = tail call float @_Z13convert_floatj(i32 %85) #2
  %87 = fmul float %86, 0x3DF0000000000000
  %88 = and i64 %1, 4294967295
  %89 = getelementptr inbounds float* %output, i64 %88
  store float %87, float* %89, align 4, !tbaa !9
  ret void
}

declare float @_Z13convert_floatj(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float>*, <4 x i32>*, <4 x i32>*)* @QuasiRandomSequence_Vector}
!1 = metadata !{void (float*, i32*, i32*)* @QuasiRandomSequence_Scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}
!8 = metadata !{float 2.500000e+00}
!9 = metadata !{metadata !10, metadata !10, i64 0}
!10 = metadata !{metadata !"float", metadata !4, i64 0}

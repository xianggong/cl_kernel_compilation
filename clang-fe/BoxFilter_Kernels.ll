; ModuleID = '../kernel-src/BoxFilter_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @box_filter(<4 x i32>* nocapture readonly %inputImage, <4 x i8>* nocapture %outputImage, i32 %N) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_global_size(i32 0) #3
  %6 = trunc i64 %5 to i32
  %7 = tail call i64 @get_global_size(i32 1) #3
  %8 = add i32 %N, -1
  %9 = lshr i32 %8, 1
  %10 = icmp slt i32 %2, %9
  %11 = icmp slt i32 %4, %9
  %or.cond = or i1 %10, %11
  br i1 %or.cond, label %19, label %12

; <label>:12                                      ; preds = %0
  %13 = trunc i64 %7 to i32
  %14 = xor i32 %9, -1
  %15 = add i32 %6, %14
  %16 = icmp sgt i32 %2, %15
  %17 = add i32 %13, %14
  %18 = icmp sgt i32 %4, %17
  %or.cond6 = or i1 %16, %18
  br i1 %or.cond6, label %19, label %24

; <label>:19                                      ; preds = %12, %0
  %20 = mul i64 %5, %3
  %21 = add i64 %20, %1
  %sext1 = shl i64 %21, 32
  %22 = ashr exact i64 %sext1, 32
  %23 = getelementptr inbounds <4 x i8>* %outputImage, i64 %22
  store <4 x i8> zeroinitializer, <4 x i8>* %23, align 4, !tbaa !8
  br label %76

; <label>:24                                      ; preds = %12
  %25 = mul i32 %N, %N
  %26 = insertelement <4 x i32> undef, i32 %25, i32 0
  %27 = shufflevector <4 x i32> %26, <4 x i32> undef, <4 x i32> zeroinitializer
  %28 = sub nsw i32 %2, %9
  %29 = sub nsw i32 %4, %9
  %30 = add nsw i32 %2, %9
  %31 = add nsw i32 %4, %9
  %32 = add nsw i32 %28, -1
  %33 = add nsw i32 %29, -1
  %34 = icmp sgt i32 %28, 0
  %35 = icmp sgt i32 %29, 0
  %or.cond2 = and i1 %34, %35
  br i1 %or.cond2, label %36, label %43

; <label>:36                                      ; preds = %24
  %37 = mul nsw i32 %33, %6
  %38 = add nsw i32 %37, %32
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds <4 x i32>* %inputImage, i64 %39
  %41 = load <4 x i32>* %40, align 16, !tbaa !8
  %42 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %41) #3
  br label %43

; <label>:43                                      ; preds = %36, %24
  %sumA.0 = phi <4 x i32> [ %42, %36 ], [ zeroinitializer, %24 ]
  %44 = icmp sgt i32 %30, -1
  %or.cond3 = and i1 %44, %35
  br i1 %or.cond3, label %45, label %52

; <label>:45                                      ; preds = %43
  %46 = mul nsw i32 %33, %6
  %47 = add nsw i32 %46, %30
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds <4 x i32>* %inputImage, i64 %48
  %50 = load <4 x i32>* %49, align 16, !tbaa !8
  %51 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %50) #3
  br label %52

; <label>:52                                      ; preds = %45, %43
  %sumB.0 = phi <4 x i32> [ %51, %45 ], [ zeroinitializer, %43 ]
  %53 = icmp sgt i32 %31, -1
  %or.cond4 = and i1 %34, %53
  %54 = mul nsw i32 %31, %6
  br i1 %or.cond4, label %55, label %._crit_edge

; <label>:55                                      ; preds = %52
  %56 = add nsw i32 %54, %32
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds <4 x i32>* %inputImage, i64 %57
  %59 = load <4 x i32>* %58, align 16, !tbaa !8
  %60 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %59) #3
  br label %._crit_edge

._crit_edge:                                      ; preds = %52, %55
  %sumD.0 = phi <4 x i32> [ %60, %55 ], [ zeroinitializer, %52 ]
  %61 = add nsw i32 %54, %30
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds <4 x i32>* %inputImage, i64 %62
  %64 = load <4 x i32>* %63, align 16, !tbaa !8
  %65 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %64) #3
  %66 = add <4 x i32> %sumA.0, %65
  %67 = sub <4 x i32> %66, %sumB.0
  %68 = sub <4 x i32> %67, %sumD.0
  %69 = sdiv <4 x i32> %68, %27
  %70 = tail call i32 @_Z14convert_uchar4Dv4_i(<4 x i32> %69) #3
  %71 = bitcast i32 %70 to <4 x i8>
  %72 = mul i64 %5, %3
  %73 = add i64 %72, %1
  %sext = shl i64 %73, 32
  %74 = ashr exact i64 %sext, 32
  %75 = getelementptr inbounds <4 x i8>* %outputImage, i64 %74
  store <4 x i8> %71, <4 x i8>* %75, align 4, !tbaa !8
  br label %76

; <label>:76                                      ; preds = %._crit_edge, %19
  ret void
}

declare i64 @get_global_id(i32) #1

declare i64 @get_global_size(i32) #1

declare <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32>) #1

declare i32 @_Z14convert_uchar4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind uwtable
define void @horizontalSAT0(<4 x i8>* nocapture readonly %input, <4 x i32>* nocapture %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = trunc i64 %3 to i32
  %5 = mul nsw i32 %4, %width
  %6 = add nsw i32 %5, %2
  %7 = sitofp i32 %r to float
  %8 = sitofp i32 %i to float
  %9 = tail call float @llvm.pow.f32(float %7, float %8)
  %10 = fptosi float %9 to i32
  %11 = icmp sgt i32 %r, 0
  br i1 %11, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %19
  %indvars.iv = phi i64 [ %indvars.iv.next, %19 ], [ 0, %0 ]
  %sum.03 = phi <4 x i32> [ %26, %19 ], [ zeroinitializer, %0 ]
  %12 = trunc i64 %indvars.iv to i32
  %13 = mul nsw i32 %12, %10
  %14 = sub nsw i32 %2, %13
  %15 = icmp slt i32 %14, 0
  br i1 %15, label %16, label %19

; <label>:16                                      ; preds = %.lr.ph
  %17 = sext i32 %6 to i64
  %18 = getelementptr inbounds <4 x i32>* %output, i64 %17
  store <4 x i32> %sum.03, <4 x i32>* %18, align 16, !tbaa !8
  br label %31

; <label>:19                                      ; preds = %.lr.ph
  %20 = sub nsw i32 %6, %13
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds <4 x i8>* %input, i64 %21
  %23 = load <4 x i8>* %22, align 4, !tbaa !8
  %24 = bitcast <4 x i8> %23 to i32
  %25 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(i32 %24) #3
  %26 = add <4 x i32> %sum.03, %25
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %27 = trunc i64 %indvars.iv.next to i32
  %28 = icmp slt i32 %27, %r
  br i1 %28, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %19, %0
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %26, %19 ]
  %29 = sext i32 %6 to i64
  %30 = getelementptr inbounds <4 x i32>* %output, i64 %29
  store <4 x i32> %sum.0.lcssa, <4 x i32>* %30, align 16, !tbaa !8
  br label %31

; <label>:31                                      ; preds = %._crit_edge, %16
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #2

declare <4 x i32> @_Z13convert_uint4Dv4_h(i32) #1

; Function Attrs: nounwind uwtable
define void @horizontalSAT(<4 x i32>* nocapture readonly %input, <4 x i32>* nocapture %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = trunc i64 %3 to i32
  %5 = mul nsw i32 %4, %width
  %6 = add nsw i32 %5, %2
  %7 = sitofp i32 %r to float
  %8 = sitofp i32 %i to float
  %9 = tail call float @llvm.pow.f32(float %7, float %8)
  %10 = fptosi float %9 to i32
  %11 = icmp sgt i32 %r, 0
  br i1 %11, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %19
  %indvars.iv = phi i64 [ %indvars.iv.next, %19 ], [ 0, %0 ]
  %sum.02 = phi <4 x i32> [ %24, %19 ], [ zeroinitializer, %0 ]
  %12 = trunc i64 %indvars.iv to i32
  %13 = mul nsw i32 %12, %10
  %14 = sub nsw i32 %2, %13
  %15 = icmp slt i32 %14, 0
  br i1 %15, label %16, label %19

; <label>:16                                      ; preds = %.lr.ph
  %17 = sext i32 %6 to i64
  %18 = getelementptr inbounds <4 x i32>* %output, i64 %17
  store <4 x i32> %sum.02, <4 x i32>* %18, align 16, !tbaa !8
  br label %29

; <label>:19                                      ; preds = %.lr.ph
  %20 = sub nsw i32 %6, %13
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds <4 x i32>* %input, i64 %21
  %23 = load <4 x i32>* %22, align 16, !tbaa !8
  %24 = add <4 x i32> %sum.02, %23
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %25 = trunc i64 %indvars.iv.next to i32
  %26 = icmp slt i32 %25, %r
  br i1 %26, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %19, %0
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %24, %19 ]
  %27 = sext i32 %6 to i64
  %28 = getelementptr inbounds <4 x i32>* %output, i64 %27
  store <4 x i32> %sum.0.lcssa, <4 x i32>* %28, align 16, !tbaa !8
  br label %29

; <label>:29                                      ; preds = %._crit_edge, %16
  ret void
}

; Function Attrs: nounwind uwtable
define void @verticalSAT(<4 x i32>* nocapture readonly %input, <4 x i32>* nocapture %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = trunc i64 %3 to i32
  %5 = sitofp i32 %r to float
  %6 = sitofp i32 %i to float
  %7 = tail call float @llvm.pow.f32(float %5, float %6)
  %8 = fptosi float %7 to i32
  %9 = icmp sgt i32 %r, 0
  br i1 %9, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %19
  %indvars.iv = phi i64 [ %indvars.iv.next, %19 ], [ 0, %0 ]
  %sum.02 = phi <4 x i32> [ %25, %19 ], [ zeroinitializer, %0 ]
  %10 = trunc i64 %indvars.iv to i32
  %11 = mul nsw i32 %10, %8
  %12 = sub nsw i32 %4, %11
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %14, label %19

; <label>:14                                      ; preds = %.lr.ph
  %15 = mul nsw i32 %4, %width
  %16 = add nsw i32 %15, %2
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds <4 x i32>* %output, i64 %17
  store <4 x i32> %sum.02, <4 x i32>* %18, align 16, !tbaa !8
  br label %32

; <label>:19                                      ; preds = %.lr.ph
  %20 = mul nsw i32 %12, %width
  %21 = add nsw i32 %20, %2
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds <4 x i32>* %input, i64 %22
  %24 = load <4 x i32>* %23, align 16, !tbaa !8
  %25 = add <4 x i32> %sum.02, %24
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %26 = trunc i64 %indvars.iv.next to i32
  %27 = icmp slt i32 %26, %r
  br i1 %27, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %19, %0
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %25, %19 ]
  %28 = mul nsw i32 %4, %width
  %29 = add nsw i32 %28, %2
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds <4 x i32>* %output, i64 %30
  store <4 x i32> %sum.0.lcssa, <4 x i32>* %31, align 16, !tbaa !8
  br label %32

; <label>:32                                      ; preds = %._crit_edge, %14
  ret void
}

; Function Attrs: nounwind uwtable
define void @box_filter_horizontal(<4 x i8>* nocapture readonly %inputImage, <4 x i8>* nocapture %outputImage, i32 %filterWidth) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_global_size(i32 0) #3
  %6 = trunc i64 %5 to i32
  %7 = tail call i64 @get_global_size(i32 1) #3
  %8 = mul nsw i32 %6, %4
  %9 = add nsw i32 %8, %2
  %10 = add nsw i32 %filterWidth, -1
  %11 = sdiv i32 %10, 2
  %12 = icmp sge i32 %2, %11
  %13 = sub nsw i32 %6, %11
  %14 = icmp slt i32 %2, %13
  %or.cond = and i1 %12, %14
  br i1 %or.cond, label %18, label %15

; <label>:15                                      ; preds = %0
  %16 = sext i32 %9 to i64
  %17 = getelementptr inbounds <4 x i8>* %outputImage, i64 %16
  store <4 x i8> zeroinitializer, <4 x i8>* %17, align 4, !tbaa !8
  br label %51

; <label>:18                                      ; preds = %0
  %19 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %20 = shufflevector <4 x i32> %19, <4 x i32> undef, <4 x i32> zeroinitializer
  %21 = sub i32 0, %11
  %22 = icmp sgt i32 %11, %21
  br i1 %22, label %.lr.ph, label %._crit_edge7

._crit_edge7:                                     ; preds = %18
  %.pre = sext i32 %9 to i64
  br label %._crit_edge

.lr.ph:                                           ; preds = %18
  %23 = sext i32 %21 to i64
  %24 = sext i32 %9 to i64
  br label %25

; <label>:25                                      ; preds = %.lr.ph, %25
  %indvars.iv = phi i64 [ %23, %.lr.ph ], [ %indvars.iv.next, %25 ]
  %sum.06 = phi <4 x i32> [ zeroinitializer, %.lr.ph ], [ %37, %25 ]
  %26 = add nsw i64 %indvars.iv, %24
  %27 = getelementptr inbounds <4 x i8>* %inputImage, i64 %26
  %28 = load <4 x i8>* %27, align 4, !tbaa !8
  %29 = bitcast <4 x i8> %28 to i32
  %30 = tail call <4 x i32> @_Z12convert_int4Dv4_h(i32 %29) #3
  %31 = add <4 x i32> %sum.06, %30
  %32 = add nsw i64 %26, 1
  %33 = getelementptr inbounds <4 x i8>* %inputImage, i64 %32
  %34 = load <4 x i8>* %33, align 4, !tbaa !8
  %35 = bitcast <4 x i8> %34 to i32
  %36 = tail call <4 x i32> @_Z12convert_int4Dv4_h(i32 %35) #3
  %37 = add <4 x i32> %31, %36
  %indvars.iv.next = add nsw i64 %indvars.iv, 2
  %38 = trunc i64 %indvars.iv.next to i32
  %39 = icmp slt i32 %38, %11
  br i1 %39, label %25, label %._crit_edge

._crit_edge:                                      ; preds = %25, %._crit_edge7
  %.pre-phi = phi i64 [ %.pre, %._crit_edge7 ], [ %24, %25 ]
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %._crit_edge7 ], [ %37, %25 ]
  %40 = add nsw i32 %9, %11
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds <4 x i8>* %inputImage, i64 %41
  %43 = load <4 x i8>* %42, align 4, !tbaa !8
  %44 = bitcast <4 x i8> %43 to i32
  %45 = tail call <4 x i32> @_Z12convert_int4Dv4_h(i32 %44) #3
  %46 = add <4 x i32> %sum.0.lcssa, %45
  %47 = sdiv <4 x i32> %46, %20
  %48 = tail call i32 @_Z14convert_uchar4Dv4_i(<4 x i32> %47) #3
  %49 = bitcast i32 %48 to <4 x i8>
  %50 = getelementptr inbounds <4 x i8>* %outputImage, i64 %.pre-phi
  store <4 x i8> %49, <4 x i8>* %50, align 4, !tbaa !8
  br label %51

; <label>:51                                      ; preds = %._crit_edge, %15
  ret void
}

declare <4 x i32> @_Z12convert_int4Dv4_h(i32) #1

; Function Attrs: nounwind uwtable
define void @box_filter_vertical(<4 x i8>* nocapture readonly %inputImage, <4 x i8>* nocapture %outputImage, i32 %filterWidth) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_global_size(i32 0) #3
  %6 = trunc i64 %5 to i32
  %7 = tail call i64 @get_global_size(i32 1) #3
  %8 = mul nsw i32 %6, %4
  %9 = add nsw i32 %8, %2
  %10 = add nsw i32 %filterWidth, -1
  %11 = sdiv i32 %10, 2
  %12 = icmp slt i32 %4, %11
  br i1 %12, label %17, label %13

; <label>:13                                      ; preds = %0
  %14 = trunc i64 %7 to i32
  %15 = sub nsw i32 %14, %11
  %16 = icmp slt i32 %4, %15
  br i1 %16, label %20, label %17

; <label>:17                                      ; preds = %13, %0
  %18 = sext i32 %9 to i64
  %19 = getelementptr inbounds <4 x i8>* %outputImage, i64 %18
  store <4 x i8> zeroinitializer, <4 x i8>* %19, align 4, !tbaa !8
  br label %61

; <label>:20                                      ; preds = %13
  %21 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %22 = shufflevector <4 x i32> %21, <4 x i32> undef, <4 x i32> zeroinitializer
  %23 = sub i32 0, %11
  %24 = icmp sgt i32 %11, %23
  br i1 %24, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %20
  %25 = sext i32 %23 to i64
  br label %26

; <label>:26                                      ; preds = %.lr.ph, %26
  %indvars.iv = phi i64 [ %25, %.lr.ph ], [ %indvars.iv.next, %26 ]
  %sum.05 = phi <4 x i32> [ zeroinitializer, %.lr.ph ], [ %45, %26 ]
  %27 = trunc i64 %indvars.iv to i32
  %28 = mul nsw i32 %27, %6
  %29 = add nsw i32 %28, %9
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds <4 x i8>* %inputImage, i64 %30
  %32 = load <4 x i8>* %31, align 4, !tbaa !8
  %33 = bitcast <4 x i8> %32 to i32
  %34 = tail call <4 x i32> @_Z12convert_int4Dv4_h(i32 %33) #3
  %35 = add <4 x i32> %sum.05, %34
  %36 = add nsw i64 %indvars.iv, 1
  %37 = trunc i64 %36 to i32
  %38 = mul nsw i32 %37, %6
  %39 = add nsw i32 %38, %9
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds <4 x i8>* %inputImage, i64 %40
  %42 = load <4 x i8>* %41, align 4, !tbaa !8
  %43 = bitcast <4 x i8> %42 to i32
  %44 = tail call <4 x i32> @_Z12convert_int4Dv4_h(i32 %43) #3
  %45 = add <4 x i32> %35, %44
  %indvars.iv.next = add nsw i64 %indvars.iv, 2
  %46 = trunc i64 %indvars.iv.next to i32
  %47 = icmp slt i32 %46, %11
  br i1 %47, label %26, label %._crit_edge

._crit_edge:                                      ; preds = %26, %20
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %20 ], [ %45, %26 ]
  %48 = mul nsw i32 %11, %6
  %49 = add nsw i32 %9, %48
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds <4 x i8>* %inputImage, i64 %50
  %52 = load <4 x i8>* %51, align 4, !tbaa !8
  %53 = bitcast <4 x i8> %52 to i32
  %54 = tail call <4 x i32> @_Z12convert_int4Dv4_h(i32 %53) #3
  %55 = add <4 x i32> %sum.0.lcssa, %54
  %56 = sdiv <4 x i32> %55, %22
  %57 = tail call i32 @_Z14convert_uchar4Dv4_i(<4 x i32> %56) #3
  %58 = bitcast i32 %57 to <4 x i8>
  %59 = sext i32 %9 to i64
  %60 = getelementptr inbounds <4 x i8>* %outputImage, i64 %59
  store <4 x i8> %58, <4 x i8>* %60, align 4, !tbaa !8
  br label %61

; <label>:61                                      ; preds = %._crit_edge, %17
  ret void
}

; Function Attrs: nounwind uwtable
define void @box_filter_horizontal_local(<4 x i8>* nocapture readonly %inputImage, <4 x i8>* nocapture %outputImage, i32 %filterWidth, <4 x i8>* nocapture %lds) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = tail call i64 @get_global_size(i32 0) #3
  %5 = trunc i64 %4 to i32
  %6 = tail call i64 @get_global_size(i32 1) #3
  %7 = mul i64 %4, %3
  %8 = add i64 %7, %1
  %9 = add nsw i32 %filterWidth, -1
  %10 = sdiv i32 %9, 2
  %11 = sub i32 0, %10
  %12 = tail call i64 @get_local_id(i32 0) #3
  %13 = trunc i64 %12 to i32
  %14 = tail call i64 @get_group_id(i32 0) #3
  %15 = trunc i64 %14 to i32
  %16 = tail call i64 @get_group_id(i32 1) #3
  %17 = trunc i64 %16 to i32
  %18 = tail call i64 @get_local_size(i32 0) #3
  %19 = trunc i64 %18 to i32
  %20 = tail call i64 @get_local_size(i32 1) #3
  %21 = trunc i64 %20 to i32
  %22 = mul nsw i32 %19, %15
  %23 = mul nsw i32 %17, %5
  %24 = mul nsw i32 %23, %21
  %25 = add nsw i32 %24, %22
  %26 = icmp slt i32 %13, %10
  br i1 %26, label %27, label %44

; <label>:27                                      ; preds = %0
  %28 = sub i32 %13, %10
  %29 = add i32 %28, %25
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds <4 x i8>* %inputImage, i64 %30
  %32 = load <4 x i8>* %31, align 4, !tbaa !8
  %sext2 = shl i64 %12, 32
  %33 = ashr exact i64 %sext2, 32
  %34 = getelementptr inbounds <4 x i8>* %lds, i64 %33
  store <4 x i8> %32, <4 x i8>* %34, align 4, !tbaa !8
  %35 = add i32 %13, 256
  %36 = add i32 %35, %25
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds <4 x i8>* %inputImage, i64 %37
  %39 = load <4 x i8>* %38, align 4, !tbaa !8
  %40 = add nsw i32 %10, 256
  %41 = add nsw i32 %40, %13
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds <4 x i8>* %lds, i64 %42
  store <4 x i8> %39, <4 x i8>* %43, align 4, !tbaa !8
  br label %44

; <label>:44                                      ; preds = %27, %0
  %45 = add nsw i32 %25, %13
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds <4 x i8>* %inputImage, i64 %46
  %48 = load <4 x i8>* %47, align 4, !tbaa !8
  %49 = add i32 %13, %10
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds <4 x i8>* %lds, i64 %50
  store <4 x i8> %48, <4 x i8>* %51, align 4, !tbaa !8
  tail call void @barrier(i32 1) #3
  %52 = icmp sge i32 %2, %10
  %53 = sub nsw i32 %5, %10
  %54 = icmp slt i32 %2, %53
  %or.cond = and i1 %52, %54
  br i1 %or.cond, label %55, label %75

; <label>:55                                      ; preds = %44
  %56 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %57 = shufflevector <4 x i32> %56, <4 x i32> undef, <4 x i32> zeroinitializer
  %58 = icmp slt i32 %10, %11
  br i1 %58, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %55
  %59 = sext i32 %11 to i64
  br label %60

; <label>:60                                      ; preds = %60, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %60 ], [ %59, %.lr.ph ]
  %sum.05 = phi <4 x i32> [ %68, %60 ], [ zeroinitializer, %.lr.ph ]
  %61 = trunc i64 %indvars.iv to i32
  %62 = add i32 %49, %61
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds <4 x i8>* %lds, i64 %63
  %65 = load <4 x i8>* %64, align 4, !tbaa !8
  %66 = bitcast <4 x i8> %65 to i32
  %67 = tail call <4 x i32> @_Z12convert_int4Dv4_h(i32 %66) #3
  %68 = add <4 x i32> %sum.05, %67
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %69 = icmp slt i32 %61, %10
  br i1 %69, label %60, label %._crit_edge

._crit_edge:                                      ; preds = %60, %55
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %55 ], [ %68, %60 ]
  %70 = sdiv <4 x i32> %sum.0.lcssa, %57
  %71 = tail call i32 @_Z14convert_uchar4Dv4_i(<4 x i32> %70) #3
  %72 = bitcast i32 %71 to <4 x i8>
  %sext = shl i64 %8, 32
  %73 = ashr exact i64 %sext, 32
  %74 = getelementptr inbounds <4 x i8>* %outputImage, i64 %73
  store <4 x i8> %72, <4 x i8>* %74, align 4, !tbaa !8
  br label %75

; <label>:75                                      ; preds = %44, %._crit_edge
  ret void
}

declare i64 @get_local_id(i32) #1

declare i64 @get_group_id(i32) #1

declare i64 @get_local_size(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (<4 x i32>*, <4 x i8>*, i32)* @box_filter}
!1 = metadata !{void (<4 x i8>*, <4 x i32>*, i32, i32, i32)* @horizontalSAT0}
!2 = metadata !{void (<4 x i32>*, <4 x i32>*, i32, i32, i32)* @horizontalSAT}
!3 = metadata !{void (<4 x i32>*, <4 x i32>*, i32, i32, i32)* @verticalSAT}
!4 = metadata !{void (<4 x i8>*, <4 x i8>*, i32)* @box_filter_horizontal}
!5 = metadata !{void (<4 x i8>*, <4 x i8>*, i32)* @box_filter_vertical}
!6 = metadata !{void (<4 x i8>*, <4 x i8>*, i32, <4 x i8>*)* @box_filter_horizontal_local}
!7 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"omnipotent char", metadata !10, i64 0}
!10 = metadata !{metadata !"Simple C/C++ TBAA"}

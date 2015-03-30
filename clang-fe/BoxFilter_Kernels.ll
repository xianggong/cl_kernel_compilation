; ModuleID = '../kernel-src/BoxFilter_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @box_filter(<4 x i32> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %N) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = tail call i32 @get_global_size(i32 0) #3
  %4 = tail call i32 @get_global_size(i32 1) #3
  %5 = add i32 %N, -1
  %6 = lshr i32 %5, 1
  %7 = icmp slt i32 %1, %6
  %8 = icmp slt i32 %2, %6
  %or.cond = or i1 %7, %8
  br i1 %or.cond, label %15, label %9

; <label>:9                                       ; preds = %0
  %10 = xor i32 %6, -1
  %11 = add i32 %3, %10
  %12 = icmp sgt i32 %1, %11
  %13 = add i32 %4, %10
  %14 = icmp sgt i32 %2, %13
  %or.cond5 = or i1 %12, %14
  br i1 %or.cond5, label %15, label %20

; <label>:15                                      ; preds = %9, %0
  %16 = mul nsw i32 %3, %2
  %17 = add nsw i32 %16, %1
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %18
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %19, align 4, !tbaa !8
  br label %71

; <label>:20                                      ; preds = %9
  %21 = mul i32 %N, %N
  %22 = insertelement <4 x i32> undef, i32 %21, i32 0
  %23 = shufflevector <4 x i32> %22, <4 x i32> undef, <4 x i32> zeroinitializer
  %24 = sub nsw i32 %1, %6
  %25 = sub nsw i32 %2, %6
  %26 = add nsw i32 %1, %6
  %27 = add nsw i32 %2, %6
  %28 = add nsw i32 %24, -1
  %29 = add nsw i32 %25, -1
  %30 = icmp sgt i32 %24, 0
  %31 = icmp sgt i32 %25, 0
  %or.cond1 = and i1 %30, %31
  br i1 %or.cond1, label %32, label %39

; <label>:32                                      ; preds = %20
  %33 = mul nsw i32 %29, %3
  %34 = add nsw i32 %33, %28
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %35
  %37 = load <4 x i32> addrspace(1)* %36, align 16, !tbaa !8
  %38 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %37) #3
  br label %39

; <label>:39                                      ; preds = %32, %20
  %sumA.0 = phi <4 x i32> [ %38, %32 ], [ zeroinitializer, %20 ]
  %40 = icmp sgt i32 %26, -1
  %or.cond2 = and i1 %40, %31
  br i1 %or.cond2, label %41, label %48

; <label>:41                                      ; preds = %39
  %42 = mul nsw i32 %29, %3
  %43 = add nsw i32 %42, %26
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %44
  %46 = load <4 x i32> addrspace(1)* %45, align 16, !tbaa !8
  %47 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %46) #3
  br label %48

; <label>:48                                      ; preds = %41, %39
  %sumB.0 = phi <4 x i32> [ %47, %41 ], [ zeroinitializer, %39 ]
  %49 = icmp sgt i32 %27, -1
  %or.cond3 = and i1 %30, %49
  %50 = mul nsw i32 %27, %3
  br i1 %or.cond3, label %51, label %._crit_edge

; <label>:51                                      ; preds = %48
  %52 = add nsw i32 %50, %28
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %53
  %55 = load <4 x i32> addrspace(1)* %54, align 16, !tbaa !8
  %56 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %55) #3
  br label %._crit_edge

._crit_edge:                                      ; preds = %48, %51
  %sumD.0 = phi <4 x i32> [ %56, %51 ], [ zeroinitializer, %48 ]
  %57 = add nsw i32 %50, %26
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %58
  %60 = load <4 x i32> addrspace(1)* %59, align 16, !tbaa !8
  %61 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %60) #3
  %62 = add <4 x i32> %sumA.0, %61
  %63 = sub <4 x i32> %62, %sumB.0
  %64 = sub <4 x i32> %63, %sumD.0
  %65 = sdiv <4 x i32> %64, %23
  %66 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %65) #3
  %67 = mul nsw i32 %3, %2
  %68 = add nsw i32 %67, %1
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %69
  store <4 x i8> %66, <4 x i8> addrspace(1)* %70, align 4, !tbaa !8
  br label %71

; <label>:71                                      ; preds = %._crit_edge, %15
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32>) #1

declare <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind
define void @horizontalSAT0(<4 x i8> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(1)* nocapture %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = mul nsw i32 %2, %width
  %4 = add nsw i32 %3, %1
  %5 = sitofp i32 %r to float
  %6 = sitofp i32 %i to float
  %7 = tail call float @llvm.pow.f32(float %5, float %6)
  %8 = fptosi float %7 to i32
  %9 = icmp sgt i32 %r, 0
  br i1 %9, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %17
  %indvars.iv = phi i64 [ %indvars.iv.next, %17 ], [ 0, %0 ]
  %sum.02 = phi <4 x i32> [ %23, %17 ], [ zeroinitializer, %0 ]
  %10 = trunc i64 %indvars.iv to i32
  %11 = mul nsw i32 %10, %8
  %12 = sub nsw i32 %1, %11
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %14, label %17

; <label>:14                                      ; preds = %.lr.ph
  %15 = sext i32 %4 to i64
  %16 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %15
  store <4 x i32> %sum.02, <4 x i32> addrspace(1)* %16, align 16, !tbaa !8
  br label %28

; <label>:17                                      ; preds = %.lr.ph
  %18 = sub nsw i32 %4, %11
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %19
  %21 = load <4 x i8> addrspace(1)* %20, align 4, !tbaa !8
  %22 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %21) #3
  %23 = add <4 x i32> %sum.02, %22
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %24 = trunc i64 %indvars.iv.next to i32
  %25 = icmp slt i32 %24, %r
  br i1 %25, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %17, %0
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %23, %17 ]
  %26 = sext i32 %4 to i64
  %27 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %26
  store <4 x i32> %sum.0.lcssa, <4 x i32> addrspace(1)* %27, align 16, !tbaa !8
  br label %28

; <label>:28                                      ; preds = %._crit_edge, %14
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #2

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @horizontalSAT(<4 x i32> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(1)* nocapture %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = mul nsw i32 %2, %width
  %4 = add nsw i32 %3, %1
  %5 = sitofp i32 %r to float
  %6 = sitofp i32 %i to float
  %7 = tail call float @llvm.pow.f32(float %5, float %6)
  %8 = fptosi float %7 to i32
  %9 = icmp sgt i32 %r, 0
  br i1 %9, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %17
  %indvars.iv = phi i64 [ %indvars.iv.next, %17 ], [ 0, %0 ]
  %sum.02 = phi <4 x i32> [ %22, %17 ], [ zeroinitializer, %0 ]
  %10 = trunc i64 %indvars.iv to i32
  %11 = mul nsw i32 %10, %8
  %12 = sub nsw i32 %1, %11
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %14, label %17

; <label>:14                                      ; preds = %.lr.ph
  %15 = sext i32 %4 to i64
  %16 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %15
  store <4 x i32> %sum.02, <4 x i32> addrspace(1)* %16, align 16, !tbaa !8
  br label %27

; <label>:17                                      ; preds = %.lr.ph
  %18 = sub nsw i32 %4, %11
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %19
  %21 = load <4 x i32> addrspace(1)* %20, align 16, !tbaa !8
  %22 = add <4 x i32> %sum.02, %21
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %23 = trunc i64 %indvars.iv.next to i32
  %24 = icmp slt i32 %23, %r
  br i1 %24, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %17, %0
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %22, %17 ]
  %25 = sext i32 %4 to i64
  %26 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %25
  store <4 x i32> %sum.0.lcssa, <4 x i32> addrspace(1)* %26, align 16, !tbaa !8
  br label %27

; <label>:27                                      ; preds = %._crit_edge, %14
  ret void
}

; Function Attrs: nounwind
define void @verticalSAT(<4 x i32> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(1)* nocapture %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = sitofp i32 %r to float
  %4 = sitofp i32 %i to float
  %5 = tail call float @llvm.pow.f32(float %3, float %4)
  %6 = fptosi float %5 to i32
  %7 = icmp sgt i32 %r, 0
  br i1 %7, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %17
  %indvars.iv = phi i64 [ %indvars.iv.next, %17 ], [ 0, %0 ]
  %sum.02 = phi <4 x i32> [ %23, %17 ], [ zeroinitializer, %0 ]
  %8 = trunc i64 %indvars.iv to i32
  %9 = mul nsw i32 %8, %6
  %10 = sub nsw i32 %2, %9
  %11 = icmp slt i32 %10, 0
  br i1 %11, label %12, label %17

; <label>:12                                      ; preds = %.lr.ph
  %13 = mul nsw i32 %2, %width
  %14 = add nsw i32 %13, %1
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %15
  store <4 x i32> %sum.02, <4 x i32> addrspace(1)* %16, align 16, !tbaa !8
  br label %30

; <label>:17                                      ; preds = %.lr.ph
  %18 = mul nsw i32 %10, %width
  %19 = add nsw i32 %18, %1
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %20
  %22 = load <4 x i32> addrspace(1)* %21, align 16, !tbaa !8
  %23 = add <4 x i32> %sum.02, %22
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %24 = trunc i64 %indvars.iv.next to i32
  %25 = icmp slt i32 %24, %r
  br i1 %25, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %17, %0
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %23, %17 ]
  %26 = mul nsw i32 %2, %width
  %27 = add nsw i32 %26, %1
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %28
  store <4 x i32> %sum.0.lcssa, <4 x i32> addrspace(1)* %29, align 16, !tbaa !8
  br label %30

; <label>:30                                      ; preds = %._crit_edge, %12
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %filterWidth) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = tail call i32 @get_global_size(i32 0) #3
  %4 = tail call i32 @get_global_size(i32 1) #3
  %5 = mul nsw i32 %3, %2
  %6 = add nsw i32 %5, %1
  %7 = add nsw i32 %filterWidth, -1
  %8 = sdiv i32 %7, 2
  %9 = icmp sge i32 %1, %8
  %10 = sub nsw i32 %3, %8
  %11 = icmp slt i32 %1, %10
  %or.cond = and i1 %9, %11
  br i1 %or.cond, label %15, label %12

; <label>:12                                      ; preds = %0
  %13 = sext i32 %6 to i64
  %14 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %13
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %14, align 4, !tbaa !8
  br label %44

; <label>:15                                      ; preds = %0
  %16 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %17 = shufflevector <4 x i32> %16, <4 x i32> undef, <4 x i32> zeroinitializer
  %18 = sub i32 0, %8
  %19 = icmp sgt i32 %8, %18
  br i1 %19, label %.lr.ph, label %._crit_edge4

._crit_edge4:                                     ; preds = %15
  %.pre = sext i32 %6 to i64
  br label %._crit_edge

.lr.ph:                                           ; preds = %15
  %20 = sext i32 %18 to i64
  %21 = sext i32 %6 to i64
  br label %22

; <label>:22                                      ; preds = %.lr.ph, %22
  %indvars.iv = phi i64 [ %20, %.lr.ph ], [ %indvars.iv.next, %22 ]
  %sum.02 = phi <4 x i32> [ zeroinitializer, %.lr.ph ], [ %32, %22 ]
  %23 = add nsw i64 %indvars.iv, %21
  %24 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %23
  %25 = load <4 x i8> addrspace(1)* %24, align 4, !tbaa !8
  %26 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %25) #3
  %27 = add <4 x i32> %sum.02, %26
  %28 = add nsw i64 %23, 1
  %29 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %28
  %30 = load <4 x i8> addrspace(1)* %29, align 4, !tbaa !8
  %31 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %30) #3
  %32 = add <4 x i32> %27, %31
  %indvars.iv.next = add nsw i64 %indvars.iv, 2
  %33 = trunc i64 %indvars.iv.next to i32
  %34 = icmp slt i32 %33, %8
  br i1 %34, label %22, label %._crit_edge

._crit_edge:                                      ; preds = %22, %._crit_edge4
  %.pre-phi = phi i64 [ %.pre, %._crit_edge4 ], [ %21, %22 ]
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %._crit_edge4 ], [ %32, %22 ]
  %35 = add nsw i32 %6, %8
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %36
  %38 = load <4 x i8> addrspace(1)* %37, align 4, !tbaa !8
  %39 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %38) #3
  %40 = add <4 x i32> %sum.0.lcssa, %39
  %41 = sdiv <4 x i32> %40, %17
  %42 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %41) #3
  %43 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %.pre-phi
  store <4 x i8> %42, <4 x i8> addrspace(1)* %43, align 4, !tbaa !8
  br label %44

; <label>:44                                      ; preds = %._crit_edge, %12
  ret void
}

declare <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @box_filter_vertical(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %filterWidth) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = tail call i32 @get_global_size(i32 0) #3
  %4 = tail call i32 @get_global_size(i32 1) #3
  %5 = mul nsw i32 %3, %2
  %6 = add nsw i32 %5, %1
  %7 = add nsw i32 %filterWidth, -1
  %8 = sdiv i32 %7, 2
  %9 = icmp sge i32 %2, %8
  %10 = sub nsw i32 %4, %8
  %11 = icmp slt i32 %2, %10
  %or.cond = and i1 %9, %11
  br i1 %or.cond, label %15, label %12

; <label>:12                                      ; preds = %0
  %13 = sext i32 %6 to i64
  %14 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %13
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %14, align 4, !tbaa !8
  br label %52

; <label>:15                                      ; preds = %0
  %16 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %17 = shufflevector <4 x i32> %16, <4 x i32> undef, <4 x i32> zeroinitializer
  %18 = sub i32 0, %8
  %19 = icmp sgt i32 %8, %18
  br i1 %19, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %15
  %20 = sext i32 %18 to i64
  br label %21

; <label>:21                                      ; preds = %.lr.ph, %21
  %indvars.iv = phi i64 [ %20, %.lr.ph ], [ %indvars.iv.next, %21 ]
  %sum.02 = phi <4 x i32> [ zeroinitializer, %.lr.ph ], [ %38, %21 ]
  %22 = trunc i64 %indvars.iv to i32
  %23 = mul nsw i32 %22, %3
  %24 = add nsw i32 %23, %6
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %25
  %27 = load <4 x i8> addrspace(1)* %26, align 4, !tbaa !8
  %28 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %27) #3
  %29 = add <4 x i32> %sum.02, %28
  %30 = add nsw i64 %indvars.iv, 1
  %31 = trunc i64 %30 to i32
  %32 = mul nsw i32 %31, %3
  %33 = add nsw i32 %32, %6
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %34
  %36 = load <4 x i8> addrspace(1)* %35, align 4, !tbaa !8
  %37 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %36) #3
  %38 = add <4 x i32> %29, %37
  %indvars.iv.next = add nsw i64 %indvars.iv, 2
  %39 = trunc i64 %indvars.iv.next to i32
  %40 = icmp slt i32 %39, %8
  br i1 %40, label %21, label %._crit_edge

._crit_edge:                                      ; preds = %21, %15
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %15 ], [ %38, %21 ]
  %41 = mul nsw i32 %8, %3
  %42 = add nsw i32 %41, %6
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %43
  %45 = load <4 x i8> addrspace(1)* %44, align 4, !tbaa !8
  %46 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %45) #3
  %47 = add <4 x i32> %sum.0.lcssa, %46
  %48 = sdiv <4 x i32> %47, %17
  %49 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %48) #3
  %50 = sext i32 %6 to i64
  %51 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %50
  store <4 x i8> %49, <4 x i8> addrspace(1)* %51, align 4, !tbaa !8
  br label %52

; <label>:52                                      ; preds = %._crit_edge, %12
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal_local(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %filterWidth, <4 x i8> addrspace(3)* nocapture %lds) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = tail call i32 @get_global_size(i32 0) #3
  %4 = tail call i32 @get_global_size(i32 1) #3
  %5 = mul nsw i32 %3, %2
  %6 = add nsw i32 %5, %1
  %7 = add nsw i32 %filterWidth, -1
  %8 = sdiv i32 %7, 2
  %9 = sub nsw i32 0, %8
  %10 = tail call i32 @get_local_id(i32 0) #3
  %11 = tail call i32 @get_group_id(i32 0) #3
  %12 = tail call i32 @get_group_id(i32 1) #3
  %13 = tail call i32 @get_local_size(i32 0) #3
  %14 = tail call i32 @get_local_size(i32 1) #3
  %15 = mul nsw i32 %13, %11
  %16 = mul nsw i32 %12, %3
  %17 = mul nsw i32 %16, %14
  %18 = add nsw i32 %17, %15
  %19 = icmp slt i32 %10, %8
  br i1 %19, label %20, label %35

; <label>:20                                      ; preds = %0
  %21 = sub i32 %10, %8
  %22 = add i32 %21, %18
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %23
  %25 = load <4 x i8> addrspace(1)* %24, align 4, !tbaa !8
  %26 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %10
  store <4 x i8> %25, <4 x i8> addrspace(3)* %26, align 4, !tbaa !8
  %27 = add i32 %10, 256
  %28 = add i32 %27, %18
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %29
  %31 = load <4 x i8> addrspace(1)* %30, align 4, !tbaa !8
  %32 = add nsw i32 %8, 256
  %33 = add nsw i32 %32, %10
  %34 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %33
  store <4 x i8> %31, <4 x i8> addrspace(3)* %34, align 4, !tbaa !8
  br label %35

; <label>:35                                      ; preds = %20, %0
  %36 = add nsw i32 %18, %10
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %37
  %39 = load <4 x i8> addrspace(1)* %38, align 4, !tbaa !8
  %40 = add i32 %10, %8
  %41 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %40
  store <4 x i8> %39, <4 x i8> addrspace(3)* %41, align 4, !tbaa !8
  tail call void @barrier(i32 1) #3
  %42 = icmp sge i32 %1, %8
  %43 = sub nsw i32 %3, %8
  %44 = icmp slt i32 %1, %43
  %or.cond = and i1 %42, %44
  br i1 %or.cond, label %45, label %60

; <label>:45                                      ; preds = %35
  %46 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %47 = shufflevector <4 x i32> %46, <4 x i32> undef, <4 x i32> zeroinitializer
  %48 = icmp slt i32 %8, %9
  br i1 %48, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %45, %.lr.ph
  %X.03 = phi i32 [ %54, %.lr.ph ], [ %9, %45 ]
  %sum.02 = phi <4 x i32> [ %53, %.lr.ph ], [ zeroinitializer, %45 ]
  %49 = add i32 %40, %X.03
  %50 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %49
  %51 = load <4 x i8> addrspace(3)* %50, align 4, !tbaa !8
  %52 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %51) #3
  %53 = add <4 x i32> %sum.02, %52
  %54 = add nsw i32 %X.03, 1
  %55 = icmp slt i32 %X.03, %8
  br i1 %55, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %45
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %45 ], [ %53, %.lr.ph ]
  %56 = sdiv <4 x i32> %sum.0.lcssa, %47
  %57 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %56) #3
  %58 = sext i32 %6 to i64
  %59 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %58
  store <4 x i8> %57, <4 x i8> addrspace(1)* %59, align 4, !tbaa !8
  br label %60

; <label>:60                                      ; preds = %35, %._crit_edge
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter}
!1 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT0}
!2 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT}
!3 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @verticalSAT}
!4 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_horizontal}
!5 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_vertical}
!6 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, <4 x i8> addrspace(3)*)* @box_filter_horizontal_local}
!7 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"omnipotent char", metadata !10, i64 0}
!10 = metadata !{metadata !"Simple C/C++ TBAA"}

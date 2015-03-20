; ModuleID = '../kernel-src/BoxFilter_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

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
  br i1 %or.cond5, label %15, label %19

; <label>:15                                      ; preds = %9, %0
  %16 = mul nsw i32 %3, %2
  %17 = add nsw i32 %16, %1
  %18 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %17
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %18, align 4, !tbaa !27
  br label %65

; <label>:19                                      ; preds = %9
  %20 = mul i32 %N, %N
  %21 = insertelement <4 x i32> undef, i32 %20, i32 0
  %22 = shufflevector <4 x i32> %21, <4 x i32> undef, <4 x i32> zeroinitializer
  %23 = sub nsw i32 %1, %6
  %24 = sub nsw i32 %2, %6
  %25 = add nsw i32 %1, %6
  %26 = add nsw i32 %2, %6
  %27 = add nsw i32 %23, -1
  %28 = add nsw i32 %24, -1
  %29 = icmp sgt i32 %23, 0
  %30 = icmp sgt i32 %24, 0
  %or.cond1 = and i1 %29, %30
  br i1 %or.cond1, label %31, label %37

; <label>:31                                      ; preds = %19
  %32 = mul nsw i32 %28, %3
  %33 = add nsw i32 %32, %27
  %34 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %33
  %35 = load <4 x i32> addrspace(1)* %34, align 16, !tbaa !27
  %36 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %35) #3
  br label %37

; <label>:37                                      ; preds = %31, %19
  %sumA.0 = phi <4 x i32> [ %36, %31 ], [ zeroinitializer, %19 ]
  %38 = icmp sgt i32 %25, -1
  %or.cond2 = and i1 %38, %30
  br i1 %or.cond2, label %39, label %45

; <label>:39                                      ; preds = %37
  %40 = mul nsw i32 %28, %3
  %41 = add nsw i32 %40, %25
  %42 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %41
  %43 = load <4 x i32> addrspace(1)* %42, align 16, !tbaa !27
  %44 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %43) #3
  br label %45

; <label>:45                                      ; preds = %39, %37
  %sumB.0 = phi <4 x i32> [ %44, %39 ], [ zeroinitializer, %37 ]
  %46 = icmp sgt i32 %26, -1
  %or.cond3 = and i1 %29, %46
  %47 = mul nsw i32 %26, %3
  br i1 %or.cond3, label %48, label %._crit_edge

; <label>:48                                      ; preds = %45
  %49 = add nsw i32 %47, %27
  %50 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %49
  %51 = load <4 x i32> addrspace(1)* %50, align 16, !tbaa !27
  %52 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %51) #3
  br label %._crit_edge

._crit_edge:                                      ; preds = %45, %48
  %sumD.0 = phi <4 x i32> [ %52, %48 ], [ zeroinitializer, %45 ]
  %53 = add nsw i32 %47, %25
  %54 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %53
  %55 = load <4 x i32> addrspace(1)* %54, align 16, !tbaa !27
  %56 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %55) #3
  %57 = add <4 x i32> %sumA.0, %56
  %58 = sub <4 x i32> %57, %sumB.0
  %59 = sub <4 x i32> %58, %sumD.0
  %60 = sdiv <4 x i32> %59, %22
  %61 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %60) #3
  %62 = mul nsw i32 %3, %2
  %63 = add nsw i32 %62, %1
  %64 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %63
  store <4 x i8> %61, <4 x i8> addrspace(1)* %64, align 4, !tbaa !27
  br label %65

; <label>:65                                      ; preds = %._crit_edge, %15
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
  br i1 %9, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %14
  %j.03 = phi i32 [ %20, %14 ], [ 0, %.lr.ph.preheader ]
  %sum.02 = phi <4 x i32> [ %19, %14 ], [ zeroinitializer, %.lr.ph.preheader ]
  %10 = mul nsw i32 %j.03, %8
  %11 = icmp slt i32 %1, %10
  br i1 %11, label %12, label %14

; <label>:12                                      ; preds = %.lr.ph
  %sum.02.lcssa = phi <4 x i32> [ %sum.02, %.lr.ph ]
  %13 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %4
  store <4 x i32> %sum.02.lcssa, <4 x i32> addrspace(1)* %13, align 16, !tbaa !27
  br label %23

; <label>:14                                      ; preds = %.lr.ph
  %15 = sub nsw i32 %4, %10
  %16 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %15
  %17 = load <4 x i8> addrspace(1)* %16, align 4, !tbaa !27
  %18 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %17) #3
  %19 = add <4 x i32> %sum.02, %18
  %20 = add nuw nsw i32 %j.03, 1
  %21 = icmp slt i32 %20, %r
  br i1 %21, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %14
  %.lcssa = phi <4 x i32> [ %19, %14 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %22 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %4
  store <4 x i32> %sum.0.lcssa, <4 x i32> addrspace(1)* %22, align 16, !tbaa !27
  br label %23

; <label>:23                                      ; preds = %._crit_edge, %12
  ret void
}

; Function Attrs: nounwind readnone
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
  br i1 %9, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %14
  %j.03 = phi i32 [ %19, %14 ], [ 0, %.lr.ph.preheader ]
  %sum.02 = phi <4 x i32> [ %18, %14 ], [ zeroinitializer, %.lr.ph.preheader ]
  %10 = mul nsw i32 %j.03, %8
  %11 = icmp slt i32 %1, %10
  br i1 %11, label %12, label %14

; <label>:12                                      ; preds = %.lr.ph
  %sum.02.lcssa = phi <4 x i32> [ %sum.02, %.lr.ph ]
  %13 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %4
  store <4 x i32> %sum.02.lcssa, <4 x i32> addrspace(1)* %13, align 16, !tbaa !27
  br label %22

; <label>:14                                      ; preds = %.lr.ph
  %15 = sub nsw i32 %4, %10
  %16 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %15
  %17 = load <4 x i32> addrspace(1)* %16, align 16, !tbaa !27
  %18 = add <4 x i32> %sum.02, %17
  %19 = add nuw nsw i32 %j.03, 1
  %20 = icmp slt i32 %19, %r
  br i1 %20, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %14
  %.lcssa = phi <4 x i32> [ %18, %14 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %21 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %4
  store <4 x i32> %sum.0.lcssa, <4 x i32> addrspace(1)* %21, align 16, !tbaa !27
  br label %22

; <label>:22                                      ; preds = %._crit_edge, %12
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
  br i1 %7, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %15
  %j.03 = phi i32 [ %21, %15 ], [ 0, %.lr.ph.preheader ]
  %sum.02 = phi <4 x i32> [ %20, %15 ], [ zeroinitializer, %.lr.ph.preheader ]
  %8 = mul nsw i32 %j.03, %6
  %9 = sub nsw i32 %2, %8
  %10 = icmp slt i32 %9, 0
  br i1 %10, label %11, label %15

; <label>:11                                      ; preds = %.lr.ph
  %sum.02.lcssa = phi <4 x i32> [ %sum.02, %.lr.ph ]
  %12 = mul nsw i32 %2, %width
  %13 = add nsw i32 %12, %1
  %14 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %13
  store <4 x i32> %sum.02.lcssa, <4 x i32> addrspace(1)* %14, align 16, !tbaa !27
  br label %26

; <label>:15                                      ; preds = %.lr.ph
  %16 = mul nsw i32 %9, %width
  %17 = add nsw i32 %16, %1
  %18 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %17
  %19 = load <4 x i32> addrspace(1)* %18, align 16, !tbaa !27
  %20 = add <4 x i32> %sum.02, %19
  %21 = add nuw nsw i32 %j.03, 1
  %22 = icmp slt i32 %21, %r
  br i1 %22, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %15
  %.lcssa = phi <4 x i32> [ %20, %15 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %23 = mul nsw i32 %2, %width
  %24 = add nsw i32 %23, %1
  %25 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %24
  store <4 x i32> %sum.0.lcssa, <4 x i32> addrspace(1)* %25, align 16, !tbaa !27
  br label %26

; <label>:26                                      ; preds = %._crit_edge, %11
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
  br i1 %or.cond, label %14, label %12

; <label>:12                                      ; preds = %0
  %13 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %13, align 4, !tbaa !27
  br label %39

; <label>:14                                      ; preds = %0
  %15 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %16 = shufflevector <4 x i32> %15, <4 x i32> undef, <4 x i32> zeroinitializer
  %17 = sub nsw i32 0, %8
  %18 = icmp sgt i32 %8, %17
  br i1 %18, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %14
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %X.03 = phi i32 [ %29, %.lr.ph ], [ %17, %.lr.ph.preheader ]
  %sum.02 = phi <4 x i32> [ %28, %.lr.ph ], [ zeroinitializer, %.lr.ph.preheader ]
  %19 = add nsw i32 %X.03, %6
  %20 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %19
  %21 = load <4 x i8> addrspace(1)* %20, align 4, !tbaa !27
  %22 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %21) #3
  %23 = add <4 x i32> %sum.02, %22
  %24 = add nsw i32 %19, 1
  %25 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %24
  %26 = load <4 x i8> addrspace(1)* %25, align 4, !tbaa !27
  %27 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %26) #3
  %28 = add <4 x i32> %23, %27
  %29 = add nsw i32 %X.03, 2
  %30 = icmp slt i32 %29, %8
  br i1 %30, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.lcssa = phi <4 x i32> [ %28, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %14
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %14 ], [ %.lcssa, %._crit_edge.loopexit ]
  %31 = add nsw i32 %6, %8
  %32 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %31
  %33 = load <4 x i8> addrspace(1)* %32, align 4, !tbaa !27
  %34 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %33) #3
  %35 = add <4 x i32> %sum.0.lcssa, %34
  %36 = sdiv <4 x i32> %35, %16
  %37 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %36) #3
  %38 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> %37, <4 x i8> addrspace(1)* %38, align 4, !tbaa !27
  br label %39

; <label>:39                                      ; preds = %._crit_edge, %12
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
  br i1 %or.cond, label %14, label %12

; <label>:12                                      ; preds = %0
  %13 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %13, align 4, !tbaa !27
  br label %43

; <label>:14                                      ; preds = %0
  %15 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %16 = shufflevector <4 x i32> %15, <4 x i32> undef, <4 x i32> zeroinitializer
  %17 = sub nsw i32 0, %8
  %18 = icmp sgt i32 %8, %17
  br i1 %18, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %14
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %Y.03 = phi i32 [ %32, %.lr.ph ], [ %17, %.lr.ph.preheader ]
  %sum.02 = phi <4 x i32> [ %31, %.lr.ph ], [ zeroinitializer, %.lr.ph.preheader ]
  %19 = mul nsw i32 %Y.03, %3
  %20 = add nsw i32 %19, %6
  %21 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %20
  %22 = load <4 x i8> addrspace(1)* %21, align 4, !tbaa !27
  %23 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %22) #3
  %24 = add <4 x i32> %sum.02, %23
  %25 = add nsw i32 %Y.03, 1
  %26 = mul nsw i32 %25, %3
  %27 = add nsw i32 %26, %6
  %28 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %27
  %29 = load <4 x i8> addrspace(1)* %28, align 4, !tbaa !27
  %30 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %29) #3
  %31 = add <4 x i32> %24, %30
  %32 = add nsw i32 %Y.03, 2
  %33 = icmp slt i32 %32, %8
  br i1 %33, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.lcssa = phi <4 x i32> [ %31, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %14
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %14 ], [ %.lcssa, %._crit_edge.loopexit ]
  %34 = mul nsw i32 %8, %3
  %35 = add nsw i32 %34, %6
  %36 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %35
  %37 = load <4 x i8> addrspace(1)* %36, align 4, !tbaa !27
  %38 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %37) #3
  %39 = add <4 x i32> %sum.0.lcssa, %38
  %40 = sdiv <4 x i32> %39, %16
  %41 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %40) #3
  %42 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> %41, <4 x i8> addrspace(1)* %42, align 4, !tbaa !27
  br label %43

; <label>:43                                      ; preds = %._crit_edge, %12
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
  br i1 %19, label %20, label %33

; <label>:20                                      ; preds = %0
  %21 = sub i32 %10, %8
  %22 = add i32 %21, %18
  %23 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %22
  %24 = load <4 x i8> addrspace(1)* %23, align 4, !tbaa !27
  %25 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %10
  store <4 x i8> %24, <4 x i8> addrspace(3)* %25, align 4, !tbaa !27
  %26 = add i32 %10, 256
  %27 = add i32 %26, %18
  %28 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %27
  %29 = load <4 x i8> addrspace(1)* %28, align 4, !tbaa !27
  %30 = add nsw i32 %8, 256
  %31 = add nsw i32 %30, %10
  %32 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %31
  store <4 x i8> %29, <4 x i8> addrspace(3)* %32, align 4, !tbaa !27
  br label %33

; <label>:33                                      ; preds = %20, %0
  %34 = add nsw i32 %18, %10
  %35 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %34
  %36 = load <4 x i8> addrspace(1)* %35, align 4, !tbaa !27
  %37 = add i32 %10, %8
  %38 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %37
  store <4 x i8> %36, <4 x i8> addrspace(3)* %38, align 4, !tbaa !27
  tail call void @barrier(i32 1) #3
  %39 = icmp sge i32 %1, %8
  %40 = sub nsw i32 %3, %8
  %41 = icmp slt i32 %1, %40
  %or.cond = and i1 %39, %41
  br i1 %or.cond, label %42, label %56

; <label>:42                                      ; preds = %33
  %43 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %44 = shufflevector <4 x i32> %43, <4 x i32> undef, <4 x i32> zeroinitializer
  %45 = icmp slt i32 %8, %9
  br i1 %45, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %42
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %X.03 = phi i32 [ %51, %.lr.ph ], [ %9, %.lr.ph.preheader ]
  %sum.02 = phi <4 x i32> [ %50, %.lr.ph ], [ zeroinitializer, %.lr.ph.preheader ]
  %46 = add i32 %37, %X.03
  %47 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %46
  %48 = load <4 x i8> addrspace(3)* %47, align 4, !tbaa !27
  %49 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %48) #3
  %50 = add <4 x i32> %sum.02, %49
  %51 = add nsw i32 %X.03, 1
  %52 = icmp slt i32 %X.03, %8
  br i1 %52, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.lcssa = phi <4 x i32> [ %50, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %42
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %42 ], [ %.lcssa, %._crit_edge.loopexit ]
  %53 = sdiv <4 x i32> %sum.0.lcssa, %44
  %54 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %53) #3
  %55 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> %54, <4 x i8> addrspace(1)* %55, align 4, !tbaa !27
  br label %56

; <label>:56                                      ; preds = %33, %._crit_edge
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6, !12, !15, !16, !19, !20}
!llvm.ident = !{!26}

!0 = !{void (<4 x i32> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint4*", !"uchar4*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"uint __attribute__((ext_vector_type(4)))*", !"uchar __attribute__((ext_vector_type(4)))*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (<4 x i8> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT0, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0}
!8 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"uchar4*", !"uint4*", !"int", !"int", !"int"}
!10 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uint __attribute__((ext_vector_type(4)))*", !"int", !"int", !"int"}
!11 = !{!"kernel_arg_type_qual", !"", !"", !"", !"", !""}
!12 = !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT, !7, !8, !13, !14, !11}
!13 = !{!"kernel_arg_type", !"uint4*", !"uint4*", !"int", !"int", !"int"}
!14 = !{!"kernel_arg_base_type", !"uint __attribute__((ext_vector_type(4)))*", !"uint __attribute__((ext_vector_type(4)))*", !"int", !"int", !"int"}
!15 = !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @verticalSAT, !7, !8, !13, !14, !11}
!16 = !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_horizontal, !1, !2, !17, !18, !5}
!17 = !{!"kernel_arg_type", !"uchar4*", !"uchar4*", !"int"}
!18 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar __attribute__((ext_vector_type(4)))*", !"int"}
!19 = !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_vertical, !1, !2, !17, !18, !5}
!20 = !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, <4 x i8> addrspace(3)*)* @box_filter_horizontal_local, !21, !22, !23, !24, !25}
!21 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 3}
!22 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!23 = !{!"kernel_arg_type", !"uchar4*", !"uchar4*", !"int", !"uchar4*"}
!24 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar __attribute__((ext_vector_type(4)))*", !"int", !"uchar __attribute__((ext_vector_type(4)))*"}
!25 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!26 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!27 = !{!28, !28, i64 0}
!28 = !{!"omnipotent char", !29, i64 0}
!29 = !{!"Simple C/C++ TBAA"}

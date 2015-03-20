; ModuleID = '../kernel-src/HistogramAtomics_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@histogramKernel_Vector.subhists = internal global [4096 x i32] zeroinitializer, align 16
@histogramKernel_Scalar.subhists = internal global [1024 x i32] zeroinitializer, align 16

; Function Attrs: nounwind uwtable
define void @histogramKernel_Vector(<4 x i32>* nocapture readonly %Image, i32* nocapture %Histogram, i32 %n4VectorsPerThread) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_local_id(i32 0) #2
  %3 = trunc i64 %2 to i32
  %4 = tail call i64 @get_global_size(i32 0) #2
  %5 = tail call i64 @get_local_size(i32 0) #2
  %6 = trunc i64 %5 to i32
  %7 = and i32 %3, 15
  %8 = icmp ult i32 %3, 1024
  br i1 %8, label %.lr.ph10, label %._crit_edge11

.lr.ph10:                                         ; preds = %0, %.lr.ph10
  %i.08 = phi i32 [ %11, %.lr.ph10 ], [ %3, %0 ]
  %9 = zext i32 %i.08 to i64
  %10 = getelementptr inbounds <4 x i32>* bitcast ([4096 x i32]* @histogramKernel_Vector.subhists to <4 x i32>*), i64 %9
  store <4 x i32> zeroinitializer, <4 x i32>* %10, align 16, !tbaa !4
  %11 = add i32 %i.08, %6
  %12 = icmp ult i32 %11, 1024
  br i1 %12, label %.lr.ph10, label %._crit_edge11

._crit_edge11:                                    ; preds = %.lr.ph10, %0
  tail call void @barrier(i32 1) #2
  %13 = icmp eq i32 %n4VectorsPerThread, 0
  br i1 %13, label %._crit_edge7, label %.lr.ph

.lr.ph:                                           ; preds = %._crit_edge11
  %14 = insertelement <4 x i32> undef, i32 %7, i32 0
  %15 = shufflevector <4 x i32> %14, <4 x i32> undef, <4 x i32> zeroinitializer
  br label %16

; <label>:16                                      ; preds = %16, %.lr.ph
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %16 ]
  %17 = mul i64 %indvars.iv, %4
  %18 = add i64 %17, %1
  %19 = and i64 %18, 4294967295
  %20 = getelementptr inbounds <4 x i32>* %Image, i64 %19
  %21 = load <4 x i32>* %20, align 16, !tbaa !4
  %22 = and <4 x i32> %21, <i32 255, i32 255, i32 255, i32 255>
  %23 = shl <4 x i32> %22, <i32 4, i32 4, i32 4, i32 4>
  %24 = add <4 x i32> %23, %15
  %25 = extractelement <4 x i32> %24, i32 0
  %26 = zext i32 %25 to i64
  %27 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %26
  %28 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %27) #2
  %29 = extractelement <4 x i32> %24, i32 1
  %30 = zext i32 %29 to i64
  %31 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %30
  %32 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %31) #2
  %33 = extractelement <4 x i32> %24, i32 2
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %34
  %36 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %35) #2
  %37 = extractelement <4 x i32> %24, i32 3
  %38 = zext i32 %37 to i64
  %39 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %38
  %40 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %39) #2
  %41 = lshr <4 x i32> %21, <i32 8, i32 8, i32 8, i32 8>
  %42 = and <4 x i32> %41, <i32 255, i32 255, i32 255, i32 255>
  %43 = shl <4 x i32> %42, <i32 4, i32 4, i32 4, i32 4>
  %44 = add <4 x i32> %43, %15
  %45 = extractelement <4 x i32> %44, i32 0
  %46 = zext i32 %45 to i64
  %47 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %46
  %48 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %47) #2
  %49 = extractelement <4 x i32> %44, i32 1
  %50 = zext i32 %49 to i64
  %51 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %50
  %52 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %51) #2
  %53 = extractelement <4 x i32> %44, i32 2
  %54 = zext i32 %53 to i64
  %55 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %54
  %56 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %55) #2
  %57 = extractelement <4 x i32> %44, i32 3
  %58 = zext i32 %57 to i64
  %59 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %58
  %60 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %59) #2
  %61 = lshr <4 x i32> %41, <i32 8, i32 8, i32 8, i32 8>
  %62 = and <4 x i32> %61, <i32 255, i32 255, i32 255, i32 255>
  %63 = shl <4 x i32> %62, <i32 4, i32 4, i32 4, i32 4>
  %64 = add <4 x i32> %63, %15
  %65 = extractelement <4 x i32> %64, i32 0
  %66 = zext i32 %65 to i64
  %67 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %66
  %68 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %67) #2
  %69 = extractelement <4 x i32> %64, i32 1
  %70 = zext i32 %69 to i64
  %71 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %70
  %72 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %71) #2
  %73 = extractelement <4 x i32> %64, i32 2
  %74 = zext i32 %73 to i64
  %75 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %74
  %76 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %75) #2
  %77 = extractelement <4 x i32> %64, i32 3
  %78 = zext i32 %77 to i64
  %79 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %78
  %80 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %79) #2
  %81 = lshr <4 x i32> %61, <i32 8, i32 8, i32 8, i32 8>
  %82 = and <4 x i32> %81, <i32 255, i32 255, i32 255, i32 255>
  %83 = shl <4 x i32> %82, <i32 4, i32 4, i32 4, i32 4>
  %84 = add <4 x i32> %83, %15
  %85 = extractelement <4 x i32> %84, i32 0
  %86 = zext i32 %85 to i64
  %87 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %86
  %88 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %87) #2
  %89 = extractelement <4 x i32> %84, i32 1
  %90 = zext i32 %89 to i64
  %91 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %90
  %92 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %91) #2
  %93 = extractelement <4 x i32> %84, i32 2
  %94 = zext i32 %93 to i64
  %95 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %94
  %96 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %95) #2
  %97 = extractelement <4 x i32> %84, i32 3
  %98 = zext i32 %97 to i64
  %99 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %98
  %100 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %99) #2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond12 = icmp eq i32 %lftr.wideiv, %n4VectorsPerThread
  br i1 %exitcond12, label %._crit_edge7, label %16

._crit_edge7:                                     ; preds = %16, %._crit_edge11
  tail call void @barrier(i32 1) #2
  %101 = icmp ult i32 %3, 256
  br i1 %101, label %.preheader, label %._crit_edge

.preheader:                                       ; preds = %._crit_edge7, %112
  %i.24 = phi i32 [ %118, %112 ], [ %3, %._crit_edge7 ]
  %102 = shl i32 %i.24, 4
  br label %103

; <label>:103                                     ; preds = %103, %.preheader
  %j.03 = phi i32 [ 0, %.preheader ], [ %110, %103 ]
  %off.02 = phi i32 [ %7, %.preheader ], [ %111, %103 ]
  %bin.01 = phi i32 [ 0, %.preheader ], [ %109, %103 ]
  %104 = and i32 %off.02, 15
  %105 = or i32 %104, %102
  %106 = zext i32 %105 to i64
  %107 = getelementptr inbounds [4096 x i32]* @histogramKernel_Vector.subhists, i64 0, i64 %106
  %108 = load i32* %107, align 4, !tbaa !7
  %109 = add i32 %108, %bin.01
  %110 = add nsw i32 %j.03, 1
  %111 = add i32 %off.02, 1
  %exitcond = icmp eq i32 %110, 16
  br i1 %exitcond, label %112, label %103

; <label>:112                                     ; preds = %103
  %113 = tail call i64 @get_group_id(i32 0) #2
  %114 = shl i64 %113, 8
  %115 = zext i32 %i.24 to i64
  %116 = add i64 %114, %115
  %117 = getelementptr inbounds i32* %Histogram, i64 %116
  store i32 %109, i32* %117, align 4, !tbaa !7
  %118 = add i32 %i.24, %6
  %119 = icmp ult i32 %118, 256
  br i1 %119, label %.preheader, label %._crit_edge

._crit_edge:                                      ; preds = %112, %._crit_edge7
  ret void
}

declare i64 @get_global_id(i32) #1

declare i64 @get_local_id(i32) #1

declare i64 @get_global_size(i32) #1

declare i64 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z8atom_incPU7CLlocalj(i32*) #1

declare i64 @get_group_id(i32) #1

; Function Attrs: nounwind uwtable
define void @histogramKernel_Scalar(i32* nocapture readonly %Image, i32* nocapture %Histogram, i32 %nVectorsPerThread) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = tail call i64 @get_local_id(i32 0) #2
  %3 = trunc i64 %2 to i32
  %4 = tail call i64 @get_global_size(i32 0) #2
  %5 = tail call i64 @get_local_size(i32 0) #2
  %6 = trunc i64 %5 to i32
  %7 = and i32 %3, 3
  %8 = icmp ult i32 %3, 1024
  br i1 %8, label %.lr.ph11, label %._crit_edge12

.lr.ph11:                                         ; preds = %0, %.lr.ph11
  %i.09 = phi i32 [ %11, %.lr.ph11 ], [ %3, %0 ]
  %9 = zext i32 %i.09 to i64
  %10 = getelementptr inbounds [1024 x i32]* @histogramKernel_Scalar.subhists, i64 0, i64 %9
  store i32 0, i32* %10, align 4, !tbaa !7
  %11 = add i32 %i.09, %6
  %12 = icmp ult i32 %11, 1024
  br i1 %12, label %.lr.ph11, label %._crit_edge12

._crit_edge12:                                    ; preds = %.lr.ph11, %0
  tail call void @barrier(i32 1) #2
  %13 = icmp eq i32 %nVectorsPerThread, 0
  br i1 %13, label %._crit_edge8, label %.lr.ph

.lr.ph:                                           ; preds = %._crit_edge12, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %._crit_edge12 ]
  %14 = mul i64 %indvars.iv, %4
  %15 = add i64 %14, %1
  %16 = and i64 %15, 4294967295
  %17 = getelementptr inbounds i32* %Image, i64 %16
  %18 = load i32* %17, align 4, !tbaa !7
  %19 = shl i32 %18, 2
  %20 = and i32 %19, 1020
  %21 = or i32 %20, %7
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds [1024 x i32]* @histogramKernel_Scalar.subhists, i64 0, i64 %22
  %24 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %23) #2
  %25 = lshr i32 %18, 6
  %26 = and i32 %25, 1020
  %27 = or i32 %26, %7
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds [1024 x i32]* @histogramKernel_Scalar.subhists, i64 0, i64 %28
  %30 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %29) #2
  %31 = lshr i32 %18, 14
  %32 = and i32 %31, 1020
  %33 = or i32 %32, %7
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds [1024 x i32]* @histogramKernel_Scalar.subhists, i64 0, i64 %34
  %36 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %35) #2
  %37 = lshr i32 %18, 24
  %38 = shl nuw nsw i32 %37, 2
  %39 = or i32 %38, %7
  %40 = zext i32 %39 to i64
  %41 = getelementptr inbounds [1024 x i32]* @histogramKernel_Scalar.subhists, i64 0, i64 %40
  %42 = tail call i32 @_Z8atom_incPU7CLlocalj(i32* %41) #2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %nVectorsPerThread
  br i1 %exitcond, label %._crit_edge8, label %.lr.ph

._crit_edge8:                                     ; preds = %.lr.ph, %._crit_edge12
  tail call void @barrier(i32 1) #2
  %43 = icmp ult i32 %3, 256
  br i1 %43, label %.preheader, label %._crit_edge

.preheader:                                       ; preds = %._crit_edge8, %.preheader
  %i.25 = phi i32 [ %73, %.preheader ], [ %3, %._crit_edge8 ]
  %44 = shl i32 %i.25, 2
  %45 = or i32 %7, %44
  %46 = zext i32 %45 to i64
  %47 = getelementptr inbounds [1024 x i32]* @histogramKernel_Scalar.subhists, i64 0, i64 %46
  %48 = load i32* %47, align 4, !tbaa !7
  %fold = add i32 %3, 1
  %49 = and i32 %fold, 3
  %50 = or i32 %49, %44
  %51 = zext i32 %50 to i64
  %52 = getelementptr inbounds [1024 x i32]* @histogramKernel_Scalar.subhists, i64 0, i64 %51
  %53 = load i32* %52, align 4, !tbaa !7
  %54 = add i32 %53, %48
  %fold13 = add i32 %3, 2
  %55 = and i32 %fold13, 3
  %56 = or i32 %55, %44
  %57 = zext i32 %56 to i64
  %58 = getelementptr inbounds [1024 x i32]* @histogramKernel_Scalar.subhists, i64 0, i64 %57
  %59 = load i32* %58, align 4, !tbaa !7
  %60 = add i32 %59, %54
  %61 = add i32 %3, 3
  %62 = and i32 %61, 3
  %63 = or i32 %62, %44
  %64 = zext i32 %63 to i64
  %65 = getelementptr inbounds [1024 x i32]* @histogramKernel_Scalar.subhists, i64 0, i64 %64
  %66 = load i32* %65, align 4, !tbaa !7
  %67 = add i32 %66, %60
  %68 = tail call i64 @get_group_id(i32 0) #2
  %69 = shl i64 %68, 8
  %70 = zext i32 %i.25 to i64
  %71 = add i64 %69, %70
  %72 = getelementptr inbounds i32* %Histogram, i64 %71
  store i32 %67, i32* %72, align 4, !tbaa !7
  %73 = add i32 %i.25, %6
  %74 = icmp ult i32 %73, 256
  br i1 %74, label %.preheader, label %._crit_edge

._crit_edge:                                      ; preds = %.preheader, %._crit_edge8
  ret void
}

; Function Attrs: nounwind uwtable
define void @reduceKernel(i32* nocapture %Histogram, i32 %nSubHists) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = icmp eq i32 %nSubHists, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %0, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %0 ]
  %bin.01 = phi i32 [ %25, %.lr.ph ], [ 0, %0 ]
  %4 = trunc i64 %indvars.iv to i32
  %5 = shl nsw i32 %4, 8
  %6 = add i32 %5, %2
  %7 = zext i32 %6 to i64
  %8 = getelementptr inbounds i32* %Histogram, i64 %7
  %9 = load i32* %8, align 4, !tbaa !7
  %10 = add i32 %6, 256
  %11 = zext i32 %10 to i64
  %12 = getelementptr inbounds i32* %Histogram, i64 %11
  %13 = load i32* %12, align 4, !tbaa !7
  %14 = add i32 %6, 512
  %15 = zext i32 %14 to i64
  %16 = getelementptr inbounds i32* %Histogram, i64 %15
  %17 = load i32* %16, align 4, !tbaa !7
  %18 = add i32 %6, 768
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds i32* %Histogram, i64 %19
  %21 = load i32* %20, align 4, !tbaa !7
  %22 = add i32 %9, %bin.01
  %23 = add i32 %22, %13
  %24 = add i32 %23, %17
  %25 = add i32 %24, %21
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 4
  %26 = trunc i64 %indvars.iv.next to i32
  %27 = icmp ult i32 %26, %nSubHists
  br i1 %27, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %0
  %bin.0.lcssa = phi i32 [ 0, %0 ], [ %25, %.lr.ph ]
  %28 = and i64 %1, 4294967295
  %29 = getelementptr inbounds i32* %Histogram, i64 %28
  store i32 %bin.0.lcssa, i32* %29, align 4, !tbaa !7
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (<4 x i32>*, i32*, i32)* @histogramKernel_Vector}
!1 = metadata !{void (i32*, i32*, i32)* @histogramKernel_Scalar}
!2 = metadata !{void (i32*, i32)* @reduceKernel}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"int", metadata !5, i64 0}

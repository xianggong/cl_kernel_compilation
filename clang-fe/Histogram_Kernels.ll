; ModuleID = '../kernel-src/Histogram_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @histogram256_vector(<4 x i32>* nocapture readonly %data, i8* nocapture %sharedArray, i32* nocapture %binResult) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = tail call i64 @get_global_id(i32 0) #2
  %3 = tail call i64 @get_group_id(i32 0) #2
  %4 = tail call i64 @get_local_size(i32 0) #2
  %.tr = trunc i64 %1 to i32
  %5 = shl i32 %.tr, 2
  %6 = lshr i64 %1, 5
  %7 = bitcast i8* %sharedArray to <4 x i8>*
  br label %8

; <label>:8                                       ; preds = %8, %0
  %indvars.iv11 = phi i64 [ 0, %0 ], [ %indvars.iv.next12, %8 ]
  %9 = mul i64 %indvars.iv11, %4
  %10 = add i64 %9, %1
  %11 = getelementptr inbounds <4 x i8>* %7, i64 %10
  store <4 x i8> zeroinitializer, <4 x i8>* %11, align 4, !tbaa !3
  %indvars.iv.next12 = add nuw nsw i64 %indvars.iv11, 1
  %exitcond13 = icmp eq i64 %indvars.iv.next12, 64
  br i1 %exitcond13, label %12, label %8

; <label>:12                                      ; preds = %8
  %13 = and i32 %5, 124
  %14 = trunc i64 %6 to i32
  tail call void @barrier(i32 1) #2
  %15 = shl i64 %4, 5
  %16 = and i64 %15, 2305843009213693920
  %17 = mul i64 %16, %3
  %18 = add i64 %17, %1
  br label %19

; <label>:19                                      ; preds = %19, %12
  %indvars.iv8 = phi i64 [ 0, %12 ], [ %indvars.iv.next9, %19 ]
  %20 = mul i64 %indvars.iv8, %4
  %21 = add i64 %18, %20
  %22 = getelementptr inbounds <4 x i32>* %data, i64 %21
  %23 = load <4 x i32>* %22, align 16, !tbaa !3
  %24 = extractelement <4 x i32> %23, i32 0
  %25 = shl i32 %24, 7
  %26 = or i32 %25, %13
  %27 = add i32 %26, %14
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds i8* %sharedArray, i64 %28
  %30 = load i8* %29, align 1, !tbaa !3
  %31 = add i8 %30, 1
  store i8 %31, i8* %29, align 1, !tbaa !3
  %32 = extractelement <4 x i32> %23, i32 1
  %33 = shl i32 %32, 7
  %34 = or i32 %33, %13
  %35 = add i32 %34, %14
  %36 = zext i32 %35 to i64
  %37 = getelementptr inbounds i8* %sharedArray, i64 %36
  %38 = load i8* %37, align 1, !tbaa !3
  %39 = add i8 %38, 1
  store i8 %39, i8* %37, align 1, !tbaa !3
  %40 = extractelement <4 x i32> %23, i32 2
  %41 = shl i32 %40, 7
  %42 = or i32 %41, %13
  %43 = add i32 %42, %14
  %44 = zext i32 %43 to i64
  %45 = getelementptr inbounds i8* %sharedArray, i64 %44
  %46 = load i8* %45, align 1, !tbaa !3
  %47 = add i8 %46, 1
  store i8 %47, i8* %45, align 1, !tbaa !3
  %48 = extractelement <4 x i32> %23, i32 3
  %49 = shl i32 %48, 7
  %50 = or i32 %49, %13
  %51 = add i32 %50, %14
  %52 = zext i32 %51 to i64
  %53 = getelementptr inbounds i8* %sharedArray, i64 %52
  %54 = load i8* %53, align 1, !tbaa !3
  %55 = add i8 %54, 1
  store i8 %55, i8* %53, align 1, !tbaa !3
  %indvars.iv.next9 = add nuw nsw i64 %indvars.iv8, 1
  %exitcond10 = icmp eq i64 %indvars.iv.next9, 32
  br i1 %exitcond10, label %56, label %19

; <label>:56                                      ; preds = %19
  tail call void @barrier(i32 1) #2
  %57 = udiv i64 256, %4
  %58 = icmp eq i64 %57, 0
  br i1 %58, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %56
  %59 = shl i64 %1, 5
  %60 = shl i64 %3, 8
  %61 = add i64 %60, %1
  br label %62

; <label>:62                                      ; preds = %.lr.ph, %77
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %77 ]
  %63 = shl i64 %indvars.iv, 12
  %64 = add i64 %63, %59
  %65 = trunc i64 %64 to i32
  br label %66

; <label>:66                                      ; preds = %66, %62
  %j.04 = phi i32 [ 0, %62 ], [ %76, %66 ]
  %binCount.03 = phi <4 x i32> [ zeroinitializer, %62 ], [ %75, %66 ]
  %67 = add nsw i32 %j.04, %.tr
  %68 = and i32 %67, 31
  %69 = or i32 %68, %65
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds <4 x i8>* %7, i64 %70
  %72 = load <4 x i8>* %71, align 4, !tbaa !3
  %73 = bitcast <4 x i8> %72 to i32
  %74 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(i32 %73) #2
  %75 = add <4 x i32> %binCount.03, %74
  %76 = add nsw i32 %j.04, 1
  %exitcond = icmp eq i32 %76, 32
  br i1 %exitcond, label %77, label %66

; <label>:77                                      ; preds = %66
  %78 = extractelement <4 x i32> %75, i32 0
  %79 = extractelement <4 x i32> %75, i32 1
  %80 = add i32 %78, %79
  %81 = extractelement <4 x i32> %75, i32 2
  %82 = add i32 %80, %81
  %83 = extractelement <4 x i32> %75, i32 3
  %84 = add i32 %82, %83
  %85 = mul i64 %indvars.iv, %4
  %86 = add i64 %61, %85
  %87 = getelementptr inbounds i32* %binResult, i64 %86
  store i32 %84, i32* %87, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %88 = icmp ult i64 %indvars.iv.next, %57
  br i1 %88, label %62, label %._crit_edge

._crit_edge:                                      ; preds = %77, %56
  ret void
}

declare i64 @get_local_id(i32) #1

declare i64 @get_global_id(i32) #1

declare i64 @get_group_id(i32) #1

declare i64 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare <4 x i32> @_Z13convert_uint4Dv4_h(i32) #1

; Function Attrs: nounwind uwtable
define void @histogram256_scalar(i32* nocapture readonly %data, i8* nocapture %sharedArray, i32* nocapture %binResult) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #2
  %2 = tail call i64 @get_global_id(i32 0) #2
  %3 = tail call i64 @get_group_id(i32 0) #2
  %4 = tail call i64 @get_local_size(i32 0) #2
  %.tr = trunc i64 %1 to i32
  %5 = shl i32 %.tr, 2
  %6 = lshr i64 %1, 5
  %7 = bitcast i8* %sharedArray to <4 x i8>*
  br label %8

; <label>:8                                       ; preds = %8, %0
  %indvars.iv12 = phi i64 [ 0, %0 ], [ %indvars.iv.next13, %8 ]
  %9 = mul i64 %indvars.iv12, %4
  %10 = add i64 %9, %1
  %11 = getelementptr inbounds <4 x i8>* %7, i64 %10
  store <4 x i8> zeroinitializer, <4 x i8>* %11, align 4, !tbaa !3
  %indvars.iv.next13 = add nuw nsw i64 %indvars.iv12, 1
  %exitcond14 = icmp eq i64 %indvars.iv.next13, 64
  br i1 %exitcond14, label %12, label %8

; <label>:12                                      ; preds = %8
  %13 = and i32 %5, 124
  %14 = trunc i64 %6 to i32
  tail call void @barrier(i32 1) #2
  %15 = shl i64 %3, 7
  br label %16

; <label>:16                                      ; preds = %16, %12
  %indvars.iv9 = phi i64 [ 0, %12 ], [ %indvars.iv.next10, %16 ]
  %tmp = add i64 %indvars.iv9, %15
  %tmp3 = mul i64 %tmp, %4
  %17 = add i64 %tmp3, %1
  %18 = getelementptr inbounds i32* %data, i64 %17
  %19 = load i32* %18, align 4, !tbaa !6
  %20 = shl i32 %19, 7
  %21 = or i32 %20, %13
  %22 = add i32 %21, %14
  %23 = zext i32 %22 to i64
  %24 = getelementptr inbounds i8* %sharedArray, i64 %23
  %25 = load i8* %24, align 1, !tbaa !3
  %26 = add i8 %25, 1
  store i8 %26, i8* %24, align 1, !tbaa !3
  %indvars.iv.next10 = add nuw nsw i64 %indvars.iv9, 1
  %exitcond11 = icmp eq i64 %indvars.iv.next10, 128
  br i1 %exitcond11, label %27, label %16

; <label>:27                                      ; preds = %16
  tail call void @barrier(i32 1) #2
  %28 = udiv i64 256, %4
  %29 = icmp eq i64 %28, 0
  br i1 %29, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %27
  %30 = shl i64 %1, 5
  %31 = shl i64 %3, 8
  %32 = add i64 %31, %1
  br label %33

; <label>:33                                      ; preds = %.lr.ph, %48
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %48 ]
  %34 = shl i64 %indvars.iv, 12
  %35 = add i64 %34, %30
  %36 = trunc i64 %35 to i32
  br label %37

; <label>:37                                      ; preds = %37, %33
  %j.05 = phi i32 [ 0, %33 ], [ %47, %37 ]
  %binCount.04 = phi <4 x i32> [ zeroinitializer, %33 ], [ %46, %37 ]
  %38 = add nsw i32 %j.05, %.tr
  %39 = and i32 %38, 31
  %40 = or i32 %39, %36
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds <4 x i8>* %7, i64 %41
  %43 = load <4 x i8>* %42, align 4, !tbaa !3
  %44 = bitcast <4 x i8> %43 to i32
  %45 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(i32 %44) #2
  %46 = add <4 x i32> %binCount.04, %45
  %47 = add nsw i32 %j.05, 1
  %exitcond = icmp eq i32 %47, 32
  br i1 %exitcond, label %48, label %37

; <label>:48                                      ; preds = %37
  %49 = extractelement <4 x i32> %46, i32 0
  %50 = extractelement <4 x i32> %46, i32 1
  %51 = add i32 %49, %50
  %52 = extractelement <4 x i32> %46, i32 2
  %53 = add i32 %51, %52
  %54 = extractelement <4 x i32> %46, i32 3
  %55 = add i32 %53, %54
  %56 = mul i64 %indvars.iv, %4
  %57 = add i64 %32, %56
  %58 = getelementptr inbounds i32* %binResult, i64 %57
  store i32 %55, i32* %58, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %59 = icmp ult i64 %indvars.iv.next, %28
  br i1 %59, label %33, label %._crit_edge

._crit_edge:                                      ; preds = %48, %27
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32>*, i8*, i32*)* @histogram256_vector}
!1 = metadata !{void (i32*, i8*, i32*)* @histogram256_scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}

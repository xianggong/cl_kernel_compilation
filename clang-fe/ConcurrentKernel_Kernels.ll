; ModuleID = '../kernel-src/ConcurrentKernel_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@K2.lds = internal global [8192 x i8] zeroinitializer, align 16
@K4.lds = internal global [8192 x i8] zeroinitializer, align 16
@K6.lds = internal global [8192 x i8] zeroinitializer, align 16
@K8.lds = internal global [8192 x i8] zeroinitializer, align 16
@K10.lds = internal global [8192 x i8] zeroinitializer, align 16

; Function Attrs: nounwind uwtable
define void @work1(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  %zero = alloca i32, align 4
  %1 = tail call i64 @get_global_size(i32 0) #2
  %2 = tail call i64 @get_global_id(i32 0) #2
  %3 = tail call i64 @get_local_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %7

.preheader:                                       ; preds = %7
  %4 = trunc i64 %1 to i32
  %5 = trunc i64 %2 to i32
  %6 = icmp ult i32 %5, %bufferSize
  br i1 %6, label %.lr.ph, label %._crit_edge

; <label>:7                                       ; preds = %7, %0
  %i.04 = phi i32 [ 1, %0 ], [ %42, %7 ]
  %tmp.03 = phi i32 [ 1, %0 ], [ %41, %7 ]
  %8 = urem i32 %i.04, %bufferSize
  %9 = zext i32 %8 to i64
  %10 = getelementptr inbounds i8* %input, i64 %9
  %11 = load i8* %10, align 1, !tbaa !11
  %12 = zext i8 %11 to i32
  %13 = shl nsw i32 %i.04, 1
  %14 = urem i32 %13, %bufferSize
  %15 = zext i32 %14 to i64
  %16 = getelementptr inbounds i8* %input, i64 %15
  %17 = load i8* %16, align 1, !tbaa !11
  %18 = zext i8 %17 to i32
  %19 = mul nsw i32 %i.04, 3
  %20 = urem i32 %19, %bufferSize
  %21 = zext i32 %20 to i64
  %22 = getelementptr inbounds i8* %input, i64 %21
  %23 = load i8* %22, align 1, !tbaa !11
  %24 = zext i8 %23 to i32
  %25 = shl nsw i32 %i.04, 2
  %26 = urem i32 %25, %bufferSize
  %27 = zext i32 %26 to i64
  %28 = getelementptr inbounds i8* %input, i64 %27
  %29 = load i8* %28, align 1, !tbaa !11
  %30 = zext i8 %29 to i32
  %31 = mul nsw i32 %i.04, 5
  %32 = urem i32 %31, %bufferSize
  %33 = zext i32 %32 to i64
  %34 = getelementptr inbounds i8* %input, i64 %33
  %35 = load i8* %34, align 1, !tbaa !11
  %36 = zext i8 %35 to i32
  %37 = add i32 %12, %tmp.03
  %38 = add i32 %37, %18
  %39 = add i32 %38, %24
  %40 = add i32 %39, %30
  %41 = add i32 %40, %36
  %42 = add nsw i32 %i.04, 1
  %exitcond = icmp eq i32 %42, 5000
  br i1 %exitcond, label %.preheader, label %7

.lr.ph:                                           ; preds = %.preheader, %.lr.ph
  %i1.02 = phi i32 [ %53, %.lr.ph ], [ %5, %.preheader ]
  %43 = zext i32 %i1.02 to i64
  %44 = getelementptr inbounds i8* %input, i64 %43
  %45 = load i8* %44, align 1, !tbaa !11
  %46 = zext i8 %45 to i32
  %47 = mul nsw i32 %46, %multiplier
  %48 = load volatile i32* %zero, align 4
  %49 = mul i32 %48, %41
  %50 = add i32 %47, %49
  %51 = trunc i32 %50 to i8
  %52 = getelementptr inbounds i8* %output, i64 %43
  store i8 %51, i8* %52, align 1, !tbaa !11
  %53 = add i32 %i1.02, %4
  %54 = icmp ult i32 %53, %bufferSize
  br i1 %54, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %.preheader
  ret void
}

declare i64 @get_global_size(i32) #1

declare i64 @get_global_id(i32) #1

declare i64 @get_local_id(i32) #1

; Function Attrs: nounwind uwtable
define void @work2(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier, i8* nocapture %lds) #0 {
  %zero = alloca i32, align 4
  %1 = tail call i64 @get_global_size(i32 0) #2
  %2 = tail call i64 @get_global_id(i32 0) #2
  %3 = tail call i64 @get_local_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %9

.preheader:                                       ; preds = %9
  %4 = trunc i64 %1 to i32
  %5 = trunc i64 %2 to i32
  %6 = icmp ult i32 %5, %bufferSize
  br i1 %6, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.preheader
  %sext = shl i64 %3, 32
  %7 = ashr exact i64 %sext, 32
  %8 = getelementptr inbounds i8* %lds, i64 %7
  br label %46

; <label>:9                                       ; preds = %9, %0
  %i.05 = phi i32 [ 1, %0 ], [ %45, %9 ]
  %tmp.04 = phi i32 [ 1, %0 ], [ %44, %9 ]
  %10 = shl nsw i32 %i.05, 1
  %11 = urem i32 %10, %bufferSize
  %12 = zext i32 %11 to i64
  %13 = getelementptr inbounds i8* %input, i64 %12
  %14 = load i8* %13, align 1, !tbaa !11
  %15 = zext i8 %14 to i32
  %16 = shl nsw i32 %i.05, 2
  %17 = urem i32 %16, %bufferSize
  %18 = zext i32 %17 to i64
  %19 = getelementptr inbounds i8* %input, i64 %18
  %20 = load i8* %19, align 1, !tbaa !11
  %21 = zext i8 %20 to i32
  %22 = mul nsw i32 %i.05, 6
  %23 = urem i32 %22, %bufferSize
  %24 = zext i32 %23 to i64
  %25 = getelementptr inbounds i8* %input, i64 %24
  %26 = load i8* %25, align 1, !tbaa !11
  %27 = zext i8 %26 to i32
  %28 = shl nsw i32 %i.05, 3
  %29 = urem i32 %28, %bufferSize
  %30 = zext i32 %29 to i64
  %31 = getelementptr inbounds i8* %input, i64 %30
  %32 = load i8* %31, align 1, !tbaa !11
  %33 = zext i8 %32 to i32
  %34 = mul nsw i32 %i.05, 10
  %35 = urem i32 %34, %bufferSize
  %36 = zext i32 %35 to i64
  %37 = getelementptr inbounds i8* %input, i64 %36
  %38 = load i8* %37, align 1, !tbaa !11
  %39 = zext i8 %38 to i32
  %40 = add i32 %15, %tmp.04
  %41 = sub i32 %40, %21
  %42 = add i32 %41, %27
  %43 = sub i32 %42, %33
  %44 = add i32 %43, %39
  %45 = add nsw i32 %i.05, 1
  %exitcond = icmp eq i32 %45, 10000
  br i1 %exitcond, label %.preheader, label %9

; <label>:46                                      ; preds = %.lr.ph, %46
  %i1.03 = phi i32 [ %5, %.lr.ph ], [ %57, %46 ]
  %47 = zext i32 %i1.03 to i64
  %48 = getelementptr inbounds i8* %input, i64 %47
  %49 = load i8* %48, align 1, !tbaa !11
  store i8 %49, i8* %8, align 1, !tbaa !11
  %50 = zext i8 %49 to i32
  %51 = mul nsw i32 %50, %multiplier
  %52 = load volatile i32* %zero, align 4
  %53 = mul nsw i32 %52, %44
  %54 = add nsw i32 %51, %53
  %55 = trunc i32 %54 to i8
  %56 = getelementptr inbounds i8* %output, i64 %47
  store i8 %55, i8* %56, align 1, !tbaa !11
  %57 = add i32 %i1.03, %4
  %58 = icmp ult i32 %57, %bufferSize
  br i1 %58, label %46, label %._crit_edge

._crit_edge:                                      ; preds = %46, %.preheader
  ret void
}

; Function Attrs: nounwind uwtable
define void @K1(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work1(i8* %input, i8* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind uwtable
define void @K2(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work2(i8* %input, i8* %output, i32 %bufferSize, i32 %multiplier, i8* getelementptr inbounds ([8192 x i8]* @K2.lds, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @K3(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work1(i8* %input, i8* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind uwtable
define void @K4(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work2(i8* %input, i8* %output, i32 %bufferSize, i32 %multiplier, i8* getelementptr inbounds ([8192 x i8]* @K4.lds, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @K5(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work1(i8* %input, i8* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind uwtable
define void @K6(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work2(i8* %input, i8* %output, i32 %bufferSize, i32 %multiplier, i8* getelementptr inbounds ([8192 x i8]* @K6.lds, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @K7(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work1(i8* %input, i8* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind uwtable
define void @K8(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work2(i8* %input, i8* %output, i32 %bufferSize, i32 %multiplier, i8* getelementptr inbounds ([8192 x i8]* @K8.lds, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @K9(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work1(i8* %input, i8* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind uwtable
define void @K10(i8* nocapture readonly %input, i8* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work2(i8* %input, i8* %output, i32 %bufferSize, i32 %multiplier, i8* getelementptr inbounds ([8192 x i8]* @K10.lds, i64 0, i64 0))
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9}
!llvm.ident = !{!10}

!0 = metadata !{void (i8*, i8*, i32, i32)* @K1}
!1 = metadata !{void (i8*, i8*, i32, i32)* @K2}
!2 = metadata !{void (i8*, i8*, i32, i32)* @K3}
!3 = metadata !{void (i8*, i8*, i32, i32)* @K4}
!4 = metadata !{void (i8*, i8*, i32, i32)* @K5}
!5 = metadata !{void (i8*, i8*, i32, i32)* @K6}
!6 = metadata !{void (i8*, i8*, i32, i32)* @K7}
!7 = metadata !{void (i8*, i8*, i32, i32)* @K8}
!8 = metadata !{void (i8*, i8*, i32, i32)* @K9}
!9 = metadata !{void (i8*, i8*, i32, i32)* @K10}
!10 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!11 = metadata !{metadata !12, metadata !12, i64 0}
!12 = metadata !{metadata !"omnipotent char", metadata !13, i64 0}
!13 = metadata !{metadata !"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/ConcurrentKernel_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@K2.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K4.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K6.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K8.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K10.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1

; Function Attrs: nounwind
define void @work1(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  %zero = alloca i32, align 4
  %1 = tail call i32 @get_global_size(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_local_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %5

.preheader:                                       ; preds = %5
  %4 = icmp ult i32 %2, %bufferSize
  br i1 %4, label %.lr.ph, label %._crit_edge

; <label>:5                                       ; preds = %5, %0
  %i.04 = phi i32 [ 1, %0 ], [ %40, %5 ]
  %tmp.03 = phi i32 [ 1, %0 ], [ %39, %5 ]
  %6 = urem i32 %i.04, %bufferSize
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds i8 addrspace(1)* %input, i64 %7
  %9 = load i8 addrspace(1)* %8, align 1, !tbaa !11
  %10 = zext i8 %9 to i32
  %11 = shl nsw i32 %i.04, 1
  %12 = urem i32 %11, %bufferSize
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds i8 addrspace(1)* %input, i64 %13
  %15 = load i8 addrspace(1)* %14, align 1, !tbaa !11
  %16 = zext i8 %15 to i32
  %17 = mul nsw i32 %i.04, 3
  %18 = urem i32 %17, %bufferSize
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds i8 addrspace(1)* %input, i64 %19
  %21 = load i8 addrspace(1)* %20, align 1, !tbaa !11
  %22 = zext i8 %21 to i32
  %23 = shl nsw i32 %i.04, 2
  %24 = urem i32 %23, %bufferSize
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i8 addrspace(1)* %input, i64 %25
  %27 = load i8 addrspace(1)* %26, align 1, !tbaa !11
  %28 = zext i8 %27 to i32
  %29 = mul nsw i32 %i.04, 5
  %30 = urem i32 %29, %bufferSize
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds i8 addrspace(1)* %input, i64 %31
  %33 = load i8 addrspace(1)* %32, align 1, !tbaa !11
  %34 = zext i8 %33 to i32
  %35 = add i32 %10, %tmp.03
  %36 = add i32 %35, %16
  %37 = add i32 %36, %22
  %38 = add i32 %37, %28
  %39 = add i32 %38, %34
  %40 = add nsw i32 %i.04, 1
  %exitcond = icmp eq i32 %40, 5000
  br i1 %exitcond, label %.preheader, label %5

.lr.ph:                                           ; preds = %.preheader, %.lr.ph
  %i1.02 = phi i32 [ %51, %.lr.ph ], [ %2, %.preheader ]
  %41 = sext i32 %i1.02 to i64
  %42 = getelementptr inbounds i8 addrspace(1)* %input, i64 %41
  %43 = load i8 addrspace(1)* %42, align 1, !tbaa !11
  %44 = zext i8 %43 to i32
  %45 = mul nsw i32 %44, %multiplier
  %46 = load volatile i32* %zero, align 4
  %47 = mul i32 %46, %39
  %48 = add i32 %45, %47
  %49 = trunc i32 %48 to i8
  %50 = getelementptr inbounds i8 addrspace(1)* %output, i64 %41
  store i8 %49, i8 addrspace(1)* %50, align 1, !tbaa !11
  %51 = add i32 %i1.02, %1
  %52 = icmp ult i32 %51, %bufferSize
  br i1 %52, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %.preheader
  ret void
}

declare i32 @get_global_size(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define void @work2(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* nocapture %lds) #0 {
  %zero = alloca i32, align 4
  %1 = tail call i32 @get_global_size(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_local_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %6

.preheader:                                       ; preds = %6
  %4 = icmp ult i32 %2, %bufferSize
  br i1 %4, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.preheader
  %5 = getelementptr inbounds i8 addrspace(3)* %lds, i32 %3
  br label %43

; <label>:6                                       ; preds = %6, %0
  %i.05 = phi i32 [ 1, %0 ], [ %42, %6 ]
  %tmp.04 = phi i32 [ 1, %0 ], [ %41, %6 ]
  %7 = shl nsw i32 %i.05, 1
  %8 = urem i32 %7, %bufferSize
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds i8 addrspace(1)* %input, i64 %9
  %11 = load i8 addrspace(1)* %10, align 1, !tbaa !11
  %12 = zext i8 %11 to i32
  %13 = shl nsw i32 %i.05, 2
  %14 = urem i32 %13, %bufferSize
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i8 addrspace(1)* %input, i64 %15
  %17 = load i8 addrspace(1)* %16, align 1, !tbaa !11
  %18 = zext i8 %17 to i32
  %19 = mul nsw i32 %i.05, 6
  %20 = urem i32 %19, %bufferSize
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds i8 addrspace(1)* %input, i64 %21
  %23 = load i8 addrspace(1)* %22, align 1, !tbaa !11
  %24 = zext i8 %23 to i32
  %25 = shl nsw i32 %i.05, 3
  %26 = urem i32 %25, %bufferSize
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds i8 addrspace(1)* %input, i64 %27
  %29 = load i8 addrspace(1)* %28, align 1, !tbaa !11
  %30 = zext i8 %29 to i32
  %31 = mul nsw i32 %i.05, 10
  %32 = urem i32 %31, %bufferSize
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds i8 addrspace(1)* %input, i64 %33
  %35 = load i8 addrspace(1)* %34, align 1, !tbaa !11
  %36 = zext i8 %35 to i32
  %37 = add i32 %12, %tmp.04
  %38 = sub i32 %37, %18
  %39 = add i32 %38, %24
  %40 = sub i32 %39, %30
  %41 = add i32 %40, %36
  %42 = add nsw i32 %i.05, 1
  %exitcond = icmp eq i32 %42, 10000
  br i1 %exitcond, label %.preheader, label %6

; <label>:43                                      ; preds = %.lr.ph, %43
  %i1.03 = phi i32 [ %2, %.lr.ph ], [ %54, %43 ]
  %44 = sext i32 %i1.03 to i64
  %45 = getelementptr inbounds i8 addrspace(1)* %input, i64 %44
  %46 = load i8 addrspace(1)* %45, align 1, !tbaa !11
  store i8 %46, i8 addrspace(3)* %5, align 1, !tbaa !11
  %47 = zext i8 %46 to i32
  %48 = mul nsw i32 %47, %multiplier
  %49 = load volatile i32* %zero, align 4
  %50 = mul nsw i32 %49, %41
  %51 = add nsw i32 %48, %50
  %52 = trunc i32 %51 to i8
  %53 = getelementptr inbounds i8 addrspace(1)* %output, i64 %44
  store i8 %52, i8 addrspace(1)* %53, align 1, !tbaa !11
  %54 = add i32 %i1.03, %1
  %55 = icmp ult i32 %54, %bufferSize
  br i1 %55, label %43, label %._crit_edge

._crit_edge:                                      ; preds = %43, %.preheader
  ret void
}

; Function Attrs: nounwind
define void @K1(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K2(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K2.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K3(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K4(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K4.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K5(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K6(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K6.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K7(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K8(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K8.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K9(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K10(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  tail call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K10.lds, i32 0, i32 0))
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9}
!llvm.ident = !{!10}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K1}
!1 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K2}
!2 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K3}
!3 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K4}
!4 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K5}
!5 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K6}
!6 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K7}
!7 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K8}
!8 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K9}
!9 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K10}
!10 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!11 = metadata !{metadata !12, metadata !12, i64 0}
!12 = metadata !{metadata !"omnipotent char", metadata !13, i64 0}
!13 = metadata !{metadata !"Simple C/C++ TBAA"}

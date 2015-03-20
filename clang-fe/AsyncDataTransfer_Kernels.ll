; ModuleID = '../kernel-src/AsyncDataTransfer_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @work(i8* nocapture readonly %input, i8* nocapture %output, i32 %multiplier) #0 {
  %zero = alloca i32, align 4
  %1 = tail call i64 @get_global_size(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %4

; <label>:4                                       ; preds = %4, %0
  %i.02 = phi i32 [ 5, %0 ], [ %39, %4 ]
  %tmp.01 = phi i32 [ 1, %0 ], [ %38, %4 ]
  %5 = srem i32 %i.02, %2
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds i8* %input, i64 %6
  %8 = load i8* %7, align 1, !tbaa !2
  %9 = zext i8 %8 to i32
  %10 = shl nsw i32 %i.02, 1
  %11 = srem i32 %10, %2
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds i8* %input, i64 %12
  %14 = load i8* %13, align 1, !tbaa !2
  %15 = zext i8 %14 to i32
  %16 = mul nsw i32 %i.02, 3
  %17 = srem i32 %16, %2
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds i8* %input, i64 %18
  %20 = load i8* %19, align 1, !tbaa !2
  %21 = zext i8 %20 to i32
  %22 = shl nsw i32 %i.02, 2
  %23 = srem i32 %22, %2
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds i8* %input, i64 %24
  %26 = load i8* %25, align 1, !tbaa !2
  %27 = zext i8 %26 to i32
  %28 = mul nsw i32 %i.02, 5
  %29 = srem i32 %28, %2
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds i8* %input, i64 %30
  %32 = load i8* %31, align 1, !tbaa !2
  %33 = zext i8 %32 to i32
  %34 = add i32 %9, %tmp.01
  %35 = add i32 %34, %15
  %36 = add i32 %35, %21
  %37 = add i32 %36, %27
  %38 = add i32 %37, %33
  %39 = add nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %39, 100
  br i1 %exitcond, label %40, label %4

; <label>:40                                      ; preds = %4
  %sext = shl i64 %3, 32
  %41 = ashr exact i64 %sext, 32
  %42 = getelementptr inbounds i8* %input, i64 %41
  %43 = load i8* %42, align 1, !tbaa !2
  %44 = zext i8 %43 to i32
  %45 = mul nsw i32 %44, %multiplier
  %46 = load volatile i32* %zero, align 4
  %47 = mul i32 %46, %38
  %48 = add i32 %45, %47
  %49 = trunc i32 %48 to i8
  %50 = getelementptr inbounds i8* %output, i64 %41
  store i8 %49, i8* %50, align 1, !tbaa !2
  ret void
}

declare i64 @get_global_size(i32) #1

declare i64 @get_global_id(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i8*, i8*, i32)* @work}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

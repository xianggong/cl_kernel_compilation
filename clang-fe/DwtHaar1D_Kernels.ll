; ModuleID = '../kernel-src/DwtHaar1D_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @dwtHaar1D(float* nocapture readonly %inSignal, float* nocapture %coefsSignal, float* nocapture %AverageSignal, float* nocapture %sharedArray, i32 %tLevels, i32 %signalLength, i32 %levelsDone, i32 %mLevels) #0 {
  %1 = tail call i64 @get_local_id(i32 0) #3
  %2 = tail call i64 @get_group_id(i32 0) #3
  %3 = tail call i64 @get_global_id(i32 0) #3
  %4 = tail call i64 @get_local_size(i32 0) #3
  %5 = shl i64 %2, 1
  %6 = mul i64 %5, %4
  %7 = add i64 %6, %1
  %8 = getelementptr inbounds float* %inSignal, i64 %7
  %9 = load float* %8, align 4, !tbaa !2
  %10 = add i64 %4, %1
  %11 = add i64 %10, %6
  %12 = getelementptr inbounds float* %inSignal, i64 %11
  %13 = load float* %12, align 4, !tbaa !2
  %14 = icmp eq i32 %levelsDone, 0
  br i1 %14, label %15, label %21

; <label>:15                                      ; preds = %0
  %16 = uitofp i32 %signalLength to float
  %17 = tail call float @llvm.sqrt.f32(float %16)
  %18 = fdiv float 1.000000e+00, %17, !fpmath !6
  %19 = fmul float %9, %18
  %20 = fmul float %13, %18
  br label %21

; <label>:21                                      ; preds = %15, %0
  %t1.0 = phi float [ %20, %15 ], [ %13, %0 ]
  %t0.0 = phi float [ %19, %15 ], [ %9, %0 ]
  %22 = getelementptr inbounds float* %sharedArray, i64 %1
  store float %t0.0, float* %22, align 4, !tbaa !2
  %23 = getelementptr inbounds float* %sharedArray, i64 %10
  store float %t1.0, float* %23, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  %24 = icmp ugt i32 %tLevels, %mLevels
  %25 = select i1 %24, i32 %mLevels, i32 %tLevels
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %21
  %27 = and i32 %25, 31
  %28 = shl i32 1, %27
  %29 = lshr i32 %signalLength, 1
  %30 = sdiv i32 %28, 2
  %31 = shl i64 %1, 1
  %32 = getelementptr inbounds float* %sharedArray, i64 %31
  %33 = or i64 %31, 1
  %34 = getelementptr inbounds float* %sharedArray, i64 %33
  %35 = xor i32 %mLevels, -1
  %36 = xor i32 %tLevels, -1
  %37 = icmp ugt i32 %35, %36
  %umax = select i1 %37, i32 %35, i32 %36
  %38 = xor i32 %umax, -1
  br label %39

; <label>:39                                      ; preds = %56, %.lr.ph
  %i.08 = phi i32 [ 0, %.lr.ph ], [ %58, %56 ]
  %midOutPos.07 = phi i32 [ %29, %.lr.ph ], [ %midOutPos.1, %56 ]
  %activeThreads.06 = phi i32 [ %30, %.lr.ph ], [ %57, %56 ]
  %40 = zext i32 %activeThreads.06 to i64
  %41 = icmp ult i64 %1, %40
  br i1 %41, label %42, label %.thread5

.thread5:                                         ; preds = %39
  tail call void @barrier(i32 1) #3
  br label %56

; <label>:42                                      ; preds = %39
  %43 = load float* %32, align 4, !tbaa !2
  %44 = load float* %34, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  %45 = fadd float %43, %44
  %46 = fmul float %45, 0x3FE6A09E60000000
  store float %46, float* %22, align 4, !tbaa !2
  %47 = zext i32 %midOutPos.07 to i64
  %48 = mul i64 %40, %2
  %49 = add i64 %48, %1
  %50 = add i64 %49, %47
  %51 = fsub float %43, %44
  %52 = fmul float %51, 0x3FE6A09E60000000
  %53 = and i64 %50, 4294967295
  %54 = getelementptr inbounds float* %coefsSignal, i64 %53
  store float %52, float* %54, align 4, !tbaa !2
  %55 = lshr i32 %midOutPos.07, 1
  br label %56

; <label>:56                                      ; preds = %.thread5, %42
  %midOutPos.1 = phi i32 [ %55, %42 ], [ %midOutPos.07, %.thread5 ]
  %57 = lshr i32 %activeThreads.06, 1
  tail call void @barrier(i32 1) #3
  %58 = add i32 %i.08, 1
  %exitcond = icmp eq i32 %58, %38
  br i1 %exitcond, label %._crit_edge, label %39

._crit_edge:                                      ; preds = %56, %21
  %59 = icmp eq i64 %1, 0
  br i1 %59, label %60, label %63

; <label>:60                                      ; preds = %._crit_edge
  %61 = load float* %sharedArray, align 4, !tbaa !2
  %62 = getelementptr inbounds float* %AverageSignal, i64 %2
  store float %61, float* %62, align 4, !tbaa !2
  br label %63

; <label>:63                                      ; preds = %60, %._crit_edge
  ret void
}

declare i64 @get_local_id(i32) #1

declare i64 @get_group_id(i32) #1

declare i64 @get_global_id(i32) #1

declare i64 @get_local_size(i32) #1

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float*, float*, float*, float*, i32, i32, i32, i32)* @dwtHaar1D}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{float 2.500000e+00}

; ModuleID = '../kernel-src/DwtHaar1D_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @dwtHaar1D(float addrspace(1)* nocapture readonly %inSignal, float addrspace(1)* nocapture %coefsSignal, float addrspace(1)* nocapture %AverageSignal, float addrspace(3)* nocapture %sharedArray, i32 %tLevels, i32 %signalLength, i32 %levelsDone, i32 %mLevels) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #3
  %2 = tail call i32 @get_group_id(i32 0) #3
  %3 = tail call i32 @get_global_id(i32 0) #3
  %4 = tail call i32 @get_local_size(i32 0) #3
  %5 = shl i32 %2, 1
  %6 = mul i32 %5, %4
  %7 = add i32 %6, %1
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds float addrspace(1)* %inSignal, i64 %8
  %10 = load float addrspace(1)* %9, align 4, !tbaa !2
  %11 = add i32 %4, %1
  %12 = add i32 %11, %6
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds float addrspace(1)* %inSignal, i64 %13
  %15 = load float addrspace(1)* %14, align 4, !tbaa !2
  %16 = icmp eq i32 %levelsDone, 0
  br i1 %16, label %17, label %23

; <label>:17                                      ; preds = %0
  %18 = uitofp i32 %signalLength to float
  %19 = tail call float @llvm.sqrt.f32(float %18)
  %20 = fdiv float 1.000000e+00, %19, !fpmath !6
  %21 = fmul float %10, %20
  %22 = fmul float %15, %20
  br label %23

; <label>:23                                      ; preds = %17, %0
  %t1.0 = phi float [ %22, %17 ], [ %15, %0 ]
  %t0.0 = phi float [ %21, %17 ], [ %10, %0 ]
  %24 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %1
  store float %t0.0, float addrspace(3)* %24, align 4, !tbaa !2
  %25 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %11
  store float %t1.0, float addrspace(3)* %25, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  %26 = icmp ugt i32 %tLevels, %mLevels
  %27 = select i1 %26, i32 %mLevels, i32 %tLevels
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %23
  %29 = and i32 %27, 31
  %30 = shl i32 1, %29
  %31 = lshr i32 %signalLength, 1
  %32 = sdiv i32 %30, 2
  %33 = shl i32 %1, 1
  %34 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %33
  %35 = or i32 %33, 1
  %36 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %35
  %37 = xor i32 %mLevels, -1
  %38 = xor i32 %tLevels, -1
  %39 = icmp ugt i32 %37, %38
  %umax = select i1 %39, i32 %37, i32 %38
  %40 = xor i32 %umax, -1
  br label %41

; <label>:41                                      ; preds = %56, %.lr.ph
  %i.08 = phi i32 [ 0, %.lr.ph ], [ %58, %56 ]
  %midOutPos.07 = phi i32 [ %31, %.lr.ph ], [ %midOutPos.1, %56 ]
  %activeThreads.06 = phi i32 [ %32, %.lr.ph ], [ %57, %56 ]
  %42 = icmp ult i32 %1, %activeThreads.06
  br i1 %42, label %43, label %.thread5

.thread5:                                         ; preds = %41
  tail call void @barrier(i32 1) #3
  br label %56

; <label>:43                                      ; preds = %41
  %44 = load float addrspace(3)* %34, align 4, !tbaa !2
  %45 = load float addrspace(3)* %36, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  %46 = fadd float %44, %45
  %47 = fmul float %46, 0x3FE6A09E60000000
  store float %47, float addrspace(3)* %24, align 4, !tbaa !2
  %48 = mul i32 %activeThreads.06, %2
  %49 = add i32 %48, %1
  %50 = add i32 %49, %midOutPos.07
  %51 = fsub float %44, %45
  %52 = fmul float %51, 0x3FE6A09E60000000
  %53 = sext i32 %50 to i64
  %54 = getelementptr inbounds float addrspace(1)* %coefsSignal, i64 %53
  store float %52, float addrspace(1)* %54, align 4, !tbaa !2
  %55 = lshr i32 %midOutPos.07, 1
  br label %56

; <label>:56                                      ; preds = %.thread5, %43
  %midOutPos.1 = phi i32 [ %55, %43 ], [ %midOutPos.07, %.thread5 ]
  %57 = lshr i32 %activeThreads.06, 1
  tail call void @barrier(i32 1) #3
  %58 = add i32 %i.08, 1
  %exitcond = icmp eq i32 %58, %40
  br i1 %exitcond, label %._crit_edge, label %41

._crit_edge:                                      ; preds = %56, %23
  %59 = icmp eq i32 %1, 0
  br i1 %59, label %60, label %64

; <label>:60                                      ; preds = %._crit_edge
  %61 = load float addrspace(3)* %sharedArray, align 4, !tbaa !2
  %62 = sext i32 %2 to i64
  %63 = getelementptr inbounds float addrspace(1)* %AverageSignal, i64 %62
  store float %61, float addrspace(1)* %63, align 4, !tbaa !2
  br label %64

; <label>:64                                      ; preds = %60, %._crit_edge
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_local_size(i32) #1

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32, i32)* @dwtHaar1D}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{float 2.500000e+00}

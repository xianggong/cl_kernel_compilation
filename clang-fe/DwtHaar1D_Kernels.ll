; ModuleID = '../kernel-src/DwtHaar1D_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @dwtHaar1D(float addrspace(1)* nocapture readonly %inSignal, float addrspace(1)* nocapture %coefsSignal, float addrspace(1)* nocapture %AverageSignal, float addrspace(3)* nocapture %sharedArray, i32 %tLevels, i32 %signalLength, i32 %levelsDone, i32 %mLevels) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #3
  %2 = tail call i32 @get_group_id(i32 0) #3
  %3 = tail call i32 @get_global_id(i32 0) #3
  %4 = tail call i32 @get_local_size(i32 0) #3
  %5 = shl i32 %2, 1
  %6 = mul i32 %5, %4
  %7 = add i32 %6, %1
  %8 = getelementptr inbounds float addrspace(1)* %inSignal, i32 %7
  %9 = load float addrspace(1)* %8, align 4, !tbaa !7
  %10 = add i32 %4, %1
  %11 = add i32 %10, %6
  %12 = getelementptr inbounds float addrspace(1)* %inSignal, i32 %11
  %13 = load float addrspace(1)* %12, align 4, !tbaa !7
  %14 = icmp eq i32 %levelsDone, 0
  br i1 %14, label %15, label %21

; <label>:15                                      ; preds = %0
  %16 = uitofp i32 %signalLength to float
  %17 = tail call float @llvm.sqrt.f32(float %16)
  %18 = fdiv float 1.000000e+00, %17, !fpmath !11
  %19 = fmul float %9, %18
  %20 = fmul float %13, %18
  br label %21

; <label>:21                                      ; preds = %15, %0
  %t1.0 = phi float [ %20, %15 ], [ %13, %0 ]
  %t0.0 = phi float [ %19, %15 ], [ %9, %0 ]
  %22 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %1
  store float %t0.0, float addrspace(3)* %22, align 4, !tbaa !7
  %23 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %10
  store float %t1.0, float addrspace(3)* %23, align 4, !tbaa !7
  tail call void @barrier(i32 1) #3
  %24 = icmp ugt i32 %tLevels, %mLevels
  %25 = select i1 %24, i32 %mLevels, i32 %tLevels
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %21
  %27 = lshr i32 %signalLength, 1
  %28 = and i32 %25, 31
  %29 = shl i32 1, %28
  %30 = sdiv i32 %29, 2
  %31 = shl i32 %1, 1
  %32 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %31
  %33 = or i32 %31, 1
  %34 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %33
  %35 = xor i32 %mLevels, -1
  %36 = xor i32 %tLevels, -1
  %37 = icmp ugt i32 %35, %36
  %umax = select i1 %37, i32 %35, i32 %36
  %38 = xor i32 %umax, -1
  br label %39

; <label>:39                                      ; preds = %53, %.lr.ph
  %i.08 = phi i32 [ 0, %.lr.ph ], [ %55, %53 ]
  %midOutPos.07 = phi i32 [ %27, %.lr.ph ], [ %midOutPos.1, %53 ]
  %activeThreads.06 = phi i32 [ %30, %.lr.ph ], [ %54, %53 ]
  %40 = icmp ult i32 %1, %activeThreads.06
  br i1 %40, label %41, label %.thread5

.thread5:                                         ; preds = %39
  tail call void @barrier(i32 1) #3
  br label %53

; <label>:41                                      ; preds = %39
  %42 = load float addrspace(3)* %32, align 4, !tbaa !7
  %43 = load float addrspace(3)* %34, align 4, !tbaa !7
  tail call void @barrier(i32 1) #3
  %44 = fadd float %42, %43
  %45 = fmul float %44, 0x3FE6A09E60000000
  store float %45, float addrspace(3)* %22, align 4, !tbaa !7
  %46 = mul i32 %activeThreads.06, %2
  %47 = add i32 %46, %1
  %48 = add i32 %47, %midOutPos.07
  %49 = fsub float %42, %43
  %50 = fmul float %49, 0x3FE6A09E60000000
  %51 = getelementptr inbounds float addrspace(1)* %coefsSignal, i32 %48
  store float %50, float addrspace(1)* %51, align 4, !tbaa !7
  %52 = lshr i32 %midOutPos.07, 1
  br label %53

; <label>:53                                      ; preds = %.thread5, %41
  %midOutPos.1 = phi i32 [ %52, %41 ], [ %midOutPos.07, %.thread5 ]
  %54 = lshr i32 %activeThreads.06, 1
  tail call void @barrier(i32 1) #3
  %55 = add nuw i32 %i.08, 1
  %exitcond = icmp eq i32 %55, %38
  br i1 %exitcond, label %._crit_edge.loopexit, label %39

._crit_edge.loopexit:                             ; preds = %53
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %21
  %56 = icmp eq i32 %1, 0
  br i1 %56, label %57, label %60

; <label>:57                                      ; preds = %._crit_edge
  %58 = load float addrspace(3)* %sharedArray, align 4, !tbaa !7
  %59 = getelementptr inbounds float addrspace(1)* %AverageSignal, i32 %2
  store float %58, float addrspace(1)* %59, align 4, !tbaa !7
  br label %60

; <label>:60                                      ; preds = %57, %._crit_edge
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_local_size(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.sqrt.f32(float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32, i32)* @dwtHaar1D, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 3, i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"float*", !"float*", !"uint", !"uint", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*", !"float*", !"uint", !"uint", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"", !"", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"float", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{float 2.500000e+00}

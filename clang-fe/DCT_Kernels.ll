; ModuleID = '../kernel-src/DCT_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind readnone
define i32 @getIdx(i32 %blockIdx, i32 %blockIdy, i32 %localIdx, i32 %localIdy, i32 %blockWidth, i32 %globalWidth) #0 {
  %1 = mul i32 %blockWidth, %blockIdx
  %2 = add i32 %1, %localIdx
  %3 = mul i32 %blockWidth, %blockIdy
  %4 = add i32 %3, %localIdy
  %5 = mul i32 %4, %globalWidth
  %6 = add i32 %2, %5
  ret i32 %6
}

; Function Attrs: nounwind
define void @DCT(float addrspace(1)* nocapture %output, float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture readonly %dct8x8, float addrspace(1)* nocapture readonly %dct8x8_trans, float addrspace(3)* nocapture %inter, i32 %width, i32 %blockWidth, i32 %inverse) #1 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = tail call i32 @get_group_id(i32 0) #3
  %4 = tail call i32 @get_group_id(i32 1) #3
  %5 = tail call i32 @get_local_id(i32 0) #3
  %6 = tail call i32 @get_local_id(i32 1) #3
  %7 = mul i32 %2, %width
  %8 = add i32 %7, %1
  %9 = icmp eq i32 %blockWidth, 0
  %10 = mul i32 %6, %blockWidth
  br i1 %9, label %._crit_edge.critedge, label %.lr.ph11

.lr.ph11:                                         ; preds = %0
  %11 = mul i32 %3, %blockWidth
  %12 = add i32 %5, %11
  %13 = mul i32 %4, %blockWidth
  %14 = icmp eq i32 %inverse, 0
  br label %15

; <label>:15                                      ; preds = %35, %.lr.ph11
  %acc.09 = phi float [ 0.000000e+00, %.lr.ph11 ], [ %acc.1, %35 ]
  %k.08 = phi i32 [ 0, %.lr.ph11 ], [ %36, %35 ]
  %16 = add i32 %k.08, %10
  %17 = add i32 %k.08, %13
  %18 = mul i32 %17, %width
  %19 = add i32 %12, %18
  %20 = sext i32 %16 to i64
  br i1 %14, label %28, label %21

; <label>:21                                      ; preds = %15
  %22 = getelementptr inbounds float addrspace(1)* %dct8x8, i64 %20
  %23 = load float addrspace(1)* %22, align 4, !tbaa !2
  %24 = sext i32 %19 to i64
  %25 = getelementptr inbounds float addrspace(1)* %input, i64 %24
  %26 = load float addrspace(1)* %25, align 4, !tbaa !2
  %27 = fmul float %23, %26
  br label %35

; <label>:28                                      ; preds = %15
  %29 = getelementptr inbounds float addrspace(1)* %dct8x8_trans, i64 %20
  %30 = load float addrspace(1)* %29, align 4, !tbaa !2
  %31 = sext i32 %19 to i64
  %32 = getelementptr inbounds float addrspace(1)* %input, i64 %31
  %33 = load float addrspace(1)* %32, align 4, !tbaa !2
  %34 = fmul float %30, %33
  br label %35

; <label>:35                                      ; preds = %21, %28
  %.pn4 = phi float [ %27, %21 ], [ %34, %28 ]
  %acc.1 = fadd float %acc.09, %.pn4
  %36 = add i32 %k.08, 1
  %exitcond15 = icmp eq i32 %36, %blockWidth
  br i1 %exitcond15, label %._crit_edge12, label %15

._crit_edge12:                                    ; preds = %35
  %37 = add i32 %10, %5
  %38 = getelementptr inbounds float addrspace(3)* %inter, i32 %37
  store float %acc.1, float addrspace(3)* %38, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  br i1 %9, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %._crit_edge12
  %39 = icmp eq i32 %inverse, 0
  %dct8x8_trans.sink = select i1 %39, float addrspace(1)* %dct8x8, float addrspace(1)* %dct8x8_trans
  br label %40

; <label>:40                                      ; preds = %40, %.lr.ph
  %acc.27 = phi float [ 0.000000e+00, %.lr.ph ], [ %acc.3, %40 ]
  %k1.06 = phi i32 [ 0, %.lr.ph ], [ %48, %40 ]
  %41 = add i32 %k1.06, %10
  %42 = mul i32 %k1.06, %blockWidth
  %43 = add i32 %42, %5
  %44 = getelementptr inbounds float addrspace(3)* %inter, i32 %41
  %45 = load float addrspace(3)* %44, align 4, !tbaa !2
  %46 = sext i32 %43 to i64
  %47 = getelementptr inbounds float addrspace(1)* %dct8x8_trans.sink, i64 %46
  %.pn5 = load float addrspace(1)* %47, align 4
  %.pn = fmul float %45, %.pn5
  %acc.3 = fadd float %acc.27, %.pn
  %48 = add i32 %k1.06, 1
  %exitcond = icmp eq i32 %48, %blockWidth
  br i1 %exitcond, label %._crit_edge, label %40

._crit_edge.critedge:                             ; preds = %0
  %49 = add i32 %10, %5
  %50 = getelementptr inbounds float addrspace(3)* %inter, i32 %49
  store float 0.000000e+00, float addrspace(3)* %50, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.critedge, %40, %._crit_edge12
  %acc.2.lcssa = phi float [ 0.000000e+00, %._crit_edge12 ], [ %acc.3, %40 ], [ 0.000000e+00, %._crit_edge.critedge ]
  %51 = sext i32 %8 to i64
  %52 = getelementptr inbounds float addrspace(1)* %output, i64 %51
  store float %acc.2.lcssa, float addrspace(1)* %52, align 4, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #2

declare i32 @get_group_id(i32) #2

declare i32 @get_local_id(i32) #2

declare void @barrier(i32) #2

attributes #0 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32)* @DCT}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

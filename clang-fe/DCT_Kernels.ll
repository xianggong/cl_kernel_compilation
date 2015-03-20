; ModuleID = '../kernel-src/DCT_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind readnone uwtable
define i32 @getIdx(i32 %blockIdx, i32 %blockIdy, i32 %localIdx, i32 %localIdy, i32 %blockWidth, i32 %globalWidth) #0 {
  %1 = mul i32 %blockWidth, %blockIdx
  %2 = add i32 %1, %localIdx
  %3 = mul i32 %blockWidth, %blockIdy
  %4 = add i32 %3, %localIdy
  %5 = mul i32 %4, %globalWidth
  %6 = add i32 %2, %5
  ret i32 %6
}

; Function Attrs: nounwind uwtable
define void @DCT(float* nocapture %output, float* nocapture readonly %input, float* nocapture readonly %dct8x8, float* nocapture readonly %dct8x8_trans, float* nocapture %inter, i32 %width, i32 %blockWidth, i32 %inverse) #1 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_group_id(i32 0) #3
  %6 = tail call i64 @get_group_id(i32 1) #3
  %7 = tail call i64 @get_local_id(i32 0) #3
  %8 = trunc i64 %7 to i32
  %9 = tail call i64 @get_local_id(i32 1) #3
  %10 = trunc i64 %9 to i32
  %11 = mul i32 %4, %width
  %12 = add i32 %11, %2
  %13 = icmp eq i32 %blockWidth, 0
  %14 = mul i32 %10, %blockWidth
  br i1 %13, label %._crit_edge.critedge, label %.lr.ph11

.lr.ph11:                                         ; preds = %0
  %15 = trunc i64 %6 to i32
  %16 = trunc i64 %5 to i32
  %17 = mul i32 %16, %blockWidth
  %18 = add i32 %8, %17
  %19 = mul i32 %15, %blockWidth
  %20 = icmp eq i32 %inverse, 0
  br label %21

; <label>:21                                      ; preds = %42, %.lr.ph11
  %indvars.iv15 = phi i64 [ 0, %.lr.ph11 ], [ %indvars.iv.next16, %42 ]
  %acc.09 = phi float [ 0.000000e+00, %.lr.ph11 ], [ %acc.1, %42 ]
  %22 = trunc i64 %indvars.iv15 to i32
  %23 = add i32 %22, %14
  %24 = add i32 %22, %19
  %25 = mul i32 %24, %width
  %26 = add i32 %18, %25
  %27 = zext i32 %23 to i64
  br i1 %20, label %35, label %28

; <label>:28                                      ; preds = %21
  %29 = getelementptr inbounds float* %dct8x8, i64 %27
  %30 = load float* %29, align 4, !tbaa !2
  %31 = zext i32 %26 to i64
  %32 = getelementptr inbounds float* %input, i64 %31
  %33 = load float* %32, align 4, !tbaa !2
  %34 = fmul float %30, %33
  br label %42

; <label>:35                                      ; preds = %21
  %36 = getelementptr inbounds float* %dct8x8_trans, i64 %27
  %37 = load float* %36, align 4, !tbaa !2
  %38 = zext i32 %26 to i64
  %39 = getelementptr inbounds float* %input, i64 %38
  %40 = load float* %39, align 4, !tbaa !2
  %41 = fmul float %37, %40
  br label %42

; <label>:42                                      ; preds = %28, %35
  %.pn4 = phi float [ %34, %28 ], [ %41, %35 ]
  %acc.1 = fadd float %acc.09, %.pn4
  %indvars.iv.next16 = add nuw nsw i64 %indvars.iv15, 1
  %lftr.wideiv17 = trunc i64 %indvars.iv.next16 to i32
  %exitcond18 = icmp eq i32 %lftr.wideiv17, %blockWidth
  br i1 %exitcond18, label %._crit_edge12, label %21

._crit_edge12:                                    ; preds = %42
  %43 = add i32 %14, %8
  %44 = zext i32 %43 to i64
  %45 = getelementptr inbounds float* %inter, i64 %44
  store float %acc.1, float* %45, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  br i1 %13, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %._crit_edge12
  %46 = icmp eq i32 %inverse, 0
  %dct8x8.dct8x8_trans = select i1 %46, float* %dct8x8, float* %dct8x8_trans
  br label %47

; <label>:47                                      ; preds = %47, %.lr.ph
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %47 ]
  %acc.27 = phi float [ 0.000000e+00, %.lr.ph ], [ %acc.3, %47 ]
  %48 = trunc i64 %indvars.iv to i32
  %49 = add i32 %48, %14
  %50 = mul i32 %48, %blockWidth
  %51 = add i32 %50, %8
  %52 = zext i32 %49 to i64
  %53 = getelementptr inbounds float* %inter, i64 %52
  %54 = load float* %53, align 4, !tbaa !2
  %55 = zext i32 %51 to i64
  %.pn5.in = getelementptr inbounds float* %dct8x8.dct8x8_trans, i64 %55
  %.pn5 = load float* %.pn5.in, align 4
  %.pn = fmul float %54, %.pn5
  %acc.3 = fadd float %acc.27, %.pn
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %blockWidth
  br i1 %exitcond, label %._crit_edge, label %47

._crit_edge.critedge:                             ; preds = %0
  %56 = add i32 %14, %8
  %57 = zext i32 %56 to i64
  %58 = getelementptr inbounds float* %inter, i64 %57
  store float 0.000000e+00, float* %58, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.critedge, %47, %._crit_edge12
  %acc.2.lcssa = phi float [ 0.000000e+00, %._crit_edge12 ], [ %acc.3, %47 ], [ 0.000000e+00, %._crit_edge.critedge ]
  %59 = zext i32 %12 to i64
  %60 = getelementptr inbounds float* %output, i64 %59
  store float %acc.2.lcssa, float* %60, align 4, !tbaa !2
  ret void
}

declare i64 @get_global_id(i32) #2

declare i64 @get_group_id(i32) #2

declare i64 @get_local_id(i32) #2

declare void @barrier(i32) #2

attributes #0 = { nounwind readnone uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float*, float*, float*, float*, float*, i32, i32, i32)* @DCT}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

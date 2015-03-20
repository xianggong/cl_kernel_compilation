; ModuleID = '../kernel-src/DCT_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

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

; <label>:15                                      ; preds = %15, %.lr.ph11
  %acc.09 = phi float [ 0.000000e+00, %.lr.ph11 ], [ %acc.1, %15 ]
  %k.08 = phi i32 [ 0, %.lr.ph11 ], [ %22, %15 ]
  %16 = add i32 %k.08, %10
  %17 = add i32 %k.08, %13
  %18 = mul i32 %17, %width
  %19 = add i32 %12, %18
  %20 = getelementptr inbounds float addrspace(1)* %input, i32 %19
  %21 = load float addrspace(1)* %20, align 4
  %dct8x8_trans.dct8x8 = select i1 %14, float addrspace(1)* %dct8x8_trans, float addrspace(1)* %dct8x8
  %.pn16.in = getelementptr inbounds float addrspace(1)* %dct8x8_trans.dct8x8, i32 %16
  %.pn16 = load float addrspace(1)* %.pn16.in, align 4
  %.pn4 = fmul float %.pn16, %21
  %acc.1 = fadd float %acc.09, %.pn4
  %22 = add nuw i32 %k.08, 1
  %exitcond15 = icmp eq i32 %22, %blockWidth
  br i1 %exitcond15, label %._crit_edge12, label %15

._crit_edge12:                                    ; preds = %15
  %acc.1.lcssa = phi float [ %acc.1, %15 ]
  %23 = add i32 %10, %5
  %24 = getelementptr inbounds float addrspace(3)* %inter, i32 %23
  store float %acc.1.lcssa, float addrspace(3)* %24, align 4, !tbaa !7
  tail call void @barrier(i32 1) #3
  br i1 %9, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %._crit_edge12
  %25 = icmp eq i32 %inverse, 0
  %dct8x8.dct8x8_trans = select i1 %25, float addrspace(1)* %dct8x8, float addrspace(1)* %dct8x8_trans
  br label %26

; <label>:26                                      ; preds = %26, %.lr.ph
  %acc.27 = phi float [ 0.000000e+00, %.lr.ph ], [ %acc.3, %26 ]
  %k1.06 = phi i32 [ 0, %.lr.ph ], [ %32, %26 ]
  %27 = add i32 %k1.06, %10
  %28 = mul i32 %k1.06, %blockWidth
  %29 = add i32 %28, %5
  %30 = getelementptr inbounds float addrspace(3)* %inter, i32 %27
  %31 = load float addrspace(3)* %30, align 4, !tbaa !7
  %.pn5.in = getelementptr inbounds float addrspace(1)* %dct8x8.dct8x8_trans, i32 %29
  %.pn5 = load float addrspace(1)* %.pn5.in, align 4
  %.pn = fmul float %31, %.pn5
  %acc.3 = fadd float %acc.27, %.pn
  %32 = add nuw i32 %k1.06, 1
  %exitcond = icmp eq i32 %32, %blockWidth
  br i1 %exitcond, label %._crit_edge.loopexit, label %26

._crit_edge.critedge:                             ; preds = %0
  %33 = add i32 %10, %5
  %34 = getelementptr inbounds float addrspace(3)* %inter, i32 %33
  store float 0.000000e+00, float addrspace(3)* %34, align 4, !tbaa !7
  tail call void @barrier(i32 1) #3
  br label %._crit_edge

._crit_edge.loopexit:                             ; preds = %26
  %acc.3.lcssa = phi float [ %acc.3, %26 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %._crit_edge.critedge, %._crit_edge12
  %acc.2.lcssa = phi float [ 0.000000e+00, %._crit_edge12 ], [ 0.000000e+00, %._crit_edge.critedge ], [ %acc.3.lcssa, %._crit_edge.loopexit ]
  %35 = getelementptr inbounds float addrspace(1)* %output, i32 %8
  store float %acc.2.lcssa, float addrspace(1)* %35, align 4, !tbaa !7
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
!llvm.ident = !{!6}

!0 = !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32)* @DCT, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 1, i32 3, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*", !"float*", !"float*", !"float*", !"uint", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*", !"float*", !"float*", !"float*", !"uint", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"", !"", !"const", !"const", !"const"}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"float", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}

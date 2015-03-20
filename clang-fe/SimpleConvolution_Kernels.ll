; ModuleID = '../kernel-src/SimpleConvolution_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @simpleConvolution(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture readonly %mask, <2 x i32> %inputDimensions, <2 x i32> %maskDimensions) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = extractelement <2 x i32> %inputDimensions, i32 0
  %3 = extractelement <2 x i32> %inputDimensions, i32 1
  %4 = urem i32 %1, %2
  %5 = udiv i32 %1, %2
  %6 = extractelement <2 x i32> %maskDimensions, i32 0
  %7 = extractelement <2 x i32> %maskDimensions, i32 1
  %8 = add i32 %6, -1
  %9 = lshr i32 %8, 1
  %10 = add i32 %7, -1
  %11 = lshr i32 %10, 1
  %12 = icmp ult i32 %4, %9
  %13 = sub i32 %4, %9
  %. = select i1 %12, i32 0, i32 %13
  %14 = add i32 %4, %9
  %15 = icmp ult i32 %14, %2
  %16 = add i32 %2, -1
  %17 = select i1 %15, i32 %14, i32 %16
  %18 = icmp ult i32 %5, %11
  %19 = sub i32 %5, %11
  %.1 = select i1 %18, i32 0, i32 %19
  %20 = add i32 %5, %11
  %21 = icmp ult i32 %20, %3
  %22 = add i32 %3, -1
  %23 = select i1 %21, i32 %20, i32 %22
  %24 = icmp ugt i32 %., %17
  br i1 %24, label %._crit_edge8, label %.preheader.lr.ph

.preheader.lr.ph:                                 ; preds = %0
  %25 = icmp ugt i32 %.1, %23
  %26 = sub i32 %11, %5
  %27 = sub i32 %9, %4
  br label %.preheader

.preheader:                                       ; preds = %.preheader.lr.ph, %._crit_edge
  %sumFX.07 = phi float [ 0.000000e+00, %.preheader.lr.ph ], [ %sumFX.1.lcssa, %._crit_edge ]
  %i.05 = phi i32 [ %., %.preheader.lr.ph ], [ %44, %._crit_edge ]
  br i1 %25, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.preheader
  %28 = add i32 %27, %i.05
  br label %29

; <label>:29                                      ; preds = %.lr.ph, %29
  %sumFX.14 = phi float [ %sumFX.07, %.lr.ph ], [ %41, %29 ]
  %j.03 = phi i32 [ %.1, %.lr.ph ], [ %42, %29 ]
  %30 = add i32 %26, %j.03
  %31 = mul i32 %30, %6
  %32 = add i32 %28, %31
  %33 = mul i32 %j.03, %2
  %34 = add i32 %33, %i.05
  %35 = getelementptr inbounds i32 addrspace(1)* %input, i32 %34
  %36 = load i32 addrspace(1)* %35, align 4, !tbaa !7
  %37 = uitofp i32 %36 to float
  %38 = getelementptr inbounds float addrspace(1)* %mask, i32 %32
  %39 = load float addrspace(1)* %38, align 4, !tbaa !11
  %40 = fmul float %37, %39
  %41 = fadd float %sumFX.14, %40
  %42 = add i32 %j.03, 1
  %43 = icmp ugt i32 %42, %23
  br i1 %43, label %._crit_edge.loopexit, label %29

._crit_edge.loopexit:                             ; preds = %29
  %.lcssa = phi float [ %41, %29 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.preheader
  %sumFX.1.lcssa = phi float [ %sumFX.07, %.preheader ], [ %.lcssa, %._crit_edge.loopexit ]
  %44 = add i32 %i.05, 1
  %45 = icmp ugt i32 %44, %17
  br i1 %45, label %._crit_edge8.loopexit, label %.preheader

._crit_edge8.loopexit:                            ; preds = %._crit_edge
  %sumFX.1.lcssa.lcssa = phi float [ %sumFX.1.lcssa, %._crit_edge ]
  br label %._crit_edge8

._crit_edge8:                                     ; preds = %._crit_edge8.loopexit, %0
  %sumFX.0.lcssa = phi float [ 0.000000e+00, %0 ], [ %sumFX.1.lcssa.lcssa, %._crit_edge8.loopexit ]
  %46 = fadd float %sumFX.0.lcssa, 5.000000e-01
  %47 = fptoui float %46 to i32
  %48 = getelementptr inbounds i32 addrspace(1)* %output, i32 %1
  store i32 %47, i32 addrspace(1)* %48, align 4, !tbaa !7
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, float addrspace(1)*, <2 x i32>, <2 x i32>)* @simpleConvolution, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint*", !"uint*", !"float*", !"uint2", !"uint2"}
!4 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"float*", !"uint __attribute__((ext_vector_type(2)))", !"uint __attribute__((ext_vector_type(2)))"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"const", !"const"}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{!12, !12, i64 0}
!12 = !{!"float", !9, i64 0}

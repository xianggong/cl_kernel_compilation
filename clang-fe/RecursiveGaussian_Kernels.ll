; ModuleID = '../kernel-src/RecursiveGaussian_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @transpose_kernel(<4 x i8> addrspace(1)* nocapture %output, <4 x i8> addrspace(1)* nocapture readonly %input, <4 x i8> addrspace(3)* nocapture %block, i32 %width, i32 %height, i32 %blockSize) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = tail call i32 @get_local_id(i32 0) #3
  %4 = tail call i32 @get_local_id(i32 1) #3
  %5 = mul i32 %2, %width
  %6 = add i32 %5, %1
  %7 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %6
  %8 = load <4 x i8> addrspace(1)* %7, align 4, !tbaa !13
  %9 = mul i32 %4, %blockSize
  %10 = add i32 %9, %3
  %11 = getelementptr inbounds <4 x i8> addrspace(3)* %block, i32 %10
  store <4 x i8> %8, <4 x i8> addrspace(3)* %11, align 4, !tbaa !13
  tail call void @barrier(i32 1) #3
  %12 = mul i32 %1, %height
  %13 = add i32 %2, %12
  %14 = load <4 x i8> addrspace(3)* %11, align 4, !tbaa !13
  %15 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %13
  store <4 x i8> %14, <4 x i8> addrspace(1)* %15, align 4, !tbaa !13
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @RecursiveGaussian_kernel(<4 x i8> addrspace(1)* nocapture readonly %input, <4 x i8> addrspace(1)* nocapture %output, i32 %width, i32 %height, float %a0, float %a1, float %a2, float %a3, float %b1, float %b2, float %coefp, float %coefn) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = icmp ult i32 %1, %width
  br i1 %2, label %.preheader, label %.loopexit

.preheader:                                       ; preds = %0
  %3 = icmp sgt i32 %height, 0
  br i1 %3, label %.lr.ph15, label %._crit_edge.thread

._crit_edge.thread:                               ; preds = %.preheader
  tail call void @barrier(i32 2) #3
  br label %.loopexit

.lr.ph15:                                         ; preds = %.preheader
  %4 = insertelement <4 x float> undef, float %a0, i32 0
  %5 = shufflevector <4 x float> %4, <4 x float> undef, <4 x i32> zeroinitializer
  %6 = insertelement <4 x float> undef, float %a1, i32 0
  %7 = shufflevector <4 x float> %6, <4 x float> undef, <4 x i32> zeroinitializer
  %8 = insertelement <4 x float> undef, float %b1, i32 0
  %9 = shufflevector <4 x float> %8, <4 x float> undef, <4 x i32> zeroinitializer
  %10 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %9
  %11 = insertelement <4 x float> undef, float %b2, i32 0
  %12 = shufflevector <4 x float> %11, <4 x float> undef, <4 x i32> zeroinitializer
  %13 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %12
  %14 = add i32 %height, -1
  br label %15

; <label>:15                                      ; preds = %15, %.lr.ph15
  %xp.014 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %31, %15 ]
  %yp.013 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %35, %15 ]
  %yb.012 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %yp.013, %15 ]
  %y.011 = phi i32 [ 0, %.lr.ph15 ], [ %49, %15 ]
  %16 = mul nsw i32 %y.011, %width
  %17 = add i32 %16, %1
  %18 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %17
  %19 = load <4 x i8> addrspace(1)* %18, align 4
  %20 = extractelement <4 x i8> %19, i32 0
  %21 = uitofp i8 %20 to float
  %22 = insertelement <4 x float> undef, float %21, i32 0
  %23 = extractelement <4 x i8> %19, i32 1
  %24 = uitofp i8 %23 to float
  %25 = insertelement <4 x float> %22, float %24, i32 1
  %26 = extractelement <4 x i8> %19, i32 2
  %27 = uitofp i8 %26 to float
  %28 = insertelement <4 x float> %25, float %27, i32 2
  %29 = extractelement <4 x i8> %19, i32 3
  %30 = uitofp i8 %29 to float
  %31 = insertelement <4 x float> %28, float %30, i32 3
  %32 = fmul <4 x float> %7, %xp.014
  %33 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %5, <4 x float> %31, <4 x float> %32)
  %34 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %10, <4 x float> %yp.013, <4 x float> %33)
  %35 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %13, <4 x float> %yb.012, <4 x float> %34)
  %36 = extractelement <4 x float> %35, i32 0
  %37 = fptoui float %36 to i8
  %38 = insertelement <4 x i8> undef, i8 %37, i32 0
  %39 = extractelement <4 x float> %35, i32 1
  %40 = fptoui float %39 to i8
  %41 = insertelement <4 x i8> %38, i8 %40, i32 1
  %42 = extractelement <4 x float> %35, i32 2
  %43 = fptoui float %42 to i8
  %44 = insertelement <4 x i8> %41, i8 %43, i32 2
  %45 = extractelement <4 x float> %35, i32 3
  %46 = fptoui float %45 to i8
  %47 = insertelement <4 x i8> %44, i8 %46, i32 3
  %48 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %17
  store <4 x i8> %47, <4 x i8> addrspace(1)* %48, align 4, !tbaa !13
  %49 = add nuw nsw i32 %y.011, 1
  %exitcond = icmp eq i32 %y.011, %14
  br i1 %exitcond, label %._crit_edge, label %15

._crit_edge:                                      ; preds = %15
  tail call void @barrier(i32 2) #3
  br i1 %3, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %._crit_edge
  %50 = insertelement <4 x float> undef, float %a2, i32 0
  %51 = shufflevector <4 x float> %50, <4 x float> undef, <4 x i32> zeroinitializer
  %52 = insertelement <4 x float> undef, float %a3, i32 0
  %53 = shufflevector <4 x float> %52, <4 x float> undef, <4 x i32> zeroinitializer
  %54 = insertelement <4 x float> undef, float %b1, i32 0
  %55 = shufflevector <4 x float> %54, <4 x float> undef, <4 x i32> zeroinitializer
  %56 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %55
  %57 = insertelement <4 x float> undef, float %b2, i32 0
  %58 = shufflevector <4 x float> %57, <4 x float> undef, <4 x i32> zeroinitializer
  %59 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %58
  br label %60

; <label>:60                                      ; preds = %.lr.ph, %60
  %y1.010.in = phi i32 [ %height, %.lr.ph ], [ %y1.010, %60 ]
  %xn.09 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %76, %60 ]
  %xa.08 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %xn.09, %60 ]
  %yn.07 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %80, %60 ]
  %ya.06 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %yn.07, %60 ]
  %y1.010 = add nsw i32 %y1.010.in, -1
  %61 = mul nsw i32 %y1.010, %width
  %62 = add i32 %61, %1
  %63 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %62
  %64 = load <4 x i8> addrspace(1)* %63, align 4
  %65 = extractelement <4 x i8> %64, i32 0
  %66 = uitofp i8 %65 to float
  %67 = insertelement <4 x float> undef, float %66, i32 0
  %68 = extractelement <4 x i8> %64, i32 1
  %69 = uitofp i8 %68 to float
  %70 = insertelement <4 x float> %67, float %69, i32 1
  %71 = extractelement <4 x i8> %64, i32 2
  %72 = uitofp i8 %71 to float
  %73 = insertelement <4 x float> %70, float %72, i32 2
  %74 = extractelement <4 x i8> %64, i32 3
  %75 = uitofp i8 %74 to float
  %76 = insertelement <4 x float> %73, float %75, i32 3
  %77 = fmul <4 x float> %53, %xa.08
  %78 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %51, <4 x float> %xn.09, <4 x float> %77)
  %79 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %56, <4 x float> %yn.07, <4 x float> %78)
  %80 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %59, <4 x float> %ya.06, <4 x float> %79)
  %81 = getelementptr inbounds <4 x i8> addrspace(1)* %output, i32 %62
  %82 = load <4 x i8> addrspace(1)* %81, align 4
  %83 = extractelement <4 x i8> %82, i32 0
  %84 = uitofp i8 %83 to float
  %85 = insertelement <4 x float> undef, float %84, i32 0
  %86 = extractelement <4 x i8> %82, i32 1
  %87 = uitofp i8 %86 to float
  %88 = insertelement <4 x float> %85, float %87, i32 1
  %89 = extractelement <4 x i8> %82, i32 2
  %90 = uitofp i8 %89 to float
  %91 = insertelement <4 x float> %88, float %90, i32 2
  %92 = extractelement <4 x i8> %82, i32 3
  %93 = uitofp i8 %92 to float
  %94 = insertelement <4 x float> %91, float %93, i32 3
  %95 = fadd <4 x float> %80, %94
  %96 = extractelement <4 x float> %95, i32 0
  %97 = fptoui float %96 to i8
  %98 = insertelement <4 x i8> undef, i8 %97, i32 0
  %99 = extractelement <4 x float> %95, i32 1
  %100 = fptoui float %99 to i8
  %101 = insertelement <4 x i8> %98, i8 %100, i32 1
  %102 = extractelement <4 x float> %95, i32 2
  %103 = fptoui float %102 to i8
  %104 = insertelement <4 x i8> %101, i8 %103, i32 2
  %105 = extractelement <4 x float> %95, i32 3
  %106 = fptoui float %105 to i8
  %107 = insertelement <4 x i8> %104, i8 %106, i32 3
  store <4 x i8> %107, <4 x i8> addrspace(1)* %81, align 4, !tbaa !13
  %108 = icmp sgt i32 %y1.010.in, 1
  br i1 %108, label %60, label %.loopexit.loopexit

.loopexit.loopexit:                               ; preds = %60
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %._crit_edge, %._crit_edge.thread, %0
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!12}

!0 = !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, <4 x i8> addrspace(3)*, i32, i32, i32)* @transpose_kernel, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uchar4*", !"uchar4*", !"uchar4*", !"uint", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar __attribute__((ext_vector_type(4)))*", !"uint", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"const", !"const", !"const"}
!6 = !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, i32, float, float, float, float, float, float, float, float)* @RecursiveGaussian_kernel, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0}
!8 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"uchar4*", !"uchar4*", !"int", !"int", !"float", !"float", !"float", !"float", !"float", !"float", !"float", !"float"}
!10 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar __attribute__((ext_vector_type(4)))*", !"int", !"int", !"float", !"float", !"float", !"float", !"float", !"float", !"float", !"float"}
!11 = !{!"kernel_arg_type_qual", !"const", !"", !"const", !"const", !"const", !"const", !"const", !"const", !"const", !"const", !"const", !"const"}
!12 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!13 = !{!14, !14, i64 0}
!14 = !{!"omnipotent char", !15, i64 0}
!15 = !{!"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/ConcurrentKernel_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

@K2.lds = internal addrspace(3) global [8192 x i8] undef, align 1
@K4.lds = internal addrspace(3) global [8192 x i8] undef, align 1
@K6.lds = internal addrspace(3) global [8192 x i8] undef, align 1
@K8.lds = internal addrspace(3) global [8192 x i8] undef, align 1
@K10.lds = internal addrspace(3) global [8192 x i8] undef, align 1

; Function Attrs: nounwind
define void @work1(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %bufferSize, i32 %multiplier) #0 {
  %zero = alloca i32, align 4
  %1 = tail call i32 @get_global_size(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_local_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %5

.preheader:                                       ; preds = %5
  %.lcssa = phi i32 [ %34, %5 ]
  %4 = icmp ult i32 %2, %bufferSize
  br i1 %4, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %.preheader
  br label %.lr.ph

; <label>:5                                       ; preds = %5, %0
  %i.04 = phi i32 [ 1, %0 ], [ %35, %5 ]
  %tmp.03 = phi i32 [ 1, %0 ], [ %34, %5 ]
  %6 = urem i32 %i.04, %bufferSize
  %7 = getelementptr inbounds i8 addrspace(1)* %input, i32 %6
  %8 = load i8 addrspace(1)* %7, align 1, !tbaa !16
  %9 = zext i8 %8 to i32
  %10 = shl nsw i32 %i.04, 1
  %11 = urem i32 %10, %bufferSize
  %12 = getelementptr inbounds i8 addrspace(1)* %input, i32 %11
  %13 = load i8 addrspace(1)* %12, align 1, !tbaa !16
  %14 = zext i8 %13 to i32
  %15 = mul nsw i32 %i.04, 3
  %16 = urem i32 %15, %bufferSize
  %17 = getelementptr inbounds i8 addrspace(1)* %input, i32 %16
  %18 = load i8 addrspace(1)* %17, align 1, !tbaa !16
  %19 = zext i8 %18 to i32
  %20 = shl nsw i32 %i.04, 2
  %21 = urem i32 %20, %bufferSize
  %22 = getelementptr inbounds i8 addrspace(1)* %input, i32 %21
  %23 = load i8 addrspace(1)* %22, align 1, !tbaa !16
  %24 = zext i8 %23 to i32
  %25 = mul nsw i32 %i.04, 5
  %26 = urem i32 %25, %bufferSize
  %27 = getelementptr inbounds i8 addrspace(1)* %input, i32 %26
  %28 = load i8 addrspace(1)* %27, align 1, !tbaa !16
  %29 = zext i8 %28 to i32
  %30 = add i32 %9, %tmp.03
  %31 = add i32 %30, %14
  %32 = add i32 %31, %19
  %33 = add i32 %32, %24
  %34 = add i32 %33, %29
  %35 = add nuw nsw i32 %i.04, 1
  %exitcond = icmp eq i32 %35, 5000
  br i1 %exitcond, label %.preheader, label %5

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %i1.02 = phi i32 [ %45, %.lr.ph ], [ %2, %.lr.ph.preheader ]
  %36 = getelementptr inbounds i8 addrspace(1)* %input, i32 %i1.02
  %37 = load i8 addrspace(1)* %36, align 1, !tbaa !16
  %38 = zext i8 %37 to i32
  %39 = mul nsw i32 %38, %multiplier
  %40 = load volatile i32* %zero, align 4
  %41 = mul i32 %40, %.lcssa
  %42 = add i32 %39, %41
  %43 = trunc i32 %42 to i8
  %44 = getelementptr inbounds i8 addrspace(1)* %output, i32 %i1.02
  store i8 %43, i8 addrspace(1)* %44, align 1, !tbaa !16
  %45 = add i32 %i1.02, %1
  %46 = icmp ult i32 %45, %bufferSize
  br i1 %46, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.preheader
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
  %.lcssa = phi i32 [ %98, %6 ]
  %4 = icmp ult i32 %2, %bufferSize
  br i1 %4, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.preheader
  %5 = getelementptr inbounds i8 addrspace(3)* %lds, i32 %3
  br label %100

; <label>:6                                       ; preds = %6, %0
  %i.05 = phi i32 [ 1, %0 ], [ %99, %6 ]
  %tmp.04 = phi i32 [ 1, %0 ], [ %98, %6 ]
  %7 = shl nsw i32 %i.05, 1
  %8 = urem i32 %7, %bufferSize
  %9 = getelementptr inbounds i8 addrspace(1)* %input, i32 %8
  %10 = load i8 addrspace(1)* %9, align 1, !tbaa !16
  %11 = zext i8 %10 to i32
  %12 = shl nsw i32 %i.05, 2
  %13 = urem i32 %12, %bufferSize
  %14 = getelementptr inbounds i8 addrspace(1)* %input, i32 %13
  %15 = load i8 addrspace(1)* %14, align 1, !tbaa !16
  %16 = zext i8 %15 to i32
  %17 = mul nsw i32 %i.05, 6
  %18 = urem i32 %17, %bufferSize
  %19 = getelementptr inbounds i8 addrspace(1)* %input, i32 %18
  %20 = load i8 addrspace(1)* %19, align 1, !tbaa !16
  %21 = zext i8 %20 to i32
  %22 = shl nsw i32 %i.05, 3
  %23 = urem i32 %22, %bufferSize
  %24 = getelementptr inbounds i8 addrspace(1)* %input, i32 %23
  %25 = load i8 addrspace(1)* %24, align 1, !tbaa !16
  %26 = zext i8 %25 to i32
  %27 = mul nsw i32 %i.05, 10
  %28 = urem i32 %27, %bufferSize
  %29 = getelementptr inbounds i8 addrspace(1)* %input, i32 %28
  %30 = load i8 addrspace(1)* %29, align 1, !tbaa !16
  %31 = zext i8 %30 to i32
  %32 = add i32 %11, %tmp.04
  %33 = sub i32 %32, %16
  %34 = add i32 %33, %21
  %35 = sub i32 %34, %26
  %36 = add i32 %35, %31
  %37 = add nuw nsw i32 %i.05, 1
  %38 = shl nsw i32 %37, 1
  %39 = urem i32 %38, %bufferSize
  %40 = getelementptr inbounds i8 addrspace(1)* %input, i32 %39
  %41 = load i8 addrspace(1)* %40, align 1, !tbaa !16
  %42 = zext i8 %41 to i32
  %43 = shl nsw i32 %37, 2
  %44 = urem i32 %43, %bufferSize
  %45 = getelementptr inbounds i8 addrspace(1)* %input, i32 %44
  %46 = load i8 addrspace(1)* %45, align 1, !tbaa !16
  %47 = zext i8 %46 to i32
  %48 = mul nsw i32 %37, 6
  %49 = urem i32 %48, %bufferSize
  %50 = getelementptr inbounds i8 addrspace(1)* %input, i32 %49
  %51 = load i8 addrspace(1)* %50, align 1, !tbaa !16
  %52 = zext i8 %51 to i32
  %53 = shl nsw i32 %37, 3
  %54 = urem i32 %53, %bufferSize
  %55 = getelementptr inbounds i8 addrspace(1)* %input, i32 %54
  %56 = load i8 addrspace(1)* %55, align 1, !tbaa !16
  %57 = zext i8 %56 to i32
  %58 = mul nsw i32 %37, 10
  %59 = urem i32 %58, %bufferSize
  %60 = getelementptr inbounds i8 addrspace(1)* %input, i32 %59
  %61 = load i8 addrspace(1)* %60, align 1, !tbaa !16
  %62 = zext i8 %61 to i32
  %63 = add i32 %42, %36
  %64 = sub i32 %63, %47
  %65 = add i32 %64, %52
  %66 = sub i32 %65, %57
  %67 = add i32 %66, %62
  %68 = add nuw nsw i32 %37, 1
  %69 = shl nsw i32 %68, 1
  %70 = urem i32 %69, %bufferSize
  %71 = getelementptr inbounds i8 addrspace(1)* %input, i32 %70
  %72 = load i8 addrspace(1)* %71, align 1, !tbaa !16
  %73 = zext i8 %72 to i32
  %74 = shl nsw i32 %68, 2
  %75 = urem i32 %74, %bufferSize
  %76 = getelementptr inbounds i8 addrspace(1)* %input, i32 %75
  %77 = load i8 addrspace(1)* %76, align 1, !tbaa !16
  %78 = zext i8 %77 to i32
  %79 = mul nsw i32 %68, 6
  %80 = urem i32 %79, %bufferSize
  %81 = getelementptr inbounds i8 addrspace(1)* %input, i32 %80
  %82 = load i8 addrspace(1)* %81, align 1, !tbaa !16
  %83 = zext i8 %82 to i32
  %84 = shl nsw i32 %68, 3
  %85 = urem i32 %84, %bufferSize
  %86 = getelementptr inbounds i8 addrspace(1)* %input, i32 %85
  %87 = load i8 addrspace(1)* %86, align 1, !tbaa !16
  %88 = zext i8 %87 to i32
  %89 = mul nsw i32 %68, 10
  %90 = urem i32 %89, %bufferSize
  %91 = getelementptr inbounds i8 addrspace(1)* %input, i32 %90
  %92 = load i8 addrspace(1)* %91, align 1, !tbaa !16
  %93 = zext i8 %92 to i32
  %94 = add i32 %73, %67
  %95 = sub i32 %94, %78
  %96 = add i32 %95, %83
  %97 = sub i32 %96, %88
  %98 = add i32 %97, %93
  %99 = add nuw nsw i32 %68, 1
  %exitcond.2 = icmp eq i32 %99, 10000
  br i1 %exitcond.2, label %.preheader, label %6

; <label>:100                                     ; preds = %.lr.ph, %100
  %i1.03 = phi i32 [ %2, %.lr.ph ], [ %110, %100 ]
  %101 = getelementptr inbounds i8 addrspace(1)* %input, i32 %i1.03
  %102 = load i8 addrspace(1)* %101, align 1, !tbaa !16
  store i8 %102, i8 addrspace(3)* %5, align 1, !tbaa !16
  %103 = zext i8 %102 to i32
  %104 = mul nsw i32 %103, %multiplier
  %105 = load volatile i32* %zero, align 4
  %106 = mul nsw i32 %105, %.lcssa
  %107 = add nsw i32 %104, %106
  %108 = trunc i32 %107 to i8
  %109 = getelementptr inbounds i8 addrspace(1)* %output, i32 %i1.03
  store i8 %108, i8 addrspace(1)* %109, align 1, !tbaa !16
  %110 = add i32 %i1.03, %1
  %111 = icmp ult i32 %110, %bufferSize
  br i1 %111, label %100, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %100
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.preheader
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

!opencl.kernels = !{!0, !6, !7, !8, !9, !10, !11, !12, !13, !14}
!llvm.ident = !{!15}

!0 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K1, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uchar*", !"uchar*", !"uint", !"int"}
!4 = !{!"kernel_arg_base_type", !"uchar*", !"uchar*", !"uint", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K2, !1, !2, !3, !4, !5}
!7 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K3, !1, !2, !3, !4, !5}
!8 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K4, !1, !2, !3, !4, !5}
!9 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K5, !1, !2, !3, !4, !5}
!10 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K6, !1, !2, !3, !4, !5}
!11 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K7, !1, !2, !3, !4, !5}
!12 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K8, !1, !2, !3, !4, !5}
!13 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K9, !1, !2, !3, !4, !5}
!14 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K10, !1, !2, !3, !4, !5}
!15 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!16 = !{!17, !17, i64 0}
!17 = !{!"omnipotent char", !18, i64 0}
!18 = !{!"Simple C/C++ TBAA"}

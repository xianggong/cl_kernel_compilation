; ModuleID = '../kernel-src/Histogram_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram256_vector(<4 x i32> addrspace(1)* nocapture readonly %data, i8 addrspace(3)* nocapture %sharedArray, i32 addrspace(1)* nocapture %binResult) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = shl i32 %1, 2
  %6 = and i32 %5, 124
  %7 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %8

; <label>:8                                       ; preds = %8, %0
  %i.07 = phi i32 [ 0, %0 ], [ %12, %8 ]
  %9 = mul i32 %i.07, %4
  %10 = add i32 %9, %1
  %11 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %10
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %11, align 4, !tbaa !3
  %12 = add nsw i32 %i.07, 1
  %exitcond11 = icmp eq i32 %12, 64
  br i1 %exitcond11, label %13, label %8

; <label>:13                                      ; preds = %8
  %14 = lshr i32 %1, 5
  tail call void @barrier(i32 1) #2
  %15 = shl i32 %4, 5
  %16 = and i32 %15, 536870880
  %17 = mul i32 %16, %3
  %18 = add i32 %17, %1
  br label %19

; <label>:19                                      ; preds = %19, %13
  %indvars.iv8 = phi i64 [ 0, %13 ], [ %indvars.iv.next9, %19 ]
  %20 = trunc i64 %indvars.iv8 to i32
  %21 = mul i32 %20, %4
  %22 = add i32 %18, %21
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds <4 x i32> addrspace(1)* %data, i64 %23
  %25 = load <4 x i32> addrspace(1)* %24, align 16, !tbaa !3
  %26 = extractelement <4 x i32> %25, i32 0
  %27 = shl i32 %26, 7
  %28 = or i32 %27, %6
  %29 = add i32 %28, %14
  %30 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %29
  %31 = load i8 addrspace(3)* %30, align 1, !tbaa !3
  %32 = add i8 %31, 1
  store i8 %32, i8 addrspace(3)* %30, align 1, !tbaa !3
  %33 = extractelement <4 x i32> %25, i32 1
  %34 = shl i32 %33, 7
  %35 = or i32 %34, %6
  %36 = add i32 %35, %14
  %37 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %36
  %38 = load i8 addrspace(3)* %37, align 1, !tbaa !3
  %39 = add i8 %38, 1
  store i8 %39, i8 addrspace(3)* %37, align 1, !tbaa !3
  %40 = extractelement <4 x i32> %25, i32 2
  %41 = shl i32 %40, 7
  %42 = or i32 %41, %6
  %43 = add i32 %42, %14
  %44 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %43
  %45 = load i8 addrspace(3)* %44, align 1, !tbaa !3
  %46 = add i8 %45, 1
  store i8 %46, i8 addrspace(3)* %44, align 1, !tbaa !3
  %47 = extractelement <4 x i32> %25, i32 3
  %48 = shl i32 %47, 7
  %49 = or i32 %48, %6
  %50 = add i32 %49, %14
  %51 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %50
  %52 = load i8 addrspace(3)* %51, align 1, !tbaa !3
  %53 = add i8 %52, 1
  store i8 %53, i8 addrspace(3)* %51, align 1, !tbaa !3
  %indvars.iv.next9 = add nuw nsw i64 %indvars.iv8, 1
  %exitcond10 = icmp eq i64 %indvars.iv.next9, 32
  br i1 %exitcond10, label %54, label %19

; <label>:54                                      ; preds = %19
  tail call void @barrier(i32 1) #2
  %55 = udiv i32 256, %4
  %56 = icmp eq i32 %55, 0
  br i1 %56, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %54
  %57 = shl i32 %1, 5
  %58 = shl i32 %3, 8
  %59 = add i32 %58, %1
  br label %60

; <label>:60                                      ; preds = %.lr.ph, %73
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %73 ]
  %61 = trunc i64 %indvars.iv to i32
  %62 = shl i32 %61, 12
  %63 = add i32 %62, %57
  br label %64

; <label>:64                                      ; preds = %64, %60
  %j.04 = phi i32 [ 0, %60 ], [ %72, %64 ]
  %binCount.03 = phi <4 x i32> [ zeroinitializer, %60 ], [ %71, %64 ]
  %65 = add nsw i32 %j.04, %1
  %66 = and i32 %65, 31
  %67 = or i32 %66, %63
  %68 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %67
  %69 = load <4 x i8> addrspace(3)* %68, align 4, !tbaa !3
  %70 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %69) #2
  %71 = add <4 x i32> %binCount.03, %70
  %72 = add nsw i32 %j.04, 1
  %exitcond = icmp eq i32 %72, 32
  br i1 %exitcond, label %73, label %64

; <label>:73                                      ; preds = %64
  %74 = extractelement <4 x i32> %71, i32 0
  %75 = extractelement <4 x i32> %71, i32 1
  %76 = add i32 %74, %75
  %77 = extractelement <4 x i32> %71, i32 2
  %78 = add i32 %76, %77
  %79 = extractelement <4 x i32> %71, i32 3
  %80 = add i32 %78, %79
  %81 = mul i32 %61, %4
  %82 = add i32 %59, %81
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds i32 addrspace(1)* %binResult, i64 %83
  store i32 %80, i32 addrspace(1)* %84, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %85 = trunc i64 %indvars.iv.next to i32
  %86 = icmp ult i32 %85, %55
  br i1 %86, label %60, label %._crit_edge

._crit_edge:                                      ; preds = %73, %54
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @histogram256_scalar(i32 addrspace(1)* nocapture readonly %data, i8 addrspace(3)* nocapture %sharedArray, i32 addrspace(1)* nocapture %binResult) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = shl i32 %1, 2
  %6 = and i32 %5, 124
  %7 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %8

; <label>:8                                       ; preds = %8, %0
  %i.08 = phi i32 [ 0, %0 ], [ %12, %8 ]
  %9 = mul i32 %i.08, %4
  %10 = add i32 %9, %1
  %11 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %10
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %11, align 4, !tbaa !3
  %12 = add nsw i32 %i.08, 1
  %exitcond12 = icmp eq i32 %12, 64
  br i1 %exitcond12, label %13, label %8

; <label>:13                                      ; preds = %8
  %14 = lshr i32 %1, 5
  tail call void @barrier(i32 1) #2
  %15 = shl i32 %3, 7
  br label %16

; <label>:16                                      ; preds = %16, %13
  %indvars.iv9 = phi i64 [ 0, %13 ], [ %indvars.iv.next10, %16 ]
  %17 = trunc i64 %indvars.iv9 to i32
  %tmp = add i32 %17, %15
  %tmp3 = mul i32 %tmp, %4
  %18 = add i32 %tmp3, %1
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds i32 addrspace(1)* %data, i64 %19
  %21 = load i32 addrspace(1)* %20, align 4, !tbaa !6
  %22 = shl i32 %21, 7
  %23 = or i32 %22, %6
  %24 = add i32 %23, %14
  %25 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %24
  %26 = load i8 addrspace(3)* %25, align 1, !tbaa !3
  %27 = add i8 %26, 1
  store i8 %27, i8 addrspace(3)* %25, align 1, !tbaa !3
  %indvars.iv.next10 = add nuw nsw i64 %indvars.iv9, 1
  %exitcond11 = icmp eq i64 %indvars.iv.next10, 128
  br i1 %exitcond11, label %28, label %16

; <label>:28                                      ; preds = %16
  tail call void @barrier(i32 1) #2
  %29 = udiv i32 256, %4
  %30 = icmp eq i32 %29, 0
  br i1 %30, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %28
  %31 = shl i32 %1, 5
  %32 = shl i32 %3, 8
  %33 = add i32 %32, %1
  br label %34

; <label>:34                                      ; preds = %.lr.ph, %47
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %47 ]
  %35 = trunc i64 %indvars.iv to i32
  %36 = shl i32 %35, 12
  %37 = add i32 %36, %31
  br label %38

; <label>:38                                      ; preds = %38, %34
  %j.05 = phi i32 [ 0, %34 ], [ %46, %38 ]
  %binCount.04 = phi <4 x i32> [ zeroinitializer, %34 ], [ %45, %38 ]
  %39 = add nsw i32 %j.05, %1
  %40 = and i32 %39, 31
  %41 = or i32 %40, %37
  %42 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %41
  %43 = load <4 x i8> addrspace(3)* %42, align 4, !tbaa !3
  %44 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %43) #2
  %45 = add <4 x i32> %binCount.04, %44
  %46 = add nsw i32 %j.05, 1
  %exitcond = icmp eq i32 %46, 32
  br i1 %exitcond, label %47, label %38

; <label>:47                                      ; preds = %38
  %48 = extractelement <4 x i32> %45, i32 0
  %49 = extractelement <4 x i32> %45, i32 1
  %50 = add i32 %48, %49
  %51 = extractelement <4 x i32> %45, i32 2
  %52 = add i32 %50, %51
  %53 = extractelement <4 x i32> %45, i32 3
  %54 = add i32 %52, %53
  %55 = mul i32 %35, %4
  %56 = add i32 %33, %55
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds i32 addrspace(1)* %binResult, i64 %57
  store i32 %54, i32 addrspace(1)* %58, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %59 = trunc i64 %indvars.iv.next to i32
  %60 = icmp ult i32 %59, %29
  br i1 %60, label %34, label %._crit_edge

._crit_edge:                                      ; preds = %47, %28
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_vector}
!1 = metadata !{void (i32 addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !7, i64 0}
!7 = metadata !{metadata !"int", metadata !4, i64 0}

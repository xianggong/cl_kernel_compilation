; ModuleID = '../kernel-src/AsyncDataTransfer_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @work(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %multiplier) #0 {
  %zero = alloca i32, align 4
  %1 = tail call i32 @get_global_size(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %3

; <label>:3                                       ; preds = %3, %0
  %i.02 = phi i32 [ 5, %0 ], [ %38, %3 ]
  %tmp.01 = phi i32 [ 1, %0 ], [ %37, %3 ]
  %4 = srem i32 %i.02, %1
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds i8 addrspace(1)* %input, i64 %5
  %7 = load i8 addrspace(1)* %6, align 1, !tbaa !2
  %8 = zext i8 %7 to i32
  %9 = shl nsw i32 %i.02, 1
  %10 = srem i32 %9, %1
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds i8 addrspace(1)* %input, i64 %11
  %13 = load i8 addrspace(1)* %12, align 1, !tbaa !2
  %14 = zext i8 %13 to i32
  %15 = mul nsw i32 %i.02, 3
  %16 = srem i32 %15, %1
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i8 addrspace(1)* %input, i64 %17
  %19 = load i8 addrspace(1)* %18, align 1, !tbaa !2
  %20 = zext i8 %19 to i32
  %21 = shl nsw i32 %i.02, 2
  %22 = srem i32 %21, %1
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds i8 addrspace(1)* %input, i64 %23
  %25 = load i8 addrspace(1)* %24, align 1, !tbaa !2
  %26 = zext i8 %25 to i32
  %27 = mul nsw i32 %i.02, 5
  %28 = srem i32 %27, %1
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i8 addrspace(1)* %input, i64 %29
  %31 = load i8 addrspace(1)* %30, align 1, !tbaa !2
  %32 = zext i8 %31 to i32
  %33 = add i32 %8, %tmp.01
  %34 = add i32 %33, %14
  %35 = add i32 %34, %20
  %36 = add i32 %35, %26
  %37 = add i32 %36, %32
  %38 = add nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %38, 100
  br i1 %exitcond, label %39, label %3

; <label>:39                                      ; preds = %3
  %40 = sext i32 %2 to i64
  %41 = getelementptr inbounds i8 addrspace(1)* %input, i64 %40
  %42 = load i8 addrspace(1)* %41, align 1, !tbaa !2
  %43 = zext i8 %42 to i32
  %44 = mul nsw i32 %43, %multiplier
  %45 = load volatile i32* %zero, align 4
  %46 = mul i32 %45, %37
  %47 = add i32 %44, %46
  %48 = trunc i32 %47 to i8
  %49 = getelementptr inbounds i8 addrspace(1)* %output, i64 %40
  store i8 %48, i8 addrspace(1)* %49, align 1, !tbaa !2
  ret void
}

declare i32 @get_global_size(i32) #1

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32)* @work}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

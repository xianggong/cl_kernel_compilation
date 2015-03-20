; ModuleID = '../kernel-src/AsyncDataTransfer_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @work(i8 addrspace(1)* nocapture readonly %input, i8 addrspace(1)* nocapture %output, i32 %multiplier) #0 {
  %zero = alloca i32, align 4
  %1 = tail call i32 @get_global_size(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  store volatile i32 0, i32* %zero, align 4
  br label %3

; <label>:3                                       ; preds = %3, %0
  %i.02 = phi i32 [ 5, %0 ], [ %33, %3 ]
  %tmp.01 = phi i32 [ 1, %0 ], [ %32, %3 ]
  %4 = srem i32 %i.02, %1
  %5 = getelementptr inbounds i8 addrspace(1)* %input, i32 %4
  %6 = load i8 addrspace(1)* %5, align 1, !tbaa !7
  %7 = zext i8 %6 to i32
  %8 = shl nsw i32 %i.02, 1
  %9 = srem i32 %8, %1
  %10 = getelementptr inbounds i8 addrspace(1)* %input, i32 %9
  %11 = load i8 addrspace(1)* %10, align 1, !tbaa !7
  %12 = zext i8 %11 to i32
  %13 = mul nsw i32 %i.02, 3
  %14 = srem i32 %13, %1
  %15 = getelementptr inbounds i8 addrspace(1)* %input, i32 %14
  %16 = load i8 addrspace(1)* %15, align 1, !tbaa !7
  %17 = zext i8 %16 to i32
  %18 = shl nsw i32 %i.02, 2
  %19 = srem i32 %18, %1
  %20 = getelementptr inbounds i8 addrspace(1)* %input, i32 %19
  %21 = load i8 addrspace(1)* %20, align 1, !tbaa !7
  %22 = zext i8 %21 to i32
  %23 = mul nsw i32 %i.02, 5
  %24 = srem i32 %23, %1
  %25 = getelementptr inbounds i8 addrspace(1)* %input, i32 %24
  %26 = load i8 addrspace(1)* %25, align 1, !tbaa !7
  %27 = zext i8 %26 to i32
  %28 = add i32 %7, %tmp.01
  %29 = add i32 %28, %12
  %30 = add i32 %29, %17
  %31 = add i32 %30, %22
  %32 = add i32 %31, %27
  %33 = add nuw nsw i32 %i.02, 1
  %exitcond = icmp eq i32 %33, 100
  br i1 %exitcond, label %34, label %3

; <label>:34                                      ; preds = %3
  %.lcssa = phi i32 [ %32, %3 ]
  %35 = getelementptr inbounds i8 addrspace(1)* %input, i32 %2
  %36 = load i8 addrspace(1)* %35, align 1, !tbaa !7
  %37 = zext i8 %36 to i32
  %38 = mul nsw i32 %37, %multiplier
  %39 = load volatile i32* %zero, align 4
  %40 = mul i32 %39, %.lcssa
  %41 = add i32 %38, %40
  %42 = trunc i32 %41 to i8
  %43 = getelementptr inbounds i8 addrspace(1)* %output, i32 %2
  store i8 %42, i8 addrspace(1)* %43, align 1, !tbaa !7
  ret void
}

declare i32 @get_global_size(i32) #1

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32)* @work, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uchar*", !"uchar*", !"int"}
!4 = !{!"kernel_arg_base_type", !"uchar*", !"uchar*", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/MemoryModel.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

@mask = addrspace(2) constant [4 x i32] [i32 1, i32 -1, i32 2, i32 -2], align 4
@MemoryModel.localBuffer = internal unnamed_addr addrspace(3) global [64 x i32] undef, align 4

; Function Attrs: nounwind
define void @MemoryModel(i32 addrspace(1)* nocapture %outputbuffer, i32 addrspace(1)* nocapture readonly %inputbuffer) #0 {
  %1 = tail call i32 @get_group_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = tail call i32 @get_global_id(i32 0) #2
  %4 = getelementptr inbounds i32 addrspace(1)* %inputbuffer, i32 %3
  %5 = load i32 addrspace(1)* %4, align 4, !tbaa !7
  %6 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %2
  store i32 %5, i32 addrspace(3)* %6, align 4, !tbaa !7
  tail call void @barrier(i32 1) #2
  %7 = and i32 %2, 63
  %8 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %7
  %9 = load i32 addrspace(3)* %8, align 4, !tbaa !7
  %10 = add i32 %2, 1
  %11 = and i32 %10, 63
  %12 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %11
  %13 = load i32 addrspace(3)* %12, align 4, !tbaa !7
  %14 = add nsw i32 %13, %9
  %15 = add i32 %2, 2
  %16 = and i32 %15, 63
  %17 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %16
  %18 = load i32 addrspace(3)* %17, align 4, !tbaa !7
  %19 = add nsw i32 %18, %14
  %20 = add i32 %2, 3
  %21 = and i32 %20, 63
  %22 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %21
  %23 = load i32 addrspace(3)* %22, align 4, !tbaa !7
  %24 = add nsw i32 %23, %19
  %25 = and i32 %1, 3
  %26 = getelementptr inbounds [4 x i32] addrspace(2)* @mask, i32 0, i32 %25
  %27 = load i32 addrspace(2)* %26, align 4, !tbaa !7
  %28 = mul nsw i32 %27, %24
  %29 = getelementptr inbounds i32 addrspace(1)* %outputbuffer, i32 %3
  store i32 %28, i32 addrspace(1)* %29, align 4, !tbaa !7
  ret void
}

declare i32 @get_group_id(i32) #1

declare i32 @get_local_id(i32) #1

declare i32 @get_global_id(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @MemoryModel, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}

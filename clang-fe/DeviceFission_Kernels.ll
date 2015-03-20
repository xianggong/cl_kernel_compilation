; ModuleID = '../kernel-src/DeviceFission_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @Add(i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = getelementptr inbounds i32 addrspace(1)* %input, i32 %1
  %3 = load i32 addrspace(1)* %2, align 4, !tbaa !8
  %4 = add nsw i32 %3, 1
  %5 = getelementptr inbounds i32 addrspace(1)* %output, i32 %1
  store i32 %4, i32 addrspace(1)* %5, align 4, !tbaa !8
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind
define void @Sub(i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = getelementptr inbounds i32 addrspace(1)* %input, i32 %1
  %3 = load i32 addrspace(1)* %2, align 4, !tbaa !8
  %4 = add nsw i32 %3, -1
  %5 = getelementptr inbounds i32 addrspace(1)* %output, i32 %1
  store i32 %4, i32 addrspace(1)* %5, align 4, !tbaa !8
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!7}

!0 = !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @Add, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int*", !"int*"}
!4 = !{!"kernel_arg_base_type", !"int*", !"int*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @Sub, !1, !2, !3, !4, !5}
!7 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}

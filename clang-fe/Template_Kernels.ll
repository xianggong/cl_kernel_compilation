; ModuleID = '../kernel-src/Template_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @templateKernel(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 %multiplier) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = getelementptr inbounds i32 addrspace(1)* %input, i32 %1
  %3 = load i32 addrspace(1)* %2, align 4, !tbaa !7
  %4 = mul i32 %3, %multiplier
  %5 = getelementptr inbounds i32 addrspace(1)* %output, i32 %1
  store i32 %4, i32 addrspace(1)* %5, align 4, !tbaa !7
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @templateKernel, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"const"}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}

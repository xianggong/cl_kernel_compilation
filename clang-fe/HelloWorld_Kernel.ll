; ModuleID = '../kernel-src/HelloWorld_Kernel.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @helloworld(i8 addrspace(1)* nocapture readonly %in, i8 addrspace(1)* nocapture %out) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = getelementptr inbounds i8 addrspace(1)* %in, i32 %1
  %3 = load i8 addrspace(1)* %2, align 1, !tbaa !7
  %4 = zext i8 %3 to i32
  %5 = add nuw nsw i32 %4, 1
  %6 = trunc i32 %5 to i8
  %7 = getelementptr inbounds i8 addrspace(1)* %out, i32 %1
  store i8 %6, i8 addrspace(1)* %7, align 1, !tbaa !7
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i8 addrspace(1)*, i8 addrspace(1)*)* @helloworld, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"char*", !"char*"}
!4 = !{!"kernel_arg_base_type", !"char*", !"char*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/FastWalshTransform_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @fastWalshTransform(float addrspace(1)* nocapture %tArray, i32 %step) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = urem i32 %1, %step
  %3 = shl i32 %step, 1
  %4 = udiv i32 %1, %step
  %5 = mul i32 %3, %4
  %6 = add i32 %5, %2
  %7 = add i32 %6, %step
  %8 = getelementptr inbounds float addrspace(1)* %tArray, i32 %6
  %9 = load float addrspace(1)* %8, align 4, !tbaa !7
  %10 = getelementptr inbounds float addrspace(1)* %tArray, i32 %7
  %11 = load float addrspace(1)* %10, align 4, !tbaa !7
  %12 = fadd float %9, %11
  store float %12, float addrspace(1)* %8, align 4, !tbaa !7
  %13 = fsub float %9, %11
  store float %13, float addrspace(1)* %10, align 4, !tbaa !7
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float addrspace(1)*, i32)* @fastWalshTransform, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"int"}
!4 = !{!"kernel_arg_base_type", !"float*", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"const"}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"float", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/FloydWarshall_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @floydWarshallPass(i32 addrspace(1)* nocapture %pathDistanceBuffer, i32 addrspace(1)* nocapture %pathBuffer, i32 %numNodes, i32 %pass) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = mul i32 %2, %numNodes
  %4 = add i32 %3, %1
  %5 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i32 %4
  %6 = load i32 addrspace(1)* %5, align 4, !tbaa !7
  %7 = add i32 %3, %pass
  %8 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i32 %7
  %9 = load i32 addrspace(1)* %8, align 4, !tbaa !7
  %10 = mul i32 %pass, %numNodes
  %11 = add i32 %1, %10
  %12 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i32 %11
  %13 = load i32 addrspace(1)* %12, align 4, !tbaa !7
  %14 = add i32 %13, %9
  %15 = icmp slt i32 %14, %6
  br i1 %15, label %16, label %18

; <label>:16                                      ; preds = %0
  store i32 %14, i32 addrspace(1)* %5, align 4, !tbaa !7
  %17 = getelementptr inbounds i32 addrspace(1)* %pathBuffer, i32 %4
  store i32 %pass, i32 addrspace(1)* %17, align 4, !tbaa !7
  br label %18

; <label>:18                                      ; preds = %16, %0
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32)* @floydWarshallPass, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"const", !"const"}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}

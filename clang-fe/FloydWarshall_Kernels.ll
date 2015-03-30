; ModuleID = '../kernel-src/FloydWarshall_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @floydWarshallPass(i32 addrspace(1)* nocapture %pathDistanceBuffer, i32 addrspace(1)* nocapture %pathBuffer, i32 %numNodes, i32 %pass) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = mul i32 %2, %numNodes
  %4 = add i32 %3, %1
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i64 %5
  %7 = load i32 addrspace(1)* %6, align 4, !tbaa !2
  %8 = add i32 %3, %pass
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i64 %9
  %11 = load i32 addrspace(1)* %10, align 4, !tbaa !2
  %12 = mul i32 %pass, %numNodes
  %13 = add i32 %1, %12
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i64 %14
  %16 = load i32 addrspace(1)* %15, align 4, !tbaa !2
  %17 = add i32 %16, %11
  %18 = icmp slt i32 %17, %7
  br i1 %18, label %19, label %21

; <label>:19                                      ; preds = %0
  store i32 %17, i32 addrspace(1)* %6, align 4, !tbaa !2
  %20 = getelementptr inbounds i32 addrspace(1)* %pathBuffer, i64 %5
  store i32 %pass, i32 addrspace(1)* %20, align 4, !tbaa !2
  br label %21

; <label>:21                                      ; preds = %19, %0
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32)* @floydWarshallPass}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/HelloWorld_Kernel.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @helloworld(i8 addrspace(1)* nocapture readonly %in, i8 addrspace(1)* nocapture %out) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds i8 addrspace(1)* %in, i64 %2
  %4 = load i8 addrspace(1)* %3, align 1, !tbaa !2
  %5 = zext i8 %4 to i32
  %6 = add nsw i32 %5, 1
  %7 = trunc i32 %6 to i8
  %8 = getelementptr inbounds i8 addrspace(1)* %out, i64 %2
  store i8 %7, i8 addrspace(1)* %8, align 1, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*)* @helloworld}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

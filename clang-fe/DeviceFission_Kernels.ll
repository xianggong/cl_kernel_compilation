; ModuleID = '../kernel-src/DeviceFission_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @Add(i32* nocapture readonly %input, i32* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = getelementptr inbounds i32* %input, i64 %1
  %3 = load i32* %2, align 4, !tbaa !3
  %4 = add nsw i32 %3, 1
  %5 = getelementptr inbounds i32* %output, i64 %1
  store i32 %4, i32* %5, align 4, !tbaa !3
  ret void
}

declare i64 @get_global_id(i32) #1

; Function Attrs: nounwind uwtable
define void @Sub(i32* nocapture readonly %input, i32* nocapture %output) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = getelementptr inbounds i32* %input, i64 %1
  %3 = load i32* %2, align 4, !tbaa !3
  %4 = add nsw i32 %3, -1
  %5 = getelementptr inbounds i32* %output, i64 %1
  store i32 %4, i32* %5, align 4, !tbaa !3
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (i32*, i32*)* @Add}
!1 = metadata !{void (i32*, i32*)* @Sub}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"int", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}

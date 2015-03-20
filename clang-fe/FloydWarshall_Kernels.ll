; ModuleID = '../kernel-src/FloydWarshall_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @floydWarshallPass(i32* nocapture %pathDistanceBuffer, i32* nocapture %pathBuffer, i32 %numNodes, i32 %pass) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #2
  %4 = trunc i64 %3 to i32
  %5 = mul i32 %4, %numNodes
  %6 = add i32 %5, %2
  %7 = zext i32 %6 to i64
  %8 = getelementptr inbounds i32* %pathDistanceBuffer, i64 %7
  %9 = load i32* %8, align 4, !tbaa !2
  %10 = add i32 %5, %pass
  %11 = zext i32 %10 to i64
  %12 = getelementptr inbounds i32* %pathDistanceBuffer, i64 %11
  %13 = load i32* %12, align 4, !tbaa !2
  %14 = mul i32 %pass, %numNodes
  %15 = add i32 %2, %14
  %16 = zext i32 %15 to i64
  %17 = getelementptr inbounds i32* %pathDistanceBuffer, i64 %16
  %18 = load i32* %17, align 4, !tbaa !2
  %19 = add i32 %18, %13
  %20 = icmp slt i32 %19, %9
  br i1 %20, label %21, label %23

; <label>:21                                      ; preds = %0
  store i32 %19, i32* %8, align 4, !tbaa !2
  %22 = getelementptr inbounds i32* %pathBuffer, i64 %7
  store i32 %pass, i32* %22, align 4, !tbaa !2
  br label %23

; <label>:23                                      ; preds = %21, %0
  ret void
}

declare i64 @get_global_id(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32*, i32*, i32, i32)* @floydWarshallPass}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

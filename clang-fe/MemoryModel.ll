; ModuleID = '../kernel-src/MemoryModel.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@mask = global [4 x i32] [i32 1, i32 -1, i32 2, i32 -2], align 16
@MemoryModel.localBuffer = internal unnamed_addr global [64 x i32] zeroinitializer, align 16

; Function Attrs: nounwind uwtable
define void @MemoryModel(i32* nocapture %outputbuffer, i32* nocapture readonly %inputbuffer) #0 {
  %1 = tail call i64 @get_group_id(i32 0) #2
  %2 = tail call i64 @get_local_id(i32 0) #2
  %3 = tail call i64 @get_global_id(i32 0) #2
  %4 = getelementptr inbounds i32* %inputbuffer, i64 %3
  %5 = load i32* %4, align 4, !tbaa !2
  %6 = getelementptr inbounds [64 x i32]* @MemoryModel.localBuffer, i64 0, i64 %2
  store i32 %5, i32* %6, align 4, !tbaa !2
  tail call void @barrier(i32 1) #2
  %7 = and i64 %2, 63
  %8 = getelementptr inbounds [64 x i32]* @MemoryModel.localBuffer, i64 0, i64 %7
  %9 = load i32* %8, align 4, !tbaa !2
  %10 = add i64 %2, 1
  %11 = and i64 %10, 63
  %12 = getelementptr inbounds [64 x i32]* @MemoryModel.localBuffer, i64 0, i64 %11
  %13 = load i32* %12, align 4, !tbaa !2
  %14 = add nsw i32 %13, %9
  %15 = add i64 %2, 2
  %16 = and i64 %15, 63
  %17 = getelementptr inbounds [64 x i32]* @MemoryModel.localBuffer, i64 0, i64 %16
  %18 = load i32* %17, align 4, !tbaa !2
  %19 = add nsw i32 %18, %14
  %20 = add i64 %2, 3
  %21 = and i64 %20, 63
  %22 = getelementptr inbounds [64 x i32]* @MemoryModel.localBuffer, i64 0, i64 %21
  %23 = load i32* %22, align 4, !tbaa !2
  %24 = add nsw i32 %23, %19
  %25 = and i64 %1, 3
  %26 = getelementptr inbounds [4 x i32]* @mask, i64 0, i64 %25
  %27 = load i32* %26, align 4, !tbaa !2
  %28 = mul nsw i32 %27, %24
  %29 = getelementptr inbounds i32* %outputbuffer, i64 %3
  store i32 %28, i32* %29, align 4, !tbaa !2
  ret void
}

declare i64 @get_group_id(i32) #1

declare i64 @get_local_id(i32) #1

declare i64 @get_global_id(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32*, i32*)* @MemoryModel}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

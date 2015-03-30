; ModuleID = '../kernel-src/MemoryModel.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@mask = addrspace(2) global [4 x i32] [i32 1, i32 -1, i32 2, i32 -2], align 4
@MemoryModel.localBuffer = internal addrspace(3) unnamed_addr global [64 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @MemoryModel(i32 addrspace(1)* nocapture %outputbuffer, i32 addrspace(1)* nocapture readonly %inputbuffer) #0 {
  %1 = tail call i32 @get_group_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = tail call i32 @get_global_id(i32 0) #2
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds i32 addrspace(1)* %inputbuffer, i64 %4
  %6 = load i32 addrspace(1)* %5, align 4, !tbaa !2
  %7 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %2
  store i32 %6, i32 addrspace(3)* %7, align 4, !tbaa !2
  tail call void @barrier(i32 1) #2
  %8 = and i32 %2, 63
  %9 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %8
  %10 = load i32 addrspace(3)* %9, align 4, !tbaa !2
  %11 = add i32 %2, 1
  %12 = and i32 %11, 63
  %13 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %12
  %14 = load i32 addrspace(3)* %13, align 4, !tbaa !2
  %15 = add nsw i32 %14, %10
  %16 = add i32 %2, 2
  %17 = and i32 %16, 63
  %18 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %17
  %19 = load i32 addrspace(3)* %18, align 4, !tbaa !2
  %20 = add nsw i32 %19, %15
  %21 = add i32 %2, 3
  %22 = and i32 %21, 63
  %23 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %22
  %24 = load i32 addrspace(3)* %23, align 4, !tbaa !2
  %25 = add nsw i32 %24, %20
  %26 = and i32 %1, 3
  %27 = zext i32 %26 to i64
  %28 = getelementptr inbounds [4 x i32] addrspace(2)* @mask, i64 0, i64 %27
  %29 = load i32 addrspace(2)* %28, align 4, !tbaa !2
  %30 = mul nsw i32 %29, %25
  %31 = getelementptr inbounds i32 addrspace(1)* %outputbuffer, i64 %4
  store i32 %30, i32 addrspace(1)* %31, align 4, !tbaa !2
  ret void
}

declare i32 @get_group_id(i32) #1

declare i32 @get_local_id(i32) #1

declare i32 @get_global_id(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @MemoryModel}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

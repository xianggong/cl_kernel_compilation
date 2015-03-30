; ModuleID = '../kernel-src/BitonicSort_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @bitonicSort(i32 addrspace(1)* nocapture %theArray, i32 %stage, i32 %passOfStage, i32 %direction) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %sub = sub i32 %stage, %passOfStage
  %shl.mask = and i32 %sub, 31
  %shl = shl i32 1, %shl.mask
  %mul = shl i32 %shl, 1
  %0 = add i32 %shl, -1
  %rem = and i32 %call, %0
  %div = lshr i32 %call, %shl.mask
  %mul1 = mul i32 %mul, %div
  %add = add i32 %mul1, %rem
  %add2 = add i32 %add, %shl
  %1 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %theArray, i64 %1
  %2 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !2
  %3 = sext i32 %add2 to i64
  %arrayidx3 = getelementptr inbounds i32 addrspace(1)* %theArray, i64 %3
  %4 = load i32 addrspace(1)* %arrayidx3, align 4, !tbaa !2
  %shl.mask4 = and i32 %stage, 31
  %5 = shl i32 1, %shl.mask4
  %rem742 = and i32 %call, %5
  %cmp = icmp eq i32 %rem742, 0
  %sub8 = sub i32 1, %direction
  %direction.sub8 = select i1 %cmp, i32 %direction, i32 %sub8
  %cmp9 = icmp ugt i32 %2, %4
  %greater.0 = select i1 %cmp9, i32 %2, i32 %4
  %lesser.0 = select i1 %cmp9, i32 %4, i32 %2
  %tobool = icmp eq i32 %direction.sub8, 0
  %greater.0.lesser.0 = select i1 %tobool, i32 %greater.0, i32 %lesser.0
  %lesser.0.greater.0 = select i1 %tobool, i32 %lesser.0, i32 %greater.0
  store i32 %greater.0.lesser.0, i32 addrspace(1)* %arrayidx, align 4, !tbaa !2
  store i32 %lesser.0.greater.0, i32 addrspace(1)* %arrayidx3, align 4, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32, i32, i32)* @bitonicSort}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

; ModuleID = '../kernel-src/MemoryModel.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@mask = addrspace(2) global [4 x i32] [i32 1, i32 -1, i32 2, i32 -2], align 4
@MemoryModel.localBuffer = internal addrspace(3) unnamed_addr global [64 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @MemoryModel(i32 addrspace(1)* nocapture %outputbuffer, i32 addrspace(1)* nocapture readonly %inputbuffer) #0 {
entry:
  %call = tail call i32 @get_group_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 0) #2
  %call2 = tail call i32 @get_global_id(i32 0) #2
  %0 = sext i32 %call2 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %inputbuffer, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !2
  %arrayidx3 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %call1
  store i32 %1, i32 addrspace(3)* %arrayidx3, align 4, !tbaa !2
  tail call void @barrier(i32 1) #2
  %rem = and i32 %call1, 63
  %arrayidx4 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %rem
  %2 = load i32 addrspace(3)* %arrayidx4, align 4, !tbaa !2
  %add.1 = add i32 %call1, 1
  %rem.1 = and i32 %add.1, 63
  %arrayidx4.1 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %rem.1
  %3 = load i32 addrspace(3)* %arrayidx4.1, align 4, !tbaa !2
  %add5.1 = add nsw i32 %3, %2
  %add.2 = add i32 %call1, 2
  %rem.2 = and i32 %add.2, 63
  %arrayidx4.2 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %rem.2
  %4 = load i32 addrspace(3)* %arrayidx4.2, align 4, !tbaa !2
  %add5.2 = add nsw i32 %4, %add5.1
  %add.3 = add i32 %call1, 3
  %rem.3 = and i32 %add.3, 63
  %arrayidx4.3 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %rem.3
  %5 = load i32 addrspace(3)* %arrayidx4.3, align 4, !tbaa !2
  %add5.3 = add nsw i32 %5, %add5.2
  %rem6 = and i32 %call, 3
  %6 = zext i32 %rem6 to i64
  %arrayidx7 = getelementptr inbounds [4 x i32] addrspace(2)* @mask, i64 0, i64 %6
  %7 = load i32 addrspace(2)* %arrayidx7, align 4, !tbaa !2
  %mul = mul nsw i32 %7, %add5.3
  %arrayidx8 = getelementptr inbounds i32 addrspace(1)* %outputbuffer, i64 %0
  store i32 %mul, i32 addrspace(1)* %arrayidx8, align 4, !tbaa !2
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
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

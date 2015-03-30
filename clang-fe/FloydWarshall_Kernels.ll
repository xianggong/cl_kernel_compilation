; ModuleID = '../kernel-src/FloydWarshall_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @floydWarshallPass(i32 addrspace(1)* nocapture %pathDistanceBuffer, i32 addrspace(1)* nocapture %pathBuffer, i32 %numNodes, i32 %pass) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 1) #2
  %mul = mul i32 %call1, %numNodes
  %add = add i32 %mul, %call
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !2
  %add3 = add i32 %mul, %pass
  %2 = sext i32 %add3 to i64
  %arrayidx4 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i64 %2
  %3 = load i32 addrspace(1)* %arrayidx4, align 4, !tbaa !2
  %mul5 = mul i32 %pass, %numNodes
  %add6 = add i32 %call, %mul5
  %4 = sext i32 %add6 to i64
  %arrayidx7 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i64 %4
  %5 = load i32 addrspace(1)* %arrayidx7, align 4, !tbaa !2
  %add8 = add i32 %5, %3
  %cmp = icmp slt i32 %add8, %1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 %add8, i32 addrspace(1)* %arrayidx, align 4, !tbaa !2
  %arrayidx14 = getelementptr inbounds i32 addrspace(1)* %pathBuffer, i64 %0
  store i32 %pass, i32 addrspace(1)* %arrayidx14, align 4, !tbaa !2
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32)* @floydWarshallPass}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

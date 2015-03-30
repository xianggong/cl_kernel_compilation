; ModuleID = '../kernel-src/Reduction_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @reduce(<4 x i32> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(1)* nocapture %output, <4 x i32> addrspace(3)* nocapture %sdata) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #2
  %call1 = tail call i32 @get_group_id(i32 0) #2
  %call2 = tail call i32 @get_global_id(i32 0) #2
  %call3 = tail call i32 @get_local_size(i32 0) #2
  %mul = shl i32 %call2, 1
  %0 = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %0
  %1 = load <4 x i32> addrspace(1)* %arrayidx, align 16, !tbaa !2
  %add29 = or i32 %mul, 1
  %2 = sext i32 %add29 to i64
  %arrayidx4 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %2
  %3 = load <4 x i32> addrspace(1)* %arrayidx4, align 16, !tbaa !2
  %add5 = add <4 x i32> %1, %3
  %arrayidx6 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %call
  store <4 x i32> %add5, <4 x i32> addrspace(3)* %arrayidx6, align 16, !tbaa !2
  tail call void @barrier(i32 1) #2
  %s.030 = lshr i32 %call3, 1
  %cmp31 = icmp eq i32 %s.030, 0
  br i1 %cmp31, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %if.end
  %s.032 = phi i32 [ %s.0, %if.end ], [ %s.030, %entry ]
  %cmp7 = icmp ult i32 %call, %s.032
  br i1 %cmp7, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %add8 = add i32 %s.032, %call
  %arrayidx9 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %add8
  %4 = load <4 x i32> addrspace(3)* %arrayidx9, align 16, !tbaa !2
  %5 = load <4 x i32> addrspace(3)* %arrayidx6, align 16, !tbaa !2
  %add11 = add <4 x i32> %5, %4
  store <4 x i32> %add11, <4 x i32> addrspace(3)* %arrayidx6, align 16, !tbaa !2
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  tail call void @barrier(i32 1) #2
  %s.0 = lshr i32 %s.032, 1
  %cmp = icmp eq i32 %s.0, 0
  br i1 %cmp, label %for.end, label %for.body

for.end:                                          ; preds = %if.end, %entry
  %cmp13 = icmp eq i32 %call, 0
  br i1 %cmp13, label %if.then14, label %if.end17

if.then14:                                        ; preds = %for.end
  %6 = load <4 x i32> addrspace(3)* %sdata, align 16, !tbaa !2
  %7 = sext i32 %call1 to i64
  %arrayidx16 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %7
  store <4 x i32> %6, <4 x i32> addrspace(1)* %arrayidx16, align 16, !tbaa !2
  br label %if.end17

if.end17:                                         ; preds = %if.then14, %for.end
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @reduce}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

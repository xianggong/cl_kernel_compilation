; ModuleID = '../kernel-src/DwtHaar1D_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @dwtHaar1D(float addrspace(1)* nocapture readonly %inSignal, float addrspace(1)* nocapture %coefsSignal, float addrspace(1)* nocapture %AverageSignal, float addrspace(3)* nocapture %sharedArray, i32 %tLevels, i32 %signalLength, i32 %levelsDone, i32 %mLevels) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #3
  %call1 = tail call i32 @get_group_id(i32 0) #3
  %call2 = tail call i32 @get_global_id(i32 0) #3
  %call3 = tail call i32 @get_local_size(i32 0) #3
  %mul = shl i32 %call1, 1
  %mul4 = mul i32 %mul, %call3
  %add = add i32 %mul4, %call
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %inSignal, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !2
  %add7 = add i32 %call3, %call
  %add8 = add i32 %add7, %mul4
  %2 = sext i32 %add8 to i64
  %arrayidx9 = getelementptr inbounds float addrspace(1)* %inSignal, i64 %2
  %3 = load float addrspace(1)* %arrayidx9, align 4, !tbaa !2
  %cmp = icmp eq i32 %levelsDone, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %conv = uitofp i32 %signalLength to float
  %call10 = tail call float @llvm.sqrt.f32(float %conv)
  %div = fdiv float 1.000000e+00, %call10, !fpmath !6
  %mul11 = fmul float %1, %div
  %mul12 = fmul float %3, %div
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %t1.0 = phi float [ %mul12, %if.then ], [ %3, %entry ]
  %t0.0 = phi float [ %mul11, %if.then ], [ %1, %entry ]
  %arrayidx13 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %call
  store float %t0.0, float addrspace(3)* %arrayidx13, align 4, !tbaa !2
  %arrayidx15 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %add7
  store float %t1.0, float addrspace(3)* %arrayidx15, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  %cmp16 = icmp ugt i32 %tLevels, %mLevels
  %cond = select i1 %cmp16, i32 %mLevels, i32 %tLevels
  %cmp2294 = icmp eq i32 %cond, 0
  br i1 %cmp2294, label %for.end, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %if.end
  %shl.mask = and i32 %cond, 31
  %shl = shl i32 1, %shl.mask
  %div19 = lshr i32 %signalLength, 1
  %div18 = sdiv i32 %shl, 2
  %mul27 = shl i32 %call, 1
  %arrayidx28 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %mul27
  %add3088 = or i32 %mul27, 1
  %arrayidx31 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %add3088
  %4 = xor i32 %mLevels, -1
  %5 = xor i32 %tLevels, -1
  %6 = icmp ugt i32 %4, %5
  %umax = select i1 %6, i32 %4, i32 %5
  %7 = xor i32 %umax, -1
  br label %for.body

for.body:                                         ; preds = %if.end44, %for.body.lr.ph
  %i.097 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %if.end44 ]
  %midOutPos.096 = phi i32 [ %div19, %for.body.lr.ph ], [ %midOutPos.1, %if.end44 ]
  %activeThreads.095 = phi i32 [ %div18, %for.body.lr.ph ], [ %shr45, %if.end44 ]
  %cmp24 = icmp ult i32 %call, %activeThreads.095
  br i1 %cmp24, label %if.then35, label %if.end32.thread93

if.end32.thread93:                                ; preds = %for.body
  tail call void @barrier(i32 1) #3
  br label %if.end44

if.then35:                                        ; preds = %for.body
  %8 = load float addrspace(3)* %arrayidx28, align 4, !tbaa !2
  %9 = load float addrspace(3)* %arrayidx31, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  %add36 = fadd float %8, %9
  %mul37 = fmul float %add36, 0x3FE6A09E60000000
  store float %mul37, float addrspace(3)* %arrayidx13, align 4, !tbaa !2
  %mul39 = mul i32 %activeThreads.095, %call1
  %add40 = add i32 %mul39, %call
  %add41 = add i32 %add40, %midOutPos.096
  %sub = fsub float %8, %9
  %mul42 = fmul float %sub, 0x3FE6A09E60000000
  %10 = sext i32 %add41 to i64
  %arrayidx43 = getelementptr inbounds float addrspace(1)* %coefsSignal, i64 %10
  store float %mul42, float addrspace(1)* %arrayidx43, align 4, !tbaa !2
  %shr = lshr i32 %midOutPos.096, 1
  br label %if.end44

if.end44:                                         ; preds = %if.end32.thread93, %if.then35
  %midOutPos.1 = phi i32 [ %shr, %if.then35 ], [ %midOutPos.096, %if.end32.thread93 ]
  %shr45 = lshr i32 %activeThreads.095, 1
  tail call void @barrier(i32 1) #3
  %inc = add i32 %i.097, 1
  %exitcond = icmp eq i32 %inc, %7
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %if.end44, %if.end
  %cmp46 = icmp eq i32 %call, 0
  br i1 %cmp46, label %if.then48, label %if.end51

if.then48:                                        ; preds = %for.end
  %11 = load float addrspace(3)* %sharedArray, align 4, !tbaa !2
  %12 = sext i32 %call1 to i64
  %arrayidx50 = getelementptr inbounds float addrspace(1)* %AverageSignal, i64 %12
  store float %11, float addrspace(1)* %arrayidx50, align 4, !tbaa !2
  br label %if.end51

if.end51:                                         ; preds = %if.then48, %for.end
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_local_size(i32) #1

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32, i32)* @dwtHaar1D}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{float 2.500000e+00}

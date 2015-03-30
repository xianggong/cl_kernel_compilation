; ModuleID = '../kernel-src/DCT_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind readnone
define i32 @getIdx(i32 %blockIdx, i32 %blockIdy, i32 %localIdx, i32 %localIdy, i32 %blockWidth, i32 %globalWidth) #0 {
entry:
  %mul = mul i32 %blockWidth, %blockIdx
  %add = add i32 %mul, %localIdx
  %mul1 = mul i32 %blockWidth, %blockIdy
  %add2 = add i32 %mul1, %localIdy
  %mul3 = mul i32 %add2, %globalWidth
  %add4 = add i32 %add, %mul3
  ret i32 %add4
}

; Function Attrs: nounwind
define void @DCT(float addrspace(1)* nocapture %output, float addrspace(1)* nocapture readonly %input, float addrspace(1)* nocapture readonly %dct8x8, float addrspace(1)* nocapture readonly %dct8x8_trans, float addrspace(3)* nocapture %inter, i32 %width, i32 %blockWidth, i32 %inverse) #1 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %call2 = tail call i32 @get_group_id(i32 0) #3
  %call3 = tail call i32 @get_group_id(i32 1) #3
  %call4 = tail call i32 @get_local_id(i32 0) #3
  %call5 = tail call i32 @get_local_id(i32 1) #3
  %mul = mul i32 %call1, %width
  %add = add i32 %mul, %call
  %cmp76 = icmp eq i32 %blockWidth, 0
  %mul6 = mul i32 %call5, %blockWidth
  br i1 %cmp76, label %for.end43.critedge, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %mul.i = mul i32 %call2, %blockWidth
  %add.i = add i32 %call4, %mul.i
  %mul1.i = mul i32 %call3, %blockWidth
  %tobool = icmp eq i32 %inverse, 0
  br label %for.body

for.body:                                         ; preds = %for.inc, %for.body.lr.ph
  %acc.078 = phi float [ 0.000000e+00, %for.body.lr.ph ], [ %acc.1, %for.inc ]
  %k.077 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.inc ]
  %add7 = add i32 %k.077, %mul6
  %add2.i = add i32 %k.077, %mul1.i
  %mul3.i = mul i32 %add2.i, %width
  %add4.i = add i32 %add.i, %mul3.i
  %0 = sext i32 %add7 to i64
  br i1 %tobool, label %if.else, label %if.then

if.then:                                          ; preds = %for.body
  %arrayidx = getelementptr inbounds float addrspace(1)* %dct8x8, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !2
  %2 = sext i32 %add4.i to i64
  %arrayidx9 = getelementptr inbounds float addrspace(1)* %input, i64 %2
  %3 = load float addrspace(1)* %arrayidx9, align 4, !tbaa !2
  %mul10 = fmul float %1, %3
  br label %for.inc

if.else:                                          ; preds = %for.body
  %arrayidx12 = getelementptr inbounds float addrspace(1)* %dct8x8_trans, i64 %0
  %4 = load float addrspace(1)* %arrayidx12, align 4, !tbaa !2
  %5 = sext i32 %add4.i to i64
  %arrayidx13 = getelementptr inbounds float addrspace(1)* %input, i64 %5
  %6 = load float addrspace(1)* %arrayidx13, align 4, !tbaa !2
  %mul14 = fmul float %4, %6
  br label %for.inc

for.inc:                                          ; preds = %if.then, %if.else
  %mul10.pn = phi float [ %mul10, %if.then ], [ %mul14, %if.else ]
  %acc.1 = fadd float %acc.078, %mul10.pn
  %inc = add i32 %k.077, 1
  %exitcond81 = icmp eq i32 %inc, %blockWidth
  br i1 %exitcond81, label %for.end, label %for.body

for.end:                                          ; preds = %for.inc
  %add17 = add i32 %mul6, %call4
  %arrayidx18 = getelementptr inbounds float addrspace(3)* %inter, i32 %add17
  store float %acc.1, float addrspace(3)* %arrayidx18, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  br i1 %cmp76, label %for.end43, label %for.body22.lr.ph

for.body22.lr.ph:                                 ; preds = %for.end
  %tobool29 = icmp eq i32 %inverse, 0
  %dct8x8_trans.sink = select i1 %tobool29, float addrspace(1)* %dct8x8, float addrspace(1)* %dct8x8_trans
  br label %for.body22

for.body22:                                       ; preds = %for.body22, %for.body22.lr.ph
  %acc.275 = phi float [ 0.000000e+00, %for.body22.lr.ph ], [ %acc.3, %for.body22 ]
  %k19.074 = phi i32 [ 0, %for.body22.lr.ph ], [ %inc42, %for.body22 ]
  %add25 = add i32 %k19.074, %mul6
  %mul27 = mul i32 %k19.074, %blockWidth
  %add28 = add i32 %mul27, %call4
  %arrayidx31 = getelementptr inbounds float addrspace(3)* %inter, i32 %add25
  %7 = load float addrspace(3)* %arrayidx31, align 4, !tbaa !2
  %8 = sext i32 %add28 to i64
  %arrayidx32 = getelementptr inbounds float addrspace(1)* %dct8x8_trans.sink, i64 %8
  %.pn = load float addrspace(1)* %arrayidx32, align 4
  %mul33.pn = fmul float %7, %.pn
  %acc.3 = fadd float %acc.275, %mul33.pn
  %inc42 = add i32 %k19.074, 1
  %exitcond = icmp eq i32 %inc42, %blockWidth
  br i1 %exitcond, label %for.end43, label %for.body22

for.end43.critedge:                               ; preds = %entry
  %add17.c = add i32 %mul6, %call4
  %arrayidx18.c = getelementptr inbounds float addrspace(3)* %inter, i32 %add17.c
  store float 0.000000e+00, float addrspace(3)* %arrayidx18.c, align 4, !tbaa !2
  tail call void @barrier(i32 1) #3
  br label %for.end43

for.end43:                                        ; preds = %for.end43.critedge, %for.body22, %for.end
  %acc.2.lcssa = phi float [ 0.000000e+00, %for.end ], [ %acc.3, %for.body22 ], [ 0.000000e+00, %for.end43.critedge ]
  %9 = sext i32 %add to i64
  %arrayidx44 = getelementptr inbounds float addrspace(1)* %output, i64 %9
  store float %acc.2.lcssa, float addrspace(1)* %arrayidx44, align 4, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #2

declare i32 @get_group_id(i32) #2

declare i32 @get_local_id(i32) #2

declare void @barrier(i32) #2

attributes #0 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32)* @DCT}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"float", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

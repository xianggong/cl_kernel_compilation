; ModuleID = '../kernel-src/BoxFilter_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @box_filter(<4 x i32> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %N) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %call2 = tail call i32 @get_global_size(i32 0) #3
  %call3 = tail call i32 @get_global_size(i32 1) #3
  %sub = add i32 %N, -1
  %div = lshr i32 %sub, 1
  %cmp = icmp slt i32 %call, %div
  %cmp4 = icmp slt i32 %call1, %div
  %or.cond = or i1 %cmp, %cmp4
  br i1 %or.cond, label %if.then, label %lor.lhs.false5

lor.lhs.false5:                                   ; preds = %entry
  %sub6 = xor i32 %div, -1
  %sub7 = add i32 %call2, %sub6
  %cmp8 = icmp sgt i32 %call, %sub7
  %sub11 = add i32 %call3, %sub6
  %cmp12 = icmp sgt i32 %call1, %sub11
  %or.cond132 = or i1 %cmp8, %cmp12
  br i1 %or.cond132, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false5, %entry
  %mul = mul nsw i32 %call2, %call1
  %add = add nsw i32 %mul, %call
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %0
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %arrayidx, align 4, !tbaa !8
  br label %return

if.end:                                           ; preds = %lor.lhs.false5
  %mul13 = mul i32 %N, %N
  %splat.splatinsert = insertelement <4 x i32> undef, i32 %mul13, i32 0
  %splat.splat = shufflevector <4 x i32> %splat.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %sub14 = sub nsw i32 %call, %div
  %sub15 = sub nsw i32 %call1, %div
  %add18 = add nsw i32 %call, %div
  %add25 = add nsw i32 %call1, %div
  %sub32 = add nsw i32 %sub14, -1
  %sub33 = add nsw i32 %sub15, -1
  %cmp36 = icmp sgt i32 %sub14, 0
  %cmp37 = icmp sgt i32 %sub15, 0
  %or.cond129 = and i1 %cmp36, %cmp37
  br i1 %or.cond129, label %if.then38, label %if.end43

if.then38:                                        ; preds = %if.end
  %mul39 = mul nsw i32 %sub33, %call2
  %add40 = add nsw i32 %mul39, %sub32
  %1 = sext i32 %add40 to i64
  %arrayidx41 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %1
  %2 = load <4 x i32> addrspace(1)* %arrayidx41, align 16, !tbaa !8
  %call42 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %2) #3
  br label %if.end43

if.end43:                                         ; preds = %if.then38, %if.end
  %sumA.0 = phi <4 x i32> [ %call42, %if.then38 ], [ zeroinitializer, %if.end ]
  %cmp44 = icmp sgt i32 %add18, -1
  %or.cond130 = and i1 %cmp44, %cmp37
  br i1 %or.cond130, label %if.then47, label %if.end52

if.then47:                                        ; preds = %if.end43
  %mul48 = mul nsw i32 %sub33, %call2
  %add49 = add nsw i32 %mul48, %add18
  %3 = sext i32 %add49 to i64
  %arrayidx50 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %3
  %4 = load <4 x i32> addrspace(1)* %arrayidx50, align 16, !tbaa !8
  %call51 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %4) #3
  br label %if.end52

if.end52:                                         ; preds = %if.then47, %if.end43
  %sumB.0 = phi <4 x i32> [ %call51, %if.then47 ], [ zeroinitializer, %if.end43 ]
  %cmp55 = icmp sgt i32 %add25, -1
  %or.cond131 = and i1 %cmp36, %cmp55
  %mul57 = mul nsw i32 %add25, %call2
  br i1 %or.cond131, label %if.then56, label %if.end61

if.then56:                                        ; preds = %if.end52
  %add58 = add nsw i32 %mul57, %sub32
  %5 = sext i32 %add58 to i64
  %arrayidx59 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %5
  %6 = load <4 x i32> addrspace(1)* %arrayidx59, align 16, !tbaa !8
  %call60 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %6) #3
  br label %if.end61

if.end61:                                         ; preds = %if.end52, %if.then56
  %sumD.0 = phi <4 x i32> [ %call60, %if.then56 ], [ zeroinitializer, %if.end52 ]
  %add63 = add nsw i32 %mul57, %add18
  %7 = sext i32 %add63 to i64
  %arrayidx64 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %7
  %8 = load <4 x i32> addrspace(1)* %arrayidx64, align 16, !tbaa !8
  %call65 = tail call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %8) #3
  %add66 = add <4 x i32> %sumA.0, %call65
  %sub67 = sub <4 x i32> %add66, %sumB.0
  %sub68 = sub <4 x i32> %sub67, %sumD.0
  %div69 = sdiv <4 x i32> %sub68, %splat.splat
  %call70 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div69) #3
  %mul71 = mul nsw i32 %call2, %call1
  %add72 = add nsw i32 %mul71, %call
  %9 = sext i32 %add72 to i64
  %arrayidx73 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %9
  store <4 x i8> %call70, <4 x i8> addrspace(1)* %arrayidx73, align 4, !tbaa !8
  br label %return

return:                                           ; preds = %if.end61, %if.then
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32>) #1

declare <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind
define void @horizontalSAT0(<4 x i8> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(1)* nocapture %output, i32 %i, i32 %r, i32 %width) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %mul = mul nsw i32 %call1, %width
  %add = add nsw i32 %mul, %call
  %conv = sitofp i32 %r to float
  %conv2 = sitofp i32 %i to float
  %call3 = tail call float @llvm.pow.f32(float %conv, float %conv2)
  %conv4 = fptosi float %call3 to i32
  %cmp27 = icmp sgt i32 %r, 0
  br i1 %cmp27, label %for.body, label %for.end

for.body:                                         ; preds = %entry, %if.end
  %indvars.iv = phi i64 [ %indvars.iv.next, %if.end ], [ 0, %entry ]
  %sum.028 = phi <4 x i32> [ %add13, %if.end ], [ zeroinitializer, %entry ]
  %0 = trunc i64 %indvars.iv to i32
  %mul6 = mul nsw i32 %0, %conv4
  %sub = sub nsw i32 %call, %mul6
  %cmp7 = icmp slt i32 %sub, 0
  br i1 %cmp7, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %1 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %1
  store <4 x i32> %sum.028, <4 x i32> addrspace(1)* %arrayidx, align 16, !tbaa !8
  br label %return

if.end:                                           ; preds = %for.body
  %sub10 = sub nsw i32 %add, %mul6
  %2 = sext i32 %sub10 to i64
  %arrayidx11 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %2
  %3 = load <4 x i8> addrspace(1)* %arrayidx11, align 4, !tbaa !8
  %call12 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %3) #3
  %add13 = add <4 x i32> %sum.028, %call12
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %4 = trunc i64 %indvars.iv.next to i32
  %cmp = icmp slt i32 %4, %r
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %if.end, %entry
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %entry ], [ %add13, %if.end ]
  %5 = sext i32 %add to i64
  %arrayidx14 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %5
  store <4 x i32> %sum.0.lcssa, <4 x i32> addrspace(1)* %arrayidx14, align 16, !tbaa !8
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #2

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @horizontalSAT(<4 x i32> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(1)* nocapture %output, i32 %i, i32 %r, i32 %width) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %mul = mul nsw i32 %call1, %width
  %add = add nsw i32 %mul, %call
  %conv = sitofp i32 %r to float
  %conv2 = sitofp i32 %i to float
  %call3 = tail call float @llvm.pow.f32(float %conv, float %conv2)
  %conv4 = fptosi float %call3 to i32
  %cmp26 = icmp sgt i32 %r, 0
  br i1 %cmp26, label %for.body, label %for.end

for.body:                                         ; preds = %entry, %if.end
  %indvars.iv = phi i64 [ %indvars.iv.next, %if.end ], [ 0, %entry ]
  %sum.027 = phi <4 x i32> [ %add12, %if.end ], [ zeroinitializer, %entry ]
  %0 = trunc i64 %indvars.iv to i32
  %mul6 = mul nsw i32 %0, %conv4
  %sub = sub nsw i32 %call, %mul6
  %cmp7 = icmp slt i32 %sub, 0
  br i1 %cmp7, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %1 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %1
  store <4 x i32> %sum.027, <4 x i32> addrspace(1)* %arrayidx, align 16, !tbaa !8
  br label %return

if.end:                                           ; preds = %for.body
  %sub10 = sub nsw i32 %add, %mul6
  %2 = sext i32 %sub10 to i64
  %arrayidx11 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %2
  %3 = load <4 x i32> addrspace(1)* %arrayidx11, align 16, !tbaa !8
  %add12 = add <4 x i32> %sum.027, %3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %4 = trunc i64 %indvars.iv.next to i32
  %cmp = icmp slt i32 %4, %r
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %if.end, %entry
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %entry ], [ %add12, %if.end ]
  %5 = sext i32 %add to i64
  %arrayidx13 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %5
  store <4 x i32> %sum.0.lcssa, <4 x i32> addrspace(1)* %arrayidx13, align 16, !tbaa !8
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind
define void @verticalSAT(<4 x i32> addrspace(1)* nocapture readonly %input, <4 x i32> addrspace(1)* nocapture %output, i32 %i, i32 %r, i32 %width) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %conv = sitofp i32 %r to float
  %conv2 = sitofp i32 %i to float
  %call3 = tail call float @llvm.pow.f32(float %conv, float %conv2)
  %conv4 = fptosi float %call3 to i32
  %cmp34 = icmp sgt i32 %r, 0
  br i1 %cmp34, label %for.body, label %for.end

for.body:                                         ; preds = %entry, %if.end
  %indvars.iv = phi i64 [ %indvars.iv.next, %if.end ], [ 0, %entry ]
  %sum.035 = phi <4 x i32> [ %add14, %if.end ], [ zeroinitializer, %entry ]
  %0 = trunc i64 %indvars.iv to i32
  %mul = mul nsw i32 %0, %conv4
  %sub = sub nsw i32 %call1, %mul
  %cmp6 = icmp slt i32 %sub, 0
  br i1 %cmp6, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %mul8 = mul nsw i32 %call1, %width
  %add = add nsw i32 %mul8, %call
  %1 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %1
  store <4 x i32> %sum.035, <4 x i32> addrspace(1)* %arrayidx, align 16, !tbaa !8
  br label %return

if.end:                                           ; preds = %for.body
  %mul11 = mul nsw i32 %sub, %width
  %add12 = add nsw i32 %mul11, %call
  %2 = sext i32 %add12 to i64
  %arrayidx13 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %2
  %3 = load <4 x i32> addrspace(1)* %arrayidx13, align 16, !tbaa !8
  %add14 = add <4 x i32> %sum.035, %3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %4 = trunc i64 %indvars.iv.next to i32
  %cmp = icmp slt i32 %4, %r
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %if.end, %entry
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %entry ], [ %add14, %if.end ]
  %mul15 = mul nsw i32 %call1, %width
  %add16 = add nsw i32 %mul15, %call
  %5 = sext i32 %add16 to i64
  %arrayidx17 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %5
  store <4 x i32> %sum.0.lcssa, <4 x i32> addrspace(1)* %arrayidx17, align 16, !tbaa !8
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %filterWidth) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %call2 = tail call i32 @get_global_size(i32 0) #3
  %call3 = tail call i32 @get_global_size(i32 1) #3
  %mul = mul nsw i32 %call2, %call1
  %add = add nsw i32 %mul, %call
  %sub = add nsw i32 %filterWidth, -1
  %div = sdiv i32 %sub, 2
  %cmp = icmp sge i32 %call, %div
  %sub4 = sub nsw i32 %call2, %div
  %cmp5 = icmp slt i32 %call, %sub4
  %or.cond = and i1 %cmp, %cmp5
  br i1 %or.cond, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %0
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %arrayidx, align 4, !tbaa !8
  br label %return

if.end:                                           ; preds = %entry
  %splat.splatinsert = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %splat.splat = shufflevector <4 x i32> %splat.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %sub6 = sub i32 0, %div
  %cmp745 = icmp sgt i32 %div, %sub6
  br i1 %cmp745, label %for.body.lr.ph, label %if.end.for.end_crit_edge

if.end.for.end_crit_edge:                         ; preds = %if.end
  %.pre = sext i32 %add to i64
  br label %for.end

for.body.lr.ph:                                   ; preds = %if.end
  %1 = sext i32 %sub6 to i64
  %2 = sext i32 %add to i64
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %indvars.iv = phi i64 [ %1, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %sum.046 = phi <4 x i32> [ zeroinitializer, %for.body.lr.ph ], [ %add16, %for.body ]
  %3 = add nsw i64 %indvars.iv, %2
  %arrayidx9 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %3
  %4 = load <4 x i8> addrspace(1)* %arrayidx9, align 4, !tbaa !8
  %call10 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %4) #3
  %add11 = add <4 x i32> %sum.046, %call10
  %5 = add nsw i64 %3, 1
  %arrayidx14 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %5
  %6 = load <4 x i8> addrspace(1)* %arrayidx14, align 4, !tbaa !8
  %call15 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %6) #3
  %add16 = add <4 x i32> %add11, %call15
  %indvars.iv.next = add nsw i64 %indvars.iv, 2
  %7 = trunc i64 %indvars.iv.next to i32
  %cmp7 = icmp slt i32 %7, %div
  br i1 %cmp7, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %if.end.for.end_crit_edge
  %.pre-phi = phi i64 [ %.pre, %if.end.for.end_crit_edge ], [ %2, %for.body ]
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %if.end.for.end_crit_edge ], [ %add16, %for.body ]
  %add18 = add nsw i32 %add, %div
  %8 = sext i32 %add18 to i64
  %arrayidx19 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %8
  %9 = load <4 x i8> addrspace(1)* %arrayidx19, align 4, !tbaa !8
  %call20 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %9) #3
  %add21 = add <4 x i32> %sum.0.lcssa, %call20
  %div22 = sdiv <4 x i32> %add21, %splat.splat
  %call23 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div22) #3
  %arrayidx24 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %.pre-phi
  store <4 x i8> %call23, <4 x i8> addrspace(1)* %arrayidx24, align 4, !tbaa !8
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

declare <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @box_filter_vertical(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %filterWidth) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %call2 = tail call i32 @get_global_size(i32 0) #3
  %call3 = tail call i32 @get_global_size(i32 1) #3
  %mul = mul nsw i32 %call2, %call1
  %add = add nsw i32 %mul, %call
  %sub = add nsw i32 %filterWidth, -1
  %div = sdiv i32 %sub, 2
  %cmp = icmp sge i32 %call1, %div
  %sub4 = sub nsw i32 %call3, %div
  %cmp5 = icmp slt i32 %call1, %sub4
  %or.cond = and i1 %cmp, %cmp5
  br i1 %or.cond, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %0
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %arrayidx, align 4, !tbaa !8
  br label %return

if.end:                                           ; preds = %entry
  %splat.splatinsert = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %splat.splat = shufflevector <4 x i32> %splat.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %sub6 = sub i32 0, %div
  %cmp750 = icmp sgt i32 %div, %sub6
  br i1 %cmp750, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %if.end
  %1 = sext i32 %sub6 to i64
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %indvars.iv = phi i64 [ %1, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %sum.051 = phi <4 x i32> [ zeroinitializer, %for.body.lr.ph ], [ %add18, %for.body ]
  %2 = trunc i64 %indvars.iv to i32
  %mul8 = mul nsw i32 %2, %call2
  %add9 = add nsw i32 %mul8, %add
  %3 = sext i32 %add9 to i64
  %arrayidx10 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %3
  %4 = load <4 x i8> addrspace(1)* %arrayidx10, align 4, !tbaa !8
  %call11 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %4) #3
  %add12 = add <4 x i32> %sum.051, %call11
  %5 = add nsw i64 %indvars.iv, 1
  %6 = trunc i64 %5 to i32
  %mul14 = mul nsw i32 %6, %call2
  %add15 = add nsw i32 %mul14, %add
  %7 = sext i32 %add15 to i64
  %arrayidx16 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %7
  %8 = load <4 x i8> addrspace(1)* %arrayidx16, align 4, !tbaa !8
  %call17 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %8) #3
  %add18 = add <4 x i32> %add12, %call17
  %indvars.iv.next = add nsw i64 %indvars.iv, 2
  %9 = trunc i64 %indvars.iv.next to i32
  %cmp7 = icmp slt i32 %9, %div
  br i1 %cmp7, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %if.end
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %if.end ], [ %add18, %for.body ]
  %mul20 = mul nsw i32 %div, %call2
  %add21 = add nsw i32 %mul20, %add
  %10 = sext i32 %add21 to i64
  %arrayidx22 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %10
  %11 = load <4 x i8> addrspace(1)* %arrayidx22, align 4, !tbaa !8
  %call23 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %11) #3
  %add24 = add <4 x i32> %sum.0.lcssa, %call23
  %div25 = sdiv <4 x i32> %add24, %splat.splat
  %call26 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div25) #3
  %12 = sext i32 %add to i64
  %arrayidx27 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %12
  store <4 x i8> %call26, <4 x i8> addrspace(1)* %arrayidx27, align 4, !tbaa !8
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal_local(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %filterWidth, <4 x i8> addrspace(3)* nocapture %lds) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %call2 = tail call i32 @get_global_size(i32 0) #3
  %call3 = tail call i32 @get_global_size(i32 1) #3
  %mul = mul nsw i32 %call2, %call1
  %add = add nsw i32 %mul, %call
  %sub = add nsw i32 %filterWidth, -1
  %div = sdiv i32 %sub, 2
  %sub31 = sub nsw i32 0, %div
  %call4 = tail call i32 @get_local_id(i32 0) #3
  %call5 = tail call i32 @get_group_id(i32 0) #3
  %call6 = tail call i32 @get_group_id(i32 1) #3
  %call7 = tail call i32 @get_local_size(i32 0) #3
  %call8 = tail call i32 @get_local_size(i32 1) #3
  %mul9 = mul nsw i32 %call7, %call5
  %mul10 = mul nsw i32 %call6, %call2
  %mul11 = mul nsw i32 %mul10, %call8
  %add12 = add nsw i32 %mul11, %mul9
  %cmp = icmp slt i32 %call4, %div
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %sub13 = sub i32 %call4, %div
  %add14 = add i32 %sub13, %add12
  %0 = sext i32 %add14 to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %0
  %1 = load <4 x i8> addrspace(1)* %arrayidx, align 4, !tbaa !8
  %arrayidx15 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %call4
  store <4 x i8> %1, <4 x i8> addrspace(3)* %arrayidx15, align 4, !tbaa !8
  %add16 = add i32 %call4, 256
  %add17 = add i32 %add16, %add12
  %2 = sext i32 %add17 to i64
  %arrayidx18 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %2
  %3 = load <4 x i8> addrspace(1)* %arrayidx18, align 4, !tbaa !8
  %add19 = add nsw i32 %div, 256
  %add20 = add nsw i32 %add19, %call4
  %arrayidx21 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %add20
  store <4 x i8> %3, <4 x i8> addrspace(3)* %arrayidx21, align 4, !tbaa !8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %add22 = add nsw i32 %add12, %call4
  %4 = sext i32 %add22 to i64
  %arrayidx23 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %4
  %5 = load <4 x i8> addrspace(1)* %arrayidx23, align 4, !tbaa !8
  %add24 = add i32 %call4, %div
  %arrayidx25 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %add24
  store <4 x i8> %5, <4 x i8> addrspace(3)* %arrayidx25, align 4, !tbaa !8
  tail call void @barrier(i32 1) #3
  %cmp26 = icmp sge i32 %call, %div
  %sub27 = sub nsw i32 %call2, %div
  %cmp28 = icmp slt i32 %call, %sub27
  %or.cond = and i1 %cmp26, %cmp28
  br i1 %or.cond, label %if.end30, label %return

if.end30:                                         ; preds = %if.end
  %splat.splatinsert = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %splat.splat = shufflevector <4 x i32> %splat.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %cmp3271 = icmp slt i32 %div, %sub31
  br i1 %cmp3271, label %for.end, label %for.body

for.body:                                         ; preds = %if.end30, %for.body
  %X.073 = phi i32 [ %inc, %for.body ], [ %sub31, %if.end30 ]
  %sum.072 = phi <4 x i32> [ %add37, %for.body ], [ zeroinitializer, %if.end30 ]
  %add34 = add i32 %add24, %X.073
  %arrayidx35 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %add34
  %6 = load <4 x i8> addrspace(3)* %arrayidx35, align 4, !tbaa !8
  %call36 = tail call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %6) #3
  %add37 = add <4 x i32> %sum.072, %call36
  %inc = add nsw i32 %X.073, 1
  %cmp32 = icmp slt i32 %X.073, %div
  br i1 %cmp32, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %if.end30
  %sum.0.lcssa = phi <4 x i32> [ zeroinitializer, %if.end30 ], [ %add37, %for.body ]
  %div38 = sdiv <4 x i32> %sum.0.lcssa, %splat.splat
  %call39 = tail call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div38) #3
  %7 = sext i32 %add to i64
  %arrayidx40 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %7
  store <4 x i8> %call39, <4 x i8> addrspace(1)* %arrayidx40, align 4, !tbaa !8
  br label %return

return:                                           ; preds = %if.end, %for.end
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter}
!1 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT0}
!2 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT}
!3 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @verticalSAT}
!4 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_horizontal}
!5 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_vertical}
!6 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, <4 x i8> addrspace(3)*)* @box_filter_horizontal_local}
!7 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"omnipotent char", metadata !10, i64 0}
!10 = metadata !{metadata !"Simple C/C++ TBAA"}

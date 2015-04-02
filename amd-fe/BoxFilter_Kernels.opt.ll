; ModuleID = 'BoxFilter_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_box_filter_kernel(<4 x i32> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %N) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %sub = sub i32 %N, 1
  %div = udiv i32 %sub, 2
  %cmp = icmp slt i32 %conv, %div
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %cmp8 = icmp slt i32 %conv2, %div
  br i1 %cmp8, label %if.then, label %lor.lhs.false10

lor.lhs.false10:                                  ; preds = %lor.lhs.false
  %sub11 = sub nsw i32 %conv4, %div
  %sub12 = sub nsw i32 %sub11, 1
  %cmp13 = icmp sgt i32 %conv, %sub12
  br i1 %cmp13, label %if.then, label %lor.lhs.false15

lor.lhs.false15:                                  ; preds = %lor.lhs.false10
  %sub16 = sub nsw i32 %conv6, %div
  %sub17 = sub nsw i32 %sub16, 1
  %cmp18 = icmp sgt i32 %conv2, %sub17
  br i1 %cmp18, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false15, %lor.lhs.false10, %lor.lhs.false, %entry
  %mul = mul nsw i32 %conv2, %conv4
  %add = add nsw i32 %conv, %mul
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %arrayidx, align 4
  br label %return

if.end:                                           ; preds = %lor.lhs.false15
  %mul20 = mul i32 %N, %N
  %0 = insertelement <4 x i32> undef, i32 %mul20, i32 0
  %splat = shufflevector <4 x i32> %0, <4 x i32> %0, <4 x i32> zeroinitializer
  %sub21 = sub nsw i32 %conv, %div
  %vecinit = insertelement <2 x i32> undef, i32 %sub21, i32 0
  %sub22 = sub nsw i32 %conv2, %div
  %vecinit23 = insertelement <2 x i32> %vecinit, i32 %sub22, i32 1
  %add25 = add nsw i32 %conv, %div
  %vecinit26 = insertelement <2 x i32> undef, i32 %add25, i32 0
  %sub27 = sub nsw i32 %conv2, %div
  %vecinit28 = insertelement <2 x i32> %vecinit26, i32 %sub27, i32 1
  %add30 = add nsw i32 %conv, %div
  %vecinit31 = insertelement <2 x i32> undef, i32 %add30, i32 0
  %add32 = add nsw i32 %conv2, %div
  %vecinit33 = insertelement <2 x i32> %vecinit31, i32 %add32, i32 1
  %sub35 = sub nsw i32 %conv, %div
  %vecinit36 = insertelement <2 x i32> undef, i32 %sub35, i32 0
  %add37 = add nsw i32 %conv2, %div
  %vecinit38 = insertelement <2 x i32> %vecinit36, i32 %add37, i32 1
  %1 = extractelement <2 x i32> %vecinit23, i32 0
  %sub39 = sub nsw i32 %1, 1
  %2 = insertelement <2 x i32> %vecinit23, i32 %sub39, i32 0
  %3 = extractelement <2 x i32> %2, i32 1
  %sub40 = sub nsw i32 %3, 1
  %4 = insertelement <2 x i32> %2, i32 %sub40, i32 1
  %5 = extractelement <2 x i32> %vecinit28, i32 1
  %sub41 = sub nsw i32 %5, 1
  %6 = insertelement <2 x i32> %vecinit28, i32 %sub41, i32 1
  %7 = extractelement <2 x i32> %vecinit38, i32 0
  %sub42 = sub nsw i32 %7, 1
  %8 = insertelement <2 x i32> %vecinit38, i32 %sub42, i32 0
  %9 = extractelement <2 x i32> %4, i32 0
  %cmp43 = icmp sge i32 %9, 0
  br i1 %cmp43, label %land.lhs.true, label %if.end53

land.lhs.true:                                    ; preds = %if.end
  %10 = extractelement <2 x i32> %4, i32 1
  %cmp45 = icmp sge i32 %10, 0
  br i1 %cmp45, label %if.then47, label %if.end53

if.then47:                                        ; preds = %land.lhs.true
  %11 = extractelement <2 x i32> %4, i32 0
  %12 = extractelement <2 x i32> %4, i32 1
  %mul48 = mul nsw i32 %12, %conv4
  %add49 = add nsw i32 %11, %mul48
  %idxprom50 = sext i32 %add49 to i64
  %arrayidx51 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %idxprom50
  %13 = load <4 x i32> addrspace(1)* %arrayidx51, align 16
  %call52 = call cc75 <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %13) #1
  br label %if.end53

if.end53:                                         ; preds = %if.then47, %land.lhs.true, %if.end
  %sumA.0 = phi <4 x i32> [ %call52, %if.then47 ], [ zeroinitializer, %land.lhs.true ], [ zeroinitializer, %if.end ]
  %14 = extractelement <2 x i32> %6, i32 0
  %cmp54 = icmp sge i32 %14, 0
  br i1 %cmp54, label %land.lhs.true56, label %if.end65

land.lhs.true56:                                  ; preds = %if.end53
  %15 = extractelement <2 x i32> %6, i32 1
  %cmp57 = icmp sge i32 %15, 0
  br i1 %cmp57, label %if.then59, label %if.end65

if.then59:                                        ; preds = %land.lhs.true56
  %16 = extractelement <2 x i32> %6, i32 0
  %17 = extractelement <2 x i32> %6, i32 1
  %mul60 = mul nsw i32 %17, %conv4
  %add61 = add nsw i32 %16, %mul60
  %idxprom62 = sext i32 %add61 to i64
  %arrayidx63 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %idxprom62
  %18 = load <4 x i32> addrspace(1)* %arrayidx63, align 16
  %call64 = call cc75 <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %18) #1
  br label %if.end65

if.end65:                                         ; preds = %if.then59, %land.lhs.true56, %if.end53
  %sumB.0 = phi <4 x i32> [ %call64, %if.then59 ], [ zeroinitializer, %land.lhs.true56 ], [ zeroinitializer, %if.end53 ]
  %19 = extractelement <2 x i32> %8, i32 0
  %cmp66 = icmp sge i32 %19, 0
  br i1 %cmp66, label %land.lhs.true68, label %if.end77

land.lhs.true68:                                  ; preds = %if.end65
  %20 = extractelement <2 x i32> %8, i32 1
  %cmp69 = icmp sge i32 %20, 0
  br i1 %cmp69, label %if.then71, label %if.end77

if.then71:                                        ; preds = %land.lhs.true68
  %21 = extractelement <2 x i32> %8, i32 0
  %22 = extractelement <2 x i32> %8, i32 1
  %mul72 = mul nsw i32 %22, %conv4
  %add73 = add nsw i32 %21, %mul72
  %idxprom74 = sext i32 %add73 to i64
  %arrayidx75 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %idxprom74
  %23 = load <4 x i32> addrspace(1)* %arrayidx75, align 16
  %call76 = call cc75 <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %23) #1
  br label %if.end77

if.end77:                                         ; preds = %if.then71, %land.lhs.true68, %if.end65
  %sumD.0 = phi <4 x i32> [ %call76, %if.then71 ], [ zeroinitializer, %land.lhs.true68 ], [ zeroinitializer, %if.end65 ]
  %24 = extractelement <2 x i32> %vecinit33, i32 0
  %25 = extractelement <2 x i32> %vecinit33, i32 1
  %mul78 = mul nsw i32 %25, %conv4
  %add79 = add nsw i32 %24, %mul78
  %idxprom80 = sext i32 %add79 to i64
  %arrayidx81 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i64 %idxprom80
  %26 = load <4 x i32> addrspace(1)* %arrayidx81, align 16
  %call82 = call cc75 <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %26) #1
  %add83 = add <4 x i32> %sumA.0, %call82
  %sub84 = sub <4 x i32> %add83, %sumB.0
  %sub85 = sub <4 x i32> %sub84, %sumD.0
  %div86 = sdiv <4 x i32> %sub85, %splat
  %call87 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div86) #1
  %mul88 = mul nsw i32 %conv2, %conv4
  %add89 = add nsw i32 %conv, %mul88
  %idxprom90 = sext i32 %add89 to i64
  %arrayidx91 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom90
  store <4 x i8> %call87, <4 x i8> addrspace(1)* %arrayidx91, align 4
  br label %return

return:                                           ; preds = %if.end77, %if.then
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_horizontalSAT0_kernel(<4 x i8> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %mul = mul nsw i32 %conv2, %width
  %add = add nsw i32 %conv, %mul
  %conv3 = sitofp i32 %r to float
  %conv4 = sitofp i32 %i to float
  %call5 = call cc75 float @_Z3powff(float %conv3, float %conv4) #1
  %conv6 = fptosi float %call5 to i32
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %sum.0 = phi <4 x i32> [ zeroinitializer, %entry ], [ %add16, %for.inc ]
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %j.0, %r
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul8 = mul nsw i32 %j.0, %conv6
  %sub = sub nsw i32 %conv, %mul8
  %cmp9 = icmp slt i32 %sub, 0
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %idxprom
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %arrayidx, align 16
  br label %return

if.end:                                           ; preds = %for.body
  %mul11 = mul nsw i32 %j.0, %conv6
  %sub12 = sub nsw i32 %add, %mul11
  %idxprom13 = sext i32 %sub12 to i64
  %arrayidx14 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i64 %idxprom13
  %0 = load <4 x i8> addrspace(1)* %arrayidx14, align 4
  %call15 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %0) #1
  %add16 = add <4 x i32> %sum.0, %call15
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %j.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %idxprom17 = sext i32 %add to i64
  %arrayidx18 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %idxprom17
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %arrayidx18, align 16
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 float @_Z3powff(float, float) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_horizontalSAT_kernel(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %mul = mul nsw i32 %conv2, %width
  %add = add nsw i32 %conv, %mul
  %conv3 = sitofp i32 %r to float
  %conv4 = sitofp i32 %i to float
  %call5 = call cc75 float @_Z3powff(float %conv3, float %conv4) #1
  %conv6 = fptosi float %call5 to i32
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %sum.0 = phi <4 x i32> [ zeroinitializer, %entry ], [ %add15, %for.inc ]
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %j.0, %r
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul8 = mul nsw i32 %j.0, %conv6
  %sub = sub nsw i32 %conv, %mul8
  %cmp9 = icmp slt i32 %sub, 0
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %idxprom
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %arrayidx, align 16
  br label %return

if.end:                                           ; preds = %for.body
  %mul11 = mul nsw i32 %j.0, %conv6
  %sub12 = sub nsw i32 %add, %mul11
  %idxprom13 = sext i32 %sub12 to i64
  %arrayidx14 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %idxprom13
  %0 = load <4 x i32> addrspace(1)* %arrayidx14, align 16
  %add15 = add <4 x i32> %sum.0, %0
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %j.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %idxprom16 = sext i32 %add to i64
  %arrayidx17 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %idxprom16
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %arrayidx17, align 16
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_verticalSAT_kernel(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %conv3 = sitofp i32 %r to float
  %conv4 = sitofp i32 %i to float
  %call5 = call cc75 float @_Z3powff(float %conv3, float %conv4) #1
  %conv6 = fptosi float %call5 to i32
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %sum.0 = phi <4 x i32> [ zeroinitializer, %entry ], [ %add17, %for.inc ]
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %j.0, %r
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul nsw i32 %j.0, %conv6
  %sub = sub nsw i32 %conv2, %mul
  %cmp8 = icmp slt i32 %sub, 0
  br i1 %cmp8, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %mul10 = mul nsw i32 %conv2, %width
  %add = add nsw i32 %conv, %mul10
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %idxprom
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %arrayidx, align 16
  br label %return

if.end:                                           ; preds = %for.body
  %mul11 = mul nsw i32 %j.0, %conv6
  %sub12 = sub nsw i32 %conv2, %mul11
  %mul13 = mul nsw i32 %width, %sub12
  %add14 = add nsw i32 %conv, %mul13
  %idxprom15 = sext i32 %add14 to i64
  %arrayidx16 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i64 %idxprom15
  %0 = load <4 x i32> addrspace(1)* %arrayidx16, align 16
  %add17 = add <4 x i32> %sum.0, %0
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %j.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %mul18 = mul nsw i32 %conv2, %width
  %add19 = add nsw i32 %conv, %mul18
  %idxprom20 = sext i32 %add19 to i64
  %arrayidx21 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i64 %idxprom20
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %arrayidx21, align 16
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_box_filter_horizontal_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %mul = mul nsw i32 %conv2, %conv4
  %add = add nsw i32 %conv, %mul
  %sub = sub nsw i32 %filterWidth, 1
  %div = sdiv i32 %sub, 2
  %cmp = icmp slt i32 %conv, %div
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %sub8 = sub nsw i32 %conv4, %div
  %cmp9 = icmp sge i32 %conv, %sub8
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %arrayidx, align 4
  br label %return

if.end:                                           ; preds = %lor.lhs.false
  %0 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %splat = shufflevector <4 x i32> %0, <4 x i32> %0, <4 x i32> zeroinitializer
  %sub11 = sub nsw i32 0, %div
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end
  %sum.0 = phi <4 x i32> [ zeroinitializer, %if.end ], [ %add24, %for.inc ]
  %X.0 = phi i32 [ %sub11, %if.end ], [ %add25, %for.inc ]
  %cmp12 = icmp slt i32 %X.0, %div
  br i1 %cmp12, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %add14 = add nsw i32 %add, %X.0
  %idxprom15 = sext i32 %add14 to i64
  %arrayidx16 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom15
  %1 = load <4 x i8> addrspace(1)* %arrayidx16, align 4
  %call17 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %1) #1
  %add18 = add <4 x i32> %sum.0, %call17
  %add19 = add nsw i32 %add, %X.0
  %add20 = add nsw i32 %add19, 1
  %idxprom21 = sext i32 %add20 to i64
  %arrayidx22 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom21
  %2 = load <4 x i8> addrspace(1)* %arrayidx22, align 4
  %call23 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %2) #1
  %add24 = add <4 x i32> %add18, %call23
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %add25 = add nsw i32 %X.0, 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %add26 = add nsw i32 %add, %div
  %idxprom27 = sext i32 %add26 to i64
  %arrayidx28 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom27
  %3 = load <4 x i8> addrspace(1)* %arrayidx28, align 4
  %call29 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %3) #1
  %add30 = add <4 x i32> %sum.0, %call29
  %div31 = sdiv <4 x i32> %add30, %splat
  %call32 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div31) #1
  %idxprom33 = sext i32 %add to i64
  %arrayidx34 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom33
  store <4 x i8> %call32, <4 x i8> addrspace(1)* %arrayidx34, align 4
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_box_filter_vertical_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %mul = mul nsw i32 %conv2, %conv4
  %add = add nsw i32 %conv, %mul
  %sub = sub nsw i32 %filterWidth, 1
  %div = sdiv i32 %sub, 2
  %cmp = icmp slt i32 %conv2, %div
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %sub8 = sub nsw i32 %conv6, %div
  %cmp9 = icmp sge i32 %conv2, %sub8
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %arrayidx, align 4
  br label %return

if.end:                                           ; preds = %lor.lhs.false
  %0 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %splat = shufflevector <4 x i32> %0, <4 x i32> %0, <4 x i32> zeroinitializer
  %sub11 = sub nsw i32 0, %div
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end
  %sum.0 = phi <4 x i32> [ zeroinitializer, %if.end ], [ %add26, %for.inc ]
  %Y.0 = phi i32 [ %sub11, %if.end ], [ %add27, %for.inc ]
  %cmp12 = icmp slt i32 %Y.0, %div
  br i1 %cmp12, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul14 = mul nsw i32 %Y.0, %conv4
  %add15 = add nsw i32 %add, %mul14
  %idxprom16 = sext i32 %add15 to i64
  %arrayidx17 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom16
  %1 = load <4 x i8> addrspace(1)* %arrayidx17, align 4
  %call18 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %1) #1
  %add19 = add <4 x i32> %sum.0, %call18
  %add20 = add nsw i32 %Y.0, 1
  %mul21 = mul nsw i32 %add20, %conv4
  %add22 = add nsw i32 %add, %mul21
  %idxprom23 = sext i32 %add22 to i64
  %arrayidx24 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom23
  %2 = load <4 x i8> addrspace(1)* %arrayidx24, align 4
  %call25 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %2) #1
  %add26 = add <4 x i32> %add19, %call25
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %add27 = add nsw i32 %Y.0, 2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %mul28 = mul nsw i32 %div, %conv4
  %add29 = add nsw i32 %add, %mul28
  %idxprom30 = sext i32 %add29 to i64
  %arrayidx31 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom30
  %3 = load <4 x i8> addrspace(1)* %arrayidx31, align 4
  %call32 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %3) #1
  %add33 = add <4 x i32> %sum.0, %call32
  %div34 = sdiv <4 x i32> %add33, %splat
  %call35 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div34) #1
  %idxprom36 = sext i32 %add to i64
  %arrayidx37 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom36
  store <4 x i8> %call35, <4 x i8> addrspace(1)* %arrayidx37, align 4
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_box_filter_horizontal_local_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth, <4 x i8> addrspace(3)* %lds) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %mul = mul nsw i32 %conv2, %conv4
  %add = add nsw i32 %conv, %mul
  %sub = sub nsw i32 %filterWidth, 1
  %div = sdiv i32 %sub, 2
  %call7 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv8 = trunc i64 %call7 to i32
  %call9 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv10 = trunc i64 %call9 to i32
  %call11 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv12 = trunc i64 %call11 to i32
  %call13 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv14 = trunc i64 %call13 to i32
  %call15 = call cc75 i64 @_Z14get_local_sizej(i32 1) #1
  %conv16 = trunc i64 %call15 to i32
  %mul17 = mul nsw i32 %conv14, %conv10
  %mul18 = mul nsw i32 %conv4, %conv12
  %mul19 = mul nsw i32 %mul18, %conv16
  %add20 = add nsw i32 %mul17, %mul19
  %cmp = icmp slt i32 %conv8, %div
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %sub22 = sub nsw i32 %add20, %div
  %add23 = add nsw i32 %sub22, %conv8
  %idxprom = sext i32 %add23 to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom
  %0 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %idxprom24 = sext i32 %conv8 to i64
  %arrayidx25 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i64 %idxprom24
  store <4 x i8> %0, <4 x i8> addrspace(3)* %arrayidx25, align 4
  %add26 = add nsw i32 %add20, %conv8
  %add27 = add nsw i32 %add26, 256
  %idxprom28 = sext i32 %add27 to i64
  %arrayidx29 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom28
  %1 = load <4 x i8> addrspace(1)* %arrayidx29, align 4
  %add30 = add nsw i32 256, %div
  %add31 = add nsw i32 %add30, %conv8
  %idxprom32 = sext i32 %add31 to i64
  %arrayidx33 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i64 %idxprom32
  store <4 x i8> %1, <4 x i8> addrspace(3)* %arrayidx33, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %add34 = add nsw i32 %add20, %conv8
  %idxprom35 = sext i32 %add34 to i64
  %arrayidx36 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom35
  %2 = load <4 x i8> addrspace(1)* %arrayidx36, align 4
  %add37 = add nsw i32 %conv8, %div
  %idxprom38 = sext i32 %add37 to i64
  %arrayidx39 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i64 %idxprom38
  store <4 x i8> %2, <4 x i8> addrspace(3)* %arrayidx39, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %cmp40 = icmp slt i32 %conv, %div
  br i1 %cmp40, label %if.then45, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end
  %sub42 = sub nsw i32 %conv4, %div
  %cmp43 = icmp sge i32 %conv, %sub42
  br i1 %cmp43, label %if.then45, label %if.end46

if.then45:                                        ; preds = %lor.lhs.false, %if.end
  br label %return

if.end46:                                         ; preds = %lor.lhs.false
  %3 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %splat = shufflevector <4 x i32> %3, <4 x i32> %3, <4 x i32> zeroinitializer
  %sub47 = sub nsw i32 0, %div
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end46
  %sum.0 = phi <4 x i32> [ zeroinitializer, %if.end46 ], [ %add55, %for.inc ]
  %X.0 = phi i32 [ %sub47, %if.end46 ], [ %inc, %for.inc ]
  %cmp48 = icmp sle i32 %X.0, %div
  br i1 %cmp48, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %add50 = add nsw i32 %conv8, %X.0
  %add51 = add nsw i32 %add50, %div
  %idxprom52 = sext i32 %add51 to i64
  %arrayidx53 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i64 %idxprom52
  %4 = load <4 x i8> addrspace(3)* %arrayidx53, align 4
  %call54 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %4) #1
  %add55 = add <4 x i32> %sum.0, %call54
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %X.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %div56 = sdiv <4 x i32> %sum.0, %splat
  %call57 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div56) #1
  %idxprom58 = sext i32 %add to i64
  %arrayidx59 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom58
  store <4 x i8> %call57, <4 x i8> addrspace(1)* %arrayidx59, align 4
  br label %return

return:                                           ; preds = %for.end, %if.then45
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

declare cc75 void @_Z7barrierj(i32)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !12, !15, !16, !19, !20}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!26}
!opencl.spir.version = !{!26}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @__OpenCL_box_filter_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint4*", metadata !"uchar4*", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint4*", metadata !"uchar4*", metadata !"uint"}
!6 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @__OpenCL_horizontalSAT0_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"uint4*", metadata !"int", metadata !"int", metadata !"int"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"uint4*", metadata !"int", metadata !"int", metadata !"int"}
!12 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @__OpenCL_horizontalSAT_kernel, metadata !7, metadata !8, metadata !13, metadata !10, metadata !14}
!13 = metadata !{metadata !"kernel_arg_type", metadata !"uint4*", metadata !"uint4*", metadata !"int", metadata !"int", metadata !"int"}
!14 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint4*", metadata !"uint4*", metadata !"int", metadata !"int", metadata !"int"}
!15 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @__OpenCL_verticalSAT_kernel, metadata !7, metadata !8, metadata !13, metadata !10, metadata !14}
!16 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @__OpenCL_box_filter_horizontal_kernel, metadata !1, metadata !2, metadata !17, metadata !4, metadata !18}
!17 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int"}
!18 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int"}
!19 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @__OpenCL_box_filter_vertical_kernel, metadata !1, metadata !2, metadata !17, metadata !4, metadata !18}
!20 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, <4 x i8> addrspace(3)*)* @__OpenCL_box_filter_horizontal_local_kernel, metadata !21, metadata !22, metadata !23, metadata !24, metadata !25}
!21 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 3}
!22 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!23 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int", metadata !"uchar4*"}
!24 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !""}
!25 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"uchar4*", metadata !"int", metadata !"uchar4*"}
!26 = metadata !{i32 1, i32 2}

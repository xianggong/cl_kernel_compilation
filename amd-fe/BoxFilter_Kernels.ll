; ModuleID = 'BoxFilter_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_box_filter_kernel(<4 x i32> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %N) #0 {
entry:
  %inputImage.addr = alloca <4 x i32> addrspace(1)*, align 8
  %outputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %N.addr = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %k = alloca i32, align 4
  %filterSize = alloca <4 x i32>, align 16
  %posA = alloca <2 x i32>, align 8
  %.compoundliteral = alloca <2 x i32>, align 8
  %posB = alloca <2 x i32>, align 8
  %.compoundliteral24 = alloca <2 x i32>, align 8
  %posC = alloca <2 x i32>, align 8
  %.compoundliteral29 = alloca <2 x i32>, align 8
  %posD = alloca <2 x i32>, align 8
  %.compoundliteral34 = alloca <2 x i32>, align 8
  %sumA = alloca <4 x i32>, align 16
  %sumB = alloca <4 x i32>, align 16
  %sumC = alloca <4 x i32>, align 16
  %sumD = alloca <4 x i32>, align 16
  store <4 x i32> addrspace(1)* %inputImage, <4 x i32> addrspace(1)** %inputImage.addr, align 8
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %outputImage.addr, align 8
  store i32 %N, i32* %N.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %y, align 4
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %width, align 4
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %height, align 4
  %0 = load i32* %N.addr, align 4
  %sub = sub i32 %0, 1
  %div = udiv i32 %sub, 2
  store i32 %div, i32* %k, align 4
  %1 = load i32* %x, align 4
  %2 = load i32* %k, align 4
  %cmp = icmp slt i32 %1, %2
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %3 = load i32* %y, align 4
  %4 = load i32* %k, align 4
  %cmp8 = icmp slt i32 %3, %4
  br i1 %cmp8, label %if.then, label %lor.lhs.false10

lor.lhs.false10:                                  ; preds = %lor.lhs.false
  %5 = load i32* %x, align 4
  %6 = load i32* %width, align 4
  %7 = load i32* %k, align 4
  %sub11 = sub nsw i32 %6, %7
  %sub12 = sub nsw i32 %sub11, 1
  %cmp13 = icmp sgt i32 %5, %sub12
  br i1 %cmp13, label %if.then, label %lor.lhs.false15

lor.lhs.false15:                                  ; preds = %lor.lhs.false10
  %8 = load i32* %y, align 4
  %9 = load i32* %height, align 4
  %10 = load i32* %k, align 4
  %sub16 = sub nsw i32 %9, %10
  %sub17 = sub nsw i32 %sub16, 1
  %cmp18 = icmp sgt i32 %8, %sub17
  br i1 %cmp18, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false15, %lor.lhs.false10, %lor.lhs.false, %entry
  %11 = load i32* %x, align 4
  %12 = load i32* %y, align 4
  %13 = load i32* %width, align 4
  %mul = mul nsw i32 %12, %13
  %add = add nsw i32 %11, %mul
  %idxprom = sext i32 %add to i64
  %14 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %14, i64 %idxprom
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %arrayidx, align 4
  br label %return

if.end:                                           ; preds = %lor.lhs.false15
  %15 = load i32* %N.addr, align 4
  %16 = load i32* %N.addr, align 4
  %mul20 = mul i32 %15, %16
  %17 = insertelement <4 x i32> undef, i32 %mul20, i32 0
  %splat = shufflevector <4 x i32> %17, <4 x i32> %17, <4 x i32> zeroinitializer
  store <4 x i32> %splat, <4 x i32>* %filterSize, align 16
  %18 = load i32* %x, align 4
  %19 = load i32* %k, align 4
  %sub21 = sub nsw i32 %18, %19
  %vecinit = insertelement <2 x i32> undef, i32 %sub21, i32 0
  %20 = load i32* %y, align 4
  %21 = load i32* %k, align 4
  %sub22 = sub nsw i32 %20, %21
  %vecinit23 = insertelement <2 x i32> %vecinit, i32 %sub22, i32 1
  store <2 x i32> %vecinit23, <2 x i32>* %.compoundliteral
  %22 = load <2 x i32>* %.compoundliteral
  store <2 x i32> %22, <2 x i32>* %posA, align 8
  %23 = load i32* %x, align 4
  %24 = load i32* %k, align 4
  %add25 = add nsw i32 %23, %24
  %vecinit26 = insertelement <2 x i32> undef, i32 %add25, i32 0
  %25 = load i32* %y, align 4
  %26 = load i32* %k, align 4
  %sub27 = sub nsw i32 %25, %26
  %vecinit28 = insertelement <2 x i32> %vecinit26, i32 %sub27, i32 1
  store <2 x i32> %vecinit28, <2 x i32>* %.compoundliteral24
  %27 = load <2 x i32>* %.compoundliteral24
  store <2 x i32> %27, <2 x i32>* %posB, align 8
  %28 = load i32* %x, align 4
  %29 = load i32* %k, align 4
  %add30 = add nsw i32 %28, %29
  %vecinit31 = insertelement <2 x i32> undef, i32 %add30, i32 0
  %30 = load i32* %y, align 4
  %31 = load i32* %k, align 4
  %add32 = add nsw i32 %30, %31
  %vecinit33 = insertelement <2 x i32> %vecinit31, i32 %add32, i32 1
  store <2 x i32> %vecinit33, <2 x i32>* %.compoundliteral29
  %32 = load <2 x i32>* %.compoundliteral29
  store <2 x i32> %32, <2 x i32>* %posC, align 8
  %33 = load i32* %x, align 4
  %34 = load i32* %k, align 4
  %sub35 = sub nsw i32 %33, %34
  %vecinit36 = insertelement <2 x i32> undef, i32 %sub35, i32 0
  %35 = load i32* %y, align 4
  %36 = load i32* %k, align 4
  %add37 = add nsw i32 %35, %36
  %vecinit38 = insertelement <2 x i32> %vecinit36, i32 %add37, i32 1
  store <2 x i32> %vecinit38, <2 x i32>* %.compoundliteral34
  %37 = load <2 x i32>* %.compoundliteral34
  store <2 x i32> %37, <2 x i32>* %posD, align 8
  store <4 x i32> zeroinitializer, <4 x i32>* %sumA, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sumB, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sumC, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sumD, align 16
  %38 = load <2 x i32>* %posA, align 8
  %39 = extractelement <2 x i32> %38, i32 0
  %sub39 = sub nsw i32 %39, 1
  %40 = load <2 x i32>* %posA, align 8
  %41 = insertelement <2 x i32> %40, i32 %sub39, i32 0
  store <2 x i32> %41, <2 x i32>* %posA, align 8
  %42 = load <2 x i32>* %posA, align 8
  %43 = extractelement <2 x i32> %42, i32 1
  %sub40 = sub nsw i32 %43, 1
  %44 = load <2 x i32>* %posA, align 8
  %45 = insertelement <2 x i32> %44, i32 %sub40, i32 1
  store <2 x i32> %45, <2 x i32>* %posA, align 8
  %46 = load <2 x i32>* %posB, align 8
  %47 = extractelement <2 x i32> %46, i32 1
  %sub41 = sub nsw i32 %47, 1
  %48 = load <2 x i32>* %posB, align 8
  %49 = insertelement <2 x i32> %48, i32 %sub41, i32 1
  store <2 x i32> %49, <2 x i32>* %posB, align 8
  %50 = load <2 x i32>* %posD, align 8
  %51 = extractelement <2 x i32> %50, i32 0
  %sub42 = sub nsw i32 %51, 1
  %52 = load <2 x i32>* %posD, align 8
  %53 = insertelement <2 x i32> %52, i32 %sub42, i32 0
  store <2 x i32> %53, <2 x i32>* %posD, align 8
  %54 = load <2 x i32>* %posA, align 8
  %55 = extractelement <2 x i32> %54, i32 0
  %cmp43 = icmp sge i32 %55, 0
  br i1 %cmp43, label %land.lhs.true, label %if.end53

land.lhs.true:                                    ; preds = %if.end
  %56 = load <2 x i32>* %posA, align 8
  %57 = extractelement <2 x i32> %56, i32 1
  %cmp45 = icmp sge i32 %57, 0
  br i1 %cmp45, label %if.then47, label %if.end53

if.then47:                                        ; preds = %land.lhs.true
  %58 = load <2 x i32>* %posA, align 8
  %59 = extractelement <2 x i32> %58, i32 0
  %60 = load <2 x i32>* %posA, align 8
  %61 = extractelement <2 x i32> %60, i32 1
  %62 = load i32* %width, align 4
  %mul48 = mul nsw i32 %61, %62
  %add49 = add nsw i32 %59, %mul48
  %idxprom50 = sext i32 %add49 to i64
  %63 = load <4 x i32> addrspace(1)** %inputImage.addr, align 8
  %arrayidx51 = getelementptr inbounds <4 x i32> addrspace(1)* %63, i64 %idxprom50
  %64 = load <4 x i32> addrspace(1)* %arrayidx51, align 16
  %call52 = call cc75 <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %64) #1
  store <4 x i32> %call52, <4 x i32>* %sumA, align 16
  br label %if.end53

if.end53:                                         ; preds = %if.then47, %land.lhs.true, %if.end
  %65 = load <2 x i32>* %posB, align 8
  %66 = extractelement <2 x i32> %65, i32 0
  %cmp54 = icmp sge i32 %66, 0
  br i1 %cmp54, label %land.lhs.true56, label %if.end65

land.lhs.true56:                                  ; preds = %if.end53
  %67 = load <2 x i32>* %posB, align 8
  %68 = extractelement <2 x i32> %67, i32 1
  %cmp57 = icmp sge i32 %68, 0
  br i1 %cmp57, label %if.then59, label %if.end65

if.then59:                                        ; preds = %land.lhs.true56
  %69 = load <2 x i32>* %posB, align 8
  %70 = extractelement <2 x i32> %69, i32 0
  %71 = load <2 x i32>* %posB, align 8
  %72 = extractelement <2 x i32> %71, i32 1
  %73 = load i32* %width, align 4
  %mul60 = mul nsw i32 %72, %73
  %add61 = add nsw i32 %70, %mul60
  %idxprom62 = sext i32 %add61 to i64
  %74 = load <4 x i32> addrspace(1)** %inputImage.addr, align 8
  %arrayidx63 = getelementptr inbounds <4 x i32> addrspace(1)* %74, i64 %idxprom62
  %75 = load <4 x i32> addrspace(1)* %arrayidx63, align 16
  %call64 = call cc75 <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %75) #1
  store <4 x i32> %call64, <4 x i32>* %sumB, align 16
  br label %if.end65

if.end65:                                         ; preds = %if.then59, %land.lhs.true56, %if.end53
  %76 = load <2 x i32>* %posD, align 8
  %77 = extractelement <2 x i32> %76, i32 0
  %cmp66 = icmp sge i32 %77, 0
  br i1 %cmp66, label %land.lhs.true68, label %if.end77

land.lhs.true68:                                  ; preds = %if.end65
  %78 = load <2 x i32>* %posD, align 8
  %79 = extractelement <2 x i32> %78, i32 1
  %cmp69 = icmp sge i32 %79, 0
  br i1 %cmp69, label %if.then71, label %if.end77

if.then71:                                        ; preds = %land.lhs.true68
  %80 = load <2 x i32>* %posD, align 8
  %81 = extractelement <2 x i32> %80, i32 0
  %82 = load <2 x i32>* %posD, align 8
  %83 = extractelement <2 x i32> %82, i32 1
  %84 = load i32* %width, align 4
  %mul72 = mul nsw i32 %83, %84
  %add73 = add nsw i32 %81, %mul72
  %idxprom74 = sext i32 %add73 to i64
  %85 = load <4 x i32> addrspace(1)** %inputImage.addr, align 8
  %arrayidx75 = getelementptr inbounds <4 x i32> addrspace(1)* %85, i64 %idxprom74
  %86 = load <4 x i32> addrspace(1)* %arrayidx75, align 16
  %call76 = call cc75 <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %86) #1
  store <4 x i32> %call76, <4 x i32>* %sumD, align 16
  br label %if.end77

if.end77:                                         ; preds = %if.then71, %land.lhs.true68, %if.end65
  %87 = load <2 x i32>* %posC, align 8
  %88 = extractelement <2 x i32> %87, i32 0
  %89 = load <2 x i32>* %posC, align 8
  %90 = extractelement <2 x i32> %89, i32 1
  %91 = load i32* %width, align 4
  %mul78 = mul nsw i32 %90, %91
  %add79 = add nsw i32 %88, %mul78
  %idxprom80 = sext i32 %add79 to i64
  %92 = load <4 x i32> addrspace(1)** %inputImage.addr, align 8
  %arrayidx81 = getelementptr inbounds <4 x i32> addrspace(1)* %92, i64 %idxprom80
  %93 = load <4 x i32> addrspace(1)* %arrayidx81, align 16
  %call82 = call cc75 <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %93) #1
  store <4 x i32> %call82, <4 x i32>* %sumC, align 16
  %94 = load <4 x i32>* %sumA, align 16
  %95 = load <4 x i32>* %sumC, align 16
  %add83 = add <4 x i32> %94, %95
  %96 = load <4 x i32>* %sumB, align 16
  %sub84 = sub <4 x i32> %add83, %96
  %97 = load <4 x i32>* %sumD, align 16
  %sub85 = sub <4 x i32> %sub84, %97
  %98 = load <4 x i32>* %filterSize, align 16
  %div86 = sdiv <4 x i32> %sub85, %98
  %call87 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div86) #1
  %99 = load i32* %x, align 4
  %100 = load i32* %y, align 4
  %101 = load i32* %width, align 4
  %mul88 = mul nsw i32 %100, %101
  %add89 = add nsw i32 %99, %mul88
  %idxprom90 = sext i32 %add89 to i64
  %102 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx91 = getelementptr inbounds <4 x i8> addrspace(1)* %102, i64 %idxprom90
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
  %input.addr = alloca <4 x i8> addrspace(1)*, align 8
  %output.addr = alloca <4 x i32> addrspace(1)*, align 8
  %i.addr = alloca i32, align 4
  %r.addr = alloca i32, align 4
  %width.addr = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %pos = alloca i32, align 4
  %c = alloca i32, align 4
  %sum = alloca <4 x i32>, align 16
  %j = alloca i32, align 4
  store <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)** %input.addr, align 8
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %output.addr, align 8
  store i32 %i, i32* %i.addr, align 4
  store i32 %r, i32* %r.addr, align 4
  store i32 %width, i32* %width.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %y, align 4
  %0 = load i32* %x, align 4
  %1 = load i32* %y, align 4
  %2 = load i32* %width.addr, align 4
  %mul = mul nsw i32 %1, %2
  %add = add nsw i32 %0, %mul
  store i32 %add, i32* %pos, align 4
  %3 = load i32* %r.addr, align 4
  %conv3 = sitofp i32 %3 to float
  %4 = load i32* %i.addr, align 4
  %conv4 = sitofp i32 %4 to float
  %call5 = call cc75 float @_Z3powff(float %conv3, float %conv4) #1
  %conv6 = fptosi float %call5 to i32
  store i32 %conv6, i32* %c, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %5 = load i32* %j, align 4
  %6 = load i32* %r.addr, align 4
  %cmp = icmp slt i32 %5, %6
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %7 = load i32* %x, align 4
  %8 = load i32* %j, align 4
  %9 = load i32* %c, align 4
  %mul8 = mul nsw i32 %8, %9
  %sub = sub nsw i32 %7, %mul8
  %cmp9 = icmp slt i32 %sub, 0
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %10 = load <4 x i32>* %sum, align 16
  %11 = load i32* %pos, align 4
  %idxprom = sext i32 %11 to i64
  %12 = load <4 x i32> addrspace(1)** %output.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %12, i64 %idxprom
  store <4 x i32> %10, <4 x i32> addrspace(1)* %arrayidx, align 16
  br label %return

if.end:                                           ; preds = %for.body
  %13 = load i32* %pos, align 4
  %14 = load i32* %j, align 4
  %15 = load i32* %c, align 4
  %mul11 = mul nsw i32 %14, %15
  %sub12 = sub nsw i32 %13, %mul11
  %idxprom13 = sext i32 %sub12 to i64
  %16 = load <4 x i8> addrspace(1)** %input.addr, align 8
  %arrayidx14 = getelementptr inbounds <4 x i8> addrspace(1)* %16, i64 %idxprom13
  %17 = load <4 x i8> addrspace(1)* %arrayidx14, align 4
  %call15 = call cc75 <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %17) #1
  %18 = load <4 x i32>* %sum, align 16
  %add16 = add <4 x i32> %18, %call15
  store <4 x i32> %add16, <4 x i32>* %sum, align 16
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %19 = load i32* %j, align 4
  %inc = add nsw i32 %19, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %20 = load <4 x i32>* %sum, align 16
  %21 = load i32* %pos, align 4
  %idxprom17 = sext i32 %21 to i64
  %22 = load <4 x i32> addrspace(1)** %output.addr, align 8
  %arrayidx18 = getelementptr inbounds <4 x i32> addrspace(1)* %22, i64 %idxprom17
  store <4 x i32> %20, <4 x i32> addrspace(1)* %arrayidx18, align 16
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
  %input.addr = alloca <4 x i32> addrspace(1)*, align 8
  %output.addr = alloca <4 x i32> addrspace(1)*, align 8
  %i.addr = alloca i32, align 4
  %r.addr = alloca i32, align 4
  %width.addr = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %pos = alloca i32, align 4
  %c = alloca i32, align 4
  %sum = alloca <4 x i32>, align 16
  %j = alloca i32, align 4
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %input.addr, align 8
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %output.addr, align 8
  store i32 %i, i32* %i.addr, align 4
  store i32 %r, i32* %r.addr, align 4
  store i32 %width, i32* %width.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %y, align 4
  %0 = load i32* %x, align 4
  %1 = load i32* %y, align 4
  %2 = load i32* %width.addr, align 4
  %mul = mul nsw i32 %1, %2
  %add = add nsw i32 %0, %mul
  store i32 %add, i32* %pos, align 4
  %3 = load i32* %r.addr, align 4
  %conv3 = sitofp i32 %3 to float
  %4 = load i32* %i.addr, align 4
  %conv4 = sitofp i32 %4 to float
  %call5 = call cc75 float @_Z3powff(float %conv3, float %conv4) #1
  %conv6 = fptosi float %call5 to i32
  store i32 %conv6, i32* %c, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %5 = load i32* %j, align 4
  %6 = load i32* %r.addr, align 4
  %cmp = icmp slt i32 %5, %6
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %7 = load i32* %x, align 4
  %8 = load i32* %j, align 4
  %9 = load i32* %c, align 4
  %mul8 = mul nsw i32 %8, %9
  %sub = sub nsw i32 %7, %mul8
  %cmp9 = icmp slt i32 %sub, 0
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %10 = load <4 x i32>* %sum, align 16
  %11 = load i32* %pos, align 4
  %idxprom = sext i32 %11 to i64
  %12 = load <4 x i32> addrspace(1)** %output.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %12, i64 %idxprom
  store <4 x i32> %10, <4 x i32> addrspace(1)* %arrayidx, align 16
  br label %return

if.end:                                           ; preds = %for.body
  %13 = load i32* %pos, align 4
  %14 = load i32* %j, align 4
  %15 = load i32* %c, align 4
  %mul11 = mul nsw i32 %14, %15
  %sub12 = sub nsw i32 %13, %mul11
  %idxprom13 = sext i32 %sub12 to i64
  %16 = load <4 x i32> addrspace(1)** %input.addr, align 8
  %arrayidx14 = getelementptr inbounds <4 x i32> addrspace(1)* %16, i64 %idxprom13
  %17 = load <4 x i32> addrspace(1)* %arrayidx14, align 16
  %18 = load <4 x i32>* %sum, align 16
  %add15 = add <4 x i32> %18, %17
  store <4 x i32> %add15, <4 x i32>* %sum, align 16
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %19 = load i32* %j, align 4
  %inc = add nsw i32 %19, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %20 = load <4 x i32>* %sum, align 16
  %21 = load i32* %pos, align 4
  %idxprom16 = sext i32 %21 to i64
  %22 = load <4 x i32> addrspace(1)** %output.addr, align 8
  %arrayidx17 = getelementptr inbounds <4 x i32> addrspace(1)* %22, i64 %idxprom16
  store <4 x i32> %20, <4 x i32> addrspace(1)* %arrayidx17, align 16
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_verticalSAT_kernel(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
entry:
  %input.addr = alloca <4 x i32> addrspace(1)*, align 8
  %output.addr = alloca <4 x i32> addrspace(1)*, align 8
  %i.addr = alloca i32, align 4
  %r.addr = alloca i32, align 4
  %width.addr = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %c = alloca i32, align 4
  %sum = alloca <4 x i32>, align 16
  %j = alloca i32, align 4
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %input.addr, align 8
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %output.addr, align 8
  store i32 %i, i32* %i.addr, align 4
  store i32 %r, i32* %r.addr, align 4
  store i32 %width, i32* %width.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %y, align 4
  %0 = load i32* %r.addr, align 4
  %conv3 = sitofp i32 %0 to float
  %1 = load i32* %i.addr, align 4
  %conv4 = sitofp i32 %1 to float
  %call5 = call cc75 float @_Z3powff(float %conv3, float %conv4) #1
  %conv6 = fptosi float %call5 to i32
  store i32 %conv6, i32* %c, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32* %j, align 4
  %3 = load i32* %r.addr, align 4
  %cmp = icmp slt i32 %2, %3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i32* %y, align 4
  %5 = load i32* %j, align 4
  %6 = load i32* %c, align 4
  %mul = mul nsw i32 %5, %6
  %sub = sub nsw i32 %4, %mul
  %cmp8 = icmp slt i32 %sub, 0
  br i1 %cmp8, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %7 = load <4 x i32>* %sum, align 16
  %8 = load i32* %x, align 4
  %9 = load i32* %y, align 4
  %10 = load i32* %width.addr, align 4
  %mul10 = mul nsw i32 %9, %10
  %add = add nsw i32 %8, %mul10
  %idxprom = sext i32 %add to i64
  %11 = load <4 x i32> addrspace(1)** %output.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(1)* %11, i64 %idxprom
  store <4 x i32> %7, <4 x i32> addrspace(1)* %arrayidx, align 16
  br label %return

if.end:                                           ; preds = %for.body
  %12 = load i32* %x, align 4
  %13 = load i32* %width.addr, align 4
  %14 = load i32* %y, align 4
  %15 = load i32* %j, align 4
  %16 = load i32* %c, align 4
  %mul11 = mul nsw i32 %15, %16
  %sub12 = sub nsw i32 %14, %mul11
  %mul13 = mul nsw i32 %13, %sub12
  %add14 = add nsw i32 %12, %mul13
  %idxprom15 = sext i32 %add14 to i64
  %17 = load <4 x i32> addrspace(1)** %input.addr, align 8
  %arrayidx16 = getelementptr inbounds <4 x i32> addrspace(1)* %17, i64 %idxprom15
  %18 = load <4 x i32> addrspace(1)* %arrayidx16, align 16
  %19 = load <4 x i32>* %sum, align 16
  %add17 = add <4 x i32> %19, %18
  store <4 x i32> %add17, <4 x i32>* %sum, align 16
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %20 = load i32* %j, align 4
  %inc = add nsw i32 %20, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %21 = load <4 x i32>* %sum, align 16
  %22 = load i32* %x, align 4
  %23 = load i32* %y, align 4
  %24 = load i32* %width.addr, align 4
  %mul18 = mul nsw i32 %23, %24
  %add19 = add nsw i32 %22, %mul18
  %idxprom20 = sext i32 %add19 to i64
  %25 = load <4 x i32> addrspace(1)** %output.addr, align 8
  %arrayidx21 = getelementptr inbounds <4 x i32> addrspace(1)* %25, i64 %idxprom20
  store <4 x i32> %21, <4 x i32> addrspace(1)* %arrayidx21, align 16
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_box_filter_horizontal_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
entry:
  %inputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %outputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %filterWidth.addr = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %pos = alloca i32, align 4
  %k = alloca i32, align 4
  %size = alloca <4 x i32>, align 16
  %sum = alloca <4 x i32>, align 16
  %X = alloca i32, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %inputImage.addr, align 8
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %outputImage.addr, align 8
  store i32 %filterWidth, i32* %filterWidth.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %y, align 4
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %width, align 4
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %height, align 4
  %0 = load i32* %x, align 4
  %1 = load i32* %y, align 4
  %2 = load i32* %width, align 4
  %mul = mul nsw i32 %1, %2
  %add = add nsw i32 %0, %mul
  store i32 %add, i32* %pos, align 4
  %3 = load i32* %filterWidth.addr, align 4
  %sub = sub nsw i32 %3, 1
  %div = sdiv i32 %sub, 2
  store i32 %div, i32* %k, align 4
  %4 = load i32* %x, align 4
  %5 = load i32* %k, align 4
  %cmp = icmp slt i32 %4, %5
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %6 = load i32* %x, align 4
  %7 = load i32* %width, align 4
  %8 = load i32* %k, align 4
  %sub8 = sub nsw i32 %7, %8
  %cmp9 = icmp sge i32 %6, %sub8
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  %9 = load i32* %pos, align 4
  %idxprom = sext i32 %9 to i64
  %10 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %10, i64 %idxprom
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %arrayidx, align 4
  br label %return

if.end:                                           ; preds = %lor.lhs.false
  %11 = load i32* %filterWidth.addr, align 4
  %12 = insertelement <4 x i32> undef, i32 %11, i32 0
  %splat = shufflevector <4 x i32> %12, <4 x i32> %12, <4 x i32> zeroinitializer
  store <4 x i32> %splat, <4 x i32>* %size, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  %13 = load i32* %k, align 4
  %sub11 = sub nsw i32 0, %13
  store i32 %sub11, i32* %X, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end
  %14 = load i32* %X, align 4
  %15 = load i32* %k, align 4
  %cmp12 = icmp slt i32 %14, %15
  br i1 %cmp12, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %16 = load i32* %pos, align 4
  %17 = load i32* %X, align 4
  %add14 = add nsw i32 %16, %17
  %idxprom15 = sext i32 %add14 to i64
  %18 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx16 = getelementptr inbounds <4 x i8> addrspace(1)* %18, i64 %idxprom15
  %19 = load <4 x i8> addrspace(1)* %arrayidx16, align 4
  %call17 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %19) #1
  %20 = load <4 x i32>* %sum, align 16
  %add18 = add <4 x i32> %20, %call17
  store <4 x i32> %add18, <4 x i32>* %sum, align 16
  %21 = load i32* %pos, align 4
  %22 = load i32* %X, align 4
  %add19 = add nsw i32 %21, %22
  %add20 = add nsw i32 %add19, 1
  %idxprom21 = sext i32 %add20 to i64
  %23 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx22 = getelementptr inbounds <4 x i8> addrspace(1)* %23, i64 %idxprom21
  %24 = load <4 x i8> addrspace(1)* %arrayidx22, align 4
  %call23 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %24) #1
  %25 = load <4 x i32>* %sum, align 16
  %add24 = add <4 x i32> %25, %call23
  store <4 x i32> %add24, <4 x i32>* %sum, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %26 = load i32* %X, align 4
  %add25 = add nsw i32 %26, 2
  store i32 %add25, i32* %X, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %27 = load i32* %pos, align 4
  %28 = load i32* %k, align 4
  %add26 = add nsw i32 %27, %28
  %idxprom27 = sext i32 %add26 to i64
  %29 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx28 = getelementptr inbounds <4 x i8> addrspace(1)* %29, i64 %idxprom27
  %30 = load <4 x i8> addrspace(1)* %arrayidx28, align 4
  %call29 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %30) #1
  %31 = load <4 x i32>* %sum, align 16
  %add30 = add <4 x i32> %31, %call29
  store <4 x i32> %add30, <4 x i32>* %sum, align 16
  %32 = load <4 x i32>* %sum, align 16
  %33 = load <4 x i32>* %size, align 16
  %div31 = sdiv <4 x i32> %32, %33
  %call32 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div31) #1
  %34 = load i32* %pos, align 4
  %idxprom33 = sext i32 %34 to i64
  %35 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx34 = getelementptr inbounds <4 x i8> addrspace(1)* %35, i64 %idxprom33
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
  %inputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %outputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %filterWidth.addr = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %pos = alloca i32, align 4
  %k = alloca i32, align 4
  %size = alloca <4 x i32>, align 16
  %sum = alloca <4 x i32>, align 16
  %Y = alloca i32, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %inputImage.addr, align 8
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %outputImage.addr, align 8
  store i32 %filterWidth, i32* %filterWidth.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %y, align 4
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %width, align 4
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %height, align 4
  %0 = load i32* %x, align 4
  %1 = load i32* %y, align 4
  %2 = load i32* %width, align 4
  %mul = mul nsw i32 %1, %2
  %add = add nsw i32 %0, %mul
  store i32 %add, i32* %pos, align 4
  %3 = load i32* %filterWidth.addr, align 4
  %sub = sub nsw i32 %3, 1
  %div = sdiv i32 %sub, 2
  store i32 %div, i32* %k, align 4
  %4 = load i32* %y, align 4
  %5 = load i32* %k, align 4
  %cmp = icmp slt i32 %4, %5
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %6 = load i32* %y, align 4
  %7 = load i32* %height, align 4
  %8 = load i32* %k, align 4
  %sub8 = sub nsw i32 %7, %8
  %cmp9 = icmp sge i32 %6, %sub8
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  %9 = load i32* %pos, align 4
  %idxprom = sext i32 %9 to i64
  %10 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %10, i64 %idxprom
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %arrayidx, align 4
  br label %return

if.end:                                           ; preds = %lor.lhs.false
  %11 = load i32* %filterWidth.addr, align 4
  %12 = insertelement <4 x i32> undef, i32 %11, i32 0
  %splat = shufflevector <4 x i32> %12, <4 x i32> %12, <4 x i32> zeroinitializer
  store <4 x i32> %splat, <4 x i32>* %size, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  %13 = load i32* %k, align 4
  %sub11 = sub nsw i32 0, %13
  store i32 %sub11, i32* %Y, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end
  %14 = load i32* %Y, align 4
  %15 = load i32* %k, align 4
  %cmp12 = icmp slt i32 %14, %15
  br i1 %cmp12, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %16 = load i32* %pos, align 4
  %17 = load i32* %Y, align 4
  %18 = load i32* %width, align 4
  %mul14 = mul nsw i32 %17, %18
  %add15 = add nsw i32 %16, %mul14
  %idxprom16 = sext i32 %add15 to i64
  %19 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx17 = getelementptr inbounds <4 x i8> addrspace(1)* %19, i64 %idxprom16
  %20 = load <4 x i8> addrspace(1)* %arrayidx17, align 4
  %call18 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %20) #1
  %21 = load <4 x i32>* %sum, align 16
  %add19 = add <4 x i32> %21, %call18
  store <4 x i32> %add19, <4 x i32>* %sum, align 16
  %22 = load i32* %pos, align 4
  %23 = load i32* %Y, align 4
  %add20 = add nsw i32 %23, 1
  %24 = load i32* %width, align 4
  %mul21 = mul nsw i32 %add20, %24
  %add22 = add nsw i32 %22, %mul21
  %idxprom23 = sext i32 %add22 to i64
  %25 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx24 = getelementptr inbounds <4 x i8> addrspace(1)* %25, i64 %idxprom23
  %26 = load <4 x i8> addrspace(1)* %arrayidx24, align 4
  %call25 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %26) #1
  %27 = load <4 x i32>* %sum, align 16
  %add26 = add <4 x i32> %27, %call25
  store <4 x i32> %add26, <4 x i32>* %sum, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %28 = load i32* %Y, align 4
  %add27 = add nsw i32 %28, 2
  store i32 %add27, i32* %Y, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %29 = load i32* %pos, align 4
  %30 = load i32* %k, align 4
  %31 = load i32* %width, align 4
  %mul28 = mul nsw i32 %30, %31
  %add29 = add nsw i32 %29, %mul28
  %idxprom30 = sext i32 %add29 to i64
  %32 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx31 = getelementptr inbounds <4 x i8> addrspace(1)* %32, i64 %idxprom30
  %33 = load <4 x i8> addrspace(1)* %arrayidx31, align 4
  %call32 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %33) #1
  %34 = load <4 x i32>* %sum, align 16
  %add33 = add <4 x i32> %34, %call32
  store <4 x i32> %add33, <4 x i32>* %sum, align 16
  %35 = load <4 x i32>* %sum, align 16
  %36 = load <4 x i32>* %size, align 16
  %div34 = sdiv <4 x i32> %35, %36
  %call35 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div34) #1
  %37 = load i32* %pos, align 4
  %idxprom36 = sext i32 %37 to i64
  %38 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx37 = getelementptr inbounds <4 x i8> addrspace(1)* %38, i64 %idxprom36
  store <4 x i8> %call35, <4 x i8> addrspace(1)* %arrayidx37, align 4
  br label %return

return:                                           ; preds = %for.end, %if.then
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_box_filter_horizontal_local_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth, <4 x i8> addrspace(3)* %lds) #0 {
entry:
  %inputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %outputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %filterWidth.addr = alloca i32, align 4
  %lds.addr = alloca <4 x i8> addrspace(3)*, align 8
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %pos = alloca i32, align 4
  %k = alloca i32, align 4
  %lid = alloca i32, align 4
  %gidX = alloca i32, align 4
  %gidY = alloca i32, align 4
  %gSizeX = alloca i32, align 4
  %gSizeY = alloca i32, align 4
  %firstElement = alloca i32, align 4
  %size = alloca <4 x i32>, align 16
  %sum = alloca <4 x i32>, align 16
  %X = alloca i32, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %inputImage.addr, align 8
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %outputImage.addr, align 8
  store i32 %filterWidth, i32* %filterWidth.addr, align 4
  store <4 x i8> addrspace(3)* %lds, <4 x i8> addrspace(3)** %lds.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %y, align 4
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %width, align 4
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %height, align 4
  %0 = load i32* %x, align 4
  %1 = load i32* %y, align 4
  %2 = load i32* %width, align 4
  %mul = mul nsw i32 %1, %2
  %add = add nsw i32 %0, %mul
  store i32 %add, i32* %pos, align 4
  %3 = load i32* %filterWidth.addr, align 4
  %sub = sub nsw i32 %3, 1
  %div = sdiv i32 %sub, 2
  store i32 %div, i32* %k, align 4
  %call7 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv8 = trunc i64 %call7 to i32
  store i32 %conv8, i32* %lid, align 4
  %call9 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv10 = trunc i64 %call9 to i32
  store i32 %conv10, i32* %gidX, align 4
  %call11 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv12 = trunc i64 %call11 to i32
  store i32 %conv12, i32* %gidY, align 4
  %call13 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv14 = trunc i64 %call13 to i32
  store i32 %conv14, i32* %gSizeX, align 4
  %call15 = call cc75 i64 @_Z14get_local_sizej(i32 1) #1
  %conv16 = trunc i64 %call15 to i32
  store i32 %conv16, i32* %gSizeY, align 4
  %4 = load i32* %gSizeX, align 4
  %5 = load i32* %gidX, align 4
  %mul17 = mul nsw i32 %4, %5
  %6 = load i32* %width, align 4
  %7 = load i32* %gidY, align 4
  %mul18 = mul nsw i32 %6, %7
  %8 = load i32* %gSizeY, align 4
  %mul19 = mul nsw i32 %mul18, %8
  %add20 = add nsw i32 %mul17, %mul19
  store i32 %add20, i32* %firstElement, align 4
  %9 = load i32* %lid, align 4
  %10 = load i32* %k, align 4
  %cmp = icmp slt i32 %9, %10
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %11 = load i32* %firstElement, align 4
  %12 = load i32* %k, align 4
  %sub22 = sub nsw i32 %11, %12
  %13 = load i32* %lid, align 4
  %add23 = add nsw i32 %sub22, %13
  %idxprom = sext i32 %add23 to i64
  %14 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %14, i64 %idxprom
  %15 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %16 = load i32* %lid, align 4
  %idxprom24 = sext i32 %16 to i64
  %17 = load <4 x i8> addrspace(3)** %lds.addr, align 8
  %arrayidx25 = getelementptr inbounds <4 x i8> addrspace(3)* %17, i64 %idxprom24
  store <4 x i8> %15, <4 x i8> addrspace(3)* %arrayidx25, align 4
  %18 = load i32* %firstElement, align 4
  %19 = load i32* %lid, align 4
  %add26 = add nsw i32 %18, %19
  %add27 = add nsw i32 %add26, 256
  %idxprom28 = sext i32 %add27 to i64
  %20 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx29 = getelementptr inbounds <4 x i8> addrspace(1)* %20, i64 %idxprom28
  %21 = load <4 x i8> addrspace(1)* %arrayidx29, align 4
  %22 = load i32* %k, align 4
  %add30 = add nsw i32 256, %22
  %23 = load i32* %lid, align 4
  %add31 = add nsw i32 %add30, %23
  %idxprom32 = sext i32 %add31 to i64
  %24 = load <4 x i8> addrspace(3)** %lds.addr, align 8
  %arrayidx33 = getelementptr inbounds <4 x i8> addrspace(3)* %24, i64 %idxprom32
  store <4 x i8> %21, <4 x i8> addrspace(3)* %arrayidx33, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %25 = load i32* %firstElement, align 4
  %26 = load i32* %lid, align 4
  %add34 = add nsw i32 %25, %26
  %idxprom35 = sext i32 %add34 to i64
  %27 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx36 = getelementptr inbounds <4 x i8> addrspace(1)* %27, i64 %idxprom35
  %28 = load <4 x i8> addrspace(1)* %arrayidx36, align 4
  %29 = load i32* %lid, align 4
  %30 = load i32* %k, align 4
  %add37 = add nsw i32 %29, %30
  %idxprom38 = sext i32 %add37 to i64
  %31 = load <4 x i8> addrspace(3)** %lds.addr, align 8
  %arrayidx39 = getelementptr inbounds <4 x i8> addrspace(3)* %31, i64 %idxprom38
  store <4 x i8> %28, <4 x i8> addrspace(3)* %arrayidx39, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %32 = load i32* %x, align 4
  %33 = load i32* %k, align 4
  %cmp40 = icmp slt i32 %32, %33
  br i1 %cmp40, label %if.then45, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end
  %34 = load i32* %x, align 4
  %35 = load i32* %width, align 4
  %36 = load i32* %k, align 4
  %sub42 = sub nsw i32 %35, %36
  %cmp43 = icmp sge i32 %34, %sub42
  br i1 %cmp43, label %if.then45, label %if.end46

if.then45:                                        ; preds = %lor.lhs.false, %if.end
  br label %return

if.end46:                                         ; preds = %lor.lhs.false
  %37 = load i32* %filterWidth.addr, align 4
  %38 = insertelement <4 x i32> undef, i32 %37, i32 0
  %splat = shufflevector <4 x i32> %38, <4 x i32> %38, <4 x i32> zeroinitializer
  store <4 x i32> %splat, <4 x i32>* %size, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  %39 = load i32* %k, align 4
  %sub47 = sub nsw i32 0, %39
  store i32 %sub47, i32* %X, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end46
  %40 = load i32* %X, align 4
  %41 = load i32* %k, align 4
  %cmp48 = icmp sle i32 %40, %41
  br i1 %cmp48, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %42 = load i32* %lid, align 4
  %43 = load i32* %X, align 4
  %add50 = add nsw i32 %42, %43
  %44 = load i32* %k, align 4
  %add51 = add nsw i32 %add50, %44
  %idxprom52 = sext i32 %add51 to i64
  %45 = load <4 x i8> addrspace(3)** %lds.addr, align 8
  %arrayidx53 = getelementptr inbounds <4 x i8> addrspace(3)* %45, i64 %idxprom52
  %46 = load <4 x i8> addrspace(3)* %arrayidx53, align 4
  %call54 = call cc75 <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %46) #1
  %47 = load <4 x i32>* %sum, align 16
  %add55 = add <4 x i32> %47, %call54
  store <4 x i32> %add55, <4 x i32>* %sum, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %48 = load i32* %X, align 4
  %inc = add nsw i32 %48, 1
  store i32 %inc, i32* %X, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %49 = load <4 x i32>* %sum, align 16
  %50 = load <4 x i32>* %size, align 16
  %div56 = sdiv <4 x i32> %49, %50
  %call57 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %div56) #1
  %51 = load i32* %pos, align 4
  %idxprom58 = sext i32 %51 to i64
  %52 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx59 = getelementptr inbounds <4 x i8> addrspace(1)* %52, i64 %idxprom58
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

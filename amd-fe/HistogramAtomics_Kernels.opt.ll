; ModuleID = 'HistogramAtomics_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@histogramKernel_Vector.subhists = internal addrspace(3) global [4096 x i32] zeroinitializer, align 4
@histogramKernel_Scalar.subhists = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_histogramKernel_Vector_kernel(<4 x i32> addrspace(1)* %Image, i32 addrspace(1)* %Histogram, i32 %n4VectorsPerThread) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv6 = trunc i64 %call5 to i32
  %rem = urem i32 %conv2, 16
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ %conv2, %entry ], [ %add, %for.inc ]
  %div = udiv i32 4096, 4
  %cmp = icmp ult i32 %i.0, %div
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %idxprom = zext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(3)* bitcast ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists to <4 x i32> addrspace(3)*), i64 %idxprom
  store <4 x i32> zeroinitializer, <4 x i32> addrspace(3)* %arrayidx, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %add = add i32 %i.0, %conv6
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc77, %for.end
  %i.1 = phi i32 [ 0, %for.end ], [ %inc, %for.inc77 ]
  %cmp9 = icmp ult i32 %i.1, %n4VectorsPerThread
  br i1 %cmp9, label %for.body11, label %for.end78

for.body11:                                       ; preds = %for.cond8
  %mul = mul i32 %i.1, %conv4
  %add12 = add i32 %conv, %mul
  %idxprom13 = zext i32 %add12 to i64
  %arrayidx14 = getelementptr inbounds <4 x i32> addrspace(1)* %Image, i64 %idxprom13
  %0 = load <4 x i32> addrspace(1)* %arrayidx14, align 16
  %and = and <4 x i32> %0, <i32 255, i32 255, i32 255, i32 255>
  %mul15 = mul <4 x i32> %and, <i32 16, i32 16, i32 16, i32 16>
  %1 = insertelement <4 x i32> undef, i32 %rem, i32 0
  %splat = shufflevector <4 x i32> %1, <4 x i32> %1, <4 x i32> zeroinitializer
  %add16 = add <4 x i32> %mul15, %splat
  %2 = extractelement <4 x i32> %add16, i32 0
  %idx.ext = zext i32 %2 to i64
  %add.ptr = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext
  %call17 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr)
  %3 = extractelement <4 x i32> %add16, i32 1
  %idx.ext18 = zext i32 %3 to i64
  %add.ptr19 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext18
  %call20 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr19)
  %4 = extractelement <4 x i32> %add16, i32 2
  %idx.ext21 = zext i32 %4 to i64
  %add.ptr22 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext21
  %call23 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr22)
  %5 = extractelement <4 x i32> %add16, i32 3
  %idx.ext24 = zext i32 %5 to i64
  %add.ptr25 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext24
  %call26 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr25)
  %shr = lshr <4 x i32> %0, <i32 8, i32 8, i32 8, i32 8>
  %and27 = and <4 x i32> %shr, <i32 255, i32 255, i32 255, i32 255>
  %mul28 = mul <4 x i32> %and27, <i32 16, i32 16, i32 16, i32 16>
  %6 = insertelement <4 x i32> undef, i32 %rem, i32 0
  %splat29 = shufflevector <4 x i32> %6, <4 x i32> %6, <4 x i32> zeroinitializer
  %add30 = add <4 x i32> %mul28, %splat29
  %7 = extractelement <4 x i32> %add30, i32 0
  %idx.ext31 = zext i32 %7 to i64
  %add.ptr32 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext31
  %call33 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr32)
  %8 = extractelement <4 x i32> %add30, i32 1
  %idx.ext34 = zext i32 %8 to i64
  %add.ptr35 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext34
  %call36 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr35)
  %9 = extractelement <4 x i32> %add30, i32 2
  %idx.ext37 = zext i32 %9 to i64
  %add.ptr38 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext37
  %call39 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr38)
  %10 = extractelement <4 x i32> %add30, i32 3
  %idx.ext40 = zext i32 %10 to i64
  %add.ptr41 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext40
  %call42 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr41)
  %shr43 = lshr <4 x i32> %shr, <i32 8, i32 8, i32 8, i32 8>
  %and44 = and <4 x i32> %shr43, <i32 255, i32 255, i32 255, i32 255>
  %mul45 = mul <4 x i32> %and44, <i32 16, i32 16, i32 16, i32 16>
  %11 = insertelement <4 x i32> undef, i32 %rem, i32 0
  %splat46 = shufflevector <4 x i32> %11, <4 x i32> %11, <4 x i32> zeroinitializer
  %add47 = add <4 x i32> %mul45, %splat46
  %12 = extractelement <4 x i32> %add47, i32 0
  %idx.ext48 = zext i32 %12 to i64
  %add.ptr49 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext48
  %call50 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr49)
  %13 = extractelement <4 x i32> %add47, i32 1
  %idx.ext51 = zext i32 %13 to i64
  %add.ptr52 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext51
  %call53 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr52)
  %14 = extractelement <4 x i32> %add47, i32 2
  %idx.ext54 = zext i32 %14 to i64
  %add.ptr55 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext54
  %call56 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr55)
  %15 = extractelement <4 x i32> %add47, i32 3
  %idx.ext57 = zext i32 %15 to i64
  %add.ptr58 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext57
  %call59 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr58)
  %shr60 = lshr <4 x i32> %shr43, <i32 8, i32 8, i32 8, i32 8>
  %and61 = and <4 x i32> %shr60, <i32 255, i32 255, i32 255, i32 255>
  %mul62 = mul <4 x i32> %and61, <i32 16, i32 16, i32 16, i32 16>
  %16 = insertelement <4 x i32> undef, i32 %rem, i32 0
  %splat63 = shufflevector <4 x i32> %16, <4 x i32> %16, <4 x i32> zeroinitializer
  %add64 = add <4 x i32> %mul62, %splat63
  %17 = extractelement <4 x i32> %add64, i32 0
  %idx.ext65 = zext i32 %17 to i64
  %add.ptr66 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext65
  %call67 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr66)
  %18 = extractelement <4 x i32> %add64, i32 1
  %idx.ext68 = zext i32 %18 to i64
  %add.ptr69 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext68
  %call70 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr69)
  %19 = extractelement <4 x i32> %add64, i32 2
  %idx.ext71 = zext i32 %19 to i64
  %add.ptr72 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext71
  %call73 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr72)
  %20 = extractelement <4 x i32> %add64, i32 3
  %idx.ext74 = zext i32 %20 to i64
  %add.ptr75 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext74
  %call76 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr75)
  br label %for.inc77

for.inc77:                                        ; preds = %for.body11
  %inc = add i32 %i.1, 1
  br label %for.cond8

for.end78:                                        ; preds = %for.cond8
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond79

for.cond79:                                       ; preds = %for.inc102, %for.end78
  %i.2 = phi i32 [ %conv2, %for.end78 ], [ %add103, %for.inc102 ]
  %cmp80 = icmp ult i32 %i.2, 256
  br i1 %cmp80, label %for.body82, label %for.end104

for.body82:                                       ; preds = %for.cond79
  br label %for.cond83

for.cond83:                                       ; preds = %for.inc93, %for.body82
  %bin.0 = phi i32 [ 0, %for.body82 ], [ %add92, %for.inc93 ]
  %off.0 = phi i32 [ %rem, %for.body82 ], [ %inc95, %for.inc93 ]
  %j.0 = phi i32 [ 0, %for.body82 ], [ %inc94, %for.inc93 ]
  %cmp84 = icmp slt i32 %j.0, 16
  br i1 %cmp84, label %for.body86, label %for.end96

for.body86:                                       ; preds = %for.cond83
  %mul87 = mul i32 %i.2, 16
  %rem88 = urem i32 %off.0, 16
  %add89 = add i32 %mul87, %rem88
  %idxprom90 = zext i32 %add89 to i64
  %arrayidx91 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i64 %idxprom90
  %21 = load i32 addrspace(3)* %arrayidx91, align 4
  %add92 = add i32 %bin.0, %21
  br label %for.inc93

for.inc93:                                        ; preds = %for.body86
  %inc94 = add nsw i32 %j.0, 1
  %inc95 = add i32 %off.0, 1
  br label %for.cond83

for.end96:                                        ; preds = %for.cond83
  %call97 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %mul98 = mul i64 %call97, 256
  %conv99 = zext i32 %i.2 to i64
  %add100 = add i64 %mul98, %conv99
  %arrayidx101 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %add100
  store i32 %bin.0, i32 addrspace(1)* %arrayidx101, align 4
  br label %for.inc102

for.inc102:                                       ; preds = %for.end96
  %add103 = add i32 %i.2, %conv6
  br label %for.cond79

for.end104:                                       ; preds = %for.cond79
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

declare cc75 void @_Z7barrierj(i32)

declare cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)*)

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_histogramKernel_Scalar_kernel(i32 addrspace(1)* %Image, i32 addrspace(1)* %Histogram, i32 %nVectorsPerThread) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv6 = trunc i64 %call5 to i32
  %rem = urem i32 %conv2, 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ %conv2, %entry ], [ %add, %for.inc ]
  %cmp = icmp ult i32 %i.0, 1024
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %idxprom = zext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i64 %idxprom
  store i32 0, i32 addrspace(3)* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %add = add i32 %i.0, %conv6
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc38, %for.end
  %i.1 = phi i32 [ 0, %for.end ], [ %inc, %for.inc38 ]
  %cmp9 = icmp ult i32 %i.1, %nVectorsPerThread
  br i1 %cmp9, label %for.body11, label %for.end39

for.body11:                                       ; preds = %for.cond8
  %mul = mul i32 %i.1, %conv4
  %add12 = add i32 %conv, %mul
  %idxprom13 = zext i32 %add12 to i64
  %arrayidx14 = getelementptr inbounds i32 addrspace(1)* %Image, i64 %idxprom13
  %0 = load i32 addrspace(1)* %arrayidx14, align 4
  %and = and i32 %0, 255
  %mul15 = mul i32 %and, 4
  %add16 = add i32 %mul15, %rem
  %idx.ext = zext i32 %add16 to i64
  %add.ptr = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i64 %idx.ext
  %call17 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr)
  %shr = lshr i32 %0, 8
  %and18 = and i32 %shr, 255
  %mul19 = mul i32 %and18, 4
  %add20 = add i32 %mul19, %rem
  %idx.ext21 = zext i32 %add20 to i64
  %add.ptr22 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i64 %idx.ext21
  %call23 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr22)
  %shr24 = lshr i32 %shr, 8
  %and25 = and i32 %shr24, 255
  %mul26 = mul i32 %and25, 4
  %add27 = add i32 %mul26, %rem
  %idx.ext28 = zext i32 %add27 to i64
  %add.ptr29 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i64 %idx.ext28
  %call30 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr29)
  %shr31 = lshr i32 %shr24, 8
  %and32 = and i32 %shr31, 255
  %mul33 = mul i32 %and32, 4
  %add34 = add i32 %mul33, %rem
  %idx.ext35 = zext i32 %add34 to i64
  %add.ptr36 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i64 %idx.ext35
  %call37 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr36)
  br label %for.inc38

for.inc38:                                        ; preds = %for.body11
  %inc = add i32 %i.1, 1
  br label %for.cond8

for.end39:                                        ; preds = %for.cond8
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.cond40

for.cond40:                                       ; preds = %for.inc64, %for.end39
  %i.2 = phi i32 [ %conv2, %for.end39 ], [ %add65, %for.inc64 ]
  %cmp41 = icmp ult i32 %i.2, 256
  br i1 %cmp41, label %for.body43, label %for.end66

for.body43:                                       ; preds = %for.cond40
  br label %for.cond45

for.cond45:                                       ; preds = %for.inc55, %for.body43
  %bin.0 = phi i32 [ 0, %for.body43 ], [ %add54, %for.inc55 ]
  %off.0 = phi i32 [ %rem, %for.body43 ], [ %inc57, %for.inc55 ]
  %j44.0 = phi i32 [ 0, %for.body43 ], [ %inc56, %for.inc55 ]
  %cmp46 = icmp slt i32 %j44.0, 4
  br i1 %cmp46, label %for.body48, label %for.end58

for.body48:                                       ; preds = %for.cond45
  %mul49 = mul i32 %i.2, 4
  %rem50 = urem i32 %off.0, 4
  %add51 = add i32 %mul49, %rem50
  %idxprom52 = zext i32 %add51 to i64
  %arrayidx53 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i64 %idxprom52
  %1 = load i32 addrspace(3)* %arrayidx53, align 4
  %add54 = add i32 %bin.0, %1
  br label %for.inc55

for.inc55:                                        ; preds = %for.body48
  %inc56 = add nsw i32 %j44.0, 1
  %inc57 = add i32 %off.0, 1
  br label %for.cond45

for.end58:                                        ; preds = %for.cond45
  %call59 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %mul60 = mul i64 %call59, 256
  %conv61 = zext i32 %i.2 to i64
  %add62 = add i64 %mul60, %conv61
  %arrayidx63 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %add62
  store i32 %bin.0, i32 addrspace(1)* %arrayidx63, align 4
  br label %for.inc64

for.inc64:                                        ; preds = %for.end58
  %add65 = add i32 %i.2, %conv6
  br label %for.cond40

for.end66:                                        ; preds = %for.cond40
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_reduceKernel_kernel(i32 addrspace(1)* %Histogram, i32 %nSubHists) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %bin.0 = phi i32 [ 0, %entry ], [ %add20, %for.inc ]
  %i.0 = phi i32 [ 0, %entry ], [ %add21, %for.inc ]
  %cmp = icmp ult i32 %i.0, %nSubHists
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %mul = mul nsw i32 %i.0, 256
  %add = add i32 %mul, %conv
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %mul2 = mul nsw i32 %i.0, 256
  %add3 = add i32 %mul2, %conv
  %add4 = add i32 %add3, 256
  %idxprom5 = zext i32 %add4 to i64
  %arrayidx6 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %idxprom5
  %1 = load i32 addrspace(1)* %arrayidx6, align 4
  %add7 = add i32 %0, %1
  %mul8 = mul nsw i32 %i.0, 256
  %add9 = add i32 %mul8, %conv
  %add10 = add i32 %add9, 512
  %idxprom11 = zext i32 %add10 to i64
  %arrayidx12 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %idxprom11
  %2 = load i32 addrspace(1)* %arrayidx12, align 4
  %add13 = add i32 %add7, %2
  %mul14 = mul nsw i32 %i.0, 256
  %add15 = add i32 %mul14, %conv
  %add16 = add i32 %add15, 768
  %idxprom17 = zext i32 %add16 to i64
  %arrayidx18 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %idxprom17
  %3 = load i32 addrspace(1)* %arrayidx18, align 4
  %add19 = add i32 %add13, %3
  %add20 = add i32 %bin.0, %add19
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %add21 = add nsw i32 %i.0, 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %idxprom22 = zext i32 %conv to i64
  %arrayidx23 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %idxprom22
  store i32 %bin.0, i32 addrspace(1)* %arrayidx23, align 4
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !9}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!15}
!opencl.spir.version = !{!15}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32)* @__OpenCL_histogramKernel_Vector_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint4*", metadata !"uint*", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint4*", metadata !"uint*", metadata !"uint"}
!6 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @__OpenCL_histogramKernel_Scalar_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint*", metadata !"uint"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint*", metadata !"uint"}
!9 = metadata !{void (i32 addrspace(1)*, i32)* @__OpenCL_reduceKernel_kernel, metadata !10, metadata !11, metadata !12, metadata !13, metadata !14}
!10 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0}
!11 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!12 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint"}
!13 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!14 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint"}
!15 = metadata !{i32 1, i32 2}

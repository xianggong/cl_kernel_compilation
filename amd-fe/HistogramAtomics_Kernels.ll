; ModuleID = 'HistogramAtomics_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@histogramKernel_Vector.subhists = internal addrspace(3) global [4096 x i32] zeroinitializer, align 4
@histogramKernel_Scalar.subhists = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_histogramKernel_Vector_kernel(<4 x i32> addrspace(1)* %Image, i32 addrspace(1)* %Histogram, i32 %n4VectorsPerThread) #0 {
entry:
  %Image.addr = alloca <4 x i32> addrspace(1)*, align 8
  %Histogram.addr = alloca i32 addrspace(1)*, align 8
  %n4VectorsPerThread.addr = alloca i32, align 4
  %tid = alloca i32, align 4
  %ltid = alloca i32, align 4
  %Stride = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %i = alloca i32, align 4
  %temp = alloca <4 x i32>, align 16
  %temp2 = alloca <4 x i32>, align 16
  %shft = alloca i32, align 4
  %msk = alloca i32, align 4
  %offset = alloca i32, align 4
  %lmem_items = alloca i32, align 4
  %p = alloca <4 x i32> addrspace(3)*, align 8
  %bin = alloca i32, align 4
  %off = alloca i32, align 4
  %j = alloca i32, align 4
  store <4 x i32> addrspace(1)* %Image, <4 x i32> addrspace(1)** %Image.addr, align 8
  store i32 addrspace(1)* %Histogram, i32 addrspace(1)** %Histogram.addr, align 8
  store i32 %n4VectorsPerThread, i32* %n4VectorsPerThread.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %ltid, align 4
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %Stride, align 4
  %call5 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %groupSize, align 4
  store i32 8, i32* %shft, align 4
  store i32 255, i32* %msk, align 4
  %0 = load i32* %ltid, align 4
  %rem = urem i32 %0, 16
  store i32 %rem, i32* %offset, align 4
  store i32 4096, i32* %lmem_items, align 4
  store <4 x i32> addrspace(3)* bitcast ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists to <4 x i32> addrspace(3)*), <4 x i32> addrspace(3)** %p, align 8
  %1 = load i32* %ltid, align 4
  store i32 %1, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32* %i, align 4
  %3 = load i32* %lmem_items, align 4
  %div = udiv i32 %3, 4
  %cmp = icmp ult i32 %2, %div
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i32* %i, align 4
  %idxprom = zext i32 %4 to i64
  %5 = load <4 x i32> addrspace(3)** %p, align 8
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(3)* %5, i64 %idxprom
  store <4 x i32> zeroinitializer, <4 x i32> addrspace(3)* %arrayidx, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32* %groupSize, align 4
  %7 = load i32* %i, align 4
  %add = add i32 %7, %6
  store i32 %add, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %i, align 4
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc77, %for.end
  %8 = load i32* %i, align 4
  %9 = load i32* %n4VectorsPerThread.addr, align 4
  %cmp9 = icmp ult i32 %8, %9
  br i1 %cmp9, label %for.body11, label %for.end78

for.body11:                                       ; preds = %for.cond8
  %10 = load i32* %tid, align 4
  %11 = load i32* %i, align 4
  %12 = load i32* %Stride, align 4
  %mul = mul i32 %11, %12
  %add12 = add i32 %10, %mul
  %idxprom13 = zext i32 %add12 to i64
  %13 = load <4 x i32> addrspace(1)** %Image.addr, align 8
  %arrayidx14 = getelementptr inbounds <4 x i32> addrspace(1)* %13, i64 %idxprom13
  %14 = load <4 x i32> addrspace(1)* %arrayidx14, align 16
  store <4 x i32> %14, <4 x i32>* %temp, align 16
  %15 = load <4 x i32>* %temp, align 16
  %and = and <4 x i32> %15, <i32 255, i32 255, i32 255, i32 255>
  %mul15 = mul <4 x i32> %and, <i32 16, i32 16, i32 16, i32 16>
  %16 = load i32* %offset, align 4
  %17 = insertelement <4 x i32> undef, i32 %16, i32 0
  %splat = shufflevector <4 x i32> %17, <4 x i32> %17, <4 x i32> zeroinitializer
  %add16 = add <4 x i32> %mul15, %splat
  store <4 x i32> %add16, <4 x i32>* %temp2, align 16
  %18 = load <4 x i32>* %temp2, align 16
  %19 = extractelement <4 x i32> %18, i32 0
  %idx.ext = zext i32 %19 to i64
  %add.ptr = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext
  %call17 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr)
  %20 = load <4 x i32>* %temp2, align 16
  %21 = extractelement <4 x i32> %20, i32 1
  %idx.ext18 = zext i32 %21 to i64
  %add.ptr19 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext18
  %call20 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr19)
  %22 = load <4 x i32>* %temp2, align 16
  %23 = extractelement <4 x i32> %22, i32 2
  %idx.ext21 = zext i32 %23 to i64
  %add.ptr22 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext21
  %call23 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr22)
  %24 = load <4 x i32>* %temp2, align 16
  %25 = extractelement <4 x i32> %24, i32 3
  %idx.ext24 = zext i32 %25 to i64
  %add.ptr25 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext24
  %call26 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr25)
  %26 = load <4 x i32>* %temp, align 16
  %shr = lshr <4 x i32> %26, <i32 8, i32 8, i32 8, i32 8>
  store <4 x i32> %shr, <4 x i32>* %temp, align 16
  %27 = load <4 x i32>* %temp, align 16
  %and27 = and <4 x i32> %27, <i32 255, i32 255, i32 255, i32 255>
  %mul28 = mul <4 x i32> %and27, <i32 16, i32 16, i32 16, i32 16>
  %28 = load i32* %offset, align 4
  %29 = insertelement <4 x i32> undef, i32 %28, i32 0
  %splat29 = shufflevector <4 x i32> %29, <4 x i32> %29, <4 x i32> zeroinitializer
  %add30 = add <4 x i32> %mul28, %splat29
  store <4 x i32> %add30, <4 x i32>* %temp2, align 16
  %30 = load <4 x i32>* %temp2, align 16
  %31 = extractelement <4 x i32> %30, i32 0
  %idx.ext31 = zext i32 %31 to i64
  %add.ptr32 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext31
  %call33 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr32)
  %32 = load <4 x i32>* %temp2, align 16
  %33 = extractelement <4 x i32> %32, i32 1
  %idx.ext34 = zext i32 %33 to i64
  %add.ptr35 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext34
  %call36 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr35)
  %34 = load <4 x i32>* %temp2, align 16
  %35 = extractelement <4 x i32> %34, i32 2
  %idx.ext37 = zext i32 %35 to i64
  %add.ptr38 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext37
  %call39 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr38)
  %36 = load <4 x i32>* %temp2, align 16
  %37 = extractelement <4 x i32> %36, i32 3
  %idx.ext40 = zext i32 %37 to i64
  %add.ptr41 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext40
  %call42 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr41)
  %38 = load <4 x i32>* %temp, align 16
  %shr43 = lshr <4 x i32> %38, <i32 8, i32 8, i32 8, i32 8>
  store <4 x i32> %shr43, <4 x i32>* %temp, align 16
  %39 = load <4 x i32>* %temp, align 16
  %and44 = and <4 x i32> %39, <i32 255, i32 255, i32 255, i32 255>
  %mul45 = mul <4 x i32> %and44, <i32 16, i32 16, i32 16, i32 16>
  %40 = load i32* %offset, align 4
  %41 = insertelement <4 x i32> undef, i32 %40, i32 0
  %splat46 = shufflevector <4 x i32> %41, <4 x i32> %41, <4 x i32> zeroinitializer
  %add47 = add <4 x i32> %mul45, %splat46
  store <4 x i32> %add47, <4 x i32>* %temp2, align 16
  %42 = load <4 x i32>* %temp2, align 16
  %43 = extractelement <4 x i32> %42, i32 0
  %idx.ext48 = zext i32 %43 to i64
  %add.ptr49 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext48
  %call50 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr49)
  %44 = load <4 x i32>* %temp2, align 16
  %45 = extractelement <4 x i32> %44, i32 1
  %idx.ext51 = zext i32 %45 to i64
  %add.ptr52 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext51
  %call53 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr52)
  %46 = load <4 x i32>* %temp2, align 16
  %47 = extractelement <4 x i32> %46, i32 2
  %idx.ext54 = zext i32 %47 to i64
  %add.ptr55 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext54
  %call56 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr55)
  %48 = load <4 x i32>* %temp2, align 16
  %49 = extractelement <4 x i32> %48, i32 3
  %idx.ext57 = zext i32 %49 to i64
  %add.ptr58 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext57
  %call59 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr58)
  %50 = load <4 x i32>* %temp, align 16
  %shr60 = lshr <4 x i32> %50, <i32 8, i32 8, i32 8, i32 8>
  store <4 x i32> %shr60, <4 x i32>* %temp, align 16
  %51 = load <4 x i32>* %temp, align 16
  %and61 = and <4 x i32> %51, <i32 255, i32 255, i32 255, i32 255>
  %mul62 = mul <4 x i32> %and61, <i32 16, i32 16, i32 16, i32 16>
  %52 = load i32* %offset, align 4
  %53 = insertelement <4 x i32> undef, i32 %52, i32 0
  %splat63 = shufflevector <4 x i32> %53, <4 x i32> %53, <4 x i32> zeroinitializer
  %add64 = add <4 x i32> %mul62, %splat63
  store <4 x i32> %add64, <4 x i32>* %temp2, align 16
  %54 = load <4 x i32>* %temp2, align 16
  %55 = extractelement <4 x i32> %54, i32 0
  %idx.ext65 = zext i32 %55 to i64
  %add.ptr66 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext65
  %call67 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr66)
  %56 = load <4 x i32>* %temp2, align 16
  %57 = extractelement <4 x i32> %56, i32 1
  %idx.ext68 = zext i32 %57 to i64
  %add.ptr69 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext68
  %call70 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr69)
  %58 = load <4 x i32>* %temp2, align 16
  %59 = extractelement <4 x i32> %58, i32 2
  %idx.ext71 = zext i32 %59 to i64
  %add.ptr72 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext71
  %call73 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr72)
  %60 = load <4 x i32>* %temp2, align 16
  %61 = extractelement <4 x i32> %60, i32 3
  %idx.ext74 = zext i32 %61 to i64
  %add.ptr75 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i64 %idx.ext74
  %call76 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr75)
  br label %for.inc77

for.inc77:                                        ; preds = %for.body11
  %62 = load i32* %i, align 4
  %inc = add i32 %62, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond8

for.end78:                                        ; preds = %for.cond8
  call cc75 void @_Z7barrierj(i32 1)
  %63 = load i32* %ltid, align 4
  store i32 %63, i32* %i, align 4
  br label %for.cond79

for.cond79:                                       ; preds = %for.inc102, %for.end78
  %64 = load i32* %i, align 4
  %cmp80 = icmp ult i32 %64, 256
  br i1 %cmp80, label %for.body82, label %for.end104

for.body82:                                       ; preds = %for.cond79
  store i32 0, i32* %bin, align 4
  %65 = load i32* %offset, align 4
  store i32 %65, i32* %off, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond83

for.cond83:                                       ; preds = %for.inc93, %for.body82
  %66 = load i32* %j, align 4
  %cmp84 = icmp slt i32 %66, 16
  br i1 %cmp84, label %for.body86, label %for.end96

for.body86:                                       ; preds = %for.cond83
  %67 = load i32* %i, align 4
  %mul87 = mul i32 %67, 16
  %68 = load i32* %off, align 4
  %rem88 = urem i32 %68, 16
  %add89 = add i32 %mul87, %rem88
  %idxprom90 = zext i32 %add89 to i64
  %arrayidx91 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i64 %idxprom90
  %69 = load i32 addrspace(3)* %arrayidx91, align 4
  %70 = load i32* %bin, align 4
  %add92 = add i32 %70, %69
  store i32 %add92, i32* %bin, align 4
  br label %for.inc93

for.inc93:                                        ; preds = %for.body86
  %71 = load i32* %j, align 4
  %inc94 = add nsw i32 %71, 1
  store i32 %inc94, i32* %j, align 4
  %72 = load i32* %off, align 4
  %inc95 = add i32 %72, 1
  store i32 %inc95, i32* %off, align 4
  br label %for.cond83

for.end96:                                        ; preds = %for.cond83
  %73 = load i32* %bin, align 4
  %call97 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %mul98 = mul i64 %call97, 256
  %74 = load i32* %i, align 4
  %conv99 = zext i32 %74 to i64
  %add100 = add i64 %mul98, %conv99
  %75 = load i32 addrspace(1)** %Histogram.addr, align 8
  %arrayidx101 = getelementptr inbounds i32 addrspace(1)* %75, i64 %add100
  store i32 %73, i32 addrspace(1)* %arrayidx101, align 4
  br label %for.inc102

for.inc102:                                       ; preds = %for.end96
  %76 = load i32* %groupSize, align 4
  %77 = load i32* %i, align 4
  %add103 = add i32 %77, %76
  store i32 %add103, i32* %i, align 4
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
  %Image.addr = alloca i32 addrspace(1)*, align 8
  %Histogram.addr = alloca i32 addrspace(1)*, align 8
  %nVectorsPerThread.addr = alloca i32, align 4
  %tid = alloca i32, align 4
  %ltid = alloca i32, align 4
  %Stride = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %idx = alloca i32, align 4
  %temp = alloca i32, align 4
  %temp2 = alloca i32, align 4
  %shft = alloca i32, align 4
  %msk = alloca i32, align 4
  %offset = alloca i32, align 4
  %lmem_items = alloca i32, align 4
  %p = alloca i32 addrspace(3)*, align 8
  %bin = alloca i32, align 4
  %off = alloca i32, align 4
  %j44 = alloca i32, align 4
  store i32 addrspace(1)* %Image, i32 addrspace(1)** %Image.addr, align 8
  store i32 addrspace(1)* %Histogram, i32 addrspace(1)** %Histogram.addr, align 8
  store i32 %nVectorsPerThread, i32* %nVectorsPerThread.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  %call1 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %ltid, align 4
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %Stride, align 4
  %call5 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %groupSize, align 4
  store i32 8, i32* %shft, align 4
  store i32 255, i32* %msk, align 4
  %0 = load i32* %ltid, align 4
  %rem = urem i32 %0, 4
  store i32 %rem, i32* %offset, align 4
  store i32 1024, i32* %lmem_items, align 4
  store i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 addrspace(3)** %p, align 8
  %1 = load i32* %ltid, align 4
  store i32 %1, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32* %i, align 4
  %3 = load i32* %lmem_items, align 4
  %cmp = icmp ult i32 %2, %3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i32* %i, align 4
  %idxprom = zext i32 %4 to i64
  %5 = load i32 addrspace(3)** %p, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(3)* %5, i64 %idxprom
  store i32 0, i32 addrspace(3)* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32* %groupSize, align 4
  %7 = load i32* %i, align 4
  %add = add i32 %7, %6
  store i32 %add, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  store i32 0, i32* %i, align 4
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc38, %for.end
  %8 = load i32* %i, align 4
  %9 = load i32* %nVectorsPerThread.addr, align 4
  %cmp9 = icmp ult i32 %8, %9
  br i1 %cmp9, label %for.body11, label %for.end39

for.body11:                                       ; preds = %for.cond8
  %10 = load i32* %tid, align 4
  %11 = load i32* %i, align 4
  %12 = load i32* %Stride, align 4
  %mul = mul i32 %11, %12
  %add12 = add i32 %10, %mul
  %idxprom13 = zext i32 %add12 to i64
  %13 = load i32 addrspace(1)** %Image.addr, align 8
  %arrayidx14 = getelementptr inbounds i32 addrspace(1)* %13, i64 %idxprom13
  %14 = load i32 addrspace(1)* %arrayidx14, align 4
  store i32 %14, i32* %temp, align 4
  %15 = load i32* %temp, align 4
  %and = and i32 %15, 255
  %mul15 = mul i32 %and, 4
  %16 = load i32* %offset, align 4
  %add16 = add i32 %mul15, %16
  store i32 %add16, i32* %temp2, align 4
  %17 = load i32* %temp2, align 4
  %idx.ext = zext i32 %17 to i64
  %add.ptr = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i64 %idx.ext
  %call17 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr)
  %18 = load i32* %temp, align 4
  %shr = lshr i32 %18, 8
  store i32 %shr, i32* %temp, align 4
  %19 = load i32* %temp, align 4
  %and18 = and i32 %19, 255
  %mul19 = mul i32 %and18, 4
  %20 = load i32* %offset, align 4
  %add20 = add i32 %mul19, %20
  store i32 %add20, i32* %temp2, align 4
  %21 = load i32* %temp2, align 4
  %idx.ext21 = zext i32 %21 to i64
  %add.ptr22 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i64 %idx.ext21
  %call23 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr22)
  %22 = load i32* %temp, align 4
  %shr24 = lshr i32 %22, 8
  store i32 %shr24, i32* %temp, align 4
  %23 = load i32* %temp, align 4
  %and25 = and i32 %23, 255
  %mul26 = mul i32 %and25, 4
  %24 = load i32* %offset, align 4
  %add27 = add i32 %mul26, %24
  store i32 %add27, i32* %temp2, align 4
  %25 = load i32* %temp2, align 4
  %idx.ext28 = zext i32 %25 to i64
  %add.ptr29 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i64 %idx.ext28
  %call30 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr29)
  %26 = load i32* %temp, align 4
  %shr31 = lshr i32 %26, 8
  store i32 %shr31, i32* %temp, align 4
  %27 = load i32* %temp, align 4
  %and32 = and i32 %27, 255
  %mul33 = mul i32 %and32, 4
  %28 = load i32* %offset, align 4
  %add34 = add i32 %mul33, %28
  store i32 %add34, i32* %temp2, align 4
  %29 = load i32* %temp2, align 4
  %idx.ext35 = zext i32 %29 to i64
  %add.ptr36 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i64 %idx.ext35
  %call37 = call cc75 i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr36)
  br label %for.inc38

for.inc38:                                        ; preds = %for.body11
  %30 = load i32* %i, align 4
  %inc = add i32 %30, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond8

for.end39:                                        ; preds = %for.cond8
  call cc75 void @_Z7barrierj(i32 1)
  %31 = load i32* %ltid, align 4
  store i32 %31, i32* %i, align 4
  br label %for.cond40

for.cond40:                                       ; preds = %for.inc64, %for.end39
  %32 = load i32* %i, align 4
  %cmp41 = icmp ult i32 %32, 256
  br i1 %cmp41, label %for.body43, label %for.end66

for.body43:                                       ; preds = %for.cond40
  store i32 0, i32* %bin, align 4
  %33 = load i32* %offset, align 4
  store i32 %33, i32* %off, align 4
  store i32 0, i32* %j44, align 4
  br label %for.cond45

for.cond45:                                       ; preds = %for.inc55, %for.body43
  %34 = load i32* %j44, align 4
  %cmp46 = icmp slt i32 %34, 4
  br i1 %cmp46, label %for.body48, label %for.end58

for.body48:                                       ; preds = %for.cond45
  %35 = load i32* %i, align 4
  %mul49 = mul i32 %35, 4
  %36 = load i32* %off, align 4
  %rem50 = urem i32 %36, 4
  %add51 = add i32 %mul49, %rem50
  %idxprom52 = zext i32 %add51 to i64
  %arrayidx53 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i64 %idxprom52
  %37 = load i32 addrspace(3)* %arrayidx53, align 4
  %38 = load i32* %bin, align 4
  %add54 = add i32 %38, %37
  store i32 %add54, i32* %bin, align 4
  br label %for.inc55

for.inc55:                                        ; preds = %for.body48
  %39 = load i32* %j44, align 4
  %inc56 = add nsw i32 %39, 1
  store i32 %inc56, i32* %j44, align 4
  %40 = load i32* %off, align 4
  %inc57 = add i32 %40, 1
  store i32 %inc57, i32* %off, align 4
  br label %for.cond45

for.end58:                                        ; preds = %for.cond45
  %41 = load i32* %bin, align 4
  %call59 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %mul60 = mul i64 %call59, 256
  %42 = load i32* %i, align 4
  %conv61 = zext i32 %42 to i64
  %add62 = add i64 %mul60, %conv61
  %43 = load i32 addrspace(1)** %Histogram.addr, align 8
  %arrayidx63 = getelementptr inbounds i32 addrspace(1)* %43, i64 %add62
  store i32 %41, i32 addrspace(1)* %arrayidx63, align 4
  br label %for.inc64

for.inc64:                                        ; preds = %for.end58
  %44 = load i32* %groupSize, align 4
  %45 = load i32* %i, align 4
  %add65 = add i32 %45, %44
  store i32 %add65, i32* %i, align 4
  br label %for.cond40

for.end66:                                        ; preds = %for.cond40
  ret void
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_reduceKernel_kernel(i32 addrspace(1)* %Histogram, i32 %nSubHists) #0 {
entry:
  %Histogram.addr = alloca i32 addrspace(1)*, align 8
  %nSubHists.addr = alloca i32, align 4
  %tid = alloca i32, align 4
  %bin = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 addrspace(1)* %Histogram, i32 addrspace(1)** %Histogram.addr, align 8
  store i32 %nSubHists, i32* %nSubHists.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %tid, align 4
  store i32 0, i32* %bin, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %i, align 4
  %1 = load i32* %nSubHists.addr, align 4
  %cmp = icmp ult i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32* %i, align 4
  %mul = mul nsw i32 %2, 256
  %3 = load i32* %tid, align 4
  %add = add i32 %mul, %3
  %idxprom = zext i32 %add to i64
  %4 = load i32 addrspace(1)** %Histogram.addr, align 8
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %4, i64 %idxprom
  %5 = load i32 addrspace(1)* %arrayidx, align 4
  %6 = load i32* %i, align 4
  %mul2 = mul nsw i32 %6, 256
  %7 = load i32* %tid, align 4
  %add3 = add i32 %mul2, %7
  %add4 = add i32 %add3, 256
  %idxprom5 = zext i32 %add4 to i64
  %8 = load i32 addrspace(1)** %Histogram.addr, align 8
  %arrayidx6 = getelementptr inbounds i32 addrspace(1)* %8, i64 %idxprom5
  %9 = load i32 addrspace(1)* %arrayidx6, align 4
  %add7 = add i32 %5, %9
  %10 = load i32* %i, align 4
  %mul8 = mul nsw i32 %10, 256
  %11 = load i32* %tid, align 4
  %add9 = add i32 %mul8, %11
  %add10 = add i32 %add9, 512
  %idxprom11 = zext i32 %add10 to i64
  %12 = load i32 addrspace(1)** %Histogram.addr, align 8
  %arrayidx12 = getelementptr inbounds i32 addrspace(1)* %12, i64 %idxprom11
  %13 = load i32 addrspace(1)* %arrayidx12, align 4
  %add13 = add i32 %add7, %13
  %14 = load i32* %i, align 4
  %mul14 = mul nsw i32 %14, 256
  %15 = load i32* %tid, align 4
  %add15 = add i32 %mul14, %15
  %add16 = add i32 %add15, 768
  %idxprom17 = zext i32 %add16 to i64
  %16 = load i32 addrspace(1)** %Histogram.addr, align 8
  %arrayidx18 = getelementptr inbounds i32 addrspace(1)* %16, i64 %idxprom17
  %17 = load i32 addrspace(1)* %arrayidx18, align 4
  %add19 = add i32 %add13, %17
  %18 = load i32* %bin, align 4
  %add20 = add i32 %18, %add19
  store i32 %add20, i32* %bin, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %19 = load i32* %i, align 4
  %add21 = add nsw i32 %19, 4
  store i32 %add21, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %20 = load i32* %bin, align 4
  %21 = load i32* %tid, align 4
  %idxprom22 = zext i32 %21 to i64
  %22 = load i32 addrspace(1)** %Histogram.addr, align 8
  %arrayidx23 = getelementptr inbounds i32 addrspace(1)* %22, i64 %idxprom22
  store i32 %20, i32 addrspace(1)* %arrayidx23, align 4
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

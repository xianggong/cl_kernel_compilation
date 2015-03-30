; ModuleID = '../kernel-src/HistogramAtomics_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@histogramKernel_Vector.subhists = internal addrspace(3) global [4096 x i32] zeroinitializer, align 4
@histogramKernel_Scalar.subhists = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @histogramKernel_Vector(<4 x i32> addrspace(1)* nocapture readonly %Image, i32 addrspace(1)* nocapture %Histogram, i32 %n4VectorsPerThread) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 0) #2
  %call2 = tail call i32 @get_global_size(i32 0) #2
  %call3 = tail call i32 @get_local_size(i32 0) #2
  %rem = and i32 %call1, 15
  %cmp130 = icmp ult i32 %call1, 1024
  br i1 %cmp130, label %for.body, label %for.end

for.body:                                         ; preds = %entry, %for.body
  %i.0131 = phi i32 [ %add, %for.body ], [ %call1, %entry ]
  %arrayidx = getelementptr inbounds <4 x i32> addrspace(3)* bitcast ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists to <4 x i32> addrspace(3)*), i32 %i.0131
  store <4 x i32> zeroinitializer, <4 x i32> addrspace(3)* %arrayidx, align 16, !tbaa !4
  %add = add i32 %i.0131, %call3
  %cmp = icmp ult i32 %add, 1024
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  tail call void @barrier(i32 1) #2
  %cmp5128 = icmp eq i32 %n4VectorsPerThread, 0
  br i1 %cmp5128, label %for.end60, label %for.body6.lr.ph

for.body6.lr.ph:                                  ; preds = %for.end
  %splat.splatinsert = insertelement <4 x i32> undef, i32 %rem, i32 0
  %splat.splat = shufflevector <4 x i32> %splat.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  br label %for.body6

for.body6:                                        ; preds = %for.body6, %for.body6.lr.ph
  %i.1129 = phi i32 [ 0, %for.body6.lr.ph ], [ %inc, %for.body6 ]
  %mul = mul i32 %i.1129, %call2
  %add7 = add i32 %mul, %call
  %0 = sext i32 %add7 to i64
  %arrayidx8 = getelementptr inbounds <4 x i32> addrspace(1)* %Image, i64 %0
  %1 = load <4 x i32> addrspace(1)* %arrayidx8, align 16, !tbaa !4
  %and = and <4 x i32> %1, <i32 255, i32 255, i32 255, i32 255>
  %mul9 = shl <4 x i32> %and, <i32 4, i32 4, i32 4, i32 4>
  %add10 = add <4 x i32> %mul9, %splat.splat
  %2 = extractelement <4 x i32> %add10, i32 0
  %add.ptr = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %2
  %call11 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr) #2
  %3 = extractelement <4 x i32> %add10, i32 1
  %add.ptr12 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %3
  %call13 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr12) #2
  %4 = extractelement <4 x i32> %add10, i32 2
  %add.ptr14 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %4
  %call15 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr14) #2
  %5 = extractelement <4 x i32> %add10, i32 3
  %add.ptr16 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %5
  %call17 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr16) #2
  %shr = lshr <4 x i32> %1, <i32 8, i32 8, i32 8, i32 8>
  %and18 = and <4 x i32> %shr, <i32 255, i32 255, i32 255, i32 255>
  %mul19 = shl <4 x i32> %and18, <i32 4, i32 4, i32 4, i32 4>
  %add22 = add <4 x i32> %mul19, %splat.splat
  %6 = extractelement <4 x i32> %add22, i32 0
  %add.ptr23 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %6
  %call24 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr23) #2
  %7 = extractelement <4 x i32> %add22, i32 1
  %add.ptr25 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %7
  %call26 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr25) #2
  %8 = extractelement <4 x i32> %add22, i32 2
  %add.ptr27 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %8
  %call28 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr27) #2
  %9 = extractelement <4 x i32> %add22, i32 3
  %add.ptr29 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %9
  %call30 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr29) #2
  %shr31 = lshr <4 x i32> %shr, <i32 8, i32 8, i32 8, i32 8>
  %and32 = and <4 x i32> %shr31, <i32 255, i32 255, i32 255, i32 255>
  %mul33 = shl <4 x i32> %and32, <i32 4, i32 4, i32 4, i32 4>
  %add36 = add <4 x i32> %mul33, %splat.splat
  %10 = extractelement <4 x i32> %add36, i32 0
  %add.ptr37 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %10
  %call38 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr37) #2
  %11 = extractelement <4 x i32> %add36, i32 1
  %add.ptr39 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %11
  %call40 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr39) #2
  %12 = extractelement <4 x i32> %add36, i32 2
  %add.ptr41 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %12
  %call42 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr41) #2
  %13 = extractelement <4 x i32> %add36, i32 3
  %add.ptr43 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %13
  %call44 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr43) #2
  %shr45 = lshr <4 x i32> %shr31, <i32 8, i32 8, i32 8, i32 8>
  %and46 = and <4 x i32> %shr45, <i32 255, i32 255, i32 255, i32 255>
  %mul47 = shl <4 x i32> %and46, <i32 4, i32 4, i32 4, i32 4>
  %add50 = add <4 x i32> %mul47, %splat.splat
  %14 = extractelement <4 x i32> %add50, i32 0
  %add.ptr51 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %14
  %call52 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr51) #2
  %15 = extractelement <4 x i32> %add50, i32 1
  %add.ptr53 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %15
  %call54 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr53) #2
  %16 = extractelement <4 x i32> %add50, i32 2
  %add.ptr55 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %16
  %call56 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr55) #2
  %17 = extractelement <4 x i32> %add50, i32 3
  %add.ptr57 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %17
  %call58 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr57) #2
  %inc = add i32 %i.1129, 1
  %exitcond = icmp eq i32 %inc, %n4VectorsPerThread
  br i1 %exitcond, label %for.end60, label %for.body6

for.end60:                                        ; preds = %for.body6, %for.end
  tail call void @barrier(i32 1) #2
  %cmp62126 = icmp ult i32 %call1, 256
  br i1 %cmp62126, label %for.cond64.preheader, label %for.end82

for.cond64.preheader:                             ; preds = %for.end60, %for.cond64.preheader
  %i.2127 = phi i32 [ %add81, %for.cond64.preheader ], [ %call1, %for.end60 ]
  %mul67 = shl i32 %i.2127, 4
  %add69 = or i32 %rem, %mul67
  %arrayidx70 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69
  %18 = load i32 addrspace(3)* %arrayidx70, align 4, !tbaa !7
  %fold = add i32 %call1, 1
  %rem68.1 = and i32 %fold, 15
  %add69.1 = or i32 %rem68.1, %mul67
  %arrayidx70.1 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.1
  %19 = load i32 addrspace(3)* %arrayidx70.1, align 4, !tbaa !7
  %add71.1 = add i32 %19, %18
  %fold132 = add i32 %call1, 2
  %rem68.2 = and i32 %fold132, 15
  %add69.2 = or i32 %rem68.2, %mul67
  %arrayidx70.2 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.2
  %20 = load i32 addrspace(3)* %arrayidx70.2, align 4, !tbaa !7
  %add71.2 = add i32 %20, %add71.1
  %fold133 = add i32 %call1, 3
  %rem68.3 = and i32 %fold133, 15
  %add69.3 = or i32 %rem68.3, %mul67
  %arrayidx70.3 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.3
  %21 = load i32 addrspace(3)* %arrayidx70.3, align 4, !tbaa !7
  %add71.3 = add i32 %21, %add71.2
  %fold134 = add i32 %call1, 4
  %rem68.4 = and i32 %fold134, 15
  %add69.4 = or i32 %rem68.4, %mul67
  %arrayidx70.4 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.4
  %22 = load i32 addrspace(3)* %arrayidx70.4, align 4, !tbaa !7
  %add71.4 = add i32 %22, %add71.3
  %fold135 = add i32 %call1, 5
  %rem68.5 = and i32 %fold135, 15
  %add69.5 = or i32 %rem68.5, %mul67
  %arrayidx70.5 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.5
  %23 = load i32 addrspace(3)* %arrayidx70.5, align 4, !tbaa !7
  %add71.5 = add i32 %23, %add71.4
  %fold136 = add i32 %call1, 6
  %rem68.6 = and i32 %fold136, 15
  %add69.6 = or i32 %rem68.6, %mul67
  %arrayidx70.6 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.6
  %24 = load i32 addrspace(3)* %arrayidx70.6, align 4, !tbaa !7
  %add71.6 = add i32 %24, %add71.5
  %fold137 = add i32 %call1, 7
  %rem68.7 = and i32 %fold137, 15
  %add69.7 = or i32 %rem68.7, %mul67
  %arrayidx70.7 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.7
  %25 = load i32 addrspace(3)* %arrayidx70.7, align 4, !tbaa !7
  %add71.7 = add i32 %25, %add71.6
  %fold138 = add i32 %call1, 8
  %rem68.8 = and i32 %fold138, 15
  %add69.8 = or i32 %rem68.8, %mul67
  %arrayidx70.8 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.8
  %26 = load i32 addrspace(3)* %arrayidx70.8, align 4, !tbaa !7
  %add71.8 = add i32 %26, %add71.7
  %fold139 = add i32 %call1, 9
  %rem68.9 = and i32 %fold139, 15
  %add69.9 = or i32 %rem68.9, %mul67
  %arrayidx70.9 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.9
  %27 = load i32 addrspace(3)* %arrayidx70.9, align 4, !tbaa !7
  %add71.9 = add i32 %27, %add71.8
  %fold140 = add i32 %call1, 10
  %rem68.10 = and i32 %fold140, 15
  %add69.10 = or i32 %rem68.10, %mul67
  %arrayidx70.10 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.10
  %28 = load i32 addrspace(3)* %arrayidx70.10, align 4, !tbaa !7
  %add71.10 = add i32 %28, %add71.9
  %fold141 = add i32 %call1, 11
  %rem68.11 = and i32 %fold141, 15
  %add69.11 = or i32 %rem68.11, %mul67
  %arrayidx70.11 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.11
  %29 = load i32 addrspace(3)* %arrayidx70.11, align 4, !tbaa !7
  %add71.11 = add i32 %29, %add71.10
  %fold142 = add i32 %call1, 12
  %rem68.12 = and i32 %fold142, 15
  %add69.12 = or i32 %rem68.12, %mul67
  %arrayidx70.12 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.12
  %30 = load i32 addrspace(3)* %arrayidx70.12, align 4, !tbaa !7
  %add71.12 = add i32 %30, %add71.11
  %fold143 = add i32 %call1, 13
  %rem68.13 = and i32 %fold143, 15
  %add69.13 = or i32 %rem68.13, %mul67
  %arrayidx70.13 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.13
  %31 = load i32 addrspace(3)* %arrayidx70.13, align 4, !tbaa !7
  %add71.13 = add i32 %31, %add71.12
  %fold144 = add i32 %call1, 14
  %rem68.14 = and i32 %fold144, 15
  %add69.14 = or i32 %rem68.14, %mul67
  %arrayidx70.14 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.14
  %32 = load i32 addrspace(3)* %arrayidx70.14, align 4, !tbaa !7
  %add71.14 = add i32 %32, %add71.13
  %inc74.14 = add i32 %call1, 15
  %rem68.15 = and i32 %inc74.14, 15
  %add69.15 = or i32 %rem68.15, %mul67
  %arrayidx70.15 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %add69.15
  %33 = load i32 addrspace(3)* %arrayidx70.15, align 4, !tbaa !7
  %add71.15 = add i32 %33, %add71.14
  %call76 = tail call i32 @get_group_id(i32 0) #2
  %mul77 = shl i32 %call76, 8
  %add78 = add i32 %mul77, %i.2127
  %34 = sext i32 %add78 to i64
  %arrayidx79 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %34
  store i32 %add71.15, i32 addrspace(1)* %arrayidx79, align 4, !tbaa !7
  %add81 = add i32 %i.2127, %call3
  %cmp62 = icmp ult i32 %add81, 256
  br i1 %cmp62, label %for.cond64.preheader, label %for.end82

for.end82:                                        ; preds = %for.cond64.preheader, %for.end60
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

declare i32 @get_global_size(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)*) #1

declare i32 @get_group_id(i32) #1

; Function Attrs: nounwind
define void @histogramKernel_Scalar(i32 addrspace(1)* nocapture readonly %Image, i32 addrspace(1)* nocapture %Histogram, i32 %nVectorsPerThread) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_local_id(i32 0) #2
  %call2 = tail call i32 @get_global_size(i32 0) #2
  %call3 = tail call i32 @get_local_size(i32 0) #2
  %rem = and i32 %call1, 3
  %cmp89 = icmp ult i32 %call1, 1024
  br i1 %cmp89, label %for.body, label %for.end

for.body:                                         ; preds = %entry, %for.body
  %i.090 = phi i32 [ %add, %for.body ], [ %call1, %entry ]
  %arrayidx = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %i.090
  store i32 0, i32 addrspace(3)* %arrayidx, align 4, !tbaa !7
  %add = add i32 %i.090, %call3
  %cmp = icmp ult i32 %add, 1024
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  tail call void @barrier(i32 1) #2
  %cmp587 = icmp eq i32 %nVectorsPerThread, 0
  br i1 %cmp587, label %for.end30, label %for.body6

for.body6:                                        ; preds = %for.end, %for.body6
  %i.188 = phi i32 [ %inc, %for.body6 ], [ 0, %for.end ]
  %mul = mul i32 %i.188, %call2
  %add7 = add i32 %mul, %call
  %0 = sext i32 %add7 to i64
  %arrayidx8 = getelementptr inbounds i32 addrspace(1)* %Image, i64 %0
  %1 = load i32 addrspace(1)* %arrayidx8, align 4, !tbaa !7
  %and = shl i32 %1, 2
  %mul9 = and i32 %and, 1020
  %add10 = or i32 %mul9, %rem
  %add.ptr = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %add10
  %call11 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr) #2
  %2 = lshr i32 %1, 6
  %mul13 = and i32 %2, 1020
  %add14 = or i32 %mul13, %rem
  %add.ptr15 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %add14
  %call16 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr15) #2
  %3 = lshr i32 %1, 14
  %mul19 = and i32 %3, 1020
  %add20 = or i32 %mul19, %rem
  %add.ptr21 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %add20
  %call22 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr21) #2
  %shr23 = lshr i32 %1, 24
  %mul25 = shl nuw nsw i32 %shr23, 2
  %add26 = or i32 %mul25, %rem
  %add.ptr27 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %add26
  %call28 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %add.ptr27) #2
  %inc = add i32 %i.188, 1
  %exitcond = icmp eq i32 %inc, %nVectorsPerThread
  br i1 %exitcond, label %for.end30, label %for.body6

for.end30:                                        ; preds = %for.body6, %for.end
  tail call void @barrier(i32 1) #2
  %cmp3285 = icmp ult i32 %call1, 256
  br i1 %cmp3285, label %for.cond35.preheader, label %for.end53

for.cond35.preheader:                             ; preds = %for.end30, %for.cond35.preheader
  %i.286 = phi i32 [ %add52, %for.cond35.preheader ], [ %call1, %for.end30 ]
  %mul38 = shl i32 %i.286, 2
  %add40 = or i32 %rem, %mul38
  %arrayidx41 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %add40
  %4 = load i32 addrspace(3)* %arrayidx41, align 4, !tbaa !7
  %fold = add i32 %call1, 1
  %rem39.1 = and i32 %fold, 3
  %add40.1 = or i32 %rem39.1, %mul38
  %arrayidx41.1 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %add40.1
  %5 = load i32 addrspace(3)* %arrayidx41.1, align 4, !tbaa !7
  %add42.1 = add i32 %5, %4
  %fold91 = add i32 %call1, 2
  %rem39.2 = and i32 %fold91, 3
  %add40.2 = or i32 %rem39.2, %mul38
  %arrayidx41.2 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %add40.2
  %6 = load i32 addrspace(3)* %arrayidx41.2, align 4, !tbaa !7
  %add42.2 = add i32 %6, %add42.1
  %inc45.2 = add i32 %call1, 3
  %rem39.3 = and i32 %inc45.2, 3
  %add40.3 = or i32 %rem39.3, %mul38
  %arrayidx41.3 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %add40.3
  %7 = load i32 addrspace(3)* %arrayidx41.3, align 4, !tbaa !7
  %add42.3 = add i32 %7, %add42.2
  %call47 = tail call i32 @get_group_id(i32 0) #2
  %mul48 = shl i32 %call47, 8
  %add49 = add i32 %mul48, %i.286
  %8 = sext i32 %add49 to i64
  %arrayidx50 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %8
  store i32 %add42.3, i32 addrspace(1)* %arrayidx50, align 4, !tbaa !7
  %add52 = add i32 %i.286, %call3
  %cmp32 = icmp ult i32 %add52, 256
  br i1 %cmp32, label %for.cond35.preheader, label %for.end53

for.end53:                                        ; preds = %for.cond35.preheader, %for.end30
  ret void
}

; Function Attrs: nounwind
define void @reduceKernel(i32 addrspace(1)* nocapture %Histogram, i32 %nSubHists) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %cmp33 = icmp eq i32 %nSubHists, 0
  br i1 %cmp33, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %bin.034 = phi i32 [ %add16, %for.body ], [ 0, %entry ]
  %0 = trunc i64 %indvars.iv to i32
  %mul = shl nsw i32 %0, 8
  %add = add i32 %mul, %call
  %1 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %1
  %2 = load i32 addrspace(1)* %arrayidx, align 4, !tbaa !7
  %add3 = add i32 %add, 256
  %3 = sext i32 %add3 to i64
  %arrayidx4 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %3
  %4 = load i32 addrspace(1)* %arrayidx4, align 4, !tbaa !7
  %add8 = add i32 %add, 512
  %5 = sext i32 %add8 to i64
  %arrayidx9 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %5
  %6 = load i32 addrspace(1)* %arrayidx9, align 4, !tbaa !7
  %add13 = add i32 %add, 768
  %7 = sext i32 %add13 to i64
  %arrayidx14 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %7
  %8 = load i32 addrspace(1)* %arrayidx14, align 4, !tbaa !7
  %add5 = add i32 %2, %bin.034
  %add10 = add i32 %add5, %4
  %add15 = add i32 %add10, %6
  %add16 = add i32 %add15, %8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 4
  %9 = trunc i64 %indvars.iv.next to i32
  %cmp = icmp ult i32 %9, %nSubHists
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  %bin.0.lcssa = phi i32 [ 0, %entry ], [ %add16, %for.body ]
  %10 = sext i32 %call to i64
  %arrayidx18 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %10
  store i32 %bin.0.lcssa, i32 addrspace(1)* %arrayidx18, align 4, !tbaa !7
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32)* @histogramKernel_Vector}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @histogramKernel_Scalar}
!2 = metadata !{void (i32 addrspace(1)*, i32)* @reduceKernel}
!3 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"int", metadata !5, i64 0}

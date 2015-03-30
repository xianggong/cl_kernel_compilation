; ModuleID = '../kernel-src/MatrixMultiplication_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @mmmKernel(<4 x float> addrspace(1)* nocapture readonly %matrixA, <4 x float> addrspace(1)* nocapture readonly %matrixB, <4 x float> addrspace(1)* nocapture %matrixC, i32 %widthA, i32 %widthB) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %div = lshr i32 %widthB, 2
  %cmp348 = icmp eq i32 %widthA, 0
  %shl122.pre = shl i32 %call1, 2
  br i1 %cmp348, label %entry.for.end_crit_edge, label %for.body.lr.ph

entry.for.end_crit_edge:                          ; preds = %entry
  %add128339.pre = or i32 %shl122.pre, 1
  %add133340.pre = or i32 %shl122.pre, 2
  %add138341.pre = or i32 %shl122.pre, 3
  br label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %div4 = lshr i32 %widthA, 2
  %mul = mul i32 %shl122.pre, %div4
  %add7342 = or i32 %shl122.pre, 1
  %mul9 = mul i32 %add7342, %div4
  %add14343 = or i32 %shl122.pre, 2
  %mul16 = mul i32 %add14343, %div4
  %add21344 = or i32 %shl122.pre, 3
  %mul23 = mul i32 %add21344, %div4
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %sum0.0353 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %62, %for.body ]
  %sum1.0352 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %86, %for.body ]
  %sum2.0351 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %110, %for.body ]
  %sum3.0350 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %134, %for.body ]
  %0 = trunc i64 %indvars.iv to i32
  %div3 = sdiv i32 %0, 4
  %add = add i32 %div3, %mul
  %1 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i64 %1
  %2 = load <4 x float> addrspace(1)* %arrayidx, align 16, !tbaa !3
  %add10 = add i32 %div3, %mul9
  %3 = sext i32 %add10 to i64
  %arrayidx11 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i64 %3
  %4 = load <4 x float> addrspace(1)* %arrayidx11, align 16, !tbaa !3
  %add17 = add i32 %div3, %mul16
  %5 = sext i32 %add17 to i64
  %arrayidx18 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i64 %5
  %6 = load <4 x float> addrspace(1)* %arrayidx18, align 16, !tbaa !3
  %add24 = add i32 %div3, %mul23
  %7 = sext i32 %add24 to i64
  %arrayidx25 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i64 %7
  %8 = load <4 x float> addrspace(1)* %arrayidx25, align 16, !tbaa !3
  %mul26 = mul i32 %0, %div
  %add27 = add i32 %mul26, %call
  %9 = sext i32 %add27 to i64
  %arrayidx28 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i64 %9
  %10 = load <4 x float> addrspace(1)* %arrayidx28, align 16, !tbaa !3
  %11 = or i64 %indvars.iv, 1
  %12 = trunc i64 %11 to i32
  %mul30 = mul i32 %12, %div
  %add31 = add i32 %mul30, %call
  %13 = sext i32 %add31 to i64
  %arrayidx32 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i64 %13
  %14 = load <4 x float> addrspace(1)* %arrayidx32, align 16, !tbaa !3
  %15 = or i64 %indvars.iv, 2
  %16 = trunc i64 %15 to i32
  %mul34 = mul i32 %16, %div
  %add35 = add i32 %mul34, %call
  %17 = sext i32 %add35 to i64
  %arrayidx36 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i64 %17
  %18 = load <4 x float> addrspace(1)* %arrayidx36, align 16, !tbaa !3
  %19 = or i64 %indvars.iv, 3
  %20 = trunc i64 %19 to i32
  %mul38 = mul i32 %20, %div
  %add39 = add i32 %mul38, %call
  %21 = sext i32 %add39 to i64
  %arrayidx40 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i64 %21
  %22 = load <4 x float> addrspace(1)* %arrayidx40, align 16, !tbaa !3
  %23 = extractelement <4 x float> %2, i32 0
  %24 = extractelement <4 x float> %10, i32 0
  %25 = extractelement <4 x float> %2, i32 1
  %26 = extractelement <4 x float> %14, i32 0
  %mul42 = fmul float %25, %26
  %27 = tail call float @llvm.fmuladd.f32(float %23, float %24, float %mul42)
  %28 = extractelement <4 x float> %2, i32 2
  %29 = extractelement <4 x float> %18, i32 0
  %30 = tail call float @llvm.fmuladd.f32(float %28, float %29, float %27)
  %31 = extractelement <4 x float> %2, i32 3
  %32 = extractelement <4 x float> %22, i32 0
  %33 = tail call float @llvm.fmuladd.f32(float %31, float %32, float %30)
  %34 = extractelement <4 x float> %sum0.0353, i32 0
  %add45 = fadd float %34, %33
  %35 = insertelement <4 x float> undef, float %add45, i32 0
  %36 = extractelement <4 x float> %10, i32 1
  %37 = extractelement <4 x float> %14, i32 1
  %mul47 = fmul float %25, %37
  %38 = tail call float @llvm.fmuladd.f32(float %23, float %36, float %mul47)
  %39 = extractelement <4 x float> %18, i32 1
  %40 = tail call float @llvm.fmuladd.f32(float %28, float %39, float %38)
  %41 = extractelement <4 x float> %22, i32 1
  %42 = tail call float @llvm.fmuladd.f32(float %31, float %41, float %40)
  %43 = extractelement <4 x float> %sum0.0353, i32 1
  %add50 = fadd float %43, %42
  %44 = insertelement <4 x float> %35, float %add50, i32 1
  %45 = extractelement <4 x float> %10, i32 2
  %46 = extractelement <4 x float> %14, i32 2
  %mul52 = fmul float %25, %46
  %47 = tail call float @llvm.fmuladd.f32(float %23, float %45, float %mul52)
  %48 = extractelement <4 x float> %18, i32 2
  %49 = tail call float @llvm.fmuladd.f32(float %28, float %48, float %47)
  %50 = extractelement <4 x float> %22, i32 2
  %51 = tail call float @llvm.fmuladd.f32(float %31, float %50, float %49)
  %52 = extractelement <4 x float> %sum0.0353, i32 2
  %add55 = fadd float %52, %51
  %53 = insertelement <4 x float> %44, float %add55, i32 2
  %54 = extractelement <4 x float> %10, i32 3
  %55 = extractelement <4 x float> %14, i32 3
  %mul57 = fmul float %25, %55
  %56 = tail call float @llvm.fmuladd.f32(float %23, float %54, float %mul57)
  %57 = extractelement <4 x float> %18, i32 3
  %58 = tail call float @llvm.fmuladd.f32(float %28, float %57, float %56)
  %59 = extractelement <4 x float> %22, i32 3
  %60 = tail call float @llvm.fmuladd.f32(float %31, float %59, float %58)
  %61 = extractelement <4 x float> %sum0.0353, i32 3
  %add60 = fadd float %61, %60
  %62 = insertelement <4 x float> %53, float %add60, i32 3
  %63 = extractelement <4 x float> %4, i32 0
  %64 = extractelement <4 x float> %4, i32 1
  %mul62 = fmul float %64, %26
  %65 = tail call float @llvm.fmuladd.f32(float %63, float %24, float %mul62)
  %66 = extractelement <4 x float> %4, i32 2
  %67 = tail call float @llvm.fmuladd.f32(float %66, float %29, float %65)
  %68 = extractelement <4 x float> %4, i32 3
  %69 = tail call float @llvm.fmuladd.f32(float %68, float %32, float %67)
  %70 = extractelement <4 x float> %sum1.0352, i32 0
  %add65 = fadd float %70, %69
  %71 = insertelement <4 x float> undef, float %add65, i32 0
  %mul67 = fmul float %64, %37
  %72 = tail call float @llvm.fmuladd.f32(float %63, float %36, float %mul67)
  %73 = tail call float @llvm.fmuladd.f32(float %66, float %39, float %72)
  %74 = tail call float @llvm.fmuladd.f32(float %68, float %41, float %73)
  %75 = extractelement <4 x float> %sum1.0352, i32 1
  %add70 = fadd float %75, %74
  %76 = insertelement <4 x float> %71, float %add70, i32 1
  %mul72 = fmul float %64, %46
  %77 = tail call float @llvm.fmuladd.f32(float %63, float %45, float %mul72)
  %78 = tail call float @llvm.fmuladd.f32(float %66, float %48, float %77)
  %79 = tail call float @llvm.fmuladd.f32(float %68, float %50, float %78)
  %80 = extractelement <4 x float> %sum1.0352, i32 2
  %add75 = fadd float %80, %79
  %81 = insertelement <4 x float> %76, float %add75, i32 2
  %mul77 = fmul float %64, %55
  %82 = tail call float @llvm.fmuladd.f32(float %63, float %54, float %mul77)
  %83 = tail call float @llvm.fmuladd.f32(float %66, float %57, float %82)
  %84 = tail call float @llvm.fmuladd.f32(float %68, float %59, float %83)
  %85 = extractelement <4 x float> %sum1.0352, i32 3
  %add80 = fadd float %85, %84
  %86 = insertelement <4 x float> %81, float %add80, i32 3
  %87 = extractelement <4 x float> %6, i32 0
  %88 = extractelement <4 x float> %6, i32 1
  %mul82 = fmul float %88, %26
  %89 = tail call float @llvm.fmuladd.f32(float %87, float %24, float %mul82)
  %90 = extractelement <4 x float> %6, i32 2
  %91 = tail call float @llvm.fmuladd.f32(float %90, float %29, float %89)
  %92 = extractelement <4 x float> %6, i32 3
  %93 = tail call float @llvm.fmuladd.f32(float %92, float %32, float %91)
  %94 = extractelement <4 x float> %sum2.0351, i32 0
  %add85 = fadd float %94, %93
  %95 = insertelement <4 x float> undef, float %add85, i32 0
  %mul87 = fmul float %88, %37
  %96 = tail call float @llvm.fmuladd.f32(float %87, float %36, float %mul87)
  %97 = tail call float @llvm.fmuladd.f32(float %90, float %39, float %96)
  %98 = tail call float @llvm.fmuladd.f32(float %92, float %41, float %97)
  %99 = extractelement <4 x float> %sum2.0351, i32 1
  %add90 = fadd float %99, %98
  %100 = insertelement <4 x float> %95, float %add90, i32 1
  %mul92 = fmul float %88, %46
  %101 = tail call float @llvm.fmuladd.f32(float %87, float %45, float %mul92)
  %102 = tail call float @llvm.fmuladd.f32(float %90, float %48, float %101)
  %103 = tail call float @llvm.fmuladd.f32(float %92, float %50, float %102)
  %104 = extractelement <4 x float> %sum2.0351, i32 2
  %add95 = fadd float %104, %103
  %105 = insertelement <4 x float> %100, float %add95, i32 2
  %mul97 = fmul float %88, %55
  %106 = tail call float @llvm.fmuladd.f32(float %87, float %54, float %mul97)
  %107 = tail call float @llvm.fmuladd.f32(float %90, float %57, float %106)
  %108 = tail call float @llvm.fmuladd.f32(float %92, float %59, float %107)
  %109 = extractelement <4 x float> %sum2.0351, i32 3
  %add100 = fadd float %109, %108
  %110 = insertelement <4 x float> %105, float %add100, i32 3
  %111 = extractelement <4 x float> %8, i32 0
  %112 = extractelement <4 x float> %8, i32 1
  %mul102 = fmul float %112, %26
  %113 = tail call float @llvm.fmuladd.f32(float %111, float %24, float %mul102)
  %114 = extractelement <4 x float> %8, i32 2
  %115 = tail call float @llvm.fmuladd.f32(float %114, float %29, float %113)
  %116 = extractelement <4 x float> %8, i32 3
  %117 = tail call float @llvm.fmuladd.f32(float %116, float %32, float %115)
  %118 = extractelement <4 x float> %sum3.0350, i32 0
  %add105 = fadd float %118, %117
  %119 = insertelement <4 x float> undef, float %add105, i32 0
  %mul107 = fmul float %112, %37
  %120 = tail call float @llvm.fmuladd.f32(float %111, float %36, float %mul107)
  %121 = tail call float @llvm.fmuladd.f32(float %114, float %39, float %120)
  %122 = tail call float @llvm.fmuladd.f32(float %116, float %41, float %121)
  %123 = extractelement <4 x float> %sum3.0350, i32 1
  %add110 = fadd float %123, %122
  %124 = insertelement <4 x float> %119, float %add110, i32 1
  %mul112 = fmul float %112, %46
  %125 = tail call float @llvm.fmuladd.f32(float %111, float %45, float %mul112)
  %126 = tail call float @llvm.fmuladd.f32(float %114, float %48, float %125)
  %127 = tail call float @llvm.fmuladd.f32(float %116, float %50, float %126)
  %128 = extractelement <4 x float> %sum3.0350, i32 2
  %add115 = fadd float %128, %127
  %129 = insertelement <4 x float> %124, float %add115, i32 2
  %mul117 = fmul float %112, %55
  %130 = tail call float @llvm.fmuladd.f32(float %111, float %54, float %mul117)
  %131 = tail call float @llvm.fmuladd.f32(float %114, float %57, float %130)
  %132 = tail call float @llvm.fmuladd.f32(float %116, float %59, float %131)
  %133 = extractelement <4 x float> %sum3.0350, i32 3
  %add120 = fadd float %133, %132
  %134 = insertelement <4 x float> %129, float %add120, i32 3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 4
  %135 = trunc i64 %indvars.iv.next to i32
  %cmp = icmp ult i32 %135, %widthA
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry.for.end_crit_edge
  %add138341.pre-phi = phi i32 [ %add138341.pre, %entry.for.end_crit_edge ], [ %add21344, %for.body ]
  %add133340.pre-phi = phi i32 [ %add133340.pre, %entry.for.end_crit_edge ], [ %add14343, %for.body ]
  %add128339.pre-phi = phi i32 [ %add128339.pre, %entry.for.end_crit_edge ], [ %add7342, %for.body ]
  %sum0.0.lcssa = phi <4 x float> [ zeroinitializer, %entry.for.end_crit_edge ], [ %62, %for.body ]
  %sum1.0.lcssa = phi <4 x float> [ zeroinitializer, %entry.for.end_crit_edge ], [ %86, %for.body ]
  %sum2.0.lcssa = phi <4 x float> [ zeroinitializer, %entry.for.end_crit_edge ], [ %110, %for.body ]
  %sum3.0.lcssa = phi <4 x float> [ zeroinitializer, %entry.for.end_crit_edge ], [ %134, %for.body ]
  %mul124 = mul i32 %shl122.pre, %div
  %add125 = add i32 %mul124, %call
  %136 = sext i32 %add125 to i64
  %arrayidx126 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i64 %136
  store <4 x float> %sum0.0.lcssa, <4 x float> addrspace(1)* %arrayidx126, align 16, !tbaa !3
  %mul129 = mul i32 %add128339.pre-phi, %div
  %add130 = add i32 %mul129, %call
  %137 = sext i32 %add130 to i64
  %arrayidx131 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i64 %137
  store <4 x float> %sum1.0.lcssa, <4 x float> addrspace(1)* %arrayidx131, align 16, !tbaa !3
  %mul134 = mul i32 %add133340.pre-phi, %div
  %add135 = add i32 %mul134, %call
  %138 = sext i32 %add135 to i64
  %arrayidx136 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i64 %138
  store <4 x float> %sum2.0.lcssa, <4 x float> addrspace(1)* %arrayidx136, align 16, !tbaa !3
  %mul139 = mul i32 %add138341.pre-phi, %div
  %add140 = add i32 %mul139, %call
  %139 = sext i32 %add140 to i64
  %arrayidx141 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i64 %139
  store <4 x float> %sum3.0.lcssa, <4 x float> addrspace(1)* %arrayidx141, align 16, !tbaa !3
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind
define void @mmmKernel_local(<4 x float> addrspace(1)* nocapture readonly %matrixA, <4 x float> addrspace(1)* nocapture readonly %matrixB, <4 x float> addrspace(1)* nocapture %matrixC, i32 %widthA, <4 x float> addrspace(3)* nocapture %blockA) #0 {
entry:
  %call = tail call i32 @get_local_id(i32 0) #3
  %call1 = tail call i32 @get_local_size(i32 0) #3
  %call2 = tail call i32 @get_local_id(i32 1) #3
  %shl = shl i32 %call1, 2
  %mul = mul i32 %shl, %call2
  %add = add i32 %mul, %call
  %call3 = tail call i32 @get_global_id(i32 0) #3
  %call4 = tail call i32 @get_global_id(i32 1) #3
  %shl5 = shl i32 %call4, 2
  %call6 = tail call i32 @get_global_size(i32 0) #3
  %mul7 = mul i32 %shl5, %call6
  %add8 = add i32 %mul7, %call3
  %div = sdiv i32 %widthA, 4
  %call9408 = tail call i32 @get_local_size(i32 0) #3
  %div10409 = udiv i32 %div, %call9408
  %cmp410 = icmp eq i32 %div10409, 0
  br i1 %cmp410, label %for.end182, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %shl16 = shl i32 %div, 2
  %arrayidx19 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %add
  %mul25 = shl i32 %div, 1
  %mul32 = mul nsw i32 %div, 3
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.end
  %sum0.0415 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %sum0.1.lcssa, %for.end ]
  %sum1.0414 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %sum1.1.lcssa, %for.end ]
  %sum2.0413 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %sum2.1.lcssa, %for.end ]
  %sum3.0412 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %sum3.1.lcssa, %for.end ]
  %i.0411 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.end ]
  %call11 = tail call i32 @get_local_size(i32 0) #3
  %mul12 = mul i32 %call11, %i.0411
  %call13 = tail call i32 @get_local_id(i32 0) #3
  %add14 = add i32 %mul12, %call13
  %call15 = tail call i32 @get_global_id(i32 1) #3
  %mul17 = mul i32 %shl16, %call15
  %add18 = add i32 %add14, %mul17
  %0 = sext i32 %add18 to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i64 %0
  %1 = load <4 x float> addrspace(1)* %arrayidx, align 16, !tbaa !3
  store <4 x float> %1, <4 x float> addrspace(3)* %arrayidx19, align 16, !tbaa !3
  %add20 = add nsw i32 %add18, %div
  %2 = sext i32 %add20 to i64
  %arrayidx21 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i64 %2
  %3 = load <4 x float> addrspace(1)* %arrayidx21, align 16, !tbaa !3
  %call22 = tail call i32 @get_local_size(i32 0) #3
  %add23 = add i32 %call22, %add
  %arrayidx24 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %add23
  store <4 x float> %3, <4 x float> addrspace(3)* %arrayidx24, align 16, !tbaa !3
  %add26 = add nsw i32 %add18, %mul25
  %4 = sext i32 %add26 to i64
  %arrayidx27 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i64 %4
  %5 = load <4 x float> addrspace(1)* %arrayidx27, align 16, !tbaa !3
  %call28 = tail call i32 @get_local_size(i32 0) #3
  %mul29 = shl i32 %call28, 1
  %add30 = add i32 %mul29, %add
  %arrayidx31 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %add30
  store <4 x float> %5, <4 x float> addrspace(3)* %arrayidx31, align 16, !tbaa !3
  %add33 = add nsw i32 %add18, %mul32
  %6 = sext i32 %add33 to i64
  %arrayidx34 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i64 %6
  %7 = load <4 x float> addrspace(1)* %arrayidx34, align 16, !tbaa !3
  %call35 = tail call i32 @get_local_size(i32 0) #3
  %mul36 = mul i32 %call35, 3
  %add37 = add i32 %mul36, %add
  %arrayidx38 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %add37
  store <4 x float> %7, <4 x float> addrspace(3)* %arrayidx38, align 16, !tbaa !3
  tail call void @barrier(i32 1) #3
  %call39 = tail call i32 @get_global_id(i32 0) #3
  %call40 = tail call i32 @get_local_size(i32 0) #3
  %call43 = tail call i32 @get_global_size(i32 0) #3
  %mul41 = shl i32 %i.0411, 2
  %shl42 = mul i32 %mul41, %call40
  %mul44 = mul i32 %shl42, %call43
  %add45 = add i32 %mul44, %call39
  %call47397 = tail call i32 @get_local_size(i32 0) #3
  %mul48398.mask = and i32 %call47397, 1073741823
  %cmp49399 = icmp eq i32 %mul48398.mask, 0
  br i1 %cmp49399, label %for.end, label %for.body50

for.body50:                                       ; preds = %for.body, %for.body50
  %sum0.1404 = phi <4 x float> [ %59, %for.body50 ], [ %sum0.0415, %for.body ]
  %sum1.1403 = phi <4 x float> [ %83, %for.body50 ], [ %sum1.0414, %for.body ]
  %sum2.1402 = phi <4 x float> [ %107, %for.body50 ], [ %sum2.0413, %for.body ]
  %sum3.1401 = phi <4 x float> [ %131, %for.body50 ], [ %sum3.0412, %for.body ]
  %j.0400 = phi i32 [ %add180, %for.body50 ], [ 0, %for.body ]
  %shr = ashr exact i32 %j.0400, 2
  %call51 = tail call i32 @get_local_id(i32 1) #3
  %mul52 = shl i32 %call51, 2
  %call53 = tail call i32 @get_local_size(i32 0) #3
  %mul54 = mul i32 %mul52, %call53
  %add55 = add i32 %mul54, %shr
  %arrayidx56 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %add55
  %8 = load <4 x float> addrspace(3)* %arrayidx56, align 16, !tbaa !3
  %call58 = tail call i32 @get_local_id(i32 1) #3
  %mul59 = shl i32 %call58, 2
  %add60391 = or i32 %mul59, 1
  %call61 = tail call i32 @get_local_size(i32 0) #3
  %mul62 = mul i32 %add60391, %call61
  %add63 = add i32 %mul62, %shr
  %arrayidx64 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %add63
  %9 = load <4 x float> addrspace(3)* %arrayidx64, align 16, !tbaa !3
  %call66 = tail call i32 @get_local_id(i32 1) #3
  %mul67 = shl i32 %call66, 2
  %add68392 = or i32 %mul67, 2
  %call69 = tail call i32 @get_local_size(i32 0) #3
  %mul70 = mul i32 %add68392, %call69
  %add71 = add i32 %mul70, %shr
  %arrayidx72 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %add71
  %10 = load <4 x float> addrspace(3)* %arrayidx72, align 16, !tbaa !3
  %call74 = tail call i32 @get_local_id(i32 1) #3
  %mul75 = shl i32 %call74, 2
  %add76393 = or i32 %mul75, 3
  %call77 = tail call i32 @get_local_size(i32 0) #3
  %mul78 = mul i32 %add76393, %call77
  %add79 = add i32 %mul78, %shr
  %arrayidx80 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %add79
  %11 = load <4 x float> addrspace(3)* %arrayidx80, align 16, !tbaa !3
  %call81 = tail call i32 @get_global_size(i32 0) #3
  %mul82 = mul i32 %call81, %j.0400
  %add83 = add i32 %mul82, %add45
  %12 = sext i32 %add83 to i64
  %arrayidx84 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i64 %12
  %13 = load <4 x float> addrspace(1)* %arrayidx84, align 16, !tbaa !3
  %add85394 = or i32 %j.0400, 1
  %call86 = tail call i32 @get_global_size(i32 0) #3
  %mul87 = mul i32 %call86, %add85394
  %add88 = add i32 %mul87, %add45
  %14 = sext i32 %add88 to i64
  %arrayidx89 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i64 %14
  %15 = load <4 x float> addrspace(1)* %arrayidx89, align 16, !tbaa !3
  %add90395 = or i32 %j.0400, 2
  %call91 = tail call i32 @get_global_size(i32 0) #3
  %mul92 = mul i32 %call91, %add90395
  %add93 = add i32 %mul92, %add45
  %16 = sext i32 %add93 to i64
  %arrayidx94 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i64 %16
  %17 = load <4 x float> addrspace(1)* %arrayidx94, align 16, !tbaa !3
  %add95396 = or i32 %j.0400, 3
  %call96 = tail call i32 @get_global_size(i32 0) #3
  %mul97 = mul i32 %call96, %add95396
  %add98 = add i32 %mul97, %add45
  %18 = sext i32 %add98 to i64
  %arrayidx99 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i64 %18
  %19 = load <4 x float> addrspace(1)* %arrayidx99, align 16, !tbaa !3
  %20 = extractelement <4 x float> %8, i32 0
  %21 = extractelement <4 x float> %13, i32 0
  %22 = extractelement <4 x float> %8, i32 1
  %23 = extractelement <4 x float> %15, i32 0
  %mul101 = fmul float %22, %23
  %24 = tail call float @llvm.fmuladd.f32(float %20, float %21, float %mul101)
  %25 = extractelement <4 x float> %8, i32 2
  %26 = extractelement <4 x float> %17, i32 0
  %27 = tail call float @llvm.fmuladd.f32(float %25, float %26, float %24)
  %28 = extractelement <4 x float> %8, i32 3
  %29 = extractelement <4 x float> %19, i32 0
  %30 = tail call float @llvm.fmuladd.f32(float %28, float %29, float %27)
  %31 = extractelement <4 x float> %sum0.1404, i32 0
  %add104 = fadd float %31, %30
  %32 = insertelement <4 x float> undef, float %add104, i32 0
  %33 = extractelement <4 x float> %13, i32 1
  %34 = extractelement <4 x float> %15, i32 1
  %mul106 = fmul float %22, %34
  %35 = tail call float @llvm.fmuladd.f32(float %20, float %33, float %mul106)
  %36 = extractelement <4 x float> %17, i32 1
  %37 = tail call float @llvm.fmuladd.f32(float %25, float %36, float %35)
  %38 = extractelement <4 x float> %19, i32 1
  %39 = tail call float @llvm.fmuladd.f32(float %28, float %38, float %37)
  %40 = extractelement <4 x float> %sum0.1404, i32 1
  %add109 = fadd float %40, %39
  %41 = insertelement <4 x float> %32, float %add109, i32 1
  %42 = extractelement <4 x float> %13, i32 2
  %43 = extractelement <4 x float> %15, i32 2
  %mul111 = fmul float %22, %43
  %44 = tail call float @llvm.fmuladd.f32(float %20, float %42, float %mul111)
  %45 = extractelement <4 x float> %17, i32 2
  %46 = tail call float @llvm.fmuladd.f32(float %25, float %45, float %44)
  %47 = extractelement <4 x float> %19, i32 2
  %48 = tail call float @llvm.fmuladd.f32(float %28, float %47, float %46)
  %49 = extractelement <4 x float> %sum0.1404, i32 2
  %add114 = fadd float %49, %48
  %50 = insertelement <4 x float> %41, float %add114, i32 2
  %51 = extractelement <4 x float> %13, i32 3
  %52 = extractelement <4 x float> %15, i32 3
  %mul116 = fmul float %22, %52
  %53 = tail call float @llvm.fmuladd.f32(float %20, float %51, float %mul116)
  %54 = extractelement <4 x float> %17, i32 3
  %55 = tail call float @llvm.fmuladd.f32(float %25, float %54, float %53)
  %56 = extractelement <4 x float> %19, i32 3
  %57 = tail call float @llvm.fmuladd.f32(float %28, float %56, float %55)
  %58 = extractelement <4 x float> %sum0.1404, i32 3
  %add119 = fadd float %58, %57
  %59 = insertelement <4 x float> %50, float %add119, i32 3
  %60 = extractelement <4 x float> %9, i32 0
  %61 = extractelement <4 x float> %9, i32 1
  %mul121 = fmul float %61, %23
  %62 = tail call float @llvm.fmuladd.f32(float %60, float %21, float %mul121)
  %63 = extractelement <4 x float> %9, i32 2
  %64 = tail call float @llvm.fmuladd.f32(float %63, float %26, float %62)
  %65 = extractelement <4 x float> %9, i32 3
  %66 = tail call float @llvm.fmuladd.f32(float %65, float %29, float %64)
  %67 = extractelement <4 x float> %sum1.1403, i32 0
  %add124 = fadd float %67, %66
  %68 = insertelement <4 x float> undef, float %add124, i32 0
  %mul126 = fmul float %61, %34
  %69 = tail call float @llvm.fmuladd.f32(float %60, float %33, float %mul126)
  %70 = tail call float @llvm.fmuladd.f32(float %63, float %36, float %69)
  %71 = tail call float @llvm.fmuladd.f32(float %65, float %38, float %70)
  %72 = extractelement <4 x float> %sum1.1403, i32 1
  %add129 = fadd float %72, %71
  %73 = insertelement <4 x float> %68, float %add129, i32 1
  %mul131 = fmul float %61, %43
  %74 = tail call float @llvm.fmuladd.f32(float %60, float %42, float %mul131)
  %75 = tail call float @llvm.fmuladd.f32(float %63, float %45, float %74)
  %76 = tail call float @llvm.fmuladd.f32(float %65, float %47, float %75)
  %77 = extractelement <4 x float> %sum1.1403, i32 2
  %add134 = fadd float %77, %76
  %78 = insertelement <4 x float> %73, float %add134, i32 2
  %mul136 = fmul float %61, %52
  %79 = tail call float @llvm.fmuladd.f32(float %60, float %51, float %mul136)
  %80 = tail call float @llvm.fmuladd.f32(float %63, float %54, float %79)
  %81 = tail call float @llvm.fmuladd.f32(float %65, float %56, float %80)
  %82 = extractelement <4 x float> %sum1.1403, i32 3
  %add139 = fadd float %82, %81
  %83 = insertelement <4 x float> %78, float %add139, i32 3
  %84 = extractelement <4 x float> %10, i32 0
  %85 = extractelement <4 x float> %10, i32 1
  %mul141 = fmul float %85, %23
  %86 = tail call float @llvm.fmuladd.f32(float %84, float %21, float %mul141)
  %87 = extractelement <4 x float> %10, i32 2
  %88 = tail call float @llvm.fmuladd.f32(float %87, float %26, float %86)
  %89 = extractelement <4 x float> %10, i32 3
  %90 = tail call float @llvm.fmuladd.f32(float %89, float %29, float %88)
  %91 = extractelement <4 x float> %sum2.1402, i32 0
  %add144 = fadd float %91, %90
  %92 = insertelement <4 x float> undef, float %add144, i32 0
  %mul146 = fmul float %85, %34
  %93 = tail call float @llvm.fmuladd.f32(float %84, float %33, float %mul146)
  %94 = tail call float @llvm.fmuladd.f32(float %87, float %36, float %93)
  %95 = tail call float @llvm.fmuladd.f32(float %89, float %38, float %94)
  %96 = extractelement <4 x float> %sum2.1402, i32 1
  %add149 = fadd float %96, %95
  %97 = insertelement <4 x float> %92, float %add149, i32 1
  %mul151 = fmul float %85, %43
  %98 = tail call float @llvm.fmuladd.f32(float %84, float %42, float %mul151)
  %99 = tail call float @llvm.fmuladd.f32(float %87, float %45, float %98)
  %100 = tail call float @llvm.fmuladd.f32(float %89, float %47, float %99)
  %101 = extractelement <4 x float> %sum2.1402, i32 2
  %add154 = fadd float %101, %100
  %102 = insertelement <4 x float> %97, float %add154, i32 2
  %mul156 = fmul float %85, %52
  %103 = tail call float @llvm.fmuladd.f32(float %84, float %51, float %mul156)
  %104 = tail call float @llvm.fmuladd.f32(float %87, float %54, float %103)
  %105 = tail call float @llvm.fmuladd.f32(float %89, float %56, float %104)
  %106 = extractelement <4 x float> %sum2.1402, i32 3
  %add159 = fadd float %106, %105
  %107 = insertelement <4 x float> %102, float %add159, i32 3
  %108 = extractelement <4 x float> %11, i32 0
  %109 = extractelement <4 x float> %11, i32 1
  %mul161 = fmul float %109, %23
  %110 = tail call float @llvm.fmuladd.f32(float %108, float %21, float %mul161)
  %111 = extractelement <4 x float> %11, i32 2
  %112 = tail call float @llvm.fmuladd.f32(float %111, float %26, float %110)
  %113 = extractelement <4 x float> %11, i32 3
  %114 = tail call float @llvm.fmuladd.f32(float %113, float %29, float %112)
  %115 = extractelement <4 x float> %sum3.1401, i32 0
  %add164 = fadd float %115, %114
  %116 = insertelement <4 x float> undef, float %add164, i32 0
  %mul166 = fmul float %109, %34
  %117 = tail call float @llvm.fmuladd.f32(float %108, float %33, float %mul166)
  %118 = tail call float @llvm.fmuladd.f32(float %111, float %36, float %117)
  %119 = tail call float @llvm.fmuladd.f32(float %113, float %38, float %118)
  %120 = extractelement <4 x float> %sum3.1401, i32 1
  %add169 = fadd float %120, %119
  %121 = insertelement <4 x float> %116, float %add169, i32 1
  %mul171 = fmul float %109, %43
  %122 = tail call float @llvm.fmuladd.f32(float %108, float %42, float %mul171)
  %123 = tail call float @llvm.fmuladd.f32(float %111, float %45, float %122)
  %124 = tail call float @llvm.fmuladd.f32(float %113, float %47, float %123)
  %125 = extractelement <4 x float> %sum3.1401, i32 2
  %add174 = fadd float %125, %124
  %126 = insertelement <4 x float> %121, float %add174, i32 2
  %mul176 = fmul float %109, %52
  %127 = tail call float @llvm.fmuladd.f32(float %108, float %51, float %mul176)
  %128 = tail call float @llvm.fmuladd.f32(float %111, float %54, float %127)
  %129 = tail call float @llvm.fmuladd.f32(float %113, float %56, float %128)
  %130 = extractelement <4 x float> %sum3.1401, i32 3
  %add179 = fadd float %130, %129
  %131 = insertelement <4 x float> %126, float %add179, i32 3
  %add180 = add nsw i32 %j.0400, 4
  %call47 = tail call i32 @get_local_size(i32 0) #3
  %mul48 = shl i32 %call47, 2
  %cmp49 = icmp ult i32 %add180, %mul48
  br i1 %cmp49, label %for.body50, label %for.end

for.end:                                          ; preds = %for.body50, %for.body
  %sum0.1.lcssa = phi <4 x float> [ %sum0.0415, %for.body ], [ %59, %for.body50 ]
  %sum1.1.lcssa = phi <4 x float> [ %sum1.0414, %for.body ], [ %83, %for.body50 ]
  %sum2.1.lcssa = phi <4 x float> [ %sum2.0413, %for.body ], [ %107, %for.body50 ]
  %sum3.1.lcssa = phi <4 x float> [ %sum3.0412, %for.body ], [ %131, %for.body50 ]
  tail call void @barrier(i32 1) #3
  %inc = add nsw i32 %i.0411, 1
  %call9 = tail call i32 @get_local_size(i32 0) #3
  %div10 = udiv i32 %div, %call9
  %cmp = icmp ult i32 %inc, %div10
  br i1 %cmp, label %for.body, label %for.end182

for.end182:                                       ; preds = %for.end, %entry
  %sum0.0.lcssa = phi <4 x float> [ zeroinitializer, %entry ], [ %sum0.1.lcssa, %for.end ]
  %sum1.0.lcssa = phi <4 x float> [ zeroinitializer, %entry ], [ %sum1.1.lcssa, %for.end ]
  %sum2.0.lcssa = phi <4 x float> [ zeroinitializer, %entry ], [ %sum2.1.lcssa, %for.end ]
  %sum3.0.lcssa = phi <4 x float> [ zeroinitializer, %entry ], [ %sum3.1.lcssa, %for.end ]
  %132 = sext i32 %add8 to i64
  %arrayidx183 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i64 %132
  store <4 x float> %sum0.0.lcssa, <4 x float> addrspace(1)* %arrayidx183, align 16, !tbaa !3
  %call184 = tail call i32 @get_global_size(i32 0) #3
  %add185 = add i32 %call184, %add8
  %133 = sext i32 %add185 to i64
  %arrayidx186 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i64 %133
  store <4 x float> %sum1.0.lcssa, <4 x float> addrspace(1)* %arrayidx186, align 16, !tbaa !3
  %call187 = tail call i32 @get_global_size(i32 0) #3
  %mul188 = shl i32 %call187, 1
  %add189 = add i32 %mul188, %add8
  %134 = sext i32 %add189 to i64
  %arrayidx190 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i64 %134
  store <4 x float> %sum2.0.lcssa, <4 x float> addrspace(1)* %arrayidx190, align 16, !tbaa !3
  %call191 = tail call i32 @get_global_size(i32 0) #3
  %mul192 = mul i32 %call191, 3
  %add193 = add i32 %mul192, %add8
  %135 = sext i32 %add193 to i64
  %arrayidx194 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i64 %135
  store <4 x float> %sum3.0.lcssa, <4 x float> addrspace(1)* %arrayidx194, align 16, !tbaa !3
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_local_size(i32) #1

declare i32 @get_global_size(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, i32)* @mmmKernel}
!1 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, <4 x float> addrspace(3)*)* @mmmKernel_local}
!2 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}

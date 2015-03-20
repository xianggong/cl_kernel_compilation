; ModuleID = '../kernel-src/MatrixMultiplication_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @mmmKernel(<4 x float> addrspace(1)* nocapture readonly %matrixA, <4 x float> addrspace(1)* nocapture readonly %matrixB, <4 x float> addrspace(1)* nocapture %matrixC, i32 %widthA, i32 %widthB) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = lshr i32 %widthB, 2
  %4 = icmp eq i32 %widthA, 0
  %.pre = shl i32 %2, 2
  br i1 %4, label %._crit_edge12, label %.lr.ph

._crit_edge12:                                    ; preds = %0
  %.pre13 = or i32 %.pre, 1
  %.pre15 = or i32 %.pre, 2
  %.pre17 = or i32 %.pre, 3
  br label %._crit_edge

.lr.ph:                                           ; preds = %0
  %5 = lshr i32 %widthA, 2
  %6 = mul i32 %.pre, %5
  %7 = or i32 %.pre, 1
  %8 = mul i32 %7, %5
  %9 = or i32 %.pre, 2
  %10 = mul i32 %9, %5
  %11 = or i32 %.pre, 3
  %12 = mul i32 %11, %5
  br label %13

; <label>:13                                      ; preds = %.lr.ph, %13
  %sum0.05 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %93, %13 ]
  %sum1.04 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %125, %13 ]
  %sum2.03 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %157, %13 ]
  %sum3.02 = phi <4 x float> [ zeroinitializer, %.lr.ph ], [ %189, %13 ]
  %i.01 = phi i32 [ 0, %.lr.ph ], [ %190, %13 ]
  %14 = sdiv i32 %i.01, 4
  %15 = add i32 %14, %6
  %16 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %15
  %17 = load <4 x float> addrspace(1)* %16, align 16, !tbaa !11
  %18 = add i32 %14, %8
  %19 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %18
  %20 = load <4 x float> addrspace(1)* %19, align 16, !tbaa !11
  %21 = add i32 %14, %10
  %22 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %21
  %23 = load <4 x float> addrspace(1)* %22, align 16, !tbaa !11
  %24 = add i32 %14, %12
  %25 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %24
  %26 = load <4 x float> addrspace(1)* %25, align 16, !tbaa !11
  %27 = mul i32 %i.01, %3
  %28 = add i32 %27, %1
  %29 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %28
  %30 = load <4 x float> addrspace(1)* %29, align 16, !tbaa !11
  %31 = or i32 %i.01, 1
  %32 = mul i32 %31, %3
  %33 = add i32 %32, %1
  %34 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %33
  %35 = load <4 x float> addrspace(1)* %34, align 16, !tbaa !11
  %36 = or i32 %i.01, 2
  %37 = mul i32 %36, %3
  %38 = add i32 %37, %1
  %39 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %38
  %40 = load <4 x float> addrspace(1)* %39, align 16, !tbaa !11
  %41 = or i32 %i.01, 3
  %42 = mul i32 %41, %3
  %43 = add i32 %42, %1
  %44 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %43
  %45 = load <4 x float> addrspace(1)* %44, align 16, !tbaa !11
  %46 = extractelement <4 x float> %17, i32 0
  %47 = extractelement <4 x float> %30, i32 0
  %48 = extractelement <4 x float> %17, i32 1
  %49 = extractelement <4 x float> %35, i32 0
  %50 = fmul float %48, %49
  %51 = tail call float @llvm.fmuladd.f32(float %46, float %47, float %50)
  %52 = extractelement <4 x float> %17, i32 2
  %53 = extractelement <4 x float> %40, i32 0
  %54 = tail call float @llvm.fmuladd.f32(float %52, float %53, float %51)
  %55 = extractelement <4 x float> %17, i32 3
  %56 = extractelement <4 x float> %45, i32 0
  %57 = tail call float @llvm.fmuladd.f32(float %55, float %56, float %54)
  %58 = extractelement <4 x float> %sum0.05, i32 0
  %59 = fadd float %58, %57
  %60 = insertelement <4 x float> undef, float %59, i32 0
  %61 = extractelement <4 x float> %30, i32 1
  %62 = extractelement <4 x float> %35, i32 1
  %63 = fmul float %48, %62
  %64 = tail call float @llvm.fmuladd.f32(float %46, float %61, float %63)
  %65 = extractelement <4 x float> %40, i32 1
  %66 = tail call float @llvm.fmuladd.f32(float %52, float %65, float %64)
  %67 = extractelement <4 x float> %45, i32 1
  %68 = tail call float @llvm.fmuladd.f32(float %55, float %67, float %66)
  %69 = extractelement <4 x float> %sum0.05, i32 1
  %70 = fadd float %69, %68
  %71 = insertelement <4 x float> %60, float %70, i32 1
  %72 = extractelement <4 x float> %30, i32 2
  %73 = extractelement <4 x float> %35, i32 2
  %74 = fmul float %48, %73
  %75 = tail call float @llvm.fmuladd.f32(float %46, float %72, float %74)
  %76 = extractelement <4 x float> %40, i32 2
  %77 = tail call float @llvm.fmuladd.f32(float %52, float %76, float %75)
  %78 = extractelement <4 x float> %45, i32 2
  %79 = tail call float @llvm.fmuladd.f32(float %55, float %78, float %77)
  %80 = extractelement <4 x float> %sum0.05, i32 2
  %81 = fadd float %80, %79
  %82 = insertelement <4 x float> %71, float %81, i32 2
  %83 = extractelement <4 x float> %30, i32 3
  %84 = extractelement <4 x float> %35, i32 3
  %85 = fmul float %48, %84
  %86 = tail call float @llvm.fmuladd.f32(float %46, float %83, float %85)
  %87 = extractelement <4 x float> %40, i32 3
  %88 = tail call float @llvm.fmuladd.f32(float %52, float %87, float %86)
  %89 = extractelement <4 x float> %45, i32 3
  %90 = tail call float @llvm.fmuladd.f32(float %55, float %89, float %88)
  %91 = extractelement <4 x float> %sum0.05, i32 3
  %92 = fadd float %91, %90
  %93 = insertelement <4 x float> %82, float %92, i32 3
  %94 = extractelement <4 x float> %20, i32 0
  %95 = extractelement <4 x float> %20, i32 1
  %96 = fmul float %95, %49
  %97 = tail call float @llvm.fmuladd.f32(float %94, float %47, float %96)
  %98 = extractelement <4 x float> %20, i32 2
  %99 = tail call float @llvm.fmuladd.f32(float %98, float %53, float %97)
  %100 = extractelement <4 x float> %20, i32 3
  %101 = tail call float @llvm.fmuladd.f32(float %100, float %56, float %99)
  %102 = extractelement <4 x float> %sum1.04, i32 0
  %103 = fadd float %102, %101
  %104 = insertelement <4 x float> undef, float %103, i32 0
  %105 = fmul float %95, %62
  %106 = tail call float @llvm.fmuladd.f32(float %94, float %61, float %105)
  %107 = tail call float @llvm.fmuladd.f32(float %98, float %65, float %106)
  %108 = tail call float @llvm.fmuladd.f32(float %100, float %67, float %107)
  %109 = extractelement <4 x float> %sum1.04, i32 1
  %110 = fadd float %109, %108
  %111 = insertelement <4 x float> %104, float %110, i32 1
  %112 = fmul float %95, %73
  %113 = tail call float @llvm.fmuladd.f32(float %94, float %72, float %112)
  %114 = tail call float @llvm.fmuladd.f32(float %98, float %76, float %113)
  %115 = tail call float @llvm.fmuladd.f32(float %100, float %78, float %114)
  %116 = extractelement <4 x float> %sum1.04, i32 2
  %117 = fadd float %116, %115
  %118 = insertelement <4 x float> %111, float %117, i32 2
  %119 = fmul float %95, %84
  %120 = tail call float @llvm.fmuladd.f32(float %94, float %83, float %119)
  %121 = tail call float @llvm.fmuladd.f32(float %98, float %87, float %120)
  %122 = tail call float @llvm.fmuladd.f32(float %100, float %89, float %121)
  %123 = extractelement <4 x float> %sum1.04, i32 3
  %124 = fadd float %123, %122
  %125 = insertelement <4 x float> %118, float %124, i32 3
  %126 = extractelement <4 x float> %23, i32 0
  %127 = extractelement <4 x float> %23, i32 1
  %128 = fmul float %127, %49
  %129 = tail call float @llvm.fmuladd.f32(float %126, float %47, float %128)
  %130 = extractelement <4 x float> %23, i32 2
  %131 = tail call float @llvm.fmuladd.f32(float %130, float %53, float %129)
  %132 = extractelement <4 x float> %23, i32 3
  %133 = tail call float @llvm.fmuladd.f32(float %132, float %56, float %131)
  %134 = extractelement <4 x float> %sum2.03, i32 0
  %135 = fadd float %134, %133
  %136 = insertelement <4 x float> undef, float %135, i32 0
  %137 = fmul float %127, %62
  %138 = tail call float @llvm.fmuladd.f32(float %126, float %61, float %137)
  %139 = tail call float @llvm.fmuladd.f32(float %130, float %65, float %138)
  %140 = tail call float @llvm.fmuladd.f32(float %132, float %67, float %139)
  %141 = extractelement <4 x float> %sum2.03, i32 1
  %142 = fadd float %141, %140
  %143 = insertelement <4 x float> %136, float %142, i32 1
  %144 = fmul float %127, %73
  %145 = tail call float @llvm.fmuladd.f32(float %126, float %72, float %144)
  %146 = tail call float @llvm.fmuladd.f32(float %130, float %76, float %145)
  %147 = tail call float @llvm.fmuladd.f32(float %132, float %78, float %146)
  %148 = extractelement <4 x float> %sum2.03, i32 2
  %149 = fadd float %148, %147
  %150 = insertelement <4 x float> %143, float %149, i32 2
  %151 = fmul float %127, %84
  %152 = tail call float @llvm.fmuladd.f32(float %126, float %83, float %151)
  %153 = tail call float @llvm.fmuladd.f32(float %130, float %87, float %152)
  %154 = tail call float @llvm.fmuladd.f32(float %132, float %89, float %153)
  %155 = extractelement <4 x float> %sum2.03, i32 3
  %156 = fadd float %155, %154
  %157 = insertelement <4 x float> %150, float %156, i32 3
  %158 = extractelement <4 x float> %26, i32 0
  %159 = extractelement <4 x float> %26, i32 1
  %160 = fmul float %159, %49
  %161 = tail call float @llvm.fmuladd.f32(float %158, float %47, float %160)
  %162 = extractelement <4 x float> %26, i32 2
  %163 = tail call float @llvm.fmuladd.f32(float %162, float %53, float %161)
  %164 = extractelement <4 x float> %26, i32 3
  %165 = tail call float @llvm.fmuladd.f32(float %164, float %56, float %163)
  %166 = extractelement <4 x float> %sum3.02, i32 0
  %167 = fadd float %166, %165
  %168 = insertelement <4 x float> undef, float %167, i32 0
  %169 = fmul float %159, %62
  %170 = tail call float @llvm.fmuladd.f32(float %158, float %61, float %169)
  %171 = tail call float @llvm.fmuladd.f32(float %162, float %65, float %170)
  %172 = tail call float @llvm.fmuladd.f32(float %164, float %67, float %171)
  %173 = extractelement <4 x float> %sum3.02, i32 1
  %174 = fadd float %173, %172
  %175 = insertelement <4 x float> %168, float %174, i32 1
  %176 = fmul float %159, %73
  %177 = tail call float @llvm.fmuladd.f32(float %158, float %72, float %176)
  %178 = tail call float @llvm.fmuladd.f32(float %162, float %76, float %177)
  %179 = tail call float @llvm.fmuladd.f32(float %164, float %78, float %178)
  %180 = extractelement <4 x float> %sum3.02, i32 2
  %181 = fadd float %180, %179
  %182 = insertelement <4 x float> %175, float %181, i32 2
  %183 = fmul float %159, %84
  %184 = tail call float @llvm.fmuladd.f32(float %158, float %83, float %183)
  %185 = tail call float @llvm.fmuladd.f32(float %162, float %87, float %184)
  %186 = tail call float @llvm.fmuladd.f32(float %164, float %89, float %185)
  %187 = extractelement <4 x float> %sum3.02, i32 3
  %188 = fadd float %187, %186
  %189 = insertelement <4 x float> %182, float %188, i32 3
  %190 = add nuw nsw i32 %i.01, 4
  %191 = icmp ult i32 %190, %widthA
  br i1 %191, label %13, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %13
  %.lcssa24 = phi <4 x float> [ %189, %13 ]
  %.lcssa23 = phi <4 x float> [ %157, %13 ]
  %.lcssa22 = phi <4 x float> [ %125, %13 ]
  %.lcssa = phi <4 x float> [ %93, %13 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %._crit_edge12
  %.pre-phi18 = phi i32 [ %.pre17, %._crit_edge12 ], [ %11, %._crit_edge.loopexit ]
  %.pre-phi16 = phi i32 [ %.pre15, %._crit_edge12 ], [ %9, %._crit_edge.loopexit ]
  %.pre-phi14 = phi i32 [ %.pre13, %._crit_edge12 ], [ %7, %._crit_edge.loopexit ]
  %sum0.0.lcssa = phi <4 x float> [ zeroinitializer, %._crit_edge12 ], [ %.lcssa, %._crit_edge.loopexit ]
  %sum1.0.lcssa = phi <4 x float> [ zeroinitializer, %._crit_edge12 ], [ %.lcssa22, %._crit_edge.loopexit ]
  %sum2.0.lcssa = phi <4 x float> [ zeroinitializer, %._crit_edge12 ], [ %.lcssa23, %._crit_edge.loopexit ]
  %sum3.0.lcssa = phi <4 x float> [ zeroinitializer, %._crit_edge12 ], [ %.lcssa24, %._crit_edge.loopexit ]
  %192 = mul i32 %.pre, %3
  %193 = add i32 %192, %1
  %194 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %193
  store <4 x float> %sum0.0.lcssa, <4 x float> addrspace(1)* %194, align 16, !tbaa !11
  %195 = mul i32 %.pre-phi14, %3
  %196 = add i32 %195, %1
  %197 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %196
  store <4 x float> %sum1.0.lcssa, <4 x float> addrspace(1)* %197, align 16, !tbaa !11
  %198 = mul i32 %.pre-phi16, %3
  %199 = add i32 %198, %1
  %200 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %199
  store <4 x float> %sum2.0.lcssa, <4 x float> addrspace(1)* %200, align 16, !tbaa !11
  %201 = mul i32 %.pre-phi18, %3
  %202 = add i32 %201, %1
  %203 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %202
  store <4 x float> %sum3.0.lcssa, <4 x float> addrspace(1)* %203, align 16, !tbaa !11
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind
define void @mmmKernel_local(<4 x float> addrspace(1)* nocapture readonly %matrixA, <4 x float> addrspace(1)* nocapture readonly %matrixB, <4 x float> addrspace(1)* nocapture %matrixC, i32 %widthA, <4 x float> addrspace(3)* nocapture %blockA) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #3
  %2 = tail call i32 @get_local_size(i32 0) #3
  %3 = tail call i32 @get_local_id(i32 1) #3
  %4 = shl i32 %2, 2
  %5 = mul i32 %4, %3
  %6 = add i32 %5, %1
  %7 = tail call i32 @get_global_id(i32 0) #3
  %8 = tail call i32 @get_global_id(i32 1) #3
  %9 = shl i32 %8, 2
  %10 = tail call i32 @get_global_size(i32 0) #3
  %11 = mul i32 %9, %10
  %12 = add i32 %11, %7
  %13 = sdiv i32 %widthA, 4
  %14 = tail call i32 @get_local_size(i32 0) #3
  %15 = udiv i32 %13, %14
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %._crit_edge16, label %.lr.ph15

.lr.ph15:                                         ; preds = %0
  %17 = shl i32 %13, 2
  %18 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %6
  %19 = shl i32 %13, 1
  %20 = mul nsw i32 %13, 3
  br label %21

; <label>:21                                      ; preds = %.lr.ph15, %._crit_edge
  %sum0.013 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %sum0.1.lcssa, %._crit_edge ]
  %sum1.012 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %sum1.1.lcssa, %._crit_edge ]
  %sum2.011 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %sum2.1.lcssa, %._crit_edge ]
  %sum3.010 = phi <4 x float> [ zeroinitializer, %.lr.ph15 ], [ %sum3.1.lcssa, %._crit_edge ]
  %i.09 = phi i32 [ 0, %.lr.ph15 ], [ %263, %._crit_edge ]
  %22 = tail call i32 @get_local_size(i32 0) #3
  %23 = mul i32 %22, %i.09
  %24 = tail call i32 @get_local_id(i32 0) #3
  %25 = add i32 %23, %24
  %26 = tail call i32 @get_global_id(i32 1) #3
  %27 = mul i32 %17, %26
  %28 = add i32 %25, %27
  %29 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %28
  %30 = load <4 x float> addrspace(1)* %29, align 16, !tbaa !11
  store <4 x float> %30, <4 x float> addrspace(3)* %18, align 16, !tbaa !11
  %31 = add nsw i32 %28, %13
  %32 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %31
  %33 = load <4 x float> addrspace(1)* %32, align 16, !tbaa !11
  %34 = tail call i32 @get_local_size(i32 0) #3
  %35 = add i32 %34, %6
  %36 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %35
  store <4 x float> %33, <4 x float> addrspace(3)* %36, align 16, !tbaa !11
  %37 = add nsw i32 %28, %19
  %38 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %37
  %39 = load <4 x float> addrspace(1)* %38, align 16, !tbaa !11
  %40 = tail call i32 @get_local_size(i32 0) #3
  %41 = shl i32 %40, 1
  %42 = add i32 %41, %6
  %43 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %42
  store <4 x float> %39, <4 x float> addrspace(3)* %43, align 16, !tbaa !11
  %44 = add nsw i32 %28, %20
  %45 = getelementptr inbounds <4 x float> addrspace(1)* %matrixA, i32 %44
  %46 = load <4 x float> addrspace(1)* %45, align 16, !tbaa !11
  %47 = tail call i32 @get_local_size(i32 0) #3
  %48 = mul i32 %47, 3
  %49 = add i32 %48, %6
  %50 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %49
  store <4 x float> %46, <4 x float> addrspace(3)* %50, align 16, !tbaa !11
  tail call void @barrier(i32 1) #3
  %51 = tail call i32 @get_global_id(i32 0) #3
  %52 = tail call i32 @get_local_size(i32 0) #3
  %53 = tail call i32 @get_global_size(i32 0) #3
  %54 = shl i32 %i.09, 2
  %55 = mul i32 %54, %52
  %56 = mul i32 %55, %53
  %57 = add i32 %56, %51
  %58 = tail call i32 @get_local_size(i32 0) #3
  %.mask = and i32 %58, 1073741823
  %59 = icmp eq i32 %.mask, 0
  br i1 %59, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %21
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %sum0.15 = phi <4 x float> [ %162, %.lr.ph ], [ %sum0.013, %.lr.ph.preheader ]
  %sum1.14 = phi <4 x float> [ %194, %.lr.ph ], [ %sum1.012, %.lr.ph.preheader ]
  %sum2.13 = phi <4 x float> [ %226, %.lr.ph ], [ %sum2.011, %.lr.ph.preheader ]
  %sum3.12 = phi <4 x float> [ %258, %.lr.ph ], [ %sum3.010, %.lr.ph.preheader ]
  %j.01 = phi i32 [ %259, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %60 = ashr exact i32 %j.01, 2
  %61 = tail call i32 @get_local_id(i32 1) #3
  %62 = shl i32 %61, 2
  %63 = tail call i32 @get_local_size(i32 0) #3
  %64 = mul i32 %62, %63
  %65 = add i32 %64, %60
  %66 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %65
  %67 = load <4 x float> addrspace(3)* %66, align 16, !tbaa !11
  %68 = tail call i32 @get_local_id(i32 1) #3
  %69 = shl i32 %68, 2
  %70 = or i32 %69, 1
  %71 = tail call i32 @get_local_size(i32 0) #3
  %72 = mul i32 %70, %71
  %73 = add i32 %72, %60
  %74 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %73
  %75 = load <4 x float> addrspace(3)* %74, align 16, !tbaa !11
  %76 = tail call i32 @get_local_id(i32 1) #3
  %77 = shl i32 %76, 2
  %78 = or i32 %77, 2
  %79 = tail call i32 @get_local_size(i32 0) #3
  %80 = mul i32 %78, %79
  %81 = add i32 %80, %60
  %82 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %81
  %83 = load <4 x float> addrspace(3)* %82, align 16, !tbaa !11
  %84 = tail call i32 @get_local_id(i32 1) #3
  %85 = shl i32 %84, 2
  %86 = or i32 %85, 3
  %87 = tail call i32 @get_local_size(i32 0) #3
  %88 = mul i32 %86, %87
  %89 = add i32 %88, %60
  %90 = getelementptr inbounds <4 x float> addrspace(3)* %blockA, i32 %89
  %91 = load <4 x float> addrspace(3)* %90, align 16, !tbaa !11
  %92 = tail call i32 @get_global_size(i32 0) #3
  %93 = mul i32 %92, %j.01
  %94 = add i32 %93, %57
  %95 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %94
  %96 = load <4 x float> addrspace(1)* %95, align 16, !tbaa !11
  %97 = or i32 %j.01, 1
  %98 = tail call i32 @get_global_size(i32 0) #3
  %99 = mul i32 %98, %97
  %100 = add i32 %99, %57
  %101 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %100
  %102 = load <4 x float> addrspace(1)* %101, align 16, !tbaa !11
  %103 = or i32 %j.01, 2
  %104 = tail call i32 @get_global_size(i32 0) #3
  %105 = mul i32 %104, %103
  %106 = add i32 %105, %57
  %107 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %106
  %108 = load <4 x float> addrspace(1)* %107, align 16, !tbaa !11
  %109 = or i32 %j.01, 3
  %110 = tail call i32 @get_global_size(i32 0) #3
  %111 = mul i32 %110, %109
  %112 = add i32 %111, %57
  %113 = getelementptr inbounds <4 x float> addrspace(1)* %matrixB, i32 %112
  %114 = load <4 x float> addrspace(1)* %113, align 16, !tbaa !11
  %115 = extractelement <4 x float> %67, i32 0
  %116 = extractelement <4 x float> %96, i32 0
  %117 = extractelement <4 x float> %67, i32 1
  %118 = extractelement <4 x float> %102, i32 0
  %119 = fmul float %117, %118
  %120 = tail call float @llvm.fmuladd.f32(float %115, float %116, float %119)
  %121 = extractelement <4 x float> %67, i32 2
  %122 = extractelement <4 x float> %108, i32 0
  %123 = tail call float @llvm.fmuladd.f32(float %121, float %122, float %120)
  %124 = extractelement <4 x float> %67, i32 3
  %125 = extractelement <4 x float> %114, i32 0
  %126 = tail call float @llvm.fmuladd.f32(float %124, float %125, float %123)
  %127 = extractelement <4 x float> %sum0.15, i32 0
  %128 = fadd float %127, %126
  %129 = insertelement <4 x float> undef, float %128, i32 0
  %130 = extractelement <4 x float> %96, i32 1
  %131 = extractelement <4 x float> %102, i32 1
  %132 = fmul float %117, %131
  %133 = tail call float @llvm.fmuladd.f32(float %115, float %130, float %132)
  %134 = extractelement <4 x float> %108, i32 1
  %135 = tail call float @llvm.fmuladd.f32(float %121, float %134, float %133)
  %136 = extractelement <4 x float> %114, i32 1
  %137 = tail call float @llvm.fmuladd.f32(float %124, float %136, float %135)
  %138 = extractelement <4 x float> %sum0.15, i32 1
  %139 = fadd float %138, %137
  %140 = insertelement <4 x float> %129, float %139, i32 1
  %141 = extractelement <4 x float> %96, i32 2
  %142 = extractelement <4 x float> %102, i32 2
  %143 = fmul float %117, %142
  %144 = tail call float @llvm.fmuladd.f32(float %115, float %141, float %143)
  %145 = extractelement <4 x float> %108, i32 2
  %146 = tail call float @llvm.fmuladd.f32(float %121, float %145, float %144)
  %147 = extractelement <4 x float> %114, i32 2
  %148 = tail call float @llvm.fmuladd.f32(float %124, float %147, float %146)
  %149 = extractelement <4 x float> %sum0.15, i32 2
  %150 = fadd float %149, %148
  %151 = insertelement <4 x float> %140, float %150, i32 2
  %152 = extractelement <4 x float> %96, i32 3
  %153 = extractelement <4 x float> %102, i32 3
  %154 = fmul float %117, %153
  %155 = tail call float @llvm.fmuladd.f32(float %115, float %152, float %154)
  %156 = extractelement <4 x float> %108, i32 3
  %157 = tail call float @llvm.fmuladd.f32(float %121, float %156, float %155)
  %158 = extractelement <4 x float> %114, i32 3
  %159 = tail call float @llvm.fmuladd.f32(float %124, float %158, float %157)
  %160 = extractelement <4 x float> %sum0.15, i32 3
  %161 = fadd float %160, %159
  %162 = insertelement <4 x float> %151, float %161, i32 3
  %163 = extractelement <4 x float> %75, i32 0
  %164 = extractelement <4 x float> %75, i32 1
  %165 = fmul float %164, %118
  %166 = tail call float @llvm.fmuladd.f32(float %163, float %116, float %165)
  %167 = extractelement <4 x float> %75, i32 2
  %168 = tail call float @llvm.fmuladd.f32(float %167, float %122, float %166)
  %169 = extractelement <4 x float> %75, i32 3
  %170 = tail call float @llvm.fmuladd.f32(float %169, float %125, float %168)
  %171 = extractelement <4 x float> %sum1.14, i32 0
  %172 = fadd float %171, %170
  %173 = insertelement <4 x float> undef, float %172, i32 0
  %174 = fmul float %164, %131
  %175 = tail call float @llvm.fmuladd.f32(float %163, float %130, float %174)
  %176 = tail call float @llvm.fmuladd.f32(float %167, float %134, float %175)
  %177 = tail call float @llvm.fmuladd.f32(float %169, float %136, float %176)
  %178 = extractelement <4 x float> %sum1.14, i32 1
  %179 = fadd float %178, %177
  %180 = insertelement <4 x float> %173, float %179, i32 1
  %181 = fmul float %164, %142
  %182 = tail call float @llvm.fmuladd.f32(float %163, float %141, float %181)
  %183 = tail call float @llvm.fmuladd.f32(float %167, float %145, float %182)
  %184 = tail call float @llvm.fmuladd.f32(float %169, float %147, float %183)
  %185 = extractelement <4 x float> %sum1.14, i32 2
  %186 = fadd float %185, %184
  %187 = insertelement <4 x float> %180, float %186, i32 2
  %188 = fmul float %164, %153
  %189 = tail call float @llvm.fmuladd.f32(float %163, float %152, float %188)
  %190 = tail call float @llvm.fmuladd.f32(float %167, float %156, float %189)
  %191 = tail call float @llvm.fmuladd.f32(float %169, float %158, float %190)
  %192 = extractelement <4 x float> %sum1.14, i32 3
  %193 = fadd float %192, %191
  %194 = insertelement <4 x float> %187, float %193, i32 3
  %195 = extractelement <4 x float> %83, i32 0
  %196 = extractelement <4 x float> %83, i32 1
  %197 = fmul float %196, %118
  %198 = tail call float @llvm.fmuladd.f32(float %195, float %116, float %197)
  %199 = extractelement <4 x float> %83, i32 2
  %200 = tail call float @llvm.fmuladd.f32(float %199, float %122, float %198)
  %201 = extractelement <4 x float> %83, i32 3
  %202 = tail call float @llvm.fmuladd.f32(float %201, float %125, float %200)
  %203 = extractelement <4 x float> %sum2.13, i32 0
  %204 = fadd float %203, %202
  %205 = insertelement <4 x float> undef, float %204, i32 0
  %206 = fmul float %196, %131
  %207 = tail call float @llvm.fmuladd.f32(float %195, float %130, float %206)
  %208 = tail call float @llvm.fmuladd.f32(float %199, float %134, float %207)
  %209 = tail call float @llvm.fmuladd.f32(float %201, float %136, float %208)
  %210 = extractelement <4 x float> %sum2.13, i32 1
  %211 = fadd float %210, %209
  %212 = insertelement <4 x float> %205, float %211, i32 1
  %213 = fmul float %196, %142
  %214 = tail call float @llvm.fmuladd.f32(float %195, float %141, float %213)
  %215 = tail call float @llvm.fmuladd.f32(float %199, float %145, float %214)
  %216 = tail call float @llvm.fmuladd.f32(float %201, float %147, float %215)
  %217 = extractelement <4 x float> %sum2.13, i32 2
  %218 = fadd float %217, %216
  %219 = insertelement <4 x float> %212, float %218, i32 2
  %220 = fmul float %196, %153
  %221 = tail call float @llvm.fmuladd.f32(float %195, float %152, float %220)
  %222 = tail call float @llvm.fmuladd.f32(float %199, float %156, float %221)
  %223 = tail call float @llvm.fmuladd.f32(float %201, float %158, float %222)
  %224 = extractelement <4 x float> %sum2.13, i32 3
  %225 = fadd float %224, %223
  %226 = insertelement <4 x float> %219, float %225, i32 3
  %227 = extractelement <4 x float> %91, i32 0
  %228 = extractelement <4 x float> %91, i32 1
  %229 = fmul float %228, %118
  %230 = tail call float @llvm.fmuladd.f32(float %227, float %116, float %229)
  %231 = extractelement <4 x float> %91, i32 2
  %232 = tail call float @llvm.fmuladd.f32(float %231, float %122, float %230)
  %233 = extractelement <4 x float> %91, i32 3
  %234 = tail call float @llvm.fmuladd.f32(float %233, float %125, float %232)
  %235 = extractelement <4 x float> %sum3.12, i32 0
  %236 = fadd float %235, %234
  %237 = insertelement <4 x float> undef, float %236, i32 0
  %238 = fmul float %228, %131
  %239 = tail call float @llvm.fmuladd.f32(float %227, float %130, float %238)
  %240 = tail call float @llvm.fmuladd.f32(float %231, float %134, float %239)
  %241 = tail call float @llvm.fmuladd.f32(float %233, float %136, float %240)
  %242 = extractelement <4 x float> %sum3.12, i32 1
  %243 = fadd float %242, %241
  %244 = insertelement <4 x float> %237, float %243, i32 1
  %245 = fmul float %228, %142
  %246 = tail call float @llvm.fmuladd.f32(float %227, float %141, float %245)
  %247 = tail call float @llvm.fmuladd.f32(float %231, float %145, float %246)
  %248 = tail call float @llvm.fmuladd.f32(float %233, float %147, float %247)
  %249 = extractelement <4 x float> %sum3.12, i32 2
  %250 = fadd float %249, %248
  %251 = insertelement <4 x float> %244, float %250, i32 2
  %252 = fmul float %228, %153
  %253 = tail call float @llvm.fmuladd.f32(float %227, float %152, float %252)
  %254 = tail call float @llvm.fmuladd.f32(float %231, float %156, float %253)
  %255 = tail call float @llvm.fmuladd.f32(float %233, float %158, float %254)
  %256 = extractelement <4 x float> %sum3.12, i32 3
  %257 = fadd float %256, %255
  %258 = insertelement <4 x float> %251, float %257, i32 3
  %259 = add nuw nsw i32 %j.01, 4
  %260 = tail call i32 @get_local_size(i32 0) #3
  %261 = shl i32 %260, 2
  %262 = icmp ult i32 %259, %261
  br i1 %262, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.lcssa29 = phi <4 x float> [ %258, %.lr.ph ]
  %.lcssa28 = phi <4 x float> [ %226, %.lr.ph ]
  %.lcssa27 = phi <4 x float> [ %194, %.lr.ph ]
  %.lcssa = phi <4 x float> [ %162, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %21
  %sum0.1.lcssa = phi <4 x float> [ %sum0.013, %21 ], [ %.lcssa, %._crit_edge.loopexit ]
  %sum1.1.lcssa = phi <4 x float> [ %sum1.012, %21 ], [ %.lcssa27, %._crit_edge.loopexit ]
  %sum2.1.lcssa = phi <4 x float> [ %sum2.011, %21 ], [ %.lcssa28, %._crit_edge.loopexit ]
  %sum3.1.lcssa = phi <4 x float> [ %sum3.010, %21 ], [ %.lcssa29, %._crit_edge.loopexit ]
  tail call void @barrier(i32 1) #3
  %263 = add nuw nsw i32 %i.09, 1
  %264 = tail call i32 @get_local_size(i32 0) #3
  %265 = udiv i32 %13, %264
  %266 = icmp ult i32 %263, %265
  br i1 %266, label %21, label %._crit_edge16.loopexit

._crit_edge16.loopexit:                           ; preds = %._crit_edge
  %sum3.1.lcssa.lcssa = phi <4 x float> [ %sum3.1.lcssa, %._crit_edge ]
  %sum2.1.lcssa.lcssa = phi <4 x float> [ %sum2.1.lcssa, %._crit_edge ]
  %sum1.1.lcssa.lcssa = phi <4 x float> [ %sum1.1.lcssa, %._crit_edge ]
  %sum0.1.lcssa.lcssa = phi <4 x float> [ %sum0.1.lcssa, %._crit_edge ]
  br label %._crit_edge16

._crit_edge16:                                    ; preds = %._crit_edge16.loopexit, %0
  %sum0.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %sum0.1.lcssa.lcssa, %._crit_edge16.loopexit ]
  %sum1.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %sum1.1.lcssa.lcssa, %._crit_edge16.loopexit ]
  %sum2.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %sum2.1.lcssa.lcssa, %._crit_edge16.loopexit ]
  %sum3.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %sum3.1.lcssa.lcssa, %._crit_edge16.loopexit ]
  %267 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %12
  store <4 x float> %sum0.0.lcssa, <4 x float> addrspace(1)* %267, align 16, !tbaa !11
  %268 = tail call i32 @get_global_size(i32 0) #3
  %269 = add i32 %268, %12
  %270 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %269
  store <4 x float> %sum1.0.lcssa, <4 x float> addrspace(1)* %270, align 16, !tbaa !11
  %271 = tail call i32 @get_global_size(i32 0) #3
  %272 = shl i32 %271, 1
  %273 = add i32 %272, %12
  %274 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %273
  store <4 x float> %sum2.0.lcssa, <4 x float> addrspace(1)* %274, align 16, !tbaa !11
  %275 = tail call i32 @get_global_size(i32 0) #3
  %276 = mul i32 %275, 3
  %277 = add i32 %276, %12
  %278 = getelementptr inbounds <4 x float> addrspace(1)* %matrixC, i32 %277
  store <4 x float> %sum3.0.lcssa, <4 x float> addrspace(1)* %278, align 16, !tbaa !11
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

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!10}

!0 = !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, i32)* @mmmKernel, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float4*", !"float4*", !"float4*", !"uint", !"uint"}
!4 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"uint", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"", !""}
!6 = !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, <4 x float> addrspace(3)*)* @mmmKernel_local, !7, !2, !8, !9, !5}
!7 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 3}
!8 = !{!"kernel_arg_type", !"float4*", !"float4*", !"float4*", !"int", !"float4*"}
!9 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"int", !"float __attribute__((ext_vector_type(4)))*"}
!10 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!11 = !{!12, !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}

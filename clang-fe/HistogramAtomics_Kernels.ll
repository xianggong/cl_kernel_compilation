; ModuleID = '../kernel-src/HistogramAtomics_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@histogramKernel_Vector.subhists = internal addrspace(3) global [4096 x i32] zeroinitializer, align 4
@histogramKernel_Scalar.subhists = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @histogramKernel_Vector(<4 x i32> addrspace(1)* nocapture readonly %Image, i32 addrspace(1)* nocapture %Histogram, i32 %n4VectorsPerThread) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = tail call i32 @get_global_size(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = and i32 %2, 15
  %6 = icmp ult i32 %2, 1024
  br i1 %6, label %.lr.ph10, label %._crit_edge11

.lr.ph10:                                         ; preds = %0, %.lr.ph10
  %i.08 = phi i32 [ %8, %.lr.ph10 ], [ %2, %0 ]
  %7 = getelementptr inbounds <4 x i32> addrspace(3)* bitcast ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists to <4 x i32> addrspace(3)*), i32 %i.08
  store <4 x i32> zeroinitializer, <4 x i32> addrspace(3)* %7, align 16, !tbaa !4
  %8 = add i32 %i.08, %4
  %9 = icmp ult i32 %8, 1024
  br i1 %9, label %.lr.ph10, label %._crit_edge11

._crit_edge11:                                    ; preds = %.lr.ph10, %0
  tail call void @barrier(i32 1) #2
  %10 = icmp eq i32 %n4VectorsPerThread, 0
  br i1 %10, label %._crit_edge7, label %.lr.ph

.lr.ph:                                           ; preds = %._crit_edge11
  %11 = insertelement <4 x i32> undef, i32 %5, i32 0
  %12 = shufflevector <4 x i32> %11, <4 x i32> undef, <4 x i32> zeroinitializer
  br label %13

; <label>:13                                      ; preds = %13, %.lr.ph
  %i.15 = phi i32 [ 0, %.lr.ph ], [ %82, %13 ]
  %14 = mul i32 %i.15, %3
  %15 = add i32 %14, %1
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds <4 x i32> addrspace(1)* %Image, i64 %16
  %18 = load <4 x i32> addrspace(1)* %17, align 16, !tbaa !4
  %19 = and <4 x i32> %18, <i32 255, i32 255, i32 255, i32 255>
  %20 = shl <4 x i32> %19, <i32 4, i32 4, i32 4, i32 4>
  %21 = add <4 x i32> %20, %12
  %22 = extractelement <4 x i32> %21, i32 0
  %23 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %22
  %24 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %23) #2
  %25 = extractelement <4 x i32> %21, i32 1
  %26 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %25
  %27 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %26) #2
  %28 = extractelement <4 x i32> %21, i32 2
  %29 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %28
  %30 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %29) #2
  %31 = extractelement <4 x i32> %21, i32 3
  %32 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %31
  %33 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %32) #2
  %34 = lshr <4 x i32> %18, <i32 8, i32 8, i32 8, i32 8>
  %35 = and <4 x i32> %34, <i32 255, i32 255, i32 255, i32 255>
  %36 = shl <4 x i32> %35, <i32 4, i32 4, i32 4, i32 4>
  %37 = add <4 x i32> %36, %12
  %38 = extractelement <4 x i32> %37, i32 0
  %39 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %38
  %40 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %39) #2
  %41 = extractelement <4 x i32> %37, i32 1
  %42 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %41
  %43 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %42) #2
  %44 = extractelement <4 x i32> %37, i32 2
  %45 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %44
  %46 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %45) #2
  %47 = extractelement <4 x i32> %37, i32 3
  %48 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %47
  %49 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %48) #2
  %50 = lshr <4 x i32> %34, <i32 8, i32 8, i32 8, i32 8>
  %51 = and <4 x i32> %50, <i32 255, i32 255, i32 255, i32 255>
  %52 = shl <4 x i32> %51, <i32 4, i32 4, i32 4, i32 4>
  %53 = add <4 x i32> %52, %12
  %54 = extractelement <4 x i32> %53, i32 0
  %55 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %54
  %56 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %55) #2
  %57 = extractelement <4 x i32> %53, i32 1
  %58 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %57
  %59 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %58) #2
  %60 = extractelement <4 x i32> %53, i32 2
  %61 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %60
  %62 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %61) #2
  %63 = extractelement <4 x i32> %53, i32 3
  %64 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %63
  %65 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %64) #2
  %66 = lshr <4 x i32> %50, <i32 8, i32 8, i32 8, i32 8>
  %67 = and <4 x i32> %66, <i32 255, i32 255, i32 255, i32 255>
  %68 = shl <4 x i32> %67, <i32 4, i32 4, i32 4, i32 4>
  %69 = add <4 x i32> %68, %12
  %70 = extractelement <4 x i32> %69, i32 0
  %71 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %70
  %72 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %71) #2
  %73 = extractelement <4 x i32> %69, i32 1
  %74 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %73
  %75 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %74) #2
  %76 = extractelement <4 x i32> %69, i32 2
  %77 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %76
  %78 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %77) #2
  %79 = extractelement <4 x i32> %69, i32 3
  %80 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %79
  %81 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %80) #2
  %82 = add i32 %i.15, 1
  %exitcond = icmp eq i32 %82, %n4VectorsPerThread
  br i1 %exitcond, label %._crit_edge7, label %13

._crit_edge7:                                     ; preds = %13, %._crit_edge11
  tail call void @barrier(i32 1) #2
  %83 = icmp ult i32 %2, 256
  br i1 %83, label %.preheader, label %._crit_edge

.preheader:                                       ; preds = %._crit_edge7, %.preheader
  %i.24 = phi i32 [ %169, %.preheader ], [ %2, %._crit_edge7 ]
  %84 = shl i32 %i.24, 4
  %85 = or i32 %5, %84
  %86 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %85
  %87 = load i32 addrspace(3)* %86, align 4, !tbaa !7
  %fold = add i32 %2, 1
  %88 = and i32 %fold, 15
  %89 = or i32 %88, %84
  %90 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %89
  %91 = load i32 addrspace(3)* %90, align 4, !tbaa !7
  %92 = add i32 %91, %87
  %fold12 = add i32 %2, 2
  %93 = and i32 %fold12, 15
  %94 = or i32 %93, %84
  %95 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %94
  %96 = load i32 addrspace(3)* %95, align 4, !tbaa !7
  %97 = add i32 %96, %92
  %fold13 = add i32 %2, 3
  %98 = and i32 %fold13, 15
  %99 = or i32 %98, %84
  %100 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %99
  %101 = load i32 addrspace(3)* %100, align 4, !tbaa !7
  %102 = add i32 %101, %97
  %fold14 = add i32 %2, 4
  %103 = and i32 %fold14, 15
  %104 = or i32 %103, %84
  %105 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %104
  %106 = load i32 addrspace(3)* %105, align 4, !tbaa !7
  %107 = add i32 %106, %102
  %fold15 = add i32 %2, 5
  %108 = and i32 %fold15, 15
  %109 = or i32 %108, %84
  %110 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %109
  %111 = load i32 addrspace(3)* %110, align 4, !tbaa !7
  %112 = add i32 %111, %107
  %fold16 = add i32 %2, 6
  %113 = and i32 %fold16, 15
  %114 = or i32 %113, %84
  %115 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %114
  %116 = load i32 addrspace(3)* %115, align 4, !tbaa !7
  %117 = add i32 %116, %112
  %fold17 = add i32 %2, 7
  %118 = and i32 %fold17, 15
  %119 = or i32 %118, %84
  %120 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %119
  %121 = load i32 addrspace(3)* %120, align 4, !tbaa !7
  %122 = add i32 %121, %117
  %fold18 = add i32 %2, 8
  %123 = and i32 %fold18, 15
  %124 = or i32 %123, %84
  %125 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %124
  %126 = load i32 addrspace(3)* %125, align 4, !tbaa !7
  %127 = add i32 %126, %122
  %fold19 = add i32 %2, 9
  %128 = and i32 %fold19, 15
  %129 = or i32 %128, %84
  %130 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %129
  %131 = load i32 addrspace(3)* %130, align 4, !tbaa !7
  %132 = add i32 %131, %127
  %fold20 = add i32 %2, 10
  %133 = and i32 %fold20, 15
  %134 = or i32 %133, %84
  %135 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %134
  %136 = load i32 addrspace(3)* %135, align 4, !tbaa !7
  %137 = add i32 %136, %132
  %fold21 = add i32 %2, 11
  %138 = and i32 %fold21, 15
  %139 = or i32 %138, %84
  %140 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %139
  %141 = load i32 addrspace(3)* %140, align 4, !tbaa !7
  %142 = add i32 %141, %137
  %fold22 = add i32 %2, 12
  %143 = and i32 %fold22, 15
  %144 = or i32 %143, %84
  %145 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %144
  %146 = load i32 addrspace(3)* %145, align 4, !tbaa !7
  %147 = add i32 %146, %142
  %fold23 = add i32 %2, 13
  %148 = and i32 %fold23, 15
  %149 = or i32 %148, %84
  %150 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %149
  %151 = load i32 addrspace(3)* %150, align 4, !tbaa !7
  %152 = add i32 %151, %147
  %fold24 = add i32 %2, 14
  %153 = and i32 %fold24, 15
  %154 = or i32 %153, %84
  %155 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %154
  %156 = load i32 addrspace(3)* %155, align 4, !tbaa !7
  %157 = add i32 %156, %152
  %158 = add i32 %2, 15
  %159 = and i32 %158, 15
  %160 = or i32 %159, %84
  %161 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %160
  %162 = load i32 addrspace(3)* %161, align 4, !tbaa !7
  %163 = add i32 %162, %157
  %164 = tail call i32 @get_group_id(i32 0) #2
  %165 = shl i32 %164, 8
  %166 = add i32 %165, %i.24
  %167 = sext i32 %166 to i64
  %168 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %167
  store i32 %163, i32 addrspace(1)* %168, align 4, !tbaa !7
  %169 = add i32 %i.24, %4
  %170 = icmp ult i32 %169, 256
  br i1 %170, label %.preheader, label %._crit_edge

._crit_edge:                                      ; preds = %.preheader, %._crit_edge7
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
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = tail call i32 @get_global_size(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = and i32 %2, 3
  %6 = icmp ult i32 %2, 1024
  br i1 %6, label %.lr.ph11, label %._crit_edge12

.lr.ph11:                                         ; preds = %0, %.lr.ph11
  %i.09 = phi i32 [ %8, %.lr.ph11 ], [ %2, %0 ]
  %7 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %i.09
  store i32 0, i32 addrspace(3)* %7, align 4, !tbaa !7
  %8 = add i32 %i.09, %4
  %9 = icmp ult i32 %8, 1024
  br i1 %9, label %.lr.ph11, label %._crit_edge12

._crit_edge12:                                    ; preds = %.lr.ph11, %0
  tail call void @barrier(i32 1) #2
  %10 = icmp eq i32 %nVectorsPerThread, 0
  br i1 %10, label %._crit_edge8, label %.lr.ph

.lr.ph:                                           ; preds = %._crit_edge12, %.lr.ph
  %i.16 = phi i32 [ %36, %.lr.ph ], [ 0, %._crit_edge12 ]
  %11 = mul i32 %i.16, %3
  %12 = add i32 %11, %1
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds i32 addrspace(1)* %Image, i64 %13
  %15 = load i32 addrspace(1)* %14, align 4, !tbaa !7
  %16 = shl i32 %15, 2
  %17 = and i32 %16, 1020
  %18 = or i32 %17, %5
  %19 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %18
  %20 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %19) #2
  %21 = lshr i32 %15, 6
  %22 = and i32 %21, 1020
  %23 = or i32 %22, %5
  %24 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %23
  %25 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %24) #2
  %26 = lshr i32 %15, 14
  %27 = and i32 %26, 1020
  %28 = or i32 %27, %5
  %29 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %28
  %30 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %29) #2
  %31 = lshr i32 %15, 24
  %32 = shl nuw nsw i32 %31, 2
  %33 = or i32 %32, %5
  %34 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %33
  %35 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %34) #2
  %36 = add i32 %i.16, 1
  %exitcond = icmp eq i32 %36, %nVectorsPerThread
  br i1 %exitcond, label %._crit_edge8, label %.lr.ph

._crit_edge8:                                     ; preds = %.lr.ph, %._crit_edge12
  tail call void @barrier(i32 1) #2
  %37 = icmp ult i32 %2, 256
  br i1 %37, label %.preheader, label %._crit_edge

.preheader:                                       ; preds = %._crit_edge8, %.preheader
  %i.25 = phi i32 [ %63, %.preheader ], [ %2, %._crit_edge8 ]
  %38 = shl i32 %i.25, 2
  %39 = or i32 %5, %38
  %40 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %39
  %41 = load i32 addrspace(3)* %40, align 4, !tbaa !7
  %fold = add i32 %2, 1
  %42 = and i32 %fold, 3
  %43 = or i32 %42, %38
  %44 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %43
  %45 = load i32 addrspace(3)* %44, align 4, !tbaa !7
  %46 = add i32 %45, %41
  %fold13 = add i32 %2, 2
  %47 = and i32 %fold13, 3
  %48 = or i32 %47, %38
  %49 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %48
  %50 = load i32 addrspace(3)* %49, align 4, !tbaa !7
  %51 = add i32 %50, %46
  %52 = add i32 %2, 3
  %53 = and i32 %52, 3
  %54 = or i32 %53, %38
  %55 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %54
  %56 = load i32 addrspace(3)* %55, align 4, !tbaa !7
  %57 = add i32 %56, %51
  %58 = tail call i32 @get_group_id(i32 0) #2
  %59 = shl i32 %58, 8
  %60 = add i32 %59, %i.25
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %61
  store i32 %57, i32 addrspace(1)* %62, align 4, !tbaa !7
  %63 = add i32 %i.25, %4
  %64 = icmp ult i32 %63, 256
  br i1 %64, label %.preheader, label %._crit_edge

._crit_edge:                                      ; preds = %.preheader, %._crit_edge8
  ret void
}

; Function Attrs: nounwind
define void @reduceKernel(i32 addrspace(1)* nocapture %Histogram, i32 %nSubHists) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = icmp eq i32 %nSubHists, 0
  br i1 %2, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %0, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %0 ]
  %bin.01 = phi i32 [ %24, %.lr.ph ], [ 0, %0 ]
  %3 = trunc i64 %indvars.iv to i32
  %4 = shl nsw i32 %3, 8
  %5 = add i32 %4, %1
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %6
  %8 = load i32 addrspace(1)* %7, align 4, !tbaa !7
  %9 = add i32 %5, 256
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %10
  %12 = load i32 addrspace(1)* %11, align 4, !tbaa !7
  %13 = add i32 %5, 512
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %14
  %16 = load i32 addrspace(1)* %15, align 4, !tbaa !7
  %17 = add i32 %5, 768
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %18
  %20 = load i32 addrspace(1)* %19, align 4, !tbaa !7
  %21 = add i32 %8, %bin.01
  %22 = add i32 %21, %12
  %23 = add i32 %22, %16
  %24 = add i32 %23, %20
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 4
  %25 = trunc i64 %indvars.iv.next to i32
  %26 = icmp ult i32 %25, %nSubHists
  br i1 %26, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %0
  %bin.0.lcssa = phi i32 [ 0, %0 ], [ %24, %.lr.ph ]
  %27 = sext i32 %1 to i64
  %28 = getelementptr inbounds i32 addrspace(1)* %Histogram, i64 %27
  store i32 %bin.0.lcssa, i32 addrspace(1)* %28, align 4, !tbaa !7
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
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"int", metadata !5, i64 0}

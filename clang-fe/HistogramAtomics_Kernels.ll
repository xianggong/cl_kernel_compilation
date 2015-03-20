; ModuleID = '../kernel-src/HistogramAtomics_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

@histogramKernel_Vector.subhists = internal addrspace(3) global [4096 x i32] undef, align 4
@histogramKernel_Scalar.subhists = internal addrspace(3) global [1024 x i32] undef, align 4

; Function Attrs: nounwind
define void @histogramKernel_Vector(<4 x i32> addrspace(1)* nocapture readonly %Image, i32 addrspace(1)* nocapture %Histogram, i32 %n4VectorsPerThread) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = tail call i32 @get_global_size(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = and i32 %2, 15
  %6 = icmp ult i32 %2, 1024
  br i1 %6, label %.lr.ph10.preheader, label %._crit_edge11

.lr.ph10.preheader:                               ; preds = %0
  br label %.lr.ph10

.lr.ph10:                                         ; preds = %.lr.ph10.preheader, %.lr.ph10
  %i.08 = phi i32 [ %8, %.lr.ph10 ], [ %2, %.lr.ph10.preheader ]
  %7 = getelementptr inbounds <4 x i32> addrspace(3)* bitcast ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists to <4 x i32> addrspace(3)*), i32 %i.08
  store <4 x i32> zeroinitializer, <4 x i32> addrspace(3)* %7, align 16, !tbaa !16
  %8 = add i32 %i.08, %4
  %9 = icmp ult i32 %8, 1024
  br i1 %9, label %.lr.ph10, label %._crit_edge11.loopexit

._crit_edge11.loopexit:                           ; preds = %.lr.ph10
  br label %._crit_edge11

._crit_edge11:                                    ; preds = %._crit_edge11.loopexit, %0
  tail call void @barrier(i32 1) #2
  %10 = icmp eq i32 %n4VectorsPerThread, 0
  br i1 %10, label %._crit_edge7, label %.lr.ph

.lr.ph:                                           ; preds = %._crit_edge11
  %11 = insertelement <4 x i32> undef, i32 %5, i32 0
  %12 = shufflevector <4 x i32> %11, <4 x i32> undef, <4 x i32> zeroinitializer
  br label %13

; <label>:13                                      ; preds = %13, %.lr.ph
  %i.15 = phi i32 [ 0, %.lr.ph ], [ %81, %13 ]
  %14 = mul i32 %i.15, %3
  %15 = add i32 %14, %1
  %16 = getelementptr inbounds <4 x i32> addrspace(1)* %Image, i32 %15
  %17 = load <4 x i32> addrspace(1)* %16, align 16, !tbaa !16
  %18 = and <4 x i32> %17, <i32 255, i32 255, i32 255, i32 255>
  %19 = shl <4 x i32> %18, <i32 4, i32 4, i32 4, i32 4>
  %20 = add <4 x i32> %12, %19
  %21 = extractelement <4 x i32> %20, i32 0
  %22 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %21
  %23 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %22) #2
  %24 = extractelement <4 x i32> %20, i32 1
  %25 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %24
  %26 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %25) #2
  %27 = extractelement <4 x i32> %20, i32 2
  %28 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %27
  %29 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %28) #2
  %30 = extractelement <4 x i32> %20, i32 3
  %31 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %30
  %32 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %31) #2
  %33 = lshr <4 x i32> %17, <i32 8, i32 8, i32 8, i32 8>
  %34 = and <4 x i32> %33, <i32 255, i32 255, i32 255, i32 255>
  %35 = shl <4 x i32> %34, <i32 4, i32 4, i32 4, i32 4>
  %36 = add <4 x i32> %12, %35
  %37 = extractelement <4 x i32> %36, i32 0
  %38 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %37
  %39 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %38) #2
  %40 = extractelement <4 x i32> %36, i32 1
  %41 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %40
  %42 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %41) #2
  %43 = extractelement <4 x i32> %36, i32 2
  %44 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %43
  %45 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %44) #2
  %46 = extractelement <4 x i32> %36, i32 3
  %47 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %46
  %48 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %47) #2
  %49 = lshr <4 x i32> %33, <i32 8, i32 8, i32 8, i32 8>
  %50 = and <4 x i32> %49, <i32 255, i32 255, i32 255, i32 255>
  %51 = shl <4 x i32> %50, <i32 4, i32 4, i32 4, i32 4>
  %52 = add <4 x i32> %12, %51
  %53 = extractelement <4 x i32> %52, i32 0
  %54 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %53
  %55 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %54) #2
  %56 = extractelement <4 x i32> %52, i32 1
  %57 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %56
  %58 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %57) #2
  %59 = extractelement <4 x i32> %52, i32 2
  %60 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %59
  %61 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %60) #2
  %62 = extractelement <4 x i32> %52, i32 3
  %63 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %62
  %64 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %63) #2
  %65 = lshr <4 x i32> %49, <i32 8, i32 8, i32 8, i32 8>
  %66 = and <4 x i32> %65, <i32 255, i32 255, i32 255, i32 255>
  %67 = shl <4 x i32> %66, <i32 4, i32 4, i32 4, i32 4>
  %68 = add <4 x i32> %12, %67
  %69 = extractelement <4 x i32> %68, i32 0
  %70 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %69
  %71 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %70) #2
  %72 = extractelement <4 x i32> %68, i32 1
  %73 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %72
  %74 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %73) #2
  %75 = extractelement <4 x i32> %68, i32 2
  %76 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %75
  %77 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %76) #2
  %78 = extractelement <4 x i32> %68, i32 3
  %79 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %78
  %80 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %79) #2
  %81 = add nuw i32 %i.15, 1
  %exitcond12 = icmp eq i32 %81, %n4VectorsPerThread
  br i1 %exitcond12, label %._crit_edge7.loopexit, label %13

._crit_edge7.loopexit:                            ; preds = %13
  br label %._crit_edge7

._crit_edge7:                                     ; preds = %._crit_edge7.loopexit, %._crit_edge11
  tail call void @barrier(i32 1) #2
  %82 = icmp ult i32 %2, 256
  br i1 %82, label %.preheader.preheader, label %._crit_edge

.preheader.preheader:                             ; preds = %._crit_edge7
  br label %.preheader

.preheader:                                       ; preds = %.preheader.preheader, %.preheader
  %i.24 = phi i32 [ %167, %.preheader ], [ %2, %.preheader.preheader ]
  %83 = shl i32 %i.24, 4
  %84 = or i32 %5, %83
  %85 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %84
  %86 = load i32 addrspace(3)* %85, align 4, !tbaa !19
  %fold = add i32 %2, 1
  %87 = and i32 %fold, 15
  %88 = or i32 %87, %83
  %89 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %88
  %90 = load i32 addrspace(3)* %89, align 4, !tbaa !19
  %91 = add i32 %90, %86
  %fold13 = add i32 %2, 2
  %92 = and i32 %fold13, 15
  %93 = or i32 %92, %83
  %94 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %93
  %95 = load i32 addrspace(3)* %94, align 4, !tbaa !19
  %96 = add i32 %95, %91
  %fold14 = add i32 %2, 3
  %97 = and i32 %fold14, 15
  %98 = or i32 %97, %83
  %99 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %98
  %100 = load i32 addrspace(3)* %99, align 4, !tbaa !19
  %101 = add i32 %100, %96
  %fold15 = add i32 %2, 4
  %102 = and i32 %fold15, 15
  %103 = or i32 %102, %83
  %104 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %103
  %105 = load i32 addrspace(3)* %104, align 4, !tbaa !19
  %106 = add i32 %105, %101
  %fold16 = add i32 %2, 5
  %107 = and i32 %fold16, 15
  %108 = or i32 %107, %83
  %109 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %108
  %110 = load i32 addrspace(3)* %109, align 4, !tbaa !19
  %111 = add i32 %110, %106
  %fold17 = add i32 %2, 6
  %112 = and i32 %fold17, 15
  %113 = or i32 %112, %83
  %114 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %113
  %115 = load i32 addrspace(3)* %114, align 4, !tbaa !19
  %116 = add i32 %115, %111
  %fold18 = add i32 %2, 7
  %117 = and i32 %fold18, 15
  %118 = or i32 %117, %83
  %119 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %118
  %120 = load i32 addrspace(3)* %119, align 4, !tbaa !19
  %121 = add i32 %120, %116
  %fold19 = add i32 %2, 8
  %122 = and i32 %fold19, 15
  %123 = or i32 %122, %83
  %124 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %123
  %125 = load i32 addrspace(3)* %124, align 4, !tbaa !19
  %126 = add i32 %125, %121
  %fold20 = add i32 %2, 9
  %127 = and i32 %fold20, 15
  %128 = or i32 %127, %83
  %129 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %128
  %130 = load i32 addrspace(3)* %129, align 4, !tbaa !19
  %131 = add i32 %130, %126
  %fold21 = add i32 %2, 10
  %132 = and i32 %fold21, 15
  %133 = or i32 %132, %83
  %134 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %133
  %135 = load i32 addrspace(3)* %134, align 4, !tbaa !19
  %136 = add i32 %135, %131
  %fold22 = add i32 %2, 11
  %137 = and i32 %fold22, 15
  %138 = or i32 %137, %83
  %139 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %138
  %140 = load i32 addrspace(3)* %139, align 4, !tbaa !19
  %141 = add i32 %140, %136
  %fold23 = add i32 %2, 12
  %142 = and i32 %fold23, 15
  %143 = or i32 %142, %83
  %144 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %143
  %145 = load i32 addrspace(3)* %144, align 4, !tbaa !19
  %146 = add i32 %145, %141
  %fold24 = add i32 %2, 13
  %147 = and i32 %fold24, 15
  %148 = or i32 %147, %83
  %149 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %148
  %150 = load i32 addrspace(3)* %149, align 4, !tbaa !19
  %151 = add i32 %150, %146
  %fold25 = add i32 %2, 14
  %152 = and i32 %fold25, 15
  %153 = or i32 %152, %83
  %154 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %153
  %155 = load i32 addrspace(3)* %154, align 4, !tbaa !19
  %156 = add i32 %155, %151
  %157 = add nuw nsw i32 %2, 15
  %158 = and i32 %157, 15
  %159 = or i32 %158, %83
  %160 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %159
  %161 = load i32 addrspace(3)* %160, align 4, !tbaa !19
  %162 = add i32 %161, %156
  %163 = tail call i32 @get_group_id(i32 0) #2
  %164 = shl i32 %163, 8
  %165 = add i32 %164, %i.24
  %166 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %165
  store i32 %162, i32 addrspace(1)* %166, align 4, !tbaa !19
  %167 = add i32 %i.24, %4
  %168 = icmp ult i32 %167, 256
  br i1 %168, label %.preheader, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.preheader
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %._crit_edge7
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
  br i1 %6, label %.lr.ph11.preheader, label %._crit_edge12

.lr.ph11.preheader:                               ; preds = %0
  br label %.lr.ph11

.lr.ph11:                                         ; preds = %.lr.ph11.preheader, %.lr.ph11
  %i.09 = phi i32 [ %8, %.lr.ph11 ], [ %2, %.lr.ph11.preheader ]
  %7 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %i.09
  store i32 0, i32 addrspace(3)* %7, align 4, !tbaa !19
  %8 = add i32 %i.09, %4
  %9 = icmp ult i32 %8, 1024
  br i1 %9, label %.lr.ph11, label %._crit_edge12.loopexit

._crit_edge12.loopexit:                           ; preds = %.lr.ph11
  br label %._crit_edge12

._crit_edge12:                                    ; preds = %._crit_edge12.loopexit, %0
  tail call void @barrier(i32 1) #2
  %10 = icmp eq i32 %nVectorsPerThread, 0
  br i1 %10, label %._crit_edge8, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %._crit_edge12
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %i.16 = phi i32 [ %35, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %11 = mul i32 %i.16, %3
  %12 = add i32 %11, %1
  %13 = getelementptr inbounds i32 addrspace(1)* %Image, i32 %12
  %14 = load i32 addrspace(1)* %13, align 4, !tbaa !19
  %15 = shl i32 %14, 2
  %16 = and i32 %15, 1020
  %17 = or i32 %16, %5
  %18 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %17
  %19 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %18) #2
  %20 = lshr i32 %14, 6
  %21 = and i32 %20, 1020
  %22 = or i32 %21, %5
  %23 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %22
  %24 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %23) #2
  %25 = lshr i32 %14, 14
  %26 = and i32 %25, 1020
  %27 = or i32 %26, %5
  %28 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %27
  %29 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %28) #2
  %30 = lshr i32 %14, 24
  %31 = shl nuw nsw i32 %30, 2
  %32 = or i32 %31, %5
  %33 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %32
  %34 = tail call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %33) #2
  %35 = add nuw i32 %i.16, 1
  %exitcond13 = icmp eq i32 %35, %nVectorsPerThread
  br i1 %exitcond13, label %._crit_edge8.loopexit, label %.lr.ph

._crit_edge8.loopexit:                            ; preds = %.lr.ph
  br label %._crit_edge8

._crit_edge8:                                     ; preds = %._crit_edge8.loopexit, %._crit_edge12
  tail call void @barrier(i32 1) #2
  %36 = icmp ult i32 %2, 256
  br i1 %36, label %.preheader.preheader, label %._crit_edge

.preheader.preheader:                             ; preds = %._crit_edge8
  br label %.preheader

.preheader:                                       ; preds = %.preheader.preheader, %.preheader
  %i.25 = phi i32 [ %61, %.preheader ], [ %2, %.preheader.preheader ]
  %37 = shl i32 %i.25, 2
  %38 = or i32 %5, %37
  %39 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %38
  %40 = load i32 addrspace(3)* %39, align 4, !tbaa !19
  %fold = add i32 %2, 1
  %41 = and i32 %fold, 3
  %42 = or i32 %41, %37
  %43 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %42
  %44 = load i32 addrspace(3)* %43, align 4, !tbaa !19
  %45 = add i32 %44, %40
  %fold14 = add i32 %2, 2
  %46 = and i32 %fold14, 3
  %47 = or i32 %46, %37
  %48 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %47
  %49 = load i32 addrspace(3)* %48, align 4, !tbaa !19
  %50 = add i32 %49, %45
  %51 = add nuw nsw i32 %2, 3
  %52 = and i32 %51, 3
  %53 = or i32 %52, %37
  %54 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %53
  %55 = load i32 addrspace(3)* %54, align 4, !tbaa !19
  %56 = add i32 %55, %50
  %57 = tail call i32 @get_group_id(i32 0) #2
  %58 = shl i32 %57, 8
  %59 = add i32 %58, %i.25
  %60 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %59
  store i32 %56, i32 addrspace(1)* %60, align 4, !tbaa !19
  %61 = add i32 %i.25, %4
  %62 = icmp ult i32 %61, 256
  br i1 %62, label %.preheader, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.preheader
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %._crit_edge8
  ret void
}

; Function Attrs: nounwind
define void @reduceKernel(i32 addrspace(1)* nocapture %Histogram, i32 %nSubHists) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = icmp eq i32 %nSubHists, 0
  br i1 %2, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %i.02 = phi i32 [ %20, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %bin.01 = phi i32 [ %19, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %3 = shl nsw i32 %i.02, 8
  %4 = add i32 %3, %1
  %5 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %4
  %6 = load i32 addrspace(1)* %5, align 4, !tbaa !19
  %7 = add i32 %4, 256
  %8 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %7
  %9 = load i32 addrspace(1)* %8, align 4, !tbaa !19
  %10 = add i32 %4, 512
  %11 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %10
  %12 = load i32 addrspace(1)* %11, align 4, !tbaa !19
  %13 = add i32 %4, 768
  %14 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %13
  %15 = load i32 addrspace(1)* %14, align 4, !tbaa !19
  %16 = add i32 %6, %bin.01
  %17 = add i32 %16, %9
  %18 = add i32 %17, %12
  %19 = add i32 %18, %15
  %20 = add nuw nsw i32 %i.02, 4
  %21 = icmp ult i32 %20, %nSubHists
  br i1 %21, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.lcssa = phi i32 [ %19, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %bin.0.lcssa = phi i32 [ 0, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %22 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %1
  store i32 %bin.0.lcssa, i32 addrspace(1)* %22, align 4, !tbaa !19
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6, !9}
!llvm.ident = !{!15}

!0 = !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32)* @histogramKernel_Vector, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint4*", !"uint*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"uint __attribute__((ext_vector_type(4)))*", !"uint*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @histogramKernel_Scalar, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint"}
!8 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint"}
!9 = !{void (i32 addrspace(1)*, i32)* @reduceKernel, !10, !11, !12, !13, !14}
!10 = !{!"kernel_arg_addr_space", i32 1, i32 0}
!11 = !{!"kernel_arg_access_qual", !"none", !"none"}
!12 = !{!"kernel_arg_type", !"uint*", !"uint"}
!13 = !{!"kernel_arg_base_type", !"uint*", !"uint"}
!14 = !{!"kernel_arg_type_qual", !"", !""}
!15 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!16 = !{!17, !17, i64 0}
!17 = !{!"omnipotent char", !18, i64 0}
!18 = !{!"Simple C/C++ TBAA"}
!19 = !{!20, !20, i64 0}
!20 = !{!"int", !17, i64 0}

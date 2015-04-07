; ModuleID = '../kernel-src/HistogramAtomics_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@histogramKernel_Vector.subhists = internal addrspace(3) global [4096 x i32] zeroinitializer, align 4
@histogramKernel_Scalar.subhists = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @histogramKernel_Vector(<4 x i32> addrspace(1)* %Image, i32 addrspace(1)* %Histogram, i32 %n4VectorsPerThread) #0 {
  %1 = alloca <4 x i32> addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32, align 4
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
  %p = alloca <4 x i32> addrspace(3)*, align 4
  %bin = alloca i32, align 4
  %off = alloca i32, align 4
  %j = alloca i32, align 4
  store <4 x i32> addrspace(1)* %Image, <4 x i32> addrspace(1)** %1, align 4
  store i32 addrspace(1)* %Histogram, i32 addrspace(1)** %2, align 4
  store i32 %n4VectorsPerThread, i32* %3, align 4
  %4 = call i32 @llvm.r600.read.tgid.x()
  store i32 %4, i32* %tid, align 4
  %5 = call i32 @llvm.r600.read.tidig.x()
  store i32 %5, i32* %ltid, align 4
  %6 = call i32 @llvm.r600.read.global.size.x()
  store i32 %6, i32* %Stride, align 4
  %7 = call i32 @llvm.r600.read.local.size.x()
  store i32 %7, i32* %groupSize, align 4
  store i32 8, i32* %shft, align 4
  store i32 255, i32* %msk, align 4
  %8 = load i32* %ltid, align 4
  %9 = urem i32 %8, 16
  store i32 %9, i32* %offset, align 4
  store i32 4096, i32* %lmem_items, align 4
  store <4 x i32> addrspace(3)* bitcast ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists to <4 x i32> addrspace(3)*), <4 x i32> addrspace(3)** %p, align 4
  %10 = load i32* %ltid, align 4
  store i32 %10, i32* %i, align 4
  br label %11

; <label>:11                                      ; preds = %20, %0
  %12 = load i32* %i, align 4
  %13 = load i32* %lmem_items, align 4
  %14 = udiv i32 %13, 4
  %15 = icmp ult i32 %12, %14
  br i1 %15, label %16, label %24

; <label>:16                                      ; preds = %11
  %17 = load i32* %i, align 4
  %18 = load <4 x i32> addrspace(3)** %p, align 4
  %19 = getelementptr inbounds <4 x i32> addrspace(3)* %18, i32 %17
  store <4 x i32> zeroinitializer, <4 x i32> addrspace(3)* %19, align 16
  br label %20

; <label>:20                                      ; preds = %16
  %21 = load i32* %groupSize, align 4
  %22 = load i32* %i, align 4
  %23 = add i32 %22, %21
  store i32 %23, i32* %i, align 4
  br label %11

; <label>:24                                      ; preds = %11
  call void @barrier(i32 1)
  store i32 0, i32* %i, align 4
  br label %25

; <label>:25                                      ; preds = %136, %24
  %26 = load i32* %i, align 4
  %27 = load i32* %3, align 4
  %28 = icmp ult i32 %26, %27
  br i1 %28, label %29, label %139

; <label>:29                                      ; preds = %25
  %30 = load i32* %tid, align 4
  %31 = load i32* %i, align 4
  %32 = load i32* %Stride, align 4
  %33 = mul i32 %31, %32
  %34 = add i32 %30, %33
  %35 = load <4 x i32> addrspace(1)** %1, align 4
  %36 = getelementptr inbounds <4 x i32> addrspace(1)* %35, i32 %34
  %37 = load <4 x i32> addrspace(1)* %36, align 16
  store <4 x i32> %37, <4 x i32>* %temp, align 16
  %38 = load <4 x i32>* %temp, align 16
  %39 = and <4 x i32> %38, <i32 255, i32 255, i32 255, i32 255>
  %40 = mul <4 x i32> %39, <i32 16, i32 16, i32 16, i32 16>
  %41 = load i32* %offset, align 4
  %42 = insertelement <4 x i32> undef, i32 %41, i32 0
  %43 = shufflevector <4 x i32> %42, <4 x i32> undef, <4 x i32> zeroinitializer
  %44 = add <4 x i32> %40, %43
  store <4 x i32> %44, <4 x i32>* %temp2, align 16
  %45 = load <4 x i32>* %temp2, align 16
  %46 = extractelement <4 x i32> %45, i32 0
  %47 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %46
  %48 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %47)
  %49 = load <4 x i32>* %temp2, align 16
  %50 = extractelement <4 x i32> %49, i32 1
  %51 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %50
  %52 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %51)
  %53 = load <4 x i32>* %temp2, align 16
  %54 = extractelement <4 x i32> %53, i32 2
  %55 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %54
  %56 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %55)
  %57 = load <4 x i32>* %temp2, align 16
  %58 = extractelement <4 x i32> %57, i32 3
  %59 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %58
  %60 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %59)
  %61 = load <4 x i32>* %temp, align 16
  %62 = lshr <4 x i32> %61, <i32 8, i32 8, i32 8, i32 8>
  store <4 x i32> %62, <4 x i32>* %temp, align 16
  %63 = load <4 x i32>* %temp, align 16
  %64 = and <4 x i32> %63, <i32 255, i32 255, i32 255, i32 255>
  %65 = mul <4 x i32> %64, <i32 16, i32 16, i32 16, i32 16>
  %66 = load i32* %offset, align 4
  %67 = insertelement <4 x i32> undef, i32 %66, i32 0
  %68 = shufflevector <4 x i32> %67, <4 x i32> undef, <4 x i32> zeroinitializer
  %69 = add <4 x i32> %65, %68
  store <4 x i32> %69, <4 x i32>* %temp2, align 16
  %70 = load <4 x i32>* %temp2, align 16
  %71 = extractelement <4 x i32> %70, i32 0
  %72 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %71
  %73 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %72)
  %74 = load <4 x i32>* %temp2, align 16
  %75 = extractelement <4 x i32> %74, i32 1
  %76 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %75
  %77 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %76)
  %78 = load <4 x i32>* %temp2, align 16
  %79 = extractelement <4 x i32> %78, i32 2
  %80 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %79
  %81 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %80)
  %82 = load <4 x i32>* %temp2, align 16
  %83 = extractelement <4 x i32> %82, i32 3
  %84 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %83
  %85 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %84)
  %86 = load <4 x i32>* %temp, align 16
  %87 = lshr <4 x i32> %86, <i32 8, i32 8, i32 8, i32 8>
  store <4 x i32> %87, <4 x i32>* %temp, align 16
  %88 = load <4 x i32>* %temp, align 16
  %89 = and <4 x i32> %88, <i32 255, i32 255, i32 255, i32 255>
  %90 = mul <4 x i32> %89, <i32 16, i32 16, i32 16, i32 16>
  %91 = load i32* %offset, align 4
  %92 = insertelement <4 x i32> undef, i32 %91, i32 0
  %93 = shufflevector <4 x i32> %92, <4 x i32> undef, <4 x i32> zeroinitializer
  %94 = add <4 x i32> %90, %93
  store <4 x i32> %94, <4 x i32>* %temp2, align 16
  %95 = load <4 x i32>* %temp2, align 16
  %96 = extractelement <4 x i32> %95, i32 0
  %97 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %96
  %98 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %97)
  %99 = load <4 x i32>* %temp2, align 16
  %100 = extractelement <4 x i32> %99, i32 1
  %101 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %100
  %102 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %101)
  %103 = load <4 x i32>* %temp2, align 16
  %104 = extractelement <4 x i32> %103, i32 2
  %105 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %104
  %106 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %105)
  %107 = load <4 x i32>* %temp2, align 16
  %108 = extractelement <4 x i32> %107, i32 3
  %109 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %108
  %110 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %109)
  %111 = load <4 x i32>* %temp, align 16
  %112 = lshr <4 x i32> %111, <i32 8, i32 8, i32 8, i32 8>
  store <4 x i32> %112, <4 x i32>* %temp, align 16
  %113 = load <4 x i32>* %temp, align 16
  %114 = and <4 x i32> %113, <i32 255, i32 255, i32 255, i32 255>
  %115 = mul <4 x i32> %114, <i32 16, i32 16, i32 16, i32 16>
  %116 = load i32* %offset, align 4
  %117 = insertelement <4 x i32> undef, i32 %116, i32 0
  %118 = shufflevector <4 x i32> %117, <4 x i32> undef, <4 x i32> zeroinitializer
  %119 = add <4 x i32> %115, %118
  store <4 x i32> %119, <4 x i32>* %temp2, align 16
  %120 = load <4 x i32>* %temp2, align 16
  %121 = extractelement <4 x i32> %120, i32 0
  %122 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %121
  %123 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %122)
  %124 = load <4 x i32>* %temp2, align 16
  %125 = extractelement <4 x i32> %124, i32 1
  %126 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %125
  %127 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %126)
  %128 = load <4 x i32>* %temp2, align 16
  %129 = extractelement <4 x i32> %128, i32 2
  %130 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %129
  %131 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %130)
  %132 = load <4 x i32>* %temp2, align 16
  %133 = extractelement <4 x i32> %132, i32 3
  %134 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %133
  %135 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %134)
  br label %136

; <label>:136                                     ; preds = %29
  %137 = load i32* %i, align 4
  %138 = add i32 %137, 1
  store i32 %138, i32* %i, align 4
  br label %25

; <label>:139                                     ; preds = %25
  call void @barrier(i32 1)
  %140 = load i32* %ltid, align 4
  store i32 %140, i32* %i, align 4
  br label %141

; <label>:141                                     ; preds = %172, %139
  %142 = load i32* %i, align 4
  %143 = icmp ult i32 %142, 256
  br i1 %143, label %144, label %176

; <label>:144                                     ; preds = %141
  store i32 0, i32* %bin, align 4
  %145 = load i32* %offset, align 4
  store i32 %145, i32* %off, align 4
  store i32 0, i32* %j, align 4
  br label %146

; <label>:146                                     ; preds = %159, %144
  %147 = load i32* %j, align 4
  %148 = icmp slt i32 %147, 16
  br i1 %148, label %149, label %164

; <label>:149                                     ; preds = %146
  %150 = load i32* %i, align 4
  %151 = mul i32 %150, 16
  %152 = load i32* %off, align 4
  %153 = urem i32 %152, 16
  %154 = add i32 %151, %153
  %155 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %154
  %156 = load i32 addrspace(3)* %155, align 4
  %157 = load i32* %bin, align 4
  %158 = add i32 %157, %156
  store i32 %158, i32* %bin, align 4
  br label %159

; <label>:159                                     ; preds = %149
  %160 = load i32* %j, align 4
  %161 = add nsw i32 %160, 1
  store i32 %161, i32* %j, align 4
  %162 = load i32* %off, align 4
  %163 = add i32 %162, 1
  store i32 %163, i32* %off, align 4
  br label %146

; <label>:164                                     ; preds = %146
  %165 = load i32* %bin, align 4
  %166 = call i32 @get_group_id(i32 0)
  %167 = mul i32 %166, 256
  %168 = load i32* %i, align 4
  %169 = add i32 %167, %168
  %170 = load i32 addrspace(1)** %2, align 4
  %171 = getelementptr inbounds i32 addrspace(1)* %170, i32 %169
  store i32 %165, i32 addrspace(1)* %171, align 4
  br label %172

; <label>:172                                     ; preds = %164
  %173 = load i32* %groupSize, align 4
  %174 = load i32* %i, align 4
  %175 = add i32 %174, %173
  store i32 %175, i32* %i, align 4
  br label %141

; <label>:176                                     ; preds = %141
  ret void
}

declare i32 @llvm.r600.read.tgid.x() #1
declare i32 @llvm.r600.read.tgid.y() #1
declare i32 @llvm.r600.read.tgid.z() #1

declare i32 @llvm.r600.read.tidig.x() #1
declare i32 @llvm.r600.read.tidig.y() #1
declare i32 @llvm.r600.read.tidig.z() #1

declare i32 @llvm.r600.read.global.size.x() #1
declare i32 @llvm.r600.read.global.size.y() #1
declare i32 @llvm.r600.read.global.size.z() #1

declare i32 @llvm.r600.read.local.size.x() #1
declare i32 @llvm.r600.read.local.size.y() #1
declare i32 @llvm.r600.read.local.size.z() #1

declare void @barrier(i32) #1

declare i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)*) #1

declare i32 @get_group_id(i32) #1

; Function Attrs: nounwind
define void @histogramKernel_Scalar(i32 addrspace(1)* %Image, i32 addrspace(1)* %Histogram, i32 %nVectorsPerThread) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca i32, align 4
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
  %p = alloca i32 addrspace(3)*, align 4
  %bin = alloca i32, align 4
  %off = alloca i32, align 4
  %j1 = alloca i32, align 4
  store i32 addrspace(1)* %Image, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %Histogram, i32 addrspace(1)** %2, align 4
  store i32 %nVectorsPerThread, i32* %3, align 4
  %4 = call i32 @llvm.r600.read.tgid.x()
  store i32 %4, i32* %tid, align 4
  %5 = call i32 @llvm.r600.read.tidig.x()
  store i32 %5, i32* %ltid, align 4
  %6 = call i32 @llvm.r600.read.global.size.x()
  store i32 %6, i32* %Stride, align 4
  %7 = call i32 @llvm.r600.read.local.size.x()
  store i32 %7, i32* %groupSize, align 4
  store i32 8, i32* %shft, align 4
  store i32 255, i32* %msk, align 4
  %8 = load i32* %ltid, align 4
  %9 = urem i32 %8, 4
  store i32 %9, i32* %offset, align 4
  store i32 1024, i32* %lmem_items, align 4
  store i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 addrspace(3)** %p, align 4
  %10 = load i32* %ltid, align 4
  store i32 %10, i32* %i, align 4
  br label %11

; <label>:11                                      ; preds = %19, %0
  %12 = load i32* %i, align 4
  %13 = load i32* %lmem_items, align 4
  %14 = icmp ult i32 %12, %13
  br i1 %14, label %15, label %23

; <label>:15                                      ; preds = %11
  %16 = load i32* %i, align 4
  %17 = load i32 addrspace(3)** %p, align 4
  %18 = getelementptr inbounds i32 addrspace(3)* %17, i32 %16
  store i32 0, i32 addrspace(3)* %18, align 4
  br label %19

; <label>:19                                      ; preds = %15
  %20 = load i32* %groupSize, align 4
  %21 = load i32* %i, align 4
  %22 = add i32 %21, %20
  store i32 %22, i32* %i, align 4
  br label %11

; <label>:23                                      ; preds = %11
  call void @barrier(i32 1)
  store i32 0, i32* %i, align 4
  br label %24

; <label>:24                                      ; preds = %75, %23
  %25 = load i32* %i, align 4
  %26 = load i32* %3, align 4
  %27 = icmp ult i32 %25, %26
  br i1 %27, label %28, label %78

; <label>:28                                      ; preds = %24
  %29 = load i32* %tid, align 4
  %30 = load i32* %i, align 4
  %31 = load i32* %Stride, align 4
  %32 = mul i32 %30, %31
  %33 = add i32 %29, %32
  %34 = load i32 addrspace(1)** %1, align 4
  %35 = getelementptr inbounds i32 addrspace(1)* %34, i32 %33
  %36 = load i32 addrspace(1)* %35, align 4
  store i32 %36, i32* %temp, align 4
  %37 = load i32* %temp, align 4
  %38 = and i32 %37, 255
  %39 = mul i32 %38, 4
  %40 = load i32* %offset, align 4
  %41 = add i32 %39, %40
  store i32 %41, i32* %temp2, align 4
  %42 = load i32* %temp2, align 4
  %43 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %42
  %44 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %43)
  %45 = load i32* %temp, align 4
  %46 = lshr i32 %45, 8
  store i32 %46, i32* %temp, align 4
  %47 = load i32* %temp, align 4
  %48 = and i32 %47, 255
  %49 = mul i32 %48, 4
  %50 = load i32* %offset, align 4
  %51 = add i32 %49, %50
  store i32 %51, i32* %temp2, align 4
  %52 = load i32* %temp2, align 4
  %53 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %52
  %54 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %53)
  %55 = load i32* %temp, align 4
  %56 = lshr i32 %55, 8
  store i32 %56, i32* %temp, align 4
  %57 = load i32* %temp, align 4
  %58 = and i32 %57, 255
  %59 = mul i32 %58, 4
  %60 = load i32* %offset, align 4
  %61 = add i32 %59, %60
  store i32 %61, i32* %temp2, align 4
  %62 = load i32* %temp2, align 4
  %63 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %62
  %64 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %63)
  %65 = load i32* %temp, align 4
  %66 = lshr i32 %65, 8
  store i32 %66, i32* %temp, align 4
  %67 = load i32* %temp, align 4
  %68 = and i32 %67, 255
  %69 = mul i32 %68, 4
  %70 = load i32* %offset, align 4
  %71 = add i32 %69, %70
  store i32 %71, i32* %temp2, align 4
  %72 = load i32* %temp2, align 4
  %73 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %72
  %74 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %73)
  br label %75

; <label>:75                                      ; preds = %28
  %76 = load i32* %i, align 4
  %77 = add i32 %76, 1
  store i32 %77, i32* %i, align 4
  br label %24

; <label>:78                                      ; preds = %24
  call void @barrier(i32 1)
  %79 = load i32* %ltid, align 4
  store i32 %79, i32* %i, align 4
  br label %80

; <label>:80                                      ; preds = %111, %78
  %81 = load i32* %i, align 4
  %82 = icmp ult i32 %81, 256
  br i1 %82, label %83, label %115

; <label>:83                                      ; preds = %80
  store i32 0, i32* %bin, align 4
  %84 = load i32* %offset, align 4
  store i32 %84, i32* %off, align 4
  store i32 0, i32* %j1, align 4
  br label %85

; <label>:85                                      ; preds = %98, %83
  %86 = load i32* %j1, align 4
  %87 = icmp slt i32 %86, 4
  br i1 %87, label %88, label %103

; <label>:88                                      ; preds = %85
  %89 = load i32* %i, align 4
  %90 = mul i32 %89, 4
  %91 = load i32* %off, align 4
  %92 = urem i32 %91, 4
  %93 = add i32 %90, %92
  %94 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %93
  %95 = load i32 addrspace(3)* %94, align 4
  %96 = load i32* %bin, align 4
  %97 = add i32 %96, %95
  store i32 %97, i32* %bin, align 4
  br label %98

; <label>:98                                      ; preds = %88
  %99 = load i32* %j1, align 4
  %100 = add nsw i32 %99, 1
  store i32 %100, i32* %j1, align 4
  %101 = load i32* %off, align 4
  %102 = add i32 %101, 1
  store i32 %102, i32* %off, align 4
  br label %85

; <label>:103                                     ; preds = %85
  %104 = load i32* %bin, align 4
  %105 = call i32 @get_group_id(i32 0)
  %106 = mul i32 %105, 256
  %107 = load i32* %i, align 4
  %108 = add i32 %106, %107
  %109 = load i32 addrspace(1)** %2, align 4
  %110 = getelementptr inbounds i32 addrspace(1)* %109, i32 %108
  store i32 %104, i32 addrspace(1)* %110, align 4
  br label %111

; <label>:111                                     ; preds = %103
  %112 = load i32* %groupSize, align 4
  %113 = load i32* %i, align 4
  %114 = add i32 %113, %112
  store i32 %114, i32* %i, align 4
  br label %80

; <label>:115                                     ; preds = %80
  ret void
}

; Function Attrs: nounwind
define void @reduceKernel(i32 addrspace(1)* %Histogram, i32 %nSubHists) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32, align 4
  %tid = alloca i32, align 4
  %bin = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 addrspace(1)* %Histogram, i32 addrspace(1)** %1, align 4
  store i32 %nSubHists, i32* %2, align 4
  %3 = call i32 @llvm.r600.read.tgid.x()
  store i32 %3, i32* %tid, align 4
  store i32 0, i32* %bin, align 4
  store i32 0, i32* %i, align 4
  br label %4

; <label>:4                                       ; preds = %45, %0
  %5 = load i32* %i, align 4
  %6 = load i32* %2, align 4
  %7 = icmp ult i32 %5, %6
  br i1 %7, label %8, label %48

; <label>:8                                       ; preds = %4
  %9 = load i32* %i, align 4
  %10 = mul nsw i32 %9, 256
  %11 = load i32* %tid, align 4
  %12 = add i32 %10, %11
  %13 = load i32 addrspace(1)** %1, align 4
  %14 = getelementptr inbounds i32 addrspace(1)* %13, i32 %12
  %15 = load i32 addrspace(1)* %14, align 4
  %16 = load i32* %i, align 4
  %17 = mul nsw i32 %16, 256
  %18 = load i32* %tid, align 4
  %19 = add i32 %17, %18
  %20 = add i32 %19, 256
  %21 = load i32 addrspace(1)** %1, align 4
  %22 = getelementptr inbounds i32 addrspace(1)* %21, i32 %20
  %23 = load i32 addrspace(1)* %22, align 4
  %24 = add i32 %15, %23
  %25 = load i32* %i, align 4
  %26 = mul nsw i32 %25, 256
  %27 = load i32* %tid, align 4
  %28 = add i32 %26, %27
  %29 = add i32 %28, 512
  %30 = load i32 addrspace(1)** %1, align 4
  %31 = getelementptr inbounds i32 addrspace(1)* %30, i32 %29
  %32 = load i32 addrspace(1)* %31, align 4
  %33 = add i32 %24, %32
  %34 = load i32* %i, align 4
  %35 = mul nsw i32 %34, 256
  %36 = load i32* %tid, align 4
  %37 = add i32 %35, %36
  %38 = add i32 %37, 768
  %39 = load i32 addrspace(1)** %1, align 4
  %40 = getelementptr inbounds i32 addrspace(1)* %39, i32 %38
  %41 = load i32 addrspace(1)* %40, align 4
  %42 = add i32 %33, %41
  %43 = load i32* %bin, align 4
  %44 = add i32 %43, %42
  store i32 %44, i32* %bin, align 4
  br label %45

; <label>:45                                      ; preds = %8
  %46 = load i32* %i, align 4
  %47 = add nsw i32 %46, 4
  store i32 %47, i32* %i, align 4
  br label %4

; <label>:48                                      ; preds = %4
  %49 = load i32* %bin, align 4
  %50 = load i32* %tid, align 4
  %51 = load i32 addrspace(1)** %1, align 4
  %52 = getelementptr inbounds i32 addrspace(1)* %51, i32 %50
  store i32 %49, i32 addrspace(1)* %52, align 4
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32)* @histogramKernel_Vector}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @histogramKernel_Scalar}
!2 = metadata !{void (i32 addrspace(1)*, i32)* @reduceKernel}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

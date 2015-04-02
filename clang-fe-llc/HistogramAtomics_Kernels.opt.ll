; ModuleID = 'HistogramAtomics_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@histogramKernel_Vector.subhists = internal addrspace(3) global [4096 x i32] zeroinitializer, align 4
@histogramKernel_Scalar.subhists = internal addrspace(3) global [1024 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @histogramKernel_Vector(<4 x i32> addrspace(1)* %Image, i32 addrspace(1)* %Histogram, i32 %n4VectorsPerThread) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_local_id(i32 0)
  %3 = call i32 @get_global_size(i32 0)
  %4 = call i32 @get_local_size(i32 0)
  %5 = urem i32 %2, 16
  br label %6

; <label>:6                                       ; preds = %11, %0
  %i.0 = phi i32 [ %2, %0 ], [ %12, %11 ]
  %7 = udiv i32 4096, 4
  %8 = icmp ult i32 %i.0, %7
  br i1 %8, label %9, label %13

; <label>:9                                       ; preds = %6
  %10 = getelementptr inbounds <4 x i32> addrspace(3)* bitcast ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists to <4 x i32> addrspace(3)*), i32 %i.0
  store <4 x i32> zeroinitializer, <4 x i32> addrspace(3)* %10, align 16
  br label %11

; <label>:11                                      ; preds = %9
  %12 = add i32 %i.0, %4
  br label %6

; <label>:13                                      ; preds = %6
  call void @barrier(i32 1)
  br label %14

; <label>:14                                      ; preds = %92, %13
  %i.1 = phi i32 [ 0, %13 ], [ %93, %92 ]
  %15 = icmp ult i32 %i.1, %n4VectorsPerThread
  br i1 %15, label %16, label %94

; <label>:16                                      ; preds = %14
  %17 = mul i32 %i.1, %3
  %18 = add i32 %1, %17
  %19 = getelementptr inbounds <4 x i32> addrspace(1)* %Image, i32 %18
  %20 = load <4 x i32> addrspace(1)* %19, align 16
  %21 = and <4 x i32> %20, <i32 255, i32 255, i32 255, i32 255>
  %22 = mul <4 x i32> %21, <i32 16, i32 16, i32 16, i32 16>
  %23 = insertelement <4 x i32> undef, i32 %5, i32 0
  %24 = shufflevector <4 x i32> %23, <4 x i32> undef, <4 x i32> zeroinitializer
  %25 = add <4 x i32> %22, %24
  %26 = extractelement <4 x i32> %25, i32 0
  %27 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %26
  %28 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %27)
  %29 = extractelement <4 x i32> %25, i32 1
  %30 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %29
  %31 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %30)
  %32 = extractelement <4 x i32> %25, i32 2
  %33 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %32
  %34 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %33)
  %35 = extractelement <4 x i32> %25, i32 3
  %36 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %35
  %37 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %36)
  %38 = lshr <4 x i32> %20, <i32 8, i32 8, i32 8, i32 8>
  %39 = and <4 x i32> %38, <i32 255, i32 255, i32 255, i32 255>
  %40 = mul <4 x i32> %39, <i32 16, i32 16, i32 16, i32 16>
  %41 = insertelement <4 x i32> undef, i32 %5, i32 0
  %42 = shufflevector <4 x i32> %41, <4 x i32> undef, <4 x i32> zeroinitializer
  %43 = add <4 x i32> %40, %42
  %44 = extractelement <4 x i32> %43, i32 0
  %45 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %44
  %46 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %45)
  %47 = extractelement <4 x i32> %43, i32 1
  %48 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %47
  %49 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %48)
  %50 = extractelement <4 x i32> %43, i32 2
  %51 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %50
  %52 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %51)
  %53 = extractelement <4 x i32> %43, i32 3
  %54 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %53
  %55 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %54)
  %56 = lshr <4 x i32> %38, <i32 8, i32 8, i32 8, i32 8>
  %57 = and <4 x i32> %56, <i32 255, i32 255, i32 255, i32 255>
  %58 = mul <4 x i32> %57, <i32 16, i32 16, i32 16, i32 16>
  %59 = insertelement <4 x i32> undef, i32 %5, i32 0
  %60 = shufflevector <4 x i32> %59, <4 x i32> undef, <4 x i32> zeroinitializer
  %61 = add <4 x i32> %58, %60
  %62 = extractelement <4 x i32> %61, i32 0
  %63 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %62
  %64 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %63)
  %65 = extractelement <4 x i32> %61, i32 1
  %66 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %65
  %67 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %66)
  %68 = extractelement <4 x i32> %61, i32 2
  %69 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %68
  %70 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %69)
  %71 = extractelement <4 x i32> %61, i32 3
  %72 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %71
  %73 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %72)
  %74 = lshr <4 x i32> %56, <i32 8, i32 8, i32 8, i32 8>
  %75 = and <4 x i32> %74, <i32 255, i32 255, i32 255, i32 255>
  %76 = mul <4 x i32> %75, <i32 16, i32 16, i32 16, i32 16>
  %77 = insertelement <4 x i32> undef, i32 %5, i32 0
  %78 = shufflevector <4 x i32> %77, <4 x i32> undef, <4 x i32> zeroinitializer
  %79 = add <4 x i32> %76, %78
  %80 = extractelement <4 x i32> %79, i32 0
  %81 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %80
  %82 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %81)
  %83 = extractelement <4 x i32> %79, i32 1
  %84 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %83
  %85 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %84)
  %86 = extractelement <4 x i32> %79, i32 2
  %87 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %86
  %88 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %87)
  %89 = extractelement <4 x i32> %79, i32 3
  %90 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 0), i32 %89
  %91 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %90)
  br label %92

; <label>:92                                      ; preds = %16
  %93 = add i32 %i.1, 1
  br label %14

; <label>:94                                      ; preds = %14
  call void @barrier(i32 1)
  br label %95

; <label>:95                                      ; preds = %115, %94
  %i.2 = phi i32 [ %2, %94 ], [ %116, %115 ]
  %96 = icmp ult i32 %i.2, 256
  br i1 %96, label %97, label %117

; <label>:97                                      ; preds = %95
  br label %98

; <label>:98                                      ; preds = %107, %97
  %bin.0 = phi i32 [ 0, %97 ], [ %106, %107 ]
  %off.0 = phi i32 [ %5, %97 ], [ %109, %107 ]
  %j.0 = phi i32 [ 0, %97 ], [ %108, %107 ]
  %99 = icmp slt i32 %j.0, 16
  br i1 %99, label %100, label %110

; <label>:100                                     ; preds = %98
  %101 = mul i32 %i.2, 16
  %102 = urem i32 %off.0, 16
  %103 = add i32 %101, %102
  %104 = getelementptr inbounds [4096 x i32] addrspace(3)* @histogramKernel_Vector.subhists, i32 0, i32 %103
  %105 = load i32 addrspace(3)* %104, align 4
  %106 = add i32 %bin.0, %105
  br label %107

; <label>:107                                     ; preds = %100
  %108 = add nsw i32 %j.0, 1
  %109 = add i32 %off.0, 1
  br label %98

; <label>:110                                     ; preds = %98
  %111 = call i32 @get_group_id(i32 0)
  %112 = mul i32 %111, 256
  %113 = add i32 %112, %i.2
  %114 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %113
  store i32 %bin.0, i32 addrspace(1)* %114, align 4
  br label %115

; <label>:115                                     ; preds = %110
  %116 = add i32 %i.2, %4
  br label %95

; <label>:117                                     ; preds = %95
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
define void @histogramKernel_Scalar(i32 addrspace(1)* %Image, i32 addrspace(1)* %Histogram, i32 %nVectorsPerThread) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_local_id(i32 0)
  %3 = call i32 @get_global_size(i32 0)
  %4 = call i32 @get_local_size(i32 0)
  %5 = urem i32 %2, 4
  br label %6

; <label>:6                                       ; preds = %10, %0
  %i.0 = phi i32 [ %2, %0 ], [ %11, %10 ]
  %7 = icmp ult i32 %i.0, 1024
  br i1 %7, label %8, label %12

; <label>:8                                       ; preds = %6
  %9 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %i.0
  store i32 0, i32 addrspace(3)* %9, align 4
  br label %10

; <label>:10                                      ; preds = %8
  %11 = add i32 %i.0, %4
  br label %6

; <label>:12                                      ; preds = %6
  call void @barrier(i32 1)
  br label %13

; <label>:13                                      ; preds = %43, %12
  %i.1 = phi i32 [ 0, %12 ], [ %44, %43 ]
  %14 = icmp ult i32 %i.1, %nVectorsPerThread
  br i1 %14, label %15, label %45

; <label>:15                                      ; preds = %13
  %16 = mul i32 %i.1, %3
  %17 = add i32 %1, %16
  %18 = getelementptr inbounds i32 addrspace(1)* %Image, i32 %17
  %19 = load i32 addrspace(1)* %18, align 4
  %20 = and i32 %19, 255
  %21 = mul i32 %20, 4
  %22 = add i32 %21, %5
  %23 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %22
  %24 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %23)
  %25 = lshr i32 %19, 8
  %26 = and i32 %25, 255
  %27 = mul i32 %26, 4
  %28 = add i32 %27, %5
  %29 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %28
  %30 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %29)
  %31 = lshr i32 %25, 8
  %32 = and i32 %31, 255
  %33 = mul i32 %32, 4
  %34 = add i32 %33, %5
  %35 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %34
  %36 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %35)
  %37 = lshr i32 %31, 8
  %38 = and i32 %37, 255
  %39 = mul i32 %38, 4
  %40 = add i32 %39, %5
  %41 = getelementptr inbounds i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 0), i32 %40
  %42 = call i32 @_Z8atom_incPU3AS3j(i32 addrspace(3)* %41)
  br label %43

; <label>:43                                      ; preds = %15
  %44 = add i32 %i.1, 1
  br label %13

; <label>:45                                      ; preds = %13
  call void @barrier(i32 1)
  br label %46

; <label>:46                                      ; preds = %66, %45
  %i.2 = phi i32 [ %2, %45 ], [ %67, %66 ]
  %47 = icmp ult i32 %i.2, 256
  br i1 %47, label %48, label %68

; <label>:48                                      ; preds = %46
  br label %49

; <label>:49                                      ; preds = %58, %48
  %bin.0 = phi i32 [ 0, %48 ], [ %57, %58 ]
  %off.0 = phi i32 [ %5, %48 ], [ %60, %58 ]
  %j1.0 = phi i32 [ 0, %48 ], [ %59, %58 ]
  %50 = icmp slt i32 %j1.0, 4
  br i1 %50, label %51, label %61

; <label>:51                                      ; preds = %49
  %52 = mul i32 %i.2, 4
  %53 = urem i32 %off.0, 4
  %54 = add i32 %52, %53
  %55 = getelementptr inbounds [1024 x i32] addrspace(3)* @histogramKernel_Scalar.subhists, i32 0, i32 %54
  %56 = load i32 addrspace(3)* %55, align 4
  %57 = add i32 %bin.0, %56
  br label %58

; <label>:58                                      ; preds = %51
  %59 = add nsw i32 %j1.0, 1
  %60 = add i32 %off.0, 1
  br label %49

; <label>:61                                      ; preds = %49
  %62 = call i32 @get_group_id(i32 0)
  %63 = mul i32 %62, 256
  %64 = add i32 %63, %i.2
  %65 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %64
  store i32 %bin.0, i32 addrspace(1)* %65, align 4
  br label %66

; <label>:66                                      ; preds = %61
  %67 = add i32 %i.2, %4
  br label %46

; <label>:68                                      ; preds = %46
  ret void
}

; Function Attrs: nounwind
define void @reduceKernel(i32 addrspace(1)* %Histogram, i32 %nSubHists) #0 {
  %1 = call i32 @get_global_id(i32 0)
  br label %2

; <label>:2                                       ; preds = %28, %0
  %bin.0 = phi i32 [ 0, %0 ], [ %27, %28 ]
  %i.0 = phi i32 [ 0, %0 ], [ %29, %28 ]
  %3 = icmp ult i32 %i.0, %nSubHists
  br i1 %3, label %4, label %30

; <label>:4                                       ; preds = %2
  %5 = mul nsw i32 %i.0, 256
  %6 = add i32 %5, %1
  %7 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %6
  %8 = load i32 addrspace(1)* %7, align 4
  %9 = mul nsw i32 %i.0, 256
  %10 = add i32 %9, %1
  %11 = add i32 %10, 256
  %12 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %11
  %13 = load i32 addrspace(1)* %12, align 4
  %14 = add i32 %8, %13
  %15 = mul nsw i32 %i.0, 256
  %16 = add i32 %15, %1
  %17 = add i32 %16, 512
  %18 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %17
  %19 = load i32 addrspace(1)* %18, align 4
  %20 = add i32 %14, %19
  %21 = mul nsw i32 %i.0, 256
  %22 = add i32 %21, %1
  %23 = add i32 %22, 768
  %24 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %23
  %25 = load i32 addrspace(1)* %24, align 4
  %26 = add i32 %20, %25
  %27 = add i32 %bin.0, %26
  br label %28

; <label>:28                                      ; preds = %4
  %29 = add nsw i32 %i.0, 4
  br label %2

; <label>:30                                      ; preds = %2
  %31 = getelementptr inbounds i32 addrspace(1)* %Histogram, i32 %1
  store i32 %bin.0, i32 addrspace(1)* %31, align 4
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

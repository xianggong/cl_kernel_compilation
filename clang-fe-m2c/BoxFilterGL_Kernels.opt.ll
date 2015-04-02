; ModuleID = 'BoxFilterGL_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @box_filter(<4 x i32> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %N) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = call i32 @__get_global_size_u32(i32 0)
  %4 = call i32 @__get_global_size_u32(i32 1)
  %5 = sub nsw i32 %N, 1
  %6 = sdiv i32 %5, 2
  %7 = icmp slt i32 %1, %6
  br i1 %7, label %18, label %8

; <label>:8                                       ; preds = %0
  %9 = icmp slt i32 %2, %6
  br i1 %9, label %18, label %10

; <label>:10                                      ; preds = %8
  %11 = sub nsw i32 %3, %6
  %12 = sub nsw i32 %11, 1
  %13 = icmp sgt i32 %1, %12
  br i1 %13, label %18, label %14

; <label>:14                                      ; preds = %10
  %15 = sub nsw i32 %4, %6
  %16 = sub nsw i32 %15, 1
  %17 = icmp sgt i32 %2, %16
  br i1 %17, label %18, label %22

; <label>:18                                      ; preds = %14, %10, %8, %0
  %19 = mul nsw i32 %2, %3
  %20 = add nsw i32 %1, %19
  %21 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %20
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %21, align 4
  br label %111

; <label>:22                                      ; preds = %14
  %23 = mul nsw i32 %N, %N
  %24 = insertelement <4 x i32> undef, i32 %23, i32 0
  %25 = shufflevector <4 x i32> %24, <4 x i32> undef, <4 x i32> zeroinitializer
  %26 = sub nsw i32 %1, %6
  %27 = insertelement <2 x i32> undef, i32 %26, i32 0
  %28 = sub nsw i32 %2, %6
  %29 = insertelement <2 x i32> %27, i32 %28, i32 1
  %30 = add nsw i32 %1, %6
  %31 = insertelement <2 x i32> undef, i32 %30, i32 0
  %32 = sub nsw i32 %2, %6
  %33 = insertelement <2 x i32> %31, i32 %32, i32 1
  %34 = add nsw i32 %1, %6
  %35 = insertelement <2 x i32> undef, i32 %34, i32 0
  %36 = add nsw i32 %2, %6
  %37 = insertelement <2 x i32> %35, i32 %36, i32 1
  %38 = sub nsw i32 %1, %6
  %39 = insertelement <2 x i32> undef, i32 %38, i32 0
  %40 = add nsw i32 %2, %6
  %41 = insertelement <2 x i32> %39, i32 %40, i32 1
  %42 = extractelement <2 x i32> %29, i32 0
  %43 = sub nsw i32 %42, 1
  %44 = insertelement <2 x i32> %29, i32 %43, i32 0
  %45 = extractelement <2 x i32> %44, i32 1
  %46 = sub nsw i32 %45, 1
  %47 = insertelement <2 x i32> %44, i32 %46, i32 1
  %48 = extractelement <2 x i32> %33, i32 1
  %49 = sub nsw i32 %48, 1
  %50 = insertelement <2 x i32> %33, i32 %49, i32 1
  %51 = extractelement <2 x i32> %41, i32 0
  %52 = sub nsw i32 %51, 1
  %53 = insertelement <2 x i32> %41, i32 %52, i32 0
  %54 = extractelement <2 x i32> %47, i32 0
  %55 = icmp sge i32 %54, 0
  br i1 %55, label %56, label %67

; <label>:56                                      ; preds = %22
  %57 = extractelement <2 x i32> %47, i32 1
  %58 = icmp sge i32 %57, 0
  br i1 %58, label %59, label %67

; <label>:59                                      ; preds = %56
  %60 = extractelement <2 x i32> %47, i32 0
  %61 = extractelement <2 x i32> %47, i32 1
  %62 = mul nsw i32 %61, %3
  %63 = add nsw i32 %60, %62
  %64 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %63
  %65 = load <4 x i32> addrspace(1)* %64, align 16
  %66 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %65)
  br label %67

; <label>:67                                      ; preds = %59, %56, %22
  %sumA.0 = phi <4 x i32> [ %66, %59 ], [ zeroinitializer, %56 ], [ zeroinitializer, %22 ]
  %68 = extractelement <2 x i32> %50, i32 0
  %69 = icmp sge i32 %68, 0
  br i1 %69, label %70, label %81

; <label>:70                                      ; preds = %67
  %71 = extractelement <2 x i32> %50, i32 1
  %72 = icmp sge i32 %71, 0
  br i1 %72, label %73, label %81

; <label>:73                                      ; preds = %70
  %74 = extractelement <2 x i32> %50, i32 0
  %75 = extractelement <2 x i32> %50, i32 1
  %76 = mul nsw i32 %75, %3
  %77 = add nsw i32 %74, %76
  %78 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %77
  %79 = load <4 x i32> addrspace(1)* %78, align 16
  %80 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %79)
  br label %81

; <label>:81                                      ; preds = %73, %70, %67
  %sumB.0 = phi <4 x i32> [ %80, %73 ], [ zeroinitializer, %70 ], [ zeroinitializer, %67 ]
  %82 = extractelement <2 x i32> %53, i32 0
  %83 = icmp sge i32 %82, 0
  br i1 %83, label %84, label %95

; <label>:84                                      ; preds = %81
  %85 = extractelement <2 x i32> %53, i32 1
  %86 = icmp sge i32 %85, 0
  br i1 %86, label %87, label %95

; <label>:87                                      ; preds = %84
  %88 = extractelement <2 x i32> %53, i32 0
  %89 = extractelement <2 x i32> %53, i32 1
  %90 = mul nsw i32 %89, %3
  %91 = add nsw i32 %88, %90
  %92 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %91
  %93 = load <4 x i32> addrspace(1)* %92, align 16
  %94 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %93)
  br label %95

; <label>:95                                      ; preds = %87, %84, %81
  %sumD.0 = phi <4 x i32> [ %94, %87 ], [ zeroinitializer, %84 ], [ zeroinitializer, %81 ]
  %96 = extractelement <2 x i32> %37, i32 0
  %97 = extractelement <2 x i32> %37, i32 1
  %98 = mul nsw i32 %97, %3
  %99 = add nsw i32 %96, %98
  %100 = getelementptr inbounds <4 x i32> addrspace(1)* %inputImage, i32 %99
  %101 = load <4 x i32> addrspace(1)* %100, align 16
  %102 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %101)
  %103 = add <4 x i32> %sumA.0, %102
  %104 = sub <4 x i32> %103, %sumB.0
  %105 = sub <4 x i32> %104, %sumD.0
  %106 = sdiv <4 x i32> %105, %25
  %107 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %106)
  %108 = mul nsw i32 %2, %3
  %109 = add nsw i32 %1, %108
  %110 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %109
  store <4 x i8> %107, <4 x i8> addrspace(1)* %110, align 4
  br label %111

; <label>:111                                     ; preds = %95, %18
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32>) #1

declare <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind
define void @horizontalSAT0(<4 x i8> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = mul nsw i32 %2, %width
  %4 = add nsw i32 %1, %3
  %5 = sitofp i32 %r to float
  %6 = sitofp i32 %i to float
  %7 = call float @llvm.pow.f32(float %5, float %6)
  %8 = fptosi float %7 to i32
  br label %9

; <label>:9                                       ; preds = %24, %0
  %sum.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %23, %24 ]
  %j.0 = phi i32 [ 0, %0 ], [ %25, %24 ]
  %10 = icmp slt i32 %j.0, %r
  br i1 %10, label %11, label %26

; <label>:11                                      ; preds = %9
  %12 = mul nsw i32 %j.0, %8
  %13 = sub nsw i32 %1, %12
  %14 = icmp slt i32 %13, 0
  br i1 %14, label %15, label %17

; <label>:15                                      ; preds = %11
  %16 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %4
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %16, align 16
  br label %28

; <label>:17                                      ; preds = %11
  %18 = mul nsw i32 %j.0, %8
  %19 = sub nsw i32 %4, %18
  %20 = getelementptr inbounds <4 x i8> addrspace(1)* %input, i32 %19
  %21 = load <4 x i8> addrspace(1)* %20, align 4
  %22 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %21)
  %23 = add <4 x i32> %sum.0, %22
  br label %24

; <label>:24                                      ; preds = %17
  %25 = add nsw i32 %j.0, 1
  br label %9

; <label>:26                                      ; preds = %9
  %27 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %4
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %27, align 16
  br label %28

; <label>:28                                      ; preds = %26, %15
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #2

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @horizontalSAT(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = mul nsw i32 %2, %width
  %4 = add nsw i32 %1, %3
  %5 = sitofp i32 %r to float
  %6 = sitofp i32 %i to float
  %7 = call float @llvm.pow.f32(float %5, float %6)
  %8 = fptosi float %7 to i32
  br label %9

; <label>:9                                       ; preds = %23, %0
  %sum.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %22, %23 ]
  %j.0 = phi i32 [ 0, %0 ], [ %24, %23 ]
  %10 = icmp slt i32 %j.0, %r
  br i1 %10, label %11, label %25

; <label>:11                                      ; preds = %9
  %12 = mul nsw i32 %j.0, %8
  %13 = sub nsw i32 %1, %12
  %14 = icmp slt i32 %13, 0
  br i1 %14, label %15, label %17

; <label>:15                                      ; preds = %11
  %16 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %4
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %16, align 16
  br label %27

; <label>:17                                      ; preds = %11
  %18 = mul nsw i32 %j.0, %8
  %19 = sub nsw i32 %4, %18
  %20 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %19
  %21 = load <4 x i32> addrspace(1)* %20, align 16
  %22 = add <4 x i32> %sum.0, %21
  br label %23

; <label>:23                                      ; preds = %17
  %24 = add nsw i32 %j.0, 1
  br label %9

; <label>:25                                      ; preds = %9
  %26 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %4
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %26, align 16
  br label %27

; <label>:27                                      ; preds = %25, %15
  ret void
}

; Function Attrs: nounwind
define void @verticalSAT(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = sitofp i32 %r to float
  %4 = sitofp i32 %i to float
  %5 = call float @llvm.pow.f32(float %3, float %4)
  %6 = fptosi float %5 to i32
  br label %7

; <label>:7                                       ; preds = %25, %0
  %sum.0 = phi <4 x i32> [ zeroinitializer, %0 ], [ %24, %25 ]
  %j.0 = phi i32 [ 0, %0 ], [ %26, %25 ]
  %8 = icmp slt i32 %j.0, %r
  br i1 %8, label %9, label %27

; <label>:9                                       ; preds = %7
  %10 = mul nsw i32 %j.0, %6
  %11 = sub nsw i32 %2, %10
  %12 = icmp slt i32 %11, 0
  br i1 %12, label %13, label %17

; <label>:13                                      ; preds = %9
  %14 = mul nsw i32 %2, %width
  %15 = add nsw i32 %1, %14
  %16 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %15
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %16, align 16
  br label %31

; <label>:17                                      ; preds = %9
  %18 = mul nsw i32 %j.0, %6
  %19 = sub nsw i32 %2, %18
  %20 = mul nsw i32 %width, %19
  %21 = add nsw i32 %1, %20
  %22 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %21
  %23 = load <4 x i32> addrspace(1)* %22, align 16
  %24 = add <4 x i32> %sum.0, %23
  br label %25

; <label>:25                                      ; preds = %17
  %26 = add nsw i32 %j.0, 1
  br label %7

; <label>:27                                      ; preds = %7
  %28 = mul nsw i32 %2, %width
  %29 = add nsw i32 %1, %28
  %30 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %29
  store <4 x i32> %sum.0, <4 x i32> addrspace(1)* %30, align 16
  br label %31

; <label>:31                                      ; preds = %27, %13
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = call i32 @__get_global_size_u32(i32 0)
  %4 = call i32 @__get_global_size_u32(i32 1)
  %5 = mul nsw i32 %2, %3
  %6 = add nsw i32 %1, %5
  %7 = sub nsw i32 %filterWidth, 1
  %8 = sdiv i32 %7, 2
  %9 = icmp slt i32 %1, %8
  br i1 %9, label %13, label %10

; <label>:10                                      ; preds = %0
  %11 = sub nsw i32 %3, %8
  %12 = icmp sge i32 %1, %11
  br i1 %12, label %13, label %15

; <label>:13                                      ; preds = %10, %0
  %14 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %14, align 4
  br label %44

; <label>:15                                      ; preds = %10
  %16 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %17 = shufflevector <4 x i32> %16, <4 x i32> undef, <4 x i32> zeroinitializer
  %18 = sub nsw i32 0, %8
  br label %19

; <label>:19                                      ; preds = %33, %15
  %sum.0 = phi <4 x i32> [ zeroinitializer, %15 ], [ %32, %33 ]
  %X.0 = phi i32 [ %18, %15 ], [ %34, %33 ]
  %20 = icmp slt i32 %X.0, %8
  br i1 %20, label %21, label %35

; <label>:21                                      ; preds = %19
  %22 = add nsw i32 %6, %X.0
  %23 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %22
  %24 = load <4 x i8> addrspace(1)* %23, align 4
  %25 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %24)
  %26 = add <4 x i32> %sum.0, %25
  %27 = add nsw i32 %6, %X.0
  %28 = add nsw i32 %27, 1
  %29 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %28
  %30 = load <4 x i8> addrspace(1)* %29, align 4
  %31 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %30)
  %32 = add <4 x i32> %26, %31
  br label %33

; <label>:33                                      ; preds = %21
  %34 = add nsw i32 %X.0, 2
  br label %19

; <label>:35                                      ; preds = %19
  %36 = add nsw i32 %6, %8
  %37 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %36
  %38 = load <4 x i8> addrspace(1)* %37, align 4
  %39 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %38)
  %40 = add <4 x i32> %sum.0, %39
  %41 = sdiv <4 x i32> %40, %17
  %42 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %41)
  %43 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> %42, <4 x i8> addrspace(1)* %43, align 4
  br label %44

; <label>:44                                      ; preds = %35, %13
  ret void
}

declare <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @box_filter_vertical(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = call i32 @__get_global_size_u32(i32 0)
  %4 = call i32 @__get_global_size_u32(i32 1)
  %5 = mul nsw i32 %2, %3
  %6 = add nsw i32 %1, %5
  %7 = sub nsw i32 %filterWidth, 1
  %8 = sdiv i32 %7, 2
  %9 = icmp slt i32 %2, %8
  br i1 %9, label %13, label %10

; <label>:10                                      ; preds = %0
  %11 = sub nsw i32 %4, %8
  %12 = icmp sge i32 %2, %11
  br i1 %12, label %13, label %15

; <label>:13                                      ; preds = %10, %0
  %14 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %14, align 4
  br label %47

; <label>:15                                      ; preds = %10
  %16 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %17 = shufflevector <4 x i32> %16, <4 x i32> undef, <4 x i32> zeroinitializer
  %18 = sub nsw i32 0, %8
  br label %19

; <label>:19                                      ; preds = %35, %15
  %sum.0 = phi <4 x i32> [ zeroinitializer, %15 ], [ %34, %35 ]
  %Y.0 = phi i32 [ %18, %15 ], [ %36, %35 ]
  %20 = icmp slt i32 %Y.0, %8
  br i1 %20, label %21, label %37

; <label>:21                                      ; preds = %19
  %22 = mul nsw i32 %Y.0, %3
  %23 = add nsw i32 %6, %22
  %24 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %23
  %25 = load <4 x i8> addrspace(1)* %24, align 4
  %26 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %25)
  %27 = add <4 x i32> %sum.0, %26
  %28 = add nsw i32 %Y.0, 1
  %29 = mul nsw i32 %28, %3
  %30 = add nsw i32 %6, %29
  %31 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %30
  %32 = load <4 x i8> addrspace(1)* %31, align 4
  %33 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %32)
  %34 = add <4 x i32> %27, %33
  br label %35

; <label>:35                                      ; preds = %21
  %36 = add nsw i32 %Y.0, 2
  br label %19

; <label>:37                                      ; preds = %19
  %38 = mul nsw i32 %8, %3
  %39 = add nsw i32 %6, %38
  %40 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %39
  %41 = load <4 x i8> addrspace(1)* %40, align 4
  %42 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %41)
  %43 = add <4 x i32> %sum.0, %42
  %44 = sdiv <4 x i32> %43, %17
  %45 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %44)
  %46 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> %45, <4 x i8> addrspace(1)* %46, align 4
  br label %47

; <label>:47                                      ; preds = %37, %13
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal_local(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth, <4 x i8> addrspace(3)* %lds) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = call i32 @__get_global_size_u32(i32 0)
  %4 = call i32 @__get_global_size_u32(i32 1)
  %5 = mul nsw i32 %2, %3
  %6 = add nsw i32 %1, %5
  %7 = sub nsw i32 %filterWidth, 1
  %8 = sdiv i32 %7, 2
  %9 = call i32 @__get_local_id_u32(i32 0)
  %10 = call i32 @__get_group_id_u32(i32 0)
  %11 = call i32 @__get_group_id_u32(i32 1)
  %12 = call i32 @__get_local_size_u32(i32 0)
  %13 = call i32 @__get_local_size_u32(i32 1)
  %14 = mul nsw i32 %12, %10
  %15 = mul nsw i32 %3, %11
  %16 = mul nsw i32 %15, %13
  %17 = add nsw i32 %14, %16
  %18 = icmp slt i32 %9, %8
  br i1 %18, label %19, label %32

; <label>:19                                      ; preds = %0
  %20 = sub nsw i32 %17, %8
  %21 = add nsw i32 %20, %9
  %22 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %21
  %23 = load <4 x i8> addrspace(1)* %22, align 4
  %24 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %9
  store <4 x i8> %23, <4 x i8> addrspace(3)* %24, align 4
  %25 = add nsw i32 %17, %9
  %26 = add nsw i32 %25, 256
  %27 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %26
  %28 = load <4 x i8> addrspace(1)* %27, align 4
  %29 = add nsw i32 256, %8
  %30 = add nsw i32 %29, %9
  %31 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %30
  store <4 x i8> %28, <4 x i8> addrspace(3)* %31, align 4
  br label %32

; <label>:32                                      ; preds = %19, %0
  %33 = add nsw i32 %17, %9
  %34 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %33
  %35 = load <4 x i8> addrspace(1)* %34, align 4
  %36 = add nsw i32 %9, %8
  %37 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %36
  store <4 x i8> %35, <4 x i8> addrspace(3)* %37, align 4
  call void @barrier(i32 1)
  %38 = icmp slt i32 %1, %8
  br i1 %38, label %42, label %39

; <label>:39                                      ; preds = %32
  %40 = sub nsw i32 %3, %8
  %41 = icmp sge i32 %1, %40
  br i1 %41, label %42, label %43

; <label>:42                                      ; preds = %39, %32
  br label %62

; <label>:43                                      ; preds = %39
  %44 = insertelement <4 x i32> undef, i32 %filterWidth, i32 0
  %45 = shufflevector <4 x i32> %44, <4 x i32> undef, <4 x i32> zeroinitializer
  %46 = sub nsw i32 0, %8
  br label %47

; <label>:47                                      ; preds = %56, %43
  %sum.0 = phi <4 x i32> [ zeroinitializer, %43 ], [ %55, %56 ]
  %X.0 = phi i32 [ %46, %43 ], [ %57, %56 ]
  %48 = icmp sle i32 %X.0, %8
  br i1 %48, label %49, label %58

; <label>:49                                      ; preds = %47
  %50 = add nsw i32 %9, %X.0
  %51 = add nsw i32 %50, %8
  %52 = getelementptr inbounds <4 x i8> addrspace(3)* %lds, i32 %51
  %53 = load <4 x i8> addrspace(3)* %52, align 4
  %54 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %53)
  %55 = add <4 x i32> %sum.0, %54
  br label %56

; <label>:56                                      ; preds = %49
  %57 = add nsw i32 %X.0, 1
  br label %47

; <label>:58                                      ; preds = %47
  %59 = sdiv <4 x i32> %sum.0, %45
  %60 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %59)
  %61 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> %60, <4 x i8> addrspace(1)* %61, align 4
  br label %62

; <label>:62                                      ; preds = %58, %42
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter}
!1 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT0}
!2 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT}
!3 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @verticalSAT}
!4 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_horizontal}
!5 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_vertical}
!6 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, <4 x i8> addrspace(3)*)* @box_filter_horizontal_local}
!7 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

; ModuleID = 'Histogram_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram256_vector(<4 x i32> addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
  %1 = call i32 @__get_local_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 0)
  %3 = call i32 @__get_group_id_u32(i32 0)
  %4 = call i32 @__get_local_size_u32(i32 0)
  %5 = and i32 %1, 31
  %6 = mul nsw i32 4, %5
  %7 = lshr i32 %1, 5
  %8 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %9

; <label>:9                                       ; preds = %15, %0
  %i.0 = phi i32 [ 0, %0 ], [ %16, %15 ]
  %10 = icmp slt i32 %i.0, 64
  br i1 %10, label %11, label %17

; <label>:11                                      ; preds = %9
  %12 = mul i32 %4, %i.0
  %13 = add i32 %12, %1
  %14 = getelementptr inbounds <4 x i8> addrspace(3)* %8, i32 %13
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %14, align 4
  br label %15

; <label>:15                                      ; preds = %11
  %16 = add nsw i32 %i.0, 1
  br label %9

; <label>:17                                      ; preds = %9
  call void @barrier(i32 1)
  br label %18

; <label>:18                                      ; preds = %57, %17
  %i1.0 = phi i32 [ 0, %17 ], [ %58, %57 ]
  %19 = icmp slt i32 %i1.0, 32
  br i1 %19, label %20, label %59

; <label>:20                                      ; preds = %18
  %21 = mul i32 %4, 256
  %22 = udiv i32 %21, 8
  %23 = mul i32 %3, %22
  %24 = mul i32 %i1.0, %4
  %25 = add i32 %23, %24
  %26 = add i32 %25, %1
  %27 = getelementptr inbounds <4 x i32> addrspace(1)* %data, i32 %26
  %28 = load <4 x i32> addrspace(1)* %27, align 16
  %29 = extractelement <4 x i32> %28, i32 0
  %30 = mul i32 %29, 128
  %31 = add i32 %30, %6
  %32 = add i32 %31, %7
  %33 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %32
  %34 = load i8 addrspace(3)* %33, align 1
  %35 = add i8 %34, 1
  store i8 %35, i8 addrspace(3)* %33, align 1
  %36 = extractelement <4 x i32> %28, i32 1
  %37 = mul i32 %36, 128
  %38 = add i32 %37, %6
  %39 = add i32 %38, %7
  %40 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %39
  %41 = load i8 addrspace(3)* %40, align 1
  %42 = add i8 %41, 1
  store i8 %42, i8 addrspace(3)* %40, align 1
  %43 = extractelement <4 x i32> %28, i32 2
  %44 = mul i32 %43, 128
  %45 = add i32 %44, %6
  %46 = add i32 %45, %7
  %47 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %46
  %48 = load i8 addrspace(3)* %47, align 1
  %49 = add i8 %48, 1
  store i8 %49, i8 addrspace(3)* %47, align 1
  %50 = extractelement <4 x i32> %28, i32 3
  %51 = mul i32 %50, 128
  %52 = add i32 %51, %6
  %53 = add i32 %52, %7
  %54 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %53
  %55 = load i8 addrspace(3)* %54, align 1
  %56 = add i8 %55, 1
  store i8 %56, i8 addrspace(3)* %54, align 1
  br label %57

; <label>:57                                      ; preds = %20
  %58 = add nsw i32 %i1.0, 1
  br label %18

; <label>:59                                      ; preds = %18
  call void @barrier(i32 1)
  br label %60

; <label>:60                                      ; preds = %92, %59
  %i2.0 = phi i32 [ 0, %59 ], [ %93, %92 ]
  %61 = udiv i32 256, %4
  %62 = icmp ult i32 %i2.0, %61
  br i1 %62, label %63, label %94

; <label>:63                                      ; preds = %60
  %64 = mul nsw i32 4096, %i2.0
  %65 = mul i32 %1, 32
  %66 = add i32 %64, %65
  br label %67

; <label>:67                                      ; preds = %77, %63
  %binCount.0 = phi <4 x i32> [ zeroinitializer, %63 ], [ %76, %77 ]
  %j.0 = phi i32 [ 0, %63 ], [ %78, %77 ]
  %68 = icmp slt i32 %j.0, 32
  br i1 %68, label %69, label %79

; <label>:69                                      ; preds = %67
  %70 = add nsw i32 %j.0, %5
  %71 = and i32 %70, 31
  %72 = add nsw i32 %66, %71
  %73 = getelementptr inbounds <4 x i8> addrspace(3)* %8, i32 %72
  %74 = load <4 x i8> addrspace(3)* %73, align 4
  %75 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %74)
  %76 = add <4 x i32> %binCount.0, %75
  br label %77

; <label>:77                                      ; preds = %69
  %78 = add nsw i32 %j.0, 1
  br label %67

; <label>:79                                      ; preds = %67
  %80 = extractelement <4 x i32> %binCount.0, i32 0
  %81 = extractelement <4 x i32> %binCount.0, i32 1
  %82 = add i32 %80, %81
  %83 = extractelement <4 x i32> %binCount.0, i32 2
  %84 = add i32 %82, %83
  %85 = extractelement <4 x i32> %binCount.0, i32 3
  %86 = add i32 %84, %85
  %87 = mul i32 %3, 256
  %88 = mul i32 %4, %i2.0
  %89 = add i32 %87, %88
  %90 = add i32 %89, %1
  %91 = getelementptr inbounds i32 addrspace(1)* %binResult, i32 %90
  store i32 %86, i32 addrspace(1)* %91, align 4
  br label %92

; <label>:92                                      ; preds = %79
  %93 = add nsw i32 %i2.0, 1
  br label %60

; <label>:94                                      ; preds = %60
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare void @barrier(i32) #1

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @histogram256_scalar(i32 addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
  %1 = call i32 @__get_local_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 0)
  %3 = call i32 @__get_group_id_u32(i32 0)
  %4 = call i32 @__get_local_size_u32(i32 0)
  %5 = and i32 %1, 31
  %6 = mul nsw i32 4, %5
  %7 = lshr i32 %1, 5
  %8 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %9

; <label>:9                                       ; preds = %15, %0
  %i.0 = phi i32 [ 0, %0 ], [ %16, %15 ]
  %10 = icmp slt i32 %i.0, 64
  br i1 %10, label %11, label %17

; <label>:11                                      ; preds = %9
  %12 = mul i32 %4, %i.0
  %13 = add i32 %12, %1
  %14 = getelementptr inbounds <4 x i8> addrspace(3)* %8, i32 %13
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %14, align 4
  br label %15

; <label>:15                                      ; preds = %11
  %16 = add nsw i32 %i.0, 1
  br label %9

; <label>:17                                      ; preds = %9
  call void @barrier(i32 1)
  br label %18

; <label>:18                                      ; preds = %34, %17
  %i1.0 = phi i32 [ 0, %17 ], [ %35, %34 ]
  %19 = icmp slt i32 %i1.0, 128
  br i1 %19, label %20, label %36

; <label>:20                                      ; preds = %18
  %21 = mul i32 %4, 128
  %22 = mul i32 %3, %21
  %23 = mul i32 %i1.0, %4
  %24 = add i32 %22, %23
  %25 = add i32 %24, %1
  %26 = getelementptr inbounds i32 addrspace(1)* %data, i32 %25
  %27 = load i32 addrspace(1)* %26, align 4
  %28 = mul i32 %27, 128
  %29 = add i32 %28, %6
  %30 = add i32 %29, %7
  %31 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %30
  %32 = load i8 addrspace(3)* %31, align 1
  %33 = add i8 %32, 1
  store i8 %33, i8 addrspace(3)* %31, align 1
  br label %34

; <label>:34                                      ; preds = %20
  %35 = add nsw i32 %i1.0, 1
  br label %18

; <label>:36                                      ; preds = %18
  call void @barrier(i32 1)
  br label %37

; <label>:37                                      ; preds = %69, %36
  %i2.0 = phi i32 [ 0, %36 ], [ %70, %69 ]
  %38 = udiv i32 256, %4
  %39 = icmp ult i32 %i2.0, %38
  br i1 %39, label %40, label %71

; <label>:40                                      ; preds = %37
  %41 = mul nsw i32 4096, %i2.0
  %42 = mul i32 %1, 32
  %43 = add i32 %41, %42
  br label %44

; <label>:44                                      ; preds = %54, %40
  %binCount.0 = phi <4 x i32> [ zeroinitializer, %40 ], [ %53, %54 ]
  %j.0 = phi i32 [ 0, %40 ], [ %55, %54 ]
  %45 = icmp slt i32 %j.0, 32
  br i1 %45, label %46, label %56

; <label>:46                                      ; preds = %44
  %47 = add nsw i32 %j.0, %5
  %48 = and i32 %47, 31
  %49 = add nsw i32 %43, %48
  %50 = getelementptr inbounds <4 x i8> addrspace(3)* %8, i32 %49
  %51 = load <4 x i8> addrspace(3)* %50, align 4
  %52 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %51)
  %53 = add <4 x i32> %binCount.0, %52
  br label %54

; <label>:54                                      ; preds = %46
  %55 = add nsw i32 %j.0, 1
  br label %44

; <label>:56                                      ; preds = %44
  %57 = extractelement <4 x i32> %binCount.0, i32 0
  %58 = extractelement <4 x i32> %binCount.0, i32 1
  %59 = add i32 %57, %58
  %60 = extractelement <4 x i32> %binCount.0, i32 2
  %61 = add i32 %59, %60
  %62 = extractelement <4 x i32> %binCount.0, i32 3
  %63 = add i32 %61, %62
  %64 = mul i32 %3, 256
  %65 = mul i32 %4, %i2.0
  %66 = add i32 %64, %65
  %67 = add i32 %66, %1
  %68 = getelementptr inbounds i32 addrspace(1)* %binResult, i32 %67
  store i32 %63, i32 addrspace(1)* %68, align 4
  br label %69

; <label>:69                                      ; preds = %56
  %70 = add nsw i32 %i2.0, 1
  br label %37

; <label>:71                                      ; preds = %37
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_vector}
!1 = metadata !{void (i32 addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

; ModuleID = '../kernel-src/SimpleConvolution_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @simpleConvolution(i32 addrspace(1)* %output, i32 addrspace(1)* %input, float addrspace(1)* %mask, <2 x i32> %inputDimensions, <2 x i32> %maskDimensions) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %3 = alloca float addrspace(1)*, align 4
  %4 = alloca <2 x i32>, align 8
  %5 = alloca <2 x i32>, align 8
  %tid = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %maskWidth = alloca i32, align 4
  %maskHeight = alloca i32, align 4
  %vstep = alloca i32, align 4
  %hstep = alloca i32, align 4
  %left = alloca i32, align 4
  %right = alloca i32, align 4
  %top = alloca i32, align 4
  %bottom = alloca i32, align 4
  %sumFX = alloca float, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %maskIndex = alloca i32, align 4
  %index = alloca i32, align 4
  store i32 addrspace(1)* %output, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %input, i32 addrspace(1)** %2, align 4
  store float addrspace(1)* %mask, float addrspace(1)** %3, align 4
  store <2 x i32> %inputDimensions, <2 x i32>* %4, align 8
  store <2 x i32> %maskDimensions, <2 x i32>* %5, align 8
  %6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %6, i32* %tid, align 4
  %7 = load <2 x i32>* %4, align 8
  %8 = extractelement <2 x i32> %7, i32 0
  store i32 %8, i32* %width, align 4
  %9 = load <2 x i32>* %4, align 8
  %10 = extractelement <2 x i32> %9, i32 1
  store i32 %10, i32* %height, align 4
  %11 = load i32* %tid, align 4
  %12 = load i32* %width, align 4
  %13 = urem i32 %11, %12
  store i32 %13, i32* %x, align 4
  %14 = load i32* %tid, align 4
  %15 = load i32* %width, align 4
  %16 = udiv i32 %14, %15
  store i32 %16, i32* %y, align 4
  %17 = load <2 x i32>* %5, align 8
  %18 = extractelement <2 x i32> %17, i32 0
  store i32 %18, i32* %maskWidth, align 4
  %19 = load <2 x i32>* %5, align 8
  %20 = extractelement <2 x i32> %19, i32 1
  store i32 %20, i32* %maskHeight, align 4
  %21 = load i32* %maskWidth, align 4
  %22 = sub i32 %21, 1
  %23 = udiv i32 %22, 2
  store i32 %23, i32* %vstep, align 4
  %24 = load i32* %maskHeight, align 4
  %25 = sub i32 %24, 1
  %26 = udiv i32 %25, 2
  store i32 %26, i32* %hstep, align 4
  %27 = load i32* %x, align 4
  %28 = load i32* %vstep, align 4
  %29 = icmp ult i32 %27, %28
  br i1 %29, label %30, label %31

; <label>:30                                      ; preds = %0
  br label %35

; <label>:31                                      ; preds = %0
  %32 = load i32* %x, align 4
  %33 = load i32* %vstep, align 4
  %34 = sub i32 %32, %33
  br label %35

; <label>:35                                      ; preds = %31, %30
  %36 = phi i32 [ 0, %30 ], [ %34, %31 ]
  store i32 %36, i32* %left, align 4
  %37 = load i32* %x, align 4
  %38 = load i32* %vstep, align 4
  %39 = add i32 %37, %38
  %40 = load i32* %width, align 4
  %41 = icmp uge i32 %39, %40
  br i1 %41, label %42, label %45

; <label>:42                                      ; preds = %35
  %43 = load i32* %width, align 4
  %44 = sub i32 %43, 1
  br label %49

; <label>:45                                      ; preds = %35
  %46 = load i32* %x, align 4
  %47 = load i32* %vstep, align 4
  %48 = add i32 %46, %47
  br label %49

; <label>:49                                      ; preds = %45, %42
  %50 = phi i32 [ %44, %42 ], [ %48, %45 ]
  store i32 %50, i32* %right, align 4
  %51 = load i32* %y, align 4
  %52 = load i32* %hstep, align 4
  %53 = icmp ult i32 %51, %52
  br i1 %53, label %54, label %55

; <label>:54                                      ; preds = %49
  br label %59

; <label>:55                                      ; preds = %49
  %56 = load i32* %y, align 4
  %57 = load i32* %hstep, align 4
  %58 = sub i32 %56, %57
  br label %59

; <label>:59                                      ; preds = %55, %54
  %60 = phi i32 [ 0, %54 ], [ %58, %55 ]
  store i32 %60, i32* %top, align 4
  %61 = load i32* %y, align 4
  %62 = load i32* %hstep, align 4
  %63 = add i32 %61, %62
  %64 = load i32* %height, align 4
  %65 = icmp uge i32 %63, %64
  br i1 %65, label %66, label %69

; <label>:66                                      ; preds = %59
  %67 = load i32* %height, align 4
  %68 = sub i32 %67, 1
  br label %73

; <label>:69                                      ; preds = %59
  %70 = load i32* %y, align 4
  %71 = load i32* %hstep, align 4
  %72 = add i32 %70, %71
  br label %73

; <label>:73                                      ; preds = %69, %66
  %74 = phi i32 [ %68, %66 ], [ %72, %69 ]
  store i32 %74, i32* %bottom, align 4
  store float 0.000000e+00, float* %sumFX, align 4
  %75 = load i32* %left, align 4
  store i32 %75, i32* %i, align 4
  br label %76

; <label>:76                                      ; preds = %121, %73
  %77 = load i32* %i, align 4
  %78 = load i32* %right, align 4
  %79 = icmp ule i32 %77, %78
  br i1 %79, label %80, label %124

; <label>:80                                      ; preds = %76
  %81 = load i32* %top, align 4
  store i32 %81, i32* %j, align 4
  br label %82

; <label>:82                                      ; preds = %117, %80
  %83 = load i32* %j, align 4
  %84 = load i32* %bottom, align 4
  %85 = icmp ule i32 %83, %84
  br i1 %85, label %86, label %120

; <label>:86                                      ; preds = %82
  %87 = load i32* %j, align 4
  %88 = load i32* %y, align 4
  %89 = load i32* %hstep, align 4
  %90 = sub i32 %88, %89
  %91 = sub i32 %87, %90
  %92 = load i32* %maskWidth, align 4
  %93 = mul i32 %91, %92
  %94 = load i32* %i, align 4
  %95 = load i32* %x, align 4
  %96 = load i32* %vstep, align 4
  %97 = sub i32 %95, %96
  %98 = sub i32 %94, %97
  %99 = add i32 %93, %98
  store i32 %99, i32* %maskIndex, align 4
  %100 = load i32* %j, align 4
  %101 = load i32* %width, align 4
  %102 = mul i32 %100, %101
  %103 = load i32* %i, align 4
  %104 = add i32 %102, %103
  store i32 %104, i32* %index, align 4
  %105 = load i32* %index, align 4
  %106 = load i32 addrspace(1)** %2, align 4
  %107 = getelementptr inbounds i32 addrspace(1)* %106, i32 %105
  %108 = load i32 addrspace(1)* %107, align 4
  %109 = uitofp i32 %108 to float
  %110 = load i32* %maskIndex, align 4
  %111 = load float addrspace(1)** %3, align 4
  %112 = getelementptr inbounds float addrspace(1)* %111, i32 %110
  %113 = load float addrspace(1)* %112, align 4
  %114 = fmul float %109, %113
  %115 = load float* %sumFX, align 4
  %116 = fadd float %115, %114
  store float %116, float* %sumFX, align 4
  br label %117

; <label>:117                                     ; preds = %86
  %118 = load i32* %j, align 4
  %119 = add i32 %118, 1
  store i32 %119, i32* %j, align 4
  br label %82

; <label>:120                                     ; preds = %82
  br label %121

; <label>:121                                     ; preds = %120
  %122 = load i32* %i, align 4
  %123 = add i32 %122, 1
  store i32 %123, i32* %i, align 4
  br label %76

; <label>:124                                     ; preds = %76
  %125 = load float* %sumFX, align 4
  %126 = fadd float %125, 5.000000e-01
  store float %126, float* %sumFX, align 4
  %127 = load float* %sumFX, align 4
  %128 = fptoui float %127 to i32
  %129 = load i32* %tid, align 4
  %130 = load i32 addrspace(1)** %1, align 4
  %131 = getelementptr inbounds i32 addrspace(1)* %130, i32 %129
  store i32 %128, i32 addrspace(1)* %131, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, float addrspace(1)*, <2 x i32>, <2 x i32>)* @simpleConvolution}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

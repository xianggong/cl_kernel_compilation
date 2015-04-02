; ModuleID = 'SimpleConvolution_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @simpleConvolution(i32 addrspace(1)* %output, i32 addrspace(1)* %input, float addrspace(1)* %mask, <2 x i32> %inputDimensions, <2 x i32> %maskDimensions) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = extractelement <2 x i32> %inputDimensions, i32 0
  %3 = extractelement <2 x i32> %inputDimensions, i32 1
  %4 = urem i32 %1, %2
  %5 = udiv i32 %1, %2
  %6 = extractelement <2 x i32> %maskDimensions, i32 0
  %7 = extractelement <2 x i32> %maskDimensions, i32 1
  %8 = sub i32 %6, 1
  %9 = udiv i32 %8, 2
  %10 = sub i32 %7, 1
  %11 = udiv i32 %10, 2
  %12 = icmp ult i32 %4, %9
  br i1 %12, label %13, label %14

; <label>:13                                      ; preds = %0
  br label %16

; <label>:14                                      ; preds = %0
  %15 = sub i32 %4, %9
  br label %16

; <label>:16                                      ; preds = %14, %13
  %17 = phi i32 [ 0, %13 ], [ %15, %14 ]
  %18 = add i32 %4, %9
  %19 = icmp uge i32 %18, %2
  br i1 %19, label %20, label %22

; <label>:20                                      ; preds = %16
  %21 = sub i32 %2, 1
  br label %24

; <label>:22                                      ; preds = %16
  %23 = add i32 %4, %9
  br label %24

; <label>:24                                      ; preds = %22, %20
  %25 = phi i32 [ %21, %20 ], [ %23, %22 ]
  %26 = icmp ult i32 %5, %11
  br i1 %26, label %27, label %28

; <label>:27                                      ; preds = %24
  br label %30

; <label>:28                                      ; preds = %24
  %29 = sub i32 %5, %11
  br label %30

; <label>:30                                      ; preds = %28, %27
  %31 = phi i32 [ 0, %27 ], [ %29, %28 ]
  %32 = add i32 %5, %11
  %33 = icmp uge i32 %32, %3
  br i1 %33, label %34, label %36

; <label>:34                                      ; preds = %30
  %35 = sub i32 %3, 1
  br label %38

; <label>:36                                      ; preds = %30
  %37 = add i32 %5, %11
  br label %38

; <label>:38                                      ; preds = %36, %34
  %39 = phi i32 [ %35, %34 ], [ %37, %36 ]
  br label %40

; <label>:40                                      ; preds = %64, %38
  %sumFX.0 = phi float [ 0.000000e+00, %38 ], [ %sumFX.1, %64 ]
  %i.0 = phi i32 [ %17, %38 ], [ %65, %64 ]
  %41 = icmp ule i32 %i.0, %25
  br i1 %41, label %42, label %66

; <label>:42                                      ; preds = %40
  br label %43

; <label>:43                                      ; preds = %61, %42
  %sumFX.1 = phi float [ %sumFX.0, %42 ], [ %60, %61 ]
  %j.0 = phi i32 [ %31, %42 ], [ %62, %61 ]
  %44 = icmp ule i32 %j.0, %39
  br i1 %44, label %45, label %63

; <label>:45                                      ; preds = %43
  %46 = sub i32 %5, %11
  %47 = sub i32 %j.0, %46
  %48 = mul i32 %47, %6
  %49 = sub i32 %4, %9
  %50 = sub i32 %i.0, %49
  %51 = add i32 %48, %50
  %52 = mul i32 %j.0, %2
  %53 = add i32 %52, %i.0
  %54 = getelementptr inbounds i32 addrspace(1)* %input, i32 %53
  %55 = load i32 addrspace(1)* %54, align 4
  %56 = uitofp i32 %55 to float
  %57 = getelementptr inbounds float addrspace(1)* %mask, i32 %51
  %58 = load float addrspace(1)* %57, align 4
  %59 = fmul float %56, %58
  %60 = fadd float %sumFX.1, %59
  br label %61

; <label>:61                                      ; preds = %45
  %62 = add i32 %j.0, 1
  br label %43

; <label>:63                                      ; preds = %43
  br label %64

; <label>:64                                      ; preds = %63
  %65 = add i32 %i.0, 1
  br label %40

; <label>:66                                      ; preds = %40
  %67 = fadd float %sumFX.0, 5.000000e-01
  %68 = fptoui float %67 to i32
  %69 = getelementptr inbounds i32 addrspace(1)* %output, i32 %1
  store i32 %68, i32 addrspace(1)* %69, align 4
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, float addrspace(1)*, <2 x i32>, <2 x i32>)* @simpleConvolution}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

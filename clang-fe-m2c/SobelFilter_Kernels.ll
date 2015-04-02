; ModuleID = '../kernel-src/SobelFilter_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @sobel_filter(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca <4 x i8> addrspace(1)*, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %Gx = alloca <4 x float>, align 16
  %Gy = alloca <4 x float>, align 16
  %c = alloca i32, align 4
  %i00 = alloca <4 x float>, align 16
  %i10 = alloca <4 x float>, align 16
  %i20 = alloca <4 x float>, align 16
  %i01 = alloca <4 x float>, align 16
  %i11 = alloca <4 x float>, align 16
  %i21 = alloca <4 x float>, align 16
  %i02 = alloca <4 x float>, align 16
  %i12 = alloca <4 x float>, align 16
  %i22 = alloca <4 x float>, align 16
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %2, align 4
  %3 = call i32 @__get_global_id_u32(i32 0)
  store i32 %3, i32* %x, align 4
  %4 = call i32 @__get_global_id_u32(i32 1)
  store i32 %4, i32* %y, align 4
  %5 = call i32 @__get_global_size_u32(i32 0)
  store i32 %5, i32* %width, align 4
  %6 = call i32 @__get_global_size_u32(i32 1)
  store i32 %6, i32* %height, align 4
  store <4 x float> zeroinitializer, <4 x float>* %Gx, align 16
  %7 = load <4 x float>* %Gx, align 16
  store <4 x float> %7, <4 x float>* %Gy, align 16
  %8 = load i32* %x, align 4
  %9 = load i32* %y, align 4
  %10 = load i32* %width, align 4
  %11 = mul i32 %9, %10
  %12 = add i32 %8, %11
  store i32 %12, i32* %c, align 4
  %13 = load i32* %x, align 4
  %14 = icmp uge i32 %13, 1
  br i1 %14, label %15, label %125

; <label>:15                                      ; preds = %0
  %16 = load i32* %x, align 4
  %17 = load i32* %width, align 4
  %18 = sub i32 %17, 1
  %19 = icmp ult i32 %16, %18
  br i1 %19, label %20, label %125

; <label>:20                                      ; preds = %15
  %21 = load i32* %y, align 4
  %22 = icmp uge i32 %21, 1
  br i1 %22, label %23, label %125

; <label>:23                                      ; preds = %20
  %24 = load i32* %y, align 4
  %25 = load i32* %height, align 4
  %26 = sub i32 %25, 1
  %27 = icmp ult i32 %24, %26
  br i1 %27, label %28, label %125

; <label>:28                                      ; preds = %23
  %29 = load i32* %c, align 4
  %30 = sub nsw i32 %29, 1
  %31 = load i32* %width, align 4
  %32 = sub i32 %30, %31
  %33 = load <4 x i8> addrspace(1)** %1, align 4
  %34 = getelementptr inbounds <4 x i8> addrspace(1)* %33, i32 %32
  %35 = load <4 x i8> addrspace(1)* %34, align 4
  %36 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %35)
  store <4 x float> %36, <4 x float>* %i00, align 16
  %37 = load i32* %c, align 4
  %38 = load i32* %width, align 4
  %39 = sub i32 %37, %38
  %40 = load <4 x i8> addrspace(1)** %1, align 4
  %41 = getelementptr inbounds <4 x i8> addrspace(1)* %40, i32 %39
  %42 = load <4 x i8> addrspace(1)* %41, align 4
  %43 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %42)
  store <4 x float> %43, <4 x float>* %i10, align 16
  %44 = load i32* %c, align 4
  %45 = add nsw i32 %44, 1
  %46 = load i32* %width, align 4
  %47 = sub i32 %45, %46
  %48 = load <4 x i8> addrspace(1)** %1, align 4
  %49 = getelementptr inbounds <4 x i8> addrspace(1)* %48, i32 %47
  %50 = load <4 x i8> addrspace(1)* %49, align 4
  %51 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %50)
  store <4 x float> %51, <4 x float>* %i20, align 16
  %52 = load i32* %c, align 4
  %53 = sub nsw i32 %52, 1
  %54 = load <4 x i8> addrspace(1)** %1, align 4
  %55 = getelementptr inbounds <4 x i8> addrspace(1)* %54, i32 %53
  %56 = load <4 x i8> addrspace(1)* %55, align 4
  %57 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %56)
  store <4 x float> %57, <4 x float>* %i01, align 16
  %58 = load i32* %c, align 4
  %59 = load <4 x i8> addrspace(1)** %1, align 4
  %60 = getelementptr inbounds <4 x i8> addrspace(1)* %59, i32 %58
  %61 = load <4 x i8> addrspace(1)* %60, align 4
  %62 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %61)
  store <4 x float> %62, <4 x float>* %i11, align 16
  %63 = load i32* %c, align 4
  %64 = add nsw i32 %63, 1
  %65 = load <4 x i8> addrspace(1)** %1, align 4
  %66 = getelementptr inbounds <4 x i8> addrspace(1)* %65, i32 %64
  %67 = load <4 x i8> addrspace(1)* %66, align 4
  %68 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %67)
  store <4 x float> %68, <4 x float>* %i21, align 16
  %69 = load i32* %c, align 4
  %70 = sub nsw i32 %69, 1
  %71 = load i32* %width, align 4
  %72 = add i32 %70, %71
  %73 = load <4 x i8> addrspace(1)** %1, align 4
  %74 = getelementptr inbounds <4 x i8> addrspace(1)* %73, i32 %72
  %75 = load <4 x i8> addrspace(1)* %74, align 4
  %76 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %75)
  store <4 x float> %76, <4 x float>* %i02, align 16
  %77 = load i32* %c, align 4
  %78 = load i32* %width, align 4
  %79 = add i32 %77, %78
  %80 = load <4 x i8> addrspace(1)** %1, align 4
  %81 = getelementptr inbounds <4 x i8> addrspace(1)* %80, i32 %79
  %82 = load <4 x i8> addrspace(1)* %81, align 4
  %83 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %82)
  store <4 x float> %83, <4 x float>* %i12, align 16
  %84 = load i32* %c, align 4
  %85 = add nsw i32 %84, 1
  %86 = load i32* %width, align 4
  %87 = add i32 %85, %86
  %88 = load <4 x i8> addrspace(1)** %1, align 4
  %89 = getelementptr inbounds <4 x i8> addrspace(1)* %88, i32 %87
  %90 = load <4 x i8> addrspace(1)* %89, align 4
  %91 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %90)
  store <4 x float> %91, <4 x float>* %i22, align 16
  %92 = load <4 x float>* %i00, align 16
  %93 = load <4 x float>* %i10, align 16
  %94 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %93, <4 x float> %92)
  %95 = load <4 x float>* %i20, align 16
  %96 = fadd <4 x float> %94, %95
  %97 = load <4 x float>* %i02, align 16
  %98 = fsub <4 x float> %96, %97
  %99 = load <4 x float>* %i12, align 16
  %100 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %99
  %101 = fsub <4 x float> %98, %100
  %102 = load <4 x float>* %i22, align 16
  %103 = fsub <4 x float> %101, %102
  store <4 x float> %103, <4 x float>* %Gx, align 16
  %104 = load <4 x float>* %i00, align 16
  %105 = load <4 x float>* %i20, align 16
  %106 = fsub <4 x float> %104, %105
  %107 = load <4 x float>* %i01, align 16
  %108 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %107
  %109 = fadd <4 x float> %106, %108
  %110 = load <4 x float>* %i21, align 16
  %111 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %110
  %112 = fsub <4 x float> %109, %111
  %113 = load <4 x float>* %i02, align 16
  %114 = fadd <4 x float> %112, %113
  %115 = load <4 x float>* %i22, align 16
  %116 = fsub <4 x float> %114, %115
  store <4 x float> %116, <4 x float>* %Gy, align 16
  %117 = load <4 x float>* %Gx, align 16
  %118 = load <4 x float>* %Gy, align 16
  %119 = call <4 x float> @_Z5hypotDv4_fS_(<4 x float> %117, <4 x float> %118)
  %120 = fdiv <4 x float> %119, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !2
  %121 = call <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %120)
  %122 = load i32* %c, align 4
  %123 = load <4 x i8> addrspace(1)** %2, align 4
  %124 = getelementptr inbounds <4 x i8> addrspace(1)* %123, i32 %122
  store <4 x i8> %121, <4 x i8> addrspace(1)* %124, align 4
  br label %125

; <label>:125                                     ; preds = %28, %23, %20, %15, %0
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_global_size_u32(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float>) #1

declare <4 x float> @_Z5hypotDv4_fS_(<4 x float>, <4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*)* @sobel_filter}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

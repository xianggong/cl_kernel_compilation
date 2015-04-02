; ModuleID = 'SobelFilter_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @sobel_filter(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = call i32 @__get_global_size_u32(i32 0)
  %4 = call i32 @__get_global_size_u32(i32 1)
  %5 = mul i32 %2, %3
  %6 = add i32 %1, %5
  %7 = icmp uge i32 %1, 1
  br i1 %7, label %8, label %73

; <label>:8                                       ; preds = %0
  %9 = sub i32 %3, 1
  %10 = icmp ult i32 %1, %9
  br i1 %10, label %11, label %73

; <label>:11                                      ; preds = %8
  %12 = icmp uge i32 %2, 1
  br i1 %12, label %13, label %73

; <label>:13                                      ; preds = %11
  %14 = sub i32 %4, 1
  %15 = icmp ult i32 %2, %14
  br i1 %15, label %16, label %73

; <label>:16                                      ; preds = %13
  %17 = sub nsw i32 %6, 1
  %18 = sub i32 %17, %3
  %19 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %18
  %20 = load <4 x i8> addrspace(1)* %19, align 4
  %21 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %20)
  %22 = sub i32 %6, %3
  %23 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %22
  %24 = load <4 x i8> addrspace(1)* %23, align 4
  %25 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %24)
  %26 = add nsw i32 %6, 1
  %27 = sub i32 %26, %3
  %28 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %27
  %29 = load <4 x i8> addrspace(1)* %28, align 4
  %30 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %29)
  %31 = sub nsw i32 %6, 1
  %32 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %31
  %33 = load <4 x i8> addrspace(1)* %32, align 4
  %34 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %33)
  %35 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %6
  %36 = load <4 x i8> addrspace(1)* %35, align 4
  %37 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %36)
  %38 = add nsw i32 %6, 1
  %39 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %38
  %40 = load <4 x i8> addrspace(1)* %39, align 4
  %41 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %40)
  %42 = sub nsw i32 %6, 1
  %43 = add i32 %42, %3
  %44 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %43
  %45 = load <4 x i8> addrspace(1)* %44, align 4
  %46 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %45)
  %47 = add i32 %6, %3
  %48 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %47
  %49 = load <4 x i8> addrspace(1)* %48, align 4
  %50 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %49)
  %51 = add nsw i32 %6, 1
  %52 = add i32 %51, %3
  %53 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %52
  %54 = load <4 x i8> addrspace(1)* %53, align 4
  %55 = call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %54)
  %56 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %25, <4 x float> %21)
  %57 = fadd <4 x float> %56, %30
  %58 = fsub <4 x float> %57, %46
  %59 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %50
  %60 = fsub <4 x float> %58, %59
  %61 = fsub <4 x float> %60, %55
  %62 = fsub <4 x float> %21, %30
  %63 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %34
  %64 = fadd <4 x float> %62, %63
  %65 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %41
  %66 = fsub <4 x float> %64, %65
  %67 = fadd <4 x float> %66, %46
  %68 = fsub <4 x float> %67, %55
  %69 = call <4 x float> @_Z5hypotDv4_fS_(<4 x float> %61, <4 x float> %68)
  %70 = fdiv <4 x float> %69, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !2
  %71 = call <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %70)
  %72 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> %71, <4 x i8> addrspace(1)* %72, align 4
  br label %73

; <label>:73                                      ; preds = %16, %13, %11, %8, %0
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

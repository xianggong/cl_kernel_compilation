; ModuleID = '../kernel-src/SobelFilter_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @sobel_filter(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = tail call i32 @get_global_size(i32 0) #3
  %4 = tail call i32 @get_global_size(i32 1) #3
  %5 = mul i32 %3, %2
  %6 = add i32 %5, %1
  %7 = icmp eq i32 %1, 0
  br i1 %7, label %76, label %8

; <label>:8                                       ; preds = %0
  %9 = add i32 %3, -1
  %10 = icmp ult i32 %1, %9
  %11 = icmp ne i32 %2, 0
  %or.cond = and i1 %10, %11
  %12 = add i32 %4, -1
  %13 = icmp ult i32 %2, %12
  %or.cond3 = and i1 %or.cond, %13
  br i1 %or.cond3, label %14, label %76

; <label>:14                                      ; preds = %8
  %15 = add nsw i32 %6, -1
  %16 = sub i32 %15, %3
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %17
  %19 = load <4 x i8> addrspace(1)* %18, align 4, !tbaa !2
  %20 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %19) #3
  %21 = sub i32 %6, %3
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %22
  %24 = load <4 x i8> addrspace(1)* %23, align 4, !tbaa !2
  %25 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %24) #3
  %26 = add nsw i32 %6, 1
  %27 = sub i32 %26, %3
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %28
  %30 = load <4 x i8> addrspace(1)* %29, align 4, !tbaa !2
  %31 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %30) #3
  %32 = sext i32 %15 to i64
  %33 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %32
  %34 = load <4 x i8> addrspace(1)* %33, align 4, !tbaa !2
  %35 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %34) #3
  %36 = sext i32 %6 to i64
  %37 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %36
  %38 = load <4 x i8> addrspace(1)* %37, align 4, !tbaa !2
  %39 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %38) #3
  %40 = sext i32 %26 to i64
  %41 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %40
  %42 = load <4 x i8> addrspace(1)* %41, align 4, !tbaa !2
  %43 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %42) #3
  %44 = add i32 %15, %3
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %45
  %47 = load <4 x i8> addrspace(1)* %46, align 4, !tbaa !2
  %48 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %47) #3
  %49 = add i32 %6, %3
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %50
  %52 = load <4 x i8> addrspace(1)* %51, align 4, !tbaa !2
  %53 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %52) #3
  %54 = add i32 %26, %3
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %55
  %57 = load <4 x i8> addrspace(1)* %56, align 4, !tbaa !2
  %58 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %57) #3
  %59 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %25, <4 x float> %20)
  %60 = fadd <4 x float> %31, %59
  %61 = fsub <4 x float> %60, %48
  %62 = fmul <4 x float> %53, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %63 = fsub <4 x float> %61, %62
  %64 = fsub <4 x float> %63, %58
  %65 = fsub <4 x float> %20, %31
  %66 = fmul <4 x float> %35, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %67 = fadd <4 x float> %65, %66
  %68 = fmul <4 x float> %43, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %69 = fsub <4 x float> %67, %68
  %70 = fadd <4 x float> %69, %48
  %71 = fsub <4 x float> %70, %58
  %72 = tail call <4 x float> @_Z5hypotDv4_fS_(<4 x float> %64, <4 x float> %71) #3
  %73 = fdiv <4 x float> %72, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !5
  %74 = tail call <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %73) #3
  %75 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %36
  store <4 x i8> %74, <4 x i8> addrspace(1)* %75, align 4, !tbaa !2
  br label %76

; <label>:76                                      ; preds = %0, %14, %8
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float>) #1

declare <4 x float> @_Z5hypotDv4_fS_(<4 x float>, <4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*)* @sobel_filter}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

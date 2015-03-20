; ModuleID = '../kernel-src/SobelFilter_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @sobel_filter(<4 x i8>* nocapture readonly %inputImage, <4 x i8>* nocapture %outputImage) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #3
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #3
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_global_size(i32 0) #3
  %6 = trunc i64 %5 to i32
  %7 = tail call i64 @get_global_size(i32 1) #3
  %8 = mul i32 %6, %4
  %9 = add i32 %8, %2
  %10 = icmp eq i32 %2, 0
  br i1 %10, label %90, label %11

; <label>:11                                      ; preds = %0
  %12 = trunc i64 %7 to i32
  %13 = add i32 %6, -1
  %14 = icmp ult i32 %2, %13
  %15 = icmp ne i32 %4, 0
  %or.cond = and i1 %14, %15
  %16 = add i32 %12, -1
  %17 = icmp ult i32 %4, %16
  %or.cond12 = and i1 %or.cond, %17
  br i1 %or.cond12, label %18, label %90

; <label>:18                                      ; preds = %11
  %19 = add nsw i32 %9, -1
  %20 = sub i32 %19, %6
  %21 = zext i32 %20 to i64
  %22 = getelementptr inbounds <4 x i8>* %inputImage, i64 %21
  %23 = load <4 x i8>* %22, align 4, !tbaa !2
  %24 = bitcast <4 x i8> %23 to i32
  %25 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %24) #3
  %26 = sub i32 %9, %6
  %27 = zext i32 %26 to i64
  %28 = getelementptr inbounds <4 x i8>* %inputImage, i64 %27
  %29 = load <4 x i8>* %28, align 4, !tbaa !2
  %30 = bitcast <4 x i8> %29 to i32
  %31 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %30) #3
  %32 = add nsw i32 %9, 1
  %33 = sub i32 %32, %6
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds <4 x i8>* %inputImage, i64 %34
  %36 = load <4 x i8>* %35, align 4, !tbaa !2
  %37 = bitcast <4 x i8> %36 to i32
  %38 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %37) #3
  %39 = sext i32 %19 to i64
  %40 = getelementptr inbounds <4 x i8>* %inputImage, i64 %39
  %41 = load <4 x i8>* %40, align 4, !tbaa !2
  %42 = bitcast <4 x i8> %41 to i32
  %43 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %42) #3
  %44 = sext i32 %9 to i64
  %45 = getelementptr inbounds <4 x i8>* %inputImage, i64 %44
  %46 = load <4 x i8>* %45, align 4, !tbaa !2
  %47 = bitcast <4 x i8> %46 to i32
  %48 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %47) #3
  %49 = sext i32 %32 to i64
  %50 = getelementptr inbounds <4 x i8>* %inputImage, i64 %49
  %51 = load <4 x i8>* %50, align 4, !tbaa !2
  %52 = bitcast <4 x i8> %51 to i32
  %53 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %52) #3
  %54 = add i32 %19, %6
  %55 = zext i32 %54 to i64
  %56 = getelementptr inbounds <4 x i8>* %inputImage, i64 %55
  %57 = load <4 x i8>* %56, align 4, !tbaa !2
  %58 = bitcast <4 x i8> %57 to i32
  %59 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %58) #3
  %60 = add i32 %9, %6
  %61 = zext i32 %60 to i64
  %62 = getelementptr inbounds <4 x i8>* %inputImage, i64 %61
  %63 = load <4 x i8>* %62, align 4, !tbaa !2
  %64 = bitcast <4 x i8> %63 to i32
  %65 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %64) #3
  %66 = add i32 %32, %6
  %67 = zext i32 %66 to i64
  %68 = getelementptr inbounds <4 x i8>* %inputImage, i64 %67
  %69 = load <4 x i8>* %68, align 4, !tbaa !2
  %70 = bitcast <4 x i8> %69 to i32
  %71 = tail call <4 x float> @_Z14convert_float4Dv4_h(i32 %70) #3
  %72 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %31, <4 x float> %25)
  %73 = fadd <4 x float> %38, %72
  %74 = fsub <4 x float> %73, %59
  %75 = fmul <4 x float> %65, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %76 = fsub <4 x float> %74, %75
  %77 = fsub <4 x float> %76, %71
  %78 = fsub <4 x float> %25, %38
  %79 = fmul <4 x float> %43, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %80 = fadd <4 x float> %78, %79
  %81 = fmul <4 x float> %53, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %82 = fsub <4 x float> %80, %81
  %83 = fadd <4 x float> %82, %59
  %84 = fsub <4 x float> %83, %71
  %85 = tail call <4 x float> @_Z5hypotDv4_fS_(<4 x float> %77, <4 x float> %84) #3
  %86 = fdiv <4 x float> %85, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !5
  %87 = tail call i32 @_Z14convert_uchar4Dv4_f(<4 x float> %86) #3
  %88 = bitcast i32 %87 to <4 x i8>
  %89 = getelementptr inbounds <4 x i8>* %outputImage, i64 %44
  store <4 x i8> %88, <4 x i8>* %89, align 4, !tbaa !2
  br label %90

; <label>:90                                      ; preds = %0, %18, %11
  ret void
}

declare i64 @get_global_id(i32) #1

declare i64 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(i32) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare i32 @_Z14convert_uchar4Dv4_f(<4 x float>) #1

declare <4 x float> @_Z5hypotDv4_fS_(<4 x float>, <4 x float>) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8>*, <4 x i8>*)* @sobel_filter}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

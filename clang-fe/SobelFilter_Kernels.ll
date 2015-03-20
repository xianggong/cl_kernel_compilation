; ModuleID = '../kernel-src/SobelFilter_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @sobel_filter(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = tail call i32 @get_global_size(i32 0) #3
  %4 = tail call i32 @get_global_size(i32 1) #3
  %5 = mul i32 %3, %2
  %6 = add i32 %5, %1
  %7 = icmp eq i32 %1, 0
  br i1 %7, label %67, label %8

; <label>:8                                       ; preds = %0
  %9 = add i32 %3, -1
  %10 = icmp ult i32 %1, %9
  %11 = icmp ne i32 %2, 0
  %or.cond = and i1 %11, %10
  %12 = add i32 %4, -1
  %13 = icmp ult i32 %2, %12
  %or.cond3 = and i1 %or.cond, %13
  br i1 %or.cond3, label %14, label %67

; <label>:14                                      ; preds = %8
  %15 = add nsw i32 %6, -1
  %16 = sub i32 %15, %3
  %17 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %16
  %18 = load <4 x i8> addrspace(1)* %17, align 4, !tbaa !7
  %19 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %18) #3
  %20 = sub i32 %6, %3
  %21 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %20
  %22 = load <4 x i8> addrspace(1)* %21, align 4, !tbaa !7
  %23 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %22) #3
  %24 = add nsw i32 %6, 1
  %25 = sub i32 %24, %3
  %26 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %25
  %27 = load <4 x i8> addrspace(1)* %26, align 4, !tbaa !7
  %28 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %27) #3
  %29 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %15
  %30 = load <4 x i8> addrspace(1)* %29, align 4, !tbaa !7
  %31 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %30) #3
  %32 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %6
  %33 = load <4 x i8> addrspace(1)* %32, align 4, !tbaa !7
  %34 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %33) #3
  %35 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %24
  %36 = load <4 x i8> addrspace(1)* %35, align 4, !tbaa !7
  %37 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %36) #3
  %38 = add i32 %15, %3
  %39 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %38
  %40 = load <4 x i8> addrspace(1)* %39, align 4, !tbaa !7
  %41 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %40) #3
  %42 = add i32 %6, %3
  %43 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %42
  %44 = load <4 x i8> addrspace(1)* %43, align 4, !tbaa !7
  %45 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %44) #3
  %46 = add i32 %24, %3
  %47 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %46
  %48 = load <4 x i8> addrspace(1)* %47, align 4, !tbaa !7
  %49 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %48) #3
  %50 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %23, <4 x float> %19)
  %51 = fadd <4 x float> %28, %50
  %52 = fsub <4 x float> %51, %41
  %53 = fmul <4 x float> %45, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %54 = fsub <4 x float> %52, %53
  %55 = fsub <4 x float> %54, %49
  %56 = fsub <4 x float> %19, %28
  %57 = fmul <4 x float> %31, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %58 = fadd <4 x float> %56, %57
  %59 = fmul <4 x float> %37, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %60 = fsub <4 x float> %58, %59
  %61 = fadd <4 x float> %60, %41
  %62 = fsub <4 x float> %61, %49
  %63 = tail call <4 x float> @_Z5hypotDv4_fS_(<4 x float> %55, <4 x float> %62) #3
  %64 = fdiv <4 x float> %63, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !10
  %65 = tail call <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %64) #3
  %66 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %6
  store <4 x i8> %65, <4 x i8> addrspace(1)* %66, align 4, !tbaa !7
  br label %67

; <label>:67                                      ; preds = %0, %14, %8
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
!llvm.ident = !{!6}

!0 = !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*)* @sobel_filter, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uchar4*", !"uchar4*"}
!4 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar __attribute__((ext_vector_type(4)))*"}
!5 = !{!"kernel_arg_type_qual", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{float 2.500000e+00}

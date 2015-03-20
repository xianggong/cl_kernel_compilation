; ModuleID = '../kernel-src/SimpleGL_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @sineWave(<4 x float> addrspace(1)* nocapture %pos, i32 %width, i32 %height, float %time) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = tail call i32 @get_global_id(i32 1) #3
  %3 = uitofp i32 %1 to float
  %4 = uitofp i32 %width to float
  %5 = fdiv float %3, %4, !fpmath !7
  %6 = uitofp i32 %2 to float
  %7 = uitofp i32 %height to float
  %8 = fdiv float %6, %7, !fpmath !7
  %9 = tail call float @llvm.fmuladd.f32(float %5, float 2.000000e+00, float -1.000000e+00)
  %10 = tail call float @llvm.fmuladd.f32(float %8, float 2.000000e+00, float -1.000000e+00)
  %11 = tail call float @llvm.fmuladd.f32(float %9, float 4.000000e+00, float %time)
  %12 = tail call float @_Z3sinf(float %11) #3
  %13 = tail call float @llvm.fmuladd.f32(float %10, float 4.000000e+00, float %time)
  %14 = tail call float @_Z3cosf(float %13) #3
  %15 = fmul float %12, %14
  %16 = fmul float %15, 5.000000e-01
  %17 = insertelement <4 x float> undef, float %9, i32 0
  %18 = insertelement <4 x float> %17, float %16, i32 1
  %19 = insertelement <4 x float> %18, float %10, i32 2
  %20 = insertelement <4 x float> %19, float 1.000000e+00, i32 3
  %21 = mul i32 %2, %width
  %22 = add i32 %21, %1
  %23 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %22
  store <4 x float> %20, <4 x float> addrspace(1)* %23, align 16, !tbaa !8
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3sinf(float) #1

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (<4 x float> addrspace(1)*, i32, i32, float)* @sineWave, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float4*", !"uint", !"uint", !"float"}
!4 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"uint", !"uint", !"float"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{float 2.500000e+00}
!8 = !{!9, !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}

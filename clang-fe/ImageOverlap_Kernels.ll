; ModuleID = '../kernel-src/ImageOverlap_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%opencl.image2d_t = type opaque

; Function Attrs: nounwind uwtable
define void @OverLap(%opencl.image2d_t* %pconfig_src, %opencl.image2d_t* %pconfig_src2, %opencl.image2d_t* %pconfig_dst) #0 {
  %1 = tail call i64 @get_global_id(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_global_id(i32 1) #2
  %4 = trunc i64 %3 to i32
  %5 = insertelement <2 x i32> undef, i32 %2, i32 0
  %6 = insertelement <2 x i32> %5, i32 %4, i32 1
  %7 = bitcast <2 x i32> %6 to double
  %8 = tail call i32 (%opencl.image2d_t*, i32, double, ...)* bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, double, ...)*)(%opencl.image2d_t* %pconfig_src, i32 0, double %7) #2
  %9 = insertelement <4 x i32> undef, i32 %8, i32 0
  %10 = shufflevector <4 x i32> %9, <4 x i32> undef, <4 x i32> zeroinitializer
  %11 = tail call i32 (%opencl.image2d_t*, i32, double, ...)* bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, double, ...)*)(%opencl.image2d_t* %pconfig_src2, i32 0, double %7) #2
  %12 = insertelement <4 x i32> undef, i32 %11, i32 0
  %13 = shufflevector <4 x i32> %12, <4 x i32> undef, <4 x i32> zeroinitializer
  %14 = add <4 x i32> %10, %13
  %15 = tail call i32 (%opencl.image2d_t*, double, <4 x i32>, ...)* bitcast (i32 (...)* @write_imageui to i32 (%opencl.image2d_t*, double, <4 x i32>, ...)*)(%opencl.image2d_t* %pconfig_dst, double %7, <4 x i32> %14) #2
  ret void
}

declare i64 @get_global_id(i32) #1

declare i32 @read_imageui(...) #1

declare i32 @write_imageui(...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (%opencl.image2d_t*, %opencl.image2d_t*, %opencl.image2d_t*)* @OverLap}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

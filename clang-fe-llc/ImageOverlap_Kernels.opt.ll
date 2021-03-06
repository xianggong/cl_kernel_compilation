; ModuleID = 'ImageOverlap_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%opencl.image2d_t = type opaque

; Function Attrs: nounwind
define void @OverLap(%opencl.image2d_t* %pconfig_src, %opencl.image2d_t* %pconfig_src2, %opencl.image2d_t* %pconfig_dst) #0 {
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = call i32 @llvm.r600.read.tgid.y()
  %3 = insertelement <2 x i32> undef, i32 %1, i32 0
  %4 = insertelement <2 x i32> %3, i32 %2, i32 1
  %5 = call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, <2 x i32>)*)(%opencl.image2d_t* %pconfig_src, i32 0, <2 x i32> %4)
  %6 = insertelement <4 x i32> undef, i32 %5, i32 0
  %7 = shufflevector <4 x i32> %6, <4 x i32> undef, <4 x i32> zeroinitializer
  %8 = call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, <2 x i32>)*)(%opencl.image2d_t* %pconfig_src2, i32 0, <2 x i32> %4)
  %9 = insertelement <4 x i32> undef, i32 %8, i32 0
  %10 = shufflevector <4 x i32> %9, <4 x i32> undef, <4 x i32> zeroinitializer
  %11 = add <4 x i32> %7, %10
  %12 = call i32 bitcast (i32 (...)* @write_imageui to i32 (%opencl.image2d_t*, <2 x i32>, <4 x i32>)*)(%opencl.image2d_t* %pconfig_dst, <2 x i32> %4, <4 x i32> %11)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.z() #1

declare i32 @read_imageui(...) #2

declare i32 @write_imageui(...) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (%opencl.image2d_t*, %opencl.image2d_t*, %opencl.image2d_t*)* @OverLap}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

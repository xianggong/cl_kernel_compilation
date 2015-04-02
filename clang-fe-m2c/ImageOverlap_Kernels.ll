; ModuleID = '../kernel-src/ImageOverlap_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%opencl.image2d_t = type opaque

; Function Attrs: nounwind
define void @OverLap(%opencl.image2d_t* %pconfig_src, %opencl.image2d_t* %pconfig_src2, %opencl.image2d_t* %pconfig_dst) #0 {
  %1 = alloca %opencl.image2d_t*, align 4
  %2 = alloca %opencl.image2d_t*, align 4
  %3 = alloca %opencl.image2d_t*, align 4
  %ix = alloca i32, align 4
  %iy = alloca i32, align 4
  %locate = alloca <2 x i32>, align 8
  %color_src = alloca <4 x i32>, align 16
  %color_dst = alloca <4 x i32>, align 16
  %sampler = alloca i32, align 4
  store %opencl.image2d_t* %pconfig_src, %opencl.image2d_t** %1, align 4
  store %opencl.image2d_t* %pconfig_src2, %opencl.image2d_t** %2, align 4
  store %opencl.image2d_t* %pconfig_dst, %opencl.image2d_t** %3, align 4
  %4 = call i32 @__get_global_id_u32(i32 0)
  store i32 %4, i32* %ix, align 4
  %5 = call i32 @__get_global_id_u32(i32 1)
  store i32 %5, i32* %iy, align 4
  %6 = load i32* %ix, align 4
  %7 = load <2 x i32>* %locate, align 8
  %8 = insertelement <2 x i32> %7, i32 %6, i32 0
  store <2 x i32> %8, <2 x i32>* %locate, align 8
  %9 = load i32* %iy, align 4
  %10 = load <2 x i32>* %locate, align 8
  %11 = insertelement <2 x i32> %10, i32 %9, i32 1
  store <2 x i32> %11, <2 x i32>* %locate, align 8
  store i32 0, i32* %sampler, align 4
  %12 = load %opencl.image2d_t** %1, align 4
  %13 = load i32* %sampler, align 4
  %14 = load <2 x i32>* %locate, align 8
  %15 = call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, <2 x i32>)*)(%opencl.image2d_t* %12, i32 %13, <2 x i32> %14)
  %16 = insertelement <4 x i32> undef, i32 %15, i32 0
  %17 = shufflevector <4 x i32> %16, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %17, <4 x i32>* %color_src, align 16
  %18 = load %opencl.image2d_t** %2, align 4
  %19 = load i32* %sampler, align 4
  %20 = load <2 x i32>* %locate, align 8
  %21 = call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, <2 x i32>)*)(%opencl.image2d_t* %18, i32 %19, <2 x i32> %20)
  %22 = insertelement <4 x i32> undef, i32 %21, i32 0
  %23 = shufflevector <4 x i32> %22, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %23, <4 x i32>* %color_dst, align 16
  %24 = load %opencl.image2d_t** %3, align 4
  %25 = load <2 x i32>* %locate, align 8
  %26 = load <4 x i32>* %color_src, align 16
  %27 = load <4 x i32>* %color_dst, align 16
  %28 = add <4 x i32> %26, %27
  %29 = call i32 bitcast (i32 (...)* @write_imageui to i32 (%opencl.image2d_t*, <2 x i32>, <4 x i32>)*)(%opencl.image2d_t* %24, <2 x i32> %25, <4 x i32> %28)
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @read_imageui(...) #1

declare i32 @write_imageui(...) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (%opencl.image2d_t*, %opencl.image2d_t*, %opencl.image2d_t*)* @OverLap}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

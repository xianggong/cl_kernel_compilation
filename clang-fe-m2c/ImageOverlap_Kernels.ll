; ModuleID = '../kernel-src/ImageOverlap_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%opencl.image2d_t = type opaque

; Function Attrs: nounwind
define void @OverLap(%opencl.image2d_t* %pconfig_src, %opencl.image2d_t* %pconfig_src2, %opencl.image2d_t* %pconfig_dst) #0 {
  %tmp_1 = alloca %opencl.image2d_t*, align 4
  %tmp_2 = alloca %opencl.image2d_t*, align 4
  %tmp_3 = alloca %opencl.image2d_t*, align 4
  %ix = alloca i32, align 4
  %iy = alloca i32, align 4
  %locate = alloca <2 x i32>, align 8
  %color_src = alloca <4 x i32>, align 16
  %color_dst = alloca <4 x i32>, align 16
  %sampler = alloca i32, align 4
  store %opencl.image2d_t* %pconfig_src, %opencl.image2d_t** %tmp_1, align 4
  store %opencl.image2d_t* %pconfig_src2, %opencl.image2d_t** %tmp_2, align 4
  store %opencl.image2d_t* %pconfig_dst, %opencl.image2d_t** %tmp_3, align 4
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_4, i32* %ix, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_5, i32* %iy, align 4
  %tmp_6 = load i32* %ix, align 4
  %tmp_7 = load <2 x i32>* %locate, align 8
  %tmp_8 = insertelement <2 x i32> %tmp_7, i32 %tmp_6, i32 0
  store <2 x i32> %tmp_8, <2 x i32>* %locate, align 8
  %tmp_9 = load i32* %iy, align 4
  %tmp_10 = load <2 x i32>* %locate, align 8
  %tmp_11 = insertelement <2 x i32> %tmp_10, i32 %tmp_9, i32 1
  store <2 x i32> %tmp_11, <2 x i32>* %locate, align 8
  store i32 0, i32* %sampler, align 4
  %tmp_12 = load %opencl.image2d_t** %tmp_1, align 4
  %tmp_13 = load i32* %sampler, align 4
  %tmp_14 = load <2 x i32>* %locate, align 8
  %tmp_15 = call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, <2 x i32>)*)(%opencl.image2d_t* %tmp_12, i32 %tmp_13, <2 x i32> %tmp_14)
  %tmp_16 = insertelement <4 x i32> undef, i32 %tmp_15, i32 0
  %tmp_17 = shufflevector <4 x i32> %tmp_16, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %tmp_17, <4 x i32>* %color_src, align 16
  %tmp_18 = load %opencl.image2d_t** %tmp_2, align 4
  %tmp_19 = load i32* %sampler, align 4
  %tmp_20 = load <2 x i32>* %locate, align 8
  %tmp_21 = call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, <2 x i32>)*)(%opencl.image2d_t* %tmp_18, i32 %tmp_19, <2 x i32> %tmp_20)
  %tmp_22 = insertelement <4 x i32> undef, i32 %tmp_21, i32 0
  %tmp_23 = shufflevector <4 x i32> %tmp_22, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %tmp_23, <4 x i32>* %color_dst, align 16
  %tmp_24 = load %opencl.image2d_t** %tmp_3, align 4
  %tmp_25 = load <2 x i32>* %locate, align 8
  %tmp_26 = load <4 x i32>* %color_src, align 16
  %tmp_27 = load <4 x i32>* %color_dst, align 16
  %tmp_28 = add <4 x i32> %tmp_26, %tmp_27
  %tmp_29 = call i32 bitcast (i32 (...)* @write_imageui to i32 (%opencl.image2d_t*, <2 x i32>, <4 x i32>)*)(%opencl.image2d_t* %tmp_24, <2 x i32> %tmp_25, <4 x i32> %tmp_28)
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

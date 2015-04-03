; ModuleID = 'ImageOverlap_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%opencl.image2d_t = type opaque

; Function Attrs: nounwind
define void @OverLap(%opencl.image2d_t* %pconfig_src, %opencl.image2d_t* %pconfig_src2, %opencl.image2d_t* %pconfig_dst) #0 {
  %tmp_4 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = call i32 @__get_global_id_u32(i32 1)
  %tmp_8 = insertelement <2 x i32> undef, i32 %tmp_4, i32 0
  %tmp_11 = insertelement <2 x i32> %tmp_8, i32 %tmp_5, i32 1
  %tmp_15 = call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, <2 x i32>)*)(%opencl.image2d_t* %pconfig_src, i32 0, <2 x i32> %tmp_11)
  %tmp_16 = insertelement <4 x i32> undef, i32 %tmp_15, i32 0
  %tmp_17 = shufflevector <4 x i32> %tmp_16, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_21 = call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, <2 x i32>)*)(%opencl.image2d_t* %pconfig_src2, i32 0, <2 x i32> %tmp_11)
  %tmp_22 = insertelement <4 x i32> undef, i32 %tmp_21, i32 0
  %tmp_23 = shufflevector <4 x i32> %tmp_22, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp_28 = add <4 x i32> %tmp_17, %tmp_23
  %tmp_29 = call i32 bitcast (i32 (...)* @write_imageui to i32 (%opencl.image2d_t*, <2 x i32>, <4 x i32>)*)(%opencl.image2d_t* %pconfig_dst, <2 x i32> %tmp_11, <4 x i32> %tmp_28)
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

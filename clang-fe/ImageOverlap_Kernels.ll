; ModuleID = '../kernel-src/ImageOverlap_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%opencl.image2d_t = type opaque

; Function Attrs: nounwind
define void @OverLap(%opencl.image2d_t* %pconfig_src, %opencl.image2d_t* %pconfig_src2, %opencl.image2d_t* %pconfig_dst) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_global_id(i32 1) #2
  %0 = insertelement <2 x i32> undef, i32 %call, i32 0
  %1 = insertelement <2 x i32> %0, i32 %call1, i32 1
  %call2 = tail call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, <2 x i32>)*)(%opencl.image2d_t* %pconfig_src, i32 0, <2 x i32> %1) #2
  %splat.splatinsert = insertelement <4 x i32> undef, i32 %call2, i32 0
  %splat.splat = shufflevector <4 x i32> %splat.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %call3 = tail call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t*, i32, <2 x i32>)*)(%opencl.image2d_t* %pconfig_src2, i32 0, <2 x i32> %1) #2
  %splat.splatinsert4 = insertelement <4 x i32> undef, i32 %call3, i32 0
  %splat.splat5 = shufflevector <4 x i32> %splat.splatinsert4, <4 x i32> undef, <4 x i32> zeroinitializer
  %add = add <4 x i32> %splat.splat, %splat.splat5
  %call6 = tail call i32 bitcast (i32 (...)* @write_imageui to i32 (%opencl.image2d_t*, <2 x i32>, <4 x i32>)*)(%opencl.image2d_t* %pconfig_dst, <2 x i32> %1, <4 x i32> %add) #2
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @read_imageui(...) #1

declare i32 @write_imageui(...) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (%opencl.image2d_t*, %opencl.image2d_t*, %opencl.image2d_t*)* @OverLap}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}

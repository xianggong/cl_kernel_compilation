; ModuleID = '../kernel-src/ImageOverlap_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

%opencl.image2d_t = type opaque

; Function Attrs: nounwind
define void @OverLap(%opencl.image2d_t addrspace(1)* %pconfig_src, %opencl.image2d_t addrspace(1)* %pconfig_src2, %opencl.image2d_t addrspace(1)* %pconfig_dst) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = insertelement <2 x i32> undef, i32 %1, i32 0
  %4 = insertelement <2 x i32> %3, i32 %2, i32 1
  %5 = tail call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t addrspace(1)*, i32, <2 x i32>)*)(%opencl.image2d_t addrspace(1)* %pconfig_src, i32 0, <2 x i32> %4) #2
  %6 = insertelement <4 x i32> undef, i32 %5, i32 0
  %7 = tail call i32 bitcast (i32 (...)* @read_imageui to i32 (%opencl.image2d_t addrspace(1)*, i32, <2 x i32>)*)(%opencl.image2d_t addrspace(1)* %pconfig_src2, i32 0, <2 x i32> %4) #2
  %8 = insertelement <4 x i32> undef, i32 %7, i32 0
  %9 = add <4 x i32> %6, %8
  %10 = shufflevector <4 x i32> %9, <4 x i32> undef, <4 x i32> zeroinitializer
  %11 = tail call i32 bitcast (i32 (...)* @write_imageui to i32 (%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x i32>)*)(%opencl.image2d_t addrspace(1)* %pconfig_dst, <2 x i32> %4, <4 x i32> %10) #2
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @read_imageui(...) #1

declare i32 @write_imageui(...) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (%opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*)* @OverLap, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"read_only", !"read_only", !"write_only"}
!3 = !{!"kernel_arg_type", !"image2d_t", !"image2d_t", !"image2d_t"}
!4 = !{!"kernel_arg_base_type", !"image2d_t", !"image2d_t", !"image2d_t"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}

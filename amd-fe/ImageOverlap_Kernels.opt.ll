; ModuleID = 'ImageOverlap_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

; Function Attrs: nounwind
define cc76 void @__OpenCL_OverLap_kernel(%opencl.image2d_t addrspace(1)* %pconfig_src, %opencl.image2d_t addrspace(1)* %pconfig_src2, %opencl.image2d_t addrspace(1)* %pconfig_dst) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %0 = insertelement <2 x i32> undef, i32 %conv, i32 0
  %1 = insertelement <2 x i32> %0, i32 %conv2, i32 1
  %call3 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %pconfig_src, i32 0, <2 x i32> %1) #1
  %call4 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %pconfig_src2, i32 0, <2 x i32> %1) #1
  %add = add <4 x i32> %call3, %call4
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %pconfig_dst, <2 x i32> %1, <4 x i32> %add)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)*, i32, <2 x i32>) #1

declare cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x i32>)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (%opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*)* @__OpenCL_OverLap_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"read_only", metadata !"read_only", metadata !"write_only"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"image2d_t", metadata !"image2d_t", metadata !"image2d_t"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"image2d_t", metadata !"image2d_t", metadata !"image2d_t"}
!6 = metadata !{i32 1, i32 2}

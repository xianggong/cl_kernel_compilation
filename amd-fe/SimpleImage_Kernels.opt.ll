; ModuleID = 'SimpleImage_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque
%opencl.image3d_t = type opaque

@imageSampler = addrspace(2) constant i32 20, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_image2dCopy_kernel(%opencl.image2d_t addrspace(1)* %input, %opencl.image2d_t addrspace(1)* %output) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %vecinit = insertelement <2 x i32> undef, i32 %conv, i32 0
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %vecinit3 = insertelement <2 x i32> %vecinit, i32 %conv2, i32 1
  %0 = load i32 addrspace(2)* @imageSampler, align 4
  %call4 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %input, i32 %0, <2 x i32> %vecinit3) #1
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %output, <2 x i32> %vecinit3, <4 x i32> %call4)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)*, i32, <2 x i32>) #1

declare cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x i32>)

; Function Attrs: nounwind
define cc76 void @__OpenCL_image3dCopy_kernel(%opencl.image3d_t addrspace(1)* %input, %opencl.image2d_t addrspace(1)* %output) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %vecinit = insertelement <2 x i32> undef, i32 %conv, i32 0
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %vecinit3 = insertelement <2 x i32> %vecinit, i32 %conv2, i32 1
  %0 = load i32 addrspace(2)* @imageSampler, align 4
  %vext = shufflevector <2 x i32> %vecinit3, <2 x i32> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %vecinit5 = shufflevector <4 x i32> %vext, <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %vecinit6 = insertelement <4 x i32> %vecinit5, i32 0, i32 2
  %vecinit7 = insertelement <4 x i32> %vecinit6, i32 0, i32 3
  %call8 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image3d11ocl_samplerDv4_i(%opencl.image3d_t addrspace(1)* %input, i32 %0, <4 x i32> %vecinit7) #1
  %1 = load i32 addrspace(2)* @imageSampler, align 4
  %call11 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv12 = trunc i64 %call11 to i32
  %vecinit13 = insertelement <2 x i32> undef, i32 %conv12, i32 0
  %call14 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %call15 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %div = udiv i64 %call15, 2
  %sub = sub i64 %call14, %div
  %conv16 = trunc i64 %sub to i32
  %vecinit17 = insertelement <2 x i32> %vecinit13, i32 %conv16, i32 1
  %vext18 = shufflevector <2 x i32> %vecinit17, <2 x i32> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %vecinit19 = shufflevector <4 x i32> %vext18, <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %vecinit20 = insertelement <4 x i32> %vecinit19, i32 1, i32 2
  %vecinit21 = insertelement <4 x i32> %vecinit20, i32 0, i32 3
  %call22 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image3d11ocl_samplerDv4_i(%opencl.image3d_t addrspace(1)* %input, i32 %1, <4 x i32> %vecinit21) #1
  %add = add <4 x i32> %call8, %call22
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %output, <2 x i32> %vecinit3, <4 x i32> %add)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z12read_imageui11ocl_image3d11ocl_samplerDv4_i(%opencl.image3d_t addrspace(1)*, i32, <4 x i32>) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!9}
!opencl.spir.version = !{!9}

!0 = metadata !{void (%opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*)* @__OpenCL_image2dCopy_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"read_only", metadata !"write_only"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"image2d_t", metadata !"image2d_t"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"image2d_t", metadata !"image2d_t"}
!6 = metadata !{void (%opencl.image3d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*)* @__OpenCL_image3dCopy_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"image3d_t", metadata !"image2d_t"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"image3d_t", metadata !"image2d_t"}
!9 = metadata !{i32 1, i32 2}

; ModuleID = 'BufferImageInterop_kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

; Function Attrs: nounwind
define cc76 void @__OpenCL_sepiaToning_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %mul = mul nsw i32 %conv4, %conv2
  %add = add nsw i32 %conv, %mul
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom
  %0 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %1 = extractelement <4 x i8> %0, i32 0
  %conv5 = zext i8 %1 to i32
  %idxprom6 = sext i32 %add to i64
  %arrayidx7 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom6
  %2 = load <4 x i8> addrspace(1)* %arrayidx7, align 4
  %3 = extractelement <4 x i8> %2, i32 1
  %conv8 = zext i8 %3 to i32
  %idxprom9 = sext i32 %add to i64
  %arrayidx10 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom9
  %4 = load <4 x i8> addrspace(1)* %arrayidx10, align 4
  %5 = extractelement <4 x i8> %4, i32 2
  %conv11 = zext i8 %5 to i32
  %conv12 = sitofp i32 %conv5 to double
  %conv14 = sitofp i32 %conv8 to double
  %mul15 = fmul double 5.900000e-01, %conv14
  %6 = call double @llvm.fmuladd.f64(double 3.000000e-01, double %conv12, double %mul15)
  %conv16 = sitofp i32 %conv11 to double
  %7 = call double @llvm.fmuladd.f64(double 1.100000e-01, double %conv16, double %6)
  %conv18 = fptrunc double %7 to float
  %conv19 = fpext float %conv18 to double
  %conv20 = fpext float 0x3FFCCCCCC0000000 to double
  %8 = call double @llvm.fmuladd.f64(double %conv20, double 5.660000e+01, double %conv19)
  %conv22 = fptosi double %8 to i32
  %cmp = icmp sgt i32 %conv22, 255
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %red.0 = phi i32 [ 255, %if.then ], [ %conv22, %entry ]
  %conv24 = fpext float %conv18 to double
  %conv25 = fpext float 0x3FFCCCCCC0000000 to double
  %9 = call double @llvm.fmuladd.f64(double %conv25, double 3.330000e+01, double %conv24)
  %conv27 = fptosi double %9 to i32
  %cmp28 = icmp sgt i32 %conv27, 255
  br i1 %cmp28, label %if.then30, label %if.end31

if.then30:                                        ; preds = %if.end
  br label %if.end31

if.end31:                                         ; preds = %if.then30, %if.end
  %green.0 = phi i32 [ 255, %if.then30 ], [ %conv27, %if.end ]
  %conv32 = fpext float %conv18 to double
  %conv33 = fpext float 0x3FFCCCCCC0000000 to double
  %10 = call double @llvm.fmuladd.f64(double %conv33, double 1.010000e+01, double %conv32)
  %conv35 = fptosi double %10 to i32
  %cmp36 = icmp sgt i32 %conv35, 255
  br i1 %cmp36, label %if.then38, label %if.end39

if.then38:                                        ; preds = %if.end31
  br label %if.end39

if.end39:                                         ; preds = %if.then38, %if.end31
  %blue.0 = phi i32 [ 255, %if.then38 ], [ %conv35, %if.end31 ]
  %cmp40 = icmp eq i32 %conv, 1
  br i1 %cmp40, label %land.lhs.true, label %if.end45

land.lhs.true:                                    ; preds = %if.end39
  %cmp42 = icmp eq i32 %conv2, 0
  br i1 %cmp42, label %if.then44, label %if.end45

if.then44:                                        ; preds = %land.lhs.true
  br label %if.end45

if.end45:                                         ; preds = %if.then44, %land.lhs.true, %if.end39
  %conv46 = trunc i32 %red.0 to i8
  %idxprom47 = sext i32 %add to i64
  %arrayidx48 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom47
  %11 = load <4 x i8> addrspace(1)* %arrayidx48, align 4
  %12 = insertelement <4 x i8> %11, i8 %conv46, i32 0
  store <4 x i8> %12, <4 x i8> addrspace(1)* %arrayidx48, align 4
  %conv49 = trunc i32 %green.0 to i8
  %idxprom50 = sext i32 %add to i64
  %arrayidx51 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom50
  %13 = load <4 x i8> addrspace(1)* %arrayidx51, align 4
  %14 = insertelement <4 x i8> %13, i8 %conv49, i32 1
  store <4 x i8> %14, <4 x i8> addrspace(1)* %arrayidx51, align 4
  %conv52 = trunc i32 %blue.0 to i8
  %idxprom53 = sext i32 %add to i64
  %arrayidx54 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom53
  %15 = load <4 x i8> addrspace(1)* %arrayidx54, align 4
  %16 = insertelement <4 x i8> %15, i8 %conv52, i32 2
  store <4 x i8> %16, <4 x i8> addrspace(1)* %arrayidx54, align 4
  %idxprom55 = sext i32 %add to i64
  %arrayidx56 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom55
  %17 = load <4 x i8> addrspace(1)* %arrayidx56, align 4
  %18 = extractelement <4 x i8> %17, i32 3
  %idxprom57 = sext i32 %add to i64
  %arrayidx58 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom57
  %19 = load <4 x i8> addrspace(1)* %arrayidx58, align 4
  %20 = insertelement <4 x i8> %19, i8 %18, i32 3
  store <4 x i8> %20, <4 x i8> addrspace(1)* %arrayidx58, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

; Function Attrs: nounwind readnone
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_imageReverse_kernel(%opencl.image2d_t addrspace(1)* %inputImage, %opencl.image2d_t addrspace(1)* %outputImage) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %dec = add nsw i32 %conv4, -1
  %0 = insertelement <2 x i32> undef, i32 %conv, i32 0
  %1 = insertelement <2 x i32> %0, i32 %conv2, i32 1
  %call5 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %inputImage, i32 20, <2 x i32> %1) #1
  %sub = sub nsw i32 %dec, %conv
  %2 = insertelement <2 x i32> %1, i32 %sub, i32 0
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %outputImage, <2 x i32> %2, <4 x i32> %call5)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)*, i32, <2 x i32>) #1

declare cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x i32>)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!10}
!opencl.spir.version = !{!10}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*)* @__OpenCL_sepiaToning_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"uchar4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"uchar4*"}
!6 = metadata !{void (%opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*)* @__OpenCL_imageReverse_kernel, metadata !1, metadata !7, metadata !8, metadata !4, metadata !9}
!7 = metadata !{metadata !"kernel_arg_access_qual", metadata !"read_only", metadata !"write_only"}
!8 = metadata !{metadata !"kernel_arg_type", metadata !"image2d_t", metadata !"image2d_t"}
!9 = metadata !{metadata !"kernel_arg_base_type", metadata !"image2d_t", metadata !"image2d_t"}
!10 = metadata !{i32 1, i32 2}

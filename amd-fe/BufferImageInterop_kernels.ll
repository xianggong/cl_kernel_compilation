; ModuleID = 'BufferImageInterop_kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

; Function Attrs: nounwind
define cc76 void @__OpenCL_sepiaToning_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage) #0 {
entry:
  %inputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %outputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %dim = alloca i32, align 4
  %dim1 = alloca i32, align 4
  %width = alloca i32, align 4
  %red = alloca i32, align 4
  %green = alloca i32, align 4
  %blue = alloca i32, align 4
  %index = alloca i32, align 4
  %grayscale = alloca float, align 4
  %depth = alloca float, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %inputImage.addr, align 8
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %dim, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %dim1, align 4
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %width, align 4
  %0 = load i32* %dim, align 4
  %1 = load i32* %width, align 4
  %2 = load i32* %dim1, align 4
  %mul = mul nsw i32 %1, %2
  %add = add nsw i32 %0, %mul
  store i32 %add, i32* %index, align 4
  %3 = load i32* %index, align 4
  %idxprom = sext i32 %3 to i64
  %4 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %4, i64 %idxprom
  %5 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %6 = extractelement <4 x i8> %5, i32 0
  %conv5 = zext i8 %6 to i32
  store i32 %conv5, i32* %red, align 4
  %7 = load i32* %index, align 4
  %idxprom6 = sext i32 %7 to i64
  %8 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx7 = getelementptr inbounds <4 x i8> addrspace(1)* %8, i64 %idxprom6
  %9 = load <4 x i8> addrspace(1)* %arrayidx7, align 4
  %10 = extractelement <4 x i8> %9, i32 1
  %conv8 = zext i8 %10 to i32
  store i32 %conv8, i32* %green, align 4
  %11 = load i32* %index, align 4
  %idxprom9 = sext i32 %11 to i64
  %12 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx10 = getelementptr inbounds <4 x i8> addrspace(1)* %12, i64 %idxprom9
  %13 = load <4 x i8> addrspace(1)* %arrayidx10, align 4
  %14 = extractelement <4 x i8> %13, i32 2
  %conv11 = zext i8 %14 to i32
  store i32 %conv11, i32* %blue, align 4
  %15 = load i32* %red, align 4
  %conv12 = sitofp i32 %15 to double
  %16 = load i32* %green, align 4
  %conv14 = sitofp i32 %16 to double
  %mul15 = fmul double 5.900000e-01, %conv14
  %17 = call double @llvm.fmuladd.f64(double 3.000000e-01, double %conv12, double %mul15)
  %18 = load i32* %blue, align 4
  %conv16 = sitofp i32 %18 to double
  %19 = call double @llvm.fmuladd.f64(double 1.100000e-01, double %conv16, double %17)
  %conv18 = fptrunc double %19 to float
  store float %conv18, float* %grayscale, align 4
  store float 0x3FFCCCCCC0000000, float* %depth, align 4
  %20 = load float* %grayscale, align 4
  %conv19 = fpext float %20 to double
  %21 = load float* %depth, align 4
  %conv20 = fpext float %21 to double
  %22 = call double @llvm.fmuladd.f64(double %conv20, double 5.660000e+01, double %conv19)
  %conv22 = fptosi double %22 to i32
  store i32 %conv22, i32* %red, align 4
  %23 = load i32* %red, align 4
  %cmp = icmp sgt i32 %23, 255
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 255, i32* %red, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %24 = load float* %grayscale, align 4
  %conv24 = fpext float %24 to double
  %25 = load float* %depth, align 4
  %conv25 = fpext float %25 to double
  %26 = call double @llvm.fmuladd.f64(double %conv25, double 3.330000e+01, double %conv24)
  %conv27 = fptosi double %26 to i32
  store i32 %conv27, i32* %green, align 4
  %27 = load i32* %green, align 4
  %cmp28 = icmp sgt i32 %27, 255
  br i1 %cmp28, label %if.then30, label %if.end31

if.then30:                                        ; preds = %if.end
  store i32 255, i32* %green, align 4
  br label %if.end31

if.end31:                                         ; preds = %if.then30, %if.end
  %28 = load float* %grayscale, align 4
  %conv32 = fpext float %28 to double
  %29 = load float* %depth, align 4
  %conv33 = fpext float %29 to double
  %30 = call double @llvm.fmuladd.f64(double %conv33, double 1.010000e+01, double %conv32)
  %conv35 = fptosi double %30 to i32
  store i32 %conv35, i32* %blue, align 4
  %31 = load i32* %blue, align 4
  %cmp36 = icmp sgt i32 %31, 255
  br i1 %cmp36, label %if.then38, label %if.end39

if.then38:                                        ; preds = %if.end31
  store i32 255, i32* %blue, align 4
  br label %if.end39

if.end39:                                         ; preds = %if.then38, %if.end31
  %32 = load i32* %dim, align 4
  %cmp40 = icmp eq i32 %32, 1
  br i1 %cmp40, label %land.lhs.true, label %if.end45

land.lhs.true:                                    ; preds = %if.end39
  %33 = load i32* %dim1, align 4
  %cmp42 = icmp eq i32 %33, 0
  br i1 %cmp42, label %if.then44, label %if.end45

if.then44:                                        ; preds = %land.lhs.true
  br label %if.end45

if.end45:                                         ; preds = %if.then44, %land.lhs.true, %if.end39
  %34 = load i32* %red, align 4
  %conv46 = trunc i32 %34 to i8
  %35 = load i32* %index, align 4
  %idxprom47 = sext i32 %35 to i64
  %36 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx48 = getelementptr inbounds <4 x i8> addrspace(1)* %36, i64 %idxprom47
  %37 = load <4 x i8> addrspace(1)* %arrayidx48, align 4
  %38 = insertelement <4 x i8> %37, i8 %conv46, i32 0
  store <4 x i8> %38, <4 x i8> addrspace(1)* %arrayidx48, align 4
  %39 = load i32* %green, align 4
  %conv49 = trunc i32 %39 to i8
  %40 = load i32* %index, align 4
  %idxprom50 = sext i32 %40 to i64
  %41 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx51 = getelementptr inbounds <4 x i8> addrspace(1)* %41, i64 %idxprom50
  %42 = load <4 x i8> addrspace(1)* %arrayidx51, align 4
  %43 = insertelement <4 x i8> %42, i8 %conv49, i32 1
  store <4 x i8> %43, <4 x i8> addrspace(1)* %arrayidx51, align 4
  %44 = load i32* %blue, align 4
  %conv52 = trunc i32 %44 to i8
  %45 = load i32* %index, align 4
  %idxprom53 = sext i32 %45 to i64
  %46 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx54 = getelementptr inbounds <4 x i8> addrspace(1)* %46, i64 %idxprom53
  %47 = load <4 x i8> addrspace(1)* %arrayidx54, align 4
  %48 = insertelement <4 x i8> %47, i8 %conv52, i32 2
  store <4 x i8> %48, <4 x i8> addrspace(1)* %arrayidx54, align 4
  %49 = load i32* %index, align 4
  %idxprom55 = sext i32 %49 to i64
  %50 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx56 = getelementptr inbounds <4 x i8> addrspace(1)* %50, i64 %idxprom55
  %51 = load <4 x i8> addrspace(1)* %arrayidx56, align 4
  %52 = extractelement <4 x i8> %51, i32 3
  %53 = load i32* %index, align 4
  %idxprom57 = sext i32 %53 to i64
  %54 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx58 = getelementptr inbounds <4 x i8> addrspace(1)* %54, i64 %idxprom57
  %55 = load <4 x i8> addrspace(1)* %arrayidx58, align 4
  %56 = insertelement <4 x i8> %55, i8 %52, i32 3
  store <4 x i8> %56, <4 x i8> addrspace(1)* %arrayidx58, align 4
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
  %inputImage.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %outputImage.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %coord = alloca <2 x i32>, align 8
  %sampler = alloca i32, align 4
  %pixel = alloca <4 x i32>, align 16
  store %opencl.image2d_t addrspace(1)* %inputImage, %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  store %opencl.image2d_t addrspace(1)* %outputImage, %opencl.image2d_t addrspace(1)** %outputImage.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %y, align 4
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %width, align 4
  %0 = load i32* %width, align 4
  %dec = add nsw i32 %0, -1
  store i32 %dec, i32* %width, align 4
  %1 = load i32* %x, align 4
  %2 = load <2 x i32>* %coord, align 8
  %3 = insertelement <2 x i32> %2, i32 %1, i32 0
  store <2 x i32> %3, <2 x i32>* %coord, align 8
  %4 = load i32* %y, align 4
  %5 = load <2 x i32>* %coord, align 8
  %6 = insertelement <2 x i32> %5, i32 %4, i32 1
  store <2 x i32> %6, <2 x i32>* %coord, align 8
  store i32 20, i32* %sampler, align 4
  %7 = load %opencl.image2d_t addrspace(1)** %inputImage.addr, align 8
  %8 = load i32* %sampler, align 4
  %9 = load <2 x i32>* %coord, align 8
  %call5 = call cc75 <4 x i32> @_Z12read_imageui11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %7, i32 %8, <2 x i32> %9) #1
  store <4 x i32> %call5, <4 x i32>* %pixel, align 16
  %10 = load i32* %width, align 4
  %11 = load i32* %x, align 4
  %sub = sub nsw i32 %10, %11
  %12 = load <2 x i32>* %coord, align 8
  %13 = insertelement <2 x i32> %12, i32 %sub, i32 0
  store <2 x i32> %13, <2 x i32>* %coord, align 8
  %14 = load %opencl.image2d_t addrspace(1)** %outputImage.addr, align 8
  %15 = load <2 x i32>* %coord, align 8
  %16 = load <4 x i32>* %pixel, align 16
  call cc75 void @_Z13write_imageui11ocl_image2dDv2_iDv4_j(%opencl.image2d_t addrspace(1)* %14, <2 x i32> %15, <4 x i32> %16)
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

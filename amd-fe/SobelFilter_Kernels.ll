; ModuleID = 'SobelFilter_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_sobel_filter_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage) #0 {
entry:
  %inputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %outputImage.addr = alloca <4 x i8> addrspace(1)*, align 8
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %Gx = alloca <4 x float>, align 16
  %Gy = alloca <4 x float>, align 16
  %c = alloca i32, align 4
  %i00 = alloca <4 x float>, align 16
  %i10 = alloca <4 x float>, align 16
  %i20 = alloca <4 x float>, align 16
  %i01 = alloca <4 x float>, align 16
  %i11 = alloca <4 x float>, align 16
  %i21 = alloca <4 x float>, align 16
  %i02 = alloca <4 x float>, align 16
  %i12 = alloca <4 x float>, align 16
  %i22 = alloca <4 x float>, align 16
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %inputImage.addr, align 8
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %x, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %y, align 4
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %width, align 4
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %height, align 4
  store <4 x float> zeroinitializer, <4 x float>* %Gx, align 16
  %0 = load <4 x float>* %Gx, align 16
  store <4 x float> %0, <4 x float>* %Gy, align 16
  %1 = load i32* %x, align 4
  %2 = load i32* %y, align 4
  %3 = load i32* %width, align 4
  %mul = mul i32 %2, %3
  %add = add i32 %1, %mul
  store i32 %add, i32* %c, align 4
  %4 = load i32* %x, align 4
  %cmp = icmp uge i32 %4, 1
  br i1 %cmp, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %5 = load i32* %x, align 4
  %6 = load i32* %width, align 4
  %sub = sub i32 %6, 1
  %cmp8 = icmp ult i32 %5, %sub
  br i1 %cmp8, label %land.lhs.true10, label %if.end

land.lhs.true10:                                  ; preds = %land.lhs.true
  %7 = load i32* %y, align 4
  %cmp11 = icmp uge i32 %7, 1
  br i1 %cmp11, label %land.lhs.true13, label %if.end

land.lhs.true13:                                  ; preds = %land.lhs.true10
  %8 = load i32* %y, align 4
  %9 = load i32* %height, align 4
  %sub14 = sub i32 %9, 1
  %cmp15 = icmp ult i32 %8, %sub14
  br i1 %cmp15, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true13
  %10 = load i32* %c, align 4
  %sub17 = sub nsw i32 %10, 1
  %11 = load i32* %width, align 4
  %sub18 = sub i32 %sub17, %11
  %idxprom = zext i32 %sub18 to i64
  %12 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %12, i64 %idxprom
  %13 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %call19 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %13) #1
  store <4 x float> %call19, <4 x float>* %i00, align 16
  %14 = load i32* %c, align 4
  %15 = load i32* %width, align 4
  %sub20 = sub i32 %14, %15
  %idxprom21 = zext i32 %sub20 to i64
  %16 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx22 = getelementptr inbounds <4 x i8> addrspace(1)* %16, i64 %idxprom21
  %17 = load <4 x i8> addrspace(1)* %arrayidx22, align 4
  %call23 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %17) #1
  store <4 x float> %call23, <4 x float>* %i10, align 16
  %18 = load i32* %c, align 4
  %add24 = add nsw i32 %18, 1
  %19 = load i32* %width, align 4
  %sub25 = sub i32 %add24, %19
  %idxprom26 = zext i32 %sub25 to i64
  %20 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx27 = getelementptr inbounds <4 x i8> addrspace(1)* %20, i64 %idxprom26
  %21 = load <4 x i8> addrspace(1)* %arrayidx27, align 4
  %call28 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %21) #1
  store <4 x float> %call28, <4 x float>* %i20, align 16
  %22 = load i32* %c, align 4
  %sub29 = sub nsw i32 %22, 1
  %idxprom30 = sext i32 %sub29 to i64
  %23 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx31 = getelementptr inbounds <4 x i8> addrspace(1)* %23, i64 %idxprom30
  %24 = load <4 x i8> addrspace(1)* %arrayidx31, align 4
  %call32 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %24) #1
  store <4 x float> %call32, <4 x float>* %i01, align 16
  %25 = load i32* %c, align 4
  %idxprom33 = sext i32 %25 to i64
  %26 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx34 = getelementptr inbounds <4 x i8> addrspace(1)* %26, i64 %idxprom33
  %27 = load <4 x i8> addrspace(1)* %arrayidx34, align 4
  %call35 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %27) #1
  store <4 x float> %call35, <4 x float>* %i11, align 16
  %28 = load i32* %c, align 4
  %add36 = add nsw i32 %28, 1
  %idxprom37 = sext i32 %add36 to i64
  %29 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx38 = getelementptr inbounds <4 x i8> addrspace(1)* %29, i64 %idxprom37
  %30 = load <4 x i8> addrspace(1)* %arrayidx38, align 4
  %call39 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %30) #1
  store <4 x float> %call39, <4 x float>* %i21, align 16
  %31 = load i32* %c, align 4
  %sub40 = sub nsw i32 %31, 1
  %32 = load i32* %width, align 4
  %add41 = add i32 %sub40, %32
  %idxprom42 = zext i32 %add41 to i64
  %33 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx43 = getelementptr inbounds <4 x i8> addrspace(1)* %33, i64 %idxprom42
  %34 = load <4 x i8> addrspace(1)* %arrayidx43, align 4
  %call44 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %34) #1
  store <4 x float> %call44, <4 x float>* %i02, align 16
  %35 = load i32* %c, align 4
  %36 = load i32* %width, align 4
  %add45 = add i32 %35, %36
  %idxprom46 = zext i32 %add45 to i64
  %37 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx47 = getelementptr inbounds <4 x i8> addrspace(1)* %37, i64 %idxprom46
  %38 = load <4 x i8> addrspace(1)* %arrayidx47, align 4
  %call48 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %38) #1
  store <4 x float> %call48, <4 x float>* %i12, align 16
  %39 = load i32* %c, align 4
  %add49 = add nsw i32 %39, 1
  %40 = load i32* %width, align 4
  %add50 = add i32 %add49, %40
  %idxprom51 = zext i32 %add50 to i64
  %41 = load <4 x i8> addrspace(1)** %inputImage.addr, align 8
  %arrayidx52 = getelementptr inbounds <4 x i8> addrspace(1)* %41, i64 %idxprom51
  %42 = load <4 x i8> addrspace(1)* %arrayidx52, align 4
  %call53 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %42) #1
  store <4 x float> %call53, <4 x float>* %i22, align 16
  %43 = load <4 x float>* %i00, align 16
  %44 = load <4 x float>* %i10, align 16
  %45 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %44, <4 x float> %43)
  %46 = load <4 x float>* %i20, align 16
  %add55 = fadd <4 x float> %45, %46
  %47 = load <4 x float>* %i02, align 16
  %sub56 = fsub <4 x float> %add55, %47
  %48 = load <4 x float>* %i12, align 16
  %mul57 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %48
  %sub58 = fsub <4 x float> %sub56, %mul57
  %49 = load <4 x float>* %i22, align 16
  %sub59 = fsub <4 x float> %sub58, %49
  store <4 x float> %sub59, <4 x float>* %Gx, align 16
  %50 = load <4 x float>* %i00, align 16
  %51 = load <4 x float>* %i20, align 16
  %sub60 = fsub <4 x float> %50, %51
  %52 = load <4 x float>* %i01, align 16
  %mul61 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %52
  %add62 = fadd <4 x float> %sub60, %mul61
  %53 = load <4 x float>* %i21, align 16
  %mul63 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %53
  %sub64 = fsub <4 x float> %add62, %mul63
  %54 = load <4 x float>* %i02, align 16
  %add65 = fadd <4 x float> %sub64, %54
  %55 = load <4 x float>* %i22, align 16
  %sub66 = fsub <4 x float> %add65, %55
  store <4 x float> %sub66, <4 x float>* %Gy, align 16
  %56 = load <4 x float>* %Gx, align 16
  %57 = load <4 x float>* %Gy, align 16
  %call67 = call cc75 <4 x float> @_Z5hypotDv4_fS_(<4 x float> %56, <4 x float> %57) #1
  %div = fdiv <4 x float> %call67, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !7
  %call68 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %div) #1
  %58 = load i32* %c, align 4
  %idxprom69 = sext i32 %58 to i64
  %59 = load <4 x i8> addrspace(1)** %outputImage.addr, align 8
  %arrayidx70 = getelementptr inbounds <4 x i8> addrspace(1)* %59, i64 %idxprom69
  store <4 x i8> %call68, <4 x i8> addrspace(1)* %arrayidx70, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true13, %land.lhs.true10, %land.lhs.true, %entry
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z5hypotDv4_fS_(<4 x float>, <4 x float>) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*)* @__OpenCL_sobel_filter_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar4*", metadata !"uchar4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar4*", metadata !"uchar4*"}
!6 = metadata !{i32 1, i32 2}
!7 = metadata !{float 2.500000e+00}

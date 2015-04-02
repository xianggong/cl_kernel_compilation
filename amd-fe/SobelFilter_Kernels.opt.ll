; ModuleID = 'SobelFilter_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_sobel_filter_kernel(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z15get_global_sizej(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %mul = mul i32 %conv2, %conv4
  %add = add i32 %conv, %mul
  %cmp = icmp uge i32 %conv, 1
  br i1 %cmp, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %sub = sub i32 %conv4, 1
  %cmp8 = icmp ult i32 %conv, %sub
  br i1 %cmp8, label %land.lhs.true10, label %if.end

land.lhs.true10:                                  ; preds = %land.lhs.true
  %cmp11 = icmp uge i32 %conv2, 1
  br i1 %cmp11, label %land.lhs.true13, label %if.end

land.lhs.true13:                                  ; preds = %land.lhs.true10
  %sub14 = sub i32 %conv6, 1
  %cmp15 = icmp ult i32 %conv2, %sub14
  br i1 %cmp15, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true13
  %sub17 = sub nsw i32 %add, 1
  %sub18 = sub i32 %sub17, %conv4
  %idxprom = zext i32 %sub18 to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom
  %0 = load <4 x i8> addrspace(1)* %arrayidx, align 4
  %call19 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %0) #1
  %sub20 = sub i32 %add, %conv4
  %idxprom21 = zext i32 %sub20 to i64
  %arrayidx22 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom21
  %1 = load <4 x i8> addrspace(1)* %arrayidx22, align 4
  %call23 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %1) #1
  %add24 = add nsw i32 %add, 1
  %sub25 = sub i32 %add24, %conv4
  %idxprom26 = zext i32 %sub25 to i64
  %arrayidx27 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom26
  %2 = load <4 x i8> addrspace(1)* %arrayidx27, align 4
  %call28 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %2) #1
  %sub29 = sub nsw i32 %add, 1
  %idxprom30 = sext i32 %sub29 to i64
  %arrayidx31 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom30
  %3 = load <4 x i8> addrspace(1)* %arrayidx31, align 4
  %call32 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %3) #1
  %idxprom33 = sext i32 %add to i64
  %arrayidx34 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom33
  %4 = load <4 x i8> addrspace(1)* %arrayidx34, align 4
  %call35 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %4) #1
  %add36 = add nsw i32 %add, 1
  %idxprom37 = sext i32 %add36 to i64
  %arrayidx38 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom37
  %5 = load <4 x i8> addrspace(1)* %arrayidx38, align 4
  %call39 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %5) #1
  %sub40 = sub nsw i32 %add, 1
  %add41 = add i32 %sub40, %conv4
  %idxprom42 = zext i32 %add41 to i64
  %arrayidx43 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom42
  %6 = load <4 x i8> addrspace(1)* %arrayidx43, align 4
  %call44 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %6) #1
  %add45 = add i32 %add, %conv4
  %idxprom46 = zext i32 %add45 to i64
  %arrayidx47 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom46
  %7 = load <4 x i8> addrspace(1)* %arrayidx47, align 4
  %call48 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %7) #1
  %add49 = add nsw i32 %add, 1
  %add50 = add i32 %add49, %conv4
  %idxprom51 = zext i32 %add50 to i64
  %arrayidx52 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %idxprom51
  %8 = load <4 x i8> addrspace(1)* %arrayidx52, align 4
  %call53 = call cc75 <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %8) #1
  %9 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %call23, <4 x float> %call19)
  %add55 = fadd <4 x float> %9, %call28
  %sub56 = fsub <4 x float> %add55, %call44
  %mul57 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %call48
  %sub58 = fsub <4 x float> %sub56, %mul57
  %sub59 = fsub <4 x float> %sub58, %call53
  %sub60 = fsub <4 x float> %call19, %call28
  %mul61 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %call32
  %add62 = fadd <4 x float> %sub60, %mul61
  %mul63 = fmul <4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, %call39
  %sub64 = fsub <4 x float> %add62, %mul63
  %add65 = fadd <4 x float> %sub64, %call44
  %sub66 = fsub <4 x float> %add65, %call53
  %call67 = call cc75 <4 x float> @_Z5hypotDv4_fS_(<4 x float> %sub59, <4 x float> %sub66) #1
  %div = fdiv <4 x float> %call67, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !7
  %call68 = call cc75 <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %div) #1
  %idxprom69 = sext i32 %add to i64
  %arrayidx70 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %idxprom69
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

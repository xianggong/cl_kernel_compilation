; ModuleID = '../kernel-src/GaussianNoiseGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

%opencl.image2d_t = type opaque

@gaussian_transform.iv0 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4
@gaussian_transform.iv1 = internal addrspace(3) global [256 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @gaussian_transform(<4 x i8> addrspace(1)* nocapture readonly %inputImage, %opencl.image2d_t* %outputImage, i32 %factor) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #2
  %call1 = tail call i32 @get_global_size(i32 0) #2
  %mul = shl i32 %call1, 1
  %call2 = tail call i32 @get_global_id(i32 1) #2
  %mul3 = mul i32 %mul, %call2
  %add = add i32 %mul3, %call
  %call4 = tail call i32 @get_global_id(i32 0) #2
  %call5 = tail call i32 @get_global_size(i32 0) #2
  %add6 = add i32 %call5, %call4
  %call7 = tail call i32 @get_global_size(i32 0) #2
  %mul8 = shl i32 %call7, 1
  %call9 = tail call i32 @get_global_id(i32 1) #2
  %mul10 = mul i32 %mul8, %call9
  %add11 = add i32 %add6, %mul10
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %0
  %1 = load <4 x i8> addrspace(1)* %arrayidx, align 4, !tbaa !2
  %call12 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %1) #2
  %2 = sext i32 %add11 to i64
  %arrayidx13 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %2
  %3 = load <4 x i8> addrspace(1)* %arrayidx13, align 4, !tbaa !2
  %call14 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %3) #2
  %4 = extractelement <4 x float> %call12, i32 0
  %5 = extractelement <4 x float> %call12, i32 1
  %add15 = fadd float %4, %5
  %6 = extractelement <4 x float> %call12, i32 2
  %add16 = fadd float %6, %add15
  %7 = extractelement <4 x float> %call12, i32 3
  %add17 = fadd float %7, %add16
  %div = fmul float %add17, 2.500000e-01
  %8 = extractelement <4 x float> %call14, i32 0
  %9 = extractelement <4 x float> %call14, i32 1
  %add18 = fadd float %8, %9
  %10 = extractelement <4 x float> %call14, i32 2
  %add19 = fadd float %10, %add18
  %11 = extractelement <4 x float> %call14, i32 3
  %add20 = fadd float %11, %add19
  %div21 = fmul float %add20, 2.500000e-01
  %sub = fsub float -0.000000e+00, %div
  %conv = fptosi float %sub to i32
  %call22 = tail call float @ran1(i32 %conv, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv0, i32 0, i32 0)) #2
  %sub23 = fsub float -0.000000e+00, %div21
  %conv24 = fptosi float %sub23 to i32
  %call25 = tail call float @ran1(i32 %conv24, i32 addrspace(3)* getelementptr inbounds ([256 x i32] addrspace(3)* @gaussian_transform.iv1, i32 0, i32 0)) #2
  %vecinit = insertelement <2 x float> undef, float %call22, i32 0
  %vecinit26 = insertelement <2 x float> %vecinit, float %call25, i32 1
  %call27 = tail call <2 x float> @BoxMuller(<2 x float> %vecinit26) #2
  %12 = extractelement <2 x float> %call27, i32 0
  %conv28 = sitofp i32 %factor to float
  %mul29 = fmul float %conv28, %12
  %splat.splatinsert = insertelement <4 x float> undef, float %mul29, i32 0
  %splat.splat = shufflevector <4 x float> %splat.splatinsert, <4 x float> undef, <4 x i32> zeroinitializer
  %add30 = fadd <4 x float> %call12, %splat.splat
  %div31 = fdiv <4 x float> %add30, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !5
  %13 = extractelement <2 x float> %call27, i32 1
  %mul33 = fmul float %conv28, %13
  %splat.splatinsert34 = insertelement <4 x float> undef, float %mul33, i32 0
  %splat.splat35 = shufflevector <4 x float> %splat.splatinsert34, <4 x float> undef, <4 x i32> zeroinitializer
  %add36 = fadd <4 x float> %call14, %splat.splat35
  %div37 = fdiv <4 x float> %add36, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, !fpmath !5
  %call38 = tail call i32 @get_global_id(i32 0) #2
  %14 = insertelement <2 x i32> undef, i32 %call38, i32 0
  %call39 = tail call i32 @get_global_id(i32 1) #2
  %15 = insertelement <2 x i32> %14, i32 %call39, i32 1
  %call40 = tail call i32 @get_global_id(i32 0) #2
  %call41 = tail call i32 @get_global_size(i32 0) #2
  %add42 = add i32 %call41, %call40
  %16 = insertelement <2 x i32> undef, i32 %add42, i32 0
  %call43 = tail call i32 @get_global_id(i32 1) #2
  %17 = insertelement <2 x i32> %16, i32 %call43, i32 1
  %call44 = tail call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t* %outputImage, <2 x i32> %15, <4 x float> %div31) #2
  %call45 = tail call i32 bitcast (i32 (...)* @write_imagef to i32 (%opencl.image2d_t*, <2 x i32>, <4 x float>)*)(%opencl.image2d_t* %outputImage, <2 x i32> %17, <4 x float> %div37) #2
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare float @ran1(i32, i32 addrspace(3)*) #1

declare <2 x float> @BoxMuller(<2 x float>) #1

declare i32 @write_imagef(...) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, %opencl.image2d_t*, i32)* @gaussian_transform}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

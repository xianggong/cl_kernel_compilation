; ModuleID = '../kernel-src/SobelFilter_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @sobel_filter(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #3
  %call1 = tail call i32 @get_global_id(i32 1) #3
  %call2 = tail call i32 @get_global_size(i32 0) #3
  %call3 = tail call i32 @get_global_size(i32 1) #3
  %mul = mul i32 %call2, %call1
  %add = add i32 %mul, %call
  %cmp = icmp eq i32 %call, 0
  br i1 %cmp, label %if.end, label %land.lhs.true

land.lhs.true:                                    ; preds = %entry
  %sub = add i32 %call2, -1
  %cmp4 = icmp ult i32 %call, %sub
  %cmp6 = icmp ne i32 %call1, 0
  %or.cond = and i1 %cmp4, %cmp6
  %sub8 = add i32 %call3, -1
  %cmp9 = icmp ult i32 %call1, %sub8
  %or.cond88 = and i1 %or.cond, %cmp9
  br i1 %or.cond88, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %sub10 = add nsw i32 %add, -1
  %sub11 = sub i32 %sub10, %call2
  %0 = sext i32 %sub11 to i64
  %arrayidx = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %0
  %1 = load <4 x i8> addrspace(1)* %arrayidx, align 4, !tbaa !2
  %call12 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %1) #3
  %sub13 = sub i32 %add, %call2
  %2 = sext i32 %sub13 to i64
  %arrayidx14 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %2
  %3 = load <4 x i8> addrspace(1)* %arrayidx14, align 4, !tbaa !2
  %call15 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %3) #3
  %add16 = add nsw i32 %add, 1
  %sub17 = sub i32 %add16, %call2
  %4 = sext i32 %sub17 to i64
  %arrayidx18 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %4
  %5 = load <4 x i8> addrspace(1)* %arrayidx18, align 4, !tbaa !2
  %call19 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %5) #3
  %6 = sext i32 %sub10 to i64
  %arrayidx21 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %6
  %7 = load <4 x i8> addrspace(1)* %arrayidx21, align 4, !tbaa !2
  %call22 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %7) #3
  %8 = sext i32 %add to i64
  %arrayidx23 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %8
  %9 = load <4 x i8> addrspace(1)* %arrayidx23, align 4, !tbaa !2
  %call24 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %9) #3
  %10 = sext i32 %add16 to i64
  %arrayidx26 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %10
  %11 = load <4 x i8> addrspace(1)* %arrayidx26, align 4, !tbaa !2
  %call27 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %11) #3
  %add29 = add i32 %sub10, %call2
  %12 = sext i32 %add29 to i64
  %arrayidx30 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %12
  %13 = load <4 x i8> addrspace(1)* %arrayidx30, align 4, !tbaa !2
  %call31 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %13) #3
  %add32 = add i32 %add, %call2
  %14 = sext i32 %add32 to i64
  %arrayidx33 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %14
  %15 = load <4 x i8> addrspace(1)* %arrayidx33, align 4, !tbaa !2
  %call34 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %15) #3
  %add36 = add i32 %add16, %call2
  %16 = sext i32 %add36 to i64
  %arrayidx37 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i64 %16
  %17 = load <4 x i8> addrspace(1)* %arrayidx37, align 4, !tbaa !2
  %call38 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %17) #3
  %18 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, <4 x float> %call15, <4 x float> %call12)
  %add40 = fadd <4 x float> %call19, %18
  %sub41 = fsub <4 x float> %add40, %call31
  %mul42 = fmul <4 x float> %call34, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %sub43 = fsub <4 x float> %sub41, %mul42
  %sub44 = fsub <4 x float> %sub43, %call38
  %sub45 = fsub <4 x float> %call12, %call19
  %mul46 = fmul <4 x float> %call22, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %add47 = fadd <4 x float> %sub45, %mul46
  %mul48 = fmul <4 x float> %call27, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %sub49 = fsub <4 x float> %add47, %mul48
  %add50 = fadd <4 x float> %sub49, %call31
  %sub51 = fsub <4 x float> %add50, %call38
  %call52 = tail call <4 x float> @_Z5hypotDv4_fS_(<4 x float> %sub44, <4 x float> %sub51) #3
  %div = fdiv <4 x float> %call52, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !5
  %call53 = tail call <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %div) #3
  %arrayidx54 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i64 %8
  store <4 x i8> %call53, <4 x i8> addrspace(1)* %arrayidx54, align 4, !tbaa !2
  br label %if.end

if.end:                                           ; preds = %entry, %if.then, %land.lhs.true
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float>) #1

declare <4 x float> @_Z5hypotDv4_fS_(<4 x float>, <4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*)* @sobel_filter}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{float 2.500000e+00}

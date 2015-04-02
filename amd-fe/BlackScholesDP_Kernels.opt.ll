; ModuleID = 'BlackScholesDP_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc75 void @phi(<4 x double> %X, <4 x double>* %phi) #0 {
entry:
  %call = call cc75 <4 x double> @_Z4fabsDv4_d(<4 x double> %X) #1
  %0 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 2.316419e-01, double 2.316419e-01, double 2.316419e-01, double 2.316419e-01>, <4 x double> %call, <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>)
  %div = fdiv <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %0
  %sub = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %X
  %mul = fmul <4 x double> %sub, %X
  %div1 = fdiv <4 x double> %mul, <double 2.000000e+00, double 2.000000e+00, double 2.000000e+00, double 2.000000e+00>
  %call2 = call cc75 <4 x double> @_Z3expDv4_d(<4 x double> %div1) #1
  %mul3 = fmul <4 x double> <double 0x3FD988453365DE00, double 0x3FD988453365DE00, double 0x3FD988453365DE00, double 0x3FD988453365DE00>, %call2
  %mul4 = fmul <4 x double> %mul3, %div
  %1 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %div, <4 x double> <double 0x3FF548CDD6F42943, double 0x3FF548CDD6F42943, double 0x3FF548CDD6F42943, double 0x3FF548CDD6F42943>, <4 x double> <double 0xBFFD23DD4EF278D0, double 0xBFFD23DD4EF278D0, double 0xBFFD23DD4EF278D0, double 0xBFFD23DD4EF278D0>)
  %2 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %div, <4 x double> %1, <4 x double> <double 0x3FFC80EF025F5E68, double 0x3FFC80EF025F5E68, double 0x3FFC80EF025F5E68, double 0x3FFC80EF025F5E68>)
  %3 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %div, <4 x double> %2, <4 x double> <double 0xBFD6D1F0E5A8325B, double 0xBFD6D1F0E5A8325B, double 0xBFD6D1F0E5A8325B, double 0xBFD6D1F0E5A8325B>)
  %4 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %div, <4 x double> %3, <4 x double> <double 0x3FD470BF3A92F8EC, double 0x3FD470BF3A92F8EC, double 0x3FD470BF3A92F8EC, double 0x3FD470BF3A92F8EC>)
  %neg = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %mul4
  %5 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %neg, <4 x double> %4, <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>)
  %cmp = fcmp olt <4 x double> %X, zeroinitializer
  %sext = sext <4 x i1> %cmp to <4 x i64>
  %sub10 = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %5
  %6 = icmp slt <4 x i64> %sext, zeroinitializer
  %7 = select <4 x i1> %6, <4 x double> %sub10, <4 x double> %5
  store <4 x double> %7, <4 x double>* %phi, align 32
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z4fabsDv4_d(<4 x double>) #1

; Function Attrs: nounwind readnone
declare <4 x double> @llvm.fmuladd.v4f64(<4 x double>, <4 x double>, <4 x double>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z3expDv4_d(<4 x double>) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_blackScholes_kernel(<4 x double> addrspace(1)* %randArray, i32 %width, <4 x double> addrspace(1)* %call, <4 x double> addrspace(1)* %put) #0 {
entry:
  %phiD1 = alloca <4 x double>, align 32
  %phiD2 = alloca <4 x double>, align 32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call2 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv = sext i32 %width to i64
  %mul = mul i64 %call2, %conv
  %add = add i64 %mul, %call1
  %arrayidx = getelementptr inbounds <4 x double> addrspace(1)* %randArray, i64 %add
  %0 = load <4 x double> addrspace(1)* %arrayidx, align 32
  %sub = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %0
  %mul4 = fmul <4 x double> <double 1.000000e+02, double 1.000000e+02, double 1.000000e+02, double 1.000000e+02>, %sub
  %1 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 1.000000e+01, double 1.000000e+01, double 1.000000e+01, double 1.000000e+01>, <4 x double> %0, <4 x double> %mul4)
  %sub6 = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %0
  %mul7 = fmul <4 x double> <double 1.000000e+02, double 1.000000e+02, double 1.000000e+02, double 1.000000e+02>, %sub6
  %2 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 1.000000e+01, double 1.000000e+01, double 1.000000e+01, double 1.000000e+01>, <4 x double> %0, <4 x double> %mul7)
  %sub9 = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %0
  %mul10 = fmul <4 x double> <double 1.000000e+01, double 1.000000e+01, double 1.000000e+01, double 1.000000e+01>, %sub9
  %3 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, <4 x double> %0, <4 x double> %mul10)
  %sub12 = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %0
  %mul13 = fmul <4 x double> <double 5.000000e-02, double 5.000000e-02, double 5.000000e-02, double 5.000000e-02>, %sub12
  %4 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 1.000000e-02, double 1.000000e-02, double 1.000000e-02, double 1.000000e-02>, <4 x double> %0, <4 x double> %mul13)
  %sub15 = fsub <4 x double> <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>, %0
  %mul16 = fmul <4 x double> <double 1.000000e-01, double 1.000000e-01, double 1.000000e-01, double 1.000000e-01>, %sub15
  %5 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> <double 1.000000e-02, double 1.000000e-02, double 1.000000e-02, double 1.000000e-02>, <4 x double> %0, <4 x double> %mul16)
  %call17 = call cc75 <4 x double> @_Z4sqrtDv4_d(<4 x double> %3) #1
  %mul18 = fmul <4 x double> %5, %call17
  %div = fdiv <4 x double> %1, %2
  %call19 = call cc75 <4 x double> @_Z3logDv4_d(<4 x double> %div) #1
  %mul20 = fmul <4 x double> %5, %5
  %div21 = fdiv <4 x double> %mul20, <double 2.000000e+00, double 2.000000e+00, double 2.000000e+00, double 2.000000e+00>
  %add22 = fadd <4 x double> %4, %div21
  %6 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %add22, <4 x double> %3, <4 x double> %call19)
  %div24 = fdiv <4 x double> %6, %mul18
  %sub25 = fsub <4 x double> %div24, %mul18
  %sub26 = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %4
  %mul27 = fmul <4 x double> %sub26, %3
  %call28 = call cc75 <4 x double> @_Z3expDv4_d(<4 x double> %mul27) #1
  %mul29 = fmul <4 x double> %2, %call28
  call cc75 void @phi(<4 x double> %div24, <4 x double>* %phiD1)
  call cc75 void @phi(<4 x double> %sub25, <4 x double>* %phiD2)
  %7 = load <4 x double>* %phiD1, align 32
  %8 = load <4 x double>* %phiD2, align 32
  %mul31 = fmul <4 x double> %mul29, %8
  %neg = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %mul31
  %9 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %1, <4 x double> %7, <4 x double> %neg)
  %conv32 = sext i32 %width to i64
  %mul33 = mul i64 %call2, %conv32
  %add34 = add i64 %mul33, %call1
  %arrayidx35 = getelementptr inbounds <4 x double> addrspace(1)* %call, i64 %add34
  store <4 x double> %9, <4 x double> addrspace(1)* %arrayidx35, align 32
  %sub36 = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %div24
  call cc75 void @phi(<4 x double> %sub36, <4 x double>* %phiD1)
  %sub37 = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %sub25
  call cc75 void @phi(<4 x double> %sub37, <4 x double>* %phiD2)
  %10 = load <4 x double>* %phiD2, align 32
  %11 = load <4 x double>* %phiD1, align 32
  %mul39 = fmul <4 x double> %1, %11
  %neg40 = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %mul39
  %12 = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> %mul29, <4 x double> %10, <4 x double> %neg40)
  %conv41 = sext i32 %width to i64
  %mul42 = mul i64 %call2, %conv41
  %add43 = add i64 %mul42, %call1
  %arrayidx44 = getelementptr inbounds <4 x double> addrspace(1)* %put, i64 %add43
  store <4 x double> %12, <4 x double> addrspace(1)* %arrayidx44, align 32
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z4sqrtDv4_d(<4 x double>) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x double> @_Z3logDv4_d(<4 x double>) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (<4 x double> addrspace(1)*, i32, <4 x double> addrspace(1)*, <4 x double> addrspace(1)*)* @__OpenCL_blackScholes_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"double4*", metadata !"int", metadata !"double4*", metadata !"double4*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"const", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"double4*", metadata !"int", metadata !"double4*", metadata !"double4*"}
!6 = metadata !{i32 1, i32 2}

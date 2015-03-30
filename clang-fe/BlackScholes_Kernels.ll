; ModuleID = '../kernel-src/BlackScholes_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @phi(<4 x float> %X, <4 x float>* nocapture %phi) #0 {
entry:
  %call = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %X)
  %0 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %call, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %div = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %0, !fpmath !3
  %1 = fmul <4 x float> %X, %X
  %mul = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %1
  %div1 = fdiv <4 x float> %mul, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %call2 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %div1) #4
  %mul3 = fmul <4 x float> %call2, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %mul4 = fmul <4 x float> %div, %mul3
  %2 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>)
  %3 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div, <4 x float> %2, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>)
  %4 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div, <4 x float> %3, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>)
  %5 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div, <4 x float> %4, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>)
  %neg = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul4
  %6 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg, <4 x float> %5, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>)
  %cmp = fcmp olt <4 x float> %X, zeroinitializer
  %sub10 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %6
  %cond.v = select <4 x i1> %cmp, <4 x float> %sub10, <4 x float> %6
  store <4 x float> %cond.v, <4 x float>* %phi, align 16, !tbaa !4
  ret void
}

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.fabs.v4f32(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

declare <4 x float> @_Z3expDv4_f(<4 x float>) #3

; Function Attrs: nounwind
define void @blackScholes(<4 x float> addrspace(1)* nocapture readonly %randArray, i32 %width, <4 x float> addrspace(1)* nocapture %call, <4 x float> addrspace(1)* nocapture %put) #0 {
entry:
  %call1 = tail call i32 @get_global_id(i32 0) #4
  %call2 = tail call i32 @get_global_id(i32 1) #4
  %mul = mul i32 %call2, %width
  %add = add i32 %mul, %call1
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %randArray, i64 %0
  %1 = load <4 x float> addrspace(1)* %arrayidx, align 16, !tbaa !4
  %sub = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %1
  %mul4 = fmul <4 x float> %sub, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %2 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>, <4 x float> %1, <4 x float> %mul4)
  %mul10 = fmul <4 x float> %sub, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %3 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %1, <4 x float> %mul10)
  %mul13 = fmul <4 x float> %sub, <float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000, float 0x3FA99999A0000000>
  %4 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %1, <4 x float> %mul13)
  %mul16 = fmul <4 x float> %sub, <float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000>
  %5 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000, float 0x3F847AE140000000>, <4 x float> %1, <4 x float> %mul16)
  %call17 = tail call <4 x float> @llvm.sqrt.v4f32(<4 x float> %3)
  %mul18 = fmul <4 x float> %5, %call17
  %div = fdiv <4 x float> %2, %2, !fpmath !3
  %call19 = tail call <4 x float> @llvm.log2.v4f32(<4 x float> %div)
  %mul21 = fmul <4 x float> %5, %5
  %div22 = fdiv <4 x float> %mul21, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %add23 = fadd <4 x float> %4, %div22
  %mul24 = fmul <4 x float> %3, %add23
  %6 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %call19, <4 x float> <float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000, float 0x3FE62E4300000000>, <4 x float> %mul24)
  %div25 = fdiv <4 x float> %6, %mul18, !fpmath !3
  %sub26 = fsub <4 x float> %div25, %mul18
  %7 = fmul <4 x float> %3, %4
  %mul28 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %7
  %call29 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %mul28) #4
  %mul30 = fmul <4 x float> %2, %call29
  %call.i = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %div25) #4
  %8 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %call.i, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %div.i = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %8, !fpmath !3
  %9 = fmul <4 x float> %div25, %div25
  %mul.i = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %9
  %div1.i = fdiv <4 x float> %mul.i, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %call2.i = tail call <4 x float> @_Z3expDv4_f(<4 x float> %div1.i) #4
  %mul3.i = fmul <4 x float> %call2.i, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %mul4.i = fmul <4 x float> %div.i, %mul3.i
  %10 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #4
  %11 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i, <4 x float> %10, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #4
  %12 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i, <4 x float> %11, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #4
  %13 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i, <4 x float> %12, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #4
  %neg.i = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul4.i
  %14 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg.i, <4 x float> %13, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %cmp.i = fcmp olt <4 x float> %div25, zeroinitializer
  %sub10.i = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %14
  %cond.v.i = select <4 x i1> %cmp.i, <4 x float> %sub10.i, <4 x float> %14
  %call.i72 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %sub26) #4
  %15 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %call.i72, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %div.i73 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %15, !fpmath !3
  %16 = fmul <4 x float> %sub26, %sub26
  %mul.i74 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %16
  %div1.i75 = fdiv <4 x float> %mul.i74, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>, !fpmath !3
  %call2.i76 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %div1.i75) #4
  %mul3.i77 = fmul <4 x float> %call2.i76, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %mul4.i78 = fmul <4 x float> %div.i73, %mul3.i77
  %17 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i73, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #4
  %18 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i73, <4 x float> %17, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #4
  %19 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i73, <4 x float> %18, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #4
  %20 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i73, <4 x float> %19, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #4
  %neg.i79 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul4.i78
  %21 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg.i79, <4 x float> %20, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %cmp.i80 = fcmp olt <4 x float> %sub26, zeroinitializer
  %sub10.i81 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %21
  %cond.v.i82 = select <4 x i1> %cmp.i80, <4 x float> %sub10.i81, <4 x float> %21
  %mul32 = fmul <4 x float> %mul30, %cond.v.i82
  %neg = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul32
  %22 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %2, <4 x float> %cond.v.i, <4 x float> %neg)
  %arrayidx35 = getelementptr inbounds <4 x float> addrspace(1)* %call, i64 %0
  store <4 x float> %22, <4 x float> addrspace(1)* %arrayidx35, align 16, !tbaa !4
  %sub36 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %div25
  %call.i83 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %sub36) #4
  %23 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %call.i83, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %div.i84 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %23, !fpmath !3
  %call2.i87 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %div1.i) #4
  %mul3.i88 = fmul <4 x float> %call2.i87, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %mul4.i89 = fmul <4 x float> %div.i84, %mul3.i88
  %24 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i84, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #4
  %25 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i84, <4 x float> %24, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #4
  %26 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i84, <4 x float> %25, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #4
  %27 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i84, <4 x float> %26, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #4
  %neg.i90 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul4.i89
  %28 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg.i90, <4 x float> %27, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %cmp.i91 = fcmp olt <4 x float> %sub36, zeroinitializer
  %sub10.i92 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %28
  %cond.v.i93 = select <4 x i1> %cmp.i91, <4 x float> %sub10.i92, <4 x float> %28
  %sub37 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %sub26
  %call.i94 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %sub37) #4
  %29 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> <float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000, float 0x3FCDA67120000000>, <4 x float> %call.i94, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %div.i95 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %29, !fpmath !3
  %call2.i98 = tail call <4 x float> @_Z3expDv4_f(<4 x float> %div1.i75) #4
  %mul3.i99 = fmul <4 x float> %call2.i98, <float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000, float 0x3FD9884540000000>
  %mul4.i100 = fmul <4 x float> %div.i95, %mul3.i99
  %30 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i95, <4 x float> <float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000, float 0x3FF548CDE0000000>, <4 x float> <float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000, float 0xBFFD23DD40000000>) #4
  %31 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i95, <4 x float> %30, <4 x float> <float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000, float 0x3FFC80EF00000000>) #4
  %32 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i95, <4 x float> %31, <4 x float> <float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000, float 0xBFD6D1F0E0000000>) #4
  %33 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %div.i95, <4 x float> %32, <4 x float> <float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000, float 0x3FD470BF40000000>) #4
  %neg.i101 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul4.i100
  %34 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %neg.i101, <4 x float> %33, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>) #4
  %cmp.i102 = fcmp olt <4 x float> %sub37, zeroinitializer
  %sub10.i103 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %34
  %cond.v.i104 = select <4 x i1> %cmp.i102, <4 x float> %sub10.i103, <4 x float> %34
  %mul39 = fmul <4 x float> %2, %cond.v.i93
  %neg40 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %mul39
  %35 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %mul30, <4 x float> %cond.v.i104, <4 x float> %neg40)
  %arrayidx43 = getelementptr inbounds <4 x float> addrspace(1)* %put, i64 %0
  store <4 x float> %35, <4 x float> addrspace(1)* %arrayidx43, align 16, !tbaa !4
  ret void
}

declare i32 @get_global_id(i32) #3

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #1

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.log2.v4f32(<4 x float>) #1

; Function Attrs: nounwind
define void @phi_scalar(float %X, float* nocapture %phi) #0 {
entry:
  %call = tail call float @llvm.fabs.f32(float %X)
  %0 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %call, float 1.000000e+00)
  %div = fdiv float 1.000000e+00, %0, !fpmath !3
  %1 = fmul float %X, %X
  %div1 = fmul float %1, -5.000000e-01
  %call2 = tail call float @_Z3expf(float %div1) #4
  %mul3 = fmul float %call2, 0x3FD9884540000000
  %mul4 = fmul float %div, %mul3
  %2 = tail call float @llvm.fmuladd.f32(float %div, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000)
  %3 = tail call float @llvm.fmuladd.f32(float %div, float %2, float 0x3FFC80EF00000000)
  %4 = tail call float @llvm.fmuladd.f32(float %div, float %3, float 0xBFD6D1F0E0000000)
  %5 = tail call float @llvm.fmuladd.f32(float %div, float %4, float 0x3FD470BF40000000)
  %neg = fsub float -0.000000e+00, %mul4
  %6 = tail call float @llvm.fmuladd.f32(float %neg, float %5, float 1.000000e+00)
  %cmp = fcmp olt float %X, 0.000000e+00
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %sub10 = fsub float 1.000000e+00, %6
  br label %cond.end

cond.end:                                         ; preds = %entry, %cond.true
  %cond = phi float [ %sub10, %cond.true ], [ %6, %entry ]
  store float %cond, float* %phi, align 4, !tbaa !7
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.fabs.f32(float) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare float @_Z3expf(float) #3

; Function Attrs: nounwind
define void @blackScholes_scalar(float addrspace(1)* nocapture readonly %randArray, i32 %width, float addrspace(1)* nocapture %call, float addrspace(1)* nocapture %put) #0 {
entry:
  %call1 = tail call i32 @get_global_id(i32 0) #4
  %call2 = tail call i32 @get_global_id(i32 1) #4
  %mul = mul i32 %call2, %width
  %add = add i32 %mul, %call1
  %0 = sext i32 %add to i64
  %arrayidx = getelementptr inbounds float addrspace(1)* %randArray, i64 %0
  %1 = load float addrspace(1)* %arrayidx, align 4, !tbaa !7
  %sub = fsub float 1.000000e+00, %1
  %mul4 = fmul float %sub, 1.000000e+02
  %2 = tail call float @llvm.fmuladd.f32(float 1.000000e+01, float %1, float %mul4)
  %mul10 = fmul float %sub, 1.000000e+01
  %3 = tail call float @llvm.fmuladd.f32(float 1.000000e+00, float %1, float %mul10)
  %mul13 = fmul float %sub, 0x3FA99999A0000000
  %4 = tail call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %1, float %mul13)
  %mul16 = fmul float %sub, 0x3FB99999A0000000
  %5 = tail call float @llvm.fmuladd.f32(float 0x3F847AE140000000, float %1, float %mul16)
  %call17 = tail call float @llvm.sqrt.f32(float %3)
  %mul18 = fmul float %5, %call17
  %div = fdiv float %2, %2, !fpmath !3
  %call19 = tail call float @llvm.log2.f32(float %div)
  %mul21 = fmul float %5, %5
  %div22 = fmul float %mul21, 5.000000e-01
  %add23 = fadd float %4, %div22
  %mul24 = fmul float %3, %add23
  %6 = tail call float @llvm.fmuladd.f32(float %call19, float 0x3FE62E4300000000, float %mul24)
  %div25 = fdiv float %6, %mul18, !fpmath !3
  %sub26 = fsub float %div25, %mul18
  %7 = fmul float %3, %4
  %mul28 = fsub float -0.000000e+00, %7
  %call29 = tail call float @_Z3expf(float %mul28) #4
  %mul30 = fmul float %2, %call29
  %call.i = tail call float @llvm.fabs.f32(float %div25) #4
  %8 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %call.i, float 1.000000e+00) #4
  %div.i = fdiv float 1.000000e+00, %8, !fpmath !3
  %9 = fmul float %div25, %div25
  %div1.i = fmul float %9, -5.000000e-01
  %call2.i = tail call float @_Z3expf(float %div1.i) #4
  %mul3.i = fmul float %call2.i, 0x3FD9884540000000
  %mul4.i = fmul float %div.i, %mul3.i
  %10 = tail call float @llvm.fmuladd.f32(float %div.i, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #4
  %11 = tail call float @llvm.fmuladd.f32(float %div.i, float %10, float 0x3FFC80EF00000000) #4
  %12 = tail call float @llvm.fmuladd.f32(float %div.i, float %11, float 0xBFD6D1F0E0000000) #4
  %13 = tail call float @llvm.fmuladd.f32(float %div.i, float %12, float 0x3FD470BF40000000) #4
  %neg.i = fsub float -0.000000e+00, %mul4.i
  %14 = tail call float @llvm.fmuladd.f32(float %neg.i, float %13, float 1.000000e+00) #4
  %cmp.i = fcmp olt float %div25, 0.000000e+00
  br i1 %cmp.i, label %cond.true.i, label %phi_scalar.exit

cond.true.i:                                      ; preds = %entry
  %sub10.i = fsub float 1.000000e+00, %14
  br label %phi_scalar.exit

phi_scalar.exit:                                  ; preds = %entry, %cond.true.i
  %cond.i = phi float [ %sub10.i, %cond.true.i ], [ %14, %entry ]
  %call.i72 = tail call float @llvm.fabs.f32(float %sub26) #4
  %15 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %call.i72, float 1.000000e+00) #4
  %div.i73 = fdiv float 1.000000e+00, %15, !fpmath !3
  %16 = fmul float %sub26, %sub26
  %div1.i74 = fmul float %16, -5.000000e-01
  %call2.i75 = tail call float @_Z3expf(float %div1.i74) #4
  %mul3.i76 = fmul float %call2.i75, 0x3FD9884540000000
  %mul4.i77 = fmul float %div.i73, %mul3.i76
  %17 = tail call float @llvm.fmuladd.f32(float %div.i73, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #4
  %18 = tail call float @llvm.fmuladd.f32(float %div.i73, float %17, float 0x3FFC80EF00000000) #4
  %19 = tail call float @llvm.fmuladd.f32(float %div.i73, float %18, float 0xBFD6D1F0E0000000) #4
  %20 = tail call float @llvm.fmuladd.f32(float %div.i73, float %19, float 0x3FD470BF40000000) #4
  %neg.i78 = fsub float -0.000000e+00, %mul4.i77
  %21 = tail call float @llvm.fmuladd.f32(float %neg.i78, float %20, float 1.000000e+00) #4
  %cmp.i79 = fcmp olt float %sub26, 0.000000e+00
  br i1 %cmp.i79, label %cond.true.i81, label %phi_scalar.exit83

cond.true.i81:                                    ; preds = %phi_scalar.exit
  %sub10.i80 = fsub float 1.000000e+00, %21
  br label %phi_scalar.exit83

phi_scalar.exit83:                                ; preds = %phi_scalar.exit, %cond.true.i81
  %cond.i82 = phi float [ %sub10.i80, %cond.true.i81 ], [ %21, %phi_scalar.exit ]
  %mul32 = fmul float %mul30, %cond.i82
  %neg = fsub float -0.000000e+00, %mul32
  %22 = tail call float @llvm.fmuladd.f32(float %2, float %cond.i, float %neg)
  %arrayidx35 = getelementptr inbounds float addrspace(1)* %call, i64 %0
  store float %22, float addrspace(1)* %arrayidx35, align 4, !tbaa !7
  %sub36 = fsub float -0.000000e+00, %div25
  %call.i84 = tail call float @llvm.fabs.f32(float %sub36) #4
  %23 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %call.i84, float 1.000000e+00) #4
  %div.i85 = fdiv float 1.000000e+00, %23, !fpmath !3
  %call2.i87 = tail call float @_Z3expf(float %div1.i) #4
  %mul3.i88 = fmul float %call2.i87, 0x3FD9884540000000
  %mul4.i89 = fmul float %div.i85, %mul3.i88
  %24 = tail call float @llvm.fmuladd.f32(float %div.i85, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #4
  %25 = tail call float @llvm.fmuladd.f32(float %div.i85, float %24, float 0x3FFC80EF00000000) #4
  %26 = tail call float @llvm.fmuladd.f32(float %div.i85, float %25, float 0xBFD6D1F0E0000000) #4
  %27 = tail call float @llvm.fmuladd.f32(float %div.i85, float %26, float 0x3FD470BF40000000) #4
  %neg.i90 = fsub float -0.000000e+00, %mul4.i89
  %28 = tail call float @llvm.fmuladd.f32(float %neg.i90, float %27, float 1.000000e+00) #4
  %cmp.i91 = fcmp ogt float %div25, -0.000000e+00
  br i1 %cmp.i91, label %cond.true.i93, label %phi_scalar.exit95

cond.true.i93:                                    ; preds = %phi_scalar.exit83
  %sub10.i92 = fsub float 1.000000e+00, %28
  br label %phi_scalar.exit95

phi_scalar.exit95:                                ; preds = %phi_scalar.exit83, %cond.true.i93
  %cond.i94 = phi float [ %sub10.i92, %cond.true.i93 ], [ %28, %phi_scalar.exit83 ]
  %sub37 = fsub float -0.000000e+00, %sub26
  %call.i96 = tail call float @llvm.fabs.f32(float %sub37) #4
  %29 = tail call float @llvm.fmuladd.f32(float 0x3FCDA67120000000, float %call.i96, float 1.000000e+00) #4
  %div.i97 = fdiv float 1.000000e+00, %29, !fpmath !3
  %call2.i99 = tail call float @_Z3expf(float %div1.i74) #4
  %mul3.i100 = fmul float %call2.i99, 0x3FD9884540000000
  %mul4.i101 = fmul float %div.i97, %mul3.i100
  %30 = tail call float @llvm.fmuladd.f32(float %div.i97, float 0x3FF548CDE0000000, float 0xBFFD23DD40000000) #4
  %31 = tail call float @llvm.fmuladd.f32(float %div.i97, float %30, float 0x3FFC80EF00000000) #4
  %32 = tail call float @llvm.fmuladd.f32(float %div.i97, float %31, float 0xBFD6D1F0E0000000) #4
  %33 = tail call float @llvm.fmuladd.f32(float %div.i97, float %32, float 0x3FD470BF40000000) #4
  %neg.i102 = fsub float -0.000000e+00, %mul4.i101
  %34 = tail call float @llvm.fmuladd.f32(float %neg.i102, float %33, float 1.000000e+00) #4
  %cmp.i103 = fcmp ogt float %sub26, -0.000000e+00
  br i1 %cmp.i103, label %cond.true.i105, label %phi_scalar.exit107

cond.true.i105:                                   ; preds = %phi_scalar.exit95
  %sub10.i104 = fsub float 1.000000e+00, %34
  br label %phi_scalar.exit107

phi_scalar.exit107:                               ; preds = %phi_scalar.exit95, %cond.true.i105
  %cond.i106 = phi float [ %sub10.i104, %cond.true.i105 ], [ %34, %phi_scalar.exit95 ]
  %mul39 = fmul float %2, %cond.i94
  %neg40 = fsub float -0.000000e+00, %mul39
  %35 = tail call float @llvm.fmuladd.f32(float %mul30, float %cond.i106, float %neg40)
  %arrayidx43 = getelementptr inbounds float addrspace(1)* %put, i64 %0
  store float %35, float addrspace(1)* %arrayidx43, align 4, !tbaa !7
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #1

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x float> addrspace(1)*, i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @blackScholes}
!1 = metadata !{void (float addrspace(1)*, i32, float addrspace(1)*, float addrspace(1)*)* @blackScholes_scalar}
!2 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!3 = metadata !{float 2.500000e+00}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"float", metadata !5, i64 0}

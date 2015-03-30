; ModuleID = '../kernel-src/Mandelbrot_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @mandelbrot_vector_float(<4 x i8> addrspace(1)* nocapture %mandelbrotImage, float %posx, float %posy, float %stepSizeX, float %stepSizeY, i32 %maxIterations, i32 %width, i32 %bench) #0 {
entry:
  %call = tail call i32 @get_global_id(i32 0) #4
  %div = sdiv i32 %width, 4
  %rem = srem i32 %call, %div
  %div2 = sdiv i32 %call, %div
  %mul = shl nsw i32 %rem, 2
  %add1073 = or i32 %mul, 1
  %add61074 = or i32 %mul, 2
  %add91075 = or i32 %mul, 3
  %conv = sitofp i32 %mul to float
  %0 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %conv, float %posx)
  %1 = insertelement <4 x float> undef, float %0, i32 0
  %conv16 = sitofp i32 %add1073 to float
  %2 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %conv16, float %posx)
  %3 = insertelement <4 x float> %1, float %2, i32 1
  %conv18 = sitofp i32 %add61074 to float
  %4 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %conv18, float %posx)
  %5 = insertelement <4 x float> %3, float %4, i32 2
  %conv20 = sitofp i32 %add91075 to float
  %6 = tail call float @llvm.fmuladd.f32(float %stepSizeX, float %conv20, float %posx)
  %7 = insertelement <4 x float> %5, float %6, i32 3
  %conv22 = sitofp i32 %div2 to float
  %8 = tail call float @llvm.fmuladd.f32(float %stepSizeY, float %conv22, float %posy)
  %9 = insertelement <4 x float> undef, float %8, i32 0
  %10 = insertelement <4 x float> %9, float %8, i32 1
  %11 = insertelement <4 x float> %10, float %8, i32 2
  %12 = insertelement <4 x float> %11, float %8, i32 3
  %mul33 = fmul float %8, %8
  %13 = tail call float @llvm.fmuladd.f32(float %0, float %0, float %mul33)
  %cmp = fcmp ole float %13, 4.000000e+00
  %conv34 = zext i1 %cmp to i32
  %14 = tail call float @llvm.fmuladd.f32(float %2, float %2, float %mul33)
  %cmp37 = fcmp ole float %14, 4.000000e+00
  %conv38 = zext i1 %cmp37 to i32
  %15 = tail call float @llvm.fmuladd.f32(float %4, float %4, float %mul33)
  %cmp41 = fcmp ole float %15, 4.000000e+00
  %conv42 = zext i1 %cmp41 to i32
  %16 = tail call float @llvm.fmuladd.f32(float %6, float %6, float %mul33)
  %cmp45 = fcmp ole float %16, 4.000000e+00
  %conv46 = zext i1 %cmp45 to i32
  %or11071123 = or i1 %cmp, %cmp37
  %or4911081124 = or i1 %or11071123, %cmp41
  %or5011091125 = or i1 %or4911081124, %cmp45
  %cmp511111 = icmp ne i32 %maxIterations, 0
  %or.cond11011112 = and i1 %or5011091125, %cmp511111
  br i1 %or.cond11011112, label %for.body, label %for.end

for.body:                                         ; preds = %entry, %for.body
  %savy.01116 = phi <4 x float> [ %37, %for.body ], [ %12, %entry ]
  %savx.01115 = phi <4 x float> [ %29, %for.body ], [ %7, %entry ]
  %ccount.01114 = phi <4 x i32> [ %add279, %for.body ], [ zeroinitializer, %entry ]
  %iter.01113 = phi i32 [ %add280, %for.body ], [ 0, %entry ]
  %sub = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.01116
  %call53 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %savx.01115, <4 x float> %savx.01115, <4 x float> %7) #4
  %call54 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub, <4 x float> %savy.01116, i32 %call53) #4
  %conv55 = sitofp i32 %call54 to float
  %splat.splatinsert = insertelement <4 x float> undef, float %conv55, i32 0
  %splat.splat = shufflevector <4 x float> %splat.splatinsert, <4 x float> undef, <4 x i32> zeroinitializer
  %mul56 = fmul <4 x float> %savx.01115, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call57 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul56, <4 x float> %savy.01116, <4 x float> %12) #4
  %conv58 = sitofp i32 %call57 to float
  %splat.splatinsert59 = insertelement <4 x float> undef, float %conv58, i32 0
  %splat.splat60 = shufflevector <4 x float> %splat.splatinsert59, <4 x float> undef, <4 x i32> zeroinitializer
  %sub61 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat60
  %call62 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat, <4 x float> %splat.splat, <4 x float> %7) #4
  %call63 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub61, <4 x float> %splat.splat60, i32 %call62) #4
  %conv64 = sitofp i32 %call63 to float
  %splat.splatinsert65 = insertelement <4 x float> undef, float %conv64, i32 0
  %splat.splat66 = shufflevector <4 x float> %splat.splatinsert65, <4 x float> undef, <4 x i32> zeroinitializer
  %mul67 = fmul <4 x float> %splat.splat, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call68 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul67, <4 x float> %splat.splat60, <4 x float> %12) #4
  %conv69 = sitofp i32 %call68 to float
  %splat.splatinsert70 = insertelement <4 x float> undef, float %conv69, i32 0
  %splat.splat71 = shufflevector <4 x float> %splat.splatinsert70, <4 x float> undef, <4 x i32> zeroinitializer
  %sub72 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat71
  %call73 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat66, <4 x float> %splat.splat66, <4 x float> %7) #4
  %call74 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub72, <4 x float> %splat.splat71, i32 %call73) #4
  %conv75 = sitofp i32 %call74 to float
  %splat.splatinsert76 = insertelement <4 x float> undef, float %conv75, i32 0
  %splat.splat77 = shufflevector <4 x float> %splat.splatinsert76, <4 x float> undef, <4 x i32> zeroinitializer
  %mul78 = fmul <4 x float> %splat.splat66, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call79 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul78, <4 x float> %splat.splat71, <4 x float> %12) #4
  %conv80 = sitofp i32 %call79 to float
  %splat.splatinsert81 = insertelement <4 x float> undef, float %conv80, i32 0
  %splat.splat82 = shufflevector <4 x float> %splat.splatinsert81, <4 x float> undef, <4 x i32> zeroinitializer
  %sub83 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat82
  %call84 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat77, <4 x float> %splat.splat77, <4 x float> %7) #4
  %call85 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub83, <4 x float> %splat.splat82, i32 %call84) #4
  %conv86 = sitofp i32 %call85 to float
  %splat.splatinsert87 = insertelement <4 x float> undef, float %conv86, i32 0
  %splat.splat88 = shufflevector <4 x float> %splat.splatinsert87, <4 x float> undef, <4 x i32> zeroinitializer
  %mul89 = fmul <4 x float> %splat.splat77, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call90 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul89, <4 x float> %splat.splat82, <4 x float> %12) #4
  %conv91 = sitofp i32 %call90 to float
  %splat.splatinsert92 = insertelement <4 x float> undef, float %conv91, i32 0
  %splat.splat93 = shufflevector <4 x float> %splat.splatinsert92, <4 x float> undef, <4 x i32> zeroinitializer
  %sub94 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat93
  %call95 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat88, <4 x float> %splat.splat88, <4 x float> %7) #4
  %call96 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub94, <4 x float> %splat.splat93, i32 %call95) #4
  %conv97 = sitofp i32 %call96 to float
  %splat.splatinsert98 = insertelement <4 x float> undef, float %conv97, i32 0
  %splat.splat99 = shufflevector <4 x float> %splat.splatinsert98, <4 x float> undef, <4 x i32> zeroinitializer
  %mul100 = fmul <4 x float> %splat.splat88, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call101 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul100, <4 x float> %splat.splat93, <4 x float> %12) #4
  %conv102 = sitofp i32 %call101 to float
  %splat.splatinsert103 = insertelement <4 x float> undef, float %conv102, i32 0
  %splat.splat104 = shufflevector <4 x float> %splat.splatinsert103, <4 x float> undef, <4 x i32> zeroinitializer
  %sub105 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat104
  %call106 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat99, <4 x float> %splat.splat99, <4 x float> %7) #4
  %call107 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub105, <4 x float> %splat.splat104, i32 %call106) #4
  %conv108 = sitofp i32 %call107 to float
  %splat.splatinsert109 = insertelement <4 x float> undef, float %conv108, i32 0
  %splat.splat110 = shufflevector <4 x float> %splat.splatinsert109, <4 x float> undef, <4 x i32> zeroinitializer
  %mul111 = fmul <4 x float> %splat.splat99, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call112 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul111, <4 x float> %splat.splat104, <4 x float> %12) #4
  %conv113 = sitofp i32 %call112 to float
  %splat.splatinsert114 = insertelement <4 x float> undef, float %conv113, i32 0
  %splat.splat115 = shufflevector <4 x float> %splat.splatinsert114, <4 x float> undef, <4 x i32> zeroinitializer
  %sub116 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat115
  %call117 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat110, <4 x float> %splat.splat110, <4 x float> %7) #4
  %call118 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub116, <4 x float> %splat.splat115, i32 %call117) #4
  %conv119 = sitofp i32 %call118 to float
  %splat.splatinsert120 = insertelement <4 x float> undef, float %conv119, i32 0
  %splat.splat121 = shufflevector <4 x float> %splat.splatinsert120, <4 x float> undef, <4 x i32> zeroinitializer
  %mul122 = fmul <4 x float> %splat.splat110, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call123 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul122, <4 x float> %splat.splat115, <4 x float> %12) #4
  %conv124 = sitofp i32 %call123 to float
  %splat.splatinsert125 = insertelement <4 x float> undef, float %conv124, i32 0
  %splat.splat126 = shufflevector <4 x float> %splat.splatinsert125, <4 x float> undef, <4 x i32> zeroinitializer
  %sub127 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat126
  %call128 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat121, <4 x float> %splat.splat121, <4 x float> %7) #4
  %call129 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub127, <4 x float> %splat.splat126, i32 %call128) #4
  %conv130 = sitofp i32 %call129 to float
  %splat.splatinsert131 = insertelement <4 x float> undef, float %conv130, i32 0
  %splat.splat132 = shufflevector <4 x float> %splat.splatinsert131, <4 x float> undef, <4 x i32> zeroinitializer
  %mul133 = fmul <4 x float> %splat.splat121, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call134 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul133, <4 x float> %splat.splat126, <4 x float> %12) #4
  %conv135 = sitofp i32 %call134 to float
  %splat.splatinsert136 = insertelement <4 x float> undef, float %conv135, i32 0
  %splat.splat137 = shufflevector <4 x float> %splat.splatinsert136, <4 x float> undef, <4 x i32> zeroinitializer
  %sub138 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat137
  %call139 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat132, <4 x float> %splat.splat132, <4 x float> %7) #4
  %call140 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub138, <4 x float> %splat.splat137, i32 %call139) #4
  %conv141 = sitofp i32 %call140 to float
  %splat.splatinsert142 = insertelement <4 x float> undef, float %conv141, i32 0
  %splat.splat143 = shufflevector <4 x float> %splat.splatinsert142, <4 x float> undef, <4 x i32> zeroinitializer
  %mul144 = fmul <4 x float> %splat.splat132, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call145 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul144, <4 x float> %splat.splat137, <4 x float> %12) #4
  %conv146 = sitofp i32 %call145 to float
  %splat.splatinsert147 = insertelement <4 x float> undef, float %conv146, i32 0
  %splat.splat148 = shufflevector <4 x float> %splat.splatinsert147, <4 x float> undef, <4 x i32> zeroinitializer
  %sub149 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat148
  %call150 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat143, <4 x float> %splat.splat143, <4 x float> %7) #4
  %call151 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub149, <4 x float> %splat.splat148, i32 %call150) #4
  %conv152 = sitofp i32 %call151 to float
  %splat.splatinsert153 = insertelement <4 x float> undef, float %conv152, i32 0
  %splat.splat154 = shufflevector <4 x float> %splat.splatinsert153, <4 x float> undef, <4 x i32> zeroinitializer
  %mul155 = fmul <4 x float> %splat.splat143, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call156 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul155, <4 x float> %splat.splat148, <4 x float> %12) #4
  %conv157 = sitofp i32 %call156 to float
  %splat.splatinsert158 = insertelement <4 x float> undef, float %conv157, i32 0
  %splat.splat159 = shufflevector <4 x float> %splat.splatinsert158, <4 x float> undef, <4 x i32> zeroinitializer
  %sub160 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat159
  %call161 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat154, <4 x float> %splat.splat154, <4 x float> %7) #4
  %call162 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub160, <4 x float> %splat.splat159, i32 %call161) #4
  %conv163 = sitofp i32 %call162 to float
  %splat.splatinsert164 = insertelement <4 x float> undef, float %conv163, i32 0
  %splat.splat165 = shufflevector <4 x float> %splat.splatinsert164, <4 x float> undef, <4 x i32> zeroinitializer
  %mul166 = fmul <4 x float> %splat.splat154, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call167 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul166, <4 x float> %splat.splat159, <4 x float> %12) #4
  %conv168 = sitofp i32 %call167 to float
  %splat.splatinsert169 = insertelement <4 x float> undef, float %conv168, i32 0
  %splat.splat170 = shufflevector <4 x float> %splat.splatinsert169, <4 x float> undef, <4 x i32> zeroinitializer
  %sub171 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat170
  %call172 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat165, <4 x float> %splat.splat165, <4 x float> %7) #4
  %call173 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub171, <4 x float> %splat.splat170, i32 %call172) #4
  %conv174 = sitofp i32 %call173 to float
  %splat.splatinsert175 = insertelement <4 x float> undef, float %conv174, i32 0
  %splat.splat176 = shufflevector <4 x float> %splat.splatinsert175, <4 x float> undef, <4 x i32> zeroinitializer
  %mul177 = fmul <4 x float> %splat.splat165, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call178 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul177, <4 x float> %splat.splat170, <4 x float> %12) #4
  %conv179 = sitofp i32 %call178 to float
  %splat.splatinsert180 = insertelement <4 x float> undef, float %conv179, i32 0
  %splat.splat181 = shufflevector <4 x float> %splat.splatinsert180, <4 x float> undef, <4 x i32> zeroinitializer
  %sub182 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat181
  %call183 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat176, <4 x float> %splat.splat176, <4 x float> %7) #4
  %call184 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub182, <4 x float> %splat.splat181, i32 %call183) #4
  %conv185 = sitofp i32 %call184 to float
  %splat.splatinsert186 = insertelement <4 x float> undef, float %conv185, i32 0
  %splat.splat187 = shufflevector <4 x float> %splat.splatinsert186, <4 x float> undef, <4 x i32> zeroinitializer
  %mul188 = fmul <4 x float> %splat.splat176, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call189 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul188, <4 x float> %splat.splat181, <4 x float> %12) #4
  %conv190 = sitofp i32 %call189 to float
  %splat.splatinsert191 = insertelement <4 x float> undef, float %conv190, i32 0
  %splat.splat192 = shufflevector <4 x float> %splat.splatinsert191, <4 x float> undef, <4 x i32> zeroinitializer
  %sub193 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat192
  %call194 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat187, <4 x float> %splat.splat187, <4 x float> %7) #4
  %call195 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub193, <4 x float> %splat.splat192, i32 %call194) #4
  %conv196 = sitofp i32 %call195 to float
  %splat.splatinsert197 = insertelement <4 x float> undef, float %conv196, i32 0
  %splat.splat198 = shufflevector <4 x float> %splat.splatinsert197, <4 x float> undef, <4 x i32> zeroinitializer
  %mul199 = fmul <4 x float> %splat.splat187, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call200 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul199, <4 x float> %splat.splat192, <4 x float> %12) #4
  %conv201 = sitofp i32 %call200 to float
  %splat.splatinsert202 = insertelement <4 x float> undef, float %conv201, i32 0
  %splat.splat203 = shufflevector <4 x float> %splat.splatinsert202, <4 x float> undef, <4 x i32> zeroinitializer
  %sub204 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat203
  %call205 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat198, <4 x float> %splat.splat198, <4 x float> %7) #4
  %call206 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub204, <4 x float> %splat.splat203, i32 %call205) #4
  %conv207 = sitofp i32 %call206 to float
  %splat.splatinsert208 = insertelement <4 x float> undef, float %conv207, i32 0
  %splat.splat209 = shufflevector <4 x float> %splat.splatinsert208, <4 x float> undef, <4 x i32> zeroinitializer
  %mul210 = fmul <4 x float> %splat.splat198, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call211 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul210, <4 x float> %splat.splat203, <4 x float> %12) #4
  %conv212 = sitofp i32 %call211 to float
  %splat.splatinsert213 = insertelement <4 x float> undef, float %conv212, i32 0
  %splat.splat214 = shufflevector <4 x float> %splat.splatinsert213, <4 x float> undef, <4 x i32> zeroinitializer
  %sub215 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %splat.splat214
  %call216 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %splat.splat209, <4 x float> %splat.splat209, <4 x float> %7) #4
  %call217 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub215, <4 x float> %splat.splat214, i32 %call216) #4
  %conv218 = sitofp i32 %call217 to float
  %mul221 = fmul <4 x float> %splat.splat209, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call222 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul221, <4 x float> %splat.splat214, <4 x float> %12) #4
  %conv223 = sitofp i32 %call222 to float
  %mul227 = fmul float %conv223, %conv223
  %17 = tail call float @llvm.fmuladd.f32(float %conv218, float %conv218, float %mul227)
  %cmp228 = fcmp ole float %17, 4.000000e+00
  %conv229 = zext i1 %cmp228 to i32
  %18 = insertelement <4 x i32> undef, i32 %conv229, i32 0
  %19 = insertelement <4 x i32> %18, i32 %conv229, i32 1
  %20 = insertelement <4 x i32> %19, i32 %conv229, i32 2
  %21 = insertelement <4 x i32> %20, i32 %conv229, i32 3
  %savx.0.elt = extractelement <4 x float> %savx.01115, i32 0
  %22 = select i1 %cmp228, float %conv218, float %savx.0.elt
  %23 = insertelement <4 x float> undef, float %22, i32 0
  %.elt1095 = extractelement <4 x float> %savx.01115, i32 1
  %24 = select i1 %cmp228, float %conv218, float %.elt1095
  %25 = insertelement <4 x float> %23, float %24, i32 1
  %.elt1096 = extractelement <4 x float> %savx.01115, i32 2
  %26 = select i1 %cmp228, float %conv218, float %.elt1096
  %27 = insertelement <4 x float> %25, float %26, i32 2
  %.elt1097 = extractelement <4 x float> %savx.01115, i32 3
  %28 = select i1 %cmp228, float %conv218, float %.elt1097
  %29 = insertelement <4 x float> %27, float %28, i32 3
  %savy.0.elt = extractelement <4 x float> %savy.01116, i32 0
  %30 = select i1 %cmp228, float %conv223, float %savy.0.elt
  %31 = insertelement <4 x float> undef, float %30, i32 0
  %.elt1098 = extractelement <4 x float> %savy.01116, i32 1
  %32 = select i1 %cmp228, float %conv223, float %.elt1098
  %33 = insertelement <4 x float> %31, float %32, i32 1
  %.elt1099 = extractelement <4 x float> %savy.01116, i32 2
  %34 = select i1 %cmp228, float %conv223, float %.elt1099
  %35 = insertelement <4 x float> %33, float %34, i32 2
  %.elt1100 = extractelement <4 x float> %savy.01116, i32 3
  %36 = select i1 %cmp228, float %conv223, float %.elt1100
  %37 = insertelement <4 x float> %35, float %36, i32 3
  %mul278 = shl <4 x i32> %21, <i32 4, i32 4, i32 4, i32 4>
  %add279 = add <4 x i32> %ccount.01114, %mul278
  %add280 = add i32 %iter.01113, 16
  %cmp51 = icmp ult i32 %add280, %maxIterations
  %or.cond1101 = and i1 %cmp228, %cmp51
  br i1 %or.cond1101, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  %.lcssa1106 = phi i32 [ %conv46, %entry ], [ %conv229, %for.body ]
  %.lcssa1105 = phi i32 [ %conv42, %entry ], [ %conv229, %for.body ]
  %.lcssa1104 = phi i32 [ %conv38, %entry ], [ %conv229, %for.body ]
  %.lcssa1103 = phi i32 [ %conv34, %entry ], [ %conv229, %for.body ]
  %savy.0.lcssa = phi <4 x float> [ %12, %entry ], [ %37, %for.body ]
  %savx.0.lcssa = phi <4 x float> [ %7, %entry ], [ %29, %for.body ]
  %ccount.0.lcssa = phi <4 x i32> [ zeroinitializer, %entry ], [ %add279, %for.body ]
  %and = and i32 %.lcssa1103, %.lcssa1104
  %and281 = and i32 %and, %.lcssa1105
  %and282 = and i32 %and281, %.lcssa1106
  %tobool283 = icmp eq i32 %and282, 0
  br i1 %tobool283, label %do.body, label %if.end

do.body:                                          ; preds = %for.end, %land.end315
  %iter.1 = phi i32 [ %dec, %land.end315 ], [ 16, %for.end ]
  %ccount.1 = phi <4 x i32> [ %add328, %land.end315 ], [ %ccount.0.lcssa, %for.end ]
  %savx.1 = phi <4 x float> [ %69, %land.end315 ], [ %savx.0.lcssa, %for.end ]
  %savy.1 = phi <4 x float> [ %77, %land.end315 ], [ %savy.0.lcssa, %for.end ]
  %38 = extractelement <4 x float> %savx.1, i32 0
  %39 = extractelement <4 x float> %savy.1, i32 0
  %mul285 = fmul float %39, %39
  %40 = tail call float @llvm.fmuladd.f32(float %38, float %38, float %mul285)
  %cmp286 = fcmp ugt float %40, 4.000000e+00
  br i1 %cmp286, label %land.end, label %land.rhs

land.rhs:                                         ; preds = %do.body
  %41 = extractelement <4 x i32> %ccount.1, i32 0
  %cmp288 = icmp ult i32 %41, %maxIterations
  br label %land.end

land.end:                                         ; preds = %do.body, %land.rhs
  %42 = phi i1 [ false, %do.body ], [ %cmp288, %land.rhs ]
  %land.ext = zext i1 %42 to i32
  %43 = insertelement <4 x i32> undef, i32 %land.ext, i32 0
  %44 = extractelement <4 x float> %savx.1, i32 1
  %45 = extractelement <4 x float> %savy.1, i32 1
  %mul291 = fmul float %45, %45
  %46 = tail call float @llvm.fmuladd.f32(float %44, float %44, float %mul291)
  %cmp292 = fcmp ugt float %46, 4.000000e+00
  br i1 %cmp292, label %land.end297, label %land.rhs294

land.rhs294:                                      ; preds = %land.end
  %47 = extractelement <4 x i32> %ccount.1, i32 1
  %cmp295 = icmp ult i32 %47, %maxIterations
  br label %land.end297

land.end297:                                      ; preds = %land.end, %land.rhs294
  %48 = phi i1 [ false, %land.end ], [ %cmp295, %land.rhs294 ]
  %land.ext298 = zext i1 %48 to i32
  %49 = insertelement <4 x i32> %43, i32 %land.ext298, i32 1
  %50 = extractelement <4 x float> %savx.1, i32 2
  %51 = extractelement <4 x float> %savy.1, i32 2
  %mul300 = fmul float %51, %51
  %52 = tail call float @llvm.fmuladd.f32(float %50, float %50, float %mul300)
  %cmp301 = fcmp ugt float %52, 4.000000e+00
  br i1 %cmp301, label %land.end306, label %land.rhs303

land.rhs303:                                      ; preds = %land.end297
  %53 = extractelement <4 x i32> %ccount.1, i32 2
  %cmp304 = icmp ult i32 %53, %maxIterations
  br label %land.end306

land.end306:                                      ; preds = %land.end297, %land.rhs303
  %54 = phi i1 [ false, %land.end297 ], [ %cmp304, %land.rhs303 ]
  %land.ext307 = zext i1 %54 to i32
  %55 = insertelement <4 x i32> %49, i32 %land.ext307, i32 2
  %56 = extractelement <4 x float> %savx.1, i32 3
  %57 = extractelement <4 x float> %savy.1, i32 3
  %mul309 = fmul float %57, %57
  %58 = tail call float @llvm.fmuladd.f32(float %56, float %56, float %mul309)
  %cmp310 = fcmp ugt float %58, 4.000000e+00
  br i1 %cmp310, label %land.end315, label %land.rhs312

land.rhs312:                                      ; preds = %land.end306
  %59 = extractelement <4 x i32> %ccount.1, i32 3
  %cmp313 = icmp ult i32 %59, %maxIterations
  br label %land.end315

land.end315:                                      ; preds = %land.end306, %land.rhs312
  %60 = phi i1 [ false, %land.end306 ], [ %cmp313, %land.rhs312 ]
  %land.ext316 = zext i1 %60 to i32
  %61 = insertelement <4 x i32> %55, i32 %land.ext316, i32 3
  %sub317 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %savy.1
  %call318 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %savx.1, <4 x float> %savx.1, <4 x float> %7) #4
  %call319 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, i32)*)(<4 x float> %sub317, <4 x float> %savy.1, i32 %call318) #4
  %conv320 = sitofp i32 %call319 to float
  %mul323 = fmul <4 x float> %savx.1, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %call324 = tail call i32 bitcast (i32 (...)* @MUL_ADD to i32 (<4 x float>, <4 x float>, <4 x float>)*)(<4 x float> %mul323, <4 x float> %savy.1, <4 x float> %12) #4
  %conv325 = sitofp i32 %call324 to float
  %add328 = add <4 x i32> %ccount.1, %61
  %dec = add i32 %iter.1, -1
  %62 = select i1 %42, float %conv320, float %38
  %63 = insertelement <4 x float> undef, float %62, i32 0
  %64 = select i1 %48, float %conv320, float %44
  %65 = insertelement <4 x float> %63, float %64, i32 1
  %66 = select i1 %54, float %conv320, float %50
  %67 = insertelement <4 x float> %65, float %66, i32 2
  %68 = select i1 %60, float %conv320, float %56
  %69 = insertelement <4 x float> %67, float %68, i32 3
  %70 = select i1 %42, float %conv325, float %39
  %71 = insertelement <4 x float> undef, float %70, i32 0
  %72 = select i1 %48, float %conv325, float %45
  %73 = insertelement <4 x float> %71, float %72, i32 1
  %74 = select i1 %54, float %conv325, float %51
  %75 = insertelement <4 x float> %73, float %74, i32 2
  %76 = select i1 %60, float %conv325, float %57
  %77 = insertelement <4 x float> %75, float %76, i32 3
  %or3691081 = or i1 %42, %48
  %or3701082 = or i1 %or3691081, %54
  %or3711083 = or i1 %or3701082, %60
  %tobool374 = icmp ne i32 %dec, 0
  %or.cond = and i1 %or3711083, %tobool374
  br i1 %or.cond, label %do.body, label %if.end

if.end:                                           ; preds = %land.end315, %for.end
  %ccount.2 = phi <4 x i32> [ %ccount.0.lcssa, %for.end ], [ %add328, %land.end315 ]
  %savx.2 = phi <4 x float> [ %savx.0.lcssa, %for.end ], [ %69, %land.end315 ]
  %savy.2 = phi <4 x float> [ %savy.0.lcssa, %for.end ], [ %77, %land.end315 ]
  %call378 = tail call <4 x float> @_Z14convert_float4Dv4_i(<4 x i32> %ccount.2) #4
  %78 = extractelement <4 x i32> %ccount.2, i32 0
  %conv379 = sitofp i32 %78 to float
  %add380 = fadd float %conv379, 1.000000e+00
  %79 = extractelement <4 x float> %savx.2, i32 0
  %80 = extractelement <4 x float> %savy.2, i32 0
  %mul382 = fmul float %80, %80
  %81 = tail call float @llvm.fmuladd.f32(float %79, float %79, float %mul382)
  %call383 = tail call float @llvm.log2.f32(float %81)
  %call384 = tail call float @llvm.log2.f32(float %call383)
  %sub385 = fsub float %add380, %call384
  %82 = extractelement <4 x i32> %ccount.2, i32 1
  %conv386 = sitofp i32 %82 to float
  %add387 = fadd float %conv386, 1.000000e+00
  %83 = extractelement <4 x float> %savx.2, i32 1
  %84 = extractelement <4 x float> %savy.2, i32 1
  %mul389 = fmul float %84, %84
  %85 = tail call float @llvm.fmuladd.f32(float %83, float %83, float %mul389)
  %call390 = tail call float @llvm.log2.f32(float %85)
  %call391 = tail call float @llvm.log2.f32(float %call390)
  %sub392 = fsub float %add387, %call391
  %86 = extractelement <4 x i32> %ccount.2, i32 2
  %conv393 = sitofp i32 %86 to float
  %add394 = fadd float %conv393, 1.000000e+00
  %87 = extractelement <4 x float> %savx.2, i32 2
  %88 = extractelement <4 x float> %savy.2, i32 2
  %mul396 = fmul float %88, %88
  %89 = tail call float @llvm.fmuladd.f32(float %87, float %87, float %mul396)
  %call397 = tail call float @llvm.log2.f32(float %89)
  %call398 = tail call float @llvm.log2.f32(float %call397)
  %sub399 = fsub float %add394, %call398
  %90 = extractelement <4 x i32> %ccount.2, i32 3
  %conv400 = sitofp i32 %90 to float
  %add401 = fadd float %conv400, 1.000000e+00
  %91 = extractelement <4 x float> %savx.2, i32 3
  %92 = extractelement <4 x float> %savy.2, i32 3
  %mul403 = fmul float %92, %92
  %93 = tail call float @llvm.fmuladd.f32(float %91, float %91, float %mul403)
  %call404 = tail call float @llvm.log2.f32(float %93)
  %call405 = tail call float @llvm.log2.f32(float %call404)
  %sub406 = fsub float %add401, %call405
  %mul408 = fmul float %sub385, 2.000000e+00
  %mul409 = fmul float %mul408, 0x400921FF20000000
  %div410 = fmul float %mul409, 3.906250e-03
  %call412 = tail call float @_Z3cosf(float %div410) #4
  %add413 = fadd float %call412, 1.000000e+00
  %mul414 = fmul float %add413, 5.000000e-01
  %mul415 = fmul float %mul414, 2.550000e+02
  %conv416 = fptoui float %mul415 to i8
  %94 = insertelement <4 x i8> undef, i8 %conv416, i32 0
  %95 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %div410, float 0x4000C154C0000000)
  %call418 = tail call float @_Z3cosf(float %95) #4
  %add419 = fadd float %call418, 1.000000e+00
  %mul420 = fmul float %add419, 5.000000e-01
  %mul421 = fmul float %mul420, 2.550000e+02
  %conv422 = fptoui float %mul421 to i8
  %96 = insertelement <4 x i8> %94, i8 %conv422, i32 1
  %sub424 = fadd float %div410, 0xC000C154C0000000
  %call425 = tail call float @_Z3cosf(float %sub424) #4
  %add426 = fadd float %call425, 1.000000e+00
  %mul427 = fmul float %add426, 5.000000e-01
  %mul428 = fmul float %mul427, 2.550000e+02
  %conv429 = fptoui float %mul428 to i8
  %97 = insertelement <4 x i8> %96, i8 %conv429, i32 2
  %98 = insertelement <4 x i8> %97, i8 -1, i32 3
  %cmp432 = icmp eq i32 %78, %maxIterations
  br i1 %cmp432, label %if.then434, label %if.end438

if.then434:                                       ; preds = %if.end
  %99 = insertelement <4 x i8> %98, i8 0, i32 0
  %100 = insertelement <4 x i8> %99, i8 0, i32 1
  %101 = insertelement <4 x i8> %100, i8 0, i32 2
  br label %if.end438

if.end438:                                        ; preds = %if.then434, %if.end
  %color.sroa.0.0 = phi <4 x i8> [ %101, %if.then434 ], [ %98, %if.end ]
  %tobool439 = icmp ne i32 %bench, 0
  br i1 %tobool439, label %if.then440, label %if.end455

if.then440:                                       ; preds = %if.end438
  %conv442 = trunc i32 %78 to i8
  %102 = insertelement <4 x i8> undef, i8 %conv442, i32 0
  %and444 = lshr i32 %78, 8
  %conv445 = trunc i32 %and444 to i8
  %103 = insertelement <4 x i8> %102, i8 %conv445, i32 1
  %and447 = lshr i32 %78, 16
  %conv449 = trunc i32 %and447 to i8
  %104 = insertelement <4 x i8> %103, i8 %conv449, i32 2
  %shr452 = lshr i32 %78, 24
  %conv453 = trunc i32 %shr452 to i8
  %105 = insertelement <4 x i8> %104, i8 %conv453, i32 3
  br label %if.end455

if.end455:                                        ; preds = %if.then440, %if.end438
  %color.sroa.0.1 = phi <4 x i8> [ %105, %if.then440 ], [ %color.sroa.0.0, %if.end438 ]
  %mul457 = shl nsw i32 %call, 2
  %106 = sext i32 %mul457 to i64
  %arrayidx458 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i64 %106
  store <4 x i8> %color.sroa.0.1, <4 x i8> addrspace(1)* %arrayidx458, align 4, !tbaa !2
  %mul459 = fmul float %sub392, 2.000000e+00
  %mul460 = fmul float %mul459, 0x400921FF20000000
  %div461 = fmul float %mul460, 3.906250e-03
  %call462 = tail call float @_Z3cosf(float %div461) #4
  %add463 = fadd float %call462, 1.000000e+00
  %mul464 = fmul float %add463, 5.000000e-01
  %mul465 = fmul float %mul464, 2.550000e+02
  %conv466 = fptoui float %mul465 to i8
  %107 = insertelement <4 x i8> undef, i8 %conv466, i32 0
  %108 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %div461, float 0x4000C154C0000000)
  %call469 = tail call float @_Z3cosf(float %108) #4
  %add470 = fadd float %call469, 1.000000e+00
  %mul471 = fmul float %add470, 5.000000e-01
  %mul472 = fmul float %mul471, 2.550000e+02
  %conv473 = fptoui float %mul472 to i8
  %109 = insertelement <4 x i8> %107, i8 %conv473, i32 1
  %sub475 = fadd float %div461, 0xC000C154C0000000
  %call476 = tail call float @_Z3cosf(float %sub475) #4
  %add477 = fadd float %call476, 1.000000e+00
  %mul478 = fmul float %add477, 5.000000e-01
  %mul479 = fmul float %mul478, 2.550000e+02
  %conv480 = fptoui float %mul479 to i8
  %110 = insertelement <4 x i8> %109, i8 %conv480, i32 2
  %111 = insertelement <4 x i8> %110, i8 -1, i32 3
  %cmp483 = icmp eq i32 %82, %maxIterations
  br i1 %cmp483, label %if.then485, label %if.end489

if.then485:                                       ; preds = %if.end455
  %112 = insertelement <4 x i8> %111, i8 0, i32 0
  %113 = insertelement <4 x i8> %112, i8 0, i32 1
  %114 = insertelement <4 x i8> %113, i8 0, i32 2
  br label %if.end489

if.end489:                                        ; preds = %if.then485, %if.end455
  %color.sroa.23.0 = phi <4 x i8> [ %114, %if.then485 ], [ %111, %if.end455 ]
  br i1 %tobool439, label %if.then491, label %if.end507

if.then491:                                       ; preds = %if.end489
  %conv493 = trunc i32 %82 to i8
  %115 = insertelement <4 x i8> undef, i8 %conv493, i32 0
  %and495 = lshr i32 %82, 8
  %conv497 = trunc i32 %and495 to i8
  %116 = insertelement <4 x i8> %115, i8 %conv497, i32 1
  %and499 = lshr i32 %82, 16
  %conv501 = trunc i32 %and499 to i8
  %117 = insertelement <4 x i8> %116, i8 %conv501, i32 2
  %shr504 = lshr i32 %82, 24
  %conv505 = trunc i32 %shr504 to i8
  %118 = insertelement <4 x i8> %117, i8 %conv505, i32 3
  br label %if.end507

if.end507:                                        ; preds = %if.then491, %if.end489
  %color.sroa.23.1 = phi <4 x i8> [ %118, %if.then491 ], [ %color.sroa.23.0, %if.end489 ]
  %add5101084 = or i32 %mul457, 1
  %119 = sext i32 %add5101084 to i64
  %arrayidx511 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i64 %119
  store <4 x i8> %color.sroa.23.1, <4 x i8> addrspace(1)* %arrayidx511, align 4, !tbaa !2
  %mul512 = fmul float %sub399, 2.000000e+00
  %mul513 = fmul float %mul512, 0x400921FF20000000
  %div514 = fmul float %mul513, 3.906250e-03
  %call515 = tail call float @_Z3cosf(float %div514) #4
  %add516 = fadd float %call515, 1.000000e+00
  %mul517 = fmul float %add516, 5.000000e-01
  %mul518 = fmul float %mul517, 2.550000e+02
  %conv519 = fptoui float %mul518 to i8
  %120 = insertelement <4 x i8> undef, i8 %conv519, i32 0
  %121 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %div514, float 0x4000C154C0000000)
  %call522 = tail call float @_Z3cosf(float %121) #4
  %add523 = fadd float %call522, 1.000000e+00
  %mul524 = fmul float %add523, 5.000000e-01
  %mul525 = fmul float %mul524, 2.550000e+02
  %conv526 = fptoui float %mul525 to i8
  %122 = insertelement <4 x i8> %120, i8 %conv526, i32 1
  %sub528 = fadd float %div514, 0xC000C154C0000000
  %call529 = tail call float @_Z3cosf(float %sub528) #4
  %add530 = fadd float %call529, 1.000000e+00
  %mul531 = fmul float %add530, 5.000000e-01
  %mul532 = fmul float %mul531, 2.550000e+02
  %conv533 = fptoui float %mul532 to i8
  %123 = insertelement <4 x i8> %122, i8 %conv533, i32 2
  %124 = insertelement <4 x i8> %123, i8 -1, i32 3
  %cmp536 = icmp eq i32 %86, %maxIterations
  br i1 %cmp536, label %if.then538, label %if.end542

if.then538:                                       ; preds = %if.end507
  %125 = insertelement <4 x i8> %124, i8 0, i32 0
  %126 = insertelement <4 x i8> %125, i8 0, i32 1
  %127 = insertelement <4 x i8> %126, i8 0, i32 2
  br label %if.end542

if.end542:                                        ; preds = %if.then538, %if.end507
  %color.sroa.46.0 = phi <4 x i8> [ %127, %if.then538 ], [ %124, %if.end507 ]
  br i1 %tobool439, label %if.then544, label %if.end560

if.then544:                                       ; preds = %if.end542
  %conv546 = trunc i32 %86 to i8
  %128 = insertelement <4 x i8> undef, i8 %conv546, i32 0
  %and548 = lshr i32 %86, 8
  %conv550 = trunc i32 %and548 to i8
  %129 = insertelement <4 x i8> %128, i8 %conv550, i32 1
  %and552 = lshr i32 %86, 16
  %conv554 = trunc i32 %and552 to i8
  %130 = insertelement <4 x i8> %129, i8 %conv554, i32 2
  %shr557 = lshr i32 %86, 24
  %conv558 = trunc i32 %shr557 to i8
  %131 = insertelement <4 x i8> %130, i8 %conv558, i32 3
  br label %if.end560

if.end560:                                        ; preds = %if.then544, %if.end542
  %color.sroa.46.1 = phi <4 x i8> [ %131, %if.then544 ], [ %color.sroa.46.0, %if.end542 ]
  %add5631085 = or i32 %mul457, 2
  %132 = sext i32 %add5631085 to i64
  %arrayidx564 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i64 %132
  store <4 x i8> %color.sroa.46.1, <4 x i8> addrspace(1)* %arrayidx564, align 4, !tbaa !2
  %mul565 = fmul float %sub406, 2.000000e+00
  %mul566 = fmul float %mul565, 0x400921FF20000000
  %div567 = fmul float %mul566, 3.906250e-03
  %call568 = tail call float @_Z3cosf(float %div567) #4
  %add569 = fadd float %call568, 1.000000e+00
  %mul570 = fmul float %add569, 5.000000e-01
  %mul571 = fmul float %mul570, 2.550000e+02
  %conv572 = fptoui float %mul571 to i8
  %133 = insertelement <4 x i8> undef, i8 %conv572, i32 0
  %134 = tail call float @llvm.fmuladd.f32(float 2.000000e+00, float %div567, float 0x4000C154C0000000)
  %call575 = tail call float @_Z3cosf(float %134) #4
  %add576 = fadd float %call575, 1.000000e+00
  %mul577 = fmul float %add576, 5.000000e-01
  %mul578 = fmul float %mul577, 2.550000e+02
  %conv579 = fptoui float %mul578 to i8
  %135 = insertelement <4 x i8> %133, i8 %conv579, i32 1
  %sub581 = fadd float %div567, 0xC000C154C0000000
  %call582 = tail call float @_Z3cosf(float %sub581) #4
  %add583 = fadd float %call582, 1.000000e+00
  %mul584 = fmul float %add583, 5.000000e-01
  %mul585 = fmul float %mul584, 2.550000e+02
  %conv586 = fptoui float %mul585 to i8
  %136 = insertelement <4 x i8> %135, i8 %conv586, i32 2
  %137 = insertelement <4 x i8> %136, i8 -1, i32 3
  %cmp589 = icmp eq i32 %90, %maxIterations
  br i1 %cmp589, label %if.then591, label %if.end595

if.then591:                                       ; preds = %if.end560
  %138 = insertelement <4 x i8> %137, i8 0, i32 0
  %139 = insertelement <4 x i8> %138, i8 0, i32 1
  %140 = insertelement <4 x i8> %139, i8 0, i32 2
  br label %if.end595

if.end595:                                        ; preds = %if.then591, %if.end560
  %color.sroa.69.0 = phi <4 x i8> [ %140, %if.then591 ], [ %137, %if.end560 ]
  br i1 %tobool439, label %if.then597, label %if.end613

if.then597:                                       ; preds = %if.end595
  %conv599 = trunc i32 %90 to i8
  %141 = insertelement <4 x i8> undef, i8 %conv599, i32 0
  %and601 = lshr i32 %90, 8
  %conv603 = trunc i32 %and601 to i8
  %142 = insertelement <4 x i8> %141, i8 %conv603, i32 1
  %and605 = lshr i32 %90, 16
  %conv607 = trunc i32 %and605 to i8
  %143 = insertelement <4 x i8> %142, i8 %conv607, i32 2
  %shr610 = lshr i32 %90, 24
  %conv611 = trunc i32 %shr610 to i8
  %144 = insertelement <4 x i8> %143, i8 %conv611, i32 3
  br label %if.end613

if.end613:                                        ; preds = %if.then597, %if.end595
  %color.sroa.69.1 = phi <4 x i8> [ %144, %if.then597 ], [ %color.sroa.69.0, %if.end595 ]
  %add6161086 = or i32 %mul457, 3
  %145 = sext i32 %add6161086 to i64
  %arrayidx617 = getelementptr inbounds <4 x i8> addrspace(1)* %mandelbrotImage, i64 %145
  store <4 x i8> %color.sroa.69.1, <4 x i8> addrspace(1)* %arrayidx617, align 4, !tbaa !2
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare i32 @MUL_ADD(...) #1

declare <4 x float> @_Z14convert_float4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind readonly
declare float @llvm.log2.f32(float) #3

declare float @_Z3cosf(float) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i8> addrspace(1)*, float, float, float, float, i32, i32, i32)* @mandelbrot_vector_float}
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

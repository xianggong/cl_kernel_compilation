; ModuleID = 'HDRToneMapping_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc75 float @luminance(float %r, float %g, float %b) #0 {
entry:
  %r.addr = alloca float, align 4
  %g.addr = alloca float, align 4
  %b.addr = alloca float, align 4
  store float %r, float* %r.addr, align 4
  store float %g, float* %g.addr, align 4
  store float %b, float* %b.addr, align 4
  %0 = load float* %r.addr, align 4
  %1 = load float* %g.addr, align 4
  %mul1 = fmul float 0x3FE6E2EB20000000, %1
  %2 = call float @llvm.fmuladd.f32(float 0x3FCB367A00000000, float %0, float %mul1)
  %3 = load float* %b.addr, align 4
  %4 = call float @llvm.fmuladd.f32(float 0x3FB27BB300000000, float %3, float %2)
  ret float %4
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_toneMappingPattanaik1_kernel(float addrspace(1)* %input, float addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
entry:
  %input.addr = alloca float addrspace(1)*, align 8
  %output.addr = alloca float addrspace(1)*, align 8
  %averageLuminance.addr = alloca float, align 4
  %gamma.addr = alloca float, align 4
  %c.addr = alloca float, align 4
  %delta.addr = alloca float, align 4
  %width.addr = alloca i32, align 4
  %numChannels.addr = alloca i32, align 4
  %height.addr = alloca i32, align 4
  %globalIdX = alloca i32, align 4
  %globalIdY = alloca i32, align 4
  %r = alloca float, align 4
  %r1 = alloca float, align 4
  %g = alloca float, align 4
  %g1 = alloca float, align 4
  %b = alloca float, align 4
  %b1 = alloca float, align 4
  %yLuminance = alloca float, align 4
  %cLPattanaik = alloca float, align 4
  %yLPattanaik = alloca float, align 4
  %gcPattanaik = alloca float, align 4
  %leftUp = alloca float, align 4
  %up = alloca float, align 4
  %rightUp = alloca float, align 4
  %left = alloca float, align 4
  %right = alloca float, align 4
  %leftDown = alloca float, align 4
  %down = alloca float, align 4
  %rightDown = alloca float, align 4
  %yDPattanaik = alloca float, align 4
  store float addrspace(1)* %input, float addrspace(1)** %input.addr, align 8
  store float addrspace(1)* %output, float addrspace(1)** %output.addr, align 8
  store float %averageLuminance, float* %averageLuminance.addr, align 4
  store float %gamma, float* %gamma.addr, align 4
  store float %c, float* %c.addr, align 4
  store float %delta, float* %delta.addr, align 4
  store i32 %width, i32* %width.addr, align 4
  store i32 %numChannels, i32* %numChannels.addr, align 4
  store i32 %height, i32* %height.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %globalIdX, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %globalIdY, align 4
  store float 0.000000e+00, float* %yLuminance, align 4
  store float 0.000000e+00, float* %cLPattanaik, align 4
  store float 0.000000e+00, float* %yLPattanaik, align 4
  %0 = load i32* %width.addr, align 4
  %1 = load i32* %numChannels.addr, align 4
  %mul = mul i32 %0, %1
  %2 = load i32* %globalIdY, align 4
  %mul3 = mul i32 %mul, %2
  %3 = load i32* %globalIdX, align 4
  %4 = load i32* %numChannels.addr, align 4
  %mul4 = mul i32 %3, %4
  %add = add i32 %mul4, 0
  %add5 = add i32 %mul3, %add
  %idxprom = zext i32 %add5 to i64
  %5 = load float addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds float addrspace(1)* %5, i64 %idxprom
  %6 = load float addrspace(1)* %arrayidx, align 4
  store float %6, float* %r1, align 4
  %7 = load i32* %width.addr, align 4
  %8 = load i32* %numChannels.addr, align 4
  %mul6 = mul i32 %7, %8
  %9 = load i32* %globalIdY, align 4
  %mul7 = mul i32 %mul6, %9
  %10 = load i32* %globalIdX, align 4
  %11 = load i32* %numChannels.addr, align 4
  %mul8 = mul i32 %10, %11
  %add9 = add i32 %mul8, 1
  %add10 = add i32 %mul7, %add9
  %idxprom11 = zext i32 %add10 to i64
  %12 = load float addrspace(1)** %input.addr, align 8
  %arrayidx12 = getelementptr inbounds float addrspace(1)* %12, i64 %idxprom11
  %13 = load float addrspace(1)* %arrayidx12, align 4
  store float %13, float* %g1, align 4
  %14 = load i32* %width.addr, align 4
  %15 = load i32* %numChannels.addr, align 4
  %mul13 = mul i32 %14, %15
  %16 = load i32* %globalIdY, align 4
  %mul14 = mul i32 %mul13, %16
  %17 = load i32* %globalIdX, align 4
  %18 = load i32* %numChannels.addr, align 4
  %mul15 = mul i32 %17, %18
  %add16 = add i32 %mul15, 2
  %add17 = add i32 %mul14, %add16
  %idxprom18 = zext i32 %add17 to i64
  %19 = load float addrspace(1)** %input.addr, align 8
  %arrayidx19 = getelementptr inbounds float addrspace(1)* %19, i64 %idxprom18
  %20 = load float addrspace(1)* %arrayidx19, align 4
  store float %20, float* %b1, align 4
  %21 = load float* %r1, align 4
  %22 = load float* %g1, align 4
  %23 = load float* %b1, align 4
  %call20 = call cc75 float @luminance(float %21, float %22, float %23)
  store float %call20, float* %yLuminance, align 4
  %24 = load float* %c.addr, align 4
  %25 = load float* %averageLuminance.addr, align 4
  %mul21 = fmul float %24, %25
  store float %mul21, float* %gcPattanaik, align 4
  %26 = load i32* %globalIdX, align 4
  %cmp = icmp ne i32 %26, 0
  br i1 %cmp, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %entry
  %27 = load i32* %globalIdY, align 4
  %cmp23 = icmp ne i32 %27, 0
  br i1 %cmp23, label %land.lhs.true25, label %if.else

land.lhs.true25:                                  ; preds = %land.lhs.true
  %28 = load i32* %globalIdX, align 4
  %29 = load i32* %width.addr, align 4
  %sub = sub i32 %29, 1
  %cmp26 = icmp ne i32 %28, %sub
  br i1 %cmp26, label %land.lhs.true28, label %if.else

land.lhs.true28:                                  ; preds = %land.lhs.true25
  %30 = load i32* %globalIdY, align 4
  %31 = load i32* %height.addr, align 4
  %sub29 = sub i32 %31, 1
  %cmp30 = icmp ne i32 %30, %sub29
  br i1 %cmp30, label %if.then, label %if.else

if.then:                                          ; preds = %land.lhs.true28
  store float 0.000000e+00, float* %leftUp, align 4
  store float 0.000000e+00, float* %up, align 4
  store float 0.000000e+00, float* %rightUp, align 4
  store float 0.000000e+00, float* %left, align 4
  store float 0.000000e+00, float* %right, align 4
  store float 0.000000e+00, float* %leftDown, align 4
  store float 0.000000e+00, float* %down, align 4
  store float 0.000000e+00, float* %rightDown, align 4
  %32 = load i32* %width.addr, align 4
  %33 = load i32* %numChannels.addr, align 4
  %mul32 = mul i32 %32, %33
  %34 = load i32* %globalIdY, align 4
  %sub33 = sub i32 %34, 1
  %mul34 = mul i32 %mul32, %sub33
  %35 = load i32* %globalIdX, align 4
  %sub35 = sub i32 %35, 1
  %36 = load i32* %numChannels.addr, align 4
  %mul36 = mul i32 %sub35, %36
  %add37 = add i32 %mul34, %mul36
  %add38 = add i32 %add37, 0
  %idxprom39 = zext i32 %add38 to i64
  %37 = load float addrspace(1)** %input.addr, align 8
  %arrayidx40 = getelementptr inbounds float addrspace(1)* %37, i64 %idxprom39
  %38 = load float addrspace(1)* %arrayidx40, align 4
  store float %38, float* %r, align 4
  %39 = load i32* %width.addr, align 4
  %40 = load i32* %numChannels.addr, align 4
  %mul41 = mul i32 %39, %40
  %41 = load i32* %globalIdY, align 4
  %sub42 = sub i32 %41, 1
  %mul43 = mul i32 %mul41, %sub42
  %42 = load i32* %globalIdX, align 4
  %sub44 = sub i32 %42, 1
  %43 = load i32* %numChannels.addr, align 4
  %mul45 = mul i32 %sub44, %43
  %add46 = add i32 %mul43, %mul45
  %add47 = add i32 %add46, 1
  %idxprom48 = zext i32 %add47 to i64
  %44 = load float addrspace(1)** %input.addr, align 8
  %arrayidx49 = getelementptr inbounds float addrspace(1)* %44, i64 %idxprom48
  %45 = load float addrspace(1)* %arrayidx49, align 4
  store float %45, float* %g, align 4
  %46 = load i32* %width.addr, align 4
  %47 = load i32* %numChannels.addr, align 4
  %mul50 = mul i32 %46, %47
  %48 = load i32* %globalIdY, align 4
  %sub51 = sub i32 %48, 1
  %mul52 = mul i32 %mul50, %sub51
  %49 = load i32* %globalIdX, align 4
  %sub53 = sub i32 %49, 1
  %50 = load i32* %numChannels.addr, align 4
  %mul54 = mul i32 %sub53, %50
  %add55 = add i32 %mul52, %mul54
  %add56 = add i32 %add55, 2
  %idxprom57 = zext i32 %add56 to i64
  %51 = load float addrspace(1)** %input.addr, align 8
  %arrayidx58 = getelementptr inbounds float addrspace(1)* %51, i64 %idxprom57
  %52 = load float addrspace(1)* %arrayidx58, align 4
  store float %52, float* %b, align 4
  %53 = load float* %r, align 4
  %54 = load float* %g, align 4
  %55 = load float* %b, align 4
  %call59 = call cc75 float @luminance(float %53, float %54, float %55)
  store float %call59, float* %leftUp, align 4
  %56 = load i32* %width.addr, align 4
  %57 = load i32* %numChannels.addr, align 4
  %mul60 = mul i32 %56, %57
  %58 = load i32* %globalIdY, align 4
  %sub61 = sub i32 %58, 1
  %mul62 = mul i32 %mul60, %sub61
  %59 = load i32* %globalIdX, align 4
  %60 = load i32* %numChannels.addr, align 4
  %mul63 = mul i32 %59, %60
  %add64 = add i32 %mul62, %mul63
  %add65 = add i32 %add64, 0
  %idxprom66 = zext i32 %add65 to i64
  %61 = load float addrspace(1)** %input.addr, align 8
  %arrayidx67 = getelementptr inbounds float addrspace(1)* %61, i64 %idxprom66
  %62 = load float addrspace(1)* %arrayidx67, align 4
  store float %62, float* %r, align 4
  %63 = load i32* %width.addr, align 4
  %64 = load i32* %numChannels.addr, align 4
  %mul68 = mul i32 %63, %64
  %65 = load i32* %globalIdY, align 4
  %sub69 = sub i32 %65, 1
  %mul70 = mul i32 %mul68, %sub69
  %66 = load i32* %globalIdX, align 4
  %67 = load i32* %numChannels.addr, align 4
  %mul71 = mul i32 %66, %67
  %add72 = add i32 %mul70, %mul71
  %add73 = add i32 %add72, 1
  %idxprom74 = zext i32 %add73 to i64
  %68 = load float addrspace(1)** %input.addr, align 8
  %arrayidx75 = getelementptr inbounds float addrspace(1)* %68, i64 %idxprom74
  %69 = load float addrspace(1)* %arrayidx75, align 4
  store float %69, float* %g, align 4
  %70 = load i32* %width.addr, align 4
  %71 = load i32* %numChannels.addr, align 4
  %mul76 = mul i32 %70, %71
  %72 = load i32* %globalIdY, align 4
  %sub77 = sub i32 %72, 1
  %mul78 = mul i32 %mul76, %sub77
  %73 = load i32* %globalIdX, align 4
  %74 = load i32* %numChannels.addr, align 4
  %mul79 = mul i32 %73, %74
  %add80 = add i32 %mul78, %mul79
  %add81 = add i32 %add80, 2
  %idxprom82 = zext i32 %add81 to i64
  %75 = load float addrspace(1)** %input.addr, align 8
  %arrayidx83 = getelementptr inbounds float addrspace(1)* %75, i64 %idxprom82
  %76 = load float addrspace(1)* %arrayidx83, align 4
  store float %76, float* %b, align 4
  %77 = load float* %r, align 4
  %78 = load float* %g, align 4
  %79 = load float* %b, align 4
  %call84 = call cc75 float @luminance(float %77, float %78, float %79)
  store float %call84, float* %up, align 4
  %80 = load i32* %width.addr, align 4
  %81 = load i32* %numChannels.addr, align 4
  %mul85 = mul i32 %80, %81
  %82 = load i32* %globalIdY, align 4
  %sub86 = sub i32 %82, 1
  %mul87 = mul i32 %mul85, %sub86
  %83 = load i32* %globalIdX, align 4
  %add88 = add i32 %83, 1
  %84 = load i32* %numChannels.addr, align 4
  %mul89 = mul i32 %add88, %84
  %add90 = add i32 %mul87, %mul89
  %add91 = add i32 %add90, 0
  %idxprom92 = zext i32 %add91 to i64
  %85 = load float addrspace(1)** %input.addr, align 8
  %arrayidx93 = getelementptr inbounds float addrspace(1)* %85, i64 %idxprom92
  %86 = load float addrspace(1)* %arrayidx93, align 4
  store float %86, float* %r, align 4
  %87 = load i32* %width.addr, align 4
  %88 = load i32* %numChannels.addr, align 4
  %mul94 = mul i32 %87, %88
  %89 = load i32* %globalIdY, align 4
  %sub95 = sub i32 %89, 1
  %mul96 = mul i32 %mul94, %sub95
  %90 = load i32* %globalIdX, align 4
  %add97 = add i32 %90, 1
  %91 = load i32* %numChannels.addr, align 4
  %mul98 = mul i32 %add97, %91
  %add99 = add i32 %mul96, %mul98
  %add100 = add i32 %add99, 1
  %idxprom101 = zext i32 %add100 to i64
  %92 = load float addrspace(1)** %input.addr, align 8
  %arrayidx102 = getelementptr inbounds float addrspace(1)* %92, i64 %idxprom101
  %93 = load float addrspace(1)* %arrayidx102, align 4
  store float %93, float* %g, align 4
  %94 = load i32* %width.addr, align 4
  %95 = load i32* %numChannels.addr, align 4
  %mul103 = mul i32 %94, %95
  %96 = load i32* %globalIdY, align 4
  %sub104 = sub i32 %96, 1
  %mul105 = mul i32 %mul103, %sub104
  %97 = load i32* %globalIdX, align 4
  %add106 = add i32 %97, 1
  %98 = load i32* %numChannels.addr, align 4
  %mul107 = mul i32 %add106, %98
  %add108 = add i32 %mul105, %mul107
  %add109 = add i32 %add108, 2
  %idxprom110 = zext i32 %add109 to i64
  %99 = load float addrspace(1)** %input.addr, align 8
  %arrayidx111 = getelementptr inbounds float addrspace(1)* %99, i64 %idxprom110
  %100 = load float addrspace(1)* %arrayidx111, align 4
  store float %100, float* %b, align 4
  %101 = load float* %r, align 4
  %102 = load float* %g, align 4
  %103 = load float* %b, align 4
  %call112 = call cc75 float @luminance(float %101, float %102, float %103)
  store float %call112, float* %rightUp, align 4
  %104 = load i32* %width.addr, align 4
  %105 = load i32* %numChannels.addr, align 4
  %mul113 = mul i32 %104, %105
  %106 = load i32* %globalIdY, align 4
  %mul114 = mul i32 %mul113, %106
  %107 = load i32* %globalIdX, align 4
  %sub115 = sub i32 %107, 1
  %108 = load i32* %numChannels.addr, align 4
  %mul116 = mul i32 %sub115, %108
  %add117 = add i32 %mul114, %mul116
  %add118 = add i32 %add117, 0
  %idxprom119 = zext i32 %add118 to i64
  %109 = load float addrspace(1)** %input.addr, align 8
  %arrayidx120 = getelementptr inbounds float addrspace(1)* %109, i64 %idxprom119
  %110 = load float addrspace(1)* %arrayidx120, align 4
  store float %110, float* %r, align 4
  %111 = load i32* %width.addr, align 4
  %112 = load i32* %numChannels.addr, align 4
  %mul121 = mul i32 %111, %112
  %113 = load i32* %globalIdY, align 4
  %mul122 = mul i32 %mul121, %113
  %114 = load i32* %globalIdX, align 4
  %sub123 = sub i32 %114, 1
  %115 = load i32* %numChannels.addr, align 4
  %mul124 = mul i32 %sub123, %115
  %add125 = add i32 %mul122, %mul124
  %add126 = add i32 %add125, 1
  %idxprom127 = zext i32 %add126 to i64
  %116 = load float addrspace(1)** %input.addr, align 8
  %arrayidx128 = getelementptr inbounds float addrspace(1)* %116, i64 %idxprom127
  %117 = load float addrspace(1)* %arrayidx128, align 4
  store float %117, float* %g, align 4
  %118 = load i32* %width.addr, align 4
  %119 = load i32* %numChannels.addr, align 4
  %mul129 = mul i32 %118, %119
  %120 = load i32* %globalIdY, align 4
  %mul130 = mul i32 %mul129, %120
  %121 = load i32* %globalIdX, align 4
  %sub131 = sub i32 %121, 1
  %122 = load i32* %numChannels.addr, align 4
  %mul132 = mul i32 %sub131, %122
  %add133 = add i32 %mul130, %mul132
  %add134 = add i32 %add133, 2
  %idxprom135 = zext i32 %add134 to i64
  %123 = load float addrspace(1)** %input.addr, align 8
  %arrayidx136 = getelementptr inbounds float addrspace(1)* %123, i64 %idxprom135
  %124 = load float addrspace(1)* %arrayidx136, align 4
  store float %124, float* %b, align 4
  %125 = load float* %r, align 4
  %126 = load float* %g, align 4
  %127 = load float* %b, align 4
  %call137 = call cc75 float @luminance(float %125, float %126, float %127)
  store float %call137, float* %left, align 4
  %128 = load i32* %width.addr, align 4
  %129 = load i32* %numChannels.addr, align 4
  %mul138 = mul i32 %128, %129
  %130 = load i32* %globalIdY, align 4
  %mul139 = mul i32 %mul138, %130
  %131 = load i32* %globalIdX, align 4
  %add140 = add i32 %131, 1
  %132 = load i32* %numChannels.addr, align 4
  %mul141 = mul i32 %add140, %132
  %add142 = add i32 %mul139, %mul141
  %add143 = add i32 %add142, 0
  %idxprom144 = zext i32 %add143 to i64
  %133 = load float addrspace(1)** %input.addr, align 8
  %arrayidx145 = getelementptr inbounds float addrspace(1)* %133, i64 %idxprom144
  %134 = load float addrspace(1)* %arrayidx145, align 4
  store float %134, float* %r, align 4
  %135 = load i32* %width.addr, align 4
  %136 = load i32* %numChannels.addr, align 4
  %mul146 = mul i32 %135, %136
  %137 = load i32* %globalIdY, align 4
  %mul147 = mul i32 %mul146, %137
  %138 = load i32* %globalIdX, align 4
  %add148 = add i32 %138, 1
  %139 = load i32* %numChannels.addr, align 4
  %mul149 = mul i32 %add148, %139
  %add150 = add i32 %mul147, %mul149
  %add151 = add i32 %add150, 1
  %idxprom152 = zext i32 %add151 to i64
  %140 = load float addrspace(1)** %input.addr, align 8
  %arrayidx153 = getelementptr inbounds float addrspace(1)* %140, i64 %idxprom152
  %141 = load float addrspace(1)* %arrayidx153, align 4
  store float %141, float* %g, align 4
  %142 = load i32* %width.addr, align 4
  %143 = load i32* %numChannels.addr, align 4
  %mul154 = mul i32 %142, %143
  %144 = load i32* %globalIdY, align 4
  %mul155 = mul i32 %mul154, %144
  %145 = load i32* %globalIdX, align 4
  %add156 = add i32 %145, 1
  %146 = load i32* %numChannels.addr, align 4
  %mul157 = mul i32 %add156, %146
  %add158 = add i32 %mul155, %mul157
  %add159 = add i32 %add158, 2
  %idxprom160 = zext i32 %add159 to i64
  %147 = load float addrspace(1)** %input.addr, align 8
  %arrayidx161 = getelementptr inbounds float addrspace(1)* %147, i64 %idxprom160
  %148 = load float addrspace(1)* %arrayidx161, align 4
  store float %148, float* %b, align 4
  %149 = load float* %r, align 4
  %150 = load float* %g, align 4
  %151 = load float* %b, align 4
  %call162 = call cc75 float @luminance(float %149, float %150, float %151)
  store float %call162, float* %right, align 4
  %152 = load i32* %width.addr, align 4
  %153 = load i32* %numChannels.addr, align 4
  %mul163 = mul i32 %152, %153
  %154 = load i32* %globalIdY, align 4
  %add164 = add i32 %154, 1
  %mul165 = mul i32 %mul163, %add164
  %155 = load i32* %globalIdX, align 4
  %sub166 = sub i32 %155, 1
  %156 = load i32* %numChannels.addr, align 4
  %mul167 = mul i32 %sub166, %156
  %add168 = add i32 %mul165, %mul167
  %add169 = add i32 %add168, 0
  %idxprom170 = zext i32 %add169 to i64
  %157 = load float addrspace(1)** %input.addr, align 8
  %arrayidx171 = getelementptr inbounds float addrspace(1)* %157, i64 %idxprom170
  %158 = load float addrspace(1)* %arrayidx171, align 4
  store float %158, float* %r, align 4
  %159 = load i32* %width.addr, align 4
  %160 = load i32* %numChannels.addr, align 4
  %mul172 = mul i32 %159, %160
  %161 = load i32* %globalIdY, align 4
  %add173 = add i32 %161, 1
  %mul174 = mul i32 %mul172, %add173
  %162 = load i32* %globalIdX, align 4
  %sub175 = sub i32 %162, 1
  %163 = load i32* %numChannels.addr, align 4
  %mul176 = mul i32 %sub175, %163
  %add177 = add i32 %mul174, %mul176
  %add178 = add i32 %add177, 1
  %idxprom179 = zext i32 %add178 to i64
  %164 = load float addrspace(1)** %input.addr, align 8
  %arrayidx180 = getelementptr inbounds float addrspace(1)* %164, i64 %idxprom179
  %165 = load float addrspace(1)* %arrayidx180, align 4
  store float %165, float* %g, align 4
  %166 = load i32* %width.addr, align 4
  %167 = load i32* %numChannels.addr, align 4
  %mul181 = mul i32 %166, %167
  %168 = load i32* %globalIdY, align 4
  %add182 = add i32 %168, 1
  %mul183 = mul i32 %mul181, %add182
  %169 = load i32* %globalIdX, align 4
  %sub184 = sub i32 %169, 1
  %170 = load i32* %numChannels.addr, align 4
  %mul185 = mul i32 %sub184, %170
  %add186 = add i32 %mul183, %mul185
  %add187 = add i32 %add186, 2
  %idxprom188 = zext i32 %add187 to i64
  %171 = load float addrspace(1)** %input.addr, align 8
  %arrayidx189 = getelementptr inbounds float addrspace(1)* %171, i64 %idxprom188
  %172 = load float addrspace(1)* %arrayidx189, align 4
  store float %172, float* %b, align 4
  %173 = load float* %r, align 4
  %174 = load float* %g, align 4
  %175 = load float* %b, align 4
  %call190 = call cc75 float @luminance(float %173, float %174, float %175)
  store float %call190, float* %leftDown, align 4
  %176 = load i32* %width.addr, align 4
  %177 = load i32* %numChannels.addr, align 4
  %mul191 = mul i32 %176, %177
  %178 = load i32* %globalIdY, align 4
  %add192 = add i32 %178, 1
  %mul193 = mul i32 %mul191, %add192
  %179 = load i32* %globalIdX, align 4
  %180 = load i32* %numChannels.addr, align 4
  %mul194 = mul i32 %179, %180
  %add195 = add i32 %mul193, %mul194
  %add196 = add i32 %add195, 0
  %idxprom197 = zext i32 %add196 to i64
  %181 = load float addrspace(1)** %input.addr, align 8
  %arrayidx198 = getelementptr inbounds float addrspace(1)* %181, i64 %idxprom197
  %182 = load float addrspace(1)* %arrayidx198, align 4
  store float %182, float* %r, align 4
  %183 = load i32* %width.addr, align 4
  %184 = load i32* %numChannels.addr, align 4
  %mul199 = mul i32 %183, %184
  %185 = load i32* %globalIdY, align 4
  %add200 = add i32 %185, 1
  %mul201 = mul i32 %mul199, %add200
  %186 = load i32* %globalIdX, align 4
  %187 = load i32* %numChannels.addr, align 4
  %mul202 = mul i32 %186, %187
  %add203 = add i32 %mul201, %mul202
  %add204 = add i32 %add203, 1
  %idxprom205 = zext i32 %add204 to i64
  %188 = load float addrspace(1)** %input.addr, align 8
  %arrayidx206 = getelementptr inbounds float addrspace(1)* %188, i64 %idxprom205
  %189 = load float addrspace(1)* %arrayidx206, align 4
  store float %189, float* %g, align 4
  %190 = load i32* %width.addr, align 4
  %191 = load i32* %numChannels.addr, align 4
  %mul207 = mul i32 %190, %191
  %192 = load i32* %globalIdY, align 4
  %add208 = add i32 %192, 1
  %mul209 = mul i32 %mul207, %add208
  %193 = load i32* %globalIdX, align 4
  %194 = load i32* %numChannels.addr, align 4
  %mul210 = mul i32 %193, %194
  %add211 = add i32 %mul209, %mul210
  %add212 = add i32 %add211, 2
  %idxprom213 = zext i32 %add212 to i64
  %195 = load float addrspace(1)** %input.addr, align 8
  %arrayidx214 = getelementptr inbounds float addrspace(1)* %195, i64 %idxprom213
  %196 = load float addrspace(1)* %arrayidx214, align 4
  store float %196, float* %b, align 4
  %197 = load float* %r, align 4
  %198 = load float* %g, align 4
  %199 = load float* %b, align 4
  %call215 = call cc75 float @luminance(float %197, float %198, float %199)
  store float %call215, float* %down, align 4
  %200 = load i32* %width.addr, align 4
  %201 = load i32* %numChannels.addr, align 4
  %mul216 = mul i32 %200, %201
  %202 = load i32* %globalIdY, align 4
  %add217 = add i32 %202, 1
  %mul218 = mul i32 %mul216, %add217
  %203 = load i32* %globalIdX, align 4
  %add219 = add i32 %203, 1
  %204 = load i32* %numChannels.addr, align 4
  %mul220 = mul i32 %add219, %204
  %add221 = add i32 %mul218, %mul220
  %add222 = add i32 %add221, 0
  %idxprom223 = zext i32 %add222 to i64
  %205 = load float addrspace(1)** %input.addr, align 8
  %arrayidx224 = getelementptr inbounds float addrspace(1)* %205, i64 %idxprom223
  %206 = load float addrspace(1)* %arrayidx224, align 4
  store float %206, float* %r, align 4
  %207 = load i32* %width.addr, align 4
  %208 = load i32* %numChannels.addr, align 4
  %mul225 = mul i32 %207, %208
  %209 = load i32* %globalIdY, align 4
  %add226 = add i32 %209, 1
  %mul227 = mul i32 %mul225, %add226
  %210 = load i32* %globalIdX, align 4
  %add228 = add i32 %210, 1
  %211 = load i32* %numChannels.addr, align 4
  %mul229 = mul i32 %add228, %211
  %add230 = add i32 %mul227, %mul229
  %add231 = add i32 %add230, 1
  %idxprom232 = zext i32 %add231 to i64
  %212 = load float addrspace(1)** %input.addr, align 8
  %arrayidx233 = getelementptr inbounds float addrspace(1)* %212, i64 %idxprom232
  %213 = load float addrspace(1)* %arrayidx233, align 4
  store float %213, float* %g, align 4
  %214 = load i32* %width.addr, align 4
  %215 = load i32* %numChannels.addr, align 4
  %mul234 = mul i32 %214, %215
  %216 = load i32* %globalIdY, align 4
  %add235 = add i32 %216, 1
  %mul236 = mul i32 %mul234, %add235
  %217 = load i32* %globalIdX, align 4
  %add237 = add i32 %217, 1
  %218 = load i32* %numChannels.addr, align 4
  %mul238 = mul i32 %add237, %218
  %add239 = add i32 %mul236, %mul238
  %add240 = add i32 %add239, 2
  %idxprom241 = zext i32 %add240 to i64
  %219 = load float addrspace(1)** %input.addr, align 8
  %arrayidx242 = getelementptr inbounds float addrspace(1)* %219, i64 %idxprom241
  %220 = load float addrspace(1)* %arrayidx242, align 4
  store float %220, float* %b, align 4
  %221 = load float* %r, align 4
  %222 = load float* %g, align 4
  %223 = load float* %b, align 4
  %call243 = call cc75 float @luminance(float %221, float %222, float %223)
  store float %call243, float* %rightDown, align 4
  %224 = load float* %leftUp, align 4
  %225 = load float* %up, align 4
  %add244 = fadd float %224, %225
  %226 = load float* %rightUp, align 4
  %add245 = fadd float %add244, %226
  %227 = load float* %left, align 4
  %add246 = fadd float %add245, %227
  %228 = load float* %right, align 4
  %add247 = fadd float %add246, %228
  %229 = load float* %leftDown, align 4
  %add248 = fadd float %add247, %229
  %230 = load float* %down, align 4
  %add249 = fadd float %add248, %230
  %231 = load float* %rightDown, align 4
  %add250 = fadd float %add249, %231
  %div = fdiv float %add250, 8.000000e+00, !fpmath !10
  store float %div, float* %yLPattanaik, align 4
  br label %if.end

if.else:                                          ; preds = %land.lhs.true28, %land.lhs.true25, %land.lhs.true, %entry
  %232 = load float* %yLuminance, align 4
  store float %232, float* %yLPattanaik, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %233 = load float* %yLPattanaik, align 4
  %234 = load float* %delta.addr, align 4
  %235 = load float* %yLPattanaik, align 4
  %236 = load float* %yLuminance, align 4
  %div251 = fdiv float %235, %236, !fpmath !10
  %add252 = fadd float %234, %div251
  %call253 = call cc75 float @_Z3logf(float %add252) #1
  %237 = load float* %gcPattanaik, align 4
  %238 = call float @llvm.fmuladd.f32(float %233, float %call253, float %237)
  store float %238, float* %cLPattanaik, align 4
  %239 = load float* %yLuminance, align 4
  %240 = load float* %yLuminance, align 4
  %241 = load float* %cLPattanaik, align 4
  %add255 = fadd float %240, %241
  %div256 = fdiv float %239, %add255, !fpmath !10
  store float %div256, float* %yDPattanaik, align 4
  %242 = load float* %r1, align 4
  %243 = load float* %yLuminance, align 4
  %div257 = fdiv float %242, %243, !fpmath !10
  %244 = load float* %gamma.addr, align 4
  %call258 = call cc75 float @_Z3powff(float %div257, float %244) #1
  %245 = load float* %yDPattanaik, align 4
  %mul259 = fmul float %call258, %245
  store float %mul259, float* %r, align 4
  %246 = load float* %g1, align 4
  %247 = load float* %yLuminance, align 4
  %div260 = fdiv float %246, %247, !fpmath !10
  %248 = load float* %gamma.addr, align 4
  %call261 = call cc75 float @_Z3powff(float %div260, float %248) #1
  %249 = load float* %yDPattanaik, align 4
  %mul262 = fmul float %call261, %249
  store float %mul262, float* %g, align 4
  %250 = load float* %b1, align 4
  %251 = load float* %yLuminance, align 4
  %div263 = fdiv float %250, %251, !fpmath !10
  %252 = load float* %gamma.addr, align 4
  %call264 = call cc75 float @_Z3powff(float %div263, float %252) #1
  %253 = load float* %yDPattanaik, align 4
  %mul265 = fmul float %call264, %253
  store float %mul265, float* %b, align 4
  %254 = load float* %r, align 4
  %255 = load i32* %width.addr, align 4
  %256 = load i32* %numChannels.addr, align 4
  %mul266 = mul i32 %255, %256
  %257 = load i32* %globalIdY, align 4
  %mul267 = mul i32 %mul266, %257
  %258 = load i32* %globalIdX, align 4
  %259 = load i32* %numChannels.addr, align 4
  %mul268 = mul i32 %258, %259
  %add269 = add i32 %mul268, 0
  %add270 = add i32 %mul267, %add269
  %idxprom271 = zext i32 %add270 to i64
  %260 = load float addrspace(1)** %output.addr, align 8
  %arrayidx272 = getelementptr inbounds float addrspace(1)* %260, i64 %idxprom271
  store float %254, float addrspace(1)* %arrayidx272, align 4
  %261 = load float* %g, align 4
  %262 = load i32* %width.addr, align 4
  %263 = load i32* %numChannels.addr, align 4
  %mul273 = mul i32 %262, %263
  %264 = load i32* %globalIdY, align 4
  %mul274 = mul i32 %mul273, %264
  %265 = load i32* %globalIdX, align 4
  %266 = load i32* %numChannels.addr, align 4
  %mul275 = mul i32 %265, %266
  %add276 = add i32 %mul275, 1
  %add277 = add i32 %mul274, %add276
  %idxprom278 = zext i32 %add277 to i64
  %267 = load float addrspace(1)** %output.addr, align 8
  %arrayidx279 = getelementptr inbounds float addrspace(1)* %267, i64 %idxprom278
  store float %261, float addrspace(1)* %arrayidx279, align 4
  %268 = load float* %b, align 4
  %269 = load i32* %width.addr, align 4
  %270 = load i32* %numChannels.addr, align 4
  %mul280 = mul i32 %269, %270
  %271 = load i32* %globalIdY, align 4
  %mul281 = mul i32 %mul280, %271
  %272 = load i32* %globalIdX, align 4
  %273 = load i32* %numChannels.addr, align 4
  %mul282 = mul i32 %272, %273
  %add283 = add i32 %mul282, 2
  %add284 = add i32 %mul281, %add283
  %idxprom285 = zext i32 %add284 to i64
  %274 = load float addrspace(1)** %output.addr, align 8
  %arrayidx286 = getelementptr inbounds float addrspace(1)* %274, i64 %idxprom285
  store float %268, float addrspace(1)* %arrayidx286, align 4
  %275 = load i32* %width.addr, align 4
  %276 = load i32* %numChannels.addr, align 4
  %mul287 = mul i32 %275, %276
  %277 = load i32* %globalIdY, align 4
  %mul288 = mul i32 %mul287, %277
  %278 = load i32* %globalIdX, align 4
  %279 = load i32* %numChannels.addr, align 4
  %mul289 = mul i32 %278, %279
  %add290 = add i32 %mul289, 3
  %add291 = add i32 %mul288, %add290
  %idxprom292 = zext i32 %add291 to i64
  %280 = load float addrspace(1)** %input.addr, align 8
  %arrayidx293 = getelementptr inbounds float addrspace(1)* %280, i64 %idxprom292
  %281 = load float addrspace(1)* %arrayidx293, align 4
  %282 = load i32* %width.addr, align 4
  %283 = load i32* %numChannels.addr, align 4
  %mul294 = mul i32 %282, %283
  %284 = load i32* %globalIdY, align 4
  %mul295 = mul i32 %mul294, %284
  %285 = load i32* %globalIdX, align 4
  %286 = load i32* %numChannels.addr, align 4
  %mul296 = mul i32 %285, %286
  %add297 = add i32 %mul296, 3
  %add298 = add i32 %mul295, %add297
  %idxprom299 = zext i32 %add298 to i64
  %287 = load float addrspace(1)** %output.addr, align 8
  %arrayidx300 = getelementptr inbounds float addrspace(1)* %287, i64 %idxprom299
  store float %281, float addrspace(1)* %arrayidx300, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3logf(float) #1

; Function Attrs: nounwind readnone
declare cc75 float @_Z3powff(float, float) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_toneMappingPattanaik_kernel(<4 x float> addrspace(1)* %input, <4 x float> addrspace(1)* %output, float %averageLuminance, float %gamma, float %c, float %delta, i32 %width, i32 %numChannels, i32 %height) #0 {
entry:
  %input.addr = alloca <4 x float> addrspace(1)*, align 8
  %output.addr = alloca <4 x float> addrspace(1)*, align 8
  %averageLuminance.addr = alloca float, align 4
  %gamma.addr = alloca float, align 4
  %c.addr = alloca float, align 4
  %delta.addr = alloca float, align 4
  %width.addr = alloca i32, align 4
  %numChannels.addr = alloca i32, align 4
  %height.addr = alloca i32, align 4
  %globalIdX = alloca i32, align 4
  %globalIdY = alloca i32, align 4
  %r = alloca float, align 4
  %r1 = alloca float, align 4
  %g = alloca float, align 4
  %g1 = alloca float, align 4
  %b = alloca float, align 4
  %b1 = alloca float, align 4
  %yLuminance = alloca float, align 4
  %cLPattanaik = alloca float, align 4
  %yLPattanaik = alloca float, align 4
  %gcPattanaik = alloca float, align 4
  %leftUp = alloca float, align 4
  %up = alloca float, align 4
  %rightUp = alloca float, align 4
  %left = alloca float, align 4
  %right = alloca float, align 4
  %leftDown = alloca float, align 4
  %down = alloca float, align 4
  %rightDown = alloca float, align 4
  %yDPattanaik = alloca float, align 4
  store <4 x float> addrspace(1)* %input, <4 x float> addrspace(1)** %input.addr, align 8
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %output.addr, align 8
  store float %averageLuminance, float* %averageLuminance.addr, align 4
  store float %gamma, float* %gamma.addr, align 4
  store float %c, float* %c.addr, align 4
  store float %delta, float* %delta.addr, align 4
  store i32 %width, i32* %width.addr, align 4
  store i32 %numChannels, i32* %numChannels.addr, align 4
  store i32 %height, i32* %height.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %globalIdX, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %globalIdY, align 4
  store float 0.000000e+00, float* %yLuminance, align 4
  store float 0.000000e+00, float* %cLPattanaik, align 4
  store float 0.000000e+00, float* %yLPattanaik, align 4
  %0 = load i32* %width.addr, align 4
  %1 = load i32* %globalIdY, align 4
  %mul = mul i32 %0, %1
  %2 = load i32* %globalIdX, align 4
  %add = add i32 %mul, %2
  %idxprom = zext i32 %add to i64
  %3 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %3, i64 %idxprom
  %4 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %5 = extractelement <4 x float> %4, i32 0
  store float %5, float* %r1, align 4
  %6 = load i32* %width.addr, align 4
  %7 = load i32* %globalIdY, align 4
  %mul3 = mul i32 %6, %7
  %8 = load i32* %globalIdX, align 4
  %add4 = add i32 %mul3, %8
  %idxprom5 = zext i32 %add4 to i64
  %9 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx6 = getelementptr inbounds <4 x float> addrspace(1)* %9, i64 %idxprom5
  %10 = load <4 x float> addrspace(1)* %arrayidx6, align 16
  %11 = extractelement <4 x float> %10, i32 1
  store float %11, float* %g1, align 4
  %12 = load i32* %width.addr, align 4
  %13 = load i32* %globalIdY, align 4
  %mul7 = mul i32 %12, %13
  %14 = load i32* %globalIdX, align 4
  %add8 = add i32 %mul7, %14
  %idxprom9 = zext i32 %add8 to i64
  %15 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx10 = getelementptr inbounds <4 x float> addrspace(1)* %15, i64 %idxprom9
  %16 = load <4 x float> addrspace(1)* %arrayidx10, align 16
  %17 = extractelement <4 x float> %16, i32 2
  store float %17, float* %b1, align 4
  %18 = load float* %r1, align 4
  %19 = load float* %g1, align 4
  %20 = load float* %b1, align 4
  %call11 = call cc75 float @luminance(float %18, float %19, float %20)
  store float %call11, float* %yLuminance, align 4
  %21 = load float* %c.addr, align 4
  %22 = load float* %averageLuminance.addr, align 4
  %mul12 = fmul float %21, %22
  store float %mul12, float* %gcPattanaik, align 4
  %23 = load i32* %globalIdX, align 4
  %cmp = icmp ne i32 %23, 0
  br i1 %cmp, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %entry
  %24 = load i32* %globalIdY, align 4
  %cmp14 = icmp ne i32 %24, 0
  br i1 %cmp14, label %land.lhs.true16, label %if.else

land.lhs.true16:                                  ; preds = %land.lhs.true
  %25 = load i32* %globalIdX, align 4
  %26 = load i32* %width.addr, align 4
  %sub = sub i32 %26, 1
  %cmp17 = icmp ne i32 %25, %sub
  br i1 %cmp17, label %land.lhs.true19, label %if.else

land.lhs.true19:                                  ; preds = %land.lhs.true16
  %27 = load i32* %globalIdY, align 4
  %28 = load i32* %height.addr, align 4
  %sub20 = sub i32 %28, 1
  %cmp21 = icmp ne i32 %27, %sub20
  br i1 %cmp21, label %if.then, label %if.else

if.then:                                          ; preds = %land.lhs.true19
  store float 0.000000e+00, float* %leftUp, align 4
  store float 0.000000e+00, float* %up, align 4
  store float 0.000000e+00, float* %rightUp, align 4
  store float 0.000000e+00, float* %left, align 4
  store float 0.000000e+00, float* %right, align 4
  store float 0.000000e+00, float* %leftDown, align 4
  store float 0.000000e+00, float* %down, align 4
  store float 0.000000e+00, float* %rightDown, align 4
  %29 = load i32* %width.addr, align 4
  %30 = load i32* %globalIdY, align 4
  %sub23 = sub i32 %30, 1
  %mul24 = mul i32 %29, %sub23
  %31 = load i32* %globalIdX, align 4
  %add25 = add i32 %mul24, %31
  %sub26 = sub i32 %add25, 1
  %idxprom27 = zext i32 %sub26 to i64
  %32 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx28 = getelementptr inbounds <4 x float> addrspace(1)* %32, i64 %idxprom27
  %33 = load <4 x float> addrspace(1)* %arrayidx28, align 16
  %34 = extractelement <4 x float> %33, i32 0
  store float %34, float* %r, align 4
  %35 = load i32* %width.addr, align 4
  %36 = load i32* %globalIdY, align 4
  %sub29 = sub i32 %36, 1
  %mul30 = mul i32 %35, %sub29
  %37 = load i32* %globalIdX, align 4
  %add31 = add i32 %mul30, %37
  %sub32 = sub i32 %add31, 1
  %idxprom33 = zext i32 %sub32 to i64
  %38 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx34 = getelementptr inbounds <4 x float> addrspace(1)* %38, i64 %idxprom33
  %39 = load <4 x float> addrspace(1)* %arrayidx34, align 16
  %40 = extractelement <4 x float> %39, i32 1
  store float %40, float* %g, align 4
  %41 = load i32* %width.addr, align 4
  %42 = load i32* %globalIdY, align 4
  %sub35 = sub i32 %42, 1
  %mul36 = mul i32 %41, %sub35
  %43 = load i32* %globalIdX, align 4
  %add37 = add i32 %mul36, %43
  %sub38 = sub i32 %add37, 1
  %idxprom39 = zext i32 %sub38 to i64
  %44 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx40 = getelementptr inbounds <4 x float> addrspace(1)* %44, i64 %idxprom39
  %45 = load <4 x float> addrspace(1)* %arrayidx40, align 16
  %46 = extractelement <4 x float> %45, i32 2
  store float %46, float* %b, align 4
  %47 = load float* %r, align 4
  %48 = load float* %g, align 4
  %49 = load float* %b, align 4
  %call41 = call cc75 float @luminance(float %47, float %48, float %49)
  store float %call41, float* %leftUp, align 4
  %50 = load i32* %width.addr, align 4
  %51 = load i32* %globalIdY, align 4
  %sub42 = sub i32 %51, 1
  %mul43 = mul i32 %50, %sub42
  %52 = load i32* %globalIdX, align 4
  %add44 = add i32 %mul43, %52
  %idxprom45 = zext i32 %add44 to i64
  %53 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx46 = getelementptr inbounds <4 x float> addrspace(1)* %53, i64 %idxprom45
  %54 = load <4 x float> addrspace(1)* %arrayidx46, align 16
  %55 = extractelement <4 x float> %54, i32 0
  store float %55, float* %r, align 4
  %56 = load i32* %width.addr, align 4
  %57 = load i32* %globalIdY, align 4
  %sub47 = sub i32 %57, 1
  %mul48 = mul i32 %56, %sub47
  %58 = load i32* %globalIdX, align 4
  %add49 = add i32 %mul48, %58
  %idxprom50 = zext i32 %add49 to i64
  %59 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx51 = getelementptr inbounds <4 x float> addrspace(1)* %59, i64 %idxprom50
  %60 = load <4 x float> addrspace(1)* %arrayidx51, align 16
  %61 = extractelement <4 x float> %60, i32 1
  store float %61, float* %g, align 4
  %62 = load i32* %width.addr, align 4
  %63 = load i32* %globalIdY, align 4
  %sub52 = sub i32 %63, 1
  %mul53 = mul i32 %62, %sub52
  %64 = load i32* %globalIdX, align 4
  %add54 = add i32 %mul53, %64
  %idxprom55 = zext i32 %add54 to i64
  %65 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx56 = getelementptr inbounds <4 x float> addrspace(1)* %65, i64 %idxprom55
  %66 = load <4 x float> addrspace(1)* %arrayidx56, align 16
  %67 = extractelement <4 x float> %66, i32 2
  store float %67, float* %b, align 4
  %68 = load float* %r, align 4
  %69 = load float* %g, align 4
  %70 = load float* %b, align 4
  %call57 = call cc75 float @luminance(float %68, float %69, float %70)
  store float %call57, float* %up, align 4
  %71 = load i32* %width.addr, align 4
  %72 = load i32* %globalIdY, align 4
  %sub58 = sub i32 %72, 1
  %mul59 = mul i32 %71, %sub58
  %73 = load i32* %globalIdX, align 4
  %add60 = add i32 %mul59, %73
  %add61 = add i32 %add60, 1
  %idxprom62 = zext i32 %add61 to i64
  %74 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx63 = getelementptr inbounds <4 x float> addrspace(1)* %74, i64 %idxprom62
  %75 = load <4 x float> addrspace(1)* %arrayidx63, align 16
  %76 = extractelement <4 x float> %75, i32 0
  store float %76, float* %r, align 4
  %77 = load i32* %width.addr, align 4
  %78 = load i32* %globalIdY, align 4
  %sub64 = sub i32 %78, 1
  %mul65 = mul i32 %77, %sub64
  %79 = load i32* %globalIdX, align 4
  %add66 = add i32 %mul65, %79
  %add67 = add i32 %add66, 1
  %idxprom68 = zext i32 %add67 to i64
  %80 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx69 = getelementptr inbounds <4 x float> addrspace(1)* %80, i64 %idxprom68
  %81 = load <4 x float> addrspace(1)* %arrayidx69, align 16
  %82 = extractelement <4 x float> %81, i32 1
  store float %82, float* %g, align 4
  %83 = load i32* %width.addr, align 4
  %84 = load i32* %globalIdY, align 4
  %sub70 = sub i32 %84, 1
  %mul71 = mul i32 %83, %sub70
  %85 = load i32* %globalIdX, align 4
  %add72 = add i32 %mul71, %85
  %add73 = add i32 %add72, 1
  %idxprom74 = zext i32 %add73 to i64
  %86 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx75 = getelementptr inbounds <4 x float> addrspace(1)* %86, i64 %idxprom74
  %87 = load <4 x float> addrspace(1)* %arrayidx75, align 16
  %88 = extractelement <4 x float> %87, i32 2
  store float %88, float* %b, align 4
  %89 = load float* %r, align 4
  %90 = load float* %g, align 4
  %91 = load float* %b, align 4
  %call76 = call cc75 float @luminance(float %89, float %90, float %91)
  store float %call76, float* %rightUp, align 4
  %92 = load i32* %width.addr, align 4
  %93 = load i32* %globalIdY, align 4
  %mul77 = mul i32 %92, %93
  %94 = load i32* %globalIdX, align 4
  %add78 = add i32 %mul77, %94
  %sub79 = sub i32 %add78, 1
  %idxprom80 = zext i32 %sub79 to i64
  %95 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx81 = getelementptr inbounds <4 x float> addrspace(1)* %95, i64 %idxprom80
  %96 = load <4 x float> addrspace(1)* %arrayidx81, align 16
  %97 = extractelement <4 x float> %96, i32 0
  store float %97, float* %r, align 4
  %98 = load i32* %width.addr, align 4
  %99 = load i32* %globalIdY, align 4
  %mul82 = mul i32 %98, %99
  %100 = load i32* %globalIdX, align 4
  %add83 = add i32 %mul82, %100
  %sub84 = sub i32 %add83, 1
  %idxprom85 = zext i32 %sub84 to i64
  %101 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx86 = getelementptr inbounds <4 x float> addrspace(1)* %101, i64 %idxprom85
  %102 = load <4 x float> addrspace(1)* %arrayidx86, align 16
  %103 = extractelement <4 x float> %102, i32 1
  store float %103, float* %g, align 4
  %104 = load i32* %width.addr, align 4
  %105 = load i32* %globalIdY, align 4
  %mul87 = mul i32 %104, %105
  %106 = load i32* %globalIdX, align 4
  %add88 = add i32 %mul87, %106
  %sub89 = sub i32 %add88, 1
  %idxprom90 = zext i32 %sub89 to i64
  %107 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx91 = getelementptr inbounds <4 x float> addrspace(1)* %107, i64 %idxprom90
  %108 = load <4 x float> addrspace(1)* %arrayidx91, align 16
  %109 = extractelement <4 x float> %108, i32 2
  store float %109, float* %b, align 4
  %110 = load float* %r, align 4
  %111 = load float* %g, align 4
  %112 = load float* %b, align 4
  %call92 = call cc75 float @luminance(float %110, float %111, float %112)
  store float %call92, float* %left, align 4
  %113 = load i32* %width.addr, align 4
  %114 = load i32* %globalIdY, align 4
  %mul93 = mul i32 %113, %114
  %115 = load i32* %globalIdX, align 4
  %add94 = add i32 %mul93, %115
  %add95 = add i32 %add94, 1
  %idxprom96 = zext i32 %add95 to i64
  %116 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx97 = getelementptr inbounds <4 x float> addrspace(1)* %116, i64 %idxprom96
  %117 = load <4 x float> addrspace(1)* %arrayidx97, align 16
  %118 = extractelement <4 x float> %117, i32 0
  store float %118, float* %r, align 4
  %119 = load i32* %width.addr, align 4
  %120 = load i32* %globalIdY, align 4
  %mul98 = mul i32 %119, %120
  %121 = load i32* %globalIdX, align 4
  %add99 = add i32 %mul98, %121
  %add100 = add i32 %add99, 1
  %idxprom101 = zext i32 %add100 to i64
  %122 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx102 = getelementptr inbounds <4 x float> addrspace(1)* %122, i64 %idxprom101
  %123 = load <4 x float> addrspace(1)* %arrayidx102, align 16
  %124 = extractelement <4 x float> %123, i32 1
  store float %124, float* %g, align 4
  %125 = load i32* %width.addr, align 4
  %126 = load i32* %globalIdY, align 4
  %mul103 = mul i32 %125, %126
  %127 = load i32* %globalIdX, align 4
  %add104 = add i32 %mul103, %127
  %add105 = add i32 %add104, 1
  %idxprom106 = zext i32 %add105 to i64
  %128 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx107 = getelementptr inbounds <4 x float> addrspace(1)* %128, i64 %idxprom106
  %129 = load <4 x float> addrspace(1)* %arrayidx107, align 16
  %130 = extractelement <4 x float> %129, i32 2
  store float %130, float* %b, align 4
  %131 = load float* %r, align 4
  %132 = load float* %g, align 4
  %133 = load float* %b, align 4
  %call108 = call cc75 float @luminance(float %131, float %132, float %133)
  store float %call108, float* %right, align 4
  %134 = load i32* %width.addr, align 4
  %135 = load i32* %globalIdY, align 4
  %add109 = add i32 %135, 1
  %mul110 = mul i32 %134, %add109
  %136 = load i32* %globalIdX, align 4
  %add111 = add i32 %mul110, %136
  %sub112 = sub i32 %add111, 1
  %idxprom113 = zext i32 %sub112 to i64
  %137 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx114 = getelementptr inbounds <4 x float> addrspace(1)* %137, i64 %idxprom113
  %138 = load <4 x float> addrspace(1)* %arrayidx114, align 16
  %139 = extractelement <4 x float> %138, i32 0
  store float %139, float* %r, align 4
  %140 = load i32* %width.addr, align 4
  %141 = load i32* %globalIdY, align 4
  %add115 = add i32 %141, 1
  %mul116 = mul i32 %140, %add115
  %142 = load i32* %globalIdX, align 4
  %add117 = add i32 %mul116, %142
  %sub118 = sub i32 %add117, 1
  %idxprom119 = zext i32 %sub118 to i64
  %143 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx120 = getelementptr inbounds <4 x float> addrspace(1)* %143, i64 %idxprom119
  %144 = load <4 x float> addrspace(1)* %arrayidx120, align 16
  %145 = extractelement <4 x float> %144, i32 1
  store float %145, float* %g, align 4
  %146 = load i32* %width.addr, align 4
  %147 = load i32* %globalIdY, align 4
  %add121 = add i32 %147, 1
  %mul122 = mul i32 %146, %add121
  %148 = load i32* %globalIdX, align 4
  %add123 = add i32 %mul122, %148
  %sub124 = sub i32 %add123, 1
  %idxprom125 = zext i32 %sub124 to i64
  %149 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx126 = getelementptr inbounds <4 x float> addrspace(1)* %149, i64 %idxprom125
  %150 = load <4 x float> addrspace(1)* %arrayidx126, align 16
  %151 = extractelement <4 x float> %150, i32 2
  store float %151, float* %b, align 4
  %152 = load float* %r, align 4
  %153 = load float* %g, align 4
  %154 = load float* %b, align 4
  %call127 = call cc75 float @luminance(float %152, float %153, float %154)
  store float %call127, float* %leftDown, align 4
  %155 = load i32* %width.addr, align 4
  %156 = load i32* %globalIdY, align 4
  %add128 = add i32 %156, 1
  %mul129 = mul i32 %155, %add128
  %157 = load i32* %globalIdX, align 4
  %add130 = add i32 %mul129, %157
  %idxprom131 = zext i32 %add130 to i64
  %158 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx132 = getelementptr inbounds <4 x float> addrspace(1)* %158, i64 %idxprom131
  %159 = load <4 x float> addrspace(1)* %arrayidx132, align 16
  %160 = extractelement <4 x float> %159, i32 0
  store float %160, float* %r, align 4
  %161 = load i32* %width.addr, align 4
  %162 = load i32* %globalIdY, align 4
  %add133 = add i32 %162, 1
  %mul134 = mul i32 %161, %add133
  %163 = load i32* %globalIdX, align 4
  %add135 = add i32 %mul134, %163
  %idxprom136 = zext i32 %add135 to i64
  %164 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx137 = getelementptr inbounds <4 x float> addrspace(1)* %164, i64 %idxprom136
  %165 = load <4 x float> addrspace(1)* %arrayidx137, align 16
  %166 = extractelement <4 x float> %165, i32 1
  store float %166, float* %g, align 4
  %167 = load i32* %width.addr, align 4
  %168 = load i32* %globalIdY, align 4
  %add138 = add i32 %168, 1
  %mul139 = mul i32 %167, %add138
  %169 = load i32* %globalIdX, align 4
  %add140 = add i32 %mul139, %169
  %idxprom141 = zext i32 %add140 to i64
  %170 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx142 = getelementptr inbounds <4 x float> addrspace(1)* %170, i64 %idxprom141
  %171 = load <4 x float> addrspace(1)* %arrayidx142, align 16
  %172 = extractelement <4 x float> %171, i32 2
  store float %172, float* %b, align 4
  %173 = load float* %r, align 4
  %174 = load float* %g, align 4
  %175 = load float* %b, align 4
  %call143 = call cc75 float @luminance(float %173, float %174, float %175)
  store float %call143, float* %down, align 4
  %176 = load i32* %width.addr, align 4
  %177 = load i32* %globalIdY, align 4
  %add144 = add i32 %177, 1
  %mul145 = mul i32 %176, %add144
  %178 = load i32* %globalIdX, align 4
  %add146 = add i32 %mul145, %178
  %add147 = add i32 %add146, 1
  %idxprom148 = zext i32 %add147 to i64
  %179 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx149 = getelementptr inbounds <4 x float> addrspace(1)* %179, i64 %idxprom148
  %180 = load <4 x float> addrspace(1)* %arrayidx149, align 16
  %181 = extractelement <4 x float> %180, i32 0
  store float %181, float* %r, align 4
  %182 = load i32* %width.addr, align 4
  %183 = load i32* %globalIdY, align 4
  %add150 = add i32 %183, 1
  %mul151 = mul i32 %182, %add150
  %184 = load i32* %globalIdX, align 4
  %add152 = add i32 %mul151, %184
  %add153 = add i32 %add152, 1
  %idxprom154 = zext i32 %add153 to i64
  %185 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx155 = getelementptr inbounds <4 x float> addrspace(1)* %185, i64 %idxprom154
  %186 = load <4 x float> addrspace(1)* %arrayidx155, align 16
  %187 = extractelement <4 x float> %186, i32 1
  store float %187, float* %g, align 4
  %188 = load i32* %width.addr, align 4
  %189 = load i32* %globalIdY, align 4
  %add156 = add i32 %189, 1
  %mul157 = mul i32 %188, %add156
  %190 = load i32* %globalIdX, align 4
  %add158 = add i32 %mul157, %190
  %add159 = add i32 %add158, 1
  %idxprom160 = zext i32 %add159 to i64
  %191 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx161 = getelementptr inbounds <4 x float> addrspace(1)* %191, i64 %idxprom160
  %192 = load <4 x float> addrspace(1)* %arrayidx161, align 16
  %193 = extractelement <4 x float> %192, i32 2
  store float %193, float* %b, align 4
  %194 = load float* %r, align 4
  %195 = load float* %g, align 4
  %196 = load float* %b, align 4
  %call162 = call cc75 float @luminance(float %194, float %195, float %196)
  store float %call162, float* %rightDown, align 4
  %197 = load float* %leftUp, align 4
  %198 = load float* %up, align 4
  %add163 = fadd float %197, %198
  %199 = load float* %rightUp, align 4
  %add164 = fadd float %add163, %199
  %200 = load float* %left, align 4
  %add165 = fadd float %add164, %200
  %201 = load float* %right, align 4
  %add166 = fadd float %add165, %201
  %202 = load float* %leftDown, align 4
  %add167 = fadd float %add166, %202
  %203 = load float* %down, align 4
  %add168 = fadd float %add167, %203
  %204 = load float* %rightDown, align 4
  %add169 = fadd float %add168, %204
  %div = fdiv float %add169, 8.000000e+00, !fpmath !10
  store float %div, float* %yLPattanaik, align 4
  br label %if.end

if.else:                                          ; preds = %land.lhs.true19, %land.lhs.true16, %land.lhs.true, %entry
  %205 = load float* %yLuminance, align 4
  store float %205, float* %yLPattanaik, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %206 = load float* %yLPattanaik, align 4
  %207 = load float* %delta.addr, align 4
  %208 = load float* %yLPattanaik, align 4
  %209 = load float* %yLuminance, align 4
  %div170 = fdiv float %208, %209, !fpmath !10
  %add171 = fadd float %207, %div170
  %call172 = call cc75 float @_Z3logf(float %add171) #1
  %210 = load float* %gcPattanaik, align 4
  %211 = call float @llvm.fmuladd.f32(float %206, float %call172, float %210)
  store float %211, float* %cLPattanaik, align 4
  %212 = load float* %yLuminance, align 4
  %213 = load float* %yLuminance, align 4
  %214 = load float* %cLPattanaik, align 4
  %add174 = fadd float %213, %214
  %div175 = fdiv float %212, %add174, !fpmath !10
  store float %div175, float* %yDPattanaik, align 4
  %215 = load float* %r1, align 4
  %216 = load float* %yLuminance, align 4
  %div176 = fdiv float %215, %216, !fpmath !10
  %217 = load float* %gamma.addr, align 4
  %call177 = call cc75 float @_Z3powff(float %div176, float %217) #1
  %218 = load float* %yDPattanaik, align 4
  %mul178 = fmul float %call177, %218
  store float %mul178, float* %r, align 4
  %219 = load float* %g1, align 4
  %220 = load float* %yLuminance, align 4
  %div179 = fdiv float %219, %220, !fpmath !10
  %221 = load float* %gamma.addr, align 4
  %call180 = call cc75 float @_Z3powff(float %div179, float %221) #1
  %222 = load float* %yDPattanaik, align 4
  %mul181 = fmul float %call180, %222
  store float %mul181, float* %g, align 4
  %223 = load float* %b1, align 4
  %224 = load float* %yLuminance, align 4
  %div182 = fdiv float %223, %224, !fpmath !10
  %225 = load float* %gamma.addr, align 4
  %call183 = call cc75 float @_Z3powff(float %div182, float %225) #1
  %226 = load float* %yDPattanaik, align 4
  %mul184 = fmul float %call183, %226
  store float %mul184, float* %b, align 4
  %227 = load float* %r, align 4
  %228 = load i32* %width.addr, align 4
  %229 = load i32* %globalIdY, align 4
  %mul185 = mul i32 %228, %229
  %230 = load i32* %globalIdX, align 4
  %add186 = add i32 %mul185, %230
  %idxprom187 = zext i32 %add186 to i64
  %231 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx188 = getelementptr inbounds <4 x float> addrspace(1)* %231, i64 %idxprom187
  %232 = load <4 x float> addrspace(1)* %arrayidx188, align 16
  %233 = insertelement <4 x float> %232, float %227, i32 0
  store <4 x float> %233, <4 x float> addrspace(1)* %arrayidx188, align 16
  %234 = load float* %g, align 4
  %235 = load i32* %width.addr, align 4
  %236 = load i32* %globalIdY, align 4
  %mul189 = mul i32 %235, %236
  %237 = load i32* %globalIdX, align 4
  %add190 = add i32 %mul189, %237
  %idxprom191 = zext i32 %add190 to i64
  %238 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx192 = getelementptr inbounds <4 x float> addrspace(1)* %238, i64 %idxprom191
  %239 = load <4 x float> addrspace(1)* %arrayidx192, align 16
  %240 = insertelement <4 x float> %239, float %234, i32 1
  store <4 x float> %240, <4 x float> addrspace(1)* %arrayidx192, align 16
  %241 = load float* %b, align 4
  %242 = load i32* %width.addr, align 4
  %243 = load i32* %globalIdY, align 4
  %mul193 = mul i32 %242, %243
  %244 = load i32* %globalIdX, align 4
  %add194 = add i32 %mul193, %244
  %idxprom195 = zext i32 %add194 to i64
  %245 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx196 = getelementptr inbounds <4 x float> addrspace(1)* %245, i64 %idxprom195
  %246 = load <4 x float> addrspace(1)* %arrayidx196, align 16
  %247 = insertelement <4 x float> %246, float %241, i32 2
  store <4 x float> %247, <4 x float> addrspace(1)* %arrayidx196, align 16
  %248 = load i32* %width.addr, align 4
  %249 = load i32* %globalIdY, align 4
  %mul197 = mul i32 %248, %249
  %250 = load i32* %globalIdX, align 4
  %add198 = add i32 %mul197, %250
  %idxprom199 = zext i32 %add198 to i64
  %251 = load <4 x float> addrspace(1)** %input.addr, align 8
  %arrayidx200 = getelementptr inbounds <4 x float> addrspace(1)* %251, i64 %idxprom199
  %252 = load <4 x float> addrspace(1)* %arrayidx200, align 16
  %253 = extractelement <4 x float> %252, i32 3
  %254 = load i32* %width.addr, align 4
  %255 = load i32* %globalIdY, align 4
  %mul201 = mul i32 %254, %255
  %256 = load i32* %globalIdX, align 4
  %add202 = add i32 %mul201, %256
  %idxprom203 = zext i32 %add202 to i64
  %257 = load <4 x float> addrspace(1)** %output.addr, align 8
  %arrayidx204 = getelementptr inbounds <4 x float> addrspace(1)* %257, i64 %idxprom203
  %258 = load <4 x float> addrspace(1)* %arrayidx204, align 16
  %259 = insertelement <4 x float> %258, float %253, i32 3
  store <4 x float> %259, <4 x float> addrspace(1)* %arrayidx204, align 16
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!9}
!opencl.spir.version = !{!9}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float, float, float, float, i32, i32, i32)* @__OpenCL_toneMappingPattanaik1_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, float, float, float, float, i32, i32, i32)* @__OpenCL_toneMappingPattanaik_kernel, metadata !1, metadata !2, metadata !7, metadata !4, metadata !8}
!7 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"float4*", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"uint", metadata !"uint", metadata !"uint"}
!8 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"float4*", metadata !"float", metadata !"float", metadata !"float", metadata !"float", metadata !"uint", metadata !"uint", metadata !"uint"}
!9 = metadata !{i32 1, i32 2}
!10 = metadata !{float 2.500000e+00}

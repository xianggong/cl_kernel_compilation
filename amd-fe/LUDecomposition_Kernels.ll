; ModuleID = 'LUDecomposition_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_kernelLUDecompose_kernel(<4 x double> addrspace(1)* %LMatrix, <4 x double> addrspace(1)* %inplaceMatrix, i32 %d, double addrspace(3)* %ratio) #0 {
entry:
  %LMatrix.addr = alloca <4 x double> addrspace(1)*, align 8
  %inplaceMatrix.addr = alloca <4 x double> addrspace(1)*, align 8
  %d.addr = alloca i32, align 4
  %ratio.addr = alloca double addrspace(3)*, align 8
  %y = alloca i32, align 4
  %x = alloca i32, align 4
  %lidx = alloca i32, align 4
  %lidy = alloca i32, align 4
  %xdimension = alloca i32, align 4
  %D = alloca i32, align 4
  %result = alloca <4 x double>, align 32
  store <4 x double> addrspace(1)* %LMatrix, <4 x double> addrspace(1)** %LMatrix.addr, align 8
  store <4 x double> addrspace(1)* %inplaceMatrix, <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  store i32 %d, i32* %d.addr, align 4
  store double addrspace(3)* %ratio, double addrspace(3)** %ratio.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %y, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %x, align 4
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %lidx, align 4
  %call5 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %lidy, align 4
  %call7 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %0 = load i32* %d.addr, align 4
  %div = sdiv i32 %0, 4
  %conv8 = sext i32 %div to i64
  %add = add i64 %call7, %conv8
  %conv9 = trunc i64 %add to i32
  store i32 %conv9, i32* %xdimension, align 4
  %1 = load i32* %d.addr, align 4
  %rem = srem i32 %1, 4
  store i32 %rem, i32* %D, align 4
  %call10 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp = icmp eq i64 %call10, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load i32* %D, align 4
  %cmp12 = icmp eq i32 %2, 0
  br i1 %cmp12, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.then
  %3 = load i32* %y, align 4
  %4 = load i32* %xdimension, align 4
  %mul = mul nsw i32 %3, %4
  %5 = load i32* %d.addr, align 4
  %div14 = sdiv i32 %5, 4
  %add15 = add nsw i32 %mul, %div14
  %idxprom = sext i32 %add15 to i64
  %6 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx = getelementptr inbounds <4 x double> addrspace(1)* %6, i64 %idxprom
  %7 = load <4 x double> addrspace(1)* %arrayidx, align 32
  %8 = extractelement <4 x double> %7, i32 0
  %9 = load i32* %d.addr, align 4
  %10 = load i32* %xdimension, align 4
  %mul16 = mul nsw i32 %9, %10
  %11 = load i32* %d.addr, align 4
  %div17 = sdiv i32 %11, 4
  %add18 = add nsw i32 %mul16, %div17
  %idxprom19 = sext i32 %add18 to i64
  %12 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx20 = getelementptr inbounds <4 x double> addrspace(1)* %12, i64 %idxprom19
  %13 = load <4 x double> addrspace(1)* %arrayidx20, align 32
  %14 = extractelement <4 x double> %13, i32 0
  %div21 = fdiv double %8, %14
  %15 = load i32* %lidy, align 4
  %idxprom22 = sext i32 %15 to i64
  %16 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx23 = getelementptr inbounds double addrspace(3)* %16, i64 %idxprom22
  store double %div21, double addrspace(3)* %arrayidx23, align 8
  br label %cond.end

cond.false:                                       ; preds = %if.then
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi double [ %div21, %cond.true ], [ 1.000000e+00, %cond.false ]
  %17 = load i32* %D, align 4
  %cmp24 = icmp eq i32 %17, 1
  br i1 %cmp24, label %cond.true26, label %cond.false40

cond.true26:                                      ; preds = %cond.end
  %18 = load i32* %y, align 4
  %19 = load i32* %xdimension, align 4
  %mul27 = mul nsw i32 %18, %19
  %20 = load i32* %d.addr, align 4
  %div28 = sdiv i32 %20, 4
  %add29 = add nsw i32 %mul27, %div28
  %idxprom30 = sext i32 %add29 to i64
  %21 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx31 = getelementptr inbounds <4 x double> addrspace(1)* %21, i64 %idxprom30
  %22 = load <4 x double> addrspace(1)* %arrayidx31, align 32
  %23 = extractelement <4 x double> %22, i32 1
  %24 = load i32* %d.addr, align 4
  %25 = load i32* %xdimension, align 4
  %mul32 = mul nsw i32 %24, %25
  %26 = load i32* %d.addr, align 4
  %div33 = sdiv i32 %26, 4
  %add34 = add nsw i32 %mul32, %div33
  %idxprom35 = sext i32 %add34 to i64
  %27 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx36 = getelementptr inbounds <4 x double> addrspace(1)* %27, i64 %idxprom35
  %28 = load <4 x double> addrspace(1)* %arrayidx36, align 32
  %29 = extractelement <4 x double> %28, i32 1
  %div37 = fdiv double %23, %29
  %30 = load i32* %lidy, align 4
  %idxprom38 = sext i32 %30 to i64
  %31 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx39 = getelementptr inbounds double addrspace(3)* %31, i64 %idxprom38
  store double %div37, double addrspace(3)* %arrayidx39, align 8
  br label %cond.end41

cond.false40:                                     ; preds = %cond.end
  br label %cond.end41

cond.end41:                                       ; preds = %cond.false40, %cond.true26
  %cond42 = phi double [ %div37, %cond.true26 ], [ 1.000000e+00, %cond.false40 ]
  %32 = load i32* %D, align 4
  %cmp43 = icmp eq i32 %32, 2
  br i1 %cmp43, label %cond.true45, label %cond.false59

cond.true45:                                      ; preds = %cond.end41
  %33 = load i32* %y, align 4
  %34 = load i32* %xdimension, align 4
  %mul46 = mul nsw i32 %33, %34
  %35 = load i32* %d.addr, align 4
  %div47 = sdiv i32 %35, 4
  %add48 = add nsw i32 %mul46, %div47
  %idxprom49 = sext i32 %add48 to i64
  %36 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx50 = getelementptr inbounds <4 x double> addrspace(1)* %36, i64 %idxprom49
  %37 = load <4 x double> addrspace(1)* %arrayidx50, align 32
  %38 = extractelement <4 x double> %37, i32 2
  %39 = load i32* %d.addr, align 4
  %40 = load i32* %xdimension, align 4
  %mul51 = mul nsw i32 %39, %40
  %41 = load i32* %d.addr, align 4
  %div52 = sdiv i32 %41, 4
  %add53 = add nsw i32 %mul51, %div52
  %idxprom54 = sext i32 %add53 to i64
  %42 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx55 = getelementptr inbounds <4 x double> addrspace(1)* %42, i64 %idxprom54
  %43 = load <4 x double> addrspace(1)* %arrayidx55, align 32
  %44 = extractelement <4 x double> %43, i32 2
  %div56 = fdiv double %38, %44
  %45 = load i32* %lidy, align 4
  %idxprom57 = sext i32 %45 to i64
  %46 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx58 = getelementptr inbounds double addrspace(3)* %46, i64 %idxprom57
  store double %div56, double addrspace(3)* %arrayidx58, align 8
  br label %cond.end60

cond.false59:                                     ; preds = %cond.end41
  br label %cond.end60

cond.end60:                                       ; preds = %cond.false59, %cond.true45
  %cond61 = phi double [ %div56, %cond.true45 ], [ 1.000000e+00, %cond.false59 ]
  %47 = load i32* %D, align 4
  %cmp62 = icmp eq i32 %47, 3
  br i1 %cmp62, label %cond.true64, label %cond.false78

cond.true64:                                      ; preds = %cond.end60
  %48 = load i32* %y, align 4
  %49 = load i32* %xdimension, align 4
  %mul65 = mul nsw i32 %48, %49
  %50 = load i32* %d.addr, align 4
  %div66 = sdiv i32 %50, 4
  %add67 = add nsw i32 %mul65, %div66
  %idxprom68 = sext i32 %add67 to i64
  %51 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx69 = getelementptr inbounds <4 x double> addrspace(1)* %51, i64 %idxprom68
  %52 = load <4 x double> addrspace(1)* %arrayidx69, align 32
  %53 = extractelement <4 x double> %52, i32 3
  %54 = load i32* %d.addr, align 4
  %55 = load i32* %xdimension, align 4
  %mul70 = mul nsw i32 %54, %55
  %56 = load i32* %d.addr, align 4
  %div71 = sdiv i32 %56, 4
  %add72 = add nsw i32 %mul70, %div71
  %idxprom73 = sext i32 %add72 to i64
  %57 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx74 = getelementptr inbounds <4 x double> addrspace(1)* %57, i64 %idxprom73
  %58 = load <4 x double> addrspace(1)* %arrayidx74, align 32
  %59 = extractelement <4 x double> %58, i32 3
  %div75 = fdiv double %53, %59
  %60 = load i32* %lidy, align 4
  %idxprom76 = sext i32 %60 to i64
  %61 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx77 = getelementptr inbounds double addrspace(3)* %61, i64 %idxprom76
  store double %div75, double addrspace(3)* %arrayidx77, align 8
  br label %cond.end79

cond.false78:                                     ; preds = %cond.end60
  br label %cond.end79

cond.end79:                                       ; preds = %cond.false78, %cond.true64
  %cond80 = phi double [ %div75, %cond.true64 ], [ 1.000000e+00, %cond.false78 ]
  br label %if.end

if.end:                                           ; preds = %cond.end79, %entry
  call cc75 void @_Z7barrierj(i32 1)
  %62 = load i32* %y, align 4
  %63 = load i32* %d.addr, align 4
  %add81 = add nsw i32 %63, 1
  %cmp82 = icmp sge i32 %62, %add81
  br i1 %cmp82, label %land.lhs.true, label %if.end221

land.lhs.true:                                    ; preds = %if.end
  %64 = load i32* %x, align 4
  %add84 = add nsw i32 %64, 1
  %mul85 = mul nsw i32 %add84, 4
  %65 = load i32* %d.addr, align 4
  %cmp86 = icmp sgt i32 %mul85, %65
  br i1 %cmp86, label %if.then88, label %if.end221

if.then88:                                        ; preds = %land.lhs.true
  %66 = load i32* %y, align 4
  %67 = load i32* %xdimension, align 4
  %mul89 = mul nsw i32 %66, %67
  %68 = load i32* %x, align 4
  %add90 = add nsw i32 %mul89, %68
  %idxprom91 = sext i32 %add90 to i64
  %69 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx92 = getelementptr inbounds <4 x double> addrspace(1)* %69, i64 %idxprom91
  %70 = load <4 x double> addrspace(1)* %arrayidx92, align 32
  %71 = extractelement <4 x double> %70, i32 0
  %72 = load i32* %lidy, align 4
  %idxprom93 = sext i32 %72 to i64
  %73 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx94 = getelementptr inbounds double addrspace(3)* %73, i64 %idxprom93
  %74 = load double addrspace(3)* %arrayidx94, align 8
  %75 = load i32* %d.addr, align 4
  %76 = load i32* %xdimension, align 4
  %mul95 = mul nsw i32 %75, %76
  %77 = load i32* %x, align 4
  %add96 = add nsw i32 %mul95, %77
  %idxprom97 = sext i32 %add96 to i64
  %78 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx98 = getelementptr inbounds <4 x double> addrspace(1)* %78, i64 %idxprom97
  %79 = load <4 x double> addrspace(1)* %arrayidx98, align 32
  %80 = extractelement <4 x double> %79, i32 0
  %neg = fsub double -0.000000e+00, %74
  %81 = call double @llvm.fmuladd.f64(double %neg, double %80, double %71)
  %82 = load <4 x double>* %result, align 32
  %83 = insertelement <4 x double> %82, double %81, i32 0
  store <4 x double> %83, <4 x double>* %result, align 32
  %84 = load i32* %y, align 4
  %85 = load i32* %xdimension, align 4
  %mul100 = mul nsw i32 %84, %85
  %86 = load i32* %x, align 4
  %add101 = add nsw i32 %mul100, %86
  %idxprom102 = sext i32 %add101 to i64
  %87 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx103 = getelementptr inbounds <4 x double> addrspace(1)* %87, i64 %idxprom102
  %88 = load <4 x double> addrspace(1)* %arrayidx103, align 32
  %89 = extractelement <4 x double> %88, i32 1
  %90 = load i32* %lidy, align 4
  %idxprom104 = sext i32 %90 to i64
  %91 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx105 = getelementptr inbounds double addrspace(3)* %91, i64 %idxprom104
  %92 = load double addrspace(3)* %arrayidx105, align 8
  %93 = load i32* %d.addr, align 4
  %94 = load i32* %xdimension, align 4
  %mul106 = mul nsw i32 %93, %94
  %95 = load i32* %x, align 4
  %add107 = add nsw i32 %mul106, %95
  %idxprom108 = sext i32 %add107 to i64
  %96 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx109 = getelementptr inbounds <4 x double> addrspace(1)* %96, i64 %idxprom108
  %97 = load <4 x double> addrspace(1)* %arrayidx109, align 32
  %98 = extractelement <4 x double> %97, i32 1
  %neg111 = fsub double -0.000000e+00, %92
  %99 = call double @llvm.fmuladd.f64(double %neg111, double %98, double %89)
  %100 = load <4 x double>* %result, align 32
  %101 = insertelement <4 x double> %100, double %99, i32 1
  store <4 x double> %101, <4 x double>* %result, align 32
  %102 = load i32* %y, align 4
  %103 = load i32* %xdimension, align 4
  %mul112 = mul nsw i32 %102, %103
  %104 = load i32* %x, align 4
  %add113 = add nsw i32 %mul112, %104
  %idxprom114 = sext i32 %add113 to i64
  %105 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx115 = getelementptr inbounds <4 x double> addrspace(1)* %105, i64 %idxprom114
  %106 = load <4 x double> addrspace(1)* %arrayidx115, align 32
  %107 = extractelement <4 x double> %106, i32 2
  %108 = load i32* %lidy, align 4
  %idxprom116 = sext i32 %108 to i64
  %109 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx117 = getelementptr inbounds double addrspace(3)* %109, i64 %idxprom116
  %110 = load double addrspace(3)* %arrayidx117, align 8
  %111 = load i32* %d.addr, align 4
  %112 = load i32* %xdimension, align 4
  %mul118 = mul nsw i32 %111, %112
  %113 = load i32* %x, align 4
  %add119 = add nsw i32 %mul118, %113
  %idxprom120 = sext i32 %add119 to i64
  %114 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx121 = getelementptr inbounds <4 x double> addrspace(1)* %114, i64 %idxprom120
  %115 = load <4 x double> addrspace(1)* %arrayidx121, align 32
  %116 = extractelement <4 x double> %115, i32 2
  %neg123 = fsub double -0.000000e+00, %110
  %117 = call double @llvm.fmuladd.f64(double %neg123, double %116, double %107)
  %118 = load <4 x double>* %result, align 32
  %119 = insertelement <4 x double> %118, double %117, i32 2
  store <4 x double> %119, <4 x double>* %result, align 32
  %120 = load i32* %y, align 4
  %121 = load i32* %xdimension, align 4
  %mul124 = mul nsw i32 %120, %121
  %122 = load i32* %x, align 4
  %add125 = add nsw i32 %mul124, %122
  %idxprom126 = sext i32 %add125 to i64
  %123 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx127 = getelementptr inbounds <4 x double> addrspace(1)* %123, i64 %idxprom126
  %124 = load <4 x double> addrspace(1)* %arrayidx127, align 32
  %125 = extractelement <4 x double> %124, i32 3
  %126 = load i32* %lidy, align 4
  %idxprom128 = sext i32 %126 to i64
  %127 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx129 = getelementptr inbounds double addrspace(3)* %127, i64 %idxprom128
  %128 = load double addrspace(3)* %arrayidx129, align 8
  %129 = load i32* %d.addr, align 4
  %130 = load i32* %xdimension, align 4
  %mul130 = mul nsw i32 %129, %130
  %131 = load i32* %x, align 4
  %add131 = add nsw i32 %mul130, %131
  %idxprom132 = sext i32 %add131 to i64
  %132 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx133 = getelementptr inbounds <4 x double> addrspace(1)* %132, i64 %idxprom132
  %133 = load <4 x double> addrspace(1)* %arrayidx133, align 32
  %134 = extractelement <4 x double> %133, i32 3
  %neg135 = fsub double -0.000000e+00, %128
  %135 = call double @llvm.fmuladd.f64(double %neg135, double %134, double %125)
  %136 = load <4 x double>* %result, align 32
  %137 = insertelement <4 x double> %136, double %135, i32 3
  store <4 x double> %137, <4 x double>* %result, align 32
  %138 = load i32* %x, align 4
  %139 = load i32* %d.addr, align 4
  %div136 = sdiv i32 %139, 4
  %cmp137 = icmp eq i32 %138, %div136
  br i1 %cmp137, label %if.then139, label %if.else

if.then139:                                       ; preds = %if.then88
  %140 = load i32* %D, align 4
  %cmp140 = icmp eq i32 %140, 0
  br i1 %cmp140, label %cond.true142, label %cond.false149

cond.true142:                                     ; preds = %if.then139
  %141 = load i32* %lidy, align 4
  %idxprom143 = sext i32 %141 to i64
  %142 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx144 = getelementptr inbounds double addrspace(3)* %142, i64 %idxprom143
  %143 = load double addrspace(3)* %arrayidx144, align 8
  %144 = load i32* %y, align 4
  %145 = load i32* %xdimension, align 4
  %mul145 = mul nsw i32 %144, %145
  %146 = load i32* %x, align 4
  %add146 = add nsw i32 %mul145, %146
  %idxprom147 = sext i32 %add146 to i64
  %147 = load <4 x double> addrspace(1)** %LMatrix.addr, align 8
  %arrayidx148 = getelementptr inbounds <4 x double> addrspace(1)* %147, i64 %idxprom147
  %148 = load <4 x double> addrspace(1)* %arrayidx148, align 32
  %149 = insertelement <4 x double> %148, double %143, i32 0
  store <4 x double> %149, <4 x double> addrspace(1)* %arrayidx148, align 32
  br label %cond.end154

cond.false149:                                    ; preds = %if.then139
  %150 = load <4 x double>* %result, align 32
  %151 = extractelement <4 x double> %150, i32 0
  %152 = load i32* %y, align 4
  %153 = load i32* %xdimension, align 4
  %mul150 = mul nsw i32 %152, %153
  %154 = load i32* %x, align 4
  %add151 = add nsw i32 %mul150, %154
  %idxprom152 = sext i32 %add151 to i64
  %155 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx153 = getelementptr inbounds <4 x double> addrspace(1)* %155, i64 %idxprom152
  %156 = load <4 x double> addrspace(1)* %arrayidx153, align 32
  %157 = insertelement <4 x double> %156, double %151, i32 0
  store <4 x double> %157, <4 x double> addrspace(1)* %arrayidx153, align 32
  br label %cond.end154

cond.end154:                                      ; preds = %cond.false149, %cond.true142
  %cond155 = phi double [ %143, %cond.true142 ], [ %151, %cond.false149 ]
  %158 = load i32* %D, align 4
  %cmp156 = icmp eq i32 %158, 1
  br i1 %cmp156, label %cond.true158, label %cond.false165

cond.true158:                                     ; preds = %cond.end154
  %159 = load i32* %lidy, align 4
  %idxprom159 = sext i32 %159 to i64
  %160 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx160 = getelementptr inbounds double addrspace(3)* %160, i64 %idxprom159
  %161 = load double addrspace(3)* %arrayidx160, align 8
  %162 = load i32* %y, align 4
  %163 = load i32* %xdimension, align 4
  %mul161 = mul nsw i32 %162, %163
  %164 = load i32* %x, align 4
  %add162 = add nsw i32 %mul161, %164
  %idxprom163 = sext i32 %add162 to i64
  %165 = load <4 x double> addrspace(1)** %LMatrix.addr, align 8
  %arrayidx164 = getelementptr inbounds <4 x double> addrspace(1)* %165, i64 %idxprom163
  %166 = load <4 x double> addrspace(1)* %arrayidx164, align 32
  %167 = insertelement <4 x double> %166, double %161, i32 1
  store <4 x double> %167, <4 x double> addrspace(1)* %arrayidx164, align 32
  br label %cond.end170

cond.false165:                                    ; preds = %cond.end154
  %168 = load <4 x double>* %result, align 32
  %169 = extractelement <4 x double> %168, i32 1
  %170 = load i32* %y, align 4
  %171 = load i32* %xdimension, align 4
  %mul166 = mul nsw i32 %170, %171
  %172 = load i32* %x, align 4
  %add167 = add nsw i32 %mul166, %172
  %idxprom168 = sext i32 %add167 to i64
  %173 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx169 = getelementptr inbounds <4 x double> addrspace(1)* %173, i64 %idxprom168
  %174 = load <4 x double> addrspace(1)* %arrayidx169, align 32
  %175 = insertelement <4 x double> %174, double %169, i32 1
  store <4 x double> %175, <4 x double> addrspace(1)* %arrayidx169, align 32
  br label %cond.end170

cond.end170:                                      ; preds = %cond.false165, %cond.true158
  %cond171 = phi double [ %161, %cond.true158 ], [ %169, %cond.false165 ]
  %176 = load i32* %D, align 4
  %cmp172 = icmp eq i32 %176, 2
  br i1 %cmp172, label %cond.true174, label %cond.false181

cond.true174:                                     ; preds = %cond.end170
  %177 = load i32* %lidy, align 4
  %idxprom175 = sext i32 %177 to i64
  %178 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx176 = getelementptr inbounds double addrspace(3)* %178, i64 %idxprom175
  %179 = load double addrspace(3)* %arrayidx176, align 8
  %180 = load i32* %y, align 4
  %181 = load i32* %xdimension, align 4
  %mul177 = mul nsw i32 %180, %181
  %182 = load i32* %x, align 4
  %add178 = add nsw i32 %mul177, %182
  %idxprom179 = sext i32 %add178 to i64
  %183 = load <4 x double> addrspace(1)** %LMatrix.addr, align 8
  %arrayidx180 = getelementptr inbounds <4 x double> addrspace(1)* %183, i64 %idxprom179
  %184 = load <4 x double> addrspace(1)* %arrayidx180, align 32
  %185 = insertelement <4 x double> %184, double %179, i32 2
  store <4 x double> %185, <4 x double> addrspace(1)* %arrayidx180, align 32
  br label %cond.end186

cond.false181:                                    ; preds = %cond.end170
  %186 = load <4 x double>* %result, align 32
  %187 = extractelement <4 x double> %186, i32 2
  %188 = load i32* %y, align 4
  %189 = load i32* %xdimension, align 4
  %mul182 = mul nsw i32 %188, %189
  %190 = load i32* %x, align 4
  %add183 = add nsw i32 %mul182, %190
  %idxprom184 = sext i32 %add183 to i64
  %191 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx185 = getelementptr inbounds <4 x double> addrspace(1)* %191, i64 %idxprom184
  %192 = load <4 x double> addrspace(1)* %arrayidx185, align 32
  %193 = insertelement <4 x double> %192, double %187, i32 2
  store <4 x double> %193, <4 x double> addrspace(1)* %arrayidx185, align 32
  br label %cond.end186

cond.end186:                                      ; preds = %cond.false181, %cond.true174
  %cond187 = phi double [ %179, %cond.true174 ], [ %187, %cond.false181 ]
  %194 = load i32* %D, align 4
  %cmp188 = icmp eq i32 %194, 3
  br i1 %cmp188, label %cond.true190, label %cond.false197

cond.true190:                                     ; preds = %cond.end186
  %195 = load i32* %lidy, align 4
  %idxprom191 = sext i32 %195 to i64
  %196 = load double addrspace(3)** %ratio.addr, align 8
  %arrayidx192 = getelementptr inbounds double addrspace(3)* %196, i64 %idxprom191
  %197 = load double addrspace(3)* %arrayidx192, align 8
  %198 = load i32* %y, align 4
  %199 = load i32* %xdimension, align 4
  %mul193 = mul nsw i32 %198, %199
  %200 = load i32* %x, align 4
  %add194 = add nsw i32 %mul193, %200
  %idxprom195 = sext i32 %add194 to i64
  %201 = load <4 x double> addrspace(1)** %LMatrix.addr, align 8
  %arrayidx196 = getelementptr inbounds <4 x double> addrspace(1)* %201, i64 %idxprom195
  %202 = load <4 x double> addrspace(1)* %arrayidx196, align 32
  %203 = insertelement <4 x double> %202, double %197, i32 3
  store <4 x double> %203, <4 x double> addrspace(1)* %arrayidx196, align 32
  br label %cond.end202

cond.false197:                                    ; preds = %cond.end186
  %204 = load <4 x double>* %result, align 32
  %205 = extractelement <4 x double> %204, i32 3
  %206 = load i32* %y, align 4
  %207 = load i32* %xdimension, align 4
  %mul198 = mul nsw i32 %206, %207
  %208 = load i32* %x, align 4
  %add199 = add nsw i32 %mul198, %208
  %idxprom200 = sext i32 %add199 to i64
  %209 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx201 = getelementptr inbounds <4 x double> addrspace(1)* %209, i64 %idxprom200
  %210 = load <4 x double> addrspace(1)* %arrayidx201, align 32
  %211 = insertelement <4 x double> %210, double %205, i32 3
  store <4 x double> %211, <4 x double> addrspace(1)* %arrayidx201, align 32
  br label %cond.end202

cond.end202:                                      ; preds = %cond.false197, %cond.true190
  %cond203 = phi double [ %197, %cond.true190 ], [ %205, %cond.false197 ]
  br label %if.end220

if.else:                                          ; preds = %if.then88
  %212 = load <4 x double>* %result, align 32
  %213 = extractelement <4 x double> %212, i32 0
  %214 = load i32* %y, align 4
  %215 = load i32* %xdimension, align 4
  %mul204 = mul nsw i32 %214, %215
  %216 = load i32* %x, align 4
  %add205 = add nsw i32 %mul204, %216
  %idxprom206 = sext i32 %add205 to i64
  %217 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx207 = getelementptr inbounds <4 x double> addrspace(1)* %217, i64 %idxprom206
  %218 = load <4 x double> addrspace(1)* %arrayidx207, align 32
  %219 = insertelement <4 x double> %218, double %213, i32 0
  store <4 x double> %219, <4 x double> addrspace(1)* %arrayidx207, align 32
  %220 = load <4 x double>* %result, align 32
  %221 = extractelement <4 x double> %220, i32 1
  %222 = load i32* %y, align 4
  %223 = load i32* %xdimension, align 4
  %mul208 = mul nsw i32 %222, %223
  %224 = load i32* %x, align 4
  %add209 = add nsw i32 %mul208, %224
  %idxprom210 = sext i32 %add209 to i64
  %225 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx211 = getelementptr inbounds <4 x double> addrspace(1)* %225, i64 %idxprom210
  %226 = load <4 x double> addrspace(1)* %arrayidx211, align 32
  %227 = insertelement <4 x double> %226, double %221, i32 1
  store <4 x double> %227, <4 x double> addrspace(1)* %arrayidx211, align 32
  %228 = load <4 x double>* %result, align 32
  %229 = extractelement <4 x double> %228, i32 2
  %230 = load i32* %y, align 4
  %231 = load i32* %xdimension, align 4
  %mul212 = mul nsw i32 %230, %231
  %232 = load i32* %x, align 4
  %add213 = add nsw i32 %mul212, %232
  %idxprom214 = sext i32 %add213 to i64
  %233 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx215 = getelementptr inbounds <4 x double> addrspace(1)* %233, i64 %idxprom214
  %234 = load <4 x double> addrspace(1)* %arrayidx215, align 32
  %235 = insertelement <4 x double> %234, double %229, i32 2
  store <4 x double> %235, <4 x double> addrspace(1)* %arrayidx215, align 32
  %236 = load <4 x double>* %result, align 32
  %237 = extractelement <4 x double> %236, i32 3
  %238 = load i32* %y, align 4
  %239 = load i32* %xdimension, align 4
  %mul216 = mul nsw i32 %238, %239
  %240 = load i32* %x, align 4
  %add217 = add nsw i32 %mul216, %240
  %idxprom218 = sext i32 %add217 to i64
  %241 = load <4 x double> addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx219 = getelementptr inbounds <4 x double> addrspace(1)* %241, i64 %idxprom218
  %242 = load <4 x double> addrspace(1)* %arrayidx219, align 32
  %243 = insertelement <4 x double> %242, double %237, i32 3
  store <4 x double> %243, <4 x double> addrspace(1)* %arrayidx219, align 32
  br label %if.end220

if.end220:                                        ; preds = %if.else, %cond.end202
  br label %if.end221

if.end221:                                        ; preds = %if.end220, %land.lhs.true, %if.end
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

declare cc75 void @_Z7barrierj(i32)

; Function Attrs: nounwind readnone
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_kernelLUCombine_kernel(double addrspace(1)* %LMatrix, double addrspace(1)* %inplaceMatrix) #0 {
entry:
  %LMatrix.addr = alloca double addrspace(1)*, align 8
  %inplaceMatrix.addr = alloca double addrspace(1)*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %gidx = alloca i32, align 4
  %gidy = alloca i32, align 4
  %dimension = alloca i32, align 4
  %dimension10 = alloca i32, align 4
  store double addrspace(1)* %LMatrix, double addrspace(1)** %LMatrix.addr, align 8
  store double addrspace(1)* %inplaceMatrix, double addrspace(1)** %inplaceMatrix.addr, align 8
  %call = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %i, align 4
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, i32* %j, align 4
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  store i32 %conv4, i32* %gidx, align 4
  %call5 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  store i32 %conv6, i32* %gidy, align 4
  %call7 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv8 = trunc i64 %call7 to i32
  store i32 %conv8, i32* %dimension, align 4
  %0 = load i32* %i, align 4
  %1 = load i32* %j, align 4
  %cmp = icmp sgt i32 %0, %1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call11 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv12 = trunc i64 %call11 to i32
  store i32 %conv12, i32* %dimension10, align 4
  %2 = load i32* %i, align 4
  %3 = load i32* %dimension10, align 4
  %mul = mul nsw i32 %2, %3
  %4 = load i32* %j, align 4
  %add = add nsw i32 %mul, %4
  %idxprom = sext i32 %add to i64
  %5 = load double addrspace(1)** %LMatrix.addr, align 8
  %arrayidx = getelementptr inbounds double addrspace(1)* %5, i64 %idxprom
  %6 = load double addrspace(1)* %arrayidx, align 8
  %7 = load i32* %i, align 4
  %8 = load i32* %dimension10, align 4
  %mul13 = mul nsw i32 %7, %8
  %9 = load i32* %j, align 4
  %add14 = add nsw i32 %mul13, %9
  %idxprom15 = sext i32 %add14 to i64
  %10 = load double addrspace(1)** %inplaceMatrix.addr, align 8
  %arrayidx16 = getelementptr inbounds double addrspace(1)* %10, i64 %idxprom15
  store double %6, double addrspace(1)* %arrayidx16, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!12}
!opencl.spir.version = !{!12}

!0 = metadata !{void (<4 x double> addrspace(1)*, <4 x double> addrspace(1)*, i32, double addrspace(3)*)* @__OpenCL_kernelLUDecompose_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 3}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"double4*", metadata !"double4*", metadata !"int", metadata !"double*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"double4*", metadata !"double4*", metadata !"int", metadata !"double*"}
!6 = metadata !{void (double addrspace(1)*, double addrspace(1)*)* @__OpenCL_kernelLUCombine_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"double*", metadata !"double*"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !""}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"double*", metadata !"double*"}
!12 = metadata !{i32 1, i32 2}

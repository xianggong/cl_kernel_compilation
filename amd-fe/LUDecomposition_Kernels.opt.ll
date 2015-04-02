; ModuleID = 'LUDecomposition_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_kernelLUDecompose_kernel(<4 x double> addrspace(1)* %LMatrix, <4 x double> addrspace(1)* %inplaceMatrix, i32 %d, double addrspace(3)* %ratio) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %call7 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %div = sdiv i32 %d, 4
  %conv8 = sext i32 %div to i64
  %add = add i64 %call7, %conv8
  %conv9 = trunc i64 %add to i32
  %rem = srem i32 %d, 4
  %call10 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %cmp = icmp eq i64 %call10, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %cmp12 = icmp eq i32 %rem, 0
  br i1 %cmp12, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.then
  %mul = mul nsw i32 %conv, %conv9
  %div14 = sdiv i32 %d, 4
  %add15 = add nsw i32 %mul, %div14
  %idxprom = sext i32 %add15 to i64
  %arrayidx = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom
  %0 = load <4 x double> addrspace(1)* %arrayidx, align 32
  %1 = extractelement <4 x double> %0, i32 0
  %mul16 = mul nsw i32 %d, %conv9
  %div17 = sdiv i32 %d, 4
  %add18 = add nsw i32 %mul16, %div17
  %idxprom19 = sext i32 %add18 to i64
  %arrayidx20 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom19
  %2 = load <4 x double> addrspace(1)* %arrayidx20, align 32
  %3 = extractelement <4 x double> %2, i32 0
  %div21 = fdiv double %1, %3
  %idxprom22 = sext i32 %conv6 to i64
  %arrayidx23 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom22
  store double %div21, double addrspace(3)* %arrayidx23, align 8
  br label %cond.end

cond.false:                                       ; preds = %if.then
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi double [ %div21, %cond.true ], [ 1.000000e+00, %cond.false ]
  %cmp24 = icmp eq i32 %rem, 1
  br i1 %cmp24, label %cond.true26, label %cond.false40

cond.true26:                                      ; preds = %cond.end
  %mul27 = mul nsw i32 %conv, %conv9
  %div28 = sdiv i32 %d, 4
  %add29 = add nsw i32 %mul27, %div28
  %idxprom30 = sext i32 %add29 to i64
  %arrayidx31 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom30
  %4 = load <4 x double> addrspace(1)* %arrayidx31, align 32
  %5 = extractelement <4 x double> %4, i32 1
  %mul32 = mul nsw i32 %d, %conv9
  %div33 = sdiv i32 %d, 4
  %add34 = add nsw i32 %mul32, %div33
  %idxprom35 = sext i32 %add34 to i64
  %arrayidx36 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom35
  %6 = load <4 x double> addrspace(1)* %arrayidx36, align 32
  %7 = extractelement <4 x double> %6, i32 1
  %div37 = fdiv double %5, %7
  %idxprom38 = sext i32 %conv6 to i64
  %arrayidx39 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom38
  store double %div37, double addrspace(3)* %arrayidx39, align 8
  br label %cond.end41

cond.false40:                                     ; preds = %cond.end
  br label %cond.end41

cond.end41:                                       ; preds = %cond.false40, %cond.true26
  %cond42 = phi double [ %div37, %cond.true26 ], [ 1.000000e+00, %cond.false40 ]
  %cmp43 = icmp eq i32 %rem, 2
  br i1 %cmp43, label %cond.true45, label %cond.false59

cond.true45:                                      ; preds = %cond.end41
  %mul46 = mul nsw i32 %conv, %conv9
  %div47 = sdiv i32 %d, 4
  %add48 = add nsw i32 %mul46, %div47
  %idxprom49 = sext i32 %add48 to i64
  %arrayidx50 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom49
  %8 = load <4 x double> addrspace(1)* %arrayidx50, align 32
  %9 = extractelement <4 x double> %8, i32 2
  %mul51 = mul nsw i32 %d, %conv9
  %div52 = sdiv i32 %d, 4
  %add53 = add nsw i32 %mul51, %div52
  %idxprom54 = sext i32 %add53 to i64
  %arrayidx55 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom54
  %10 = load <4 x double> addrspace(1)* %arrayidx55, align 32
  %11 = extractelement <4 x double> %10, i32 2
  %div56 = fdiv double %9, %11
  %idxprom57 = sext i32 %conv6 to i64
  %arrayidx58 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom57
  store double %div56, double addrspace(3)* %arrayidx58, align 8
  br label %cond.end60

cond.false59:                                     ; preds = %cond.end41
  br label %cond.end60

cond.end60:                                       ; preds = %cond.false59, %cond.true45
  %cond61 = phi double [ %div56, %cond.true45 ], [ 1.000000e+00, %cond.false59 ]
  %cmp62 = icmp eq i32 %rem, 3
  br i1 %cmp62, label %cond.true64, label %cond.false78

cond.true64:                                      ; preds = %cond.end60
  %mul65 = mul nsw i32 %conv, %conv9
  %div66 = sdiv i32 %d, 4
  %add67 = add nsw i32 %mul65, %div66
  %idxprom68 = sext i32 %add67 to i64
  %arrayidx69 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom68
  %12 = load <4 x double> addrspace(1)* %arrayidx69, align 32
  %13 = extractelement <4 x double> %12, i32 3
  %mul70 = mul nsw i32 %d, %conv9
  %div71 = sdiv i32 %d, 4
  %add72 = add nsw i32 %mul70, %div71
  %idxprom73 = sext i32 %add72 to i64
  %arrayidx74 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom73
  %14 = load <4 x double> addrspace(1)* %arrayidx74, align 32
  %15 = extractelement <4 x double> %14, i32 3
  %div75 = fdiv double %13, %15
  %idxprom76 = sext i32 %conv6 to i64
  %arrayidx77 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom76
  store double %div75, double addrspace(3)* %arrayidx77, align 8
  br label %cond.end79

cond.false78:                                     ; preds = %cond.end60
  br label %cond.end79

cond.end79:                                       ; preds = %cond.false78, %cond.true64
  %cond80 = phi double [ %div75, %cond.true64 ], [ 1.000000e+00, %cond.false78 ]
  br label %if.end

if.end:                                           ; preds = %cond.end79, %entry
  call cc75 void @_Z7barrierj(i32 1)
  %add81 = add nsw i32 %d, 1
  %cmp82 = icmp sge i32 %conv, %add81
  br i1 %cmp82, label %land.lhs.true, label %if.end221

land.lhs.true:                                    ; preds = %if.end
  %add84 = add nsw i32 %conv2, 1
  %mul85 = mul nsw i32 %add84, 4
  %cmp86 = icmp sgt i32 %mul85, %d
  br i1 %cmp86, label %if.then88, label %if.end221

if.then88:                                        ; preds = %land.lhs.true
  %mul89 = mul nsw i32 %conv, %conv9
  %add90 = add nsw i32 %mul89, %conv2
  %idxprom91 = sext i32 %add90 to i64
  %arrayidx92 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom91
  %16 = load <4 x double> addrspace(1)* %arrayidx92, align 32
  %17 = extractelement <4 x double> %16, i32 0
  %idxprom93 = sext i32 %conv6 to i64
  %arrayidx94 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom93
  %18 = load double addrspace(3)* %arrayidx94, align 8
  %mul95 = mul nsw i32 %d, %conv9
  %add96 = add nsw i32 %mul95, %conv2
  %idxprom97 = sext i32 %add96 to i64
  %arrayidx98 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom97
  %19 = load <4 x double> addrspace(1)* %arrayidx98, align 32
  %20 = extractelement <4 x double> %19, i32 0
  %neg = fsub double -0.000000e+00, %18
  %21 = call double @llvm.fmuladd.f64(double %neg, double %20, double %17)
  %22 = insertelement <4 x double> undef, double %21, i32 0
  %mul100 = mul nsw i32 %conv, %conv9
  %add101 = add nsw i32 %mul100, %conv2
  %idxprom102 = sext i32 %add101 to i64
  %arrayidx103 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom102
  %23 = load <4 x double> addrspace(1)* %arrayidx103, align 32
  %24 = extractelement <4 x double> %23, i32 1
  %idxprom104 = sext i32 %conv6 to i64
  %arrayidx105 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom104
  %25 = load double addrspace(3)* %arrayidx105, align 8
  %mul106 = mul nsw i32 %d, %conv9
  %add107 = add nsw i32 %mul106, %conv2
  %idxprom108 = sext i32 %add107 to i64
  %arrayidx109 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom108
  %26 = load <4 x double> addrspace(1)* %arrayidx109, align 32
  %27 = extractelement <4 x double> %26, i32 1
  %neg111 = fsub double -0.000000e+00, %25
  %28 = call double @llvm.fmuladd.f64(double %neg111, double %27, double %24)
  %29 = insertelement <4 x double> %22, double %28, i32 1
  %mul112 = mul nsw i32 %conv, %conv9
  %add113 = add nsw i32 %mul112, %conv2
  %idxprom114 = sext i32 %add113 to i64
  %arrayidx115 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom114
  %30 = load <4 x double> addrspace(1)* %arrayidx115, align 32
  %31 = extractelement <4 x double> %30, i32 2
  %idxprom116 = sext i32 %conv6 to i64
  %arrayidx117 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom116
  %32 = load double addrspace(3)* %arrayidx117, align 8
  %mul118 = mul nsw i32 %d, %conv9
  %add119 = add nsw i32 %mul118, %conv2
  %idxprom120 = sext i32 %add119 to i64
  %arrayidx121 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom120
  %33 = load <4 x double> addrspace(1)* %arrayidx121, align 32
  %34 = extractelement <4 x double> %33, i32 2
  %neg123 = fsub double -0.000000e+00, %32
  %35 = call double @llvm.fmuladd.f64(double %neg123, double %34, double %31)
  %36 = insertelement <4 x double> %29, double %35, i32 2
  %mul124 = mul nsw i32 %conv, %conv9
  %add125 = add nsw i32 %mul124, %conv2
  %idxprom126 = sext i32 %add125 to i64
  %arrayidx127 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom126
  %37 = load <4 x double> addrspace(1)* %arrayidx127, align 32
  %38 = extractelement <4 x double> %37, i32 3
  %idxprom128 = sext i32 %conv6 to i64
  %arrayidx129 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom128
  %39 = load double addrspace(3)* %arrayidx129, align 8
  %mul130 = mul nsw i32 %d, %conv9
  %add131 = add nsw i32 %mul130, %conv2
  %idxprom132 = sext i32 %add131 to i64
  %arrayidx133 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom132
  %40 = load <4 x double> addrspace(1)* %arrayidx133, align 32
  %41 = extractelement <4 x double> %40, i32 3
  %neg135 = fsub double -0.000000e+00, %39
  %42 = call double @llvm.fmuladd.f64(double %neg135, double %41, double %38)
  %43 = insertelement <4 x double> %36, double %42, i32 3
  %div136 = sdiv i32 %d, 4
  %cmp137 = icmp eq i32 %conv2, %div136
  br i1 %cmp137, label %if.then139, label %if.else

if.then139:                                       ; preds = %if.then88
  %cmp140 = icmp eq i32 %rem, 0
  br i1 %cmp140, label %cond.true142, label %cond.false149

cond.true142:                                     ; preds = %if.then139
  %idxprom143 = sext i32 %conv6 to i64
  %arrayidx144 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom143
  %44 = load double addrspace(3)* %arrayidx144, align 8
  %mul145 = mul nsw i32 %conv, %conv9
  %add146 = add nsw i32 %mul145, %conv2
  %idxprom147 = sext i32 %add146 to i64
  %arrayidx148 = getelementptr inbounds <4 x double> addrspace(1)* %LMatrix, i64 %idxprom147
  %45 = load <4 x double> addrspace(1)* %arrayidx148, align 32
  %46 = insertelement <4 x double> %45, double %44, i32 0
  store <4 x double> %46, <4 x double> addrspace(1)* %arrayidx148, align 32
  br label %cond.end154

cond.false149:                                    ; preds = %if.then139
  %47 = extractelement <4 x double> %43, i32 0
  %mul150 = mul nsw i32 %conv, %conv9
  %add151 = add nsw i32 %mul150, %conv2
  %idxprom152 = sext i32 %add151 to i64
  %arrayidx153 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom152
  %48 = load <4 x double> addrspace(1)* %arrayidx153, align 32
  %49 = insertelement <4 x double> %48, double %47, i32 0
  store <4 x double> %49, <4 x double> addrspace(1)* %arrayidx153, align 32
  br label %cond.end154

cond.end154:                                      ; preds = %cond.false149, %cond.true142
  %cond155 = phi double [ %44, %cond.true142 ], [ %47, %cond.false149 ]
  %cmp156 = icmp eq i32 %rem, 1
  br i1 %cmp156, label %cond.true158, label %cond.false165

cond.true158:                                     ; preds = %cond.end154
  %idxprom159 = sext i32 %conv6 to i64
  %arrayidx160 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom159
  %50 = load double addrspace(3)* %arrayidx160, align 8
  %mul161 = mul nsw i32 %conv, %conv9
  %add162 = add nsw i32 %mul161, %conv2
  %idxprom163 = sext i32 %add162 to i64
  %arrayidx164 = getelementptr inbounds <4 x double> addrspace(1)* %LMatrix, i64 %idxprom163
  %51 = load <4 x double> addrspace(1)* %arrayidx164, align 32
  %52 = insertelement <4 x double> %51, double %50, i32 1
  store <4 x double> %52, <4 x double> addrspace(1)* %arrayidx164, align 32
  br label %cond.end170

cond.false165:                                    ; preds = %cond.end154
  %53 = extractelement <4 x double> %43, i32 1
  %mul166 = mul nsw i32 %conv, %conv9
  %add167 = add nsw i32 %mul166, %conv2
  %idxprom168 = sext i32 %add167 to i64
  %arrayidx169 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom168
  %54 = load <4 x double> addrspace(1)* %arrayidx169, align 32
  %55 = insertelement <4 x double> %54, double %53, i32 1
  store <4 x double> %55, <4 x double> addrspace(1)* %arrayidx169, align 32
  br label %cond.end170

cond.end170:                                      ; preds = %cond.false165, %cond.true158
  %cond171 = phi double [ %50, %cond.true158 ], [ %53, %cond.false165 ]
  %cmp172 = icmp eq i32 %rem, 2
  br i1 %cmp172, label %cond.true174, label %cond.false181

cond.true174:                                     ; preds = %cond.end170
  %idxprom175 = sext i32 %conv6 to i64
  %arrayidx176 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom175
  %56 = load double addrspace(3)* %arrayidx176, align 8
  %mul177 = mul nsw i32 %conv, %conv9
  %add178 = add nsw i32 %mul177, %conv2
  %idxprom179 = sext i32 %add178 to i64
  %arrayidx180 = getelementptr inbounds <4 x double> addrspace(1)* %LMatrix, i64 %idxprom179
  %57 = load <4 x double> addrspace(1)* %arrayidx180, align 32
  %58 = insertelement <4 x double> %57, double %56, i32 2
  store <4 x double> %58, <4 x double> addrspace(1)* %arrayidx180, align 32
  br label %cond.end186

cond.false181:                                    ; preds = %cond.end170
  %59 = extractelement <4 x double> %43, i32 2
  %mul182 = mul nsw i32 %conv, %conv9
  %add183 = add nsw i32 %mul182, %conv2
  %idxprom184 = sext i32 %add183 to i64
  %arrayidx185 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom184
  %60 = load <4 x double> addrspace(1)* %arrayidx185, align 32
  %61 = insertelement <4 x double> %60, double %59, i32 2
  store <4 x double> %61, <4 x double> addrspace(1)* %arrayidx185, align 32
  br label %cond.end186

cond.end186:                                      ; preds = %cond.false181, %cond.true174
  %cond187 = phi double [ %56, %cond.true174 ], [ %59, %cond.false181 ]
  %cmp188 = icmp eq i32 %rem, 3
  br i1 %cmp188, label %cond.true190, label %cond.false197

cond.true190:                                     ; preds = %cond.end186
  %idxprom191 = sext i32 %conv6 to i64
  %arrayidx192 = getelementptr inbounds double addrspace(3)* %ratio, i64 %idxprom191
  %62 = load double addrspace(3)* %arrayidx192, align 8
  %mul193 = mul nsw i32 %conv, %conv9
  %add194 = add nsw i32 %mul193, %conv2
  %idxprom195 = sext i32 %add194 to i64
  %arrayidx196 = getelementptr inbounds <4 x double> addrspace(1)* %LMatrix, i64 %idxprom195
  %63 = load <4 x double> addrspace(1)* %arrayidx196, align 32
  %64 = insertelement <4 x double> %63, double %62, i32 3
  store <4 x double> %64, <4 x double> addrspace(1)* %arrayidx196, align 32
  br label %cond.end202

cond.false197:                                    ; preds = %cond.end186
  %65 = extractelement <4 x double> %43, i32 3
  %mul198 = mul nsw i32 %conv, %conv9
  %add199 = add nsw i32 %mul198, %conv2
  %idxprom200 = sext i32 %add199 to i64
  %arrayidx201 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom200
  %66 = load <4 x double> addrspace(1)* %arrayidx201, align 32
  %67 = insertelement <4 x double> %66, double %65, i32 3
  store <4 x double> %67, <4 x double> addrspace(1)* %arrayidx201, align 32
  br label %cond.end202

cond.end202:                                      ; preds = %cond.false197, %cond.true190
  %cond203 = phi double [ %62, %cond.true190 ], [ %65, %cond.false197 ]
  br label %if.end220

if.else:                                          ; preds = %if.then88
  %68 = extractelement <4 x double> %43, i32 0
  %mul204 = mul nsw i32 %conv, %conv9
  %add205 = add nsw i32 %mul204, %conv2
  %idxprom206 = sext i32 %add205 to i64
  %arrayidx207 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom206
  %69 = load <4 x double> addrspace(1)* %arrayidx207, align 32
  %70 = insertelement <4 x double> %69, double %68, i32 0
  store <4 x double> %70, <4 x double> addrspace(1)* %arrayidx207, align 32
  %71 = extractelement <4 x double> %43, i32 1
  %mul208 = mul nsw i32 %conv, %conv9
  %add209 = add nsw i32 %mul208, %conv2
  %idxprom210 = sext i32 %add209 to i64
  %arrayidx211 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom210
  %72 = load <4 x double> addrspace(1)* %arrayidx211, align 32
  %73 = insertelement <4 x double> %72, double %71, i32 1
  store <4 x double> %73, <4 x double> addrspace(1)* %arrayidx211, align 32
  %74 = extractelement <4 x double> %43, i32 2
  %mul212 = mul nsw i32 %conv, %conv9
  %add213 = add nsw i32 %mul212, %conv2
  %idxprom214 = sext i32 %add213 to i64
  %arrayidx215 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom214
  %75 = load <4 x double> addrspace(1)* %arrayidx215, align 32
  %76 = insertelement <4 x double> %75, double %74, i32 2
  store <4 x double> %76, <4 x double> addrspace(1)* %arrayidx215, align 32
  %77 = extractelement <4 x double> %43, i32 3
  %mul216 = mul nsw i32 %conv, %conv9
  %add217 = add nsw i32 %mul216, %conv2
  %idxprom218 = sext i32 %add217 to i64
  %arrayidx219 = getelementptr inbounds <4 x double> addrspace(1)* %inplaceMatrix, i64 %idxprom218
  %78 = load <4 x double> addrspace(1)* %arrayidx219, align 32
  %79 = insertelement <4 x double> %78, double %77, i32 3
  store <4 x double> %79, <4 x double> addrspace(1)* %arrayidx219, align 32
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
  %call = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %call5 = call cc75 i64 @_Z12get_group_idj(i32 1) #1
  %conv6 = trunc i64 %call5 to i32
  %call7 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv8 = trunc i64 %call7 to i32
  %cmp = icmp sgt i32 %conv, %conv2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call11 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %conv12 = trunc i64 %call11 to i32
  %mul = mul nsw i32 %conv, %conv12
  %add = add nsw i32 %mul, %conv2
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds double addrspace(1)* %LMatrix, i64 %idxprom
  %0 = load double addrspace(1)* %arrayidx, align 8
  %mul13 = mul nsw i32 %conv, %conv12
  %add14 = add nsw i32 %mul13, %conv2
  %idxprom15 = sext i32 %add14 to i64
  %arrayidx16 = getelementptr inbounds double addrspace(1)* %inplaceMatrix, i64 %idxprom15
  store double %0, double addrspace(1)* %arrayidx16, align 8
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

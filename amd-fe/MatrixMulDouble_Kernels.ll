; ModuleID = 'MatrixMulDouble_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_mmmKernel_kernel(<4 x double> addrspace(1)* %matrixA, <4 x double> addrspace(1)* %matrixB, <4 x double> addrspace(1)* %matrixC, i32 %widthA, i32 %widthB) #0 {
entry:
  %matrixA.addr = alloca <4 x double> addrspace(1)*, align 8
  %matrixB.addr = alloca <4 x double> addrspace(1)*, align 8
  %matrixC.addr = alloca <4 x double> addrspace(1)*, align 8
  %widthA.addr = alloca i32, align 4
  %widthB.addr = alloca i32, align 4
  %pos = alloca <2 x i32>, align 8
  %.compoundliteral = alloca <2 x i32>, align 8
  %sum0 = alloca <4 x double>, align 32
  %sum1 = alloca <4 x double>, align 32
  %sum2 = alloca <4 x double>, align 32
  %sum3 = alloca <4 x double>, align 32
  %i = alloca i32, align 4
  %tempA0 = alloca <4 x double>, align 32
  %tempA1 = alloca <4 x double>, align 32
  %tempA2 = alloca <4 x double>, align 32
  %tempA3 = alloca <4 x double>, align 32
  %tempB0 = alloca <4 x double>, align 32
  %tempB1 = alloca <4 x double>, align 32
  %tempB2 = alloca <4 x double>, align 32
  %tempB3 = alloca <4 x double>, align 32
  store <4 x double> addrspace(1)* %matrixA, <4 x double> addrspace(1)** %matrixA.addr, align 8
  store <4 x double> addrspace(1)* %matrixB, <4 x double> addrspace(1)** %matrixB.addr, align 8
  store <4 x double> addrspace(1)* %matrixC, <4 x double> addrspace(1)** %matrixC.addr, align 8
  store i32 %widthA, i32* %widthA.addr, align 4
  store i32 %widthB, i32* %widthB.addr, align 4
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %vecinit = insertelement <2 x i32> undef, i32 %conv, i32 0
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv2 = trunc i64 %call1 to i32
  %vecinit3 = insertelement <2 x i32> %vecinit, i32 %conv2, i32 1
  store <2 x i32> %vecinit3, <2 x i32>* %.compoundliteral
  %0 = load <2 x i32>* %.compoundliteral
  store <2 x i32> %0, <2 x i32>* %pos, align 8
  store <4 x double> zeroinitializer, <4 x double>* %sum0, align 32
  store <4 x double> zeroinitializer, <4 x double>* %sum1, align 32
  store <4 x double> zeroinitializer, <4 x double>* %sum2, align 32
  store <4 x double> zeroinitializer, <4 x double>* %sum3, align 32
  %1 = load i32* %widthB.addr, align 4
  %div = udiv i32 %1, 4
  store i32 %div, i32* %widthB.addr, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32* %i, align 4
  %3 = load i32* %widthA.addr, align 4
  %cmp = icmp ult i32 %2, %3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i32* %i, align 4
  %div5 = sdiv i32 %4, 4
  %5 = load <2 x i32>* %pos, align 8
  %6 = extractelement <2 x i32> %5, i32 1
  %shl = shl i32 %6, 2
  %7 = load i32* %widthA.addr, align 4
  %div6 = udiv i32 %7, 4
  %mul = mul i32 %shl, %div6
  %add = add i32 %div5, %mul
  %idxprom = zext i32 %add to i64
  %8 = load <4 x double> addrspace(1)** %matrixA.addr, align 8
  %arrayidx = getelementptr inbounds <4 x double> addrspace(1)* %8, i64 %idxprom
  %9 = load <4 x double> addrspace(1)* %arrayidx, align 32
  store <4 x double> %9, <4 x double>* %tempA0, align 32
  %10 = load i32* %i, align 4
  %div7 = sdiv i32 %10, 4
  %11 = load <2 x i32>* %pos, align 8
  %12 = extractelement <2 x i32> %11, i32 1
  %shl8 = shl i32 %12, 2
  %add9 = add nsw i32 %shl8, 1
  %13 = load i32* %widthA.addr, align 4
  %div10 = udiv i32 %13, 4
  %mul11 = mul i32 %add9, %div10
  %add12 = add i32 %div7, %mul11
  %idxprom13 = zext i32 %add12 to i64
  %14 = load <4 x double> addrspace(1)** %matrixA.addr, align 8
  %arrayidx14 = getelementptr inbounds <4 x double> addrspace(1)* %14, i64 %idxprom13
  %15 = load <4 x double> addrspace(1)* %arrayidx14, align 32
  store <4 x double> %15, <4 x double>* %tempA1, align 32
  %16 = load i32* %i, align 4
  %div15 = sdiv i32 %16, 4
  %17 = load <2 x i32>* %pos, align 8
  %18 = extractelement <2 x i32> %17, i32 1
  %shl16 = shl i32 %18, 2
  %add17 = add nsw i32 %shl16, 2
  %19 = load i32* %widthA.addr, align 4
  %div18 = udiv i32 %19, 4
  %mul19 = mul i32 %add17, %div18
  %add20 = add i32 %div15, %mul19
  %idxprom21 = zext i32 %add20 to i64
  %20 = load <4 x double> addrspace(1)** %matrixA.addr, align 8
  %arrayidx22 = getelementptr inbounds <4 x double> addrspace(1)* %20, i64 %idxprom21
  %21 = load <4 x double> addrspace(1)* %arrayidx22, align 32
  store <4 x double> %21, <4 x double>* %tempA2, align 32
  %22 = load i32* %i, align 4
  %div23 = sdiv i32 %22, 4
  %23 = load <2 x i32>* %pos, align 8
  %24 = extractelement <2 x i32> %23, i32 1
  %shl24 = shl i32 %24, 2
  %add25 = add nsw i32 %shl24, 3
  %25 = load i32* %widthA.addr, align 4
  %div26 = udiv i32 %25, 4
  %mul27 = mul i32 %add25, %div26
  %add28 = add i32 %div23, %mul27
  %idxprom29 = zext i32 %add28 to i64
  %26 = load <4 x double> addrspace(1)** %matrixA.addr, align 8
  %arrayidx30 = getelementptr inbounds <4 x double> addrspace(1)* %26, i64 %idxprom29
  %27 = load <4 x double> addrspace(1)* %arrayidx30, align 32
  store <4 x double> %27, <4 x double>* %tempA3, align 32
  %28 = load <2 x i32>* %pos, align 8
  %29 = extractelement <2 x i32> %28, i32 0
  %30 = load i32* %i, align 4
  %31 = load i32* %widthB.addr, align 4
  %mul31 = mul i32 %30, %31
  %add32 = add i32 %29, %mul31
  %idxprom33 = zext i32 %add32 to i64
  %32 = load <4 x double> addrspace(1)** %matrixB.addr, align 8
  %arrayidx34 = getelementptr inbounds <4 x double> addrspace(1)* %32, i64 %idxprom33
  %33 = load <4 x double> addrspace(1)* %arrayidx34, align 32
  store <4 x double> %33, <4 x double>* %tempB0, align 32
  %34 = load <2 x i32>* %pos, align 8
  %35 = extractelement <2 x i32> %34, i32 0
  %36 = load i32* %i, align 4
  %add35 = add nsw i32 %36, 1
  %37 = load i32* %widthB.addr, align 4
  %mul36 = mul i32 %add35, %37
  %add37 = add i32 %35, %mul36
  %idxprom38 = zext i32 %add37 to i64
  %38 = load <4 x double> addrspace(1)** %matrixB.addr, align 8
  %arrayidx39 = getelementptr inbounds <4 x double> addrspace(1)* %38, i64 %idxprom38
  %39 = load <4 x double> addrspace(1)* %arrayidx39, align 32
  store <4 x double> %39, <4 x double>* %tempB1, align 32
  %40 = load <2 x i32>* %pos, align 8
  %41 = extractelement <2 x i32> %40, i32 0
  %42 = load i32* %i, align 4
  %add40 = add nsw i32 %42, 2
  %43 = load i32* %widthB.addr, align 4
  %mul41 = mul i32 %add40, %43
  %add42 = add i32 %41, %mul41
  %idxprom43 = zext i32 %add42 to i64
  %44 = load <4 x double> addrspace(1)** %matrixB.addr, align 8
  %arrayidx44 = getelementptr inbounds <4 x double> addrspace(1)* %44, i64 %idxprom43
  %45 = load <4 x double> addrspace(1)* %arrayidx44, align 32
  store <4 x double> %45, <4 x double>* %tempB2, align 32
  %46 = load <2 x i32>* %pos, align 8
  %47 = extractelement <2 x i32> %46, i32 0
  %48 = load i32* %i, align 4
  %add45 = add nsw i32 %48, 3
  %49 = load i32* %widthB.addr, align 4
  %mul46 = mul i32 %add45, %49
  %add47 = add i32 %47, %mul46
  %idxprom48 = zext i32 %add47 to i64
  %50 = load <4 x double> addrspace(1)** %matrixB.addr, align 8
  %arrayidx49 = getelementptr inbounds <4 x double> addrspace(1)* %50, i64 %idxprom48
  %51 = load <4 x double> addrspace(1)* %arrayidx49, align 32
  store <4 x double> %51, <4 x double>* %tempB3, align 32
  %52 = load <4 x double>* %tempA0, align 32
  %53 = extractelement <4 x double> %52, i32 0
  %54 = load <4 x double>* %tempB0, align 32
  %55 = extractelement <4 x double> %54, i32 0
  %56 = load <4 x double>* %tempA0, align 32
  %57 = extractelement <4 x double> %56, i32 1
  %58 = load <4 x double>* %tempB1, align 32
  %59 = extractelement <4 x double> %58, i32 0
  %mul51 = fmul double %57, %59
  %60 = call double @llvm.fmuladd.f64(double %53, double %55, double %mul51)
  %61 = load <4 x double>* %tempA0, align 32
  %62 = extractelement <4 x double> %61, i32 2
  %63 = load <4 x double>* %tempB2, align 32
  %64 = extractelement <4 x double> %63, i32 0
  %65 = call double @llvm.fmuladd.f64(double %62, double %64, double %60)
  %66 = load <4 x double>* %tempA0, align 32
  %67 = extractelement <4 x double> %66, i32 3
  %68 = load <4 x double>* %tempB3, align 32
  %69 = extractelement <4 x double> %68, i32 0
  %70 = call double @llvm.fmuladd.f64(double %67, double %69, double %65)
  %71 = load <4 x double>* %sum0, align 32
  %72 = extractelement <4 x double> %71, i32 0
  %add54 = fadd double %72, %70
  %73 = load <4 x double>* %sum0, align 32
  %74 = insertelement <4 x double> %73, double %add54, i32 0
  store <4 x double> %74, <4 x double>* %sum0, align 32
  %75 = load <4 x double>* %tempA0, align 32
  %76 = extractelement <4 x double> %75, i32 0
  %77 = load <4 x double>* %tempB0, align 32
  %78 = extractelement <4 x double> %77, i32 1
  %79 = load <4 x double>* %tempA0, align 32
  %80 = extractelement <4 x double> %79, i32 1
  %81 = load <4 x double>* %tempB1, align 32
  %82 = extractelement <4 x double> %81, i32 1
  %mul56 = fmul double %80, %82
  %83 = call double @llvm.fmuladd.f64(double %76, double %78, double %mul56)
  %84 = load <4 x double>* %tempA0, align 32
  %85 = extractelement <4 x double> %84, i32 2
  %86 = load <4 x double>* %tempB2, align 32
  %87 = extractelement <4 x double> %86, i32 1
  %88 = call double @llvm.fmuladd.f64(double %85, double %87, double %83)
  %89 = load <4 x double>* %tempA0, align 32
  %90 = extractelement <4 x double> %89, i32 3
  %91 = load <4 x double>* %tempB3, align 32
  %92 = extractelement <4 x double> %91, i32 1
  %93 = call double @llvm.fmuladd.f64(double %90, double %92, double %88)
  %94 = load <4 x double>* %sum0, align 32
  %95 = extractelement <4 x double> %94, i32 1
  %add59 = fadd double %95, %93
  %96 = load <4 x double>* %sum0, align 32
  %97 = insertelement <4 x double> %96, double %add59, i32 1
  store <4 x double> %97, <4 x double>* %sum0, align 32
  %98 = load <4 x double>* %tempA0, align 32
  %99 = extractelement <4 x double> %98, i32 0
  %100 = load <4 x double>* %tempB0, align 32
  %101 = extractelement <4 x double> %100, i32 2
  %102 = load <4 x double>* %tempA0, align 32
  %103 = extractelement <4 x double> %102, i32 1
  %104 = load <4 x double>* %tempB1, align 32
  %105 = extractelement <4 x double> %104, i32 2
  %mul61 = fmul double %103, %105
  %106 = call double @llvm.fmuladd.f64(double %99, double %101, double %mul61)
  %107 = load <4 x double>* %tempA0, align 32
  %108 = extractelement <4 x double> %107, i32 2
  %109 = load <4 x double>* %tempB2, align 32
  %110 = extractelement <4 x double> %109, i32 2
  %111 = call double @llvm.fmuladd.f64(double %108, double %110, double %106)
  %112 = load <4 x double>* %tempA0, align 32
  %113 = extractelement <4 x double> %112, i32 3
  %114 = load <4 x double>* %tempB3, align 32
  %115 = extractelement <4 x double> %114, i32 2
  %116 = call double @llvm.fmuladd.f64(double %113, double %115, double %111)
  %117 = load <4 x double>* %sum0, align 32
  %118 = extractelement <4 x double> %117, i32 2
  %add64 = fadd double %118, %116
  %119 = load <4 x double>* %sum0, align 32
  %120 = insertelement <4 x double> %119, double %add64, i32 2
  store <4 x double> %120, <4 x double>* %sum0, align 32
  %121 = load <4 x double>* %tempA0, align 32
  %122 = extractelement <4 x double> %121, i32 0
  %123 = load <4 x double>* %tempB0, align 32
  %124 = extractelement <4 x double> %123, i32 3
  %125 = load <4 x double>* %tempA0, align 32
  %126 = extractelement <4 x double> %125, i32 1
  %127 = load <4 x double>* %tempB1, align 32
  %128 = extractelement <4 x double> %127, i32 3
  %mul66 = fmul double %126, %128
  %129 = call double @llvm.fmuladd.f64(double %122, double %124, double %mul66)
  %130 = load <4 x double>* %tempA0, align 32
  %131 = extractelement <4 x double> %130, i32 2
  %132 = load <4 x double>* %tempB2, align 32
  %133 = extractelement <4 x double> %132, i32 3
  %134 = call double @llvm.fmuladd.f64(double %131, double %133, double %129)
  %135 = load <4 x double>* %tempA0, align 32
  %136 = extractelement <4 x double> %135, i32 3
  %137 = load <4 x double>* %tempB3, align 32
  %138 = extractelement <4 x double> %137, i32 3
  %139 = call double @llvm.fmuladd.f64(double %136, double %138, double %134)
  %140 = load <4 x double>* %sum0, align 32
  %141 = extractelement <4 x double> %140, i32 3
  %add69 = fadd double %141, %139
  %142 = load <4 x double>* %sum0, align 32
  %143 = insertelement <4 x double> %142, double %add69, i32 3
  store <4 x double> %143, <4 x double>* %sum0, align 32
  %144 = load <4 x double>* %tempA1, align 32
  %145 = extractelement <4 x double> %144, i32 0
  %146 = load <4 x double>* %tempB0, align 32
  %147 = extractelement <4 x double> %146, i32 0
  %148 = load <4 x double>* %tempA1, align 32
  %149 = extractelement <4 x double> %148, i32 1
  %150 = load <4 x double>* %tempB1, align 32
  %151 = extractelement <4 x double> %150, i32 0
  %mul71 = fmul double %149, %151
  %152 = call double @llvm.fmuladd.f64(double %145, double %147, double %mul71)
  %153 = load <4 x double>* %tempA1, align 32
  %154 = extractelement <4 x double> %153, i32 2
  %155 = load <4 x double>* %tempB2, align 32
  %156 = extractelement <4 x double> %155, i32 0
  %157 = call double @llvm.fmuladd.f64(double %154, double %156, double %152)
  %158 = load <4 x double>* %tempA1, align 32
  %159 = extractelement <4 x double> %158, i32 3
  %160 = load <4 x double>* %tempB3, align 32
  %161 = extractelement <4 x double> %160, i32 0
  %162 = call double @llvm.fmuladd.f64(double %159, double %161, double %157)
  %163 = load <4 x double>* %sum1, align 32
  %164 = extractelement <4 x double> %163, i32 0
  %add74 = fadd double %164, %162
  %165 = load <4 x double>* %sum1, align 32
  %166 = insertelement <4 x double> %165, double %add74, i32 0
  store <4 x double> %166, <4 x double>* %sum1, align 32
  %167 = load <4 x double>* %tempA1, align 32
  %168 = extractelement <4 x double> %167, i32 0
  %169 = load <4 x double>* %tempB0, align 32
  %170 = extractelement <4 x double> %169, i32 1
  %171 = load <4 x double>* %tempA1, align 32
  %172 = extractelement <4 x double> %171, i32 1
  %173 = load <4 x double>* %tempB1, align 32
  %174 = extractelement <4 x double> %173, i32 1
  %mul76 = fmul double %172, %174
  %175 = call double @llvm.fmuladd.f64(double %168, double %170, double %mul76)
  %176 = load <4 x double>* %tempA1, align 32
  %177 = extractelement <4 x double> %176, i32 2
  %178 = load <4 x double>* %tempB2, align 32
  %179 = extractelement <4 x double> %178, i32 1
  %180 = call double @llvm.fmuladd.f64(double %177, double %179, double %175)
  %181 = load <4 x double>* %tempA1, align 32
  %182 = extractelement <4 x double> %181, i32 3
  %183 = load <4 x double>* %tempB3, align 32
  %184 = extractelement <4 x double> %183, i32 1
  %185 = call double @llvm.fmuladd.f64(double %182, double %184, double %180)
  %186 = load <4 x double>* %sum1, align 32
  %187 = extractelement <4 x double> %186, i32 1
  %add79 = fadd double %187, %185
  %188 = load <4 x double>* %sum1, align 32
  %189 = insertelement <4 x double> %188, double %add79, i32 1
  store <4 x double> %189, <4 x double>* %sum1, align 32
  %190 = load <4 x double>* %tempA1, align 32
  %191 = extractelement <4 x double> %190, i32 0
  %192 = load <4 x double>* %tempB0, align 32
  %193 = extractelement <4 x double> %192, i32 2
  %194 = load <4 x double>* %tempA1, align 32
  %195 = extractelement <4 x double> %194, i32 1
  %196 = load <4 x double>* %tempB1, align 32
  %197 = extractelement <4 x double> %196, i32 2
  %mul81 = fmul double %195, %197
  %198 = call double @llvm.fmuladd.f64(double %191, double %193, double %mul81)
  %199 = load <4 x double>* %tempA1, align 32
  %200 = extractelement <4 x double> %199, i32 2
  %201 = load <4 x double>* %tempB2, align 32
  %202 = extractelement <4 x double> %201, i32 2
  %203 = call double @llvm.fmuladd.f64(double %200, double %202, double %198)
  %204 = load <4 x double>* %tempA1, align 32
  %205 = extractelement <4 x double> %204, i32 3
  %206 = load <4 x double>* %tempB3, align 32
  %207 = extractelement <4 x double> %206, i32 2
  %208 = call double @llvm.fmuladd.f64(double %205, double %207, double %203)
  %209 = load <4 x double>* %sum1, align 32
  %210 = extractelement <4 x double> %209, i32 2
  %add84 = fadd double %210, %208
  %211 = load <4 x double>* %sum1, align 32
  %212 = insertelement <4 x double> %211, double %add84, i32 2
  store <4 x double> %212, <4 x double>* %sum1, align 32
  %213 = load <4 x double>* %tempA1, align 32
  %214 = extractelement <4 x double> %213, i32 0
  %215 = load <4 x double>* %tempB0, align 32
  %216 = extractelement <4 x double> %215, i32 3
  %217 = load <4 x double>* %tempA1, align 32
  %218 = extractelement <4 x double> %217, i32 1
  %219 = load <4 x double>* %tempB1, align 32
  %220 = extractelement <4 x double> %219, i32 3
  %mul86 = fmul double %218, %220
  %221 = call double @llvm.fmuladd.f64(double %214, double %216, double %mul86)
  %222 = load <4 x double>* %tempA1, align 32
  %223 = extractelement <4 x double> %222, i32 2
  %224 = load <4 x double>* %tempB2, align 32
  %225 = extractelement <4 x double> %224, i32 3
  %226 = call double @llvm.fmuladd.f64(double %223, double %225, double %221)
  %227 = load <4 x double>* %tempA1, align 32
  %228 = extractelement <4 x double> %227, i32 3
  %229 = load <4 x double>* %tempB3, align 32
  %230 = extractelement <4 x double> %229, i32 3
  %231 = call double @llvm.fmuladd.f64(double %228, double %230, double %226)
  %232 = load <4 x double>* %sum1, align 32
  %233 = extractelement <4 x double> %232, i32 3
  %add89 = fadd double %233, %231
  %234 = load <4 x double>* %sum1, align 32
  %235 = insertelement <4 x double> %234, double %add89, i32 3
  store <4 x double> %235, <4 x double>* %sum1, align 32
  %236 = load <4 x double>* %tempA2, align 32
  %237 = extractelement <4 x double> %236, i32 0
  %238 = load <4 x double>* %tempB0, align 32
  %239 = extractelement <4 x double> %238, i32 0
  %240 = load <4 x double>* %tempA2, align 32
  %241 = extractelement <4 x double> %240, i32 1
  %242 = load <4 x double>* %tempB1, align 32
  %243 = extractelement <4 x double> %242, i32 0
  %mul91 = fmul double %241, %243
  %244 = call double @llvm.fmuladd.f64(double %237, double %239, double %mul91)
  %245 = load <4 x double>* %tempA2, align 32
  %246 = extractelement <4 x double> %245, i32 2
  %247 = load <4 x double>* %tempB2, align 32
  %248 = extractelement <4 x double> %247, i32 0
  %249 = call double @llvm.fmuladd.f64(double %246, double %248, double %244)
  %250 = load <4 x double>* %tempA2, align 32
  %251 = extractelement <4 x double> %250, i32 3
  %252 = load <4 x double>* %tempB3, align 32
  %253 = extractelement <4 x double> %252, i32 0
  %254 = call double @llvm.fmuladd.f64(double %251, double %253, double %249)
  %255 = load <4 x double>* %sum2, align 32
  %256 = extractelement <4 x double> %255, i32 0
  %add94 = fadd double %256, %254
  %257 = load <4 x double>* %sum2, align 32
  %258 = insertelement <4 x double> %257, double %add94, i32 0
  store <4 x double> %258, <4 x double>* %sum2, align 32
  %259 = load <4 x double>* %tempA2, align 32
  %260 = extractelement <4 x double> %259, i32 0
  %261 = load <4 x double>* %tempB0, align 32
  %262 = extractelement <4 x double> %261, i32 1
  %263 = load <4 x double>* %tempA2, align 32
  %264 = extractelement <4 x double> %263, i32 1
  %265 = load <4 x double>* %tempB1, align 32
  %266 = extractelement <4 x double> %265, i32 1
  %mul96 = fmul double %264, %266
  %267 = call double @llvm.fmuladd.f64(double %260, double %262, double %mul96)
  %268 = load <4 x double>* %tempA2, align 32
  %269 = extractelement <4 x double> %268, i32 2
  %270 = load <4 x double>* %tempB2, align 32
  %271 = extractelement <4 x double> %270, i32 1
  %272 = call double @llvm.fmuladd.f64(double %269, double %271, double %267)
  %273 = load <4 x double>* %tempA2, align 32
  %274 = extractelement <4 x double> %273, i32 3
  %275 = load <4 x double>* %tempB3, align 32
  %276 = extractelement <4 x double> %275, i32 1
  %277 = call double @llvm.fmuladd.f64(double %274, double %276, double %272)
  %278 = load <4 x double>* %sum2, align 32
  %279 = extractelement <4 x double> %278, i32 1
  %add99 = fadd double %279, %277
  %280 = load <4 x double>* %sum2, align 32
  %281 = insertelement <4 x double> %280, double %add99, i32 1
  store <4 x double> %281, <4 x double>* %sum2, align 32
  %282 = load <4 x double>* %tempA2, align 32
  %283 = extractelement <4 x double> %282, i32 0
  %284 = load <4 x double>* %tempB0, align 32
  %285 = extractelement <4 x double> %284, i32 2
  %286 = load <4 x double>* %tempA2, align 32
  %287 = extractelement <4 x double> %286, i32 1
  %288 = load <4 x double>* %tempB1, align 32
  %289 = extractelement <4 x double> %288, i32 2
  %mul101 = fmul double %287, %289
  %290 = call double @llvm.fmuladd.f64(double %283, double %285, double %mul101)
  %291 = load <4 x double>* %tempA2, align 32
  %292 = extractelement <4 x double> %291, i32 2
  %293 = load <4 x double>* %tempB2, align 32
  %294 = extractelement <4 x double> %293, i32 2
  %295 = call double @llvm.fmuladd.f64(double %292, double %294, double %290)
  %296 = load <4 x double>* %tempA2, align 32
  %297 = extractelement <4 x double> %296, i32 3
  %298 = load <4 x double>* %tempB3, align 32
  %299 = extractelement <4 x double> %298, i32 2
  %300 = call double @llvm.fmuladd.f64(double %297, double %299, double %295)
  %301 = load <4 x double>* %sum2, align 32
  %302 = extractelement <4 x double> %301, i32 2
  %add104 = fadd double %302, %300
  %303 = load <4 x double>* %sum2, align 32
  %304 = insertelement <4 x double> %303, double %add104, i32 2
  store <4 x double> %304, <4 x double>* %sum2, align 32
  %305 = load <4 x double>* %tempA2, align 32
  %306 = extractelement <4 x double> %305, i32 0
  %307 = load <4 x double>* %tempB0, align 32
  %308 = extractelement <4 x double> %307, i32 3
  %309 = load <4 x double>* %tempA2, align 32
  %310 = extractelement <4 x double> %309, i32 1
  %311 = load <4 x double>* %tempB1, align 32
  %312 = extractelement <4 x double> %311, i32 3
  %mul106 = fmul double %310, %312
  %313 = call double @llvm.fmuladd.f64(double %306, double %308, double %mul106)
  %314 = load <4 x double>* %tempA2, align 32
  %315 = extractelement <4 x double> %314, i32 2
  %316 = load <4 x double>* %tempB2, align 32
  %317 = extractelement <4 x double> %316, i32 3
  %318 = call double @llvm.fmuladd.f64(double %315, double %317, double %313)
  %319 = load <4 x double>* %tempA2, align 32
  %320 = extractelement <4 x double> %319, i32 3
  %321 = load <4 x double>* %tempB3, align 32
  %322 = extractelement <4 x double> %321, i32 3
  %323 = call double @llvm.fmuladd.f64(double %320, double %322, double %318)
  %324 = load <4 x double>* %sum2, align 32
  %325 = extractelement <4 x double> %324, i32 3
  %add109 = fadd double %325, %323
  %326 = load <4 x double>* %sum2, align 32
  %327 = insertelement <4 x double> %326, double %add109, i32 3
  store <4 x double> %327, <4 x double>* %sum2, align 32
  %328 = load <4 x double>* %tempA3, align 32
  %329 = extractelement <4 x double> %328, i32 0
  %330 = load <4 x double>* %tempB0, align 32
  %331 = extractelement <4 x double> %330, i32 0
  %332 = load <4 x double>* %tempA3, align 32
  %333 = extractelement <4 x double> %332, i32 1
  %334 = load <4 x double>* %tempB1, align 32
  %335 = extractelement <4 x double> %334, i32 0
  %mul111 = fmul double %333, %335
  %336 = call double @llvm.fmuladd.f64(double %329, double %331, double %mul111)
  %337 = load <4 x double>* %tempA3, align 32
  %338 = extractelement <4 x double> %337, i32 2
  %339 = load <4 x double>* %tempB2, align 32
  %340 = extractelement <4 x double> %339, i32 0
  %341 = call double @llvm.fmuladd.f64(double %338, double %340, double %336)
  %342 = load <4 x double>* %tempA3, align 32
  %343 = extractelement <4 x double> %342, i32 3
  %344 = load <4 x double>* %tempB3, align 32
  %345 = extractelement <4 x double> %344, i32 0
  %346 = call double @llvm.fmuladd.f64(double %343, double %345, double %341)
  %347 = load <4 x double>* %sum3, align 32
  %348 = extractelement <4 x double> %347, i32 0
  %add114 = fadd double %348, %346
  %349 = load <4 x double>* %sum3, align 32
  %350 = insertelement <4 x double> %349, double %add114, i32 0
  store <4 x double> %350, <4 x double>* %sum3, align 32
  %351 = load <4 x double>* %tempA3, align 32
  %352 = extractelement <4 x double> %351, i32 0
  %353 = load <4 x double>* %tempB0, align 32
  %354 = extractelement <4 x double> %353, i32 1
  %355 = load <4 x double>* %tempA3, align 32
  %356 = extractelement <4 x double> %355, i32 1
  %357 = load <4 x double>* %tempB1, align 32
  %358 = extractelement <4 x double> %357, i32 1
  %mul116 = fmul double %356, %358
  %359 = call double @llvm.fmuladd.f64(double %352, double %354, double %mul116)
  %360 = load <4 x double>* %tempA3, align 32
  %361 = extractelement <4 x double> %360, i32 2
  %362 = load <4 x double>* %tempB2, align 32
  %363 = extractelement <4 x double> %362, i32 1
  %364 = call double @llvm.fmuladd.f64(double %361, double %363, double %359)
  %365 = load <4 x double>* %tempA3, align 32
  %366 = extractelement <4 x double> %365, i32 3
  %367 = load <4 x double>* %tempB3, align 32
  %368 = extractelement <4 x double> %367, i32 1
  %369 = call double @llvm.fmuladd.f64(double %366, double %368, double %364)
  %370 = load <4 x double>* %sum3, align 32
  %371 = extractelement <4 x double> %370, i32 1
  %add119 = fadd double %371, %369
  %372 = load <4 x double>* %sum3, align 32
  %373 = insertelement <4 x double> %372, double %add119, i32 1
  store <4 x double> %373, <4 x double>* %sum3, align 32
  %374 = load <4 x double>* %tempA3, align 32
  %375 = extractelement <4 x double> %374, i32 0
  %376 = load <4 x double>* %tempB0, align 32
  %377 = extractelement <4 x double> %376, i32 2
  %378 = load <4 x double>* %tempA3, align 32
  %379 = extractelement <4 x double> %378, i32 1
  %380 = load <4 x double>* %tempB1, align 32
  %381 = extractelement <4 x double> %380, i32 2
  %mul121 = fmul double %379, %381
  %382 = call double @llvm.fmuladd.f64(double %375, double %377, double %mul121)
  %383 = load <4 x double>* %tempA3, align 32
  %384 = extractelement <4 x double> %383, i32 2
  %385 = load <4 x double>* %tempB2, align 32
  %386 = extractelement <4 x double> %385, i32 2
  %387 = call double @llvm.fmuladd.f64(double %384, double %386, double %382)
  %388 = load <4 x double>* %tempA3, align 32
  %389 = extractelement <4 x double> %388, i32 3
  %390 = load <4 x double>* %tempB3, align 32
  %391 = extractelement <4 x double> %390, i32 2
  %392 = call double @llvm.fmuladd.f64(double %389, double %391, double %387)
  %393 = load <4 x double>* %sum3, align 32
  %394 = extractelement <4 x double> %393, i32 2
  %add124 = fadd double %394, %392
  %395 = load <4 x double>* %sum3, align 32
  %396 = insertelement <4 x double> %395, double %add124, i32 2
  store <4 x double> %396, <4 x double>* %sum3, align 32
  %397 = load <4 x double>* %tempA3, align 32
  %398 = extractelement <4 x double> %397, i32 0
  %399 = load <4 x double>* %tempB0, align 32
  %400 = extractelement <4 x double> %399, i32 3
  %401 = load <4 x double>* %tempA3, align 32
  %402 = extractelement <4 x double> %401, i32 1
  %403 = load <4 x double>* %tempB1, align 32
  %404 = extractelement <4 x double> %403, i32 3
  %mul126 = fmul double %402, %404
  %405 = call double @llvm.fmuladd.f64(double %398, double %400, double %mul126)
  %406 = load <4 x double>* %tempA3, align 32
  %407 = extractelement <4 x double> %406, i32 2
  %408 = load <4 x double>* %tempB2, align 32
  %409 = extractelement <4 x double> %408, i32 3
  %410 = call double @llvm.fmuladd.f64(double %407, double %409, double %405)
  %411 = load <4 x double>* %tempA3, align 32
  %412 = extractelement <4 x double> %411, i32 3
  %413 = load <4 x double>* %tempB3, align 32
  %414 = extractelement <4 x double> %413, i32 3
  %415 = call double @llvm.fmuladd.f64(double %412, double %414, double %410)
  %416 = load <4 x double>* %sum3, align 32
  %417 = extractelement <4 x double> %416, i32 3
  %add129 = fadd double %417, %415
  %418 = load <4 x double>* %sum3, align 32
  %419 = insertelement <4 x double> %418, double %add129, i32 3
  store <4 x double> %419, <4 x double>* %sum3, align 32
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %420 = load i32* %i, align 4
  %add130 = add nsw i32 %420, 4
  store i32 %add130, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %421 = load <4 x double>* %sum0, align 32
  %422 = load <2 x i32>* %pos, align 8
  %423 = extractelement <2 x i32> %422, i32 0
  %424 = load <2 x i32>* %pos, align 8
  %425 = extractelement <2 x i32> %424, i32 1
  %shl131 = shl i32 %425, 2
  %add132 = add nsw i32 %shl131, 0
  %426 = load i32* %widthB.addr, align 4
  %mul133 = mul i32 %add132, %426
  %add134 = add i32 %423, %mul133
  %idxprom135 = zext i32 %add134 to i64
  %427 = load <4 x double> addrspace(1)** %matrixC.addr, align 8
  %arrayidx136 = getelementptr inbounds <4 x double> addrspace(1)* %427, i64 %idxprom135
  store <4 x double> %421, <4 x double> addrspace(1)* %arrayidx136, align 32
  %428 = load <4 x double>* %sum1, align 32
  %429 = load <2 x i32>* %pos, align 8
  %430 = extractelement <2 x i32> %429, i32 0
  %431 = load <2 x i32>* %pos, align 8
  %432 = extractelement <2 x i32> %431, i32 1
  %shl137 = shl i32 %432, 2
  %add138 = add nsw i32 %shl137, 1
  %433 = load i32* %widthB.addr, align 4
  %mul139 = mul i32 %add138, %433
  %add140 = add i32 %430, %mul139
  %idxprom141 = zext i32 %add140 to i64
  %434 = load <4 x double> addrspace(1)** %matrixC.addr, align 8
  %arrayidx142 = getelementptr inbounds <4 x double> addrspace(1)* %434, i64 %idxprom141
  store <4 x double> %428, <4 x double> addrspace(1)* %arrayidx142, align 32
  %435 = load <4 x double>* %sum2, align 32
  %436 = load <2 x i32>* %pos, align 8
  %437 = extractelement <2 x i32> %436, i32 0
  %438 = load <2 x i32>* %pos, align 8
  %439 = extractelement <2 x i32> %438, i32 1
  %shl143 = shl i32 %439, 2
  %add144 = add nsw i32 %shl143, 2
  %440 = load i32* %widthB.addr, align 4
  %mul145 = mul i32 %add144, %440
  %add146 = add i32 %437, %mul145
  %idxprom147 = zext i32 %add146 to i64
  %441 = load <4 x double> addrspace(1)** %matrixC.addr, align 8
  %arrayidx148 = getelementptr inbounds <4 x double> addrspace(1)* %441, i64 %idxprom147
  store <4 x double> %435, <4 x double> addrspace(1)* %arrayidx148, align 32
  %442 = load <4 x double>* %sum3, align 32
  %443 = load <2 x i32>* %pos, align 8
  %444 = extractelement <2 x i32> %443, i32 0
  %445 = load <2 x i32>* %pos, align 8
  %446 = extractelement <2 x i32> %445, i32 1
  %shl149 = shl i32 %446, 2
  %add150 = add nsw i32 %shl149, 3
  %447 = load i32* %widthB.addr, align 4
  %mul151 = mul i32 %add150, %447
  %add152 = add i32 %444, %mul151
  %idxprom153 = zext i32 %add152 to i64
  %448 = load <4 x double> addrspace(1)** %matrixC.addr, align 8
  %arrayidx154 = getelementptr inbounds <4 x double> addrspace(1)* %448, i64 %idxprom153
  store <4 x double> %442, <4 x double> addrspace(1)* %arrayidx154, align 32
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_mmmKernel_local_kernel(<4 x double> addrspace(1)* %matrixA, <4 x double> addrspace(1)* %matrixB, <4 x double> addrspace(1)* %matrixC, i32 %widthA, <4 x double> addrspace(3)* %blockA) #0 {
entry:
  %matrixA.addr = alloca <4 x double> addrspace(1)*, align 8
  %matrixB.addr = alloca <4 x double> addrspace(1)*, align 8
  %matrixC.addr = alloca <4 x double> addrspace(1)*, align 8
  %widthA.addr = alloca i32, align 4
  %blockA.addr = alloca <4 x double> addrspace(3)*, align 8
  %blockPos = alloca i32, align 4
  %globalPos = alloca i32, align 4
  %sum0 = alloca <4 x double>, align 32
  %sum1 = alloca <4 x double>, align 32
  %sum2 = alloca <4 x double>, align 32
  %sum3 = alloca <4 x double>, align 32
  %temp = alloca i32, align 4
  %i = alloca i32, align 4
  %globalPosA = alloca i32, align 4
  %globalPosB = alloca i32, align 4
  %j = alloca i32, align 4
  %tempA0 = alloca <4 x double>, align 32
  %tempA1 = alloca <4 x double>, align 32
  %tempA2 = alloca <4 x double>, align 32
  %tempA3 = alloca <4 x double>, align 32
  %tempB0 = alloca <4 x double>, align 32
  %tempB1 = alloca <4 x double>, align 32
  %tempB2 = alloca <4 x double>, align 32
  %tempB3 = alloca <4 x double>, align 32
  store <4 x double> addrspace(1)* %matrixA, <4 x double> addrspace(1)** %matrixA.addr, align 8
  store <4 x double> addrspace(1)* %matrixB, <4 x double> addrspace(1)** %matrixB.addr, align 8
  store <4 x double> addrspace(1)* %matrixC, <4 x double> addrspace(1)** %matrixC.addr, align 8
  store i32 %widthA, i32* %widthA.addr, align 4
  store <4 x double> addrspace(3)* %blockA, <4 x double> addrspace(3)** %blockA.addr, align 8
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %call2 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %shl = shl i64 %call2, 2
  %mul = mul i64 %call1, %shl
  %add = add i64 %call, %mul
  %conv = trunc i64 %add to i32
  store i32 %conv, i32* %blockPos, align 4
  %call3 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call4 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %shl5 = shl i64 %call4, 2
  %call6 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul7 = mul i64 %shl5, %call6
  %add8 = add i64 %call3, %mul7
  %conv9 = trunc i64 %add8 to i32
  store i32 %conv9, i32* %globalPos, align 4
  store <4 x double> zeroinitializer, <4 x double>* %sum0, align 32
  store <4 x double> zeroinitializer, <4 x double>* %sum1, align 32
  store <4 x double> zeroinitializer, <4 x double>* %sum2, align 32
  store <4 x double> zeroinitializer, <4 x double>* %sum3, align 32
  %0 = load i32* %widthA.addr, align 4
  %div = sdiv i32 %0, 4
  store i32 %div, i32* %temp, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc211, %entry
  %1 = load i32* %i, align 4
  %conv10 = sext i32 %1 to i64
  %2 = load i32* %temp, align 4
  %conv11 = sext i32 %2 to i64
  %call12 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %div13 = udiv i64 %conv11, %call12
  %cmp = icmp ult i64 %conv10, %div13
  br i1 %cmp, label %for.body, label %for.end212

for.body:                                         ; preds = %for.cond
  %3 = load i32* %i, align 4
  %conv15 = sext i32 %3 to i64
  %call16 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul17 = mul i64 %conv15, %call16
  %call18 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %add19 = add i64 %mul17, %call18
  %call20 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %shl21 = shl i64 %call20, 2
  %4 = load i32* %temp, align 4
  %conv22 = sext i32 %4 to i64
  %mul23 = mul i64 %shl21, %conv22
  %add24 = add i64 %add19, %mul23
  %conv25 = trunc i64 %add24 to i32
  store i32 %conv25, i32* %globalPosA, align 4
  %5 = load i32* %globalPosA, align 4
  %idxprom = sext i32 %5 to i64
  %6 = load <4 x double> addrspace(1)** %matrixA.addr, align 8
  %arrayidx = getelementptr inbounds <4 x double> addrspace(1)* %6, i64 %idxprom
  %7 = load <4 x double> addrspace(1)* %arrayidx, align 32
  %8 = load i32* %blockPos, align 4
  %idxprom26 = sext i32 %8 to i64
  %9 = load <4 x double> addrspace(3)** %blockA.addr, align 8
  %arrayidx27 = getelementptr inbounds <4 x double> addrspace(3)* %9, i64 %idxprom26
  store <4 x double> %7, <4 x double> addrspace(3)* %arrayidx27, align 32
  %10 = load i32* %globalPosA, align 4
  %11 = load i32* %temp, align 4
  %add28 = add nsw i32 %10, %11
  %idxprom29 = sext i32 %add28 to i64
  %12 = load <4 x double> addrspace(1)** %matrixA.addr, align 8
  %arrayidx30 = getelementptr inbounds <4 x double> addrspace(1)* %12, i64 %idxprom29
  %13 = load <4 x double> addrspace(1)* %arrayidx30, align 32
  %14 = load i32* %blockPos, align 4
  %conv31 = sext i32 %14 to i64
  %call32 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %add33 = add i64 %conv31, %call32
  %15 = load <4 x double> addrspace(3)** %blockA.addr, align 8
  %arrayidx34 = getelementptr inbounds <4 x double> addrspace(3)* %15, i64 %add33
  store <4 x double> %13, <4 x double> addrspace(3)* %arrayidx34, align 32
  %16 = load i32* %globalPosA, align 4
  %17 = load i32* %temp, align 4
  %mul35 = mul nsw i32 2, %17
  %add36 = add nsw i32 %16, %mul35
  %idxprom37 = sext i32 %add36 to i64
  %18 = load <4 x double> addrspace(1)** %matrixA.addr, align 8
  %arrayidx38 = getelementptr inbounds <4 x double> addrspace(1)* %18, i64 %idxprom37
  %19 = load <4 x double> addrspace(1)* %arrayidx38, align 32
  %20 = load i32* %blockPos, align 4
  %conv39 = sext i32 %20 to i64
  %call40 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul41 = mul i64 2, %call40
  %add42 = add i64 %conv39, %mul41
  %21 = load <4 x double> addrspace(3)** %blockA.addr, align 8
  %arrayidx43 = getelementptr inbounds <4 x double> addrspace(3)* %21, i64 %add42
  store <4 x double> %19, <4 x double> addrspace(3)* %arrayidx43, align 32
  %22 = load i32* %globalPosA, align 4
  %23 = load i32* %temp, align 4
  %mul44 = mul nsw i32 3, %23
  %add45 = add nsw i32 %22, %mul44
  %idxprom46 = sext i32 %add45 to i64
  %24 = load <4 x double> addrspace(1)** %matrixA.addr, align 8
  %arrayidx47 = getelementptr inbounds <4 x double> addrspace(1)* %24, i64 %idxprom46
  %25 = load <4 x double> addrspace(1)* %arrayidx47, align 32
  %26 = load i32* %blockPos, align 4
  %conv48 = sext i32 %26 to i64
  %call49 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul50 = mul i64 3, %call49
  %add51 = add i64 %conv48, %mul50
  %27 = load <4 x double> addrspace(3)** %blockA.addr, align 8
  %arrayidx52 = getelementptr inbounds <4 x double> addrspace(3)* %27, i64 %add51
  store <4 x double> %25, <4 x double> addrspace(3)* %arrayidx52, align 32
  call cc75 void @_Z7barrierj(i32 1)
  %call53 = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %28 = load i32* %i, align 4
  %conv54 = sext i32 %28 to i64
  %call55 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul56 = mul i64 %conv54, %call55
  %shl57 = shl i64 %mul56, 2
  %call58 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul59 = mul i64 %shl57, %call58
  %add60 = add i64 %call53, %mul59
  %conv61 = trunc i64 %add60 to i32
  store i32 %conv61, i32* %globalPosB, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond62

for.cond62:                                       ; preds = %for.inc, %for.body
  %29 = load i32* %j, align 4
  %conv63 = sext i32 %29 to i64
  %call64 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul65 = mul i64 %call64, 4
  %cmp66 = icmp ult i64 %conv63, %mul65
  br i1 %cmp66, label %for.body68, label %for.end

for.body68:                                       ; preds = %for.cond62
  %30 = load i32* %j, align 4
  %shr = ashr i32 %30, 2
  %conv69 = sext i32 %shr to i64
  %call70 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %mul71 = mul i64 %call70, 4
  %call72 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul73 = mul i64 %mul71, %call72
  %add74 = add i64 %conv69, %mul73
  %31 = load <4 x double> addrspace(3)** %blockA.addr, align 8
  %arrayidx75 = getelementptr inbounds <4 x double> addrspace(3)* %31, i64 %add74
  %32 = load <4 x double> addrspace(3)* %arrayidx75, align 32
  store <4 x double> %32, <4 x double>* %tempA0, align 32
  %33 = load i32* %j, align 4
  %shr76 = ashr i32 %33, 2
  %conv77 = sext i32 %shr76 to i64
  %call78 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %mul79 = mul i64 %call78, 4
  %add80 = add i64 %mul79, 1
  %call81 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul82 = mul i64 %add80, %call81
  %add83 = add i64 %conv77, %mul82
  %34 = load <4 x double> addrspace(3)** %blockA.addr, align 8
  %arrayidx84 = getelementptr inbounds <4 x double> addrspace(3)* %34, i64 %add83
  %35 = load <4 x double> addrspace(3)* %arrayidx84, align 32
  store <4 x double> %35, <4 x double>* %tempA1, align 32
  %36 = load i32* %j, align 4
  %shr85 = ashr i32 %36, 2
  %conv86 = sext i32 %shr85 to i64
  %call87 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %mul88 = mul i64 %call87, 4
  %add89 = add i64 %mul88, 2
  %call90 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul91 = mul i64 %add89, %call90
  %add92 = add i64 %conv86, %mul91
  %37 = load <4 x double> addrspace(3)** %blockA.addr, align 8
  %arrayidx93 = getelementptr inbounds <4 x double> addrspace(3)* %37, i64 %add92
  %38 = load <4 x double> addrspace(3)* %arrayidx93, align 32
  store <4 x double> %38, <4 x double>* %tempA2, align 32
  %39 = load i32* %j, align 4
  %shr94 = ashr i32 %39, 2
  %conv95 = sext i32 %shr94 to i64
  %call96 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %mul97 = mul i64 %call96, 4
  %add98 = add i64 %mul97, 3
  %call99 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul100 = mul i64 %add98, %call99
  %add101 = add i64 %conv95, %mul100
  %40 = load <4 x double> addrspace(3)** %blockA.addr, align 8
  %arrayidx102 = getelementptr inbounds <4 x double> addrspace(3)* %40, i64 %add101
  %41 = load <4 x double> addrspace(3)* %arrayidx102, align 32
  store <4 x double> %41, <4 x double>* %tempA3, align 32
  %42 = load i32* %globalPosB, align 4
  %conv103 = sext i32 %42 to i64
  %43 = load i32* %j, align 4
  %conv104 = sext i32 %43 to i64
  %call105 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul106 = mul i64 %conv104, %call105
  %add107 = add i64 %conv103, %mul106
  %44 = load <4 x double> addrspace(1)** %matrixB.addr, align 8
  %arrayidx108 = getelementptr inbounds <4 x double> addrspace(1)* %44, i64 %add107
  %45 = load <4 x double> addrspace(1)* %arrayidx108, align 32
  store <4 x double> %45, <4 x double>* %tempB0, align 32
  %46 = load i32* %globalPosB, align 4
  %conv109 = sext i32 %46 to i64
  %47 = load i32* %j, align 4
  %add110 = add nsw i32 %47, 1
  %conv111 = sext i32 %add110 to i64
  %call112 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul113 = mul i64 %conv111, %call112
  %add114 = add i64 %conv109, %mul113
  %48 = load <4 x double> addrspace(1)** %matrixB.addr, align 8
  %arrayidx115 = getelementptr inbounds <4 x double> addrspace(1)* %48, i64 %add114
  %49 = load <4 x double> addrspace(1)* %arrayidx115, align 32
  store <4 x double> %49, <4 x double>* %tempB1, align 32
  %50 = load i32* %globalPosB, align 4
  %conv116 = sext i32 %50 to i64
  %51 = load i32* %j, align 4
  %add117 = add nsw i32 %51, 2
  %conv118 = sext i32 %add117 to i64
  %call119 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul120 = mul i64 %conv118, %call119
  %add121 = add i64 %conv116, %mul120
  %52 = load <4 x double> addrspace(1)** %matrixB.addr, align 8
  %arrayidx122 = getelementptr inbounds <4 x double> addrspace(1)* %52, i64 %add121
  %53 = load <4 x double> addrspace(1)* %arrayidx122, align 32
  store <4 x double> %53, <4 x double>* %tempB2, align 32
  %54 = load i32* %globalPosB, align 4
  %conv123 = sext i32 %54 to i64
  %55 = load i32* %j, align 4
  %add124 = add nsw i32 %55, 3
  %conv125 = sext i32 %add124 to i64
  %call126 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul127 = mul i64 %conv125, %call126
  %add128 = add i64 %conv123, %mul127
  %56 = load <4 x double> addrspace(1)** %matrixB.addr, align 8
  %arrayidx129 = getelementptr inbounds <4 x double> addrspace(1)* %56, i64 %add128
  %57 = load <4 x double> addrspace(1)* %arrayidx129, align 32
  store <4 x double> %57, <4 x double>* %tempB3, align 32
  %58 = load <4 x double>* %tempA0, align 32
  %59 = extractelement <4 x double> %58, i32 0
  %60 = load <4 x double>* %tempB0, align 32
  %61 = extractelement <4 x double> %60, i32 0
  %62 = load <4 x double>* %tempA0, align 32
  %63 = extractelement <4 x double> %62, i32 1
  %64 = load <4 x double>* %tempB1, align 32
  %65 = extractelement <4 x double> %64, i32 0
  %mul131 = fmul double %63, %65
  %66 = call double @llvm.fmuladd.f64(double %59, double %61, double %mul131)
  %67 = load <4 x double>* %tempA0, align 32
  %68 = extractelement <4 x double> %67, i32 2
  %69 = load <4 x double>* %tempB2, align 32
  %70 = extractelement <4 x double> %69, i32 0
  %71 = call double @llvm.fmuladd.f64(double %68, double %70, double %66)
  %72 = load <4 x double>* %tempA0, align 32
  %73 = extractelement <4 x double> %72, i32 3
  %74 = load <4 x double>* %tempB3, align 32
  %75 = extractelement <4 x double> %74, i32 0
  %76 = call double @llvm.fmuladd.f64(double %73, double %75, double %71)
  %77 = load <4 x double>* %sum0, align 32
  %78 = extractelement <4 x double> %77, i32 0
  %add134 = fadd double %78, %76
  %79 = load <4 x double>* %sum0, align 32
  %80 = insertelement <4 x double> %79, double %add134, i32 0
  store <4 x double> %80, <4 x double>* %sum0, align 32
  %81 = load <4 x double>* %tempA0, align 32
  %82 = extractelement <4 x double> %81, i32 0
  %83 = load <4 x double>* %tempB0, align 32
  %84 = extractelement <4 x double> %83, i32 1
  %85 = load <4 x double>* %tempA0, align 32
  %86 = extractelement <4 x double> %85, i32 1
  %87 = load <4 x double>* %tempB1, align 32
  %88 = extractelement <4 x double> %87, i32 1
  %mul136 = fmul double %86, %88
  %89 = call double @llvm.fmuladd.f64(double %82, double %84, double %mul136)
  %90 = load <4 x double>* %tempA0, align 32
  %91 = extractelement <4 x double> %90, i32 2
  %92 = load <4 x double>* %tempB2, align 32
  %93 = extractelement <4 x double> %92, i32 1
  %94 = call double @llvm.fmuladd.f64(double %91, double %93, double %89)
  %95 = load <4 x double>* %tempA0, align 32
  %96 = extractelement <4 x double> %95, i32 3
  %97 = load <4 x double>* %tempB3, align 32
  %98 = extractelement <4 x double> %97, i32 1
  %99 = call double @llvm.fmuladd.f64(double %96, double %98, double %94)
  %100 = load <4 x double>* %sum0, align 32
  %101 = extractelement <4 x double> %100, i32 1
  %add139 = fadd double %101, %99
  %102 = load <4 x double>* %sum0, align 32
  %103 = insertelement <4 x double> %102, double %add139, i32 1
  store <4 x double> %103, <4 x double>* %sum0, align 32
  %104 = load <4 x double>* %tempA0, align 32
  %105 = extractelement <4 x double> %104, i32 0
  %106 = load <4 x double>* %tempB0, align 32
  %107 = extractelement <4 x double> %106, i32 2
  %108 = load <4 x double>* %tempA0, align 32
  %109 = extractelement <4 x double> %108, i32 1
  %110 = load <4 x double>* %tempB1, align 32
  %111 = extractelement <4 x double> %110, i32 2
  %mul141 = fmul double %109, %111
  %112 = call double @llvm.fmuladd.f64(double %105, double %107, double %mul141)
  %113 = load <4 x double>* %tempA0, align 32
  %114 = extractelement <4 x double> %113, i32 2
  %115 = load <4 x double>* %tempB2, align 32
  %116 = extractelement <4 x double> %115, i32 2
  %117 = call double @llvm.fmuladd.f64(double %114, double %116, double %112)
  %118 = load <4 x double>* %tempA0, align 32
  %119 = extractelement <4 x double> %118, i32 3
  %120 = load <4 x double>* %tempB3, align 32
  %121 = extractelement <4 x double> %120, i32 2
  %122 = call double @llvm.fmuladd.f64(double %119, double %121, double %117)
  %123 = load <4 x double>* %sum0, align 32
  %124 = extractelement <4 x double> %123, i32 2
  %add144 = fadd double %124, %122
  %125 = load <4 x double>* %sum0, align 32
  %126 = insertelement <4 x double> %125, double %add144, i32 2
  store <4 x double> %126, <4 x double>* %sum0, align 32
  %127 = load <4 x double>* %tempA0, align 32
  %128 = extractelement <4 x double> %127, i32 0
  %129 = load <4 x double>* %tempB0, align 32
  %130 = extractelement <4 x double> %129, i32 3
  %131 = load <4 x double>* %tempA0, align 32
  %132 = extractelement <4 x double> %131, i32 1
  %133 = load <4 x double>* %tempB1, align 32
  %134 = extractelement <4 x double> %133, i32 3
  %mul146 = fmul double %132, %134
  %135 = call double @llvm.fmuladd.f64(double %128, double %130, double %mul146)
  %136 = load <4 x double>* %tempA0, align 32
  %137 = extractelement <4 x double> %136, i32 2
  %138 = load <4 x double>* %tempB2, align 32
  %139 = extractelement <4 x double> %138, i32 3
  %140 = call double @llvm.fmuladd.f64(double %137, double %139, double %135)
  %141 = load <4 x double>* %tempA0, align 32
  %142 = extractelement <4 x double> %141, i32 3
  %143 = load <4 x double>* %tempB3, align 32
  %144 = extractelement <4 x double> %143, i32 3
  %145 = call double @llvm.fmuladd.f64(double %142, double %144, double %140)
  %146 = load <4 x double>* %sum0, align 32
  %147 = extractelement <4 x double> %146, i32 3
  %add149 = fadd double %147, %145
  %148 = load <4 x double>* %sum0, align 32
  %149 = insertelement <4 x double> %148, double %add149, i32 3
  store <4 x double> %149, <4 x double>* %sum0, align 32
  %150 = load <4 x double>* %tempA1, align 32
  %151 = extractelement <4 x double> %150, i32 0
  %152 = load <4 x double>* %tempB0, align 32
  %153 = extractelement <4 x double> %152, i32 0
  %154 = load <4 x double>* %tempA1, align 32
  %155 = extractelement <4 x double> %154, i32 1
  %156 = load <4 x double>* %tempB1, align 32
  %157 = extractelement <4 x double> %156, i32 0
  %mul151 = fmul double %155, %157
  %158 = call double @llvm.fmuladd.f64(double %151, double %153, double %mul151)
  %159 = load <4 x double>* %tempA1, align 32
  %160 = extractelement <4 x double> %159, i32 2
  %161 = load <4 x double>* %tempB2, align 32
  %162 = extractelement <4 x double> %161, i32 0
  %163 = call double @llvm.fmuladd.f64(double %160, double %162, double %158)
  %164 = load <4 x double>* %tempA1, align 32
  %165 = extractelement <4 x double> %164, i32 3
  %166 = load <4 x double>* %tempB3, align 32
  %167 = extractelement <4 x double> %166, i32 0
  %168 = call double @llvm.fmuladd.f64(double %165, double %167, double %163)
  %169 = load <4 x double>* %sum1, align 32
  %170 = extractelement <4 x double> %169, i32 0
  %add154 = fadd double %170, %168
  %171 = load <4 x double>* %sum1, align 32
  %172 = insertelement <4 x double> %171, double %add154, i32 0
  store <4 x double> %172, <4 x double>* %sum1, align 32
  %173 = load <4 x double>* %tempA1, align 32
  %174 = extractelement <4 x double> %173, i32 0
  %175 = load <4 x double>* %tempB0, align 32
  %176 = extractelement <4 x double> %175, i32 1
  %177 = load <4 x double>* %tempA1, align 32
  %178 = extractelement <4 x double> %177, i32 1
  %179 = load <4 x double>* %tempB1, align 32
  %180 = extractelement <4 x double> %179, i32 1
  %mul156 = fmul double %178, %180
  %181 = call double @llvm.fmuladd.f64(double %174, double %176, double %mul156)
  %182 = load <4 x double>* %tempA1, align 32
  %183 = extractelement <4 x double> %182, i32 2
  %184 = load <4 x double>* %tempB2, align 32
  %185 = extractelement <4 x double> %184, i32 1
  %186 = call double @llvm.fmuladd.f64(double %183, double %185, double %181)
  %187 = load <4 x double>* %tempA1, align 32
  %188 = extractelement <4 x double> %187, i32 3
  %189 = load <4 x double>* %tempB3, align 32
  %190 = extractelement <4 x double> %189, i32 1
  %191 = call double @llvm.fmuladd.f64(double %188, double %190, double %186)
  %192 = load <4 x double>* %sum1, align 32
  %193 = extractelement <4 x double> %192, i32 1
  %add159 = fadd double %193, %191
  %194 = load <4 x double>* %sum1, align 32
  %195 = insertelement <4 x double> %194, double %add159, i32 1
  store <4 x double> %195, <4 x double>* %sum1, align 32
  %196 = load <4 x double>* %tempA1, align 32
  %197 = extractelement <4 x double> %196, i32 0
  %198 = load <4 x double>* %tempB0, align 32
  %199 = extractelement <4 x double> %198, i32 2
  %200 = load <4 x double>* %tempA1, align 32
  %201 = extractelement <4 x double> %200, i32 1
  %202 = load <4 x double>* %tempB1, align 32
  %203 = extractelement <4 x double> %202, i32 2
  %mul161 = fmul double %201, %203
  %204 = call double @llvm.fmuladd.f64(double %197, double %199, double %mul161)
  %205 = load <4 x double>* %tempA1, align 32
  %206 = extractelement <4 x double> %205, i32 2
  %207 = load <4 x double>* %tempB2, align 32
  %208 = extractelement <4 x double> %207, i32 2
  %209 = call double @llvm.fmuladd.f64(double %206, double %208, double %204)
  %210 = load <4 x double>* %tempA1, align 32
  %211 = extractelement <4 x double> %210, i32 3
  %212 = load <4 x double>* %tempB3, align 32
  %213 = extractelement <4 x double> %212, i32 2
  %214 = call double @llvm.fmuladd.f64(double %211, double %213, double %209)
  %215 = load <4 x double>* %sum1, align 32
  %216 = extractelement <4 x double> %215, i32 2
  %add164 = fadd double %216, %214
  %217 = load <4 x double>* %sum1, align 32
  %218 = insertelement <4 x double> %217, double %add164, i32 2
  store <4 x double> %218, <4 x double>* %sum1, align 32
  %219 = load <4 x double>* %tempA1, align 32
  %220 = extractelement <4 x double> %219, i32 0
  %221 = load <4 x double>* %tempB0, align 32
  %222 = extractelement <4 x double> %221, i32 3
  %223 = load <4 x double>* %tempA1, align 32
  %224 = extractelement <4 x double> %223, i32 1
  %225 = load <4 x double>* %tempB1, align 32
  %226 = extractelement <4 x double> %225, i32 3
  %mul166 = fmul double %224, %226
  %227 = call double @llvm.fmuladd.f64(double %220, double %222, double %mul166)
  %228 = load <4 x double>* %tempA1, align 32
  %229 = extractelement <4 x double> %228, i32 2
  %230 = load <4 x double>* %tempB2, align 32
  %231 = extractelement <4 x double> %230, i32 3
  %232 = call double @llvm.fmuladd.f64(double %229, double %231, double %227)
  %233 = load <4 x double>* %tempA1, align 32
  %234 = extractelement <4 x double> %233, i32 3
  %235 = load <4 x double>* %tempB3, align 32
  %236 = extractelement <4 x double> %235, i32 3
  %237 = call double @llvm.fmuladd.f64(double %234, double %236, double %232)
  %238 = load <4 x double>* %sum1, align 32
  %239 = extractelement <4 x double> %238, i32 3
  %add169 = fadd double %239, %237
  %240 = load <4 x double>* %sum1, align 32
  %241 = insertelement <4 x double> %240, double %add169, i32 3
  store <4 x double> %241, <4 x double>* %sum1, align 32
  %242 = load <4 x double>* %tempA2, align 32
  %243 = extractelement <4 x double> %242, i32 0
  %244 = load <4 x double>* %tempB0, align 32
  %245 = extractelement <4 x double> %244, i32 0
  %246 = load <4 x double>* %tempA2, align 32
  %247 = extractelement <4 x double> %246, i32 1
  %248 = load <4 x double>* %tempB1, align 32
  %249 = extractelement <4 x double> %248, i32 0
  %mul171 = fmul double %247, %249
  %250 = call double @llvm.fmuladd.f64(double %243, double %245, double %mul171)
  %251 = load <4 x double>* %tempA2, align 32
  %252 = extractelement <4 x double> %251, i32 2
  %253 = load <4 x double>* %tempB2, align 32
  %254 = extractelement <4 x double> %253, i32 0
  %255 = call double @llvm.fmuladd.f64(double %252, double %254, double %250)
  %256 = load <4 x double>* %tempA2, align 32
  %257 = extractelement <4 x double> %256, i32 3
  %258 = load <4 x double>* %tempB3, align 32
  %259 = extractelement <4 x double> %258, i32 0
  %260 = call double @llvm.fmuladd.f64(double %257, double %259, double %255)
  %261 = load <4 x double>* %sum2, align 32
  %262 = extractelement <4 x double> %261, i32 0
  %add174 = fadd double %262, %260
  %263 = load <4 x double>* %sum2, align 32
  %264 = insertelement <4 x double> %263, double %add174, i32 0
  store <4 x double> %264, <4 x double>* %sum2, align 32
  %265 = load <4 x double>* %tempA2, align 32
  %266 = extractelement <4 x double> %265, i32 0
  %267 = load <4 x double>* %tempB0, align 32
  %268 = extractelement <4 x double> %267, i32 1
  %269 = load <4 x double>* %tempA2, align 32
  %270 = extractelement <4 x double> %269, i32 1
  %271 = load <4 x double>* %tempB1, align 32
  %272 = extractelement <4 x double> %271, i32 1
  %mul176 = fmul double %270, %272
  %273 = call double @llvm.fmuladd.f64(double %266, double %268, double %mul176)
  %274 = load <4 x double>* %tempA2, align 32
  %275 = extractelement <4 x double> %274, i32 2
  %276 = load <4 x double>* %tempB2, align 32
  %277 = extractelement <4 x double> %276, i32 1
  %278 = call double @llvm.fmuladd.f64(double %275, double %277, double %273)
  %279 = load <4 x double>* %tempA2, align 32
  %280 = extractelement <4 x double> %279, i32 3
  %281 = load <4 x double>* %tempB3, align 32
  %282 = extractelement <4 x double> %281, i32 1
  %283 = call double @llvm.fmuladd.f64(double %280, double %282, double %278)
  %284 = load <4 x double>* %sum2, align 32
  %285 = extractelement <4 x double> %284, i32 1
  %add179 = fadd double %285, %283
  %286 = load <4 x double>* %sum2, align 32
  %287 = insertelement <4 x double> %286, double %add179, i32 1
  store <4 x double> %287, <4 x double>* %sum2, align 32
  %288 = load <4 x double>* %tempA2, align 32
  %289 = extractelement <4 x double> %288, i32 0
  %290 = load <4 x double>* %tempB0, align 32
  %291 = extractelement <4 x double> %290, i32 2
  %292 = load <4 x double>* %tempA2, align 32
  %293 = extractelement <4 x double> %292, i32 1
  %294 = load <4 x double>* %tempB1, align 32
  %295 = extractelement <4 x double> %294, i32 2
  %mul181 = fmul double %293, %295
  %296 = call double @llvm.fmuladd.f64(double %289, double %291, double %mul181)
  %297 = load <4 x double>* %tempA2, align 32
  %298 = extractelement <4 x double> %297, i32 2
  %299 = load <4 x double>* %tempB2, align 32
  %300 = extractelement <4 x double> %299, i32 2
  %301 = call double @llvm.fmuladd.f64(double %298, double %300, double %296)
  %302 = load <4 x double>* %tempA2, align 32
  %303 = extractelement <4 x double> %302, i32 3
  %304 = load <4 x double>* %tempB3, align 32
  %305 = extractelement <4 x double> %304, i32 2
  %306 = call double @llvm.fmuladd.f64(double %303, double %305, double %301)
  %307 = load <4 x double>* %sum2, align 32
  %308 = extractelement <4 x double> %307, i32 2
  %add184 = fadd double %308, %306
  %309 = load <4 x double>* %sum2, align 32
  %310 = insertelement <4 x double> %309, double %add184, i32 2
  store <4 x double> %310, <4 x double>* %sum2, align 32
  %311 = load <4 x double>* %tempA2, align 32
  %312 = extractelement <4 x double> %311, i32 0
  %313 = load <4 x double>* %tempB0, align 32
  %314 = extractelement <4 x double> %313, i32 3
  %315 = load <4 x double>* %tempA2, align 32
  %316 = extractelement <4 x double> %315, i32 1
  %317 = load <4 x double>* %tempB1, align 32
  %318 = extractelement <4 x double> %317, i32 3
  %mul186 = fmul double %316, %318
  %319 = call double @llvm.fmuladd.f64(double %312, double %314, double %mul186)
  %320 = load <4 x double>* %tempA2, align 32
  %321 = extractelement <4 x double> %320, i32 2
  %322 = load <4 x double>* %tempB2, align 32
  %323 = extractelement <4 x double> %322, i32 3
  %324 = call double @llvm.fmuladd.f64(double %321, double %323, double %319)
  %325 = load <4 x double>* %tempA2, align 32
  %326 = extractelement <4 x double> %325, i32 3
  %327 = load <4 x double>* %tempB3, align 32
  %328 = extractelement <4 x double> %327, i32 3
  %329 = call double @llvm.fmuladd.f64(double %326, double %328, double %324)
  %330 = load <4 x double>* %sum2, align 32
  %331 = extractelement <4 x double> %330, i32 3
  %add189 = fadd double %331, %329
  %332 = load <4 x double>* %sum2, align 32
  %333 = insertelement <4 x double> %332, double %add189, i32 3
  store <4 x double> %333, <4 x double>* %sum2, align 32
  %334 = load <4 x double>* %tempA3, align 32
  %335 = extractelement <4 x double> %334, i32 0
  %336 = load <4 x double>* %tempB0, align 32
  %337 = extractelement <4 x double> %336, i32 0
  %338 = load <4 x double>* %tempA3, align 32
  %339 = extractelement <4 x double> %338, i32 1
  %340 = load <4 x double>* %tempB1, align 32
  %341 = extractelement <4 x double> %340, i32 0
  %mul191 = fmul double %339, %341
  %342 = call double @llvm.fmuladd.f64(double %335, double %337, double %mul191)
  %343 = load <4 x double>* %tempA3, align 32
  %344 = extractelement <4 x double> %343, i32 2
  %345 = load <4 x double>* %tempB2, align 32
  %346 = extractelement <4 x double> %345, i32 0
  %347 = call double @llvm.fmuladd.f64(double %344, double %346, double %342)
  %348 = load <4 x double>* %tempA3, align 32
  %349 = extractelement <4 x double> %348, i32 3
  %350 = load <4 x double>* %tempB3, align 32
  %351 = extractelement <4 x double> %350, i32 0
  %352 = call double @llvm.fmuladd.f64(double %349, double %351, double %347)
  %353 = load <4 x double>* %sum3, align 32
  %354 = extractelement <4 x double> %353, i32 0
  %add194 = fadd double %354, %352
  %355 = load <4 x double>* %sum3, align 32
  %356 = insertelement <4 x double> %355, double %add194, i32 0
  store <4 x double> %356, <4 x double>* %sum3, align 32
  %357 = load <4 x double>* %tempA3, align 32
  %358 = extractelement <4 x double> %357, i32 0
  %359 = load <4 x double>* %tempB0, align 32
  %360 = extractelement <4 x double> %359, i32 1
  %361 = load <4 x double>* %tempA3, align 32
  %362 = extractelement <4 x double> %361, i32 1
  %363 = load <4 x double>* %tempB1, align 32
  %364 = extractelement <4 x double> %363, i32 1
  %mul196 = fmul double %362, %364
  %365 = call double @llvm.fmuladd.f64(double %358, double %360, double %mul196)
  %366 = load <4 x double>* %tempA3, align 32
  %367 = extractelement <4 x double> %366, i32 2
  %368 = load <4 x double>* %tempB2, align 32
  %369 = extractelement <4 x double> %368, i32 1
  %370 = call double @llvm.fmuladd.f64(double %367, double %369, double %365)
  %371 = load <4 x double>* %tempA3, align 32
  %372 = extractelement <4 x double> %371, i32 3
  %373 = load <4 x double>* %tempB3, align 32
  %374 = extractelement <4 x double> %373, i32 1
  %375 = call double @llvm.fmuladd.f64(double %372, double %374, double %370)
  %376 = load <4 x double>* %sum3, align 32
  %377 = extractelement <4 x double> %376, i32 1
  %add199 = fadd double %377, %375
  %378 = load <4 x double>* %sum3, align 32
  %379 = insertelement <4 x double> %378, double %add199, i32 1
  store <4 x double> %379, <4 x double>* %sum3, align 32
  %380 = load <4 x double>* %tempA3, align 32
  %381 = extractelement <4 x double> %380, i32 0
  %382 = load <4 x double>* %tempB0, align 32
  %383 = extractelement <4 x double> %382, i32 2
  %384 = load <4 x double>* %tempA3, align 32
  %385 = extractelement <4 x double> %384, i32 1
  %386 = load <4 x double>* %tempB1, align 32
  %387 = extractelement <4 x double> %386, i32 2
  %mul201 = fmul double %385, %387
  %388 = call double @llvm.fmuladd.f64(double %381, double %383, double %mul201)
  %389 = load <4 x double>* %tempA3, align 32
  %390 = extractelement <4 x double> %389, i32 2
  %391 = load <4 x double>* %tempB2, align 32
  %392 = extractelement <4 x double> %391, i32 2
  %393 = call double @llvm.fmuladd.f64(double %390, double %392, double %388)
  %394 = load <4 x double>* %tempA3, align 32
  %395 = extractelement <4 x double> %394, i32 3
  %396 = load <4 x double>* %tempB3, align 32
  %397 = extractelement <4 x double> %396, i32 2
  %398 = call double @llvm.fmuladd.f64(double %395, double %397, double %393)
  %399 = load <4 x double>* %sum3, align 32
  %400 = extractelement <4 x double> %399, i32 2
  %add204 = fadd double %400, %398
  %401 = load <4 x double>* %sum3, align 32
  %402 = insertelement <4 x double> %401, double %add204, i32 2
  store <4 x double> %402, <4 x double>* %sum3, align 32
  %403 = load <4 x double>* %tempA3, align 32
  %404 = extractelement <4 x double> %403, i32 0
  %405 = load <4 x double>* %tempB0, align 32
  %406 = extractelement <4 x double> %405, i32 3
  %407 = load <4 x double>* %tempA3, align 32
  %408 = extractelement <4 x double> %407, i32 1
  %409 = load <4 x double>* %tempB1, align 32
  %410 = extractelement <4 x double> %409, i32 3
  %mul206 = fmul double %408, %410
  %411 = call double @llvm.fmuladd.f64(double %404, double %406, double %mul206)
  %412 = load <4 x double>* %tempA3, align 32
  %413 = extractelement <4 x double> %412, i32 2
  %414 = load <4 x double>* %tempB2, align 32
  %415 = extractelement <4 x double> %414, i32 3
  %416 = call double @llvm.fmuladd.f64(double %413, double %415, double %411)
  %417 = load <4 x double>* %tempA3, align 32
  %418 = extractelement <4 x double> %417, i32 3
  %419 = load <4 x double>* %tempB3, align 32
  %420 = extractelement <4 x double> %419, i32 3
  %421 = call double @llvm.fmuladd.f64(double %418, double %420, double %416)
  %422 = load <4 x double>* %sum3, align 32
  %423 = extractelement <4 x double> %422, i32 3
  %add209 = fadd double %423, %421
  %424 = load <4 x double>* %sum3, align 32
  %425 = insertelement <4 x double> %424, double %add209, i32 3
  store <4 x double> %425, <4 x double>* %sum3, align 32
  br label %for.inc

for.inc:                                          ; preds = %for.body68
  %426 = load i32* %j, align 4
  %add210 = add nsw i32 %426, 4
  store i32 %add210, i32* %j, align 4
  br label %for.cond62

for.end:                                          ; preds = %for.cond62
  call cc75 void @_Z7barrierj(i32 1)
  br label %for.inc211

for.inc211:                                       ; preds = %for.end
  %427 = load i32* %i, align 4
  %inc = add nsw i32 %427, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end212:                                       ; preds = %for.cond
  %428 = load <4 x double>* %sum0, align 32
  %429 = load i32* %globalPos, align 4
  %idxprom213 = sext i32 %429 to i64
  %430 = load <4 x double> addrspace(1)** %matrixC.addr, align 8
  %arrayidx214 = getelementptr inbounds <4 x double> addrspace(1)* %430, i64 %idxprom213
  store <4 x double> %428, <4 x double> addrspace(1)* %arrayidx214, align 32
  %431 = load <4 x double>* %sum1, align 32
  %432 = load i32* %globalPos, align 4
  %conv215 = sext i32 %432 to i64
  %call216 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %add217 = add i64 %conv215, %call216
  %433 = load <4 x double> addrspace(1)** %matrixC.addr, align 8
  %arrayidx218 = getelementptr inbounds <4 x double> addrspace(1)* %433, i64 %add217
  store <4 x double> %431, <4 x double> addrspace(1)* %arrayidx218, align 32
  %434 = load <4 x double>* %sum2, align 32
  %435 = load i32* %globalPos, align 4
  %conv219 = sext i32 %435 to i64
  %call220 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul221 = mul i64 2, %call220
  %add222 = add i64 %conv219, %mul221
  %436 = load <4 x double> addrspace(1)** %matrixC.addr, align 8
  %arrayidx223 = getelementptr inbounds <4 x double> addrspace(1)* %436, i64 %add222
  store <4 x double> %434, <4 x double> addrspace(1)* %arrayidx223, align 32
  %437 = load <4 x double>* %sum3, align 32
  %438 = load i32* %globalPos, align 4
  %conv224 = sext i32 %438 to i64
  %call225 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul226 = mul i64 3, %call225
  %add227 = add i64 %conv224, %mul226
  %439 = load <4 x double> addrspace(1)** %matrixC.addr, align 8
  %arrayidx228 = getelementptr inbounds <4 x double> addrspace(1)* %439, i64 %add227
  store <4 x double> %437, <4 x double> addrspace(1)* %arrayidx228, align 32
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z15get_global_sizej(i32) #1

declare cc75 void @_Z7barrierj(i32)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!10}
!opencl.spir.version = !{!10}

!0 = metadata !{void (<4 x double> addrspace(1)*, <4 x double> addrspace(1)*, <4 x double> addrspace(1)*, i32, i32)* @__OpenCL_mmmKernel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"double4*", metadata !"double4*", metadata !"double4*", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"double4*", metadata !"double4*", metadata !"double4*", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (<4 x double> addrspace(1)*, <4 x double> addrspace(1)*, <4 x double> addrspace(1)*, i32, <4 x double> addrspace(3)*)* @__OpenCL_mmmKernel_local_kernel, metadata !7, metadata !2, metadata !8, metadata !4, metadata !9}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 3}
!8 = metadata !{metadata !"kernel_arg_type", metadata !"double4*", metadata !"double4*", metadata !"double4*", metadata !"int", metadata !"double4*"}
!9 = metadata !{metadata !"kernel_arg_base_type", metadata !"double4*", metadata !"double4*", metadata !"double4*", metadata !"int", metadata !"double4*"}
!10 = metadata !{i32 1, i32 2}

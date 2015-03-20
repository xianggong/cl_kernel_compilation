; ModuleID = 'MatrixMultiplication_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_mmmKernel_kernel(<4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)* %matrixC, i32 %widthA, i32 %widthB) #0 {
entry:
  %matrixA.addr = alloca <4 x float> addrspace(1)*, align 8
  %matrixB.addr = alloca <4 x float> addrspace(1)*, align 8
  %matrixC.addr = alloca <4 x float> addrspace(1)*, align 8
  %widthA.addr = alloca i32, align 4
  %widthB.addr = alloca i32, align 4
  %pos = alloca <2 x i32>, align 8
  %.compoundliteral = alloca <2 x i32>, align 8
  %sum0 = alloca <4 x float>, align 16
  %sum1 = alloca <4 x float>, align 16
  %sum2 = alloca <4 x float>, align 16
  %sum3 = alloca <4 x float>, align 16
  %i = alloca i32, align 4
  %tempA0 = alloca <4 x float>, align 16
  %tempA1 = alloca <4 x float>, align 16
  %tempA2 = alloca <4 x float>, align 16
  %tempA3 = alloca <4 x float>, align 16
  %tempB0 = alloca <4 x float>, align 16
  %tempB1 = alloca <4 x float>, align 16
  %tempB2 = alloca <4 x float>, align 16
  %tempB3 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)** %matrixA.addr, align 8
  store <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)** %matrixB.addr, align 8
  store <4 x float> addrspace(1)* %matrixC, <4 x float> addrspace(1)** %matrixC.addr, align 8
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
  store <4 x float> zeroinitializer, <4 x float>* %sum0, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum3, align 16
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
  %8 = load <4 x float> addrspace(1)** %matrixA.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %8, i64 %idxprom
  %9 = load <4 x float> addrspace(1)* %arrayidx, align 16
  store <4 x float> %9, <4 x float>* %tempA0, align 16
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
  %14 = load <4 x float> addrspace(1)** %matrixA.addr, align 8
  %arrayidx14 = getelementptr inbounds <4 x float> addrspace(1)* %14, i64 %idxprom13
  %15 = load <4 x float> addrspace(1)* %arrayidx14, align 16
  store <4 x float> %15, <4 x float>* %tempA1, align 16
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
  %20 = load <4 x float> addrspace(1)** %matrixA.addr, align 8
  %arrayidx22 = getelementptr inbounds <4 x float> addrspace(1)* %20, i64 %idxprom21
  %21 = load <4 x float> addrspace(1)* %arrayidx22, align 16
  store <4 x float> %21, <4 x float>* %tempA2, align 16
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
  %26 = load <4 x float> addrspace(1)** %matrixA.addr, align 8
  %arrayidx30 = getelementptr inbounds <4 x float> addrspace(1)* %26, i64 %idxprom29
  %27 = load <4 x float> addrspace(1)* %arrayidx30, align 16
  store <4 x float> %27, <4 x float>* %tempA3, align 16
  %28 = load <2 x i32>* %pos, align 8
  %29 = extractelement <2 x i32> %28, i32 0
  %30 = load i32* %i, align 4
  %31 = load i32* %widthB.addr, align 4
  %mul31 = mul i32 %30, %31
  %add32 = add i32 %29, %mul31
  %idxprom33 = zext i32 %add32 to i64
  %32 = load <4 x float> addrspace(1)** %matrixB.addr, align 8
  %arrayidx34 = getelementptr inbounds <4 x float> addrspace(1)* %32, i64 %idxprom33
  %33 = load <4 x float> addrspace(1)* %arrayidx34, align 16
  store <4 x float> %33, <4 x float>* %tempB0, align 16
  %34 = load <2 x i32>* %pos, align 8
  %35 = extractelement <2 x i32> %34, i32 0
  %36 = load i32* %i, align 4
  %add35 = add nsw i32 %36, 1
  %37 = load i32* %widthB.addr, align 4
  %mul36 = mul i32 %add35, %37
  %add37 = add i32 %35, %mul36
  %idxprom38 = zext i32 %add37 to i64
  %38 = load <4 x float> addrspace(1)** %matrixB.addr, align 8
  %arrayidx39 = getelementptr inbounds <4 x float> addrspace(1)* %38, i64 %idxprom38
  %39 = load <4 x float> addrspace(1)* %arrayidx39, align 16
  store <4 x float> %39, <4 x float>* %tempB1, align 16
  %40 = load <2 x i32>* %pos, align 8
  %41 = extractelement <2 x i32> %40, i32 0
  %42 = load i32* %i, align 4
  %add40 = add nsw i32 %42, 2
  %43 = load i32* %widthB.addr, align 4
  %mul41 = mul i32 %add40, %43
  %add42 = add i32 %41, %mul41
  %idxprom43 = zext i32 %add42 to i64
  %44 = load <4 x float> addrspace(1)** %matrixB.addr, align 8
  %arrayidx44 = getelementptr inbounds <4 x float> addrspace(1)* %44, i64 %idxprom43
  %45 = load <4 x float> addrspace(1)* %arrayidx44, align 16
  store <4 x float> %45, <4 x float>* %tempB2, align 16
  %46 = load <2 x i32>* %pos, align 8
  %47 = extractelement <2 x i32> %46, i32 0
  %48 = load i32* %i, align 4
  %add45 = add nsw i32 %48, 3
  %49 = load i32* %widthB.addr, align 4
  %mul46 = mul i32 %add45, %49
  %add47 = add i32 %47, %mul46
  %idxprom48 = zext i32 %add47 to i64
  %50 = load <4 x float> addrspace(1)** %matrixB.addr, align 8
  %arrayidx49 = getelementptr inbounds <4 x float> addrspace(1)* %50, i64 %idxprom48
  %51 = load <4 x float> addrspace(1)* %arrayidx49, align 16
  store <4 x float> %51, <4 x float>* %tempB3, align 16
  %52 = load <4 x float>* %tempA0, align 16
  %53 = extractelement <4 x float> %52, i32 0
  %54 = load <4 x float>* %tempB0, align 16
  %55 = extractelement <4 x float> %54, i32 0
  %56 = load <4 x float>* %tempA0, align 16
  %57 = extractelement <4 x float> %56, i32 1
  %58 = load <4 x float>* %tempB1, align 16
  %59 = extractelement <4 x float> %58, i32 0
  %mul51 = fmul float %57, %59
  %60 = call float @llvm.fmuladd.f32(float %53, float %55, float %mul51)
  %61 = load <4 x float>* %tempA0, align 16
  %62 = extractelement <4 x float> %61, i32 2
  %63 = load <4 x float>* %tempB2, align 16
  %64 = extractelement <4 x float> %63, i32 0
  %65 = call float @llvm.fmuladd.f32(float %62, float %64, float %60)
  %66 = load <4 x float>* %tempA0, align 16
  %67 = extractelement <4 x float> %66, i32 3
  %68 = load <4 x float>* %tempB3, align 16
  %69 = extractelement <4 x float> %68, i32 0
  %70 = call float @llvm.fmuladd.f32(float %67, float %69, float %65)
  %71 = load <4 x float>* %sum0, align 16
  %72 = extractelement <4 x float> %71, i32 0
  %add54 = fadd float %72, %70
  %73 = load <4 x float>* %sum0, align 16
  %74 = insertelement <4 x float> %73, float %add54, i32 0
  store <4 x float> %74, <4 x float>* %sum0, align 16
  %75 = load <4 x float>* %tempA0, align 16
  %76 = extractelement <4 x float> %75, i32 0
  %77 = load <4 x float>* %tempB0, align 16
  %78 = extractelement <4 x float> %77, i32 1
  %79 = load <4 x float>* %tempA0, align 16
  %80 = extractelement <4 x float> %79, i32 1
  %81 = load <4 x float>* %tempB1, align 16
  %82 = extractelement <4 x float> %81, i32 1
  %mul56 = fmul float %80, %82
  %83 = call float @llvm.fmuladd.f32(float %76, float %78, float %mul56)
  %84 = load <4 x float>* %tempA0, align 16
  %85 = extractelement <4 x float> %84, i32 2
  %86 = load <4 x float>* %tempB2, align 16
  %87 = extractelement <4 x float> %86, i32 1
  %88 = call float @llvm.fmuladd.f32(float %85, float %87, float %83)
  %89 = load <4 x float>* %tempA0, align 16
  %90 = extractelement <4 x float> %89, i32 3
  %91 = load <4 x float>* %tempB3, align 16
  %92 = extractelement <4 x float> %91, i32 1
  %93 = call float @llvm.fmuladd.f32(float %90, float %92, float %88)
  %94 = load <4 x float>* %sum0, align 16
  %95 = extractelement <4 x float> %94, i32 1
  %add59 = fadd float %95, %93
  %96 = load <4 x float>* %sum0, align 16
  %97 = insertelement <4 x float> %96, float %add59, i32 1
  store <4 x float> %97, <4 x float>* %sum0, align 16
  %98 = load <4 x float>* %tempA0, align 16
  %99 = extractelement <4 x float> %98, i32 0
  %100 = load <4 x float>* %tempB0, align 16
  %101 = extractelement <4 x float> %100, i32 2
  %102 = load <4 x float>* %tempA0, align 16
  %103 = extractelement <4 x float> %102, i32 1
  %104 = load <4 x float>* %tempB1, align 16
  %105 = extractelement <4 x float> %104, i32 2
  %mul61 = fmul float %103, %105
  %106 = call float @llvm.fmuladd.f32(float %99, float %101, float %mul61)
  %107 = load <4 x float>* %tempA0, align 16
  %108 = extractelement <4 x float> %107, i32 2
  %109 = load <4 x float>* %tempB2, align 16
  %110 = extractelement <4 x float> %109, i32 2
  %111 = call float @llvm.fmuladd.f32(float %108, float %110, float %106)
  %112 = load <4 x float>* %tempA0, align 16
  %113 = extractelement <4 x float> %112, i32 3
  %114 = load <4 x float>* %tempB3, align 16
  %115 = extractelement <4 x float> %114, i32 2
  %116 = call float @llvm.fmuladd.f32(float %113, float %115, float %111)
  %117 = load <4 x float>* %sum0, align 16
  %118 = extractelement <4 x float> %117, i32 2
  %add64 = fadd float %118, %116
  %119 = load <4 x float>* %sum0, align 16
  %120 = insertelement <4 x float> %119, float %add64, i32 2
  store <4 x float> %120, <4 x float>* %sum0, align 16
  %121 = load <4 x float>* %tempA0, align 16
  %122 = extractelement <4 x float> %121, i32 0
  %123 = load <4 x float>* %tempB0, align 16
  %124 = extractelement <4 x float> %123, i32 3
  %125 = load <4 x float>* %tempA0, align 16
  %126 = extractelement <4 x float> %125, i32 1
  %127 = load <4 x float>* %tempB1, align 16
  %128 = extractelement <4 x float> %127, i32 3
  %mul66 = fmul float %126, %128
  %129 = call float @llvm.fmuladd.f32(float %122, float %124, float %mul66)
  %130 = load <4 x float>* %tempA0, align 16
  %131 = extractelement <4 x float> %130, i32 2
  %132 = load <4 x float>* %tempB2, align 16
  %133 = extractelement <4 x float> %132, i32 3
  %134 = call float @llvm.fmuladd.f32(float %131, float %133, float %129)
  %135 = load <4 x float>* %tempA0, align 16
  %136 = extractelement <4 x float> %135, i32 3
  %137 = load <4 x float>* %tempB3, align 16
  %138 = extractelement <4 x float> %137, i32 3
  %139 = call float @llvm.fmuladd.f32(float %136, float %138, float %134)
  %140 = load <4 x float>* %sum0, align 16
  %141 = extractelement <4 x float> %140, i32 3
  %add69 = fadd float %141, %139
  %142 = load <4 x float>* %sum0, align 16
  %143 = insertelement <4 x float> %142, float %add69, i32 3
  store <4 x float> %143, <4 x float>* %sum0, align 16
  %144 = load <4 x float>* %tempA1, align 16
  %145 = extractelement <4 x float> %144, i32 0
  %146 = load <4 x float>* %tempB0, align 16
  %147 = extractelement <4 x float> %146, i32 0
  %148 = load <4 x float>* %tempA1, align 16
  %149 = extractelement <4 x float> %148, i32 1
  %150 = load <4 x float>* %tempB1, align 16
  %151 = extractelement <4 x float> %150, i32 0
  %mul71 = fmul float %149, %151
  %152 = call float @llvm.fmuladd.f32(float %145, float %147, float %mul71)
  %153 = load <4 x float>* %tempA1, align 16
  %154 = extractelement <4 x float> %153, i32 2
  %155 = load <4 x float>* %tempB2, align 16
  %156 = extractelement <4 x float> %155, i32 0
  %157 = call float @llvm.fmuladd.f32(float %154, float %156, float %152)
  %158 = load <4 x float>* %tempA1, align 16
  %159 = extractelement <4 x float> %158, i32 3
  %160 = load <4 x float>* %tempB3, align 16
  %161 = extractelement <4 x float> %160, i32 0
  %162 = call float @llvm.fmuladd.f32(float %159, float %161, float %157)
  %163 = load <4 x float>* %sum1, align 16
  %164 = extractelement <4 x float> %163, i32 0
  %add74 = fadd float %164, %162
  %165 = load <4 x float>* %sum1, align 16
  %166 = insertelement <4 x float> %165, float %add74, i32 0
  store <4 x float> %166, <4 x float>* %sum1, align 16
  %167 = load <4 x float>* %tempA1, align 16
  %168 = extractelement <4 x float> %167, i32 0
  %169 = load <4 x float>* %tempB0, align 16
  %170 = extractelement <4 x float> %169, i32 1
  %171 = load <4 x float>* %tempA1, align 16
  %172 = extractelement <4 x float> %171, i32 1
  %173 = load <4 x float>* %tempB1, align 16
  %174 = extractelement <4 x float> %173, i32 1
  %mul76 = fmul float %172, %174
  %175 = call float @llvm.fmuladd.f32(float %168, float %170, float %mul76)
  %176 = load <4 x float>* %tempA1, align 16
  %177 = extractelement <4 x float> %176, i32 2
  %178 = load <4 x float>* %tempB2, align 16
  %179 = extractelement <4 x float> %178, i32 1
  %180 = call float @llvm.fmuladd.f32(float %177, float %179, float %175)
  %181 = load <4 x float>* %tempA1, align 16
  %182 = extractelement <4 x float> %181, i32 3
  %183 = load <4 x float>* %tempB3, align 16
  %184 = extractelement <4 x float> %183, i32 1
  %185 = call float @llvm.fmuladd.f32(float %182, float %184, float %180)
  %186 = load <4 x float>* %sum1, align 16
  %187 = extractelement <4 x float> %186, i32 1
  %add79 = fadd float %187, %185
  %188 = load <4 x float>* %sum1, align 16
  %189 = insertelement <4 x float> %188, float %add79, i32 1
  store <4 x float> %189, <4 x float>* %sum1, align 16
  %190 = load <4 x float>* %tempA1, align 16
  %191 = extractelement <4 x float> %190, i32 0
  %192 = load <4 x float>* %tempB0, align 16
  %193 = extractelement <4 x float> %192, i32 2
  %194 = load <4 x float>* %tempA1, align 16
  %195 = extractelement <4 x float> %194, i32 1
  %196 = load <4 x float>* %tempB1, align 16
  %197 = extractelement <4 x float> %196, i32 2
  %mul81 = fmul float %195, %197
  %198 = call float @llvm.fmuladd.f32(float %191, float %193, float %mul81)
  %199 = load <4 x float>* %tempA1, align 16
  %200 = extractelement <4 x float> %199, i32 2
  %201 = load <4 x float>* %tempB2, align 16
  %202 = extractelement <4 x float> %201, i32 2
  %203 = call float @llvm.fmuladd.f32(float %200, float %202, float %198)
  %204 = load <4 x float>* %tempA1, align 16
  %205 = extractelement <4 x float> %204, i32 3
  %206 = load <4 x float>* %tempB3, align 16
  %207 = extractelement <4 x float> %206, i32 2
  %208 = call float @llvm.fmuladd.f32(float %205, float %207, float %203)
  %209 = load <4 x float>* %sum1, align 16
  %210 = extractelement <4 x float> %209, i32 2
  %add84 = fadd float %210, %208
  %211 = load <4 x float>* %sum1, align 16
  %212 = insertelement <4 x float> %211, float %add84, i32 2
  store <4 x float> %212, <4 x float>* %sum1, align 16
  %213 = load <4 x float>* %tempA1, align 16
  %214 = extractelement <4 x float> %213, i32 0
  %215 = load <4 x float>* %tempB0, align 16
  %216 = extractelement <4 x float> %215, i32 3
  %217 = load <4 x float>* %tempA1, align 16
  %218 = extractelement <4 x float> %217, i32 1
  %219 = load <4 x float>* %tempB1, align 16
  %220 = extractelement <4 x float> %219, i32 3
  %mul86 = fmul float %218, %220
  %221 = call float @llvm.fmuladd.f32(float %214, float %216, float %mul86)
  %222 = load <4 x float>* %tempA1, align 16
  %223 = extractelement <4 x float> %222, i32 2
  %224 = load <4 x float>* %tempB2, align 16
  %225 = extractelement <4 x float> %224, i32 3
  %226 = call float @llvm.fmuladd.f32(float %223, float %225, float %221)
  %227 = load <4 x float>* %tempA1, align 16
  %228 = extractelement <4 x float> %227, i32 3
  %229 = load <4 x float>* %tempB3, align 16
  %230 = extractelement <4 x float> %229, i32 3
  %231 = call float @llvm.fmuladd.f32(float %228, float %230, float %226)
  %232 = load <4 x float>* %sum1, align 16
  %233 = extractelement <4 x float> %232, i32 3
  %add89 = fadd float %233, %231
  %234 = load <4 x float>* %sum1, align 16
  %235 = insertelement <4 x float> %234, float %add89, i32 3
  store <4 x float> %235, <4 x float>* %sum1, align 16
  %236 = load <4 x float>* %tempA2, align 16
  %237 = extractelement <4 x float> %236, i32 0
  %238 = load <4 x float>* %tempB0, align 16
  %239 = extractelement <4 x float> %238, i32 0
  %240 = load <4 x float>* %tempA2, align 16
  %241 = extractelement <4 x float> %240, i32 1
  %242 = load <4 x float>* %tempB1, align 16
  %243 = extractelement <4 x float> %242, i32 0
  %mul91 = fmul float %241, %243
  %244 = call float @llvm.fmuladd.f32(float %237, float %239, float %mul91)
  %245 = load <4 x float>* %tempA2, align 16
  %246 = extractelement <4 x float> %245, i32 2
  %247 = load <4 x float>* %tempB2, align 16
  %248 = extractelement <4 x float> %247, i32 0
  %249 = call float @llvm.fmuladd.f32(float %246, float %248, float %244)
  %250 = load <4 x float>* %tempA2, align 16
  %251 = extractelement <4 x float> %250, i32 3
  %252 = load <4 x float>* %tempB3, align 16
  %253 = extractelement <4 x float> %252, i32 0
  %254 = call float @llvm.fmuladd.f32(float %251, float %253, float %249)
  %255 = load <4 x float>* %sum2, align 16
  %256 = extractelement <4 x float> %255, i32 0
  %add94 = fadd float %256, %254
  %257 = load <4 x float>* %sum2, align 16
  %258 = insertelement <4 x float> %257, float %add94, i32 0
  store <4 x float> %258, <4 x float>* %sum2, align 16
  %259 = load <4 x float>* %tempA2, align 16
  %260 = extractelement <4 x float> %259, i32 0
  %261 = load <4 x float>* %tempB0, align 16
  %262 = extractelement <4 x float> %261, i32 1
  %263 = load <4 x float>* %tempA2, align 16
  %264 = extractelement <4 x float> %263, i32 1
  %265 = load <4 x float>* %tempB1, align 16
  %266 = extractelement <4 x float> %265, i32 1
  %mul96 = fmul float %264, %266
  %267 = call float @llvm.fmuladd.f32(float %260, float %262, float %mul96)
  %268 = load <4 x float>* %tempA2, align 16
  %269 = extractelement <4 x float> %268, i32 2
  %270 = load <4 x float>* %tempB2, align 16
  %271 = extractelement <4 x float> %270, i32 1
  %272 = call float @llvm.fmuladd.f32(float %269, float %271, float %267)
  %273 = load <4 x float>* %tempA2, align 16
  %274 = extractelement <4 x float> %273, i32 3
  %275 = load <4 x float>* %tempB3, align 16
  %276 = extractelement <4 x float> %275, i32 1
  %277 = call float @llvm.fmuladd.f32(float %274, float %276, float %272)
  %278 = load <4 x float>* %sum2, align 16
  %279 = extractelement <4 x float> %278, i32 1
  %add99 = fadd float %279, %277
  %280 = load <4 x float>* %sum2, align 16
  %281 = insertelement <4 x float> %280, float %add99, i32 1
  store <4 x float> %281, <4 x float>* %sum2, align 16
  %282 = load <4 x float>* %tempA2, align 16
  %283 = extractelement <4 x float> %282, i32 0
  %284 = load <4 x float>* %tempB0, align 16
  %285 = extractelement <4 x float> %284, i32 2
  %286 = load <4 x float>* %tempA2, align 16
  %287 = extractelement <4 x float> %286, i32 1
  %288 = load <4 x float>* %tempB1, align 16
  %289 = extractelement <4 x float> %288, i32 2
  %mul101 = fmul float %287, %289
  %290 = call float @llvm.fmuladd.f32(float %283, float %285, float %mul101)
  %291 = load <4 x float>* %tempA2, align 16
  %292 = extractelement <4 x float> %291, i32 2
  %293 = load <4 x float>* %tempB2, align 16
  %294 = extractelement <4 x float> %293, i32 2
  %295 = call float @llvm.fmuladd.f32(float %292, float %294, float %290)
  %296 = load <4 x float>* %tempA2, align 16
  %297 = extractelement <4 x float> %296, i32 3
  %298 = load <4 x float>* %tempB3, align 16
  %299 = extractelement <4 x float> %298, i32 2
  %300 = call float @llvm.fmuladd.f32(float %297, float %299, float %295)
  %301 = load <4 x float>* %sum2, align 16
  %302 = extractelement <4 x float> %301, i32 2
  %add104 = fadd float %302, %300
  %303 = load <4 x float>* %sum2, align 16
  %304 = insertelement <4 x float> %303, float %add104, i32 2
  store <4 x float> %304, <4 x float>* %sum2, align 16
  %305 = load <4 x float>* %tempA2, align 16
  %306 = extractelement <4 x float> %305, i32 0
  %307 = load <4 x float>* %tempB0, align 16
  %308 = extractelement <4 x float> %307, i32 3
  %309 = load <4 x float>* %tempA2, align 16
  %310 = extractelement <4 x float> %309, i32 1
  %311 = load <4 x float>* %tempB1, align 16
  %312 = extractelement <4 x float> %311, i32 3
  %mul106 = fmul float %310, %312
  %313 = call float @llvm.fmuladd.f32(float %306, float %308, float %mul106)
  %314 = load <4 x float>* %tempA2, align 16
  %315 = extractelement <4 x float> %314, i32 2
  %316 = load <4 x float>* %tempB2, align 16
  %317 = extractelement <4 x float> %316, i32 3
  %318 = call float @llvm.fmuladd.f32(float %315, float %317, float %313)
  %319 = load <4 x float>* %tempA2, align 16
  %320 = extractelement <4 x float> %319, i32 3
  %321 = load <4 x float>* %tempB3, align 16
  %322 = extractelement <4 x float> %321, i32 3
  %323 = call float @llvm.fmuladd.f32(float %320, float %322, float %318)
  %324 = load <4 x float>* %sum2, align 16
  %325 = extractelement <4 x float> %324, i32 3
  %add109 = fadd float %325, %323
  %326 = load <4 x float>* %sum2, align 16
  %327 = insertelement <4 x float> %326, float %add109, i32 3
  store <4 x float> %327, <4 x float>* %sum2, align 16
  %328 = load <4 x float>* %tempA3, align 16
  %329 = extractelement <4 x float> %328, i32 0
  %330 = load <4 x float>* %tempB0, align 16
  %331 = extractelement <4 x float> %330, i32 0
  %332 = load <4 x float>* %tempA3, align 16
  %333 = extractelement <4 x float> %332, i32 1
  %334 = load <4 x float>* %tempB1, align 16
  %335 = extractelement <4 x float> %334, i32 0
  %mul111 = fmul float %333, %335
  %336 = call float @llvm.fmuladd.f32(float %329, float %331, float %mul111)
  %337 = load <4 x float>* %tempA3, align 16
  %338 = extractelement <4 x float> %337, i32 2
  %339 = load <4 x float>* %tempB2, align 16
  %340 = extractelement <4 x float> %339, i32 0
  %341 = call float @llvm.fmuladd.f32(float %338, float %340, float %336)
  %342 = load <4 x float>* %tempA3, align 16
  %343 = extractelement <4 x float> %342, i32 3
  %344 = load <4 x float>* %tempB3, align 16
  %345 = extractelement <4 x float> %344, i32 0
  %346 = call float @llvm.fmuladd.f32(float %343, float %345, float %341)
  %347 = load <4 x float>* %sum3, align 16
  %348 = extractelement <4 x float> %347, i32 0
  %add114 = fadd float %348, %346
  %349 = load <4 x float>* %sum3, align 16
  %350 = insertelement <4 x float> %349, float %add114, i32 0
  store <4 x float> %350, <4 x float>* %sum3, align 16
  %351 = load <4 x float>* %tempA3, align 16
  %352 = extractelement <4 x float> %351, i32 0
  %353 = load <4 x float>* %tempB0, align 16
  %354 = extractelement <4 x float> %353, i32 1
  %355 = load <4 x float>* %tempA3, align 16
  %356 = extractelement <4 x float> %355, i32 1
  %357 = load <4 x float>* %tempB1, align 16
  %358 = extractelement <4 x float> %357, i32 1
  %mul116 = fmul float %356, %358
  %359 = call float @llvm.fmuladd.f32(float %352, float %354, float %mul116)
  %360 = load <4 x float>* %tempA3, align 16
  %361 = extractelement <4 x float> %360, i32 2
  %362 = load <4 x float>* %tempB2, align 16
  %363 = extractelement <4 x float> %362, i32 1
  %364 = call float @llvm.fmuladd.f32(float %361, float %363, float %359)
  %365 = load <4 x float>* %tempA3, align 16
  %366 = extractelement <4 x float> %365, i32 3
  %367 = load <4 x float>* %tempB3, align 16
  %368 = extractelement <4 x float> %367, i32 1
  %369 = call float @llvm.fmuladd.f32(float %366, float %368, float %364)
  %370 = load <4 x float>* %sum3, align 16
  %371 = extractelement <4 x float> %370, i32 1
  %add119 = fadd float %371, %369
  %372 = load <4 x float>* %sum3, align 16
  %373 = insertelement <4 x float> %372, float %add119, i32 1
  store <4 x float> %373, <4 x float>* %sum3, align 16
  %374 = load <4 x float>* %tempA3, align 16
  %375 = extractelement <4 x float> %374, i32 0
  %376 = load <4 x float>* %tempB0, align 16
  %377 = extractelement <4 x float> %376, i32 2
  %378 = load <4 x float>* %tempA3, align 16
  %379 = extractelement <4 x float> %378, i32 1
  %380 = load <4 x float>* %tempB1, align 16
  %381 = extractelement <4 x float> %380, i32 2
  %mul121 = fmul float %379, %381
  %382 = call float @llvm.fmuladd.f32(float %375, float %377, float %mul121)
  %383 = load <4 x float>* %tempA3, align 16
  %384 = extractelement <4 x float> %383, i32 2
  %385 = load <4 x float>* %tempB2, align 16
  %386 = extractelement <4 x float> %385, i32 2
  %387 = call float @llvm.fmuladd.f32(float %384, float %386, float %382)
  %388 = load <4 x float>* %tempA3, align 16
  %389 = extractelement <4 x float> %388, i32 3
  %390 = load <4 x float>* %tempB3, align 16
  %391 = extractelement <4 x float> %390, i32 2
  %392 = call float @llvm.fmuladd.f32(float %389, float %391, float %387)
  %393 = load <4 x float>* %sum3, align 16
  %394 = extractelement <4 x float> %393, i32 2
  %add124 = fadd float %394, %392
  %395 = load <4 x float>* %sum3, align 16
  %396 = insertelement <4 x float> %395, float %add124, i32 2
  store <4 x float> %396, <4 x float>* %sum3, align 16
  %397 = load <4 x float>* %tempA3, align 16
  %398 = extractelement <4 x float> %397, i32 0
  %399 = load <4 x float>* %tempB0, align 16
  %400 = extractelement <4 x float> %399, i32 3
  %401 = load <4 x float>* %tempA3, align 16
  %402 = extractelement <4 x float> %401, i32 1
  %403 = load <4 x float>* %tempB1, align 16
  %404 = extractelement <4 x float> %403, i32 3
  %mul126 = fmul float %402, %404
  %405 = call float @llvm.fmuladd.f32(float %398, float %400, float %mul126)
  %406 = load <4 x float>* %tempA3, align 16
  %407 = extractelement <4 x float> %406, i32 2
  %408 = load <4 x float>* %tempB2, align 16
  %409 = extractelement <4 x float> %408, i32 3
  %410 = call float @llvm.fmuladd.f32(float %407, float %409, float %405)
  %411 = load <4 x float>* %tempA3, align 16
  %412 = extractelement <4 x float> %411, i32 3
  %413 = load <4 x float>* %tempB3, align 16
  %414 = extractelement <4 x float> %413, i32 3
  %415 = call float @llvm.fmuladd.f32(float %412, float %414, float %410)
  %416 = load <4 x float>* %sum3, align 16
  %417 = extractelement <4 x float> %416, i32 3
  %add129 = fadd float %417, %415
  %418 = load <4 x float>* %sum3, align 16
  %419 = insertelement <4 x float> %418, float %add129, i32 3
  store <4 x float> %419, <4 x float>* %sum3, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %420 = load i32* %i, align 4
  %add130 = add nsw i32 %420, 4
  store i32 %add130, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %421 = load <4 x float>* %sum0, align 16
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
  %427 = load <4 x float> addrspace(1)** %matrixC.addr, align 8
  %arrayidx136 = getelementptr inbounds <4 x float> addrspace(1)* %427, i64 %idxprom135
  store <4 x float> %421, <4 x float> addrspace(1)* %arrayidx136, align 16
  %428 = load <4 x float>* %sum1, align 16
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
  %434 = load <4 x float> addrspace(1)** %matrixC.addr, align 8
  %arrayidx142 = getelementptr inbounds <4 x float> addrspace(1)* %434, i64 %idxprom141
  store <4 x float> %428, <4 x float> addrspace(1)* %arrayidx142, align 16
  %435 = load <4 x float>* %sum2, align 16
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
  %441 = load <4 x float> addrspace(1)** %matrixC.addr, align 8
  %arrayidx148 = getelementptr inbounds <4 x float> addrspace(1)* %441, i64 %idxprom147
  store <4 x float> %435, <4 x float> addrspace(1)* %arrayidx148, align 16
  %442 = load <4 x float>* %sum3, align 16
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
  %448 = load <4 x float> addrspace(1)** %matrixC.addr, align 8
  %arrayidx154 = getelementptr inbounds <4 x float> addrspace(1)* %448, i64 %idxprom153
  store <4 x float> %442, <4 x float> addrspace(1)* %arrayidx154, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nounwind
define cc76 void @__OpenCL_mmmKernel_local_kernel(<4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)* %matrixC, i32 %widthA, <4 x float> addrspace(3)* %blockA) #0 {
entry:
  %matrixA.addr = alloca <4 x float> addrspace(1)*, align 8
  %matrixB.addr = alloca <4 x float> addrspace(1)*, align 8
  %matrixC.addr = alloca <4 x float> addrspace(1)*, align 8
  %widthA.addr = alloca i32, align 4
  %blockA.addr = alloca <4 x float> addrspace(3)*, align 8
  %blockPos = alloca i32, align 4
  %globalPos = alloca i32, align 4
  %sum0 = alloca <4 x float>, align 16
  %sum1 = alloca <4 x float>, align 16
  %sum2 = alloca <4 x float>, align 16
  %sum3 = alloca <4 x float>, align 16
  %temp = alloca i32, align 4
  %i = alloca i32, align 4
  %globalPosA = alloca i32, align 4
  %globalPosB = alloca i32, align 4
  %j = alloca i32, align 4
  %tempA0 = alloca <4 x float>, align 16
  %tempA1 = alloca <4 x float>, align 16
  %tempA2 = alloca <4 x float>, align 16
  %tempA3 = alloca <4 x float>, align 16
  %tempB0 = alloca <4 x float>, align 16
  %tempB1 = alloca <4 x float>, align 16
  %tempB2 = alloca <4 x float>, align 16
  %tempB3 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %matrixA, <4 x float> addrspace(1)** %matrixA.addr, align 8
  store <4 x float> addrspace(1)* %matrixB, <4 x float> addrspace(1)** %matrixB.addr, align 8
  store <4 x float> addrspace(1)* %matrixC, <4 x float> addrspace(1)** %matrixC.addr, align 8
  store i32 %widthA, i32* %widthA.addr, align 4
  store <4 x float> addrspace(3)* %blockA, <4 x float> addrspace(3)** %blockA.addr, align 8
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
  store <4 x float> zeroinitializer, <4 x float>* %sum0, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum1, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum2, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum3, align 16
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
  %6 = load <4 x float> addrspace(1)** %matrixA.addr, align 8
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %6, i64 %idxprom
  %7 = load <4 x float> addrspace(1)* %arrayidx, align 16
  %8 = load i32* %blockPos, align 4
  %idxprom26 = sext i32 %8 to i64
  %9 = load <4 x float> addrspace(3)** %blockA.addr, align 8
  %arrayidx27 = getelementptr inbounds <4 x float> addrspace(3)* %9, i64 %idxprom26
  store <4 x float> %7, <4 x float> addrspace(3)* %arrayidx27, align 16
  %10 = load i32* %globalPosA, align 4
  %11 = load i32* %temp, align 4
  %add28 = add nsw i32 %10, %11
  %idxprom29 = sext i32 %add28 to i64
  %12 = load <4 x float> addrspace(1)** %matrixA.addr, align 8
  %arrayidx30 = getelementptr inbounds <4 x float> addrspace(1)* %12, i64 %idxprom29
  %13 = load <4 x float> addrspace(1)* %arrayidx30, align 16
  %14 = load i32* %blockPos, align 4
  %conv31 = sext i32 %14 to i64
  %call32 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %add33 = add i64 %conv31, %call32
  %15 = load <4 x float> addrspace(3)** %blockA.addr, align 8
  %arrayidx34 = getelementptr inbounds <4 x float> addrspace(3)* %15, i64 %add33
  store <4 x float> %13, <4 x float> addrspace(3)* %arrayidx34, align 16
  %16 = load i32* %globalPosA, align 4
  %17 = load i32* %temp, align 4
  %mul35 = mul nsw i32 2, %17
  %add36 = add nsw i32 %16, %mul35
  %idxprom37 = sext i32 %add36 to i64
  %18 = load <4 x float> addrspace(1)** %matrixA.addr, align 8
  %arrayidx38 = getelementptr inbounds <4 x float> addrspace(1)* %18, i64 %idxprom37
  %19 = load <4 x float> addrspace(1)* %arrayidx38, align 16
  %20 = load i32* %blockPos, align 4
  %conv39 = sext i32 %20 to i64
  %call40 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul41 = mul i64 2, %call40
  %add42 = add i64 %conv39, %mul41
  %21 = load <4 x float> addrspace(3)** %blockA.addr, align 8
  %arrayidx43 = getelementptr inbounds <4 x float> addrspace(3)* %21, i64 %add42
  store <4 x float> %19, <4 x float> addrspace(3)* %arrayidx43, align 16
  %22 = load i32* %globalPosA, align 4
  %23 = load i32* %temp, align 4
  %mul44 = mul nsw i32 3, %23
  %add45 = add nsw i32 %22, %mul44
  %idxprom46 = sext i32 %add45 to i64
  %24 = load <4 x float> addrspace(1)** %matrixA.addr, align 8
  %arrayidx47 = getelementptr inbounds <4 x float> addrspace(1)* %24, i64 %idxprom46
  %25 = load <4 x float> addrspace(1)* %arrayidx47, align 16
  %26 = load i32* %blockPos, align 4
  %conv48 = sext i32 %26 to i64
  %call49 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul50 = mul i64 3, %call49
  %add51 = add i64 %conv48, %mul50
  %27 = load <4 x float> addrspace(3)** %blockA.addr, align 8
  %arrayidx52 = getelementptr inbounds <4 x float> addrspace(3)* %27, i64 %add51
  store <4 x float> %25, <4 x float> addrspace(3)* %arrayidx52, align 16
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
  %31 = load <4 x float> addrspace(3)** %blockA.addr, align 8
  %arrayidx75 = getelementptr inbounds <4 x float> addrspace(3)* %31, i64 %add74
  %32 = load <4 x float> addrspace(3)* %arrayidx75, align 16
  store <4 x float> %32, <4 x float>* %tempA0, align 16
  %33 = load i32* %j, align 4
  %shr76 = ashr i32 %33, 2
  %conv77 = sext i32 %shr76 to i64
  %call78 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %mul79 = mul i64 %call78, 4
  %add80 = add i64 %mul79, 1
  %call81 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul82 = mul i64 %add80, %call81
  %add83 = add i64 %conv77, %mul82
  %34 = load <4 x float> addrspace(3)** %blockA.addr, align 8
  %arrayidx84 = getelementptr inbounds <4 x float> addrspace(3)* %34, i64 %add83
  %35 = load <4 x float> addrspace(3)* %arrayidx84, align 16
  store <4 x float> %35, <4 x float>* %tempA1, align 16
  %36 = load i32* %j, align 4
  %shr85 = ashr i32 %36, 2
  %conv86 = sext i32 %shr85 to i64
  %call87 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %mul88 = mul i64 %call87, 4
  %add89 = add i64 %mul88, 2
  %call90 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul91 = mul i64 %add89, %call90
  %add92 = add i64 %conv86, %mul91
  %37 = load <4 x float> addrspace(3)** %blockA.addr, align 8
  %arrayidx93 = getelementptr inbounds <4 x float> addrspace(3)* %37, i64 %add92
  %38 = load <4 x float> addrspace(3)* %arrayidx93, align 16
  store <4 x float> %38, <4 x float>* %tempA2, align 16
  %39 = load i32* %j, align 4
  %shr94 = ashr i32 %39, 2
  %conv95 = sext i32 %shr94 to i64
  %call96 = call cc75 i64 @_Z12get_local_idj(i32 1) #1
  %mul97 = mul i64 %call96, 4
  %add98 = add i64 %mul97, 3
  %call99 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %mul100 = mul i64 %add98, %call99
  %add101 = add i64 %conv95, %mul100
  %40 = load <4 x float> addrspace(3)** %blockA.addr, align 8
  %arrayidx102 = getelementptr inbounds <4 x float> addrspace(3)* %40, i64 %add101
  %41 = load <4 x float> addrspace(3)* %arrayidx102, align 16
  store <4 x float> %41, <4 x float>* %tempA3, align 16
  %42 = load i32* %globalPosB, align 4
  %conv103 = sext i32 %42 to i64
  %43 = load i32* %j, align 4
  %conv104 = sext i32 %43 to i64
  %call105 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul106 = mul i64 %conv104, %call105
  %add107 = add i64 %conv103, %mul106
  %44 = load <4 x float> addrspace(1)** %matrixB.addr, align 8
  %arrayidx108 = getelementptr inbounds <4 x float> addrspace(1)* %44, i64 %add107
  %45 = load <4 x float> addrspace(1)* %arrayidx108, align 16
  store <4 x float> %45, <4 x float>* %tempB0, align 16
  %46 = load i32* %globalPosB, align 4
  %conv109 = sext i32 %46 to i64
  %47 = load i32* %j, align 4
  %add110 = add nsw i32 %47, 1
  %conv111 = sext i32 %add110 to i64
  %call112 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul113 = mul i64 %conv111, %call112
  %add114 = add i64 %conv109, %mul113
  %48 = load <4 x float> addrspace(1)** %matrixB.addr, align 8
  %arrayidx115 = getelementptr inbounds <4 x float> addrspace(1)* %48, i64 %add114
  %49 = load <4 x float> addrspace(1)* %arrayidx115, align 16
  store <4 x float> %49, <4 x float>* %tempB1, align 16
  %50 = load i32* %globalPosB, align 4
  %conv116 = sext i32 %50 to i64
  %51 = load i32* %j, align 4
  %add117 = add nsw i32 %51, 2
  %conv118 = sext i32 %add117 to i64
  %call119 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul120 = mul i64 %conv118, %call119
  %add121 = add i64 %conv116, %mul120
  %52 = load <4 x float> addrspace(1)** %matrixB.addr, align 8
  %arrayidx122 = getelementptr inbounds <4 x float> addrspace(1)* %52, i64 %add121
  %53 = load <4 x float> addrspace(1)* %arrayidx122, align 16
  store <4 x float> %53, <4 x float>* %tempB2, align 16
  %54 = load i32* %globalPosB, align 4
  %conv123 = sext i32 %54 to i64
  %55 = load i32* %j, align 4
  %add124 = add nsw i32 %55, 3
  %conv125 = sext i32 %add124 to i64
  %call126 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul127 = mul i64 %conv125, %call126
  %add128 = add i64 %conv123, %mul127
  %56 = load <4 x float> addrspace(1)** %matrixB.addr, align 8
  %arrayidx129 = getelementptr inbounds <4 x float> addrspace(1)* %56, i64 %add128
  %57 = load <4 x float> addrspace(1)* %arrayidx129, align 16
  store <4 x float> %57, <4 x float>* %tempB3, align 16
  %58 = load <4 x float>* %tempA0, align 16
  %59 = extractelement <4 x float> %58, i32 0
  %60 = load <4 x float>* %tempB0, align 16
  %61 = extractelement <4 x float> %60, i32 0
  %62 = load <4 x float>* %tempA0, align 16
  %63 = extractelement <4 x float> %62, i32 1
  %64 = load <4 x float>* %tempB1, align 16
  %65 = extractelement <4 x float> %64, i32 0
  %mul131 = fmul float %63, %65
  %66 = call float @llvm.fmuladd.f32(float %59, float %61, float %mul131)
  %67 = load <4 x float>* %tempA0, align 16
  %68 = extractelement <4 x float> %67, i32 2
  %69 = load <4 x float>* %tempB2, align 16
  %70 = extractelement <4 x float> %69, i32 0
  %71 = call float @llvm.fmuladd.f32(float %68, float %70, float %66)
  %72 = load <4 x float>* %tempA0, align 16
  %73 = extractelement <4 x float> %72, i32 3
  %74 = load <4 x float>* %tempB3, align 16
  %75 = extractelement <4 x float> %74, i32 0
  %76 = call float @llvm.fmuladd.f32(float %73, float %75, float %71)
  %77 = load <4 x float>* %sum0, align 16
  %78 = extractelement <4 x float> %77, i32 0
  %add134 = fadd float %78, %76
  %79 = load <4 x float>* %sum0, align 16
  %80 = insertelement <4 x float> %79, float %add134, i32 0
  store <4 x float> %80, <4 x float>* %sum0, align 16
  %81 = load <4 x float>* %tempA0, align 16
  %82 = extractelement <4 x float> %81, i32 0
  %83 = load <4 x float>* %tempB0, align 16
  %84 = extractelement <4 x float> %83, i32 1
  %85 = load <4 x float>* %tempA0, align 16
  %86 = extractelement <4 x float> %85, i32 1
  %87 = load <4 x float>* %tempB1, align 16
  %88 = extractelement <4 x float> %87, i32 1
  %mul136 = fmul float %86, %88
  %89 = call float @llvm.fmuladd.f32(float %82, float %84, float %mul136)
  %90 = load <4 x float>* %tempA0, align 16
  %91 = extractelement <4 x float> %90, i32 2
  %92 = load <4 x float>* %tempB2, align 16
  %93 = extractelement <4 x float> %92, i32 1
  %94 = call float @llvm.fmuladd.f32(float %91, float %93, float %89)
  %95 = load <4 x float>* %tempA0, align 16
  %96 = extractelement <4 x float> %95, i32 3
  %97 = load <4 x float>* %tempB3, align 16
  %98 = extractelement <4 x float> %97, i32 1
  %99 = call float @llvm.fmuladd.f32(float %96, float %98, float %94)
  %100 = load <4 x float>* %sum0, align 16
  %101 = extractelement <4 x float> %100, i32 1
  %add139 = fadd float %101, %99
  %102 = load <4 x float>* %sum0, align 16
  %103 = insertelement <4 x float> %102, float %add139, i32 1
  store <4 x float> %103, <4 x float>* %sum0, align 16
  %104 = load <4 x float>* %tempA0, align 16
  %105 = extractelement <4 x float> %104, i32 0
  %106 = load <4 x float>* %tempB0, align 16
  %107 = extractelement <4 x float> %106, i32 2
  %108 = load <4 x float>* %tempA0, align 16
  %109 = extractelement <4 x float> %108, i32 1
  %110 = load <4 x float>* %tempB1, align 16
  %111 = extractelement <4 x float> %110, i32 2
  %mul141 = fmul float %109, %111
  %112 = call float @llvm.fmuladd.f32(float %105, float %107, float %mul141)
  %113 = load <4 x float>* %tempA0, align 16
  %114 = extractelement <4 x float> %113, i32 2
  %115 = load <4 x float>* %tempB2, align 16
  %116 = extractelement <4 x float> %115, i32 2
  %117 = call float @llvm.fmuladd.f32(float %114, float %116, float %112)
  %118 = load <4 x float>* %tempA0, align 16
  %119 = extractelement <4 x float> %118, i32 3
  %120 = load <4 x float>* %tempB3, align 16
  %121 = extractelement <4 x float> %120, i32 2
  %122 = call float @llvm.fmuladd.f32(float %119, float %121, float %117)
  %123 = load <4 x float>* %sum0, align 16
  %124 = extractelement <4 x float> %123, i32 2
  %add144 = fadd float %124, %122
  %125 = load <4 x float>* %sum0, align 16
  %126 = insertelement <4 x float> %125, float %add144, i32 2
  store <4 x float> %126, <4 x float>* %sum0, align 16
  %127 = load <4 x float>* %tempA0, align 16
  %128 = extractelement <4 x float> %127, i32 0
  %129 = load <4 x float>* %tempB0, align 16
  %130 = extractelement <4 x float> %129, i32 3
  %131 = load <4 x float>* %tempA0, align 16
  %132 = extractelement <4 x float> %131, i32 1
  %133 = load <4 x float>* %tempB1, align 16
  %134 = extractelement <4 x float> %133, i32 3
  %mul146 = fmul float %132, %134
  %135 = call float @llvm.fmuladd.f32(float %128, float %130, float %mul146)
  %136 = load <4 x float>* %tempA0, align 16
  %137 = extractelement <4 x float> %136, i32 2
  %138 = load <4 x float>* %tempB2, align 16
  %139 = extractelement <4 x float> %138, i32 3
  %140 = call float @llvm.fmuladd.f32(float %137, float %139, float %135)
  %141 = load <4 x float>* %tempA0, align 16
  %142 = extractelement <4 x float> %141, i32 3
  %143 = load <4 x float>* %tempB3, align 16
  %144 = extractelement <4 x float> %143, i32 3
  %145 = call float @llvm.fmuladd.f32(float %142, float %144, float %140)
  %146 = load <4 x float>* %sum0, align 16
  %147 = extractelement <4 x float> %146, i32 3
  %add149 = fadd float %147, %145
  %148 = load <4 x float>* %sum0, align 16
  %149 = insertelement <4 x float> %148, float %add149, i32 3
  store <4 x float> %149, <4 x float>* %sum0, align 16
  %150 = load <4 x float>* %tempA1, align 16
  %151 = extractelement <4 x float> %150, i32 0
  %152 = load <4 x float>* %tempB0, align 16
  %153 = extractelement <4 x float> %152, i32 0
  %154 = load <4 x float>* %tempA1, align 16
  %155 = extractelement <4 x float> %154, i32 1
  %156 = load <4 x float>* %tempB1, align 16
  %157 = extractelement <4 x float> %156, i32 0
  %mul151 = fmul float %155, %157
  %158 = call float @llvm.fmuladd.f32(float %151, float %153, float %mul151)
  %159 = load <4 x float>* %tempA1, align 16
  %160 = extractelement <4 x float> %159, i32 2
  %161 = load <4 x float>* %tempB2, align 16
  %162 = extractelement <4 x float> %161, i32 0
  %163 = call float @llvm.fmuladd.f32(float %160, float %162, float %158)
  %164 = load <4 x float>* %tempA1, align 16
  %165 = extractelement <4 x float> %164, i32 3
  %166 = load <4 x float>* %tempB3, align 16
  %167 = extractelement <4 x float> %166, i32 0
  %168 = call float @llvm.fmuladd.f32(float %165, float %167, float %163)
  %169 = load <4 x float>* %sum1, align 16
  %170 = extractelement <4 x float> %169, i32 0
  %add154 = fadd float %170, %168
  %171 = load <4 x float>* %sum1, align 16
  %172 = insertelement <4 x float> %171, float %add154, i32 0
  store <4 x float> %172, <4 x float>* %sum1, align 16
  %173 = load <4 x float>* %tempA1, align 16
  %174 = extractelement <4 x float> %173, i32 0
  %175 = load <4 x float>* %tempB0, align 16
  %176 = extractelement <4 x float> %175, i32 1
  %177 = load <4 x float>* %tempA1, align 16
  %178 = extractelement <4 x float> %177, i32 1
  %179 = load <4 x float>* %tempB1, align 16
  %180 = extractelement <4 x float> %179, i32 1
  %mul156 = fmul float %178, %180
  %181 = call float @llvm.fmuladd.f32(float %174, float %176, float %mul156)
  %182 = load <4 x float>* %tempA1, align 16
  %183 = extractelement <4 x float> %182, i32 2
  %184 = load <4 x float>* %tempB2, align 16
  %185 = extractelement <4 x float> %184, i32 1
  %186 = call float @llvm.fmuladd.f32(float %183, float %185, float %181)
  %187 = load <4 x float>* %tempA1, align 16
  %188 = extractelement <4 x float> %187, i32 3
  %189 = load <4 x float>* %tempB3, align 16
  %190 = extractelement <4 x float> %189, i32 1
  %191 = call float @llvm.fmuladd.f32(float %188, float %190, float %186)
  %192 = load <4 x float>* %sum1, align 16
  %193 = extractelement <4 x float> %192, i32 1
  %add159 = fadd float %193, %191
  %194 = load <4 x float>* %sum1, align 16
  %195 = insertelement <4 x float> %194, float %add159, i32 1
  store <4 x float> %195, <4 x float>* %sum1, align 16
  %196 = load <4 x float>* %tempA1, align 16
  %197 = extractelement <4 x float> %196, i32 0
  %198 = load <4 x float>* %tempB0, align 16
  %199 = extractelement <4 x float> %198, i32 2
  %200 = load <4 x float>* %tempA1, align 16
  %201 = extractelement <4 x float> %200, i32 1
  %202 = load <4 x float>* %tempB1, align 16
  %203 = extractelement <4 x float> %202, i32 2
  %mul161 = fmul float %201, %203
  %204 = call float @llvm.fmuladd.f32(float %197, float %199, float %mul161)
  %205 = load <4 x float>* %tempA1, align 16
  %206 = extractelement <4 x float> %205, i32 2
  %207 = load <4 x float>* %tempB2, align 16
  %208 = extractelement <4 x float> %207, i32 2
  %209 = call float @llvm.fmuladd.f32(float %206, float %208, float %204)
  %210 = load <4 x float>* %tempA1, align 16
  %211 = extractelement <4 x float> %210, i32 3
  %212 = load <4 x float>* %tempB3, align 16
  %213 = extractelement <4 x float> %212, i32 2
  %214 = call float @llvm.fmuladd.f32(float %211, float %213, float %209)
  %215 = load <4 x float>* %sum1, align 16
  %216 = extractelement <4 x float> %215, i32 2
  %add164 = fadd float %216, %214
  %217 = load <4 x float>* %sum1, align 16
  %218 = insertelement <4 x float> %217, float %add164, i32 2
  store <4 x float> %218, <4 x float>* %sum1, align 16
  %219 = load <4 x float>* %tempA1, align 16
  %220 = extractelement <4 x float> %219, i32 0
  %221 = load <4 x float>* %tempB0, align 16
  %222 = extractelement <4 x float> %221, i32 3
  %223 = load <4 x float>* %tempA1, align 16
  %224 = extractelement <4 x float> %223, i32 1
  %225 = load <4 x float>* %tempB1, align 16
  %226 = extractelement <4 x float> %225, i32 3
  %mul166 = fmul float %224, %226
  %227 = call float @llvm.fmuladd.f32(float %220, float %222, float %mul166)
  %228 = load <4 x float>* %tempA1, align 16
  %229 = extractelement <4 x float> %228, i32 2
  %230 = load <4 x float>* %tempB2, align 16
  %231 = extractelement <4 x float> %230, i32 3
  %232 = call float @llvm.fmuladd.f32(float %229, float %231, float %227)
  %233 = load <4 x float>* %tempA1, align 16
  %234 = extractelement <4 x float> %233, i32 3
  %235 = load <4 x float>* %tempB3, align 16
  %236 = extractelement <4 x float> %235, i32 3
  %237 = call float @llvm.fmuladd.f32(float %234, float %236, float %232)
  %238 = load <4 x float>* %sum1, align 16
  %239 = extractelement <4 x float> %238, i32 3
  %add169 = fadd float %239, %237
  %240 = load <4 x float>* %sum1, align 16
  %241 = insertelement <4 x float> %240, float %add169, i32 3
  store <4 x float> %241, <4 x float>* %sum1, align 16
  %242 = load <4 x float>* %tempA2, align 16
  %243 = extractelement <4 x float> %242, i32 0
  %244 = load <4 x float>* %tempB0, align 16
  %245 = extractelement <4 x float> %244, i32 0
  %246 = load <4 x float>* %tempA2, align 16
  %247 = extractelement <4 x float> %246, i32 1
  %248 = load <4 x float>* %tempB1, align 16
  %249 = extractelement <4 x float> %248, i32 0
  %mul171 = fmul float %247, %249
  %250 = call float @llvm.fmuladd.f32(float %243, float %245, float %mul171)
  %251 = load <4 x float>* %tempA2, align 16
  %252 = extractelement <4 x float> %251, i32 2
  %253 = load <4 x float>* %tempB2, align 16
  %254 = extractelement <4 x float> %253, i32 0
  %255 = call float @llvm.fmuladd.f32(float %252, float %254, float %250)
  %256 = load <4 x float>* %tempA2, align 16
  %257 = extractelement <4 x float> %256, i32 3
  %258 = load <4 x float>* %tempB3, align 16
  %259 = extractelement <4 x float> %258, i32 0
  %260 = call float @llvm.fmuladd.f32(float %257, float %259, float %255)
  %261 = load <4 x float>* %sum2, align 16
  %262 = extractelement <4 x float> %261, i32 0
  %add174 = fadd float %262, %260
  %263 = load <4 x float>* %sum2, align 16
  %264 = insertelement <4 x float> %263, float %add174, i32 0
  store <4 x float> %264, <4 x float>* %sum2, align 16
  %265 = load <4 x float>* %tempA2, align 16
  %266 = extractelement <4 x float> %265, i32 0
  %267 = load <4 x float>* %tempB0, align 16
  %268 = extractelement <4 x float> %267, i32 1
  %269 = load <4 x float>* %tempA2, align 16
  %270 = extractelement <4 x float> %269, i32 1
  %271 = load <4 x float>* %tempB1, align 16
  %272 = extractelement <4 x float> %271, i32 1
  %mul176 = fmul float %270, %272
  %273 = call float @llvm.fmuladd.f32(float %266, float %268, float %mul176)
  %274 = load <4 x float>* %tempA2, align 16
  %275 = extractelement <4 x float> %274, i32 2
  %276 = load <4 x float>* %tempB2, align 16
  %277 = extractelement <4 x float> %276, i32 1
  %278 = call float @llvm.fmuladd.f32(float %275, float %277, float %273)
  %279 = load <4 x float>* %tempA2, align 16
  %280 = extractelement <4 x float> %279, i32 3
  %281 = load <4 x float>* %tempB3, align 16
  %282 = extractelement <4 x float> %281, i32 1
  %283 = call float @llvm.fmuladd.f32(float %280, float %282, float %278)
  %284 = load <4 x float>* %sum2, align 16
  %285 = extractelement <4 x float> %284, i32 1
  %add179 = fadd float %285, %283
  %286 = load <4 x float>* %sum2, align 16
  %287 = insertelement <4 x float> %286, float %add179, i32 1
  store <4 x float> %287, <4 x float>* %sum2, align 16
  %288 = load <4 x float>* %tempA2, align 16
  %289 = extractelement <4 x float> %288, i32 0
  %290 = load <4 x float>* %tempB0, align 16
  %291 = extractelement <4 x float> %290, i32 2
  %292 = load <4 x float>* %tempA2, align 16
  %293 = extractelement <4 x float> %292, i32 1
  %294 = load <4 x float>* %tempB1, align 16
  %295 = extractelement <4 x float> %294, i32 2
  %mul181 = fmul float %293, %295
  %296 = call float @llvm.fmuladd.f32(float %289, float %291, float %mul181)
  %297 = load <4 x float>* %tempA2, align 16
  %298 = extractelement <4 x float> %297, i32 2
  %299 = load <4 x float>* %tempB2, align 16
  %300 = extractelement <4 x float> %299, i32 2
  %301 = call float @llvm.fmuladd.f32(float %298, float %300, float %296)
  %302 = load <4 x float>* %tempA2, align 16
  %303 = extractelement <4 x float> %302, i32 3
  %304 = load <4 x float>* %tempB3, align 16
  %305 = extractelement <4 x float> %304, i32 2
  %306 = call float @llvm.fmuladd.f32(float %303, float %305, float %301)
  %307 = load <4 x float>* %sum2, align 16
  %308 = extractelement <4 x float> %307, i32 2
  %add184 = fadd float %308, %306
  %309 = load <4 x float>* %sum2, align 16
  %310 = insertelement <4 x float> %309, float %add184, i32 2
  store <4 x float> %310, <4 x float>* %sum2, align 16
  %311 = load <4 x float>* %tempA2, align 16
  %312 = extractelement <4 x float> %311, i32 0
  %313 = load <4 x float>* %tempB0, align 16
  %314 = extractelement <4 x float> %313, i32 3
  %315 = load <4 x float>* %tempA2, align 16
  %316 = extractelement <4 x float> %315, i32 1
  %317 = load <4 x float>* %tempB1, align 16
  %318 = extractelement <4 x float> %317, i32 3
  %mul186 = fmul float %316, %318
  %319 = call float @llvm.fmuladd.f32(float %312, float %314, float %mul186)
  %320 = load <4 x float>* %tempA2, align 16
  %321 = extractelement <4 x float> %320, i32 2
  %322 = load <4 x float>* %tempB2, align 16
  %323 = extractelement <4 x float> %322, i32 3
  %324 = call float @llvm.fmuladd.f32(float %321, float %323, float %319)
  %325 = load <4 x float>* %tempA2, align 16
  %326 = extractelement <4 x float> %325, i32 3
  %327 = load <4 x float>* %tempB3, align 16
  %328 = extractelement <4 x float> %327, i32 3
  %329 = call float @llvm.fmuladd.f32(float %326, float %328, float %324)
  %330 = load <4 x float>* %sum2, align 16
  %331 = extractelement <4 x float> %330, i32 3
  %add189 = fadd float %331, %329
  %332 = load <4 x float>* %sum2, align 16
  %333 = insertelement <4 x float> %332, float %add189, i32 3
  store <4 x float> %333, <4 x float>* %sum2, align 16
  %334 = load <4 x float>* %tempA3, align 16
  %335 = extractelement <4 x float> %334, i32 0
  %336 = load <4 x float>* %tempB0, align 16
  %337 = extractelement <4 x float> %336, i32 0
  %338 = load <4 x float>* %tempA3, align 16
  %339 = extractelement <4 x float> %338, i32 1
  %340 = load <4 x float>* %tempB1, align 16
  %341 = extractelement <4 x float> %340, i32 0
  %mul191 = fmul float %339, %341
  %342 = call float @llvm.fmuladd.f32(float %335, float %337, float %mul191)
  %343 = load <4 x float>* %tempA3, align 16
  %344 = extractelement <4 x float> %343, i32 2
  %345 = load <4 x float>* %tempB2, align 16
  %346 = extractelement <4 x float> %345, i32 0
  %347 = call float @llvm.fmuladd.f32(float %344, float %346, float %342)
  %348 = load <4 x float>* %tempA3, align 16
  %349 = extractelement <4 x float> %348, i32 3
  %350 = load <4 x float>* %tempB3, align 16
  %351 = extractelement <4 x float> %350, i32 0
  %352 = call float @llvm.fmuladd.f32(float %349, float %351, float %347)
  %353 = load <4 x float>* %sum3, align 16
  %354 = extractelement <4 x float> %353, i32 0
  %add194 = fadd float %354, %352
  %355 = load <4 x float>* %sum3, align 16
  %356 = insertelement <4 x float> %355, float %add194, i32 0
  store <4 x float> %356, <4 x float>* %sum3, align 16
  %357 = load <4 x float>* %tempA3, align 16
  %358 = extractelement <4 x float> %357, i32 0
  %359 = load <4 x float>* %tempB0, align 16
  %360 = extractelement <4 x float> %359, i32 1
  %361 = load <4 x float>* %tempA3, align 16
  %362 = extractelement <4 x float> %361, i32 1
  %363 = load <4 x float>* %tempB1, align 16
  %364 = extractelement <4 x float> %363, i32 1
  %mul196 = fmul float %362, %364
  %365 = call float @llvm.fmuladd.f32(float %358, float %360, float %mul196)
  %366 = load <4 x float>* %tempA3, align 16
  %367 = extractelement <4 x float> %366, i32 2
  %368 = load <4 x float>* %tempB2, align 16
  %369 = extractelement <4 x float> %368, i32 1
  %370 = call float @llvm.fmuladd.f32(float %367, float %369, float %365)
  %371 = load <4 x float>* %tempA3, align 16
  %372 = extractelement <4 x float> %371, i32 3
  %373 = load <4 x float>* %tempB3, align 16
  %374 = extractelement <4 x float> %373, i32 1
  %375 = call float @llvm.fmuladd.f32(float %372, float %374, float %370)
  %376 = load <4 x float>* %sum3, align 16
  %377 = extractelement <4 x float> %376, i32 1
  %add199 = fadd float %377, %375
  %378 = load <4 x float>* %sum3, align 16
  %379 = insertelement <4 x float> %378, float %add199, i32 1
  store <4 x float> %379, <4 x float>* %sum3, align 16
  %380 = load <4 x float>* %tempA3, align 16
  %381 = extractelement <4 x float> %380, i32 0
  %382 = load <4 x float>* %tempB0, align 16
  %383 = extractelement <4 x float> %382, i32 2
  %384 = load <4 x float>* %tempA3, align 16
  %385 = extractelement <4 x float> %384, i32 1
  %386 = load <4 x float>* %tempB1, align 16
  %387 = extractelement <4 x float> %386, i32 2
  %mul201 = fmul float %385, %387
  %388 = call float @llvm.fmuladd.f32(float %381, float %383, float %mul201)
  %389 = load <4 x float>* %tempA3, align 16
  %390 = extractelement <4 x float> %389, i32 2
  %391 = load <4 x float>* %tempB2, align 16
  %392 = extractelement <4 x float> %391, i32 2
  %393 = call float @llvm.fmuladd.f32(float %390, float %392, float %388)
  %394 = load <4 x float>* %tempA3, align 16
  %395 = extractelement <4 x float> %394, i32 3
  %396 = load <4 x float>* %tempB3, align 16
  %397 = extractelement <4 x float> %396, i32 2
  %398 = call float @llvm.fmuladd.f32(float %395, float %397, float %393)
  %399 = load <4 x float>* %sum3, align 16
  %400 = extractelement <4 x float> %399, i32 2
  %add204 = fadd float %400, %398
  %401 = load <4 x float>* %sum3, align 16
  %402 = insertelement <4 x float> %401, float %add204, i32 2
  store <4 x float> %402, <4 x float>* %sum3, align 16
  %403 = load <4 x float>* %tempA3, align 16
  %404 = extractelement <4 x float> %403, i32 0
  %405 = load <4 x float>* %tempB0, align 16
  %406 = extractelement <4 x float> %405, i32 3
  %407 = load <4 x float>* %tempA3, align 16
  %408 = extractelement <4 x float> %407, i32 1
  %409 = load <4 x float>* %tempB1, align 16
  %410 = extractelement <4 x float> %409, i32 3
  %mul206 = fmul float %408, %410
  %411 = call float @llvm.fmuladd.f32(float %404, float %406, float %mul206)
  %412 = load <4 x float>* %tempA3, align 16
  %413 = extractelement <4 x float> %412, i32 2
  %414 = load <4 x float>* %tempB2, align 16
  %415 = extractelement <4 x float> %414, i32 3
  %416 = call float @llvm.fmuladd.f32(float %413, float %415, float %411)
  %417 = load <4 x float>* %tempA3, align 16
  %418 = extractelement <4 x float> %417, i32 3
  %419 = load <4 x float>* %tempB3, align 16
  %420 = extractelement <4 x float> %419, i32 3
  %421 = call float @llvm.fmuladd.f32(float %418, float %420, float %416)
  %422 = load <4 x float>* %sum3, align 16
  %423 = extractelement <4 x float> %422, i32 3
  %add209 = fadd float %423, %421
  %424 = load <4 x float>* %sum3, align 16
  %425 = insertelement <4 x float> %424, float %add209, i32 3
  store <4 x float> %425, <4 x float>* %sum3, align 16
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
  %428 = load <4 x float>* %sum0, align 16
  %429 = load i32* %globalPos, align 4
  %idxprom213 = sext i32 %429 to i64
  %430 = load <4 x float> addrspace(1)** %matrixC.addr, align 8
  %arrayidx214 = getelementptr inbounds <4 x float> addrspace(1)* %430, i64 %idxprom213
  store <4 x float> %428, <4 x float> addrspace(1)* %arrayidx214, align 16
  %431 = load <4 x float>* %sum1, align 16
  %432 = load i32* %globalPos, align 4
  %conv215 = sext i32 %432 to i64
  %call216 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %add217 = add i64 %conv215, %call216
  %433 = load <4 x float> addrspace(1)** %matrixC.addr, align 8
  %arrayidx218 = getelementptr inbounds <4 x float> addrspace(1)* %433, i64 %add217
  store <4 x float> %431, <4 x float> addrspace(1)* %arrayidx218, align 16
  %434 = load <4 x float>* %sum2, align 16
  %435 = load i32* %globalPos, align 4
  %conv219 = sext i32 %435 to i64
  %call220 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul221 = mul i64 2, %call220
  %add222 = add i64 %conv219, %mul221
  %436 = load <4 x float> addrspace(1)** %matrixC.addr, align 8
  %arrayidx223 = getelementptr inbounds <4 x float> addrspace(1)* %436, i64 %add222
  store <4 x float> %434, <4 x float> addrspace(1)* %arrayidx223, align 16
  %437 = load <4 x float>* %sum3, align 16
  %438 = load i32* %globalPos, align 4
  %conv224 = sext i32 %438 to i64
  %call225 = call cc75 i64 @_Z15get_global_sizej(i32 0) #1
  %mul226 = mul i64 3, %call225
  %add227 = add i64 %conv224, %mul226
  %439 = load <4 x float> addrspace(1)** %matrixC.addr, align 8
  %arrayidx228 = getelementptr inbounds <4 x float> addrspace(1)* %439, i64 %add227
  store <4 x float> %437, <4 x float> addrspace(1)* %arrayidx228, align 16
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

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, i32)* @__OpenCL_mmmKernel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"float4*", metadata !"float4*", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"float4*", metadata !"float4*", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, <4 x float> addrspace(3)*)* @__OpenCL_mmmKernel_local_kernel, metadata !7, metadata !2, metadata !8, metadata !4, metadata !9}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 3}
!8 = metadata !{metadata !"kernel_arg_type", metadata !"float4*", metadata !"float4*", metadata !"float4*", metadata !"int", metadata !"float4*"}
!9 = metadata !{metadata !"kernel_arg_base_type", metadata !"float4*", metadata !"float4*", metadata !"float4*", metadata !"int", metadata !"float4*"}
!10 = metadata !{i32 1, i32 2}

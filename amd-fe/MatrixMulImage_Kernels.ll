; ModuleID = 'MatrixMulImage_Kernels.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%opencl.image2d_t = type opaque

@imageSampler = addrspace(2) constant i32 20, align 4

; Function Attrs: nounwind
define cc76 void @__OpenCL_mmmKernel_kernel(%opencl.image2d_t addrspace(1)* %matrixA, %opencl.image2d_t addrspace(1)* %matrixB, %opencl.image2d_t addrspace(1)* %matrixC, i32 %widthA, i32 %widthB) #0 {
entry:
  %matrixA.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %matrixB.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %matrixC.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
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
  %.compoundliteral5 = alloca <2 x i32>, align 8
  %tempA1 = alloca <4 x float>, align 16
  %.compoundliteral10 = alloca <2 x i32>, align 8
  %tempA2 = alloca <4 x float>, align 16
  %.compoundliteral16 = alloca <2 x i32>, align 8
  %tempA3 = alloca <4 x float>, align 16
  %.compoundliteral23 = alloca <2 x i32>, align 8
  %tempB0 = alloca <4 x float>, align 16
  %.compoundliteral30 = alloca <2 x i32>, align 8
  %tempB1 = alloca <4 x float>, align 16
  %.compoundliteral34 = alloca <2 x i32>, align 8
  %tempB2 = alloca <4 x float>, align 16
  %.compoundliteral39 = alloca <2 x i32>, align 8
  %tempB3 = alloca <4 x float>, align 16
  %.compoundliteral44 = alloca <2 x i32>, align 8
  %.compoundliteral82 = alloca <2 x i32>, align 8
  %.compoundliteral85 = alloca <2 x i32>, align 8
  %.compoundliteral90 = alloca <2 x i32>, align 8
  %.compoundliteral95 = alloca <2 x i32>, align 8
  store %opencl.image2d_t addrspace(1)* %matrixA, %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  store %opencl.image2d_t addrspace(1)* %matrixB, %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  store %opencl.image2d_t addrspace(1)* %matrixC, %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
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
  %4 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %5 = load i32 addrspace(2)* @imageSampler, align 4
  %6 = load i32* %i, align 4
  %div6 = sdiv i32 %6, 4
  %vecinit7 = insertelement <2 x i32> undef, i32 %div6, i32 0
  %7 = load <2 x i32>* %pos, align 8
  %8 = extractelement <2 x i32> %7, i32 1
  %shl = shl i32 %8, 2
  %vecinit8 = insertelement <2 x i32> %vecinit7, i32 %shl, i32 1
  store <2 x i32> %vecinit8, <2 x i32>* %.compoundliteral5
  %9 = load <2 x i32>* %.compoundliteral5
  %call9 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %4, i32 %5, <2 x i32> %9) #1
  store <4 x float> %call9, <4 x float>* %tempA0, align 16
  %10 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %11 = load i32 addrspace(2)* @imageSampler, align 4
  %12 = load i32* %i, align 4
  %div11 = sdiv i32 %12, 4
  %vecinit12 = insertelement <2 x i32> undef, i32 %div11, i32 0
  %13 = load <2 x i32>* %pos, align 8
  %14 = extractelement <2 x i32> %13, i32 1
  %shl13 = shl i32 %14, 2
  %add = add nsw i32 %shl13, 1
  %vecinit14 = insertelement <2 x i32> %vecinit12, i32 %add, i32 1
  store <2 x i32> %vecinit14, <2 x i32>* %.compoundliteral10
  %15 = load <2 x i32>* %.compoundliteral10
  %call15 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %10, i32 %11, <2 x i32> %15) #1
  store <4 x float> %call15, <4 x float>* %tempA1, align 16
  %16 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %17 = load i32 addrspace(2)* @imageSampler, align 4
  %18 = load i32* %i, align 4
  %div17 = sdiv i32 %18, 4
  %vecinit18 = insertelement <2 x i32> undef, i32 %div17, i32 0
  %19 = load <2 x i32>* %pos, align 8
  %20 = extractelement <2 x i32> %19, i32 1
  %shl19 = shl i32 %20, 2
  %add20 = add nsw i32 %shl19, 2
  %vecinit21 = insertelement <2 x i32> %vecinit18, i32 %add20, i32 1
  store <2 x i32> %vecinit21, <2 x i32>* %.compoundliteral16
  %21 = load <2 x i32>* %.compoundliteral16
  %call22 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %16, i32 %17, <2 x i32> %21) #1
  store <4 x float> %call22, <4 x float>* %tempA2, align 16
  %22 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %23 = load i32 addrspace(2)* @imageSampler, align 4
  %24 = load i32* %i, align 4
  %div24 = sdiv i32 %24, 4
  %vecinit25 = insertelement <2 x i32> undef, i32 %div24, i32 0
  %25 = load <2 x i32>* %pos, align 8
  %26 = extractelement <2 x i32> %25, i32 1
  %shl26 = shl i32 %26, 2
  %add27 = add nsw i32 %shl26, 3
  %vecinit28 = insertelement <2 x i32> %vecinit25, i32 %add27, i32 1
  store <2 x i32> %vecinit28, <2 x i32>* %.compoundliteral23
  %27 = load <2 x i32>* %.compoundliteral23
  %call29 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %22, i32 %23, <2 x i32> %27) #1
  store <4 x float> %call29, <4 x float>* %tempA3, align 16
  %28 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %29 = load i32 addrspace(2)* @imageSampler, align 4
  %30 = load <2 x i32>* %pos, align 8
  %31 = extractelement <2 x i32> %30, i32 0
  %vecinit31 = insertelement <2 x i32> undef, i32 %31, i32 0
  %32 = load i32* %i, align 4
  %vecinit32 = insertelement <2 x i32> %vecinit31, i32 %32, i32 1
  store <2 x i32> %vecinit32, <2 x i32>* %.compoundliteral30
  %33 = load <2 x i32>* %.compoundliteral30
  %call33 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %28, i32 %29, <2 x i32> %33) #1
  store <4 x float> %call33, <4 x float>* %tempB0, align 16
  %34 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %35 = load i32 addrspace(2)* @imageSampler, align 4
  %36 = load <2 x i32>* %pos, align 8
  %37 = extractelement <2 x i32> %36, i32 0
  %vecinit35 = insertelement <2 x i32> undef, i32 %37, i32 0
  %38 = load i32* %i, align 4
  %add36 = add nsw i32 %38, 1
  %vecinit37 = insertelement <2 x i32> %vecinit35, i32 %add36, i32 1
  store <2 x i32> %vecinit37, <2 x i32>* %.compoundliteral34
  %39 = load <2 x i32>* %.compoundliteral34
  %call38 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %34, i32 %35, <2 x i32> %39) #1
  store <4 x float> %call38, <4 x float>* %tempB1, align 16
  %40 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %41 = load i32 addrspace(2)* @imageSampler, align 4
  %42 = load <2 x i32>* %pos, align 8
  %43 = extractelement <2 x i32> %42, i32 0
  %vecinit40 = insertelement <2 x i32> undef, i32 %43, i32 0
  %44 = load i32* %i, align 4
  %add41 = add nsw i32 %44, 2
  %vecinit42 = insertelement <2 x i32> %vecinit40, i32 %add41, i32 1
  store <2 x i32> %vecinit42, <2 x i32>* %.compoundliteral39
  %45 = load <2 x i32>* %.compoundliteral39
  %call43 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %40, i32 %41, <2 x i32> %45) #1
  store <4 x float> %call43, <4 x float>* %tempB2, align 16
  %46 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %47 = load i32 addrspace(2)* @imageSampler, align 4
  %48 = load <2 x i32>* %pos, align 8
  %49 = extractelement <2 x i32> %48, i32 0
  %vecinit45 = insertelement <2 x i32> undef, i32 %49, i32 0
  %50 = load i32* %i, align 4
  %add46 = add nsw i32 %50, 3
  %vecinit47 = insertelement <2 x i32> %vecinit45, i32 %add46, i32 1
  store <2 x i32> %vecinit47, <2 x i32>* %.compoundliteral44
  %51 = load <2 x i32>* %.compoundliteral44
  %call48 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %46, i32 %47, <2 x i32> %51) #1
  store <4 x float> %call48, <4 x float>* %tempB3, align 16
  %52 = load <4 x float>* %tempA0, align 16
  %53 = extractelement <4 x float> %52, i32 0
  %54 = load <4 x float>* %tempB0, align 16
  %55 = extractelement <4 x float> %54, i32 0
  %56 = load <4 x float>* %tempA0, align 16
  %57 = extractelement <4 x float> %56, i32 1
  %58 = load <4 x float>* %tempB1, align 16
  %59 = extractelement <4 x float> %58, i32 0
  %mul49 = fmul float %57, %59
  %60 = call float @llvm.fmuladd.f32(float %53, float %55, float %mul49)
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
  %add50 = fadd float %72, %70
  %73 = load <4 x float>* %sum0, align 16
  %74 = insertelement <4 x float> %73, float %add50, i32 0
  store <4 x float> %74, <4 x float>* %sum0, align 16
  %75 = load <4 x float>* %tempA0, align 16
  %76 = extractelement <4 x float> %75, i32 0
  %77 = load <4 x float>* %tempB0, align 16
  %78 = extractelement <4 x float> %77, i32 1
  %79 = load <4 x float>* %tempA0, align 16
  %80 = extractelement <4 x float> %79, i32 1
  %81 = load <4 x float>* %tempB1, align 16
  %82 = extractelement <4 x float> %81, i32 1
  %mul51 = fmul float %80, %82
  %83 = call float @llvm.fmuladd.f32(float %76, float %78, float %mul51)
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
  %add52 = fadd float %95, %93
  %96 = load <4 x float>* %sum0, align 16
  %97 = insertelement <4 x float> %96, float %add52, i32 1
  store <4 x float> %97, <4 x float>* %sum0, align 16
  %98 = load <4 x float>* %tempA0, align 16
  %99 = extractelement <4 x float> %98, i32 0
  %100 = load <4 x float>* %tempB0, align 16
  %101 = extractelement <4 x float> %100, i32 2
  %102 = load <4 x float>* %tempA0, align 16
  %103 = extractelement <4 x float> %102, i32 1
  %104 = load <4 x float>* %tempB1, align 16
  %105 = extractelement <4 x float> %104, i32 2
  %mul53 = fmul float %103, %105
  %106 = call float @llvm.fmuladd.f32(float %99, float %101, float %mul53)
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
  %add54 = fadd float %118, %116
  %119 = load <4 x float>* %sum0, align 16
  %120 = insertelement <4 x float> %119, float %add54, i32 2
  store <4 x float> %120, <4 x float>* %sum0, align 16
  %121 = load <4 x float>* %tempA0, align 16
  %122 = extractelement <4 x float> %121, i32 0
  %123 = load <4 x float>* %tempB0, align 16
  %124 = extractelement <4 x float> %123, i32 3
  %125 = load <4 x float>* %tempA0, align 16
  %126 = extractelement <4 x float> %125, i32 1
  %127 = load <4 x float>* %tempB1, align 16
  %128 = extractelement <4 x float> %127, i32 3
  %mul55 = fmul float %126, %128
  %129 = call float @llvm.fmuladd.f32(float %122, float %124, float %mul55)
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
  %add56 = fadd float %141, %139
  %142 = load <4 x float>* %sum0, align 16
  %143 = insertelement <4 x float> %142, float %add56, i32 3
  store <4 x float> %143, <4 x float>* %sum0, align 16
  %144 = load <4 x float>* %tempA1, align 16
  %145 = extractelement <4 x float> %144, i32 0
  %146 = load <4 x float>* %tempB0, align 16
  %147 = extractelement <4 x float> %146, i32 0
  %148 = load <4 x float>* %tempA1, align 16
  %149 = extractelement <4 x float> %148, i32 1
  %150 = load <4 x float>* %tempB1, align 16
  %151 = extractelement <4 x float> %150, i32 0
  %mul57 = fmul float %149, %151
  %152 = call float @llvm.fmuladd.f32(float %145, float %147, float %mul57)
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
  %add58 = fadd float %164, %162
  %165 = load <4 x float>* %sum1, align 16
  %166 = insertelement <4 x float> %165, float %add58, i32 0
  store <4 x float> %166, <4 x float>* %sum1, align 16
  %167 = load <4 x float>* %tempA1, align 16
  %168 = extractelement <4 x float> %167, i32 0
  %169 = load <4 x float>* %tempB0, align 16
  %170 = extractelement <4 x float> %169, i32 1
  %171 = load <4 x float>* %tempA1, align 16
  %172 = extractelement <4 x float> %171, i32 1
  %173 = load <4 x float>* %tempB1, align 16
  %174 = extractelement <4 x float> %173, i32 1
  %mul59 = fmul float %172, %174
  %175 = call float @llvm.fmuladd.f32(float %168, float %170, float %mul59)
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
  %add60 = fadd float %187, %185
  %188 = load <4 x float>* %sum1, align 16
  %189 = insertelement <4 x float> %188, float %add60, i32 1
  store <4 x float> %189, <4 x float>* %sum1, align 16
  %190 = load <4 x float>* %tempA1, align 16
  %191 = extractelement <4 x float> %190, i32 0
  %192 = load <4 x float>* %tempB0, align 16
  %193 = extractelement <4 x float> %192, i32 2
  %194 = load <4 x float>* %tempA1, align 16
  %195 = extractelement <4 x float> %194, i32 1
  %196 = load <4 x float>* %tempB1, align 16
  %197 = extractelement <4 x float> %196, i32 2
  %mul61 = fmul float %195, %197
  %198 = call float @llvm.fmuladd.f32(float %191, float %193, float %mul61)
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
  %add62 = fadd float %210, %208
  %211 = load <4 x float>* %sum1, align 16
  %212 = insertelement <4 x float> %211, float %add62, i32 2
  store <4 x float> %212, <4 x float>* %sum1, align 16
  %213 = load <4 x float>* %tempA1, align 16
  %214 = extractelement <4 x float> %213, i32 0
  %215 = load <4 x float>* %tempB0, align 16
  %216 = extractelement <4 x float> %215, i32 3
  %217 = load <4 x float>* %tempA1, align 16
  %218 = extractelement <4 x float> %217, i32 1
  %219 = load <4 x float>* %tempB1, align 16
  %220 = extractelement <4 x float> %219, i32 3
  %mul63 = fmul float %218, %220
  %221 = call float @llvm.fmuladd.f32(float %214, float %216, float %mul63)
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
  %add64 = fadd float %233, %231
  %234 = load <4 x float>* %sum1, align 16
  %235 = insertelement <4 x float> %234, float %add64, i32 3
  store <4 x float> %235, <4 x float>* %sum1, align 16
  %236 = load <4 x float>* %tempA2, align 16
  %237 = extractelement <4 x float> %236, i32 0
  %238 = load <4 x float>* %tempB0, align 16
  %239 = extractelement <4 x float> %238, i32 0
  %240 = load <4 x float>* %tempA2, align 16
  %241 = extractelement <4 x float> %240, i32 1
  %242 = load <4 x float>* %tempB1, align 16
  %243 = extractelement <4 x float> %242, i32 0
  %mul65 = fmul float %241, %243
  %244 = call float @llvm.fmuladd.f32(float %237, float %239, float %mul65)
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
  %add66 = fadd float %256, %254
  %257 = load <4 x float>* %sum2, align 16
  %258 = insertelement <4 x float> %257, float %add66, i32 0
  store <4 x float> %258, <4 x float>* %sum2, align 16
  %259 = load <4 x float>* %tempA2, align 16
  %260 = extractelement <4 x float> %259, i32 0
  %261 = load <4 x float>* %tempB0, align 16
  %262 = extractelement <4 x float> %261, i32 1
  %263 = load <4 x float>* %tempA2, align 16
  %264 = extractelement <4 x float> %263, i32 1
  %265 = load <4 x float>* %tempB1, align 16
  %266 = extractelement <4 x float> %265, i32 1
  %mul67 = fmul float %264, %266
  %267 = call float @llvm.fmuladd.f32(float %260, float %262, float %mul67)
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
  %add68 = fadd float %279, %277
  %280 = load <4 x float>* %sum2, align 16
  %281 = insertelement <4 x float> %280, float %add68, i32 1
  store <4 x float> %281, <4 x float>* %sum2, align 16
  %282 = load <4 x float>* %tempA2, align 16
  %283 = extractelement <4 x float> %282, i32 0
  %284 = load <4 x float>* %tempB0, align 16
  %285 = extractelement <4 x float> %284, i32 2
  %286 = load <4 x float>* %tempA2, align 16
  %287 = extractelement <4 x float> %286, i32 1
  %288 = load <4 x float>* %tempB1, align 16
  %289 = extractelement <4 x float> %288, i32 2
  %mul69 = fmul float %287, %289
  %290 = call float @llvm.fmuladd.f32(float %283, float %285, float %mul69)
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
  %add70 = fadd float %302, %300
  %303 = load <4 x float>* %sum2, align 16
  %304 = insertelement <4 x float> %303, float %add70, i32 2
  store <4 x float> %304, <4 x float>* %sum2, align 16
  %305 = load <4 x float>* %tempA2, align 16
  %306 = extractelement <4 x float> %305, i32 0
  %307 = load <4 x float>* %tempB0, align 16
  %308 = extractelement <4 x float> %307, i32 3
  %309 = load <4 x float>* %tempA2, align 16
  %310 = extractelement <4 x float> %309, i32 1
  %311 = load <4 x float>* %tempB1, align 16
  %312 = extractelement <4 x float> %311, i32 3
  %mul71 = fmul float %310, %312
  %313 = call float @llvm.fmuladd.f32(float %306, float %308, float %mul71)
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
  %add72 = fadd float %325, %323
  %326 = load <4 x float>* %sum2, align 16
  %327 = insertelement <4 x float> %326, float %add72, i32 3
  store <4 x float> %327, <4 x float>* %sum2, align 16
  %328 = load <4 x float>* %tempA3, align 16
  %329 = extractelement <4 x float> %328, i32 0
  %330 = load <4 x float>* %tempB0, align 16
  %331 = extractelement <4 x float> %330, i32 0
  %332 = load <4 x float>* %tempA3, align 16
  %333 = extractelement <4 x float> %332, i32 1
  %334 = load <4 x float>* %tempB1, align 16
  %335 = extractelement <4 x float> %334, i32 0
  %mul73 = fmul float %333, %335
  %336 = call float @llvm.fmuladd.f32(float %329, float %331, float %mul73)
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
  %add74 = fadd float %348, %346
  %349 = load <4 x float>* %sum3, align 16
  %350 = insertelement <4 x float> %349, float %add74, i32 0
  store <4 x float> %350, <4 x float>* %sum3, align 16
  %351 = load <4 x float>* %tempA3, align 16
  %352 = extractelement <4 x float> %351, i32 0
  %353 = load <4 x float>* %tempB0, align 16
  %354 = extractelement <4 x float> %353, i32 1
  %355 = load <4 x float>* %tempA3, align 16
  %356 = extractelement <4 x float> %355, i32 1
  %357 = load <4 x float>* %tempB1, align 16
  %358 = extractelement <4 x float> %357, i32 1
  %mul75 = fmul float %356, %358
  %359 = call float @llvm.fmuladd.f32(float %352, float %354, float %mul75)
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
  %add76 = fadd float %371, %369
  %372 = load <4 x float>* %sum3, align 16
  %373 = insertelement <4 x float> %372, float %add76, i32 1
  store <4 x float> %373, <4 x float>* %sum3, align 16
  %374 = load <4 x float>* %tempA3, align 16
  %375 = extractelement <4 x float> %374, i32 0
  %376 = load <4 x float>* %tempB0, align 16
  %377 = extractelement <4 x float> %376, i32 2
  %378 = load <4 x float>* %tempA3, align 16
  %379 = extractelement <4 x float> %378, i32 1
  %380 = load <4 x float>* %tempB1, align 16
  %381 = extractelement <4 x float> %380, i32 2
  %mul77 = fmul float %379, %381
  %382 = call float @llvm.fmuladd.f32(float %375, float %377, float %mul77)
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
  %add78 = fadd float %394, %392
  %395 = load <4 x float>* %sum3, align 16
  %396 = insertelement <4 x float> %395, float %add78, i32 2
  store <4 x float> %396, <4 x float>* %sum3, align 16
  %397 = load <4 x float>* %tempA3, align 16
  %398 = extractelement <4 x float> %397, i32 0
  %399 = load <4 x float>* %tempB0, align 16
  %400 = extractelement <4 x float> %399, i32 3
  %401 = load <4 x float>* %tempA3, align 16
  %402 = extractelement <4 x float> %401, i32 1
  %403 = load <4 x float>* %tempB1, align 16
  %404 = extractelement <4 x float> %403, i32 3
  %mul79 = fmul float %402, %404
  %405 = call float @llvm.fmuladd.f32(float %398, float %400, float %mul79)
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
  %add80 = fadd float %417, %415
  %418 = load <4 x float>* %sum3, align 16
  %419 = insertelement <4 x float> %418, float %add80, i32 3
  store <4 x float> %419, <4 x float>* %sum3, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %420 = load i32* %i, align 4
  %add81 = add nsw i32 %420, 4
  store i32 %add81, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %421 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %422 = load <2 x i32>* %pos, align 8
  %423 = extractelement <2 x i32> %422, i32 0
  %vecinit83 = insertelement <2 x i32> undef, i32 %423, i32 0
  %424 = load <2 x i32>* %pos, align 8
  %425 = extractelement <2 x i32> %424, i32 1
  %mul = mul nsw i32 %425, 4
  %vecinit84 = insertelement <2 x i32> %vecinit83, i32 %mul, i32 1
  store <2 x i32> %vecinit84, <2 x i32>* %.compoundliteral82
  %426 = load <2 x i32>* %.compoundliteral82
  %427 = load <4 x float>* %sum0, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %421, <2 x i32> %426, <4 x float> %427)
  %428 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %429 = load <2 x i32>* %pos, align 8
  %430 = extractelement <2 x i32> %429, i32 0
  %vecinit86 = insertelement <2 x i32> undef, i32 %430, i32 0
  %431 = load <2 x i32>* %pos, align 8
  %432 = extractelement <2 x i32> %431, i32 1
  %mul87 = mul nsw i32 %432, 4
  %add88 = add nsw i32 %mul87, 1
  %vecinit89 = insertelement <2 x i32> %vecinit86, i32 %add88, i32 1
  store <2 x i32> %vecinit89, <2 x i32>* %.compoundliteral85
  %433 = load <2 x i32>* %.compoundliteral85
  %434 = load <4 x float>* %sum1, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %428, <2 x i32> %433, <4 x float> %434)
  %435 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %436 = load <2 x i32>* %pos, align 8
  %437 = extractelement <2 x i32> %436, i32 0
  %vecinit91 = insertelement <2 x i32> undef, i32 %437, i32 0
  %438 = load <2 x i32>* %pos, align 8
  %439 = extractelement <2 x i32> %438, i32 1
  %mul92 = mul nsw i32 %439, 4
  %add93 = add nsw i32 %mul92, 2
  %vecinit94 = insertelement <2 x i32> %vecinit91, i32 %add93, i32 1
  store <2 x i32> %vecinit94, <2 x i32>* %.compoundliteral90
  %440 = load <2 x i32>* %.compoundliteral90
  %441 = load <4 x float>* %sum2, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %435, <2 x i32> %440, <4 x float> %441)
  %442 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %443 = load <2 x i32>* %pos, align 8
  %444 = extractelement <2 x i32> %443, i32 0
  %vecinit96 = insertelement <2 x i32> undef, i32 %444, i32 0
  %445 = load <2 x i32>* %pos, align 8
  %446 = extractelement <2 x i32> %445, i32 1
  %mul97 = mul nsw i32 %446, 4
  %add98 = add nsw i32 %mul97, 3
  %vecinit99 = insertelement <2 x i32> %vecinit96, i32 %add98, i32 1
  store <2 x i32> %vecinit99, <2 x i32>* %.compoundliteral95
  %447 = load <2 x i32>* %.compoundliteral95
  %448 = load <4 x float>* %sum3, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %442, <2 x i32> %447, <4 x float> %448)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)*, i32, <2 x i32>) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #1

declare cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)*, <2 x i32>, <4 x float>)

; Function Attrs: nounwind
define cc76 void @__OpenCL_mmmKernel2_kernel(%opencl.image2d_t addrspace(1)* %matrixA, %opencl.image2d_t addrspace(1)* %matrixB, %opencl.image2d_t addrspace(1)* %matrixC, i32 %widthA, i32 %widthB) #0 {
entry:
  %matrixA.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %matrixB.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %matrixC.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %widthA.addr = alloca i32, align 4
  %widthB.addr = alloca i32, align 4
  %pos = alloca <2 x i32>, align 8
  %.compoundliteral = alloca <2 x i32>, align 8
  %sum0 = alloca <4 x float>, align 16
  %sum1 = alloca <4 x float>, align 16
  %sum2 = alloca <4 x float>, align 16
  %sum3 = alloca <4 x float>, align 16
  %sum4 = alloca <4 x float>, align 16
  %sum5 = alloca <4 x float>, align 16
  %sum6 = alloca <4 x float>, align 16
  %sum7 = alloca <4 x float>, align 16
  %i = alloca i32, align 4
  %tempA0 = alloca <4 x float>, align 16
  %.compoundliteral5 = alloca <2 x i32>, align 8
  %tempA1 = alloca <4 x float>, align 16
  %.compoundliteral10 = alloca <2 x i32>, align 8
  %tempA2 = alloca <4 x float>, align 16
  %.compoundliteral16 = alloca <2 x i32>, align 8
  %tempA3 = alloca <4 x float>, align 16
  %.compoundliteral23 = alloca <2 x i32>, align 8
  %tempA4 = alloca <4 x float>, align 16
  %.compoundliteral30 = alloca <2 x i32>, align 8
  %tempA5 = alloca <4 x float>, align 16
  %.compoundliteral37 = alloca <2 x i32>, align 8
  %tempA6 = alloca <4 x float>, align 16
  %.compoundliteral44 = alloca <2 x i32>, align 8
  %tempA7 = alloca <4 x float>, align 16
  %.compoundliteral51 = alloca <2 x i32>, align 8
  %tempB0 = alloca <4 x float>, align 16
  %.compoundliteral58 = alloca <2 x i32>, align 8
  %tempB1 = alloca <4 x float>, align 16
  %.compoundliteral62 = alloca <2 x i32>, align 8
  %tempB2 = alloca <4 x float>, align 16
  %.compoundliteral67 = alloca <2 x i32>, align 8
  %tempB3 = alloca <4 x float>, align 16
  %.compoundliteral72 = alloca <2 x i32>, align 8
  %.compoundliteral142 = alloca <2 x i32>, align 8
  %.compoundliteral145 = alloca <2 x i32>, align 8
  %.compoundliteral150 = alloca <2 x i32>, align 8
  %.compoundliteral155 = alloca <2 x i32>, align 8
  %.compoundliteral160 = alloca <2 x i32>, align 8
  %.compoundliteral165 = alloca <2 x i32>, align 8
  %.compoundliteral170 = alloca <2 x i32>, align 8
  %.compoundliteral175 = alloca <2 x i32>, align 8
  store %opencl.image2d_t addrspace(1)* %matrixA, %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  store %opencl.image2d_t addrspace(1)* %matrixB, %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  store %opencl.image2d_t addrspace(1)* %matrixC, %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
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
  store <4 x float> zeroinitializer, <4 x float>* %sum4, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum5, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum6, align 16
  store <4 x float> zeroinitializer, <4 x float>* %sum7, align 16
  %1 = load i32* %widthB.addr, align 4
  %shr = lshr i32 %1, 2
  store i32 %shr, i32* %widthB.addr, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32* %i, align 4
  %3 = load i32* %widthA.addr, align 4
  %cmp = icmp ult i32 %2, %3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %5 = load i32 addrspace(2)* @imageSampler, align 4
  %6 = load i32* %i, align 4
  %shr6 = ashr i32 %6, 2
  %vecinit7 = insertelement <2 x i32> undef, i32 %shr6, i32 0
  %7 = load <2 x i32>* %pos, align 8
  %8 = extractelement <2 x i32> %7, i32 1
  %shl = shl i32 %8, 3
  %vecinit8 = insertelement <2 x i32> %vecinit7, i32 %shl, i32 1
  store <2 x i32> %vecinit8, <2 x i32>* %.compoundliteral5
  %9 = load <2 x i32>* %.compoundliteral5
  %call9 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %4, i32 %5, <2 x i32> %9) #1
  store <4 x float> %call9, <4 x float>* %tempA0, align 16
  %10 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %11 = load i32 addrspace(2)* @imageSampler, align 4
  %12 = load i32* %i, align 4
  %shr11 = ashr i32 %12, 2
  %vecinit12 = insertelement <2 x i32> undef, i32 %shr11, i32 0
  %13 = load <2 x i32>* %pos, align 8
  %14 = extractelement <2 x i32> %13, i32 1
  %shl13 = shl i32 %14, 3
  %add = add nsw i32 %shl13, 1
  %vecinit14 = insertelement <2 x i32> %vecinit12, i32 %add, i32 1
  store <2 x i32> %vecinit14, <2 x i32>* %.compoundliteral10
  %15 = load <2 x i32>* %.compoundliteral10
  %call15 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %10, i32 %11, <2 x i32> %15) #1
  store <4 x float> %call15, <4 x float>* %tempA1, align 16
  %16 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %17 = load i32 addrspace(2)* @imageSampler, align 4
  %18 = load i32* %i, align 4
  %shr17 = ashr i32 %18, 2
  %vecinit18 = insertelement <2 x i32> undef, i32 %shr17, i32 0
  %19 = load <2 x i32>* %pos, align 8
  %20 = extractelement <2 x i32> %19, i32 1
  %shl19 = shl i32 %20, 3
  %add20 = add nsw i32 %shl19, 2
  %vecinit21 = insertelement <2 x i32> %vecinit18, i32 %add20, i32 1
  store <2 x i32> %vecinit21, <2 x i32>* %.compoundliteral16
  %21 = load <2 x i32>* %.compoundliteral16
  %call22 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %16, i32 %17, <2 x i32> %21) #1
  store <4 x float> %call22, <4 x float>* %tempA2, align 16
  %22 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %23 = load i32 addrspace(2)* @imageSampler, align 4
  %24 = load i32* %i, align 4
  %shr24 = ashr i32 %24, 2
  %vecinit25 = insertelement <2 x i32> undef, i32 %shr24, i32 0
  %25 = load <2 x i32>* %pos, align 8
  %26 = extractelement <2 x i32> %25, i32 1
  %shl26 = shl i32 %26, 3
  %add27 = add nsw i32 %shl26, 3
  %vecinit28 = insertelement <2 x i32> %vecinit25, i32 %add27, i32 1
  store <2 x i32> %vecinit28, <2 x i32>* %.compoundliteral23
  %27 = load <2 x i32>* %.compoundliteral23
  %call29 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %22, i32 %23, <2 x i32> %27) #1
  store <4 x float> %call29, <4 x float>* %tempA3, align 16
  %28 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %29 = load i32 addrspace(2)* @imageSampler, align 4
  %30 = load i32* %i, align 4
  %shr31 = ashr i32 %30, 2
  %vecinit32 = insertelement <2 x i32> undef, i32 %shr31, i32 0
  %31 = load <2 x i32>* %pos, align 8
  %32 = extractelement <2 x i32> %31, i32 1
  %shl33 = shl i32 %32, 3
  %add34 = add nsw i32 %shl33, 4
  %vecinit35 = insertelement <2 x i32> %vecinit32, i32 %add34, i32 1
  store <2 x i32> %vecinit35, <2 x i32>* %.compoundliteral30
  %33 = load <2 x i32>* %.compoundliteral30
  %call36 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %28, i32 %29, <2 x i32> %33) #1
  store <4 x float> %call36, <4 x float>* %tempA4, align 16
  %34 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %35 = load i32 addrspace(2)* @imageSampler, align 4
  %36 = load i32* %i, align 4
  %shr38 = ashr i32 %36, 2
  %vecinit39 = insertelement <2 x i32> undef, i32 %shr38, i32 0
  %37 = load <2 x i32>* %pos, align 8
  %38 = extractelement <2 x i32> %37, i32 1
  %shl40 = shl i32 %38, 3
  %add41 = add nsw i32 %shl40, 5
  %vecinit42 = insertelement <2 x i32> %vecinit39, i32 %add41, i32 1
  store <2 x i32> %vecinit42, <2 x i32>* %.compoundliteral37
  %39 = load <2 x i32>* %.compoundliteral37
  %call43 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %34, i32 %35, <2 x i32> %39) #1
  store <4 x float> %call43, <4 x float>* %tempA5, align 16
  %40 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %41 = load i32 addrspace(2)* @imageSampler, align 4
  %42 = load i32* %i, align 4
  %shr45 = ashr i32 %42, 2
  %vecinit46 = insertelement <2 x i32> undef, i32 %shr45, i32 0
  %43 = load <2 x i32>* %pos, align 8
  %44 = extractelement <2 x i32> %43, i32 1
  %shl47 = shl i32 %44, 3
  %add48 = add nsw i32 %shl47, 6
  %vecinit49 = insertelement <2 x i32> %vecinit46, i32 %add48, i32 1
  store <2 x i32> %vecinit49, <2 x i32>* %.compoundliteral44
  %45 = load <2 x i32>* %.compoundliteral44
  %call50 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %40, i32 %41, <2 x i32> %45) #1
  store <4 x float> %call50, <4 x float>* %tempA6, align 16
  %46 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %47 = load i32 addrspace(2)* @imageSampler, align 4
  %48 = load i32* %i, align 4
  %shr52 = ashr i32 %48, 2
  %vecinit53 = insertelement <2 x i32> undef, i32 %shr52, i32 0
  %49 = load <2 x i32>* %pos, align 8
  %50 = extractelement <2 x i32> %49, i32 1
  %shl54 = shl i32 %50, 3
  %add55 = add nsw i32 %shl54, 7
  %vecinit56 = insertelement <2 x i32> %vecinit53, i32 %add55, i32 1
  store <2 x i32> %vecinit56, <2 x i32>* %.compoundliteral51
  %51 = load <2 x i32>* %.compoundliteral51
  %call57 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %46, i32 %47, <2 x i32> %51) #1
  store <4 x float> %call57, <4 x float>* %tempA7, align 16
  %52 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %53 = load i32 addrspace(2)* @imageSampler, align 4
  %54 = load <2 x i32>* %pos, align 8
  %55 = extractelement <2 x i32> %54, i32 0
  %vecinit59 = insertelement <2 x i32> undef, i32 %55, i32 0
  %56 = load i32* %i, align 4
  %vecinit60 = insertelement <2 x i32> %vecinit59, i32 %56, i32 1
  store <2 x i32> %vecinit60, <2 x i32>* %.compoundliteral58
  %57 = load <2 x i32>* %.compoundliteral58
  %call61 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %52, i32 %53, <2 x i32> %57) #1
  store <4 x float> %call61, <4 x float>* %tempB0, align 16
  %58 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %59 = load i32 addrspace(2)* @imageSampler, align 4
  %60 = load <2 x i32>* %pos, align 8
  %61 = extractelement <2 x i32> %60, i32 0
  %vecinit63 = insertelement <2 x i32> undef, i32 %61, i32 0
  %62 = load i32* %i, align 4
  %add64 = add nsw i32 %62, 1
  %vecinit65 = insertelement <2 x i32> %vecinit63, i32 %add64, i32 1
  store <2 x i32> %vecinit65, <2 x i32>* %.compoundliteral62
  %63 = load <2 x i32>* %.compoundliteral62
  %call66 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %58, i32 %59, <2 x i32> %63) #1
  store <4 x float> %call66, <4 x float>* %tempB1, align 16
  %64 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %65 = load i32 addrspace(2)* @imageSampler, align 4
  %66 = load <2 x i32>* %pos, align 8
  %67 = extractelement <2 x i32> %66, i32 0
  %vecinit68 = insertelement <2 x i32> undef, i32 %67, i32 0
  %68 = load i32* %i, align 4
  %add69 = add nsw i32 %68, 2
  %vecinit70 = insertelement <2 x i32> %vecinit68, i32 %add69, i32 1
  store <2 x i32> %vecinit70, <2 x i32>* %.compoundliteral67
  %69 = load <2 x i32>* %.compoundliteral67
  %call71 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %64, i32 %65, <2 x i32> %69) #1
  store <4 x float> %call71, <4 x float>* %tempB2, align 16
  %70 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %71 = load i32 addrspace(2)* @imageSampler, align 4
  %72 = load <2 x i32>* %pos, align 8
  %73 = extractelement <2 x i32> %72, i32 0
  %vecinit73 = insertelement <2 x i32> undef, i32 %73, i32 0
  %74 = load i32* %i, align 4
  %add74 = add nsw i32 %74, 3
  %vecinit75 = insertelement <2 x i32> %vecinit73, i32 %add74, i32 1
  store <2 x i32> %vecinit75, <2 x i32>* %.compoundliteral72
  %75 = load <2 x i32>* %.compoundliteral72
  %call76 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %70, i32 %71, <2 x i32> %75) #1
  store <4 x float> %call76, <4 x float>* %tempB3, align 16
  %76 = load <4 x float>* %tempA0, align 16
  %77 = extractelement <4 x float> %76, i32 0
  %78 = load <4 x float>* %tempB0, align 16
  %79 = extractelement <4 x float> %78, i32 0
  %80 = load <4 x float>* %tempA0, align 16
  %81 = extractelement <4 x float> %80, i32 1
  %82 = load <4 x float>* %tempB1, align 16
  %83 = extractelement <4 x float> %82, i32 0
  %mul77 = fmul float %81, %83
  %84 = call float @llvm.fmuladd.f32(float %77, float %79, float %mul77)
  %85 = load <4 x float>* %tempA0, align 16
  %86 = extractelement <4 x float> %85, i32 2
  %87 = load <4 x float>* %tempB2, align 16
  %88 = extractelement <4 x float> %87, i32 0
  %89 = call float @llvm.fmuladd.f32(float %86, float %88, float %84)
  %90 = load <4 x float>* %tempA0, align 16
  %91 = extractelement <4 x float> %90, i32 3
  %92 = load <4 x float>* %tempB3, align 16
  %93 = extractelement <4 x float> %92, i32 0
  %94 = call float @llvm.fmuladd.f32(float %91, float %93, float %89)
  %95 = load <4 x float>* %sum0, align 16
  %96 = extractelement <4 x float> %95, i32 0
  %add78 = fadd float %96, %94
  %97 = load <4 x float>* %sum0, align 16
  %98 = insertelement <4 x float> %97, float %add78, i32 0
  store <4 x float> %98, <4 x float>* %sum0, align 16
  %99 = load <4 x float>* %tempA0, align 16
  %100 = extractelement <4 x float> %99, i32 0
  %101 = load <4 x float>* %tempB0, align 16
  %102 = extractelement <4 x float> %101, i32 1
  %103 = load <4 x float>* %tempA0, align 16
  %104 = extractelement <4 x float> %103, i32 1
  %105 = load <4 x float>* %tempB1, align 16
  %106 = extractelement <4 x float> %105, i32 1
  %mul79 = fmul float %104, %106
  %107 = call float @llvm.fmuladd.f32(float %100, float %102, float %mul79)
  %108 = load <4 x float>* %tempA0, align 16
  %109 = extractelement <4 x float> %108, i32 2
  %110 = load <4 x float>* %tempB2, align 16
  %111 = extractelement <4 x float> %110, i32 1
  %112 = call float @llvm.fmuladd.f32(float %109, float %111, float %107)
  %113 = load <4 x float>* %tempA0, align 16
  %114 = extractelement <4 x float> %113, i32 3
  %115 = load <4 x float>* %tempB3, align 16
  %116 = extractelement <4 x float> %115, i32 1
  %117 = call float @llvm.fmuladd.f32(float %114, float %116, float %112)
  %118 = load <4 x float>* %sum0, align 16
  %119 = extractelement <4 x float> %118, i32 1
  %add80 = fadd float %119, %117
  %120 = load <4 x float>* %sum0, align 16
  %121 = insertelement <4 x float> %120, float %add80, i32 1
  store <4 x float> %121, <4 x float>* %sum0, align 16
  %122 = load <4 x float>* %tempA0, align 16
  %123 = extractelement <4 x float> %122, i32 0
  %124 = load <4 x float>* %tempB0, align 16
  %125 = extractelement <4 x float> %124, i32 2
  %126 = load <4 x float>* %tempA0, align 16
  %127 = extractelement <4 x float> %126, i32 1
  %128 = load <4 x float>* %tempB1, align 16
  %129 = extractelement <4 x float> %128, i32 2
  %mul81 = fmul float %127, %129
  %130 = call float @llvm.fmuladd.f32(float %123, float %125, float %mul81)
  %131 = load <4 x float>* %tempA0, align 16
  %132 = extractelement <4 x float> %131, i32 2
  %133 = load <4 x float>* %tempB2, align 16
  %134 = extractelement <4 x float> %133, i32 2
  %135 = call float @llvm.fmuladd.f32(float %132, float %134, float %130)
  %136 = load <4 x float>* %tempA0, align 16
  %137 = extractelement <4 x float> %136, i32 3
  %138 = load <4 x float>* %tempB3, align 16
  %139 = extractelement <4 x float> %138, i32 2
  %140 = call float @llvm.fmuladd.f32(float %137, float %139, float %135)
  %141 = load <4 x float>* %sum0, align 16
  %142 = extractelement <4 x float> %141, i32 2
  %add82 = fadd float %142, %140
  %143 = load <4 x float>* %sum0, align 16
  %144 = insertelement <4 x float> %143, float %add82, i32 2
  store <4 x float> %144, <4 x float>* %sum0, align 16
  %145 = load <4 x float>* %tempA0, align 16
  %146 = extractelement <4 x float> %145, i32 0
  %147 = load <4 x float>* %tempB0, align 16
  %148 = extractelement <4 x float> %147, i32 3
  %149 = load <4 x float>* %tempA0, align 16
  %150 = extractelement <4 x float> %149, i32 1
  %151 = load <4 x float>* %tempB1, align 16
  %152 = extractelement <4 x float> %151, i32 3
  %mul83 = fmul float %150, %152
  %153 = call float @llvm.fmuladd.f32(float %146, float %148, float %mul83)
  %154 = load <4 x float>* %tempA0, align 16
  %155 = extractelement <4 x float> %154, i32 2
  %156 = load <4 x float>* %tempB2, align 16
  %157 = extractelement <4 x float> %156, i32 3
  %158 = call float @llvm.fmuladd.f32(float %155, float %157, float %153)
  %159 = load <4 x float>* %tempA0, align 16
  %160 = extractelement <4 x float> %159, i32 3
  %161 = load <4 x float>* %tempB3, align 16
  %162 = extractelement <4 x float> %161, i32 3
  %163 = call float @llvm.fmuladd.f32(float %160, float %162, float %158)
  %164 = load <4 x float>* %sum0, align 16
  %165 = extractelement <4 x float> %164, i32 3
  %add84 = fadd float %165, %163
  %166 = load <4 x float>* %sum0, align 16
  %167 = insertelement <4 x float> %166, float %add84, i32 3
  store <4 x float> %167, <4 x float>* %sum0, align 16
  %168 = load <4 x float>* %tempA1, align 16
  %169 = extractelement <4 x float> %168, i32 0
  %170 = load <4 x float>* %tempB0, align 16
  %171 = extractelement <4 x float> %170, i32 0
  %172 = load <4 x float>* %tempA1, align 16
  %173 = extractelement <4 x float> %172, i32 1
  %174 = load <4 x float>* %tempB1, align 16
  %175 = extractelement <4 x float> %174, i32 0
  %mul85 = fmul float %173, %175
  %176 = call float @llvm.fmuladd.f32(float %169, float %171, float %mul85)
  %177 = load <4 x float>* %tempA1, align 16
  %178 = extractelement <4 x float> %177, i32 2
  %179 = load <4 x float>* %tempB2, align 16
  %180 = extractelement <4 x float> %179, i32 0
  %181 = call float @llvm.fmuladd.f32(float %178, float %180, float %176)
  %182 = load <4 x float>* %tempA1, align 16
  %183 = extractelement <4 x float> %182, i32 3
  %184 = load <4 x float>* %tempB3, align 16
  %185 = extractelement <4 x float> %184, i32 0
  %186 = call float @llvm.fmuladd.f32(float %183, float %185, float %181)
  %187 = load <4 x float>* %sum1, align 16
  %188 = extractelement <4 x float> %187, i32 0
  %add86 = fadd float %188, %186
  %189 = load <4 x float>* %sum1, align 16
  %190 = insertelement <4 x float> %189, float %add86, i32 0
  store <4 x float> %190, <4 x float>* %sum1, align 16
  %191 = load <4 x float>* %tempA1, align 16
  %192 = extractelement <4 x float> %191, i32 0
  %193 = load <4 x float>* %tempB0, align 16
  %194 = extractelement <4 x float> %193, i32 1
  %195 = load <4 x float>* %tempA1, align 16
  %196 = extractelement <4 x float> %195, i32 1
  %197 = load <4 x float>* %tempB1, align 16
  %198 = extractelement <4 x float> %197, i32 1
  %mul87 = fmul float %196, %198
  %199 = call float @llvm.fmuladd.f32(float %192, float %194, float %mul87)
  %200 = load <4 x float>* %tempA1, align 16
  %201 = extractelement <4 x float> %200, i32 2
  %202 = load <4 x float>* %tempB2, align 16
  %203 = extractelement <4 x float> %202, i32 1
  %204 = call float @llvm.fmuladd.f32(float %201, float %203, float %199)
  %205 = load <4 x float>* %tempA1, align 16
  %206 = extractelement <4 x float> %205, i32 3
  %207 = load <4 x float>* %tempB3, align 16
  %208 = extractelement <4 x float> %207, i32 1
  %209 = call float @llvm.fmuladd.f32(float %206, float %208, float %204)
  %210 = load <4 x float>* %sum1, align 16
  %211 = extractelement <4 x float> %210, i32 1
  %add88 = fadd float %211, %209
  %212 = load <4 x float>* %sum1, align 16
  %213 = insertelement <4 x float> %212, float %add88, i32 1
  store <4 x float> %213, <4 x float>* %sum1, align 16
  %214 = load <4 x float>* %tempA1, align 16
  %215 = extractelement <4 x float> %214, i32 0
  %216 = load <4 x float>* %tempB0, align 16
  %217 = extractelement <4 x float> %216, i32 2
  %218 = load <4 x float>* %tempA1, align 16
  %219 = extractelement <4 x float> %218, i32 1
  %220 = load <4 x float>* %tempB1, align 16
  %221 = extractelement <4 x float> %220, i32 2
  %mul89 = fmul float %219, %221
  %222 = call float @llvm.fmuladd.f32(float %215, float %217, float %mul89)
  %223 = load <4 x float>* %tempA1, align 16
  %224 = extractelement <4 x float> %223, i32 2
  %225 = load <4 x float>* %tempB2, align 16
  %226 = extractelement <4 x float> %225, i32 2
  %227 = call float @llvm.fmuladd.f32(float %224, float %226, float %222)
  %228 = load <4 x float>* %tempA1, align 16
  %229 = extractelement <4 x float> %228, i32 3
  %230 = load <4 x float>* %tempB3, align 16
  %231 = extractelement <4 x float> %230, i32 2
  %232 = call float @llvm.fmuladd.f32(float %229, float %231, float %227)
  %233 = load <4 x float>* %sum1, align 16
  %234 = extractelement <4 x float> %233, i32 2
  %add90 = fadd float %234, %232
  %235 = load <4 x float>* %sum1, align 16
  %236 = insertelement <4 x float> %235, float %add90, i32 2
  store <4 x float> %236, <4 x float>* %sum1, align 16
  %237 = load <4 x float>* %tempA1, align 16
  %238 = extractelement <4 x float> %237, i32 0
  %239 = load <4 x float>* %tempB0, align 16
  %240 = extractelement <4 x float> %239, i32 3
  %241 = load <4 x float>* %tempA1, align 16
  %242 = extractelement <4 x float> %241, i32 1
  %243 = load <4 x float>* %tempB1, align 16
  %244 = extractelement <4 x float> %243, i32 3
  %mul91 = fmul float %242, %244
  %245 = call float @llvm.fmuladd.f32(float %238, float %240, float %mul91)
  %246 = load <4 x float>* %tempA1, align 16
  %247 = extractelement <4 x float> %246, i32 2
  %248 = load <4 x float>* %tempB2, align 16
  %249 = extractelement <4 x float> %248, i32 3
  %250 = call float @llvm.fmuladd.f32(float %247, float %249, float %245)
  %251 = load <4 x float>* %tempA1, align 16
  %252 = extractelement <4 x float> %251, i32 3
  %253 = load <4 x float>* %tempB3, align 16
  %254 = extractelement <4 x float> %253, i32 3
  %255 = call float @llvm.fmuladd.f32(float %252, float %254, float %250)
  %256 = load <4 x float>* %sum1, align 16
  %257 = extractelement <4 x float> %256, i32 3
  %add92 = fadd float %257, %255
  %258 = load <4 x float>* %sum1, align 16
  %259 = insertelement <4 x float> %258, float %add92, i32 3
  store <4 x float> %259, <4 x float>* %sum1, align 16
  %260 = load <4 x float>* %tempA2, align 16
  %261 = extractelement <4 x float> %260, i32 0
  %262 = load <4 x float>* %tempB0, align 16
  %263 = extractelement <4 x float> %262, i32 0
  %264 = load <4 x float>* %tempA2, align 16
  %265 = extractelement <4 x float> %264, i32 1
  %266 = load <4 x float>* %tempB1, align 16
  %267 = extractelement <4 x float> %266, i32 0
  %mul93 = fmul float %265, %267
  %268 = call float @llvm.fmuladd.f32(float %261, float %263, float %mul93)
  %269 = load <4 x float>* %tempA2, align 16
  %270 = extractelement <4 x float> %269, i32 2
  %271 = load <4 x float>* %tempB2, align 16
  %272 = extractelement <4 x float> %271, i32 0
  %273 = call float @llvm.fmuladd.f32(float %270, float %272, float %268)
  %274 = load <4 x float>* %tempA2, align 16
  %275 = extractelement <4 x float> %274, i32 3
  %276 = load <4 x float>* %tempB3, align 16
  %277 = extractelement <4 x float> %276, i32 0
  %278 = call float @llvm.fmuladd.f32(float %275, float %277, float %273)
  %279 = load <4 x float>* %sum2, align 16
  %280 = extractelement <4 x float> %279, i32 0
  %add94 = fadd float %280, %278
  %281 = load <4 x float>* %sum2, align 16
  %282 = insertelement <4 x float> %281, float %add94, i32 0
  store <4 x float> %282, <4 x float>* %sum2, align 16
  %283 = load <4 x float>* %tempA2, align 16
  %284 = extractelement <4 x float> %283, i32 0
  %285 = load <4 x float>* %tempB0, align 16
  %286 = extractelement <4 x float> %285, i32 1
  %287 = load <4 x float>* %tempA2, align 16
  %288 = extractelement <4 x float> %287, i32 1
  %289 = load <4 x float>* %tempB1, align 16
  %290 = extractelement <4 x float> %289, i32 1
  %mul95 = fmul float %288, %290
  %291 = call float @llvm.fmuladd.f32(float %284, float %286, float %mul95)
  %292 = load <4 x float>* %tempA2, align 16
  %293 = extractelement <4 x float> %292, i32 2
  %294 = load <4 x float>* %tempB2, align 16
  %295 = extractelement <4 x float> %294, i32 1
  %296 = call float @llvm.fmuladd.f32(float %293, float %295, float %291)
  %297 = load <4 x float>* %tempA2, align 16
  %298 = extractelement <4 x float> %297, i32 3
  %299 = load <4 x float>* %tempB3, align 16
  %300 = extractelement <4 x float> %299, i32 1
  %301 = call float @llvm.fmuladd.f32(float %298, float %300, float %296)
  %302 = load <4 x float>* %sum2, align 16
  %303 = extractelement <4 x float> %302, i32 1
  %add96 = fadd float %303, %301
  %304 = load <4 x float>* %sum2, align 16
  %305 = insertelement <4 x float> %304, float %add96, i32 1
  store <4 x float> %305, <4 x float>* %sum2, align 16
  %306 = load <4 x float>* %tempA2, align 16
  %307 = extractelement <4 x float> %306, i32 0
  %308 = load <4 x float>* %tempB0, align 16
  %309 = extractelement <4 x float> %308, i32 2
  %310 = load <4 x float>* %tempA2, align 16
  %311 = extractelement <4 x float> %310, i32 1
  %312 = load <4 x float>* %tempB1, align 16
  %313 = extractelement <4 x float> %312, i32 2
  %mul97 = fmul float %311, %313
  %314 = call float @llvm.fmuladd.f32(float %307, float %309, float %mul97)
  %315 = load <4 x float>* %tempA2, align 16
  %316 = extractelement <4 x float> %315, i32 2
  %317 = load <4 x float>* %tempB2, align 16
  %318 = extractelement <4 x float> %317, i32 2
  %319 = call float @llvm.fmuladd.f32(float %316, float %318, float %314)
  %320 = load <4 x float>* %tempA2, align 16
  %321 = extractelement <4 x float> %320, i32 3
  %322 = load <4 x float>* %tempB3, align 16
  %323 = extractelement <4 x float> %322, i32 2
  %324 = call float @llvm.fmuladd.f32(float %321, float %323, float %319)
  %325 = load <4 x float>* %sum2, align 16
  %326 = extractelement <4 x float> %325, i32 2
  %add98 = fadd float %326, %324
  %327 = load <4 x float>* %sum2, align 16
  %328 = insertelement <4 x float> %327, float %add98, i32 2
  store <4 x float> %328, <4 x float>* %sum2, align 16
  %329 = load <4 x float>* %tempA2, align 16
  %330 = extractelement <4 x float> %329, i32 0
  %331 = load <4 x float>* %tempB0, align 16
  %332 = extractelement <4 x float> %331, i32 3
  %333 = load <4 x float>* %tempA2, align 16
  %334 = extractelement <4 x float> %333, i32 1
  %335 = load <4 x float>* %tempB1, align 16
  %336 = extractelement <4 x float> %335, i32 3
  %mul99 = fmul float %334, %336
  %337 = call float @llvm.fmuladd.f32(float %330, float %332, float %mul99)
  %338 = load <4 x float>* %tempA2, align 16
  %339 = extractelement <4 x float> %338, i32 2
  %340 = load <4 x float>* %tempB2, align 16
  %341 = extractelement <4 x float> %340, i32 3
  %342 = call float @llvm.fmuladd.f32(float %339, float %341, float %337)
  %343 = load <4 x float>* %tempA2, align 16
  %344 = extractelement <4 x float> %343, i32 3
  %345 = load <4 x float>* %tempB3, align 16
  %346 = extractelement <4 x float> %345, i32 3
  %347 = call float @llvm.fmuladd.f32(float %344, float %346, float %342)
  %348 = load <4 x float>* %sum2, align 16
  %349 = extractelement <4 x float> %348, i32 3
  %add100 = fadd float %349, %347
  %350 = load <4 x float>* %sum2, align 16
  %351 = insertelement <4 x float> %350, float %add100, i32 3
  store <4 x float> %351, <4 x float>* %sum2, align 16
  %352 = load <4 x float>* %tempA3, align 16
  %353 = extractelement <4 x float> %352, i32 0
  %354 = load <4 x float>* %tempB0, align 16
  %355 = extractelement <4 x float> %354, i32 0
  %356 = load <4 x float>* %tempA3, align 16
  %357 = extractelement <4 x float> %356, i32 1
  %358 = load <4 x float>* %tempB1, align 16
  %359 = extractelement <4 x float> %358, i32 0
  %mul101 = fmul float %357, %359
  %360 = call float @llvm.fmuladd.f32(float %353, float %355, float %mul101)
  %361 = load <4 x float>* %tempA3, align 16
  %362 = extractelement <4 x float> %361, i32 2
  %363 = load <4 x float>* %tempB2, align 16
  %364 = extractelement <4 x float> %363, i32 0
  %365 = call float @llvm.fmuladd.f32(float %362, float %364, float %360)
  %366 = load <4 x float>* %tempA3, align 16
  %367 = extractelement <4 x float> %366, i32 3
  %368 = load <4 x float>* %tempB3, align 16
  %369 = extractelement <4 x float> %368, i32 0
  %370 = call float @llvm.fmuladd.f32(float %367, float %369, float %365)
  %371 = load <4 x float>* %sum3, align 16
  %372 = extractelement <4 x float> %371, i32 0
  %add102 = fadd float %372, %370
  %373 = load <4 x float>* %sum3, align 16
  %374 = insertelement <4 x float> %373, float %add102, i32 0
  store <4 x float> %374, <4 x float>* %sum3, align 16
  %375 = load <4 x float>* %tempA3, align 16
  %376 = extractelement <4 x float> %375, i32 0
  %377 = load <4 x float>* %tempB0, align 16
  %378 = extractelement <4 x float> %377, i32 1
  %379 = load <4 x float>* %tempA3, align 16
  %380 = extractelement <4 x float> %379, i32 1
  %381 = load <4 x float>* %tempB1, align 16
  %382 = extractelement <4 x float> %381, i32 1
  %mul103 = fmul float %380, %382
  %383 = call float @llvm.fmuladd.f32(float %376, float %378, float %mul103)
  %384 = load <4 x float>* %tempA3, align 16
  %385 = extractelement <4 x float> %384, i32 2
  %386 = load <4 x float>* %tempB2, align 16
  %387 = extractelement <4 x float> %386, i32 1
  %388 = call float @llvm.fmuladd.f32(float %385, float %387, float %383)
  %389 = load <4 x float>* %tempA3, align 16
  %390 = extractelement <4 x float> %389, i32 3
  %391 = load <4 x float>* %tempB3, align 16
  %392 = extractelement <4 x float> %391, i32 1
  %393 = call float @llvm.fmuladd.f32(float %390, float %392, float %388)
  %394 = load <4 x float>* %sum3, align 16
  %395 = extractelement <4 x float> %394, i32 1
  %add104 = fadd float %395, %393
  %396 = load <4 x float>* %sum3, align 16
  %397 = insertelement <4 x float> %396, float %add104, i32 1
  store <4 x float> %397, <4 x float>* %sum3, align 16
  %398 = load <4 x float>* %tempA3, align 16
  %399 = extractelement <4 x float> %398, i32 0
  %400 = load <4 x float>* %tempB0, align 16
  %401 = extractelement <4 x float> %400, i32 2
  %402 = load <4 x float>* %tempA3, align 16
  %403 = extractelement <4 x float> %402, i32 1
  %404 = load <4 x float>* %tempB1, align 16
  %405 = extractelement <4 x float> %404, i32 2
  %mul105 = fmul float %403, %405
  %406 = call float @llvm.fmuladd.f32(float %399, float %401, float %mul105)
  %407 = load <4 x float>* %tempA3, align 16
  %408 = extractelement <4 x float> %407, i32 2
  %409 = load <4 x float>* %tempB2, align 16
  %410 = extractelement <4 x float> %409, i32 2
  %411 = call float @llvm.fmuladd.f32(float %408, float %410, float %406)
  %412 = load <4 x float>* %tempA3, align 16
  %413 = extractelement <4 x float> %412, i32 3
  %414 = load <4 x float>* %tempB3, align 16
  %415 = extractelement <4 x float> %414, i32 2
  %416 = call float @llvm.fmuladd.f32(float %413, float %415, float %411)
  %417 = load <4 x float>* %sum3, align 16
  %418 = extractelement <4 x float> %417, i32 2
  %add106 = fadd float %418, %416
  %419 = load <4 x float>* %sum3, align 16
  %420 = insertelement <4 x float> %419, float %add106, i32 2
  store <4 x float> %420, <4 x float>* %sum3, align 16
  %421 = load <4 x float>* %tempA3, align 16
  %422 = extractelement <4 x float> %421, i32 0
  %423 = load <4 x float>* %tempB0, align 16
  %424 = extractelement <4 x float> %423, i32 3
  %425 = load <4 x float>* %tempA3, align 16
  %426 = extractelement <4 x float> %425, i32 1
  %427 = load <4 x float>* %tempB1, align 16
  %428 = extractelement <4 x float> %427, i32 3
  %mul107 = fmul float %426, %428
  %429 = call float @llvm.fmuladd.f32(float %422, float %424, float %mul107)
  %430 = load <4 x float>* %tempA3, align 16
  %431 = extractelement <4 x float> %430, i32 2
  %432 = load <4 x float>* %tempB2, align 16
  %433 = extractelement <4 x float> %432, i32 3
  %434 = call float @llvm.fmuladd.f32(float %431, float %433, float %429)
  %435 = load <4 x float>* %tempA3, align 16
  %436 = extractelement <4 x float> %435, i32 3
  %437 = load <4 x float>* %tempB3, align 16
  %438 = extractelement <4 x float> %437, i32 3
  %439 = call float @llvm.fmuladd.f32(float %436, float %438, float %434)
  %440 = load <4 x float>* %sum3, align 16
  %441 = extractelement <4 x float> %440, i32 3
  %add108 = fadd float %441, %439
  %442 = load <4 x float>* %sum3, align 16
  %443 = insertelement <4 x float> %442, float %add108, i32 3
  store <4 x float> %443, <4 x float>* %sum3, align 16
  %444 = load <4 x float>* %tempA4, align 16
  %445 = extractelement <4 x float> %444, i32 0
  %446 = load <4 x float>* %tempB0, align 16
  %447 = extractelement <4 x float> %446, i32 0
  %448 = load <4 x float>* %tempA4, align 16
  %449 = extractelement <4 x float> %448, i32 1
  %450 = load <4 x float>* %tempB1, align 16
  %451 = extractelement <4 x float> %450, i32 0
  %mul109 = fmul float %449, %451
  %452 = call float @llvm.fmuladd.f32(float %445, float %447, float %mul109)
  %453 = load <4 x float>* %tempA4, align 16
  %454 = extractelement <4 x float> %453, i32 2
  %455 = load <4 x float>* %tempB2, align 16
  %456 = extractelement <4 x float> %455, i32 0
  %457 = call float @llvm.fmuladd.f32(float %454, float %456, float %452)
  %458 = load <4 x float>* %tempA4, align 16
  %459 = extractelement <4 x float> %458, i32 3
  %460 = load <4 x float>* %tempB3, align 16
  %461 = extractelement <4 x float> %460, i32 0
  %462 = call float @llvm.fmuladd.f32(float %459, float %461, float %457)
  %463 = load <4 x float>* %sum4, align 16
  %464 = extractelement <4 x float> %463, i32 0
  %add110 = fadd float %464, %462
  %465 = load <4 x float>* %sum4, align 16
  %466 = insertelement <4 x float> %465, float %add110, i32 0
  store <4 x float> %466, <4 x float>* %sum4, align 16
  %467 = load <4 x float>* %tempA4, align 16
  %468 = extractelement <4 x float> %467, i32 0
  %469 = load <4 x float>* %tempB0, align 16
  %470 = extractelement <4 x float> %469, i32 1
  %471 = load <4 x float>* %tempA4, align 16
  %472 = extractelement <4 x float> %471, i32 1
  %473 = load <4 x float>* %tempB1, align 16
  %474 = extractelement <4 x float> %473, i32 1
  %mul111 = fmul float %472, %474
  %475 = call float @llvm.fmuladd.f32(float %468, float %470, float %mul111)
  %476 = load <4 x float>* %tempA4, align 16
  %477 = extractelement <4 x float> %476, i32 2
  %478 = load <4 x float>* %tempB2, align 16
  %479 = extractelement <4 x float> %478, i32 1
  %480 = call float @llvm.fmuladd.f32(float %477, float %479, float %475)
  %481 = load <4 x float>* %tempA4, align 16
  %482 = extractelement <4 x float> %481, i32 3
  %483 = load <4 x float>* %tempB3, align 16
  %484 = extractelement <4 x float> %483, i32 1
  %485 = call float @llvm.fmuladd.f32(float %482, float %484, float %480)
  %486 = load <4 x float>* %sum4, align 16
  %487 = extractelement <4 x float> %486, i32 1
  %add112 = fadd float %487, %485
  %488 = load <4 x float>* %sum4, align 16
  %489 = insertelement <4 x float> %488, float %add112, i32 1
  store <4 x float> %489, <4 x float>* %sum4, align 16
  %490 = load <4 x float>* %tempA4, align 16
  %491 = extractelement <4 x float> %490, i32 0
  %492 = load <4 x float>* %tempB0, align 16
  %493 = extractelement <4 x float> %492, i32 2
  %494 = load <4 x float>* %tempA4, align 16
  %495 = extractelement <4 x float> %494, i32 1
  %496 = load <4 x float>* %tempB1, align 16
  %497 = extractelement <4 x float> %496, i32 2
  %mul113 = fmul float %495, %497
  %498 = call float @llvm.fmuladd.f32(float %491, float %493, float %mul113)
  %499 = load <4 x float>* %tempA4, align 16
  %500 = extractelement <4 x float> %499, i32 2
  %501 = load <4 x float>* %tempB2, align 16
  %502 = extractelement <4 x float> %501, i32 2
  %503 = call float @llvm.fmuladd.f32(float %500, float %502, float %498)
  %504 = load <4 x float>* %tempA4, align 16
  %505 = extractelement <4 x float> %504, i32 3
  %506 = load <4 x float>* %tempB3, align 16
  %507 = extractelement <4 x float> %506, i32 2
  %508 = call float @llvm.fmuladd.f32(float %505, float %507, float %503)
  %509 = load <4 x float>* %sum4, align 16
  %510 = extractelement <4 x float> %509, i32 2
  %add114 = fadd float %510, %508
  %511 = load <4 x float>* %sum4, align 16
  %512 = insertelement <4 x float> %511, float %add114, i32 2
  store <4 x float> %512, <4 x float>* %sum4, align 16
  %513 = load <4 x float>* %tempA4, align 16
  %514 = extractelement <4 x float> %513, i32 0
  %515 = load <4 x float>* %tempB0, align 16
  %516 = extractelement <4 x float> %515, i32 3
  %517 = load <4 x float>* %tempA4, align 16
  %518 = extractelement <4 x float> %517, i32 1
  %519 = load <4 x float>* %tempB1, align 16
  %520 = extractelement <4 x float> %519, i32 3
  %mul115 = fmul float %518, %520
  %521 = call float @llvm.fmuladd.f32(float %514, float %516, float %mul115)
  %522 = load <4 x float>* %tempA4, align 16
  %523 = extractelement <4 x float> %522, i32 2
  %524 = load <4 x float>* %tempB2, align 16
  %525 = extractelement <4 x float> %524, i32 3
  %526 = call float @llvm.fmuladd.f32(float %523, float %525, float %521)
  %527 = load <4 x float>* %tempA4, align 16
  %528 = extractelement <4 x float> %527, i32 3
  %529 = load <4 x float>* %tempB3, align 16
  %530 = extractelement <4 x float> %529, i32 3
  %531 = call float @llvm.fmuladd.f32(float %528, float %530, float %526)
  %532 = load <4 x float>* %sum4, align 16
  %533 = extractelement <4 x float> %532, i32 3
  %add116 = fadd float %533, %531
  %534 = load <4 x float>* %sum4, align 16
  %535 = insertelement <4 x float> %534, float %add116, i32 3
  store <4 x float> %535, <4 x float>* %sum4, align 16
  %536 = load <4 x float>* %tempA5, align 16
  %537 = extractelement <4 x float> %536, i32 0
  %538 = load <4 x float>* %tempB0, align 16
  %539 = extractelement <4 x float> %538, i32 0
  %540 = load <4 x float>* %tempA5, align 16
  %541 = extractelement <4 x float> %540, i32 1
  %542 = load <4 x float>* %tempB1, align 16
  %543 = extractelement <4 x float> %542, i32 0
  %mul117 = fmul float %541, %543
  %544 = call float @llvm.fmuladd.f32(float %537, float %539, float %mul117)
  %545 = load <4 x float>* %tempA5, align 16
  %546 = extractelement <4 x float> %545, i32 2
  %547 = load <4 x float>* %tempB2, align 16
  %548 = extractelement <4 x float> %547, i32 0
  %549 = call float @llvm.fmuladd.f32(float %546, float %548, float %544)
  %550 = load <4 x float>* %tempA5, align 16
  %551 = extractelement <4 x float> %550, i32 3
  %552 = load <4 x float>* %tempB3, align 16
  %553 = extractelement <4 x float> %552, i32 0
  %554 = call float @llvm.fmuladd.f32(float %551, float %553, float %549)
  %555 = load <4 x float>* %sum5, align 16
  %556 = extractelement <4 x float> %555, i32 0
  %add118 = fadd float %556, %554
  %557 = load <4 x float>* %sum5, align 16
  %558 = insertelement <4 x float> %557, float %add118, i32 0
  store <4 x float> %558, <4 x float>* %sum5, align 16
  %559 = load <4 x float>* %tempA5, align 16
  %560 = extractelement <4 x float> %559, i32 0
  %561 = load <4 x float>* %tempB0, align 16
  %562 = extractelement <4 x float> %561, i32 1
  %563 = load <4 x float>* %tempA5, align 16
  %564 = extractelement <4 x float> %563, i32 1
  %565 = load <4 x float>* %tempB1, align 16
  %566 = extractelement <4 x float> %565, i32 1
  %mul119 = fmul float %564, %566
  %567 = call float @llvm.fmuladd.f32(float %560, float %562, float %mul119)
  %568 = load <4 x float>* %tempA5, align 16
  %569 = extractelement <4 x float> %568, i32 2
  %570 = load <4 x float>* %tempB2, align 16
  %571 = extractelement <4 x float> %570, i32 1
  %572 = call float @llvm.fmuladd.f32(float %569, float %571, float %567)
  %573 = load <4 x float>* %tempA5, align 16
  %574 = extractelement <4 x float> %573, i32 3
  %575 = load <4 x float>* %tempB3, align 16
  %576 = extractelement <4 x float> %575, i32 1
  %577 = call float @llvm.fmuladd.f32(float %574, float %576, float %572)
  %578 = load <4 x float>* %sum5, align 16
  %579 = extractelement <4 x float> %578, i32 1
  %add120 = fadd float %579, %577
  %580 = load <4 x float>* %sum5, align 16
  %581 = insertelement <4 x float> %580, float %add120, i32 1
  store <4 x float> %581, <4 x float>* %sum5, align 16
  %582 = load <4 x float>* %tempA5, align 16
  %583 = extractelement <4 x float> %582, i32 0
  %584 = load <4 x float>* %tempB0, align 16
  %585 = extractelement <4 x float> %584, i32 2
  %586 = load <4 x float>* %tempA5, align 16
  %587 = extractelement <4 x float> %586, i32 1
  %588 = load <4 x float>* %tempB1, align 16
  %589 = extractelement <4 x float> %588, i32 2
  %mul121 = fmul float %587, %589
  %590 = call float @llvm.fmuladd.f32(float %583, float %585, float %mul121)
  %591 = load <4 x float>* %tempA5, align 16
  %592 = extractelement <4 x float> %591, i32 2
  %593 = load <4 x float>* %tempB2, align 16
  %594 = extractelement <4 x float> %593, i32 2
  %595 = call float @llvm.fmuladd.f32(float %592, float %594, float %590)
  %596 = load <4 x float>* %tempA5, align 16
  %597 = extractelement <4 x float> %596, i32 3
  %598 = load <4 x float>* %tempB3, align 16
  %599 = extractelement <4 x float> %598, i32 2
  %600 = call float @llvm.fmuladd.f32(float %597, float %599, float %595)
  %601 = load <4 x float>* %sum5, align 16
  %602 = extractelement <4 x float> %601, i32 2
  %add122 = fadd float %602, %600
  %603 = load <4 x float>* %sum5, align 16
  %604 = insertelement <4 x float> %603, float %add122, i32 2
  store <4 x float> %604, <4 x float>* %sum5, align 16
  %605 = load <4 x float>* %tempA5, align 16
  %606 = extractelement <4 x float> %605, i32 0
  %607 = load <4 x float>* %tempB0, align 16
  %608 = extractelement <4 x float> %607, i32 3
  %609 = load <4 x float>* %tempA5, align 16
  %610 = extractelement <4 x float> %609, i32 1
  %611 = load <4 x float>* %tempB1, align 16
  %612 = extractelement <4 x float> %611, i32 3
  %mul123 = fmul float %610, %612
  %613 = call float @llvm.fmuladd.f32(float %606, float %608, float %mul123)
  %614 = load <4 x float>* %tempA5, align 16
  %615 = extractelement <4 x float> %614, i32 2
  %616 = load <4 x float>* %tempB2, align 16
  %617 = extractelement <4 x float> %616, i32 3
  %618 = call float @llvm.fmuladd.f32(float %615, float %617, float %613)
  %619 = load <4 x float>* %tempA5, align 16
  %620 = extractelement <4 x float> %619, i32 3
  %621 = load <4 x float>* %tempB3, align 16
  %622 = extractelement <4 x float> %621, i32 3
  %623 = call float @llvm.fmuladd.f32(float %620, float %622, float %618)
  %624 = load <4 x float>* %sum5, align 16
  %625 = extractelement <4 x float> %624, i32 3
  %add124 = fadd float %625, %623
  %626 = load <4 x float>* %sum5, align 16
  %627 = insertelement <4 x float> %626, float %add124, i32 3
  store <4 x float> %627, <4 x float>* %sum5, align 16
  %628 = load <4 x float>* %tempA6, align 16
  %629 = extractelement <4 x float> %628, i32 0
  %630 = load <4 x float>* %tempB0, align 16
  %631 = extractelement <4 x float> %630, i32 0
  %632 = load <4 x float>* %tempA6, align 16
  %633 = extractelement <4 x float> %632, i32 1
  %634 = load <4 x float>* %tempB1, align 16
  %635 = extractelement <4 x float> %634, i32 0
  %mul125 = fmul float %633, %635
  %636 = call float @llvm.fmuladd.f32(float %629, float %631, float %mul125)
  %637 = load <4 x float>* %tempA6, align 16
  %638 = extractelement <4 x float> %637, i32 2
  %639 = load <4 x float>* %tempB2, align 16
  %640 = extractelement <4 x float> %639, i32 0
  %641 = call float @llvm.fmuladd.f32(float %638, float %640, float %636)
  %642 = load <4 x float>* %tempA6, align 16
  %643 = extractelement <4 x float> %642, i32 3
  %644 = load <4 x float>* %tempB3, align 16
  %645 = extractelement <4 x float> %644, i32 0
  %646 = call float @llvm.fmuladd.f32(float %643, float %645, float %641)
  %647 = load <4 x float>* %sum6, align 16
  %648 = extractelement <4 x float> %647, i32 0
  %add126 = fadd float %648, %646
  %649 = load <4 x float>* %sum6, align 16
  %650 = insertelement <4 x float> %649, float %add126, i32 0
  store <4 x float> %650, <4 x float>* %sum6, align 16
  %651 = load <4 x float>* %tempA6, align 16
  %652 = extractelement <4 x float> %651, i32 0
  %653 = load <4 x float>* %tempB0, align 16
  %654 = extractelement <4 x float> %653, i32 1
  %655 = load <4 x float>* %tempA6, align 16
  %656 = extractelement <4 x float> %655, i32 1
  %657 = load <4 x float>* %tempB1, align 16
  %658 = extractelement <4 x float> %657, i32 1
  %mul127 = fmul float %656, %658
  %659 = call float @llvm.fmuladd.f32(float %652, float %654, float %mul127)
  %660 = load <4 x float>* %tempA6, align 16
  %661 = extractelement <4 x float> %660, i32 2
  %662 = load <4 x float>* %tempB2, align 16
  %663 = extractelement <4 x float> %662, i32 1
  %664 = call float @llvm.fmuladd.f32(float %661, float %663, float %659)
  %665 = load <4 x float>* %tempA6, align 16
  %666 = extractelement <4 x float> %665, i32 3
  %667 = load <4 x float>* %tempB3, align 16
  %668 = extractelement <4 x float> %667, i32 1
  %669 = call float @llvm.fmuladd.f32(float %666, float %668, float %664)
  %670 = load <4 x float>* %sum6, align 16
  %671 = extractelement <4 x float> %670, i32 1
  %add128 = fadd float %671, %669
  %672 = load <4 x float>* %sum6, align 16
  %673 = insertelement <4 x float> %672, float %add128, i32 1
  store <4 x float> %673, <4 x float>* %sum6, align 16
  %674 = load <4 x float>* %tempA6, align 16
  %675 = extractelement <4 x float> %674, i32 0
  %676 = load <4 x float>* %tempB0, align 16
  %677 = extractelement <4 x float> %676, i32 2
  %678 = load <4 x float>* %tempA6, align 16
  %679 = extractelement <4 x float> %678, i32 1
  %680 = load <4 x float>* %tempB1, align 16
  %681 = extractelement <4 x float> %680, i32 2
  %mul129 = fmul float %679, %681
  %682 = call float @llvm.fmuladd.f32(float %675, float %677, float %mul129)
  %683 = load <4 x float>* %tempA6, align 16
  %684 = extractelement <4 x float> %683, i32 2
  %685 = load <4 x float>* %tempB2, align 16
  %686 = extractelement <4 x float> %685, i32 2
  %687 = call float @llvm.fmuladd.f32(float %684, float %686, float %682)
  %688 = load <4 x float>* %tempA6, align 16
  %689 = extractelement <4 x float> %688, i32 3
  %690 = load <4 x float>* %tempB3, align 16
  %691 = extractelement <4 x float> %690, i32 2
  %692 = call float @llvm.fmuladd.f32(float %689, float %691, float %687)
  %693 = load <4 x float>* %sum6, align 16
  %694 = extractelement <4 x float> %693, i32 2
  %add130 = fadd float %694, %692
  %695 = load <4 x float>* %sum6, align 16
  %696 = insertelement <4 x float> %695, float %add130, i32 2
  store <4 x float> %696, <4 x float>* %sum6, align 16
  %697 = load <4 x float>* %tempA6, align 16
  %698 = extractelement <4 x float> %697, i32 0
  %699 = load <4 x float>* %tempB0, align 16
  %700 = extractelement <4 x float> %699, i32 3
  %701 = load <4 x float>* %tempA6, align 16
  %702 = extractelement <4 x float> %701, i32 1
  %703 = load <4 x float>* %tempB1, align 16
  %704 = extractelement <4 x float> %703, i32 3
  %mul131 = fmul float %702, %704
  %705 = call float @llvm.fmuladd.f32(float %698, float %700, float %mul131)
  %706 = load <4 x float>* %tempA6, align 16
  %707 = extractelement <4 x float> %706, i32 2
  %708 = load <4 x float>* %tempB2, align 16
  %709 = extractelement <4 x float> %708, i32 3
  %710 = call float @llvm.fmuladd.f32(float %707, float %709, float %705)
  %711 = load <4 x float>* %tempA6, align 16
  %712 = extractelement <4 x float> %711, i32 3
  %713 = load <4 x float>* %tempB3, align 16
  %714 = extractelement <4 x float> %713, i32 3
  %715 = call float @llvm.fmuladd.f32(float %712, float %714, float %710)
  %716 = load <4 x float>* %sum6, align 16
  %717 = extractelement <4 x float> %716, i32 3
  %add132 = fadd float %717, %715
  %718 = load <4 x float>* %sum6, align 16
  %719 = insertelement <4 x float> %718, float %add132, i32 3
  store <4 x float> %719, <4 x float>* %sum6, align 16
  %720 = load <4 x float>* %tempA7, align 16
  %721 = extractelement <4 x float> %720, i32 0
  %722 = load <4 x float>* %tempB0, align 16
  %723 = extractelement <4 x float> %722, i32 0
  %724 = load <4 x float>* %tempA7, align 16
  %725 = extractelement <4 x float> %724, i32 1
  %726 = load <4 x float>* %tempB1, align 16
  %727 = extractelement <4 x float> %726, i32 0
  %mul133 = fmul float %725, %727
  %728 = call float @llvm.fmuladd.f32(float %721, float %723, float %mul133)
  %729 = load <4 x float>* %tempA7, align 16
  %730 = extractelement <4 x float> %729, i32 2
  %731 = load <4 x float>* %tempB2, align 16
  %732 = extractelement <4 x float> %731, i32 0
  %733 = call float @llvm.fmuladd.f32(float %730, float %732, float %728)
  %734 = load <4 x float>* %tempA7, align 16
  %735 = extractelement <4 x float> %734, i32 3
  %736 = load <4 x float>* %tempB3, align 16
  %737 = extractelement <4 x float> %736, i32 0
  %738 = call float @llvm.fmuladd.f32(float %735, float %737, float %733)
  %739 = load <4 x float>* %sum7, align 16
  %740 = extractelement <4 x float> %739, i32 0
  %add134 = fadd float %740, %738
  %741 = load <4 x float>* %sum7, align 16
  %742 = insertelement <4 x float> %741, float %add134, i32 0
  store <4 x float> %742, <4 x float>* %sum7, align 16
  %743 = load <4 x float>* %tempA7, align 16
  %744 = extractelement <4 x float> %743, i32 0
  %745 = load <4 x float>* %tempB0, align 16
  %746 = extractelement <4 x float> %745, i32 1
  %747 = load <4 x float>* %tempA7, align 16
  %748 = extractelement <4 x float> %747, i32 1
  %749 = load <4 x float>* %tempB1, align 16
  %750 = extractelement <4 x float> %749, i32 1
  %mul135 = fmul float %748, %750
  %751 = call float @llvm.fmuladd.f32(float %744, float %746, float %mul135)
  %752 = load <4 x float>* %tempA7, align 16
  %753 = extractelement <4 x float> %752, i32 2
  %754 = load <4 x float>* %tempB2, align 16
  %755 = extractelement <4 x float> %754, i32 1
  %756 = call float @llvm.fmuladd.f32(float %753, float %755, float %751)
  %757 = load <4 x float>* %tempA7, align 16
  %758 = extractelement <4 x float> %757, i32 3
  %759 = load <4 x float>* %tempB3, align 16
  %760 = extractelement <4 x float> %759, i32 1
  %761 = call float @llvm.fmuladd.f32(float %758, float %760, float %756)
  %762 = load <4 x float>* %sum7, align 16
  %763 = extractelement <4 x float> %762, i32 1
  %add136 = fadd float %763, %761
  %764 = load <4 x float>* %sum7, align 16
  %765 = insertelement <4 x float> %764, float %add136, i32 1
  store <4 x float> %765, <4 x float>* %sum7, align 16
  %766 = load <4 x float>* %tempA7, align 16
  %767 = extractelement <4 x float> %766, i32 0
  %768 = load <4 x float>* %tempB0, align 16
  %769 = extractelement <4 x float> %768, i32 2
  %770 = load <4 x float>* %tempA7, align 16
  %771 = extractelement <4 x float> %770, i32 1
  %772 = load <4 x float>* %tempB1, align 16
  %773 = extractelement <4 x float> %772, i32 2
  %mul137 = fmul float %771, %773
  %774 = call float @llvm.fmuladd.f32(float %767, float %769, float %mul137)
  %775 = load <4 x float>* %tempA7, align 16
  %776 = extractelement <4 x float> %775, i32 2
  %777 = load <4 x float>* %tempB2, align 16
  %778 = extractelement <4 x float> %777, i32 2
  %779 = call float @llvm.fmuladd.f32(float %776, float %778, float %774)
  %780 = load <4 x float>* %tempA7, align 16
  %781 = extractelement <4 x float> %780, i32 3
  %782 = load <4 x float>* %tempB3, align 16
  %783 = extractelement <4 x float> %782, i32 2
  %784 = call float @llvm.fmuladd.f32(float %781, float %783, float %779)
  %785 = load <4 x float>* %sum7, align 16
  %786 = extractelement <4 x float> %785, i32 2
  %add138 = fadd float %786, %784
  %787 = load <4 x float>* %sum7, align 16
  %788 = insertelement <4 x float> %787, float %add138, i32 2
  store <4 x float> %788, <4 x float>* %sum7, align 16
  %789 = load <4 x float>* %tempA7, align 16
  %790 = extractelement <4 x float> %789, i32 0
  %791 = load <4 x float>* %tempB0, align 16
  %792 = extractelement <4 x float> %791, i32 3
  %793 = load <4 x float>* %tempA7, align 16
  %794 = extractelement <4 x float> %793, i32 1
  %795 = load <4 x float>* %tempB1, align 16
  %796 = extractelement <4 x float> %795, i32 3
  %mul139 = fmul float %794, %796
  %797 = call float @llvm.fmuladd.f32(float %790, float %792, float %mul139)
  %798 = load <4 x float>* %tempA7, align 16
  %799 = extractelement <4 x float> %798, i32 2
  %800 = load <4 x float>* %tempB2, align 16
  %801 = extractelement <4 x float> %800, i32 3
  %802 = call float @llvm.fmuladd.f32(float %799, float %801, float %797)
  %803 = load <4 x float>* %tempA7, align 16
  %804 = extractelement <4 x float> %803, i32 3
  %805 = load <4 x float>* %tempB3, align 16
  %806 = extractelement <4 x float> %805, i32 3
  %807 = call float @llvm.fmuladd.f32(float %804, float %806, float %802)
  %808 = load <4 x float>* %sum7, align 16
  %809 = extractelement <4 x float> %808, i32 3
  %add140 = fadd float %809, %807
  %810 = load <4 x float>* %sum7, align 16
  %811 = insertelement <4 x float> %810, float %add140, i32 3
  store <4 x float> %811, <4 x float>* %sum7, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %812 = load i32* %i, align 4
  %add141 = add nsw i32 %812, 4
  store i32 %add141, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %813 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %814 = load <2 x i32>* %pos, align 8
  %815 = extractelement <2 x i32> %814, i32 0
  %vecinit143 = insertelement <2 x i32> undef, i32 %815, i32 0
  %816 = load <2 x i32>* %pos, align 8
  %817 = extractelement <2 x i32> %816, i32 1
  %mul = mul nsw i32 %817, 8
  %vecinit144 = insertelement <2 x i32> %vecinit143, i32 %mul, i32 1
  store <2 x i32> %vecinit144, <2 x i32>* %.compoundliteral142
  %818 = load <2 x i32>* %.compoundliteral142
  %819 = load <4 x float>* %sum0, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %813, <2 x i32> %818, <4 x float> %819)
  %820 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %821 = load <2 x i32>* %pos, align 8
  %822 = extractelement <2 x i32> %821, i32 0
  %vecinit146 = insertelement <2 x i32> undef, i32 %822, i32 0
  %823 = load <2 x i32>* %pos, align 8
  %824 = extractelement <2 x i32> %823, i32 1
  %mul147 = mul nsw i32 %824, 8
  %add148 = add nsw i32 %mul147, 1
  %vecinit149 = insertelement <2 x i32> %vecinit146, i32 %add148, i32 1
  store <2 x i32> %vecinit149, <2 x i32>* %.compoundliteral145
  %825 = load <2 x i32>* %.compoundliteral145
  %826 = load <4 x float>* %sum1, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %820, <2 x i32> %825, <4 x float> %826)
  %827 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %828 = load <2 x i32>* %pos, align 8
  %829 = extractelement <2 x i32> %828, i32 0
  %vecinit151 = insertelement <2 x i32> undef, i32 %829, i32 0
  %830 = load <2 x i32>* %pos, align 8
  %831 = extractelement <2 x i32> %830, i32 1
  %mul152 = mul nsw i32 %831, 8
  %add153 = add nsw i32 %mul152, 2
  %vecinit154 = insertelement <2 x i32> %vecinit151, i32 %add153, i32 1
  store <2 x i32> %vecinit154, <2 x i32>* %.compoundliteral150
  %832 = load <2 x i32>* %.compoundliteral150
  %833 = load <4 x float>* %sum2, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %827, <2 x i32> %832, <4 x float> %833)
  %834 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %835 = load <2 x i32>* %pos, align 8
  %836 = extractelement <2 x i32> %835, i32 0
  %vecinit156 = insertelement <2 x i32> undef, i32 %836, i32 0
  %837 = load <2 x i32>* %pos, align 8
  %838 = extractelement <2 x i32> %837, i32 1
  %mul157 = mul nsw i32 %838, 8
  %add158 = add nsw i32 %mul157, 3
  %vecinit159 = insertelement <2 x i32> %vecinit156, i32 %add158, i32 1
  store <2 x i32> %vecinit159, <2 x i32>* %.compoundliteral155
  %839 = load <2 x i32>* %.compoundliteral155
  %840 = load <4 x float>* %sum3, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %834, <2 x i32> %839, <4 x float> %840)
  %841 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %842 = load <2 x i32>* %pos, align 8
  %843 = extractelement <2 x i32> %842, i32 0
  %vecinit161 = insertelement <2 x i32> undef, i32 %843, i32 0
  %844 = load <2 x i32>* %pos, align 8
  %845 = extractelement <2 x i32> %844, i32 1
  %mul162 = mul nsw i32 %845, 8
  %add163 = add nsw i32 %mul162, 4
  %vecinit164 = insertelement <2 x i32> %vecinit161, i32 %add163, i32 1
  store <2 x i32> %vecinit164, <2 x i32>* %.compoundliteral160
  %846 = load <2 x i32>* %.compoundliteral160
  %847 = load <4 x float>* %sum4, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %841, <2 x i32> %846, <4 x float> %847)
  %848 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %849 = load <2 x i32>* %pos, align 8
  %850 = extractelement <2 x i32> %849, i32 0
  %vecinit166 = insertelement <2 x i32> undef, i32 %850, i32 0
  %851 = load <2 x i32>* %pos, align 8
  %852 = extractelement <2 x i32> %851, i32 1
  %mul167 = mul nsw i32 %852, 8
  %add168 = add nsw i32 %mul167, 5
  %vecinit169 = insertelement <2 x i32> %vecinit166, i32 %add168, i32 1
  store <2 x i32> %vecinit169, <2 x i32>* %.compoundliteral165
  %853 = load <2 x i32>* %.compoundliteral165
  %854 = load <4 x float>* %sum5, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %848, <2 x i32> %853, <4 x float> %854)
  %855 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %856 = load <2 x i32>* %pos, align 8
  %857 = extractelement <2 x i32> %856, i32 0
  %vecinit171 = insertelement <2 x i32> undef, i32 %857, i32 0
  %858 = load <2 x i32>* %pos, align 8
  %859 = extractelement <2 x i32> %858, i32 1
  %mul172 = mul nsw i32 %859, 8
  %add173 = add nsw i32 %mul172, 6
  %vecinit174 = insertelement <2 x i32> %vecinit171, i32 %add173, i32 1
  store <2 x i32> %vecinit174, <2 x i32>* %.compoundliteral170
  %860 = load <2 x i32>* %.compoundliteral170
  %861 = load <4 x float>* %sum6, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %855, <2 x i32> %860, <4 x float> %861)
  %862 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %863 = load <2 x i32>* %pos, align 8
  %864 = extractelement <2 x i32> %863, i32 0
  %vecinit176 = insertelement <2 x i32> undef, i32 %864, i32 0
  %865 = load <2 x i32>* %pos, align 8
  %866 = extractelement <2 x i32> %865, i32 1
  %mul177 = mul nsw i32 %866, 8
  %add178 = add nsw i32 %mul177, 7
  %vecinit179 = insertelement <2 x i32> %vecinit176, i32 %add178, i32 1
  store <2 x i32> %vecinit179, <2 x i32>* %.compoundliteral175
  %867 = load <2 x i32>* %.compoundliteral175
  %868 = load <4 x float>* %sum7, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %862, <2 x i32> %867, <4 x float> %868)
  ret void
}

; Function Attrs: nounwind
define cc75 <4 x float> @mat_mult_mini(<4 x float> %a, <4 x float> %b0, <4 x float> %b1, <4 x float> %b2, <4 x float> %b3, <4 x float> %c) #0 {
entry:
  %a.addr = alloca <4 x float>, align 16
  %b0.addr = alloca <4 x float>, align 16
  %b1.addr = alloca <4 x float>, align 16
  %b2.addr = alloca <4 x float>, align 16
  %b3.addr = alloca <4 x float>, align 16
  %c.addr = alloca <4 x float>, align 16
  %tmp = alloca <4 x float>, align 16
  store <4 x float> %a, <4 x float>* %a.addr, align 16
  store <4 x float> %b0, <4 x float>* %b0.addr, align 16
  store <4 x float> %b1, <4 x float>* %b1.addr, align 16
  store <4 x float> %b2, <4 x float>* %b2.addr, align 16
  store <4 x float> %b3, <4 x float>* %b3.addr, align 16
  store <4 x float> %c, <4 x float>* %c.addr, align 16
  %0 = load <4 x float>* %a.addr, align 16
  %1 = extractelement <4 x float> %0, i32 0
  %2 = insertelement <4 x float> undef, float %1, i32 0
  %splat = shufflevector <4 x float> %2, <4 x float> %2, <4 x i32> zeroinitializer
  %3 = load <4 x float>* %b0.addr, align 16
  %4 = load <4 x float>* %c.addr, align 16
  %call = call cc75 <4 x float> @_Z3madDv4_fS_S_(<4 x float> %splat, <4 x float> %3, <4 x float> %4) #1
  store <4 x float> %call, <4 x float>* %tmp, align 16
  %5 = load <4 x float>* %a.addr, align 16
  %6 = extractelement <4 x float> %5, i32 1
  %7 = insertelement <4 x float> undef, float %6, i32 0
  %splat1 = shufflevector <4 x float> %7, <4 x float> %7, <4 x i32> zeroinitializer
  %8 = load <4 x float>* %b1.addr, align 16
  %9 = load <4 x float>* %tmp, align 16
  %call2 = call cc75 <4 x float> @_Z3madDv4_fS_S_(<4 x float> %splat1, <4 x float> %8, <4 x float> %9) #1
  store <4 x float> %call2, <4 x float>* %tmp, align 16
  %10 = load <4 x float>* %a.addr, align 16
  %11 = extractelement <4 x float> %10, i32 2
  %12 = insertelement <4 x float> undef, float %11, i32 0
  %splat3 = shufflevector <4 x float> %12, <4 x float> %12, <4 x i32> zeroinitializer
  %13 = load <4 x float>* %b2.addr, align 16
  %14 = load <4 x float>* %tmp, align 16
  %call4 = call cc75 <4 x float> @_Z3madDv4_fS_S_(<4 x float> %splat3, <4 x float> %13, <4 x float> %14) #1
  store <4 x float> %call4, <4 x float>* %tmp, align 16
  %15 = load <4 x float>* %a.addr, align 16
  %16 = extractelement <4 x float> %15, i32 3
  %17 = insertelement <4 x float> undef, float %16, i32 0
  %splat5 = shufflevector <4 x float> %17, <4 x float> %17, <4 x i32> zeroinitializer
  %18 = load <4 x float>* %b3.addr, align 16
  %19 = load <4 x float>* %tmp, align 16
  %call6 = call cc75 <4 x float> @_Z3madDv4_fS_S_(<4 x float> %splat5, <4 x float> %18, <4 x float> %19) #1
  store <4 x float> %call6, <4 x float>* %tmp, align 16
  %20 = load <4 x float>* %tmp, align 16
  ret <4 x float> %20
}

; Function Attrs: nounwind readnone
declare cc75 <4 x float> @_Z3madDv4_fS_S_(<4 x float>, <4 x float>, <4 x float>) #1

; Function Attrs: nounwind
define cc75 <4 x float> @mat_mult_pre(<4 x float> %a, <4 x float> %b0, <4 x float> %b1, <4 x float> %b2, <4 x float> %b3) #0 {
entry:
  %a.addr = alloca <4 x float>, align 16
  %b0.addr = alloca <4 x float>, align 16
  %b1.addr = alloca <4 x float>, align 16
  %b2.addr = alloca <4 x float>, align 16
  %b3.addr = alloca <4 x float>, align 16
  %tmp = alloca <4 x float>, align 16
  store <4 x float> %a, <4 x float>* %a.addr, align 16
  store <4 x float> %b0, <4 x float>* %b0.addr, align 16
  store <4 x float> %b1, <4 x float>* %b1.addr, align 16
  store <4 x float> %b2, <4 x float>* %b2.addr, align 16
  store <4 x float> %b3, <4 x float>* %b3.addr, align 16
  %0 = load <4 x float>* %a.addr, align 16
  %1 = extractelement <4 x float> %0, i32 0
  %2 = insertelement <4 x float> undef, float %1, i32 0
  %splat = shufflevector <4 x float> %2, <4 x float> %2, <4 x i32> zeroinitializer
  %3 = load <4 x float>* %b0.addr, align 16
  %mul = fmul <4 x float> %splat, %3
  store <4 x float> %mul, <4 x float>* %tmp, align 16
  %4 = load <4 x float>* %a.addr, align 16
  %5 = extractelement <4 x float> %4, i32 1
  %6 = insertelement <4 x float> undef, float %5, i32 0
  %splat1 = shufflevector <4 x float> %6, <4 x float> %6, <4 x i32> zeroinitializer
  %7 = load <4 x float>* %b1.addr, align 16
  %8 = load <4 x float>* %tmp, align 16
  %call = call cc75 <4 x float> @_Z3madDv4_fS_S_(<4 x float> %splat1, <4 x float> %7, <4 x float> %8) #1
  store <4 x float> %call, <4 x float>* %tmp, align 16
  %9 = load <4 x float>* %a.addr, align 16
  %10 = extractelement <4 x float> %9, i32 2
  %11 = insertelement <4 x float> undef, float %10, i32 0
  %splat2 = shufflevector <4 x float> %11, <4 x float> %11, <4 x i32> zeroinitializer
  %12 = load <4 x float>* %b2.addr, align 16
  %13 = load <4 x float>* %tmp, align 16
  %call3 = call cc75 <4 x float> @_Z3madDv4_fS_S_(<4 x float> %splat2, <4 x float> %12, <4 x float> %13) #1
  store <4 x float> %call3, <4 x float>* %tmp, align 16
  %14 = load <4 x float>* %a.addr, align 16
  %15 = extractelement <4 x float> %14, i32 3
  %16 = insertelement <4 x float> undef, float %15, i32 0
  %splat4 = shufflevector <4 x float> %16, <4 x float> %16, <4 x i32> zeroinitializer
  %17 = load <4 x float>* %b3.addr, align 16
  %18 = load <4 x float>* %tmp, align 16
  %call5 = call cc75 <4 x float> @_Z3madDv4_fS_S_(<4 x float> %splat4, <4 x float> %17, <4 x float> %18) #1
  store <4 x float> %call5, <4 x float>* %tmp, align 16
  %19 = load <4 x float>* %tmp, align 16
  ret <4 x float> %19
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_mmmKernel3_kernel(%opencl.image2d_t addrspace(1)* %matrixA, %opencl.image2d_t addrspace(1)* %matrixB, %opencl.image2d_t addrspace(1)* %matrixC, i32 %widthA, i32 %widthB) #0 {
entry:
  %matrixA.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %matrixB.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %matrixC.addr = alloca %opencl.image2d_t addrspace(1)*, align 8
  %widthA.addr = alloca i32, align 4
  %widthB.addr = alloca i32, align 4
  %pos = alloca <2 x i32>, align 8
  %.compoundliteral = alloca <2 x i32>, align 8
  %sum0 = alloca <4 x float>, align 16
  %sum1 = alloca <4 x float>, align 16
  %sum2 = alloca <4 x float>, align 16
  %sum3 = alloca <4 x float>, align 16
  %sum4 = alloca <4 x float>, align 16
  %sum5 = alloca <4 x float>, align 16
  %sum6 = alloca <4 x float>, align 16
  %sum7 = alloca <4 x float>, align 16
  %offsety = alloca <8 x i32>, align 32
  %.compoundliteral4 = alloca <8 x i32>, align 32
  %offsetx = alloca <4 x i32>, align 16
  %.compoundliteral5 = alloca <4 x i32>, align 16
  %xpos = alloca i32, align 4
  %ypos = alloca i32, align 4
  %ybs = alloca <8 x i32>, align 32
  %j = alloca i32, align 4
  %ib4 = alloca i32, align 4
  %ioff = alloca <4 x i32>, align 16
  %tempA0 = alloca <4 x float>, align 16
  %.compoundliteral6 = alloca <2 x i32>, align 8
  %tempA1 = alloca <4 x float>, align 16
  %.compoundliteral9 = alloca <2 x i32>, align 8
  %tempA2 = alloca <4 x float>, align 16
  %.compoundliteral12 = alloca <2 x i32>, align 8
  %tempA3 = alloca <4 x float>, align 16
  %.compoundliteral15 = alloca <2 x i32>, align 8
  %tempA4 = alloca <4 x float>, align 16
  %.compoundliteral18 = alloca <2 x i32>, align 8
  %tempA5 = alloca <4 x float>, align 16
  %.compoundliteral21 = alloca <2 x i32>, align 8
  %tempA6 = alloca <4 x float>, align 16
  %.compoundliteral24 = alloca <2 x i32>, align 8
  %tempA7 = alloca <4 x float>, align 16
  %.compoundliteral27 = alloca <2 x i32>, align 8
  %tempB0 = alloca <4 x float>, align 16
  %.compoundliteral30 = alloca <2 x i32>, align 8
  %tempB1 = alloca <4 x float>, align 16
  %.compoundliteral34 = alloca <2 x i32>, align 8
  %tempB2 = alloca <4 x float>, align 16
  %.compoundliteral38 = alloca <2 x i32>, align 8
  %tempB3 = alloca <4 x float>, align 16
  %.compoundliteral42 = alloca <2 x i32>, align 8
  %i = alloca i32, align 4
  %ib455 = alloca i32, align 4
  %ioff57 = alloca <4 x i32>, align 16
  %.compoundliteral60 = alloca <2 x i32>, align 8
  %.compoundliteral64 = alloca <2 x i32>, align 8
  %.compoundliteral68 = alloca <2 x i32>, align 8
  %.compoundliteral72 = alloca <2 x i32>, align 8
  %.compoundliteral76 = alloca <2 x i32>, align 8
  %.compoundliteral80 = alloca <2 x i32>, align 8
  %.compoundliteral84 = alloca <2 x i32>, align 8
  %.compoundliteral88 = alloca <2 x i32>, align 8
  %.compoundliteral92 = alloca <2 x i32>, align 8
  %.compoundliteral96 = alloca <2 x i32>, align 8
  %.compoundliteral100 = alloca <2 x i32>, align 8
  %.compoundliteral104 = alloca <2 x i32>, align 8
  %ypos8 = alloca <8 x i32>, align 32
  %.compoundliteral119 = alloca <2 x i32>, align 8
  %.compoundliteral122 = alloca <2 x i32>, align 8
  %.compoundliteral125 = alloca <2 x i32>, align 8
  %.compoundliteral128 = alloca <2 x i32>, align 8
  %.compoundliteral131 = alloca <2 x i32>, align 8
  %.compoundliteral134 = alloca <2 x i32>, align 8
  %.compoundliteral137 = alloca <2 x i32>, align 8
  %.compoundliteral140 = alloca <2 x i32>, align 8
  store %opencl.image2d_t addrspace(1)* %matrixA, %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  store %opencl.image2d_t addrspace(1)* %matrixB, %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  store %opencl.image2d_t addrspace(1)* %matrixC, %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
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
  %1 = load i32* %widthB.addr, align 4
  %shr = lshr i32 %1, 2
  store i32 %shr, i32* %widthB.addr, align 4
  store <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, <8 x i32>* %.compoundliteral4
  %2 = load <8 x i32>* %.compoundliteral4
  store <8 x i32> %2, <8 x i32>* %offsety, align 32
  store <4 x i32> <i32 0, i32 1, i32 2, i32 3>, <4 x i32>* %.compoundliteral5
  %3 = load <4 x i32>* %.compoundliteral5
  store <4 x i32> %3, <4 x i32>* %offsetx, align 16
  %4 = load <2 x i32>* %pos, align 8
  %5 = extractelement <2 x i32> %4, i32 0
  store i32 %5, i32* %xpos, align 4
  %6 = load <2 x i32>* %pos, align 8
  %7 = extractelement <2 x i32> %6, i32 1
  store i32 %7, i32* %ypos, align 4
  %8 = load i32* %ypos, align 4
  %shl = shl i32 %8, 3
  %9 = insertelement <8 x i32> undef, i32 %shl, i32 0
  %splat = shufflevector <8 x i32> %9, <8 x i32> %9, <8 x i32> zeroinitializer
  %10 = load <8 x i32>* %offsety, align 32
  %add = add <8 x i32> %splat, %10
  store <8 x i32> %add, <8 x i32>* %ybs, align 32
  store i32 0, i32* %j, align 4
  store i32 0, i32* %ib4, align 4
  %11 = load <4 x i32>* %offsetx, align 16
  store <4 x i32> %11, <4 x i32>* %ioff, align 16
  %12 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %13 = load i32 addrspace(2)* @imageSampler, align 4
  %14 = load <8 x i32>* %ybs, align 32
  %15 = extractelement <8 x i32> %14, i32 0
  %vecinit7 = insertelement <2 x i32> <i32 0, i32 undef>, i32 %15, i32 1
  store <2 x i32> %vecinit7, <2 x i32>* %.compoundliteral6
  %16 = load <2 x i32>* %.compoundliteral6
  %call8 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %12, i32 %13, <2 x i32> %16) #1
  store <4 x float> %call8, <4 x float>* %tempA0, align 16
  %17 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %18 = load i32 addrspace(2)* @imageSampler, align 4
  %19 = load <8 x i32>* %ybs, align 32
  %20 = extractelement <8 x i32> %19, i32 1
  %vecinit10 = insertelement <2 x i32> <i32 0, i32 undef>, i32 %20, i32 1
  store <2 x i32> %vecinit10, <2 x i32>* %.compoundliteral9
  %21 = load <2 x i32>* %.compoundliteral9
  %call11 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %17, i32 %18, <2 x i32> %21) #1
  store <4 x float> %call11, <4 x float>* %tempA1, align 16
  %22 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %23 = load i32 addrspace(2)* @imageSampler, align 4
  %24 = load <8 x i32>* %ybs, align 32
  %25 = extractelement <8 x i32> %24, i32 2
  %vecinit13 = insertelement <2 x i32> <i32 0, i32 undef>, i32 %25, i32 1
  store <2 x i32> %vecinit13, <2 x i32>* %.compoundliteral12
  %26 = load <2 x i32>* %.compoundliteral12
  %call14 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %22, i32 %23, <2 x i32> %26) #1
  store <4 x float> %call14, <4 x float>* %tempA2, align 16
  %27 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %28 = load i32 addrspace(2)* @imageSampler, align 4
  %29 = load <8 x i32>* %ybs, align 32
  %30 = extractelement <8 x i32> %29, i32 3
  %vecinit16 = insertelement <2 x i32> <i32 0, i32 undef>, i32 %30, i32 1
  store <2 x i32> %vecinit16, <2 x i32>* %.compoundliteral15
  %31 = load <2 x i32>* %.compoundliteral15
  %call17 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %27, i32 %28, <2 x i32> %31) #1
  store <4 x float> %call17, <4 x float>* %tempA3, align 16
  %32 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %33 = load i32 addrspace(2)* @imageSampler, align 4
  %34 = load <8 x i32>* %ybs, align 32
  %35 = extractelement <8 x i32> %34, i32 4
  %vecinit19 = insertelement <2 x i32> <i32 0, i32 undef>, i32 %35, i32 1
  store <2 x i32> %vecinit19, <2 x i32>* %.compoundliteral18
  %36 = load <2 x i32>* %.compoundliteral18
  %call20 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %32, i32 %33, <2 x i32> %36) #1
  store <4 x float> %call20, <4 x float>* %tempA4, align 16
  %37 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %38 = load i32 addrspace(2)* @imageSampler, align 4
  %39 = load <8 x i32>* %ybs, align 32
  %40 = extractelement <8 x i32> %39, i32 5
  %vecinit22 = insertelement <2 x i32> <i32 0, i32 undef>, i32 %40, i32 1
  store <2 x i32> %vecinit22, <2 x i32>* %.compoundliteral21
  %41 = load <2 x i32>* %.compoundliteral21
  %call23 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %37, i32 %38, <2 x i32> %41) #1
  store <4 x float> %call23, <4 x float>* %tempA5, align 16
  %42 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %43 = load i32 addrspace(2)* @imageSampler, align 4
  %44 = load <8 x i32>* %ybs, align 32
  %45 = extractelement <8 x i32> %44, i32 6
  %vecinit25 = insertelement <2 x i32> <i32 0, i32 undef>, i32 %45, i32 1
  store <2 x i32> %vecinit25, <2 x i32>* %.compoundliteral24
  %46 = load <2 x i32>* %.compoundliteral24
  %call26 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %42, i32 %43, <2 x i32> %46) #1
  store <4 x float> %call26, <4 x float>* %tempA6, align 16
  %47 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %48 = load i32 addrspace(2)* @imageSampler, align 4
  %49 = load <8 x i32>* %ybs, align 32
  %50 = extractelement <8 x i32> %49, i32 7
  %vecinit28 = insertelement <2 x i32> <i32 0, i32 undef>, i32 %50, i32 1
  store <2 x i32> %vecinit28, <2 x i32>* %.compoundliteral27
  %51 = load <2 x i32>* %.compoundliteral27
  %call29 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %47, i32 %48, <2 x i32> %51) #1
  store <4 x float> %call29, <4 x float>* %tempA7, align 16
  %52 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %53 = load i32 addrspace(2)* @imageSampler, align 4
  %54 = load <2 x i32>* %pos, align 8
  %55 = extractelement <2 x i32> %54, i32 0
  %vecinit31 = insertelement <2 x i32> undef, i32 %55, i32 0
  %vecinit32 = insertelement <2 x i32> %vecinit31, i32 0, i32 1
  store <2 x i32> %vecinit32, <2 x i32>* %.compoundliteral30
  %56 = load <2 x i32>* %.compoundliteral30
  %call33 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %52, i32 %53, <2 x i32> %56) #1
  store <4 x float> %call33, <4 x float>* %tempB0, align 16
  %57 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %58 = load i32 addrspace(2)* @imageSampler, align 4
  %59 = load <2 x i32>* %pos, align 8
  %60 = extractelement <2 x i32> %59, i32 0
  %vecinit35 = insertelement <2 x i32> undef, i32 %60, i32 0
  %vecinit36 = insertelement <2 x i32> %vecinit35, i32 1, i32 1
  store <2 x i32> %vecinit36, <2 x i32>* %.compoundliteral34
  %61 = load <2 x i32>* %.compoundliteral34
  %call37 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %57, i32 %58, <2 x i32> %61) #1
  store <4 x float> %call37, <4 x float>* %tempB1, align 16
  %62 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %63 = load i32 addrspace(2)* @imageSampler, align 4
  %64 = load <2 x i32>* %pos, align 8
  %65 = extractelement <2 x i32> %64, i32 0
  %vecinit39 = insertelement <2 x i32> undef, i32 %65, i32 0
  %vecinit40 = insertelement <2 x i32> %vecinit39, i32 2, i32 1
  store <2 x i32> %vecinit40, <2 x i32>* %.compoundliteral38
  %66 = load <2 x i32>* %.compoundliteral38
  %call41 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %62, i32 %63, <2 x i32> %66) #1
  store <4 x float> %call41, <4 x float>* %tempB2, align 16
  %67 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %68 = load i32 addrspace(2)* @imageSampler, align 4
  %69 = load <2 x i32>* %pos, align 8
  %70 = extractelement <2 x i32> %69, i32 0
  %vecinit43 = insertelement <2 x i32> undef, i32 %70, i32 0
  %vecinit44 = insertelement <2 x i32> %vecinit43, i32 3, i32 1
  store <2 x i32> %vecinit44, <2 x i32>* %.compoundliteral42
  %71 = load <2 x i32>* %.compoundliteral42
  %call45 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %67, i32 %68, <2 x i32> %71) #1
  store <4 x float> %call45, <4 x float>* %tempB3, align 16
  %72 = load <4 x float>* %tempA0, align 16
  %73 = load <4 x float>* %tempB0, align 16
  %74 = load <4 x float>* %tempB1, align 16
  %75 = load <4 x float>* %tempB2, align 16
  %76 = load <4 x float>* %tempB3, align 16
  %call46 = call cc75 <4 x float> @mat_mult_pre(<4 x float> %72, <4 x float> %73, <4 x float> %74, <4 x float> %75, <4 x float> %76)
  store <4 x float> %call46, <4 x float>* %sum0, align 16
  %77 = load <4 x float>* %tempA1, align 16
  %78 = load <4 x float>* %tempB0, align 16
  %79 = load <4 x float>* %tempB1, align 16
  %80 = load <4 x float>* %tempB2, align 16
  %81 = load <4 x float>* %tempB3, align 16
  %call47 = call cc75 <4 x float> @mat_mult_pre(<4 x float> %77, <4 x float> %78, <4 x float> %79, <4 x float> %80, <4 x float> %81)
  store <4 x float> %call47, <4 x float>* %sum1, align 16
  %82 = load <4 x float>* %tempA2, align 16
  %83 = load <4 x float>* %tempB0, align 16
  %84 = load <4 x float>* %tempB1, align 16
  %85 = load <4 x float>* %tempB2, align 16
  %86 = load <4 x float>* %tempB3, align 16
  %call48 = call cc75 <4 x float> @mat_mult_pre(<4 x float> %82, <4 x float> %83, <4 x float> %84, <4 x float> %85, <4 x float> %86)
  store <4 x float> %call48, <4 x float>* %sum2, align 16
  %87 = load <4 x float>* %tempA3, align 16
  %88 = load <4 x float>* %tempB0, align 16
  %89 = load <4 x float>* %tempB1, align 16
  %90 = load <4 x float>* %tempB2, align 16
  %91 = load <4 x float>* %tempB3, align 16
  %call49 = call cc75 <4 x float> @mat_mult_pre(<4 x float> %87, <4 x float> %88, <4 x float> %89, <4 x float> %90, <4 x float> %91)
  store <4 x float> %call49, <4 x float>* %sum3, align 16
  %92 = load <4 x float>* %tempA4, align 16
  %93 = load <4 x float>* %tempB0, align 16
  %94 = load <4 x float>* %tempB1, align 16
  %95 = load <4 x float>* %tempB2, align 16
  %96 = load <4 x float>* %tempB3, align 16
  %call50 = call cc75 <4 x float> @mat_mult_pre(<4 x float> %92, <4 x float> %93, <4 x float> %94, <4 x float> %95, <4 x float> %96)
  store <4 x float> %call50, <4 x float>* %sum4, align 16
  %97 = load <4 x float>* %tempA5, align 16
  %98 = load <4 x float>* %tempB0, align 16
  %99 = load <4 x float>* %tempB1, align 16
  %100 = load <4 x float>* %tempB2, align 16
  %101 = load <4 x float>* %tempB3, align 16
  %call51 = call cc75 <4 x float> @mat_mult_pre(<4 x float> %97, <4 x float> %98, <4 x float> %99, <4 x float> %100, <4 x float> %101)
  store <4 x float> %call51, <4 x float>* %sum5, align 16
  %102 = load <4 x float>* %tempA6, align 16
  %103 = load <4 x float>* %tempB0, align 16
  %104 = load <4 x float>* %tempB1, align 16
  %105 = load <4 x float>* %tempB2, align 16
  %106 = load <4 x float>* %tempB3, align 16
  %call52 = call cc75 <4 x float> @mat_mult_pre(<4 x float> %102, <4 x float> %103, <4 x float> %104, <4 x float> %105, <4 x float> %106)
  store <4 x float> %call52, <4 x float>* %sum6, align 16
  %107 = load <4 x float>* %tempA7, align 16
  %108 = load <4 x float>* %tempB0, align 16
  %109 = load <4 x float>* %tempB1, align 16
  %110 = load <4 x float>* %tempB2, align 16
  %111 = load <4 x float>* %tempB3, align 16
  %call53 = call cc75 <4 x float> @mat_mult_pre(<4 x float> %107, <4 x float> %108, <4 x float> %109, <4 x float> %110, <4 x float> %111)
  store <4 x float> %call53, <4 x float>* %sum7, align 16
  store i32 4, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %112 = load i32* %i, align 4
  %113 = load i32* %widthA.addr, align 4
  %cmp = icmp ult i32 %112, %113
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %114 = load i32* %i, align 4
  %shr56 = ashr i32 %114, 2
  store i32 %shr56, i32* %ib455, align 4
  %115 = load i32* %i, align 4
  %116 = insertelement <4 x i32> undef, i32 %115, i32 0
  %splat58 = shufflevector <4 x i32> %116, <4 x i32> %116, <4 x i32> zeroinitializer
  %117 = load <4 x i32>* %offsetx, align 16
  %add59 = add <4 x i32> %splat58, %117
  store <4 x i32> %add59, <4 x i32>* %ioff57, align 16
  %118 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %119 = load i32 addrspace(2)* @imageSampler, align 4
  %120 = load i32* %ib455, align 4
  %vecinit61 = insertelement <2 x i32> undef, i32 %120, i32 0
  %121 = load <8 x i32>* %ybs, align 32
  %122 = extractelement <8 x i32> %121, i32 0
  %vecinit62 = insertelement <2 x i32> %vecinit61, i32 %122, i32 1
  store <2 x i32> %vecinit62, <2 x i32>* %.compoundliteral60
  %123 = load <2 x i32>* %.compoundliteral60
  %call63 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %118, i32 %119, <2 x i32> %123) #1
  store <4 x float> %call63, <4 x float>* %tempA0, align 16
  %124 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %125 = load i32 addrspace(2)* @imageSampler, align 4
  %126 = load i32* %ib455, align 4
  %vecinit65 = insertelement <2 x i32> undef, i32 %126, i32 0
  %127 = load <8 x i32>* %ybs, align 32
  %128 = extractelement <8 x i32> %127, i32 1
  %vecinit66 = insertelement <2 x i32> %vecinit65, i32 %128, i32 1
  store <2 x i32> %vecinit66, <2 x i32>* %.compoundliteral64
  %129 = load <2 x i32>* %.compoundliteral64
  %call67 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %124, i32 %125, <2 x i32> %129) #1
  store <4 x float> %call67, <4 x float>* %tempA1, align 16
  %130 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %131 = load i32 addrspace(2)* @imageSampler, align 4
  %132 = load i32* %ib455, align 4
  %vecinit69 = insertelement <2 x i32> undef, i32 %132, i32 0
  %133 = load <8 x i32>* %ybs, align 32
  %134 = extractelement <8 x i32> %133, i32 2
  %vecinit70 = insertelement <2 x i32> %vecinit69, i32 %134, i32 1
  store <2 x i32> %vecinit70, <2 x i32>* %.compoundliteral68
  %135 = load <2 x i32>* %.compoundliteral68
  %call71 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %130, i32 %131, <2 x i32> %135) #1
  store <4 x float> %call71, <4 x float>* %tempA2, align 16
  %136 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %137 = load i32 addrspace(2)* @imageSampler, align 4
  %138 = load i32* %ib455, align 4
  %vecinit73 = insertelement <2 x i32> undef, i32 %138, i32 0
  %139 = load <8 x i32>* %ybs, align 32
  %140 = extractelement <8 x i32> %139, i32 3
  %vecinit74 = insertelement <2 x i32> %vecinit73, i32 %140, i32 1
  store <2 x i32> %vecinit74, <2 x i32>* %.compoundliteral72
  %141 = load <2 x i32>* %.compoundliteral72
  %call75 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %136, i32 %137, <2 x i32> %141) #1
  store <4 x float> %call75, <4 x float>* %tempA3, align 16
  %142 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %143 = load i32 addrspace(2)* @imageSampler, align 4
  %144 = load <2 x i32>* %pos, align 8
  %145 = extractelement <2 x i32> %144, i32 0
  %vecinit77 = insertelement <2 x i32> undef, i32 %145, i32 0
  %146 = load <4 x i32>* %ioff57, align 16
  %147 = extractelement <4 x i32> %146, i32 0
  %vecinit78 = insertelement <2 x i32> %vecinit77, i32 %147, i32 1
  store <2 x i32> %vecinit78, <2 x i32>* %.compoundliteral76
  %148 = load <2 x i32>* %.compoundliteral76
  %call79 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %142, i32 %143, <2 x i32> %148) #1
  store <4 x float> %call79, <4 x float>* %tempB0, align 16
  %149 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %150 = load i32 addrspace(2)* @imageSampler, align 4
  %151 = load <2 x i32>* %pos, align 8
  %152 = extractelement <2 x i32> %151, i32 0
  %vecinit81 = insertelement <2 x i32> undef, i32 %152, i32 0
  %153 = load <4 x i32>* %ioff57, align 16
  %154 = extractelement <4 x i32> %153, i32 1
  %vecinit82 = insertelement <2 x i32> %vecinit81, i32 %154, i32 1
  store <2 x i32> %vecinit82, <2 x i32>* %.compoundliteral80
  %155 = load <2 x i32>* %.compoundliteral80
  %call83 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %149, i32 %150, <2 x i32> %155) #1
  store <4 x float> %call83, <4 x float>* %tempB1, align 16
  %156 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %157 = load i32 addrspace(2)* @imageSampler, align 4
  %158 = load <2 x i32>* %pos, align 8
  %159 = extractelement <2 x i32> %158, i32 0
  %vecinit85 = insertelement <2 x i32> undef, i32 %159, i32 0
  %160 = load <4 x i32>* %ioff57, align 16
  %161 = extractelement <4 x i32> %160, i32 2
  %vecinit86 = insertelement <2 x i32> %vecinit85, i32 %161, i32 1
  store <2 x i32> %vecinit86, <2 x i32>* %.compoundliteral84
  %162 = load <2 x i32>* %.compoundliteral84
  %call87 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %156, i32 %157, <2 x i32> %162) #1
  store <4 x float> %call87, <4 x float>* %tempB2, align 16
  %163 = load %opencl.image2d_t addrspace(1)** %matrixB.addr, align 8
  %164 = load i32 addrspace(2)* @imageSampler, align 4
  %165 = load <2 x i32>* %pos, align 8
  %166 = extractelement <2 x i32> %165, i32 0
  %vecinit89 = insertelement <2 x i32> undef, i32 %166, i32 0
  %167 = load <4 x i32>* %ioff57, align 16
  %168 = extractelement <4 x i32> %167, i32 3
  %vecinit90 = insertelement <2 x i32> %vecinit89, i32 %168, i32 1
  store <2 x i32> %vecinit90, <2 x i32>* %.compoundliteral88
  %169 = load <2 x i32>* %.compoundliteral88
  %call91 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %163, i32 %164, <2 x i32> %169) #1
  store <4 x float> %call91, <4 x float>* %tempB3, align 16
  %170 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %171 = load i32 addrspace(2)* @imageSampler, align 4
  %172 = load i32* %ib455, align 4
  %vecinit93 = insertelement <2 x i32> undef, i32 %172, i32 0
  %173 = load <8 x i32>* %ybs, align 32
  %174 = extractelement <8 x i32> %173, i32 4
  %vecinit94 = insertelement <2 x i32> %vecinit93, i32 %174, i32 1
  store <2 x i32> %vecinit94, <2 x i32>* %.compoundliteral92
  %175 = load <2 x i32>* %.compoundliteral92
  %call95 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %170, i32 %171, <2 x i32> %175) #1
  store <4 x float> %call95, <4 x float>* %tempA4, align 16
  %176 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %177 = load i32 addrspace(2)* @imageSampler, align 4
  %178 = load i32* %ib455, align 4
  %vecinit97 = insertelement <2 x i32> undef, i32 %178, i32 0
  %179 = load <8 x i32>* %ybs, align 32
  %180 = extractelement <8 x i32> %179, i32 5
  %vecinit98 = insertelement <2 x i32> %vecinit97, i32 %180, i32 1
  store <2 x i32> %vecinit98, <2 x i32>* %.compoundliteral96
  %181 = load <2 x i32>* %.compoundliteral96
  %call99 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %176, i32 %177, <2 x i32> %181) #1
  store <4 x float> %call99, <4 x float>* %tempA5, align 16
  %182 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %183 = load i32 addrspace(2)* @imageSampler, align 4
  %184 = load i32* %ib455, align 4
  %vecinit101 = insertelement <2 x i32> undef, i32 %184, i32 0
  %185 = load <8 x i32>* %ybs, align 32
  %186 = extractelement <8 x i32> %185, i32 6
  %vecinit102 = insertelement <2 x i32> %vecinit101, i32 %186, i32 1
  store <2 x i32> %vecinit102, <2 x i32>* %.compoundliteral100
  %187 = load <2 x i32>* %.compoundliteral100
  %call103 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %182, i32 %183, <2 x i32> %187) #1
  store <4 x float> %call103, <4 x float>* %tempA6, align 16
  %188 = load %opencl.image2d_t addrspace(1)** %matrixA.addr, align 8
  %189 = load i32 addrspace(2)* @imageSampler, align 4
  %190 = load i32* %ib455, align 4
  %vecinit105 = insertelement <2 x i32> undef, i32 %190, i32 0
  %191 = load <8 x i32>* %ybs, align 32
  %192 = extractelement <8 x i32> %191, i32 7
  %vecinit106 = insertelement <2 x i32> %vecinit105, i32 %192, i32 1
  store <2 x i32> %vecinit106, <2 x i32>* %.compoundliteral104
  %193 = load <2 x i32>* %.compoundliteral104
  %call107 = call cc75 <4 x float> @_Z11read_imagef11ocl_image2d11ocl_samplerDv2_i(%opencl.image2d_t addrspace(1)* %188, i32 %189, <2 x i32> %193) #1
  store <4 x float> %call107, <4 x float>* %tempA7, align 16
  %194 = load <4 x float>* %tempA0, align 16
  %195 = load <4 x float>* %tempB0, align 16
  %196 = load <4 x float>* %tempB1, align 16
  %197 = load <4 x float>* %tempB2, align 16
  %198 = load <4 x float>* %tempB3, align 16
  %199 = load <4 x float>* %sum0, align 16
  %call108 = call cc75 <4 x float> @mat_mult_mini(<4 x float> %194, <4 x float> %195, <4 x float> %196, <4 x float> %197, <4 x float> %198, <4 x float> %199)
  store <4 x float> %call108, <4 x float>* %sum0, align 16
  %200 = load <4 x float>* %tempA1, align 16
  %201 = load <4 x float>* %tempB0, align 16
  %202 = load <4 x float>* %tempB1, align 16
  %203 = load <4 x float>* %tempB2, align 16
  %204 = load <4 x float>* %tempB3, align 16
  %205 = load <4 x float>* %sum1, align 16
  %call109 = call cc75 <4 x float> @mat_mult_mini(<4 x float> %200, <4 x float> %201, <4 x float> %202, <4 x float> %203, <4 x float> %204, <4 x float> %205)
  store <4 x float> %call109, <4 x float>* %sum1, align 16
  %206 = load <4 x float>* %tempA2, align 16
  %207 = load <4 x float>* %tempB0, align 16
  %208 = load <4 x float>* %tempB1, align 16
  %209 = load <4 x float>* %tempB2, align 16
  %210 = load <4 x float>* %tempB3, align 16
  %211 = load <4 x float>* %sum2, align 16
  %call110 = call cc75 <4 x float> @mat_mult_mini(<4 x float> %206, <4 x float> %207, <4 x float> %208, <4 x float> %209, <4 x float> %210, <4 x float> %211)
  store <4 x float> %call110, <4 x float>* %sum2, align 16
  %212 = load <4 x float>* %tempA3, align 16
  %213 = load <4 x float>* %tempB0, align 16
  %214 = load <4 x float>* %tempB1, align 16
  %215 = load <4 x float>* %tempB2, align 16
  %216 = load <4 x float>* %tempB3, align 16
  %217 = load <4 x float>* %sum3, align 16
  %call111 = call cc75 <4 x float> @mat_mult_mini(<4 x float> %212, <4 x float> %213, <4 x float> %214, <4 x float> %215, <4 x float> %216, <4 x float> %217)
  store <4 x float> %call111, <4 x float>* %sum3, align 16
  %218 = load <4 x float>* %tempA4, align 16
  %219 = load <4 x float>* %tempB0, align 16
  %220 = load <4 x float>* %tempB1, align 16
  %221 = load <4 x float>* %tempB2, align 16
  %222 = load <4 x float>* %tempB3, align 16
  %223 = load <4 x float>* %sum4, align 16
  %call112 = call cc75 <4 x float> @mat_mult_mini(<4 x float> %218, <4 x float> %219, <4 x float> %220, <4 x float> %221, <4 x float> %222, <4 x float> %223)
  store <4 x float> %call112, <4 x float>* %sum4, align 16
  %224 = load <4 x float>* %tempA5, align 16
  %225 = load <4 x float>* %tempB0, align 16
  %226 = load <4 x float>* %tempB1, align 16
  %227 = load <4 x float>* %tempB2, align 16
  %228 = load <4 x float>* %tempB3, align 16
  %229 = load <4 x float>* %sum5, align 16
  %call113 = call cc75 <4 x float> @mat_mult_mini(<4 x float> %224, <4 x float> %225, <4 x float> %226, <4 x float> %227, <4 x float> %228, <4 x float> %229)
  store <4 x float> %call113, <4 x float>* %sum5, align 16
  %230 = load <4 x float>* %tempA6, align 16
  %231 = load <4 x float>* %tempB0, align 16
  %232 = load <4 x float>* %tempB1, align 16
  %233 = load <4 x float>* %tempB2, align 16
  %234 = load <4 x float>* %tempB3, align 16
  %235 = load <4 x float>* %sum6, align 16
  %call114 = call cc75 <4 x float> @mat_mult_mini(<4 x float> %230, <4 x float> %231, <4 x float> %232, <4 x float> %233, <4 x float> %234, <4 x float> %235)
  store <4 x float> %call114, <4 x float>* %sum6, align 16
  %236 = load <4 x float>* %tempA7, align 16
  %237 = load <4 x float>* %tempB0, align 16
  %238 = load <4 x float>* %tempB1, align 16
  %239 = load <4 x float>* %tempB2, align 16
  %240 = load <4 x float>* %tempB3, align 16
  %241 = load <4 x float>* %sum7, align 16
  %call115 = call cc75 <4 x float> @mat_mult_mini(<4 x float> %236, <4 x float> %237, <4 x float> %238, <4 x float> %239, <4 x float> %240, <4 x float> %241)
  store <4 x float> %call115, <4 x float>* %sum7, align 16
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %242 = load i32* %i, align 4
  %add116 = add nsw i32 %242, 4
  store i32 %add116, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %243 = load <2 x i32>* %pos, align 8
  %244 = extractelement <2 x i32> %243, i32 1
  %mul = mul nsw i32 %244, 8
  store i32 %mul, i32* %ypos, align 4
  %245 = load i32* %ypos, align 4
  %246 = insertelement <8 x i32> undef, i32 %245, i32 0
  %splat117 = shufflevector <8 x i32> %246, <8 x i32> %246, <8 x i32> zeroinitializer
  %247 = load <8 x i32>* %offsety, align 32
  %add118 = add <8 x i32> %splat117, %247
  store <8 x i32> %add118, <8 x i32>* %ypos8, align 32
  %248 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %249 = load <2 x i32>* %pos, align 8
  %250 = extractelement <2 x i32> %249, i32 0
  %vecinit120 = insertelement <2 x i32> undef, i32 %250, i32 0
  %251 = load <8 x i32>* %ypos8, align 32
  %252 = extractelement <8 x i32> %251, i32 0
  %vecinit121 = insertelement <2 x i32> %vecinit120, i32 %252, i32 1
  store <2 x i32> %vecinit121, <2 x i32>* %.compoundliteral119
  %253 = load <2 x i32>* %.compoundliteral119
  %254 = load <4 x float>* %sum0, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %248, <2 x i32> %253, <4 x float> %254)
  %255 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %256 = load <2 x i32>* %pos, align 8
  %257 = extractelement <2 x i32> %256, i32 0
  %vecinit123 = insertelement <2 x i32> undef, i32 %257, i32 0
  %258 = load <8 x i32>* %ypos8, align 32
  %259 = extractelement <8 x i32> %258, i32 1
  %vecinit124 = insertelement <2 x i32> %vecinit123, i32 %259, i32 1
  store <2 x i32> %vecinit124, <2 x i32>* %.compoundliteral122
  %260 = load <2 x i32>* %.compoundliteral122
  %261 = load <4 x float>* %sum1, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %255, <2 x i32> %260, <4 x float> %261)
  %262 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %263 = load <2 x i32>* %pos, align 8
  %264 = extractelement <2 x i32> %263, i32 0
  %vecinit126 = insertelement <2 x i32> undef, i32 %264, i32 0
  %265 = load <8 x i32>* %ypos8, align 32
  %266 = extractelement <8 x i32> %265, i32 2
  %vecinit127 = insertelement <2 x i32> %vecinit126, i32 %266, i32 1
  store <2 x i32> %vecinit127, <2 x i32>* %.compoundliteral125
  %267 = load <2 x i32>* %.compoundliteral125
  %268 = load <4 x float>* %sum2, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %262, <2 x i32> %267, <4 x float> %268)
  %269 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %270 = load <2 x i32>* %pos, align 8
  %271 = extractelement <2 x i32> %270, i32 0
  %vecinit129 = insertelement <2 x i32> undef, i32 %271, i32 0
  %272 = load <8 x i32>* %ypos8, align 32
  %273 = extractelement <8 x i32> %272, i32 3
  %vecinit130 = insertelement <2 x i32> %vecinit129, i32 %273, i32 1
  store <2 x i32> %vecinit130, <2 x i32>* %.compoundliteral128
  %274 = load <2 x i32>* %.compoundliteral128
  %275 = load <4 x float>* %sum3, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %269, <2 x i32> %274, <4 x float> %275)
  %276 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %277 = load <2 x i32>* %pos, align 8
  %278 = extractelement <2 x i32> %277, i32 0
  %vecinit132 = insertelement <2 x i32> undef, i32 %278, i32 0
  %279 = load <8 x i32>* %ypos8, align 32
  %280 = extractelement <8 x i32> %279, i32 4
  %vecinit133 = insertelement <2 x i32> %vecinit132, i32 %280, i32 1
  store <2 x i32> %vecinit133, <2 x i32>* %.compoundliteral131
  %281 = load <2 x i32>* %.compoundliteral131
  %282 = load <4 x float>* %sum4, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %276, <2 x i32> %281, <4 x float> %282)
  %283 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %284 = load <2 x i32>* %pos, align 8
  %285 = extractelement <2 x i32> %284, i32 0
  %vecinit135 = insertelement <2 x i32> undef, i32 %285, i32 0
  %286 = load <8 x i32>* %ypos8, align 32
  %287 = extractelement <8 x i32> %286, i32 5
  %vecinit136 = insertelement <2 x i32> %vecinit135, i32 %287, i32 1
  store <2 x i32> %vecinit136, <2 x i32>* %.compoundliteral134
  %288 = load <2 x i32>* %.compoundliteral134
  %289 = load <4 x float>* %sum5, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %283, <2 x i32> %288, <4 x float> %289)
  %290 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %291 = load <2 x i32>* %pos, align 8
  %292 = extractelement <2 x i32> %291, i32 0
  %vecinit138 = insertelement <2 x i32> undef, i32 %292, i32 0
  %293 = load <8 x i32>* %ypos8, align 32
  %294 = extractelement <8 x i32> %293, i32 6
  %vecinit139 = insertelement <2 x i32> %vecinit138, i32 %294, i32 1
  store <2 x i32> %vecinit139, <2 x i32>* %.compoundliteral137
  %295 = load <2 x i32>* %.compoundliteral137
  %296 = load <4 x float>* %sum6, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %290, <2 x i32> %295, <4 x float> %296)
  %297 = load %opencl.image2d_t addrspace(1)** %matrixC.addr, align 8
  %298 = load <2 x i32>* %pos, align 8
  %299 = extractelement <2 x i32> %298, i32 0
  %vecinit141 = insertelement <2 x i32> undef, i32 %299, i32 0
  %300 = load <8 x i32>* %ypos8, align 32
  %301 = extractelement <8 x i32> %300, i32 7
  %vecinit142 = insertelement <2 x i32> %vecinit141, i32 %301, i32 1
  store <2 x i32> %vecinit142, <2 x i32>* %.compoundliteral140
  %302 = load <2 x i32>* %.compoundliteral140
  %303 = load <4 x float>* %sum7, align 16
  call cc75 void @_Z12write_imagef11ocl_image2dDv2_iDv4_f(%opencl.image2d_t addrspace(1)* %297, <2 x i32> %302, <4 x float> %303)
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6, !7}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!8}
!opencl.spir.version = !{!8}

!0 = metadata !{void (%opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*, i32, i32)* @__OpenCL_mmmKernel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"read_only", metadata !"read_only", metadata !"write_only", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"image2d_t", metadata !"image2d_t", metadata !"image2d_t", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"image2d_t", metadata !"image2d_t", metadata !"image2d_t", metadata !"uint", metadata !"uint"}
!6 = metadata !{void (%opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*, i32, i32)* @__OpenCL_mmmKernel2_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!7 = metadata !{void (%opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*, %opencl.image2d_t addrspace(1)*, i32, i32)* @__OpenCL_mmmKernel3_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!8 = metadata !{i32 1, i32 2}

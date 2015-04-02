; ModuleID = '../kernel-src/RecursiveGaussian_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @transpose_kernel(<4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(3)* %block, i32 %width, i32 %height, i32 %blockSize) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca <4 x i8> addrspace(1)*, align 4
  %3 = alloca <4 x i8> addrspace(3)*, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %globalIdy = alloca i32, align 4
  %localIdx = alloca i32, align 4
  %localIdy = alloca i32, align 4
  %sourceIndex = alloca i32, align 4
  %targetIndex = alloca i32, align 4
  store <4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)** %1, align 4
  store <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)** %2, align 4
  store <4 x i8> addrspace(3)* %block, <4 x i8> addrspace(3)** %3, align 4
  store i32 %width, i32* %4, align 4
  store i32 %height, i32* %5, align 4
  store i32 %blockSize, i32* %6, align 4
  %7 = call i32 @get_global_id(i32 0)
  store i32 %7, i32* %globalIdx, align 4
  %8 = call i32 @get_global_id(i32 1)
  store i32 %8, i32* %globalIdy, align 4
  %9 = call i32 @get_local_id(i32 0)
  store i32 %9, i32* %localIdx, align 4
  %10 = call i32 @get_local_id(i32 1)
  store i32 %10, i32* %localIdy, align 4
  %11 = load i32* %globalIdy, align 4
  %12 = load i32* %4, align 4
  %13 = mul i32 %11, %12
  %14 = load i32* %globalIdx, align 4
  %15 = add i32 %13, %14
  %16 = load <4 x i8> addrspace(1)** %2, align 4
  %17 = getelementptr inbounds <4 x i8> addrspace(1)* %16, i32 %15
  %18 = load <4 x i8> addrspace(1)* %17, align 4
  %19 = load i32* %localIdy, align 4
  %20 = load i32* %6, align 4
  %21 = mul i32 %19, %20
  %22 = load i32* %localIdx, align 4
  %23 = add i32 %21, %22
  %24 = load <4 x i8> addrspace(3)** %3, align 4
  %25 = getelementptr inbounds <4 x i8> addrspace(3)* %24, i32 %23
  store <4 x i8> %18, <4 x i8> addrspace(3)* %25, align 4
  call void @barrier(i32 1)
  %26 = load i32* %localIdy, align 4
  %27 = load i32* %6, align 4
  %28 = mul i32 %26, %27
  %29 = load i32* %localIdx, align 4
  %30 = add i32 %28, %29
  store i32 %30, i32* %sourceIndex, align 4
  %31 = load i32* %globalIdy, align 4
  %32 = load i32* %globalIdx, align 4
  %33 = load i32* %5, align 4
  %34 = mul i32 %32, %33
  %35 = add i32 %31, %34
  store i32 %35, i32* %targetIndex, align 4
  %36 = load i32* %sourceIndex, align 4
  %37 = load <4 x i8> addrspace(3)** %3, align 4
  %38 = getelementptr inbounds <4 x i8> addrspace(3)* %37, i32 %36
  %39 = load <4 x i8> addrspace(3)* %38, align 4
  %40 = load i32* %targetIndex, align 4
  %41 = load <4 x i8> addrspace(1)** %1, align 4
  %42 = getelementptr inbounds <4 x i8> addrspace(1)* %41, i32 %40
  store <4 x i8> %39, <4 x i8> addrspace(1)* %42, align 4
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @RecursiveGaussian_kernel(<4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)* %output, i32 %width, i32 %height, float %a0, float %a1, float %a2, float %a3, float %b1, float %b2, float %coefp, float %coefn) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca <4 x i8> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float, align 4
  %x = alloca i32, align 4
  %xp = alloca <4 x float>, align 16
  %yp = alloca <4 x float>, align 16
  %yb = alloca <4 x float>, align 16
  %y = alloca i32, align 4
  %pos = alloca i32, align 4
  %xc = alloca <4 x float>, align 16
  %13 = alloca <4 x float>, align 16
  %yc = alloca <4 x float>, align 16
  %14 = alloca <4 x i8>, align 4
  %xn = alloca <4 x float>, align 16
  %xa = alloca <4 x float>, align 16
  %yn = alloca <4 x float>, align 16
  %ya = alloca <4 x float>, align 16
  %y1 = alloca i32, align 4
  %pos2 = alloca i32, align 4
  %xc3 = alloca <4 x float>, align 16
  %15 = alloca <4 x float>, align 16
  %yc4 = alloca <4 x float>, align 16
  %temp = alloca <4 x float>, align 16
  %16 = alloca <4 x float>, align 16
  %17 = alloca <4 x i8>, align 4
  store <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)** %1, align 4
  store <4 x i8> addrspace(1)* %output, <4 x i8> addrspace(1)** %2, align 4
  store i32 %width, i32* %3, align 4
  store i32 %height, i32* %4, align 4
  store float %a0, float* %5, align 4
  store float %a1, float* %6, align 4
  store float %a2, float* %7, align 4
  store float %a3, float* %8, align 4
  store float %b1, float* %9, align 4
  store float %b2, float* %10, align 4
  store float %coefp, float* %11, align 4
  store float %coefn, float* %12, align 4
  %18 = call i32 @get_global_id(i32 0)
  store i32 %18, i32* %x, align 4
  %19 = load i32* %x, align 4
  %20 = load i32* %3, align 4
  %21 = icmp uge i32 %19, %20
  br i1 %21, label %22, label %23

; <label>:22                                      ; preds = %0
  br label %232

; <label>:23                                      ; preds = %0
  store <4 x float> zeroinitializer, <4 x float>* %xp, align 16
  store <4 x float> zeroinitializer, <4 x float>* %yp, align 16
  store <4 x float> zeroinitializer, <4 x float>* %yb, align 16
  store i32 0, i32* %y, align 4
  br label %24

; <label>:24                                      ; preds = %108, %23
  %25 = load i32* %y, align 4
  %26 = load i32* %4, align 4
  %27 = icmp slt i32 %25, %26
  br i1 %27, label %28, label %111

; <label>:28                                      ; preds = %24
  %29 = load i32* %x, align 4
  %30 = load i32* %y, align 4
  %31 = load i32* %3, align 4
  %32 = mul nsw i32 %30, %31
  %33 = add i32 %29, %32
  store i32 %33, i32* %pos, align 4
  %34 = load i32* %pos, align 4
  %35 = load <4 x i8> addrspace(1)** %1, align 4
  %36 = getelementptr inbounds <4 x i8> addrspace(1)* %35, i32 %34
  %37 = load <4 x i8> addrspace(1)* %36, align 4
  %38 = extractelement <4 x i8> %37, i32 0
  %39 = uitofp i8 %38 to float
  %40 = insertelement <4 x float> undef, float %39, i32 0
  %41 = load i32* %pos, align 4
  %42 = load <4 x i8> addrspace(1)** %1, align 4
  %43 = getelementptr inbounds <4 x i8> addrspace(1)* %42, i32 %41
  %44 = load <4 x i8> addrspace(1)* %43, align 4
  %45 = extractelement <4 x i8> %44, i32 1
  %46 = uitofp i8 %45 to float
  %47 = insertelement <4 x float> %40, float %46, i32 1
  %48 = load i32* %pos, align 4
  %49 = load <4 x i8> addrspace(1)** %1, align 4
  %50 = getelementptr inbounds <4 x i8> addrspace(1)* %49, i32 %48
  %51 = load <4 x i8> addrspace(1)* %50, align 4
  %52 = extractelement <4 x i8> %51, i32 2
  %53 = uitofp i8 %52 to float
  %54 = insertelement <4 x float> %47, float %53, i32 2
  %55 = load i32* %pos, align 4
  %56 = load <4 x i8> addrspace(1)** %1, align 4
  %57 = getelementptr inbounds <4 x i8> addrspace(1)* %56, i32 %55
  %58 = load <4 x i8> addrspace(1)* %57, align 4
  %59 = extractelement <4 x i8> %58, i32 3
  %60 = uitofp i8 %59 to float
  %61 = insertelement <4 x float> %54, float %60, i32 3
  store <4 x float> %61, <4 x float>* %13
  %62 = load <4 x float>* %13
  store <4 x float> %62, <4 x float>* %xc, align 16
  %63 = load float* %5, align 4
  %64 = insertelement <4 x float> undef, float %63, i32 0
  %65 = shufflevector <4 x float> %64, <4 x float> undef, <4 x i32> zeroinitializer
  %66 = load <4 x float>* %xc, align 16
  %67 = load float* %6, align 4
  %68 = insertelement <4 x float> undef, float %67, i32 0
  %69 = shufflevector <4 x float> %68, <4 x float> undef, <4 x i32> zeroinitializer
  %70 = load <4 x float>* %xp, align 16
  %71 = fmul <4 x float> %69, %70
  %72 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %65, <4 x float> %66, <4 x float> %71)
  %73 = load float* %9, align 4
  %74 = insertelement <4 x float> undef, float %73, i32 0
  %75 = shufflevector <4 x float> %74, <4 x float> undef, <4 x i32> zeroinitializer
  %76 = load <4 x float>* %yp, align 16
  %77 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %75
  %78 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %77, <4 x float> %76, <4 x float> %72)
  %79 = load float* %10, align 4
  %80 = insertelement <4 x float> undef, float %79, i32 0
  %81 = shufflevector <4 x float> %80, <4 x float> undef, <4 x i32> zeroinitializer
  %82 = load <4 x float>* %yb, align 16
  %83 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %81
  %84 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %83, <4 x float> %82, <4 x float> %78)
  store <4 x float> %84, <4 x float>* %yc, align 16
  %85 = load <4 x float>* %yc, align 16
  %86 = extractelement <4 x float> %85, i32 0
  %87 = fptoui float %86 to i8
  %88 = insertelement <4 x i8> undef, i8 %87, i32 0
  %89 = load <4 x float>* %yc, align 16
  %90 = extractelement <4 x float> %89, i32 1
  %91 = fptoui float %90 to i8
  %92 = insertelement <4 x i8> %88, i8 %91, i32 1
  %93 = load <4 x float>* %yc, align 16
  %94 = extractelement <4 x float> %93, i32 2
  %95 = fptoui float %94 to i8
  %96 = insertelement <4 x i8> %92, i8 %95, i32 2
  %97 = load <4 x float>* %yc, align 16
  %98 = extractelement <4 x float> %97, i32 3
  %99 = fptoui float %98 to i8
  %100 = insertelement <4 x i8> %96, i8 %99, i32 3
  store <4 x i8> %100, <4 x i8>* %14
  %101 = load <4 x i8>* %14
  %102 = load i32* %pos, align 4
  %103 = load <4 x i8> addrspace(1)** %2, align 4
  %104 = getelementptr inbounds <4 x i8> addrspace(1)* %103, i32 %102
  store <4 x i8> %101, <4 x i8> addrspace(1)* %104, align 4
  %105 = load <4 x float>* %xc, align 16
  store <4 x float> %105, <4 x float>* %xp, align 16
  %106 = load <4 x float>* %yp, align 16
  store <4 x float> %106, <4 x float>* %yb, align 16
  %107 = load <4 x float>* %yc, align 16
  store <4 x float> %107, <4 x float>* %yp, align 16
  br label %108

; <label>:108                                     ; preds = %28
  %109 = load i32* %y, align 4
  %110 = add nsw i32 %109, 1
  store i32 %110, i32* %y, align 4
  br label %24

; <label>:111                                     ; preds = %24
  call void @barrier(i32 2)
  store <4 x float> zeroinitializer, <4 x float>* %xn, align 16
  store <4 x float> zeroinitializer, <4 x float>* %xa, align 16
  store <4 x float> zeroinitializer, <4 x float>* %yn, align 16
  store <4 x float> zeroinitializer, <4 x float>* %ya, align 16
  %112 = load i32* %4, align 4
  %113 = sub nsw i32 %112, 1
  store i32 %113, i32* %y1, align 4
  br label %114

; <label>:114                                     ; preds = %229, %111
  %115 = load i32* %y1, align 4
  %116 = icmp sgt i32 %115, -1
  br i1 %116, label %117, label %232

; <label>:117                                     ; preds = %114
  %118 = load i32* %x, align 4
  %119 = load i32* %y1, align 4
  %120 = load i32* %3, align 4
  %121 = mul nsw i32 %119, %120
  %122 = add i32 %118, %121
  store i32 %122, i32* %pos2, align 4
  %123 = load i32* %pos2, align 4
  %124 = load <4 x i8> addrspace(1)** %1, align 4
  %125 = getelementptr inbounds <4 x i8> addrspace(1)* %124, i32 %123
  %126 = load <4 x i8> addrspace(1)* %125, align 4
  %127 = extractelement <4 x i8> %126, i32 0
  %128 = uitofp i8 %127 to float
  %129 = insertelement <4 x float> undef, float %128, i32 0
  %130 = load i32* %pos2, align 4
  %131 = load <4 x i8> addrspace(1)** %1, align 4
  %132 = getelementptr inbounds <4 x i8> addrspace(1)* %131, i32 %130
  %133 = load <4 x i8> addrspace(1)* %132, align 4
  %134 = extractelement <4 x i8> %133, i32 1
  %135 = uitofp i8 %134 to float
  %136 = insertelement <4 x float> %129, float %135, i32 1
  %137 = load i32* %pos2, align 4
  %138 = load <4 x i8> addrspace(1)** %1, align 4
  %139 = getelementptr inbounds <4 x i8> addrspace(1)* %138, i32 %137
  %140 = load <4 x i8> addrspace(1)* %139, align 4
  %141 = extractelement <4 x i8> %140, i32 2
  %142 = uitofp i8 %141 to float
  %143 = insertelement <4 x float> %136, float %142, i32 2
  %144 = load i32* %pos2, align 4
  %145 = load <4 x i8> addrspace(1)** %1, align 4
  %146 = getelementptr inbounds <4 x i8> addrspace(1)* %145, i32 %144
  %147 = load <4 x i8> addrspace(1)* %146, align 4
  %148 = extractelement <4 x i8> %147, i32 3
  %149 = uitofp i8 %148 to float
  %150 = insertelement <4 x float> %143, float %149, i32 3
  store <4 x float> %150, <4 x float>* %15
  %151 = load <4 x float>* %15
  store <4 x float> %151, <4 x float>* %xc3, align 16
  %152 = load float* %7, align 4
  %153 = insertelement <4 x float> undef, float %152, i32 0
  %154 = shufflevector <4 x float> %153, <4 x float> undef, <4 x i32> zeroinitializer
  %155 = load <4 x float>* %xn, align 16
  %156 = load float* %8, align 4
  %157 = insertelement <4 x float> undef, float %156, i32 0
  %158 = shufflevector <4 x float> %157, <4 x float> undef, <4 x i32> zeroinitializer
  %159 = load <4 x float>* %xa, align 16
  %160 = fmul <4 x float> %158, %159
  %161 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %154, <4 x float> %155, <4 x float> %160)
  %162 = load float* %9, align 4
  %163 = insertelement <4 x float> undef, float %162, i32 0
  %164 = shufflevector <4 x float> %163, <4 x float> undef, <4 x i32> zeroinitializer
  %165 = load <4 x float>* %yn, align 16
  %166 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %164
  %167 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %166, <4 x float> %165, <4 x float> %161)
  %168 = load float* %10, align 4
  %169 = insertelement <4 x float> undef, float %168, i32 0
  %170 = shufflevector <4 x float> %169, <4 x float> undef, <4 x i32> zeroinitializer
  %171 = load <4 x float>* %ya, align 16
  %172 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %170
  %173 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %172, <4 x float> %171, <4 x float> %167)
  store <4 x float> %173, <4 x float>* %yc4, align 16
  %174 = load <4 x float>* %xn, align 16
  store <4 x float> %174, <4 x float>* %xa, align 16
  %175 = load <4 x float>* %xc3, align 16
  store <4 x float> %175, <4 x float>* %xn, align 16
  %176 = load <4 x float>* %yn, align 16
  store <4 x float> %176, <4 x float>* %ya, align 16
  %177 = load <4 x float>* %yc4, align 16
  store <4 x float> %177, <4 x float>* %yn, align 16
  %178 = load i32* %pos2, align 4
  %179 = load <4 x i8> addrspace(1)** %2, align 4
  %180 = getelementptr inbounds <4 x i8> addrspace(1)* %179, i32 %178
  %181 = load <4 x i8> addrspace(1)* %180, align 4
  %182 = extractelement <4 x i8> %181, i32 0
  %183 = uitofp i8 %182 to float
  %184 = insertelement <4 x float> undef, float %183, i32 0
  %185 = load i32* %pos2, align 4
  %186 = load <4 x i8> addrspace(1)** %2, align 4
  %187 = getelementptr inbounds <4 x i8> addrspace(1)* %186, i32 %185
  %188 = load <4 x i8> addrspace(1)* %187, align 4
  %189 = extractelement <4 x i8> %188, i32 1
  %190 = uitofp i8 %189 to float
  %191 = insertelement <4 x float> %184, float %190, i32 1
  %192 = load i32* %pos2, align 4
  %193 = load <4 x i8> addrspace(1)** %2, align 4
  %194 = getelementptr inbounds <4 x i8> addrspace(1)* %193, i32 %192
  %195 = load <4 x i8> addrspace(1)* %194, align 4
  %196 = extractelement <4 x i8> %195, i32 2
  %197 = uitofp i8 %196 to float
  %198 = insertelement <4 x float> %191, float %197, i32 2
  %199 = load i32* %pos2, align 4
  %200 = load <4 x i8> addrspace(1)** %2, align 4
  %201 = getelementptr inbounds <4 x i8> addrspace(1)* %200, i32 %199
  %202 = load <4 x i8> addrspace(1)* %201, align 4
  %203 = extractelement <4 x i8> %202, i32 3
  %204 = uitofp i8 %203 to float
  %205 = insertelement <4 x float> %198, float %204, i32 3
  store <4 x float> %205, <4 x float>* %16
  %206 = load <4 x float>* %16
  %207 = load <4 x float>* %yc4, align 16
  %208 = fadd <4 x float> %206, %207
  store <4 x float> %208, <4 x float>* %temp, align 16
  %209 = load <4 x float>* %temp, align 16
  %210 = extractelement <4 x float> %209, i32 0
  %211 = fptoui float %210 to i8
  %212 = insertelement <4 x i8> undef, i8 %211, i32 0
  %213 = load <4 x float>* %temp, align 16
  %214 = extractelement <4 x float> %213, i32 1
  %215 = fptoui float %214 to i8
  %216 = insertelement <4 x i8> %212, i8 %215, i32 1
  %217 = load <4 x float>* %temp, align 16
  %218 = extractelement <4 x float> %217, i32 2
  %219 = fptoui float %218 to i8
  %220 = insertelement <4 x i8> %216, i8 %219, i32 2
  %221 = load <4 x float>* %temp, align 16
  %222 = extractelement <4 x float> %221, i32 3
  %223 = fptoui float %222 to i8
  %224 = insertelement <4 x i8> %220, i8 %223, i32 3
  store <4 x i8> %224, <4 x i8>* %17
  %225 = load <4 x i8>* %17
  %226 = load i32* %pos2, align 4
  %227 = load <4 x i8> addrspace(1)** %2, align 4
  %228 = getelementptr inbounds <4 x i8> addrspace(1)* %227, i32 %226
  store <4 x i8> %225, <4 x i8> addrspace(1)* %228, align 4
  br label %229

; <label>:229                                     ; preds = %117
  %230 = load i32* %y1, align 4
  %231 = add nsw i32 %230, -1
  store i32 %231, i32* %y1, align 4
  br label %114

; <label>:232                                     ; preds = %22, %114
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, <4 x i8> addrspace(3)*, i32, i32, i32)* @transpose_kernel}
!1 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, i32, float, float, float, float, float, float, float, float)* @RecursiveGaussian_kernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

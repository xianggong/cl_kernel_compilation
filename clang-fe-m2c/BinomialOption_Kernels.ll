; ModuleID = '../kernel-src/BinomialOption_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @binomial_options(i32 %numSteps, <4 x float> addrspace(1)* %randArray, <4 x float> addrspace(1)* %output, <4 x float> addrspace(3)* %callA, <4 x float> addrspace(3)* %callB) #0 {
  %1 = alloca i32, align 4
  %2 = alloca <4 x float> addrspace(1)*, align 4
  %3 = alloca <4 x float> addrspace(1)*, align 4
  %4 = alloca <4 x float> addrspace(3)*, align 4
  %5 = alloca <4 x float> addrspace(3)*, align 4
  %tid = alloca i32, align 4
  %bid = alloca i32, align 4
  %inRand = alloca <4 x float>, align 16
  %s = alloca <4 x float>, align 16
  %x = alloca <4 x float>, align 16
  %optionYears = alloca <4 x float>, align 16
  %dt = alloca <4 x float>, align 16
  %vsdt = alloca <4 x float>, align 16
  %rdt = alloca <4 x float>, align 16
  %r = alloca <4 x float>, align 16
  %rInv = alloca <4 x float>, align 16
  %u = alloca <4 x float>, align 16
  %d = alloca <4 x float>, align 16
  %pu = alloca <4 x float>, align 16
  %pd = alloca <4 x float>, align 16
  %puByr = alloca <4 x float>, align 16
  %pdByr = alloca <4 x float>, align 16
  %profit = alloca <4 x float>, align 16
  %j = alloca i32, align 4
  store i32 %numSteps, i32* %1, align 4
  store <4 x float> addrspace(1)* %randArray, <4 x float> addrspace(1)** %2, align 4
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %3, align 4
  store <4 x float> addrspace(3)* %callA, <4 x float> addrspace(3)** %4, align 4
  store <4 x float> addrspace(3)* %callB, <4 x float> addrspace(3)** %5, align 4
  %6 = call i32 @__get_local_id_u32(i32 0)
  store i32 %6, i32* %tid, align 4
  %7 = call i32 @__get_group_id_u32(i32 0)
  store i32 %7, i32* %bid, align 4
  %8 = load i32* %bid, align 4
  %9 = load <4 x float> addrspace(1)** %2, align 4
  %10 = getelementptr inbounds <4 x float> addrspace(1)* %9, i32 %8
  %11 = load <4 x float> addrspace(1)* %10, align 16
  store <4 x float> %11, <4 x float>* %inRand, align 16
  %12 = load <4 x float>* %inRand, align 16
  %13 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %12
  %14 = load <4 x float>* %inRand, align 16
  %15 = fmul <4 x float> %14, <float 3.000000e+01, float 3.000000e+01, float 3.000000e+01, float 3.000000e+01>
  %16 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %13, <4 x float> <float 5.000000e+00, float 5.000000e+00, float 5.000000e+00, float 5.000000e+00>, <4 x float> %15)
  store <4 x float> %16, <4 x float>* %s, align 16
  %17 = load <4 x float>* %inRand, align 16
  %18 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %17
  %19 = load <4 x float>* %inRand, align 16
  %20 = fmul <4 x float> %19, <float 1.000000e+02, float 1.000000e+02, float 1.000000e+02, float 1.000000e+02>
  %21 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %18, <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, <4 x float> %20)
  store <4 x float> %21, <4 x float>* %x, align 16
  %22 = load <4 x float>* %inRand, align 16
  %23 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %22
  %24 = load <4 x float>* %inRand, align 16
  %25 = fmul <4 x float> %24, <float 1.000000e+01, float 1.000000e+01, float 1.000000e+01, float 1.000000e+01>
  %26 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %23, <4 x float> <float 2.500000e-01, float 2.500000e-01, float 2.500000e-01, float 2.500000e-01>, <4 x float> %25)
  store <4 x float> %26, <4 x float>* %optionYears, align 16
  %27 = load <4 x float>* %optionYears, align 16
  %28 = load i32* %1, align 4
  %29 = sitofp i32 %28 to float
  %30 = fdiv float 1.000000e+00, %29, !fpmath !2
  %31 = insertelement <4 x float> undef, float %30, i32 0
  %32 = shufflevector <4 x float> %31, <4 x float> undef, <4 x i32> zeroinitializer
  %33 = fmul <4 x float> %27, %32
  store <4 x float> %33, <4 x float>* %dt, align 16
  %34 = load <4 x float>* %dt, align 16
  %35 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %34)
  %36 = fmul <4 x float> <float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000>, %35
  store <4 x float> %36, <4 x float>* %vsdt, align 16
  %37 = load <4 x float>* %dt, align 16
  %38 = fmul <4 x float> <float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000, float 0x3F947AE140000000>, %37
  store <4 x float> %38, <4 x float>* %rdt, align 16
  %39 = load <4 x float>* %rdt, align 16
  %40 = call <4 x float> @_Z3expDv4_f(<4 x float> %39)
  store <4 x float> %40, <4 x float>* %r, align 16
  %41 = load <4 x float>* %r, align 16
  %42 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %41, !fpmath !2
  store <4 x float> %42, <4 x float>* %rInv, align 16
  %43 = load <4 x float>* %vsdt, align 16
  %44 = call <4 x float> @_Z3expDv4_f(<4 x float> %43)
  store <4 x float> %44, <4 x float>* %u, align 16
  %45 = load <4 x float>* %u, align 16
  %46 = fdiv <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %45, !fpmath !2
  store <4 x float> %46, <4 x float>* %d, align 16
  %47 = load <4 x float>* %r, align 16
  %48 = load <4 x float>* %d, align 16
  %49 = fsub <4 x float> %47, %48
  %50 = load <4 x float>* %u, align 16
  %51 = load <4 x float>* %d, align 16
  %52 = fsub <4 x float> %50, %51
  %53 = fdiv <4 x float> %49, %52, !fpmath !2
  store <4 x float> %53, <4 x float>* %pu, align 16
  %54 = load <4 x float>* %pu, align 16
  %55 = fsub <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %54
  store <4 x float> %55, <4 x float>* %pd, align 16
  %56 = load <4 x float>* %pu, align 16
  %57 = load <4 x float>* %rInv, align 16
  %58 = fmul <4 x float> %56, %57
  store <4 x float> %58, <4 x float>* %puByr, align 16
  %59 = load <4 x float>* %pd, align 16
  %60 = load <4 x float>* %rInv, align 16
  %61 = fmul <4 x float> %59, %60
  store <4 x float> %61, <4 x float>* %pdByr, align 16
  %62 = load <4 x float>* %s, align 16
  %63 = load <4 x float>* %vsdt, align 16
  %64 = load i32* %tid, align 4
  %65 = uitofp i32 %64 to float
  %66 = load i32* %1, align 4
  %67 = sitofp i32 %66 to float
  %68 = fsub float -0.000000e+00, %67
  %69 = call float @llvm.fmuladd.f32(float 2.000000e+00, float %65, float %68)
  %70 = insertelement <4 x float> undef, float %69, i32 0
  %71 = shufflevector <4 x float> %70, <4 x float> undef, <4 x i32> zeroinitializer
  %72 = fmul <4 x float> %63, %71
  %73 = call <4 x float> @_Z3expDv4_f(<4 x float> %72)
  %74 = load <4 x float>* %x, align 16
  %75 = fsub <4 x float> <float -0.000000e+00, float -0.000000e+00, float -0.000000e+00, float -0.000000e+00>, %74
  %76 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %62, <4 x float> %73, <4 x float> %75)
  store <4 x float> %76, <4 x float>* %profit, align 16
  %77 = load <4 x float>* %profit, align 16
  %78 = extractelement <4 x float> %77, i32 0
  %79 = fcmp ogt float %78, 0.000000e+00
  br i1 %79, label %80, label %83

; <label>:80                                      ; preds = %0
  %81 = load <4 x float>* %profit, align 16
  %82 = extractelement <4 x float> %81, i32 0
  br label %84

; <label>:83                                      ; preds = %0
  br label %84

; <label>:84                                      ; preds = %83, %80
  %85 = phi float [ %82, %80 ], [ 0.000000e+00, %83 ]
  %86 = load i32* %tid, align 4
  %87 = load <4 x float> addrspace(3)** %4, align 4
  %88 = getelementptr inbounds <4 x float> addrspace(3)* %87, i32 %86
  %89 = load <4 x float> addrspace(3)* %88, align 16
  %90 = insertelement <4 x float> %89, float %85, i32 0
  store <4 x float> %90, <4 x float> addrspace(3)* %88, align 16
  %91 = load <4 x float>* %profit, align 16
  %92 = extractelement <4 x float> %91, i32 1
  %93 = fcmp ogt float %92, 0.000000e+00
  br i1 %93, label %94, label %97

; <label>:94                                      ; preds = %84
  %95 = load <4 x float>* %profit, align 16
  %96 = extractelement <4 x float> %95, i32 1
  br label %98

; <label>:97                                      ; preds = %84
  br label %98

; <label>:98                                      ; preds = %97, %94
  %99 = phi float [ %96, %94 ], [ 0.000000e+00, %97 ]
  %100 = load i32* %tid, align 4
  %101 = load <4 x float> addrspace(3)** %4, align 4
  %102 = getelementptr inbounds <4 x float> addrspace(3)* %101, i32 %100
  %103 = load <4 x float> addrspace(3)* %102, align 16
  %104 = insertelement <4 x float> %103, float %99, i32 1
  store <4 x float> %104, <4 x float> addrspace(3)* %102, align 16
  %105 = load <4 x float>* %profit, align 16
  %106 = extractelement <4 x float> %105, i32 2
  %107 = fcmp ogt float %106, 0.000000e+00
  br i1 %107, label %108, label %111

; <label>:108                                     ; preds = %98
  %109 = load <4 x float>* %profit, align 16
  %110 = extractelement <4 x float> %109, i32 2
  br label %112

; <label>:111                                     ; preds = %98
  br label %112

; <label>:112                                     ; preds = %111, %108
  %113 = phi float [ %110, %108 ], [ 0.000000e+00, %111 ]
  %114 = load i32* %tid, align 4
  %115 = load <4 x float> addrspace(3)** %4, align 4
  %116 = getelementptr inbounds <4 x float> addrspace(3)* %115, i32 %114
  %117 = load <4 x float> addrspace(3)* %116, align 16
  %118 = insertelement <4 x float> %117, float %113, i32 2
  store <4 x float> %118, <4 x float> addrspace(3)* %116, align 16
  %119 = load <4 x float>* %profit, align 16
  %120 = extractelement <4 x float> %119, i32 3
  %121 = fcmp ogt float %120, 0.000000e+00
  br i1 %121, label %122, label %125

; <label>:122                                     ; preds = %112
  %123 = load <4 x float>* %profit, align 16
  %124 = extractelement <4 x float> %123, i32 3
  br label %126

; <label>:125                                     ; preds = %112
  br label %126

; <label>:126                                     ; preds = %125, %122
  %127 = phi float [ %124, %122 ], [ 0.000000e+00, %125 ]
  %128 = load i32* %tid, align 4
  %129 = load <4 x float> addrspace(3)** %4, align 4
  %130 = getelementptr inbounds <4 x float> addrspace(3)* %129, i32 %128
  %131 = load <4 x float> addrspace(3)* %130, align 16
  %132 = insertelement <4 x float> %131, float %127, i32 3
  store <4 x float> %132, <4 x float> addrspace(3)* %130, align 16
  call void @barrier(i32 1)
  %133 = load i32* %1, align 4
  store i32 %133, i32* %j, align 4
  br label %134

; <label>:134                                     ; preds = %181, %126
  %135 = load i32* %j, align 4
  %136 = icmp sgt i32 %135, 0
  br i1 %136, label %137, label %184

; <label>:137                                     ; preds = %134
  %138 = load i32* %tid, align 4
  %139 = load i32* %j, align 4
  %140 = icmp ult i32 %138, %139
  br i1 %140, label %141, label %158

; <label>:141                                     ; preds = %137
  %142 = load <4 x float>* %puByr, align 16
  %143 = load i32* %tid, align 4
  %144 = load <4 x float> addrspace(3)** %4, align 4
  %145 = getelementptr inbounds <4 x float> addrspace(3)* %144, i32 %143
  %146 = load <4 x float> addrspace(3)* %145, align 16
  %147 = load <4 x float>* %pdByr, align 16
  %148 = load i32* %tid, align 4
  %149 = add i32 %148, 1
  %150 = load <4 x float> addrspace(3)** %4, align 4
  %151 = getelementptr inbounds <4 x float> addrspace(3)* %150, i32 %149
  %152 = load <4 x float> addrspace(3)* %151, align 16
  %153 = fmul <4 x float> %147, %152
  %154 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %142, <4 x float> %146, <4 x float> %153)
  %155 = load i32* %tid, align 4
  %156 = load <4 x float> addrspace(3)** %5, align 4
  %157 = getelementptr inbounds <4 x float> addrspace(3)* %156, i32 %155
  store <4 x float> %154, <4 x float> addrspace(3)* %157, align 16
  br label %158

; <label>:158                                     ; preds = %141, %137
  call void @barrier(i32 1)
  %159 = load i32* %tid, align 4
  %160 = load i32* %j, align 4
  %161 = sub nsw i32 %160, 1
  %162 = icmp ult i32 %159, %161
  br i1 %162, label %163, label %180

; <label>:163                                     ; preds = %158
  %164 = load <4 x float>* %puByr, align 16
  %165 = load i32* %tid, align 4
  %166 = load <4 x float> addrspace(3)** %5, align 4
  %167 = getelementptr inbounds <4 x float> addrspace(3)* %166, i32 %165
  %168 = load <4 x float> addrspace(3)* %167, align 16
  %169 = load <4 x float>* %pdByr, align 16
  %170 = load i32* %tid, align 4
  %171 = add i32 %170, 1
  %172 = load <4 x float> addrspace(3)** %5, align 4
  %173 = getelementptr inbounds <4 x float> addrspace(3)* %172, i32 %171
  %174 = load <4 x float> addrspace(3)* %173, align 16
  %175 = fmul <4 x float> %169, %174
  %176 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %164, <4 x float> %168, <4 x float> %175)
  %177 = load i32* %tid, align 4
  %178 = load <4 x float> addrspace(3)** %4, align 4
  %179 = getelementptr inbounds <4 x float> addrspace(3)* %178, i32 %177
  store <4 x float> %176, <4 x float> addrspace(3)* %179, align 16
  br label %180

; <label>:180                                     ; preds = %163, %158
  call void @barrier(i32 1)
  br label %181

; <label>:181                                     ; preds = %180
  %182 = load i32* %j, align 4
  %183 = sub nsw i32 %182, 2
  store i32 %183, i32* %j, align 4
  br label %134

; <label>:184                                     ; preds = %134
  %185 = load i32* %tid, align 4
  %186 = icmp eq i32 %185, 0
  br i1 %186, label %187, label %194

; <label>:187                                     ; preds = %184
  %188 = load <4 x float> addrspace(3)** %4, align 4
  %189 = getelementptr inbounds <4 x float> addrspace(3)* %188, i32 0
  %190 = load <4 x float> addrspace(3)* %189, align 16
  %191 = load i32* %bid, align 4
  %192 = load <4 x float> addrspace(1)** %3, align 4
  %193 = getelementptr inbounds <4 x float> addrspace(1)* %192, i32 %191
  store <4 x float> %190, <4 x float> addrspace(1)* %193, align 16
  br label %194

; <label>:194                                     ; preds = %187, %184
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #2

; Function Attrs: nounwind readonly
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #3

declare <4 x float> @_Z3expDv4_f(<4 x float>) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*, <4 x float> addrspace(3)*)* @binomial_options}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

; ModuleID = '../kernel-src/MatrixTranspose_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @matrixTranspose(<4 x float> addrspace(1)* %output, <4 x float> addrspace(1)* %input, <4 x float> addrspace(3)* %block) #0 {
  %1 = alloca <4 x float> addrspace(1)*, align 4
  %2 = alloca <4 x float> addrspace(1)*, align 4
  %3 = alloca <4 x float> addrspace(3)*, align 4
  %wiWidth = alloca i32, align 4
  %gix_t = alloca i32, align 4
  %giy_t = alloca i32, align 4
  %num_of_blocks_x = alloca i32, align 4
  %giy = alloca i32, align 4
  %gix = alloca i32, align 4
  %lix = alloca i32, align 4
  %liy = alloca i32, align 4
  %blockSize = alloca i32, align 4
  %ix = alloca i32, align 4
  %iy = alloca i32, align 4
  %index_in = alloca i32, align 4
  %ind = alloca i32, align 4
  %index_out = alloca i32, align 4
  %v0 = alloca <4 x float>, align 16
  %v1 = alloca <4 x float>, align 16
  %v2 = alloca <4 x float>, align 16
  %v3 = alloca <4 x float>, align 16
  %4 = alloca <4 x float>, align 16
  %5 = alloca <4 x float>, align 16
  %6 = alloca <4 x float>, align 16
  %7 = alloca <4 x float>, align 16
  store <4 x float> addrspace(1)* %output, <4 x float> addrspace(1)** %1, align 4
  store <4 x float> addrspace(1)* %input, <4 x float> addrspace(1)** %2, align 4
  store <4 x float> addrspace(3)* %block, <4 x float> addrspace(3)** %3, align 4
  %8 = call i32 @llvm.r600.read.global.size.x()
  store i32 %8, i32* %wiWidth, align 4
  %9 = call i32 @get_group_id(i32 0)
  store i32 %9, i32* %gix_t, align 4
  %10 = call i32 @get_group_id(i32 1)
  store i32 %10, i32* %giy_t, align 4
  %11 = call i32 @llvm.r600.read.ngroups.x()
  store i32 %11, i32* %num_of_blocks_x, align 4
  %12 = load i32* %gix_t, align 4
  store i32 %12, i32* %giy, align 4
  %13 = load i32* %gix_t, align 4
  %14 = load i32* %giy_t, align 4
  %15 = add i32 %13, %14
  %16 = load i32* %num_of_blocks_x, align 4
  %17 = urem i32 %15, %16
  store i32 %17, i32* %gix, align 4
  %18 = call i32 @llvm.r600.read.tidig.x()
  store i32 %18, i32* %lix, align 4
  %19 = call i32 @llvm.r600.read.tidig.y()
  store i32 %19, i32* %liy, align 4
  %20 = call i32 @llvm.r600.read.local.size.x()
  store i32 %20, i32* %blockSize, align 4
  %21 = load i32* %gix, align 4
  %22 = load i32* %blockSize, align 4
  %23 = mul i32 %21, %22
  %24 = load i32* %lix, align 4
  %25 = add i32 %23, %24
  store i32 %25, i32* %ix, align 4
  %26 = load i32* %giy, align 4
  %27 = load i32* %blockSize, align 4
  %28 = mul i32 %26, %27
  %29 = load i32* %liy, align 4
  %30 = add i32 %28, %29
  store i32 %30, i32* %iy, align 4
  %31 = load i32* %ix, align 4
  %32 = load i32* %iy, align 4
  %33 = load i32* %wiWidth, align 4
  %34 = mul i32 %32, %33
  %35 = mul i32 %34, 4
  %36 = add i32 %31, %35
  store i32 %36, i32* %index_in, align 4
  %37 = load i32* %liy, align 4
  %38 = load i32* %blockSize, align 4
  %39 = mul i32 %37, %38
  %40 = mul i32 %39, 4
  %41 = load i32* %lix, align 4
  %42 = add i32 %40, %41
  store i32 %42, i32* %ind, align 4
  %43 = load i32* %index_in, align 4
  %44 = load <4 x float> addrspace(1)** %2, align 4
  %45 = getelementptr inbounds <4 x float> addrspace(1)* %44, i32 %43
  %46 = load <4 x float> addrspace(1)* %45, align 16
  %47 = load i32* %ind, align 4
  %48 = load <4 x float> addrspace(3)** %3, align 4
  %49 = getelementptr inbounds <4 x float> addrspace(3)* %48, i32 %47
  store <4 x float> %46, <4 x float> addrspace(3)* %49, align 16
  %50 = load i32* %index_in, align 4
  %51 = load i32* %wiWidth, align 4
  %52 = add i32 %50, %51
  %53 = load <4 x float> addrspace(1)** %2, align 4
  %54 = getelementptr inbounds <4 x float> addrspace(1)* %53, i32 %52
  %55 = load <4 x float> addrspace(1)* %54, align 16
  %56 = load i32* %ind, align 4
  %57 = load i32* %blockSize, align 4
  %58 = add i32 %56, %57
  %59 = load <4 x float> addrspace(3)** %3, align 4
  %60 = getelementptr inbounds <4 x float> addrspace(3)* %59, i32 %58
  store <4 x float> %55, <4 x float> addrspace(3)* %60, align 16
  %61 = load i32* %index_in, align 4
  %62 = load i32* %wiWidth, align 4
  %63 = mul i32 %62, 2
  %64 = add i32 %61, %63
  %65 = load <4 x float> addrspace(1)** %2, align 4
  %66 = getelementptr inbounds <4 x float> addrspace(1)* %65, i32 %64
  %67 = load <4 x float> addrspace(1)* %66, align 16
  %68 = load i32* %ind, align 4
  %69 = load i32* %blockSize, align 4
  %70 = mul i32 %69, 2
  %71 = add i32 %68, %70
  %72 = load <4 x float> addrspace(3)** %3, align 4
  %73 = getelementptr inbounds <4 x float> addrspace(3)* %72, i32 %71
  store <4 x float> %67, <4 x float> addrspace(3)* %73, align 16
  %74 = load i32* %index_in, align 4
  %75 = load i32* %wiWidth, align 4
  %76 = mul i32 %75, 3
  %77 = add i32 %74, %76
  %78 = load <4 x float> addrspace(1)** %2, align 4
  %79 = getelementptr inbounds <4 x float> addrspace(1)* %78, i32 %77
  %80 = load <4 x float> addrspace(1)* %79, align 16
  %81 = load i32* %ind, align 4
  %82 = load i32* %blockSize, align 4
  %83 = mul i32 %82, 3
  %84 = add i32 %81, %83
  %85 = load <4 x float> addrspace(3)** %3, align 4
  %86 = getelementptr inbounds <4 x float> addrspace(3)* %85, i32 %84
  store <4 x float> %80, <4 x float> addrspace(3)* %86, align 16
  call void @barrier(i32 1)
  %87 = load i32* %giy, align 4
  %88 = load i32* %blockSize, align 4
  %89 = mul i32 %87, %88
  %90 = load i32* %lix, align 4
  %91 = add i32 %89, %90
  store i32 %91, i32* %ix, align 4
  %92 = load i32* %gix, align 4
  %93 = load i32* %blockSize, align 4
  %94 = mul i32 %92, %93
  %95 = load i32* %liy, align 4
  %96 = add i32 %94, %95
  store i32 %96, i32* %iy, align 4
  %97 = load i32* %ix, align 4
  %98 = load i32* %iy, align 4
  %99 = load i32* %wiWidth, align 4
  %100 = mul i32 %98, %99
  %101 = mul i32 %100, 4
  %102 = add i32 %97, %101
  store i32 %102, i32* %index_out, align 4
  %103 = load i32* %lix, align 4
  %104 = load i32* %blockSize, align 4
  %105 = mul i32 %103, %104
  %106 = mul i32 %105, 4
  %107 = load i32* %liy, align 4
  %108 = add i32 %106, %107
  store i32 %108, i32* %ind, align 4
  %109 = load i32* %ind, align 4
  %110 = load <4 x float> addrspace(3)** %3, align 4
  %111 = getelementptr inbounds <4 x float> addrspace(3)* %110, i32 %109
  %112 = load <4 x float> addrspace(3)* %111, align 16
  store <4 x float> %112, <4 x float>* %v0, align 16
  %113 = load i32* %ind, align 4
  %114 = load i32* %blockSize, align 4
  %115 = add i32 %113, %114
  %116 = load <4 x float> addrspace(3)** %3, align 4
  %117 = getelementptr inbounds <4 x float> addrspace(3)* %116, i32 %115
  %118 = load <4 x float> addrspace(3)* %117, align 16
  store <4 x float> %118, <4 x float>* %v1, align 16
  %119 = load i32* %ind, align 4
  %120 = load i32* %blockSize, align 4
  %121 = mul i32 %120, 2
  %122 = add i32 %119, %121
  %123 = load <4 x float> addrspace(3)** %3, align 4
  %124 = getelementptr inbounds <4 x float> addrspace(3)* %123, i32 %122
  %125 = load <4 x float> addrspace(3)* %124, align 16
  store <4 x float> %125, <4 x float>* %v2, align 16
  %126 = load i32* %ind, align 4
  %127 = load i32* %blockSize, align 4
  %128 = mul i32 %127, 3
  %129 = add i32 %126, %128
  %130 = load <4 x float> addrspace(3)** %3, align 4
  %131 = getelementptr inbounds <4 x float> addrspace(3)* %130, i32 %129
  %132 = load <4 x float> addrspace(3)* %131, align 16
  store <4 x float> %132, <4 x float>* %v3, align 16
  %133 = load <4 x float>* %v0, align 16
  %134 = extractelement <4 x float> %133, i32 0
  %135 = insertelement <4 x float> undef, float %134, i32 0
  %136 = load <4 x float>* %v1, align 16
  %137 = extractelement <4 x float> %136, i32 0
  %138 = insertelement <4 x float> %135, float %137, i32 1
  %139 = load <4 x float>* %v2, align 16
  %140 = extractelement <4 x float> %139, i32 0
  %141 = insertelement <4 x float> %138, float %140, i32 2
  %142 = load <4 x float>* %v3, align 16
  %143 = extractelement <4 x float> %142, i32 0
  %144 = insertelement <4 x float> %141, float %143, i32 3
  store <4 x float> %144, <4 x float>* %4
  %145 = load <4 x float>* %4
  %146 = load i32* %index_out, align 4
  %147 = load <4 x float> addrspace(1)** %1, align 4
  %148 = getelementptr inbounds <4 x float> addrspace(1)* %147, i32 %146
  store <4 x float> %145, <4 x float> addrspace(1)* %148, align 16
  %149 = load <4 x float>* %v0, align 16
  %150 = extractelement <4 x float> %149, i32 1
  %151 = insertelement <4 x float> undef, float %150, i32 0
  %152 = load <4 x float>* %v1, align 16
  %153 = extractelement <4 x float> %152, i32 1
  %154 = insertelement <4 x float> %151, float %153, i32 1
  %155 = load <4 x float>* %v2, align 16
  %156 = extractelement <4 x float> %155, i32 1
  %157 = insertelement <4 x float> %154, float %156, i32 2
  %158 = load <4 x float>* %v3, align 16
  %159 = extractelement <4 x float> %158, i32 1
  %160 = insertelement <4 x float> %157, float %159, i32 3
  store <4 x float> %160, <4 x float>* %5
  %161 = load <4 x float>* %5
  %162 = load i32* %index_out, align 4
  %163 = load i32* %wiWidth, align 4
  %164 = add i32 %162, %163
  %165 = load <4 x float> addrspace(1)** %1, align 4
  %166 = getelementptr inbounds <4 x float> addrspace(1)* %165, i32 %164
  store <4 x float> %161, <4 x float> addrspace(1)* %166, align 16
  %167 = load <4 x float>* %v0, align 16
  %168 = extractelement <4 x float> %167, i32 2
  %169 = insertelement <4 x float> undef, float %168, i32 0
  %170 = load <4 x float>* %v1, align 16
  %171 = extractelement <4 x float> %170, i32 2
  %172 = insertelement <4 x float> %169, float %171, i32 1
  %173 = load <4 x float>* %v2, align 16
  %174 = extractelement <4 x float> %173, i32 2
  %175 = insertelement <4 x float> %172, float %174, i32 2
  %176 = load <4 x float>* %v3, align 16
  %177 = extractelement <4 x float> %176, i32 2
  %178 = insertelement <4 x float> %175, float %177, i32 3
  store <4 x float> %178, <4 x float>* %6
  %179 = load <4 x float>* %6
  %180 = load i32* %index_out, align 4
  %181 = load i32* %wiWidth, align 4
  %182 = mul i32 %181, 2
  %183 = add i32 %180, %182
  %184 = load <4 x float> addrspace(1)** %1, align 4
  %185 = getelementptr inbounds <4 x float> addrspace(1)* %184, i32 %183
  store <4 x float> %179, <4 x float> addrspace(1)* %185, align 16
  %186 = load <4 x float>* %v0, align 16
  %187 = extractelement <4 x float> %186, i32 3
  %188 = insertelement <4 x float> undef, float %187, i32 0
  %189 = load <4 x float>* %v1, align 16
  %190 = extractelement <4 x float> %189, i32 3
  %191 = insertelement <4 x float> %188, float %190, i32 1
  %192 = load <4 x float>* %v2, align 16
  %193 = extractelement <4 x float> %192, i32 3
  %194 = insertelement <4 x float> %191, float %193, i32 2
  %195 = load <4 x float>* %v3, align 16
  %196 = extractelement <4 x float> %195, i32 3
  %197 = insertelement <4 x float> %194, float %196, i32 3
  store <4 x float> %197, <4 x float>* %7
  %198 = load <4 x float>* %7
  %199 = load i32* %index_out, align 4
  %200 = load i32* %wiWidth, align 4
  %201 = mul i32 %200, 3
  %202 = add i32 %199, %201
  %203 = load <4 x float> addrspace(1)** %1, align 4
  %204 = getelementptr inbounds <4 x float> addrspace(1)* %203, i32 %202
  store <4 x float> %198, <4 x float> addrspace(1)* %204, align 16
  ret void
}

declare i32 @llvm.r600.read.global.size.x() #1
declare i32 @llvm.r600.read.global.size.y() #1
declare i32 @llvm.r600.read.global.size.z() #1

declare i32 @get_group_id(i32) #1

declare i32 @llvm.r600.read.ngroups.x() #1
declare i32 @llvm.r600.read.ngroups.y() #1
declare i32 @llvm.r600.read.ngroups.z() #1


declare i32 @llvm.r600.read.tidig.x() #1
declare i32 @llvm.r600.read.tidig.y() #1
declare i32 @llvm.r600.read.tidig.z() #1

declare i32 @llvm.r600.read.local.size.x() #1
declare i32 @llvm.r600.read.local.size.y() #1
declare i32 @llvm.r600.read.local.size.z() #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*)* @matrixTranspose}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

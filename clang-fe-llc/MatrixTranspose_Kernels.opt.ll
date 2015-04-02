; ModuleID = 'MatrixTranspose_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @matrixTranspose(<4 x float> addrspace(1)* %output, <4 x float> addrspace(1)* %input, <4 x float> addrspace(3)* %block) #0 {
  %1 = call i32 @get_global_size(i32 0)
  %2 = call i32 @get_group_id(i32 0)
  %3 = call i32 @get_group_id(i32 1)
  %4 = call i32 @get_num_groups(i32 0)
  %5 = add i32 %2, %3
  %6 = urem i32 %5, %4
  %7 = call i32 @get_local_id(i32 0)
  %8 = call i32 @get_local_id(i32 1)
  %9 = call i32 @get_local_size(i32 0)
  %10 = mul i32 %6, %9
  %11 = add i32 %10, %7
  %12 = mul i32 %2, %9
  %13 = add i32 %12, %8
  %14 = mul i32 %13, %1
  %15 = mul i32 %14, 4
  %16 = add i32 %11, %15
  %17 = mul i32 %8, %9
  %18 = mul i32 %17, 4
  %19 = add i32 %18, %7
  %20 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %16
  %21 = load <4 x float> addrspace(1)* %20, align 16
  %22 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %19
  store <4 x float> %21, <4 x float> addrspace(3)* %22, align 16
  %23 = add i32 %16, %1
  %24 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %23
  %25 = load <4 x float> addrspace(1)* %24, align 16
  %26 = add i32 %19, %9
  %27 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %26
  store <4 x float> %25, <4 x float> addrspace(3)* %27, align 16
  %28 = mul i32 %1, 2
  %29 = add i32 %16, %28
  %30 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %29
  %31 = load <4 x float> addrspace(1)* %30, align 16
  %32 = mul i32 %9, 2
  %33 = add i32 %19, %32
  %34 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %33
  store <4 x float> %31, <4 x float> addrspace(3)* %34, align 16
  %35 = mul i32 %1, 3
  %36 = add i32 %16, %35
  %37 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %36
  %38 = load <4 x float> addrspace(1)* %37, align 16
  %39 = mul i32 %9, 3
  %40 = add i32 %19, %39
  %41 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %40
  store <4 x float> %38, <4 x float> addrspace(3)* %41, align 16
  call void @barrier(i32 1)
  %42 = mul i32 %2, %9
  %43 = add i32 %42, %7
  %44 = mul i32 %6, %9
  %45 = add i32 %44, %8
  %46 = mul i32 %45, %1
  %47 = mul i32 %46, 4
  %48 = add i32 %43, %47
  %49 = mul i32 %7, %9
  %50 = mul i32 %49, 4
  %51 = add i32 %50, %8
  %52 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %51
  %53 = load <4 x float> addrspace(3)* %52, align 16
  %54 = add i32 %51, %9
  %55 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %54
  %56 = load <4 x float> addrspace(3)* %55, align 16
  %57 = mul i32 %9, 2
  %58 = add i32 %51, %57
  %59 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %58
  %60 = load <4 x float> addrspace(3)* %59, align 16
  %61 = mul i32 %9, 3
  %62 = add i32 %51, %61
  %63 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %62
  %64 = load <4 x float> addrspace(3)* %63, align 16
  %65 = extractelement <4 x float> %53, i32 0
  %66 = insertelement <4 x float> undef, float %65, i32 0
  %67 = extractelement <4 x float> %56, i32 0
  %68 = insertelement <4 x float> %66, float %67, i32 1
  %69 = extractelement <4 x float> %60, i32 0
  %70 = insertelement <4 x float> %68, float %69, i32 2
  %71 = extractelement <4 x float> %64, i32 0
  %72 = insertelement <4 x float> %70, float %71, i32 3
  %73 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %48
  store <4 x float> %72, <4 x float> addrspace(1)* %73, align 16
  %74 = extractelement <4 x float> %53, i32 1
  %75 = insertelement <4 x float> undef, float %74, i32 0
  %76 = extractelement <4 x float> %56, i32 1
  %77 = insertelement <4 x float> %75, float %76, i32 1
  %78 = extractelement <4 x float> %60, i32 1
  %79 = insertelement <4 x float> %77, float %78, i32 2
  %80 = extractelement <4 x float> %64, i32 1
  %81 = insertelement <4 x float> %79, float %80, i32 3
  %82 = add i32 %48, %1
  %83 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %82
  store <4 x float> %81, <4 x float> addrspace(1)* %83, align 16
  %84 = extractelement <4 x float> %53, i32 2
  %85 = insertelement <4 x float> undef, float %84, i32 0
  %86 = extractelement <4 x float> %56, i32 2
  %87 = insertelement <4 x float> %85, float %86, i32 1
  %88 = extractelement <4 x float> %60, i32 2
  %89 = insertelement <4 x float> %87, float %88, i32 2
  %90 = extractelement <4 x float> %64, i32 2
  %91 = insertelement <4 x float> %89, float %90, i32 3
  %92 = mul i32 %1, 2
  %93 = add i32 %48, %92
  %94 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %93
  store <4 x float> %91, <4 x float> addrspace(1)* %94, align 16
  %95 = extractelement <4 x float> %53, i32 3
  %96 = insertelement <4 x float> undef, float %95, i32 0
  %97 = extractelement <4 x float> %56, i32 3
  %98 = insertelement <4 x float> %96, float %97, i32 1
  %99 = extractelement <4 x float> %60, i32 3
  %100 = insertelement <4 x float> %98, float %99, i32 2
  %101 = extractelement <4 x float> %64, i32 3
  %102 = insertelement <4 x float> %100, float %101, i32 3
  %103 = mul i32 %1, 3
  %104 = add i32 %48, %103
  %105 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %104
  store <4 x float> %102, <4 x float> addrspace(1)* %105, align 16
  ret void
}

declare i32 @get_global_size(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_num_groups(i32) #1

declare i32 @get_local_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*)* @matrixTranspose}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

; ModuleID = '../kernel-src/MatrixTranspose_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @matrixTranspose(<4 x float> addrspace(1)* nocapture %output, <4 x float> addrspace(1)* nocapture readonly %input, <4 x float> addrspace(3)* nocapture %block) #0 {
  %1 = tail call i32 @get_global_size(i32 0) #2
  %2 = tail call i32 @get_group_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 1) #2
  %4 = tail call i32 @get_num_groups(i32 0) #2
  %5 = add i32 %3, %2
  %6 = urem i32 %5, %4
  %7 = tail call i32 @get_local_id(i32 0) #2
  %8 = tail call i32 @get_local_id(i32 1) #2
  %9 = tail call i32 @get_local_size(i32 0) #2
  %10 = mul i32 %9, %6
  %11 = add i32 %10, %7
  %12 = mul i32 %9, %2
  %13 = add i32 %12, %8
  %14 = shl i32 %1, 2
  %15 = mul i32 %14, %13
  %16 = add i32 %11, %15
  %17 = shl i32 %8, 2
  %18 = mul i32 %17, %9
  %19 = add i32 %18, %7
  %20 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %16
  %21 = load <4 x float> addrspace(1)* %20, align 16, !tbaa !7
  %22 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %19
  store <4 x float> %21, <4 x float> addrspace(3)* %22, align 16, !tbaa !7
  %23 = add i32 %16, %1
  %24 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %23
  %25 = load <4 x float> addrspace(1)* %24, align 16, !tbaa !7
  %26 = add i32 %19, %9
  %27 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %26
  store <4 x float> %25, <4 x float> addrspace(3)* %27, align 16, !tbaa !7
  %28 = shl i32 %1, 1
  %29 = add i32 %16, %28
  %30 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %29
  %31 = load <4 x float> addrspace(1)* %30, align 16, !tbaa !7
  %32 = shl i32 %9, 1
  %33 = add i32 %19, %32
  %34 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %33
  store <4 x float> %31, <4 x float> addrspace(3)* %34, align 16, !tbaa !7
  %35 = mul i32 %1, 3
  %36 = add i32 %16, %35
  %37 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %36
  %38 = load <4 x float> addrspace(1)* %37, align 16, !tbaa !7
  %39 = mul i32 %9, 3
  %40 = add i32 %19, %39
  %41 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %40
  store <4 x float> %38, <4 x float> addrspace(3)* %41, align 16, !tbaa !7
  tail call void @barrier(i32 1) #2
  %42 = add i32 %12, %7
  %43 = add i32 %10, %8
  %44 = mul i32 %14, %43
  %45 = add i32 %42, %44
  %46 = shl i32 %7, 2
  %47 = mul i32 %46, %9
  %48 = add i32 %47, %8
  %49 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %48
  %50 = load <4 x float> addrspace(3)* %49, align 16, !tbaa !7
  %51 = add i32 %48, %9
  %52 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %51
  %53 = load <4 x float> addrspace(3)* %52, align 16, !tbaa !7
  %54 = add i32 %48, %32
  %55 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %54
  %56 = load <4 x float> addrspace(3)* %55, align 16, !tbaa !7
  %57 = add i32 %48, %39
  %58 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %57
  %59 = load <4 x float> addrspace(3)* %58, align 16, !tbaa !7
  %60 = shufflevector <4 x float> %50, <4 x float> %53, <4 x i32> <i32 0, i32 4, i32 undef, i32 undef>
  %61 = shufflevector <4 x float> %60, <4 x float> %56, <4 x i32> <i32 0, i32 1, i32 4, i32 undef>
  %62 = shufflevector <4 x float> %61, <4 x float> %59, <4 x i32> <i32 0, i32 1, i32 2, i32 4>
  %63 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %45
  store <4 x float> %62, <4 x float> addrspace(1)* %63, align 16, !tbaa !7
  %64 = shufflevector <4 x float> %50, <4 x float> %53, <4 x i32> <i32 1, i32 5, i32 undef, i32 undef>
  %65 = shufflevector <4 x float> %64, <4 x float> %56, <4 x i32> <i32 0, i32 1, i32 5, i32 undef>
  %66 = shufflevector <4 x float> %65, <4 x float> %59, <4 x i32> <i32 0, i32 1, i32 2, i32 5>
  %67 = add i32 %45, %1
  %68 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %67
  store <4 x float> %66, <4 x float> addrspace(1)* %68, align 16, !tbaa !7
  %69 = shufflevector <4 x float> %50, <4 x float> %53, <4 x i32> <i32 2, i32 6, i32 undef, i32 undef>
  %70 = shufflevector <4 x float> %69, <4 x float> %56, <4 x i32> <i32 0, i32 1, i32 6, i32 undef>
  %71 = shufflevector <4 x float> %70, <4 x float> %59, <4 x i32> <i32 0, i32 1, i32 2, i32 6>
  %72 = add i32 %45, %28
  %73 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %72
  store <4 x float> %71, <4 x float> addrspace(1)* %73, align 16, !tbaa !7
  %74 = shufflevector <4 x float> %50, <4 x float> %53, <4 x i32> <i32 3, i32 7, i32 undef, i32 undef>
  %75 = shufflevector <4 x float> %74, <4 x float> %56, <4 x i32> <i32 0, i32 1, i32 7, i32 undef>
  %76 = shufflevector <4 x float> %75, <4 x float> %59, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %77 = add i32 %45, %35
  %78 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %77
  store <4 x float> %76, <4 x float> addrspace(1)* %78, align 16, !tbaa !7
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
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*)* @matrixTranspose, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 3}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float4*", !"float4*", !"float4*"}
!4 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}

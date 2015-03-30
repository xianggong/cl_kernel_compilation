; ModuleID = '../kernel-src/MatrixTranspose_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

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
  %20 = sext i32 %16 to i64
  %21 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %20
  %22 = load <4 x float> addrspace(1)* %21, align 16, !tbaa !2
  %23 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %19
  store <4 x float> %22, <4 x float> addrspace(3)* %23, align 16, !tbaa !2
  %24 = add i32 %16, %1
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %25
  %27 = load <4 x float> addrspace(1)* %26, align 16, !tbaa !2
  %28 = add i32 %19, %9
  %29 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %28
  store <4 x float> %27, <4 x float> addrspace(3)* %29, align 16, !tbaa !2
  %30 = shl i32 %1, 1
  %31 = add i32 %16, %30
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %32
  %34 = load <4 x float> addrspace(1)* %33, align 16, !tbaa !2
  %35 = shl i32 %9, 1
  %36 = add i32 %19, %35
  %37 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %36
  store <4 x float> %34, <4 x float> addrspace(3)* %37, align 16, !tbaa !2
  %38 = mul i32 %1, 3
  %39 = add i32 %16, %38
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %40
  %42 = load <4 x float> addrspace(1)* %41, align 16, !tbaa !2
  %43 = mul i32 %9, 3
  %44 = add i32 %19, %43
  %45 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %44
  store <4 x float> %42, <4 x float> addrspace(3)* %45, align 16, !tbaa !2
  tail call void @barrier(i32 1) #2
  %46 = add i32 %12, %7
  %47 = add i32 %10, %8
  %48 = mul i32 %14, %47
  %49 = add i32 %46, %48
  %50 = shl i32 %7, 2
  %51 = mul i32 %50, %9
  %52 = add i32 %51, %8
  %53 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %52
  %54 = load <4 x float> addrspace(3)* %53, align 16, !tbaa !2
  %55 = add i32 %52, %9
  %56 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %55
  %57 = load <4 x float> addrspace(3)* %56, align 16, !tbaa !2
  %58 = add i32 %52, %35
  %59 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %58
  %60 = load <4 x float> addrspace(3)* %59, align 16, !tbaa !2
  %61 = add i32 %52, %43
  %62 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %61
  %63 = load <4 x float> addrspace(3)* %62, align 16, !tbaa !2
  %64 = shufflevector <4 x float> %54, <4 x float> %57, <4 x i32> <i32 0, i32 4, i32 undef, i32 undef>
  %65 = shufflevector <4 x float> %64, <4 x float> %60, <4 x i32> <i32 0, i32 1, i32 4, i32 undef>
  %66 = shufflevector <4 x float> %65, <4 x float> %63, <4 x i32> <i32 0, i32 1, i32 2, i32 4>
  %67 = sext i32 %49 to i64
  %68 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %67
  store <4 x float> %66, <4 x float> addrspace(1)* %68, align 16, !tbaa !2
  %69 = shufflevector <4 x float> %54, <4 x float> %57, <4 x i32> <i32 1, i32 5, i32 undef, i32 undef>
  %70 = shufflevector <4 x float> %69, <4 x float> %60, <4 x i32> <i32 0, i32 1, i32 5, i32 undef>
  %71 = shufflevector <4 x float> %70, <4 x float> %63, <4 x i32> <i32 0, i32 1, i32 2, i32 5>
  %72 = add i32 %49, %1
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %73
  store <4 x float> %71, <4 x float> addrspace(1)* %74, align 16, !tbaa !2
  %75 = shufflevector <4 x float> %54, <4 x float> %57, <4 x i32> <i32 2, i32 6, i32 undef, i32 undef>
  %76 = shufflevector <4 x float> %75, <4 x float> %60, <4 x i32> <i32 0, i32 1, i32 6, i32 undef>
  %77 = shufflevector <4 x float> %76, <4 x float> %63, <4 x i32> <i32 0, i32 1, i32 2, i32 6>
  %78 = add i32 %49, %30
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %79
  store <4 x float> %77, <4 x float> addrspace(1)* %80, align 16, !tbaa !2
  %81 = shufflevector <4 x float> %54, <4 x float> %57, <4 x i32> <i32 3, i32 7, i32 undef, i32 undef>
  %82 = shufflevector <4 x float> %81, <4 x float> %60, <4 x i32> <i32 0, i32 1, i32 7, i32 undef>
  %83 = shufflevector <4 x float> %82, <4 x float> %63, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %84 = add i32 %49, %38
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %85
  store <4 x float> %83, <4 x float> addrspace(1)* %86, align 16, !tbaa !2
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
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, <4 x float> addrspace(3)*)* @matrixTranspose}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

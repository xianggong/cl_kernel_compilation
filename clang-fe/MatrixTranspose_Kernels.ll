; ModuleID = '../kernel-src/MatrixTranspose_Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @matrixTranspose(<4 x float>* nocapture %output, <4 x float>* nocapture readonly %input, <4 x float>* nocapture %block) #0 {
  %1 = tail call i64 @get_global_size(i32 0) #2
  %2 = trunc i64 %1 to i32
  %3 = tail call i64 @get_group_id(i32 0) #2
  %4 = trunc i64 %3 to i32
  %5 = tail call i64 @get_group_id(i32 1) #2
  %6 = trunc i64 %5 to i32
  %7 = tail call i64 @get_num_groups(i32 0) #2
  %8 = trunc i64 %7 to i32
  %9 = add i32 %6, %4
  %10 = urem i32 %9, %8
  %11 = tail call i64 @get_local_id(i32 0) #2
  %12 = trunc i64 %11 to i32
  %13 = tail call i64 @get_local_id(i32 1) #2
  %14 = trunc i64 %13 to i32
  %15 = tail call i64 @get_local_size(i32 0) #2
  %16 = trunc i64 %15 to i32
  %17 = mul i32 %16, %10
  %18 = add i32 %17, %12
  %19 = mul i32 %16, %4
  %20 = add i32 %19, %14
  %21 = shl i32 %2, 2
  %22 = mul i32 %21, %20
  %23 = add i32 %18, %22
  %24 = shl i32 %14, 2
  %25 = mul i32 %24, %16
  %26 = add i32 %25, %12
  %27 = sext i32 %23 to i64
  %28 = getelementptr inbounds <4 x float>* %input, i64 %27
  %29 = load <4 x float>* %28, align 16, !tbaa !2
  %30 = sext i32 %26 to i64
  %31 = getelementptr inbounds <4 x float>* %block, i64 %30
  store <4 x float> %29, <4 x float>* %31, align 16, !tbaa !2
  %32 = add i32 %23, %2
  %33 = zext i32 %32 to i64
  %34 = getelementptr inbounds <4 x float>* %input, i64 %33
  %35 = load <4 x float>* %34, align 16, !tbaa !2
  %36 = add i32 %26, %16
  %37 = zext i32 %36 to i64
  %38 = getelementptr inbounds <4 x float>* %block, i64 %37
  store <4 x float> %35, <4 x float>* %38, align 16, !tbaa !2
  %39 = shl i32 %2, 1
  %40 = add i32 %23, %39
  %41 = zext i32 %40 to i64
  %42 = getelementptr inbounds <4 x float>* %input, i64 %41
  %43 = load <4 x float>* %42, align 16, !tbaa !2
  %44 = shl i32 %16, 1
  %45 = add i32 %26, %44
  %46 = zext i32 %45 to i64
  %47 = getelementptr inbounds <4 x float>* %block, i64 %46
  store <4 x float> %43, <4 x float>* %47, align 16, !tbaa !2
  %48 = mul i32 %2, 3
  %49 = add i32 %23, %48
  %50 = zext i32 %49 to i64
  %51 = getelementptr inbounds <4 x float>* %input, i64 %50
  %52 = load <4 x float>* %51, align 16, !tbaa !2
  %53 = mul i32 %16, 3
  %54 = add i32 %26, %53
  %55 = zext i32 %54 to i64
  %56 = getelementptr inbounds <4 x float>* %block, i64 %55
  store <4 x float> %52, <4 x float>* %56, align 16, !tbaa !2
  tail call void @barrier(i32 1) #2
  %57 = add i32 %19, %12
  %58 = add i32 %17, %14
  %59 = mul i32 %21, %58
  %60 = add i32 %57, %59
  %61 = shl i32 %12, 2
  %62 = mul i32 %61, %16
  %63 = add i32 %62, %14
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds <4 x float>* %block, i64 %64
  %66 = load <4 x float>* %65, align 16, !tbaa !2
  %67 = add i32 %63, %16
  %68 = zext i32 %67 to i64
  %69 = getelementptr inbounds <4 x float>* %block, i64 %68
  %70 = load <4 x float>* %69, align 16, !tbaa !2
  %71 = add i32 %63, %44
  %72 = zext i32 %71 to i64
  %73 = getelementptr inbounds <4 x float>* %block, i64 %72
  %74 = load <4 x float>* %73, align 16, !tbaa !2
  %75 = add i32 %63, %53
  %76 = zext i32 %75 to i64
  %77 = getelementptr inbounds <4 x float>* %block, i64 %76
  %78 = load <4 x float>* %77, align 16, !tbaa !2
  %79 = shufflevector <4 x float> %66, <4 x float> %70, <4 x i32> <i32 0, i32 4, i32 undef, i32 undef>
  %80 = shufflevector <4 x float> %79, <4 x float> %74, <4 x i32> <i32 0, i32 1, i32 4, i32 undef>
  %81 = shufflevector <4 x float> %80, <4 x float> %78, <4 x i32> <i32 0, i32 1, i32 2, i32 4>
  %82 = sext i32 %60 to i64
  %83 = getelementptr inbounds <4 x float>* %output, i64 %82
  store <4 x float> %81, <4 x float>* %83, align 16, !tbaa !2
  %84 = shufflevector <4 x float> %66, <4 x float> %70, <4 x i32> <i32 1, i32 5, i32 undef, i32 undef>
  %85 = shufflevector <4 x float> %84, <4 x float> %74, <4 x i32> <i32 0, i32 1, i32 5, i32 undef>
  %86 = shufflevector <4 x float> %85, <4 x float> %78, <4 x i32> <i32 0, i32 1, i32 2, i32 5>
  %87 = add i32 %60, %2
  %88 = zext i32 %87 to i64
  %89 = getelementptr inbounds <4 x float>* %output, i64 %88
  store <4 x float> %86, <4 x float>* %89, align 16, !tbaa !2
  %90 = shufflevector <4 x float> %66, <4 x float> %70, <4 x i32> <i32 2, i32 6, i32 undef, i32 undef>
  %91 = shufflevector <4 x float> %90, <4 x float> %74, <4 x i32> <i32 0, i32 1, i32 6, i32 undef>
  %92 = shufflevector <4 x float> %91, <4 x float> %78, <4 x i32> <i32 0, i32 1, i32 2, i32 6>
  %93 = add i32 %60, %39
  %94 = zext i32 %93 to i64
  %95 = getelementptr inbounds <4 x float>* %output, i64 %94
  store <4 x float> %92, <4 x float>* %95, align 16, !tbaa !2
  %96 = shufflevector <4 x float> %66, <4 x float> %70, <4 x i32> <i32 3, i32 7, i32 undef, i32 undef>
  %97 = shufflevector <4 x float> %96, <4 x float> %74, <4 x i32> <i32 0, i32 1, i32 7, i32 undef>
  %98 = shufflevector <4 x float> %97, <4 x float> %78, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %99 = add i32 %60, %48
  %100 = zext i32 %99 to i64
  %101 = getelementptr inbounds <4 x float>* %output, i64 %100
  store <4 x float> %98, <4 x float>* %101, align 16, !tbaa !2
  ret void
}

declare i64 @get_global_size(i32) #1

declare i64 @get_group_id(i32) #1

declare i64 @get_num_groups(i32) #1

declare i64 @get_local_id(i32) #1

declare i64 @get_local_size(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x float>*, <4 x float>*, <4 x float>*)* @matrixTranspose}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

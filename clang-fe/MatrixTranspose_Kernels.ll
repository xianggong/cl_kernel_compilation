; ModuleID = '../kernel-src/MatrixTranspose_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @matrixTranspose(<4 x float> addrspace(1)* nocapture %output, <4 x float> addrspace(1)* nocapture readonly %input, <4 x float> addrspace(3)* nocapture %block) #0 {
entry:
  %call = tail call i32 @get_global_size(i32 0) #2
  %call1 = tail call i32 @get_group_id(i32 0) #2
  %call2 = tail call i32 @get_group_id(i32 1) #2
  %call3 = tail call i32 @get_num_groups(i32 0) #2
  %add = add i32 %call2, %call1
  %rem = urem i32 %add, %call3
  %call4 = tail call i32 @get_local_id(i32 0) #2
  %call5 = tail call i32 @get_local_id(i32 1) #2
  %call6 = tail call i32 @get_local_size(i32 0) #2
  %mul = mul i32 %call6, %rem
  %add7 = add i32 %mul, %call4
  %mul8 = mul i32 %call6, %call1
  %add9 = add i32 %mul8, %call5
  %mul10 = shl i32 %call, 2
  %mul11 = mul i32 %mul10, %add9
  %add12 = add i32 %add7, %mul11
  %mul13 = shl i32 %call5, 2
  %mul14 = mul i32 %mul13, %call6
  %add15 = add i32 %mul14, %call4
  %0 = sext i32 %add12 to i64
  %arrayidx = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %0
  %1 = load <4 x float> addrspace(1)* %arrayidx, align 16, !tbaa !2
  %arrayidx16 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %add15
  store <4 x float> %1, <4 x float> addrspace(3)* %arrayidx16, align 16, !tbaa !2
  %add17 = add i32 %add12, %call
  %2 = sext i32 %add17 to i64
  %arrayidx18 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %2
  %3 = load <4 x float> addrspace(1)* %arrayidx18, align 16, !tbaa !2
  %add19 = add i32 %add15, %call6
  %arrayidx20 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %add19
  store <4 x float> %3, <4 x float> addrspace(3)* %arrayidx20, align 16, !tbaa !2
  %mul21 = shl i32 %call, 1
  %add22 = add i32 %add12, %mul21
  %4 = sext i32 %add22 to i64
  %arrayidx23 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %4
  %5 = load <4 x float> addrspace(1)* %arrayidx23, align 16, !tbaa !2
  %mul24 = shl i32 %call6, 1
  %add25 = add i32 %add15, %mul24
  %arrayidx26 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %add25
  store <4 x float> %5, <4 x float> addrspace(3)* %arrayidx26, align 16, !tbaa !2
  %mul27 = mul i32 %call, 3
  %add28 = add i32 %add12, %mul27
  %6 = sext i32 %add28 to i64
  %arrayidx29 = getelementptr inbounds <4 x float> addrspace(1)* %input, i64 %6
  %7 = load <4 x float> addrspace(1)* %arrayidx29, align 16, !tbaa !2
  %mul30 = mul i32 %call6, 3
  %add31 = add i32 %add15, %mul30
  %arrayidx32 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %add31
  store <4 x float> %7, <4 x float> addrspace(3)* %arrayidx32, align 16, !tbaa !2
  tail call void @barrier(i32 1) #2
  %add34 = add i32 %mul8, %call4
  %add36 = add i32 %mul, %call5
  %mul38 = mul i32 %mul10, %add36
  %add39 = add i32 %add34, %mul38
  %mul40 = shl i32 %call4, 2
  %mul41 = mul i32 %mul40, %call6
  %add42 = add i32 %mul41, %call5
  %arrayidx43 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %add42
  %8 = load <4 x float> addrspace(3)* %arrayidx43, align 16, !tbaa !2
  %add44 = add i32 %add42, %call6
  %arrayidx45 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %add44
  %9 = load <4 x float> addrspace(3)* %arrayidx45, align 16, !tbaa !2
  %add47 = add i32 %add42, %mul24
  %arrayidx48 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %add47
  %10 = load <4 x float> addrspace(3)* %arrayidx48, align 16, !tbaa !2
  %add50 = add i32 %add42, %mul30
  %arrayidx51 = getelementptr inbounds <4 x float> addrspace(3)* %block, i32 %add50
  %11 = load <4 x float> addrspace(3)* %arrayidx51, align 16, !tbaa !2
  %vecinit52 = shufflevector <4 x float> %8, <4 x float> %9, <4 x i32> <i32 0, i32 4, i32 undef, i32 undef>
  %vecinit53 = shufflevector <4 x float> %vecinit52, <4 x float> %10, <4 x i32> <i32 0, i32 1, i32 4, i32 undef>
  %vecinit54 = shufflevector <4 x float> %vecinit53, <4 x float> %11, <4 x i32> <i32 0, i32 1, i32 2, i32 4>
  %12 = sext i32 %add39 to i64
  %arrayidx55 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %12
  store <4 x float> %vecinit54, <4 x float> addrspace(1)* %arrayidx55, align 16, !tbaa !2
  %vecinit58 = shufflevector <4 x float> %8, <4 x float> %9, <4 x i32> <i32 1, i32 5, i32 undef, i32 undef>
  %vecinit59 = shufflevector <4 x float> %vecinit58, <4 x float> %10, <4 x i32> <i32 0, i32 1, i32 5, i32 undef>
  %vecinit60 = shufflevector <4 x float> %vecinit59, <4 x float> %11, <4 x i32> <i32 0, i32 1, i32 2, i32 5>
  %add61 = add i32 %add39, %call
  %13 = sext i32 %add61 to i64
  %arrayidx62 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %13
  store <4 x float> %vecinit60, <4 x float> addrspace(1)* %arrayidx62, align 16, !tbaa !2
  %vecinit65 = shufflevector <4 x float> %8, <4 x float> %9, <4 x i32> <i32 2, i32 6, i32 undef, i32 undef>
  %vecinit66 = shufflevector <4 x float> %vecinit65, <4 x float> %10, <4 x i32> <i32 0, i32 1, i32 6, i32 undef>
  %vecinit67 = shufflevector <4 x float> %vecinit66, <4 x float> %11, <4 x i32> <i32 0, i32 1, i32 2, i32 6>
  %add69 = add i32 %add39, %mul21
  %14 = sext i32 %add69 to i64
  %arrayidx70 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %14
  store <4 x float> %vecinit67, <4 x float> addrspace(1)* %arrayidx70, align 16, !tbaa !2
  %vecinit73 = shufflevector <4 x float> %8, <4 x float> %9, <4 x i32> <i32 3, i32 7, i32 undef, i32 undef>
  %vecinit74 = shufflevector <4 x float> %vecinit73, <4 x float> %10, <4 x i32> <i32 0, i32 1, i32 7, i32 undef>
  %vecinit75 = shufflevector <4 x float> %vecinit74, <4 x float> %11, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %add77 = add i32 %add39, %mul27
  %15 = sext i32 %add77 to i64
  %arrayidx78 = getelementptr inbounds <4 x float> addrspace(1)* %output, i64 %15
  store <4 x float> %vecinit75, <4 x float> addrspace(1)* %arrayidx78, align 16, !tbaa !2
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
!1 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}

; ModuleID = 'MemoryOptimizations_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @copy1DFastPath(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_3
  %tmp_7 = load float addrspace(1)* %tmp_6, align 4
  %tmp_10 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_3
  store float %tmp_7, float addrspace(1)* %tmp_10, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

; Function Attrs: nounwind
define void @copy1DCompletePath(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = icmp slt i32 %tmp_3, 0
  br i1 %tmp_5, label %tmp_6, label %tmp_10

tmp_6:                                            ; preds = %0
  %tmp_8 = bitcast float addrspace(1)* %output to i32 addrspace(1)*
  %tmp_9 = call i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)* %tmp_8, i32 1)
  br label %tmp_10

tmp_10:                                           ; preds = %tmp_6, %0
  %tmp_13 = getelementptr inbounds float addrspace(1)* %input, i32 %tmp_3
  %tmp_14 = load float addrspace(1)* %tmp_13, align 4
  %tmp_17 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_3
  store float %tmp_14, float addrspace(1)* %tmp_17, align 4
  ret void
}

declare i32 @_Z8atom_addPU3AS1ii(i32 addrspace(1)*, i32) #1

; Function Attrs: nounwind
define void @copy2Dfloat(float addrspace(1)* %A, float addrspace(1)* %C) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = call i32 @__get_global_id_u32(i32 1)
  %tmp_6 = mul nsw i32 %tmp_4, 1024
  %tmp_8 = add nsw i32 %tmp_6, %tmp_3
  %tmp_10 = getelementptr inbounds float addrspace(1)* %A, i32 %tmp_8
  %tmp_11 = load float addrspace(1)* %tmp_10, align 4
  %tmp_13 = mul nsw i32 %tmp_4, 1024
  %tmp_15 = add nsw i32 %tmp_13, %tmp_3
  %tmp_17 = getelementptr inbounds float addrspace(1)* %C, i32 %tmp_15
  store float %tmp_11, float addrspace(1)* %tmp_17, align 4
  ret void
}

; Function Attrs: nounwind
define void @copy2Dfloat4(<4 x float> addrspace(1)* %A, <4 x float> addrspace(1)* %C) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = call i32 @__get_global_id_u32(i32 1)
  %tmp_6 = mul nsw i32 %tmp_4, 1024
  %tmp_8 = add nsw i32 %tmp_6, %tmp_3
  %tmp_10 = getelementptr inbounds <4 x float> addrspace(1)* %A, i32 %tmp_8
  %tmp_11 = load <4 x float> addrspace(1)* %tmp_10, align 16
  %tmp_13 = mul nsw i32 %tmp_4, 1024
  %tmp_15 = add nsw i32 %tmp_13, %tmp_3
  %tmp_17 = getelementptr inbounds <4 x float> addrspace(1)* %C, i32 %tmp_15
  store <4 x float> %tmp_11, <4 x float> addrspace(1)* %tmp_17, align 16
  ret void
}

; Function Attrs: nounwind
define void @copy1Dfloat4(<4 x float> addrspace(1)* %input, <4 x float> addrspace(1)* %output) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_6 = getelementptr inbounds <4 x float> addrspace(1)* %input, i32 %tmp_3
  %tmp_7 = load <4 x float> addrspace(1)* %tmp_6, align 16
  %tmp_10 = getelementptr inbounds <4 x float> addrspace(1)* %output, i32 %tmp_3
  store <4 x float> %tmp_7, <4 x float> addrspace(1)* %tmp_10, align 16
  ret void
}

; Function Attrs: nounwind
define void @NoCoal(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = sub i32 %tmp_3, 1
  %tmp_5 = call i32 @__get_local_id_u32(i32 0)
  %tmp_6 = and i32 %tmp_5, 15
  %tmp_7 = icmp eq i32 %tmp_6, 0
  br i1 %tmp_7, label %tmp_8, label %tmp_11

tmp_8:                                            ; preds = %0
  %tmp_10 = add nsw i32 %tmp_4, 16
  br label %tmp_11

tmp_11:                                           ; preds = %tmp_8, %0
  %gid.0 = phi i32 [ %tmp_10, %tmp_8 ], [ %tmp_4, %0 ]
  %tmp_14 = getelementptr inbounds float addrspace(1)* %input, i32 %gid.0
  %tmp_15 = load float addrspace(1)* %tmp_14, align 4
  %tmp_18 = getelementptr inbounds float addrspace(1)* %output, i32 %gid.0
  store float %tmp_15, float addrspace(1)* %tmp_18, align 4
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

; Function Attrs: nounwind
define void @Split(float addrspace(1)* %input, float addrspace(1)* %output) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_5 = and i32 %tmp_3, 1
  %tmp_6 = icmp eq i32 %tmp_5, 0
  br i1 %tmp_6, label %tmp_7, label %tmp_13

tmp_7:                                            ; preds = %0
  %tmp_9 = and i32 %tmp_3, 0
  %tmp_10 = add nsw i32 %tmp_9, 62
  %tmp_11 = call i32 @__get_local_id_u32(i32 0)
  %tmp_12 = sub i32 %tmp_10, %tmp_11
  br label %tmp_13

tmp_13:                                           ; preds = %tmp_7, %0
  %gid.0 = phi i32 [ %tmp_12, %tmp_7 ], [ %tmp_3, %0 ]
  %tmp_16 = getelementptr inbounds float addrspace(1)* %input, i32 %gid.0
  %tmp_17 = load float addrspace(1)* %tmp_16, align 4
  %tmp_20 = getelementptr inbounds float addrspace(1)* %output, i32 %gid.0
  store float %tmp_17, float addrspace(1)* %tmp_20, align 4
  ret void
}

; Function Attrs: nounwind
define void @localBankConflicts(float addrspace(3)* %share, float addrspace(1)* %output) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = call i32 @__get_local_id_u32(i32 0)
  br label %tmp_5

tmp_5:                                            ; preds = %tmp_32, %0
  %resulta.0 = phi i32 [ 0, %0 ], [ %tmp_19, %tmp_32 ]
  %resultb.0 = phi i32 [ 0, %0 ], [ %tmp_31, %tmp_32 ]
  %i.0 = phi i32 [ 0, %0 ], [ %tmp_34, %tmp_32 ]
  %tmp_7 = icmp slt i32 %i.0, 128
  br i1 %tmp_7, label %tmp_8, label %tmp_35

tmp_8:                                            ; preds = %tmp_5
  %tmp_10 = mul nsw i32 %tmp_4, 32
  %tmp_12 = add nsw i32 %tmp_10, %i.0
  %tmp_14 = getelementptr inbounds float addrspace(3)* %share, i32 %tmp_12
  %tmp_15 = load float addrspace(3)* %tmp_14, align 4
  %tmp_17 = sitofp i32 %resulta.0 to float
  %tmp_18 = fadd float %tmp_17, %tmp_15
  %tmp_19 = fptosi float %tmp_18 to i32
  %tmp_21 = mul nsw i32 %tmp_4, 32
  %tmp_23 = add nsw i32 %tmp_21, %i.0
  %tmp_24 = add nsw i32 %tmp_23, 1
  %tmp_26 = getelementptr inbounds float addrspace(3)* %share, i32 %tmp_24
  %tmp_27 = load float addrspace(3)* %tmp_26, align 4
  %tmp_29 = sitofp i32 %resultb.0 to float
  %tmp_30 = fadd float %tmp_29, %tmp_27
  %tmp_31 = fptosi float %tmp_30 to i32
  br label %tmp_32

tmp_32:                                           ; preds = %tmp_8
  %tmp_34 = add nsw i32 %i.0, 2
  br label %tmp_5

tmp_35:                                           ; preds = %tmp_5
  %tmp_38 = add nsw i32 %resulta.0, %resultb.0
  %tmp_39 = sitofp i32 %tmp_38 to float
  %tmp_42 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_3
  store float %tmp_39, float addrspace(1)* %tmp_42, align 4
  ret void
}

; Function Attrs: nounwind
define void @noLocalBankConflicts(float addrspace(3)* %share, float addrspace(1)* %output) #0 {
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  %tmp_4 = call i32 @__get_local_id_u32(i32 0)
  br label %tmp_5

tmp_5:                                            ; preds = %tmp_30, %0
  %resulta.0 = phi i32 [ 0, %0 ], [ %tmp_18, %tmp_30 ]
  %resultb.0 = phi i32 [ 0, %0 ], [ %tmp_29, %tmp_30 ]
  %i.0 = phi i32 [ 0, %0 ], [ %tmp_32, %tmp_30 ]
  %tmp_7 = icmp slt i32 %i.0, 128
  br i1 %tmp_7, label %tmp_8, label %tmp_33

tmp_8:                                            ; preds = %tmp_5
  %tmp_11 = add nsw i32 %i.0, %tmp_4
  %tmp_13 = getelementptr inbounds float addrspace(3)* %share, i32 %tmp_11
  %tmp_14 = load float addrspace(3)* %tmp_13, align 4
  %tmp_16 = sitofp i32 %resulta.0 to float
  %tmp_17 = fadd float %tmp_16, %tmp_14
  %tmp_18 = fptosi float %tmp_17 to i32
  %tmp_20 = add nsw i32 %i.0, 1
  %tmp_22 = add nsw i32 %tmp_20, %tmp_4
  %tmp_24 = getelementptr inbounds float addrspace(3)* %share, i32 %tmp_22
  %tmp_25 = load float addrspace(3)* %tmp_24, align 4
  %tmp_27 = sitofp i32 %resultb.0 to float
  %tmp_28 = fadd float %tmp_27, %tmp_25
  %tmp_29 = fptosi float %tmp_28 to i32
  br label %tmp_30

tmp_30:                                           ; preds = %tmp_8
  %tmp_32 = add nsw i32 %i.0, 2
  br label %tmp_5

tmp_33:                                           ; preds = %tmp_5
  %tmp_36 = add nsw i32 %resulta.0, %resultb.0
  %tmp_37 = sitofp i32 %tmp_36 to float
  %tmp_40 = getelementptr inbounds float addrspace(1)* %output, i32 %tmp_3
  store float %tmp_37, float addrspace(1)* %tmp_40, align 4
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy1DFastPath}
!1 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy1DCompletePath}
!2 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @copy2Dfloat}
!3 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @copy2Dfloat4}
!4 = metadata !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @copy1Dfloat4}
!5 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @NoCoal}
!6 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @Split}
!7 = metadata !{void (float addrspace(3)*, float addrspace(1)*)* @localBankConflicts}
!8 = metadata !{void (float addrspace(3)*, float addrspace(1)*)* @noLocalBankConflicts}
!9 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

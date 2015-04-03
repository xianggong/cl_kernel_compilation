; ModuleID = 'BitonicSort_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @bitonicSort(i32 addrspace(1)* %theArray, i32 %stage, i32 %passOfStage, i32 %direction) #0 {
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  %tmp_9 = sub i32 %stage, %passOfStage
  %tmp_10 = and i32 %tmp_9, 31
  %tmp_11 = shl i32 1, %tmp_10
  %tmp_13 = mul i32 2, %tmp_11
  %tmp_16 = urem i32 %tmp_6, %tmp_11
  %tmp_19 = udiv i32 %tmp_6, %tmp_11
  %tmp_21 = mul i32 %tmp_19, %tmp_13
  %tmp_22 = add i32 %tmp_16, %tmp_21
  %tmp_25 = add i32 %tmp_22, %tmp_11
  %tmp_28 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %tmp_22
  %tmp_29 = load i32 addrspace(1)* %tmp_28, align 4
  %tmp_32 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %tmp_25
  %tmp_33 = load i32 addrspace(1)* %tmp_32, align 4
  %tmp_35 = and i32 %stage, 31
  %tmp_36 = shl i32 1, %tmp_35
  %tmp_39 = udiv i32 %tmp_6, %tmp_36
  %tmp_40 = urem i32 %tmp_39, 2
  %tmp_41 = icmp eq i32 %tmp_40, 1
  br i1 %tmp_41, label %tmp_42, label %tmp_45

tmp_42:                                           ; preds = %0
  %tmp_44 = sub i32 1, %direction
  br label %tmp_45

tmp_45:                                           ; preds = %tmp_42, %0
  %sortIncreasing.0 = phi i32 [ %tmp_44, %tmp_42 ], [ %direction, %0 ]
  %tmp_48 = icmp ugt i32 %tmp_29, %tmp_33
  br i1 %tmp_48, label %tmp_49, label %tmp_52

tmp_49:                                           ; preds = %tmp_45
  br label %tmp_55

tmp_52:                                           ; preds = %tmp_45
  br label %tmp_55

tmp_55:                                           ; preds = %tmp_52, %tmp_49
  %greater.0 = phi i32 [ %tmp_29, %tmp_49 ], [ %tmp_33, %tmp_52 ]
  %lesser.0 = phi i32 [ %tmp_33, %tmp_49 ], [ %tmp_29, %tmp_52 ]
  %tmp_57 = icmp ne i32 %sortIncreasing.0, 0
  br i1 %tmp_57, label %tmp_58, label %tmp_67

tmp_58:                                           ; preds = %tmp_55
  %tmp_62 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %tmp_22
  store i32 %lesser.0, i32 addrspace(1)* %tmp_62, align 4
  %tmp_66 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %tmp_25
  store i32 %greater.0, i32 addrspace(1)* %tmp_66, align 4
  br label %tmp_76

tmp_67:                                           ; preds = %tmp_55
  %tmp_71 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %tmp_22
  store i32 %greater.0, i32 addrspace(1)* %tmp_71, align 4
  %tmp_75 = getelementptr inbounds i32 addrspace(1)* %theArray, i32 %tmp_25
  store i32 %lesser.0, i32 addrspace(1)* %tmp_75, align 4
  br label %tmp_76

tmp_76:                                           ; preds = %tmp_67, %tmp_58
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32, i32, i32)* @bitonicSort}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

; ModuleID = '../kernel-src/BitonicSort_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @bitonicSort(i32 addrspace(1)* %theArray, i32 %stage, i32 %passOfStage, i32 %direction) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %sortIncreasing = alloca i32, align 4
  %threadId = alloca i32, align 4
  %pairDistance = alloca i32, align 4
  %blockWidth = alloca i32, align 4
  %leftId = alloca i32, align 4
  %rightId = alloca i32, align 4
  %leftElement = alloca i32, align 4
  %rightElement = alloca i32, align 4
  %sameDirectionBlockWidth = alloca i32, align 4
  %greater = alloca i32, align 4
  %lesser = alloca i32, align 4
  store i32 addrspace(1)* %theArray, i32 addrspace(1)** %tmp_1, align 4
  store i32 %stage, i32* %tmp_2, align 4
  store i32 %passOfStage, i32* %tmp_3, align 4
  store i32 %direction, i32* %tmp_4, align 4
  %tmp_5 = load i32* %tmp_4, align 4
  store i32 %tmp_5, i32* %sortIncreasing, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_6, i32* %threadId, align 4
  %tmp_7 = load i32* %tmp_2, align 4
  %tmp_8 = load i32* %tmp_3, align 4
  %tmp_9 = sub i32 %tmp_7, %tmp_8
  %tmp_10 = and i32 %tmp_9, 31
  %tmp_11 = shl i32 1, %tmp_10
  store i32 %tmp_11, i32* %pairDistance, align 4
  %tmp_12 = load i32* %pairDistance, align 4
  %tmp_13 = mul i32 2, %tmp_12
  store i32 %tmp_13, i32* %blockWidth, align 4
  %tmp_14 = load i32* %threadId, align 4
  %tmp_15 = load i32* %pairDistance, align 4
  %tmp_16 = urem i32 %tmp_14, %tmp_15
  %tmp_17 = load i32* %threadId, align 4
  %tmp_18 = load i32* %pairDistance, align 4
  %tmp_19 = udiv i32 %tmp_17, %tmp_18
  %tmp_20 = load i32* %blockWidth, align 4
  %tmp_21 = mul i32 %tmp_19, %tmp_20
  %tmp_22 = add i32 %tmp_16, %tmp_21
  store i32 %tmp_22, i32* %leftId, align 4
  %tmp_23 = load i32* %leftId, align 4
  %tmp_24 = load i32* %pairDistance, align 4
  %tmp_25 = add i32 %tmp_23, %tmp_24
  store i32 %tmp_25, i32* %rightId, align 4
  %tmp_26 = load i32* %leftId, align 4
  %tmp_27 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_28 = getelementptr inbounds i32 addrspace(1)* %tmp_27, i32 %tmp_26
  %tmp_29 = load i32 addrspace(1)* %tmp_28, align 4
  store i32 %tmp_29, i32* %leftElement, align 4
  %tmp_30 = load i32* %rightId, align 4
  %tmp_31 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_32 = getelementptr inbounds i32 addrspace(1)* %tmp_31, i32 %tmp_30
  %tmp_33 = load i32 addrspace(1)* %tmp_32, align 4
  store i32 %tmp_33, i32* %rightElement, align 4
  %tmp_34 = load i32* %tmp_2, align 4
  %tmp_35 = and i32 %tmp_34, 31
  %tmp_36 = shl i32 1, %tmp_35
  store i32 %tmp_36, i32* %sameDirectionBlockWidth, align 4
  %tmp_37 = load i32* %threadId, align 4
  %tmp_38 = load i32* %sameDirectionBlockWidth, align 4
  %tmp_39 = udiv i32 %tmp_37, %tmp_38
  %tmp_40 = urem i32 %tmp_39, 2
  %tmp_41 = icmp eq i32 %tmp_40, 1
  br i1 %tmp_41, label %tmp_42, label %tmp_45

tmp_42:                                      ; preds = %tmp_0
  %tmp_43 = load i32* %sortIncreasing, align 4
  %tmp_44 = sub i32 1, %tmp_43
  store i32 %tmp_44, i32* %sortIncreasing, align 4
  br label %tmp_45

tmp_45:                                      ; preds = %tmp_42, %tmp_0
  %tmp_46 = load i32* %leftElement, align 4
  %tmp_47 = load i32* %rightElement, align 4
  %tmp_48 = icmp ugt i32 %tmp_46, %tmp_47
  br i1 %tmp_48, label %tmp_49, label %tmp_52

tmp_49:                                      ; preds = %tmp_45
  %tmp_50 = load i32* %leftElement, align 4
  store i32 %tmp_50, i32* %greater, align 4
  %tmp_51 = load i32* %rightElement, align 4
  store i32 %tmp_51, i32* %lesser, align 4
  br label %tmp_55

tmp_52:                                      ; preds = %tmp_45
  %tmp_53 = load i32* %rightElement, align 4
  store i32 %tmp_53, i32* %greater, align 4
  %tmp_54 = load i32* %leftElement, align 4
  store i32 %tmp_54, i32* %lesser, align 4
  br label %tmp_55

tmp_55:                                      ; preds = %tmp_52, %tmp_49
  %tmp_56 = load i32* %sortIncreasing, align 4
  %tmp_57 = icmp ne i32 %tmp_56, 0
  br i1 %tmp_57, label %tmp_58, label %tmp_67

tmp_58:                                      ; preds = %tmp_55
  %tmp_59 = load i32* %lesser, align 4
  %tmp_60 = load i32* %leftId, align 4
  %tmp_61 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_62 = getelementptr inbounds i32 addrspace(1)* %tmp_61, i32 %tmp_60
  store i32 %tmp_59, i32 addrspace(1)* %tmp_62, align 4
  %tmp_63 = load i32* %greater, align 4
  %tmp_64 = load i32* %rightId, align 4
  %tmp_65 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_66 = getelementptr inbounds i32 addrspace(1)* %tmp_65, i32 %tmp_64
  store i32 %tmp_63, i32 addrspace(1)* %tmp_66, align 4
  br label %tmp_76

tmp_67:                                      ; preds = %tmp_55
  %tmp_68 = load i32* %greater, align 4
  %tmp_69 = load i32* %leftId, align 4
  %tmp_70 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_71 = getelementptr inbounds i32 addrspace(1)* %tmp_70, i32 %tmp_69
  store i32 %tmp_68, i32 addrspace(1)* %tmp_71, align 4
  %tmp_72 = load i32* %lesser, align 4
  %tmp_73 = load i32* %rightId, align 4
  %tmp_74 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_75 = getelementptr inbounds i32 addrspace(1)* %tmp_74, i32 %tmp_73
  store i32 %tmp_72, i32 addrspace(1)* %tmp_75, align 4
  br label %tmp_76

tmp_76:                                      ; preds = %tmp_67, %tmp_58
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32, i32, i32)* @bitonicSort}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

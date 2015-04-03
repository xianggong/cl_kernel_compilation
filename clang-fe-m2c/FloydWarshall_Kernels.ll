; ModuleID = '../kernel-src/FloydWarshall_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @floydWarshallPass(i32 addrspace(1)* %pathDistanceBuffer, i32 addrspace(1)* %pathBuffer, i32 %numNodes, i32 %pass) #0 {
  %tmp_1 = alloca i32 addrspace(1)*, align 4
  %tmp_2 = alloca i32 addrspace(1)*, align 4
  %tmp_3 = alloca i32, align 4
  %tmp_4 = alloca i32, align 4
  %xValue = alloca i32, align 4
  %yValue = alloca i32, align 4
  %k = alloca i32, align 4
  %oldWeight = alloca i32, align 4
  %tempWeight = alloca i32, align 4
  store i32 addrspace(1)* %pathDistanceBuffer, i32 addrspace(1)** %tmp_1, align 4
  store i32 addrspace(1)* %pathBuffer, i32 addrspace(1)** %tmp_2, align 4
  store i32 %numNodes, i32* %tmp_3, align 4
  store i32 %pass, i32* %tmp_4, align 4
  %tmp_5 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_5, i32* %xValue, align 4
  %tmp_6 = call i32 @__get_global_id_u32(i32 1)
  store i32 %tmp_6, i32* %yValue, align 4
  %tmp_7 = load i32* %tmp_4, align 4
  store i32 %tmp_7, i32* %k, align 4
  %tmp_8 = load i32* %yValue, align 4
  %tmp_9 = load i32* %tmp_3, align 4
  %tmp_10 = mul i32 %tmp_8, %tmp_9
  %tmp_11 = load i32* %xValue, align 4
  %tmp_12 = add i32 %tmp_10, %tmp_11
  %tmp_13 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_14 = getelementptr inbounds i32 addrspace(1)* %tmp_13, i32 %tmp_12
  %tmp_15 = load i32 addrspace(1)* %tmp_14, align 4
  store i32 %tmp_15, i32* %oldWeight, align 4
  %tmp_16 = load i32* %yValue, align 4
  %tmp_17 = load i32* %tmp_3, align 4
  %tmp_18 = mul i32 %tmp_16, %tmp_17
  %tmp_19 = load i32* %k, align 4
  %tmp_20 = add i32 %tmp_18, %tmp_19
  %tmp_21 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_22 = getelementptr inbounds i32 addrspace(1)* %tmp_21, i32 %tmp_20
  %tmp_23 = load i32 addrspace(1)* %tmp_22, align 4
  %tmp_24 = load i32* %k, align 4
  %tmp_25 = load i32* %tmp_3, align 4
  %tmp_26 = mul i32 %tmp_24, %tmp_25
  %tmp_27 = load i32* %xValue, align 4
  %tmp_28 = add i32 %tmp_26, %tmp_27
  %tmp_29 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_30 = getelementptr inbounds i32 addrspace(1)* %tmp_29, i32 %tmp_28
  %tmp_31 = load i32 addrspace(1)* %tmp_30, align 4
  %tmp_32 = add i32 %tmp_23, %tmp_31
  store i32 %tmp_32, i32* %tempWeight, align 4
  %tmp_33 = load i32* %tempWeight, align 4
  %tmp_34 = load i32* %oldWeight, align 4
  %tmp_35 = icmp slt i32 %tmp_33, %tmp_34
  br i1 %tmp_35, label %tmp_36, label %tmp_53

tmp_36:                                      ; preds = %tmp_0
  %tmp_37 = load i32* %tempWeight, align 4
  %tmp_38 = load i32* %yValue, align 4
  %tmp_39 = load i32* %tmp_3, align 4
  %tmp_40 = mul i32 %tmp_38, %tmp_39
  %tmp_41 = load i32* %xValue, align 4
  %tmp_42 = add i32 %tmp_40, %tmp_41
  %tmp_43 = load i32 addrspace(1)** %tmp_1, align 4
  %tmp_44 = getelementptr inbounds i32 addrspace(1)* %tmp_43, i32 %tmp_42
  store i32 %tmp_37, i32 addrspace(1)* %tmp_44, align 4
  %tmp_45 = load i32* %k, align 4
  %tmp_46 = load i32* %yValue, align 4
  %tmp_47 = load i32* %tmp_3, align 4
  %tmp_48 = mul i32 %tmp_46, %tmp_47
  %tmp_49 = load i32* %xValue, align 4
  %tmp_50 = add i32 %tmp_48, %tmp_49
  %tmp_51 = load i32 addrspace(1)** %tmp_2, align 4
  %tmp_52 = getelementptr inbounds i32 addrspace(1)* %tmp_51, i32 %tmp_50
  store i32 %tmp_45, i32 addrspace(1)* %tmp_52, align 4
  br label %tmp_53

tmp_53:                                      ; preds = %tmp_36, %tmp_0
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32)* @floydWarshallPass}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

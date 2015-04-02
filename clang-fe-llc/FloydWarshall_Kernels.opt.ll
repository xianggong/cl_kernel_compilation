; ModuleID = 'FloydWarshall_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @floydWarshallPass(i32 addrspace(1)* %pathDistanceBuffer, i32 addrspace(1)* %pathBuffer, i32 %numNodes, i32 %pass) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = call i32 @get_global_id(i32 1)
  %3 = mul i32 %2, %numNodes
  %4 = add i32 %3, %1
  %5 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i32 %4
  %6 = load i32 addrspace(1)* %5, align 4
  %7 = mul i32 %2, %numNodes
  %8 = add i32 %7, %pass
  %9 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i32 %8
  %10 = load i32 addrspace(1)* %9, align 4
  %11 = mul i32 %pass, %numNodes
  %12 = add i32 %11, %1
  %13 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i32 %12
  %14 = load i32 addrspace(1)* %13, align 4
  %15 = add i32 %10, %14
  %16 = icmp slt i32 %15, %6
  br i1 %16, label %17, label %24

; <label>:17                                      ; preds = %0
  %18 = mul i32 %2, %numNodes
  %19 = add i32 %18, %1
  %20 = getelementptr inbounds i32 addrspace(1)* %pathDistanceBuffer, i32 %19
  store i32 %15, i32 addrspace(1)* %20, align 4
  %21 = mul i32 %2, %numNodes
  %22 = add i32 %21, %1
  %23 = getelementptr inbounds i32 addrspace(1)* %pathBuffer, i32 %22
  store i32 %pass, i32 addrspace(1)* %23, align 4
  br label %24

; <label>:24                                      ; preds = %17, %0
  ret void
}

declare i32 @get_global_id(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32)* @floydWarshallPass}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

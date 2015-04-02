; ModuleID = 'DeviceFission_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @Add(i32 addrspace(1)* %input, i32 addrspace(1)* %output) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = getelementptr inbounds i32 addrspace(1)* %input, i32 %1
  %3 = load i32 addrspace(1)* %2, align 4
  %4 = add nsw i32 %3, 1
  %5 = getelementptr inbounds i32 addrspace(1)* %output, i32 %1
  store i32 %4, i32 addrspace(1)* %5, align 4
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind
define void @Sub(i32 addrspace(1)* %input, i32 addrspace(1)* %output) #0 {
  %1 = call i32 @get_global_id(i32 0)
  %2 = getelementptr inbounds i32 addrspace(1)* %input, i32 %1
  %3 = load i32 addrspace(1)* %2, align 4
  %4 = sub nsw i32 %3, 1
  %5 = getelementptr inbounds i32 addrspace(1)* %output, i32 %1
  store i32 %4, i32 addrspace(1)* %5, align 4
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @Add}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @Sub}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

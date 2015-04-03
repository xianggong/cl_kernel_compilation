; ModuleID = '../kernel-src/BasicDebug_Kernel2.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @debugKernel(float addrspace(1)* %inputbuffer, float addrspace(1)* %outputbuffer) #0 {
  %tmp_1 = alloca float addrspace(1)*, align 4
  %tmp_2 = alloca float addrspace(1)*, align 4
  %globalID = alloca i32, align 4
  %value = alloca i32, align 4
  store float addrspace(1)* %inputbuffer, float addrspace(1)** %tmp_1, align 4
  store float addrspace(1)* %outputbuffer, float addrspace(1)** %tmp_2, align 4
  %tmp_3 = call i32 @__get_global_id_u32(i32 0)
  store i32 %tmp_3, i32* %globalID, align 4
  store i32 0, i32* %value, align 4
  %tmp_4 = load i32* %globalID, align 4
  %tmp_5 = load float addrspace(1)** %tmp_1, align 4
  %tmp_6 = getelementptr inbounds float addrspace(1)* %tmp_5, i32 %tmp_4
  %tmp_7 = load float addrspace(1)* %tmp_6, align 4
  %tmp_8 = fptoui float %tmp_7 to i32
  store i32 %tmp_8, i32* %value, align 4
  %tmp_9 = load i32* %value, align 4
  %tmp_10 = uitofp i32 %tmp_9 to float
  %tmp_11 = load i32* %globalID, align 4
  %tmp_12 = load float addrspace(1)** %tmp_2, align 4
  %tmp_13 = getelementptr inbounds float addrspace(1)* %tmp_12, i32 %tmp_11
  store float %tmp_10, float addrspace(1)* %tmp_13, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*)* @debugKernel}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

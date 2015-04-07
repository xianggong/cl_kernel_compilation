; ModuleID = '../kernel-src/CplusplusWrapper_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @vectorAdd(float addrspace(1)* %output, float addrspace(1)* %inputA, float addrspace(1)* %inputB) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %3 = alloca float addrspace(1)*, align 4
  %gid = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %1, align 4
  store float addrspace(1)* %inputA, float addrspace(1)** %2, align 4
  store float addrspace(1)* %inputB, float addrspace(1)** %3, align 4
  %4 = call i32 @llvm.r600.read.tgid.x()
  store i32 %4, i32* %gid, align 4
  %5 = load i32* %gid, align 4
  %6 = load float addrspace(1)** %2, align 4
  %7 = getelementptr inbounds float addrspace(1)* %6, i32 %5
  %8 = load float addrspace(1)* %7, align 4
  %9 = load i32* %gid, align 4
  %10 = load float addrspace(1)** %3, align 4
  %11 = getelementptr inbounds float addrspace(1)* %10, i32 %9
  %12 = load float addrspace(1)* %11, align 4
  %13 = fadd float %8, %12
  %14 = load i32* %gid, align 4
  %15 = load float addrspace(1)** %1, align 4
  %16 = getelementptr inbounds float addrspace(1)* %15, i32 %14
  store float %13, float addrspace(1)* %16, align 4
  ret void
}

declare i32 @llvm.r600.read.tgid.x() #1
declare i32 @llvm.r600.read.tgid.y() #1
declare i32 @llvm.r600.read.tgid.z() #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*)* @vectorAdd}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

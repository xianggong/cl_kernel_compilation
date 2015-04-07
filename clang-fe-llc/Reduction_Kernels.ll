; ModuleID = '../kernel-src/Reduction_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @reduce(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(3)* %sdata) #0 {
  %1 = alloca <4 x i32> addrspace(1)*, align 4
  %2 = alloca <4 x i32> addrspace(1)*, align 4
  %3 = alloca <4 x i32> addrspace(3)*, align 4
  %tid = alloca i32, align 4
  %bid = alloca i32, align 4
  %gid = alloca i32, align 4
  %localSize = alloca i32, align 4
  %stride = alloca i32, align 4
  %s = alloca i32, align 4
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %1, align 4
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %2, align 4
  store <4 x i32> addrspace(3)* %sdata, <4 x i32> addrspace(3)** %3, align 4
  %4 = call i32 @llvm.r600.read.tidig.x()
  store i32 %4, i32* %tid, align 4
  %5 = call i32 @get_group_id(i32 0)
  store i32 %5, i32* %bid, align 4
  %6 = call i32 @llvm.r600.read.tgid.x()
  store i32 %6, i32* %gid, align 4
  %7 = call i32 @llvm.r600.read.local.size.x()
  store i32 %7, i32* %localSize, align 4
  %8 = load i32* %gid, align 4
  %9 = mul i32 %8, 2
  store i32 %9, i32* %stride, align 4
  %10 = load i32* %stride, align 4
  %11 = load <4 x i32> addrspace(1)** %1, align 4
  %12 = getelementptr inbounds <4 x i32> addrspace(1)* %11, i32 %10
  %13 = load <4 x i32> addrspace(1)* %12, align 16
  %14 = load i32* %stride, align 4
  %15 = add i32 %14, 1
  %16 = load <4 x i32> addrspace(1)** %1, align 4
  %17 = getelementptr inbounds <4 x i32> addrspace(1)* %16, i32 %15
  %18 = load <4 x i32> addrspace(1)* %17, align 16
  %19 = add <4 x i32> %13, %18
  %20 = load i32* %tid, align 4
  %21 = load <4 x i32> addrspace(3)** %3, align 4
  %22 = getelementptr inbounds <4 x i32> addrspace(3)* %21, i32 %20
  store <4 x i32> %19, <4 x i32> addrspace(3)* %22, align 16
  call void @barrier(i32 1)
  %23 = load i32* %localSize, align 4
  %24 = lshr i32 %23, 1
  store i32 %24, i32* %s, align 4
  br label %25

; <label>:25                                      ; preds = %45, %0
  %26 = load i32* %s, align 4
  %27 = icmp ugt i32 %26, 0
  br i1 %27, label %28, label %48

; <label>:28                                      ; preds = %25
  %29 = load i32* %tid, align 4
  %30 = load i32* %s, align 4
  %31 = icmp ult i32 %29, %30
  br i1 %31, label %32, label %44

; <label>:32                                      ; preds = %28
  %33 = load i32* %tid, align 4
  %34 = load i32* %s, align 4
  %35 = add i32 %33, %34
  %36 = load <4 x i32> addrspace(3)** %3, align 4
  %37 = getelementptr inbounds <4 x i32> addrspace(3)* %36, i32 %35
  %38 = load <4 x i32> addrspace(3)* %37, align 16
  %39 = load i32* %tid, align 4
  %40 = load <4 x i32> addrspace(3)** %3, align 4
  %41 = getelementptr inbounds <4 x i32> addrspace(3)* %40, i32 %39
  %42 = load <4 x i32> addrspace(3)* %41, align 16
  %43 = add <4 x i32> %42, %38
  store <4 x i32> %43, <4 x i32> addrspace(3)* %41, align 16
  br label %44

; <label>:44                                      ; preds = %32, %28
  call void @barrier(i32 1)
  br label %45

; <label>:45                                      ; preds = %44
  %46 = load i32* %s, align 4
  %47 = lshr i32 %46, 1
  store i32 %47, i32* %s, align 4
  br label %25

; <label>:48                                      ; preds = %25
  %49 = load i32* %tid, align 4
  %50 = icmp eq i32 %49, 0
  br i1 %50, label %51, label %58

; <label>:51                                      ; preds = %48
  %52 = load <4 x i32> addrspace(3)** %3, align 4
  %53 = getelementptr inbounds <4 x i32> addrspace(3)* %52, i32 0
  %54 = load <4 x i32> addrspace(3)* %53, align 16
  %55 = load i32* %bid, align 4
  %56 = load <4 x i32> addrspace(1)** %2, align 4
  %57 = getelementptr inbounds <4 x i32> addrspace(1)* %56, i32 %55
  store <4 x i32> %54, <4 x i32> addrspace(1)* %57, align 16
  br label %58

; <label>:58                                      ; preds = %51, %48
  ret void
}

declare i32 @llvm.r600.read.tidig.x() #1
declare i32 @llvm.r600.read.tidig.y() #1
declare i32 @llvm.r600.read.tidig.z() #1

declare i32 @get_group_id(i32) #1

declare i32 @llvm.r600.read.tgid.x() #1
declare i32 @llvm.r600.read.tgid.y() #1
declare i32 @llvm.r600.read.tgid.z() #1

declare i32 @llvm.r600.read.local.size.x() #1
declare i32 @llvm.r600.read.local.size.y() #1
declare i32 @llvm.r600.read.local.size.z() #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @reduce}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

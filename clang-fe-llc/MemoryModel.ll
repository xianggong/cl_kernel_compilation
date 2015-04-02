; ModuleID = '../kernel-src/MemoryModel.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@mask = addrspace(2) global [4 x i32] [i32 1, i32 -1, i32 2, i32 -2], align 4
@MemoryModel.localBuffer = internal addrspace(3) global [64 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @MemoryModel(i32 addrspace(1)* %outputbuffer, i32 addrspace(1)* %inputbuffer) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i32 addrspace(1)*, align 4
  %result = alloca i32, align 4
  %group_id = alloca i32, align 4
  %item_id = alloca i32, align 4
  %gid = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 addrspace(1)* %outputbuffer, i32 addrspace(1)** %1, align 4
  store i32 addrspace(1)* %inputbuffer, i32 addrspace(1)** %2, align 4
  store i32 0, i32* %result, align 4
  %3 = call i32 @get_group_id(i32 0)
  store i32 %3, i32* %group_id, align 4
  %4 = call i32 @get_local_id(i32 0)
  store i32 %4, i32* %item_id, align 4
  %5 = call i32 @get_global_id(i32 0)
  store i32 %5, i32* %gid, align 4
  %6 = load i32* %gid, align 4
  %7 = load i32 addrspace(1)** %2, align 4
  %8 = getelementptr inbounds i32 addrspace(1)* %7, i32 %6
  %9 = load i32 addrspace(1)* %8, align 4
  %10 = load i32* %item_id, align 4
  %11 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %10
  store i32 %9, i32 addrspace(3)* %11, align 4
  call void @barrier(i32 1)
  store i32 0, i32* %i, align 4
  br label %12

; <label>:12                                      ; preds = %24, %0
  %13 = load i32* %i, align 4
  %14 = icmp slt i32 %13, 4
  br i1 %14, label %15, label %27

; <label>:15                                      ; preds = %12
  %16 = load i32* %item_id, align 4
  %17 = load i32* %i, align 4
  %18 = add i32 %16, %17
  %19 = urem i32 %18, 64
  %20 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %19
  %21 = load i32 addrspace(3)* %20, align 4
  %22 = load i32* %result, align 4
  %23 = add nsw i32 %22, %21
  store i32 %23, i32* %result, align 4
  br label %24

; <label>:24                                      ; preds = %15
  %25 = load i32* %i, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, i32* %i, align 4
  br label %12

; <label>:27                                      ; preds = %12
  %28 = load i32* %group_id, align 4
  %29 = urem i32 %28, 4
  %30 = getelementptr inbounds [4 x i32] addrspace(2)* @mask, i32 0, i32 %29
  %31 = load i32 addrspace(2)* %30, align 4
  %32 = load i32* %result, align 4
  %33 = mul nsw i32 %32, %31
  store i32 %33, i32* %result, align 4
  %34 = load i32* %result, align 4
  %35 = load i32* %gid, align 4
  %36 = load i32 addrspace(1)** %1, align 4
  %37 = getelementptr inbounds i32 addrspace(1)* %36, i32 %35
  store i32 %34, i32 addrspace(1)* %37, align 4
  ret void
}

declare i32 @get_group_id(i32) #1

declare i32 @get_local_id(i32) #1

declare i32 @get_global_id(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @MemoryModel}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

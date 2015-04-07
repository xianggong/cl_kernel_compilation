; ModuleID = 'MemoryModel.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@mask = addrspace(2) global [4 x i32] [i32 1, i32 -1, i32 2, i32 -2], align 4
@MemoryModel.localBuffer = internal addrspace(3) global [64 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define void @MemoryModel(i32 addrspace(1)* %outputbuffer, i32 addrspace(1)* %inputbuffer) #0 {
  %1 = call i32 @get_group_id(i32 0)
  %2 = call i32 @llvm.r600.read.tidig.x()
  %3 = call i32 @llvm.r600.read.tgid.x()
  %4 = getelementptr inbounds i32 addrspace(1)* %inputbuffer, i32 %3
  %5 = load i32 addrspace(1)* %4, align 4
  %6 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %2
  store i32 %5, i32 addrspace(3)* %6, align 4
  call void @barrier(i32 1)
  br label %7

; <label>:7                                       ; preds = %15, %0
  %result.0 = phi i32 [ 0, %0 ], [ %14, %15 ]
  %i.0 = phi i32 [ 0, %0 ], [ %16, %15 ]
  %8 = icmp slt i32 %i.0, 4
  br i1 %8, label %9, label %17

; <label>:9                                       ; preds = %7
  %10 = add i32 %2, %i.0
  %11 = urem i32 %10, 64
  %12 = getelementptr inbounds [64 x i32] addrspace(3)* @MemoryModel.localBuffer, i32 0, i32 %11
  %13 = load i32 addrspace(3)* %12, align 4
  %14 = add nsw i32 %result.0, %13
  br label %15

; <label>:15                                      ; preds = %9
  %16 = add nsw i32 %i.0, 1
  br label %7

; <label>:17                                      ; preds = %7
  %18 = urem i32 %1, 4
  %19 = getelementptr inbounds [4 x i32] addrspace(2)* @mask, i32 0, i32 %18
  %20 = load i32 addrspace(2)* %19, align 4
  %21 = mul nsw i32 %result.0, %20
  %22 = getelementptr inbounds i32 addrspace(1)* %outputbuffer, i32 %3
  store i32 %21, i32 addrspace(1)* %22, align 4
  ret void
}

declare i32 @get_group_id(i32) #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.x() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.y() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.z() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.x() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.y() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.z() #2

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @MemoryModel}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

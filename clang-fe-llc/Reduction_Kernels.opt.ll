; ModuleID = 'Reduction_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @reduce(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(3)* %sdata) #0 {
  %1 = call i32 @llvm.r600.read.tidig.x()
  %2 = call i32 @get_group_id(i32 0)
  %3 = call i32 @llvm.r600.read.tgid.x()
  %4 = call i32 @llvm.r600.read.local.size.x()
  %5 = mul i32 %3, 2
  %6 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %5
  %7 = load <4 x i32> addrspace(1)* %6, align 16
  %8 = add i32 %5, 1
  %9 = getelementptr inbounds <4 x i32> addrspace(1)* %input, i32 %8
  %10 = load <4 x i32> addrspace(1)* %9, align 16
  %11 = add <4 x i32> %7, %10
  %12 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %1
  store <4 x i32> %11, <4 x i32> addrspace(3)* %12, align 16
  call void @barrier(i32 1)
  %13 = lshr i32 %4, 1
  br label %14

; <label>:14                                      ; preds = %26, %0
  %s.0 = phi i32 [ %13, %0 ], [ %27, %26 ]
  %15 = icmp ugt i32 %s.0, 0
  br i1 %15, label %16, label %28

; <label>:16                                      ; preds = %14
  %17 = icmp ult i32 %1, %s.0
  br i1 %17, label %18, label %25

; <label>:18                                      ; preds = %16
  %19 = add i32 %1, %s.0
  %20 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %19
  %21 = load <4 x i32> addrspace(3)* %20, align 16
  %22 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 %1
  %23 = load <4 x i32> addrspace(3)* %22, align 16
  %24 = add <4 x i32> %23, %21
  store <4 x i32> %24, <4 x i32> addrspace(3)* %22, align 16
  br label %25

; <label>:25                                      ; preds = %18, %16
  call void @barrier(i32 1)
  br label %26

; <label>:26                                      ; preds = %25
  %27 = lshr i32 %s.0, 1
  br label %14

; <label>:28                                      ; preds = %14
  %29 = icmp eq i32 %1, 0
  br i1 %29, label %30, label %34

; <label>:30                                      ; preds = %28
  %31 = getelementptr inbounds <4 x i32> addrspace(3)* %sdata, i32 0
  %32 = load <4 x i32> addrspace(3)* %31, align 16
  %33 = getelementptr inbounds <4 x i32> addrspace(1)* %output, i32 %2
  store <4 x i32> %32, <4 x i32> addrspace(1)* %33, align 16
  br label %34

; <label>:34                                      ; preds = %30, %28
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.z() #1

declare i32 @get_group_id(i32) #2

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.z() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.local.size.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.local.size.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.local.size.z() #1

declare void @barrier(i32) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, <4 x i32> addrspace(3)*)* @reduce}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

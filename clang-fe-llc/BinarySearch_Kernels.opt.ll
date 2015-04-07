; ModuleID = 'BinarySearch_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @binarySearch(<4 x i32> addrspace(1)* %outputArray, i32 addrspace(1)* %sortedArray, i32 %subdivSize, i32 %globalLowerIndex, i32 %findMe) #0 {
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = mul i32 %1, %subdivSize
  %3 = add i32 %globalLowerIndex, %2
  %4 = getelementptr inbounds i32 addrspace(1)* %sortedArray, i32 %3
  %5 = load i32 addrspace(1)* %4, align 4
  %6 = add i32 %1, 1
  %7 = mul i32 %6, %subdivSize
  %8 = add i32 %globalLowerIndex, %7
  %9 = sub i32 %8, 1
  %10 = getelementptr inbounds i32 addrspace(1)* %sortedArray, i32 %9
  %11 = load i32 addrspace(1)* %10, align 4
  %12 = icmp ugt i32 %5, %findMe
  br i1 %12, label %15, label %13

; <label>:13                                      ; preds = %0
  %14 = icmp ult i32 %11, %findMe
  br i1 %14, label %15, label %16

; <label>:15                                      ; preds = %13, %0
  br label %23

; <label>:16                                      ; preds = %13
  %17 = getelementptr inbounds <4 x i32> addrspace(1)* %outputArray, i32 0
  %18 = load <4 x i32> addrspace(1)* %17, align 16
  %19 = insertelement <4 x i32> %18, i32 %1, i32 0
  store <4 x i32> %19, <4 x i32> addrspace(1)* %17, align 16
  %20 = getelementptr inbounds <4 x i32> addrspace(1)* %outputArray, i32 0
  %21 = load <4 x i32> addrspace(1)* %20, align 16
  %22 = insertelement <4 x i32> %21, i32 1, i32 3
  store <4 x i32> %22, <4 x i32> addrspace(1)* %20, align 16
  br label %23

; <label>:23                                      ; preds = %16, %15
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.z() #1

; Function Attrs: nounwind
define void @binarySearch_mulkeys(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %numKeys, i32 addrspace(1)* %output) #0 {
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = mul nsw i32 %1, 256
  %3 = add nsw i32 %2, 255
  br label %4

; <label>:4                                       ; preds = %21, %0
  %i.0 = phi i32 [ 0, %0 ], [ %22, %21 ]
  %5 = icmp ult i32 %i.0, %numKeys
  br i1 %5, label %6, label %23

; <label>:6                                       ; preds = %4
  %7 = getelementptr inbounds i32 addrspace(1)* %keys, i32 %i.0
  %8 = load i32 addrspace(1)* %7, align 4
  %9 = getelementptr inbounds i32 addrspace(1)* %input, i32 %2
  %10 = load i32 addrspace(1)* %9, align 4
  %11 = icmp uge i32 %8, %10
  br i1 %11, label %12, label %20

; <label>:12                                      ; preds = %6
  %13 = getelementptr inbounds i32 addrspace(1)* %keys, i32 %i.0
  %14 = load i32 addrspace(1)* %13, align 4
  %15 = getelementptr inbounds i32 addrspace(1)* %input, i32 %3
  %16 = load i32 addrspace(1)* %15, align 4
  %17 = icmp ule i32 %14, %16
  br i1 %17, label %18, label %20

; <label>:18                                      ; preds = %12
  %19 = getelementptr inbounds i32 addrspace(1)* %output, i32 %i.0
  store i32 %2, i32 addrspace(1)* %19, align 4
  br label %20

; <label>:20                                      ; preds = %18, %12, %6
  br label %21

; <label>:21                                      ; preds = %20
  %22 = add nsw i32 %i.0, 1
  br label %4

; <label>:23                                      ; preds = %4
  ret void
}

; Function Attrs: nounwind
define void @binarySearch_mulkeysConcurrent(i32 addrspace(1)* %keys, i32 addrspace(1)* %input, i32 %inputSize, i32 %numSubdivisions, i32 addrspace(1)* %output) #0 {
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = urem i32 %1, %numSubdivisions
  %3 = udiv i32 %inputSize, %numSubdivisions
  %4 = mul i32 %2, %3
  %5 = udiv i32 %inputSize, %numSubdivisions
  %6 = add i32 %4, %5
  %7 = call i32 @llvm.r600.read.tgid.x()
  %8 = udiv i32 %7, %numSubdivisions
  %9 = getelementptr inbounds i32 addrspace(1)* %keys, i32 %8
  %10 = load i32 addrspace(1)* %9, align 4
  br label %11

; <label>:11                                      ; preds = %32, %0
  %lBound.0 = phi i32 [ %4, %0 ], [ %lBound.1, %32 ]
  %uBound.0 = phi i32 [ %6, %0 ], [ %uBound.1, %32 ]
  %12 = icmp sge i32 %uBound.0, %lBound.0
  br i1 %12, label %13, label %33

; <label>:13                                      ; preds = %11
  %14 = add nsw i32 %lBound.0, %uBound.0
  %15 = sdiv i32 %14, 2
  %16 = getelementptr inbounds i32 addrspace(1)* %input, i32 %15
  %17 = load i32 addrspace(1)* %16, align 4
  %18 = icmp eq i32 %17, %10
  br i1 %18, label %19, label %23

; <label>:19                                      ; preds = %13
  %20 = call i32 @llvm.r600.read.tgid.x()
  %21 = udiv i32 %20, %numSubdivisions
  %22 = getelementptr inbounds i32 addrspace(1)* %output, i32 %21
  store i32 %15, i32 addrspace(1)* %22, align 4
  br label %33

; <label>:23                                      ; preds = %13
  %24 = getelementptr inbounds i32 addrspace(1)* %input, i32 %15
  %25 = load i32 addrspace(1)* %24, align 4
  %26 = icmp ugt i32 %25, %10
  br i1 %26, label %27, label %29

; <label>:27                                      ; preds = %23
  %28 = sub nsw i32 %15, 1
  br label %31

; <label>:29                                      ; preds = %23
  %30 = add nsw i32 %15, 1
  br label %31

; <label>:31                                      ; preds = %29, %27
  %lBound.1 = phi i32 [ %lBound.0, %27 ], [ %30, %29 ]
  %uBound.1 = phi i32 [ %28, %27 ], [ %uBound.0, %29 ]
  br label %32

; <label>:32                                      ; preds = %31
  br label %11

; <label>:33                                      ; preds = %19, %11
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @binarySearch}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(1)*)* @binarySearch_mulkeys}
!2 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32, i32 addrspace(1)*)* @binarySearch_mulkeysConcurrent}
!3 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

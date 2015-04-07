; ModuleID = 'RadixSort_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram(i32 addrspace(1)* %unsortedData, i32 addrspace(1)* %buckets, i32 %shiftCount, i32 addrspace(3)* %sharedArray) #0 {
  %1 = call i32 @llvm.r600.read.tidig.x()
  %2 = call i32 @llvm.r600.read.tgid.x()
  %3 = call i32 @get_group_id(i32 0)
  %4 = call i32 @llvm.r600.read.local.size.x()
  %5 = call i32 @llvm.r600.read.global.size.x()
  %6 = call i32 @llvm.r600.read.local.size.x()
  %7 = udiv i32 %5, %6
  %8 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %1
  store i32 0, i32 addrspace(3)* %8, align 4
  call void @barrier(i32 1)
  %9 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %2
  %10 = load i32 addrspace(1)* %9, align 4
  %11 = and i32 %shiftCount, 31
  %12 = lshr i32 %10, %11
  %13 = and i32 %12, 255
  %14 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %13
  %15 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* %14, i32 1)
  call void @barrier(i32 1)
  %16 = mul i32 %3, %4
  %17 = add i32 %16, %1
  %18 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %1
  %19 = load i32 addrspace(3)* %18, align 4
  %20 = getelementptr inbounds i32 addrspace(1)* %buckets, i32 %17
  store i32 %19, i32 addrspace(1)* %20, align 4
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tidig.z() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.tgid.z() #1

declare i32 @get_group_id(i32) #2

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.local.size.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.local.size.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.local.size.z() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.global.size.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.global.size.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.r600.read.global.size.z() #1

declare void @barrier(i32) #2

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #2

; Function Attrs: nounwind
define void @permute(i32 addrspace(1)* %unsortedData, i32 addrspace(1)* %scanedBuckets, i32 %shiftCount, i16 addrspace(3)* %sharedBuckets, i32 addrspace(1)* %sortedData) #0 {
  %1 = call i32 @get_group_id(i32 0)
  %2 = call i32 @llvm.r600.read.tidig.x()
  %3 = call i32 @llvm.r600.read.tgid.x()
  %4 = call i32 @llvm.r600.read.local.size.x()
  br label %5

; <label>:5                                       ; preds = %19, %0
  %i.0 = phi i32 [ 0, %0 ], [ %20, %19 ]
  %6 = icmp slt i32 %i.0, 256
  br i1 %6, label %7, label %21

; <label>:7                                       ; preds = %5
  %8 = mul i32 %1, 256
  %9 = mul i32 %8, %4
  %10 = mul i32 %2, 256
  %11 = add i32 %9, %10
  %12 = add i32 %11, %i.0
  %13 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %12
  %14 = load i32 addrspace(1)* %13, align 4
  %15 = trunc i32 %14 to i16
  %16 = mul i32 %2, 256
  %17 = add i32 %16, %i.0
  %18 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %17
  store i16 %15, i16 addrspace(3)* %18, align 2
  br label %19

; <label>:19                                      ; preds = %7
  %20 = add nsw i32 %i.0, 1
  br label %5

; <label>:21                                      ; preds = %5
  call void @barrier(i32 1)
  br label %22

; <label>:22                                      ; preds = %47, %21
  %i1.0 = phi i32 [ 0, %21 ], [ %48, %47 ]
  %23 = icmp slt i32 %i1.0, 256
  br i1 %23, label %24, label %49

; <label>:24                                      ; preds = %22
  %25 = mul i32 %3, 256
  %26 = add i32 %25, %i1.0
  %27 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %26
  %28 = load i32 addrspace(1)* %27, align 4
  %29 = and i32 %shiftCount, 31
  %30 = lshr i32 %28, %29
  %31 = and i32 %30, 255
  %32 = mul i32 %2, 256
  %33 = add i32 %32, %31
  %34 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %33
  %35 = load i16 addrspace(3)* %34, align 2
  %36 = zext i16 %35 to i32
  %37 = mul i32 %3, 256
  %38 = add i32 %37, %i1.0
  %39 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %38
  %40 = load i32 addrspace(1)* %39, align 4
  %41 = getelementptr inbounds i32 addrspace(1)* %sortedData, i32 %36
  store i32 %40, i32 addrspace(1)* %41, align 4
  %42 = add i32 %36, 1
  %43 = trunc i32 %42 to i16
  %44 = mul i32 %2, 256
  %45 = add i32 %44, %31
  %46 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %45
  store i16 %43, i16 addrspace(3)* %46, align 2
  call void @barrier(i32 1)
  br label %47

; <label>:47                                      ; preds = %24
  %48 = add nsw i32 %i1.0, 1
  br label %22

; <label>:49                                      ; preds = %22
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim2(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size, i32 %stride, i32 addrspace(1)* %sumBuffer) #0 {
  %1 = call i32 @llvm.r600.read.tidig.x()
  %2 = call i32 @llvm.r600.read.tidig.y()
  %3 = call i32 @llvm.r600.read.tgid.x()
  %4 = call i32 @llvm.r600.read.tgid.y()
  %5 = call i32 @get_group_id(i32 0)
  %6 = call i32 @get_group_id(i32 1)
  %7 = mul i32 %2, %block_size
  %8 = add i32 %7, %1
  %9 = shl i32 %3, 8
  %10 = add nsw i32 %9, %4
  %11 = call i32 @llvm.r600.read.global.size.x()
  %12 = udiv i32 %11, %block_size
  %13 = mul i32 %6, %12
  %14 = add i32 %13, %5
  %15 = getelementptr inbounds i32 addrspace(1)* %input, i32 %10
  %16 = load i32 addrspace(1)* %15, align 4
  %17 = getelementptr inbounds i32 addrspace(3)* %block, i32 %1
  store i32 %16, i32 addrspace(3)* %17, align 4
  call void @barrier(i32 1)
  %18 = getelementptr inbounds i32 addrspace(3)* %block, i32 0
  %19 = load i32 addrspace(3)* %18, align 4
  br label %20

; <label>:20                                      ; preds = %33, %0
  %cache.0 = phi i32 [ %19, %0 ], [ %cache.1, %33 ]
  %dis.0 = phi i32 [ 1, %0 ], [ %34, %33 ]
  %21 = icmp ult i32 %dis.0, %block_size
  br i1 %21, label %22, label %35

; <label>:22                                      ; preds = %20
  %23 = icmp sge i32 %1, %dis.0
  br i1 %23, label %24, label %31

; <label>:24                                      ; preds = %22
  %25 = sub nsw i32 %1, %dis.0
  %26 = getelementptr inbounds i32 addrspace(3)* %block, i32 %25
  %27 = load i32 addrspace(3)* %26, align 4
  %28 = getelementptr inbounds i32 addrspace(3)* %block, i32 %1
  %29 = load i32 addrspace(3)* %28, align 4
  %30 = add i32 %27, %29
  br label %31

; <label>:31                                      ; preds = %24, %22
  %cache.1 = phi i32 [ %30, %24 ], [ %cache.0, %22 ]
  call void @barrier(i32 1)
  %32 = getelementptr inbounds i32 addrspace(3)* %block, i32 %1
  store i32 %cache.1, i32 addrspace(3)* %32, align 4
  call void @barrier(i32 1)
  br label %33

; <label>:33                                      ; preds = %31
  %34 = mul nsw i32 %dis.0, 2
  br label %20

; <label>:35                                      ; preds = %20
  %36 = sub i32 %block_size, 1
  %37 = getelementptr inbounds i32 addrspace(3)* %block, i32 %36
  %38 = load i32 addrspace(3)* %37, align 4
  %39 = getelementptr inbounds i32 addrspace(1)* %sumBuffer, i32 %14
  store i32 %38, i32 addrspace(1)* %39, align 4
  %40 = icmp eq i32 %1, 0
  br i1 %40, label %41, label %43

; <label>:41                                      ; preds = %35
  %42 = getelementptr inbounds i32 addrspace(1)* %output, i32 %10
  store i32 0, i32 addrspace(1)* %42, align 4
  br label %48

; <label>:43                                      ; preds = %35
  %44 = sub nsw i32 %1, 1
  %45 = getelementptr inbounds i32 addrspace(3)* %block, i32 %44
  %46 = load i32 addrspace(3)* %45, align 4
  %47 = getelementptr inbounds i32 addrspace(1)* %output, i32 %10
  store i32 %46, i32 addrspace(1)* %47, align 4
  br label %48

; <label>:48                                      ; preds = %43, %41
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim1(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(3)* %block, i32 %block_size) #0 {
  %1 = call i32 @llvm.r600.read.tidig.x()
  %2 = call i32 @llvm.r600.read.tgid.x()
  %3 = call i32 @get_group_id(i32 0)
  %4 = getelementptr inbounds i32 addrspace(1)* %input, i32 %2
  %5 = load i32 addrspace(1)* %4, align 4
  %6 = getelementptr inbounds i32 addrspace(3)* %block, i32 %1
  store i32 %5, i32 addrspace(3)* %6, align 4
  %7 = getelementptr inbounds i32 addrspace(3)* %block, i32 0
  %8 = load i32 addrspace(3)* %7, align 4
  br label %9

; <label>:9                                       ; preds = %22, %0
  %cache.0 = phi i32 [ %8, %0 ], [ %cache.1, %22 ]
  %stride.0 = phi i32 [ 1, %0 ], [ %23, %22 ]
  %10 = icmp ult i32 %stride.0, %block_size
  br i1 %10, label %11, label %24

; <label>:11                                      ; preds = %9
  %12 = icmp sge i32 %1, %stride.0
  br i1 %12, label %13, label %20

; <label>:13                                      ; preds = %11
  %14 = sub nsw i32 %1, %stride.0
  %15 = getelementptr inbounds i32 addrspace(3)* %block, i32 %14
  %16 = load i32 addrspace(3)* %15, align 4
  %17 = getelementptr inbounds i32 addrspace(3)* %block, i32 %1
  %18 = load i32 addrspace(3)* %17, align 4
  %19 = add i32 %16, %18
  br label %20

; <label>:20                                      ; preds = %13, %11
  %cache.1 = phi i32 [ %19, %13 ], [ %cache.0, %11 ]
  call void @barrier(i32 1)
  %21 = getelementptr inbounds i32 addrspace(3)* %block, i32 %1
  store i32 %cache.1, i32 addrspace(3)* %21, align 4
  call void @barrier(i32 1)
  br label %22

; <label>:22                                      ; preds = %20
  %23 = mul nsw i32 %stride.0, 2
  br label %9

; <label>:24                                      ; preds = %9
  %25 = icmp eq i32 %1, 0
  br i1 %25, label %26, label %28

; <label>:26                                      ; preds = %24
  %27 = getelementptr inbounds i32 addrspace(1)* %output, i32 %2
  store i32 0, i32 addrspace(1)* %27, align 4
  br label %33

; <label>:28                                      ; preds = %24
  %29 = sub nsw i32 %1, 1
  %30 = getelementptr inbounds i32 addrspace(3)* %block, i32 %29
  %31 = load i32 addrspace(3)* %30, align 4
  %32 = getelementptr inbounds i32 addrspace(1)* %output, i32 %2
  store i32 %31, i32 addrspace(1)* %32, align 4
  br label %33

; <label>:33                                      ; preds = %28, %26
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(i32 addrspace(1)* %output, i32 addrspace(1)* %input, i32 addrspace(1)* %summary, i32 %stride) #0 {
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = call i32 @llvm.r600.read.tgid.y()
  %3 = mul nsw i32 %2, %stride
  %4 = add nsw i32 %3, %1
  %5 = getelementptr inbounds i32 addrspace(1)* %output, i32 %4
  store i32 0, i32 addrspace(1)* %5, align 4
  %6 = icmp sgt i32 %1, 0
  br i1 %6, label %7, label %21

; <label>:7                                       ; preds = %0
  br label %8

; <label>:8                                       ; preds = %18, %7
  %i.0 = phi i32 [ 0, %7 ], [ %19, %18 ]
  %9 = icmp slt i32 %i.0, %1
  br i1 %9, label %10, label %20

; <label>:10                                      ; preds = %8
  %11 = mul nsw i32 %2, %stride
  %12 = add nsw i32 %11, %i.0
  %13 = getelementptr inbounds i32 addrspace(1)* %input, i32 %12
  %14 = load i32 addrspace(1)* %13, align 4
  %15 = getelementptr inbounds i32 addrspace(1)* %output, i32 %4
  %16 = load i32 addrspace(1)* %15, align 4
  %17 = add i32 %16, %14
  store i32 %17, i32 addrspace(1)* %15, align 4
  br label %18

; <label>:18                                      ; preds = %10
  %19 = add nsw i32 %i.0, 1
  br label %8

; <label>:20                                      ; preds = %8
  br label %21

; <label>:21                                      ; preds = %20, %0
  %22 = sub nsw i32 %stride, 1
  %23 = icmp eq i32 %1, %22
  br i1 %23, label %24, label %34

; <label>:24                                      ; preds = %21
  %25 = getelementptr inbounds i32 addrspace(1)* %output, i32 %4
  %26 = load i32 addrspace(1)* %25, align 4
  %27 = mul nsw i32 %2, %stride
  %28 = sub nsw i32 %stride, 1
  %29 = add nsw i32 %27, %28
  %30 = getelementptr inbounds i32 addrspace(1)* %input, i32 %29
  %31 = load i32 addrspace(1)* %30, align 4
  %32 = add i32 %26, %31
  %33 = getelementptr inbounds i32 addrspace(1)* %summary, i32 %2
  store i32 %32, i32 addrspace(1)* %33, align 4
  br label %34

; <label>:34                                      ; preds = %24, %21
  ret void
}

; Function Attrs: nounwind
define void @blockAddition(i32 addrspace(1)* %input, i32 addrspace(1)* %output, i32 %stride) #0 {
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = call i32 @llvm.r600.read.tgid.y()
  %3 = call i32 @get_group_id(i32 0)
  %4 = call i32 @get_group_id(i32 1)
  %5 = shl i32 %1, 8
  %6 = add nsw i32 %2, %5
  %7 = mul i32 %4, %stride
  %8 = add i32 %7, %3
  %9 = getelementptr inbounds i32 addrspace(1)* %input, i32 %8
  %10 = load i32 addrspace(1)* %9, align 4
  %11 = getelementptr inbounds i32 addrspace(1)* %output, i32 %6
  %12 = load i32 addrspace(1)* %11, align 4
  %13 = add i32 %12, %10
  store i32 %13, i32 addrspace(1)* %11, align 4
  ret void
}

; Function Attrs: nounwind
define void @FixOffset(i32 addrspace(1)* %input, i32 addrspace(1)* %output) #0 {
  %1 = call i32 @llvm.r600.read.tgid.x()
  %2 = call i32 @llvm.r600.read.tgid.y()
  %3 = shl i32 %1, 8
  %4 = add nsw i32 %2, %3
  %5 = getelementptr inbounds i32 addrspace(1)* %input, i32 %2
  %6 = load i32 addrspace(1)* %5, align 4
  %7 = getelementptr inbounds i32 addrspace(1)* %output, i32 %4
  %8 = load i32 addrspace(1)* %7, align 4
  %9 = add i32 %8, %6
  store i32 %9, i32 addrspace(1)* %7, align 4
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(3)*)* @histogram}
!1 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i16 addrspace(3)*, i32 addrspace(1)*)* @permute}
!2 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32, i32, i32 addrspace(1)*)* @ScanArraysdim2}
!3 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32)* @ScanArraysdim1}
!4 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*, i32)* @prefixSum}
!5 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @blockAddition}
!6 = metadata !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @FixOffset}
!7 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

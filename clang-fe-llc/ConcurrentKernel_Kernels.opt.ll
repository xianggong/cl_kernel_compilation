; ModuleID = 'ConcurrentKernel_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@K2.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K4.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K6.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K8.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1
@K10.lds = internal addrspace(3) global [8192 x i8] zeroinitializer, align 1

; Function Attrs: nounwind
define void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  %zero = alloca i32, align 4
  %1 = call i32 @get_global_size(i32 0)
  %2 = call i32 @get_global_id(i32 0)
  %3 = call i32 @get_local_id(i32 0)
  store volatile i32 0, i32* %zero, align 4
  br label %4

; <label>:4                                       ; preds = %37, %0
  %tmp.0 = phi i32 [ 1, %0 ], [ %36, %37 ]
  %i.0 = phi i32 [ 1, %0 ], [ %38, %37 ]
  %5 = icmp slt i32 %i.0, 5000
  br i1 %5, label %6, label %39

; <label>:6                                       ; preds = %4
  %7 = mul nsw i32 %i.0, 1
  %8 = urem i32 %7, %bufferSize
  %9 = getelementptr inbounds i8 addrspace(1)* %input, i32 %8
  %10 = load i8 addrspace(1)* %9, align 1
  %11 = zext i8 %10 to i32
  %12 = mul nsw i32 %i.0, 2
  %13 = urem i32 %12, %bufferSize
  %14 = getelementptr inbounds i8 addrspace(1)* %input, i32 %13
  %15 = load i8 addrspace(1)* %14, align 1
  %16 = zext i8 %15 to i32
  %17 = add nsw i32 %11, %16
  %18 = mul nsw i32 %i.0, 3
  %19 = urem i32 %18, %bufferSize
  %20 = getelementptr inbounds i8 addrspace(1)* %input, i32 %19
  %21 = load i8 addrspace(1)* %20, align 1
  %22 = zext i8 %21 to i32
  %23 = add nsw i32 %17, %22
  %24 = mul nsw i32 %i.0, 4
  %25 = urem i32 %24, %bufferSize
  %26 = getelementptr inbounds i8 addrspace(1)* %input, i32 %25
  %27 = load i8 addrspace(1)* %26, align 1
  %28 = zext i8 %27 to i32
  %29 = add nsw i32 %23, %28
  %30 = mul nsw i32 %i.0, 5
  %31 = urem i32 %30, %bufferSize
  %32 = getelementptr inbounds i8 addrspace(1)* %input, i32 %31
  %33 = load i8 addrspace(1)* %32, align 1
  %34 = zext i8 %33 to i32
  %35 = add nsw i32 %29, %34
  %36 = add i32 %tmp.0, %35
  br label %37

; <label>:37                                      ; preds = %6
  %38 = add nsw i32 %i.0, 1
  br label %4

; <label>:39                                      ; preds = %4
  br label %40

; <label>:40                                      ; preds = %53, %39
  %i1.0 = phi i32 [ %2, %39 ], [ %54, %53 ]
  %41 = icmp ult i32 %i1.0, %bufferSize
  br i1 %41, label %42, label %55

; <label>:42                                      ; preds = %40
  %43 = getelementptr inbounds i8 addrspace(1)* %input, i32 %i1.0
  %44 = load i8 addrspace(1)* %43, align 1
  %45 = zext i8 %44 to i32
  %46 = mul nsw i32 %45, %multiplier
  %47 = srem i32 %46, 256
  %48 = load volatile i32* %zero, align 4
  %49 = mul i32 %48, %tmp.0
  %50 = add i32 %47, %49
  %51 = trunc i32 %50 to i8
  %52 = getelementptr inbounds i8 addrspace(1)* %output, i32 %i1.0
  store i8 %51, i8 addrspace(1)* %52, align 1
  br label %53

; <label>:53                                      ; preds = %42
  %54 = add i32 %i1.0, %1
  br label %40

; <label>:55                                      ; preds = %40
  ret void
}

declare i32 @get_global_size(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_local_id(i32) #1

; Function Attrs: nounwind
define void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* %lds) #0 {
  %zero = alloca i32, align 4
  %1 = call i32 @get_global_size(i32 0)
  %2 = call i32 @get_global_id(i32 0)
  %3 = call i32 @get_local_id(i32 0)
  store volatile i32 0, i32* %zero, align 4
  br label %4

; <label>:4                                       ; preds = %37, %0
  %tmp.0 = phi i32 [ 1, %0 ], [ %36, %37 ]
  %i.0 = phi i32 [ 1, %0 ], [ %38, %37 ]
  %5 = icmp slt i32 %i.0, 10000
  br i1 %5, label %6, label %39

; <label>:6                                       ; preds = %4
  %7 = mul nsw i32 %i.0, 2
  %8 = urem i32 %7, %bufferSize
  %9 = getelementptr inbounds i8 addrspace(1)* %input, i32 %8
  %10 = load i8 addrspace(1)* %9, align 1
  %11 = zext i8 %10 to i32
  %12 = mul nsw i32 %i.0, 4
  %13 = urem i32 %12, %bufferSize
  %14 = getelementptr inbounds i8 addrspace(1)* %input, i32 %13
  %15 = load i8 addrspace(1)* %14, align 1
  %16 = zext i8 %15 to i32
  %17 = sub nsw i32 %11, %16
  %18 = mul nsw i32 %i.0, 6
  %19 = urem i32 %18, %bufferSize
  %20 = getelementptr inbounds i8 addrspace(1)* %input, i32 %19
  %21 = load i8 addrspace(1)* %20, align 1
  %22 = zext i8 %21 to i32
  %23 = add nsw i32 %17, %22
  %24 = mul nsw i32 %i.0, 8
  %25 = urem i32 %24, %bufferSize
  %26 = getelementptr inbounds i8 addrspace(1)* %input, i32 %25
  %27 = load i8 addrspace(1)* %26, align 1
  %28 = zext i8 %27 to i32
  %29 = sub nsw i32 %23, %28
  %30 = mul nsw i32 %i.0, 10
  %31 = urem i32 %30, %bufferSize
  %32 = getelementptr inbounds i8 addrspace(1)* %input, i32 %31
  %33 = load i8 addrspace(1)* %32, align 1
  %34 = zext i8 %33 to i32
  %35 = add nsw i32 %29, %34
  %36 = add nsw i32 %tmp.0, %35
  br label %37

; <label>:37                                      ; preds = %6
  %38 = add nsw i32 %i.0, 1
  br label %4

; <label>:39                                      ; preds = %4
  br label %40

; <label>:40                                      ; preds = %56, %39
  %i1.0 = phi i32 [ %2, %39 ], [ %57, %56 ]
  %41 = icmp ult i32 %i1.0, %bufferSize
  br i1 %41, label %42, label %58

; <label>:42                                      ; preds = %40
  %43 = getelementptr inbounds i8 addrspace(1)* %input, i32 %i1.0
  %44 = load i8 addrspace(1)* %43, align 1
  %45 = getelementptr inbounds i8 addrspace(3)* %lds, i32 %3
  store i8 %44, i8 addrspace(3)* %45, align 1
  %46 = getelementptr inbounds i8 addrspace(3)* %lds, i32 %3
  %47 = load i8 addrspace(3)* %46, align 1
  %48 = zext i8 %47 to i32
  %49 = mul nsw i32 %48, %multiplier
  %50 = srem i32 %49, 256
  %51 = load volatile i32* %zero, align 4
  %52 = mul nsw i32 %51, %tmp.0
  %53 = add nsw i32 %50, %52
  %54 = trunc i32 %53 to i8
  %55 = getelementptr inbounds i8 addrspace(1)* %output, i32 %i1.0
  store i8 %54, i8 addrspace(1)* %55, align 1
  br label %56

; <label>:56                                      ; preds = %42
  %57 = add i32 %i1.0, %1
  br label %40

; <label>:58                                      ; preds = %40
  ret void
}

; Function Attrs: nounwind
define void @K1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K2.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K3(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K4(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K4.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K5(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K6(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K6.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K7(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K8(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K8.lds, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind
define void @K9(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  call void @work1(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier)
  ret void
}

; Function Attrs: nounwind
define void @K10(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier) #0 {
  call void @work2(i8 addrspace(1)* %input, i8 addrspace(1)* %output, i32 %bufferSize, i32 %multiplier, i8 addrspace(3)* getelementptr inbounds ([8192 x i8] addrspace(3)* @K10.lds, i32 0, i32 0))
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9}
!llvm.ident = !{!10}

!0 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K1}
!1 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K2}
!2 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K3}
!3 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K4}
!4 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K5}
!5 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K6}
!6 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K7}
!7 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K8}
!8 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K9}
!9 = metadata !{void (i8 addrspace(1)*, i8 addrspace(1)*, i32, i32)* @K10}
!10 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

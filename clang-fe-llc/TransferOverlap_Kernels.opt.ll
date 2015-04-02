; ModuleID = 'TransferOverlap_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@readKernel.lcount = internal addrspace(3) global i32 0, align 4
@writeKernel.lval = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define void @readKernel(<4 x i32> addrspace(1)* %in, i32 addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = call i32 @get_local_id(i32 0)
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  store i32 0, i32 addrspace(3)* @readKernel.lcount, align 4
  br label %4

; <label>:4                                       ; preds = %3, %0
  call void @barrier(i32 1)
  br label %5

; <label>:5                                       ; preds = %45, %4
  %pcount.0 = phi i32 [ 0, %4 ], [ %pcount.1, %45 ]
  %n.0 = phi i32 [ 0, %4 ], [ %46, %45 ]
  %6 = icmp ult i32 %n.0, %nk
  br i1 %6, label %7, label %47

; <label>:7                                       ; preds = %5
  %8 = call i32 @get_global_id(i32 0)
  br label %9

; <label>:9                                       ; preds = %40, %7
  %pcount.1 = phi i32 [ %pcount.0, %7 ], [ %pcount.5, %40 ]
  %i.0 = phi i32 [ 0, %7 ], [ %41, %40 ]
  %idx.0 = phi i32 [ %8, %7 ], [ %43, %40 ]
  %10 = icmp ult i32 %i.0, %ni
  br i1 %10, label %11, label %44

; <label>:11                                      ; preds = %9
  %12 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %13 = load volatile <4 x i32> addrspace(1)* %12, align 16
  %14 = extractelement <4 x i32> %13, i32 0
  %15 = icmp eq i32 %14, %val
  br i1 %15, label %16, label %18

; <label>:16                                      ; preds = %11
  %17 = add i32 %pcount.1, 1
  br label %18

; <label>:18                                      ; preds = %16, %11
  %pcount.2 = phi i32 [ %17, %16 ], [ %pcount.1, %11 ]
  %19 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %20 = load volatile <4 x i32> addrspace(1)* %19, align 16
  %21 = extractelement <4 x i32> %20, i32 1
  %22 = icmp eq i32 %21, %val
  br i1 %22, label %23, label %25

; <label>:23                                      ; preds = %18
  %24 = add i32 %pcount.2, 1
  br label %25

; <label>:25                                      ; preds = %23, %18
  %pcount.3 = phi i32 [ %24, %23 ], [ %pcount.2, %18 ]
  %26 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %27 = load volatile <4 x i32> addrspace(1)* %26, align 16
  %28 = extractelement <4 x i32> %27, i32 2
  %29 = icmp eq i32 %28, %val
  br i1 %29, label %30, label %32

; <label>:30                                      ; preds = %25
  %31 = add i32 %pcount.3, 1
  br label %32

; <label>:32                                      ; preds = %30, %25
  %pcount.4 = phi i32 [ %31, %30 ], [ %pcount.3, %25 ]
  %33 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %34 = load volatile <4 x i32> addrspace(1)* %33, align 16
  %35 = extractelement <4 x i32> %34, i32 3
  %36 = icmp eq i32 %35, %val
  br i1 %36, label %37, label %39

; <label>:37                                      ; preds = %32
  %38 = add i32 %pcount.4, 1
  br label %39

; <label>:39                                      ; preds = %37, %32
  %pcount.5 = phi i32 [ %38, %37 ], [ %pcount.4, %32 ]
  br label %40

; <label>:40                                      ; preds = %39
  %41 = add i32 %i.0, 1
  %42 = call i32 @get_global_size(i32 0)
  %43 = add i32 %idx.0, %42
  br label %9

; <label>:44                                      ; preds = %9
  br label %45

; <label>:45                                      ; preds = %44
  %46 = add nsw i32 %n.0, 1
  br label %5

; <label>:47                                      ; preds = %5
  %48 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @readKernel.lcount, i32 %pcount.0)
  call void @barrier(i32 1)
  %49 = call i32 @get_local_id(i32 0)
  %50 = icmp eq i32 %49, 0
  br i1 %50, label %51, label %56

; <label>:51                                      ; preds = %47
  %52 = load i32 addrspace(3)* @readKernel.lcount, align 4
  %53 = udiv i32 %52, %nk
  %54 = call i32 @get_group_id(i32 0)
  %55 = getelementptr inbounds i32 addrspace(1)* %out, i32 %54
  store volatile i32 %53, i32 addrspace(1)* %55, align 4
  br label %56

; <label>:56                                      ; preds = %51, %47
  %57 = call i32 @get_global_id(i32 0)
  %58 = icmp eq i32 %57, 0
  br i1 %58, label %59, label %63

; <label>:59                                      ; preds = %56
  %60 = call i32 @get_num_groups(i32 0)
  %61 = add i32 %60, 1
  %62 = getelementptr inbounds i32 addrspace(1)* %out, i32 %61
  store volatile i32 %val, i32 addrspace(1)* %62, align 4
  br label %63

; <label>:63                                      ; preds = %59, %56
  ret void
}

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_num_groups(i32) #1

; Function Attrs: nounwind
define void @writeKernel(i32 addrspace(1)* %in, <4 x i32> addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = call i32 @get_local_id(i32 0)
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %8

; <label>:3                                       ; preds = %0
  %4 = call i32 @get_num_groups(i32 0)
  %5 = add i32 %4, 1
  %6 = getelementptr inbounds i32 addrspace(1)* %in, i32 %5
  %7 = load volatile i32 addrspace(1)* %6, align 4
  store i32 %7, i32 addrspace(3)* @writeKernel.lval, align 4
  br label %8

; <label>:8                                       ; preds = %3, %0
  call void @barrier(i32 1)
  %9 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %10 = insertelement <4 x i32> undef, i32 %9, i32 0
  %11 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %12 = insertelement <4 x i32> %10, i32 %11, i32 1
  %13 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %14 = insertelement <4 x i32> %12, i32 %13, i32 2
  %15 = load i32 addrspace(3)* @writeKernel.lval, align 4
  %16 = insertelement <4 x i32> %14, i32 %15, i32 3
  br label %17

; <label>:17                                      ; preds = %30, %8
  %n.0 = phi i32 [ 0, %8 ], [ %31, %30 ]
  %18 = icmp ult i32 %n.0, %nk
  br i1 %18, label %19, label %32

; <label>:19                                      ; preds = %17
  %20 = call i32 @get_global_id(i32 0)
  br label %21

; <label>:21                                      ; preds = %25, %19
  %i.0 = phi i32 [ 0, %19 ], [ %26, %25 ]
  %idx.0 = phi i32 [ %20, %19 ], [ %28, %25 ]
  %22 = icmp ult i32 %i.0, %ni
  br i1 %22, label %23, label %29

; <label>:23                                      ; preds = %21
  %24 = getelementptr inbounds <4 x i32> addrspace(1)* %out, i32 %idx.0
  store volatile <4 x i32> %16, <4 x i32> addrspace(1)* %24, align 16
  br label %25

; <label>:25                                      ; preds = %23
  %26 = add i32 %i.0, 1
  %27 = call i32 @get_global_size(i32 0)
  %28 = add i32 %idx.0, %27
  br label %21

; <label>:29                                      ; preds = %21
  br label %30

; <label>:30                                      ; preds = %29
  %31 = add nsw i32 %n.0, 1
  br label %17

; <label>:32                                      ; preds = %17
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @readKernel}
!1 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @writeKernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

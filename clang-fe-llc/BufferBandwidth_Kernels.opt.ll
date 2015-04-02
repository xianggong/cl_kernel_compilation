; ModuleID = 'BufferBandwidth_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@read_kernel.lcount = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define void @read_kernel(<4 x i32> addrspace(1)* %in, i32 addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = icmp eq i32 %nk, 0
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  br label %59

; <label>:3                                       ; preds = %0
  %4 = call i32 @get_local_id(i32 0)
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %3
  store i32 0, i32 addrspace(3)* @read_kernel.lcount, align 4
  br label %7

; <label>:7                                       ; preds = %6, %3
  call void @barrier(i32 1)
  br label %8

; <label>:8                                       ; preds = %48, %7
  %pcount.0 = phi i32 [ 0, %7 ], [ %pcount.1, %48 ]
  %n.0 = phi i32 [ 0, %7 ], [ %49, %48 ]
  %9 = icmp ult i32 %n.0, %nk
  br i1 %9, label %10, label %50

; <label>:10                                      ; preds = %8
  %11 = call i32 @get_global_id(i32 0)
  br label %12

; <label>:12                                      ; preds = %43, %10
  %pcount.1 = phi i32 [ %pcount.0, %10 ], [ %pcount.5, %43 ]
  %i.0 = phi i32 [ 0, %10 ], [ %44, %43 ]
  %idx.0 = phi i32 [ %11, %10 ], [ %46, %43 ]
  %13 = icmp ult i32 %i.0, %ni
  br i1 %13, label %14, label %47

; <label>:14                                      ; preds = %12
  %15 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %16 = load <4 x i32> addrspace(1)* %15, align 16
  %17 = extractelement <4 x i32> %16, i32 0
  %18 = icmp eq i32 %17, %val
  br i1 %18, label %19, label %21

; <label>:19                                      ; preds = %14
  %20 = add i32 %pcount.1, 1
  br label %21

; <label>:21                                      ; preds = %19, %14
  %pcount.2 = phi i32 [ %20, %19 ], [ %pcount.1, %14 ]
  %22 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %23 = load <4 x i32> addrspace(1)* %22, align 16
  %24 = extractelement <4 x i32> %23, i32 1
  %25 = icmp eq i32 %24, %val
  br i1 %25, label %26, label %28

; <label>:26                                      ; preds = %21
  %27 = add i32 %pcount.2, 1
  br label %28

; <label>:28                                      ; preds = %26, %21
  %pcount.3 = phi i32 [ %27, %26 ], [ %pcount.2, %21 ]
  %29 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %30 = load <4 x i32> addrspace(1)* %29, align 16
  %31 = extractelement <4 x i32> %30, i32 2
  %32 = icmp eq i32 %31, %val
  br i1 %32, label %33, label %35

; <label>:33                                      ; preds = %28
  %34 = add i32 %pcount.3, 1
  br label %35

; <label>:35                                      ; preds = %33, %28
  %pcount.4 = phi i32 [ %34, %33 ], [ %pcount.3, %28 ]
  %36 = getelementptr inbounds <4 x i32> addrspace(1)* %in, i32 %idx.0
  %37 = load <4 x i32> addrspace(1)* %36, align 16
  %38 = extractelement <4 x i32> %37, i32 3
  %39 = icmp eq i32 %38, %val
  br i1 %39, label %40, label %42

; <label>:40                                      ; preds = %35
  %41 = add i32 %pcount.4, 1
  br label %42

; <label>:42                                      ; preds = %40, %35
  %pcount.5 = phi i32 [ %41, %40 ], [ %pcount.4, %35 ]
  br label %43

; <label>:43                                      ; preds = %42
  %44 = add i32 %i.0, 1
  %45 = call i32 @get_global_size(i32 0)
  %46 = add i32 %idx.0, %45
  br label %12

; <label>:47                                      ; preds = %12
  br label %48

; <label>:48                                      ; preds = %47
  %49 = add nsw i32 %n.0, 1
  br label %8

; <label>:50                                      ; preds = %8
  %51 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @read_kernel.lcount, i32 %pcount.0)
  call void @barrier(i32 1)
  %52 = call i32 @get_local_id(i32 0)
  %53 = icmp eq i32 %52, 0
  br i1 %53, label %54, label %59

; <label>:54                                      ; preds = %50
  %55 = load i32 addrspace(3)* @read_kernel.lcount, align 4
  %56 = udiv i32 %55, %nk
  %57 = call i32 @get_group_id(i32 0)
  %58 = getelementptr inbounds i32 addrspace(1)* %out, i32 %57
  store i32 %56, i32 addrspace(1)* %58, align 4
  br label %59

; <label>:59                                      ; preds = %54, %50, %2
  ret void
}

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

declare i32 @get_group_id(i32) #1

; Function Attrs: nounwind
define void @write_kernel(i32 addrspace(1)* %in, <4 x i32> addrspace(1)* %out, i32 %ni, i32 %val, i32 %nk) #0 {
  %1 = icmp eq i32 %nk, 0
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  br label %23

; <label>:3                                       ; preds = %0
  %4 = insertelement <4 x i32> undef, i32 %val, i32 0
  %5 = insertelement <4 x i32> %4, i32 %val, i32 1
  %6 = insertelement <4 x i32> %5, i32 %val, i32 2
  %7 = insertelement <4 x i32> %6, i32 %val, i32 3
  br label %8

; <label>:8                                       ; preds = %21, %3
  %n.0 = phi i32 [ 0, %3 ], [ %22, %21 ]
  %9 = icmp ult i32 %n.0, %nk
  br i1 %9, label %10, label %23

; <label>:10                                      ; preds = %8
  %11 = call i32 @get_global_id(i32 0)
  br label %12

; <label>:12                                      ; preds = %16, %10
  %i.0 = phi i32 [ 0, %10 ], [ %17, %16 ]
  %idx.0 = phi i32 [ %11, %10 ], [ %19, %16 ]
  %13 = icmp ult i32 %i.0, %ni
  br i1 %13, label %14, label %20

; <label>:14                                      ; preds = %12
  %15 = getelementptr inbounds <4 x i32> addrspace(1)* %out, i32 %idx.0
  store <4 x i32> %7, <4 x i32> addrspace(1)* %15, align 16
  br label %16

; <label>:16                                      ; preds = %14
  %17 = add i32 %i.0, 1
  %18 = call i32 @get_global_size(i32 0)
  %19 = add i32 %idx.0, %18
  br label %12

; <label>:20                                      ; preds = %12
  br label %21

; <label>:21                                      ; preds = %20
  %22 = add nsw i32 %n.0, 1
  br label %8

; <label>:23                                      ; preds = %8, %2
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i32 addrspace(1)*, i32, i32, i32)* @read_kernel}
!1 = metadata !{void (i32 addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @write_kernel}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

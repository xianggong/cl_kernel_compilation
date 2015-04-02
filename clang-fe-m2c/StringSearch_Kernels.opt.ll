; ModuleID = 'StringSearch_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

@StringSearchNaive.groupSuccessCounter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack1Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack2Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.groupSuccessCounter = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define i32 @compare(i8 addrspace(1)* %text, i8 addrspace(3)* %pattern, i32 %length) #0 {
  br label %1

; <label>:1                                       ; preds = %31, %0
  %l.0 = phi i32 [ 0, %0 ], [ %32, %31 ]
  %2 = icmp ult i32 %l.0, %length
  br i1 %2, label %3, label %33

; <label>:3                                       ; preds = %1
  %4 = getelementptr inbounds i8 addrspace(1)* %text, i32 %l.0
  %5 = load i8 addrspace(1)* %4, align 1
  %6 = zext i8 %5 to i32
  %7 = icmp sle i32 65, %6
  br i1 %7, label %8, label %19

; <label>:8                                       ; preds = %3
  %9 = getelementptr inbounds i8 addrspace(1)* %text, i32 %l.0
  %10 = load i8 addrspace(1)* %9, align 1
  %11 = zext i8 %10 to i32
  %12 = icmp sle i32 %11, 90
  br i1 %12, label %13, label %19

; <label>:13                                      ; preds = %8
  %14 = getelementptr inbounds i8 addrspace(1)* %text, i32 %l.0
  %15 = load i8 addrspace(1)* %14, align 1
  %16 = zext i8 %15 to i32
  %17 = sub nsw i32 %16, 65
  %18 = add nsw i32 %17, 97
  br label %23

; <label>:19                                      ; preds = %8, %3
  %20 = getelementptr inbounds i8 addrspace(1)* %text, i32 %l.0
  %21 = load i8 addrspace(1)* %20, align 1
  %22 = zext i8 %21 to i32
  br label %23

; <label>:23                                      ; preds = %19, %13
  %24 = phi i32 [ %18, %13 ], [ %22, %19 ]
  %25 = getelementptr inbounds i8 addrspace(3)* %pattern, i32 %l.0
  %26 = load i8 addrspace(3)* %25, align 1
  %27 = zext i8 %26 to i32
  %28 = icmp ne i32 %24, %27
  br i1 %28, label %29, label %30

; <label>:29                                      ; preds = %23
  br label %34

; <label>:30                                      ; preds = %23
  br label %31

; <label>:31                                      ; preds = %30
  %32 = add i32 %l.0, 1
  br label %1

; <label>:33                                      ; preds = %1
  br label %34

; <label>:34                                      ; preds = %33, %29
  %.0 = phi i32 [ 0, %29 ], [ 1, %33 ]
  ret i32 %.0
}

; Function Attrs: nounwind
define void @StringSearchNaive(i8 addrspace(1)* %text, i32 %textLength, i8 addrspace(1)* %pattern, i32 %patternLength, i32 addrspace(1)* %resultBuffer, i32 addrspace(1)* %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* %localPattern) #0 {
  %1 = call i32 @__get_local_id_u32(i32 0)
  %2 = call i32 @__get_local_size_u32(i32 0)
  %3 = call i32 @__get_group_id_u32(i32 0)
  %4 = sub i32 %textLength, %patternLength
  %5 = add i32 %4, 1
  %6 = mul i32 %3, %maxSearchLength
  %7 = add i32 %6, %maxSearchLength
  %8 = icmp ugt i32 %6, %5
  br i1 %8, label %9, label %10

; <label>:9                                       ; preds = %0
  br label %65

; <label>:10                                      ; preds = %0
  %11 = icmp ugt i32 %7, %5
  br i1 %11, label %12, label %13

; <label>:12                                      ; preds = %10
  br label %13

; <label>:13                                      ; preds = %12, %10
  %endSearchIdx.0 = phi i32 [ %5, %12 ], [ %7, %10 ]
  br label %14

; <label>:14                                      ; preds = %40, %13
  %idx.0 = phi i32 [ %1, %13 ], [ %41, %40 ]
  %15 = icmp ult i32 %idx.0, %patternLength
  br i1 %15, label %16, label %42

; <label>:16                                      ; preds = %14
  %17 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %18 = load i8 addrspace(1)* %17, align 1
  %19 = zext i8 %18 to i32
  %20 = icmp sle i32 65, %19
  br i1 %20, label %21, label %32

; <label>:21                                      ; preds = %16
  %22 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %23 = load i8 addrspace(1)* %22, align 1
  %24 = zext i8 %23 to i32
  %25 = icmp sle i32 %24, 90
  br i1 %25, label %26, label %32

; <label>:26                                      ; preds = %21
  %27 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %28 = load i8 addrspace(1)* %27, align 1
  %29 = zext i8 %28 to i32
  %30 = sub nsw i32 %29, 65
  %31 = add nsw i32 %30, 97
  br label %36

; <label>:32                                      ; preds = %21, %16
  %33 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %34 = load i8 addrspace(1)* %33, align 1
  %35 = zext i8 %34 to i32
  br label %36

; <label>:36                                      ; preds = %32, %26
  %37 = phi i32 [ %31, %26 ], [ %35, %32 ]
  %38 = trunc i32 %37 to i8
  %39 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %idx.0
  store i8 %38, i8 addrspace(3)* %39, align 1
  br label %40

; <label>:40                                      ; preds = %36
  %41 = add nsw i32 %idx.0, %2
  br label %14

; <label>:42                                      ; preds = %14
  %43 = icmp eq i32 %1, 0
  br i1 %43, label %44, label %45

; <label>:44                                      ; preds = %42
  store volatile i32 0, i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4
  br label %45

; <label>:45                                      ; preds = %44, %42
  call void @barrier(i32 1)
  %46 = add i32 %6, %1
  br label %47

; <label>:47                                      ; preds = %58, %45
  %stringPos.0 = phi i32 [ %46, %45 ], [ %59, %58 ]
  %48 = icmp ult i32 %stringPos.0, %endSearchIdx.0
  br i1 %48, label %49, label %60

; <label>:49                                      ; preds = %47
  %50 = getelementptr inbounds i8 addrspace(1)* %text, i32 %stringPos.0
  %51 = call i32 @compare(i8 addrspace(1)* %50, i8 addrspace(3)* %localPattern, i32 %patternLength)
  %52 = icmp eq i32 %51, 1
  br i1 %52, label %53, label %57

; <label>:53                                      ; preds = %49
  %54 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, i32 1)
  %55 = add i32 %6, %54
  %56 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i32 %55
  store i32 %stringPos.0, i32 addrspace(1)* %56, align 4
  br label %57

; <label>:57                                      ; preds = %53, %49
  br label %58

; <label>:58                                      ; preds = %57
  %59 = add i32 %stringPos.0, %2
  br label %47

; <label>:60                                      ; preds = %47
  call void @barrier(i32 1)
  %61 = icmp eq i32 %1, 0
  br i1 %61, label %62, label %65

; <label>:62                                      ; preds = %60
  %63 = load volatile i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4
  %64 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i32 %3
  store i32 %63, i32 addrspace(1)* %64, align 4
  br label %65

; <label>:65                                      ; preds = %62, %60, %9
  ret void
}

declare i32 @__get_local_id_u32(i32) #1

declare i32 @__get_local_size_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

; Function Attrs: nounwind
define void @StringSearchLoadBalance(i8 addrspace(1)* %text, i32 %textLength, i8 addrspace(1)* %pattern, i32 %patternLength, i32 addrspace(1)* %resultBuffer, i32 addrspace(1)* %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* %localPattern, i32 addrspace(3)* %stack1) #0 {
  %1 = call i32 @__get_local_id_u32(i32 0)
  %2 = call i32 @__get_local_size_u32(i32 0)
  %3 = call i32 @__get_group_id_u32(i32 0)
  %4 = icmp eq i32 %1, 0
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack2Counter, align 4
  br label %6

; <label>:6                                       ; preds = %5, %0
  %7 = sub i32 %textLength, %patternLength
  %8 = add i32 %7, 1
  %9 = mul i32 %3, %maxSearchLength
  %10 = add i32 %9, %maxSearchLength
  %11 = icmp ugt i32 %9, %8
  br i1 %11, label %12, label %13

; <label>:12                                      ; preds = %6
  br label %163

; <label>:13                                      ; preds = %6
  %14 = icmp ugt i32 %10, %8
  br i1 %14, label %15, label %16

; <label>:15                                      ; preds = %13
  br label %16

; <label>:16                                      ; preds = %15, %13
  %endSearchIdx.0 = phi i32 [ %8, %15 ], [ %10, %13 ]
  %17 = sub i32 %endSearchIdx.0, %9
  br label %18

; <label>:18                                      ; preds = %44, %16
  %idx.0 = phi i32 [ %1, %16 ], [ %45, %44 ]
  %19 = icmp ult i32 %idx.0, %patternLength
  br i1 %19, label %20, label %46

; <label>:20                                      ; preds = %18
  %21 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %22 = load i8 addrspace(1)* %21, align 1
  %23 = zext i8 %22 to i32
  %24 = icmp sle i32 65, %23
  br i1 %24, label %25, label %36

; <label>:25                                      ; preds = %20
  %26 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %27 = load i8 addrspace(1)* %26, align 1
  %28 = zext i8 %27 to i32
  %29 = icmp sle i32 %28, 90
  br i1 %29, label %30, label %36

; <label>:30                                      ; preds = %25
  %31 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %32 = load i8 addrspace(1)* %31, align 1
  %33 = zext i8 %32 to i32
  %34 = sub nsw i32 %33, 65
  %35 = add nsw i32 %34, 97
  br label %40

; <label>:36                                      ; preds = %25, %20
  %37 = getelementptr inbounds i8 addrspace(1)* %pattern, i32 %idx.0
  %38 = load i8 addrspace(1)* %37, align 1
  %39 = zext i8 %38 to i32
  br label %40

; <label>:40                                      ; preds = %36, %30
  %41 = phi i32 [ %35, %30 ], [ %39, %36 ]
  %42 = trunc i32 %41 to i8
  %43 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 %idx.0
  store i8 %42, i8 addrspace(3)* %43, align 1
  br label %44

; <label>:44                                      ; preds = %40
  %45 = add i32 %idx.0, %2
  br label %18

; <label>:46                                      ; preds = %18
  call void @barrier(i32 1)
  %47 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 0
  %48 = load i8 addrspace(3)* %47, align 1
  %49 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 1
  %50 = load i8 addrspace(3)* %49, align 1
  br label %51

; <label>:51                                      ; preds = %157, %125, %46
  %stringPos.0 = phi i32 [ %1, %46 ], [ %118, %125 ], [ %118, %157 ]
  %52 = icmp ult i32 %stringPos.0, %17
  br i1 %52, label %53, label %117

; <label>:53                                      ; preds = %51
  %54 = zext i8 %48 to i32
  %55 = add i32 %9, %stringPos.0
  %56 = getelementptr inbounds i8 addrspace(1)* %text, i32 %55
  %57 = load i8 addrspace(1)* %56, align 1
  %58 = zext i8 %57 to i32
  %59 = icmp sle i32 65, %58
  br i1 %59, label %60, label %73

; <label>:60                                      ; preds = %53
  %61 = add i32 %9, %stringPos.0
  %62 = getelementptr inbounds i8 addrspace(1)* %text, i32 %61
  %63 = load i8 addrspace(1)* %62, align 1
  %64 = zext i8 %63 to i32
  %65 = icmp sle i32 %64, 90
  br i1 %65, label %66, label %73

; <label>:66                                      ; preds = %60
  %67 = add i32 %9, %stringPos.0
  %68 = getelementptr inbounds i8 addrspace(1)* %text, i32 %67
  %69 = load i8 addrspace(1)* %68, align 1
  %70 = zext i8 %69 to i32
  %71 = sub nsw i32 %70, 65
  %72 = add nsw i32 %71, 97
  br label %78

; <label>:73                                      ; preds = %60, %53
  %74 = add i32 %9, %stringPos.0
  %75 = getelementptr inbounds i8 addrspace(1)* %text, i32 %74
  %76 = load i8 addrspace(1)* %75, align 1
  %77 = zext i8 %76 to i32
  br label %78

; <label>:78                                      ; preds = %73, %66
  %79 = phi i32 [ %72, %66 ], [ %77, %73 ]
  %80 = icmp eq i32 %54, %79
  br i1 %80, label %81, label %116

; <label>:81                                      ; preds = %78
  %82 = zext i8 %50 to i32
  %83 = add i32 %9, %stringPos.0
  %84 = add i32 %83, 1
  %85 = getelementptr inbounds i8 addrspace(1)* %text, i32 %84
  %86 = load i8 addrspace(1)* %85, align 1
  %87 = zext i8 %86 to i32
  %88 = icmp sle i32 65, %87
  br i1 %88, label %89, label %104

; <label>:89                                      ; preds = %81
  %90 = add i32 %9, %stringPos.0
  %91 = add i32 %90, 1
  %92 = getelementptr inbounds i8 addrspace(1)* %text, i32 %91
  %93 = load i8 addrspace(1)* %92, align 1
  %94 = zext i8 %93 to i32
  %95 = icmp sle i32 %94, 90
  br i1 %95, label %96, label %104

; <label>:96                                      ; preds = %89
  %97 = add i32 %9, %stringPos.0
  %98 = add i32 %97, 1
  %99 = getelementptr inbounds i8 addrspace(1)* %text, i32 %98
  %100 = load i8 addrspace(1)* %99, align 1
  %101 = zext i8 %100 to i32
  %102 = sub nsw i32 %101, 65
  %103 = add nsw i32 %102, 97
  br label %110

; <label>:104                                     ; preds = %89, %81
  %105 = add i32 %9, %stringPos.0
  %106 = add i32 %105, 1
  %107 = getelementptr inbounds i8 addrspace(1)* %text, i32 %106
  %108 = load i8 addrspace(1)* %107, align 1
  %109 = zext i8 %108 to i32
  br label %110

; <label>:110                                     ; preds = %104, %96
  %111 = phi i32 [ %103, %96 ], [ %109, %104 ]
  %112 = icmp eq i32 %82, %111
  br i1 %112, label %113, label %116

; <label>:113                                     ; preds = %110
  %114 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1)
  %115 = getelementptr inbounds i32 addrspace(3)* %stack1, i32 %114
  store i32 %stringPos.0, i32 addrspace(3)* %115, align 4
  br label %116

; <label>:116                                     ; preds = %113, %110, %78
  br label %117

; <label>:117                                     ; preds = %116, %51
  %118 = add nsw i32 %stringPos.0, %2
  call void @barrier(i32 1)
  %119 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  call void @barrier(i32 1)
  %120 = icmp ult i32 %119, %2
  br i1 %120, label %121, label %126

; <label>:121                                     ; preds = %117
  %122 = sdiv i32 %118, %2
  %123 = mul nsw i32 %122, %2
  %124 = icmp ult i32 %123, %17
  br i1 %124, label %125, label %126

; <label>:125                                     ; preds = %121
  br label %51

; <label>:126                                     ; preds = %121, %117
  %127 = icmp ult i32 %1, %119
  br i1 %127, label %128, label %146

; <label>:128                                     ; preds = %126
  %129 = call i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, i32 1)
  %130 = add nsw i32 %129, -1
  %131 = getelementptr inbounds i32 addrspace(3)* %stack1, i32 %130
  %132 = load i32 addrspace(3)* %131, align 4
  %133 = getelementptr inbounds i8 addrspace(1)* %text, i32 %9
  %134 = getelementptr inbounds i8 addrspace(1)* %133, i32 %132
  %135 = getelementptr inbounds i8 addrspace(1)* %134, i32 2
  %136 = getelementptr inbounds i8 addrspace(3)* %localPattern, i32 2
  %137 = sub i32 %patternLength, 2
  %138 = call i32 @compare(i8 addrspace(1)* %135, i8 addrspace(3)* %136, i32 %137)
  %139 = icmp eq i32 %138, 1
  br i1 %139, label %140, label %145

; <label>:140                                     ; preds = %128
  %141 = call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, i32 1)
  %142 = add i32 %9, %132
  %143 = add i32 %9, %141
  %144 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i32 %143
  store i32 %142, i32 addrspace(1)* %144, align 4
  br label %145

; <label>:145                                     ; preds = %140, %128
  br label %146

; <label>:146                                     ; preds = %145, %126
  call void @barrier(i32 1)
  %147 = sdiv i32 %118, %2
  %148 = mul nsw i32 %147, %2
  %149 = icmp uge i32 %148, %17
  br i1 %149, label %150, label %157

; <label>:150                                     ; preds = %146
  %151 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  %152 = icmp ule i32 %151, 0
  br i1 %152, label %153, label %157

; <label>:153                                     ; preds = %150
  %154 = load i32 addrspace(3)* @StringSearchLoadBalance.stack2Counter, align 4
  %155 = icmp ule i32 %154, 0
  br i1 %155, label %156, label %157

; <label>:156                                     ; preds = %153
  br label %158

; <label>:157                                     ; preds = %153, %150, %146
  br label %51

; <label>:158                                     ; preds = %156
  %159 = icmp eq i32 %1, 0
  br i1 %159, label %160, label %163

; <label>:160                                     ; preds = %158
  %161 = load i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4
  %162 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i32 %3
  store i32 %161, i32 addrspace(1)* %162, align 4
  br label %163

; <label>:163                                     ; preds = %160, %158, %12
  ret void
}

declare i32 @_Z10atomic_subPVU3AS3jj(i32 addrspace(3)*, i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*)* @StringSearchNaive}
!1 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*, i32 addrspace(3)*)* @StringSearchLoadBalance}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

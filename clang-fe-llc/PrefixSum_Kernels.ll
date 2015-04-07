; ModuleID = '../kernel-src/PrefixSum_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @group_prefixSum(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(3)* %block, i32 %length, i32 %idxOffset) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca float addrspace(1)*, align 4
  %3 = alloca float addrspace(3)*, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %localId = alloca i32, align 4
  %localSize = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  %offset = alloca i32, align 4
  %l = alloca i32, align 4
  %ai = alloca i32, align 4
  %bi = alloca i32, align 4
  %maxThread = alloca i32, align 4
  %d = alloca i32, align 4
  %ai1 = alloca i32, align 4
  %bi2 = alloca i32, align 4
  store float addrspace(1)* %output, float addrspace(1)** %1, align 4
  store float addrspace(1)* %input, float addrspace(1)** %2, align 4
  store float addrspace(3)* %block, float addrspace(3)** %3, align 4
  store i32 %length, i32* %4, align 4
  store i32 %idxOffset, i32* %5, align 4
  %6 = call i32 @llvm.r600.read.tidig.x()
  store i32 %6, i32* %localId, align 4
  %7 = call i32 @llvm.r600.read.local.size.x()
  store i32 %7, i32* %localSize, align 4
  %8 = call i32 @get_group_id(i32 0)
  store i32 %8, i32* %globalIdx, align 4
  %9 = load i32* %5, align 4
  %10 = load i32* %globalIdx, align 4
  %11 = load i32* %localSize, align 4
  %12 = mul nsw i32 %10, %11
  %13 = load i32* %localId, align 4
  %14 = add nsw i32 %12, %13
  %15 = mul nsw i32 2, %14
  %16 = add nsw i32 %15, 1
  %17 = mul i32 %9, %16
  %18 = sub i32 %17, 1
  store i32 %18, i32* %globalIdx, align 4
  %19 = load i32* %globalIdx, align 4
  %20 = load i32* %4, align 4
  %21 = icmp ult i32 %19, %20
  br i1 %21, label %22, label %31

; <label>:22                                      ; preds = %0
  %23 = load i32* %globalIdx, align 4
  %24 = load float addrspace(1)** %2, align 4
  %25 = getelementptr inbounds float addrspace(1)* %24, i32 %23
  %26 = load float addrspace(1)* %25, align 4
  %27 = load i32* %localId, align 4
  %28 = mul nsw i32 2, %27
  %29 = load float addrspace(3)** %3, align 4
  %30 = getelementptr inbounds float addrspace(3)* %29, i32 %28
  store float %26, float addrspace(3)* %30, align 4
  br label %31

; <label>:31                                      ; preds = %22, %0
  %32 = load i32* %globalIdx, align 4
  %33 = load i32* %5, align 4
  %34 = add i32 %32, %33
  %35 = load i32* %4, align 4
  %36 = icmp ult i32 %34, %35
  br i1 %36, label %37, label %49

; <label>:37                                      ; preds = %31
  %38 = load i32* %globalIdx, align 4
  %39 = load i32* %5, align 4
  %40 = add i32 %38, %39
  %41 = load float addrspace(1)** %2, align 4
  %42 = getelementptr inbounds float addrspace(1)* %41, i32 %40
  %43 = load float addrspace(1)* %42, align 4
  %44 = load i32* %localId, align 4
  %45 = mul nsw i32 2, %44
  %46 = add nsw i32 %45, 1
  %47 = load float addrspace(3)** %3, align 4
  %48 = getelementptr inbounds float addrspace(3)* %47, i32 %46
  store float %43, float addrspace(3)* %48, align 4
  br label %49

; <label>:49                                      ; preds = %37, %31
  store i32 1, i32* %offset, align 4
  %50 = load i32* %4, align 4
  %51 = lshr i32 %50, 1
  store i32 %51, i32* %l, align 4
  br label %52

; <label>:52                                      ; preds = %84, %49
  %53 = load i32* %l, align 4
  %54 = icmp sgt i32 %53, 0
  br i1 %54, label %55, label %87

; <label>:55                                      ; preds = %52
  call void @barrier(i32 1)
  %56 = load i32* %localId, align 4
  %57 = load i32* %l, align 4
  %58 = icmp slt i32 %56, %57
  br i1 %58, label %59, label %81

; <label>:59                                      ; preds = %55
  %60 = load i32* %offset, align 4
  %61 = load i32* %localId, align 4
  %62 = mul nsw i32 2, %61
  %63 = add nsw i32 %62, 1
  %64 = mul nsw i32 %60, %63
  %65 = sub nsw i32 %64, 1
  store i32 %65, i32* %ai, align 4
  %66 = load i32* %offset, align 4
  %67 = load i32* %localId, align 4
  %68 = mul nsw i32 2, %67
  %69 = add nsw i32 %68, 2
  %70 = mul nsw i32 %66, %69
  %71 = sub nsw i32 %70, 1
  store i32 %71, i32* %bi, align 4
  %72 = load i32* %ai, align 4
  %73 = load float addrspace(3)** %3, align 4
  %74 = getelementptr inbounds float addrspace(3)* %73, i32 %72
  %75 = load float addrspace(3)* %74, align 4
  %76 = load i32* %bi, align 4
  %77 = load float addrspace(3)** %3, align 4
  %78 = getelementptr inbounds float addrspace(3)* %77, i32 %76
  %79 = load float addrspace(3)* %78, align 4
  %80 = fadd float %79, %75
  store float %80, float addrspace(3)* %78, align 4
  br label %81

; <label>:81                                      ; preds = %59, %55
  %82 = load i32* %offset, align 4
  %83 = shl i32 %82, 1
  store i32 %83, i32* %offset, align 4
  br label %84

; <label>:84                                      ; preds = %81
  %85 = load i32* %l, align 4
  %86 = ashr i32 %85, 1
  store i32 %86, i32* %l, align 4
  br label %52

; <label>:87                                      ; preds = %52
  %88 = load i32* %offset, align 4
  %89 = load i32* %4, align 4
  %90 = icmp ult i32 %88, %89
  br i1 %90, label %91, label %94

; <label>:91                                      ; preds = %87
  %92 = load i32* %offset, align 4
  %93 = shl i32 %92, 1
  store i32 %93, i32* %offset, align 4
  br label %94

; <label>:94                                      ; preds = %91, %87
  %95 = load i32* %offset, align 4
  %96 = ashr i32 %95, 1
  store i32 %96, i32* %maxThread, align 4
  store i32 0, i32* %d, align 4
  br label %97

; <label>:97                                      ; preds = %129, %94
  %98 = load i32* %d, align 4
  %99 = load i32* %maxThread, align 4
  %100 = icmp slt i32 %98, %99
  br i1 %100, label %101, label %132

; <label>:101                                     ; preds = %97
  %102 = load i32* %d, align 4
  %103 = add nsw i32 %102, 1
  store i32 %103, i32* %d, align 4
  %104 = load i32* %offset, align 4
  %105 = ashr i32 %104, 1
  store i32 %105, i32* %offset, align 4
  call void @barrier(i32 1)
  %106 = load i32* %localId, align 4
  %107 = load i32* %d, align 4
  %108 = icmp slt i32 %106, %107
  br i1 %108, label %109, label %128

; <label>:109                                     ; preds = %101
  %110 = load i32* %offset, align 4
  %111 = load i32* %localId, align 4
  %112 = add nsw i32 %111, 1
  %113 = mul nsw i32 %110, %112
  %114 = sub nsw i32 %113, 1
  store i32 %114, i32* %ai1, align 4
  %115 = load i32* %ai1, align 4
  %116 = load i32* %offset, align 4
  %117 = ashr i32 %116, 1
  %118 = add nsw i32 %115, %117
  store i32 %118, i32* %bi2, align 4
  %119 = load i32* %ai1, align 4
  %120 = load float addrspace(3)** %3, align 4
  %121 = getelementptr inbounds float addrspace(3)* %120, i32 %119
  %122 = load float addrspace(3)* %121, align 4
  %123 = load i32* %bi2, align 4
  %124 = load float addrspace(3)** %3, align 4
  %125 = getelementptr inbounds float addrspace(3)* %124, i32 %123
  %126 = load float addrspace(3)* %125, align 4
  %127 = fadd float %126, %122
  store float %127, float addrspace(3)* %125, align 4
  br label %128

; <label>:128                                     ; preds = %109, %101
  br label %129

; <label>:129                                     ; preds = %128
  %130 = load i32* %d, align 4
  %131 = shl i32 %130, 1
  store i32 %131, i32* %d, align 4
  br label %97

; <label>:132                                     ; preds = %97
  call void @barrier(i32 1)
  %133 = load i32* %globalIdx, align 4
  %134 = load i32* %4, align 4
  %135 = icmp ult i32 %133, %134
  br i1 %135, label %136, label %145

; <label>:136                                     ; preds = %132
  %137 = load i32* %localId, align 4
  %138 = mul nsw i32 2, %137
  %139 = load float addrspace(3)** %3, align 4
  %140 = getelementptr inbounds float addrspace(3)* %139, i32 %138
  %141 = load float addrspace(3)* %140, align 4
  %142 = load i32* %globalIdx, align 4
  %143 = load float addrspace(1)** %1, align 4
  %144 = getelementptr inbounds float addrspace(1)* %143, i32 %142
  store float %141, float addrspace(1)* %144, align 4
  br label %145

; <label>:145                                     ; preds = %136, %132
  %146 = load i32* %globalIdx, align 4
  %147 = load i32* %5, align 4
  %148 = add i32 %146, %147
  %149 = load i32* %4, align 4
  %150 = icmp ult i32 %148, %149
  br i1 %150, label %151, label %163

; <label>:151                                     ; preds = %145
  %152 = load i32* %localId, align 4
  %153 = mul nsw i32 2, %152
  %154 = add nsw i32 %153, 1
  %155 = load float addrspace(3)** %3, align 4
  %156 = getelementptr inbounds float addrspace(3)* %155, i32 %154
  %157 = load float addrspace(3)* %156, align 4
  %158 = load i32* %globalIdx, align 4
  %159 = load i32* %5, align 4
  %160 = add i32 %158, %159
  %161 = load float addrspace(1)** %1, align 4
  %162 = getelementptr inbounds float addrspace(1)* %161, i32 %160
  store float %157, float addrspace(1)* %162, align 4
  br label %163

; <label>:163                                     ; preds = %151, %145
  ret void
}

declare i32 @llvm.r600.read.tidig.x() #1
declare i32 @llvm.r600.read.tidig.y() #1
declare i32 @llvm.r600.read.tidig.z() #1

declare i32 @llvm.r600.read.local.size.x() #1
declare i32 @llvm.r600.read.local.size.y() #1
declare i32 @llvm.r600.read.local.size.z() #1

declare i32 @get_group_id(i32) #1

declare void @barrier(i32) #1

; Function Attrs: nounwind
define void @global_prefixSum(float addrspace(1)* %buffer, i32 %offset, i32 %length) #0 {
  %1 = alloca float addrspace(1)*, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %localSize = alloca i32, align 4
  %groupIdx = alloca i32, align 4
  %sortedLocalBlocks = alloca i32, align 4
  %gidToUnsortedBlocks = alloca i32, align 4
  %globalIdx = alloca i32, align 4
  store float addrspace(1)* %buffer, float addrspace(1)** %1, align 4
  store i32 %offset, i32* %2, align 4
  store i32 %length, i32* %3, align 4
  %4 = call i32 @llvm.r600.read.local.size.x()
  store i32 %4, i32* %localSize, align 4
  %5 = call i32 @get_group_id(i32 0)
  store i32 %5, i32* %groupIdx, align 4
  %6 = load i32* %2, align 4
  %7 = load i32* %localSize, align 4
  %8 = udiv i32 %6, %7
  store i32 %8, i32* %sortedLocalBlocks, align 4
  %9 = load i32* %groupIdx, align 4
  %10 = load i32* %groupIdx, align 4
  %11 = load i32* %2, align 4
  %12 = shl i32 %11, 1
  %13 = load i32* %sortedLocalBlocks, align 4
  %14 = sub i32 %12, %13
  %15 = udiv i32 %10, %14
  %16 = add i32 %15, 1
  %17 = load i32* %sortedLocalBlocks, align 4
  %18 = mul i32 %16, %17
  %19 = add i32 %9, %18
  store i32 %19, i32* %gidToUnsortedBlocks, align 4
  %20 = load i32* %gidToUnsortedBlocks, align 4
  %21 = load i32* %localSize, align 4
  %22 = mul nsw i32 %20, %21
  %23 = call i32 @llvm.r600.read.tidig.x()
  %24 = add i32 %22, %23
  store i32 %24, i32* %globalIdx, align 4
  %25 = load i32* %globalIdx, align 4
  %26 = add nsw i32 %25, 1
  %27 = load i32* %2, align 4
  %28 = urem i32 %26, %27
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %30, label %49

; <label>:30                                      ; preds = %0
  %31 = load i32* %globalIdx, align 4
  %32 = load i32* %3, align 4
  %33 = icmp ult i32 %31, %32
  br i1 %33, label %34, label %49

; <label>:34                                      ; preds = %30
  %35 = load i32* %globalIdx, align 4
  %36 = load i32* %globalIdx, align 4
  %37 = load i32* %2, align 4
  %38 = urem i32 %36, %37
  %39 = add i32 %38, 1
  %40 = sub i32 %35, %39
  %41 = load float addrspace(1)** %1, align 4
  %42 = getelementptr inbounds float addrspace(1)* %41, i32 %40
  %43 = load float addrspace(1)* %42, align 4
  %44 = load i32* %globalIdx, align 4
  %45 = load float addrspace(1)** %1, align 4
  %46 = getelementptr inbounds float addrspace(1)* %45, i32 %44
  %47 = load float addrspace(1)* %46, align 4
  %48 = fadd float %47, %43
  store float %48, float addrspace(1)* %46, align 4
  br label %49

; <label>:49                                      ; preds = %34, %30, %0
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32)* @group_prefixSum}
!1 = metadata !{void (float addrspace(1)*, i32, i32)* @global_prefixSum}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

; ModuleID = 'DCT_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define i32 @getIdx(i32 %blockIdx, i32 %blockIdy, i32 %localIdx, i32 %localIdy, i32 %blockWidth, i32 %globalWidth) #0 {
  %1 = mul i32 %blockIdx, %blockWidth
  %2 = add i32 %1, %localIdx
  %3 = mul i32 %blockIdy, %blockWidth
  %4 = add i32 %3, %localIdy
  %5 = mul i32 %4, %globalWidth
  %6 = add i32 %5, %2
  ret i32 %6
}

; Function Attrs: nounwind
define void @DCT(float addrspace(1)* %output, float addrspace(1)* %input, float addrspace(1)* %dct8x8, float addrspace(1)* %dct8x8_trans, float addrspace(3)* %inter, i32 %width, i32 %blockWidth, i32 %inverse) #0 {
  %1 = call i32 @__get_global_id_u32(i32 0)
  %2 = call i32 @__get_global_id_u32(i32 1)
  %3 = call i32 @__get_group_id_u32(i32 0)
  %4 = call i32 @__get_group_id_u32(i32 1)
  %5 = call i32 @__get_local_id_u32(i32 0)
  %6 = call i32 @__get_local_id_u32(i32 1)
  %7 = mul i32 %2, %width
  %8 = add i32 %7, %1
  br label %9

; <label>:9                                       ; preds = %31, %0
  %acc.0 = phi float [ 0.000000e+00, %0 ], [ %acc.1, %31 ]
  %k.0 = phi i32 [ 0, %0 ], [ %32, %31 ]
  %10 = icmp ult i32 %k.0, %blockWidth
  br i1 %10, label %11, label %33

; <label>:11                                      ; preds = %9
  %12 = mul i32 %6, %blockWidth
  %13 = add i32 %12, %k.0
  %14 = call i32 @getIdx(i32 %3, i32 %4, i32 %5, i32 %k.0, i32 %blockWidth, i32 %width)
  %15 = icmp ne i32 %inverse, 0
  br i1 %15, label %16, label %23

; <label>:16                                      ; preds = %11
  %17 = getelementptr inbounds float addrspace(1)* %dct8x8, i32 %13
  %18 = load float addrspace(1)* %17, align 4
  %19 = getelementptr inbounds float addrspace(1)* %input, i32 %14
  %20 = load float addrspace(1)* %19, align 4
  %21 = fmul float %18, %20
  %22 = fadd float %acc.0, %21
  br label %30

; <label>:23                                      ; preds = %11
  %24 = getelementptr inbounds float addrspace(1)* %dct8x8_trans, i32 %13
  %25 = load float addrspace(1)* %24, align 4
  %26 = getelementptr inbounds float addrspace(1)* %input, i32 %14
  %27 = load float addrspace(1)* %26, align 4
  %28 = fmul float %25, %27
  %29 = fadd float %acc.0, %28
  br label %30

; <label>:30                                      ; preds = %23, %16
  %acc.1 = phi float [ %22, %16 ], [ %29, %23 ]
  br label %31

; <label>:31                                      ; preds = %30
  %32 = add i32 %k.0, 1
  br label %9

; <label>:33                                      ; preds = %9
  %34 = mul i32 %6, %blockWidth
  %35 = add i32 %34, %5
  %36 = getelementptr inbounds float addrspace(3)* %inter, i32 %35
  store float %acc.0, float addrspace(3)* %36, align 4
  call void @barrier(i32 1)
  br label %37

; <label>:37                                      ; preds = %60, %33
  %acc.2 = phi float [ 0.000000e+00, %33 ], [ %acc.3, %60 ]
  %k1.0 = phi i32 [ 0, %33 ], [ %61, %60 ]
  %38 = icmp ult i32 %k1.0, %blockWidth
  br i1 %38, label %39, label %62

; <label>:39                                      ; preds = %37
  %40 = mul i32 %6, %blockWidth
  %41 = add i32 %40, %k1.0
  %42 = mul i32 %k1.0, %blockWidth
  %43 = add i32 %42, %5
  %44 = icmp ne i32 %inverse, 0
  br i1 %44, label %45, label %52

; <label>:45                                      ; preds = %39
  %46 = getelementptr inbounds float addrspace(3)* %inter, i32 %41
  %47 = load float addrspace(3)* %46, align 4
  %48 = getelementptr inbounds float addrspace(1)* %dct8x8_trans, i32 %43
  %49 = load float addrspace(1)* %48, align 4
  %50 = fmul float %47, %49
  %51 = fadd float %acc.2, %50
  br label %59

; <label>:52                                      ; preds = %39
  %53 = getelementptr inbounds float addrspace(3)* %inter, i32 %41
  %54 = load float addrspace(3)* %53, align 4
  %55 = getelementptr inbounds float addrspace(1)* %dct8x8, i32 %43
  %56 = load float addrspace(1)* %55, align 4
  %57 = fmul float %54, %56
  %58 = fadd float %acc.2, %57
  br label %59

; <label>:59                                      ; preds = %52, %45
  %acc.3 = phi float [ %51, %45 ], [ %58, %52 ]
  br label %60

; <label>:60                                      ; preds = %59
  %61 = add i32 %k1.0, 1
  br label %37

; <label>:62                                      ; preds = %37
  %63 = getelementptr inbounds float addrspace(1)* %output, i32 %8
  store float %acc.2, float addrspace(1)* %63, align 4
  ret void
}

declare i32 @__get_global_id_u32(i32) #1

declare i32 @__get_group_id_u32(i32) #1

declare i32 @__get_local_id_u32(i32) #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32)* @DCT}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

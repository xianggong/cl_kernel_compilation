; ModuleID = 'DwtHaar1D_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @dwtHaar1D(float addrspace(1)* %inSignal, float addrspace(1)* %coefsSignal, float addrspace(1)* %AverageSignal, float addrspace(3)* %sharedArray, i32 %tLevels, i32 %signalLength, i32 %levelsDone, i32 %mLevels) #0 {
  %1 = call i32 @llvm.r600.read.tidig.x()
  %2 = call i32 @get_group_id(i32 0)
  %3 = call i32 @llvm.r600.read.tgid.x()
  %4 = call i32 @llvm.r600.read.local.size.x()
  %5 = mul i32 %2, %4
  %6 = mul i32 %5, 2
  %7 = add i32 %6, %1
  %8 = getelementptr inbounds float addrspace(1)* %inSignal, i32 %7
  %9 = load float addrspace(1)* %8, align 4
  %10 = mul i32 %2, %4
  %11 = mul i32 %10, 2
  %12 = add i32 %11, %4
  %13 = add i32 %12, %1
  %14 = getelementptr inbounds float addrspace(1)* %inSignal, i32 %13
  %15 = load float addrspace(1)* %14, align 4
  %16 = icmp eq i32 0, %levelsDone
  br i1 %16, label %17, label %23

; <label>:17                                      ; preds = %0
  %18 = uitofp i32 %signalLength to float
  %19 = call float @llvm.sqrt.f32(float %18)
  %20 = fdiv float 1.000000e+00, %19, !fpmath !2
  %21 = fmul float %9, %20
  %22 = fmul float %15, %20
  br label %23

; <label>:23                                      ; preds = %17, %0
  %t0.0 = phi float [ %21, %17 ], [ %9, %0 ]
  %t1.0 = phi float [ %22, %17 ], [ %15, %0 ]
  %24 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %1
  store float %t0.0, float addrspace(3)* %24, align 4
  %25 = add i32 %4, %1
  %26 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %25
  store float %t1.0, float addrspace(3)* %26, align 4
  call void @barrier(i32 1)
  %27 = icmp ugt i32 %tLevels, %mLevels
  br i1 %27, label %28, label %29

; <label>:28                                      ; preds = %23
  br label %30

; <label>:29                                      ; preds = %23
  br label %30

; <label>:30                                      ; preds = %29, %28
  %31 = phi i32 [ %mLevels, %28 ], [ %tLevels, %29 ]
  %32 = and i32 %31, 31
  %33 = shl i32 1, %32
  %34 = sdiv i32 %33, 2
  %35 = udiv i32 %signalLength, 2
  %36 = call float @llvm.sqrt.f32(float 2.000000e+00)
  %37 = fdiv float 1.000000e+00, %36, !fpmath !2
  br label %38

; <label>:38                                      ; preds = %65, %30
  %activeThreads.0 = phi i32 [ %34, %30 ], [ %64, %65 ]
  %midOutPos.0 = phi i32 [ %35, %30 ], [ %midOutPos.1, %65 ]
  %i.0 = phi i32 [ 0, %30 ], [ %66, %65 ]
  %data0.0 = phi float [ undef, %30 ], [ %data0.1, %65 ]
  %data1.0 = phi float [ undef, %30 ], [ %data1.1, %65 ]
  %39 = icmp ult i32 %i.0, %31
  br i1 %39, label %40, label %67

; <label>:40                                      ; preds = %38
  %41 = icmp ult i32 %1, %activeThreads.0
  br i1 %41, label %42, label %50

; <label>:42                                      ; preds = %40
  %43 = mul i32 2, %1
  %44 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %43
  %45 = load float addrspace(3)* %44, align 4
  %46 = mul i32 2, %1
  %47 = add i32 %46, 1
  %48 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %47
  %49 = load float addrspace(3)* %48, align 4
  br label %50

; <label>:50                                      ; preds = %42, %40
  %data0.1 = phi float [ %45, %42 ], [ %data0.0, %40 ]
  %data1.1 = phi float [ %49, %42 ], [ %data1.0, %40 ]
  call void @barrier(i32 1)
  %51 = icmp ult i32 %1, %activeThreads.0
  br i1 %51, label %52, label %63

; <label>:52                                      ; preds = %50
  %53 = fadd float %data0.1, %data1.1
  %54 = fmul float %53, %37
  %55 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 %1
  store float %54, float addrspace(3)* %55, align 4
  %56 = mul i32 %2, %activeThreads.0
  %57 = add i32 %midOutPos.0, %56
  %58 = add i32 %57, %1
  %59 = fsub float %data0.1, %data1.1
  %60 = fmul float %59, %37
  %61 = getelementptr inbounds float addrspace(1)* %coefsSignal, i32 %58
  store float %60, float addrspace(1)* %61, align 4
  %62 = lshr i32 %midOutPos.0, 1
  br label %63

; <label>:63                                      ; preds = %52, %50
  %midOutPos.1 = phi i32 [ %62, %52 ], [ %midOutPos.0, %50 ]
  %64 = lshr i32 %activeThreads.0, 1
  call void @barrier(i32 1)
  br label %65

; <label>:65                                      ; preds = %63
  %66 = add i32 %i.0, 1
  br label %38

; <label>:67                                      ; preds = %38
  %68 = icmp eq i32 0, %1
  br i1 %68, label %69, label %73

; <label>:69                                      ; preds = %67
  %70 = getelementptr inbounds float addrspace(3)* %sharedArray, i32 0
  %71 = load float addrspace(3)* %70, align 4
  %72 = getelementptr inbounds float addrspace(1)* %AverageSignal, i32 %2
  store float %71, float addrspace(1)* %72, align 4
  br label %73

; <label>:73                                      ; preds = %69, %67
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

; Function Attrs: nounwind readonly
declare float @llvm.sqrt.f32(float) #3

declare void @barrier(i32) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!opencl.kernels = !{!0}
!llvm.ident = !{!1}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(3)*, i32, i32, i32, i32)* @dwtHaar1D}
!1 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!2 = metadata !{float 2.500000e+00}

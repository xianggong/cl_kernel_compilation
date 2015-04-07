; ModuleID = '../kernel-src/BoxFilterGL_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @box_filter(<4 x i32> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %N) #0 {
  %1 = alloca <4 x i32> addrspace(1)*, align 4
  %2 = alloca <4 x i8> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %k = alloca i32, align 4
  %filterSize = alloca <4 x i32>, align 16
  %posA = alloca <2 x i32>, align 8
  %4 = alloca <2 x i32>, align 8
  %posB = alloca <2 x i32>, align 8
  %5 = alloca <2 x i32>, align 8
  %posC = alloca <2 x i32>, align 8
  %6 = alloca <2 x i32>, align 8
  %posD = alloca <2 x i32>, align 8
  %7 = alloca <2 x i32>, align 8
  %sumA = alloca <4 x i32>, align 16
  %sumB = alloca <4 x i32>, align 16
  %sumC = alloca <4 x i32>, align 16
  %sumD = alloca <4 x i32>, align 16
  store <4 x i32> addrspace(1)* %inputImage, <4 x i32> addrspace(1)** %1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %2, align 4
  store i32 %N, i32* %3, align 4
  %8 = call i32 @llvm.r600.read.tgid.x()
  store i32 %8, i32* %x, align 4
  %9 = call i32 @llvm.r600.read.tgid.y()
  store i32 %9, i32* %y, align 4
  %10 = call i32 @llvm.r600.read.global.size.x()
  store i32 %10, i32* %width, align 4
  %11 = call i32 @llvm.r600.read.global.size.y()
  store i32 %11, i32* %height, align 4
  %12 = load i32* %3, align 4
  %13 = sub nsw i32 %12, 1
  %14 = sdiv i32 %13, 2
  store i32 %14, i32* %k, align 4
  %15 = load i32* %x, align 4
  %16 = load i32* %k, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %36, label %18

; <label>:18                                      ; preds = %0
  %19 = load i32* %y, align 4
  %20 = load i32* %k, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %36, label %22

; <label>:22                                      ; preds = %18
  %23 = load i32* %x, align 4
  %24 = load i32* %width, align 4
  %25 = load i32* %k, align 4
  %26 = sub nsw i32 %24, %25
  %27 = sub nsw i32 %26, 1
  %28 = icmp sgt i32 %23, %27
  br i1 %28, label %36, label %29

; <label>:29                                      ; preds = %22
  %30 = load i32* %y, align 4
  %31 = load i32* %height, align 4
  %32 = load i32* %k, align 4
  %33 = sub nsw i32 %31, %32
  %34 = sub nsw i32 %33, 1
  %35 = icmp sgt i32 %30, %34
  br i1 %35, label %36, label %44

; <label>:36                                      ; preds = %29, %22, %18, %0
  %37 = load i32* %x, align 4
  %38 = load i32* %y, align 4
  %39 = load i32* %width, align 4
  %40 = mul nsw i32 %38, %39
  %41 = add nsw i32 %37, %40
  %42 = load <4 x i8> addrspace(1)** %2, align 4
  %43 = getelementptr inbounds <4 x i8> addrspace(1)* %42, i32 %41
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %43, align 4
  br label %194

; <label>:44                                      ; preds = %29
  %45 = load i32* %3, align 4
  %46 = load i32* %3, align 4
  %47 = mul nsw i32 %45, %46
  %48 = insertelement <4 x i32> undef, i32 %47, i32 0
  %49 = shufflevector <4 x i32> %48, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %49, <4 x i32>* %filterSize, align 16
  %50 = load i32* %x, align 4
  %51 = load i32* %k, align 4
  %52 = sub nsw i32 %50, %51
  %53 = insertelement <2 x i32> undef, i32 %52, i32 0
  %54 = load i32* %y, align 4
  %55 = load i32* %k, align 4
  %56 = sub nsw i32 %54, %55
  %57 = insertelement <2 x i32> %53, i32 %56, i32 1
  store <2 x i32> %57, <2 x i32>* %4
  %58 = load <2 x i32>* %4
  store <2 x i32> %58, <2 x i32>* %posA, align 8
  %59 = load i32* %x, align 4
  %60 = load i32* %k, align 4
  %61 = add nsw i32 %59, %60
  %62 = insertelement <2 x i32> undef, i32 %61, i32 0
  %63 = load i32* %y, align 4
  %64 = load i32* %k, align 4
  %65 = sub nsw i32 %63, %64
  %66 = insertelement <2 x i32> %62, i32 %65, i32 1
  store <2 x i32> %66, <2 x i32>* %5
  %67 = load <2 x i32>* %5
  store <2 x i32> %67, <2 x i32>* %posB, align 8
  %68 = load i32* %x, align 4
  %69 = load i32* %k, align 4
  %70 = add nsw i32 %68, %69
  %71 = insertelement <2 x i32> undef, i32 %70, i32 0
  %72 = load i32* %y, align 4
  %73 = load i32* %k, align 4
  %74 = add nsw i32 %72, %73
  %75 = insertelement <2 x i32> %71, i32 %74, i32 1
  store <2 x i32> %75, <2 x i32>* %6
  %76 = load <2 x i32>* %6
  store <2 x i32> %76, <2 x i32>* %posC, align 8
  %77 = load i32* %x, align 4
  %78 = load i32* %k, align 4
  %79 = sub nsw i32 %77, %78
  %80 = insertelement <2 x i32> undef, i32 %79, i32 0
  %81 = load i32* %y, align 4
  %82 = load i32* %k, align 4
  %83 = add nsw i32 %81, %82
  %84 = insertelement <2 x i32> %80, i32 %83, i32 1
  store <2 x i32> %84, <2 x i32>* %7
  %85 = load <2 x i32>* %7
  store <2 x i32> %85, <2 x i32>* %posD, align 8
  store <4 x i32> zeroinitializer, <4 x i32>* %sumA, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sumB, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sumC, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sumD, align 16
  %86 = load <2 x i32>* %posA, align 8
  %87 = extractelement <2 x i32> %86, i32 0
  %88 = sub nsw i32 %87, 1
  %89 = load <2 x i32>* %posA, align 8
  %90 = insertelement <2 x i32> %89, i32 %88, i32 0
  store <2 x i32> %90, <2 x i32>* %posA, align 8
  %91 = load <2 x i32>* %posA, align 8
  %92 = extractelement <2 x i32> %91, i32 1
  %93 = sub nsw i32 %92, 1
  %94 = load <2 x i32>* %posA, align 8
  %95 = insertelement <2 x i32> %94, i32 %93, i32 1
  store <2 x i32> %95, <2 x i32>* %posA, align 8
  %96 = load <2 x i32>* %posB, align 8
  %97 = extractelement <2 x i32> %96, i32 1
  %98 = sub nsw i32 %97, 1
  %99 = load <2 x i32>* %posB, align 8
  %100 = insertelement <2 x i32> %99, i32 %98, i32 1
  store <2 x i32> %100, <2 x i32>* %posB, align 8
  %101 = load <2 x i32>* %posD, align 8
  %102 = extractelement <2 x i32> %101, i32 0
  %103 = sub nsw i32 %102, 1
  %104 = load <2 x i32>* %posD, align 8
  %105 = insertelement <2 x i32> %104, i32 %103, i32 0
  store <2 x i32> %105, <2 x i32>* %posD, align 8
  %106 = load <2 x i32>* %posA, align 8
  %107 = extractelement <2 x i32> %106, i32 0
  %108 = icmp sge i32 %107, 0
  br i1 %108, label %109, label %125

; <label>:109                                     ; preds = %44
  %110 = load <2 x i32>* %posA, align 8
  %111 = extractelement <2 x i32> %110, i32 1
  %112 = icmp sge i32 %111, 0
  br i1 %112, label %113, label %125

; <label>:113                                     ; preds = %109
  %114 = load <2 x i32>* %posA, align 8
  %115 = extractelement <2 x i32> %114, i32 0
  %116 = load <2 x i32>* %posA, align 8
  %117 = extractelement <2 x i32> %116, i32 1
  %118 = load i32* %width, align 4
  %119 = mul nsw i32 %117, %118
  %120 = add nsw i32 %115, %119
  %121 = load <4 x i32> addrspace(1)** %1, align 4
  %122 = getelementptr inbounds <4 x i32> addrspace(1)* %121, i32 %120
  %123 = load <4 x i32> addrspace(1)* %122, align 16
  %124 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %123)
  store <4 x i32> %124, <4 x i32>* %sumA, align 16
  br label %125

; <label>:125                                     ; preds = %113, %109, %44
  %126 = load <2 x i32>* %posB, align 8
  %127 = extractelement <2 x i32> %126, i32 0
  %128 = icmp sge i32 %127, 0
  br i1 %128, label %129, label %145

; <label>:129                                     ; preds = %125
  %130 = load <2 x i32>* %posB, align 8
  %131 = extractelement <2 x i32> %130, i32 1
  %132 = icmp sge i32 %131, 0
  br i1 %132, label %133, label %145

; <label>:133                                     ; preds = %129
  %134 = load <2 x i32>* %posB, align 8
  %135 = extractelement <2 x i32> %134, i32 0
  %136 = load <2 x i32>* %posB, align 8
  %137 = extractelement <2 x i32> %136, i32 1
  %138 = load i32* %width, align 4
  %139 = mul nsw i32 %137, %138
  %140 = add nsw i32 %135, %139
  %141 = load <4 x i32> addrspace(1)** %1, align 4
  %142 = getelementptr inbounds <4 x i32> addrspace(1)* %141, i32 %140
  %143 = load <4 x i32> addrspace(1)* %142, align 16
  %144 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %143)
  store <4 x i32> %144, <4 x i32>* %sumB, align 16
  br label %145

; <label>:145                                     ; preds = %133, %129, %125
  %146 = load <2 x i32>* %posD, align 8
  %147 = extractelement <2 x i32> %146, i32 0
  %148 = icmp sge i32 %147, 0
  br i1 %148, label %149, label %165

; <label>:149                                     ; preds = %145
  %150 = load <2 x i32>* %posD, align 8
  %151 = extractelement <2 x i32> %150, i32 1
  %152 = icmp sge i32 %151, 0
  br i1 %152, label %153, label %165

; <label>:153                                     ; preds = %149
  %154 = load <2 x i32>* %posD, align 8
  %155 = extractelement <2 x i32> %154, i32 0
  %156 = load <2 x i32>* %posD, align 8
  %157 = extractelement <2 x i32> %156, i32 1
  %158 = load i32* %width, align 4
  %159 = mul nsw i32 %157, %158
  %160 = add nsw i32 %155, %159
  %161 = load <4 x i32> addrspace(1)** %1, align 4
  %162 = getelementptr inbounds <4 x i32> addrspace(1)* %161, i32 %160
  %163 = load <4 x i32> addrspace(1)* %162, align 16
  %164 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %163)
  store <4 x i32> %164, <4 x i32>* %sumD, align 16
  br label %165

; <label>:165                                     ; preds = %153, %149, %145
  %166 = load <2 x i32>* %posC, align 8
  %167 = extractelement <2 x i32> %166, i32 0
  %168 = load <2 x i32>* %posC, align 8
  %169 = extractelement <2 x i32> %168, i32 1
  %170 = load i32* %width, align 4
  %171 = mul nsw i32 %169, %170
  %172 = add nsw i32 %167, %171
  %173 = load <4 x i32> addrspace(1)** %1, align 4
  %174 = getelementptr inbounds <4 x i32> addrspace(1)* %173, i32 %172
  %175 = load <4 x i32> addrspace(1)* %174, align 16
  %176 = call <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32> %175)
  store <4 x i32> %176, <4 x i32>* %sumC, align 16
  %177 = load <4 x i32>* %sumA, align 16
  %178 = load <4 x i32>* %sumC, align 16
  %179 = add <4 x i32> %177, %178
  %180 = load <4 x i32>* %sumB, align 16
  %181 = sub <4 x i32> %179, %180
  %182 = load <4 x i32>* %sumD, align 16
  %183 = sub <4 x i32> %181, %182
  %184 = load <4 x i32>* %filterSize, align 16
  %185 = sdiv <4 x i32> %183, %184
  %186 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %185)
  %187 = load i32* %x, align 4
  %188 = load i32* %y, align 4
  %189 = load i32* %width, align 4
  %190 = mul nsw i32 %188, %189
  %191 = add nsw i32 %187, %190
  %192 = load <4 x i8> addrspace(1)** %2, align 4
  %193 = getelementptr inbounds <4 x i8> addrspace(1)* %192, i32 %191
  store <4 x i8> %186, <4 x i8> addrspace(1)* %193, align 4
  br label %194

; <label>:194                                     ; preds = %165, %36
  ret void
}

declare i32 @llvm.r600.read.tgid.x() #1
declare i32 @llvm.r600.read.tgid.y() #1
declare i32 @llvm.r600.read.tgid.z() #1

declare i32 @llvm.r600.read.global.size.x() #1
declare i32 @llvm.r600.read.global.size.y() #1
declare i32 @llvm.r600.read.global.size.z() #1

declare <4 x i32> @_Z12convert_int4Dv4_j(<4 x i32>) #1

declare <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32>) #1

; Function Attrs: nounwind
define void @horizontalSAT0(<4 x i8> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca <4 x i32> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %pos = alloca i32, align 4
  %c = alloca i32, align 4
  %sum = alloca <4 x i32>, align 16
  %j = alloca i32, align 4
  store <4 x i8> addrspace(1)* %input, <4 x i8> addrspace(1)** %1, align 4
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %2, align 4
  store i32 %i, i32* %3, align 4
  store i32 %r, i32* %4, align 4
  store i32 %width, i32* %5, align 4
  %6 = call i32 @llvm.r600.read.tgid.x()
  store i32 %6, i32* %x, align 4
  %7 = call i32 @llvm.r600.read.tgid.y()
  store i32 %7, i32* %y, align 4
  %8 = load i32* %x, align 4
  %9 = load i32* %y, align 4
  %10 = load i32* %5, align 4
  %11 = mul nsw i32 %9, %10
  %12 = add nsw i32 %8, %11
  store i32 %12, i32* %pos, align 4
  %13 = load i32* %4, align 4
  %14 = sitofp i32 %13 to float
  %15 = load i32* %3, align 4
  %16 = sitofp i32 %15 to float
  %17 = call float @llvm.pow.f32(float %14, float %16)
  %18 = fptosi float %17 to i32
  store i32 %18, i32* %c, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  store i32 0, i32* %j, align 4
  br label %19

; <label>:19                                      ; preds = %47, %0
  %20 = load i32* %j, align 4
  %21 = load i32* %4, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %50

; <label>:23                                      ; preds = %19
  %24 = load i32* %x, align 4
  %25 = load i32* %j, align 4
  %26 = load i32* %c, align 4
  %27 = mul nsw i32 %25, %26
  %28 = sub nsw i32 %24, %27
  %29 = icmp slt i32 %28, 0
  br i1 %29, label %30, label %35

; <label>:30                                      ; preds = %23
  %31 = load <4 x i32>* %sum, align 16
  %32 = load i32* %pos, align 4
  %33 = load <4 x i32> addrspace(1)** %2, align 4
  %34 = getelementptr inbounds <4 x i32> addrspace(1)* %33, i32 %32
  store <4 x i32> %31, <4 x i32> addrspace(1)* %34, align 16
  br label %55

; <label>:35                                      ; preds = %23
  %36 = load i32* %pos, align 4
  %37 = load i32* %j, align 4
  %38 = load i32* %c, align 4
  %39 = mul nsw i32 %37, %38
  %40 = sub nsw i32 %36, %39
  %41 = load <4 x i8> addrspace(1)** %1, align 4
  %42 = getelementptr inbounds <4 x i8> addrspace(1)* %41, i32 %40
  %43 = load <4 x i8> addrspace(1)* %42, align 4
  %44 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %43)
  %45 = load <4 x i32>* %sum, align 16
  %46 = add <4 x i32> %45, %44
  store <4 x i32> %46, <4 x i32>* %sum, align 16
  br label %47

; <label>:47                                      ; preds = %35
  %48 = load i32* %j, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, i32* %j, align 4
  br label %19

; <label>:50                                      ; preds = %19
  %51 = load <4 x i32>* %sum, align 16
  %52 = load i32* %pos, align 4
  %53 = load <4 x i32> addrspace(1)** %2, align 4
  %54 = getelementptr inbounds <4 x i32> addrspace(1)* %53, i32 %52
  store <4 x i32> %51, <4 x i32> addrspace(1)* %54, align 16
  br label %55

; <label>:55                                      ; preds = %50, %30
  ret void
}

; Function Attrs: nounwind readonly
declare float @llvm.pow.f32(float, float) #2

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @horizontalSAT(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = alloca <4 x i32> addrspace(1)*, align 4
  %2 = alloca <4 x i32> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %pos = alloca i32, align 4
  %c = alloca i32, align 4
  %sum = alloca <4 x i32>, align 16
  %j = alloca i32, align 4
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %1, align 4
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %2, align 4
  store i32 %i, i32* %3, align 4
  store i32 %r, i32* %4, align 4
  store i32 %width, i32* %5, align 4
  %6 = call i32 @llvm.r600.read.tgid.x()
  store i32 %6, i32* %x, align 4
  %7 = call i32 @llvm.r600.read.tgid.y()
  store i32 %7, i32* %y, align 4
  %8 = load i32* %x, align 4
  %9 = load i32* %y, align 4
  %10 = load i32* %5, align 4
  %11 = mul nsw i32 %9, %10
  %12 = add nsw i32 %8, %11
  store i32 %12, i32* %pos, align 4
  %13 = load i32* %4, align 4
  %14 = sitofp i32 %13 to float
  %15 = load i32* %3, align 4
  %16 = sitofp i32 %15 to float
  %17 = call float @llvm.pow.f32(float %14, float %16)
  %18 = fptosi float %17 to i32
  store i32 %18, i32* %c, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  store i32 0, i32* %j, align 4
  br label %19

; <label>:19                                      ; preds = %46, %0
  %20 = load i32* %j, align 4
  %21 = load i32* %4, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %49

; <label>:23                                      ; preds = %19
  %24 = load i32* %x, align 4
  %25 = load i32* %j, align 4
  %26 = load i32* %c, align 4
  %27 = mul nsw i32 %25, %26
  %28 = sub nsw i32 %24, %27
  %29 = icmp slt i32 %28, 0
  br i1 %29, label %30, label %35

; <label>:30                                      ; preds = %23
  %31 = load <4 x i32>* %sum, align 16
  %32 = load i32* %pos, align 4
  %33 = load <4 x i32> addrspace(1)** %2, align 4
  %34 = getelementptr inbounds <4 x i32> addrspace(1)* %33, i32 %32
  store <4 x i32> %31, <4 x i32> addrspace(1)* %34, align 16
  br label %54

; <label>:35                                      ; preds = %23
  %36 = load i32* %pos, align 4
  %37 = load i32* %j, align 4
  %38 = load i32* %c, align 4
  %39 = mul nsw i32 %37, %38
  %40 = sub nsw i32 %36, %39
  %41 = load <4 x i32> addrspace(1)** %1, align 4
  %42 = getelementptr inbounds <4 x i32> addrspace(1)* %41, i32 %40
  %43 = load <4 x i32> addrspace(1)* %42, align 16
  %44 = load <4 x i32>* %sum, align 16
  %45 = add <4 x i32> %44, %43
  store <4 x i32> %45, <4 x i32>* %sum, align 16
  br label %46

; <label>:46                                      ; preds = %35
  %47 = load i32* %j, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, i32* %j, align 4
  br label %19

; <label>:49                                      ; preds = %19
  %50 = load <4 x i32>* %sum, align 16
  %51 = load i32* %pos, align 4
  %52 = load <4 x i32> addrspace(1)** %2, align 4
  %53 = getelementptr inbounds <4 x i32> addrspace(1)* %52, i32 %51
  store <4 x i32> %50, <4 x i32> addrspace(1)* %53, align 16
  br label %54

; <label>:54                                      ; preds = %49, %30
  ret void
}

; Function Attrs: nounwind
define void @verticalSAT(<4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)* %output, i32 %i, i32 %r, i32 %width) #0 {
  %1 = alloca <4 x i32> addrspace(1)*, align 4
  %2 = alloca <4 x i32> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %c = alloca i32, align 4
  %sum = alloca <4 x i32>, align 16
  %j = alloca i32, align 4
  store <4 x i32> addrspace(1)* %input, <4 x i32> addrspace(1)** %1, align 4
  store <4 x i32> addrspace(1)* %output, <4 x i32> addrspace(1)** %2, align 4
  store i32 %i, i32* %3, align 4
  store i32 %r, i32* %4, align 4
  store i32 %width, i32* %5, align 4
  %6 = call i32 @llvm.r600.read.tgid.x()
  store i32 %6, i32* %x, align 4
  %7 = call i32 @llvm.r600.read.tgid.y()
  store i32 %7, i32* %y, align 4
  %8 = load i32* %4, align 4
  %9 = sitofp i32 %8 to float
  %10 = load i32* %3, align 4
  %11 = sitofp i32 %10 to float
  %12 = call float @llvm.pow.f32(float %9, float %11)
  %13 = fptosi float %12 to i32
  store i32 %13, i32* %c, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  store i32 0, i32* %j, align 4
  br label %14

; <label>:14                                      ; preds = %49, %0
  %15 = load i32* %j, align 4
  %16 = load i32* %4, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %52

; <label>:18                                      ; preds = %14
  %19 = load i32* %y, align 4
  %20 = load i32* %j, align 4
  %21 = load i32* %c, align 4
  %22 = mul nsw i32 %20, %21
  %23 = sub nsw i32 %19, %22
  %24 = icmp slt i32 %23, 0
  br i1 %24, label %25, label %34

; <label>:25                                      ; preds = %18
  %26 = load <4 x i32>* %sum, align 16
  %27 = load i32* %x, align 4
  %28 = load i32* %y, align 4
  %29 = load i32* %5, align 4
  %30 = mul nsw i32 %28, %29
  %31 = add nsw i32 %27, %30
  %32 = load <4 x i32> addrspace(1)** %2, align 4
  %33 = getelementptr inbounds <4 x i32> addrspace(1)* %32, i32 %31
  store <4 x i32> %26, <4 x i32> addrspace(1)* %33, align 16
  br label %61

; <label>:34                                      ; preds = %18
  %35 = load i32* %x, align 4
  %36 = load i32* %5, align 4
  %37 = load i32* %y, align 4
  %38 = load i32* %j, align 4
  %39 = load i32* %c, align 4
  %40 = mul nsw i32 %38, %39
  %41 = sub nsw i32 %37, %40
  %42 = mul nsw i32 %36, %41
  %43 = add nsw i32 %35, %42
  %44 = load <4 x i32> addrspace(1)** %1, align 4
  %45 = getelementptr inbounds <4 x i32> addrspace(1)* %44, i32 %43
  %46 = load <4 x i32> addrspace(1)* %45, align 16
  %47 = load <4 x i32>* %sum, align 16
  %48 = add <4 x i32> %47, %46
  store <4 x i32> %48, <4 x i32>* %sum, align 16
  br label %49

; <label>:49                                      ; preds = %34
  %50 = load i32* %j, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, i32* %j, align 4
  br label %14

; <label>:52                                      ; preds = %14
  %53 = load <4 x i32>* %sum, align 16
  %54 = load i32* %x, align 4
  %55 = load i32* %y, align 4
  %56 = load i32* %5, align 4
  %57 = mul nsw i32 %55, %56
  %58 = add nsw i32 %54, %57
  %59 = load <4 x i32> addrspace(1)** %2, align 4
  %60 = getelementptr inbounds <4 x i32> addrspace(1)* %59, i32 %58
  store <4 x i32> %53, <4 x i32> addrspace(1)* %60, align 16
  br label %61

; <label>:61                                      ; preds = %52, %25
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca <4 x i8> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %pos = alloca i32, align 4
  %k = alloca i32, align 4
  %size = alloca <4 x i32>, align 16
  %sum = alloca <4 x i32>, align 16
  %X = alloca i32, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %2, align 4
  store i32 %filterWidth, i32* %3, align 4
  %4 = call i32 @llvm.r600.read.tgid.x()
  store i32 %4, i32* %x, align 4
  %5 = call i32 @llvm.r600.read.tgid.y()
  store i32 %5, i32* %y, align 4
  %6 = call i32 @llvm.r600.read.global.size.x()
  store i32 %6, i32* %width, align 4
  %7 = call i32 @llvm.r600.read.global.size.y()
  store i32 %7, i32* %height, align 4
  %8 = load i32* %x, align 4
  %9 = load i32* %y, align 4
  %10 = load i32* %width, align 4
  %11 = mul nsw i32 %9, %10
  %12 = add nsw i32 %8, %11
  store i32 %12, i32* %pos, align 4
  %13 = load i32* %3, align 4
  %14 = sub nsw i32 %13, 1
  %15 = sdiv i32 %14, 2
  store i32 %15, i32* %k, align 4
  %16 = load i32* %x, align 4
  %17 = load i32* %k, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %25, label %19

; <label>:19                                      ; preds = %0
  %20 = load i32* %x, align 4
  %21 = load i32* %width, align 4
  %22 = load i32* %k, align 4
  %23 = sub nsw i32 %21, %22
  %24 = icmp sge i32 %20, %23
  br i1 %24, label %25, label %29

; <label>:25                                      ; preds = %19, %0
  %26 = load i32* %pos, align 4
  %27 = load <4 x i8> addrspace(1)** %2, align 4
  %28 = getelementptr inbounds <4 x i8> addrspace(1)* %27, i32 %26
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %28, align 4
  br label %79

; <label>:29                                      ; preds = %19
  %30 = load i32* %3, align 4
  %31 = insertelement <4 x i32> undef, i32 %30, i32 0
  %32 = shufflevector <4 x i32> %31, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %32, <4 x i32>* %size, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  %33 = load i32* %k, align 4
  %34 = sub nsw i32 0, %33
  store i32 %34, i32* %X, align 4
  br label %35

; <label>:35                                      ; preds = %59, %29
  %36 = load i32* %X, align 4
  %37 = load i32* %k, align 4
  %38 = icmp slt i32 %36, %37
  br i1 %38, label %39, label %62

; <label>:39                                      ; preds = %35
  %40 = load i32* %pos, align 4
  %41 = load i32* %X, align 4
  %42 = add nsw i32 %40, %41
  %43 = load <4 x i8> addrspace(1)** %1, align 4
  %44 = getelementptr inbounds <4 x i8> addrspace(1)* %43, i32 %42
  %45 = load <4 x i8> addrspace(1)* %44, align 4
  %46 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %45)
  %47 = load <4 x i32>* %sum, align 16
  %48 = add <4 x i32> %47, %46
  store <4 x i32> %48, <4 x i32>* %sum, align 16
  %49 = load i32* %pos, align 4
  %50 = load i32* %X, align 4
  %51 = add nsw i32 %49, %50
  %52 = add nsw i32 %51, 1
  %53 = load <4 x i8> addrspace(1)** %1, align 4
  %54 = getelementptr inbounds <4 x i8> addrspace(1)* %53, i32 %52
  %55 = load <4 x i8> addrspace(1)* %54, align 4
  %56 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %55)
  %57 = load <4 x i32>* %sum, align 16
  %58 = add <4 x i32> %57, %56
  store <4 x i32> %58, <4 x i32>* %sum, align 16
  br label %59

; <label>:59                                      ; preds = %39
  %60 = load i32* %X, align 4
  %61 = add nsw i32 %60, 2
  store i32 %61, i32* %X, align 4
  br label %35

; <label>:62                                      ; preds = %35
  %63 = load i32* %pos, align 4
  %64 = load i32* %k, align 4
  %65 = add nsw i32 %63, %64
  %66 = load <4 x i8> addrspace(1)** %1, align 4
  %67 = getelementptr inbounds <4 x i8> addrspace(1)* %66, i32 %65
  %68 = load <4 x i8> addrspace(1)* %67, align 4
  %69 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %68)
  %70 = load <4 x i32>* %sum, align 16
  %71 = add <4 x i32> %70, %69
  store <4 x i32> %71, <4 x i32>* %sum, align 16
  %72 = load <4 x i32>* %sum, align 16
  %73 = load <4 x i32>* %size, align 16
  %74 = sdiv <4 x i32> %72, %73
  %75 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %74)
  %76 = load i32* %pos, align 4
  %77 = load <4 x i8> addrspace(1)** %2, align 4
  %78 = getelementptr inbounds <4 x i8> addrspace(1)* %77, i32 %76
  store <4 x i8> %75, <4 x i8> addrspace(1)* %78, align 4
  br label %79

; <label>:79                                      ; preds = %62, %25
  ret void
}

declare <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @box_filter_vertical(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca <4 x i8> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %pos = alloca i32, align 4
  %k = alloca i32, align 4
  %size = alloca <4 x i32>, align 16
  %sum = alloca <4 x i32>, align 16
  %Y = alloca i32, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %2, align 4
  store i32 %filterWidth, i32* %3, align 4
  %4 = call i32 @llvm.r600.read.tgid.x()
  store i32 %4, i32* %x, align 4
  %5 = call i32 @llvm.r600.read.tgid.y()
  store i32 %5, i32* %y, align 4
  %6 = call i32 @llvm.r600.read.global.size.x()
  store i32 %6, i32* %width, align 4
  %7 = call i32 @llvm.r600.read.global.size.y()
  store i32 %7, i32* %height, align 4
  %8 = load i32* %x, align 4
  %9 = load i32* %y, align 4
  %10 = load i32* %width, align 4
  %11 = mul nsw i32 %9, %10
  %12 = add nsw i32 %8, %11
  store i32 %12, i32* %pos, align 4
  %13 = load i32* %3, align 4
  %14 = sub nsw i32 %13, 1
  %15 = sdiv i32 %14, 2
  store i32 %15, i32* %k, align 4
  %16 = load i32* %y, align 4
  %17 = load i32* %k, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %25, label %19

; <label>:19                                      ; preds = %0
  %20 = load i32* %y, align 4
  %21 = load i32* %height, align 4
  %22 = load i32* %k, align 4
  %23 = sub nsw i32 %21, %22
  %24 = icmp sge i32 %20, %23
  br i1 %24, label %25, label %29

; <label>:25                                      ; preds = %19, %0
  %26 = load i32* %pos, align 4
  %27 = load <4 x i8> addrspace(1)** %2, align 4
  %28 = getelementptr inbounds <4 x i8> addrspace(1)* %27, i32 %26
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(1)* %28, align 4
  br label %85

; <label>:29                                      ; preds = %19
  %30 = load i32* %3, align 4
  %31 = insertelement <4 x i32> undef, i32 %30, i32 0
  %32 = shufflevector <4 x i32> %31, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %32, <4 x i32>* %size, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  %33 = load i32* %k, align 4
  %34 = sub nsw i32 0, %33
  store i32 %34, i32* %Y, align 4
  br label %35

; <label>:35                                      ; preds = %63, %29
  %36 = load i32* %Y, align 4
  %37 = load i32* %k, align 4
  %38 = icmp slt i32 %36, %37
  br i1 %38, label %39, label %66

; <label>:39                                      ; preds = %35
  %40 = load i32* %pos, align 4
  %41 = load i32* %Y, align 4
  %42 = load i32* %width, align 4
  %43 = mul nsw i32 %41, %42
  %44 = add nsw i32 %40, %43
  %45 = load <4 x i8> addrspace(1)** %1, align 4
  %46 = getelementptr inbounds <4 x i8> addrspace(1)* %45, i32 %44
  %47 = load <4 x i8> addrspace(1)* %46, align 4
  %48 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %47)
  %49 = load <4 x i32>* %sum, align 16
  %50 = add <4 x i32> %49, %48
  store <4 x i32> %50, <4 x i32>* %sum, align 16
  %51 = load i32* %pos, align 4
  %52 = load i32* %Y, align 4
  %53 = add nsw i32 %52, 1
  %54 = load i32* %width, align 4
  %55 = mul nsw i32 %53, %54
  %56 = add nsw i32 %51, %55
  %57 = load <4 x i8> addrspace(1)** %1, align 4
  %58 = getelementptr inbounds <4 x i8> addrspace(1)* %57, i32 %56
  %59 = load <4 x i8> addrspace(1)* %58, align 4
  %60 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %59)
  %61 = load <4 x i32>* %sum, align 16
  %62 = add <4 x i32> %61, %60
  store <4 x i32> %62, <4 x i32>* %sum, align 16
  br label %63

; <label>:63                                      ; preds = %39
  %64 = load i32* %Y, align 4
  %65 = add nsw i32 %64, 2
  store i32 %65, i32* %Y, align 4
  br label %35

; <label>:66                                      ; preds = %35
  %67 = load i32* %pos, align 4
  %68 = load i32* %k, align 4
  %69 = load i32* %width, align 4
  %70 = mul nsw i32 %68, %69
  %71 = add nsw i32 %67, %70
  %72 = load <4 x i8> addrspace(1)** %1, align 4
  %73 = getelementptr inbounds <4 x i8> addrspace(1)* %72, i32 %71
  %74 = load <4 x i8> addrspace(1)* %73, align 4
  %75 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %74)
  %76 = load <4 x i32>* %sum, align 16
  %77 = add <4 x i32> %76, %75
  store <4 x i32> %77, <4 x i32>* %sum, align 16
  %78 = load <4 x i32>* %sum, align 16
  %79 = load <4 x i32>* %size, align 16
  %80 = sdiv <4 x i32> %78, %79
  %81 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %80)
  %82 = load i32* %pos, align 4
  %83 = load <4 x i8> addrspace(1)** %2, align 4
  %84 = getelementptr inbounds <4 x i8> addrspace(1)* %83, i32 %82
  store <4 x i8> %81, <4 x i8> addrspace(1)* %84, align 4
  br label %85

; <label>:85                                      ; preds = %66, %25
  ret void
}

; Function Attrs: nounwind
define void @box_filter_horizontal_local(<4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)* %outputImage, i32 %filterWidth, <4 x i8> addrspace(3)* %lds) #0 {
  %1 = alloca <4 x i8> addrspace(1)*, align 4
  %2 = alloca <4 x i8> addrspace(1)*, align 4
  %3 = alloca i32, align 4
  %4 = alloca <4 x i8> addrspace(3)*, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %pos = alloca i32, align 4
  %k = alloca i32, align 4
  %lid = alloca i32, align 4
  %gidX = alloca i32, align 4
  %gidY = alloca i32, align 4
  %gSizeX = alloca i32, align 4
  %gSizeY = alloca i32, align 4
  %firstElement = alloca i32, align 4
  %size = alloca <4 x i32>, align 16
  %sum = alloca <4 x i32>, align 16
  %X = alloca i32, align 4
  store <4 x i8> addrspace(1)* %inputImage, <4 x i8> addrspace(1)** %1, align 4
  store <4 x i8> addrspace(1)* %outputImage, <4 x i8> addrspace(1)** %2, align 4
  store i32 %filterWidth, i32* %3, align 4
  store <4 x i8> addrspace(3)* %lds, <4 x i8> addrspace(3)** %4, align 4
  %5 = call i32 @llvm.r600.read.tgid.x()
  store i32 %5, i32* %x, align 4
  %6 = call i32 @llvm.r600.read.tgid.y()
  store i32 %6, i32* %y, align 4
  %7 = call i32 @llvm.r600.read.global.size.x()
  store i32 %7, i32* %width, align 4
  %8 = call i32 @llvm.r600.read.global.size.y()
  store i32 %8, i32* %height, align 4
  %9 = load i32* %x, align 4
  %10 = load i32* %y, align 4
  %11 = load i32* %width, align 4
  %12 = mul nsw i32 %10, %11
  %13 = add nsw i32 %9, %12
  store i32 %13, i32* %pos, align 4
  %14 = load i32* %3, align 4
  %15 = sub nsw i32 %14, 1
  %16 = sdiv i32 %15, 2
  store i32 %16, i32* %k, align 4
  %17 = call i32 @llvm.r600.read.tidig.x()
  store i32 %17, i32* %lid, align 4
  %18 = call i32 @get_group_id(i32 0)
  store i32 %18, i32* %gidX, align 4
  %19 = call i32 @get_group_id(i32 1)
  store i32 %19, i32* %gidY, align 4
  %20 = call i32 @llvm.r600.read.local.size.x()
  store i32 %20, i32* %gSizeX, align 4
  %21 = call i32 @llvm.r600.read.local.size.y()
  store i32 %21, i32* %gSizeY, align 4
  %22 = load i32* %gSizeX, align 4
  %23 = load i32* %gidX, align 4
  %24 = mul nsw i32 %22, %23
  %25 = load i32* %width, align 4
  %26 = load i32* %gidY, align 4
  %27 = mul nsw i32 %25, %26
  %28 = load i32* %gSizeY, align 4
  %29 = mul nsw i32 %27, %28
  %30 = add nsw i32 %24, %29
  store i32 %30, i32* %firstElement, align 4
  %31 = load i32* %lid, align 4
  %32 = load i32* %k, align 4
  %33 = icmp slt i32 %31, %32
  br i1 %33, label %34, label %59

; <label>:34                                      ; preds = %0
  %35 = load i32* %firstElement, align 4
  %36 = load i32* %k, align 4
  %37 = sub nsw i32 %35, %36
  %38 = load i32* %lid, align 4
  %39 = add nsw i32 %37, %38
  %40 = load <4 x i8> addrspace(1)** %1, align 4
  %41 = getelementptr inbounds <4 x i8> addrspace(1)* %40, i32 %39
  %42 = load <4 x i8> addrspace(1)* %41, align 4
  %43 = load i32* %lid, align 4
  %44 = load <4 x i8> addrspace(3)** %4, align 4
  %45 = getelementptr inbounds <4 x i8> addrspace(3)* %44, i32 %43
  store <4 x i8> %42, <4 x i8> addrspace(3)* %45, align 4
  %46 = load i32* %firstElement, align 4
  %47 = load i32* %lid, align 4
  %48 = add nsw i32 %46, %47
  %49 = add nsw i32 %48, 256
  %50 = load <4 x i8> addrspace(1)** %1, align 4
  %51 = getelementptr inbounds <4 x i8> addrspace(1)* %50, i32 %49
  %52 = load <4 x i8> addrspace(1)* %51, align 4
  %53 = load i32* %k, align 4
  %54 = add nsw i32 256, %53
  %55 = load i32* %lid, align 4
  %56 = add nsw i32 %54, %55
  %57 = load <4 x i8> addrspace(3)** %4, align 4
  %58 = getelementptr inbounds <4 x i8> addrspace(3)* %57, i32 %56
  store <4 x i8> %52, <4 x i8> addrspace(3)* %58, align 4
  br label %59

; <label>:59                                      ; preds = %34, %0
  %60 = load i32* %firstElement, align 4
  %61 = load i32* %lid, align 4
  %62 = add nsw i32 %60, %61
  %63 = load <4 x i8> addrspace(1)** %1, align 4
  %64 = getelementptr inbounds <4 x i8> addrspace(1)* %63, i32 %62
  %65 = load <4 x i8> addrspace(1)* %64, align 4
  %66 = load i32* %lid, align 4
  %67 = load i32* %k, align 4
  %68 = add nsw i32 %66, %67
  %69 = load <4 x i8> addrspace(3)** %4, align 4
  %70 = getelementptr inbounds <4 x i8> addrspace(3)* %69, i32 %68
  store <4 x i8> %65, <4 x i8> addrspace(3)* %70, align 4
  call void @barrier(i32 1)
  %71 = load i32* %x, align 4
  %72 = load i32* %k, align 4
  %73 = icmp slt i32 %71, %72
  br i1 %73, label %80, label %74

; <label>:74                                      ; preds = %59
  %75 = load i32* %x, align 4
  %76 = load i32* %width, align 4
  %77 = load i32* %k, align 4
  %78 = sub nsw i32 %76, %77
  %79 = icmp sge i32 %75, %78
  br i1 %79, label %80, label %81

; <label>:80                                      ; preds = %74, %59
  br label %114

; <label>:81                                      ; preds = %74
  %82 = load i32* %3, align 4
  %83 = insertelement <4 x i32> undef, i32 %82, i32 0
  %84 = shufflevector <4 x i32> %83, <4 x i32> undef, <4 x i32> zeroinitializer
  store <4 x i32> %84, <4 x i32>* %size, align 16
  store <4 x i32> zeroinitializer, <4 x i32>* %sum, align 16
  %85 = load i32* %k, align 4
  %86 = sub nsw i32 0, %85
  store i32 %86, i32* %X, align 4
  br label %87

; <label>:87                                      ; preds = %103, %81
  %88 = load i32* %X, align 4
  %89 = load i32* %k, align 4
  %90 = icmp sle i32 %88, %89
  br i1 %90, label %91, label %106

; <label>:91                                      ; preds = %87
  %92 = load i32* %lid, align 4
  %93 = load i32* %X, align 4
  %94 = add nsw i32 %92, %93
  %95 = load i32* %k, align 4
  %96 = add nsw i32 %94, %95
  %97 = load <4 x i8> addrspace(3)** %4, align 4
  %98 = getelementptr inbounds <4 x i8> addrspace(3)* %97, i32 %96
  %99 = load <4 x i8> addrspace(3)* %98, align 4
  %100 = call <4 x i32> @_Z12convert_int4Dv4_h(<4 x i8> %99)
  %101 = load <4 x i32>* %sum, align 16
  %102 = add <4 x i32> %101, %100
  store <4 x i32> %102, <4 x i32>* %sum, align 16
  br label %103

; <label>:103                                     ; preds = %91
  %104 = load i32* %X, align 4
  %105 = add nsw i32 %104, 1
  store i32 %105, i32* %X, align 4
  br label %87

; <label>:106                                     ; preds = %87
  %107 = load <4 x i32>* %sum, align 16
  %108 = load <4 x i32>* %size, align 16
  %109 = sdiv <4 x i32> %107, %108
  %110 = call <4 x i8> @_Z14convert_uchar4Dv4_i(<4 x i32> %109)
  %111 = load i32* %pos, align 4
  %112 = load <4 x i8> addrspace(1)** %2, align 4
  %113 = getelementptr inbounds <4 x i8> addrspace(1)* %112, i32 %111
  store <4 x i8> %110, <4 x i8> addrspace(1)* %113, align 4
  br label %114

; <label>:114                                     ; preds = %106, %80
  ret void
}

declare i32 @llvm.r600.read.tidig.x() #1
declare i32 @llvm.r600.read.tidig.y() #1
declare i32 @llvm.r600.read.tidig.z() #1

declare i32 @get_group_id(i32) #1

declare i32 @llvm.r600.read.local.size.x() #1
declare i32 @llvm.r600.read.local.size.y() #1
declare i32 @llvm.r600.read.local.size.z() #1

declare void @barrier(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }

!opencl.kernels = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter}
!1 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT0}
!2 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @horizontalSAT}
!3 = metadata !{void (<4 x i32> addrspace(1)*, <4 x i32> addrspace(1)*, i32, i32, i32)* @verticalSAT}
!4 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_horizontal}
!5 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @box_filter_vertical}
!6 = metadata !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32, <4 x i8> addrspace(3)*)* @box_filter_horizontal_local}
!7 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

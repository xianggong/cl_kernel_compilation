; ModuleID = '../kernel-src/Histogram_Kernels.cl'
target datalayout = "e-p:64:64:64-p3:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600--"

; Function Attrs: nounwind
define void @histogram256_vector(<4 x i32> addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
  %1 = alloca <4 x i32> addrspace(1)*, align 4
  %2 = alloca i8 addrspace(3)*, align 4
  %3 = alloca i32 addrspace(1)*, align 4
  %localId = alloca i32, align 4
  %globalId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %offSet1 = alloca i32, align 4
  %offSet2 = alloca i32, align 4
  %offSet3 = alloca i32, align 4
  %input = alloca <4 x i8> addrspace(3)*, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  %value = alloca <4 x i32>, align 16
  %binCount = alloca <4 x i32>, align 16
  %result = alloca i32, align 4
  %binVal = alloca <4 x i8>, align 4
  %binValAsUint = alloca <4 x i32>, align 16
  %i2 = alloca i32, align 4
  %passNumber = alloca i32, align 4
  %j = alloca i32, align 4
  %bankNum = alloca i32, align 4
  store <4 x i32> addrspace(1)* %data, <4 x i32> addrspace(1)** %1, align 4
  store i8 addrspace(3)* %sharedArray, i8 addrspace(3)** %2, align 4
  store i32 addrspace(1)* %binResult, i32 addrspace(1)** %3, align 4
  %4 = call i32 @get_local_id(i32 0)
  store i32 %4, i32* %localId, align 4
  %5 = call i32 @get_global_id(i32 0)
  store i32 %5, i32* %globalId, align 4
  %6 = call i32 @get_group_id(i32 0)
  store i32 %6, i32* %groupId, align 4
  %7 = call i32 @get_local_size(i32 0)
  store i32 %7, i32* %groupSize, align 4
  %8 = load i32* %localId, align 4
  %9 = and i32 %8, 31
  store i32 %9, i32* %offSet1, align 4
  %10 = load i32* %offSet1, align 4
  %11 = mul nsw i32 4, %10
  store i32 %11, i32* %offSet2, align 4
  %12 = load i32* %localId, align 4
  %13 = lshr i32 %12, 5
  store i32 %13, i32* %offSet3, align 4
  %14 = load i8 addrspace(3)** %2, align 4
  %15 = bitcast i8 addrspace(3)* %14 to <4 x i8> addrspace(3)*
  store <4 x i8> addrspace(3)* %15, <4 x i8> addrspace(3)** %input, align 4
  store i32 0, i32* %i, align 4
  br label %16

; <label>:16                                      ; preds = %27, %0
  %17 = load i32* %i, align 4
  %18 = icmp slt i32 %17, 64
  br i1 %18, label %19, label %30

; <label>:19                                      ; preds = %16
  %20 = load i32* %groupSize, align 4
  %21 = load i32* %i, align 4
  %22 = mul i32 %20, %21
  %23 = load i32* %localId, align 4
  %24 = add i32 %22, %23
  %25 = load <4 x i8> addrspace(3)** %input, align 4
  %26 = getelementptr inbounds <4 x i8> addrspace(3)* %25, i32 %24
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %26, align 4
  br label %27

; <label>:27                                      ; preds = %19
  %28 = load i32* %i, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* %i, align 4
  br label %16

; <label>:30                                      ; preds = %16
  call void @barrier(i32 1)
  store i32 0, i32* %i1, align 4
  br label %31

; <label>:31                                      ; preds = %93, %30
  %32 = load i32* %i1, align 4
  %33 = icmp slt i32 %32, 32
  br i1 %33, label %34, label %96

; <label>:34                                      ; preds = %31
  %35 = load i32* %groupId, align 4
  %36 = load i32* %groupSize, align 4
  %37 = mul i32 %36, 256
  %38 = udiv i32 %37, 8
  %39 = mul i32 %35, %38
  %40 = load i32* %i1, align 4
  %41 = load i32* %groupSize, align 4
  %42 = mul i32 %40, %41
  %43 = add i32 %39, %42
  %44 = load i32* %localId, align 4
  %45 = add i32 %43, %44
  %46 = load <4 x i32> addrspace(1)** %1, align 4
  %47 = getelementptr inbounds <4 x i32> addrspace(1)* %46, i32 %45
  %48 = load <4 x i32> addrspace(1)* %47, align 16
  store <4 x i32> %48, <4 x i32>* %value, align 16
  %49 = load <4 x i32>* %value, align 16
  %50 = extractelement <4 x i32> %49, i32 0
  %51 = mul i32 %50, 128
  %52 = load i32* %offSet2, align 4
  %53 = add i32 %51, %52
  %54 = load i32* %offSet3, align 4
  %55 = add i32 %53, %54
  %56 = load i8 addrspace(3)** %2, align 4
  %57 = getelementptr inbounds i8 addrspace(3)* %56, i32 %55
  %58 = load i8 addrspace(3)* %57, align 1
  %59 = add i8 %58, 1
  store i8 %59, i8 addrspace(3)* %57, align 1
  %60 = load <4 x i32>* %value, align 16
  %61 = extractelement <4 x i32> %60, i32 1
  %62 = mul i32 %61, 128
  %63 = load i32* %offSet2, align 4
  %64 = add i32 %62, %63
  %65 = load i32* %offSet3, align 4
  %66 = add i32 %64, %65
  %67 = load i8 addrspace(3)** %2, align 4
  %68 = getelementptr inbounds i8 addrspace(3)* %67, i32 %66
  %69 = load i8 addrspace(3)* %68, align 1
  %70 = add i8 %69, 1
  store i8 %70, i8 addrspace(3)* %68, align 1
  %71 = load <4 x i32>* %value, align 16
  %72 = extractelement <4 x i32> %71, i32 2
  %73 = mul i32 %72, 128
  %74 = load i32* %offSet2, align 4
  %75 = add i32 %73, %74
  %76 = load i32* %offSet3, align 4
  %77 = add i32 %75, %76
  %78 = load i8 addrspace(3)** %2, align 4
  %79 = getelementptr inbounds i8 addrspace(3)* %78, i32 %77
  %80 = load i8 addrspace(3)* %79, align 1
  %81 = add i8 %80, 1
  store i8 %81, i8 addrspace(3)* %79, align 1
  %82 = load <4 x i32>* %value, align 16
  %83 = extractelement <4 x i32> %82, i32 3
  %84 = mul i32 %83, 128
  %85 = load i32* %offSet2, align 4
  %86 = add i32 %84, %85
  %87 = load i32* %offSet3, align 4
  %88 = add i32 %86, %87
  %89 = load i8 addrspace(3)** %2, align 4
  %90 = getelementptr inbounds i8 addrspace(3)* %89, i32 %88
  %91 = load i8 addrspace(3)* %90, align 1
  %92 = add i8 %91, 1
  store i8 %92, i8 addrspace(3)* %90, align 1
  br label %93

; <label>:93                                      ; preds = %34
  %94 = load i32* %i1, align 4
  %95 = add nsw i32 %94, 1
  store i32 %95, i32* %i1, align 4
  br label %31

; <label>:96                                      ; preds = %31
  call void @barrier(i32 1)
  store i32 0, i32* %i2, align 4
  br label %97

; <label>:97                                      ; preds = %153, %96
  %98 = load i32* %i2, align 4
  %99 = load i32* %groupSize, align 4
  %100 = udiv i32 256, %99
  %101 = icmp ult i32 %98, %100
  br i1 %101, label %102, label %156

; <label>:102                                     ; preds = %97
  %103 = load i32* %i2, align 4
  %104 = mul nsw i32 4096, %103
  %105 = load i32* %localId, align 4
  %106 = mul i32 %105, 32
  %107 = add i32 %104, %106
  store i32 %107, i32* %passNumber, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %binCount, align 16
  store i32 0, i32* %result, align 4
  store i32 0, i32* %j, align 4
  br label %108

; <label>:108                                     ; preds = %127, %102
  %109 = load i32* %j, align 4
  %110 = icmp slt i32 %109, 32
  br i1 %110, label %111, label %130

; <label>:111                                     ; preds = %108
  %112 = load i32* %j, align 4
  %113 = load i32* %offSet1, align 4
  %114 = add nsw i32 %112, %113
  %115 = and i32 %114, 31
  store i32 %115, i32* %bankNum, align 4
  %116 = load i32* %passNumber, align 4
  %117 = load i32* %bankNum, align 4
  %118 = add nsw i32 %116, %117
  %119 = load <4 x i8> addrspace(3)** %input, align 4
  %120 = getelementptr inbounds <4 x i8> addrspace(3)* %119, i32 %118
  %121 = load <4 x i8> addrspace(3)* %120, align 4
  store <4 x i8> %121, <4 x i8>* %binVal, align 4
  %122 = load <4 x i8>* %binVal, align 4
  %123 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %122)
  store <4 x i32> %123, <4 x i32>* %binValAsUint, align 16
  %124 = load <4 x i32>* %binValAsUint, align 16
  %125 = load <4 x i32>* %binCount, align 16
  %126 = add <4 x i32> %125, %124
  store <4 x i32> %126, <4 x i32>* %binCount, align 16
  br label %127

; <label>:127                                     ; preds = %111
  %128 = load i32* %j, align 4
  %129 = add nsw i32 %128, 1
  store i32 %129, i32* %j, align 4
  br label %108

; <label>:130                                     ; preds = %108
  %131 = load <4 x i32>* %binCount, align 16
  %132 = extractelement <4 x i32> %131, i32 0
  %133 = load <4 x i32>* %binCount, align 16
  %134 = extractelement <4 x i32> %133, i32 1
  %135 = add i32 %132, %134
  %136 = load <4 x i32>* %binCount, align 16
  %137 = extractelement <4 x i32> %136, i32 2
  %138 = add i32 %135, %137
  %139 = load <4 x i32>* %binCount, align 16
  %140 = extractelement <4 x i32> %139, i32 3
  %141 = add i32 %138, %140
  store i32 %141, i32* %result, align 4
  %142 = load i32* %result, align 4
  %143 = load i32* %groupId, align 4
  %144 = mul i32 %143, 256
  %145 = load i32* %groupSize, align 4
  %146 = load i32* %i2, align 4
  %147 = mul i32 %145, %146
  %148 = add i32 %144, %147
  %149 = load i32* %localId, align 4
  %150 = add i32 %148, %149
  %151 = load i32 addrspace(1)** %3, align 4
  %152 = getelementptr inbounds i32 addrspace(1)* %151, i32 %150
  store i32 %142, i32 addrspace(1)* %152, align 4
  br label %153

; <label>:153                                     ; preds = %130
  %154 = load i32* %i2, align 4
  %155 = add nsw i32 %154, 1
  store i32 %155, i32* %i2, align 4
  br label %97

; <label>:156                                     ; preds = %97
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @histogram256_scalar(i32 addrspace(1)* %data, i8 addrspace(3)* %sharedArray, i32 addrspace(1)* %binResult) #0 {
  %1 = alloca i32 addrspace(1)*, align 4
  %2 = alloca i8 addrspace(3)*, align 4
  %3 = alloca i32 addrspace(1)*, align 4
  %localId = alloca i32, align 4
  %globalId = alloca i32, align 4
  %groupId = alloca i32, align 4
  %groupSize = alloca i32, align 4
  %offSet1 = alloca i32, align 4
  %offSet2 = alloca i32, align 4
  %offSet3 = alloca i32, align 4
  %input = alloca <4 x i8> addrspace(3)*, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  %value = alloca i32, align 4
  %binCount = alloca <4 x i32>, align 16
  %result = alloca i32, align 4
  %binVal = alloca <4 x i8>, align 4
  %binValAsUint = alloca <4 x i32>, align 16
  %i2 = alloca i32, align 4
  %passNumber = alloca i32, align 4
  %j = alloca i32, align 4
  %bankNum = alloca i32, align 4
  store i32 addrspace(1)* %data, i32 addrspace(1)** %1, align 4
  store i8 addrspace(3)* %sharedArray, i8 addrspace(3)** %2, align 4
  store i32 addrspace(1)* %binResult, i32 addrspace(1)** %3, align 4
  %4 = call i32 @get_local_id(i32 0)
  store i32 %4, i32* %localId, align 4
  %5 = call i32 @get_global_id(i32 0)
  store i32 %5, i32* %globalId, align 4
  %6 = call i32 @get_group_id(i32 0)
  store i32 %6, i32* %groupId, align 4
  %7 = call i32 @get_local_size(i32 0)
  store i32 %7, i32* %groupSize, align 4
  %8 = load i32* %localId, align 4
  %9 = and i32 %8, 31
  store i32 %9, i32* %offSet1, align 4
  %10 = load i32* %offSet1, align 4
  %11 = mul nsw i32 4, %10
  store i32 %11, i32* %offSet2, align 4
  %12 = load i32* %localId, align 4
  %13 = lshr i32 %12, 5
  store i32 %13, i32* %offSet3, align 4
  %14 = load i8 addrspace(3)** %2, align 4
  %15 = bitcast i8 addrspace(3)* %14 to <4 x i8> addrspace(3)*
  store <4 x i8> addrspace(3)* %15, <4 x i8> addrspace(3)** %input, align 4
  store i32 0, i32* %i, align 4
  br label %16

; <label>:16                                      ; preds = %27, %0
  %17 = load i32* %i, align 4
  %18 = icmp slt i32 %17, 64
  br i1 %18, label %19, label %30

; <label>:19                                      ; preds = %16
  %20 = load i32* %groupSize, align 4
  %21 = load i32* %i, align 4
  %22 = mul i32 %20, %21
  %23 = load i32* %localId, align 4
  %24 = add i32 %22, %23
  %25 = load <4 x i8> addrspace(3)** %input, align 4
  %26 = getelementptr inbounds <4 x i8> addrspace(3)* %25, i32 %24
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %26, align 4
  br label %27

; <label>:27                                      ; preds = %19
  %28 = load i32* %i, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* %i, align 4
  br label %16

; <label>:30                                      ; preds = %16
  call void @barrier(i32 1)
  store i32 0, i32* %i1, align 4
  br label %31

; <label>:31                                      ; preds = %58, %30
  %32 = load i32* %i1, align 4
  %33 = icmp slt i32 %32, 128
  br i1 %33, label %34, label %61

; <label>:34                                      ; preds = %31
  %35 = load i32* %groupId, align 4
  %36 = load i32* %groupSize, align 4
  %37 = mul i32 %36, 128
  %38 = mul i32 %35, %37
  %39 = load i32* %i1, align 4
  %40 = load i32* %groupSize, align 4
  %41 = mul i32 %39, %40
  %42 = add i32 %38, %41
  %43 = load i32* %localId, align 4
  %44 = add i32 %42, %43
  %45 = load i32 addrspace(1)** %1, align 4
  %46 = getelementptr inbounds i32 addrspace(1)* %45, i32 %44
  %47 = load i32 addrspace(1)* %46, align 4
  store i32 %47, i32* %value, align 4
  %48 = load i32* %value, align 4
  %49 = mul i32 %48, 128
  %50 = load i32* %offSet2, align 4
  %51 = add i32 %49, %50
  %52 = load i32* %offSet3, align 4
  %53 = add i32 %51, %52
  %54 = load i8 addrspace(3)** %2, align 4
  %55 = getelementptr inbounds i8 addrspace(3)* %54, i32 %53
  %56 = load i8 addrspace(3)* %55, align 1
  %57 = add i8 %56, 1
  store i8 %57, i8 addrspace(3)* %55, align 1
  br label %58

; <label>:58                                      ; preds = %34
  %59 = load i32* %i1, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, i32* %i1, align 4
  br label %31

; <label>:61                                      ; preds = %31
  call void @barrier(i32 1)
  store i32 0, i32* %i2, align 4
  br label %62

; <label>:62                                      ; preds = %118, %61
  %63 = load i32* %i2, align 4
  %64 = load i32* %groupSize, align 4
  %65 = udiv i32 256, %64
  %66 = icmp ult i32 %63, %65
  br i1 %66, label %67, label %121

; <label>:67                                      ; preds = %62
  %68 = load i32* %i2, align 4
  %69 = mul nsw i32 4096, %68
  %70 = load i32* %localId, align 4
  %71 = mul i32 %70, 32
  %72 = add i32 %69, %71
  store i32 %72, i32* %passNumber, align 4
  store <4 x i32> zeroinitializer, <4 x i32>* %binCount, align 16
  store i32 0, i32* %result, align 4
  store i32 0, i32* %j, align 4
  br label %73

; <label>:73                                      ; preds = %92, %67
  %74 = load i32* %j, align 4
  %75 = icmp slt i32 %74, 32
  br i1 %75, label %76, label %95

; <label>:76                                      ; preds = %73
  %77 = load i32* %j, align 4
  %78 = load i32* %offSet1, align 4
  %79 = add nsw i32 %77, %78
  %80 = and i32 %79, 31
  store i32 %80, i32* %bankNum, align 4
  %81 = load i32* %passNumber, align 4
  %82 = load i32* %bankNum, align 4
  %83 = add nsw i32 %81, %82
  %84 = load <4 x i8> addrspace(3)** %input, align 4
  %85 = getelementptr inbounds <4 x i8> addrspace(3)* %84, i32 %83
  %86 = load <4 x i8> addrspace(3)* %85, align 4
  store <4 x i8> %86, <4 x i8>* %binVal, align 4
  %87 = load <4 x i8>* %binVal, align 4
  %88 = call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %87)
  store <4 x i32> %88, <4 x i32>* %binValAsUint, align 16
  %89 = load <4 x i32>* %binValAsUint, align 16
  %90 = load <4 x i32>* %binCount, align 16
  %91 = add <4 x i32> %90, %89
  store <4 x i32> %91, <4 x i32>* %binCount, align 16
  br label %92

; <label>:92                                      ; preds = %76
  %93 = load i32* %j, align 4
  %94 = add nsw i32 %93, 1
  store i32 %94, i32* %j, align 4
  br label %73

; <label>:95                                      ; preds = %73
  %96 = load <4 x i32>* %binCount, align 16
  %97 = extractelement <4 x i32> %96, i32 0
  %98 = load <4 x i32>* %binCount, align 16
  %99 = extractelement <4 x i32> %98, i32 1
  %100 = add i32 %97, %99
  %101 = load <4 x i32>* %binCount, align 16
  %102 = extractelement <4 x i32> %101, i32 2
  %103 = add i32 %100, %102
  %104 = load <4 x i32>* %binCount, align 16
  %105 = extractelement <4 x i32> %104, i32 3
  %106 = add i32 %103, %105
  store i32 %106, i32* %result, align 4
  %107 = load i32* %result, align 4
  %108 = load i32* %groupId, align 4
  %109 = mul i32 %108, 256
  %110 = load i32* %groupSize, align 4
  %111 = load i32* %i2, align 4
  %112 = mul i32 %110, %111
  %113 = add i32 %109, %112
  %114 = load i32* %localId, align 4
  %115 = add i32 %113, %114
  %116 = load i32 addrspace(1)** %3, align 4
  %117 = getelementptr inbounds i32 addrspace(1)* %116, i32 %115
  store i32 %107, i32 addrspace(1)* %117, align 4
  br label %118

; <label>:118                                     ; preds = %95
  %119 = load i32* %i2, align 4
  %120 = add nsw i32 %119, 1
  store i32 %120, i32* %i2, align 4
  br label %62

; <label>:121                                     ; preds = %62
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.kernels = !{!0, !1}
!llvm.ident = !{!2}

!0 = metadata !{void (<4 x i32> addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_vector}
!1 = metadata !{void (i32 addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_scalar}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}

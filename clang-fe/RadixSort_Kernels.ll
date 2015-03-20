; ModuleID = '../kernel-src/RadixSort_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @histogram(i32 addrspace(1)* nocapture readonly %unsortedData, i32 addrspace(1)* nocapture %buckets, i32 %shiftCount, i32 addrspace(3)* %sharedArray) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = tail call i32 @get_global_size(i32 0) #2
  %6 = tail call i32 @get_local_size(i32 0) #2
  %7 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %1
  store i32 0, i32 addrspace(3)* %7, align 4, !tbaa !41
  tail call void @barrier(i32 1) #2
  %8 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %2
  %9 = load i32 addrspace(1)* %8, align 4, !tbaa !41
  %10 = and i32 %shiftCount, 31
  %11 = lshr i32 %9, %10
  %12 = and i32 %11, 255
  %13 = getelementptr inbounds i32 addrspace(3)* %sharedArray, i32 %12
  %14 = tail call i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)* %13, i32 1) #2
  tail call void @barrier(i32 1) #2
  %15 = mul i32 %4, %3
  %16 = add i32 %15, %1
  %17 = load i32 addrspace(3)* %7, align 4, !tbaa !41
  %18 = getelementptr inbounds i32 addrspace(1)* %buckets, i32 %16
  store i32 %17, i32 addrspace(1)* %18, align 4, !tbaa !41
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare i32 @get_global_size(i32) #1

declare void @barrier(i32) #1

declare i32 @_Z10atomic_addPVU3AS3jj(i32 addrspace(3)*, i32) #1

; Function Attrs: nounwind
define void @permute(i32 addrspace(1)* nocapture readonly %unsortedData, i32 addrspace(1)* nocapture readonly %scanedBuckets, i32 %shiftCount, i16 addrspace(3)* nocapture %sharedBuckets, i32 addrspace(1)* nocapture %sortedData) #0 {
  %1 = tail call i32 @get_group_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 0) #2
  %3 = tail call i32 @get_global_id(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = shl i32 %1, 8
  %6 = mul i32 %5, %4
  %7 = shl i32 %2, 8
  %8 = add i32 %6, %7
  br label %9

; <label>:9                                       ; preds = %9, %0
  %i.03 = phi i32 [ 0, %0 ], [ %121, %9 ]
  %10 = add i32 %8, %i.03
  %11 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %10
  %12 = load i32 addrspace(1)* %11, align 4, !tbaa !41
  %13 = trunc i32 %12 to i16
  %14 = add i32 %i.03, %7
  %15 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %14
  store i16 %13, i16 addrspace(3)* %15, align 2, !tbaa !45
  %16 = add nuw nsw i32 %i.03, 1
  %17 = add i32 %8, %16
  %18 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %17
  %19 = load i32 addrspace(1)* %18, align 4, !tbaa !41
  %20 = trunc i32 %19 to i16
  %21 = add i32 %16, %7
  %22 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %21
  store i16 %20, i16 addrspace(3)* %22, align 2, !tbaa !45
  %23 = add nuw nsw i32 %16, 1
  %24 = add i32 %8, %23
  %25 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %24
  %26 = load i32 addrspace(1)* %25, align 4, !tbaa !41
  %27 = trunc i32 %26 to i16
  %28 = add i32 %23, %7
  %29 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %28
  store i16 %27, i16 addrspace(3)* %29, align 2, !tbaa !45
  %30 = add nuw nsw i32 %23, 1
  %31 = add i32 %8, %30
  %32 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %31
  %33 = load i32 addrspace(1)* %32, align 4, !tbaa !41
  %34 = trunc i32 %33 to i16
  %35 = add i32 %30, %7
  %36 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %35
  store i16 %34, i16 addrspace(3)* %36, align 2, !tbaa !45
  %37 = add nuw nsw i32 %30, 1
  %38 = add i32 %8, %37
  %39 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %38
  %40 = load i32 addrspace(1)* %39, align 4, !tbaa !41
  %41 = trunc i32 %40 to i16
  %42 = add i32 %37, %7
  %43 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %42
  store i16 %41, i16 addrspace(3)* %43, align 2, !tbaa !45
  %44 = add nuw nsw i32 %37, 1
  %45 = add i32 %8, %44
  %46 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %45
  %47 = load i32 addrspace(1)* %46, align 4, !tbaa !41
  %48 = trunc i32 %47 to i16
  %49 = add i32 %44, %7
  %50 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %49
  store i16 %48, i16 addrspace(3)* %50, align 2, !tbaa !45
  %51 = add nuw nsw i32 %44, 1
  %52 = add i32 %8, %51
  %53 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %52
  %54 = load i32 addrspace(1)* %53, align 4, !tbaa !41
  %55 = trunc i32 %54 to i16
  %56 = add i32 %51, %7
  %57 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %56
  store i16 %55, i16 addrspace(3)* %57, align 2, !tbaa !45
  %58 = add nuw nsw i32 %51, 1
  %59 = add i32 %8, %58
  %60 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %59
  %61 = load i32 addrspace(1)* %60, align 4, !tbaa !41
  %62 = trunc i32 %61 to i16
  %63 = add i32 %58, %7
  %64 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %63
  store i16 %62, i16 addrspace(3)* %64, align 2, !tbaa !45
  %65 = add nuw nsw i32 %58, 1
  %66 = add i32 %8, %65
  %67 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %66
  %68 = load i32 addrspace(1)* %67, align 4, !tbaa !41
  %69 = trunc i32 %68 to i16
  %70 = add i32 %65, %7
  %71 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %70
  store i16 %69, i16 addrspace(3)* %71, align 2, !tbaa !45
  %72 = add nuw nsw i32 %65, 1
  %73 = add i32 %8, %72
  %74 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %73
  %75 = load i32 addrspace(1)* %74, align 4, !tbaa !41
  %76 = trunc i32 %75 to i16
  %77 = add i32 %72, %7
  %78 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %77
  store i16 %76, i16 addrspace(3)* %78, align 2, !tbaa !45
  %79 = add nuw nsw i32 %72, 1
  %80 = add i32 %8, %79
  %81 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %80
  %82 = load i32 addrspace(1)* %81, align 4, !tbaa !41
  %83 = trunc i32 %82 to i16
  %84 = add i32 %79, %7
  %85 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %84
  store i16 %83, i16 addrspace(3)* %85, align 2, !tbaa !45
  %86 = add nuw nsw i32 %79, 1
  %87 = add i32 %8, %86
  %88 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %87
  %89 = load i32 addrspace(1)* %88, align 4, !tbaa !41
  %90 = trunc i32 %89 to i16
  %91 = add i32 %86, %7
  %92 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %91
  store i16 %90, i16 addrspace(3)* %92, align 2, !tbaa !45
  %93 = add nuw nsw i32 %86, 1
  %94 = add i32 %8, %93
  %95 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %94
  %96 = load i32 addrspace(1)* %95, align 4, !tbaa !41
  %97 = trunc i32 %96 to i16
  %98 = add i32 %93, %7
  %99 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %98
  store i16 %97, i16 addrspace(3)* %99, align 2, !tbaa !45
  %100 = add nuw nsw i32 %93, 1
  %101 = add i32 %8, %100
  %102 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %101
  %103 = load i32 addrspace(1)* %102, align 4, !tbaa !41
  %104 = trunc i32 %103 to i16
  %105 = add i32 %100, %7
  %106 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %105
  store i16 %104, i16 addrspace(3)* %106, align 2, !tbaa !45
  %107 = add nuw nsw i32 %100, 1
  %108 = add i32 %8, %107
  %109 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %108
  %110 = load i32 addrspace(1)* %109, align 4, !tbaa !41
  %111 = trunc i32 %110 to i16
  %112 = add i32 %107, %7
  %113 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %112
  store i16 %111, i16 addrspace(3)* %113, align 2, !tbaa !45
  %114 = add nuw nsw i32 %107, 1
  %115 = add i32 %8, %114
  %116 = getelementptr inbounds i32 addrspace(1)* %scanedBuckets, i32 %115
  %117 = load i32 addrspace(1)* %116, align 4, !tbaa !41
  %118 = trunc i32 %117 to i16
  %119 = add i32 %114, %7
  %120 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %119
  store i16 %118, i16 addrspace(3)* %120, align 2, !tbaa !45
  %121 = add nuw nsw i32 %114, 1
  %exitcond4.15 = icmp eq i32 %121, 256
  br i1 %exitcond4.15, label %122, label %9

; <label>:122                                     ; preds = %9
  tail call void @barrier(i32 1) #2
  %123 = shl i32 %3, 8
  %124 = and i32 %shiftCount, 31
  br label %125

; <label>:125                                     ; preds = %125, %122
  %i1.02 = phi i32 [ 0, %122 ], [ %229, %125 ]
  %126 = add i32 %i1.02, %123
  %127 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %126
  %128 = load i32 addrspace(1)* %127, align 4, !tbaa !41
  %129 = lshr i32 %128, %124
  %130 = and i32 %129, 255
  %131 = or i32 %130, %7
  %132 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %131
  %133 = load i16 addrspace(3)* %132, align 2, !tbaa !45
  %134 = zext i16 %133 to i32
  %135 = getelementptr inbounds i32 addrspace(1)* %sortedData, i32 %134
  store i32 %128, i32 addrspace(1)* %135, align 4, !tbaa !41
  %136 = add nuw nsw i32 %134, 1
  %137 = trunc i32 %136 to i16
  store i16 %137, i16 addrspace(3)* %132, align 2, !tbaa !45
  tail call void @barrier(i32 1) #2
  %138 = add nuw nsw i32 %i1.02, 1
  %139 = add i32 %138, %123
  %140 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %139
  %141 = load i32 addrspace(1)* %140, align 4, !tbaa !41
  %142 = lshr i32 %141, %124
  %143 = and i32 %142, 255
  %144 = or i32 %143, %7
  %145 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %144
  %146 = load i16 addrspace(3)* %145, align 2, !tbaa !45
  %147 = zext i16 %146 to i32
  %148 = getelementptr inbounds i32 addrspace(1)* %sortedData, i32 %147
  store i32 %141, i32 addrspace(1)* %148, align 4, !tbaa !41
  %149 = add nuw nsw i32 %147, 1
  %150 = trunc i32 %149 to i16
  store i16 %150, i16 addrspace(3)* %145, align 2, !tbaa !45
  tail call void @barrier(i32 1) #2
  %151 = add nuw nsw i32 %138, 1
  %152 = add i32 %151, %123
  %153 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %152
  %154 = load i32 addrspace(1)* %153, align 4, !tbaa !41
  %155 = lshr i32 %154, %124
  %156 = and i32 %155, 255
  %157 = or i32 %156, %7
  %158 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %157
  %159 = load i16 addrspace(3)* %158, align 2, !tbaa !45
  %160 = zext i16 %159 to i32
  %161 = getelementptr inbounds i32 addrspace(1)* %sortedData, i32 %160
  store i32 %154, i32 addrspace(1)* %161, align 4, !tbaa !41
  %162 = add nuw nsw i32 %160, 1
  %163 = trunc i32 %162 to i16
  store i16 %163, i16 addrspace(3)* %158, align 2, !tbaa !45
  tail call void @barrier(i32 1) #2
  %164 = add nuw nsw i32 %151, 1
  %165 = add i32 %164, %123
  %166 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %165
  %167 = load i32 addrspace(1)* %166, align 4, !tbaa !41
  %168 = lshr i32 %167, %124
  %169 = and i32 %168, 255
  %170 = or i32 %169, %7
  %171 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %170
  %172 = load i16 addrspace(3)* %171, align 2, !tbaa !45
  %173 = zext i16 %172 to i32
  %174 = getelementptr inbounds i32 addrspace(1)* %sortedData, i32 %173
  store i32 %167, i32 addrspace(1)* %174, align 4, !tbaa !41
  %175 = add nuw nsw i32 %173, 1
  %176 = trunc i32 %175 to i16
  store i16 %176, i16 addrspace(3)* %171, align 2, !tbaa !45
  tail call void @barrier(i32 1) #2
  %177 = add nuw nsw i32 %164, 1
  %178 = add i32 %177, %123
  %179 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %178
  %180 = load i32 addrspace(1)* %179, align 4, !tbaa !41
  %181 = lshr i32 %180, %124
  %182 = and i32 %181, 255
  %183 = or i32 %182, %7
  %184 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %183
  %185 = load i16 addrspace(3)* %184, align 2, !tbaa !45
  %186 = zext i16 %185 to i32
  %187 = getelementptr inbounds i32 addrspace(1)* %sortedData, i32 %186
  store i32 %180, i32 addrspace(1)* %187, align 4, !tbaa !41
  %188 = add nuw nsw i32 %186, 1
  %189 = trunc i32 %188 to i16
  store i16 %189, i16 addrspace(3)* %184, align 2, !tbaa !45
  tail call void @barrier(i32 1) #2
  %190 = add nuw nsw i32 %177, 1
  %191 = add i32 %190, %123
  %192 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %191
  %193 = load i32 addrspace(1)* %192, align 4, !tbaa !41
  %194 = lshr i32 %193, %124
  %195 = and i32 %194, 255
  %196 = or i32 %195, %7
  %197 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %196
  %198 = load i16 addrspace(3)* %197, align 2, !tbaa !45
  %199 = zext i16 %198 to i32
  %200 = getelementptr inbounds i32 addrspace(1)* %sortedData, i32 %199
  store i32 %193, i32 addrspace(1)* %200, align 4, !tbaa !41
  %201 = add nuw nsw i32 %199, 1
  %202 = trunc i32 %201 to i16
  store i16 %202, i16 addrspace(3)* %197, align 2, !tbaa !45
  tail call void @barrier(i32 1) #2
  %203 = add nuw nsw i32 %190, 1
  %204 = add i32 %203, %123
  %205 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %204
  %206 = load i32 addrspace(1)* %205, align 4, !tbaa !41
  %207 = lshr i32 %206, %124
  %208 = and i32 %207, 255
  %209 = or i32 %208, %7
  %210 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %209
  %211 = load i16 addrspace(3)* %210, align 2, !tbaa !45
  %212 = zext i16 %211 to i32
  %213 = getelementptr inbounds i32 addrspace(1)* %sortedData, i32 %212
  store i32 %206, i32 addrspace(1)* %213, align 4, !tbaa !41
  %214 = add nuw nsw i32 %212, 1
  %215 = trunc i32 %214 to i16
  store i16 %215, i16 addrspace(3)* %210, align 2, !tbaa !45
  tail call void @barrier(i32 1) #2
  %216 = add nuw nsw i32 %203, 1
  %217 = add i32 %216, %123
  %218 = getelementptr inbounds i32 addrspace(1)* %unsortedData, i32 %217
  %219 = load i32 addrspace(1)* %218, align 4, !tbaa !41
  %220 = lshr i32 %219, %124
  %221 = and i32 %220, 255
  %222 = or i32 %221, %7
  %223 = getelementptr inbounds i16 addrspace(3)* %sharedBuckets, i32 %222
  %224 = load i16 addrspace(3)* %223, align 2, !tbaa !45
  %225 = zext i16 %224 to i32
  %226 = getelementptr inbounds i32 addrspace(1)* %sortedData, i32 %225
  store i32 %219, i32 addrspace(1)* %226, align 4, !tbaa !41
  %227 = add nuw nsw i32 %225, 1
  %228 = trunc i32 %227 to i16
  store i16 %228, i16 addrspace(3)* %223, align 2, !tbaa !45
  tail call void @barrier(i32 1) #2
  %229 = add nuw nsw i32 %216, 1
  %exitcond.7 = icmp eq i32 %229, 256
  br i1 %exitcond.7, label %230, label %125

; <label>:230                                     ; preds = %125
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim2(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(3)* nocapture %block, i32 %block_size, i32 %stride, i32 addrspace(1)* nocapture %sumBuffer) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 1) #2
  %3 = tail call i32 @get_global_id(i32 0) #2
  %4 = tail call i32 @get_global_id(i32 1) #2
  %5 = tail call i32 @get_group_id(i32 0) #2
  %6 = tail call i32 @get_group_id(i32 1) #2
  %7 = shl i32 %3, 8
  %8 = add nsw i32 %7, %4
  %9 = tail call i32 @get_global_size(i32 0) #2
  %10 = udiv i32 %9, %block_size
  %11 = mul i32 %10, %6
  %12 = add i32 %11, %5
  %13 = getelementptr inbounds i32 addrspace(1)* %input, i32 %8
  %14 = load i32 addrspace(1)* %13, align 4, !tbaa !41
  %15 = getelementptr inbounds i32 addrspace(3)* %block, i32 %1
  store i32 %14, i32 addrspace(3)* %15, align 4, !tbaa !41
  tail call void @barrier(i32 1) #2
  %16 = icmp ugt i32 %block_size, 1
  br i1 %16, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %17 = load i32 addrspace(3)* %block, align 4, !tbaa !41
  br label %18

; <label>:18                                      ; preds = %.lr.ph, %26
  %dis.02 = phi i32 [ 1, %.lr.ph ], [ %27, %26 ]
  %cache.01 = phi i32 [ %17, %.lr.ph ], [ %cache.1, %26 ]
  %19 = icmp slt i32 %1, %dis.02
  br i1 %19, label %26, label %20

; <label>:20                                      ; preds = %18
  %21 = sub nsw i32 %1, %dis.02
  %22 = getelementptr inbounds i32 addrspace(3)* %block, i32 %21
  %23 = load i32 addrspace(3)* %22, align 4, !tbaa !41
  %24 = load i32 addrspace(3)* %15, align 4, !tbaa !41
  %25 = add i32 %24, %23
  br label %26

; <label>:26                                      ; preds = %18, %20
  %cache.1 = phi i32 [ %25, %20 ], [ %cache.01, %18 ]
  tail call void @barrier(i32 1) #2
  store i32 %cache.1, i32 addrspace(3)* %15, align 4, !tbaa !41
  tail call void @barrier(i32 1) #2
  %27 = shl nsw i32 %dis.02, 1
  %28 = icmp ult i32 %27, %block_size
  br i1 %28, label %18, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %26
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %29 = add i32 %block_size, -1
  %30 = getelementptr inbounds i32 addrspace(3)* %block, i32 %29
  %31 = load i32 addrspace(3)* %30, align 4, !tbaa !41
  %32 = getelementptr inbounds i32 addrspace(1)* %sumBuffer, i32 %12
  store i32 %31, i32 addrspace(1)* %32, align 4, !tbaa !41
  %33 = icmp eq i32 %1, 0
  br i1 %33, label %38, label %34

; <label>:34                                      ; preds = %._crit_edge
  %35 = add nsw i32 %1, -1
  %36 = getelementptr inbounds i32 addrspace(3)* %block, i32 %35
  %37 = load i32 addrspace(3)* %36, align 4, !tbaa !41
  br label %38

; <label>:38                                      ; preds = %._crit_edge, %34
  %.sink = phi i32 [ %37, %34 ], [ 0, %._crit_edge ]
  %39 = getelementptr inbounds i32 addrspace(1)* %output, i32 %8
  store i32 %.sink, i32 addrspace(1)* %39, align 4
  ret void
}

; Function Attrs: nounwind
define void @ScanArraysdim1(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(3)* nocapture %block, i32 %block_size) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = getelementptr inbounds i32 addrspace(1)* %input, i32 %2
  %5 = load i32 addrspace(1)* %4, align 4, !tbaa !41
  %6 = getelementptr inbounds i32 addrspace(3)* %block, i32 %1
  store i32 %5, i32 addrspace(3)* %6, align 4, !tbaa !41
  %7 = icmp ugt i32 %block_size, 1
  br i1 %7, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %8 = load i32 addrspace(3)* %block, align 4, !tbaa !41
  br label %9

; <label>:9                                       ; preds = %.lr.ph, %17
  %stride.02 = phi i32 [ 1, %.lr.ph ], [ %18, %17 ]
  %cache.01 = phi i32 [ %8, %.lr.ph ], [ %cache.1, %17 ]
  %10 = icmp slt i32 %1, %stride.02
  br i1 %10, label %17, label %11

; <label>:11                                      ; preds = %9
  %12 = sub nsw i32 %1, %stride.02
  %13 = getelementptr inbounds i32 addrspace(3)* %block, i32 %12
  %14 = load i32 addrspace(3)* %13, align 4, !tbaa !41
  %15 = load i32 addrspace(3)* %6, align 4, !tbaa !41
  %16 = add i32 %15, %14
  br label %17

; <label>:17                                      ; preds = %9, %11
  %cache.1 = phi i32 [ %16, %11 ], [ %cache.01, %9 ]
  tail call void @barrier(i32 1) #2
  store i32 %cache.1, i32 addrspace(3)* %6, align 4, !tbaa !41
  tail call void @barrier(i32 1) #2
  %18 = shl nsw i32 %stride.02, 1
  %19 = icmp ult i32 %18, %block_size
  br i1 %19, label %9, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %17
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %20 = icmp eq i32 %1, 0
  br i1 %20, label %25, label %21

; <label>:21                                      ; preds = %._crit_edge
  %22 = add nsw i32 %1, -1
  %23 = getelementptr inbounds i32 addrspace(3)* %block, i32 %22
  %24 = load i32 addrspace(3)* %23, align 4, !tbaa !41
  br label %25

; <label>:25                                      ; preds = %._crit_edge, %21
  %.sink = phi i32 [ %24, %21 ], [ 0, %._crit_edge ]
  %26 = getelementptr inbounds i32 addrspace(1)* %output, i32 %2
  store i32 %.sink, i32 addrspace(1)* %26, align 4
  ret void
}

; Function Attrs: nounwind
define void @prefixSum(i32 addrspace(1)* nocapture %output, i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %summary, i32 %stride) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = mul nsw i32 %2, %stride
  %4 = add nsw i32 %3, %1
  %5 = getelementptr inbounds i32 addrspace(1)* %output, i32 %4
  store i32 0, i32 addrspace(1)* %5, align 4, !tbaa !41
  %6 = icmp sgt i32 %1, 0
  br i1 %6, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %0
  %7 = add i32 %1, -1
  br label %8

; <label>:8                                       ; preds = %8, %.lr.ph
  %9 = phi i32 [ 0, %.lr.ph ], [ %13, %8 ]
  %i.01 = phi i32 [ 0, %.lr.ph ], [ %14, %8 ]
  %10 = add nsw i32 %i.01, %3
  %11 = getelementptr inbounds i32 addrspace(1)* %input, i32 %10
  %12 = load i32 addrspace(1)* %11, align 4, !tbaa !41
  %13 = add i32 %9, %12
  store i32 %13, i32 addrspace(1)* %5, align 4, !tbaa !41
  %14 = add nuw nsw i32 %i.01, 1
  %exitcond = icmp eq i32 %i.01, %7
  br i1 %exitcond, label %.loopexit.loopexit, label %8

.loopexit.loopexit:                               ; preds = %8
  %.lcssa = phi i32 [ %13, %8 ]
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %0
  %15 = phi i32 [ 0, %0 ], [ %.lcssa, %.loopexit.loopexit ]
  %16 = add nsw i32 %stride, -1
  %17 = icmp eq i32 %1, %16
  br i1 %17, label %18, label %23

; <label>:18                                      ; preds = %.loopexit
  %19 = getelementptr inbounds i32 addrspace(1)* %input, i32 %4
  %20 = load i32 addrspace(1)* %19, align 4, !tbaa !41
  %21 = add i32 %20, %15
  %22 = getelementptr inbounds i32 addrspace(1)* %summary, i32 %2
  store i32 %21, i32 addrspace(1)* %22, align 4, !tbaa !41
  br label %23

; <label>:23                                      ; preds = %18, %.loopexit
  ret void
}

; Function Attrs: nounwind
define void @blockAddition(i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %output, i32 %stride) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = tail call i32 @get_group_id(i32 1) #2
  %5 = shl i32 %1, 8
  %6 = add nsw i32 %2, %5
  %7 = mul i32 %4, %stride
  %8 = add i32 %7, %3
  %9 = getelementptr inbounds i32 addrspace(1)* %input, i32 %8
  %10 = load i32 addrspace(1)* %9, align 4, !tbaa !41
  %11 = getelementptr inbounds i32 addrspace(1)* %output, i32 %6
  %12 = load i32 addrspace(1)* %11, align 4, !tbaa !41
  %13 = add i32 %12, %10
  store i32 %13, i32 addrspace(1)* %11, align 4, !tbaa !41
  ret void
}

; Function Attrs: nounwind
define void @FixOffset(i32 addrspace(1)* nocapture readonly %input, i32 addrspace(1)* nocapture %output) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = shl i32 %1, 8
  %4 = add nsw i32 %2, %3
  %5 = getelementptr inbounds i32 addrspace(1)* %input, i32 %2
  %6 = load i32 addrspace(1)* %5, align 4, !tbaa !41
  %7 = getelementptr inbounds i32 addrspace(1)* %output, i32 %4
  %8 = load i32 addrspace(1)* %7, align 4, !tbaa !41
  %9 = add i32 %8, %6
  store i32 %9, i32 addrspace(1)* %7, align 4, !tbaa !41
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6, !12, !18, !23, !28, !34}
!llvm.ident = !{!40}

!0 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i32 addrspace(3)*)* @histogram, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 3}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint", !"uint*"}
!4 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint", !"uint*"}
!5 = !{!"kernel_arg_type_qual", !"const", !"", !"", !""}
!6 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32, i16 addrspace(3)*, i32 addrspace(1)*)* @permute, !7, !8, !9, !10, !11}
!7 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 3, i32 1}
!8 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none"}
!9 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint", !"ushort*", !"uint*"}
!10 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint", !"ushort*", !"uint*"}
!11 = !{!"kernel_arg_type_qual", !"const", !"const", !"", !"", !""}
!12 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32, i32, i32 addrspace(1)*)* @ScanArraysdim2, !13, !14, !15, !16, !17}
!13 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0, i32 0, i32 1}
!14 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none"}
!15 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint*", !"uint", !"uint", !"uint*"}
!16 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint*", !"uint", !"uint", !"uint*"}
!17 = !{!"kernel_arg_type_qual", !"", !"", !"", !"const", !"const", !""}
!18 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(3)*, i32)* @ScanArraysdim1, !19, !2, !20, !21, !22}
!19 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 3, i32 0}
!20 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint*", !"uint"}
!21 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint*", !"uint"}
!22 = !{!"kernel_arg_type_qual", !"", !"", !"", !"const"}
!23 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*, i32)* @prefixSum, !24, !2, !25, !26, !27}
!24 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 1, i32 0}
!25 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint*", !"int"}
!26 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint*", !"int"}
!27 = !{!"kernel_arg_type_qual", !"", !"", !"", !""}
!28 = !{void (i32 addrspace(1)*, i32 addrspace(1)*, i32)* @blockAddition, !29, !30, !31, !32, !33}
!29 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!30 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!31 = !{!"kernel_arg_type", !"uint*", !"uint*", !"uint"}
!32 = !{!"kernel_arg_base_type", !"uint*", !"uint*", !"uint"}
!33 = !{!"kernel_arg_type_qual", !"", !"", !""}
!34 = !{void (i32 addrspace(1)*, i32 addrspace(1)*)* @FixOffset, !35, !36, !37, !38, !39}
!35 = !{!"kernel_arg_addr_space", i32 1, i32 1}
!36 = !{!"kernel_arg_access_qual", !"none", !"none"}
!37 = !{!"kernel_arg_type", !"uint*", !"uint*"}
!38 = !{!"kernel_arg_base_type", !"uint*", !"uint*"}
!39 = !{!"kernel_arg_type_qual", !"", !""}
!40 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!41 = !{!42, !42, i64 0}
!42 = !{!"int", !43, i64 0}
!43 = !{!"omnipotent char", !44, i64 0}
!44 = !{!"Simple C/C++ TBAA"}
!45 = !{!46, !46, i64 0}
!46 = !{!"short", !43, i64 0}

; ModuleID = '../kernel-src/Histogram_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @histogram256_vector(<4 x i32> addrspace(1)* nocapture readonly %data, i8 addrspace(3)* nocapture %sharedArray, i32 addrspace(1)* nocapture %binResult) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = shl i32 %1, 2
  %6 = and i32 %5, 124
  %7 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %8

; <label>:8                                       ; preds = %8, %0
  %i.07 = phi i32 [ 0, %0 ], [ %72, %8 ]
  %9 = mul i32 %i.07, %4
  %10 = add i32 %9, %1
  %11 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %10
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %11, align 4, !tbaa !10
  %12 = add nuw nsw i32 %i.07, 1
  %13 = mul i32 %12, %4
  %14 = add i32 %13, %1
  %15 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %14
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %15, align 4, !tbaa !10
  %16 = add nuw nsw i32 %12, 1
  %17 = mul i32 %16, %4
  %18 = add i32 %17, %1
  %19 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %18
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %19, align 4, !tbaa !10
  %20 = add nuw nsw i32 %16, 1
  %21 = mul i32 %20, %4
  %22 = add i32 %21, %1
  %23 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %22
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %23, align 4, !tbaa !10
  %24 = add nuw nsw i32 %20, 1
  %25 = mul i32 %24, %4
  %26 = add i32 %25, %1
  %27 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %26
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %27, align 4, !tbaa !10
  %28 = add nuw nsw i32 %24, 1
  %29 = mul i32 %28, %4
  %30 = add i32 %29, %1
  %31 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %30
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %31, align 4, !tbaa !10
  %32 = add nuw nsw i32 %28, 1
  %33 = mul i32 %32, %4
  %34 = add i32 %33, %1
  %35 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %34
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %35, align 4, !tbaa !10
  %36 = add nuw nsw i32 %32, 1
  %37 = mul i32 %36, %4
  %38 = add i32 %37, %1
  %39 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %38
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %39, align 4, !tbaa !10
  %40 = add nuw nsw i32 %36, 1
  %41 = mul i32 %40, %4
  %42 = add i32 %41, %1
  %43 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %42
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %43, align 4, !tbaa !10
  %44 = add nuw nsw i32 %40, 1
  %45 = mul i32 %44, %4
  %46 = add i32 %45, %1
  %47 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %46
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %47, align 4, !tbaa !10
  %48 = add nuw nsw i32 %44, 1
  %49 = mul i32 %48, %4
  %50 = add i32 %49, %1
  %51 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %50
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %51, align 4, !tbaa !10
  %52 = add nuw nsw i32 %48, 1
  %53 = mul i32 %52, %4
  %54 = add i32 %53, %1
  %55 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %54
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %55, align 4, !tbaa !10
  %56 = add nuw nsw i32 %52, 1
  %57 = mul i32 %56, %4
  %58 = add i32 %57, %1
  %59 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %58
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %59, align 4, !tbaa !10
  %60 = add nuw nsw i32 %56, 1
  %61 = mul i32 %60, %4
  %62 = add i32 %61, %1
  %63 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %62
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %63, align 4, !tbaa !10
  %64 = add nuw nsw i32 %60, 1
  %65 = mul i32 %64, %4
  %66 = add i32 %65, %1
  %67 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %66
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %67, align 4, !tbaa !10
  %68 = add nuw nsw i32 %64, 1
  %69 = mul i32 %68, %4
  %70 = add i32 %69, %1
  %71 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %70
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %71, align 4, !tbaa !10
  %72 = add nuw nsw i32 %68, 1
  %exitcond9.15 = icmp eq i32 %72, 64
  br i1 %exitcond9.15, label %73, label %8

; <label>:73                                      ; preds = %8
  %74 = lshr i32 %1, 5
  tail call void @barrier(i32 1) #2
  %75 = shl i32 %4, 5
  %76 = and i32 %75, 536870880
  %77 = mul i32 %76, %3
  %78 = add i32 %77, %1
  br label %79

; <label>:79                                      ; preds = %79, %73
  %i1.06 = phi i32 [ 0, %73 ], [ %211, %79 ]
  %80 = mul i32 %i1.06, %4
  %81 = add i32 %78, %80
  %82 = getelementptr inbounds <4 x i32> addrspace(1)* %data, i32 %81
  %83 = load <4 x i32> addrspace(1)* %82, align 16, !tbaa !10
  %84 = extractelement <4 x i32> %83, i32 0
  %85 = shl i32 %84, 7
  %86 = or i32 %85, %6
  %87 = add i32 %86, %74
  %88 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %87
  %89 = load i8 addrspace(3)* %88, align 1, !tbaa !10
  %90 = add i8 %89, 1
  store i8 %90, i8 addrspace(3)* %88, align 1, !tbaa !10
  %91 = extractelement <4 x i32> %83, i32 1
  %92 = shl i32 %91, 7
  %93 = or i32 %92, %6
  %94 = add i32 %93, %74
  %95 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %94
  %96 = load i8 addrspace(3)* %95, align 1, !tbaa !10
  %97 = add i8 %96, 1
  store i8 %97, i8 addrspace(3)* %95, align 1, !tbaa !10
  %98 = extractelement <4 x i32> %83, i32 2
  %99 = shl i32 %98, 7
  %100 = or i32 %99, %6
  %101 = add i32 %100, %74
  %102 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %101
  %103 = load i8 addrspace(3)* %102, align 1, !tbaa !10
  %104 = add i8 %103, 1
  store i8 %104, i8 addrspace(3)* %102, align 1, !tbaa !10
  %105 = extractelement <4 x i32> %83, i32 3
  %106 = shl i32 %105, 7
  %107 = or i32 %106, %6
  %108 = add i32 %107, %74
  %109 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %108
  %110 = load i8 addrspace(3)* %109, align 1, !tbaa !10
  %111 = add i8 %110, 1
  store i8 %111, i8 addrspace(3)* %109, align 1, !tbaa !10
  %112 = add nuw nsw i32 %i1.06, 1
  %113 = mul i32 %112, %4
  %114 = add i32 %78, %113
  %115 = getelementptr inbounds <4 x i32> addrspace(1)* %data, i32 %114
  %116 = load <4 x i32> addrspace(1)* %115, align 16, !tbaa !10
  %117 = extractelement <4 x i32> %116, i32 0
  %118 = shl i32 %117, 7
  %119 = or i32 %118, %6
  %120 = add i32 %119, %74
  %121 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %120
  %122 = load i8 addrspace(3)* %121, align 1, !tbaa !10
  %123 = add i8 %122, 1
  store i8 %123, i8 addrspace(3)* %121, align 1, !tbaa !10
  %124 = extractelement <4 x i32> %116, i32 1
  %125 = shl i32 %124, 7
  %126 = or i32 %125, %6
  %127 = add i32 %126, %74
  %128 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %127
  %129 = load i8 addrspace(3)* %128, align 1, !tbaa !10
  %130 = add i8 %129, 1
  store i8 %130, i8 addrspace(3)* %128, align 1, !tbaa !10
  %131 = extractelement <4 x i32> %116, i32 2
  %132 = shl i32 %131, 7
  %133 = or i32 %132, %6
  %134 = add i32 %133, %74
  %135 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %134
  %136 = load i8 addrspace(3)* %135, align 1, !tbaa !10
  %137 = add i8 %136, 1
  store i8 %137, i8 addrspace(3)* %135, align 1, !tbaa !10
  %138 = extractelement <4 x i32> %116, i32 3
  %139 = shl i32 %138, 7
  %140 = or i32 %139, %6
  %141 = add i32 %140, %74
  %142 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %141
  %143 = load i8 addrspace(3)* %142, align 1, !tbaa !10
  %144 = add i8 %143, 1
  store i8 %144, i8 addrspace(3)* %142, align 1, !tbaa !10
  %145 = add nuw nsw i32 %112, 1
  %146 = mul i32 %145, %4
  %147 = add i32 %78, %146
  %148 = getelementptr inbounds <4 x i32> addrspace(1)* %data, i32 %147
  %149 = load <4 x i32> addrspace(1)* %148, align 16, !tbaa !10
  %150 = extractelement <4 x i32> %149, i32 0
  %151 = shl i32 %150, 7
  %152 = or i32 %151, %6
  %153 = add i32 %152, %74
  %154 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %153
  %155 = load i8 addrspace(3)* %154, align 1, !tbaa !10
  %156 = add i8 %155, 1
  store i8 %156, i8 addrspace(3)* %154, align 1, !tbaa !10
  %157 = extractelement <4 x i32> %149, i32 1
  %158 = shl i32 %157, 7
  %159 = or i32 %158, %6
  %160 = add i32 %159, %74
  %161 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %160
  %162 = load i8 addrspace(3)* %161, align 1, !tbaa !10
  %163 = add i8 %162, 1
  store i8 %163, i8 addrspace(3)* %161, align 1, !tbaa !10
  %164 = extractelement <4 x i32> %149, i32 2
  %165 = shl i32 %164, 7
  %166 = or i32 %165, %6
  %167 = add i32 %166, %74
  %168 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %167
  %169 = load i8 addrspace(3)* %168, align 1, !tbaa !10
  %170 = add i8 %169, 1
  store i8 %170, i8 addrspace(3)* %168, align 1, !tbaa !10
  %171 = extractelement <4 x i32> %149, i32 3
  %172 = shl i32 %171, 7
  %173 = or i32 %172, %6
  %174 = add i32 %173, %74
  %175 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %174
  %176 = load i8 addrspace(3)* %175, align 1, !tbaa !10
  %177 = add i8 %176, 1
  store i8 %177, i8 addrspace(3)* %175, align 1, !tbaa !10
  %178 = add nuw nsw i32 %145, 1
  %179 = mul i32 %178, %4
  %180 = add i32 %78, %179
  %181 = getelementptr inbounds <4 x i32> addrspace(1)* %data, i32 %180
  %182 = load <4 x i32> addrspace(1)* %181, align 16, !tbaa !10
  %183 = extractelement <4 x i32> %182, i32 0
  %184 = shl i32 %183, 7
  %185 = or i32 %184, %6
  %186 = add i32 %185, %74
  %187 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %186
  %188 = load i8 addrspace(3)* %187, align 1, !tbaa !10
  %189 = add i8 %188, 1
  store i8 %189, i8 addrspace(3)* %187, align 1, !tbaa !10
  %190 = extractelement <4 x i32> %182, i32 1
  %191 = shl i32 %190, 7
  %192 = or i32 %191, %6
  %193 = add i32 %192, %74
  %194 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %193
  %195 = load i8 addrspace(3)* %194, align 1, !tbaa !10
  %196 = add i8 %195, 1
  store i8 %196, i8 addrspace(3)* %194, align 1, !tbaa !10
  %197 = extractelement <4 x i32> %182, i32 2
  %198 = shl i32 %197, 7
  %199 = or i32 %198, %6
  %200 = add i32 %199, %74
  %201 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %200
  %202 = load i8 addrspace(3)* %201, align 1, !tbaa !10
  %203 = add i8 %202, 1
  store i8 %203, i8 addrspace(3)* %201, align 1, !tbaa !10
  %204 = extractelement <4 x i32> %182, i32 3
  %205 = shl i32 %204, 7
  %206 = or i32 %205, %6
  %207 = add i32 %206, %74
  %208 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %207
  %209 = load i8 addrspace(3)* %208, align 1, !tbaa !10
  %210 = add i8 %209, 1
  store i8 %210, i8 addrspace(3)* %208, align 1, !tbaa !10
  %211 = add nuw nsw i32 %178, 1
  %exitcond8.3 = icmp eq i32 %211, 32
  br i1 %exitcond8.3, label %212, label %79

; <label>:212                                     ; preds = %79
  tail call void @barrier(i32 1) #2
  %213 = udiv i32 256, %4
  %214 = icmp eq i32 %213, 0
  br i1 %214, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %212
  %215 = shl i32 %1, 5
  %216 = shl i32 %3, 8
  %217 = add i32 %216, %1
  %218 = and i32 %1, 31
  br label %219

; <label>:219                                     ; preds = %.lr.ph, %219
  %i2.05 = phi i32 [ 0, %.lr.ph ], [ %453, %219 ]
  %220 = shl i32 %i2.05, 12
  %221 = add i32 %220, %215
  %222 = or i32 %218, %221
  %223 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %222
  %224 = load <4 x i8> addrspace(3)* %223, align 4, !tbaa !10
  %225 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %224) #2
  %226 = add nsw i32 %1, 1
  %227 = and i32 %226, 31
  %228 = or i32 %227, %221
  %229 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %228
  %230 = load <4 x i8> addrspace(3)* %229, align 4, !tbaa !10
  %231 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %230) #2
  %232 = add <4 x i32> %225, %231
  %233 = add nsw i32 %1, 2
  %234 = and i32 %233, 31
  %235 = or i32 %234, %221
  %236 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %235
  %237 = load <4 x i8> addrspace(3)* %236, align 4, !tbaa !10
  %238 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %237) #2
  %239 = add <4 x i32> %232, %238
  %240 = add nsw i32 %1, 3
  %241 = and i32 %240, 31
  %242 = or i32 %241, %221
  %243 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %242
  %244 = load <4 x i8> addrspace(3)* %243, align 4, !tbaa !10
  %245 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %244) #2
  %246 = add <4 x i32> %239, %245
  %247 = add nsw i32 %1, 4
  %248 = and i32 %247, 31
  %249 = or i32 %248, %221
  %250 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %249
  %251 = load <4 x i8> addrspace(3)* %250, align 4, !tbaa !10
  %252 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %251) #2
  %253 = add <4 x i32> %246, %252
  %254 = add nsw i32 %1, 5
  %255 = and i32 %254, 31
  %256 = or i32 %255, %221
  %257 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %256
  %258 = load <4 x i8> addrspace(3)* %257, align 4, !tbaa !10
  %259 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %258) #2
  %260 = add <4 x i32> %253, %259
  %261 = add nsw i32 %1, 6
  %262 = and i32 %261, 31
  %263 = or i32 %262, %221
  %264 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %263
  %265 = load <4 x i8> addrspace(3)* %264, align 4, !tbaa !10
  %266 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %265) #2
  %267 = add <4 x i32> %260, %266
  %268 = add nsw i32 %1, 7
  %269 = and i32 %268, 31
  %270 = or i32 %269, %221
  %271 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %270
  %272 = load <4 x i8> addrspace(3)* %271, align 4, !tbaa !10
  %273 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %272) #2
  %274 = add <4 x i32> %267, %273
  %275 = add nsw i32 %1, 8
  %276 = and i32 %275, 31
  %277 = or i32 %276, %221
  %278 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %277
  %279 = load <4 x i8> addrspace(3)* %278, align 4, !tbaa !10
  %280 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %279) #2
  %281 = add <4 x i32> %274, %280
  %282 = add nsw i32 %1, 9
  %283 = and i32 %282, 31
  %284 = or i32 %283, %221
  %285 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %284
  %286 = load <4 x i8> addrspace(3)* %285, align 4, !tbaa !10
  %287 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %286) #2
  %288 = add <4 x i32> %281, %287
  %289 = add nsw i32 %1, 10
  %290 = and i32 %289, 31
  %291 = or i32 %290, %221
  %292 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %291
  %293 = load <4 x i8> addrspace(3)* %292, align 4, !tbaa !10
  %294 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %293) #2
  %295 = add <4 x i32> %288, %294
  %296 = add nsw i32 %1, 11
  %297 = and i32 %296, 31
  %298 = or i32 %297, %221
  %299 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %298
  %300 = load <4 x i8> addrspace(3)* %299, align 4, !tbaa !10
  %301 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %300) #2
  %302 = add <4 x i32> %295, %301
  %303 = add nsw i32 %1, 12
  %304 = and i32 %303, 31
  %305 = or i32 %304, %221
  %306 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %305
  %307 = load <4 x i8> addrspace(3)* %306, align 4, !tbaa !10
  %308 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %307) #2
  %309 = add <4 x i32> %302, %308
  %310 = add nsw i32 %1, 13
  %311 = and i32 %310, 31
  %312 = or i32 %311, %221
  %313 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %312
  %314 = load <4 x i8> addrspace(3)* %313, align 4, !tbaa !10
  %315 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %314) #2
  %316 = add <4 x i32> %309, %315
  %317 = add nsw i32 %1, 14
  %318 = and i32 %317, 31
  %319 = or i32 %318, %221
  %320 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %319
  %321 = load <4 x i8> addrspace(3)* %320, align 4, !tbaa !10
  %322 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %321) #2
  %323 = add <4 x i32> %316, %322
  %324 = add nsw i32 %1, 15
  %325 = and i32 %324, 31
  %326 = or i32 %325, %221
  %327 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %326
  %328 = load <4 x i8> addrspace(3)* %327, align 4, !tbaa !10
  %329 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %328) #2
  %330 = add <4 x i32> %323, %329
  %331 = add nsw i32 %1, 16
  %332 = and i32 %331, 31
  %333 = or i32 %332, %221
  %334 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %333
  %335 = load <4 x i8> addrspace(3)* %334, align 4, !tbaa !10
  %336 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %335) #2
  %337 = add <4 x i32> %330, %336
  %338 = add nsw i32 %1, 17
  %339 = and i32 %338, 31
  %340 = or i32 %339, %221
  %341 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %340
  %342 = load <4 x i8> addrspace(3)* %341, align 4, !tbaa !10
  %343 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %342) #2
  %344 = add <4 x i32> %337, %343
  %345 = add nsw i32 %1, 18
  %346 = and i32 %345, 31
  %347 = or i32 %346, %221
  %348 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %347
  %349 = load <4 x i8> addrspace(3)* %348, align 4, !tbaa !10
  %350 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %349) #2
  %351 = add <4 x i32> %344, %350
  %352 = add nsw i32 %1, 19
  %353 = and i32 %352, 31
  %354 = or i32 %353, %221
  %355 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %354
  %356 = load <4 x i8> addrspace(3)* %355, align 4, !tbaa !10
  %357 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %356) #2
  %358 = add <4 x i32> %351, %357
  %359 = add nsw i32 %1, 20
  %360 = and i32 %359, 31
  %361 = or i32 %360, %221
  %362 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %361
  %363 = load <4 x i8> addrspace(3)* %362, align 4, !tbaa !10
  %364 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %363) #2
  %365 = add <4 x i32> %358, %364
  %366 = add nsw i32 %1, 21
  %367 = and i32 %366, 31
  %368 = or i32 %367, %221
  %369 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %368
  %370 = load <4 x i8> addrspace(3)* %369, align 4, !tbaa !10
  %371 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %370) #2
  %372 = add <4 x i32> %365, %371
  %373 = add nsw i32 %1, 22
  %374 = and i32 %373, 31
  %375 = or i32 %374, %221
  %376 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %375
  %377 = load <4 x i8> addrspace(3)* %376, align 4, !tbaa !10
  %378 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %377) #2
  %379 = add <4 x i32> %372, %378
  %380 = add nsw i32 %1, 23
  %381 = and i32 %380, 31
  %382 = or i32 %381, %221
  %383 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %382
  %384 = load <4 x i8> addrspace(3)* %383, align 4, !tbaa !10
  %385 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %384) #2
  %386 = add <4 x i32> %379, %385
  %387 = add nsw i32 %1, 24
  %388 = and i32 %387, 31
  %389 = or i32 %388, %221
  %390 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %389
  %391 = load <4 x i8> addrspace(3)* %390, align 4, !tbaa !10
  %392 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %391) #2
  %393 = add <4 x i32> %386, %392
  %394 = add nsw i32 %1, 25
  %395 = and i32 %394, 31
  %396 = or i32 %395, %221
  %397 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %396
  %398 = load <4 x i8> addrspace(3)* %397, align 4, !tbaa !10
  %399 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %398) #2
  %400 = add <4 x i32> %393, %399
  %401 = add nsw i32 %1, 26
  %402 = and i32 %401, 31
  %403 = or i32 %402, %221
  %404 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %403
  %405 = load <4 x i8> addrspace(3)* %404, align 4, !tbaa !10
  %406 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %405) #2
  %407 = add <4 x i32> %400, %406
  %408 = add nsw i32 %1, 27
  %409 = and i32 %408, 31
  %410 = or i32 %409, %221
  %411 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %410
  %412 = load <4 x i8> addrspace(3)* %411, align 4, !tbaa !10
  %413 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %412) #2
  %414 = add <4 x i32> %407, %413
  %415 = add nsw i32 %1, 28
  %416 = and i32 %415, 31
  %417 = or i32 %416, %221
  %418 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %417
  %419 = load <4 x i8> addrspace(3)* %418, align 4, !tbaa !10
  %420 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %419) #2
  %421 = add <4 x i32> %414, %420
  %422 = add nsw i32 %1, 29
  %423 = and i32 %422, 31
  %424 = or i32 %423, %221
  %425 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %424
  %426 = load <4 x i8> addrspace(3)* %425, align 4, !tbaa !10
  %427 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %426) #2
  %428 = add <4 x i32> %421, %427
  %429 = add nsw i32 %1, 30
  %430 = and i32 %429, 31
  %431 = or i32 %430, %221
  %432 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %431
  %433 = load <4 x i8> addrspace(3)* %432, align 4, !tbaa !10
  %434 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %433) #2
  %435 = add <4 x i32> %428, %434
  %436 = add nsw i32 %1, 31
  %437 = and i32 %436, 31
  %438 = or i32 %437, %221
  %439 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %438
  %440 = load <4 x i8> addrspace(3)* %439, align 4, !tbaa !10
  %441 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %440) #2
  %442 = add <4 x i32> %435, %441
  %443 = extractelement <4 x i32> %442, i32 0
  %444 = extractelement <4 x i32> %442, i32 1
  %445 = add i32 %443, %444
  %446 = extractelement <4 x i32> %442, i32 2
  %447 = add i32 %445, %446
  %448 = extractelement <4 x i32> %442, i32 3
  %449 = add i32 %447, %448
  %450 = mul i32 %i2.05, %4
  %451 = add i32 %217, %450
  %452 = getelementptr inbounds i32 addrspace(1)* %binResult, i32 %451
  store i32 %449, i32 addrspace(1)* %452, align 4, !tbaa !13
  %453 = add nuw nsw i32 %i2.05, 1
  %454 = icmp ult i32 %453, %213
  br i1 %454, label %219, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %219
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %212
  ret void
}

declare i32 @get_local_id(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_group_id(i32) #1

declare i32 @get_local_size(i32) #1

declare void @barrier(i32) #1

declare <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8>) #1

; Function Attrs: nounwind
define void @histogram256_scalar(i32 addrspace(1)* nocapture readonly %data, i8 addrspace(3)* nocapture %sharedArray, i32 addrspace(1)* nocapture %binResult) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 0) #2
  %3 = tail call i32 @get_group_id(i32 0) #2
  %4 = tail call i32 @get_local_size(i32 0) #2
  %5 = shl i32 %1, 2
  %6 = and i32 %5, 124
  %7 = bitcast i8 addrspace(3)* %sharedArray to <4 x i8> addrspace(3)*
  br label %8

; <label>:8                                       ; preds = %8, %0
  %i.08 = phi i32 [ 0, %0 ], [ %72, %8 ]
  %9 = mul i32 %i.08, %4
  %10 = add i32 %9, %1
  %11 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %10
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %11, align 4, !tbaa !10
  %12 = add nuw nsw i32 %i.08, 1
  %13 = mul i32 %12, %4
  %14 = add i32 %13, %1
  %15 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %14
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %15, align 4, !tbaa !10
  %16 = add nuw nsw i32 %12, 1
  %17 = mul i32 %16, %4
  %18 = add i32 %17, %1
  %19 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %18
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %19, align 4, !tbaa !10
  %20 = add nuw nsw i32 %16, 1
  %21 = mul i32 %20, %4
  %22 = add i32 %21, %1
  %23 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %22
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %23, align 4, !tbaa !10
  %24 = add nuw nsw i32 %20, 1
  %25 = mul i32 %24, %4
  %26 = add i32 %25, %1
  %27 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %26
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %27, align 4, !tbaa !10
  %28 = add nuw nsw i32 %24, 1
  %29 = mul i32 %28, %4
  %30 = add i32 %29, %1
  %31 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %30
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %31, align 4, !tbaa !10
  %32 = add nuw nsw i32 %28, 1
  %33 = mul i32 %32, %4
  %34 = add i32 %33, %1
  %35 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %34
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %35, align 4, !tbaa !10
  %36 = add nuw nsw i32 %32, 1
  %37 = mul i32 %36, %4
  %38 = add i32 %37, %1
  %39 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %38
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %39, align 4, !tbaa !10
  %40 = add nuw nsw i32 %36, 1
  %41 = mul i32 %40, %4
  %42 = add i32 %41, %1
  %43 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %42
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %43, align 4, !tbaa !10
  %44 = add nuw nsw i32 %40, 1
  %45 = mul i32 %44, %4
  %46 = add i32 %45, %1
  %47 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %46
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %47, align 4, !tbaa !10
  %48 = add nuw nsw i32 %44, 1
  %49 = mul i32 %48, %4
  %50 = add i32 %49, %1
  %51 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %50
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %51, align 4, !tbaa !10
  %52 = add nuw nsw i32 %48, 1
  %53 = mul i32 %52, %4
  %54 = add i32 %53, %1
  %55 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %54
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %55, align 4, !tbaa !10
  %56 = add nuw nsw i32 %52, 1
  %57 = mul i32 %56, %4
  %58 = add i32 %57, %1
  %59 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %58
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %59, align 4, !tbaa !10
  %60 = add nuw nsw i32 %56, 1
  %61 = mul i32 %60, %4
  %62 = add i32 %61, %1
  %63 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %62
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %63, align 4, !tbaa !10
  %64 = add nuw nsw i32 %60, 1
  %65 = mul i32 %64, %4
  %66 = add i32 %65, %1
  %67 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %66
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %67, align 4, !tbaa !10
  %68 = add nuw nsw i32 %64, 1
  %69 = mul i32 %68, %4
  %70 = add i32 %69, %1
  %71 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %70
  store <4 x i8> zeroinitializer, <4 x i8> addrspace(3)* %71, align 4, !tbaa !10
  %72 = add nuw nsw i32 %68, 1
  %exitcond10.15 = icmp eq i32 %72, 64
  br i1 %exitcond10.15, label %73, label %8

; <label>:73                                      ; preds = %8
  %74 = lshr i32 %1, 5
  tail call void @barrier(i32 1) #2
  %75 = shl i32 %3, 7
  br label %76

; <label>:76                                      ; preds = %76, %73
  %i1.07 = phi i32 [ 0, %73 ], [ %156, %76 ]
  %tmp = add i32 %i1.07, %75
  %tmp3 = mul i32 %tmp, %4
  %77 = add i32 %tmp3, %1
  %78 = getelementptr inbounds i32 addrspace(1)* %data, i32 %77
  %79 = load i32 addrspace(1)* %78, align 4, !tbaa !13
  %80 = shl i32 %79, 7
  %81 = or i32 %80, %6
  %82 = add i32 %81, %74
  %83 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %82
  %84 = load i8 addrspace(3)* %83, align 1, !tbaa !10
  %85 = add i8 %84, 1
  store i8 %85, i8 addrspace(3)* %83, align 1, !tbaa !10
  %86 = add nuw nsw i32 %i1.07, 1
  %tmp.1 = add i32 %86, %75
  %tmp3.1 = mul i32 %tmp.1, %4
  %87 = add i32 %tmp3.1, %1
  %88 = getelementptr inbounds i32 addrspace(1)* %data, i32 %87
  %89 = load i32 addrspace(1)* %88, align 4, !tbaa !13
  %90 = shl i32 %89, 7
  %91 = or i32 %90, %6
  %92 = add i32 %91, %74
  %93 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %92
  %94 = load i8 addrspace(3)* %93, align 1, !tbaa !10
  %95 = add i8 %94, 1
  store i8 %95, i8 addrspace(3)* %93, align 1, !tbaa !10
  %96 = add nuw nsw i32 %86, 1
  %tmp.2 = add i32 %96, %75
  %tmp3.2 = mul i32 %tmp.2, %4
  %97 = add i32 %tmp3.2, %1
  %98 = getelementptr inbounds i32 addrspace(1)* %data, i32 %97
  %99 = load i32 addrspace(1)* %98, align 4, !tbaa !13
  %100 = shl i32 %99, 7
  %101 = or i32 %100, %6
  %102 = add i32 %101, %74
  %103 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %102
  %104 = load i8 addrspace(3)* %103, align 1, !tbaa !10
  %105 = add i8 %104, 1
  store i8 %105, i8 addrspace(3)* %103, align 1, !tbaa !10
  %106 = add nuw nsw i32 %96, 1
  %tmp.3 = add i32 %106, %75
  %tmp3.3 = mul i32 %tmp.3, %4
  %107 = add i32 %tmp3.3, %1
  %108 = getelementptr inbounds i32 addrspace(1)* %data, i32 %107
  %109 = load i32 addrspace(1)* %108, align 4, !tbaa !13
  %110 = shl i32 %109, 7
  %111 = or i32 %110, %6
  %112 = add i32 %111, %74
  %113 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %112
  %114 = load i8 addrspace(3)* %113, align 1, !tbaa !10
  %115 = add i8 %114, 1
  store i8 %115, i8 addrspace(3)* %113, align 1, !tbaa !10
  %116 = add nuw nsw i32 %106, 1
  %tmp.4 = add i32 %116, %75
  %tmp3.4 = mul i32 %tmp.4, %4
  %117 = add i32 %tmp3.4, %1
  %118 = getelementptr inbounds i32 addrspace(1)* %data, i32 %117
  %119 = load i32 addrspace(1)* %118, align 4, !tbaa !13
  %120 = shl i32 %119, 7
  %121 = or i32 %120, %6
  %122 = add i32 %121, %74
  %123 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %122
  %124 = load i8 addrspace(3)* %123, align 1, !tbaa !10
  %125 = add i8 %124, 1
  store i8 %125, i8 addrspace(3)* %123, align 1, !tbaa !10
  %126 = add nuw nsw i32 %116, 1
  %tmp.5 = add i32 %126, %75
  %tmp3.5 = mul i32 %tmp.5, %4
  %127 = add i32 %tmp3.5, %1
  %128 = getelementptr inbounds i32 addrspace(1)* %data, i32 %127
  %129 = load i32 addrspace(1)* %128, align 4, !tbaa !13
  %130 = shl i32 %129, 7
  %131 = or i32 %130, %6
  %132 = add i32 %131, %74
  %133 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %132
  %134 = load i8 addrspace(3)* %133, align 1, !tbaa !10
  %135 = add i8 %134, 1
  store i8 %135, i8 addrspace(3)* %133, align 1, !tbaa !10
  %136 = add nuw nsw i32 %126, 1
  %tmp.6 = add i32 %136, %75
  %tmp3.6 = mul i32 %tmp.6, %4
  %137 = add i32 %tmp3.6, %1
  %138 = getelementptr inbounds i32 addrspace(1)* %data, i32 %137
  %139 = load i32 addrspace(1)* %138, align 4, !tbaa !13
  %140 = shl i32 %139, 7
  %141 = or i32 %140, %6
  %142 = add i32 %141, %74
  %143 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %142
  %144 = load i8 addrspace(3)* %143, align 1, !tbaa !10
  %145 = add i8 %144, 1
  store i8 %145, i8 addrspace(3)* %143, align 1, !tbaa !10
  %146 = add nuw nsw i32 %136, 1
  %tmp.7 = add i32 %146, %75
  %tmp3.7 = mul i32 %tmp.7, %4
  %147 = add i32 %tmp3.7, %1
  %148 = getelementptr inbounds i32 addrspace(1)* %data, i32 %147
  %149 = load i32 addrspace(1)* %148, align 4, !tbaa !13
  %150 = shl i32 %149, 7
  %151 = or i32 %150, %6
  %152 = add i32 %151, %74
  %153 = getelementptr inbounds i8 addrspace(3)* %sharedArray, i32 %152
  %154 = load i8 addrspace(3)* %153, align 1, !tbaa !10
  %155 = add i8 %154, 1
  store i8 %155, i8 addrspace(3)* %153, align 1, !tbaa !10
  %156 = add nuw nsw i32 %146, 1
  %exitcond9.7 = icmp eq i32 %156, 128
  br i1 %exitcond9.7, label %157, label %76

; <label>:157                                     ; preds = %76
  tail call void @barrier(i32 1) #2
  %158 = udiv i32 256, %4
  %159 = icmp eq i32 %158, 0
  br i1 %159, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %157
  %160 = shl i32 %1, 5
  %161 = shl i32 %3, 8
  %162 = add i32 %161, %1
  %163 = and i32 %1, 31
  br label %164

; <label>:164                                     ; preds = %.lr.ph, %164
  %i2.06 = phi i32 [ 0, %.lr.ph ], [ %398, %164 ]
  %165 = shl i32 %i2.06, 12
  %166 = add i32 %165, %160
  %167 = or i32 %163, %166
  %168 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %167
  %169 = load <4 x i8> addrspace(3)* %168, align 4, !tbaa !10
  %170 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %169) #2
  %171 = add nsw i32 %1, 1
  %172 = and i32 %171, 31
  %173 = or i32 %172, %166
  %174 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %173
  %175 = load <4 x i8> addrspace(3)* %174, align 4, !tbaa !10
  %176 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %175) #2
  %177 = add <4 x i32> %170, %176
  %178 = add nsw i32 %1, 2
  %179 = and i32 %178, 31
  %180 = or i32 %179, %166
  %181 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %180
  %182 = load <4 x i8> addrspace(3)* %181, align 4, !tbaa !10
  %183 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %182) #2
  %184 = add <4 x i32> %177, %183
  %185 = add nsw i32 %1, 3
  %186 = and i32 %185, 31
  %187 = or i32 %186, %166
  %188 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %187
  %189 = load <4 x i8> addrspace(3)* %188, align 4, !tbaa !10
  %190 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %189) #2
  %191 = add <4 x i32> %184, %190
  %192 = add nsw i32 %1, 4
  %193 = and i32 %192, 31
  %194 = or i32 %193, %166
  %195 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %194
  %196 = load <4 x i8> addrspace(3)* %195, align 4, !tbaa !10
  %197 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %196) #2
  %198 = add <4 x i32> %191, %197
  %199 = add nsw i32 %1, 5
  %200 = and i32 %199, 31
  %201 = or i32 %200, %166
  %202 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %201
  %203 = load <4 x i8> addrspace(3)* %202, align 4, !tbaa !10
  %204 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %203) #2
  %205 = add <4 x i32> %198, %204
  %206 = add nsw i32 %1, 6
  %207 = and i32 %206, 31
  %208 = or i32 %207, %166
  %209 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %208
  %210 = load <4 x i8> addrspace(3)* %209, align 4, !tbaa !10
  %211 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %210) #2
  %212 = add <4 x i32> %205, %211
  %213 = add nsw i32 %1, 7
  %214 = and i32 %213, 31
  %215 = or i32 %214, %166
  %216 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %215
  %217 = load <4 x i8> addrspace(3)* %216, align 4, !tbaa !10
  %218 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %217) #2
  %219 = add <4 x i32> %212, %218
  %220 = add nsw i32 %1, 8
  %221 = and i32 %220, 31
  %222 = or i32 %221, %166
  %223 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %222
  %224 = load <4 x i8> addrspace(3)* %223, align 4, !tbaa !10
  %225 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %224) #2
  %226 = add <4 x i32> %219, %225
  %227 = add nsw i32 %1, 9
  %228 = and i32 %227, 31
  %229 = or i32 %228, %166
  %230 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %229
  %231 = load <4 x i8> addrspace(3)* %230, align 4, !tbaa !10
  %232 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %231) #2
  %233 = add <4 x i32> %226, %232
  %234 = add nsw i32 %1, 10
  %235 = and i32 %234, 31
  %236 = or i32 %235, %166
  %237 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %236
  %238 = load <4 x i8> addrspace(3)* %237, align 4, !tbaa !10
  %239 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %238) #2
  %240 = add <4 x i32> %233, %239
  %241 = add nsw i32 %1, 11
  %242 = and i32 %241, 31
  %243 = or i32 %242, %166
  %244 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %243
  %245 = load <4 x i8> addrspace(3)* %244, align 4, !tbaa !10
  %246 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %245) #2
  %247 = add <4 x i32> %240, %246
  %248 = add nsw i32 %1, 12
  %249 = and i32 %248, 31
  %250 = or i32 %249, %166
  %251 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %250
  %252 = load <4 x i8> addrspace(3)* %251, align 4, !tbaa !10
  %253 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %252) #2
  %254 = add <4 x i32> %247, %253
  %255 = add nsw i32 %1, 13
  %256 = and i32 %255, 31
  %257 = or i32 %256, %166
  %258 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %257
  %259 = load <4 x i8> addrspace(3)* %258, align 4, !tbaa !10
  %260 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %259) #2
  %261 = add <4 x i32> %254, %260
  %262 = add nsw i32 %1, 14
  %263 = and i32 %262, 31
  %264 = or i32 %263, %166
  %265 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %264
  %266 = load <4 x i8> addrspace(3)* %265, align 4, !tbaa !10
  %267 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %266) #2
  %268 = add <4 x i32> %261, %267
  %269 = add nsw i32 %1, 15
  %270 = and i32 %269, 31
  %271 = or i32 %270, %166
  %272 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %271
  %273 = load <4 x i8> addrspace(3)* %272, align 4, !tbaa !10
  %274 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %273) #2
  %275 = add <4 x i32> %268, %274
  %276 = add nsw i32 %1, 16
  %277 = and i32 %276, 31
  %278 = or i32 %277, %166
  %279 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %278
  %280 = load <4 x i8> addrspace(3)* %279, align 4, !tbaa !10
  %281 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %280) #2
  %282 = add <4 x i32> %275, %281
  %283 = add nsw i32 %1, 17
  %284 = and i32 %283, 31
  %285 = or i32 %284, %166
  %286 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %285
  %287 = load <4 x i8> addrspace(3)* %286, align 4, !tbaa !10
  %288 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %287) #2
  %289 = add <4 x i32> %282, %288
  %290 = add nsw i32 %1, 18
  %291 = and i32 %290, 31
  %292 = or i32 %291, %166
  %293 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %292
  %294 = load <4 x i8> addrspace(3)* %293, align 4, !tbaa !10
  %295 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %294) #2
  %296 = add <4 x i32> %289, %295
  %297 = add nsw i32 %1, 19
  %298 = and i32 %297, 31
  %299 = or i32 %298, %166
  %300 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %299
  %301 = load <4 x i8> addrspace(3)* %300, align 4, !tbaa !10
  %302 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %301) #2
  %303 = add <4 x i32> %296, %302
  %304 = add nsw i32 %1, 20
  %305 = and i32 %304, 31
  %306 = or i32 %305, %166
  %307 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %306
  %308 = load <4 x i8> addrspace(3)* %307, align 4, !tbaa !10
  %309 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %308) #2
  %310 = add <4 x i32> %303, %309
  %311 = add nsw i32 %1, 21
  %312 = and i32 %311, 31
  %313 = or i32 %312, %166
  %314 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %313
  %315 = load <4 x i8> addrspace(3)* %314, align 4, !tbaa !10
  %316 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %315) #2
  %317 = add <4 x i32> %310, %316
  %318 = add nsw i32 %1, 22
  %319 = and i32 %318, 31
  %320 = or i32 %319, %166
  %321 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %320
  %322 = load <4 x i8> addrspace(3)* %321, align 4, !tbaa !10
  %323 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %322) #2
  %324 = add <4 x i32> %317, %323
  %325 = add nsw i32 %1, 23
  %326 = and i32 %325, 31
  %327 = or i32 %326, %166
  %328 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %327
  %329 = load <4 x i8> addrspace(3)* %328, align 4, !tbaa !10
  %330 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %329) #2
  %331 = add <4 x i32> %324, %330
  %332 = add nsw i32 %1, 24
  %333 = and i32 %332, 31
  %334 = or i32 %333, %166
  %335 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %334
  %336 = load <4 x i8> addrspace(3)* %335, align 4, !tbaa !10
  %337 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %336) #2
  %338 = add <4 x i32> %331, %337
  %339 = add nsw i32 %1, 25
  %340 = and i32 %339, 31
  %341 = or i32 %340, %166
  %342 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %341
  %343 = load <4 x i8> addrspace(3)* %342, align 4, !tbaa !10
  %344 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %343) #2
  %345 = add <4 x i32> %338, %344
  %346 = add nsw i32 %1, 26
  %347 = and i32 %346, 31
  %348 = or i32 %347, %166
  %349 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %348
  %350 = load <4 x i8> addrspace(3)* %349, align 4, !tbaa !10
  %351 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %350) #2
  %352 = add <4 x i32> %345, %351
  %353 = add nsw i32 %1, 27
  %354 = and i32 %353, 31
  %355 = or i32 %354, %166
  %356 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %355
  %357 = load <4 x i8> addrspace(3)* %356, align 4, !tbaa !10
  %358 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %357) #2
  %359 = add <4 x i32> %352, %358
  %360 = add nsw i32 %1, 28
  %361 = and i32 %360, 31
  %362 = or i32 %361, %166
  %363 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %362
  %364 = load <4 x i8> addrspace(3)* %363, align 4, !tbaa !10
  %365 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %364) #2
  %366 = add <4 x i32> %359, %365
  %367 = add nsw i32 %1, 29
  %368 = and i32 %367, 31
  %369 = or i32 %368, %166
  %370 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %369
  %371 = load <4 x i8> addrspace(3)* %370, align 4, !tbaa !10
  %372 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %371) #2
  %373 = add <4 x i32> %366, %372
  %374 = add nsw i32 %1, 30
  %375 = and i32 %374, 31
  %376 = or i32 %375, %166
  %377 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %376
  %378 = load <4 x i8> addrspace(3)* %377, align 4, !tbaa !10
  %379 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %378) #2
  %380 = add <4 x i32> %373, %379
  %381 = add nsw i32 %1, 31
  %382 = and i32 %381, 31
  %383 = or i32 %382, %166
  %384 = getelementptr inbounds <4 x i8> addrspace(3)* %7, i32 %383
  %385 = load <4 x i8> addrspace(3)* %384, align 4, !tbaa !10
  %386 = tail call <4 x i32> @_Z13convert_uint4Dv4_h(<4 x i8> %385) #2
  %387 = add <4 x i32> %380, %386
  %388 = extractelement <4 x i32> %387, i32 0
  %389 = extractelement <4 x i32> %387, i32 1
  %390 = add i32 %388, %389
  %391 = extractelement <4 x i32> %387, i32 2
  %392 = add i32 %390, %391
  %393 = extractelement <4 x i32> %387, i32 3
  %394 = add i32 %392, %393
  %395 = mul i32 %i2.06, %4
  %396 = add i32 %162, %395
  %397 = getelementptr inbounds i32 addrspace(1)* %binResult, i32 %396
  store i32 %394, i32 addrspace(1)* %397, align 4, !tbaa !13
  %398 = add nuw nsw i32 %i2.06, 1
  %399 = icmp ult i32 %398, %158
  br i1 %399, label %164, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %164
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %157
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6}
!llvm.ident = !{!9}

!0 = !{void (<4 x i32> addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_vector, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 3, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uint4*", !"uchar*", !"uint*"}
!4 = !{!"kernel_arg_base_type", !"uint __attribute__((ext_vector_type(4)))*", !"uchar*", !"uint*"}
!5 = !{!"kernel_arg_type_qual", !"const", !"", !""}
!6 = !{void (i32 addrspace(1)*, i8 addrspace(3)*, i32 addrspace(1)*)* @histogram256_scalar, !1, !2, !7, !8, !5}
!7 = !{!"kernel_arg_type", !"uint*", !"uchar*", !"uint*"}
!8 = !{!"kernel_arg_base_type", !"uint*", !"uchar*", !"uint*"}
!9 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!10 = !{!11, !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{!14, !14, i64 0}
!14 = !{!"int", !11, i64 0}

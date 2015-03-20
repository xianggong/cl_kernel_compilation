; ModuleID = '../kernel-src/NBody_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

; Function Attrs: nounwind
define void @nbody_sim(<4 x float> addrspace(1)* nocapture readonly %pos, <4 x float> addrspace(1)* nocapture readonly %vel, i32 %numBodies, float %deltaTime, float %epsSqr, <4 x float> addrspace(1)* nocapture %newPosition, <4 x float> addrspace(1)* nocapture %newVelocity) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #3
  %2 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %1
  %3 = load <4 x float> addrspace(1)* %2, align 16, !tbaa !7
  %4 = icmp sgt i32 %numBodies, 8
  br i1 %4, label %.preheader7.preheader, label %.preheader

.preheader7.preheader:                            ; preds = %0
  br label %.preheader7

.preheader7:                                      ; preds = %.preheader7.preheader, %.preheader7
  %indvars.iv = phi i32 [ %indvars.iv.next, %.preheader7 ], [ 7, %.preheader7.preheader ]
  %acc.014 = phi <4 x float> [ %203, %.preheader7 ], [ zeroinitializer, %.preheader7.preheader ]
  %i.013 = phi i32 [ %204, %.preheader7 ], [ 0, %.preheader7.preheader ]
  %5 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %i.013
  %6 = load <4 x float> addrspace(1)* %5, align 16, !tbaa !7
  %7 = fsub <4 x float> %6, %3
  %8 = extractelement <4 x float> %7, i32 0
  %9 = extractelement <4 x float> %7, i32 1
  %10 = fmul float %9, %9
  %11 = tail call float @llvm.fmuladd.f32(float %8, float %8, float %10)
  %12 = extractelement <4 x float> %7, i32 2
  %13 = tail call float @llvm.fmuladd.f32(float %12, float %12, float %11)
  %14 = fadd float %13, %epsSqr
  %15 = tail call float @llvm.sqrt.f32(float %14)
  %16 = fdiv float 1.000000e+00, %15, !fpmath !10
  %17 = fmul float %16, %16
  %18 = fmul float %16, %17
  %19 = extractelement <4 x float> %6, i32 3
  %20 = fmul float %19, %18
  %21 = insertelement <3 x float> undef, float %20, i32 0
  %22 = shufflevector <3 x float> %21, <3 x float> undef, <3 x i32> zeroinitializer
  %23 = shufflevector <4 x float> %7, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %24 = fmul <3 x float> %23, %22
  %25 = shufflevector <4 x float> %acc.014, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %26 = fadd <3 x float> %25, %24
  %27 = shufflevector <3 x float> %26, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %28 = shufflevector <4 x float> %acc.014, <4 x float> %27, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %29 = or i32 %i.013, 1
  %30 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %29
  %31 = load <4 x float> addrspace(1)* %30, align 16, !tbaa !7
  %32 = fsub <4 x float> %31, %3
  %33 = extractelement <4 x float> %32, i32 0
  %34 = extractelement <4 x float> %32, i32 1
  %35 = fmul float %34, %34
  %36 = tail call float @llvm.fmuladd.f32(float %33, float %33, float %35)
  %37 = extractelement <4 x float> %32, i32 2
  %38 = tail call float @llvm.fmuladd.f32(float %37, float %37, float %36)
  %39 = fadd float %38, %epsSqr
  %40 = tail call float @llvm.sqrt.f32(float %39)
  %41 = fdiv float 1.000000e+00, %40, !fpmath !10
  %42 = fmul float %41, %41
  %43 = fmul float %41, %42
  %44 = extractelement <4 x float> %31, i32 3
  %45 = fmul float %44, %43
  %46 = insertelement <3 x float> undef, float %45, i32 0
  %47 = shufflevector <3 x float> %46, <3 x float> undef, <3 x i32> zeroinitializer
  %48 = shufflevector <4 x float> %32, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %49 = fmul <3 x float> %48, %47
  %50 = shufflevector <4 x float> %28, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %51 = fadd <3 x float> %50, %49
  %52 = shufflevector <3 x float> %51, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %53 = shufflevector <4 x float> %28, <4 x float> %52, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %54 = add nsw i32 %29, 1
  %55 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %54
  %56 = load <4 x float> addrspace(1)* %55, align 16, !tbaa !7
  %57 = fsub <4 x float> %56, %3
  %58 = extractelement <4 x float> %57, i32 0
  %59 = extractelement <4 x float> %57, i32 1
  %60 = fmul float %59, %59
  %61 = tail call float @llvm.fmuladd.f32(float %58, float %58, float %60)
  %62 = extractelement <4 x float> %57, i32 2
  %63 = tail call float @llvm.fmuladd.f32(float %62, float %62, float %61)
  %64 = fadd float %63, %epsSqr
  %65 = tail call float @llvm.sqrt.f32(float %64)
  %66 = fdiv float 1.000000e+00, %65, !fpmath !10
  %67 = fmul float %66, %66
  %68 = fmul float %66, %67
  %69 = extractelement <4 x float> %56, i32 3
  %70 = fmul float %69, %68
  %71 = insertelement <3 x float> undef, float %70, i32 0
  %72 = shufflevector <3 x float> %71, <3 x float> undef, <3 x i32> zeroinitializer
  %73 = shufflevector <4 x float> %57, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %74 = fmul <3 x float> %73, %72
  %75 = shufflevector <4 x float> %53, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %76 = fadd <3 x float> %75, %74
  %77 = shufflevector <3 x float> %76, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %78 = shufflevector <4 x float> %53, <4 x float> %77, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %79 = or i32 %i.013, 3
  %80 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %79
  %81 = load <4 x float> addrspace(1)* %80, align 16, !tbaa !7
  %82 = fsub <4 x float> %81, %3
  %83 = extractelement <4 x float> %82, i32 0
  %84 = extractelement <4 x float> %82, i32 1
  %85 = fmul float %84, %84
  %86 = tail call float @llvm.fmuladd.f32(float %83, float %83, float %85)
  %87 = extractelement <4 x float> %82, i32 2
  %88 = tail call float @llvm.fmuladd.f32(float %87, float %87, float %86)
  %89 = fadd float %88, %epsSqr
  %90 = tail call float @llvm.sqrt.f32(float %89)
  %91 = fdiv float 1.000000e+00, %90, !fpmath !10
  %92 = fmul float %91, %91
  %93 = fmul float %91, %92
  %94 = extractelement <4 x float> %81, i32 3
  %95 = fmul float %94, %93
  %96 = insertelement <3 x float> undef, float %95, i32 0
  %97 = shufflevector <3 x float> %96, <3 x float> undef, <3 x i32> zeroinitializer
  %98 = shufflevector <4 x float> %82, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %99 = fmul <3 x float> %98, %97
  %100 = shufflevector <4 x float> %78, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %101 = fadd <3 x float> %100, %99
  %102 = shufflevector <3 x float> %101, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %103 = shufflevector <4 x float> %78, <4 x float> %102, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %104 = add nsw i32 %79, 1
  %105 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %104
  %106 = load <4 x float> addrspace(1)* %105, align 16, !tbaa !7
  %107 = fsub <4 x float> %106, %3
  %108 = extractelement <4 x float> %107, i32 0
  %109 = extractelement <4 x float> %107, i32 1
  %110 = fmul float %109, %109
  %111 = tail call float @llvm.fmuladd.f32(float %108, float %108, float %110)
  %112 = extractelement <4 x float> %107, i32 2
  %113 = tail call float @llvm.fmuladd.f32(float %112, float %112, float %111)
  %114 = fadd float %113, %epsSqr
  %115 = tail call float @llvm.sqrt.f32(float %114)
  %116 = fdiv float 1.000000e+00, %115, !fpmath !10
  %117 = fmul float %116, %116
  %118 = fmul float %116, %117
  %119 = extractelement <4 x float> %106, i32 3
  %120 = fmul float %119, %118
  %121 = insertelement <3 x float> undef, float %120, i32 0
  %122 = shufflevector <3 x float> %121, <3 x float> undef, <3 x i32> zeroinitializer
  %123 = shufflevector <4 x float> %107, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %124 = fmul <3 x float> %123, %122
  %125 = shufflevector <4 x float> %103, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %126 = fadd <3 x float> %125, %124
  %127 = shufflevector <3 x float> %126, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %128 = shufflevector <4 x float> %103, <4 x float> %127, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %129 = add nsw i32 %79, 2
  %130 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %129
  %131 = load <4 x float> addrspace(1)* %130, align 16, !tbaa !7
  %132 = fsub <4 x float> %131, %3
  %133 = extractelement <4 x float> %132, i32 0
  %134 = extractelement <4 x float> %132, i32 1
  %135 = fmul float %134, %134
  %136 = tail call float @llvm.fmuladd.f32(float %133, float %133, float %135)
  %137 = extractelement <4 x float> %132, i32 2
  %138 = tail call float @llvm.fmuladd.f32(float %137, float %137, float %136)
  %139 = fadd float %138, %epsSqr
  %140 = tail call float @llvm.sqrt.f32(float %139)
  %141 = fdiv float 1.000000e+00, %140, !fpmath !10
  %142 = fmul float %141, %141
  %143 = fmul float %141, %142
  %144 = extractelement <4 x float> %131, i32 3
  %145 = fmul float %144, %143
  %146 = insertelement <3 x float> undef, float %145, i32 0
  %147 = shufflevector <3 x float> %146, <3 x float> undef, <3 x i32> zeroinitializer
  %148 = shufflevector <4 x float> %132, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %149 = fmul <3 x float> %148, %147
  %150 = shufflevector <4 x float> %128, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %151 = fadd <3 x float> %150, %149
  %152 = shufflevector <3 x float> %151, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %153 = shufflevector <4 x float> %128, <4 x float> %152, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %154 = add nsw i32 %79, 3
  %155 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %154
  %156 = load <4 x float> addrspace(1)* %155, align 16, !tbaa !7
  %157 = fsub <4 x float> %156, %3
  %158 = extractelement <4 x float> %157, i32 0
  %159 = extractelement <4 x float> %157, i32 1
  %160 = fmul float %159, %159
  %161 = tail call float @llvm.fmuladd.f32(float %158, float %158, float %160)
  %162 = extractelement <4 x float> %157, i32 2
  %163 = tail call float @llvm.fmuladd.f32(float %162, float %162, float %161)
  %164 = fadd float %163, %epsSqr
  %165 = tail call float @llvm.sqrt.f32(float %164)
  %166 = fdiv float 1.000000e+00, %165, !fpmath !10
  %167 = fmul float %166, %166
  %168 = fmul float %166, %167
  %169 = extractelement <4 x float> %156, i32 3
  %170 = fmul float %169, %168
  %171 = insertelement <3 x float> undef, float %170, i32 0
  %172 = shufflevector <3 x float> %171, <3 x float> undef, <3 x i32> zeroinitializer
  %173 = shufflevector <4 x float> %157, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %174 = fmul <3 x float> %173, %172
  %175 = shufflevector <4 x float> %153, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %176 = fadd <3 x float> %175, %174
  %177 = shufflevector <3 x float> %176, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %178 = shufflevector <4 x float> %153, <4 x float> %177, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %179 = or i32 %i.013, 7
  %180 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %179
  %181 = load <4 x float> addrspace(1)* %180, align 16, !tbaa !7
  %182 = fsub <4 x float> %181, %3
  %183 = extractelement <4 x float> %182, i32 0
  %184 = extractelement <4 x float> %182, i32 1
  %185 = fmul float %184, %184
  %186 = tail call float @llvm.fmuladd.f32(float %183, float %183, float %185)
  %187 = extractelement <4 x float> %182, i32 2
  %188 = tail call float @llvm.fmuladd.f32(float %187, float %187, float %186)
  %189 = fadd float %188, %epsSqr
  %190 = tail call float @llvm.sqrt.f32(float %189)
  %191 = fdiv float 1.000000e+00, %190, !fpmath !10
  %192 = fmul float %191, %191
  %193 = fmul float %191, %192
  %194 = extractelement <4 x float> %181, i32 3
  %195 = fmul float %194, %193
  %196 = insertelement <3 x float> undef, float %195, i32 0
  %197 = shufflevector <3 x float> %196, <3 x float> undef, <3 x i32> zeroinitializer
  %198 = shufflevector <4 x float> %182, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %199 = fmul <3 x float> %198, %197
  %200 = shufflevector <4 x float> %178, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %201 = fadd <3 x float> %200, %199
  %202 = shufflevector <3 x float> %201, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %203 = shufflevector <4 x float> %178, <4 x float> %202, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %204 = add i32 %i.013, 8
  %205 = add nsw i32 %indvars.iv, 9
  %206 = icmp slt i32 %205, %numBodies
  %indvars.iv.next = add i32 %indvars.iv, 8
  br i1 %206, label %.preheader7, label %.preheader.loopexit

.preheader.loopexit:                              ; preds = %.preheader7
  %.lcssa24 = phi i32 [ %204, %.preheader7 ]
  %.lcssa23 = phi <4 x float> [ %203, %.preheader7 ]
  br label %.preheader

.preheader:                                       ; preds = %.preheader.loopexit, %0
  %acc.0.lcssa = phi <4 x float> [ zeroinitializer, %0 ], [ %.lcssa23, %.preheader.loopexit ]
  %i.0.lcssa = phi i32 [ 0, %0 ], [ %.lcssa24, %.preheader.loopexit ]
  %207 = icmp slt i32 %i.0.lcssa, %numBodies
  br i1 %207, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.preheader
  %208 = add i32 %numBodies, -1
  br label %209

; <label>:209                                     ; preds = %209, %.lr.ph
  %acc.29 = phi <4 x float> [ %acc.0.lcssa, %.lr.ph ], [ %233, %209 ]
  %i.28 = phi i32 [ %i.0.lcssa, %.lr.ph ], [ %234, %209 ]
  %210 = getelementptr inbounds <4 x float> addrspace(1)* %pos, i32 %i.28
  %211 = load <4 x float> addrspace(1)* %210, align 16, !tbaa !7
  %212 = fsub <4 x float> %211, %3
  %213 = extractelement <4 x float> %212, i32 0
  %214 = extractelement <4 x float> %212, i32 1
  %215 = fmul float %214, %214
  %216 = tail call float @llvm.fmuladd.f32(float %213, float %213, float %215)
  %217 = extractelement <4 x float> %212, i32 2
  %218 = tail call float @llvm.fmuladd.f32(float %217, float %217, float %216)
  %219 = fadd float %218, %epsSqr
  %220 = tail call float @llvm.sqrt.f32(float %219)
  %221 = fdiv float 1.000000e+00, %220, !fpmath !10
  %222 = fmul float %221, %221
  %223 = fmul float %221, %222
  %224 = extractelement <4 x float> %211, i32 3
  %225 = fmul float %224, %223
  %226 = insertelement <3 x float> undef, float %225, i32 0
  %227 = shufflevector <3 x float> %226, <3 x float> undef, <3 x i32> zeroinitializer
  %228 = shufflevector <4 x float> %212, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %229 = fmul <3 x float> %228, %227
  %230 = shufflevector <4 x float> %acc.29, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %231 = fadd <3 x float> %230, %229
  %232 = shufflevector <3 x float> %231, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %233 = shufflevector <4 x float> %acc.29, <4 x float> %232, <4 x i32> <i32 4, i32 5, i32 6, i32 3>
  %234 = add nsw i32 %i.28, 1
  %exitcond = icmp eq i32 %i.28, %208
  br i1 %exitcond, label %._crit_edge.loopexit, label %209

._crit_edge.loopexit:                             ; preds = %209
  %.lcssa = phi <4 x float> [ %233, %209 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.preheader
  %acc.2.lcssa = phi <4 x float> [ %acc.0.lcssa, %.preheader ], [ %.lcssa, %._crit_edge.loopexit ]
  %235 = getelementptr inbounds <4 x float> addrspace(1)* %vel, i32 %1
  %236 = load <4 x float> addrspace(1)* %235, align 16, !tbaa !7
  %237 = shufflevector <4 x float> %3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %238 = shufflevector <4 x float> %236, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %239 = insertelement <3 x float> undef, float %deltaTime, i32 0
  %240 = shufflevector <3 x float> %239, <3 x float> undef, <3 x i32> zeroinitializer
  %241 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %238, <3 x float> %240, <3 x float> %237)
  %242 = shufflevector <4 x float> %acc.2.lcssa, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %243 = fmul <3 x float> %242, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %244 = fmul <3 x float> %240, %243
  %245 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %244, <3 x float> %240, <3 x float> %241)
  %246 = shufflevector <3 x float> %245, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %247 = shufflevector <4 x float> %246, <4 x float> %3, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %248 = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> %242, <3 x float> %240, <3 x float> %238)
  %249 = shufflevector <3 x float> %248, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 undef>
  %250 = shufflevector <4 x float> %249, <4 x float> %236, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %251 = getelementptr inbounds <4 x float> addrspace(1)* %newPosition, i32 %1
  store <4 x float> %247, <4 x float> addrspace(1)* %251, align 16, !tbaa !7
  %252 = getelementptr inbounds <4 x float> addrspace(1)* %newVelocity, i32 %1
  store <4 x float> %250, <4 x float> addrspace(1)* %252, align 16, !tbaa !7
  ret void
}

declare i32 @get_global_id(i32) #1

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: nounwind readnone
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nounwind readnone
declare <3 x float> @llvm.fmuladd.v3f32(<3 x float>, <3 x float>, <3 x float>) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*, i32, float, float, <4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @nbody_sim, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0, i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float4*", !"float4*", !"int", !"float", !"float", !"float4*", !"float4*"}
!4 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"int", !"float", !"float", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !"", !"", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{float 2.500000e+00}

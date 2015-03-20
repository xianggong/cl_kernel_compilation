; ModuleID = '../kernel-src/URNG_Kernels.cl'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn"

@noise_uniform.iv = internal addrspace(3) global [1024 x i32] undef, align 4

; Function Attrs: nounwind
define float @ran1(i32 %idum, i32 addrspace(3)* nocapture %iv) #0 {
  %1 = tail call i32 @get_local_id(i32 0) #2
  %2 = tail call i32 @get_local_id(i32 1) #2
  %3 = tail call i32 @get_local_size(i32 0) #2
  %4 = mul i32 %3, %2
  %5 = add i32 %4, %1
  %6 = shl i32 %5, 4
  %7 = sdiv i32 %idum, 127773
  %8 = mul i32 %7, -127773
  %9 = add i32 %8, %idum
  %10 = mul nsw i32 %9, 16807
  %11 = mul i32 %7, -2836
  %12 = add i32 %10, %11
  %13 = icmp slt i32 %12, 0
  %14 = add nsw i32 %12, 2147483647
  %. = select i1 %13, i32 %14, i32 %12
  %15 = sdiv i32 %., 127773
  %16 = mul i32 %15, -127773
  %17 = add i32 %., %16
  %18 = mul nsw i32 %17, 16807
  %19 = mul i32 %15, -2836
  %20 = add i32 %18, %19
  %21 = icmp slt i32 %20, 0
  %22 = add nsw i32 %20, 2147483647
  %..1 = select i1 %21, i32 %22, i32 %20
  %23 = or i32 %6, 15
  %24 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %23
  store i32 %..1, i32 addrspace(3)* %24, align 4, !tbaa !7
  %25 = sdiv i32 %..1, 127773
  %26 = mul i32 %25, -127773
  %27 = add i32 %..1, %26
  %28 = mul nsw i32 %27, 16807
  %29 = mul i32 %25, -2836
  %30 = add i32 %28, %29
  %31 = icmp slt i32 %30, 0
  %32 = add nsw i32 %30, 2147483647
  %..2 = select i1 %31, i32 %32, i32 %30
  %33 = or i32 %6, 14
  %34 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %33
  store i32 %..2, i32 addrspace(3)* %34, align 4, !tbaa !7
  %35 = sdiv i32 %..2, 127773
  %36 = mul i32 %35, -127773
  %37 = add i32 %..2, %36
  %38 = mul nsw i32 %37, 16807
  %39 = mul i32 %35, -2836
  %40 = add i32 %38, %39
  %41 = icmp slt i32 %40, 0
  %42 = add nsw i32 %40, 2147483647
  %..3 = select i1 %41, i32 %42, i32 %40
  %43 = or i32 %6, 13
  %44 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %43
  store i32 %..3, i32 addrspace(3)* %44, align 4, !tbaa !7
  %45 = sdiv i32 %..3, 127773
  %46 = mul i32 %45, -127773
  %47 = add i32 %..3, %46
  %48 = mul nsw i32 %47, 16807
  %49 = mul i32 %45, -2836
  %50 = add i32 %48, %49
  %51 = icmp slt i32 %50, 0
  %52 = add nsw i32 %50, 2147483647
  %..4 = select i1 %51, i32 %52, i32 %50
  %53 = or i32 %6, 12
  %54 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %53
  store i32 %..4, i32 addrspace(3)* %54, align 4, !tbaa !7
  %55 = sdiv i32 %..4, 127773
  %56 = mul i32 %55, -127773
  %57 = add i32 %..4, %56
  %58 = mul nsw i32 %57, 16807
  %59 = mul i32 %55, -2836
  %60 = add i32 %58, %59
  %61 = icmp slt i32 %60, 0
  %62 = add nsw i32 %60, 2147483647
  %..5 = select i1 %61, i32 %62, i32 %60
  %63 = or i32 %6, 11
  %64 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %63
  store i32 %..5, i32 addrspace(3)* %64, align 4, !tbaa !7
  %65 = sdiv i32 %..5, 127773
  %66 = mul i32 %65, -127773
  %67 = add i32 %..5, %66
  %68 = mul nsw i32 %67, 16807
  %69 = mul i32 %65, -2836
  %70 = add i32 %68, %69
  %71 = icmp slt i32 %70, 0
  %72 = add nsw i32 %70, 2147483647
  %..6 = select i1 %71, i32 %72, i32 %70
  %73 = or i32 %6, 10
  %74 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %73
  store i32 %..6, i32 addrspace(3)* %74, align 4, !tbaa !7
  %75 = sdiv i32 %..6, 127773
  %76 = mul i32 %75, -127773
  %77 = add i32 %..6, %76
  %78 = mul nsw i32 %77, 16807
  %79 = mul i32 %75, -2836
  %80 = add i32 %78, %79
  %81 = icmp slt i32 %80, 0
  %82 = add nsw i32 %80, 2147483647
  %..7 = select i1 %81, i32 %82, i32 %80
  %83 = or i32 %6, 9
  %84 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %83
  store i32 %..7, i32 addrspace(3)* %84, align 4, !tbaa !7
  %85 = sdiv i32 %..7, 127773
  %86 = mul i32 %85, -127773
  %87 = add i32 %..7, %86
  %88 = mul nsw i32 %87, 16807
  %89 = mul i32 %85, -2836
  %90 = add i32 %88, %89
  %91 = icmp slt i32 %90, 0
  %92 = add nsw i32 %90, 2147483647
  %..8 = select i1 %91, i32 %92, i32 %90
  %93 = or i32 %6, 8
  %94 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %93
  store i32 %..8, i32 addrspace(3)* %94, align 4, !tbaa !7
  %95 = sdiv i32 %..8, 127773
  %96 = mul i32 %95, -127773
  %97 = add i32 %..8, %96
  %98 = mul nsw i32 %97, 16807
  %99 = mul i32 %95, -2836
  %100 = add i32 %98, %99
  %101 = icmp slt i32 %100, 0
  %102 = add nsw i32 %100, 2147483647
  %..9 = select i1 %101, i32 %102, i32 %100
  %103 = or i32 %6, 7
  %104 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %103
  store i32 %..9, i32 addrspace(3)* %104, align 4, !tbaa !7
  %105 = sdiv i32 %..9, 127773
  %106 = mul i32 %105, -127773
  %107 = add i32 %..9, %106
  %108 = mul nsw i32 %107, 16807
  %109 = mul i32 %105, -2836
  %110 = add i32 %108, %109
  %111 = icmp slt i32 %110, 0
  %112 = add nsw i32 %110, 2147483647
  %..10 = select i1 %111, i32 %112, i32 %110
  %113 = or i32 %6, 6
  %114 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %113
  store i32 %..10, i32 addrspace(3)* %114, align 4, !tbaa !7
  %115 = sdiv i32 %..10, 127773
  %116 = mul i32 %115, -127773
  %117 = add i32 %..10, %116
  %118 = mul nsw i32 %117, 16807
  %119 = mul i32 %115, -2836
  %120 = add i32 %118, %119
  %121 = icmp slt i32 %120, 0
  %122 = add nsw i32 %120, 2147483647
  %..11 = select i1 %121, i32 %122, i32 %120
  %123 = or i32 %6, 5
  %124 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %123
  store i32 %..11, i32 addrspace(3)* %124, align 4, !tbaa !7
  %125 = sdiv i32 %..11, 127773
  %126 = mul i32 %125, -127773
  %127 = add i32 %..11, %126
  %128 = mul nsw i32 %127, 16807
  %129 = mul i32 %125, -2836
  %130 = add i32 %128, %129
  %131 = icmp slt i32 %130, 0
  %132 = add nsw i32 %130, 2147483647
  %..12 = select i1 %131, i32 %132, i32 %130
  %133 = or i32 %6, 4
  %134 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %133
  store i32 %..12, i32 addrspace(3)* %134, align 4, !tbaa !7
  %135 = sdiv i32 %..12, 127773
  %136 = mul i32 %135, -127773
  %137 = add i32 %..12, %136
  %138 = mul nsw i32 %137, 16807
  %139 = mul i32 %135, -2836
  %140 = add i32 %138, %139
  %141 = icmp slt i32 %140, 0
  %142 = add nsw i32 %140, 2147483647
  %..13 = select i1 %141, i32 %142, i32 %140
  %143 = or i32 %6, 3
  %144 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %143
  store i32 %..13, i32 addrspace(3)* %144, align 4, !tbaa !7
  %145 = sdiv i32 %..13, 127773
  %146 = mul i32 %145, -127773
  %147 = add i32 %..13, %146
  %148 = mul nsw i32 %147, 16807
  %149 = mul i32 %145, -2836
  %150 = add i32 %148, %149
  %151 = icmp slt i32 %150, 0
  %152 = add nsw i32 %150, 2147483647
  %..14 = select i1 %151, i32 %152, i32 %150
  %153 = or i32 %6, 2
  %154 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %153
  store i32 %..14, i32 addrspace(3)* %154, align 4, !tbaa !7
  %155 = sdiv i32 %..14, 127773
  %156 = mul i32 %155, -127773
  %157 = add i32 %..14, %156
  %158 = mul nsw i32 %157, 16807
  %159 = mul i32 %155, -2836
  %160 = add i32 %158, %159
  %161 = icmp slt i32 %160, 0
  %162 = add nsw i32 %160, 2147483647
  %..15 = select i1 %161, i32 %162, i32 %160
  %163 = or i32 %6, 1
  %164 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %163
  store i32 %..15, i32 addrspace(3)* %164, align 4, !tbaa !7
  %165 = sdiv i32 %..15, 127773
  %166 = mul i32 %165, -127773
  %167 = add i32 %..15, %166
  %168 = mul nsw i32 %167, 16807
  %169 = mul i32 %165, -2836
  %170 = add i32 %168, %169
  %171 = icmp slt i32 %170, 0
  %172 = add nsw i32 %170, 2147483647
  %..16 = select i1 %171, i32 %172, i32 %170
  %173 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %6
  store i32 %..16, i32 addrspace(3)* %173, align 4, !tbaa !7
  %174 = sdiv i32 %..16, 134217728
  %175 = add nsw i32 %174, %6
  %176 = getelementptr inbounds i32 addrspace(3)* %iv, i32 %175
  %177 = load i32 addrspace(3)* %176, align 4, !tbaa !7
  %178 = sitofp i32 %177 to float
  %179 = fmul float %178, 0x3E00000000000000
  ret float %179
}

declare i32 @get_local_id(i32) #1

declare i32 @get_local_size(i32) #1

; Function Attrs: nounwind
define void @noise_uniform(<4 x i8> addrspace(1)* nocapture readonly %inputImage, <4 x i8> addrspace(1)* nocapture %outputImage, i32 %factor) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = tail call i32 @get_global_size(i32 0) #2
  %4 = mul i32 %3, %2
  %5 = add i32 %4, %1
  %6 = getelementptr inbounds <4 x i8> addrspace(1)* %inputImage, i32 %5
  %7 = load <4 x i8> addrspace(1)* %6, align 4, !tbaa !11
  %8 = tail call <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %7) #2
  %9 = extractelement <4 x float> %8, i32 0
  %10 = extractelement <4 x float> %8, i32 1
  %11 = fadd float %9, %10
  %12 = extractelement <4 x float> %8, i32 2
  %13 = fadd float %12, %11
  %14 = fadd float %10, %13
  %15 = fmul float %14, 2.500000e-01
  %16 = fsub float -0.000000e+00, %15
  %17 = fptosi float %16 to i32
  %18 = tail call float @ran1(i32 %17, i32 addrspace(3)* getelementptr inbounds ([1024 x i32] addrspace(3)* @noise_uniform.iv, i32 0, i32 0))
  %19 = fadd float %18, 0xBFE19999A0000000
  %20 = sitofp i32 %factor to float
  %21 = fmul float %20, %19
  %22 = insertelement <4 x float> undef, float %21, i32 0
  %23 = shufflevector <4 x float> %22, <4 x float> undef, <4 x i32> zeroinitializer
  %24 = fadd <4 x float> %8, %23
  %25 = tail call <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float> %24) #2
  %26 = getelementptr inbounds <4 x i8> addrspace(1)* %outputImage, i32 %5
  store <4 x i8> %25, <4 x i8> addrspace(1)* %26, align 4, !tbaa !11
  ret void
}

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8>) #1

declare <4 x i8> @_Z18convert_uchar4_satDv4_f(<4 x float>) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (<4 x i8> addrspace(1)*, <4 x i8> addrspace(1)*, i32)* @noise_uniform, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"uchar4*", !"uchar4*", !"int"}
!4 = !{!"kernel_arg_base_type", !"uchar __attribute__((ext_vector_type(4)))*", !"uchar __attribute__((ext_vector_type(4)))*", !"int"}
!5 = !{!"kernel_arg_type_qual", !"", !"", !""}
!6 = !{!"Ubuntu clang version 3.6.1-svn232753-1~exp1 (branches/release_36) (based on LLVM 3.6.1)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{!9, !9, i64 0}

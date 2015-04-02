; ModuleID = 'BasicDebug_Kernel.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@.str = private unnamed_addr constant [36 x i8] c"Output vector data: f4 = %2.2v4hlf\0A\00", align 1
@printfKernel.data = internal addrspace(3) global [10 x i32] zeroinitializer, align 4
@.str1 = private unnamed_addr constant [19 x i8] c"\09This is group %d\0A\00", align 1
@.str2 = private unnamed_addr constant [23 x i8] c"\09Output LDS data:  %d\0A\00", align 1
@.str3 = private unnamed_addr constant [38 x i8] c"the global ID of this thread is : %d\0A\00", align 1

; Function Attrs: nounwind
define cc76 void @__OpenCL_printfKernel_kernel(float addrspace(1)* %inputbuffer) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %cmp = icmp eq i32 10, %conv
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %arrayidx = getelementptr inbounds float addrspace(1)* %inputbuffer, i64 0
  %0 = load float addrspace(1)* %arrayidx, align 4
  %vecinit = insertelement <4 x float> undef, float %0, i32 0
  %arrayidx6 = getelementptr inbounds float addrspace(1)* %inputbuffer, i64 1
  %1 = load float addrspace(1)* %arrayidx6, align 4
  %vecinit7 = insertelement <4 x float> %vecinit, float %1, i32 1
  %arrayidx8 = getelementptr inbounds float addrspace(1)* %inputbuffer, i64 2
  %2 = load float addrspace(1)* %arrayidx8, align 4
  %vecinit9 = insertelement <4 x float> %vecinit7, float %2, i32 2
  %arrayidx10 = getelementptr inbounds float addrspace(1)* %inputbuffer, i64 3
  %3 = load float addrspace(1)* %arrayidx10, align 4
  %vecinit11 = insertelement <4 x float> %vecinit9, float %3, i32 3
  %call12 = call cc75 i32 (i8 addrspace(2)*, ...)* @printf(i8 addrspace(2)* inttoptr (i64 ptrtoint ([36 x i8]* @.str to i64) to i8 addrspace(2)*), <4 x float> %vecinit11)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %idxprom = zext i32 %conv4 to i64
  %arrayidx13 = getelementptr inbounds [10 x i32] addrspace(3)* @printfKernel.data, i32 0, i64 %idxprom
  store i32 %conv4, i32 addrspace(3)* %arrayidx13, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %cmp14 = icmp eq i32 10, %conv4
  br i1 %cmp14, label %if.then16, label %if.end19

if.then16:                                        ; preds = %if.end
  %call17 = call cc75 i32 (i8 addrspace(2)*, ...)* @printf(i8 addrspace(2)* inttoptr (i64 ptrtoint ([19 x i8]* @.str1 to i64) to i8 addrspace(2)*), i32 %conv2)
  %4 = load i32 addrspace(3)* getelementptr inbounds ([10 x i32] addrspace(3)* @printfKernel.data, i64 1, i64 0), align 4
  %call18 = call cc75 i32 (i8 addrspace(2)*, ...)* @printf(i8 addrspace(2)* inttoptr (i64 ptrtoint ([23 x i8]* @.str2 to i64) to i8 addrspace(2)*), i32 %4)
  br label %if.end19

if.end19:                                         ; preds = %if.then16, %if.end
  %call20 = call cc75 i32 (i8 addrspace(2)*, ...)* @printf(i8 addrspace(2)* inttoptr (i64 ptrtoint ([38 x i8]* @.str3 to i64) to i8 addrspace(2)*), i32 %conv)
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

declare cc75 i32 @printf(i8 addrspace(2)*, ...)

declare cc75 void @_Z7barrierj(i32)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (float addrspace(1)*)* @__OpenCL_printfKernel_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*"}
!6 = metadata !{i32 1, i32 2}

; ModuleID = 'BitonicSort_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define cc76 void @__OpenCL_bitonicSort_kernel(i32 addrspace(1)* %theArray, i32 %stage, i32 %passOfStage, i32 %direction) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %sub = sub i32 %stage, %passOfStage
  %shl.mask = and i32 %sub, 31
  %shl = shl i32 1, %shl.mask
  %mul = mul i32 2, %shl
  %rem = urem i32 %conv, %shl
  %div = udiv i32 %conv, %shl
  %mul1 = mul i32 %div, %mul
  %add = add i32 %rem, %mul1
  %add2 = add i32 %add, %shl
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds i32 addrspace(1)* %theArray, i64 %idxprom
  %0 = load i32 addrspace(1)* %arrayidx, align 4
  %idxprom3 = zext i32 %add2 to i64
  %arrayidx4 = getelementptr inbounds i32 addrspace(1)* %theArray, i64 %idxprom3
  %1 = load i32 addrspace(1)* %arrayidx4, align 4
  %shl.mask5 = and i32 %stage, 31
  %shl6 = shl i32 1, %shl.mask5
  %div7 = udiv i32 %conv, %shl6
  %rem8 = urem i32 %div7, 2
  %cmp = icmp eq i32 %rem8, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %sub10 = sub i32 1, %direction
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %sortIncreasing.0 = phi i32 [ %sub10, %if.then ], [ %direction, %entry ]
  %cmp11 = icmp ugt i32 %0, %1
  br i1 %cmp11, label %if.then13, label %if.else

if.then13:                                        ; preds = %if.end
  br label %if.end14

if.else:                                          ; preds = %if.end
  br label %if.end14

if.end14:                                         ; preds = %if.else, %if.then13
  %greater.0 = phi i32 [ %0, %if.then13 ], [ %1, %if.else ]
  %lesser.0 = phi i32 [ %1, %if.then13 ], [ %0, %if.else ]
  %tobool = icmp ne i32 %sortIncreasing.0, 0
  br i1 %tobool, label %if.then15, label %if.else20

if.then15:                                        ; preds = %if.end14
  %idxprom16 = zext i32 %add to i64
  %arrayidx17 = getelementptr inbounds i32 addrspace(1)* %theArray, i64 %idxprom16
  store i32 %lesser.0, i32 addrspace(1)* %arrayidx17, align 4
  %idxprom18 = zext i32 %add2 to i64
  %arrayidx19 = getelementptr inbounds i32 addrspace(1)* %theArray, i64 %idxprom18
  store i32 %greater.0, i32 addrspace(1)* %arrayidx19, align 4
  br label %if.end25

if.else20:                                        ; preds = %if.end14
  %idxprom21 = zext i32 %add to i64
  %arrayidx22 = getelementptr inbounds i32 addrspace(1)* %theArray, i64 %idxprom21
  store i32 %greater.0, i32 addrspace(1)* %arrayidx22, align 4
  %idxprom23 = zext i32 %add2 to i64
  %arrayidx24 = getelementptr inbounds i32 addrspace(1)* %theArray, i64 %idxprom23
  store i32 %lesser.0, i32 addrspace(1)* %arrayidx24, align 4
  br label %if.end25

if.end25:                                         ; preds = %if.else20, %if.then15
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!6}
!opencl.spir.version = !{!6}

!0 = metadata !{void (i32 addrspace(1)*, i32, i32, i32)* @__OpenCL_bitonicSort_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"const", metadata !"const", metadata !"const"}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uint*", metadata !"uint", metadata !"uint", metadata !"uint"}
!6 = metadata !{i32 1, i32 2}

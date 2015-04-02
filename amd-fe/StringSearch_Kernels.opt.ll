; ModuleID = 'StringSearch_Kernels.opt.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

@StringSearchNaive.groupSuccessCounter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack1Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.stack2Counter = internal addrspace(3) global i32 0, align 4
@StringSearchLoadBalance.groupSuccessCounter = internal addrspace(3) global i32 0, align 4

; Function Attrs: nounwind
define cc75 i32 @compare(i8 addrspace(1)* %text, i8 addrspace(3)* %pattern, i32 %length) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %l.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp ult i32 %l.0, %length
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %idxprom = zext i32 %l.0 to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom
  %0 = load i8 addrspace(1)* %arrayidx, align 1
  %conv = zext i8 %0 to i32
  %cmp1 = icmp sle i32 65, %conv
  br i1 %cmp1, label %land.lhs.true, label %cond.false

land.lhs.true:                                    ; preds = %for.body
  %idxprom3 = zext i32 %l.0 to i64
  %arrayidx4 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom3
  %1 = load i8 addrspace(1)* %arrayidx4, align 1
  %conv5 = zext i8 %1 to i32
  %cmp6 = icmp sle i32 %conv5, 90
  br i1 %cmp6, label %cond.true, label %cond.false

cond.true:                                        ; preds = %land.lhs.true
  %idxprom8 = zext i32 %l.0 to i64
  %arrayidx9 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom8
  %2 = load i8 addrspace(1)* %arrayidx9, align 1
  %conv10 = zext i8 %2 to i32
  %sub = sub nsw i32 %conv10, 65
  %add = add nsw i32 %sub, 97
  br label %cond.end

cond.false:                                       ; preds = %land.lhs.true, %for.body
  %idxprom11 = zext i32 %l.0 to i64
  %arrayidx12 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom11
  %3 = load i8 addrspace(1)* %arrayidx12, align 1
  %conv13 = zext i8 %3 to i32
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %add, %cond.true ], [ %conv13, %cond.false ]
  %idxprom14 = zext i32 %l.0 to i64
  %arrayidx15 = getelementptr inbounds i8 addrspace(3)* %pattern, i64 %idxprom14
  %4 = load i8 addrspace(3)* %arrayidx15, align 1
  %conv16 = zext i8 %4 to i32
  %cmp17 = icmp ne i32 %cond, %conv16
  br i1 %cmp17, label %if.then, label %if.end

if.then:                                          ; preds = %cond.end
  br label %return

if.end:                                           ; preds = %cond.end
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add i32 %l.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %return

return:                                           ; preds = %for.end, %if.then
  %retval.0 = phi i32 [ 0, %if.then ], [ 1, %for.end ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define cc76 void @__OpenCL_StringSearchNaive_kernel(i8 addrspace(1)* %text, i32 %textLength, i8 addrspace(1)* %pattern, i32 %patternLength, i32 addrspace(1)* %resultBuffer, i32 addrspace(1)* %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* %localPattern) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %sub = sub i32 %textLength, %patternLength
  %add = add i32 %sub, 1
  %mul = mul i32 %conv4, %maxSearchLength
  %add5 = add i32 %mul, %maxSearchLength
  %cmp = icmp ugt i32 %mul, %add
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %if.end59

if.end:                                           ; preds = %entry
  %cmp7 = icmp ugt i32 %add5, %add
  br i1 %cmp7, label %if.then9, label %if.end10

if.then9:                                         ; preds = %if.end
  br label %if.end10

if.end10:                                         ; preds = %if.then9, %if.end
  %endSearchIdx.0 = phi i32 [ %add, %if.then9 ], [ %add5, %if.end ]
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end10
  %idx.0 = phi i32 [ %conv, %if.end10 ], [ %add32, %for.inc ]
  %cmp11 = icmp ult i32 %idx.0, %patternLength
  br i1 %cmp11, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %idxprom = sext i32 %idx.0 to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %idxprom
  %0 = load i8 addrspace(1)* %arrayidx, align 1
  %conv13 = zext i8 %0 to i32
  %cmp14 = icmp sle i32 65, %conv13
  br i1 %cmp14, label %land.lhs.true, label %cond.false

land.lhs.true:                                    ; preds = %for.body
  %idxprom16 = sext i32 %idx.0 to i64
  %arrayidx17 = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %idxprom16
  %1 = load i8 addrspace(1)* %arrayidx17, align 1
  %conv18 = zext i8 %1 to i32
  %cmp19 = icmp sle i32 %conv18, 90
  br i1 %cmp19, label %cond.true, label %cond.false

cond.true:                                        ; preds = %land.lhs.true
  %idxprom21 = sext i32 %idx.0 to i64
  %arrayidx22 = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %idxprom21
  %2 = load i8 addrspace(1)* %arrayidx22, align 1
  %conv23 = zext i8 %2 to i32
  %sub24 = sub nsw i32 %conv23, 65
  %add25 = add nsw i32 %sub24, 97
  br label %cond.end

cond.false:                                       ; preds = %land.lhs.true, %for.body
  %idxprom26 = sext i32 %idx.0 to i64
  %arrayidx27 = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %idxprom26
  %3 = load i8 addrspace(1)* %arrayidx27, align 1
  %conv28 = zext i8 %3 to i32
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %add25, %cond.true ], [ %conv28, %cond.false ]
  %conv29 = trunc i32 %cond to i8
  %idxprom30 = sext i32 %idx.0 to i64
  %arrayidx31 = getelementptr inbounds i8 addrspace(3)* %localPattern, i64 %idxprom30
  store i8 %conv29, i8 addrspace(3)* %arrayidx31, align 1
  br label %for.inc

for.inc:                                          ; preds = %cond.end
  %add32 = add nsw i32 %idx.0, %conv2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %cmp33 = icmp eq i32 %conv, 0
  br i1 %cmp33, label %if.then35, label %if.end36

if.then35:                                        ; preds = %for.end
  store volatile i32 0, i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4
  br label %if.end36

if.end36:                                         ; preds = %if.then35, %for.end
  call cc75 void @_Z7barrierj(i32 1)
  %add37 = add i32 %mul, %conv
  br label %for.cond38

for.cond38:                                       ; preds = %for.inc51, %if.end36
  %stringPos.0 = phi i32 [ %add37, %if.end36 ], [ %add52, %for.inc51 ]
  %cmp39 = icmp ult i32 %stringPos.0, %endSearchIdx.0
  br i1 %cmp39, label %for.body41, label %for.end53

for.body41:                                       ; preds = %for.cond38
  %idx.ext = zext i32 %stringPos.0 to i64
  %add.ptr = getelementptr inbounds i8 addrspace(1)* %text, i64 %idx.ext
  %call42 = call cc75 i32 @compare(i8 addrspace(1)* %add.ptr, i8 addrspace(3)* %localPattern, i32 %patternLength)
  %cmp43 = icmp eq i32 %call42, 1
  br i1 %cmp43, label %if.then45, label %if.end50

if.then45:                                        ; preds = %for.body41
  %call46 = call cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter)
  %add47 = add i32 %mul, %call46
  %idxprom48 = zext i32 %add47 to i64
  %arrayidx49 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i64 %idxprom48
  store i32 %stringPos.0, i32 addrspace(1)* %arrayidx49, align 4
  br label %if.end50

if.end50:                                         ; preds = %if.then45, %for.body41
  br label %for.inc51

for.inc51:                                        ; preds = %if.end50
  %add52 = add i32 %stringPos.0, %conv2
  br label %for.cond38

for.end53:                                        ; preds = %for.cond38
  call cc75 void @_Z7barrierj(i32 1)
  %cmp54 = icmp eq i32 %conv, 0
  br i1 %cmp54, label %if.then56, label %if.end59

if.then56:                                        ; preds = %for.end53
  %4 = load volatile i32 addrspace(3)* @StringSearchNaive.groupSuccessCounter, align 4
  %idxprom57 = sext i32 %conv4 to i64
  %arrayidx58 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i64 %idxprom57
  store i32 %4, i32 addrspace(1)* %arrayidx58, align 4
  br label %if.end59

if.end59:                                         ; preds = %if.then56, %for.end53, %if.then
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_local_idj(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z14get_local_sizej(i32) #1

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z12get_group_idj(i32) #1

declare cc75 void @_Z7barrierj(i32)

declare cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)*)

; Function Attrs: nounwind
define cc76 void @__OpenCL_StringSearchLoadBalance_kernel(i8 addrspace(1)* %text, i32 %textLength, i8 addrspace(1)* %pattern, i32 %patternLength, i32 addrspace(1)* %resultBuffer, i32 addrspace(1)* %resultCountPerWG, i32 %maxSearchLength, i8 addrspace(3)* %localPattern, i32 addrspace(3)* %stack1) #0 {
entry:
  %call = call cc75 i64 @_Z12get_local_idj(i32 0) #1
  %conv = trunc i64 %call to i32
  %call1 = call cc75 i64 @_Z14get_local_sizej(i32 0) #1
  %conv2 = trunc i64 %call1 to i32
  %call3 = call cc75 i64 @_Z12get_group_idj(i32 0) #1
  %conv4 = trunc i64 %call3 to i32
  %cmp = icmp eq i32 %conv, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  store i32 0, i32 addrspace(3)* @StringSearchLoadBalance.stack2Counter, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %sub = sub i32 %textLength, %patternLength
  %add = add i32 %sub, 1
  %mul = mul i32 %conv4, %maxSearchLength
  %add6 = add i32 %mul, %maxSearchLength
  %cmp7 = icmp ugt i32 %mul, %add
  br i1 %cmp7, label %if.then9, label %if.end10

if.then9:                                         ; preds = %if.end
  br label %if.end162

if.end10:                                         ; preds = %if.end
  %cmp11 = icmp ugt i32 %add6, %add
  br i1 %cmp11, label %if.then13, label %if.end14

if.then13:                                        ; preds = %if.end10
  br label %if.end14

if.end14:                                         ; preds = %if.then13, %if.end10
  %endSearchIdx.0 = phi i32 [ %add, %if.then13 ], [ %add6, %if.end10 ]
  %sub15 = sub i32 %endSearchIdx.0, %mul
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end14
  %idx.0 = phi i32 [ %conv, %if.end14 ], [ %add37, %for.inc ]
  %cmp16 = icmp ult i32 %idx.0, %patternLength
  br i1 %cmp16, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %idxprom = zext i32 %idx.0 to i64
  %arrayidx = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %idxprom
  %0 = load i8 addrspace(1)* %arrayidx, align 1
  %conv18 = zext i8 %0 to i32
  %cmp19 = icmp sle i32 65, %conv18
  br i1 %cmp19, label %land.lhs.true, label %cond.false

land.lhs.true:                                    ; preds = %for.body
  %idxprom21 = zext i32 %idx.0 to i64
  %arrayidx22 = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %idxprom21
  %1 = load i8 addrspace(1)* %arrayidx22, align 1
  %conv23 = zext i8 %1 to i32
  %cmp24 = icmp sle i32 %conv23, 90
  br i1 %cmp24, label %cond.true, label %cond.false

cond.true:                                        ; preds = %land.lhs.true
  %idxprom26 = zext i32 %idx.0 to i64
  %arrayidx27 = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %idxprom26
  %2 = load i8 addrspace(1)* %arrayidx27, align 1
  %conv28 = zext i8 %2 to i32
  %sub29 = sub nsw i32 %conv28, 65
  %add30 = add nsw i32 %sub29, 97
  br label %cond.end

cond.false:                                       ; preds = %land.lhs.true, %for.body
  %idxprom31 = zext i32 %idx.0 to i64
  %arrayidx32 = getelementptr inbounds i8 addrspace(1)* %pattern, i64 %idxprom31
  %3 = load i8 addrspace(1)* %arrayidx32, align 1
  %conv33 = zext i8 %3 to i32
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %add30, %cond.true ], [ %conv33, %cond.false ]
  %conv34 = trunc i32 %cond to i8
  %idxprom35 = zext i32 %idx.0 to i64
  %arrayidx36 = getelementptr inbounds i8 addrspace(3)* %localPattern, i64 %idxprom35
  store i8 %conv34, i8 addrspace(3)* %arrayidx36, align 1
  br label %for.inc

for.inc:                                          ; preds = %cond.end
  %add37 = add i32 %idx.0, %conv2
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call cc75 void @_Z7barrierj(i32 1)
  %arrayidx38 = getelementptr inbounds i8 addrspace(3)* %localPattern, i64 0
  %4 = load i8 addrspace(3)* %arrayidx38, align 1
  %arrayidx39 = getelementptr inbounds i8 addrspace(3)* %localPattern, i64 1
  %5 = load i8 addrspace(3)* %arrayidx39, align 1
  br label %while.body

while.body:                                       ; preds = %if.end156, %if.then121, %for.end
  %stringPos.0 = phi i32 [ %conv, %for.end ], [ %add114, %if.then121 ], [ %add114, %if.end156 ]
  %cmp40 = icmp ult i32 %stringPos.0, %sub15
  br i1 %cmp40, label %if.then42, label %if.end113

if.then42:                                        ; preds = %while.body
  %conv43 = zext i8 %4 to i32
  %add44 = add i32 %mul, %stringPos.0
  %idxprom45 = zext i32 %add44 to i64
  %arrayidx46 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom45
  %6 = load i8 addrspace(1)* %arrayidx46, align 1
  %conv47 = zext i8 %6 to i32
  %cmp48 = icmp sle i32 65, %conv47
  br i1 %cmp48, label %land.lhs.true50, label %cond.false64

land.lhs.true50:                                  ; preds = %if.then42
  %add51 = add i32 %mul, %stringPos.0
  %idxprom52 = zext i32 %add51 to i64
  %arrayidx53 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom52
  %7 = load i8 addrspace(1)* %arrayidx53, align 1
  %conv54 = zext i8 %7 to i32
  %cmp55 = icmp sle i32 %conv54, 90
  br i1 %cmp55, label %cond.true57, label %cond.false64

cond.true57:                                      ; preds = %land.lhs.true50
  %add58 = add i32 %mul, %stringPos.0
  %idxprom59 = zext i32 %add58 to i64
  %arrayidx60 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom59
  %8 = load i8 addrspace(1)* %arrayidx60, align 1
  %conv61 = zext i8 %8 to i32
  %sub62 = sub nsw i32 %conv61, 65
  %add63 = add nsw i32 %sub62, 97
  br label %cond.end69

cond.false64:                                     ; preds = %land.lhs.true50, %if.then42
  %add65 = add i32 %mul, %stringPos.0
  %idxprom66 = zext i32 %add65 to i64
  %arrayidx67 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom66
  %9 = load i8 addrspace(1)* %arrayidx67, align 1
  %conv68 = zext i8 %9 to i32
  br label %cond.end69

cond.end69:                                       ; preds = %cond.false64, %cond.true57
  %cond70 = phi i32 [ %add63, %cond.true57 ], [ %conv68, %cond.false64 ]
  %cmp71 = icmp eq i32 %conv43, %cond70
  br i1 %cmp71, label %land.lhs.true73, label %if.end112

land.lhs.true73:                                  ; preds = %cond.end69
  %conv74 = zext i8 %5 to i32
  %add75 = add i32 %mul, %stringPos.0
  %add76 = add i32 %add75, 1
  %idxprom77 = zext i32 %add76 to i64
  %arrayidx78 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom77
  %10 = load i8 addrspace(1)* %arrayidx78, align 1
  %conv79 = zext i8 %10 to i32
  %cmp80 = icmp sle i32 65, %conv79
  br i1 %cmp80, label %land.lhs.true82, label %cond.false98

land.lhs.true82:                                  ; preds = %land.lhs.true73
  %add83 = add i32 %mul, %stringPos.0
  %add84 = add i32 %add83, 1
  %idxprom85 = zext i32 %add84 to i64
  %arrayidx86 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom85
  %11 = load i8 addrspace(1)* %arrayidx86, align 1
  %conv87 = zext i8 %11 to i32
  %cmp88 = icmp sle i32 %conv87, 90
  br i1 %cmp88, label %cond.true90, label %cond.false98

cond.true90:                                      ; preds = %land.lhs.true82
  %add91 = add i32 %mul, %stringPos.0
  %add92 = add i32 %add91, 1
  %idxprom93 = zext i32 %add92 to i64
  %arrayidx94 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom93
  %12 = load i8 addrspace(1)* %arrayidx94, align 1
  %conv95 = zext i8 %12 to i32
  %sub96 = sub nsw i32 %conv95, 65
  %add97 = add nsw i32 %sub96, 97
  br label %cond.end104

cond.false98:                                     ; preds = %land.lhs.true82, %land.lhs.true73
  %add99 = add i32 %mul, %stringPos.0
  %add100 = add i32 %add99, 1
  %idxprom101 = zext i32 %add100 to i64
  %arrayidx102 = getelementptr inbounds i8 addrspace(1)* %text, i64 %idxprom101
  %13 = load i8 addrspace(1)* %arrayidx102, align 1
  %conv103 = zext i8 %13 to i32
  br label %cond.end104

cond.end104:                                      ; preds = %cond.false98, %cond.true90
  %cond105 = phi i32 [ %add97, %cond.true90 ], [ %conv103, %cond.false98 ]
  %cmp106 = icmp eq i32 %conv74, %cond105
  br i1 %cmp106, label %if.then108, label %if.end112

if.then108:                                       ; preds = %cond.end104
  %call109 = call cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter)
  %idxprom110 = sext i32 %call109 to i64
  %arrayidx111 = getelementptr inbounds i32 addrspace(3)* %stack1, i64 %idxprom110
  store i32 %stringPos.0, i32 addrspace(3)* %arrayidx111, align 4
  br label %if.end112

if.end112:                                        ; preds = %if.then108, %cond.end104, %cond.end69
  br label %if.end113

if.end113:                                        ; preds = %if.end112, %while.body
  %add114 = add nsw i32 %stringPos.0, %conv2
  call cc75 void @_Z7barrierj(i32 1)
  %14 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  call cc75 void @_Z7barrierj(i32 1)
  %cmp115 = icmp ult i32 %14, %conv2
  br i1 %cmp115, label %land.lhs.true117, label %if.end122

land.lhs.true117:                                 ; preds = %if.end113
  %div = sdiv i32 %add114, %conv2
  %mul118 = mul nsw i32 %div, %conv2
  %cmp119 = icmp ult i32 %mul118, %sub15
  br i1 %cmp119, label %if.then121, label %if.end122

if.then121:                                       ; preds = %land.lhs.true117
  br label %while.body

if.end122:                                        ; preds = %land.lhs.true117, %if.end113
  %cmp123 = icmp ult i32 %conv, %14
  br i1 %cmp123, label %if.then125, label %if.end144

if.then125:                                       ; preds = %if.end122
  %call126 = call cc75 i32 @_Z10atomic_decPVU3AS3j(i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter)
  %dec = add nsw i32 %call126, -1
  %idxprom127 = sext i32 %dec to i64
  %arrayidx128 = getelementptr inbounds i32 addrspace(3)* %stack1, i64 %idxprom127
  %15 = load i32 addrspace(3)* %arrayidx128, align 4
  %idx.ext = zext i32 %mul to i64
  %add.ptr = getelementptr inbounds i8 addrspace(1)* %text, i64 %idx.ext
  %idx.ext129 = sext i32 %15 to i64
  %add.ptr130 = getelementptr inbounds i8 addrspace(1)* %add.ptr, i64 %idx.ext129
  %add.ptr131 = getelementptr inbounds i8 addrspace(1)* %add.ptr130, i64 2
  %add.ptr132 = getelementptr inbounds i8 addrspace(3)* %localPattern, i64 2
  %sub133 = sub i32 %patternLength, 2
  %call134 = call cc75 i32 @compare(i8 addrspace(1)* %add.ptr131, i8 addrspace(3)* %add.ptr132, i32 %sub133)
  %cmp135 = icmp eq i32 %call134, 1
  br i1 %cmp135, label %if.then137, label %if.end143

if.then137:                                       ; preds = %if.then125
  %call138 = call cc75 i32 @_Z10atomic_incPVU3AS3j(i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter)
  %add139 = add i32 %mul, %15
  %add140 = add i32 %mul, %call138
  %idxprom141 = zext i32 %add140 to i64
  %arrayidx142 = getelementptr inbounds i32 addrspace(1)* %resultBuffer, i64 %idxprom141
  store i32 %add139, i32 addrspace(1)* %arrayidx142, align 4
  br label %if.end143

if.end143:                                        ; preds = %if.then137, %if.then125
  br label %if.end144

if.end144:                                        ; preds = %if.end143, %if.end122
  call cc75 void @_Z7barrierj(i32 1)
  %div145 = sdiv i32 %add114, %conv2
  %mul146 = mul nsw i32 %div145, %conv2
  %cmp147 = icmp uge i32 %mul146, %sub15
  br i1 %cmp147, label %land.lhs.true149, label %if.end156

land.lhs.true149:                                 ; preds = %if.end144
  %16 = load i32 addrspace(3)* @StringSearchLoadBalance.stack1Counter, align 4
  %cmp150 = icmp ule i32 %16, 0
  br i1 %cmp150, label %land.lhs.true152, label %if.end156

land.lhs.true152:                                 ; preds = %land.lhs.true149
  %17 = load i32 addrspace(3)* @StringSearchLoadBalance.stack2Counter, align 4
  %cmp153 = icmp ule i32 %17, 0
  br i1 %cmp153, label %if.then155, label %if.end156

if.then155:                                       ; preds = %land.lhs.true152
  br label %while.end

if.end156:                                        ; preds = %land.lhs.true152, %land.lhs.true149, %if.end144
  br label %while.body

while.end:                                        ; preds = %if.then155
  %cmp157 = icmp eq i32 %conv, 0
  br i1 %cmp157, label %if.then159, label %if.end162

if.then159:                                       ; preds = %while.end
  %18 = load i32 addrspace(3)* @StringSearchLoadBalance.groupSuccessCounter, align 4
  %idxprom160 = sext i32 %conv4 to i64
  %arrayidx161 = getelementptr inbounds i32 addrspace(1)* %resultCountPerWG, i64 %idxprom160
  store i32 %18, i32 addrspace(1)* %arrayidx161, align 4
  br label %if.end162

if.end162:                                        ; preds = %if.then159, %while.end, %if.then9
  ret void
}

declare cc75 i32 @_Z10atomic_decPVU3AS3j(i32 addrspace(3)*)

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0, !6}
!opencl.enable.FP_CONTRACT = !{}
!opencl.ocl.version = !{!12}
!opencl.spir.version = !{!12}

!0 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*)* @__OpenCL_StringSearchNaive_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 0, i32 1, i32 1, i32 0, i32 3}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"uchar*", metadata !"uint", metadata !"uchar*", metadata !"uint", metadata !"int*", metadata !"int*", metadata !"uint", metadata !"uchar*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"const", metadata !"const", metadata !"const", metadata !"", metadata !"", metadata !"const", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar*", metadata !"uint", metadata !"uchar*", metadata !"uint", metadata !"int*", metadata !"int*", metadata !"uint", metadata !"uchar*"}
!6 = metadata !{void (i8 addrspace(1)*, i32, i8 addrspace(1)*, i32, i32 addrspace(1)*, i32 addrspace(1)*, i32, i8 addrspace(3)*, i32 addrspace(3)*)* @__OpenCL_StringSearchLoadBalance_kernel, metadata !7, metadata !8, metadata !9, metadata !10, metadata !11}
!7 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 0, i32 1, i32 0, i32 1, i32 1, i32 0, i32 3, i32 3}
!8 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!9 = metadata !{metadata !"kernel_arg_type", metadata !"uchar*", metadata !"uint", metadata !"uchar*", metadata !"uint", metadata !"int*", metadata !"int*", metadata !"uint", metadata !"uchar*", metadata !"int*"}
!10 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"const", metadata !"const", metadata !"const", metadata !"", metadata !"", metadata !"const", metadata !"", metadata !""}
!11 = metadata !{metadata !"kernel_arg_base_type", metadata !"uchar*", metadata !"uint", metadata !"uchar*", metadata !"uint", metadata !"int*", metadata !"int*", metadata !"uint", metadata !"uchar*", metadata !"int*"}
!12 = metadata !{i32 1, i32 2}

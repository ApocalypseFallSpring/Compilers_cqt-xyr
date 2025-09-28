; ModuleID = 'main.cpp'
source_filename = "main.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

declare i32 @getint()
declare void @putint(i32)
declare void @putch(i32)

define i32 @add(i32 %a, i32 %b) {
entry:
  %result = add nsw i32 %a, %b
  ret i32 %result
}

define i32 @main() {
entry:
  %rv = alloca i32, align 4
  %a  = alloca i32, align 4
  %b  = alloca i32, align 4
  %i  = alloca i32, align 4
  %t  = alloca i32, align 4
  %n  = alloca i32, align 4

  store i32 0, i32* %rv, align 4
  store i32 0, i32* %a,  align 4
  store i32 1, i32* %b,  align 4
  store i32 1, i32* %i,  align 4

  %n_in = call i32 @getint()
  store i32 %n_in, i32* %n, align 4

  %a0 = load i32, i32* %a, align 4
  call void @putint(i32 %a0)
  call void @putch(i32 10)

  %b0 = load i32, i32* %b, align 4
  call void @putint(i32 %b0)
  call void @putch(i32 10)

  br label %loop.cond

loop.cond:
  %iv = load i32, i32* %i, align 4
  %nv = load i32, i32* %n, align 4
  %cmp = icmp slt i32 %iv, %nv
  br i1 %cmp, label %loop.body, label %loop.end

loop.body:
  %b1 = load i32, i32* %b, align 4
  store i32 %b1, i32* %t, align 4

  %a1 = load i32, i32* %a, align 4
  %b2 = load i32, i32* %b, align 4
  %sum = call i32 @add(i32 %a1, i32 %b2)
  store i32 %sum, i32* %b, align 4

  %b3 = load i32, i32* %b, align 4
  %mod = srem i32 %b3, 2
  %iseven = icmp eq i32 %mod, 0
  br i1 %iseven, label %if.then, label %if.end

if.then:
  %bprint = load i32, i32* %b, align 4
  call void @putint(i32 %bprint)
  call void @putch(i32 10)
  br label %if.end

if.end:
  %tval = load i32, i32* %t, align 4
  store i32 %tval, i32* %a, align 4

  %iv1 = load i32, i32* %i, align 4
  %iv2 = add nsw i32 %iv1, 1
  store i32 %iv2, i32* %i, align 4

  br label %loop.cond

loop.end:
  ret i32 0
}

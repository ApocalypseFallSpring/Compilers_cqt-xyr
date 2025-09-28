
    .text
    .globl  add
    .p2align    2
add:                                // @add
    add     w0, w0, w1              // a + b
    ret

    .globl  main
    .p2align    2
main:                               // @main
    stp     x29, x30, [sp, #-48]!   // 保存帧指针和链接寄存器
    mov     x29, sp                 // 设置新的帧指针
    
    // 初始化变量
    mov     w8, #0                  // a = 0
    str     w8, [sp, #28]           // 存储a到栈
    mov     w8, #1                  // b = 1
    str     w8, [sp, #24]           // 存储b到栈
    mov     w8, #1                  // i = 1
    str     w8, [sp, #20]           // 存储i到栈
    
    // n = getint()
    bl      getint
    str     w0, [sp, #16]           // 存储n到栈
    
    // putint(a)
    ldr     w0, [sp, #28]           // 加载a
    bl      putint
    
    // putch(10) - 换行符
    mov     w0, #10                 // ASCII换行符
    bl      putch
    
    // putint(b)
    ldr     w0, [sp, #24]           // 加载b
    bl      putint
    
    // putch(10) - 换行符
    mov     w0, #10                 // ASCII换行符
    bl      putch
    
    // while (i < n) 循环开始
    b       .LBB1_1
.LBB1_1:                            // =>循环主体
    ldr     w8, [sp, #20]           // 加载i
    ldr     w9, [sp, #16]           // 加载n
    cmp     w8, w9                  // 比较 i < n
    b.ge    .LBB1_6                 // 如果 i >= n, 跳出循环
    
    // t = b
    ldr     w8, [sp, #24]           // 加载b
    str     w8, [sp, #12]           // 存储到t
    
    // b = add(a, b)
    ldr     w0, [sp, #28]           // 加载a到第一个参数
    ldr     w1, [sp, #24]           // 加载b到第二个参数
    bl      add                     // 调用add函数
    str     w0, [sp, #24]           // 存储结果到b
    
    // if (b % 2 == 0)
    and     w8, w0, #1              // b & 1 (取最低位)
    cbnz    w8, .LBB1_4             // 如果结果不为0(奇数), 跳过输出
    
    // putint(b)
    ldr     w0, [sp, #24]           // 加载b
    bl      putint
    
    // putch(10)
    mov     w0, #10                 // ASCII换行符
    bl      putch
    
.LBB1_4:                            // if条件结束
    // a = t
    ldr     w8, [sp, #12]           // 加载t
    str     w8, [sp, #28]           // 存储到a
    
    // i = i + 1
    ldr     w8, [sp, #20]           // 加载i
    add     w8, w8, #1              // i + 1
    str     w8, [sp, #20]           // 存储回i
    
    b       .LBB1_1                 // 继续循环
    
.LBB1_6:                            // 循环结束
    // return 0
    mov     w0, #0                  // 返回值0
    ldp     x29, x30, [sp], #48     // 恢复帧指针和链接寄存器
    ret
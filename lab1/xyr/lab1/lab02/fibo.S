.text
    .globl  add
    .p2align    2
add:                                // 加法函数实现
    add     w0, w0, w1              // 计算w0 + w1，结果存入w0
    ret                             // 返回计算结果

    .globl  main
    .p2align    2
main:                               // 主函数入口
    stp     x29, x30, [sp, #-48]!   // 保存帧指针与返回地址，分配栈空间
    mov     x29, sp                 // 更新帧指针指向当前栈顶
    
    // 初始化变量并存储到栈
    mov     w8, #0                  // 初始化a为0
    str     w8, [sp, #28]           
    mov     w8, #1                  // 初始化b为1
    str     w8, [sp, #24]
    mov     w8, #1                  // 初始化i为1
    str     w8, [sp, #20]
    
    // 获取输入值n
    bl      getint                  // 调用getint获取输入
    str     w0, [sp, #16]           // 保存n到栈
    
    // 输出初始a值
    ldr     w0, [sp, #28]           // 读取a的值
    bl      putint                  // 输出a
    mov     w0, #10                 // 换行符ASCII码
    bl      putch                   // 输出换行
    
    // 输出初始b值
    ldr     w0, [sp, #24]           // 读取b的值
    bl      putint                  // 输出b
    mov     w0, #10                 // 换行符ASCII码
    bl      putch                   // 输出换行
    
    // 循环控制：i < n
    b       .loop_cond              // 跳转到循环条件判断
.loop_body:                          // 循环主体
    // 暂存b的值到t
    ldr     w8, [sp, #24]           
    str     w8, [sp, #12]           // t = b
    
    // 计算新的b值：b = a + b
    ldr     w0, [sp, #28]           // 参数1：a
    ldr     w1, [sp, #24]           // 参数2：b
    bl      add                     // 调用加法函数
    str     w0, [sp, #24]           // 更新b的值
    
    // 判断b是否为偶数并输出
    and     w8, w0, #1              // 取b的最低位（判断奇偶）
    cbnz    w8, .skip_output        // 若为奇数则跳过输出
    
    ldr     w0, [sp, #24]           // 读取b的值
    bl      putint                  // 输出偶数b
    mov     w0, #10                 // 换行符
    bl      putch                   // 输出换行
    
.skip_output:                        // 跳过输出的分支
    // 更新a的值为之前的b
    ldr     w8, [sp, #12]           
    str     w8, [sp, #28]           // a = t（原b值）
    
    // 计数器i自增
    ldr     w8, [sp, #20]           
    add     w8, w8, #1              // i += 1
    str     w8, [sp, #20]           // 保存更新后的i
    
.loop_cond:                          // 循环条件判断
    ldr     w8, [sp, #20]           // 读取i
    ldr     w9, [sp, #16]           // 读取n
    cmp     w8, w9                  // 比较i与n
    blt     .loop_body              // 若i < n则继续循环
    
    // 程序结束处理
    mov     w0, #0                  // 设置返回值为0
    ldp     x29, x30, [sp], #48     // 恢复栈状态与寄存器
    ret                             // 主函数返回


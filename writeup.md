## lab1
strap_vector.S 第23行把当前trapframe地址存在t6里，然后把当前的通用寄存器都保存到这个地址，也就是保存到了trapframe->regs。第32行又把交换后的sscratch（原来的a0）写回到trapframe的regs。
user_lib.c里第29行，把返回值设置成了a0。
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:51:46 09/25/2020 
// Design Name: 
// Module Name:    Single_Cycle_Computer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Single_Cycle_Computer(		
    input Reset , Clock,			//CPU输入输出接口：Reset（复位信号）,Clock（时钟信号），
	 output [31:0] Result,addr		//Result（CPU运算结果），addr（指令存储器地址）,都是32位
    );
//////////////////////////////////////////////////////////////////////////////////
//存储器写信号，存储器读信号，存储器回寄存器信号
	 wire MemWrite, MemRead , MemtoReg;
//instruction ROMd Inst(即32位长度的指令),从存储器往寄存器回写的值，从寄存器往存储器写的值，
	 wire [31:0] Inst , MemOutData , MemtoRegdata ,Result;
//五路二选一即选择rs还是rt寄存器，寄存器写信号，参加ALU运算的来源（是通过B过来还是经过扩展而来），
//Branch分支指令，ALU运算得到的指令
	 wire RegDst , RegWrite , ALUSrc  ,Branch , Zero;
//用来区分ALU的运算方式
	 wire [2:0] ALU_op;
//得到的由rs还是rt进行5路二选一得到
	 wire [4:0] Wn;
//寄存器堆从A出去的值，寄存器堆从B出去的值，符号扩展完成的值即（Inst的低16位符号扩展完成），
	 wire [31:0] A , B , Ext_Imm , ALU_B ;
	 //取指部件，首先取出指令，正常取指，执行后PC+4。跳转指令，立即数左移两位后与PC+4的结果相加。
	 Fetch U0(Branch,Zero,Reset,Clock,Ext_Imm,addr);
	 //指令存储部件，在这里取出指令，取出的指令在Inst中
	 INST_ROM U7(addr,Inst);
	 //控制信号的产生，对于Inst提供的指令，产生相应的信号，对应的字段信号为op字段（不同的操作类型
	 //对应不同的操作R型的操作字段为全0，lw为100011，sw为101011，beq为000100，lui为001111），
	 //func字段来确定指令的功能。剩下的均为产生的控制信号。
	 Control_Unit U1( .op(Inst[31:26]) , .func(Inst[5:0]),
	             .RegDst(RegDst) , .RegWrite(RegWrite) , .ALUSrc(ALUSrc) ,
                .MemWrite(MemWrite),.MemRead(MemRead) , .MemtoReg(MemtoReg) ,
	             .Branch(Branch) , .ALU_op(ALU_op)  );
	//五路二选一，根据Control_Unit产生的RegDSt信号来确定哪5位进入Wn
    MUX5_2_1 U2( Inst[20:16] , Inst[15:11] , RegDst , Wn );
	//寄存器堆，根据Control_Unit产生的RegWrite信号来决定是否写入寄存器。从MemtoReg信号决定后
	//回写到寄存器的数据从A输出的和从B输出的32位结果
	 RegFile U3(Inst[25:21] , Inst[20:16] ,Wn ,RegWrite , MemtoRegdata , A ,B , Clock);
    //对Inst的低16位进行符号扩展
    Sign_Extender U4( Inst[15:0] , Ext_Imm);
    //通过Control_Unit产生的ALUSrc控制信号来进行32位2路二选一，得到的结果赋值给ALU_B与A进行ALU运算
    MUX32_2_1 U5( B , Ext_Imm , ALUSrc , ALU_B );
	 //根据Control_Unit产生的ALU_op来进行ALU运算，得到的结果Result位输出
	 ALU U6 ( A , ALU_B , ALU_op , Result , Zero);
	//根据Control_Unit产生的MemWrite，MemRead信号，以及ALU产生的Result作为Addr处理存储器
	//MemOutdata作为存储器的输出。
	 DATA_RAM U8(Clock, MemOutData,B,Result ,MemWrite, MemRead);
	 //根据Control_Unit产生的MemtoReg信号来确定最后的MemtoRegdata
	 MUX32_2_1 U9(Result , MemOutData , MemtoReg , MemtoRegdata);
	 
endmodule

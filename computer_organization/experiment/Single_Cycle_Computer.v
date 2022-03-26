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
    input Reset , Clock,			//CPU��������ӿڣ�Reset����λ�źţ�,Clock��ʱ���źţ���
	 output [31:0] Result,addr		//Result��CPU����������addr��ָ��洢����ַ��,����32λ
    );
//////////////////////////////////////////////////////////////////////////////////
//�洢��д�źţ��洢�����źţ��洢���ؼĴ����ź�
	 wire MemWrite, MemRead , MemtoReg;
//instruction ROMd Inst(��32λ���ȵ�ָ��),�Ӵ洢�����Ĵ�����д��ֵ���ӼĴ������洢��д��ֵ��
	 wire [31:0] Inst , MemOutData , MemtoRegdata ,Result;
//��·��ѡһ��ѡ��rs����rt�Ĵ������Ĵ���д�źţ��μ�ALU�������Դ����ͨ��B�������Ǿ�����չ��������
//Branch��ָ֧�ALU����õ���ָ��
	 wire RegDst , RegWrite , ALUSrc  ,Branch , Zero;
//��������ALU�����㷽ʽ
	 wire [2:0] ALU_op;
//�õ�����rs����rt����5·��ѡһ�õ�
	 wire [4:0] Wn;
//�Ĵ����Ѵ�A��ȥ��ֵ���Ĵ����Ѵ�B��ȥ��ֵ��������չ��ɵ�ֵ����Inst�ĵ�16λ������չ��ɣ���
	 wire [31:0] A , B , Ext_Imm , ALU_B ;
	 //ȡָ����������ȡ��ָ�����ȡָ��ִ�к�PC+4����תָ�������������λ����PC+4�Ľ����ӡ�
	 Fetch U0(Branch,Zero,Reset,Clock,Ext_Imm,addr);
	 //ָ��洢������������ȡ��ָ�ȡ����ָ����Inst��
	 INST_ROM U7(addr,Inst);
	 //�����źŵĲ���������Inst�ṩ��ָ�������Ӧ���źţ���Ӧ���ֶ��ź�Ϊop�ֶΣ���ͬ�Ĳ�������
	 //��Ӧ��ͬ�Ĳ���R�͵Ĳ����ֶ�Ϊȫ0��lwΪ100011��swΪ101011��beqΪ000100��luiΪ001111����
	 //func�ֶ���ȷ��ָ��Ĺ��ܡ�ʣ�µľ�Ϊ�����Ŀ����źš�
	 Control_Unit U1( .op(Inst[31:26]) , .func(Inst[5:0]),
	             .RegDst(RegDst) , .RegWrite(RegWrite) , .ALUSrc(ALUSrc) ,
                .MemWrite(MemWrite),.MemRead(MemRead) , .MemtoReg(MemtoReg) ,
	             .Branch(Branch) , .ALU_op(ALU_op)  );
	//��·��ѡһ������Control_Unit������RegDSt�ź���ȷ����5λ����Wn
    MUX5_2_1 U2( Inst[20:16] , Inst[15:11] , RegDst , Wn );
	//�Ĵ����ѣ�����Control_Unit������RegWrite�ź��������Ƿ�д��Ĵ�������MemtoReg�źž�����
	//��д���Ĵ��������ݴ�A����ĺʹ�B�����32λ���
	 RegFile U3(Inst[25:21] , Inst[20:16] ,Wn ,RegWrite , MemtoRegdata , A ,B , Clock);
    //��Inst�ĵ�16λ���з�����չ
    Sign_Extender U4( Inst[15:0] , Ext_Imm);
    //ͨ��Control_Unit������ALUSrc�����ź�������32λ2·��ѡһ���õ��Ľ����ֵ��ALU_B��A����ALU����
    MUX32_2_1 U5( B , Ext_Imm , ALUSrc , ALU_B );
	 //����Control_Unit������ALU_op������ALU���㣬�õ��Ľ��Resultλ���
	 ALU U6 ( A , ALU_B , ALU_op , Result , Zero);
	//����Control_Unit������MemWrite��MemRead�źţ��Լ�ALU������Result��ΪAddr����洢��
	//MemOutdata��Ϊ�洢���������
	 DATA_RAM U8(Clock, MemOutData,B,Result ,MemWrite, MemRead);
	 //����Control_Unit������MemtoReg�ź���ȷ������MemtoRegdata
	 MUX32_2_1 U9(Result , MemOutData , MemtoReg , MemtoRegdata);
	 
endmodule

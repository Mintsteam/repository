`include "define.v"


module id(
    input wire rst,
    input wire[`InstAddrBus] pc_i,
    input wire[`InstBus]     inst_i,

    input wire[`RegBus]      reg1_data_i,
    input wire[`RegBus]      reg2_data_i,

    output reg               reg1_read_o,
    output reg               reg2_read_o,
    output reg[`RegAddrBus]  reg1_addr_o,
    output reg[`RegAddrBus]  reg2_addr_o,

    output reg[`AluOpBus]    aluop_o,
    output reg[`AluSelBus]   alusel_o,
    output reg[`RegBus]      reg1_o,
    output reg[`RegBus]      reg2_o,
    output reg[`RegAddrBus]  wd_o,
    output reg               wreg_o  
);

    wire[5:0] op = inst_i[31:26];
    wire[4:0] op2 = inst_i[10:6];
    wire[5:0] op3 = inst_i[5:0];
    wire[4:0] op4 = inst_i[20:16];

    reg[`RegBus] imm;

    reg instvalid;

    always @ (*)
    begin
        if (rst == `RstEnable)
        begin
            aluop_o <= `EXE_NOP_OP;
            alusel_o <= `EXE_RES_NOP;
            wd_o <= `NOPRegAddr;
            wreg_o <= `WriteDisable;
            instvalid <= `InstValid;
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;
            reg1_addr_o <= `NOPRegAddr;
            reg2_addr_o <= `NOPRegAddr;
            imm <= `ZeroWord;
        end else begin
            aluop_o <= `EXE_NOP_OP;
            alusel_o <= `EXE_RES_NOP;
            wd_o <= inst_i[15:11];//
            wreg_o <= `WriteDisable;
            instvalid <=`InstInvalid;
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;
            reg1_addr_o <= inst_i[25:21];//将21-25位分离来寻址rs寄存器
            reg2_addr_o <= inst_i[20:16];//将20-16位分离来寻址rt寄存器
            imm <= `ZeroWord;//将立即数赋值为0

            case (op)//根据操作码进行指令译码
                `EXE_ORI://执行ORI指令
                begin
                    wreg_o <= `WriteEnable;//因该运算需要写回
                    aluop_o <= `EXE_OR_OP;//运算子类型是逻辑“或”运算
                    alusel_o <= `EXE_RES_LOGIC;//运算类型是逻辑运算
                    reg1_read_o <= 1'b1;//控制reg1读，也就是将内容读取到rs寄存器中
                    reg2_read_o <= 1'b0;//因只需读取一个数据，故reg2不需要读取使能信号
                    imm <= {16'h0, inst_i[15:0]};//将立即数扩展到32位
                    wd_o <= inst_i[20:16];//结果写入到rt寄存器内
                    instvalid <= `InstValid;//指令有效
                end
                default:
                begin
                end
            endcase
        end
    end

    always @ (*) 
    begin
        if (rst == `RstEnable)
        begin
            reg1_o <= `ZeroWord;
        end else if (reg1_read_o == 1'b1)
        begin
            reg1_o <= reg1_data_i;
        end else if (reg1_read_o == 1'b0)
        begin
            reg1_o <= imm;
        end else begin
            reg1_o <= `ZeroWord;
        end
    end

        always @ (*) 
    begin
        if (rst == `RstEnable)
        begin
            reg2_o <= `ZeroWord;
        end else if (reg2_read_o == 1'b1)
        begin
            reg2_o <= reg2_data_i;
        end else if (reg2_read_o == 1'b0)
        begin
            reg2_o <= imm;
        end else begin
            reg2_o <= `ZeroWord;
        end
    end
endmodule

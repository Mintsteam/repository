`include "define.v"


module regfile(
    input wire              clk,
    input wire              rst,

    input wire we,
    input wire[`RegAddrBus] waddr,
    input wire[`RegBus]     wdata,

    input wire re1,
    input wire[`RegAddrBus] raddr1,
    output reg[`RegBus]     rdata1,

    input wire re2,
    input wire[`RegAddrBus] raddr2,
    output reg[`RegBus]     rdata2
);

    reg[`RegBus] regs[0:`RegNum-1];

    always @ (posedge clk)//控制写入ROM
    begin
        if (rst == `RstDisable)
        begin
            if ((we == `WriteEnable) && (waddr != `RegNumLog2'h0))//如果写入信号有效并且写入地址不为0（MIPS32架构规定$0寄存器值必为0，故不能写入该寄存器）
            begin
                regs[waddr] <= wdata;
            end
        end
    end

    always @ (*)//与写入寄存器操作不同的是读寄存器操作是组合逻辑操作，写入寄存器操作是时序逻辑电路，可保证译码阶段取得要读取的寄存器的值
    begin
        if (rst ==`RstEnable)
        begin
            rdata1 <= `ZeroWord;
        end else if (raddr1 == `RegNumLog2'h0)//如果要读取的ROM单元为0号单元，则直接给出0
        begin
            rdata1 <= `ZeroWord;
        end else if ((raddr1 == waddr) && (we == `WriteEnable) && (re1 == `ReadEnable))//如果同时对一个ROM单元既写入又读取，输出写入的数据
        begin
            rdata1 <= wdata;
        end else if (re1 == `ReadEnable)//如果读信号有效
        begin
            rdata1 <=regs[raddr1];//输出ROM内的指令信息
        end else begin
            rdata1 <= `ZeroWord;
        end
    end

    always @ (*) 
    begin
        if (rst ==`RstEnable)
        begin
            rdata1 <= `ZeroWord;
        end else if (raddr2 == `RegNumLog2'h0)
        begin
            rdata1 <= `ZeroWord;
        end else if ((raddr2 == waddr) && (we == `WriteEnable) && (re2 == `ReadEnable)) 
        begin
            rdata2 <= wdata;
        end else if (re2 == `ReadEnable)
        begin
            rdata2 <=regs[raddr2];
        end else begin
            rdata2 <= `ZeroWord;
        end
    end
endmodule
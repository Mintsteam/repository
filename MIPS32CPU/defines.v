//**************************全局宏定义***********************//
`define RstEnable      1'b1
`define RstDisable     1'b0
`define ZeroWord       32'h00000000    //32位的数值0
`define WriteEnable    1'b1
`define WriteDisable   1'b0
`define ReadEnable     1'b1
`define ReadDisable    1'b0
`define AluOpBus       7:0            //译码阶段输出aluop_o的宽度
`define AluSelBus      2:0            //输出alusel_o的宽度
`define InstValid      1'b0           //指令有效
`define InstInvalid    1'b1           //指令无效
`define True_v         1'b1
`define False_v        1'b0
`define ChipEnable     1'b1
`define ChipDisable    1'b0

//**************************与具体指令有关***********************//
`define EXE_ORI        6'b001101      //指令ori的指令码
`define EXE_NOP        6'b000000

//AluOp
`define EXE_OR_OP      8'b00100101
`define EXE_NOP_OP     8'b00000000

//AluSel
`define EXE_RES_LOGIC  3'b001
`define EXE_RES_NOP    3'b000

//**************************与指令存储器ROM有关***********************//
`define InstAddrBus    31:0           //ROM的地址总线宽度
`define InstBus        31:0           //ROM的数据总线宽度
`define InstMemNum     131071         //ROM实际大小为128K
`define InstMemNumLog2 17             //ROM实际使用的地址线宽度

//**************************与通用寄存器RegFile有关***********************//
`define RegAddrBus     4:0            //Regfile模块地址线宽度
`define RegBus         31:0           //Regfile模块的数据线宽度
`define RegWidth       32             //通用寄存器的宽度
`define DoubleRegWidth 64
`define DoubleRegBus   63:0
`define RegNum         32
`define RegNumLog2     5              //寻址用通用寄存器使用的地址位数
`define NOPRegAddr     5'b00000

module rv32i (
    input clk,
    input reset,
    output [31:0] pc,         // Contador de programa
    output [31:0] aluResult,  // Resultado de la ALU
    output [31:0] writeData,  // Datos a escribir en la memoria de datos
    output memWrite,          // Señal de escritura de memoria
    output [31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31
);

    // Señales internas
    wire [31:0] instr;
    wire [31:0] readData;

    // Instancia de la memoria de instrucciones (ROM)
    rom instructionMemory (
        .address(pc[6:2]), // Usamos los bits [6:2] del PC como dirección
        .data(instr)
    );

    // Instancia del dataPath
    dataPath dp (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .readData(readData),
        .pc(pc),
        .aluResult(aluResult),
        .writeData(writeData),
        .memWrite(memWrite),
        .reg0(reg0), .reg1(reg1), .reg2(reg2), .reg3(reg3), .reg4(reg4), .reg5(reg5), .reg6(reg6), .reg7(reg7), .reg8(reg8), .reg9(reg9), .reg10(reg10), .reg11(reg11), .reg12(reg12), .reg13(reg13), .reg14(reg14), .reg15(reg15), .reg16(reg16), .reg17(reg17), .reg18(reg18), .reg19(reg19), .reg20(reg20), .reg21(reg21), .reg22(reg22), .reg23(reg23), .reg24(reg24), .reg25(reg25), .reg26(reg26), .reg27(reg27), .reg28(reg28), .reg29(reg29), .reg30(reg30), .reg31(reg31)
    );

endmodule
/*
module rv32i (
    input clk,
    input reset,
    input [31:0] instr,       // Instrucción desde la memoria de instrucciones
    input [31:0] readData,    // Datos leídos desde la memoria de datos
    output [31:0] pc,         // Contador de programa
    output [31:0] aluResult,  // Resultado de la ALU
    output [31:0] writeData,  // Datos a escribir en la memoria de datos
    output memWrite           // Señal de escritura de memoria
);

    // Señales internas
    wire [31:0] immExt;
    wire [31:0] srcA, srcB, writeDataReg;
    wire [2:0] aluControl;
    wire [1:0] immSrc;
    wire aluSrc, regWrite, pcSrc, branch, resSrc;

    // Instancia del dataPath
    dataPath dp (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .readData(readData),
        .pc(pc),
        .aluResult(aluResult),
        .writeData(writeData),
        .memWrite(memWrite)
    );

    // Instancia de la Unidad de Control
    UC controlUnit (
        .op(instr[6:0]),
        .func3(instr[14:12]),
        .func7(instr[30]),
        .zero(aluResult == 0),
        .pcSrc(pcSrc),
        .branch(branch),
        .resSrc(resSrc),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .regWrite(regWrite),
        .aluControl(aluControl),
        .immSrc(immSrc)
    );

endmodule
*/
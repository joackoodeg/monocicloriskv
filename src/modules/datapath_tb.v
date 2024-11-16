`timescale 1ns / 1ps

module dataPath_tb;
    // Inputs
    reg clk;
    reg reset;
    reg [31:0] instr;
    reg [31:0] readData;

    // Outputs
    wire [31:0] pc;
    wire [31:0] aluResult;
    wire [31:0] writeData;
    wire memWrite;
    wire [31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9;
    wire [31:0] reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19;
    wire [31:0] reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29;
    wire [31:0] reg30, reg31;

    // Instantiate DUT
    dataPath uut (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .readData(readData),
        .pc(pc),
        .aluResult(aluResult),
        .writeData(writeData),
        .memWrite(memWrite),
        .reg0(reg0), .reg1(reg1), .reg2(reg2), .reg3(reg3),
        .reg4(reg4), .reg5(reg5), .reg6(reg6), .reg7(reg7),
        .reg8(reg8), .reg9(reg9), .reg10(reg10), .reg11(reg11),
        .reg12(reg12), .reg13(reg13), .reg14(reg14), .reg15(reg15),
        .reg16(reg16), .reg17(reg17), .reg18(reg18), .reg19(reg19),
        .reg20(reg20), .reg21(reg21), .reg22(reg22), .reg23(reg23),
        .reg24(reg24), .reg25(reg25), .reg26(reg26), .reg27(reg27),
        .reg28(reg28), .reg29(reg29), .reg30(reg30), .reg31(reg31)
    );

    // Clock generator
    always #5 clk = ~clk;

    // Task for monitoring control signals
    task display_control_signals;
        begin
            $display("\nControl Signals:");
            $display("regWrite=%b, aluSrc=%b, resSrc=%b", 
                    uut.regWrite, uut.aluSrc, uut.resSrc);
            $display("memWrite=%b, branch=%b, pcSrc=%b", 
                    uut.memWrite, uut.branch, uut.pcSrc);
        end
    endtask

    // Task for displaying register values
    task display_registers;
        begin
            $display("\nRegister Values:");
            $display("reg0=%h, reg1=%h, reg2=%h, reg3=%h", reg0, reg1, reg2, reg3);
            $display("reg4=%h, reg5=%h, reg6=%h, reg7=%h", reg4, reg5, reg6, reg7);
        end
    endtask

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        instr = 32'b0;
        readData = 32'b0;

        // Wait 100 ns for global reset
        #100;
        reset = 0;
        
        // Test 1: Load Word (lw)
        @(posedge clk);
        instr = 32'b00000000000100000000000010000011; // lw x1, 0(x0)
        readData = 32'h12345678;
        @(posedge clk);
        #1;
        $display("\nTest lw:");
        display_control_signals();
        display_registers();

        // Test 2: Store Word (sw)
        @(posedge clk);
        instr = 32'b00000000000100000010000010100011; // sw x1, 0(x0)
        @(posedge clk);
        #1;
        $display("\nTest sw:");
        display_control_signals();
        display_registers();

        // Test 3: Add
        @(posedge clk);
        instr = 32'b00000000000100001000000110110011; // add x3, x1, x2
        @(posedge clk);
        #1;
        $display("\nTest add:");
        display_control_signals();
        display_registers();

        // Test 4: Branch Equal (beq)
        @(posedge clk);
        instr = 32'b00000000000100001000000001100011; // beq x1, x2, offset
        @(posedge clk);
        #1;
        $display("\nTest beq:");
        display_control_signals();
        display_registers();

        // Test 5: Add Immediate (addi)
        @(posedge clk);
        instr = 32'b00000000000100001000000010010011; // addi x1, x2, 1
        @(posedge clk);
        #1;
        $display("\nTest addi:");
        display_control_signals();
        display_registers();

        // Test 6: Jump and Link (jal)
        @(posedge clk);
        instr = 32'b00000000000100000000000011101111; // jal x1, offset
        @(posedge clk);
        #1;
        $display("\nTest jal:");
        display_control_signals();
        display_registers();

        // Final register dump
        $display("\nFinal Register State:");
        display_registers();

        // End simulation
        #100;
        $finish;
    end

    // Optional: Monitor changes
    initial begin
        $monitor("Time=%0t pc=%h aluResult=%h writeData=%h memWrite=%b",
                 $time, pc, aluResult, writeData, memWrite);
    end

endmodule

/*
`timescale 1ns / 1ps

module dataPath_tb;

    // Entradas
    reg clk;
    reg reset;
    reg [31:0] instr;
    reg [31:0] readData;

    // Salidas
    wire [31:0] pc;
    wire [31:0] aluResult;
    wire [31:0] writeData;
    wire memWrite;
    wire [31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31;

    // Instancia del módulo a probar
    dataPath uut (
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

    // Generador de reloj
    always #5 clk = ~clk;

    initial begin
        // Inicialización de señales
        clk = 0;
        reset = 1;
        instr = 32'b0;
        readData = 32'b0;

        // Reset del sistema
        #10;
        reset = 0;

        // Test 1: Instrucción de carga (lw)
        instr = 32'b00000000000100000000000010000011; // lw x1, 0(x0)
        readData = 32'h12345678; // Dato leído desde la memoria
        #20;
        $display("Test lw: pc=%h, aluResult=%h, writeData=%h, memWrite=%b", pc, aluResult, writeData, memWrite);

        // Test 2: Instrucción de almacenamiento (sw)
        instr = 32'b00000000000100000010000010100011; // sw x1, 0(x0)
        #20;
        $display("Test sw: pc=%h, aluResult=%h, writeData=%h, memWrite=%b", pc, aluResult, writeData, memWrite);

        // Test 3: Instrucción de suma (add)
        instr = 32'b00000000000100001000000110110011; // add x3, x1, x2
        #20;
        $display("Test add: pc=%h, aluResult=%h, writeData=%h, memWrite=%b", pc, aluResult, writeData, memWrite);

        // Test 4: Instrucción de salto condicional (beq)
        instr = 32'b00000000000100001000000001100011; // beq x1, x2, offset
        #20;
        $display("Test beq: pc=%h, aluResult=%h, writeData=%h, memWrite=%b", pc, aluResult, writeData, memWrite);

        // Test 5: Instrucción de suma inmediata (addi)
        instr = 32'b00000000000100001000000010010011; // addi x1, x2, 1
        #20;
        $display("Test addi: pc=%h, aluResult=%h, writeData=%h, memWrite=%b", pc, aluResult, writeData, memWrite);

        // Test 6: Instrucción de salto y enlace (jal)
        instr = 32'b00000000000100000000000011101111; // jal x1, offset
        #20;
        $display("Test jal: pc=%h, aluResult=%h, writeData=%h, memWrite=%b", pc, aluResult, writeData, memWrite);

        // Verificar los valores de los registros
        $display("reg0 = %h", reg0);
        $display("reg1 = %h", reg1);
        $display("reg2 = %h", reg2);
        $display("reg3 = %h", reg3);
        $display("reg4 = %h", reg4);
        $display("reg5 = %h", reg5);
        $display("reg6 = %h", reg6);
        $display("reg7 = %h", reg7);
        $display("reg8 = %h", reg8);
        $display("reg9 = %h", reg9);
        $display("reg10 = %h", reg10);
        $display("reg11 = %h", reg11);
        $display("reg12 = %h", reg12);
        $display("reg13 = %h", reg13);
        $display("reg14 = %h", reg14);
        $display("reg15 = %h", reg15);
        $display("reg16 = %h", reg16);
        $display("reg17 = %h", reg17);
        $display("reg18 = %h", reg18);
        $display("reg19 = %h", reg19);
        $display("reg20 = %h", reg20);
        $display("reg21 = %h", reg21);
        $display("reg22 = %h", reg22);
        $display("reg23 = %h", reg23);
        $display("reg24 = %h", reg24);
        $display("reg25 = %h", reg25);
        $display("reg26 = %h", reg26);
        $display("reg27 = %h", reg27);
        $display("reg28 = %h", reg28);
        $display("reg29 = %h", reg29);
        $display("reg30 = %h", reg30);
        $display("reg31 = %h", reg31);

        // Finalizar simulación
        $finish;
    end

endmodule
*/
module mainDeco(
    input [6:0] op,
    output reg branch,           // Señal de control para salto condicional (Branch)
    output reg resSrc,           // Selección de fuente de resultado (ResultSrc)
    output reg memWrite,         // Señal de escritura de memoria (MemWrite)
    output reg aluSrc,           // Selección de fuente de entrada para la ALU (ALUSrc)
    output reg regWrite,         // Señal de escritura de registros (RegWrite)
    output reg [1:0] immSrc,     // Selección del tipo de inmediato (ImmSrc)
    output reg [1:0] aluOp       // Operación de la ALU (ALUOp)
);

    always @(*) begin
        // Valores por defecto (para evitar latches)
        branch = 0;
        resSrc = 0;
        memWrite = 0;
        aluSrc = 0;
        regWrite = 0;
        immSrc = 2'b00;
        aluOp = 2'b00;

        // Decodificación según el valor del opcode (op)
        case(op)
            7'b0000011: begin // lw (load word)
                regWrite = 1;
                immSrc = 2'b00;
                aluSrc = 1;
                memWrite = 0;
                resSrc = 1;
                branch = 0;
                aluOp = 2'b00;
            end
            7'b0100011: begin // sw (store word)
                regWrite = 0;
                immSrc = 2'b01;
                aluSrc = 1;
                memWrite = 1;
                resSrc = 0; // X en la tabla, pero no es relevante aca
                branch = 0;
                aluOp = 2'b00;
            end
            7'b0110011: begin // R-type
                regWrite = 1;
                immSrc = 2'bXX; // Innecesario en R-type, se marca como X
                aluSrc = 0;
                memWrite = 0;
                resSrc = 0;
                branch = 0;
                aluOp = 2'b10;
            end
            7'b1100011: begin // beq (branch if equal)
                regWrite = 0;
                immSrc = 2'b10;
                aluSrc = 0;
                memWrite = 0;
                resSrc = 0; // X en la tabla, pero no es relevante aca
                branch = 1;
                aluOp = 2'b01;
            end
            default: begin
                // En caso de opcode desconocido, todas las señales se mantienen en 0
                branch = 0;
                resSrc = 0;
                memWrite = 0;
                aluSrc = 0;
                regWrite = 0;
                immSrc = 2'b00;
                aluOp = 2'b00;
            end
        endcase
    end

endmodule

/*
Decodificador principal:
Unidad que decodifica el tipo de instruccion
para generar el camino de datos
*/
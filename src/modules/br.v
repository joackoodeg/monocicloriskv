module BR #(parameter N = 32) (
    input clk,
    input [4:0] a1, a2, a3,
    input [N-1:0] wd3,
    input we,
    output [N-1:0] rd1, rd2,
    output [N-1:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31
);

    reg [N-1:0] regFile [0:31]; // 32 registers of N bits each
    integer i; // Declare iterator outside procedural block

    // Initialize all registers to 0
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            regFile[i] = {N{1'b0}};
        end
    end
    assign rd1 = regFile[a1];
    assign rd2 = regFile[a2];

    // Asignar los registros a las salidas observables
    assign reg0 = regFile[0];
    assign reg1 = regFile[1];
    assign reg2 = regFile[2];
    assign reg3 = regFile[3];
    assign reg4 = regFile[4];
    assign reg5 = regFile[5];
    assign reg6 = regFile[6];
    assign reg7 = regFile[7];
    assign reg8 = regFile[8];
    assign reg9 = regFile[9];
    assign reg10 = regFile[10];
    assign reg11 = regFile[11];
    assign reg12 = regFile[12];
    assign reg13 = regFile[13];
    assign reg14 = regFile[14];
    assign reg15 = regFile[15];
    assign reg16 = regFile[16];
    assign reg17 = regFile[17];
    assign reg18 = regFile[18];
    assign reg19 = regFile[19];
    assign reg20 = regFile[20];
    assign reg21 = regFile[21];
    assign reg22 = regFile[22];
    assign reg23 = regFile[23];
    assign reg24 = regFile[24];
    assign reg25 = regFile[25];
    assign reg26 = regFile[26];
    assign reg27 = regFile[27];
    assign reg28 = regFile[28];
    assign reg29 = regFile[29];
    assign reg30 = regFile[30];
    assign reg31 = regFile[31];

    always @(posedge clk) begin
        if (we) begin
            regFile[a3] <= wd3;
        end
    end
endmodule
/*
module BR #(parameter N = 32) (
    input clk,
    input [4:0] a1, a2, a3,
    input [N-1:0] wd3,
    input we,
    output [N-1:0] rd1, rd2
);
//Posiblemente: inicializar en 0 regFile
    reg [N-1:0] regFile [31:0]; // 32 registros de 32 bits

    assign rd1 = regFile[a1];
    assign rd2 = regFile[a2];

    always @(posedge clk) begin
        if (we) begin
            regFile[a3] <= wd3;
        end
    end
endmodule
*/

/*
Banco de registros: El banco de registro contiene todos los registros y tiene dos
puertos de lectura y uno de escritura. El banco genera el contenido de los registros
correspondientes a la entradas de lectura (A1, A2) en las salidas (RD1, RD2). Una
escritura debe indicarse explícitamente mediante la señal de control de escritura.

Como las escrituras se activan por flancos, se puede leer y escribir el mismo registro
dentro de un ciclo de reloj: la lectura obtendrá el valor escrito en el
ciclo anterior, mientras que el valor escrito estará disponible para
una lectura en el ciclo posterior.

Las entradas que seleccionan los registros (A1, A2 y A3) tienen 5 bits de ancho,
mientras que las líneas que llevan los datos (RD1, RD2 y WD3) tienen 32 bits de ancho.
*/
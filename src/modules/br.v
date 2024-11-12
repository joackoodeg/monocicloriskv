module BR #(parameter N = 32) (
    input clk,
    input [4:0] a1, a2, a3,
    input [N-1:0] wd3,
    input we,
    output [N-1:0] rd1, rd2
);
    reg [N-1:0] regFile [31:0]; // 32 registros de 32 bits

    assign rd1 = regFile[a1];
    assign rd2 = regFile[a2];

    always @(posedge clk) begin
        if (we) begin
            regFile[a3] <= wd3;
        end
    end
endmodule

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
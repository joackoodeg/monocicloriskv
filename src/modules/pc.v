module PC #(parameter N = 32) (
    input clk,
    input [N-1:0] pcNext,
    output reg [N-1:0] pc
);
    always @(posedge clk) begin
        pc <= pcNext;
    end
endmodule

/*
Contador de programa: es un registro de 32 bits que guarda la dirección de la
instrucción que se está ejecutando.
Sus entradas son la dirección de la próxima instrucción a ejecutar (PC`) y el
reloj del sistema (CLK), que indica cuando actualizar la salida; mientras que la
salida es la dirección de la instrucción que se ejecuta (PC).
*/
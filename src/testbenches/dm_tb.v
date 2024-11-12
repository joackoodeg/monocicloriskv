`include "../src/modules/dm.v"

module tb_DM;
    reg clk;
    reg [4:0] addressDM;
    reg [31:0] wd;
    reg we;
    wire [31:0] rd;

    DM uut (
        .clk(clk),
        .addressDM(addressDM),
        .wd(wd),
        .we(we),
        .rd(rd)
    );

    initial begin
        clk = 0;
        we = 0;
        addressDM = 5'd0;
        wd = 32'h00000000;
        #10 we = 1; addressDM = 5'd0; wd = 32'hA5A5A5A5;
        #10 we = 0; addressDM = 5'd0; // Leer la dirección 0
        #10 $stop;
    end

    always #5 clk = ~clk;
endmodule

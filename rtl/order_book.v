module order_book(
    input wire clk,
    input wire rst,
    input wire valid,
    input wire side,

    input wire [31:0] price,
    input wire [31:0] quantity,
    
    output reg [31:0] best_bid,
    output reg [31:0] best_ask,
    output reg [31:0] spread
);
always @(posedge clk) begin

        if (rst) begin
            best_bid <= 0;
            best_ask <= 0;
            spread   <= 0;
        end

    end

endmodule

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
        else if (valid) begin

    // BUY order
        if (side == 0) begin

            if (price > best_bid) begin
                best_bid <= price;
            end

        end

    // SELL order
        else begin

            if (best_ask == 0 || price < best_ask) begin
                best_ask <= price;
            end

        end

    end

end

endmodule

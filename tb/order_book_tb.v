`timescale 1ns/1ps

module order_book_tb;

    reg clk;
    reg rst;
    reg valid;
    reg side;

    reg [31:0] price;
    reg [31:0] quantity;

    wire [31:0] best_bid;
    wire [31:0] best_ask;
    wire [31:0] spread;

    order_book dut (
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .side(side),
        .price(price),
        .quantity(quantity),
        .best_bid(best_bid),
        .best_ask(best_ask),
        .spread(spread)
    );

    // Clock: 100 MHz
    initial begin
        clk = 0;
    end

    always #5 clk = ~clk;

    // Waveform
    initial begin
        $dumpfile("sim/order_book.vcd");
        $dumpvars(0, order_book_tb);
    end

    // Test
    initial begin

    rst      = 1;
    valid    = 0;
    side     = 0;
    price    = 0;
    quantity = 0;

    // Reset
    #20;
    rst = 0;

    // --------------------------------
    // BUY 100 x 50
    // --------------------------------
    valid    = 1;
    side     = 0;
    price    = 100;
    quantity = 50;

    #10;
    valid = 0;

    // --------------------------------
    // SELL 105 x 30
    // --------------------------------
    #10;
    valid    = 1;
    side     = 1;
    price    = 105;
    quantity = 30;

    #10;
    valid = 0;

    #20;

    $finish;

end
endmodule
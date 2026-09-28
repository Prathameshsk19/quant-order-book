`timescale 1ns/1ps

module order_book_v7_tb;

    reg clk;
    reg rst;
    reg valid;
    reg side;

    reg [31:0] price;
    reg [31:0] quantity;

    wire [31:0] best_bid;
    wire [31:0] best_bid_qty;
    wire [31:0] best_ask;
    wire [31:0] best_ask_qty;
    wire [31:0] spread;

    wire        trade_valid;
    wire [31:0] trade_price;
    wire [31:0] trade_qty;

    // DUT
    order_book dut (
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .side(side),
        .price(price),
        .quantity(quantity),

        .best_bid(best_bid),
        .best_bid_qty(best_bid_qty),

        .best_ask(best_ask),
        .best_ask_qty(best_ask_qty),

        .spread(spread),

        .trade_valid(trade_valid),
        .trade_price(trade_price),
        .trade_qty(trade_qty)
    );

    // 10 ns clock
    always #5 clk = ~clk;

    initial begin

        $dumpfile("sim/order_book_v7.vcd");
        $dumpvars(0, order_book_v7_tb);

        clk      = 0;
        rst      = 1;
        valid    = 0;
        side     = 0;
        price    = 0;
        quantity = 0;

        // -----------------------------
        // RESET
        // -----------------------------

        #20;
        rst = 0;

        // -----------------------------
        // Build ASK
        // SELL 105 x 20
        // -----------------------------

        @(negedge clk);
        valid    = 1;
        side     = 1;
        price    = 105;
        quantity = 20;

        @(negedge clk);
        valid = 0;

        // -----------------------------
        // BUY 105 x 8
        // Should match 8
        // Remaining ASK = 12
        // -----------------------------

        @(negedge clk);
        valid    = 1;
        side     = 0;
        price    = 105;
        quantity = 8;

        @(negedge clk);
        valid = 0;

        // -----------------------------
        // BUY 105 x 12
        // Should match remaining 12
        // ASK level disappears
        // -----------------------------

        @(negedge clk);
        valid    = 1;
        side     = 0;
        price    = 105;
        quantity = 12;

        @(negedge clk);
        valid = 0;

        // -----------------------------
        // Build BID
        // BUY 100 x 40
        // -----------------------------

        @(negedge clk);
        valid    = 1;
        side     = 0;
        price    = 100;
        quantity = 40;

        @(negedge clk);
        valid = 0;

        // -----------------------------
        // SELL 100 x 15
        // Should match 15
        // Remaining BID = 25
        // -----------------------------

        @(negedge clk);
        valid    = 1;
        side     = 1;
        price    = 100;
        quantity = 15;

        @(negedge clk);
        valid = 0;

        // -----------------------------
        // PARTIAL FILL
        //
        // Existing BID = 100 x 25
        //
        // SELL 99 x 50
        //
        // 25 executes
        // Remaining 25 becomes ASK at 99
        // -----------------------------

        @(negedge clk);
        valid    = 1;
        side     = 1;
        price    = 99;
        quantity = 50;

        @(negedge clk);
        valid = 0;

        #20;

        $finish;

    end

endmodule
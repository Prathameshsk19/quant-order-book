module order_book(
    input wire clk,
    input wire rst,
    input wire valid,
    input wire side,

    input wire [31:0] price,
    input wire [31:0] quantity,

    output reg [31:0] best_bid,
    output reg [31:0] best_bid_qty,

    output reg [31:0] best_ask,
    output reg [31:0] best_ask_qty,

    output reg [31:0] spread
);

    // ----------------------------------------
    // 4 price levels per side
    // ----------------------------------------

    reg [31:0] bid_price [0:3];
    reg [31:0] bid_qty   [0:3];

    reg [31:0] ask_price [0:3];
    reg [31:0] ask_qty   [0:3];

    integer i;

    // ----------------------------------------
    // Order insertion / quantity aggregation
    // ----------------------------------------

    always @(posedge clk) begin

        if (rst) begin

            for (i = 0; i < 4; i = i + 1) begin
                bid_price[i] <= 0;
                bid_qty[i]   <= 0;

                ask_price[i] <= 0;
                ask_qty[i]   <= 0;
            end

        end

        else if (valid) begin

            // =================================
            // BUY
            // =================================
            if (side == 0) begin

                // Same price level?
                if (bid_price[0] == price)
                    bid_qty[0] <= bid_qty[0] + quantity;

                else if (bid_price[1] == price)
                    bid_qty[1] <= bid_qty[1] + quantity;

                else if (bid_price[2] == price)
                    bid_qty[2] <= bid_qty[2] + quantity;

                else if (bid_price[3] == price)
                    bid_qty[3] <= bid_qty[3] + quantity;

                // Otherwise find empty slot
                else if (bid_price[0] == 0) begin
                    bid_price[0] <= price;
                    bid_qty[0]   <= quantity;
                end

                else if (bid_price[1] == 0) begin
                    bid_price[1] <= price;
                    bid_qty[1]   <= quantity;
                end

                else if (bid_price[2] == 0) begin
                    bid_price[2] <= price;
                    bid_qty[2]   <= quantity;
                end

                else if (bid_price[3] == 0) begin
                    bid_price[3] <= price;
                    bid_qty[3]   <= quantity;
                end

            end

            // =================================
            // SELL
            // =================================
            else begin

                // Same price level?
                if (ask_price[0] == price)
                    ask_qty[0] <= ask_qty[0] + quantity;

                else if (ask_price[1] == price)
                    ask_qty[1] <= ask_qty[1] + quantity;

                else if (ask_price[2] == price)
                    ask_qty[2] <= ask_qty[2] + quantity;

                else if (ask_price[3] == price)
                    ask_qty[3] <= ask_qty[3] + quantity;

                // Otherwise find empty slot
                else if (ask_price[0] == 0) begin
                    ask_price[0] <= price;
                    ask_qty[0]   <= quantity;
                end

                else if (ask_price[1] == 0) begin
                    ask_price[1] <= price;
                    ask_qty[1]   <= quantity;
                end

                else if (ask_price[2] == 0) begin
                    ask_price[2] <= price;
                    ask_qty[2]   <= quantity;
                end

                else if (ask_price[3] == 0) begin
                    ask_price[3] <= price;
                    ask_qty[3]   <= quantity;
                end

            end

        end

    end


    // ----------------------------------------
    // Find best bid / best ask
    // ----------------------------------------

    integer j;

    reg [31:0] temp_best_bid;
    reg [31:0] temp_best_bid_qty;

    reg [31:0] temp_best_ask;
    reg [31:0] temp_best_ask_qty;

    always @(*) begin

        // Defaults
        temp_best_bid     = 0;
        temp_best_bid_qty = 0;

        temp_best_ask     = 0;
        temp_best_ask_qty = 0;

        // ------------------------------------
        // Find highest BUY price
        // ------------------------------------

        for (j = 0; j < 4; j = j + 1) begin

            if (bid_price[j] > temp_best_bid) begin
                temp_best_bid     = bid_price[j];
                temp_best_bid_qty = bid_qty[j];
            end

        end

        // ------------------------------------
        // Find lowest SELL price
        // ------------------------------------

        for (j = 0; j < 4; j = j + 1) begin

            if (ask_price[j] != 0) begin

                if ((temp_best_ask == 0) ||
                    (ask_price[j] < temp_best_ask)) begin

                    temp_best_ask     = ask_price[j];
                    temp_best_ask_qty = ask_qty[j];

                end

            end

        end

        best_bid     = temp_best_bid;
        best_bid_qty = temp_best_bid_qty;

        best_ask     = temp_best_ask;
        best_ask_qty = temp_best_ask_qty;

        // ------------------------------------
        // Spread
        // ------------------------------------

        if ((best_bid != 0) && (best_ask != 0))
            spread = best_ask - best_bid;
        else
            spread = 0;

    end

endmodule
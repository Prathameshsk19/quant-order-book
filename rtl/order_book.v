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

    output reg [31:0] spread,

    // V7 trade outputs
    output reg        trade_valid,
    output reg [31:0] trade_price,
    output reg [31:0] trade_qty
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
    // Best-price information
    // ----------------------------------------

    integer j;

    reg [31:0] temp_best_bid;
    reg [31:0] temp_best_bid_qty;

    reg [31:0] temp_best_ask;
    reg [31:0] temp_best_ask_qty;

    integer best_ask_index;

    // ----------------------------------------
    // Order processing
    // ----------------------------------------

    always @(posedge clk) begin

        if (rst) begin

            // Clear order book
            for (i = 0; i < 4; i = i + 1) begin

                bid_price[i] <= 0;
                bid_qty[i]   <= 0;

                ask_price[i] <= 0;
                ask_qty[i]   <= 0;

            end

            // Clear trade outputs
            trade_valid <= 0;
            trade_price <= 0;
            trade_qty   <= 0;

        end

        else begin

            // Trade outputs are normally inactive
            trade_valid <= 0;
            trade_price <= 0;
            trade_qty   <= 0;

            if (valid && (quantity != 0)) begin

                // ========================================
                // BUY ORDER
                // ========================================

                if (side == 0) begin

                    // ------------------------------------
                    // Does BUY cross the best ASK?
                    // ------------------------------------

                    if ((best_ask != 0) &&
                        (price >= best_ask)) begin

                        // Trade occurs
                        trade_valid <= 1;
                        trade_price <= best_ask;

                        // --------------------------------
                        // BUY smaller than ASK
                        // --------------------------------

                        if (quantity < best_ask_qty) begin

                            trade_qty <= quantity;

                            ask_qty[best_ask_index] <=
                                best_ask_qty - quantity;

                        end

                        // --------------------------------
                        // BUY completely consumes ASK
                        // --------------------------------

                        else begin

                            trade_qty <= best_ask_qty;

                            ask_price[best_ask_index] <= 0;
                            ask_qty[best_ask_index]   <= 0;

                        end

                    end

                    // ------------------------------------
                    // BUY does NOT cross ASK
                    // Add to BID book
                    // ------------------------------------

                    else begin

                        // Existing price level
                        if (bid_price[0] == price)
                            bid_qty[0] <= bid_qty[0] + quantity;

                        else if (bid_price[1] == price)
                            bid_qty[1] <= bid_qty[1] + quantity;

                        else if (bid_price[2] == price)
                            bid_qty[2] <= bid_qty[2] + quantity;

                        else if (bid_price[3] == price)
                            bid_qty[3] <= bid_qty[3] + quantity;

                        // Empty price level
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

                end

                // ========================================
                // SELL ORDER
                // ========================================

                else begin

                    // ------------------------------------
                    // SELL does not match yet
                    //
                    // For now, V7 only implements
                    // BUY -> ASK matching.
                    // SELL continues to enter ASK book.
                    // ------------------------------------

                    // Existing price level
                    if (ask_price[0] == price)
                        ask_qty[0] <= ask_qty[0] + quantity;

                    else if (ask_price[1] == price)
                        ask_qty[1] <= ask_qty[1] + quantity;

                    else if (ask_price[2] == price)
                        ask_qty[2] <= ask_qty[2] + quantity;

                    else if (ask_price[3] == price)
                        ask_qty[3] <= ask_qty[3] + quantity;

                    // Empty price level
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

    end


    // ----------------------------------------
    // Find best bid / best ask
    // ----------------------------------------

    always @(*) begin

        // Defaults
        temp_best_bid     = 0;
        temp_best_bid_qty = 0;

        temp_best_ask     = 0;
        temp_best_ask_qty = 0;

        best_ask_index    = -1;

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

                    // Remember which array entry
                    // contains the best ASK
                    best_ask_index = j;

                end

            end

        end

        // ------------------------------------
        // Output best bid
        // ------------------------------------

        best_bid     = temp_best_bid;
        best_bid_qty = temp_best_bid_qty;

        // ------------------------------------
        // Output best ask
        // ------------------------------------

        best_ask     = temp_best_ask;
        best_ask_qty = temp_best_ask_qty;

        // ------------------------------------
        // Spread
        // ------------------------------------

        if ((best_bid != 0) &&
            (best_ask != 0)) begin

            spread = best_ask - best_bid;

        end

        else begin

            spread = 0;

        end

    end

endmodule
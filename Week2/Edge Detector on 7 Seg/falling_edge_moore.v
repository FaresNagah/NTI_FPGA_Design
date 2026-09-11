module falling_edge_moore (
    input  wire clk, rst_n,trig,
    output wire pulse
);
    localparam ZERO = 2'b00,
               ONE  = 2'b01,
               EDG  = 2'b10;

    reg [1:0] state, next_state;

    always @(posedge clk or posedge rst_n) begin
        if (!rst_n)
            state <= ZERO;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            ZERO:    next_state = trig  ? ONE  : ZERO;
            ONE:     next_state = !trig ? EDG  : ONE;
            EDG:     next_state = trig  ? ONE  : ZERO;
            default: next_state = ZERO;
        endcase
    end

    assign pulse = (state == EDG);

endmodule
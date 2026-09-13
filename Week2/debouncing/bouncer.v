module bouncer #(
    parameter CLK_FREQ_HZ = 50_000_000, 
    parameter TICK_PERIOD_NS = 100      
)(
    input  wire clk,rst_n,sw,
    output reg  db
);
    localparam TICKS_COUNT = 5;
    localparam CNT_WIDTH   = 3; 
    reg [2:0] state_reg, state_next;
    reg sw_meta, sw_sync;
    reg [CNT_WIDTH-1:0] q_reg;
    wire m_tick;


      localparam [2:0] 
        ZERO    = 3'b000,
        WAIT1_1 = 3'b001,
        WAIT1_2 = 3'b010,
        WAIT1_3 = 3'b011,
        ONE     = 3'b100,
        WAIT0_1 = 3'b101,
        WAIT0_2 = 3'b110,
        WAIT0_3 = 3'b111;



    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q_reg <= {CNT_WIDTH{1'b0}};
        else if (q_reg == TICKS_COUNT - 1)
            q_reg <= {CNT_WIDTH{1'b0}};
        else
            q_reg <= q_reg + 1'b1;
    end

    assign m_tick = (q_reg == TICKS_COUNT - 1);

  
  
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sw_meta <= 1'b0;
            sw_sync <= 1'b0;
        end else begin
            sw_meta <= sw;
            sw_sync <= sw_meta;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state_reg <= ZERO;
        else
            state_reg <= state_next;
    end

    always @(*) begin
        state_next = state_reg;
        db = 1'b0;

        case (state_reg)
            ZERO: begin
                db = 1'b0;
                if (sw_sync)
                    state_next = WAIT1_1;
            end

            WAIT1_1: begin
                db = 1'b0;
                if (!sw_sync)
                    state_next = ZERO;
                else if (m_tick)
                    state_next = WAIT1_2;
            end

            WAIT1_2: begin
                db = 1'b0;
                if (!sw_sync)
                    state_next = ZERO;
                else if (m_tick)
                    state_next = WAIT1_3;
            end

            WAIT1_3: begin
                db = 1'b0;
                if (!sw_sync)
                    state_next = ZERO;
                else if (m_tick)
                    state_next = ONE;
            end

            ONE: begin
                db = 1'b1;
                if (!sw_sync)
                    state_next = WAIT0_1;
            end

            WAIT0_1: begin
                db = 1'b1;
                if (sw_sync)
                    state_next = ONE;
                else if (m_tick)
                    state_next = WAIT0_2;
            end

            WAIT0_2: begin
                db = 1'b1;
                if (sw_sync)
                    state_next = ONE;
                else if (m_tick)
                    state_next = WAIT0_3;
            end

            WAIT0_3: begin
                db = 1'b1;
                if (sw_sync)
                    state_next = ONE;
                else if (m_tick)
                    state_next = ZERO;
            end

            default: state_next = ZERO;
        endcase
    end

endmodule
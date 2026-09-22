// Memory node with destination parameter to route response packets to Port 3 (Testbench)
module ram_network_node_fixed #(
    parameter DATA_WIDTH = 24,
    parameter ADDR_WIDTH = 5,
    parameter RAM_DEPTH  = 32,
    parameter [1:0] RESP_DEST = 2'b11 // Destination for read response packets
) (
    input clk, rst_n, rx_valid,
    input [DATA_WIDTH-1:0] rx_data,
    input fifo_full,
    output reg rx_ready,      
    output reg  [DATA_WIDTH-1:0] tx_data,      
    output reg tx_wr_en
);
    reg [15:0] mem [0:RAM_DEPTH-1];

    localparam [1:0] S_IDLE      = 2'b00,
                     S_SEND_RESP = 2'b01,
                     S_DONE      = 2'b10;

    reg [1:0] state;
    reg [ADDR_WIDTH-1:0] saved_addr;
    reg [15:0] saved_data;

    wire       pkt_rw   = rx_data[21];
    wire [ADDR_WIDTH-1:0] pkt_addr = rx_data[20:16];
    wire [15:0] pkt_data = rx_data[15:0];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state      <= S_IDLE;
            rx_ready   <= 1'b1;
            tx_wr_en   <= 1'b0;
            tx_data    <= {DATA_WIDTH{1'b0}};
            saved_addr <= {ADDR_WIDTH{1'b0}};
            saved_data <= 16'h0000;
        end else begin
            case (state)
                S_IDLE: begin
                    tx_wr_en <= 1'b0;
                    rx_ready <= 1'b1;
                    if (rx_valid && rx_ready) begin
                        if (pkt_rw == 1'b1) begin
                            mem[pkt_addr] <= pkt_data;
                        end else begin
                            saved_addr <= pkt_addr;
                            saved_data <= mem[pkt_addr];
                            rx_ready   <= 1'b0;
                            state      <= S_SEND_RESP;
                        end
                    end
                end

                S_SEND_RESP: begin
                    if (!fifo_full) begin

                        tx_data  <= {RESP_DEST, 1'b0, saved_addr, saved_data};
                        tx_wr_en <= 1'b1;
                        state    <= S_DONE;
                    end else begin
                        tx_wr_en <= 1'b0;
                    end
                end

                S_DONE: begin
                    tx_wr_en <= 1'b0;
                    rx_ready <= 1'b1;
                    state    <= S_IDLE;
                end

                default: state <= S_IDLE;
            endcase
        end
    end
endmodule